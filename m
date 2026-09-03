Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83FAF456E1E
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Sep 2026 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788434873; cv=none; b=HAt7RLrGoSQF4RlEWJ3FDGZLTo6XGJDjTb5698z7c415klWN0CahSacTY/tnbPegTb4U3IWuCyHrdwudxINuHhnfBdbJvTDDwjRW7LuHII2UYSyW7Mtqfm/yFExq6NgRvMQC7exC0BT7qIBqwkqQ69qSBMMLD6UhVty1XbVvnEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788434873; c=relaxed/simple;
	bh=bpt7RHW5YEvSeuRX4i+k8HqnnLI/qvItvdzE0CmtwNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p4hpI6GvKoiuA4rFx7WaXPWcdXtGbkwbewSyY3XjeJWjxnqREDddH2ffz5cOkVcwZClIqTxcFRbDNEYfJWz/iMfHI2YWPDj82u0pyCG1xgj4sbjiOYVv8MvUHnlhIf14us93VAVzMmLDjiCHV4W65IkVXJWPbCnEiZmCwbShdIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1ud0p9q; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1ud0p9q"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-482e4998d28so1667278f8f.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 03 Sep 2026 04:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788434867; x=1789039667; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2uZzEoi17n5jSyEBNDhQETxzMK74y33vCW7uiC5o2HE=;
        b=U1ud0p9qg93Ff8mzALEAJzj+6qGaWJpwrTJBwPlh3NaOBxtYhNBoZhYoCXEokK8FsV
         0RVFYwn+G6CLO6UpkueHHNWqMk8EdgrH48vL8l5mpMbsgGAbGmfF1BgPW9GNgzvfal5R
         NLILqNYgTwUAspTKe0uHsWm+GntH5maN0UJt26DZVTs9cUcAz4tx/vU/Wto04M8HEDeY
         7JWiAoUvEOD7/rX0nkKEpteTpenK7e/7wds8G0TkxrS+pR4vq9SAilGVQEmTGVXo3cfm
         L0ClmlZDg2d/ntAB8zejjQAe0kPe7LVPW4E33jgf22stguyx661O63vmI2Yus+8xsgAF
         WEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788434867; x=1789039667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2uZzEoi17n5jSyEBNDhQETxzMK74y33vCW7uiC5o2HE=;
        b=ciOoxuF3QAEDe/foJ3pMw1aj15S9zrtyqMWoCfWGbmKiBsRZUQD/QOqDL++FmnwSzZ
         72Is+uB/b6pO3EZ0xy6wMHjj93XlqP9L83VV/tNKlNx7QE0FKN1S5DKa+mHc5zfoHL+p
         LNKANi9i6emgYiDQFYPXXjIryDmGn1T8zrMAzu/BoqUhp5Xdcnj22ZN+ljr9ACOvE+/k
         u9Jdom+I1beKJJTzbP7m9WEBtpFp9ID0AqxSHjmbm0jC5XI83hY2PyMgX4ZieRLE729z
         NV+0EcEnQ9lSdErGADPLzMrW7hdJudJC5tGTxdYq5iprAzx6LxPSw80lBZf5P0a5n6vB
         XJsA==
X-Forwarded-Encrypted: i=1; AKwUvBwWPGKSZcyCfqKPW6iLKUvcKf3rCQ1q1TZYUrLMX3P7ljeYYQfmBDQBBBayEtYmppz9QCHcmlh1PuZbuYIWmg==@lists.linux.dev
X-Gm-Message-State: AFuF++mEqYfTp2ckPGoSS5WzvNVRngq0GIGS6FO7jr2UvzbTnLoUhjOv
	dwKoArbIJC43YZfoWzbC4cXu26YDLdjWfx9/K6HxquABLnzIP2yXcLRS
