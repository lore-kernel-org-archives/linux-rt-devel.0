Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793806964;
	b=F1faHPCEFKpXxhUKYmLt2fYU8NLeJrcR3lRKrNMB9idU0fNugry8nkhmYJxlCSuJoqAG
	 BFCC4rhg7eT9gBtkaXMFMXBBi6z9/A1oB51ujdmW5hZcPN3ri0P6Mb6VjeoaBxgVwfQHA
	 ib+Q0Mmd4WIWNBl80CCjf5W/crVaCazu+aKQV0iB6Ro37Ye7vjYuMJVCdqefy4zapjMpo
	 cpTKm7kTK/oruaFKDDWr2met/fGuJkNdIdrkj6xX5/l+BetP+4pJeFjZ7laSKiRqwPdGm
	 MjmfmqrgIEFdI7YTNXJNtr8FFCALgrqWGP1/lllMEgLMdvNMAsEM3RDnHpK6HJ7E7IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793806964;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OOrY76HST88toXJHCO5fPSyBCbHQM5OhP9gCTyjkFSM=;
	b=o5QeJbehOh0V8FmitlcexnwoPzBjDPxkP4iojNQ/3C8+i4f/10pi4VT58OkuHX615M24
	 BtCSRZMnoZHmKbd6G2IOELbQRS02BWWnflpMknuGieTWiDdeRs3zU4M54z6Uinc3O3dnZ
	 Tp7wZC1OudvuChuPMSdiuV/5aoOLDKumMvIlhwxFHHBTVm54+N2KMRY0SDbWPnCiDViZb
	 Vn0uu4TqRqfBycBgcpnof1/hTJQrij3PGhC+uykx22/6pXDPtF4kYG9sgcpyKBoPemkX7
	 nGdtHhi+PjRcpwBjKR9T6uS7XqKUVGDCp1vhZBdL990MYciIKbvrwtWtgGlfVe8DnGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFl7Uz8o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D17606A330;
	Wed,  4 Nov 2026 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fFl7Uz8o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C281F000C1;
	Wed,  4 Nov 2026 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793806963;
	bh=OOrY76HST88toXJHCO5fPSyBCbHQM5OhP9gCTyjkFSM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fFl7Uz8oVYtEPklE8rph9f+kECYmHM4odN+OluuEGLAlDcOhzQdagoT+4uHdVXU21
	 kbD1PpUyov86RCaz88Zdp4GK+zRd8v8hL+Q8Rm/YMrHtB2hyF7OFrO+WQu2MRN8PBr
	 YiQg/q6E8jl6T2jQK499YOt5LfWLoVwnzYnBriBaFyAeAaR6sdXMopQhqtH0DHuF7o
	 xkrp/RMulG5w4QJpwgROdzl1hamXyKhIJ+OIaD2qB1+Kroa0JdeyX37BpWrnrSGiQj
	 lhSgEoId4HJEzaOGNMTrH4Ie3UzfqdunRYc8lNuAK291iNj6ESSkJYAIZaicOUHMjN
	 aJCOW8FbOwefw==
Message-ID: <sashiko-outbox-197527@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] sched/deadline: Do not lose a throttled task
 switched out and back
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <1b0485061f99455deaca614016de741f2091c4a8.1793804635.git.mathieu.desnoyers@efficios.com>
References: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
 <1b0485061f99455deaca614016de741f2091c4a8.1793804635.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:42:42 +0000
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
- [Medium] sched/deadline: incomplete replenishment when clearing dl_thrott=
led
- [Medium] sched/deadline: stale dl_yielded left set by dl_task_timer()
--

commit b274aa4dbc0a2822908373f43a14a8b8436d20eb
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not lose a throttled task switched out and back

This commit clears dl_se->dl_throttled in dl_task_timer() when a throttled
SCHED_DEADLINE task has been switched to another scheduling policy before
its replenishment timer fires, so that switching back to SCHED_DEADLINE
before the 0-lag time does not leave the task permanently throttled.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 30a52e42c26d8..d474fbfd9be6d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1232,10 +1232,17 @@ static enum hrtimer_restart dl_task_timer(struct =
hrtimer *timer)
> =20
>  	/*
>  	 * The task might have changed its scheduling policy to something
> -	 * different than SCHED_DEADLINE (through switched_from_dl()).
> +	 * different than SCHED_DEADLINE (through switched_from_dl()). It
> +	 * keeps its parameters until its 0-lag time and may come back to
> +	 * SCHED_DEADLINE before then, switched_to_dl() cancelling the
> +	 * inactive timer: it must not come back throttled, since this was
> +	 * its replenishment. Its deadline has passed: the enqueue starts a
> +	 * new period.
>  	 */
> -	if (!dl_task(p))
> +	if (!dl_task(p)) {
> +		dl_se->dl_throttled =3D 0;
>  		goto unlock;
> +	}

