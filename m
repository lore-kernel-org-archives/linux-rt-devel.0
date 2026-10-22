Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645659;
	b=1x2IC15zA9sdTWAQU7Wu+VGDqyR61rDUtttyolf2le2D9439K0dFMLm0oNwtOsL45ZNs
	 WabQQv4fUUzOhFsRwZiHRajhNxwCGFHNWU+rNVFpSw/FkY7+rX945dN2fDOo7JyJGRqcJ
	 wsIi3e9BQtEvp13wOUT/A9M8r5qy/5eeLJxisWZEc4gMFVb+1vLLPmVu84Y3ETix4pJGr
	 K5TCPMup03XfIXBeNLErrcrUzpZoGf3aXwgzVW+PtNrA0s2rM7z2r30A6RDLb638WK8yE
	 3W8KamH18lVgyVCiPqvYumZw0ZcnmMgbzbhZoDkP5jxu5gugXxKa+p3NUHnj2MJ9JgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645659;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rvJDGDbxJ+1ZmzBF0ntz3JbtZDPeNlBQcw7LAqsvHgY=;
	b=pAURYb06Y5qNvqGYpoR7PugS4yhylJ7lAqpbF87ue/Wa4NmgE6TBKsWMtKiDcJu5jOpN
	 MO1LO/9sF3VVx5s0yI7ZoqqvcHm3pJGJhCFiixwgrHg3V9WaMW7dqiVwc/jHU29clCDKq
	 6g5ZV1GY5yr8pnEaZWgbtljBbAp2z4me5K0b6MLMm2YsO3Ci2B349ITpUeiHezcYJVhUp
	 JaOVlsM+fqA1dqkf/7jzOKYgq+WAd2b09MrIGc31STXWigNQ0QTQSsgKoOaUekW9a0dpF
	 efU/8kvp5MIRItTb2ruYZzBWG4P3/LLHcpU/R4vRSh9Bv+EBNfkhyMJlndjnrxMqbDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VuzaNFz6;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C87606A33E
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 05:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39C87606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VuzaNFz6
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48c4649b35bso1340289f8f.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 22:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645656; x=1793250456; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rvJDGDbxJ+1ZmzBF0ntz3JbtZDPeNlBQcw7LAqsvHgY=;
        b=VuzaNFz6rIHvkWb6rdV0GxXavtEUWW5xph2WSxcx3zBFu1JSaJ8jBYzGJMW5ifUGRP
         O2RAN0V9NT3bWUX0OVE6eXy+Opb+XVLq9233vQvk7AvBI5D7uS2lrP0Zz1a0WCXb3Xrb
         2m51aeow8IsH5tPDMywTWI+/DcparrzlMtOnvhTtThAKFclKZucuaS6duMryXhwj+laV
         kbF3Pi03Myc6qeGc0ykYH8I2bNZWgqUK2fqsiMRpNGAH+XLyofBFHpo/F9HN0IKFx6uO
         0acIYei63sM6gxnAX1buOEpq1Z18R7mS6cYv2e+Q5kTgNZxYepAJeSKEHVbDrAbAywdS
         dnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645656; x=1793250456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rvJDGDbxJ+1ZmzBF0ntz3JbtZDPeNlBQcw7LAqsvHgY=;
        b=Ij8o1VKC7imL3Ojh7pS/oaatak9Q9meH7zm+z6KMVcn1NvDNxU6zZN2S5gnUmTTixW
         KILsw5L8hkxe/blhxjXTI+qk1Nw4J2oLjuDMkB4IyuMkCbxs9AMe+aD+be/6luqM+3ve
         Jj6tesJOSVdSskhpN9yDGNPV4HHy6Iw7GivALhYWkymLANjSKg6AMqcAQhqT8FECjpYN
         mv/qZevWuFr/yJELJ1VMglSyXn1fIhicbyv0+kkTNqGkVJweIgU+EW3Qtql2ltvcB7Lg
         fMGPO+bnHO6cIFtbepUBr+7wZHBHs0LgWJFqP4GRKfGFpBywyZ5BY9Xydb+jCsizpxX4
         SWEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzEVHdJY0ePiW7Yy7oShxHYHM1gFhDT4vjg6aqSlw4dxKyTH141xVdVkd+UqqNGN+ePXuwqm1sBS6AQY7ePLg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJLq72Z60LFS1VETIyS/wsw7VlUEzMK7Wj9hsExevB8iPx/113y
	476fwYrRvjflUXh08aC/lD+tJ8h4oPlJUIEV9pm1E7DOT2Qbmcusf+qT
