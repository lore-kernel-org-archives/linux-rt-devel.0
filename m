Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035887;
	b=viOpCLKuQqHy81QXCrn5O7FvpilzlCOygC4WdyXF/qxZLFsO3b5NDMQ1DOgt39log7ON
	 4N8KHMYTWBMWWmRZdO4zeOQH1Ex/q+ljzrvT8rhCLSJ0BkNSujnVzhdcUmgjG7gkx6WBh
	 zqxZZJZheumB5xJntKI2fVAc7uzyci0k0OCbXyPlk4ku4lSmeR/CjUvkZsjQsyw47zSYi
	 U4xNQrumMHifUr8dhvEZuAMS1tWLnjDOjVNr2wc6ahq220Q3HmGMqXIq0p0e1K/c4/cKO
	 PpwhuktDIbSaUPQjOenEBED9Yrq0onBV5Zgg/oOBV0C8QNzYFxv+fL8hb6GHZ+44wCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035887;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hVpOUdPfBVWBK2Biqg840IDP1oSjbED2vU8YGX+1DjY=;
	b=XX3I7x8342RtEWyuy+toQIlYioWgUgKwHzD1j3NzhGtGBFpTKY0uqWZOB7PcoLvqa4N4
	 LIm4Dpg2kRd5htQ40w9iJnx4kDaWTfJe7zkbrHj1N5yZpfdtnPF7M0XdszQK+MtvpLdbP
	 lejYUyb1P4z0pvjNYxstddkc8pPSbDw2xpPeKc4z/pfdxyUa3FheRPxathuPCkabg1/Kj
	 D+YLxkTA2Rhz+h5Uu5YclxS0xcA7g3JP+v/x4zpZy6TD0TLdjjnsZORNVmRSCn2pMa93E
	 ufAvdSnpADDsr/ASoKw67cGkJnJ498xYW20aKTRM8aN5ugkI0yCAI8ct1Io2oKiYNwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0ygF9ww;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574DE60A2600;
	Wed, 18 Nov 2026 21:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i0ygF9ww
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0A711F000C4;
	Wed, 18 Nov 2026 21:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795035887;
	bh=hVpOUdPfBVWBK2Biqg840IDP1oSjbED2vU8YGX+1DjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0ygF9wwx8rhPnMwBPVhfYFmd5cmdRZBLKwjgN1ryL03LJNZ3c9rJxJJ0z+1tBAem
	 49TafgFzHqNtZyxniNfX4kyGn6TIHYJRDlQeCA/0QTbGGIK1Obc5Pn4KwOU1ndwxEN
	 EI5Ra9dkkz8n5shSaZ+pmx+U+dxsAQ7oPbj49/rtJagffPu+b25K213lh8TJyuMN9+
	 CzR9LdIp6I+nZxGCE3ilXeBVGFmbM5w4AZ1pMbmVE1S81Ymel1f7EoQoMGQVABFURJ
	 p9nj9eIj1zC8sV/Nj7EuQlsh52rradweS1brCBPwpcbNijLJpvvWv1WTWpMLpVEJOF
	 FFJpIdxv145TQ==
Message-ID: <sashiko-outbox-221967@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/16] selftests/sched: Add a test of SCHED_DEADLINE
 bandwidth accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <92d746027d4034afb4e9c55bd1b686312a2401ab.1795031605.git.mathieu.desnoyers@efficios.com>
References: <cover.1795031605.git.mathieu.desnoyers@efficios.com>
 <92d746027d4034afb4e9c55bd1b686312a2401ab.1795031605.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 21:04:46 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [Medium] selftests/sched: sub-cgroup start and unconditional cpu
  toggle in move_cancelled()
- [Medium] selftests/sched: broken PI and runtime logic in
  deboost_new_params_reboost()
- [Medium] selftests/sched: pi_chain_donor_leaves() fails due to
  unpropagated dl.pi_se
- [Medium] selftests/sched: rebuild_record_taken() fails under
  isolcpus=3Ddomain,0,1
- [Low] selftests/sched: rebuild_record_taken() fails instead of
  skipping without debugfs
- [Low] selftests/sched: data race on late.done and unjoined thread in
  move_cancelled()
- [Low] selftests/sched: unchecked -1 error return from probe() in
  bandwidth comparisons
- [Low] selftests/sched: unused variables, write-only fair_tid, and dead
  mode branches
