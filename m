Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537945;
	b=fClMKeXJC1ra/961hfNeAupm2kGmg3nrcTuv4l/0dhntdHSaJlrf/mUbFfNAoHtAXuvq
	 OHrFbZtgEl4NQCFcBgvR88veSKSWHKNPbQGLSniQYJdsrsqqUxBuU/RafREITH/mmN3AF
	 +Xs+sYP7RjlCUDaVjIBy9VxvOHPNvqOjbET6GcEyrM1kUcB/E8YqsxQWSSw3lFs1qhODN
	 GTcV8++7CUR74lHDG6HOGe/Wm8BIRrJ+bTdAKr2w0aE0msuWdJ0oGivFyH23hHXEVzRGu
	 gXDOsPupqUpmHUwXR6mpzBZG6dPko8IcYwNhIB0sETthJGIjxBbwGz65Pt/8K9IFNEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537945;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=FQQ6X5r63jXO8YunPQTlae6cep++8XOz+K/i9Cf6hkE=;
	b=GacjDZG4TInfrwZ07i8joZwQrYBAwHsZM/a2Lk9+5FgkI+4jx3lmDDJbHsVqPe3iVD1F
	 iRk74LJKcxGKOktlvPvpRReT0WdSXIruZljK4keFHrpuKqHao5YwTYNO9BtQqfdm9TJCu
	 zBbhL+ZYV/I1LM9N3gDhWr12h3yOQ4UNbqfOIX4Ag5sbTR1JrMYnVK138cOGbGZtqr4r8
	 kQXn/Ttb+3HNACqtJjTI64k7xmWKlHFtKZmfq8ZRikSUC0zz1nyvCc1LVYNviJq8HDX8T
	 2/Wn2PnER3CnuNk+Zrdy2JY8t2p16kWbqIHShXxEWr0xnZ6lx+zRDVwi41psHhYEjpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTK+NXQN;
	arc=none smtp.remote-ip=74.125.227.200
