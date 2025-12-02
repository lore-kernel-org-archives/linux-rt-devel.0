Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA27E12F5A5
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Dec 2025 14:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685101; cv=none; b=T+mOn5w/vxMDDF9XsTmeWdGIydkMRASNbsz15wDUe2IgGPT3z5c/GuncoCrd7acEEue9inTV2NADp6IBpfrhKnVWSr2BXsisOX5NAK2F6yIf1+q5s0I/InfxsoR1rkqQfCZJOUskMCUaGRrO+yMLnkxEPrDXML+ifJS9FcRf0Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685101; c=relaxed/simple;
	bh=6TNigRVcbfg9qLcebJ1ML5NfpOow2r7nW3+derYAFA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsEW/I5dWAPXja6kRZOnJAaaOKFz76aEfP+l96L4RR3MHv2RiqTs2/jX9dxOuVcX/w6sTrzet6W6nziznY/MjmsFWPU4Jy+c2Qws1YjS/1HZfLp4Js+YmwnnJe/WuUj8RQ7jlM/iVqU9JrBapDNkAgfgbcYhOBxIJZY1ln6d7+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ej1/maXk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=itBlWujI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ej1/maXk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="itBlWujI"
Date: Tue, 2 Dec 2025 15:18:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764685097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DqWhd7pgLu3TuaNPiJjtSv9NJ0oz7uW4FlhXV6xN5Rs=;
	b=Ej1/maXk1+OVOKSqGfGnIKB2lCd51saxgMtGGH4yetKbvQGaRAyAQ7AONQqd7Abqt5gT0p
	nplBYemfht2enMcDbHaiz73l3hQRxlkZxfwgC+OO6V/UpG2pIDr4yaPnikGFtPQsvRYb39
	aniWaTXZAPynxtvIinWsZ4zjfxidYB0ZdkEV7Y3X6XQlCOlPq/0dHfAAauktKXcNzP0JA0
	3VT6zipY1gW4qO6L4D37px3jNHVSIWpR/hAGsuFgGjVsk87nb9vKN2YS5rdTXO0oHcV895
	dXfMZgCwpsOIjJajhhJBC79hGxdJD25mrYnFuJuNPKC+MdEACJ+s+47tH3Tz5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764685097;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DqWhd7pgLu3TuaNPiJjtSv9NJ0oz7uW4FlhXV6xN5Rs=;
	b=itBlWujI2YRSHbmdJFL3jsgZvkv/LDqYUy63ulGGFJJBuQjBgtB9XxEBLrFSYMdlAoC8N4
	yY9mL6J2Nkv+mmDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Xie Yuanbin <xieyuanbin1@huawei.com>, Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Yadi.hu" <yadi.hu@windriver.com>
Subject: Re: [PATCH v3 2/5] ARM: mm: fault: Enable interrupts before invoking
 __do_user_fault()
Message-ID: <20251202141816.wfHNUMFK@linutronix.de>
References: <20251110145555.2555055-1-bigeasy@linutronix.de>
 <20251110145555.2555055-3-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251110145555.2555055-3-bigeasy@linutronix.de>

On 2025-11-10 15:55:52 [+0100], To linux-arm-kernel@lists.infradead.org wrote:
|
|   https://www.armlinux.org.uk/developer/patches/viewpatch.php?id=9460/1
|
| Moved to Discarded.
|
| This makes the issues with the branch predictor hardening worse if this
| patch is merged on its own - since this adds another path where
| interrupts are enabled before calling harden_branch_predictor() in
| __do_user_fault(). It would be sensible to move the interrupt enable
| into __do_user_fault().
|
|    *** PLEASE DO NOT REPLY TO THIS MESSAGE ***

I thought that we apply both.
In 9462/1 I am moving harden_branch_predictor() out of __do_user_fault()
because do_page_fault() needs the hardening before the interrupts are
enabled. Do mean something like

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 2bc828a1940c0..f70b98fb562b3 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -186,6 +186,7 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 	if (addr > TASK_SIZE)
 		harden_branch_predictor();
 
+	local_irq_enable();
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
 	    ((user_debug & UDBG_BUS)  && (sig == SIGBUS))) {
@@ -274,8 +275,13 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 
 	/* Enable interrupts if they were enabled in the parent context. */
-	if (interrupts_enabled(regs))
+	if (interrupts_enabled(regs)) {
+		if (addr >= TASK_SIZE && user_mode(regs)) {
+			__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
+			return 0;
+		}
 		local_irq_enable();
+	}
 
 	/*
 	 * If we're in an interrupt or have no user

instead both patches? So now we end up in __do_user_fault() via
do_page_fault() with enabled interrupts but only for addr < TASK_SIZE
which does not involve harden_branch_predictor().

Sebastian
