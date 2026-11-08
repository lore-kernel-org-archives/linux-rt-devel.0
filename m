Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166330;
	b=u6djcJHm3g3tdQE31cjggEDfR0myApfz4ItDoK3iaXjuOqBGkKRXiFdr7/XhZOSfIdF1
	 vgwzgEXxbn0RWHkfW4zs867Smb0PlcxVtGUUCU87UDzeC36yBuc//g+xLj9M0k8U/dnQx
	 +5OHenHWotMjHcGc4A6bxFQjVWaFBVqVvMmWUNTyFM497LZUZXOq3xVP7vVoIz5ItqBDF
	 NKmzdrhRl4q9tu+MRU7tzbqnzCZxFR2v/mhlv4Q7YxylFXh+Bt9fdoMY0ZKsjjS/GFsKM
	 H9ADJbq3x/R5Z1wu9Imck8m9M5AS9/d50p3JSof39S5ZncdQIcEwmhAL6kEBd6ejUqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166330;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H0KhdtJ508lIJ8z9fPM7Hp6z8VLh9WO5XJIlqHrGSeQ=;
	b=mKVmuYi58dzLKuezxsT+tcxAVjZXwT43ngJvtcA6lPaKXz6ZSncpgKOZ2nFcSwE25fio
	 mG2q+Dty4pR7qSUn4XNe70hx5KHb/N8mCGRN6XA9Gm5xtMIC9tgBhuMgWIByBa3qQ/by+
	 lQsztPti3OyeofTRRg/tYtF1dtgxBt2wWiZo/th4zKpvCrsuUq4p4FKMOutcTRDYS0L19
	 7dfnWdSoLEwqLHQP4+PwvKppPBYgLe7xNy1YD8KlJtFfHXNvu2v34ebNRo6UKb99Y1h+Y
	 9U6OCfnKhIzuFt1eiwk8aQt9DZCUYSRIlpSpo75e9i8/UlOI1qh8zGjvcvAIVjxUmqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BKdm/aR/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0BB606A323;
	Sun,  8 Nov 2026 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKdm/aR/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B031F008A4;
	Sun,  8 Nov 2026 19:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794166329;
	bh=H0KhdtJ508lIJ8z9fPM7Hp6z8VLh9WO5XJIlqHrGSeQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BKdm/aR/x97UNvlW/q08oNJJpTTrg81mh0jrtANQqOIZ3BToBUeu3ro/0PIMkeOIB
	 fZTbQo7tQ0u6GZJwOAu//wHwOxje9W+WIf/ZJwWcEyyhIo7noizeuH5F0lbLKTF4hW
	 k03nmtTCy6bS7cJYEJB7c+QFMsxdzPm8eh7xZ9oL1wSIIhByFZrpLkFaFwW6/QMu1I
	 UO1MYD/PcSrzETfmBCxGAzUCEcnTDe5PzhHzocDdB+mEYEXLOPWDjFb3g74lxPML6a
	 QtPhIrJ2LhyBjndXGLCxrt1/B6U1yO5leJFvNUzMnWL4Xn4hChX6pAECdPc+SncLZv
	 fX7XHAGtIULlg==
Message-ID: <sashiko-outbox-203956@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 21/29] cgroup/cpuset: Reserve the bandwidth in the
 root domain a task moves to
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261108185406.1549770-22-mathieu.desnoyers@efficios.com>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-22-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:32:09 +0000
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
- [Medium] sched/deadline: __dl_task_bw_move_cpu() skips move on
  spanning cpumask
- [Medium] sched/deadline: per-CPU reservation mismatch when task_cpu()
  changes
- [Medium] sched/core: equal cpumask early exit skips
  set_cpus_allowed_dl()
--

commit 3d21f1cc814c2706665d48f13e93dc3e9c2ac11e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

cgroup/cpuset: Reserve the bandwidth in the root domain a task moves to

