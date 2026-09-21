Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B42649B5A0
	for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789998621; cv=none; b=cizRKcw2FUEBtc0PzsZAK9vtEJvlOeTDEbWU/GOWwDkumXJSf6Eh8eRkcFq/uf64NshDkN8iYOlKksZ291KRkMFMNq1cphiBOckQfdoaul0omesVbylVJ/ClHnnrVmmowHT9zLISaHhPO1wolRt2TwFgOhgmKziB+TzfXbyOTlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789998621; c=relaxed/simple;
	bh=ACnM+V+aLLV5+YeRJKhqFR36cL4sDZE1i820gzYMOPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwFOEzMOMrCMSNXB/Bb3IVO0AeEbwrMExw9YfKdH9REYfhZHCkikdT2MgyZOthbmiUw7PRmLKWH/jdSanjyq0x+12i1SgL6eGgrxB/1XCeejQOZD2vt0HOc0jBmjep7RCwrsQyA/W7+tpVCeNdvkhu1qVXUiodd+W/uCLGLHmD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xTb2mdfg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KAnPetvn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xTb2mdfg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KAnPetvn"
Date: Mon, 21 Sep 2026 15:50:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789998616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=157TXiKV8552H/o9aH6Mds39Zvu4RhFll/XUmprzqEA=;
	b=xTb2mdfg918hMuru6Kb8sn0AP4njh4WU8uYhqHPTg0UxGQqbb80z/6xsOQgMFg4NyM53SG
	qlquanf1yHjToIChesXr3jPTfK+kYJxPWeNoWpNSHfKjh+OYL8FDKbtPRosF4Dzd4krUZ7
	OPV8WlR1Mbx79Esq2eKJHEhCVD0NSUenYd/Kz5TWhaOga6WqLVeA56GxZo+K0s52MmAUai
	ypgBtRsswZoDRx4DFZScSNZ/xi3qaFaJjW4+te+CXJef3h4Jr2UL+LjNxV6SeNOVVPyJic
	228ZDbPKJFLjwpvK6kjpLqsYZmqG5L/GMAtX0gWtConhDEgJCzIpztweXKebCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789998616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=157TXiKV8552H/o9aH6Mds39Zvu4RhFll/XUmprzqEA=;
	b=KAnPetvneJQjjrynrUuU0OTT1nM5GN5cvv+NI8q2Ni2G6l2I8KGoSPzFG4WVZSE58MpjIi
	HCYKFAmCzyW9zvDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] softirq: Preserve interrupt context during IRQ exit
Message-ID: <20260921135015.edLXthz6@linutronix.de>
References: <20260905023210.82853-1-kmehltretter@gmail.com>
 <20260917152150.dvEKJ8B3@linutronix.de>
 <20260919075105.34023-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919075105.34023-1-kmehltretter@gmail.com>

On 2026-09-19 09:51:05 [+0200], Karl Mehltretter wrote:
> On 2026-09-17 17:21:50 [+0200], Sebastian Andrzej Siewior wrote:
> > The breakage is limited to KCSAN & friends within the window during
> > transition to softirq and out. There is nothing else? Well, the timer
> > wake looks wrong in trace, noted.
> 
> I know of nothing that is broken today. It is more than instrumentation
> though. Code that reads the context from preempt_count sees the
> interrupted task in that window. Besides ftrace, KCSAN, KMSAN, KCOV and
> the printk caller id I found:
> 
>  - can_spin_trylock() and local_trylock() on RT refuse hard interrupt
>    context. A trylock on top of a task that is blocked on a lock
>    confuses the PI code. In that window they do not refuse. BPF attached
>    to sched_waking or sched_wakeup reaches them through kmalloc_nolock().
> 
>  - oops_end() and make_task_dead() test in_interrupt(). Today an oops in
>    that window is treated like an oops in task context and kills the
>    interrupted task. With HARDIRQ_OFFSET set it panics with "Fatal
>    exception in interrupt", like an oops in the handler itself.
> 
>  - rcu_read_unlock_special() and raise_softirq_irqoff(). See the end of
>    this mail.
> 
> I'll list these in the changelog. I will also say what the patch does
> not cover. tick_irq_exit() and the other deferred rearm sites still run
> after HARDIRQ_OFFSET is removed.

