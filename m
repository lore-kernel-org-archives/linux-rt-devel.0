Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794166222;
	b=XrC9SFkECZp/BuiFmHqP94KhRuFFsGp4U76IyJgAojpYcqAYe5DY5+qe5W5XkEeBShNi
	 vhu/YfQ5L1zHTyviKWDDhnhKqmjDE3muShhOJh1L4zvNBCxF5tRxVyjTL1wNBM3+hobN5
	 X2xEau2wWwMAvQhNNBja/7XlqWzNtmLMqbEP8/qxZFRaX1h1MmrDOmSQ1BeSCtG3sFSh6
	 VahFcM39aus9vQSLEhk5w559uWIrYsRPpvzR7tB7xqtcemU1I+fwBeMetkZgKCdlV5/yh
	 x43sCjvULA+mgjlFNgCd6U+rPlwSuiaPgL2/ZfPZSdYyUv9MS82e4jqTWRtN1lHfcmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794166222;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BMIXgXkKw5+haq+cqmb8pTrJNJ/kBe5kcnJCgdUGsps=;
	b=eyGO30C9PWRspE1VwUFjYtBhN14kb8NBLCljUuLQhs5C0Tr9y0GjeC7HulDc2Rr0LePa
	 sHCbwJWck46kP66/GFOfaVdUj1IQtv97Oc0pUvm4o6UZN6Sxbx39l9wBRhHmdSX751GfL
	 YxbH4rHPBstIpQN5BafpzpJ/JBmpN1b6QizGGP+j02swJeKVtw/NTYhg3uCI3DyDCINC1
	 818xyvh2XZBBxsXKi8Xg5jpowdGyzObaAUyMomm36jFBXkJPrrA6DdirBoNz0rI36HOyd
	 UObOhQiYhGsyQqTVg3Qg1DlHVotuYc8zn/Lhtn6PDOkgAhbou8W45MMJOagQXSjZVmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATf084pv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C09606A31C;
	Sun,  8 Nov 2026 19:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ATf084pv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5A41F0089F;
	Sun,  8 Nov 2026 19:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794166221;
	bh=BMIXgXkKw5+haq+cqmb8pTrJNJ/kBe5kcnJCgdUGsps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ATf084pvtZIm7b3ljgl6rfZsQvidA4i9OuY5eeNTp06fZ/Yd/eJFQvjYoDj2Ptv32
	 ciHso4FIT7iljgBh8ElUP/lxL2nDWuOU914oPyIuffcfetCWv20IV628u9hJFzUEAl
	 sqhFDT9rtqrXwEGGfqovr6pvjL+h+R1RzGp779msJpg07FV5ki0B2ls1Vib1ODMV1y
	 lBDGHKtKPKiXcMDtjRcrgEkfoVGckqkVFFGGbueSxufsf/qRlqCyoToGjMIy677X1a
	 1chzaNAd+zQYQmHRB1OuD+LrfG3ZnHBP1PH9xiZjZJbcKLd0gT7/oG6lqe6Z64RTrx
	 dZ2kd+Cre1p+A==
Message-ID: <sashiko-outbox-203951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/29] sched/deadline: Move a task's bandwidth only
 where room was made
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261108185406.1549770-19-mathieu.desnoyers@efficios.com>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-19-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:30:20 +0000
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
- [Medium] sched/deadline: skipped bandwidth move in
  __set_cpus_allowed_ptr_locked()
--

commit e053f633c12ae5159a18a1d6a2e9e44a383c8ab0
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Move a task's bandwidth only where room was made

This commit adds the SCA_DL_BW_RESERVED flag and
set_cpus_allowed_bw_reserved() so that set_cpus_allowed_dl() only moves a
deadline task's bandwidth across root domains when the caller has reserved
space in the destination root domain.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bf722f5ff97e5..030106b3d97f4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3272,6 +3272,22 @@ int set_cpus_allowed_ptr(struct task_struct *p, co=
nst struct cpumask *new_mask)
>  }
>  EXPORT_SYMBOL_GPL(set_cpus_allowed_ptr);
> =20
> +/*
> + * Like set_cpus_allowed_ptr(), for a caller that has made room for the
> + * deadline bandwidth of @p in the root domain of @new_mask. Move that
> + * bandwidth there with @p. Return 0 on success, or a negative error
> + * code.
> + */
> +int set_cpus_allowed_bw_reserved(struct task_struct *p, const struct cpu=
mask *new_mask)
> +{
> +	struct affinity_context ac =3D {
> +		.new_mask  =3D new_mask,
> +		.flags     =3D SCA_DL_BW_RESERVED,
> +	};
> +
> +	return __set_cpus_allowed_ptr(p, &ac);
> +}

[Severity: Medium]
Can __set_cpus_allowed_ptr_locked() skip set_cpus_allowed_dl() when
SCA_DL_BW_RESERVED is set and p->cpus_mask already equals ctx->new_mask?

kernel/sched/core.c:__set_cpus_allowed_ptr_locked() {
	...
	if (!(ctx->flags & SCA_MIGRATE_ENABLE)) {
		if (cpumask_equal(&p->cpus_mask, ctx->new_mask)) {
			if (ctx->flags & SCA_USER)
				swap(p->user_cpus_ptr, ctx->user_mask);
			goto out;
		}
	...
}

With this patch, an affinity change without SCA_DL_BW_RESERVED (such as
sched_setaffinity() when sched_rt_runtime_us is -1 on a cpuset spanning
two root domains) updates p->cpus_mask to CPUs in root domain B while
leaving p->dl.dl_bw_cpu in root domain A.  If the task is then attached to
a cpuset in root domain B whose effective affinity mask matches
p->cpus_mask, cpuset_can_attach() reserves bandwidth in root domain B and
cpuset_attach_task() calls set_cpus_allowed_bw_reserved(), but
__set_cpus_allowed_ptr_locked() takes the cpumask_equal() early exit
without calling do_set_cpus_allowed() -> set_cpus_allowed_dl().

That leaves p->dl.dl_bw counted in source root domain A, keeps
p->dl.dl_bw_cpu pointing to root domain A, and leaks the destination
reservation in root domain B.  Later commits in this series ("cgroup/cpuset:
Give back the bandwidth an attach did not move" and "sched/deadline: Move
a task's bandwidth when it must leave its CPU") only partially mitigate
this: if the task was sleeping during the earlier unreserved affinity
change, p->dl.dl_bw_cpu stays in root domain A, the cpumask_equal() early
exit still skips set_cpus_allowed_dl() on attach, and cpuset_free_dl_bw()
refunds root domain B while the sleeping task's bandwidth remains counted
in root domain A.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108185406.1549=
770-1-mathieu.desnoyers@efficios.com?part=3D18
