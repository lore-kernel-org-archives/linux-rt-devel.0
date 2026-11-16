Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794857467;
	b=eD/4OlNhaHCBEgBnSN/UDKXcbPE7m1k8sQrm6RgQdnBdaACGUdtYSYmQo4blizdp7Iv8
	 C/QG6V1n6NmNL80BYVimRhoYJnaem9hRUBzyhlAJVPBQ9BTiW90XN2bTX5ArTsNNcVMM7
	 psAJUOiR8YVp4zQpqeb+6Wqmxgv+iV/o2RtpYYzruRW7bFpaV6tb1O4FmzWwWxkCkeeYH
	 rrIV7UoDmOLfA0/I/T7ZMtLxRx7jde01AqNDHYAX9cYvlsSIvsbUMeX44fSO3ZGsKfOQU
	 CabO3vZdQUJ3+X1QjRKMV3J5J737DuaDafnOYLQ8MY5hVy8K8M0y2tTxSYGAAHZM09A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794857467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ixv40pUJ5hyTAry5bSwRv503Fc0hNYjPvW+LeFM9yPM=;
	b=AHGsBBkkP2Jr+ysq6EzkkpzHThw538ZJxjO2xciIy7a/gE2RYCzjL5R2U+f4We9jxKns
	 qnKm1OuGygvTIC5gyKKQea5mDg8SvIrUV9JcQYRYeNeQXBFBYHZkKC8OS/3hc325DvuWE
	 1+N2fvCDU3J9RaUB6wzqgSJPJVzi/hjh965TFPxTp6QZEJmkycb0cjDf4tVxeU9yrJ4jg
	 0EIJlWmQ7fzB9ONT9dmekvojlbWSdxTDN4bVDfHekg14ZQ1L4bGcc3jHuW52TWHa+J/hd
	 hDQ61fjVbSceN049BVlbdz+G9ddKeWFZ4ESl2AhbKuEMt4HQGRkv7xc6gUjgSeyHFlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcSQWVLg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C8606A31C;
	Mon, 16 Nov 2026 19:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hcSQWVLg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046E41F000C4;
	Mon, 16 Nov 2026 19:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794857467;
	bh=ixv40pUJ5hyTAry5bSwRv503Fc0hNYjPvW+LeFM9yPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hcSQWVLgDuKYy8lFekchnAxAEDaIwGiZMFOPSCc9fa+nR7NhTopjPj3lRZTKKoWl3
	 jzwXj9/yvB+ok2SbjbQxlZ/kCVE0mshHxDWCP6mtaHv+dOgT35JBrzspmpqphFrKYw
	 ltsNN0qDEJT9w1tdNYmomWVjTS855w0uqM5QGCD4dsRzbwTMAfVimWKSNR/g9QLEgH
	 OJVCDi3D20HilL4GKEx/Ulalp5VqeNVzYQRfXd7BKQzQ42oS453uFvVXpUABHOJn7C
	 fzcvAAX9vNQ6zsGaFCbUu5kYtt93O5xChcttr4YPucT9mc9B2SWcXDtKqyTSCfUYhp
	 pqrvK6MDmVZoA==
Message-ID: <sashiko-outbox-217566@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 21/37] sched: Make deadline policy and affinity
 changes wait for a cpuset attach
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261116190549.230119-22-mathieu.desnoyers@efficios.com>
References: <20261116190549.230119-1-mathieu.desnoyers@efficios.com>
 <20261116190549.230119-22-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 19:31:06 +0000
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
- [Medium] sched: broken cpuset rollback in __sched_setaffinity() with
  SCA_DL_NOWAIT
--

commit 9d195b268d19186fd430b17e56b76c3ac49f0d39
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

sched: Make deadline policy and affinity changes wait for a cpuset attach

