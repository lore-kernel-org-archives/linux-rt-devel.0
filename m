Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229CC3921EC;
	Sat, 12 Sep 2026 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789243768; cv=none; b=JqFMjYrSdQWimk0tmnQsnHSowTZ5eooE5+XTbok0uDkTm0bcrB388K13ZHYmOfaJ+luDgqK2SDJlwMhzc9xH4GFnT2r6WiiJ547HQ+D6T9L+qWqpJs3OhkapRcCHA6hpSTRw3yBsjKcR3/9DZOhcyfCutYvKcX/DF++53L/TpZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789243768; c=relaxed/simple;
	bh=WojAOunnQHua6UevCKUF5uyfoZWpXARk3NtWdHl6fXc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QuiQC3WVtFFaCNwknUzDRq6lfHUmu60yq2ZKP2dhXgApP23llfyBOerLRVtdsg/A4XXgDyqAGUkbt4pngennr7w99zuQSAt3vn+db4REWhd2nA2TuRzl62bHhg61LpRKoircfjbJPw3C7K92WQfmobZWpYLVpFipBUksoSJh0dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LM4BT0ge; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LM4BT0ge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA4DF1F000FF;
	Sat, 12 Sep 2026 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789243766;
	bh=cf69hnfZhyaQSMzcNWdZwVKugIMigrIYQsNwOjVbsO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LM4BT0gelq/w7AuPqR949zzcqkfW0y724pqi7ksfUiZEhJeKMcdTJZ/L26Bo7xACJ
	 6Fpwb4MmMT5H3ky4kkXhJQfqWgDeSVN2BTx7lPK8yZQ9SVPtj9A7pgwztaFduVNALl
	 RPDWZM0lwlu7DAmZwxZY5zE0e6Y8/vsRXtRuulY2QoWzs0E2XSPSqVNShia49iPI8m
	 EcODE/ZbKUWxy4UOBoSqcpTtzDfiWrgIDtqbVL4O/vt1eVGmBz7leNqsE/0UZs5usw
	 xQT17ZXQgAh6Sd2zHazutQTf61PDZE+o40FL0l6ZRFezfTmnBthk6434h1DQwHQvbF
	 4IyDWEYhGO/RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] ARM: cacheinfo: count external caches in
 early_cache_level()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260912195552.76673-3-kmehltretter@gmail.com>
References: <20260912195552.76673-1-kmehltretter@gmail.com>
 <20260912195552.76673-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 12 Sep 2026 20:09:26 +0000
Message-Id: <20260912200926.AA4DF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Reallocation of cacheinfo memory via kzalloc_objs(..., GFP_ATOMIC)=
 is called with interrupts disabled on secondary CPUs in big.LITTLE systems=
, which crashes on PREEMPT_RT.
--

commit 19c5ea8e9a4a8fc2bc601139e06e4ead6e749ab2
Author: Karl Mehltretter <kmehltretter@gmail.com>

ARM: cacheinfo: count external caches in early_cache_level()

This commit alters early_cache_level() to directly invoke
init_cache_level(). This includes device tree-described external
caches in the early allocation size, attempting to avoid late cacheinfo
reallocation on secondary CPUs which causes issues on PREEMPT_RT.

> diff --git a/arch/arm/kernel/cacheinfo.c b/arch/arm/kernel/cacheinfo.c
> index 860eeb03cfe5d..31591c9472548 100644
> --- a/arch/arm/kernel/cacheinfo.c
> +++ b/arch/arm/kernel/cacheinfo.c

[ ... ]

> @@ -146,6 +139,11 @@ int init_cache_level(unsigned int cpu)
>  	return 0;
>  }
> =20
> +int early_cache_level(unsigned int cpu)
> +{
> +	return init_cache_level(cpu);
> +}

[Severity: High]
This is a pre-existing issue, but does this CLIDR fallback path still leave
the kernel vulnerable to a panic on PREEMPT_RT if a secondary CPU happens to
have more cache leaves than the boot CPU?

On big.LITTLE ARM systems, if a secondary CPU has more cache leaves and no
device-tree cache specification is used, early_leaves will be smaller than
the required size. This forces a reallocation while interrupts are disabled
on the secondary CPU:

arch/arm/kernel/smp.c:secondary_start_kernel() {
    ...
	trace_hardirqs_off();
    ...
	update_siblings_masks(cpu);
}

drivers/base/arch_topology.c:update_siblings_masks() {
    ...
	ret =3D detect_cache_attributes(cpuid);
}

drivers/base/cacheinfo.c:init_level_allocate_ci() {
    ...
	if (cache_leaves(cpu) <=3D early_leaves && per_cpu_cacheinfo(cpu))
		return 0;

	kfree(per_cpu_cacheinfo(cpu));
	return allocate_cache_info(cpu);
}

drivers/base/cacheinfo.c:allocate_cache_info() {
    ...
	per_cpu_cacheinfo(cpu) =3D kzalloc_objs(struct cacheinfo,
					      cache_leaves(cpu), GFP_ATOMIC);
}

On PREEMPT_RT, memory allocation with GFP_ATOMIC relies on a sleepable
slab rt_mutex. Calling this with interrupts disabled results in a BUG
("sleeping function called from invalid context") and a system panic
during boot.

Could this reallocation path be avoided or deferred to a context where
interrupts are enabled for secondary CPUs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912195552.7667=
3-1-kmehltretter@gmail.com?part=3D2
