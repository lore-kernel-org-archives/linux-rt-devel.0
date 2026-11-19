Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795097248;
	b=MV2txTCkBETfT7n5dUVBt131Fp8kEsazOLQkClaLelgQO8T8fucBghQc43CtFjxjsog2
	 TNrd9IHQrqH4kLyKfcPInJB4oLeQ+JNR93J20hRi3wXLiatBjetndzu6k9D4hYHJp9yIU
	 oThsCogLKyuZKg+VvZzpUbEoxC+xMpRnELzY3CKYEo1zfWzT8hG4e1WLRe4uh8HYQLhpz
	 e3h6IGsORCNKK+HWlJ8vJ26kZRT6uoEZAnJWnhR2aiLAaCH/uzpz9lqqe5L2M1Ep/u87V
	 3vahYCJ0a6DjTEGvTjN+ut5oLX5CjUGzTM6ldz8TeSTVNpZR3+xVvyL4cjlbif/UrEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795097248;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CgYEg/LphU9tZTrlUiyYU3UR+8AQufN5dyMmm+cvWxU=;
	b=MxJ/Olz+ufuxGl2OvjSmNpZyXkod+E2+pUac2eq0jfFpOGoEJxg/QA6zvPylXK46SUMK
	 5WA3jnhFvN6VIDSlzZnlrbXNOYALPIdU1tDCRRy9jbf709c0TOaSlK1njV34UtOWX5LjE
	 2kaA1UuH5q9gLAGobIk9AItMQ44eArWqkg3ozITaTIgSHAjixHD3uSYiBVZZnY1n0ujkb
	 Vv4e7t8tH3gd2yKYU1Jf6AG/8N6Og7HM4MG74dPNjoAOo+GUT3I/RnKzdgscx6nVealNV
	 aJyDWW9ZaVFOK9XGhA5W881uAwEWDLSiNMD/LL6rDDgkeYMqb5WVGBTSHoluPAlXahg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KF/0eClK";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBC8606A325;
	Thu, 19 Nov 2026 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KF/0eClK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7FF1F000C5;
	Thu, 19 Nov 2026 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795097247;
	bh=CgYEg/LphU9tZTrlUiyYU3UR+8AQufN5dyMmm+cvWxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KF/0eClKkjzarJypJ37zNTjAY2lrEFQp+sBGuAzb+tt4NMUSisheHKC3UqSaIURBs
	 +vaZEEVcnFOCbgGQPPydQR8PjlAkGgNxVPAUAw+wvk+GoZmjC5/8X4pAOCS2QrV8l6
	 +E7Fcf0Xi4W5A0RcqNn9jKkUGDovcZ9C5nihFftadHltti39s/PVAqEDLYBfdNnZeD
	 ws4x/vCI5BfPLnlKTtjqdFkCTpWU0z0oLXq0Wn5neXjkC/yb+UTfY65CAg/G3J/ekC
	 +UPqZty2x5JcWS8Xj1FzZqB4bGfhspcajL5ynmRVgeYo4OkJz37fK7g2oDyokM5DpF
	 K01skBo+qbr6w==
Message-ID: <sashiko-outbox-223251@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/17] sched/deadline: Fix an overflow of the 0-lag
 time with long periods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <b341033dd787d5bd4a5259cf654fb725f57629c2.1795092090.git.mathieu.desnoyers@efficios.com>
References: <cover.1795092090.git.mathieu.desnoyers@efficios.com>
 <b341033dd787d5bd4a5259cf654fb725f57629c2.1795092090.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 14:07:26 +0000
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
- [Medium] sched/deadline: divide error and overflow in
  task_non_contending()
--

commit 8f3d9963b4f77fcaacfd297c2fa7927bf18777cd
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Fix an overflow of the 0-lag time with long periods

This commit replaces div64_long() in task_non_contending() with
mul_u64_u64_div_u64() so that computing the 0-lag time does not overflow
64-bit multiplication on long deadline periods.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d6d2657dcddd6..86297ef5ac076 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -425,9 +425,20 @@ static void task_non_contending(struct sched_dl_enti=
ty *dl_se, bool dl_task)
> =20
>  	WARN_ON(dl_se->dl_non_contending);
> =20
> -	zerolag_time =3D dl_se->deadline -
> -		 div64_long((dl_se->runtime * dl_se->dl_period),
> -			dl_se->dl_runtime);
> +	/*
> +	 * The 0-lag time is the deadline minus the runtime left, scaled by
> +	 * dl_period / dl_runtime. The product of the runtime and dl_period
> +	 * can overflow s64 with periods of a few seconds, so multiply on 128
> +	 * bits. The runtime is negative after an overrun.
> +	 */
> +	if (dl_se->runtime >=3D 0)
> +		zerolag_time =3D dl_se->deadline -
> +			mul_u64_u64_div_u64(dl_se->runtime, dl_se->dl_period,
> +					    dl_se->dl_runtime);
> +	else
> +		zerolag_time =3D dl_se->deadline +
> +			mul_u64_u64_div_u64(-dl_se->runtime, dl_se->dl_period,
> +					    dl_se->dl_runtime);

[Severity: Medium]
Can mul_u64_u64_div_u64() trap with a divide error (#DE) on x86-64 or
overflow s64 zerolag_time when |dl_se->runtime| exceeds dl_se->dl_runtime?

On x86-64, mul_u64_u64_div_u64() uses an unguarded divq instruction that
traps with #DE whenever the quotient does not fit in u64, and even when it
fits in u64, a quotient above S64_MAX wraps s64 zerolag_time into the wrong
sign.

|dl_se->runtime| is not bounded by dl_se->dl_runtime when root raises
sysctl_sched_dl_period_max: for example, if an active task with a 140s
runtime and period calls sched_setattr() to lower sched_runtime to 1024 ns
while dl_se->deadline is still in the future, __setparam_dl() updates
dl_se->dl_runtime to 1024 without clamping dl_se->runtime, and
enqueue_dl_entity() skips setup_new_dl_entity():

kernel/sched/deadline.c:enqueue_dl_entity() {
    ...
	} else if ((flags & ENQUEUE_MOVE) &&
		   !is_dl_boosted(dl_se) &&
		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
		setup_new_dl_entity(dl_se);
	}
    ...
}

When the task then blocks or leaves SCHED_DEADLINE, task_non_contending()
divides 140e9 * 140e9 by 1024 (> U64_MAX) and panics in divq with rq->__lock
held (or in the else branch when a task with dl_runtime =3D 1024 ns and a
large dl_period overruns by a scheduler tick before blocking).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795092090.gi=
t.mathieu.desnoyers@efficios.com?part=3D10
