Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657446;
	b=OcFISvheG3tZXO3zOZLVNeV3k6QXvyqDQE1otjAa0ivJxqlkn+4V6u5/eP5jpP0pWSTB
	 sk8jRr+KlCT5BbRxSRiucwvliJF3UMMIr9FU3R5g/tr6xrL1JaHyNWNKtlXkh7XcANqYi
	 uHfB5FIlJFn9u664cEDCOadaZga1AIT37SOAtz+6Ur8ohOQzbG6Yz62NY2k/+RM8QHyYH
	 R9yVCDZ0Z3oN2OUgF2gCg668qxY4ZxDGYflX0RSZ64OQPxUSjCgnkkOWAA/X1A3HG4eGP
	 Qr/1F+cPBnMggwD4SzyHTVx6usawVN4hrIFwcNxRNT9vLbmYgWxwr0YaGgKPc4zGO9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657446;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m2RvOd+XVd5bUt3hWNxmT4fsaJ6Zs1eWnplpITK5zkM=;
	b=HcNhDi38sryuJG/eeaHC6Zv86XAUJ8AoLLI3S6YIBWOG8vHw8TdULXOOY4PZz7HE1VSd
	 FXxbBO88CQ3XBQibnwuEDGYBgnPy7FASZRn+cJkAXrSCmtURfw/d9aBj8IStht3fJZi4y
	 SR6gtggY1v1e3oGm/kgjkSIgd2fPguAVIpoPVj0TdQt/JicYNKmusI73956UR5+WH0Fsq
	 P47tnUzDlxUqHmt8WTfL/ygSf5X438EgCk2SYIaWOuN8bNOJZQKxDANe6Qj7QIfm2HfKQ
	 wS9sUhKAVRV9JUB4DNjw9RpUg7u5atqM5ETbbfQFhQhI24VS/E8sLsy/vCxoBu8PiEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8U3mk9p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41F4606A32D;
	Thu, 26 Nov 2026 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8U3mk9p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9671F000C4;
	Thu, 26 Nov 2026 01:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795657445;
	bh=m2RvOd+XVd5bUt3hWNxmT4fsaJ6Zs1eWnplpITK5zkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C8U3mk9pQgmlVvzan6WdUvkg1YqZYTQR3I/tLHfiXXuK85/mFtHcVkbq9HzgCQ7y9
	 ZFCJxXa04fxacBzjZQlaEFIjjyI1Otx2B39N57RigOwpgKarn25XXoEFXKK5edGnee
	 roOWchZlfsBCuBXjl38zKUrOrxLzYg4xNTkTrQzAGrnIZup9nZJzH2n8PD5E77Z2a/
	 Ha8Eq+cLmmBrK+ORoG3MdjHVEBqAAkpT/GaOZKpnAuNVKkDspObdo4gV3fAx/TiDDL
	 6SUmn+Yq7F+mbf5Vu7OOHP5DAfBxu/2xJOD3lRAA64ets2LaLAYf13huEndA/G3woc
	 ey2w7ztXi6sLw==
Message-ID: <sashiko-outbox-234581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 26/43] sched/deadline: Keep a departing constrained
 task until its next period
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <06ad8ff186e425049082d0ee9b6518f85406257d.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <06ad8ff186e425049082d0ee9b6518f85406257d.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 01:44:05 +0000
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
- [Medium] sched/deadline: dl_task_timer() advances period before
  inactive_task_timer()
- [Medium] sched/deadline: HRTIMER_RESTART in inactive_task_timer()
  races with cancel
--

commit 43e71343c7049144c9877a7ba7fddb15005d58e2
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep a departing constrained task until its next period

