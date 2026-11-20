Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209100;
	b=YViUAmywzcYVFKCH1+0UzTndGy2vpFDNAlAPr9DCkS071kYIdn17JV6PKGbhgack5L5d
	 mlLYqyLee4WPGMVjcYDRaQCJGV/UvypSBnP0ojeWAJJCZOhqroDxjZaxiQ7YTUNA6b7rQ
	 sWupc4/Q3q83FOD5ihdNw+S+wAvieAdRdDoB4LuP0sDdNfMZ8huVuNQQnX85rHoVKHQN+
	 YeQhf4xuzBOwwhImjL3ylk/ebuYqUnBXTTuDRtSrubtNgcbnmy4LsK/a5Ulrpcw6ows7h
	 z+RS6fmW1xkJmdhqNFKyxjcwyu8F0fDihALDw5ZVKDg7w8/nfBMKZFC7Gx1f+zdh1uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209100;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S1HXA273iuZgUbRFpoY4bpPQTCGhUgQPAylO/uCFCCY=;
	b=mKqX+l2yCvOr1zawye+hwRcTn9MgDOAhQ1oeiiwxULUbT0iu4AVxZN4ddS47YOkI3Kri
	 s7/7hq9PGzKZBZrVBwYGsZwTY6j9e9J8ykO91xXo+WWLcfljx7oY4kJzE/Ga7oSg92Zej
	 7wR/z1/Esm+gstrAxm0/KTZatOffO4Gsv/C3eckgBWDxb+PjK5y9IouWHrq+DY5eX/001
	 ymEOKEt8OE1JretbFqZqAhQYOzInoFX7wxgDDc/eg/bcIqNokYE3LrtqiU4YeH+ulf4G1
	 Rg1zGmQpkxe8o7nSTJiSRrOYcP3jOKij59vh39IDQrj2HqNg2fO2TTrObi9OZqAOjSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGZrNpFI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2210F606A33B;
	Fri, 20 Nov 2026 21:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RGZrNpFI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D321F000D1;
	Fri, 20 Nov 2026 21:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209100;
	bh=S1HXA273iuZgUbRFpoY4bpPQTCGhUgQPAylO/uCFCCY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RGZrNpFIdBbOzaNY41L39KW2hfNgNtLjqiK4YgpvNueV4Y+BbqhmiHzggX+Fk7gwD
	 aMcfQq708OwgHid4c4SLiF9HdGnqN4EVB4ZIB75erASPDPWmXHiJexcAH+RX0fwQcz
	 XmcX7gr4JovN75Ni/LORYBDmTCU+RO5PGb8GVICnsw1dRSlQxWeuSf4jMqSoDr1w2o
	 WIGTJfXaSSPwwhFJ+8UkcN1EfzJSjv7zHcn4BoMRXWes61MKXzf7JhV0edmahONVP2
	 t5OYkmmxN/stOstplIyuB1fLzY1fMC4p2+1IRpIKadU0FsDOXx9ewb+lln3nmLOvXX
	 4xIFYAJNKnTBA==
Message-ID: <sashiko-outbox-226138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 13/40] sched/deadline: Make a rebuild count a task
 in the root domain it runs in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <c7c27e2c74c13bb8580f84ac9ed12a5a8001947a.1795207232.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <c7c27e2c74c13bb8580f84ac9ed12a5a8001947a.1795207232.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:11:38 +0000
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
- [Medium] sched/deadline: dl_add_task_root_domain() drops departed
  out-of-mask task bw
--

commit 39db1557a3e0cb285c7dd82b57ad0144aeff4d00
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Make a rebuild count a task in the root domain it runs in

