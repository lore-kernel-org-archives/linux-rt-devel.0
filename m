Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859737;
	b=BfeYnHkbLQva4S8Lwjo2IEwZfMStRYipv0C0oRt7uLy64LfcW/9/H25ZkkHkuPVcNVNs
	 ht4ZuYbh1qL6RK/iibFPsvY9KPwb1vs4/5Mhs7NfaJV8WNlZIy41GfWf6+4ZvEB4yqtYo
	 NY1HYI/DorM3hu9agkYKfCOWT6AbiXl7aPewvATNY9syiinxay/gKQURYvxOPayJd0/t0
	 npCsWscQG94r9Z/M9N9qEH6CiKWecH3oKFCBGqccAmV6Z6MByt4obn0/OEYQj5gHIkVb9
	 ZTCBLJEq6Gv+1yp9pP/Xm4WrM84iHpb/uTjmtPh+VR+Y8O3GFjiklbLSyaUBObWw6Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859737;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r/Q2uX9NvdN9sYELwuEeVc162IpDQy4YQ6WZoTClWMg=;
	b=ymJ+ohjv8Bq5kR0e8CETk5Iuv70ISyM2H8pRKXeRh2LGGplfMTUkr0D59S2Lbeg65Fsq
	 SvgKML8oE6VOMAQwN8u+kThCoMVDWEDa7D5ecorDPOk8JpE0d1rlBTvG+1MG62pJBxOoI
	 C+x1iUHq4KrsmV6RNADW7PfiGqRS6rMjSpcaOKjNilhgZZXgWApzrXmWq3rxKqeg1MSBc
	 8Vw19SMhwtFVNPCifo8xSkOiL2D3sGFyLM+jqCxZH7Q+pzOmB9RIELRu5W4wn0R3ngN4K
	 KCkinLlg6ViP7aninolLb5mbLcn55qry0Oztn6aqEcrnuSP7jmpXYvhRjaaHdQuRx7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DgDuelW9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6DC606A31C;
	Mon, 16 Nov 2026 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DgDuelW9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6291F000C4;
	Mon, 16 Nov 2026 20:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859736;
	bh=r/Q2uX9NvdN9sYELwuEeVc162IpDQy4YQ6WZoTClWMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DgDuelW9T9ByQDMzzEWqFd8HxhtXAWBt1WQ9A/PYGVkhqOdgo1V2n7aHbiIH4Sedr
	 j1/3SKtQTIeuzbWKaTahdplfhLoTrjK7oytJGSJrHGfRFQ4OQfdnnIsdot9Q5viJq5
	 mSibKcmvBOFOL85F2fuE2PDg4B+9BasdEeUCSo84+P5AFQzhbglRQj1+2qHcd8ICox
	 vrWefYj/B0n6vlpyrBHSlOoJqKGBtj58+IE1MhtKM+/rxuTcA23Y1SuznTqTEheETO
	 Vztm3X+buBjPf7MoicTtW0rI81FCWJtaJrqSh74TwaUI36KImkBWsN16W59POk/reG
	 fAg9hGtSnd9pw==
Message-ID: <sashiko-outbox-217636@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 28/37] cgroup/cpuset: Refuse to take a deadline task
 out of its root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-29-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-29-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 20:08:55 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] cgroup/cpuset: excpus clobbered via tmp->new_cpus in
  remote_cpus_update()
- [High] cgroup/cpuset: partition_xcpus_del() called on invalid
  partition in update_parent_effective_cpumask()
- [Medium] cgroup/cpuset: wrong descendant effective_cpus in
  dl_tasks_keep_without()
- [Medium] sched/deadline: user_cpus_ptr ignored in
  dl_task_keeps_root_domain()
- [Medium] cgroup/cpuset: dl_tasks_keep_root_domain() skips invalidated
  partitions
--

commit 2c62aa35faa810e650ef3867961558c694f57e4c
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

cgroup/cpuset: Refuse to take a deadline task out of its root domain

