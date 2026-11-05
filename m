Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909428;
	b=BEcrP0iwlUkl4N37Ri3qyRP99k4DPvIhclqsIvqjpGYuojpvW9z/uXGQF0UqwV9Rn1ge
	 DgJkIytq9qZbMLbsJxW7wpd3xb0FlZdkUkAbg1Do05E2tDOUEGzwqvJo9+zE+6VuOriXy
	 yWyAvyITzft3GTcwAb4ddzQuhHNPw9shZMZD9VFrgoulWlGhUH/0lWHTkU4tus3GvFHHi
	 5KnouvHj2FaMg1lzEhAgw9G29T2+5EdQdVj8CVR+FmG7jV5MY1wO6rd2U0EvfcvkDFOG5
	 cWE4zTIBOCGRNK8MjOe1AyCBF4xEH+jpX+T14SpjrMKtdhxUkdn7OlS7+duYzOaHn+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909428;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wUViCC77mXYQ0JKmq5TEV5oH2rgM/Z1kN/WuET4hyj0=;
	b=Eg3VhENQ/V1cRGjrlwGV9jJAXPX2KgRt8iVQJGwhK+eAAWbOLG0dwoeaJj5aQ4JitgLI
	 82kGgn2S805Nyo2EsT6v869jcDejN9cPZCiAG1GBJ2uXq3dMft1/QNzrFpJXurOxCj5Ll
	 X15EroK2l6os3cIC7El95LY+07iMHQuT/VDNdA6NgSDILR5lDnJl0rXf+umZL//tP/cnE
	 /tiRQc9JYRe/HpQebvMfzr4V/UjCztynUpK+5yP5oS8fls36CgewCqdTbyxhMnb1xXRBr
	 tX9OSpdB8+amTnZ2yUEv4+1BD3U/+t50wR327AjbdXLOLzlgkpLBjgGFBEH4+Wj9cGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWvVgwMo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1514606A334;
	Thu,  5 Nov 2026 20:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWvVgwMo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2368C1F0089F;
	Thu,  5 Nov 2026 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793909427;
	bh=wUViCC77mXYQ0JKmq5TEV5oH2rgM/Z1kN/WuET4hyj0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NWvVgwMov4I4jUiZ47seWeSGhEo0jtG2KKgVJhP4845UdabjOPhFhIvUubG5/0o7T
	 HHOmJdTK1+LjFGRVMHArKukKDUaPmys5FUZGJLfLJpDeoJScU5epoLIv9/LD5gDyB9
	 t+cxzIUtwY9YJHkuIic8omIYrxHbvmUQxFNdN3j6rv1EbzweTnNQSmNmwK48IJNy15
	 3S8r78+w6FgWA9qryOyZ8hd9ux2yAtjv0KK4mykyNyZPOkp7104CF8Nyh8349KeqAg
	 WjzwfhmoukY4+A38r+9rTMacx2rr4BqM8IJZ6ib6DXKpwiYxN0vDvyKj+DJRlynE07
	 FKWr2cM+nUAQA==
Message-ID: <sashiko-outbox-200077@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/24] sched/deadline: Release the bandwidth of a
 task that leaves the class asleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261105193359.1450487-9-mathieu.desnoyers@efficios.com>
References: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
 <20261105193359.1450487-9-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 20:10:26 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] sched/deadline: __dl_clear_state() leaves dl_deadline set, breakin=
g PI boost
- [High] sched/deadline: __dl_clear_state() leaves dl_runtime set, breaking=
 PI deboost
--

commit 9c0c6a820e95bee2f513ebeba452d798eb3ec73c
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Release the bandwidth of a task that leaves the class asleep

