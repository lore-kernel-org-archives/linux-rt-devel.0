Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795120039;
	b=Vc6MtamNutees9hnKf7o57P9LmQTTXHJq7GtNx/UoWDwdUJ7Xp7lMPVxJbkxeXEwizve
	 gCNSANYR4sLdCpAKCqM8D+D+aQoanSOTkI9zTlL3EnRxgsjuY5yXCcfITUvUoP/3XL8rz
	 J0Ix1x4JH5TDs51G5bi+OYEV+PSJqamK/M5A+pNYIqkFjAtchzzV/Oyiyb0lIneQZqAFZ
	 xMDUSYwAqGweoweIz3fxSKxhxUbC9Ta5Up1SiRxGRyjR5ggcaTsE9JpxwqiOB3/lOgY/s
	 E949fB3/l/K8NXIAgqVX+mvPck2BfuJ4nnaN5Ge9V5KuxQkyb0k4cdSE3ZQej2jMHJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795120039;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X0sq3NCP6gP8rOY8UXacpSPRSCgofFU5/Js5Ndqgb3c=;
	b=YRvjA8BTJnjLqPA5quUuUfmWn6ku7esbcxTroIIl1earwa4B2gODlaHs50AQ8Kb8PTnG
	 oPU9A/DdKT3eF2fXq0je1frRFFSKYH3tXr9LWrd16gihfrh6Cr9embkwnHzCe3Aye9Hir
	 d7VQGE3LGZTazG159lWo4AgqBrGufWDpr909EZ0B4pnh6Zkm2ygMb8X3qWGNODxV+uRuv
	 SPkurUEVNgYiLhe+XsgDnqlPRDG7Zc/6jyJxQphDuBwWfJyaIRiVUermd+sX1G8cPjCly
	 SDakGdc7c5hTBYXnjiL+nX2ftN7AlSkk8AtL5L8DEplJ2Wsdt0lWPWPJleareFgtDdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNAtUQEa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510FA606A332;
	Thu, 19 Nov 2026 20:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNAtUQEa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51041F000D3;
	Thu, 19 Nov 2026 20:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795120039;
	bh=X0sq3NCP6gP8rOY8UXacpSPRSCgofFU5/Js5Ndqgb3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HNAtUQEaX8GKXCMWOymspt+4f52XgDnSKULY1iMgKJ0NUk4J804ZXq8NBnwW7KbJ1
	 3oe1c3kFDxsS1dpXYEEduHFPSlAYizpglcWFQ87lSGDdllK1ff7mcOqLULgaSw5hUV
	 Cd0e+aYHyc6mHKHc18Feij+b53W0ZaFI/C+rRTrg3FHTAh54LpQ+VGmP7Fbx4+zBPE
	 CI8tZ0coyhB/ezaKH3ApY/8M/zH7VXSdl1z0S+fdngOpZsF2AXmbOsE6SnVaaeozha
	 tg2eaqGyo/cuty187FLPBtyna2hRiMaGYBU2eWQ4vUlxUpt7cgF7OH6m6ryjExgGKi
	 wbU0KlvyjgpUA==
Message-ID: <sashiko-outbox-224019@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 18/33] selftests/sched: Test the root domain of a
 task in deadline_bw_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <55480cfbc5c82f022d2f7c4d1ac721ea50e5dfe3.1795116791.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
 <55480cfbc5c82f022d2f7c4d1ac721ea50e5dfe3.1795116791.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 20:27:18 +0000
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
- [Low] selftests/sched: missing 0-lag sleep on goto out in
  hotplug_dead_accepted()
--

commit 18c7a84e3237184ed7ce53936729cf7fbe932760
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Test the root domain of a task in deadline_bw_test

This commit adds 24 test cases to deadline_bw_test covering how a deadline
task stays in the root domain that accounts for its bandwidth across CPU
hotplug and cpuset changes.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> index fa1ff62d6f42f..a290e332831d6 100644
> --- a/tools/testing/selftests/sched/deadline/deadline_bw_test.c
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c

[ ... ]

> @@ -7014,6 +7562,1368 @@ static int move_back_cpu_offline(void)

[ ... ]

> +static int hotplug_dead_accepted(void)
> +{
> +	int fd[2] =3D { -1, -1 }, err, cpu, ret =3D KSFT_SKIP;
> +	long long def0, hk0, def, hk;
> +	uint64_t t;
> +	char buf[64];
> +	pid_t pid =3D -1;

[ ... ]

> +	pid =3D task_from(fb_h, 1, 100 * NSEC_PER_MSEC, NSEC_PER_SEC, fd[0]);
> +	if (pid < 0 || child_up("hotplug_dead_accepted", 0) ||
> +	    wait_for(1000, proc_state_of(pid) =3D=3D 'S'))
> +		goto out;
> +	err =3D enter(cs_b, pid);
> +	if (err) {
> +		ksft_print_msg("a move into B refused: %s\n", strerror(-err));
> +		goto out;
> +	}
> +	if (fallback_totals(&def, &hk))
> +		goto out;
> +	cpu =3D task_cpu_of(pid);
> +	if (cpu !=3D fb_h || def !=3D def0 || hk <=3D hk0) {
> +		ksft_print_msg("in B on CPU %d: total_bw %lld, %lld\n", cpu, def, hk);
> +		goto out;
> +	}
> +	if (write(fd[1], "x", 1) !=3D 1) {
> +		ksft_print_msg("write to the deadline task: %s\n", strerror(errno));
> +		goto out;
> +	}
> +	t =3D now_ns();
> +	if (wait_for(1000, proc_state_of(pid) =3D=3D 'Z'))
> +		goto out;
> +	if (now_ns() - t > 500 * NSEC_PER_MSEC) {
> +		ksft_print_msg("the task took over 500ms to exit\n");
> +		ret =3D KSFT_SKIP;
> +		goto out;
> +	}
> +	sleep_ns(10 * NSEC_PER_MSEC);		/* past do_task_dead() */
> +	err =3D cpu_online(fb_h, 0);
> +	if (err) {
> +		ksft_print_msg("offline of CPU %d under a dead task: %s\n", fb_h,
> +			       strerror(-err));
> +		goto out;
> +	}
> +	reap(pid);
> +	pid =3D -1;
> +	cpu_up(fb_h);
> +	sleep_ns(NSEC_PER_SEC);			/* past the 0-lag time */
> +	ret =3D totals_check("task gone", fb_i2, fb_h, def0, hk0);
> +out:
> +	reap(pid);
> +	cpu_up(fb_h);
> +	if (fd[0] >=3D 0) {
> +		close(fd[0]);
> +		close(fd[1]);
> +	}
> +	cs_cleanup();
> +	return ret;
> +}

[Severity: Low]
Does jumping to out after the 1-second-period deadline task has run (such
as on the 500ms exit-time KSFT_SKIP path or if cpu_online() fails) return
before the task's 0-lag time expires?

Because hp_cases[] run sequentially without rebuilding root domain
accounting, the dead task's bandwidth remains in the housekeeping root
domain's total_bw when the next test case reads its initial baseline hk0,
causing a false failure once the 0-lag timer fires during that test.
Moving sleep_ns(NSEC_PER_SEC) after reap(pid) and cpu_up(fb_h) in the out
block would wait out the 0-lag time on skip and error paths as well.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795116790.gi=
t.mathieu.desnoyers@efficios.com?part=3D18
