Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129D3AFB11
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462882; cv=none; b=V0JIaZGZjIHp4evjSXEo1kv7V2QUY00vulOQgHQ2ypH7BZaSgiHOsS7+O4j2YdMJGvgvQSM9dqUg+eqRvQnPN4aMHNCO8sZ7yCoNXCFfNAHGyJcVabL6Rmywf2Tbl3HbZ6y60l0kpGmuzwo/5cwdJcNj8bWb+ccGLiLuNCcf1VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462882; c=relaxed/simple;
	bh=s7aQ9Jo5IpNpRaKI4kBz7sEX+KAWTf7AOPfOgiYuQ6g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tz9zXIvxtdr9qVvTbMeOyRsinujdc4RSJSm1gQuZai6GQxsM8HHGZnTv3xnY5U48HfkWdgIxZchJ6ffyUftIMTqmTNYwy0ud3hZOnSXMGGCGLLzPULLYOJ8yx5VOBdspFJXbIaBu8wl5sFHvGfven1YzHyjWODGdllLAyur/Kys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HP1mfmYR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HP1mfmYR"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4997581cdc1so8059605e9.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786462878; x=1787067678; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nbbtsW/svgslrDggJ6qu2kRElCJjA61vSbbwa+q9b9E=;
        b=HP1mfmYRfzhxx4XObce02NJUvlILczmCxzgY2wRSzafzBAIT4vAyLgkytj6cdzcKkT
         w8ybWgZ4xZl7NkvKSvMAGU0BgxGUbk0eQXR4+8eY7ZHY4jROC/W4HzQh8NWYFcdNfm5N
         c3T+QjmVEETzqdo5uQi0AuCmzzWFR7AjhrGg63WLN4w0Mo4iftAIwI4qtTYS1JUsEjBD
         uHbPx8mnXtaCPvQOKmSFk1Y5ZKrbXhjkVhKcIPnGp9XdbjeaMsGrDy3prBFqJxTArATl
         a4MtpCf8NflfvUboFtKtWcLfBXKXUhXB4H2IMD5+syNkJT/tGVIPKzjqCUnD79FCUOJX
         mKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462878; x=1787067678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nbbtsW/svgslrDggJ6qu2kRElCJjA61vSbbwa+q9b9E=;
        b=PU2FksdB/TT6x9hEzyDqrXvW6t1rnAgKq8lTq/yB3XFb1Snwfbam/Y7guZR7qFctHj
         vvvUkrX5JvocFBxKayh/pPLsFLDa64ZePYYZUdTG5a4tAutfUuXSWPxf9yaCHr9qB5D+
         ogu+4Ob+eg18ZqKGeYjuCVbuT2gyRUumEbuBPsALRHIXAU4HL6GiMrKQFR4CRQUM+SIT
         9LjFd7V/Gq+Jgi35hRtc0dF320xl331LcoUFEGoifihIkN5SV0MWrtILBjjq87hmsFf7
         PkAwpzpIr9T2Rl5JszGmXfJzHNRgNZ3jvgCU6/L4VV2+XaWqlOIpMuCIBbL6P5Oke3dB
         gfDA==
X-Forwarded-Encrypted: i=1; AHgh+RpAgQcj2G5P6b58BXynOxno6vZtCyhnPNg+RZgWBWmrPbMBnp0zqNqLXqE30ackUWdKy4uZXB7BqwlMaAxylA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzLyyfya69jiJ0z0fXVEMNseGmQewVuNTqbqJ4mqKnpke+Ysc9w
	a8A9qHXHPyf+NB+NwPgtjhUsUZRkgWizuKNbwT732u9lqc9ZzfYPw+ND
