Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209571;
	b=Y3d1HpzbCYxhWz1OblnIrcrUGP8BCvGZ/CzzNoRvZjH2wWRi9ODsPi9tZKa7KfGXwZmE
	 SzyIr5XDJNekljf9VmSScwfHhMfj03iqK7u4Kn4kfLdh2/j9Lwl2njpaURAOpa9cRi7ab
	 LHFSjqNoJEHQdz1TUqAs9qbAgkkbBsgjiv7zg4I9rujaaflLChirteVfCxMTW1nB2zbZH
	 xzOtElgjbqRcLeOdgF15HjAHz6wNn8+V2NA2IEmlzO9gG64duZ+uCNd4KpoMusrzrtc7C
	 DNBbG4usLr/DY5NmfhUepLil/PVNVLGlex+gVl8u291DMClTnEcs4xgrKJtCpnMROBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209571;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1xHaGKkiicl3LIsTMC3jXLV1vV7xvZPeqG90DVIgdO0=;
	b=17nxrFBdRMRfwCTZxRY3ROqxjmFgkYsd8QEFAYA3kp02Uzu/fjj+aVaJ3i4GK4D+/oK3
	 2BmDLkmQy7Zxwu0gvNMAAvJ1O0otxGsqRyTaVD1UkeGV3pZoXAfmGB/CzVE81AKhxuFAv
	 59AxFxb5hBjcHsVylE+hA3+nrGHE1rc9S+yjtgGqMCg255MLaTB0kiB/p3prSB9E2GIrL
	 qUoBwvGZLTqbjEVZqHV/8KVh8ajnqpxU2mb/dih9qK23w8fBte4XbLMesj80Lnx1QY4Js
	 QsmEIhFH+0vFGakNitX9rTu7bFs/hLIIK1lZ7zjxJHqcBrbhDYXo/sJGpzHUGtism6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1rRQf+H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672C606A694;
	Fri, 20 Nov 2026 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V1rRQf+H
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB6781F000C0;
	Fri, 20 Nov 2026 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209571;
	bh=1xHaGKkiicl3LIsTMC3jXLV1vV7xvZPeqG90DVIgdO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V1rRQf+Ht8OBPPgPIJvxKnI5BL9Yd3nXoVAFzQQGGhlZfishQC8Qdk4OmNlmgU9X3
	 aozb9kPv1mzkRTyhp41reB9L1CGo0na8T+84tOwjJcBpIJ925FOFuKJWqjyjfksxI8
	 BFvLfDalNdTGqq/iKoYM5FgSFWE4CCqUZAtehIDoLh0JtbUsqQJDgEZZx3y6t/jrYB
	 YYii4/iMwSTpFnA2SGxjZjb9Wy7gkHwhF7oXO3TygEU+FKOqmXcBzsW1cZ5EjSTSMU
	 vfZD9UyvAKiY3Z35G8aoXcHhUbDuTIE6MIWkSqZ6gRnnYV5iyRBD/HAbk1Il5aWDj4
	 HYISpxdvqxj4g==
Message-ID: <sashiko-outbox-226157@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 16/40] sched/deadline: Keep the last CPU a task has
 in its root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <efba6f58f1e0ef5cea319448374083b8149f26da.1795207232.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <efba6f58f1e0ef5cea319448374083b8149f26da.1795207232.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:19:30 +0000
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
- [Medium] cgroup/cpuset: partition_child_lost() picks last sibling
  after gone not first
- [Medium] cgroup/cpuset: upward cascade of gone across unpopulated
  parent partitions
- [Medium] cgroup/cpuset: missed root domain move for tasks in isolated
  partition gone
- [Medium] cgroup/cpuset: skipping a =3D=3D lost in
  cpuset_offline_moves_dl() ignores subpartitions
- [Medium] cgroup/cpuset: dl_task_in_cpuset() falsely matches
  SCHED_FLAG_SUGOV kthreads
--

commit 38c9a6cf11adbb513d6b034865c486d38c14c195
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep the last CPU a task has in its root domain

This commit refuses to take a CPU offline with -EBUSY when doing so would
leave a deadline task running in a different root domain that did not
admit its bandwidth, either because the task loses its last CPU in its
root domain or because the offline invalidates a cpuset partition.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7bdb9e21a7edb..e3c42c63844ba 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
[ ... ]
> @@ -4312,6 +4334,259 @@ void cpuset_cpus_allowed(struct task_struct *tsk,=
 struct cpumask *pmask)
