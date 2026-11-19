Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121012;
	b=sWZZGT89YfbnR+aDDLIwcb+C0kFSAywV57RfEhbjUDMPseJmrOlbmOInYkV7XjiMhJiq
	 kOXDaCIOzokac7Khq4S1GfFa2N2nNpiZbFb9gVDhqZ+stG7b3OaANC8x9lYxOWkOvyUgW
	 UZL/x9QOXQ7r60/nHHcHvnKmEcri0zmqMCcnUldFsVXi5fYJXjwz4fdZC5C7Ag/c7nXrw
	 1eesLN+1tcIjo/uA0l7Htuvy/TAnENWfyEfHzv/e2sr4S/LRCgevzvHv1UdfyTMX5PiQu
	 l4tBoS3cQ4i/H5oPAjOOJjr6RxUNh5AGQE9+b9rKYUtX2xYpxNfOEvB6N65Z5kScXfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121012;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9uAHqj9t+kIJyelQwFFNiq2CuAQrjW/jg//cYnhkbOg=;
	b=oEeD8zatYo73+aiBSfaCjPaR6aD+NySu0d8XpBHhpiLHsNH6Ac1fXmcKzXCfhVrVulO7
	 4swwMGYW4soV97MMprtAeiyJJLZYa63d0ESS64q38omLgW78YKzcLmU1NaotIr4lOqOW0
	 QD3wLtmG+XWeyvLRoeohzrrbqu3Mbym0S7PWQWhaJSAlhb1fODGke2XT81Y5B/sT1EcAJ
	 mqjNQkPtSrdLt8inTY1rsYBQa+WTndQvkznhL0w9/CSUA79fJm3O2nvG0DTB6Sg0zEugQ
	 BE+8jTiOHaZdP3nFFEi4Bk1N+CghIfPKGwvz770TccA6agoF92zognSQdwrC3031qlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akb7UfSF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D950F606B76A;
	Thu, 19 Nov 2026 20:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=akb7UfSF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B811F000C6;
	Thu, 19 Nov 2026 20:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121012;
	bh=9uAHqj9t+kIJyelQwFFNiq2CuAQrjW/jg//cYnhkbOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=akb7UfSFhnv4ETeJeQRQNqhfBdC1ZaMR283NCMyhSQBUPrZXD417abB0r1EIhy23R
	 ehfPydjts8BdXR7D12SmJVXFlO8wvnNeWmojzPE0W10DlrrJ/rBMMAm837MCX+thSm
	 BBwo9enQKFy9tiUiiTbAvS/67H1sM5vhyB3XDWlfjeNLpS/ik9d8UreT5jf0xJWoGM
	 dr4y6SQ7Ksq1un3Y7iFg8q1xVr/7t4PdK10eLUt0HVzprrBBGDOMRfZM24/yByfMry
	 CsHm/ZtomfWyg2YiAELTD/ZLPxskiGX8A/RPkvgf4bCd6IripvfMG/O01J0MQU+Yto
	 9UOddbSDcemjQ==
Message-ID: <sashiko-outbox-224041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 17/33] cgroup/cpuset: Refuse to take a deadline task
 out of its root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <b9c82782e39a90f12daa052f5189fbfc97e2eb11.1795116791.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <b9c82782e39a90f12daa052f5189fbfc97e2eb11.1795116791.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:43:31 +0000
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
- [Medium] cgroup/cpuset: stale root domain check in
  update_parent_effective_cpumask()
- [Medium] cgroup/cpuset: offline CPU mismatch in
  dl_tasks_keep_without() for top_cpuset
--

commit b32b990dae89a854c1147c1874b9e7ba8e861a7d
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

cgroup/cpuset: Refuse to take a deadline task out of its root domain

