Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795186703;
	b=i7UjCqO8uhBTgJivDsnmidiIwHHRBWbxwVsOS04ApmtU0yOYBKLX4NUQoKbDCxdw9QRP
	 7azbvuAinQnur1rEGMLndEbkCM5hYnugYTbqJZsxZkHhj+mdl+gtBJUfBSEKgX9krrYuT
	 C+vwCyOaz/nKF/X0fLZ8z0UFIA97WFKed9ycNQcjGTHXX0+u4wlpUZc2lDN1jF8WuKWIx
	 9WYbv9GXBVqpL70pIYvMR/Win86Zpyj60J3tWNB5OCEI2pNQgVUc4u5UlbpQT7Bs9Haqh
	 Uop0YeGlPaS0lSm2tRaWWUc4SAppPuroeksMUATc5fqle880u87YKjNlpc99wRNkdSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795186703;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sdACru9RLOuNjFdUd1XIdKuMm3R10IStrfgT9IzK/ys=;
	b=gK65ypsOlMYVio3RDxiN3a/pL/0mi+sgSOPYXlnF5owZTbhSsivc8zyYFai+MpULFtV4
	 boYAvtYd2eFvvWq/pP9FHhRO5ZLMTj2tGfIjBaS5/Wp69NurH29uG9m66jcvBlwsCjSxJ
	 uo25yVa2ylFtZnrvEUw1aK9zbPBqphnPh3gBGWuz0/97BK812epUpC7xhC//c3XA9GG+p
	 Ry6yn/URWX0nn5GvV6XNgAblMOZr+29xIjCsxwroM10bZiRH2SpTypi2QqvQVJMWF/bdT
	 9u/IHIxxlbskncEcSKiXsh3Jt1kc0bORh+qN16C5A1v5NqQNAdyxhC87ts4pXdhjLpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYzuHpva;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E160A2602;
	Fri, 20 Nov 2026 14:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cYzuHpva
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039FE1F000CF;
	Fri, 20 Nov 2026 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795186703;
	bh=sdACru9RLOuNjFdUd1XIdKuMm3R10IStrfgT9IzK/ys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cYzuHpvaZrD721fMMxkH6kkzvntW2stDaKnNVvZv0ti2/odEmQ/5SQ8o4G2PaLe0b
	 Q9YhAb0QFSYFhVC4XZ+ucRaqD4ThFvoL8CnE3B73j8RjU/W2pOMElhTFhCT/xP4387
	 jOJWoPzmYOjx2ShGGkmQNly4tzG0ih/i0gVxFBSvWa823eodnxs1vdm7cirz5JRwNC
	 XRJIJOh7v9HYNHoU9fXSAOnbM6ELMkgu3h8AOu6OJbf2m6qNjj2UvMqEmTuQzec/8q
	 BoJv/45N2I8kElPNTm+UBL4UQyUbbtFRM3jAJx+tYNBclzaEruX0vWLpOEF8tECkEl
	 ix4pixpk5AOSA==
Message-ID: <sashiko-outbox-225415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 32/33] sched/deadline: Check the runtime of a task
 whose parameters change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <d65436da41c304678dd3d77f003f32d05583fed7.1795181240.git.mathieu.desnoyers@efficios.com>
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <d65436da41c304678dd3d77f003f32d05583fed7.1795181240.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:58:22 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] sched/deadline: missing resched_curr() when enqueue throttles
  curr
- [Medium] sched/deadline: missing dl_new_params handling in
  switched_to_dl()
- [Medium] sched/deadline: stale deadline comparison before dl_deboost()
- [Medium] sched/deadline: __setparam_dl() mixes old deadline with new
  period bounds
- [Medium] sched/deadline: broken PI and sleeping period start in
  dl_deboost()
- [Medium] sched/deadline: desynced rt_mutex waiter deadline via
  dl_new_params handling
- [Medium] sched/deadline: missing PI boost when update_dl_entity()
  pushes owner deadline
--

commit de588e0683949d020e350120c6ab70125cea5a24
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Check the runtime of a task whose parameters change

