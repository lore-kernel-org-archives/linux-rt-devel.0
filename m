Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807139;
	b=3q/1l91+Eefa7pJ/WxZl3/3Gwxht3amopUCICT09YF/DEd1QxB/Ns+57QJ9+3w1JcHxy
	 AcDhMfIMMegRn7wffsaC8K6v2sOz1/1mXljU4D+guNSUsf9/hovVOnusVnDeHCns1x7xi
	 KWfbMlEkr20vEjb41wNSsPBqHeGHI9ogYrZ9G8Gi3J+ZVWkZdGKREHi2RP+x6vv3+BGHO
	 PvhdOz0/lAQVZzPVYVDE/7fv7EFGxabq4gynlT8fAUn0vaA4CPplMrT8vOi9ezyvXD7lc
	 tdZSfDTQ8usTVbhlSmvNT5TDWfXaeTmAFmQZTWX2a3MgQFZVShOtuKSSCCsuzZ2lKUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807139;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FUoaVMMjdNye+38KQ9tj7X+L8nPMvUdw6lAcT7+wOes=;
	b=RX8BfDmKPoMjTUxQKpfYhKz5BQrRd6pj2+6IIvOghjpBrRfz3hh5N5ZuBTzF1P+Kvx4w
	 CtEhkOEJtFZG9jyn8gPYeEAefIbFUFsO/HHkj/OnfnmwWwq6U5UKYbanYr5h9bNnTDMp8
	 bhWRtQas9S56BePY4nhuBYhPQXZY/T405iw/oIOptIKdpHAtL+hhlnU+VD5C8O7QygrWn
	 p+hJw+r0ZkLdSpldkc3CVyM0iW1NpAt5iy8MrCjHmqJDb+2yzC9DispL1X9AY9kxtQdk5
	 tWClyefjtt4OTJHalEOQkrNay1u8mZU8stusippfIYqdogQchm7wHy0k/6wToo9ONLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cuvY/XDb";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E929C606A31B;
	Wed,  4 Nov 2026 15:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cuvY/XDb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DA11F000C1;
	Wed,  4 Nov 2026 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807138;
	bh=FUoaVMMjdNye+38KQ9tj7X+L8nPMvUdw6lAcT7+wOes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cuvY/XDbBixltHyNv93Ycz2rwNNLqf55yE/2u8QHeUamIr6uvFMHiZuUdh09dHWJz
	 JE9ZMdXFaLh7ezv+FKDrTFqg4SVjCTyXMbM+7+Jctq3aDN5+FTnMMF70+N0gcfRHQ6
	 lymGY2EbsL1DgEmBqAAOd1XLCFuZwFFyu+mVNQGl1w+KE/CdB9Oz3qDWt5xM3RR/JS
	 2rjdSjYObTRzhMOwbRDMzZzAKVm2mVtxFfB5cCL+5vCKiIr9Y7lbZizqg6NztMFegK
	 aFXeW81h/6Lp4U9dx1JHdsaAvLTfp6yyN6D7856Z4t71kO9kpubv+sZAIp4EsbRGav
	 KFpWkKbqjWK7w==
Message-ID: <sashiko-outbox-197536@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] sched/deadline: Rebuild the root domains'
 accounting without cpusets too
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <7ea39be6af23940c33a63002ea832838fe69bb9e.1793804635.git.mathieu.desnoyers@efficios.com>
References: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
 <7ea39be6af23940c33a63002ea832838fe69bb9e.1793804635.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:45:37 +0000
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
- [High] sched/deadline: race between dl_rebuild_rd_accounting() and sched_=
dl_overflow()
- [High] sched/deadline: BUG_ON() in dl_add_task_root_domain() when isolate=
d CPUs offline
- [High] sched/deadline: dl_get_task_effective_cpus() picks isolated CPU fo=
r hk tasks
--

commit c1e57d1e06a701583f3de7582594314893352edf
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Rebuild the root domains' accounting without cpusets too

