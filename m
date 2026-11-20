Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209748;
	b=0oJNL6GeqiMKVnFw2kg+3yOztRA+uMUHufDethWvKheaDEyuQjfDeytBPszIV4bk2VOc
	 vlKeNskXMiWuGtnzghTMLfxU5gpK4P0EbKeq5gO6HKa/EXxyizfvDGMfPRNLBqA1hlwZG
	 Hz++M6RWGcUhBBhX35X1EjYjlJmayZA31E35qQLN7wxUwp1tyzYCLu3RzKNO1LK+8+CSe
	 yd0UTn+/ZYipyhtHsyNZBWGgvBjzLaNDezTKT9XwF3oeHxNlw48gLmUCCw2kpE5ZhoP2A
	 1adtyQwhQevsixmnFhowipyKZ9d96nsrxUTkZQPXeMbM/1+HgXdBao4ZhptEio1IAUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209748;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6xcTzZ7SpbVsHTNrKbqQtXbY3eSGT6VEh2OiWB6MSV0=;
	b=tM4ixlc0b/nf1Vl/po6+ELc06QfDk0bKYzNg9sZowKbE4dbQqE7zPRJCqF6pitpT6IDf
	 hRby98QjXEcagR5CUI3UKjDeQSsN5VO80t34bjBZHfGFkza/OboZmSZV0ofPGXGJYoicQ
	 17KbO5bTdw0u4zgD0QneOd8PbZ3dN6gOXpK2KXUTourryq9VW3UMCbJ7DUOON8KtZ83nI
	 TElMADF6USC5HZv8hi+EnDvu8KhA30Hm8TQUkuLELBq/K8+mdH0uGH8KYbNAI2/obr1xF
	 sAhndLr+Tnmyhh5lYPTH8lxER9P+xYi7TmvKxSEtCrWcesxMSL0nXMXEUEUpnse9H6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wiwfgui6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115FA606A33F;
	Fri, 20 Nov 2026 21:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wiwfgui6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816961F000C0;
	Fri, 20 Nov 2026 21:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209747;
	bh=6xcTzZ7SpbVsHTNrKbqQtXbY3eSGT6VEh2OiWB6MSV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wiwfgui6Qkbi0iKI1jccS35+mdwa47Iv6C5V2AolvhsF4X37UPMMpD2Yiw+V5O4ld
	 Up5rtpO1ja0ad1KJAIMTgDbKhBj/WwlXHE2oX2+6B5oTiGgRiFYWkS7ULZhkqIwsQF
	 cryrRAfI/l2FhUO/PsnmydORHb/9MdJmB0PoUpBr9Zfai7MCo8+a26QLRzE8+MSyDb
	 uR1To9+pSrmt1hlTmwGI+bdP3w1IHyEudVlhg509HMcB+FbSZl8E8ob71G/5MlxRIB
	 LthH4MYPqrgp5BbvK9BxLUJs3ObaYhalukoIdi1zlAq2pe7/OH77EAHiXJCBSyU325
	 JMkD6tjogHRbg==
Message-ID: <sashiko-outbox-226168@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 26/40] sched/deadline: Replenish a throttled task
 boosted while asleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <9c0cc7d7c43e0562a9fc9f363898178b36c6e9c2.1795207232.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <9c0cc7d7c43e0562a9fc9f363898178b36c6e9c2.1795207232.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:22:27 +0000
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
- [Medium] sched/deadline: missing dl_note_donor_refill() in
  replenish_dl_entity()
- [Medium] sched/deadline: dl_task_timer() refills sleeping task from
  donor parameters
--

commit c9c72591d4a367d03f9bada51027022e7fbe7e42
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Replenish a throttled task boosted while asleep

