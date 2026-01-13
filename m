Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A053803FC
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Jan 2026 08:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768293843; cv=none; b=Napm1wRsm44Q8/JPGFM1RRemHi+SByIY8CAKvIPUF9egTn9GT2QBoLtHTKFmy9ajQUI2gWXwt0ByEl9cb23tKbhYQfFX3mOnkwfQbxfoCHvj12fSdRBWVuLVdzNOfrKD28iAVmJODDl8WVUnvJxeTepUgfkJAltPm8ealVneALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768293843; c=relaxed/simple;
	bh=fJqGqkX6XZGUhq00KGOlugtxf7DhQXaXCfwXTxmX0Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs3NyYO4OGrQ07hkPxP0bG5VjOLPtW6+J0ozqIj80vAgh98rRm4uFP2MqeMH7Z+4j2z0LJyXQst7yvtSDNMmLRaeLVgfLwAspOAUjleiBlDWaiUHdNWwrTqAr49xV94V7H+MPoMYsrJ7Gl7rD5UEEv8fRuqsGQYpoxpV7K9CIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmguyQX1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BgHeo+fl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmguyQX1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BgHeo+fl"
Date: Tue, 13 Jan 2026 09:43:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768293841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AdTjAzAKQBYEL5OQjV6f38C4DwSSxKprjKJ6pTNzCoE=;
	b=NmguyQX1V1Vy08xl2rmdDnDTFv0WdG+yMfjqgFYBHJBSPAoafmcXB8nrALaxrDh9upx4YT
	9LOvCZZC/2Sj9I6Vf7iygbaSkmWl4ub+EBes4d8gPUfseAHVzlNNGeGgybmFocxKQyhBvV
	BTGXlFnVHaYL5j0JqSQ5DVFSI6H0DNq6amIpXgiUvmTleLp+uWhWzx3hF3aC0F1n5sZxVi
	6Z0oII8XyUkgseHqRoeyxTN6CtdcIYRomxp+BRvz4qsLl6lnhYnjIj4jVzTlaJWC+LV2lM
	Rsq02PaAjpYSyVXAbpyqz1+1po3SFWHup6jUqf4j7Jg7NIy0H1IqaAr7jIwTfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768293841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AdTjAzAKQBYEL5OQjV6f38C4DwSSxKprjKJ6pTNzCoE=;
	b=BgHeo+fl/nfOaYAKVL0l7NmwLZrmGcE+Fesw/+jIGG0+fBda84QGyLKFy5MVpK3EvVq/Ss
	SY6qztn1/1/OiRBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
	liangjlee@google.com
Subject: Re: Regression in performance when using PREEMPT_RT
Message-ID: <20260113084359.esKk1MF2@linutronix.de>
References: <20251226110249.0c2f1d8d@gandalf.local.home>
 <20260112152702.-73BFhnF@linutronix.de>
 <20260112123356.5bc120b6@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260112123356.5bc120b6@gandalf.local.home>

On 2026-01-12 12:33:56 [-0500], Steven Rostedt wrote:
> > CPU resources with any other task on that CPU which different than
> > softirq on !RT where it has to wait until other hardirqs complete.
> > The other thing is that if something "else" is busy, say a
> > threaded-interrupt then it will pickup this request (before ksoftirqd
> > had the chance). The result is that handler now does the I/O at its end
> > instead ksoftirqd. If the interrupt is important and has a higher
> > priority then the average MAX_RT_PRIO / 2 then this block I/O might
> > disrupt its schedule.
> 
> I'm not sure what the affect of that would be.

It could get completed by the networking interrupt. That would be okay
from the "correctness" POV but if your networking has higher priority
and disk I/O is considered low priority then it will be probably not
good.

> > I think moving the interrupt to a BIG CPU (as the block queue), if
> > possible, would be the easiest thing to do.
> 
> We have done that. It appears that the hardware simply picks the first CPU
> it can use and *always* uses that. By setting it to a big core, it did get
> some improvement but the problem is still that the softirq only runs on
> that CPU.

That is "normal". Unless you have firmware that configures each
interrupt to a CPU and linux simply uses the default value. 

> > If the hardware restricts it, I would suggest having a dedicated
> > SCHED_FIFO thread for its duty would be better than an anonymous
> > catch-all ksoftirqd.
> 
> I think the solution may be to give up on PREEMPT_RT if that's the case,
> unless there's a non PREEMPT_RT reason to make that change.
> 
> To give you an idea of what the issue is here, it is the distribution of the
> block softirq (even when the irq itself is always coming in on a single
> CPU).
> 
>  cat /proc/softirqs | grep -i block
> 
> non-rt:
> 	BLOCK:          6          0          0          0          1          7     162986     164750
> 
> RT unmodified:
> 	BLOCK:     329875          0          0          0          0          0          0          0
> 
> RT without the forced_irqthreads check:
> 	BLOCK:          0          0          0          0         11         15     164116     163619

So the last two or four CPUs are the big ones? It seems that you have at
least two queues. Not sure where they come from.
I would suggest to create threads per run-queue just to keep it within
the context. This should mimic the anonymous softirq. The difference
would be the higher priority and preference over the SCHED_OTHER tasks
which might improve the performance (which depends on the current
workload, i.e. if your system idle then there is no fight for CPU
ressources).
Or you get the one interrupt per queue if this is missing in the eMMC
driver somewhere on the software side. Usually the NVME do this.

> -- Steve

Sebastian
