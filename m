Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795659362;
	b=Px8zhEyVl7oLmhhElxk/7FlU4Qw5FRK0/Q95ZNP5c6zdxKCEGGcrMjdyDAoxcNUMYsEI
	 UeWNS7cV496Tt+x8Axu0YCmkRUouayi5BNzM0WzujnJz9oHeMlvmEqTbkn5G+WvdYS0oY
	 dNCMR6GO4KmXTRoVO+Y8/dsrhmFBOCa6cgT69yqHqtu3PmGrv3Em5NreqJhRHhyuZQkUY
	 Rh90sP2HDfojPyGxUzJdTG2AFwW+7NpGJipzNmvHplpWOoLbmEXnORa31TMjwQT/q/MpH
	 UlEM8dfwl9R1bzzQMt2G7X3yi9hSLgMgLr+FWkuFQhLpRivlrp36D2qxWvHY2ODXeAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795659362;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YcWL6NeReKp9UVG73s6Un/SgTGue3iuXucJPd6Xahhg=;
	b=y2xLG4QeWDKp7yLn0QSlbeGodbXgXr1ywtvq+zaPu1ZSVQR+gEVVlEqCgzx8DM88bmVm
	 HkHzGyxf64Lt55YOt4PJX0Q8BYDVEJtEfaT/mtxZZbB8QJIivQKATmfMNqw5HoxOWHX6T
	 CTh6RTHeNGWsmAul1bLcL+8EEV0QqlVOZNjrcnVkg6ENDaXb4BG3JdRQtAApb+X2z9vEf
	 LiAhssaaCGGcNs6kfJnCsPgy46k722rzMhHthHkkzoDjxehzzPBlFprBFuJW6XUJRDnMM
	 39FpovHG1vmi8eGdR0BVuLtrhATVYv2Vu1ku1i/dYxgst4qKCL1trtjr/mZ2GMFb1Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVMnd2xL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99028606A32C;
	Thu, 26 Nov 2026 02:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nVMnd2xL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EFB1F000D2;
	Thu, 26 Nov 2026 02:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795659362;
	bh=YcWL6NeReKp9UVG73s6Un/SgTGue3iuXucJPd6Xahhg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nVMnd2xLR+WE9FQPgiLyvhh9fZ+PSY5fguwxx0jWt++LxTgyyFtupI38S7L/hD42F
	 +wKe1h1UBzaB8mfo9t7exRNhz61N5Vw+W5n9FMsmVNJ1EF+J5PdgFQm/Hkv/o+nZTT
	 unYYk7M2642PrZAT7FtZb91kWmmPNvGqCBe/2NjnchUBQOExZDpeuODUIgRn9udvNi
	 2iXqs6l52ki6t2VaIK53Df1lY7tbwkCU+f2XDDp67RhAJp5/4PE6KIw3L9o0X7xkTH
	 XmX34i5YQRLEwNgcpWBML2MnfZYVA+8CDJjXdp/iD15mAvZVcQMMuQst3io97Nz52E
	 oQQ8CZU35jyZg==
Message-ID: <sashiko-outbox-234632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 37/43] sched/deadline: Keep the debt of a task
 across a change of parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <33e066447added164bbf6c39e0e4de022d7ecc7e.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <33e066447added164bbf6c39e0e4de022d7ecc7e.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 02:16:01 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [Medium] sched/deadline: unthrottled zero-runtime wakeup in
  dl_setattr_place()
- [Medium] sched/deadline: deferred boost debt and timer race in
  dl_setattr_period()
- [Medium] sched/deadline: missing zero-deadline check in
  dl_in_constrained_gap()
- [Medium] sched/deadline: redundant update_dl_entity() check after
  dl_setattr_period()
- [Medium] sched/deadline: mismatched period fitting in
  dl_drop_boost_out()
- [Medium] sched/deadline: own_runtime zeroed before debt calc in
  dl_hold_refilled_boost()
- [Medium] sched/deadline: extra period bw retention when
  dl_task_timer() refills departed task
- [Medium] sched/deadline: stale inactive_timer when sched_setattr()
  keeps same dl_bw
--

