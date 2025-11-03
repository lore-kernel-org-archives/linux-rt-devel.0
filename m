Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35452FD671
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Nov 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762164952; cv=none; b=jimVGmTAZnwbEoxAl24AxrAUgIsJj4owqOFi5Z4td5GcgSdeoXSp4C9/l6qO1z7bPixAoEkY2Bv+ed/481Ewmh+hjYt/xIEiWEdK4ZTVjMF1+1O612QEnfPGgpJ/CdBxxWKBLiWEVpg2+61xo6BH4ov+E8/adaxBd+D5kWX+TDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762164952; c=relaxed/simple;
	bh=YrO1cJ6zT0UFl0cZu61hQp+9rZYmZxLFv1R9/qGz2wI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ni5OlM8EtTg/FLESgslzFGqJ+49462tfP8dFJqPf6zk4pdwhLYFfjInWy5HXfHiz8cNqfT1zt7gXrxfduGzm3YNnjzKLsCav63felCAXZuJeO6TjIKJx7Bqh5iK9qRzqAl9B8szgGfFLCEapcsB5Yi+xaB5mhJWiv0G5wyQSZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P/xdus4/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dz5c0xgq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P/xdus4/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dz5c0xgq"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762164948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFX45+cde+E+pSrfN0TxYhQqVRuFdBuKHSweNWzETGA=;
	b=P/xdus4/7qcgvfM4Fk4EfF8ai2r+6XMxs9/cUZxEtOvKl5HuKwo1DHZYrbmh1MTAC8kT5s
	kJ3aTvJs4XLXz7ITcBUEHO22eJE2EaTY7a4VbUBY4ELbAIt9vKBvXA92E+hzJQSfBrTzpf
	sLipkKHMUdm2+tQzInRi+BfDBC8QUKfgo67JXF2+sI/XIQLuOnZ2GX3oVk1zbLKaNeYvJY
	FLIfkN6S63DhVPDf8v7GiVFgPeF9figkmbOiL7Dl3R6CjKyWAPC+IZXi7DFIwIMqXhk6xf
	fujqVD2zIXJOx6d5xDpBKjdkT8AxaVpz3hMTJIC9/pY2PJFPbNDKjprZCw8mmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762164948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KFX45+cde+E+pSrfN0TxYhQqVRuFdBuKHSweNWzETGA=;
	b=Dz5c0xgqMUiTCoGpvyB3G3phhltXO2frv8t2mNktqGe3N9DeWlw5XTTwbijtk+qEgpyCXY
	JZ0yAwo8Es847PAg==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/5] ARM: Disable jump-label on PREEMPT_RT
Date: Mon,  3 Nov 2025 11:15:43 +0100
Message-ID: <20251103101545.760243-4-bigeasy@linutronix.de>
In-Reply-To: <20251103101545.760243-1-bigeasy@linutronix.de>
References: <20251103101545.760243-1-bigeasy@linutronix.de>
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

On 64-bit Arm, it is possible to use jump labels without the
stop_machine() call, which architecturally provides a way to atomically
change one 32-bit instruction word while keeping maintaining consistency,
but this is not generally the case on 32-bit, in particular in thumb2
mode.

Disable jump-label support on a PREEMPT_RT system when SMP is enabled.

[bigeasy: Patch description.]
[arnd: add !SMP case, extend changelog]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2e3f93b690f47..92ca24336ec4b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -80,7 +80,7 @@ config ARM
 	select HAS_IOPORT
 	select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
 	select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
-	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
+	select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU && =
(!PREEMPT_RT || !SMP)
 	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
--=20
2.51.0

