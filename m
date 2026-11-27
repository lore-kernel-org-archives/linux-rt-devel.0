Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792932;
	b=r2bkUIh5wUnsPVfPHK1Y2VTIAQbaqQH5PcPBRo7Qp20d9dcydrg4iWlZpjJjd2OxsGgi
	 jXo+5hWLyKpbF6CtlHpSPAxCyjH85WOwbSHX4Ay0lwRXthA7JsrHqm53Ss5wfGtmpVrjC
	 Nvjg3YJzNDcGUeMl9YVjQyKrS+uH0E7LK1rYrXh4wrPEr+hfLKCk4dKFEC9zDa1p/wgRA
	 wwwCW5k5S1ny1E5ETs1BYtqMCU6+wQzJFc+13Lx6Pdh48mgb3LB5QyGXXNf7OF+CL1lzQ
	 C+xEE5XjFOYf+046xtkTn58eduUpuBPbQDIp/xL2dHPi7Y+CrW/6ogsEOOjPUWovMfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792932;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8bAdNFT97pbFl4E++HCF7KHqvNkD0KBGjqhvjcXA1cY=;
	b=HqYlZI1La7877HV/JHv20oC+MlSAevdD21/v7EhE7Bh/VczhMxl5ArsSitZc3ZukG825
	 tPz/Ypmfag0pDPpPwmPn9XNn0NpqShsMabUI1hgpSjh6uGag8wEL8b1zrMIRCyMSN4U5q
	 PUX2ri5GoXLxBE6kPB7mwDJ658JRgBHf4cEUYSOZr07qvQeFlqGX9bO0K2NEgvkJon9Il
	 3v4PIDwmZod4yLF3bebkUL4jagl2OWTFPRj5b2tyRWGZmTRMpleQn0Cv+mrMYh9EoQLUU
	 BXUXVUCq/hUVcZBs4k7wjFQLcYctZ+zWa3DqT1i/6Ul4xC42AA1aU/XQajiYrkbFoeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkbzrEWA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCEE606A32D;
	Fri, 27 Nov 2026 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkbzrEWA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A354A1F00897;
	Fri, 27 Nov 2026 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792931;
	bh=8bAdNFT97pbFl4E++HCF7KHqvNkD0KBGjqhvjcXA1cY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LkbzrEWAFSQH6KE454t/eka3dkkLWBxp8FDgOPWFJCyhncE0ohyak5lPTeQsq08uu
	 knbq1sf/dVeACkdRe8an5YL5SjUqf0mPOzJILwvMU4TlLB9016hs853eVnC8Hl7645
	 NITGbd218ZQjQckl89XusfxIH6Wq4ywNjjvlqaTwPatTcz07W54kpun7467RnCw+IT
	 qm6Yp3i67YeI20uGU7GlNph4taW+F/oLb0rVU4uvW6cBhpCWY8aWhHquiWlQDX68Kv
	 VRY0SbUUZr08I7KmuMFlGpey3vQB23k9wVPtzC4GY/NyIL36KHWG0ZoPSjhEX4HaSB
	 1/2B+frnkUKZg==
Message-ID: <sashiko-outbox-237715@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/43] sched/deadline: Keep departing bandwidth
 across a root domain rebuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <fca1ab7a541ea78376d27e327b472acff2ab6fb3.1795771147.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <fca1ab7a541ea78376d27e327b472acff2ab6fb3.1795771147.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:22:11 +0000
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
- [Medium] sched/deadline: departed bw misattributed in
  dl_clear_root_domains()
- [Medium] sched/deadline: departed bw not discounted under lock in
  sched_dl_overflow()
--

commit 11764f8fab5822dc0f850c6d21fd4579821bb933
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep departing bandwidth across a root domain rebuild

This commit tracks tasks that leave SCHED_DEADLINE or die before their
0-lag time on dl_departed_list with their departing CPU and a rebuild
generation counter, so root domain accounting rebuilds and the inactive
timer preserve and release their bandwidth in the original root domain.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index fe6b12500b54b..c2b5b5fdf1b98 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -3643,9 +3778,51 @@ void dl_clear_root_domain(struct root_domain *rd)
>  		dl_server_add_bw(rd, i);
>  }
> =20
> -void dl_clear_root_domain_cpu(int cpu)
> +/*
> + * Clear every root domain before a rebuild of their accounting, and cou=
nt
> + * the rebuild in dl_bw_gen. Put back the bandwidth of their servers. Put
> + * back the bandwidth of the tasks on dl_departed_list, which no cpuset
> + * holds as deadline tasks. Put each in the root domain of the CPU
> + * recorded for it, or drop it if that CPU is not active.
> + * dl_add_task_root_domain() then adds the deadline tasks of the cpusets.
> + */
> +void dl_clear_root_domains(void)
>  {
> -	dl_clear_root_domain(cpu_rq(cpu)->rd);
> +	struct sched_dl_entity *dl_se;
> +	u64 cookie =3D ++dl_cookie;
> +	struct dl_bw *dl_b;
> +	int cpu;
> +
> +	guard(raw_spinlock_irqsave)(&dl_departed_lock);
> +	dl_bw_gen++;
> +	for_each_possible_cpu(cpu) {
> +		if (!dl_bw_visited(cpu, cookie))
> +			dl_clear_root_domain(cpu_rq(cpu)->rd);
> +	}
> +	list_for_each_entry(dl_se, &dl_departed_list, dl_departed_node) {
> +		cpu =3D dl_se->dl_departed_cpu;
> +		/*
> +		 * Skip bandwidth that an earlier rebuild dropped. It is not
> +		 * counted now, and its release removes nothing
> +		 * (dl_task_release_bw()).
> +		 */
> +		if (dl_se->dl_bw_gen !=3D dl_bw_gen - 1)
> +			continue;
> +		/*
> +		 * Drop the bandwidth of a task whose CPU is inactive. A CPU
> +		 * that goes offline is in the default root domain by then.
> +		 * The root domain that counted the task cannot be found
> +		 * from the recorded number. The release then removes
> +		 * nothing, and no later rebuild restores it.
> +		 */
> +		if (!cpu_active(cpu))
> +			continue;
> +		dl_b =3D dl_bw_of(cpu);
> +		raw_spin_lock(&dl_b->lock);
> +		__dl_add(dl_b, dl_se->dl_bw, dl_bw_cpus(cpu));
> +		raw_spin_unlock(&dl_b->lock);
> +		dl_se->dl_bw_gen =3D dl_bw_gen;
> +	}
>  }

