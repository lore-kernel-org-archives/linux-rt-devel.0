Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017591;
	b=KEN5Xq+GKzywflN1vMvxyONa8CJylg8C4H7SWiSzLV4zcdADtgeFCOQE9985pBzp3Ybt
	 QJ11zN9zEGTEe6mbDaK+1yKsypd6lZm+Qdg6TjPJHfn2NjP5Lduttyt3395LOCUUPHZyH
	 2VRttCAbobqf8A4y82jf5puorB1sE2Wkln9NWdHrsXF5sv54BHSoGryRJDf1MLsJnQs1Q
	 e/dSuV/tuQ3Pb9xxi2raPsYAqjxmbNBLftNRjzZBaW9fc8AllENHUvpspcdhrLpaPIwtO
	 BavTU+Juv3/FhGIznPjj2lwMIMxCA6MgaVQBLqkU25UkLbl539g+pwAkYJvhYqgHajA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017591;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CVDpM5shQz8r0U/jeQqprBlzv2snsLy+sq8LFE1yYfo=;
	b=MZnqr8sG7oMn7XRe0i1MFUelnmwcuqpHR5VJ3io0ZVfifsEsC26a5CpTvZM+F+CCPSXT
	 V19uOwGp1DhwWhOO3EbPTXa3Bo7okXRvZZXrgbMKBkEXvdUYoLX0qHKh1AZeNVst0TsnC
	 36myKunCKOuY0t3heDGw2JrVdXidz++DLno21X2SPMNxI4L4Vh3MWddxF6eLd75iRsiBA
	 lp/G9BxIt4QWmf/bGk7N4LHvu6M0fU3P1kx8yI3SnSM2T+DGKeVs13/6eGiPxc6tPWcs4
	 uOI3jLRzj3k4rmxxjxZSZptub7RhaRyPSdAt+hrKIBKqalepYCwmNWHFcIijfZIWnyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYt9YWte;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489B606A32C;
	Sat,  7 Nov 2026 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AYt9YWte
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503531F008A1;
	Sat,  7 Nov 2026 02:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794017590;
	bh=CVDpM5shQz8r0U/jeQqprBlzv2snsLy+sq8LFE1yYfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AYt9YWte463rpr3P5w0PWvWcgVQ/oWx0W3bBYMN86XwoTUvDEgk6KW2vMCFfcB7A+
	 +8a8pw2uxhZuoQdSpZdL7ZDIs0vRD9f5QZNvsskv0Yufpe5xl6hZL5UO39KHFCqJ2W
	 rMoc3aCkJL/lseWvJireLc7vZX7dgJwqopw8Sdh+X545zVgnNX+0Bsminriy5MCPa3
	 SMtWP23ftp1nThKHPal8yFRvrNO1CWS19L6/c3NEBhhLLw8KQvunb3gTQZRS2jmc0D
	 byc0pJBr2bxzER4qqqIecVoaoxtyjX3lMmK4AIY+Hwoxh2qM/bGBPFBPYbfsUbq66q
	 4bPCKhVi/HVuA==
Message-ID: <sashiko-outbox-202487@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/26] sched: Let a task boosted by a deadline waiter
 change its policy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261107014451.1487825-5-mathieu.desnoyers@efficios.com>
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-5-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 02:13:09 +0000
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
- [Medium] sched: dangling pi_se in __sched_setscheduler() when pi is
  false
- [Medium] sched: unconditional ENQUEUE_REPLENISH in
  __setscheduler_dl_pi()
--

commit 8fd411e98dd72e517f278200f2a112aeff758f77
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched: Let a task boosted by a deadline waiter change its policy

