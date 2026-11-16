Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859959;
	b=gpzrJ8V9IgYjLQebvHxPIrcWK6a7VPEsJHSUQMrcJwkchq+hbP9NJXIS3m7uyb6LHdHB
	 hcikIOlSym//ApeTjHWFUG+Hb0yHsGH4PVIX5/ReDYA0RHF9vKmKFtIPFuIvfWOEdwerZ
	 YWytdbnJymahKAXcBHLDYklz8k9ZAYNPPqaLZnUaw9sUqkbERNFDAy1FeFgQW8xgG0Cj+
	 mDbsMufKGmD8+uyYv4b+mtRn5eXwjsy4n5xXElVtCam2pRaGwtMvsm1YyLLa0bMcpzY3l
	 oJQ6Cz2rq1nlLlq/GiHUrVIit4QWFh8kgJDTr99l5hoE/SK5Xy3EWxgkX9w73pLjmIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859959;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n3p23qamEPSVCku/oD2M/mowxIfwSLWupYtuZmpll5M=;
	b=o5GRsOgiXn1KmKdOHVWBruwi91JFpRUn2/CLBHtIRCxjt610X64GPALIv5pm1IKDobqI
	 3z2o/8Zpgmu5zrMruvY/UmEbGjkuXtFDWO2H+cS7VjdeTheXVGbTHKDxjq8vJ/U2DKmsC
	 gCu5UcZ8p71oDfDYot6Jq3pLHCOPgbmpnE8yxNqkIQhkOzsu98lgiij8ZcJfeUInIE0cN
	 tjMIiGqT2KKH/fRS4NZ2E+Wpn4n2hKETkv6GLSld0/DejS1m+gTI2pBe5hgdmJLVsb3vE
	 OwQBbC+ZY6Jdo6ftZ9tccKUVKMB2ZzSN2ydsua2Sy3JVfnOz5L01pLIQCLZsNiGPzsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bR9C4XtD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AD6606A887;
	Mon, 16 Nov 2026 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bR9C4XtD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C681F000C4;
	Mon, 16 Nov 2026 20:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859959;
	bh=n3p23qamEPSVCku/oD2M/mowxIfwSLWupYtuZmpll5M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bR9C4XtDF/k0L5w/U5uQo6eXX7kanrYrxFdZawrLfoHk7xnDVdh1qDn0iUSJkBSsJ
	 Oqp6463VWr+a24SukPwK+XAwrvY2NkFTncDZAdYxpfdw3UcLC78BvYbr0cJ/UjqZrG
	 wrt9MknJJfV5cXCi6ZtB9oTTRP/T7apZ375/+nS6faqyXb/Riiav3m266dnwIepI8z
	 S7FCRaXNFbgoIyJd+HTmq6FWviD8OZ1HlQjwohbia/RwF1cZ74vbevI+m5CSab7PXB
	 gOuxyh51SCc9wGRZvMDofplgzTg9AA6rNbXLoeiE5PWXGrBkKSkG0xeBqD1OjjgfUV
	 LHwdvvywZjo2w==
Message-ID: <sashiko-outbox-217639@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 31/37] sched/deadline: Start a period for a task that
 enters the class blocked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-32-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-32-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 20:12:38 +0000
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
- [Medium] sched/deadline: unstarted period in switched_to_dl() when
  !pi_blocked_on
- [Medium] sched/deadline: switched_to_dl() skips period reset on
  boosted pre-0-lag task
- [Medium] sched/deadline: stale deadline on rt_mutex waiter when donor
  or policy changes
--

commit 97588bc2bebff0e4575bb7d4c8f530868b8856a3
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Start a period for a task that enters the class blocked

This commit starts a new period in switched_to_dl() when a task blocked on
an rt_mutex enters dl_sched_class with an expired deadline so that the
rt_mutex waiter tree does not sort it with a deadline of 0.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 69a338c1526d0..ffa8b946e8047 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -4352,6 +4363,17 @@ static void switched_to_dl(struct rq *rq, struct t=
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

[Severity: Medium]
Does gating replenish_dl_new_period() on dl_task_pi_blocked(p) leave
p->dl.deadline at 0 when a sleeping task participates in rt_mutex priority
inheritance before waking up?

While a task sleeps in futex_wait_requeue_pi() on a non-PI futex,
p->pi_blocked_on is NULL.  If sched_setattr() or a PI boost moves p into
dl_sched_class there, switched_to_dl() leaves p->dl.deadline at 0, and a
later FUTEX_CMP_REQUEUE_PI calls rt_mutex_start_proxy_lock() ->
task_blocks_on_rt_mutex() without waking p, queuing its waiter ahead of all
deadline waiters with deadline 0.  Likewise, if a task holding an rt_mutex
is switched to SCHED_DEADLINE while sleeping on a non-rt_mutex wait,
p->dl.deadline stays 0 and rt_mutex_setprio() fails to boost p when a
deadline waiter with an earlier deadline blocks on that rt_mutex
(dl_entity_preempt(&pi_task->dl, &p->dl) is false against 0).

[Severity: Medium]
What happens when a task that left SCHED_DEADLINE before its 0-lag time is
PI-boosted back into dl_sched_class while blocked on an rt_mutex?

switched_from_dl() preserves p->dl.deadline and p->dl.dl_throttled until
inactive_timer fires.  If p then blocks on an rt_mutex while holding
another and is boosted back into dl_sched_class, enqueue_task_dl() is not
called because p is not queued, and switched_to_dl() checks
!p->dl.dl_throttled && dl_time_before(p->dl.deadline, rq_clock(rq)) without
checking is_dl_boosted(&p->dl).

If p->dl.dl_throttled is still set, switched_to_dl() skips
replenish_dl_new_period() and leaves p throttled with its expired deadline;
if p->dl.dl_timer then fires while p is boosted, dl_task_timer() bails out
on is_dl_boosted(dl_se) without clearing dl_throttled, which prevents
enqueue_dl_entity() from queuing p after deboost.  Even when p is not
throttled, if its old pre-0-lag p->dl.deadline is still in the future,
switched_to_dl() skips replenish_dl_new_period() and the chain walk sorts p
using its abandoned reservation's deadline instead of the donor's.

[Severity: Medium]
Does starting a period in switched_to_dl() leave p->dl.deadline stale if the
top PI donor on a blocked task changes while it remains in dl_sched_class?

If a non-deadline task p owns rt_mutex M1 and blocks on rt_mutex M2, an
initial deadline waiter W1 on M1 moves p into dl_sched_class and
switched_to_dl() sets p->dl.deadline from W1.  If a second deadline waiter
W2 with a much earlier deadline then blocks on M1, rt_mutex_setprio(p, W2)
keeps prev_class =3D=3D next_class =3D=3D &dl_sched_class and sets p->dl.pi=
_se =3D
W2->dl.pi_se with ENQUEUE_REPLENISH.  Because p is not queued,
sched_change_end() calls prio_changed_dl() instead of enqueue_task_dl() or
switched_to_dl(), leaving p->dl.deadline at W1's later deadline.
rt_mutex_adjust_prio_chain() then sees an unchanged waiter deadline and
stops the chain walk on M2, and when p later wakes up, update_dl_entity()
keeps W1's future deadline if dl_entity_overflow() is not triggered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D31
