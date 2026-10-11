Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EDF340416
	for <linux-rt-devel@lists.linux.dev>; Sun, 11 Oct 2026 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791698883; cv=none; b=I3afis1n3hawLc/sDH5Wm739kp04E0/8FqXjz88jfpWIIVyf80SYcjnstpG9jAuTImucsL/t4v13R5jK0HjWEkTOA8nav1aiaDKRBAP+VRatkg/p2F+rf49MF73RVMOiSOnEh2GSEt/uyue7YhvhAZ8BIKrJ83ws5wxd/fDH0tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791698883; c=relaxed/simple;
	bh=LoQfu2WFhFb7I7CXB6hcrQiqkzCUkLE4CzLYOc1+HTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jX+mHoZe32/GM9V/I/wpB288TnERZueI95dwdrJGxv+90FjtO8gysO9tN8PKHE6aw7tsS639DUbEO0Q2BbGrOHpOTH4r1zi6076qmwe8JoDKduvuauxUKW6C8bTklT2rLkwl0HJcg2ak1N5moLLt4pJMvoOXGEegaVhfh4p3nOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eVMj0IAb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eVMj0IAb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a061a13884so8089985e9.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 10 Oct 2026 23:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791698879; x=1792303679; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wLPfyyzZnXx9ps6Css6vbcFog+sE8xY9CJOiW8YPbMY=;
        b=eVMj0IAbgMIBSxPOIjWz2HSI0Mfcm4KqjsJhXwiEWpkFhIKQd10NBRyvhGZoupp5Bv
         P0MZgzHHh1c0gW+N6JvHkdB/aAG7PcZswzDhXm4+8hSqe0+mo+0oIVDSEt6yLvXO/hO9
         4zuM4Vf8OHBk4GlpoJW7DEpF9fXSW7moz1YtN7EejEXJWscyy3dV8YzlJMc0f3rzcvIh
         uCZwvjToF54unvxHFZ4CD90WzorIOOVS1IrJClnDPNEHurEpZUFpDD/bSeaM46m/1ALD
         ATtAWvZxcMh81kBTbeabCQRnop7C1WT55DAy904k2GS21HkSJatfV840ko0/92ew2+B4
         Folw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791698879; x=1792303679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wLPfyyzZnXx9ps6Css6vbcFog+sE8xY9CJOiW8YPbMY=;
        b=1B+pZna0JySaRD+4zix3qA+Q5Oz90x5jM4gyylzqbNOSXZPuCMR8UbgP80XrRLdDu9
         zi7ewtKIc7Lwly4U8RWavWALgVQ6wWe6HexFoZKVeeen6RKDK0emqHpU02kIt0TtD5rR
         L7mVldtkCNGpn3CfogThnOmuFeWCvR96xOn50LBsdWDXdbp2oBPu/Lzq2MAEQ9Vp2gJZ
         K09Qs2wUbwTwjQVYNItapW2an6qCdWfr0CZkUeuMSXpjmbPZZVcQrsBxmKHCXHt0hk/I
         7F5lbj0atdFHJhF3XlawOvgNJResBzkY+wxf5jvhS0k5Zhx9m4yEWeZzdhXUe0ObYHPu
         +6kA==
X-Forwarded-Encrypted: i=1; AKwUvBwBBUDLCXOHtWAPOORyM5KkCUDj+qFE5cNZrIFXHTqUO4S3PAU3RXXhfSeKq6MY6pxcPiKGq7BnG4+RvvnoAA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKu0i1c0zs9HoNOV2rHPCo9rH4pjGUHwk7hZkwMQlbKUU5sgv/4
	RNsOzF/WrIjirQyGiq854JBZiHr6yTB7wvXapB9W4RE0SLnXsWZZf6/E
