Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120131;
	b=QThQsSp2+gADzwLmloZ5BVDVybWKNEjOP+cnlbxd2yu53lcjA3me6l+/ob7SEQNmpNfa
	 M7qAKrtwgmhz3em8kP1aezsJKJdkzo41ohO0s58LDES8lz6IF5vnxuNwgjPxjLz/W8cPw
	 EuyMtstfA9yEgCqUCBO3Jb01VoLCrWTZUx+3r+RyJA//FUSK8MZlKiY6bfp8CltROwJk8
	 OHbYcF8/mqJLNmcibjstq24QBgfPiFNV+WHgjyuwjmf7Q/IBJNEOXRVBy2XA0IJv5TSzC
	 S0tOUDBwT/rQQEnwwYPxsolTtOd1RZaPizMNgmWhhee6jd2Eai88LLQIShfhnzg97Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120131;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qa5D7MDOpUe6cUQ+JZTRKmeJX7MIHRLKCXKvwS1zzus=;
	b=TXmsmcCf167gwR7PPyDtkK6+Vnl9OD+tftMFmPq/wnN8rK91D2nLJdaTxzNTCdvHGi/9
	 tKZDEp24rs9xz0CwdMmSYWKuMvKunpD2hFaEdo4dyYwNEkyLhenIWISj/XClvQR4qOvP0
	 UIEhNVJbOSm/9bIIIg5b/5pJJcMEYzpnnELx8RSa/EAn8Wnwq2laYliuFFvHqmfgCXfZ3
	 qlSoeXZMsSKckIBN2ybngChL2OBsBY4yty5zaFHcCThuw0PelGW6Ts6sGqI3YbPDMNrTM
	 B+eSEyBT3Xcwy0+6mult3hQyilLQo4DI9j6+CrAFMrqE3qsLuIPyBXGRbGq8qQ3L9QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bcNe/3ga";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFE0606A325;
	Thu, 19 Nov 2026 20:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcNe/3ga
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7C61F000D0;
	Thu, 19 Nov 2026 20:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120130;
	bh=qa5D7MDOpUe6cUQ+JZTRKmeJX7MIHRLKCXKvwS1zzus=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bcNe/3gag1OaYgRvc9c8pNkSXFKPb6i23In47InOh1XS7758M1+3wSBssSFJE4Lot
	 KBotEAlnpC1gFqwz/4DWjeT/mOqg1aUH1yDbw86pduFA+BEUv/wRhCLBzZJZudzhcU
	 hEp4iUROzk9Cr8NutYsH54BVP97naidhV9EdV6rpwVHNAHUgdpMfYy7zPJKGMMkY23
	 wAGyUyFEs62OIUysblsj4VQrFnUxDoksMh+vFhXlFp7k4GSYB0RWNAC2iVYyfi0T+T
	 YKbBOf7ujI30Ur8MlmNpAGX9qiqSNLc8q/NRFPfKEkxKUnWVYrZZhVX6qO0VLCmS3r
	 pCZGfYZlqf35Q==
Message-ID: <sashiko-outbox-224022@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 05/33] selftests/sched: Test SCHED_DEADLINE bandwidth
 across a root domain rebuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <2c85e2efab1ae7eb89b6d6e334c933348486c542.1795116790.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <2c85e2efab1ae7eb89b6d6e334c933348486c542.1795116790.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:28:50 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [Medium] selftests/sched: missing isolated/sparse CPU handling and
  code duplication
- [Low] selftests/sched: missing 0-lag wait on early exit in
  test_rebuild()
- [Low] selftests/sched: undersized path buffer in make_partition()
- [Low] selftests/sched: missing PR_SET_PDEATHSIG in departing() and
  sleeper()
--

commit 61b9ca4442ef766ed51f3c6ad77a1ac959261741
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Test SCHED_DEADLINE bandwidth across a root domain rebuild

