Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802337;
	b=ptBlG4Jna6uKvLeleonQ/WXXE0VxDlDHdZTgdr2VdZBRF0t7mHR62VQmJtyDkH4P5F79
	 If9KLw/32Qr+Eo8KBCkaLHBDgUH7JAISYRP5Cq6uOU+mfKzBmxutRHXqiP/11d0FnSUdk
	 EOg3J49gqHC2dAkQqLgOln84ZEfTR+bWoL08A+a4AYNXeLA2ZGSf9XLAgjWCyJZXUjM8T
	 WMoNZ9FBwqzGkW0cpDu85bAliEidFg/HmXOnNybqWtNvC/V9f8gvENWbtQZyxGqmdes2U
	 9FchQrkmwPrnNBitXhNMz6EL6QQcsLqJ883U7R8bNPcmgLBjl7NZGWoZT2aNcb5os0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802337;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+EOxcwUH6JJK6t1c97ePvVNSvzaZ0oqDaKNs55ZOceg=;
	b=au+CqVr8zNFuQbNQ7mUeURBAt0X5GZ0/cGQG075NIWkDffcukLFYMTq/FPsUHKfxySaJ
	 OM2Wg/2MyzectuSNiYOa/0iw8hwjvH9tFouXWZ0dlGqmj3L15gz/qfp9sUOlCdFst3YKP
	 GzHzuSuISYHFh/6JubvAjgN76mfM/3l4EJMoih7hXQDQz8M+nu3pAw1HL6PJHw+XsgzvC
	 vXhwQb64lM19hFwm6eOz9kWMR54YABAzYLtNmOOemJpfbj4iXGcBzbPdEKM623oShkz61
	 FhIRmM8XFIRD4ReNrscC4X6iOmfNTmHQhkg0YQhwXeAV1OabDDJZU2Ukag9nZw3Hq1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ei3DjKaR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4183606A31C;
	Fri, 27 Nov 2026 17:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ei3DjKaR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3323A1F00893;
	Fri, 27 Nov 2026 17:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795802335;
	bh=+EOxcwUH6JJK6t1c97ePvVNSvzaZ0oqDaKNs55ZOceg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ei3DjKaRpt2WvLZE617weSRFUBAeE3T6Mky5slGAloXAiRUnZ7sKKM6o6M7GuHgFE
	 GnFZfg9jyqufkRqb57D78GYFcvkbMRtFRkJcGdHVT9PZ/xBR67COqlFADPszkFn6Rj
	 tD7EQRNI092VINdfiGgt4oFGecDMncMWLcHaSEvv13gtKhMQI78OT/9di6DjKLvtUt
	 nwo2rRyEB+oTRBNgoamSHWtOG5PfV2ivxbmRsByedy7BD5jviWVsQyGDBg0HUnxeAY
	 he3oT7qdscwTXbjN5DyZA7cl25G4oV3mmhhXRhdbpG9VlongwBkXTyztzILSz4C6NN
	 LzuQyd0Bt4oVw==
Message-ID: <sashiko-outbox-238021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 39/43] sched/deadline: Boost an owner throttled
 after its waiter blocked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <128cc48c0630c9f7197e29fab8cbc086ed34bd83.1795771148.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <128cc48c0630c9f7197e29fab8cbc086ed34bd83.1795771148.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 17:58:54 +0000
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
- [Medium] locking/rtmutex: stale pi_tree.prio in
  rt_mutex_ask_dl_boost() on handover
- [Medium] sched/deadline: dl_boost_start() ignores runtime <=3D 0 boost
  condition
--

commit eaf42f89f7029cb15ae44695c0cca1de7ab04a1a
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Boost an owner throttled after its waiter blocked

This commit queues a hard irq_work when a SCHED_DEADLINE rt_mutex owner
is throttled or finishes a blocked wait, so that rt_mutex_adjust_owner()
can boost the owner from its top waiter outside the rq lock.

> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 49caf38759f34..1deed8937e416 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1086,6 +1086,20 @@ static int __sched rt_mutex_adjust_prio_chain(stru=
ct task_struct *task,
>  	return ret;
>  }
> =20
> +/*
> + * Ask for a boost of @task, a deadline task with a deadline top waiter.
> + * @task can be throttled already. Its throttle is only read under the
> + * rq lock, so leave the check to the irq_work of
> + * dl_request_owner_boost(). The caller holds the pi_lock of @task.
> + */
> +static __always_inline void rt_mutex_ask_dl_boost(struct task_struct *ta=
sk)
> +{
> +	lockdep_assert_held(&task->pi_lock);
> +	if (dl_prio(task->normal_prio) && task_has_pi_waiters(task) &&
> +	    dl_prio(task_top_pi_waiter(task)->pi_tree.prio))
> +		dl_request_owner_boost(task);
> +}
> +
>  /*
>   * Try to take an rt-mutex
>   *
> @@ -1195,6 +1209,13 @@ try_to_take_rt_mutex(struct rt_mutex_base *lock, s=
truct task_struct *task,
>  	 */
>  	if (rt_mutex_has_waiters(lock))
>  		rt_mutex_enqueue_pi(task, rt_mutex_top_waiter(lock));
> +	/*
> +	 * @task took the lock ahead of the remaining waiters, so none of
> +	 * them has a higher priority. A deadline task can still need a
> +	 * boost: it can be throttled already. Its throttle found no waiter,
> +	 * or it waited on this lock then. Ask for the boost again.
> +	 */
> +	rt_mutex_ask_dl_boost(task);
>  	raw_spin_unlock(&task->pi_lock);
> =20
>  takeit:

