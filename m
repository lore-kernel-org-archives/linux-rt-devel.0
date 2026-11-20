Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208941;
	b=jW4omJJYlBrniB09CAo05m2B8ZLYgxIi0g1vXuiu4X314M0UK9kH5R8XI2WeBmtoVXqZ
	 U35e6lZi8EEAmn0eNzpObkL2X8vTNTd4JE8kXopOIITEQEISm0nUcEZSWaMtEQN1a6dwv
	 l0VIkRNoAeroKYQd/tkzXObh1NZ0/+eVRuKPpsB2ai0IvGVHWty57JiVl7s7prXjZMyWf
	 7ztfG2oBEekDilJ81UBA8h9EsD/nJiwRedYDOBzHMah1NUsXt0qtcTS7fjdeMl3G90Swc
	 vAu6hfYwZ/TjvCVw5kDbJzhN1Kkab8eUQLOlr57Nd7ULBXz0WWURRg1qmDCuDLz/Maw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208941;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O25rA5UXimFfXClKEaHhOmZj2ob0lGVZAnMWeUUZSV4=;
	b=SReMFRAPZh1U29sOW90T+qnAZ3bzKRF+cS2cdO8TCKwCOX7xZaqEo5DAVoF6RlYrmoul
	 4O7SqWcHDZYB+NX1Og8ShAW5+PgK201d5lKCRTkPb5QcZqVDY2kESWFTmGavGIJ9tqVHY
	 K9TRf1x9q3FvGjQ9eS00eyAb8mGSYqHT+rtAfs9/1MnQ9pMCVeBiuYSN/fenPFf2yV5cb
	 a7ShvPlJlydu85gNBYtgV0UHCSoqGMXWWF/RdDEhEXplFGj6lGKSsI7UsfLPtqiLnyPTo
	 R3W2+HQpB8Xd+SdL+ojIzYAsGcvgTa//Y3jmGX/elbxNW+J+cEZqLU5eGxE2zX4d2xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfWcJZoT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B045606A6A6;
	Fri, 20 Nov 2026 21:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DfWcJZoT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2181F000C0;
	Fri, 20 Nov 2026 21:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795208940;
	bh=O25rA5UXimFfXClKEaHhOmZj2ob0lGVZAnMWeUUZSV4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DfWcJZoTe599OI8V0tdnZRTJncePuuvnW+ENcdF7SopQ6zD3JHGnurpx5vXa3WNhu
	 7EEzur2VWhlWXvS2tjiV+wVnkKtCB67o0R2TFSvQn2Y4SWckwD+Afhas+RRVYe3tDv
	 P1oVX6W/eHVGvx93uERyz/6P3bG+oTD/htUDEqcF6G8JqJ/A9kIxMxshXINlg0mUry
	 iUB3fFBimu/iLlpfokIZz9lVGCx2PvqNXQ5ayxSjXpTJTo++MZBcYYVLJTl1h3TDGX
	 oOsrR4zejzZIbt1rrfAuL4KpyBB8ZW7lJDtPCSAa2vTj+iFjmqtnIc5qyJ/jfFDYQE
	 OcY5kGQpzPgng==
Message-ID: <sashiko-outbox-226131@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 31/40] selftests/sched: Test deadline boosts in
 deadline_bw_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <e0d14db39ed097c54761a08cb3a1c3e5a57f81ea.1795207233.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <e0d14db39ed097c54761a08cb3a1c3e5a57f81ea.1795207233.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:08:59 +0000
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
- [Low] selftests/sched: hang in requeue_pi_new_period() error path on
  FUTEX_WAKE
- [Low] selftests/sched: deadlock in deboost_out_asleep_after_refill()
  error path
--

commit 27cfa3f823b3f1e4dfbcad5af492394f2bdb22ea
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Test deadline boosts in deadline_bw_test

This commit adds ten test cases to deadline_bw_test covering SCHED_DEADLINE
priority inheritance boosts, deboosts, runtime refills, and lock waiter
ordering.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> index cf3b49cf2be28..7925623ed1da7 100644
> --- a/tools/testing/selftests/sched/deadline/deadline_bw_test.c
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c