This commit releases a task's bandwidth from the root domain's total_bw in
switched_from_dl() when the task leaves SCHED_DEADLINE while not queued and
without a pending inactive timer. It also introduces __dl_clear_state() to
clear the dynamic period state and dl_bw while keeping static parameters in
place in case the task is still a priority inheritance donor.

Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-2-dd761f=
e005b4@redhat.com/

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 088e84fb9b107..867111a0822e7 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -3550,15 +3551,62 @@ static void switched_from_dl(struct rq *rq, struc=
t task_struct *p)
>  	dec_dl_tasks_cs(p);
> =20
>  	if (!task_on_rq_queued(p)) {
> -		/*
> -		 * Inactive timer is armed. However, p is leaving DEADLINE and
> -		 * might migrate away from this rq while continuing to run on
> -		 * some other class. We need to remove its contribution from
> -		 * this rq running_bw now, or sub_rq_bw (below) will complain.
> -		 */
> -		if (p->dl.dl_non_contending)
> +		bool released =3D false;
> +
> +		if (p->dl.dl_non_contending) {
> +			/*
> +			 * Inactive timer is armed. However, p is leaving
> +			 * DEADLINE and might migrate away from this rq while
> +			 * continuing to run on some other class. We need to
> +			 * remove its contribution from this rq running_bw now,
> +			 * or sub_rq_bw (below) will complain.
> +			 *
> +			 * inactive_task_timer() will find !dl_task(p) and
> +			 * release total_bw via __dl_sub().
> +			 */
>  			sub_running_bw(&p->dl, &rq->dl);
> +		} else if (p->dl.dl_runtime && !dl_entity_is_special(&p->dl)) {
> +			/*
> +			 * No pending inactive timer: the task never ran as
> +			 * DEADLINE or the timer already fired while still
> +			 * DEADLINE (only dropping running_bw at that time).
> +			 * Nobody else will release total_bw, do it now.
> +			 *
> +			 * Not for a task without parameters of its own, one
> +			 * deboosted from priority inheritance, nor for a
> +			 * special one: neither has bandwidth in total_bw.
> +			 */
> +			struct dl_bw *dl_b =3D dl_bw_of(task_cpu(p));
> +
> +			raw_spin_lock(&dl_b->lock);
> +			__dl_sub(dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
> +			raw_spin_unlock(&dl_b->lock);
> +			released =3D true;
> +		}
>  		sub_rq_bw(&p->dl, &rq->dl);
> +		/*
> +		 * Released: its 0-lag time is past, and the state of the
> +		 * period it was in goes with the bandwidth, as where
> +		 * inactive_task_timer() resets it. Its bandwidth is no one's
> +		 * to release again, and a dl_bw of 0 is what every path that
> +		 * would takes. Kept, it would make the task one with
> +		 * bandwidth to task_contending() and task_non_contending()
> +		 * once priority inheritance boosts it, and a deboost while
> +		 * it sleeps would release it a second time. So would the
> +		 * inactive timer's handler when it runs late,
> +		 * dl_non_contending cleared under it by
> +		 * migrate_task_rq_dl(): it finds !dl_task(p).
> +		 *
> +		 * The parameters themselves stay, where
> +		 * inactive_task_timer() resets them with the bandwidth: the
> +		 * task may still be the donor of a priority inheritance
> +		 * boost until rt_mutex_adjust_pi() walks the chain, outside
> +		 * this runqueue lock, and replenish_dl_entity() of the
> +		 * boosted owner would never leave its loop over a dl_period
> +		 * and a dl_runtime of 0.
> +		 */
> +		if (released)
> +			__dl_clear_state(&p->dl);
>  	}

[Severity: High]
As reported by Sashiko on v2 [1], doesn't leaving p->dl.dl_runtime and
p->dl.dl_period non-zero in __dl_clear_state() cause task_non_contending()
to still run with stale parameters if this task is later boosted via
priority inheritance?

The comment above notes that clearing dl_bw prevents task_contending() and
task_non_contending() from treating the task as one with bandwidth once
priority inheritance boosts it. However, task_non_contending(),
task_contending(), and switched_from_dl() check dl_se->dl_runtime =3D=3D 0
rather than dl_se->dl_bw =3D=3D 0:

kernel/sched/deadline.c:task_non_contending() {
	if (dl_se->dl_runtime =3D=3D 0)
		return;
	...
	zerolag_time =3D dl_se->deadline -
		 div64_long((dl_se->runtime * dl_se->dl_period),
			dl_se->dl_runtime);
}

When a task p leaves SCHED_DEADLINE while asleep without a pending inactive
timer, switched_from_dl() calls __dl_clear_state(&p->dl), which zeroes
p->dl.dl_bw but keeps p->dl.dl_runtime, p->dl.dl_period, p->dl.dl_deadline,
and p->dl.dl_density at their old values.

If p (now running under e.g. SCHED_NORMAL) is later PI-boosted by a
SCHED_DEADLINE waiter W, p->dl.runtime and p->dl.deadline are taken from W,
while p->dl.dl_period and p->dl.dl_runtime remain p's old stale parameters
(and select_task_rq_dl() -> dl_task_fits_capacity() also checks p's stale
dl_density).

When p subsequently blocks while boosted (dequeue_dl_entity() ->
task_non_contending()) or is deboosted while queued (switched_from_dl() ->
task_non_contending()), task_non_contending() sees dl_se->dl_runtime !=3D 0
and computes zerolag_time by mixing donor W's runtime and deadline with p's
stale dl_period and dl_runtime:

1. If W's runtime and p's stale dl_period are both large (up to
   sysctl_sched_dl_period_max, ~4.19s), the signed s64 multiplication
   dl_se->runtime * dl_se->dl_period can overflow to a negative value;
   divided by a small stale dl_runtime, zerolag_time becomes positive by
   days, arming inactive_timer and pinning p via get_task_struct(p).

2. Even without overflow, whenever W's runtime/deadline ratio is smaller
   than p's stale dl_runtime/dl_period ratio, zerolag_time >=3D 0 and
   task_non_contending() arms p->dl.inactive_timer with
   p->dl.dl_non_contending =3D 1 instead of calling __dl_clear_params(). If=
 p
   blocked while boosted and is then deboosted while asleep,
   switched_from_dl() sees p->dl.dl_non_contending =3D=3D 1 and skips
   __dl_clear_state(), leaving W's future deadline and remaining runtime on
   p->dl after deboost. If p then re-enters SCHED_DEADLINE via
   sched_setattr() with a small runtime reservation before W's deadline
   passes, switched_to_dl() cancels inactive_timer and enqueue_dl_entity()
   sees !dl_time_before(dl_se->deadline, rq_clock(rq)), skipping
   setup_new_dl_entity() and allowing p to run unboosted with W's leftover
   runtime.

[ ... ]
> @@ -3960,22 +4008,34 @@ bool __checkparam_dl(const struct sched_attr *att=
r)
>  /*
>   * This function clears the sched_dl_entity static params.
>   */
> -static void __dl_clear_params(struct sched_dl_entity *dl_se)
> +/*
> + * The bandwidth of @dl_se and the state of the period it is in: what a
> + * task that left the class past its 0-lag time has no use for. The
> + * parameters stay, where a boosted owner may still read them.
> + */
> +static void __dl_clear_state(struct sched_dl_entity *dl_se)
>  {
> -	dl_se->dl_runtime		=3D 0;
> -	dl_se->dl_deadline		=3D 0;
> -	dl_se->dl_period		=3D 0;
>  	dl_se->flags			=3D 0;
>  	dl_se->dl_bw			=3D 0;
> -	dl_se->dl_density		=3D 0;
> =20
>  	dl_se->deadline			=3D 0;
>  	dl_se->runtime			=3D 0;
> =20
>  	dl_se->dl_throttled		=3D 0;
>  	dl_se->dl_yielded		=3D 0;
> -	dl_se->dl_non_contending	=3D 0;
>  	dl_se->dl_overrun		=3D 0;
> +}

[Severity: High]
As reported by Sashiko on v2 [1], what happens in replenish_dl_entity()
when a task that had __dl_clear_state() called on it is later boosted via
priority inheritance?

In __dl_clear_state(), dl_se->deadline and dl_se->runtime are cleared to 0,
while dl_se->dl_deadline is left non-zero. If the task is later running in
e.g. SCHED_NORMAL while holding a PTHREAD_PRIO_INHERIT rt_mutex and a
SCHED_DEADLINE waiter w1 blocks on it, rt_mutex_setprio() boosts the owner
into dl_sched_class with ENQUEUE_REPLENISH, calling:

  enqueue_task_dl()
    -> enqueue_dl_entity()
      -> replenish_dl_entity()

In kernel/sched/deadline.c:replenish_dl_entity():

	if (dl_se->dl_deadline =3D=3D 0 ||
	    (dl_se->dl_defer_armed && dl_entity_overflow(dl_se, rq_clock(rq)))) {
		dl_se->deadline =3D rq_clock(rq) + pi_of(dl_se)->dl_deadline;
		dl_se->runtime =3D pi_of(dl_se)->dl_runtime;
	}
	...
	while (dl_se->runtime <=3D 0) {
		dl_se->deadline +=3D pi_of(dl_se)->dl_period;
		dl_se->runtime +=3D pi_of(dl_se)->dl_runtime;
	}

	if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
		printk_deferred_once("sched: DL replenish lagged too much\n");
		replenish_dl_new_period(dl_se, rq);
	}

