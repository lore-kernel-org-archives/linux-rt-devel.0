Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210408;
	b=NKfr8YvLsynJBRqVQGXDwLBFY5Uw1e8VrrIAa/VX1IiMrhyTljkxFRT8r+DuF0JCyyOT
	 P3j8MedE2bEwTJYHoWfyKNibfz3qSkIC2sYQ4r1ZX+EZByeqpuyWs9ElzyPhBcGIenPJb
	 7Pk3/P87YrQw94HNrsyP3W528rNIPmbB50lrkCYrOB89UWSXxh1rDzf6fBCJmG42w4gXS
	 d03w9HwsBG7g4nxbEXViqAwMeS0TeLMK1dqNL/HZxK1OvXeRKtE8UlGjF7QUd6d4B2e0t
	 AQ+2SVoMh4XRL5YwAg9SbsuXmZ/pthZrBLPDMeD0Gbm8OmAijKVu23yPr6LNR3YBpQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210408;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yIELFXgaQqNz0yz+2Y2T0WdEqJZoQcYPn7sw/Ofvrd4=;
	b=L96BvGHalA+xoePEBjkRBnmLI2itpqIEPSO0amSD5pCh/M2Q08Rzs+YxDYAqtdb+YHJH
	 w5FwmHpezZSqdXB+CfjWzkn1gvX6LM4KUDtAHMF7h1Xeat6mEb9HNjo+8Hcs5eW/GL80c
	 KJ4eZjKkX4bxLakcd9EW4VScoRguDTzRZBCTBOWVHkEU72K1YbppFiHQDHlCxowC0gqin
	 U3jF+tXMulSiRDqNW0GPFRM8IGU3FoWZ5/g4/+JpLbc+swU0tU4+Fus9kKYSV8nvPUHoA
	 4JnpveiegjddgUm0XsJw6FJ9e6Fxe+zbi5aSb1kX96VvoeumMHtUR0VUdjwauSypjsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNGGqG+C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D37606A6A8;
	Fri, 20 Nov 2026 21:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNGGqG+C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC331F000C0;
	Fri, 20 Nov 2026 21:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210408;
	bh=yIELFXgaQqNz0yz+2Y2T0WdEqJZoQcYPn7sw/Ofvrd4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jNGGqG+Czpa2Y3sUb3HpT1xYo/3vNbSwEpko7AOLbn4dAW8/3dEQpVC2puy1NZXz5
	 RY2oxyKpR0ZLYmTfGmHvrW6H21hhizZ3I6QgeMK/Pgg8rH0ghGjImNiwa9UFUOn1wm
	 RlzfXV8VFvNHoJuoSCaP+xeXUkf0MRnezEqBA65lpzMJEuFXyT0GFf8dta7fXLYj0Y
	 Fc1DM4N2kfkyBK7H//7xt1wG53EuZiLvVpGKK4OUJ8KXRa38wdU5gE6cdSXUXsUouz
	 HLFXhrjUu64FTfDeIcr8819jtx4mcuo+NVuICHp4yNh5ykG/MT35yZ44jtXuyDoClR
	 NGL+3zdDj86Dw==
Message-ID: <sashiko-outbox-226195@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 38/40] sched/deadline: Boost an owner that cannot
 run on its own reservation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <297755d1d8dde37f65e12a4cd502c6332011f44c.1795207233.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <297755d1d8dde37f65e12a4cd502c6332011f44c.1795207233.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:33:27 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] sched/deadline: missing throttle restoration in dl_deboost()
- [High] sched/deadline: donor period added to own_deadline in
  replenish_dl_entity()
- [Medium] sched/deadline: missing dl_boost_held check in
  switched_from_dl()
- [Medium] sched/deadline: expired own_deadline restored in dl_deboost()
- [Medium] sched/deadline: stale deadline on PI chain in
  dl_boost_blocked()
- [Medium] sched/deadline: missing refill on boosted wakeup in
  enqueue_task_dl()
--

commit 59eba5619dd87ca592a528ffc0286ed100abcecc
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Boost an owner that cannot run on its own reservation

