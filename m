Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830173;
	b=wECWxqZlOuD7WLej+brErNpcstJMpY4/bBqX8n7UlYeJaNr4lw7m//C5+4k4PSkDF/2n
	 AYOcs+ho9rIxU1iH/2TvaQUGZeYMMEdSbTWvNfYZOnQZ8b8Hmpf9/Mpc4MlWYuk9nfFYg
	 ErshdsjiSO8nAM/5pwZNIRpagjCPUpkiOmmOv/Tne+7WiuE20CgwouP6J9CAbezgjZbHT
	 w5Dq1hd+6Zh2AWvEFZAxR21tvmOLeGjKC1SoEW7/6eSL7bMPcwydTTYjf+n1UusHofuEX
	 q4zyD550h5Hmlg7WmMYh0zhH0VIAfyPHvNI9lwHce52yNmNgoVZY/ieWP/bCbDtaHeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830173;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E+UNeJXu4h4RsCSjrrH6bPbPUDdq5s2pPUaiZDxgY2k=;
	b=odXaI7L2Bsr7bWkB7HMlMLiheNrtVTyLRwE3FNO+GkEB9OEbq371EPKhrtQbHfNcq0ZV
	 6dzQ7zC0kvougW7D72GwPVSLQz6tfNxTuRGPvplm/821vAqLvYjn6YR5iri/Cl3ZmI0rT
	 1r7OPH2QtW29gTmsvFv4Z2Bl4kaLzl/dIKcQ3G1lqlJNUczldqHLdGkePt5jVUAvxTSL7
	 JLQvamsXtgq0yACTV0x6HYiFc03UodKSf0GgTRYjv3BLds/eHYfoFl3tyYSBwN2bTv8kW
	 WgY5x1U7aev5cI5dpwLjsFWvr3MgajPXzThzRh1waXK1lHqtSgYdNUNBcvTVc/kHx5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCmRM1ug;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D546606EEA1;
	Wed,  4 Nov 2026 22:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kCmRM1ug
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7241F000C1;
	Wed,  4 Nov 2026 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793830173;
	bh=E+UNeJXu4h4RsCSjrrH6bPbPUDdq5s2pPUaiZDxgY2k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kCmRM1ugzpN/2iwaXPZGF+LfnjuxpbI2ljh/u5k+UuQRmMvBY7/ePTE5bfzLwxWRC
	 um2ocyc11K4RnuGS20gQjXZt/9HqlOJVlZJG12tpbExjmbcpjnEIdD3PCMlbgsJ9/z
	 oJZROHosh5bk7YGv7Y9vs4smaFuqi+1m1oxJQ5Dnn99BRiyaQz91SoSo98QFlbuQb7
	 zgbUbHAV1AUb4WxB07BEIzyCUqZL36sA+lnIPr1mVbp9esBgNrabFbdw/cJRwva1rK
	 Zd/3drgDwIg0xHSbMl/EnKIiwy0UQ5FZDsAvZ60ix0KDU7FkUWFVtLmFWe4O4piiSx
	 FCULNZsGTWl8A==
Message-ID: <sashiko-outbox-198201@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/21] sched/deadline: Do not lose a throttled task
 switched out and back
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261104211207.1392343-7-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-7-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 22:09:32 +0000
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
- [High] sched/deadline: replenish_dl_entity() in dl_task_timer() skips 0-l=
ag reset
--

commit a554b85972acb72b5ec447330ac07adc4a64ee34
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not lose a throttled task switched out and back

