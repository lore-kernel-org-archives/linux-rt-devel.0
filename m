Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A71845FFCD
	for <linux-rt-devel@lists.linux.dev>; Tue,  4 Aug 2026 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785850679; cv=none; b=X3go6m/Bn0s6jxEl6dxkgqanWrKPS5tctZIycRffzUk7UqZWVWPTAU1ZpvdOQpZhK6G7zLbc1KJiuKw0zBLcBz5usVb0V8TqN0zeUptb3cEp1aRRD6Tp5pXxeLuq7N0DQTqvnrYmte2ZI/o6gI5Pp/23uS8m3x8wS1m29/P8XNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785850679; c=relaxed/simple;
	bh=TonXhsMotAM6xXoprsD61W4QbRRx6qUuq1xFrrGHANY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AAE4X89NB7JK6aaHTdplqIyNWT+BEuKHH0qchWYny19x9DlFf/BaLvEBzc1Ur4T1QuRiF6I957WFxVyLCBuBLbu22sJP6yW05F3sJArOPMedQdnx2WXSM3TFY72vglqg53jEIkxlnylUDgnejS66Q0FeoG/kmx37tyJl6rTc3kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yqpFb3hg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E2tsA9Jh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yqpFb3hg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E2tsA9Jh"
From: "Ahmed S. Darwish" <darwi@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785850675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6Ep0Yf08aVrUklEZyohKGnlxuBQQ61AS4gmzMneH10=;
	b=yqpFb3hg9RW0996IT8VmO5ygY2SWlr81hlaLJ8eReRiyPvBR2DkA/wj149hkdE6X0WDXPZ
	Tj94V8PNg36Ka6I86pscft5e1J376iA1VOMlD8jLPhVmWOjlzSWxJcxsButa1nxYw26uXj
	lvbHrWmcQNg8hEDrno/htAnpckqhQOYZCuDgwJB3LvDa5dHYn2ke+nZ8Wx00IvVLmU+zW8
	+ZviUsEcv3OGyRWfqFlgfE1ro+wXO50FyYIAtOrEE/7J/VDE0fv2eB8B77yYVz4zcJ7AgI
	j64iz4fOv7qDV593JumDXCWrWRuRCU9iJs1+SwzGAMUxRPK0mQFiTeW94aLd8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785850675;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6Ep0Yf08aVrUklEZyohKGnlxuBQQ61AS4gmzMneH10=;
	b=E2tsA9JhNarnDp4xbge5l3ojzFaaw1Eg+ehmIrSdoCBvi2fNY1bPdiKMWE0U9USI6ri79R
	5l+bTcAEwfbYH/BQ==
To: Jonathan Corbet <corbet@lwn.net>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Cc: Matthew Wilcox <willy@infradead.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [PATCH v5 1/1] Documentation: real-time: Add kernel configuration guide
Date: Tue,  4 Aug 2026 15:37:45 +0200
Message-ID: <20260804133746.744212-2-darwi@linutronix.de>
In-Reply-To: <20260804133746.744212-1-darwi@linutronix.de>
References: <20260804133746.744212-1-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a configuration guide for real-time kernels.

List all Kconfig options that are recommended to be either enabled or
disabled.  Explicitly add a table of contents at the top of the document,
so that all the options can be seen in a glance.

Whenever appropriate, link to other kernel guides; e.g. cpuidle, cpufreq,
power management, workqueues, and no_hz.

Add a summary at the end of the document warning users that there is a no
"one size fits all solution" for configuring a real-time system.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
---
 Documentation/core-api/real-time/index.rst    |   1 +
 .../real-time/kernel-configuration.rst        | 307 ++++++++++++++++++
 2 files changed, 308 insertions(+)
 create mode 100644 Documentation/core-api/real-time/kernel-configuration.rst

diff --git a/Documentation/core-api/real-time/index.rst b/Documentation/core-api/real-time/index.rst
index f08d2395a22c..a17a3dec535c 100644
--- a/Documentation/core-api/real-time/index.rst
+++ b/Documentation/core-api/real-time/index.rst
@@ -15,3 +15,4 @@ the required changes compared to a non-PREEMPT_RT configuration.
    differences
    hardware
    architecture-porting
