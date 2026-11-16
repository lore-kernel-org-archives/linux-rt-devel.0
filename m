Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858134;
	b=dp91L2c433E127Bx0k5uf2oMum9zClCGANmOA1txMCsuQqmRSNCYXnamFAdZ8lHOWUJh
	 lUEvkEepCm+jX4u+PaLr7gLmkLnpM6cRV6tPdmib8ECgwOuDl4o44StaxFj9kzBR1stt/
	 3R4Ot1uq3u9fg0JKa51CkSq16Cu1NCPrOCaMBxSAm/4TrLQ2csEcNTj/db/htAHsoKmOa
	 jEKE9nZftt0ENLJIjzYCoj3l3s+JQ4l3YrOlAonHZGtnSGUUyV0aHV2WCiIjXpvTQEeqa
	 LmomaDYrQiBaoz+96NcLuTmkBcM6CYnBGWohpuWAUBRxlYBLh8Q3fe4SMy/+xtuXVwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858134;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rNb9bQsdhMwrhJ/otfhzVlcn4OiqAMy/G1sex/r4c0M=;
	b=4DU4NHLCZB5ExY3ynTqEVMGjy0HyxI8nUaWP1A5qFY/3O3/nWjgeYaPWCdlqaOioCumn
	 tsDvAODerOEkVMgBBw1vq1Qz/Z6lorp/cP4FqyHvoCcDOyozFSFPSsAluaB/cROOmDjid
	 N+pPgVZroBSBTWlU2ecbcIGSd1LP9a5rlx17cI/GF3NF1ifOzKOuy5h4S3aTK7o2P+1MG
	 IhssCrtZ5FJkK6u9WKVnVxR72dAtTm8Lu0YkbB9MLmSjfnIYsEwNf/pPNzf+7/VC+9yog
	 49y1+0pk6Z9IIzfdPIoSqQTOpclqxQXIhBFtJX/UU7lkgCEj8gygfC7v6pEjU5QQEuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7HJtAW+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E305606A322;
	Mon, 16 Nov 2026 19:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S7HJtAW+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68841F000C4;
	Mon, 16 Nov 2026 19:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858134;
	bh=rNb9bQsdhMwrhJ/otfhzVlcn4OiqAMy/G1sex/r4c0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S7HJtAW+1XpF3e2apNCGWZCxhK6+FP0EdXd07FMlMeeeFCZFHDF3seMrwELFtBtyI
	 pgBm08jgs3CnbJQoZXQObUhZw5Bolrp+PS2VDwHZiuqidMPQMiBMi5K4hoApN0VWsg
	 4dl9N4DPEyytONJs0Wv0iszVaiFPxtliLTa0/AvBphpotnrd53OWCti8o11Cwwf7VJ
	 xtUy4SukEgl5PbGoRKtZq9CzmM2zgGd+GLJndHU1FRfWVCE+yESxJ0qNftBWTMam/P
	 iRaloDpx1ynsHPiDPUd5XDJxyDBL3aqAj9C5bEjZ2KVPjIgO1I+NzHO90GJtjGWYo7
	 p1T3WSEJHcH5w==
Message-ID: <sashiko-outbox-217594@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/37] sched/deadline: Do not replenish a boost from
 cleared parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-9-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-9-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:42:13 +0000
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
- [Medium] sched/deadline: torn donor parameter reads in
  replenish_dl_entity()
- [Medium] sched/deadline: unreset negative runtime in
  replenish_dl_entity()
- [Medium] sched/deadline: zero deadline in replenish_dl_entity() on
  initial boost
--

commit f55f8a9d26011d4eb967a7bc04c3939d81815727
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not replenish a boost from cleared parameters

This commit avoids an infinite loop in replenish_dl_entity() when a
boosted entity's donor has left SCHED_DEADLINE and had its parameters
cleared before the priority inheritance chain walk deboosts the owner.

