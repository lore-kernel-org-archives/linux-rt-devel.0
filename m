Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795158405;
	b=OAne7EpeCnG3Ag3BhIML8YpeX2DJ+TMU+GW/5OhB8oIyuJTHvtdSkfoD1NQY/gFF4PCE
	 wFmgC6mVKNtdw2coTI0e/UxJaI8NXvQzmqhB2yGUgx6cmribtHdSX3A2yTVB1mv5rybTv
	 4OOLefPgsZ7JPuWK7qpEJzvuRcxyr2h+5pX6WukbluWAB0yskURhlXe7FdSx4bPApnBsZ
	 HO1OpXp4v/laAEISeUehm9vk02gj5G116IwZ7n9f1skQWxcUWrMr+2KBJyiU/tBkKIB7q
	 G8r0MNStkPTO6e0FLrXQYrX8YUNyZGndMmKjdHtg0U025vP4nHIwqLAw8KCxTWoaljg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795158405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=DNfItCD3Z4BoYtins2/yOU+Coq3wbYX7eM32Pd4EAjg=;
	b=p8swfZ4ka0HRAmeMyeLxJU1DELg2wB202lyNbu4Hqb9ml3Yv0zgDtAnbcMYxgR2pxycb
	 N0B1hpESEIjjKx4wJa2o2TyZHVlOFiJvc/Wozw6a0t9NJqyItRd4/6X0m/q1aEQVEjcJy
	 IuzBSGeQx6c9I4JJNKUHDvTie2qGhiIeF9daUPaq+Rkba1sUmPiIRGYlKuoZ03ReFO4aM
	 2fxbiXCfTxKV4E3E/m0a6wqF9g11gldEDZ3o5VyTJFfhXbnr7ToTxAVx5UQUJhH3HBlNi
	 kFsa9Y1Bg4z5iiLJfIziPvvZYdcWSgxJfyFC44eujNC+jtaU7eIS5AM7gAl9QFD9lKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rnGNTEtJ;
	arc=none smtp.remote-ip=74.125.227.134
Received: from mail-pj2-f6.google.com (mail-pj2-f6.google.com [74.125.227.134])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2669606A325
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 07:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2669606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rnGNTEtJ
Received: by mail-pj2-f6.google.com with SMTP id 98e67ed59e1d1-3b1c4ce7151so136022a91.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 23:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795158403; x=1795763203; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DNfItCD3Z4BoYtins2/yOU+Coq3wbYX7eM32Pd4EAjg=;
        b=rnGNTEtJwqk5XgSHQdyxKADy8TKecw/c0YdNZvb8wxGQ0d8bmWNHoyNBHkfA1cIuLu
         D3kcrr4aGLPCyVI1W+8TRz4EsMEhDZC9h5+vM117zF+eylhpMIdLl/SIyttOUThQdkBR
         zm0Q8icE5XL+DXB6+jEWx8KrmZjR6xcbHpv0vKwPITOYXgnpZw/mDklWzEc82JgPCyjg
         xoPy7iyL3bXXSCUfncZ7AN/dX+uXLVMJWKcep5/nnHppkvF+Oz2iwU9tj1iFrbFOkxSg
         rKVdJ67+ISBhy8zVcQI24Azl5Io4wVqZwpUyMJxJIzlhoD4s7xD5RHXntuY8wEC9J0f3
         bCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795158403; x=1795763203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DNfItCD3Z4BoYtins2/yOU+Coq3wbYX7eM32Pd4EAjg=;
        b=i3X3dX8tmVmX7l7Eiqbb/TPr2m3b87Jy99yl0p+0uVB4S02tvT/PtJw7dtumIFxcUQ
         reveGdx/gln6W1TRYOnNRNdBXJk/7U5671BzHpAJ3PU78khyyJicvFhAMh+uydfQiF7n
         I+/fq0TxlXlZd9w//2w5O4EuHGX6TS6AtbZrMAa94ghZ6bY0su8EXsVD4ohqz/0rqE3Q
         XaQoE5jj0tYQ+3msaUkuP2f+r4eMtkk5V0NgPoim8anSix5DhQlKt65ccqtE9jxNjXB8
         TTRtcSvyn2/9gVw76Z34a1o4dD7JfwgwPXtlSU0gB2YCTTEMOYiiTRCFUx2H1JIudXXR
         GppA==
X-Gm-Message-State: APuU4Z8TG0KZy1xatKKDegF4+CCsspVCMnDB1+QH+AScSxUJTXypuCxt
	v95g47ra9P8uFkIgyGVuL/Om/tT+Aiz4AYA3hPwSRpHG8hkj+IystDV9
