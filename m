Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542522;
	b=CsE0T4OGXYYMDMtQfuBFhmU0O2v0ZothtyrPlLtj8M1rM1p0q8R+7JjX9rOaF5u47WIy
	 1yUimI4go/TR5Pvvm67D+ukqgKYN61SYUmW4HfdGv+Ld65L+nqvSD48rzb9+usGrgthe/
	 iIvAtb4a4n7m2/RTXk3vtbAwSi34sDsHQs7i14tUcB7RL0mo95NWmEFAuKnaIA7bSvjPJ
	 5mSSf/T0nobepu1Z8Ug+bgDzhfwMgCGHdidHwitxejvNYR1a+HaPd4B96b2UysyElcKFZ
	 S6qEmHUmnznOEWJo7aCEmEIsWG2hnlvbOzM7aYT8yzdoxspl3m6jMHBCVKGr7WT0SBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542522;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=iAxXNBw21OAhqAVbpLzIkcF+I6WgYNRYnju4tgLuhNo=;
	b=CKrOpo0XlEfQ0H/8Y4hduOGq7fWHyFe6wFZszTRQUw6fx469dDuVAmyNmEUg88ghRbAo
	 5E4ZQJ0/nI01FuLNLRPNA6qzhhE5OCIPd//Btv6MjImrvvrKAljKA99dcnwQ+c8FXX5fB
	 rUMBhCIbx6Ye18Yf88VxsakM6GWc+QNx9B9jtkX6ww3yq05ZGkA6E17uVIF5zMvePbYx3
	 /8+lTU+0BEoYCfLl3VDtInowubRssjYItVmZvLjB+jgLHZ9TFOjwn7CWa91KXjBCgcQej
	 Fs7JX8Jgg9FeY4KGv8YmJW2vB/7d06HpHMiK0hDyJE8BFznQ5fR1LtVYFNjLz6+MxwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=o9oSUpqr;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="378Q0/Lt";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E38606A321
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 17:48:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21E38606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=o9oSUpqr;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=378Q0/Lt
Date: Tue, 24 Nov 2026 18:48:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795542519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAxXNBw21OAhqAVbpLzIkcF+I6WgYNRYnju4tgLuhNo=;
	b=o9oSUpqr51DMerEkCYl2Zk2l2Yc1flM2MDtCTpSw3Fp3rz6kv9jCmEQF/Xh36oYu9ipRJa
	xnY4510j0DppTsblJJYCGpHsEWNSIl5QOriw6dUmjNmKi6hzDY+bDT0Tjnj7s2EE6O/fUC
	NRcydLhv89OUUus/gL1Dn3Z3cs4im9+ODQNggFVfLLxQ3rePiIHM5d4XS5twp4e2PBaF6T
	aRw3GUTuTVF9o0cByks8lQeo0UFuQDZEJz1L3P+EwtzuPi6eeng76L+IuSFXmOmgRWbSk2
	UUxpGbb/D4p1v74nmozvZzCCrDTbQaHC1QTB00ELu9azBAYaEmWaAhuJ+DWulg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795542519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iAxXNBw21OAhqAVbpLzIkcF+I6WgYNRYnju4tgLuhNo=;
	b=378Q0/LtFoKLUUPTs/BLM0vx6CsDeF1MrAPHTV3ZaSQ7qkB4ECH4qbg9fkhUIkcF8mhdvO
	nhcGsdqsXtub47DA==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Zixin Wang <w1355457260@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	bigeasy@linutronix.de, frederic@kernel.org,
	john.ogness@linutronix.de, clrkwllms@kernel.org,
	rostedt@goodmis.org, corbet@lwn.net, wagi@monom.org,
	atomlin@atomlin.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] Documentation: real-time: Add boot parameters and
 task isolation section
Message-ID: <awXN9RY3x5xEGFe4@lx-t490>
References: <20261124163202.56921-1-w1355457260@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124163202.56921-1-w1355457260@gmail.com>

Hi Zixin,

