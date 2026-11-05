Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793837894;
	b=T6omfPI4baeaCVvKUcMWDkWGZ4cIAZbfJj3Wy6sUbECMXt0kH3CxroB/22lA4ossnoP3
	 z6nn2OBnUyXGnGds5QdGBGbePDlGgiNLG9hbZAGBYXRgCsdVr1wHM6AUw7r9INi+lwnA1
	 ZZQn20zKWNxpLvzgsO/fFPyZb81MZRl0N/+t5c5pW2VcrzISZFxkcSyFwvv6ofPFiAshk
	 jPNVtyMGG2XYA4vpcFFisS734xj7qQZhztopdGYriCdxlJqjJBy/jdO2FsdhCzFaNnw9P
	 j/lYyFUV0JBDIHZipX/vPWhB8WToq7ITrxXYfqhIKsSshZEMMF22ziZAcf1x/WAOtsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837894;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tcVGlFNKiNvkU2JmAQTx514vxuvuoK0ws39vUVWc+G8=;
	b=e1wi56M8i7vWF6bRc0K0WP5AL6AMShzs56UUREDNAA0rZy38NKQoWBP+ewTQitSdWVfQ
	 VklQtRSPRWYFGBbgkbd0vpjBadhSR1y0QWkQ6kGVDFGACrLzE6VwiYa3KFownUl4m5LuP
	 0UxmOTwPjvjE91Wr8Tfk+d9IQlAs4oNOqnO7Aslutd8EJ422sVc+yjPqunkjYon0VRQWP
	 C3Vyaz5V7DWYId7B2rIsFcPZnXFZ/pUsl8oEQnAL3j0lDJJB2GAcKQ9LMH75LqUCWxs+e
	 pd3bEs84EUrpS7Up944x4CuNrXU6CMX0AYkEtUc5mDFRUJ5yTBfUWzyMcQHjTLrOZXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUsH7AoI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC996606A326;
	Thu,  5 Nov 2026 00:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aUsH7AoI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA6C1F000C1;
	Thu,  5 Nov 2026 00:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793837893;
	bh=tcVGlFNKiNvkU2JmAQTx514vxuvuoK0ws39vUVWc+G8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aUsH7AoImJ01+fCanW1QEhBv9nWlL+ll/qHyNEn8duaAXyzyK977im6kG8R2kIz+6
	 51Kqw9XdehqRMzMkboJhJsa1LyPxSjIOxy6CXHlcWeFqBKoCvdOYHfWV1Ws9S/Sh3D
	 /lKSvxWbbztM2I9s5hM/erTjtivb/auO3Do1PhzjmrohH8ahW3+CyYf+IT8K9hvysd
	 elGtv/XeEJzFEhlTbXiqG0icFXo+zoD+BCaARQjH2dVZNJEA9KJrzQDuDCX0dH0mkZ
	 cx0i32pfsxRJc/Rad0B+Jd76QnK7IOZB6txiq1Bk6qZT32KCO4AwSIwi+O1Jbq4G+K
	 1X00j6/QZ3OQw==
Message-ID: <sashiko-outbox-198343@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/21] sched/deadline: Credit a rebuild to a CPU that
 can hold the bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261104211207.1392343-19-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-19-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:18:12 +0000
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
- [High] sched/deadline: offline hk_msk CPUs break dl_get_task_effective_cp=
us()
- [High] sched/deadline: stale HK_TYPE_DOMAIN mask in dl_get_task_effective=
_cpus()
- [High] sched/deadline: dl_add_task_root_domain() ignores dl_bw_cpu on emp=
ty msk
--

commit 119330e07c6138cad461765e2b7413e00f7f5e31
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Credit a rebuild to a CPU that can hold the bandwidth