Link: https://lore.kernel.org/all/avL8oOtjKqVNR7-l@jlelli-thinkpadt14gen4.r=
emote.csb/

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index e4d7cbf4861de..c4ea510599415 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -807,8 +807,26 @@ static void replenish_dl_entity(struct sched_dl_enti=
ty *dl_se)
>  {
>  	struct dl_rq *dl_rq =3D dl_rq_of_se(dl_se);
>  	struct rq *rq =3D rq_of_dl_rq(dl_rq);
> +	struct sched_dl_entity *pi_se =3D pi_of(dl_se);
> +	u64 runtime =3D READ_ONCE(pi_se->dl_runtime);
> +	u64 deadline =3D READ_ONCE(pi_se->dl_deadline);
> +	u64 period =3D READ_ONCE(pi_se->dl_period);

[Severity: Medium]
Can replenish_dl_entity() observe a non-zero runtime alongside a zeroed
deadline or period when racing with __dl_clear_params()?

__dl_clear_params() zeroes dl_runtime, dl_deadline and dl_period in that
same order under the donor's rq lock without ordering barriers:

CPU0 (boosted owner)              CPU1 (donor)
replenish_dl_entity()
  runtime =3D READ_ONCE(pi_se->dl_runtime)
                                  inactive_task_timer()
                                    __dl_clear_params()
                                      dl_se->dl_runtime =3D 0
                                      dl_se->dl_deadline =3D 0
                                      dl_se->dl_period =3D 0
  deadline =3D READ_ONCE(pi_se->dl_deadline)  <-- reads 0
  period =3D READ_ONCE(pi_se->dl_period)      <-- reads 0

Because only !runtime is checked below, replenish_dl_entity() proceeds
with runtime > 0 and deadline =3D=3D 0 or period =3D=3D 0.  A boosted non-d=
eadline
task gets dl_se->deadline set to rq_clock(rq) + 0, while a boosted
SCHED_DEADLINE task has runtime added in the while (dl_se->runtime <=3D 0)
loop without advancing dl_se->deadline.  If dl_se->deadline is then in the
past, the lag check emits a false "sched: DL replenish lagged too much"
warning and calls replenish_dl_new_period(), which re-reads
pi_of(dl_se)->dl_deadline and pi_of(dl_se)->dl_runtime directly and sets
dl_se->runtime to 0.

> -	WARN_ON_ONCE(pi_of(dl_se)->dl_runtime <=3D 0);
> +	/*
> +	 * A boosted entity runs on the parameters of its donor, the top
> +	 * waiter of an rt_mutex. The donor can leave the class and have them
> +	 * cleared before the chain walk deboosts this entity. They are
> +	 * cleared under the donor's rq lock, which can be another one. So
> +	 * read each of them once. Refilling from a runtime of 0 would loop
> +	 * forever. Leave the entity runnable instead: the walk deboosts it,
> +	 * or its task releases the lock.
> +	 */
> +	if (unlikely(!runtime)) {
> +		WARN_ON_ONCE(!is_dl_boosted(dl_se));
> +		dl_se->dl_yielded =3D 0;
> +		dl_se->dl_throttled =3D 0;
> +		return;
> +	}

[Severity: Medium]
Does returning here without resetting dl_se->runtime leave the entity with
an accumulating negative runtime?

When a boosted task exhausts its runtime after the donor's parameters are
cleared, dl_se->runtime remains <=3D 0 across this early return.  Every
subsequent tick in update_curr_dl_se() subtracts delta_exec from
dl_se->runtime, sees dl_runtime_exceeded(dl_se), sets dl_se->dl_overrun
(sending repeated SIGXCPU signals if SCHED_FLAG_DL_OVERRUN is enabled),
and re-enters enqueue_task_dl() -> replenish_dl_entity().

With the follow-up commit "sched/deadline: Reset the donor's runtime at a
deboost in the class", this return also happens before
dl_note_donor_refill(dl_se).  If a SCHED_DEADLINE owner had not been
refilled from the donor before the donor's parameters were cleared,
dl_donor_refill stays 0 and dl_deboost() does not reset dl_se->runtime;
when dl_se->deadline is still in the future at deboost, the negative
runtime is charged against the owner's own periods on its next replenish,
or pushes zerolag_time past dl_se->deadline in task_non_contending() if
the owner blocks first.

[Severity: Medium]
Can this early return also leave dl_se->deadline at 0 when a runnable
non-deadline task is first boosted into SCHED_DEADLINE?

When rt_mutex_setprio() boosts a runnable non-deadline task whose
dl_se->deadline is 0, it sets ENQUEUE_REPLENISH and calls
enqueue_task_dl() -> enqueue_dl_entity() -> replenish_dl_entity().  If the
donor's parameters were already cleared (for example after
normalize_rt_tasks(), or before a multi-hop PI chain walk finishes
deboosting an intermediate lock owner), replenish_dl_entity() returns here
before the dl_se->dl_deadline =3D=3D 0 branch initializes dl_se->deadline.

__enqueue_dl_entity() then calls inc_dl_deadline() with deadline =3D=3D 0:

kernel/sched/deadline.c:inc_dl_deadline() {
	if (dl_rq->earliest_dl.curr =3D=3D 0 ||
	    dl_time_before(deadline, dl_rq->earliest_dl.curr)) {
		if (dl_rq->earliest_dl.curr =3D=3D 0)
			cpupri_set(&rq->rd->cpupri, rq->cpu, CPUPRI_HIGHER);
		dl_rq->earliest_dl.curr =3D deadline;
		cpudl_set(&rq->rd->cpudl, rq->cpu, deadline);
	}
}

Because dl_rq->earliest_dl.curr =3D=3D 0 is the sentinel for an empty dl_rq,
enqueuing a subsequent deadline task with a later deadline overwrites
dl_rq->earliest_dl.curr and cpudl, hiding earlier deadlines on this rq
from cross-CPU deadline balancing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D8
