Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038276;
	b=TaYkG5jbjx6s84nYouvao1jQPuiGCnL9XVj7L5+fArC5HgKuvWpum7PAWYU6wFWN5Tmr
	 miALksHvisA6mbT2I2XWxrv2w3+U7KlPmEwNFHfRchTim+GCWOIMDCDwK32QzwZfzVEbX
	 aCjW/6UqIZo2hv/fKF5ROC2NnOLI5DQ3TcFodxtcbbTfWJsMQJ/8HTTV7mHC9Mxoua+Ny
	 FzyI+xm6kRm2MDOIXm5YnW8yrbnkQa00gx4JUISpl3pY43EqoT5jYju3QDNtaGaGlRw5D
	 t+TusRPTcYxWUcfsQ0/ADloxgD9Pc9+NXMjCXBHYJ0MSNbKRmEe8O0rKV8ae/enQvLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038276;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pv0tl8DSZDkf+66qS7JvneQYqimu2gvuuRpcR4hoZTM=;
	b=YqZL3PnAiAJ5TbkKNQ69SRmYHSJB73Zx+YkCsLa8s26W2z8Q3TKgm4jJOmRgRW11aCi+
	 BtERF7KA+JJltqBGnp4AchNBk7P4ZQ6rp7mTscNJieTh4HlACs4TR9kaIHBUxsTp01Pnq
	 7I3XLJxqnPT0UrXeIQ7qTej32RhVoZwq3qS6d8u7tV4EobTH79ACA3q2XU3KQSQQ4WHUB
	 l61EpXayE7W7PnIAEVuyhBgn4cdKdZ8bFTsA4nBL/KRJw1xXYFrjI9FxifzWBK0qm6/7e
	 LpjbfUhfXyuJ0YnOdpQjL+ErcYdOaPNZDcOixlGSANTmnX0kQbPwmA5tGrt2+KzMLSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZbT9/1GZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45E606A334;
	Wed, 18 Nov 2026 21:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZbT9/1GZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F411F000C4;
	Wed, 18 Nov 2026 21:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795038276;
	bh=pv0tl8DSZDkf+66qS7JvneQYqimu2gvuuRpcR4hoZTM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZbT9/1GZ9whUkl9pew6gWzekgZaD1TrtYBt+mkPtji8owg/RuN3O0iwDJs9eiFIuA
	 neTcqRAjDIMJ0OBP5aF4qzDfHskttTdtdwTS/PVQSD/SaojzheCx2owhdpqCVQxVD1
	 iQy4lDO2JGV3SiGoy4BKDDlDNEIW618FTY1tA3TGzWpmTP7zzQnUqJYRpBTi4yZWVk
	 3JffgxwEMGQ2DJ6cR0WqrNNdLtLz951YBC70x4NFiwMJ0qg4kvK1aUytyaFh4ZmZDM
	 dwdEbPz9Wild0o4yuwPnZWU6ixEOqPTM8ZvXPXrhisJskuJ+w599NLQgYVGckxyB6c
	 IxAEM+NpAVh9Q==
Message-ID: <sashiko-outbox-222024@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/16] sched/deadline: Reset the deadline and the
 runtime with the parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795037078.git.mathieu.desnoyers@efficios.com>
References: <cover.1795037078.git.mathieu.desnoyers@efficios.com>
 <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795037078.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:44:35 +0000
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
- [Medium] sched/deadline: donor runtime and deadline retained after PI
  deboost
- [Medium] sched/deadline: uncanceled dl_timer in __dl_clear_params()
--

commit d69ea33f8330709357d7bb1bbbe6f7eeb0c68972
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Reset the deadline and the runtime with the parameters

This commit resets a deadline entity's runtime and deadline in
__dl_clear_params() and upon deboost in switched_from_dl() so that its next
entry into SCHED_DEADLINE starts a new period.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 71b1c155c2424..d6d2657dcddd6 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3569,6 +3569,16 @@ static void switched_from_dl(struct rq *rq, struct=
 task_struct *p)
