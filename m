Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927321;
	b=z27C4aOLeySFwKrS5InO+qalDw2VR1y3Mzu2Fm+b50WNzzCQSXKH7v648V8cNOejwdr4
	 h59EuJc1ARBOtO9mzofW3Agqa1njD0wRS9dAZjEg5XVx5dujeh0EmXqLSo+gE+TVR1jMW
	 Zr87r21U/1cBS915cohYAtp6TuOJn8EQuhe4+9Dv38IrjRxFKjDmKcxRf3zfhyXzp0Z9L
	 ORjKzI6eEOjYQCkoKpDajklZFqRE+D+AciidW3pU1t74Wod4deD+G5Mz5fs2a6pgEWSEf
	 3w3JP/wZihZ/j1osKYM01IJ2jjErb6ubLHaFkARll6r+/uhP4pufLN9h977kCcT2gPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927321;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=He6eUap6Aq/L1QMPaO3O+WqRw9KVBdLJ0EpzgYo74p4=;
	b=q6n6l0gVdNrSwKNpbqnh/UL2SEVZSGG5Iv3kjo38y8WFqjecrWrukbCSeQGPU82y2cUS
	 H2gBMMZNZW0Btniyhx3L16bxAHW4S59RHgOuOmvoisYPO0AU9jffOWeDkKezYgraNSO0s
	 dYOIvTqnLkPOxOfxfIfdXg9/edBXYBuw9IKKMa1OQ9/NjA8553y27TsI+aUWkzqMKfRcV
	 aCCo1vYcjY4txdrDTFALRVTqxLNvwtIiiZfxR8YSd139chj+wd1MR7tFKHkDFDhlCoDy9
	 IRDs4kmOIsPZ3kk4SRuJA9wbYxEjvYtOscOXFUlbNO7Rn14SrBGy0y++KXsZayfTk2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kh0pBXa1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BD8606A32C;
	Tue, 17 Nov 2026 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kh0pBXa1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585B21F000C6;
	Tue, 17 Nov 2026 14:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927321;
	bh=He6eUap6Aq/L1QMPaO3O+WqRw9KVBdLJ0EpzgYo74p4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kh0pBXa1ZxISdutm9qDKMLlVEC96Ky0m2e4pWmDfSwEju6OdOPUxldGNevJwFATVJ
	 cQey39G6KTrNL9VD4/GZ0epCJCdrJ6ajwknE60C5vVXfbj1zEc0pG0FzFUNB0jioSU
	 MUoGADbap8C6sPAg7D7lIw/RdfV+UFwjoM0ahOHxqIu/Yy8kPALu+5aTTU+WvwzX4i
	 f6qaMQkEVWiCunr1CKMO4Cptuz0UW4Wil7rXZ9PELZVvqpHFh0e/dJF7iRs9EwwWCD
	 UkRAA9yQbAlsfQrzA+5dMu/3EnkRBLcoicaJrgrsHZ1t8Bf9+Ju3gpJ/k/yICVCZY4
	 Kx3IVWLqFrUIg==
Message-ID: <sashiko-outbox-219000@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 11/40] sched/deadline: Reset the donor's runtime at a
 deboost in the class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <299aaf536a1a63c7b496eebe7a6ca20e8f06ad5f.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <299aaf536a1a63c7b496eebe7a6ca20e8f06ad5f.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:55:20 +0000
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
- [Medium] sched/deadline: rt_mutex_setprio() skips dl_deboost() on
  donor change
- [Medium] sched/deadline: donor runtime kept when leaving
  dl_sched_class
- [Low] sched/deadline: missing dl_note_donor_refill() on cleared donor
  in replenish_dl_entity()
--

commit bb738227d35bdf5cba0afaf4e41cb6707e38d0c4
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Reset the donor's runtime at a deboost in the class

This commit adds a dl_donor_refill flag to record when a boosted task has i=
ts
runtime replenished from a donor's reservation, and starts a new period from
the task's own parameters when the boost ends in the deadline class.

[ ... ]

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 5ed660f099a55..a22df8b43a1a7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7834,16 +7834,26 @@ void rt_mutex_setprio(struct task_struct *p, stru=
ct task_struct *pi_task)
>  				p->dl.pi_se =3D pi_task->dl.pi_se;
>  				scope->flags |=3D ENQUEUE_REPLENISH;
>  			} else {
> -				p->dl.pi_se =3D &p->dl;
> +				dl_deboost(&p->dl);
> +				/*
> +				 * dl_deboost() can start a new period. Its
> +				 * deadline can then be after the top waiter's.
> +				 * Boost the task again then.
> +				 */
> +				if (pi_task && dl_prio(pi_task->prio) &&
> +				    dl_entity_preempt(&pi_task->dl, &p->dl)) {
> +					p->dl.pi_se =3D pi_task->dl.pi_se;
> +					scope->flags |=3D ENQUEUE_REPLENISH;
> +				}
>  			}

