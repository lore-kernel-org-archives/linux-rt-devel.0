Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8122FC01B
	for <linux-rt-devel@lists.linux.dev>; Mon, 12 Jan 2026 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768231629; cv=none; b=KadkWazyWxia0dNmpo8QTSPkFr06kFt3QedaDJm23s20yBItwr0H5Ril2rPuJYNRb6ZttPNllfdTrYQONr6dkqwd5L3q8obdgd3EHpOowV7gZ0lytVnOjZ1XvbNWoZOuY5EMwcj8S6/phPj2pfbrXm7xTJe6rUHABm7GJV5qgKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768231629; c=relaxed/simple;
	bh=oVUwuNagOwAVRBnGzcG1umn2ZB9l5X1iVufL/1EfOAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IJKbT38tVavsdCKodbTA0nvUNW/WDMeDUrNqfZI8KgPJys4ZiSM43G8QhgVpXTCVdLFXlXdOzMiUtM9RjtN/i9ax5ZoaBMy4Fc6BffPIeuOyr0Jm1koYs8GEGvtr873XYJzGCP/7+bKB72FLJUc61MKI9FZy/8JeWTy1qr/igUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ouvQVH6o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PxG4wFB1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ouvQVH6o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PxG4wFB1"
Date: Mon, 12 Jan 2026 16:27:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768231624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DEn0+vni0ijyJTbbWPZn43T96N7EyTp4VR7+jIheKeE=;
	b=ouvQVH6oRAR4UfYBMCxtZki1r0ToE7WH8Tvxx98NizDFDqVTB4NsaxI9UoJkEnS+KpNETx
	t3Cz4zuXvy3qpJvEKsjELrZW9yP8geEM9VnZ7WE6N1fvUj0cF4ubGHqe+3j8d0dVZdmVBx
	UE7p5MMY7QK0b22GzxW5sJk8KGzYnuWMmmmaR6mvbf/iIDIiO0T9zdznEnuwsC2TVu9WVP
	PklPLrJgxkfdBbgSLWUAuA+T+nRyZaF/p+kL/NcGWaZr9HDq3Ta3WBj8pNXUh9p36sIvRT
	62OIYkb2VPlhZZeyo6VfRwhQTFe2YU4ssIWKQp0BDTWDYOOJKHqI2G0vasxQhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768231624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DEn0+vni0ijyJTbbWPZn43T96N7EyTp4VR7+jIheKeE=;
	b=PxG4wFB16JHVH+n+QOyP5pzGCf2VIAo16FPmtCR7ejzc+21eWWZuqR1QUjrUJs0q9pxRVJ
	VvjWWYw5E9fmPNDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
	liangjlee@google.com
Subject: Re: Regression in performance when using PREEMPT_RT
Message-ID: <20260112152702.-73BFhnF@linutronix.de>
References: <20251226110249.0c2f1d8d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226110249.0c2f1d8d@gandalf.local.home>

On 2025-12-26 11:02:49 [-0500], Steven Rostedt wrote:
> Hi Sebastian,
> 
> We are doing some experiments in running Android Pixel with a PREEMPT_RT
> kernel, we found a few unacceptable performance regressions. One was in the
> block layer. In non-rt, the ufshcd interrupt would trigger the BLOCK
> softirq on another CPU. In RT, it always triggered the softirq on the same
> CPU as the interrupt. As the interrupt line always triggers on CPU0, it
> forces the BLOCK softirq to also always run on CPU 0, which is bad because
> CPU 0 is a little core and the main work should be running on a big core.
> 
> In block/blk-mq.c:blk_mq_complete_need_ipi() there's this code:
> 
> 	/*
> 	 * With force threaded interrupts enabled, raising softirq from an SMP
> 	 * function call will always result in waking the ksoftirqd thread.
> 	 * This is probably worse than completing the request on a different
> 	 * cache domain.
> 	 */
> 	if (force_irqthreads())
> 		return false;
> 
> When I saw "probably worse", I'm thinking this was decided by analysis and
> not by any real numbers. Was it?
> 
> When we commented out the above if statement so that it did not return
> false, things sped up to almost non-rt speeds again.
> 
> The fio benchmark went from 76MB to 94MB (higher is better). It's still not
> at the level of non-rt, but this was definitely one of the areas that
> caused the regression.
> 
> Is that exit out of the function truly needed?

If I remember correctly, it completes in the context the
threaded-handler. It only does the remote-IPI thingy if the queue is
assigned to a different CPU than the CPU where it completes the request.
In your case it seems that either the device has multiple queues
configured and just one interrupt or the queue is configured to a
different CPU than the interrupt.

If you have multiple queues but just one interrupt then the lack
distributing the load is unfortunate. If the queue has been moved to a
BIG CPU then I suggest to move the IRQ to a BIG CPU, too.

If you ignore the statement and allow the remote-IPI to kick the softirq
then the request ends up in ksoftirqd on the remote CPU probably
accompanied by a warning. Here it runs as SCHED_OTHER and competes for
CPU resources with any other task on that CPU which different than
softirq on !RT where it has to wait until other hardirqs complete.
The other thing is that if something "else" is busy, say a
threaded-interrupt then it will pickup this request (before ksoftirqd
had the chance). The result is that handler now does the I/O at its end
instead ksoftirqd. If the interrupt is important and has a higher
priority then the average MAX_RT_PRIO / 2 then this block I/O might
disrupt its schedule.

I think moving the interrupt to a BIG CPU (as the block queue), if
possible, would be the easiest thing to do.
If the hardware restricts it, I would suggest having a dedicated
SCHED_FIFO thread for its duty would be better than an anonymous
catch-all ksoftirqd.

> Thanks,

Sebastian