X-Gm-Gg: AZFdTZfGSCYqgjDiisvqL6s0w8lpSGTS6NJMLYTqpsS9MuqMGhaZET4bz3wB7UuQPTf
	noDOF/kxKtALI9zOJKGIyH7ACS7UXj+n/JTkg2Mco84GXkqbhsazqZxKE7tsNAGDQXZexliPzEg
	sY/N6u7hHSTFR6s6fkBBpgGKEswzwCBF4sbtGTQEqEn1bM908YGnMw4sKuD/duAk1ACdMQfSezT
	wROd8yPFLeZku9Bycogl9i1nW8PB6h+rKt4fgTzYG7kIGXmtXDLaf8tS1u5FP11DiI6zxpjdqaZ
	pUxh6OzxYW4Gt4K3IR7gQiWSjh5IXGQmb2AeOS5nl8geGGiGeucmXAa8nZZPBx3T/EEqstZDNFt
	7wQ5WvnHIK6ez8tgqRlDqmBlzBAQ84gPWuCD8iS1bDt33jGKYmwgB90fLjUs9fjHs8TBLRG6BP6
	8OGksb96fWvS5MKGVV2MDm2tZXngv5iWGpCIwpm9pgM1vsXKtIEGKo8Wvw6nPQufIVlbL65KcCW
	rN93FscJw+oPK2AAMjEfxKEaa7z5cFA7syg6VUpBCSU3h4otBEbXA1M/9sBb1Aiwzx2BF2RyAzF
	rbnic69a3kWEAUaSs77MIWqPfYcKP1k6TLWBxVnJ0CnKLA==
X-Received: by 2002:a17:90b:2c84:b0:3ac:a203:e092 with SMTP id 98e67ed59e1d1-3b41c7b6864mr1838751a91.1.1795158403117;
        Thu, 19 Nov 2026 23:06:43 -0800 (PST)
Received: from nixos ([2409:8a28:ae4:7f20:fd8b:76d8:48d:6284])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ffbab7fsm1016361a91.0.2026.11.19.23.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:06:42 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: linux-doc@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	Zixin Wang <w1355457260@gmail.com>
Subject: [PATCH v2] Documentation: real-time: Add boot parameters and task isolation section
Date: Fri, 20 Nov 2026 15:06:20 +0800
Message-ID: <20261120070620.535693-1-w1355457260@gmail.com>
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
affinity, idle states, and real-time throttling, with references to
the relevant documentation.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220633
Link: https://github.com/elisa-tech/wg-aerospace/issues/222
Signed-off-by: Zixin Wang <w1355457260@gmail.com>
---
v1 -> v2:
  - Fix the kernel.sched_rt_runtime_us description: the default runtime
    is 1000000 us and, without CONFIG_RT_GROUP_SCHED, SCHED_FIFO/RR tasks
    are no longer throttled through this sysctl.  Describe the per-CPU
    fair deadline server (50 ms per 1000 ms) instead.  Reported by
    Sashiko.
  - Clarify the isolcpus= flag semantics: only the domain flag removes
    CPUs from load balancing, and the remaining flags do not affect
    unrelated kernel threads, timers, or interrupts.  Review feedback.

 .../real-time/kernel-configuration.rst        | 141 ++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/Documentation/core-api/real-time/kernel-configuration.rst b/Documentation/core-api/real-time/kernel-configuration.rst
index d7f08e7b..995674b9 100644
--- a/Documentation/core-api/real-time/kernel-configuration.rst
+++ b/Documentation/core-api/real-time/kernel-configuration.rst
@@ -216,6 +216,147 @@ just by being enabled.
 These tracers do incur measurable latency overhead even when tracing is not
 currently active.
 