X-Gm-Gg: AYBFou0H0VdQQ8koriy4W2jupFgqCJgVl0i9k7Wn9DZlk6v7wQrpIE6Hi7IUYEKQRHC
	M+Sgbu6n2SpL+a/2rtOXN+sAQsfmJE+e7k9DsvR6sLkXIfwfRvCnnhxf7GSpF8JibFg7LBasWkc
	x7J6m3mlP7gXtMsoDZaIRGK74yJuM2PFw1IjSHx8YMt30IFFwgUi0LvtdSOBLP872HXdARPK8dz
	/C10laWVJ31EkvtUhmYy2cZM2nEULbbN6zFA/tpZpDwlGjnGilMeklQUo2N5r8TpPOBjAnF+Wcw
	l3T0DefQTHNmgtpoYWVYwb37x7NG+RGZR8uwAU1aSFpxUoxFhdOjPSF15jqj1riJ97TbzOLNAvu
	Bzxr8OuwpdG5XpLHRDyotoEmLLTCkrt5u61ZsFwmeqzemJyeFlRQ5F/M6AMAhC5yom6xWZ9RTQ1
	KUakxWZ3TNtQ1TleGEPvH7FXtQWFFT4Mc7IhO7zl9Rp0y1IuBoQL0zRBVjcWSKfLZ3aOgdeD3gF
	e6BaW9SbatN1AVorNc/mBVxZRmS7hhjNpithhmd+kUt2a399iKRYeXO0Da0Ek9QM2Z0ddrmN0Ul
	ud/x+f2DAoHUcZjkBkcRYdh57+W4FV+vNQ8mYEuLxinhzc0Ak6QL5qhGRbgrGUuxNsmGlQo9fr0
	/2hvIHIa44vR5
X-Received: by 2002:a05:600c:840c:b0:4a1:8515:2d25 with SMTP id 5b1f17b1804b1-4a18e3e3604mr139433265e9.0.1791698878807;
        Sat, 10 Oct 2026 23:07:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a124-4001-d491-d32f-6b9f-21c5.310.pool.telefonica.de. [2a02:3100:a124:4001:d491:d32f:6b9f:21c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a198b0cfe3sm58764425e9.3.2026.10.10.23.07.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 23:07:58 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Boqun Feng <boqun@kernel.org>,
	Lyude Paul <lyude@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Bradley Morgan <brads@mainlining.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH v6] softirq: Preserve interrupt context during IRQ exit
Date: Sun, 11 Oct 2026 08:07:42 +0200
Message-Id: <20261011060742.30584-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__irq_exit_rcu() removes HARDIRQ_OFFSET from preempt_count() before
the IRQ exit work. On the outermost IRQ exit, with no NMI or softirq
state remaining, this makes context checks report task context. The
softirq-dispatch, timer-wakeup and tick-exit checks account for the early
decrement, but other code reached in this window sees the wrong context:

  - ftrace, perf and the ring buffer record task context and use the
    task recursion and context slots.
  - KCSAN attributes accesses to the interrupted task. KMSAN uses and
    changes the interrupted task's KMSAN context. KCOV and the printk
    caller id see a task.
  - On PREEMPT_RT can_spin_trylock() and local_trylock() reject hard
    interrupt context to avoid interfering with PI when the interrupted
    task is blocked on a lock. Those checks do not reject calls made in
    this window. BPF programs attached to sched_waking or sched_wakeup
    can reach the trylock path through kmalloc_nolock().
  - An oops kills the interrupted task instead of ending in "Fatal
    exception in interrupt".

The early decrement predates git. No failure caused by this
misclassification is known. lockdep is unaffected because
lockdep_hardirq_exit() is the last operation in irq_exit().

Keep HARDIRQ_OFFSET until the end of __irq_exit_rcu(), including
tick_irq_exit(). Softirq handlers must run in BH context, so replace
HARDIRQ_OFFSET with SOFTIRQ_OFFSET while they run and restore it
afterwards. Use one raw counter update for each transition to preserve
the preemption disable location recorded by irq_enter_rcu(), and update
lockdep explicitly. Detect IRQ exit with in_hardirq() in
softirq_handle_begin() because __do_softirq() can be reached through
do_softirq_own_stack() and cannot take an argument.

Adjust the exit checks for HARDIRQ_OFFSET still being present. Use
irq_count() == HARDIRQ_OFFSET for softirq dispatch, as in irq_enter_rcu().
Use hardirq_count() == HARDIRQ_OFFSET for the timer thread wakeup and
tick_irq_exit(). NMI exits use a separate path. An IRQ nested in an NMI
has an extra HARDIRQ_OFFSET from NMI entry, so it is excluded too. The
timer thread check must ignore softirq_count() to allow wakeups when an
IRQ interrupts softirq processing or a BH-disabled section. The timer
thread handles all pending softirqs, including any raised during its
wakeup.

A softirq raised from a tracepoint on the final preempt_count_sub()
waits for the next interrupt exit and can trigger NOHZ tick-stop
warnings. Handling that instrumentation case does not justify a check
on every interrupt exit. A tracepoint on tick_irq_exit() can also raise
a softirq after the normal softirq handling has finished.

