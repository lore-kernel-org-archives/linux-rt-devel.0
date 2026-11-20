Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209685;
	b=UNTJ6mhUFjXeJwJOKLK7Ht3SgqSjQoWzWWtTCpXmS/s6X/EmnDItD+dqEgI+2oXAnr20
	 S/yqNwF4EVjGPjRVG/rclU0YVdNJsczXTfa5ml01QCJqNnwVOkiCxR8snZizwHleKplV7
	 sPvTgnlNQ6akRcWS/ufL145gJBFZVf2NmPO+LB89FAbWnA3I3RjqVgC7Xe1qUD7uhHk9r
	 zkg8kKz+NbvNOcWCyIdVTWL3eX6cPuA6p009bTESYHZ2dABWcGcw0xJLw2BKuuyueWjMf
	 TQAX0S0wLjukDl2mOFlVJpZtWA1h3+nQdxTkrv8r3G3g5y0uasTpjAMf0lXZWbADuFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209685;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LcW5LGPLQNlpPABgCM8Lav+Jb0a9Avhy4piIz92GWfI=;
	b=bH6z5P0fp6PodqymDaL2Il58XXB7xXPDGcV83hRj+gj0V77OsZH/qH4N8OR6/5SUxKp8
	 I6kBvOmKHNvIr6f8Y7e8RQAL3VxDAlJUq+dp/1XOCFu7i5AMTm4Xma6WtOnuFs5BPWH0p
	 e18xhCxL55U0NqTZCT/uQBkc5RN6QpvSKfGzTiRE0r3S1MDiHBE2cWRmi7nvkXNTw/yyj
	 0ex2Hu8jZkoryAOmuYHxFSUFVIArj9s9mz1JspTOuNAQqeT4tEzzswXiALEFM9XnK19Ec
	 CZEQmlAT7LTRvfX4j0jHEO8M56XTWlS7LY2rB6K8u2perpsDCvOUMDcGZUjwmETBD9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIHWLapb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2961E606A6AF;
	Fri, 20 Nov 2026 21:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIHWLapb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B65DA1F000C4;
	Fri, 20 Nov 2026 21:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209685;
	bh=LcW5LGPLQNlpPABgCM8Lav+Jb0a9Avhy4piIz92GWfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bIHWLapbw9Pqnul7m1Tj39h3iCi1bWWGwic+B2iGhTpv6ocCOXf9YUhLthjgWmVP6
	 9mfMtXDEsxFrE8FG6xV4cyuGEHwjlNJboiZDkcIAUJ/FPU8lpQi+dhVDEcHR8HjvmD
	 ZI6Tf/Hy82Zm6Psr2USmSLVICPMmlSVPxNEynhEaVoDpUgl943cbrPvILsZNW+E46n
	 cwmKNOoFnCOoiFuUo4S9xwSgfpL2bFOjbWUHabWizGvaoxQiqN5P93sGP/2+/5IIhI
	 TMI0qDID9pFyIgk4L+V5ITjj8nGR5cCR/Esk5GGK1Vh/9XwbRPEsB7j8nvUrnqvbOT
	 gpj2tMB9x3nDQ==
Message-ID: <sashiko-outbox-226162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 28/40] sched/deadline: Start a period for a task
 that enters the class blocked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <0557a76f35a09f1caa281777e3926d3446a7c74e.1795207232.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <0557a76f35a09f1caa281777e3926d3446a7c74e.1795207232.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:21:24 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] sched/deadline: dl_boost_blocked() skips departed tasks with
  dl_deadline
--

commit 83a90ad95f7f2d67e4562e7ef1ff35c08c85da9f
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Start a period for a task that enters the class blocked

This commit starts a deadline period for a task blocked on an rt_mutex
when it enters the deadline class or receives a new priority-inheritance
donor while having no deadline reservation of its own.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index aa12908aeaeab..ee3a08ff33458 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -1184,6 +1195,30 @@ static inline void replenish_dl_new_period(struct =
sched_dl_entity *dl_se,
>  	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
>  }
> =20
> +#ifdef CONFIG_RT_MUTEXES
> +/*
> + * Start a period from the new donor of @p, if @p has no reservation of =
its
> + * own and waits on an rt_mutex. The enqueue does this for a queued task=
, in
> + * replenish_dl_entity(). A blocked task is not enqueued, but the chain =
walk
> + * copies its deadline into its waiter.
> + *
> + * The caller calls it only when the donor changes. A new period changes=
 the
> + * deadline, so the chain walk finds the waiter out of date and goes on.=
 In a
> + * ww_mutex cycle, a new period at each step would never let the walk st=
op.
> + *
> + * The caller holds the rq lock and the pi_lock of @p, and has updated t=
he
> + * rq clock.
> + */
> +void dl_boost_blocked(struct task_struct *p)
> +{
> +	struct sched_dl_entity *dl_se =3D &p->dl;
> +
> +	if (!dl_se->dl_deadline && !dl_se->dl_throttled &&
> +	    dl_task_pi_blocked(p))
> +		replenish_dl_new_period(dl_se, task_rq(p));
> +}
> +#endif

[Severity: Medium]
Can dl_boost_blocked() skip starting a period for a task that left
SCHED_DEADLINE before its 0-lag time?

When a deadline task switches to a non-deadline policy before its 0-lag
time, switched_from_dl() arms inactive_timer and leaves dl_se->dl_deadline
and dl_se->deadline non-zero until that timer fires.  If the task blocks
on an rt_mutex and is boosted back into dl_sched_class before
dl_se->deadline passes, switched_to_dl() cancels inactive_timer (so
__dl_clear_params() never clears dl_se->dl_deadline while the task remains
boosted) and skips replenish_dl_new_period() because dl_se->deadline has
not passed yet.

Once dl_se->deadline does pass while the task is still blocked and boosted,
a subsequent boost by a new donor calls dl_boost_blocked(p), which sees
dl_se->dl_deadline !=3D 0 and returns without replenishing.  The chain walk
then requeues the waiter with the expired dl_se->deadline ahead of waiters
with current deadlines.

Checking !dl_prio(p->normal_prio) (or whether dl_se->deadline has passed)
instead of !dl_se->dl_deadline would cover tasks still carrying parameters
from before they left the class.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D28
