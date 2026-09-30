Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FDA3CFF66
	for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790795685; cv=none; b=WwGefUehyWoI1qTkaQT3PNaIijCDgZ+1OZX0HTyJ6GQ2T3Ju2YqRDU+YUFF/PLH8vclvOJkzkr+J95v7+cYVc+QVeZ2nwabTfude9WHWqY/VaXB3kh84hb1F9jbrCkYp/HsZ3s6mtvt6cshU9s+MIiFmAO+IJMjxqhR1LzVYmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790795685; c=relaxed/simple;
	bh=Q2dfVBTA5NMWKcswYwtN7KVP6XuDzsX/wflSVX+jOE0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fQV1V4GKjeeZ1qW+9RB/4WgAt0lKdxX0rzSZShA05e7+wTINU9RRvjrw7ILJI6hGc8vRKDxKW8KkM5GIlGJZefNKG5S2j+vm9EUDtCNSspuOBo19UfSR/cJx03etkkvdxTPhnF2Eq5uH3D/DMtQ+GPJVQES+0okz6KMbcQ5rCvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4MF+q4d; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4MF+q4d"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so35463265e9.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 30 Sep 2026 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790795682; x=1791400482; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3zvnjS+dlt0/FohVtWMLLifkmnbfEBWCuLKr0ZvxY+U=;
        b=h4MF+q4dvx/HxG5frRSNluHwZoj9F3YCorKgEXYwUldfufT7S+B/T/5b2C+ObjutGK
         SiQKzKleljP+UxPYjpWVhDb0pCDaXHOA27FfjpPgLZY/sVv1mjYZYZR5YPybcWmm6fgT
         AuEXmb7Ao0GP5Ivz0g0QAHVt2MAZxSCehT9j1mWYpuVNEf6Pq6YAUjxk4cWb96tLGP++
         o0Zhhf2rsHCK8wGF4WG0cVaN6oQGBHL4lQV+KuyM75b27aC3ebS9XHODRnjiRXPWaDDI
         Kou02rx4NHvP8VA6OvB7rrI7lbqTeekpSax7K3FzmM13LCRY9pg5qRNo/ZdAHIY3n/kz
         nntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790795682; x=1791400482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3zvnjS+dlt0/FohVtWMLLifkmnbfEBWCuLKr0ZvxY+U=;
        b=ICi5UOefc7j8mXM7gbDfzxV91rOpuu2/VHEt8CdAlIukX573u3A4hJT7uNRYMz4wFA
         6FhkUjQVxcqSNxRcCRKiHcMVjZctaAuGTHNPIcTBnDw0Ub70HWy3lcMaPkCqjlpMN7f/
         oYzkYZO/dOW9o5DriR8um2mwz5xA4jG38AxcALEs3tkcvOcTsp9z5KVw33xWpDk9U6AX
         vipnAIPJC5GKbeT8HCFUCNF4Bkfgjr4VMIPZbpAIIyMb3tOvLYH7gnsBRXrYbfOXYCRZ
         uCyG6fKUuadd0ZpEvDiFK9HzIZGf8c2j7Cvr3OwndptGHiiCPdhdoSup23zCgOpCkFNh
         iKIA==
X-Forwarded-Encrypted: i=1; AKwUvBxR8avJQ2EBJzUCMx5EXyktnkZpfSyLN1IZhHyQ44PVpgf64oo4xaK3O6CY/mdz6cZeeVWY4QhPbtiAdM1ZdA==@lists.linux.dev
X-Gm-Message-State: AFuF++kfmPyHdSGocas4NkWB/g6dl5YYqtRYWXeNbcoLFbhpYtLVX9Ah
	z1wLpDP7KeXE+LBQ8XmAprN+Rc4TwsF52BuoeIH8KmuD3FQ2BVPD6fll
