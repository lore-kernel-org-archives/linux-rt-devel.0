Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793834293;
	b=rHpWlTftM5eUZi3GV39oyCfXH/VTx7nZiVZ+Nvlj4zItOR7vit/tqU+HmPQg6zCqrCQi
	 hfbpUHOtxJ6TGzieUZiT7mvtrGoAyuW2xejpRVHx0Mc/eu6InuVNbixfqXy0Atjj0mtq5
	 Gpq9Gdbojc1Zlx6TWoBV3u+WJGLWWbCi1FyilmG+B8itf0DqVCZLexSUNsk7n7g9AtNxr
	 VroUh3WfJ0yKB+GnbyCKd2J+N+TPvCd4wvUG5ATq/CnUPrrckH//DyzwAdjE2Qcwtsg2Y
	 VY06jlZZ3fguwnQ4odaGvm6x8HyhWVf9YSwJcs8CuFpi0RcjCvbG5X2rXh1Y/iqiWVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834293;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XACrs4pTXCils0EC/S2elwUQpJ60Uk3C828QQn96+Ao=;
	b=hXWmm9nDWhYZArzygHB3mAWRqwTRCJ6aqVHmq2ZplcJmjXrE4+sKijch7Vxo5zl4dMwx
	 LGY9Upxf+CqF6RnD8wIw4sO4tsINUYuDAgRakKyhUpiRm4WObIzUpU5Gt6rDWNr4dtbRa
	 Iy1SEvlCbBUJFHA0KfR9Jc3Hdxh+ELg+L8p7YL0PXhL+0g0XbZvxMuJkMXGFtt0cRdRh6
	 FF7YI/XbF/Q4K7xW3Q57dR+7QoJERRxaxx0rBTZuPlTZbWWfGOw0p9S2tnLEw6sWQ35B9
	 FVFH2Clqdt/KYrHLMTlsqurCqoh15ROtPDyz0As+phGo3mFFlL3QmL7+LW9yZ+c0Wsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bce0gb7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E11606A31B;
	Wed,  4 Nov 2026 23:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bce0gb7H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DB11F000C1;
	Wed,  4 Nov 2026 23:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793834293;
	bh=XACrs4pTXCils0EC/S2elwUQpJ60Uk3C828QQn96+Ao=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bce0gb7HzbjKd4nzNAX1dsOpQPOfBf8OrqWiQaffUJz4ChFETNrpcJO17+Qw2yQbI
	 0W8YofE0GTYOeJ+V/jHOfcgsKYvs4VcIUs/GOHrAGmJ83NYbI6U5rfw4H4/T+6A9kc
	 mNneopP3A4jepFMUmZMuQ7yzuPNuAEnqgRb2xlckx8rkUHJhj9NdI0JfuXCM81+LIa
	 mko4fZ9LqKgXXMqqTcTsv5lLCjXJJqPKca99BgJlumpYVdbGLYoQfzzoNz39wnD8D5
	 N0dJ4PU/qbugbm48Vp0RTu/PHiHmVxD1iN8Jkl8VDbxfC9oZvo6hUirZ5DOIIquCxT
	 +5tj2v8JoGaNw==
Message-ID: <sashiko-outbox-198288@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/21] sched/deadline: Rebuild the root domains'
 accounting without cpusets too
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261104211207.1392343-14-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-14-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:18:12 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] sched: lock inversion and leaked dl_accounting_mutex in __sched_se=
tscheduler()
- [High] sched/deadline: late dl_accounting_mutex lock in dl_rebuild_rd_acc=
ounting()
- [High] sched/deadline: dl_rebuild_rd_accounting() walks dead and zombie t=
asks
--

commit 9c6ff828105f0cf8abfab2f4dbfe02756a888bc8
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Rebuild the root domains' accounting without cpusets too

This commit implements dl_rebuild_rd_accounting() and dl_accounting_mutex f=
or
!CONFIG_CPUSETS kernels so that root domain SCHED_DEADLINE bandwidth
accounting is rebuilt across all tasks during CPU hotplug and suspend/resum=
e.

