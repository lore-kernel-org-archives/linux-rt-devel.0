Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930385;
	b=tjESNbs/E/MdLbvBNpsDhDpB8nz8CXuTrIQLarjmljbmpFD/hipCB2B4AJ4aXoVI7Sx4
	 H7ADcdKuMxnllvcs59l3D8JOr98YjqirkbI/xlhH3JedtYBocrnQjW8ZpgFVv0ZfT1b1n
	 f1id69Roc2LKVYMrRzIR8RNe42HduUsNfnsZs9hFZ6NI8l2sYD7sks3J0eJPWNH2oC016
	 1ViMyZEek4YL2eFPdIRrb7Vdi/r1TRSqnGtK4ZBlUv0oc421RJRandM7a3e5+Bd3bfYoP
	 7Ay9ChX218jaZvAnZ5vMeUgBiuFruaKCoYpQeLJEZwVmQLulJHkkJtVJfRQ/GfeWRoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930385;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IbQtyA8KclMq0kN4x7zzrFuHcipjgs9Jx0GfOWSzjDg=;
	b=2TPyDNDNs2OgCViMEImaDKNBTIoInGVuREuYNi645750ujsfgcbAlaj9nd08sNqvHP3q
	 LP0zyPftfsQ1tExA+uxGxFZhEFpHbsZ0gtjpUDtBXZ94Gcvkq8AjPqyDhu702zlVnvKOZ
	 MPjRAqJeddEPkdotpsrOrg3RNuopB4ipTzFmlbqCObtbd9fWXNQ8cQ6mC7On5D68kMWhJ
	 Vud3mEPABwhVg5QZtoeBqYFFcPDSVULI2URDob48Hll5igQV0Y184SVrE9Yx2xPkU+O5y
	 QvHhTv5kYZaCk1fGbZAMyDjunXbASzf8x5uRkZnqh8YvfihYoGIllmdnEB6/2IfzjYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AC90hsFF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92391606A32A;
	Tue, 17 Nov 2026 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AC90hsFF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2523C1F000CC;
	Tue, 17 Nov 2026 15:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794930385;
	bh=IbQtyA8KclMq0kN4x7zzrFuHcipjgs9Jx0GfOWSzjDg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AC90hsFFguoJbpPB7HtofT610vQ8NSOvXExOusMiEWmpF0cimbqrwkVYv2mEmhNf/
	 LaaTgHYyrTjxskTqAsMC/+0HnCFBAwRgyGqPtHIPeB5WEAlvmbF1NgGrXJRNEaLQHR
	 ACZxi0ReIhnBfC+VU5B+xDREo6QEYpUsWMB2r1cGu2nWDhg7z8dm1xxd1GhnKzp/j9
	 bT8dO/Pa7sCL7NN3BaWyP0xZKw5TI9Zqj7b1lPuLNsuC0WgtrNNufYhcxQQMF/wgQt
	 wsP4qNGhXalSOVoM0AThGDGq5eY7KwiKPTjDHrwX6jjbbeCZYvSb0L2j8vnCiINZuQ
	 t9AlLxjTBc+CA==
Message-ID: <sashiko-outbox-219105@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 33/40] sched/deadline: Start a period for a task that
 enters the class blocked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <263b8e16915845e823712fd5feefa7b79205f7d1.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <263b8e16915845e823712fd5feefa7b79205f7d1.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:46:24 +0000
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
- [Medium] sched/deadline: unstarted period when sleeping task has
  !dl_task_pi_blocked()
- [Medium] sched/deadline: sched_setattr() on PI-boosted blocked task
  skips period update
--

commit 5f0fe1e32222b5c48a70b881608ff3bc4a90abf3
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Start a period for a task that enters the class blocked

This commit starts a deadline period in switched_to_dl() and
dl_boost_blocked() when a task blocked on an rt_mutex enters the deadline
class or receives a new donor so its waiter does not sort with a deadline
of 0.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 0b30059483136..90b17969554bf 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -125,6 +125,12 @@ void dl_deboost(struct sched_dl_entity *dl_se)
>  	}
>  	dl_drop_boost(dl_se);
>  }
> +
> +/* Return true if @p waits on an rt_mutex. The caller holds its pi_lock.=
 */