This commit updates deadline priority inheritance so that a deadline
waiter boosts a lock owner that is throttled or past its deadline, saving
and restoring the owner's parameters across the boost when it could not
run on its own reservation.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0dce129b41468..cbe0dfe26de3d 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7974,10 +7974,13 @@ void rt_mutex_setprio(struct task_struct *p, stru=
ct task_struct *pi_task)
>  			if (!dl_prio(p->normal_prio) ||
>  			    (pi_task && dl_prio(pi_task->prio) &&
>  			     !(p->dl.dl_new_params && p->dl.pi_se !=3D &p->dl) &&
> -			     dl_entity_preempt(&pi_task->dl, &p->dl))) {
> +			     dl_waiter_boosts(p, pi_task))) {
>  				struct sched_dl_entity *old_donor =3D p->dl.pi_se;
> =20
>  				dl_set_donor(&p->dl, pi_task);
> +				if (dl_prio(p->normal_prio) && old_donor =3D=3D &p->dl &&
> +				    p->dl.pi_se !=3D &p->dl)
> +					dl_boost_start(&p->dl);
>  				scope->flags |=3D ENQUEUE_REPLENISH;
>  				if (!scope->queued && p->dl.pi_se !=3D old_donor)
>  					dl_boost_blocked(p);

[Severity: Medium]
When p is a deadline task blocked on another rt_mutex (!scope->queued),
does dl_boost_blocked(p) leave p->dl.deadline stale for the rest of the PI
chain walk?

sched_change_end() skips enqueue_task_dl() when !scope->queued, and
dl_boost_blocked() only replenishes tasks with !dl_se->dl_deadline &&
!dl_se->dl_throttled:

kernel/sched/deadline.c:dl_boost_blocked() {
	struct sched_dl_entity *dl_se =3D &p->dl;

	if (!dl_se->dl_deadline && !dl_se->dl_throttled &&
	    dl_task_pi_blocked(p))
		replenish_dl_new_period(dl_se, task_rq(p));
}

When p has its own deadline parameters or is throttled, p->dl.deadline is
not updated to the donor's deadline before rt_mutex_adjust_prio_chain()
calls waiter_update_prio() and dl_waiter_boosts() on the next lock in the
chain, so the boost fails to propagate across nested rt_mutexes.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index e9b3d3ec71d77..ff1c104f6afd8 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -161,21 +165,32 @@ static inline bool dl_task_pi_blocked(struct task_s=
truct *p)
>  void dl_deboost(struct sched_dl_entity *dl_se)
>  {
>  	struct task_struct *p =3D dl_task_of(dl_se);
> -
> +	bool own =3D false;
> +
> +	/* Put back what dl_boost_start() saved. */
> +	if (dl_se->dl_boost_held) {
> +		dl_se->deadline =3D dl_se->own_deadline;
> +		dl_se->runtime =3D dl_se->own_runtime;
> +		dl_se->period_start =3D dl_se->own_period_start;
> +		dl_se->dl_donor_refill =3D 0;
> +		own =3D true;
> +	}

[Severity: High]
When a task that was boosted while throttled (own_runtime <=3D 0) is
deboosted before own_deadline, does restoring own_runtime without restoring
dl_throttled leave the task runnable on dl_rq with exhausted runtime?

When the boost started, enqueue_task_dl() canceled dl_timer and cleared
dl_se->dl_throttled =3D 0.  If the boost ends before own_deadline,
dl_deboost() restores own_deadline and own_runtime <=3D 0 with dl_throttled
still 0, and enqueue_dl_entity() only checks dl_check_constrained_dl() for
past deadlines before calling __enqueue_dl_entity(dl_se).  The exhausted
owner is then enqueued as runnable with its earlier own_deadline,
preventing the woken waiter from preempting it and running beyond its CBS
budget until the next tick.  If dl_new_params was set during the boost,
the subsequent dl_waiter_boosts() and dl_boost_start() check in
rt_mutex_setprio() also sees dl_throttled =3D=3D 0 and misses that the owner
cannot run on its own reservation.

[Severity: Medium]
Should switched_from_dl() also restore own_deadline, own_runtime and
own_period_start when dl_boost_held is set?

If a task boosted with dl_boost_held changes policy to a non-deadline
class while boosted and leaves dl_sched_class at deboost,
rt_mutex_setprio() runs switched_from_dl() and dl_drop_boost() instead of
dl_deboost():

kernel/sched/deadline.c:switched_from_dl() {
	bool own_period =3D p->dl.dl_runtime && p->dl.dl_donor_refill;
    ...
	if (own_period)
		dl_start_own_period(&p->dl);

	if (task_on_rq_queued(p) && p->dl.dl_runtime)
		task_non_contending(&p->dl, false);
}

Because dl_donor_refill was set when the boosted task replenished from its
donor, switched_from_dl() calls dl_start_own_period() and resets runtime
to full dl_runtime instead of restoring the exhausted own_* reservation.
task_non_contending() then sees a 0-lag time of now and releases the
task's root-domain bandwidth immediately instead of waiting until the true
0-lag time of the saved period.

[ ... ]

> @@ -214,6 +229,62 @@ void dl_check_blocked_params(struct task_struct *p)
>  		update_dl_entity(dl_se);
>  	}
>  }
> +
> +/*
> + * Return true if the deadline waiter @pi_task must boost the owner @p,
> + * which has a deadline policy of its own. Compare @pi_task with the
> + * deadline that @p would run on:
> + * - @p is throttled, or past its deadline and before its next period:
> + *   it cannot run on its own reservation. Boost it.
> + * - @p was boosted for that reason: keep the boost until its own next
> + *   period. After that period starts, compare with now + dl_deadline.
> + * - @p is past its deadline otherwise: its next enqueue starts a new
> + *   period. Compare with now + dl_deadline.
> + * - Else, compare with the deadline of @p.
> + * A special entity, such as a sugov kthread, always boosts @p.
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
Once now reaches own_period_start + dl_period, dl_waiter_boosts() compares
pi_task against now + dl_se->dl_deadline, but if it returns false and
triggers a deboost while p is pi-blocked on another rt_mutex, does
dl_deboost() restore the expired own_deadline instead of starting a new
period?

In dl_deboost(), the dl_boost_held branch unconditionally restores
dl_se->deadline =3D dl_se->own_deadline (which is now in the past) and
clears dl_se->dl_donor_refill =3D 0 so dl_start_own_period() is skipped.
When p is blocked on a second rt_mutex (!scope->queued), enqueue_task_dl()
does not run in sched_change_end(), so rt_mutex_adjust_prio_chain() copies
that expired past deadline into p's waiter node on the outer lock and
orders p ahead of waiters with valid future deadlines.  The same expired
own_deadline is also exposed on the outer lock if p is deboosted while
still in the constrained gap and pi-blocked.

> +	if (!is_dl_boosted(dl_se)) {
> +		if (dl_se->dl_throttled || dl_in_constrained_gap(dl_se))
> +			return true;
> +		if (dl_time_before(dl_se->deadline, now))
> +			return dl_time_before(pi_task->dl.deadline,
> +					      now + dl_se->dl_deadline);
> +	}
> +	return dl_entity_preempt(&pi_task->dl, dl_se);
> +}
> +
> +/*
> + * Call this when @dl_se gets its first donor, after dl_set_donor()
> + * installed it. If @dl_se cannot run on its own reservation, save its
> + * deadline, runtime and period start in own_*. Then set dl_boost_held.
> + * dl_deboost() puts them back. A task with no parameters of its own has
> + * nothing to save. The caller holds the rq lock and has updated the rq
> + * clock.
> + */
> +void dl_boost_start(struct sched_dl_entity *dl_se)
> +{
> +	if (!dl_se->dl_runtime ||
> +	    (!dl_se->dl_throttled && !dl_in_constrained_gap(dl_se)))
> +		return;
> +	dl_se->own_deadline =3D dl_se->deadline;
> +	dl_se->own_runtime =3D dl_se->runtime;
> +	dl_se->own_period_start =3D dl_se->period_start;
> +	dl_se->dl_boost_held =3D 1;
> +}

