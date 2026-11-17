Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930303;
	b=PQ+VtzG8lNj7PqIgZoUMFKO5tES6hZYS+Td27nQ+i+CBFX/3iMwAaNGM0Wd+ZXmnl1Sv
	 IgttzsZ3cjn2yi0oTWbBqBqjPhUIpf0OtMw1hzMyLtgk0nmJrvNWvYWIW1o9cjzH1KeLC
	 XlkYYbQzeGvZ0k2Cb4rrMJyN180kpoevGmDR6+d3CJXLriu1hO/ozCnYeB3HD7z8m0eD0
	 QCPB6F3EghGBP3KZfFx2ssH++1Fgr3OrIp/mpIjhhXV0XjDbsdhUUCAZm/UANDxoJtLzA
	 8MftD/8YqugBT07EzVCpSNohuN3e3DUHzd/mEMVEHEDV1IIVwuQKkNs4A45GlZovUcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930303;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LD1nG13DDJvwSRgDgWdYj3ZDMv2tVel7Etfk2lB4uV4=;
	b=lBPLBv19gTwFqMrT8tfqPjaI6ozCbN4TTmQznWMHt39XpZnjTAUHeei6Ek6wOzFBrfRV
	 sUtgkhAUyGwOibubX4rQZAwaPgKGd324ArtWwZoyK4CrROjmS+uEZ+mCP0qtW27SI0iJ3
	 Id32ZMeDoEz5r/tn4LcyUVqsYHPnKy/g3K/HmoMhKFiV4b5JD2VD4B+HhMdTC8/IMDkIF
	 v7ZvyQBEn1norZR6FKK/VPPbv9B/idmOIJi+kqhZzbPmcbh01SwsLrmOhIK3+JamGW6AB
	 h9Xo1TANbZgHLg1wDNag7cegfdRf3IKXqZGA4D1ju49Avo0tPUFagV3X42x4sIMrsxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3jLobrz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81A0606A330;
	Tue, 17 Nov 2026 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U3jLobrz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC391F000C4;
	Tue, 17 Nov 2026 15:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794930303;
	bh=LD1nG13DDJvwSRgDgWdYj3ZDMv2tVel7Etfk2lB4uV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U3jLobrzjX4hepsYTUdMuQ5C2G7Q58YX2XTWtLICrHS0o1FyFybJL2u6jw39Y7+cl
	 JdCjLvxpe1xD/LoTfqdBacN7kYD6rdb5Z087h04Q8nI3ZqDjnOWbP9aFftiYOeG/Gb
	 En9LpmNurb0MyHUWKDVvckL7t9z+NSEqHV0DS8YDSOqmsz0VKp38U+OD02gUMdG82q
	 UeeE5MGX2FyX48v1O/9j/cBWe/clXeayb7VqZiVEPuYkkaDXeAI3diJfM7bcSmNc7R
	 V87ouWLekDLZaAvSB5HDCYcbFyBdnWZ64ZpvY5J8MIu7RWP+sl5qD3OQdsY/hXHPAM
	 liVni5I2tysFw==
Message-ID: <sashiko-outbox-219102@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 36/40] sched/deadline: Check the runtime of a task
 whose parameters change
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <a7e0d6e42bb46c9304699dbfc63dd24efe842ead.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <a7e0d6e42bb46c9304699dbfc63dd24efe842ead.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:45:02 +0000
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
- [Medium] sched/deadline: boosted task with !dl_donor_refill runs on
  old runtime
- [Medium] sched/deadline: dl_new_params deferred past dl_deboost()
  breaks PI re-boost
- [Medium] sched/deadline: update_dl_entity() on dl_new_params mixes old
  and new params
--

commit 707d1303811b0425863d63e123b53368955b72a6
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Check the runtime of a task whose parameters change

