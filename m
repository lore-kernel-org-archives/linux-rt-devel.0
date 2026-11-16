Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857894;
	b=ijbeEMCrrR1xIc5V7w0tikFPbWxjtrYRoEuRlj1qCvaDgvhhFNXi3UG4VRSfys8yJU8a
	 EE3uIfiD/NH2kHmJUdhzE/Olv8uf4CdPPmRYkLoRQyDzWwNW0xGvRkWZsPiinzxReFcTk
	 rAWS5qumYX0nvKilQLsYcQp227TLUxURYgssEbwtoGbUItkNH1ZYkFzb0DBizz7rygfvl
	 ++BL/AgKTHSa9ft/3xbo5Bv70xwJqu8VdiTdGBpszFu6w3Wcaex4V2qgD3qWFd/R1c4jY
	 DhrImJcaA6lElKXxYcE7KvWch6pS72ihge81RpgA0UWZaB/iKkbdzNWfQOyXRAiyCVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857894;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T5/jl0WG58J/jWJqcfWQ1ICz7MTZF0OBu/vr4v0ERPM=;
	b=qfABl7m3Q9XMIhyu6aAi9GMkZ4n598x/4t0SL7v+Svy+uPI2DSEbFPzOumbrE+uD+ssx
	 QpQvcomIZ0HHZ4VHPMujyLZBYCsqK9BOQb8itDDuA/2e5S5Mw5BDVEL9ZxAhuM+ckwMRp
	 kBAKN2viJ8g6jNkmnbHqk6YczwdHke8n1GsUW28pG7IjGkS2Dvgh7H6LBP0JmgjS26Y/1
	 ADzqF8TveyRcDsbCLV2fv0ePqCnSmJThIFCg4LZ/DGob9D4rFgBeZC+qRtfmBGqbl94g6
	 StYElPdG+c7w7F/s8vvnNHsXsuSUwRBwbKNPjrIz/QiBmnXw+Mpvw8PyiWW5f5HNR7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYdgJuD4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54344606A323;
	Mon, 16 Nov 2026 19:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dYdgJuD4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9981D1F000C5;
	Mon, 16 Nov 2026 19:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794857893;
	bh=T5/jl0WG58J/jWJqcfWQ1ICz7MTZF0OBu/vr4v0ERPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dYdgJuD47wtMohIU/YRARZOf0lpmj/mRjzRplEtOM0UbvAzq/NQz7MZqLyB4i3/7X
	 4Jwc18JSY/P4iqCtGWXlnhLI8e2vyrAgCrgHNzJXackK2zBJ3Tj06yKMg961tEOkc4
	 K4LeQEBSxdm9uWafF6GyG096zjlx41vzLlmoYg1AyelZkklWDnA0uy48+bS+bLzlF2
	 MmWUJq/KTNzOTv8zrNWdU8i/vzH/yhxIl+HjVMtjawY7VwKIXND2KtUPOD3HVNlFjX
	 cLIuf/Af/Bz43BJggRXEAkjTTRKk4sI+x7P4E0SdNtUVnSJvMtbgaiupFteXZDjY67
	 zhxsLmo7WXDuA==
Message-ID: <sashiko-outbox-217586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/37] sched/deadline: Reset the donor's runtime at a
 deboost in the class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-11-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-11-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:38:13 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] sched/deadline: implicit declaration of
  dl_note_donor_refill()
- [Medium] sched/deadline: rt_mutex_setprio() skips dl_deboost() on
  donor change
- [Medium] sched/deadline: donor runtime kept when leaving
  dl_sched_class
- [Medium] sched/deadline: missing dl_note_donor_refill() on cleared
  donor
- [Low] sched/deadline: __dl_clear_params() fails to clear
  dl_donor_refill
--

commit 25ef3546a7248ed2f828d8c39dc34ecf7474dcc4
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Reset the donor's runtime at a deboost in the class

This commit adds a dl_donor_refill flag to struct sched_dl_entity to track
when a priority-inherited SCHED_DEADLINE task has been replenished from its
donor's reservation, resetting its period on in-class deboost.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5ed660f099a55..a22df8b43a1a7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7834,16 +7834,26 @@ void rt_mutex_setprio(struct task_struct *p, stru=
ct task_struct *pi_task)
>  				p->dl.pi_se =3D pi_task->dl.pi_se;
>  				scope->flags |=3D ENQUEUE_REPLENISH;
>  			} else {
> -				p->dl.pi_se =3D &p->dl;
> +				dl_deboost(&p->dl);
> +				/*
> +				 * dl_deboost() can start a new period. Its
> +				 * deadline can then be after the top waiter's.
> +				 * Boost the task again then.
> +				 */
> +				if (pi_task && dl_prio(pi_task->prio) &&
> +				    dl_entity_preempt(&pi_task->dl, &p->dl)) {
> +					p->dl.pi_se =3D pi_task->dl.pi_se;
> +					scope->flags |=3D ENQUEUE_REPLENISH;
> +				}
>  			}

[Severity: Medium]
When a SCHED_DEADLINE task was refilled from an earlier donor and now switc=
hes
to a new top waiter pi_task, doesn't the outer dl_entity_preempt(&pi_task->=
dl,
&p->dl) check compare pi_task against the old donor's postponed deadline
before dl_deboost() can reset p->dl to its own reservation?

If the first donor's refill pushed p->dl.deadline past pi_task->dl.deadline,
rt_mutex_setprio() takes the first branch and skips dl_deboost(). Because
p->dl.dl_deadline is non-zero and p->dl.runtime > 0, replenish_dl_entity()
leaves the first donor's remaining runtime and postponed deadline in place
after the unlock. Calling dl_deboost(&p->dl) unconditionally when
dl_prio(p->normal_prio) before testing dl_entity_preempt(&pi_task->dl, &p->=
dl)
would reset the period first and then boost from the new waiter if needed.

