Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807561;
	b=HKadBX/ClrmxFJ2P/eAcyPCS9E2YZ+Dy4Y5La7y4/GMaRWYIx7/ck1Qz3e5nwUV0WcK5
	 3zz42BBUThdh4I2C5PA9J41PvBk2kubrbNPj6LtkDqsJ9Q6srGJjLBO72YaU5ghp6hX9S
	 qu7Y3QXTgmkWdj6KerPp9n26E+nEunGbbNDbsCQsNMQ6VAvjnwMaENGRjOqNx+Zz4nEM2
	 2E+7Oss6DzS6ZkuulcZH/4dLJuImvbyObSedCUxMvEAjQRvIfpT0vNKL34orEbjGS0Npn
	 v04S1TeuGZPAlKdKEAH7vv6LbboXqKIeL0+MJn2iUThvRV8jqMuYdDMyxy8mFAA2Vng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807561;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=95XPUtnv/nhj2ccphEgTpHACpjAxCOWBTu5I2zY7qoY=;
	b=HkVjtWFhyL62FudfFvynaKgoyHB5vlsvJ/T2pHXXqGEoxNXsgbahXUDr7DhLwocV/ifc
	 z+YPicizhWtqf/yCfR3M5s0lH4icsCi0ZkMWHxD1F1yaer1Q7bRL3JX+FwXmwUWP/+uwg
	 eSG/Ug0teGWw+yDCI6LiHOX3Hbfq4lP6EGJ2hW+4Sljn9K9o19yZlM+/eIWOqbSuSjPn+
	 rzooWDkaNRVtbfkv6WuRzHWt6DD6ZnO0/QKg4rn3PwwSUZwaiypdQ4THss6juoU7aDTw1
	 /5BXyQemIF8meZSVd63fvXaR0CT1xfg+oS974dXEDtWEpGsgl2mdb7V0Gf64SppgLLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sx5L1fJe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B70606A328;
	Wed,  4 Nov 2026 15:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sx5L1fJe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990001F000C1;
	Wed,  4 Nov 2026 15:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793807560;
	bh=95XPUtnv/nhj2ccphEgTpHACpjAxCOWBTu5I2zY7qoY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sx5L1fJevbZF3nGZueEsaAJhts5kgENy/CjgYbca6c0l6kHJ6i7y2x/YXakmSWl13
	 HVBp1rNdJLfZZEi74WZKh6PEeswPWtc23coHfHOcuBEs1Se101gH8UfW34cJIdzgMg
	 h7C9V9LqHmiws4dCnDcNj0+B32/NRDQ6e5VObgKnQ9zM8xHbdLDnBJSXapKNILjfLX
	 Z9LwypIrFc6+cR4gj23rionb7iqytdrofVii/yZqtluXswINIeAlamv0jRbBnyufWc
	 CI6mI4rP9okcN9OkxjaLuItB9xEIs3VOJVVBbuj5kjTJEQnWYZ/UqhRe9dbV7nlfgR
	 2Rd1fWsQk2lGg==
Message-ID: <sashiko-outbox-197548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] selftests/sched: Add a test of SCHED_DEADLINE
 bandwidth accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <bd80a4a54b998762a8aa192b76fd3efcf7b01172.1793804635.git.mathieu.desnoyers@efficios.com>
References: <cover.1793804635.git.mathieu.desnoyers@efficios.com>
 <bd80a4a54b998762a8aa192b76fd3efcf7b01172.1793804635.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 15:52:40 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Medium] selftests/sched: deadline_bw_test exceeds default 45s kselftest =
timeout
- [Medium] selftests/sched: hardcoded 64 KiB thread stack in probe() and ho=
ld()
- [Medium] selftests/sched: mix_worker() reuses r % 8 making r % 4 and r % =
2 always 0
- [Medium] selftests/sched: overrun_group_death() triggers SIGXCPU before s=
ibling setup
- [Medium] selftests/sched: cpu_up() in hotplug_departed() masks bandwidth =
corruption
- [Medium] selftests/sched: missing shm_lock_init() call in random_mix()
- [Medium] selftests/sched: return -1 from probe() when pthread_create() fa=
ils
- [Low] selftests/sched: silent KSFT_SKIP returns without reason strings
--

