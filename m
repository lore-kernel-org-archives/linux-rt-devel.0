Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32283093DB
	for <linux-rt-devel@lists.linux.dev>; Mon, 17 Aug 2026 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786931025; cv=none; b=LwrRLyoNodm3q0mqLqo+9Bk43+k5SLpklJASLYxmkueuE7m3ETZyeGL72Jp7fChyI8hL0zqp77GxrV/UZkt5D6f1w7GEz0EuKKiF1wPul3lmuBZ2+3hpknYP4X4vZqai+fnSHtAJnPi5/7yRjLq1FnV8IpH2wkfFabGHhg2b5YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786931025; c=relaxed/simple;
	bh=KTF4SbsujXMW774XFidlx28bgRQdG/juW8w2xk4oqNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hSby6cw3z3BkhLQevU1MBiVfWNXIHUFsVJBm8oX+MpNjCi4kPd8sABSAxorOl4I+SzDha9Hj7bxGLqYyT5SNJ9JNZNKk4TNWa1BRHYk9OFFNezhdVFdl+y0YRGuVXY+dlUqIX6SIM08ZCVe516nssnqKzy7EW8aprP5Xvd71ZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qL5WLC8V; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qL5WLC8V"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-476a130c138so3004111f8f.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 16 Aug 2026 18:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786931022; x=1787535822; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GNT8LbyIlLO1KA9N3Ppnv86v2THDT/5d+bmEcq3CPJY=;
        b=qL5WLC8VLjyCtZgNQbmi+iPik4BLFwx2+jds6s/YKT7Ca8jvgyxgBGey9nLYbvgphh
         f6MURNWhGgIjxcLIfA5evBcIBWtmTIqdmG1GHRc6vTuD7XXnSOVo9ey0RukB9ZCmmpw8
         ENQvRC3Ak54hl1u4NFh9Y6LQt20ZsfTxEPg9EVhtV8CMtqQKhNH7dkx5whV2X3aZHdej
         2766XFNR/vFyQMyH2GgWSXzMP9IupTVVQVZhYA4EXr3YhDhLMF0oyhYXmoOBbVjufomw
         2hRufP0jNvtyzosKa0bjr8Q4mIdNh5L/+XWo3jKtT2H1uw5C1MnryVVaZnguwhStoj1F
         rzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786931022; x=1787535822;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GNT8LbyIlLO1KA9N3Ppnv86v2THDT/5d+bmEcq3CPJY=;
        b=gWrZNFEMjZGnmXlvwUdKYTOIU/ij2s+yhrzzRbBsuvOcucLGHgLAo6R8nKhzTi6RM3
         eTef1+oe0+p4u252qF57hwN9GvYNu7mXBgiHdWusPuKubpavBrd+Cyp6VKyu3chFesAx
         +oERh+nU+Q+hs4DCJyDyuobaFv3vLfiN7Oo/4pk0DGEFbw2URzcbqs+EIoXDGCvOCx8X
         1wYN7Xcxe8l5p4hSPMW7Jq8dpiFK/KHVXZPwWOsWTxmHDheoVWgoGlm3UYNJCG5uzREg
         p/f9nArng76UaHjEuMvs3A3yFbvNM7/UcFDGURNAGCZPVff9w3hMB5xfCK2L7Z8Zbv04
         wlRg==
X-Forwarded-Encrypted: i=1; AHgh+RqYAQubjWBHVvhbxwqCLJs61CVSV/2Ir1hH9vZGdEkZ28hrORpRjpXYbcUkMwH5DjoHxKLakbWOPS1Gn+oF0Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YznE8hAToVIuZtLEDiXIsYT7E8x9KaQV6Qh4jAj2A77ZSdobpxe
	bVXBGZn4iG2LuZn/umyt6vmcBuyxZVD2kIKYIFijYbLZnD+SjmZM6KSJ
X-Gm-Gg: AR+sD12mSk/1a3sRslChmd630I8GB4i+eKJuEIoKh7XbdDiPX/oQ7KxZ0bcYCKxS27/
	BHsA97SZ0upZWbHfsAP9+ci7MP26eUn/w0cVv0jiDZpJUet7p0YNYWolfZ/cCr5+YYVsm27BNIX
	ButZbz1phQLy5IWkIuzwbmYxrO5RRsxYWOzTJFRXXEneRB9P47c5RicxAENP2NtFppqZKl6+QK6
	JAnXJKSNsqZ6w3zwjki5+Yyw7t5FkhOeCiNds8N6LLVEZpqaHdw+86poATViG9uLXpMQVobvRlm
	AKYnwBcQyCfiq3UcR08e/D3cJmEHKe9Yf5iLurEYtATHdzPKrzBCubt3MJy/9eC7YlUoLJRbMp3
	9qPFi6v6B8CsIAUDZIV05IZAoaFPfE0Q7AhGTRrDzb6i5ko8mD24u5y3G93p1pGq08aIMbPceAM
	y4QWnoqJ1mv3jNtUx263g1YKjRNKwa3fZhzovZoQKSoMA3oz7glwQU4h/PicepqUf4o0SAuEfif
	S2uYFgBKPLB1gCyjWI78YJVQAJN2cqWjuO56NmMEfd/3zEDqioiZmsSJ3WJkB0UkKM7n0yd01kY
	PGiLbRP4noMvd9vDgjUSZGxO1e6U96VJsu2TnO/K33QTPazdhmkL4/565Ss+lVqOLe5vBA==