This commit adds a dl_new_params flag to struct sched_dl_entity so that
when sched_setattr() modifies a deadline task's runtime, deadline, or
period, the next non-boosted enqueue calls update_dl_entity() to check the
remaining runtime against the new parameters.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b650c37ae5615..f1d259df8f2a0 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2785,7 +2785,16 @@ static void __dequeue_dl_entity(struct sched_dl_en=
tity *dl_se)
>  static void
>  enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
>  {
> +	bool new_params =3D dl_se->dl_new_params;
> +
>  	WARN_ON_ONCE(on_dl_rq(dl_se));
> +	/*
> +	 * A boosted task runs on the parameters of its donor. Keep the mark
> +	 * until an enqueue checks the runtime against its own: the one at
> +	 * the deboost, or at a wakeup.
> +	 */
> +	if (!is_dl_boosted(dl_se))
> +		dl_se->dl_new_params =3D 0;

[Severity: Medium]
Can a boosted SCHED_DEADLINE task with !dl_se->dl_donor_refill keep
running on its old reservation's remaining runtime after sched_setattr()
shrinks its parameters?

When a SCHED_DEADLINE task with dl_se->runtime > 0 is boosted by an
earlier-deadline waiter, replenish_dl_entity() does not refill it from the
donor and leaves dl_se->dl_donor_refill at 0:

kernel/sched/deadline.c:replenish_dl_entity() {
    ...
	if (dl_se->runtime <=3D 0)
		dl_note_donor_refill(dl_se);

	while (dl_se->runtime <=3D 0) {
		dl_se->deadline +=3D period;
		dl_se->runtime +=3D runtime;
	}
    ...
}

Because the task is still consuming its own remaining runtime rather than
the donor's, deferring dl_new_params whenever is_dl_boosted(dl_se) is true
lets the task consume the old larger runtime while holding the lock, even
though sched_dl_overflow() has already released the old bandwidth in the
root domain for other deadline tasks to use.

> @@ -2834,12 +2843,13 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, =
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
>  	} else if ((flags & ENQUEUE_MOVE) &&

[Severity: Medium]
When a boosted task with dl_new_params set and !dl_se->dl_donor_refill is
deboosted in rt_mutex_setprio(), does deferring update_dl_entity() until
enqueue_dl_entity() miss the post-deboost re-boost check?

In rt_mutex_setprio(), dl_deboost(&p->dl) only updates p->dl.deadline when
dl_se->dl_donor_refill is set, and immediately checks whether the task
must be boosted again by the remaining top waiter:

kernel/sched/core.c:rt_mutex_setprio() {
    ...
				dl_deboost(&p->dl);
				/*
				 * dl_deboost() can start a new period. Its
				 * deadline can then be after the top waiter's.
				 * Boost the task again then.
				 */
				if (pi_task && dl_prio(pi_task->prio) &&
				    dl_entity_preempt(&pi_task->dl, &p->dl)) {
					p->dl.pi_se =3D pi_task->dl.pi_se;
					scope->flags |=3D ENQUEUE_REPLENISH;
				}
    ...
}

Because update_dl_entity() only runs later in sched_change_end() ->
enqueue_task_dl() -> enqueue_dl_entity(), dl_entity_preempt() compares
pi_task->dl against p->dl.deadline before update_dl_entity() advances
p->dl.deadline to a new period, leaving p unboosted with a deadline later
than its top waiter.  If p is blocked on another rt_mutex (!scope->queued)
when deboosted, enqueue_dl_entity() does not run at all, so the priority
inheritance chain walk propagates p's stale deadline.

[Severity: Medium]
Can calling update_dl_entity() on dl_new_params mix the previous period's
dynamic state with the newly written static parameters when switching
between constrained and implicit deadlines?

If a running task started its current period with a constrained deadline
(dl_deadline < dl_period) and calls sched_setattr() to switch to an
implicit deadline (dl_deadline =3D=3D dl_period), __setparam_dl() overwrites
dl_se->dl_deadline and dl_se->dl_period before enqueue_dl_entity() runs.
When dl_entity_overflow() then triggers in update_dl_entity(),
!dl_is_implicit(dl_se) is now false:

kernel/sched/deadline.c:update_dl_entity() {
    ...
		if (unlikely((!dl_is_implicit(dl_se) ||
			      (dl_se->dl_defer && dl_se->dl_defer_running)) &&
			     !dl_time_before(dl_se->deadline, rq_clock(rq)) &&
			     !is_dl_boosted(dl_se))) {
			update_dl_revised_wakeup(dl_se, rq);
			return;
		}

		dl_se->dl_defer_running =3D 0;
		replenish_dl_new_period(dl_se, rq);
    ...
}

Instead of capping the runtime via update_dl_revised_wakeup(),
update_dl_entity() calls replenish_dl_new_period() and grants a full fresh
runtime before the constrained reservation's period or 0-lag time has
elapsed.  Conversely, if a runnable task whose old deadline has already
passed switches to a constrained deadline, dl_check_constrained_dl() at
the top of enqueue_dl_entity() computes dl_next_period() from the old
dl_se->deadline and the new dl_deadline/dl_period, throttles the task, and
returns before update_dl_entity() can start a new period.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D36