X-Gm-Gg: AYBFou2H1IlDD6KAv01Gdx4lVwTmEqe0JOJ1mw4pbd7xRPxUy13KMWvaWn5lESMeA86
	tmjFqj21dMuHy4dPias6lCDhIegW0bdwpeDNf27f5FCKuryLKtC03mBPV6ih8+b/3suSaTRgAQu
	tGih1/MpHW7tA+X5ANEUGClWsRdAviS90hm6S4PoTfnpY0Ehd4GPin4UIG4uc2d7BoaEJiYalZ4
	+XvwC+iltbU1uNIReRS352Sh/2LQ8lsAaMP6SqqdCbpsuRWgX/6IF21JYbQy3NHR3muqEnGRDrj
	OTvnBCvo+a87ilDMwGqiFrnCbE6pqyZ4o+HxnxERJXBYmg4nlyQVENA+yVrneJyHuu8/m2K2VFt
	QsgJ0ubCREnrYEbiwX5Q0j32QxgL0z868Gk1I7gLcyh1TS60oW50/Q5fwyFNFLTXkyw/GBLPM3M
	BpXNa8WJEfxHvXF9QUf2rEDMMNYWT7J0cTBpnwyUGxxlYtqWcAbI6UbY062H5ot+lAKfGjY68Ae
	WLgOjcHElOg/QQEirjab7nQqqe/5aJt2YmoPzuphwGRo0xZaLWBhaOmkN1fxIvfab9o9mo+5ioL
	i1D0GGdXrPh1dfUqU8ah1nAnBJ3HgiDfOhPcwWIIZwtnXUj5p4AVFLLMdBj64yd0nppvo6KJ4Z2
	l
X-Received: by 2002:a05:6000:41cb:b0:484:44ec:2c14 with SMTP id ffacd0b85a97d-48488dece71mr21694820f8f.1.1788434866683;
        Thu, 03 Sep 2026 04:27:46 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448ed30c0sm13509281f8f.24.2026.09.03.04.27.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 04:27:46 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH] softirq: Preserve interrupt context during IRQ exit
Date: Thu,  3 Sep 2026 13:27:37 +0200
Message-Id: <20260903112737.49551-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__irq_exit_rcu() drops HARDIRQ_OFFSET before deferred hrtimer rearm,
softirq dispatch, and timersd wakeup. This work is still on the IRQ
return path, but in_task() reports task context.

Context-sensitive code called from this window therefore sees task
context. ftrace records normal-context flags and selects its normal
recursion slot. KCSAN attributes IRQ-exit accesses to the interrupted
task, while KMSAN can select and modify that task's metadata.

Keep HARDIRQ_OFFSET until the IRQ-exit work is done. For direct softirq
handling, replace it with SOFTIRQ_OFFSET and restore it afterwards. Other
__do_softirq() call paths keep their existing accounting.

With hardirq context retained, ftrace records hardirq context, KCSAN uses
interrupt attribution, and KMSAN no longer uses the interrupted task's
state.

Since softirq eligibility is now tested before HARDIRQ_OFFSET is removed,
use irq_count() == HARDIRQ_OFFSET. This preserves the old !in_interrupt()
semantics, including PREEMPT_RT's task-local softirq-disable state.

Drop HARDIRQ_OFFSET before tick_irq_exit(), as before.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20260813130826.GW687043@noisy.programming.kicks-ass.net
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
I reworked Peter's draft linked above into this version and tested it.

Changes:
- Use in_hardirq() in softirq_handle_begin() instead of ksirqd, since
  __do_softirq() also has task-context callers, including ktimerd.
- Use irq_count() for the eligibility test so PREEMPT_RT's task-local
  BH-disabled state remains part of the decision.

Tested with non-RT, threadirqs and PREEMPT_RT x86-64 QEMU boot/stress.
The QEMU kernels had lockdep and IRQ tracing enabled and reported no new
warnings.

A focused RT test rejected every BH-disabled IRQ-exit observation. The
old-mask negative control admitted every one.

ftrace marked direct IRQ-exit work as hardirq rather than normal context.

A separate A/B changed printk caller attribution from task to CPU,
in_task() from 1 to 0 and interrupt_context_level() from 0 to 2. Fault
injection no longer consumed the interrupted task's fail_nth state.

KCSAN attributed all 16 target reports to interrupt context.

KMSAN did not select or change task state in 64K IRQ-exit windows. All
28 KMSAN KUnit tests passed.

