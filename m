Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E3730E854
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Feb 2026 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771256270; cv=none; b=QY2O0W1+bZvlXG4T435vH4RT+O5SmKUap5EPHoH82uhqFBmCmYX7ntvfsegdOTZ1RKot4DxI6aHh+xvNmrcCxoGXDf+2cUAj3tMHFco9IbImpqQ4cWvzEmI4BHJe/UjReDzTQXQsnArYU5wAaipE7emA3Vbhg9LxaLQYw/VgcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771256270; c=relaxed/simple;
	bh=4bDUvi6EEPic+v6Ow+64yXCVquOAAgfRnQCiCWcMckU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BRlE1aYs4kAehacex83gjkrK7LZkMyGeDhAvAL0D136WaZrWkJZdRJG6mk08aLF52+zNvuZypZQZRkQegaZmKgvutOypQnAu2sxJz5q3m893roOikXVU5Ay92xH2BZoFbRVHIwtAor8hlXQrcnUj3ledjjIFeMUxPdDZfYWkY+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hJkGpQ3w; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sv9xFOQP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hJkGpQ3w";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sv9xFOQP"
Date: Mon, 16 Feb 2026 16:37:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771256267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6PnG3DeeB6mHo0hnnLDiezB/8Zfvc61iiF9yoYDdbs0=;
	b=hJkGpQ3wBA/LVJYeFutd1Ooe4HXfnZ3K7a+xdXAssA9CfQuL+SefTFp4oRLwEqgQKvblqC
	JoNTJol/AkcSPZG1qLoTrDnssecG6Wc0UY6Cj0G1hWMLPss/qc4R/72ypC2GEMDii/P7k8
	QGvWVVXZwKwcRtoWVmrSil7ueFOKWdSkbjgyi/XPv0Td+ut5kQYyago+xZA7qEwV0Z4doi
	OisvBjeL8ocvDWxJBukYUX4Nn6dwgilXRcJ5TwmyvZiXRv+Ohg1FXVoecNMYg8M2ro/Sbs
	fPl/0xV/c1okZLhB/Kr6FQTThFced0zSTacSPU1+SMfQ/DEc54thXOxwU1tkow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771256267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6PnG3DeeB6mHo0hnnLDiezB/8Zfvc61iiF9yoYDdbs0=;
	b=sv9xFOQPVrfsm4wO3sVRTKH4Fig0un2FzAXsPkdWRfDOjsnrA/XNt3eTUFGBZOg/vCAZbh
	DYrPJautLl9o7SDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on
 PREEMPT_RT
Message-ID: <20260216153745.CA3__zRc@linutronix.de>
References: <20260216134333.412332-1-spasswolf@web.de>
 <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6274de932f4a62c51b424b65fc875ef3cb5ffd60.camel@web.de>

On 2026-02-16 16:32:29 [+0100], Bert Karwatzki wrote:
> Am Montag, dem 16.02.2026 um 14:43 +0100 schrieb Bert Karwatzki:
> > Starting with linux-6.18, I see the following log messages
> > 
> > 2026-02-15T23:50:17.558716+01:00 [ T1559] Dead loop on virtual device wlp4s0, fix it urgently!
> > 2026-02-15T23:50:17.558737+01:00 [ T1559] Dead loop on virtual device wlp4s0, fix it urgently!
> > [...]
> > 
> > regarding my wireless network device
> > 
> > 04:00.0 Network controller [0280]: MEDIATEK Corp. MT7921K (RZ608) Wi-Fi 6E 80MHz [14c3:0608]
> > 
> > I bisected this (from v6.17 to v6.18) and got this as the first bad commit:
> > 3253cb49cbad ("softirq: Allow to drop the softirq-BKL lock on PREEMPT_RT")
> > 
> > Using CONFIG_PREEMPT_RT_NEEDS_BH_LOCK=y in v6.18.10 fixes the issue.
> > 
> > Bert Karwatzki
> 
> May I presume that to fix this properly at least some of the spin_lock_bh()s in
> net/mac80211/ need to be converted to local_lock_nested_bh()s?

I am not sure what issue is so I can't tell. The dev_xmit_recursion*()
based counters are per-task so it should be fine. But yet the wifi
managed to repeatedly enqueue packets. This might be a real recursion, a
stack trace should tell. And then, somewhere synchronisation is missing.

> Bert Karwatzki

Sebastian
