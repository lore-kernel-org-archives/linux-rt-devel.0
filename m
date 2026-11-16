Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858614;
	b=o/hsNbBN6bcS4GkILv40w5VmM1yx9s5K7cxfp4iQ1/rM2Fcd8F3F/Vxe+PuStNj3QhQt
	 h3vdY8OfG/yRIcb1qOCZivn74m3sodMDFE+qGnVUKzM3XLedNivDuscfjA8vyxXhGEaOm
	 n8nq/R8t/MRqUBMrl6q5K2puCxZg6uUdkKcyWzLb9bil+WosOLlBV8y5gQtP3hcWxsbQi
	 SOGYBMiy2hCjrOhwzZjF6aTY0cSFQjkcFdEyu30nznF0IkVRPEf0WctH821cCS9QfvSDi
	 IqwhT7bCdTGiltAbTQCvM4fEN74NGEo769Qsi+yHZlcLrDPMPpJgsWL4SLj1+33LHPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858614;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IIvFx80GjTB9EGYhrWhLVrexyzalzFYFMysPWbOV+sc=;
	b=I2SJfO2CcpxJYygX7i07V7S2Dhn6dnd78sOYcPAb6X7ICusIpFg7gs/BBLedMnt4Mx2T
	 Xyq4T8/2hwTPqZOD3HG1K2QU37XFmuXRJKEEzRmcosAQa8O48Xghj7Fv8lBXlCgyDMHpR
	 1V82NnGtpdlAGnzWnSYDIXLpUroE9CSZFbgYL40rZr2D41MqB8JmDu6EGFQaD15rKeXBr
	 sNglgEHGk5IVERTrFSdBoZx9FwA7LX6BNnypTQDlgWn9r8paBy7YhmraBqdzbfxZFYgS/
	 r2uzYUvmMv9qcLRwrXoLrM6oe9/OnJdlDHRa+BsyQsFMTT8apyltmHNLKg3pLLePmdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R5U37/PQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA7D606A329;
	Mon, 16 Nov 2026 19:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R5U37/PQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3519C1F000C7;
	Mon, 16 Nov 2026 19:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858613;
	bh=IIvFx80GjTB9EGYhrWhLVrexyzalzFYFMysPWbOV+sc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R5U37/PQW8PaVqe7TNoKWnmH1a4YAkPlXHHXbiIQBxt7qqOvF+Hs+NWq1pyB9kiQ3
	 KWrP0cbISNKbvddq9EvvTfsYcLP+lGF/H7ajxFlZgMrhkX39k9f858O/UfDv9HDiDz
	 Vfrq2Oy6kS0i0ps9tj3YFrwSU2i/bOciLGtYuPW0PwrgyheyBVlF+2JDtNKtCfDBdX
	 4V9zqLlQZMXnTsmsYrJz5ITUZvzAEuJalcoS+Nre/BHP0CW5BOTnBXlb30qpRp8+5V
	 55Mw6zq5eX0S7OGLK+icnp+zOXDqTIKlXQXiwXdUhAvSfYwIitSuNJ7M7ePOw34/XT
	 77YFqeg8p7HYg==
Message-ID: <sashiko-outbox-217620@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 26/37] sched/deadline: Keep a task in the root domain
 that counts its bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-27-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-27-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:50:12 +0000
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
- [Medium] sched/deadline: dl_task_offline_migration() bypasses
  dl_task_bw_span()
- [Medium] sched/deadline: dl_task_bw_span() returns NULL for
  deactivating dl_bw_cpu
- [Low] sched/deadline: dead branch and fallback order in
  dl_task_rebuild_cpu()
--

commit a54933b747047e1dd4434be5e5299159be0de9fe
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep a task in the root domain that counts its bandwidth