commit c657dc02c2b65f18247904268d2a021787f80d4c
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep the debt of a task across a change of parameters

This commit fits the period in progress of a SCHED_DEADLINE task to new
parameters across sched_setattr() so that any accumulated runtime debt is
preserved and repaid at the new bandwidth.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 23186eb9968e8..1ec7789e81b86 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -130,6 +132,19 @@ static inline bool dl_end_held_boost(struct sched_dl=
_entity *dl_se)
>  	return true;
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
> +	       dl_time_before(now, dl_se->period_start + dl_se->dl_period);
> +}

[Severity: Medium]
Should dl_in_constrained_gap() check that dl_se->deadline is non-zero
first, as dl_proxy_block() does?

For a task new to SCHED_DEADLINE (or after __dl_clear_params()), both
deadline and period_start are 0.  If the task is blocked on an rt_mutex
and given a constrained deadline while rq_clock(rq) < dl_se->dl_period,
dl_in_constrained_gap() returns true, so both dl_check_blocked_params()
and switched_to_dl() skip starting a period and leave deadline =3D=3D 0 in
the task's rt_mutex waiter node.

[ ... ]

> @@ -227,12 +272,80 @@ void dl_deboost(struct sched_dl_entity *dl_se)
[ ... ]
> +void dl_drop_boost_out(struct sched_dl_entity *dl_se)
> +{
> +	bool saved =3D dl_se->dl_setattr_saved && !dl_se->dl_donor_refill;
> +
> +	dl_drop_boost(dl_se);
> +	if (saved)
> +		dl_setattr_period(dl_se, dl_se->setattr_runtime,
> +				  dl_se->setattr_deadline, dl_se->setattr_period);
> +}

[Severity: Medium]
Does dl_drop_boost_out() fit the period with different rules from the
ones switched_from_dl() just used to arm inactive_timer?

When a boosted task with dl_setattr_saved leaves SCHED_DEADLINE,
switched_from_dl() runs first and computes the 0-lag time via
dl_zerolag_period(), which calls dl_setattr_place() with run =3D false
(so keep =3D 0).  dl_drop_boost_out() then calls dl_setattr_period(),
which passes run =3D !dl_se->dl_throttled && !asleep.  For a queued or
pi-blocked task with runtime > 0, dl_setattr_place() keeps up to
dl_runtime, pushes period_start and deadline past the 0-lag time that
inactive_timer was armed for, and leaves runtime =3D keep unthrottled (or,
when keep =3D=3D 0 and debt > 0, sets dl_throttled =3D 1 and arms dl_timer =
on
a task that has already left SCHED_DEADLINE).

[ ... ]

> @@ -1934,6 +2108,10 @@ static enum hrtimer_restart dl_task_timer(struct h=
rtimer *timer)
>  		if (dl_se->dl_throttled && !is_dl_boosted(dl_se)) {
>  			sched_clock_tick();
>  			update_rq_clock(rq);
> +			/* Not before the next period: see below. */
> +			if (dl_time_before(rq_clock(rq), dl_next_period(dl_se)) &&
> +			    start_dl_timer(dl_se))
> +				goto unlock;
>  			replenish_dl_entity(dl_se);
>  		}
>  		goto unlock;

[Severity: Medium]
When a throttled constrained-deadline task leaves SCHED_DEADLINE, can
replenishing it here in dl_task_timer() cause inactive_task_timer() to
hold its bandwidth for an extra period?

Both dl_timer and inactive_timer are armed for dl_next_period(dl_se)
(or dl_timer fires first when an overrun places the 0-lag time after
dl_next_period(dl_se)).  When dl_task_timer() runs replenish_dl_entity(),
it advances dl_se->period_start by dl_period, so inactive_task_timer()
then sees dl_next_period(dl_se) - rq_clock(rq) > 0 and restarts itself
for another full period before releasing total_bw:

kernel/sched/deadline.c:inactive_task_timer() {
    ...
	if (!dl_task(p) && READ_ONCE(p->__state) !=3D TASK_DEAD &&
	    !dl_is_implicit(dl_se)) {
		s64 left =3D dl_next_period(dl_se) - rq_clock(rq);

		if (left > 0) {
			ktime_t at =3D ktime_add_ns(hrtimer_cb_get_time(timer), left);

			hrtimer_set_expires(timer, at);
			task_rq_unlock(rq, p, &rf);
			return HRTIMER_RESTART;
		}
	}
    ...
}

