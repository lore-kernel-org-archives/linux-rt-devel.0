Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510890;
	b=YHCEbApG4QVOE0lQtUPoyyHBnoj0oJ41mId5gdZRJvk7c4igoq1ilX04VdxezoT8f7vY
	 NJ6tAIrkOgFTKW45fCeY4w34OPD++0mpd2FXhTU+wi6UE97TT4h6ovJDJM0Ais0trY4Cg
	 eoa7HkScDK5Fwy4fbl6Kc8r+ua9UGZ7v7pIs+wk50M38sBvTUd31QX4YnKuzfu2db6X/x
	 aSEHcjPJ4OZNgaBv0f+QBld894KIgPnBT4/yg/COIX+J3NyMG/4MRjSeW1TA7tbb/aS4+
	 58jHPIxpwloyqGD+JWFNJBxj2n/FfjPADhy0df9230y9NSLTDmFmzpTT8L3BvdsfqOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510890;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=zNlGFfzkwV6FPF6+BDZB5x8JOUEfDn0OibP8uM9DPxU=;
	b=l/p+JDVLvoEpzBlXI333f3QVfoSL4Vmi0gM84rLaobS+gjKcJQ6qy2k40v3OIvLU79pR
	 J1o+f/HV/mTlN50VRJeaPtnD1E69FwF0zNDZXY1S9jSZJZ643ns9KbSpyySM1p50+1hRJ
	 8L3WHxVcRbYOyqUjcVJGAW5wRqGkXBJAZc25HFyliQQRFvY0ik2l5OFKm0Sx0PeIgjVfH
	 NSELYlVj/5oUs8/lhKnQgt6pMhYPWNjBCGCSI5YwF66nry9kLPlK2yNLVlZoFHLpNLUEE
	 o/ocFlSGtKIRt1PmTCxioc4/BYeGfsXx7rLEDohCHHaxqQQMY084ODvcBo9KD/epC5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dgf9PKGP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=BuI05u+J;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7A6606A31C
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 19:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A7A6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dgf9PKGP;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=BuI05u+J
Date: Thu, 12 Nov 2026 20:14:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794510888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNlGFfzkwV6FPF6+BDZB5x8JOUEfDn0OibP8uM9DPxU=;
	b=dgf9PKGPPx6MMiVxAPo5ClHsYi0fWqjpAjmvvMZ49eOommAsRo3sGZjni06W/f8HM8UB1Y
	iZBNrBH9nLTiorhkSKwKbrsNPxgY/zTFnOBgDT1kGIUg5SG9nq0A36ZtzS2VLIP2Qq5C88
	nddRFEzBTAhHA/MDnxJoiD6uQWHSNLfuLruJcguv3eziiKR5TnvtauI1vxHl/zSEXCBizW
	0f+bJ0LYN7k3Ruwq3qzjLdFiNoy4+Sh3Jb22U/uzGM31Yo89yQREnpo2VkG5D0WaYjD41z
	gRH1AXMxqUqfDDmeYLd1luUk8ay/LCl3vWXTJlyMOrnKWuzNVp+lhJNf0+wpTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794510888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zNlGFfzkwV6FPF6+BDZB5x8JOUEfDn0OibP8uM9DPxU=;
	b=BuI05u+JiHs7vQsJX/T/5J4yDMpGINOxVPsk6nzq3wwhvQVDxEnC4YTlm2ahGnhGWTcvLu
	MIiIXuwGnSE2F+CA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nsc@kernel.org>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Julian Braha <julianbraha@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@amutable.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-rt-devel@lists.linux.dev, debian-kernel@lists.debian.org,
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
Message-ID: <avYQJiHwzCkzeONg@lx-t490>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <avQNdicGzL3De556@derry.ads.avm.de>
 <avWy2r1BcDatzwo1@lx-t490>
 <20261112175042.GD4107043@ax162>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112175042.GD4107043@ax162>

On Thu, 12 Nov 2026, Nathan Chancellor wrote:
>
> On Thu, Nov 12, 2026 at 01:36:42PM +0100, Ahmed S. Darwish wrote:
> >
> > Would it be OK if one or two people from the Kconfig side also step-up as
> > reviewrs?  Julian? Nicolas? Nathan?
> >
>
> Sure, I have no objections to being a reviewer for this tool.
>

Thanks a lot!

>
> What tree(s) do you envision this initially landing in and taking
> subsequent updates through?
>

Unless you have any objections, I think kbuild would be the right tree ;)

All the best,
Ahmed
