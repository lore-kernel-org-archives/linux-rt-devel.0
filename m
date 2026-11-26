Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659433;
	b=dE2Ea2DL0U/wUGLgs9V4R1+MbwvHC+075ysHAP7v28f58uQOxkCVEzsNyhK1/Ov3CREv
	 AbHcU8zRgX4LAcGY9BXpX1k7p1pLp3z55fUnblg6FUhVXaayXZZAvoZpgWJnWVDQQzU99
	 vt2nblx5mCaCW77i9RePOv2/6DC+av9o/GULSGsVKmo+xUFQRN8Sbc0iK7O3n8tODq8Rp
	 mlOmiMXEt/ju0GSrCuDHTjWyhKGcOtDV/DwQsFP4P4tyy5p8K03b1UxgA6kABL83VGwkm
	 yGYBe+dVmhXP6Su0Xv/pfRoB9s6qN/nSa+8YpVdFsPwY955pMeqIP6r7UmEOu5cuaNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659433;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=llnG6wS+EwxhQTswiQYG7fffBB/zehlOVLMwXSWNDqU=;
	b=zXhwhv+LzxKFIHUN4aB1zRgkyyJhLZIdY5Nkg6wtrYzELNpEatoQMRDjdt9Ie5j3Csjn
	 iuzLIaVQO8wtomfjwe+IIzB4AF6kmH/ijEcGxOk01jRA2/r4FrVAeTxpTE+hnk5VojHHb
	 si89SSZiislfHNmkNN0X+ul6Ow0ULrRa8sB3nRh6w9l0Sbw+7QdVNGm85ORfow90/BFQn
	 EHM4o7zq7ZuJDNOIs8cKA3KSYanaURx+D2had1g0tffWCKKjEoq/+JJO6tY0CN+EWF5d0
	 SHiTKc/v3vD+hASGH63n9M0H3m9B4M5pAMeyQClsr/0jJEgM/MOItGctRLAm/Xut/vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Trp4FQVo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C0606A31E;
	Thu, 26 Nov 2026 02:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Trp4FQVo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACFA1F000C6;
	Thu, 26 Nov 2026 02:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795659432;
	bh=llnG6wS+EwxhQTswiQYG7fffBB/zehlOVLMwXSWNDqU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Trp4FQVojrxXBOm/0siTNDjMk6yLCyaTaiSKXHfFcM0+vToh76XFYVug1VyGNoQGT
	 cEyE5nINYXZB0aNtVzWlrQXEJwg6hWSYq+PkubNNP3b8MCac7g7dB+lPLa8Rnl73Yy
	 sLqGrhxy1G4Jrn8wvzQFfU3fUG0kVmXArU6WHKeaSs9MObw/NXJZxsCCCVRHOjwBlF
	 /gkvuGEK4cUjt+Uu5Q8JAEEV74HkplhxHYhZXbGEc7TzxSt7cEIdKmbodj0GKXqMcD
	 PvYzi5r+hqViiJuC8Xk+hkUbH0KwCm6WmhwldzkcQ/izzyAKjdAQPus9a9qv2+l286
	 NhJcWlnyPqc/A==
Message-ID: <sashiko-outbox-234634@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 38/43] sched/deadline: Boost an owner that cannot
 run on its own reservation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <29af731a1e529469abd92e902bcc8126f8cbe972.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <29af731a1e529469abd92e902bcc8126f8cbe972.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 02:17:11 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 10 potential
issues to consider:
- [High] sched/deadline: self-donor cycle after policy change skips
  enqueue_dl_entity()
- [Medium] sched/deadline: mismatched donor parameters in
  dl_boost_donor_period()
- [Medium] sched/deadline: missed deadline update on donor change in
  rt_mutex_setprio()
- [Medium] sched/deadline: inconsistent throttle state after
  dl_end_held_boost()
- [Medium] sched/deadline: stale or expired deadline propagated on
  rt_mutex PI chains
