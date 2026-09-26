Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7A305683
	for <linux-rt-devel@lists.linux.dev>; Sat, 26 Sep 2026 14:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433314; cv=none; b=PsvWDXCtOeGosOwXgMhQMffl8PY1EROxdhp6WIieONhCspLm1q6r6c2u9YqIWLjoVdVSQZPvjtNAdk6mS94SapIuheLsFB+nWbH43IywsOdCozOlcH3tjXT803kNrDIC7OtKmDU5z1+8ktCgVda7Ez+0lFmy63mkGqAGkAyeOJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433314; c=relaxed/simple;
	bh=JveIdfMnbEYqobIaG4H/0vVCYtVazpDPoziCms40STk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pOexnVA9hm0RxTmu4XFTrgpjYchUgz8zJrB/oLPhF1+++HMsX6yb6ggN9OnQTNHGCaFhu3t99PoYf8WZ5NygBcVxQE/2Dy1n2FXcgaHCCXxrsS8dgo1+PeCtjbGV9ijj8Zo78itHJv0KRS32VaX0U3XTEqUY+CTwRoOzs3dfHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsaxcepZ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsaxcepZ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so1954765e9.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 26 Sep 2026 07:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790433311; x=1791038111; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sRi2uvg9/167pPQxsIteWZThRIVLdNuXQXVpU9sXzLQ=;
        b=VsaxcepZ6wRfVr3L1ikfMY0F6craFLcIDRRhdquKs8SWo8u+5Y2xvVTgjGaezV9q8N
         J9f9sM2KQDNUvG135LV6E5ZxmFIxVovLUqpyIbsypWlwAR52sLNvjYguQH4P93xk/Avd
         1X/qAJPYT1dqZqy6wh2Tx6jbzhXM/9Gs0LbJeeGXOCKE3zUnVXG6x6GRZeWGYM2M7PJ+
         ENXJPFDO8CzDeCyVlihYbP1kvf9TH6VtjfMEzmmgoXR4jVHjdMaRvO6/IbZmI5/Ghckr
         UAVm50GZ7hJ6QI86kDW9BnVVHlEQfj6lfKWBpOUsNUl89/BwIcdGfB3bJi/JM1znIjVy
         WgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790433311; x=1791038111;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sRi2uvg9/167pPQxsIteWZThRIVLdNuXQXVpU9sXzLQ=;
        b=JpQnyRq0Tqdir+R+J2eLREly54qJcgS1VsTybaef++FwZQYwq69Uuk6cPE8uJ+SJ+C
         LuErMxhPLYQE+of9QROeHXNSULwWN+CLJbdzq9LD8XrEmVy5ognpK7YVVO+mNFWk2ZbZ
         uiefvcDS2tQ+zAnaNfVohX6sfjM1fZrSRXPqN3kAP+0fvg45QNb7dPGFSoC4SX8H5N8u
         1T5uymstyeDG2RIfvfqOnHP7seNKkG353Ng5FLAkZPS8oIVCbIanIVjtwGGtgYqbCzxh
         kddtoelVmWSFqQuW/llz/UcfPbkI2lyBq/XcTxqqsWp5Mrt558HRp2EAdJuZrVmJdefo
         0CLQ==
X-Forwarded-Encrypted: i=1; AKwUvBx67kMbI1KOSTd6e31xUG9l39y3ls4le44Sqf9RodMV0uxGI1pxt+Cf/BFlqqfEvu0V2SWpHbMKkM5as3Eu3A==@lists.linux.dev
X-Gm-Message-State: AFuF++mKpL0gdAent5HEr4nEndtUA4CqUTA7v9d/3EjFDayWWlWOK24z
	yR0WcinQA80+nwckwWjyupGUDg/p0HeoqBXE4Q2SM+4eKShAj7DJfpw/
