Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.203
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795153374;
	b=mCSgl5cU8R/ZrDFvQ5ltrsVo0Vf5PMCYsXNee6MirePQOHe3JyYIKt1I4D3Nr520fUub
	 Gzj2ajmQh68VZdvSLih4Y4d8+YbMWvxrlcyl7BspMOuJntIwY45x8RwJpcALhaPrAa1B/
	 5XKWf/cLLxBRdMyzpTBg1MAVbVuXZqWWUNiS8GH+tVA+uYgWJQE9GTplb6SVPncWKFT/E
	 eYn7hP67gZeQGRM8b7UZUqfBV3zq+UGZ1u0J8C5sY0e9TeVtn/slNDQZ23ACSmU37dn+I
	 CBDj0mNWNzmPJ6sbfnn5nF9UFdgt2tMclnOF9RnYuZfEfMUOKF1+3UyuEMRkIK6xRMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795153374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=PRVj0Zfy4s8iK7gSS3v+F/enDQYd0fmloOn08T3wYJ4=;
	b=oSqc4eCV4imE0Jdsacu1JHQCBALafwZ5VdtTJGMGorF5iZBkzX3mBYuUVdnatBNXnNCb
	 jOGSAPO1MJwli8WwAtC+lwxkVlTDEkR9uVfieQdjY33swllOkfF17m8p4fdS9OFFTWQtu
	 iH6IiYk42VnYi1WXv6o7u6qQcPKROx1hE425baCjCvT/nCe7Cc826mZjgxAUlbFvwAXm2
	 1VIbZtwvehmEiySW0MzdZ/clEmQXw3vJUhKmFDnvH5XbSDGMl2qhREu/fd5cyvTJTftX4
	 pXyC+FsJ6kGuXajiCCKF0CcT9ixWSnfa36pGcq4IEUuWjqW8zj0jh5966CQ8JCgMNfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fcGgXxoO;
	arc=none smtp.remote-ip=74.125.227.203