The "important" part is this fixing something that is broken today or is
it just avoiding fallout. We don't have any memory allocations/ locking
in the mentioned window as far as I know. That would fix things, just
avoid fallout.
The wake-up in that window does record wrong flags in the recorded trace
but I am unsure if this mandates a fix-me-backport for instance.

> The value is the same. Without the casts gcc warns:
> 
>   warning: overflow in conversion from 'long unsigned int' to 'int'
>   changes value from '18446744073692774656' to '-16776960' [-Woverflow]
> 
> -Woverflow is on by default. I'll swap the operands:

Is this some gcc-17 thing? I don't remember that I saw it and I did test
that.

> > that is quite some WARN_ON_ONCE. We would like to see just
> > HARDIRQ_OFFSET at the end. Or SOFTIRQ_OFFSET before the end. One should
> > be enough or the math is wrong.
> 
> softirq_handle_end() will have one. It checks irq_count() ==
> HARDIRQ_OFFSET after the addition. In softirq_handle_begin() I will move
> lockdep_softirqs_off() before the assertion. Then the lockdep softirq
> state is consistent if the assertion fires and printk runs.

Right. I mean you have one state and this what you want test for. I
don't think it make sense to test before and after arithmetics.
I am just not sure if those warnings should be hidden behind
CONFIG_DEBUG_PREEMPT similar as preempt_count_add() does it. Maybe it is
not hot-enough-path to worry about it.

> > Why is this preempt_count() instead irq_count. Why is there
> > IRQ_EXIT_TIMERS? It is almost as the first check except now we would
> > like to ignore the additional softirq_count().
> 
> Yes, that is the intent. irq_count() would skip the wakeup when the
> interrupt hit a BH disabled or softirq serving section. The old test
> did not skip it, and nothing else handles pending_timer_softirq.

I am slightly unsure but I think we want the wakeup of the timer thread
even if we are in a bh-disabled section. If the current task is a
SCHED_OTHER then the wake-up preempt it. If the thread is already woken
then the wake-up will do nothing.

> I'll drop the macro and the raw preempt_count() and use
> 
> 	!in_nmi() && hardirq_count() == HARDIRQ_OFFSET
> 
> This is the old test, evaluated before HARDIRQ_OFFSET is removed. It
> reads like the first check without softirq_count(). I'll add a comment
> that says why softirq_count() is left out.
> 
> I also want to change the order in your code. With HARDIRQ_OFFSET set,
> raise_softirq_irqoff() does not wake ksoftirqd. rcu_read_unlock_special()
> raises RCU_SOFTIRQ instead of setting NEED_RESCHED. Both assume that

It depends if RCU uses softirq _and_ BH was disabled. So I don't see
what is wrong with that.
Anyway, one step at a time with some reasoning why.

> interrupt exit handles pending softirqs. In v2 that is not true for a
> softirq raised inside wake_timersd(), because the wakeup comes after the
> pending check. The timer thread would handle it, because run_ktimerd()
> handles all vectors. I do not want to rely on that, but wake the timer
> thread first:
> 
> 	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
> 	    local_timers_pending_force_th() &&
> 	    !in_nmi() && hardirq_count() == HARDIRQ_OFFSET)
> 		wake_timersd();
> 
> 	if (irq_count() == HARDIRQ_OFFSET && local_softirq_pending()) {
> 		hrtimer_rearm_deferred();
> 		invoke_softirq();
> 	}
> 
> 	preempt_count_sub(HARDIRQ_OFFSET);
> 	tick_irq_exit();
> 
> Today the wakeup already runs before the rearm when no softirq is
> pending. Does the old order have a reason that I do not see? Then I
> keep it and document that the timer thread handles such a softirq.

This only matters for the threadirq case. Here invoke_softirq() will
only wake ksoftirqd and wake_timersd() will only wake the ktimers
thread. There will be no new softirqs added to the mask. This currently
is an ugly catch-all for both sides. Ideally only the softirqs raised by
task X should be handled by task X but the first one will do everything.

> Karl

Sebastian
