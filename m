Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928691;
	b=PaqRewU2yANiD00dZHNQwaYk48zvMdCsjC7ZBMGDl/Rj32F+ea14cqC+NyVaOed6NreT
	 w7SGtvlx+0ldMvJ6vCtOaB2hfItwE7boYjkz4niYh2PVg14VwfPe9TkYI1k7qhfNdRfWR
	 7n5A98CE927/FD7rxtXK/HkMfW4WhIOPRgMvFozHKa8eL+loew4a/CFv1XsAhAX3PdluF
	 N2UcU8j19QmOh4/gRJN8fA2mJqVaBRhUhAFAsYEouqH9rjDjOt8GjzFNQxFDT00AYk9zT
	 EqEd1syj8FCiVV+zu7lNkYku674AJcjUzG4GnV+EnQXEZNS54pz67ougPEvsU6GfEZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928691;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j9vCey1t+Q+IMeHeZ7shCm4L8ss6/YF1LVZj4OVh5hM=;
	b=4uDg2o7eOgPw9joPd1HbC6g06XfsL27m6MhDxeZd6XZiiikb131uehbVR5cNRw+NtuPu
	 UEn38m4tEzntCu6lCjhGExZr23RX+IZF8Yrn1U6lEtdxMavI8hhOLZG8QrDRJqjnsZbVm
	 /CxiZ5hddWd4YN32Y/yyhoNH0pLJV5Re2GkexJyIxeIfsdBsLmHHYWXE5mQgPSLrEvrDp
	 VJbhlHTgIDlnx7Biol3Lig1aqYT5FY84SlgwjCPI5bFmikaFp08EQp4F83m44gjgHxBgs
	 g24/vW3VUNywF/zcsoh8Tjtgewqd0Cd7oZ33f2W4gDU6Ek13TyvM8nq3vrGO8NCSW/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGaEYV9x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203C1606A32C;
	Tue, 17 Nov 2026 15:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGaEYV9x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3E171F000C4;
	Tue, 17 Nov 2026 15:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794928691;
	bh=j9vCey1t+Q+IMeHeZ7shCm4L8ss6/YF1LVZj4OVh5hM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KGaEYV9xrj4Wxdc8IlNAekXAlWD7lJGk5hFGQDvriEaKCB9F2oco39kUwe2vbbg1v
	 xfj8pUglRQ9CCzA8qoSEi1anKX1qfp7TZFJcEpwCDAC3RCgeMPzRyVLSlnew82f+yB
	 2bz6O0kILNTAcQiqayIspHxaufMIC8i3/QN7tyqFozuUaqx2QyzECVwaey4EYAgHvk
	 aWNbZjhb+3aiAdDAESvHvPWjrZEEtarmmT6NhJ8Xjfy70LDikPrUefpKQy6FzgZfIt
	 Fe66TBqfiK6s0fIJYr0dBPsdAPKtMDxWkiKPCQlxw/HjxgTHSz+0eDbL0bcI5J5N3P
	 gRe0sBAdu8iRg==
Message-ID: <sashiko-outbox-219044@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 23/40] sched: Make deadline policy and affinity
 changes wait for a cpuset attach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <7863f1eabf2d998cad9a6abde392e89adaa5fd7c.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <7863f1eabf2d998cad9a6abde392e89adaa5fd7c.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:18:10 +0000
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
- [Medium] sched: stale cpumask before cpuset_lock_no_attach() in
  __sched_setaffinity()
--

commit b29e127976b751a796fee47f2183b160f8e83a4d
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched: Make deadline policy and affinity changes wait for a cpuset attach

This commit introduces cpuset_lock_no_attach() and uses it in
__sched_setscheduler() and sched_setaffinity() so that deadline policy and
affinity changes wait until any in-progress cpuset task attach finishes.

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 4f47b17151ed9..4aa3ccbff320f 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c

[ ... ]

