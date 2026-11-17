Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929398;
	b=cmHv3WyFDX7o8uN6QVC1aCIGoyYglk/+qR82iw1vmSeY6Zca7xA5HpEPxkf4KxwPyg9J
	 /OqgeLqQ/WFR/gmT98vA/7BWRK0ghYxfbK7Zd5cwMOU2dQfXbRauo4o0T1rhFhhIP64dA
	 NCjw60Yaz4pMP/nmnx9vPb0NAVFnKRssk4YoSqkNt2RMCVA5+h/BkC1BjsmtWuoSrK2BZ
	 LXil8uLizY2n6AbVXIA/rY91y04IoRQIMI4ZhyDUHKjto+M+VTuIEWOU8HqYH58zHkmQS
	 whA2cNvlO/ILpkSz7GsTu/dIcr0pgTctYLzf466Wv/PXJ+cflAm8i58ldRDvfyl1YDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929398;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3CRbfO9EemqeArOWbykc5waMc6189YzNCo9OZd3FhSQ=;
	b=OXMhhSaB6csmTssCry0COzFKi2TwiM4a+nLdHh5DGCAF8g9j2XTkqZgciPGIxB+4t3OF
	 8gY1kr64QZE3D0gs/7qMtdmgcbmWeMIvZKdSS+aYENQjU8n1gK0DWYDWaPZ7C6KqyzoEO
	 uzuGe1urAbf4lUfs5KLnej2keT2TJUHg98CLDXuEd7qmO01CWTe6QkSvEih2IROhXZ+cv
	 TENIghDUqrUsFkSmZmXNLpiLJ0KpWLkyjiwyz1qLappdUphZ4AbHYCfUtn1sIVeipoYhz
	 9XWp0j3kd+KFm7JB45A6NJRUI+XjRRVcOFAexZiWmRSphFpMPYq1p6CJGezlyYpYDEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSFDykKE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B605606A31C;
	Tue, 17 Nov 2026 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSFDykKE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B821F000C4;
	Tue, 17 Nov 2026 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929398;
	bh=3CRbfO9EemqeArOWbykc5waMc6189YzNCo9OZd3FhSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RSFDykKEd0flVIBjF9Iz1TokFgHlPGa83uv9tVQZjHjR0c0ksqbYyQvEChXmfMq+/
	 DMNiB5zY3KQg/LD1h8GUo6OdI8L4XiLNfAPH3eCkPguTLe0aZZJKWO1X53uDVaoxAc
	 p8kwWerCchvR0ZA1NODsr26FFJeEeXuIaEHaDR0rfQhNMGTJwe++lLiEccxMGfYzmo
	 DKjU7qD4Lp7HglEL3ha8FpdbvW64DI1b1nFgm/8+RVP5xtwSeKVnIP2daP6PuVgEa8
	 2zi7mRqNayVDxJK8qw/HhAXXrFVG9a3MhJnbrfmHEhgK98opsZT3ioKxryBOuHTAQF
	 Oq5k8lBPL0SbQ==
Message-ID: <sashiko-outbox-219077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 27/40] sched/deadline: Move a task's bandwidth to the
 root domain it runs in
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <3292905cac4b511f515b4d353f02a41d747b8015.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <3292905cac4b511f515b4d353f02a41d747b8015.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:29:57 +0000
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
- [Medium] sched/deadline: dl_bw_rebuilding() drops bw moves during
  rebuild task walk
- [Medium] sched/deadline: migrate_task_rq_dl() drops bw move for
  mutex-blocked tasks
- [Medium] sched/deadline: dl_task_move_bw() moves departed bw of
  PI-boosted tasks
--

commit 00a2592b3e4a7ff7a78ebc503a680dacf59e846b
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Move a task's bandwidth to the root domain it runs in

