Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209702;
	b=fOIngYXvAU6Ji2Alnqvsw4PLsbBsWCqWZzNn/rAt+WhPG3u2ulzXUeonSn3J3BDG+Cys
	 NVkPZ7SAoze+3MnKG4JE/eJ1aNeJsKtmD6ymP7wxb1BScIKsnJMvY1tNBdkKYFDpuuhxz
	 /K6GU6/o/mZlGrtLZ/gyzmWe8XIbQ6Zwr1YdQN+M1QHeo4Jern/Ycdts5T0MGlC0Z/EyI
	 GkrXU7yzTC6XIsO//Ie67j01Lya6d7B9f/Xr46MOWHnetBatzv3bp5thIKjXs8GN8vW01
	 wnEnuGlfY6ymv/SMYMdy+7rPejQR/syT4+CmSt/QRR8ti32/8dX7bNlIxO+GtKj2O3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209702;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=x3Dpiu4WGDnRCbf+/G2EMShJL7tFWJHjHn6VMGZ42nA=;
	b=jJRkSydtfhO3e1w1lxQoAucIPMCrnwqNgv9QjezlUYkoPN03ycR6uBrJ3eFT9dL2ymIe
	 H3mQCCebZj3diw8IUCne7vNKWBxT7aTJS9JZhtWWON6nzcqQC/OhbvCJWRcemjEcoxpEk
	 pk5GcquF4khQqIjHiuxKDotmNvPTWvSJsh4qZzHpRBwM8Ru3plKfCywsZlTCfMmVtaJUg
	 pwv5C6vSvrMPIaRF7XWIBrNSlyYwn2TO3ue6Xmf3UQIn3t+RcKDnn8LQJJhJGkxmBYuC4
	 +I2WLcAeu/ox8g7hQf+WG2KiweqTTvGz9OUdXoRv2Ctpxhiknf3LlKqo3GQ1NHEUBIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RY9n0HZJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFCD606A6AE;
	Fri, 20 Nov 2026 21:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RY9n0HZJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EC61F000D3;
	Fri, 20 Nov 2026 21:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209700;
	bh=x3Dpiu4WGDnRCbf+/G2EMShJL7tFWJHjHn6VMGZ42nA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RY9n0HZJ3qiiPkbxfa8fpFfBkSrGR3/UAvw428PwN174AxM0zUAdn6WsUc/FyRE9z
	 L18fYka+h1yvxpZnqXVS8kZD3K7XyQOzCPGzrDpGiV/uXJsRCBBHFN8su5pqdMPl48
	 TloDyCARF4HO8sW8ZXOeUnsKeexQYx5Vf1WFGjX+T6ZoT1iWz+ZQzp12gGcRwaVKPV
	 Fa++hIZlRY08LNt/S3IeqbZjGE5bYM/V3xMsFD1uaQTmSOvZ6aldHvOKhFjB+ap3Dv
	 yFQgtdq0Zf0c3AwBrORLVam3WAevHUEm2aaB/Noh5/9fd6DwG2WkBe77Y0Od5Dc36S
	 tmJVETkAUycoQ==
Message-ID: <sashiko-outbox-226164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 37/40] sched/deadline: Keep the start of the period
 across a change of dl_deadline
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <3360961974ba9401f7d6d4d7d5fd513db04c9fc5.1795207233.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <3360961974ba9401f7d6d4d7d5fd513db04c9fc5.1795207233.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:21:40 +0000
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
- [High] sched/deadline: replenish_dl_entity() keeps old dl_deadline
  across periods
- [Medium] sched/deadline: dl_is_implicit() bypasses constrained gap on
  dl_deadline growth
--

commit f729f2d93fa31589edb8491dd221ca94c6da13fe
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep the start of the period across a change of dl_deadline

This commit records the start of each deadline period in
sched_dl_entity::period_start and uses it in dl_next_period() and
dl_in_constrained_gap() so that mid-period changes to dl_deadline via
sched_setattr() do not shift the computed start of the next period.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b9c206a59c164..e9b3d3ec71d77 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c

[ ... ]

> @@ -103,7 +104,7 @@ static inline bool dl_in_constrained_gap(struct sched=
_dl_entity *dl_se)
>  	u64 now =3D rq_clock(rq_of_dl_se(dl_se));
> =20
>  	return !dl_is_implicit(dl_se) && dl_time_before(dl_se->deadline, now) &&
> -	       dl_time_before(now, dl_se->deadline - dl_se->dl_deadline + dl_se=
->dl_period);
> +	       dl_time_before(now, dl_se->period_start + dl_se->dl_period);
>  }

[Severity: Medium]
Can a constrained task whose dl_deadline is increased to equal dl_period
during an active period still bypass throttling in the gap between its
current deadline and its next period?

When sched_setattr() sets dl_deadline =3D=3D dl_period mid-period,
dl_is_implicit(dl_se) becomes true while dl_se->deadline is still earlier
than dl_next_period(dl_se).  Because dl_in_constrained_gap(),
enqueue_dl_entity(), update_dl_entity(), and dl_proxy_block() gate their
constrained-deadline checks on !dl_is_implicit(dl_se), a task waking
between dl_se->deadline and dl_next_period(dl_se) skips
dl_check_constrained_dl() and receives a new period and full runtime early
via replenish_dl_new_period():

kernel/sched/deadline.c:enqueue_dl_entity() {
	...
	if (!dl_se->dl_throttled && !dl_is_implicit(dl_se))
		dl_check_constrained_dl(dl_se);
	...
}

[ ... ]

> @@ -1425,6 +1429,7 @@ static void replenish_dl_entity(struct sched_dl_ent=
ity *dl_se)
>  	 */
>  	while (dl_se->runtime <=3D 0) {
>  		dl_se->deadline +=3D period;
> +		dl_se->period_start +=3D period;
>  		dl_se->runtime +=3D runtime;
>  	}

[Severity: High]
Does advancing dl_se->deadline by period here keep the old relative
deadline offset across future periods after sched_setattr() changes
dl_deadline?

With start_dl_timer() now arming the replenishment timer at
dl_se->period_start + dl_se->dl_period instead of shifting by the old
dl_deadline, dl_se->deadline at replenishment time is still
period_start + old_dl_deadline.  Adding period to both dl_se->period_start
and dl_se->deadline leaves dl_se->deadline at
new_period_start + old_dl_deadline instead of
dl_se->period_start + deadline, so subsequent periods continue using the
old relative deadline and can falsely throttle the task in
dl_check_constrained_dl() or grant a second replenishment mid-period in
update_dl_entity().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D37
