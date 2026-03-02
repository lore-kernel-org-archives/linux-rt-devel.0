Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D035F8D2
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 11:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772450399; cv=none; b=XPUm+Zf6gGCncMQju9ueYeOGmVwxJ7wgTLXYU3De/8yxsPkiurD2+MucqzDRSfE1FfsuOzXIyMaUmupUps5YJKc3tWPeD8U/LiK4Xt5eNXopTg2HBN7HR9ARqH26qTE/mEA7zBQ+Oh3ZuZGAEJOds5LHywR4JZeTsfqJC9KwMwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772450399; c=relaxed/simple;
	bh=Am7M7v/yHZx3jg5FKouJ3m3d0QoGzJXSiE90KXOL4L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTP5qostar5mY/sAayGcYsqwD/EOh8zEnBLegve+CMkQ1l64M02nyYex1SArxFOp0gbzLNeaM27qjvDAQS9gmBtGYTTvY6d2TVFEU8oOTVrcKXFJcdH5RiVbs7iAmyIOAs7i+uCTcSlhzUSC5R8E//koqJSjrDSnKynwpnTqqT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=l83eA+F9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l83eA+F9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ocYEB4fdGgMKdOvsGSPbMiW4wO5zpFrlBMuOyfO3pn8=; b=l83eA+F97qbvUztHGOKN98Sc5U
	s8yrqskGDymoQUqUzA7Elqf699sR7PTFIlFouqAj577IC/UI/DJBGgZ47IcaWGcWLaKeYu3ON7PQY
	YBjRZX9r/LlLMEzsF3qWnrffsoxGgM3/RgmJXd294Cg9iSMOQ7lB9yluCQ8gidO0/0UspIdE++MBQ
	I+qaVT1WY+/kqzU4wiSp9ov9NVTFoRFECKo1GP4ybLqQyzZ66W+YqxaAkDjWBWGTsXqzUdNMzhUlG
	aaD5bT6eTI2kiREr0qbu582YzhnAuusFFW7VVDQrDWqp9Z8a6kI8QPnryxL7m9lD7FLA+hRshfr0N
	L5t41C9Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41268)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vx1Ja-000000003o0-2VeK;
	Mon, 02 Mar 2026 11:19:54 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vx1JY-000000005tv-3Shu;
	Mon, 02 Mar 2026 11:19:52 +0000
Date: Mon, 2 Mar 2026 11:19:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/6] ARM: move vmalloc() lazy-page table population
Message-ID: <aaVyWFNu8scqZeEY@shell.armlinux.org.uk>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
 <E1vvzcX-0000000Awo0-2KBN@rmk-PC.armlinux.org.uk>
 <20260302104351.yyWvNCTb@linutronix.de>
 <aaVs_31KNKvUkNL8@shell.armlinux.org.uk>
 <20260302110055.hFMkUcnt@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302110055.hFMkUcnt@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 02, 2026 at 12:00:55PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-03-02 10:57:03 [+0000], Russell King (Oracle) wrote:
> > > > --- a/arch/arm/mm/fault.c
> > > > +++ b/arch/arm/mm/fault.c
> > > > @@ -261,6 +261,70 @@ static inline bool ttbr0_usermode_access_allowed(struct pt_regs *regs)
> > > >  }
> > > >  #endif
> > > >  
> > > > +/*
> > > > + * Handle a vmalloc fault, copying the non-leaf page table entries from
> > > > + * init_mm.pgd. Any kernel context can trigger this, so we must not sleep
> > > > + * or enable interrupts. Having two CPUs execute this for the same page is
> > > 
> > > "unconditionally enable interrupts."? It wouldn't be wrong to enable
> > > them if the calling context had them enabled, right?
> > 
> > I don't know where you got "unconditionally enable interrupts" from the
> > comment - it says the exact opposite.
> 
> My point. You could enable the interrupts if the parent context had them
> enabled. It is not that you must keep them disabled because a second
> fault/ interrupt would overwrite your CPU state.

We've gone from the code always having interrupts disabled, to your
review response that always wants them to be enabled (which is what
*un*conditionally enable interrupts means) to now conditionally enable
interrupts.

We are reading the CPU's page table pointer (the one programmed in
hardware) here, and we don't want that changing while we're fixing
the fault. So, interrupts need to stay disabled. x86 doesn't enable
interrupts in this path either, and we shouldn't be having differing
behaviour without good reason.

There are two places where x86 enables interrupts in its fault
handling. One of them is while handling a user address fault in
do_user_addr_fault(). The other is __bad_area_nosemaphore() where we
also know that we've come from user mode. All other fault handling
happens with interrupts disabled.

In any case, we've always had interrupts disabled in this path. Any
change to that would need to be a separate patch.

So, the comment in the patch is 100% correct.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
