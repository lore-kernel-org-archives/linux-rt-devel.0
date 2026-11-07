Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018359;
	b=jaQ6ho9KXu2bYgLH3Vx5y/k6nqhRXvI8G1bkWbIHnaAR1heK2exa3nVIgfLbXiyRaxVx
	 9g8uqWO2+OmgBi7yA6NrIAWOVEvU0MoR8mcE8oQoctB3VVp5Dld9G/clTNDwQo3kJkYve
	 rKQ+pXR4FIqEneCoawFxs0E1OcLZghVbyG4YR3gyvAIsXKJO3a42gLe2y0BuQANYvHtqD
	 6wSswUWn2HKiqPq9s6p7DncC1qCm5yEYzvkVNt6M+7yRNntuUoU+5otAHCdQw4ibKO/SV
	 1yTCYLnOuSctkDqIJrEIkGb8mbfA3/qoPwzAmctOD+aYuQR5ieGJNLi0CUIoVFB/0eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018359;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fb9Y0AzB2OClsE5aYetS6PIswhFtifUFzTXe2GEMGsA=;
	b=vpXR5udrt6OfW5IKLRedSMeA9CnkK8PruUkzK9svKLgeZYH0iroD9z1tR8K2XaQsBJhB
	 GI7BK5OpEvKWI21hYtfGYxMABHJQ/p3rsu4yP74va26vVIRyPgQFwhmO7TF2L+MjLBPw/
	 6kMR2DaPvN6YRNc7T81uG3HxR0MY8q9GcI83CaHYgtarxqRlqdAveGRCwpHERLPfOfOQa
	 FJcY/wsZr7MPpY3j9Bxncjz1LT4dpviN5T4rMZgwhxXOV9a7Q3XfgOjtNw/o/9eHMF9uR
	 U9mGZhW9lAcSAi/y98b8WVjRvCgeYv+r+40h/DexWZXB/MxMYzZ6JgdGK2EaLsiMqeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4N00g+7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7814A606A32C;
	Sat,  7 Nov 2026 02:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4N00g+7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 077C21F0089F;
	Sat,  7 Nov 2026 02:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794018359;
	bh=fb9Y0AzB2OClsE5aYetS6PIswhFtifUFzTXe2GEMGsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y4N00g+7ceDd/jzrPDyqF1TDmhMKulmypDvjSV/ISCerHR8diIX3PHK3GlB07EdJz
	 SsP8ha4DWnMGecIS+Egi3th8+H+V2sAMHBohner1LveF7m0amgJLvmUITw8f17noCj
	 Y2jXsRsPEni/KkTXYYUa8D0+lrJ9l7CrP9DpalGPce9jfobNaXOHuW23ABiEMiUDUs
	 Tmk6c7TQFhCNKqrR63wmAKyBa/HnApSlFWTn3EzaiMGr2lE8bhVBDUNxUzi/v+Y8Yi
	 rBzgKOtoyLlcpJMQiSXGBO82QxrwZ7Z0aTz46Ick8F2d63wwVuQq90Udtcc4pqgMMe
	 KnaG5WZOJwL/w==
Message-ID: <sashiko-outbox-202508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 26/26] selftests/sched: Add a test of SCHED_DEADLINE
 bandwidth accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261107014451.1487825-27-mathieu.desnoyers@efficios.com>
References: <20261107014451.1487825-1-mathieu.desnoyers@efficios.com>
 <20261107014451.1487825-27-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 02:25:58 +0000
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
- [Low] selftests/sched: unchecked boosting_waiter() return and boost
  state
--

commit e5ace2481bd0093710ca8b43f5f8c80f64160b52
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Add a test of SCHED_DEADLINE bandwidth accounting

This commit adds deadline_bw_test to test SCHED_DEADLINE bandwidth
accounting across priority inheritance, parameter changes, cpuset moves,
task exits, sched_yield(), runtime overruns, bandwidth reclaiming, fair
server changes, and CPU hotplug.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> new file mode 100644
> index 0000000000000..8ede5d5a350e3
> --- /dev/null
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c

[ ... ]