- [Low] selftests/sched: re-init of active robust mutex shm_lock in
  shm_lock_init()
--

commit ec25de481fdb21f02eb990530342399d3485450d
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Add a test of SCHED_DEADLINE bandwidth accounting

This commit adds deadline_bw_test, a kselftest covering SCHED_DEADLINE
bandwidth accounting across priority inheritance, parameter changes,
cpuset moves, task deaths, yields, runtime overruns, bandwidth
reclaiming, fair server changes, and CPU hotplug.

Link: https://github.com/jlelli/sched-deadline-tests

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> new file mode 100644
> index 0000000000000..1e64402f90df0
> --- /dev/null
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c

[ ... ]

> +	sem_post(&rb_donor_go);
> +	t0 =3D now_ns();
> +	while (!rb_donor_locking || proc_state_of(donor_tid) !=3D 'S') {
> +		if (now_ns() - t0 > NSEC_PER_SEC) {
> +			ksft_print_msg("the donor did not block on the lock\n");
> +			err =3D -1;
> +			goto out;
> +		}
> +	}
> +	err =3D set_deadline(rb_waiter_tid, 2 * NSEC_PER_MSEC, PERIOD);
> +	if (err) {
> +		ksft_print_msg("the waiter refused as a deadline task: %s\n",
> +			       strerror(-err));
> +		goto out;
> +	}
> +	err =3D set_deadline(0, 5 * NSEC_PER_MSEC, PERIOD);

[Severity: Medium]
Does deboost_new_params_reboost() exercise reboosting after a deboost as
its comment describes?

When reboost_owner() calls set_deadline() on rb_waiter_tid while W is
blocked on pi_lock, W is not queued on a runqueue, so __setparam_dl()
updates W's static parameters and switched_to_dl() returns without setting
W->dl.deadline.  rt_mutex_adjust_pi() then copies W->dl.deadline (0) into
W's waiter node on pi_lock, which sorts ahead of D's deadline in
rt_waiter_node_less() and makes W the top waiter boosting O immediately,
before D times out.

Also, when O calls set_deadline() on itself while running, the kernel
enqueues O with ENQUEUE_RESTORE | ENQUEUE_MOVE without replenishing, and
rt_mutex_setprio() on deboost does not compare O's remaining runtime
against its new static runtime or start a new period, so the test passes
without testing a reboost on deboost.

[ ... ]

> +static pthread_mutex_t pi_lock2;
> +static sem_t holder_go;
> +static atomic_int holder_holds, chain_waits, donor_done, x_waits, l2_tak=
es;
> +static atomic_int chain_rank, x_rank;
> +static _Atomic pid_t x_tid, fair_tid;

[ ... ]

> +	donor_tid =3D 0;
> +	x_tid =3D 0;
> +	fair_tid =3D 0;
> +	return 0;
> +}

[Severity: Low]
fair_tid is set in pi_init_lock2() but never read, which triggers a
-Wunused-but-set-variable warning under -Wall.  Similarly, nisol and isol
in main() are populated by read_online(&isol, 1) and never used or freed,
sleeper_cpu is never modified from -1 (leaving the sleeper_cpu >=3D 0 block
in dl_sleeper_tid() unreachable), struct hp_case::no_hp is never set, and
several helper modes (was_dl !=3D 0 in pi_asleep(), modes 1 and 2 in
deboost_case(), spin_ms =3D=3D 8 in refill_case(), modes 0 and 2..5 in
return_case(), and MV_YIELDED in mover()) have no callers.

[ ... ]

> +	have[LV_Z] =3D !pthread_create(&t[LV_Z], NULL, leave_waiter, (void *)2L=
);
> +	if (!have[LV_Z] ||
> +	    wait_for(1000, (leave_tid[LV_Z] && proc_state_of(leave_tid[LV_Z]) =
=3D=3D 'S') ||
> +			   leave_err)) {
> +		ksft_print_msg("Z never blocked on L1\n");
> +		goto out;
> +	}
> +	sleep_ns(10 * NSEC_PER_MSEC);	/* the chain walk of Z is done */
> +	err =3D leave_err ? -EINVAL : set_other(leave_tid[LV_W]);

[Severity: Medium]
Does pi_chain_donor_leaves() fail because Z is never propagated past M to
O as O's donor?

