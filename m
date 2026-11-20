Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795184807;
	b=2k1r+QTHgVZTLwC4LUTf3B+lnXXopL37MUMHbEgQRCaODPABRRv1BxIeMsaD3EL8u1cX
	 sPtgY4KJGbbjThD1wzqXH89s+ddxEo7Yfs6AHfTkjXaeM0YfozstsakprLWFGEMBEw5GO
	 tzI/FvAS3DOOdmH7xwCbnHM0DFVRdRNQg9JItBup+FwvbcgKufzEHSKA287bZG3QqOYjs
	 wGYWZfVMbY3yXCVBf5+U7uQ8vjMGQcilhPN0HxxgNmVmuEc/QwhX/Boyphs3mFaym4hyz
	 IpiqC26HrgSjOMq34MeUcObRPYjfgDCm/csAugH3GolZ35fPINfC4PScl/ITNfc38HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795184807;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=o8CqTgpj9o9s3c/cKwJbW2YWJcNUBL3TSARpKe1Chpw=;
	b=vtdXOpC9DZKpyB606Jwn82PMgB54KYmX40RICvFuY2cik1u0ZoPZ8LCFu10iLpQRLl9x
	 EpbuEYkEdeqwS8rVZpTnOKp0mnwCUHJi5C36j+DjzEfU2OPWFknnDYJ/A7nIpavTvLHyg
	 8WEiwnDnRYk6Zpw86PuYOTya7YvUsXGwNrWCTlkmd8fLmjf6b8GTYa6AEgtG86mxnTm0/
	 sS3HOi/QJwWtkLe+8N8pAZWidWhOmZxjXn1iXGDSw7gGFH0r3YJFJBKJYx066siu3RTdN
	 cgHKkL0DG9Pjkg9TJl9Z3RF+xeusHwAZPPZJzl/jKqbEyjoQYZz7qzvhoIMuxaOhi/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b47T/9yh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC7606A320;
	Fri, 20 Nov 2026 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b47T/9yh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726021F000CA;
	Fri, 20 Nov 2026 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795184806;
	bh=o8CqTgpj9o9s3c/cKwJbW2YWJcNUBL3TSARpKe1Chpw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b47T/9yhSiUSmpHCDDHeR3yylQtwckSAnevdqECo5CNn7VAQHrGAT2ras1G3IautA
	 iYbX3HnLigD+3WbKaMlFieYcySe2//snCjyC2R8YGtFan3S5JzwojUYnPr6YBqwjAM
	 BRtO49Y6O46ifRiAdogpj4CJg1523DvmyxDIhxfi6xjdjsWvZSIRkdPcsCD1MglQ9K
	 PzSgdr0NozphsryDmltLqhLr16zyhkyj7Ua0L4coA8cZPq4ZbNyy1vZQwOXJ1Bvvkg
	 3PT/GAGW+SizexevyzqjqS3wWwgh+V6NyrG8WZu36bGC0v9G0ueOrDmiUBkbFgSJ06
	 dz7bGGs6yslrQ==
Message-ID: <sashiko-outbox-225360@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 28/33] selftests/sched: Test deadline boosts in
 deadline_bw_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <3c1582ebc8887e6cb2183b47ee746c93878ce8cc.1795181240.git.mathieu.desnoyers@efficios.com>
References: <cover.1795181240.git.mathieu.desnoyers@efficios.com>
 <3c1582ebc8887e6cb2183b47ee746c93878ce8cc.1795181240.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 14:26:46 +0000
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
- [Low] selftests/sched: asleep_donor() 1s period in
  deboost_out_asleep_after_refill() outlasts 300ms probe wait
--

commit d2e9c0f7968d87de2ffed7f0becb6e1c373c9c07
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Test deadline boosts in deadline_bw_test

This commit adds eight test cases to deadline_bw_test covering SCHED_DEADLI=
NE
priority inheritance boost and deboost scenarios, runtime refills from a
donor, and waiter ordering on PI locks.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> index 25fbbc3e88d00..5ea9bfe0aee2c 100644
> --- a/tools/testing/selftests/sched/deadline/deadline_bw_test.c
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c

[ ... ]

> @@ -1938,6 +2065,326 @@ static int deboost_keeps_own_runtime(void)
>  	return ret;
>  }
> =20
> +/* Run refill_case() with an owner that is refilled from its donor. */

[ ... ]

> +static void *asleep_donor(void *arg)
> +{
> +	struct timespec ts;
> +	int err;
> +
> +	aslp_donor_tid =3D gettid_();
> +	err =3D set_deadline(0, NSEC_PER_MSEC, NSEC_PER_SEC);
> +	sem_post(&aslp_donor_ready);
> +	if (err) {
> +		ksft_print_msg("the donor refused as a deadline task: %s\n", strerror(=
-err));
> +		return (void *)1;
> +	}
> +	if (sem_wait_for(&aslp_owner_locked, 5000)) {
> +		ksft_print_msg("the owner did not take the lock\n");
> +		return (void *)1;
> +	}
> +	clock_gettime(CLOCK_REALTIME, &ts);
> +	ts.tv_nsec +=3D 200 * 1000000L;
> +	ts.tv_sec +=3D ts.tv_nsec / 1000000000L;
> +	ts.tv_nsec %=3D 1000000000L;
> +	aslp_donor_locking =3D 1;
> +	err =3D pthread_mutex_timedlock(&pi_lock, &ts);
> +	aslp_total_bw =3D total_bw_of(top_cpu(1));

[Severity: Low]
Can asleep_donor()'s 1s period outlast the 300ms wait in measured(), causing
probe() to fail with a false bandwidth leak?

asleep_donor() runs with a 1ms runtime and 1s period (a 1000:1 ratio).
Its initial 0-lag time passes during the 200ms timedlock sleep, so waking
on timeout replenishes a new 1s period.  It then calls total_bw_of(), which
reads /sys/kernel/debug/sched/debug while still in SCHED_DEADLINE.  Each
microsecond of CPU time spent there pushes its 0-lag time forward by 999us,
so spending more than ~300us leaves its bandwidth active past the 3 * PERIOD
(300ms) sleep in measured(), and probe(cg_p) admits 8 tasks instead of 9.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795181240.gi=
t.mathieu.desnoyers@efficios.com?part=3D28
