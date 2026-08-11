Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7813438AF
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 19:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478389; cv=none; b=dPNuoCnO8gfFK7LkdP2kMssUFcA3U+GJVyA6dcaWaPAXnhMydjYr93myDMl+Vq6WuEYJCgigcHpP7Jv01LOeNNnkcxJFLGUjm16pquy0YPYseoD5OE4CZAWYXP7cii1ThGphek7ET27CH5v7cs1OnaVerMvszfc1Fn4o1VDHf30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478389; c=relaxed/simple;
	bh=MG+IMM/i/CNNVL5AzxKL/XKpYW8iwuXXfH2txBkWygI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=e8vGOGPFPrkLC96IX41/7OT4e7TSW1X4odazZOtpPdewIH28YtodEzniAhBLZ0TnQdPWwiwyJcnkePFpdhV+KwBjdCuTKGaz4a76DVw8DdEShJrhYMENogve1WcWUTtFsXGZ0wCDB5ihfKl6fHvy8cyAaHbwYEAqQhwoP1u2+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=CTYNrJGy; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="CTYNrJGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786478382;
	bh=olhjGijS3yV1N3w6K81sASrZ/p4/Pr5xRUDJM7G3JdQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CTYNrJGykIy/v5FnQ2QoNNFUDyWMVT3p3OBB6sd0wfqsSTyIDrDxZBp4Ar2sGW4WL
	 6SJv9/bXbvyeIkZB72FrhTKaukTTPGkZjO/Bjek/3VCVjfCvkEkk6TNZ3lNFZTasEy
	 uHNjhwNlTHb9ZD4PHa7T+iGDSinD9zEwdqg7lAno=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4hKMsV4p1hz10wG;
	Tue, 11 Aug 2026 19:59:42 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4hKMsT568kz10vf;
	Tue, 11 Aug 2026 19:59:41 +0000 (UTC)
Date: Tue, 11 Aug 2026 20:59:41 +0100
From: Bradley Morgan <include@grrlz.net>
To: Karl Mehltretter <kmehltretter@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
CC: Andrey Konovalov <andreyknvl@gmail.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Marco Elver <elver@google.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] kcov: Suppress timer and scheduler coverage leaks
In-Reply-To: <20260811154111.64669-1-kmehltretter@gmail.com>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
Message-ID: <60A84278-D257-4815-8CB0-8247DEDDA339@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 11 August 2026 16:41:05 BST, Karl Mehltretter <kmehltretter@gmail.com>
wrote:
>KCOV aims to exclude interrupt and scheduler coverage so syscall coverage
>stays input-dependent. Instrumented callees can still record when
>uninstrumented timer and scheduler paths run with in_task() true.
>
>With the diagnostic patch in [1] applied, CONFIG_KCOV_SELFTEST exposes
>three cases on x86-64: deferred hrtimer rearm, __schedule() callees and
>PREEMPT_RT wakeups. Task-context wakeups and new-task enqueue also add
>scheduler coverage to ordinary syscalls.
>
>Add a nestable KCOV_PAUSED bit and a kcov_pause guard. Use the guard for
>deferred hrtimer rearm, __schedule(), the try_to_wake_up() wakeup body
>and wake_up_new_task(). This suppresses their instrumented callees
>without excluding those callees from task-context coverage.
>
>Changes in v2:
> - Add patch 1 to make kcov_start()'s mode parameter unsigned int. No
>   functional change.
> - Rework patch 2 around a guard-only API with private current-only
>   helpers (Bradley Morgan).
> - Use the guard in patches 3-6 and reword the pause comments.
>
>v2 testing:
> - GCC builds on x86-64, arm32, arm64, MIPS32/64, PowerPC 32/64,
>   s390, RISC-V 32/64, LoongArch, Xtensa and UML.
> - PREEMPT_RT builds on x86-64, arm32, arm64, RISC-V 32/64 and
>   LoongArch.
> - x86-64 builds with GCC 8.1 and Clang 22.1. Both kernels passed a
>   KCOV selftest boot.
> - x86-64 CONFIG_KCOV=n build, with no KCOV or pause references.
> - KCOV selftest, 10/10 x86-64 boots with and without PREEMPT_RT. A
>   fresh non-RT boot passed after the helper-only rework.
> - 40 dummy_hcd/g_zero remote-KCOV cycles on x86-64 and arm64.
> - 400 repeated fork() calls on x86-64 PREEMPT_RT.
>
>Three one-hour syzkaller A/B pairs were run. Each baseline and patched
>run used four 2-vCPU PREEMPT_RT VMs. The patched kernel completed 22-51%
>more executions than base. At matched execution counts, corpus size grew
>42-54% and coverage 14-19%. No run produced a report.
>
>With KCOV disabled, the pause sections compile away. With KCOV enabled
>on x86-64, GCC 15.2 grows __schedule() by 117 bytes,
>try_to_wake_up() by 94 bytes and wake_up_new_task() by 88 bytes relative
>to the base commit.
>
>[1]
>https://lore.kernel.org/r/20260724192122.73080-1-kmehltretter@gmail.com
>