Because dl_se->dl_deadline is still non-zero, replenish_dl_entity() skips
the dl_se->dl_deadline =3D=3D 0 initialization branch:

1. On the first boost, the while (dl_se->runtime <=3D 0) loop starts from
   dl_se->deadline =3D=3D 0 and dl_se->runtime =3D=3D 0 and sets dl_se->dea=
dline to
   pi_of(dl_se)->dl_period. When rq_clock(rq) > pi_of(dl_se)->dl_period,
   dl_time_before() triggers a false "sched: DL replenish lagged too much"
   warning; when rq_clock(rq) <=3D pi_of(dl_se)->dl_period, dl_time_before()
   is false and the task is queued with the bogus absolute deadline
   pi_of(dl_se)->dl_period instead of rq_clock(rq) +
   pi_of(dl_se)->dl_deadline.

2. If the task is already boosted by deadline waiter w1 (so p->dl.runtime >=
 0
   and p->dl.deadline > rq_clock(rq)) and a second deadline waiter w2 with
   an earlier deadline blocks on the mutex, rt_mutex_setprio() calls
   replenish_dl_entity() with ENQUEUE_REPLENISH. Because
   p->dl.dl_deadline !=3D 0, p->dl.runtime > 0, and p->dl.deadline >
   rq_clock(rq), replenish_dl_entity() does nothing and leaves the owner
   scheduled with w1's later deadline instead of adopting w2's earlier
   deadline.

[1] https://lore.kernel.org/r/sashiko-outbox-198212@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105193359.1450=
487-1-mathieu.desnoyers@efficios.com?part=3D8
