Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859731;
	b=dVZsJBvyURkXgv8oAtM/CJ2cAnwrhDJZPgT4K2LARI9UMi7YlbyTJQZ2itdta81cppKl
	 wqOka3ecRkKsI906Y8/YloYf+I2de22UQxggwl/IfIG0K6CcwV6olfMsLnAJAOVs8/VhR
	 X9x5UVgaPBCUUbbS/ZEx8W7uyhZTT7R+czBLCdijVIfYmRd7VCZt96015xtx6R/No1hVj
	 hQaM8ERqz1vj4cJ7sc9zxsjF5t2ZskODu2b+2OLFYmE6k0zxjUX/NhtClNfWmWgEYJgqZ
	 JQcG296cspswP79AD9axaKTiiY5GkG4zbo+0teBHiMLzzxcp/nbX6CuhN9bts1SVU1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859731;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8JuflPW44YRux+IBxd0uF+mKUDFKcO3peiQaN1S90XQ=;
	b=UA5Bafsz7YLLu7IFzWVAwWDnlYr7H1alVsCEIDkL296EIoVfq2dzLdPZnN4R92Wz7NVe
	 S+5jY7TsWNJT/QfW+BD4Sv4VQ32izCFtwAQLRFX0QHl3ALXHUYtu1P4/4JIwl3QM7cmJn
	 chGY5yTrHKQ+5htJ03Gk3Ivy2rYgTdOhwzAPDvXcqIXNnya5VFcK09oRrgvBfvaGI2ZcR
	 N6QPstL3kPFD4G20EJEJ2hGykcpPukXQvH7hABgrRSHS80St6wCIjo9KGrGHBAJq6U42J
	 6n8d/I+uidbdYL18AhCZmKIXTa18exrIV7UWJ46Jm1tjcThSKBUMG4lAbb864FKTPsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYBFFZRH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED052606A31C;
	Mon, 16 Nov 2026 20:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MYBFFZRH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353CF1F000C4;
	Mon, 16 Nov 2026 20:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859730;
	bh=8JuflPW44YRux+IBxd0uF+mKUDFKcO3peiQaN1S90XQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MYBFFZRH2N8sJX4t46JGns/9dl6eYiC7CbotgVEdzVh39zxRHrzV7EZLhM6tBxNek
	 naRToMtDol8Z2BuYled7vE74CDUlOVuFVuIzhDWmxicE+RlY7//iG2s0YhmCvRDsrc
	 ltgbzpm6mC0C9d/of6MaL8+rdo6Neq3vgR88fo2OaHqnDZ3YUXcUic9Quw66kBx1jY
	 b5nJls7B60MuU1UXpMrFkrngpvMNR9d5rwxNquJ3aLSeQChUefnQNthWd/CrFbO/w6
	 FV+exhRcaT+gmnixbr7ArLQguldlXXxaUvw8pAl7TrRJUAM0pYjkcS2XJfiQWh2CQG
	 GaIZeOLV+VAFQ==
Message-ID: <sashiko-outbox-217635@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 32/37] sched/deadline: Check the runtime of a task
 that comes back runnable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-33-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-33-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 20:08:49 +0000
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
- [Medium] sched/deadline: missed update_dl_entity() when setattr runs
  while PI-boosted
--

commit d9e5d198497bbfbacaaacba33587790f1f7b2f0f
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Check the runtime of a task that comes back runnable

This commit calls update_dl_entity() when a runnable unboosted task enters
SCHED_DEADLINE so its remaining runtime is checked against its new
scheduling parameters.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index ffa8b946e8047..b47c13c8714d9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2723,6 +2723,14 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, i=
nt flags)
>  		update_dl_entity(dl_se);
>  	} else if (flags & ENQUEUE_REPLENISH) {
>  		replenish_dl_entity(dl_se);
> +	} else if ((flags & ENQUEUE_CLASS) && !is_dl_boosted(dl_se)) {
> +		/*
> +		 * The task enters the class runnable. It may come back before
> +		 * its deadline, with the runtime left from older parameters.
> +		 * Check that runtime against the new parameters, as a wakeup
> +		 * does.
> +		 */
> +		update_dl_entity(dl_se);
>  	} else if ((flags & ENQUEUE_MOVE) &&
>  		   !is_dl_boosted(dl_se) &&
>  		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {

[Severity: Medium]
Can a runnable task bypass update_dl_entity() when returning to
SCHED_DEADLINE with smaller runtime if it is PI-boosted at the time of
sched_setattr()?

If a SCHED_DEADLINE task switches to SCHED_OTHER before its 0-lag time and
is then PI-boosted back into dl_sched_class by an rt_mutex waiter,
replenish_dl_entity() sees non-zero dl_se->dl_deadline and positive
dl_se->runtime, so dl_se->dl_donor_refill stays 0.

When sched_setattr() then returns the task to SCHED_DEADLINE with a
smaller runtime while still boosted, __sched_setscheduler() sees
prev_class =3D=3D next_class =3D=3D &dl_sched_class (so ENQUEUE_CLASS is no=
t set)
and is_dl_boosted(dl_se) is true, skipping update_dl_entity().  Even with
commit "sched/deadline: Check the runtime of a task whose parameters
change", enqueue_dl_entity() clears dl_se->dl_new_params unconditionally
at the top while skipping the check because is_dl_boosted(dl_se) is true.

When the task later unlocks the rt_mutex, dl_deboost() sees
dl_donor_refill =3D=3D 0 and leaves the old larger dl_se->runtime intact:

kernel/sched/deadline.c:dl_deboost() {
	if (dl_se->dl_donor_refill) {
		dl_se->deadline =3D rq_clock(rq) + dl_se->dl_deadline;
		dl_se->runtime =3D dl_se->dl_runtime;
	}
	dl_drop_boost(dl_se);
}

Because the subsequent enqueue only passes ENQUEUE_MOVE with a future
deadline, update_dl_entity() is never called, and the task runs on its old
larger runtime while admission control only accounts for the new smaller
bandwidth.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D32
