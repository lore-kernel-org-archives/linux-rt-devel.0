Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793912757;
	b=Hu/D0YNEwfpi3svYPaKmIHd0Vmj+rN3UULHnV4pQbKLlwmICWGigzCB8R8pdxf8Iz4hq
	 k1pwCkFBNpzAfabmmr6l/c/Yl2d5ijc4AViu3cihncKJmBT/+5/fmqSxmwsRnez44W7Dj
	 J+puIAbx94VJ46SLo/ANZUXLZhscZE3Ihn9y0fWgYKIvecKEaUFeBbnvtG1HZUURlNLZm
	 o15ptvGqHCzOfq+d2moCAbfoxylejtsP4Z9OSrRNAnbJtcEL0HsfZk44ezOOVXp4t7JWU
	 Myfn5ByXwedYppXIEPc6CgRbnuDu0kaN5T86bGrtDHxjcFgYRqWRDIgOtnUzFp+NIFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793912757;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OcFFapRSHso21RLBFJiqlZa8OweuDMOPbBc8e6K7CPA=;
	b=TcjUMm+figQqIB6e+2cI7CRoWNIgac0YsIUPzw56D8OrQ+eTMTaA5Lc3FDUvU1ClhqaL
	 pGzGCi9UWBiPjpV09o1srGEjfmtGo35fCBfIvtks+qdZ+Z6ydzo8Cn91B0unGNvm/sd6D
	 0rAEbbnfMFkogvTapvUOBz4SPnha3q1fCmw4Y5Uxog5u57xt1qQN+4G3rQ/sLetYVorDe
	 JCbCWdD+0XEgD2I00cK+346wNyNzgobW114d7s4P9JnF63K7fiekbqbmty+Z+gBWrV2lE
	 5B8jAKb9r0Ka22YFygBBGmYqPkMwdIFp1D8o9BZfxWi76Mx7kW8zLomY+JnwwZo8McA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPKjpUnR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE376606A31B;
	Thu,  5 Nov 2026 21:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UPKjpUnR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157B61F008A3;
	Thu,  5 Nov 2026 21:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793912756;
	bh=OcFFapRSHso21RLBFJiqlZa8OweuDMOPbBc8e6K7CPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UPKjpUnRmOphUJBINCGoazM1kWcok3N1pKV8C7W2Qp18a1gJ0z9mPwn/qlEc4cFIN
	 TWpBCpqXhwgImV+W/uaCHDEwSnDfESwpptJh00vZBg/9cZuS5H1lLYqJpekl9f6cfX
	 Uegy8fdGegdVXOhnhLfBTYLbQU1PPQzgUyFktpNitwoLpoXTeaW7pZBinU/B4DQ7Wd
	 7JE6Z6RFqPioOKX3QdpdKtNAmGez2QlIuFqKMiXprO/P9r1sfLy4qDel5unZkKLUeb
	 9jgklW2BpGORyahtwEO/9BXXbbSXRJxUeCS3QO+WMhjJ9sUfQCinhdvfYkRMX7i5hJ
	 U5hOTQ0XYsXIw==
Message-ID: <sashiko-outbox-200183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 19/24] sched/deadline: Cancel the replenishment timer
 with the parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261105193359.1450487-20-mathieu.desnoyers@efficios.com>
References: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
 <20261105193359.1450487-20-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:05:55 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] sched/deadline: premature bw and timer release in switched_from_=
dl()
--

commit d600ad50b186384ae85393fc674963e28ed720fb
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Cancel the replenishment timer with the parameters

This commit cancels the deadline replenishment timer when clearing
a task's deadline parameters at its 0-lag time in task_non_contending()
and inactive_task_timer(), and when releasing bandwidth and clearing
period state for a sleeping task in switched_from_dl().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index bcf7f88b204ad..f772a944a3e53 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -3920,8 +3922,10 @@ static void switched_from_dl(struct rq *rq, struct=
 task_struct *p)
>  		 * boosted owner would never leave its loop over a dl_period
>  		 * and a dl_runtime of 0.
>  		 */
> -		if (released)
> +		if (released) {
> +			cancel_replenish_timer(&p->dl);
>  			__dl_clear_state(&p->dl);
> +		}
>  	}

[Severity: Medium]
Can this cancel p->dl.dl_timer, clear the period state, and release
total_bw before the task's 0-lag time has actually passed if the task
switches back to and from dl_sched_class while asleep?

1. Suppose a SCHED_DEADLINE task p has an armed replenishment timer
(p->dl.dl_timer) and a future 0-lag time, and either blocks and then
switches to SCHED_OTHER, or switches to SCHED_OTHER while throttled and
then blocks. In switched_from_dl(), task_non_contending() has armed
p->dl.inactive_timer, and switched_from_dl() clears
p->dl.dl_non_contending and calls dl_task_depart(p):

kernel/sched/deadline.c:switched_from_dl() {
	...
	if (p->dl.dl_non_contending) {
		p->dl.dl_non_contending =3D 0;
		dl_task_depart(p);
	}
}

2. While p is still asleep (!task_on_rq_queued(p)) and before its 0-lag
time passes, p re-enters dl_sched_class (via sched_setattr() or a
priority inheritance boost in rt_mutex_setprio()). Because p is not
queued on the rq, enqueue_task_dl() is not called, and switched_to_dl()
cancels p->dl.inactive_timer without re-arming it:

kernel/sched/deadline.c:switched_to_dl() {
	cancel_inactive_timer(&p->dl);
	dl_task_undepart(p);
	inc_dl_tasks_cs(p);

	/* If p is not queued we will update its parameters at next wakeup. */
	if (!task_on_rq_queued(p)) {
		add_rq_bw(&p->dl, &rq->dl);

		return;
	}
	...
}

At this point, p is asleep in dl_sched_class before its 0-lag time with
p->dl.dl_non_contending =3D=3D 0 and no inactive_timer armed.

3. If p then leaves dl_sched_class again while still asleep (via
sched_setscheduler() or PI deboost in rt_mutex_setprio()) before its
0-lag time, switched_from_dl() skips task_non_contending() because
task_on_rq_queued(p) is false, and enters the !task_on_rq_queued(p)
branch where p->dl.dl_non_contending is 0:

kernel/sched/deadline.c:switched_from_dl() {
	if (task_on_rq_queued(p) && p->dl.dl_runtime)
		task_non_contending(&p->dl, false);
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
		if (released) {
			cancel_replenish_timer(&p->dl);
			__dl_clear_state(&p->dl);
		}
	}
}

Wouldn't switched_from_dl() treat p->dl.dl_non_contending =3D=3D 0 as meani=
ng
the 0-lag time has already elapsed, and prematurely release total_bw via
dl_task_release_bw(p), cancel p->dl.dl_timer, and clear dl_throttled,
runtime, and deadline via __dl_clear_state(&p->dl) while the task is
still before its 0-lag time?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105193359.1450=
487-1-mathieu.desnoyers@efficios.com?part=3D19
