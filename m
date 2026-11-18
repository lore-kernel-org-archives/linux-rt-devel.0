Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034281;
	b=eJziRK5DYGMlwbSb/o9q57CHcZAElQg/w8sYx2Cgqg42qnHx0nHNOV7Ez7Hhl/2ZchDd
	 QOJWlTXazgGCz0rr3p0N5j8P7QLwWTewavJKXI9O6NgB8e2DUyVPK2WNkAOZgXE3tVfqK
	 rQnpMIiBJ6a/RcBCgoeTdiSJaO02BqtBCswqueK2QWxMS97Nd4fNx3otPG32nyVgLvIuF
	 uahUEqDz6kIUQU6am/5Kq2DhKnXOhocNRrd0AwU+Q3vMq27BhQuXJxNPiLELYGUsENm5l
	 Bn9wE8HeMsYzcklDcavkr1mPaWupQS9OJu67bTaV9br+2reJ2Zp8liwRboviCLFQ6Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034281;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gFRMj142tR8+Qh+o/MwcGuA+ioSN7LcSeBCB6sdYTqw=;
	b=cadggvTq8pu5VmKKYfebfTrOe31PQuvfK6acSD+ANCB+X2A8u4n4LS1FZapdNKdesojx
	 CiEabnPZZhREQbU6Fn+J7Y8gGil1BC1GoD8VSid+Xz0Jm6tCcufqfb/1iIX4WZ4CbqGta
	 0uwrvh+Uzv5x2vMS0nUQZjN31KblQkqvOe1FMD8f/AHWs+PgfrAIklIA2yg0by1VkzpIR
	 K4+s7STmx7lOSc28wzZJtMgfCRS3yAvGoUe3gU+jDu9rRf4SDD/hSFed+klKV+DIZAIz1
	 yMvEDmRxO16kaDSSuvNiwGdxLTfWFjSmnqNGnTY9To5c6615cQGunRileww7iSDgnpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Myfeld2K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A61B606A333;
	Wed, 18 Nov 2026 20:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Myfeld2K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15ACC1F000C7;
	Wed, 18 Nov 2026 20:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795034281;
	bh=gFRMj142tR8+Qh+o/MwcGuA+ioSN7LcSeBCB6sdYTqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Myfeld2KJScSqy2uOHr+ml/BsO8RAP0t0+vWOCezuLoHct89QOa+MoQXXwBA6PtI1
	 d3YWS4sA9A/NasIAbkBqSh4z2BFgexH49FS3/H0TOUDpO8MSD2Xp3ZRhirxbL6eXmS
	 KiBuvjMFmqMEck3YfhVNh8GP9uPgBeGvJ73jpxnP520TSE8UYk2JvHziGab5VdTKlU
	 uO7KiJwC4Dp6cxjZsocPg9tbtDBDeR/Zn/yHenX5k3fodqCQihcdOs53CqdrAIRRpc
	 TlYOFK+oB6c2W7X38CSNUoJiH86WPflWzsSp6WcV2wQG1VPXOLbImJwm3DCrROyeFH
	 aiqQxB0gcXGuQ==
Message-ID: <sashiko-outbox-221940@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/16] sched/deadline: Reset the deadline and the
 runtime with the parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795031605.git.mathieu.desnoyers@efficios.com>
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795031605.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 20:38:00 +0000
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
  boost in switched_from_dl()
- [Medium] sched/deadline: uncanceled dl_timer in __dl_clear_params()
  unthrottles new period early
--

commit fd3c8e10959b630f111829811b626124918b2948
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Reset the deadline and the runtime with the parameters

This commit resets dl_se->deadline and dl_se->runtime in
__dl_clear_params() and in switched_from_dl() when a boosted task with no
parameters of its own leaves SCHED_DEADLINE, so that the next entry into
the class starts a new period.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 71b1c155c2424..d6d2657dcddd6 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

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
>  	/*
>  	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
>  	 * keep track of that on its cpuset (for correct bandwidth tracking).

[Severity: Medium]
Can a task still retain the donor's runtime and deadline after a PI
deboost if p->dl.dl_runtime is non-zero?

If a non-deadline task is PI-boosted by a SCHED_DEADLINE waiter and
sched_setattr() switches it to SCHED_DEADLINE while still boosted,
__sched_setscheduler() sees prev_class =3D=3D next_class =3D=3D &dl_sched_c=
lass
and skips switched_from_dl() and switched_to_dl().  __setparam_dl() sets
p->dl.dl_runtime to the task's new reservation without clearing the donor's
p->dl.deadline and p->dl.runtime (and if the task is sleeping, skipping
switched_to_dl() also misses add_rq_bw(), causing a later __sub_rq_bw()
underflow warning).  When rt_mutex_setprio() later deboosts the task, it
remains in dl_sched_class with the donor's future deadline, so
enqueue_dl_entity() skips setup_new_dl_entity() and the task runs on the
donor's remaining runtime.

Similarly, if a task that recently left SCHED_DEADLINE is PI-boosted
before its 0-lag inactive_timer expires, switched_to_dl() cancels
inactive_timer while p->dl.dl_runtime is still non-zero, and
replenish_dl_entity() overwrites p->dl.deadline and p->dl.runtime from the
donor.  On deboost, !p->dl.dl_runtime is false, so switched_from_dl()
leaves the donor's deadline and runtime in place and passes them to
task_non_contending().

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
If dl_se->dl_timer was armed before the task left SCHED_DEADLINE, can
leaving it queued in __dl_clear_params() unthrottle the task's new period
early?

If a task throttles (for example via sched_yield() while its 0-lag time is
still before the end of its period) and switches out of SCHED_DEADLINE,
dl_se->dl_timer remains armed for the old period's replenishment time.
When inactive_task_timer() fires at the 0-lag time, __dl_clear_params()
now resets dl_se->deadline, dl_se->runtime, and dl_se->dl_throttled so
that re-entering SCHED_DEADLINE starts a fresh period with a later
deadline, but dl_se->dl_timer is not canceled.  If the task re-enters
SCHED_DEADLINE and throttles in its new period before the old timer
expires, start_dl_timer() sees hrtimer_is_queued(&dl_se->dl_timer) and
does not reprogram it:

kernel/sched/deadline.c:start_dl_timer() {
	...
	if (!hrtimer_is_queued(timer)) {
		if (!dl_server(dl_se))
			get_task_struct(dl_task_of(dl_se));
		hrtimer_start(timer, act, HRTIMER_MODE_ABS_HARD);
	}
	return 1;
}

When the stale timer fires at the old period boundary, dl_task_timer()
replenishes and unthrottles the task before its new period ends.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795031605.gi=
t.mathieu.desnoyers@efficios.com?part=3D9
