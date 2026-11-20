Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795174564;
	b=sE0XyXLlg2+Czny5AvHkRNB2t0c5MOJwPHwdv77T8JfPPr9uKEN8xgoRRoXw9cuS8UXg
	 kOeN5Z2q/t1r3dtzndmbLaSGJ/PgQtZwyG6On7CkO7+btPGPo2UbrKcRMf2MSlE+IPoO4
	 zkp4ycnq6iH6oBa8wACL6bogaP18NMDEQdUZlddA30Eq8Hjbr+q/a8FWkRqHxV2DJiCxk
	 GeLAISNtCKF7IKhCfTpK/xQ5bLxu0Ycdg1CjiHL+pVsf4HyQpNdPhqt/YF6Hqikt85TwJ
	 mhUsXS7BJqCLorIsqliTpj/f/zAMbkaUfPtFV1/YPLQrfmmYzpzxCt3f92gwESSremg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795174564;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=SMoA0QsiPOyJUtX7o/6SvPRpcNHkZMkKyPUQpx5qduo=;
	b=43RbxVUEYkWtTw3/jytwQyeTkx36tUCU1DeatXerMz17L9O6H/HImskYBb+1lQ0eQSbu
	 8VjGLfE8isuDJeEVNLlhC6eB57EbXeW6vhlLafm/pfgHwkn30zXQMjmJcVtxzndGT4WJB
	 vtDB5s8yiheU4zfi+YAQqIpMFv9MO0YgQKw+biS/98ERFoYEmWyvna7hmfkhfWzQw/LJh
	 MGfU0oRrtkhUbOhBlf8CE3lmqP3MBEaNei7G/sosz8uWcbKP33Q38GT1y0MbSRhhztD7V
	 aH0bOKdJQ2T0PIBZNRPdEHZhEAx40sBifgTwWJfLofqu4Lnk4y2amtsAk5XAlZGt2Lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=AsD7xB0w;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=4V39IGvG;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B87606A325
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 11:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7B87606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=AsD7xB0w;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=4V39IGvG
Date: Fri, 20 Nov 2026 12:35:59 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795174561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMoA0QsiPOyJUtX7o/6SvPRpcNHkZMkKyPUQpx5qduo=;
	b=AsD7xB0wBOXFR+XNC1MU0d+VtQbKRRunMOdXYwiTukr7n7wURs1ATvOd7AFD413PFj7uJY
	xQ0NiD0Exgvz9RqY627m7ZboLtRWyE383iuty5IXBm4llxJNbdwnH+HX/vfSN0qsSke2H8
	x5Em58QmIVpCQrqBDJ8aBXWrzCJ4LEeweh+fRPCAvhrvIDp/0h9XVeASkZKZM+3OuoXQt6
	yWFFxY01FstE0UNbxcJMV10ILGxhbWVX4h/3aFVhEAiL4sbxgEhsdUfNw5YKNzgUUdoFW+
	Gsjj3fbg6TFXB9QpZ13IIUdzDqiiPrwLEzTMgov/mw6gjtIuOw+UASD5oIkzGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795174561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SMoA0QsiPOyJUtX7o/6SvPRpcNHkZMkKyPUQpx5qduo=;
	b=4V39IGvGLHo8Bb5ddA8rrv7XtO5HvxSrjLdFCot4XK7Mr5yH0VnGRUurYno+/QY4XP9Idi
	ks772A0BerBarJBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Zixin Wang <w1355457260@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	clrkwllms@kernel.org, rostedt@goodmis.org, corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Daniel Wagner <wagi@monom.org>, Aaron Tomlin <atomlin@atomlin.com>
Subject: Re: [PATCH v2] Documentation: real-time: Add boot parameters and
 task isolation section
Message-ID: <20261120113559.VCQRFh0b@linutronix.de>
References: <20261120070620.535693-1-w1355457260@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120070620.535693-1-w1355457260@gmail.com>

On 2026-11-20 15:06:20 [+0800], Zixin Wang wrote:
> --- a/Documentation/core-api/real-time/kernel-configuration.rst
> +++ b/Documentation/core-api/real-time/kernel-configuration.rst
> @@ -216,6 +216,147 @@ just by being enabled.
>  These tracers do incur measurable latency overhead even when tracing is not
>  currently active.
>  
> +Boot parameters and task isolation
> +==================================
> +
> +Kernel configuration options alone do not determine a real-time system's
> +worst-case latency.  Integrators commonly rely on boot parameters and
> +runtime tunables as well, to keep kernel housekeeping work away from
> +latency-sensitive tasks.  The parameters below complement the options
> +described above.  Each one is documented in detail in
> +Documentation/admin-guide/kernel-parameters.rst; the notes here focus on
> +the aspects that matter for real-time latency.  For the full CPU
> +isolation model and its limitations, see
> +Documentation/admin-guide/cpu-isolation.rst.
> +
> +.. caution::
> +
> +  CPU isolation is best effort.  Unbound workqueues, kernel threads,

