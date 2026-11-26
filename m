Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795656947;
	b=AaQMj5VyCd4KBWeEcvrxTiA/g7IVTvbhN7FoJXS8BFPCyAaSLzhE5WxwAe29SIoXvgX9
	 8dMDvmTBQ8N1WdC7AuMYR6hTVCLv9C0MQILFW6gvW2Be5ssYTTrNFA1nOo7tBuy7h4nuR
	 6MYpYnmM9TG6LdUhrjarG1fpvUtgbzJUd6pWNTfTfJvCXaMj7vnS396K73iHtT8IbdPma
	 RkkA7r3fBRDAqPCRrBuAd/WUJ3tf4EPreQhHd7Z+zZVMxIbEdNd/QcOCJwpv3SFO2/pvf
	 v5w4pAJ5BNX8qWo80XtV5FQkSv5eP0G+tJR/eVGSmvNHyV5s/kOVcOH0o0V0xkM8W9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795656947;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UBctsvJEzz0DHRWtLTStJ9Xmzeqn9/SRgg3Tp+mO8Ck=;
	b=pmFmRnrXTvpPgbI2kRU6FVvJ3pDKhjh+F+Ix1OS50HBi6CpUFFO02uRT4/A1PnIsNx5m
	 rU6X80yaPbkY9DECajFtw7iFmJL2dHbnDNH9dzw9kAELXeVA0dm3VH2wIeBqJNBm9+tUI
	 +fwzgImYxsj8DbEnHGKzq4G9ZlE2gPrAlO94zk2EFgFexdvDxtfmJmY4x3m8oSN/3DrVJ
	 KCk7G7ToptpPykzZP1OmpKTLQvKVDSxBcF3xMipS5gZrrzdX/SMKWD0jlU7qf+i2MPwO5
	 9kVS3M7u4TWRNWiilOoLHKVt04Ly1npdYPDDNfROaOi+L+XzufGdjcR1egV+8eAKIrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2OeijWg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAEB606A327;
	Thu, 26 Nov 2026 01:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I2OeijWg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DFDF1F000C4;
	Thu, 26 Nov 2026 01:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795656947;
	bh=UBctsvJEzz0DHRWtLTStJ9Xmzeqn9/SRgg3Tp+mO8Ck=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I2OeijWgCRTjlYDD4V+v6TVScq24Pq0FN1uJ9xcmzLAvMua/27RE+3DY0o3yvo5Fl
	 /6z71JkiDCD/RGAlL+BqHuJFgxNdsbafJwT1zj/q/IDEmJDAWdwLeJv6s9UOLc2yWn
	 UNU/VvyFqo24wxpF9nlm+oasrHp7aB1AkCyw7/WMZXYNIryZEViDRQJ1p82Nk+BgrV
	 pe3NyZHf3sIv8nDNNMkN+p86fy7yaEqpMUH1VcCHs180XA9Qj/C7zI7do1s4SJFZW5
	 Z6WQzPzEC4tYaeJz+ygHCgVAuam8f/cCR6Qyqon00CYm65WDBc8cZtQzH1dtPUU12N
	 432ARlImU328A==
Message-ID: <sashiko-outbox-234566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 16/43] sched/deadline: Keep the last CPU a task has
 in its root domain
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <8760bd586c67945ac5129fd92e52bdfc2e840c67.1795646914.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <8760bd586c67945ac5129fd92e52bdfc2e840c67.1795646914.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 01:35:47 +0000
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
- [Medium] cgroup/cpuset: wrong v1 ancestor walk in
  cpuset_cpus_allowed_without()
--

commit e0e4cf76f577347925934619360185ec78904567
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Keep the last CPU a task has in its root domain

This commit refuses CPU offline operations with -EBUSY when taking the CPU
offline would move a SCHED_DEADLINE task out of the root domain that
admitted its bandwidth.

> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 7bdb9e21a7edb..37d04b08996ec 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
[ ... ]
> @@ -4312,6 +4334,292 @@ void cpuset_cpus_allowed(struct task_struct *tsk,=
 struct cpumask *pmask)
>  	spin_unlock_irqrestore(&callback_lock, flags);
>  }
> =20
[ ... ]
> +bool cpuset_cpus_allowed_without(struct task_struct *tsk, int cpu,
> +				 struct cpumask *pmask)
> +{
> +	const struct cpumask *possible =3D task_cpu_possible_mask(tsk);
> +	struct cpuset *cs =3D task_cs(tsk), *from, *gone =3D NULL;
> +
> +	guard(rcu)();
> +	if (!is_in_v2_mode()) {
> +		/*
> +		 * cgroup v1 moves the tasks of a cpuset left with no CPU to
> +		 * the nearest ancestor that keeps one.
> +		 */
> +		for (from =3D cs; from; from =3D parent_cs(from)) {
> +			cpumask_and(pmask, from->effective_cpus, cpu_active_mask);
> +			cpumask_clear_cpu(cpu, pmask);
> +			if (cpumask_intersects(pmask, possible))
> +				break;
> +		}

[Severity: Medium]
Should the cgroup v1 loop break on !cpumask_empty(pmask) instead of
cpumask_intersects(pmask, possible)?

On cgroup v1, cpuset1_hotplug_update_tasks() only considers a cpuset empty
and moves its tasks to an ancestor when cs->cpus_allowed becomes completely
empty:

kernel/cgroup/cpuset-v1.c:cpuset1_hotplug_update_tasks() {
    ...
	is_empty =3D cpumask_empty(cs->cpus_allowed) ||
		   nodes_empty(cs->mems_allowed);
    ...
	if (is_empty)
		remove_tasks_in_empty_cpuset(cs);
}

On systems with asymmetric 32-bit support where task_cpu_possible_mask(tsk)
is a subset of cpu_possible_mask, a cpuset can retain active 64-bit-only
CPUs after the offline while having no CPUs left in possible.  In that case
cgroup v1 leaves the task in cs and falls back to select_fallback_rq(),
whereas this loop walks up to parent_cs(from) and can return an ancestor's
32-bit-capable CPUs in pmask, allowing dl_task_leaves_span() to accept an
offline that moves a deadline task to another root domain or reject a valid
one with -EBUSY.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D16
