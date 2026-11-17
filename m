Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794930062;
	b=wHhGesdofnyu68YE79fpRUfnYQ+5RgZryXwjgE2YHEF1JR+Z3j913AKnsbtEdwjFXeSe
	 IUbl215XWZFKUiOO8pO464F8iUfO7+VBgRAaJR26/zyBpspw8CVZ1nnUJgPKpm5EfxZAR
	 5527qf8ydgzqy+rZ10uGTG2Z/tqhfeInQbge1CO/98wtOYhh+0FlSJpHGZ7FBJceD6yBb
	 sJc2K9yZWgJ78Zokcg/Fas0UJ+wukAm4hhOrPdvqZGFhNBSuSVgchvc1mauiArrwwW1b8
	 LSzKPrTi9e1ti6dInbr5rDmUM3On0g1k8+ixaGGdrEGK1vZQoFr6YuWi5uVX7LiLIsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794930062;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wlJNvrjZWiuaRuGyrOQWgPk5txP+yFZUmFtsnOTUjgQ=;
	b=my3ICv4cnUSzK8zWPANr6fEPuBrc8gl4EtWbagmbZVDcs4Bovf2EQ/elyPYh9c97ZYJW
	 /nboCPw7+h8rh5qzzQ9u4zEoOZ+ePXtUrGk0LbC76WuQvhzLwNG1e1P2SNp6GQV1z/7Rq
	 qP109WXaNBpy+8YQIvzlZ5EPZeqoVEXtsx69zOqwsjR7+w+kZe9u5o43itNajLUK8B4R6
	 cQHVp3cAlA4xO2Pz3U7f2Kxi0UUCbXzaVu2OeddHWbEWe1xqHMS0ZKJOi8vYXewxGYK+z
	 H2dT9JbUIl1wiiaCQ83g96zsqry4d0eRkZGp97rrdgMxA5JcwMlu5TJyAwzA4RtDAEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgLpbGp+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5268F606A31C;
	Tue, 17 Nov 2026 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZgLpbGp+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4AC1F000C4;
	Tue, 17 Nov 2026 15:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794930062;
	bh=wlJNvrjZWiuaRuGyrOQWgPk5txP+yFZUmFtsnOTUjgQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZgLpbGp+c5WVEELtIYUoS+tOid1hUm4YRBQhPZvUm1yf8AA2/EzhXvZr4SjgvJ5t3
	 +3IlHb757hBp4BZRk0ZxOMN0yGIwFyLmf8cmlqdCepnwRbVPxVIXLCSPVCmv9OreIj
	 KcyzU6p/jwUGy4SpOckZKp2o0wJ/5Cr1G23oOsqfhr2Hwgoy7nQcTGbY/bZz7h5W/l
	 9BVmTcUuwbgeutwlOeohk7ySkS5euHKsUG7YtICXxeF9KPv9Q1IYyn+zRKfTQVwZzY
	 f3YMk8bON4uORYo1OvrncG4BH7QivcWQ9hIriKBQDjyBLnD+b6SqRrNLnTlLf6WEnw
	 FVV6XYW2dtcsg==
Message-ID: <sashiko-outbox-219096@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 29/40] sched/deadline: Keep the last CPU a task has
 in its root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <a075dad17300a5b31dc3d99bef81fb9dadd6cbcd.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <a075dad17300a5b31dc3d99bef81fb9dadd6cbcd.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:41:01 +0000
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
- [Medium] cgroup/cpuset: missing descendant cpus_allowed filter in
  cpuset_cpus_allowed_without()
- [Medium] cgroup/cpuset: filter by task_cpu_possible_mask() in
  cpuset_cpus_allowed_without()
--

commit 119af82ab355761f9fade868df0ef32c60b9344b
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep the last CPU a task has in its root domain

