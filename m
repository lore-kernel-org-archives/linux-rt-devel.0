Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121612;
	b=bVk0bv6xNHgwGk/Tb4xFwlUQLEu9x6Y50PXnvMys7gYr2OJVhqWddmbQpCa2a0pm15G5
	 v0xog5hAZhknhrrKb5rnjclFRraRNh9OniVoawVYjADGQp28nfRtHYL4sO6HhPV71KUh9
	 utSriBARNae1xoWgnuV+ZajqUPbHZOSS9w0tTaJuNIVCuWgCKkCLpVDW+tZ1kKEMGZEOJ
	 CZqOGUZm9PcEkmNWgpMPRQxqaifwrt3ZQ5WYKOWwdD/6p+iFLB705p/3WKnJe5Gmr+r4R
	 RVYdRzdglM87CiP2DkRO1cn5U5H8Bk5yKKJ8ctmbuQwSHz4Bub1go5Oq7Mt4Rro5WQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121612;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=doWgGKOldeOCmCMzpyTVuYzXWuhu5KUYxem7/mwt2dk=;
	b=DLnTY0HPgco+0OGkLDrFezxQM8oXM7prg1JviFTPICDXLw2ZBIgLQvkb/rnLg2mGRb75
	 k8IMCUyonhEuFHaWrsSxGz2vEE2xG/+ELb+Q4CM71BxaF3sEDq/uptie9sUUpxExU+hcD
	 eYCJm1RQnutOEqb0oF5+M9TCnBydoK6a36xTjEu+6qVu8vlhzyu8aSdfKI2I4DZIo0JQg
	 +NZCzc3BIcDnGagbJCbwvg041+6FyO7+k1yXa66WlVLscqolLd0gS+wRmf6KZ9PXgcmkf
	 theOVdMvYHnOTtVfCmDJxLSWTfZrCbQces1P3F4LR1RfxDcoJrdyJdvARTidokUTE6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlpoTEVX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8589606A902;
	Thu, 19 Nov 2026 20:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlpoTEVX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530F51F000C0;
	Thu, 19 Nov 2026 20:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121612;
	bh=doWgGKOldeOCmCMzpyTVuYzXWuhu5KUYxem7/mwt2dk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GlpoTEVXYU15jVKiG2/VH5nZ2i+iauceceEG/I8KQB1qofHjyeWnINUbp6u/xg+il
	 /HZU6LYrzyVeDZFHWUKINvkdjwOu5YhSLPipopx/lyZqx3OpGuJjNSTHz9w9AQY22l
	 P70xYOeXQagsz/SAhTCpHZ987gGuImF2dFADnLblnpe/wMD/jJACJ/fC5VrQlvNVAf
	 tq1LfeibXQa3o0cjlSUryOse/97FtLryjdZtCI9uVoa6YtQ6E26lzdkVucsdCXQTse
	 0jZoVTQKJlFQQ8I/Mgq81TRqDyR0z6z3qacNH/STGMzOO9gOJlW+7XCjwyv5hJWcaF
	 dyQsaxcg1WOzA==
Message-ID: <sashiko-outbox-224061@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/33] sched/deadline: Move a task's bandwidth to the
 root domain it runs in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <b4bddc11bb05352bb1eca11dd5e0060479aa2e5a.1795116791.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <b4bddc11bb05352bb1eca11dd5e0060479aa2e5a.1795116791.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:53:31 +0000
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
- [Medium] sched/deadline: dl_bw_move_blocked() drops bw of tasks
  skipped by walk
- [Medium] sched/deadline: task_woken_dl() moves bw to old rd on pinned
  wakeup
- [Medium] sched/deadline: dl_task_move_bw() moves departing bandwidth
  of PI-boosted task
--

commit 692ba1dcff2566600d665231dbe2bb9a5d88adc8
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Move a task's bandwidth to the root domain it runs in

