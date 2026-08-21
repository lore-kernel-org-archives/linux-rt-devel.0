Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27BB48C8BB
	for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312779; cv=none; b=OwQAZS1C1hPIVUOX/8KOneEsvXctllJYOgxHS5XDsqjJaQ9qdz8w1vrjzdZkawVu/hSCjSe94RE18bF0eyT/Wekb0Gn8PxSTq7GodkN+r++pZzXgBDon9Pmv4/M5CJ5BzBv3oZPh+cy7uNoNwzvRLU4a4XbbKvvteDIzWW4rZtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312779; c=relaxed/simple;
	bh=iywtAefJH0cp2WybM/S8fmGeCE9JjoLPwGt8j0B0bos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNd5VWuTw1ngYOLLYDPAnKveEsW9wrHZVQc0Ewxx954nP7FyqnPpnZRemPwuyxqwEdShGJMuDP5BDNciOg4rweJ/XlY0Y9MVRmnC5ne5T/G0FB43rjSF9TacYt6yG1WO/NSFW9epjRGv5IqgFxXDMOg2K0UVraBnKpgh/Bfd5eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gpjo2aby; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gpjo2aby"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so1828514a12.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 21 Aug 2026 04:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1787312774; x=1787917574; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=c1MWicBPO6iNH4zdYEFKHlPXKcGPe09DuWRp2ts42Yg=;
        b=gpjo2abyUj0x4cbBJVtO3NJ/qM8M73FJhxjNgboSDdC7DZK+wC23FHZBfDbhd5CjVF
         m4s1PtdZIntGesjbr+Zfw3CsAA4TiOMti3i4EOUfWINSwGjeuMLPobR3gHpBZg3ISxrW
         oaYOaQOgVKEu8aMdIZw4T1l8kvcKDf5xxbJic2jL+Ab4GnQN+gc7DuD3x/wX+RGbfN3Z
         Gqy1whmnQr4wr4xYo6Rv+FTqqcYWv1SbqHjQFruVBCmk7f/T6eS6UP8bV0l5YcFA4iuD
         x7PGtxmpIrY3i9jM1F+2UQOCXCTnLZ0p49seOaKLZJpC8hry/2HHi/cQv9P9O1uDeenD
         4wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312774; x=1787917574;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c1MWicBPO6iNH4zdYEFKHlPXKcGPe09DuWRp2ts42Yg=;
        b=ahLRO4BhzINhiWRb3+5+dLu6k2eBzSQjMHmF1wUhnGK9Sgo9r5gHU7YLB5O7YELqNL
         uwS1cEPUmW90oHP0b7aWiibEMn6H9VddqECvwmK7H9rVlV8qMgYhTUcl+TmttlUxAFgY
         KaZFZhGYr9562MVJ3kyQDmQ2zO0QYpinSuTLgwTGySTvSnitZgLwrG737/OEYBw5WYbz
         CL6cJ1rgNxTdy8gVAboC281GWJ2ynhOBm8riBJDu3yg30dZ+jyqoXd/mkBPVnN/MctmX
         H8wT5rYAVD+8U5S7F4et5c7yOGoJrLpXTSyOr7UIP6CuWYLqxypYIt+FpcP30pFopnnV
         Gb3Q==
X-Forwarded-Encrypted: i=1; AHgh+RpS/Q7+rRn8+wl2tgxDncjOz9IDB+O7AldsZbpEP7CGnWP9RR/pVxoEJ2Qs0t4MMFIQW1HOEKJorRFhhUh7lg==@lists.linux.dev
X-Gm-Message-State: AFuF++mpRNXokR1JXoRA3pzKoiNenZlqLq5wvauG176d6/h5FnA3qQYj
	pS+C6d7YLFUjr7maNm7Y9fzPIz181Ks7gYtif8FDUjHfMuU5fZX29kcJ77U5fQ6Bz1k=