X-Gm-Gg: AYBFou2taUa4DTDVr0e8lM2DycgKWlB9WrjrKFy45HCAtN+/EfC9wkvHoMi06KBcXjv
	jDyXSfngfTvNwZ0F+2OfubkGLNLUSJuKUjxpyxivXCeMaUM7k+8XOtGhAuEeJ8ekSczV2QXqYKh
	1YtH30gMgXSaB5dLuqtg4gXPEglB8PlnjveseOawwOGXG+TKzWrrWIJkJQP/cJJWFcETzdZqYff
	DlGre6Mufm3M3SFCckM+jtOT+sk0PjgZBew+VXZ+0Upz0sIBzKPNBVR7L7SqK4uYI07dmT7n5gR
	LMMv3rxg8h6paV+6a+P5UeDUclz1IL6WSMFCwUx+0PeS/ffdz19XJpAur9L6v8LUW9aXleTGLSJ
	187BgkkGS/a6eWQJcxtm6s/iaY2ShY10t0a8LB24SZqiyI89K+YcABnfK9lEDOgrIlBss3Yj8W1
	qIr+bm9TqtCeI3j9/UnDKfOxzYwfuCDzkDG0gnhUEk/MrcaoVjLy8sTVYE2kCmI20rw+b++dDdU
	9bRJbdCZ5UJ3pNCgFtvho3x02C30qCG7VNQOurDDm/ioGEYO20JN0dQLmnsG73rvOOo3fhVvxS9
	z/vhL4HNlL3B8Ycsc+4zsPgn++6oWjtfePCSFa6zY+FxHp5tNu1KvJ/TOwO0/lFRntpzNh+JNlh
	GxBzrOdwIWKH3
X-Received: by 2002:a05:600c:3107:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49ff06e502dmr96350065e9.16.1790433310920;
        Sat, 26 Sep 2026 07:35:10 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b162-c701-4960-a998-3de8-2fce.310.pool.telefonica.de. [2a02:3100:b162:c701:4960:a998:3de8:2fce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a64ef3asm14533819f8f.30.2026.09.26.07.35.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 07:35:10 -0700 (PDT)
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
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v4] softirq: Preserve interrupt context during IRQ exit
Date: Sat, 26 Sep 2026 16:35:05 +0200
Message-Id: <20260926143505.66024-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the return from interrupt path, __irq_exit_rcu() removes
HARDIRQ_OFFSET from the preemption counter at the very top of the
function. Everything after that reports the current context as task
instead of hard interrupt. The code in the function itself, such as
invoke_softirq(), is aware of this and does not rely on the counter.
Everything else which derives the context from preempt_count gets it
wrong in that window:

  - ftrace, perf and the ring buffer record task context and use the
    task recursion and context slots.
  - KCSAN attributes the accesses to the interrupted task, KMSAN uses
    and changes its state. KCOV and the printk caller id see a task.
  - On PREEMPT_RT can_spin_trylock() and local_trylock() reject hard
    interrupt context to avoid interfering with PI when the interrupted
    task is blocked on a lock. That check does not reject calls made in
    this window. BPF programs attached to sched_waking or sched_wakeup
    can reach it through kmalloc_nolock().
  - An oops kills the interrupted task instead of ending in "Fatal
    exception in interrupt".

Tracing and the sanitizers see the wrong context in this window. No
failure caused by this misclassification is known. The early removal of
HARDIRQ_OFFSET predates git. lockdep is not affected because
lockdep_hardirq_exit() is the last operation in irq_exit().

Keep HARDIRQ_OFFSET until right before tick_irq_exit(), which needs
in_hardirq() to be false for the outermost interrupt. Softirq handlers
must not run with HARDIRQ_OFFSET set, so softirq_handle_begin() replaces
it with SOFTIRQ_OFFSET and softirq_handle_end() reverts that, each in a
single raw preempt_count update. The raw operations keep the preemption
disable location recorded by irq_enter_rcu(), and lockdep is updated by
hand. softirq_handle_begin() detects the case with in_hardirq() because
__do_softirq() is reached through the stack switch in
do_softirq_own_stack() and cannot take an argument.

The checks run before HARDIRQ_OFFSET is removed. !in_interrupt() becomes
irq_count() == HARDIRQ_OFFSET, as in irq_enter_rcu(). The timer thread
check becomes !in_nmi() && hardirq_count() == HARDIRQ_OFFSET. It does
not test softirq_count(): the timer thread must also wake when the
interrupt hit softirq processing or a section with BHs disabled.
A softirq raised in the timer thread wakeup is handled by the timer
thread, which handles all pending softirqs.

A softirq raised from a tracepoint on the final preempt_count_sub()
waits for the next interrupt exit and can trigger NOHZ tick-stop
warnings meanwhile. That is not the normal path and does not justify a
check on every interrupt exit. A tracepoint on tick_irq_exit() already
behaves the same way.

