Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121287;
	b=03R1/qw2ks3ZjE8Z669mjZN5zSz2K5m8uFZ05LA/Mcbimvy5B2m2EfJTUKbgRRPKa+sQ
	 SuXR/Utq6oAlSNuX26c3OQhdJ9mvw0D/FvQVBATVKUwK+UiVS9b5J/828a6vY/kOoIggF
	 S8y+Dc91G0Tpe0KL0cxEBlE7XPY5k65QjgboKgvy7xswm4urw5G1Zzbz1vsRnk4Jwh6Lo
	 ls2mrByjY+aY0okZKAqYkTi6ZFYAWtk94JmG5BK6oQQAcIP5kZnGVw2iiLrFT2rxTxxIf
	 JxS/CMi6rAg36wIHgs8EmfpIlDnXDa1CsnDBVDRg/0Wd3+Ui5QVrHfhPk2ZJItFEU6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121287;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LO8QnbAUXGyA2uTqsC7OqjLhIHLB4daZQzZsSF/AKTM=;
	b=bb7qa7DOIS1eogyN8d1x7OztCUTZtYaXxBTBaZSB4ObFK9iA0KODugsNiHAU2l43HBzk
	 vPLGS9QbPstNeYHedKBxAfeF7oZSPWv7q0rkkfqKaQHrXwC/02NAXEh0bVE1K8Pneh64X
	 7RZrRqQtlPFbcE2nRGLqAXoXD/UJWOJnO29AOomtt34M82LAfnPFdqLt3MK0gKKUkEPKJ
	 B7FmPGVyUKvwhUs6kHsrRtervV2Hvh1w5u/ZP1U9B0BFlkFwGBR14+Y9dMsaWU0XE/p8i
	 v9ange+vgDjf1eZDmDKSwbGZbxJjOC3lVmsEIzvUuExSJGj8Fpg+Mlh5MGhiPpcpDIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c/i6x6Ak";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232FA606CC6A;
	Thu, 19 Nov 2026 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c/i6x6Ak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C5F1F000CF;
	Thu, 19 Nov 2026 20:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121286;
	bh=LO8QnbAUXGyA2uTqsC7OqjLhIHLB4daZQzZsSF/AKTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c/i6x6AkCROfQenYLJJVH/BLyL7WG1hBwFr7oltGEf9/g04r8VGVBFJ850uKM9c+V
	 n/5r3o9T3Fb+k/FS9lJ/mk/TEnC7m11Na88r1hbELzmM658mSA2beIK9TZXlg/Jx8R
	 /L6rjnaVE/9GSjU5CQdPmlu5zCIEc4+Jn48rA2byDx6eNp7pU+9Hfac4UiI6zoQXaw
	 QdnMGWUlRnI/T1ancrbeoSQjCi7EnC5cyiGneQGrmEJmtFsrW5inrYaQ15Re5HBIyy
	 HEmXczSE2dK3Xxa78BUI+M+Pf++tPLng9gMp2GRyYXETotYPEeofQmeO/9cT9yEEYs
	 +Mr88z6Fn5s4w==
Message-ID: <sashiko-outbox-224050@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 16/33] sched/deadline: Keep the last CPU a task has
 in its root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <6e555ba3ad1013206d77ded129a127dadfd3b983.1795116791.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <6e555ba3ad1013206d77ded129a127dadfd3b983.1795116791.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:48:06 +0000
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
- [Medium] cgroup/cpuset: empty mask in cpuset_cpus_allowed_without() on
  top_cpuset loss
- [Medium] cgroup/cpuset: cpuset_cpus_allowed_without() walks past empty
  valid partition
- [Medium] sched/deadline: missed root domain move when offline
  invalidates PRS_ISOLATED
--

commit 6a0cfaf09c2412ad93623e8c7467bb4c5d10dd61
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep the last CPU a task has in its root domain

This commit refuses CPU offline in dl_bw_deactivate() with -EBUSY when
removing the CPU would leave a deadline task with runnable CPUs only
outside the root domain that admitted its bandwidth, or when invalidating
a cpuset partition would move a deadline task to another root domain.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7bdb9e21a7edb..5299652d47b6e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c