This commit keeps a departing constrained SCHED_DEADLINE task's bandwidth
and deadline until the later of its 0-lag time and its next period in
task_non_contending() and inactive_task_timer().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 1d2dcf478f95d..11774b3b9fe93 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -2598,6 +2614,25 @@ static enum hrtimer_restart inactive_task_timer(st=
ruct hrtimer *timer)
>  	if (dl_server(dl_se))
>  		goto no_task;
> =20
> +	/*
> +	 * A constrained task which has left the class keeps its bandwidth
> +	 * and its deadline until its next period, as in
> +	 * task_non_contending(). This timer may have been armed for the
> +	 * 0-lag time while the task was still in the class.
> +	 */
> +	if (!dl_task(p) && READ_ONCE(p->__state) !=3D TASK_DEAD &&
> +	    !dl_is_implicit(dl_se)) {
> +		s64 left =3D dl_next_period(dl_se) - rq_clock(rq);

[Severity: Medium]
Can dl_task_timer() advance dl_se->deadline before inactive_task_timer()
computes dl_next_period(dl_se), holding the departed task's bandwidth for
an extra period?

When a constrained task is throttled before leaving SCHED_DEADLINE,
dl_se->dl_timer remains armed for the end of the departure period while
dl_se->inactive_timer is armed for max(0-lag time, dl_next_period(dl_se)).
When dl_task_timer() fires at the period boundary while !dl_task(p), it
replenishes the entity:

kernel/sched/deadline.c:dl_task_timer() {
    ...
	if (!dl_task(p)) {
		if (dl_se->dl_throttled && !is_dl_boosted(dl_se)) {
			sched_clock_tick();
			update_rq_clock(rq);
			replenish_dl_entity(dl_se);
		}
		goto unlock;
	}
    ...
}

replenish_dl_entity() adds dl_se->dl_period to dl_se->deadline until
dl_se->runtime > 0.  When inactive_task_timer() then runs at the period
boundary (or later at the 0-lag time after an overrun), dl_next_period()
is computed from the replenished dl_se->deadline, so left > 0 and
inactive_task_timer() restarts for another full period instead of
releasing the task's bandwidth and clearing its parameters.  If the task
re-enters SCHED_DEADLINE during that extra period after the advanced
deadline, dl_check_constrained_dl() also throttles it until the end of the
second period.

> +
> +		if (left > 0) {
> +			ktime_t at =3D ktime_add_ns(hrtimer_cb_get_time(timer), left);
> +
> +			hrtimer_set_expires(timer, at);
> +			task_rq_unlock(rq, p, &rf);
> +			return HRTIMER_RESTART;
> +		}
> +	}

[Severity: Medium]
Can returning HRTIMER_RESTART after task_rq_unlock() race with
cancel_inactive_timer() in switched_to_dl() and leave inactive_timer
queued after the task returns to SCHED_DEADLINE?

cancel_dl_timer() assumes that when hrtimer_try_to_cancel() returns -1,
the running callback will finish with HRTIMER_NORESTART and drop the task
reference.  Because __run_hrtimer() only re-acquires cpu_base->lock and
re-enqueues the timer after inactive_task_timer() returns, another CPU can
run switched_to_dl() in between:

CPU0                                  CPU1
__run_hrtimer()
  inactive_task_timer()
    hrtimer_set_expires(timer, at)
    task_rq_unlock(rq, p, &rf)
                                      __sched_setscheduler()
                                        task_rq_lock(p, &rf)
                                        switched_to_dl()
                                          cancel_inactive_timer(&p->dl)
                                            hrtimer_try_to_cancel() -> -1
                                        task_rq_unlock(rq, p, &rf)
    return HRTIMER_RESTART
  raw_spin_lock(&cpu_base->lock)
  enqueue_hrtimer(timer, base, ...)   <-- queued while p is in DL

p is then back in SCHED_DEADLINE with dl_non_contending =3D=3D 0 while
hrtimer_active(&p->dl.inactive_timer) is true.  If p blocks or leaves
SCHED_DEADLINE before that stale timer fires, task_non_contending() sees
hrtimer_active(&dl_se->inactive_timer) and immediately subtracts
running_bw or releases the task's bandwidth and clears its deadline before
the 0-lag time.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D26