This commit implements dl_rebuild_rd_accounting() in kernel/sched/deadline.c
for kernels built without CONFIG_CPUSETS by clearing the root domains and
walking all threads under tasklist_lock to re-add their deadline bandwidth.
It also moves the declaration of dl_rebuild_rd_accounting() from
include/linux/cpuset.h to include/linux/sched/deadline.h.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index a8906cf966401..0ea902b9e5d09 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3668,6 +3668,28 @@ void dl_clear_root_domain(struct root_domain *rd)
>  		dl_server_add_bw(rd, i);
>  }
> =20
> +#ifndef CONFIG_CPUSETS
> +/*
> + * Rebuild the root domains' accounting, where no cpuset holds the
> + * deadline tasks of each: they are found by walking them all, which
> + * dl_rebuild_rd_accounting() of the cpusets does per cpuset instead.
> + */
> +void dl_rebuild_rd_accounting(void)
> +{
> +	struct task_struct *g, *p;
> +
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&sched_domains_mutex);
> +
> +	dl_clear_root_domains();

[Severity: High]
What serializes this rebuild against concurrent __sched_setscheduler() ->
sched_dl_overflow() calls when CONFIG_CPUSETS is disabled?

With CONFIG_CPUSETS enabled, __sched_setscheduler() in
kernel/sched/syscalls.c calls cpuset_lock() when entering, leaving, or
updating SCHED_DEADLINE:

	if (dl_policy(policy) || dl_policy(p->policy)) {
		cpuset_locked =3D true;
		cpuset_lock();
	}

and sched_dl_overflow() in kernel/sched/deadline.c relies on cpuset_mutex to
prevent a rebuild from running concurrently:

	/*
	 * Back before its 0-lag time, the task still has the bandwidth it
	 * left with, which the new one replaces: removed from the root
	 * domain that keeps it (dl_task_release_bw()). A rebuild cannot
	 * run meanwhile: the caller holds cpuset_mutex.
	 */
	if (!err && dl_policy(policy) && !task_has_dl_policy(p)) {
		lockdep_assert_cpuset_lock_held();
		if (p->dl.dl_departed_cpu >=3D 0)
			dl_task_release_bw(p, -1);
		p->dl.dl_bw_gen =3D dl_bw_gen;
	}

When !CONFIG_CPUSETS, cpuset_lock() and lockdep_assert_cpuset_lock_held() in
include/linux/cpuset.h are no-op stubs, while dl_rebuild_rd_accounting() on=
ly
holds cpu_hotplug_lock and sched_domains_mutex, neither of which is taken by
__sched_setscheduler().

Without mutual exclusion between dl_rebuild_rd_accounting() and
__sched_setscheduler(), can they interleave and corrupt rd->dl_bw.total_bw?
For example:

1. A task entering SCHED_DEADLINE calls sched_dl_overflow(), which adds
new_bw to dl_b->total_bw under dl_b->lock and drops dl_b->lock before setti=
ng
p->dl.dl_bw_gen =3D dl_bw_gen and before __setparam_dl() updates p->dl.dl_bw
and p->prio. If dl_clear_root_domains() runs in that window, it increments
dl_bw_gen and resets rd->dl_bw.total_bw to 0 (wiping out new_bw), after whi=
ch
sched_dl_overflow() writes the new dl_bw_gen into p->dl.dl_bw_gen. When
dl_add_task_root_domain() later visits p, it sees p->dl.dl_bw_gen =3D=3D
dl_bw_gen and skips it, leaving new_bw uncounted until p exits and underflo=
ws
total_bw.

2. If an existing SCHED_DEADLINE task updates its parameters after
dl_clear_root_domains() zeroes total_bw and before for_each_process_thread()
reaches p, sched_dl_overflow() adjusts total_bw by new_bw - old_bw without
updating p->dl.dl_bw_gen, __setparam_dl() sets p->dl.dl_bw =3D new_bw, and
dl_add_task_root_domain() subsequently adds new_bw a second time.