X-Gm-Gg: AYBFou2hxambdibumHgqRWDEPtvmJw6ERFv8Dr8Xx5OVT8bxfg3nBPWi1tAujZM8Boa
	Ym6yJHm3LexP+nAXllci9nyi6o0rbiiV5/an1C7KYYg6rg+gs2axvtBOOHK3KqGCCMfci+fM81O
	CAPKDZlJKJTyl4oKi+Ie7csk/k/6YpYd2DSSY5X5yG8N/qeLMIUZceTQtxc2oWYFrgMS6njEJDS
	35+8g5Pv7dJqp1kC4xyqh0BaIqLfR9FpE2V9JS6IRjhIPk2m9ZPFyNyPqkHJiiG3C7BtGFpeUPo
	VHdQZCBLp+C5e+G6OJxnMwKIQqJvKtq8eaX7gvTcUPRTTfppzU6kw7/uDYwH59DoGWjY6c3tB2u
	IdIFpkgVx9+MofQ4QzpCO3+izxLrGuoG10sguBnbN5rW+pPW77+iOGT5ieKfDeWPT1PDoj4Cs2g
	PEQCnpPfIQK7LiPLdbPcaP1P5jEN31uM/83Q/nb8FdDJq1TNKDRZqtgkitIWmMiVbd1W9kor+Go
	rPXhxc0rfg5Xfzfp6SNrOUIg+4BEerInIE6NnzcVI2ZjKyZZ/7P4kcTu/x5MBHXJdtiLZqdkHXm
	gtvpv3NIkBAFEnkFDJ4qY6B09YB2lsrqMBKzl5gXkJnweCpXp7Nc6DDme+BQZ2+OGswGhUEfhs7
	Yib+q7Z6JbYwER9JLwg7hu+nf8HI1d5gNicq5xP2d4ygITkfVJvX+7fD5j6ROr9UE/iLaHZHVLK
	fFqQYQPA==
X-Received: by 2002:a05:6000:2283:b0:48e:fdd:41d9 with SMTP id ffacd0b85a97d-48e264958f2mr10382265f8f.31.1792645655514;
        Wed, 21 Oct 2026 22:07:35 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm9994979f8f.8.2026.10.21.22.07.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:07:34 -0700 (PDT)
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
Subject: [RFC PATCH 3/9] rv: Add a monitor for generic IRQ context transitions
Date: Thu, 22 Oct 2026 07:07:06 +0200
Message-Id: <20261022050712.75035-4-kmehltretter@gmail.com>
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

The generic IRQ boundary events expose state transitions but do not check
their order or agreement with live kernel state.

Add the irqentry monitor group and its irqstate hybrid automaton. The
monitor checks generic hardirq and serving-softirq nesting against live
kernel state. On PREEMPT_RT, it suspends and resumes task-local softirq
state across sched_switch().

The monitor observes only the generic boundary events. It does not cover
NMI entry, architecture-specific intervals before generic IRQ entry or
after generic IRQ exit, or paths that bypass the generic helpers.

The generated model header is reproducible from the included DOT file
with the unmodified rvgen tool.