This commit moves a deadline task's bandwidth in migrate_task_rq_dl() and
task_woken_dl() when the task migrates to or wakes up on an active CPU in a
root domain different from the one currently accounting its bandwidth, while
blocking moves during sched domain rebuilds and tasklist accounting walks.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index df55aba27ddc3..fb8f32a31cf91 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -268,6 +268,71 @@ static LIST_HEAD(dl_departed_list);
>  static DEFINE_RAW_SPINLOCK(dl_departed_lock);
>  static unsigned int dl_bw_gen;
> =20
> +/*
> + * Odd while the sched domains are rebuilt: from before the first CPU
> + * leaves its root domain until dl_clear_root_domains(). Meanwhile the
> + * CPUs change root domains one by one. Housekeeping CPUs pass through
> + * def_root_domain, next to the CPUs that isolcpus=3D"domain" isolates. =
So
> + * the root domain of the CPU recorded with a task says nothing about
> + * where its bandwidth is counted. The new root domains count no task
> + * yet.
> + *
> + * Changed under dl_departed_lock. dl_task_bw_elsewhere() reads it
> + * without the lock.
> + */
> +static unsigned int dl_bw_rebuild_seq;
> +
> +/*
> + * True while dl_rebuild_rd_accounting() walks the task list: from
> + * dl_clear_root_domains() until the walk ends. The root domains are fin=
al
> + * by then. A task the walk has not reached yet has a dl_bw_gen that is
> + * not current. Changed under dl_departed_lock. dl_task_bw_elsewhere()
> + * reads it without the lock.
> + */
> +static bool dl_bw_walking;
> +
> +/* Return true while the sched domains are rebuilt. */
> +static inline bool dl_bw_rebuilding(void)
> +{
> +	return READ_ONCE(dl_bw_rebuild_seq) & 1;
> +}
> +
> +/*
> + * Return true if the bandwidth of @p must not move now. Either the sched
> + * domains are rebuilt, or the walk of the task list that follows has not
> + * reached @p yet. The walk then counts @p. A move must not count it
> + * first.
> + *
> + * The answer is exact under dl_departed_lock. Without it, the answer is=
 a
> + * hint: dl_task_move_bw() tests again under the lock.
> + */
> +static inline bool dl_bw_move_blocked(struct task_struct *p)
> +{
> +	if (dl_bw_rebuilding())
> +		return true;
> +	return READ_ONCE(dl_bw_walking) &&
> +	       READ_ONCE(p->dl.dl_bw_gen) !=3D READ_ONCE(dl_bw_gen);
> +}

[Severity: Medium]
Can dl_bw_move_blocked() prevent a task that dl_add_task_root_domain()
already visited and skipped from adding its bandwidth when it falls back
to an active CPU before the tasklist walk finishes?

When dl_add_task_root_domain() visits a task that currently has no active
CPU in its mask, it returns early without updating p->dl.dl_bw_gen,
relying on a later move of the task to an active CPU to count its
bandwidth.  However, p->dl.dl_bw_gen !=3D dl_bw_gen leaves the skipped task
indistinguishable from a task that the walk has not reached yet:

CPU0                                  CPU1
dl_rebuild_rd_accounting()
  dl_clear_root_domains()
    dl_bw_gen++
    dl_bw_walking =3D true
  for_each_process_thread(g, p)
    dl_add_task_root_domain(p)
      dl_task_rebuild_cpu(p) >=3D nr_cpu_ids
      return (p->dl.dl_bw_gen !=3D dl_bw_gen)
                                      try_to_wake_up(p)
                                        select_fallback_rq() -> new_cpu
                                        migrate_task_rq_dl(p, new_cpu)
                                          dl_task_bw_elsewhere(p, new_cpu)
                                            dl_bw_move_blocked(p) -> true
                                        ttwu_do_activate()
                                          task_woken_dl(rq, p)
                                            dl_bw_move_blocked(p) -> true
    ... walks remaining tasks ...
  dl_bw_walk_end()
    dl_bw_walking =3D false             <-- p runs on new_cpu with bandwidth
                                          uncounted in new_cpu's rd

Because the walk has already passed p and both migrate_task_rq_dl() and
task_woken_dl() were blocked by dl_bw_move_blocked(), p runs in new_cpu's
root domain without its bandwidth counted there, allowing that root domain
to admit deadline tasks beyond its capacity.

[ ... ]

> @@ -2920,11 +2985,82 @@ select_task_rq_dl(struct task_struct *p, int cpu,=
 int flags)
