Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033905;
	b=vIxCv2dpDqBXXZpPviSKEXC6z5Z3b//tzGsTJNtIJ5nii5/iXQBCCZ2IEk/xazpXZoHO
	 PgK741mSzMiqlSj+PmvrLqGTO/fL5QXvkutUQldKA268TiyDpEGsK7XcTYnW6rs5fBsge
	 Je0d2w4/IzdYabuvyzVBKVlv2xCQ+K/VCUv5swiC5YyOWViri4o7wqNqVbxy8UvugRdn0
	 mmdNhz3b4A502vT+nYQ8CNbxOjiuDfKnAxXDMjPX68pcogQpzqFS5Q2VIWQaU2VOeU9B/
	 7hmLCYS3mWdze7+n96fXye9XT3kVOyzcBN4fra9V36owUFo26VoOGt615e3I21tuDzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033905;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=H/aL6lukz4c67uN1ZyxEvz7Fvl4SSelgui/rUbM7Swk=;
	b=vnVskiC8EuaryGtAz4GdRmI8hYBGVS32bVP8/nM1Q1aGq4ObL8zfM473iOmHEdlsVZnI
	 rIwP6Dmjx031a+vUUoTGMcZvNpwf2l15rooVz3/mZ6E1sS1RG/M4RySR/wzmp7h+gknJv
	 b0SSPCT0zywZ2fMU22SUKFSzBJiAo9GONbzZx02DjVwZjkF+ADeaORi/QBQJm10bRJBw6
	 IiRCwDZPjVutc5ldQZrSG3H0pXIMM+4Y/Y1svvxVnEJwuhGFEFnOpDRw8fjQFXzFUd4jo
	 /2wgHgUIVvMPcMBk7vEQ1IaR+LUjcDN7W5xwlW/12XD7id7XXEKGsOvH3Yw+WRqugcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrTHte3v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C87606A32A;
	Wed, 18 Nov 2026 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrTHte3v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715BC1F000C5;
	Wed, 18 Nov 2026 20:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033904;
	bh=H/aL6lukz4c67uN1ZyxEvz7Fvl4SSelgui/rUbM7Swk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YrTHte3vPzuilbZ2aCH2/GVIJa1qEe76m36slFhbs8Wif+SlAX5SswmEZxPCMlyiU
	 ux2L2+EI4Xx1M/ffjRWEsnCNauB2jD9dMs/FtOVF4XgOnM39jYviYBr1qJ9NJeFYjc
	 xPCXXe8h7ZM0z9PeganqRURczvlzS6DzUXfFlOWCBW6ykRDiprbzI6tJFRQfS7yvBN
	 TE3bJR2M8NVwt+pelSSTKUW4Im/KCsbMLKsQY84vKyK3daXKZkKt3yBlapg6TWeMXB
	 yAyM5UCN82F1Y49EPcO6I4RgQBQwaHGojFLfa7EdTFqWQQALq3KYEEmNBQXILVgT8p
	 MfdwHm31MwrIg==
Message-ID: <sashiko-outbox-221937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 07/16] sched/deadline: Do not lose a throttled task
 switched out and back
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <e58738e763010632a024a6874a97f1d980b90ce3.1795031605.git.mathieu.desnoyers@efficios.com>
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <e58738e763010632a024a6874a97f1d980b90ce3.1795031605.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 20:31:43 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] sched/deadline: stale dl_timer and deadline after
  __dl_clear_params() [1]
--

commit e6978eb9fe65441d4ddb2d45bfc7400e644913a5
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not lose a throttled task switched out and back

This commit replenishes a throttled SCHED_DEADLINE task in dl_task_timer()
if the task has switched to another scheduling policy, so that it can be
enqueued if it switches back to SCHED_DEADLINE before its 0-lag time.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index b614d5fc1a1ac..e4d7cbf4861de 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1233,9 +1233,18 @@ static enum hrtimer_restart dl_task_timer(struct h=
rtimer *timer)
>  	/*
>  	 * The task might have changed its scheduling policy to something
>  	 * different than SCHED_DEADLINE (through switched_from_dl()).
> +	 * It keeps its parameters until its 0-lag time. If it comes back
> +	 * before then, nothing else would lift its throttle. So replenish
> +	 * it now, as the !queued case below does. Its return enqueues it.
>  	 */
> -	if (!dl_task(p))
> +	if (!dl_task(p)) {
> +		if (dl_se->dl_throttled && !is_dl_boosted(dl_se)) {
> +			sched_clock_tick();
> +			update_rq_clock(rq);
> +			replenish_dl_entity(dl_se);
> +		}
>  		goto unlock;
> +	}

[Severity: High]
This problem wasn't introduced by this patch, but in the opposite order
where the 0-lag time elapses before dl_se->dl_timer fires [1], does
__dl_clear_params() leave a stale dl_se->dl_timer armed along with stale
dl_se->deadline and dl_se->runtime values?

When a task calls sched_yield() with remaining runtime (or a
constrained-deadline task overruns slightly), its 0-lag time is earlier
than dl_next_period(dl_se).  If the task then switches out of
SCHED_DEADLINE, task_non_contending() or inactive_task_timer() calls
__dl_clear_params(), which clears dl_se->dl_throttled without cancelling
dl_se->dl_timer or resetting dl_se->deadline and dl_se->runtime:

kernel/sched/deadline.c:__dl_clear_params() {
	dl_se->dl_runtime		=3D 0;
	dl_se->dl_deadline		=3D 0;
	dl_se->dl_period		=3D 0;
	dl_se->flags			=3D 0;
	dl_se->dl_bw			=3D 0;
	dl_se->dl_density		=3D 0;

	dl_se->dl_throttled		=3D 0;
	dl_se->dl_yielded		=3D 0;
    ...
}

If the task switches back to SCHED_DEADLINE before the old period ends,
enqueue_dl_entity() with ENQUEUE_MOVE sees dl_se->deadline still in the
future and skips setup_new_dl_entity(), running the task with stale
runtime and deadline values.  If the task then throttles under its new
reservation while the old dl_se->dl_timer is still queued,
start_dl_timer() sees hrtimer_is_queued(&dl_se->dl_timer) and skips
reprogramming it, delaying replenishment until the old timer expires.

[1] https://sashiko.dev/#/bug/linux-5f16aeeb-544a-4da3-a8a9-3a7be85e8892

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795031605.gi=
t.mathieu.desnoyers@efficios.com?part=3D7
