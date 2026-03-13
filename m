Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF01D37268B
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Mar 2026 08:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773389653; cv=none; b=R/VqZlPS+R2DhyffFqNQaZNT8pC0SUa3rNwQ6Qn6WRHI0YHBrwCEFNnzEQ1PB9GsDZBP9PZL5NuBMZf2RAlMXCKm7lypMwhzv8JLf4LprqtqCgDmM5WjPpqLyyZIIXVMV1LMsj1kva3BC8biGPjSzP0E4plicdPcYP0sXHKT6ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773389653; c=relaxed/simple;
	bh=NOwVTCj2Bf+bcv15qJJAw8ducjhuGqjXum3l1zrPerg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDkDZnKJnGRV7vgCPvZWPWzKLBlpZep04lYnFejEcdmX7ZiJ/4RHJBNPkpcJo/LWlB50J1wrNRpPuSSpIyLtHmNfWWsXz/iQsGdXT8mumVrBEagnCDonkXWhy+uLDIuYxbViq02W4iDhEGETKU/uwOr/q8vGEjvpdfx9u/NDq3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0tAerDzk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hBPobF8+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0tAerDzk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hBPobF8+"
Date: Fri, 13 Mar 2026 09:14:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773389644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ct7qebckGUx5GcC9JTNJqNdxTAlAfz9amV76IXfV000=;
	b=0tAerDzkvtxOLlAClGBSD14CX1AfkP/Rdc8FVd1MlVigKM/Kcl3/9CsmdzUuQQuQqMpZIN
	sjXMcNi5kOb2gpUIUbU7o4lx6uw4AUEtjDae4tujJVBlxTZ3LGAdGcGjmo94rvJd9ZDPES
	WEiDk/k4K2RtxDynKxTN17sblh7MV29cPus6mT/pwrjrhqfWrCFYMs7un+o7Zo+TdOQi0Y
	hFsJeEC+tWYsxEuDyQ3VwmsfU7U/hoTMYRX5EmcCwvMBnEUuF6slpksVxKn7nq2SXAFMak
	xlVjpc9tws0QItmI/rFOLzduM6kJdCGDeeHSyiZtilQq2/qGQtABBUIGcvs5oA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773389644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ct7qebckGUx5GcC9JTNJqNdxTAlAfz9amV76IXfV000=;
	b=hBPobF8+jn9s1MIsEq9OzoPpHCrNQIAPcsSc3QwPXN+D6ZSj9HC4S+8r1jhD+acgGp2bPk
	CBO4U2LGHDq9LOCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: boqun@kernel.org, clrkwllms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	longman@redhat.com, mingo@redhat.com, peterz@infradead.org,
	rostedt@goodmis.org, will@kernel.org
Subject: Re: [PATCH] softirq: WARN_ON !preemptible() not check softirq cnt in
 bh disable on RT
Message-ID: <20260313081402.D1ZLwsTF@linutronix.de>
References: <20260312100546.jjvRquDg@linutronix.de>
 <20260312124753.962974-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260312124753.962974-1-jackzxcui1989@163.com>

On 2026-03-12 20:47:53 [+0800], Xin Zhao wrote:
> hi, Sebastian
Hi Xin,

> > 
> > local_bh_disable() becomes an implicit RCU read lock section on
> > !PREEMPT_RT and be must preserve the semantic. 
> 
> My current understanding of the statement "local_bh_disable() becomes an implicit RCU read lock
> section on !PREEMPT_RT" is as follows:
> In a regular Linux system, during the period of local_bh_disable, both preemption and soft
> interrupts are disabled, so RCU callbacks cannot be executed. This effectively means that the
> progress of the RCU grace period is stalled during the bh disable period. In a PREEMPT_RT system,

No, that is not it. A preempt-disabled section can be interrupted by a
softirq. You can also offload the RCU-callbacks from CPU1 to CPU0 at
which point you can run RCU callbacks while CPU1 has interrupts off.
This has not always been like that but this is what we have now.

> RCU callbacks are executed in an RCU context and are not protected by bh disable, so it is
> necessary to explicitly mark the RCU read lock state.
> I don't know if my understanding is correct.

You do call_rcu() at which point the pointer/ callback lands on a list
for clean up. At this point if you can observe the pointer you need to
be in a RCU section to delay processing of the list, delaying the grace
period. If the grace period starts, all new callbacks land on a new
list. In order to process "the previous" list, the rcu_read_lock()
counter needs to get to zero and every CPU needs to schedule once. This
ensures that you are not in a preempt_disable() section (or
bh_disable(), or spin_lock(), or irq off). I think this is correct but
very compressed.

The requirement that preempt_disable() needs to be considered is very
old and comes from "classic RCU" where rcu_read_lock() was
preempt_disable() and some people just did preempt_disable() because
this was the thing before rcu_read_lock() was introduced. And then
spin_lock() did the same, some people rely on it so it needs to be
preserved.

> > Ideally if task X queues soft interrupts, it handles them and a later
> > task does not observe them. Only a task with higher priority can add
> > additional softirq work.
> > If task X queues BLOCK and gets preempted, task Y with higher priority
> > adds NET_RX, then task Y will handle NET_RX and BLOCK. This can be
> > avoided by handling the softirqs per-task.
> 
> It does sound like it can optimize quite a lot. By the way, does per-task
> manner calls softirq callbacks just before voluntary switch out or trigger
> task_work before return to user-space? 

It wouldn't change much. It would run on the exit from most outer BH
section, on local_bh_enable() like it is now. The difference would be
only that callbacks raised in this callbacks would be executed. So say,
TaskX raises NET_RX and BLOCK, gets preempted, TaskY gets in, raises
NET_RX and TASKLET. TaskY runs now callbacks and will do only NET_RX and
TASKLET. Then we schedule back to taskX which does NET_RX (empty) and
BLOCK.

Currently, TaskY would also do BLOCK.

> > I am not a big fan of the BH workqueues because you queue work items in
> > context in which it originates and then it "vanishes". So all the
> > priorities and so on are gone. Also the work from lower priority tasks
> > gets mixed with high priority tasks. Not something you desire in
> > general.
> > In general you are better off remaining in the threaded interrupt,
> > completing the work.
> 
> Indeed, if we queue the soft interrupts triggered by different priority
> tasks into a single workqueue, it wouldn't be very appropriate. If we
> want to queue them into a bottom-half (bh) workqueue, we would also need
> to create a corresponding workqueue for each priority and queue based on
> that priority. I previously developed a patch for a real-time workqueue,
> which has been used in our project. If certain soft interrupt tasks are
> very important and do not require CPU affinity, then queuing them on
> other CPUs to execute according to the actual priority needed might
> optimize performance to some extent from a real-time perspective.
> 
> https://lore.kernel.org/lkml/20251205125445.4154667-1-jackzxcui1989@163.com/

This encodes too much application logic. Having a kthread for a "thing"
is usually better. You can run that kthread either per-CPU or "unbound"
and let userland deal with it by either pinning it to a CPU and/ or
adjusting its priority based on his setup. So it can be more important
than network or less important (depending if your critical real time
work is network related or not). 

> Xin Zhao

Sebastian