This commit rejects cpuset CPU mask updates and invalidates partition roots
when the resulting effective CPUs would move a SCHED_DEADLINE task out of t=
he
root domain accounting its bandwidth without admission control.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index ef5ad8e38f06f..5b4f7d4ef3ae2 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
[ ... ]
> @@ -1126,6 +1127,92 @@ static void update_partition_sd_lb(struct cpuset *=
cs, int old_prs)
[ ... ]
> +static bool dl_tasks_keep_without(struct cpuset *root, struct cpuset *pa=
rt,
> +				  const struct cpumask *xcpus, bool enable,
> +				  struct cpumask *new_cpus)
> +{
> +	struct cgroup_subsys_state *pos_css;
> +	struct cpuset *cp, *a;
> +	bool keep =3D true;
> +
> +	rcu_read_lock();
> +	cpuset_for_each_descendant_pre(cp, pos_css, root) {
> +		if (cp =3D=3D part || (cp !=3D root && is_partition_valid(cp))) {
> +			pos_css =3D css_rightmost_descendant(pos_css);
> +			continue;
> +		}
> +		if (!cpumask_intersects(cp->effective_cpus, xcpus))
> +			continue;
> +		for (a =3D cp; ; a =3D parent_cs(a)) {
> +			if (cpumask_andnot(new_cpus, a->effective_cpus, xcpus) ||
> +			    a =3D=3D root)
> +				break;
> +		}
> +		keep =3D dl_tasks_keep_cpus(cp, new_cpus);
> +		if (!keep)
> +			break;
> +	}
> +	if (keep && enable) {
> +		cpuset_for_each_descendant_pre(cp, pos_css, part) {
> +			if (cp !=3D part && is_partition_valid(cp)) {
> +				pos_css =3D css_rightmost_descendant(pos_css);
> +				continue;
> +			}
> +			if (cpumask_subset(cp->effective_cpus, xcpus))
> +				continue;
> +			if (!cpumask_and(new_cpus, cp->effective_cpus, xcpus))
> +				cpumask_copy(new_cpus, xcpus);
> +			keep =3D dl_tasks_keep_cpus(cp, new_cpus);
> +			if (!keep)
> +				break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return keep;
> +}

[Severity: Medium]
Can dl_tasks_keep_without() miscompute new_cpus for descendant cpusets and
let a deadline task move to another root domain without admission control?

In the first loop, when cp loses all of its effective_cpus to xcpus and
inherits from an ancestor a above parent_cs(cp), new_cpus is set to
a->effective_cpus & ~xcpus without filtering top-down through the
cpus_allowed masks of the cpusets between a and cp as
compute_effective_cpumask() does. If root has effective_cpus {0, 1, 2}
(0-1 housekeeping, 2 isolated), child P has cpus_allowed {0}, and grandchild
C has cpus_allowed {2} (so C inherits effective_cpus {0}), a partition taki=
ng
xcpus {0} tests C against root's {1, 2} and sees housekeeping CPU 1, whereas
update_cpumasks_hier() gives P {1, 2} and gives C {2}, moving a deadline
task in C into the isolated root domain.

In the second loop (when enable is true), cp's new mask is derived from
cp->effective_cpus & xcpus instead of filtering xcpus & cpu_active_mask
top-down through each descendant's cpus_allowed. Because enabling part
switches its effective CPUs from cpus_allowed to effective_xcpus, a child C
whose cpus_allowed only intersects part->exclusive_cpus previously inherited
part->cpus_allowed, passes the cpumask_subset(cp->effective_cpus, xcpus)
check if part->cpus_allowed is a subset of xcpus, and then switches to
C->cpus_allowed once part is enabled; in addition, xcpus is not masked with
cpu_active_mask, so offline CPUs in xcpus can match def_root_domain->span.

[ ... ]

> @@ -1779,6 +1868,9 @@ static void remote_cpus_update(struct cpuset *cs, s=
truct cpumask *xcpus,
>  		else if (prstate_housekeeping_conflict(prs, PRS_ROOT,
>  						       excpus, tmp->delmask))
>  			WRITE_ONCE(cs->prs_err, PERR_HKEEPING);
> +		else if (!dl_tasks_keep_without(&top_cpuset, cs, tmp->addmask,
> +						false, tmp->new_cpus))
> +			WRITE_ONCE(cs->prs_err, PERR_DLTASK);
>  		if (cs->prs_err)
>  			goto invalidate;
>  	}

[Severity: High]
Does passing tmp->new_cpus to dl_tasks_keep_without() clobber excpus before
it is copied to cs->effective_xcpus?

update_cpumasks_hier() calls remote_cpus_update() with excpus pointing to
tmp->new_cpus:

kernel/cgroup/cpuset.c:update_cpumasks_hier() {
    ...
			compute_excpus(cp, tmp->new_cpus);
			...
			rcu_read_unlock();
			remote_cpus_update(cp, NULL, tmp->new_cpus, tmp);
			rcu_read_lock();
    ...
}

When a descendant remote partition gains exclusive CPUs during
update_cpumasks_hier(), dl_tasks_keep_without() overwrites tmp->new_cpus
with top_cpuset's remaining effective CPUs, and remote_cpus_update() then
copies that clobbered mask from excpus into cs->effective_xcpus.

[ ... ]

> @@ -2013,6 +2109,15 @@ static int update_parent_effective_cpumask(struct =
cpuset *cs, int cmd,
>  			deleting =3D false;
>  			adding =3D cpumask_and(tmp->addmask,
>  					     cs->effective_xcpus, parent->effective_xcpus);
> +		} else if (deleting &&
> +			   !dl_tasks_keep_without(parent, cs, tmp->delmask,
> +						  is_partition_invalid(cs),
> +						  tmp->new_cpus)) {
> +			/* As above: the partition becomes invalid. */
> +			part_error =3D PERR_DLTASK;
> +			deleting =3D false;
> +			adding =3D cpumask_and(tmp->addmask,
> +					     cs->effective_xcpus, parent->effective_xcpus);
>  		}
>  	} else {

[Severity: High]
Can setting adding here when is_partition_invalid(cs) is true call
partition_xcpus_del() on an already-invalid partition?

An invalid local partition root (old_prs < 0) with cpuset.cpus.exclusive set
keeps a non-empty cs->effective_xcpus even though those CPUs were not remov=
ed
from parent->effective_cpus. When updating cpuset.cpus or
cpuset.cpus.exclusive on that invalid partition takes the newmask branch and
dl_tasks_keep_without() returns false, adding becomes true while old_prs < =
0,
so partition_xcpus_del(old_prs, parent, tmp->addmask) triggers
WARN_ON_ONCE(old_prs < 0) and corrupts subpartitions_cpus, isolated_cpus, a=
nd
parent->effective_cpus by releasing CPUs that cs never held. Guarding adding
with is_partition_valid(cs) avoids releasing unowned CPUs.

[ ... ]

> @@ -2496,6 +2604,66 @@ static void partition_cpus_change(struct cpuset *c=
s, struct cpuset *trialcs,
[ ... ]
> +static bool dl_tasks_keep_root_domain(struct cpuset *cs, struct cpuset *=
trialcs,
> +				      struct cpumask *new_cpus)
> +{
> +	struct cgroup_subsys_state *pos_css;
> +	struct cpuset *cp;
> +	bool keep =3D true;
> +
> +	if (is_partition_valid(cs))
> +		return true;
> +	rcu_read_lock();
> +	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
> +		if (is_partition_valid(cp)) {
> +			pos_css =3D css_rightmost_descendant(pos_css);
> +			continue;
> +		}
> +		trial_effective_cpus(cp, cs, trialcs, new_cpus);
> +		if (cpumask_subset(cp->effective_cpus, new_cpus))
> +			continue;
> +		keep =3D dl_tasks_keep_cpus(cp, new_cpus);
> +		if (!keep)
> +			break;
> +	}
> +	rcu_read_unlock();
> +	return keep;
> +}
> +
>  /**
>   * update_cpumask - update the cpus_allowed mask of a cpuset and all tas=
ks in it
>   * @cs: the cpuset to consider
> @@ -2528,6 +2696,11 @@ static int update_cpumask(struct cpuset *cs, struc=
t cpuset *trialcs,
>  	if (alloc_tmpmasks(&tmp))
>  		return -ENOMEM;
> =20
> +	if (!dl_tasks_keep_root_domain(cs, trialcs, tmp.new_cpus)) {
> +		free_tmpmasks(&tmp);
> +		return -EBUSY;
> +	}
> +
>  	/*
>  	 * Check all the descendants in update_cpumasks_hier() if
>  	 * effective_xcpus is to be changed.

[Severity: Medium]
What happens when a write to cpuset.cpus (or cpuset.cpus.exclusive)
invalidates a valid partition root?

dl_tasks_keep_root_domain() runs before partition_cpus_change() and returns
true immediately when is_partition_valid(cs) is true, and
update_exclusive_cpumask() does not check dl_tasks_keep_root_domain() at al=
l.
If cs is a valid root partition on a housekeeping CPU containing a deadline
task and a user writes a boot-isolated CPU to cs/cpuset.cpus,
partition_cpus_change() invalidates cs (PERR_HKEEPING), and
update_cpumasks_hier() recomputes cs->effective_cpus as a non-partition
cpuset on the isolated CPU; dl_rebuild_rd_accounting() then adds the task's
bandwidth to def_root_domain via dl_add_task_root_domain() without admission
control.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 096c0ec55cdc2..61b50266468f9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -4955,6 +4955,25 @@ int dl_bw_deactivate(int cpu)
>  	return ret;
>  }
> =20
> +/*
> + * Return false if @p has CPUs in the root domain that counts its
> + * bandwidth and @new_mask holds none of them. A cpuset refuses such a
> + * mask: only a move to another cpuset makes room in another root domain.
> + */
> +bool dl_task_keeps_root_domain(struct task_struct *p,
> +			       const struct cpumask *new_mask)
> +{
> +	const struct cpumask *span;
> +
> +	if (!dl_bandwidth_enabled() || !task_has_dl_policy(p))
> +		return true;
> +	guard(raw_spinlock_irqsave)(&p->pi_lock);
> +	guard(rcu)();
> +	span =3D dl_task_bw_span(p);
> +	return !span || !cpumask_intersects(span, p->cpus_ptr) ||
> +	       cpumask_intersects(span, new_mask);
> +}

[Severity: Medium]
Should dl_task_keeps_root_domain() account for p->user_cpus_ptr the way
__set_cpus_allowed_ptr() and dl_task_bw_reserve_cpu() do?

When cpuset_update_tasks_cpumask() calls set_cpus_allowed_ptr(task, new_cpu=
s),
__set_cpus_allowed_ptr() restricts new_cpus to new_cpus & p->user_cpus_ptr
whenever their intersection is non-empty. Because dl_task_keeps_root_domain=
()
tests span against new_mask directly (and dl_tasks_keep_root_domain() and
dl_tasks_keep_without() skip cpusets where cpumask_subset(cp->effective_cpu=
s,
new_cpus) holds), a deadline task counted in housekeeping span {0, 1} whose
p->user_cpus_ptr only intersects new_mask on isolated CPU {2} passes this
check (or the subset check when widening effective_cpus from {0, 1} to
{0, 1, 2}) and has its affinity restricted to {2} in the isolated root doma=
in
without admission control. Intersecting new_mask with p->user_cpus_ptr when
cpumask_intersects(new_mask, p->user_cpus_ptr) is true and checking tasks e=
ven
when new_cpus grows would match __set_cpus_allowed_ptr().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D28
