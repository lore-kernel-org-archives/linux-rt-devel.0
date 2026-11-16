Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858998;
	b=pmAIBwHX7iH4JIU7VOOtYMqEr848m1TJglq+8wGOWeCSBlII5fxVIQhaeU/s0lBeHNEp
	 Q1K7P73pFODhmNTrlEdHVSr+bLwxNF6YtEbtBHFy6RJtWngdlpGltgCtMCfuVASjWRSxh
	 0xRaRqPyGlxrLiWMUG7RLVneMZqRfuidxrEKkJHObaaY9uqp9nkpHQUyNPmLzlP2MzU/r
	 BP8d0934/cRQrFO8YqQRC1QsC9wuNKpja/0jRMGJPxMQUEGVrQWxBwAFSuxdKOSu0yaHQ
	 hxjWvqz5qDKYHaejx6sSB8czHo5D5g6RqbOoozEm99aIAj24IcUSNVgT+7xOFLJ560Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858998;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yYuKJFpeOOUiRlcbNdqkTa4zbZgovEnL4C4jJYmyByo=;
	b=N6kIXaO67YkVqFPXyVd3lQjBWSb3+Z0cqL9EFgvL0NQoc2ttPDHDuxDNJ5JlMbmJK34m
	 DEAGUo22Wwx497g48MHj6b7A/ryaGWEH1vbBGXGEGRDFa0K5P2AqXcGu684ypjJMIBBba
	 GzmO1P4JWOKjXSBis6Z54pghJQkydeg4Wgvu8ffsSPV3YI1hstgMIge6JroNSA+JvvuS+
	 NFTuNAVmFABfJ+IOEWrWEXIwaoW5ShEW+Mjr1J9v34U+Ya7H0/Bi5i9JQEUtQvuGmmSuf
	 3DjakeR39FjZX/piNq23Fb5jWVtYe2K8uNMdCAcz0y+uYKqD4MO1QkAKUbwp78JSR9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lxorfpif;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD91606A31C;
	Mon, 16 Nov 2026 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lxorfpif
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B351F000C4;
	Mon, 16 Nov 2026 19:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794858997;
	bh=yYuKJFpeOOUiRlcbNdqkTa4zbZgovEnL4C4jJYmyByo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LxorfpiffHEPN+ubuF4E7+AUjQL37EeodzC6ntwfs4G/wWQYneZ6fevziae8iFk6i
	 NWLgto+vGSH2E+T0YigXRESx7Tsh8lTGTKtD+dBJc5K78kyfFKINEzcZLiQWGOX1f8
	 4uHP1j9zM3TdXVFym3DuVoVouyRUuJBN0qWITMlKiY9DwN8lChHZjgeNw/NF/mkMEs
	 bVo3e3piBmW9GcH9wbrWlhdpk1zPguitn4EWTekY+dfBDCUyRFo5jpdJbJ0/DhZ4Cd
	 pe1Hla9Rrr9mqweu52p1+4j3AhJPNLa+e9TqGLL6vkB/egfl81gZAuy9vV0bup3pCX
	 fD70TuUyA3BSg==
Message-ID: <sashiko-outbox-217626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 23/37] cgroup/cpuset: Reserve the bandwidth in the
 root domain a task moves to
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-24-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-24-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:56:36 +0000
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
- [High] sched/deadline: unmasked offline CPUs in
  __dl_task_bw_move_cpu() span check
- [Medium] cgroup/cpuset: stale dl_bw_resv_cpu left when cpuset_attach()
  skips task loop
--

commit 1fc4cfdda6a5d5f5e22bff0342024fd03d578a7c
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

cgroup/cpuset: Reserve the bandwidth in the root domain a task moves to

This commit reserves and moves a deadline task's bandwidth using the
specific destination CPU recorded in task->dl.dl_bw_resv_cpu during
cpuset_can_attach(), keeping per-CPU reservation sums in cpuset_dl_bw so
that attaches to cpusets spanning multiple root domains account bandwidth
in the root domain where the task actually runs.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 2f39c3d12550e..0d55f092d9cbb 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
[ ... ]
> @@ -3236,15 +3258,20 @@ static int cpuset_can_attach(struct cgroup_taskse=
t *tset)
>  				goto out_unlock;
>  		}
> =20
> -		if (dl_task(task)) {
> -			/*
> -			 * Count all migrating DL tasks for cpuset task accounting.
> -			 * Only tasks that need a root-domain bandwidth move
> -			 * contribute to sum_migrate_dl_bw.
> -			 */
> -			cs->nr_migrate_dl_tasks++;
> -			if (dl_task_needs_bw_move(task, cs->effective_cpus))
> -				cs->sum_migrate_dl_bw +=3D task->dl.dl_bw;
> +		if (!dl_task(task))
> +			continue;
> +		/*
> +		 * Sum the bandwidth of the deadline tasks that move to another
> +		 * root domain, per CPU that the move records. That CPU depends
> +		 * on the CPUs the task gets. A cpuset can span more than one
> +		 * root domain, and the affinity of a task can keep it in any
> +		 * of them.
> +		 */
> +		cpuset_attach_cpus(cs, task, cpus_attach);
> +		cpu =3D dl_task_bw_reserve_cpu(task, cpus_attach);
> +		if (cpu >=3D 0) {
> +			per_cpu_ptr(&cpuset_dl_bw, cpu)->sum +=3D task->dl.dl_bw;
> +			cpumask_set_cpu(cpu, dl_attach_cpus);
>  		}
>  	}
[ ... ]
> @@ -3407,8 +3446,9 @@ static void cpuset_attach(struct cgroup_taskset *ts=
et)
>  		schedule_flush_migrate_mm();
>  	cs->old_mems_allowed =3D attach_ctx.nodemask_to;
>  out:
> -	clear_attach_data(&src_cs_head, false);
> -	clear_attach_data(&dst_cs_head, false);
> +	clear_attach_data(&src_cs_head);
> +	clear_attach_data(&dst_cs_head);
> +	cpuset_free_dl_bw();
>  	dec_attach_in_progress_locked();
> =20
>  	mutex_unlock(&cpuset_mutex);