> +/* A deadline task that blocks on the lock: it boosts its owner. */
> +static void *boosting_waiter(void *arg)
> +{
> +	return (void *)(long)wait_lock_for(300, 1);
> +}
> +
> +/*
> + * SCHED_FLAG_KEEP_PARAMS with SCHED_DEADLINE on an owner that priority
> + * inheritance has boosted into the class: the class of the request is t=
he
> + * one the owner already has, so a class change is not what it asks for,
> + * and the policy it asks for is one the kept parameters would not give
> + * it. It is refused with EINVAL; admitted, it reserves the bandwidth of
> + * the owner's slice and nothing ever releases it.
> + */
> +static int params_keep_boosted(void)
> +{
> +	struct dl_attr slice =3D {
> +		.size =3D sizeof(slice),
> +		.sched_policy =3D SCHED_OTHER,
> +		.sched_runtime =3D 40 * NSEC_PER_MSEC,	/* what the request would keep =
*/
> +	};
> +	struct dl_attr keep =3D {
> +		.size =3D sizeof(keep),
> +		.sched_policy =3D SCHED_DEADLINE,
> +		.sched_flags =3D SCHED_FLAG_KEEP_PARAMS,
> +		.sched_deadline =3D PERIOD,
> +		.sched_period =3D PERIOD,
> +	};
> +	int ret =3D KSFT_PASS, err;
> +	pthread_t o, w;
> +
> +	if (pi_init())
> +		return KSFT_SKIP;
> +	if (pthread_create(&o, NULL, sleeping_owner, (void *)0L)) {
> +		ksft_print_msg("the owner thread could not start\n");
> +		return KSFT_FAIL;
> +	}
> +	if (wait_for(5000, owner_holds) || owner_holds !=3D 2) {
> +		ksft_print_msg("the owner never took the lock\n");
> +		join(o);
> +		return KSFT_FAIL;
> +	}
> +	if (syscall(SYS_sched_setattr, owner_tid, &slice, 0)) {
> +		ksft_print_msg("the owner cannot take a slice of its own: %s\n",
> +			       strerror(errno));
> +		ret =3D KSFT_SKIP;
> +		goto out;
> +	}
> +	if (pthread_create(&w, NULL, boosting_waiter, NULL)) {
> +		ksft_print_msg("the waiter thread could not start\n");
> +		ret =3D KSFT_FAIL;
> +		goto out;
> +	}
> +	sleep_ns(50 * NSEC_PER_MSEC);		/* it blocks, the owner is boosted */
> +	err =3D syscall(SYS_sched_setattr, owner_tid, &keep, 0) ? -errno : 0;
> +	if (err !=3D -EINVAL) {
> +		ksft_print_msg("KEEP_PARAMS to SCHED_DEADLINE on a boosted owner: %s, =
not EINVAL\n",
> +			       err ? strerror(-err) : "accepted");
> +		ret =3D KSFT_FAIL;
> +	}
> +	join(w);
> +out:
> +	join(o);
> +	return ret;
> +}
> +
> +/* Boosted by a deadline waiter, the owner may still change its policy. =
*/
> +static int boosted_owner_policy(void)
> +{
> +	int ret =3D KSFT_PASS, err;
> +	pthread_t o, w;
> +
> +	if (pi_init())
> +		return KSFT_SKIP;
> +	if (pthread_create(&o, NULL, sleeping_owner, (void *)0L)) {
> +		ksft_print_msg("the owner thread could not start\n");
> +		return KSFT_FAIL;
> +	}
> +	if (wait_for(5000, owner_holds) || owner_holds !=3D 2) {
> +		ksft_print_msg("the owner never took the lock\n");
> +		join(o);
> +		return KSFT_FAIL;
> +	}
> +	if (pthread_create(&w, NULL, boosting_waiter, NULL)) {
> +		ksft_print_msg("the waiter thread could not start\n");
> +		join(o);
> +		return KSFT_FAIL;
> +	}
> +	sleep_ns(50 * NSEC_PER_MSEC);		/* it blocks, the owner is boosted */
> +	err =3D set_other(owner_tid);
> +	if (err) {
> +		ksft_print_msg("SCHED_OTHER on a boosted owner: %s\n", strerror(-err));
> +		ret =3D KSFT_FAIL;
> +	}
> +	join(w);
> +	join(o);
> +	return ret;
> +}

[Severity: Low]
Can params_keep_boosted() and boosted_owner_policy() report KSFT_PASS
even when owner_tid was never PI-boosted?

boosting_waiter() returns the status of wait_lock_for(), which is
non-zero if set_deadline() or pthread_mutex_timedlock() fails, but join()
calls pthread_join(t, NULL) and discards that return value.  Neither test
checks prio_of(owner_tid) =3D=3D DL_TASK_PRIO before calling sched_setattr()
either, so if wait_lock_for() fails or w is delayed past the 50ms sleep,
both tests exercise an unboosted SCHED_OTHER owner and still pass.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107014451.1487=
825-1-mathieu.desnoyers@efficios.com?part=3D26
