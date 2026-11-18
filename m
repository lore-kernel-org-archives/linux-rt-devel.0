Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033064;
	b=FfZ3NIBCA/AO75lRjD6MhCLEwSrR6a3jBXttBYjuhGPvzxbC0dO1oSpfg1fPDxxmsjWi
	 /k6cl+47H6vtrkcByINV+XIhj3eoVWGBYvTmKCCjDUBxnbPkEWKHOvpKpbHk62LvrX8BX
	 Bhn/uI1FBA+Ju/Vt389PgA0q7s2KVEvi9gxiUW7Zwtq+frR9+WR9O6GgdqJbMFRIRgNa0
	 lQSUyNKs5FR+FcaolnjcbDA2VD8fc0RJ/0Bk8YXWTv5bQPp17DS0Nv1jE9WQ5pe2e5uJE
	 f/cgTBk5jYNL5CDzE+llaEXvjMPEUUc/6mE3ts0wEUZEx3My4zl1YcJTmowVsJ5k66A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033064;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4w1sLbHtXNKQIDExclAzAeH6BlhvUXb49HGCBRm8AM4=;
	b=hil9/o872QskvL7qa9TCWNgbo0r8Ke08ftSQnHjX2znrBMTP5TqOS6jWEXdLOv6FiYJZ
	 2U10VXQ4ERF/z2RuieIGYb1/yN/UbLIb1dvSOCMtXiOFiQxXZRxiKBaa+vfomUUfKVAWB
	 7vxEEUo8O9K+embI2ociyUiQnBzvjsLOQ8prASogRnNUIMyEv102a0lSMlnaDZhq2MgfP
	 4WR4EfG6tBS4X/mU7yKFgQRrBDhmP3ApwIsp+h1Adgx6i8aZRBiVxgoc4gLYCold55csv
	 t54lFT2oeAv9zUGbcqPqcHGOsop59IWbrTwDxYVaFpMyqz6y48L2ky48uZW1scGIuuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d/OZsNj7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10437606A334;
	Wed, 18 Nov 2026 20:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/OZsNj7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0961F000C4;
	Wed, 18 Nov 2026 20:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033063;
	bh=4w1sLbHtXNKQIDExclAzAeH6BlhvUXb49HGCBRm8AM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d/OZsNj78xygzusxevCB7fBQ5VsT+YhWeEeYoMp1S9hmO5rPROIBT0eEvmySyqH30
	 K+UxeJClfBapD+oz0VY+h2QmSpdeobGonuaMMrn0TETkT8C0O1gRxDLQBRt8Gxh7PE
	 FpvgYdkGHqQTWVYJmW+x2gcd+n/6CMbaPm72MdN/r+lgAIc45naDDWgn/e60pyxSKJ
	 Ns9Ckz5tovrC/o00KvK+IX4ALyWR08ms+nOI5FMFUq8hg6mRUXveRzXDqOx/gVopZO
	 DuPHohGXGcR18TjdBY3bKTf3fkBb87AJnJMufolOCw2/Ub2sdNnbCVwMrI9PF1GRQb
	 HEmSj4mAfUoDA==
Message-ID: <sashiko-outbox-221922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/16] sched: Take cpuset_mutex for a deadline policy
 change only with pi
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <9194486f15bb0cb36b51e4525f471d1150c0d58b.1795031605.git.mathieu.desnoyers@efficios.com>
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <9194486f15bb0cb36b51e4525f471d1150c0d58b.1795031605.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 20:17:43 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] sched/deadline: bandwidth leak in __sched_setscheduler() on
  TASK_DEAD task [1]
--

commit eb6bc35bf21202354f98c206678837ac0c913d54
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched: Take cpuset_mutex for a deadline policy change only with pi

This commit avoids taking cpuset_mutex in __sched_setscheduler() when pi
is unset, and retries under the runqueue lock if the target task entered
SCHED_DEADLINE after the unlocked policy check.

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index cb115aa9b0b33..9b04e77297aeb 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -561,9 +561,11 @@ int __sched_setscheduler(struct task_struct *p,
> =20
>  	/*
>  	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
> -	 * information.
> +	 * information. Do not take cpuset_mutex when pi is unset: the
> +	 * caller is normalize_rt_tasks(), which holds tasklist_lock and
> +	 * cannot sleep.
>  	 */
> -	if (dl_policy(policy) || dl_policy(p->policy)) {
> +	if (pi && (dl_policy(policy) || dl_policy(p->policy))) {
>  		cpuset_locked =3D true;
>  		cpuset_lock();
>  	}
> @@ -643,7 +645,13 @@ int __sched_setscheduler(struct task_struct *p,
>  		}
>  	}
> =20
> -	/* Re-check policy now with rq lock held: */
> +	/*
> +	 * The caller gave no policy (SETPARAM_POLICY): the request was
> +	 * derived from an unlocked read of p->policy above. If the task
> +	 * changed policy since, re-derive the request from scratch, and
> +	 * release cpuset_mutex: the re-derived request re-decides whether
> +	 * it is needed.
> +	 */
>  	if (unlikely(oldpolicy !=3D -1 && oldpolicy !=3D p->policy)) {
>  		policy =3D oldpolicy =3D -1;
>  		task_rq_unlock(rq, p, &rf);
> @@ -654,6 +662,18 @@ int __sched_setscheduler(struct task_struct *p,
>  		goto recheck;
>  	}
> =20
> +	/*
> +	 * The caller gave an explicit policy, so the request needs no
> +	 * re-derivation (oldpolicy is -1 above). But the decision to
> +		 * take cpuset_mutex used the same unlocked read: the task
> +	 * entered SCHED_DEADLINE since, and the change below would take
> +	 * it out of the class. Retry to take the mutex.
> +	 */
> +	if (unlikely(pi && !cpuset_locked && task_has_dl_policy(p))) {
> +		task_rq_unlock(rq, p, &rf);
> +		goto recheck;
> +	}
> +
>  	oldprio =3D p->prio;
> =20
>  	newprio =3D __normal_prio(policy, attr->sched_priority, attr->sched_nic=
e);

[Severity: High]
This problem wasn't introduced by this patch, but can
__sched_setscheduler() leak deadline bandwidth and cpuset deadline task
counters if called on a zombie task [1]?

A task that has reached TASK_DEAD and been deactivated from its runqueue
remains reachable by PID until reaped.  If sched_setattr() sets
SCHED_DEADLINE on it, sched_dl_overflow() adds the requested bandwidth to
dl_b->total_bw and rq->dl.extra_bw, and switched_to_dl() increments
cs->nr_deadline_tasks via inc_dl_tasks_cs() and adds the bandwidth to
rq->dl.this_bw:

kernel/sched/deadline.c:switched_to_dl() {
	...
	inc_dl_tasks_cs(p);

	/* If p is not queued we will update its parameters at next wakeup. */
	if (!task_on_rq_queued(p)) {
		add_rq_bw(&p->dl, &rq->dl);

		return;
	}
	...
}

Because a TASK_DEAD task never wakes or runs again and release_task() does
not release deadline bandwidth or decrement cs->nr_deadline_tasks, the
bandwidth and cpuset task count are leaked until reboot, blocking cpuset
changes and eventually causing __dl_overflow() to reject all new
SCHED_DEADLINE admissions with -EBUSY.

[1] https://sashiko.dev/#/bug/linux-6b520332-dcc7-4d6b-b09a-5ec47df1d3cc

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795031605.gi=
t.mathieu.desnoyers@efficios.com?part=3D6
