Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121946;
	b=hi+RbxUtWXaLSsxrzA4gNXJ10mFe1s6la0YwRp6LJO7BYOQuDGDlsZI3TMp5NEcfOUKU
	 /Udvjb3VDyOvKimt1ofhHX9RlYby9Zq9yg8sz6BA94CQqp9toz4TLA1040n+AYihnnXZD
	 lAV5SrSQ/u2rhRxveW3y50wfEvXooea8TS8GPh00uaVeEVcCvlNrli9hMRnKbqG/Oxcoa
	 AO0e55SihPBH5hBdUwe3V1wI6+ToQ5vAh5gLmrMo1wzyYUqhrn69qQEk7xbZL5ICwj6d9
	 W0Spk3YCU9mWMGus2p3EJSyiBIK/r7CbgT904wUdsQ4FStMJ53re8LgHVoUQacZuOig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121946;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G1pcEvjR2pSJvbQKF+KKXdZzwnsyzVOnl5RF1DfJCT8=;
	b=BiM0XJ1BjAkiOeYhyS9GylBBHKRYPSAX+eaZ/dThsnT/8qBXKV4ZXZb9yz9BttUHARyT
	 yuAHpMDcwrkOISQxgt+BaN0EoPVrKjUICLNqUVfEgb/bdOKKvWk/rqWzq2GN2iJ7dW1hw
	 nwNiVmGPNM8sYON11no7fWBlHWiKAM3iADWFfQ3AZQsq0BnHH1laadSWzO62YgUZupDMU
	 vm188d8DaGCNkThvrEyYa4ZaPPeglXq3PBuDbQtMjiCVY3oP9KWEIbhKDQNrcUbTsmeUe
	 AwlOoK5DvQRyom6/TtOmh/vKYhXlxjaW20zo9iefMR7wNkYMyzfmKYiv9W/B9wivsjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRTeRxq0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53F5606A904;
	Thu, 19 Nov 2026 20:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRTeRxq0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53B0D1F000C0;
	Thu, 19 Nov 2026 20:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121946;
	bh=G1pcEvjR2pSJvbQKF+KKXdZzwnsyzVOnl5RF1DfJCT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IRTeRxq0MWbySYSjULmfQ+orb1PEPVfs22cOopaGzDmI+Lsqy9AZB3M7fMnXfnBjK
	 S6MgeokxDfLn2INXI4ceyn1sW1bsewhApoqS5fzCH3h7HoA8jh8sQTRBsY3XDi578I
	 fxOiw8Gkcn15U8K1er7yRP/DPDSlA8b5C1LJtfw4U2MLmD47o/QwOgxYQmjm+/gW3r
	 Ko5zhohj/zZWTgTP9pGo2he2g8AjNDMhV+BuH8IQdBPqat4g+JOgfhsm13Inq/wli/
	 Qf9Y6pzUyDBR5sCusk6Y/CNtzO+vDvxZuW1nkCaJoRUbeUxsV4THQlTaY18IS2iX6N
	 lRBG+hYdQEEhw==
Message-ID: <sashiko-outbox-224081@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 32/33] sched/deadline: Check the runtime of a task
 whose parameters change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <efcd611a473f0da0161243c58f4af7c7ca73e2ba.1795116791.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <efcd611a473f0da0161243c58f4af7c7ca73e2ba.1795116791.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:59:05 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] sched/deadline: dl_deboost() skips dl_check_constrained_dl()
  and sleep check
- [Medium] sched/deadline: __setparam_dl() skips dl_new_params on
  boosted policy re-entry
- [Medium] sched/deadline: stale deadline in rt_mutex_adjust_pi() on
  blocked param change
- [Medium] sched/deadline: missing PI boost when update_dl_entity()
  pushes owner deadline
--

commit ef8688347a9187823ad70d72973343acbfec2dd5
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Check the runtime of a task whose parameters change

This commit marks deadline tasks whose runtime, deadline, or period
changes in __setparam_dl() and runs update_dl_entity() on the next
unboosted enqueue or upon deboost in dl_deboost().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 7ed2f525b883e..2849484428c60 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -130,6 +136,12 @@ void dl_deboost(struct sched_dl_entity *dl_se)
>  	if (dl_se->dl_donor_refill)
>  		dl_start_own_period(dl_se);
>  	dl_drop_boost(dl_se);
> +
> +	if (dl_se->dl_new_params) {
> +		dl_se->dl_new_params =3D 0;
> +		if (!dl_se->dl_throttled)
> +			update_dl_entity(dl_se);
> +	}
>  }

[Severity: Medium]
Does calling update_dl_entity() directly from dl_deboost() bypass
dl_check_constrained_dl() and update sleeping tasks prematurely?

