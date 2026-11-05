Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793913429;
	b=Ox9Y2ZxD8Kt2je4gc3bnzFzyy3Oamg3kdxkpwVfTvTCUvIWJKKIsLOGehdSYsJRPCaHx
	 jvSuV+qh8fpZgQJEb4IoBxVLN3vqDmHSLosWbXWQcH72mrMuaBxNmCwJ1lnhtZ5F2fyik
	 bDtvPdR1Xfx3MBQ6P6fOWj1zI1gWtwFC+PKrnWqtUIFJeldrjRp2Ud5PdYeb4B6e1hxf4
	 R3VgJ5ElP9QM3FDab3XoJQz/Wq6I6APd7tvfZE8IuyDF5HU9ts+YdDwB9yzatXZ/ba+mU
	 FQNLF0tg3hHS+qw3LCdZndXFHFxtIYsTHxQ2q8OvPJryRa/rAsToc+vKs9GpD158EZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913429;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/+biNtr+xln0rFjEaWe5bkdhb05tAUnaC2xdWexJ9ZI=;
	b=cN4kM72wtDcuFxuh5WbdLeuq6QW22D+knv7ccSfsClcDo55d7SEhWWtORQe5dMIS25np
	 7E0S5pDBPvjskMXgQtxYZgxyU9t3bYgBv0OnqsSr9GA8CszSEYxyg82HjCSnK9S+Pj51y
	 vcO9NAatOGqxLmfaOjVS+UzLGOnWrFmbo6hrDh+nuJUUJiM64qxdu+LaazcOLc+K8XlCy
	 ETHG3Ndd6fGV766/bZTarYP95Bn4PofMGEprE361mjVL8uNzSI8brUGAJsAoqJvb4QQms
	 DS+M5rZD5jMj4ViOLkH/iyPWficOEfUAJWYKbkASx/ef2j7i0uhzlsJqdfRF6szk1Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUeM7u7I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2175B606A326;
	Thu,  5 Nov 2026 21:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUeM7u7I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DA61F0089F;
	Thu,  5 Nov 2026 21:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793913428;
	bh=/+biNtr+xln0rFjEaWe5bkdhb05tAUnaC2xdWexJ9ZI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oUeM7u7IEwa6XiisLVS9iWGEq6gv6cbP9Se+MPbABFNJoYRI4lTmGLySyAJn8aVw9
	 +WwfjLlIXkqquzvMg3HDSPz0UpcqRmlOP7aT+fejqYDNvFV3l7nScvT60AYoFNfhxX
	 bDdOGRtK+GuMhpC4jtHl0AKqNhrQBZ6OC1fojxfdmP+gSO+UcMEGty5VMl4Bfazfm5
	 /m8itDcT23PyKQ6QZ6qwhS+hxA9lJxf8px/Nfq/ISln9Y7U35g6z9s+xqtPYHF8YUk
	 OzywxZGvLSCSq7BKotboRYYaOty//x9nBejtM9b+ssjUS00X46VKB0Scl4JQ+PFC/d
	 sIf8iY7wpkjjA==
Message-ID: <sashiko-outbox-200212@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 24/24] selftests/sched: Add a test of SCHED_DEADLINE
 bandwidth accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <20261105193359.1450487-25-mathieu.desnoyers@efficios.com>
References: <20261105193359.1450487-1-mathieu.desnoyers@efficios.com>
 <20261105193359.1450487-25-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 21:17:08 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/sched: death_group() kills two throttled threads and n=
one running
- [Medium] selftests/sched: moves() wakes on exact period boundary in move_=
throttled()
--

commit eb8b43e433ced961bc0d97ddf7bd888cfef3b0b9
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Add a test of SCHED_DEADLINE bandwidth accounting

This commit adds deadline_bw_test, a selftest suite with 46 test cases
covering SCHED_DEADLINE bandwidth accounting across priority inheritance,
parameter changes, cpuset moves, task deaths, sched_yield(), runtime
overruns, bandwidth reclaiming, fair server changes, a randomized mix of
transitions, and CPU hotplug.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> new file mode 100644
> index 0000000000000..898809c2185a8
> --- /dev/null
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c

[ ... ]