Reviewed-by: Bradley Morgan <include@grrlz.net>

On all 6 patches


>v1: https://lore.kernel.org/r/20260807205027.31972-1-kmehltretter@gmail.com
>
>Karl Mehltretter (6):
>  kcov: Use unsigned int for kcov_start() mode parameter
>  kcov: Add a kcov_pause guard
>  hrtimer: Pause KCOV during deferred rearm
>  sched/core: Pause KCOV in __schedule()
>  sched/core: Pause KCOV in try_to_wake_up()
>  sched/core: Pause KCOV in wake_up_new_task()
>
> include/linux/hrtimer_rearm.h | 17 +++++++++++++--
> include/linux/kcov.h          | 40 ++++++++++++++++++++++++++++++++++-
> kernel/kcov.c                 |  4 ++--
> kernel/sched/core.c           | 11 +++++++++-
> 4 files changed, 66 insertions(+), 6 deletions(-)
>
>Range-diff:
>-:  ------------- > 1:  f60b858edad96 kcov: Use unsigned int for kcov_start() mode parameter
>1:  a67095eb565de ! 2:  4415cac41ca43 kcov: add kcov_pause()/kcov_resume() helpers
>    @@ Metadata
>     Author: Karl Mehltretter <kmehltretter@gmail.com>
>     
>      ## Commit message ##
>    -    kcov: add kcov_pause()/kcov_resume() helpers
>    +    kcov: Add a kcov_pause guard
>     
>         Interrupt-return work can run after HARDIRQ_OFFSET is dropped, when
>         in_task() is true. KCOV then attributes instrumented callees to the
>         interrupted task.
>     
>         Add a KCOV_PAUSED bit next to KCOV_IN_CTXSW and mask both in
>    -    kcov_mode_enabled(). The context switch suppression keeps its own bit:
>    -    kcov_prepare_switch() runs on the previous task and kcov_finish_switch()
>    -    on the one switched in, so its lifetime is not a pause section.
>    +    kcov_mode_enabled(). The coverage callbacks need no new check because
>    +    check_kcov_mode()'s exact comparison rejects modes with KCOV_PAUSED set.
>     
>    -    Sections nest by passing the state returned by kcov_pause() to
>    -    kcov_resume(). Both operate on current. When task KCOV is active, remote
>    -    softirq sections save and restore the complete mode, preserving the
>    -    pause state.
>    +    The context switch suppression keeps its own bit: kcov_prepare_switch()
>    +    runs on the previous task and kcov_finish_switch() on the one switched
>    +    in, so its lifetime is not a pause section.
>     
>    -    The helpers are __always_inline, and the caller must be uninstrumented:
>    +    Provide a kcov_pause guard backed by internal helpers that operate on
>    +    current. The guard saves the previous pause state and restores it at
>    +    scope exit, so sections nest. When KCOV is enabled for current, remote
>    +    softirq sections save and restore the complete mode, preserving the pause
>    +    state.
>    +
>    +    The helpers are __always_inline, and guard users must be uninstrumented:
>         inlining does not remove the caller's own coverage callbacks.
>     
>    -    Assisted-by: Claude:claude-opus-4-8
>         Assisted-by: Claude:claude-fable-5
>         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>     
>    @@ include/linux/kcov.h
>      #define _LINUX_KCOV_H
>      
>     +#include <linux/bits.h>
>    ++#include <linux/cleanup.h>
>      #include <linux/sched.h>
>      #include <uapi/linux/kcov.h>
>      
>    @@ include/linux/kcov.h: do {						\
>      } while (0)
>      
>     +/*
>    -+ * Pause coverage for current. Pass the returned state to kcov_resume().
>    -+ * Callers must be uninstrumented.
>    ++ * Pause coverage for current. Callers must be uninstrumented.
>    ++ * Pass the returned state to __kcov_resume().
>     + */
>    -+static __always_inline unsigned int kcov_pause(struct task_struct *t)
>    ++static __always_inline unsigned int __kcov_pause(void)
>     +{
>     +	unsigned int paused;
>     +
>    -+	paused = t->kcov_mode & KCOV_PAUSED;
>    -+	t->kcov_mode |= KCOV_PAUSED;
>    ++	paused = current->kcov_mode & KCOV_PAUSED;
>    ++	current->kcov_mode |= KCOV_PAUSED;
>     +	return paused;
>     +}
>     +
>    -+static __always_inline void kcov_resume(struct task_struct *t, unsigned int paused)
>    ++static __always_inline void __kcov_resume(unsigned int paused)
>     +{
>     +	if (!paused)
>    -+		t->kcov_mode &= ~KCOV_PAUSED;
>    ++		current->kcov_mode &= ~KCOV_PAUSED;
>     +}
>     +
>      /* See Documentation/dev-tools/kcov.rst for usage details. */
>    @@ include/linux/kcov.h: void __sanitizer_cov_trace_switch(kcov_u64 val, void *case
>      
>      static inline void kcov_task_init(struct task_struct *t) {}
>      static inline void kcov_task_exit(struct task_struct *t) {}
>    -+static inline unsigned int kcov_pause(struct task_struct *t) { return 0; }
>    -+static inline void kcov_resume(struct task_struct *t, unsigned int paused) {}
>    ++static inline unsigned int __kcov_pause(void) { return 0; }
>    ++static inline void __kcov_resume(unsigned int paused) {}
>      static inline void kcov_prepare_switch(struct task_struct *t) {}
>      static inline void kcov_finish_switch(struct task_struct *t) {}
>      static inline void kcov_remote_start(u64 handle) {}
>    +@@ include/linux/kcov.h: static inline void kcov_remote_start_usb_softirq(u64 id) {}
>    + static inline void kcov_remote_stop_softirq(void) {}
>    + 
>    + #endif /* CONFIG_KCOV */
>    ++
>    ++/*
>    ++ * Scope-based KCOV pause:
>    ++ *
>    ++ *	guard(kcov_pause)();
>    ++ *
>    ++ * pauses coverage for current until the end of the scope. Callers must be
>    ++ * uninstrumented.
>    ++ */
>    ++DEFINE_LOCK_GUARD_0(kcov_pause,
>    ++		    _T->paused = __kcov_pause(),
>    ++		    __kcov_resume(_T->paused),
>    ++		    unsigned int paused)
>    ++
>    + #endif /* _LINUX_KCOV_H */
>     
>      ## kernel/kcov.c ##
>     @@ kernel/kcov.c: static const struct file_operations kcov_fops = {
>2:  2d64b45a316c8 ! 3:  c891839993a1e hrtimer: pause KCOV during deferred rearm
>    @@ Metadata
>     Author: Karl Mehltretter <kmehltretter@gmail.com>
>     
>      ## Commit message ##
>    -    hrtimer: pause KCOV during deferred rearm
>    +    hrtimer: Pause KCOV during deferred rearm
>     
>         Deferred hrtimer rearm can run after HARDIRQ_OFFSET is dropped. in_task()
>         is then true, so KCOV attributes the instrumented timer-reprogramming
>         subtree to current.
>     
>    -    With CONFIG_KCOV_SELFTEST, the interrupt selftest fails on x86_64
>    -    defconfig under QEMU, detecting spurious coverage in
>    -    __hrtimer_rearm_deferred(). The same happens on s390, RISC-V and
>    -    LoongArch, which also enable HRTIMER_REARM_DEFERRED.
>    +    With CONFIG_KCOV_SELFTEST added to x86_64 defconfig, the interrupt
>    +    selftest fails under QEMU, detecting spurious coverage in
>    +    __hrtimer_rearm_deferred(). The same happens on s390, RISC-V and LoongArch,
>    +    which also enable HRTIMER_REARM_DEFERRED.
>     
>         Excluding the involved files instead would cost their coverage on real
>         task-context paths, e.g. the hrtimer and timekeeping syscalls.
>     
>    -    Pause in the __always_inline wrappers, including hrtick_schedule_exit().
>    -    Call sites where task KCOV can be active are KCOV-disabled or noinstr.
>    -    HAVE_NOINSTR_HACK covers pre-GCC-12 x86. The other affected
>    -    architectures restrict KCOV to GCC 12 or Clang through
>    -    ARCH_WANTS_NO_INSTR. This avoids relying on __no_sanitize_coverage,
>    -    which is empty before GCC 12. Tested with GCC 8.1 and 15 on x86_64.
>    +    Take the kcov_pause guard in an __always_inline wrapper around
>    +    __hrtimer_rearm_deferred(). Use it at all call sites, including
>    +    hrtick_schedule_exit(). Callers that may run with KCOV enabled for current
>    +    are built without KCOV instrumentation or marked noinstr. HAVE_NOINSTR_HACK
>    +    covers pre-GCC-12 x86. The other affected architectures restrict KCOV to
>    +    GCC 12 or Clang through ARCH_WANTS_NO_INSTR. This avoids relying on
>    +    __no_sanitize_coverage, which is empty before GCC 12. Tested with GCC 8.1
>    +    and 15 on x86_64.
>     
>         Fixes: 15dd3a948855 ("hrtimer: Push reprogramming timers into the interrupt return path")
>    -    Assisted-by: Claude:claude-opus-4-8
>         Assisted-by: Claude:claude-fable-5
>         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>     
>    @@ include/linux/hrtimer_rearm.h
>      void __hrtimer_rearm_deferred(void);
>      
>     +/*
>    -+ * Pause outside __hrtimer_rearm_deferred() to suppress its entry coverage.
>    -+ * Call sites where task KCOV can be active are uninstrumented.
>    ++ * KCOV: Pause outside __hrtimer_rearm_deferred() to suppress entry coverage.
>    ++ * Callers with KCOV enabled for current must be uninstrumented.
>     + */
>    -+static __always_inline void hrtimer_rearm_deferred_paused(void)
>    ++static __always_inline void hrtimer_rearm_deferred_kcov_paused(void)
>     +{
>    -+	unsigned int kcov_paused = kcov_pause(current);
>    ++	guard(kcov_pause)();
>     +
>     +	__hrtimer_rearm_deferred();
>    -+	kcov_resume(current, kcov_paused);
>     +}
>     +
>      /*
>    @@ include/linux/hrtimer_rearm.h: hrtimer_rearm_deferred_user_irq(unsigned long *ti
>      	if (unlikely((*tif_work & TIF_REARM_MASK) == _TIF_HRTIMER_REARM)) {
>      		clear_thread_flag(TIF_HRTIMER_REARM);
>     -		__hrtimer_rearm_deferred();
>    -+		hrtimer_rearm_deferred_paused();
>    ++		hrtimer_rearm_deferred_kcov_paused();
>      		/* Don't go into the loop if HRTIMER_REARM was the only flag */
>      		*tif_work &= ~TIF_HRTIMER_REARM;
>      		return !*tif_work;
>    @@ include/linux/hrtimer_rearm.h: hrtimer_rearm_deferred_user_irq(unsigned long *ti
>      {
>      	if (hrtimer_test_and_clear_rearm_deferred_tif(tif_work))
>     -		__hrtimer_rearm_deferred();
>    -+		hrtimer_rearm_deferred_paused();
>    ++		hrtimer_rearm_deferred_kcov_paused();
>      }
>      
>      /*
>    @@ include/linux/hrtimer_rearm.h: static __always_inline bool hrtimer_test_and_clea
>      
>      #else  /* CONFIG_HRTIMER_REARM_DEFERRED */
>      static __always_inline void __hrtimer_rearm_deferred(void) { }
>    -+static __always_inline void hrtimer_rearm_deferred_paused(void) { }
>    ++static __always_inline void hrtimer_rearm_deferred_kcov_paused(void) { }
>      static __always_inline void hrtimer_rearm_deferred(void) { }
>      static __always_inline void hrtimer_rearm_deferred_tif(unsigned long tif_work) { }
>      static __always_inline bool
>    @@ kernel/sched/core.c: static inline void hrtick_schedule_exit(struct rq *rq)
>      
>      	if (rq->hrtick_sched & HRTICK_SCHED_REARM_HRTIMER)
>     -		__hrtimer_rearm_deferred();
>    -+		hrtimer_rearm_deferred_paused();
>    ++		hrtimer_rearm_deferred_kcov_paused();
>      
>      	rq->hrtick_sched = HRTICK_SCHED_NONE;
>      }
>3:  dc4bdcf8adacd ! 4:  63657f2c7ef08 sched: pause KCOV in __schedule()
>    @@ Metadata
>     Author: Karl Mehltretter <kmehltretter@gmail.com>
>     
>      ## Commit message ##
>    -    sched: pause KCOV in __schedule()
>    +    sched/core: Pause KCOV in __schedule()
>     
>         kernel/sched/ is not instrumented, but callees such as sched_clock(),
>         architecture CPU-capacity helpers and profile_hits() are.
>    @@ Commit message
>         During preemption and schedule() calls, instrumented callees can add
>         nondeterministic scheduler coverage to current.
>     
>    -    With CONFIG_KCOV_SELFTEST, the interrupt selftest fails on x86_64
>    -    defconfig under QEMU, detecting spurious coverage in
>    -    arch_scale_cpu_capacity(). On arm64 the same class of leak appears in
>    -    sched_clock(), once the separate arm64 interrupt-accounting leak is
>    -    suppressed.
>    +    With CONFIG_KCOV_SELFTEST added to x86_64 defconfig, the interrupt
>    +    selftest fails under QEMU, detecting spurious coverage in
>    +    arch_scale_cpu_capacity().
>     
>         Annotating each callee would spread exclusions across architectures.
>         Pause across __schedule() instead, extending the scheduler exclusion to
>         its callees.
>     
>    -    KCOV_PAUSED remains set while a task is switched out. Its resumed
>    -    __schedule() frame restores the prior state.
>    +    KCOV_PAUSED remains set while a task is switched out. The guard in its
>    +    resumed __schedule() frame restores the prior state.
>     
>         Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
>    -    Assisted-by: Claude:claude-opus-4-8
>         Assisted-by: Claude:claude-fable-5
>         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>     
>      ## kernel/sched/core.c ##
>     @@ kernel/sched/core.c: static void __sched notrace __schedule(int sched_mode)
>    - 	bool is_switch = false;
>    - 	unsigned long *switch_count;
>    - 	unsigned long prev_state;
>    -+	unsigned int kcov_paused;
>    - 	struct rq_flags rf;
>      	struct rq *rq;
>      	int cpu;
>      
>    -+	/* KCOV: sched/ is uninstrumented but the __schedule() callees are not. */
>    -+	kcov_paused = kcov_pause(current);
>    ++	/* Instrumented callees would leak coverage into current. */
>    ++	guard(kcov_pause)();
>     +
>      	/* Trace preemptions consistently with task switches */
>      	trace_sched_entry_tp(sched_mode == SM_PREEMPT);
>      
>    -@@ kernel/sched/core.c: static void __sched notrace __schedule(int sched_mode)
>    - 		raw_spin_rq_unlock_irq(rq);
>    - 	}
>    - 	trace_sched_exit_tp(is_switch);
>    -+	kcov_resume(current, kcov_paused);
>    - }
>    - 
>    - void __noreturn do_task_dead(void)
>4:  b8e96cc1903de ! 5:  5cf8497b8a0ab sched: pause KCOV in try_to_wake_up()
>    @@ Metadata
>     Author: Karl Mehltretter <kmehltretter@gmail.com>
>     
>      ## Commit message ##
>    -    sched: pause KCOV in try_to_wake_up()
>    +    sched/core: Pause KCOV in try_to_wake_up()
>     
>         try_to_wake_up() is uninstrumented, but it calls instrumented helpers
>         such as kthread_is_per_cpu(), CPU capacity helpers and SCHED_HRTICK
>    @@ Commit message
>         selftest's spin. The same helpers leak into non-RT syscall wakeups such
>         as a pipe write waking a reader.
>     
>    -    Pause all of try_to_wake_up(). Wrapping only select_task_rq() would miss
>    -    SCHED_HRTICK arming during enqueue.
>    +    Pause the wakeup body with the kcov_pause guard. Wrapping only
>    +    select_task_rq() would miss SCHED_HRTICK arming during enqueue.
>     
>         Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
>    -    Assisted-by: Claude:claude-opus-4-8
>    +    Assisted-by: Claude:claude-fable-5
>         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>     
>      ## kernel/sched/core.c ##
>     @@ kernel/sched/core.c: int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>    - {
>      	guard(preempt)();
>      	int cpu, success = 0;
>    -+	/* KCOV: sched/ is uninstrumented but the wakeup callees are not. */
>    -+	unsigned int kcov_paused = kcov_pause(current);
>      
>    ++	/* Instrumented callees would leak coverage into current. */
>    ++	guard(kcov_pause)();
>    ++
>      	wake_flags |= WF_TTWU;
>      
>    -@@ kernel/sched/core.c: int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>    - 	if (success)
>    - 		ttwu_stat(p, task_cpu(p), wake_flags);
>    - 
>    -+	kcov_resume(current, kcov_paused);
>    - 	return success;
>    - }
>    - 
>    + 	if (p == current) {
>5:  f91a7644a15e8 ! 6:  a00870853f5a1 sched: pause KCOV in wake_up_new_task()
>    @@ Metadata
>     Author: Karl Mehltretter <kmehltretter@gmail.com>
>     
>      ## Commit message ##
>    -    sched: pause KCOV in wake_up_new_task()
>    +    sched/core: Pause KCOV in wake_up_new_task()
>     
>         wake_up_new_task() is uninstrumented, but CPU selection and enqueue call
>         instrumented helpers. During a KCOV-enabled fork, they can record
>    @@ Commit message
>         scheduler exclusion to new-task wakeups.
>     
>         Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
>    -    Assisted-by: Claude:claude-opus-4-8
>    +    Assisted-by: Claude:claude-fable-5
>         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
>     
>      ## kernel/sched/core.c ##
>     @@ kernel/sched/core.c: void wake_up_new_task(struct task_struct *p)
>    - {
>    - 	struct rq_flags rf;
>      	struct rq *rq;
>    -+	unsigned int kcov_paused;
>      	int wake_flags = WF_FORK;
>      
>    -+	/* KCOV: sched/ is uninstrumented but the wakeup callees are not. */
>    -+	kcov_paused = kcov_pause(current);
>    ++	/* Instrumented callees would leak coverage into current. */
>    ++	guard(kcov_pause)();
>     +
>      	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>      	WRITE_ONCE(p->__state, TASK_RUNNING);
>      	/*
>    -@@ kernel/sched/core.c: void wake_up_new_task(struct task_struct *p)
>    - 		rq_repin_lock(rq, &rf);
>    - 	}
>    - 	task_rq_unlock(rq, p, &rf);
>    -+	kcov_resume(current, kcov_paused);
>    - }
>    - 
>    - #ifdef CONFIG_PREEMPT_NOTIFIERS
>
>base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
>

Thanks!
