Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188551;
	b=guwgbBFu/8hz4OAffLFap91LOvDXfqYKlmuiLQQ8Ihcl0rtYS6NXb2lN3GR7kxi+0Am6
	 IGcgX8vfqdx4iIYh9fYEiF3jw9nz4VxjHTVi1a4F2xH5fVN/9/SjRCibLBnjOcmLzoSiH
	 cBgh4c/TE5WF9ZeoEel03p81aNQpV3s5/h7kXkHX4ONCs502h6T+HHzV/HFCPZYG2Asfh
	 oIgQdV95V5P5vEER5atBioOF2YvKoX2dEqgUYkJOptabYFt3r1j4qXRNz5to9eCRcYt78
	 UqL+SJmaT0qIUcz5IHQ2vQIaLco2EDWYz+nJFG3qz3KMeBItceRoC6fyD2t2+O+wqsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=uzA49QxuK5wCejR8YkAwkvdhpULE3l6iDV8rffStUcU=;
	b=tXziZQC34J3LUp9D5XqUsXox4ozU8d70JCNMK/Ns+/0OBpEWR/eSAb3jyotFUgltow6O
	 fcAY44Dr3blUUZR069rcZZMuG1y7WLZsMP7NDz4MSrLPUPFr5PW6H/KKFrKxP1ikig2WL
	 slDJWO7o7pzElI+HUXzdknjbAUWxq3Pw03Iei9//+rhgXJlz12Q2RzdHNfajQjrzPQU8o
	 JkwZRNNoGUWsqZyw3c3vtr8Gqv0GhxbX4Mw/eXRELJUOK5JknPdgeoxk6cOVq34nBdY+E
	 qf6HW/LquFB26AesKkQ9HxkiNBjF9fOCKfx3gwlNrjZpQEe739HqB8qgUGb/x5QnZWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aCP+JiAG;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA94606A320
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 15:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AA94606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aCP+JiAG
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3b3fb6d5edeso208729a91.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 07:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795188550; x=1795793350; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uzA49QxuK5wCejR8YkAwkvdhpULE3l6iDV8rffStUcU=;
        b=aCP+JiAGx5Dg4MZQdY5FtGW5/aaeO7l7ERlv9CPPqOfOvkl2gVKsvo792Hszxk0c2Z
         3t3icEiUyMVOQxhS2c9dQqf6UvyLjxiLzPT7VjUQL0k+3w2rgLSJqbGDUj2EtgNCVIat
         bMhbvQKTMW1LzRr1VWTcwHMRWYDSD2biKbgR6fnTejGxMFHLODDkjp4WkoPkZHxgDZwx
         jlDB28gstaJ7hvgU0ajQuTsJNjOZObk/YrLzkq+PaFCH0ymYyz3JYSZkqSqVAXGC6UiA
         1br6AbIDM1jw5fSw/J5z4DlNqgQZV17RGW2MRs9ABTKGx+eKew/mcVxlzqo+e1d6TtJC
         h2dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795188550; x=1795793350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uzA49QxuK5wCejR8YkAwkvdhpULE3l6iDV8rffStUcU=;
        b=W800/UPLwgagoU9Gtmo44+DcFjg/+obS3U5I1BsMQDLftjlauheC67k8WhnPFaO/YT
         Dh+1Azs5v7DNyTFncWnWoIbLD+LsOsxd9kwAuWoteUpvHzsCcC1yAYNfc/BvB0KEOzNM
         YRUnDM1M+jBWzcCEn81cDWgYkm9d4kXAPtWLkCcE6qwMzJ2stKASqtUPpLJHq0Xwdtg3
         vdkWtlnIozQOr6v1mVEO1w5Ze+XGtZPZoYcOtYFb90pgIRx7Dn7VUd4lajfrIEprNcP8
         L0WA/lEevNxiaJZn8++mNQwkQ68z2dGtPWmyQu+q+37fGlJ/lvN8o13qMWBDsd9Ufa52
         P5TA==
X-Gm-Message-State: APuU4Z+57QHsyaPR17jvRf4As5QP+MnIY3E7hmpqDSzXFAtDJ4AK0LKi
	M89iBR2w7/mo3KBe3FnIZ8Y99BVZ3MNryKrcbRkSjsU7aW8B3rbaY2UTVbS/bFEzB0CeqA==