>  	if (task_on_rq_queued(p) && p->dl.dl_runtime)
>  		task_non_contending(&p->dl, false);
> =20
> +	/*
> +	 * A task with no parameters of its own was boosted into the class.
> +	 * Its deadline and runtime are the donor's. Reset them, so that its
> +	 * next entry into the class starts a new period.
> +	 */
> +	if (!p->dl.dl_runtime) {
> +		p->dl.deadline =3D 0;
> +		p->dl.runtime =3D 0;
> +	}
> +
>  	/*
>  	 * In case a task is setscheduled out from SCHED_DEADLINE we need to
>  	 * keep track of that on its cpuset (for correct bandwidth tracking).

[Severity: Medium]
Can a task still retain the donor's runtime and deadline after a PI deboost
when p->dl.dl_runtime is non-zero?

If a task that left SCHED_DEADLINE before its 0-lag time is PI-boosted by a
deadline waiter before inactive_timer fires, switched_to_dl() cancels
inactive_timer and replenish_dl_entity() overwrites p->dl.deadline and
p->dl.runtime from the donor while p->dl.dl_runtime still holds the task's
own prior parameter.  When the task is deboosted, switched_from_dl() sees
p->dl.dl_runtime !=3D 0, skips this reset, and passes the donor's deadline =
and
runtime to task_non_contending(), allowing the task to run on the donor's
runtime if it re-enters SCHED_DEADLINE before that deadline.

Similarly, if a non-deadline task is switched to SCHED_DEADLINE via
sched_setattr() while PI-boosted, prev_class and next_class are both
dl_sched_class, so neither switched_from_dl() nor switched_to_dl() runs.
__setparam_dl() sets p->dl.dl_runtime without clearing the donor's deadline
and runtime (and for a sleeping task, skipping switched_to_dl() also misses
add_rq_bw()), so when rt_mutex_setprio() later restores p->dl.pi_se =3D &p-=
>dl,
enqueue_dl_entity() sees the donor's future deadline and skips
setup_new_dl_entity().

> @@ -3984,7 +3994,8 @@ bool __checkparam_dl(const struct sched_attr *attr)
>  }
> =20
>  /*
> - * This function clears the sched_dl_entity static params.
> + * Clear the static parameters of @dl_se. Also reset its deadline and its
> + * runtime, so that its next enqueue starts a new period.
>   */
>  static void __dl_clear_params(struct sched_dl_entity *dl_se)
>  {
> @@ -3995,6 +4006,9 @@ static void __dl_clear_params(struct sched_dl_entit=
y *dl_se)
>  	dl_se->dl_bw			=3D 0;
>  	dl_se->dl_density		=3D 0;
> =20
> +	dl_se->deadline			=3D 0;
> +	dl_se->runtime			=3D 0;
> +
>  	dl_se->dl_throttled		=3D 0;
>  	dl_se->dl_yielded		=3D 0;
>  	dl_se->dl_non_contending	=3D 0;

[Severity: Medium]
Does zeroing dl_se->deadline, dl_se->runtime, and dl_se->dl_throttled here
without canceling dl_se->dl_timer leave a stale replenishment timer queued
from the old period?

If a task throttles when its 0-lag time is earlier than dl_next_period(dl_s=
e)
(such as after sched_yield() with positive remaining runtime, or with a
constrained deadline dl_deadline < dl_period) and leaves SCHED_DEADLINE,
__dl_clear_params() runs at the 0-lag time while dl_se->dl_timer is still
queued for the old period end.  If the task re-enters SCHED_DEADLINE and
throttles in its new period before that old timer expires, start_dl_timer()
sees hrtimer_is_queued(&dl_se->dl_timer) and skips arming the timer for the
new period, so dl_task_timer() replenishes and unthrottles the task at the
old period boundary instead.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795037078.gi=
t.mathieu.desnoyers@efficios.com?part=3D9
