Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794928487;
	b=WkSdmKerecQHFe2b3f8mkx4kf5bKi5Ov3Nt4saGLJFz9J97IIeyh7AuxcxSrUvPWa5UI
	 gJ0Ltn5H+u8w9BMp88+sWjWagL1OTafVTxsLaj9vT1Q78xZkYHcQx/WYdG+B2VHcqF1Gl
	 M2ZWoPJYK1mFsVWuejujXlmO/mUXWSBIBCjeHSvlHh00Ke6JeXjTNpg7czJcplJv9AU8S
	 N9HaY0x8hsFLGqwSFqo5DNvkPsmpCoXA9UPuvz5wUiy00vSXjjcdzJs/tW26WS+0cB6Nb
	 uciDOxVeXbhBubsRNXXxlSXh2SIu+NdA5LLI8oA86/pOv04OcK2mtL5XERqBg1GMmJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794928487;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FlqNaTQ1KSYXtEicQmukvAIbCh1ZGMk91UvUei3msgo=;
	b=lzdHms/w+9UxvEFYwv2jq0WCgsgPpwpUObxh4s687FA+YzmqJjO7Y5nIMh/aZdUQucGU
	 BH8er6IUThNsDZP1mRKfFMSJXAOm01HjfhaTxeiFSL0IYNfOtRxJdgQfjIfrku4UgnVGM
	 zep768uxOBmBQ6DRM0QWzqIKJ/kx9Bv8CSURRMEN7Pd41gRxh01y7E59kzG05BDR9GsBw
	 X/FtuHnKcSiU0NfymMjsTsEAUyUhYcb7l/z1MmV28nbyrsow6hsw67r7VByfp9aEErAot
	 udGYoilNffjyeCuGFcSY7wZfwUhRopFvJ8kK2GQNbaX8Z2794gS2MsrMdJ8Kws8QNyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfgVPEJY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E2B606A31C;
	Tue, 17 Nov 2026 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfgVPEJY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77E071F000C5;
	Tue, 17 Nov 2026 15:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794928486;
	bh=FlqNaTQ1KSYXtEicQmukvAIbCh1ZGMk91UvUei3msgo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XfgVPEJY04fEMFmXFk+QMQel56ssvYReJAs0ShT5v7Jq5IWhFLJKSKDQAxUn1CVIW
	 URxH4sY7Pq4RECmhKwXOlbUuulbUbLgeMl0PZOgonmVhpWSV8RZINs9PAo2mT51Zrz
	 pnz2yjlRUNHBaEYo4fK/oOowpw0+3ih/s2TJtlClTTGZpWD/9BWgyN+g6MSzuy+gvE
	 q8TfIeaicDFLB4GAN6KsX2YsvBym/BkzG96zsSrJVyYP3bvagoGh/YZbPwOBgysoaT
	 NFa2jZiZk06j/f+FLWEUzojSCsix/Fe3cJ5W/IPqW1HmLfzDmjXK8FiY05YjXPF5oF
	 GpnblAUE1uVPg==
Message-ID: <sashiko-outbox-219040@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 18/40] sched/deadline: Record the root domain holding
 a task's bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <81044090393551a0c264a8f3a7d1c3c22321c395.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <81044090393551a0c264a8f3a7d1c3c22321c395.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:14:46 +0000
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
- [Medium] sched/deadline: __sched_setscheduler() checks task_rq(p) root
  domain
--

commit 889f3e0f3403117f479bd558c00411593ac35a7e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Record the root domain holding a task's bandwidth

This commit replaces dl_departed_cpu with dl_bw_cpu in struct sched_dl_enti=
ty
to record a CPU of the root domain that accounts for a deadline task's
bandwidth across admissions, moves, rebuilds, and releases.

Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-1-dd761f=
e005b4@redhat.com/

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 8e8c62c574d55..01fbbd02cf8d0 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -4213,6 +4280,23 @@ int sched_dl_overflow(struct task_struct *p, int p=
olicy,
>  	if (new_bw =3D=3D p->dl.dl_bw && task_has_dl_policy(p))
>  		return 0;
> =20
> +	/*
> +	 * Change the bandwidth of a deadline task where it is counted: in
> +	 * the root domain of the CPU recorded with it. A task moved asleep
> +	 * has not run there yet, so the CPU it is on can be elsewhere. No
> +	 * bandwidth is counted if a rebuild dropped it, or if the task
> +	 * enters the class. A runtime below about a millionth of the period
> +	 * gives a bandwidth of 0. It counts for nothing, and no move updates
> +	 * its record. In these three cases, the root domain of the CPU the
> +	 * task is on takes the new bandwidth. The caller holds cpuset_mutex,
> +	 * or dl_accounting_mutex without cpusets, so no rebuild runs
> +	 * meanwhile.
> +	 */
> +	counted =3D task_has_dl_policy(p) && p->dl.dl_bw_cpu >=3D 0 &&
> +		  p->dl.dl_bw_gen =3D=3D dl_bw_gen;
> +	cpu =3D counted && p->dl.dl_bw ? p->dl.dl_bw_cpu : task_cpu(p);
> +	dl_b =3D dl_bw_of(cpu);
[ ... ]
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 4c013caa24713..306cd8d32173b 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -1185,6 +1185,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct s=
ched_attr __user *, uattr,
> =20
>  int dl_task_check_affinity(struct task_struct *p, const struct cpumask *=
mask)
>  {
> +	unsigned int cpu;
> +
>  	/*
>  	 * If the task isn't a deadline task or admission control is
>  	 * disabled then we don't care about affinity changes.
> @@ -1204,9 +1206,16 @@ int dl_task_check_affinity(struct task_struct *p, =
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
Should __sched_setscheduler() also use the root domain recorded in
p->dl.dl_bw_cpu rather than rq->rd when validating a deadline task's
root domain span and dl_bw.bw?

kernel/sched/syscalls.c:__sched_setscheduler() {
	...
		if (dl_bandwidth_enabled() && dl_policy(policy) &&
				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
			cpumask_t *span =3D rq->rd->span;

			if (!cpumask_subset(span, &p->cpus_mask) ||
			    rq->rd->dl_bw.bw =3D=3D 0) {
				retval =3D -EPERM;
				goto unlock;
			}
		}
	...
}

When a sleeping SCHED_DEADLINE task is moved to another exclusive cpuset
partition (or its CPU goes offline into the default root domain),
p->cpus_mask and p->dl.dl_bw_cpu reflect the root domain holding its
bandwidth, while rq (task_rq(p)) remains in the old root domain. Because
rq->rd->span is not a subset of p->cpus_mask, __sched_setscheduler()
rejects sched_setattr() parameter updates on that task with -EPERM before
reaching the moved-sleeper handling in sched_dl_overflow().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D18
