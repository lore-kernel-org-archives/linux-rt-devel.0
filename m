Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210735;
	b=5pg4brsWxoR/bYEmKR8ja2E1vuTHjOHQ7cBipXt4TuIq9AyKy/KdyTPT24FRyDNmnExv
	 aFaAuiIXjksMh+RSlVSWgADY4Lpcbh2lm0m5Bj2Gvt2E1kOYjQ68G5uU2W/jVyrcBFiT/
	 4zmQ/X6++GgTlNNqpBKOfFok273mRLpT1aChzeCVppwLMHr6DPVDIP0XgBGNsR1ARUG5X
	 bxfPkjwVtdhzqL1QDFfWFrtFTonDWX7pzKqmKDLCWOnpdjCZ1MPJMcb4U+Gway4aE5HSE
	 PVX0AMQ6AXdnLlRoxpm6Qk2jnbJHve9gMPsFWUuX/aOsqqwHfPMAc6mVsq35EDrHLag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210735;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H3YGOD4xuDKxYeyRunaEVKbNSGBgrL7HGU/fsPpnD8g=;
	b=B0UzTCPzhEbc5lFXuUas5wCLBapnhJqUVjWsupqq2ZOWrR+E55+lI406QMXzal0haMgC
	 LaipxA68VWCJOgIXIwpxQZprIVtRkzGFjPgMsq/slb30KD+X0WMlcx3o2Ds9bZzbWLOE8
	 wrxrl9RFWXEG3vEIqdmU8POZyCzgpxPAZ0bhRjkHJ1dMSIa44OKSFjKdDIrvPxiKAB4Ds
	 6uq/7KsE0PmdAudMHJaJjWhDEfXmMcqSKbfqdgSAqzrWRuP8969IzyWiZ/31TOsjq0Sed
	 BayZs4nL7ssNyInr7xpXRxvz9MBofiSB3nqqAilFU/64hu/WpQPpakCe+oRvNnC9IUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUkm8R07;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E50D606A683;
	Fri, 20 Nov 2026 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MUkm8R07
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A2E1F000CF;
	Fri, 20 Nov 2026 21:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210734;
	bh=H3YGOD4xuDKxYeyRunaEVKbNSGBgrL7HGU/fsPpnD8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MUkm8R07Zq7ejqqOus4ZZpSpOGC0ztvoGcR8cF/DwNjpQy6MKM4lr2gCdt2b943EK
	 zMTfInPYGc83TTBboJS5yvt2T6kY6ILDgtmMJPyBOSwZsXMkmz9zhK6nGcr7/Lpn1O
	 ZrVjKJckBNfnqEuVVGVRqL13OUY1C/4bihZndcujVm3mIrnI7xVSISCSzIy6EDatQC
	 EvZa6ez3jdHahHmZ+nerY51K8fOUtwtmHZDzTNu7QGzWF0RD5jBqJji2Hw+iged339
	 ZUwHwmnO5SrOh9/9iuN/aJJz7iIFaesjGqXvYjg1UkHXIK1SnpnN0EN6TsAI5gp6YU
	 APsYAu8kKtmnw==
Message-ID: <sashiko-outbox-226204@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 35/40] sched/deadline: Check the runtime of a task
 whose parameters change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <f0f5e657ac6bccc75297da3739df812adda360b2.1795207233.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <f0f5e657ac6bccc75297da3739df812adda360b2.1795207233.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:38:53 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] sched/deadline: dl_proxy_block() misses dl_new_params check
  on PI futex requeue
- [Medium] sched/deadline: missing PI boost when update_dl_entity()
  pushes owner deadline
- [Low] sched/deadline: __setparam_dl() skips dl_new_params on
  same-param re-entry
--

commit a68761d066fed61088f4cef94943c4d4d24b8d1f
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Check the runtime of a task whose parameters change

This commit tracks deadline parameter changes in dl_new_params so that
the remaining runtime is checked against the new reservation at the next
enqueue, at deboost, or immediately when blocked on an rt_mutex.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 83aefe5ab671c..fe48137509ad8 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -145,12 +177,41 @@ void dl_deboost(struct sched_dl_entity *dl_se)
>  		}
>  	}
>  	dl_drop_boost(dl_se);
> +
> +	if (!task_on_rq_queued(p) && !dl_task_pi_blocked(p))
> +		return;
> +	if (dl_se->dl_new_params && !dl_se->dl_throttled && dl_in_constrained_g=
ap(dl_se))
> +		return;
> +	if (dl_se->dl_new_params) {
> +		dl_se->dl_new_params =3D 0;
> +		if (!dl_se->dl_throttled)
> +			update_dl_entity(dl_se);
> +	}
>  }
> =20
> -/* Return true if @p waits on an rt_mutex. The caller holds its pi_lock.=
 */
> -static inline bool dl_task_pi_blocked(struct task_struct *p)
> +/*
> + * Check the runtime of @p against the parameters that sched_setattr() j=
ust
> + * gave it, if @p waits on an rt_mutex. Before any wakeup, its waiter no=
de
> + * holds its deadline. The caller then calls rt_mutex_adjust_pi(), which
> + * requeues the waiter with the result. Other changes of @p, such as a
> + * cgroup move, do not requeue it: leave the check to sched_setattr().
> + *
> + * A boosted task, a throttled one, or one past its deadline and before
> + * its next period keeps the mark. Its deboost or its wakeup checks it.
> + * The caller holds the rq lock and the pi_lock of @p, and has updated t=
he
> + * rq clock.
> + */
> +void dl_check_blocked_params(struct task_struct *p)
>  {
> -	return p->pi_blocked_on;
> +	struct sched_dl_entity *dl_se =3D &p->dl;
> +
> +	if (!dl_task(p) || task_on_rq_queued(p) || !dl_task_pi_blocked(p))
> +		return;
> +	if (dl_se->dl_new_params && !is_dl_boosted(dl_se) &&
> +	    !dl_se->dl_throttled && !dl_in_constrained_gap(dl_se)) {
> +		dl_se->dl_new_params =3D 0;
> +		update_dl_entity(dl_se);
> +	}
>  }