- [Medium] sched/deadline: stale past deadline kept when boosting
  unqueued owner
- [Medium] sched/deadline: dl_waiter_boosts() ignores positive
  own_runtime on held boost
- [Medium] sched/deadline: deboost of sleeping constrained task wastes
  period and runtime
- [Medium] sched/deadline: dl_end_held_boost() zeroes negative
  own_runtime overrun debt
- [Medium] sched/deadline: rt_mutex_setprio() skips dl_boost_start() for
  departed task
--

commit 32b5d84720d53a30b294628db937bed83d5c70cf
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Boost an owner that cannot run on its own reservation

This commit updates SCHED_DEADLINE priority inheritance so that a lock owner
that is throttled or in its constrained deadline gap is boosted and runs on=
 a
donor period, while preserving and resuming the donor period across
repeated boosts.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fa032d6dc873a..c1e043d27b67c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7961,9 +7961,9 @@ void rt_mutex_setprio(struct task_struct *p, struct=
 task_struct *pi_task)
>  		 * 1. -rt task is running and holds mutex A
>  		 *      --> -dl task blocks on mutex A
>  		 *
> -		 * 2. -dl task is running and holds mutex A
> -		 *      --> -dl task blocks on mutex A and could preempt the
> -		 *          running task
> +		 * 2. -dl task holds mutex A
> +		 *      --> -dl task blocks on mutex A, and dl_waiter_boosts()
> +		 *          returns true for it
>  		 */
>  		if (dl_prio(prio)) {
>  			/*
> @@ -7975,13 +7975,27 @@ void rt_mutex_setprio(struct task_struct *p, stru=
ct task_struct *pi_task)
>  			if (!dl_prio(p->normal_prio) ||
>  			    (pi_task && dl_prio(pi_task->prio) &&
>  			     !(p->dl.dl_new_params && p->dl.pi_se !=3D &p->dl) &&
> -			     dl_entity_preempt(&pi_task->dl, &p->dl))) {
> +			     dl_waiter_boosts(p, pi_task))) {
>  				struct sched_dl_entity *old_donor =3D p->dl.pi_se;
> =20
> -				dl_set_donor(&p->dl, pi_task);
> -				scope->flags |=3D ENQUEUE_REPLENISH;
> -				if (!scope->queued && p->dl.pi_se !=3D old_donor)
> -					dl_boost_blocked(p);
> +				if (!dl_set_donor(&p->dl, pi_task)) {
> +					/*
> +					 * The donor of the top waiter is @p: @p waits
> +					 * on a lock that it owns. End the boost of a
> +					 * deadline task, as a deboost does. Another
> +					 * task keeps its donor: a deboost would leave
> +					 * it in the class with no parameters.
> +					 */
> +					if (dl_prio(p->normal_prio) && old_donor !=3D &p->dl)
> +						dl_deboost(&p->dl);
> +				} else {
> +					if (dl_prio(p->normal_prio) &&
> +					    old_donor =3D=3D &p->dl && p->dl.pi_se !=3D &p->dl)
> +						dl_boost_start(&p->dl);

[Severity: Medium]
Does gating dl_boost_start(&p->dl) on dl_prio(p->normal_prio) skip holding
the boost for a departed deadline task that still carries its own parameters
until its 0-lag time?

When a SCHED_DEADLINE task leaves the class while throttled or in its
constrained gap, it keeps its non-zero p->dl.dl_runtime and
p->dl.dl_throttled state until inactive_timer fires.  If a deadline waiter
boosts it back into dl_sched_class while !dl_prio(p->normal_prio),
dl_boost_start() is skipped here.  Although commit "sched/deadline: Run a
boost held at its first refill on a donor period" later in this series rout=
es
runnable refills through dl_hold_refilled_boost(), an unqueued throttled
departed task is still not replenished by dl_boost_blocked() or
switched_to_dl(); if it is blocked on another rt_mutex it propagates its
stale deadline along the PI chain, and if it wakes up while boosted before
p->dl.deadline, enqueue_task_dl() clears dl_throttled and update_dl_entity()
enqueues it with runtime <=3D 0.  Since dl_boost_start() already checks
!dl_se->dl_runtime, the dl_prio(p->normal_prio) check here can be dropped.

> +					scope->flags |=3D ENQUEUE_REPLENISH;

[Severity: Medium]
When p is already in a held boost (old_donor !=3D &p->dl) and a new top wai=
ter
with an earlier deadline replaces old_donor, does skipping dl_boost_start()
leave p running on the previous donor's later deadline?

Because p->dl.dl_deadline is non-zero and p still has positive donor runtime
and a future deadline from old_donor, neither replenish_dl_entity() (via
ENQUEUE_REPLENISH) nor dl_boost_blocked() updates p->dl.deadline or
p->dl.runtime to the new donor's reservation.  If an intermediate-deadline
task preempts p, p cannot consume the remaining runtime from old_donor to
trigger a refill, causing priority inversion for the urgent new waiter.

> +					if (!scope->queued && p->dl.pi_se !=3D old_donor)
> +						dl_boost_blocked(p);
> +				}

