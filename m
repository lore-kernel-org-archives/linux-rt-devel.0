Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121597;
	b=qPwdGmTskKXgAzveoXdYScvm84Rpr4AhCvX1oAZWyR2ZnyXXzV1OVnulgWUgnAsqCe2t
	 YtBXVUd28z4tIgC+Qm1Xly9f2l8v/L8svjq35jSGyKOBH8ezCt72n/tz0fD1MTcJ4S7cJ
	 8TNhCmSrwThIOlhWpozrtAfrGhnprBXhaLww4CxKZUe4uMfRXyiZ2L2z8fL9do/VRFHL+
	 yRD0Nu7bJjAzvD8kpUdMctHFD6VUYzBo+p5yCt5ZuTL0qkAQR4afnBpHAb4h4MFKtQFzj
	 PXNJf3RrDCEqj+Ek1339oSo+IaWxpFmBUR4wEfFiXKf2x2H2w/euO/sjBN2baR6fjLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121597;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LlxCWovDTUv+Qu6Xloj+MVtQaPY7xSjf/N7WJ3qIRa4=;
	b=CwOWDImrgDJ5+uYesRVvNUFVMVBCRbveJQx/lgW/QrxDzv5SQkmw8Vx9dHUSgb0uDU+c
	 HyWupYfpKspRl1WXhwcn03n+5GDvE7n9GSMsaYFyndypvGvomn0+3rQQIEERm5WYxE1LK
	 vZqTT5k2PlzIoOk4kvooc5AR9RfbPjjvr8CJnkq3Z3rBR7cYjSefRu5t2T3H3xjBwvnsA
	 BV+WnIRbAYxYycLh6ZWTKJ9rwDt8SfibpPZ6P3P0oM0VE2Pui+YShgzyVm7lOh9tICtMo
	 3VAiL5MurbNzqQmoRN+RYVpaZN08E5iZkF2m/TZq5ck6C8Rpx+DfDr0dRMadVljSN7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwA2oXYH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B8606A337;
	Thu, 19 Nov 2026 20:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BwA2oXYH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 734B51F000D0;
	Thu, 19 Nov 2026 20:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121596;
	bh=LlxCWovDTUv+Qu6Xloj+MVtQaPY7xSjf/N7WJ3qIRa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BwA2oXYHBiTAVGgyEes6oF6C5mTiYQQiVTaFUr5p+5Q/FDR5D77T0XoY6gjzisqBu
	 OGrym0/wI2KXpKQ2Iy2eRQO+Qwj72YBWOS2B3nL2LYyyRDjbYhMuNYbpP6lyLGaKa/
	 qC+U6w9XFM9nvdK++YqF52cKbe1ewwsbX/bPEPrZt7pEtN6A6WrAfDEqAXm3sXnKK/
	 v6nTTm3YG2g+OlBeOruEhAoWy2SWkYWG3QHGpf36M2OsbKapxbKC+D/FnPksC4BQFt
	 8EvIdHhNnejpF6ONgOuLTAQluBpIfg0mwzk16kIbLrJpOKG8+K1FbnnWXKahHsQu2p
	 yGoBJDws+y/hg==
Message-ID: <sashiko-outbox-224059@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 23/33] sched/deadline: Reset the donor's runtime at a
 deboost in the class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <a6b2af72b10e67a5865158280c3955e4f8169a24.1795116791.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <a6b2af72b10e67a5865158280c3955e4f8169a24.1795116791.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:53:15 +0000
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
- [Medium] sched/deadline: missing dl_note_donor_refill() in
  replenish_dl_entity()
- [Medium] sched/deadline: dl_entity_preempt() precedes dl_deboost() in
  rt_mutex_setprio()
--

commit 99ad044e86f7c0f67e987d30b947babfc918e9b4
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Reset the donor's runtime at a deboost in the class

This commit tracks whether a boosted deadline entity had its runtime
refilled from its donor's reservation via a new dl_donor_refill flag, and
starts a new period from the task's own parameters when the boost ends in
SCHED_DEADLINE.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index fe2919be3775b..781eff6455250 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -7957,16 +7957,26 @@ void rt_mutex_setprio(struct task_struct *p, stru=
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
Can a SCHED_DEADLINE task keep a departed donor's refilled runtime and
deadline when switching to another deadline top waiter?

Before this else branch, rt_mutex_setprio() checks
dl_entity_preempt(&pi_task->dl, &p->dl) against p->dl.deadline.  If a
previous donor refilled p (setting p->dl.dl_donor_refill =3D 1) and pushed
p->dl.deadline past the next waiter pi_task->dl.deadline, that outer
check succeeds and skips dl_deboost(&p->dl).  Because p->dl.dl_deadline
is non-zero and p->dl.runtime can still be positive from the previous
donor's refill, ENQUEUE_REPLENISH in replenish_dl_entity() does not reset
p->dl.runtime or p->dl.deadline, leaving p running with the previous
donor's remaining runtime and postponed deadline.

Calling dl_deboost(&p->dl) before testing dl_entity_preempt(&pi_task->dl,
&p->dl) for dl_prio(p->normal_prio) tasks would also avoid duplicating
the re-boost check in the else branch.

[ ... ]

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 914915abb912d..66a1150c4811a 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -1150,6 +1187,7 @@ static void replenish_dl_entity(struct sched_dl_ent=
ity *dl_se)
>  		if (!dl_se->dl_deadline) {
>  			dl_se->deadline =3D rq_clock(rq);
>  			dl_se->runtime =3D 0;
> +			dl_note_donor_refill(dl_se);
>  		}
>  		if (dl_se->runtime < 0 || dl_se->dl_yielded)
>  			dl_se->runtime =3D 0;

[Severity: Medium]
Should the (dl_se->runtime < 0 || dl_se->dl_yielded) path also call
dl_note_donor_refill(dl_se)?

When a boosted SCHED_DEADLINE task (dl_se->dl_deadline !=3D 0) exhausts its
runtime or yields after its donor's parameters have been cleared, this
branch clamps dl_se->runtime to 0 and clears dl_se->dl_throttled without
recording the refill.  At deboost, dl_deboost() sees
dl_se->dl_donor_refill =3D=3D 0 and leaves the task queued with
dl_se->runtime =3D=3D 0, so it throttles on the next tick instead of starti=
ng
a new period with its own reservation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795116790.gi=
t.mathieu.desnoyers@efficios.com?part=3D23