The number of preempt_count updates and the interrupt time accounting
are unchanged. The preemptoff tracer now reports the interrupt and the
softirq processing on top of it as one section, and function graph with
nofuncgraph-irqs also skips the interrupt exit work, including the
__do_softirq() frame.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20260813130826.GW687043@noisy.programming.kicks-ass.net
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
---

Notes:
    Thanks for the review, Sebastian, and for the Reviewed-by, Bradley.
    
    Changes in v4:
    - Drop the ksoftirqd wakeup after the final preempt_count_sub(). A
      tracepoint consumer raising a softirq there is not a path to cater
      for (Sebastian).
    - Reword the first changelog paragraph (Sebastian).
    - Rebase on v7.3-rc4, which contains the prerequisites a155ac8f0c52
      and 2af470916a20. tip/irq/core does not have them yet.
    - Keep the Reviewed-by from v3. The only code change is the removal
      above.
    
    Testing: the v4 code is the v3 code without the trailing check, which is
    the state that ran on the x86-64 and arm64 QEMU matrix, the SAM9X75
    (also RT) and the Raspberry Pi 500+ (also RT) before v3 was posted. The
    Pi 400 ran the variant with the check. On v7.3-rc4, base against v4
    booted and stressed cleanly in QEMU on arm64 (virt, SMP, lockdep) and
    arm32 (versatilepb, lockdep).
    
    v3: https://lore.kernel.org/r/20260924041538.52574-1-kmehltretter@gmail.com
    v2: https://lore.kernel.org/r/20260905023210.82853-1-kmehltretter@gmail.com

 Documentation/core-api/entry.rst | 16 +++++---
 kernel/softirq.c                 | 65 ++++++++++++++++++++++++++------
 2 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
index 79fdaed954d9..ff3df997b151 100644
--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -197,8 +197,9 @@ return true, handles NOHZ tick state and interrupt time accounting. This
 means that up to the point where irq_enter_rcu() is invoked in_hardirq()
 returns false.
 
-irq_exit_rcu() handles interrupt time accounting, undoes the preemption
-count update and eventually handles soft interrupts and NOHZ tick state.
+irq_exit_rcu() handles interrupt time accounting, handles soft interrupts if
+possible, undoes the preemption count update and finally handles the NOHZ tick
+state.
 
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
index 5d02c36c40e3..12e3e4493767 100644
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
@@ -481,15 +481,40 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
-static inline void softirq_handle_begin(void)
+static inline bool softirq_handle_begin(void)
 {
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	bool from_irq_exit = in_hardirq();
+
+	if (!from_irq_exit) {
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
@@ -605,6 +630,7 @@ static void handle_softirqs(bool ksirqd)
 	unsigned long old_flags = current->flags;
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	struct softirq_action *h;
+	bool from_irq_exit;
 	bool in_hardirq;
 	__u32 pending;
 	int softirq_bit;
@@ -618,7 +644,7 @@ static void handle_softirqs(bool ksirqd)
 
 	pending = local_softirq_pending();
 
-	softirq_handle_begin();
+	from_irq_exit = softirq_handle_begin();
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
 
@@ -670,7 +696,7 @@ static void handle_softirqs(bool ksirqd)
 
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-	softirq_handle_end();
+	softirq_handle_end(from_irq_exit);
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -748,8 +774,12 @@ static inline void __irq_exit_rcu(void)
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
@@ -758,10 +788,21 @@ static inline void __irq_exit_rcu(void)
 		invoke_softirq();
 	}
 
+	/*
+	 * Wake the timer thread even if the interrupt hit a softirq or a
+	 * section with BHs disabled. Only nested interrupts and NMIs are
+	 * excluded.
+	 */
 	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
-	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
+	    local_timers_pending_force_th() &&
+	    !in_nmi() && hardirq_count() == HARDIRQ_OFFSET)
 		wake_timersd();
 
+	/*
+	 * tick_irq_exit() relies on in_hardirq() being false for the
+	 * outermost interrupt.
+	 */
+	preempt_count_sub(HARDIRQ_OFFSET);
 	tick_irq_exit();
 }
 

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.39.5 (Apple Git-154)

