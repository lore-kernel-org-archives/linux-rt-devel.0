Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806775;
	b=G9iI0yATpC9TlIH3wK/jfh8NCvaOvwyI06HLrqrx62/78s4bQeBDtHtSgNKSGNAcz/pW
	 PVIn7n966cUyzFOFTnUzQtrXkHBL4M4Hv9LtOv7/Kd1h0MGqrNOPNjuC1/HqMkg9yftkx
	 pjG3bC52h4A82zRMVwZrLiWSY9YIhBST2eAqCuub3/EJxYO9nMO7rtd097rKnmGTQZESk
	 kQdtMxZ2dl+8hziJEjAWrDWlBtHDkmy+62WNM3B6ojCb32YSj073WcWk85sfTsN2fWrLX
	 BKmTsGfqJAiCGNDLx8E376QuIAl1gdcaTcSA8LXeUBR1nTW94A57GgtbuqnN40N4eIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806775;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T2CB5lVQFP2GaFsIq1RNEBTm7G9oCk4Clet8hNatQtE=;
	b=4OAzuekW+4nXceoBz5WejWeFobrePiY8gjCDcup1MBzg7a2dBFN98Xodx/65Zj6tefHy
	 fRg7QS6M5nDY/R+jxDd0Le3sCEWfZN53vv9Xvu4jWFBnGSx4wTaoxfaLPFFpR8yzQDcdJ
	 MIfqkS2lahOjT9XSLyjKLO+GaDmef+/JvUwlaUiA8zHeTu9z4wtOk0bnabzEcoV0ajeVV
	 Vj7x85Rtqy/ycf2Ift4drbZDDKhWGY6EdPElZb2NoQsdA631Ro10oYpYFb/NT0jTis/eV
	 5kP8LjiWc0rXulntZaiztWjqrNybvM0SmT5qrnZwW6iOL5CkUXLJtPPc8vrFzMmbOaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sogmz4bH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649A7606D80B;
	Wed,  4 Nov 2026 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sogmz4bH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A8C1F000C1;
	Wed,  4 Nov 2026 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793806775;
	bh=T2CB5lVQFP2GaFsIq1RNEBTm7G9oCk4Clet8hNatQtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sogmz4bHK+SWVZ4/aX3vlTO75ToDTp3LB1rtn8t/oK8bOhwotonCAa0lH5qo4s/0+
	 OVc6zCTGUVx4ibUXpQ3yy8CcSBT+Fa00tzPmCzzhZPcOpefeYjFJ2TpO5jM5/eIKfx
	 Ej0ne9IkJM9T2vpT92LFyik3Ouhnqc2uY790BfquVe9pGWFvOSPFzcaa08TPYRILzW
	 33hFih0fdo0SXqlnEdWjU6+ARZHQWWwQqiyYwH55H9zHdgzqdPkXXpDOxMv4bPkKWb
	 PEaSmCRD4mjA4mV39KKGrzJUQGRJcwy57i5InVZy/+h1c7Vznbi5PPMVKumS5w6r5h
	 jTu6iGiWHDP/g==
Message-ID: <sashiko-outbox-197525@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 03/12] sched/deadline: Do not BUG() on a deadline task
 with no active CPU allowed
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <9cf4959749b84933fa506de5fc43b2dc0e02cd05.1793804635.git.mathieu.desnoyers@efficios.com>
References: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
 <9cf4959749b84933fa506de5fc43b2dc0e02cd05.1793804635.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:39:34 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched/deadline: stale root domain in dl_task_root_domain_cpu() fal=
lback
--

commit 1ac76c29bedf1013e2c606590748a52f51b1170b
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not BUG() on a deadline task with no active CPU allowed

This commit replaces the BUG_ON(cpu >=3D nr_cpu_ids) in
dl_task_root_domain_cpu() with a fallback to task_cpu(p) when a deadline
task's cpus_mask contains no active CPUs.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index dadda1a528ec6..30a52e42c26d8 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3338,13 +3338,19 @@ static void task_woken_dl(struct rq *rq, struct t=
ask_struct *p)
>   * current cpus_mask (not yet updated to the new mask) to find the
>   * actual root domain. Use cpus_mask rather than cpus_ptr, which
>   * may be temporarily narrowed by migrate_disable().
> + *
> + * The mask has no active CPU left when the CPUs it allows went offline,
> + * which the affinity of a deadline task allows with admission control
> + * off, and that of a task boosted into the deadline class by priority
> + * inheritance always: fall back to the CPU the task last ran on.
>   */
>  static unsigned int dl_task_root_domain_cpu(struct task_struct *p)
>  {
>  	unsigned int cpu;
> =20
>  	cpu =3D cpumask_first_and(&p->cpus_mask, cpu_active_mask);
> -	BUG_ON(cpu >=3D nr_cpu_ids);
> +	if (cpu >=3D nr_cpu_ids)
> +		cpu =3D task_cpu(p);
>  	return cpu;
>  }

