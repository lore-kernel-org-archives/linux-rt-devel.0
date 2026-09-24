Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1B463B7B
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267726; cv=none; b=R+18E5kdNJbkP5WnyOyqp4yRjCvopPmbKbo48oIFmIyIk0cxOq9gKJeidOQCouLxwf/cbHQwO7ZNGNKEwLZH/12219SHkBWPaeSwVwKg3Xps6XvXQhRoDhi9MbZECJUFltg1bi3VnSTvO2WEIfHv78gRxWw9QhQSD9NPbazLqr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267726; c=relaxed/simple;
	bh=iNbBus2U8ZFYU1VXwPxKX66INGGSt1tx61ILURfxYj8=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=I4JODV/Dvuy1POXW3g6FXZLAI8raSzpDNP2xDJJ6/2UNRG70p+O5IHbFQpwTr/qhFRT9O3wZcemIfpdWc7IXvuXrt8XH2+cw8qKMkkH74ry4ybBdLbHXdYBWbeIVDFwLAMa+A0ZovIoRzJWZYAG7WweTcTyrhiqWrAHZWNtKOS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=hr1WJpk7; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Dh8GAAuS; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="hr1WJpk7";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Dh8GAAuS"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790267678; bh=cF/z0+szAgUkO9TvSE+7Cxq
	bF20dYd3g3xPL7sA9krI=; b=hr1WJpk7icOmBpou61m8nv/jxbyGwztwopBb4dZn9vHVSeZFEb
	doqNJRDkNa/S/sfKlzi1K/iIGec6MF55f57V97aZIuxwDhkSK6Pgei0LeWd36Z0l6zzBUH93Hx6
	dHznPDC7GyJc0L1cD56ovgiMOEllMdkd5eIs9cyM0lIWXCTj7jAqz7LDeKFBc4ctRzw90SXzqnr
	49IYDG99QW5uUFlU0KG9kiLkzYye92gx+VmLRUAhBr/1NAOLLTKjDT7NrEEpWS4HXRXOtRlf7ia
	XuVAJwiQRQur91hltWzCLbo268PFIhzM2nlDKkdHuaFoipY6LRdSDwTpIK9vCH7jtRA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1790267678; bh=cF/z0+szAgUkO9TvSE+7Cxq
	bF20dYd3g3xPL7sA9krI=; b=Dh8GAAuSUcB1A4vUTuGXEMHpR8ZnSsXyjTVHGA/M4ftuLzjRWp
	nCsuqaeNFmUh6snyxpI//EE9NIqgNYL6auDw==;
Date: Thu, 24 Sep 2026 17:34:38 +0100
From: Bradley Morgan <brads@mainlining.org>
To: kmehltretter@gmail.com
CC: bigeasy@linutronix.de, boqun@kernel.org, clrkwllms@kernel.org, corbet@lwn.net,
 elver@google.com, frederic@kernel.org, glider@google.com,
 joelagnelf@nvidia.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 lyude@redhat.com, peterz@infradead.org, rostedt@goodmis.org, tglx@kernel.org
