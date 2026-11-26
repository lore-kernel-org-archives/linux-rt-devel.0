Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658498;
	b=qTNAPMgXO1T67jt9Z0UyGkVzOET3z8si02TBK9KFOH1qcvcqXdCD3DjEZvPK7SUGbWec
	 gZfiAe5mbWYNDBssaaAImjX8CShKaYc0X9/bDllsgbnqkyG6suIq4r113j6inuMguXQQV
	 al2cg4TBBhc2OCzdJUBG0ASl1rL6UuPgbU4BTqGHiivsrk0fWAdtkNWBmihDiHVmq4TxQ
	 eypaBM+mEmodfvYN+FVgDga794OQFluGb9B7SVXFeS9/l1aIyxT5+7H46fgjiLhtdD7BO
	 uHDZDfQE+KAsNiNVB7Bsm8uo6rYcoBRshHoDiLSbFW5NoQy+8mzxnJxo/a1KcKW3Gww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658498;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DrlN2HxJ+I3bISLWgA04HPxA74Q0FNUZW42EnCO49bA=;
	b=Gdjm7QMJaVFVqGZSn7oeQcb2znipLwD0GplAZXKfwuXMJsfigapiWcLQDEHtZYmi8HFf
	 53TRdPugRmt+Ud4ZwT/di1Qqm6oqN/M2Ogh61aepched/d6QtBEIje8OtHw2hQZklndxU
	 afXCUQn5aZNut3W6csn8S8NlNKfOinKwixYR+Yqpn1pjSgK18SePLrwkPjmJM0uKtFqEt
	 LK62YJ27Kza22n98aKBbxUNbSz9A8q9rGHucQbzP5jCAkJQ3kh4uPCPhZAV+SEQxp9Iz1
	 XGRO/vgrglaS0vnRfxtd1+fa5PbmKRVNe9XvcEXczRolCaa2K9IVcb39ffnoSine6bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JgKKEDcM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ECC606A31E;
	Thu, 26 Nov 2026 02:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JgKKEDcM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7791F000C6;
	Thu, 26 Nov 2026 02:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658497;
	bh=DrlN2HxJ+I3bISLWgA04HPxA74Q0FNUZW42EnCO49bA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JgKKEDcM5llFA0UgWcCYkTzcYXT7w48t/+2q5gFc1uqJF7/lwmEqHv39pE2ec5Nrn
	 Gzdik3ribBf7BviaPa53Jrowe/l0s++OSTTNP2oCVhh/1utKxW25g9T11l5h5f/mXY
	 1pW/6qJnz8DbDpYK6IVe3AYR7ao0T6h2UvG87tYz0zbkxLeBxaBS6DZAcdoZGVfM0h
	 mvmh5ZS2UrvvjABSIhJMGWTPxhAgOT4V6p0KM9416+rLnfLf60/VrxS7+A7XR74ReQ
	 +06UsdMx01/k0XkLXuLm2KPCyQGZhqMzlPmiInGf4l2byDDXIZ6rq5+Umyb7/cNnLg
	 /R0W18/11nUOg==
Message-ID: <sashiko-outbox-234599@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 42/43] selftests/sched: Test parameter changes in
 deadline_bw_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <f4340ebcf4ff6e789ad8c5272eb798b3180265d4.1795646915.git.mathieu.desnoyers@efficios.com>
References: <cover.1795646914.git.mathieu.desnoyers@efficios.com>
 <f4340ebcf4ff6e789ad8c5272eb798b3180265d4.1795646915.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 02:01:36 +0000
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
- [Medium] selftests/sched: premature bandwidth probe after
  reenter_runnable_in_gap()
- [Medium] selftests/sched: missing rival readiness wait in
  owner_boost_case()
--

commit 1245641ca231366ed56f97e5e4afa480f85900ad
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Test parameter changes in deadline_bw_test

This commit adds 39 test cases to deadline_bw_test covering SCHED_DEADLINE
parameter changes, priority inheritance boosting, and tasks re-entering the
deadline class during a constrained gap, and waits for total_bw to drain
between partition test cases.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> index 83dd8b4e79a3d..78b58888e9d54 100644
> --- a/tools/testing/selftests/sched/deadline/deadline_bw_test.c
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c