Received: from mail-pi2-f8.google.com (mail-pi2-f8.google.com [74.125.227.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87CD606A327
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 16:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B87CD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTK+NXQN
Received: by mail-pi2-f8.google.com with SMTP id 41be03b00d2f7-cdead29f654so70824a12.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 08:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795537944; x=1796142744; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FQQ6X5r63jXO8YunPQTlae6cep++8XOz+K/i9Cf6hkE=;
        b=NTK+NXQN20MQN9AjaQj0yYUMiGw4vCtDbDx8zbvHCEuHcK5ohfXyJFJjlkM8ulTviM
         wq6ypCe3rmm14RjYx7DvEUR2b0nVP3eKIZ5pGSbe1sijsWk0KASqDYIj4S8bh2xG2Dt7
         1MurbmyhFPT8orCawq4HtWGxmzDL/O3JIY9EeEkQ0203uSvrkNXugaemj1+HpnHFbQTE
         uv2BlVcXKqUoslT4HNhh0E5TADO/mAyEWHYyPSwUMAJuAvqxhslyl0hlj5unSDoaGGHu
         HpykdrVPL3bhbq+7P+kSR3ZDul4O4auLfUIT1Hxfhd+t6QHyhmcmVOcZuNqmProKCH9z
         7qFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795537944; x=1796142744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FQQ6X5r63jXO8YunPQTlae6cep++8XOz+K/i9Cf6hkE=;
        b=pkQ1OHiHeJCCmZQHmorOAFHeXzO/sZashMbocX3lx8MkoFLHfpZ9uJlmf66Y6+zRnc
         +vGwzCH2HWvHdBb4LPombEmGrT8FMwZN7fi0/PXgX5AHfu89JjMs7aRi5lKF5oWiyvtJ
         3hbrM2EWM/rocpXZQp9T8Eevthp3nBep79lNICYDPMf0dCgS6bOw16/xDAkqOxuj6Trc
         YT9feFFHJX5Pm9+9CXC2RGfpo4dO1xWvtJ1Lw+btQcS3yYi0FHK6MTRAGPss53HBtPf0
         CENGArOVdAD3WdexuN6XR0YQIX5UrUKi/HOaSVY6jTGxiOMHjOpH8xNvbZKoi+DNA790
         hJ7w==
X-Gm-Message-State: APuU4Z/DYrcognzWZYMXuq4kC2qNPdrt4pddH/+aihnZ5kfwgcEFMaYv
	3AU1eqgA1iz+KlgH5/fsiL7yGSI9yZwW3XqqNPIAd8ICRf0lrk8TUuDJ
X-Gm-Gg: AZFdTZcjPvHtdqPhjGOggYMHYbjOXojIWLJaXb3ijzPGJ2xhouD2FT7NcE5SoKAh1vD
	hxnAb1KOUMCq+7Hih9CZoAEEu1U5Y2NlCgbytY3yud1M/Q3GQsgXTe+l7ZRyjuWTIScawquQakw
	3ScvvmX3Ak4iWsyt+mxLFJMhqGmdbTg8iUAOWbIVeVNvsDePASZ/LAyrVwXhQBPzfuhQB+R61Sk
	kocDPT8StgNmDQxfvBuUCRgSqLcK4sAZFIl39qIC+K44Z8rWRbgwBquDQueQhf9GZLg45u5Wq35
	gUI1XuB0UTXqSgVyAcaJAimcOyCj1Y2DkoQYNiPvC5ESxy7rivHPvbIgPm/d55sZ2/wAowznbhz
	PahNwMMueKOtCwfGUlhSe6V9q4XciuIPzS0+IYZ0fBSlBBX9yy5sj7B5V9ofqo+7I/lQoMhN4nt
	SlD95BmfBlKNhjPIJwXFhgMbUnjVyv35pa2au4jgxPKd/5V8AsRKDwwPQwruczNaiOBgiO04cjZ
	crYoqujK8Oz7zZLh870Nv9SRI4E8/YJSXS9t4rM8PAL/gxyskpdKXWgE5FHPjniNBfmalt4vcCu
	cERzBme7oJFOMDtLmThRKGqLmrAVLgTr1N/PRsACeJX3
X-Received: by 2002:a05:6a00:23cb:b0:88d:20ff:15c9 with SMTP id d2e1a72fcca58-8c87bdb54f4mr14339476b3a.17.1795537943820;
        Tue, 24 Nov 2026 08:32:23 -0800 (PST)
Received: from nixos ([60.186.16.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c14fsm7441328b3a.15.2026.11.24.08.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 08:32:23 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: linux-doc@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	bigeasy@linutronix.de,
	frederic@kernel.org,
	darwi@linutronix.de,
	john.ogness@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	corbet@lwn.net,
	wagi@monom.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org,
	Zixin Wang <w1355457260@gmail.com>
Subject: [PATCH v5] Documentation: real-time: Add boot parameters and task isolation section
Date: Tue, 24 Nov 2026 16:32:02 +0000
Message-ID: <20261124163202.56921-1-w1355457260@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the boot parameters and runtime tunables that affect the
worst-case latency of a real-time system, alongside the existing
kernel configuration guidance.

Cover CPU isolation, nohz_full, RCU callback offloading, interrupt
affinity, and C-state limits, with references to the relevant
documentation.  Keep the C-state parameters next to CONFIG_CPU_IDLE
and the tickless trade-off next to CONFIG_NO_HZ, so each option stays
with its configuration guidance.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220633
Link: https://github.com/elisa-tech/wg-aerospace/issues/222
Signed-off-by: Zixin Wang <w1355457260@gmail.com>
---
Thanks Sebastian for the review.

v4 -> v5:
  - Drop the fixed 1-9 range for intel_idle.max_cstate; the maximum
    C-state depth is platform dependent.
  - Move the residual 1 Hz tick and workqueue details to the
    isolcpus=nohz description, matching kernel-parameters.rst, and
    document that the global workqueue runs on all CPUs by default
    and needs manual affinity or the domain flag.
  - Shorten the nohz_full= entry accordingly.
  - Clarify the rcu_nocbs= and CONFIG_RCU_NOCB_CPU_DEFAULT_ALL
    interaction.

Testing:
  make SPHINXDIRS="core-api" htmldocs and checkpatch.pl pass.

  The host boot, latency, and QEMU C-state observations from v4 are
  unchanged.
---
 .../real-time/kernel-configuration.rst        | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/Documentation/core-api/real-time/kernel-configuration.rst b/Documentation/core-api/real-time/kernel-configuration.rst
index d7f08e7..5ce10d0 100644
--- a/Documentation/core-api/real-time/kernel-configuration.rst
+++ b/Documentation/core-api/real-time/kernel-configuration.rst
@@ -98,6 +98,11 @@ can be achieved by using the boot parameter [1]_::
 
   processor.max_cstate=1
 
+On x86 systems using ``intel_idle``, the ``intel_idle.max_cstate=`` boot
+parameter sets the maximum C-state depth.  A value of 0 disables
+``intel_idle`` and falls back to ``acpi_idle``; it does not disable
+C-states.
+
 Higher C-states can be acceptable depending on the user workload's latency
 requirements.  For ACPI-based platforms, use the ``cpupower idle-info``
 command to inspect the available idle states.
@@ -179,6 +184,9 @@ the extra accounting and state book-keeping.
   ``NO_HZ_FULL`` may be beneficial.  In such cases, users should offload the
   kernel housekeeping to dedicated CPUs and isolate compute cores.
 
+``nohz_full=`` enables tickless operation for a set of CPUs; see
+:ref:`real_time_boot_parameters` for its interaction with ``isolcpus=``.
+
 See also Documentation/timers/no_hz.rst
 
 ``CONFIG_PREEMPT_RT``
@@ -190,6 +198,39 @@ See also Documentation/timers/no_hz.rst
 This option must be enabled, or the resulting kernel will not be fully
 preemptible and real-time capable.
 
+``CONFIG_RCU_NOCB_CPU``
+-------------------------
+
+:Expectation: allowed
+:Severity: *info*
+
+Enable support for offloading RCU callback invocation from selected CPUs
+to per-CPU ``rcuo`` kthreads.  The offload is selected with ``rcu_nocbs=``,
+implied by ``nohz_full=``, or enabled for all CPUs by
+``CONFIG_RCU_NOCB_CPU_DEFAULT_ALL`` when neither parameter is given.
+Enabling this option alone does not change callback placement.  Use it
+when RCU callback processing causes jitter on CPUs dedicated to
+latency-sensitive tasks.  See Documentation/admin-guide/cpu-isolation.rst.
+
+``rcu_nocbs[=cpu-list]``
+  Offload RCU callback invocation from the listed CPUs to the
+  corresponding ``rcuo`` kthread, which can run on a housekeeping CPU.
+  This reduces callback-processing jitter on the CPU that enqueued them.
+  On a non-real-time kernel this also moves invocation out of softirq
+  context; with PREEMPT_RT, callbacks already run in kthread context
+  because ``rcutree.use_softirq`` is false, and the offload only changes
+  where they run.  If the parameter is given without a CPU list, no CPU
+  is offloaded at boot; the mode can still be toggled at runtime through
+  cpusets.  The parameter takes precedence over
+  ``CONFIG_RCU_NOCB_CPU_DEFAULT_ALL``.
+
+``rcu_nocb_poll``
+  Make the ``rcuo`` kthreads poll for callbacks instead of requiring the
+  offloaded CPUs to wake them.  This improves the real-time response at
+  the cost of higher power consumption, because the kthreads wake up
+  periodically to do the polling.  Consider this option only when wakeup
+  latency matters more than power.
+
 ``CONFIG_TRACING`` (and tracing options)
 ----------------------------------------
 
@@ -216,6 +257,97 @@ just by being enabled.
 These tracers do incur measurable latency overhead even when tracing is not
 currently active.
 
+.. _real_time_boot_parameters:
+
+Boot parameters and task isolation
+==================================
+
+Kernel configuration options alone do not determine a real-time system's
+worst-case latency.  Integrators commonly rely on boot parameters and
+runtime tunables as well, to keep kernel housekeeping work away from
+latency-sensitive tasks.  The parameters below complement the options
+described above.  Some of them correspond to a configuration option and
+are referenced from that option's section, so the configuration and
+runtime guidance stay together.  Each one is documented in detail in
+Documentation/admin-guide/kernel-parameters.rst; the notes here focus on
+the aspects that matter for real-time latency.  Consider these options
+only when the workload suffers from the corresponding interference;
+leave them disabled otherwise, as each of them trades flexibility or
+power for a lower worst-case latency.  The notes below follow the
+decisions an integrator has to make: whether to keep tasks off a CPU,
+whether to stop its tick, and where interrupts should run.  Idle state
+limits are discussed with ``CONFIG_CPU_IDLE`` above, and RCU callback
+offloading with ``CONFIG_RCU_NOCB_CPU`` above.
+For the full CPU isolation model and its limitations, see
+Documentation/admin-guide/cpu-isolation.rst.
+
+.. caution::
+
+  CPU isolation is best effort.  Work that is explicitly bound to an
+  isolated CPU, such as per-CPU kernel threads, bound workqueues, and
+  interrupts, may still run there unless it is steered away.  Measure
+  the resulting latency with tools such as ``osnoise``, ``timerlat``,
+  and ``rtla`` rather than assuming that an isolated CPU is free of
+  kernel noise.  See Documentation/timers/no_hz.rst and
+  Documentation/tools/rtla/index.rst.
+
+CPU isolation
+-------------
+
+``isolcpus=``
+  Format: ``[flag-list,]<cpu-list>``.  Isolates the listed CPUs from the
+  disturbances selected by the flag list (default: ``domain``):
+
+  ``domain``
+    Remove the CPUs from the scheduler domains.  This is the default
+    when no flag is given.  Domain isolation cannot be undone at
+    runtime; use cpusets when the isolated CPU set must change
+    dynamically.  Isolated CPUs remain usable through CPU affinity or
+    cpusets.  Unbound workqueues and unbound kernel threads are
+    confined to the housekeeping CPUs as a side effect.  Consider it
+    for CPUs dedicated to a latency-sensitive workload.
+
+  ``nohz``
+    Equivalent to ``nohz_full=``; see below.  The residual 1 Hz tick is
+    offloaded to workqueues, which must be affine to the housekeeping
+    CPUs through the global workqueue ``cpumask``
+    (/sys/devices/virtual/workqueue/cpumask).  By default the global
+    workqueue runs on all CPUs; configure this cpumask manually after
+    boot, or use the ``domain`` flag to confine unbound workqueues.
+
+  A practical configuration therefore combines ``isolcpus=`` with
+  ``nohz_full=``, ``rcu_nocbs=``, an interrupt affinity mask, and, on
+  x86 systems, a C-state limit.
+
+  Timer placement follows the same choice.  By default a migratable
+  timer expires on the CPU that armed it; with ``nohz`` (or
+  ``nohz_full=``), timers and hrtimers armed on the isolated CPUs are
+  migrated to housekeeping CPUs.
+
+``nohz_full=``
+  Format: ``<cpu-list>``.  Requires ``CONFIG_NO_HZ_FULL=y``.  Stops the
+  scheduler tick on the listed CPUs whenever possible.  The boot CPU is
+  forced outside the range to maintain timekeeping, and the RCU
+  callbacks of the listed CPUs are offloaded as if they had been
+  passed to ``rcu_nocbs=``; see the ``CONFIG_RCU_NOCB_CPU`` section
+  above.  This parameter takes precedence over
+  ``CONFIG_RCU_NOCB_CPU_DEFAULT_ALL``.
+
+  The trade-off between tickless operation and the kernel-to-userspace
+  transition latency is described in the ``CONFIG_NO_HZ`` /
+  ``CONFIG_NO_HZ_FULL`` section above.
+
+Interrupt affinity
+------------------
+
+``irqaffinity=``
+  Format: ``<cpu-list>``.  Sets the default affinity mask for
+  interrupts that do not have an explicit affinity, steering them to
+  the housekeeping CPUs.  Managed interrupts are not affected by this
+  setting and cannot be redirected through ``/proc/irq/*``.  Verify
+  the resulting placement in ``/proc/interrupts``.  See
+  Documentation/core-api/irq/managed_irq.rst.
+
 Kernel Debug Options
 ====================
 
-- 
2.54.0