The number of counter updates and interrupt time accounting are
unchanged. The preemptoff tracer now reports the interrupt and subsequent
softirq processing as one section. With nofuncgraph-irqs, function graph
tracing also skips the IRQ exit work, including the __do_softirq() frame.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20260813130826.GW687043@noisy.programming.kicks-ass.net
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---

Changes in v6:
- Keep HARDIRQ_OFFSET through tick_irq_exit() and use
  hardirq_count() == HARDIRQ_OFFSET for its nesting check (Frederic).
- Update entry.rst to document NOHZ handling before the final
  preemption-count decrement.
- Test in_hardirq() directly in softirq_handle_begin() (Frederic).
- Drop the in_nmi() test from the timer thread wakeup condition
  (Frederic). NMI entry adds HARDIRQ_OFFSET, so the equality check
  excludes IRQs nested in an NMI.
- Drop the earlier Reviewed-by tags pending reconfirmation of the
  tick_irq_exit() behavior change.

Testing:
QEMU IRQ-exit probes (v5/v6):

                                                        v5          v6
  Tick-exit calls (hardirq/total)                   0/5553   5339/5339
  Tick-exit function-graph records                    5555           0
  KMSAN selections (task/total)             427205/3492324   0/2992433

The two tick-exit rows count tick_nohz_irq_exit(); function-graph
tracing used nofuncgraph-irqs. Captures had timer activity and zero
trace loss.
Each KMSAN kernel passed all 28 KUnit tests; those tests generated all
KMSAN reports.

Additional testing covered 67 guest boots and 10 kernel/softirq.o builds
across five architectures, including RT/non-RT stress, KCOV
configurations and 600-second rcutorture.
The KCSAN probe deliberately triggered reports to check IRQ-exit
context.

Matched configurations of the unpatched base and v6 were compared on
Pi 400, Pi 500+, BeagleV Ahead, AMD/KVM and UP ARMv6 Pi 1B+. Pi 500+ and
AMD tick-exit traces confirmed hardirq context with v6 and zero trace
loss. The NOHZ_FULL tick stopped on both versions on Pi 500+ and BeagleV
Ahead. Pi 1B+ base/v6 workloads completed without reported errors.

On physical SAM9X75 (cpuidle-at91), base/v6 tick-exit traces showed
hardirq flags in 0/556 and 540/540 calls, with 558 and zero
function-graph records under nofuncgraph-irqs. Both kernels showed idle
and Ethernet activity, with zero trace loss.

On Pi 500+, accounted CPU time exceeded wall time under intermittent
workloads on both the unpatched base and v6. No v6-specific regression
was established.

v5: https://lore.kernel.org/r/20260930191432.62760-1-kmehltretter@gmail.com
 Documentation/core-api/entry.rst | 16 +++++----
 kernel/softirq.c                 | 60 +++++++++++++++++++++++++-------
 2 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
index 79fdaed954d9..09942135aad1 100644
--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -197,8 +197,9 @@ return true, handles NOHZ tick state and interrupt time accounting. This
 means that up to the point where irq_enter_rcu() is invoked in_hardirq()
 returns false.
 
-irq_exit_rcu() handles interrupt time accounting, undoes the preemption
-count update and eventually handles soft interrupts and NOHZ tick state.
+irq_exit_rcu() handles interrupt time accounting, handles soft interrupts if
+possible, handles the NOHZ tick state and finally undoes the preemption count
+update.
 
 In theory, the preemption count could be updated in irqentry_enter(). In
 practice, deferring this update to irq_enter_rcu() allows the preemption-count
@@ -207,10 +208,13 @@ irqentry_exit(), which are described in the next paragraph. The only downside
 is that the early entry code up to irq_enter_rcu() must be aware that the
 preemption count has not yet been updated with the HARDIRQ_OFFSET state.
 
-Note that irq_exit_rcu() must remove HARDIRQ_OFFSET from the preemption count
-before it handles soft interrupts, whose handlers must run in BH context rather
-than irq-disabled context. In addition, irqentry_exit() might schedule, which
-also requires that HARDIRQ_OFFSET has been removed from the preemption count.
+Note that soft interrupt handlers must run in BH context rather than in hard
+interrupt context. irq_exit_rcu() therefore replaces HARDIRQ_OFFSET with
+SOFTIRQ_OFFSET in the preemption count while it handles soft interrupts and
+puts HARDIRQ_OFFSET back afterwards, so that the remaining interrupt exit work
+is still attributed to the interrupt. HARDIRQ_OFFSET is removed before
+irq_exit_rcu() returns because irqentry_exit() might schedule, which requires
+that HARDIRQ_OFFSET has been removed from the preemption count.
 
 Even though interrupt handlers are expected to run with local interrupts
 disabled, interrupt nesting is common from an entry/exit perspective. For
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 5d02c36c40e3..be49e6469f3a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -350,8 +350,8 @@ static inline void ksoftirqd_run_end(void)
 	local_irq_enable();
 }
 
