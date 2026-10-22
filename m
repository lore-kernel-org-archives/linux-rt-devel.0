Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645661;
	b=kLd1FRG5ItzbuNuBHWil6Ge3hG9F5txaiv050u7+n1SHltCG2C9xWaKa03vefd2vaAZh
	 apj4+ByqKCWITf87KQx1ztWC2lyFQtHu2463+BfBpCTqbk1diNq+uRrP0necSqrcnpt+Z
	 4i4Fv47g6d1zokHLTxHo5x9ere6TuT9YISIam3ReaAdmwfu7jctfeSfJWSwfDWMi1HrMu
	 J7nHHJdspVecm1k8biebf/8HcSYbR4GgIKTFYYBui5XkSp4ydrbQvuzZNDxYjb6KnEJuT
	 25jv4FYIXOaSMJy27fQpeacEQkUJyejoTlxglsl8rBbMTK39Vl18RR9OA5Ttp2g3AGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=07+mRxyOIRiwBbjnVflzXSK1jgEE0EJDr+2fF5PpXTQ=;
	b=o9xZ/GtvZ/nDb0CDsfCvcvFVJaUiN9I1eLta/BEOeDiiKzygBGaayxeO4gDK50rZ3hlt
	 vOgZwtvK88IWSttqtJ5/gyga/m4PO0vx4yyr/1ElylM7IYRTbiRzbYB1WBDlZorJfPNlL
	 zys0DoNY8BFHVCVAsA4P1VXBnrtloPPE4xqcGOs5CoDSLUnobD51ZHYSMG+FYi5WtY6F0
	 RzjFiLpwjfTPM7u8TNPfWMVuOLsHAYQ7zKY6LlJ2Ot8QG59sw0I0ymRUZehHAhyiCr5lP
	 HZXkUHln2a2RUHgTyE12fQA4wD5gmitSBj+lrRJisN0xJ3QsZOegY22UNZdlOgrwM1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r0AV6UXb;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E09606A33E
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 05:07:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23E09606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=r0AV6UXb
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48afcd7ba9bso965291f8f.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 22:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645658; x=1793250458; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=07+mRxyOIRiwBbjnVflzXSK1jgEE0EJDr+2fF5PpXTQ=;
        b=r0AV6UXba0ouJRB450DEdqYiaPOs7+OyV+HUWWOKtTWzoeaDJ/0LzbxG4HD3ccPu+h
         3MxmLGlMfil39Fl7gFjD6hionjkd+TRQYC5lIP3dnGaNTYSii3vs5V5Hk54DuWsTgNBR
         TQP2e3RWRwdEhMbBrY4buu56zqItWZV842Oo5OnsjrNmUu9abNUTrj8tuUDoh+7k7S9K
         PMQOM3+t/MkaHaOe9iI5hHquAU++CIY/JswFevHNQYVB8eDGHzSFweRcSUuFYHezc3uP
         XNk+j2l5QE8T2R71gyRtgsfLHKL56MZlx2ZpW7wZM4Fhn26TFfr6yZFw3Z+aS/nZ2yol
         zBvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645658; x=1793250458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=07+mRxyOIRiwBbjnVflzXSK1jgEE0EJDr+2fF5PpXTQ=;
        b=bQkKXFgz/t3MLlohWOsvg6YpUd3MqNyGcapc25dS6b2bPTWAHEuZ7s/k6H2M3ueM9a
         scJ3Zl9mTANvtYFwKkDGU42g2JzoEz64OFCbE7XAYZS2tNgKDMFjQi8zXn9U1550wlM1
         io2kHd28ngrVdt8N+JH1R9w1Dvd1bP9OdhLY22E8uoxxU65D6tnOH9KjN0ahCsoxPwID
         jGVxnMfTpFDh2fdaPViBk1qoCjrICrjchaXW9VzMotqRYqmrM4cT36nD+jCWdTWLXAsQ
         h2wk6hEb3Iw0F55GKGGpy0OUImoaJMMGXYs5TNT3KAg7Z3aP7cKtzH1MRy0mChSK9WWq
         6mhA==