[Severity: Medium]
When a deadline owner p (with p->dl.dl_deadline !=3D 0) is blocked on anoth=
er
rt_mutex (!scope->queued), can the PI chain walk propagate a stale or
expired p->dl.deadline to the next lock?

Because scope->queued is false, sched_change_end() does not run
enqueue_task_dl(), and dl_boost_blocked() returns early whenever
dl_se->dl_deadline !=3D 0.  If p is boosted while not throttled and not in =
its
constrained gap, dl_boost_start() also returns early, so waiter_update_prio=
()
and dl_waiter_boosts() on the outer lock use p's own deadline instead of the
donor's.  Conversely, if p is deboosted while in its constrained gap and
blocked on an outer lock, dl_end_held_boost() and dl_deboost() restore
p->dl.deadline to own_deadline in the past and set dl_throttled =3D 1, caus=
ing
the chain walk to queue p on the outer lock with an expired deadline that
spuriously boosts the outer lock's owner.

[ ... ]

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 1ec7789e81b86..a526497c099c3 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -126,7 +134,15 @@ static inline bool dl_end_held_boost(struct sched_dl=
_entity *dl_se)
>  					       (dl_se->dl_density *
>  						(dl_se->deadline - now)) >> BW_SHIFT);
>  	} else {
> +		/*
> +		 * A new period lifts the throttle. A task asleep since
> +		 * before the boost still has its replenishment timer armed
> +		 * for its old next period: cancel it.
> +		 */
>  		dl_start_own_period(dl_se);
> +		dl_se->dl_throttled =3D 0;
> +		if (hrtimer_try_to_cancel(&dl_se->dl_timer) =3D=3D 1)
> +			put_task_struct(dl_task_of(dl_se));
>  	}

[Severity: Medium]
If a constrained-deadline task goes to sleep holding a lock with remaining
runtime > 0 and is boosted and deboosted while asleep during or after its
constrained gap, does deboosting it waste its remaining runtime and start a
new period while it is still asleep?

When the boost ends before own_period_start + dl_period, dl_end_held_boost()
zeroes dl_se->runtime (recording false runtime consumption for 0-lag and
sched_setattr() debt calculations) and dl_deboost() throttles the sleeping
task and arms dl_timer, which fires and starts a new period while the task
sleeps.  When the boost ends at or after own_period_start + dl_period,
dl_end_held_boost() calls dl_start_own_period() immediately while the task =
is
asleep.  In both cases, if the task wakes up after the constrained deadline
of that new period, dl_check_constrained_dl() throttles it on wakeup even
though it slept through the entire period.

[ ... ]

