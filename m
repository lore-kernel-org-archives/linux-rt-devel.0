Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806392;
	b=ypx8F7q14LuWGQyzanms9/M5Uq4BhReg03iK4F2br3mzNHJH3Ft/QzmxkYjyVJPky5oZ
	 28gDgE5ANLQuMsaVFRZfJawAJlq/OOtvQ7/OiiXTKxEWv5Ysnb0Bbe23xIFK0e9FuTAFT
	 0Lrc41UBNI8b+iZkAg+qzmO2myrTsWE5IRMa800QVLrWCmK+fFZ0xu6VaT+5VcTToBq56
	 Gz4M4bahO89oafkP2OLKqrzzcIRA8Xcbm5/VPsUy/mBxqdkiYJnPAOvK9r3B/t6BMXCMp
	 l0rlxt6LKXbSV6cmA3jjNs9zv/n/+tyazeuuJ3pmx8DFYkptX6XcghuJ5HPFz2zmE2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806392;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ijgGCnSqrjIVk6YkV/Tk0OCRls1u+aL1OVhTRnPDVEw=;
	b=DhJz8oCm8jt2j0RHAob8rtSW3dIq+4SlNRFBUq14RIPNPgK44dhZp0/sXgol8te6rVFR
	 oAKDDQWhgHbBjME+sD+mLV0y2LbtrLCEqssVcHVxyMgI05Jr8SqUDZLgsXbGpka7rwUsH
	 mnvk83K6+/DOK/LXOF1K1XRzyKf7tpxYrV+OA1pVkDyboW3ApdYOFAv0vUwwKWtEHX7/A
	 LAOsHasJVcUT8/Eko+V76BQE+gh7EhYQYDVIECTRWluatCdp+/oUlO6uUp5r1dEUu8gW/
	 8mSAEGNK49WkKyJjtad2mm3IcGlj1T1HbJBi1BPKqb7gKahFY3XRNPaorij3ypdovRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UanPt8Ab;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A503606A31B;
	Wed,  4 Nov 2026 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UanPt8Ab
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62461F00A15;
	Wed,  4 Nov 2026 15:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793806392;
	bh=ijgGCnSqrjIVk6YkV/Tk0OCRls1u+aL1OVhTRnPDVEw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UanPt8Ab3aWe29Kx9mDWZ326Rw/aPLRuEWwsuAdv9JZhC43Tnn5jJh+ZlYqvkOrb2
	 5JeVBI5fLe3ioSUGZJ0zPWZ4h81II/x2fLCfjITa0CryrCtgjAnfAzLyEv3zzC5AcG
	 EfWSQKqWgWOpZLbdk1aZQGSbjOSvfL9Ks1+1Um98P1sSzgRUpCj8R4llYET/MexYfk
	 v97TOqa2gYSgPqlRoh/d6KMwHtrclOCbiXka50GvrdOkGPPch2pSMIwphqL5Q5Ldrj
	 GA5km1M+1R4LWW4h/T4TYRuBtLZkutyXneDvAkzpFAkmh43adH+DQ8lU5x5ts84jw9
	 UnmBsQp2EFqqA==
Message-ID: <sashiko-outbox-197510@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] sched/deadline: Do not release a departing
 sleeper's bandwidth twice
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <21f538f65f013a71920547ac92c76ca8ba544d19.1793804635.git.mathieu.desnoyers@efficios.com>
References: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
 <21f538f65f013a71920547ac92c76ca8ba544d19.1793804635.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:33:11 +0000
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
- [High] sched/deadline: infinite loop in replenish_dl_entity() on PI donor=
 clear
--

commit 0ea45c3b24aa9d9591791893080fc323c30a9de8
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not release a departing sleeper's bandwidth twice