This commit changes __sched_setscheduler() to test task_has_dl_policy(p)
rather than dl_task(p) when deciding whether to run sched_dl_overflow(),
allowing a task boosted by a deadline waiter to change its policy.

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index b8c036d03d6f5..bdffe5452dc8c 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -689,7 +689,9 @@ int __sched_setscheduler(struct task_struct *p,
>  	 * If setscheduling to SCHED_DEADLINE (or changing the parameters
>  	 * of a SCHED_DEADLINE task) we need to check if enough bandwidth
>  	 * is available. Last of the checks: nothing gives back the
> -	 * bandwidth it reserves.
> +	 * bandwidth it reserves. A task boosted into the class by priority
> +	 * inheritance has nothing to admit nor to leave: the policy
> +	 * decides, not the priority.
>  	 *
>  	 * Nothing to admit for parameters that are kept
>  	 * (SCHED_FLAG_KEEP_PARAMS): they are the ones the task has, and
> @@ -697,7 +699,8 @@ int __sched_setscheduler(struct task_struct *p,
>  	 * change of its own that landed in between would leave them stale.
>  	 */
>  	if (!(attr->sched_flags & SCHED_FLAG_KEEP_PARAMS) &&
> -	    (dl_policy(policy) || dl_task(p)) && sched_dl_overflow(p, policy, a=
ttr)) {
> +	    (dl_policy(policy) || task_has_dl_policy(p)) &&
> +	    sched_dl_overflow(p, policy, attr)) {
>  		retval =3D -EBUSY;
>  		goto unlock;
>  	}

[Severity: Medium]
Does this leave a dangling p->dl.pi_se pointer when normalize_rt_tasks()
(sysrq-n) calls __sched_setscheduler() with pi set to false on a non-deadli=
ne
task boosted by a deadline rt_mutex waiter?

With pi set to false, __sched_setscheduler() skips rt_effective_prio(), so
newprio is normal priority (120) and the task moves to fair_sched_class.
However, __setscheduler_dl_pi() only updates p->dl.pi_se when dl_prio(newpr=
io)
is true:

kernel/sched/syscalls.c:__setscheduler_dl_pi() {
	if (dl_prio(newprio) && !dl_policy(policy)) {
		struct task_struct *pi_task =3D rt_mutex_get_top_task(p);

		if (pi_task) {
			p->dl.pi_se =3D pi_task->dl.pi_se;
			scope->flags |=3D ENQUEUE_REPLENISH;
		}
	}
}

switched_from_dl() does not reset p->dl.pi_se either because p->dl.dl_runti=
me
is 0, and when p later releases the rt_mutex, rt_mutex_setprio() sees
prio =3D=3D p->prio && !dl_prio(prio) and returns early without resetting
p->dl.pi_se =3D &p->dl.  If the waiter later exits (or has its deadline
parameters cleared) and p subsequently enters the deadline policy,
is_dl_boosted(&p->dl) remains true and replenish_dl_entity() dereferences t=
he
stale p->dl.pi_se pointer, causing a use-after-free or an infinite loop und=
er
rq->__lock.

[Severity: Medium]
Can a non-deadline task boosted by a deadline waiter also bypass deadline
bandwidth enforcement by repeatedly calling sched_setscheduler() or
sched_setattr()?

With this change, a boosted non-deadline task calling __sched_setscheduler()
with pi set to true (for example, toggling between normal and batch policie=
s)
keeps dl_prio(newprio) and reaches __setscheduler_dl_pi(), which
unconditionally sets ENQUEUE_REPLENISH on scope->flags.  When
sched_change_end() re-enqueues the task, enqueue_task_dl() clears
dl_se->dl_throttled and replenish_dl_entity() sees dl_se->dl_deadline =3D=
=3D 0:

kernel/sched/deadline.c:replenish_dl_entity() {
	if (dl_se->dl_deadline =3D=3D 0 ||
	    (dl_se->dl_defer_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
		dl_se->deadline =3D rq_clock(rq) + pi_of(dl_se)->dl_deadline;
		dl_se->runtime =3D pi_of(dl_se)->dl_runtime;
	}
}

This refills dl_se->runtime to the donor's full runtime and unthrottles the
task on every call, allowing the mutex owner to replenish its inherited bud=
get
indefinitely and starve lower-priority tasks on that CPU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107014451.1487=
825-1-mathieu.desnoyers@efficios.com?part=3D4
