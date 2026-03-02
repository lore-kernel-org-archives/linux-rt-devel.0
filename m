Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D7134EEF5
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772449034; cv=none; b=PT65I2qEeCO8HYEYxxUjvGZCD3vz7LafKXcYOLAnLi4Am4oclUVkjF8gYpr7LHThXduJKAXQQWIDVvQELJvx8axwjRZyMxGwqEB5krq1LvrfOYkVe+KqqoAYPiFIMfIFgfg6hJWs71UCL0MACdRFwYKAoYacS8hpw8p6ac0/HKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772449034; c=relaxed/simple;
	bh=pnpZTbLli4wnugoxOc1WAGx7te+6Faf/piqwdNeepIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyW/wwqT1nV3jkVPa/OdPBPlmNOepQiTQ0PCZBhM2UhRuqdj4IY6a/fuyf9dXzwvshBGPIR4sF7BGp/xUKFe6yGCqfFrlMleHo7qylFJznjlmGZKNGw1sRWs1YTjSIhTmjWGHGkUnECl7dWq9nVm0PdViHdMQYxMJsZd6RvKBrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=udnUpSWG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="udnUpSWG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FAqhxBxcL4d5OKJCpmpcDNhOGlqoMuYHBy0BmNlM2k4=; b=udnUpSWGRreB4H62gRwfpXeEGy
	fLCciVqT8O01ynpse167ELki3yPqtqIMlR10aBB+6zptX87JO/WVhaCLcTSa5mfq7rCr5SLlZ2LE3
	w+zjDH+bpkMbWfuw1qcAt0i1MXkkLoOpXnyFk7fzZ+IT/iWLqv8uF5STM6ftfCsXwKvzhRCUeN9hL
	RHjWKP/1te+e6SPfrm91EWv1HFDdw7C96K5LNJFq7JeKaIw2sax2zlz+5GitYNtChke+f+MXrKTPv
	zPCvMuucqjUNhzlHSlL76evdS5YNSv6UHc7LHJOvMxQln768gQ/Apyan4BvHZisj7VxtmAsiUN77h
	z1nCR4hQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47878)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vx0xV-000000003mI-3xrV;
	Mon, 02 Mar 2026 10:57:06 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vx0xT-000000005sn-0urP;
	Mon, 02 Mar 2026 10:57:03 +0000
Date: Mon, 2 Mar 2026 10:57:03 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/6] ARM: move vmalloc() lazy-page table population
Message-ID: <aaVs_31KNKvUkNL8@shell.armlinux.org.uk>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
 <E1vvzcX-0000000Awo0-2KBN@rmk-PC.armlinux.org.uk>
 <20260302104351.yyWvNCTb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302104351.yyWvNCTb@linutronix.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 02, 2026 at 11:43:51AM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-27 15:19:13 [+0000], Russell King (Oracle) wrote:
> > Split the vmalloc() lazy-page table population from
> > do_translation_fault() into a new vmalloc_fault() function.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> > --- a/arch/arm/mm/fault.c
> > +++ b/arch/arm/mm/fault.c
> > @@ -261,6 +261,70 @@ static inline bool ttbr0_usermode_access_allowed(struct pt_regs *regs)
> >  }
> >  #endif
> >  
> > +/*
> > + * Handle a vmalloc fault, copying the non-leaf page table entries from
> > + * init_mm.pgd. Any kernel context can trigger this, so we must not sleep
> > + * or enable interrupts. Having two CPUs execute this for the same page is
> 
> "unconditionally enable interrupts."? It wouldn't be wrong to enable
> them if the calling context had them enabled, right?

I don't know where you got "unconditionally enable interrupts" from the
comment - it says the exact opposite.

> 
> > + * no problem, we'll just copy the same data twice.
> > + *
> > + * Returns false on failure.
> > + */
> > +static bool __kprobes __maybe_unused vmalloc_fault(unsigned long addr)
> 
> Maybe handle_vmalloc_fault().

x86:

static noinline int vmalloc_fault(unsigned long address)
{
...

I prefer to keep the name the same.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
