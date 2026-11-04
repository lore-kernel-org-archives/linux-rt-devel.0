Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807108;
	b=QK7THlb4P3w6ZvBgPId8q94bvlkGkH+q8hbGg35zqc/eXvj71B/XqDfPtJjPIODTuscH
	 CdC0+us9cHEouSEHKCKcTWdpy797fvSfQb6QwnXxDdOQKtQ+jMPOpWw6GNI6A20X0HTIm
	 2iQEfx1FPIMmi8UxFCnlfehFENxFUn1vVP5XRFkW0TlSNi6IpRlT4Li6hQimCeCGnNDGO
	 3OzPJCWXicPFDzkwXlLN0eDRxdbIxlaBqTtpwsCnhpqQNq4GagmAyOdimnpKxr1rqGJVn
	 cmZr6Iox/QVSz+NhKteKkqB9cXpggvhYG92LEZ9moJvGzqASTyLP1+eEjieQbc5BM2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807108;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z4CCc46y3/2NIWh2Af04uPLjxR6LiWLu1foNS8mTlVA=;
	b=shYuZ2TODxYrKsfl2Ak6pUelxdb7aOSGRSsrrKh0UOGyRQpUT8VYWmYz/RtAe/3fa/bh
	 zZ3wD29bjv0zOxMsHf8/dL/c37XyX+91ploTZbh8JO5fWkg0wCZjOJhWyDrItRLPawL2/
	 4Vcn5GYFzehF+4IxtV8l9foPnG+uNRMN3/PkmBDj22uP1eMGAfTltSOQBJ30iBSi+UxKB
	 Vbo867YL2ZoJsVMzdysBocJNJL+JtboZ67B8df31ITW9VP6TWly3sdbVg7APU/OL9K3WY
	 2XzmFB4EAPM4wjpGfFW2nwYKGmGrNTTOEQ1eTa/3twdhZJMvrlYlxKjj0PEhmknypSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihX+Jzlm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD493606A326;
	Wed,  4 Nov 2026 15:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ihX+Jzlm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 348751F00A15;
	Wed,  4 Nov 2026 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807107;
	bh=z4CCc46y3/2NIWh2Af04uPLjxR6LiWLu1foNS8mTlVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ihX+JzlmmmwTcudd2BzANdPB3v/LWqLjcz5KyzJuFpL0kpIidBY+B9bBxD2I9G+YS
	 O2azdgBPg6QubVJyqfIR7jqlyOPNv9Du5qjbimiFn3uSvJ1KOHhd/a/ZHWO/YvZLBg
	 kWiwHzSFJCGd5NQt4Xb47GbyDAuVJh1Keloe1s0dQ6QNzP17/QGGAGG1rkyAib+q9s
	 wZoigep5QqEAS4UX9XDSgusvf0HHYPJKepUmTS9qwGtLbcbmVDnf8JReNCaF2TeS5j
	 VBCW+s3IuswIZB4nyl4TbeYZqh18YjmqoWFR7BEQp5rgEJDTqob9S/3VUhx4Bt+7Db
	 V72SRo5tGncFQ==
Message-ID: <sashiko-outbox-197534@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/12] sched/deadline: Do not take a waking task's
 bandwidth off a runqueue it left
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <828cd80ec6e4764f04f8667fc98d7aa22d2bf076.1793804635.git.mathieu.desnoyers@efficios.com>
References: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
 <828cd80ec6e4764f04f8667fc98d7aa22d2bf076.1793804635.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:45:06 +0000
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
- [High] sched/deadline: double add_rq_bw() in task_contending() on wake_li=
st switch
- [Medium] sched/deadline: migrate_task_rq_dl() leaves dl_bw_offrq set for =
dl_runtime =3D=3D 0
--

commit 38f78e09a172accddd40a9e36af4e6c19f0febc1
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not take a waking task's bandwidth off a runqueue it left

This commit adds a dl_bw_offrq bit to struct sched_dl_entity to track when a
waking deadline task has had its bandwidth removed from its previous runque=
ue
by migrate_task_rq_dl() but has not yet been enqueued on its target CPU. Wh=
ile
dl_bw_offrq is set, dl_change_utilization() and switched_from_dl() avoid
subtracting the task's bandwidth from the target CPU's runqueue before the
wakeup enqueue charges it via add_rq_bw().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 8ead9b050dfcf..a8906cf966401 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -2785,6 +2794,12 @@ static void migrate_task_rq_dl(struct task_struct =
*p, int new_cpu __maybe_unused
>  		cancel_inactive_timer(&p->dl);
>  	}
>  	sub_rq_bw(&p->dl, &rq->dl);
> +	/*
> +	 * Until the enqueue on the CPU it wakes on charges it there, which
> +	 * add_rq_bw() tells of, this bandwidth is on no runqueue: the rq of
> +	 * task_cpu() is not the one it was taken from.
> +	 */
> +	p->dl.dl_bw_offrq =3D 1;
>  	rq_unlock(rq, &rf);
>  }

