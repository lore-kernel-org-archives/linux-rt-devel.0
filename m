Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806215;
	b=JQ2Xh0LtpRTmhqxcHpDL4vJugUALJGGBD2cD7xuziE3461sza0+iTx/PCIVVIcmml8xI
	 wiYxteQcJerYx0lvSYM7S0YAF3XbHl/xEltDfPjhppePpnv2UAvS7VBojoF8GdFpXNMpy
	 0ZO0HCYXYZgvVtQAgms7bpBXm+0nrf4TuI5EmMlsz/ao9qFvLQ+GKoYLjS4pf+ZmCSE+Q
	 QEHfIzH+ySaIrdXuPA0GljCyuCJfS9JaNFZiaI/d6ALEI/s7b8rnxIvSQ1zNTFcG7wCC9
	 YmB0M1aetFGLriDr6iKaH94ldJVB+uijIjagpMGzl/GYs43zYiDgxqOQOWOiDiaWl4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iSyVaBgGFPBVvVXq9g4cBJYG7aBJRMGkfhjJiniL5fA=;
	b=Qqc+1Ow0lyBCMRYlr26jJkwsyeCia9TgxjiEreDe/GI0k52uB6KdTvS4G7iEJYMfBYIt
	 PMx1q7t7+2Fa14sGMJyRGLPF7cbvcLxU+y2m0mRuKgY22wsoAj3F+q/PMmyIrWJiJeoiD
	 GTpAbBMxG5yWZ1YUfX/voYR6q8ZLVTwb85CdEk6uZiwsNy2HVIP8vJWAAFlLoac97JtJg
	 1ElAW/EGZpjrLo+WVglUEH09BFAF9gDAwuhdojxef0TusM1JzI7jWY5fllIBE4a0czjhe
	 uIuko1Mz4n0xAQ3yRtpPwAMiM4Fi5JqCoSDbB6jRGEhHO5/MUEa5oujMeamyY504esQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cI2gU33w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05886606A32E;
	Wed,  4 Nov 2026 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cI2gU33w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2491F00919;
	Wed,  4 Nov 2026 15:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793806214;
	bh=iSyVaBgGFPBVvVXq9g4cBJYG7aBJRMGkfhjJiniL5fA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cI2gU33wJ5JVOFFhp3fYjlKxifJH4U+5XUvivtHn/mn9jBQ8eEAj/Hyr5k4sTNb69
	 +l/lO8MhJaJgc6JgFAiTc/P4dM5wVzaz7T/M26QWwSr5pjAoHJZkO0FX9VuKyAhVbx
	 W8xPc4TL6YdU3HN1jlMjWIvYLtGGCuO4EkYKnAgnljx284uYpV1Qm+NHVNYmwRIMTE
	 W+9+KiffnKtaUasAOIzY/atgZiV5wQwG1qVfvqmyfm0Aa0rVoN/GUtUWvKWehzZMqg
	 8ZE9ipqjaTci9D4IYbyBXAtk5GDHRlfzCycavznYensxQ94EmAZgxxDGmwCfV23PMn
	 L3yWE19adOwkA==
Message-ID: <sashiko-outbox-197505@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/12] sched: Reject SCHED_FLAG_KEEP_PARAMS before
 reserving deadline bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <fc36341b93c2e994ccec71a5ab6d5c8e76b3d73c.1793804635.git.mathieu.desnoyers@efficios.com>
References: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
 <fc36341b93c2e994ccec71a5ab6d5c8e76b3d73c.1793804635.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:30:13 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched: bandwidth leak in __sched_setscheduler() under SCHED_FLAG_K=
EEP_PARAMS
--

commit 7875cab1acc5b85b363d87da8587a9ad5e4642f8
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched: Reject SCHED_FLAG_KEEP_PARAMS before reserving deadline bandwidth

