Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792646245;
	b=rNI/5tB3MO0XbKnE6BUjHmfDuoH3avIUerrEby93D7L3fT71XNGRP9BkCbpvuB8RPita
	 IfAv5R/niPClKAW6ur8MVWz9/vUAz8wwOpOoU/7AHnlVXDJxztU5DOD5dzTNZR0KfBQUJ
	 ikx5k1kL4vDMmfgFk5xnBX0vQVULWsyd4+YBqaf++FYkOA956jXx53G6lEPTPhnqokidL
	 ZJ5szRG91z8LmUJOdcgEOPRlopicvMrAfT5FckW5TpNodEjWH8pwBp4TUKLukz6yHSZS4
	 BA4ncsxPMNIf03Os3Um6UmE/2eVKtmAr8ud7CJ2IWUbYbof7IYFqzB0XF+5r1/MKgAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792646245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Jvd6Ubikpqp7Iwt0RuiwkREVpOrwG8rxrLh+IG+UXJI=;
	b=soQZUkW/EzvheIzC1fgQvEsuwoNeZ4AldIWlxgUKtcJTvpGSmJ4pk4zdFzJFvN247VQp
	 t9H/MeuiiMWk0O2QuF3dtcnGS1ntrsJVdMn+vjSs9l3Pfbt0NmBGMANqfXOOdRep1l8MG
	 mq3tLgDs760UrlWiSLz/+zLyt6d6aX8/b//8lT1naQX8/v7cBiVBztwmeMJQ0YPS9UM4B
	 oFg0jcufynYKKof7dt7aOzT1vMrM6BTkrXUZ4gNA8KJyJKgkh0cux33dh5oWYH7jY6r+s
	 iF0hJI3KaryfBdvxP0GTU6TFSoKuHie+AHFr+Luc4F65W8kgCB8ac4cqfeCpujMGKDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PYmItdO2;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23558606A33A
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 05:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23558606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PYmItdO2
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a0286c981dso14578965e9.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 22:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792646242; x=1793251042; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jvd6Ubikpqp7Iwt0RuiwkREVpOrwG8rxrLh+IG+UXJI=;
        b=PYmItdO2E5qWYXo6o3TxmAiEtKPJXBkHLt/mJ65+LBelEnigrl56of/NWRFfsagThb
         YJlMObyAAPv0R2v4fTZ9Ho7SLQcu0uynJQYSdTLworXdKGvgcPG+MqQcWWcZ+CXSGvcg
         8jvVFIuf8ZJx4VaSWlJ5HTc/9aekmdK7qJ0wqhgLjPUW82j4uo2DGRF25gU+6qO5RsL8
         yid0ldaOGk1V7iFtBmvthvifsMFWyNtwYBIy63ANi8RUeIxucQBIYBfL//3qqTpMjgDf
         RXqLhMQoQwdDg/uFQK3SViMOP/s+ZUDv1HvZOTI9XfA8hxJF6Ti32EqGvWx0DRIgvD0M
         09ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792646242; x=1793251042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jvd6Ubikpqp7Iwt0RuiwkREVpOrwG8rxrLh+IG+UXJI=;
        b=rUNck3no24EhoZbnxP5LRsu+5tQWEagW6pl/iKrNzOvIbEEuV+JPi0d7t6c+uln/WS
         v9o1hIKiRjZfYfKRt50qUFxi/7GzZCjCXp8LCrryzRWHeLsxQlwFbabvdgUZsgkQhf9E
         5FCyswYFYcn2RNKx9IbPp5p94dqV0Jmpn5Mg2JSgDj0UdyMDyWlLVM1P6brKR7A+n5ZX
         L2mDY6tAOWjpZOpl8ioSd+cwb1jKNeW+nSy6mOtjxMxA3wjrWpBqCYWCPqxGQMGKHgKd
         VtxbOtG5dhTqdJYEZR9TV/JyutSPe/h9CgoOm8Dv240iwPPMpyWJxb//JJqq7D1NSi9v
         pr+A==
X-Forwarded-Encrypted: i=1; AKwUvBxh0kTfVpfWRbIHMAIBLQe4UuCbVo9UWAHO8LhHggR3LWvbwkgGX2jv7jfd8h6Z36BvLPgd5zF7bfCAH5XlZg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ41CnfFIZ+oB4UKsA/eggk6HutDYUBphz8WtyjkROjq+MgD+Qo
	NM+KbPFfbkeT+Mi/NnlkCH2wvI4p3ajEZKNjMBWLoCCxa0Q7dkYRlFJy