This commit prevents switched_from_dl() from releasing root domain bandwidth
for tasks without their own deadline parameters or special sugov entities, =
and
clears the deadline parameters after releasing a departing sleeper's bandwi=
dth
so it cannot be released a second time.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d474fbfd9be6d..3c57e5f5fc056 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3567,6 +3567,8 @@ static void switched_from_dl(struct rq *rq, struct =
task_struct *p)
>  	dec_dl_tasks_cs(p);
> =20
>  	if (!task_on_rq_queued(p)) {
> +		bool released =3D false;
> +
>  		if (p->dl.dl_non_contending) {
>  			/*
>  			 * Inactive timer is armed. However, p is leaving
> @@ -3579,12 +3581,18 @@ static void switched_from_dl(struct rq *rq, struc=
t task_struct *p)
>  			 * release total_bw via __dl_sub().
>  			 */
>  			sub_running_bw(&p->dl, &rq->dl);
> -		} else {
> +		} else if (p->dl.dl_runtime && !dl_entity_is_special(&p->dl)) {
>  			/*
>  			 * No pending inactive timer: the task never ran as
>  			 * DEADLINE or the timer already fired while still
>  			 * DEADLINE (only dropping running_bw at that time).
>  			 * Nobody else will release total_bw, do it now.
> +			 *
> +			 * Not for a task without parameters of its own, one
> +			 * deboosted from priority inheritance, whose mask may
> +			 * have no active CPU for dl_task_root_domain_cpu(),
> +			 * nor for a special one: neither has bandwidth in
> +			 * total_bw.
>  			 */
>  			unsigned int cpu =3D dl_task_root_domain_cpu(p);
>  			struct dl_bw *dl_b =3D &cpu_rq(cpu)->rd->dl_bw;
> @@ -3592,8 +3600,20 @@ static void switched_from_dl(struct rq *rq, struct=
 task_struct *p)
>  			raw_spin_lock(&dl_b->lock);
>  			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
>  			raw_spin_unlock(&dl_b->lock);
> +			released =3D true;
>  		}
>  		sub_rq_bw(&p->dl, &rq->dl);
> +		/*
> +		 * Released: reset the parameters, as inactive_task_timer()
> +		 * does. Kept, they would make the task one with bandwidth to
> +		 * task_contending() and task_non_contending() once priority
> +		 * inheritance boosts it, and a deboost while it sleeps would
> +		 * release that bandwidth again. So would the inactive timer's
> +		 * handler when it runs late, dl_non_contending cleared under
> +		 * it by migrate_task_rq_dl(): it finds !dl_task(p).
> +		 */
> +		if (released)
> +			__dl_clear_params(&p->dl);

[Severity: High]
Can calling __dl_clear_params(&p->dl) in switched_from_dl() cause an infini=
te
loop in replenish_dl_entity() when p is blocked on an rt_mutex and acting as
the priority inheritance donor for the lock owner?

If a non-deadline owner holds an rt_mutex and a SCHED_DEADLINE task p blocks
on it as the top waiter, task_blocks_on_rt_mutex() -> rt_mutex_setprio() se=
ts
owner->dl.pi_se =3D &p->dl and places the owner into dl_sched_class.

If p's 0-lag time has already elapsed while p sleeps on the lock (so
p->dl.dl_non_contending =3D=3D 0) and p is switched to another policy via
__sched_setscheduler() in kernel/sched/syscalls.c, switched_from_dl() runs
inside the sched_change guard before rt_mutex_adjust_pi(p) is called:

    scoped_guard (sched_change, p, queue_flags) {
        /* sched_change_begin() -> switched_from_dl() */
        ...
    }

    preempt_disable();
    head =3D splice_balance_callbacks(rq);
    task_rq_unlock(rq, p, &rf);

    if (pi) {
        if (cpuset_locked)
            cpuset_unlock();
        rt_mutex_adjust_pi(p);
    }

At that point __dl_clear_params(&p->dl) zeroes p->dl.dl_runtime,
p->dl.dl_deadline, and p->dl.dl_period while the lock owner still has
owner->dl.pi_se pointing to &p->dl.

Even once rt_mutex_adjust_pi(p) calls rt_mutex_setprio() in
kernel/sched/core.c to deboost the owner, sched_change_begin() dequeues and
updates the owner before resetting owner->dl.pi_se:

    scoped_guard (sched_change, p, queue_flag) {
        /* sched_change_begin() -> dequeue_task_dl() -> update_curr_dl() */
        ...
        } else {
            if (dl_prio(oldprio))
                p->dl.pi_se =3D &p->dl;

If the boosted owner exhausts its runtime (or yields) either concurrently on
another CPU before rt_mutex_adjust_pi(p) runs, or during the dequeue in
rt_mutex_setprio(), update_curr_dl_se() sees is_dl_boosted(&owner->dl) and
calls:

    enqueue_task_dl(rq, owner, ENQUEUE_REPLENISH)
      -> enqueue_dl_entity()
        -> replenish_dl_entity(&owner->dl)

In kernel/sched/deadline.c:replenish_dl_entity(), pi_of(dl_se) still resolv=
es
to &p->dl where dl_runtime and dl_period are now 0:

    WARN_ON_ONCE(pi_of(dl_se)->dl_runtime <=3D 0);
    ...
    while (dl_se->runtime <=3D 0) {
        dl_se->deadline +=3D pi_of(dl_se)->dl_period;
        dl_se->runtime +=3D pi_of(dl_se)->dl_runtime;
    }

Wouldn't this trigger the warning and spin forever with the runqueue lock
held and interrupts disabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793804635.gi=
t.mathieu.desnoyers@efficios.com?part=3D5
