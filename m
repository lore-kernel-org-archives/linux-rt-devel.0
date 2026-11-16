Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858717;
	b=mvAXX3snGrA390Zpsyu+DroaRTg/CwNA+6R7NpxJ9LtdzkuS5YRvmltlMCkhJCOrdrlE
	 3Ras95rAUaqgXQMXJuBsynG1g7zlI38T3ia8NGRCe5sOA8/mIPBoKpK6hSeKfqWH1jl0y
	 yuHmq7djp0NNQ1GX4ovzXEv+Ynn0/qk9UmQjtro8WSFe/4nqGerh9OzmXs2K7sUq4qMk2
	 ogldkEN6rgR5CtXaI0jg51GZlpkJpkPRtgBBl7bUslBGCyqN+iVlNbv9y0gmfCBPrDA9q
	 xGu+HXWWckH5mikmHMwoAeBTSxZq7szXmgAcm3zaZDapdRgjYU3rLIYLbqmNTyc91wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858717;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6HgwmWYcONPNNtmHk0JhkhAXhnKsy7DAPueZvbln4CA=;
	b=e6Cic1aS5I2nAxEcWOaL7OOxFlw5f0UpZa356knMrS5mRFAWArKwMyYkG1ExeytYOvyC
	 zVE3lUGy0hRLBs6Kk/XjKfx4W38RLLpn2422JpeW5/Lm8pEYqd3MUJEDsb7pHV6Q0FlRt
	 h+IsVdilz26F5d5vgXzHhCwPbT2nydfta9JTBmZlo265Nz+sZC4bUl/b1ybNBE++bCRqi
	 daC8/eWa7nGRg5ojpx6HQFcWa3dAyObd6RMEGNTP0LUOu22/RqPGrYnRwWE7DAhgIFmmL
	 VkNvQ6b1G8yYisY0rYss6W2f8LJRLeDSqYz0ltht9SYW0ZKPqDmHDQtrlNUPvDOUYVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nICS7gFu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDE9606A31C;
	Mon, 16 Nov 2026 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nICS7gFu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513511F000C4;
	Mon, 16 Nov 2026 19:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858717;
	bh=6HgwmWYcONPNNtmHk0JhkhAXhnKsy7DAPueZvbln4CA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nICS7gFuX2HZtw7KUa7HCK58elmgltmAs2Yl73q9QW1Rty/aKd6OAuYrhiTJu/sjl
	 7OQprvkf37OZnPNld0NDYh2dmzuZdzLlNwbKhWmID9gv9d98+niIX/Cj3R3WVwb2TM
	 TcmLxjMmTE+A+/daiBHnj8XoactHzU3mVyrtEUAUmv3MbUTtCW3c9WBjNJfKYG0Em4
	 p4QCM1CD0T9SyIGELWLFPcTuBP0jl7mYpPN7ayzOba8X0i+Giw6NLVO8p2RDKYwyJZ
	 FDGtKnf17CPyMJKarBR6ZSP+q6r0a0d+g7wCModbvKxHIuOyH0hjU+zE4VdnfErVC9
	 zCwFB0WnbQNow==
Message-ID: <sashiko-outbox-217621@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 27/37] sched/deadline: Keep the last CPU a task has
 in its root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-28-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-28-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:51:56 +0000
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
- [Medium] sched/deadline: missing affinity masks in
  dl_task_leaves_span() fallback
- [Low] sched/deadline: dl_task_leaves_span() rejects CPU offline for
  dead tasks
--

commit 48b62790717c3a90940a59e814da93b5ddf9ada9
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep the last CPU a task has in its root domain

