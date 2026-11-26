Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657841;
	b=ug6peVOaTwKSwDSiT9VOwr4NaYEGYIaoSlkdZCwWsP5dQSyK8dVfo3tFwsO5BVNfWUgh
	 Ufn4+kgjs8sy+QyNAA6VfH25699xrt3s41IEaOK0hVbB+dmv5/QjuCwRZZamcH94EGn+j
	 U7bmJKtrfqgphigadlIhqTeC8QwnUAQ/EMJZD03pdH2xcf1I0cS/cAVHS0x+wmaR7LKh/
	 d6llZ7fub7dp4SL6DsSW2ieNtHuBM0mXWCOOPMBdzleRdiMa/7T8/7CjNy7cuP1HtVrdL
	 hFIDHsld+UvPElCLkqVkUR0K9ACYGjFGj7HEpVWlltwC1yw1J0+AtHEYdT7FZwwah6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657841;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OXdgxUflMp6zTYG2SsrUJzYi2m2tiXKTrQijZHJ3m9E=;
	b=b4OdWDx/745msOtNlzyrwzZjmagdYCjm/zDOxemfbFCiYjHWFFr0zyEfvnLbHhx6vUJK
	 PRpOQbqlsVN5DUxeEtjTZgfYH2/amKtycOEpj9MwQ6FlX9IRLA7n+CKdWWr7lrF74X/AU
	 pN/aJK/3FsgXUPqkD7NeDu3MOvptTwlRNLIGI31ezU0MM4sDtfFs6Abe2IA7+ckAM6kIP
	 0/nv5e7JJNGIqABZb6YUTnDegriIHS41P/OTovrjfjw1VRakG6tkS3ATqGRHBmMEaMgSZ
	 /gE1NkfFhyvT57vMngExEowSBml+Tz5I+ywOsr0qNRubQeHO/+HL+robgqIsPuJZILw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3xvA0SR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25AC606A31E;
	Thu, 26 Nov 2026 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N3xvA0SR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37B6A1F000C4;
	Thu, 26 Nov 2026 01:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795657840;
	bh=OXdgxUflMp6zTYG2SsrUJzYi2m2tiXKTrQijZHJ3m9E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3xvA0SRcnLA+EhKtB4y6NsLFc6zfupfP2QW0mn5fLCES+WmPmr2RdbDBMSVeuVd0
	 KHIhB/jYiAaM1bODycP0yiM5kIBht6TDjzo2NP2Hpww+TFe0igAnRjdpfhOJ/VkTyz
	 dzTMYtDCv+3J8uZ5XUKLbhAHP+Rp1AdQLdzXm9EZC86jaGxuLhmEvZ4XwvLBLVd3wx
	 EXEFgI8+shQzJE9REtVWUBWllEAdpuwjxD16C0Y8fYNSCthhdPeihdAHsdSDzd9abM
	 ZlhZlyXi/cx/4lnDAcgFR3p3jh95nU1eBV9Vo7T9L+HZZL6hY3ZQc5CwJHLhXads3V
	 ms0akFVdAylIg==
Message-ID: <sashiko-outbox-234588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 31/43] sched/deadline: Restore the owner's period at
 a deboost out of the class
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <c53e032decdc0ae447feecd391faa770e683dd89.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <c53e032decdc0ae447feecd391faa770e683dd89.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 01:50:39 +0000
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
- [Medium] sched/deadline: missing throttle after held boost ends in
  switched_from_dl()
--

commit 7695498ee5152a5e36e39a21aef4b92a39936d61
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Restore the owner's period at a deboost out of the class

This commit restores the lock owner's own deadline and runtime parameters
in switched_from_dl() when a priority-inheritance boost ends as the task
leaves SCHED_DEADLINE, and recalculates the 0-lag inactive timer from the
restored parameters.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 4d46d1c9c6981..5d1d4ea288788 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -4802,6 +4802,22 @@ void dl_clear_root_domains(void)
> =20
>  static void switched_from_dl(struct rq *rq, struct task_struct *p)
>  {
> +	bool held =3D dl_end_held_boost(&p->dl);
> +	bool own_period =3D held || (p->dl.dl_runtime && p->dl.dl_donor_refill);
> +
> +	/*
> +	 * After a refill from the donor, the runtime and deadline are the
> +	 * donor's. task_non_contending() would mix them with the task's own
> +	 * dl_runtime and dl_period. So give the task values of its own first,
> +	 * as dl_deboost() does. After a held boost, dl_end_held_boost() above
> +	 * has put back the saved ones. A task with nothing saved starts a
> +	 * period of its own. Its 0-lag time is then now. A constrained task
> +	 * still keeps its bandwidth until its next period: see
> +	 * task_non_contending().
> +	 */
> +	if (own_period && !held)
> +		dl_start_own_period(&p->dl);

[Severity: Medium]
Should switched_from_dl() also throttle p->dl and arm p->dl.dl_timer when
held is true and p->dl.runtime <=3D 0, the way dl_deboost() does?

When a task exhausts its own runtime while boosted, replenish_dl_entity()
clears dl_throttled and dl_hold_refilled_boost() saves own_runtime =3D 0.
If the task leaves SCHED_DEADLINE at the deboost before own_deadline,
dl_end_held_boost() restores p->dl.deadline =3D own_deadline and
p->dl.runtime =3D 0, leaving p->dl.dl_throttled =3D=3D 0.

If the task switches back to SCHED_DEADLINE before p->dl.deadline,
enqueue_dl_entity() sees dl_throttled =3D=3D 0 and a deadline still in the
future, so it enqueues the task onto dl_rq with runtime =3D=3D 0 and lets it
run past its reserved budget in the current period.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D31
