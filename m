Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039678;
	b=X7zaqAHQ1aNyeQdNNc0rCiLr90dbBQxSC7DWrFJAO2yQITn4MrW+4Q+kvSLUxF9Ffs5w
	 2MUiQTpjJ6jRwFbjplLBmAMsDiBVDxpc577HDckDJUnOqbrfWDj189H8mGturN75SP1yG
	 NSFkrNMZbvPXzAOCaFaLymM8l1YuEfZRO0JloblThvBeRa9kMuwJzLKLlQv+r30l3oHnL
	 lSLINgJAR4cu5y+WfeJtJuxjNs6jUhLCto1YXOG74sdX/bs302qwckWqxHSzgFJbKmttd
	 1ccRrl6L6Fk8Upu/6VK/a5vfQBX4BHu6CghIrwYrv3ZQf9kbkvkNGvrTDzHjE+Myibw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039678;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ltf/D1U3fBU25HLoOONKELBPBoOBkSZopBKQqtCUdXs=;
	b=wjTy2ukgJEhjr8f7zTnC4oD56YkIJ5eD1XBC+vC+BZfRF+ySnjkLd0CKOP3SzCvQzi8g
	 xcAy3odmj/OnrYNi7HPLZG7yC+Nbv2RwE72cnwIhyp0dDHPLf6Db9fu3TOEe8/wBJFscx
	 Jz54cwK9elVm8e0eKopYtC3d6+NcXAYzuQSO24LcuMzwIXKgc/JGZUTYGVz8a58bmFSPN
	 ffACZ2S1bDi75j4d+FUxkzA667mGKAsaXPOV96w5nEQYdthpxUmvS4yG48oSYiyY/XPpC
	 pG0adOEnXWnT8F+f2CEkw/RldSNeXjkYdMffWcQ/NUm0eXX/OkOoS5FhlC2X4Xyfz/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=giUQltc0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7E1606A31C;
	Wed, 18 Nov 2026 22:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=giUQltc0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022421F000C5;
	Wed, 18 Nov 2026 22:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039678;
	bh=Ltf/D1U3fBU25HLoOONKELBPBoOBkSZopBKQqtCUdXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=giUQltc097KIay3q/sSSNU/iPuPn10aaiKkUW2FDl5tKCM3JYXQpdOCLV/ymD/Yvf
	 NS44grh3KqUHjMERLuROzAGSLM/6uZe8NeodzYS6EhvNtcVOWEzwbuTRiXwmfNIiWj
	 NystOAVmUF6VHI7Lyq1nIP+oCSqPdO/0TQphF6sK6ZzZs0b995BFFaJMWEyYz2Y+sz
	 mIAAUc2CUp9JbsQmqLaY/EPIXtGJ7GXEy1xVjCP89D23Kl3QI7wC1JaUJTEhrVZR78
	 f6IByvIKiTcHWrVEilzNyoqlOSAQVQbwR293H0f3eZ0jmBFWcabzTOiTQNz4DCtGZQ
	 099lGgjVKKWWg==
Message-ID: <sashiko-outbox-222083@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/16] selftests/sched: Add a test of SCHED_DEADLINE
 bandwidth accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <a94584f87598e48fece3c4eb9ec5f65e2a442abb.1795037078.git.mathieu.desnoyers@efficios.com>
References: <cover.1795037078.git.mathieu.desnoyers@efficios.com>
 <a94584f87598e48fece3c4eb9ec5f65e2a442abb.1795037078.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 22:07:57 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [Medium] selftests/sched: unhandled SCHED_FIFO EPERM in
  server_client()
- [Medium] selftests/sched: pi_chain_donor_leaves() fails due to
  unpropagated dl.pi_se
- [Medium] selftests/sched: zero waiter deadline in
  deboost_new_params_reboost()
- [Low] selftests/sched: process-private ready flag in shm_lock_init()
- [Low] selftests/sched: write-only fair_tid, unused isol, and dead mode
  branches
--

commit 027ae545afaed0101b592ecd773abaab9b25aeca
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Add a test of SCHED_DEADLINE bandwidth accounting

This commit adds the deadline_bw_test selftest covering SCHED_DEADLINE
bandwidth accounting across priority inheritance, parameter changes,
cpuset moves, task exits, bandwidth reclaiming, fair servers, and CPU
hotplug.

