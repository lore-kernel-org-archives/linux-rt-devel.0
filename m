Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830512;
	b=Chzm1wHSE3SCBTdAllyi6wC5mEx4HHUPJ8y982l3sAlOYUlplJTMx5SS0jKJToakW2LL
	 eUYCqFqsx8rQ9mVSuAM4Jy0fI97tHw1Y7YtNkD8Hjon81AVyIWBy4IuaggeeSvAFwu+QF
	 QeMkXeeus5XO04ZPNEspx5SaexTiJynIyB52VmBSYRzKXe0cgFBIQifQT7Q/hraThnNbt
	 wWWN6xWWZthbRSSopLcOYFk2hgwrJ97acMXUGViTa8Ipr0S1lYDicEe/XferF3MfDDqSn
	 Gb5QyRSwikVgESyxPpaVOYCGoNparPVA4XQejXVRld8WzUGdB5qmxDMCiwlW00SA9kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830512;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3P7gTlrJaFuH0TDPhEdUMNCwq87nzqSEsIEvJ7B0CPI=;
	b=JlVUEHKYWEk5/7+Ud214mtGEKuR1WtI1DFnTqEUBKtP4jlYZSQgCaJAPLt9LoAjvxKlu
	 SMmHYd/vpEfZDymoZFKgf2ThW+lPksWkMo1Qrm1u/JNWuj6GckIIfpTiRkIKwn/PB6R4I
	 55+YKW5nbHUF3fxCNm5P3uukmmdjdw3EwOfvUBja+qeFxDzWRG6YuaE++H/s5qvhpDtaQ
	 WAcMa8fw7zPHJLURzEpvaBi2BDik36CgneENByybPL/mmPGsZHxfcrkSdk6uUqcBXKdzi
	 bzNKzsuqPe6jLp6T/+mh6VQLYY+/aJ3PyYi+KUJod8b4GjB796YgjQuSSNi57O7RjDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GV2Z+Fwi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBC8606A851;
	Wed,  4 Nov 2026 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GV2Z+Fwi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435B31F000C1;
	Wed,  4 Nov 2026 22:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793830511;
	bh=3P7gTlrJaFuH0TDPhEdUMNCwq87nzqSEsIEvJ7B0CPI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GV2Z+FwiOrCOzohORPu8V0RlDDAInoj4XU/F9gJUOlYM4ogLoeSYQdEkNm9+pLYXb
	 vbH8wvuy1orZYyw8cr07JORWhplQ2GIhGIP18sHOVdBYMi6ipWc/oLcIVge2ONX4QE
	 yqd6Cb9NesfYDIx2xFR9FxOFTm6b0HpQSHdzierMbsd8AtEb1lTuE45khd5yQ4fslg
	 YY6fOg+ajpIlk5G5dBbghXCtsdBsYo+dIJloVBmn+mfCu8wNZgAHJYUWCcs9RertZZ
	 rNzMZ6OjfTvF/eqhnEhYer3JYt0Ax9F98fXsKH+2CzSjAdq91EHdCnrUexjffspMQh
	 sxg7FZlgUj0xw==
Message-ID: <sashiko-outbox-198212@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/21] sched/deadline: Do not release a departing
 sleeper's bandwidth twice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261104211207.1392343-8-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-8-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 22:15:10 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched/deadline: switched_from_dl() leaves stale params after clear=
ing dl_bw
--

commit 3a2d0df92966c3d09add14a543e55863d8af1e1e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not release a departing sleeper's bandwidth twice

