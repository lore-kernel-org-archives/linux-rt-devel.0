Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4193DCDBB
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Mar 2026 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773240716; cv=none; b=a01WxaOrhQgxJa6i77XntS0uWwnRc5ZPUJ+jy5pc8zujCc1QOcSz7wRFO4K4ZYh1aH00atW7bih5bmPs5k07QsOAKXPUZJgnDhCtTkNR1yqQ7dEO9gVWOwpi7e71hjhc9YwN09ywZ6Pi3G72WJTHpRCqDU1EKdzizG8XT9xfvY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773240716; c=relaxed/simple;
	bh=RfERqnE1t1NFQpTouIpOU6fwUCNFyayNq2kH4Jc/5B0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc4Sl7eQJibUP5fEn78v6mvpC1Yg7eW46gIuh5BVmJgC8SFJYyh1w3sVEtuVjK1mKsSUmdLMEZoQP4CvFxP6cF3Uf0Fw7GGLjPuSPAQiUWAb64/YpyZTDDe81x26JpbR7B1wdsd2GvcQzNQqZrW0/7eb+KoycHppB2D3aZAIyHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JOixGUW7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vhWe785E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JOixGUW7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vhWe785E"
Date: Wed, 11 Mar 2026 15:51:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773240710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8JODN19PltpAtAEfHpH9VX/DcbB2gTeXbVOlpdQzGGM=;
	b=JOixGUW7DsDcasGCmDD25pAzIla018mjbe2focWT9SQBSOJpi43HgSWfo4YUnmFHmAtwxo
	BgVAAD0+9iSwwsYq5lrflnjTWyo/HTM2JHmUbh9aZ9GA+ghXc2EU/KetMHKUENrdm1KDso
	bdzt6XrMNJaLEAfd7an4d2vp9DGb+RkGjCRvnnyDqvW2CgPgQEqlJ49yVjP3Nf/fRb8i+Y
	FArUjY80Ge+6OndsQ1nM7CVRSWqKLnAxu+4CM5FpRyyd4WtoBYDSOk3rGd0bOJ1aKmIpdb
	x79BQZWb6jo1KPnE3H6sVljtYrw/zq7VkYYq64kaugXNRWplDXfLHhaLRIhtIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773240710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8JODN19PltpAtAEfHpH9VX/DcbB2gTeXbVOlpdQzGGM=;
	b=vhWe785E5GO+pn9G7uqiAIhgAedY4axTcnDTeBk7yu4uIpmwWjOUDF1F63l1HvF09cZlp6
	hiPbwwSl8AMDzrAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: boqun@kernel.org, clrkwllms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, will@kernel.org
Subject: Re: [PATCH] softirq: WARN_ON !preemptible() not check softirq cnt in
 bh disable on RT
Message-ID: <20260311145149.dU2xpGoO@linutronix.de>
References: <20260311093303.4_1N-y3-@linutronix.de>
 <20260311104007.66966-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311104007.66966-1-jackzxcui1989@163.com>

On 2026-03-11 18:40:07 [+0800], Xin Zhao wrote:
> hi, Sebastian
Hi Xin,

> > > Although the original check of this_cpu_read(softirq_ctrl.cnt) can also
> > > prevent the WARN_ON print during the boot process, it may hide some issues
> > > that should be exposed immediately. Because softirq_ctrl.cnt maybe 0 when
> > > __local_bh_disabled_ip() is called in !preemptible() context.
> > 
> > That is actually the point. If it is known that the call chain does not
> > origin from bh-disabled context the it is fine. Well, not fine if you
> > stick to the details but good enough if you don't to constantly complain
> > to everyone about the little things which don't make a difference.
> 
> I just think that using (system_state != SYSTEM_BOOTING) for conditional checks
> is more reasonable than using (softirq_ctrl.cnt).

We had users which which did
	local_irq_disable();
	local_bh_disable();

and we decided not to bother if there is no reason to.

> > > In RT-Linux, __local_bh_disable_ip() will be used by numerous _bh variants
> > > locks and local_bh_disable(). Since locks call __might_resched() check, we
> > > analyze the scenario of using local_bh_disable() in !preemptible() context.
> > > 
> > > If CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is not enabled, __local_bh_disable_ip()
> > > does not enter the local_lock lock and thus using local_bh_disable() in
> > > !preemptible() context does not lead to might sleep problem, but using
> > > local_bh_disable() in !preemptible() state is not meaningful in RT-Linux.
> > 
> > but it does not cause a locking or scheduling problem either.
> > 
> > > In non RT-Linux, we use local_irq_save() followed by local_bh_disable() to
> > > keep soft interrupts disabled after restoring interrupts. However, in
> > > RT-Linux, when CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is not enabled,
> > > local_bh_disable() merely increments the softirq_ctrl.cnt counter without
> > > actually disabling the soft interrupt behavior, because other tasks on the
> > > CPU can preempt the task that wants to disable soft interrupts and execute
> > > soft interrupt-related logic.
> > > Consider the sequence diagram below:
> > > Task A                        Task B
> > >                               __local_bh_enable_ip()
> > >                                 __do_softirq()
> > >                                   handle_softirqs()
> > >                                     ...
> > >                                     local_irq_enable();
> > >                                     ...
> > > local_irq_save()
> > > local_bh_disable()
> > > local_irq_restore()
> > >                                     h->action(); -- it is serving softirq
> > > local_bh_enable()
> > 
> > Okay. How is this a problem? You can enter this scenario event even
> > without disabling interrupts within Task A.
> 
> I should use the situation where CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is enabled to
> illustrate the example above. People would expect that soft interrupts on this
> CPU would not execute after calling local_bh_disable(), but as shown in the
> example, this cannot actually be guaranteed.

If CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is enabled then the scenario is
possible but the DEBUG_LOCKS_WARN_ON will trigger a warning.

> Using (softirq_ctrl.cnt) as a condition for WARN_ON will only report issues in
> scenarios similar to the one shown in the example. In many other cases, during
> the execution of Task A, if there is no soft interrupt-related logic running on
> the CPU, this WARN_ON may not get printed, thus hiding potential issues in the
> code.
> 
> If Task A truly expects that soft interrupts remain disabled after calling
> local_bh_disable(), and this expectation may not be met, we should detect this
> risk early and prompt the user, just like the might_sleep() checks, providing
> warnings proactively rather than indicating an issue after it has occurred.

Hmm. Is there actually anything wrong in tree?
Longterm I would intend to make !CONFIG_PREEMPT_RT_NEEDS_BH_LOCK
default.

> Xin Zhao

Sebastian
