Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117721;
	b=z/efTHd/4y8ZDh+o2OBnvJylVdgYWLuAxD35IbT4VOxaUpgblFiXkO7c9j6Y+SAnFIm5
	 ih6jQP9YdO7PLyOeJXtcCYTogwdXE/D4PL19OxS7b5DNK/+YQXdDf2tePze97eFqJzZq9
	 3DwRU/WGf5GWohI+tRRvK8xO6RYT8PbOv9HgtXAnh50ijAt/rDsc22Yi2v4SMzDAhmNF2
	 1VEimSoCFwo6muT8Tr7JbdIyJRGBy8muQCGuvV3pg1utJKO5DWF03dGJQ0PrmAc7gFmaW
	 JvoMTLdUz0JWUOcTDZJ/7RLid/qjzicLx10RpjcHOb/4qDAa+r8lsIFnpDqSWs2k6og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117721;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Yx08n39nXmj2ZO8vnABtp5adBK0JedRf7qIS6ngU52A=;
	b=btL/hb/954095TqOXvpbKvrmPpkpGmcKGciRzshAy4vdmtTLgV0f3SgXNb6Y6lLKEws9
	 llqxjguGGx8+x0WGzL++8lbRIXn02mVnuW/+hzCNGnZlEzvH1tC10TbGVPqZ0sN+lOOwt
	 QSpdTeK5PoK9+Smk58AHyJ9fzNoA3qUUITZiphGFM8/L8eL7i5iTFKbIR9HbBlsw6S6iY
	 wRPXU1ATISUTP74U3R+oEWyTNfG4NbgY6nYqxnk1nWjiww5nLwfYjX6G1gAKrjVAAVcwG
	 rWs+aUZ9xXsGo+8sHUFmENqJttlNKriDzh9vynWSE9gdlqkcycF6FqtLR+7eAApU1nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEl369YZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0DE606A326;
	Thu, 19 Nov 2026 19:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEl369YZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9AD1F000C5;
	Thu, 19 Nov 2026 19:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117720;
	bh=Yx08n39nXmj2ZO8vnABtp5adBK0JedRf7qIS6ngU52A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NEl369YZTSpVlkTNGdEY27HeGERNCnQqE7Wk62E+WoJLlQDoOb7hzhRazlLpRR3uc
	 o07EXbBZPlSQyhi1Lo3AQJGgv7aHLw5Y9v+pBpBEkT79Ea0iuGnzbBCTUysp9h7puF
	 z0gBROIyPI2iGs18WS9PFpNqgvhmrZBbBj2KMJU4ADwHPuev6iW2ATAXXVaMZBcDQz
	 wywT7jc1xyZe+pGqn+RHHPw9KebfV71vR8OfFzrd75FwXIOqkV5FtdwMY/sRpRKda8
	 k64hZwiPxJLD4yZ6UeIZWnd65klaDlmTxpzVI4vk5uGNjaFrb8sdA0QjnA02MG0pvh
	 Hn09p3eDOme/A==
Message-ID: <sashiko-outbox-223973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/17] sched/deadline: Reset the deadline and the
 runtime with the parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795115075.git.mathieu.desnoyers@efficios.com>
References: <cover.1795115075.git.mathieu.desnoyers@efficios.com>
 <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795115075.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:48:39 +0000
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
- [Medium] sched/deadline: donor runtime and deadline retained after PI
  deboost
- [Medium] sched/deadline: uncanceled dl_timer in __dl_clear_params()
--

commit 05620e4d8280739bac7b4e66a17979a460a0143c
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Reset the deadline and the runtime with the parameters

This commit resets a deadline entity's dynamic deadline and runtime in
__dl_clear_params() and when a PI-boosted task without its own deadline
parameters leaves SCHED_DEADLINE in switched_from_dl().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 71b1c155c2424..d6d2657dcddd6 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3569,6 +3569,16 @@ static void switched_from_dl(struct rq *rq, struct=
 task_struct *p)
>  	if (task_on_rq_queued(p) && p->dl.dl_runtime)
>  		task_non_contending(&p->dl, false);
> =20
> +	/*
> +	 * A task with no parameters of its own was boosted into the class.
> +	 * Its deadline and runtime are the donor's. Reset them, so that its
> +	 * next entry into the class starts a new period.
> +	 */
> +	if (!p->dl.dl_runtime) {
> +		p->dl.deadline =3D 0;
> +		p->dl.runtime =3D 0;
> +	}
> +

