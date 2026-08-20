Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918101F12F8;
	Thu, 20 Aug 2026 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236249; cv=none; b=mcpbpdNDJbJoxnFLzYl+rjqLKyqG1V1sblX/U+RpK1vK/g3y1GYgugEleQzRKsLZR0F0WvHLXTno5opM12Rv+2MI04F4WyQA51SXphu/Bixr/dFFxcBtD8+l8AnQybTak12/unCcb0eHhVsOyp5/NGDjabBLUVvJskHL9+bEjTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236249; c=relaxed/simple;
	bh=hh8Ddx7WY1oSzmoq98pwt/7a9h5Z8WAOjmKndyT2ebo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XTuXcMDnSEyA1fSss4xBROhP9IqFDQuVbONOgANxijUJ5ulIElCUShHVNGpElkGcsMU9EUsJBwpDZKikoVJS7//sGtMrv7gYc73XiydDUP18bGrxoRJw2y31gL93xRkPkNJSabUEOxbOIQ0rs9/+twV6TUSzUqitmJ6MZGRD3Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvxBKv8d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvxBKv8d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C641F000E9;
	Thu, 20 Aug 2026 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787236247;
	bh=n7tMbSqmwszLxvrla2Xz68UZmP3Mwl6PN1C2SKC1Rtg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MvxBKv8dyLqr1KVF1ShqYwfoEaMVludu40qzZXI/ymUdffCDhQgUROSJPA3b/O6zE
	 4MzrKkQV+h4aNANm/Srs8poEJHHIyfyc1oEZVtFOD1Xpyd1dTWxPHXRXpSZPNv28vu
	 y92goY4L6oacEqPokIF71Zwbc/PyacDgJJcc6nwlXP8IIemJc9/EkDe6ABSyqtnpoh
	 jsDweK5eCpN8ZOASDnMjGYm/zQaMMHZi4N6eHGAiOJHJYUMTaxGO4HFsewaFNObiig
	 1gF/aMO+SFfZJYxzrdrZ2wV5mz8C/YGm80o5pWTDmmjvkPf61nVbVxGgWQ5vHGkVcY
	 JJD5WDWbv9itA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/3] cpumask: Honor irq_default_affinity in
 cpumask_local_spread()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Bezdeka" <florian.bezdeka@siemens.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-1-3f79a99cadaf@siemens.com>
References: <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com>
 <20260819-flo-net-7-2-make-stmmac-default-affinity-aware-v1-1-3f79a99cadaf@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:30:46 +0000
Message-Id: <20260820143046.D2C641F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] cpumask_local_spread() can return an invalid CPU index (>=3D n=
r_cpu_ids) when offline CPUs are present in irq_default_affinity, leading t=
o out-of-bounds memory accesses in callers.
- [High] Unprotected, non-atomic accesses to irq_default_affinity in cpumas=
k_local_spread() can race with concurrent updates from procfs, causing a di=
vision by zero or an out-of-bounds index return.
--

--- Patch [1]: [PATCH RFC 1/3] cpumask: Honor irq_default_affinity in cpuma=
sk_local_spread() ---
commit 451b7ef83d22392d8351ba057c391bf3a21095c8
Author: Florian Bezdeka <florian.bezdeka@siemens.com>

cpumask: Honor irq_default_affinity in cpumask_local_spread()

This patch updates cpumask_local_spread() to honor irq_default_affinity
instead of cpu_online_mask. This aims to prevent IRQs from targeting
isolated CPUs for workloads like PREEMPT_RT.

> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 5adb9874fbd0f..73e7b60a92011 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c

[ ... ]

> @@ -110,9 +112,9 @@ unsigned int cpumask_local_spread(unsigned int i, int=
 node)
>  	unsigned int cpu;
> =20
>  	/* Wrap: we always want a cpu. */
> -	i %=3D num_online_cpus();
> +	i %=3D cpumask_weight(irq_default_affinity);

[Severity: High]
Is it possible for a concurrent write to irq_default_affinity to cause a
division by zero?

Userland can update the mask via /proc/irq/default_smp_affinity, which
uses a non-atomic cpumask_copy() in default_affinity_write().

If cpumask_local_spread() locklessly computes the weight while bits are
being copied, could it momentarily observe a weight of 0 and trigger a
division by zero panic here?

> =20
> -	cpu =3D sched_numa_find_nth_cpu(cpu_online_mask, i, node);
> +	cpu =3D sched_numa_find_nth_cpu(irq_default_affinity, i, node);

[Severity: Critical]
Does this code return an invalid CPU index if there are offline CPUs
present in irq_default_affinity?

The modulo above uses cpumask_weight(irq_default_affinity), which
counts all bits in the mask regardless of whether the CPUs are online.

However, sched_numa_find_nth_cpu() only searches within cpu_online_mask:

include/linux/topology.h:sched_numa_find_nth_cpu() {
    return cpumask_nth_and(cpu, cpus, cpu_online_mask);
}

If irq_default_affinity contains offline CPUs, the weight can be larger than
the number of online CPUs.

If i ends up larger than or equal to the number of online CPUs in the mask,
won't sched_numa_find_nth_cpu() fail and return an index >=3D nr_cpu_ids,
causing out-of-bounds memory accesses in callers?

> =20
>  	WARN_ON(cpu >=3D nr_cpu_ids);
>  	return cpu;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-flo-net-7-=
2-make-stmmac-default-affinity-aware-v1-0-3f79a99cadaf@siemens.com?part=3D1