This commit calls replenish_dl_entity() from dl_task_timer() when a throttl=
ed
task has switched out of SCHED_DEADLINE before the replenishment timer fire=
s,
so that if the task switches back before its 0-lag time, it does not remain
throttled with no pending timer.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 30a52e42c26d8..b646063a7b0d5 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1232,10 +1232,23 @@ static enum hrtimer_restart dl_task_timer(struct =
hrtimer *timer)
> =20
>  	/*
>  	 * The task might have changed its scheduling policy to something
> -	 * different than SCHED_DEADLINE (through switched_from_dl()).
> +	 * different than SCHED_DEADLINE (through switched_from_dl()). It
> +	 * keeps its parameters until its 0-lag time and may come back to
> +	 * SCHED_DEADLINE before then, switched_to_dl() cancelling the
> +	 * inactive timer: give it the replenishment this timer owes it, as
> +	 * the !queued case below does, and leave the enqueue to its return.
> +	 * A throttle left behind would never be lifted; an overrun left in
> +	 * its runtime would be forgiven by the new period its enqueue
> +	 * starts; and a yield left set would throttle it again at once.
>  	 */
> -	if (!dl_task(p))
> +	if (!dl_task(p)) {
> +		if (dl_se->dl_throttled && !is_dl_boosted(dl_se)) {
> +			sched_clock_tick();
> +			update_rq_clock(rq);
> +			replenish_dl_entity(dl_se);
> +		}
>  		goto unlock;
> +	}

[Severity: High]
What happens if the task stays out of SCHED_DEADLINE past its 0-lag time, a=
nd
then switches back to SCHED_DEADLINE while runnable before the replenished
dl_se->deadline expires?

When replenish_dl_entity() runs here in dl_task_timer() at the end of the
period, it advances dl_se->deadline by one or more periods (past the 0-lag
time) and sets a positive dl_se->runtime:

kernel/sched/deadline.c:replenish_dl_entity() {
	...
	while (dl_se->runtime <=3D 0) {
		dl_se->deadline +=3D pi_of(dl_se)->dl_period;
		dl_se->runtime +=3D pi_of(dl_se)->dl_runtime;
	}
	...
}

If the task does not return before the 0-lag time, inactive_task_timer()
fires, subtracts the old bandwidth from dl_b, and calls __dl_clear_params():

kernel/sched/deadline.c:inactive_task_timer() {
	...
	raw_spin_lock(&dl_b->lock);
	__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
	raw_spin_unlock(&dl_b->lock);
	__dl_clear_params(dl_se);
	...
}

However, __dl_clear_params() only zeroes the static reservation parameters =
and
flags; it leaves the dynamic dl_se->deadline and dl_se->runtime untouched:

kernel/sched/deadline.c:__dl_clear_params() {
	dl_se->dl_runtime		=3D 0;
	dl_se->dl_deadline		=3D 0;
	dl_se->dl_period		=3D 0;
	dl_se->flags			=3D 0;
	dl_se->dl_bw			=3D 0;
	dl_se->dl_density		=3D 0;
	...
}

If the runnable task then switches back to SCHED_DEADLINE via sched_setattr=
()
after the 0-lag time has passed, but before the replenished dl_se->deadline,
__setparam_dl() writes the new static parameters and sched_change_end() cal=
ls
enqueue_task_dl() -> enqueue_dl_entity() with ENQUEUE_MOVE (and without
ENQUEUE_WAKEUP):

kernel/sched/deadline.c:enqueue_dl_entity() {
	...
	} else if ((flags & ENQUEUE_MOVE) &&
		   !is_dl_boosted(dl_se) &&
		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
		setup_new_dl_entity(dl_se);
	}
	...
}

Previously, dl_se->deadline stayed at the old deadline (which is earlier th=
an
the 0-lag time), so dl_time_before(dl_se->deadline, rq_clock(rq)) was always
true after the 0-lag time and setup_new_dl_entity() initialized a fresh per=
iod
from the new static parameters.

With dl_se->deadline pushed past the 0-lag time by replenish_dl_entity(),
won't dl_time_before(dl_se->deadline, rq_clock(rq)) evaluate to false during
the window between the 0-lag time and the replenished dl_se->deadline,
skipping setup_new_dl_entity()?

If setup_new_dl_entity() is skipped after the 0-lag time has already freed =
the
old bandwidth and reset the reservation, the task will run with stale dynam=
ic
dl_se->runtime and dl_se->deadline from its previous reservation. For examp=
le,
a task could re-enter SCHED_DEADLINE with a tiny new runtime reservation af=
ter
its old bandwidth was released at 0-lag, yet still consume the large
dl_se->runtime replenished from its previous reservation, or conversely rem=
ain
penalized by a previous overrun after its 0-lag time has already elapsed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104211207.1392=
343-1-mathieu.desnoyers@efficios.com?part=3D6