+Boot parameters and task isolation
+==================================
+
+Kernel configuration options alone do not determine a real-time system's
+worst-case latency.  Integrators commonly rely on boot parameters and
+runtime tunables as well, to keep kernel housekeeping work away from
+latency-sensitive tasks.  The parameters below complement the options
+described above.  Each one is documented in detail in
+Documentation/admin-guide/kernel-parameters.rst; the notes here focus on
+the aspects that matter for real-time latency.  For the full CPU
+isolation model and its limitations, see
+Documentation/admin-guide/cpu-isolation.rst.
+
+.. caution::
+
+  CPU isolation is best effort.  Unbound workqueues, kernel threads,
+  timers, and interrupts may still run on isolated CPUs unless they are
+  explicitly steered away.  Measure the resulting latency with tools
+  such as ``osnoise``, ``timerlat``, and ``rtla`` rather than assuming
+  that an isolated CPU is free of kernel noise.  See
+  Documentation/timers/no_hz.rst and Documentation/tools/rtla/index.rst.
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
+    cpusets.
+
+  ``nohz``
+    Stop the tick when a single task runs and offload kernel noise,
+    including RCU callbacks.  This is equivalent to ``nohz_full=``.
+    The residual 1 Hz tick is offloaded to workqueues, which must be
+    affined to housekeeping CPUs through the global workqueue
+    ``cpumask`` (/sys/devices/virtual/workqueue/cpumask); by default
+    that workqueue may run on any CPU.
+
+  ``managed_irq``
+    Prevent managed interrupts from being targeted at isolated CPUs
+    when their automatically computed affinity mask also contains
+    housekeeping CPUs.  This is best effort and has no effect when the
+    mask contains isolated CPUs only.  See
+    Documentation/core-api/irq/managed_irq.rst.
+
+  Apart from the best-effort managed IRQ redirection, these flags do
+  not stop kernel threads, timers, or interrupts that are already
+  affined to the isolated CPUs.  A practical configuration therefore
+  combines ``isolcpus=`` with ``nohz_full=``, ``rcu_nocbs=``, an
+  interrupt affinity mask, and a C-state limit.
+``nohz_full=``
+  Format: ``<cpu-list>``.  Requires ``CONFIG_NO_HZ_FULL=y``.  Stops the
+  scheduler tick on the listed CPUs whenever possible.  The boot CPU is
+  forced outside the range to maintain timekeeping, and the RCU
+  callbacks of the listed CPUs are offloaded as if they had been
+  passed to ``rcu_nocbs=``.  This parameter takes precedence over
+  ``CONFIG_RCU_NOCB_CPU_DEFAULT_ALL``.
+
+  Tickless operation can increase the kernel-to-userspace transition
+  latency, so it is most useful for workloads that execute in
+  userspace for long periods with few syscalls.  Periodic workloads
+  with short periods may prefer a consistent tick instead.
+
+RCU callback offloading
+-----------------------
+
+``rcu_nocbs[=cpu-list]``
+  In kernels built with ``CONFIG_RCU_NOCB_CPU=y``, move RCU callback
+  invocation for the listed CPUs out of softirq context and into
+  per-CPU ``rcuo`` kthreads.  This reduces OS jitter on the offloaded
+  CPUs.  If the argument is omitted, no CPU is offloaded at boot, but
+  the mode can be toggled at runtime through cpusets.  ``nohz_full=``
+  implies the same offload for the CPUs it lists.
+
+``rcu_nocb_poll``
+  Make the ``rcuo`` kthreads poll for callbacks instead of requiring
+  the offloaded CPUs to wake them.  This improves the real-time
+  response at the cost of higher power consumption, because the
+  kthreads wake up periodically to do the polling.
+
+Interrupt affinity
+------------------
+
+``irqaffinity=``
+  Format: ``<cpu-list>``.  Sets the default affinity mask for
+  interrupts that do not have an explicit affinity.  Managed
+  interrupts, such as MSI-X queue interrupts, derive their affinity
+  from the device queue mask instead and cannot be changed through
+  ``/proc/irq/*``.  Combine ``irqaffinity=`` with the ``managed_irq``
+  flag of ``isolcpus=`` to keep interrupts away from isolated CPUs
+  where possible.  See Documentation/core-api/irq/managed_irq.rst.
+
+Idle state limits
+-----------------
+
+``processor.max_cstate=``
+  ACPI platforms only.  Limits the deepest C-state the processor may
+  enter.  ``processor.max_cstate=1`` caps the processor at C1 and
+  avoids the entry and exit latency, cache flushing, and clock effects
+  of deeper states.  A value of 9 overrides any DMI blacklist limit.
+
+``intel_idle.max_cstate=``
+  x86 platforms using ``intel_idle`` only.  A value between 1 and 9
+  specifies the maximum C-state depth.  A value of 0 disables
+  ``intel_idle`` and falls back to ``acpi_idle``; it does not disable
+  C-states.
+
+Deeper C-states save power but increase wakeup latency.  Choose the
+shallowest state that still meets the platform's power and thermal
+requirements, and validate the result with the tools listed above.
+
+Real-time throttling
+--------------------
+
+``kernel.sched_rt_runtime_us``
+  Together with ``kernel.sched_rt_period_us``, this sysctl defines the
+  total bandwidth available to SCHED_DEADLINE entities.  When
+  ``CONFIG_RT_GROUP_SCHED`` is enabled, it also limits the bandwidth of
+  the real-time scheduling groups.  The default runtime equals the
+  period (1000000 us), so no bandwidth is subtracted from deadline
+  tasks by default.
+
+  Without ``CONFIG_RT_GROUP_SCHED``, SCHED_FIFO and SCHED_RR tasks are
+  no longer throttled through this interface.  Instead, a per-CPU fair
+  deadline server keeps non-real-time tasks running by providing
+  50 ms of runtime per 1000 ms period.  That reservation is not
+  disabled by setting this sysctl to -1; the server parameters are
+  exposed under /sys/kernel/debug/sched/fair_server/cpuX/.
+
+  A value of -1 removes the total deadline bandwidth limit, that is,
+  runtime equals period.  Do this only after validating the workload,
+  because runaway real-time tasks can then starve the rest of the
+  system.  See Documentation/scheduler/sched-rt-group.rst for RT group
+  scheduling details.
+
 Kernel Debug Options
 ====================
 
-- 
2.54.0

