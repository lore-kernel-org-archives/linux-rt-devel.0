Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838334;
	b=nMk7+oKiS/aJAjHhRY8uRgdti5LD+wswDM2ju7KsNXzMukL62wXcgOSStNzDbWWuVUk8
	 ZAJ/iZ/gtUc6+V6glBAruKe/TY8uQYDZ1Qf30CSBj0Y/tl1+mzGbjUI2TJRVY06x97DYr
	 vDApgh8SxkXsbEGcpNWR0Z0tcH8NjdY3FS/ydeLxvRYp/WW6/nvY4sOn9TaL3lrJBkum5
	 yA7HsWBBWCBDjV+g2F45juLXmBnYNx+6uztjwqhQYHydVAhGpREyYk/N5a1W6rLJl+qDx
	 g37pBRwEW8S2L338awvuk+zI/Yyjcpwy7QRlrXO+ZZ0GeV5xnM3WjoMGq9jqGpAxFng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838334;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/ONf8LMPh39a51yT19bDLCqB+BxgwtV1gv/DgxnpC7o=;
	b=oCEa3BsUN+YMrmYCj9h52MLO8Ay802+1udFUpLktQDNzpwPYI0dAjOtQgdvXNELKkqJi
	 VQjdUHX8eu0mucd3Iih0YOFHu88ILyHf4FOQgrFZ8taGF4HQsb3zu7K3ceciwimpIWTAB
	 9Arg0S/iRESZRLn4gXMswVkMVr5dV3QXW7oGP6rhTHklJzp8LFFYp0kiPBo0ZXzFPuOcT
	 432sHsmTGvq4tCcc2+6nHWmerGHsnXQilkXKQOOOJS9FR8z2eP7V+5M6oEyujOvcTG1Eu
	 kTse5F37cZwc7g0YemnjylHb1904dqyL3zuOyb2jHgtTdxcWVAnpOprlngo/agwBMsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1SbKH31;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF74D606A326;
	Thu,  5 Nov 2026 00:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1SbKH31
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2EF1F000C1;
	Thu,  5 Nov 2026 00:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793838333;
	bh=/ONf8LMPh39a51yT19bDLCqB+BxgwtV1gv/DgxnpC7o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c1SbKH31TGZRbkfH1Tb66B0+W6n23rioM1Sioo2I1JGCfp4lmzBOSb60nSh21Vft/
	 W3nXvs6DBSwAcdCSYQxhi+/L5HD0KaE9llqTY9X0hxLYOjP3eHHPx0EvEVlhtPA8ZY
	 UI3T6LCzp7upLPU8cd662pVH1PCo+qXkau/Xexg0KEFrNoAnQvqAEwrBsKkOUfmKe1
	 ae/SlzK9cv5meg7I0BYQnP9nbLCQdX7/pzUGD9peVWlyzpiVNPunOwF48iGbHtjCsq
	 fs6EA356LLFuY4Ji8hhsy6MSWL2zxyzqDjVgEaQ6sBUsSX3ViPKEUR7Fka2nvUjReb
	 R213ix6x1/t5g==
Message-ID: <sashiko-outbox-198356@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 20/21] sched/deadline: Cancel the replenishment timer
 with the parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261104211207.1392343-21-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-21-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:25:32 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] sched/deadline: stale deadline and runtime left by __dl_clear_pa=
rams()
- [Medium] sched/deadline: uncancelled dl_timer in switched_from_dl() for s=
leepers
--

commit 88a7a115f1789bc812516cdb6cea3464930cdccf
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Cancel the replenishment timer with the parameters

This commit cancels a deadline task's replenishment timer in
task_non_contending() and inactive_task_timer() when clearing its parameters
at the 0-lag time after leaving SCHED_DEADLINE. This prevents a task that
re-enters SCHED_DEADLINE before the old period expires from keeping the
armed replenishment timer of its previous reservation.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c0af06d0f3688..15d224846ebad 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -563,6 +563,7 @@ static void task_non_contending(struct sched_dl_entit=
y *dl_se, bool dl_task)
>  				if (READ_ONCE(p->__state) =3D=3D TASK_DEAD)
>  					sub_rq_bw(dl_se, &rq->dl);
>  				dl_task_release_bw(p);
> +				cancel_replenish_timer(dl_se);
>  				__dl_clear_params(dl_se);
>  			}
>  		}

[Severity: Medium]
When cancel_replenish_timer() and __dl_clear_params() run at the 0-lag time
in task_non_contending() or inactive_task_timer(), __dl_clear_params()
clears dl_throttled and dl_yielded along with the static reservation
parameters, but leaves the dynamic dl_se->deadline and dl_se->runtime from
the old reservation intact:

kernel/sched/deadline.c:__dl_clear_params() {
	dl_se->dl_runtime		=3D 0;
	dl_se->dl_deadline		=3D 0;
	dl_se->dl_period		=3D 0;
	dl_se->flags			=3D 0;
	dl_se->dl_bw			=3D 0;
	dl_se->dl_density		=3D 0;

	dl_se->dl_throttled		=3D 0;
	dl_se->dl_yielded		=3D 0;
	...
}

