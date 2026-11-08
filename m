Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165924;
	b=j3/XzzEuG1cZd94ODttF4UlBfITi34dy1tMAk0Wk7SsIdGWaLog+gjWzjFxHKCdyYrx0
	 IxGRcFA0R4SfBJpDJbvx1xhqKIC3dJ4cETcpePbgBLqxVqB9ZT4A9bho1Tk1xhq8rPEmJ
	 Km65xcyL7MWYoPs78iqWhLLST6g/NkhL3QSYYtDDoF3KEMxQEh/zPKhyFBOLf9V9NJNad
	 ZrrsUrpHCtL+OA6/TJPKtU66rfcLyGhwx4NoZGnxRro0jtpj1SmIv3ZychHVx4wpF4mnR
	 yJuZT9sf50VL8p15Y7OwwDGUf0YMfG23V5h4caokjghTC8YF29bluF6f77S/h6vm3kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165924;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Idnvy6UBEdjdA2ebpHOLOhTTrf10eml5JHDqpJWTatE=;
	b=OqkSamGCOJ8o9WFRivrdYjFp7yPmPMCY7POuOw2VVNgR0wOGYuoFMUYfiwqNYdmRSDQ4
	 4SR9zOXRZQRlZDq1BTYrrds6JrrIhKmb+jYN0cxqhZCAX2ubztSfyUe/vF3etxoHdpcTU
	 E0Igks4KJm4I9jW/bNprZN3C0iIEjiSYffqomGoGeZTO3wMZDamliokQooo1Qb/RLOO2n
	 JRWtDHmxUX3bezAkHOR+Mhg2Prpud0Xw6ENu1stC+T7zo8K+53UN5/mmSECnjIbvomLmB
	 NVZOaIFBPctGDdHT4y0fMxopnbmwRdALhsxPXG0ommjzxsMlk3EvJ1kI8OUx4voLHUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaId8wOQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F19E606A31C;
	Sun,  8 Nov 2026 19:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaId8wOQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9771F0089F;
	Sun,  8 Nov 2026 19:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165924;
	bh=Idnvy6UBEdjdA2ebpHOLOhTTrf10eml5JHDqpJWTatE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UaId8wOQaGFBfv4Z9KvrNcr6YLzL4Mo4Qjp0V+s7P1KYmQt+GZzd7p3SwAQVNEGo2
	 6cMDkBjB/AK07RIAhZ49WEnD5DJJL8OhuaUIYTlrTJoU7M06pV/rOBj5PCfzK+seZK
	 11bwt3sWMepF29mM2pHEjvXdZB2Dz1DKz/pVqIRTwsAGpiQUpvLqRBEqPJYY3LDxNl
	 yoYIqye4GnsoBJTfpCOE53Cp2kCIP8+9bUXVqYhKsV4FrrBoYHK27fkZ5iPVhQZc+t
	 vjvoWSpBMz1X1USyCUD9z+0ErAwQFXlkNMez+AE9gb5jwddOd2ef7XVlfbWQzMHwEl
	 4HZDIq63cW8jg==
Message-ID: <sashiko-outbox-203947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 22/29] sched/deadline: Make a rebuild use the CPU
 recorded with a task's bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261108185406.1549770-23-mathieu.desnoyers@efficios.com>
References: <20261108185406.1549770-1-mathieu.desnoyers@efficios.com>
 <20261108185406.1549770-23-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 19:25:23 +0000
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
- [Medium] sched/deadline: wrong root domain in dl_task_rebuild_cpu() on
  empty mask
--

commit 2d9a77b300d6ae31513d7938853f189f48778450
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Make a rebuild use the CPU recorded with a task's bandwidth

This commit updates deadline root domain accounting rebuilds to select a
task's root domain from its current CPU, recorded bandwidth CPU, or active
cpumask, and skips tasks with no active CPU instead of hitting BUG_ON().

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 8d9e55bca9439..bc31045e4686f 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -3720,6 +3726,55 @@ static void dl_get_task_effective_cpus(struct task=
_struct *p, struct cpumask *cp
[ ... ]
> +static unsigned int dl_task_rebuild_cpu(struct task_struct *p)
> +{
> +	struct cpumask *msk =3D this_cpu_cpumask_var_ptr(local_cpu_mask_dl);
> +	int recorded =3D p->dl.dl_bw_cpu;
> +	unsigned int cpu;
> +
> +	/*
> +	 * Look at the mask of the task first. A change of the cpusets sets
> +	 * the mask of each task before its rebuild. The housekeeping mask
> +	 * that dl_get_task_effective_cpus() reads is updated after it. If no
> +	 * CPU of the mask is active, take the CPU recorded if it is active:
> +	 * dl_task_offline_migration() moved the task there. Else ask the
> +	 * cpuset.
> +	 */
> +	cpumask_and(msk, &p->cpus_mask, cpu_active_mask);
> +	cpu =3D task_cpu(p);
> +	if (cpumask_test_cpu(cpu, msk))
> +		return cpu;
> +	if (cpumask_empty(msk)) {
> +		if (recorded >=3D 0 && cpu_active(recorded))
> +			return recorded;
> +		dl_get_task_effective_cpus(p, msk);
> +		cpumask_and(msk, msk, cpu_active_mask);
> +	}
> +	if (recorded >=3D 0 && cpumask_test_cpu(recorded, msk))
> +		return recorded;

[Severity: Medium]
Can returning recorded whenever cpu_active(recorded) is true on an empty
msk charge a sleeping task's bandwidth to a stale root domain instead of
consulting dl_get_task_effective_cpus()?

Suppose a task in top_cpuset with user_cpus_ptr =3D {1} and cpus_mask =3D {=
1}
is asleep when CPU 1 goes offline.  Top_cpuset tasks do not have cpus_mask
reset on hotplug, so the hotplug rebuild sees cpumask_empty(msk), queries
dl_get_task_effective_cpus(), and records active CPU 0 in p->dl.dl_bw_cpu.
If a new cpuset partition root is then created on CPU 0 while the task
stays asleep, cpuset_update_tasks_cpumask() intersects the remaining
possible CPUs with user_cpus_ptr ({1}), leaving cpus_mask as {1}.  The
partition rebuild then sees cpumask_empty(msk) and cpu_active(0), and
returns CPU 0 without calling dl_get_task_effective_cpus(), charging the
task's bandwidth to the new partition on CPU 0 rather than top_cpuset.

Also, because the cpumask_empty(msk) block returns early whenever recorded
is active, if execution reaches dl_get_task_effective_cpus() and
cpumask_and(msk, msk, cpu_active_mask), recorded is guaranteed to be
inactive, so the subsequent cpumask_test_cpu(recorded, msk) check can
never succeed after that fallback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108185406.1549=
770-1-mathieu.desnoyers@efficios.com?part=3D22