[Severity: Medium]
What happens if a non-deadline task boosted via priority inheritance (with
p->dl.dl_runtime =3D=3D 0) blocks and migrates on wakeup through
try_to_wake_up() -> set_task_cpu() -> migrate_task_rq_dl()?

Here migrate_task_rq_dl() unconditionally sets p->dl.dl_bw_offrq =3D 1, but
when the wakeup enqueues the task via enqueue_task_dl() ->
enqueue_dl_entity() -> task_contending(), task_contending() returns early
before calling add_rq_bw():

kernel/sched/deadline.c:task_contending() {
	if (dl_se->dl_runtime =3D=3D 0)
		return;

	if (flags & ENQUEUE_MIGRATED)
		add_rq_bw(dl_se, dl_rq);

Because switched_from_dl() only clears dl_bw_offrq when !task_on_rq_queued(=
p),
won't p->dl.dl_bw_offrq remain stuck at 1 after the wakeup completes?

If the task later blocks while still PI-boosted in dl_sched_class and
sched_setattr() assigns it SCHED_DEADLINE parameters, __sched_setscheduler()
sees prev_class =3D=3D next_class =3D=3D &dl_sched_class and does not call
switched_to_dl(). Wouldn't the stale p->dl.dl_bw_offrq =3D=3D 1 then cause
dl_change_utilization() or a subsequent switched_from_dl() while blocked to
skip updating rq->dl.this_bw?

> @@ -3736,7 +3751,9 @@ static void switched_from_dl(struct rq *rq, struct =
task_struct *p)
>  			dl_task_release_bw(p, dl_task_root_domain_cpu(p));
>  			released =3D true;
>  		}
> -		sub_rq_bw(&p->dl, &rq->dl);
> +		if (!p->dl.dl_bw_offrq)
> +			sub_rq_bw(&p->dl, &rq->dl);
> +		p->dl.dl_bw_offrq =3D 0;

[Severity: High]
Can this leak p->dl.dl_bw into the target CPU's rq->dl.this_bw when a task
queued on the target CPU's wake_list switches out of SCHED_DEADLINE and back
into SCHED_DEADLINE before sched_ttwu_pending() runs?

When try_to_wake_up() migrates a waking deadline task and queues it via
ttwu_queue_wakelist(), p->sched_remote_wakeup is set to 1 while
!task_on_rq_queued(p) and migrate_task_rq_dl() sets p->dl.dl_bw_offrq =3D 1.

If the task then leaves SCHED_DEADLINE before sched_ttwu_pending() runs,
switched_from_dl() sees p->dl.dl_bw_offrq =3D=3D 1, skips sub_rq_bw(), and =
clears
p->dl.dl_bw_offrq =3D 0. If the task is then switched back to SCHED_DEADLINE
(or if a non-deadline task on the wake_list with p->sched_remote_wakeup =3D=
=3D 1
switches to SCHED_DEADLINE) while still waiting on the wake_list,
switched_to_dl() charges the target CPU's rq->dl.this_bw immediately:

kernel/sched/deadline.c:switched_to_dl() {
	...
	/* If p is not queued we will update its parameters at next wakeup. */
	if (!task_on_rq_queued(p)) {
		add_rq_bw(&p->dl, &rq->dl);

		return;
	}

When sched_ttwu_pending() subsequently runs on the target CPU, it sees
p->sched_remote_wakeup =3D=3D 1 and calls ttwu_do_activate() with WF_MIGRAT=
ED,
which passes ENQUEUE_MIGRATED into enqueue_task_dl() -> enqueue_dl_entity()=
 ->
task_contending():

kernel/sched/deadline.c:task_contending() {
	...
	if (flags & ENQUEUE_MIGRATED)
		add_rq_bw(dl_se, dl_rq);

Since task_contending() checks (flags & ENQUEUE_MIGRATED) rather than
dl_se->dl_bw_offrq, won't it call add_rq_bw() a second time on the target
CPU's dl_rq even though switched_to_dl() already added p->dl.dl_bw and clea=
red
dl_bw_offrq?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793804635.gi=
t.mathieu.desnoyers@efficios.com?part=3D9
