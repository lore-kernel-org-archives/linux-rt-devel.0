Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018907;
	b=BNK77/kpgta9VCOz0gwdRTfTjGeG4IZkqgFLRzjwa5gwcFB7R/k4CiejPiXoq5ehSOV7
	 qZD0xy7zHbZFDEDoTUCoFjiX7Am3HlYifkiN7+8P+fMyCkJkgeEvamSEKviHjsyPDUCvd
	 fiLKQ3pXkLYq0nftB2PMbdLYrFi8PqBlBJ/h6sz8qESheBdCyWXkaQjFAfiUXBs+W9ZOZ
	 32p0qWWTD1D8EBgWunu68DoCOEyI2LXj6KaXBJHtyj6bxmuUxoKfhKdcRADJkdy7GKd9r
	 uGdmXXo6OJqsrHEEbLOTDNEjWw3TU63w7IQn8Ebspi5N9ajU21y5oOsgn//9DbNCTXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018907;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sWTcDMCTygav0CaUS0RvarQmybynl/nwZfWcd7HfFJs=;
	b=AHC4bgJ9uD3GFvKXmK1e0xmSIUXhJCmCQdgbZ/62Mf17enEAd3QCeSozmVeWweOxBR5H
	 oKrdIpXG06lLxOo9J4s2Vd9AU10I+PcSu8GA1mA8LBYA0OvV1iBwKFW36NmETXgzyx1cM
	 O0Hfl2fqfQzodd/lCT76epdl9TUxQ0/VD42Q5rVLQ1Kw4jJtlMp8533OH7iQnTLlxsbSH
	 xbC8sIptbSIh8Z29Nkv3WOGkL5kGtkBAWvmJJuHb/E3bZvZXh3gZnx8kxIw64wcnOdtdo
	 muLWhx1NQN0J2b/hdgfqDeGY4UuFil8OKpC0Ri74gLAhUjW9opSwyNxkrLyxg7WyVCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jiU7p3eL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E232C606A32C;
	Sat,  7 Nov 2026 02:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jiU7p3eL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794881F008A1;
	Sat,  7 Nov 2026 02:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794018906;
	bh=sWTcDMCTygav0CaUS0RvarQmybynl/nwZfWcd7HfFJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jiU7p3eLu1rNlMN/bpwYmzplM+zWR70vfmKjGBQd7bTauh9O1Vpkh8oM1ggM4bFR4
	 q9uY6HL4uNuu7/4UDSSqVwE1FjBdkdRVPv4RmUu5PB7bmmMm0+oCf3AOH5hxjtJdLB
	 Z3QJ/zWIlmdcaWpmvdDAYwrB3pqkK0kPSaotV+gYxzH33JbWw78vsYlrG5M7OXrFoI
	 NSdfiKzRVBoFgdv/4mCFuf1C6D58Hu7F/TbmkyjhXe/3DhmMFYX/PQtmGBIrgpKJeU
	 N2JakB5F7YbyFxVzyPk6518inJXwneZNuPPMC/HeVJDWQ5+7gvsbJYyP11jUGKx89w
	 rpPEsuVsZuEdg==
Message-ID: <sashiko-outbox-202514@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/26] sched/deadline: Record the root domain holding
 a task's bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261107014451.1487825-17-mathieu.desnoyers@efficios.com>
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-17-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 02:35:06 +0000
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
- [Medium] sched/deadline: dl_task_undepart() loses departed state on PI
  boost
- [Medium] sched/deadline: stale dl_bw_cpu when dl_bw is zero misroutes
  bandwidth
--

commit 750b37778a0ba278821539fc3ca7bca85e0c4a0a
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Record the root domain holding a task's bandwidth

