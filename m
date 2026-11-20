Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209968;
	b=ReAm0t944G82wVAKtp/E17rPh3XIKfKrLpnrUDEYsBbth7IY0ekm5ybfAOgjfv3Fy+F6
	 FEjbbkdSOceWungAg6yuIQ4Yfo2QOhTABqCS5vhk2nkwTCPUQoFGs09zcKSyyY3On5KNs
	 tkjE6GngtMer6KneJJNkVM5eZLmqusl6xAvIucuomdzOePZ/PcT8gHGcinnzn43TEnGa1
	 sRSkmH4hYgRXH+U1CuIrj9bhFFc6s6GZoaUVdjfsxH/BEVgO8lSR0ekS+Bxwk8ZP/S4so
	 BcIKfP+wW/6MO39ma3qb17uuaVq+Ps1lpBV6tVlcGdOSN4wU//8QfqlTDcEIy50SO7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209968;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8amswnvtInzqviW6zxh+hTO3qU8xY1vLKgxSB28EODo=;
	b=IClky61PKgpRHesLawm6xW4jduL6f2uOVwd6YdUWToDeOClaBF/4D3peqQftA/LRmUYW
	 fMQMvn5bJSGds1efcGNMX/dyKwAYOzue4khQ3MF4Z+IWziIEFpoVAxKNb+V4CBnvk+40y
	 YwWFWjJs+U+lab95MKPfoSRswkoXKsUJpc/azl8osh2s/MVUog+al3KXPAgfWcOWIWG2V
	 F7z56pTmfe47tE/UqUnu0aUH3DJyEV8Jy2b0qbwieu3ELI4W7mUhvn1Hdr81Za3cJOWXy
	 iiSiZ1hZdH8AFiV3JWULg+lpTxLstZIGreXvqPTYXFZHlVsMdh6l4WqzPMbR/myO9GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRAhB2Ip;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39421606A334;
	Fri, 20 Nov 2026 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRAhB2Ip
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8398F1F000C6;
	Fri, 20 Nov 2026 21:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209967;
	bh=8amswnvtInzqviW6zxh+hTO3qU8xY1vLKgxSB28EODo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mRAhB2Ip1/OZxYH82O+wOg44IcbFfm0Zfk/m7gLtpW7uUjSlhPbmb5kbmbfVmRZAn
	 yG6Ot9ecs4cO7gGBKwa5t6c5BAz6d7nhqSeWoR5rOfx0S5409Ut84WTY2WJhLg3ON+
	 QXzUzp0L4Kus5M6gOQO8IbcfJoKzT7+vK81C6a2O/7EKQj11mjRbBMY25moYQ7hlOm
	 Uf9ko2WTIgMt4toHi+2+JnJPTXQDSAs+OIqOSxKf5tQ5CG6h/Yfvx6t+Nmxp2Wn0Ge
	 WsCjIW4pdgLV/701bRTP4KVOL1Jf/kUtq+BSnp2ODDH5FhDNcIK4R5R4uWadHVWvbs
	 4O/RzL2vk8FIg==
Message-ID: <sashiko-outbox-226175@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 25/40] sched/deadline: Reset the donor's runtime at
 a deboost in the class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <a16410b68dd594967dd00f2b2bd03f1ac458c1a7.1795207232.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <a16410b68dd594967dd00f2b2bd03f1ac458c1a7.1795207232.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:26:07 +0000
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
- [Medium] sched/deadline: dl_deboost() starts period for sleeping
  constrained task
--

commit 280104d364cfcdeb61df32b73bafd44ef91c8ae1
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Reset the donor's runtime at a deboost in the class

This commit records whether a boosted deadline entity had its runtime
refilled from its donor's parameters in dl_donor_refill, and starts a new
period from the entity's own reservation when deboosting within
SCHED_DEADLINE if that flag is set.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index a566e9252a418..2912d13b60d60 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -93,12 +93,62 @@ static inline bool is_dl_boosted(struct sched_dl_enti=
ty *dl_se)
>  {
>  	return pi_of(dl_se) !=3D dl_se;
>  }
> +
> +/*
> + * Record that @dl_se had its runtime refilled from the parameters of its
> + * donor, if it is boosted.
> + */
> +static inline void dl_note_donor_refill(struct sched_dl_entity *dl_se)
> +{
> +	if (is_dl_boosted(dl_se))
> +		dl_se->dl_donor_refill =3D 1;
> +}
> +
> +static void task_non_contending(struct sched_dl_entity *dl_se, bool dl_t=
ask);
> +
> +/*
> + * End the boost of @dl_se, whose task stays in the class. If the boost
> + * refilled its runtime from the donor's parameters, start a new period
> + * now. The next enqueue is too late for a task blocked on another
> + * rt_mutex: the chain walk copies its deadline into its waiter node
> + * first. Without a refill, the task keeps the runtime and the deadline
> + * of its own reservation.
> + *
> + * The caller holds the rq lock and the pi_lock of the task, and has
> + * updated the rq clock.
> + */
> +void dl_deboost(struct sched_dl_entity *dl_se)
> +{
> +	struct rq *rq =3D rq_of_dl_se(dl_se);
> +
> +	if (dl_se->dl_donor_refill) {
> +		dl_se->deadline =3D rq_clock(rq) + dl_se->dl_deadline;
> +		dl_se->runtime =3D dl_se->dl_runtime;

[Severity: Medium]
Does starting a new period in dl_deboost() while the task is asleep cause
a constrained-deadline task (dl_deadline < dl_period) to lose runtime or
be throttled when it later wakes up?

If a deadline waiter times out on an rt_mutex held by a sleeping
constrained-deadline task with dl_donor_refill set (and not blocked on
another rt_mutex), dl_deboost() sets dl_se->deadline =3D t_deboost +
dl_deadline and dl_se->runtime =3D dl_runtime while the task sleeps.  When
the task later wakes up at t_wake:

- if t_deboost < t_wake <=3D t_deboost + dl_deadline, dl_entity_overflow()
  is true because dl_se->runtime =3D=3D dl_runtime while remaining time to
  deadline is less than dl_deadline, so update_dl_entity() calls
  update_dl_revised_wakeup() and scales down dl_se->runtime for the time
  spent sleeping since t_deboost;
- if t_deboost + dl_deadline < t_wake < t_deboost + dl_period,
  enqueue_dl_entity() -> dl_check_constrained_dl() sees deadline < t_wake
  < dl_next_period(dl_se) and throttles the waking task until t_deboost +
  dl_period, even though it did not run during that period.

Later in this series, commit "sched/deadline: Check the runtime of a task
whose parameters change" avoids starting a period at deboost for
dl_new_params when the task is neither queued nor pi-blocked, and commit
"sched/deadline: Boost an owner that cannot run on its own reservation"
restores the task's saved reservation when dl_boost_held is set, but the
dl_donor_refill path in dl_deboost() still starts a period while asleep.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D25