[Severity: Medium]
Can a SCHED_DEADLINE task skip dl_deboost(&p->dl) here when switching from
one deadline donor to another?

In rt_mutex_setprio(), the outer if statement tests
dl_entity_preempt(&pi_task->dl, &p->dl) before calling dl_deboost(&p->dl).
When p was refilled from a previous donor W1, p->dl.deadline holds W1's
postponed deadline rather than p's own reservation deadline.  If p unlocks
W1's lock while another deadline waiter W2 is queued on a lock held by p, a=
nd
W2->dl.deadline is earlier than W1's postponed deadline, the outer check
takes the first branch and skips dl_deboost(&p->dl).

Because p->dl.dl_deadline is non-zero and p->dl.runtime is still positive
from W1's refill, ENQUEUE_REPLENISH in replenish_dl_entity() does not reset
p->dl.runtime or p->dl.deadline either.  p then keeps W1's leftover runtime
and postponed deadline, even if p's own new-period deadline would have been
earlier than W2->dl.deadline.

Calling dl_deboost(&p->dl) unconditionally when dl_prio(p->normal_prio)
before testing whether pi_task preempts &p->dl would compare pi_task against
p's own reservation.

>  		} else if (rt_prio(prio)) {
>  			if (dl_prio(oldprio))
> -				p->dl.pi_se =3D &p->dl;
> +				dl_drop_boost(&p->dl);
>  			if (oldprio < prio)
>  				scope->flags |=3D ENQUEUE_HEAD;
>  		} else {
>  			if (dl_prio(oldprio))
> -				p->dl.pi_se =3D &p->dl;
> +				dl_drop_boost(&p->dl);
>  			if (rt_prio(oldprio))
>  				p->rt.timeout =3D 0;
>  		}

[Severity: Medium]
Does a task that still has SCHED_DEADLINE parameters (p->dl.dl_runtime !=3D=
 0)
keep the donor's refilled runtime and deadline when leaving the deadline
class at deboost?

A task can have p->dl.dl_runtime !=3D 0 and p->dl.dl_donor_refill =3D=3D 1 =
while
leaving dl_sched_class (for example, if it changed its policy away from
SCHED_DEADLINE while boosted and then unlocks, or if it left SCHED_DEADLINE
before its 0-lag time and was boosted and refilled before inactive_timer
fired).  When it leaves dl_sched_class, sched_change_begin() runs
switched_from_dl() before dl_drop_boost(&p->dl) clears dl_donor_refill:

kernel/sched/deadline.c:switched_from_dl() {
	if (task_on_rq_queued(p) && p->dl.dl_runtime)
		task_non_contending(&p->dl, false);
	...
	if (!p->dl.dl_runtime) {
		p->dl.deadline =3D 0;
		p->dl.runtime =3D 0;
	}
}

Because p->dl.dl_runtime is non-zero, switched_from_dl() passes the donor's
refilled runtime and deadline to task_non_contending(), which mixes them wi=
th
p's own dl_period and dl_runtime to compute zerolag_time.  If the donor's
remaining runtime makes zerolag_time negative, task_non_contending() clears
p's parameters immediately and lets p re-enter SCHED_DEADLINE with a fresh
budget in the same period; otherwise, p retains the donor's runtime and
deadline if it returns to SCHED_DEADLINE before inactive_timer fires.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d6d2657dcddd6..989e7e7d3f8f1 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -832,6 +869,7 @@ static void replenish_dl_entity(struct sched_dl_entit=
y *dl_se)
>  		if (!dl_se->dl_deadline) {
>  			dl_se->deadline =3D rq_clock(rq);
>  			dl_se->runtime =3D 0;
> +			dl_note_donor_refill(dl_se);
>  		}
>  		if (dl_se->runtime < 0 || dl_se->dl_yielded)
>  			dl_se->runtime =3D 0;

[Severity: Low]
In this cleared-donor fallback (!runtime || !deadline || !period), should
dl_note_donor_refill(dl_se) also be called when dl_se->dl_deadline is
non-zero?

If a boosted SCHED_DEADLINE task hits this path when its runtime is exhaust=
ed
or after sched_yield(), replenish_dl_entity() zeroes dl_se->runtime and
clears dl_se->dl_throttled without setting dl_donor_refill.  A subsequent
dl_deboost() then leaves the task in the class with runtime =3D=3D 0,
dl_throttled =3D=3D 0, and its old deadline.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D11