When Z blocks on L1, task_blocks_on_rt_mutex() updates M->dl.pi_se to
&Z->dl, but M is sleeping on L2, so M->prio (-1) and M->dl.deadline do not
change.  In rt_mutex_adjust_prio_chain(), rt_waiter_node_equal() sees that
M's waiter node on L2 still matches M's prio and deadline and stops without
requeueing M on L2 or calling rt_mutex_adjust_prio() on O:

kernel/locking/rtmutex.c:rt_mutex_adjust_prio_chain() {
    ...
	if (rt_waiter_node_equal(&waiter->tree, task_to_waiter_node(task))) {
		if (!detect_deadlock)
			goto out_unlock_pi;
		else
			requeue =3D false;
	}
    ...
}

O->dl.pi_se therefore stays &W->dl.  After set_other(leave_tid[LV_W]) and
the 250ms sleep clear W's deadline parameters, waking O replenishes O from
W's zeroed parameters with runtime =3D 0 and deadline =3D rq_clock(rq), so O
preempts and starves Y on P's CPU and fails the y_ns < 30ms check.

[ ... ]

> +/* What late_setter() does, and the result. */
> +static struct {
> +	pid_t pid;
> +	uint64_t runtime;
> +	uint64_t delay;
> +	atomic_int go;
> +	int ret;
> +	uint64_t done;
> +} late;
> +
> +/*
> + * Make late.pid a deadline task of late.runtime every 100ms, late.delay
> + * ns after late.go. Store the result in late.ret and the time it return=
ed
> + * in late.done.
> + */
> +static void *late_setter(void *arg)
> +{
> +	uint64_t start;
> +
> +	while (!late.go)
> +		;
> +	start =3D now_ns();
> +	while (now_ns() - start < late.delay)
> +		;
> +	late.ret =3D set_deadline(late.pid, late.runtime, PERIOD);
> +	late.done =3D now_ns();
> +	return arg;
> +}

[ ... ]

> +static int move_cancelled(void)
> +{
> +	int with_p, with_r, ret =3D KSFT_PASS, i, err;
> +	const char *name =3D "move_cancelled";
> +	uint64_t start, len;
> +	pid_t pid;
> +
> +	mv_state[0] =3D 0;
> +	mv_state[3] =3D 0;
> +	mv_state[4] =3D 0;
> +	mv_state[5] =3D 0;
> +	pid =3D pinned_mover(2048, 1);
> +	if (pid < 0 || child_up(name, 0) || wait_for(5000, mv_state[5])) {
> +		reap(pid);
> +		return mv_state[0] =3D=3D -2 ? KSFT_SKIP : KSFT_FAIL;
> +	}
> +	if (mv_state[5] < 0 || write_file(root, "cgroup.subtree_control", "+cpu=
")) {
> +		ksft_print_msg("%s: no SCHED_FIFO thread or no cpu controller\n", name=
);
> +		reap(pid);
> +		return KSFT_SKIP;
> +	}

[ ... ]

> +		if (wait_for(5000, late.done)) {
> +			ksft_print_msg("%s: sched_setattr() still waits after a cancelled mov=
e\n",
> +				       name);
> +			ret =3D KSFT_FAIL;
> +			break;	/* the thread cannot be joined */
> +		}
> +		join(t);
> +		if (late.ret) {
> +			ksft_print_msg("%s: sched_setattr: %s\n", name, strerror(-late.ret));
> +			ret =3D KSFT_FAIL;
> +		}
> +	}
> +	sleep_ns(3 * PERIOD);
> +	if (ret =3D=3D KSFT_PASS &&
> +	    (admits_in(cg_p, with_p, "P, after the cancelled moves") ||
> +	     admits_in(root, with_r, "the root domain of the process")))
> +		ret =3D KSFT_FAIL;
> +out:
> +	reap(pid);
> +	if (write_file(root, "cgroup.subtree_control", "-cpu"))
> +		ksft_print_msg("%s: the cpu controller stays enabled\n", name);
> +	return ret;
> +}

[Severity: Medium]
What happens in move_cancelled() when deadline_bw_test is started from a
non-root cgroup (such as a systemd session or service cgroup)?

