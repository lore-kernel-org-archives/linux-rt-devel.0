Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4981FF7D2
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Dec 2024 11:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733484876; cv=none; b=LH6sq7Cstk4311kiDvWgtyOZ/2RdEPKtGJooUhZzoMNrM6s8n6VIOVekCEdMXXxJ3xGgCXLrqqxeBogHcGFzMARcgiKl08vgQ20KzmfKsMrBVFsmmvyupqdEj9tKueoTv41X/8ohh0dhImOCbNbImpATILRstZO+EzZDXWEtZ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733484876; c=relaxed/simple;
	bh=mGgCXvquxk1TQ2QTxP4XgQrU5XNuEcIZhaifQ6gGMcY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a9HcXDzKDAYANDv0FyQioHIKUUObvAE0xpmwZSVm8Y+aMw6Uq+2EVZJIAAaX6sBNsR2dWNfBWVvutTACGYbJ2LBMtv7Nj6sE0p4B9ckPcStJoKX9ksZi4wPc3XLVYuqwpm5iwzc/fwKZsig/6UdEheyWbrm0PlHzjKVVmrRZRKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hcsrV7nh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ukSv9X4o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hcsrV7nh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ukSv9X4o"
Date: Fri, 6 Dec 2024 12:34:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733484872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TVG0MNLdzcFbxnVEVl/LMDFRgZ/xtiH891JiT1QECtU=;
	b=hcsrV7nh/IS7hjqisf2KeDZsHzfsT9wuvcZPcSYq7ZFO4S5HS6ZfGP4WQLEWptDIkcrB6R
	Dns6CgjCwLCXpQRxAjYTEU0OMK3iJFigI9vWYNDUSEGbC+JHqs9lDxMA85J2WdUmRcYUDa
	xeVAuMPmEmanTuXy7DuWK1sgT6i191HzKXiouevnKjS4xRInnFSvrKA+Iq9LbkA69H2+GU
	mU0Hb1o5iueZAsCEkjnCFM86NS8mvbCCqSu7Njt8XrR+CpwPhCW8glinXG4FtnS18eOQAQ
	dWOkNlvar/ocS/w1uTOQz4b6beDrLYg5eF8B8oHb0+bXXMr36Hh9Zy4+BVXJXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733484872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=TVG0MNLdzcFbxnVEVl/LMDFRgZ/xtiH891JiT1QECtU=;
	b=ukSv9X4oRsdKfTdSyjFgu9PQAoo1/p7ULfOBcnPV4arjmooTi0mjXfHsqD9X0K2IJcILTk
	2ZoZz7e4QZZIlwBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Ben Segall <bsegall@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Mel Gorman <mgorman@suse.de>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Will Deacon <will@kernel.org>, x86@kernel.org
Subject: [RFC PATCH] preempt: Add a generic function to return the preemption
 string.
Message-ID: <20241206113431.Q-VXMlru@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The individual architectures often add the preemption model to the begin
of the backtrace. This is the case on X86 or ARM64 for the "die" case
but not for regular warning. With the addition of DYNAMIC_PREEMPT for
PREEMPT_RT we end up with CONFIG_PREEMPT and CONFIG_PREEMPT_RT set
simultaneously. That means that everyone who tried to add that piece of
information gets it wrong for PREEMPT_RT because PREEMPT is checked
first.
This is an attempt to cover all users that I identified so far with a
generic function provided by the scheduler. While at it, extend it with
the LAZY information and add it to dump_stack_print_info().

Comments?

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/kernel/traps.c      | 11 ++---------
 arch/arm64/kernel/traps.c    | 12 ++----------
 arch/powerpc/kernel/traps.c  |  4 ++--
 arch/s390/kernel/dumpstack.c |  9 ++-------
 arch/x86/kernel/dumpstack.c  |  7 +------
 arch/xtensa/kernel/traps.c   |  6 +-----
 include/linux/preempt.h      |  2 ++
 kernel/sched/core.c          | 24 ++++++++++++++++++++++++
 kernel/trace/trace.c         |  6 +-----
 lib/dump_stack.c             |  4 ++--
 10 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 6ea645939573f..1254992184d2e 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -258,13 +258,6 @@ void show_stack(struct task_struct *tsk, unsigned long *sp, const char *loglvl)
 	barrier();
 }
 
