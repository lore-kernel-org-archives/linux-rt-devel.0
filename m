Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658022;
	b=24YE2yAUsWIl6hHmbwz9mfOSsDoUwZ2nZPq9Mndm+JSlMuRGU1yGCA9pmONvqOF7S0TU
	 MDdtGBzpAz7o/s4ae/1K/TZYEMjxm9M9gnxsfCzNJ84mRZ0AxtTzhL06XxbhKfdwICDLn
	 AxVZiojbR/ns0i0hy6mk3Bq2mT3iVfkWiCfPF+erzxUu5Px3fMg8aoKEU2ls5sZ0a1OYm
	 npvT2vU5V03jPDZ35vdZ7Lry1dfOYo7QOIb4QwGEPil1qTzo49oBqCTA9SfG2pyh6fdQV
	 JtmMrs+nvcy7IbTT4k05Idgd/Xo6euAjLZ68nTgMx6QbyCSjQOVzjSLqj26C5p0pE3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658022;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+cHTEurbqsd7zSGKgmqAVYiNvItVPPZ0dZmH2pKh7Ao=;
	b=AL6PJHs4bP+uRol94AzwrJO5WctTUTs2r00nynh71BqOIatMLXwNH5EhL8LywsKcRu8w
	 ck4AP12PMWM1RG2yCcB12OMPhUI6U29AuirPjWDFdcoXlD7AZNty5o71EVM8AwgvqIakx
	 2IvQnpDwNrdJ8ZAcfFtgtePdVQDpmd62cxTqOpbJ+SJgWb9YrWoJv/PVDOYrRh/rGt2cr
	 E3xNv9hgEd9a7UpjJcpXpEXSEMwSG2xDKoM0K9LguuzdkQO65/V5IYCthBY38ZRcsM3Od
	 ptACUcnBHNwx6ZZXPYB+bnuRE1NxZVN1NoaulbaTpGXnFQ0YebQpUMsrJB8oxM+T+6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCv+j2jG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740D606A31E;
	Thu, 26 Nov 2026 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCv+j2jG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB9C51F000C0;
	Thu, 26 Nov 2026 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658022;
	bh=+cHTEurbqsd7zSGKgmqAVYiNvItVPPZ0dZmH2pKh7Ao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QCv+j2jGdaeO79gxxixoJ7rdHOuEFcHSTgiPzfzBroALPhx3RwfpBvvg/A+59fxPX
	 0rWiJdR4wgUBNxeDg+VT2wcBV+nDEYhaH6rjzOhc79LKa9aZpY6AwoPqhZakWqhY/+
	 08YGzrmPy0gpvNRkHcqRC9ZXIj353Fqs/TFBm3o7F9VVDG9bUAUriYPbOrM2LHkO23
	 X2YZIZzkBXRQTUAgFHCKsyuIF+Egf9afvRYy1W6fMclSl/aSj5eglFLlx6y04yIN/N
	 NDpVEcb7/bREUBTo//1cn2tiDQ6yD71SWvRmvHmpFB+OkYcd7vpqbY4FGMwaPr3iOB
	 PbjHWSlAYo4OQ==
Message-ID: <sashiko-outbox-234590@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 30/43] sched/deadline: Start a period for a task
 that enters the class blocked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <f878da91a2dcaec14aaf959a83659c166a98ad05.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <f878da91a2dcaec14aaf959a83659c166a98ad05.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 01:53:41 +0000
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
- [Medium] sched/deadline: missing zero-deadline check in
  switched_to_dl()
- [Medium] sched/deadline: dl_boost_blocked() skips tasks with non-zero
  dl_deadline
- [Medium] sched/deadline: switched_to_dl() skips donor period when
  throttled task is boosted
--

commit e2fecf170ee9d540debd8f3437e1896d21f58e13
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Start a period for a task that enters the class blocked

This commit starts a deadline period for a task blocked on an rt_mutex
when it enters SCHED_DEADLINE via switched_to_dl() or receives a new
priority-inheritance donor via dl_boost_blocked(), so that the rt_mutex
chain walk sorts its waiter with a current deadline rather than 0.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 5ec1c5eaf7647..4d46d1c9c6981 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -1301,6 +1312,30 @@ static inline void replenish_dl_new_period(struct =
sched_dl_entity *dl_se,
>  	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
>  }
> =20
> +#ifdef CONFIG_RT_MUTEXES
> +/*
> + * Start a period from the new donor of @p, if @p has no reservation of =
its
> + * own and waits on an rt_mutex. The enqueue does this for a queued task=
, in
> + * replenish_dl_entity(). A blocked task is not enqueued, but the chain =
walk
> + * copies its deadline into its waiter.
> + *
> + * Call it only when the donor changes. A new period changes the deadlin=
e,
> + * so the chain walk finds the waiter out of date and goes on. In a ww_m=
utex
> + * cycle, a new period at each step would never let the walk stop.
> + *
> + * The caller holds the rq lock and the pi_lock of @p, and has updated t=
he
> + * rq clock.
> + */
> +void dl_boost_blocked(struct task_struct *p)
> +{
> +	struct sched_dl_entity *dl_se =3D &p->dl;
> +
> +	if (!dl_se->dl_deadline && !dl_se->dl_throttled &&
> +	    dl_task_pi_blocked(p))
> +		replenish_dl_new_period(dl_se, task_rq(p));
> +}
> +#endif