Unlike kill_case() and death_group(), main() and move_cancelled() never
move the test process into root before forking pinned_mover(2048, 1).
With CONFIG_RT_GROUP_SCHED=3Dy, a non-root cgroup has no RT runtime by
default, so either fifo_sleeper() fails sched_setscheduler(SCHED_FIFO)
with EPERM when +cpu is already enabled, or enabling +cpu on root fails
with EINVAL while the child cgroup contains a SCHED_FIFO task, causing
move_cancelled() to always skip.  Also, unlike run_p_cases() and
cs_setup() with +cpuset, move_cancelled() unconditionally writes -cpu to
root/cgroup.subtree_control at exit even if the cpu controller was already
enabled before the test ran.

[Severity: Low]
In the same loop, late.done is a plain uint64_t written by late_setter()
while move_cancelled() polls it in wait_for(5000, late.done), which is a
data race.  If that wait times out, breaking out before join(t) also
leaves t unjoined in the main process even though reap(pid) at out: kills
pid and unblocks late_setter().

[ ... ]

> +/* Set up shm_lock. Return 0, or -1 if it cannot be set up. */
> +static int shm_lock_init(void)
> +{
> +	pthread_mutexattr_t a;
> +	int err;
> +
> +	err =3D pthread_mutexattr_init(&a);
> +	if (!err)
> +		err =3D pthread_mutexattr_setpshared(&a, PTHREAD_PROCESS_SHARED);
> +	if (!err)
> +		err =3D pthread_mutexattr_setprotocol(&a, PTHREAD_PRIO_INHERIT);
> +	if (!err)
> +		err =3D pthread_mutexattr_setrobust(&a, PTHREAD_MUTEX_ROBUST);
> +	if (!err)
> +		err =3D pthread_mutex_init(shm_lock, &a);

[ ... ]

> +	} else {
> +		reap(waiter);
> +		waiter =3D -1;
> +		sleep_ns(50 * NSEC_PER_MSEC);	/* the owner deboosted asleep */
> +	}
> +out:
> +	reap(waiter);
> +	reap(owner);
> +	return ret;
> +}

[Severity: Low]
Does shm_lock_init() re-initialize shm_lock without destroying it across
death_pi_waiter, death_pi_owner, and death_pi_deadline_owner?

shm_lock lives in MAP_SHARED memory, and in death_pi_waiter, reap(owner)
kills the owner with SIGKILL while it still holds shm_lock, leaving the
robust mutex in the FUTEX_OWNER_DIED state when the next test case calls
pthread_mutex_init(shm_lock, &a).  shm_lock_init() (and
pi_chain_two_owners()) also omits pthread_mutexattr_destroy(&a).

[ ... ]