[Severity: Medium]
Should dl_proxy_block() also check and clear dl_se->dl_new_params?

When a task sleeps in futex(FUTEX_WAIT_REQUEUE_PI), p->pi_blocked_on is
NULL, so dl_check_blocked_params() returns early and leaves
dl_se->dl_new_params set.  If futex(FUTEX_CMP_REQUEUE_PI) then requeues
the task onto an rt_mutex before its old deadline expires,
task_blocks_on_rt_mutex() calls dl_proxy_block() before copying
p->dl.deadline into the waiter node:

kernel/sched/deadline.c:dl_proxy_block() {
	...
	if (!task_on_rq_queued(p) && !dl_se->dl_throttled &&
	    dl_time_before(dl_se->deadline, rq_clock(rq)) &&
	    (dl_is_implicit(dl_se) ||
	     !dl_time_before(rq_clock(rq), dl_next_period(dl_se))))
		replenish_dl_new_period(dl_se, rq);
	...
}

Because dl_proxy_block() only checks whether dl_se->deadline has passed,
a task whose reservation was shrunk while sleeping in
FUTEX_WAIT_REQUEUE_PI is queued on the rt_mutex (and boosts the lock
owner) with its stale earlier deadline, allowing it to acquire the lock
ahead of waiters with earlier deadlines.  Even when the old deadline has
passed and dl_proxy_block() starts a new period, it leaves
dl_se->dl_new_params set, so a later boost and deboost while blocked
calls update_dl_entity() a second time.

[ ... ]

> @@ -5179,6 +5261,11 @@ void __setparam_dl(struct task_struct *p, const st=
ruct sched_attr *attr)
>  	u64 period =3D attr->sched_period ?: attr->sched_deadline;
>  	bool held;
> =20
> +	if (attr->sched_runtime !=3D dl_se->dl_runtime ||
> +	    attr->sched_deadline !=3D dl_se->dl_deadline ||
> +	    period !=3D dl_se->dl_period)
> +		dl_se->dl_new_params =3D 1;
> +

[Severity: Low]
Can __setparam_dl() leave dl_se->dl_new_params unset when a task leaves
SCHED_DEADLINE before its 0-lag time and later re-enters the class with
the same parameters?

When a task leaves SCHED_DEADLINE before its 0-lag time,
switched_from_dl() leaves dl_runtime, dl_deadline and dl_period in
dl_se until inactive_task_timer() runs __dl_clear_params().  If the task
was PI-boosted back into dl_sched_class before the 0-lag time (without
refilling from the donor), or if sched_setattr() races with
inactive_task_timer() right after the 0-lag time while the task is
blocked on an rt_mutex, calling sched_setattr() to restore
SCHED_DEADLINE with identical parameters sees no change in dl_runtime,
dl_deadline or dl_period and does not set dl_se->dl_new_params.
switched_to_dl() then cancels inactive_timer without starting a new
period if dl_se->deadline has not passed, and neither
dl_check_blocked_params() nor dl_deboost() checks the remaining runtime
against the new reservation.

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 9884fa55538ac..b25504e8748be 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -311,6 +311,9 @@ static inline void __setscheduler_dl_pi(int newprio, =
int policy,
>  	 */
>  	if (!dl_prio(newprio))
>  		dl_drop_boost(&p->dl);
> +
> +	/* rt_mutex_adjust_pi() then requeues the waiter of a blocked task. */
> +	dl_check_blocked_params(p);
>  }
>  #else /* !CONFIG_RT_MUTEXES */
>  static inline void __setscheduler_dl_pi(int newprio, int policy,

[Severity: Medium]
What happens if p owns an rt_mutex with a deadline waiter whose deadline
was later than p's old deadline, and shrinking p's reservation pushes
p->dl.deadline past that waiter's deadline?

In __setscheduler_dl_pi(), rt_mutex_get_top_task(p) is only checked when
!dl_policy(policy):

kernel/sched/syscalls.c:__setscheduler_dl_pi() {
	if (dl_prio(newprio) && !dl_policy(policy)) {
		struct task_struct *pi_task =3D rt_mutex_get_top_task(p);

		if (pi_task) {
			dl_set_donor(&p->dl, pi_task);
			scope->flags |=3D ENQUEUE_REPLENISH;
		}
	}
	...
}

When an unboosted deadline task p stays in SCHED_DEADLINE and shrinks
its reservation, update_dl_entity() (in dl_check_blocked_params() or in
enqueue_dl_entity() during sched_change_end()) can start a new period
and move p->dl.deadline after its top waiter's deadline.  Unlike
rt_mutex_setprio(), which rechecks whether pi_task preempts p after
dl_deboost() updates p->dl, __sched_setscheduler() never boosts p with
its top waiter.  If p is running, it will throttle when its reduced
runtime expires while holding the lock instead of running on the
waiter's donor parameters; if p is blocked on another rt_mutex,
rt_mutex_adjust_pi() will propagate p's own unboosted deadline up the PI
chain instead of the waiter's.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D35