This commit adds the deadline_rebuild_test selftest to verify that
SCHED_DEADLINE bandwidth of tasks that exit or leave the policy before
their 0-lag time is preserved across cpuset partition root domain
rebuilds.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_rebuild_test=
.c b/tools/testing/selftests/sched/deadline/deadline_rebuild_test.c
> new file mode 100644
> index 0000000000000..714a0ff03f1b9
> --- /dev/null
> +++ b/tools/testing/selftests/sched/deadline/deadline_rebuild_test.c
> @@ -0,0 +1,497 @@

[ ... ]

> +/* Make @cg a partition root of CPU @cpu alone. Return 0, or -1 on error=
. */
> +static int make_partition(const char *cg, int cpu)
> +{
> +	char path[PATH_MAX], buf[32];
> +
> +	if (mkdir(cg, 0755) && errno !=3D EEXIST)
> +		return -1;
> +	snprintf(buf, sizeof(buf), "%d", cpu);
> +	if (write_file(cg, "cpuset.cpus", buf) || write_file(cg, "cpuset.cpus.p=
artition", "root"))
> +		return -1;
> +	snprintf(path, sizeof(path), "%s/cpuset.cpus.partition", cg);
> +	if (read_file(path, buf, sizeof(buf)) || strcmp(buf, "root\n"))
> +		return -1;
> +	return 0;
> +}

[Severity: Low]
Can snprintf() truncate path[] here and trigger a -Wformat-truncation
warning when make_partition() is inlined with cg_p or cg_q (which are
sized PATH_MAX)?  Sizing path[] to PATH_MAX + 32, as main() does for
cgroup.subtree_control, avoids the truncation warning.

[ ... ]

> +static pid_t departing(const char *cg, enum depart how, int fd[2])
> +{
> +	pid_t pid =3D fork();
> +
> +	if (pid < 0)
> +		ksft_print_msg("fork: %s\n", strerror(errno));
> +	if (!pid) {
> +		uint64_t t0;
> +
> +		close(fd[0]);
> +		if (cg && enter(cg, getpid()))
> +			_exit(2);
> +		if (set_deadline(0, 400 * NSEC_PER_MSEC))
> +			_exit(3);
> +		t0 =3D cpu_time_ns();
> +		while (cpu_time_ns() - t0 < 380 * NSEC_PER_MSEC)
> +			;
> +		if (how =3D=3D DIES)
> +			_exit(0);
> +		if (set_other(0) || write(fd[1], "x", 1) !=3D 1)
> +			_exit(4);
> +		for (;;)
> +			pause();
> +	}

[ ... ]

> +static pid_t sleeper(const char *cg)
> +{
> +	int fd[2];
> +	pid_t pid;
> +	char c;
> +
> +	if (pipe(fd))
> +		return -1;
> +	pid =3D fork();
> +	if (pid < 0)
> +		ksft_print_msg("fork: %s\n", strerror(errno));
> +	if (!pid) {
> +		close(fd[0]);
> +		if (enter(cg, getpid()) || write(fd[1], "x", 1) !=3D 1)
> +			_exit(1);
> +		for (;;)
> +			pause();
> +	}

[Severity: Low]
If the test runner is killed by a signal or kselftest timeout while
children from departing() or sleeper() are alive, will those children stay
blocked in pause() inside cg_p holding SCHED_DEADLINE bandwidth and
preventing cg_p from being removed?  Using a fork_child() helper with
prctl(PR_SET_PDEATHSIG, SIGKILL), like deadline_switch_test.c and
deadline_bw_test.c do, ensures children exit with the test.

[ ... ]

> +static int test_rebuild(enum depart how)
> +{
> +	int ret =3D KSFT_FAIL, fd[2], err;
> +	pid_t pid =3D -1;
> +
> +	if (pipe(fd))
> +		return KSFT_FAIL;
> +	if (make_partition(cg_p, ncpus - 1)) {
> +		ksft_print_msg("no partition root on CPU %d\n", ncpus - 1);
> +		ret =3D KSFT_SKIP;
> +		goto out;
> +	}
> +	pid =3D departing(cg_p, how, fd);
> +	err =3D departed(&pid, how, fd[0]);
> +	if (err) {
> +		ksft_print_msg("the deadline task failed (%d)\n", err);
> +		goto out;
> +	}
> +	if (make_partition(cg_q, ncpus - 2)) {
> +		ksft_print_msg("no partition root on CPU %d\n", ncpus - 2);
> +		ret =3D KSFT_SKIP;
> +		goto out;
> +	}
> +	/*
> +	 * Wait past the 0-lag time. In the SWITCHED_OUT case the task is still
> +	 * alive then: it sleeps in P as a SCHED_OTHER task.
> +	 */
> +	sleep_ns(1500 * NSEC_PER_MSEC);
> +	ret =3D check_p();
> +out:
> +	reap(pid);
> +	remove_partition(cg_q);
> +	remove_partition(cg_p);
> +	close(fd[0]);
> +	if (fd[1] >=3D 0)
> +		close(fd[1]);
> +	return ret;
> +}
> +
> +/*
> + * Have a task outside P switch to SCHED_OTHER and sleep. Before its 0-l=
ag
> + * time, move it into P and kill it. Then check P.
> + */
> +static int test_move(void)
> +{
> +	int ret =3D KSFT_FAIL, fd[2], err;
> +	pid_t pid =3D -1;
> +
> +	if (pipe(fd))
> +		return KSFT_FAIL;
> +	if (make_partition(cg_p, ncpus - 1)) {
> +		ksft_print_msg("no partition root on CPU %d\n", ncpus - 1);
> +		ret =3D KSFT_SKIP;
> +		goto out;
> +	}
> +	pid =3D departing(NULL, SWITCHED_OUT, fd);
> +	err =3D departed(&pid, SWITCHED_OUT, fd[0]);
> +	if (err) {
> +		ksft_print_msg("the deadline task failed (%d)\n", err);
> +		goto out;
> +	}
> +	if (enter(cg_p, pid)) {
> +		ksft_print_msg("the task cannot move into P\n");
> +		goto out;
> +	}

[Severity: Low]
If make_partition(cg_q, ncpus - 2) in test_rebuild() or enter(cg_p, pid)
in test_move() fails after departed() has succeeded, does jumping directly
to out skip waiting for the departed task's 0-lag inactive timer?  The
next test case in main() would then start while the 400ms/1000ms bandwidth
is still pending removal from the root domain.

[ ... ]

> +int main(void)
> +{
> +	char buf[256], path[PATH_MAX + 32];
> +	int added;
> +
> +	ksft_print_header();
> +	if (geteuid())
> +		ksft_exit_skip("needs root\n");
> +	ncpus =3D get_nprocs();
> +	if (ncpus < 3)
> +		ksft_exit_skip("needs 3 CPUs\n");

[Severity: Medium]
Can picking CPUs ncpus - 1 and ncpus - 2 from get_nprocs() fail when
online CPU numbering has gaps or when isolcpus=3Ddomain is configured?

Unlike deadline_bw_test.c, which reads /sys/devices/system/cpu/online and
/sys/devices/system/cpu/isolated, picks online non-isolated CPUs, and
restricts task affinity away from isolated CPUs, this test assumes online
CPUs are contiguously numbered 0..ncpus-1 and none are isolated.  When
isolcpus=3Ddomain is used (which deadline_bw_test.c requires for many of its
cases), ncpus - 1 or ncpus - 2 can be isolated or offline, and in
test_move() the child spawned by departing(NULL, SWITCHED_OUT, fd)
inherits root-cgroup affinity that includes isolated CPUs, causing
set_deadline() to fail.

Since roughly half of this file duplicates the cgroup v2, partition, and
SCHED_DEADLINE helpers from deadline_bw_test.c in the same directory,
could these helpers be shared (or these three cases folded into
deadline_bw_test.c) so online and isolated CPUs are handled consistently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795116790.gi=
t.mathieu.desnoyers@efficios.com?part=3D5