X-Gm-Gg: AZFdTZcTkBLzG1oc0eT2y7V1VdVFhpYqmW0dbwGMw7deCYmFEd0tO/zpyk2HEHzwr5x
	5VUE5RW0gOXp2ARxinmpFhgbfPOXu8Ax22x5JTFWwmaZxVeJE2KFFtEMNiWQ/jWAjvFJd7FR8HG
	d2UTxjwB6z2ei1eG4luDVe57lRNe7FxSN+kLFY75h6xDHdD895aNkE3MwoqDf144f1+OjFTOg0E
	jXcbyEACG9COk/4ZmKBTpeBVz97a6MfZU3dqRafkAD8hcAQ8OJ2nuKLoTkL0My20Vd/Yt8HZAkd
	mshDf8xFCMOQBqHfW8Bg6+CP5HFGOcqge0mz3Vi0ijbVjql7a/yXuWvxmdAhiXojc6wKhvBA7sJ
	f+XxW66qSjEIFSAHdkexrQ6pZ78GffJDoOEhjQjHKplbrhspU1ZJiNo09qyDy6mXTtAufuSPpja
	0jULoWYZ1oXbhFBQNY5ol0jwMPk2s5M/EJKetEoQH6uqdVCv/5tRbQz0+5uLZtWcsbDOcr3ZXxZ
	gjyMznZiqDx+H0x6HAyYsgguFMp+RrCj/fRQvG9WLZd3lWA/yp7vuBUGz3bJcJbiSvBGaVrgupD
	IW1sgzmO/noo9so/gtV+Iw==
X-Received: by 2002:a17:90b:3fc5:b0:3b4:166a:27cf with SMTP id 98e67ed59e1d1-3b41c902ba8mr3313427a91.21.1795188549395;
        Fri, 20 Nov 2026 07:29:09 -0800 (PST)
Received: from nixos ([218.72.8.127])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a34asm4683836a91.3.2026.11.20.07.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 07:29:08 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: linux-doc@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	corbet@lwn.net,
	frederic@kernel.org,
	wagi@monom.org,
	atomlin@atomlin.com,
	linux-kernel@vger.kernel.org,
	Zixin Wang <w1355457260@gmail.com>
Subject: [PATCH v3] Documentation: real-time: Add boot parameters and task isolation section
Date: Fri, 20 Nov 2026 23:28:36 +0800
Message-ID: <20261120152836.100638-1-w1355457260@gmail.com>
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
affinity, and idle state limits, with references to the relevant
documentation.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220633
Link: https://github.com/elisa-tech/wg-aerospace/issues/222
Signed-off-by: Zixin Wang <w1355457260@gmail.com>
---
Thanks Sebastian for the review and for the pointer to the sched_dl
series.

v2 -> v3:
  - Rework the isolation caveat: explicitly bound work, such as per-CPU
    kthreads, bound workqueues, and interrupts, can still run on
    isolated CPUs; unbound work is steered away.
  - Clarify the flag responsibilities: domain isolation confines
    unbound workqueues and kernel threads to the housekeeping CPUs,
    while nohz/nohz_full handles the tick, timers, and RCU callback
    offload.  This was calibrated with local QEMU boots (domain-only,
    nohz-only, and combined configurations).
  - Describe rcu_nocbs by the CPU the callbacks run on, and mention
    rcutree.use_softirq=false on PREEMPT_RT.
  - Drop the managed_irq flag description while that area is being
    reworked; no position is taken on where I/O completion interrupts
    should be delivered.
  - Remove the MSI-X example from irqaffinity and state that managed
    interrupts are not affected.
  - Qualify the C-state limit as x86/ACPI specific.
  - Drop the kernel.sched_rt_runtime_us subsection; that documentation
    is being reworked in the sched_dl series.
  - Frame the section around the decisions an integrator has to make,
    and spell out the timer placement choice: a migratable timer
    expires on the CPU that armed it unless nohz/nohz_full migrates it
    to a housekeeping CPU.
  - Add when-to-use guidance for rcu_nocbs, irqaffinity and C-state
    limits, and state that options should remain disabled when no
    corresponding interference is measurable.

