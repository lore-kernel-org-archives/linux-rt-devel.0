Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929478;
	b=Hsuxprcwjs+pHiC7kXetkKaKEjKl3BU1nIhS0fhS90E6WoY9rmhluQZHyll2Mo/Io+Ox
	 M9TBdxNZDuc3fkxUjdKbHus7HUUVNXW1FKJCCu28HxsqWXC50lsnzxGvlxO4HWk+6Dzr/
	 OMsPMe8Avxo+e8/xhmlMT9t6i8hBjyY4cDSrInQpxct+MM1YspqelB6N17OTRhlNGeTTW
	 HQza/+t2NkuHXzFK/wNkIfAZGe2u6UhZZotv7sQqJUhASA3DejQKD/qr3t/XSZFbfKbj1
	 aMSkRlBWkZT+onRYrFokO7No/Oz8sekTW5PIeOCnM1Inch/HyVXPmU9vW/DhjngOV5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929478;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PKL4BRMLIT1oHfd2ndtnhBtH2V+B8G3agIEqqwCdQbs=;
	b=mqPIShAwK15eQif3lhzv9/RnPHGA/v8LBCvEzZLf7GFL3GtCbDVsrS2Y2qDhTyheGI/9
	 qEuWH9KnA7cX+f9LUL4pO+Ta/0VM+rUFNN/FH3EPsSiq8vTMcvtC8zIna0FZPpGSmTlJt
	 55oEJuJNJyqeAvEG/WbVS+7p+K94A2F9kuWygCMeLPrwEtU9s+CLjySHliy2gPap6gLC3
	 be5kgo5B9YQAfES10nzlfyZawHJEFhL7dgpZhnLAkZ2OzeyJkNw93vPTxqOUiZmWQH9uF
	 SK4udhDDh2KK1bkBYJm9mVF0tESiHWKdwKJc4YkkJtQyJMEzpU/w0oB8tILzLcCOEaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lb4Zqmun;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C321606A31C;
	Tue, 17 Nov 2026 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lb4Zqmun
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48B91F000C4;
	Tue, 17 Nov 2026 15:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929478;
	bh=PKL4BRMLIT1oHfd2ndtnhBtH2V+B8G3agIEqqwCdQbs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lb4ZqmunJK2+v72NmsYfb5eNrDr7boYx136hYrQMwuaNlgfQx8wdH2uVxbEzS5h1/
	 6rbawUxjgWpugFRHXYmAl7clPGzwj/alPa6dX559vxS7jylz/6NKP8A9oVgpDH+rxr
	 EDuAokXAe1VuSKM8id7c8DmKCUSapEV8SIyCiPS6JCvcZwIc8l4uVrU+GFzKuUKSOc
	 17Ug/yyzD0X+vmYXWlP2H9vBi9Pz1mqgR+gYuUkrvaTGHkOY0n0DPqPi34S31lF2Ov
	 uOK642REd+CL4pvuM5zYme4DxwLAdp7XP+6RQ8+1MSD50vyQ2YUiZAM5zPmAHqSOoR
	 q3KaErre1RU6Q==
Message-ID: <sashiko-outbox-219082@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 26/40] sched/deadline: Make a rebuild count a task in
 the root domain it runs in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <d956394fd7c5d85d9cd92489b0abf5c709c4545d.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <d956394fd7c5d85d9cd92489b0abf5c709c4545d.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:31:17 +0000
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
- [Medium] sched/deadline: dl_task_rebuild_cpu() uses recorded CPU
  outside task cpuset
- [Medium] sched/deadline: dl_task_rebuild_cpu() fallback reads stale
  HK_TYPE_DOMAIN
--

commit 5f53c9545c6d42e90c32f229213e080ced9acb3f
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Make a rebuild count a task in the root domain it runs in