This commit refuses to take a CPU offline with -EBUSY when doing so would
leave a SCHED_DEADLINE task with runnable CPUs only outside the root
domain that accounts for its bandwidth.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7bdb9e21a7edb..3ccd61a37d302 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4312,6 +4312,32 @@ void cpuset_cpus_allowed(struct task_struct *tsk, =
struct cpumask *pmask)
>  	spin_unlock_irqrestore(&callback_lock, flags);
>  }
> =20
> +/*
> + * Set @pmask to the active CPUs that the cpuset of @tsk gives it once @=
cpu
> + * is offline: those of the nearest ancestor that keeps one. Leave it em=
pty
> + * if there is none. As cpuset_update_tasks_cpumask() does, keep the CPUs
> + * possible for @tsk. As __set_cpus_allowed_ptr() does, keep those of the
> + * affinity the user set, if one is left. The caller holds the CPU hotpl=
ug
> + * lock for writing, which keeps the cpusets and their tasks as they are.
> + * It holds the pi_lock of @tsk, which keeps its user affinity.
> + */
> +void cpuset_cpus_allowed_without(struct task_struct *tsk, int cpu,
> +				 struct cpumask *pmask)
> +{
> +	struct cpuset *cs;
> +
> +	guard(rcu)();
> +	for (cs =3D task_cs(tsk); cs; cs =3D parent_cs(cs)) {
> +		cpumask_and(pmask, cs->effective_cpus, cpu_active_mask);
> +		cpumask_clear_cpu(cpu, pmask);
> +		if (!cpumask_empty(pmask))
> +			break;
> +	}

[Severity: Medium]
Does cpuset_cpus_allowed_without() return an overly wide mask when it
walks past an intermediate ancestor to find remaining active CPUs?

During cgroup v2 hotplug, compute_effective_cpumask() propagates
effective_cpus top-down, intersecting each descendant's configured
cpus_allowed with its parent's new effective_cpus and only inheriting the
parent's mask when that intersection is empty:

kernel/cgroup/cpuset.c:compute_effective_cpumask() {
	has_cpus =3D cpumask_and(new_cpus, cs->cpus_allowed, parent->effective_cpu=
s);
	if (!has_cpus && is_in_v2_mode())
		cpumask_copy(new_cpus, parent->effective_cpus);
}

Consider a system with isolcpus=3Ddomain,0 and housekeeping CPUs 1-2, where
parent P has cpus_allowed =3D {1} and child C has cpus_allowed =3D {0, 1}
(giving C effective_cpus =3D {1}).  When CPU 1 is taken offline, walking up
from C skips P (which becomes empty) and returns top_cpuset's remaining
active CPUs {0, 2}.  dl_task_leaves_span() sees CPU 2 in the housekeeping
root domain span {1, 2} and allows the offline.  However, once P inherits
{0, 2} from top_cpuset, C computes cpus_allowed & P->effective_cpus =3D
{0, 1} & {0, 2} =3D {0}, moving the deadline task and its bandwidth onto
isolated CPU 0 in def_root_domain without admission control.

> +	cpumask_and(pmask, pmask, task_cpu_possible_mask(tsk));

[Severity: Medium]
Can intersecting pmask with task_cpu_possible_mask(tsk) after the
ancestor loop leave pmask empty when an ancestor has possible CPUs for
tsk?

On asymmetric arm64 systems where a 32-bit deadline task can only run on
a subset of CPUs, task_cs(tsk)->effective_cpus may retain active
64-bit-only CPUs after the outgoing 32-bit CPU is cleared.  The loop then
stops at task_cs(tsk), and intersecting with task_cpu_possible_mask(tsk)
afterward produces an empty pmask.  dl_task_leaves_span() treats an empty
msk as false and allows the last 32-bit CPU in the task's root domain to
go offline, after which guarantee_active_cpus() (which filters by
task_cpu_possible_mask(tsk) before testing each ancestor) walks up to an
ancestor with a 32-bit CPU in another root domain and moves the task's
bandwidth there without admission control.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D29