This commit updates switched_from_dl() to only release total_bw when a
departing sleeping task has its own deadline parameters and is not a
special entity, and clears p->dl.dl_bw afterward so that subsequent paths
do not subtract its bandwidth a second time.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b646063a7b0d5..624cabdec9652 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3573,6 +3573,8 @@ static void switched_from_dl(struct rq *rq, struct =
task_struct *p)
>  	dec_dl_tasks_cs(p);
> =20
>  	if (!task_on_rq_queued(p)) {
> +		bool released =3D false;
> +
>  		if (p->dl.dl_non_contending) {
>  			/*
>  			 * Inactive timer is armed. However, p is leaving
> @@ -3585,12 +3587,18 @@ static void switched_from_dl(struct rq *rq, struc=
t task_struct *p)
>  			 * release total_bw via __dl_sub().
>  			 */
>  			sub_running_bw(&p->dl, &rq->dl);
> -		} else {
> +		} else if (p->dl.dl_runtime && !dl_entity_is_special(&p->dl)) {
>  			/*
>  			 * No pending inactive timer: the task never ran as
>  			 * DEADLINE or the timer already fired while still
>  			 * DEADLINE (only dropping running_bw at that time).
>  			 * Nobody else will release total_bw, do it now.
> +			 *
> +			 * Not for a task without parameters of its own, one
> +			 * deboosted from priority inheritance, whose mask may
> +			 * have no active CPU for dl_task_root_domain_cpu(),
> +			 * nor for a special one: neither has bandwidth in
> +			 * total_bw.
>  			 */
>  			unsigned int cpu =3D dl_task_root_domain_cpu(p);
>  			struct dl_bw *dl_b =3D &cpu_rq(cpu)->rd->dl_bw;
> @@ -3598,8 +3606,29 @@ static void switched_from_dl(struct rq *rq, struct=
 task_struct *p)
>  			raw_spin_lock(&dl_b->lock);
>  			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
>  			raw_spin_unlock(&dl_b->lock);
> +			released =3D true;
>  		}
>  		sub_rq_bw(&p->dl, &rq->dl);
> +		/*
> +		 * Released: its bandwidth is no one's to release again, and
> +		 * a dl_bw of 0 is what every path that would takes. Kept, it
> +		 * would make the task one with bandwidth to task_contending()
> +		 * and task_non_contending() once priority inheritance boosts
> +		 * it, and a deboost while it sleeps would release it a second
> +		 * time. So would the inactive timer's handler when it runs
> +		 * late, dl_non_contending cleared under it by
> +		 * migrate_task_rq_dl(): it finds !dl_task(p).
> +		 *
> +		 * The parameters themselves stay, where
> +		 * inactive_task_timer() resets them with the bandwidth: the
> +		 * task may still be the donor of a priority inheritance
> +		 * boost until rt_mutex_adjust_pi() walks the chain, outside
> +		 * this runqueue lock, and replenish_dl_entity() of the
> +		 * boosted owner would never leave its loop over a dl_period
> +		 * and a dl_runtime of 0.
> +		 */
> +		if (released)
> +			p->dl.dl_bw =3D 0;

[Severity: High]
When switched_from_dl() takes the !p->dl.dl_non_contending branch, there is
no pending inactive timer to run inactive_task_timer() and call
__dl_clear_params(&p->dl) later. Does clearing only p->dl.dl_bw here leave
the departed task permanently carrying stale deadline parameters
(dl_runtime, dl_deadline, dl_period, dl_density, flags, runtime, and
deadline) after it switches to another policy such as SCHED_OTHER?

Several paths in kernel/sched/deadline.c check dl_deadline, dl_runtime, or
flags rather than dl_bw to distinguish a PI-boosted non-deadline task from
a task with its own deadline reservation:

1. In replenish_dl_entity(), initial replenishment for a PI-boosted task
checks dl_se->dl_deadline =3D=3D 0:

kernel/sched/deadline.c:replenish_dl_entity() {
	if (dl_se->dl_deadline =3D=3D 0 ||
	    (dl_se->dl_defer_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
		dl_se->deadline =3D rq_clock(rq) + pi_of(dl_se)->dl_deadline;
		dl_se->runtime =3D pi_of(dl_se)->dl_runtime;
	}
}

If the departed task is later PI-boosted by a SCHED_DEADLINE waiter while
holding an rt_mutex, dl_se->dl_deadline is still non-zero. If its stale
p->dl.runtime is still positive and p->dl.deadline is still in the future,
replenish_dl_entity() skips both the while (dl_se->runtime <=3D 0) loop and
the dl_time_before(dl_se->deadline, rq_clock(rq)) check, so the boosted
task runs with its own stale runtime and deadline instead of inheriting the
donor's parameters. Conversely, if the task never ran as SCHED_DEADLINE
(p->dl.deadline =3D=3D 0, p->dl.runtime =3D=3D 0) or its stale deadline is =
in the
past, skipping the dl_se->dl_deadline =3D=3D 0 initialization causes the lo=
op
to advance from the stale deadline and trigger a false replenishment lag
warning.

2. If the task previously had SCHED_FLAG_RECLAIM set in p->dl.flags,
retaining p->dl.flags while p->dl.dl_bw =3D=3D 0 causes dl_scaled_delta_exe=
c()
to call grub_reclaim() when the task is later PI-boosted:

kernel/sched/deadline.c:grub_reclaim() {
	if (u_inact + rq->dl.extra_bw > rq->dl.max_bw - dl_se->dl_bw)
		u_act =3D dl_se->dl_bw;
	else
		u_act =3D rq->dl.max_bw - u_inact - rq->dl.extra_bw;
}

Whenever u_inact + rq->dl.extra_bw >=3D rq->dl.max_bw, u_act becomes
dl_se->dl_bw (0), scaling execution time to 0 so the boosted task's runtime
never depletes. Stale SCHED_FLAG_DL_OVERRUN in p->dl.flags can likewise
deliver SIGXCPU to the boosted non-deadline task.

3. Both task_non_contending() and task_contending() guard against
non-deadline boosted tasks by checking dl_se->dl_runtime =3D=3D 0:

kernel/sched/deadline.c:task_non_contending() {
	if (dl_se->dl_runtime =3D=3D 0)
		return;
}

Because p->dl.dl_runtime remains non-zero, blocking while PI-boosted (or
deboosting while runnable) runs task_non_contending() using the stale
parameters and sets p->dl.dl_non_contending =3D 1 with inactive_timer armed
Even though p->dl.dl_bw is 0 at that moment, if the task then re-enters
SCHED_DEADLINE via sched_setattr() while sleeping and PI-boosted
(prev_class =3D=3D next_class =3D=3D &dl_sched_class), __setparam_dl() assi=
gns a
non-zero p->dl.dl_bw while dl_non_contending is still 1 without having
added the new bandwidth to rq->dl.running_bw, causing inactive_task_timer()
or migrate_task_rq_dl() to underflow rq->dl.running_bw.

4. If the departed task wakes up in SCHED_OTHER and later switches back to
SCHED_DEADLINE while runnable before its old p->dl.deadline passes,
enqueue_dl_entity() checks dl_time_before(dl_se->deadline, rq_clock(rq)):

kernel/sched/deadline.c:enqueue_dl_entity() {
	} else if ((flags & ENQUEUE_MOVE) &&
		   !is_dl_boosted(dl_se) &&
		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
		setup_new_dl_entity(dl_se);
	}
}

Because the stale p->dl.deadline is still in the future,
setup_new_dl_entity() is skipped and the task reuses its old unspent
runtime.

Should switched_from_dl() clear the remaining deadline parameters (or reset
them once any PI donor relationship is adjusted) instead of leaving them
populated when no inactive timer is pending?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104211207.1392=
343-1-mathieu.desnoyers@efficios.com?part=3D7
