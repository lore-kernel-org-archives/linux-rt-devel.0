Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645654;
	b=ZhX+kFhRxJVLyuPLHqdclY7zUbauMRyvjX6Yg1nNmy15gtnfEJ7RXsfj9+jfyzx/ZqEh
	 GK7eS3ToZeRVuAsRFyOapkK9opjHqn4IdU3qjb0Rs82PuqI/Wa6wHCpZ4XzlNx3wGnfmw
	 itPzXzbAzBktIGkVBSsq83rDMaz8wLbIrjoVNq8XHJF4VnNt4rNLkBIYjk6sdxBEkxKMK
	 x9ZuWZFJUbKyFJrDJnggjkFfLrjpeZcEWJZQByCoDfvaFmKoN+Li9NXJno4trorRdNa6R
	 iOHZZfCU7BD429+CzBIERpAcwRyyamrHXu4Y/4JvufILOMLe9xWwRPI0ILFlefT1W3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RVCEYCvcD/LI4F4phUaENR7v/vt6SGoYCV0hEXjw1+k=;
	b=mWQa8sGE5cRM8phXg81Tqz+2evOrTQYVzA4hfQvzyC1P3U8aFN/HNMPjJfkvG+nB2/FN
	 leApSjMja9ZPFuvqI9UgruHoY4IxwNYvAyVNBAnCkNxp4aFKa69pDEKOIuhpQTz3kR0Sr
	 /ymA2oAffjMYhH1wca2z/sPPs+TDDWQi5f5qqQlGeLmMQ6NMf/kIbPo98bDjVqOSQYA+i
	 fobQL43Yd/sGeAO2P7hYN+PT6uld+IX+VxGg0Z0FNqF0UgIFUNf7VSHgpvBxW/MgnMEMV
	 wNsgaNCm3NcJEh8p3me8VN+ZbwdCVpaOV1IVnepZYUZDbsy7vIe4wPOo3Vb26qfcsTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TEejIY43;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F336606A328
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 05:07:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F336606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TEejIY43
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e0d1da913so363301f8f.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 22:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645652; x=1793250452; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVCEYCvcD/LI4F4phUaENR7v/vt6SGoYCV0hEXjw1+k=;
        b=TEejIY43H0u8u4WqFnReyqG0uE2H5CSHJqVHyBZXSVfWQ377F4sn4OFXes5/8h2WjH
         3HtVPTXGG6ZDicC/u9piIOKWu4K+g2VDZ0+rxgLcp0qRlo6E3AdzMitBE/piHHrlRSJz
         GgFXAnPNvkyk8y+Wa+A8mpWSkyCmFAZp903mecY9l761ytSeEf870oeBRYqIl/07zrq6
         /9ryxvmjpgFd0PVyZ2DaOT4z/MbyEVhBAyoRm2q3JyIGvC8RKHfMZ0cL2Fv7c5B9LxiZ
         3YZ2zYRzf+a5Zj+8nimRK3U4X2isN4+eHJ53ZCMN5LXjY6yrDSMthM4AafP9NYFm+IP6
         IajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645652; x=1793250452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RVCEYCvcD/LI4F4phUaENR7v/vt6SGoYCV0hEXjw1+k=;
        b=k4v1WcvRCkEF8tPIAim5OvvKnlS9ws3xhb050sYiY6zEmmoqFNan5+6Q7AyZ+z/Dj5
         n01BHAWaCRbGqXuF7bQlNdhEVv0KTi7PxYgbqqysq6K8mLPMkSI8Zu1b/BhTsjAen0aB
         sAEFQ/1jKBbx6vkpQxih+qbMVkqzTs2U09hBYI9DYppfHTNxMymxxQA8108nvTgOfh0q
         KlnklgIbRtt1wfGaDya2ptlpPpWoJIxV8lSGxaXVmcLfjfRzRTdDy/a0+LytLheTwWJQ
         O/XkvIK12iHFtIH1z1AcQRTIL1YaubaM9ONMQJN5wOCh+wQbqVLD7rF/qjGGQNVnLr4T
         BtMA==
X-Forwarded-Encrypted: i=1; AKwUvBwrtuojdm7hVaucSdftADYNgCCAqOoTplWn2UTlHcNOO3VPcJw7eanMGAvZm201tC0n+bZGDDQugINi64FNeA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLtlNsxhYArhp2Kh98QpY23VNZT6swmHRX5asXCMX4CkZMDB+BX
	6BltsxaI05+daPgOcfr5ZonHVkzeLL1z7+FIq8Q4kcVsO2xFZTQ2+NVN
X-Gm-Gg: AYBFou0gfcRG724moJdYBI8zD4yPHHPo2RUOjukUEVomD3K7WxNJt+qy0jkboorJgJa
	GpJ7yA0sbwCM5SwF+B0qboKH1wca7+oSt3mJfFcIMeLQL+IheWMIMV2zm++xZ8mfpKh+V3MauAT
	XTdGSOY4R6SQWRMl9HRtE0VcMgXndvlUm3vKrZ+gldKecIt2u9e0PE7WDFNOsoH8Wi5CSKtx1i/
	TiBLkdXhW93HZkhjXf74M9SEuYdwxA95VLHWhzsV20NfC3Kal2buPkj8trNzI6f9iDmTC5c0EA+
	M2bLwA/i1GlkS5dYAi0G/sEqyMohda8Y7AZJ6PZnMODbFoeTAhDzxcWhNKBYtPjlU81qqO/KK0i
	4TREVOmlkClGOg/X+DMCAIIlh0VorzgZ211ZNWpbZY96q2tD/zJ0uBHiky6cYj7fzoQX0wDPjTb
	hgAekwfgKGvmKZNzHR2YMIWtM+1RcMXTVdpNoXl5QWw1FWcNgA4YZOHX9tXtFhdBD9SaM3ANraj
	UqHNNurPdxsIinE8V4ETn5KpJcTdY1BN4LH7xxzown+K/IQRyGkAP2E5ddgAX/bWQ82YGyOvOX3
	rElEFVKgxdK1RgYMHL7YCsblSk3RLn20Kk/ARVlkOu51ZHCUU0g72FgzF+eLa1fZTpNXf/936C7
	uLQR7zBFtnr0ZTpDVXc87k2JS3U8pBDem+NqIdArOkBRQwKkla9WjrnWYQ7E=
