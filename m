Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658242;
	b=bG0SI9JfB8VTqZOSEEUn27D3QaSyl1FLyZdp8VClFs/gaUVTYA39BY0u14qsrgpLnf9P
	 VO/A0xL+6zycFmReZLiz/+as24J8lm0alTMJtIH2J/SpOuYfGlcjUaVVVv1VhAsehe5wi
	 m9Pu/LBK9YKQxL/JtDFlr3LqiOCoaDwIAbheTUDkhaeUtmKpROqj3iOqgLaa7ZvLzjRa2
	 Hpdol90EaXs0ZYxa4GZX9g8IE2RDA22rVx+DFdkUiERGq5hUpidOPBu59zay4oBfDVPPs
	 PCnn3rQ8zJq2YNkCceG8L1McMHyMH4vtTv6Q+pOZhPeHLr9aUdXgsjtDtH3Al7AMdLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658242;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p62QnwXnO0v/T1cHeC+iaQT9SNjiTZTWxNLljhxV0/M=;
	b=qhAGF1kgE7A6ns8N6ch2NDIXMiNSvT1ogmYPU1GQh6IFrhBbQcmEclrdudT6mMWlHoiS
	 gybgoCwOugabEEJk4h+/28uxRZjQHE06LVsoWUdtbt4I3/+oin4YRcHXYS88/FUeXvrjy
	 1+i992+8N4AgdPvI4VYkKRpjaOvVosWdhJIfurTGrjtzQxNBYtApwytnZCRrvJnMB3oPW
	 EP/t5+pUmGDNpQd9bS9fRkdvQ4yv1YzSQLNRE9HcZBzL67W3yEa42n2DlJmGBGw82X5iz
	 ZipCAS46TyOKM7eEpEF2QOJPmOBs7RzB/eBYM/sCdQ9k+KGwdnxfTGCgcdAyMMhyBSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFETayfE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A7606A326;
	Thu, 26 Nov 2026 01:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DFETayfE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEC41F000C0;
	Thu, 26 Nov 2026 01:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658242;
	bh=p62QnwXnO0v/T1cHeC+iaQT9SNjiTZTWxNLljhxV0/M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFETayfE3Gf3ynl3jwfpCR1YPetdhq1JnXUCJqm85fBvnOiaoVFNsAYd4KPGUtRuV
	 AT+6jcU+gX2Gs1jKlIfx6gOEY5s9E/vUQf2wPSlto6ok8KmOqU3qIDStY2ardkR0Df
	 g6ye8uja5xjNDqwhvDeblzIp6STGRj5VsjMN5pnbDfHIqEqEWIxio8rbO8TyZP18ob
	 5L0Ddq5TygnAsW8xQ+kaOUIqElZb6qP/oVJtCr7winzr8spVDnikymDxITkf3cbATW
	 qdg5UgDzqRsmkC2QQQuYHYQhz9nXQ/6h1MhJM1NTvEdT7zJT8THwAvrh1zSOTgVaIi
	 CuLWTR3HYuLGw==
Message-ID: <sashiko-outbox-234598@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 32/43] sched/deadline: Start a period for a task
 requeued onto an rt_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <ea269b2ab986ea98f5df5ace2a80c4b4d9d7e55f.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <ea269b2ab986ea98f5df5ace2a80c4b4d9d7e55f.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 01:57:21 +0000
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
- [Medium] sched/deadline: dl_proxy_block() skips overflow check for
  boosted tasks
- [Medium] locking/rtmutex: race in __rt_mutex_start_proxy_lock() after
  dl_proxy_block()
- [Medium] sched/deadline: dl_note_donor_refill() saves zero
  own_deadline
- [Medium] sched/deadline: missing dl_proxy_block() in
  futex_proxy_trylock_atomic()
--

commit fbb8bd3107eb7bdbd7615a1083bdbc46d1982421
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Start a period for a task requeued onto an rt_mutex

This commit adds dl_proxy_block() and calls it from
__rt_mutex_start_proxy_lock() so that a sleeping SCHED_DEADLINE task
requeued onto an rt_mutex via FUTEX_CMP_REQUEUE_PI has its deadline
updated before the trylock and waiter insertion.

> diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
> index 6bdbd36bac949..f1246efc62d3a 100644
> --- a/kernel/locking/rtmutex_api.c
> +++ b/kernel/locking/rtmutex_api.c
> @@ -342,6 +342,18 @@ int __sched __rt_mutex_start_proxy_lock(struct rt_mu=
tex_base *lock,
> =20
>  	lockdep_assert_held(&lock->wait_lock);
> =20
> +	/*
> +	 * A requeued @task sleeps, so its deadline can be stale. The trylock
> +	 * below and the waiter node both read it: update it first.
> +	 * futex_lock_pi() passes current, which is running. Its deadline is
> +	 * up to date.
> +	 */
> +	if (task !=3D current) {
> +		raw_spin_lock(&task->pi_lock);
> +		dl_proxy_block(task);
> +		raw_spin_unlock(&task->pi_lock);
> +	}

[Severity: Medium]
Can releasing task->pi_lock here before task->pi_blocked_on is set race
with sched_setattr() or PI boosting on another CPU?

If task is not in SCHED_DEADLINE when dl_proxy_block() runs, it returns
with task->dl.deadline still at 0.  Before task_blocks_on_rt_mutex()
re-acquires task->pi_lock and sets task->pi_blocked_on, another CPU can
switch or boost task into SCHED_DEADLINE:

CPU0                                  CPU1
__rt_mutex_start_proxy_lock()
  raw_spin_lock(&task->pi_lock)
  dl_proxy_block(task)
    !dl_task(task) -> returns
  raw_spin_unlock(&task->pi_lock)
                                      __sched_setscheduler(task, ...)
                                        raw_spin_lock(&task->pi_lock)
                                        switched_to_dl()
                                          !dl_task_pi_blocked(task)
                                          /* task->dl.deadline stays 0 */
                                        raw_spin_unlock(&task->pi_lock)
  try_to_take_rt_mutex() /
  task_blocks_on_rt_mutex()
    raw_spin_lock(&task->pi_lock)
    waiter_update_prio(waiter, task)  <-- copies deadline =3D=3D 0
    task->pi_blocked_on =3D waiter
    raw_spin_unlock(&task->pi_lock)

Because task->pi_blocked_on is still NULL when switched_to_dl() runs on
CPU1, switched_to_dl() leaves task->dl.deadline at 0.  CPU0 then uses
deadline 0 to steal the lock or enqueue the waiter ahead of all real
deadline waiters.

> +
>  	if (try_to_take_rt_mutex(lock, task, NULL))
>  		return 1;

[Severity: Medium]
Does the uncontended FUTEX_CMP_REQUEUE_PI fast path in
futex_proxy_trylock_atomic() also need to call dl_proxy_block() on the
new owner?

When the target PI futex is uncontended and nr_requeue >=3D 1,
futex_requeue() acquires the futex for top_waiter->task via
futex_proxy_trylock_atomic() -> futex_lock_pi_atomic(), attaches
top_waiter->task as the pi_mutex owner, and wakes it without going
through __rt_mutex_start_proxy_lock():

kernel/futex/requeue.c:futex_proxy_trylock_atomic() {
	...
	ret =3D futex_lock_pi_atomic(pifutex, hb2, key2, ps, top_waiter->task,
				   exiting, set_waiters);
	if (ret =3D=3D 1) {
		requeue_pi_wake_futex(top_waiter, key2, hb2);
	...
}

If try_to_wake_up() queues top_waiter->task on a remote CPU's wake_list
via ttwu_queue_wakelist(), enqueue_task_dl() -> update_dl_entity() has
not run yet when futex_requeue() loops to requeue the next waiter onto
that pi_mutex via rt_mutex_start_proxy_lock().  The boost check against
the new owner then sees top_waiter->task's stale deadline (0, expired, or
overflowed), which can miss a boost from a waiter or cause the subsequent
donor refill at wakeup on the remote CPU to save the unreplenished stale
deadline as own_deadline.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 5d1d4ea288788..c59953e80b1a9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1682,6 +1682,59 @@ static inline u64 dl_next_period(struct sched_dl_e=
ntity *dl_se)
>  	return dl_se->deadline - dl_se->dl_deadline + dl_se->dl_period;
>  }
> =20
> +#ifdef CONFIG_RT_MUTEXES
> +/*
> + * FUTEX_CMP_REQUEUE_PI makes @p wait on an rt_mutex while @p sleeps.
> + * The waiter node of @p takes its deadline before any wakeup. So apply
> + * the wakeup rule of update_dl_entity() to @p now:
> + * - A deadline of 0, which a task that entered the class asleep has,
> + *   gets a new period.
> + * - A constrained task past its deadline and before its next period
> + *   keeps its deadline. Its wakeup throttles it until that period. Its
> + *   waiter node keeps that passed deadline, and sorts first.
> + * - Any other task gets the check of update_dl_entity(). A deadline
> + *   that has passed gets a new period.
> + *
> + * The caller holds the pi_lock of @p.
> + */
> +void dl_proxy_block(struct task_struct *p)
> +{
> +	struct sched_dl_entity *dl_se =3D &p->dl;
> +	struct rq_flags rf;
> +	struct rq *rq;
> +
> +	if (!dl_task(p))
> +		return;
> +	rq =3D __task_rq_lock(p, &rf);
> +	update_rq_clock(rq);
> +	if (task_on_rq_queued(p) || dl_se->dl_throttled)
> +		goto unlock;
> +	/*
> +	 * A boosted task runs on the parameters of its donor. Start a period
> +	 * from them if its deadline is 0 or has passed. A task in the class
> +	 * with no runtime of its own is always boosted: the test of
> +	 * dl_runtime is only a guard.
> +	 */
> +	if (is_dl_boosted(dl_se) || !dl_se->dl_runtime) {
> +		if (!dl_se->deadline ||
> +		    dl_time_before(dl_se->deadline, rq_clock(rq)))
> +			replenish_dl_new_period(dl_se, rq);

[Severity: Medium]
When a boosted sleeping task has dl_se->deadline =3D=3D 0 and
dl_se->dl_runtime > 0, does replenish_dl_new_period() here record
own_deadline =3D 0 via dl_note_donor_refill()?

If a sleeping non-deadline task is first PI-boosted via an rt_mutex it
owns and then given its own SCHED_DEADLINE parameters via sched_setattr()
while still asleep, dl_se->dl_runtime is non-zero while dl_se->deadline
and dl_se->dl_donor_refill are still 0.  Calling replenish_dl_new_period()
from dl_proxy_block() runs dl_note_donor_refill():

kernel/sched/deadline.c:dl_note_donor_refill() {
	...
	first =3D !dl_se->dl_donor_refill;
	dl_se->dl_donor_refill =3D 1;
	if (first && dl_se->dl_runtime && !dl_se->dl_boost_held)
		dl_hold_refilled_boost(dl_se);
}

Because dl_note_donor_refill() checks dl_se->dl_runtime without checking
whether dl_se->deadline is non-zero, dl_hold_refilled_boost() saves
own_deadline =3D 0 and sets dl_boost_held =3D 1.  When the boost ends,
dl_end_held_boost() can restore dl_se->deadline =3D 0 and throttle the task
with a zero deadline, causing its waiter node to sort ahead of all real
deadlines.

> +		goto unlock;
> +	}
> +	if (!dl_se->deadline) {
> +		replenish_dl_new_period(dl_se, rq);
> +		goto unlock;
> +	}
> +	if (!dl_is_implicit(dl_se) &&
> +	    dl_time_before(dl_se->deadline, rq_clock(rq)) &&
> +	    dl_time_before(rq_clock(rq), dl_next_period(dl_se)))
> +		goto unlock;
> +	update_dl_entity(dl_se);
> +unlock:
> +	__task_rq_unlock(rq, p, &rf);
> +}