This commit reserves SCHED_DEADLINE bandwidth per target CPU during cpuset
attach so that tasks moving into cpusets spanning multiple root domains or
retaining user affinity have their bandwidth accounted in the root domain
they actually move to.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3a538b42dcdd4..7df1ee4afb550 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3224,6 +3224,22 @@ static int __set_cpus_allowed_ptr_locked(struct ta=
sk_struct *p,
>  		goto out;
>  	}
> =20
> +	/*
> +	 * The caller made room for the deadline bandwidth of @p in the root
> +	 * domain of ctx->dl_bw_cpu. The new mask can span two root domains:
> +	 * keep @p in that one. Also wake a sleeping @p up on dest_cpu, since
> +	 * select_fallback_rq() could pick a CPU of the other one.
> +	 */
> +	if ((ctx->flags & SCA_DL_BW_RESERVED) &&
> +	    cpumask_test_cpu(ctx->dl_bw_cpu, cpu_valid_mask) &&
> +	    cpumask_test_cpu(ctx->dl_bw_cpu, ctx->new_mask)) {
> +		if (!cpumask_test_cpu(dest_cpu,
> +				      cpu_rq(ctx->dl_bw_cpu)->rd->span))
> +			dest_cpu =3D ctx->dl_bw_cpu;
> +		if (!task_on_rq_queued(p))
> +			p->wake_cpu =3D dest_cpu;
> +	}
> +
>  	do_set_cpus_allowed(p, ctx);
> =20
>  	return affine_move_task(rq, p, rf, dest_cpu, ctx->flags);

[Severity: Medium]
What happens when set_cpus_allowed_bw_reserved() is called for a task
whose p->cpus_mask already equals ctx->new_mask, while p->dl.dl_bw_cpu
still points to another root domain?

Earlier in __set_cpus_allowed_ptr_locked(), the cpumask_equal() check
returns early before reaching the SCA_DL_BW_RESERVED logic or
do_set_cpus_allowed():