3. If a task switches out of SCHED_DEADLINE after dl_clear_root_domains() h=
as
walked dl_departed_list and before for_each_process_thread() visits p,
switched_from_dl() moves p to dl_departed_list and clears its deadline
priority, so dl_add_task_root_domain() sees !dl_task(p) and drops its
bandwidth before its 0-lag time.

4. Between dl_clear_root_domains() and the end of the tasklist walk,
concurrent sched_dl_overflow() admission checks evaluate __dl_overflow()
against a zeroed or partially rebuilt total_bw.

> +
> +	read_lock(&tasklist_lock);
> +	for_each_process_thread(g, p)
> +		dl_add_task_root_domain(p);

[Severity: High]
Can walking all tasks with for_each_process_thread() trigger the
BUG_ON(cpu >=3D nr_cpu_ids) in dl_add_task_root_domain() when CPUs isolated=
 via
isolcpus=3Ddomain are taken offline?

In kernel/sched/deadline.c, dl_add_task_root_domain() computes the effective
CPU mask and checks BUG_ON(cpu >=3D nr_cpu_ids) before checking
p->dl.dl_bw_gen, p->dl.dl_departed_cpu, or p->dl.dl_bw:

	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
		return;
	}

	msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
	dl_get_task_effective_cpus(p, msk);
	cpu =3D cpumask_first_and(cpu_active_mask, msk);
	BUG_ON(cpu >=3D nr_cpu_ids);

And dl_get_task_effective_cpus() handles HK_TYPE_DOMAIN isolation as follow=
s:

	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
			/*
			 * CPUs isolated by isolcpu=3D"domain" always belong to
			 * def_root_domain.
			 */
			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
			return;
		}
	}

Because for_each_process_thread() visits every task in the system, it visits
unreaped EXIT_ZOMBIE deadline tasks whose bandwidth has already been releas=
ed
or moved to dl_departed_list (where p->prio is still < MAX_DL_PRIO, so
dl_task(p) is true), as well as PI-boosted tasks with p->dl.dl_bw =3D=3D 0.
Since those tasks carry no active bandwidth in def_root_domain to block
dl_bw_deactivate(), all isolated CPUs outside hk_msk can be taken offline.
When that happens, cpumask_andnot(cpus, cpu_active_mask, hk_msk) is empty,
cpumask_first_and(cpu_active_mask, msk) returns nr_cpu_ids, and
dl_add_task_root_domain() hits BUG_ON(cpu >=3D nr_cpu_ids).

[Severity: High]
Also in the dl_add_task_root_domain() -> dl_get_task_effective_cpus() path =
on
!CONFIG_CPUSETS, could housekeeping deadline tasks have their bandwidth
added to def_root_domain instead of the housekeeping root domain when
isolcpus=3Ddomain is used?

In dl_get_task_effective_cpus():

	hk_msk =3D housekeeping_cpumask(HK_TYPE_DOMAIN);
	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
			return;
		}
	}

	cpuset_cpus_allowed_locked(p, cpus);

When !CONFIG_CPUSETS, cpuset_cpus_allowed_locked() in include/linux/cpuset.h
copies task_cpu_possible_mask(p) into cpus without masking out the CPUs
isolated by HK_TYPE_DOMAIN:

static inline void cpuset_cpus_allowed_locked(struct task_struct *p,
					struct cpumask *mask)
{
	cpumask_copy(mask, task_cpu_possible_mask(p));
}

For a housekeeping deadline task where p->cpus_ptr intersects hk_msk,
dl_add_task_root_domain() then picks:

	cpu =3D cpumask_first_and(cpu_active_mask, msk);

If an active isolated CPU has a lower CPU number than the active housekeepi=
ng
CPUs (for example with isolcpus=3Ddomain,0), cpu resolves to CPU 0, whose
cpu_rq(cpu)->rd is def_root_domain rather than the housekeeping root domain.
Wouldn't that account the housekeeping task's bandwidth into def_root_domain
during the rebuild, and later underflow the housekeeping root domain's
total_bw when the task leaves SCHED_DEADLINE or exits?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793804635.gi=
t.mathieu.desnoyers@efficios.com?part=3D11
