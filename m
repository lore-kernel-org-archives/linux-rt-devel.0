Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859289;
	b=Qf3yecSSWKJc230ATLzLozbeG/lbcKBfYZyMOCGFovB9Id7z8bpXhLo3qzFyyfkPYUYS
	 NsHnRFZocFGv8iEk1RcWuaYCL63KNihzqZlOwi4QJaHVGZOfZ9Y4CyKoevloaa00FljlJ
	 Z3xt6EeOZNp9NhHsF14LlZVaEjgOgTjKON+PBTUHRp+AFQpn8xSnEqP9EUDinSuO3PB8M
	 f4eRnCCMT6i7cOItU9RRHMz/IIult6lF8PglWyZymdAA0l+Y2FAP6IFMJZHHD6y/3UEUa
	 BkTTO28gpOzfV/Ta+TZ68R7Y7THKNyCxDBTQESXVGrOQ7Yt85B/BRTIPKDxc1NkVabA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859289;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+T2KYxpU/p45NNR6XvSw9rX7S7huMe68JNhs7SJPSV4=;
	b=s5Ze/0qkDidaHlZaAXSwZMeiohx973u37v+QJawbNr71n3AdiGx03BCRyrBtLQ5wnkK3
	 rT511AbxWxWVSxYne83oEbI54bNS/kDh2TRcg4JGKvoYbrTsmoLLZH6xIcNuWV/jIONTr
	 rSjxXGs+p7rot5bbEiqmWyHpwOlgkn2//iQHW9w/dofxPBhtwbUllPvndtbD5SHd3PhvE
	 B0tOF91tTVKB0twasvS3gu6dMvQKhTch+GtVc7Af3jgnHXkbmoofeBmnRFiqAB1J2j3uL
	 DoDpoioZtdxI0UH+e64lz+g1wzRec3rOm+ahZTJ38mLjhCCDl23qoylXquudgNR2LUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aCNI1V/G";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE56606A322;
	Mon, 16 Nov 2026 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aCNI1V/G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B811F000C4;
	Mon, 16 Nov 2026 20:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859288;
	bh=+T2KYxpU/p45NNR6XvSw9rX7S7huMe68JNhs7SJPSV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aCNI1V/G5Sf4po6V6umaX6mPEQraCcVrzIIccUY8LDCmXwkKtfC+WjxLP5dckSEeq
	 /WSEWT0T0aGmkABhjDCMRpLBfJzYmUdnFOPmkHrWCArUpsyBDBSZK/zVOZcxVyHguV
	 NwAc5zVUcruzoypclYSsjKZOoZ2CltS7Kpd5KftMpPnJawKzWYbvvSHSDKjFGmBktC
	 Y40GBXxM+qy5GxWyg6XBDvE7Zi0SAoWJjicDu977WD5IkXqyxQHImP5TKIPQ8+SIIw
	 c6E3rB/HwciJuHByv3+7CllifGnrcW6C2ej9FzP5a+aeeEnota9xHp+llBg6gkXmj0
	 tOur4VIB8py/A==
Message-ID: <sashiko-outbox-217630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 24/37] sched/deadline: Make a rebuild count a task in
 the root domain it runs in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-25-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-25-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 20:01:27 +0000
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
- [Medium] sched/deadline: dl_task_rebuild_cpu() misaccounts
  offline-migrated task
--

commit 9e9e921e040902e3cbd909c81dd80911851e51ce
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Make a rebuild count a task in the root domain it runs in

This commit updates root-domain deadline bandwidth rebuilding to select the
CPU where a deadline task's bandwidth is counted based on the task's current
CPU, recorded dl_bw_cpu, active affinity mask, and cpuset, while skipping
tasks that have no active CPU available.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b43106a590256..c765a403014a2 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -3795,6 +3801,55 @@ static void dl_get_task_effective_cpus(struct task=
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
> +	if (cpumask_test_cpu(cpu, msk))
> +		return cpu;
> +	if (cpumask_empty(msk)) {
> +		if (recorded >=3D 0 && cpu_active(recorded))
> +			return recorded;
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
Can dl_task_rebuild_cpu() count a task migrated by
dl_task_offline_migration() in the wrong root domain once a CPU in
p->cpus_mask comes back online?

When admission control is disabled and all CPUs in p->cpus_ptr are offline,
dl_task_offline_migration() falls back to cpumask_any(cpu_active_mask) and
moves a throttled task's bandwidth and runqueue placement to that fallback
CPU without changing p->cpus_mask:

kernel/sched/deadline.c:dl_task_offline_migration() {
    ...
		cpu =3D cpumask_any_and(cpu_active_mask, p->cpus_ptr);
		if (cpu >=3D nr_cpu_ids) {
			...
			cpu =3D cpumask_any(cpu_active_mask);
		}
		later_rq =3D cpu_rq(cpu);
    ...
}

If p was pinned to a single offline CPU (p->nr_cpus_allowed =3D=3D 1), it i=
s not
pushable and continues running and replenishing on the fallback CPU even
after its original CPU comes back online.  During the rebuild triggered by
that cpu_up(), msk (&p->cpus_mask & cpu_active_mask) is no longer empty, and
neither task_cpu(p) nor recorded (p->dl.dl_bw_cpu) is in msk.
dl_task_rebuild_cpu() then returns a CPU from msk rather than task_cpu(p),
accounting the bandwidth in the root domain of p->cpus_mask instead of the
root domain where the task is still queued and running.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D24