This commit records a CPU from the root domain accounting for a deadline
task's bandwidth in sched_dl_entity::dl_bw_cpu so that subsequent moves,
parameter updates, rebuilds, and releases operate on the root domain that
took the bandwidth.

Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-1-dd761f=
e005b4@redhat.com/

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 3f3de4b74a2dc..7a7101e6f7a03 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -3537,10 +3575,18 @@ static void set_cpus_allowed_dl(struct task_struc=
t *p,
>  bool dl_task_needs_bw_move(struct task_struct *p,
>  			   const struct cpumask *new_mask)
>  {
> -	if (!dl_task(p))
> +	unsigned int cpu;
> +
> +	/*
> +	 * Nothing to move for a special entity, nor for a task boosted into
> +	 * the class with no bandwidth of its own: neither is counted, as
> +	 * dl_add_task_root_domain() leaves them out.
> +	 */
> +	if (!dl_task(p) || dl_entity_is_special(&p->dl) || !p->dl.dl_bw)
>  		return false;
> =20
> -	return !cpumask_intersects(task_rq(p)->rd->span, new_mask);
> +	cpu =3D dl_task_root_domain_cpu(p);
> +	return !cpumask_intersects(cpu_rq(cpu)->rd->span, new_mask);
>  }
> =20
>  /* Assumes rq->lock is held */
> @@ -3614,8 +3660,9 @@ void dl_add_task_root_domain(struct task_struct *p)
>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>  	/*
>  	 * Nothing to count for a special entity, nor for a task with no
> -	 * bandwidth, such as an exited one whose bandwidth went with its
> -	 * parameters, which the walk of the task list finds too.
> +	 * bandwidth: an exited one whose bandwidth went with its
> +	 * parameters, which the walk of the task list finds too, and a task
> +	 * boosted into the class with none of its own, which gets no record.
>  	 */
>  	if (!dl_task(p) || dl_entity_is_special(&p->dl) || !p->dl.dl_bw) {
>  		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> @@ -3639,10 +3686,12 @@ void dl_add_task_root_domain(struct task_struct *=
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

[ ... ]

> @@ -3942,13 +3992,10 @@ static void switched_to_dl(struct rq *rq, struct =
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

[Severity: Medium]
When a task that left SCHED_DEADLINE before its 0-lag time is boosted back
into dl_sched_class via priority inheritance, does calling
dl_task_undepart(p) lose the fact that its bandwidth is departing?

Unlinking p->dl.dl_departed_node while !task_has_dl_policy(p) makes
list_empty(&p->dl.dl_departed_node) true while dl_task(p) and p->dl.dl_bw
are both non-zero.  If the task's affinity or cpuset changed to another
root domain after it left SCHED_DEADLINE, a root-domain rebuild in
dl_add_task_root_domain() will skip the !list_empty(&p->dl.dl_departed_node)
branch, charge the departing bandwidth to the new root domain that never
admitted it, and overwrite p->dl.dl_bw_cpu.

For the same reason, dl_task_needs_bw_move() checks !dl_task(p) rather
than !task_has_dl_policy(p), so migrating that PI-boosted task across
exclusive cpusets moves its departing bandwidth into the destination root
domain.  If a prior rebuild had already dropped the departing bandwidth,
dl_add_task_root_domain() also puts it back because it does not check
dl_bw_gen =3D=3D dl_bw_gen - 1 as dl_clear_root_domains() does.  And because
rt_mutex_setprio() does not serialize against dl_rebuild_rd_accounting(),
a departed task that is PI-boosted when dl_clear_root_domains() runs and
deboosted before the task-list walk reaches it is missed by both, dropping
its active 0-lag bandwidth from the root domain.

[ ... ]

> @@ -4155,9 +4202,10 @@ int sched_dl_overflow(struct task_struct *p, int p=
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
> @@ -4166,6 +4214,20 @@ int sched_dl_overflow(struct task_struct *p, int p=
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
> +	 * caller holds cpuset_mutex, or the lock of dl_accounting_lock()
> +	 * without cpusets, so no rebuild runs meanwhile.
> +	 */
> +	counted =3D task_has_dl_policy(p) && p->dl.dl_bw_cpu >=3D 0 &&
> +		  p->dl.dl_bw_gen =3D=3D dl_bw_gen;
> +	cpu =3D counted ? p->dl.dl_bw_cpu : task_cpu(p);
> +	dl_b =3D dl_bw_of(cpu);

[ ... ]

> @@ -4209,11 +4273,20 @@ int sched_dl_overflow(struct task_struct *p, int =
policy,
>  	 * run meanwhile: the caller holds cpuset_mutex, or the lock of
>  	 * dl_accounting_lock() without cpusets.
>  	 */
> -	if (!err && dl_policy(policy) && !task_has_dl_policy(p)) {
> -		lockdep_assert_cpuset_lock_held();
> -		lockdep_assert_dl_accounting_held();
> -		if (p->dl.dl_departed_cpu >=3D 0)
> -			dl_task_release_bw(p, -1);
> +	if (!err && dl_policy(policy)) {
> +		if (!task_has_dl_policy(p)) {
> +			lockdep_assert_cpuset_lock_held();
> +			lockdep_assert_dl_accounting_held();
> +			/*
> +			 * Whatever bandwidth the task still has counted
> +			 * somewhere, the new one replaces: on the departed
> +			 * list, or taken off it by a boost into the class
> +			 * (switched_to_dl()), the record says where.
> +			 */
> +			if (p->dl.dl_bw_cpu >=3D 0)
> +				dl_task_release_bw(p);
> +		}
> +		p->dl.dl_bw_cpu =3D cpu;
> +		p->dl.dl_bw_gen =3D dl_bw_gen;
>  	}

[Severity: Medium]
Can recording p->dl.dl_bw_cpu when new_bw is 0 cause a later sched_setattr()
to charge the task's bandwidth to a stale root domain?

__checkparam_dl() permits parameters where (runtime << BW_SHIFT) < period
(for example, runtime =3D 1024 ns and period =3D 2 s), for which to_ratio()
returns new_bw =3D=3D 0.  sched_dl_overflow() (and dl_task_offline_migratio=
n())
still sets p->dl.dl_bw_cpu to a CPU in the current root domain RD0.  If
the task is then moved to another exclusive cpuset partition RD1,
dl_task_needs_bw_move() returns false because !p->dl.dl_bw, leaving
p->dl.dl_bw_cpu pointing at RD0.  When the task runs in RD1 and calls
sched_setattr() with new_bw > 0, sched_dl_overflow() sees counted =3D=3D tr=
ue
and validates and adds new_bw to RD0's dl_bw instead of RD1's, bypassing
admission control in RD1.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107014451.1487=
825-1-mathieu.desnoyers@efficios.com?part=3D16
