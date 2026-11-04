Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793835103;
	b=1rI1cBR4XXir7/N3iXisqYNzhw6ZvRcm8NN3lG2QAG2WLePCyd1parziR8BM2YSOCxyr
	 1l/aMWe1TyQzYMsM+/BOnCOe4QO0iOpjR1ypRrUT3LDwZD15Jz5HQ8wZaSvFi1vX+2pJE
	 pKvpB+W4ai6YH34+9G/wm+uGP/bd9qBT3UNgf3l2XnxhthUkBxMYWTpIK9tzSaAbjFYt3
	 ul9ydpT8FnLjOAIfL3A+F84rqHfqNvMrHICbaWgkHyZNZywoX/eo/Le5J2nfFDFdhKZC3
	 U/zRnuh03CYlE3MAsuUZDlB6COc2l2DKRVd4+MSN5zEWic7jqtG7qHJ4Z8hgPQWSMDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793835103;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7Dj0Khh1eXzE1heKHSPxHmwPdgiFpustvZu53qRPwBA=;
	b=QuYZhZxSMu5yx+X9UwbzLCAZljceWrSIFgmC48pDeDAjHhWtWu0h5XuBHX/yHP/kcX/U
	 OAW54E45uWBRH4XmIEDEPEfgV0+a5y6z5URPdwhOW9eGw123BYV7HlbUvtNNXOzpmGUUl
	 2wFDaexmrONC0HKAeqtrBNkqgKeixVM8E8aeba/zfNx9yG2J55gRN/rhHFITY0uRZN+ye
	 HkwdMfrhxxrtnsMbnX4N3tdDqk81MVTyQeHdgZCgZJHmYign8S/5tvwzdICSUHRKy3MU5
	 UciF+ngVaidNASE2vJNLwKojtu4tkU04sj0mPOXNdvvXVhJ1HrDLdf+2w+i+TVxlyIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpsAau5b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3722B606A326;
	Wed,  4 Nov 2026 23:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpsAau5b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B09F1F000C1;
	Wed,  4 Nov 2026 23:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793835102;
	bh=7Dj0Khh1eXzE1heKHSPxHmwPdgiFpustvZu53qRPwBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XpsAau5b1Td/g6NY/qgvYXJDUOEzL0AXOZCvUK6KmqSFYzmZrueGzGbYI78NwmP+8
	 Z38btwteZq50/xHHRp8E4wbUYOt9MVghCzcHb37cgZYZsTwzkBE8nNWFsoKxrOoXrl
	 0o0YYEPLSd7dqdo9rRCu6axWcQpo3euZAgQALg+gxilNWIQf0NTkA1yXnfimMuKqXI
	 drVDDmUY/i/CVrLFdoM1HpMYYhSQVJCTH8FhNrUST61RWBBL9DVtw5/3U/d90XDxgZ
	 D0g13HCicVQqOnojT64keL00osW+LnJStZ9ATztabn1hXco2JDCFz+e0kq001iWwDV
	 vgkg3CiHdyKWg==
Message-ID: <sashiko-outbox-198299@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 15/21] sched/deadline: Record the root domain holding
 a task's bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261104211207.1392343-16-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-16-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:31:42 +0000
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
- [High] sched/deadline: broken rd rebuild for PI-boosted departed tasks
- [Medium] sched/deadline: stale task_cpu() root domain on sleeping moved t=
asks
- [Low] sched/deadline: stale comments in switched_to_dl() and dl_bw_cpu he=
lpers
--

commit 90cd336704a1119534fc7c444edd810ae1302642
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Record the root domain holding a task's bandwidth