Link: https://github.com/jlelli/sched-deadline-tests

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> new file mode 100644
> index 0000000000000..d015e743c941f
> --- /dev/null
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c

[ ... ]

> +static void *reboost_owner(void *arg)
> +{
> +	uint64_t t0;
> +	int err;
> +
> +	owner_tid =3D gettid_();
> +	if (take_pi_lock())
> +		return (void *)1;
> +	owner_holds =3D 2;
> +	sem_wait_sig(&owner_go);
> +	if (rb_abort) {
> +		drop_pi_lock();
> +		return NULL;
> +	}
> +	err =3D set_deadline(0, 50 * NSEC_PER_MSEC, PERIOD);
> +	if (err) {
> +		ksft_print_msg("the owner refused as a deadline task: %s\n",
> +			       strerror(-err));
> +		goto out;
> +	}
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
Does calling set_deadline() on rb_waiter_tid while W is already blocked on
pi_lock give W an absolute deadline of 0 instead of a deadline later than O
and D?

Because W is not queued on a runqueue, __setparam_dl() sets its static
parameters while leaving W->dl.deadline at 0, and switched_to_dl() returns
early without enqueuing W.  rt_mutex_adjust_pi() then updates W's waiter
node on pi_lock with tree.deadline =3D 0, which sorts ahead of D
(dl_time_before(0, D->dl.deadline) is true) and makes W the top waiter
boosting O right away.  When D times out 20ms later, D is no longer the top
waiter, so remove_waiter() returns without deboosting or reboosting O.

[ ... ]

> +static int pi_init_lock2(void)
> +{

[ ... ]

> +	donor_tid =3D 0;
> +	x_tid =3D 0;
> +	fair_tid =3D 0;
> +	return 0;
> +}

[Severity: Low]
This isn't a bug, but fair_tid is only written here and never read (which
triggers -Wunused-but-set-variable under Clang).  In addition, main()
populates isol via read_online(&isol, 1) without using or freeing it,
wait_spinner(), hold() and release_held() have unused forward declarations,
and several helpers retain unreachable branches with no callers in
p_cases[] or hp_cases[] (sleeper_cpu >=3D 0 in dl_sleeper_tid(), was_dl !=
=3D 0
in sleeping_owner() and pi_asleep(), modes 1 and 2 in deboost_case(),
spin_ms =3D=3D 8 in refill_case(), modes 0 and 2-5 in return_case() along w=
ith
set_constrained(), MV_YIELDED in mover(), and hp_case::no_hp).

[ ... ]

> +/*
> + * A chain walk must pass a new donor on to the end of the chain. This
> + * holds even when the sort keys of the task in the middle do not change.
> + *

[ ... ]

> + * 5. Z blocks on L1. Z's deadline is earlier than W's, so Z becomes M's
> + *    donor. M sleeps, so its deadline does not move. The chain walk must
> + *    go on to O and make Z O's donor too.
> + * 6. The main thread switches W to SCHED_OTHER. W sleeps and has run
> + *    almost nothing, so its parameters are cleared at once.
> + * 7. 250ms later, the main thread wakes O up. O has no deadline ahead, =
so
> + *    its wakeup starts a new period from its donor. O spins 100ms.
> + *    Then it measures the CPU time Y gets over 200ms, and unlocks L2.
> + *
> + * With Z as its donor, O gets 2ms every 80ms. Y's deadline is soon the
> + * earlier one, and Y gets about its 60ms. With W as its donor, O runs on
> + * cleared parameters. Each refill gives it no runtime and a deadline of
> + * about now. O then runs before Y all the time, and Y gets close to
> + * nothing. The case fails if Y gets less than 30ms.
> + *
> + * W does not exit before O unlocks L2. It waits for L1, which M releases
> + * after it gets L2.
> + */
> +static int pi_chain_donor_leaves(void)
> +{

[ ... ]

> +	} else if (ret =3D=3D KSFT_PASS && y_ns < 30 * (long long)NSEC_PER_MSEC=
) {
> +		ksft_print_msg("Y ran %lld ms of 200: O ran on the cleared parameters =
of W\n",
> +			       y_ns / (long long)NSEC_PER_MSEC);
> +		ret =3D KSFT_FAIL;
> +	}

[Severity: Medium]
Does pi_chain_donor_leaves() pass on this series without an rt_mutex chain
walk change to propagate M->dl.pi_se to O when M's sort keys do not move?