> @@ -264,6 +283,13 @@ void dl_deboost(struct sched_dl_entity *dl_se)
>  	if (held && dl_se->runtime <=3D 0) {
>  		struct rq *rq =3D task_rq(p);
> =20
> +		/*
> +		 * The timer can still be armed. enqueue_task_dl() cancels it
> +		 * when it boosts a runnable task, but a task that slept through
> +		 * the boost kept it. sched_setattr() can have moved the task's
> +		 * next period since. Cancel the timer before arming it again.
> +		 */
> +		cancel_replenish_timer(dl_se);
>  		dl_se->dl_throttled =3D 1;
>  		if (!start_dl_timer(dl_se)) {

[Severity: Medium]
Can dl_se->dl_throttled and dl_se->dl_timer be left out of sync with the
runtime restored by dl_end_held_boost()?

There are two cases where the throttle state does not match the restored
period:
1. switched_from_dl() calls dl_end_held_boost(&p->dl) when a task leaves
SCHED_DEADLINE during a held boost, but lacks this re-throttling block; if
the task was runnable during the boost, enqueue_task_dl() cleared
dl_throttled and canceled dl_timer, leaving p with runtime <=3D 0 and
dl_throttled =3D=3D 0 (so returning to SCHED_DEADLINE with identical parame=
ters
before own_deadline enqueues p with runtime <=3D 0 or wraps negative runtime
into an early period).
2. If a task was throttled while asleep (dl_throttled =3D=3D 1, dl_timer ar=
med),
boosted while asleep, and sched_setattr() started a new period in own_* with
own_runtime > 0 via dl_setattr_place() when debt =3D=3D 0, dl_end_held_boos=
t()
takes the now < own_period_start + dl_period branch and restores runtime > 0
without clearing dl_throttled or canceling dl_timer, leaving the deboosted
task throttled with positive runtime.

> @@ -347,6 +373,114 @@ void dl_check_blocked_params(struct task_struct *p)
>  		update_dl_entity(dl_se);
>  	}
>  }
> +
> +/*
> + * Return true if the deadline waiter @pi_task must boost the owner @p,
> + * which has a deadline policy of its own. Compare @pi_task with the
> + * deadline that @p would run on:
> + * - The boost of @p is held: keep it until the next period of @p
> + *   starts. After that, compare with now + dl_deadline.
> + * - @p is not boosted, and cannot run on its own reservation. It is
> + *   throttled, or past its deadline and before its next period. Boost i=
t.
> + * - @p is not boosted, and past its deadline otherwise: its next enqueue
> + *   starts a new period. Compare with now + dl_deadline.
> + * - Else, compare with the deadline of @p.
> + * A special entity (a sugov kthread) always boosts @p.
> + *
> + * The caller holds the rq lock of @p and has updated the rq clock.
> + */
> +bool dl_waiter_boosts(struct task_struct *p, struct task_struct *pi_task)
> +{
> +	struct sched_dl_entity *dl_se =3D &p->dl;
> +	u64 now =3D rq_clock(task_rq(p));
> +
> +	if (dl_entity_is_special(&pi_task->dl))
> +		return true;
> +	if (dl_se->dl_boost_held) {
> +		if (dl_time_before(now, dl_se->own_period_start + dl_se->dl_period))
> +			return true;
> +		return dl_time_before(pi_task->dl.deadline, now + dl_se->dl_deadline);
> +	}

[Severity: Medium]
Does dl_waiter_boosts() keep a held boost when p has positive own_runtime
and an own_deadline earlier than pi_task->dl.deadline?

dl_hold_refilled_boost() also sets dl_boost_held =3D 1 on a wakeup refill w=
hen
the donor's density cannot accommodate p's remaining runtime, saving
own_runtime > 0 with now < own_deadline.  If that early waiter leaves while
a waiter with a deadline later than own_deadline remains, returning true he=
re
keeps p boosted on the later waiter's deadline instead of deboosting p back
to its own earlier deadline and remaining runtime.

> +	if (!is_dl_boosted(dl_se)) {
> +		if (dl_se->dl_throttled || dl_in_constrained_gap(dl_se))
> +			return true;
> +		if (dl_time_before(dl_se->deadline, now))
> +			return dl_time_before(pi_task->dl.deadline,
> +					      now + dl_se->dl_deadline);
> +	}
> +	return dl_entity_preempt(&pi_task->dl, dl_se);
> +}

