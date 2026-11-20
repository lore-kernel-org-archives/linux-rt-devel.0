Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185104;
	b=vDEIS0WV2Z1OgU5L/ZTtsce1cYd3Y1lEE308M+yG8aXpRqHGMBudRbq/dwutHgcC81/q
	 iLo/P80us3upssk1D8JWht/jnFFuTEi4MVf4sVmo2zhAauWaZx5siLMUDAq7wu5RNefyp
	 xsY2LKThTRoQnZXjqYsIDi+/o7S/aTDWoiPDgjjf5pgFu9U11l5riRtcO00fGWIPs8XSZ
	 fg3OopCzVZYRORpzRJNE+ip/PRaiZ5DLkgIIAvdy1xhSzMNKrLeuPPJ/TZtt4LltdJviC
	 SJsmaLeLHfv25pC+x6ivBCha31QzsUpcb4spPAuSt9K9/Sl1SfC+mKN3zY9ArZyJ7Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185104;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oFJE/I7RDzIm+F/bNgkmoK9nSAcpSc0RkgmAThy76cI=;
	b=euDtePizRBSOV3yDyiMf6H+tlFhKNPRiYE3umArGXXoBP+FKMMFX9dvS1ez/ua5Q9aPF
	 nIxRXfRlw5nlqgz74sHMNpEg+GhdJfW1npiCpz2PcfHQGulyV3nN+n+eiVMGsVfZT1G/Y
	 Uiua0iH7TQOg440t8vjc/VWGKpUajHLRa6MlFeAgfoJrHJOzxkq0LlVuBdy//VQqQ8Y4+
	 BpPjV+0FkpADw5JyskD3Tmjvx/Brh+o5ASTCsU+qcYNx4z0GnMy0CKwcC5KQXen0FHeGe
	 wVNKxbNghw8r57MyMtVqUKkDXLb6SRei+DDIDqJB0rRBU7NNf3UGerEq4ZE6+Pne/GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F/yC5r9R";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F5F606A320;
	Fri, 20 Nov 2026 14:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F/yC5r9R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CC61F000CA;
	Fri, 20 Nov 2026 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795185104;
	bh=oFJE/I7RDzIm+F/bNgkmoK9nSAcpSc0RkgmAThy76cI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F/yC5r9RO9u9IgFOf4eufxyeIauS2ONJYHo1MQ5O+Yaoyyc+jccMHXYnDML1pphQf
	 ZD1N2dVompTFiSZ6LiVaf9V34l5VkhRK5+/CD5yFq5tLtCUU4aT4KG89H+TQ25ptCq
	 Tuwy+x4Va5wmI65k/a/viXA0LpvIpmGgKSyUC63+8t1G9cLrGVPeROS9GikEb+OnjR
	 UTNof+MurjzVAc66jOJ7WmFdJgpH8b6SP0u3zFJKf/2xCaKPavo+aehktqjMZtDOUA
	 IJJ3VFQkl6yVzEy3Iw5Evt4/rkayENobcRanSgGNpIcV6A7qIZ9tJmHruGib2TKUiG
	 eAEdFasNsC8ZQ==
Message-ID: <sashiko-outbox-225376@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 16/33] sched/deadline: Keep the last CPU a task has
 in its root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <05ebb23f175aca8ebb3b93eeb2621f07a0a352a5.1795181240.git.mathieu.desnoyers@efficios.com>
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <05ebb23f175aca8ebb3b93eeb2621f07a0a352a5.1795181240.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:31:43 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] cgroup/cpuset: cpuset_offline_moves_dl() misses empty parent
  partition
--

commit a61be9d5e1d2e372e16191df4de9a790c2bf73c9
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep the last CPU a task has in its root domain

This commit refuses to take a CPU offline when doing so would leave a
deadline task with no runnable CPU in its admitting root domain, or when
invalidating a cpuset partition would move a deadline task into another
root domain.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7bdb9e21a7edb..ef95c730853e0 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c

[ ... ]

> @@ -4312,6 +4334,233 @@ void cpuset_cpus_allowed(struct task_struct *tsk,=
 struct cpumask *pmask)
>  	spin_unlock_irqrestore(&callback_lock, flags);
>  }
> =20
> +/*
> + * Return true if @cs holds a task, or one of its cpusets that is not a
> + * valid partition root does. This is partition_is_populated() for the
> + * offline path, which holds the CPU hotplug lock for writing instead of
> + * cpuset_mutex. That lock keeps tasks from moving to another cgroup:
> + * cgroup_attach_lock() takes it. The caller holds rcu_read_lock().
> + */
> +static bool partition_populated_offline(struct cpuset *cs)
> +{
> +	struct cgroup_subsys_state *pos_css;
> +	struct cpuset *cp;
> +
> +	if (cgroup_has_tasks(cs->css.cgroup))
> +		return true;
> +	cpuset_for_each_descendant_pre(cp, pos_css, cs) {
> +		if (cp =3D=3D cs)
> +			continue;
> +		if (is_partition_valid(cp)) {
> +			pos_css =3D css_rightmost_descendant(pos_css);
> +			continue;
> +		}
> +		if (cgroup_is_populated(cp->css.cgroup))
> +			return true;
> +	}
> +	return false;
> +}

[ ... ]

> +bool cpuset_cpus_allowed_without(struct task_struct *tsk, int cpu,
> +				 struct cpumask *pmask)
> +{
> +	const struct cpumask *possible =3D task_cpu_possible_mask(tsk);
> +	struct cpuset *cs =3D task_cs(tsk), *from;
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
> +			if (!cpumask_empty(pmask) || from =3D=3D &top_cpuset)
> +				break;
> +		}
> +		effective_cpus_below(cs, from, pmask);
> +	}

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

[Severity: Medium]
Can cpuset_offline_moves_dl() and cpuset_cpus_allowed_without() miss the
invalidation of a sibling partition when an unpopulated parent partition
delegates all of its active CPUs to child partitions?

Suppose an unpopulated partition parent_p with effective_xcpus {1, 2}
delegates CPU 1 to a populated child partition c1 and CPU 2 to a sibling
partition c2 created after c1, leaving parent_p->effective_cpus empty.
When CPU 1 goes offline, the pre-order walk in cpuset_handle_hotplug()
first invalidates c1 because it has no active CPUs left; c1 then counts
as populating parent_p, so visiting c2 next triggers
tasks_nocpu_error(parent_p, c2, &new_cpus) in
cpuset_hotplug_update_tasks() and invalidates c2 as well, giving CPU 2 to
parent_p and c1.

Before hotplug runs, cpuset_offline_moves_dl(1) finds p =3D c1, sees
partition_child_lost(c1, 1, &dl_offline_cpus) =3D=3D NULL, and returns false
without checking whether invalidating c1 causes parent_p to invalidate c2.
Similarly, in cpuset_cpus_allowed_without() for a task in c1, walking up
to from =3D parent_p calls partition_populated_offline(parent_p), which
skips c1 because is_partition_valid(c1) is still true, causing
partition_child_lost(parent_p, 1, pmask) to return NULL and the loop to
walk past parent_p to top_cpuset.  As a result, dl_bw_deactivate() can
accept an offline that moves deadline tasks in c1 or c2 into parent_p's
root domain without admission control.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795181240.gi=
t.mathieu.desnoyers@efficios.com?part=3D16
