Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658236;
	b=4c5dVjhBTFGJ3XDQuyaSJpLcnLjUtZk0sxh/QWtkGX54caMO6+ZnNzHmcB5soTmY4k1N
	 yn3sU2te5tr+IlQh6GUjNCdynIF1QghQBpyrhZX0txuXlNsvR25sr6nQIfBH+IXRjULUK
	 dM7CheBNr6wgRMlw5ZUwrvAilg7mXkcXLUIQLalleSrVrttvlVhID7aTTdVXxHPRmaWyO
	 SMYWC0uzmerQgR/RIth6cR44p2n9Z26f8OA17lmaZlvQUUmao3bR7A3NyH/bcP4IPh/ZD
	 TKMkL6oeEpZ/oO/FrVptsf3YDfDU/XUq1bu52YU/R4A91fUY61Q24HVkqEcLRgEmsmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658236;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fs2eG4Yi2zV27uaUrXB2bXnJvKTyNzyfzdK5IRRK0eU=;
	b=h2XOw454y2gnU6faCKl/Mci/SJE6bvd7zo6XTbzwYJzKBvmygg91XVDS6Dvh6LfaXWf8
	 taB2VVR//SOKfBXAMWT8NVi59br/CkFtgpSBi2imY4f/Y2JW5i/8aszG3TyEWUIcAIJ0Q
	 DbT+xDNQU9NrtHp3aUvrUiEvwJc6wmVQ2pnh5xGPv7gnB1IsdOQl26WG+kdej4bTEUmiK
	 OqjEiMnym3/YQXzSLbI1LaIoLHnNOpfux+jIQkvZd8fkUYjCJF+G+/1qwEFcPrz9vhQWl
	 jI3SbX7OkHhonxSsinPh1gaCXghlUssg+JJozdlcK2SclG0yTKMQbf4VxBKCPnkgb1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9L2227m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87E606A31E;
	Thu, 26 Nov 2026 01:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z9L2227m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B1D61F000C0;
	Thu, 26 Nov 2026 01:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658236;
	bh=Fs2eG4Yi2zV27uaUrXB2bXnJvKTyNzyfzdK5IRRK0eU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z9L2227mVndcOVhD5qf+gFPJ+ek4jrt8rj0vgbDHWbMKNY8tMcWdKR6Ys/tYuo1Ta
	 3oxfIXbOwwX73WjNIs89Zk3JIgIkgs1KTstetAyzpdmiyGEGweee0nvwLreXlpCirx
	 9lT7VtG4X3VY9JPCGSpAdaJQghiCIRpf/yQsRjdYKd2mm/Rq2EYBW40PFkxP/5fhOg
	 KgigmLH0lIGgRUIfBH6kvGgCq62OfcbTSzthjOJQCA0odR4wOye467xm5471K/4K9A
	 MEqo0tSRIrRezESupiH8yLoCQc84v/H6hsMemv/rM9yPCj76ep+URtNm+g14FF4yIa
	 e1APpZNKab0Ig==
Message-ID: <sashiko-outbox-234597@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 28/43] sched/deadline: Restore the owner's period at
 a deboost in the class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <221d9b8a8508cdf0e5f3763606ca4c1faff6ee46.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <221d9b8a8508cdf0e5f3763606ca4c1faff6ee46.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 01:57:15 +0000
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
- [Medium] sched/deadline: missing dl_note_donor_refill() in
  replenish_dl_entity()
- [Medium] sched/deadline: dl_note_donor_refill() holds boost when
  deadline is 0
- [Medium] sched/deadline: running_bw under-accounting in dl_deboost()
  for blocked task
- [Medium] sched/deadline: dl_deboost() starts or arms period for
  sleeping task
--

commit 9f6872fae6d8bfd66c95f630e6a2c4067df9ded7
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Restore the owner's period at a deboost in the class

