Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A6D293C57;
	Tue, 17 Jun 2025 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152380; cv=none; b=BzV0GpxvlvrqW2qGe7o5NAOTT4LLss6Pc2oaD13E3LQuOiyERWMeff3bci7of9taO168eEuzL7dAxDYp9Yo6/mdyxDhHZjxiLU9pHrWGHd4vQKCsk4DDRDuflWwMvkVWxksGo0xvccA1frulz0xKU10rZ311uuvfLgtdIZcOLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152380; c=relaxed/simple;
	bh=tEdbtuqZcchLoDWZOowWW0dNyOhuwX8zhFxOwPzEozM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pk+QuMxp3YIs4MxXYtKAnAdKnz5RMVVmUHvzn/2Yf8pCfBVDFWCRCXLJxKYPAzHXzmwSd8+BagkvE2lo+oqEmU2zhDlWIqi8DYOy5QRyKJMLTdemxcG9XWQrhhScw1IjiZ6l14pzKAxSyuvbZOhGWJTs5U6ZlGyHbdGc81xnZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cRnCcT2G; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cRnCcT2G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LpJtHAO+l391V4MTDYJdtbpzYP7Tob1XgARez9VAkgk=; b=cRnCcT2GzpjKy0QWJm5YQR+8Or
	bzwk0WBy8L7GiYB4PNEh9jGyGUWnQEi4rHBzYiv1Yu74tbayYsQ1NlJ+fwYcYmVwkI7a6voy5jJx/
	13NCMApPKbBC2laXjlmavhVLeb0seRjMAX1AQdRhyrFqxjZck51eTUJf3uQ0cUxin7h+U2Tdj76Hr
	r+nQR6xFRbTuAniLpf8cIZknua6p4DQP7QSF0dgwt9N6035dTPO7Jw7dgRpyFFulKBOTdZ1Y10uYA
	R4D5MR7arZ5Grupp/FN/AzEYuPHKfvmPnyKVf9CHWc6BrZLTBTar4HmfCqdRNlOuhhUXZiUqWVxmO
	o5nBULTQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRSa3-0000000Gwgx-0uHc;
	Tue, 17 Jun 2025 09:26:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E5433308523; Tue, 17 Jun 2025 11:26:09 +0200 (CEST)
Date: Tue, 17 Jun 2025 11:26:09 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	DietmarEggemann@uudg.org, dietmar.eggemann@arm.com,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RESEND PATCH v4] sched: do not call __put_task_struct() on rt
 if pi_blocked_on is set
Message-ID: <20250617092609.GR1613376@noisy.programming.kicks-ass.net>
References: <aEw-KjUjjP2gYH6z@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEw-KjUjjP2gYH6z@uudg.org>

On Fri, Jun 13, 2025 at 12:05:14PM -0300, Luis Claudio R. Goncalves wrote:
> With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> with a mutex enqueued. That could lead to this sequence:
> 
>         rt_mutex_adjust_prio_chain()
>           put_task_struct()
>             __put_task_struct()
>               sched_ext_free()
>                 spin_lock_irqsave()
>                   rtlock_lock() --->  TRIGGERS
>                                       lockdep_assert(!current->pi_blocked_on);
> 
> Fix that by unconditionally resorting to the deferred call to
> __put_task_struct() if PREEMPT_RT is enabled.
> 

Should this have a Fixes: tag and go into /urgent?

> Suggested-by: Crystal Wood <crwood@redhat.com>
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
> ---
> 
> Resent as a gentle reminder, because this issue results in scary backtraces,
> not obvious to debug and pinpoint root cause.
> 
> v2: (Rostedt) remove the #ifdef from put_task_struct() and create
>     tsk_is_pi_blocked_on() in sched.h to make the change cleaner.
> v3: (Sebastian, PeterZ) always call the deferred __put_task_struct() on RT.
> v4: Fix the implementation of what was requested on v3.
> 
>  include/linux/sched/task.h |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
> index 0f2aeb37bbb04..51678a541477a 100644
> --- a/include/linux/sched/task.h
> +++ b/include/linux/sched/task.h
> @@ -134,11 +134,8 @@ static inline void put_task_struct(struct task_struct *t)
>  	if (!refcount_dec_and_test(&t->usage))
>  		return;
>  
> -	/*
> -	 * In !RT, it is always safe to call __put_task_struct().
> -	 * Under RT, we can only call it in preemptible context.
> -	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> +	/* In !RT, it is always safe to call __put_task_struct(). */
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
>  
>  		lock_map_acquire_try(&put_task_map);
> @@ -148,11 +145,13 @@ static inline void put_task_struct(struct task_struct *t)
>  	}
>  
>  	/*
> -	 * under PREEMPT_RT, we can't call put_task_struct
> +	 * Under PREEMPT_RT, we can't call __put_task_struct
>  	 * in atomic context because it will indirectly
> -	 * acquire sleeping locks.
> +	 * acquire sleeping locks. The same is true if the
> +	 * current process has a mutex enqueued (blocked on
> +	 * a PI chain).
>  	 *
> -	 * call_rcu() will schedule delayed_put_task_struct_rcu()
> +	 * call_rcu() will schedule __put_task_struct_rcu_cb()
>  	 * to be called in process context.
>  	 *
>  	 * __put_task_struct() is called when
> @@ -165,7 +164,7 @@ static inline void put_task_struct(struct task_struct *t)
>  	 *
>  	 * delayed_free_task() also uses ->rcu, but it is only called
>  	 * when it fails to fork a process. Therefore, there is no
> -	 * way it can conflict with put_task_struct().
> +	 * way it can conflict with __put_task_struct().
>  	 */
>  	call_rcu(&t->rcu, __put_task_struct_rcu_cb);
>  }
> 
> ----- End forwarded message -----
> 
