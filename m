Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106809;
	b=EC6cATs9Abc2JyMBwIacR9rCp4pYLPYcjboUuv9iRzpDPQ/6kYZZhWwWdMhU6n7sxLb+
	 aK/sWB+xM6NuDYhTwvewzZa2uaKkZDYX491ZA1cdtlf586OCTFsKOa5REJKvAAvUbtxED
	 ygadPLOq/Yzsgkud7+NGZrDiLBY7YYhBu3sIk41eTODY2fHsy+/CNN4qSQecg1uLfITJG
	 pNGTMk1YaerzwBsTu10YuK+EmGnRCi0UlhQC7S3WkWW42MIanWLmm4Tfft+gNc3gW/Rrr
	 1J2XBIzFhRCeddxZHu+lfDFBigOxJJh5yQuj9CSpJIyJmdoOVwFWMg6702PR0jiUMuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106809;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MlDbLgLPuNZcMAsDODqgwgftrdMr5sjSBNjIff1nty0=;
	b=j7DiGA5qFWK6DOiAxpBpYq/ivdP3OYy+bgsw6JVjRUH9o5h7YTaZPq1pwQ63GNgUSpt7
	 CJw14WB6E7ABmk7EZ2XGWH2aaxmey/VzSd0lOSRrarAYoh/9HPY76ZdavS2ey2sopNpmn
	 Sf1VHazq4yY/qVzXCM610CTAEeCXQ9zCQGIASWH8Qj94UOZtkR/7HJMItZZO8b0vLsoIF
	 7AM7Zjqu2lN5lr0bN1QcXivZVAuLW0s2O8VLCkLOHdbd4FeogrJyS1F21jtCtCDg0McVM
	 xidCOrm1aCkYZ9Y5OIIqGeoxVwTSy5B/b8JEIjPwDqwYCyMO7DhW98ZF7T5i2qS2sMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IF0sETFY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0340B606A32C;
	Thu, 19 Nov 2026 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IF0sETFY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 429EA1F000C8;
	Thu, 19 Nov 2026 16:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795106808;
	bh=MlDbLgLPuNZcMAsDODqgwgftrdMr5sjSBNjIff1nty0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IF0sETFY6beQJlTaL6FZaFYEvjitD50FclFdTOcwIHN+8zHfxnw3h22KuZZbXfOhc
	 yzlE3K0I2RzU+FPW+/AyqX3C4G7D9SSloOgpx3XR/+2H+3DQFqVmX40t8HTqyP5Ost
	 Pf21DnKTpeJR3CkFCDYlZ+D7ELops8ywIW4SSqvqvwSwDMNqGegFeDR6b0HNsu7qK7
	 9BCnIZG7DH0OE+u84LG1DXFBdnRJ2bm+IFsBT0fe1Qb0gMajqwe69PfRtI5xfa26ZM
	 VqtGzmoEtrmgqDA1mucxx3mb5uj2zmfCOVsPGdc+vHFekhVl8rnrUt8+Y+zWvVI/wM
	 EmYo3WZd2HxAA==
Message-ID: <sashiko-outbox-223567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v4 10/17] sched/deadline: Fix an overflow of the
 0-lag time with long periods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <abbad2aa0ec392b1b0ede00b66b2d177d2b7b2df.1795105408.git.mathieu.desnoyers@efficios.com>
References: <cover.1795105408.git.mathieu.desnoyers@efficios.com>
 <abbad2aa0ec392b1b0ede00b66b2d177d2b7b2df.1795105408.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 16:46:47 +0000
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
- [Medium] sched/deadline: unguarded overrun division in
  task_non_contending()
--

commit d4e10a0b92da9c2b0b15604d4fa7ca96de8eadaf
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Fix an overflow of the 0-lag time with long periods

This commit uses mul_u64_u64_div_u64() to compute the 0-lag time in
task_non_contending() so that runtime * dl_period does not overflow s64
with long periods, and bounds the positive-runtime division when the
parameters were shrunk.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d6d2657dcddd6..5e4aff28e9bcd 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -411,7 +411,7 @@ static void task_non_contending(struct sched_dl_entit=
y *dl_se, bool dl_task)
>  	struct hrtimer *timer =3D &dl_se->inactive_timer;
>  	struct rq *rq =3D rq_of_dl_se(dl_se);
>  	struct dl_rq *dl_rq =3D &rq->dl;
> -	s64 zerolag_time;
> +	s64 zerolag_time, left;
> =20
>  	/*
>  	 * If this is a non-deadline task that has been boosted,
> @@ -425,15 +425,40 @@ static void task_non_contending(struct sched_dl_ent=
ity *dl_se, bool dl_task)
> =20
>  	WARN_ON(dl_se->dl_non_contending);
> =20
> -	zerolag_time =3D dl_se->deadline -
> -		 div64_long((dl_se->runtime * dl_se->dl_period),
> -			dl_se->dl_runtime);
> -
>  	/*
> -	 * Using relative times instead of the absolute "0-lag time"
> -	 * allows to simplify the code
> +	 * The 0-lag time is the deadline minus the runtime left, scaled by
> +	 * dl_period / dl_runtime. The product of the runtime and dl_period
> +	 * can overflow s64 with periods of a few seconds, so multiply on 128
> +	 * bits. Compute the 0-lag time relative to now.
> +	 *
> +	 * After a change of parameters, the runtime and the deadline stay
> +	 * those of the old parameters until the next period. The 0-lag time
> +	 * uses the new dl_runtime and dl_period. The runtime left can then be
> +	 * far above dl_runtime, and the quotient too large for 64 bits. So
> +	 * first compare the runtime left with the runtime that the new
> +	 * parameters give until the deadline:
> +	 *
> +	 *   (deadline - now) * dl_runtime / dl_period
> +	 *
> +	 * If it is larger, the 0-lag time has passed, and the bandwidth is
> +	 * released now.
> +	 *
> +	 * The runtime is negative after an overrun. The next tick throttles
> +	 * the task, so the overrun is short and its quotient fits.
>  	 */
> -	zerolag_time -=3D rq_clock(rq);
> +	left =3D dl_se->deadline - rq_clock(rq);
> +	if (dl_se->runtime < 0)
> +		zerolag_time =3D left +
> +			mul_u64_u64_div_u64(-dl_se->runtime, dl_se->dl_period,
> +					    dl_se->dl_runtime);

[Severity: Medium]
Can mul_u64_u64_div_u64() in the dl_se->runtime < 0 branch still overflow
s64 or u64 when dl_runtime was shrunk or the overrun spans multiple
seconds?

An overrun is not guaranteed to be short: in a guest, a vCPU preemption
can produce a multi-second delta_exec in a single update_curr_dl_se()
call, and a task throttled while blocking on an rt_mutex that is then
PI-boosted before waking has dl_throttled cleared in enqueue_task_dl()
without replenishment (because dl_entity_overflow() returns false when
dl_se->runtime < 0).

If a task with a raised period limit (e.g. 300s or UINT_MAX us) shrinks
dl_runtime to 1024 ns via sched_setattr(), an overrun of a few seconds
makes (-dl_se->runtime * dl_se->dl_period) / dl_se->dl_runtime exceed
S64_MAX (wrapping zerolag_time negative and releasing bandwidth early) or
U64_MAX (trapping with #DE in divq on x86-64). Even with the default 4s
period limit, scaling a single-tick overrun of the old runtime by the new
dl_period / dl_runtime ratio can arm inactive_timer for hours, locking up
running_bw and total_bw.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795105408.gi=
t.mathieu.desnoyers@efficios.com?part=3D10