This commit saves a boosted task's own deadline and remaining runtime on
its first donor replenishment and restores or restarts its own period when
it is deboosted while staying in the deadline class.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 172fb2811d4a0..100cb4b5fdb6d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -83,6 +83,53 @@ static inline int on_dl_rq(struct sched_dl_entity *dl_=
se)
>  	return !RB_EMPTY_NODE(&dl_se->rb_node);
>  }
> =20
> +/*
> + * Start a period of the reservation of @dl_se now. The caller holds the=
 rq
> + * lock and has updated the rq clock.
> + */
> +static inline void dl_start_own_period(struct sched_dl_entity *dl_se)
> +{
> +	dl_se->deadline =3D rq_clock(rq_of_dl_se(dl_se)) + dl_se->dl_deadline;
> +	dl_se->runtime =3D dl_se->dl_runtime;
> +}
> +
> +/*
> + * Put back the deadline and runtime saved when the boost was held, by
> + * dl_hold_refilled_boost(). If the task's own next period has started
> + * since, start a period of its own instead. Return true if the boost was
> + * held. The caller holds the rq lock and has updated the rq clock.
> + */
> +static inline bool dl_end_held_boost(struct sched_dl_entity *dl_se)
> +{
> +	u64 now =3D rq_clock(rq_of_dl_se(dl_se));
> +	u64 next =3D dl_se->own_deadline - dl_se->dl_deadline + dl_se->dl_perio=
d;
> +
> +	if (!dl_se->dl_boost_held)
> +		return false;
> +	if (dl_time_before(now, next)) {
> +		dl_se->deadline =3D dl_se->own_deadline;
> +		dl_se->runtime =3D dl_se->own_runtime;
> +		/*
> +		 * Past its own deadline, the task is in its constrained gap:
> +		 * it waits for its own next period. Give back no runtime, so
> +		 * that dl_deboost() throttles it. Before its deadline,
> +		 * dl_hold_refilled_boost() can keep runtime left, from a
> +		 * wakeup refill. Cap it at what the task's own density allows
> +		 * until its deadline, as update_dl_revised_wakeup() does.
> +		 */
> +		if (!dl_time_before(now, dl_se->deadline))
> +			dl_se->runtime =3D 0;
> +		else if (dl_se->runtime > 0)
> +			dl_se->runtime =3D min_t(s64, dl_se->runtime,
> +					       (dl_se->dl_density *
> +						(dl_se->deadline - now)) >> BW_SHIFT);
> +	} else {
> +		dl_start_own_period(dl_se);
> +	}
> +	dl_se->dl_donor_refill =3D 0;
> +	return true;
> +}
> +
>  #ifdef CONFIG_RT_MUTEXES
>  static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_s=
e)
>  {
> @@ -93,12 +140,104 @@ static inline bool is_dl_boosted(struct sched_dl_en=
tity *dl_se)
>  {
>  	return pi_of(dl_se) !=3D dl_se;
>  }
> +
> +static void dl_hold_refilled_boost(struct sched_dl_entity *dl_se);
> +
> +/*
> + * Record that a replenishment changes the runtime of @dl_se while it is
> + * boosted. At the first refill, dl_hold_refilled_boost() saves the
> + * task's own deadline and runtime. Call this before the replenishment
> + * adds runtime or moves the deadline. A task with no parameters of its
> + * own at the first refill has no period to save. Later refills of the
> + * same boost save nothing, even if the task gets parameters meanwhile.
> + */
> +static inline void dl_note_donor_refill(struct sched_dl_entity *dl_se)
> +{
> +	bool first;
> +
> +	if (!is_dl_boosted(dl_se))
> +		return;
> +	first =3D !dl_se->dl_donor_refill;
> +	dl_se->dl_donor_refill =3D 1;
> +	if (first && dl_se->dl_runtime && !dl_se->dl_boost_held)
> +		dl_hold_refilled_boost(dl_se);
> +}

[Severity: Medium]
Can dl_note_donor_refill() call dl_hold_refilled_boost() when
dl_se->deadline is still 0?

If an rt_mutex owner is boosted while sleeping on a non-PI waitqueue and is
given SCHED_DEADLINE parameters via sched_setattr() before waking up,
__setparam_dl() sets dl_se->dl_runtime > 0 while leaving dl_se->deadline at
0 because the task is not queued.  When the task wakes up while still
boosted, update_dl_entity() -> replenish_dl_new_period() ->
dl_note_donor_refill() sees dl_se->dl_runtime !=3D 0 and calls
dl_hold_refilled_boost(), saving own_deadline =3D 0 and own_runtime =3D 0 w=
ith
dl_boost_held =3D 1 even though the task has never started a period of its
own.

At deboost, if dl_time_before(now, next) holds in dl_end_held_boost(), it
restores dl_se->deadline =3D 0 and dl_se->runtime =3D 0 and throttles the t=
ask
instead of starting its first own period.  With commit "sched/deadline:
Keep the debt of a task across a change of parameters" later in this
series, a subsequent sched_setattr() while running in this held boost sees
own_runtime =3D=3D 0 and starts the task's own period while it is still
boosted, consuming its own deadline window while running for the donor.
Also, prior to commit "sched/deadline: Boost an owner that cannot run on
its own reservation" later in this series, another rt_mutex_setprio() on
the sleeping task evaluates dl_time_before(pi_task->dl.deadline, 0) as
false and deboosts it.

Checking dl_se->deadline !=3D 0 before calling dl_hold_refilled_boost() wou=
ld
leave only dl_donor_refill =3D 1 set so deboost starts a fresh own period.

> +
> +static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_t=
ask);
> +static int start_dl_timer(struct sched_dl_entity *dl_se);
> +
> +/*
> + * End the boost of @dl_se, whose task stays in the class. Then bring the
> + * runtime and the deadline of the task back to its own parameters:
> + *  - After a held boost, dl_end_held_boost() puts back the values that
> + *    dl_hold_refilled_boost() saved. The time the task ran on the
> + *    donor's refills is not charged to its own runtime. If that runtime
> + *    is used up, throttle the task again until its own next period, or
> + *    start that period if it has started.
> + *  - After a refill of a task that had no parameters of its own at the
> + *    refill, start a new period now.
> + *  - Without a refill, the task keeps the runtime and the deadline of i=
ts
> + *    own reservation.
> + * Do it now: the next enqueue is too late for a task blocked on another
> + * rt_mutex. The chain walk copies its deadline into its waiter node fir=
st.
> + *
> + * The caller holds the rq lock and the pi_lock of the task, and has
> + * updated the rq clock.
> + */
> +void dl_deboost(struct sched_dl_entity *dl_se)
> +{
> +	struct task_struct *p =3D dl_task_of(dl_se);
> +	bool held =3D dl_end_held_boost(dl_se);
> +	bool own =3D held;
> +
> +	if (dl_se->dl_donor_refill) {
> +		dl_start_own_period(dl_se);
> +		own =3D true;
> +	}
> +	/*
> +	 * If the task blocked while boosted, its inactive timer can be armed
> +	 * from the runtime and deadline of the donor's refills. Cancel it, and
> +	 * work out the 0-lag time again from the runtime and deadline the task
> +	 * gets back.
> +	 * If the timer handler is already running, it releases the
> +	 * bandwidth.
> +	 */
> +	if (own && dl_se->dl_non_contending &&
> +	    hrtimer_try_to_cancel(&dl_se->inactive_timer) =3D=3D 1) {
> +		dl_se->dl_non_contending =3D 0;
> +		put_task_struct(p);
> +		task_non_contending(dl_se, true);
> +	}

[Severity: Medium]
Can this leave rq->dl.running_bw under-accounted when a task blocks after a
donor refill and is deboosted while still blocked?

When a boosted deadline task blocks after a donor refill (with
dl_boost_held set), dequeue_dl_entity() calls task_non_contending() ->
dl_time_to_zerolag(), which compares the donor's refilled dl_se->runtime
against the task's own dl_runtime and dl_period:

kernel/sched/deadline.c:dl_time_to_zerolag() {
    ...
	if (dl_se->runtime > mul_u64_u64_div_u64(left, dl_se->dl_runtime,
						 dl_se->dl_period)) {
		return -1;
	}
    ...
}

If the donor's remaining runtime exceeds what the task's own bandwidth
could leave, dl_time_to_zerolag() returns -1 (or an early 0-lag time whose
inactive_timer expires before the task's own 0-lag time), so
task_non_contending() calls sub_running_bw() immediately and leaves
dl_se->dl_non_contending =3D=3D 0.  When dl_deboost() later restores the ta=
sk's
exhausted own_runtime and own_deadline while the task is still blocked,
dl_se->dl_non_contending is 0, so the task's dl_bw is not added back to
rq->dl.running_bw and inactive_timer is not armed for its true 0-lag time,
allowing GRUB tasks on the runqueue to reclaim bandwidth the task already
used in its period.

> +	dl_drop_boost(dl_se);
> +
> +	/*
> +	 * A held boost can end before the task's own next period, with its
> +	 * own runtime used up. Throttle the task until that period. If
> +	 * start_dl_timer() finds that the period has already started, start
> +	 * it now.
> +	 */
> +	if (held && dl_se->runtime <=3D 0) {
> +		struct rq *rq =3D task_rq(p);
> +
> +		dl_se->dl_throttled =3D 1;
> +		if (!start_dl_timer(dl_se)) {
> +			dl_se->dl_throttled =3D 0;
> +			dl_start_own_period(dl_se);
> +		} else if (task_current_donor(rq, p)) {
> +			resched_curr(rq);
> +		}
> +	}
> +}

[Severity: Medium]
Does dl_deboost() start a new period (or arm dl_timer to replenish one)
while a constrained-deadline task is sleeping on a non-PI waitqueue?

If a constrained-deadline task (dl_deadline < dl_period) holding an
rt_mutex is deboosted while sleeping (!task_on_rq_queued(p) &&
!p->pi_blocked_on), dl_end_held_boost() and dl_deboost() either call
dl_start_own_period() immediately or arm dl_timer via start_dl_timer(),
which replenishes and starts a period in dl_task_timer() while the task
remains asleep.  Because that period ticks while the task is sleeping,
waking up before the deadline causes update_dl_revised_wakeup() to trim its
runtime for the time spent asleep, and waking up in the constrained gap
between the deadline and the next period causes dl_check_constrained_dl()
to throttle the task until the following period even though it never ran.

Commit "sched/deadline: Keep the debt of a task across a change of
parameters" later in this series avoids starting a period or arming
dl_timer for an asleep constrained-deadline task in dl_setattr_place() so
that wakeup either throttles it until next or starts a fresh period on
wakeup.

[ ... ]

> @@ -1231,8 +1373,10 @@ static void replenish_dl_entity(struct sched_dl_en=
tity *dl_se)
>  			dl_se->deadline =3D rq_clock(rq);
>  			dl_se->runtime =3D 0;
>  		}
> -		if (dl_se->runtime < 0 || dl_se->dl_yielded)
> +		if (dl_se->runtime < 0 || dl_se->dl_yielded) {
>  			dl_se->runtime =3D 0;
> +			dl_note_donor_refill(dl_se);
> +		}
>  		dl_se->dl_yielded =3D 0;
>  		dl_se->dl_throttled =3D 0;
>  		return;

[Severity: Medium]
When a boosted task with !dl_se->dl_deadline is replenished after its
donor's parameters were cleared (!runtime || !deadline || !period), does
this miss calling dl_note_donor_refill(dl_se)?

The !dl_se->dl_deadline block sets dl_se->deadline =3D rq_clock(rq) and
dl_se->runtime =3D 0 without calling dl_note_donor_refill(dl_se), and zeroi=
ng
dl_se->runtime prevents the following dl_se->runtime < 0 check from calling
it either.  If sched_setattr() then gives the task SCHED_DEADLINE
parameters during the boost, dl_deboost() sees both dl_boost_held =3D=3D 0 =
and
dl_donor_refill =3D=3D 0 and leaves the task with runtime =3D=3D 0 and the =
stale
rq_clock(rq) deadline instead of starting its own period (or a subsequent
donor refill sees first =3D=3D true and saves that artificial deadline and 0
runtime as own_deadline and own_runtime).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D28