-#ifdef CONFIG_PREEMPT
-#define S_PREEMPT " PREEMPT"
-#elif defined(CONFIG_PREEMPT_RT)
-#define S_PREEMPT " PREEMPT_RT"
-#else
-#define S_PREEMPT ""
-#endif
 #ifdef CONFIG_SMP
 #define S_SMP " SMP"
 #else
@@ -282,8 +275,8 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	static int die_counter;
 	int ret;
 
-	pr_emerg("Internal error: %s: %x [#%d]" S_PREEMPT S_SMP S_ISA "\n",
-	         str, err, ++die_counter);
+	pr_emerg("Internal error: %s: %x [#%d] %s" S_SMP S_ISA "\n",
+		 str, err, ++die_counter, preempt_model_str());
 
 	/* trap and error numbers are mostly meaningless on ARM */
 	ret = notify_die(DIE_OOPS, str, regs, err, tsk->thread.trap_no, SIGSEGV);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 4e26bd356a482..0b6f92fcdb304 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -172,14 +172,6 @@ static void dump_kernel_instr(const char *lvl, struct pt_regs *regs)
 	printk("%sCode: %s\n", lvl, str);
 }
 
-#ifdef CONFIG_PREEMPT
-#define S_PREEMPT " PREEMPT"
-#elif defined(CONFIG_PREEMPT_RT)
-#define S_PREEMPT " PREEMPT_RT"
-#else
-#define S_PREEMPT ""
-#endif
-
 #define S_SMP " SMP"
 
 static int __die(const char *str, long err, struct pt_regs *regs)
@@ -187,8 +179,8 @@ static int __die(const char *str, long err, struct pt_regs *regs)
 	static int die_counter;
 	int ret;
 