This commit introduces dl_task_rebuild_cpu() to select an active CPU in
the root domain where a deadline task runs during root domain bandwidth
rebuilds, and leaves out tasks with no active CPU until offline migration
or a later rebuild places them.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index a9b8bd019d4ba..9ff79141c6306 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -3820,6 +3826,60 @@ static void dl_get_task_effective_cpus(struct task=
_struct *p, struct cpumask *cp
>  	cpuset_cpus_allowed_locked(p, cpus);
>  }
> =20
> +/*
> + * Return a CPU of the root domain where a rebuild of the accounting sho=
uld
> + * count the bandwidth of @p, or nr_cpu_ids if there is none.
> + *
> + * Prefer the CPU @p is on, if it is active and in the mask of @p. The
> + * task runs, or wakes up, in the root domain of that CPU. A mask can ho=
ld
> + * CPUs of two root domains: housekeeping CPUs and CPUs isolated by
> + * isolcpus=3D"domain". When every CPU of a mask goes offline,
> + * select_fallback_rq() can widen it to both. It moves no bandwidth.
> + * Prefer that CPU also if @p is queued there, out of its mask, and the
> + * CPU is the one recorded. Without admission control,
> + * dl_task_offline_migration() can put a throttled task and its bandwidth
> + * on any active CPU. The task runs there until it blocks.
> + *
> + * Else prefer the CPU recorded with the bandwidth, if it is active and =
in
> + * the mask. It is in the root domain that admitted the bandwidth, or th=
at
> + * its last move put it in. A task moved asleep is still on a CPU of the
> + * root domain it left, out of its mask. Else take the first active CPU =
of
> + * the mask, a housekeeping one if there is one. A task on isolated CPUs
> + * that all went offline can have no active CPU at all.
> + */
> +static unsigned int dl_task_rebuild_cpu(struct task_struct *p)
> +{
> +	struct cpumask *msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
> +	int recorded =3D p->dl.dl_bw_cpu;
> +	unsigned int cpu;
> +
> +	/*
> +	 * Look at the mask of the task first. A change of the cpusets sets
> +	 * the mask of each task before its rebuild. The housekeeping mask
> +	 * that dl_get_task_effective_cpus() reads is updated after it. If no
> +	 * CPU of the mask is active, take the CPU recorded if it is active.
> +	 * dl_task_offline_migration() moved the task there, or an earlier
> +	 * rebuild counted it there. Else ask the cpuset.
> +	 */
> +	cpumask_and(msk, &p->cpus_mask, cpu_active_mask);
> +	cpu =3D task_cpu(p);
> +	if (cpumask_test_cpu(cpu, msk) ||
> +	    (cpu =3D=3D recorded && cpu_active(cpu) && task_on_rq_queued(p)))
> +		return cpu;
> +	if (cpumask_empty(msk)) {
> +		if (recorded >=3D 0 && cpu_active(recorded))
> +			return recorded;

[Severity: Medium]
Can returning recorded here without checking the task's cpuset charge the
bandwidth to a newly created partition that no longer contains the task?

Suppose a sleeping task in top_cpuset has user_cpus_ptr restricted via
sched_setaffinity() to CPUs 0 and 1, and both go offline while CPUs 2 and
3 remain online.  The hotplug rebuild sees an empty msk, falls back to
dl_get_task_effective_cpus(), and records CPU 2 in p->dl.dl_bw_cpu.

If CPU 2 is then moved into a new cpuset partition root,
cpuset_update_tasks_cpumask() updates top_cpuset tasks with
possible_mask & ~subpartitions_cpus.  Because __set_cpus_allowed_ptr()
intersects that mask with p->user_cpus_ptr ({0, 1}), p->cpus_mask stays
{0, 1} and msk remains empty.  This check then sees CPU 2 is still active
and returns it, counting the top_cpuset task's bandwidth in the new
partition on CPU 2 instead of top_cpuset on CPU 3.

> +		dl_get_task_effective_cpus(p, msk);
> +		cpumask_and(msk, msk, cpu_active_mask);
> +	} else if (recorded >=3D 0 && cpumask_test_cpu(recorded, msk)) {
> +		return recorded;
> +	}
> +	cpu =3D cpumask_first_and(msk, housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT=
));
> +	if (cpu < nr_cpu_ids)
> +		return cpu;
> +	return cpumask_first(msk);
> +}

[Severity: Medium]
Does calling dl_get_task_effective_cpus() here read a stale
HK_TYPE_DOMAIN mask during cpuset partition transitions?

dl_get_task_effective_cpus() checks housekeeping_cpumask(HK_TYPE_DOMAIN):

kernel/sched/deadline.c:dl_get_task_effective_cpus() {
	hk_msk =3D housekeeping_cpumask(HK_TYPE_DOMAIN);
	if (housekeeping_enabled(HK_TYPE_DOMAIN)) {
		if (!cpumask_intersects(p->cpus_ptr, hk_msk)) {
			cpumask_andnot(cpus, cpu_active_mask, hk_msk);
			return;
		}
	}
}

HK_TYPE_DOMAIN excludes both boot-time isolcpus=3Ddomain CPUs and runtime
isolated cpuset partitions, and cpuset_update_sd_hk_unlock() rebuilds
root domain accounting before housekeeping_update() refreshes
HK_TYPE_DOMAIN.  If a task is confined to an offline isolcpus=3Ddomain CPU
(so msk is empty and recorded is inactive) when a runtime isolated
partition on another CPU transitions to root or member,
cpu_active_mask & ~hk_msk still includes that partition's CPU.
dl_add_task_root_domain() will then charge the task's bandwidth to that
root domain and record the CPU in p->dl.dl_bw_cpu.

Should dl_get_task_effective_cpus() use HK_TYPE_DOMAIN_BOOT to match
dl_task_rebuild_cpu()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D26