Received: from mail-pi2-f11.google.com (mail-pi2-f11.google.com [74.125.227.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBD9606A320
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Nov 2026 05:42:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7EBD9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fcGgXxoO
Received: by mail-pi2-f11.google.com with SMTP id 41be03b00d2f7-cdde34e1e0aso228728a12.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 21:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795153374; x=1795758174; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PRVj0Zfy4s8iK7gSS3v+F/enDQYd0fmloOn08T3wYJ4=;
        b=fcGgXxoOI4STD7Sn6bj6KTO+IG/NiVkEfrudCk2NYHxVJyDEQFnsvKvgdG9Q6X0+k9
         rC9ZdRvc1D01lTIaWpB/UW/gEGAmUsZi/3n8pJTBRywoj8G1g8oF292U7cHGMU4k9r2d
         UYOOYQW7HV3cmYihmRWTwqe+RACp1ci3IROV6sIrWUs+o62u7edQGRcOU/9bypQGr65y
         7qMJFdxJIwMwdN3NP8LPgz1fve+lr7kiQ0RXfg6PLrRh4K1fIBSP1ZyKTi4nIIHkdOf5
         WU4csNcZWz01JzWAl63JkXa5OZxsZWG1gfIU1cqw6uuYLdpLYtGj9AcbcurAvroGYNyW
         kCMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795153374; x=1795758174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PRVj0Zfy4s8iK7gSS3v+F/enDQYd0fmloOn08T3wYJ4=;
        b=Xcq+V/SJlChYqP7aXfCPOyg//gzBK/M0Uilc4/JtA7p+0Up3b11g8XYacCRFThO2lN
         rqmdlKMQcsa/ca6GL1pVKC5IHnayqlXjCW3jEmtjlBHvQCklhC4ttOsX70HINzaRCtJf
         69jxl3xw7sIDn5gQ8tgg0yKSHixL62lqeT4CNNpvM3rjl4yM4L36IfpgN88wYm7btYCR
         rf9tjQTvGSiw2ObUP60UKYjIpN5Bna/P34XB2AVCiWaDFCZLOuL0qiTP8xS+BpIyBPtb
         6oJ8viRZ2GZZOL4FyJhcoGESINa1ErulAKvNjUUHFkaqLg3d6FD/bw43/a/67xFALy7d
         Rhwg==
X-Gm-Message-State: APuU4Z9ixzqV9en16IH83lvRgayUD5RmzEpR2+wILIwaidLAdC62rsib
	wjsw9Mi+Wt3ADa5wwCZSZ1n7h4QiQa/S2Y5cbLw65Rt71hgaYvXsxxQf
X-Gm-Gg: AYBFou0CGBbeWc+o80FrQRTwUaWFDmb7AROVO+lvAm+nzdbW+IHuJAW8NAqEaiXFSMP
	2iMLYoMFMHJGaqIZsD9OlRLb/+mMxoS+kVfLjC5XKYEKafKDmI8Pi/X8HrdVwQ9AubZQOzhsqXX
	KyOSvb7qLtaf3SOKwSb4ddfehytwFBltLpWOKzr2meAp2qEQcDxpqWf67oIwByptD1o6i5lLYo3
	ElYTTuH2UFOY+47w/zk7Qfz1d9QPKqqdNHjwX7Jo5Myi3mSAkbI8BSr2d98IDwDn94jJjY334lG
	pQ2XwkRm5lJwEuFQi+4jSgRrYLoIiVtxPMrrkYu6JS9bHvBNTGdrZCS3xTkwix9ZQ3ynb1MTGc0
	4qU50IFugyxMyAfPca9uP6njYfgtF9TGMQzTO9PKqD3aTfK8x1BcpT4Vpxgk1RDRWw1fIt/I0PX
	9ReNkMat4QbDowqnjrAQUztAvzBwf3EPTP9HHmsy8fqWRjnxFYo9XWU89vleOfCFffG9J3/fhlJ
	j8t5Ad3ShBU0VAcRcQs5xh/Zk00zXe9kzWOTRof6d5Nf/mF/+kdNIrwpXErbCljmDXdM38v2AeJ
	RsHUbcuoYk9DUThbtFnPB7Vc
X-Received: by 2002:a05:6a20:c887:b0:3ff:f20b:d2ec with SMTP id adf61e73a8af0-4014dd66078mr2060410637.52.1795153373567;
        Thu, 19 Nov 2026 21:42:53 -0800 (PST)
Received: from nixos ([2409:8a28:ae4:7f20:fd8b:76d8:48d:6284])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c219sm947000b3a.18.2026.11.19.21.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 21:42:53 -0800 (PST)
From: Zixin Wang <w1355457260@gmail.com>
To: linux-doc@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	Zixin Wang <w1355457260@gmail.com>
Subject: [PATCH] Documentation: real-time: Add boot parameters and task isolation section
Date: Fri, 20 Nov 2026 13:42:42 +0800
Message-ID: <20261120054242.523606-1-w1355457260@gmail.com>
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
 .../real-time/kernel-configuration.rst        | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/Documentation/core-api/real-time/kernel-configuration.rst b/Documentation/core-api/real-time/kernel-configuration.rst
index d7f08e7b..65532496 100644
--- a/Documentation/core-api/real-time/kernel-configuration.rst
+++ b/Documentation/core-api/real-time/kernel-configuration.rst
@@ -216,6 +216,140 @@ just by being enabled.
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
+  Format: ``[flag-list,]<cpu-list>``.  Removes the listed CPUs from the
+  scheduler's general load balancing so that runnable tasks are not
+  placed there automatically.  The optional flag list selects the type
+  of isolation:
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
+    ``cpumask``; by default that workqueue may run on any CPU.
+
+  ``managed_irq``
+    Prevent managed interrupts from being targeted at isolated CPUs
+    when their automatically computed affinity mask also contains
+    housekeeping CPUs.  This is best effort and has no effect when the
+    mask contains isolated CPUs only.  See
+    Documentation/core-api/irq/managed_irq.rst.
+
+  ``isolcpus=`` only influences task placement.  It does not stop
+  kernel threads, timers, or interrupts that are already affined to
+  the isolated CPUs.  A practical configuration therefore combines it
+  with ``nohz_full=``, ``rcu_nocbs=``, an interrupt affinity mask, and
+  a C-state limit.
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
+  This sysctl, normally set at boot through a ``sysctl.d``
+  configuration file, limits the CPU time available to real-time
+  scheduling during ``kernel.sched_rt_period_us``.  The default of
+  950000 us per 1000000 us reserves 5% of the CPU for non-real-time
+  tasks.  A value of -1 removes the limit, allowing real-time tasks to
+  use the full period; do this only after validating the workload,
+  because a runaway real-time task can then starve the rest of the
+  system.  Recent kernels require the runtime/period ratio to stay
+  above 0.05 to preserve bandwidth for the fair deadline server.  See
+  Documentation/scheduler/sched-rt-group.rst.
+
 Kernel Debug Options
 ====================
 
-- 
2.54.0

