Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121828;
	b=FXruiUspGr2cvC33MYBrlIGMRllPaT3iE9y8jLaELO2ppj+NBHET0GGXcoFyfpjJaPFN
	 BCV2F37v5Duga/si2p6knqhbnDV1/QO9z/M4N5sy5OzjNEmys+7ezjDRCa6lrunaEOKZI
	 Kz2Sa9ke+bgdQGrRh/ZoFGM3pdXa/MJNGadyBzI/CPWMqPtkIc/21PdTBtLFWYbv25TeQ
	 wv83w3OftdEckuGHYN88ssqZuEPeV3bra9MFxbVm5FLSpgRA9emJW08iyLVdS6RYJT0To
	 I6qELNrenMT5W/7/xkuOnfASVW8Pa5396LVTU+eTS87q7KersC4kLK/l7+/KsWW0ljA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121828;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zNDC7rbKVdKb8xtQpRE/gu48zmjdlctTpZIHUURrBzM=;
	b=2bnyX+xJTng+llK9TeZiCe7EL/lCAZ+vEoKRZRHokJliVh8uK3jegdbxA+r6LxJ7rlmc
	 A+q1vjuxmgzd3s7D9BDDUTqv1NnEKfqGqmahrPAEyF4s47uIJymPIp2KGRd9DBDs7x5ei
	 7lt4qf/8nvvuhlpyzw0Lc9tdNieGGomDefn1gp3WFXJn4kOskQTu1F4Ak/XlTLACy8hcb
	 FHiUyGf+xE0jV72QHDPptK8noIcDhWT3ny3T8qdatiA6kp0DYGD/PWJKSgNoFXxtX5gx4
	 F6lqfnJOKI2wlnNJ1wqIMVAtmE8Y5cmAxKzX4p7pc6j5Q5l+dnJwUXyfgR241vDAuNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EviDrMkY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A811606A320;
	Thu, 19 Nov 2026 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EviDrMkY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1581F000C4;
	Thu, 19 Nov 2026 20:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121828;
	bh=zNDC7rbKVdKb8xtQpRE/gu48zmjdlctTpZIHUURrBzM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EviDrMkY406BXnHfiUYNvK89bTnEZ3OpoBGPAZa3nvpZ+iUz2sw+V0OTQZBOTnEf2
	 yQkfzmItGqM+9H8JxZYheLTptILZeWZUBHKMhBfAzAy1OH9ZCSbCQn16aZEKSbI2pG
	 NcSnx7buuK2qYtBysCLrBYpqxme+DWHYssZEsVTgWHoyuqWzRsGWOc4KFIlq3xwH68
	 Q5g4IuTYV8tMCYAkCR8C+4XZM0TE6MSZKitLjH/sME5LCbnsXcXr8DXwNKIug2qg42
	 d6PMJ1DvNwPcWEaqaY6OSPUP056FbBYu2AZOgDgSTqYobwjLAjK477QgJbjifgdsrn
	 mnl2c2vWNM98w==
Message-ID: <sashiko-outbox-224078@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 26/33] sched/deadline: Start a period for a task that
 enters the class blocked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <b218275f5c0dabbb914bf1ae9cf6a32f0551dd0e.1795116791.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <b218275f5c0dabbb914bf1ae9cf6a32f0551dd0e.1795116791.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:57:07 +0000
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
- [Medium] sched/deadline: dl_task_pi_blocked() misses tasks sleeping
  off rt_mutex
- [Medium] sched/deadline: missing period start in
  __sched_setscheduler() when boosted
- [Medium] sched/deadline: dl_boost_blocked() skips departed tasks with
  dl_deadline
--

commit 38735e4f5a4290a90781132f54e4120fda6dbb23
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Start a period for a task that enters the class blocked

This commit starts a new period in switched_to_dl() and dl_boost_blocked()
when a task blocked on an rt_mutex enters the deadline class or receives a
new priority-inheritance donor.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 8ac78958a17af..77a1d1f463f6d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -125,6 +125,12 @@ void dl_deboost(struct sched_dl_entity *dl_se)
>  	}
>  	dl_drop_boost(dl_se);
>  }
> +
> +/* Return true if @p waits on an rt_mutex. The caller holds its pi_lock.=
 */
> +static inline bool dl_task_pi_blocked(struct task_struct *p)
> +{
> +	return p->pi_blocked_on;
> +}

[Severity: Medium]
Does gating replenish_dl_new_period() on dl_task_pi_blocked() leave
p->dl.deadline at 0 for tasks that sleep with p->pi_blocked_on =3D=3D NULL?

In futex_wait_requeue_pi(), a task sleeps on the non-PI source futex with
p->pi_blocked_on =3D=3D NULL before being requeued.  If it enters the deadl=
ine
class while sleeping there (via sched_setattr() or a boost on another
rt_mutex it owns), switched_to_dl() and dl_boost_blocked() skip starting a
period.  When FUTEX_CMP_REQUEUE_PI then proxy-locks the task onto the PI
futex without waking it, task_blocks_on_rt_mutex() copies p->dl.deadline
(still 0) into waiter->tree.deadline before setting p->pi_blocked_on,
placing the waiter ahead of all existing deadline waiters and boosting the
owner with deadline 0:

kernel/locking/rtmutex.c:task_blocks_on_rt_mutex() {
    ...
	waiter_update_prio(waiter, task);
	waiter_clone_prio(waiter, task);
    ...
	task->pi_blocked_on =3D waiter;
    ...
}