> +static int hotplug_server(void)
> +{
> +	int base, off10, off30;
> +
> +	if (server_set(hp_cpu, SERVER_RUNTIME, SERVER_PERIOD)) {
> +		ksft_print_msg("the fair server of CPU %d cannot be set\n", hp_cpu);
> +		return KSFT_SKIP;
> +	}
> +	base =3D probe(NULL);
> +	if (cpu_online(hp_cpu, 0)) {
> +		ksft_print_msg("offline of CPU %d refused\n", hp_cpu);
> +		return KSFT_FAIL;
> +	}
> +	off10 =3D probe(NULL);
> +	cpu_up(hp_cpu);
> +	if (server_set(hp_cpu, 3 * SERVER_RUNTIME, SERVER_PERIOD) ||
> +	    admits(base - 2, "a fair server of 30%"))
> +		return KSFT_FAIL;
> +	if (cpu_online(hp_cpu, 0)) {
> +		ksft_print_msg("offline of CPU %d refused, its fair server at 30%%\n",=
 hp_cpu);
> +		return KSFT_FAIL;
> +	}
> +	off30 =3D probe(NULL);
> +	cpu_up(hp_cpu);
> +	if (off30 !=3D off10) {

[Severity: Low]
Can hotplug_server() pass when probe(NULL) fails and returns -1?

If both offline probes return -1, off30 !=3D off10 evaluates to false; base
is not checked for <=3D 0 either.  move_refused() and move_zero_bw()
similarly compare probe(cg_p) !=3D base_p || probe(root) !=3D base_r without
checking whether base_p or base_r failed with -1.

[ ... ]

> +static int rebuild_record_taken(void)
> +{
> +	int a =3D top_cpu(3), b =3D top_cpu(2), c =3D online[0], d =3D top_cpu(=
1);
> +	int fd[2] =3D { -1, -1 }, i, n, err, cpu, ret =3D KSFT_SKIP;
> +	long long q, h, q0, h0, bw;
> +	char buf[4096];
> +	pid_t pid =3D -1;
> +
> +	if (ncpus < 4 || !cpu_hotpluggable(a) || !cpu_hotpluggable(b) ||
> +	    !cpu_hotpluggable(d)) {
> +		ksft_print_msg("needs 4 CPUs, 3 of them hotpluggable\n");
> +		return KSFT_SKIP;
> +	}
> +	if (cs_setup())
> +		return KSFT_SKIP;
> +	/* Q has every housekeeping CPU but A, B and D. */
> +	for (i =3D n =3D 0; i < ncpus - 3; i++)
> +		n +=3D snprintf(buf + n, sizeof(buf) - n, "%s%d", n ? "," : "",
> +			      online[i]);
> +	if (make_partition_cpus(cs_q, buf)) {
> +		ksft_print_msg("Q cannot be a partition root of CPUs %s\n", buf);
> +		goto out;
> +	}
> +	ret =3D KSFT_FAIL;
> +	err =3D cpu_online(d, 0);
> +	if (err) {
> +		ksft_print_msg("offline of CPU %d: %s\n", d, strerror(-err));
> +		goto out;
> +	}
> +	bw =3D total_bw_of(a);
> +	if (bw =3D=3D -1 || pipe(fd)) {
> +		ksft_print_msg("no total_bw of CPU %d, or no pipe\n", a);
> +		goto out;
> +	}

[Severity: Low]
Should rebuild_record_taken() return KSFT_SKIP instead of KSFT_FAIL when
total_bw_of(a) returns -1 because /sys/kernel/debug/sched/debug is not
available?

ret is set to KSFT_FAIL before total_bw_of(a) is checked, whereas the
other debugfs-dependent cases skip when debugfs files cannot be read.

> +	mv_state[0] =3D 0;
> +	mv_state[1] =3D 0;
> +	pid =3D fork_child("a deadline task");
> +	if (!pid) {
> +		cpu_set_t set;
> +		char ch;
> +
> +		CPU_ZERO(&set);
> +		CPU_SET(a, &set);
> +		CPU_SET(b, &set);
> +		if (sched_setaffinity(0, sizeof(set), &set) ||
> +		    set_deadline(0, 10 * NSEC_PER_MSEC, PERIOD)) {

[ ... ]

> +	if (fallback_wake(fd[1], pid))
> +		goto out;
> +	/* Go on after a failure: the totals tell more. */
> +	cpu =3D task_cpu_of(pid);
> +	if (cpu !=3D c)
> +		ksft_print_msg("woken on CPU %d, not %d\n", cpu, c);
> +	else if (!totals_check("woken", d, c, q, h))
> +		ret =3D KSFT_PASS;
> +	reap(pid);
> +	pid =3D -1;
> +	sleep_ns(3 * PERIOD);
> +	if (totals_of(d, c, &q0, &h0)) {
> +		ret =3D KSFT_FAIL;
> +		goto out;
> +	}
> +	if (q !=3D q0 || h !=3D h0 + bw) {
> +		ksft_print_msg("Q counts %lld of %lld, the root cgroup %lld\n",
> +			       q - q0, bw, h - h0);
> +		ret =3D KSFT_FAIL;
> +	}

[Severity: Medium]
Does rebuild_record_taken() fail when CPU 0 is isolated with
isolcpus=3Ddomain,0,1?

When CPU 0 is isolated, online[0] is the first housekeeping CPU (for
example, c =3D 2).  The child in the root cgroup overwrites its inherited
housekeeping affinity with {a, b}.  Once a and b are taken offline and
cs_q takes the remaining housekeeping CPUs except c,
dl_add_task_root_domain() queries cpuset_cpus_allowed_locked() for
top_cpuset, which includes the isolated CPUs 0 and 1, so
cpumask_first_and(cpu_active_mask, msk) picks CPU 0 and adds bw to CPU 0's
default root domain rather than CPU c's housekeeping root domain (leaving
h =3D=3D h0 instead of h0 + bw).  Likewise, waking pid via fallback_wake()
hits select_fallback_rq() -> cpuset_cpus_allowed_fallback(), which resets
pid's affinity to top_cpuset.cpus_allowed and wakes pid on CPU 0 instead
of CPU c.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795031605.gi=
t.mathieu.desnoyers@efficios.com?part=3D16
