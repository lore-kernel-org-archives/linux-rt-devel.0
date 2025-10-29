Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A31345CAF
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Oct 2025 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753576; cv=none; b=QUCqKj1MDNrbns9vyWbellcndX1f3ZM8sMLvsHBQBzpXojkHi+Jp7e7XSeF1zJ0Zc+zt/ZaKWffix3Lu662bTOBKsYmNeeGlTn4pcAkhkpQm1oBMmxPfSMMwez7LNvGduO+RAAYtLs5duHjpYxZrHhHsRuHszONcHPrZTro0f9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753576; c=relaxed/simple;
	bh=HxVwDhSf5zbFnFVzGMJ2HV17nFU6E65mSbN4A4+bb9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOKtRyQ47hhbZQCqIP+SEc9BxNN2w8tE/b04TFZQTLbccok1t+prtgvC08AkGdGqIQGZJTBAFcj4Bd6s15S5dq5rm7oadFtDhxakVMNXsdfcTwMEH6TnurZ+TRcbcFQl/nWuhZ5kjoCwv0oX7u4z4cPhZMhBlq21VfFh1lB1Hx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ivQpHH+V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QYj8Pu8G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ivQpHH+V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QYj8Pu8G"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761753573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LRztOyIqyrMC2Ez/HddfGnFygKmQq5glgGfhkLoOfQ=;
	b=ivQpHH+VIOhvSnzE7CppoebQT0ng8d7YgsQq/1Loyt9HP2+/Seva8N7nCmWY/jhZ35EPTq
	wp41zFNRq0fM6eCK4vf1d02yyOj0g7GVuhmCErVo5yn/TDiPT6ylutfKJswE7/cTkd3+Tb
	gTs8IT0EuIJiL8U97IFlrdB5sUHB+UaxsSeDxequ6YImPYEdGPj3wTRQuEFQO8RHBmGHyn
	kWZKiWWu7I1kbSl+4z47fFmshEHJclvs7G6Rtmil5JixNpR2Zbo5cQhm1u5AIz53MOtDNJ
	pu+sSSjWAUy/PehvNiePyvU/xIIUVbpRziF+cGYIDSO8rM2gbxcsIAE09tAN4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761753573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LRztOyIqyrMC2Ez/HddfGnFygKmQq5glgGfhkLoOfQ=;
	b=QYj8Pu8G6ZnR6NLrw4eU1ghlBsZj+4QPiqi5Cn0QsnLjqF8lAdvHgsa/wJ5qgx+zXsGNEf
	XrPZlF9TErZgQZCA==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/5] ARM: Disable jump-label on PREEMPT_RT.
Date: Wed, 29 Oct 2025 16:59:17 +0100
Message-ID: <20251029155918.503060-5-bigeasy@linutronix.de>
In-Reply-To: <20251029155918.503060-1-bigeasy@linutronix.de>
References: <20251029155918.503060-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Thomas Gleixner <tglx@linutronix.de>

jump-labels are used to efficiently switch between two possible code
paths. To achieve this, stop_machine() is used to keep the CPU in a
known state while the opcode is modified. The usage of stop_machine()
here leads to large latency spikes which can be observed on PREEMPT_RT.

Jump labels may change the target during runtime and are not restricted
to debug or "configuration/ setup" part of a PREEMPT_RT system where
high latencies could be defined as acceptable.

Disable jump-label support on a PREEMPT_RT system.

[bigeasy: Patch description.]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 864a14a434b08..99c9b1c320af8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -80,7 +80,7 @@ config ARM
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
-	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
+	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU && =
!PREEMPT_RT
 	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
--=20
2.51.0