-static inline void softirq_handle_begin(void) { }
-static inline void softirq_handle_end(void) { }
+static inline bool softirq_handle_begin(void) { return false; }
+static inline void softirq_handle_end(bool from_irq_exit) { }
 
 static inline bool should_wake_ksoftirqd(void)
 {
@@ -481,15 +481,38 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
-static inline void softirq_handle_begin(void)
+static inline bool softirq_handle_begin(void)
 {
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	if (!in_hardirq()) {
+		__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+		return false;
+	}
+
+	/*
+	 * Only reached from irq_exit(), with HARDIRQ_OFFSET still set.
+	 * Replace it with SOFTIRQ_OFFSET before handle_softirqs() enables
+	 * interrupts. Use the raw operation to preserve the preemption
+	 * disable location recorded by irq_enter_rcu(), and update lockdep
+	 * directly.
+	 */
+	__preempt_count_sub(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
+	lockdep_softirqs_off(_RET_IP_);
+	WARN_ON_ONCE(irq_count() != SOFTIRQ_OFFSET);
+
+	return true;
 }
 
-static inline void softirq_handle_end(void)
+static inline void softirq_handle_end(bool from_irq_exit)
 {
-	__local_bh_enable(SOFTIRQ_OFFSET);
-	WARN_ON_ONCE(in_interrupt());
+	if (!from_irq_exit) {
+		__local_bh_enable(SOFTIRQ_OFFSET);
+		WARN_ON_ONCE(in_interrupt());
+		return;
+	}
+
+	lockdep_softirqs_on(_RET_IP_);
+	__preempt_count_add(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
+	WARN_ON_ONCE(irq_count() != HARDIRQ_OFFSET);
 }
 
 static inline void ksoftirqd_run_begin(void)
@@ -605,6 +628,7 @@ static void handle_softirqs(bool ksirqd)
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
+	bool from_irq_exit;
 	bool in_hardirq;
 	__u32 pending;
 	int softirq_bit;
@@ -618,7 +642,7 @@ static void handle_softirqs(bool ksirqd)
 
 	pending = local_softirq_pending();
 
-	softirq_handle_begin();
+	from_irq_exit = softirq_handle_begin();
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
 
@@ -670,7 +694,7 @@ restart:
 
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-	softirq_handle_end();
+	softirq_handle_end(from_irq_exit);
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -716,7 +740,7 @@ static inline void tick_irq_exit(void)
 
 	/* Make sure that timer wheel updates are propagated */
 	if ((sched_core_idle_cpu(cpu) && !need_resched()) || tick_nohz_full_cpu(cpu)) {
-		if (!in_hardirq())
+		if (hardirq_count() == HARDIRQ_OFFSET)
 			tick_nohz_irq_exit();
 	}
 #endif
@@ -748,8 +772,12 @@ static inline void __irq_exit_rcu(void)
 	lockdep_assert_irqs_disabled();
 #endif
 	account_hardirq_exit(current);
-	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt() && local_softirq_pending()) {
+
+	/*
+	 * HARDIRQ_OFFSET is still set. Only the outermost interrupt handles
+	 * softirqs, and only if it did not hit a softirq or BH disabled section.
+	 */
+	if (irq_count() == HARDIRQ_OFFSET && local_softirq_pending()) {
 		/*
 		 * If we left hrtimers unarmed, make sure to arm them now,
 		 * before enabling interrupts to run softirq.
@@ -758,11 +786,17 @@ static inline void __irq_exit_rcu(void)
 		invoke_softirq();
 	}
 
+	/*
+	 * Wake the timer thread even if the interrupt hit a softirq or a
+	 * section with BHs disabled. Only the outermost interrupt can wake it.
+	 */
 	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
-	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
+	    local_timers_pending_force_th() &&
+	    hardirq_count() == HARDIRQ_OFFSET)
 		wake_timersd();
 
 	tick_irq_exit();
+	preempt_count_sub(HARDIRQ_OFFSET);
 }
 
 /**

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