This commit moves the sched_dl_overflow() check and sched_reset_on_fork
update in __sched_setscheduler() after the SCHED_FLAG_KEEP_PARAMS class
change check so rejected requests do not leak deadline bandwidth.

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 3fa447aabe7fb..f0b7b2d52614f 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -655,17 +655,6 @@ int __sched_setscheduler(struct task_struct *p,
>  		goto recheck;
>  	}
> =20
> -	/*
> -	 * If setscheduling to SCHED_DEADLINE (or changing the parameters
> -	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
> -	 * is available.
> -	 */
> -	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, a=
ttr)) {
> -		retval =3D -EBUSY;
> -		goto unlock;
> -	}
> -
> -	p->sched_reset_on_fork =3D reset_on_fork;
>  	oldprio =3D p->prio;
> =20
>  	newprio =3D __normal_prio(policy, attr->sched_priority, attr->sched_nic=
e);
> @@ -699,6 +688,19 @@ int __sched_setscheduler(struct task_struct *p,
>  		queue_flags |=3D DEQUEUE_CLASS;
>  	}
> =20
> +	/*
> +	 * If setscheduling to SCHED_DEADLINE (or changing the parameters
> +	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
> +	 * is available. Last of the checks: nothing gives back the
> +	 * bandwidth it reserves.
> +	 */
> +	if ((dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, a=
ttr)) {
> +		retval =3D -EBUSY;
> +		goto unlock;
> +	}

[Severity: High]
Can __sched_setscheduler() in kernel/sched/syscalls.c still leak
dl_b->total_bw or corrupt rq->dl bandwidth accounting when
SCHED_FLAG_KEEP_PARAMS is set?

When attr->sched_flags & SCHED_FLAG_KEEP_PARAMS is set, the sched_change
block skips __setscheduler_params(p, attr):

kernel/sched/syscalls.c:__sched_setscheduler() {
	...
	scoped_guard (sched_change, p, queue_flags) {

		if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS)) {
			__setscheduler_params(p, attr);
			p->sched_class =3D next_class;
			p->prio =3D newprio;
			__setscheduler_dl_pi(newprio, policy, p, scope);
		}
		__setscheduler_uclamp(p, attr);
	...
}

Because __setscheduler_params() is skipped, neither p->policy nor
p->dl.dl_bw is updated. However, SCHED_FLAG_KEEP_PARAMS is only rejected
when prev_class !=3D next_class, and sched_dl_overflow(p, policy, attr) is
still called even when SCHED_FLAG_KEEP_PARAMS is set.

This allows sched_dl_overflow() to modify deadline bandwidth without
updating p->dl.dl_bw or p->policy in two paths:

1. If a non-deadline task (e.g. p->policy =3D=3D SCHED_NORMAL, so
!task_has_dl_policy(p) and p->dl.dl_bw =3D=3D 0) is PI-boosted by a
SCHED_DEADLINE waiter via rt_mutex_setprio(), p->sched_class is
&dl_sched_class while p->policy remains SCHED_NORMAL. Calling
sys_sched_setattr() with sched_policy =3D SCHED_DEADLINE and
SCHED_FLAG_KEEP_PARAMS populates attr.sched_runtime =3D p->se.slice via
get_params(). In __sched_setscheduler(), both prev_class and next_class
are &dl_sched_class, so the prev_class !=3D next_class check is bypassed.
sched_dl_overflow() then sees dl_policy(policy) && !task_has_dl_policy(p)
and adds new_bw to dl_b->total_bw via __dl_add(), while the
SCHED_FLAG_KEEP_PARAMS check skips __setscheduler_params(), leaving
p->policy as SCHED_NORMAL and p->dl.dl_bw as 0. When p deboosts, new_bw is
never subtracted from dl_b->total_bw.

2. In SYSCALL_DEFINE3(sched_setattr), get_params(p, &attr, 0) reads p's
deadline parameters without holding p->pi_lock or rq->__lock:

kernel/sched/syscalls.c:SYSCALL_DEFINE3(sched_setattr) {
	...
	if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
		get_params(p, &attr, 0);

	return sched_setattr(p, &attr);
}

If a concurrent sched_setattr() updates a SCHED_DEADLINE task's parameters
before __sched_setscheduler() acquires task_rq_lock(p, &rf), attr holds
stale parameters where new_bw !=3D p->dl.dl_bw while prev_class =3D=3D
next_class =3D=3D &dl_sched_class. sched_dl_overflow() then updates
dl_b->total_bw and calls dl_change_utilization(p, new_bw) to update
rq->dl.this_bw and rq->dl.running_bw to the stale new_bw, while
__setscheduler_params() is skipped, leaving p->dl.dl_bw out of sync with
dl_b->total_bw and rq->dl.

Should __sched_setscheduler() also reject SCHED_FLAG_KEEP_PARAMS when
policy !=3D p->policy, and skip sched_dl_overflow() when
SCHED_FLAG_KEEP_PARAMS is set?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793804635.gi=
t.mathieu.desnoyers@efficios.com?part=3D1
