Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802849;
	b=Hf+/kriWJCTcgkbsXTImapEeICvCcCh8RDxl4SD+GoHC1jkrJQNnwq3HpfJx/52eTRe5
	 o6YUhO/cmJ67LUYqOXpBG7nZvN1avxDp/21DlmVuLcWKsKZbvdSDZODscjHDEnwi6oBd4
	 WiYrxa5OvEAhw4JhSYb4udIyafD+AHLrQo1QC1FVTX/Ktx9rwzUheD4/nDlrc3pzQ/10W
	 WOXRcl8KQE79LKaQnLs0b3ta4vJTJYV9vu0ULX/nHAs/QVl5ScdOBa3+vA00mMz4p5/aw
	 u7NDssRfb3OSkAXtbKX4j8F+QsJWEMK83wdFZHMMa2KdAw47jS4wHE262XBH0CeIUQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802849;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+5Ygh2ECUKLLLQDpCnwt97nesI3PwTyBQqvF4nierYE=;
	b=kj25IC8KwcvP9CBudt+pJnUoUjK1Wgubusrv03qPB1ZO9t2ubsF4nB1maU5OfARSh7gJ
	 qz8nrcoTin9GChZcKVZDI2IjWd9dH6YsYrjDk3qX0zsPLgBTgjeeJM6gxoT6eA/1GNzbR
	 PQ7LwDG2KIo2vh3J9Qvvu/mzO3V64UMBcHTUpWFCBie23x3VpAyfjk618sczThoRTg/wo
	 PDbmqx479eGWk/d2Yiod3OUUquysssunLjNwi/AJ+g82AfDMQt3TyJ23/1QrukKhJsVMK
	 mip1OSs6caRnJDcaQ37GSyJGTysyO7dRmA/3yPGI5Ewj/jO66BUSW06+k3nsxRtefDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKZiIKp+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34299606A333;
	Fri, 27 Nov 2026 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eKZiIKp+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611171F0089A;
	Fri, 27 Nov 2026 18:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802848;
	bh=+5Ygh2ECUKLLLQDpCnwt97nesI3PwTyBQqvF4nierYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eKZiIKp+G9ZAxnhcQv2XHw6jsyQcNj2kHoWUu8Ho5HaxCk2MhgWbYzOx6ycuJ9blH
	 ZtS47FfkXtyMCAyIRaSpflYd0rLxJ7UOvXrDITFGALZZbIl0b7cZ3x289KCW8LA+oI
	 7YinG5dhJE0I4EZWeiUn0oZjn5h9tdPJPwAc9kssxTek5PZEXlkyFN8CVIVRwo+tYz
	 G5arHgSExvPUisXulAYpQVtsZpug7BxSBhFzgfgDNA3sQU8qa+C42icGaBgqKRJAJX
	 rHHFCXJaO0B5nFUvjnqUXIth7miAcT0LnJ7g8G1xhe6ebPmjFSncPDly9U18/m0Y5z
	 YBSM6M8BLUueQ==
Message-ID: <sashiko-outbox-238043@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 38/43] sched/deadline: Boost an owner that cannot
 run on its own reservation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <bc3b068a5510b87e32a1c0f89d93884b53295226.1795771148.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <bc3b068a5510b87e32a1c0f89d93884b53295226.1795771148.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 18:07:27 +0000
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
- [Medium] sched/deadline: mismatched runtime <=3D 0 checks in
  dl_waiter_boosts()
- [Medium] sched/deadline: deadline inversion in dl_boost_donor_period()
  on resume
- [Medium] sched/deadline: lost throttle state on sleeping task in
  dl_deboost()
- [Medium] sched/deadline: stale past deadline kept when boosting
  unqueued owner
- [Medium] sched/deadline: missed deadline update on donor change in
  rt_mutex_setprio()
- [Medium] sched/deadline: dl_boost_start() skipped when
  !dl_prio(p->normal_prio)
--

commit c18a5e374403621910f4e9e5b28d6e3a7f84d1f4
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Boost an owner that cannot run on its own reservation

