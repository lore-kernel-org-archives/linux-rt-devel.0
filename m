Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209781;
	b=lX88rkGZUL2yitOWy6r4S2T8zNiutZ9HfYb8GfWR/y+4xW7OmOJkyMad/wLYphuW5LHG
	 Iw56JLV8x55g2btmXiLPOa9aa6yxug1TZr4/a7GToNz9l4pSS1qR79I/v0NEVzuI6FMWq
	 Fg1aZ3vblD6SsbTEwWzxTzKwkOMm3K6vRRQJ2euTHYsdV2jq8kEuGrt67wsmsBBbfy+eY
	 eMpfOibkI8sI3U+xRoMF4f73MtBP16lOmxGvMURbnLYeSD8ni4bRyoMuV2U0YW2GVrOEl
	 5wYzWB+3aRtkIyDiVWUw+VojDZrrX/1ox1MlAB4y5D39JRDR7/hteK/dPckEGO1VtUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209781;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dyryEjqYOME8+PYg9JXDgw0mWKKfxxqicT4a167ty/o=;
	b=w8tRekUn+0ZVgL3ocA+eTdRnsygnfd3mRhb6WMqgLgGSfnmdtydsJ1jf8OnO12J6cfXg
	 wjykVIHtsIHj/46j1dwlQJ1vDqa6Ym4HZdGiL0M6cnW+Sc2bDyONdU21SGcEZse7RLNpp
	 AYjzNaCMlykzeQLrkgZqQCl8ReBaP/xFdPprSOYgANyc+K5rh+UF+3s1jLuWWXa+dfPDT
	 fcp0TZMJhwDTAkCRCirET/qSZOra2No48bDLcfYWljW7trrNCFuBQyiMQJ18aRMqxzvRs
	 s4qN1dAOlrkVNbegbJcStpN8USfghSwptgQdpvCbb+GP1O1mvVFSfIg57eErtDbE6SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXfpvIg1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCDE606A33D;
	Fri, 20 Nov 2026 21:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXfpvIg1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8691F000C4;
	Fri, 20 Nov 2026 21:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209780;
	bh=dyryEjqYOME8+PYg9JXDgw0mWKKfxxqicT4a167ty/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MXfpvIg1v+7aJQmHiqO43dfZD7DhmIq7o2JWtn0nnGHl0B2Ky4kKkNKWPTBBSbZpi
	 VEk7sRnQ9HWSGuTEW3mcUTO1d+WUQzDQgViR1L+CcNCg7ujKDHV8eiOiS7Vz1Y8pi/
	 g7KdZuXoykhqgGqwPhEYW3D/UFg5EgxVNB2bxC/hBON4cmDS7tme1rPkP4KJdSOmOc
	 D4c2J39AdTZNyTUPoHau16ZNOFMRcgRqqjbWUXozlRIEovMoqO0PsQ5bjKE6iWUD5J
	 iStId/JgpNN+wZpoBvmdvWTMqTaOCeGwY9KaNxlRnfCoT1mNYj7GQrMm6+S5kVIjU5
	 UIG38u0ZHnW1Q==
Message-ID: <sashiko-outbox-226169@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 17/40] cgroup/cpuset: Refuse to take a deadline task
 out of its root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <4a72b203ecf2e3de65f7e0ef7fda8eb415af0014.1795207232.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <4a72b203ecf2e3de65f7e0ef7fda8eb415af0014.1795207232.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:22:59 +0000
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
- [Medium] cgroup/cpuset: dl_tasks_keep_without() omits pending CPUs for
  PRS_ISOLATED
- [Low] sched/deadline: dl_task_keeps_root_domain() does not skip
  TASK_DEAD tasks
--

commit 70ebc9e9b00f4d77522df69295e46140ef69f4bc
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

cgroup/cpuset: Refuse to take a deadline task out of its root domain

This commit rejects cpuset mask changes with -EBUSY or invalidates
partitions with PERR_DLTASK when the new effective CPU mask would leave a
SCHED_DEADLINE task without any CPUs in the root domain that accounts its
bandwidth.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index e3c42c63844ba..ea0962f69ba4f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
[ ... ]
> @@ -1148,6 +1181,91 @@ static void effective_cpus_below(struct cpuset *cp=
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
> +	 * of a root partition to one root domain.
> +	 */
> +	if (root->partition_root_state =3D=3D PRS_ROOT) {
> +		pending =3D dl_pending_cpus;
> +		cpumask_copy(pending, root->effective_cpus);
> +		if (root =3D=3D &top_cpuset)
> +			cpumask_and(pending, pending,
> +				    housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
> +	}

[Severity: Medium]
Should pending also be populated when root->partition_root_state is
PRS_ISOLATED (for example via is_partition_valid(root))?

An isolated partition root can have an isolated child partition and hold
SCHED_DEADLINE tasks whose bandwidth is counted in def_root_domain.  When
an isolated parent partition holding a deadline task grows by acquiring a
new CPU, that CPU is not added to def_root_domain.span until
rebuild_sched_domains_locked() runs at the end of the change.  While
update_cpumasks_hier() re-evaluates an invalid child isolated partition via
update_parent_effective_cpumask() -> dl_tasks_keep_without(), pending is
NULL, so dl_task_keeps_root_domain() only checks the pre-rebuild
def_root_domain.span and leaves the child partition invalid with
PERR_DLTASK.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 604b105672103..d8a912ea13d18 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -5287,6 +5287,42 @@ int dl_bw_deactivate(int cpu)
>  	return ret;
>  }
> =20
> +/*
> + * Return false if @p has CPUs in the root domain that counts its
> + * bandwidth and @new_mask holds none of them. A cpuset refuses such a
> + * mask: only a move to another cpuset makes room in another root domain.
> + * Like __set_cpus_allowed_ptr(), keep @new_mask within the affinity set=
 by
> + * the user, if they intersect. @pending is NULL, or holds the CPUs that
> + * the rebuild at the end of the change gives to the root domain of a
> + * partition root.
> + */
> +bool dl_task_keeps_root_domain(struct task_struct *p,
> +			       const struct cpumask *new_mask,
> +			       const struct cpumask *pending)
> +{
> +	const struct cpumask *span, *user =3D cpu_possible_mask;
> +
> +	if (!dl_bandwidth_enabled() || !task_has_dl_policy(p))
> +		return true;
> +	/* pi_lock also protects p->user_cpus_ptr. */
> +	guard(raw_spinlock_irqsave)(&p->pi_lock);
> +	guard(rcu)();
> +	span =3D dl_task_bw_span(p);
> +	/* A task in a migrate_disable() section has a cpus_ptr of one CPU. */
> +	if (!span || !cpumask_intersects(span, &p->cpus_mask))
> +		return true;

[Severity: Low]
Should dl_task_keeps_root_domain() ignore tasks with
READ_ONCE(p->__state) =3D=3D TASK_DEAD, the way dl_task_leaves_span() and
dl_task_in_cpuset() do?

When a SCHED_DEADLINE thread in a multi-threaded process exits before its
0-lag time, it stays on dl_departed_list with a non-NULL dl_task_bw_span(p)
and remains visible to css_task_iter_next() until do_cgroup_task_dead()
unlinks it from cset->tasks.  Evaluating that dead thread here can cause a
cpuset.cpus write to fail with -EBUSY or a partition update to fail with
PERR_DLTASK.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D17