This commit filters out isolated CPUs from a deadline task's effective CPU
mask when housekeeping CPUs are present, and skips tasks that have no active
CPU during a root domain bandwidth accounting rebuild.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 029ec2ba5a663..c0af06d0f3688 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3617,6 +3617,16 @@ static void dl_get_task_effective_cpus(struct task=
_struct *p, struct cpumask *cp
>  	 * hierarchy up to the partition root.
>  	 */
>  	cpuset_cpus_allowed_locked(p, cpus);
> +	/*
> +	 * Which the CPUs isolated by isolcpu=3D"domain" are not part of: a
> +	 * cpuset can include them beside housekeeping CPUs, and without
> +	 * cpusets the mask is every CPU the task can run on. The first
> +	 * active CPU of it would then be an isolated one, of the default
> +	 * root domain, rather than one of the root domain the task's
> +	 * bandwidth belongs to.
> +	 */
> +	if (housekeeping_enabled(HK_TYPE_DOMAIN))
> +		cpumask_and(cpus, cpus, hk_msk);
>  }

[Severity: High]
Can offline or unpopulated housekeeping CPUs in hk_msk cause
dl_get_task_effective_cpus() to drop or misattribute the bandwidth of a
deadline task running in def_root_domain?

In housekeeping_setup() and housekeeping_update(),
housekeeping_cpumask(HK_TYPE_DOMAIN) is built from cpu_possible_mask minus
the isolated CPUs, so hk_msk continues to include housekeeping CPUs when
they are offline or unpopulated:

kernel/sched/deadline.c:dl_get_task_effective_cpus() {
	hk_msk =3D housekeeping_cpumask(HK_TYPE_DOMAIN);
	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
			return;
		}
	}
	cpuset_cpus_allowed_locked(p, cpus);
	if (housekeeping_enabled(HK_TYPE_DOMAIN))
		cpumask_and(cpus, cpus, hk_msk);
}

For a deadline task running on an active isolated CPU in def_root_domain,
p->cpus_ptr can still contain offline or unpopulated housekeeping CPUs
(for example, __sched_setscheduler() requires cpumask_subset(rq->rd->span,
p->cpus_ptr) where def_root_domain.span contains offline possible CPUs,
and top_cpuset keeps offline non-subpartition CPUs in p->cpus_ptr).

Because p->cpus_ptr and hk_msk both contain those offline housekeeping CPUs,
cpumask_intersects(p->cpus_ptr, hk_msk) evaluates to true even when p has no
active housekeeping CPU in p->cpus_ptr. Execution then falls through and
cpumask_and(cpus, cpus, hk_msk) strips all active isolated CPUs from cpus:

- If cpus contains no active housekeeping CPUs (for example, all
  housekeeping CPUs in top_cpuset are offline, or p is in a child cpuset cs
  where guarantee_active_cpus() stops at cs because cs->effective_cpus
  intersects cpu_active_mask on the active isolated CPU),
  cpumask_first_and(cpu_active_mask, msk) in dl_add_task_root_domain()
  returns >=3D nr_cpu_ids and drops the active task's bandwidth from
  def_root_domain.

- If another housekeeping CPU outside p->cpus_ptr is active in top_cpuset
  (or with !CONFIG_CPUSETS), stripping the isolated CPUs causes
  dl_add_task_root_domain() to credit p's bandwidth to that housekeeping
  root domain instead of def_root_domain. Similarly, a task admitted on an
  isolated CPU in def_root_domain with an unnarrowed affinity mask has its
  bandwidth moved to a housekeeping root domain on rebuild while continuing
  to run in def_root_domain.

- Conversely, if a housekeeping deadline task is preempted on an isolated
  CPU while in a migrate_disable() section, migrate_disable_switch() narrows
  p->cpus_ptr to cpumask_of(rq->cpu), so !cpumask_intersects(p->cpus_ptr,
  hk_msk) evaluates to true and credits its bandwidth to def_root_domain
  instead of its housekeeping root domain.

[Severity: High]
Also in dl_get_task_effective_cpus(), does reading HK_TYPE_DOMAIN observe a
stale mask during cgroup v2 isolated partition transitions?

When a cgroup v2 PRS_ISOLATED partition transitions to PRS_ROOT or
PRS_MEMBER, or is invalidated during CPU hotplug,
cpuset_update_sd_hk_unlock() and cpuset_handle_hotplug() invoke
rebuild_sched_domains_locked() -> partition_sched_domains_locked() ->
dl_rebuild_rd_accounting() -> dl_add_task_root_domain() ->
dl_get_task_effective_cpus() before housekeeping_update() updates
HK_TYPE_DOMAIN:

kernel/cgroup/cpuset.c:cpuset_update_sd_hk_unlock() {
	if (force_sd_rebuild)
		rebuild_sched_domains_locked();

	if (update_housekeeping) {
		update_housekeeping =3D false;
		cpumask_copy(isolated_hk_cpus, isolated_cpus);

		mutex_unlock(&cpuset_mutex);
		cpus_read_unlock();
		WARN_ON_ONCE(housekeeping_update(isolated_hk_cpus));
	}
}

While generate_sched_domains() uses housekeeping_cpumask(HK_TYPE_DOMAIN_BOO=
T),
dl_get_task_effective_cpus() queries HK_TYPE_DOMAIN, which still excludes t=
he
CPUs transitioning out of PRS_ISOLATED while dl_rebuild_rd_accounting() run=
s.

If a deadline task in that partition has p->cpus_ptr intersecting the stale
hk_msk (for example, on an offline CPU), cpumask_and(cpus, cpus, hk_msk)
clears the newly un-isolated active CPUs from cpus and drops the task's
bandwidth from the rebuild. If p->cpus_ptr does not intersect the stale
hk_msk, dl_get_task_effective_cpus() returns cpu_active_mask & ~hk_msk,
which can pick a lower-numbered isolated CPU in def_root_domain instead of
the task's new root domain.

> =20
>  /* The caller should hold cpuset_mutex */
> @@ -3637,7 +3647,18 @@ void dl_add_task_root_domain(struct task_struct *p)
>  	msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
>  	dl_get_task_effective_cpus(p, msk);
>  	cpu =3D cpumask_first_and(cpu_active_mask, msk);
> -	BUG_ON(cpu >=3D nr_cpu_ids);
> +	if (cpu >=3D nr_cpu_ids) {
> +		/*
> +		 * No active CPU to count this task's bandwidth: the ones it
> +		 * may run on all went offline, which the CPUs isolated by
> +		 * isolcpu=3D"domain" allow, no deadline task of theirs keeping
> +		 * the last of them online. Leave it out of this rebuild,
> +		 * where dl_bw_gen keeps its release out as well, until one
> +		 * has a CPU for it.
> +		 */
> +		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> +		return;
> +	}

[Severity: High]
Does returning early when cpu >=3D nr_cpu_ids skip tasks whose bandwidth was
already moved to an active fallback CPU by dl_task_offline_migration(), or
recorded on an active CPU in p->dl.dl_bw_cpu when departing SCHED_DEADLINE?

When a deadline task confined to isolated CPUs is throttled while all of its
isolated CPUs go offline, dl_task_timer() -> dl_task_offline_migration()
picks an active fallback CPU via cpumask_any(cpu_active_mask), migrates p to
later_rq->cpu, and records p->dl.dl_bw_cpu =3D later_rq->cpu without modify=
ing
p->cpus_ptr:

kernel/sched/deadline.c:dl_task_offline_migration() {
	scoped_guard (raw_spinlock, &dl_departed_lock) {
		if (p->dl.dl_bw_gen =3D=3D dl_bw_gen) {
			...
		}
		p->dl.dl_bw_cpu =3D later_rq->cpu;
	}

	set_task_cpu(p, later_rq->cpu);
}

Because p->cpus_ptr is still restricted to the offline isolated CPUs,
dl_get_task_effective_cpus(p, msk) returns an empty mask on rebuild. In
dl_add_task_root_domain(), cpu =3D cpumask_first_and(cpu_active_mask, msk) =
is
then >=3D nr_cpu_ids, and this early return exits before consulting
p->dl.dl_bw_cpu or crediting later_rq->rd->dl_bw.

Similarly, because the cpu >=3D nr_cpu_ids return happens before acquiring
dl_departed_lock and checking !list_empty(&p->dl.dl_departed_node), a task
that departed SCHED_DEADLINE with an active CPU recorded in p->dl.dl_bw_cpu
and then had its affinity restricted to offline isolated CPUs (before dying
during the rebuild walk or being PI-boosted back into dl_sched_class prior =
to
its 0-lag time) will also return early and have its bandwidth omitted from
the recorded active CPU's root domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104211207.1392=
343-1-mathieu.desnoyers@efficios.com?part=3D18
