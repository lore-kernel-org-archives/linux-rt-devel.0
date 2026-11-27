Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802876;
	b=ljgGGmgZvnq9iBjFYfQjhvReX1PDysYMixkfMZhiTHXQXb03Y/wusEuO7OaUcBJorL+v
	 eoyM5qHiKqWZSmv3YaGq+0kYGZIywp2gIJPgzol6RtD1OXpu0tMo/OyAMsBasQZSkkORZ
	 wzVwqqef2wiVU2SMKK+1MRK65rhBep6KsxxcryMJF74gFMfyXUZHGaeP/m8cliFGD1wNR
	 +XN0xRHVvoAsPg3GZT9buYervHLQ2vMhBBybG6Yi3oPDznFqyoP6NfigKGxko61FHTeOT
	 h9coPL2PvqOy0SlG0OojD8GSU6oUaGUs3vd1q1fwAX6bC/srHONzp4gIQ9avH4RGg3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802876;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9+sXP/dgT8KSDd3l4e8Kf/bLYRbSf9j3hdA0pgxosqI=;
	b=SliQSXwC8pwgF7CaOHuLDqbjMBCEsFJ8D0/GeKBRRalv5Mhx4zxYh683Qae0q2E8ConL
	 ziwRL4y5uenneAVRDzF3mrm62zO7aQWeX4zqy8Ad2ZB32/Lc1ggZ4s2xginrWLL+e//SQ
	 Ykba8DdUoBPo2A+/0v+i1mFWqEoSGvIB6iEkASZXHA5kdHOIQGEnbJBpC0sy8UDPNSatI
	 W3uexiKrBZ2jkSjQcDwTNEjhC/pnyLdzQ4kp1drdOTtqpUzlxc4vPVFR8enxHarAN13yT
	 Zcad/gg5pGzRFlN9PlvA8pv2WLXLXo6xwO6CyMMz3lchRHvrXe3ldwjE6PkKw208fGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPrcT72z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F087606A31C;
	Fri, 27 Nov 2026 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPrcT72z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E161F00898;
	Fri, 27 Nov 2026 18:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802875;
	bh=9+sXP/dgT8KSDd3l4e8Kf/bLYRbSf9j3hdA0pgxosqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WPrcT72zGiik0zk0XryPuR80p0VH3a/r9YJOsBtmP9PzIL/W7vBXJh7UPlYU1HYbR
	 W6d9JhRLaG7GVB5qxl5gQMRsfq/xfvNBI2kPpYU6TkVulMDyeQYwJFIOCOI/59UDwN
	 6R0dkz0zax/yZIuzFLITsLGj21lQgjcCZDs6WLTnsd0arvnyErXyZi/jQkMp5PIRGf
	 ujPluQw51lLq60YNUSUl0RpVCxw6Cipwfag9HAO3I9lzyeYc4Z/vLMh7TB/fel88Ns
	 a+Mm7hkfBnBPcutIeVZ7Baita6C+hoDCh/iRT9ByPSqJgQDgHEUBZPUiKmbdbuQm0g
	 i8oYG7Ba6XYcA==
Message-ID: <sashiko-outbox-238044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 41/43] sched/deadline: Run a boost held at its first
 refill on a donor period
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <5b1fecd307f51ac34910dc854f64c64a63dbb7e3.1795771148.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <5b1fecd307f51ac34910dc854f64c64a63dbb7e3.1795771148.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 18:07:55 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] sched/deadline: corrupted donor period state when donor
  params are cleared
- [Low] sched/deadline: duplicate replenishment tracepoint on first
  held-boost refill
--

commit 0aa5ad7879d538e8d7671934363e9bde5d35376e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Run a boost held at its first refill on a donor period

