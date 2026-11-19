Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121271;
	b=xMPwhDP052SrEsEcUWPfd7JNp8sM2eI6Qvu80N080UmWBaFqkhohgRKAGxVBA8KH6lZc
	 HWP0ihCjQT7Vx2hNKL9592Dw+AVFqtDldcfnQ/+XuV8jdQuCFI8e7VgHKJh590R/cR9S5
	 YFV/DF6hkixMbyI78eyP6ZPau7RMSxrg9uBEWUrX09xGuxUwa8RFwnitDyC/G0yUMiyYi
	 THZ95w+VX9mgnxgwZBX49kRntXYrfuBVxPfsnT7aMtATX2lnV4ryRznQT2o0K2I4FB48b
	 B+s5G3gXlzJ8xcIa4XiVU/sL2EHDOcr2YrXqVw6mfvFxu3Jjvar7GKAID8558bEoDWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121271;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7VGROY6qOIMN2R+Mawmbz74S23uVXZnVc+/ox9qRxm8=;
	b=teIJAAjBp1xPnNFw/LyPUKpydxuuXXF4SW1SjfzIDz1zKBEY/FLPCcbVWmaeY8XDaBQJ
	 pmeVLxFzGGch83qchtOeBa4WW9MHQxWuWq3LsKADwWMscwsvRUlnmqCSIZ4ygpdjhHaZB
	 jzmDC+gEj4Qt/YDuZ5sQwR8Xd6Bc9sNjglLg+0C5hXspNvl5bUQepUN7My3GtMY5vqK9f
	 o3RJVciY255aGhv2yka9eyFL4ajBNpInnvSIZLlp6yB/q5cAg5e4qdq/MyivDevXwvr6U
	 Vob7fMRtu/SjQesZN0AVibVGESPS2CJlUWzGJQlRHTfsq7tLxjYlGomTIUpRtxkVbTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=It8WcrGR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10153606CC5C;
	Thu, 19 Nov 2026 20:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=It8WcrGR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACA51F000C4;
	Thu, 19 Nov 2026 20:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121270;
	bh=7VGROY6qOIMN2R+Mawmbz74S23uVXZnVc+/ox9qRxm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=It8WcrGRK0JutZOkPHh4tH8PSorRPp6KtwyPjLk5jj2uGrSsGtgm8OZ9muuXtsFY+
	 rS24lU+fQmx2CsvSdDuGnRfkHyJvHMa90KUJPyTN/pLEWPVUlKVc7289ZV3bMNs77h
	 fUX5ytGo31+KDy4+Pc9g8oFuOcHb4ff3EvMf9ox/9qY1jRa/X5rJVEoHUNkMXyhepk
	 /VJLV3kMPZEpnTwfSWwMiTi0YeSDDGjB9tluMMd2iaaIKCePWMHoaSkp9MjrCxuQUW
	 PTMW9F1L6H598HM7pgJIkgsIPIHReyEoPCC4+9eimCbrBsJgNUr/n1ZH9ENMFU/BeY
	 fApzMd6+5nimg==
Message-ID: <sashiko-outbox-224049@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 27/33] sched/deadline: Start a period at a deboost
 out of the class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <9663a1e69055f16fb3e828fb0b47cb79dd020439.1795116791.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <9663a1e69055f16fb3e828fb0b47cb79dd020439.1795116791.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:47:50 +0000
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
- [Medium] sched/deadline: delayed bw release in switched_from_dl() at
  0-lag time 0
- [Medium] sched/deadline: uncanceled donor timer in switched_from_dl()
  when asleep
--

commit d30233a80ec3ae5aaad3cff8dd2909eea144f7c6
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Start a period at a deboost out of the class

