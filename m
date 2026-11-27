Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805860;
	b=sU/XZPNmm5j44Gkp0IIXJbmNc8yognjUhi1exvIm7XMvrEJpI/mljDfYbh6rzCZRx66k
	 ey0rN6g1LEGupBACQybTsdWuq6XRLzHYxQ/eHgYeVgaRcq9GQI2f/eX/pTJRlLrQj1UED
	 alMYDse2SfvRzGu2FCLu7DX3erGvslE0g6e4TPLT4MM4Z5Dz5YrHmdqmcIh26K9U5HWR3
	 WCQCN8gKhP2pfI4VD+2hdP2ijyh4FsYPfN1I8gvYdjClwas+FR4hFqoWoc9IxZxwHWf0l
	 g5iERNF5bFeavN0Ygs5qgZSegI6OGvx+OaUxlHz6SxVRrIcZigbvcbvIp5xHh+YRdFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805860;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2EK0BwQeYmRHkxY7jQ1ZvtT4e0u5KpogzcETkrrqPuE=;
	b=An9dRvaI+fcN+z/xG6kRp3uXs3NLPNatpGD7uxBA8dgW1wZJ3qIw8C/lX4F6+ahkg4/9
	 uwkoDhI3jCaNDYYzfG5y2SG8+Z+QzUUron9V9eNMQ3Lz7tPXPYMISv5hOvtt5akPnYnHH
	 Ykauxqjgbg1v8XCHRy6WP/S92VdOVPX3Dch29o2/bIz2lJzWASPa65OS0B0orHTR7906G
	 Oo9FTxgXXLX3ux77wVLCTs8aYWdt1FvlHuH0Rlghrj4S+D5Mnl92YYVLE+K7OgqahBkQw
	 EiV9iNaZXpakNBoXc9UH6ZwRR/Rw9zwcUU33gD5tCwLLIUtYbU25sB5Lb9nxrR1lr6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1cmAt+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1D4606A31C;
	Fri, 27 Nov 2026 18:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1cmAt+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3668E1F000C1;
	Fri, 27 Nov 2026 18:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795805859;
	bh=2EK0BwQeYmRHkxY7jQ1ZvtT4e0u5KpogzcETkrrqPuE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K1cmAt+PJq4+FLAShBcEAalSS1j9BO4gibH3w5+g4IhHFlWNArqMjJrjkqCxkDwuR
	 6CBBI4LSpvXOzHfd6fNh3cA7tRA8SI6+8R12jWv6GagOneBK7qFTJI7TiteebiqmjY
	 3X24jQLpxDahndn8u5XQRmAmwQqUqVQ3JarXGdEkn2AqWwtjo+VN6Khwy2h0bTKBG8
	 K9EodWV4foB9b/oYyRr3vs6kPymNN5X5IWtWIWH2QbZjqFXHRfWh1vI5Dpu9zp9sU6
	 RQSwoOH7ACp7ngMoRe2M1S31yq6gNFlNZU2IDVR19GJETIcI1hVhFYb/Lev4vgMhZo
	 IBn1ynSfRRyfw==
Message-ID: <sashiko-outbox-238121@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 42/43] selftests/sched: Test parameter changes in
 deadline_bw_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <e42c6ca948ebfe1bccef4d533e4d1d33fb4ce7f5.1795771148.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <e42c6ca948ebfe1bccef4d533e4d1d33fb4ce7f5.1795771148.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 18:57:38 +0000
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
- [Medium] selftests/sched: premature probe in measured() after
  constrained task exit
--

commit 55867328ab1ab4f59bba08a621ac5a4d89b5c264
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Test parameter changes in deadline_bw_test

This commit adds 39 test cases to deadline_bw_test covering parameter
changes, priority inheritance boosts of throttled or constrained owners,
and constrained tasks re-entering SCHED_DEADLINE during their gap.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> index 83dd8b4e79a3d..66955952901ff 100644
> --- a/tools/testing/selftests/sched/deadline/deadline_bw_test.c
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c

[ ... ]

> @@ -2749,93 +2923,3194 @@ static int requeue_pi_new_period(void)
>  	return ret;
>  }
> =20

[ ... ]

> +static void *rb2_t(void *arg)
> +{
> +	uint32_t tid =3D gettid_();
> +	int err;
> +
> +	rb2_t_tid =3D tid;
> +	err =3D set_constrained(0, 10 * NSEC_PER_MSEC, 20 * NSEC_PER_MSEC, 5 * =
PERIOD);
> +	rb2_t_start =3D now_ns();
> +	if (err) {
> +		ksft_print_msg("T refused as a deadline task: %s\n", strerror(-err));
> +		rb2_t_locking =3D -1;
> +		return (void *)1;
> +	}
> +	spin_ns(2 * NSEC_PER_MSEC);
> +	rb2_t_locking =3D 1;
> +	if (syscall(SYS_futex, &rb2_pi, FUTEX_LOCK_PI | FUTEX_PRIVATE_FLAG,
> +		    0, NULL, NULL, 0)) {
> +		ksft_print_msg("FUTEX_LOCK_PI: %s\n", strerror(errno));
> +		set_other(0);
> +		return (void *)1;
> +	}
> +	rb2_t_got =3D now_ns();
> +	if (!atomic_compare_exchange_strong(&rb2_pi, &tid, 0))
> +		syscall(SYS_futex, &rb2_pi, FUTEX_UNLOCK_PI | FUTEX_PRIVATE_FLAG,
> +			0, NULL, NULL, 0);
> +	if (set_other(0))
> +		ksft_print_msg("T cannot leave SCHED_DEADLINE\n");
> +	return NULL;
> +}

[Severity: Medium]
Does calling set_other(0) at the start of T's second 500ms constrained
period cause measured() to probe before T's bandwidth is released?

T is throttled in its constrained gap until t =3D 500ms, when dl_task_timer=
()
replenishes it for [500ms, 1000ms].  When T immediately calls set_other(0)
while still alive, task_non_contending() keeps the departing constrained
task's 2% bandwidth until the end of that period at t =3D 1000ms, and
do_exit() does not cancel inactive_timer after T has left SCHED_DEADLINE.

Because reenter_pi_blocked_in_gap() returns right after pthread_join() at
t =3D 500ms and measured() only waits 3 * PERIOD (300ms):

tools/testing/selftests/sched/deadline/deadline_bw_test.c:measured() {
	...
	ret =3D run_in(cg, fn);
	sleep_ns(3 * PERIOD);
	after =3D probe(cg);
	...
}

probe(cg) runs at t =3D 800ms while T's 2% bandwidth is still counted in
total_bw, admitting 8 probe tasks of 10% instead of 9 and failing the test.
The same happens in ra_t() (for reenter_asleep_in_gap() and
reenter_asleep_late_in_gap()) and in ob_owner() (for
pi_owner_asleep_in_gap() and pi_owner_wakes_in_gap_later(), where
drop_pi_lock() deboosts and throttles O in its gap until t =3D 500ms before
set_other(0)).  Waiting for the next period before returning (as
reenter_runnable_in_gap() does) or letting the thread exit without calling
set_other(0) first would avoid the premature probe.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D42
