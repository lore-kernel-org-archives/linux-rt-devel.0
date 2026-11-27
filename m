Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792590;
	b=E/EWmXd3IfjQbTpjSxCNUr57guEzn53AnvCoSmFEia/2N3ylnVdoHFumBwYwsu/AVMDf
	 VVXwK8jghgY40zcvq9SoISuM/Xa508vqPvMqJ/oZa75sRoBjYQkSYzf1AW5MAfukkj9Ht
	 V13d5TnUycOlyEChrmjkth9kzP48paxPIOumqXjUFqyt4rd4qztC2R++SM1UE6gBQvU2l
	 nEx+xLbAtSXr0dGV/BaayTZmHDCe4ZcVBmSJIcO4NPIMtVzjgGB0i2BQqy8n6Lu3WZ7Vy
	 lH5L3GS4oj3zlRA1Bb4V88EfuehIQGk2AUVx5NviieU3a326mPR6w7wBLQJso0h1JtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792590;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dgJZTPaA1xCyR1CAanM00Ab+ro9AcSUSjh91Z30F8k0=;
	b=4BEm/WU6CJHIma7lOWwp75P7RR+Uo1ByJYsK+5jkRC0dYJffhiJK5NjOyVwJqqdqh+In
	 osANQqRlzm9PNGlSkxAtrxT/mOMLsG1NNfzvnFfiZGZrTK6Y+WXLuAyHLDOU4pZRgXlvU
	 3Ni0z0xbDZ8M3g3/cTnhFZAC7cdkoBBjkEQxROh/gl4WiCU0YRxg8pmzFqL7KS94G/Wva
	 ebKUGkzz2ZTChLjUfR0M+RcO43XO9V7AUGs4XUv1txsvRpGi1g1GP++UqIA0HGNC5rVea
	 mcJ939HpGkq812ShA6Lya6iKm6AWxD8XF0Vs3jjFtNhN9jMlQGUCddqQ4r/kH/hEMzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="j/iBty8x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCA69606A31C;
	Fri, 27 Nov 2026 15:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j/iBty8x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F31D1F00919;
	Fri, 27 Nov 2026 15:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792590;
	bh=dgJZTPaA1xCyR1CAanM00Ab+ro9AcSUSjh91Z30F8k0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j/iBty8x0EpvKvIeIsyj9MhiFYACeQqdyKXb/8Ss01MOlkRIUj/G60rwP0YN1t9+6
	 8FRzJZxVIeNv3HuSMPLct0dPCu/SVVYjxFXvWMAP+sG56dLXg/L1fe5fzO+AWnOHjf
	 scjFl7/a2I9QkVTX2/g3IUPBGDuowQ1V6XoNliw1fRFdhdFhGBjF8gBBaYKA4hRgnd
	 Tcd1doZN40+4IhTVjgu6J2zlvIHC4TtttAkeLChJnBwdVCLpeu0m6EEex438tUrnV+
	 dKeaT+tlAlSF4njkUhn4YwqlgG04WIOGoDcE4HBVkka9/eEFt5MpjQtUGgkkt9Gj6B
	 +gs553vh7pvTw==
Message-ID: <sashiko-outbox-237690@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/43] selftests/sched: Test SCHED_DEADLINE
 bandwidth across a root domain rebuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <9da289721a288519b45703f0f23fe09cbf6d2dac.1795771147.git.mathieu.desnoyers@efficios.com>
References: <cover.1795771147.git.mathieu.desnoyers@efficios.com>
 <9da289721a288519b45703f0f23fe09cbf6d2dac.1795771147.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:16:26 +0000
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
- [Low] selftests/sched: SIGKILL before set_other() in reap() leaves DL
  bandwidth
--

commit 0894b84fdb5ad0556ac423d675bc233e094e30da
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Test SCHED_DEADLINE bandwidth across a root domain rebuild

This commit adds the deadline_rebuild_test selftest to verify that
SCHED_DEADLINE bandwidth from tasks that exit or switch out before their
0-lag time is properly tracked across root domain rebuilds.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_rebuild_test=
.c b/tools/testing/selftests/sched/deadline/deadline_rebuild_test.c
> new file mode 100644
> index 0000000000000..735c3c65e156a
> --- /dev/null
> +++ b/tools/testing/selftests/sched/deadline/deadline_rebuild_test.c
> @@ -0,0 +1,587 @@
[ ... ]
> +static void reap(pid_t pid)
> +{
> +	int status;
> +
> +	if (pid <=3D 0)
> +		return;
> +	if (kill(pid, SIGKILL) && errno !=3D ESRCH)
> +		ksft_print_msg("kill %d: %s\n", pid, strerror(errno));
> +	/* Ignore the result: the task may be dead already. */
> +	set_other(pid);
> +	while (waitpid(pid, &status, 0) !=3D pid) {
> +		if (errno =3D=3D EINTR)
> +			continue;
> +		ksft_print_msg("waitpid %d: %s\n", pid, strerror(errno));
> +		break;
> +	}
> +}

[Severity: Low]
Can calling kill(pid, SIGKILL) before set_other(pid) leave the 600ms/s
bandwidth of task 'a' from check_p() allocated past the end of the test
case?

In check_p(), task 'a' is switched to SCHED_DEADLINE while sleeping in
pause(), so its deadline and runtime are still 0.  Waking it with SIGKILL
before switching it to SCHED_OTHER starts a new deadline period on cpu_p;
if task 'a' runs for any non-zero time before set_other() or do_exit()
dequeues it, its 0-lag time becomes positive and its 600ms/s bandwidth is
held until the inactive timer fires.  Because test_rebuild() sets ran =3D 0
before calling check_p(), it proceeds directly to the next test case
without waiting for that timer, which can cause the next case's 400ms/s
admission on cpu_p to fail with EBUSY.

Calling set_other(pid) before kill(pid, SIGKILL) switches the sleeping task
back to SCHED_OTHER while its deadline is still 0, releasing its bandwidth
immediately.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795771147.gi=
t.mathieu.desnoyers@efficios.com?part=3D5
