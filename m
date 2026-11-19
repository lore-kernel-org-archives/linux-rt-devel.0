Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121520;
	b=QUTIFLnicnuNg0uMoPOJFQOjWbD9FAWQOv7RayNNncBwN2mwDly2UBojHKnOON1+c5YA
	 NqPZpMnzxO8ro9jpRT4qxgztZpi9GwF6ibivbg2hbU0FbbteU3BJfYINQRXhzBwZNMR2M
	 LzDhwKcSGGHompxR8Ond4Ws628DBy4wDj34NCS3RihtqDEYplX0S38QsTMUvefZqhNRet
	 esuU2JXFg8H7sJF2EubbeLBtz5R1EbAFRDK6k6k+7p3Lpa/HqNYZiZh174VB8XOyolCzh
	 skLPrpui5YZB0IUdvj8GKfa9cLHmh4dRDoeAcWor5GjfOEmSHnXvFFagHvyKPTwxi5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121520;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HUPumk9i57DkSOuQPvVMnytpwx19+jA5RUkY1AF2mFs=;
	b=guffvltnV3LpOzgOCT2jfAltYBq2JzjPlmsOwvpYQ6J8hhHFoXMZDmI0MqR/JgBrqeW5
	 usTTRVMKRkYECYgNjYIbongYOiik1wM1HwZXt14SakuoXFdJDUwVPGs6ak8X+NboGL+xM
	 s35ihI6yn0oVNz2NMpdJCzjQPDKFJvWEGw+BX7MeYOZO5R320J+cb0KR/5kXQmOAAlS29
	 7unYFsMtlih3lNVsk8CWG/y9YwJmU9F8QWVofv5N6RM3v2bvim1CtHLbpTPGqmvPqrSc2
	 XZVnZWa4EiLDwQYZ6pbMBEu8oET+p7KBNUwXRVJJlprPlGClBbnaiqfprkx8CClZ1Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OdRHcvao;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2AD606A902;
	Thu, 19 Nov 2026 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OdRHcvao
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23C11F000C0;
	Thu, 19 Nov 2026 20:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121520;
	bh=HUPumk9i57DkSOuQPvVMnytpwx19+jA5RUkY1AF2mFs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OdRHcvao74GmConYaEBc4jCOEGcYaYlY7FAUeAWeXO/yT8+oJJtEx4q72WMd931VI
	 dOL/ohn9pztfZ2CutaoDtryLquBPQUlFFCgASSwD2RjWlT+Wh/2COAxhnkYLh5sKvD
	 S+0m0gPgtlOi7lWbPvgr06OUxiB7VydlJA9rQbVGhMz1uVsAkkET1GsA+f0uwzc5//
	 Cl22o8JysQ7CFT4U4lW3FX6s3DWs/O9vST5v4Hvj08yJKF+SgWj7cWWKTLRHo2j6ye
	 jGG0Q2dnNCfGptM49F+la+vW5Gvl20xZbQ4RRvhHmFMhbU86eMD8HgIB2PrDnh2XpE
	 SStMrNaIW8SBg==
Message-ID: <sashiko-outbox-224056@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/33] sched/deadline: Record the root domain holding
 a task's bandwidth
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <b652188b8e94eaa45102ac88f15d841e9a5ef141.1795116790.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <b652188b8e94eaa45102ac88f15d841e9a5ef141.1795116790.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:51:59 +0000
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
- [Medium] sched/deadline: __sched_setscheduler() checks task_rq(p)->rd
  instead of dl_bw_cpu
--

commit 6c6c4ca320b457b4335ef207d939dd20b5bb6c38
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched/deadline: Record the root domain holding a task's bandwidth

This commit records a CPU from the root domain accounting a deadline
task's bandwidth in dl_bw_cpu and uses it across bandwidth moves,
releases, parameter updates, and affinity checks.

Link: https://lore.kernel.org/all/20261103-b4-sched-dl-bw-fixes-v1-1-dd761f=
e005b4@redhat.com/

> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 585070a9d3171..5a8f38632e545 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
[ ... ]
> @@ -4203,6 +4270,23 @@ int sched_dl_overflow(struct task_struct *p, int p=
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

[Severity: Medium]
Should the root domain check in __sched_setscheduler() also use the
recorded dl_bw_cpu instead of rq->rd?

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

When a sleeping SCHED_DEADLINE task is moved to another cpuset partition,
p->cpus_mask is updated to the new root domain while task_rq(p) remains in
the old root domain until wakeup.  Because the old rq->rd->span is not a
subset of p->cpus_mask, __sched_setscheduler() rejects sched_setattr()
parameter changes with -EPERM before reaching sched_dl_overflow().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795116790.gi=
t.mathieu.desnoyers@efficios.com?part=3D3