This commit updates deadline priority inheritance via dl_waiter_boosts(),
dl_boost_start(), and dl_boost_donor_period() so that a deadline waiter
boosts a lock owner that is throttled, out of runtime, or in its
constrained gap, and runs it on a bounded donor period. It also reads the
waiter's priority and donor once in dl_top_donor() to avoid boosting a
non-deadline owner when the waiter's donor is the owner itself.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index f374b8a0a38b6..9fda819aa4efb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
[ ... ]
> @@ -7984,15 +7990,36 @@ void rt_mutex_setprio(struct task_struct *p, stru=
ct task_struct *pi_task)
>  			 * with that deadline.
>  			 */
>  			if (!dl_prio(p->normal_prio) ||
> -			    (pi_task && dl_prio(pi_task->prio) &&
> +			    (donor &&
>  			     !(p->dl.dl_new_params && p->dl.pi_se !=3D &p->dl) &&
> -			     dl_entity_preempt(&pi_task->dl, &p->dl))) {
> +			     dl_waiter_boosts(p, pi_task))) {
>  				struct sched_dl_entity *old_donor =3D p->dl.pi_se;
> =20
> -				dl_set_donor(&p->dl, pi_task);
> -				scope->flags |=3D ENQUEUE_REPLENISH;
> -				if (!scope->queued && p->dl.pi_se !=3D old_donor)
> -					dl_boost_blocked(p);
> +				/*
> +				 * donor is not NULL here. A task with no
> +				 * deadline policy has a deadline prio only from
> +				 * a deadline waiter, whose donor is not @p: see
> +				 * __rt_effective_prio().
> +				 */
> +				if (!dl_set_donor(&p->dl, &donor)) {
> +					/*
> +					 * The donor of the top waiter is @p: @p waits
> +					 * on a lock that it owns, or the waiter has a
> +					 * stale donor. End the boost of a deadline
> +					 * task, as a deboost does. A task with no
> +					 * deadline policy does not get here:
> +					 * __rt_effective_prio() did not boost it.
> +					 */
> +					if (dl_prio(p->normal_prio) && old_donor !=3D &p->dl)
> +						dl_deboost(&p->dl);
> +				} else {
> +					if (dl_prio(p->normal_prio) &&
> +					    old_donor =3D=3D &p->dl && p->dl.pi_se !=3D &p->dl)
> +						dl_boost_start(&p->dl);
> +					scope->flags |=3D ENQUEUE_REPLENISH;
> +					if (!scope->queued && p->dl.pi_se !=3D old_donor)
> +						dl_boost_blocked(p);
> +				}

[Severity: Medium]
When a new top waiter with an earlier deadline replaces old_donor during
a held boost (p->dl.dl_boost_held =3D=3D 1 and old_donor !=3D &p->dl), does
rt_mutex_setprio() leave p->dl.deadline at the previous donor's later
deadline?

Because old_donor !=3D &p->dl, dl_boost_start() is skipped. For a deadline
owner (p->dl.dl_deadline !=3D 0) that still has positive donor runtime left
and a future deadline from the old donor, replenish_dl_entity() and
dl_boost_blocked() also leave p->dl.deadline and p->dl.runtime unchanged.
Until the old donor's remaining runtime is exhausted, p continues to be
scheduled (or ordered on an outer rt_mutex) at the old donor's later
deadline rather than the new top waiter's deadline.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index ae0940838ca5a..7f839185eb381 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -285,6 +319,13 @@ void dl_deboost(struct sched_dl_entity *dl_se)
>  	if (held && dl_se->runtime <=3D 0 && (!asleep || dl_se->dl_throttled)) {
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
>  			dl_se->dl_throttled =3D 0;

[Severity: Medium]
Can dl_deboost() fail to re-throttle a sleeping task whose held boost ends
before its own next period?

If the owner was throttled while asleep with dl_timer armed for its old
period boundary, and sched_setattr() during the held boost moves
own_period_start + dl_period further into the future, dl_setattr_period()
updates own_* without canceling dl_timer:

kernel/sched/deadline.c:dl_setattr_period() {
    ...
	if (dl_se->dl_boost_held) {
		dl_setattr_place(dl_se, now, &dl_se->own_period_start,
				 &dl_se->own_deadline, &dl_se->own_runtime,
				 old_runtime, old_deadline, old_period, false, false);
		return true;
	}
    ...
}

When dl_timer fires at the old period boundary while the task is still
asleep and boosted, dl_task_timer() skips the dl_next_period() check
because is_dl_boosted(dl_se) is true and calls replenish_dl_entity(),
which clears dl_se->dl_throttled =3D 0 (and can also grant a fresh donor
period if the donor's deadline has passed). Similarly, if an owner with a
negative runtime overrun (own_runtime < 0) was runnable when boosted,
enqueue_task_dl() cleared dl_se->dl_throttled =3D 0 before the owner went
to sleep on a non-rt_mutex waitqueue. When dl_deboost() later runs while
the task is asleep before own_period_start + dl_period,
dl_end_held_boost() restores own_runtime <=3D 0, but (!asleep ||
dl_se->dl_throttled) is false, so dl_deboost() neither re-throttles the
task nor arms dl_timer, and a later wakeup can erase a negative overrun in
update_dl_entity().

> @@ -379,6 +420,130 @@ void dl_check_blocked_params(struct task_struct *p)
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
> +		/*
> +		 * A boost held at a wakeup refill can keep runtime of the
> +		 * task's own, before its own deadline. The task can run on
> +		 * it: compare with that deadline.
> +		 */
> +		if (dl_se->own_runtime > 0 &&
> +		    dl_time_before(now, dl_se->own_deadline))
> +			return dl_time_before(pi_task->dl.deadline,
> +					      dl_se->own_deadline);
> +		if (dl_time_before(now, dl_se->own_period_start + dl_se->dl_period))
> +			return true;
> +		return dl_time_before(pi_task->dl.deadline, now + dl_se->dl_deadline);
> +	}
> +	if (!is_dl_boosted(dl_se)) {
> +		if (dl_se->dl_throttled || dl_in_constrained_gap(dl_se) ||
> +		    (dl_se->dl_runtime && dl_se->runtime <=3D 0))
> +			return true;
> +		if (dl_time_before(dl_se->deadline, now))
> +			return dl_time_before(pi_task->dl.deadline,
> +					      now + dl_se->dl_deadline);
> +	}
> +	return dl_entity_preempt(&pi_task->dl, dl_se);
> +}

[Severity: Medium]
Can an unboosted owner whose deadline has passed outside its constrained
gap be left with its stale past deadline when boosted while not queued?

When p is blocked on another rt_mutex (or sleeping) after period_start +
dl_period has passed, dl_waiter_boosts() boosts p if pi_task->dl.deadline
< now + dl_se->dl_deadline (or unconditionally if dl_se->runtime <=3D 0).
Because scope->queued is false in rt_mutex_setprio(), enqueue_task_dl()
does not run, dl_boost_start() returns early because p is neither
throttled nor in its constrained gap, and dl_boost_blocked() returns early
because dl_se->dl_deadline is non-zero. That leaves p boosted (p->dl.pi_se
!=3D &p->dl) with p->dl.dl_boost_held =3D=3D 0 and p->dl.deadline still in =
the
past, so waiter_update_prio() propagates p's stale past deadline into the
outer lock's waiter tree and subsequent dl_waiter_boosts() calls on p
compare against that past deadline.

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
> +	/*
> +	 * The donor can differ from the one of the last held boost. Keep the
> +	 * start of the donor period and the runtime left, but take the
> +	 * deadline and the cap of the runtime from this donor.
> +	 */
> +	if (dl_se->dl_boost_granted && runtime && period &&
> +	    dl_time_before(now, dl_se->boost_period_start + period)) {
> +		dl_se->period_start =3D dl_se->boost_period_start;
> +		dl_se->deadline =3D dl_se->period_start +
> +				  READ_ONCE(pi_se->dl_deadline);
> +		dl_se->runtime =3D min_t(s64, dl_se->boost_runtime, runtime);
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
Can dl_boost_donor_period() place dl_se->deadline far past the new donor's
deadline when resuming a period across different donors?

During a held boost under a donor with a long period P1 (for example,
1000ms), if the owner exhausts that donor's runtime, replenish_dl_entity()
advances dl_se->period_start by P1 into the future (t0 + 1000ms), and
dl_end_held_boost() saves that future timestamp in
dl_se->boost_period_start. If a second donor with a short period and
deadline (for example, 10ms) boosts the owner at now =3D t0 + 50ms,
dl_time_before(now, dl_se->boost_period_start + period) is true, so
dl_boost_donor_period() sets dl_se->deadline =3D t0 + 1010ms, scheduling the
owner 950ms after the urgent waiter's deadline. The converse happens if a
short-period donor saves boost_period_start =3D 0 and a constrained donor
with dl_deadline =3D 10ms, dl_period =3D 100ms boosts at now =3D 20ms:
dl_se->deadline =3D 0 + 10ms is in the past, so adding period pushes
dl_se->deadline to 110ms (80ms past the new donor's deadline). Also,
dl_se->boost_deadline is written in dl_end_held_boost() but never read.

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
Should dl_waiter_boosts() and dl_boost_start() use matching conditions for
dl_se->runtime <=3D 0?

In dl_waiter_boosts(), (dl_se->dl_runtime && dl_se->runtime <=3D 0) is
checked before testing whether dl_se->deadline is 0 or already in the
past. When a sleeping owner's held boost ends after its own next period
has started and the top waiter has a deadline later than now +
dl_se->dl_deadline, the first dl_waiter_boosts() call in
rt_mutex_setprio() returns false and calls dl_deboost(), where
dl_end_held_boost() sets dl_se->runtime =3D 0 and dl_se->dl_throttled =3D 0.
The second dl_waiter_boosts() call in rt_mutex_setprio() after
dl_deboost() then sees !is_dl_boosted(dl_se) and dl_se->runtime <=3D 0,
returns true, and immediately re-boosts the sleeping owner with the
later-deadline waiter it just deboosted from.

Conversely, when a sleeping owner before its own deadline has
dl_se->runtime <=3D 0 and dl_se->dl_throttled =3D=3D 0 (such as after
dl_setattr_place() -> dl_setattr_period() or after a deboost),
dl_waiter_boosts() boosts it via dl_se->runtime <=3D 0, but dl_boost_start()
does not check dl_se->runtime <=3D 0 and returns early without setting
dl_boost_held or calling dl_boost_donor_period(). If that owner wakes up
while boosted before dl_se->deadline, update_dl_entity() does not
replenish it and enqueue_dl_entity() skips throttling because
is_dl_boosted(dl_se) is true, enqueuing it with runtime =3D=3D 0 and
dl_boost_held =3D=3D 0.

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 4f26601f0530a..b71df4c2c13ae 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -303,6 +303,7 @@ static bool check_same_owner(struct task_struct *p)
>  #ifdef CONFIG_RT_MUTEXES
>  static inline void __setscheduler_dl_pi(int newprio, int policy,
>  			      struct task_struct *p,
> +			      struct sched_dl_entity **donor,
>  			      struct sched_change_ctx *scope)
>  {
>  	/*
> @@ -312,14 +313,10 @@ static inline void __setscheduler_dl_pi(int newprio=
, int policy,
>  	 * sure replenishment happens with the next enqueue.
>  	 */
> =20
> -	if (dl_prio(newprio) && !dl_policy(policy)) {
> -		struct task_struct *pi_task =3D rt_mutex_get_top_task(p);
> -
> -		if (pi_task) {
> -			dl_set_donor(&p->dl, pi_task);
> -			scope->flags |=3D ENQUEUE_REPLENISH;
> -		}
> -	}
> +	/* *@donor chose newprio: see rt_effective_prio(). */
> +	if (dl_prio(newprio) && !dl_policy(policy) && *donor &&
> +	    dl_set_donor(&p->dl, donor))
> +		scope->flags |=3D ENQUEUE_REPLENISH;

[Severity: Medium]
Does skipping dl_boost_start(&p->dl) here and when !dl_prio(p->normal_prio)
in rt_mutex_setprio() miss holding the boost for a task that left
SCHED_DEADLINE while throttled or in its constrained gap?

A task that switches from SCHED_DEADLINE to a non-deadline policy before
its 0-lag time or next period retains p->dl.dl_runtime !=3D 0 along with its
throttled or constrained-gap state while !dl_prio(p->normal_prio). If it
holds an rt_mutex with a deadline waiter during __sched_setscheduler() (or
is boosted afterwards in rt_mutex_setprio()), dl_boost_start(&p->dl) is
not called. If the task is queued with a negative runtime overrun,
replenish_dl_entity() falls back to dl_hold_refilled_boost(), which clamps
own_runtime to 0 instead of preserving the negative overrun as
dl_boost_start() does; if the task is not queued, neither
dl_boost_blocked() nor switched_to_dl() gives it a donor period, leaving
it boosted with dl_boost_held =3D=3D 0 and its own stale deadline and runti=
me.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D38