> +static inline bool dl_task_pi_blocked(struct task_struct *p)
> +{
> +	return p->pi_blocked_on;
> +}

[Severity: Medium]
Can gating replenish_dl_new_period() on dl_task_pi_blocked(p) still leave
p->dl.deadline at 0 when a sleeping task participates in rt_mutex priority
inheritance before waking up?

A non-deadline task sleeping in futex_wait_requeue_pi() on uaddr1 has
!task_on_rq_queued(p) and p->pi_blocked_on =3D=3D NULL.  If it enters
dl_sched_class while sleeping on uaddr1 (via sched_setattr() or a PI boost
on another rt_mutex it owns), dl_task_pi_blocked(p) is false, so both
switched_to_dl() and dl_boost_blocked() leave p->dl.deadline at 0.  A
subsequent FUTEX_CMP_REQUEUE_PI then calls rt_mutex_start_proxy_lock() ->
task_blocks_on_rt_mutex() without waking p, queueing its waiter on uaddr2
with a deadline of 0 ahead of all real deadline waiters.

Similarly, if a task holding an rt_mutex sleeps in a non-rt_mutex syscall
(p->pi_blocked_on =3D=3D NULL) and sched_setattr() makes it SCHED_DEADLINE,
p->dl.deadline remains 0 while dl_prio(p->normal_prio) becomes true.  If an
earlier-deadline waiter then blocks on that rt_mutex before p wakes up,
rt_mutex_setprio() evaluates dl_entity_preempt(&pi_task->dl, &p->dl)
against deadline 0, which returns false and fails to boost p.

[ ... ]

> @@ -4483,6 +4514,17 @@ static void switched_to_dl(struct rq *rq, struct t=
ask_struct *p)
>  	if (!task_on_rq_queued(p)) {
>  		add_rq_bw(&p->dl, &rq->dl);
> =20
> +		/*
> +		 * A task that waits on an rt_mutex cannot wait for its wakeup.
> +		 * The chain walk sorts its waiter by its deadline first. A task
> +		 * new to the class has a deadline of 0, which goes before every
> +		 * real one. Start a new period now, as setup_new_dl_entity()
> +		 * does at an enqueue.
> +		 */
> +		if (dl_task_pi_blocked(p) && !p->dl.dl_throttled &&
> +		    dl_time_before(p->dl.deadline, rq_clock(rq)))
> +			replenish_dl_new_period(&p->dl, rq);
> +
>  		return;
>  	}

[Severity: Medium]
What happens when sched_setattr() changes the policy of a task blocked on
an rt_mutex that is already in dl_sched_class due to a PI boost?

Because prev_class and next_class are both &dl_sched_class,
__sched_setscheduler() does not set DEQUEUE_CLASS, so switched_to_dl() does
not run:

kernel/sched/syscalls.c:__setscheduler_dl_pi() {
	if (dl_prio(newprio) && !dl_policy(policy)) {
		struct task_struct *pi_task =3D rt_mutex_get_top_task(p);

		if (pi_task) {
			p->dl.pi_se =3D pi_task->dl.pi_se;
			scope->flags |=3D ENQUEUE_REPLENISH;
		}
	}
...
}

When sched_setattr() gives such a blocked task its own SCHED_DEADLINE
reservation with an earlier deadline than its donor's,
__setscheduler_dl_pi() does nothing because dl_policy(policy) is true, and
prio_changed_dl() returns early because !task_on_rq_queued(p).  Neither
p->dl.deadline nor p->dl.pi_se is updated, so rt_mutex_adjust_pi() sees
rt_waiter_up_to_date(waiter, p) and stops without re-sorting p's waiter or
propagating the earlier deadline down the lock chain.

Conversely, when a blocked task leaves SCHED_DEADLINE (!dl_policy(policy))
while remaining boosted in dl_sched_class (dl_prio(newprio)), setting
ENQUEUE_REPLENISH in __setscheduler_dl_pi() has no effect while
!scope->queued because dl_boost_blocked() is not called.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D33
