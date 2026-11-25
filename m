Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795612847;
	b=OcZTxZZhbqRBByU0PcLVruVXFgfl4Or5H5ol0903LbcbnRoX/lUTnQCp252QJY6yZJAb
	 PFC2eMGgcscci0MFOsZbW5v9kBd4Qs5F+T3Y+rB4hvvT/OMvP0Em9t7hRrI0SiyZSZEW7
	 5cLqKJdPwLrjEjOzO6GmPgcBGjdAPn2ikmEcg2t9wovh33RkDw1kRKdAmXRAYo1Snl08G
	 aodlj9v8kfSz4NUIrpQfcNc/nRRxwT4nOtqKGsLupCylAJM7oDSysdFFjCqSKVYZVNhke
	 TZiuLbQKG9gQ9F8DPHOO24FVowP3pg7chJrq1z8x+voHiaZf2EAe7+7ipHXm0gPb77g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612847;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=BpbsyFzLIuLLRIYUo5HYMqPLpIFsXjaSEvpIntsRtr0=;
	b=ONk4f8k+1F+19CpHMUWTTjSStN7p9ygBXxEStu9j03aDZNHLNmjDsF//KLV4IomYVq+J
	 iWx6FriO0wlCf/oRCVUMBMUrrb2fZhKv+JHTrBLrPSRslT08UsvTUU4uMM3Xnnzaup4zh
	 kP4pT4PhGdjfqrl/gKOcxyTfhg0pbg1SJC4dKqM4CXq9A/XWdzuUNp1Wa8sTktqNCInhp
	 NwU6LDoyyJLxdqnHNkKhG1YtM+suDCcJWh+ADq7/Hst7Shij7S3fDM86lhyGIFW5Jb+EZ
	 7rXY2gvnXjmUlQUnmoK6Z/NC+lSLYPITa/KScQlWlNk4iIadUVWBjve0SnWeWZnU6/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz28PkFL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30807606A321;
	Wed, 25 Nov 2026 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz28PkFL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEFA1F000C6;
	Wed, 25 Nov 2026 13:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795612846;
	bh=BpbsyFzLIuLLRIYUo5HYMqPLpIFsXjaSEvpIntsRtr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Nz28PkFLFYFGWEiprnX/yPyrxQsP8nKvrvdcWwUgxzh3FoRp12gGpD9UROXfm5y0m
	 iELAGyxgX94lNmbKmbz7a+PDFZGWWFZVBOOlveXfIO+glA29LEo0b79CylwE0HLTeS
	 lg4mYoJysr3g/ef8KSfuhvairPs7vvKvxQSKOaqCIRcCi2t3nUw9lmw01Kp9/sVd48
	 teXoxuJUqe9Fwu9tVtBL1k3gn85WoEpdPOVcLj95stwXkMma4faYwFGKxu+l4YSpZo
	 jvkts9N34r680JGLJzjZ1DZwsudXjP7R/5nVXMj1x37vR3EkvOmtbBQqyYz5QBio46
	 R54G/sSyh7cbA==
Date: Wed, 25 Nov 2026 14:20:43 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Zixin Wang <w1355457260@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	bigeasy@linutronix.de, darwi@linutronix.de,
	john.ogness@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, corbet@lwn.net, wagi@monom.org,
	atomlin@atomlin.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] Documentation: real-time: Add runtime tuning guide
Message-ID: <awbgq0xQyJATel0_@localhost.localdomain>
References: <20261125074658.33117-1-w1355457260@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261125074658.33117-1-w1355457260@gmail.com>

Le Wed, Nov 25, 2026 at 07:46:58AM +0000, Zixin Wang a écrit :
> +CPU isolation
> +=============

Isn't it kind of duplicating Documentation/admin-guide/cpu-isolation.rst ?

> +
> +.. caution::
> +
> +  CPU isolation is best effort.  Work that is explicitly bound to an
> +  isolated CPU, such as per-CPU kernel threads, bound workqueues, and
> +  interrupts, may still run there unless it is steered away.  Measure
> +  the resulting latency with tools such as ``osnoise``, ``timerlat``,
> +  and ``rtla`` rather than assuming that an isolated CPU is free of
> +  kernel noise.  See Documentation/timers/no_hz.rst and

And cpunoise but that's all in Documentation/admin-guide/cpu-isolation.rst

> +RCU callback offloading
> +=======================
> +
> +``CONFIG_RCU_NOCB_CPU`` in
> +Documentation/core-api/real-time/kernel-configuration.rst enables support
> +for offloading RCU callback invocation from selected CPUs to per-CPU
> +``rcuo`` kthreads.  The offload is selected with ``rcu_nocbs=``, implied
> +by ``nohz_full=``, or enabled for all CPUs by
> +``CONFIG_RCU_NOCB_CPU_DEFAULT_ALL`` when neither parameter is given.
> +
> +``rcu_nocbs[=cpu-list]``
> +  Offload RCU callback invocation from the listed CPUs to the
> +  corresponding ``rcuo`` kthread, which can run on a housekeeping CPU.
> +  This reduces callback-processing jitter on the CPU that enqueued them.
> +  On a non-real-time kernel this also moves invocation out of softirq
> +  context; with PREEMPT_RT, callbacks already run in kthread context
> +  because ``rcutree.use_softirq`` is false, and the offload only changes
> +  where they run.  If the parameter is given without a CPU list, no CPU
> +  is offloaded at boot; the mode can still be toggled at runtime through
> +  cpusets.  The parameter takes precedence over
> +  ``CONFIG_RCU_NOCB_CPU_DEFAULT_ALL``.
> +
> +``rcu_nocb_poll``
> +  Make the ``rcuo`` kthreads poll for callbacks instead of requiring the
> +  offloaded CPUs to wake them.  This improves the real-time response at
> +  the cost of higher power consumption, because the kthreads wake up
> +  periodically to do the polling.  Consider this option only when wakeup
> +  latency matters more than power.

Does nocb polling really improve real time response?
I have doubts.

It checks callbacks and grace periods every jiffy instead of waiting
for actual callbacks and grace period events.

This means introducing jiffy worst case latencies.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
