Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859472;
	b=Uf8mIT7xjg+abC3f1mHVbh3UV3ALioUm/zWsHfTrLM4MP3uVXeBP+kO+UHpQolP5Rblw
	 cAPY5wTGSYrxxBXNj52z+PxZjzis+1Y9eWKqJt8RCSjBxFBZDfouwkC63JeTxovQWyulh
	 U4g4BlefNt5jRqXzbHwOJar+D4a8MqpIODT4NvIQB/W4Vzvu4+EKC/RpwahQY4gHmzI56
	 aDqokITTVE17HGSfStPdF0kPnpla9dtxhp7k0zob4sArBBCcsoaYirlrtuS1fmunfwZCJ
	 Px6BjMbXAttxmbB4TTgnfnGRpCMAdCG/vks+vLGXYDRCUTImFKPPhHJ5ahNz2Ub6DEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859472;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mZreKafCH7rPi/FRPVyNHa4l78htzwWreiZqSG6TLS4=;
	b=tquT3gkIgm+l5VwXabQX7Pl+lcpHBcd5R8qU8DJd3Q+Cga0d0G7oofplRNMu17W0OCrn
	 kN5MOVOGDAA8prwv1hxp6zUElqiouXMdB4WYO4nfZX+QMFF8igeMlhxo7ofbobgMvJJjn
	 qBV+w2T/Ml3lduC1wIN9eWhTzLMIjKParGc90DijA0uQZWr7mBd4QD9bx00JXb/0hT21a
	 ssBgO/hFRJYqXf3MECexE9/IXTOVgoZtxkfZQt2Z76dFUAKRBr/BA1DEsaSQ3sbYEbGrM
	 3RY1uCf11cKpIenyXWHhyPQ92DOw6LP4eaYsqOs9L9Idh7koH2TuTdYbqMsUlacL+QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbZyNsr0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EAD60A3803;
	Mon, 16 Nov 2026 20:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HbZyNsr0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F26FB1F00AE3;
	Mon, 16 Nov 2026 20:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859472;
	bh=mZreKafCH7rPi/FRPVyNHa4l78htzwWreiZqSG6TLS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HbZyNsr0n7Y5KyOYkuWUgGLPui0UAivauo+U8/LdW/alput/uusjy7FmP5zV6KAnG
	 GafNaVUrZTpRrF0BLdrmQHRAzWNGB7JFXl0Ge2DpUc17Lh8ZkxTG4zuYdjEmMlt+r4
	 UKBCMSPBGYXiDsNc6ZJZKcF72HawmPRyyEHY/x9AAtY3gXs0DNouOWJjMjPCFI+Kiq
	 UPUA7mQUpE/CteJJ5vXkSvTnSaZuKnwHH7XLSBTcIa+xJXJtJ8Pdp/FMxsrRlaYZ7p
	 HQQHWTXrs4ZdIo4mK/TDOFlRe1rmHX+XRbCZ5gX8giQM+SVgnoBgdLMkZTXlGse8r1
	 cg82fRIa6sJiA==
Message-ID: <sashiko-outbox-217632@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 33/37] sched/deadline: Check the runtime of a task
 whose parameters change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-34-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-34-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 20:04:31 +0000
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
- [Medium] sched/deadline: dl_new_params cleared while boosted in
  enqueue_dl_entity()
- [Medium] sched/deadline: unchecked laxity in update_dl_entity() on
  dl_deadline shrink
--

commit b62a12a066a3a8cec83cd122301c3f7fcc56bd77
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Check the runtime of a task whose parameters change

This commit adds a dl_new_params flag to struct sched_dl_entity so that
when sched_setattr() modifies a deadline task's runtime, deadline, or
period, the next enqueue checks the remaining runtime against the new
parameters via update_dl_entity().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b47c13c8714d9..3b62ee43c2099 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2674,7 +2674,10 @@ static void __dequeue_dl_entity(struct sched_dl_en=
tity *dl_se)
>  static void
>  enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
>  {
> +	bool new_params =3D dl_se->dl_new_params;
> +
>  	WARN_ON_ONCE(on_dl_rq(dl_se));
> +	dl_se->dl_new_params =3D 0;

[Severity: Medium]
Does clearing dl_se->dl_new_params unconditionally here lose the mark if
the task is priority-inheritance boosted when sched_setattr() shrinks its
reservation?

When is_dl_boosted(dl_se) is true, the new_params branch below is skipped
(or on a wakeup while boosted, update_dl_entity() checks against
pi_of(dl_se) rather than the task's own parameters).  If the boost took no
donor refill (dl_donor_refill =3D=3D 0), dl_deboost() later leaves
dl_se->runtime and dl_se->deadline intact, and the subsequent enqueue sees
dl_se->dl_new_params =3D=3D 0 and lets the task run on its old larger runti=
me
after admission control already released the bandwidth difference.

>  	update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
> =20
> @@ -2723,12 +2726,13 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, =
int flags)
>  		update_dl_entity(dl_se);
>  	} else if (flags & ENQUEUE_REPLENISH) {
>  		replenish_dl_entity(dl_se);
> -	} else if ((flags & ENQUEUE_CLASS) && !is_dl_boosted(dl_se)) {
> +	} else if (((flags & ENQUEUE_CLASS) || new_params) &&
> +		   !is_dl_boosted(dl_se)) {
>  		/*
> -		 * The task enters the class runnable. It may come back before
> -		 * its deadline, with the runtime left from older parameters.
> -		 * Check that runtime against the new parameters, as a wakeup
> -		 * does.
> +		 * The task enters the class, or its parameters change, while
> +		 * it is runnable. It may have runtime left from older
> +		 * parameters. Check that runtime against the new parameters,
> +		 * as a wakeup does.
>  		 */
>  		update_dl_entity(dl_se);

[Severity: Medium]
Can update_dl_entity() leave or set dl_se->runtime above the new
dl_se->dl_runtime when sched_setattr() shrinks dl_deadline to a
constrained reservation while dl_se->deadline - rq_clock(rq) still exceeds
the new dl_deadline?

Both dl_entity_overflow() and update_dl_revised_wakeup() assume that
laxity =3D dl_se->deadline - rq_clock(rq) is at most dl_se->dl_deadline:

kernel/sched/deadline.c:update_dl_revised_wakeup() {
	u64 laxity =3D dl_se->deadline - rq_clock(rq);

	WARN_ON(dl_time_before(dl_se->deadline, rq_clock(rq)));

	dl_se->runtime =3D (dl_se->dl_density * laxity) >> BW_SHIFT;
}

For example, if a task running at 50ms/100ms/100ms has runtime =3D 30ms and
laxity =3D 80ms when changed to 10ms/20ms/100ms (density 50%),
dl_entity_overflow() sees 30ms / 80ms <=3D 10ms / 20ms and leaves runtime at
30ms; if changed instead at runtime =3D 49ms and laxity =3D 99ms to
8ms/20ms/100ms (density 40%), update_dl_revised_wakeup() sets
dl_se->runtime to 39.6ms against an 8ms budget.  Besides letting the task
overrun the bandwidth it just gave back in sched_dl_overflow(), blocking
with dl_se->runtime > dl_se->dl_runtime makes task_non_contending()
compute a negative zerolag_time and drop running_bw or total_bw
immediately.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D33