This commit refuses to take a CPU offline with -EBUSY when doing so would
leave a deadline task with runnable CPUs only outside the root domain that
accounts for its bandwidth.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 5294546786f12..096c0ec55cdc2 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -4896,9 +4896,63 @@ static int dl_bw_manage(enum dl_bw_request req, in=
t cpu, u64 dl_bw)
>  	return overflow ? -EBUSY : 0;
>  }
> =20
> +/*
> + * Return true if @p has CPUs to run on once @cpu is offline, but none in
> + * the root domain of @cpu, which counts its bandwidth.
> + */
> +static bool dl_task_leaves_span(struct task_struct *p, int cpu,
> +				const struct cpumask *span)
> +{
> +	struct cpumask *msk;
> +
> +	guard(raw_spinlock_irqsave)(&p->pi_lock);
> +	if (dl_task_bw_span(p) !=3D span)
> +		return false;
> +	msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
> +	cpumask_and(msk, p->cpus_ptr, cpu_active_mask);
> +	cpumask_clear_cpu(cpu, msk);
> +	/* With no CPU left, the cpuset gives @p the CPUs of an ancestor. */
> +	if (cpumask_empty(msk))
> +		cpuset_cpus_allowed_without(p, cpu, msk);
> +	return !cpumask_empty(msk) && !cpumask_intersects(msk, span);
> +}

[Severity: Medium]
When msk is empty and dl_task_leaves_span() falls back to
cpuset_cpus_allowed_without(), does it also need to restrict the inherited
ancestor mask by p->user_cpus_ptr (when their intersection is non-empty)
and task_cpu_possible_mask(p)?

When the CPU goes offline, cpuset_update_tasks_cpumask() updates the task
via __set_cpus_allowed_ptr(), which intersects the new cpuset mask with
p->user_cpus_ptr if they overlap:

kernel/sched/core.c:__set_cpus_allowed_ptr() {
    ...
	if (p->user_cpus_ptr &&
	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) =
&&
	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
		ctx->new_mask =3D rq->scratch_mask;
    ...
}

Suppose CPUs 0-1 are housekeeping CPUs in span and CPUs 2-3 are isolated
(isolcpus=3Ddomain,2,3), and a task with user_cpus_ptr =3D {0, 2, 3} is mov=
ed
into a child cpuset with cpuset.cpus =3D 0 under top_cpuset (0-3).  Taking
CPU 0 offline leaves msk empty, so cpuset_cpus_allowed_without() returns
{1, 2, 3} from top_cpuset.  Because dl_task_leaves_span() sees CPU 1 in
msk & span, it allows the offline, after which __set_cpus_allowed_ptr()
intersects {1, 2, 3} with user_cpus_ptr and restricts the task to {2, 3} in
the default root domain without an admission check.

In addition, the CONFIG_CPUSETS implementation of
cpuset_cpus_allowed_without() does not intersect cs->effective_cpus with
task_cpu_possible_mask(tsk), unlike guarantee_active_cpus() and the
!CONFIG_CPUSETS stub.

> +
> +/*
> + * Return true if @cpu is the last CPU that a deadline task can run on in
> + * the root domain that counts its bandwidth. With @cpu offline, the task
> + * would run in another root domain, which did not admit it. The mask of
> + * a task holds CPUs of two root domains only with isolcpus=3D"domain".
> + *
> + * A suspend takes the CPUs offline with the tasks frozen, and the resume
> + * puts them back. Without admission control, there is no limit to excee=
d.
> + * Return false in both cases.
> + */
> +static bool dl_cpu_last_of_task(int cpu)
> +{
> +	const struct cpumask *span;
> +	struct task_struct *g, *p;
> +
> +	if (cpuhp_tasks_frozen || !dl_bandwidth_enabled())
> +		return false;
> +	/* No task holds a bandwidth: do not walk the task list. */
> +	if (!atomic_read(&dl_nr_bw_tasks))
> +		return false;
> +	guard(rcu)();
> +	span =3D cpu_rq(cpu)->rd->span;
> +	for_each_process_thread(g, p) {
> +		if (task_has_dl_policy(p) && dl_task_leaves_span(p, cpu, span))
> +			return true;
> +	}

[Severity: Low]
Can this reject a CPU offline when p is an un-reaped exited task waiting for
its 0-lag timer?

When a deadline task exits before its 0-lag time, task_non_contending()
places it on dl_departed_list and arms inactive_timer while leaving
p->policy and p->dl.dl_bw_cpu set.  Until release_task() unhashes the task
or inactive_timer fires, for_each_process_thread() still visits it and
dl_task_leaves_span() returns true if the outgoing CPU was its only CPU in
span, causing dl_bw_deactivate() to fail with -EBUSY even though a
TASK_DEAD task will never run again or move its bandwidth to another root
domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D27
