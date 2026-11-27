Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787334;
	b=Eun08HcPYEI7mZyuWqyt/FjqTvBDFRIUYJNchSSInSKj1VYb/tiKbBihS8aJ0fGcq3xf
	 iALAqCPbJbVSF9pWFvNEOJp9kt6wfc2CbwM6FDQ/SUY0ay0+OgHkVoy2kKvm0IstAzWrO
	 hfszouvPMrrJmNahcS5aLq4htR/LSv4rgzMxB6j2VgNlUttd6LagZfG2G3pJP0diwEH8Z
	 YIlOjS5B85niw/DE9hIJedMG2IWQxrBxE5XXx+AUsH4fltzQnIjnwKUlbg2T8gcHYYamj
	 nJfOgR4IEe/PhPkq2mNr4j+5L26N3hskctg9EaJy7pI2AZB+ia4y6yDPLpdhdTZ5VNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787334;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PNRsNxkfWQW8x6oTCCzBASMqwEonHHyZcKGQQN4NB1c=;
	b=kFhPNWLmD0n6pZ3CNzLUkjQOq3GqF93VXtykRpbmI0XZUcuIM6/oBi8TWVbzRfrHDGoL
	 RwGNB93qZGtXXkcYqWSmPMUsXaNBzZhIGSZ6sVySO/LM6dlOMuUnGm2MKaiauNvtA/tNI
	 IpxNGUowRmN4nrM4Fh2sVn4HzFPA57y+yft9YMn3qOa44KRcjDkTYcF2ipko4IilzPsSw
	 y5cFwBwoAfOuJJYDb1OXtya0p0Isw1JHJGaa57FJyPJaOq63aXDJhCTj0B4ddZCTDrVEc
	 w7pKPSMhD7+tQN+4dMCotDKSebu4zMC1ggoLkaAt55BStXNek0ZZ3+q9OuXCViHaHkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=XHwTyjkL;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C87606A682;
	Fri, 27 Nov 2026 13:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37C87606A682
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=XHwTyjkL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787327;
	bh=PNRsNxkfWQW8x6oTCCzBASMqwEonHHyZcKGQQN4NB1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XHwTyjkL3vDrVZXmk2UeiMpl+UATeerSvpptknGyWuWLfUvdvUXqVXYHGlYRiGsID
	 I3Tkiny5f2eG3fr0mrQELsjRhKMUtaAepu3KMmqRwrencQiJqeZCJQmQj9aSs9PrGq
	 cn9kSnW75F2dqxCP5nkBFTXPh4dRAsSqA19ic+owhQpsfh6KMnTm0s9IMqAoV8sjgN
	 XNmeheKFB1hyazUmB//q6QK60TllD54apJFWWCPxp5DjGOjiFFYEWv4CscB69BfQ/n
	 YubQ/gx1jJlkhJFYIzZRjTGnT7Kk19PA5t3ba9GlX5TFb3VqEJIeLG0DMpsC0WuroY
	 aGOeXzNlO446w==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWg4tQgzXPD;
	Fri, 27 Nov 2026 08:48:47 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 38/43] sched/deadline: Boost an owner that cannot run on its own reservation
Date: Fri, 27 Nov 2026 08:48:41 -0500
Message-ID: <20261127134846.114774-13-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234634@kernel.org>
References: <29af731a1e529469abd92e902bcc8126f8cbe972.1795646914.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234634@kernel.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Does gating dl_boost_start(&p->dl) on dl_prio(p->normal_prio) skip holding
> the boost for a departed deadline task that still carries its own parameters
> until its 0-lag time?

Yes, for a task that is not queued. A queued task gets its boost held
at the first refill. An unqueued one behaves as on v7.4-rc2: its
waiter node keeps its deadline, as the cover states. Its wakeup while
boosted lifts its throttle. With runtime <= 0, it then runs at most
until the next tick, which refills it from the donor. Dropping the
check would also need dl_drop_boost_out() to end a held boost for a
task that leaves the class. v12 will leave it as it is.

