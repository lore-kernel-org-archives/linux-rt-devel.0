Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3842F3636
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837779; cv=none; b=EjBJYf1yE2mxwmYMQrwLeCOYp4cIsJu+umLLiNZm4ImIwUg48Kg3SlJiY5dmkopmMqwi1Kyy8vMRsraEaffMSCrV+NrPprg7NqnoRgGwaESdJkCq+lEGAVmuc3cqME20od1rBHUQddJ/GQfOdJfI2UeXtD++6P/eCsXI6Vi3dx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837779; c=relaxed/simple;
	bh=plGB9nAlvPQZyXBDQnLojxlkT1Mn0OiHQbZLEnIor1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJSfevBp7GmG61oofhoHscJ4DAVKVkSrU1rzFMvbApOjPXWx0KeCzYeHdUyPP1jshX6mc7Tk9leR+QBRW6MehV2/c6QYuMWBDrLqb5D6BH9oeIpTf5TYYQ1E1rTCXpbW5os0OlSAYKd76m9jGalS2mp4hReHxykAbuyJJTEPakY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4u4Ee2SR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9revQB1k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4u4Ee2SR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9revQB1k"
Date: Thu, 30 Oct 2025 16:22:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761837774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrxqbtZiBL/qfZS6zqxhKAA8G4C9IigNp34u5Qgc960=;
	b=4u4Ee2SRxSM7HfNqMDUNTMZ8zt80JhxIKS6wJUR43zONguQuYeob9FcovaBra1EYtsd0GN
	4SLcj5i/cRZZgdce4ldAHDNhQQ+tsnkUjEzamR3LOF7JIJ+LtG0U9FNgpHQUJO4AVTH4s0
	FkT6lm0/sh5H54gZNbsE7fd31B2OXBx/FslLNKo2ieHoJLlO3VJIv1Gm3rJisRXFgcCkqA
	Beq09jO/ik5FCWPX24j5GL8Ry4yk6w2hniqwWMHdtsGF/WXzZU0l9ObEqSL6vpyrHKIvrz
	a2wlqkpUjNkqDvG3WoCr3AqbAp75lw/PcuLdKLujOEuTAXLK/8xFjKuFA8iGcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761837774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrxqbtZiBL/qfZS6zqxhKAA8G4C9IigNp34u5Qgc960=;
	b=9revQB1kULyB8N2ZJeUz5QrrHZRkebuE2Rq12yPd4uK07Gq7Qf8ec0iXI4J6hdjeWY5/qV
	p35lUOfoaoJvYxAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: Re: [PATCH 5/5] ARM: Allow to enable RT
Message-ID: <20251030152253.tK-rY89Y@linutronix.de>
References: <20251029155918.503060-1-bigeasy@linutronix.de>
 <20251029155918.503060-6-bigeasy@linutronix.de>
 <1ab2724c-4280-4193-832b-4afc0ba496c1@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1ab2724c-4280-4193-832b-4afc0ba496c1@app.fastmail.com>

On 2025-10-30 16:18:45 [+0100], Arnd Bergmann wrote:
> On Wed, Oct 29, 2025, at 16:59, Sebastian Andrzej Siewior wrote:
> > All known issues have been adressed.
> > Allow to select RT.
> >
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  arch/arm/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 99c9b1c320af8..002db8da69ee5 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -41,6 +41,7 @@ config ARM
> >  	select ARCH_SUPPORTS_CFI
> >  	select ARCH_SUPPORTS_HUGETLBFS if ARM_LPAE
> >  	select ARCH_SUPPORTS_PER_VMA_LOCK
> > +	select ARCH_SUPPORTS_RT if HAVE_POSIX_CPU_TIMERS_TASK_WORK
> >  	select ARCH_USE_BUILTIN_BSWAP
> >  	select ARCH_USE_CMPXCHG_LOCKREF
> >  	select ARCH_USE_MEMTEST
> > @@ -129,6 +130,7 @@ config ARM
> >  	select HAVE_PERF_EVENTS
> >  	select HAVE_PERF_REGS
> >  	select HAVE_PERF_USER_STACK_DUMP
> > +	select HAVE_POSIX_CPU_TIMERS_TASK_WORK if !KVM
> >  	select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
> >  	select HAVE_REGS_AND_STACK_ACCESS_API
> >  	select HAVE_RSEQ
> 
> This can be simplified slightly since CONFIG_KVM is long gone on
> ARM, so you can just select both HAVE_POSIX_CPU_TIMERS_TASK_WORK
> and ARCH_SUPPORTS_RT unconditionally.

If ARM does not have KVM then I would not depend on
HAVE_POSIX_CPU_TIMERS_TASK_WORK since selecting it without providing it
is wrong. This can be implemented without the need of KVM or RT.

>       Arnd

Sebastian
