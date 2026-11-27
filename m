Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800511;
	b=AJ8D4LcIdD7U4bEHShFgrfeumbSCfT66DBes53oDOloc1iSnAK8IlaDNRJ2reBgnX6Vw
	 UUYCDOHEMHhUc0Ng+RY+J0Fw+Lc+115+uzVmGfYaj09QUppPOCWTpPrWaWSe4fLSfPh/t
	 aVpgnwvvPFecm2DOKj9UydAtOWJcBJYkcBkzDz5g9lMrWLEw/x8aInPVVjmdtgYq+M/Ma
	 LlETVO4T3NvQblAcQlgW20zhG5PtoQu83ZHjacn6pRnH2Hr4tk2KkS4aCpQlO4pqvxG5+
	 QJV2SN+7RKEiHmh++cd1DfQ+uQ+o6g4wPBjFVoPGe0MmPnLyxcd2BI+IVlKaeUPAcIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800511;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IBu0HA6hJlpz85DSvdGM2TgmdFaDpZLyEz7AbufuMnU=;
	b=TxLoQJpIt2FUEHxR8p6ch1ri+Jna9dWkB1z50N0wxDsnwrbGfEEeDa1hz46/kIGpszVY
	 KoKrTBWbH7EbbxJtKU5b3vazuFMLWt28Y9mdjeRTZhsD5tw7Ts8dcmBrCBdlsE0kin7V5
	 s4kY1JYtOzDZvYWucPYdnke033w7h74eTCbPR2zhZNc71isxo6VtTuPKwTeOy344QfbMs
	 t+Jbh5ZcI0tHJ2HDozdQzQPAea/UBrHd0kcgb4tutZqovCMvx23jG/dB0Eelf90zQH/e8
	 5avbv/VFwt7BuipDm1JWAbaiposP3bzzdyKFlh2TyW6JK2aUtEoyhkW5uG6kU5QcLsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3N3d1BY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094BB606A333;
	Fri, 27 Nov 2026 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3N3d1BY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2434F1F00898;
	Fri, 27 Nov 2026 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795800510;
	bh=IBu0HA6hJlpz85DSvdGM2TgmdFaDpZLyEz7AbufuMnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F3N3d1BYrocGazZc6rJVbSCw22opLG5i0HjtwWnTmvpvrOb5/Ds72dvVvTX52WErF
	 bXadGhXXfyRg799SoQOyei8f9s4hiuVERBY5FTcvKFhf4RKmSJJxXewahBaV0q35Hz
	 bY2ngZ1UkaamkyH459QT9Ugcmj/vRkl0eisBcEq0p+rBu/ekd8DtD662Sjso+G6K2g
	 mEnmDt3d8bZEwwJCcBtrHJ7xCG9ocZOe/98gGEycq+/I1OmOrDB38WZe4piSAOl9dn
	 UWDLv32YbBNMAbUyXtlWQJX2/9vsbYXCHSblcBPwdmjDHkKjnIT9fQ84jj3+JPVV9W
	 xyAJK7xRTt+Jw==
Message-ID: <sashiko-outbox-237990@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 31/43] sched/deadline: Restore the owner's period at
 a deboost out of the class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <a802201284a7bff640a793ee06356eda187bf59e.1795771148.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <a802201284a7bff640a793ee06356eda187bf59e.1795771148.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 17:28:29 +0000
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
- [Medium] sched/deadline: unreplenished wakeup of boosted task with
  zero runtime
--

commit 0aea8c212d9bcdc25976b70fd796e3d1b02c40e5
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Restore the owner's period at a deboost out of the class

This commit restores a task's own deadline and runtime (or starts a new
period) in switched_from_dl() when leaving SCHED_DEADLINE after a donor
refill, and throttles unboosted tasks with no remaining runtime on
enqueue.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 9c707512d93d8..6e20efb863594 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3132,6 +3132,21 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, i=
nt flags)
>  		setup_new_dl_entity(dl_se);
>  	}
> =20
> +	/*
> +	 * A task can come back to the class with no runtime left, before its
> +	 * deadline. It would run until the next tick. Throttle it now, until
> +	 * its next period, as update_curr_dl_se() would.
> +	 */
> +	if (!dl_server(dl_se) && !is_dl_boosted(dl_se) &&
> +	    !dl_entity_is_special(dl_se) && dl_se->dl_runtime &&
> +	    !dl_se->dl_throttled && dl_se->runtime <=3D 0) {
> +		struct rq *rq =3D rq_of_dl_se(dl_se);
> +
> +		dl_se->dl_throttled =3D 1;
> +		if (task_current_donor(rq, dl_task_of(dl_se)))
> +			resched_curr(rq);
> +	}

[Severity: Medium]
Can a task waking up while boosted be enqueued onto dl_rq with
dl_se->runtime =3D=3D 0 and its exhausted own_deadline instead of being
replenished from its donor?

When switched_from_dl() calls dl_end_held_boost(&p->dl, false), a task
that exhausted its own runtime before the first donor refill leaves the
class with p->dl.runtime =3D=3D 0, p->dl.deadline =3D=3D own_deadline in the
future, and p->dl.dl_throttled =3D=3D 0.  If it then sleeps while holding an
rt_mutex and a SCHED_DEADLINE waiter boosts it back into the class before
own_deadline, neither rt_mutex_setprio() nor switched_to_dl() replenishes
it while asleep (and in the later commit "sched/deadline: Boost an owner
that cannot run on its own reservation", dl_boost_start() is skipped when
!dl_prio(p->normal_prio) and also returns early when !dl_se->dl_throttled
&& !dl_in_constrained_gap(dl_se)).

When the task wakes up before own_deadline, enqueue_dl_entity() with
ENQUEUE_WAKEUP calls update_dl_entity(), where both
dl_time_before(dl_se->deadline, rq_clock(rq)) and dl_entity_overflow() are
false because runtime is 0.  Because the new dl_se->runtime <=3D 0 check
above skips is_dl_boosted(dl_se) without replenishing,
__enqueue_dl_entity() queues the boosted task with runtime =3D=3D 0 and
deadline =3D=3D own_deadline, causing EDF priority inversion when own_deadl=
ine
is later than a donor period's deadline.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D31