This commit introduces cpuset_lock_no_attach() and SCA_DL_NOWAIT so that
SCHED_DEADLINE policy changes in __sched_setscheduler() and affinity
changes in sched_setaffinity() wait for an in-progress cpuset attach to
finish.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2a964286a7cd0..52c291de384e7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3195,6 +3195,16 @@ static int __set_cpus_allowed_ptr_locked(struct ta=
sk_struct *p,
>  		goto out;
>  	}
> =20
> +	/*
> +	 * sched_setaffinity() tested the policy with no lock, and did not
> +	 * wait for a cpuset attach in progress. @p became a deadline task
> +	 * since: let the caller wait and try again.
> +	 */
> +	if ((ctx->flags & SCA_DL_NOWAIT) && task_has_dl_policy(p)) {
> +		ret =3D -EAGAIN;
> +		goto out;
> +	}
> +
>  	/*
>  	 * Check under the same lock that __sched_setscheduler() holds for
>  	 * its admission test, so that p cannot become SCHED_DEADLINE
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 4f47b17151ed9..70b364b4f82dd 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c

[ ... ]

> @@ -1318,13 +1324,31 @@ long sched_setaffinity(pid_t pid, const struct cp=
umask *in_mask)
>  		return -ENOMEM;
>  	}
> =20
> -	ac =3D (struct affinity_context){
> -		.new_mask  =3D in_mask,
> -		.user_mask =3D user_mask,
> -		.flags     =3D SCA_USER,
> -	};
> -
> -	retval =3D __sched_setaffinity(p, &ac);
> +	/*
> +	 * Wait for a cpuset attach in progress before changing the affinity
> +	 * of a deadline task. cpuset_can_attach() reserved the bandwidth of
> +	 * the task for the CPUs it moves to, and cpuset_attach() moves it
> +	 * there. A new affinity in between could change those CPUs.
> +	 *
> +	 * The policy is tested here with no lock. A task that becomes a
> +	 * deadline task after this test is found under its runqueue lock,
> +	 * with SCA_DL_NOWAIT. Wait and try again then.
> +	 */
> +	for (;;) {
> +		dl =3D task_has_dl_policy(p);
> +		ac =3D (struct affinity_context){
> +			.new_mask  =3D in_mask,
> +			.user_mask =3D user_mask,
> +			.flags     =3D SCA_USER | (dl ? 0 : SCA_DL_NOWAIT),
> +		};
> +		if (dl)
> +			cpuset_lock_no_attach();
> +		retval =3D __sched_setaffinity(p, &ac);
> +		if (dl)
> +			cpuset_unlock();
> +		if (dl || retval !=3D -EAGAIN)
> +			break;
> +	}
>  	kfree(ac.user_mask);
> =20
>  	return retval;

[Severity: Medium]
Can SCA_DL_NOWAIT cause the cpuset race rollback in __sched_setaffinity()
to fail and leave p->cpus_mask and p->user_cpus_ptr un-restored?

When p is initially not a deadline task, sched_setaffinity() passes
SCA_DL_NOWAIT without holding cpuset_mutex.  If the first
__set_cpus_allowed_ptr() succeeds while a concurrent cpuset update narrows
cpus_allowed and another thread changes p to SCHED_DEADLINE, the recovery
path in __sched_setaffinity() clears SCA_DL_CHECK but leaves SCA_DL_NOWAIT
set:

kernel/sched/syscalls.c:__sched_setaffinity() {
    ...
	cpuset_cpus_allowed(p, cpus_allowed);
	if (!cpumask_subset(new_mask, cpus_allowed)) {
    ...
		ctx->flags &=3D ~SCA_DL_CHECK;
		__set_cpus_allowed_ptr(p, ctx);
		retval =3D -EINVAL;
	}
    ...
}

CPU0                                  CPU1
sched_setaffinity(p)
  dl =3D false (SCA_DL_NOWAIT set)
  __sched_setaffinity(p, &ac)
    cpuset_cpus_allowed(p, ...)
    __set_cpus_allowed_ptr(p, ctx)
      sets p->cpus_mask =3D new_mask
      swaps p->user_cpus_ptr
        with ctx->user_mask
                                      cpuset narrows p's cpus_allowed
                                      sched_setattr(p, SCHED_DEADLINE)
    cpuset_cpus_allowed(p, ...)
    !cpumask_subset(new_mask, ...)
    ctx->flags &=3D ~SCA_DL_CHECK
    __set_cpus_allowed_ptr(p, ctx)
      SCA_DL_NOWAIT && dl_policy
      returns -EAGAIN (ignored)  <-- rollback skipped
    returns -EINVAL
  kfree(ac.user_mask)

Because the second __set_cpus_allowed_ptr() aborts with -EAGAIN and its
return value is ignored, p->cpus_mask is left containing CPUs outside the
task's cpuset cpus_allowed, and the rejected user_mask remains installed
in p->user_cpus_ptr while the previous user_cpus_ptr is freed.

Clearing SCA_DL_NOWAIT alongside SCA_DL_CHECK before the recovery
__set_cpus_allowed_ptr() call would allow the rollback to complete.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116190549.2301=
19-1-mathieu.desnoyers@efficios.com?part=3D21