commit e47dbb10f477e11f4985642a757e69830e31cc5f
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Add a test of SCHED_DEADLINE bandwidth accounting

This commit adds the deadline_bw_test selftest with 43 test cases exercising
SCHED_DEADLINE bandwidth accounting across priority inheritance, parameter
changes, cpuset moves, task deaths, sched_yield(), runtime overruns, GRUB
bandwidth reclaiming, fair server changes, a randomized mix, and CPU hotplu=
g.

> diff --git a/tools/testing/selftests/sched/Makefile b/tools/testing/selft=
ests/sched/Makefile
> index 728e046b463c9..a32a0f7aa76b8 100644
> --- a/tools/testing/selftests/sched/Makefile
> +++ b/tools/testing/selftests/sched/Makefile
> @@ -10,6 +10,6 @@ LDLIBS +=3D -lpthread
> =20
>  TEST_GEN_FILES :=3D cs_prctl_test
>  TEST_PROGS :=3D cs_prctl_test
> -TEST_GEN_PROGS :=3D deadline_switch_test deadline_rebuild_test
> +TEST_GEN_PROGS :=3D deadline_switch_test deadline_rebuild_test deadline_=
bw_test

[Severity: Medium]
When deadline_bw_test is added to TEST_GEN_PROGS in
tools/testing/selftests/sched/Makefile without a companion
tools/testing/selftests/sched/settings file, the kselftest runner applies t=
he
default 45-second timeout (kselftest_default_timeout=3D45 in
tools/testing/selftests/kselftest/runner.sh).

In main() -> run_p_cases(), the 43 sequential test cases perform unconditio=
nal
sleeps totaling over 74 seconds when all features are enabled (including 25
MEASURED_IN_P cases sleeping at least 900ms each across two probe() calls a=
nd
measured(), server_states() sleeping 9.9s, params_waking() sleeping 5.3s, a=
nd
random_mix() sleeping 5.3s), and over 51 seconds even when the debugfs and
hotplug cases are skipped.

Because deadline_bw_test does not handle SIGTERM, when runner.sh kills the
test after 45 seconds it exits without running remove_p(),
remove_partition(cg_q), server_restore(), or restoring cgroup.subtree_contr=
ol,
leaving active cpuset partitions and modified fair_server parameters on the
system.

Should tools/testing/selftests/sched/settings be added with a higher timeout
(and a signal handler installed to clean up cgroups and fair_server state on
termination)?

