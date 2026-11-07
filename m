Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018207;
	b=z7b65aD50L4OdkY+SR+bhTHZCMn1k1OxJDjvsFNdyKQQ3NK37z5jsRV+s5bQuJ9dBjWf
	 XtwEYUmUHkSQCKlj/mZ1ozgxj0U+sqWgPJxUbmFPcmfRqueqCWdZpc3Zqn+kNlFONHcUJ
	 V/BthHdpVNkAvwjF/yLnBfMg313uMzGutKtr7MbnOgOdBwFkKWaLOhuScziS27S5Vl2h6
	 KlzooefiqTmPNNPwMPyBFyGjmY6RcsqThw6yGsW1pRbc1mCKNa9neR+imkQM2qN8U5xgm
	 UCx2ELbVQCdrKDFgTxc7pTdhQEtT3Cz0MaDS5H3pBBssf7YdpRzX/eGkMxM3K50R0Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018207;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aGmrldz9V6FjVYaqCEU6CVBsGYkxKhA35/EJPWKIcO0=;
	b=takx2qhdk8+sRxdFUtujwrcF6QPejGdtINOnJKF3MxoI/a+XwwB1Dxk+EBIjboKuu89+
	 VBJeuBzZ42PVjOzY9Irvf/80+gvXlY2jPK5cuv0Tw+904jc7PHj2iIBKChykIYDA+PEr6
	 +yRVyY3sgWIvl7Nx/UY2fDeOmQqFoD0pJJTQsUWXGOXS914TG+LwNSvW5ys4RkwTzsMYY
	 WSjqEjJFPP4BDt+xfdRozJTpW1HdoYYxKgZgL+njGjRq0CG57RCbcWmt5IpmBCjRnwBfd
	 7uPRJayeNxb7lQl6+lIRBXrOlWkLMQkI4CtPp/kUXEK2J8+i3MaYzdnAkZLvMD1jEiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKp6L1JB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069FE606A32C;
	Sat,  7 Nov 2026 02:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aKp6L1JB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896191F008A1;
	Sat,  7 Nov 2026 02:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794018206;
	bh=aGmrldz9V6FjVYaqCEU6CVBsGYkxKhA35/EJPWKIcO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKp6L1JBjzbohv6PmadQB9ZL/ka18lwUeuYqBQBVuBAHZhFXyLI0OPlAis/O+0JS7
	 f5bgBkD90g/EXcijs6J7auW7YYB/aalEp2Fhib+76wmsOMqh+XOpGtMCS6x/lJ4A/8
	 X1fmy9sHF+4aRKh+tt9lH8lnJDn3j3gN2C9HIttPfyGRQWXxNWA/Awn/wKhtLO1aSb
	 NtooEff4PFrTM2JHa4l+DRb6KITQ8hDrT4wRjT5ejmNA9v9WUy9hf2vTPtk8NzsmKN
	 tyGJ2EwO5zxgU2G/r5louXo0CG6a2VRxSnzWxAqBke9DUNWMYnRXsHxIyLD/5dD4k4
	 8IDa0jm4z54yA==
Message-ID: <sashiko-outbox-202504@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/26] sched/deadline: Release the bandwidth of a
 task that leaves the class asleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261107014451.1487825-11-mathieu.desnoyers@efficios.com>
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-11-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 02:23:26 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] sched/deadline: dl_zero_lag() mixes PI donor state with kept
  task params
--

commit 82ae18ee2c32ac7a69958d0da90b2ae54505ac04
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Release the bandwidth of a task that leaves the class asleep

This commit releases or arms the inactive timer for a task's SCHED_DEADLINE
bandwidth in switched_from_dl() when the task leaves the class while not
queued, and clears its deadline parameters once the bandwidth is released.

Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-2-dd761f=
e005b4@redhat.com/

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index f389620e6fc9a..cb0cf9c15108f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -390,6 +390,22 @@ static void dl_change_utilization(struct task_struct=
 *p, u64 new_bw)
