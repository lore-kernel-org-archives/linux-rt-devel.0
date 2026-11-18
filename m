Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795034812;
	b=XzQl/DI97AiOQb85nsDmvzKU+Qp0M/VpcRFtrbdA+1iyoBARcMmpwabeLMqT3SsdGlgU
	 TwuV0twKH9qCu0KvhmNtYFg5Wlcoy5/onw7xP3bxBgKd2c+kziwhC7QQoXUZuQX1o9NBt
	 QToxKohyx8v1AlHUqFyDIfNw/MAVPjz7xFub9RbnjtwfMoHXMN0wwkwma9/de2u0SC2Ne
	 loQE87jZYQfah8i2ONXMYeeEE6lHKyg9KsQrJ6X2GmGMp/bkkEE/Ugw1EFgElIm935MxO
	 s5QFDds9QDgZN05KkFilpSfiTqF7SLz82b60nc4PMrhH9XwNB8Vj6tyuYS15HxWO0iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795034812;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Eg0XzdvsEqmccfhqdHEUxS2yLLGQS7q2fittqu67Nio=;
	b=jOlG4wFmjKRkxB/skyPLdO9AL5zisLMs9Afhk+rQqDgDVgcuG1jMB3sCKjn/MUiQlYOS
	 YPNl3WlklPYrlzTtpw7RayuAdUGINPlpevF0rlDpqh+r4w7Dk38z7VZDT12/WHshJ+DqK
	 h1LNdOKhlSsdO1Eeiq5FFfszdycKqa9aIY1+IO6e9oAd2Fz4BcnpgdojynoMQeQDGs7zO
	 DbEycwEnQ28oijZCSpbcjeM3Tuzh28zH3xbz1rQrs0nOHP5o7zZm/HH+ERNsObAn7Wdia
	 tx7AQ6abrftLQd2SSRrstIeUw1Cc8D/XJvPkg25Hb8SfLCM2g5AfGLywbYCGa6Rw/Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVZbf3AT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3940606A31C;
	Wed, 18 Nov 2026 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mVZbf3AT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5160E1F000C4;
	Wed, 18 Nov 2026 20:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795034812;
	bh=Eg0XzdvsEqmccfhqdHEUxS2yLLGQS7q2fittqu67Nio=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mVZbf3ATxrMwmdoUt1Z3tljbRPjouXrcCFx2Np28wizoYVVQn8tT4gS23RXWomWSY
	 3EZJYpmjy61UYIKrj4NCCIP9gI6Z68tG3mdfgMVkXEnJkO2AtcA+ycmmb+OS+fVDpD
	 Cs4n2Xs8z6vgCbgykw4dmvGqVLEHLu7WJ1Di3a/F25flsHJBo7iYwMaugyc6/BHQSI
	 TXX555MHULJKP8KgmsGyUd4NhixcyurNobQPwcleHLtlScE8QVqKNlh9/+wyd5oPEc
	 0KXUAVpX4oQrgxH5Ew+VY+UwSoYikRsZR11/EgT6NZ9ChIEMKyNs4HcviYVXUXBwyV
	 dPEzCW8+QWvcw==
Message-ID: <sashiko-outbox-221950@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/16] sched/deadline: Fix this_bw when a task is
 changed during a remote wakeup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <dfe9865764c347295703c25e9a781438784f061b.1795031605.git.mathieu.desnoyers@efficios.com>
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <dfe9865764c347295703c25e9a781438784f061b.1795031605.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 20:46:51 +0000
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
- [Medium] sched/deadline: this_bw desync in add_rq_bw() for PI-boosted
  tasks
--

commit 31f5271550e5299348b26e477800f7ac60f7e6c1
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Fix this_bw when a task is changed during a remote wakeup

This commit introduces a dl_bw_oncpu bit in struct sched_dl_entity to track
whether a runqueue's this_bw currently accounts for the task's bandwidth,
preventing bandwidth drift when parameters change during a remote wakeup.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index f0e03f97fd82f..c36516210669d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -267,18 +267,35 @@ void __sub_rq_bw(u64 dl_bw, struct dl_rq *dl_rq)
>  	WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw);
>  }
> =20
> +/*
> + * @dl_se->dl_bw_oncpu tells whether the this_bw of a runqueue counts the
> + * bandwidth of @dl_se. add_rq_bw() adds the bandwidth only if no runque=
ue
> + * counts it. sub_rq_bw() subtracts it only if one does.
> + *
> + * A wakeup on another CPU takes the bandwidth off the old runqueue. The
> + * enqueue on the new CPU adds it back later. A change of the task in
> + * between must not count the bandwidth twice, nor take it off a runqueue
> + * that does not count it.
> + *
> + * The servers track their bandwidth with dl_bw_attached. They call
> + * __add_rq_bw() and __sub_rq_bw() directly.
> + */
>  static inline
>  void add_rq_bw(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
>  {
> -	if (!dl_entity_is_special(dl_se))
> -		__add_rq_bw(dl_se->dl_bw, dl_rq);
> +	if (dl_entity_is_special(dl_se) || dl_se->dl_bw_oncpu)
> +		return;
> +	__add_rq_bw(dl_se->dl_bw, dl_rq);
> +	dl_se->dl_bw_oncpu =3D 1;
>  }

[Severity: Medium]
Can add_rq_bw() set dl_bw_oncpu =3D 1 while dl_se->dl_bw is 0 for a PI-boos=
ted
non-deadline task, causing dl_rq->this_bw to miss a later SCHED_DEADLINE
bandwidth assignment?

When a non-deadline task (dl_runtime =3D=3D 0, dl_bw =3D=3D 0) is PI-booste=
d into
dl_sched_class via rt_mutex_setprio(), enqueue_dl_entity(ENQUEUE_RESTORE) or
switched_to_dl() calls add_rq_bw(), which adds 0 to this_bw and sets
dl_bw_oncpu =3D 1.

If sched_setattr() assigns SCHED_DEADLINE with new_bw > 0 while the boosted
task is unqueued (either sleeping or on a remote wake_list), prev_class and
next_class are both &dl_sched_class so ENQUEUE_CLASS is not set, and
!task_has_dl_policy(p) is true so sched_dl_overflow() skips
dl_change_utilization().  __setparam_dl() then sets p->dl.dl_bw =3D new_bw
while dl_bw_oncpu is already 1 and this_bw still has 0.

When the task finishes waking up, task_contending() calls add_rq_bw(), which
returns early because dl_bw_oncpu is 1, and then add_running_bw() adds new_=
bw
to running_bw, triggering WARN_ON_ONCE(dl_rq->running_bw > dl_rq->this_bw).
When the task later migrates, leaves SCHED_DEADLINE, or exits, sub_rq_bw()
subtracts new_bw and underflows this_bw.  Should add_rq_bw() also return
early when !dl_se->dl_bw (or !dl_se->dl_runtime)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795031605.gi=
t.mathieu.desnoyers@efficios.com?part=3D12