This commit runs a boost held at its first refill on a donor period by
calling dl_boost_donor_period() from dl_hold_refilled_boost() and keeping
the placed period in replenish_dl_new_period().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b9dd7ec10e7d2..f4e07aa47715d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -1741,11 +1746,13 @@ static void wakeup_preempt_dl(struct rq *rq, stru=
ct task_struct *p, int flags);
>  static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
>  					    struct rq *rq)
>  {
> -	dl_note_donor_refill(dl_se);
> -	/* for non-boosted task, pi_of(dl_se) =3D=3D dl_se */
> -	dl_se->period_start =3D rq_clock(rq);
> -	dl_se->deadline =3D dl_se->period_start + pi_of(dl_se)->dl_deadline;
> -	dl_se->runtime =3D pi_of(dl_se)->dl_runtime;
> +	/* A boost held from this refill keeps the period it placed. */
> +	if (!dl_note_donor_refill(dl_se)) {
> +		/* for non-boosted task, pi_of(dl_se) =3D=3D dl_se */
> +		dl_se->period_start =3D rq_clock(rq);
> +		dl_se->deadline =3D dl_se->period_start + pi_of(dl_se)->dl_deadline;
> +		dl_se->runtime =3D pi_of(dl_se)->dl_runtime;
> +	}
> =20
>  	/*
>  	 * If it is a deferred reservation, and the server

[Severity: Low]
Does holding a boost on its first refill emit trace_sched_dl_replenish_tp()
twice for a single replenishment?

When dl_note_donor_refill() holds the boost, dl_hold_refilled_boost() calls
dl_boost_donor_period().  Whenever no earlier donor period is resumed,
dl_boost_donor_period() calls replenish_dl_new_period(), which fires
trace_sched_dl_replenish_tp() before returning to the outer
replenish_dl_new_period() or replenish_dl_entity() call that fires
trace_sched_dl_replenish_tp() a second time.

[ ... ]

> @@ -6115,11 +6125,15 @@ static bool dl_setattr_period(struct sched_dl_ent=
ity *dl_se, u64 old_runtime,
>   * If sched_setattr() changed the parameters before this refill,
>   * dl_setattr_period() saved the old ones in setattr_*. Fit the period
>   * saved in own_* to the new parameters with them. setattr_* share
> - * storage with own_*: read them before writing own_*. The caller holds
> - * the rq lock of the task, and has updated the rq clock.
> + * storage with own_*: read them before writing own_*. Return true if a
> + * period of the donor was placed. The caller holds the rq lock of the
> + * task, and has updated the rq clock.
>   */
> -static void dl_hold_refilled_boost(struct sched_dl_entity *dl_se)
> +static bool dl_hold_refilled_boost(struct sched_dl_entity *dl_se)
>  {
> +	struct sched_dl_entity *pi_se =3D pi_of(dl_se);
> +	u64 donor_runtime =3D READ_ONCE(pi_se->dl_runtime);
> +	u64 donor_deadline =3D READ_ONCE(pi_se->dl_deadline);
>  	u64 old_runtime =3D dl_se->setattr_runtime;
>  	u64 old_deadline =3D dl_se->setattr_deadline;
>  	u64 old_period =3D dl_se->setattr_period;
> @@ -6142,6 +6156,14 @@ static void dl_hold_refilled_boost(struct sched_dl=
_entity *dl_se)
>  				 old_runtime, old_deadline, old_period, false, false);
>  	else if (!dl_time_before(now, dl_se->own_deadline))
>  		dl_se->own_runtime =3D 0;
> +	/*
> +	 * replenish_dl_entity() checks the donor's parameters: it adds no
> +	 * runtime if they were cleared. Start no period from them then.
> +	 */
> +	if (!donor_runtime || !donor_deadline)
> +		return false;
> +	dl_boost_donor_period(dl_se);
> +	return true;
>  }
>  #endif /* CONFIG_RT_MUTEXES */

[Severity: Medium]
Can clearing the donor's parameters corrupt dl_se's period and saved
boost_* state?

When the donor leaves SCHED_DEADLINE and __dl_clear_params(pi_se) zeroes
its parameters before or during the first refill of an unheld boost, three
things go wrong:

1. dl_hold_refilled_boost() sets dl_se->dl_boost_held =3D 1 before checking
!donor_runtime || !donor_deadline.  Returning false leaves dl_se->deadline
and dl_se->period_start on the owner's own period with dl_se->runtime =3D=
=3D 0.
At deboost, dl_end_held_boost() sees dl_boost_held =3D=3D 1 and saves the
owner's own period and zero runtime into boost_* with dl_boost_granted =3D =
1:

kernel/sched/deadline.c:dl_end_held_boost() {
	if (!dl_se->dl_boost_held)
		return false;
	...
	dl_se->boost_deadline =3D dl_se->deadline;
	dl_se->boost_runtime =3D dl_se->runtime;
	dl_se->boost_period_start =3D dl_se->period_start;
	dl_se->dl_boost_granted =3D 1;
}

A subsequent held boost from a new donor within own_period_start + period
then resumes the owner's own_period_start with zero runtime in
dl_boost_donor_period(), and replenish_dl_entity() pushes its deadline out
to own_period_start + dl_deadline + dl_period (past the waiter's deadline).

2. When called from replenish_dl_new_period() -> dl_note_donor_refill(),
returning false from dl_hold_refilled_boost() causes
if (!dl_note_donor_refill(dl_se)) in replenish_dl_new_period() to take the
branch and overwrite period_start =3D rq_clock(rq), deadline =3D period_sta=
rt +
0, and runtime =3D 0 from the cleared donor parameters anyway.

3. __dl_clear_params(pi_se) runs under the donor's rq lock on another CPU.
replenish_dl_entity() snapshots runtime, deadline, and period once and
validates all three, whereas dl_hold_refilled_boost() re-reads
pi_se->dl_runtime and pi_se->dl_deadline (without dl_period), and
dl_boost_donor_period() and replenish_dl_new_period() re-read pi_se fields
again.  If __dl_clear_params(pi_se) races between replenish_dl_entity()'s
initial check and those re-reads, dl_hold_refilled_boost() can return false
without placing a donor period while replenish_dl_entity() still executes
its while (dl_se->runtime <=3D 0) loop on the owner's own deadline and
negative runtime, or replenish_dl_new_period() can zero the relative
deadline and runtime before that loop advances both period_start and
deadline to now + period.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D41
