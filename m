Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5ED33B6DA
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Mar 2026 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448237; cv=none; b=JD4xbq1N+YcFS9jB6cgN+37Lh69y7ZeRLcmr1OjNiRr2DllQHzvWohP6bZyxxwUxDUp8RJXfO1aiq68PDW1XWCSGqEJgXGzJjurO0ier/YB7X2b0QKbYSq91/fVZ26xV/4WJNPy/J4zzCS9ERKtffRhG9g1S4WUBUq2x9nMLptc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448237; c=relaxed/simple;
	bh=grUn59mxUvXPuCxTU+iBFUY/7/w53415CtPvweStB74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9c22XlvbehxfPqBn0GDOT6E2a66PAJkL9a6HkFm8lx6AwneTMiJ84wFTUYNR0I3Xt+DH2n/9wRs/esvDo7hdBzHhmq98S3GuwrHUp9CfqgmjmEh3d38Wj9XT+K+o9aVyT6aGPwsRtorNbfmlcSuthGJHxLiNEfKUDIQzKebDNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=POieAP56; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EZUWSgnM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="POieAP56";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EZUWSgnM"
Date: Mon, 2 Mar 2026 11:43:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772448232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0zLKLtB5A7zru2ahcIUFI/0NS64SB8AC7f0H7kN8aQ=;
	b=POieAP56h6+EUimzNHr1QIXuhdRMFHnsWSD9O7dhECwq6nKFsDhzAzUpqHBqjz8t0ziLVj
	ye3qvNWHsYvVxYLD4xcKeUad1ZCDGNMuaeprWloJyzSTLkelFvaDN560AhA/6wFapZyy4H
	0P+v5rt8EDBgikY4QdAmh0K35fOJu27mh+DwoblNtsSaAQVyX0gej07v2PkIlM1nDbXMze
	qrnQLkJCiUPfZO59LYc2Mgg4WLa3G8Z/gqiWv3d1USbieAXLciHwTYm9HWBQF2JlUJCGHo
	T6Xx/e0zdHEdu6a7oc56sURg7cQsbmWuMy87ullACwz2E2YyMdq28Y7mdFEKCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772448232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0zLKLtB5A7zru2ahcIUFI/0NS64SB8AC7f0H7kN8aQ=;
	b=EZUWSgnMd/Mkt//b0cYqq7JbPWZYKwsKHKmTMXm8JVUnVvnTUAX/Q8/2b+2S+vYyoBK8It
	OhAsdi09nhhhXnAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/6] ARM: move vmalloc() lazy-page table population
Message-ID: <20260302104351.yyWvNCTb@linutronix.de>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
 <E1vvzcX-0000000Awo0-2KBN@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <E1vvzcX-0000000Awo0-2KBN@rmk-PC.armlinux.org.uk>

On 2026-02-27 15:19:13 [+0000], Russell King (Oracle) wrote:
> Split the vmalloc() lazy-page table population from
> do_translation_fault() into a new vmalloc_fault() function.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> --- a/arch/arm/mm/fault.c
> +++ b/arch/arm/mm/fault.c
> @@ -261,6 +261,70 @@ static inline bool ttbr0_usermode_access_allowed(struct pt_regs *regs)
>  }
>  #endif
>  
> +/*
> + * Handle a vmalloc fault, copying the non-leaf page table entries from
> + * init_mm.pgd. Any kernel context can trigger this, so we must not sleep
> + * or enable interrupts. Having two CPUs execute this for the same page is

"unconditionally enable interrupts."? It wouldn't be wrong to enable
them if the calling context had them enabled, right?

> + * no problem, we'll just copy the same data twice.
> + *
> + * Returns false on failure.
> + */
> +static bool __kprobes __maybe_unused vmalloc_fault(unsigned long addr)

Maybe handle_vmalloc_fault().

> +{

Sebastian