>  	return cpu;
>  }
> =20
> -static void migrate_task_rq_dl(struct task_struct *p, int new_cpu __mayb=
e_unused)
> +/*
> + * Return true if the root domain of @cpu may not count the bandwidth of
> + * @p. Either another root domain counts it, or a rebuild left @p out.
> + * Test without dl_departed_lock, so that a move inside a root domain
> + * takes no lock. dl_task_move_bw() tests again under it.
> + *
> + * Return false if @cpu is not active. A migration-disabled task can wake
> + * up on a CPU that goes offline, after it joined the default root domai=
n.
> + * Keep the bandwidth where it is counted. balance_push() moves the task
> + * off that CPU once it enables migration, or its next wakeup does once
> + * the CPU is offline. That migration moves the bandwidth if needed.
> + *
> + * Return false while the sched domains are rebuilt. The CPUs then move
> + * to their new root domains one by one. That alone can make the two root
> + * domains differ. The rebuild of the accounting that follows counts @p.
> + * Return false also while that rebuild has not reached @p. Once it has
> + * counted @p, the root domains are final, and a move is right again.
> + */
> +static bool dl_task_bw_elsewhere(struct task_struct *p, int cpu)
> +{
> +	int bw_cpu =3D READ_ONCE(p->dl.dl_bw_cpu);
> +
> +	if (bw_cpu < 0 || !p->dl.dl_bw || !cpu_active(cpu) ||
> +	    dl_bw_move_blocked(p))
> +		return false;
> +	return READ_ONCE(p->dl.dl_bw_gen) !=3D READ_ONCE(dl_bw_gen) ||
> +	       cpu_rq(bw_cpu)->rd !=3D cpu_rq(cpu)->rd;
> +}
> +
> +/*
> + * Move the bandwidth of @p to the root domain of @new_cpu. Count it the=
re
> + * also if a rebuild left @p out. Add it even without room, since @p runs
> + * there. The caller holds the rq lock of @p, or its pi_lock for a wakeu=
p.
> + */
> +static void dl_task_move_bw(struct task_struct *p, int new_cpu)
> +{
> +	struct dl_bw *dl_b;
> +	int cpu;
> +
> +	if (dl_entity_is_special(&p->dl) || !p->dl.dl_bw)
> +		return;
> +
> +	guard(raw_spinlock)(&dl_departed_lock);
> +	cpu =3D p->dl.dl_bw_cpu;
> +	if (cpu < 0 || dl_bw_move_blocked(p))
> +		return;
> +	if (p->dl.dl_bw_gen =3D=3D dl_bw_gen) {
> +		if (cpu_rq(cpu)->rd =3D=3D cpu_rq(new_cpu)->rd)
> +			return;
> +		dl_b =3D dl_bw_of(cpu);
> +		raw_spin_lock(&dl_b->lock);
> +		__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
> +		raw_spin_unlock(&dl_b->lock);
> +	}
> +	dl_b =3D dl_bw_of(new_cpu);
> +	raw_spin_lock(&dl_b->lock);
> +	__dl_add(dl_b, p->dl.dl_bw, dl_bw_cpus(new_cpu));
> +	raw_spin_unlock(&dl_b->lock);
> +	p->dl.dl_bw_cpu =3D new_cpu;
> +	p->dl.dl_bw_gen =3D dl_bw_gen;
> +}

[Severity: Medium]
Can dl_task_bw_elsewhere() and dl_task_move_bw() move the departing
bandwidth of a non-deadline task that is PI-boosted back into
dl_sched_class before its 0-lag time?

When a task leaves SCHED_DEADLINE before its 0-lag time, p->dl.dl_bw
remains non-zero and p->dl.dl_bw_cpu records the original root domain
where its departing bandwidth must stay accounted until
inactive_task_timer() fires, as noted in switched_to_dl():

kernel/sched/deadline.c:switched_to_dl() {
    ...
	 * again. So take it off the list. The task keeps the CPU recorded. It
	 * takes the bandwidth from the root domain of that CPU, even if it
	 * moved to another root domain meanwhile.
    ...
}

Because neither dl_task_bw_elsewhere() nor dl_task_move_bw() checks
task_has_dl_policy(p), if that departed task moves to another root domain
under SCHED_OTHER and is PI-boosted into dl_sched_class before its 0-lag
time, waking or migrating it in the new root domain subtracts its
departing bandwidth from the original root domain early and adds it to the
new root domain without admission control.  Checking task_has_dl_policy(p)
in dl_task_bw_elsewhere() and dl_task_move_bw() would keep departing
bandwidth pinned to the original root domain.

[ ... ]

> @@ -3587,6 +3723,15 @@ static void pull_dl_task(struct rq *this_rq)
>   */
>  static void task_woken_dl(struct rq *rq, struct task_struct *p)
>  {
> +	/*
> +	 * A task can wake up on the CPU it slept on, with no migration,
> +	 * while another root domain counts its bandwidth. The bandwidth
> +	 * moved while the task slept out of its mask, and the mask then got
> +	 * that CPU back. Move the bandwidth to this root domain.
> +	 */
> +	if (unlikely(dl_task_bw_elsewhere(p, cpu_of(rq))))
> +		dl_task_move_bw(p, cpu_of(rq));

[Severity: Medium]
If a task sleeps inside a migrate_disable() section on an active CPU while
its affinity and bandwidth move to another root domain, does
task_woken_dl() move the bandwidth back to the old root domain when the
task wakes up on its pinned CPU?

When p blocks under migrate_disable() on active CPU B (in root domain B)
and cpuset_attach_task() -> set_cpus_allowed_dl() moves p->cpus_mask and
p->dl.dl_bw_cpu to root domain A while affine_move_task() waits for
migrate_enable(), waking p to finish its migrate_disable() section selects
CPU B via p->cpus_ptr without migration.  Because CPU B is still active
and dl_task_bw_elsewhere() does not check is_migration_disabled(p) or
whether the CPU is in p->cpus_mask, task_woken_dl() moves p's bandwidth
from root domain A back to root domain B.  That frees the reserved
bandwidth in root domain A before migrate_enable() migrates p to root
domain A and re-adds its bandwidth without admission control.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795116790.gi=
t.mathieu.desnoyers@efficios.com?part=3D14
