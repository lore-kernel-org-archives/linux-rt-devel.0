Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5DB1CA84
	for <linux-rt-devel@lists.linux.dev>; Thu, 10 Apr 2025 06:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744267729; cv=none; b=QCNs+BWkGbYLuJm8ZPrRjepW/lBUWDW3qhG3cmpKGCEgs2NeZGSZ8G3QbitusICtLKtIY7ozALxuQJCjoM7zc7QLWHyPNGQd1N/sWrhNpul2h7FVXrtR531ybZkCBBAr0RqW3g354YRswoskZ2Et3ETmEJFNQxV8dLd/Fm4jAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744267729; c=relaxed/simple;
	bh=sZM9CP//2z8V6Uj/FTh7LVuB83U+xRpiCRHizaMJ//w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKpqkWhUwmiKWkCgs/0Zy4sVH8XSdKyp6csd+u7x231CqPhkGX9uj4k4IDxcSM7YU4kwKEP3GhxRruUYDkoq6iZlxW8hofiAnuqx04CFlwEmQBFBvgiGYjDgUFEIyw4t7o2RzpY950VoDKJhtx5t87xfcbQOzvysTy1yoUh4ONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Zfht4AQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xLg12l5B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Zfht4AQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xLg12l5B"
Date: Thu, 10 Apr 2025 08:48:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744267725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2cDfQjMVvP2bl8F3g4a6IR3khW0kxUFdh8FMWtAJKLQ=;
	b=2Zfht4AQPI7fM/2v77p7eH9APYGCt+J7iXPqq+32fb6KGk82WSl9xVfczj7YVHcGM/Y3dV
	/fa1M+ilScbHzxdz4tsEVDV921i9qwNUqFum7fpX6it7dP8zvLyV/l2pOvQ6UWeup8AJau
	EA3onaaIjVVvVYrbA75lLJnuY6uE+b2iTGv0dh29G9mzv4o9Rs96tHNSXKWviY12m9gay2
	6WyFcqHvQFKzp8/PpEMyGnjLKkcp+omArULWc8UB/QEmUYK9lOsU4K2j+CNLBwu6qjg4e5
	OaOQKKEik4HVzT4g5FzVN8i9bdXYzU77pYScK04Vdh4iRXi+frkx23oL/6SUxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744267725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2cDfQjMVvP2bl8F3g4a6IR3khW0kxUFdh8FMWtAJKLQ=;
	b=xLg12l5BQw8aXErIR0/4IbfoonTlxjP51TpzIISdt+LpAVaSe2SDIVtcbEYMbndkjMXv71
	bOHRCAUkbbF6sbDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, lclaudio00@gmail.com,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <20250410064844.wm4KbunL@linutronix.de>
References: <Z_bDWN2pAnijPAMR@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z_bDWN2pAnijPAMR@uudg.org>

+ sched folks.

On 2025-04-09 15:58:32 [-0300], Luis Claudio R. Goncalves wrote:
> With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> with a mutex enqueued. That could lead to this sequence:
> 
> 	rt_mutex_adjust_prio_chain()
> 	  put_task_struct()
> 	    __put_task_struct()
> 	      sched_ext_free()
> 	        spin_lock_irqsave()
> 	          rtlock_lock() --->  TRIGGERS
> 	                              lockdep_assert(!current->pi_blocked_on);
> 
> Adjust the check in put_task_struct() to also consider pi_blocked_on before
> calling __put_task_struct(), resorting to the deferred call in case it is
> set.
> 
> v2: Rostedt suggested removing the #ifdef from put_task_struct() and
>     creating tsk_is_pi_blocked_on() in sched.h to make the change cleaner.

I complained about this special RT case in put_task_struct() when it was
first got introduced. Couldn't we just just unconditionally do the RCU
put?

> Suggested-by: Crystal Wood <crwood@redhat.com>
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
>  include/linux/sched.h      |   12 ++++++++++++
>  include/linux/sched/task.h |   10 +++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5ec93e5ba53a9..9fbfa7f55a83d 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2148,6 +2148,18 @@ static inline bool task_is_runnable(struct task_struct *p)
>  	return p->on_rq && !p->se.sched_delayed;
>  }
>  
> +#ifdef CONFIG_RT_MUTEXES
> +static inline bool tsk_is_pi_blocked_on(struct task_struct *tsk)
> +{
> +	return tsk->pi_blocked_on != NULL;
> +}
> +#else
> +static inline bool tsk_is_pi_blocked_on(strut task_struct *tsk)
> +{
> +	return false;
> +}
> +#endif
> +
>  extern bool sched_task_on_rq(struct task_struct *p);
>  extern unsigned long get_wchan(struct task_struct *p);
>  extern struct task_struct *cpu_curr_snapshot(int cpu);
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 0f2aeb37bbb04..1f17a3dd51774 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -135,9 +135,11 @@ static inline void put_task_struct(struct task_struct *t)
>  
>  	/*
>  	 * In !RT, it is always safe to call __put_task_struct().
> -	 * Under RT, we can only call it in preemptible context.
> +	 * Under RT, we can only call it in preemptible context,
> +	 * when not blocked on a PI chain.
>  	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
> +	    (preemptible() || !tsk_is_pi_blocked_on(current))) {
>  		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
>  
>  		lock_map_acquire_try(&put_task_map);
> @@ -149,7 +151,9 @@ static inline void put_task_struct(struct task_struct *t)
>  	/*
>  	 * under PREEMPT_RT, we can't call put_task_struct
>  	 * in atomic context because it will indirectly
> -	 * acquire sleeping locks.
> +	 * acquire sleeping locks. The same is true if the
> +	 * current process has a mutex enqueued (blocked on
> +	 * a PI chain).
>  	 *
>  	 * call_rcu() will schedule delayed_put_task_struct_rcu()
>  	 * to be called in process context.

Sebastian