X-Gm-Gg: AYBFou24IOtvQG16b2HXlVDc1TXZyM2j68EKj1rhjp4QxbIeRKWCyNtN2aDeYuCPqby
	aM3T3Q4jJ3f81SB2T6GIsTnBXw++Ve1j1MtOHekFJVozHzjul7i+JlEgSSxvKoUtZ452LdiPuCi
	rEr402r9Z8gWWOaZziqZDKyGRsJSgNOskSinfEjwVRIVA3Ar8ylGoVMX3CJtIIUsxqMcYOtbDLF
	865qXPw0ReDc2wZ/AXaK1CTTRcmg1SngDZjUJYD3FRH49Cd5HS9yXaQ9XVHaWhCdW+WQHl/01hy
	L7Nz1zE3ZPLbjb46/HsHHdLWJ+tnENmUBsYdZ/68iQ6OvhpZQ3RcAH+evMtb1ZW9USKc6oLlcKi
	wh/UgtS8VYVW0tQ9XWuBZXtdwZrWPSXDZOVAYS+kYyw/tbYAaqxMFeamG+0JzFYokltt/oi6J+H
	HBCTbA2tiF1gaftEnAJUfla3w6hOKoBLQ+EJV53p0SAtzZ41dlsRyjsA1gpaaDgDMk+pPDdhUpY
	jGIBXJmPW8tY2mT0kD8XvgdV+kA/yLWCe/gvUZye41QpP4lzllnFDC4fu4rYUdgIve+vulNVCdM
	QaspIfvrnDOemR6xdzmI5XD7xGnM5vZB/rBV6bz+b20BQvdPAQkpFqvjG7/5eog06urhiJLIlqP
	DeCOgUY3M3fRon2Jh/ax2eXyaJmVy896ujMrkc2jKxIEIXWGPGQEgdFh7bos=
X-Received: by 2002:a05:600c:a15:b0:4a1:c6a2:5566 with SMTP id 5b1f17b1804b1-4a1fdd2fa77mr75428425e9.26.1792646242449;
        Wed, 21 Oct 2026 22:17:22 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1fd0f4427sm90362275e9.3.2026.10.21.22.17.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:17:21 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 03/12] entry: Add the pre-counted ordinary-hardirq entry/exit contract
Date: Thu, 22 Oct 2026 07:16:45 +0200
Message-Id: <20261022051654.79224-4-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261022051654.79224-1-kmehltretter@gmail.com>
References: <20261022051654.79224-1-kmehltretter@gmail.com>
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

Architectures which identify ordinary hardirqs before generic entry need
to install HARDIRQ_OFFSET before context tracking and tracing callbacks
run. Lockdep hardirq state must agree with that count. On exit, both states
must remain installed until every traceable callback has returned.

Add irqentry_hardirq_enter() to install the raw count and lockdep state
before instrumentable entry work. irq_enter_rcu_preempt_counted() completes
the delayed preempt-count bookkeeping while preserving the existing timer
and hardirq accounting boundary.

Add a retained exit path which runs IRQ-exit processing and instrumentable
teardown preparation before returning to an immediate raw count and lockdep
teardown. This keeps function-graph return callbacks in hardirq context.

A return callback after the final softirq drain can raise regular or
forced-thread timer work while hardirq state still suppresses the usual
wakeup. Recheck ksoftirqd, ktimerd, then ksoftirqd after the last traceable
teardown step. Record wake requests made by the main exit path so the
closure does not repeat them.

Keep the existing entry and exit interfaces unchanged. Architectures opt
in only after distinguishing ordinary hardirqs from NMI-like entry. They
must not place instrumentable code between the retained-exit helper and
raw teardown.

Assisted-by: LLM
---
 include/linux/hardirq.h          |  24 +++++
 include/linux/interrupt.h        |   2 +-
 include/linux/irq-entry-common.h |  31 ++++++-
 include/linux/irqflags.h         |   9 +-
 kernel/entry/common.c            |  30 +++++++
 kernel/softirq.c                 | 148 ++++++++++++++++++++++++++-----
 6 files changed, 215 insertions(+), 29 deletions(-)

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 73b48dd9f1354..ad27a06c859a0 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -25,6 +25,30 @@ static __always_inline void rcu_irq_enter_check_tick(void)
 		__rcu_irq_enter_check_tick();
 }
 
