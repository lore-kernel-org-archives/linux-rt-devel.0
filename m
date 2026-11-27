Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795797040;
	b=vNZHfHAgt7q3YUm2Ioubp6VRu9VQtcdvB76EGKmmhzLr6frPkzRlRi50H3ZvdB2wra54
	 0DFrhGieyH8jbfHsrI4Iv0BFBTMNeQCHPx0CB0FGqHEYAHS9VMdPBKgjKrZhn0IRjfTiw
	 CtZm/l8P6iMDPSf40KPY8MxjIUvIaDw1iImo2hOV34jgRefbk8h0si4Sd3lqZl3rA9UH5
	 VfH7MN8fRPGQlf0rt3eORp+ov5/QcHW2Tqsd557MFWrKe3oi0s5qOxBFxq8shbdWY55R0
	 EJ8sON5Nn+ZcaSGRiMvSschrnr0nl7UWAdybhMIDgopd8muwD/X8cdCYypSrlo2F2Iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795797040;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j4aRr+DSijQjnmPUjp3F7REYDXudlHrCOlvGGU/DyMg=;
	b=P1jrLGKIv/SAvQstc97B9rsZqTwo6hix0du9uTS1K+usRw+N2UjJMJd7h4DCByRURTZn
	 3AGoFXRc8owN+5iqO7+ahsUN3onrX4h71gzFE3DW/1Fje+UVHb9UyY9Rc9enMHPFOUznd
	 /VWstyDMq7AItX4xO6bvOkwZj7J8Y36xXaboyUwJlFScngvmpu7J8pr5fay4J8Uno8uBj
	 wPCTFlvVgbChkQygqd6dSfdW1M5OR7WJxVaDdljKoT9p05ICCAwQo1a1qU5O9CZOVFV3l
	 e9dgAirFErTB7vGpHero1ja5F4sLNFK31e6IR77hGoCzJy44BLquYGhUIBZWG7WEVKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2T8ppYO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9B606A31C;
	Fri, 27 Nov 2026 16:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X2T8ppYO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0437F1F0089B;
	Fri, 27 Nov 2026 16:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795797040;
	bh=j4aRr+DSijQjnmPUjp3F7REYDXudlHrCOlvGGU/DyMg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X2T8ppYOhj0ms5T1TwV4UuLesNWqQRsB1WsNSAXt3KoRZdpS6YVUjlihkd0eloPZ3
	 TMeBzCf1ohiJ3Rg2MK7lKJ8biGSjU6yeuzst1aW8On69Fvdh4QhZ7KVtTRJ0q984vG
	 PgpS2mdk+TeYbMAqMwlsdkHxWzM8oOrwzRY5AjYT0YXLBN995kxC9snt5y11y3pwor
	 Io8Z2lGVBz5r+AreParrQxieGPqdafkgVuAelC6mZCc64xP3afu3NlCsbF9RTFIaZQ
	 iOqusWLI/2Mf2tTbxGpQ/FyNy6dNGxFjxm36TqCgaozET8Yzb+F9ZOFvZRw2lOvY5E
	 /J5pirSd5tAqw==
Message-ID: <sashiko-outbox-237881@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 17/43] cgroup/cpuset: Refuse to take a deadline task
 out of its root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <63398d7537bc4e331e08c6c998fa1506430cac57.1795771148.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <63398d7537bc4e331e08c6c998fa1506430cac57.1795771148.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 16:30:39 +0000
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
- [Medium] cgroup/cpuset: stale def_root_domain span in
  dl_task_keeps_root_domain()
- [Medium] cgroup/cpuset: update_sibling_cpumasks() bypasses
  dl_tasks_keep_without()
- [Medium] cgroup/cpuset: missing dl_tasks_hold_bw() guard and subtree
  pruning in walks
--

commit c6b54021eb5d4c0abcdec9cdb08c630e44667111
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

cgroup/cpuset: Refuse to take a deadline task out of its root domain