[Severity: Medium]
Does cpuset_attach() leave a stale task->dl.dl_bw_resv_cpu behind when it
takes the !attach_ctx.cpus_updated && !attach_ctx.mems_updated fast path?

In cpuset_can_attach(), dl_task_bw_reserve_cpu() runs whenever oldcs !=3D c=
s,
even if oldcs and cs have identical effective_cpus and effective_mems (for
example, when enabling +cpuset in cgroup.subtree_control or moving a task
between v2 cgroups with the same effective masks).  If the task's bandwidth
is currently counted in another root domain, dl_task_bw_reserve_cpu() sets
task->dl.dl_bw_resv_cpu =3D cpu.  In cpuset_attach(), the fast path:

kernel/cgroup/cpuset.c:cpuset_attach() {
    ...
	if (cpuset_v2() && !attach_ctx.cpus_updated && !attach_ctx.mems_updated) {
		llist_for_each_entry(cs, dst_cs_head.first, attach_node)
			cs->old_mems_allowed =3D attach_ctx.nodemask_to;
		goto out;
	}
    ...
}

jumps past cpuset_attach_task() to out:, where cpuset_free_dl_bw() releases
the reservation in cpuset_dl_bw, but dl_task_bw_unreserve() is never called
on the tasks in tset.

If that task is later part of a v2 threaded subtree attach where oldcs =3D=
=3D cs
for this thread while another thread in the taskset has oldcs !=3D cs and
cpus_updated =3D=3D true, cpuset_can_attach() skips this task, and
cpuset_attach_task() consumes the stale dl_bw_resv_cpu.  That moves the
task's bandwidth without a destination reservation and adds moved to
per_cpu(cpuset_dl_bw, cpu).moved, corrupting the root domain accounting and
underflowing b->sum - b->moved in cpuset_free_dl_bw().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 5503820c5b26c..b43106a590256 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -3657,10 +3676,64 @@ bool dl_task_needs_bw_move(struct task_struct *p,
>  	 * their bandwidth: dl_add_task_root_domain() leaves them out.
>  	 */
>  	if (!dl_task(p) || dl_entity_is_special(&p->dl) || !p->dl.dl_bw)
> -		return false;
> +		return -1;
> =20
>  	cpu =3D dl_task_root_domain_cpu(p);
> -	return !cpumask_intersects(cpu_rq(cpu)->rd->span, new_mask);
> +	if (cpumask_intersects(cpu_rq(cpu)->rd->span, new_mask))
> +		return -1;
> +	/*
> +	 * A task moved asleep is still on a CPU of the root domain it left.
> +	 * If the new mask holds that CPU, the task wakes up there.
> +	 */
> +	cpu =3D task_cpu(p);
> +	if (cpu_active(cpu) && cpumask_test_cpu(cpu, new_mask))
> +		return cpu;
> +	cpu =3D cpumask_first_and_and(new_mask, cpu_active_mask,
> +				    housekeeping_cpumask(HK_TYPE_DOMAIN_BOOT));
> +	if (cpu >=3D nr_cpu_ids)
> +		cpu =3D cpumask_any_and(new_mask, cpu_active_mask);
> +	return cpu < nr_cpu_ids ? (int)cpu : -1;
> +}

[Severity: High]
Can offline CPUs in def_root_domain.span cause __dl_task_bw_move_cpu() to
falsely return -1 when attaching a task to top_cpuset?

Every offline possible CPU is attached to def_root_domain (in sched_init()
and detach_destroy_domains()), as are CPUs isolated via isolcpus=3Ddomain or
isolated cpuset partitions.  When a task is attached to top_cpuset,
cpuset_attach_cpus() sets new_mask to task_cpu_possible_mask(task) &
~subpartitions_cpus, which includes all offline possible CPUs.

Because cpumask_intersects(cpu_rq(cpu)->rd->span, new_mask) does not mask
against cpu_active_mask, any system with an offline CPU in
cpu_possible_mask will see def_root_domain.span intersect new_mask on that
offline CPU (unless filtered out by p->user_cpus_ptr).  Moving a deadline
task whose bandwidth is in def_root_domain back to top_cpuset will then
return -1 here, skipping both the destination reservation and the bandwidth
move out of def_root_domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D23