This commit introduces dl_task_rebuild_cpu() to select the CPU and root
domain where a deadline task's bandwidth is counted during a root domain
accounting rebuild, and leaves out tasks with no active CPU instead of
triggering a BUG_ON().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0ece0f7d5e1ae..1e7168241e9cf 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -3863,6 +3875,62 @@ static void dl_get_task_effective_cpus(struct task=
_struct *p, struct cpumask *cp
>  	cpuset_cpus_allowed_locked(p, cpus);
>  }
> =20
> +/*
> + * Return a CPU of the root domain where a rebuild of the accounting sho=
uld
> + * count the bandwidth of @p, or nr_cpu_ids if there is none.

[ ... ]

> +static unsigned int dl_task_rebuild_cpu(struct task_struct *p)
> +{
> +	struct cpumask *msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
> +	/*
> +	 * Read the record once. The last schedule of a dead task clears it
> +	 * under its rq lock, and the caller holds only the pi_lock.
> +	 */
> +	int recorded =3D READ_ONCE(p->dl.dl_bw_cpu);
> +	unsigned int cpu;
> +
> +	/*
> +	 * Look at the mask of the task first. A change of the cpusets sets
> +	 * the mask of each task before its rebuild. If no CPU of the mask
> +	 * is active, ask the cpuset. The task wakes up on one of its CPUs.
> +	 * Take the CPU recorded only if it is one of them: a partition root
> +	 * can have taken it since it was recorded.
> +	 */
> +	cpumask_and(msk, &p->cpus_mask, cpu_active_mask);
> +	cpu =3D task_cpu(p);
> +	if (cpumask_test_cpu(cpu, msk) ||
> +	    (cpu =3D=3D recorded && cpu_active(cpu) && task_on_rq_queued(p)))
> +		return cpu;
> +	if (cpumask_empty(msk)) {
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
> +
>  /* From dl_rebuild_rd_accounting(), under the locks it asserts. */
>  void dl_add_task_root_domain(struct task_struct *p)
>  {
> @@ -3870,7 +3938,6 @@ void dl_add_task_root_domain(struct task_struct *p)
>  	struct rq *rq;
>  	struct dl_bw *dl_b;
>  	unsigned int cpu;
> -	struct cpumask *msk;
> =20
>  	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>  	/*
> @@ -3885,10 +3952,17 @@ void dl_add_task_root_domain(struct task_struct *=
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
> +		 * No active CPU can count the bandwidth of this task. Leave it
> +		 * out of this rebuild. dl_bw_gen then keeps its release from
> +		 * removing anything. A later rebuild, or
> +		 * dl_task_offline_migration(), counts it again.
> +		 */
> +		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
> +		return;
> +	}

[Severity: Medium]
Can this early return drop the departing bandwidth of a task that was
migrated outside its mask by dl_task_offline_migration() and exited
during the rebuild?

When admission control is disabled and all CPUs in a task's mask and
cpuset are offline, dl_task_offline_migration() moves a throttled task
and its bandwidth to an active fallback CPU (recording it in
p->dl.dl_bw_cpu).  If a subsequent rebuild runs dl_clear_root_domains()
and the task then exits on that fallback CPU with its 0-lag time in the
future before dl_add_task_root_domain() visits it, the task is dequeued
and placed on the departed list.

Because task_on_rq_queued(p) is now false and neither p->cpus_mask nor
dl_get_task_effective_cpus() contains an active CPU,
dl_task_rebuild_cpu() returns nr_cpu_ids.  Returning before acquiring
dl_departed_lock skips the !list_empty(&p->dl.dl_departed_node) branch
right below, which would otherwise count the departed task on its active
recorded p->dl.dl_bw_cpu until the inactive timer fires:

kernel/sched/deadline.c:dl_add_task_root_domain() {
	...
	if (!list_empty(&p->dl.dl_departed_node)) {
		int recorded =3D p->dl.dl_bw_cpu;

		if (p->dl.dl_bw_gen !=3D dl_bw_gen - 1)
			goto unlock;
		if (recorded < 0 || !cpu_active(recorded))
			goto unlock;
		cpu =3D recorded;
	}
	...
}

Deferring the cpu >=3D nr_cpu_ids check (or dl_task_rebuild_cpu() itself)
until after the departed-list check under dl_departed_lock would preserve
the departing bandwidth on the recorded CPU's root domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D13