Testing:
  QEMU/KVM with 8 vCPUs and a virtio-scsi device with two queues,
  based on linux 7.3.5 with NO_HZ_FULL and RCU_NOCB_CPU enabled:

  The tests that check per-CPU behavior were pinned to CPU 6 and the
  affinity was verified from /proc/self/status.  These measurements
  verify the knob behavior; the guidance on when to use each option
  comes from the referenced documentation.

  - Domain-only and domain+nohz confine the unbound workqueue cpumask
    to the housekeeping CPUs; nohz-only leaves it unrestricted.
  - rcuo kthreads run on housekeeping CPUs when domain isolation is
    active; rcu_nocbs without domain isolation leaves them
    unrestricted.
  - Timers and hrtimers created on a nohz-isolated CPU expire on
    housekeeping CPUs; without nohz they expire on the isolated CPU.
  - With nohz, the per-CPU tick handler did not run on the isolated
    CPU while a pinned task was running; without nohz it did.
  - isolcpus=managed_irq moves a virtio-scsi queue interrupt from an
    isolated CPU to a housekeeping CPU.
  - The fair server reports 50 ms of runtime per 1000 ms period and
    sched_rt_runtime_us defaults to 1000000.
  - A PREEMPT_RT build boots as PREEMPT_RT; rcutree.use_softirq is
    false in that build (its module parameter is not exposed on RT).

  processor.max_cstate and intel_idle.max_cstate could not be
  exercised: QEMU exposes no ACPI _CST states, so no cpuidle states are
  registered, and intel_idle is not built for this AMD test setup.

One open question about the idle state limits section: I could not
exercise processor.max_cstate or intel_idle.max_cstate locally.  QEMU
exposes no ACPI _CST states, so the kernel registers no cpuidle states,
and intel_idle is not built for this AMD test host.  Should the section
stay as documentation-only guidance, or would you prefer that I drop or
rework it (for example, by pointing to
Documentation/admin-guide/pm/cpuidle.rst)?  I am happy to adjust it.

 .../real-time/kernel-configuration.rst        | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/Documentation/core-api/real-time/kernel-configuration.rst b/Documentation/core-api/real-time/kernel-configuration.rst
index d7f08e7b..0e28dd94 100644
--- a/Documentation/core-api/real-time/kernel-configuration.rst
+++ b/Documentation/core-api/real-time/kernel-configuration.rst
@@ -216,6 +216,138 @@ just by being enabled.
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
+the aspects that matter for real-time latency.  Consider these options
+only when the workload suffers from the corresponding interference;
+leave them disabled otherwise, as each of them trades flexibility or
+power for a lower worst-case latency.  The notes below follow the
+decisions an integrator has to make: whether to keep tasks off a CPU,
+whether to stop its tick, where RCU callbacks and interrupts should
+run, and whether deep idle states are acceptable.  For the full CPU
+isolation model and its limitations, see
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
+    Stop the tick when a single task runs and offload kernel noise,
+    including RCU callbacks.  This is equivalent to ``nohz_full=``.
+    The residual 1 Hz tick is offloaded to workqueues.  The global
+    workqueue ``cpumask`` (/sys/devices/virtual/workqueue/cpumask) can
+    further restrict where unbound work runs.
+
+  Domain isolation steers unbound workqueues and kernel threads away
+  from the isolated CPUs, while ``nohz`` (or ``nohz_full=``) moves the
+  tick, timers, and RCU callback processing off them; work explicitly
+  bound to an isolated CPU is not affected.  A practical configuration
+  therefore combines ``isolcpus=`` with ``nohz_full=``, ``rcu_nocbs=``,
+  an interrupt affinity mask, and, on x86 systems, a C-state limit.
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
+  In kernels built with ``CONFIG_RCU_NOCB_CPU=y``, offload RCU callback
+  invocation from the listed CPUs to the corresponding ``rcuo``
+  kthread, which can run on a housekeeping CPU.  This keeps callbacks
+  from being invoked on the CPU that enqueued them.  On a non-real-time
+  kernel this also moves invocation out of softirq context; with
+  PREEMPT_RT, callbacks already run in kthread context because
+  ``rcutree.use_softirq`` is false, and the offload only changes the
+  CPU they run on.  Consider it when RCU callback processing causes
+  jitter on an isolated CPU.  If omitted, no CPU is offloaded at boot;
+  the mode can still be toggled at runtime through cpusets.
+  ``nohz_full=`` implies the same offload for the CPUs it lists.
+
+``rcu_nocb_poll``
+  Make the ``rcuo`` kthreads poll for callbacks instead of requiring
+  the offloaded CPUs to wake them.  This improves the real-time
+  response at the cost of higher power consumption, because the
+  kthreads wake up periodically to do the polling.  Consider this
+  option only when wakeup latency matters more than power.
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
+Deeper C-states save power but increase wakeup latency.  Consider
+limiting them only when wakeup latency matters; otherwise leave the
+platform's power management unchanged.  Choose the shallowest state
+that still meets the platform's power and thermal requirements, and
+validate the result with the tools listed above.
+
 Kernel Debug Options
 ====================
 
-- 
2.54.0

