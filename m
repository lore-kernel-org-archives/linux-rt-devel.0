Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389D27EFEF
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756811866; cv=none; b=gzgvyt2AKAB05LANzzf8qF+shv1X0BialjNR9YOlDjIj6ox/zQQBzg1AE5Yz1AM/Xb1ib+D7FPEPLqeTHfiRLBBlWso8UuciOsP7lphPECKp+FBh3Ctyzhcb3RrcrbXEByQe6SAwOUcUK/RjYDTELukjy4HEKCWOvNCSHIBnqBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756811866; c=relaxed/simple;
	bh=fHzzoYSHg9ksGleSFYDrl9wU1kx1EKt1g9S3/Xb5Qcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SWKjjZhZsarV2YXI/oFC2PAK+d8hNDeiNlpbU/XDorI7KLHQceY4y2A/rZX+se4D38O4gEq6KmijF750X/dNWIwb4FOCde5FZROlv7rwmHZqiq+vU3gCUEllJwMxFiO62E6k1tiJ2/orAX9hzBjq0tHi7rI8lVOvzBtciWbrnlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SMZ7+Bmc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2rPU+K4o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SMZ7+Bmc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2rPU+K4o"
Date: Tue, 2 Sep 2025 13:17:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756811863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFjWGYIsy98AcXysopDf44OU1aoUg06aXLTfYq7t5/Y=;
	b=SMZ7+Bmca+nbikRYRdLxU+XVQnbDVZovZileY6fafW96He4JmaMW7dXm+3OC8JqcqlcEZV
	TKcIaBIKFivExqIrU0PhqIEQn8TqCNCeK/brusv/90W14XC1j6oov6FE1QuZwGnIPRevcI
	OyhujgVQO8r4sTYfotQDkrMaFJs7OwSqUeWQiCSywfEE9aTxyJ43eIUR85AXYHDmghEmMx
	Y2liL2e3C7IxlLXqe9AShWWMMd9pe9FIlMY/eJpjkh5AXrX0zue+ExItIXTg5HsDYALskC
	0aRFi2zmf4WHaSRQJbgHWk4g1cAjlvHV2qguY7zVtiE+6ExSmAHB3LwjfdRnzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756811863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oFjWGYIsy98AcXysopDf44OU1aoUg06aXLTfYq7t5/Y=;
	b=2rPU+K4osKEZ4g9DRYiIyNmCpekP07sNWBICZPX8nt6n46cGh6Y+4JkJn0B9SnwmKQZc1j
	yPS/MtXtRZsmpZAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 1/3] workqueue: Provide a handshake for canceling BH
 workers
Message-ID: <20250902111740.hwMmUu4T@linutronix.de>
References: <20250901163811.963326-1-bigeasy@linutronix.de>
 <20250901163811.963326-2-bigeasy@linutronix.de>
 <CAJhGHyBaqn_HOoHX+YinKW5YSy1rncfbvYXktkEtmFgK44E9wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJhGHyBaqn_HOoHX+YinKW5YSy1rncfbvYXktkEtmFgK44E9wg@mail.gmail.com>

On 2025-09-02 18:12:10 [+0800], Lai Jiangshan wrote:
> Hello
Hi Lai,

> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -222,7 +222,9 @@ struct worker_pool {
> >         struct workqueue_attrs  *attrs;         /* I: worker attributes */
> >         struct hlist_node       hash_node;      /* PL: unbound_pool_hash node */
> >         int                     refcnt;         /* PL: refcnt for unbound pools */
> > -
> > +#ifdef CONFIG_PREEMPT_RT
> > +       spinlock_t              cb_lock;        /* BH worker cancel lock */
> > +#endif
> >         /*
> 
> Is it possible to use rt_mutex_init_proxy_locked(), rt_mutex_proxy_unlock()
> and rt_mutex_wait_proxy_lock()?
> 
> Or is it possible to add something like rt_spinlock_init_proxy_locked(),
> rt_spinlock_proxy_unlock() and rt_spinlock_wait_proxy_lock() which work
> the same as the rt_mutex's proxy lock primitives but for non-sleep context?

I don't think so. I think non-sleep context is the killer part. Those
are for PI and this works by assigning waiter's priority, going to sleep
until "it" is done. Now if you want non-sleep then you would have to
remain on the CPU and spin until the "work" is done. This spinning would
work if the other task is on a remote CPU. But if both are on the same
CPU then spinning is not working.

> I think they will work as an rt variant of struct completion and
> they can be used for __flush_work() for BH work for preempt_rt
> as the same way as wait_for_completion() is used for normal work.

I completely dislike the idea of spinning until completion for the BH
work. Yes, we have three tasklet users which are doing this as of today.
We have no users which require this for workqueue and you can schedule a
workqueue from interrupt context.
Why do we even what this? My idea was to submit this and then hide later
behind an "atomic" API which will hopefully remain unused. As explained
it the previous thread: From RT's point of view it requires to acquire
and drop the cb_lock each time and boost all items on that worker until
the "barrier" work item arrives. While in general the "one" item is
boosted if needed.

> Thanks
> Lai

Sebastian
