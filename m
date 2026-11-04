Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793832269;
	b=ztstOPMgJ1ozBOg230DrZVL8YzZGQUj2Rx/5Ig43hss1bwEfNQo0VVU1XO+iu0+wlxQv
	 lx4PRUkg6CNYbPt2p2oQ18SPJBkrwE4qJ76PXcYVvsbeU5IH45DYJ2OAxDarkeF6gHuVT
	 DWjNMdDGgfNZfUPq7z3MBnOS0rlVAyUv6HdANZu2YeiGoukjSnY35EhA4ARl4G7j1UhST
	 XEm3y88ZSHVqIap5b1svcHSSOON1KbVdgjfx+Mwri5J9dK0h5csSCedQvCzIUWPryT0Rk
	 57DdnHM6/WKO0pD37IBl2qbVw+Inu3lQUABqgJE5FObW0Lud/MF4MyaEXxmWHKA65Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793832269;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Q8QJSTYLWOmcirwSrHJZlqljESPHG1DSVnqXXWP28rw=;
	b=WxwXTG65tplr5GDT+l0B+529KLpiOUAMplRV44aNmGWIT0ptQZJ2v5ajhO0VofOS92pl
	 MiQgtBIwTDrG5W9bvLUQS2h+rGjW+BMgeAUjRqyK++Ac85BUIDzraj4DHeFjuP31yYO75
	 bXtEyIx6H39CCfRNZxSgkG/DY351cHVUIg7EvosMdFVyXVNfFB7tEkw2Ic1CH1JsVv/9I
	 1h81Q76G4C0Qzu8naFIoFGSd1u4Z8Yq4ZnQXoLVZc+9o5EAFWy9h3L5qqNMLxNweRomVu
	 ztrjfFst36UjSk9msfzekwEYV5XXz984Hd8ARtrnqNXJH6KXjKLLzaKg8bmDmM/e68w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgR2MXI0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D83606A31B;
	Wed,  4 Nov 2026 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgR2MXI0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19E11F000C1;
	Wed,  4 Nov 2026 22:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793832269;
	bh=Q8QJSTYLWOmcirwSrHJZlqljESPHG1DSVnqXXWP28rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SgR2MXI0Ux0iW6D5ZOIN+Nzk4OX/tfUY3z4dtXQAiuPTa25DRhCNnTE+GggtI/Nv0
	 Gn1Okq0FaTeMkGyqSGu8T8+++4g2+h+6ZFrBJo02o04sE3ubcnQL7rmew0o0PFpmkw
	 XCI71UWV6a9KzTOu4G/u+y8V3eK2W67j/p1F5LdsSs26zD0guFtIIpjdX+NNB3t4sD
	 LlrOrfDX1DBuwmsAF/gW/boirf9OrTb15Ev08kcL+SqD9GSaBDXhTM7D0PfBIUhZH1
	 3+gXzg45MTSmPvTDKpsGrwEg+Rp6pzDYGtMiUgQTrmSF02afvCGt7j0Irg5vey9TID
	 3TRE1wWwG8oHg==
Message-ID: <sashiko-outbox-198243@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/21] sched/deadline: Keep departing bandwidth
 across a root domain rebuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261104211207.1392343-10-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-10-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 22:44:28 +0000
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
- [High] sched/deadline: departing bandwidth accounting corrupted in switch=
ed_to_dl() on PI boost
--

commit 1e8adcf8ed2712137f083c0716509491291e2298
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep departing bandwidth across a root domain rebuild

