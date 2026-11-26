Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657559;
	b=WkfQUpsTbZNj46OfLQrozz/B5A2rXw3nLL7z0gCMfopvl81JZPI+BTo7lwbqIKhUwn9X
	 PkuxHy8rAEXh2bxsQvN2DY/Mmu2MrKP02zEdz9RIC6hbSB+FXvA5NgPgQZiMj/FVQtx/G
	 K+9SsLbQt6z4ybDi4DPI+54ZejPsIUz3Ype3C9+tNbsocCoIJX6fZUh5ZA9wgUOucr37n
	 +hr1HsjII9/HiyF15tJQwRHDboG1PX7gPdjQtatuv5D6kWn8tyIcriVGJmafO4fCD0muB
	 rBkGdDpFr0h+ox9J6FpDBTL7JJTAe4nO/bdwatiPQv76lz7wXe5Z+mdMy7s+qNZ8Jpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657559;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wOhUMvOvzQ8J+fcRHlkBq0U3V2e+VS9gVMFOQhS8dQs=;
	b=Xs/c1XrS92fA7CAEUFHCy4SYI2oQZtua4Yu70bePFRfzdba1R92BBC3s1vo85/Z6KCJG
	 YLCnA2jrBOVwS+geAvfBvCqmZjRx7PxIEtPy/9c2Xk9Jb/mjCqLBufgilbWG/v+D4Kvp2
	 4KEFdZj3BB5JV/g0HDSh8jLkBwWr58QKp19TFdPJUHXqm7BmH3G2/GMnloJGgie0hEVfC
	 CS9ZhC7pl1cjl3PQ/9jMEvYhJpZ61HAbfivSp89UrRAAl9ZE7tT9AK6p65nogqHbzTaW6
	 mWqQXOnDwWr9oLOfnDtmNBHdLwVTNUIxuqoHxjklZ6iql54VCJLbX0Exm+bu89y6GAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjrVGjAa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A34606A32A;
	Thu, 26 Nov 2026 01:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjrVGjAa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2201F000C0;
	Thu, 26 Nov 2026 01:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795657558;
	bh=wOhUMvOvzQ8J+fcRHlkBq0U3V2e+VS9gVMFOQhS8dQs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GjrVGjAakC8OkdW1fK2I8A5QPIeuCtc5H8ojbMum9uqWMPQzLjgHaEUuF8zbY2Cpj
	 Ly8FYtKruP/GsUnDx/+CSdUvkTWD/bkaq+eKR642zS62BJ3wJXp4jgI9K8AwYqtsvu
	 dyINV/1B1Ef0MP34caKP8qIu7PcH4b20ywEiqXhDAmmHk4/GLPRLj6pKqMI+Z3WnAH
	 8EFAsgcEpg92hbIMs2OBY4oHPXWcE/xf6RP/7lqct4QcNftDgi7vHVsIQ8RJfPs0CR
	 a0ijZOvCHZC24QNK4iy3IseWUGrX+BUZ/1WDXv0CmyRDsECh2tjenjBeh1itjmUDOF
	 sNNHHhGnzf2/w==
Message-ID: <sashiko-outbox-234583@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 34/43] sched/deadline: Cancel the replenishment
 timer with the parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <85ae6bb1ce221469c21c31a352a703aceed394ed.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <85ae6bb1ce221469c21c31a352a703aceed394ed.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 01:45:58 +0000
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
- [Medium] sched/deadline: dl_task_timer() extends departed constrained
  task by a period
--

commit b4f4668865f16f00f3ee081d72d2725e00494e96
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Cancel the replenishment timer with the parameters

This commit cancels a task's deadline replenishment timer alongside
clearing its deadline parameters in task_non_contending() and
inactive_task_timer().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index c59953e80b1a9..828923a771076 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -2895,6 +2896,7 @@ static enum hrtimer_restart inactive_task_timer(str=
uct hrtimer *timer)
>  		}
> =20
>  		dl_task_release_bw(p);
> +		cancel_replenish_timer(dl_se);
>  		__dl_clear_params(dl_se);
> =20
>  		goto unlock;

[Severity: Medium]
Can dl_task_timer() fire before inactive_task_timer() at
dl_next_period(dl_se) for a departed constrained-deadline task, pushing
its bandwidth release and parameter reset out by an extra period?

When a constrained-deadline task is throttled without a runtime overrun
(for example via sched_yield()), start_dl_timer() queues dl_se->dl_timer
for dl_next_period(dl_se).  If the task then leaves SCHED_DEADLINE,
task_non_contending() or inactive_task_timer() queues
dl_se->inactive_timer for that same dl_next_period(dl_se) timestamp
without cancelling dl_timer.  Because dl_timer was queued in the hrtimer
tree first, it fires first at dl_next_period(dl_se):

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

replenish_dl_entity() advances dl_se->deadline by dl_period.  When
inactive_task_timer() runs right after, it sees
dl_next_period(dl_se) - rq_clock(rq) =3D=3D dl_period > 0 and returns
HRTIMER_RESTART instead of reaching dl_task_release_bw(),
cancel_replenish_timer(), and __dl_clear_params():

kernel/sched/deadline.c:inactive_task_timer() {
    ...
	if (!dl_task(p) && READ_ONCE(p->__state) !=3D TASK_DEAD &&
	    !dl_is_implicit(dl_se)) {
		s64 left =3D dl_next_period(dl_se) - rq_clock(rq);

		if (left > 0) {
			ktime_t at =3D ktime_add_ns(hrtimer_cb_get_time(timer), left);

			hrtimer_set_expires(timer, at);
			task_rq_unlock(rq, p, &rf);
			return HRTIMER_RESTART;
		}
	}
    ...
}

The departed task's bandwidth remains locked in dl_b->total_bw for an
extra period, and if the task returns to SCHED_DEADLINE after the phantom
deadline it is throttled with zero runtime until that extra period ends.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D34
