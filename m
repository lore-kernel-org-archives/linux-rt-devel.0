Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121711;
	b=VpKW/elIy2f2Mh5/+UDcsf1rXz/PRzXOmGdClAt/V6TblTZl8dCH+y1AKcTFL8+sAC9t
	 y7HJxczEIDSLtEnYLTSI546NWt8/PBER5abuyJGfCAZWgry16Ks94cmdD9HSaSsTlJwcZ
	 gbv5bGhabtHsrexb4J4czZnozChfbBTJk/b5ZhpTu4zk+g+8BnVwkcRiOf90WREXgYwah
	 e7ppUT2Dp7dTPNNE2rckUwONH7s4Gx9gB2Hc/JUXBd7/jEHEwS+XN6Z52cW5T0Fok0xP9
	 UGS0or82h35WkGKzXfyKr2/w6Wy4AQGpkvv+cyhdVSgl8+MxMW6oqxCJedSOWwjUadw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121711;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TeQbIYRy5vcxmDP5rydEZ6NPXJdYE2wEvzvwLrYJALQ=;
	b=4tN+EoKMRkU3PePyrMsTXTz/VyiujAyXpbV30bFmAZewvdCSJ0QtG1gprcs8jRIX5LLg
	 DPRdbdZkUHNI/E9wC8/KMgnRXGbJQf35Dfv47bcgp8++oS/TgDhRoz82eeuXAtV4nShCE
	 v3iHheQPiC/kgbgLI2+jBK6OOCblo3PjjKq5erd4TaowRSbftWLedMZ3jDCfudbhHlLDl
	 FT7un/78GJN0WmTQ/R+BwdDp1upun1h/vEo3aY8lbWVf4Akk5S0kEKrPLvOif3598WPhI
	 cbhx7bZ3ZTiJu7rPd3cYw1IpdmbJWpcP1AbSwLzjZIi6dVTELKHihB9zt3MG2eRP0sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOe0YnEA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6084606A325;
	Thu, 19 Nov 2026 20:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LOe0YnEA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181BF1F000C0;
	Thu, 19 Nov 2026 20:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121711;
	bh=TeQbIYRy5vcxmDP5rydEZ6NPXJdYE2wEvzvwLrYJALQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LOe0YnEA9Ja6sKzIKVL+yUFegBMCyx5LjeOM4vZ2V5v8QR82FcOe7Y/uZj8yT5Fdm
	 M8DK9A0Ndf/y52ehphyS8+URqDT0b1ZWpQsTFMECzPIIvVIgqXQTl7jFMfOD+MgRJ+
	 QDGERbKWUZ88lfX31wUd1gLR8vVxz6dGAgZZTJxtHaqP3N8BJ7KT7EaM0k+F+zG9Iy
	 gWj1LdfCmJqng89hXyO8wUosgDpKCDYMK3FyWLSEBqnamQEaqzZZ8GLwfkqm2yLByA
	 RNzpY2DdEPG2zWhE+zY2uFVvoisEQjfDRLqwwFDC6QNhAAQ6C3XQDV39aeVosD55Mh
	 Iv9qDZRXvNRbQ==
Message-ID: <sashiko-outbox-224072@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/33] sched/deadline: Keep a task in the root domain
 that counts its bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <35ed0190c119025d684ab89cd51e4805c7f7dbad.1795116791.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <35ed0190c119025d684ab89cd51e4805c7f7dbad.1795116791.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:55:10 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [Medium] sched/deadline: missing seqlock memory barriers in
  dl_task_bw_span()
- [Medium] sched/deadline: race on rd->span returned by
  dl_task_bw_span()
- [Medium] sched: select_fallback_rq() overwrites fallback mask when
  state is fail
- [Medium] sched/deadline: dl_task_offline_migration() ignores span when
  cpus_ptr inactive
- [Medium] sched/deadline: lost bandwidth in dl_task_offline_migration()
  during rebuild
- [Medium] sched/deadline: dl_task_bw_span() returns NULL for
  runtime-isolated CPUs
--

