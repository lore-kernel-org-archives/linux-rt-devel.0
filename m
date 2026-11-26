Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658580;
	b=dL28bnbNeIBmXuAwjCCkn0l94MK74MndRuO53B5RcdCOCtasg807k4iprQvSjRjukik7
	 IBDhz3H3+B6kB+dUKpIvBfkepXWkbAx8wWgZMUMcQQ3m8buMx0fiD1yUAhKBjPvj+MXqb
	 S+yP+A7aeVCKIm/T/SaReXS5gwt9pDiwVtmLsSaMzySzDZEidVfBe7lVGoyQtkMihoBH7
	 lo9riGmM7gE61PlOiyWRJ1v9jOoea19x+fVa1e73eediyVZw1GA6IsVeUk2MW54Mz1WYD
	 QSbptMR6Nacaf8rl45WkbTWPHv5WftE5AVsXrnY+OY61qlxK0qxVJQa+BkUEgNWzWUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658580;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tdUbSmAFJCwhs6UJbo8cJ+NlOjPxUK6thl/R+o9JtJQ=;
	b=mrXwBWoJSivDFNc5IBb3nf2YLgmsDIlkhZVDmv2WgC91UevRa08xr6Y+PrAfOijh17tG
	 qm2jv47vpXKym50XdWtClhlWHHwkxvzPl1lAarppxEAlorSQ+XUt5ug4RElhEmiG/vQYp
	 vpgjFJqvoEWBeTKS9bgyxKyzwBUlib6g3PcAS5w9cB8/bc8O2O+DYIU+MgGUQn1T7OjGP
	 jRFWQDMR8XVosL6DEp3wBv67VqMMtcgPggNSeqJtB2WS+voOdvLYSv+Ph2QVf6Ud4y+jv
	 ljdE0Fnhp9oIAzGDqPtomdO6AC5lWhTQI9vUEl5SD4LgycrchIYzI37m68og+Qr4aHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RN5H1iPO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360F6606A31E;
	Thu, 26 Nov 2026 02:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RN5H1iPO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FF71F000C4;
	Thu, 26 Nov 2026 02:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658580;
	bh=tdUbSmAFJCwhs6UJbo8cJ+NlOjPxUK6thl/R+o9JtJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RN5H1iPOg+AerWiWxqlhEB0qePxtUxzGypTAHapo4iLePH6JB0lCWwk8IBf0IHD59
	 FvhKA0nvIPEJaRzX2KAS/c7nyF5e80bCU3FSBKUWslns73klfFbHUQU2809UNH42J3
	 thy4+P5uBwkuMMh94qYdNBZPN7tnuwHLWHAUWwegLF0VHk/qLp51LqaMWo7jn/2Hn5
	 sufzPn7iO2vmGuuk7/g1PxY6Gr80GPJXuieo/+En5AHedCZOmOCn9ZJKoYziuIIx7Q
	 2BXMjm2AUfJ/DWE+mV53k8vHdIX5HPcPGH5Lfdi4tZFHEQzx3oogRelu/VB+rpSbzw
	 6Ek57ALfhtxmA==
Message-ID: <sashiko-outbox-234600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 41/43] sched/deadline: Run a boost held at its first
 refill on a donor period
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <a6b6005cb9ccdba38560bbc40d1a22649432b14d.1795646915.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <a6b6005cb9ccdba38560bbc40d1a22649432b14d.1795646915.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 02:02:59 +0000
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
- [Medium] sched/deadline: stale donor period or zero runtime in
  dl_boost_donor_period()
--

commit 5fe21dc7cf6ba0759a7b3c870c560c1b847c8ab3
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Run a boost held at its first refill on a donor period