X-Forwarded-Encrypted: i=1; AKwUvBwOa/BnG5ngm7wXCMkhFvtU3OEpvnncB+r/hRMYZ0ChrvfUqWUCURAg8olRQ2sthaRLGk7KQJD3myHya6uT1g==@lists.linux.dev
X-Gm-Message-State: AFq9FYJTZFbA+0/V0HmhTz+vx/sZSCe/nDdl6Txf/CixWVPGWeDuhBFf
	dls6rE3ZPl3ArZlI+00ZNgii422HBylJljAkDToX8pELlh15AlZ4wtK/
X-Gm-Gg: AYBFou2GjKk0bz8VzXjv94QnOQsG/3maPmI3u4abQsWGt+m0YABVrf9OfXaGBWtksEY
	esHyPMvCTUIvM3VLX31RQR8aGkYKcDobdCql9pN0xZkC5R+xp7AjE+q8i41YLEGHVY9ATQD1itX
	yKMXl3uLYBXg24Ojvbr1UX7uzgl0vpmSlSm+QFjXadjlpQucKSAYnlEIYDsQq36cZVxd+aLo4io
	f/PIgIXsBSFd0Zm5W6dz9qLRmam4zc3agfftoTNPu6SuWgHo2hqQGk0ABSNpjTgniG0KRbvSh5X
	K9th3llpZEs1OIotk9pjiF4P/L3whwjaXZTD0YnCmNgSYpSz1bRRhQWR0rkP4KEI9FkNP4RCmPI
	iaCZpYTUR1M/gE1fNI7mTTVCHDveE8EuqSagahGnppwEQImT6LCzoLm3L5O85r6hw0lNaqcnbvM
	Lm8S0C8Q+IBsfjk0TB54bIw4K+/eeB2xQo9swe3hnOl3/NifbsNupZvxbTNU4s7UUYuic3v2dcY
	Nk0gDLS/yIdwaaz/4DVLPoEd6EEd/w7dtaubTvah7O6LZEYUBOcPoiS+15zKg18/D8Ns+q87vRt
	SBfVZ5cFM7ni5xSvAJEeOv2VqCDsN9rD0QW7UasAgU+0ItfLrxnaVdBMcJaIrYoUTXKWodgK6Hl
	7m7fZdCoJNlnocjyhcKcCnk7f/ULLQwIKcVxB22CQCa0UnMpNtuJM8lhdNCc=
X-Received: by 2002:a05:6000:2901:b0:48e:25e1:5eb8 with SMTP id ffacd0b85a97d-48e2642e9aemr8678202f8f.3.1792645658351;
        Wed, 21 Oct 2026 22:07:38 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm9994979f8f.8.2026.10.21.22.07.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:07:37 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/9] rv: Add a monitor for IRQ-exit scheduling ownership
Date: Thu, 22 Oct 2026 07:07:07 +0200
Message-Id: <20261022050712.75035-5-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022050712.75035-1-kmehltretter@gmail.com>
References: <20261022050712.75035-1-kmehltretter@gmail.com>
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

Existing scheduler events do not identify the task that owns a
preempt_schedule_irq() invocation after it switches out.

Add irqexit, a per-task hybrid-automaton monitor that follows an
invocation through entry, suspension, migration, resumption, and return.
Its guards check hardirq context, local interrupt state, and task
ownership.

The monitor covers preempt_schedule_irq() only. It does not cover
architecture-specific interrupt-return work or establish that the helper
was reached from a physical interrupt.

The generated model header is reproducible from the included DOT file
with the unmodified rvgen tool.