>  		} else if (rt_prio(prio)) {
>  			if (dl_prio(oldprio))
> -				p->dl.pi_se =3D &p->dl;
> +				dl_drop_boost(&p->dl);
>  			if (oldprio < prio)
>  				scope->flags |=3D ENQUEUE_HEAD;
>  		} else {
>  			if (dl_prio(oldprio))
> -				p->dl.pi_se =3D &p->dl;
> +				dl_drop_boost(&p->dl);
>  			if (rt_prio(oldprio))
>  				p->rt.timeout =3D 0;
>  		}

[Severity: Medium]
What happens if a task with its own deadline parameters (p->dl.dl_runtime !=
=3D 0)
is refilled from a donor and then leaves dl_sched_class at deboost, for
instance after changing its policy via sched_setattr() while boosted (or be=
ing
boosted again before its 0-lag timer fires)?

sched_change_begin() runs switched_from_dl() before dl_drop_boost() clears
dl_donor_refill, and switched_from_dl() only resets deadline and runtime wh=
en
!p->dl.dl_runtime:

kernel/sched/deadline.c:switched_from_dl() {
	if (task_on_rq_queued(p) && p->dl.dl_runtime)
		task_non_contending(&p->dl, false);
...
	if (!p->dl.dl_runtime) {
		p->dl.deadline =3D 0;
		p->dl.runtime =3D 0;
	}
}

task_non_contending() then computes zerolag_time from the donor's refilled
deadline and runtime combined with p's own dl_period and dl_runtime. If the
donor's remaining runtime makes zerolag_time negative, task_non_contending()
immediately clears p's parameters even though p already exhausted its own
budget in this period; otherwise p keeps the donor's runtime and deadline
with dl_donor_refill cleared if it returns to SCHED_DEADLINE before the
inactive timer fires.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index dd48f74412b87..1f3da0e0a698c 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -93,6 +93,38 @@ static inline bool is_dl_boosted(struct sched_dl_entit=
y *dl_se)
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
> +	}
> +	dl_drop_boost(dl_se);
> +}
>  #else /* !CONFIG_RT_MUTEXES: */
>  static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_s=
e)
>  {

[Severity: Medium]
Does this break the build when CONFIG_RT_MUTEXES is disabled?
dl_note_donor_refill() is defined inside #ifdef CONFIG_RT_MUTEXES with no
stub in the #else branch, but replenish_dl_new_period() and
replenish_dl_entity() call it unconditionally.

[ ... ]

> @@ -842,11 +875,15 @@ static void replenish_dl_entity(struct sched_dl_ent=
ity *dl_se)
>  	    (dl_se->dl_defer_armed && dl_entity_overflow(dl_se, rq_clock(rq))))=
 {
>  		dl_se->deadline =3D rq_clock(rq) + deadline;
>  		dl_se->runtime =3D runtime;
> +		dl_note_donor_refill(dl_se);
>  	}
> =20
>  	if (dl_se->dl_yielded && dl_se->runtime > 0)
>  		dl_se->runtime =3D 0;
> =20
> +	if (dl_se->runtime <=3D 0)
> +		dl_note_donor_refill(dl_se);
> +

[Severity: Medium]
Should the early return when !runtime earlier in replenish_dl_entity() also
call dl_note_donor_refill(dl_se)?

kernel/sched/deadline.c:replenish_dl_entity() {
	if (unlikely(!runtime)) {
		WARN_ON_ONCE(!is_dl_boosted(dl_se));
		dl_se->dl_yielded =3D 0;
		dl_se->dl_throttled =3D 0;
		return;
	}
}

When a donor leaves the class and its parameters are cleared before the lock
owner is deboosted, this path keeps the owner runnable after it exhausted i=
ts
runtime, and update_curr_dl_se() continues driving dl_se->runtime negative.
Without dl_donor_refill set, dl_deboost() will not start a new period and t=
he
boosted execution is charged against the owner's own reservation (or leaves
deadline at 0 if the owner entered SCHED_DEADLINE while boosted).

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 92134ce326a49..d87296abec4c2 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -356,6 +356,16 @@ extern int  sched_dl_global_validate(void);
>  extern void sched_dl_do_global(void);
>  extern int  sched_dl_overflow(struct task_struct *p, int policy, const s=
truct sched_attr *attr);
>  extern void __setparam_dl(struct task_struct *p, const struct sched_attr=
 *attr);
> +#ifdef CONFIG_RT_MUTEXES
> +extern void dl_deboost(struct sched_dl_entity *dl_se);
> +
> +/* End the boost of @dl_se. The caller holds the rq lock of its task. */
> +static inline void dl_drop_boost(struct sched_dl_entity *dl_se)
> +{
> +	dl_se->pi_se =3D dl_se;
> +	dl_se->dl_donor_refill =3D 0;
> +}
> +#endif

[Severity: Low]
Should __dl_clear_params() also clear dl_donor_refill (or call
dl_drop_boost()) instead of only setting dl_se->pi_se =3D dl_se?

kernel/sched/deadline.c:__dl_clear_params() {
...
	dl_se->dl_defer_running		=3D 0;
	dl_se->dl_defer_armed		=3D 0;

#ifdef CONFIG_RT_MUTEXES
	dl_se->pi_se			=3D dl_se;
#endif
}

If a task forks while boosted and refilled by a donor, dup_task_struct()
copies dl_donor_refill =3D 1 into the child and __sched_fork() ->
init_dl_entity() -> __dl_clear_params() leaves it set, which would cause an
unintended period reset if the child later becomes SCHED_DEADLINE and passes
through dl_deboost().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D10