+   kernel-configuration
diff --git a/Documentation/core-api/real-time/kernel-configuration.rst b/Documentation/core-api/real-time/kernel-configuration.rst
new file mode 100644
index 000000000000..72f7e8453bcc
--- /dev/null
+++ b/Documentation/core-api/real-time/kernel-configuration.rst
@@ -0,0 +1,307 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================
+Real-Time Kernel configuration
+==============================
+
+.. contents:: Table of Contents
+   :depth: 3
+   :local:
+
+Introduction
+============
+
+This document lists the kernel configuration options that might affect a
+real-time kernel's worst-case latency.  It is intended for system integrators.
+
+Configuration options
+=====================
+
+.. Please keep the configuration listings alphabetically ordered
+
+CPU frequency governors
+-----------------------
+
+``CONFIG_CPU_FREQ``
+^^^^^^^^^^^^^^^^^^^
+
+:Expectation: enabled
+:Severity: *high*
+
+The CPU frequency scaling subsystem ensures that the processor can operate at
+its maximum supported frequency.  While, in general, bootloaders are tasked
+with setting the CPU clock to the highest speed on boot, some do not.  It is
+thus desirable to keep this option enabled.
+
+.. caution::
+
+  A real-time kernel is not about being "as fast as possible", however
+  real-time requirements may demand that the CPU is clocked at a particular
+  speed.
+
+``CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE``
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+:Expectation: enabled
+:Severity: *high*
+
+Real-Time workloads expect a fixed CPU frequency during execution.  Using the
+performance governor is an easy way to achieve that purely from kernel
+configuration.
+
+This is not an absolute rule.  Some setups might prefer to clock the CPU to
+lower speeds due to thermal packaging or other requirements.  The key is that
+the CPU frequency remains constant once set.
+
+Non-performance CPU frequency governors
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+:Expectation: disabled
+:Severity: *medium*
+
+To ensure reproducible system latency measurements, disable the
+non-``PERFORMANCE`` CPU frequency governors whenever possible.  This avoids
+the risk of unknown userspace tasks implicitly or explicitly setting a
+different CPU frequency governor, and and thereby changing latency behavior
+while the system is running.
+
+If disabling other frequency governors is not an option, use a governor that
+keeps the CPU frequency fixed.  For example,
+``CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE`` can be enabled when userspace is
+responsible for setting a *stable* frequency during system initialization.
+
+If a low CPU frequency is desired, then
+``CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE`` can be set.
+
+The ``ONDEMAND`` governor should not be enabled on a real-time system.  Its
+frequency changes depend on workload behavior and can significantly harm
+determinism.
+
+For more information, see Documentation/admin-guide/pm/cpufreq.rst
+
+``CONFIG_CPU_IDLE``
+-------------------
+
+:Expectation: enabled
+:Severity: *info*
+
+CPU idle states (C-states) allow the processor to enter low-power modes during
+periods of inactivity.  Very-low CPU idle states may require flushing the CPU
+caches and lowering or disabling the clocking.  This can lower power
+consumption, but it also increases the entry and exit latency from such
+states.
+
+While disabling this option eliminates cpuidle-related latencies, doing so can
+significantly impact hardware longevity, warranty, and thermal behavior.
+Users should cap the maximum C-state to C1 instead.  For ACPI platforms, this
+can be achieved by using the boot parameter [1]_::
+
+  processor.max_cstate=1
+
+Higher C-states can be acceptable depending on the user workload's latency
+requirements.  For ACPI-based platforms, use the ``cpupower idle-info``
+command to inspect the available idle states.
+
+For more information, please see:
+
+- ``linux/tools/power/cpupower``
+- Documentation/admin-guide/pm/cpuidle.rst
+- Documentation/admin-guide/pm/index.rst
+
+``CONFIG_DRM``
+--------------
+
+:Expectation: disabled
+:Severity: *info*
+
+GPU-accelerated workloads can share system resources with the CPU, including
+last-level cache (LLC) and memory bandwidth.  Modern integrated GPUs optimize
+graphics performance at the expense of CPU determinism.
+
+Examples of affected platforms:
+
+- Intel processors with integrated graphics (Gen9 and later)
+- AMD APUs with Radeon Graphics
+- Xilinx Zynq UltraScale+ MPSoC EG/EV series
+
+If graphics workloads must run alongside real-time tasks, users must conduct
+thorough stress testing using tools like ``glmark2`` while measuring the
+overall system latency.
+
+For more information, please check:
+
+- Documentation/core-api/real-time/hardware.rst ("Regarding hardware" section)
+- Documentation/filesystems/resctrl.rst
+- `Real-Time and Graphics: A Contradiction? <https://web.archive.org/web/20221025085614/https://linutronix.de/PDF/Realtime_and_graphics-acontradiction2021.pdf>`_
+
+``CONFIG_EFI_DISABLE_RUNTIME``
+------------------------------
+
+:Expectation: enabled
+:Severity: *medium*
+
+EFI is the standard boot and firmware interface for multiple architectures.
+EFI runtime services provide callback functions to be called from the kernel;
+e.g., as utilized by (``CONFIG_EFI_VARS*``) or (``CONFIG_RTC_DRV_EFI``).  For
+the former, the kernel calls into EFI to update the EFI variables.
+
+Calling into EFI means invoking firmware callbacks.  During such invocations,
+the system might not be able to react to interrupts and will thus not be able
+to perform a context switch.  This can cause significant latency spikes for
+the real-time system.
+
+``CONFIG_PREEMPT_RT`` enables this option by default.  If this option is
+manually disabled at build time, the following boot parameter [1]_ may be used
+to disable EFI runtime at boot up::
+
+  efi=noruntime
+
+Alternatively, confine EFI runtime service calls to a housekeeping CPU by
+restricting the ``efi_runtime`` workqueue CPU affinity.  For example, set that
+workqueue's affinity to CPU #0 and pin your RT tasks to a different CPU range.
+See Documentation/core-api/workqueue.rst
+
+``CONFIG_NO_HZ`` / ``CONFIG_NO_HZ_FULL``
+----------------------------------------
+
+:Expectation: disabled
+:Severity: *medium*
+
+Tickless operation can increase kernel-to-userspace transition latency due to
+the extra accounting and state book-keeping.
+
+*Guidance by real-time workload type:*
+
+- For periodic workloads; e.g., control loops executing every 100 µs, avoid
+  ``NO_HZ`` modes.  Consistent kernel ticks are preferable.
+
+- For computation-intensive workloads; e.g. extended userspace execution,
+  ``NO_HZ_FULL`` may be beneficial.  In such cases, users should offload the
+  kernel housekeeping to dedicated CPUs and isolate compute cores.
+
+See also Documentation/timers/no_hz.rst
+
+``CONFIG_PREEMPT_RT``
+---------------------
+
+:Expectation: enabled
+:Severity: **fatal**
+
+This option must be enabled, or the resulting kernel will not be fully
+preemptible and real-time capable.
+
+``CONFIG_TRACING`` (and tracing options)
+----------------------------------------
+
+:Expectation: enabled
+:Severity: *info*
+
+Shipping kernels with tracing support enabled (but not actively running) is
+highly recommended.  This will allow the users to extract more information if
+latency problems arise.  Nonetheless, some tracers do incur latency overhead
+by just being enable.
+
+.. caution::
+
+  Users should *not* make use of tracers or trace events during production
+  real-time kernel operation as they can add considerable overhead and degrade
+  the system's latency.
+
+``CONFIG_IRQSOFF_TRACER`` and ``CONFIG_PREEMPT_TRACER``
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+:Expectation: disabled
+:Severity: *high*
+
+These tracers do incur measurable latency overhead even when tracing is not
+currently active.
+
+Kernel Debug Options
+====================
+
+Most kernel debug options add runtime overhead that increases the worst-case
+latency.
+
+.. caution::
+
+  During development and early testing, users are encouraged to run their
+  real-time workloads and peripherals with lockdep (:ref:`lockdep`) and other
+  kernel debug options enabled, for a considerable amount of time.  Such
+  workloads might trigger kernel code paths that were not triggered during the
+  internal Linux real-time kernel development, thus helping to uncover locking
+  and other types of kernel bugs.
+
+``CONFIG_DEBUG_ATOMIC_SLEEP``
+-----------------------------
+
+:Expectation: allowed
+
+This sanity check catches common kernel programming errors with a tolerable
+latency cost.  It also increases overall scheduling as each ``might_sleep()``
+can lead to a context switch.
+
+``CONFIG_DEBUG_BUGVERBOSE`` and ``CONFIG_DEBUG_INFO*``
+------------------------------------------------------
+
+:Expectation: allowed
+
+These options increase the kernel image size but have no latency impact.  They
+are also essential for meaningful BUG logs, crash dumps, and profiling.
+
+``CONFIG_DEBUG_FS``
+-------------------
+
+:Expectation: allowed
+
+This is safe to include in real-time kernels, *provided that debugfs is not
+accessed during production runtime*.
+
+``CONFIG_DEBUG_KERNEL``
+-----------------------
+
+:Expectation: allowed
+
+Meta-option which allows debug features to be enabled.  It has no runtime
+impact, but beware of any debug features that it may have implicitly enabled.
+
+``CONFIG_LOCKUP_DETECTOR``
+--------------------------
+
+:Expectation: disabled
+:Severity: *high*
+
+The lockup detector creates kernel timer callbacks that execute every few
+seconds, in hard-IRQ context, even on real-time kernels.  These periodic
+interrupts can cause latency spikes.
+
+Users should use hardware watchdogs instead, which will provide a similar
+functionality without the software-induced latency.
+
+.. _lockdep:
+
+``CONFIG_PROVE_LOCKING``
+------------------------
+
+:Expectation: disabled
+:Severity: *high*
+
+Proving the correctness of all kernel locking adds substantial overhead and
+significantly increases worst-case latency.
+
+Summary
+=======
+
+There is no "one size fits all" solution for configuring a real-time Linux
+system.  Beginning with the system real-time requirements, integrators must
+consider the features and functions of the system's hardware, kernel, and
+userspace.  All such components must be properly configured in order to
+establish and constrain the system's maximum latency.
+
+With that in mind, any incorrect real-time kernel configuration could cause a
+new maximum latency that shows up at the wrong time and is catastrophic for
+the real-time system's latency.
+
+References
+==========
+
+.. [1] See Documentation/admin-guide/kernel-parameters.rst
-- 
2.55.0