X-Gm-Gg: AR+sD13Ausn3WlN4VWA2TJAqJylBaS2jJ+twoa9Di7AqnXse/8nuQICqgXiB1znK4hh
	cMPw3KL3fFW4/gr2PJpyIpKlRHfzMQmNyNq9rPe3I1eWc4dSOgiMDWZO/b7tIfmCPfXHJKJDS1u
	Tw5jzw1td4+dF93dBulLWA/fZow8cp4Teg8tjWT5OFeVDI3GgBMoZGstrJcLWXDPCOrCAGs3PdD
	hLfHX9XOHQaWy+t0DvlszzLyMGiCWfu0nmmkZitxJQWsfd9iyQMYZTbntzprR587i6ohOfZpcv9
	2FgDzy+rPaBCPEBQaYe3yZMX1K6UCdF2vB37e15FA1MyLwMjXEns7aByBQPzcua3h7J9swm0O3x
	27lPE66CtB0w3Fy8kjevY+oxpozTKaKiwFmNuKd3kUz1jKOJltjX0NoQFdu7rQBMDQ2eERIy5dy
	tvvU//zJJ98Zs8TkS9MUOlJTj0TQ8OdNs0qTgI55vfqJc+JLDp0Kf9C24ZHTABYmLsfXrUeqXCz
	ySvN/LWTf3J+jIx5D7fVbNbbP26ySXOUE9Y6YGrB5HNS1xCysHeYiYD71PbSkxEPQYN8a3CRU6o
	8hMd3YLmvxgMHKmwKk6046ETCk0zR/EK/e2Ik8ggVmppV485AYSeess3UmPFBFvlQYC+PPE8AwM
	x8nZF
X-Received: by 2002:a05:600c:4585:b0:493:f318:3bc6 with SMTP id 5b1f17b1804b1-49978472d39mr66761285e9.13.1786462877773;
        Tue, 11 Aug 2026 08:41:17 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aaa7aabsm1670275e9.7.2026.08.11.08.41.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 08:41:17 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Bradley Morgan <include@grrlz.net>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] kcov: Suppress timer and scheduler coverage leaks
Date: Tue, 11 Aug 2026 17:41:05 +0200
Message-Id: <20260811154111.64669-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCOV aims to exclude interrupt and scheduler coverage so syscall coverage
stays input-dependent. Instrumented callees can still record when
uninstrumented timer and scheduler paths run with in_task() true.

With the diagnostic patch in [1] applied, CONFIG_KCOV_SELFTEST exposes
three cases on x86-64: deferred hrtimer rearm, __schedule() callees and
PREEMPT_RT wakeups. Task-context wakeups and new-task enqueue also add
scheduler coverage to ordinary syscalls.

Add a nestable KCOV_PAUSED bit and a kcov_pause guard. Use the guard for
deferred hrtimer rearm, __schedule(), the try_to_wake_up() wakeup body
and wake_up_new_task(). This suppresses their instrumented callees
without excluding those callees from task-context coverage.

Changes in v2:
 - Add patch 1 to make kcov_start()'s mode parameter unsigned int. No
   functional change.
 - Rework patch 2 around a guard-only API with private current-only
   helpers (Bradley Morgan).
 - Use the guard in patches 3-6 and reword the pause comments.

v2 testing:
 - GCC builds on x86-64, arm32, arm64, MIPS32/64, PowerPC 32/64,
   s390, RISC-V 32/64, LoongArch, Xtensa and UML.
 - PREEMPT_RT builds on x86-64, arm32, arm64, RISC-V 32/64 and
   LoongArch.
 - x86-64 builds with GCC 8.1 and Clang 22.1. Both kernels passed a
   KCOV selftest boot.
 - x86-64 CONFIG_KCOV=n build, with no KCOV or pause references.
 - KCOV selftest, 10/10 x86-64 boots with and without PREEMPT_RT. A
   fresh non-RT boot passed after the helper-only rework.
 - 40 dummy_hcd/g_zero remote-KCOV cycles on x86-64 and arm64.
 - 400 repeated fork() calls on x86-64 PREEMPT_RT.

Three one-hour syzkaller A/B pairs were run. Each baseline and patched
run used four 2-vCPU PREEMPT_RT VMs. The patched kernel completed 22-51%
more executions than base. At matched execution counts, corpus size grew
42-54% and coverage 14-19%. No run produced a report.

With KCOV disabled, the pause sections compile away. With KCOV enabled
on x86-64, GCC 15.2 grows __schedule() by 117 bytes,
try_to_wake_up() by 94 bytes and wake_up_new_task() by 88 bytes relative
to the base commit.

[1] https://lore.kernel.org/r/20260724192122.73080-1-kmehltretter@gmail.com

v1: https://lore.kernel.org/r/20260807205027.31972-1-kmehltretter@gmail.com