Subject: Re: [PATCH v3] softirq: Preserve interrupt context during IRQ exit
In-Reply-To: <20260924041538.52574-1-kmehltretter@gmail.com>
Message-ID: <706B01DB-E4B8-453C-9265-0B861F649F68@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 24 September 2026 05:15:38 BST, Karl Mehltretter
<kmehltretter@gmail.com> wrote:
>__irq_exit_rcu() removes HARDIRQ_OFFSET first and then runs
>hrtimer_rearm_deferred(), invoke_softirq() and wake_timersd(). This is
>interrupt exit work with interrupts disabled, but preempt_count already
>describes the interrupted task again. Everything which derives the
>context from preempt_count gets it wrong in that window:
>
>  - ftrace, perf and the ring buffer record task context and use the
>    task recursion and context slots.
>  - KCSAN attributes the accesses to the interrupted task, KMSAN uses
>    and changes its state. KCOV and the printk caller id see a task.
>  - On PREEMPT_RT can_spin_trylock() and local_trylock() reject hard
>    interrupt context to avoid interfering with PI when the interrupted
>    task is blocked on a lock. That check does not reject calls made in
>    this window. BPF programs attached to sched_waking or sched_wakeup
>    can reach it through kmalloc_nolock().
>  - An oops kills the interrupted task instead of ending in "Fatal
>    exception in interrupt".
>
>Tracing and the sanitizers see the wrong context in this window. No
>failure caused by this misclassification is known. The early removal of
>HARDIRQ_OFFSET predates git. lockdep is not affected because
>lockdep_hardirq_exit() is the last operation in irq_exit().
>
>Keep HARDIRQ_OFFSET until right before tick_irq_exit(), which needs
>in_hardirq() to be false for the outermost interrupt. Softirq handlers
>must not run with HARDIRQ_OFFSET set, so softirq_handle_begin() replaces
>it with SOFTIRQ_OFFSET and softirq_handle_end() reverts that, each in a
>single raw preempt_count update. The raw operations keep the preemption
>disable location recorded by irq_enter_rcu(), and lockdep is updated by
>hand. softirq_handle_begin() detects the case with
>in_hardirq() because __do_softirq() is reached through the stack switch
>in do_softirq_own_stack() and cannot take an argument.
>
>The checks run before HARDIRQ_OFFSET is removed. !in_interrupt() becomes
>irq_count() == HARDIRQ_OFFSET, as in irq_enter_rcu(). The timer thread
>check becomes !in_nmi() && hardirq_count() == HARDIRQ_OFFSET. It does
>not test softirq_count(): the timer thread must also wake when the
>interrupt hit softirq processing or a section with BHs disabled.
>A softirq raised in the timer thread wakeup is handled by the timer
>thread, which handles all pending softirqs.
>
>A softirq raised in the final preempt_count_sub(), e.g. by a consumer of
>the preempt_enable tracepoint, misses these checks. Wake ksoftirqd for
>it as raise_softirq_irqoff() would. Otherwise it waits for the next
>interrupt exit and a cpuidle driver reports it as pending at idle entry.
>
>The number of preempt_count updates and the interrupt time accounting
>are unchanged. The preemptoff tracer now reports the interrupt and the
>softirq processing on top of it as one section, and function graph with
>nofuncgraph-irqs also skips the interrupt exit work, including the
>__do_softirq() frame.
>
>Suggested-by: Peter Zijlstra <peterz@infradead.org>
>Link: https://lore.kernel.org/r/20260813130826.GW687043@noisy.programming.kicks-ass.net
>Assisted-by: LLM
>Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>---
>
>Notes:
>    Thanks for the review, Sebastian.
>    
>    v3 also adds a pending softirq check after the final
>    preempt_count_sub(). A preempt_enable tracepoint callback can raise a
>    softirq there, after the softirq and timer thread checks. With an RCU
>    reader in that callback I saw 10 NOHZ tick-stop warnings per boot in
>    QEMU without the new check, and none on the base kernel or with the
>    check. The check wakes ksoftirqd for newly pending softirqs. Does this
>    case justify the extra check on every IRQ exit?
>    
>    Changes in v3:
>    - Operands swapped, no casts, one irq_count() check per direction,
>      lockdep_softirqs_off() before it (Sebastian).
>    - Timer thread check without IRQ_EXIT_TIMERS, order of the exit work
>      kept (Sebastian).
>    - from_hardirq renamed to from_irq_exit, comment as Sebastian suggested.
>    - ksoftirqd wakeup for a softirq raised in the final
>      preempt_count_sub(), see above.
>    - Documentation/core-api/entry.rst updated.
>    - Rebased on tip/master c81f6d2398d0.
>    
>    I am not proposing this for stable.
>    
>    Testing: base against v3 in QEMU on x86-64 in separate configurations
>    (non-RT, threadirqs, RT, KCSAN, KMSAN, rcutorture), on arm32, arm64,
>    ppc64, s390x, parisc, sparc64, riscv64, loongarch64 and m68k, and on a
>    SAM9X75 (also RT), a Raspberry Pi 500+ and a Raspberry Pi 400. No
>    regressions observed in these runs.
>    
>    v2: https://lore.kernel.org/r/20260905023210.82853-1-kmehltretter@gmail.com
>
> Documentation/core-api/entry.rst | 16 ++++---
> kernel/softirq.c                 | 79 +++++++++++++++++++++++++++-----
> 2 files changed, 77 insertions(+), 18 deletions(-)
>
>diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
>index 79fdaed954d9d..ff3df997b151f 100644
>--- a/Documentation/core-api/entry.rst
>+++ b/Documentation/core-api/entry.rst
>@@ -197,8 +197,9 @@ return true, handles NOHZ tick state and interrupt time accounting. This
> means that up to the point where irq_enter_rcu() is invoked in_hardirq()
> returns false.
> 
>-irq_exit_rcu() handles interrupt time accounting, undoes the preemption
>-count update and eventually handles soft interrupts and NOHZ tick state.
>+irq_exit_rcu() handles interrupt time accounting, handles soft interrupts if
>+possible, undoes the preemption count update and finally handles the NOHZ tick
>+state.
> 
> In theory, the preemption count could be updated in irqentry_enter(). In
> practice, deferring this update to irq_enter_rcu() allows the
> preemption-count
>@@ -207,10 +208,13 @@ irqentry_exit(), which are described in the next paragraph. The only downside
> is that the early entry code up to irq_enter_rcu() must be aware that the
> preemption count has not yet been updated with the HARDIRQ_OFFSET state.
> 
>-Note that irq_exit_rcu() must remove HARDIRQ_OFFSET from the preemption count
>-before it handles soft interrupts, whose handlers must run in BH context rather
>-than irq-disabled context. In addition, irqentry_exit() might schedule, which
>-also requires that HARDIRQ_OFFSET has been removed from the preemption count.
>+Note that soft interrupt handlers must run in BH context rather than in hard
>+interrupt context. irq_exit_rcu() therefore replaces HARDIRQ_OFFSET with
>+SOFTIRQ_OFFSET in the preemption count while it handles soft interrupts and
>+puts HARDIRQ_OFFSET back afterwards, so that the remaining interrupt exit work
>+is still attributed to the interrupt. HARDIRQ_OFFSET is removed before
>+irq_exit_rcu() returns because irqentry_exit() might schedule, which requires
>+that HARDIRQ_OFFSET has been removed from the preemption count.
> 
> Even though interrupt handlers are expected to run with local interrupts
> disabled, interrupt nesting is common from an entry/exit perspective. For
>diff --git a/kernel/softirq.c b/kernel/softirq.c
>index c3729c5b284b0..efa6707edc0e9 100644
>--- a/kernel/softirq.c
>+++ b/kernel/softirq.c
>@@ -350,8 +350,8 @@ static inline void ksoftirqd_run_end(void)
> 	local_irq_enable();
> }
> 
>-static inline void softirq_handle_begin(void) { }
>-static inline void softirq_handle_end(void) { }
>+static inline bool softirq_handle_begin(void) { return false; }
>+static inline void softirq_handle_end(bool from_irq_exit) { }
> 
> static inline bool should_wake_ksoftirqd(void)
> {
>@@ -481,15 +481,40 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
> }
> EXPORT_SYMBOL(__local_bh_enable_ip);
> 
>-static inline void softirq_handle_begin(void)
>+static inline bool softirq_handle_begin(void)
> {
>-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
>+	bool from_irq_exit = in_hardirq();
>+
>+	if (!from_irq_exit) {
>+		__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
>+		return false;
>+	}
>+
>+	/*
>+	 * Only reached from irq_exit(), with HARDIRQ_OFFSET still set.
>+	 * Replace it with SOFTIRQ_OFFSET before handle_softirqs() enables
>+	 * interrupts. Use the raw operation to preserve the preemption
>+	 * disable location recorded by irq_enter_rcu(), and update lockdep
>+	 * directly.
>+	 */
>+	__preempt_count_sub(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
>+	lockdep_softirqs_off(_RET_IP_);
>+	WARN_ON_ONCE(irq_count() != SOFTIRQ_OFFSET);
>+
>+	return true;
> }
> 
>-static inline void softirq_handle_end(void)
>+static inline void softirq_handle_end(bool from_irq_exit)
> {
>-	__local_bh_enable(SOFTIRQ_OFFSET);
>-	WARN_ON_ONCE(in_interrupt());
>+	if (!from_irq_exit) {
>+		__local_bh_enable(SOFTIRQ_OFFSET);
>+		WARN_ON_ONCE(in_interrupt());
>+		return;
>+	}
>+
>+	lockdep_softirqs_on(_RET_IP_);
>+	__preempt_count_add(HARDIRQ_OFFSET - SOFTIRQ_OFFSET);
>+	WARN_ON_ONCE(irq_count() != HARDIRQ_OFFSET);
> }
> 
> static inline void ksoftirqd_run_begin(void)
>@@ -605,6 +630,7 @@ static void handle_softirqs(bool ksirqd)
> 	unsigned long old_flags = current->flags;
> 	int max_restart = MAX_SOFTIRQ_RESTART;
> 	struct softirq_action *h;
>+	bool from_irq_exit;
> 	bool in_hardirq;
> 	__u32 pending;
> 	int softirq_bit;
>@@ -618,7 +644,7 @@ static void handle_softirqs(bool ksirqd)
> 
> 	pending = local_softirq_pending();
> 
>-	softirq_handle_begin();
>+	from_irq_exit = softirq_handle_begin();
> 	in_hardirq = lockdep_softirq_start();
> 	account_softirq_enter(current);
> 
>@@ -670,7 +696,7 @@ static void handle_softirqs(bool ksirqd)
> 
> 	account_softirq_exit(current);
> 	lockdep_softirq_end(in_hardirq);
>-	softirq_handle_end();
>+	softirq_handle_end(from_irq_exit);
> 	current_restore_flags(old_flags, PF_MEMALLOC);
> }
> 
>@@ -742,14 +768,20 @@ static inline void wake_timersd(void) { }
> 
> static inline void __irq_exit_rcu(void)
> {
>+	u32 pending;
>+
> #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
> 	local_irq_disable();
> #else
> 	lockdep_assert_irqs_disabled();
> #endif
> 	account_hardirq_exit(current);
>-	preempt_count_sub(HARDIRQ_OFFSET);
>-	if (!in_interrupt() && local_softirq_pending()) {
>+
>+	/*
>+	 * HARDIRQ_OFFSET is still set. Only the outermost interrupt handles
>+	 * softirqs, and only if it did not hit a softirq or BH disabled section.
>+	 */
>+	if (irq_count() == HARDIRQ_OFFSET && local_softirq_pending()) {
> 		/*
> 		 * If we left hrtimers unarmed, make sure to arm them now,
> 		 * before enabling interrupts to run softirq.
>@@ -758,10 +790,33 @@ static inline void __irq_exit_rcu(void)
> 		invoke_softirq();
> 	}
> 
>+	/*
>+	 * Wake the timer thread even if the interrupt hit a softirq or a
>+	 * section with BHs disabled. Only nested interrupts and NMIs are
>+	 * excluded.
>+	 */
> 	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
>-	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
>+	    local_timers_pending_force_th() &&
>+	    !in_nmi() && hardirq_count() == HARDIRQ_OFFSET)
> 		wake_timersd();
> 
>+	pending = local_softirq_pending();
>+
>+	/*
>+	 * tick_irq_exit() relies on in_hardirq() being false for the
>+	 * outermost interrupt.
>+	 */
>+	preempt_count_sub(HARDIRQ_OFFSET);
>+
>+	/*
>+	 * A softirq raised in preempt_count_sub(), e.g. by a tracepoint,
>+	 * missed the checks above. Wake ksoftirqd as raise_softirq_irqoff()
>+	 * would have done.
>+	 */
>+	if (unlikely(local_softirq_pending() & ~pending) && !in_interrupt() &&
>+	    should_wake_ksoftirqd())
>+		wakeup_softirqd();
>+
> 	tick_irq_exit();
> }
> 
>
>base-commit: c81f6d2398d063009cc9ad2c98f126daaa7669e2
>
Nice! LGTM, thanks

Reviewed-by: Bradley Morgan <brads@mainlining.org>


(Note this review is done by correctness!)
--- Thanks!
"I'm not a very positive person" - Linus torvalds