X-Gm-Gg: AR+sD11UItglt+Mtqmb0bRiEu+XnX+uDE9KrH7HEhjdwoB96dJFoT3cUFNsAKo7epKB
	8RBVUC+MTnP6ZHK/LbekDIP3ByHWM0WmAQtBjDTXuwPL5pGh1iPBNCExFYrOT2SEOcP5p+2wonO
	ASnuXqU8YEJnbk5tXrYzyUaapdZfHEu55+KQuvtmxlkwSyglqFrh4if4hLkd2yNvh8KPOgIh/7W
	sp6B2d5z3e/I225pAkcI+iQ2niNxpykkM3KPISxAPCKS9s2OXYK2NpIRvV5J/22+uUjshkt5QSC
	0OzvP9/WQ0CqKNlQ8pbyc+Kq78fC9GDE9puu4b5cczmn538uQVckFaOFp/LfMV3zQVIBW1dP7WH
	fJj8MzJs8glnvq+PnPQyRH+6W8Qz/zPbILc2BtzliGJuMRNL/n/C8Eg47Hx+UFMoT6v2egHfPVp
	a9cixBNB+POQ0DicaGazRvJG1T9WL85Drz4HCpbgRj8MVLcfVTO3NrMlCJjCoZ+KrlMQAC5DTgw
	w==
X-Received: by 2002:a05:6402:2353:b0:6a1:f95b:8cef with SMTP id 4fb4d7f45d1cf-6a42f179014mr5348858a12.4.1787312768371;
        Fri, 21 Aug 2026 04:46:08 -0700 (PDT)