[Severity: Medium]
When dl_waiter_boosts() boosts an unqueued owner whose deadline is in the
past (dl_time_before(dl_se->deadline, now)) and that is neither throttled
nor in its constrained gap, what updates p->dl.deadline?

Because p is not queued, sched_change_end() does not run enqueue_task_dl();
dl_boost_start() returns early because p is neither throttled nor in its
constrained gap; and dl_boost_blocked() returns early because
p->dl.dl_deadline is non-zero.  As a result, p becomes boosted with
dl_boost_held =3D=3D 0 while p->dl.deadline remains in the past, so subsequ=
ent
dl_waiter_boosts() calls on p and waiter_update_prio() in an rt_mutex chain
walk compare against p's stale past deadline.

> +
> +static bool dl_entity_overflow(struct sched_dl_entity *dl_se, u64 t);
> +
> +/*
> + * Run @dl_se, whose boost is held, on a period of its donor. Resume the
> + * donor period that the last held boost ran on, unless a whole period of
> + * the current donor has passed since it started. A new period at each
> + * boost would give the task one donor runtime per boost. Nothing charges
> + * the donor for that runtime.
> + *
> + * If the deadline of the resumed period has passed, move to its next
> + * period here, with a full donor runtime. A later enqueue would
> + * otherwise start a period from now, which gives a second donor runtime
> + * too early. As in a refill by replenish_dl_entity(), the task can use
> + * that runtime at once, although its period starts in the future.
> + *
> + * Cap the runtime to the donor's density until the deadline, as
> + * update_dl_revised_wakeup() does at the wakeup of a constrained task.
> + */
> +static void dl_boost_donor_period(struct sched_dl_entity *dl_se)
> +{
> +	struct sched_dl_entity *pi_se =3D pi_of(dl_se);
> +	struct rq *rq =3D rq_of_dl_se(dl_se);
> +	u64 runtime =3D READ_ONCE(pi_se->dl_runtime);
> +	u64 period =3D READ_ONCE(pi_se->dl_period);
> +	u64 now =3D rq_clock(rq);
> +
> +	if (dl_se->dl_boost_granted && runtime && period &&
> +	    dl_time_before(now, dl_se->boost_period_start + period)) {
> +		dl_se->period_start =3D dl_se->boost_period_start;
> +		dl_se->deadline =3D dl_se->boost_deadline;
> +		dl_se->runtime =3D dl_se->boost_runtime;
> +		if (!dl_time_before(now, dl_se->deadline)) {
> +			dl_se->period_start +=3D period;
> +			dl_se->deadline +=3D period;
> +			dl_se->runtime =3D runtime;
> +		}
> +		if (dl_entity_overflow(dl_se, now))
> +			dl_se->runtime =3D (READ_ONCE(pi_se->dl_density) *
> +					  (dl_se->deadline - now)) >> BW_SHIFT;
> +		return;
> +	}
> +	replenish_dl_new_period(dl_se, rq);
> +}

[Severity: Medium]
Can dl_boost_donor_period() resume boost_deadline and boost_runtime from a
different donor with incompatible parameters?

dl_end_held_boost() saves boost_deadline, boost_runtime, and
boost_period_start without recording which donor or relative deadline
produced them.  If a previous held boost ran under a donor with a long
relative deadline and large runtime and deboosted, and a more urgent donor
with a shorter dl_deadline and smaller dl_runtime boosts the same owner
before boost_period_start + pi_se->dl_period, dl_boost_donor_period() gives
the owner the old donor's far-future boost_deadline (causing priority
inversion for the urgent waiter) and caps runtime to
(pi_se->dl_density * (boost_deadline - now)) >> BW_SHIFT without capping to
pi_se->dl_runtime, which can grant several multiples of the new donor's
dl_runtime.  Conversely, if the previous boost had a much shorter
boost_deadline that has already passed, advancing dl_se->deadline by
boost_deadline + period instead of dl_se->period_start + pi_se->dl_deadline
sets the new deadline too early and causes dl_entity_overflow() to truncate
the new period's runtime.