For the two cases described in the commit message where the 0-lag time is
reached before the old period ends, could leaving dl_se->deadline and
dl_se->runtime set cause problems if the task returns to SCHED_DEADLINE
before the old deadline or period expires?

In the first case, a task yields (or leaves with remaining runtime > 0), so
its 0-lag time is earlier than dl_se->deadline. After the 0-lag time passes
and releases the old bandwidth and clears dl_throttled and dl_yielded, if
the task returns to SCHED_DEADLINE before the old dl_se->deadline,
enqueue_dl_entity() checks whether the deadline has passed on the
ENQUEUE_MOVE path:

kernel/sched/deadline.c:enqueue_dl_entity() {
	...
	} else if ((flags & ENQUEUE_MOVE) &&
		   !is_dl_boosted(dl_se) &&
		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
		setup_new_dl_entity(dl_se);
	}
}

Because the stale dl_se->deadline is still in the future,
setup_new_dl_entity() is skipped and the task runs with its leftover
dl_se->runtime and old dl_se->deadline (regaining runtime it forfeited when
yielding, or exceeding a smaller new dl_runtime after its old bandwidth was
already released).

In the second case, a constrained-deadline task overruns slightly and
reaches its 0-lag time after dl_se->deadline, but before dl_next_period().
If it switches back to SCHED_DEADLINE as a constrained-deadline task before
the old period ends, enqueue_dl_entity() runs dl_check_constrained_dl()
before reaching the ENQUEUE_MOVE check:

kernel/sched/deadline.c:enqueue_dl_entity() {
	...
	if (!dl_se->dl_throttled && !dl_is_implicit(dl_se))
		dl_check_constrained_dl(dl_se);
	...
	if (!dl_se->dl_defer && dl_se->dl_throttled && !(flags & ENQUEUE_REPLENISH=
)) {
		if (flags & ENQUEUE_WAKEUP)
			task_contending(dl_se, flags);

		return;
	}
}

Seeing dl_se->deadline in the past and rq_clock(rq) before dl_next_period(),
dl_check_constrained_dl() sets dl_se->dl_throttled =3D 1 and re-arms dl_tim=
er
for the old period, causing enqueue_dl_entity() to return early without
initializing the new reservation.

Should __dl_clear_params() also reset dl_se->deadline and dl_se->runtime?

> @@ -2326,6 +2327,7 @@ static enum hrtimer_restart inactive_task_timer(str=
uct hrtimer *timer)
>  		}
> =20
>  		dl_task_release_bw(p);
> +		cancel_replenish_timer(dl_se);
>  		__dl_clear_params(dl_se);
> =20
>  		goto unlock;

[Severity: Medium]
What happens if a constrained-deadline task overruns slightly as it blocks,
reaches its 0-lag time while still sleeping in SCHED_DEADLINE, and only then
switches out of SCHED_DEADLINE before its replenishment timer fires?

When the task blocks in dequeue_task_dl(), update_curr_dl_se() sees the
runtime overrun, sets dl_se->dl_throttled =3D 1, and starts dl_se->dl_timer
for dl_next_period(). Then dequeue_dl_entity() calls
task_non_contending(&p->dl, true).

If the 0-lag time passes while the task is still asleep and still in
SCHED_DEADLINE, task_non_contending() or inactive_task_timer() drops
running_bw and clears dl_non_contending, while dl_throttled remains 1 and
dl_timer remains armed.

If the sleeping task is then switched to another scheduling class before
dl_timer fires, switched_from_dl() takes the !task_on_rq_queued(p) &&
!p->dl.dl_non_contending branch:

kernel/sched/deadline.c:switched_from_dl() {
	...
	if (!task_on_rq_queued(p)) {
		bool released =3D false;

		if (p->dl.dl_non_contending) {
			sub_running_bw(&p->dl, &rq->dl);
		} else if (p->dl.dl_runtime && !dl_entity_is_special(&p->dl)) {
			dl_task_release_bw(p);
			released =3D true;
		}
		sub_rq_bw(&p->dl, &rq->dl);
		if (released)
			p->dl.dl_bw =3D 0;
	}
}

Because neither task_non_contending() nor inactive_task_timer() runs on this
path, dl_task_release_bw(p) releases the bandwidth while leaving
p->dl.dl_timer armed and p->dl.dl_throttled set to 1. If the task returns to
SCHED_DEADLINE before the old dl_timer expires, enqueue_dl_entity() sees
dl_se->dl_throttled =3D=3D 1 and returns early without enqueuing the task u=
ntil
the old period ends.

Should switched_from_dl() also cancel the replenishment timer and clear the
throttled state when releasing a sleeping task's bandwidth past its 0-lag
time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104211207.1392=
343-1-mathieu.desnoyers@efficios.com?part=3D20
