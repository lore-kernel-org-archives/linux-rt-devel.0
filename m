Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794019697;
	b=Z4e6itJ4C3DflN6fNrV289bPoZCnoE3oqcIEWP9pwrBmbao0t4ltE0MWQaSL7bHPky74
	 2JyK1OT+UY8X2w4gmwz3o+wX+uw+ItY9Z42UZwcV1h2c8qOuFs4L2zmWZN9rN1/HKhXVT
	 r6owAubWui9LOPT5zmAmuOceytnvlA4luweg5Hq9YknO/vOyssUEG5f4s2n/kBY+dt//O
	 zyvuZfT90YnfqCO2myjHnqPXE321mt4JO2HTHWFrJZdjbqgvID7erqQJ/UoLb4p3olUb7
	 6eQH2zlatL6+ZKJRZvf582tUBIBMvT7OLiyrCJRuxDP2fKS8QomcmY5Lb02KluLzqag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794019697;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AAIgwpH/ck9FKfPm3RWaDCqCEhNWIqAAxiu/CXOeZw8=;
	b=J1y06oLzyHr7Bw4B+BFSsbfXPzWZVW0FeUjPsOUS/8e0tH4b9Bh+EAnFddovWmIRV2tO
	 L1p44khFxHGAPbnfTn0QZnF62/U2G/UAKZpSG/nbwBX3xzec/ryEoyDv6XyD76Tpy9oXY
	 fJVEho99n7AgH9e9AI71otBKIAoj7RABnvLGQXD8oRCugIZBeFHlUv+KFgpUQ8vAMTNkG
	 omdaatOs7Lfwt2nK03MYa4GFqpE0DO4lsdhiOQEnFHze9HrEfVJ3cxm7KLt74GiNWVvgb
	 mQlYulJamKJ/t80H8k+x1xRCTq7yuz7Y37KEjhNo9dT5sZsa5+gBwcNKUihug5h86ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIJy15Yg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A554E606A326;
	Sat,  7 Nov 2026 02:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oIJy15Yg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4591F0089F;
	Sat,  7 Nov 2026 02:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794019696;
	bh=AAIgwpH/ck9FKfPm3RWaDCqCEhNWIqAAxiu/CXOeZw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIJy15YggkrbYsz7vbSYSHLYIrrndeJYFAxF/tYGjT+SBtOH7QVjHQKAQ/A4YhSMM
	 MZd1NYS67f9OJtZzymdNykiLg/gtCvtSrlvLMBRAW2PzoUgWyjxUbem2UvSSmUqXlG
	 I6F8866P9fQDrfDqc7cIsFryGX3SUMNrB6DCE60BM0XFkLHhqEkXG91ED3EZer+/Yh
	 IOvpKqyB65MJ64RENmG4aJhmK92hMaxOy91aO5Fs709w2YX3lXBUpFiTlw+JHEpxqj
	 X2AlXJUTgCRQdGiSwzh+eXTHBixdOWi2b2o4tPYM9MLdJ89I3mA2zJy755M2mm3Svw
	 eO4lweULJNDVg==
Message-ID: <sashiko-outbox-202515@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 20/26] sched/deadline: Credit a rebuild to the CPU
 recorded with the task's bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261107014451.1487825-21-mathieu.desnoyers@efficios.com>
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-21-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 02:48:11 +0000
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
- [Medium] sched/deadline: stale dl_bw_cpu used by dl_task_rebuild_cpu()
  after fallback migration
- [Medium] sched/deadline: dl_task_rebuild_cpu() disagrees with
  select_fallback_rq() on isolated CPUs
--

commit 95575db84831c783a0bb061a74c9e5615adce1b2
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Credit a rebuild to the CPU recorded with the task's bandwi=
dth

This commit adds dl_task_rebuild_cpu() so root domain bandwidth rebuilds
credit each deadline task to the CPU recorded with its bandwidth when active
and allowed, and updates dl_task_offline_migration() to add bandwidth even
when a prior rebuild left the task out.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index f169cf35e3136..ed951246e3d2d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -3656,6 +3662,47 @@ static void dl_get_task_effective_cpus(struct task=
_struct *p, struct cpumask *cp
>  	cpuset_cpus_allowed_locked(p, cpus);
>  }
> =20
> +/*
> + * A CPU of the root domain that a rebuild of the accounting counts @p's
> + * bandwidth in. The one recorded with it, where it is active and the
> + * cpuset of @p allows it: that of the root domain that admitted the
> + * bandwidth, or that the last move put it in, which the cpuset alone do=
es
> + * not tell where it holds CPUs of two root domains, housekeeping ones
> + * beside the ones isolcpus=3D"domain" leaves to the default root domain=
. The
> + * record answers as well for a task whose own CPUs went offline, moved =
to
> + * an active one by dl_task_offline_migration(). Else the first active C=
PU
> + * the cpuset allows, a housekeeping one where it has any; and nr_cpu_ids
> + * where it allows none, which the isolated CPUs allow, no deadline task
> + * of theirs keeping the last of them online.
> + */
> +static unsigned int dl_task_rebuild_cpu(struct task_struct *p)
> +{
> +	struct cpumask *msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
> +	int recorded =3D p->dl.dl_bw_cpu;
> +	unsigned int cpu;
> +
> +	/*
> +	 * The task's own CPUs first: a change of cpusets sets the mask of
> +	 * each task before the rebuild it makes, where the housekeeping mask
> +	 * that dl_get_task_effective_cpus() reads lags that change. With
> +	 * none of them active, the CPU recorded is where
> +	 * dl_task_offline_migration() moved the task; else its cpuset says.
> +	 */
> +	cpumask_and(msk, &p->cpus_mask, cpu_active_mask);
> +	if (cpumask_empty(msk)) {
> +		if (recorded >=3D 0 && cpu_active(recorded))
> +			return recorded;
> +		dl_get_task_effective_cpus(p, msk);
> +		cpumask_and(msk, msk, cpu_active_mask);
> +	}
> +	if (recorded >=3D 0 && cpumask_test_cpu(recorded, msk))
> +		return recorded;
> +	cpu =3D cpumask_first_and(msk, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT=
));
> +	if (cpu < nr_cpu_ids)
> +		return cpu;
> +	return cpumask_first(msk);
> +}

