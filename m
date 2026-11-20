Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209482;
	b=Ubn3WIRoPz4jKt7IYbc9gvPORePVPIcPtMLooThjdtdkG4gZtTHsBpl+yDWjzO6d0rvL
	 4pGaQZSTZHOAVCVPNOxq2ZF39bj3xoXGLixM6awirDg0Jh8V5m0FeAtV2Br98pYNyJGri
	 DuqiGO3fqpyBqygsyfZlyI65q5zvTGWv7ZPLldBEIsuqO9hZHxgfggqOhyCU9FKwqZBa8
	 wJN5MRltJvxTuEuXwW5fXvp8mQP6U/zJ79As4wCf7L5ZzYXGeaHOgy77Ne9nr3PG8+g0O
	 qIuqsUBcQIGfSArDyJo0zvzG6axzR5FbQpoU1pJpqZfR5LCPbwMiNpV4ePgZ71xygQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209482;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=LUatZsx+OjdjB9hoDWV8i7p3YX61+WOHN0UmE2quwBo=;
	b=3ecy47dOSIMjEwPyJk654emi1JLRFSndRLkYSX94UlhofGYrjvuGP7HQyJh7ajQhytMn
	 bVHqezF5opMa2chsFkAuYE4tl+t2vHmW72gjtQjJJ34i2vumkaoPN/HRyXu//O963lZq/
	 rih0xZcHSnLBtAG1Qpv56W2QmJX66abmUhVmfb/VD1ALdIfZf95GwpqLavMgu9d3hYsnC
	 48GCJVdrMbNpCcz4ybtLLSSzk0VTzXdGqQ7LZLZFVKWko8lql4m8XXBv4A7t/mGCUxRCE
	 tuwleg+lb3TFnUzKtLL/2y6AFPT/M5PNc/e5N89aVYjcKDkp5bUsAU4Fcanx21TnJhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnA4CmsV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9D60A2600;
	Fri, 20 Nov 2026 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CnA4CmsV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911181F000CA;
	Fri, 20 Nov 2026 21:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209481;
	bh=LUatZsx+OjdjB9hoDWV8i7p3YX61+WOHN0UmE2quwBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CnA4CmsVfPq37brUqn/PwLVLykL6C9ajZKprLKIJxyaMUZQQNGbfOIxTWItWBSQfI
	 1YFjVvKb/hbpOsvvqOrZ8+cSEGC2C/xzAGi4ZhBTAdERvKAKQBgENwV1jBOkGsLNKt
	 4iN5E+5NpVUHIT/J6eBBrfWgG9y4sSLq7a6Q2n9zkVdG5iWDB4VhAD+z5oXAItR9P8
	 vwx/SpG8raheumtItkmN1GMJKgFPLLAtfkHlIvicPrabxsw6Gbl0wyDcqt9X/QPZ3q
	 REC+u/Q9hqkdjAcUlMMg2bcb6m1WLlH/DgjCuA7M3IVnNARqjHI7m0o5WBXW7mIMDw
	 B2VYPHa0TFAww==
Message-ID: <sashiko-outbox-226154@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 03/40] sched/deadline: Record the root domain
 holding a task's bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <1d10d1a2f94b18ec7e51c1c57833a34c2481c092.1795207232.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <1d10d1a2f94b18ec7e51c1c57833a34c2481c092.1795207232.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:18:01 +0000
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
- [Medium] sched/deadline: dl_task_admit_cpu() returns offline CPU in
  p->cpus_mask
- [Medium] sched/deadline: dl_task_check_affinity() uses stale CPU when
  dl_bw is 0
--

commit fc9f04f79ff6b3431efcbfa8c33fd7eb5355e667
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Record the root domain holding a task's bandwidth

This commit records in dl_bw_cpu a CPU of the root domain that accounts for
a deadline task's bandwidth, replacing dl_departed_cpu so that admission,
affinity checks, moves, and releases operate on the root domain where the
bandwidth is counted even when a sleeping task remains on a CPU from
another root domain.

Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-1-dd761f=
e005b4@redhat.com/

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d1a2ae9ab75fd..dbb5dafff3717 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -3592,14 +3618,52 @@ static void task_woken_dl(struct rq *rq, struct t=
ask_struct *p)
[ ... ]
> +static unsigned int dl_task_admit_cpu(struct task_struct *p)
> +{
> +	unsigned int cpu;
> +
> +	if (task_has_dl_policy(p) && p->dl.dl_bw && p->dl.dl_bw_cpu >=3D 0 &&
> +	    p->dl.dl_bw_gen =3D=3D dl_bw_gen)
> +		return p->dl.dl_bw_cpu;
> +	cpu =3D task_cpu(p);
> +	if (!cpumask_test_cpu(cpu, &p->cpus_mask)) {
> +		unsigned int other =3D cpumask_first_and(cpu_active_mask, &p->cpus_mas=
k);
> +
> +		if (other < nr_cpu_ids)
> +			cpu =3D other;
> +	}
> +	return cpu;
> +}

[Severity: Medium]
Can dl_task_admit_cpu() return an offline CPU when p is asleep on a CPU
that went offline?

For tasks in top_cpuset (or when CONFIG_CPUSETS is disabled), CPU
hot-unplug does not clear the offline CPU from p->cpus_mask.  If p is
asleep on that CPU when sched_setattr() enters SCHED_DEADLINE (or updates
a zero-bandwidth task), cpumask_test_cpu(cpu, &p->cpus_mask) is still
true, so dl_task_admit_cpu() returns the offline CPU whose runqueue is
attached to def_root_domain.  __sched_setscheduler() and
sched_dl_overflow() then check and charge def_root_domain instead of the
active root domain where p will run, failing with -EBUSY when
def_root_domain has no active CPUs or accounting the bandwidth in the
wrong root domain.

Should the fallback also trigger when !cpu_active(cpu)?

> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 96a5f0a7adbc3..95181e5de8da6 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
[ ... ]
> @@ -1204,9 +1213,16 @@ int dl_task_check_affinity(struct task_struct *p, =
const struct cpumask *mask)
>  	 * if admission test is enabled, we only admit -deadline
>  	 * tasks allowed to run on all the CPUs in the task's
>  	 * root_domain.
> +	 *
> +	 * That is the root domain that counts the bandwidth of the task:
> +	 * the one of the CPU recorded with it. A task moved asleep to
> +	 * another cpuset is still on a CPU of the root domain it left. A
> +	 * bandwidth of 0 is counted nowhere, and no move updates its
> +	 * record: use the CPU the task is on.
>  	 */
> +	cpu =3D READ_ONCE(p->dl.dl_bw) ? dl_task_root_domain_cpu(p) : task_cpu(=
p);
>  	guard(rcu)();
> -	if (!cpumask_subset(task_rq(p)->rd->span, mask))
> +	if (!cpumask_subset(cpu_rq(cpu)->rd->span, mask))
>  		return -EBUSY;
> =20
>  	return 0;

[Severity: Medium]
When p->dl.dl_bw is 0 and p was moved to another cpuset partition while
asleep, doesn't task_cpu(p) still point to the old root domain that p left?

Because dl_task_needs_bw_move() skips zero-bandwidth tasks, p->dl.dl_bw_cpu
is not updated on the move, and while p remains asleep task_cpu(p) is still
a CPU of the old partition outside p->cpus_mask.  Calling
sched_setaffinity() before p wakes up intersects the requested mask with
the new cpuset's allowed CPUs and then checks cpumask_subset() against the
old root domain's span, causing sched_setaffinity() to fail with -EBUSY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D3