[Severity: Medium]
Can dl_boost_blocked() leave an expired p->dl.deadline in place when a
blocked task still has a non-zero dl_se->dl_deadline?

When a SCHED_DEADLINE task leaves the class before its 0-lag time,
switched_from_dl() leaves dl_se->dl_deadline and dl_se->deadline non-zero
until inactive_timer fires.  If that task holds an rt_mutex, blocks on a
second rt_mutex, and gets boosted back into dl_sched_class before
dl_se->deadline passes, switched_to_dl() cancels inactive_timer (so
__dl_clear_params() never clears dl_se->dl_deadline) and does not start a
new period.  If a second deadline donor with an earlier deadline boosts
the task after dl_se->deadline has passed, dl_boost_blocked() returns
early because dl_se->dl_deadline is non-zero, and the chain walk requeues
the waiter with the expired dl_se->deadline ahead of waiters with current
deadlines.

> @@ -4866,6 +4901,26 @@ static void switched_to_dl(struct rq *rq, struct t=
ask_struct *p)
>  	if (!task_on_rq_queued(p)) {
>  		add_rq_bw(&p->dl, &rq->dl);
> =20
> +		/*
> +		 * The chain walk sorts the waiter of a task by its deadline,
> +		 * before the wakeup sets the task up. A task new to the class
> +		 * has a deadline of 0, which goes before every real one. So
> +		 * start a new period now for a task that waits on an
> +		 * rt_mutex, as setup_new_dl_entity() does at an enqueue.
> +		 *
> +		 * A task that comes back to the class before its 0-lag time
> +		 * keeps its deadline. For a constrained task, that deadline
> +		 * can have passed before its next period. As
> +		 * dl_check_constrained_dl() does, leave such a task alone
> +		 * unless it is boosted. Its wakeup throttles it until its
> +		 * next period.
> +		 */
> +		if (dl_task_pi_blocked(p) && !p->dl.dl_throttled &&
> +		    dl_time_before(p->dl.deadline, rq_clock(rq)) &&
> +		    (is_dl_boosted(&p->dl) ||
> +		     !dl_time_before(rq_clock(rq), dl_next_period(&p->dl))))
> +			replenish_dl_new_period(&p->dl, rq);
> +
>  		return;
>  	}

[Severity: Medium]
Does switched_to_dl() skip replenish_dl_new_period() when a task with
p->dl.deadline =3D=3D 0 enters SCHED_DEADLINE with a constrained reservation
while blocked on an rt_mutex?

__setparam_dl() writes p->dl.dl_deadline and p->dl.dl_period before
switched_to_dl() runs.  When p->dl.deadline is 0, dl_next_period(&p->dl)
evaluates to dl_period - dl_deadline.  If rq_clock(rq) < dl_period -
dl_deadline, dl_time_before(rq_clock(rq), dl_next_period(&p->dl)) is
true, so switched_to_dl() treats the never-initialized deadline as being
in a constrained gap and leaves p->dl.deadline at 0 for the rt_mutex
chain walk.

In addition, if a blocked task returning to SCHED_DEADLINE before its
0-lag time changes its dl_deadline or dl_period via sched_setattr(),
dl_next_period(&p->dl) mixes the old p->dl.deadline with the newly
overwritten p->dl.dl_deadline and p->dl.dl_period.  Even after the later
commit "sched/deadline: Keep the debt of a task across a change of
parameters" replaces the dl_next_period() check with
dl_in_constrained_gap(), dl_in_constrained_gap() still returns true when
deadline =3D=3D 0 and period_start =3D=3D 0 while now < dl_period unless
!p->dl.deadline is checked first.

[Severity: Medium]
Does the !p->dl.dl_throttled check in switched_to_dl() also prevent a
throttled departed task from receiving a donor period when it is boosted
back into SCHED_DEADLINE?

If a constrained SCHED_DEADLINE task exhausts its runtime
(p->dl.dl_throttled =3D 1), switches to SCHED_OTHER before its next period,
and blocks on an rt_mutex while holding another rt_mutex, a PI boost back
into dl_sched_class after p->dl.deadline has passed sees
p->dl.dl_throttled =3D=3D 1 in switched_to_dl() and skips
replenish_dl_new_period().  The chain walk then queues the waiter with
the expired p->dl.deadline instead of the donor's deadline, and on unlock
enqueue_task_dl() clears dl_throttled because is_dl_boosted(&p->dl) is
true, letting the task run immediately ahead of earlier-deadline waiters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D30
