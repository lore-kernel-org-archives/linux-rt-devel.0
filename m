Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795657085;
	b=XXG+enXHTEbSvWXAx/m2ZxB3c/ScOV75ti/fTb0TEVdxH5wyrAxyYdqb0OJhg5ihkXga
	 kj+1XyrbPfmrbpd3FUUBa1xyTgMFkWnpTXJbqo0LYMU3rCgGkXtCxt4YgwiL/QwDmKsiz
	 lqllVUZPPoyGfr3TAG65uzuED1ijoq52XYj6FToqo+Je0QaEke9MF0LlOe0gcuNtWd/Ac
	 npJQ2O1JMcpBFbMYFwDaoquuRhnV2CAJVlcXJe1fCV5iebM0IcDG8fpLW4npt/U9J6LQ8
	 rYVVVNOqhdMAHKQCy6qem2Vu2hdJi2OUmdSy0qw9BoEpDPOL6/soY/1gNiK7mWdXDKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795657085;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zog7jF/2BPtVfJQhwRXt+srPHB7Tq3M8n+JZAtPbs2Y=;
	b=FE8UZESy4UeCmR4YUQV4LxX+ibMpru6n3xZ7J+OroW9NOJ89mqgKP2N6i9m0fhnbj9yu
	 hmqiJjA0MUpG3xK/h35c2mqvuu/MzUVlr5ipRnpDHV49ElGZ+QezVlu8+gDLjXtjdyvMY
	 uFlpgtIl2S7ZWCjDravKy0N1woWL+4V3b6N5X9gStVHooewfl6+PveI47c6XnbTUXYe+6
	 70qqHDc0TBJNIo++Rn19LYf13cKlKNuUaCCDkMPA8T5GAd4iwEjuM5IkET6XojCNchViH
	 IJuJpcnt7xh7sOu5gmS2J1kK3ks3M/Ww47ocYxfNRVRdnBdorL4CWwG3hGxHvHYFNog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtoW5qj0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2253606A31E;
	Thu, 26 Nov 2026 01:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BtoW5qj0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154591F000C4;
	Thu, 26 Nov 2026 01:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795657085;
	bh=zog7jF/2BPtVfJQhwRXt+srPHB7Tq3M8n+JZAtPbs2Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BtoW5qj0Uiwnj9C4fmhsGV66V9y8xpJ7ju3GU1TjtadTsZeU7AkYXVMo7LYG7OjvK
	 qGzR/JZLSk0RD8w2URCQTAld4urozgOizBYjg5ttotvnRwhGFEfFH3Aelx1LaoBRUV
	 hlB63ppCZPRT7WObhCmc+agD/L0B5HpfmfrbcgYrEa/rCoABKju1l82g0j4GmKenJC
	 YvsHvjd3FAq0tb1S5xbJ4rsaVa4KRtVIVvjkwZGoW/p9ITRPpuNDPlPfCmnlHtLUA0
	 bYN07hMYtnjKAw2+WohSgtYWNaDdf03DOA1zfESy5hzBywOV1LAlCJA+AMAfkhko49
	 oYWMvH4WDFxDQ==
Message-ID: <sashiko-outbox-234570@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 15/43] sched/deadline: Keep a task in the root
 domain that counts its bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <1b7d48df779794ceece2155c0080722932f2c3cd.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <1b7d48df779794ceece2155c0080722932f2c3cd.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 01:38:04 +0000
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
- [Medium] sched/deadline: select_fallback_rq() bypasses local NUMA node
  search
- [Medium] sched/deadline: __set_cpus_allowed_ptr_locked() clobbers
  valid wake_cpu
--

commit 4af84b97f62357ff3460aae481348b8b367fe8d9
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep a task in the root domain that counts its bandwidth

This commit introduces dl_task_bw_span() and updates CPU selection paths
during affinity changes, wakeups, CPU offline, and sched domain rebuilds
to prefer CPUs within the root domain that accounts for a deadline task's
bandwidth.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 7615ba02d52b3..3dd42581cc177 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3264,6 +3264,27 @@ static int __set_cpus_allowed_ptr_locked(struct ta=
sk_struct *p,
>  			dest_cpu =3D ctx->dl_bw_cpu;
>  		if (!task_on_rq_queued(p))
>  			p->wake_cpu =3D dest_cpu;
> +	} else {
> +		const struct cpumask *span =3D dl_task_bw_span(p);
> +		unsigned int cpu =3D nr_cpu_ids;
> +
> +		/*
> +		 * No room was made for @p in another root domain. Keep @p
> +		 * in the root domain that counts its bandwidth, if the new
> +		 * mask holds one of its CPUs. Also wake a sleeping @p up
> +		 * there. A wakeup during a rebuild of the sched domains has
> +		 * no span to prefer.
> +		 */
> +		if (span && cpumask_test_cpu(dest_cpu, span))
> +			cpu =3D dest_cpu;
> +		else if (span)
> +			cpu =3D cpumask_first_and_and(cpu_valid_mask,
> +						    ctx->new_mask, span);
> +		if (cpu < nr_cpu_ids) {
> +			dest_cpu =3D cpu;
> +			if (!task_on_rq_queued(p))
> +				p->wake_cpu =3D dest_cpu;
> +		}
>  	}

[Severity: Medium]
Does this overwrite p->wake_cpu for a sleeping deadline task even when
its existing p->wake_cpu is still valid in ctx->new_mask and span?

dest_cpu is chosen earlier via cpumask_any_and_distribute(cpu_valid_mask,
ctx->new_mask).  Unlike a queued task (where affine_move_task() leaves p
on task_cpu(p) if it remains in the new mask), a sleeping deadline task
has p->wake_cpu unconditionally replaced with the pseudo-random dest_cpu
whenever span is non-NULL, forcing an unnecessary migration on the next
wakeup.

Only updating p->wake_cpu when it is not already in cpu_valid_mask,
ctx->new_mask, and span would preserve wakeup locality.

> @@ -3668,8 +3689,22 @@ static int select_fallback_rq(int cpu, struct task=
_struct *p)
>  	int nid =3D cpu_to_node(cpu);
>  	const struct cpumask *nodemask =3D NULL;
>  	enum { cpuset, possible, fail } state =3D cpuset;
> +	const struct cpumask *span;
> +	bool span_forced =3D false;
>  	int dest_cpu;
> =20
> +	/*
> +	 * Keep a deadline task in the root domain that counts its
> +	 * bandwidth, if one of its CPUs is allowed and online.
> +	 */
> +	span =3D dl_task_bw_span(p);
> +	if (span) {
> +		for_each_cpu_and(dest_cpu, span, p->cpus_ptr) {
> +			if (is_cpu_allowed(p, dest_cpu))
> +				return dest_cpu;
> +		}
> +	}
> +
>  	/*
>  	 * If the node that the CPU is on has been offlined, cpu_to_node()
>  	 * will return -1. There is no CPU on the node, and we should

[Severity: Medium]
Does this early return bypass the local NUMA node search in
select_fallback_rq() for deadline tasks?

Because dl_task_bw_span(p) returns rd->span for any admitted deadline
task outside a domain rebuild, scanning span & p->cpus_ptr in ascending
CPU order and returning before the cpumask_of_node(nid) loop below skips
same-node CPU selection on multi-node NUMA systems and always sends the
task to the lowest-numbered allowed CPU in its root domain.

Checking cpumask_of_node(nid) intersected with span first when span is
non-NULL would keep the task in its root domain while preserving NUMA
locality.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D15
