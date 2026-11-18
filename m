Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795033383;
	b=1Yu7mIIZkVpVlecgrQzwwR+YQW0OLYjNh6UJ/x10+F2X2esvV149KkO0L+rH9F32kjHE
	 5wEmem9nNG7TKwTuWLOJmkfyfkbFrIL1EGQPewfFKXFHQzg8TVFIGzxr46vB2/fp4+s9E
	 rp6Vd70/g1MurQXwH7dyWJdT+0wE/lSYGZVlk4Vvih9C/yIORlJbLJmzUCyAfv0lQUaxr
	 k0i9IiMIBGtpAbX11cQek2m63bkgQFazmnGuRmmVQJWTsbslKuuanIpxtHL18aTZrVnzk
	 Yws0NEpuHnjAS3ezd77r+JYcCi1EIPfuZTsEASY7/mNY+BKdtauoziMGLKYsPU2gcVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795033383;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bN9i2RmrpWmNeLYeD3d20Nki5CIeURjyVzi7h5KnLXQ=;
	b=EUj9jKOVQa+ntrhQ4rNqmd4gk+7CqiQZ/O3sGEiSt6B65m67ThaAFSQNBtwhuvCOD3ND
	 M5WWV/Uv3e7m6reaIHG4eT5O3iP7xQJ8XEcUH0Vs9Me+yopIV/C5PJOTMtG/l5MoVhlM3
	 ai3oES6XPUvjkbvVX3Z4XahBjd9wYXDNEtJzyLj7OHaI1tAXE3qSbBPuFjOdna9U4cPsZ
	 mujiC3/D8QRWTwMnyUs00U+1wMRoF5hxwGHAetBvjyuntuqDifJZ1BZXv3v2ztJJiYc4l
	 pUaM+KcqjZh+6HR8POEbY2MtmHZX6WUY5OXu5jEaEcB0bIxWmxDs4To/k8kK9gQ1s/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hP5uuf5P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204C260A260B;
	Wed, 18 Nov 2026 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hP5uuf5P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F68B1F000D3;
	Wed, 18 Nov 2026 20:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795033383;
	bh=bN9i2RmrpWmNeLYeD3d20Nki5CIeURjyVzi7h5KnLXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hP5uuf5PoG+QOOylvsP9BTFrOcaEoU11t+w3cR6QFieMwhG4pDillqF4sH4Nzzt4O
	 WnE2Ciw2o3snKbYPpA/lB4YyIj9EqNSC6VAOlku6PYcfLOqYtTTFQWJ7fCR4of4GNE
	 yGMT5IUxxCQyPmhzF4B6MAo1oUzp+tewqmLF4G+oWzo8O4t6gSi3kJGKVt5CPHS78Y
	 3C/aX8HmVkgwt/OiY5TKql+xHQp8lg0ZYnKibRhyic4bvXSm0SVvroLEoK8baqHu1F
	 MJrxUsZSxU3epn1s8UBNvkoei3um9jLl+mVwaQdAmTmaSH+hWIZy6pykWWxvniJanL
	 kTwl1+FZnUJIQ==
Message-ID: <sashiko-outbox-221930@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/16] sched/deadline: Do not divide by zero active CPUs
 of a root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <46cf3d11435498c167e87c1e402c6ab2522f71ab.1795031605.git.mathieu.desnoyers@efficios.com>
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <46cf3d11435498c167e87c1e402c6ab2522f71ab.1795031605.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 20:23:02 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] sched/deadline: integer overflow in __dl_sub() and __dl_add()
  [1]
--

commit 976d925f6742563bd97b6e12f465ca24230d49b8
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Do not divide by zero active CPUs of a root domain

This commit guards the extra_bw updates in __dl_sub() and __dl_add()
against a zero active CPU count in a root domain during CPU hotplug.

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index dfae08625342e..b614d5fc1a1ac 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -189,18 +189,25 @@ void __dl_update(struct dl_bw *dl_b, s64 bw)
>  	}
>  }
> =20
> +/*
> + * Spread a change of total_bw over the extra_bw of the active CPUs of t=
he
> + * root domain. @cpus is their number. With no active CPU, as can happen
> + * during CPU hotplug, change total_bw alone.
> + */
>  static inline
>  void __dl_sub(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
>  {
>  	dl_b->total_bw -=3D tsk_bw;
> -	__dl_update(dl_b, (s32)tsk_bw / cpus);
> +	if (cpus)
> +		__dl_update(dl_b, (s32)tsk_bw / cpus);
>  }
> =20
>  static inline
>  void __dl_add(struct dl_bw *dl_b, u64 tsk_bw, int cpus)
>  {
>  	dl_b->total_bw +=3D tsk_bw;
> -	__dl_update(dl_b, -((s32)tsk_bw / cpus));
> +	if (cpus)
> +		__dl_update(dl_b, -((s32)tsk_bw / cpus));
>  }

[Severity: High]
This problem wasn't introduced by this patch, but can casting tsk_bw to
s32 in __dl_sub() and __dl_add() overflow and flip the sign [1]?

During a large cpuset bandwidth migration (cpuset_reserve_dl_bw() ->
dl_bw_alloc()), tsk_bw can exceed S32_MAX on systems with many CPUs.
Truncating tsk_bw to a negative s32 before dividing by cpus reverses the
sign of the delta passed to __dl_update(), corrupting per-runqueue
extra_bw accounting and breaking SCHED_DEADLINE admission control.

[1] https://sashiko.dev/#/bug/linux-ebf16093-b39b-4cd9-a580-85c7bb17302b

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795031605.gi=
t.mathieu.desnoyers@efficios.com?part=3D4