This commit adds a dl_new_params flag to struct sched_dl_entity so that
when sched_setattr() modifies a task's runtime, deadline, or period, the
remaining runtime is checked against the new parameters via
update_dl_entity() on the next unboosted enqueue, at deboost in
dl_deboost(), or in prio_changed_dl() for tasks blocked on an rt_mutex.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b319173178f3a..77f37a23b808f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -93,6 +93,19 @@ static inline void dl_start_own_period(struct sched_dl=
_entity *dl_se)
>  	dl_se->runtime =3D dl_se->dl_runtime;
>  }
> =20
> +/*
> + * Return true if @dl_se has a constrained deadline, and the rq clock is
> + * past its deadline and before its next period. An enqueue then throttl=
es
> + * it until that period.
> + */
> +static inline bool dl_in_constrained_gap(struct sched_dl_entity *dl_se)
> +{
> +	u64 now =3D rq_clock(rq_of_dl_se(dl_se));
> +
> +	return !dl_is_implicit(dl_se) && dl_time_before(dl_se->deadline, now) &&
> +	       dl_time_before(now, dl_se->deadline - dl_se->dl_deadline + dl_se=
->dl_period);
> +}

[Severity: Medium]
Does dl_in_constrained_gap() (as well as dl_check_constrained_dl() and
update_dl_entity()) mix the old dl_se->deadline with the newly overwritten
dl_se->dl_deadline and dl_se->dl_period?

__setparam_dl() overwrites dl_se->dl_deadline and dl_se->dl_period in
place while dl_se->deadline is still anchored to old_period_start +
old_dl_deadline.  When a constrained task increases dl_deadline to match
dl_period near the end of its runtime, dl_is_implicit(dl_se) becomes true
on the new parameters, so update_dl_entity() skips
update_dl_revised_wakeup() and calls replenish_dl_new_period(), granting a
full fresh budget within the active period.  Conversely, when an implicit
task past its old deadline shrinks dl_deadline, dl_se->deadline -
dl_se->dl_deadline + dl_se->dl_period shifts the computed period end forward
by old_dl_deadline - new_dl_deadline, causing dl_in_constrained_gap() and
dl_check_constrained_dl() to treat the expired period as an active
constrained gap and throttle the task instead of replenishing it.

> @@ -114,6 +127,8 @@ static inline void dl_note_donor_refill(struct sched_=
dl_entity *dl_se)
>  		dl_se->dl_donor_refill =3D 1;
>  }
> =20
> +static void update_dl_entity(struct sched_dl_entity *dl_se);
> +
>  /*
>   * End the boost of @dl_se, whose task stays in the class. If the boost
>   * refilled its runtime from the donor's parameters, start a new period
> @@ -122,6 +137,13 @@ static inline void dl_note_donor_refill(struct sched=
_dl_entity *dl_se)
>   * first. Without a refill, the task keeps the runtime and the deadline
>   * of its own reservation.
>   *
> + * If sched_setattr() changed the parameters during the boost, check the
> + * runtime left against them now, for the same reason. rt_mutex_setprio()
> + * then compares the result with the top waiter. Leave that check to the
> + * next enqueue for a task with a constrained deadline, past its deadline
> + * and before its next period. The enqueue first throttles it until that
> + * period: see dl_check_constrained_dl().
> + *
>   * The caller holds the rq lock and the pi_lock of the task, and has
>   * updated the rq clock.
>   */
> @@ -130,6 +152,14 @@ void dl_deboost(struct sched_dl_entity *dl_se)
>  	if (dl_se->dl_donor_refill)
>  		dl_start_own_period(dl_se);
>  	dl_drop_boost(dl_se);
> +
> +	if (dl_se->dl_new_params && !dl_se->dl_throttled && dl_in_constrained_g=
ap(dl_se))
> +		return;
> +	if (dl_se->dl_new_params) {
> +		dl_se->dl_new_params =3D 0;
> +		if (!dl_se->dl_throttled)
> +			update_dl_entity(dl_se);
> +	}
>  }

[Severity: Medium]
Can rt_mutex_setprio() skip dl_deboost() by comparing pi_task->dl.deadline
against p->dl.deadline before dl_deboost() updates p->dl.deadline?

