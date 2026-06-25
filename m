Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FF43D16FD
	for <linux-rt-devel@lists.linux.dev>; Thu, 25 Jun 2026 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782383024; cv=none; b=lwWm4XO+xjgFYNRRmN39mqela3F3JM1qovaBbQwsc2aZfoJFIhTNgPDL6L0BZpDvixJdmvMPvFBB1haTZvRzGrTKRM9/X0R5VYtYv7TB/u5qcn9gN6fe4NG/7xOCg1k+DUaO+BuBv4oJInowR+fVzS6vlJs6HajBgr+jDcfR0w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782383024; c=relaxed/simple;
	bh=rq6lW2/CJHyipvrcdPacZBylD98yvnyB3oEp62sWO8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hufLJ532m9GnE0EVDLI0qb1Vbi2EQfMBI97yip82mz5r1fHT+ek/XKjkhoSvo7AUykVuSGEdw19hLwDtDHwiS08eRzEcD2Dc4WGiFU/OFRWIptOaTfKxBfS0lFeRyF1OALN0mx2cueuVIUfUDyMSvR2G7nGSBS4vQq1aZh+6IBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=m3sOIQ+q; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="m3sOIQ+q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x38mY+apgJvav2oRACEhK8S6N3vdzgE0kpGM3pJ4yJk=; b=m3sOIQ+qBZbLluxKlIKAN1D0aW
	fRpYkZERaIqvEHIQrSa1INeAtc1DFAyUnD5gb6GUHirkWLdB4/VviXsgjBq//+l68gmfvFQY6ZaHk
	FdKcKNaeR1JsW586gBMhiiskZmtHSOIXb68QVyOahCjp3NPKxkV+vA1MHFsQO+ignUM5vi3gkV24c
	aBoxIX9JzVkoctjJMa02yxLBJL1m3/U665ZLLuj7GPJZNr59MBGiIg+s6uGEsFJKryug2LqWIiB59
	ghay+lyo6Li0rNlU5A1HPfczPSqfjanlnPnFlhXcydzfMtO1FekZzgHvY5JGLsCzlw+86FMXHntMB
	valLG4/w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37248)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wchF9-000000000nG-3BJO;
	Thu, 25 Jun 2026 11:23:35 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wchF8-000000001vx-1ikY;
	Thu, 25 Jun 2026 11:23:34 +0100
Date: Thu, 25 Jun 2026 11:23:34 +0100
From: Russell King <linux@armlinux.org.uk>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
	linusw@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, liaohua4@huawei.com,
	lilinjie8@huawei.com
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling
 user mode errors
Message-ID: <aj0BpqlaCh3cVw8Q@shell.armlinux.org.uk>
References: <20260625073522.182503-1-xieyuanbin1@huawei.com>
 <20260625100031.25088-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625100031.25088-1-xieyuanbin1@huawei.com>
Sender: "Russell King,,," <linux@armlinux.org.uk>

On Thu, Jun 25, 2026 at 06:00:31PM +0800, Xie Yuanbin wrote:
> On 2026-06-25 10:05:52 [+0100], Russell King wrote:
> > > for this but actual breakpoint handling might be broken or is it 
> > > just me? But then your stack trace looks like mine so :/
> > 
> > ARM Linux doesn't use BKPT. BKPT was an instruction introduced by Arm 
> > Ltd in ARMv5TE. Prior to this, we use a UDF instruction instead (we 
> > had to pick something!) and gdb and other tools use that as a 
> > breapoint.
> > 
> > Moreover, BKPT isn't guaranteed to trap to the kernel, especially when 
> > there is a hardware debugger connected. In that case, DDI0100E states 
> > that use of BKPT must be according to the instructions provided with 
> > the hardware debugger. This makes BKPT unsuitable for use.
> 
> When do_DataAbort()/do_PrefetchAbort() run into `inf->fn()`, and the
> hook function return != 0 with interrupts disabled, the WARN may be
> triggered. From the code perspective, there are countless possible
> places, and "bkpt #0" is just one of these.
> 
> For example:
> bcm5301x_init_early()->hook_fault_code(bcm5301x_abort_handler).
> if CONFIG_ARCH_BCM_5301X=y, then bcm5301x_abort_handler() may return 1
> without enabling the interrupts.
> if CONFIG_ARCH_BCM_5301X=n, then in the same scenario it will run into
> do_bad(), also return 1 without enabling the interrupts.
> 
> So I think maybe:
> 1. enable interrupts in all hook functions, maybe
>    multiple points for modification.
> 2. enable interrupts in do_DataAbort()/do_PrefetchAbort() before
>    `inf->fn()`, but harden_branch_predictor() may be difficult.

Unfortunately, this breaks the Spectre/Meltdown mitigations. The
page fault handlers must be entered with interrupts disabled.

> 3. enable interrupts in do_DataAbort()/do_PrefetchAbort() after
>    `inf->fn()`, this may be ok.
> 
> From this perspective, arm_notify_die() also seems to be a good place?

If one is happy with higher latency for preempt cases, then it may
be, but if we want lower latency, then it ought to be earlier.
My preference is (3).

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