> =20
>  static void __dl_clear_params(struct sched_dl_entity *dl_se);
> =20
> +/*
> + * The 0-lag time of @dl_se, relative to the clock of its runqueue: its
> + * utilization counts until then once it blocks or leaves the class.
> + */
> +static s64 dl_zero_lag(struct sched_dl_entity *dl_se)
> +{
> +	struct rq *rq =3D rq_of_dl_se(dl_se);
> +
> +	/*
> +	 * Using relative times instead of the absolute "0-lag time"
> +	 * allows to simplify the code
> +	 */
> +	return dl_se->deadline - rq_clock(rq) -
> +	       div64_long((dl_se->runtime * dl_se->dl_period), dl_se->dl_runtim=
e);
> +}
[ ... ]
> @@ -3597,15 +3605,69 @@ static void switched_from_dl(struct rq *rq, struc=
t task_struct *p)
>  	dec_dl_tasks_cs(p);
> =20
>  	if (!task_on_rq_queued(p)) {
> -		/*
> -		 * Inactive timer is armed. However, p is leaving DEADLINE and
> -		 * might migrate away from this rq while continuing to run on
> -		 * some other class. We need to remove its contribution from
> -		 * this rq running_bw now, or sub_rq_bw (below) will complain.
> -		 */
> -		if (p->dl.dl_non_contending)
> +		bool released =3D false;
> +
> +		if (p->dl.dl_non_contending) {
> +			/*
> +			 * Inactive timer is armed. However, p is leaving
> +			 * DEADLINE and might migrate away from this rq while
> +			 * continuing to run on some other class. We need to
> +			 * remove its contribution from this rq running_bw now,
> +			 * or sub_rq_bw (below) will complain.
> +			 *
> +			 * inactive_task_timer() will find !dl_task(p) and
> +			 * release total_bw via __dl_sub().
> +			 */
>  			sub_running_bw(&p->dl, &rq->dl);
> +		} else if (p->dl.dl_runtime && !dl_entity_is_special(&p->dl) &&
> +			   dl_zero_lag(&p->dl) >=3D 0 &&
> +			   !hrtimer_active(&p->dl.inactive_timer)) {
> +			/*
> +			 * No inactive timer armed, the 0-lag time ahead: the
> +			 * task is in flight to the CPU it wakes on, which
> +			 * cancelled the timer (migrate_task_rq_dl()), or it
> +			 * came back to the class asleep, which cancelled it,
> +			 * and leaves again. Arm the timer, as for a queued
> +			 * task: its handler releases total_bw at the 0-lag
> +			 * time, finding the task out of the class. running_bw
> +			 * is off this runqueue already, or never was on it.
> +			 */
> +			task_non_contending(&p->dl, false);
> +		} else if (p->dl.dl_runtime && !dl_entity_is_special(&p->dl)) {

[Severity: Medium]
Can dl_zero_lag(&p->dl) mix a PI donor's dynamic period state with p's own
unreleased reservation parameters?

When a SCHED_DEADLINE task leaves the class before its 0-lag time (or
changes policy away from SCHED_DEADLINE while already PI-boosted), it keeps
its static parameters (dl_runtime, dl_deadline, dl_period, dl_bw) until
0-lag time.  If a SCHED_DEADLINE waiter boosts the task into dl_sched_class
before inactive_timer fires, switched_to_dl() cancels inactive_timer.

During the boost, replenish_dl_entity() skips initializing the donor's
period at first because p->dl.dl_deadline is still non-zero:

kernel/sched/deadline.c:replenish_dl_entity() {
    ...
	if (dl_se->dl_deadline =3D=3D 0 ||
	    (dl_se->dl_defer_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
		dl_se->deadline =3D rq_clock(rq) + pi_deadline_of(dl_se);
		dl_se->runtime =3D pi_runtime_of(dl_se);
	}
    ...
}

Once p->dl.deadline and p->dl.runtime are replenished from the donor's
pi_params (on wakeup via replenish_dl_new_period() or after exhausting the
old runtime), p->dl.deadline and p->dl.runtime hold the donor's state while
p->dl.dl_period and p->dl.dl_runtime still hold p's old reservation.  When
p later blocks or is deboosted in switched_from_dl(), dl_zero_lag(&p->dl)
combines the donor's deadline and runtime with p's dl_period and
dl_runtime.  Depending on the donor's parameters, this either releases p's
dl_bw and clears its parameters before p's true 0-lag time, or sees a
positive 0-lag time after p's true 0-lag time has already passed, delaying
the bandwidth release and leaving the donor's deadline and runtime on
p->dl.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107014451.1487=
825-1-mathieu.desnoyers@efficios.com?part=3D10