In enqueue_dl_entity(), dl_check_constrained_dl() runs before
update_dl_entity() so a constrained task (!dl_is_implicit(dl_se)) with
dl_se->deadline < rq_clock(rq) < dl_next_period(dl_se) is throttled until
its next period.  Because rt_mutex_setprio() calls dl_deboost() before
sched_change_end() enqueues the task, update_dl_entity() sees
dl_time_before(dl_se->deadline, rq_clock(rq)) and immediately starts a new
period via replenish_dl_new_period(), moving dl_se->deadline into the
future before enqueue_dl_entity() can throttle it.

In addition, if the lock owner is sleeping on a non-PI wait when a donor
times out or is interrupted (!task_on_rq_queued(p) &&
!dl_task_pi_blocked(p)), dl_deboost() clears dl_new_params and starts a
new period while the task is still asleep rather than waiting for its
wakeup enqueue.

[ ... ]

> @@ -2913,12 +2934,13 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, =
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
Can an unboosted SCHED_DEADLINE lock owner miss a required PI boost when
update_dl_entity() pushes its deadline past its top waiter's deadline?

Suppose a SCHED_DEADLINE task p holds an rt_mutex with a SCHED_DEADLINE
waiter whose deadline is later than p->dl.deadline, so p is not boosted.
When sched_setattr() shrinks p's reservation, __setscheduler_dl_pi() runs
before sched_change_end() and only checks !dl_policy(policy).  Then
enqueue_dl_entity() calls update_dl_entity(), which starts a new period
and advances p->dl.deadline past the waiter's deadline.  Unlike
rt_mutex_setprio(), which rechecks dl_entity_preempt(&pi_task->dl, &p->dl)
after dl_deboost(), __sched_setscheduler() never compares p's new deadline
against rt_mutex_get_top_task(p), leaving p unboosted and allowing it to
be throttled on its reduced runtime while holding the lock.

[ ... ]

> @@ -4971,6 +4993,11 @@ void __setparam_dl(struct task_struct *p, const st=
ruct sched_attr *attr)
>  	u64 period =3D attr->sched_period ?: attr->sched_deadline;
>  	bool held;
> =20
> +	if (attr->sched_runtime !=3D dl_se->dl_runtime ||
> +	    attr->sched_deadline !=3D dl_se->dl_deadline ||
> +	    period !=3D dl_se->dl_period)
> +		dl_se->dl_new_params =3D 1;
> +
>  	/*
>  	 * Change the bandwidth that the runqueue counts here, with the
>  	 * parameters. A task that priority inheritance boosted into the

[Severity: Medium]
Does __setparam_dl() leave dl_new_params unset when a task leaves
SCHED_DEADLINE and re-enters with the same parameters while PI-boosted?

When a SCHED_DEADLINE task switches to another policy while PI-boosted (or
switches before its 0-lag time and is then PI-boosted back into
dl_sched_class, where switched_to_dl() cancels inactive_timer), its old
dl_runtime, dl_deadline, dl_period, runtime, and deadline remain in p->dl.
If the task still has positive runtime so replenish_dl_entity() does not
set dl_donor_refill, and sched_setattr() switches it back to
SCHED_DEADLINE with identical parameters while still boosted, prev_class
and next_class are both &dl_sched_class (so ENQUEUE_CLASS is not set) and
the parameter comparison above is false.  At deboost, dl_deboost() sees
both dl_donor_refill =3D=3D 0 and dl_new_params =3D=3D 0 and skips
update_dl_entity(), letting the task consume its old leftover runtime
before the old deadline.

[Severity: Medium]
When sched_setattr() shrinks the parameters of an unboosted task blocked
on an rt_mutex, does rt_mutex_adjust_pi() use a stale p->dl.deadline?

For a task blocked waiting on an rt_mutex (dl_task_pi_blocked(p) is true
and task_on_rq_queued(p) is false), sched_change_end() does not call
enqueue_task_dl(); prio_changed_dl() returns early because the task is not
queued, and switched_to_dl() only replenishes when p->dl.deadline is
already in the past:

kernel/sched/deadline.c:switched_to_dl() {
	...
		if (dl_task_pi_blocked(p) && !p->dl.dl_throttled &&
		    dl_time_before(p->dl.deadline, rq_clock(rq)))
			replenish_dl_new_period(&p->dl, rq);
	...
}

When __sched_setscheduler() then calls rt_mutex_adjust_pi(p),
dl_new_params is still pending and update_dl_entity() has not run, so an
overflowing remaining runtime does not advance p->dl.deadline to a new
period before the waiter tree and lock owner boost are updated.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795116790.gi=
t.mathieu.desnoyers@efficios.com?part=3D32
