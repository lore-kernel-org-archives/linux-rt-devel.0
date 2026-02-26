Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E56364028
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 11:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104677; cv=none; b=PGCuj7VNY4JM8BCW8un7EiEeGGt2ix4YKO8u3BozjRVfOvY/PtGK/fhPczxHs8RLz/pdDoXRXxSWfkIktcg2HCY4SrAvfpGWNr6VYOpF1NbNeMDkefElxGlmc2de0uy40+L7rbr34vapczmlcU852z73HtoLF5RgAGQjmQsuasw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104677; c=relaxed/simple;
	bh=qedbynoY9oXOKjEIjhcibXGySNdM/+ZsNVxC/7csBVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H6weO9eyy4S9nXnFCHUCagLi9d/1EYAej7AKCtJjLfIpz0Zl8UU0UxroJS3xtaJO5ZjH8s6ZspoREfXOhacq7pLwJIR/N6pFUUfv9fOw9X8qLPT8jQC9MGUqA2EOYf7gUVHD47qS0dzQOiW8hmO+1VkTZdAc+mm6QmiVeNEVPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bCjSuYcn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IaaLHdq8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bCjSuYcn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IaaLHdq8"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772104672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbh1MpTYM6hT6+hxx5B3RT1R6a3HmEw4rZDwEZ7mk8M=;
	b=bCjSuYcn/+ZM1ceCTKV3Ga+muYNyIOwmEu9ixE9zpPGMUEP/WdYs84JikiNZYLiUV2xAeq
	2j+4RE1ANruUZdmFlWtuwmcfiM34D3iDZkYMYTWSuqDA6bUJ8wM4HIi6YzZWH+kOouvziL
	l0EOavi/LX+Q3peEu9++CpZxarC2PiNhy1Z/D8eWsLHslkxUYFivmz2np9EMMNRFxJU+n7
	19I29qKlEmXzEyNX/sg09nYWEpAQfyuYaxTfBcOVyqmbXuKipCzRSvIVRwrFZiqZ83XIq6
	AB4H1hoYPMDIdpaxbJpBPHN4ZVbUYAba132vqKWS+vUBdqIEsjpqQO9XXCz41g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772104672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbh1MpTYM6hT6+hxx5B3RT1R6a3HmEw4rZDwEZ7mk8M=;
	b=IaaLHdq8eaNC3lOvcLRaB9n0FA9t7MTAJqHT24znFXGfuhuv/vJsfIYoVqjET/stusudro
	LGInj8gai3OUITBw==
To: linux-arm-kernel@lists.infradead.org,
	linux-rt-devel@lists.linux.dev
Cc: Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Yadi.hu" <yadi.hu@windriver.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v5 1/2] ARM: mm: fault: Enable interrupts before invoking __do_user_fault()
Date: Thu, 26 Feb 2026 12:17:41 +0100
Message-ID: <20260226111742.3598421-2-bigeasy@linutronix.de>
In-Reply-To: <20260226111742.3598421-1-bigeasy@linutronix.de>
References: <20260226111742.3598421-1-bigeasy@linutronix.de>
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

