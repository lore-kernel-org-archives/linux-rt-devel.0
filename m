Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ED772622
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Mar 2026 15:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773934649; cv=none; b=c6qupL3D0++4aqcaNforhtIin7IQfndB5Y6G1mvkWcosLPFIcwMhn7a1uSlWms+oCQaYnXv0DSrzW3bMAWewwvWwteqSVmEOe0oV2dxPqI3CnIgvakcBh0HCHJyc2nc7v4WOUdCBueeMaVKarSBOiBWAkqvKRerKVJ9ED0M27cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773934649; c=relaxed/simple;
	bh=m47wt8te8pdLLJuE0AD+0WXTXlvbO8k1tPNVU7WiuZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBWANvPjZ239SYJ/FBqDwP8wLUpwYhFSOg9hP73LiBzt+CuuwU3PnPkXL2LYYSQqCkJU7w4d9U9HxRWM6jVfu5mQizDwMIiU8btgD7YzB+3qhzo26XiRI1pacONf/VDo2sPNtyXLUgH98UrWr8tDSZTJsby1WasjT1g9iMTPjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kOZk19s1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=knSRbQsH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kOZk19s1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="knSRbQsH"
Date: Thu, 19 Mar 2026 16:37:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773934645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pX8AWi3+fAkBpCvrvefx9HGhVqqVpnvrhHpID+luKag=;
	b=kOZk19s1v2DEUr0b3Z8YeKeFLvJkX5pi1vT3c4JceWhd3Qz2EdAmR/IPTTQ4IhvCjH5VyV
	x6AZleKCWh76JCiuzTZvHsDMuF4b7u770GTvKLcVh594mbwV8wbEEi+u8RERk5Tz/uuCzb
	w7zaYlvW5R4zMh7BBkyQuOqOMIl93UqWtSmERjQtazJSazewftrCt82xsnSyd6NoBFc/o3
	8ubiXMA3tmZrghON2x/1s1wml0TfSd7GpRxfEgeB1PfB0AK3W+tYPzTlZuvunswn7YUWCd
	qG9s71m5sUTn2vT7/R4okc8EFf0WC5hy63jEWeFpqEbYO81lMaBO6aqdx1Cy8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773934645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pX8AWi3+fAkBpCvrvefx9HGhVqqVpnvrhHpID+luKag=;
	b=knSRbQsHw49orwgVo+tZK3OebtUmiMv8RvvGqbQ9DPLYxHh7gYiD/ePbV0mqauiiIMdt9D
	OxuwvxflbyArFRDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/6] ARM: cleanup fault handling
Message-ID: <20260319153724.Aqs8brxQ@linutronix.de>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
 <20260302105735.Roqcqp6h@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260302105735.Roqcqp6h@linutronix.de>

On 2026-03-02 11:57:37 [+0100], To Russell King (Oracle) wrote:
> On 2026-02-27 15:18:26 [+0000], Russell King (Oracle) wrote:
> > Hi,
> Hi,
Hi Russell,

> > This series cleans up the 32-bit ARM fault handling:
> > 
> > 1. ensure a consistent IRQ state in the user fault processing path.
> > 2. split vmalloc fault processing in a similar way to x86
> > 3. move is_..._fault() to the local fault.h header file
> > 4. update the FSR deifnitions using BIT() and GENMASK()
> > 5. move LPAE/non-LPAE specific FSR bits/masks along side users
> > 6. get rid of #ifdefs within is_..._fault() by providing a LPAE
> >    and non-LPAE versions.
> 
> Thank you Russell. With this series (notably #1) the PREEMPT_RT support
> can be enabled. Would you mind adding "ARM: Allow to enable RT" from
> 	https://lore.kernel.org/all/20260226111742.3598421-3-bigeasy@linutronix.de/
> 
> to the series/ merge it with it? Or should I just send it to your patch
> system?

Russell, any suggestion how to move on here?

Sebastian