> +static int moves(enum mv_mode mode, const char *name)
> +{
> +	int base_p, base_r, after_p, after_r, ret =3D KSFT_PASS;
> +	pid_t pid;
> +
> +	base_p =3D probe(cg_p);
> +	base_r =3D probe(root);
> +	mv_state[0] =3D 0;
> +	mv_state[1] =3D 0;
> +	pid =3D mover(mode, 30 * NSEC_PER_MSEC);
> +	if (pid < 0 || child_up(name, mode =3D=3D MV_NON_CONTENDING)) {
> +		reap(pid);
> +		return KSFT_FAIL;
> +	}
> +	if (mode =3D=3D MV_NON_CONTENDING)
> +		sleep_ns(NSEC_PER_MSEC);
> +	else
> +		sleep_ns(2 * PERIOD);
> +	if (enter(cg_p, pid) || enter(root, pid)) {

[Severity: Medium]
In move_throttled() -> moves(), does sleeping for 2 * PERIOD (200ms) end up
moving the task while it is running rather than throttled?

In mover() for MV_THROTTLED, the task sets a runtime of 30ms per 100ms
period (PERIOD), sets *mv_state =3D 1 immediately, and spins. child_up()
polls mv_state[0] every 1ms and returns roughly 1ms into the task's first
100ms period.

When moves() then sleeps for 2 * PERIOD (200ms), that sleep is an exact
multiple of the 100ms period. The task exhausts its 30ms runtime at ~30ms,
is replenished at 100ms, exhausts its runtime at ~130ms, and is replenished
again at 200ms for the 200ms..230ms window. When sleep_ns(2 * PERIOD)
returns at ~201ms, enter(cg_p, pid) moves the task right after
replenishment while it is actively running instead of throttled.

Should moves() wait for the spinner to be throttled (for example using
wait_spinner(0) like death_killed_throttled() does) before calling enter()?

[ ... ]

> +/* Deadline threads of one process, asleep, throttled and running, kille=
d at once. */
> +static void *group_thread(void *arg)
> +{
> +	long kind =3D (long)arg;
> +
> +	if (set_deadline(0, 10 * NSEC_PER_MSEC, PERIOD)) {
> +		mv_state[0] =3D -1000;
> +		return NULL;
> +	}
> +	spin_ns(NSEC_PER_MSEC);
> +	mv_state[0]++;
> +	if (!kind)
> +		for (;;)
> +			pause();
> +	for (;;)
> +		;
> +	return NULL;
> +}
> +
> +static int death_group(void)
> +{
> +	pid_t pid;
> +
> +	mv_state[0] =3D 0;
> +	pid =3D fork_child("a group of deadline threads");
> +	if (pid < 0)
> +		return KSFT_FAIL;
> +	if (!pid) {
> +		pthread_t t;
> +		long i;
> +
> +		for (i =3D 0; i < 3; i++)
> +			if (pthread_create(&t, NULL, group_thread, (void *)i))
> +				mv_state[0] =3D -1000;
> +		for (;;)
> +			pause();
> +	}
> +	if (wait_for(5000, mv_state[0] < 0 || mv_state[0] =3D=3D 3))
> +		ksft_print_msg("only %d threads of the group started\n", (int)mv_state=
[0]);
> +	sleep_ns(PERIOD / 2);
> +	reap(pid);

[Severity: Medium]
The comment above group_thread() says this tests killing a group of
deadline threads that are asleep, throttled, and running at once, but can
any thread in the group actually be running when reap(pid) sends SIGKILL?

Each group_thread() sets a runtime of 10ms per 100ms period (PERIOD) on
cg_p's single CPU. Thread 0 spins 1ms and pauses, while threads 1 and 2
spin endlessly. Once mv_state[0] reaches 3, death_group() sleeps for
PERIOD / 2 (50ms). On cg_p's single CPU, threads 1 and 2 each consume
their remaining 9ms of runtime (18ms total) and are both throttled well
before the 50ms sleep finishes.

In addition, because death_group() stays inside cg_p as a SCHED_OTHER task
(unlike kill_case(), which moves the killer to root), it cannot run on
cg_p's single CPU to call reap(pid) while any deadline thread in cg_p is
actively running. As a result, reap(pid) always kills one sleeping thread
and two throttled threads, leaving the running thread case untested.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105193359.1450=
487-1-mathieu.desnoyers@efficios.com?part=3D24