commit 13af0f791d03e3d95add27f78ad7796e24778c3d
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep a task in the root domain that counts its bandwidth

This commit adds dl_task_bw_span() and updates CPU selection and offline
migration paths to keep SCHED_DEADLINE tasks in the root domain that
accounts for their bandwidth.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7615ba02d52b3..fe2919be3775b 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c

[ ... ]

> @@ -3686,6 +3721,26 @@ static int select_fallback_rq(int cpu, struct task=
_struct *p)
>  	}
> =20
>  	for (;;) {
> +		/* The mask is wider now: look again in that root domain. */
> +		if (span && state !=3D cpuset) {
> +			for_each_cpu_and(dest_cpu, span, p->cpus_ptr) {
> +				if (is_cpu_allowed(p, dest_cpu))
> +					goto out;
> +			}
> +			/*
> +			 * The wider mask has no active CPU in that root
> +			 * domain. Allow the CPUs of the root domain instead.
> +			 * At an offline, the cpuset update comes next and sets
> +			 * the real mask.
> +			 */
> +			if (!span_forced && cpumask_intersects(span, cpu_active_mask) &&
> +			    cpumask_subset(span, task_cpu_possible_mask(p))) {
> +				span_forced =3D true;
> +				set_cpus_allowed_force(p, span);
> +				continue;
> +			}
> +		}
> +
>  		/* Any allowed, online CPU? */
>  		for_each_cpu(dest_cpu, p->cpus_ptr) {
>  			if (!is_cpu_allowed(p, dest_cpu))

[Severity: Medium]
Can this overwrite task_cpu_fallback_mask(p) with span when state is
already fail, and hit BUG() without ever scanning the fallback mask?

When cpuset_cpus_allowed_fallback(p) returns false (such as under cgroup
v1 or CONFIG_CPUSETS=3Dn), case cpuset falls through to case possible,
which installs task_cpu_fallback_mask(p) and sets state =3D fail.  On the
next iteration, state !=3D cpuset is true, so if span has no CPU in
task_cpu_fallback_mask(p) (for example, when span is def_root_domain.span
under isolcpus=3Ddomain), this block replaces p->cpus_mask with span and
continues with state =3D=3D fail.  If no CPU in span satisfies
is_cpu_allowed() on the following pass (for instance, an unbound deadline
kthread when the active CPU in span has cpu_dying() set), the loop
reaches case fail: BUG() without testing task_cpu_fallback_mask(p).

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index fb8f32a31cf91..c33e73e920ebb 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -927,18 +929,36 @@ static struct rq *find_lock_later_rq(struct task_st=
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
>  		if (cpu >=3D nr_cpu_ids) {
>  			/*
>  			 * Failed to find any suitable CPU.

[Severity: Medium]
What happens here when p->cpus_ptr has no active CPUs left, but span
still does?

In sched_cpu_deactivate(), set_cpu_active(cpu, false) and
sched_set_rq_offline() run before cpuset_cpu_inactive() widens the mask
of tasks in a cpuset whose last active CPU just went offline.  If
dl_task_timer() fires for a throttled task in that window, p->cpus_ptr
contains no active CPUs, so both cpumask_first_and_and() and
cpumask_any_and() fail.  Unlike select_fallback_rq(), this path does not
fall back to an active CPU in span; instead it triggers
WARN_ON_ONCE(dl_bandwidth_enabled()) and picks
cpumask_any(cpu_active_mask), which with isolcpus=3Ddomain,0,1 moves a
housekeeping task and its bandwidth to isolated CPU 0 in def_root_domain.

> @@ -981,8 +1001,15 @@ static struct rq *dl_task_offline_migration(struct =
rq *rq, struct task_struct *p
>  	 * moved to another cpuset while it was not running. If a rebuild
>  	 * dropped the bandwidth, there is nothing to move: the next rebuild
>  	 * counts it.
> +	 *
> +	 * Move nothing while the sched domains are rebuilt, or before the
> +	 * walk that follows has counted @p, as dl_task_move_bw() does. The
> +	 * CPU picked above then had no span to prefer. The walk counts @p
> +	 * on the side of the CPU recorded.
>  	 */
>  	scoped_guard (raw_spinlock, &dl_departed_lock) {
> +		if (dl_bw_move_blocked(p))
> +			break;
>  		if (p->dl.dl_bw_gen =3D=3D dl_bw_gen) {
>  			struct rq *src_rq =3D cpu_rq(dl_task_root_domain_cpu(p));

[Severity: Medium]
Can breaking out on dl_bw_move_blocked(p) leave p's bandwidth uncounted
after a rebuild?

If all CPUs in p->cpus_mask are inactive and dl_task_offline_migration()
moves a throttled task to an out-of-mask fallback CPU while a rebuild or
the task-list walk is in progress, skipping this block leaves
p->dl.dl_bw_cpu pointing at the offline CPU.  When dl_task_rebuild_cpu()
then visits p (or if the walk already passed p and left it uncounted with
p->dl.dl_bw_gen !=3D dl_bw_gen while dl_bw_walking is still true), the
check

	if (cpu =3D=3D recorded && cpu_active(cpu) && task_on_rq_queued(p))
		return cpu;

no longer matches, and p's bandwidth is never added to later_rq's root
domain.  This also contradicts the comment just below stating that
dl_task_offline_migration() counts the bandwidth when a rebuild left the
task out.

[ ... ]

> @@ -3757,6 +3799,61 @@ static unsigned int dl_task_root_domain_cpu(struct=
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
> + * Return NULL while the sched domains are rebuilt. The CPU recorded can
> + * then sit in def_root_domain on its way to a new root domain. The span
> + * of def_root_domain holds the isolated CPUs, and no longer the
> + * housekeeping CPUs that already left it. A caller would send a
> + * housekeeping task to an isolated CPU.
> + *
> + * Return NULL also for a task that the walk of the task list after the
> + * rebuild has not reached yet. Its dl_bw_gen is not current.
> + *
> + * The caller holds the pi_lock or the rq lock of @p. With interrupts
> + * off, the root domain is not freed.
> + */
> +const struct cpumask *dl_task_bw_span(struct task_struct *p)
> +{
> +	unsigned int seq =3D READ_ONCE(dl_bw_rebuild_seq);
> +	struct root_domain *rd;
> +	int cpu;
> +
> +	if (!task_has_dl_policy(p) || dl_entity_is_special(&p->dl) ||
> +	    !p->dl.dl_bw || (seq & 1))
> +		return NULL;
> +	cpu =3D READ_ONCE(p->dl.dl_bw_cpu);
> +	if (cpu < 0 || READ_ONCE(p->dl.dl_bw_gen) !=3D READ_ONCE(dl_bw_gen))
> +		return NULL;
> +	/*
> +	 * The CPU recorded can be going offline. It keeps its root domain
> +	 * until the rebuild attaches it to def_root_domain. The rebuild then
> +	 * records an active CPU with @p, or leaves @p out. Until then, the
> +	 * root domain of the CPU recorded still counts @p.
> +	 *
> +	 * A CPU that isolcpus=3D"domain" isolates is always in
> +	 * def_root_domain, which then counts @p. A housekeeping CPU that is
> +	 * not active and in def_root_domain was attached there by the
> +	 * rebuild. def_root_domain does not count @p then.
> +	 */
> +	rd =3D cpu_rq(cpu)->rd;
> +	/*
> +	 * A rebuild that started since writes rq->rd after it made
> +	 * dl_bw_rebuild_seq odd. Use this root domain only if none did.
> +	 */
> +	smp_rmb();
> +	if (READ_ONCE(dl_bw_rebuild_seq) !=3D seq)
> +		return NULL;

[Severity: Medium]
Are the sequence-counter memory barriers complete between
dl_task_bw_span() and dl_clear_root_domains()?

dl_task_bw_span() has no read barrier after reading seq before reading
dl_bw_gen and cpu_rq(cpu)->rd (which is also read without READ_ONCE()),
and dl_clear_root_domains() has no write barrier before incrementing
dl_bw_rebuild_seq from odd back to even:

kernel/sched/deadline.c:dl_clear_root_domains() {
    ...
	WRITE_ONCE(dl_bw_gen, dl_bw_gen + 1);
	WARN_ON_ONCE(!(dl_bw_rebuild_seq & 1));
	WRITE_ONCE(dl_bw_rebuild_seq, dl_bw_rebuild_seq + 1);
    ...
}

On weakly-ordered architectures, the loads and stores can reorder at the
end of a rebuild:

CPU0                                  CPU1
dl_task_bw_span()                     partition_sched_domains_locked()
  // reordered loads:                   detach_destroy_domains()
  // reads old dl_bw_gen =3D=3D 1             rq_attach_root()
  // reads mid-rebuild                      cpu_rq(cpu)->rd =3D &def_root_d=
omain
  //   rd =3D=3D &def_root_domain           ...
                                        dl_clear_root_domains()
                                          WRITE_ONCE(dl_bw_gen, 2)
                                          WRITE_ONCE(dl_bw_rebuild_seq, 2)
  seq =3D READ_ONCE(dl_bw_rebuild_seq) // 2
  smp_rmb()
  READ_ONCE(dl_bw_rebuild_seq) =3D=3D 2
  return rd->span;  <-- returns def_root_domain.span for housekeeping task

Using smp_load_acquire(&dl_bw_rebuild_seq) at the start of
dl_task_bw_span(), READ_ONCE(cpu_rq(cpu)->rd), and
smp_store_release(&dl_bw_rebuild_seq, dl_bw_rebuild_seq + 1) in
dl_clear_root_domains() would close this race.

> +	if (!cpu_active(cpu) && rd =3D=3D &def_root_domain &&
> +	    housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN_BOOT))
> +		return NULL;

[Severity: Medium]
Does this return NULL when an offlining CPU belongs to def_root_domain
through runtime cpuset isolation rather than boot-time isolcpus=3Ddomain?

CPUs in a cgroup v2 isolated partition (PRS_ISOLATED) or a cgroup v1
cpuset with sched_load_balance=3D0 are attached to def_root_domain while
active, so def_root_domain counts their tasks' bandwidth.  However,
housekeeping_update() only updates HK_TYPE_DOMAIN, leaving runtime-
isolated CPUs set in HK_TYPE_DOMAIN_BOOT.  When such a CPU goes offline,
between set_cpu_active(cpu, false) and the sched domain rebuild in
cpuset_cpu_inactive(), this check sees housekeeping_test_cpu(cpu,
HK_TYPE_DOMAIN_BOOT) =3D=3D true and returns NULL, allowing
select_fallback_rq() and __set_cpus_allowed_ptr_locked() to move the task
and its bandwidth out of def_root_domain without an admission test.

> +	return rd->span;
> +}

[Severity: Medium]
Is it safe for callers to read the live rd->span cpumask returned here
when they only hold p->pi_lock?

Checking dl_bw_rebuild_seq only verifies that no rebuild was running up
to the check.  Immediately after dl_task_bw_span() returns rd->span, a
rebuild can start on another CPU and rq_attach_root() will mutate
old_rd->span and def_root_domain.span in place:

CPU0                                  CPU1
select_fallback_rq()
  span =3D dl_task_bw_span(p)
    // returns rd->span
  ...
  set_cpus_allowed_force(p, span)
    ...
      set_cpus_allowed_common()
        cpumask_copy(&p->cpus_mask,
                     ctx->new_mask)
                                      partition_sched_domains_locked()
                                        dl_bw_rebuild_begin()
                                        detach_destroy_domains()
                                          rq_attach_root()
                                            cpumask_clear_cpu(..., old_rd->=
span)
        p->nr_cpus_allowed =3D
          cpumask_weight(ctx->new_mask)  <-- mismatches p->cpus_mask

Besides desynchronizing p->nr_cpus_allowed from p->cpus_mask, callers can
observe housekeeping CPUs transiently set in def_root_domain.span as
detach_destroy_domains() moves them through def_root_domain, placing an
isolated task on a housekeeping CPU without admission control.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795116790.gi=
t.mathieu.desnoyers@efficios.com?part=3D15