> When p is already in a held boost (old_donor != &p->dl) and a new top waiter
> with an earlier deadline replaces old_donor, does skipping dl_boost_start()
> leave p running on the previous donor's later deadline?

Yes, as on v7.4-rc2. A new donor does not refill the task while it has
runtime left and its deadline has not passed. Starting a donor period
when the donor's deadline is earlier would fix it. That is for a
follow-up.

> When a deadline owner p (with p->dl.dl_deadline != 0) is blocked on another
> rt_mutex (!scope->queued), can the PI chain walk propagate a stale or
> expired p->dl.deadline to the next lock?

Yes, as on v7.4-rc2. The waiter node of a blocked owner holds the
owner's own deadline, also a passed one. The cover lists this with the
known limits: a waiter keeps the deadline it blocked with.

> If a constrained-deadline task goes to sleep holding a lock with remaining
> runtime > 0 and is boosted and deboosted while asleep during or after its
> constrained gap, does deboosting it waste its remaining runtime and start a
> new period while it is still asleep?

Yes. This is the third point on patch 28. In v12, a deboost of a task
asleep on anything but an rt_mutex will start no period. A task that
was throttled before the boost stays throttled. Any other task is left
to its wakeup.

> Can dl_se->dl_throttled and dl_se->dl_timer be left out of sync with the
> runtime restored by dl_end_held_boost()?

Yes, in both cases:
1. In v12, the enqueue will throttle a task that comes back with no
   runtime left before its deadline: see my reply on patch 31.
2. v12 will lift the throttle, and cancel the timer, when the runtime
   put back is positive.

> Does dl_waiter_boosts() keep a held boost when p has positive own_runtime
> and an own_deadline earlier than pi_task->dl.deadline?

Yes. In v12, dl_waiter_boosts() will compare with the owner's own
deadline while the owner has runtime of its own left.

> When dl_waiter_boosts() boosts an unqueued owner whose deadline is in the
> past (dl_time_before(dl_se->deadline, now)) and that is neither throttled
> nor in its constrained gap, what updates p->dl.deadline?

Nothing does. dl_boost_blocked() starts a period only for a task with
no parameters of its own. The waiter node keeps the passed deadline,
as on v7.4-rc2: see my reply on patch 30.

> Can dl_boost_donor_period() resume boost_deadline and boost_runtime from a
> different donor with incompatible parameters?

Yes. In v12, a resumed donor period will keep its start and its runtime
left, but take its deadline from the current donor. Its runtime will
also be capped at the donor's runtime.

> When dl_boost_start() saves a negative dl_se->runtime from a throttled task
> that overran its budget, does dl_end_held_boost() erase that overrun debt if
> the boost ends after own_deadline?

Yes. v12 will keep a negative runtime there.

> What happens if a SCHED_DEADLINE task p is the root donor in an rt_mutex
> lock cycle (so its top waiter pi_task has pi_task->dl.pi_se == &p->dl) and p
> changes its policy to a non-deadline policy?

Yes. This happens on v7.4-rc2 too. __setscheduler_dl_pi() and
rt_mutex_setprio() copy pi_task->dl.pi_se, which is &p->dl here. p then
stays in the class unboosted, and enqueue_task_dl() returns early. The
only change from this patch is that ENQUEUE_REPLENISH is no longer set.
So enqueue_task_dl() now also prints its "REPLENISH flag missing"
warning.

It needs no deadlock. A Spin model reaches it on v7.4-rc2 in 7 steps:
a failed ABBA lock attempt, then a sched_setscheduler() of p to
SCHED_OTHER. A stale donor in the waiter works too: see my reply on
patch 21. In v12, __rt_effective_prio() will not boost a task with no
deadline policy by a waiter whose donor is the task itself. One read
of that donor will choose both the class and the donor. With two
reads, the model still reaches the state, in 8 steps. With one read,
it finds none within its bounds.

Thanks,

Mathieu
