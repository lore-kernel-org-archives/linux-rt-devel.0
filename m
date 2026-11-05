Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793838991;
	b=2w4FNCyiUdnObQ42Bjp6dAeYbwTwj1L4bdyh0b1wj8VWJiATRuevDJWQ13P8ybR+ogDC
	 F908HO4/+1E+rUtsxkv5HrY06Fq45TyAgPwhSvb736dvsKpUjPYGPk1lrMjZmPmL9xmI5
	 5BWexzTzQcrlFnyPdb24kAzQPxSBMsG718aqFH523mYkmUxqSgU/wPRu76gss8rgVBMaN
	 yPhLkbZTM111565m+qlbY5PLSZgToVIcF7ugcCcNXL3RwgByY7CfoeeiQgAfM12Xsrub6
	 RrcYj349kob3fpRTuAX3ZQBN5CHDWdYYrzHk0my9MLe/gYxnK0HfYjPTtPAjBP/WQpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793838991;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3iNCC6xLWWcFyrcMl4HD2CdXqo+pD0srI7x5T7EPMmM=;
	b=EUO8k3x/lOAdUJPxC2x04mWw5u24XbrWVxjaIkNMbeVKuQFPrdwFfEzOBinvYC2V53j5
	 ijcKos9RqM+PxrRtcrfHjBRikBK1xP/L5qubjb5nXPrLWlLUr7+KAYkrmG/BqlGHglysq
	 IE06dudLP58NlDIBGcmQMePiXyj7Q77U/FLi3Dcj1cIgdd8HcjRaOal1qRyIQyFw+ciD/
	 5hQE3EwZZMPOr01fSGBMyg6QzU/9E4/rK0BwJ4y2YjarWupNUPmdv1Zc7w21/YtkoXQ7B
	 vrnG3/CSG4cndwE226EguGIkPViNZhhj/JecUXVHC9NYULLUQ/xqvqdlmuWYMS6JGkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3cW24Lp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A77606A326;
	Thu,  5 Nov 2026 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S3cW24Lp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2471F000C1;
	Thu,  5 Nov 2026 00:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793838990;
	bh=3iNCC6xLWWcFyrcMl4HD2CdXqo+pD0srI7x5T7EPMmM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S3cW24LpB9eFkriChRv96sf3vIrUpsYPR/7H9wOuvsbckmAQk7cGqn0akDBVSQMrH
	 t2AKHm1IKYi3fc2T+DLtlsA/0jxu6Ra2TOsF9mD4yKf0uBfyiGIndSJe8KIb5Uyhlv
	 1btfYBJTLzxXnRGX4d+9uWIJ3lhw7h59/ZEOyLLMMrixD6WbimCZ3woXXlaGENgsVa
	 z7GOZ2vlaKlXU3yQBC8XtS+AK4xqugwxCytcRVaCj1FTL1n0BPHM/uuGGzgpeRhW9c
	 zN2IXPBWs+MPq81PN5IRFo5QZGKwp3bCZcwt6LVQXt5W+hMwi0ES+om1gi5OgKRpuq
	 J85koQn80bt1Q==
Message-ID: <sashiko-outbox-198366@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 21/21] sched/deadline: Count the bandwidth a boosted
 task is given
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261104211207.1392343-22-mathieu.desnoyers@efficios.com>
References: <20261104211207.1392343-1-mathieu.desnoyers@efficios.com>
 <20261104211207.1392343-22-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 00:36:29 +0000
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
- [Medium] sched/deadline: dl_change_utilization() checks old flags before =
update
--

commit f342e630523d7367eb408895a6057749ace71951
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Count the bandwidth a boosted task is given