[Severity: Medium]
If an owner is throttled while going to sleep, boosted while asleep, and
then wakes up before own_deadline while still boosted, does
enqueue_task_dl() fail to replenish it from the donor?

When the boost happens while !scope->queued, ENQUEUE_REPLENISH is not
consumed by sched_change_end().  On the subsequent wakeup,
enqueue_task_dl(rq, p, ENQUEUE_WAKEUP) cancels dl_timer and clears
dl_se->dl_throttled =3D 0 without setting ENQUEUE_REPLENISH, so
enqueue_dl_entity() calls update_dl_entity(dl_se):

kernel/sched/deadline.c:update_dl_entity() {
    ...
	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
	    dl_entity_overflow(dl_se, rq_clock(rq))) {
    ...
		replenish_dl_new_period(dl_se, rq);
	}
}

Because rq_clock(rq) < own_deadline and dl_se->runtime <=3D 0 makes left <=
=3D 0
while right > 0 in dl_entity_overflow(), both checks are false and
replenish_dl_new_period() is skipped, enqueuing the boosted owner with
runtime <=3D 0 and its old own_deadline instead of the donor's parameters.

[ ... ]

> @@ -1443,7 +1514,13 @@ static void replenish_dl_entity(struct sched_dl_en=
tity *dl_se)
>  	 * entity.
>  	 */
>  	if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
> -		printk_deferred_once("sched: DL replenish lagged too much\n");
> +		/*
> +		 * dl_waiter_boosts() boosts an owner past its deadline. Its
> +		 * deadline is then expected to be in the past: do not warn.
> +		 * The new period takes the donor's parameters.
> +		 */
> +		if (!is_dl_boosted(dl_se))
> +			printk_deferred_once("sched: DL replenish lagged too much\n");
>  		replenish_dl_new_period(dl_se, rq);
>  	}

[Severity: High]
When a runnable throttled owner (runtime <=3D 0) is boosted, does the
while (dl_se->runtime <=3D 0) loop right above this check advance
dl_se->deadline from own_deadline by the donor's period instead of
starting a donor period at rq_clock(rq)?

kernel/sched/deadline.c:replenish_dl_entity() {
    ...
	while (dl_se->runtime <=3D 0) {
		dl_se->deadline +=3D period;
		dl_se->period_start +=3D period;
		dl_se->runtime +=3D runtime;
	}

	if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
		if (!is_dl_boosted(dl_se))
			printk_deferred_once("sched: DL replenish lagged too much\n");
		replenish_dl_new_period(dl_se, rq);
	}
}

For any throttled owner whose own_deadline has not passed yet (or is
within one donor period of rq_clock(rq)), adding the donor's period to
own_deadline keeps dl_se->deadline >=3D rq_clock(rq), so
replenish_dl_new_period() is never reached.  The boosted owner runs with a
deadline of own_deadline + pi_se->dl_period (later than its unboosted
own_deadline) instead of rq_clock(rq) + pi_se->dl_deadline, and its own
pre-boost overrun is deducted from the donor's runtime while also being
restored from own_runtime at dl_deboost().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D38