This commit replaces dl_departed_cpu and cpumask-based root domain lookups
with a recorded dl_bw_cpu in struct sched_dl_entity so that deadline
bandwidth is released or moved from the same root domain where it was
accounted.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 85df2b0044bed..1dbde0fd199b4 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -252,15 +252,14 @@ static unsigned int dl_bw_gen;
>   * @p leaves SCHED_DEADLINE, or dies, its bandwidth kept for now in the =
root
>   * domain of @cpu. Under its rq lock.
>   */
> -static void dl_task_depart(struct task_struct *p, int cpu)
> +static void dl_task_depart(struct task_struct *p)
>  {
>  	struct sched_dl_entity *dl_se =3D &p->dl;
> =20
>  	lockdep_assert_irqs_disabled();
> -	if (dl_se->dl_departed_cpu >=3D 0)
> -		return;
>  	guard(raw_spinlock)(&dl_departed_lock);
> -	dl_se->dl_departed_cpu =3D cpu;
> +	if (!list_empty(&dl_se->dl_departed_node) || dl_se->dl_bw_cpu < 0)
> +		return;
>  	list_add(&dl_se->dl_departed_node, &dl_departed_list);
>  }
> =20
> @@ -273,9 +272,10 @@ static void dl_task_undepart(struct task_struct *p)
>  	struct sched_dl_entity *dl_se =3D &p->dl;
> =20
>  	lockdep_assert_irqs_disabled();
> +	if (list_empty(&dl_se->dl_departed_node))
> +		return;
>  	guard(raw_spinlock)(&dl_departed_lock);
> -	dl_se->dl_departed_cpu =3D -1;
> -	list_del(&dl_se->dl_departed_node);
> +	list_del_init(&dl_se->dl_departed_node);
>  }
> =20
>  /*
> @@ -284,24 +284,25 @@ static void dl_task_undepart(struct task_struct *p)
>   * when a rebuild of the accounting has dropped it; and no rebuild runni=
ng
>   * counts it again. Under @p's rq lock.
>   */
> -static void dl_task_release_bw(struct task_struct *p, int cpu)
> +static void dl_task_release_bw(struct task_struct *p)

[ ... ]

> @@ -3475,11 +3488,14 @@ static void task_woken_dl(struct rq *rq, struct t=
ask_struct *p)
>   */
>  static unsigned int dl_task_root_domain_cpu(struct task_struct *p)
>  {
> -	unsigned int cpu;
> +	int cpu =3D p->dl.dl_bw_cpu;
> =20
> -	cpu =3D cpumask_first_and(&p->cpus_mask, cpu_active_mask);
> -	if (cpu >=3D nr_cpu_ids)
> -		cpu =3D task_cpu(p);
> +	/*
> +	 * No bandwidth of @p's counted anywhere: nothing to take back or to
> +	 * move, and the CPU it is on answers for its root domain.
> +	 */
> +	if (cpu < 0)
> +		return task_cpu(p);
>  	return cpu;
>  }

[ ... ]