This commit moves the runqueue bandwidth accounting update from
sched_dl_overflow() to __setparam_dl() so that tasks already in the deadline
class due to priority inheritance have their new bandwidth added to the
runqueue's this_bw when sched_setattr() sets SCHED_DEADLINE parameters.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 15d224846ebad..a3b45bb4f35e1 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -442,22 +442,32 @@ void cancel_inactive_timer(struct sched_dl_entity *=
dl_se)
>  	cancel_dl_timer(dl_se, &dl_se->inactive_timer);
>  }
> =20
> +/*
> + * The runqueue a sleeping task is on counts the bandwidth the task has:
> + * give it @new_bw in place of what it counts of the task's.
> + */
>  static void dl_change_utilization(struct task_struct *p, u64 new_bw)
>  {
> -	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
> +	struct sched_dl_entity *dl_se =3D &p->dl;
> +	struct rq *rq =3D task_rq(p);
> =20
> -	if (task_on_rq_queued(p))
> +	if (task_on_rq_queued(p) || dl_entity_is_special(dl_se))
>  		return;

[ ... ]

> @@ -4266,6 +4275,18 @@ int sched_dl_overflow(struct task_struct *p, int p=
olicy,
>  void __setparam_dl(struct task_struct *p, const struct sched_attr *attr)
>  {
>  	struct sched_dl_entity *dl_se =3D &p->dl;
> +	u64 period =3D attr->sched_period ?: attr->sched_deadline;
> +
> +	/*
> +	 * The bandwidth of a special entity is counted on no runqueue.
> +	 * The rest have theirs changed here, where their parameters are:
> +	 * switched_to_dl() hands it to the runqueue of a task that enters
> +	 * the class, and a task that priority inheritance boosted into the
> +	 * class is in it already, so nothing dequeues it and enqueues it
> +	 * back for that.
> +	 */
> +	if (!(attr->sched_flags & SCHED_FLAG_SUGOV))
> +		dl_change_utilization(p, to_ratio(period, attr->sched_runtime));
> =20
>  	dl_se->dl_runtime =3D attr->sched_runtime;
>  	dl_se->dl_deadline =3D attr->sched_deadline;

[Severity: Medium]
Does dl_change_utilization() check the old dl_se->flags before __setparam_d=
l()
updates them?

In __setparam_dl(), dl_change_utilization() is called when attr->sched_flags
does not have SCHED_FLAG_SUGOV set, before dl_se->flags is updated from
attr->sched_flags:

kernel/sched/deadline.c:__setparam_dl() {
	if (!(attr->sched_flags & SCHED_FLAG_SUGOV))
		dl_change_utilization(p, to_ratio(period, attr->sched_runtime));

	dl_se->dl_runtime =3D attr->sched_runtime;
	dl_se->dl_deadline =3D attr->sched_deadline;
	dl_se->dl_period =3D attr->sched_period ?: dl_se->dl_deadline;
	dl_se->flags =3D attr->sched_flags & SCHED_DL_FLAGS;
}

If a sleeping task that previously had SCHED_FLAG_SUGOV set in dl_se->flags=
 is
reconfigured via __sched_setscheduler() -> __setscheduler_params() ->
__setparam_dl() without SCHED_FLAG_SUGOV, dl_entity_is_special(dl_se) in
dl_change_utilization() still observes the old SCHED_FLAG_SUGOV flag and
returns early without adding new_bw to rq->dl.this_bw or setting
dl_se->dl_bw_oncpu =3D 1.

Immediately afterward, __setparam_dl() clears SCHED_FLAG_SUGOV in dl_se->fl=
ags,
and switched_to_dl() does not run because the task is already in
dl_sched_class. When the task later wakes up on the same CPU, task_contendi=
ng()
sees !dl_entity_is_special(dl_se) and adds dl_se->dl_bw to rq->dl.running_bw
while rq->dl.this_bw does not include it, triggering:

	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);

Since __setparam_dl() is the only caller of dl_change_utilization() and alr=
eady
checks !(attr->sched_flags & SCHED_FLAG_SUGOV), should the
dl_entity_is_special(dl_se) check in dl_change_utilization() be dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104211207.1392=
343-1-mathieu.desnoyers@efficios.com?part=3D21