[ ... ]

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index cbcc00ea46d31..85df2b0044bed 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3685,6 +3685,53 @@ void dl_clear_root_domain(struct root_domain *rd)
>  		dl_server_add_bw(rd, i);
>  }
> =20
> +#ifndef CONFIG_CPUSETS
> +/*
> + * Where cpusets are built in, cpuset_mutex keeps an admission of bandwi=
dth
> + * from running against a rebuild of the accounting, and
> + * __sched_setscheduler() takes it for every change of or into
> + * SCHED_DEADLINE. Where they are not, cpuset_lock() is a stub and this
> + * takes its place.
> + */
> +static DEFINE_MUTEX(dl_accounting_mutex);
> +
> +void dl_accounting_lock(void)
> +{
> +	mutex_lock(&dl_accounting_mutex);
> +}
> +
> +void dl_accounting_unlock(void)
> +{
> +	mutex_unlock(&dl_accounting_mutex);
> +}
> +
> +void lockdep_assert_dl_accounting_held(void)
> +{
> +	lockdep_assert_held(&dl_accounting_mutex);
> +}
> +
> +/*
> + * Rebuild the root domains' accounting, where no cpuset holds the
> + * deadline tasks of each: they are found by walking them all, which
> + * dl_rebuild_rd_accounting() of the cpusets does per cpuset instead.
> + */
> +void dl_rebuild_rd_accounting(void)
> +{
> +	struct task_struct *g, *p;
> +
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&sched_domains_mutex);
> +
> +	guard(mutex)(&dl_accounting_mutex);
> +	dl_clear_root_domains();

[Severity: High]
As reported by Sashiko on v1 [1], is acquiring dl_accounting_mutex inside
dl_rebuild_rd_accounting() too late to serialize against
__sched_setscheduler() -> sched_dl_overflow()?

Under CONFIG_CPUSETS, rebuild_sched_domains_cpuslocked() and
cpuset_reset_sched_domains() acquire cpuset_mutex before calling
partition_sched_domains(), holding it across the entire execution of
partition_sched_domains_locked().

Under !CONFIG_CPUSETS, partition_sched_domains_locked() runs
detach_destroy_domains() and build_sched_domains() -> cpu_attach_domain() ->
rq_attach_root() before calling dl_rebuild_rd_accounting():

kernel/sched/topology.c:partition_sched_domains_locked() {
    ...
    detach_destroy_domains(doms_cur);
    ...
    build_sched_domains(doms_new[i], ...);
    ...
    update_sched_domain_debugfs();
    dl_rebuild_rd_accounting();
}

At that point, newly allocated root_domain instances (whose dl_bw.total_bw
only holds dl_server bandwidth and zero task bandwidth) are already attached
to cpu_rq(cpu)->rd, while dl_bw_gen has not yet been incremented by
dl_clear_root_domains().

If __sched_setscheduler() runs on another CPU during that window, it can
acquire dl_accounting_mutex before dl_rebuild_rd_accounting() is reached and
call sched_dl_overflow() against the unpopulated new root domain:

- A task entering SCHED_DEADLINE checks __dl_overflow() against a new
  root_domain with zero task bandwidth, allowing total_bw to be overcommitt=
ed
  once dl_rebuild_rd_accounting() runs and adds both existing tasks and the
  newly admitted task.

- A departed task re-entering SCHED_DEADLINE before its 0-lag time calls
  dl_task_release_bw(p, -1) in sched_dl_overflow(); because dl_bw_gen has n=
ot
  been incremented yet, dl_task_release_bw() sees dl_se->dl_bw_gen =3D=3D
  dl_bw_gen and subtracts dl_se->dl_bw from dl_bw_of(dl_departed_cpu),
  underflowing the newly attached root_domain's total_bw.

- An existing SCHED_DEADLINE task reducing its bandwidth calls
  __dl_overflow() and __dl_sub() on the unpopulated new root_domain, either
  failing with -EBUSY on unsigned wrap or underflowing total_bw.

Should dl_accounting_mutex be held across partition_sched_domains_locked()
(or acquired by its callers) just like cpuset_mutex?

> +
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, p)
> +		dl_add_task_root_domain(p);
> +	read_unlock(&tasklist_lock);
> +}

[Severity: High]
Can walking all tasks with for_each_process_thread() in
dl_rebuild_rd_accounting() corrupt rd->dl_bw.total_bw when encountering dyi=
ng
(TASK_DEAD) or unreaped zombie (EXIT_ZOMBIE) deadline tasks?

Unlike css_task_iter_next() in the CONFIG_CPUSETS implementation (which ski=
ps
dying tasks and exiting tasks with no live threads), for_each_process_threa=
d()
visits tasks in do_task_dead() as well as unreaped EXIT_ZOMBIE processes un=
til
they are reaped, while p->prio remains < MAX_DL_PRIO so dl_task(p) is true:

1. When a SCHED_DEADLINE task dies at or after its 0-lag time via
do_task_dead() -> __schedule() -> deactivate_task() -> dequeue_task_dl() ->
task_non_contending(), it runs under rq->__lock without holding p->pi_lock =
or
dl_accounting_mutex:

kernel/sched/deadline.c:task_non_contending() {
    ...
    if (!dl_task || READ_ONCE(p->__state) =3D=3D TASK_DEAD) {
        if (READ_ONCE(p->__state) =3D=3D TASK_DEAD)
            sub_rq_bw(dl_se, &rq->dl);
        dl_task_release_bw(p, task_cpu(p));
        __dl_clear_params(dl_se);
    }
    ...
}

If dl_rebuild_rd_accounting() runs on another CPU between
dl_task_release_bw() (which releases dl_departed_lock) and
__dl_clear_params() (which zeroes dl_se->dl_bw), dl_clear_root_domains()
increments dl_bw_gen and dl_add_task_root_domain(p) sees
p->dl.dl_bw_gen !=3D dl_bw_gen with a non-zero p->dl.dl_bw, adding the dying
task's bandwidth back to dl_b->total_bw where it is permanently leaked.

2. If a task dies before its 0-lag time on CPU X (entering dl_departed_list
with dl_departed_cpu =3D X and dl_bw_gen =3D G) and remains an unreaped
EXIT_ZOMBIE while CPU X goes offline (rebuild G + 1), both
dl_clear_root_domains() and dl_add_task_root_domain() skip it because
!cpu_active(X), dropping its bandwidth with p->dl.dl_bw_gen left at G. If C=
PU
X comes back online (rebuild G + 2) before inactive_task_timer() fires,
dl_clear_root_domains() skips the entry because dl_se->dl_bw_gen !=3D
dl_bw_gen - 1, but for_each_process_thread() then passes the zombie to
dl_add_task_root_domain(p), which checks only p->dl.dl_bw_gen =3D=3D dl_bw_=
gen
and cpu_active(cpu), adding the dropped bandwidth back.

[ ... ]

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 8eddb9d47d8e7..b1fc4fadd6899 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -559,6 +559,7 @@ int __sched_setscheduler(struct task_struct *p,
>  	if (dl_policy(policy) || dl_policy(p->policy)) {
>  		cpuset_locked =3D true;
>  		cpuset_lock();
> +		dl_accounting_lock();
>  	}
> =20
>  	/*
> @@ -650,8 +651,10 @@ int __sched_setscheduler(struct task_struct *p,
>  	if (unlikely(oldpolicy !=3D -1 && oldpolicy !=3D p->policy)) {
>  		policy =3D oldpolicy =3D -1;
>  		task_rq_unlock(rq, p, &rf);
> -		if (cpuset_locked)
> +		if (cpuset_locked) {
> +			dl_accounting_unlock();
> +			cpuset_unlock();
> +		}
>  		goto recheck;
>  	}
> =20
> @@ -740,8 +743,10 @@ int __sched_setscheduler(struct task_struct *p,
>  	task_rq_unlock(rq, p, &rf);
> =20
>  	if (pi) {
> -		if (cpuset_locked)
> +		if (cpuset_locked) {
> +			dl_accounting_unlock();
> +			cpuset_unlock();
> +		}
>  		rt_mutex_adjust_pi(p);
>  	}

[Severity: High]
What happens when normalize_rt_tasks() calls __sched_setscheduler(p, &attr,
false, false) on a SCHED_DEADLINE task while holding read_lock(&tasklist_lo=
ck)?

kernel/sched/core.c:normalize_rt_tasks() {
    read_lock(&tasklist_lock);
    for_each_process_thread(g, p) {
        ...
        if (!rt_or_dl_task(p))
            continue;
        ...
        __sched_setscheduler(p, &attr, false, false);
    }
    read_unlock(&tasklist_lock);
}

Because dl_policy(p->policy) is true, __sched_setscheduler() calls
dl_accounting_lock() without checking whether pi is true. On !CONFIG_CPUSETS
kernels (where cpuset_lock() was previously a no-op stub), acquiring
dl_accounting_mutex under read_lock(&tasklist_lock) sleeps in atomic context
and inverts the lock order relative to dl_rebuild_rd_accounting(), which
acquires dl_accounting_mutex before read_lock(&tasklist_lock).

In addition, on the normal return path of __sched_setscheduler(),
dl_accounting_unlock() and cpuset_unlock() are only called inside if (pi), =
so
calling __sched_setscheduler() with pi =3D=3D false returns 0 with
dl_accounting_mutex (and cpuset_mutex) still locked.

[1] https://lore.kernel.org/r/7ea39be6af23940c33a63002ea832838fe69bb9e.1793=
804635.git.mathieu.desnoyers@efficios.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104211207.1392=
343-1-mathieu.desnoyers@efficios.com?part=3D13
