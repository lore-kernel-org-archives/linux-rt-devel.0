Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911824;
	b=u9hBHLpE3kZXCT3CZ2AsBdHpPxqnQVlHLXVubbBL5MtjnfS68SGd+/WwDqtHRDevbowN
	 /7ls8WTRcBOelb/zFCD/jovYbk8oiXjlnXquzg16dkZ/lw924ES7LfnwBFWDtrgVYrUTS
	 7QfFD1Yx5Fl+XC9jlCuwyRJUR1Dp+a6VISVcZVzeGKxwoJZDIiyLJXi+VG42+nXdvmYJI
	 A68Hd1eF8t0HTDZ7EoQF5pSV5do4ANSK+31QLm+THtanuJBHG/fcqSavBZL25JoJTVVoH
	 tdY1BxyyLEpztpH3iwGI1D94+wj1iTBojz6LjfmX4L5lE5/mgpUjhyi2jDqRrbAADkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911824;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E0AqOfuTV7JeUiJbXm35NbgaWhBfAcNhkLGv4zW2+TY=;
	b=mhwXOd6eWD/iqjSDq7f9akw3kjbX+NmUpW+fGF7HQO5LRPZOLl0ohL4igtRZ39Y2VBSt
	 W4VvLkjzFie2mrFZbhv97UNAnD48hayH4kbtFAFpey9PNTYclYhRyacdd9kJoUvTJJyDT
	 YxAlWCrdGy0Fok3CthCi0lBAIzstLyrbA1RsyZK2ZP8d/i9cKCbNqCGTJcGrZnaGnhSXp
	 I2JrGzX64TTaqxsBBvyh0c4fCtrVU9m77I48EcDbiFqultC7/jx8f6rCLEyeF1L3kep+y
	 fIlBfDzEAB0Jn7se2wNnYokYMxfpyElGcvuAipcRbjfpNDP7+WVcC26urZl7YO+YmYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6uFer1m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8F606A32E;
	Thu,  5 Nov 2026 20:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6uFer1m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403C41F008A1;
	Thu,  5 Nov 2026 20:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793911823;
	bh=E0AqOfuTV7JeUiJbXm35NbgaWhBfAcNhkLGv4zW2+TY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G6uFer1mfyYH01zzknSHF17QKJY8qB1dr1mI372Ux3PlB3UtEmZa+w7PGtnMIY0Qq
	 9GQ7Rj5sGgOtFnJkdrKS8zvs3xReUe49TZ7JUWY5KItQMbfSrYJSBuAe3gOfq2oFUb
	 olT/MesHCiHa/mFfG7GTZdWhkwnkpTlkCl5C5U7tC2cnmMEIQEuHansO55B9Ory9U1
	 wE8tmKtGU0HdtPzG+NJnmx2Ohf7epcIBGY87DvVZ1jAuFCK4LHJEBizcF+RhXJBbYn
	 LxFsLcLSDL+NgKGI+UNCKxXNJVh8xFsJ0TeXDtimK/LjISbbZX2V4d8tNk40hTnEfr
	 5h8uYPPLLcAcg==
Message-ID: <sashiko-outbox-200155@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/24] sched/deadline: Record the root domain holding
 a task's bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261105193359.1450487-15-mathieu.desnoyers@efficios.com>
References: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
 <20261105193359.1450487-15-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:50:22 +0000
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
- [Medium] sched/deadline: stale task_rq() root domain check on sleeping mo=
ved tasks
- [Medium] sched/deadline: missing special and zero-bw checks in dl_task_ne=
eds_bw_move()
--

commit 529159218137dba9eec548b4daee830c808791a5
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Record the root domain holding a task's bandwidth

