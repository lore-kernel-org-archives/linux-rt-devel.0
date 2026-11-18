Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038720;
	b=JYYmobnv69mby4dW1s8j/IAYLf2n546PYTi2NYRRV5+n+oNQoTwduJEGtyev/ptU9t51
	 YROjkxs6GR06+8Jrg2fYa6DnSWjM6rG2PJKG2PmPTo2TgZ7o6mOLoT6Q7JHiWPDyyGvUX
	 AQh3Io/EC0pu5CnlDHtIIt0o8aOsQaZeBtaDFb+yVS5/YY0jAXWw5Ppw8puVfHimCmAQp
	 Hby3+63Wl1XpUVuuPfC9nxF8wGZDGConk95LiMu/pdWS8aiMlnq8RkvXAZKiIktAKHIyU
	 vkz0o71wq5VIUHMrMgHDmSK6YbIkpchdrn1jTswiYf5vcYINmzTyutTfhgLDWdR8lrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038720;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mLjrk+BoaZmQWd0Xv2ZVPoiHdbshU6XLBO6Ygb8cIfE=;
	b=SE4JESrxSsE0rUA+EjDCJyfWvh2VBCBrNbmbbK19tnIW4jQPznYlg7zRDS2DGs16i5bn
	 8kdersQxA3M11hxHt2WvwVCnk+nZTUDytQriJhuIbmlKfRFOGZN5t9EoU0EUjzsd8UzG1
	 r61oQXnbuKyYO1FPT8WU1mBYIaKxdCfa5dL7s7JdOD7YdQBVzC0uqegx17eD39rdn82Qg
	 RDMX1ppTFzKeGld2Knu41TG9EPvfpXRfaD2CcYGvdWyiDlBnA6Tt4sY3EEDpzH9CHS1tc
	 0MlJFR/mswCKRBHl4wrk2RTqHmklIVAaUShEB3PvLtu2/6ZHgUtds6u9ZL6OS3dw7Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RniTuwl/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7C2606A334;
	Wed, 18 Nov 2026 21:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RniTuwl/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EF8D1F000D0;
	Wed, 18 Nov 2026 21:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795038720;
	bh=mLjrk+BoaZmQWd0Xv2ZVPoiHdbshU6XLBO6Ygb8cIfE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RniTuwl/krPYIUoWRUhLWJT6LR1qKWVyWij8arR0R/wXL94gFMXrGzluSZzgCC0ry
	 WT1r7sfFAbxewj8oDO042ozNBuPYo2YWWwbQ8BPHqEfqfYlTn6Vc6jaEjA7ttedQeb
	 8KVPsgNsmAkpyxHrHTMIaHunQ5rqoR/vT5P2jfwMFOwI5Jn3qzVoBtiRiUgm3NN8c4
	 hNUcvzqCiV59wuXy25TcWM8j0n0Sc69cbfLuXkEnqaxM/TbVCU47V9uJvQL6cbrnoY
	 VqgxySQ7E/uXp1g9oCkXxu/pB2ycmZCrzixNDfBx7+YtrsP8KNAz0lV+zjI5TpQHXa
	 EUnYlukY0Tegg==
Message-ID: <sashiko-outbox-222041@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/16] sched/deadline: Release the bandwidth of a
 task that leaves the class asleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <413baa5f50669ae464f504dbafeb504dd9b6ef6c.1795037078.git.mathieu.desnoyers@efficios.com>
References: <cover.1795037078.git.mathieu.desnoyers@efficios.com>
 <413baa5f50669ae464f504dbafeb504dd9b6ef6c.1795037078.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:51:59 +0000
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
- [Medium] sched/deadline: stale params and s64 overflow in
  task_non_contending()
--

commit f6b619684c21aa7de4c182929a5157b957fed874
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Release the bandwidth of a task that leaves the class asleep

This commit calls task_non_contending() in switched_from_dl() when an
unqueued task leaves SCHED_DEADLINE without an armed inactive timer, so
that its total_bw contribution is released immediately or at the 0-lag
time.

Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-2-dd761f=
e005b4@redhat.com/

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d6d2657dcddd6..f0e03f97fd82f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -3595,6 +3595,14 @@ static void switched_from_dl(struct rq *rq, struct=
 task_struct *p)
>  		if (p->dl.dl_non_contending)
>  			sub_running_bw(&p->dl, &rq->dl);
>  		sub_rq_bw(&p->dl, &rq->dl);
> +		/*
> +		 * Without an armed timer, nothing releases total_bw. Do as for
> +		 * a queued task: arm the timer if the 0-lag time is ahead, or
> +		 * release the bandwidth and clear the parameters now. Call
> +		 * task_non_contending() after sub_rq_bw(), which needs dl_bw.
> +		 */
> +		if (!p->dl.dl_non_contending)
> +			task_non_contending(&p->dl, false);

[Severity: Medium]
Can task_non_contending() compute a bogus zerolag_time here when a
sleeping task had its deadline parameters updated before leaving the
class?

When a sleeping task re-enters SCHED_DEADLINE before its 0-lag time (or
updates its SCHED_DEADLINE parameters in place while asleep),
switched_to_dl() or dl_rq_change_utilization() cancels inactive_timer and
__setparam_dl() overwrites dl_runtime, dl_deadline and dl_period while
leaving the dynamic runtime and deadline from the previous reservation to
be updated at the next wakeup.  If the task then leaves SCHED_DEADLINE
while still asleep, task_non_contending() mixes the old runtime and
deadline with the new dl_period and dl_runtime:

kernel/sched/deadline.c:task_non_contending() {
	...
	zerolag_time =3D dl_se->deadline -
		 div64_long((dl_se->runtime * dl_se->dl_period),
			dl_se->dl_runtime);
	...
}

If the task had negative runtime under the old reservation and was given
a smaller dl_runtime / dl_period ratio, (-runtime * dl_period) /
dl_runtime is scaled up by the new ratio and can arm inactive_timer days
in the future, pinning total_bw and the task_struct reference; if runtime
was positive and dl_runtime was lowered below runtime, zerolag_time
becomes negative before the true 0-lag time and releases total_bw early.

Also, in the same calculation, dl_se->runtime * dl_se->dl_period is
evaluated in unscaled 64-bit arithmetic (unlike dl_entity_overflow(),
which shifts by DL_SCALE), so valid parameters within the default
sysctl_sched_dl_period_max (~4.19s, e.g. dl_period =3D 4s and remaining
runtime =3D 2.4s) overflow S64_MAX and wrap the dividend negative, pushing
zerolag_time past the deadline.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795037078.gi=
t.mathieu.desnoyers@efficios.com?part=3D10
