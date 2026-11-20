Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185558;
	b=aJ6LemChEWWqX6zNoLc6WVHDBHCOouzRpKlJxCJ5Fof39li9+gv91uJ7DcB7vNsGpMXC
	 DhnKhF2pHH5VelKLD9DMoKmhnMm5Z6hUmEfyKV+/m3/gLJLHZ/uoZsMEJkfP8AAat6u+c
	 QF3FK2EWxAX0TJhP297AZDn+74TUxUVjHMx2RXBY5DZ8KAvgu0LRS20diw+sTSz/+L7WI
	 tLLS4aU4F9h1vzmwMuCkmJkMIFD4+LqE+QAwdoIszb3Fi/cNLqfHZzzGDFtriaYbBLlGv
	 5EX1IiTCVrlZ+iMww26g4CfPx02Bil53vEfzW0W4VaVICIgQ+qfOXt9qYTgpshFNisA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185558;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CcmbksXAMobKpgiwrMme6mUmZDWBBOFhSRsJdVvzVP4=;
	b=iK7rDOnDCOhnzbQTabfKXlm0yZfw6XsP3qHdWN9UE/EiJFbarD03AQ6Iw0Zx4BR5NLwr
	 rHifpuSYq+FuGDF1ddJeFDKM/EHWjIWvtnVuJ6DQGfort6VpPjje/UFGfDG8K8OGebL+d
	 rL+W9Rp88cOfzG3fYAMiKKfiloKtqIxxc7znoXy47MWT5Y5Uuen9xDaCpbLqq+OQHfGNz
	 bj1nfLLfsY0Pl+rRciOKBeqqhbhq4HFaXBMZ1H84kQPvwFNKVUldYoiHbKzj03MqVY+Sn
	 VY2E5NZPZ4l2gZgBo2iLOFERzKo//rxVbIqcGSiTCZ2LxPyWu8eDirB3CjlQHV1QSHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksJbEENw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F84B606A320;
	Fri, 20 Nov 2026 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksJbEENw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 969991F000C6;
	Fri, 20 Nov 2026 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795185558;
	bh=CcmbksXAMobKpgiwrMme6mUmZDWBBOFhSRsJdVvzVP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ksJbEENwBJ3YnCs82ghySk/6reVBP7NTFownNedCksFikhlhfvkzRCp/FnefUOdag
	 02QrisEvK+mp8xKs3WOjSLWQZaMTLEp+CLGZqh5+/jChY8FftkZFa/y9kmXSwGlMvK
	 SLNZKgjaIn7j04UVsTXDK/h/+uXyXJz25k7PyRQrNrWogAF21QGDrqLwXto8a5ypMX
	 prTS3+rprSLw8P7ryRSIq4fm4o0mZwCyWXixOYdmydz5APmMuU0UjQv04UwnHHKapH
	 Qe0ksNxDJUVz1ZiFidZT2K6XZaC9OjJjm5ViDEiJYHl3RS4hVNa337eMVGzobho3rq
	 pK4ECCkRLqZkg==
Message-ID: <sashiko-outbox-225397@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 26/33] sched/deadline: Start a period for a task that
 enters the class blocked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <8c4afb25de793f30e480c975d5c4f94d27e51c02.1795181240.git.mathieu.desnoyers@efficios.com>
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <8c4afb25de793f30e480c975d5c4f94d27e51c02.1795181240.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:39:17 +0000
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
- [Medium] sched/deadline: dl_task_pi_blocked() misses tasks sleeping
  off rt_mutex
- [Medium] sched/deadline: dl_boost_blocked() skips departed tasks with
  dl_deadline
--

commit 081950c6c411228f7405820577a9fbf92ec78a5f
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Start a period for a task that enters the class blocked

This commit starts a deadline period in switched_to_dl() and
dl_boost_blocked() when a task blocked on an rt_mutex enters the deadline
class or receives a new priority-inheritance donor.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 6511f1de0baaf..c57bbc7a9536a 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -125,6 +125,12 @@ void dl_deboost(struct sched_dl_entity *dl_se)
>  	}
>  	dl_drop_boost(dl_se);
>  }
> +
> +/* Return true if @p waits on an rt_mutex. The caller holds its pi_lock.=
 */
