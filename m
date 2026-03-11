Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21272E7F0A
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Mar 2026 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245357; cv=none; b=Z8FDbCQzu9PzHg7Fq1GatLlPj3mOgnb6/+BX/J+YgFZmwI/VMvO/fvgD+ly3bwdIj2evI9dVba6ayCFgcAoGfp1EnmXXQoJs0ZGj0EtGG6wjfmPg1UCOmxFVJKr3PykPcpTswiVgKGsRUsMZ6tDQEr4SEY8+RbXWmg3hTDxXKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245357; c=relaxed/simple;
	bh=RkkzeNoT323clY/rhpzTJ+1YN4JH3idADq1QniA9ZBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWg0QIak98G54MA5n3rJojdrM1QD1WOkmNMY7MQUf4DhW7fxseEuyvQofg+6s6WaW80likLNbH1lv4W3T9dfhW1zKaXQoR0U2dBTicsRL6lFlfBqcitjFY7LeF7SDUYFMN23KtfIVsXZdbIOOgp8bTMRiaFOY3xhOTU0cXHCkzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hr4252XC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/hQpgCQi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hr4252XC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/hQpgCQi"
Date: Wed, 11 Mar 2026 17:09:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773245351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S2seA070HVr0gkIKDrpkKeoGhMu52LjYkSwWucylBao=;
	b=hr4252XCH1E94zR8KYOPZwJtVyKXdzS0kw9X0CbnySZSybfuYMQwwL5N45qlvY49WXBEmD
	L9dmUSnqnUZy1mfYzvdnbDNLe3g1lluL3mgb+Tsv7pqU1K7ipcVgGcYIrq3F9UnTXiDCnz
	bKxw9hKjzX8Uwo9vtDyokZ2xXyEXemTPNvs9AVj7/s0psW6mGX6mB40yJ7IoY1CvWoZgd2
	wJcENKZX/mZRtbYl7a9OIOTtsBSO0r/QDS7tW2rscF5X5zCPOUIZlpgMud3Ge9xHh9s3GD
	iqZ0+Ap+bx8y2WPa9xLoPGd0nVxW7yqpr/KfTpEJhtXUjsSkkFp7oweAMZ8sRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773245351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S2seA070HVr0gkIKDrpkKeoGhMu52LjYkSwWucylBao=;
	b=/hQpgCQijCOQt3059Uj4YmmMwjxp5lY8TjslJ46+jeoMz+lh8uYnM7kBd2mYz22rSvHRKs
	tcup80TzV8vJjQCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: boqun@kernel.org, clrkwllms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, will@kernel.org
Subject: Re: [PATCH] softirq: WARN_ON !preemptible() not check softirq cnt in
 bh disable on RT
Message-ID: <20260311160910.yoU_8pQ7@linutronix.de>
References: <20260311145149.dU2xpGoO@linutronix.de>
 <20260311153402.230138-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260311153402.230138-1-jackzxcui1989@163.com>

On 2026-03-11 23:34:02 [+0800], Xin Zhao wrote:
> hi, Sebastian
Hi,

> On 2026-03-11 14:51 UTC, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> 
> > > I just think that using (system_state != SYSTEM_BOOTING) for conditional checks
> > > is more reasonable than using (softirq_ctrl.cnt).
> > 
> > We had users which which did
> > 	local_irq_disable();
> > 	local_bh_disable();
> > 
> > and we decided not to bother if there is no reason to.
> 
> If there are users have such usage, it will probabilistically hit the print statement
> for DEBUG_LOCKS_WARN_ON(softirq_ctrl.cnt). This is because the task running this code
> may preempt a task that has already entered the local_bh_disable critical section.
> Isn't that right?

Correct. And that is how got rid of the offenders. If I remember
correctly a few remained during kernel init which were considered not an
issue. But I just booted a few boxes double checking and I don't see the
warning meaning it went away.

> > > I should use the situation where CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is enabled to
> > > illustrate the example above. People would expect that soft interrupts on this
> > > CPU would not execute after calling local_bh_disable(), but as shown in the
> > > example, this cannot actually be guaranteed.
> > 
> > If CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is enabled then the scenario is
> > possible but the DEBUG_LOCKS_WARN_ON will trigger a warning.
> 
> Indeed, it will trigger this warning; it just reduces the probability of it being
> reported.
Yes

> > Hmm. Is there actually anything wrong in tree?
> > Longterm I would intend to make !CONFIG_PREEMPT_RT_NEEDS_BH_LOCK
> > default.
> 
> I am tracing the soft interrupt code interface and found a _local_bh_enable interface
> that only exists in non-RT Linux. This _local_bh_enable is used in sclp.c as follows:

Funny story: I did a grep for the pattern you described and this s390
driver was the only thing that popped up.

>     local_irq_disable();
>     local_ctl_load(0, &cr0);
>     if (!irq_context)
>         _local_bh_enable();
>     local_tick_enable(old_tick);
>     local_irq_restore(flags);
> 
> I did not further investigate why the above code in sclp.c is not used in RT-Linux. As
> for why _local_bh_enable does not exist in RT-Linux, it may be due to the consideration
> that local_bh_disable is "ineffective" in the !preemptible() state in RT-Linux, but I'm
> not sure if my understanding is correct.
> 
> Since you also mentioned that later CONFIG_PREEMPT_RT_NEEDS_BH_LOCK will no longer be
> enabled, at that point, local_bh_disable almost loses its significance. I think it
> should either be removed or implemented as a no-op, as it no longer achieves our
> expected effect, and it would be better to save some instruction execution time.

We can't nop it entirely. local_bh_disable() needs remain a RCU read
section and it needs to ensure that the context does not wonder off to
another CPU. Also we need to count the disable/enable because once we go
back to zero, we need to run callbacks which may have queued up.
And if we queue the softirq on per-task basis rather then per-CPU then
we don't have the problem that one task completes softirqs queued by
another one.

> Xin Zhao

Sebastian