This commit tracks tasks that leave SCHED_DEADLINE or exit before their
0-lag time on dl_departed_list along with the CPU of their root domain and a
rebuild generation counter. This preserves their departing bandwidth across
dl_rebuild_rd_accounting() and ensures inactive_task_timer() removes the
bandwidth from the original root domain even if the task migrates.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 624cabdec9652..2729c108b24bc 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -3485,12 +3575,33 @@ void dl_add_task_root_domain(struct task_struct *=
p)
>  	dl_get_task_effective_cpus(p, msk);
>  	cpu =3D cpumask_first_and(cpu_active_mask, msk);
>  	BUG_ON(cpu >=3D nr_cpu_ids);
> +
> +	raw_spin_lock(&dl_departed_lock);
> +	/*
> +	 * Counted already by this rebuild: put back by
> +	 * dl_clear_root_domains() as a departed task, which priority
> +	 * inheritance boosted into the class since, or its bandwidth
> +	 * gone since (dl_task_release_bw()), as that of one that died
> +	 * after the walk found it. One that died since with its 0-lag
> +	 * time ahead goes back to the root domain of the CPU recorded
> +	 * (dl_task_depart()), if active.
> +	 */
> +	if (p->dl.dl_bw_gen =3D=3D dl_bw_gen)
> +		goto unlock;
> +	if (p->dl.dl_departed_cpu >=3D 0) {
> +		cpu =3D p->dl.dl_departed_cpu;
> +		if (!cpu_active(cpu))
> +			goto unlock;
> +	}
>  	rq =3D cpu_rq(cpu);
>  	dl_b =3D &rq->rd->dl_bw;
> =20
>  	raw_spin_lock(&dl_b->lock);
>  	__dl_add(dl_b, p->dl.dl_bw, cpumask_weight(rq->rd->span));
>  	raw_spin_unlock(&dl_b->lock);
> +	p->dl.dl_bw_gen =3D dl_bw_gen;
> +unlock:
> +	raw_spin_unlock(&dl_departed_lock);
>  	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
>  }

[ ... ]

> @@ -3584,7 +3731,7 @@ static void switched_from_dl(struct rq *rq, struct =
task_struct *p)
>  			 * or sub_rq_bw (below) will complain.
>  			 *
>  			 * inactive_task_timer() will find !dl_task(p) and
> -			 * release total_bw via __dl_sub().
> +			 * release total_bw (dl_task_release_bw()).
>  			 */
>  			sub_running_bw(&p->dl, &rq->dl);
>  		} else if (p->dl.dl_runtime && !dl_entity_is_special(&p->dl)) {
> @@ -3600,12 +3747,7 @@ static void switched_from_dl(struct rq *rq, struct=
 task_struct *p)
>  			 * nor for a special one: neither has bandwidth in
>  			 * total_bw.
>  			 */
> -			unsigned int cpu =3D dl_task_root_domain_cpu(p);
> -			struct dl_bw *dl_b =3D &cpu_rq(cpu)->rd->dl_bw;
> -
> -			raw_spin_lock(&dl_b->lock);
> -			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(cpu));
> -			raw_spin_unlock(&dl_b->lock);
> +			dl_task_release_bw(p, dl_task_root_domain_cpu(p));
>  			released =3D true;
>  		}
>  		sub_rq_bw(&p->dl, &rq->dl);

[ ... ]

> @@ -3657,6 +3809,16 @@ static void switched_from_dl(struct rq *rq, struct=
 task_struct *p)