kernel/sched/core.c:__set_cpus_allowed_ptr_locked() {
    ...
	if (!(ctx->flags & SCA_MIGRATE_ENABLE)) {
		if (cpumask_equal(&p->cpus_mask, ctx->new_mask)) {
			if (ctx->flags & SCA_USER)
				swap(p->user_cpus_ptr, ctx->user_mask);
			goto out;
		}
    ...
}

If an earlier unreserved affinity change (such as sched_setaffinity() to
isolated CPUs 1-2 while p->dl.dl_bw_cpu is on housekeeping CPU 0) already
set p->cpus_mask to {1, 2}, attaching the task to a cpuset where
cpus_attach is {1, 2} reserves bandwidth on CPU 1 in cpuset_can_attach().
__set_cpus_allowed_ptr_locked() then takes the goto out path without
calling set_cpus_allowed_dl(), leaving ctx->dl_bw_moved at 0.
cpuset_free_dl_bw() frees the new reservation on CPU 1 and the task's
bandwidth remains recorded in the old root domain on CPU 0.

[ ... ]

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0326527dd2d1e..8d9e55bca9439 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3558,6 +3558,9 @@ static unsigned int dl_task_root_domain_cpu(struct =
task_struct *p)
>  	return cpu;
>  }
> =20
> +static int __dl_task_bw_move_cpu(struct task_struct *p,
> +				 const struct cpumask *new_mask);
> +
>  static void set_cpus_allowed_dl(struct task_struct *p,
>  				struct affinity_context *ctx)
>  {
> @@ -3572,14 +3575,17 @@ static void set_cpus_allowed_dl(struct task_struc=
t *p,
>  	 * rebuild of the accounting. Moving it without room would leave no
>  	 * root domain counting it.
>  	 *
> +	 * The caller made room in the root domain of ctx->dl_bw_cpu, the CPU
> +	 * it expects the move to record. Move the bandwidth only if the move
> +	 * records that CPU. The affinity or the CPU of @p may have changed.
> +	 *
>  	 * Report in @ctx the bandwidth moved. The caller read the record
>  	 * without the runqueue lock, so it must count only what this reports.
>  	 */
>  	if ((ctx->flags & SCA_DL_BW_RESERVED) &&
> -	    dl_task_needs_bw_move(p, ctx->new_mask)) {
> +	    __dl_task_bw_move_cpu(p, ctx->new_mask) =3D=3D ctx->dl_bw_cpu) {
>  		unsigned int src_cpu =3D dl_task_root_domain_cpu(p);
>  		struct dl_bw *src_dl_b =3D &cpu_rq(src_cpu)->rd->dl_bw;
> -		unsigned int cpu;
> =20
>  		/*
>  		 * We now free resources of the root_domain we are migrating
> @@ -3593,12 +3599,8 @@ static void set_cpus_allowed_dl(struct task_struct=
 *p,
>  			raw_spin_unlock(&src_dl_b->lock);
>  		}
> =20
> -		/*
> -		 * cpuset_can_attach() made room in the root domain of the new
> -		 * mask. That root domain counts the bandwidth from now on.
> -		 */
> -		cpu =3D cpumask_any_and(ctx->new_mask, cpu_active_mask);
> -		p->dl.dl_bw_cpu =3D cpu < nr_cpu_ids ? (int)cpu : -1;
> +		/* Record the CPU the caller made room on. */
> +		p->dl.dl_bw_cpu =3D ctx->dl_bw_cpu;
>  		p->dl.dl_bw_gen =3D dl_bw_gen;
>  		ctx->dl_bw_moved =3D p->dl.dl_bw;
>  	}
> @@ -3606,8 +3608,15 @@ static void set_cpus_allowed_dl(struct task_struct=
 *p,
>  	set_cpus_allowed_common(p, ctx);
>  }
> =20
> -bool dl_task_needs_bw_move(struct task_struct *p,
> -			   const struct cpumask *new_mask)
> +/*
> + * Return the CPU that a move of @p to the CPUs of @new_mask records with
> + * its bandwidth. That is the CPU @p is on, if @p can stay there. Else it
> + * is the first active CPU of @new_mask, a housekeeping one if there is
> + * one. Return -1 if the bandwidth stays in the root domain that counts
> + * it. The caller holds the rq lock of @p.
> + */
> +static int __dl_task_bw_move_cpu(struct task_struct *p,
> +				 const struct cpumask *new_mask)
>  {
>  	unsigned int cpu;
> =20
> @@ -3617,10 +3626,39 @@ bool dl_task_needs_bw_move(struct task_struct *p,
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

[Severity: Medium]
Can __dl_task_bw_move_cpu() return -1 for a spanning new_mask even when
the task will be placed onto a CPU in a different root domain?

When cpu_rq(cpu)->rd->span intersects new_mask, __dl_task_bw_move_cpu()
returns -1 without checking where the task will actually run, and
cpuset_attach_task() then calls set_cpus_allowed_ptr() without
SCA_DL_BW_RESERVED.  Because __set_cpus_allowed_ptr_locked() only clamps
dest_cpu and p->wake_cpu to the bandwidth root domain when
SCA_DL_BW_RESERVED is set, the task is not kept in cpu_rq(cpu)->rd->span.

For example, with isolcpus=3Ddomain,1,2 (CPUs 1-2 in def_root_domain, CPUs 0
and 3 in the housekeeping root domain), if a task running on CPU 0 is
moved to a mask of {1, 2, 3}, cpu_rq(0)->rd->span ({0, 3}) intersects
{1, 2, 3} at CPU 3, so __dl_task_bw_move_cpu() returns -1.
__set_cpus_allowed_ptr_locked() can then pick CPU 1 or 2 via
cpumask_any_and_distribute() (or select_fallback_rq() on wakeup if the
task was sleeping on CPU 0), moving the task into def_root_domain while
its bandwidth stays accounted in the housekeeping root domain without
admission control in def_root_domain.

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

[Severity: Medium]
Can a wakeup or migration between cpuset_can_attach() and
set_cpus_allowed_dl() cause __dl_task_bw_move_cpu() to return a different
CPU in the same destination root domain and skip the bandwidth move?

Suppose task p sleeps on CPU 1 in root domain {0, 1, 2, 3} and was earlier
migrated while asleep into a partition on CPU 4, setting p->wake_cpu =3D 4
and p->dl.dl_bw_cpu =3D 4 while task_cpu(p) remains 1.  When p is moved back
to {0, 1, 2, 3}:

CPU0                              CPU1
cpuset_can_attach()
  dl_task_bw_move_cpu(p, {0..3})
    task_cpu(p) =3D=3D 1 -> returns 1
  reserves bw in cpuset_dl_bw[1]
                                  try_to_wake_up(p)
                                    set_task_cpu(p, 4)
cpuset_attach_task()
  dl_task_bw_move_cpu(p, {0..3})
    task_cpu(p) =3D=3D 4
    cpumask_first_and_and() -> 0
  cpuset_dl_bw[0].sum is 0
  set_cpus_allowed_ptr(p, ...)    <-- bw move skipped

Even though CPU 0 and CPU 1 belong to the same destination root domain,
matching on the exact CPU number misses the reservation in
cpuset_dl_bw[1] (and the same mismatch can happen between
cpuset_attach_task() and set_cpus_allowed_dl()).  cpuset_free_dl_bw() then
frees the reservation on CPU 1 and p's bandwidth remains recorded on CPU 4
in the source partition's root domain.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108185406.1549=
770-1-mathieu.desnoyers@efficios.com?part=3D21