This commit starts a new period using the task's own reservation parameters
in switched_from_dl() when a boosted task with dl_donor_refill set leaves
SCHED_DEADLINE, sharing the period reset logic with dl_deboost() via
dl_start_own_period().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 77a1d1f463f6d..d284036ecb8a9 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -83,6 +83,16 @@ static inline int on_dl_rq(struct sched_dl_entity *dl_=
se)
>  	return !RB_EMPTY_NODE(&dl_se->rb_node);
>  }
> =20
> +/*
> + * Start a period of the reservation of @dl_se now. The caller holds the=
 rq
> + * lock and has updated the rq clock.
> + */
> +static inline void dl_start_own_period(struct sched_dl_entity *dl_se)
> +{
> +	dl_se->deadline =3D rq_clock(rq_of_dl_se(dl_se)) + dl_se->dl_deadline;
> +	dl_se->runtime =3D dl_se->dl_runtime;
> +}

[ ... ]

> @@ -4504,6 +4510,17 @@ void dl_clear_root_domains(void)
> =20
>  static void switched_from_dl(struct rq *rq, struct task_struct *p)
>  {
> +	/*
> +	 * The boost of a task with parameters of its own ends, and the task
> +	 * leaves the class. If the boost refilled its runtime from the
> +	 * donor's parameters, its runtime and deadline are not those of its
> +	 * reservation. task_non_contending() would mix them with its own
> +	 * dl_runtime and dl_period. Start a period of its own instead, as
> +	 * dl_deboost() does. Its 0-lag time is then now, or has passed.
> +	 */
> +	if (p->dl.dl_runtime && p->dl.dl_donor_refill)
> +		dl_start_own_period(&p->dl);
> +
>  	/*
>  	 * task_non_contending() can start the "inactive timer" (if the 0-lag
>  	 * time is in the future). If the task switches back to dl before

[Severity: Medium]
Does task_non_contending() still arm a 0-ns inactive_timer instead of
releasing the bandwidth at once when dl_deadline =3D=3D dl_period?

After dl_start_own_period(&p->dl), left equals dl_deadline and runtime
equals dl_runtime.  For an implicit-deadline reservation (dl_deadline =3D=3D
dl_period), task_non_contending() computes zerolag_time =3D=3D 0, which does
not take the immediate release branch:

kernel/sched/deadline.c:task_non_contending() {
	...
	} else if (left < 0 ||
		 dl_se->runtime > mul_u64_u64_div_u64(left, dl_se->dl_runtime,
						      dl_se->dl_period))
		zerolag_time =3D -1;
	else
		zerolag_time =3D left -
			mul_u64_u64_div_u64(dl_se->runtime, dl_se->dl_period,
					    dl_se->dl_runtime);

	/*
	 * If the "0-lag time" already passed, decrease the active
	 * utilization now, instead of starting a timer
	 */
	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
	...
}

Because zerolag_time is 0 rather than negative, task_non_contending() arms
inactive_timer for 0 ns and switched_from_dl() puts p on dl_departed_list,
keeping p's bandwidth in total_bw and its parameters uncleared until the
timer interrupt fires and inactive_task_timer() acquires the rq lock.

[Severity: Medium]
What happens if p is asleep with p->dl.dl_non_contending already set when
it is deboosted out of SCHED_DEADLINE?

If a boosted task with its own parameters was refilled from its donor and
then blocked, dequeue_dl_entity() -> task_non_contending(&p->dl, true)
already armed inactive_timer from the mixed donor and owner parameters and
set p->dl.dl_non_contending =3D 1.  If the boost ends while p is still asle=
ep
(for instance, when the donor waiter times out or is interrupted),
switched_from_dl() calls dl_start_own_period(&p->dl) here, but then skips
task_non_contending(&p->dl, false) in the !task_on_rq_queued(p) block
because p->dl.dl_non_contending is already set:

kernel/sched/deadline.c:switched_from_dl() {
	...
	if (!task_on_rq_queued(p)) {
		if (p->dl.dl_non_contending)
			sub_running_bw(&p->dl, &rq->dl);
		sub_rq_bw(&p->dl, &rq->dl);
		if (!p->dl.dl_non_contending)
			task_non_contending(&p->dl, false);
	}

	if (p->dl.dl_non_contending) {
		p->dl.dl_non_contending =3D 0;
		dl_task_depart(p);
	}
	...
}

The old donor-mixed inactive_timer stays armed and p is placed on
dl_departed_list, keeping its bandwidth in total_bw until that timer fires.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795116790.gi=
t.mathieu.desnoyers@efficios.com?part=3D27
