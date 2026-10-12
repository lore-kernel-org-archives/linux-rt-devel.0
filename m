Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAD35C1A6;
	Mon, 12 Oct 2026 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818489; cv=none; b=F8bpl3laoC4N72Pekqx8C6EMJGUJdxvsPvfRQGMndXfUs6OBx96eoyq/xFJOrhdVQVVZsKbWPQFjC99fTFc22hLTujdu/wvI1IO0zBJeWxKEt0Q2VDrEUGi9LGf1gzvic5T3giW3apEYLCBySMWipjacXdYxCyKFU+X5myQWBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818489; c=relaxed/simple;
	bh=V3T2KqP05PPNQNzMnOJGikVCS700ULWiyxMbOFqWao0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eP7mNFqgiEl8oqGm+gD8X9+C+TeIlGBremkWuBDY3egbl3LCA8dzaWS1VxrEsnHjZ6hdH0RC2jml002M8kixnXyu1I8HZDxJWEeGG28jPnSk3Tbw+coumVPu4UFkMCtOuFT7sIfknKB2rmDU83fQnyESLPZlZD/w3mi+FJx46Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m/zyFzFq; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m/zyFzFq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bX+SBpFYzPiBpusGse8IzndZlRu6fhKhDRIRSp1NJCY=; b=m/zyFzFqnIQbIMgFdQ6cTjDeO+
	nKdANjlgOCsb5Ig7GjV+yb2g8UA99n+yx/dKBzRgWyAatmboZgtAef9IUp5tpMlxt/an5qcXYMOHg
	JuwAYZSKuAvIV5EObJpNRVF2B3WfyXbQmrSkMMvNL3B5EUYqiGAH6wAQztpxS3TuSDy6xSQoAYX+q
	RYwbo2ln3veFYdVslCuaET23JX0zXoEIg3a2RvFZyo5RTv19mKiQU6RcFCb8MHlgB6ON1VQYD/kA7
	Vv65fgu5M815N1+cKQmjbu3Xnl2kHpv7LoFR++1dYiUJDQfdGbm7fMDL9g7xLXBJ+/DWBmyj2sc5B
	GpSXlvyA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGHq6-0000000EZME-0CGZ;
	Mon, 12 Oct 2026 15:21:22 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 6C50830045A; Mon, 12 Oct 2026 17:21:20 +0200 (CEST)
Date: Mon, 12 Oct 2026 17:21:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC PATCH] entry: Account the deferred hrtimer rearm as hardirq
 context for lockdep
Message-ID: <20261012152120.GT4121339@noisy.programming.kicks-ass.net>
References: <20261008204649.62265-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008204649.62265-1-mikhail.v.gavrilov@gmail.com>

On Fri, Oct 09, 2026 at 01:46:49AM +0500, Mikhail Gavrilov wrote:

> Commit 15dd3a948855
> ("hrtimer: Push reprogramming timers into the interrupt return path")
> moved the reprogramming of the clock event device out of the timer
> interrupt into the interrupt return path. On return to kernel mode
> irqentry_exit_to_kernel_mode_after_preempt() performs it after
> irq_exit_rcu() has already left lockdep's hardirq context. lockdep
> therefore records hrtimer_bases.lock and the timekeeper sequence count
> as taken by the interrupted context, on top of the locks that context
> holds, and every distinct held-lock stack an interrupt hits adds two
> lock chains. When the rearm runs from irq_enter_rcu() or
> __irq_exit_rcu() it is still inside lockdep's hardirq context, and there
> the same acquisitions reuse one pair of chains.

Urgh.

> Not touched, and a question for you: the rearm in hrtick_schedule_exit()
> also stacks chains on the preempted task's locks, under the runqueue lock.
> Chains with hrtimer_bases.lock under the runqueue lock, this rearm among
> them, were 4.9% of the pool in the boot above. Should it get the same
> treatment?

I'm thinking those would be there before the patch too. We've always
done hrtimer_start() from there. You might not have seen it because
hrtick was default disabled for most.


>  include/linux/irq-entry-common.h | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
> index 0bb6c03481fa..521cc30cef08 100644
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -468,6 +468,21 @@ static inline void irqentry_exit_to_kernel_mode_preempt(struct pt_regs *regs,
>  		irqentry_exit_cond_resched();
>  }
>  
> +/*
> + * The deferred hrtimer rearm is the tail of the timer interrupt, moved to the
> + * interrupt return path so that it runs after a possible reschedule. By now
> + * irq_exit_rcu() has left lockdep's hardirq context. Re-enter it for the
> + * rearm, so that the hrtimer base lock and the timekeeping sequence count are
> + * not chained onto the locks held by the interrupted context, which would add
> + * new lock chains for every lock stack an interrupt hits.
> + */
> +static __always_inline void irqentry_hrtimer_rearm_deferred(void)
> +{
> +	lockdep_hardirq_enter();
> +	hrtimer_rearm_deferred();
> +	lockdep_hardirq_exit();
> +}
> +
>  /**
>   * irqentry_exit_to_kernel_mode_after_preempt - Establish trace, lockdep and RCU state
>   * @regs:	Pointer to current's pt_regs
> @@ -491,7 +506,7 @@ irqentry_exit_to_kernel_mode_after_preempt(struct pt_regs *regs, irqentry_state_
>  		 */
>  		if (state.exit_rcu) {
>  			instrumentation_begin();
> -			hrtimer_rearm_deferred();
> +			irqentry_hrtimer_rearm_deferred();
>  			/* Tell the tracer that IRET will enable interrupts */
>  			trace_hardirqs_on_prepare();
>  			lockdep_hardirqs_on_prepare();
> @@ -502,7 +517,7 @@ irqentry_exit_to_kernel_mode_after_preempt(struct pt_regs *regs, irqentry_state_
>  		}
>  
>  		instrumentation_begin();
> -		hrtimer_rearm_deferred();
> +		irqentry_hrtimer_rearm_deferred();
>  		/* Covers both tracing and lockdep */
>  		trace_hardirqs_on();
>  		instrumentation_end();

The first question I had was about __exit_to_usermode_prepare(), that
also does hrtimer_rearm, but doesn't get wrapped. I'm thinking that's
not a problem because at that point the lock stack is empty and all
that. But perhaps a comment?

That said; I wonder if we want more of irqentry_exit_to_kernel_mode()
wrapped like this. The schedule_preempt_irq() thing will now also stack
rq->lock and the like on top of 'random' kernel stacks, rather than
keeping it in 'empty' hardirq contexts.

Or am I making a mess of things?