[ ... ]

> @@ -4312,6 +4334,234 @@ void cpuset_cpus_allowed(struct task_struct *tsk,=
 struct cpumask *pmask)

[ ... ]

> +bool cpuset_cpus_allowed_without(struct task_struct *tsk, int cpu,
> +				 struct cpumask *pmask)
> +{
> +	const struct cpumask *possible =3D task_cpu_possible_mask(tsk);
> +	struct cpuset *cs =3D task_cs(tsk), *from;
> +
> +	guard(rcu)();
> +	if (!is_in_v2_mode()) {
> +		/*
> +		 * cgroup v1 moves the tasks of a cpuset left with no CPU to
> +		 * the nearest ancestor that keeps one.
> +		 */
> +		for (from =3D cs; from; from =3D parent_cs(from)) {
> +			cpumask_and(pmask, from->effective_cpus, cpu_active_mask);
> +			cpumask_clear_cpu(cpu, pmask);
> +			if (cpumask_intersects(pmask, possible))
> +				break;
> +		}
> +	} else {
> +		/*
> +		 * cgroup v2 works out the CPUs of each cpuset from the top
> +		 * down. A cpuset keeps those of its parent that cpuset.cpus
> +		 * holds, or takes all of them if there are none. Start from
> +		 * the nearest partition root that keeps an active CPU, or from
> +		 * the top cpuset. A partition root left with no CPU of its own
> +		 * can take those of a child partition.
> +		 */
> +		for (from =3D cs; ; from =3D parent_cs(from)) {
> +			if (from !=3D &top_cpuset && !is_partition_valid(from))
> +				continue;
> +			cpumask_and(pmask, from->effective_cpus, cpu_active_mask);
> +			cpumask_clear_cpu(cpu, pmask);
> +			if (cpumask_empty(pmask) && from !=3D &top_cpuset &&
> +			    !partition_child_lost(from, cpu, pmask))
> +				cpumask_clear(pmask);

[Severity: Medium]
Does cpuset_cpus_allowed_without() leave pmask empty when from reaches
top_cpuset and @cpu was the last active CPU in top_cpuset.effective_cpus?

When top_cpuset has no active CPUs left outside subpartitions_cpus,
cpuset_handle_hotplug() clears subpartitions_cpus and reclaims all
remaining active CPUs into top_cpuset.effective_cpus:

kernel/cgroup/cpuset.c:cpuset_handle_hotplug() {
    ...
		if (!cpumask_empty(subpartitions_cpus)) {
			if (cpumask_subset(&new_cpus, subpartitions_cpus)) {
				cpumask_clear(subpartitions_cpus);
			} else {
				cpumask_andnot(&new_cpus, &new_cpus,
					       subpartitions_cpus);
			}
		}
		cpumask_copy(top_cpuset.effective_cpus, &new_cpus);
    ...
}

cpuset_offline_moves_dl() skips non-partition descendants whose enclosing
partition is top_cpuset (a =3D=3D &top_cpuset), leaving their deadline tasks
to dl_task_leaves_span().  Because pmask stays empty at top_cpuset here,
cpuset_cpus_allowed_without() skips effective_cpus_below() and
tsk->user_cpus_ptr filtering and returns false.  dl_task_leaves_span()
then takes the select_fallback_rq() branch and accepts the offline
whenever the task's current root domain has another active CPU (for
example, a boot-isolated CPU in def_root_domain), even if the CPUs
reclaimed from subpartitions_cpus put the task's cpuset in a different
root domain without admission control.

> +			if (!cpumask_empty(pmask) || from =3D=3D &top_cpuset)
> +				break;
> +		}
> +		effective_cpus_below(cs, from, pmask);

[Severity: Medium]
Can this loop walk past an unpopulated valid parent partition root that
stays valid with an empty effective_cpus mask during hotplug?

Suppose an unpopulated outer partition p_outer delegates all of its
active effective_xcpus to two child partitions: p_inner1 on @cpu (an
isolated partition sharing def_root_domain with a boot-isolated CPU in
top_cpuset) and p_inner2 on another active CPU.  During hotplug,
cpuset_handle_hotplug() visits descendants in pre-order: when it visits
p_outer, p_inner1 is still a valid partition root, so
partition_is_populated(p_outer, NULL) is false, p_inner2 is not
invalidated, and p_outer stays valid with an empty effective_cpus mask.
When cpuset_hotplug_update_tasks() next visits p_inner1, p_inner1 is
invalidated and inherits p_outer's empty effective_cpus mask.

Here, when from walks up from p_inner1 to p_outer, pmask is empty and
partition_child_lost(p_outer, cpu, pmask) returns NULL because
partition_populated_offline(p_outer) is false.  Instead of stopping at
p_outer with an empty mask, the loop continues up to top_cpuset and
returns true with top_cpuset's CPUs intersected with tsk->user_cpus_ptr.
If tsk->user_cpus_ptr restricts the task in p_inner1 to @cpu and the
boot-isolated CPU in top_cpuset, dl_task_leaves_span() sees the
boot-isolated CPU in msk and accepts the offline, whereas actual hotplug
gives p_inner1 an empty effective_cpus mask and dl_task_rebuild_cpu()
falls back to guarantee_active_cpus() (ignoring user_cpus_ptr) and moves
the task's bandwidth to a housekeeping CPU in top_cpuset.

[ ... ]

> +bool cpuset_offline_moves_dl(int cpu)
> +{
> +	struct cgroup_subsys_state *pos_css;
> +	struct cpuset *cp, *a, *p =3D &top_cpuset, *lost =3D NULL;
> +	bool found =3D false;
> +
> +	if (!is_in_v2_mode())
> +		return false;
> +	rcu_read_lock();
> +	cpuset_for_each_descendant_pre(cp, pos_css, &top_cpuset) {
> +		if (cp !=3D &top_cpuset && is_partition_valid(cp) &&
> +		    cpumask_test_cpu(cpu, cp->effective_cpus)) {
> +			p =3D cp;
> +			break;
> +		}
> +	}
> +	if (p !=3D &top_cpuset) {
> +		lost =3D partition_child_lost(p, cpu, &dl_offline_cpus);
> +	} else {
> +		cpumask_and(&dl_offline_cpus, top_cpuset.effective_cpus, cpu_active_ma=
sk);
> +		cpumask_clear_cpu(cpu, &dl_offline_cpus);
> +		if (cpumask_empty(&dl_offline_cpus) && !cpumask_empty(subpartitions_cp=
us))
> +			lost =3D &top_cpuset;
> +	}
> +	if (!lost) {
> +		rcu_read_unlock();
> +		return false;
> +	}
> +	cpuset_for_each_descendant_pre(cp, pos_css, lost) {
> +		if (cp =3D=3D &top_cpuset)
> +			continue;
> +		/* The partition that gives @cp its CPUs. */
> +		for (a =3D cp; a !=3D lost && !is_partition_valid(a); a =3D parent_cs(=
a))
> +			;
> +		if (a =3D=3D &top_cpuset ||
> +		    (a->partition_root_state =3D=3D PRS_ISOLATED &&
> +		     p->partition_root_state =3D=3D PRS_ISOLATED) ||
> +		    (a =3D=3D lost && a->partition_root_state !=3D PRS_ISOLATED &&
> +		     p->partition_root_state !=3D PRS_ISOLATED))
> +			continue;
> +		if (!css_tryget_online(&cp->css))
> +			continue;
> +		rcu_read_unlock();
> +		found =3D dl_task_in_cpuset(cp);
> +		rcu_read_lock();
> +		css_put(&cp->css);
> +		if (found)
> +			break;
> +	}
> +	rcu_read_unlock();
> +	return found;
> +}
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c33e73e920ebb..eead45a0c1191 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -5066,9 +5066,79 @@ static int dl_bw_manage(enum dl_bw_request req, in=
t cpu, u64 dl_bw)
>  	return overflow ? -EBUSY : 0;
>  }
> =20
> +/*
> + * Return true if @p has CPUs to run on once @cpu is offline, but none in
> + * the root domain of @cpu, which counts its bandwidth. A dead task runs=
 no
> + * more. It can wait for its 0-lag time, or for its parent to reap it.
> + * Return false for it.
> + */
> +static bool dl_task_leaves_span(struct task_struct *p, int cpu,
> +				const struct cpumask *span)
> +{
> +	struct cpumask *msk;
> +
> +	guard(raw_spinlock_irqsave)(&p->pi_lock);
> +	if (READ_ONCE(p->__state) =3D=3D TASK_DEAD || dl_task_bw_span(p) !=3D s=
pan)
> +		return false;
> +	msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
> +	/* A task in a migrate_disable() section has a cpus_ptr of one CPU. */
> +	cpumask_and(msk, &p->cpus_mask, cpu_active_mask);
> +	cpumask_clear_cpu(cpu, msk);
> +	/* With no CPU left, ask which CPUs the cpuset gives @p. */
> +	if (cpumask_empty(msk) && !cpuset_cpus_allowed_without(p, cpu, msk)) {
> +		/*
> +		 * select_fallback_rq() picks the CPU. It gives @p the CPUs of
> +		 * @span if one of them is active and @p can run on all of them.
> +		 */
> +		if (cpumask_any_and_but(span, cpu_active_mask, cpu) < nr_cpu_ids &&
> +		    cpumask_subset(span, task_cpu_possible_mask(p)))
> +			return false;
> +	}
> +	return !cpumask_empty(msk) && !cpumask_intersects(msk, span);
> +}