[Severity: Medium]
Can a task still retain the donor's runtime and deadline after a PI deboost
when p->dl.dl_runtime is non-zero?

If a non-deadline task is PI-boosted into dl_sched_class and sched_setattr()
then switches it to SCHED_DEADLINE while still boosted, prev_class and
next_class in __sched_setscheduler() are both &dl_sched_class.
switched_from_dl() and switched_to_dl() are skipped, and __setparam_dl()
sets p->dl.dl_runtime without clearing the donor's p->dl.deadline or
p->dl.runtime (and if p is sleeping, skipping switched_to_dl() also skips
add_rq_bw(&p->dl, &rq->dl), later triggering the running_bw > this_bw
warning and underflow in __sub_rq_bw()).  When rt_mutex_setprio() later
deboosts p, it remains in dl_sched_class and restores p->dl.pi_se =3D &p->dl
without ENQUEUE_REPLENISH.  Because the donor's deadline is still in the
future, enqueue_dl_entity() skips setup_new_dl_entity() and p runs unboosted
on the donor's remaining runtime and deadline.

Similarly, if a task with non-zero p->dl.dl_runtime (either a task waiting
for its inactive_timer before 0-lag time that gets PI-boosted, or a boosted
SCHED_DEADLINE task that switches to a non-deadline policy via
__setscheduler_dl_pi()) is replenished from a donor while boosted,
switched_from_dl() on deboost sees p->dl.dl_runtime !=3D 0, skips this rese=
t,
and passes the donor-derived deadline and runtime to task_non_contending().

> @@ -3984,7 +3994,8 @@ bool __checkparam_dl(const struct sched_attr *attr)
>  }
> =20
>  /*
> - * This function clears the sched_dl_entity static params.
> + * Clear the static parameters of @dl_se. Also reset its deadline and its
> + * runtime, so that its next enqueue starts a new period.
>   */
>  static void __dl_clear_params(struct sched_dl_entity *dl_se)
>  {
> @@ -3995,6 +4006,9 @@ static void __dl_clear_params(struct sched_dl_entit=
y *dl_se)
>  	dl_se->dl_bw			=3D 0;
>  	dl_se->dl_density		=3D 0;
> =20
> +	dl_se->deadline			=3D 0;
> +	dl_se->runtime			=3D 0;
> +
>  	dl_se->dl_throttled		=3D 0;
>  	dl_se->dl_yielded		=3D 0;
>  	dl_se->dl_non_contending	=3D 0;

[Severity: Medium]
Can clearing dl_se->deadline, dl_se->runtime, and dl_se->dl_throttled here
without canceling dl_se->dl_timer leave a stale replenishment timer queued
from the old period?

When a task is throttled with its 0-lag time earlier than
dl_next_period(dl_se) (for example after sched_yield() with remaining
runtime, or with a constrained deadline where dl_deadline < dl_period) and
switches out of SCHED_DEADLINE, __dl_clear_params() runs at the 0-lag time
while dl_se->dl_timer is still armed for the old period end.  If the task
re-enters SCHED_DEADLINE before that timer fires, enqueue_dl_entity() sees
dl_se->deadline =3D=3D 0 and starts a new period without canceling dl_timer
(since dl_se->dl_throttled was cleared).  When the task throttles in its new
period, start_dl_timer() sees hrtimer_is_queued(&dl_se->dl_timer) and skips
arming the timer for the new period:

kernel/sched/deadline.c:start_dl_timer() {
	...
	if (!hrtimer_is_queued(timer)) {
		if (!dl_server(dl_se))
			get_task_struct(dl_task_of(dl_se));
		hrtimer_start(timer, act, HRTIMER_MODE_ABS_HARD);
	}

	return 1;
}

When the old dl_timer expires at the previous period boundary,
dl_task_timer() replenishes and unthrottles the task at the wrong time,
allowing it to exceed its admitted bandwidth reservation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795115075.gi=
t.mathieu.desnoyers@efficios.com?part=3D9