An unbound workqueue is not restricted to a certain to CPU therefore it
will not run on an isolated CPU. The same is true for kernel threads as
long as they are not restricted to the isolated CPU.


> +  timers, and interrupts may still run on isolated CPUs unless they are
> +  explicitly steered away.  Measure the resulting latency with tools
> +  such as ``osnoise``, ``timerlat``, and ``rtla`` rather than assuming
> +  that an isolated CPU is free of kernel noise.  See
> +  Documentation/timers/no_hz.rst and Documentation/tools/rtla/index.rst.
> +
> +CPU isolation
> +-------------
> +
> +``isolcpus=``
> +  Format: ``[flag-list,]<cpu-list>``.  Isolates the listed CPUs from the
> +  disturbances selected by the flag list (default: ``domain``):
> +
> +  ``domain``
> +    Remove the CPUs from the scheduler domains.  This is the default
> +    when no flag is given.  Domain isolation cannot be undone at
> +    runtime; use cpusets when the isolated CPU set must change
> +    dynamically.  Isolated CPUs remain usable through CPU affinity or
> +    cpusets.
> +
> +  ``nohz``
> +    Stop the tick when a single task runs and offload kernel noise,
> +    including RCU callbacks.  This is equivalent to ``nohz_full=``.
> +    The residual 1 Hz tick is offloaded to workqueues, which must be
> +    affined to housekeeping CPUs through the global workqueue
> +    ``cpumask`` (/sys/devices/virtual/workqueue/cpumask); by default
> +    that workqueue may run on any CPU.

By default, yes, but that options changes it.

> +  ``managed_irq``
> +    Prevent managed interrupts from being targeted at isolated CPUs
> +    when their automatically computed affinity mask also contains
> +    housekeeping CPUs.  This is best effort and has no effect when the
> +    mask contains isolated CPUs only.  See
> +    Documentation/core-api/irq/managed_irq.rst.

It is currently worked on managed_irq. Apart from this it might be
debatable that if you perform I/O on an isolated CPU should you or
should you not receive a completion interrupt on the isolated CPU
initiating the I/O. Any statement from your side?

Frederic, does this fit here from your perspective?

> +
> +  Apart from the best-effort managed IRQ redirection, these flags do
> +  not stop kernel threads, timers, or interrupts that are already
> +  affined to the isolated CPUs.  A practical configuration therefore

timers. Unless a timer is explicitly set to target a certain CPU it will
avoid to fire on the isolated CPU even if "setup" on the isolated CPU.

> +  combines ``isolcpus=`` with ``nohz_full=``, ``rcu_nocbs=``, an
> +  interrupt affinity mask, and a C-state limit.

C-state is x86 specific.

> +``nohz_full=``
> +  Format: ``<cpu-list>``.  Requires ``CONFIG_NO_HZ_FULL=y``.  Stops the
> +  scheduler tick on the listed CPUs whenever possible.  The boot CPU is
> +  forced outside the range to maintain timekeeping, and the RCU
> +  callbacks of the listed CPUs are offloaded as if they had been
> +  passed to ``rcu_nocbs=``.  This parameter takes precedence over
> +  ``CONFIG_RCU_NOCB_CPU_DEFAULT_ALL``.
> +
> +  Tickless operation can increase the kernel-to-userspace transition
> +  latency, so it is most useful for workloads that execute in
> +  userspace for long periods with few syscalls.  Periodic workloads
> +  with short periods may prefer a consistent tick instead.
> +
> +RCU callback offloading
> +-----------------------
> +
> +``rcu_nocbs[=cpu-list]``
> +  In kernels built with ``CONFIG_RCU_NOCB_CPU=y``, move RCU callback
> +  invocation for the listed CPUs out of softirq context and into
> +  per-CPU ``rcuo`` kthreads.  This reduces OS jitter on the offloaded
> +  CPUs.  If the argument is omitted, no CPU is offloaded at boot, but
> +  the mode can be toggled at runtime through cpusets.  ``nohz_full=``
> +  implies the same offload for the CPUs it lists.

