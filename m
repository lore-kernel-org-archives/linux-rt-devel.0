Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795447473;
	b=EromeMuallLUEafRYQ/mUUh2yqUyZmLhNTJie4gGJHq8kfV3I8wl/I9HVt4cJlgdhF89
	 d2voBPM5PGAU9N4/CbalND6gbbPzFFNZGIj3I7f8UlkU5+DMPg+jWfj4fLvfOhMkKAFib
	 C6GWyHLE5KUe4mNhc2U8BaFiZNUrEzyYMsoYXEtfZRUBCn1246DtgUEI0jYMdtfsyHLCg
	 Ky7o6tv6P8q9Xx/PxVv6RrPNf4a8PvyejZjXACQ4PFr7rDub6M72EclWkrOSVh6wdjLAV
	 Mztx1VR/v3B5tuFHJziDcI6IUvCwbuJOXNWijcL75yOkWIbv+KHb08CjaMmm1IWTxxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795447473;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=quJ9x6vCaEZENj0BcSZX26iJFFHGXwFCBIa4eWkw88s=;
	b=BRhNfSTSqiHdYo3Dogj+udyxeMTnHuHRiO/lHKLyJuDJY7ZmXTUWLrD9zsjL0eTWQX5G
	 tggEyWi7rOVxH9AAb/EUm3hdBnM6n0tjy3Z26BZF1eaO/NPXWgSmSFDBAiIu+FQzt9mhT
	 9hOscMN1IbcjPd7tDeOpKBY3vYU9spZXig3JTAOLBM3r8T2LhcUHomPEkSwtMYVzDwSua
	 4sWye3adFT+x+p5Nq6SzhSGu4/6gdisIrhtb0826lRYy+rmzneOMAGo2qNvYCjfJndRli
	 OntvvWF1w6N7ilF9DMcoUG9JRnEzhRBD7yjefmpLGmqDMwkhle+C7qxWyd8Olw0PoJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tgnHFYnt;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b="Q/rvAn2M";
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF091606A321
	for <linux-rt-devel@lists.linux.dev>; Mon, 23 Nov 2026 15:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF091606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tgnHFYnt;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Q/rvAn2M
Date: Mon, 23 Nov 2026 16:24:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795447470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=quJ9x6vCaEZENj0BcSZX26iJFFHGXwFCBIa4eWkw88s=;
	b=tgnHFYntZ/tLKwZ/6vBAjPKXx9TBqrBwzDGWDWdtsXqhE0tWbEnPD0J0FBYZw6rhbz2Jgs
	dyCUeAMtrOGLEKTjqwGZke08gRR/kmlM8EmFWg6Rdpzryx6n2GJvQVaU88V5i1jp3ECiKT
	KqAqQXDRyVyMtb3Bo4EO38eNd93vqwWTqDF04hbmiSdb/vrBcnA/908FExH5GLj5JJJKOf
	6YOP0z3Ps63wOlg1iY6asQn5gBadc4Uj82gBon/QLbNfYKIIqxxRrtxiTvho68puEvRwql
	JQqVhfVHcuS7uoV7VVHYt/8W61yrFK3PLZuWgu4so1+9wHUllU8zN38eLsFQcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795447470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=quJ9x6vCaEZENj0BcSZX26iJFFHGXwFCBIa4eWkw88s=;
	b=Q/rvAn2MU1pnnIupXzqNs/NkdvRU3tHlIbLF/KOfs/acTN73HI2UUh7I+Us+6+GCIFweDL
	GyB2/kNEPCb5plBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Zixin Wang <w1355457260@gmail.com>, frederic@kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>
Cc: linux-doc@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	clrkwllms@kernel.org, rostedt@goodmis.org, corbet@lwn.net,
	frederic@kernel.org, wagi@monom.org, atomlin@atomlin.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Documentation: real-time: Add boot parameters and
 task isolation section
Message-ID: <20261123152427.UC03D36n@linutronix.de>
References: <20261121093740.4133-1-w1355457260@gmail.com>
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
In-Reply-To: <20261121093740.4133-1-w1355457260@gmail.com>

any statement from the folks in To:?