+void irq_enter_rcu_preempt_counted(void);
+bool irq_exit_rcu_preempt_counted_prepare(void);
+
+/*
+ * Prepare every potentially instrumentable part of hardirq teardown before
+ * the raw count and lockdep updates. The caller must invoke the matching
+ * finish helper without passing through instrumentable code.
+ */
+static __always_inline bool irqentry_hardirq_exit_prepare(void)
+{
+	bool do_sub;
+
+	do_sub = preempt_count_sub_prepare(HARDIRQ_OFFSET);
+	lockdep_hardirq_exit_prepare();
+	return do_sub;
+}
+
+static __always_inline void irqentry_hardirq_exit_finish(bool do_sub)
+{
+	if (do_sub)
+		__preempt_count_sub(HARDIRQ_OFFSET);
+	lockdep_hardirq_exit_finish();
+}
+
 /*
  * It is safe to do non-atomic ops on ->hardirq_context,
  * because NMI handlers may not preempt and the ops are
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3bf969ad8fe07..fda5a29b176b4 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -636,7 +636,7 @@ DECLARE_PER_CPU(struct task_struct *, ktimerd);
 DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
 void raise_ktimers_thread(unsigned int nr);
 
-static inline unsigned int local_timers_pending_force_th(void)
+static __always_inline unsigned int local_timers_pending_force_th(void)
 {
 	return __this_cpu_read(pending_timer_softirq);
 }
diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index c74b5c87e10f6..3ee80e926a17a 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -76,8 +76,9 @@ static __always_inline bool arch_in_rcu_eqs(void) { return false; }
 #endif
 
 /**
- * enter_from_user_mode - Establish state when coming from user mode
+ * __enter_from_user_mode - Establish state when coming from user mode
  * @regs:	Pointer to currents pt_regs
+ * @hardirq:	Whether to establish hardirq lockdep context before tracing
  *
  * Syscall/interrupt entry disables interrupts, but user mode is traced as
  * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
@@ -95,10 +96,13 @@ static __always_inline bool arch_in_rcu_eqs(void) { return false; }
  * done between establishing state and enabling interrupts. The caller must
  * enable interrupts before invoking syscall_enter_from_user_mode_work().
  */
-static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+static __always_inline void __enter_from_user_mode(struct pt_regs *regs,
+						   bool hardirq)
 {
 	arch_enter_from_user_mode(regs);
 	lockdep_hardirqs_off(CALLER_ADDR0);
+	if (hardirq)
+		lockdep_hardirq_enter();
 
 	CT_WARN_ON(__ct_state() != CT_STATE_USER);
 	user_exit_irqoff();
@@ -109,6 +113,11 @@ static __always_inline void enter_from_user_mode(struct pt_regs *regs)
 	instrumentation_end();
 }
 
+static __always_inline void enter_from_user_mode(struct pt_regs *regs)
+{
+	__enter_from_user_mode(regs, false);
+}
+
 /**
  * arch_exit_to_user_mode_work - Architecture specific TIF work for exit
  *				 to user mode.
@@ -341,6 +350,8 @@ typedef struct irqentry_state {
 } irqentry_state_t;
 #endif
 
+irqentry_state_t noinstr irqentry_hardirq_enter(struct pt_regs *regs);
+
 /**
  * irqentry_exit_cond_resched - Conditionally reschedule on return from interrupt
  *
@@ -364,8 +375,9 @@ void dynamic_irqentry_exit_cond_resched(void);
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
 /**
- * irqentry_enter_from_kernel_mode - Establish state before invoking the irq handler
+ * __irqentry_enter_from_kernel_mode - Establish state before invoking an exception
  * @regs:	Pointer to currents pt_regs
+ * @hardirq:	Whether to establish hardirq lockdep context before tracing
  *
  * Invoked from architecture specific entry code with interrupts disabled.
  * Can only be called when the interrupt entry came from kernel mode. The
@@ -379,7 +391,8 @@ void dynamic_irqentry_exit_cond_resched(void);
  *
  * Returns: An opaque object that must be passed to irqentry_exit_to_kernel_mode().
  */
