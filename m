Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929025;
	b=Nk3VMbIGnwjNLrI+Gzyva0ZwYyYkvyVZDDKDm6Y91QKp4AmlYKxPcFlpWCrNET9pWvvc
	 pLcLT0P1SXZ/WdWxDDFzqoBoSTJ35V5om7TDaY+3LYHApAhIyOg5iRehO7xhjzZIkpJ2h
	 XRBcVkcZWia+UvWOgTK14HBqOZtrLMmY+1RKCBN+HtaKAAwqmHScOEXMcFdgtScjYBXP1
	 1YT6cEdi4M1qqv1D4Egx0i1tNDoP8QBA04BfPNVmMGPL1YF+vq08ec1up8rFO/7jhJzUw
	 w+VGH8tqOaQxV72Qk7Ydo0TpJrYz/2fBbI1de7u8ovDBb7zlA3gNGjmSZ8dsI7j9bKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929025;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mSX7nUXRaAIFnfD43d+7mLEk80OZ6gLg3zuHdBHTOJ0=;
	b=HcmGm8hql8z5X8Q0voX8EnTy8OtXn1D9kT8nmNiTpZdIByTjbjLYpjGytbbdfdGIvLFH
	 mv4oNbaSTJW5s1OXl7oSgTaY/8C5qXr7eOTy9C5zEQdYV10/lItFLTfQC9EantMbg+eT7
	 EBQ/X+U0a+mUZBeaCSNsPzBUOsEE5s/9+OyE+361Awtve9YeqCy3zGs4lY3zbk8EjZFmK
	 SjP+nN5uXfHNbXObNIOng0cxSuEm/nRn/dnNwOIpY5RoFFzpEcxUnkaPIXnd6SuawbqTV
	 +Vb3Zfdq8XQGk/VSBb06+nK1T291xKucY+PUTMPTHNWfWDc3CvG7rM4RM0PTf8E+YpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uu0e1rS2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB236606A881;
	Tue, 17 Nov 2026 15:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uu0e1rS2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C501F000C5;
	Tue, 17 Nov 2026 15:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929025;
	bh=mSX7nUXRaAIFnfD43d+7mLEk80OZ6gLg3zuHdBHTOJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uu0e1rS274Qqeja5yvHqcX4UjyGrDcWcLKBaJgPRGwRrJZJgtwH6NCUq67GHKzHqT
	 hbbaAoGXm3ayaJD8N/IiIatCodLgZkNEt+DQLfZ6LGi32uNZVa1047zyBTX3GZn3PB
	 zZtxqxTDt7RY4DT5GdZWr9adac5O5z0HzQG8KWqX5suSdfdIqHqFJC6v0688eJGBQ/
	 xArs92azFmC8YnB9F+Lr6mw/O8b3h7eJd8m8ylX/Cy9MkWb7Zsi4BQIL/BqgZhcbZ4
	 P61iglUwiNPfkaKp5xew2wvMZjbQ2FjS+4T4/2ziWzCsc+TyfS6t5/M9lqv4/zyGKF
	 HqgqRX6bPxlLQ==
Message-ID: <sashiko-outbox-219058@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 38/40] selftests/sched: Add a test of SCHED_DEADLINE
 policy round trips
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <eb355ec19fcfcffd3e7f8dbd79dff377581a7a87.1794922146.git.mathieu.desnoyers@efficios.com>
References: <cover.1794922146.git.mathieu.desnoyers@efficios.com>
 <eb355ec19fcfcffd3e7f8dbd79dff377581a7a87.1794922146.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 15:23:44 +0000
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
- [Medium] selftests/sched: 64 KiB FILLER_STACK fails
  pthread_attr_setstacksize()
- [Low] selftests/sched: missing sem_destroy() and pipe leak in
  deadline_switch_test
--

commit 84b080b4abc565be69cf0d196565fbf11ac9aa91
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Add a test of SCHED_DEADLINE policy round trips

This commit adds a new sched/deadline selftest covering SCHED_DEADLINE
policy round trips to SCHED_OTHER and back, as well as sysrq-n
normalization with deadline tasks and priority-inheritance lock owners.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_switch_test.=
c b/tools/testing/selftests/sched/deadline/deadline_switch_test.c
> new file mode 100644
> index 0000000000000..daf10f81cb968
> --- /dev/null
> +++ b/tools/testing/selftests/sched/deadline/deadline_switch_test.c

[ ... ]

> +static int test_sysrq_boosted_owner(int normalized)
> +{

[ ... ]

> +	if (sem_init(&owner_locked, 0, 0) || sem_init(&owner_go, 0, 0)) {
> +		ksft_print_msg("sem_init: %s\n", strerror(errno));
> +		ret =3D KSFT_FAIL;
> +		goto out;
> +	}

[ ... ]

> +out:
> +	close(fd);
> +	pthread_mutex_destroy(&pi_lock);
> +	return ret;
> +}
> +
> +#define FILLERS		2048
> +#define FILLER_STACK	(64 * 1024)

[ ... ]

> +static int test_sysrq_running_owner(int normalized)
> +{

[ ... ]

> +	fill =3D calloc(FILLERS, sizeof(*fill));
> +	if (!fill || pipe(filler_pipe) || sem_init(&owner_locked, 0, 0) ||
> +	    sem_init(&filler_ready, 0, 0) || sem_init(&waiter_go, 0, 0) ||
> +	    pthread_attr_init(&fa) || pthread_attr_setstacksize(&fa, FILLER_STA=
CK)) {
> +		ksft_print_msg("setup: %s\n", strerror(errno));
> +		free(fill);
> +		close(fd);
> +		pthread_mutex_destroy(&pi_lock);
> +		return KSFT_FAIL;
> +	}

[Severity: Medium]
Does pthread_attr_setstacksize(&fa, FILLER_STACK) fail with EINVAL on
architectures where PTHREAD_STACK_MIN is larger than 64 KiB, such as arm64
and powerpc64 (128 KiB)?  That causes test_sysrq_running_owner() to fail
during setup on those architectures.

Also, pthread_attr_init() and pthread_attr_setstacksize() return an error
number directly without setting errno, so strerror(errno) reports a stale
errno (typically "Success"), and this error path returns without closing
filler_pipe or destroying fa.

[ ... ]

> +out:
> +	close(filler_pipe[1]);
> +	for (i =3D 0; i < started; i++)
> +		if (join(fill[i]))
> +			ret =3D KSFT_FAIL;
> +	close(filler_pipe[0]);
> +	sched_setaffinity(0, sizeof(old), &old);
> +	pthread_attr_destroy(&fa);
> +	free(fill);
> +	close(fd);
> +	pthread_mutex_destroy(&pi_lock);
> +	return ret;
> +}

[Severity: Low]
Should test_sysrq_boosted_owner() and test_sysrq_running_owner() call
sem_destroy() on owner_locked, owner_go, filler_ready, and waiter_go during
cleanup?  Without sem_destroy(&owner_locked) in test_sysrq_boosted_owner(),
test_sysrq_running_owner() calls sem_init() on an already initialized
owner_locked semaphore, which is undefined behavior in POSIX.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794922146.gi=
t.mathieu.desnoyers@efficios.com?part=3D38
