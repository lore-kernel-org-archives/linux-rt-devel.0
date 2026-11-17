Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929580;
	b=XLmzgl0QeiT6X3G9bgeoy8uJL4r9LmdhxeYkJ2xbzwdSKs989ycYIfwUeRXcWAJoDZcI
	 IJb3pckG5+BLPpRHYSTRKN/l4hXcYcRKHxER5R+9Zw6kwwUDZfiZaLr+ZPU2iO/5VMtKK
	 LpZ6R1J1zhBT3sUmWSlqR7ad0qMK0j6lIdI1A1EhXUdPOw/g0RlTi3r7ev+hI7x/lUxmJ
	 dihD91E4i0de9u1wTSb4LLoLuoh20IcIfnMo6GlHl1Az0gge3cyrDttOD+vh4nJ7gyyO0
	 8Qm6+s5tF31zMg4vwb8DQH2v79r6qABltNt8EG1WUZFhibdw67oENKocjTd7IpSvM2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929580;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2bfoJIlIIy5iLnYZGk3og+FlJiJ+PUUh9sRXWFXZJMo=;
	b=NmFnm62KAOVfmx4QsbUp6bW84dYCZTWu71lRez2GeotjgKOihE/c2zZX2GRzdV1gRjEw
	 JbdNAKgtlKqdXYCExOg5Kbybnn2dlYdQsLlLZ5c6YJGjflyEf2zxxjKP7g9mP6P32dDMK
	 M88GTMi75Oo+zYswgYGH1UzQ3OJNvVEiOlvoK1zGyTQGbwMmyVu2KWO03oN0/rEKu1ryQ
	 a/KDQ4nToK51sKmDoxOMtynG31HFuPtLVHflkAwZYWR86txk/SqYWH7OeKmtLUDl1Upyj
	 8PJoJ8CfvytPGA4JEy1p1Is/oX2SuIj7Bk9eXx0aaBXrxWNGP8KqkxMuf8wSVuWSykg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ico5QK7A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFF1606A31C;
	Tue, 17 Nov 2026 15:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ico5QK7A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0EC51F000C5;
	Tue, 17 Nov 2026 15:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929580;
	bh=2bfoJIlIIy5iLnYZGk3og+FlJiJ+PUUh9sRXWFXZJMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ico5QK7A4Y/8HHnaQqUz/7H+nVG5hyFFhJuhpxsnqAIKCKB6PFYf8CK/PAbuMUfVp
	 1oaJGOyoo37AYKfHda7pCXUQRx8nMUg2+AESubOJvXRIyTLsqiYl5Pu3KcQbXxlqnb
	 u/+l7Q1t4FyjwUHNmhYznsYg9il8UVcortwAoYmVE7ixX8T0EAD5WJTbH+34H5xqiF
	 8cEnlag4WCzYIMgk6c3OBg8tKr16X0LXWKixxGITPVtLjTx8CQObRi401HANWzoks4
	 iUG6AwWFgZCqKhNFAFA8+dJB7Ns1wbsSPV6ukNOezLHIBt7oEDJ3IVFSdhm3cxs3/q
	 YEQ6/WHWTZQNw==
Message-ID: <sashiko-outbox-219085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 28/40] sched/deadline: Keep a task in the root domain
 that counts its bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <2c1a48adf25ac3528a1f88632bda53826db5399e.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <2c1a48adf25ac3528a1f88632bda53826db5399e.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:32:59 +0000
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
- [Medium] sched/deadline: missing wake_cpu update in
  __set_cpus_allowed_ptr_locked()
- [Medium] sched/deadline: wrong root domain in
  dl_task_offline_migration() on rebuild
- [Medium] sched/deadline: missing READ_ONCE() on dl_bw_cpu in
  dl_task_rebuild_cpu()
--

commit fecf231094845bbb7da45c72106b5c90fffb123d
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep a task in the root domain that counts its bandwidth

This commit adds dl_task_bw_span() and updates CPU selection paths for
SCHED_DEADLINE tasks to prefer CPUs in the root domain that accounts for
the task's bandwidth.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index e9f80407f75be..dc270a23179d5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3264,6 +3264,23 @@ static int __set_cpus_allowed_ptr_locked(struct ta=
sk_struct *p,
>  			dest_cpu =3D ctx->dl_bw_cpu;
>  		if (!task_on_rq_queued(p))
>  			p->wake_cpu =3D dest_cpu;
> +	} else {
> +		const struct cpumask *span =3D dl_task_bw_span(p);
> +		unsigned int cpu =3D nr_cpu_ids;
> +
> +		/*
> +		 * No room was made for @p in another root domain. Keep @p
> +		 * in the root domain that counts its bandwidth, if the new
> +		 * mask holds one of its CPUs.
> +		 */
> +		if (span && !cpumask_test_cpu(dest_cpu, span))
> +			cpu =3D cpumask_first_and_and(cpu_valid_mask,
> +						    ctx->new_mask, span);
> +		if (cpu < nr_cpu_ids) {
> +			dest_cpu =3D cpu;
> +			if (!task_on_rq_queued(p))
> +				p->wake_cpu =3D dest_cpu;
> +		}
>  	}

[Severity: Medium]
Does this leave p->wake_cpu stale when cpumask_any_and_distribute()
already picked a dest_cpu inside span?

