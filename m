Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106983;
	b=pzcEVM2NWvat7rFJV1OQHdKkaY1ZPcHeOFZHGR9iW1zITRwMdPw7t20LmQu+HnTCTBFG
	 8chZ61yq/2jy85QCvcRdC9S0dxPf3O0vAq+J3AP+cmQ3IdWilJzhHWbCIIZ/770h9VJna
	 pSHD6KGb5qUHFKYviCZMrCBm6GQ57O6IPWH9Qc8bkf/yUyGQOyF8q854gw82xECgjch0v
	 HdljalblbPC74Se6A3Kal+NFKyknl8ADbK5MRP94W6LGV1LVYJSdPJYMr0YpoIcj0AUw1
	 vavjktgG62gCYKaV4HJuUvewXANdp+Lr/ZMnPXaKcEd1hNpqiSehc+cFuLhGNkAgJJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106983;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mCFd4aA2ku+UX9hcU6OoqxiyVSj+I5zYR2+NoCDs4N0=;
	b=d6L0AdiP5Qkphao1DMpHzTiMFfpNEJ7q/PQpUJ/oyYvlThfMo4M2C86QElo3qRu8cKj1
	 AnYyX52K3GhhbGa+qVNSoJZq5IBRuJg4/HfrZP8MIYiMhrXs2H8ALfu2ZF5/ZL0BERkMu
	 FF/IOu1Sz4Gukga40gyCmZs7+SkhwKrtvKQgYieWVt/HKYqwOQ30cWiBaAeEXTt6SAO54
	 RFZpccDbKUGqpE5xnc9LLnZDfjmelP0ihBF0Tq9mbVpJtqdwvcRDrle8pcEjUy7AXPMRw
	 yiJ75v7UtDVGrkFAOjpkcjnlOmGsXM9QlnQrxJWBMqJnOVRqRpdvUn/LVjYZ/hw3M1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChhAjHuw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B5A60A261E;
	Thu, 19 Nov 2026 16:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChhAjHuw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D77B1F000C8;
	Thu, 19 Nov 2026 16:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106982;
	bh=mCFd4aA2ku+UX9hcU6OoqxiyVSj+I5zYR2+NoCDs4N0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ChhAjHuwRDzWFyANhcrPIXeH2Yy7ZoWswioUwveQOLenHie1+6WPs+eebzoisZW39
	 rrEbwT7kSBHAOGySWoGUOr+HzLk0LV+N8+xeW3m5x2torxn0AebPD62QXdFl4YJdCA
	 CKUNpZibVn1SNy9XXfH/bMaTC6IuHGh5VB2O394lWX7geBJXjv36n+MvmNNWQRvLbc
	 cTBYlLE7wwYEVsBfZsFi4OziiI/rxP2DKWJyRRy3QWnjpAXVoJ0GxVORaIHSGlO0XF
	 iW7u0FHSiWFvjRZ0etnBb7c1Ai7QqP6ztP/LX91kVjOz+5ss2E6tEPXfG/AsrQiggI
	 YFZS9l9bRGnHQ==
Message-ID: <sashiko-outbox-223577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v4 09/17] sched/deadline: Reset the deadline and
 the runtime with the parameters
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795105408.git.mathieu.desnoyers@efficios.com>
References: <cover.1795105408.git.mathieu.desnoyers@efficios.com>
 <07a810645c5ab919a52ffe2cc4b63074a84751fb.1795105408.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 16:49:42 +0000
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

commit 2c25e238b8ef61f400892fff248fbabebd5863e5
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Reset the deadline and the runtime with the parameters

This commit resets dl_se->deadline and dl_se->runtime in __dl_clear_params()
and in switched_from_dl() when a boosted task with no deadline parameters of
its own leaves SCHED_DEADLINE, so that the next entry starts a new period.

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

[Severity: Medium]
Can a task still retain the donor's deadline and runtime after PI deboost w=
hen
p->dl.dl_runtime is non-zero?

If a non-deadline task is PI-boosted by a SCHED_DEADLINE waiter and calls
sched_setattr() to enter SCHED_DEADLINE while still boosted, prev_class and
next_class in __sched_setscheduler() are both &dl_sched_class, so neither
switched_from_dl() nor switched_to_dl() runs.  __setparam_dl() sets
p->dl.dl_runtime without clearing the donor's deadline or runtime (and if p=
 is
sleeping, skipping switched_to_dl() also skips add_rq_bw(), later triggering
WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw) and underflow in
__sub_rq_bw()).  When rt_mutex_setprio() later deboosts p, it stays in
dl_sched_class and restores p->dl.pi_se =3D &p->dl without ENQUEUE_REPLENIS=
H, so
enqueue_dl_entity() sees the donor's future deadline and skips
setup_new_dl_entity(), letting p run unboosted on the donor's remaining
runtime.

Similarly, if a task leaves SCHED_DEADLINE before its 0-lag time (or changes
policy while boosted via __setscheduler_dl_pi()) and is replenished from a
donor while p->dl.dl_runtime is still non-zero, switched_from_dl() on deboo=
st
skips this !p->dl.dl_runtime reset and passes the donor's deadline and runt=
ime
to task_non_contending().

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
Does resetting deadline, runtime, and dl_throttled in __dl_clear_params()
without canceling dl_se->dl_timer leave a stale replenishment timer queued?

When a task yields with remaining runtime (or uses a constrained deadline w=
ith
dl_deadline < dl_period) and is throttled, its 0-lag time arrives before
dl_se->dl_timer fires at dl_next_period(dl_se).  If the task switches out of
SCHED_DEADLINE while throttled, __dl_clear_params() runs at the 0-lag time =
and
clears deadline and dl_throttled while dl_se->dl_timer remains queued.  If =
the
task re-enters SCHED_DEADLINE before that old timer expires,
enqueue_dl_entity() starts a new period, and when the task throttles in the
new period, start_dl_timer() bails out because hrtimer_is_queued(timer) is
already true:

kernel/sched/deadline.c:start_dl_timer() {
	...
	if (!hrtimer_is_queued(timer)) {
		if (!dl_server(dl_se))
			get_task_struct(dl_task_of(dl_se));
		hrtimer_start(timer, act, HRTIMER_MODE_ABS_HARD);
	}

	return 1;
}

When the stale dl_timer fires at the old period boundary, dl_task_timer()
replenishes and unthrottles the task in the middle of its new period, allow=
ing
it to exceed its reservation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795105408.gi=
t.mathieu.desnoyers@efficios.com?part=3D9