[Severity: Medium]
Can dl_clear_root_domains() charge departing bandwidth to the wrong root
domain and underflow cpu_rq(cpu)->dl.extra_bw when dl_departed_cpu is
moved into a new child cpuset partition root before the 0-lag timer
fires?

If two tasks in a 3-CPU top_cpuset (each with dl_bw =3D 0.6) depart while
running on CPU 2 and a new 1-CPU partition root is then created on CPU 2,
this loop adds both tasks' bandwidth (1.2 total) to the new 1-CPU root
domain via dl_bw_of(2).  That drops the departing bandwidth from
top_cpuset, blocks deadline admissions in the new partition with -EBUSY,
and subtracts 1.2 from cpu_rq(2)->dl.extra_bw (initialized to 0.95),
wrapping the unsigned u64 below zero.

Later commits in this series ("sched/deadline: Record the root domain
holding a task's bandwidth" and "sched/deadline: Make a rebuild count a
task in the root domain it runs in") check whether a partition root took
the recorded CPU for live deadline tasks, but leave dl_clear_root_domains()
and the departed branch of dl_add_task_root_domain() using
dl_departed_cpu unconditionally.

[ ... ]

> @@ -3963,8 +4156,6 @@ int sched_dl_overflow(struct task_struct *p, int po=
licy,
> =20
>  	if (dl_policy(policy) && !task_has_dl_policy(p) &&
>  	    !__dl_overflow(dl_b, cap, 0, new_bw)) {
> -		if (hrtimer_active(&p->dl.inactive_timer))
> -			__dl_sub(dl_b, p->dl.dl_bw, cpus);
>  		__dl_add(dl_b, new_bw, cpus);
>  		err =3D 0;
>  	} else if (dl_policy(policy) && task_has_dl_policy(p) &&
> @@ -3990,6 +4181,19 @@ int sched_dl_overflow(struct task_struct *p, int p=
olicy,
>  	}
>  	raw_spin_unlock(&dl_b->lock);
> =20
> +	/*
> +	 * A task that comes back before its 0-lag time still has the
> +	 * bandwidth it left with. The new bandwidth replaces it, so remove the
> +	 * old one from the root domain that keeps it (dl_task_release_bw()).
> +	 * No rebuild can run meanwhile: the caller holds cpuset_mutex.
> +	 */
> +	if (!err && dl_policy(policy) && !task_has_dl_policy(p)) {
> +		lockdep_assert_cpuset_lock_held();
> +		if (p->dl.dl_departed_cpu >=3D 0)
> +			dl_task_release_bw(p, -1);
> +		p->dl.dl_bw_gen =3D dl_bw_gen;
> +	}
> +
>  	return err;
>  }

[Severity: Medium]
When a departed task returns to SCHED_DEADLINE in the same root domain
before its 0-lag timer fires, doesn't releasing p->dl.dl_bw after dropping
dl_b->lock transiently double-count the task's old and new bandwidth in
dl_b->total_bw and rq->dl.extra_bw?

Between raw_spin_unlock(&dl_b->lock) and dl_task_release_bw() taking
dl_b->lock again, both p->dl.dl_bw and new_bw are counted in dl_b, which
can cause concurrent sched_dl_global_validate() or
dl_server_apply_params() calls to fail with -EBUSY and transiently reduces
(or underflows when admission control is disabled) rq->dl.extra_bw read
by grub_reclaim().  In addition, __dl_overflow(dl_b, cap, 0, new_bw)
still checks admission with old_bw =3D 0 even when p->dl.dl_bw is already
counted in the same dl_b and about to be replaced, rejecting a task with
50% bandwidth in a 1-CPU partition root that switches to SCHED_OTHER and
back to SCHED_DEADLINE before its 0-lag time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D1