This commit moves a deadline task's bandwidth to the root domain of its
new CPU in migrate_task_rq_dl() and task_woken_dl() when it differs from
the root domain that currently counts it, while suppressing moves during
sched domain rebuilds and proxy execution migrations.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 9ff79141c6306..6c6a4d9cd0548 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -2930,11 +2968,86 @@ select_task_rq_dl(struct task_struct *p, int cpu,=
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
> + * domains differ. The rebuild of the accounting
> + * that follows counts @p.
> + */
> +static bool dl_task_bw_elsewhere(struct task_struct *p, int cpu)
> +{
> +	int bw_cpu =3D READ_ONCE(p->dl.dl_bw_cpu);
> +
> +	if (bw_cpu < 0 || !p->dl.dl_bw || !cpu_active(cpu) || dl_bw_rebuilding(=
))
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
> +	if (cpu < 0 || dl_bw_rebuilding())
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
Can dl_task_move_bw() move the departing bandwidth of a non-deadline task
that was PI-boosted back into the deadline class?

When a task leaves SCHED_DEADLINE before its 0-lag time, switched_from_dl()
arms inactive_timer and leaves p->dl.dl_bw and p->dl.dl_bw_cpu set in the
original root domain.  As a non-deadline task (!task_has_dl_policy(p)), it
can move to another root domain without admission control, and if it is
then PI-boosted by a deadline waiter before its 0-lag time,
switched_to_dl() cancels the inactive timer and takes it off
dl_departed_list while keeping the original dl_bw_cpu recorded.

Because neither dl_task_bw_elsewhere() nor dl_task_move_bw() checks
task_has_dl_policy(p), waking or migrating the boosted task in the new root
domain subtracts p->dl.dl_bw from the original root domain before its
0-lag time and adds that unreserved bandwidth to the new root domain.

> +
> +static void migrate_task_rq_dl(struct task_struct *p, int new_cpu)
>  {
>  	struct rq_flags rf;
>  	struct rq *rq;
> =20
> +	/*
> +	 * The new CPU can be in another root domain than the one that counts
> +	 * the bandwidth. A mask can hold CPUs of two root domains, and
> +	 * select_fallback_rq() can widen it. Move the bandwidth there, as
> +	 * dl_task_offline_migration() does for a throttled task.
> +	 *
> +	 * Not for a task that is blocked on a mutex and only queued for
> +	 * proxy execution. It does not run on the new CPU, so its bandwidth
> +	 * stays in its root domain. If its wake-up then picks a CPU of another
> +	 * root domain, the bandwidth moves at that time.
> +	 */
> +	if (unlikely(dl_task_bw_elsewhere(p, new_cpu)) &&
> +	    !(p->is_blocked && task_on_rq_migrating(p)))
> +		dl_task_move_bw(p, new_cpu);

[Severity: Medium]
Does skipping dl_task_move_bw() when p->is_blocked && task_on_rq_migrating(=
p)
also drop the bandwidth move for normal queued migrations of mutex-blocked
tasks under CONFIG_SCHED_PROXY_EXEC?

When a mutex-blocked task (p->is_blocked =3D=3D 1) is migrated across root
domains by move_queued_task() or move_queued_task_locked() (for example
from __balance_push_cpu_stop() during CPU hotplug or push_dl_task()),
deactivate_task() sets p->on_rq =3D TASK_ON_RQ_MIGRATING and set_task_cpu()
updates both p->cpu and p->wake_cpu to new_cpu:

kernel/sched/core.c:move_queued_task() {
	...
	deactivate_task(rq, p, DEQUEUE_NOCLOCK);
	set_task_cpu(p, new_cpu);
	...
	activate_task(rq, p, 0);
}

When the mutex is unlocked, try_to_wake_up() sees p->on_rq =3D=3D TASK_ON_R=
Q_QUEUED
and takes ttwu_runnable():

kernel/sched/core.c:ttwu_runnable() {
	...
	if (p->is_blocked) {
		if (p->se.sched_delayed)
			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
		if (proxy_needs_return(rq, p))
			return 0;
	}
	...
	ttwu_do_wakeup(p);
	return 1;
}

Because task_cpu(p) =3D=3D p->wake_cpu, proxy_needs_return() returns false =
and
ttwu_runnable() finishes the wakeup in place without calling
migrate_task_rq_dl() or task_woken_dl(), leaving p's bandwidth counted in
the old root domain.

[ ... ]

> @@ -4068,8 +4192,10 @@ void dl_rebuild_rd_accounting(void)
>  	 * a resume run one for each CPU. A task gets a bandwidth under the
>  	 * locks this rebuild holds, so the count cannot leave 0 meanwhile.
>  	 */
> -	if (!atomic_read(&dl_nr_bw_tasks))
> +	if (!atomic_read(&dl_nr_bw_tasks)) {
> +		dl_bw_rebuild_end();
>  		return;
> +	}
> =20
>  	read_lock(&tasklist_lock);
>  	for_each_process_thread(g, p) {
> @@ -4083,6 +4209,7 @@ void dl_rebuild_rd_accounting(void)
>  			dl_add_task_root_domain(p);
>  	}
>  	read_unlock(&tasklist_lock);
> +	dl_bw_rebuild_end();
>  }

[Severity: Medium]
Can keeping dl_bw_rebuilding() true until the end of the tasklist walk
drop bandwidth moves for tasks that dl_add_task_root_domain() has already
visited?

During CPU deactivation, tasks are woken via select_fallback_rq() or pushed
by __balance_push_cpu_stop() while dl_rebuild_rd_accounting() walks
for_each_process_thread() under read_lock(&tasklist_lock):

CPU0                                    CPU1
partition_sched_domains_locked()
  dl_bw_rebuild_begin()
  ...
  dl_rebuild_rd_accounting()
    dl_clear_root_domains()
    read_lock(&tasklist_lock)
    for_each_process_thread(g, p)
      dl_add_task_root_domain(p)
        /* counts p in RD_A (or skips
         * p if cpu >=3D nr_cpu_ids) */
                                        try_to_wake_up(p)
                                          select_fallback_rq() -> cpu in RD=
_B
                                          set_task_cpu(p, new_cpu)
                                            migrate_task_rq_dl(p, new_cpu)
                                              dl_task_bw_elsewhere()
                                                dl_bw_rebuilding() =3D=3D t=
rue
                                                --> returns false (bw not m=
oved)
      /* still visiting later tasks */
    read_unlock(&tasklist_lock)
    dl_bw_rebuild_end()

Once dl_add_task_root_domain(p) releases p->pi_lock, p can wake up or
migrate to an active CPU in another root domain before the walk finishes.
Because dl_bw_rebuilding() is still true, migrate_task_rq_dl() and
task_woken_dl() ignore the move, leaving p's bandwidth counted in RD_A (or
uncounted if dl_task_rebuild_cpu(p) returned nr_cpu_ids).

In addition, when dl_task_bw_elsewhere() runs under rq->__lock without
p->pi_lock, it reads bw_cpu =3D READ_ONCE(p->dl.dl_bw_cpu) before checking
dl_bw_rebuilding() and READ_ONCE(dl_bw_gen), whereas
dl_add_task_root_domain() updates p->dl.dl_bw_cpu and p->dl.dl_bw_gen under
p->pi_lock and dl_departed_lock, so dl_task_bw_elsewhere() can compare
cpu_rq(bw_cpu)->rd using a stale bw_cpu read from before the rebuild ended.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D27