>  	spin_unlock_irqrestore(&callback_lock, flags);
>  }
[ ... ]
> +static struct cpuset *partition_child_lost(struct cpuset *p, int cpu,
> +					   struct cpumask *new_cpus,
> +					   struct cpuset *gone)
> +{
> +	bool populated =3D partition_populated_offline(p);
> +	struct cgroup_subsys_state *css;
> +	struct cpuset *child, *lost =3D NULL;
> +
> +	cpumask_and(new_cpus, p->effective_xcpus, cpu_active_mask);
> +	cpumask_clear_cpu(cpu, new_cpus);
> +	if (cpumask_empty(new_cpus))
> +		return NULL;
> +	cpuset_for_each_child(child, css, p) {
> +		if (child =3D=3D gone) {
> +			populated =3D true;
> +			continue;
> +		}
> +		if (!is_partition_valid(child))
> +			continue;
> +		if (populated && cpumask_subset(new_cpus, child->effective_xcpus)) {
> +			lost =3D child;
> +			continue;
> +		}
> +		cpumask_andnot(new_cpus, new_cpus, child->effective_xcpus);
> +	}
> +	return lost;
> +}

[Severity: Medium]
When gone is set and p was initially unpopulated with no active CPUs of
its own, does partition_child_lost() pick the last valid sibling
partition after gone instead of the first?

During the pre-order walk in cpuset_handle_hotplug(), p is visited before
gone is invalidated, so p->effective_cpus remains empty.  Once gone is
visited and invalidated, p becomes populated while p->effective_cpus is
still empty.  When cpuset_hotplug_update_tasks() visits the first valid
sibling partition after gone, tasks_nocpu_error() checks
cpumask_subset(parent->effective_cpus, xcpus), which is immediately true
for an empty parent->effective_cpus:

kernel/cgroup/cpuset.c:tasks_nocpu_error() {
	return (cpumask_subset(parent->effective_cpus, xcpus) &&
		partition_is_populated(parent, cs)) ||
	       (!cpumask_intersects(xcpus, cpu_active_mask) &&
		partition_is_populated(cs, NULL));
}

That invalidates the first valid sibling partition after gone and gives
its active CPUs to p->effective_cpus, leaving later sibling partitions
valid.  Here, new_cpus still holds the union of all remaining children's
CPUs when visiting the first sibling after gone, so
cpumask_subset(new_cpus, child->effective_xcpus) is false until the last
valid sibling.  If p has two valid sibling partitions after gone where the
first holds a deadline task and the second does not,
cpuset_offline_moves_dl() and cpuset_cpus_allowed_without() inspect the
second sibling and accept the offline, merging the deadline tasks of gone
and the first sibling into p's root domain without admission control.

Also, if every active CPU in p->effective_xcpus belongs to child
partitions visited before gone, new_cpus becomes empty before gone, and
cpumask_subset(new_cpus, child->effective_xcpus) then matches a later
valid child partition whose effective_xcpus are all offline.