When Z blocks on L1 in step 5, rt_mutex_setprio(M, Z) updates M->dl.pi_se
to &Z->dl, but M is sleeping on L2, so M->prio and M->dl.deadline stay
unchanged.  In rt_mutex_adjust_prio_chain(), rt_waiter_node_equal() sees
that M's waiter node on L2 still matches task_to_waiter_node(M), skips
requeueing M on L2, and never calls rt_mutex_adjust_prio() on O:

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

O->dl.pi_se stays &W->dl after W switches to SCHED_OTHER and has its
parameters cleared.  When O wakes in step 7, replenish_dl_entity() keeps
resetting O->dl.deadline to rq_clock(rq) and O->dl.runtime to 0 from W's
cleared parameters, starving Y on P's CPU and failing this check.

[ ... ]

> +/* Set up shm_lock. Return 0, or -1 if it cannot be set up. */
> +static int shm_lock_init(void)
> +{
> +	static int ready;
> +	pthread_mutexattr_t a;
> +	int err;
> +
> +	/*
> +	 * A case can kill the owner while it holds the lock. Take the lock
> +	 * back and release it, so that it can be destroyed.
> +	 */
> +	if (ready) {
> +		err =3D pthread_mutex_trylock(shm_lock);
> +		if (err =3D=3D EOWNERDEAD)
> +			err =3D pthread_mutex_consistent(shm_lock);
> +		if (!err)
> +			pthread_mutex_unlock(shm_lock);
> +		pthread_mutex_destroy(shm_lock);
> +		ready =3D 0;
> +	}

[Severity: Low]
Since death_pi_waiter, death_pi_owner, and death_pi_deadline_owner each run
in a separate child process forked by run_in(), doesn't the process-private
static ready variable start at 0 in every child?

In death_pi_waiter, reap(owner) kills the owner while it holds shm_lock,
leaving *shm_lock in MAP_SHARED memory in the EOWNERDEAD state.  When
death_pi_owner and death_pi_deadline_owner run in new child processes,
ready is 0, so the EOWNERDEAD recovery and pthread_mutex_destroy() block is
skipped and pthread_mutex_init() is called directly on the active mutex.
Should ready live in the MAP_SHARED mv_state buffer (or should pi_death()
clean up shm_lock before exiting)?

[ ... ]

> +static pid_t server_client(int rt)
> +{
> +	pid_t pid =3D fork_child(rt ? "a real-time task of P" : "a fair task of=
 P");
> +
> +	if (!pid) {
> +		struct sched_param sp =3D { .sched_priority =3D 1 };
> +
> +		if (enter(cg_p, getpid()) ||
> +		    (rt && sched_setscheduler(0, SCHED_FIFO, &sp)))
> +			_exit(1);
> +		mv_state[0]++;
> +		for (;;) {
> +			wait_set(&mv_state[4 + rt]);
> +			spin_ns(rt ? 50 * NSEC_PER_MSEC : NSEC_PER_MSEC);
> +			if (rt)
> +				sleep_ns(NSEC_PER_MSEC);
> +		}
> +	}
> +	return pid;
> +}

[ ... ]

> +static int server_states(void)
> +{

[ ... ]

> +	fair =3D server_client(0);
> +	rt =3D server_client(1);
> +	if (fair < 0 || rt < 0 || wait_for(5000, mv_state[0] >=3D 2)) {
> +		if (fair >=3D 0 && rt >=3D 0)
> +			ksft_print_msg("a fair or real-time task of P could not start\n");
> +		ret =3D KSFT_FAIL;
> +	}

[Severity: Medium]
On a CONFIG_RT_GROUP_SCHED=3Dy system where the cpu controller is already
enabled in root/cgroup.subtree_control, won't server_client(1) fail
sched_setscheduler(0, SCHED_FIFO, &sp) in cg_p with EPERM and cause
server_states() to time out and fail instead of skipping?

As noted in move_cancelled(), child cgroups have no RT runtime in cgroup v2
when CONFIG_RT_GROUP_SCHED is enabled with the cpu controller active.
Because move_cancelled() only disables the cpu controller on exit if it
added "+cpu" itself, sched_setscheduler() in server_client(1) fails and
calls _exit(1) without updating mv_state[0], so server_states() waits the
full 5 seconds and returns KSFT_FAIL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795037078.gi=
t.mathieu.desnoyers@efficios.com?part=3D16