When cpumask_test_cpu(dest_cpu, span) is true, cpu stays at nr_cpu_ids and
p->wake_cpu is not updated for a sleeping task.  Because affine_move_task()
does not move sleeping tasks, p->wake_cpu remains on the old CPU (such as
an offlining housekeeping CPU during cpuset_hotplug_update_tasks()).  If p
then wakes up during the subsequent sched domain rebuild while
dl_task_bw_span(p) returns NULL, select_task_rq() and select_fallback_rq()
can place p on an isolated CPU in def_root_domain and move its bandwidth
without admission control.

Updating p->wake_cpu whenever span is non-NULL and dest_cpu is in span
(and !task_on_rq_queued(p)) would avoid this.

[ ... ]

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 6c6a4d9cd0548..e5f77d3c5fa03 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -901,18 +903,36 @@ static struct rq *find_lock_later_rq(struct task_st=
ruct *task, struct rq *rq);
> =20
>  static struct rq *dl_task_offline_migration(struct rq *rq, struct task_s=
truct *p)
>  {
> +	const struct cpumask *span;
>  	struct rq *later_rq =3D NULL;
>  	struct dl_bw *dl_b;
> =20
>  	later_rq =3D find_lock_later_rq(p, rq);
> +	/*
> +	 * find_lock_later_rq() looks in the root domain of @rq. Once @rq is
> +	 * offline, a rebuild attaches it to def_root_domain. That root domain
> +	 * may not count @p. Do not take @p out of the root domain that counts
> +	 * it while @p has an active CPU there.
> +	 */
> +	span =3D dl_task_bw_span(p);
> +	if (later_rq && span && !cpumask_test_cpu(later_rq->cpu, span) &&
> +	    cpumask_first_and_and(cpu_active_mask, p->cpus_ptr, span) < nr_cpu_=
ids) {
> +		double_unlock_balance(rq, later_rq);
> +		later_rq =3D NULL;
> +	}
>  	if (!later_rq) {
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
Can dl_task_offline_migration() still move a throttled task and its
bandwidth into def_root_domain when dl_task_timer() fires during a sched
domain rebuild?

CPU0                                     CPU1 (<hardirq>)
sched_cpu_deactivate(H)
  sched_set_rq_offline(rq_H)
  cpuset_cpu_inactive(H)
    partition_sched_domains_locked()
      dl_bw_rebuild_begin()
      detach_destroy_domains()
        cpu_attach_domain(def_rd, H)
                                         dl_task_timer(p)
                                           dl_task_offline_migration(rq_H, =
p)
                                             find_lock_later_rq() -> iso_rq
                                             dl_task_bw_span(p) -> NULL
                                             p->dl.dl_bw_cpu =3D iso_rq->cpu
      dl_rebuild_rd_accounting()
        dl_add_task_root_domain(p)
          dl_task_rebuild_cpu(p) -> iso_rq->cpu

While dl_bw_rebuild_seq is odd, rq_H is already attached to
def_root_domain, so find_lock_later_rq() searches def_root_domain (or
cpumask_any_and() picks the first active CPU in p->cpus_ptr, which can be
an isolated CPU).  Because dl_task_bw_span(p) returns NULL during the
rebuild, the check above does not reject the isolated later_rq.

Unlike migrate_task_rq_dl() and task_woken_dl(), which skip moving
bandwidth while dl_bw_rebuilding() is true, dl_task_offline_migration()
then unconditionally subtracts p->dl.dl_bw from src_rq->rd->dl_bw (which
can underflow total_bw before dl_clear_root_domains() runs), adds it to
def_root_domain, and overwrites p->dl.dl_bw_cpu with the isolated CPU.
Both the rebuild and later wakeups then treat def_root_domain as the root
domain that counts p.

[ ... ]

> @@ -3987,17 +4075,37 @@ static unsigned int dl_task_rebuild_cpu(struct ta=
sk_struct *p)
>  	 */
>  	cpumask_and(msk, &p->cpus_mask, cpu_active_mask);
>  	cpu =3D task_cpu(p);
> -	if (cpumask_test_cpu(cpu, msk) ||
> -	    (cpu =3D=3D recorded && cpu_active(cpu) && task_on_rq_queued(p)))
> +	if (cpu =3D=3D recorded && cpu_active(cpu) && task_on_rq_queued(p))
>  		return cpu;
>  	if (cpumask_empty(msk)) {
>  		if (recorded >=3D 0 && cpu_active(recorded))
>  			return recorded;
>  		dl_get_task_effective_cpus(p, msk);
>  		cpumask_and(msk, msk, cpu_active_mask);
> -	} else if (recorded >=3D 0 && cpumask_test_cpu(recorded, msk)) {
> -		return recorded;
>  	}
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

[Severity: Medium]
Should p->dl.dl_bw_cpu be read with READ_ONCE() when initializing recorded
in dl_task_rebuild_cpu()?

dl_add_task_root_domain() calls dl_task_rebuild_cpu(p) while holding only
p->pi_lock, before acquiring dl_departed_lock.  Concurrently, a dying
deadline task in its final __schedule() holds rq->lock and
dl_departed_lock (not p->pi_lock) and can write p->dl.dl_bw_cpu =3D -1 via
task_non_contending() -> dl_task_release_bw().  Because recorded is loaded
with a plain read and used after calling housekeeping_cpumask(), the
compiler is free to reload p->dl.dl_bw_cpu after the recorded >=3D 0 check
and pass -1 to cpumask_test_cpu().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D28