> diff --git a/tools/testing/selftests/sched/deadline_bw_test.c b/tools/tes=
ting/selftests/sched/deadline_bw_test.c
> new file mode 100644
> index 0000000000000..d16aee10155b3
> --- /dev/null
> +++ b/tools/testing/selftests/sched/deadline_bw_test.c
[ ... ]
> +static int probe(const char *cg)
> +{
> +	int fd[2], n =3D -1, max =3D 16 * ncpus + 16;
> +	pid_t pid;
> +
> +	if (pipe(fd)) {
> +		ksft_print_msg("pipe: %s\n", strerror(errno));
> +		return -1;
> +	}
> +	pid =3D fork_child("the admission check");
> +	if (!pid) {
> +		struct probe_slot *s =3D calloc(max, sizeof(*s));
> +		pthread_attr_t a;
> +		int i, k =3D 0;
> +
> +		close(fd[0]);
> +		if (!s || sem_init(&probe_done, 0, 0) || pipe(probe_hold) ||
> +		    (cg && enter(cg, getpid())))
> +			_exit(1);
> +		if (pthread_attr_init(&a) || pthread_attr_setstacksize(&a, 64 * 1024))
> +			_exit(1);

[Severity: Medium]
On architectures where PTHREAD_STACK_MIN is larger than 64 KiB (for example,
ppc64le where PTHREAD_STACK_MIN is 128 KiB, or kernels configured with 64 K=
iB
pages), will pthread_attr_setstacksize(&a, 64 * 1024) fail with EINVAL in b=
oth
probe() and hold()?

In probe(), that causes the child to exit with 1 and probe() to return -1,
which causes measured() to skip all 25 MEASURED_IN_P cases and fails the
remaining cases that call probe() directly.

In hold(), the same call also logs strerror(errno) even though
pthread_attr_init() and pthread_attr_setstacksize() return the error number
directly rather than setting errno:

	if (pthread_attr_init(&a) || pthread_attr_setstacksize(&a, 64 * 1024)) {
		ksft_print_msg("pthread_attr: %s\n", strerror(errno));
		return -1;
	}

Should the stack size in probe() and hold() be clamped to at least
PTHREAD_STACK_MIN, and hold() pass the returned error code to strerror()?

> +		for (i =3D 0; i < max; i++) {
> +			if (pthread_create(&s[i].t, &a, probe_thread, &s[i]))
> +				break;

[Severity: Medium]
If pthread_create() fails partway through the admission loop in probe() (for
example with EAGAIN due to RLIMIT_NPROC, cgroup pids.max, or memory pressure
when probing across many CPUs), breaking out of the loop leaves k at the
number of threads created so far rather than setting k =3D -1.

Won't probe() then write that partial count k to the pipe and return it as a
valid admission count, causing callers like measured(), admits_in(), and
moves() to misreport a bandwidth leak or double-release?

[ ... ]
> +/* The deadline threads of overrun_group_death(). */
> +static void *og_thread(void *arg)
> +{
> +	switch ((int)(long)arg) {
> +	case 0:		/* overruns its runtime: SIGXCPU to the group */
> +		if (set_deadline_flags(0, 10 * NSEC_PER_MSEC, PERIOD,
> +				       SCHED_FLAG_DL_OVERRUN))
> +			_exit(1);
> +		spin_ns(30 * NSEC_PER_MSEC);
> +		break;
> +	case 1:		/* asleep, its 0-lag time past */
> +		if (set_deadline(0, 20 * NSEC_PER_MSEC, PERIOD))
> +			_exit(1);
> +		spin_ns(NSEC_PER_MSEC);
> +		break;
> +	case 2:		/* asleep, mostly before its 0-lag time */
> +		if (set_deadline(0, 15 * NSEC_PER_MSEC, PERIOD))
> +			_exit(1);
> +		for (;;) {
> +			spin_ns(3 * NSEC_PER_MSEC);
> +			sleep_ns(22 * NSEC_PER_MSEC);
> +		}
> +	}
> +	for (;;)
> +		pause();
> +}
> +
> +/*
> + * The SIGXCPU of an overrun kills the whole thread group: the bandwidth
> + * of its three deadline threads comes back.
> + */
> +static int overrun_group_death(void)
> +{
> +	pid_t pid =3D fork_child("a group of deadline threads");
> +	int i, status;
> +
> +	if (!pid) {
> +		pthread_t t;
> +
> +		for (i =3D 0; i < 3; i++)
> +			if (pthread_create(&t, NULL, og_thread, (void *)(long)i))
> +				_exit(1);
> +		for (;;)
> +			pause();
> +	}

[Severity: Medium]
overrun_group_death() runs inside cg_p, which is a single-CPU cpuset partit=
ion
root, and creates thread 0 first without waiting for threads 1 and 2 to rea=
ch
their sleeping states.

In og_thread(), thread 0 immediately enters SCHED_DEADLINE with a 10ms runt=
ime
and 100ms period and calls spin_ns(30 * NSEC_PER_MSEC) on P's single CPU. E=
ven
if threads 1 and 2 also enter SCHED_DEADLINE before thread 0 starts spinnin=
g,
all three share the same 100ms relative deadline so thread 0 has the earlie=
st
deadline and monopolizes the single CPU until it overruns at 10ms and deliv=
ers
SIGXCPU to the thread group.

Doesn't this kill the process before threads 1 and 2 can spin and go to sle=
ep
in their intended states?

[ ... ]
> +static pid_t mix_worker(int idx, unsigned int seed)
> +{
> +	static const uint64_t runtime[] =3D { 5, 10, 20, 30 };
> +	static const uint64_t period[] =3D { 50, 100 };
> +	static const uint64_t flag[] =3D { 0, SCHED_FLAG_RECLAIM, SCHED_FLAG_DL=
_OVERRUN };
> +	pid_t pid =3D fork_child("a worker of the mix");
> +
> +	if (!pid) {
> +		struct sigaction sa =3D { .sa_handler =3D catch_xcpu };
> +		int err;
> +
> +		if (sigaction(SIGXCPU, &sa, NULL))
> +			_exit(1);
> +		seed +=3D idx;
> +		/*
> +		 * A refusal is part of the mix: each call below is made in
> +		 * whatever state the worker is in, and an error is what the
> +		 * kernel is entitled to answer.
> +		 */
> +		while (!mix_state[0]) {
> +			unsigned int r =3D rand_r(&seed);
> +
> +			switch (r % 8) {
> +			case 0:
> +				set_deadline_flags(0, runtime[r % 4] * NSEC_PER_MSEC,
> +						   period[r % 2] * NSEC_PER_MSEC,
> +						   flag[r % 3]);
> +				break;

[Severity: Medium]
In mix_worker(), case 0 of switch (r % 8) is only entered when r is a multi=
ple
of 8. Because runtime[r % 4] and period[r % 2] use r directly without divid=
ing
by 8, aren't r % 4 and r % 2 always 0 here, causing mix_worker() to only ev=
er
select runtime[0] (5ms) and period[0] (50ms)?

[ ... ]
> +			case 5:
> +				err =3D pthread_mutex_trylock(shm_lock);
> +				if (err =3D=3D EOWNERDEAD)	/* its owner died holding it */
> +					err =3D pthread_mutex_consistent(shm_lock);
> +				if (!err) {
> +					spin_ns(NSEC_PER_MSEC);
> +					if (pthread_mutex_unlock(shm_lock))
> +						_exit(1);
> +				}
> +				break;
[ ... ]
> +static int random_mix(void)
> +{
[ ... ]
> +	mix_state =3D mv_state + 16;
> +	for (i =3D 0; i <=3D MIX_WORKERS; i++)
> +		mix_state[i] =3D 0;
> +	for (i =3D 0; i < MIX_WORKERS; i++) {
> +		pid[i] =3D mix_worker(i, seed);
> +		if (pid[i] < 0) {
> +			ret =3D KSFT_FAIL;
> +			goto out;
> +		}
> +	}

[Severity: Medium]
In random_mix(), the mix_worker() child processes lock and unlock shm_lock
across processes while random_mix() periodically kills workers with SIGKILL,
but random_mix() never calls shm_lock_init().

In main(), shm_lock is only pointed at zero-initialized MAP_SHARED memory:

	shm_lock =3D (pthread_mutex_t *)((char *)mv_state + 256);

shm_lock_init() (which configures PTHREAD_PROCESS_SHARED,
PTHREAD_PRIO_INHERIT, and PTHREAD_MUTEX_ROBUST) is only called inside
pi_death() for the earlier death_pi_* cases. If the death_pi_* cases were
skipped in measured(), or if shm_lock_init() failed there, shm_lock remains=
 a
zero-initialized process-private non-robust mutex when random_mix() runs; a=
nd
if an earlier death_pi_* case failed before its waiter recovered and unlock=
ed
shm_lock, shm_lock enters random_mix() in an inconsistent or unrecoverable
state.

Should random_mix() call shm_lock_init() (or skip case 5 in mix_worker() wh=
en
shm_lock_init() fails)?

[ ... ]
> +static int hotplug_departed(void)
> +{
> +	int base =3D probe(NULL), after, cpu, ret =3D KSFT_PASS;
> +	pid_t pid;
> +
> +	mv_state[0] =3D 0;
> +	mv_state[1] =3D 0;
> +	pid =3D mover(MV_THROTTLED, 40 * NSEC_PER_MSEC);
> +	if (pid < 0 || child_up("a departing deadline task", 0)) {
> +		reap(pid);
> +		return KSFT_FAIL;
> +	}
> +	sleep_ns(PERIOD / 2);
> +	/* Running and queued: its bandwidth stays until its 0-lag time. */
> +	if (set_other(pid))
> +		ret =3D KSFT_FAIL;
> +	cpu =3D task_cpu_of(pid);
> +	if (cpu <=3D 0) {
> +		cpu_set_t set;
> +
> +		/* Out of the class now: it may be moved to the CPU we offline. */
> +		cpu =3D hp_cpu;
> +		CPU_ZERO(&set);
> +		CPU_SET(cpu, &set);
> +		if (sched_setaffinity(pid, sizeof(set), &set))
> +			ret =3D KSFT_FAIL;
> +	}
> +	if (ret =3D=3D KSFT_PASS && cpu_online(cpu, 0)) {
> +		ksft_print_msg("offline of CPU %d refused\n", cpu);
> +		ret =3D KSFT_FAIL;
> +	}
> +	sleep_ns(2 * PERIOD);
> +	cpu_up(cpu);
> +	reap(pid);
> +	sleep_ns(3 * PERIOD);
> +	after =3D probe(NULL);

[Severity: Medium]
In hotplug_departed(), after offlining cpu and sleeping 2 * PERIOD (so
inactive_task_timer() has already fired and cleared the departed task's
deadline parameters), the test calls cpu_up(cpu) before calling
after =3D probe(NULL).

Doesn't bringing cpu back online trigger dl_rebuild_rd_accounting() ->
dl_clear_root_domains(), resetting the root domain's total_bw to 0 and
recomputing it from scratch before probe(NULL) measures it, which masks any
total_bw leak or underflow that occurred when the inactive timer fired while
cpu was offline?

Also, since pid runs in the root cgroup with all online CPUs in its affinity
mask when set_other(pid) is called, switched_from_dl() ->
dl_task_root_domain_cpu() picks the first CPU in pid's cpus_mask (CPU 0) as
dl_departed_cpu rather than the CPU offlined here. Should probe(NULL) be
checked while cpu is still offline (or should pid's affinity be restricted =
to
include cpu and exclude CPU 0 before entering SCHED_DEADLINE)?

[ ... ]
> +static void report(const char *name, int ret)
> +{
> +	if (ret =3D=3D KSFT_PASS)
> +		ksft_test_result_pass("%s\n", name);
> +	else if (ret =3D=3D KSFT_SKIP)
> +		ksft_test_result_skip("%s\n", name);
> +	else
> +		ksft_test_result_fail("%s\n", name);
> +}

[Severity: Low]
In report(), ksft_test_result_skip("%s\n", name) only prints the test name,
and many of the KSFT_SKIP return paths (such as in run_in(), params_refused=
(),
params_keep_class_change(), yield_switched_out(), overrun_caught(),
reclaim_runs(), reclaim_switched(), server_params(), server_rebuilds(),
server_states(), server_reclaim(), params_waking(), random_mix(),
hotplug_refused(), hotplug_server(), and hotplug_server_refused()) return
KSFT_SKIP without printing why the test was skipped.

Could the skip paths pass or log a reason string explaining which prerequis=
ite
was missing, per kselftest conventions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793804635.gi=
t.mathieu.desnoyers@efficios.com?part=3D12