This commit updates dl_hold_refilled_boost() and replenish_dl_new_period()
so that a boost held at its first refill from a donor runs on a resumed or
newly started donor period via dl_boost_donor_period().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 52095e24638cc..3d573bf812eed 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -1663,11 +1668,13 @@ static void wakeup_preempt_dl(struct rq *rq, stru=
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

[Severity: Medium]
Can keeping the period placed by dl_note_donor_refill() here leave
dl_se->runtime at 0 or resume a stale donor's deadline and runtime?

kernel/sched/deadline.c:dl_boost_donor_period() {
	...
	if (dl_se->dl_boost_granted && runtime && period &&
	    dl_time_before(now, dl_se->boost_period_start + period)) {
		dl_se->period_start =3D dl_se->boost_period_start;
		dl_se->deadline =3D dl_se->boost_deadline;
		dl_se->runtime =3D dl_se->boost_runtime;
		if (!dl_time_before(now, dl_se->deadline)) {
			dl_se->period_start +=3D period;
			dl_se->deadline +=3D period;
			dl_se->runtime =3D runtime;
		}
		if (dl_entity_overflow(dl_se, now))
			dl_se->runtime =3D (READ_ONCE(pi_se->dl_density) *
					  (dl_se->deadline - now)) >> BW_SHIFT;
		return;
	}
	...
}

When replenish_dl_new_period() is the first refill that holds the boost
(for example from update_dl_entity() on wakeup, or at the end of
replenish_dl_entity() when the owner still had positive runtime left past
its own deadline), there is no while (dl_se->runtime <=3D 0) loop after it.
If dl_boost_donor_period() resumes a granted period where boost_runtime is
0, or where the density calculation near boost_deadline truncates to 0,
replenish_dl_new_period() returns with dl_se->runtime =3D=3D 0.

In addition, if the previous held boost came from a different donor (or the
same donor before sched_setattr()) with a longer deadline and larger
runtime, dl_boost_donor_period() resumes boost_deadline and boost_runtime
as long as now is before boost_period_start + period, without checking that
they match the current donor's dl_deadline and dl_runtime.  That can give
the owner a deadline later than the current waiter's (or its own) and a
runtime larger than the current donor's dl_runtime.

[ ... ]

> @@ -6016,11 +6026,15 @@ static bool dl_setattr_period(struct sched_dl_ent=
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
> @@ -6037,6 +6051,14 @@ static void dl_hold_refilled_boost(struct sched_dl=
_entity *dl_se)
>  		dl_setattr_place(dl_se, now, &dl_se->own_period_start,
>  				 &dl_se->own_deadline, &dl_se->own_runtime,
>  				 old_runtime, old_deadline, old_period, false, false);
> +	/*
> +	 * replenish_dl_entity() checks the donor's parameters: it adds no
> +	 * runtime if they were cleared. Start no period from them then.
> +	 */
> +	if (!donor_runtime || !donor_deadline)
> +		return false;
> +	dl_boost_donor_period(dl_se);
> +	return true;
>  }

[Severity: Medium]
When the donor leaves SCHED_DEADLINE and has its parameters cleared on
another CPU before the rt_mutex chain walk deboosts the owner, can
returning false here after setting dl_se->dl_boost_held =3D 1 corrupt the
owner's period and saved boost state?

First, in replenish_dl_entity(), if the donor's parameters are already
cleared at the initial check, dl_note_donor_refill() is called when
dl_se->runtime < 0 or dl_se->dl_yielded is set.  dl_hold_refilled_boost()
sets dl_se->dl_boost_held =3D 1 and returns false without placing a donor
period, leaving dl_se->deadline and dl_se->period_start set to the owner's
own period with dl_se->runtime =3D=3D 0.  When the boost ends,
dl_end_held_boost() sees dl_boost_held =3D=3D 1 and saves the owner's own
period with boost_runtime =3D 0 into boost_* and sets dl_boost_granted =3D =
1,
so the next held boost from a valid donor resumes the owner's old period
with 0 runtime.

Second, when dl_note_donor_refill() is called from
replenish_dl_new_period(), returning false from dl_hold_refilled_boost()
causes replenish_dl_new_period() to enter the !dl_note_donor_refill(dl_se)
branch and overwrite dl_se->period_start =3D rq_clock(rq), dl_se->deadline =
=3D
dl_se->period_start + 0, and dl_se->runtime =3D 0 from the cleared donor
parameters anyway.

Third, because dl_hold_refilled_boost() (which also omits checking
pi_se->dl_period), dl_boost_donor_period(), and replenish_dl_new_period()
re-read pi_se's parameters instead of using replenish_dl_entity()'s
validated snapshot, a concurrent __dl_clear_params(pi_se) after
replenish_dl_entity()'s initial check makes dl_hold_refilled_boost() return
false while replenish_dl_entity() proceeds to the while (dl_se->runtime <=3D
0) loop, advancing the owner's own deadline by the donor's period.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D41
