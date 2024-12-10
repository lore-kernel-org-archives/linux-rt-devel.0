Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2787523DEBB;
	Tue, 10 Dec 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846803; cv=none; b=Lsp3VzMgJHwHgj2c7dW/Fo9G0ZiGE1Hk+H+Avc65E2TXrjGcLqu1iASRsu6EgtWgZjz1Jk7MuZ4Wmded6iu8MNFYdkv2pwDpNZbuqY7M7n/VbH3ll7UYxqz6NfMXi++9nVgYz1kOKaTubaX+8VeqKMTtG99/fQ3ScPuRrBs6px8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846803; c=relaxed/simple;
	bh=nhIKrOVHXT3fUCBw4LPHGsOsiy5FD8A3uloS3DV+YHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FjbBPHLLUjtykXNIeXb/xEy99mNRE6FD7Re0UuaeqOmnekFcSJ4Qxi8RhpOPvokEMnpHwWEs4NphtULHe1D1JO2G/5oR8jvXdJ6hl5ifxpxiv8cCCt1nRu3zY7R6L7euOhyc8rE+SJdnF6aQAcIsQWqG5WaVRwmd3IgWK9bALF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8ZZHIvS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8ZZHIvS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C9CC4CEE8;
	Tue, 10 Dec 2024 16:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733846802;
	bh=nhIKrOVHXT3fUCBw4LPHGsOsiy5FD8A3uloS3DV+YHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8ZZHIvSDkAlRtjuBdPZfIY3aU5cCBpzyB/i2Vv0HHj1O6+BciyVjba8Qkih/H+oH
	 8TtDjHvi5iAR5MM0ElcShiTGwZql1i32Y6428E+38PRhzgRtAWTKpfhzHJiPn84smK
	 HJWY3mo1jKE1QGYdAFfrLrczgT25PXzoZxXyZngcTAjKXWCDBA2CPN3ZHKobWSi6Kp
	 YPEzJWTJOIMs4W0CAIhrvEGezqOkDjf872n/KtyP4lCYe2TAn2G5E3eIEtTgkMqO5y
	 6R94PbszNkqgUUmIxY+fUeVVOLgne6LUFDtXRCNteNin/BkIZD+yk9ibqhphxRJ7mU
	 pxz1jz8DVVEoQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 1/4] ARM: Disable jump-label on PREEMPT_RT
Date: Tue, 10 Dec 2024 17:05:53 +0100
Message-Id: <20241210160556.2341497-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210160556.2341497-1-arnd@kernel.org>
References: <20241210160556.2341497-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

jump-labels are used to efficiently switch between two possible code
paths. To achieve this, stop_machine() is used to keep the CPU in a
known state while the opcode is modified. The usage of stop_machine()
here leads to large latency spikes which can be observed on PREEMPT_RT.

Jump labels may change the target during runtime and are not restricted
to debug or "configuration/ setup" part of a PREEMPT_RT system where
high latencies could be defined as acceptable.

On 64-bit Arm, it is possible to use jump labels without the
stop_machine() call, which architecturally provides a way to atomically
change one 32-bit instruction word while keeping maintaining consistency,
but this is not generally the case on 32-bit, in particular in thumb2
mode.

Disable jump-label support on a PREEMPT_RT system when SMP is enabled.

[bigeasy: Patch description.]
[arnd: add !SMP case, extend changelog]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20220613182447.112191-2-bigeasy@linutronix.de
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I slightly changed the patch from the version currently in linux-rt.git
to leave jump labels enabled on single-CPU kernels that are still
fairly common on 32-bit arm.

If there are no additional concerns about this version, I will
forward it to Russell's patch system
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index fb4e1da3bb98..ed850cc0ed3c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -80,7 +80,7 @@ config ARM
 	select HAS_IOPORT if PCI || PCMCIA || ISA || ARCH_FOOTBRIDGE || ARCH_RPC
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
-	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
+	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU && (!PREEMPT_RT || !SMP)
 	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
-- 
2.39.5

