Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA2532F74F
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Oct 2025 15:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837870; cv=none; b=OJXLi8/Eo4UpqXXIThB9Wj5h8sxjTZRngbVUoFC8MDDYd5Z84hySLZj4HCfM5U2hE3UwaMltvRJ5vD8Mg5ysqc1N/T8VXlI3vaIQqCXw3lhegRb0mo4Xx3Zuo6yYT/ShZhztRcVoq9ZQlLRj3K6xxnpN7d1+D4EYqbWqvi2tpR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837870; c=relaxed/simple;
	bh=nSzmJNbMLU0Y4VF4MpXStF8rYLD3J+zExA3aj5Fc9R0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRi25I3SgxcHL90Ie6NhVWm5oq8Q0B9s+mmqGeJZyfJNzAslyNJhZ83SyW5hUUEaqWt1dqS8v+/OJ0CGqhdTm8iT2j4lIyQpS100zIyrvQpK2JhbOjBLG1szex8LzalD+QPk1Nj9r0lJuvAGx1wcQKOm+wlidaOqXib8llpKqUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PKcyx326; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cDdEynsJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PKcyx326";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cDdEynsJ"
Date: Thu, 30 Oct 2025 16:24:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761837867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi/t7YkNDmbk/F2qjW7hI53RWpw2lxVXNHcYNrayOdI=;
	b=PKcyx326D3+6GEI9BgzdYGpKGr1M3DTsKJUZUJDpfu+2OYWLb5hosf54uJfao4ZFZ9k1/H
	tS25ImM+z+iwPAK0cBSVCrKbt4LmIwqmGFegjsdDynWaj+U8u3LDrp3nbrO3ZjvY2Ehya4
	snO+unzlBbIteNp3qnKHZdeQuCRPqkDSTbx/VUTkAqRoyqrtiod3uUleQAdsJp/0JMPWOt
	ciEDS6KQDg8t7Wy5Zl4Av35PEPk+3ZGzTZLdAu80a4Nv5TXUUBitdD4JHcGvJm4ERLSnJV
	DCcrKX06JfA3QOnKxCunQ8ArxxJZrr8z6zC36WjwLX4aH3kjBRaXPJ2YS3W0jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761837867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi/t7YkNDmbk/F2qjW7hI53RWpw2lxVXNHcYNrayOdI=;
	b=cDdEynsJkm+iNs3BWvcN4anqDWDDygdDuSlxxaxsuCZFAbGofLkfpGrpQM9/5Tab2UGHkR
	V7ueWyLJUTmYZPAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Russell King <linux@armlinux.org.uk>,
	Xie Yuanbin <xieyuanbin1@huawei.com>
Subject: Re: [PATCH 3/5] ARM: Disable FAST_GUP on PREEMPT_RT if HIGHPTE is
 also enabled.
Message-ID: <20251030152425.TXa7Vocb@linutronix.de>
References: <20251029155918.503060-1-bigeasy@linutronix.de>
 <20251029155918.503060-4-bigeasy@linutronix.de>
 <324652fe-b5b8-45a6-9c57-096813e9092c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <324652fe-b5b8-45a6-9c57-096813e9092c@app.fastmail.com>

On 2025-10-30 16:15:42 [+0100], Arnd Bergmann wrote:
> On Wed, Oct 29, 2025, at 16:59, Sebastian Andrzej Siewior wrote:
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -105,7 +105,7 @@ config ARM
> >  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> >  	select HAVE_EFFICIENT_UNALIGNED_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && MMU
> >  	select HAVE_EXIT_THREAD
> > -	select HAVE_GUP_FAST if ARM_LPAE
> > +	select HAVE_GUP_FAST if ARM_LPAE && !(PREEMPT_RT && HIGHPTE)
> >  	select HAVE_FUNCTION_ERROR_INJECTION
> >  	select HAVE_FUNCTION_GRAPH_TRACER
> >  	select HAVE_FUNCTION_GRAPH_FREGS
> 
> I would still prefer the version I posted previous at
> 
> https://lore.kernel.org/all/20241210160556.2341497-3-arnd@kernel.org/
> 
> disabling HIGHPTE when PREEMPT_RT is enabled.

I did remember that we shifted something I just wasn't sure what it was.
I will update for v2.

>      Arnd

Sebastian