Karl Mehltretter (6):
  kcov: Use unsigned int for kcov_start() mode parameter
  kcov: Add a kcov_pause guard
  hrtimer: Pause KCOV during deferred rearm
  sched/core: Pause KCOV in __schedule()
  sched/core: Pause KCOV in try_to_wake_up()
  sched/core: Pause KCOV in wake_up_new_task()

 include/linux/hrtimer_rearm.h | 17 +++++++++++++--
 include/linux/kcov.h          | 40 ++++++++++++++++++++++++++++++++++-
 kernel/kcov.c                 |  4 ++--
 kernel/sched/core.c           | 11 +++++++++-
 4 files changed, 66 insertions(+), 6 deletions(-)

Range-diff:
-:  ------------- > 1:  f60b858edad96 kcov: Use unsigned int for kcov_start() mode parameter
1:  a67095eb565de ! 2:  4415cac41ca43 kcov: add kcov_pause()/kcov_resume() helpers
    @@ Metadata
     Author: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## Commit message ##
    -    kcov: add kcov_pause()/kcov_resume() helpers
    +    kcov: Add a kcov_pause guard
     
         Interrupt-return work can run after HARDIRQ_OFFSET is dropped, when
         in_task() is true. KCOV then attributes instrumented callees to the
         interrupted task.
     
         Add a KCOV_PAUSED bit next to KCOV_IN_CTXSW and mask both in
    -    kcov_mode_enabled(). The context switch suppression keeps its own bit:
    -    kcov_prepare_switch() runs on the previous task and kcov_finish_switch()
    -    on the one switched in, so its lifetime is not a pause section.
    +    kcov_mode_enabled(). The coverage callbacks need no new check because
    +    check_kcov_mode()'s exact comparison rejects modes with KCOV_PAUSED set.
     
    -    Sections nest by passing the state returned by kcov_pause() to
    -    kcov_resume(). Both operate on current. When task KCOV is active, remote
    -    softirq sections save and restore the complete mode, preserving the
    -    pause state.
    +    The context switch suppression keeps its own bit: kcov_prepare_switch()
    +    runs on the previous task and kcov_finish_switch() on the one switched
    +    in, so its lifetime is not a pause section.
     
    -    The helpers are __always_inline, and the caller must be uninstrumented:
    +    Provide a kcov_pause guard backed by internal helpers that operate on
    +    current. The guard saves the previous pause state and restores it at
    +    scope exit, so sections nest. When KCOV is enabled for current, remote
    +    softirq sections save and restore the complete mode, preserving the pause
    +    state.
    +
    +    The helpers are __always_inline, and guard users must be uninstrumented:
         inlining does not remove the caller's own coverage callbacks.
     
    -    Assisted-by: Claude:claude-opus-4-8
         Assisted-by: Claude:claude-fable-5
         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
     
    @@ include/linux/kcov.h
      #define _LINUX_KCOV_H
      
     +#include <linux/bits.h>
    ++#include <linux/cleanup.h>
      #include <linux/sched.h>
      #include <uapi/linux/kcov.h>
      
    @@ include/linux/kcov.h: do {						\
      } while (0)
      
     +/*
    -+ * Pause coverage for current. Pass the returned state to kcov_resume().
    -+ * Callers must be uninstrumented.
    ++ * Pause coverage for current. Callers must be uninstrumented.
    ++ * Pass the returned state to __kcov_resume().
     + */
    -+static __always_inline unsigned int kcov_pause(struct task_struct *t)
    ++static __always_inline unsigned int __kcov_pause(void)
     +{
     +	unsigned int paused;
     +
    -+	paused = t->kcov_mode & KCOV_PAUSED;
    -+	t->kcov_mode |= KCOV_PAUSED;
    ++	paused = current->kcov_mode & KCOV_PAUSED;
    ++	current->kcov_mode |= KCOV_PAUSED;
     +	return paused;
     +}
     +
    -+static __always_inline void kcov_resume(struct task_struct *t, unsigned int paused)
    ++static __always_inline void __kcov_resume(unsigned int paused)
     +{
     +	if (!paused)
    -+		t->kcov_mode &= ~KCOV_PAUSED;
    ++		current->kcov_mode &= ~KCOV_PAUSED;
     +}
     +
      /* See Documentation/dev-tools/kcov.rst for usage details. */
    @@ include/linux/kcov.h: void __sanitizer_cov_trace_switch(kcov_u64 val, void *case
      
      static inline void kcov_task_init(struct task_struct *t) {}
      static inline void kcov_task_exit(struct task_struct *t) {}
    -+static inline unsigned int kcov_pause(struct task_struct *t) { return 0; }
    -+static inline void kcov_resume(struct task_struct *t, unsigned int paused) {}
    ++static inline unsigned int __kcov_pause(void) { return 0; }
    ++static inline void __kcov_resume(unsigned int paused) {}
      static inline void kcov_prepare_switch(struct task_struct *t) {}
      static inline void kcov_finish_switch(struct task_struct *t) {}
      static inline void kcov_remote_start(u64 handle) {}
    +@@ include/linux/kcov.h: static inline void kcov_remote_start_usb_softirq(u64 id) {}
    + static inline void kcov_remote_stop_softirq(void) {}
    + 
    + #endif /* CONFIG_KCOV */
    ++
    ++/*
    ++ * Scope-based KCOV pause:
    ++ *
    ++ *	guard(kcov_pause)();
    ++ *
    ++ * pauses coverage for current until the end of the scope. Callers must be
    ++ * uninstrumented.
    ++ */
    ++DEFINE_LOCK_GUARD_0(kcov_pause,
    ++		    _T->paused = __kcov_pause(),
    ++		    __kcov_resume(_T->paused),
    ++		    unsigned int paused)
    ++
    + #endif /* _LINUX_KCOV_H */
     
      ## kernel/kcov.c ##
     @@ kernel/kcov.c: static const struct file_operations kcov_fops = {
2:  2d64b45a316c8 ! 3:  c891839993a1e hrtimer: pause KCOV during deferred rearm
    @@ Metadata
     Author: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## Commit message ##
    -    hrtimer: pause KCOV during deferred rearm
    +    hrtimer: Pause KCOV during deferred rearm
     
         Deferred hrtimer rearm can run after HARDIRQ_OFFSET is dropped. in_task()
         is then true, so KCOV attributes the instrumented timer-reprogramming
         subtree to current.
     
    -    With CONFIG_KCOV_SELFTEST, the interrupt selftest fails on x86_64
    -    defconfig under QEMU, detecting spurious coverage in
    -    __hrtimer_rearm_deferred(). The same happens on s390, RISC-V and
    -    LoongArch, which also enable HRTIMER_REARM_DEFERRED.
    +    With CONFIG_KCOV_SELFTEST added to x86_64 defconfig, the interrupt
    +    selftest fails under QEMU, detecting spurious coverage in
    +    __hrtimer_rearm_deferred(). The same happens on s390, RISC-V and LoongArch,
    +    which also enable HRTIMER_REARM_DEFERRED.
     
         Excluding the involved files instead would cost their coverage on real
         task-context paths, e.g. the hrtimer and timekeeping syscalls.
     
    -    Pause in the __always_inline wrappers, including hrtick_schedule_exit().
    -    Call sites where task KCOV can be active are KCOV-disabled or noinstr.
    -    HAVE_NOINSTR_HACK covers pre-GCC-12 x86. The other affected
    -    architectures restrict KCOV to GCC 12 or Clang through
    -    ARCH_WANTS_NO_INSTR. This avoids relying on __no_sanitize_coverage,
    -    which is empty before GCC 12. Tested with GCC 8.1 and 15 on x86_64.
    +    Take the kcov_pause guard in an __always_inline wrapper around
    +    __hrtimer_rearm_deferred(). Use it at all call sites, including
    +    hrtick_schedule_exit(). Callers that may run with KCOV enabled for current
    +    are built without KCOV instrumentation or marked noinstr. HAVE_NOINSTR_HACK
    +    covers pre-GCC-12 x86. The other affected architectures restrict KCOV to
    +    GCC 12 or Clang through ARCH_WANTS_NO_INSTR. This avoids relying on
    +    __no_sanitize_coverage, which is empty before GCC 12. Tested with GCC 8.1
    +    and 15 on x86_64.
     
         Fixes: 15dd3a948855 ("hrtimer: Push reprogramming timers into the interrupt return path")
    -    Assisted-by: Claude:claude-opus-4-8
         Assisted-by: Claude:claude-fable-5
         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
     
    @@ include/linux/hrtimer_rearm.h
      void __hrtimer_rearm_deferred(void);
      
     +/*
    -+ * Pause outside __hrtimer_rearm_deferred() to suppress its entry coverage.
    -+ * Call sites where task KCOV can be active are uninstrumented.
    ++ * KCOV: Pause outside __hrtimer_rearm_deferred() to suppress entry coverage.
    ++ * Callers with KCOV enabled for current must be uninstrumented.
     + */
    -+static __always_inline void hrtimer_rearm_deferred_paused(void)
    ++static __always_inline void hrtimer_rearm_deferred_kcov_paused(void)
     +{
    -+	unsigned int kcov_paused = kcov_pause(current);
    ++	guard(kcov_pause)();
     +
     +	__hrtimer_rearm_deferred();
    -+	kcov_resume(current, kcov_paused);
     +}
     +
      /*
    @@ include/linux/hrtimer_rearm.h: hrtimer_rearm_deferred_user_irq(unsigned long *ti
      	if (unlikely((*tif_work & TIF_REARM_MASK) == _TIF_HRTIMER_REARM)) {
      		clear_thread_flag(TIF_HRTIMER_REARM);
     -		__hrtimer_rearm_deferred();
    -+		hrtimer_rearm_deferred_paused();
    ++		hrtimer_rearm_deferred_kcov_paused();
      		/* Don't go into the loop if HRTIMER_REARM was the only flag */
      		*tif_work &= ~TIF_HRTIMER_REARM;
      		return !*tif_work;
    @@ include/linux/hrtimer_rearm.h: hrtimer_rearm_deferred_user_irq(unsigned long *ti
      {
      	if (hrtimer_test_and_clear_rearm_deferred_tif(tif_work))
     -		__hrtimer_rearm_deferred();
    -+		hrtimer_rearm_deferred_paused();
    ++		hrtimer_rearm_deferred_kcov_paused();
      }
      
      /*
    @@ include/linux/hrtimer_rearm.h: static __always_inline bool hrtimer_test_and_clea
      
      #else  /* CONFIG_HRTIMER_REARM_DEFERRED */
      static __always_inline void __hrtimer_rearm_deferred(void) { }
    -+static __always_inline void hrtimer_rearm_deferred_paused(void) { }
    ++static __always_inline void hrtimer_rearm_deferred_kcov_paused(void) { }
      static __always_inline void hrtimer_rearm_deferred(void) { }
      static __always_inline void hrtimer_rearm_deferred_tif(unsigned long tif_work) { }
      static __always_inline bool
    @@ kernel/sched/core.c: static inline void hrtick_schedule_exit(struct rq *rq)
      
      	if (rq->hrtick_sched & HRTICK_SCHED_REARM_HRTIMER)
     -		__hrtimer_rearm_deferred();
    -+		hrtimer_rearm_deferred_paused();
    ++		hrtimer_rearm_deferred_kcov_paused();
      
      	rq->hrtick_sched = HRTICK_SCHED_NONE;
      }
3:  dc4bdcf8adacd ! 4:  63657f2c7ef08 sched: pause KCOV in __schedule()
    @@ Metadata
     Author: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## Commit message ##
    -    sched: pause KCOV in __schedule()
    +    sched/core: Pause KCOV in __schedule()
     
         kernel/sched/ is not instrumented, but callees such as sched_clock(),
         architecture CPU-capacity helpers and profile_hits() are.
    @@ Commit message
         During preemption and schedule() calls, instrumented callees can add
         nondeterministic scheduler coverage to current.
     
    -    With CONFIG_KCOV_SELFTEST, the interrupt selftest fails on x86_64
    -    defconfig under QEMU, detecting spurious coverage in
    -    arch_scale_cpu_capacity(). On arm64 the same class of leak appears in
    -    sched_clock(), once the separate arm64 interrupt-accounting leak is
    -    suppressed.
    +    With CONFIG_KCOV_SELFTEST added to x86_64 defconfig, the interrupt
    +    selftest fails under QEMU, detecting spurious coverage in
    +    arch_scale_cpu_capacity().
     
         Annotating each callee would spread exclusions across architectures.
         Pause across __schedule() instead, extending the scheduler exclusion to
         its callees.
     
    -    KCOV_PAUSED remains set while a task is switched out. Its resumed
    -    __schedule() frame restores the prior state.
    +    KCOV_PAUSED remains set while a task is switched out. The guard in its
    +    resumed __schedule() frame restores the prior state.
     
         Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
    -    Assisted-by: Claude:claude-opus-4-8
         Assisted-by: Claude:claude-fable-5
         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## kernel/sched/core.c ##
     @@ kernel/sched/core.c: static void __sched notrace __schedule(int sched_mode)
    - 	bool is_switch = false;
    - 	unsigned long *switch_count;
    - 	unsigned long prev_state;
    -+	unsigned int kcov_paused;
    - 	struct rq_flags rf;
      	struct rq *rq;
      	int cpu;
      
    -+	/* KCOV: sched/ is uninstrumented but the __schedule() callees are not. */
    -+	kcov_paused = kcov_pause(current);
    ++	/* Instrumented callees would leak coverage into current. */
    ++	guard(kcov_pause)();
     +
      	/* Trace preemptions consistently with task switches */
      	trace_sched_entry_tp(sched_mode == SM_PREEMPT);
      
    -@@ kernel/sched/core.c: static void __sched notrace __schedule(int sched_mode)
    - 		raw_spin_rq_unlock_irq(rq);
    - 	}
    - 	trace_sched_exit_tp(is_switch);
    -+	kcov_resume(current, kcov_paused);
    - }
    - 
    - void __noreturn do_task_dead(void)