[Severity: High]
When a deadline task's cpus_mask has no active CPUs left, can falling back
to task_cpu(p) in dl_task_root_domain_cpu() return an offline or stale CPU
whose root domain no longer holds p->dl.dl_bw?

For example, with admission control disabled (sched_rt_runtime_us =3D=3D -1=
),
suppose a SCHED_DEADLINE task p in top_cpuset is pinned via
sched_setaffinity() to CPU 1 (so p->cpus_mask is {1}), runs on CPU 1
(task_cpu(p) =3D=3D 1), and blocks.

When CPU 1 goes offline via sched_cpu_deactivate(), cpuset_handle_hotplug()
does not rewrite p->cpus_mask for tasks in top_cpuset, so p->cpus_mask
remains {1} and task_cpu(p) remains 1. During the domain rebuild:

  partition_sched_domains_locked()
    detach_destroy_domains() -> attaches offline CPU 1 to def_root_domain
    build_sched_domains() -> attaches remaining active CPUs to rd_active
    dl_rebuild_rd_accounting()
      dl_clear_root_domain() -> sets def_root_domain.dl_bw.total_bw =3D 0
      dl_add_task_root_domain(p)

In kernel/sched/deadline.c:dl_add_task_root_domain():

	msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
	dl_get_task_effective_cpus(p, msk);
	cpu =3D cpumask_first_and(cpu_active_mask, msk);
	BUG_ON(cpu >=3D nr_cpu_ids);
	rq =3D cpu_rq(cpu);
	dl_b =3D &rq->rd->dl_bw;

	raw_spin_lock(&dl_b->lock);
	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));

dl_get_task_effective_cpus() queries cpuset_cpus_allowed_locked(), so p's
bandwidth is accounted into rd_active->dl_bw.total_bw, whereas
cpu_rq(task_cpu(p))->rd is def_root_domain. (Similarly, if a sleeping
deadline task last ran on CPU A in partition A, was moved to a 1-CPU cpuset
on CPU B without waking up, and CPU B goes offline, task_cpu(p) still
points to CPU A in partition A.)

Because dl_task_root_domain_cpu(p) returns task_cpu(p) (CPU 1) while
p->cpus_mask has no active CPUs:

1. In switched_from_dl(), if p changes policy away from SCHED_DEADLINE
   while sleeping, __dl_sub() subtracts p->dl.dl_bw from
   def_root_domain.dl_bw.total_bw (underflowing it from 0) instead of
   rd_active->dl_bw.total_bw, leaking p->dl.dl_bw in rd_active.

2. In dl_task_needs_bw_move() and set_cpus_allowed_dl():

	cpu =3D dl_task_root_domain_cpu(p);
	return !cpumask_intersects(cpu_rq(cpu)->rd->span, new_mask);

   cpu_rq(1)->rd->span is def_root_domain.span, which contains only
   offline CPUs and does not intersect any new_mask of active CPUs.
   Updating p's affinity to active CPUs in rd_active via
   sched_setaffinity() or cpuset_cpus_allowed_fallback() causes
   dl_task_needs_bw_move() to return true and set_cpus_allowed_dl() to
   subtract p->dl.dl_bw from def_root_domain.dl_bw.total_bw. Moving p via
   cpuset_can_attach() and cpuset_attach_task() to a child cpuset in the
   same root domain rd_active causes cpuset_reserve_dl_bw() to add
   p->dl.dl_bw a second time to rd_active->dl_bw.total_bw while
   set_cpus_allowed_dl() subtracts from def_root_domain; moving p to a
   different partition subtracts from def_root_domain instead of rd_active,
   leaking p->dl.dl_bw in rd_active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793804635.gi=
t.mathieu.desnoyers@efficios.com?part=3D3
