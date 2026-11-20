Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208763;
	b=jI5Kcbj4YvHGpu6LKw/XalXW11JUWAkeU0qTHkLDp0vC+ZJHpGnuSJDUTeh8LFhs9XT8
	 OF+gfrPevNeRbp2iQ5+UIFg0XA6W95FvCF5pi64u4FHno3+KqJnu9F8U5ZlmC18gNxCgn
	 yuxgv6MJQ16fpluY07zj9g70Az4SPKW9GemhnJ1t97u0N4mJzdRrAwKzU0PBQRUgvhwIf
	 zF2huH+6ikL2TpFREDpdclU8o/rJtpZ5KE5UBA9pCZzVrtCIyhJTzyCV+b+r7X/Y9nzKX
	 Qa8MIVe7ritTSFxfUCn6FkdZJqwwD2DrJY/lxcUuYmgS6vsZ8foZ1udKfgKhpPi6Ecg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208763;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VqDIlQyAzY8kK+qViAPCwaJa5GOhXYAFQJ40ugDcBWk=;
	b=p0Y8teDqBy8G/p7L+Rd7t40us+BFF/mgANutn3Ob8TdtzVUIVhCe/LXCjQTdOxxcShYD
	 mj9iwUy/FGFiANBEmlA8U7LzW//+wc+QVQMhOnUycV9i5UfXwcPEEj6OYa9ephzEJHPJD
	 0My2+WXv+9JFBQ0IywvnJNYa6EE7JumtxmBxektNzU60V9viWH/TC/bYilsmJQ9RdGfy5
	 1pQWoxjZdYV7xHr/+qUIsBbDbb11l27/gjyrANKUfOXoZxVqTLk1VKQfA5Y9mrBYPmqyR
	 yxjvkYXUyJc5HaWMcJ5pbXPT257TgMY5Wh7Yc8qEmjty8qX48SrSJB6UZ1KfRnGzG2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKdPbunl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCF6606A33E;
	Fri, 20 Nov 2026 21:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bKdPbunl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06FC1F000C6;
	Fri, 20 Nov 2026 21:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795208763;
	bh=VqDIlQyAzY8kK+qViAPCwaJa5GOhXYAFQJ40ugDcBWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bKdPbunlLcN6/x1b+7MkZW0nDybVKhIlsUk6SsQcRazCjm3bYO+QgYkD9cCw2hqwo
	 6pHXbpLOKuEnI5KMW7ecT29q8iO14LEkXhEeyK5fo5Ezxa8mev2VoGosDu/kkGRXfC
	 n6c2hF3lig7vbHM7SzUVDxOCHaqx9LTBT6xd975D9AEnI0x1pwMY0fKpMu5o9wsfYs
	 jZ4QNDdUKaUnffLFPsM2hOQaEIoPq7XNMPTKQg2AKv57k/54gIGKu6GKqh73nzAQAQ
	 HRRbLsms4XdxzS3cYFYSD9vL3InQktOvFJfwxb4KjkWWq78TgXWI0BRrAHL0x1hUlp
	 jhkHyhP+TGyAw==
Message-ID: <sashiko-outbox-226127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 24/40] selftests/sched: Test the rtmutex chain walk
 in deadline_bw_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Cc: linux-rt-devel@lists.linux.dev, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-kernel@vger.kernel.org
In-Reply-To: <bd1d884143e64a1d5fc73e8af268af995627dc54.1795207232.git.mathieu.desnoyers@efficios.com>
References: <cover.1795207232.git.mathieu.desnoyers@efficios.com>
 <bd1d884143e64a1d5fc73e8af268af995627dc54.1795207232.git.mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 21:06:02 +0000
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
- [Medium] selftests/sched: top_moves() fails instead of skipping
  without RT runtime
--

commit 6100a36909c549fb0079a550f7245c5c073ca05e
Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

selftests/sched: Test the rtmutex chain walk in deadline_bw_test

This commit adds the pi_chain_top_moves and pi_chain_top_moves_rt test
cases to deadline_bw_test to verify rtmutex priority inheritance chain
walks when an owner's top waiter moves to another lock it holds.

> diff --git a/tools/testing/selftests/sched/deadline/deadline_bw_test.c b/=
tools/testing/selftests/sched/deadline/deadline_bw_test.c
> index 7b0a3f2fb12b8..cf3b49cf2be28 100644
> --- a/tools/testing/selftests/sched/deadline/deadline_bw_test.c
> +++ b/tools/testing/selftests/sched/deadline/deadline_bw_test.c
[ ... ]
> +/*
> + * W and Z: W blocks on L1', Z on L1. @arg is 1 for W. With top_rt, W
> + * becomes SCHED_FIFO 50 and Z SCHED_FIFO 20. Otherwise W becomes a
> + * deadline task of 2ms every 80ms and Z one of 5ms every 200ms. The main
> + * thread switches W to SCHED_OTHER while it waits.
> + */
> +static void *top_waiter(void *arg)
> +{
> +	int w =3D (long)arg;
> +	struct sched_param sp =3D { .sched_priority =3D w ? 50 : 20 };
> +	uint64_t runtime =3D (w ? 2 : 5) * NSEC_PER_MSEC;
> +	pthread_mutex_t *l =3D w ? &top_lock : &pi_lock;
> +
> +	if (top_rt ? sched_setscheduler(0, SCHED_FIFO, &sp) :
> +		     set_deadline(0, runtime, 40 * runtime)) {
> +		top_err =3D 1;
> +		return arg;
> +	}

[Severity: Medium]
Should top_moves() return KSFT_SKIP instead of KSFT_FAIL when
sched_setscheduler(0, SCHED_FIFO, &sp) fails with EPERM?

pi_chain_top_moves_rt runs with MEASURED_IN_P inside child cgroup P.  When
CONFIG_RT_GROUP_SCHED is enabled and the cgroup v2 cpu controller is active
in the root cgroup, child cgroups have no RT runtime, so
sched_setscheduler() returns EPERM and sets top_err =3D 1, failing the test.
Other SCHED_FIFO tests in P check for EPERM and skip:

tools/testing/selftests/sched/deadline/deadline_bw_test.c:server_client() {
	...
		if (rt && sched_setscheduler(0, SCHED_FIFO, &sp)) {
			/* With RT group scheduling, P can have no RT runtime. */
			if (errno =3D=3D EPERM)
				mv_state[6] =3D 1;
			_exit(1);
		}
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795207232.gi=
t.mathieu.desnoyers@efficios.com?part=3D24