This commit refuses cpuset cpumask updates and invalidates partitions that
would remove all CPUs of the root domain accounting a SCHED_DEADLINE task's
bandwidth.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 5299652d47b6e..4350977601eb1 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
[ ... ]
> @@ -2106,10 +2232,13 @@ static int update_parent_effective_cpumask(struct=
 cpuset *cs, int cmd,
>  				}
>  				rcu_read_unlock();
>  			}
> -			if (exclusive)
> -				deleting =3D !cpumask_empty(tmp->delmask);
> -			else
> +			if (!exclusive)
>  				part_error =3D PERR_NOTEXCL;
> +			else if (!dl_tasks_keep_without(parent, cs, tmp->delmask,
> +							NULL, true))
> +				part_error =3D PERR_DLTASK;
> +			else
> +				deleting =3D !cpumask_empty(tmp->delmask);
>  		}
>  		/*
>  		 * When both cs and parent remain valid, parent's

[Severity: Medium]
Can dl_tasks_keep_without() here reject a valid partition recovery with
PERR_DLTASK because the root domains have not been rebuilt yet?

This partcmd_update branch with newmask =3D=3D NULL runs from
cpuset_hotplug_update_tasks() and update_cpumasks_hier() after
parent->effective_cpus has grown, but before rebuild_sched_domains_locked()
or rebuild_sched_domains_cpuslocked() updates rd->span.

For example, when a valid non-top partition parent holding CPU 0, a deadline
task on CPU 0, and an invalid child partition requesting CPU 0 (previously
PERR_NOCPUS) is expanded to CPUs {0, 1}, update_cpumasks_hier() updates
parent->effective_cpus to {0, 1} and calls
update_parent_effective_cpumask(cp, partcmd_update, NULL, tmp) before
rebuilding sched domains.  At that point dl_task_bw_span() for parent's
deadline task is still {0}, so dl_tasks_keep_without(parent, cp, {0}, NULL,
true) sees that parent's remaining CPU {1} does not intersect {0} and leaves
the child partition invalid with PERR_DLTASK.  The same stale span check al=
so
runs when a CPU comes online in cpuset_hotplug_update_tasks(), which then
migrates the task onto the newly onlined CPU anyway while leaving the
partition invalid.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index eead45a0c1191..641674f65931f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -5141,6 +5141,31 @@ int dl_bw_deactivate(int cpu)
>  	return ret;
>  }
> =20
> +/*
> + * Return false if @p has CPUs in the root domain that counts its
> + * bandwidth and @new_mask holds none of them. A cpuset refuses such a
> + * mask: only a move to another cpuset makes room in another root domain.
> + * Like __set_cpus_allowed_ptr(), keep @new_mask within the affinity set=
 by
> + * the user, if they intersect.
> + */
> +bool dl_task_keeps_root_domain(struct task_struct *p,
> +			       const struct cpumask *new_mask)
> +{
> +	const struct cpumask *span;
> +
> +	if (!dl_bandwidth_enabled() || !task_has_dl_policy(p))
> +		return true;
> +	/* pi_lock also protects p->user_cpus_ptr. */
> +	guard(raw_spinlock_irqsave)(&p->pi_lock);
> +	guard(rcu)();
> +	span =3D dl_task_bw_span(p);
> +	if (!span || !cpumask_intersects(span, p->cpus_ptr))
> +		return true;
> +	if (p->user_cpus_ptr && cpumask_intersects(new_mask, p->user_cpus_ptr))
> +		return cpumask_intersects_and(span, new_mask, p->user_cpus_ptr);
> +	return cpumask_intersects(span, new_mask);
> +}

[Severity: Medium]
Does dl_task_keeps_root_domain() mismatch cpuset_update_tasks_cpumask() when
offline CPUs are present in top_cpuset?

For top_cpuset, dl_tasks_keep_without() builds new_mask from
top_cpuset.effective_cpus, which only contains active CPUs, whereas
cpuset_update_tasks_cpumask() passes possible_mask & ~subpartitions_cpus
(including offline CPUs) to set_cpus_allowed_ptr():

kernel/cgroup/cpuset.c:cpuset_update_tasks_cpumask() {
	...
		if (top_cs) {
			if (task->flags & (PF_KTHREAD | PF_NO_SETAFFINITY))
				continue;
			cpumask_andnot(new_cpus, possible_mask, subpartitions_cpus);
		} else {
			cpumask_and(new_cpus, possible_mask, cs->effective_cpus);
		}
		set_cpus_allowed_ptr(task, new_cpus);
}

If a deadline task in top_cpuset has user_cpus_ptr set to {offline CPU,
online CPU X} and a partition takes CPU X, cpumask_intersects(new_mask,
p->user_cpus_ptr) is false because new_mask excludes the offline CPU, so
dl_task_keeps_root_domain() assumes user_cpus_ptr will be ignored and allows
the partition change.  When cpuset_update_tasks_cpumask() then calls
set_cpus_allowed_ptr() with the offline CPU included in new_cpus,
__set_cpus_allowed_ptr() intersects with user_cpus_ptr down to the offline
CPU alone and fails with -EINVAL, leaving the top_cpuset deadline task bound
to CPU X inside the new partition.

In addition, cpumask_intersects(span, p->cpus_ptr) does not mask with
cpu_active_mask; because def_root_domain.span and top_cpuset tasks' cpus_ptr
both include all offline possible CPUs, that test stays true whenever any
possible CPU is offline even if p has no active CPUs in def_root_domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795116790.gi=
t.mathieu.desnoyers@efficios.com?part=3D17