On Tue, 24 Nov 2026, Zixin Wang wrote:
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
> +
...
> +.. _real_time_boot_parameters:
> +
> +Boot parameters and task isolation
> +==================================
> +
> +Kernel configuration options alone do not determine a real-time system's
> +worst-case latency.  Integrators commonly rely on boot parameters and
> +runtime tunables as well, to keep kernel housekeeping work away from
> +latency-sensitive tasks.  The parameters below complement the options
> +described above.  Some of them correspond to a configuration option and
> +are referenced from that option's section, so the configuration and
> +runtime guidance stay together.  Each one is documented in detail in
> +Documentation/admin-guide/kernel-parameters.rst; the notes here focus on
> +the aspects that matter for real-time latency.  Consider these options
> +only when the workload suffers from the corresponding interference;
> +leave them disabled otherwise, as each of them trades flexibility or
> +power for a lower worst-case latency.  The notes below follow the
> +decisions an integrator has to make: whether to keep tasks off a CPU,
> +whether to stop its tick, and where interrupts should run.  Idle state
> +limits are discussed with ``CONFIG_CPU_IDLE`` above, and RCU callback
> +offloading with ``CONFIG_RCU_NOCB_CPU`` above.
> +For the full CPU isolation model and its limitations, see
> +Documentation/admin-guide/cpu-isolation.rst.
> +
> +.. caution::
> +
> +  CPU isolation is best effort.  Work that is explicitly bound to an
> +  isolated CPU, such as per-CPU kernel threads, bound workqueues, and
> +  interrupts, may still run there unless it is steered away.  Measure
> +  the resulting latency with tools such as ``osnoise``, ``timerlat``,
> +  and ``rtla`` rather than assuming that an isolated CPU is free of
> +  kernel noise.  See Documentation/timers/no_hz.rst and
> +  Documentation/tools/rtla/index.rst.
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
> +    cpusets.  Unbound workqueues and unbound kernel threads are
> +    confined to the housekeeping CPUs as a side effect.  Consider it
> +    for CPUs dedicated to a latency-sensitive workload.
> +
> +  ``nohz``
> +    Equivalent to ``nohz_full=``; see below.  The residual 1 Hz tick is
> +    offloaded to workqueues, which must be affine to the housekeeping
> +    CPUs through the global workqueue ``cpumask``
> +    (/sys/devices/virtual/workqueue/cpumask).  By default the global
> +    workqueue runs on all CPUs; configure this cpumask manually after
> +    boot, or use the ``domain`` flag to confine unbound workqueues.
> +
> +  A practical configuration therefore combines ``isolcpus=`` with
> +  ``nohz_full=``, ``rcu_nocbs=``, an interrupt affinity mask, and, on
> +  x86 systems, a C-state limit.
> +
> +  Timer placement follows the same choice.  By default a migratable
> +  timer expires on the CPU that armed it; with ``nohz`` (or
> +  ``nohz_full=``), timers and hrtimers armed on the isolated CPUs are
> +  migrated to housekeeping CPUs.
> +
> +``nohz_full=``
> +  Format: ``<cpu-list>``.  Requires ``CONFIG_NO_HZ_FULL=y``.  Stops the
> +  scheduler tick on the listed CPUs whenever possible.  The boot CPU is
> +  forced outside the range to maintain timekeeping, and the RCU
> +  callbacks of the listed CPUs are offloaded as if they had been
> +  passed to ``rcu_nocbs=``; see the ``CONFIG_RCU_NOCB_CPU`` section
> +  above.  This parameter takes precedence over
> +  ``CONFIG_RCU_NOCB_CPU_DEFAULT_ALL``.
> +
> +  The trade-off between tickless operation and the kernel-to-userspace
> +  transition latency is described in the ``CONFIG_NO_HZ`` /
> +  ``CONFIG_NO_HZ_FULL`` section above.
> +
> +Interrupt affinity
> +------------------
> +
> +``irqaffinity=``
> +  Format: ``<cpu-list>``.  Sets the default affinity mask for
> +  interrupts that do not have an explicit affinity, steering them to
> +  the housekeeping CPUs.  Managed interrupts are not affected by this
> +  setting and cannot be redirected through ``/proc/irq/*``.  Verify
> +  the resulting placement in ``/proc/interrupts``.  See
> +  Documentation/core-api/irq/managed_irq.rst.
> +
>

Thanks for the write-up above.

I wrote the RT configuration guide some time ago, where "configuration"
here implied kconfig build-time .config generation.

It is true, of course, that "kernel configuration options alone do not
determine a real-time system's worst-case latency".  But this does not mean
that all the RT optimization tricks above must be squeezed together into
the kernel RT /configuration/ guide.

There's also a kernel configuration checker that produces lots of links to
this guide:

    https://msgid.link/20261106091922.7560-1-darwi@linutronix.de

So I don't think that expanding the scope of this document into overall RT
optimizations tricks will help.

Since the whole of Documentation/real-time/ is dedicated to PREEMPT_RT, why
not integrate these RT-optimization information into a proper guide there?

Then, let this configuration guide link to the relevant sections only when
necessary.  This way, scope creep is avoided.

Thanks!

--
Ahmed S. Darwish
Linutronix GmbH