[Severity: Medium]
Can dl_task_rebuild_cpu() credit a task's bandwidth to a different root
domain than the one select_fallback_rq() places the task on when multiple
CPUs are isolated with isolcpus=3Ddomain?

Suppose CPUs 0 and 1 are housekeeping and CPUs 2 and 3 are isolated in
def_root_domain, and a sleeping deadline task is pinned to CPU 2 when CPU 2
goes offline.  Because p->cpus_mask has no active CPU and p->dl.dl_bw_cpu
(2) is inactive, dl_task_rebuild_cpu() falls back to
dl_get_task_effective_cpus(), which sees p->cpus_ptr disjoint from hk_msk
and returns the remaining active isolated CPU 3, so dl_add_task_root_domain=
()
credits def_root_domain and sets p->dl.dl_bw_cpu =3D 3.  When the task later
wakes up, select_fallback_rq() -> cpuset_cpus_allowed_fallback() ->
set_cpus_allowed_force() widens p->cpus_mask to all possible CPUs {0..3} and
selects the first active CPU 0 in the housekeeping root domain, while
p->dl.dl_bw_cpu remains 3 (now in p->cpus_mask) so subsequent rebuilds keep
the bandwidth in def_root_domain.

Conversely, if CPUs 0 and 1 are isolated and CPUs 2 and 3 are housekeeping,
and a running task pinned to CPU 0 is migrated by balance_push() ->
select_fallback_rq() when CPU 0 goes offline, select_fallback_rq() widens
p->cpus_mask to {0..3} and moves the task to the first active CPU 1 in
def_root_domain.  When dl_task_rebuild_cpu() then runs with recorded =3D 0
(inactive) and msk =3D {1, 2, 3}, cpumask_first_and(msk,
housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT)) picks housekeeping CPU 2 instead
of task_cpu(p) (CPU 1), crediting the housekeeping root domain while the
task runs in def_root_domain.

>  /* From dl_rebuild_rd_accounting(), under the locks it asserts. */
>  void dl_add_task_root_domain(struct task_struct *p)
>  {
> @@ -3663,7 +3710,6 @@ void dl_add_task_root_domain(struct task_struct *p)
>  	struct rq *rq;
>  	struct dl_bw *dl_b;
>  	unsigned int cpu;
> -	struct cpumask *msk;
> =20
>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>  	/*
> @@ -3677,10 +3723,16 @@ void dl_add_task_root_domain(struct task_struct *=
p)
>  		return;
>  	}
> =20
> -	msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
> -	dl_get_task_effective_cpus(p, msk);
> -	cpu =3D cpumask_first_and(cpu_active_mask, msk);
> -	BUG_ON(cpu >=3D nr_cpu_ids);
> +	cpu =3D dl_task_rebuild_cpu(p);
> +	if (cpu >=3D nr_cpu_ids) {
> +		/*
> +		 * No active CPU to count this task's bandwidth: leave it out
> +		 * of this rebuild, where dl_bw_gen keeps its release out as
> +		 * well, until one has a CPU for it.
> +		 */
> +		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> +		return;
> +	}

[Severity: Medium]
When a task has no active CPU and is left out of the rebuild here, does
leaving p->dl.dl_bw_cpu untouched cause a later rebuild to credit its
bandwidth back to the old isolated CPU after fallback migration?

If a sleeping task confined to isolated CPU 2 is skipped here when CPU 2
goes offline, p->dl.dl_bw_cpu stays 2.  When the task wakes up while CPU 2
is still offline, try_to_wake_up() -> select_task_rq() ->
select_fallback_rq() calls set_cpus_allowed_force() without
SCA_DL_BW_RESERVED, widening p->cpus_mask to all possible CPUs and moving
the task to a housekeeping CPU without updating p->dl.dl_bw_cpu.  Once CPU 2
is brought back online, dl_task_rebuild_cpu() sees recorded =3D=3D 2 set in
p->cpus_mask & cpu_active_mask and returns CPU 2, crediting the task's
bandwidth to def_root_domain even though the task was left out of the
previous generation and is now running in the housekeeping root domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107014451.1487=
825-1-mathieu.desnoyers@efficios.com?part=3D20
