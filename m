Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097822;
	b=CUCJZLOd9t1JyIzV9KP4cz445EYtJqzYEivZ8A81kZNDlX7JIpew7oDXVmuygtCpzk1A
	 UbwdRmrsr2E6ZKErF/1PonkUaKv18/scCtY07L12yTLmkfOBJ9sJSCC6HsK6sjm8KGsbU
	 QLj2Gr1WIsGI3J0yebao5wgl0360iid3y2pHihOPSffSfGFl+PHlW3hFqExbJEfCIXIIt
	 J+fBiyal/jxOlJk28Euke2x9tCZTwi4BO2r4TCMy5HbiZD0vpnHVtPjypvYWRrSBokRc1
	 qtzUUy9fjTFg9oN3izIMoTKmiQ/H+B2hBNA7jPGnstUKp+W7U7/aOF5b9hTyg6w3cBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097822;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fhuagbYq4Tfbcmy4/0xy4XABFoKQaNOWZXZw/RIALow=;
	b=5IoRlGHX0bSwAshuwgBxciOciQ5B6I1E6U8gf8mjWEWEidVSdDFI7IBJ5WwDIJBovhHp
	 v8RdzbeQ/UbSayLuxAaRDfLKUy65lp1v0g4G4Bmj0EhRDdFdtJqv4vGkmeb/sCzjD+6M6
	 U3n0c8/TE6KE/W195cBrtjNc3iHLH2QHQ1FOYBPFstBC1OIRSqwxBC7yJe1pCFAtrFVSn
	 5NlbRwL52b29LZVkVhRB7OgZ70sVqMs53b4FZDZuji67Wu/YtDi9LzRBmYAMwVjyLIjht
	 0CS9Se5u5Kqo5EcDujn4HIIKiqN9zxNdhZe+dWvq0icg1gaq3BIsJKR/Ck84OgZzmoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFL75JCV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C241606A320;
	Thu, 19 Nov 2026 14:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MFL75JCV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100C91F000C7;
	Thu, 19 Nov 2026 14:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795097822;
	bh=fhuagbYq4Tfbcmy4/0xy4XABFoKQaNOWZXZw/RIALow=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MFL75JCVbK4tcdv+MR2By2FSO3x2b269rMPyKEOcThM+SWzTBReHgDPtn22gJjwaa
	 IrAc3L971B9r522vhZkbHp0qoM2JhziIoJ7Cb/tQicIxhfUsHIaDfFUkfhNY5WBSgJ
	 L5Rq5Tr++eD7L0ue2mQK/rcGKvQ32yC2hmOCSUutOrgnzKRjEwZB87F+OMT7Fz49Fh
	 0zoM/wJ9FUraunxM6xaj11SOEyipqDuj+Pj8VTfRfoZ97EdPSFty/1rBOXDE9Fnb7J
	 tAlpuUXElNpZp4IwU27SlEgRvyTUOQ8MjHUSg9UyGdReNKRtYi7lyBws1CYNEzU7yI
	 VHHPFuj5K4wpQ==
Message-ID: <sashiko-outbox-223274@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/17] sched/deadline: Reset the deadline and the
 runtime with the parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795092090.git.mathieu.desnoyers@efficios.com>
References: <cover.1795092090.git.mathieu.desnoyers@efficios.com>
 <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795092090.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 14:17:01 +0000
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
- [Medium] sched/deadline: uncanceled dl_timer in __dl_clear_params()
- [Medium] sched/deadline: donor runtime and deadline retained after PI
  deboost
--

commit f0775a38253db75f6dd935fb60d7593eb5b90b93
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Reset the deadline and the runtime with the parameters

This commit resets a deadline entity's runtime and deadline in
__dl_clear_params() and in switched_from_dl() when a boosted task with no
parameters of its own leaves SCHED_DEADLINE, so that its next entry starts
a new period.

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
Can a task still keep its donor's runtime and deadline after a priority
inheritance deboost when p->dl.dl_runtime is non-zero?

If a task enters SCHED_DEADLINE via sched_setattr() while PI-boosted by a
deadline waiter, __sched_setscheduler() sees prev_class =3D=3D next_class =
=3D=3D
&dl_sched_class and skips switched_from_dl() and switched_to_dl(), while
__setparam_dl() sets p->dl.dl_runtime without clearing the donor's
p->dl.deadline and p->dl.runtime.  When the mutex is unlocked,
rt_mutex_setprio() keeps the task in dl_sched_class and restores
p->dl.pi_se =3D &p->dl without ENQUEUE_REPLENISH, and enqueue_dl_entity()
skips setup_new_dl_entity() because the donor's deadline is still in the
future:

kernel/sched/deadline.c:enqueue_dl_entity() {
	...
	} else if ((flags & ENQUEUE_MOVE) &&
		   !is_dl_boosted(dl_se) &&
		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
		setup_new_dl_entity(dl_se);
	}
	...
}

The task then runs unboosted on the donor's remaining runtime and deadline
(and if it was sleeping during sched_setattr(), skipping switched_to_dl()
also skips add_rq_bw(), underflowing rq->dl.this_bw on dequeue).

Similarly, if a former SCHED_DEADLINE task is PI-boosted and deboosted
before its 0-lag inactive_timer fires, switched_to_dl() cancels
inactive_timer while p->dl.dl_runtime is still non-zero.  On deboost,
switched_from_dl() skips the !p->dl.dl_runtime reset and passes the donor's
deadline and runtime to task_non_contending().

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
Does clearing deadline, runtime, and dl_throttled here without canceling
dl_se->dl_timer leave a stale replenishment timer armed for the old period?

When a throttled task leaves SCHED_DEADLINE at a time when its 0-lag time is
earlier than dl_next_period() (for instance after sched_yield() with
remaining runtime, or with a constrained deadline dl_deadline < dl_period),
__dl_clear_params() runs at the 0-lag time while dl_se->dl_timer is still
queued for the old period end.  If the task re-enters SCHED_DEADLINE before
that timer fires, enqueue_dl_entity() sees dl_se->deadline =3D=3D 0 and sta=
rts a
new period without canceling dl_timer (because dl_throttled was cleared).
When the task throttles in its new period, start_dl_timer() sees
hrtimer_is_queued(&dl_se->dl_timer) and skips arming the timer for the new
replenishment time:

kernel/sched/deadline.c:start_dl_timer() {
	...
	if (!hrtimer_is_queued(timer)) {
		if (!dl_server(dl_se))
			get_task_struct(dl_task_of(dl_se));
		hrtimer_start(timer, act, HRTIMER_MODE_ABS_HARD);
	}

	return 1;
}

When the old dl_timer fires at the old period boundary, dl_task_timer()
replenishes and unthrottles the task early, letting it consume an extra
budget slice in its new period.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795092090.gi=
t.mathieu.desnoyers@efficios.com?part=3D9