[ ... ]

> @@ -2749,93 +2923,3168 @@ static int requeue_pi_new_period(void)

[ ... ]

> +static void *rr_t(void *arg)
> +{
> +	int err;
> +
> +	rr_t_tid =3D gettid_();
> +	err =3D set_constrained(0, 10 * NSEC_PER_MSEC, 20 * NSEC_PER_MSEC, 5 * =
PERIOD);
> +	rr_t_start =3D now_ns();
> +	if (err) {
> +		ksft_print_msg("T refused as a deadline task: %s\n", strerror(-err));
> +		rr_t_ready =3D -1;
> +		return (void *)1;
> +	}
> +	rr_t_ready =3D 1;
> +	while (!rr_stop) {
> +		uint64_t t =3D now_ns(), b =3D rr_back_at;
> +
> +		if (b && !rr_t_ran && t > b + 2 * NSEC_PER_MSEC)
> +			rr_t_ran =3D t;
> +	}
> +	return NULL;
> +}
> +
> +/*
> + * The same as reenter_asleep_in_gap(), for a task that stays runnable. P
> + * has one CPU:
> + * 1. T becomes a deadline task of 10ms in 20ms, every 500ms, at 0ms, and
> + *    spins. It is throttled at 10ms, until its next period at 500ms.
> + * 2. At 40ms, the main thread switches T to SCHED_OTHER, then back to
> + *    SCHED_DEADLINE with the same parameters.
> + *
> + * Leaving the class and coming back must not give T a new period before
> + * 500ms. With a new period, T would run at once. The case fails if T ru=
ns
> + * from 2ms to 50ms after rr_back_at.
> + */
> +static int reenter_runnable_in_gap(void)
> +{
> +	int ret =3D KSFT_FAIL, err;
> +	void *t_ret =3D NULL;
> +	pthread_t t;
> +
> +	rr_t_ready =3D 0;
> +	rr_stop =3D 0;
> +	rr_t_tid =3D 0;
> +	rr_t_start =3D 0;
> +	rr_back_at =3D 0;
> +	rr_t_ran =3D 0;
> +	if (pthread_create(&t, NULL, rr_t, NULL)) {
> +		ksft_print_msg("the T thread could not start\n");
> +		return KSFT_FAIL;
> +	}
> +	if (wait_for(1000, rr_t_ready) || rr_t_ready < 0) {
> +		ksft_print_msg("T never started\n");
> +		goto out;
> +	}
> +	while (now_ns() - rr_t_start < 40 * NSEC_PER_MSEC)
> +		sleep_ns(NSEC_PER_MSEC);
> +	err =3D set_other(rr_t_tid);
> +	if (err) {
> +		ksft_print_msg("T cannot leave SCHED_DEADLINE: %s\n", strerror(-err));
> +		goto out;
> +	}
> +	/* Store it before the switch back. A T given a new period runs at once=
. */
> +	rr_back_at =3D now_ns();
> +	err =3D set_constrained(rr_t_tid, 10 * NSEC_PER_MSEC, 20 * NSEC_PER_MSE=
C, 5 * PERIOD);
> +	if (err) {
> +		ksft_print_msg("T refused back as a deadline task: %s\n", strerror(-er=
r));
> +		goto out;
> +	}
> +	sleep_ns(50 * NSEC_PER_MSEC);
> +	ret =3D KSFT_PASS;
> +out:
> +	set_other(rr_t_tid);
> +	rr_stop =3D 1;
> +	if (pthread_join(t, &t_ret) || t_ret)
> +		ret =3D KSFT_FAIL;

[Severity: Medium]
Can measured() probe cg_p before rr_t's 0-lag time at 500ms and report a
false bandwidth leak?

Unlike reenter_pi_blocked_in_gap() and reenter_asleep_case(), which wait
for T to run at 500ms before returning, reenter_runnable_in_gap() switches
rr_t to SCHED_OTHER and returns at about 90ms while rr_t's 2% bandwidth is
still held by its inactive timer until 500ms.  Because the case is
registered as MEASURED_IN_P, measured() only waits 3 * PERIOD (300ms,
reaching about 390ms) before running probe(cg_p):

tools/testing/selftests/sched/deadline/deadline_bw_test.c:measured() {
    ...
	ret =3D run_in(cg, fn);
	sleep_ns(3 * PERIOD);
	after =3D probe(cg);
    ...
}

If probe(cg_p) spawns its nine 10% tasks before 500ms, the ninth task fails
admission with -EBUSY (5% fair server + 2% rr_t + 90% > 95%) and fails the
test.

[ ... ]

> +/*
> + * Run as the rival C of pi_owner_throttled_rival(). Become a deadline
> + * task of 40ms in 60ms, every 100ms. Wait until W is about to block,
> + * then sleep until 13ms after O's start, and spin 40ms of CPU time.
> + * Return NULL, or 1 on an error.
> + */
> +static void *ob_rival(void *arg)
> +{
> +	struct timespec ts;
> +	uint64_t end;
> +	int err;
> +
> +	err =3D set_constrained(0, 40 * NSEC_PER_MSEC, 60 * NSEC_PER_MSEC, PERI=
OD);
> +	if (err) {
> +		ksft_print_msg("the rival refused as a deadline task: %s\n",
> +			       strerror(-err));
> +		return (void *)1;
> +	}
> +	sem_wait_sig(&ob_rival_go);
> +	end =3D ob_t0 + 13 * NSEC_PER_MSEC;
> +	ts.tv_sec =3D end / NSEC_PER_SEC;
> +	ts.tv_nsec =3D end % NSEC_PER_SEC;
> +	while (clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &ts, NULL) =3D=
=3D EINTR)
> +		;
> +	spin_ns(40 * NSEC_PER_MSEC);
> +	if (set_other(0))
> +		ksft_print_msg("the rival cannot leave SCHED_DEADLINE\n");
> +	return NULL;
> +}
> +
> +/*
> + * Run an owner_boost case of @kind: ob_owner() and ob_waiter(), and
> + * ob_rival() with OB_RIVAL. W must get pi_lock within @limit_ms of O's
> + * start.
> + */
> +static int owner_boost_case(int kind, int limit_ms)
> +{
> +	void *o_ret =3D NULL, *w_ret =3D NULL, *c_ret =3D NULL;
> +	int throttled =3D kind !=3D OB_GAP && kind !=3D OB_LATE_GAP;
> +	int ret =3D KSFT_FAIL;
> +	pthread_t o, w, c;

[ ... ]

> +	if (kind =3D=3D OB_GAP)
> +		sleep_ns(30 * NSEC_PER_MSEC);	/* O sleeps past its deadline */
> +	if (kind =3D=3D OB_RIVAL && pthread_create(&c, NULL, ob_rival, NULL)) {
> +		ksft_print_msg("the rival thread could not start\n");
> +		kind =3D OB_THROTTLED;
> +		c_ret =3D (void *)1;
> +	}
> +	sem_post(&ob_go);

[Severity: Medium]
Can ob_waiter preempt ob_rival before ob_rival enters SCHED_DEADLINE?

On P's single CPU, owner_boost_case() creates ob_rival and immediately
posts ob_go to wake ob_waiter without waiting for ob_rival to finish
set_constrained():

  main thread (CPU of P)        ob_waiter             ob_rival
  ----------------------        ---------             --------
  pthread_create(..., ob_rival)
  sem_post(&ob_go)
                                wakes as SCHED_OTHER
                                set_deadline(2ms, 10ms)
                                sem_post(&ob_rival_go)
                                take_pi_lock()
                                  boosts ob_owner
                                  ob_owner spins 5ms
                                  unlocks at 15ms
                                                      first scheduled
                                                      set_constrained(...)

When ob_waiter runs before the newly created ob_rival thread, ob_waiter
and the boosted ob_owner keep the single CPU in SCHED_DEADLINE until the
lock hand-off is already over at 15ms, so pi_owner_throttled_rival()
passes without ob_rival competing at 13ms.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795646914.gi=
t.mathieu.desnoyers@efficios.com?part=3D42