> +bool cpuset_cpus_allowed_without(struct task_struct *tsk, int cpu,
> +				 struct cpumask *pmask)
> +{
> +	const struct cpumask *possible =3D task_cpu_possible_mask(tsk);
> +	struct cpuset *cs =3D task_cs(tsk), *from, *gone =3D NULL;
> +
> +	guard(rcu)();
> +	if (!is_in_v2_mode()) {
[ ... ]
> +	} else {
> +		/*
> +		 * cgroup v2 works out the CPUs of each cpuset from the top
> +		 * down. A cpuset keeps those of its parent that cpuset.cpus
> +		 * holds, or takes all of them if there are none. Start from
> +		 * the nearest partition root that keeps an active CPU, or from
> +		 * the top cpuset. A partition root left with no CPU of its own
> +		 * can take those of a child partition. One left with tasks and
> +		 * no CPU becomes invalid, and its tasks count in its parent.
> +		 */
> +		for (from =3D cs; ; from =3D parent_cs(from)) {
> +			if (from !=3D &top_cpuset && !is_partition_valid(from))
> +				continue;
> +			cpumask_and(pmask, from->effective_cpus, cpu_active_mask);
> +			cpumask_clear_cpu(cpu, pmask);
> +			if (cpumask_empty(pmask) && from !=3D &top_cpuset &&
> +			    !partition_child_lost(from, cpu, pmask, gone))
> +				cpumask_clear(pmask);
> +			if (!cpumask_empty(pmask) || from =3D=3D &top_cpuset)
> +				break;
> +			gone =3D gone || partition_populated_offline(from) ? from : NULL;
> +		}
> +		effective_cpus_below(cs, from, pmask);
> +	}

[Severity: Medium]
Can gone cascade upward across an unpopulated parent partition here and
in cpuset_offline_moves_dl()?

Suppose an unpopulated partition P1 has no active CPUs of its own and
only one valid child partition P2, which is populated and loses its last
active CPU.  cpuset_handle_hotplug() walks descendants in pre-order and
visits P1 before P2; at that point P2 is still valid, so
partition_is_populated(P1, NULL) is false and P1 remains a valid
partition with empty effective_cpus when P2 is later invalidated.  With
gone || partition_populated_offline(from), once gone is set to P2, the
next iteration at P1 sets gone =3D P1 and climbs to parent_cs(P1) (or
top_cpuset), so cpuset_cpus_allowed_without() returns the ancestor's CPUs
instead of taking the empty-mask fallback path, and
cpuset_offline_moves_dl() checks sibling partitions of P1 that are not
invalidated.

> +	if (!cpumask_and(pmask, pmask, possible)) {
[ ... ]
> +static bool dl_task_in_cpuset(struct cpuset *cs)
> +{
> +	struct css_task_iter it;
> +	struct task_struct *task;
> +	bool found =3D false;
> +
> +	css_task_iter_start(&cs->css, 0, &it);
> +	while (!found && (task =3D css_task_iter_next(&it)))
> +		found =3D task->policy =3D=3D SCHED_DEADLINE &&
> +			READ_ONCE(task->__state) !=3D TASK_DEAD;
> +	css_task_iter_end(&it);
> +	return found;
> +}

[Severity: Medium]
Does dl_task_in_cpuset() match sugov kthreads in top_cpuset that do not
hold root-domain deadline bandwidth?

sugov_kthread_create() creates SCHED_DEADLINE kernel threads with
SCHED_FLAG_SUGOV in top_cpuset, which dl_se_holds_bw() excludes from
root-domain bandwidth accounting.  When the last active CPU of
top_cpuset goes offline while a partition exists and dl_nr_bw_tasks is
non-zero, cpuset_offline_moves_dl() sets lost =3D &top_cpuset and calls
dl_task_in_cpuset(&top_cpuset), refusing the offline with -EBUSY whenever
a sugov kthread is present.

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
> +		struct cpuset *gone =3D NULL;
> +
> +		/*
> +		 * A partition left with tasks and no CPU becomes invalid. Its
> +		 * tasks then count in its parent, which can take the CPUs of a
> +		 * later child partition. The parent is then the one that takes
> +		 * CPUs.
> +		 */
> +		while (!(lost =3D partition_child_lost(p, cpu, &dl_offline_cpus, gone)=
) &&
> +		       cpumask_empty(&dl_offline_cpus) &&
> +		       (gone || partition_populated_offline(p)) &&
> +		       parent_cs(p) !=3D &top_cpuset && is_partition_valid(parent_cs(p=
))) {
> +			gone =3D p;
> +			p =3D parent_cs(p);
> +		}
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

[Severity: Medium]
Can deadline tasks in gone change root domain undetected when gone is an
isolated partition and its parent p is a non-isolated partition?

Suppose p is PRS_ROOT with no active CPUs of its own and has two
PRS_ISOLATED child partitions: C1 on CPU 1 with deadline tasks (counted in
def_root_domain) and C2 on CPU 2 with no deadline tasks.  When CPU 1 goes
offline, C1 becomes gone and C2 becomes lost.  cpuset_offline_moves_dl()
only walks descendants of lost (C2) and finds no deadline tasks, while
dl_task_leaves_span() checks C1's tasks against the current
def_root_domain span, which still includes CPU 2 because C2 has not been
invalidated yet.  Both checks pass, and hotplug then invalidates C1 and
C2 into p, moving CPU 2 and C1's deadline tasks out of def_root_domain
into p's PRS_ROOT root domain without admission control.

> +		/* The partition that gives @cp its CPUs. */
> +		for (a =3D cp; a !=3D lost && !is_partition_valid(a); a =3D parent_cs(=
a))
> +			;
> +		if (lost !=3D &top_cpuset &&
> +		    ((a->partition_root_state =3D=3D PRS_ISOLATED &&
> +		      p->partition_root_state =3D=3D PRS_ISOLATED) ||
> +		     (a =3D=3D lost && a->partition_root_state !=3D PRS_ISOLATED &&
> +		      p->partition_root_state !=3D PRS_ISOLATED)))
> +			continue;

[Severity: Medium]
Does skipping a =3D=3D lost when neither lost nor p is PRS_ISOLATED hold wh=
en
lost has a valid child partition of its own?

When lost is invalidated, any valid child partition under lost is also
invalidated, so p's root domain takes all active CPUs of
lost->effective_xcpus rather than just lost->effective_cpus.  If lost had
effective_xcpus =3D {1, 2} and effective_cpus =3D {1} because a valid child
partition held CPU 2 (with no deadline tasks), a member cpuset under lost
configured with cpuset.cpus =3D 2 previously had an empty intersection with
lost->effective_cpus and inherited {1}, where its deadline task was
admitted.  Skipping a =3D=3D lost lets the offline of p's last CPU succeed,
and once p's effective_cpus becomes {1, 2}, the member cpuset's
effective_cpus switches from {1} to {2} (or a deadline task in lost
pinned to {1} no longer spans its {1, 2} root domain).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D16