X-Received: by 2002:a05:6000:29cc:b0:47f:773f:2d68 with SMTP id ffacd0b85a97d-48160738c19mr25865875f8f.16.1786931021932;
        Sun, 16 Aug 2026 18:43:41 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-9dc5-9401-09c8-a88d-e919-d148.310.pool.telefonica.de. [2a02:3100:9dc5:9401:9c8:a88d:e919:d148])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4815f2c18cbsm24837588f8f.29.2026.08.16.18.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 18:43:41 -0700 (PDT)
Date: Mon, 17 Aug 2026 03:43:39 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Alexander Potapenko <glider@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>, 
	Bradley Morgan <include@grrlz.net>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] hrtimer: Pause KCOV during deferred rearm
Message-ID: <aoJltY3whwRjbmFW@gmail.com>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
 <20260811154111.64669-4-kmehltretter@gmail.com>
 <20260812102100.GF776954@noisy.programming.kicks-ass.net>
 <an1dEVKGlwbusXcS@gmail.com>
 <20260813130826.GW687043@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813130826.GW687043@noisy.programming.kicks-ass.net>

On Thu, Aug 13, 2026 at 03:08:26PM +0100, Peter Zijlstra wrote:
> Bah, so the only reason this one pops is because it is outside of the
> softirq code, same for those two wakeups I suppose.
> 
> Would something crazy like this work? That closes the holes in the
> preempt_count munging around there.
> 
> *completely* untested and all that
> 

Thanks, I tested this.

The idea helps, but the ksirqd check is not enough.

__do_softirq() also runs from task context and ktimerd with ksirqd=false.
Subtracting HARDIRQ_OFFSET there corrupts preempt_count.

In the direct IRQ-exit path, __local_bh_disable_ip() also warns because
HARDIRQ_OFFSET is still set.

My version below checks in_hardirq() in handle_softirqs(). For direct
IRQ-exit dispatch it replaces HARDIRQ_OFFSET with SOFTIRQ_OFFSET, then
restores it.

Other callers keep the normal local-BH accounting. tick_irq_exit() still
runs after HARDIRQ_OFFSET is dropped.

In a 400-round KCOV test, flaky PCs fell from 140 to 129. The average
trace size fell from 147.7 to 141.6 PCs. But measured syzcaller coverage
did not improve significantly.

I also ran a targeted KCSAN test that intentionally produced 58
reports on each kernel. Baseline classified all IRQ-exit accesses as
"by task". With this patch, all were "by interrupt". Both passed the
KCSAN selftest. Lockdep and IRQ-tracing boots also passed.

This patch does not replace the KCOV pause series. It only covers work
dispatched directly from IRQ exit. Deferred rearm outside this path
and task-context scheduler leaks remain.

Karl

---
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 7980a4a232f..d6be8ca2793 100644
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
 
@@ -670,7 +691,7 @@ static void handle_softirqs(bool ksirqd)
 
 	account_softirq_exit(current);
 	lockdep_softirq_end(in_hardirq);
-	softirq_handle_end();
+	softirq_handle_end(from_hardirq);
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
@@ -740,6 +761,9 @@ static inline void wake_timersd(void) { }
 
 #endif
 
+#define IRQ_EXIT_TIMERS	(NMI_MASK | HARDIRQ_MASK)
+#define IRQ_EXIT_SOFTIRQ	(IRQ_EXIT_TIMERS | HARDIRQ_DISABLE_MASK | SOFTIRQ_MASK)
+
 static inline void __irq_exit_rcu(void)
 {
 #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
@@ -748,7 +772,6 @@ static inline void __irq_exit_rcu(void)
 	lockdep_assert_irqs_disabled();
 #endif
 	account_hardirq_exit(current);
-	preempt_count_sub(HARDIRQ_OFFSET);
 	/*
 	 * Interrupts may happen between hardirq_disable_enter() and
 	 * local_irq_save() in local_interrupt_disable(), if irq_exit() invokes
@@ -757,7 +780,7 @@ static inline void __irq_exit_rcu(void)
 	 * hardirq disabling count is already 1, hence we need to prevent
 	 * invoking softirq when a local_interrupt_disable() is ongoing.
 	 */
-	if (!in_interrupt() && !hardirq_disable_count() &&
+	if ((preempt_count() & IRQ_EXIT_SOFTIRQ) == HARDIRQ_OFFSET &&
 	    local_softirq_pending()) {
 		/*
 		 * If we left hrtimers unarmed, make sure to arm them now,
@@ -768,9 +791,11 @@ static inline void __irq_exit_rcu(void)
 	}
 
 	if (IS_ENABLED(CONFIG_IRQ_FORCED_THREADING) && force_irqthreads() &&
-	    local_timers_pending_force_th() && !(in_nmi() | in_hardirq()))
+	    local_timers_pending_force_th() &&
+	    (preempt_count() & IRQ_EXIT_TIMERS) == HARDIRQ_OFFSET)
 		wake_timersd();
 
+	preempt_count_sub(HARDIRQ_OFFSET);
 	tick_irq_exit();
 }
 