X-Gm-Gg: AYBFou3xRrJoZMYWa4nw0tkuDjkvFq9pdwHvEpdlwqOkRb41XbYsCyjDpgklmYUpX/a
	tq6eZEvG8OfF0a2UEvWMq5525pQURYKUpjwrlMVuls7T5spK3XCf6Iy92+wM9jyrNP6EPsL+9Y2
	oUCTh0zkpLnO+Hq/P9Ha1yOEO+MFKoSHpaIy9oGOCkFJUW/KHYspZAaQnbjg2GnoLqIPwfRnzn+
	AkLGhyy/XpGORqsOAN17fhhZS46AqeAMKIovV4QlRaS+BR0ayhRu+LxCoxH5SmHfuy4WM/54Gbu
	6xPNIOLfWFNhmA+XTAgAq0nEcu7nrwCfu0hM5Ka268AFy8ATqoGlZ0ZoI+4kYzU56X0gC+L542m
	wGqzCkyMM4ABR24vl1zxlXKiC62BusfWp+o0DKW91TI/NalyjaP2qg0TN7WGDEOtIDV33Ebs9Ub
	IrYlYq+ZFFH0PgrPEtK6WCZvizeVUic0ZpslB1mE/oytaRrjd3W/J2jGCXq4/S4vXMk1mF/kbxc
	Vr6tPqeHX86lsJzV3MTvN3yDNj2J9jsMQBz8ErOhfXadMHDaoymxlx4UrB/7teE1w000mhUUuaS
	H/eV1OgeidIOL94usj8T2/kXdRTqMmWOlswxOw0th1BdTe0m8PaABM+xu40Rru5DYHDnva1xEjv
	i
X-Received: by 2002:a05:600c:4445:b0:4a0:1b14:e845 with SMTP id 5b1f17b1804b1-4a01b14e85dmr40903785e9.2.1790795681430;
        Wed, 30 Sep 2026 12:14:41 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b2b3-0101-b51c-a607-3dcc-3979.310.pool.telefonica.de. [2a02:3100:b2b3:101:b51c:a607:3dcc:3979])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f9145e6sm4184065e9.5.2026.09.30.12.14.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 30 Sep 2026 12:14:40 -0700 (PDT)
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
Subject: [PATCH v5] softirq: Preserve interrupt context during IRQ exit
Date: Wed, 30 Sep 2026 21:14:32 +0200
Message-Id: <20260930191432.62760-1-kmehltretter@gmail.com>
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
check becomes (in_nmi() | hardirq_count()) == HARDIRQ_OFFSET. It does
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
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Notes:
    Changes in v5:
    - Timer thread wakeup: merge the NMI test into the hardirq test,
      (in_nmi() | hardirq_count()) == HARDIRQ_OFFSET (Sebastian).
    - Add Sebastian's Reviewed-by, given on v4.
    - Rebase on v7.3-rc5. The two touched files are unchanged since rc4.
    
    Testing: v5 differs from v4 by that one expression. Both forms agree
    for all 2^32 preempt_count values and at the real site on every IRQ
    exit in four QEMU boots (arm64, arm32; plain and threadirqs; 1.1M
    evaluations). gcc 15 emits one conditional branch less on x86-64,
    arm64 and arm32; clang 22 on arm64, and 16 bytes less on x86-64. On
    v7.3-rc5, base against v5 in QEMU on arm64 (virt, SMP, lockdep) and
    arm32 (versatilepb, lockdep): boot and stress, nothing on v5 that the
    base does not show.
    
    v4: https://lore.kernel.org/r/20260926143505.66024-1-kmehltretter@gmail.com

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
index 5d02c36c40e3..288e9e37b806 100644
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
+	    (in_nmi() | hardirq_count()) == HARDIRQ_OFFSET)
 		wake_timersd();
 
+	/*
+	 * tick_irq_exit() relies on in_hardirq() being false for the
+	 * outermost interrupt.
+	 */
+	preempt_count_sub(HARDIRQ_OFFSET);
 	tick_irq_exit();
 }
 

base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
-- 
2.39.5 (Apple Git-154)

