Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209323;
	b=Y1pQYtlk4fZP5oHp1EyYfjaC1pbJ5BChoiA6B4Mm3vIW7HCJsMkhwoGjcEeq8xrYQqjm
	 yjzacymlsTnxaLWthYX/4ydZQk9xWRgTmoiDy3AA/EUZ3fqAxdl590eZ6F7mHUyY69FCw
	 qkwB2ocz7feJbUt+jI6d1bGcct0Vq/9HjwyS8kfKcF+kNgoQg/hylW5coJpO2E0QHDl79
	 o+W+4vzVf/MgYPtbr6RR2Jj87xy1CLqMIOg5VG5E+MQgdQx6L9eJ9v8qwrhMEP02VrfSm
	 XquaGTeCZB+tbbDG1CuKDhPEuLVcxoIYDxXrziPF8shBbqAHIjC7zv7F7683ib0g8+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209323;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JBmJkvgaEVsfIZUUww3wSsP5Wyw2CcKE6sSchPV2ZSI=;
	b=kZ8uilZc44aV7cosJLJXrB2HTAATOMWDovXLYRsSDofK78HFCGFCu/z/Lu1HLXc1N5yl
	 JxGyRl/eu1PS0MhhPsyn86/mRDm2mxDn6x6xyD5y9GgXWFNocQd7ZSVfcSTMl1VKQmmVx
	 4vwyi01nLKjCsCtPhcV/c8SvF7xSyiSMAWjYq6rEYELo4khFoKTaZKsrULF9JQUGuxVWJ
	 ZpwqsFdCaxYCiBDWg9AOPSw9vION1B0XErR3ZpLfwyKHYBL1sadyLJgk6BVsySr00mCGL
	 TRNEL57AgKO2YHSRNrSZ0fOskpGqntBjnBJtZCxdLOznSbJYo0/JRyYxCxc7OI2j8SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TcrlczJf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B489606A338;
	Fri, 20 Nov 2026 21:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TcrlczJf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7EA1F000CA;
	Fri, 20 Nov 2026 21:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795209323;
	bh=JBmJkvgaEVsfIZUUww3wSsP5Wyw2CcKE6sSchPV2ZSI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TcrlczJfsoHOsaWB2T6gR1guMTLq1A/0gy0Sb2kARA5jIXHh2Z3BNpWx7weL3U+4V
	 vOC+u5hyEyO+MATHkGFTPq9uJQjX1Psd35cbyjb3Ywj0VnSAChEyjY58+zRVGTKWjv
	 OSZD7stcYx1yjHsRXJv01MV6G7sQHrHN3x3PlRHRLlr+nybHKVH3z7VZZgfP/ZHnlx
	 FgXENlkRmpZ3TE0PLIni9Dk48AQRJW28Te5v2tA/brgswRcU0MWu9EI0NI84HdGYQk
	 x5CpVTaUjKoO0jgwcKCxzdO99V7ACb1KeME43ong5JSU06Nkj3Z6woPIPoy1kZjkW4
	 RRUBgQ3BnYQNg==
Message-ID: <sashiko-outbox-226150@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 40/40] selftests/sched: Share the helpers of the
 deadline tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <62c694b97d7fdffabae640eb6dee797eceb3701c.1795207233.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <62c694b97d7fdffabae640eb6dee797eceb3701c.1795207233.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:15:22 +0000
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
- [Low] selftests/sched: Makefile pattern rule shadowed by lib.mk
- [Low] selftests/sched: orphaned now_ns() comment and duplicate
  cpu_time_ns()
--

commit 152ce0e30fc3ab83803e1441c43fe57ed1ceba20
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Share the helpers of the deadline tests

This commit extracts duplicated time, file I/O, cgroup, and reporting
helpers from deadline_bw_test, deadline_rebuild_test, and
deadline_switch_test into a shared deadline_util.h header.

> diff --git a/tools/testing/selftests/sched/deadline/Makefile b/tools/test=
ing/selftests/sched/deadline/Makefile
> index 15f1e96a21e6f..c7a665a02d6f9 100644
> --- a/tools/testing/selftests/sched/deadline/Makefile
> +++ b/tools/testing/selftests/sched/deadline/Makefile
> @@ -6,3 +6,6 @@ LDLIBS +=3D -lpthread
>  TEST_GEN_PROGS :=3D deadline_switch_test deadline_rebuild_test deadline_=
bw_test
> =20
>  include ../../lib.mk
> +
> +$(OUTPUT)/%: %.c deadline_util.h
> +	$(CC) $(CFLAGS) $< $(LDFLAGS) $(LDLIBS) -o $@

[Severity: Low]
Does this pattern rule ever take effect?

lib.mk already defines "$(OUTPUT)/%:%.c $(LOCAL_HDRS)".  Because the
prerequisite patterns differ, GNU Make keeps both rules and always matches
the earlier one in lib.mk, so editing deadline_util.h does not trigger a
rebuild.  Setting "LOCAL_HDRS +=3D deadline_util.h" before including lib.mk
instead of adding a second pattern rule registers the header with lib.mk's
rule.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_rebuild_test=
.c b/tools/testing/selftests/sched/deadline/deadline_rebuild_test.c
> index 85b24b868da72..7b0609e8e6edd 100644
> --- a/tools/testing/selftests/sched/deadline/deadline_rebuild_test.c
> +++ b/tools/testing/selftests/sched/deadline/deadline_rebuild_test.c
[ ... ]
> @@ -91,22 +93,6 @@ static int set_other(pid_t pid)
>   * Return the CLOCK_MONOTONIC time in ns. clock_gettime() cannot fail: t=
he
>   * clock is always supported, and the pointer is valid.
>   */
> -static uint64_t now_ns(void)
> -{
> -	struct timespec ts;
> -
> -	clock_gettime(CLOCK_MONOTONIC, &ts);
> -	return ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;
> -}
> -
> -static void sleep_ns(uint64_t ns)
> -{
> -	struct timespec ts =3D { .tv_sec =3D ns / NSEC_PER_SEC, .tv_nsec =3D ns=
 % NSEC_PER_SEC };
> -
> -	while (nanosleep(&ts, &ts) && errno =3D=3D EINTR)
> -		;
> -}
> -
>  static void reap(pid_t pid)

[Severity: Low]
This isn't a bug, but removing now_ns() leaves its comment attached to
reap().  Also, cpu_time_ns() in this file is identical to thread_time_ns()
in deadline_util.h and could be replaced by it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D40