Assisted-by: LLM
---
 kernel/trace/rv/Kconfig                       |   1 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitors/irqexit/Kconfig      |  14 ++
 kernel/trace/rv/monitors/irqexit/irqexit.c    | 159 ++++++++++++++++++
 kernel/trace/rv/monitors/irqexit/irqexit.h    |  85 ++++++++++
 .../trace/rv/monitors/irqexit/irqexit_trace.h |  19 +++
 kernel/trace/rv/rv_trace.h                    |   1 +
 .../verification/models/irqentry/irqexit.dot  |  21 +++
 8 files changed, 301 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/irqexit/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.c
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.h
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_trace.h
 create mode 100644 tools/verification/models/irqentry/irqexit.dot

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index e7b30668a559b..12854fc9643f9 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -75,6 +75,7 @@ source "kernel/trace/rv/monitors/opid/Kconfig"
 
 source "kernel/trace/rv/monitors/irqentry/Kconfig"
 source "kernel/trace/rv/monitors/irqstate/Kconfig"
+source "kernel/trace/rv/monitors/irqexit/Kconfig"
 # Add new irqentry monitors here
 
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index f39a9f8815764..c9a0bf8d9f9b8 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_RV_MON_SSSW) += monitors/sssw/sssw.o
 obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
 obj-$(CONFIG_RV_MON_IRQENTRY) += monitors/irqentry/irqentry.o
 obj-$(CONFIG_RV_MON_IRQSTATE) += monitors/irqstate/irqstate.o
+obj-$(CONFIG_RV_MON_IRQEXIT) += monitors/irqexit/irqexit.o
 obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