The exact TIP source also passed A/B boot/stress on a Pi 400
(Cortex-A72, arm64).

For additional coverage, the mainline adaptation passed A/B boot/stress
on a Microchip SAM9X75 Curiosity (ARM926EJ-S/ARMv5TEJ).

vmlinux linked successfully for arm64, ARM, RISC-V and s390.

 kernel/softirq.c | 48 ++++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 5d02c36c40e3..63aeaa5f62e9 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -350,8 +350,8 @@ static inline void ksoftirqd_run_end(void)
 	local_irq_enable();
 }
 
-static inline void softirq_handle_begin(void) { }
-static inline void softirq_handle_end(void) { }
+static inline bool softirq_handle_begin(void) { return false; }
+static inline void softirq_handle_end(bool from_hardirq) { }
 
 static inline bool should_wake_ksoftirqd(void)
 {
@@ -481,15 +481,35 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
-static inline void softirq_handle_begin(void)
+static inline bool softirq_handle_begin(void)
 {
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	bool from_hardirq = in_hardirq();
+
+	if (!from_hardirq) {
+		__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+		return false;
+	}
+
+	/* Replace the retained hardirq context with normal softirq context. */
+	__preempt_count_add((int)SOFTIRQ_OFFSET - (int)HARDIRQ_OFFSET);
+	if (softirq_count() == SOFTIRQ_OFFSET)
+		lockdep_softirqs_off(_RET_IP_);
+
+	return true;
 }
 
-static inline void softirq_handle_end(void)
+static inline void softirq_handle_end(bool from_hardirq)
 {
-	__local_bh_enable(SOFTIRQ_OFFSET);
-	WARN_ON_ONCE(in_interrupt());
+	if (!from_hardirq) {
+		__local_bh_enable(SOFTIRQ_OFFSET);
+		WARN_ON_ONCE(in_interrupt());
+		return;
+	}
+
+	if (softirq_count() == SOFTIRQ_OFFSET)
+		lockdep_softirqs_on(_RET_IP_);
+	__preempt_count_sub((int)SOFTIRQ_OFFSET - (int)HARDIRQ_OFFSET);
+	WARN_ON_ONCE(!in_hardirq());
 }
 
 static inline void ksoftirqd_run_begin(void)
@@ -605,6 +625,7 @@ static void handle_softirqs(bool ksirqd)
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
+	bool from_hardirq;
 	bool in_hardirq;
 	__u32 pending;
 	int softirq_bit;
@@ -618,7 +639,7 @@ static void handle_softirqs(bool ksirqd)
 
 	pending = local_softirq_pending();
 
-	softirq_handle_begin();
+	from_hardirq = softirq_handle_begin();
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
 
@@ -670,7 +691,7 @@ restart:
 
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-	softirq_handle_end();
+	softirq_handle_end(from_hardirq);
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -740,6 +761,8 @@ static inline void wake_timersd(void) { }
 
 #endif
 
+#define IRQ_EXIT_TIMERS	(NMI_MASK | HARDIRQ_MASK)
+
 static inline void __irq_exit_rcu(void)
 {
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
@@ -748,8 +771,7 @@ static inline void __irq_exit_rcu(void)
 	lockdep_assert_irqs_disabled();
 #endif
 	account_hardirq_exit(current);
-	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt() && local_softirq_pending()) {
+	if (irq_count() == HARDIRQ_OFFSET && local_softirq_pending()) {
 		/*
 		 * If we left hrtimers unarmed, make sure to arm them now,
 		 * before enabling interrupts to run softirq.
@@ -759,9 +781,11 @@ static inline void __irq_exit_rcu(void)
 	}
 
 	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
-	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
+	    local_timers_pending_force_th() &&
+	    (preempt_count() & IRQ_EXIT_TIMERS) == HARDIRQ_OFFSET)
 		wake_timersd();
 
+	preempt_count_sub(HARDIRQ_OFFSET);
 	tick_irq_exit();
 }
 

base-commit: 2af470916a208b576ac9975d221d9a378cf8ace9
-- 
2.53.0