Assisted-by: LLM
---
 kernel/trace/rv/Kconfig                       |   4 +
 kernel/trace/rv/Makefile                      |   2 +
 kernel/trace/rv/monitors/irqentry/Kconfig     |  13 +
 kernel/trace/rv/monitors/irqentry/irqentry.c  |  35 +++
 kernel/trace/rv/monitors/irqentry/irqentry.h  |   3 +
 kernel/trace/rv/monitors/irqstate/Kconfig     |  14 +
 kernel/trace/rv/monitors/irqstate/irqstate.c  | 240 ++++++++++++++++++
 kernel/trace/rv/monitors/irqstate/irqstate.h  | 139 ++++++++++
 .../rv/monitors/irqstate/irqstate_trace.h     |  15 ++
 kernel/trace/rv/rv_trace.h                    |   1 +
 .../verification/models/irqentry/irqstate.dot |  32 +++
 11 files changed, 498 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/irqentry/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.c
 create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.h
 create mode 100644 kernel/trace/rv/monitors/irqstate/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.c
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.h
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_trace.h
 create mode 100644 tools/verification/models/irqentry/irqstate.dot

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index efa930f94ea4a..e7b30668a559b 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -73,6 +73,10 @@ source "kernel/trace/rv/monitors/sssw/Kconfig"
 source "kernel/trace/rv/monitors/opid/Kconfig"
 # Add new sched monitors here
 
+source "kernel/trace/rv/monitors/irqentry/Kconfig"
+source "kernel/trace/rv/monitors/irqstate/Kconfig"
+# Add new irqentry monitors here
+
 source "kernel/trace/rv/monitors/rtapp/Kconfig"
 source "kernel/trace/rv/monitors/pagefault/Kconfig"
 source "kernel/trace/rv/monitors/sleep/Kconfig"
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index cdbf68c84f5a4..f39a9f8815764 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -17,6 +17,8 @@ obj-$(CONFIG_RV_MON_STS) += monitors/sts/sts.o
 obj-$(CONFIG_RV_MON_NRP) += monitors/nrp/nrp.o
 obj-$(CONFIG_RV_MON_SSSW) += monitors/sssw/sssw.o
 obj-$(CONFIG_RV_MON_OPID) += monitors/opid/opid.o
+obj-$(CONFIG_RV_MON_IRQENTRY) += monitors/irqentry/irqentry.o
+obj-$(CONFIG_RV_MON_IRQSTATE) += monitors/irqstate/irqstate.o
 obj-$(CONFIG_RV_MON_STALL) += monitors/stall/stall.o
 obj-$(CONFIG_RV_MON_DEADLINE) += monitors/deadline/deadline.o
 obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
