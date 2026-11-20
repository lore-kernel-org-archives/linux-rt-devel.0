Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209854;
	b=PYgDApCk1Fhw+094gFs/z/ETEZmNjInxMi/BtFwgTeQHpxPtqiCuVWsuEmRGUaF8DFrX
	 fJHSFfLrF1aiQH/Uy8S9m04S23RTrgtq/ZzE4MeJCfe/DU1oot3QDFOdrezuzp6cRxdux
	 4eTCOMHRcFoHAQ410PSNjymPVFdU5w+Hjj0bhXJQ0tGz80rzPgtCGsNRPjaWmyMPBit8g
	 XyVuDm+MR0mVW+H3SAS4vksJz4OB+wAWtoDcwl/QUr/wAmP+U2Q6eJliH94l210fWCFuM
	 O/3HZBcdv+KqPQSPzs11dc0iOSmTmRIckZUZSRX8lay4dkFqv/xqG41pDuqMHSE2Mrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209854;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zRoJRslp6kqg0jms8lDN9+y86oBP3loPDzrCd/J/5vM=;
	b=cUNrccNbCQRqWQUSWT60VWuOF/7zI9CS5G+Dk5dMYGeP8DvOT9tOMfakxFw+ProdXrlO
	 5LN/a/C87e2SPownfgX/EFBQxT+shVf2kJ9MuADCKpG9Af+XVSBfm4ZA4M0bXNTuwefjA
	 KwOiSwd+yipAyESGN98oySWeWSCbITz/IeTGYoraXDzY1hW3M/fDgpwBXaohX6hckQGMb
	 b/GRdDodILntPs7vuSXZ66Oq/bAH8+KxSq35/twSx4Dvho/WbuvYTJy2wKhXoqahMdDbZ
	 wFsRcah47QD49FXffenx1fk7uezbtFXUvHxe9o49M05nwLFAXts9P6htGHcf2AbIiUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehWSoh3v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68220606A6A0;
	Fri, 20 Nov 2026 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehWSoh3v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E401F000C6;
	Fri, 20 Nov 2026 21:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209854;
	bh=zRoJRslp6kqg0jms8lDN9+y86oBP3loPDzrCd/J/5vM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ehWSoh3vh0Bp2lJD4iG1lVr4iqAk03IUX2TG/GestpqNf1IJ1xMzsSTEphFc9dNMd
	 zzsOoeHLMwQVc1AYOsdOe76YNoNtwC8JYCpSQIMBzyhbqjjSDMPVeo2mCsA+edigFO
	 Mj+pyZ7Fx5OXfoFtoajILx+eLUFlwzRwiBeVby+0ddg8CMR4h6AdfHpgwQ2h5BgCxB
	 1PQEHOYH+aLvKHx4MG2rk6NOaisHcjNDbByM8bIr7RnTC0aC986hQD0QSvFgaH+Fxa
	 xOn1cxHipIp20Vg3R7SAAZAatvIJkpItonvrij2jkhkDlDHvbpJ6hoqhq0tY9zAGk7
	 5z9LbznMEUm0w==
Message-ID: <sashiko-outbox-226170@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 30/40] sched/deadline: Start a period for a task
 requeued onto an rt_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <6c7be87e201d405bdf589989cb45afca9160c2e4.1795207232.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <6c7be87e201d405bdf589989cb45afca9160c2e4.1795207232.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:24:13 +0000
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
- [Medium] sched/deadline: dl_proxy_block() skips period start for
  PI-boosted tasks
- [Medium] locking/rtmutex: proxy lock steal uses stale deadline before
  dl_proxy_block()
- [Medium] sched/deadline: missing dl_entity_overflow() check in
  dl_proxy_block()
- [Medium] sched/deadline: dl_proxy_block() skips period start for zero
  constrained deadline
--

commit ccbb5e6cd761023e5e38a79f3d3be937fad4a331
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Start a period for a task requeued onto an rt_mutex

This commit adds dl_proxy_block() to start a new period for a sleeping
SCHED_DEADLINE task when it is proxy-locked onto an rt_mutex, so the
waiter node does not use a deadline of 0 or a deadline in the past.

> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index b09816977d4e5..5ff123d24b2a6 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1245,6 +1245,9 @@ static int __sched task_blocks_on_rt_mutex(struct r=
t_mutex_base *lock,
>  		return -EDEADLK;
> =20
>  	raw_spin_lock(&task->pi_lock);
> +	/* A proxy lock: @task sleeps, and its deadline can be stale. */
> +	if (task !=3D current)
> +		dl_proxy_block(task);
>  	waiter->task =3D task;
>  	waiter->lock =3D lock;
>  	waiter_update_prio(waiter, task);

[Severity: Medium]
Can __rt_mutex_start_proxy_lock() steal the rt_mutex using a stale
task->dl.deadline before task_blocks_on_rt_mutex() runs dl_proxy_block()?

__rt_mutex_start_proxy_lock() calls try_to_take_rt_mutex(lock, task, NULL)
before calling task_blocks_on_rt_mutex().  When the target PI futex has
just been unlocked and is in the handoff state with waiters,
try_to_take_rt_mutex() tests rt_mutex_steal(task_to_waiter(task),
rt_mutex_top_waiter(lock)), which reads task->dl.deadline before
dl_proxy_block() refreshes it:

kernel/locking/rtmutex.c:try_to_take_rt_mutex() {
    ...
		if (rt_mutex_has_waiters(lock)) {
			/* Check whether the trylock can steal it. */
			if (!rt_mutex_steal(task_to_waiter(task),
					    rt_mutex_top_waiter(lock)))
				return 0;
    ...
}

A requeued task with a deadline of 0 or a passed deadline can then steal
the lock from a woken top waiter with an earlier real deadline, and
because try_to_take_rt_mutex() does not call rt_mutex_adjust_prio(), the
new owner remains unboosted once wakeup assigns its real later deadline.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b1346be9e81da..1c5888b1717de 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1573,6 +1573,36 @@ static inline u64 dl_next_period(struct sched_dl_e=
ntity *dl_se)
>  	return dl_se->deadline - dl_se->dl_deadline + dl_se->dl_period;
>  }
> =20
> +#ifdef CONFIG_RT_MUTEXES
> +/*
> + * FUTEX_CMP_REQUEUE_PI makes @p wait on an rt_mutex while @p sleeps.
> + * The waiter node of @p takes its deadline, before any wakeup. @p would
> + * not run with a deadline of 0, which it has if it entered the class
> + * asleep. Nor would it run with a deadline that has passed. Start a new
> + * period then, as its wakeup would. Leave a task past its deadline and
> + * before its next period: its wakeup throttles it until that period.
> + *
> + * The caller holds the pi_lock of @p.
> + */
> +void dl_proxy_block(struct task_struct *p)
> +{
> +	struct sched_dl_entity *dl_se =3D &p->dl;
> +	struct rq_flags rf;
> +	struct rq *rq;
> +
> +	if (!dl_task(p) || is_dl_boosted(dl_se) || !dl_se->dl_runtime)
> +		return;

[Severity: Medium]
Does returning early on is_dl_boosted(dl_se) or !dl_se->dl_runtime leave
p->dl.deadline at 0 (or expired) when p was PI-boosted while sleeping in
FUTEX_WAIT_REQUEUE_PI?

While p sleeps in futex_wait_requeue_pi(), p is not queued and
p->pi_blocked_on is NULL (so dl_task_pi_blocked(p) is false).  If p holds
another rt_mutex and a SCHED_DEADLINE waiter blocks on it, both
dl_boost_blocked() and switched_to_dl() skip replenish_dl_new_period()
because dl_task_pi_blocked(p) is false, leaving p->dl.deadline at 0 or at
a passed deadline.  When FUTEX_CMP_REQUEUE_PI then requeues p onto a
second rt_mutex, dl_proxy_block() returns early instead of starting a
period from pi_of(dl_se), and waiter_update_prio() copies the 0 or
expired deadline into waiter->tree.deadline.

> +	rq =3D __task_rq_lock(p, &rf);
> +	update_rq_clock(rq);
> +	if (!task_on_rq_queued(p) && !dl_se->dl_throttled &&
> +	    dl_time_before(dl_se->deadline, rq_clock(rq)) &&
> +	    (dl_is_implicit(dl_se) ||
> +	     !dl_time_before(rq_clock(rq), dl_next_period(dl_se))))
> +		replenish_dl_new_period(dl_se, rq);

[Severity: Medium]
Should an implicit-deadline task also start a new period here when
dl_entity_overflow(dl_se, rq_clock(rq)) is true?

When an implicit-deadline task sleeps in FUTEX_WAIT_REQUEUE_PI past its
0-lag time (or has its parameters shrunk via sched_setattr() while
sleeping) and is requeued before its old dl_se->deadline passes,
dl_entity_overflow(dl_se, rq_clock(rq)) is already true.  Because the
task is asleep, update_dl_entity() will unconditionally see
dl_entity_overflow() (or a passed deadline) at wakeup and call
replenish_dl_new_period().  Without checking dl_entity_overflow() in
dl_proxy_block(), waiter_update_prio() copies the old dl_se->deadline that
the task would never run with, causing it to sort ahead of waiters whose
deadlines are earlier than its wakeup deadline.

[Severity: Medium]
What happens if a constrained-deadline task has dl_se->deadline =3D=3D 0 wh=
en
rq_clock(rq) is still before dl_next_period(dl_se)?

If sched_setattr() switches a task sleeping in FUTEX_WAIT_REQUEUE_PI to
SCHED_DEADLINE with dl_deadline < dl_period, dl_se->deadline is 0.
Because dl_is_implicit(dl_se) is false, dl_proxy_block() evaluates
dl_next_period(dl_se), which computes dl_period - dl_deadline (or
dl_period after commit "sched/deadline: Keep the start of the period
across a change of dl_deadline") as if a period had started at t =3D 0.  If
rq_clock(rq) < dl_next_period(dl_se), dl_proxy_block() skips
replenish_dl_new_period() and leaves waiter->tree.deadline at 0.  Checking
!dl_se->deadline before testing dl_next_period(dl_se) would avoid this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D30
