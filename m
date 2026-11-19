Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098174;
	b=cJd1J3baX5PdOI74kpZ5ltVorAlKSYFsH2ZuGa9jEuQeD+qUpQpGI7+uVWxo9RSBIShs
	 Vo5t24gP3mluiq+RS0qmHKmA/FbsSKnlZMG0auE/V9hFgK0wqhVz30XQloW2QVOAZfjUC
	 e32M4k1vRlm/X5prKA/JeWgjsPerIR2gaAtjZSIGsRoE217V+iSyxXwBMLScvi4tvZPGo
	 qKmgrRVh9AzX4s/thYicLnnewGiTbQC0gRp1ylqLSnxPouB4m2c+2qtJVXd9WxVXD4iQ1
	 +gntNg/C8MTC2geOMjGui4xa2ykJu6nA6NryheNM9vnHv5fjhaRn+L0FZ3145d3qSQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098174;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mIyBeXxde5GtJ0Hgtl6XBoppR/HmsbeDUlllzG6dqHc=;
	b=zn98xwqH0hQ973CfqxZpVEzuJsPsP7iFr5HnGKibPnx/moCxFd20Wg9WQDjLb6K6UtLK
	 OA07271evr0COic0X9uabNQTTnju2eCSjp+saIXWwam2b68kog5f1yvMvLmJYDCG7ccp0
	 XhVaHjeFFd95NkSr+1qWQBfnu9h6zZUeF4CSdJh+DKxsuQPdblalu8FxEJxoDJ5FmzYpd
	 /PCZZbS55R2z8YTFjxMhi6UgAmuZRKJGBuKfoxc7Bx8nahEJgQ1lVYhVNN41ncOE9EBoT
	 z1hEp5hXUJvtbNrNxIo7Vy3+uOd9k5cD2ANlSUR4KhITOun80z1e/hCcv75uiNJP9lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnLByrUR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA84F606A320;
	Thu, 19 Nov 2026 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnLByrUR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08241F000C4;
	Thu, 19 Nov 2026 14:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795098174;
	bh=mIyBeXxde5GtJ0Hgtl6XBoppR/HmsbeDUlllzG6dqHc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cnLByrURP7TIVNTwP7lvBb28+H02nVe/+ggJFgH+qs+NP9m0szPvhJ52EsiBPagq7
	 EjDFLn9vT6V6Dpa/BM7fB0FNywydKYkP0zf8GHOcx4v6m6aqk3lXM7Nl1lYHb49g/E
	 VPFlzA680GnjhweyNgby1X3iwLvV+v9pp7/Ua1dYSDnB5z64qQm07NrLxOinlMSKUq
	 TuxmderVYV5a9lfXIZYt2m8U4NTb2mpCrIC10xwfoQMfHrLmZcl8Me/dhtKZySUO1C
	 P+MG1VVvZP33uXYh50MKbBYpKbUDZD3zBgbEQMwWN2J/cfBsLtSFgzYS2oleaHKhH9
	 15PfLZ04ruKyg==
Message-ID: <sashiko-outbox-223287@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/17] selftests/sched: Add a test of SCHED_DEADLINE
 bandwidth accounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <cbb59b2e6ec73b9c32cd43ef6ddc8548070a5942.1795092090.git.mathieu.desnoyers@efficios.com>
References: <cover.1795092090.git.mathieu.desnoyers@efficios.com>
 <cbb59b2e6ec73b9c32cd43ef6ddc8548070a5942.1795092090.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 14:22:53 +0000
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
- [Low] selftests/sched: dead code and unused variables in
  deadline_bw_test
--

commit 6221c4626318f0c62cd5eec65b1e903934d1d349
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Add a test of SCHED_DEADLINE bandwidth accounting

This commit adds the deadline_bw_test kselftest to verify SCHED_DEADLINE
bandwidth accounting across priority inheritance, parameter changes,
cpuset moves, task deaths, deadline servers, and CPU hotplug.

Link: https://github.com/jlelli/sched-deadline-tests

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> new file mode 100644
> index 0000000000000..f91eeddceba18
> --- /dev/null
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c
[ ... ]
> +/* The same, for a task that leaves and comes back while it sleeps. */
> +static int return_asleep_new_params(void)
> +{
> +	return return_case(1);
> +}
> +
> +static pthread_mutex_t pi_lock2;
> +static sem_t holder_go;
> +static atomic_int holder_holds, chain_waits, donor_done, x_waits, l2_tak=
es;
> +static atomic_int chain_rank, x_rank;
> +static _Atomic pid_t x_tid, fair_tid;
[ ... ]
> +	ncpus =3D read_online(&online, 0);
> +	nisol =3D read_online(&isol, 1);
> +	if (ncpus < 0 || nisol < 0)
> +		ksft_exit_fail_msg("the online CPUs cannot be read\n");

[Severity: Low]
Several test modes and static variables in deadline_bw_test.c are never
used:

- return_case() and returner() implement modes 0 through 5 (including
  calls to set_constrained() in modes 4 and 5), but return_case() is only
  called with mode 1 in return_asleep_new_params().
- deboost_case() and deboosted_owner() implement modes 1 and 2, but
  deboost_case() is only called with mode 0 in deboost_resets_period().
- refill_case() checks for spin_ms =3D=3D 8, but is only called with 1 in
  deboost_keeps_own_runtime().
- pi_asleep() and sleeping_owner() implement was_dl !=3D 0 branches, but all
  callers pass 0.
- fair_tid is only assigned 0 in pi_init_lock2(), sleeper_cpu stays at -1
  (making the sleeper_cpu >=3D 0 block in dl_sleeper_tid() unreachable), and
  isol and nisol are populated in main() via read_online(&isol, 1) and
  never used or freed.
- MV_YIELDED in mover(), struct hp_case::no_hp, and the forward
  declarations of wait_spinner(), hold(), and release_held() are unused.

Were these extra modes meant to be wired into p_cases[], or should the
unused code be dropped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795092090.gi=
t.mathieu.desnoyers@efficios.com?part=3D17