[ ... ]

> @@ -3159,12 +3361,13 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, =
int flags)
>  		update_dl_entity(dl_se);
>  	} else if (flags & ENQUEUE_REPLENISH) {
>  		replenish_dl_entity(dl_se);
> -	} else if ((flags & ENQUEUE_CLASS) && !is_dl_boosted(dl_se)) {
> +	} else if (((flags & ENQUEUE_CLASS) || new_params) &&
> +		   !is_dl_boosted(dl_se)) {
>  		/*
> -		 * The task enters the class, or its parameters change, while
> -		 * it is runnable. It may come back before
> -		 * its deadline, with the runtime left from older parameters.
> -		 * Check that runtime against the new parameters,
> -		 * as a wakeup does.
> +		 * The task enters the class, or its parameters change, while
> +		 * it is runnable. It may have runtime left from older
> +		 * parameters. Check that runtime against the new parameters,
> +		 * as a wakeup does.
>  		 */
>  		update_dl_entity(dl_se);
>  	} else if ((flags & ENQUEUE_MOVE) &&

[Severity: Medium]
Does testing (flags & ENQUEUE_CLASS) here run update_dl_entity() on a
period that dl_setattr_period() has already fitted?

When a runnable task leaves SCHED_DEADLINE and re-enters before its
0-lag time with modified parameters, __setparam_dl() fits the period
via dl_setattr_period() and clears dl_new_params.  As noted in the
comment on dl_setattr_period(), running update_dl_entity() afterward
checks dl_entity_overflow() at microsecond granularity, which can see a
rounding overflow on the just-fitted period and call
replenish_dl_new_period(), wiping out the debt.  In __setparam_dl(),
the !pending guard has the same effect when dl_new_params was already
set before a change that dl_setattr_period() fits.

[ ... ]

> @@ -5325,47 +5529,298 @@ int sched_dl_overflow(struct task_struct *p, int=
 policy,
[ ... ]
> +static bool dl_setattr_place(struct sched_dl_entity *dl_se, u64 now,
> +			     u64 *start, u64 *deadline, s64 *runtime,
> +			     u64 old_runtime, u64 old_deadline, u64 old_period,
> +			     bool run, bool asleep)
> +{
[ ... ]
> +	*runtime =3D 0;
> +	if (asleep && dl_deadline < dl_period) {
> +		if (dl_time_before(next, now))
> +			next =3D now;
> +		*start =3D next - dl_period;
> +		*deadline =3D *start + dl_deadline;
> +		return false;
> +	}

[Severity: Medium]
What happens if a sleeping task with a new constrained deadline wakes up
before *deadline?

When next - now >=3D dl_period - dl_deadline (for instance, when debt
repayment exceeds the constrained gap, or when now < release + dl_deadline
forces next >=3D release + dl_period), *deadline =3D next - dl_period +
dl_deadline is in the future while *runtime is set to 0 and
dl_setattr_place() returns false (clearing dl_throttled).  If the task
wakes up before *deadline, dl_check_constrained_dl() does not throttle
it because deadline >=3D now, and dl_entity_overflow() returns false
because left =3D (dl_deadline >> DL_SCALE) * (0 >> DL_SCALE) =3D 0 is not
greater than right >=3D 0.  The task is then enqueued unthrottled with
runtime =3D=3D 0 before its next period at next.

> +	if (!dl_time_before(now, next)) {
> +		*start =3D now;
> +		*deadline =3D now + dl_deadline;
> +		*runtime =3D dl_runtime;
> +		return false;
> +	}
> +	*start =3D next - dl_period;
> +	*deadline =3D *start + dl_deadline;
> +	return true;
> +}
> +
[ ... ]
> +static bool dl_setattr_period(struct sched_dl_entity *dl_se, u64 old_run=
time,
> +			      u64 old_deadline, u64 old_period)
> +{
[ ... ]
> +	if (is_dl_boosted(dl_se)) {
> +		if (!dl_se->dl_setattr_saved && !dl_se->dl_donor_refill) {
> +			dl_se->setattr_runtime =3D old_runtime;
> +			dl_se->setattr_deadline =3D old_deadline;
> +			dl_se->setattr_period =3D old_period;
> +			dl_se->dl_setattr_saved =3D 1;
> +		}
> +		return true;
> +	}

[Severity: Medium]
When a boosted task's bandwidth is reduced before any donor refill, does
deferring the fit until deboost or refill repay the debt at the old
bandwidth instead of the new one?

sched_dl_overflow() immediately releases the old bandwidth in total_bw
at sched_setattr(), but dl_setattr_place() is only called later at the
deboost or first donor refill with that later timestamp as now.
Computing debt =3D (zerolag - now) * old_runtime / old_period at the later
timestamp credits the entire interval since sched_setattr() at
old_runtime / old_period rather than the new bandwidth.  Also, because
setattr_* are only recorded when !dl_setattr_saved, a second
sched_setattr() back to the original parameters before deboost leaves
dl_setattr_saved set and still fits against the first period's state.

> +
> +	/*
> +	 * start_dl_timer() does not move a queued timer: cancel it first. If
> +	 * its handler is already running, the cancel fails. The handler then
> +	 * waits for the rq lock. It finds the task no longer throttled, or
> +	 * arms the timer again at the next period set here.
> +	 */
> +	cancel_replenish_timer(dl_se);

[Severity: Medium]
If a sleeping task has dl_non_contending set and sched_setattr() changes
its period without changing dl_bw, can the old inactive_timer fire too
early if the task then leaves SCHED_DEADLINE?

When new_bw =3D=3D dl_se->dl_bw (for example, when changing a constrained
dl_deadline to implicit while keeping dl_runtime and dl_period, or
scaling both proportionally), dl_change_utilization() returns early and
leaves inactive_timer armed for the old 0-lag time.  dl_setattr_period()
then updates period_start, deadline and runtime, and if the sleeping
task subsequently leaves SCHED_DEADLINE, switched_from_dl() sees
p->dl.dl_non_contending =3D=3D 1 and skips task_non_contending(), so
inactive_task_timer() fires at the stale pre-setattr 0-lag time and
releases the bandwidth and clears the parameters early.

[ ... ]

> +static void dl_hold_refilled_boost(struct sched_dl_entity *dl_se)
> +{
> +	u64 old_runtime =3D dl_se->setattr_runtime;
> +	u64 old_deadline =3D dl_se->setattr_deadline;
> +	u64 old_period =3D dl_se->setattr_period;
> +	bool saved =3D dl_se->dl_setattr_saved;
> +	u64 now =3D rq_clock(rq_of_dl_se(dl_se));
> +
> +	dl_se->own_deadline =3D dl_se->deadline;
> +	dl_se->own_runtime =3D dl_time_before(now, dl_se->deadline) ?
> +			     max_t(s64, dl_se->runtime, 0) : 0;
> +	dl_se->own_period_start =3D dl_se->period_start;
> +	dl_se->dl_boost_held =3D 1;
> +	dl_se->dl_setattr_saved =3D 0;
> +	if (saved && dl_se->own_deadline && old_runtime && old_period)
> +		dl_setattr_place(dl_se, now, &dl_se->own_period_start,
> +				 &dl_se->own_deadline, &dl_se->own_runtime,
> +				 old_runtime, old_deadline, old_period, false, false);
> +}

[Severity: Medium]
Does zeroing or clamping dl_se->own_runtime before calling
dl_setattr_place() corrupt the debt calculation?

dl_setattr_place() uses the incoming *runtime to compute how much of the
old period's runtime was used (adjusting zerolag by *runtime *
old_period / old_runtime) before setting *runtime =3D 0 when run is false.
When a boosted constrained task has unused runtime (dl_se->runtime > 0)
and its first donor refill happens after dl_se->deadline (or when
sched_setattr() is called later while dl_boost_held is set), zeroing
own_runtime first makes dl_setattr_place() treat the entire old_runtime
as consumed and charge debt for runtime the task never used.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D37
