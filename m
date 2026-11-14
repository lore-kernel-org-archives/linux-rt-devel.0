Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794617889;
	b=tMEuaX6PaLvzHfAREKf7dUvkatK0ys/5ljRTQTPPLyHyp8K3row51Lm0uSyIwX8FCZEM
	 vvzEsbMnKpvmMzkNCj/uChsPOHKzOD9s/pvfxl8NyLr41diGx16bL+qE1jTRqgXU+ICJX
	 BO2sKWVL5yW7F94Y9WNz8Qp1mMWhK+wEfit7WCdVqmA9Q+1o7oq/LElomjwQX89fxWeUa
	 DAvZKDDRq8Y3tQB24NS9ZF/N/3Ql5hJOzDldBoBAl5Dg6vdwRVc+JuViFqGsUFQVn5ydu
	 jrq0Ied1sAO8V9Ydi40ShF6vbR4wdIO55zIyt3UL8n3vPeI6jApI4QD3eZvGT8g4/VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794617889;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e6v85ZIraoazHNUXlppbNvMaQtRUkcnjO47mUt/ObK4=;
	b=2gqjD6MLWABAOznaZM2XLaLiv5cdTIZt5nDd5n93RMx0MtncHEbGSRTtq2hd/eRMTUNJ
	 kmrLLua66yTYqQj3wpNtA323gHT3hmCyRjovIg+kZPO8AxiObu/HwKCSt/xDKbxMOVny8
	 T5mBNu8F/5bHYscGM7GX8Chw1t8QqLJmERm1pys9wYqoSRrO6xftbdZNQHNUa4i0YyAd2
	 J+6u0Qnm9v9giJ39N6Ny9ojMnmUlNRNKf97yO+L/Hqgaf5GRyt67KYGJZlEsGmShS/zxG
	 W5+is9Cq6hZ7GkuoOuzLKS7jhwf1OxjGjd+GU2jwEyGggDJHHnOqDdf49XpG6g011GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjRHhCzq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E75A606A327;
	Sat, 14 Nov 2026 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NjRHhCzq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BDF1F000C4;
	Sat, 14 Nov 2026 00:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794617888;
	bh=e6v85ZIraoazHNUXlppbNvMaQtRUkcnjO47mUt/ObK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NjRHhCzqCqwn4pLLjyzB4k6IsrOh/9FcVvjgoExmVwNF3521Ionpd2FVlV1Jc7dh6
	 VkEMsPgR454Emf524k4jSRmVT+Fh+jn8VUFXodwbwTY2VF8IhVKBU4vg3I80XxaAcR
	 B8ux5cKoCQsYssG9Zwee52Ve51arMezf/Ytbw56LCw6/ShNhGpkPAD8TlrWmMyYuFn
	 iteQPZQvTMkLHxu3AzAsRk7RSvF1/xJG60E9QgI4xrCEwmGJGu2ldgFa2AuNh3t7YA
	 DZZW9HDLHeSvAOTgmTW6QZWNaRZyD0t3P1RZ7ImHLzf87OfpM2PbUsOQ6thcnsXjoY
	 e9j+y/8i61Dxw==
Message-ID: <sashiko-outbox-213970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for-v7.5 12/14] rcutorture: Enable RCU_BOOST where
 supported
Reply-To: sashiko-reviews@lists.linux.dev
To: "Joel Fernandes" <jfern@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261113005747.2977123-13-jfern@kernel.org>
References: <20261113005747.2977123-1-jfern@kernel.org>
 <20261113005747.2977123-13-jfern@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 00:58:08 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] rcutorture: promptless RCU_BOOST default y breaks
  BUSTED-BOOST negative test
- [Medium] rcutorture: unintended rcu_torture_boost() activation in
  NOCB01 and NOCB02
- [Low] rcu: Kconfig exposes RCU_BOOST_DELAY prompt when RCU_EXPERT=3Dn
--

commit d21fbe9cdf60a4b081f0f993ea961ee602b93a2c
Author: Paul E. McKenney <paulmck@kernel.org>

rcutorture: Enable RCU_BOOST where supported

This commit drops the RCU_EXPERT dependency and prompt from RCU_BOOST so
that it is automatically enabled whenever RT_MUTEXES and PREEMPT_RCU
(or PREEMPT_RT) are enabled, and removes CONFIG_RCU_BOOST=3Dn from
rcutorture config fragments.

> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index bc9483c0b5d84..7b605fa1f576e 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -237,17 +237,15 @@ config RCU_FANOUT_LEAF
>  	  Take the default if unsure.
> =20
>  config RCU_BOOST
> -	bool "Enable RCU priority boosting"
> -	depends on (RT_MUTEXES && PREEMPT_RCU && RCU_EXPERT) || PREEMPT_RT
> -	default y if PREEMPT_RT
> +	bool
> +	default y if (RT_MUTEXES && PREEMPT_RCU) || PREEMPT_RT