This commit rejects cpuset CPU mask updates and invalidates partition roots
when the change would move a SCHED_DEADLINE task out of the root domain
that accounts for its bandwidth without performing admission control.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 9461277ed0fa3..62f0c7e6a97b0 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
[ ... ]
> @@ -1148,6 +1181,96 @@ static void effective_cpus_below(struct cpuset *cp=
, struct cpuset *from,
>  	}
>  }
> =20
> +/*
> + * A scratch mask for dl_tasks_keep_without(). Its callers still need ea=
ch
> + * mask of their struct tmpmasks after the call. Protected by
> + * cpuset_mutex.
> + */
> +static cpumask_var_t dl_keep_cpus, dl_pending_cpus;
> +
> +/*
> + * Return false if a partition that takes the CPUs of @xcpus makes a
> + * deadline task leave the root domain that counts its bandwidth. A cpus=
et
> + * can hold CPUs of two root domains: with isolcpus=3D"domain", or on cg=
roup
> + * v1 with sched_load_balance off. Such a task would run in a root domain
> + * that did not admit it.
> + *
> + * @root is the partition root that gives the CPUs. @part is the cpuset
> + * that takes them. In the same change, @part can give the CPUs of @gives
> + * back to @root. @gives is NULL if it gives none back.
> + *
> + * Work out the new CPUs of each cpuset of @root from the top down, as
> + * update_cpumasks_hier() does, down to the next partition roots. If
> + * @enable, @part becomes a partition root. Then do the same for its own
> + * cpusets, starting from the active CPUs of @xcpus.
> + */
> +static bool dl_tasks_keep_without(struct cpuset *root, struct cpuset *pa=
rt,
> +				  const struct cpumask *xcpus,
> +				  const struct cpumask *gives, bool enable)
> +{
> +	struct cpumask *new_cpus =3D dl_keep_cpus, *pending =3D NULL;
> +	struct cgroup_subsys_state *pos_css;
> +	struct cpuset *cp;
> +	bool keep =3D true;
> +
> +	lockdep_assert_cpuset_lock_held();
> +	/*
> +	 * The CPUs of @root can have changed before the rebuild of the
> +	 * sched domains, which ends the change. Then the root domain of a
> +	 * task of @root does not span them yet. The rebuild gives the CPUs
> +	 * of a root partition to one root domain. It gives those of an
> +	 * isolated partition, and of its valid children, to the default
> +	 * root domain.
> +	 */
> +	if (root->partition_root_state =3D=3D PRS_ROOT ||
> +	    root->partition_root_state =3D=3D PRS_ISOLATED) {
> +		pending =3D dl_pending_cpus;
> +		cpumask_copy(pending, root->effective_cpus);
> +		if (root =3D=3D &top_cpuset)
> +			cpumask_and(pending, pending,
> +				    housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
> +	}
> +	rcu_read_lock();
> +	cpuset_for_each_descendant_pre(cp, pos_css, root) {
> +		if (cp =3D=3D part || (cp !=3D root && is_partition_valid(cp))) {
> +			pos_css =3D css_rightmost_descendant(pos_css);
> +			continue;
> +		}
> +		/* The CPUs that @root has after the change. */
> +		cpumask_copy(new_cpus, root->effective_cpus);
> +		if (gives) {
> +			cpumask_or(new_cpus, new_cpus, gives);
> +			cpumask_and(new_cpus, new_cpus, cpu_active_mask);
> +		}
> +		cpumask_andnot(new_cpus, new_cpus, xcpus);
> +		effective_cpus_below(cp, root, new_cpus);
> +		if (cpumask_equal(cp->effective_cpus, new_cpus))
> +			continue;
> +		keep =3D dl_tasks_keep_cpus(cp, new_cpus, pending);

[Severity: Medium]
With isolcpus=3Ddomain, can a deadline task counted in def_root_domain bypa=
ss
this check when a PRS_ISOLATED partition returns a housekeeping CPU to
top_cpuset while taking a boot-isolated CPU?

Suppose an isolated partition holding housekeeping CPU 0 swaps its CPUs in
one write to take boot-isolated CPU 1 (xcpus =3D {1}, gives =3D {0}), and a
deadline task in top_cpuset is counted in def_root_domain on CPU 1.  Before
rebuild_sched_domains_locked() runs at the end of the write,
dl_task_bw_span(p) returns def_root_domain.span, which still contains CPU
0.  Because new_cpus includes gives ({0}), cpumask_intersects_and(span,
new_mask, user) in dl_task_keeps_root_domain() matches on CPU 0 and returns
true.  The rebuild then moves CPU 0 back to top_cpuset's housekeeping root
domain while CPU 1 remains in def_root_domain under the isolated partition,
migrating the deadline task and its bandwidth into the housekeeping root
domain without admission control.

> +		if (!keep)
> +			break;
> +	}
> +	if (keep && enable) {
> +		cpuset_for_each_descendant_pre(cp, pos_css, part) {
> +			if (cp !=3D part && is_partition_valid(cp)) {
> +				pos_css =3D css_rightmost_descendant(pos_css);
> +				continue;
> +			}
> +			cpumask_and(new_cpus, xcpus, cpu_active_mask);
> +			effective_cpus_below(cp, part, new_cpus);
> +			if (cpumask_equal(cp->effective_cpus, new_cpus))
> +				continue;
> +			keep =3D dl_tasks_keep_cpus(cp, new_cpus,
> +				root->partition_root_state =3D=3D PRS_ISOLATED ?
> +				pending : NULL);
> +			if (!keep)
> +				break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return keep;
> +}

[Severity: Medium]
Can update_sibling_cpumasks() cause dl_tasks_keep_without() to skip its
check when a growing parent partition has two invalid child partitions?

Suppose parent PRS_ROOT partition P has CPUs 0,2 and two PRS_INVALID_ROOT
children: C1 (cpus 0,2) and C2 (cpus 1, currently falling back to P's
effective_cpus 0,2 and holding 160% total deadline bandwidth admitted in
P's root domain).  When P grows to 0-3, update_cpumasks_hier() visits C1
first.  update_parent_effective_cpumask() validates C1 on 0,2 (while C2 is
still an invalid member of P, which passes via pending =3D {0-3}) and calls
update_sibling_cpumasks(P, C1, tmp).  That call runs
update_cpumasks_hier(C2, tmp, false), which treats C2 as a member because
cp =3D=3D cs, setting C2->effective_cpus and its tasks' cpus_mask to {1}:

kernel/cgroup/cpuset.c:update_cpumasks_hier() {
    ...
		if ((cp !=3D cs) && old_prs) {
			switch (parent->partition_root_state) {
			case PRS_ROOT:
			case PRS_ISOLATED:
				update_parent =3D true;
				break;
    ...
		spin_lock_irq(&callback_lock);
		cpumask_copy(cp->effective_cpus, tmp->new_cpus);
    ...
		cpuset_update_tasks_cpumask(cp, tmp->new_cpus);
    ...
}

When the outer update_cpumasks_hier(P, ...) loop then reaches C2 and calls
update_parent_effective_cpumask() -> dl_tasks_keep_without(P, C2, {1},
NULL, true), cpumask_equal(cp->effective_cpus, new_cpus) is already true
(and even inside dl_task_keeps_root_domain(), p->cpus_mask is already {1},
which no longer intersects P's pre-rebuild root domain span {0, 2}).  C2 is
then promoted to a valid 1-CPU PRS_ROOT partition holding 160% deadline
bandwidth.

[ ... ]

> @@ -2518,6 +2667,62 @@ static void partition_cpus_change(struct cpuset *c=
s, struct cpuset *trialcs,
>  	}
>  }
> =20
> +/*
> + * Set @new_cpus to the effective CPUs that @cp gets if @cs takes the CP=
Us
> + * of @trialcs. @cp is @cs or one of its descendants.
> + */
> +static void trial_effective_cpus(struct cpuset *cp, struct cpuset *cs,
> +				 struct cpuset *trialcs, struct cpumask *new_cpus)
> +{
> +	struct cpuset *parent =3D parent_cs(cs);
> +
> +	if (!cpumask_and(new_cpus, trialcs->cpus_allowed, parent->effective_cpu=
s) &&
> +	    is_in_v2_mode())
> +		cpumask_copy(new_cpus, parent->effective_cpus);
> +	effective_cpus_below(cp, cs, new_cpus);
> +}
> +
> +/*
> + * Return false if the CPUs of @trialcs make a deadline task of @cs, or =
of
> + * a descendant, leave the root domain that counts its bandwidth. A cpus=
et
> + * can hold CPUs of two root domains: with isolcpus=3D"domain", or on cg=
roup
> + * v1 with sched_load_balance off. The task would run in a root domain t=
hat
> + * did not admit it. Only a move to another cpuset can take the task
> + * there. The move asks the other root domain for room.
> + *
> + * A partition root takes its CPUs from its parent, which checks the same
> + * for its own tasks: see dl_tasks_keep_without().
> + */
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
> +		/*
> +		 * Test a mask that grows too. A task whose user affinity
> +		 * holds none of the old CPUs gets only the new ones.
> +		 */
> +		if (cpumask_equal(cp->effective_cpus, new_cpus))
> +			continue;
> +		keep =3D dl_tasks_keep_cpus(cp, new_cpus, NULL);
> +		if (!keep)
> +			break;
> +	}
> +	rcu_read_unlock();
> +	return keep;
> +}

[Severity: Medium]
Should dl_tasks_keep_root_domain() and dl_tasks_keep_without() check
!dl_tasks_hold_bw() before walking the hierarchy, and skip unchanged
subtrees with css_rightmost_descendant(pos_css)?

Because dl_tasks_hold_bw() is only checked inside dl_tasks_keep_cpus(),
every cpuset.cpus write and partition update walks the entire non-partition
subtree and runs effective_cpus_below() on every descendant even when no
deadline tasks exist or admission control is disabled.  In addition, when
cpumask_equal(cp->effective_cpus, new_cpus) is true in either function, a
plain continue still visits all of cp's descendants even though their
effective_cpus cannot change either.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D17