kernel/sched/core.c:rt_mutex_setprio() {
	...
			if (!dl_prio(p->normal_prio) ||
			    (pi_task && dl_prio(pi_task->prio) &&
			     dl_entity_preempt(&pi_task->dl, &p->dl))) {
				bool new_donor =3D p->dl.pi_se !=3D pi_task->dl.pi_se;

				p->dl.pi_se =3D pi_task->dl.pi_se;
				scope->flags |=3D ENQUEUE_REPLENISH;
				if (!scope->queued && new_donor)
					dl_boost_blocked(p);
			} else {
				dl_deboost(&p->dl);
	...
}

If a boosted owner p changes its parameters to a shorter deadline via
sched_setattr() and its current donor leaves while a second deadline waiter
pi_task remains, pi_task->dl.deadline can be earlier than p's stale
p->dl.deadline even though update_dl_entity() in dl_deboost() would give p
an earlier deadline than pi_task.  Because dl_entity_preempt() runs first,
rt_mutex_setprio() takes the boost branch, skips dl_deboost(), and leaves p
running on its stale later deadline and old runtime.

[Severity: High]
When dl_deboost() returns early on dl_in_constrained_gap(dl_se) for a
running task (or when sched_setattr() puts a running task into a
constrained gap), who calls resched_curr(rq) after enqueue_dl_entity()
throttles it?

In sched_change_end(), enqueue_dl_entity() calls dl_check_constrained_dl(),
which sets dl_se->dl_throttled =3D 1 and starts dl_se->dl_timer, and
enqueue_dl_entity() then returns early without calling
__enqueue_dl_entity().  Next, prio_changed_dl() sees p->dl.deadline =3D=3D
old_deadline and also returns early without calling resched_curr(rq).  The
throttled task stays on the CPU as rq->curr with !on_dl_rq(&p->dl), where
update_curr_dl() returns immediately without accounting runtime until the
replenishment timer or another wakeup triggers a reschedule.

[Severity: Medium]
Does returning early on dl_in_constrained_gap(dl_se) in dl_deboost() (and
prio_changed_dl()), or calling update_dl_entity(dl_se) unconditionally
afterward, break PI boosting and sleeping tasks?

There are three issues here:

First, when a lock owner p is deboosted while in its constrained gap and
another deadline waiter pi_task with pi_task->dl.deadline > now is waiting
on the lock, dl_deboost() drops the boost and leaves p->dl.deadline in the
past (< now).  In rt_mutex_setprio(), dl_entity_preempt(&pi_task->dl,
&p->dl) then sees p's expired deadline as earlier than pi_task->dl.deadline
and fails to reboost p, so sched_change_end() -> enqueue_dl_entity() ->
dl_check_constrained_dl() throttles the lock owner while pi_task waits on
it.

Second, for a task blocked on an rt_mutex in its constrained gap, both
dl_deboost() and prio_changed_dl() leave its expired deadline (< now) in
place, so rt_mutex_adjust_pi() / rt_mutex_adjust_prio_chain() orders its
waiter ahead of runnable waiters with future deadlines; when the lock is
released, mark_wakeup_next_waiter() wakes only that top waiter, which is
immediately throttled in dl_check_constrained_dl() without taking the lock.

Third, when !dl_in_constrained_gap(dl_se), dl_deboost() calls
update_dl_entity(dl_se) even when the task is sleeping on a non-PI
waitqueue (!task_on_rq_queued(p) && !dl_task_pi_blocked(p)), starting a new
period while the task is asleep so that its budget is reduced or throttled
by the time it wakes up.

[ ... ]

> @@ -2961,12 +3000,13 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, =
int flags)
>  		update_dl_entity(dl_se);
>  	} else if (flags & ENQUEUE_REPLENISH) {
>  		replenish_dl_entity(dl_se);
> -	} else if ((flags & ENQUEUE_CLASS) && !is_dl_boosted(dl_se)) {
> +	} else if (((flags & ENQUEUE_CLASS) || new_params) &&
> +		   !is_dl_boosted(dl_se)) {
>  		/*
> -		 * The task enters the class runnable. It may come back before
> -		 * its deadline, with the runtime left from older parameters.
> -		 * Check that runtime against the new parameters, as a wakeup
> -		 * does.
> +		 * The task enters the class, or its parameters change, while
> +		 * it is runnable. It may have runtime left from older
> +		 * parameters. Check that runtime against the new parameters,
> +		 * as a wakeup does.
>  		 */
>  		update_dl_entity(dl_se);
>  	} else if ((flags & ENQUEUE_MOVE) &&

[Severity: Medium]
When update_dl_entity() here (or in prio_changed_dl()) starts a new period
for an unboosted rt_mutex owner and pushes p->dl.deadline past its top
waiter's deadline, does anything PI-boost p with that waiter?

In __sched_setscheduler(), __setscheduler_dl_pi() runs before
sched_change_end() and only checks !dl_policy(policy).  If p already runs
under SCHED_DEADLINE and holds an rt_mutex with a deadline waiter whose
deadline was later than p's old deadline, shrinking p's reservation causes
update_dl_entity() to advance p->dl.deadline past the waiter's deadline
without adopting the waiter's pi_se, leaving p unboosted on its reduced
budget while holding the lock.

> @@ -4832,8 +4872,22 @@ static u64 get_prio_dl(struct rq *rq, struct task_=
struct *p)
>   */
>  static void prio_changed_dl(struct rq *rq, struct task_struct *p, u64 ol=
d_deadline)
>  {
> -	if (!task_on_rq_queued(p))
> +	if (!task_on_rq_queued(p)) {
> +		/*
> +		 * The deadline of a task blocked on an rt_mutex is in its
> +		 * waiter node, before any wakeup. If sched_setattr() changed
> +		 * its parameters, check its runtime against them now, as
> +		 * dl_deboost() does. rt_mutex_adjust_pi() then requeues the
> +		 * waiter with the result.
> +		 */
> +		if (p->dl.dl_new_params && !is_dl_boosted(&p->dl) &&
> +		    !p->dl.dl_throttled && dl_task_pi_blocked(p) &&
> +		    !dl_in_constrained_gap(&p->dl)) {
> +			p->dl.dl_new_params =3D 0;
> +			update_dl_entity(&p->dl);
> +		}
>  		return;
> +	}

[Severity: Medium]
Should switched_to_dl() also handle p->dl.dl_new_params for a task blocked
on an rt_mutex?

kernel/sched/deadline.c:switched_to_dl() {
	...
	if (!task_on_rq_queued(p)) {
		/*
		 * Give a deadline to a task that enters the class while it
		 * waits on an rt_mutex: rt_mutex_adjust_pi() reads it next.
		 * A task that comes back before its deadline keeps its old
		 * period; enqueue_dl_entity() checks the runtime left at the
		 * wakeup.
		 */
		if (dl_task_pi_blocked(p) && !p->dl.dl_throttled &&
		    dl_time_before(p->dl.deadline, rq_clock(rq)))
			replenish_dl_new_period(&p->dl, rq);

		return;
	}
	...
}

When a task enters or re-enters SCHED_DEADLINE via __sched_setscheduler()
while blocked on an rt_mutex, __setparam_dl() sets p->dl.dl_new_params =3D =
1,
and sched_change_end() takes the ENQUEUE_CLASS branch and calls
switched_to_dl() instead of prio_changed_dl().  If the task returns to
SCHED_DEADLINE before its old deadline with a smaller reservation,
switched_to_dl() does not call update_dl_entity(&p->dl), so
rt_mutex_adjust_pi() queues the waiter with its stale old deadline; and if
p->dl.deadline was in the past, switched_to_dl() starts a new period
without clearing p->dl.dl_new_params.

[Severity: Medium]
Can consuming p->dl.dl_new_params in prio_changed_dl() desynchronize
p->dl.deadline from the task's rt_mutex waiter node when prio_changed_dl()
is reached from callers other than __sched_setscheduler()?

If p->dl.dl_new_params remains set while p is blocked on an rt_mutex (after
switched_to_dl(), or after prio_changed_dl() skipped update_dl_entity() due
to dl_in_constrained_gap(&p->dl) or is_dl_boosted(&p->dl)), a later
sched_move_task(), do_set_cpus_allowed(), or sched_setnuma() on p runs
sched_change_end() -> prio_changed_dl().  Because time has elapsed while p
was blocked, update_dl_entity(&p->dl) sees dl_entity_overflow() and pushes
p->dl.deadline to a new period, but those callers do not call
rt_mutex_adjust_pi(p) afterward, leaving p->dl.deadline out of sync with
p->pi_blocked_on->tree.deadline.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795181240.gi=
t.mathieu.desnoyers@efficios.com?part=3D32