[Severity: Medium]
Could clearing only dl_se->dl_throttled here without calling
replenish_dl_entity(dl_se) forgive negative runtime overruns and leave
dl_se->deadline stale when the task switches back to SCHED_DEADLINE before
its 0-lag time?

The window between the replenishment timer and the inactive timer exists
specifically when a task has overrun its runtime (dl_se->runtime < 0),
making the 0-lag time later than dl_next_period(dl_se). Normal replenishment
in replenish_dl_entity() deducts that overrun from subsequent periods:

kernel/sched/deadline.c:replenish_dl_entity() {
	...
	while (dl_se->runtime <=3D 0) {
		dl_se->deadline +=3D pi_of(dl_se)->dl_period;
		dl_se->runtime +=3D pi_of(dl_se)->dl_runtime;
	}
	...
}

By only clearing dl_se->dl_throttled and leaving dl_se->deadline in the past
and dl_se->runtime negative, a task returning to SCHED_DEADLINE before its
0-lag time enters enqueue_dl_entity(), where setup_new_dl_entity() (on
ENQUEUE_MOVE) or update_dl_entity() (on ENQUEUE_WAKEUP) calls
replenish_dl_new_period(dl_se, rq):

kernel/sched/deadline.c:enqueue_dl_entity() {
	...
	} else if ((flags & ENQUEUE_MOVE) &&
		   !is_dl_boosted(dl_se) &&
		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
		setup_new_dl_entity(dl_se);
	}
	...
}

replenish_dl_new_period() unconditionally resets dl_se->runtime to the full
pi_of(dl_se)->dl_runtime rather than deducting the prior negative runtime
overrun, allowing the task to bypass bandwidth enforcement by switching
policies across its replenishment point.

In addition, in enqueue_dl_entity(), dl_check_constrained_dl() runs before
the ENQUEUE_MOVE branch:

kernel/sched/deadline.c:enqueue_dl_entity() {
	...
	if (!dl_se->dl_throttled && !dl_is_implicit(dl_se))
		dl_check_constrained_dl(dl_se);
	...
}

If the task returns with constrained-deadline parameters (for example, with
a larger dl_period passed to sched_setattr() so that dl_se->deadline <
rq_clock(rq) < dl_next_period(dl_se)), dl_check_constrained_dl() sees the
un-advanced dl_se->deadline and re-throttles the task before
setup_new_dl_entity() is reached. And if the task migrated to another CPU
while in SCHED_OTHER whose rq_clock(rq) has not yet strictly passed
dl_se->deadline when it switches back, dl_time_before(dl_se->deadline,
rq_clock(rq)) evaluates to false and the task is enqueued onto dl_rq with
dl_se->runtime <=3D 0.

[Severity: Medium]
What happens if the task had also called sched_yield() in the period where
it was throttled, leaving dl_se->dl_yielded set to 1 when dl_task_timer()
fires?

In yield_task_dl(), rq->donor->dl.dl_yielded =3D 1 is set before calling
update_curr_dl(rq) -> update_curr_dl_se():

kernel/sched/deadline.c:yield_task_dl() {
	...
	rq->donor->dl.dl_yielded =3D 1;

	update_rq_clock(rq);
	update_curr_dl(rq);
	...
}

If the elapsed execution time in that slice also pushes dl_se->runtime < 0,
update_curr_dl_se() throttles the task with both dl_se->dl_throttled =3D=3D=
 1
and dl_se->dl_yielded =3D=3D 1, and arms the inactive timer for a 0-lag time
later than the deadline when the task switches out of SCHED_DEADLINE.

Unlike replenish_dl_entity() and __dl_clear_params(), which clear both
dl_se->dl_yielded and dl_se->dl_throttled:

kernel/sched/deadline.c:replenish_dl_entity() {
	...
	if (dl_se->dl_yielded)
		dl_se->dl_yielded =3D 0;
	if (dl_se->dl_throttled)
		dl_se->dl_throttled =3D 0;
	...
}

neither the !dl_task(p) path in dl_task_timer() nor replenish_dl_new_period=
()
clears dl_se->dl_yielded. When the task switches back to SCHED_DEADLINE
before its 0-lag time, wouldn't it be enqueued with a stale
dl_se->dl_yielded =3D=3D 1 and immediately get throttled again for an entire
new period on the next call to update_curr_dl_se()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793804635.gi=
t.mathieu.desnoyers@efficios.com?part=3D4
