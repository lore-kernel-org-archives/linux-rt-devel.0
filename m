Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165460;
	b=sRgsrGFl2425rMIBeGEOsowrhWVEwg/RVB/zvcwhZPjuuu/xH2I5GLTrizJnx3hGyYzt
	 G7xjq1tnxZIB69K4BlKQ+o3d8G4u0g2iFpZe3aHaYZD8pIWXQK5cGnGvB9LY7Uk1VLO7Q
	 l2Q8fyq2x9hCgm9+RFE5LG+Ab7yahX8cwqeoj6WwSW00Wu5m6876w64dyt99n2dJ+iVMM
	 sM8eA4n+Xt0ULJBsy/fbQXEOUm9PrByXiPFrI2KYhHSCTZBlLtGI570nZoMU6dgobXzxG
	 upMkwiqC/KEjKDQL0pzWhOCHXGENpkEwrvay86XAAhl+AysYTFJftfujIsLfe5FnvPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165460;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V2a36xghgUAXwOogjxhzBipfecgnEqN+y26p5P7ES0s=;
	b=1/3zx8K8KFHMx6Fg8ZVFfCQ2dCgWkABtQW/AvPlksHfqK3nW8h1UZHip7uSFHS/jrAkd
	 sR482reZiSt+m38qPoG6QWWD/Yiqkn1E3Q8DqPSEP+F29+pVgkF2vhwTbQBCtZEqgW1vj
	 Df+cGI8XodjuZkUmstW5ZBq6Pkymkr/FOZ03ZisMPIqWqius632nW/lmDIdEtZKzl0Xte
	 CfDdY926CJ8vAWWSFVVTgMwrVZWYCTn5ggKugWq1U/gf8wBrRVI+xeFZGxRu8UmlcrQdn
	 M0VLj9KayNE1hGStDY9IWEWVfnMZWaoPygc3O4mmvruM01Z8WVFpzWP6eYxLFGPD0ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9gjbYY3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556D606A31C;
	Sun,  8 Nov 2026 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9gjbYY3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829381F0089F;
	Sun,  8 Nov 2026 19:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165459;
	bh=V2a36xghgUAXwOogjxhzBipfecgnEqN+y26p5P7ES0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W9gjbYY3Zj36YHz8WbmLrb2AqYwOdUmqBs+DLjBb0FpOSJLGFCjTukhusR86XLkaM
	 a01BFLYPWf9Om1kjfiU721Mh1oO8iuetTU7eyEmGF60fnJ2tFREqkpUqW4dbhNpcuL
	 pzfWEPvuK/F5obV5U0LjHhQWvtEgxPS90fANc+hRkii2/g2DxO4efaXcl9fzXo5164
	 cb3MF/Ao7kEPbHJjTE2+nxIUE474oplvLSsz1u2ml+SyaepwasJfrgaQ5E2bOaTDS9
	 OGQcz0hRVjeRofBePgLUxabHenKJy3KM7Jk2EsQkpZ4P1O4R1atgkfg4MEu/cMpX9C
	 a+bt8TQfHSZxg==
Message-ID: <sashiko-outbox-203929@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/29] sched/deadline: Reset the donor's runtime at a
 deboost in the class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261108185406.1549770-11-mathieu.desnoyers@efficios.com>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-11-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:17:38 +0000
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
- [Medium] sched/deadline: donor runtime and deadline kept in
  dl_deboost() when <=3D dl_runtime
- [Medium] sched/deadline: lost PI boost in rt_mutex_setprio() after
  dl_deboost() resets deadline
- [Medium] sched/deadline: dl_deboost() leaves deadline =3D=3D 0 when task
  is not queued
--

commit cd4afb597a9d73fea8dc312f5eba35ea246cd6ce
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Reset the donor's runtime at a deboost in the class

This commit adds dl_deboost() to reset a deadline task's runtime and
deadline when a priority inheritance boost ends in the deadline class with
a remaining runtime larger than the task's own dl_runtime.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e4d299acb1fc4..bf722f5ff97e5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7898,7 +7898,7 @@ void rt_mutex_setprio(struct task_struct *p, struct=
 task_struct *pi_task)