> +static inline bool dl_task_pi_blocked(struct task_struct *p)
> +{
> +	return p->pi_blocked_on;
> +}

[Severity: Medium]
Can gating the new period on dl_task_pi_blocked() in switched_to_dl() and
dl_boost_blocked() still leave a sleeping task with an uninitialized or
stale p->dl.deadline?

In futex_wait_requeue_pi(), a task sleeps on the non-PI source futex with
p->pi_blocked_on =3D=3D NULL.  If it enters the deadline class while sleepi=
ng
there (via sched_setattr() or a PI boost on another rt_mutex it owns),
dl_task_pi_blocked() is false and p->dl.deadline stays 0.  A later
FUTEX_CMP_REQUEUE_PI proxy-locks the sleeping task onto the contended PI
futex via rt_mutex_start_proxy_lock() -> task_blocks_on_rt_mutex(), which
copies p->dl.deadline =3D=3D 0 into waiter->tree.deadline before setting
p->pi_blocked_on, ordering the waiter ahead of all real deadline waiters.

Even without FUTEX_WAIT_REQUEUE_PI, if a task sleeping with
p->pi_blocked_on =3D=3D NULL holds an rt_mutex and is switched to
SCHED_DEADLINE via sched_setattr(), p->dl.deadline remains 0 while slept,
so a deadline task blocking on that rt_mutex fails
dl_entity_preempt(&pi_task->dl, &p->dl) and cannot boost it.  And if a
non-deadline task holding an rt_mutex already has a period from donor W1
and receives an earlier donor W2 while sleeping with p->pi_blocked_on =3D=3D
NULL, dl_boost_blocked() skips the refill and wakeup's update_dl_entity()
keeps W1's later deadline whenever W1's remaining runtime and deadline do
not overflow W2's density.

[ ... ]

> @@ -1162,6 +1173,30 @@ static inline void replenish_dl_new_period(struct =
sched_dl_entity *dl_se,
>  	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
>  }
> =20
> +#ifdef CONFIG_RT_MUTEXES
> +/*
> + * Start a period from the new donor of @p, if @p has no reservation of =
its
> + * own and waits on an rt_mutex. The enqueue does this for a queued task=
, in
> + * replenish_dl_entity(). A blocked task is not enqueued, but the chain =
walk
> + * copies its deadline into its waiter.
> + *
> + * The caller calls it only when the donor changes. A new period changes=
 the
> + * deadline, so the chain walk finds the waiter out of date and goes on.=
 In a
> + * ww_mutex cycle, a new period at each step would never let the walk st=
op.
> + *
> + * The caller holds the rq lock and the pi_lock of @p, and has updated t=
he
> + * rq clock.
> + */
> +void dl_boost_blocked(struct task_struct *p)
> +{
> +	struct sched_dl_entity *dl_se =3D &p->dl;
> +
> +	if (!dl_se->dl_deadline && !dl_se->dl_throttled &&
> +	    dl_task_pi_blocked(p))
> +		replenish_dl_new_period(dl_se, task_rq(p));
> +}
> +#endif

[Severity: Medium]
Does checking !dl_se->dl_deadline in dl_boost_blocked() miss a task that
left SCHED_DEADLINE before its 0-lag time?

When a deadline task switches to a non-deadline policy before its 0-lag
time, switched_from_dl() arms inactive_timer and leaves dl_se->dl_deadline
and dl_se->deadline non-zero until the timer fires.  If the task is
blocked on an rt_mutex and boosted back into the deadline class before
dl_se->deadline passes, switched_to_dl() cancels inactive_timer (so
__dl_clear_params() never runs) and skips replenish_dl_new_period()
because dl_se->deadline is still in the future.

Once that old deadline passes while the task remains blocked, a later
boost from a new deadline donor does not invoke switched_to_dl() and is
skipped by dl_boost_blocked() because dl_se->dl_deadline is still
non-zero.  rt_mutex_adjust_prio_chain() then requeues the waiter with the
new pi_se but the expired dl_se->deadline, ordering it ahead of waiters
with current deadlines.  Should this check !dl_prio(p->normal_prio) (or
also replenish when dl_time_before(dl_se->deadline, rq_clock(rq)))?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795181240.gi=
t.mathieu.desnoyers@efficios.com?part=3D26