4:  b8e96cc1903de ! 5:  5cf8497b8a0ab sched: pause KCOV in try_to_wake_up()
    @@ Metadata
     Author: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## Commit message ##
    -    sched: pause KCOV in try_to_wake_up()
    +    sched/core: Pause KCOV in try_to_wake_up()
     
         try_to_wake_up() is uninstrumented, but it calls instrumented helpers
         such as kthread_is_per_cpu(), CPU capacity helpers and SCHED_HRTICK
    @@ Commit message
         selftest's spin. The same helpers leak into non-RT syscall wakeups such
         as a pipe write waking a reader.
     
    -    Pause all of try_to_wake_up(). Wrapping only select_task_rq() would miss
    -    SCHED_HRTICK arming during enqueue.
    +    Pause the wakeup body with the kcov_pause guard. Wrapping only
    +    select_task_rq() would miss SCHED_HRTICK arming during enqueue.
     
         Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
    -    Assisted-by: Claude:claude-opus-4-8
    +    Assisted-by: Claude:claude-fable-5
         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## kernel/sched/core.c ##
     @@ kernel/sched/core.c: int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
    - {
      	guard(preempt)();
      	int cpu, success = 0;
    -+	/* KCOV: sched/ is uninstrumented but the wakeup callees are not. */
    -+	unsigned int kcov_paused = kcov_pause(current);
      
    ++	/* Instrumented callees would leak coverage into current. */
    ++	guard(kcov_pause)();
    ++
      	wake_flags |= WF_TTWU;
      
    -@@ kernel/sched/core.c: int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
    - 	if (success)
    - 		ttwu_stat(p, task_cpu(p), wake_flags);
    - 
    -+	kcov_resume(current, kcov_paused);
    - 	return success;
    - }
    - 
    + 	if (p == current) {
5:  f91a7644a15e8 ! 6:  a00870853f5a1 sched: pause KCOV in wake_up_new_task()
    @@ Metadata
     Author: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## Commit message ##
    -    sched: pause KCOV in wake_up_new_task()
    +    sched/core: Pause KCOV in wake_up_new_task()
     
         wake_up_new_task() is uninstrumented, but CPU selection and enqueue call
         instrumented helpers. During a KCOV-enabled fork, they can record
    @@ Commit message
         scheduler exclusion to new-task wakeups.
     
         Fixes: 5c9a8750a640 ("kernel: add kcov code coverage")
    -    Assisted-by: Claude:claude-opus-4-8
    +    Assisted-by: Claude:claude-fable-5
         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## kernel/sched/core.c ##
     @@ kernel/sched/core.c: void wake_up_new_task(struct task_struct *p)
    - {
    - 	struct rq_flags rf;
      	struct rq *rq;
    -+	unsigned int kcov_paused;
      	int wake_flags = WF_FORK;
      
    -+	/* KCOV: sched/ is uninstrumented but the wakeup callees are not. */
    -+	kcov_paused = kcov_pause(current);
    ++	/* Instrumented callees would leak coverage into current. */
    ++	guard(kcov_pause)();
     +
      	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
      	WRITE_ONCE(p->__state, TASK_RUNNING);
      	/*
    -@@ kernel/sched/core.c: void wake_up_new_task(struct task_struct *p)
    - 		rq_repin_lock(rq, &rf);
    - 	}
    - 	task_rq_unlock(rq, p, &rf);
    -+	kcov_resume(current, kcov_paused);
    - }
    - 
    - #ifdef CONFIG_PREEMPT_NOTIFIERS

base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
-- 
2.53.0