>  				dl_boost(&p->dl, &pi->dl);
>  				scope->flags |=3D ENQUEUE_REPLENISH;
>  			} else {
> -				p->dl.dl_boosted =3D 0;
> +				dl_deboost(&p->dl);
>  			}
>  		} else if (rt_prio(prio)) {
>  			if (dl_prio(oldprio))

[Severity: Medium]
Can this drop a needed boost when a boosted deadline task transitions from
an earlier-deadline waiter W1 to a later-deadline waiter W2 whose deadline
is still earlier than the owner's own unboosted deadline?

rt_mutex_setprio() checks dl_time_before(pi->deadline, p->dl.deadline)
before calling dl_deboost(), so W2's deadline is compared against W1's
earlier deadline still stored in p->dl.deadline:

kernel/sched/core.c:rt_mutex_setprio() {
	if (dl_prio(prio)) {
		if (!dl_prio(p->normal_prio) ||
		    (pi_task && dl_prio(pi->prio) &&
		     (dl_entity_is_special(&pi_task->dl) ||
		      dl_time_before(pi->deadline, p->dl.deadline)))) {
			dl_boost(&p->dl, &pi->dl);
			scope->flags |=3D ENQUEUE_REPLENISH;
		} else {
			dl_deboost(&p->dl);
		}
}

Because W2's deadline is not before W1's deadline, rt_mutex_setprio()
calls dl_deboost(&p->dl), which zeroes p->dl.deadline when p->dl.runtime >
p->dl.dl_runtime.  On enqueue, setup_new_dl_entity() pushes p->dl.deadline
out to rq_clock(rq) + p->dl.dl_deadline, leaving p running unboosted with
a deadline later than W2's.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index cc43c5eeae51a..e6c55afcfd011 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -118,6 +118,22 @@ void dl_boost(struct sched_dl_entity *dl_se, const s=
truct sched_dl_params *param
>  	dl_se->pi_params =3D *params;
>  	dl_se->dl_boosted =3D 1;
>  }
> +
> +/*
> + * End the boost of @dl_se, a task that stays in the class. Its own
> + * reservation never gives it a runtime above dl_runtime. A larger runti=
me
> + * is what the donor left. In that case, reset the runtime and the
> + * deadline. The next enqueue then starts a new period. The caller holds
> + * the rq lock and the pi_lock of the task.
> + */
> +void dl_deboost(struct sched_dl_entity *dl_se)
> +{
> +	if (dl_se->dl_boosted && dl_se->runtime > (s64)dl_se->dl_runtime) {
> +		dl_se->deadline =3D 0;
> +		dl_se->runtime =3D 0;
> +	}
> +	dl_se->dl_boosted =3D 0;
> +}

[Severity: Medium]
Does keeping dl_se->runtime and dl_se->deadline when dl_se->runtime <=3D
(s64)dl_se->dl_runtime still allow the deboosted task to run the donor's
remaining runtime on top of its own runtime in one period?

On ENQUEUE_MOVE from rt_mutex_setprio(), enqueue_dl_entity() only calls
setup_new_dl_entity() if dl_se->deadline is in the past and does not check
dl_entity_overflow().  If a task (for example, dl_runtime =3D 10ms,
dl_period =3D 100ms) is deboosted when the donor has <=3D 10ms of runtime l=
eft
and an earlier deadline (say 20ms away), dl_deboost() preserves both the
remaining donor runtime and the donor's deadline.  Once the task consumes
that remaining runtime and throttles, start_dl_timer() arms the
replenishment timer at dl_next_period(dl_se):

kernel/sched/deadline.c:dl_next_period() {
	return dl_se->deadline - dl_se->dl_deadline + dl_se->dl_period;
}

For dl_deadline =3D=3D dl_period, that replenishment fires at the donor's
deadline rather than a full dl_period in the future, giving the task a new
full dl_runtime immediately and allowing up to nearly 2 * dl_runtime of
unboosted execution within a single dl_period.

[Severity: Medium]
What happens when dl_deboost() zeroes dl_se->deadline on a task that is
not queued on a runqueue?

When a boosted deadline task holding lock L1 is blocked on lock L2 and the
waiter on L1 aborts, rt_mutex_setprio() runs under sched_change, which
only calls enqueue_task() in sched_change_end() if ctx->queued is true.
Because the task is blocked on L2, it is not enqueued and p->dl.deadline
remains 0.  rt_mutex_adjust_prio_chain() then calls waiter_update_prio()
for the task's waiter on L2, copying task->dl.deadline (0) into
waiter->tree.deadline.  Since dl_time_before(0, d) is true for any
positive deadline d < 2^63, the deboosted task sorts ahead of real
deadline waiters on L2 and falsely boosts L2's owner with deadline 0, while
also preventing any new deadline waiter on L1 from boosting p while
p->dl.deadline is 0.

In addition, when the task is queued and has a constrained deadline
(dl_deadline < dl_period), enqueue_dl_entity() calls
dl_check_constrained_dl(dl_se) on dl_se->deadline =3D=3D 0 before reaching =
the
ENQUEUE_MOVE setup_new_dl_entity() call.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108185406.1549=
770-1-mathieu.desnoyers@efficios.com?part=3D10