[ ... ]

> @@ -1939,6 +2066,664 @@ static int deboost_keeps_own_runtime(void)

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
> +		sem_post(&aslp_donor_out);
> +		return (void *)1;
> +	}
> +	if (sem_wait_for(&aslp_owner_locked, 5000)) {
> +		ksft_print_msg("the owner did not take the lock\n");
> +		sem_post(&aslp_donor_out);
> +		return (void *)1;
> +	}
> +	clock_gettime(CLOCK_REALTIME, &ts);
> +	ts.tv_nsec +=3D 200 * 1000000L;
> +	ts.tv_sec +=3D ts.tv_nsec / 1000000000L;
> +	ts.tv_nsec %=3D 1000000000L;
> +	aslp_donor_locking =3D 1;
> +	err =3D pthread_mutex_timedlock(&pi_lock, &ts);
> +	sem_post(&aslp_donor_out);
> +	sem_wait_sig(&aslp_read_done);

[ ... ]

> +static int deboost_out_asleep_after_refill(void)
> +{

[ ... ]

> +	if (pthread_create(&d, NULL, asleep_donor, NULL)) {
> +		ksft_print_msg("the donor thread could not start\n");
> +		return KSFT_FAIL;
> +	}
> +	if (sem_wait_for(&aslp_donor_ready, 5000)) {
> +		ksft_print_msg("the donor is not ready\n");
> +		sem_post(&aslp_owner_locked);
> +		join(d);
> +		return KSFT_FAIL;
> +	}
> +	base =3D total_bw_of(top_cpu(1));	/* with D, without O */
> +	if (pthread_create(&o, NULL, asleep_owner, NULL)) {
> +		ksft_print_msg("the owner thread could not start\n");
> +		sem_post(&aslp_owner_locked);
> +		join(d);
> +		return KSFT_FAIL;
> +	}

[Severity: Low]
Will join(d) hang on these two error paths if aslp_read_done is not
posted?  Posting aslp_owner_locked wakes asleep_donor(), which then takes
pi_lock and blocks in sem_wait_sig(&aslp_read_done).

[ ... ]

> +static void *rq_w(void *arg)
> +{
> +	long ret;
> +
> +	rq_w_tid =3D gettid_();
> +	ret =3D syscall(SYS_futex, &rq_cond, FUTEX_WAIT_REQUEUE_PI | FUTEX_PRIV=
ATE_FLAG,
> +		      0, NULL, &rq_pi, 0);
> +	if (ret) {
> +		ksft_print_msg("FUTEX_WAIT_REQUEUE_PI: %s\n", strerror(errno));
> +		return (void *)1;
> +	}
> +	rq_w_rank =3D rq_order++;
> +	rq_pi_unlock();
> +	if (set_other(0))
> +		ksft_print_msg("W cannot leave SCHED_DEADLINE\n");
> +	return NULL;
> +}

[ ... ]

> +static int requeue_pi_new_period(void)
> +{

[ ... ]

> +out:
> +	rq_pi_unlock();
> +	if (ret !=3D KSFT_PASS) {
> +		/* Let W go if it was not requeued. */
> +		rq_cond =3D 1;
> +		syscall(SYS_futex, &rq_cond, FUTEX_WAKE | FUTEX_PRIVATE_FLAG,
> +			1, NULL, NULL, 0);
> +	}
> +	if (have_x && pthread_join(x, &x_ret))
> +		ret =3D KSFT_FAIL;
> +	if (pthread_join(w, &w_ret))
> +		ret =3D KSFT_FAIL;

[Severity: Low]
Does FUTEX_WAKE wake W when it is sleeping in FUTEX_WAIT_REQUEUE_PI on
rq_cond?  In the kernel, futex_wake() rejects waiters that have
rt_waiter set with -EINVAL without waking them:

kernel/futex/waitwake.c:futex_wake() {
    ...
		if (this->pi_state || this->rt_waiter) {
			ret =3D -EINVAL;
			break;
		}
    ...
}

If an earlier setup step such as set_deadline() fails before W is
requeued, W stays asleep on rq_cond and pthread_join(w, &w_ret) hangs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D31