[Severity: Medium]
Can rt_mutex_ask_dl_boost() observe a stale pi_tree.prio when a blocked
waiter was promoted to SCHED_DEADLINE before becoming the lock's top
waiter?

In rt_mutex_adjust_prio_chain(), waiter_update_prio() updates
waiter->tree.{prio,deadline}, whereas waiter_clone_prio() only copies
those keys to waiter->pi_tree.{prio,deadline} when the lock has an owner
and the waiter is the old or new top waiter.  If a second waiter becomes
a deadline task while behind another waiter (or while the lock has no
owner during wakeup handover), and the first waiter then takes the lock
in try_to_take_rt_mutex() or aborts in remove_waiter(),
rt_mutex_enqueue_pi() inserts the new top waiter into pi_waiters without
calling waiter_clone_prio().  rt_mutex_ask_dl_boost() then reads the
stale non-deadline pi_tree.prio and skips dl_request_owner_boost(),
leaving a throttled deadline owner unboosted until its next period.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 7f839185eb381..6bb92dfecbb89 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -544,6 +544,82 @@ void dl_boost_start(struct sched_dl_entity *dl_se)
>  	dl_se->dl_yielded =3D 0;
>  	dl_boost_donor_period(dl_se);
>  }
> +
[ ... ]
> +bool dl_owner_needs_boost(struct task_struct *p, struct task_struct *pi_=
task)
> +{
> +	struct rq_flags rf;
> +	struct rq *rq;
> +	bool ret =3D false;
> +
> +	if (!dl_prio(p->normal_prio) || !dl_prio(pi_task->prio))
> +		return false;
> +	rq =3D __task_rq_lock(p, &rf);
> +	if (!is_dl_boosted(&p->dl)) {
> +		update_rq_clock(rq);
> +		ret =3D dl_waiter_boosts(p, pi_task);
> +	}
> +	__task_rq_unlock(rq, p, &rf);
> +	return ret;
> +}
[ ... ]
> @@ -3611,6 +3700,8 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, in=
t flags)
>  		dl_se->dl_throttled =3D 1;
>  		if (task_current_donor(rq, dl_task_of(dl_se)))
>  			resched_curr(rq);
> +		/* A deadline waiter on an rt_mutex may boost it now. */
> +		dl_request_owner_boost(dl_task_of(dl_se));
>  	}

[Severity: Medium]
Should dl_boost_start() also hold the boost when dl_se->runtime <=3D 0?

dl_waiter_boosts() boosts an unboosted owner when (dl_se->dl_runtime &&
dl_se->runtime <=3D 0), even if !dl_se->dl_throttled and
!dl_in_constrained_gap(dl_se):

kernel/sched/deadline.c:dl_waiter_boosts() {
    ...
	if (!is_dl_boosted(dl_se)) {
		if (dl_se->dl_throttled || dl_in_constrained_gap(dl_se) ||
		    (dl_se->dl_runtime && dl_se->runtime <=3D 0))
			return true;
    ...
}

However, dl_boost_start() returns early without holding the boost or
switching to a donor period when !dl_se->dl_throttled &&
!dl_in_constrained_gap(dl_se):

kernel/sched/deadline.c:dl_boost_start() {
	if (!dl_se->dl_runtime ||
	    (!dl_se->dl_throttled && !dl_in_constrained_gap(dl_se)))
		return;
    ...
}

If an asleep owner has runtime =3D=3D 0 and dl_throttled =3D=3D 0 before its
deadline (for instance, after sched_setattr() leaves an asleep
constrained-deadline owner with runtime =3D=3D 0 in dl_setattr_place()),
rt_mutex_setprio() sets p->dl.pi_se to the donor while dl_boost_start()
does nothing.  When the owner later wakes up before its deadline,
update_dl_entity() does not replenish it (dl_entity_overflow() returns
false for runtime =3D=3D 0) and enqueue_dl_entity() skips the runtime <=3D 0
throttle check because is_dl_boosted(dl_se) is true, enqueuing the owner
with zero runtime and its own deadline instead of the donor's parameters.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D39