This commit lets dl_task_timer() replenish a throttled task that was PI
boosted while sleeping instead of returning early before clearing
dl_throttled.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 2912d13b60d60..9a4639ae676a4 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1705,10 +1705,13 @@ static enum hrtimer_restart dl_task_timer(struct =
hrtimer *timer)
>  	}
> =20
>  	/*
> -	 * The task might have been boosted by someone else and might be in the
> -	 * boosting/deboosting path, its not throttled.
> +	 * A boost overrides the throttle. enqueue_task_dl() lifts it when the
> +	 * boost enqueues the task, or when the task wakes up boosted. So a
> +	 * queued task needs nothing here. A boost of a sleeping task does not
> +	 * enqueue it, and it can end before the wakeup. Nothing would lift the
> +	 * throttle then. So let a sleeping task reach the !queued case below.
>  	 */
> -	if (is_dl_boosted(dl_se) && task_on_rq_queued(p))
> +	if (is_dl_boosted(dl_se) && task_on_rq_queued(p))
>  		goto unlock;

[Severity: Medium]
Can replenish_dl_entity() leave dl_se->dl_donor_refill unset when a
sleeping SCHED_DEADLINE task's donor has its parameters cleared before
dl_task_timer() fires?

If the donor leaves SCHED_DEADLINE and reaches its 0-lag time before the
rt_mutex chain walk finishes deboosting the sleeping owner,
replenish_dl_entity() takes the cleared-parameter branch:

kernel/sched/deadline.c:replenish_dl_entity() {
	if (unlikely(!runtime || !deadline || !period)) {
		WARN_ON_ONCE(!is_dl_boosted(dl_se));
		if (!dl_se->dl_deadline) {
			dl_se->deadline =3D rq_clock(rq);
			dl_se->runtime =3D 0;
			dl_note_donor_refill(dl_se);
		}
		if (dl_se->runtime < 0 || dl_se->dl_yielded)
			dl_se->runtime =3D 0;
		dl_se->dl_yielded =3D 0;
		dl_se->dl_throttled =3D 0;
		return;
	}

Because a SCHED_DEADLINE owner has dl_se->dl_deadline !=3D 0, it skips
dl_note_donor_refill(dl_se) while zeroing runtime and clearing
dl_throttled.  When dl_deboost() then runs, dl_se->dl_donor_refill is 0, so
it does not start a new period of the task's own reservation, leaving the
owner with runtime =3D=3D 0 and a stale past deadline that prevents remaini=
ng
deadline waiters from re-boosting it.  Calling dl_note_donor_refill(dl_se)
and updating dl_se->deadline unconditionally in the cleared-parameter branch
would ensure dl_deboost() resets the owner's reservation.

[Severity: Medium]
Does calling replenish_dl_entity() from dl_task_timer() refill a sleeping
task's pre-boost runtime debt using the donor's parameters?

A boosted task is never throttled with dl_timer armed while boosted, so a
task reaching dl_task_timer() with is_dl_boosted(dl_se) &&
!task_on_rq_queued(p) was throttled on its own reservation as it went to
sleep and has consumed no runtime while boosted.  However,
replenish_dl_entity() reads runtime and period from pi_of(dl_se) and calls
dl_note_donor_refill(dl_se):

kernel/sched/deadline.c:replenish_dl_entity() {
	if (dl_se->runtime <=3D 0)
		dl_note_donor_refill(dl_se);

	while (dl_se->runtime <=3D 0) {
		dl_se->deadline +=3D period;
		dl_se->runtime +=3D runtime;
	}

If the sleeping owner overran its own large runtime and is boosted by a
waiter with a small dl_runtime, the loop pays back the owner's pre-boost
overrun in increments of the donor's runtime and period, pushing
dl_se->deadline multiple donor periods into the future so the owner runs
with a far-future deadline upon wakeup instead of the donor's urgent
deadline.  Conversely, if the waiter times out before the owner wakes up,
dl_deboost() sees dl_se->dl_donor_refill set, grants a fresh full period
that erases the owner's pre-boost overrun, and cancels inactive_timer early
to drop running_bw before the true 0-lag time.  In addition, with later
commit "sched/deadline: Boost an owner that cannot run on its own
reservation", dl_boost_start() saves the throttled sleeping task's
negative own_runtime and expired own_deadline with dl_boost_held =3D 1, and
dl_deboost() restores those unreplenished values after dl_task_timer() has
already cleared dl_throttled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D26