-static __always_inline irqentry_state_t irqentry_enter_from_kernel_mode(struct pt_regs *regs)
+static __always_inline irqentry_state_t
+__irqentry_enter_from_kernel_mode(struct pt_regs *regs, bool hardirq)
 {
 	irqentry_state_t ret = {
 		.exit_rcu = false,
@@ -416,6 +429,8 @@ static __always_inline irqentry_state_t irqentry_enter_from_kernel_mode(struct p
 		 * as in irqentry_enter_from_user_mode().
 		 */
 		lockdep_hardirqs_off(CALLER_ADDR0);
+		if (hardirq)
+			lockdep_hardirq_enter();
 		ct_irq_enter();
 		instrumentation_begin();
 		kmsan_unpoison_entry_regs(regs);
@@ -433,6 +448,8 @@ static __always_inline irqentry_state_t irqentry_enter_from_kernel_mode(struct p
 	 * in having another one here.
 	 */
 	lockdep_hardirqs_off(CALLER_ADDR0);
+	if (hardirq)
+		lockdep_hardirq_enter();
 	instrumentation_begin();
 	kmsan_unpoison_entry_regs(regs);
 	rcu_irq_enter_check_tick();
@@ -442,6 +459,12 @@ static __always_inline irqentry_state_t irqentry_enter_from_kernel_mode(struct p
 	return ret;
 }
 
+static __always_inline irqentry_state_t
+irqentry_enter_from_kernel_mode(struct pt_regs *regs)
+{
+	return __irqentry_enter_from_kernel_mode(regs, false);
+}
+
 /**
  * irqentry_exit_to_kernel_mode_preempt - Run preempt checks on return to kernel mode
  * @regs:	Pointer to current's pt_regs
diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
index 5bc179a88e513..e98313a8ad307 100644
--- a/include/linux/irqflags.h
+++ b/include/linux/irqflags.h
@@ -64,9 +64,14 @@ do {							\
 do {						\
 	current->hardirq_threaded = 1;		\
 } while (0)
+# define lockdep_hardirq_exit_prepare()	\
+	__this_cpu_preempt_check("add")
+# define lockdep_hardirq_exit_finish()		\
+	raw_cpu_dec(hardirq_context)
 # define lockdep_hardirq_exit()			\
 do {						\
-	__this_cpu_dec(hardirq_context);	\
+	lockdep_hardirq_exit_prepare();		\
+	lockdep_hardirq_exit_finish();		\
 } while (0)
 
 # define lockdep_hrtimer_enter(__hrtimer)		\
@@ -119,6 +124,8 @@ do {						\
 # define lockdep_softirqs_enabled(p)		0
 # define lockdep_hardirq_enter()		do { } while (0)
 # define lockdep_hardirq_threaded()		do { } while (0)
+# define lockdep_hardirq_exit_prepare()	do { } while (0)
+# define lockdep_hardirq_exit_finish()		do { } while (0)
 # define lockdep_hardirq_exit()			do { } while (0)
 # define lockdep_softirq_enter()		do { } while (0)
 # define lockdep_softirq_exit()			do { } while (0)
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 28399c41ebfb1..36c43d3c76eae 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/futex.h>
+#include <linux/hardirq.h>
 #include <linux/highmem.h>
 #include <linux/irq-entry-common.h>
 #include <linux/jump_label.h>
@@ -120,6 +121,35 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	return irqentry_enter_from_kernel_mode(regs);
 }
 
+/**
+ * irqentry_hardirq_enter - Establish state for ordinary hardirq entry
+ * @regs: Pointer to the interrupted register state
+ *
+ * Install the raw hardirq count before anything instrumentable can run. Then
+ * establish IRQ-disabled and hardirq lockdep state before context tracking or
+ * irqflag tracing can invoke callbacks. The caller must have distinguished an
+ * ordinary hardirq from NMI-like entry and must complete the delayed
+ * preempt-count bookkeeping with irq_enter_rcu_preempt_counted().
+ *
+ * Returns: An opaque object for the matching irqentry exit operation.
+ */
+noinstr irqentry_state_t irqentry_hardirq_enter(struct pt_regs *regs)
+{
+	__preempt_count_add(HARDIRQ_OFFSET);
+
+	if (user_mode(regs)) {
+		irqentry_state_t ret = {
+			.exit_rcu = false,
+		};
+
+		__enter_from_user_mode(regs, true);
+		rseq_note_user_irq_entry();
+		return ret;
+	}
+
+	return __irqentry_enter_from_kernel_mode(regs, true);
+}
+
 /**
  * arch_irqentry_exit_need_resched - Architecture specific need resched function
  *
diff --git a/kernel/softirq.c b/kernel/softirq.c
index be49e6469f3ad..63427d29cb6d1 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -14,6 +14,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/instrumentation.h>
 #include <linux/local_lock.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
@@ -353,15 +354,18 @@ static inline void ksoftirqd_run_end(void)
 static inline bool softirq_handle_begin(void) { return false; }
 static inline void softirq_handle_end(bool from_irq_exit) { }
 
-static inline bool should_wake_ksoftirqd(void)
+static __always_inline bool should_wake_ksoftirqd(void)
 {
 	return !this_cpu_read(softirq_ctrl.cnt);
 }
 
-static inline void invoke_softirq(void)
+static inline bool invoke_softirq(void)
 {
-	if (should_wake_ksoftirqd())
-		wakeup_softirqd();
+	if (!should_wake_ksoftirqd())
+		return false;
+
+	wakeup_softirqd();
+	return true;
 }
 
 #define SCHED_SOFTIRQ_MASK	BIT(SCHED_SOFTIRQ)
@@ -525,12 +529,12 @@ static inline void ksoftirqd_run_end(void)
 	local_irq_enable();
 }
 
-static inline bool should_wake_ksoftirqd(void)
+static __always_inline bool should_wake_ksoftirqd(void)
 {
 	return true;
 }
 
-static inline void invoke_softirq(void)
+static inline bool invoke_softirq(void)
 {
 	if (!force_irqthreads() || !__this_cpu_read(ksoftirqd)) {
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
@@ -548,9 +552,11 @@ static inline void invoke_softirq(void)
 		 */
 		do_softirq_own_stack();
 #endif
-	} else {
-		wakeup_softirqd();
+		return false;
 	}
+
+	wakeup_softirqd();
+	return true;
 }
 
 asmlinkage __visible void do_softirq(void)
@@ -703,13 +709,8 @@ asmlinkage __visible void __softirq_entry __do_softirq(void)
 	handle_softirqs(false);
 }
 
-/**
- * irq_enter_rcu - Enter an interrupt context with RCU watching
- */
-void irq_enter_rcu(void)
+static __always_inline void irq_enter_rcu_common(void)
 {
-	__irq_enter_raw();
-
 	/*
 	 * If this is a nested interrupt that hits the exit_to_user_mode_loop
 	 * where it has enabled interrupts but before it has hit schedule() we
@@ -724,6 +725,28 @@ void irq_enter_rcu(void)
 	account_hardirq_enter(current);
 }
 
+/**
+ * irq_enter_rcu_preempt_counted - Enter hardirq with its count already set
+ *
+ * Complete an early raw hardirq preempt-count update, then establish the
+ * remaining timer and accounting state. The matching lockdep hardirq state
+ * was established by irqentry_hardirq_enter() before entry tracing.
+ */
+void irq_enter_rcu_preempt_counted(void)
+{
+	preempt_count_add_finish(HARDIRQ_OFFSET);
+	irq_enter_rcu_common();
+}
+
+/**
+ * irq_enter_rcu - Enter an interrupt context with RCU watching
+ */
+void irq_enter_rcu(void)
+{
+	__irq_enter_raw();
+	irq_enter_rcu_common();
+}
+
 /**
  * irq_enter - Enter an interrupt context including RCU update
  */
@@ -764,8 +787,56 @@ static inline void wake_timersd(void) { }
 
 #endif
 
-static inline void __irq_exit_rcu(void)
+static __always_inline bool irq_exit_wake_ksoftirqd(void)
 {
+	if (irq_count() != HARDIRQ_OFFSET || !local_softirq_pending() ||
+	    !should_wake_ksoftirqd())
+		return false;
+
+	wakeup_softirqd();
+	return true;
+}
+
+static __always_inline bool irq_exit_wake_timersd(void)
+{
+	if (!IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) || !force_irqthreads() ||
+	    !local_timers_pending_force_th() ||
+	    hardirq_count() != HARDIRQ_OFFSET)
+		return false;
+
+	wake_timersd();
+	return true;
+}
+
+enum irq_exit_wake_flags {
+	IRQ_EXIT_WAKE_KSOFTIRQD	= BIT(0),
+	IRQ_EXIT_WAKE_KTIMERD	= BIT(1),
+};
+
+static __always_inline void
+irq_exit_wake_late_softirqs(unsigned int wake_flags)
+{
+	bool ksoftirqd_wake_requested = wake_flags & IRQ_EXIT_WAKE_KSOFTIRQD;
+	bool ktimerd_wake_requested = wake_flags & IRQ_EXIT_WAKE_KTIMERD;
+
+	/*
+	 * A wakeup can be traced, and its callback can raise work for the other
+	 * worker. Check ksoftirqd, then ktimerd, then ksoftirqd again. Skip a
+	 * worker whose direct wake request was recorded above: it cannot run on
+	 * this CPU before hardirq teardown, so later work remains visible to it.
+	 */
+	if (!ksoftirqd_wake_requested)
+		ksoftirqd_wake_requested = irq_exit_wake_ksoftirqd();
+	if (!ktimerd_wake_requested)
+		ktimerd_wake_requested = irq_exit_wake_timersd();
+	if (!ksoftirqd_wake_requested && ktimerd_wake_requested)
+		irq_exit_wake_ksoftirqd();
+}
+
+static __always_inline unsigned int __irq_exit_rcu(bool keep_hardirq_count)
+{
+	unsigned int wake_flags = 0;
+
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
 	local_irq_disable();
 #else
@@ -783,20 +854,51 @@ static inline void __irq_exit_rcu(void)
 		 * before enabling interrupts to run softirq.
 		 */
 		hrtimer_rearm_deferred();
-		invoke_softirq();
+		if (invoke_softirq() && keep_hardirq_count)
+			wake_flags |= IRQ_EXIT_WAKE_KSOFTIRQD;
 	}
 
 	/*
 	 * Wake the timer thread even if the interrupt hit a softirq or a
 	 * section with BHs disabled. Only the outermost interrupt can wake it.
 	 */
-	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
-	    local_timers_pending_force_th() &&
-	    hardirq_count() == HARDIRQ_OFFSET)
-		wake_timersd();
+	if (irq_exit_wake_timersd() && keep_hardirq_count)
+		wake_flags |= IRQ_EXIT_WAKE_KTIMERD;
 
 	tick_irq_exit();