>  static void switched_to_dl(struct rq *rq, struct task_struct *p)
>  {
>  	cancel_inactive_timer(&p->dl);
> +	/*
> +	 * Boosted back into the class before its 0-lag time (a policy change
> +	 * released that bandwidth in sched_dl_overflow()): the inactive
> +	 * timer will not remove it, but its leaving the class again. That
> +	 * forgets the CPU recorded: moved to another root domain meanwhile,
> +	 * the task then removes the bandwidth from that one, as it did
> +	 * before departures were recorded.
> +	 */
> +	if (p->dl.dl_departed_cpu >=3D 0)
> +		dl_task_undepart(p);

[ ... ]

> @@ -3924,6 +4078,19 @@ int sched_dl_overflow(struct task_struct *p, int p=
olicy,
>  	}
>  	raw_spin_unlock(&dl_b->lock);
> =20
> +	/*
> +	 * Back before its 0-lag time, the task still has the bandwidth it
> +	 * left with, which the new one replaces: removed from the root
> +	 * domain that keeps it (dl_task_release_bw()). A rebuild cannot
> +	 * run meanwhile: the caller holds cpuset_mutex.
> +	 */
> +	if (!err && dl_policy(policy) && !task_has_dl_policy(p)) {
> +		lockdep_assert_cpuset_lock_held();
> +		if (p->dl.dl_departed_cpu >=3D 0)
> +			dl_task_release_bw(p, -1);
> +		p->dl.dl_bw_gen =3D dl_bw_gen;
> +	}

[Severity: High]
As reported by Sashiko on v1 [1], can priority-inheritance boosting of a
departed task before its 0-lag time corrupt root-domain total_bw accounting?

When a SCHED_DEADLINE task p switches to a non-deadline policy such as
SCHED_OTHER before its 0-lag time, switched_from_dl() arms inactive_timer,
clears p->dl.dl_non_contending, keeps p->dl.dl_runtime and p->dl.dl_bw, and
calls dl_task_depart() to record the CPU of its original root domain (RD_A)
and link p onto dl_departed_list. If p holds an rt_mutex and is boosted into
dl_sched_class via rt_mutex_setprio() before its 0-lag time,
switched_to_dl() calls cancel_inactive_timer(&p->dl) and
dl_task_undepart(p), unlinking p from dl_departed_list and resetting
p->dl.dl_departed_cpu to -1 in this commit.

In this commit, resetting p->dl.dl_departed_cpu to -1 causes
sched_dl_overflow() to skip dl_task_release_bw() if p is setscheduled back
to SCHED_DEADLINE while boosted, leaking the old p->dl.dl_bw in RD_A, and
causes switched_from_dl() on deboost after a migration to RD_B to subtract
p->dl.dl_bw from RD_B instead of RD_A.

Later commits in the series ("sched/deadline: Record the root domain holding
a task's bandwidth" and "sched/deadline: Count the bandwidth a boosted task
is given") replace dl_departed_cpu with dl_bw_cpu (preserving dl_bw_cpu
across dl_task_undepart()) and update rq->dl.this_bw in __setparam_dl().
However, even with those later commits applied, don't the following three
scenarios still corrupt bandwidth accounting when a departed task is
PI-boosted before its 0-lag time?

1. If p migrates to another cpuset partition / root domain (RD_B) while in
SCHED_OTHER (!dl_task(p)), cpuset_can_attach() does not reserve or move
p->dl.dl_bw into RD_B, so p->dl.dl_bw remains in RD_A. If p is then
PI-boosted in RD_B, switched_to_dl() calls dl_task_undepart(p) and unlinks
p->dl.dl_departed_node from dl_departed_list. If dl_rebuild_rd_accounting()
runs while p is PI-boosted, dl_clear_root_domains() does not see p on
dl_departed_list, and dl_add_task_root_domain(p) sees that p is not on
dl_departed_list (list_empty(&p->dl.dl_departed_node), or
p->dl.dl_departed_cpu < 0 here). Doesn't dl_add_task_root_domain(p) then
ignore the recorded CPU in RD_A and add p->dl.dl_bw to RD_B (via
dl_get_task_effective_cpus()), dropping p's departing bandwidth from RD_A
before its 0-lag time and charging RD_B without admission control?

2. Because rt_mutex_setprio() only holds p->pi_lock and rq->__lock (not
cpuset_mutex or dl_accounting_mutex), can a PI deboost race with a
concurrent dl_rebuild_rd_accounting()? If p is PI-boosted when
dl_clear_root_domains() runs, p is not on dl_departed_list, so
dl_clear_root_domains() clears the root domains without restoring
p->dl.dl_bw. If rt_mutex_setprio() then deboosts p before
dl_add_task_root_domain(p) inspects it, switched_from_dl() re-adds p to
dl_departed_list after dl_clear_root_domains() has already finished, and
dl_add_task_root_domain(p) sees !dl_task(p) and returns early, dropping p's
departing bandwidth before its 0-lag time.

3. If p is sleeping (!task_on_rq_queued(p)) after leaving SCHED_DEADLINE
with inactive_timer armed (so p->dl.dl_non_contending is 0), and a
SCHED_DEADLINE waiter blocks on an rt_mutex held by p, switched_to_dl()
cancels inactive_timer and calls dl_task_undepart(p). If that waiter times
out or is interrupted while p is still sleeping, rt_mutex_setprio() deboosts
p and calls switched_from_dl(). Since !task_on_rq_queued(p),
p->dl.dl_non_contending =3D=3D 0, and p->dl.dl_runtime > 0, doesn't
switched_from_dl() enter the else-if branch and call dl_task_release_bw()
immediately, releasing p->dl.dl_bw before p's 0-lag time has elapsed?

[1] https://lore.kernel.org/r/9a2c58b84302e5ed3765f773eca3c71c7d5ea7bb.1793=
804635.git.mathieu.desnoyers@efficios.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104211207.1392=
343-1-mathieu.desnoyers@efficios.com?part=3D9