diff --git a/kernel/trace/rv/monitors/irqexit/Kconfig b/kernel/trace/rv/monitors/irqexit/Kconfig
new file mode 100644
index 0000000000000..55d85e3aa3fca
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_IRQEXIT
+	depends on RV
+	depends on RV_MON_IRQENTRY
+	default y
+	select HA_MON_EVENTS_ID
+	bool "irqexit monitor"
+	help
+	  Verify that IRQ-exit scheduling starts outside hardirq context
+	  with interrupts disabled and returns to its original task.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_irqentry.rst
diff --git a/kernel/trace/rv/monitors/irqexit/irqexit.c b/kernel/trace/rv/monitors/irqexit/irqexit.c
new file mode 100644
index 0000000000000..a088b28b62b17
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/irqexit.c
@@ -0,0 +1,159 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/hardirq.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rv.h>
+#include <linux/tracepoint.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "irqexit"
+
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/irqentry/irqentry.h>
+
+#define RV_MON_TYPE RV_MON_PER_TASK
+#include "irqexit.h"
+#include <rv/ha_monitor.h>
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_irqexit env, u64 time_ns)
+{
+	switch (env) {
+	case hardirq_irqexit:
+		return hardirq_count();
+	case irq_off_irqexit:
+		return !!irqs_disabled();
+	case owner_current_irqexit:
+		return ha_get_target(ha_mon) == rv_get_current();
+	default:
+		return ENV_INVALID_VALUE;
+	}
+}
+
+static inline bool ha_verify_guards(struct ha_monitor *ha_mon,
+				    enum states curr_state, enum events event,
+				    enum states next_state, u64 time_ns)
+{
+	bool res = true;
+
+	if (curr_state == idle_irqexit && event == resched_entry_irqexit)
+		res = ha_get_env(ha_mon, hardirq_irqexit, time_ns) == 0ull &&
+		      ha_get_env(ha_mon, irq_off_irqexit, time_ns) == 1ull &&
+		      ha_get_env(ha_mon, owner_current_irqexit, time_ns) == 1ull;
+	else if (curr_state == idle_irqexit && event == switch_in_irqexit)
+		res = ha_get_env(ha_mon, hardirq_irqexit, time_ns) == 0ull &&
+		      ha_get_env(ha_mon, irq_off_irqexit, time_ns) == 1ull;
+	else if (curr_state == idle_irqexit && event == switch_out_irqexit)
+		res = ha_get_env(ha_mon, hardirq_irqexit, time_ns) == 0ull &&
+		      ha_get_env(ha_mon, irq_off_irqexit, time_ns) == 1ull;
+	else if (curr_state == rescheduling_irqexit && event == resched_exit_irqexit)
+		res = ha_get_env(ha_mon, hardirq_irqexit, time_ns) == 0ull &&
+		      ha_get_env(ha_mon, irq_off_irqexit, time_ns) == 1ull &&
+		      ha_get_env(ha_mon, owner_current_irqexit, time_ns) == 1ull;
+	else if (curr_state == rescheduling_irqexit && event == switch_out_irqexit)
+		res = ha_get_env(ha_mon, hardirq_irqexit, time_ns) == 0ull &&
+		      ha_get_env(ha_mon, irq_off_irqexit, time_ns) == 1ull &&
+		      ha_get_env(ha_mon, owner_current_irqexit, time_ns) == 1ull;
+	else if (curr_state == suspended_irqexit && event == switch_in_irqexit)
+		res = ha_get_env(ha_mon, hardirq_irqexit, time_ns) == 0ull &&
+		      ha_get_env(ha_mon, irq_off_irqexit, time_ns) == 1ull;
+	return res;
+}
+
+static bool ha_verify_constraint(struct ha_monitor *ha_mon,
+				 enum states curr_state, enum events event,
+				 enum states next_state, u64 time_ns)
+{
+	return ha_verify_guards(ha_mon, curr_state, event, next_state, time_ns);
+}
+
+static void handle_resched_entry(void *data, struct task_struct *owner)
+{
+	da_handle_start_run_event(owner, resched_entry_irqexit);
+}
+
+static void handle_resched_exit(void *data, struct task_struct *owner)
+{
+	/* Do not hide an invalid return behind enable-mid-invocation sync. */
+	if (owner != rv_get_current() || hardirq_count() || !irqs_disabled())
+		da_handle_start_run_event(owner, resched_exit_irqexit);
+	else
+		da_handle_start_event(owner, resched_exit_irqexit);
+}
+
+static void probe_resched_entry(void *data, struct task_struct *owner,
+				unsigned long pc, bool irq_off)
+{
+	handle_resched_entry(data, owner);
+}
+
+static void probe_resched_exit(void *data, struct task_struct *owner,
+			       unsigned long pc, bool irq_off)
+{
+	handle_resched_exit(data, owner);
+}
+
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	/* current is still prev; the incoming task must not use that guard. */
+	da_handle_event(prev, switch_out_irqexit);
+	da_handle_event(next, switch_in_irqexit);
+}
+
+static int enable_irqexit(void)
+{
+	int retval;
+
+	retval = ha_monitor_init();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("irqexit", sched_irq_preempt_entry, probe_resched_entry);
+	rv_attach_trace_probe("irqexit", sched_irq_preempt_exit, probe_resched_exit);
+	rv_attach_trace_probe("irqexit", sched_switch, handle_sched_switch);
+
+	return 0;
+}
+
+static void disable_irqexit(void)
+{
+	rv_this.enabled = 0;
+
+	rv_detach_trace_probe("irqexit", sched_irq_preempt_entry, probe_resched_entry);
+	rv_detach_trace_probe("irqexit", sched_irq_preempt_exit, probe_resched_exit);
+	rv_detach_trace_probe("irqexit", sched_switch, handle_sched_switch);
+
+	ha_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "irqexit",
+	.description = "Verify IRQ-exit scheduling ownership.",
+	.enable = enable_irqexit,
+	.disable = disable_irqexit,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_irqexit(void)
+{
+	return rv_register_monitor(&rv_this, &rv_irqentry);
+}
+
+static void __exit unregister_irqexit(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_irqexit);
+module_exit(unregister_irqexit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Karl Mehltretter <kmehltretter@gmail.com>");
+MODULE_DESCRIPTION("irqexit: verify IRQ-exit scheduling ownership");
diff --git a/kernel/trace/rv/monitors/irqexit/irqexit.h b/kernel/trace/rv/monitors/irqexit/irqexit.h
new file mode 100644
index 0000000000000..f48d44d1dff73
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/irqexit.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of irqexit automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME irqexit
+
+enum states_irqexit {
+	idle_irqexit,
+	rescheduling_irqexit,
+	suspended_irqexit,
+	state_max_irqexit,
+};
+
+#define INVALID_STATE state_max_irqexit
+
+enum events_irqexit {
+	resched_entry_irqexit,
+	resched_exit_irqexit,
+	switch_in_irqexit,
+	switch_out_irqexit,
+	event_max_irqexit,
+};
+
+enum envs_irqexit {
+	hardirq_irqexit,
+	irq_off_irqexit,
+	owner_current_irqexit,
+	env_max_irqexit,
+	env_max_stored_irqexit = hardirq_irqexit,
+};
+
+_Static_assert(env_max_stored_irqexit <= MAX_HA_ENV_LEN, "Not enough slots");
+
+struct automaton_irqexit {
+	char *state_names[state_max_irqexit];
+	char *event_names[event_max_irqexit];
+	char *env_names[env_max_irqexit];
+	unsigned char function[state_max_irqexit][event_max_irqexit];
+	unsigned char initial_state;
+	bool final_states[state_max_irqexit];
+};
+
+static const struct automaton_irqexit automaton_irqexit = {
+	.state_names = {
+		"idle",
+		"rescheduling",
+		"suspended",
+	},
+	.event_names = {
+		"resched_entry",
+		"resched_exit",
+		"switch_in",
+		"switch_out",
+	},
+	.env_names = {
+		"hardirq",
+		"irq_off",
+		"owner_current",
+	},
+	.function = {
+		{
+			rescheduling_irqexit,
+			INVALID_STATE,
+			idle_irqexit,
+			idle_irqexit,
+		},
+		{
+			INVALID_STATE,
+			idle_irqexit,
+			INVALID_STATE,
+			suspended_irqexit,
+		},
+		{
+			INVALID_STATE,
+			INVALID_STATE,
+			rescheduling_irqexit,
+			INVALID_STATE,
+		},
+	},
+	.initial_state = idle_irqexit,
+	.final_states = { 1, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/irqexit/irqexit_trace.h b/kernel/trace/rv/monitors/irqexit/irqexit_trace.h
new file mode 100644
index 0000000000000..f35366875feff
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqexit/irqexit_trace.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_IRQEXIT
+DEFINE_EVENT(event_da_monitor_id, event_irqexit,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_irqexit,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+
+DEFINE_EVENT(error_env_da_monitor_id, error_env_irqexit,
+	     TP_PROTO(int id, char *state, char *event, char *env),
+	     TP_ARGS(id, state, event, env));
+#endif /* CONFIG_RV_MON_IRQEXIT */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 040b3635ef289..c90dae4338bcc 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -190,6 +190,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor_id,
 
 #include <monitors/stall/stall_trace.h>
 #include <monitors/nomiss/nomiss_trace.h>
+#include <monitors/irqexit/irqexit_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_ID here
 
 #endif
diff --git a/tools/verification/models/irqentry/irqexit.dot b/tools/verification/models/irqentry/irqexit.dot
new file mode 100644
index 0000000000000..eb2e5499ad7a7
--- /dev/null
+++ b/tools/verification/models/irqentry/irqexit.dot
@@ -0,0 +1,21 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_idle"};
+	{node [shape = doublecircle] "idle"};
+	{node [shape = circle] "rescheduling"};
+	{node [shape = circle] "suspended"};
+	"__init_idle" -> "idle";
+	"idle" [label = "idle", color = green3];
+	"idle" -> "idle" [ label = "switch_in;hardirq == 0 && irq_off == 1\nswitch_out;hardirq == 0 && irq_off == 1" ];
+	"idle" -> "rescheduling" [ label = "resched_entry;hardirq == 0 && irq_off == 1 && owner_current == 1" ];
+	"rescheduling" [label = "rescheduling"];
+	"rescheduling" -> "idle" [ label = "resched_exit;hardirq == 0 && irq_off == 1 && owner_current == 1" ];
+	"rescheduling" -> "suspended" [ label = "switch_out;hardirq == 0 && irq_off == 1 && owner_current == 1" ];
+	"suspended" [label = "suspended"];
+	"suspended" -> "rescheduling" [ label = "switch_in;hardirq == 0 && irq_off == 1" ];
+	{ rank = min ;
+		"__init_idle";
+		"idle";
+	}
+}
-- 
2.39.5 (Apple Git-154)