Similarly, if a task holding an rt_mutex sleeps on a non-rt_mutex primitive
(p->pi_blocked_on =3D=3D NULL), calling sched_setattr(SCHED_DEADLINE) leaves
p->dl.deadline at 0 so an earlier-deadline waiter blocking on that rt_mutex
sees dl_entity_preempt() return false and fails to boost it; or if the
sleeping owner has no reservation of its own and gets boosted by a second
waiter with an earlier deadline than the first, dl_boost_blocked() skips
the period start and ENQUEUE_REPLENISH is discarded because !scope->queued.

[ ... ]

> @@ -1116,6 +1127,30 @@ static inline void replenish_dl_new_period(struct =
sched_dl_entity *dl_se,
>  	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
>  }
> =20
> +#ifdef CONFIG_RT_MUTEXES
> +/*
> + * Start a period from the new donor of @p, if @p has no reservation of =
its
> + * own and waits on an rt_mutex. The enqueue does this for a queued task=
, in
> + * replenish_dl_entity(). A blocked task is not enqueued, but the chain =
walk
> + * copies its deadline into its waiter.
> + *
> + * The caller calls it only when the donor changes. A new period changes=
 the
> + * deadline, so the chain walk finds the waiter out of date and goes on.=
 In a
> + * ww_mutex cycle, a new period at each step would never let the walk st=
op.
> + *
> + * The caller holds the rq lock and the pi_lock of @p, and has updated t=
he
> + * rq clock.
> + */
> +void dl_boost_blocked(struct task_struct *p)
> +{
> +	struct sched_dl_entity *dl_se =3D &p->dl;
> +
> +	if (!dl_se->dl_deadline && !dl_se->dl_throttled &&
> +	    dl_task_pi_blocked(p))
> +		replenish_dl_new_period(dl_se, task_rq(p));
> +}
> +#endif

[Severity: Medium]
Can checking !dl_se->dl_deadline in dl_boost_blocked() miss a non-deadline
task that recently left SCHED_DEADLINE before its 0-lag time?

When a task switches from SCHED_DEADLINE to a non-deadline policy before
its 0-lag time, switched_from_dl() arms inactive_timer and leaves
dl_se->dl_deadline and dl_se->deadline non-zero until the timer fires.  If
the task holds one rt_mutex, blocks on a second rt_mutex, and gets boosted
into the deadline class before that 0-lag time, dl_boost_blocked() sees
dl_se->dl_deadline !=3D 0 and skips starting a period from the donor.
switched_to_dl() then cancels inactive_timer (so __dl_clear_params() will
not run while the task stays boosted) and also skips
replenish_dl_new_period() while the old dl_se->deadline has not yet passed.

Once that old deadline passes while the task remains blocked and a new
donor boosts it, switched_to_dl() does not run because the task is already
in dl_sched_class, and dl_boost_blocked() still sees dl_se->dl_deadline !=
=3D 0,
requeuing the waiter on the second rt_mutex with the expired deadline ahead
of waiters with current deadlines.  Should this check !dl_prio(p->normal_pr=
io)
instead of !dl_se->dl_deadline?

[ ... ]

> @@ -4565,6 +4600,17 @@ static void switched_to_dl(struct rq *rq, struct t=
ask_struct *p)
>  	if (!task_on_rq_queued(p)) {
>  		add_rq_bw(&p->dl, &rq->dl);
> =20
> +		/*
> +		 * A task that waits on an rt_mutex cannot wait for its wakeup.
> +		 * The chain walk sorts its waiter by its deadline first. A task
> +		 * new to the class has a deadline of 0, which goes before every
> +		 * real one. Start a new period now, as setup_new_dl_entity()
> +		 * does at an enqueue.
> +		 */
> +		if (dl_task_pi_blocked(p) && !p->dl.dl_throttled &&
> +		    dl_time_before(p->dl.deadline, rq_clock(rq)))
> +			replenish_dl_new_period(&p->dl, rq);
> +
>  		return;
>  	}

[Severity: Medium]
What happens when sched_setattr() gives a SCHED_DEADLINE reservation to a
blocked task that is already in dl_sched_class (for instance, because it
was boosted into the class by priority inheritance)?

In __sched_setscheduler(), prev_class and next_class are both
&dl_sched_class, so DEQUEUE_CLASS is not set and sched_change_end() calls
prio_changed_dl() (which returns early when !task_on_rq_queued(p)) instead
of switched_to_dl().  Meanwhile, __setscheduler_dl_pi() only acts when
!dl_policy(policy):

kernel/sched/syscalls.c:__setscheduler_dl_pi() {
	if (!dl_prio(p->prio))
		return;

	if (dl_prio(newprio) && !dl_policy(policy)) {
		struct task_struct *pi_task =3D rt_mutex_get_top_task(p);
    ...
}

If a non-deadline task holding rt_mutex L1 and blocked on rt_mutex L2 is
boosted by a deadline waiter on L1, and sched_setattr(SCHED_DEADLINE) then
gives the task its own reservation with an earlier deadline than its donor
(or if the donor's deadline on the task has already expired), the task is
neither deboosted nor given a period from its new parameters, leaving its
waiter on L2 ordered by the donor's later or expired deadline.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795116790.gi=
t.mathieu.desnoyers@efficios.com?part=3D26