> +
> +/*
> + * Call this when @dl_se gets its first donor, after dl_set_donor(). If
> + * @dl_se cannot run on its own reservation, hold the boost from now. Sa=
ve
> + * its deadline, runtime and period start in own_*, and set dl_boost_hel=
d.
> + * Then run it on a period of the donor. A refill would instead add donor
> + * periods to its own deadline. That is often later than the waiter's.
> + *
> + * A task with no parameters of its own has nothing to save. The caller
> + * holds the rq lock and has updated the rq clock.
> + */
> +void dl_boost_start(struct sched_dl_entity *dl_se)
> +{
> +	if (!dl_se->dl_runtime ||
> +	    (!dl_se->dl_throttled && !dl_in_constrained_gap(dl_se)))
> +		return;
> +	/*
> +	 * A yield gave up the rest of the task's own period: save no runtime
> +	 * for it. The yield does not apply to the donor period placed below.
> +	 */
> +	dl_se->own_deadline =3D dl_se->deadline;
> +	dl_se->own_runtime =3D dl_se->dl_yielded ? 0 : dl_se->runtime;
> +	dl_se->own_period_start =3D dl_se->period_start;
> +	dl_se->dl_boost_held =3D 1;
> +	dl_se->dl_yielded =3D 0;
> +	dl_boost_donor_period(dl_se);
> +}

[Severity: Medium]
When dl_boost_start() saves a negative dl_se->runtime from a throttled task
that overran its budget, does dl_end_held_boost() erase that overrun debt if
the boost ends after own_deadline?

In dl_end_held_boost(), when now < own_period_start + dl_period and
!dl_time_before(now, dl_se->deadline) (for example, during the constrained
gap of a constrained-deadline task), dl_se->runtime is unconditionally set
to 0 instead of only clamping positive runtime, forgiving the negative
overrun saved in own_runtime.

[ ... ]

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 4f26601f0530a..165f407f45b34 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -315,10 +315,8 @@ static inline void __setscheduler_dl_pi(int newprio,=
 int policy,
>  	if (dl_prio(newprio) && !dl_policy(policy)) {
>  		struct task_struct *pi_task =3D rt_mutex_get_top_task(p);
> =20
> -		if (pi_task) {
> -			dl_set_donor(&p->dl, pi_task);
> +		if (pi_task && dl_set_donor(&p->dl, pi_task))
>  			scope->flags |=3D ENQUEUE_REPLENISH;
> -		}
>  	}

[Severity: High]
What happens if a SCHED_DEADLINE task p is the root donor in an rt_mutex
lock cycle (so its top waiter pi_task has pi_task->dl.pi_se =3D=3D &p->dl) =
and p
changes its policy to a non-deadline policy?

Because pi_task->prio is deadline priority, rt_effective_prio() keeps p in
dl_sched_class while __setscheduler_params() sets !dl_prio(p->normal_prio).
dl_set_donor(&p->dl, pi_task) then sees pi_se =3D=3D &p->dl and returns fal=
se,
leaving p->dl.pi_se =3D=3D &p->dl (!is_dl_boosted(&p->dl)) and omitting
ENQUEUE_REPLENISH (the same happens in rt_mutex_setprio() if a waiter still
carrying pi_se =3D=3D &p->dl blocks on p after p left SCHED_DEADLINE).  When
sched_change_end() or a later wakeup calls enqueue_task_dl(), it hits the
!is_dl_boosted(dl_se) && !dl_prio(p->normal_prio) early return without
calling enqueue_dl_entity(), leaving p marked TASK_ON_RQ_QUEUED with
rq->nr_running incremented while absent from rq->dl.root.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D38