This commit records a CPU of the root domain holding a deadline task's
bandwidth in sched_dl_entity::dl_bw_cpu so that bandwidth updates,
migrations, and releases operate on the root domain that actually accounted
for the bandwidth.

Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-1-dd761f=
e005b4@redhat.com/

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d9bd01a1bac0e..6a9b9791ddad7 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -3474,17 +3499,30 @@ static void set_cpus_allowed_dl(struct task_struc=
t *p,
>  	 * domain (see cpuset_can_attach()).
>  	 */
>  	if (dl_task_needs_bw_move(p, ctx->new_mask)) {
> -		struct dl_bw *src_dl_b;
> +		unsigned int src_cpu =3D dl_task_root_domain_cpu(p);
> +		struct dl_bw *src_dl_b =3D &cpu_rq(src_cpu)->rd->dl_bw;
> +		unsigned int cpu;
> =20
> -		src_dl_b =3D dl_bw_of(cpu_of(rq));
>  		/*
>  		 * We now free resources of the root_domain we are migrating
>  		 * off. In the worst case, sched_setattr() may temporary fail
> -		 * until we complete the update.
> +		 * until we complete the update. A rebuild that dropped the
> +		 * bandwidth of @p leaves nothing to free.
> +		 */
> +		if (p->dl.dl_bw_gen =3D=3D dl_bw_gen) {
> +			raw_spin_lock(&src_dl_b->lock);
> +			__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(src_cpu));
> +			raw_spin_unlock(&src_dl_b->lock);
> +		}
> +
> +		/*
> +		 * The room in the root domain of the mask to come was made
> +		 * by cpuset_can_attach(): that one counts the bandwidth from
> +		 * here on.
>  		 */
> -		raw_spin_lock(&src_dl_b->lock);
> -		__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
> -		raw_spin_unlock(&src_dl_b->lock);
> +		cpu =3D cpumask_any_and(ctx->new_mask, cpu_active_mask);
> +		p->dl.dl_bw_cpu =3D cpu < nr_cpu_ids ? (int)cpu : -1;
> +		p->dl.dl_bw_gen =3D dl_bw_gen;
>  	}
> =20
>  	set_cpus_allowed_common(p, ctx);
> @@ -3493,10 +3531,13 @@ static void set_cpus_allowed_dl(struct task_struc=
t *p,
>  bool dl_task_needs_bw_move(struct task_struct *p,
>  			   const struct cpumask *new_mask)
>  {
> +	unsigned int cpu;
> +
>  	if (!dl_task(p))
>  		return false;
> =20
> -	return !cpumask_intersects(task_rq(p)->rd->span, new_mask);
> +	cpu =3D dl_task_root_domain_cpu(p);
> +	return !cpumask_intersects(cpu_rq(cpu)->rd->span, new_mask);
>  }

[Severity: Medium]
Should dl_task_needs_bw_move() also return false when
dl_entity_is_special(&p->dl) or !p->dl.dl_bw (or p->dl.dl_bw_cpu < 0)?

In include/linux/sched.h, dl_bw_cpu is documented as a CPU of the root
domain that counts dl_bw, and -1 where none does. Consistent with that,
dl_add_task_root_domain() checks:

    if (!dl_task(p) || dl_entity_is_special(&p->dl) || !p->dl.dl_bw)

so special entities and tasks boosted into the class via priority
inheritance with no bandwidth of their own do not get counted or given a
dl_bw_cpu record.

However, dl_task_needs_bw_move() only checks !dl_task(p), and
dl_task_root_domain_cpu(p) falls back to task_cpu(p) when dl_bw_cpu < 0.

Even with the follow-up commits "sched/deadline: Move a task's bandwidth
only where room was made" and "cgroup/cpuset: Give back the bandwidth an
attach did not move" applied, if a non-deadline task with p->dl.dl_bw =3D=
=3D 0
and p->dl.dl_bw_cpu =3D=3D -1 is priority-inheritance boosted into
dl_sched_class and moved across root domains via cpuset_can_attach() ->
cpuset_attach_task(), cpuset_attach_task() evaluates:

    dl_task(task) && dl_task_needs_bw_move(task, cs->effective_cpus) &&
    cs->sum_moved_dl_bw + task->dl.dl_bw <=3D cs->sum_migrate_dl_bw

as true (since 0 <=3D 0) and calls set_cpus_allowed_bw_reserved() ->
set_cpus_allowed_dl(), which sets a non-negative p->dl.dl_bw_cpu on the
0-bandwidth task.

When that task is later deboosted in switched_from_dl(), if dl_runtime =3D=
=3D 0,
dl_task_release_bw() is not called and the task returns to SCHED_NORMAL with
a stale non-negative dl_bw_cpu. If the task previously left SCHED_DEADLINE
while asleep past its 0-lag time (where switched_from_dl() called
dl_task_release_bw() and __dl_clear_state(), clearing dl_bw =3D 0 and
dl_bw_cpu =3D -1 while keeping dl_runtime > 0), deboosting it before its 0-=
lag
time causes dl_task_depart() to see dl_bw_cpu >=3D 0 and link the 0-bandwid=
th
task onto dl_departed_list.

Similarly, for a SCHED_FLAG_SUGOV kthread (where sched_dl_overflow() returns
0 early leaving dl_bw_cpu =3D -1 while __setparam_dl() sets dl_bw > 0, and
sugov_kthread_create() uses set_cpus_allowed_ptr() without PF_NO_SETAFFINITY
when policy->dvfs_possible_from_any_cpu is true), migrating the kthread
across root domains causes dl_task_needs_bw_move() to return true, charging
its uncounted dl_bw into root-domain total_bw accounting and setting
dl_bw_cpu >=3D 0.

> @@ -3568,7 +3609,11 @@ void dl_add_task_root_domain(struct task_struct *p)
>  	struct cpumask *msk;
> =20
>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
> -	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
> +	/*
> +	 * Nothing to count for a special entity, nor for a task boosted into
> +	 * the class with no bandwidth of its own, which gets no record.
> +	 */
> +	if (!dl_task(p) || dl_entity_is_special(&p->dl) || !p->dl.dl_bw) {
>  		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
>  		return;
>  	}
> @@ -3590,10 +3635,12 @@ void dl_add_task_root_domain(struct task_struct *=
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
>  	} else if (READ_ONCE(p->__state) =3D=3D TASK_DEAD) {
>  		/*
>  		 * Dead and not departed: its bandwidth was released at its
> @@ -3610,6 +3657,7 @@ void dl_add_task_root_domain(struct task_struct *p)
>  	raw_spin_lock(&dl_b->lock);
>  	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
>  	raw_spin_unlock(&dl_b->lock);
> +	p->dl.dl_bw_cpu =3D cpu;
>  	p->dl.dl_bw_gen =3D dl_bw_gen;
>  unlock:
>  	raw_spin_unlock(&dl_departed_lock);

[ ... ]

> @@ -3872,13 +3920,10 @@ static void switched_to_dl(struct rq *rq, struct =
task_struct *p)
>  	/*
>  	 * Boosted back into the class before its 0-lag time (a policy change
>  	 * released that bandwidth in sched_dl_overflow()): the inactive
> -	 * timer will not remove it, but its leaving the class again. That
> -	 * forgets the CPU recorded: moved to another root domain meanwhile,
> -	 * the task then removes the bandwidth from that one, as it did
> -	 * before departures were recorded.
> +	 * timer will not remove it, but its leaving the class again, from
> +	 * the root domain of the CPU recorded, which it keeps.
>  	 */
> -	if (p->dl.dl_departed_cpu >=3D 0)
> -		dl_task_undepart(p);
> +	dl_task_undepart(p);

[Severity: High]
As reported by Sashiko on v2 [1], can root domain bandwidth accounting be
corrupted during a rebuild when a departed task is boosted into
dl_sched_class via priority inheritance before its 0-lag time expires?

When a SCHED_DEADLINE task in root domain RD0 switches to SCHED_NORMAL
before its 0-lag time, switched_from_dl() arms inactive_timer and calls
dl_task_depart(p), linking p->dl.dl_departed_node onto dl_departed_list with
p->dl.dl_bw_cpu set to RD0's CPU and p->dl.dl_bw > 0.

If p is then boosted into dl_sched_class via priority inheritance
(rt_mutex_setprio() -> switched_to_dl()), switched_to_dl() cancels
inactive_timer and calls dl_task_undepart(p), which unlinks
p->dl.dl_departed_node from dl_departed_list while keeping p->dl.dl_bw_cpu
set to RD0's CPU.

If a root domain rebuild (dl_rebuild_rd_accounting()) runs while p is
PI-boosted, dl_clear_root_domains() does not restore p's bandwidth because p
is no longer on dl_departed_list, and in dl_add_task_root_domain(p),
!list_empty(&p->dl.dl_departed_node) is false. Doesn't this lead to three
issues:

1. If p was moved to another cpuset partition RD1 while in SCHED_NORMAL
   (where no deadline admission check or bandwidth reservation was performed
   because !dl_task(p)), neither dl_add_task_root_domain(p) here nor
   dl_task_rebuild_cpu(p) in the follow-up commit "sched/deadline: Credit a
   rebuild to the CPU recorded with the task's bandwidth" preserves
   p->dl.dl_bw_cpu (since RD0's CPU is not in RD1's effective cpumask).
   Instead, the rebuild adds p->dl.dl_bw to RD1 and overwrites
   p->dl.dl_bw_cpu with RD1's CPU.

2. If p's departing bandwidth was already dropped by an earlier rebuild
   (p->dl.dl_bw_gen < dl_bw_gen - 1 or p->dl.dl_bw_cpu went offline),
   dl_add_task_root_domain(p) lacks the dl_bw_gen =3D=3D dl_bw_gen - 1 and
   cpu_active(recorded) checks present in dl_clear_root_domains() and
   resurrects p->dl.dl_bw into p's effective cpuset.

3. Because rt_mutex_setprio() only holds p->pi_lock and rq->__lock (not
   cpuset_mutex or dl_accounting_mutex), p can be PI-boosted when
   dl_clear_root_domains() runs (so dl_clear_root_domains() misses it) and
   then deboost via rt_mutex_setprio() -> switched_from_dl() before
   dl_add_task_root_domain(p) inspects it. switched_from_dl() puts p back
   onto dl_departed_list after dl_clear_root_domains() has already finished,
   and dl_add_task_root_domain(p) skips p because !dl_task(p) is now true,
   dropping p's active 0-lag bandwidth from RD0.

[ ... ]

> @@ -4091,9 +4136,10 @@ int sched_dl_overflow(struct task_struct *p, int p=
olicy,
>  	u64 period =3D attr->sched_period ?: attr->sched_deadline;
>  	u64 runtime =3D attr->sched_runtime;
>  	u64 new_bw =3D dl_policy(policy) ? to_ratio(period, runtime) : 0;
> -	int cpus, err =3D -1, cpu =3D task_cpu(p);
> -	struct dl_bw *dl_b =3D dl_bw_of(cpu);
> +	int cpus, err =3D -1, cpu;
> +	struct dl_bw *dl_b;
>  	unsigned long cap;
> +	bool counted;
> =20
>  	if (attr->sched_flags & SCHED_FLAG_SUGOV)
>  		return 0;
> @@ -4102,6 +4148,19 @@ int sched_dl_overflow(struct task_struct *p, int p=
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
As reported by Sashiko on v2 [2], does updating a task's deadline parameters
or affinity while it is asleep after moving to a new cpuset partition still
check the stale task_rq(p) root domain in __sched_setscheduler() and
dl_task_check_affinity(), or fall back to the stale task_cpu(p) in
sched_dl_overflow() when counted is false?

When a task p sleeping on a CPU in cpuset partition A is moved via
cgroup.procs (cpuset_attach_task() -> set_cpus_allowed_ptr()) to a disjoint
cpuset partition B, affine_move_task() leaves task_cpu(p) and task_rq(p) on
partition A's CPU until wakeup, while set_cpus_allowed_common() updates
p->cpus_ptr to partition B's CPUs and (for a SCHED_DEADLINE task)
set_cpus_allowed_dl() moves its bandwidth to partition B and sets
p->dl.dl_bw_cpu to a CPU in partition B.

Although sched_dl_overflow() is updated here to use p->dl.dl_bw_cpu when
counted is true, its caller __sched_setscheduler() in
kernel/sched/syscalls.c still checks rq =3D task_rq(p) (in partition A):

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
cpumask_subset(span, p->cpus_ptr) fails and __sched_setscheduler() returns
-EPERM before reaching sched_dl_overflow().

Similarly, dl_task_check_affinity() in kernel/sched/syscalls.c checks:

    guard(rcu)();
    if (!cpumask_subset(task_rq(p)->rd->span, mask))
        return -EBUSY;

against the stale task_rq(p)->rd->span rather than the root domain of
dl_task_root_domain_cpu(p).

In addition, in sched_dl_overflow(), when counted is false (for example,
when a sleeping non-deadline task moved to partition B enters SCHED_DEADLINE
with dl_bandwidth_enabled() disabled or via sched_setattr_nocheck(), or
after a rebuild dropped its bandwidth), cpu =3D counted ? p->dl.dl_bw_cpu :
task_cpu(p) falls back to task_cpu(p) in partition A, crediting new_bw and
recording p->dl.dl_bw_cpu in partition A even though the task's cpuset and
p->cpus_ptr belong to partition B.

[1] https://lore.kernel.org/r/sashiko-outbox-198299@kernel.org
[2] https://lore.kernel.org/r/sashiko-outbox-198299@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105193359.1450=
487-1-mathieu.desnoyers@efficios.com?part=3D14