This sounds very familiar with the wording in kernel-parameters.txt.
With PREEMPT_RT enabled the callbacks are not pulled out of the softirq
context and this is an additional detail. There is
rcutree.use_softirq=false on PREEMPT_RT.
What it actually does is that the callbacks are no longer invoked on the
CPU that enqueued them but in the offloaded thread which can run on the
housekeeping CPU.

> +
> +``rcu_nocb_poll``
> +  Make the ``rcuo`` kthreads poll for callbacks instead of requiring
> +  the offloaded CPUs to wake them.  This improves the real-time
> +  response at the cost of higher power consumption, because the
> +  kthreads wake up periodically to do the polling.

At this point I am not sure if you explain (and copy original
description) or collect option which are advised/ recommended.

Maybe it is a list of options worth considering.

> +
> +Interrupt affinity
> +------------------
> +
> +``irqaffinity=``
> +  Format: ``<cpu-list>``.  Sets the default affinity mask for
> +  interrupts that do not have an explicit affinity.  Managed
> +  interrupts, such as MSI-X queue interrupts, derive their affinity

this "such as MSI-X queue interrupts" probably does not belong here. The
affinity of managed-interrupts can not be changed. How they are placed
is a different story.

> +  from the device queue mask instead and cannot be changed through
> +  ``/proc/irq/*``.  Combine ``irqaffinity=`` with the ``managed_irq``
> +  flag of ``isolcpus=`` to keep interrupts away from isolated CPUs
> +  where possible.  See Documentation/core-api/irq/managed_irq.rst.
> +
> +Idle state limits
> +-----------------
> +
> +``processor.max_cstate=``
> +  ACPI platforms only.  Limits the deepest C-state the processor may
> +  enter.  ``processor.max_cstate=1`` caps the processor at C1 and
> +  avoids the entry and exit latency, cache flushing, and clock effects
> +  of deeper states.  A value of 9 overrides any DMI blacklist limit.
> +
> +``intel_idle.max_cstate=``
> +  x86 platforms using ``intel_idle`` only.  A value between 1 and 9
> +  specifies the maximum C-state depth.  A value of 0 disables
> +  ``intel_idle`` and falls back to ``acpi_idle``; it does not disable
> +  C-states.
> +
> +Deeper C-states save power but increase wakeup latency.  Choose the
> +shallowest state that still meets the platform's power and thermal
> +requirements, and validate the result with the tools listed above.
> +
> +Real-time throttling
> +--------------------
> +
> +``kernel.sched_rt_runtime_us``
> +  Together with ``kernel.sched_rt_period_us``, this sysctl defines the
> +  total bandwidth available to SCHED_DEADLINE entities.  When
> +  ``CONFIG_RT_GROUP_SCHED`` is enabled, it also limits the bandwidth of
> +  the real-time scheduling groups.  The default runtime equals the
> +  period (1000000 us), so no bandwidth is subtracted from deadline
> +  tasks by default.

I would throw this away. First of sched_rt_runtime_us is not related to
throttling anymore and then I try to get rid of CONFIG_RT_GROUP_SCHED
(and this option). And I doubt anyone seriously uses this option.

> +  Without ``CONFIG_RT_GROUP_SCHED``, SCHED_FIFO and SCHED_RR tasks are
> +  no longer throttled through this interface.  Instead, a per-CPU fair
> +  deadline server keeps non-real-time tasks running by providing
> +  50 ms of runtime per 1000 ms period.  That reservation is not
> +  disabled by setting this sysctl to -1; the server parameters are
> +  exposed under /sys/kernel/debug/sched/fair_server/cpuX/.
> +
> +  A value of -1 removes the total deadline bandwidth limit, that is,
> +  runtime equals period.  Do this only after validating the workload,
> +  because runaway real-time tasks can then starve the rest of the
> +  system.  See Documentation/scheduler/sched-rt-group.rst for RT group
> +  scheduling details.

I do try to move it someplace else, see 
	https://lore.kernel.org/all/20261113-sched_dl-v3-0-a76ffa1cdeee@linutronix.de/

The basic information is that we have throttling in place and one needs
to disable it if it interferes.

Overall I don't mind having a collection of useful options worth
considering. I'm just not sure if the format of explaining the
parameters again is the right approach. Maybe it is worth considering
why a certain configuration step should be considered. Like should a
kernel timer expire on the CPU that programmed it or on the
house-keeping CPU instead? That would be the knob for it.

> +
>  Kernel Debug Options
>  ====================
>  

Sebastian