> @@ -3614,10 +3643,12 @@ void dl_add_task_root_domain(struct task_struct *=
p)
>  	 */
>  	if (p->dl.dl_bw_gen =3D=3D dl_bw_gen)
>  		goto unlock;
> -	if (p->dl.dl_departed_cpu >=3D 0) {
> -		cpu =3D p->dl.dl_departed_cpu;
> -		if (!cpu_active(cpu))
> +	if (!list_empty(&p->dl.dl_departed_node)) {
> +		int recorded =3D p->dl.dl_bw_cpu;
> +
> +		if (recorded < 0 || !cpu_active(recorded))
>  			goto unlock;
> +		cpu =3D recorded;
>  	}
>  	rq =3D cpu_rq(cpu);
>  	dl_b =3D &rq->rd->dl_bw;
> @@ -3625,6 +3656,7 @@ void dl_add_task_root_domain(struct task_struct *p)
>  	raw_spin_lock(&dl_b->lock);
>  	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
>  	raw_spin_unlock(&dl_b->lock);
> +	p->dl.dl_bw_cpu =3D cpu;
>  	p->dl.dl_bw_gen =3D dl_bw_gen;
>  unlock:
>  	raw_spin_unlock(&dl_departed_lock);

[Severity: High]
Can root domain bandwidth accounting be corrupted during a rebuild when a
departed task is boosted into dl_sched_class via priority inheritance before
its 0-lag time expires?

When a SCHED_DEADLINE task leaves the deadline policy before its 0-lag time,
switched_from_dl() arms inactive_timer and calls dl_task_depart(p) to link
p->dl.dl_departed_node onto dl_departed_list with p->dl.dl_bw_cpu recording
its root domain CPU. If p is then PI-boosted via rt_mutex_setprio() ->
switched_to_dl(), dl_task_undepart(p) unlinks p->dl.dl_departed_node while
preserving p->dl.dl_bw_cpu.

If dl_rebuild_rd_accounting() runs while p is PI-boosted,
dl_add_task_root_domain(p) sees list_empty(&p->dl.dl_departed_node) =3D=3D =
true:

1. If p was moved to another cpuset partition while in SCHED_NORMAL (where =
no
deadline admission check ran because !dl_task(p)), dl_add_task_root_domain(=
p)
ignores p->dl.dl_bw_cpu, adds p->dl.dl_bw to the new cpuset's root domain v=
ia
dl_get_task_effective_cpus(p), and overwrites p->dl.dl_bw_cpu with cpu. Or,
if an earlier rebuild had already dropped p's departing bandwidth, this path
resurrects p->dl.dl_bw into p's effective cpuset.

2. Because rt_mutex_setprio() only holds p->pi_lock and rq->__lock (not
cpuset_mutex or dl_accounting_mutex), p can be PI-boosted when
dl_clear_root_domains() runs (so it is not on dl_departed_list and is not
restored there) and then deboost via rt_mutex_setprio() -> switched_from_dl=
()
before the task walk reaches p. switched_from_dl() puts p back onto
dl_departed_list after dl_clear_root_domains() has already finished, and
dl_add_task_root_domain(p) skips p because !dl_task(p) is now true, dropping
p's active 0-lag bandwidth completely.

3. For a regular non-deadline task with p->dl.dl_bw =3D=3D 0 that is PI-boo=
sted
during a rebuild, dl_add_task_root_domain(p) unconditionally sets
p->dl.dl_bw_cpu =3D cpu, leaving a non-negative dl_bw_cpu on a task with ze=
ro
bandwidth after it deboosts.

Should a departed task stay on dl_departed_list across PI boost/deboost unt=
il
its bandwidth is actually released, and should dl_add_task_root_domain(p) s=
kip
tasks with p->dl.dl_bw =3D=3D 0?

[ ... ]

> @@ -3890,8 +3922,7 @@ static void switched_to_dl(struct rq *rq, struct ta=
sk_struct *p)
>  	 * the task then removes the bandwidth from that one, as it did
>  	 * before departures were recorded.
>  	 */
> -	if (p->dl.dl_departed_cpu >=3D 0)
> -		dl_task_undepart(p);
> +	dl_task_undepart(p);

[Severity: Low]
This isn't a bug, but several comments in kernel/sched/deadline.c were not
updated to match the new dl_bw_cpu behavior:

1. In switched_to_dl(), the comment right above dl_task_undepart(p) still s=
ays:

	 * Boosted back into the class before its 0-lag time (a policy change
	 * released that bandwidth in sched_dl_overflow()): the inactive
	 * timer will not remove it, but its leaving the class again. That
	 * forgets the CPU recorded: moved to another root domain meanwhile,
	 * the task then removes the bandwidth from that one, as it did
	 * before departures were recorded.

However, dl_task_undepart(p) now preserves p->dl.dl_bw_cpu instead of
forgetting it.

2. Above dl_task_root_domain_cpu(), the function comment still states that =
it
uses p's current cpus_mask to find the root domain and falls back when
cpus_mask has no active CPU:

 * Find the root domain where a DL task's bandwidth is currently
 * accounted. For a sleeping task that was moved between cpusets
 * without running, task_rq(p)->rd may be stale. Use the task's
 * current cpus_mask (not yet updated to the new mask) to find the
 * actual root domain. Use cpus_mask rather than cpus_ptr, which
 * may be temporarily narrowed by migrate_disable().

whereas dl_task_root_domain_cpu() now reads p->dl.dl_bw_cpu directly.

3. Above dl_task_depart() and dl_task_release_bw(), the comments still refer
to the @cpu parameter and departed-CPU fallback that were removed from both
functions.

Could these comments be updated to reflect the new dl_bw_cpu logic?

[ ... ]

> @@ -4115,6 +4147,19 @@ int sched_dl_overflow(struct task_struct *p, int p=
olicy,
>  	if (new_bw =3D=3D p->dl.dl_bw && task_has_dl_policy(p))
>  		return 0;
> =20
> +	/*
> +	 * The bandwidth of a task of the class is counted in the root
> +	 * domain that took it, which the CPU the task is on does not tell:
> +	 * moved asleep, it has not run there yet. Change it where it is
> +	 * counted; a rebuild that dropped it, and a task that enters the
> +	 * class, have the root domain of that CPU take the new one. The
> +	 * caller holds cpuset_mutex, so no rebuild runs meanwhile.
> +	 */
> +	counted =3D task_has_dl_policy(p) && p->dl.dl_bw_cpu >=3D 0 &&
> +		  p->dl.dl_bw_gen =3D=3D dl_bw_gen;
> +	cpu =3D counted ? p->dl.dl_bw_cpu : task_cpu(p);
> +	dl_b =3D dl_bw_of(cpu);

[Severity: Medium]
Does updating a task's deadline parameters while it is asleep after moving =
to
a new cpuset partition still use the stale task_cpu(p) root domain in
__sched_setscheduler() and sched_dl_overflow()?

When a task sleeping on a CPU in partition A is moved to a disjoint cpuset
partition B via cpuset_attach_task() -> set_cpus_allowed_ptr(),
affine_move_task() does not migrate the sleeping task's runqueue, so
task_cpu(p) remains in partition A while p->cpus_ptr and p->cpus_mask are
updated to partition B (and for a SCHED_DEADLINE task, set_cpus_allowed_dl()
updates p->dl.dl_bw_cpu to partition B).

If __sched_setscheduler() is then called on the still-sleeping task:

1. In kernel/sched/syscalls.c:__sched_setscheduler(), when
dl_bandwidth_enabled() is true, the affinity check before sched_dl_overflow=
()
still inspects rq->rd->span from task_rq(p) (partition A):

		if (dl_bandwidth_enabled() && dl_policy(policy) &&
				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
			cpumask_t *span =3D rq->rd->span;

			if (!cpumask_subset(span, p->cpus_ptr) ||
			    rq->rd->dl_bw.bw =3D=3D 0) {
				retval =3D -EPERM;
				goto unlock;
			}
		}

Because partition A's span is disjoint from p->cpus_ptr (partition B),
!cpumask_subset(span, p->cpus_ptr) triggers and __sched_setscheduler() fails
with -EPERM before reaching sched_dl_overflow().

2. In sched_dl_overflow(), when counted is false (for example, when a sleep=
ing
non-deadline task moved to partition B is switched to SCHED_DEADLINE while
still asleep, or when a prior rebuild dropped the task's bandwidth),
cpu =3D counted ? p->dl.dl_bw_cpu : task_cpu(p) falls back to task_cpu(p) in
partition A, crediting the bandwidth to partition A's root domain even thou=
gh
inc_dl_tasks_cs(p) and the task's wakeup place it in partition B.

Should __sched_setscheduler() and the uncounted path in sched_dl_overflow()
resolve the destination root domain from the task's effective cpuset or
allowed mask rather than task_cpu(p)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104211207.1392=
343-1-mathieu.desnoyers@efficios.com?part=3D15