diff --git a/kernel/trace/rv/monitors/irqentry/Kconfig b/kernel/trace/rv/monitors/irqentry/Kconfig
new file mode 100644
index 0000000000000..c4476650cd930
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqentry/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_IRQENTRY
+	depends on RV
+	bool "irqentry monitor"
+	help
+	  Enable the container for monitors which check IRQ-entry execution
+	  context and ordering. Individual monitors can compare hardirq,
+	  softirq, and scheduler events with the kernel's recorded execution
+	  context.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_irqentry.rst
diff --git a/kernel/trace/rv/monitors/irqentry/irqentry.c b/kernel/trace/rv/monitors/irqentry/irqentry.c
new file mode 100644
index 0000000000000..4029ef14389b9
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqentry/irqentry.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rv.h>
+
+#define MODULE_NAME "irqentry"
+
+#include "irqentry.h"
+
+struct rv_monitor rv_irqentry = {
+	.name = "irqentry",
+	.description = "IRQ-entry context monitors.",
+	.enable = NULL,
+	.disable = NULL,
+	.reset = NULL,
+	.enabled = 0,
+};
+
+static int __init register_irqentry(void)
+{
+	return rv_register_monitor(&rv_irqentry, NULL);
+}
+
+static void __exit unregister_irqentry(void)
+{
+	rv_unregister_monitor(&rv_irqentry);
+}
+
+module_init(register_irqentry);
+module_exit(unregister_irqentry);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Karl Mehltretter <kmehltretter@gmail.com>");
+MODULE_DESCRIPTION("irqentry: IRQ-entry context monitors.");
diff --git a/kernel/trace/rv/monitors/irqentry/irqentry.h b/kernel/trace/rv/monitors/irqentry/irqentry.h
new file mode 100644
index 0000000000000..a7d72483522d2
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqentry/irqentry.h
@@ -0,0 +1,3 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+extern struct rv_monitor rv_irqentry;
diff --git a/kernel/trace/rv/monitors/irqstate/Kconfig b/kernel/trace/rv/monitors/irqstate/Kconfig
new file mode 100644
index 0000000000000..bf43b9a4d64fd
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqstate/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+config RV_MON_IRQSTATE
+	depends on RV
+	depends on RV_MON_IRQENTRY
+	default y
+	select HA_MON_EVENTS_IMPLICIT
+	bool "irqstate monitor"
+	help
+	  Verify that generic hardirq and softirq context boundaries agree
+	  with the execution context recorded in preempt count.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_irqentry.rst
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate.c b/kernel/trace/rv/monitors/irqstate/irqstate.c
new file mode 100644
index 0000000000000..2d8c824a4870a
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqstate/irqstate.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/hardirq.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/rcupdate.h>
+#include <linux/rv.h>
+#include <linux/tracepoint.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "irqstate"
+
+#include <trace/events/irq.h>
+#include <trace/events/sched.h>
+#include <rv_trace.h>
+#include <monitors/irqentry/irqentry.h>
+
+#define RV_MON_TYPE RV_MON_PER_CPU
+#include "irqstate.h"
+#include <rv/ha_monitor.h>
+
+static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_irqstate env,
+		      u64 time_ns)
+{
+	switch (env) {
+	case hardirq_irqstate:
+		return hardirq_count();
+	case serving_softirq_irqstate:
+		return !!in_serving_softirq();
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
+	if (curr_state == in_hardirq_irqstate && event == hardirq_exit_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) > 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 0;
+	else if (curr_state == in_hardirq_irqstate &&
+		 event == softirq_entry_from_hardirq_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) == 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == idle_irqstate && event == hardirq_entry_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) > 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 0;
+	else if (curr_state == idle_irqstate && event == softirq_entry_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) == 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == idle_irqstate && event == softirq_resume_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) == 0;
+	else if (curr_state == in_softirq_irqstate && event == hardirq_entry_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) > 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == in_softirq_irqstate && event == softirq_exit_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) == 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == in_softirq_irqstate && event == softirq_suspend_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) == 0;
+	else if (curr_state == hardirq_from_softirq_irqstate &&
+		 event == hardirq_exit_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) > 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == softirq_from_hardirq_irqstate &&
+		 event == hardirq_entry_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) > 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == softirq_from_hardirq_irqstate &&
+		 event == softirq_exit_to_hardirq_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) == 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+	else if (curr_state == hardirq_from_softirq_from_hardirq_irqstate &&
+		 event == hardirq_exit_irqstate)
+		res = ha_get_env(ha_mon, hardirq_irqstate, time_ns) > 0 &&
+		      ha_get_env(ha_mon, serving_softirq_irqstate, time_ns) == 1;
+
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
+static void handle_hardirq_entry(void *data, unsigned int depth)
+{
+	if (!hardirq_count()) {
+		da_handle_start_run_event(hardirq_entry_irqstate);
+		return;
+	}
+
+	/* Nested hardirqs leave the outer context state unchanged. */
+	if (depth > 1)
+		return;
+
+	if (in_serving_softirq())
+		da_handle_event(hardirq_entry_irqstate);
+	else
+		da_handle_start_run_event(hardirq_entry_irqstate);
+}
+
+static void handle_hardirq_exit(void *data, unsigned int depth)
+{
+	if (!hardirq_count()) {
+		da_handle_start_run_event(hardirq_exit_irqstate);
+		return;
+	}
+
+	/* Nested hardirqs leave the outer context state unchanged. */
+	if (depth > 1)
+		return;
+
+	if (in_serving_softirq())
+		da_handle_event(hardirq_exit_irqstate);
+	else
+		da_handle_start_event(hardirq_exit_irqstate);
+}
+
+static void handle_softirq_entry(void *data, bool serving, bool from_hardirq)
+{
+	if (from_hardirq)
+		da_handle_event(softirq_entry_from_hardirq_irqstate);
+	else
+		da_handle_start_run_event(softirq_entry_irqstate);
+}
+
+static void handle_softirq_exit(void *data, bool serving, bool from_hardirq)
+{
+	if (from_hardirq) {
+		da_handle_event(softirq_exit_to_hardirq_irqstate);
+		return;
+	}
+
+	if (in_serving_softirq())
+		da_handle_start_event(softirq_exit_irqstate);
+	else
+		da_handle_start_run_event(softirq_exit_irqstate);
+}
+
+#ifdef CONFIG_PREEMPT_RT
+static void handle_sched_switch(void *data, bool preempt,
+				struct task_struct *prev,
+				struct task_struct *next,
+				unsigned int prev_state)
+{
+	/*
+	 * Serving-softirq state belongs to a task on RT. At this tracepoint
+	 * interrupts are disabled and current still names prev. Suspend its
+	 * context before representing the context of the incoming task.
+	 */
+	if (READ_ONCE(prev->softirq_disable_cnt) & SOFTIRQ_OFFSET)
+		da_handle_start_event(softirq_suspend_irqstate);
+	if (READ_ONCE(next->softirq_disable_cnt) & SOFTIRQ_OFFSET)
+		da_handle_start_run_event(softirq_resume_irqstate);
+}
+#endif
+
+static void attach_irqstate(void)
+{
+	rv_attach_trace_probe("irqstate", hardirq_context_entry, handle_hardirq_entry);
+	rv_attach_trace_probe("irqstate", hardirq_context_exit, handle_hardirq_exit);
+	rv_attach_trace_probe("irqstate", softirq_context_entry, handle_softirq_entry);
+	rv_attach_trace_probe("irqstate", softirq_context_exit, handle_softirq_exit);
+#ifdef CONFIG_PREEMPT_RT
+	rv_attach_trace_probe("irqstate", sched_switch, handle_sched_switch);
+	/*
+	 * Drain BH preparations which sampled the entry tracepoint disabled.
+	 * Their RCU read-side protection covers that sample and the serving
+	 * interval. Do not enable the monitor while one can still publish a
+	 * serving bit without its entry event after an IRQ synchronizes idle.
+	 */
+	synchronize_rcu();
+#endif
+}
+
+static void detach_irqstate(void)
+{
+	rv_detach_trace_probe("irqstate", hardirq_context_entry, handle_hardirq_entry);
+	rv_detach_trace_probe("irqstate", hardirq_context_exit, handle_hardirq_exit);
+	rv_detach_trace_probe("irqstate", softirq_context_entry, handle_softirq_entry);
+	rv_detach_trace_probe("irqstate", softirq_context_exit, handle_softirq_exit);
+#ifdef CONFIG_PREEMPT_RT
+	rv_detach_trace_probe("irqstate", sched_switch, handle_sched_switch);
+#endif
+}
+
+static int enable_irqstate(void)
+{
+	int retval;
+
+	retval = ha_monitor_init();
+	if (retval)
+		return retval;
+
+	attach_irqstate();
+
+	return 0;
+}
+
+static void disable_irqstate(void)
+{
+	rv_this.enabled = 0;
+
+	detach_irqstate();
+
+	ha_monitor_destroy();
+}
+
+static struct rv_monitor rv_this = {
+	.name = "irqstate",
+	.description = "IRQ context boundaries agree with execution state.",
+	.enable = enable_irqstate,
+	.disable = disable_irqstate,
+	.reset = da_monitor_reset_all,
+	.enabled = 0,
+};
+
+static int __init register_irqstate(void)
+{
+	return rv_register_monitor(&rv_this, &rv_irqentry);
+}
+
+static void __exit unregister_irqstate(void)
+{
+	rv_unregister_monitor(&rv_this);
+}
+
+module_init(register_irqstate);
+module_exit(unregister_irqstate);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Karl Mehltretter <kmehltretter@gmail.com>");
+MODULE_DESCRIPTION("irqstate: verify IRQ event and execution context agreement");
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate.h b/kernel/trace/rv/monitors/irqstate/irqstate.h
new file mode 100644
index 0000000000000..2459f579c4696
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqstate/irqstate.h
@@ -0,0 +1,139 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Automatically generated C representation of irqstate automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+#define MONITOR_NAME irqstate
+
+enum states_irqstate {
+	idle_irqstate,
+	hardirq_from_softirq_irqstate,
+	hardirq_from_softirq_from_hardirq_irqstate,
+	in_hardirq_irqstate,
+	in_softirq_irqstate,
+	softirq_from_hardirq_irqstate,
+	state_max_irqstate,
+};
+
+#define INVALID_STATE state_max_irqstate
+
+enum events_irqstate {
+	hardirq_entry_irqstate,
+	hardirq_exit_irqstate,
+	softirq_entry_irqstate,
+	softirq_entry_from_hardirq_irqstate,
+	softirq_exit_irqstate,
+	softirq_exit_to_hardirq_irqstate,
+	softirq_resume_irqstate,
+	softirq_suspend_irqstate,
+	event_max_irqstate,
+};
+
+enum envs_irqstate {
+	hardirq_irqstate,
+	serving_softirq_irqstate,
+	env_max_irqstate,
+	env_max_stored_irqstate = hardirq_irqstate,
+};
+
+_Static_assert(env_max_stored_irqstate <= MAX_HA_ENV_LEN, "Not enough slots");
+
+struct automaton_irqstate {
+	char *state_names[state_max_irqstate];
+	char *event_names[event_max_irqstate];
+	char *env_names[env_max_irqstate];
+	unsigned char function[state_max_irqstate][event_max_irqstate];
+	unsigned char initial_state;
+	bool final_states[state_max_irqstate];
+};
+
+static const struct automaton_irqstate automaton_irqstate = {
+	.state_names = {
+		"idle",
+		"hardirq_from_softirq",
+		"hardirq_from_softirq_from_hardirq",
+		"in_hardirq",
+		"in_softirq",
+		"softirq_from_hardirq",
+	},
+	.event_names = {
+		"hardirq_entry",
+		"hardirq_exit",
+		"softirq_entry",
+		"softirq_entry_from_hardirq",
+		"softirq_exit",
+		"softirq_exit_to_hardirq",
+		"softirq_resume",
+		"softirq_suspend",
+	},
+	.env_names = {
+		"hardirq",
+		"serving_softirq",
+	},
+	.function = {
+		{
+			in_hardirq_irqstate,
+			INVALID_STATE,
+			in_softirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			in_softirq_irqstate,
+			INVALID_STATE,
+		},
+		{
+			INVALID_STATE,
+			in_softirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			INVALID_STATE,
+			softirq_from_hardirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			INVALID_STATE,
+			idle_irqstate,
+			INVALID_STATE,
+			softirq_from_hardirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+		{
+			hardirq_from_softirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			idle_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			idle_irqstate,
+		},
+		{
+			hardirq_from_softirq_from_hardirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			INVALID_STATE,
+			in_hardirq_irqstate,
+			INVALID_STATE,
+			INVALID_STATE,
+		},
+	},
+	.initial_state = idle_irqstate,
+	.final_states = { 1, 0, 0, 0, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitors/irqstate/irqstate_trace.h b/kernel/trace/rv/monitors/irqstate/irqstate_trace.h
new file mode 100644
index 0000000000000..43de706dda7b6
--- /dev/null
+++ b/kernel/trace/rv/monitors/irqstate/irqstate_trace.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifdef CONFIG_RV_MON_IRQSTATE
+DEFINE_EVENT(event_da_monitor, event_irqstate,
+	     TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor, error_irqstate,
+	     TP_PROTO(char *state, char *event),
+	     TP_ARGS(state, event));
+
+DEFINE_EVENT(error_env_da_monitor, error_env_irqstate,
+	     TP_PROTO(char *state, char *event, char *env),
+	     TP_ARGS(state, event, env));
+#endif /* CONFIG_RV_MON_IRQSTATE */
diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 2f8a932432c95..040b3635ef289 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -91,6 +91,7 @@ DECLARE_EVENT_CLASS(error_env_da_monitor,
 );
 
 #include <monitors/opid/opid_trace.h>
+#include <monitors/irqstate/irqstate_trace.h>
 // Add new monitors based on CONFIG_HA_MON_EVENTS_IMPLICIT here
 
 #endif
diff --git a/tools/verification/models/irqentry/irqstate.dot b/tools/verification/models/irqentry/irqstate.dot
new file mode 100644
index 0000000000000..90c41e8909e4e
--- /dev/null
+++ b/tools/verification/models/irqentry/irqstate.dot
@@ -0,0 +1,32 @@
+digraph state_automaton {
+	center = true;
+	size = "7,11";
+	{node [shape = plaintext, style=invis, label=""] "__init_idle"};
+	{node [shape = doublecircle] "idle"};
+	{node [shape = circle] "in_hardirq"};
+	{node [shape = circle] "in_softirq"};
+	{node [shape = circle] "hardirq_from_softirq"};
+	{node [shape = circle] "softirq_from_hardirq"};
+	{node [shape = circle] "hardirq_from_softirq_from_hardirq"};
+	"__init_idle" -> "idle";
+	"idle" [label = "idle", color = green3];
+	"idle" -> "in_hardirq" [ label = "hardirq_entry;hardirq > 0 && serving_softirq == 0" ];
+	"idle" -> "in_softirq" [ label = "softirq_entry;hardirq == 0 && serving_softirq == 1\nsoftirq_resume;hardirq == 0" ];
+	"in_hardirq" [label = "in_hardirq"];
+	"in_hardirq" -> "idle" [ label = "hardirq_exit;hardirq > 0 && serving_softirq == 0" ];
+	"in_hardirq" -> "softirq_from_hardirq" [ label = "softirq_entry_from_hardirq;hardirq == 0 && serving_softirq == 1" ];
+	"in_softirq" [label = "in_softirq"];
+	"in_softirq" -> "idle" [ label = "softirq_exit;hardirq == 0 && serving_softirq == 1\nsoftirq_suspend;hardirq == 0" ];
+	"in_softirq" -> "hardirq_from_softirq" [ label = "hardirq_entry;hardirq > 0 && serving_softirq == 1" ];
+	"hardirq_from_softirq" [label = "hardirq_from_softirq"];
+	"hardirq_from_softirq" -> "in_softirq" [ label = "hardirq_exit;hardirq > 0 && serving_softirq == 1" ];
+	"softirq_from_hardirq" [label = "softirq_from_hardirq"];
+	"softirq_from_hardirq" -> "in_hardirq" [ label = "softirq_exit_to_hardirq;hardirq == 0 && serving_softirq == 1" ];
+	"softirq_from_hardirq" -> "hardirq_from_softirq_from_hardirq" [ label = "hardirq_entry;hardirq > 0 && serving_softirq == 1" ];
+	"hardirq_from_softirq_from_hardirq" [label = "hardirq_from_softirq_from_hardirq"];
+	"hardirq_from_softirq_from_hardirq" -> "softirq_from_hardirq" [ label = "hardirq_exit;hardirq > 0 && serving_softirq == 1" ];
+	{ rank = min ;
+		"__init_idle";
+		"idle";
+	}
+}
-- 
2.39.5 (Apple Git-154)