Received: from localhost (109-81-81-112.rct.o2.cz. [109.81.81.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c327asm6269903a12.8.2026.08.21.04.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:46:08 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:46:06 +0200
From: Michal Hocko <mhocko@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ben Segall <bsegall@google.com>, Boqun Feng <boqun@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Sean Young <sean@mess.org>, Steven Rostedt <rostedt@goodmis.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] sched: Allow sleeping spinlocks on PREEMPT_RT within
 non_block_start()/end block.
Message-ID: <aog6fr80a2buniSZ@tiehlicka>
References: <20260821095755.am1-Segb@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260821095755.am1-Segb@linutronix.de>

On Fri 21-08-26 11:57:55, Sebastian Andrzej Siewior wrote:
> Commit 312364f3534cc ("kernel.h: Add non_block_start/end()") added
> non_block_star()/end(). The intention was to catch any callbacks which
> depend on locks or sleep able conditionals in order to ensure forward
> progress. According to the commit message spinlocks were excluded
> "because spinlocks can't have an indirect dependency upon the page
> allocator…".
> On PREEMPT_RT this leads to a splat because spinlock_t and rwlock_t are
> turned into a sleeping spinlock which have a might_sleep() as they could
> schedule() on lock contention.
> 
> Besids mm, the other used of non_block_start() is pwm. Here the hrtimer
> can acnqure a spinlock_t on RT and I can't tell other user but I assume
> it is not atomic on RT since it wouldn't be able to acquire its own
> (spinlock_t) lock.
> 
> Since spinlock_t (and rwlock_t) are not problem, add a sleeping_lock
> argument to __might_resched() signaling if this is scheduling request
> is from a sleeping lock (true) or regular scheduling request (false).
> Add the `true' argument to rtlock_might_resched() which is used on
> PREEMPT_RT for both sleeping lock types.

This definitely makes a lot of sense to me. It looks like a
straightforward solution for false positives. The patch looks good to
me, I do not feel qualified to give you Acked-by though.

Thanks!
 
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Sean Young <sean@mess.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/kernel.h       |  5 +++--
>  include/linux/sched.h        | 24 ++++++++++++------------
>  kernel/locking/spinlock_rt.c |  2 +-
>  kernel/sched/core.c          |  7 ++++---
>  4 files changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index e5570a16cbb1a..fbafdfe9bdb78 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -70,7 +70,8 @@ extern int dynamic_might_resched(void);
>  #endif /* CONFIG_PREEMPT_* */
>  
>  #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
> -extern void __might_resched(const char *file, int line, unsigned int offsets);
> +extern void __might_resched(const char *file, int line, unsigned int offsets,
> +			    bool rt_sleeping_lock);
>  extern void __might_sleep(const char *file, int line);
>  extern void __cant_sleep(const char *file, int line, int preempt_offset);
>  extern void __cant_migrate(const char *file, int line);
> @@ -128,7 +129,7 @@ extern void __cant_migrate(const char *file, int line);
>  # define non_block_end() WARN_ON(current->non_block_count-- == 0)
>  #else
>    static inline void __might_resched(const char *file, int line,
> -				     unsigned int offsets) { }
> +				     unsigned int offsets, bool rt_sleeping_lock) { }
>  static inline void __might_sleep(const char *file, int line) { }
>  # define might_sleep() do { might_resched(); } while (0)
>  # define cant_sleep() do { } while (0)
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 373bcc0598d10..650e42d55e1e8 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -2158,9 +2158,9 @@ static inline int _cond_resched(void)
>  
>  #endif /* !CONFIG_PREEMPTION || CONFIG_PREEMPT_DYNAMIC */
>  
> -#define cond_resched() ({			\
> -	__might_resched(__FILE__, __LINE__, 0);	\
> -	_cond_resched();			\
> +#define cond_resched() ({				\
> +	__might_resched(__FILE__, __LINE__, 0, false);	\
> +	_cond_resched();				\
>  })
>  
>  extern int __cond_resched_lock(spinlock_t *lock) __must_hold(lock);
> @@ -2186,19 +2186,19 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock) __must_hold(lock);
>  	(PREEMPT_LOCK_OFFSET + (1U << MIGHT_RESCHED_RCU_SHIFT))
>  #endif
>  
> -#define cond_resched_lock(lock) ({						\
> -	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
> -	__cond_resched_lock(lock);						\
> +#define cond_resched_lock(lock) ({							\
> +	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS, false);	\
> +	__cond_resched_lock(lock);							\
>  })
>  
> -#define cond_resched_rwlock_read(lock) ({					\
> -	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
> -	__cond_resched_rwlock_read(lock);					\
> +#define cond_resched_rwlock_read(lock) ({						\
> +	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS, false);	\
> +	__cond_resched_rwlock_read(lock);						\
>  })
>  
> -#define cond_resched_rwlock_write(lock) ({					\
> -	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS);	\
> -	__cond_resched_rwlock_write(lock);					\
> +#define cond_resched_rwlock_write(lock) ({						\
> +	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_RESCHED_OFFSETS, false);	\
> +	__cond_resched_rwlock_write(lock);						\
>  })
>  
>  #ifndef CONFIG_PREEMPT_RT
> diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
> index 1d5e1b3c60bfa..0a89e7f10af18 100644
> --- a/kernel/locking/spinlock_rt.c
> +++ b/kernel/locking/spinlock_rt.c
> @@ -33,7 +33,7 @@
>  	(rcu_preempt_depth() << MIGHT_RESCHED_RCU_SHIFT)
>  
>  #define rtlock_might_resched()						\
> -	__might_resched(__FILE__, __LINE__, RTLOCK_RESCHED_OFFSETS)
> +	__might_resched(__FILE__, __LINE__, RTLOCK_RESCHED_OFFSETS, true)
>  
>  static __always_inline void rtlock_lock(struct rt_mutex_base *rtm)
>  {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 96226707c2f61..ee0fbb41fc61c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9123,7 +9123,7 @@ void __might_sleep(const char *file, int line)
>  			(void *)current->task_state_change,
>  			(void *)current->task_state_change);
>  
> -	__might_resched(file, line, 0);
> +	__might_resched(file, line, 0, false);
>  }
>  EXPORT_SYMBOL(__might_sleep);
>  
> @@ -9148,7 +9148,8 @@ static inline bool resched_offsets_ok(unsigned int offsets)
>  	return nested == offsets;
>  }
>  
> -void __might_resched(const char *file, int line, unsigned int offsets)
> +void __might_resched(const char *file, int line, unsigned int offsets,
> +		     bool rt_sleeping_lock)
>  {
>  	/* Ratelimiting timestamp: */
>  	static unsigned long prev_jiffy;
> @@ -9159,7 +9160,7 @@ void __might_resched(const char *file, int line, unsigned int offsets)
>  	rcu_sleep_check();
>  
>  	if ((resched_offsets_ok(offsets) && !irqs_disabled() &&
> -	     !is_idle_task(current) && !current->non_block_count) ||
> +	     !is_idle_task(current) && (rt_sleeping_lock || !current->non_block_count)) ||
>  	    system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
>  	    oops_in_progress)
>  		return;
> -- 
> 2.55.0

-- 
Michal Hocko
SUSE Labs
