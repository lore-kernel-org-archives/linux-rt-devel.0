Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927316;
	b=hGtCFvHBG7U5ptjimsXH+7vf3RlVFE/L7aNtA9ocaA6tKAamndDYFdQ9jTh1On6Re7Pg
	 rtUt4134dCORqOOWk6eheUL/3KVPi1IttTc0ALswymUGkHH5fc7sPV1jDX3GJ6XKyVMbs
	 vUenIo/HMRza2s+IKjt3td+7D0TkQmD0X0nJUxxJl4zZiz56rLZFHipqapplWnysLDFyj
	 17D0Izo5x8MVRoRO4dU5SB1/L0ntcObMIMiZCNLtbPTMHL764nPdVIB4/PlBR/woBDYWN
	 IrVKMMM+C0gKB+bwGsiQXlLGVj5Mc9QHi5JV/da5aRcF0dgRIRPI/ms20medzSkGd6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TD4unzIkvrOq6TRq1/+CgCb71DJUPC8dz67V6tVj8eI=;
	b=43BAHUB32vjqBuGfGLHxOu3LbohXEeevnzDpXbegjV0hz9zzUKCu3BHy6kqTEnPbhPSC
	 nIQH76QSIx1OFs7XN9whhVdYy4LAVnWRFFPBrdsb9sfsHclbvsStr9EkB7q5fD+KpayiW
	 NXDwCwc38KkxBLCVG27QRHixqgHVDDEg4hiz9cvbDpagrLtWyeZMDYh7atxz3O0db2dsN
	 AeVXd+nbuI1i5CG5dE5UFZgvi+sPilICU3Olcj7boxWWrTDBdiG1uU9CF8IZTCtxAnWdk
	 YbbbyoMki62iHNIksd4NkxU/rqlGMpubM44LAwacq7HubWpDF2Di17k4r11htsGYURw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RFBHk48C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B15606A31C;
	Tue, 17 Nov 2026 14:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RFBHk48C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1541F000C4;
	Tue, 17 Nov 2026 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927315;
	bh=TD4unzIkvrOq6TRq1/+CgCb71DJUPC8dz67V6tVj8eI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RFBHk48CpBjsJzzO3GSxKfCBercZdP248X51KLSsbkRNqEo1sygCqWh8sHfTACtiz
	 Eunu9JbkrOkbQEfJHH4wMxhIzhDZEI4cTf/MO2RsdAsbDd9j6UiVKtMFIpR6W5xAr/
	 8DAlqiywOoVc7A9/p+IVeTIfSergUTFj+/NgNe+1ZnMq4SFWj2IsMQBDCB++/1Szv7
	 awGi75rsYvsJIUBCH2YdfR5idaIVy8AEuIXVIvJXI7pnJgU8APm22seOWXza+QKtax
	 5dr4/wQ4rRXbv6ht+nYk2mjmssNMOhtTxGN+GB7J+9X2AwTIVHY2medbdmLwPa3Zoh
	 VySF3bUQZgryA==
Message-ID: <sashiko-outbox-218998@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 12/40] sched/deadline: Replenish a throttled task
 boosted while asleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <7bb821fa298ce41c9f6e49b5b6f5e462b41db8d5.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <7bb821fa298ce41c9f6e49b5b6f5e462b41db8d5.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:55:15 +0000
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
- [Medium] sched/deadline: dl_task_timer() refills sleeping boosted task
  from donor
--

commit 2a5083dbbf5a615c669ceffa5d4cba59162262f3
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Replenish a throttled task boosted while asleep

This commit changes dl_task_timer() to return early for a boosted task only
when it is queued on the runqueue, allowing a sleeping boosted task to fall
through and be replenished when its deadline timer fires.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 989e7e7d3f8f1..2b5a2a43addfd 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1319,10 +1319,13 @@ static enum hrtimer_restart dl_task_timer(struct =
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
> -	if (is_dl_boosted(dl_se))
> +	if (is_dl_boosted(dl_se) && task_on_rq_queued(p))
>  		goto unlock;
> =20
>  	/*

[Severity: Medium]
Does letting a sleeping boosted task fall through to replenish_dl_entity()
corrupt its CBS accounting by refilling its pre-boost deficit from the
donor's reservation parameters?

A task only sets dl_throttled and arms dl_timer while unboosted, so when
dl_task_timer() fires while p is still asleep, p has never executed under
the boost and dl_se->runtime and dl_se->deadline still reflect p's own
pre-sleep reservation.  However, replenish_dl_entity() reads runtime,
deadline, and period from pi_of(dl_se):

kernel/sched/deadline.c:replenish_dl_entity() {
	...
	if (dl_se->runtime <=3D 0)
		dl_note_donor_refill(dl_se);

	while (dl_se->runtime <=3D 0) {
		dl_se->deadline +=3D period;
		dl_se->runtime +=3D runtime;
	}
	...
}

Because dl_note_donor_refill() sets dl_se->dl_donor_refill, if the donor
times out and deboosts p before wakeup, dl_deboost() resets dl_se->deadline
and dl_se->runtime to a full new period, forgiving any runtime overrun p
owed before going to sleep.

If p instead wakes up while still boosted after overrunning its own budget,
the while loop above pays off p's overrun in multiples of the donor's
smaller runtime and period, which can push p's boosted deadline several
donor periods into the future.  For a constrained-deadline task whose
dl_timer fires at dl_next_period(dl_se), adding a donor's shorter dl_period
to p's earlier dl_se->deadline can leave dl_se->deadline behind rq_clock(rq)
and falsely trigger the "sched: DL replenish lagged too much" warning.  If
the donor left SCHED_DEADLINE and had its parameters cleared before
dl_task_timer() runs, the !runtime branch in replenish_dl_entity() skips
dl_note_donor_refill() and the deadline update because dl_se->dl_deadline is
non-zero, leaving p's expired deadline in the past after dl_deboost().
Finally, if p changed policy while sleeping and boosted, refilling from the
donor before 0-lag time leaves donor-derived runtime and deadline on p when
rt_mutex_setprio() drops the boost via dl_drop_boost().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D12
