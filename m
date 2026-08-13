Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED832BF4B;
	Thu, 13 Aug 2026 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626531; cv=none; b=fx1r4pHxFmkdOsuglYlnkBVRNPM5rM4jnCxAVMKrr4EYxVMPOuYZtj8+v8RRMdaIJ5DnCdgCHoOc+7PW1kGwdEP0qiNWzaCUzErxvGXUvM8iy+UNht2LXJmwvYPXdi2zwRxCJgmj0tyRpvkiCG4URzTdJLGWh4vLNpN18bgDJwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626531; c=relaxed/simple;
	bh=zyipall5psryofndUYAYMZ9w3By8wjXMBswnOeMJe/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BnbgOVS1DsCEnVs2geUP1LH5DGCtOgs2oLLqRdGywD1HEc9fAgVjfjGqQUTxsnfMNFqdLDvNf0/5K+FwXgzEmKFIEWv02KHgtTl+O6dIIEYZKuog+QQq/1B75zkGp6pftjrJe/A1PXOKKNWszQpBuS+AblH3Lfyg8c79Lt6APfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=F9KrB+5X; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="F9KrB+5X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EYqflzaefOmqGMeZ7Ri8GSrPxJnaOwkHPfR5XTKOLJ4=; b=F9KrB+5XUMjEjH0rVkqsS2zmCM
	MLkZqTHLuV4WqG9dyCXOzQ9xlRTP+KdG3ipFyHeS+8P0XCnIrn5XHiDaDxn6/vusuYRKId6dx3IeG
	xKfNdtKVoGvWJ+A7C8M2Sfo1EojE+LcOhMOjpjFUED15k0jTn9IFfCEGy86baMaLJPIw5J05AlMfy
	5NKbTs92Ty+Mo2/Q+UPf4+WUaFAv9Eg0ujc+kjO0nIh1e2QMKoochwSLQT9AIDhuC3s9/GEeC/fzj
	Smesoc2n+/AR0JLWklIcIhVVG1QVtdI0iJRmWqmvF3Fl/z3e/c21PvNPstznYhOaTizzvKvUMVrBf
	vR/Fgp/w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuVAf-00000003cgi-0O9f;
	Thu, 13 Aug 2026 13:08:33 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E7206300382; Thu, 13 Aug 2026 15:08:26 +0200 (CEST)
Date: Thu, 13 Aug 2026 15:08:26 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
	Bradley Morgan <include@grrlz.net>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] hrtimer: Pause KCOV during deferred rearm
Message-ID: <20260813130826.GW687043@noisy.programming.kicks-ass.net>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
 <20260811154111.64669-4-kmehltretter@gmail.com>
 <20260812102100.GF776954@noisy.programming.kicks-ass.net>
 <an1dEVKGlwbusXcS@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an1dEVKGlwbusXcS@gmail.com>

On Thu, Aug 13, 2026 at 07:59:57AM +0200, Karl Mehltretter wrote:
> On Wed, Aug 12, 2026 at 12:21:00PM +0100, Peter Zijlstra wrote:
> > > Deferred hrtimer rearm can run after HARDIRQ_OFFSET is dropped. in_task()
> > > is then true, so KCOV attributes the instrumented timer-reprogramming
> > > subtree to current.
> > 
> > But that is clearly noinstr code; there should be no kcov calls in
> > there.
> > 
> > If kcov is emitted inside noinstr, then kcov is a broken piece of crap
> > and needs to die.
> > 
> > NAK
> 
> Thanks for the review!
> 
> By "instrumented" I meant KCOV-instrumented. The selftest callback comes
> from __hrtimer_rearm_deferred() in ordinary .text, not .noinstr.text.
> 
> On x86, irq_exit_rcu() runs in an instrumentable IDT-entry region.
> __irq_exit_rcu() subtracts hardirq offset before calling

DEFINE_IDTENTRY_IRQ(func)
__visible noinstr void func(regs, error_code)
  run_irq_on_irqstack_cond(__func, regs, vector)
    irq_enter_rcu()
    func
    irq_exit_rcu()