-	preempt_count_sub(HARDIRQ_OFFSET);
+	if (!keep_hardirq_count)
+		preempt_count_sub(HARDIRQ_OFFSET);
+
+	return wake_flags;
+}
+
+/**
+ * irq_exit_rcu_preempt_counted_prepare - Process IRQ exit and prepare teardown
+ *
+ * The caller established hardirq state before instrumentable IRQ entry. Keep
+ * that state through every traceable part of IRQ exit, then prepare its raw
+ * teardown. The caller must apply the raw teardown immediately after return.
+ *
+ * Return callbacks can raise regular or forced-thread timer softirqs after
+ * __irq_exit_rcu() performed its final drain and worker wakeups. Recheck both
+ * queues after all traceable preparation. Worker wakeups are traceable too,
+ * so order the rechecks such that a callback which raises work for the other
+ * worker cannot leave it asleep. Do not repeat a direct worker wake
+ * recorded by __irq_exit_rcu(); the worker cannot run on this CPU before
+ * hardirq teardown.
+ */
+bool noinstr irq_exit_rcu_preempt_counted_prepare(void)
+{
+	unsigned int wake_flags;
+	bool do_sub;
+
+	instrumentation_begin();
+	wake_flags = __irq_exit_rcu(true);
+	do_sub = irqentry_hardirq_exit_prepare();
+	irq_exit_wake_late_softirqs(wake_flags);
+	instrumentation_end();
+
+	return do_sub;
 }
 
 /**
@@ -806,7 +908,7 @@ static inline void __irq_exit_rcu(void)
  */
 void irq_exit_rcu(void)
 {
-	__irq_exit_rcu();
+	__irq_exit_rcu(false);
 	 /* must be last! */
 	lockdep_hardirq_exit();
 }
@@ -818,7 +920,7 @@ void irq_exit_rcu(void)
  */
 void irq_exit(void)
 {
-	__irq_exit_rcu();
+	__irq_exit_rcu(false);
 	ct_irq_exit();
 	 /* must be last! */
 	lockdep_hardirq_exit();
-- 
2.39.5 (Apple Git-154)