[Severity: Medium]
Should the boosted branch in dl_proxy_block() also check
dl_entity_overflow(dl_se, rq_clock(rq)) as update_dl_entity() does?

In update_dl_entity(), a boosted task whose deadline has not yet passed
still gets a new donor period when dl_entity_overflow(dl_se, rq_clock(rq))
is true:

kernel/sched/deadline.c:update_dl_entity() {
	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
	    dl_entity_overflow(dl_se, rq_clock(rq))) {
		if (unlikely((!dl_is_implicit(dl_se) ||
			      (dl_se->dl_defer && dl_se->dl_defer_running)) &&
			     !dl_time_before(dl_se->deadline, rq_clock(rq)) &&
			     !is_dl_boosted(dl_se))) {
			update_dl_revised_wakeup(dl_se, rq);
			return;
		}

		dl_se->dl_defer_running =3D 0;
		replenish_dl_new_period(dl_se, rq);
	}
}

Because dl_proxy_block() only tests !dl_se->deadline ||
dl_time_before(dl_se->deadline, rq_clock(rq)) for boosted tasks and then
jumps to unlock, a boosted task requeued after its overflow threshold but
before dl_se->deadline keeps its stale earlier deadline for the trylock,
waiter sorting, and owner boosting, even though waking it would
immediately postpone its deadline to a new donor period.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D32