Gah, that is the softirq thing and is indeed just inside the
instrumented code :-( My memory had all the preempt_count fiddling in
the noinst code.

> hrtimer_rearm_deferred(), so check_kcov_mode() sees in_task() and records
> callee coverage for current.
> 
> This is the same class of failure as 477d81a1c47a ("x86/entry: Remove
> unwanted instrumentation in common_interrupt()"). There the hardirq offset
> had not yet been added, here it has already been removed. Its callee
> could be inlined. 

That one was a lot simpler, it really wanted to be noinstr.

> Deferred rearm instead reaches shared hrtimer, tick,
> clockevent and architecture code. Statically excluding the graph
> would be pervasive and also lose coverage from ordinary task context.
> 
> Do you want deferred rearm and its complete call graph converted to
> noinstr, or merely built without KCOV instrumentation?

Bah, so the only reason this one pops is because it is outside of the
softirq code, same for those two wakeups I suppose.

Would something crazy like this work? That closes the holes in the
preempt_count munging around there.

*completely* untested and all that

---
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7980a4a232f9..42a1b24c4a0c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -481,14 +481,14 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
-static inline void softirq_handle_begin(void)
+static inline void softirq_handle_begin(bool ksirqd)
 {
-	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET - (!ksirqd)*HARDIRQ_OFFSET);
 }
 
-static inline void softirq_handle_end(void)
+static inline void softirq_handle_end(bool ksirqd)
 {
-	__local_bh_enable(SOFTIRQ_OFFSET);
+	__local_bh_enable(SOFTIRQ_OFFSET - (!ksirqd)*HARDIRQ_OFFSET);
 	WARN_ON_ONCE(in_interrupt());
 }
 
@@ -618,7 +618,7 @@ static void handle_softirqs(bool ksirqd)
 
 	pending = local_softirq_pending();
 
-	softirq_handle_begin();
+	softirq_handle_begin(ksirqd);
 	in_hardirq = lockdep_softirq_start();
 	account_softirq_enter(current);
 
@@ -670,7 +670,7 @@ static void handle_softirqs(bool ksirqd)
 
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-	softirq_handle_end();
+	softirq_handle_end(ksirqd);
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -740,6 +740,9 @@ static inline void wake_timersd(void) { }
 
 #endif
 
+#define IRQ_EXIT_TIMERS  (NMI_MASK | HARDIRQ_MASK)
+#define IRQ_EXIT_SOFTIRQ (IRQ_EXIT_TIMERS | HARDIRQ_DISABLE_MASK | SOFTIRQ_MASK)
+
 static inline void __irq_exit_rcu(void)
 {
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
@@ -748,7 +751,6 @@ static inline void __irq_exit_rcu(void)
 	lockdep_assert_irqs_disabled();
 #endif
 	account_hardirq_exit(current);
-	preempt_count_sub(HARDIRQ_OFFSET);
 	/*
 	 * Interrupts may happen between hardirq_disable_enter() and
 	 * local_irq_save() in local_interrupt_disable(), if irq_exit() invokes
@@ -757,7 +759,7 @@ static inline void __irq_exit_rcu(void)
 	 * hardirq disabling count is already 1, hence we need to prevent
 	 * invoking softirq when a local_interrupt_disable() is ongoing.
 	 */
-	if (!in_interrupt() && !hardirq_disable_count() &&
+	if ((preempt_count() & IRQ_EXIT_SOFTIRQ) == HARDIRQ_OFFSET &&
 	    local_softirq_pending()) {
 		/*
 		 * If we left hrtimers unarmed, make sure to arm them now,
@@ -768,9 +770,11 @@ static inline void __irq_exit_rcu(void)
 	}
 
 	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
-	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
+	    local_timers_pending_force_th() &&
+	    (preempt_count() & IRQ_EXIT_TIMERS) == HARDIRQ_OFFSET)
 		wake_timersd();
 
+	preempt_count_sub(HARDIRQ_OFFSET);
 	tick_irq_exit();
 }
 