> @@ -1271,9 +1276,21 @@ int __sched_setaffinity(struct task_struct *p, str=
uct affinity_context *ctx)
>  		/*
>  		 * The cpuset mask must win here, as it does when
>  		 * cpuset_update_tasks_cpumask() sets it on a deadline task.
> +		 *
> +		 * A sched_setattr() may have made @p a deadline task since
> +		 * the first call. SCA_DL_NOWAIT would then skip this second
> +		 * call. Wait for a cpuset attach in progress instead, as
> +		 * sched_setaffinity() does for a deadline task.
>  		 */
>  		ctx->flags &=3D ~SCA_DL_CHECK;
> -		__set_cpus_allowed_ptr(p, ctx);
> +		if (ctx->flags & SCA_DL_NOWAIT) {
> +			ctx->flags &=3D ~SCA_DL_NOWAIT;
> +			cpuset_lock_no_attach();
> +			__set_cpus_allowed_ptr(p, ctx);
> +			cpuset_unlock();
> +		} else {
> +			__set_cpus_allowed_ptr(p, ctx);
> +		}
>  		retval =3D -EINVAL;
>  	}

[Severity: Medium]
Can this second __set_cpus_allowed_ptr() call apply a stale new_mask after
cpuset_lock_no_attach() sleeps?

In __sched_setaffinity(), when the concurrent cpuset update recovery path
(!cpumask_subset(new_mask, cpus_allowed)) is entered with SCA_DL_NOWAIT set,
cpuset_cpus_allowed(p, cpus_allowed) and new_mask are computed before
cpuset_lock_no_attach() is called:

kernel/sched/syscalls.c:__sched_setaffinity() {
    ...
	cpuset_cpus_allowed(p, cpus_allowed);
	if (!cpumask_subset(new_mask, cpus_allowed)) {
		cpumask_copy(new_mask, cpus_allowed);
		if (unlikely((ctx->flags & SCA_USER) && ctx->user_mask)) {
			bool empty =3D !cpumask_and(new_mask, new_mask,
						  ctx->user_mask);

			if (empty)
				cpumask_copy(new_mask, cpus_allowed);
		}
    ...
}

If p becomes a SCHED_DEADLINE task after the first __set_cpus_allowed_ptr()
call and a cpuset attach or update runs before cpuset_lock_no_attach()
acquires cpuset_mutex, new_mask is not recomputed under cpuset_mutex:

CPU0                              CPU1
sched_setaffinity(p)
  !task_has_dl_policy(p)
  __sched_setaffinity(p, &ac)
    __set_cpus_allowed_ptr()
    cpuset_cpus_allowed()
    cpumask_copy(new_mask, ...)
                                  sched_setattr(p, SCHED_DEADLINE)
                                  cgroup_procs_write() -> cpuset_attach()
                                    moves p and DL bw to new partition P
    cpuset_lock_no_attach()
    __set_cpus_allowed_ptr()
      sets p->cpus_mask to stale new_mask  <-- wrong CPUs for p's DL bw

Because SCA_DL_CHECK is cleared before the second __set_cpus_allowed_ptr()
call, p's affinity is overwritten with the pre-attach cpuset mask while its
deadline bandwidth remains accounted in P's root domain.

In addition, if css_set_move_task() moves p to the destination cpuset before
cpuset_cpus_allowed() is read while attach_ctx.in_progress is still set,
waiting in cpuset_lock_no_attach() delays restoring p->user_cpus_ptr from
ctx->user_mask until after cpuset_attach_task() has already run using the
un-restored p->user_cpus_ptr from the first __set_cpus_allowed_ptr() call,
and then applies new_mask intersected with the old ctx->user_mask without
SCA_DL_CHECK, narrowing the deadline task's affinity below its root domain
span.

Recomputing cpus_allowed and new_mask after acquiring cpuset_lock_no_attach=
()
(or holding cpuset_lock_no_attach() before reading cpus_allowed on the
recovery path) would ensure the mask matches the post-attach cpuset state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D23