[Severity: Medium]
Can an offline that invalidates an isolated partition (PRS_ISOLATED) still
move a deadline task from def_root_domain to a housekeeping root domain
without being refused?

Suppose CPU 1 is isolated at boot via isolcpus=3Ddomain,1, while CPU 0 and
CPU 2 are in housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT).  top_cpuset has
effective_cpus =3D {1, 2}, and a child PRS_ISOLATED partition P has
effective_cpus =3D {0} with a deadline task recorded on CPU 0 and counted in
def_root_domain (whose pre-offline span is {0, 1}).  When CPU 0 is taken
offline:

1. cpuset_offline_moves_dl(0) finds p =3D P, calls partition_child_lost()
   which returns NULL because P has no active effective_xcpus left, and
   returns false.

2. dl_task_leaves_span() gets msk =3D {1, 2} from top_cpuset via
   cpuset_cpus_allowed_without(), sees that msk intersects the pre-offline
   span {0, 1} at CPU 1, and returns false.

3. Once CPU 0 is offline, P is invalidated into top_cpuset and the task
   gets cpus_mask =3D {1, 2}.  During dl_rebuild_rd_accounting(),
   dl_task_rebuild_cpu() matches the recorded CPU against
   housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT):

kernel/sched/deadline.c:dl_task_rebuild_cpu() {
    ...
	if (recorded >=3D 0) {
		const struct cpumask *hk =3D housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT);
		bool rec_hk =3D cpumask_test_cpu(recorded, hk);
		unsigned int same;
    ...
		for_each_cpu(same, msk) {
			if (cpumask_test_cpu(same, hk) =3D=3D rec_hk)
				return same;
		}
	}
    ...
}

Because CPU 0 was isolated by PRS_ISOLATED rather than at boot, rec_hk is
true, so dl_task_rebuild_cpu() picks housekeeping CPU 2 instead of
boot-isolated CPU 1 and moves the task's bandwidth into top_cpuset's
housekeeping root domain without admission control.

A similar move happens if top_cpuset holds only boot-isolated CPU 0 (with
a deadline task in top_cpuset) and an empty PRS_ISOLATED partition holds
housekeeping CPU 1: offlining CPU 0 invalidates the PRS_ISOLATED
partition so CPU 1 leaves def_root_domain to form top_cpuset's
housekeeping root domain, while dl_task_leaves_span() still tests against
the pre-offline def_root_domain span {0, 1}.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795116790.gi=
t.mathieu.desnoyers@efficios.com?part=3D16
