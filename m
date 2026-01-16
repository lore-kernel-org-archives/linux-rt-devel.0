Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5975B342173
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 17:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582854; cv=none; b=J5O3hLY1I6gfVPwuFxLGsNo8fBCSyaBHxcLGchyKpe2rWoLOx1Y8k3z30SNlrQIaTY9yuX8P9zbpfjssb76DxO/DxA+LjxljwzIb+5LIOnGFrCe4FKRfwv35D0+yKphq8qdZxocXkUqZ4RZ8X7rg5w+Q+VO/FswPXImaQUhFMh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582854; c=relaxed/simple;
	bh=pq4QtovReuLq4GOCzaD73ZehWdmxfZRYDQIgZL3OE24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kY+HQbjjur/o4i2mV3LwVV89C8j9h7iHJToejwdMLOwzi8e7qgv7ugadpkXuCsCQOlOTirX6fc/snCGPuRa5rFRn7Wmm0v0V0i61MdvfCHeYgYo3/1e2qB6VAW6PDHYdJfLyhLJeOLhay2fHpeDR04MWAAKEI5EUK/lVxTs+GQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oWAoIzLi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zaK9Yr/c; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oWAoIzLi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zaK9Yr/c"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768582850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qeDaJWkLpO3qxUyIpo4/TvFhIlWEjGwXwi9nucOmHE=;
	b=oWAoIzLiZo+HJLUBQ016q/kj04m9mFa3MDfAdyfTHmouC8+xvZkaS3cStpxyxjRQ89nIx0
	fC9cP5Cjnyn0VO39duLOcPvEvsLICjEti1k9XFplXxs8/CRf6DByVQtexQJecO54S8L7sv
	2NH0fS9Cur2xP2eRPtDRrstAR119Yv3mxIWjmwlOuvzaCLSaKUaXHANeFdm/5fM/zjwSVL
	JdliFT91X/YXw1GBPFl5VNYmVO1GKTn09g98kanV9l3RrZZHE4dm3srvjITrId++A1n2mH
	W7BKdkj86OJcOcLp4Rb0v2WuhvZTeP8/QwgAEb4KxcORl9mMaRm824GaSb/Rhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768582850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2qeDaJWkLpO3qxUyIpo4/TvFhIlWEjGwXwi9nucOmHE=;
	b=zaK9Yr/cS0PgEIdnPWdrsyb/hlLZUFei+vojpVVvndgS42BnNNNJrWvD/8D1fuz/0D94bJ
	4lrPHsFv8uKD0OBA==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Yadi.hu" <yadi.hu@windriver.com>,
	Bryan Brattlof <bb@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 1/2] ARM: mm: fault: Enable interrupts before invoking __do_user_fault()
Date: Fri, 16 Jan 2026 18:00:40 +0100
Message-ID: <20260116170041.1059997-2-bigeasy@linutronix.de>
In-Reply-To: <20260116170041.1059997-1-bigeasy@linutronix.de>
References: <20260116170041.1059997-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Yadi.hu" <yadi.hu@windriver.com>

A page fault from userland for a kernel address originates from from
do_sect_fault() (!LPAE) or do_page_fault() and ends in __do_user_fault()
by sending a signal.

Sending a signal requires to acquire sighand_struct::siglock which is a
spinlock_t. On PREEMPT_RT spinlock_t becomes a sleeping spin lock which
requires interrupts to be enabled. Since the calling context is user
land, interrupts must have been enabled so it is fine to enable them in
this case.

Enable interrupts in do_kernel_address_page_fault() unconditional in the
user_mode case().
Enable interrupts in do_sect_fault() if they were previously enabled.

[bigeasy: Initial patch/ report by Yadi. Maintained the patch and redid
          the patch description since]

Signed-off-by: Yadi.hu <yadi.hu@windriver.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Bryan Brattlof <bb@ti.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/mm/fault.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ed4330cc3f4e6..3f1c73269c126 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -270,6 +270,7 @@ do_kernel_address_page_fault(struct mm_struct *mm, unsi=
gned long addr,
 		 * while interrupts are still disabled, then send a SIGSEGV.
 		 */
 		harden_branch_predictor();
+		local_irq_enable();
 		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
 	} else {
 		/*
@@ -592,6 +593,9 @@ do_sect_fault(unsigned long addr, unsigned int fsr, str=
uct pt_regs *regs)
 	if (addr >=3D TASK_SIZE && user_mode(regs))
 		harden_branch_predictor();
=20
+	if (interrupts_enabled(regs))
+		local_irq_enable();
+
 	do_bad_area(addr, fsr, regs);
=20
 	return 0;
--=20
2.51.0