-	pr_emerg("Internal error: %s: %016lx [#%d]" S_PREEMPT S_SMP "\n",
-		 str, err, ++die_counter);
+	pr_emerg("Internal error: %s: %016lx [#%d] %s" S_SMP "\n",
+		 str, err, ++die_counter, preempt_model_str());
 
 	/* trap and error numbers are mostly meaningless on ARM */
 	ret = notify_die(DIE_OOPS, str, regs, err, 0, SIGSEGV);
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index edf5cabe5dfdb..d6d77d92b3358 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -263,10 +263,10 @@ static int __die(const char *str, struct pt_regs *regs, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 
-	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
+	printk("%s PAGE_SIZE=%luK%s %s %s%s%s%s %s\n",
 	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
 	       PAGE_SIZE / 1024, get_mmu_str(),
-	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
+	       preempt_model_str(),
 	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
 	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
 	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 1ecd0580561f6..7930fbab69dbb 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -198,13 +198,8 @@ void __noreturn die(struct pt_regs *regs, const char *str)
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
-	printk("%s: %04x ilc:%d [#%d] ", str, regs->int_code & 0xffff,
-	       regs->int_code >> 17, ++die_counter);
-#ifdef CONFIG_PREEMPT
-	pr_cont("PREEMPT ");
-#elif defined(CONFIG_PREEMPT_RT)
-	pr_cont("PREEMPT_RT ");
-#endif
+	printk("%s: %04x ilc:%d [#%d] %s", str, regs->int_code & 0xffff,
+	       regs->int_code >> 17, ++die_counter, preempt_model_str());
 	pr_cont("SMP ");
 	if (debug_pagealloc_enabled())
 		pr_cont("DEBUG_PAGEALLOC");
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index a7d562697e50e..064b23a93c6fe 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -395,18 +395,13 @@ NOKPROBE_SYMBOL(oops_end);
 
 static void __die_header(const char *str, struct pt_regs *regs, long err)
 {
-	const char *pr = "";
-
 	/* Save the regs of the first oops for the executive summary later. */
 	if (!die_counter)
 		exec_summary_regs = *regs;
 
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
-
 	printk(KERN_DEFAULT
 	       "Oops: %s: %04lx [#%d]%s%s%s%s%s\n", str, err & 0xffff,
-	       ++die_counter, pr,
+	       ++die_counter, preempt_model_str(),
 	       IS_ENABLED(CONFIG_SMP)     ? " SMP"             : "",
 	       debug_pagealloc_enabled()  ? " DEBUG_PAGEALLOC" : "",
 	       IS_ENABLED(CONFIG_KASAN)   ? " KASAN"           : "",
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 38092d21acf8e..0edba7d8df8c7 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -629,15 +629,11 @@ DEFINE_SPINLOCK(die_lock);
 void __noreturn die(const char * str, struct pt_regs * regs, long err)
 {
 	static int die_counter;
-	const char *pr = "";
-
-	if (IS_ENABLED(CONFIG_PREEMPTION))
-		pr = IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : " PREEMPT";
 
 	console_verbose();
 	spin_lock_irq(&die_lock);
 
-	pr_info("%s: sig: %ld [#%d]%s\n", str, err, ++die_counter, pr);
+	pr_info("%s: sig: %ld [#%d]%s\n", str, err, ++die_counter, preempt_model_str());
 	show_regs(regs);
 	if (!user_mode(regs))
 		show_stack(NULL, (unsigned long *)regs->areg[1], KERN_INFO);
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index ca86235ac15c0..3e9808f2b5491 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -515,6 +515,8 @@ static inline bool preempt_model_rt(void)
 	return IS_ENABLED(CONFIG_PREEMPT_RT);
 }
 
+extern const char *preempt_model_str(void);
+
 /*
  * Does the preemption model allow non-cooperative preemption?
  *
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a5190..8f5517dbe07d4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7642,6 +7642,30 @@ static inline void preempt_dynamic_init(void) { }
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
+const char *preempt_model_str(void)
+{
+	if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && preempt_model_lazy()) {
+		if (preempt_model_rt())
+			return "PREEMPT_RT+LAZY";
+		if (preempt_model_full())
+			return "PREEMPT+LAZY";
+		if (preempt_model_voluntary())
+			return "VOLUNTARY+LAZY";
+		if (preempt_model_none())
+			return "NONE+LAZY";
+	} else {
+		if (preempt_model_rt())
+			return "PREEMPT_RT";
+		if (preempt_model_full())
+			return "PREEMPT";
+		if (preempt_model_voluntary())
+			return "VOLUNTARY";
+		if (preempt_model_none())
+			return "NONE";
+	}
+	return "UNKNOWN-PREEMPT";
+}
+
 int io_schedule_prepare(void)
 {
 	int old_iowait = current->in_iowait;
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index be62f0ea1814d..3861f53f9a434 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4266,11 +4266,7 @@ print_trace_header(struct seq_file *m, struct trace_iterator *iter)
 		   entries,
 		   total,
 		   buf->cpu,
-		   preempt_model_none()      ? "server" :
-		   preempt_model_voluntary() ? "desktop" :
-		   preempt_model_full()      ? "preempt" :
-		   preempt_model_rt()        ? "preempt_rt" :
-		   "unknown",
+		   preempt_model_str(),
 		   /* These are reserved for later use */
 		   0, 0, 0, 0);
 #ifdef CONFIG_SMP
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 388da1aea14a5..c3e59f8992279 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -54,7 +54,7 @@ void __init dump_stack_set_arch_desc(const char *fmt, ...)
  */
 void dump_stack_print_info(const char *log_lvl)
 {
-	printk("%sCPU: %d UID: %u PID: %d Comm: %.20s %s%s %s %.*s" BUILD_ID_FMT "\n",
+	printk("%sCPU: %d UID: %u PID: %d Comm: %.20s %s%s %s %.*s %s" BUILD_ID_FMT "\n",
 	       log_lvl, raw_smp_processor_id(),
 	       __kuid_val(current_real_cred()->euid),
 	       current->pid, current->comm,
@@ -62,7 +62,7 @@ void dump_stack_print_info(const char *log_lvl)
 	       print_tainted(),
 	       init_utsname()->release,
 	       (int)strcspn(init_utsname()->version, " "),
-	       init_utsname()->version, BUILD_ID_VAL);
+	       init_utsname()->version, preempt_model_str(), BUILD_ID_VAL);
 
 	if (get_taint())
 		printk("%s%s\n", log_lvl, print_tainted_verbose());
-- 
2.45.2