[Severity: Medium]
Does making RCU_BOOST a promptless symbol that defaults to y break the
BUSTED-BOOST rcutorture negative test added in d4240d628f98 ("rcutorture:
Add BUSTED-BOOST to test RCU priority boosting tests")?

BUSTED-BOOST sets CONFIG_PREEMPT=3Dy (selecting CONFIG_PREEMPT_RCU=3Dy) and
passes rcutorture.test_boost=3D2 so rcu_torture_can_boost() runs the boost
test on a kernel with CONFIG_RCU_BOOST=3Dn to verify boost-failure
detection.  With this change, BUSTED-BOOST builds with CONFIG_RCU_BOOST=3Dy
and cannot override it in its config fragment, so priority boosting is
active and the negative test passes instead of failing.

>  	help
>  	  This option boosts the priority of preempted RCU readers that
>  	  block the current preemptible RCU grace period for too long.
>  	  This option also prevents heavy loads from blocking RCU
> -	  callback invocation.
> +	  callback invocation.  It is now automatically enabled in
> +	  any kernel that can benefit from it and that can support it.
> =20
> -	  Say Y here if you are working with real-time apps or heavy loads
> -	  Say N here if you are unsure.
> =20
>  config RCU_BOOST_DELAY
>  	int "Milliseconds to delay boosting after RCU grace-period start"

[Severity: Low]
Will enabling RCU_BOOST when CONFIG_RCU_EXPERT=3Dn expose the
RCU_BOOST_DELAY (and RCU_NOCB_CPU_CB_BOOST when NO_HZ_FULL selects
RCU_NOCB_CPU) prompts during make oldconfig on non-expert configurations?

Both options depend on RCU_BOOST and have unconditional prompts that were
previously hidden when RCU_EXPERT=3Dn kept RCU_BOOST disabled.  Since
kernel/rcu/tree_plugin.h uses CONFIG_RCU_BOOST_DELAY unconditionally under
#ifdef CONFIG_RCU_BOOST, gating their prompts with "if RCU_EXPERT" would
keep the default value defined without prompting non-expert users.

> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB01 b/tool=
s/testing/selftests/rcutorture/configs/rcu/NOCB01
> index bbe6d28210ab5..91ca7e8b5725f 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/NOCB01
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB01
> @@ -14,7 +14,6 @@ CONFIG_RCU_FANOUT_LEAF=3D2
>  CONFIG_RCU_NOCB_CPU=3Dy
>  CONFIG_DEBUG_LOCK_ALLOC=3Dn
>  CONFIG_PROVE_LOCKING=3Dn
> -CONFIG_RCU_BOOST=3Dn
>  CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
>  CONFIG_RCU_EXPERT=3Dy
>  CONFIG_RCU_EQS_DEBUG=3Dy
> diff --git a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02 b/tool=
s/testing/selftests/rcutorture/configs/rcu/NOCB02
> index 4c2b8cd6d8fdb..ed3f3f7b29e73 100644
> --- a/tools/testing/selftests/rcutorture/configs/rcu/NOCB02
> +++ b/tools/testing/selftests/rcutorture/configs/rcu/NOCB02
> @@ -14,7 +14,6 @@ CONFIG_RCU_FANOUT_LEAF=3D2
>  CONFIG_RCU_NOCB_CPU=3Dy
>  CONFIG_DEBUG_LOCK_ALLOC=3Dn
>  CONFIG_PROVE_LOCKING=3Dn
> -CONFIG_RCU_BOOST=3Dn
>  CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dn
>  CONFIG_RCU_EXPERT=3Dy
>  CONFIG_RCU_EQS_DEBUG=3Dy

[Severity: Medium]
Does enabling CONFIG_RCU_BOOST=3Dy in NOCB01 and NOCB02 unintentionally
start rcu_torture_boost() stress threads on these scenarios?

With CONFIG_RCU_TORTURE_TEST=3Dy and CONFIG_RCU_BOOST=3Dy,
sanitize_kthread_prio() raises kthread_prio to 2 and
rcu_torture_can_boost() returns true by default, spawning per-CPU
SCHED_FIFO rcu_torture_boost() threads on scenarios that leave rcuop
kthreads at SCHED_NORMAL without CONFIG_RCU_NOCB_CPU_CB_BOOST=3Dy.  The
follow-up commit "rcutorture: Disable RCU priority boost testing on
non-TREE03 scenarios" adds rcutorture.test_boost=3D0 to TREE01, TREE02,
TREE08, and TREE09, but omits NOCB01.boot and NOCB02.boot.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113005747.2977=
123-1-jfern@kernel.org?part=3D12