This commit adds dl_task_bw_span() and updates CPU selection paths and
dl_task_rebuild_cpu() to prefer CPUs in the root domain that counts a
deadline task's bandwidth.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 35f40185953a3..5294546786f12 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -864,13 +864,19 @@ static struct rq *dl_task_offline_migration(struct =
rq *rq, struct task_struct *p
> =20
>  	later_rq =3D find_lock_later_rq(p, rq);
>  	if (!later_rq) {
> +		const struct cpumask *span =3D dl_task_bw_span(p);
>  		int cpu;
> =20
>  		/*
>  		 * If we cannot preempt any rq, fall back to pick any
> -		 * online CPU:
> +		 * online CPU. Try the root domain that counts @p first.
>  		 */
> -		cpu =3D cpumask_any_and(cpu_active_mask, p->cpus_ptr);
> +		cpu =3D nr_cpu_ids;
> +		if (span)
> +			cpu =3D cpumask_first_and_and(cpu_active_mask,
> +						    p->cpus_ptr, span);
> +		if (cpu >=3D nr_cpu_ids)
> +			cpu =3D cpumask_any_and(cpu_active_mask, p->cpus_ptr);

[Severity: Medium]
Can find_lock_later_rq(p, rq) bypass the dl_task_bw_span(p) check and
migrate p onto an isolated CPU in def_root_domain?

When a housekeeping CPU goes offline, detach_destroy_domains() attaches
its runqueue to def_root_domain while dl_rebuild_rd_accounting() moves a
throttled task's bandwidth to the new housekeeping root domain.  When
dl_task_timer() later fires on that offline CPU and calls
dl_task_offline_migration(), find_later_rq() searches
task_rq(p)->rd->cpudl, which is def_root_domain.cpudl:

kernel/sched/deadline.c:find_later_rq() {
    ...
	if (!cpudl_find(&task_rq(task)->rd->cpudl, task, later_mask))
		return -1;
    ...
}

With isolcpus=3Ddomain, isolated CPUs also belong to def_root_domain.  If
p->cpus_mask includes an isolated CPU that is free or running a later
deadline in def_root_domain.cpudl, find_lock_later_rq() returns that
isolated CPU's runqueue and skips the !later_rq fallback entirely,
moving p and its bandwidth into def_root_domain without admission
control.

[ ... ]

> @@ -3669,6 +3690,29 @@ static unsigned int dl_task_root_domain_cpu(struct=
 task_struct *p)
>  	return cpu;
>  }
> =20
> +/*
> + * Return the CPUs of the root domain that counts the bandwidth of @p, or
> + * NULL if none does. The mask of @p can hold CPUs of another root domai=
n,
> + * with isolcpus=3D"domain". Where a CPU is picked for @p, a CPU of this
> + * root domain comes first: no other root domain admitted @p.
> + *
> + * The caller holds the pi_lock or the rq lock of @p. With interrupts
> + * off, the root domain is not freed.
> + */
> +const struct cpumask *dl_task_bw_span(struct task_struct *p)
> +{
> +	int cpu;
> +
> +	if (!task_has_dl_policy(p) || dl_entity_is_special(&p->dl) ||
> +	    !p->dl.dl_bw)
> +		return NULL;
> +	cpu =3D READ_ONCE(p->dl.dl_bw_cpu);
> +	if (cpu < 0 || !cpu_active(cpu) ||
> +	    READ_ONCE(p->dl.dl_bw_gen) !=3D READ_ONCE(dl_bw_gen))
> +		return NULL;
> +	return cpu_rq(cpu)->rd->span;
> +}

[Severity: Medium]
Does rejecting !cpu_active(cpu) here cause dl_task_bw_span() to return
NULL while a CPU is being deactivated?

In sched_cpu_deactivate(cpu), set_cpu_active(cpu, false) runs before
balance_push_set(), synchronize_rcu(), and cpuset_cpu_inactive(), and
cpuset_handle_hotplug() also calls cpuset_hotplug_update_tasks() before
rebuild_sched_domains_cpuslocked() runs dl_rebuild_rd_accounting().
Throughout that window, cpu_rq(cpu)->rd still points to the root domain
that counts p's bandwidth, but any task whose p->dl.dl_bw_cpu is the
outgoing CPU gets dl_task_bw_span(p) =3D=3D NULL.  Tasks pushed by
balance_push, updated by cpuset_hotplug_update_tasks(), or woken during
deactivation can then be placed on an isolated CPU in def_root_domain
and move their bandwidth there without admission control.

> @@ -3903,6 +3947,27 @@ static unsigned int dl_task_rebuild_cpu(struct tas=
k_struct *p)
>  	 */
>  	cpumask_and(msk, &p->cpus_mask, cpu_active_mask);
>  	cpu =3D task_cpu(p);
> +	/*
> +	 * Keep the bandwidth where it was counted: with the housekeeping
> +	 * CPUs, or with the CPUs that isolcpus=3D"domain" isolates. The root
> +	 * domains are new, and the CPU recorded can be offline. So prefer a
> +	 * CPU of the mask of the same kind as the CPU recorded: housekeeping
> +	 * or not.
> +	 */
> +	if (recorded >=3D 0) {
> +		const struct cpumask *hk =3D housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT);
> +		bool rec_hk =3D cpumask_test_cpu(recorded, hk);
> +		unsigned int same;
> +
> +		if (cpumask_test_cpu(cpu, msk) && cpumask_test_cpu(cpu, hk) =3D=3D rec=
_hk)
> +			return cpu;
> +		if (cpumask_test_cpu(recorded, msk))
> +			return recorded;
> +		for_each_cpu(same, msk) {
> +			if (cpumask_test_cpu(same, hk) =3D=3D rec_hk)
> +				return same;
> +		}
> +	}
>  	if (cpumask_test_cpu(cpu, msk))
>  		return cpu;
>  	if (cpumask_empty(msk)) {

[Severity: Low]
Because the new (recorded >=3D 0) block returns recorded whenever
cpumask_test_cpu(recorded, msk) is true, the existing else-if branch
right below this hunk is now unreachable:

kernel/sched/deadline.c:dl_task_rebuild_cpu() {
    ...
	if (cpumask_empty(msk)) {
		if (recorded >=3D 0 && cpu_active(recorded))
			return recorded;
		dl_get_task_effective_cpus(p, msk);
		cpumask_and(msk, msk, cpu_active_mask);
	} else if (recorded >=3D 0 && cpumask_test_cpu(recorded, msk)) {
		return recorded;
	}
    ...
}

Also, when cpumask_empty(msk) is true and recorded is inactive,
dl_get_task_effective_cpus(p, msk) refills msk after the kind-matching
loop has already run, so the fallback at the end of the function will
pick a housekeeping CPU even when recorded was an isolated CPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D26