On 2026-11-21 17:37:40 [+0800], Zixin Wang wrote:
> Document the boot parameters and runtime tunables that affect the
> worst-case latency of a real-time system, alongside the existing
> kernel configuration guidance.
> 
> Cover CPU isolation, nohz_full, RCU callback offloading, interrupt
> affinity, and C-state limits, with references to the relevant
> documentation.  Keep the C-state parameters next to CONFIG_CPU_IDLE
> and the tickless trade-off next to CONFIG_NO_HZ, so each option stays
> with its configuration guidance.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220633
> Link: https://github.com/elisa-tech/wg-aerospace/issues/222
> Signed-off-by: Zixin Wang <w1355457260@gmail.com>
> ---
> Thanks Sebastian for the review.
> 
> v3 -> v4:
>   - Fold the C-state parameters into the CONFIG_CPU_IDLE section,
>     which already documents processor.max_cstate=1 and cpupower, and
>     drop the separate "Idle state limits" subsection.
>   - Point CONFIG_NO_HZ/CONFIG_NO_HZ_FULL at nohz_full= and avoid
>     repeating the tickless-transition explanation in the isolation
>     section.
>   - Add a CONFIG_RCU_NOCB_CPU section for rcu_nocbs= and rcu_nocb_poll,
>     and reference it from the isolation section.
>   - Remove repeated statements within the isolation section: the
>     domain side effect, the duplicate isolcpus=nohz/nohz_full=
>     description, and the nohz_full/rcu_nocbs cross-statement.
>   - Keep the boot parameter section focused on the cross-cutting
>     isolation parameters and their interactions.
> 
> Testing:
>   make SPHINXDIRS="core-api" htmldocs and checkpatch.pl pass.
> 
>   Host boot test (AMD Ryzen 5 5600H, acpi_idle): with
>   processor.max_cstate=1, /sys/module/processor/parameters/max_cstate
>   is 1 and cpupower idle-info reports only POLL/C1; without the
>   parameter the host reports POLL/C1/C2/C3.  intel_idle.max_cstate was
>   not tested because the host uses acpi_idle.
> 
>   Host latency comparison (cyclictest, CPU 2 isolated, performance
>   governor): the idle-phase average latency was 15 us with
>   processor.max_cstate=1, 32 us with processor.max_cstate=2, and
>   248 us without a limit; the corresponding maxima were 879 us,
>   2407 us, and 3336 us.  The tight-phase maxima were dominated by a
>   device IRQ (about 3.2 ms), so the idle phase is the relevant
>   comparison.  C2 and C3 usage was confirmed by the cpuidle usage
>   counters.
> 
>   QEMU test: the default ACPI tables have no _CST; with a small _CST
>   SSDT loaded via -acpitable, the guest registers POLL/C1/C2/C3, and
>   processor.max_cstate=1 limits them to POLL/C1.  This verifies the
>   parameter behavior; the QEMU setup does not measure real host
>   C-state latency.
> 
>  .../real-time/kernel-configuration.rst        | 128 ++++++++++++++++++
>  1 file changed, 128 insertions(+)
> 
> diff --git a/Documentation/core-api/real-time/kernel-configuration.rst b/Documentation/core-api/real-time/kernel-configuration.rst
> index d7f08e7b..315960cf 100644
> --- a/Documentation/core-api/real-time/kernel-configuration.rst
> +++ b/Documentation/core-api/real-time/kernel-configuration.rst
> @@ -98,6 +98,11 @@ can be achieved by using the boot parameter [1]_::
>  
>    processor.max_cstate=1
>  
> +On x86 systems using ``intel_idle``, the ``intel_idle.max_cstate=`` boot
> +parameter sets the maximum C-state depth (1-9).  A value of 0 disables

Please remove 1-9. According to
	https://edc.intel.com/content/www/us/en/design/ipla/software-development-platforms/client/platforms/alder-lake-desktop/12th-generation-intel-core-processors-datasheet-volume-1-of-2/011/package-c-states/

there is a C10. I *think* this is entirely platform dependent and there
is no real limit on the upper number.

> +``intel_idle`` and falls back to ``acpi_idle``; it does not disable
> +C-states.
> +
>  Higher C-states can be acceptable depending on the user workload's latency
>  requirements.  For ACPI-based platforms, use the ``cpupower idle-info``
>  command to inspect the available idle states.
> @@ -179,6 +184,9 @@ the extra accounting and state book-keeping.
>    ``NO_HZ_FULL`` may be beneficial.  In such cases, users should offload the
>    kernel housekeeping to dedicated CPUs and isolate compute cores.
>  
> +``nohz_full=`` enables tickless operation for a set of CPUs; see
> +:ref:`real_time_boot_parameters` for its interaction with ``isolcpus=``.
> +
>  See also Documentation/timers/no_hz.rst
>  
>  ``CONFIG_PREEMPT_RT``
> @@ -190,6 +198,36 @@ See also Documentation/timers/no_hz.rst
>  This option must be enabled, or the resulting kernel will not be fully
>  preemptible and real-time capable.
>  
> +``CONFIG_RCU_NOCB_CPU``
> +-------------------------
> +
> +:Expectation: allowed
> +:Severity: *info*
> +
> +Enable support for offloading RCU callback invocation from selected CPUs
> +to per-CPU ``rcuo`` kthreads.  The offload is selected with ``rcu_nocbs=``
> +or implied by ``nohz_full=``; enabling this option alone does not change
> +callback placement.  Use it when RCU callback processing causes jitter on
> +CPUs dedicated to latency-sensitive tasks.  See
> +Documentation/admin-guide/cpu-isolation.rst.
> +
> +``rcu_nocbs[=cpu-list]``
> +  Offload RCU callback invocation from the listed CPUs to the
> +  corresponding ``rcuo`` kthread, which can run on a housekeeping CPU.
> +  This keeps callbacks from being invoked on the CPU that enqueued them.
> +  On a non-real-time kernel this also moves invocation out of softirq
> +  context; with PREEMPT_RT, callbacks already run in kthread context
> +  because ``rcutree.use_softirq`` is false, and the offload only changes
> +  the CPU they run on.  If omitted, no CPU is offloaded at boot; the mode
> +  can still be toggled at runtime through cpusets.
> +
> +``rcu_nocb_poll``
> +  Make the ``rcuo`` kthreads poll for callbacks instead of requiring the
> +  offloaded CPUs to wake them.  This improves the real-time response at
> +  the cost of higher power consumption, because the kthreads wake up
> +  periodically to do the polling.  Consider this option only when wakeup
> +  latency matters more than power.
> +
>  ``CONFIG_TRACING`` (and tracing options)
>  ----------------------------------------
>  
> @@ -216,6 +254,96 @@ just by being enabled.
>  These tracers do incur measurable latency overhead even when tracing is not
>  currently active.
>  
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
> +    Equivalent to ``nohz_full=``; see below.
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
> +  The residual 1 Hz tick is offloaded to workqueues; the global
> +  workqueue ``cpumask`` (/sys/devices/virtual/workqueue/cpumask) can
> +  further restrict where unbound work runs.

If you keep this short, and move everything up to the ``nohz`` section
above then it is like the source. And I *think* the workqueue part is
mentioned in the nohz section because workqueue uses the "domain" mask
by default. This part you left out.

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
>  Kernel Debug Options
>  ====================
>  

Sebastian