X-Received: by 2002:a05:6000:1611:b0:48d:fce6:884e with SMTP id ffacd0b85a97d-48e2d110a50mr1772805f8f.12.1792645652196;
        Wed, 21 Oct 2026 22:07:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm9994979f8f.8.2026.10.21.22.07.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:07:31 -0700 (PDT)
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
Subject: [RFC PATCH 2/9] tracing/sched: Add IRQ preemption lifecycle events
Date: Thu, 22 Oct 2026 07:07:05 +0200
Message-Id: <20261022050712.75035-3-kmehltretter@gmail.com>
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

Tracepoints around __schedule() do not identify the boundaries of one
preempt_schedule_irq() invocation. The calling task may switch out and
resume on another CPU before the invocation returns.

Add events at entry to and return from preempt_schedule_irq(). Record the
calling task as the owner in both events so consumers can follow the
invocation across switches and migration. Sample the preempt count and
interrupt state before dispatching the callbacks.

The events bracket preempt_schedule_irq() only. They do not cover
architecture-specific interrupt-return work or establish that the helper
was reached from a physical interrupt.

Assisted-by: LLM
---
 include/trace/events/sched.h | 51 ++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c          |  6 +++++
 2 files changed, 57 insertions(+)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 535860581f159..d0f510c35b02b 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -52,6 +52,57 @@ TRACE_EVENT(sched_kthread_stop_ret,
 	TP_printk("ret=%d", __entry->ret)
 );
 
+DECLARE_EVENT_CLASS(sched_irq_preempt,
+
+	TP_PROTO(struct task_struct *owner, unsigned long pc, bool irq_off),
+
+	TP_ARGS(owner, pc, irq_off),
+
+	TP_STRUCT__entry(
+		__array(char, owner_comm, TASK_COMM_LEN)
+		__field(pid_t, owner_pid)
+		__field(unsigned long, pc)
+		__field(bool, irq_off)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->owner_comm, owner->comm, TASK_COMM_LEN);
+		__entry->owner_pid = owner->pid;
+		__entry->pc = pc;
+		__entry->irq_off = irq_off;
+	),
+
+	TP_printk("owner=%s/%d pc=0x%lx irq_off=%d",
+		  __entry->owner_comm, __entry->owner_pid,
+		  __entry->pc, __entry->irq_off)
+);
+
+/**
+ * sched_irq_preempt_entry - begin preempt_schedule_irq() processing
+ * @owner: task whose interrupted execution will resume after scheduling
+ * @pc: preempt count sampled at the call site, before tracing bookkeeping
+ * @irq_off: interrupt state sampled at the same call site
+ *
+ * Emitted after entry assertions and context-tracking setup, with zero
+ * preempt count and local interrupts disabled. Exception-return paths can
+ * also use this scheduler entrypoint.
+ */
+DEFINE_EVENT(sched_irq_preempt, sched_irq_preempt_entry,
+	     TP_PROTO(struct task_struct *owner, unsigned long pc, bool irq_off),
+	     TP_ARGS(owner, pc, irq_off));
+
+/**
+ * sched_irq_preempt_exit - original preempt_schedule_irq() invocation resumes
+ * @owner: task saved by the matching entry, possibly on a different CPU
+ * @pc: preempt count sampled at the call site, before tracing bookkeeping
+ * @irq_off: interrupt state sampled at the same call site
+ *
+ * Emitted with local interrupts disabled before restoring context tracking.
+ */
+DEFINE_EVENT(sched_irq_preempt, sched_irq_preempt_exit,
+	     TP_PROTO(struct task_struct *owner, unsigned long pc, bool irq_off),
+	     TP_ARGS(owner, pc, irq_off));
+
 /**
  * sched_kthread_work_queue_work - called when a work gets queued
  * @worker:	pointer to the kthread_worker
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1754d9f95f2cf..b971a373ea3a1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7593,12 +7593,16 @@ EXPORT_SYMBOL(dynamic_preempt_schedule_notrace);
  */
 asmlinkage __visible void __sched preempt_schedule_irq(void)
 {
+	struct task_struct *owner = current;
 	enum ctx_state prev_state;
 
 	/* Catch callers which need to be fixed */
 	BUG_ON(preempt_count() || !irqs_disabled());
 
 	prev_state = exception_enter();
+	/* Sample before tracing bookkeeping can change the observed context. */
+	if (trace_sched_irq_preempt_entry_enabled())
+		trace_sched_irq_preempt_entry(owner, preempt_count(), irqs_disabled());
 
 	do {
 		preempt_disable();
@@ -7608,6 +7612,8 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
 
+	if (trace_sched_irq_preempt_exit_enabled())
+		trace_sched_irq_preempt_exit(owner, preempt_count(), irqs_disabled());
 	exception_exit(prev_state);
 }
 
-- 
2.39.5 (Apple Git-154)

