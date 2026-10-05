Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B683451CC
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 Oct 2026 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226698; cv=none; b=hF3m1o1azBsq/Oog/8BPfSDoGS/kSI8u2ppdITZV/EMnHZRyTzJGUerZsgkP9cHGnPNTSyi4d4632Y50sOmO+Qiu+6ejcX6f+sBBwKUGuPAYHB4sFp1p4FXS3S1qDhnqAIet+ekAKHou9p80yQtNA6Jzy5HdWRmmkFPmZJF66eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226698; c=relaxed/simple;
	bh=GY59al+l+b58JvGR/yoOqaYFUC5Jmyfi72d07AQ3Zm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kOQcl1avdzNvvLeXl0Pzeog8UydV53Nup+bkQV59OLW0FCibauYSJJ9raDepvSDVnu95klXWSNBqxI9M2LwLZnLSy+3bD7yFlChYqGAcldYK9lfNA7diJBLFLmWjazk7JKp0WTnr2VDjk+mfT6/YzxMIpwQ+pfWJZEvIWrIh70c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyaW1Emi; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyaW1Emi"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so17376805e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 05 Oct 2026 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791226695; x=1791831495; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+vGMk9zMXfshoZYeo78yUdqNiKs9Wg3yxfRMv775miA=;
        b=HyaW1Emie0t1eMGJ29aank0zCTJrf8HyCbG5ASCy4t9S0aUPyMAno8gjJCypBxQC/v
         Uc1JuY0UL7GDmiN7NLNIx6djpi84sgkNdqi4wz8DZ6KILKp1CTqR+3Hzfm/wOT3b+qKz
         4bvZrfhFgmWOTw1kdSDqz/eJihH1JqA4FS6xwpmpNtcmgKzrVyc7bpuDA2GRXS06nk3I
         UMdZ4hPycQ01fziIZQTJM75OC5Kk8i3UDf6y3ndz6UJOEGZfju6RSEkgTHYiYZ+ZTMPG
         xxbmP7/mfxDFG7jiIlE1igCcnn+X26XbHgdv6SRBb+B06HQZycWSpy7rRu+5XnA0KKTY
         K2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226695; x=1791831495;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+vGMk9zMXfshoZYeo78yUdqNiKs9Wg3yxfRMv775miA=;
        b=ZqvWLa5l7R6jOzkYV03XvzCvOYzr94ZHdHvB1iZzYD++Ve2GP+Yhj3e/D4tDHvrKVx
         kkix6YVvUtoVWZ/pYBeP7Z+MHAsNNILULC8/cfEepG5uImSFWTQyq4gBwNbxlP9/SfKd
         41eQJyEyeCMMCKpBDHztLEc3lf2qSBH/Qf+SgXftj9YpZ7j8a1Abby2gmY853VnrLHPI
         jpqUXlOEtU74ZITsnuvhoxIc559UHNBgqrbQod7fA1kwb8VlCQS4YAwQlaZoDiEDUmmg
         0O/1/lYEpO3DX/bLp/ojdpzCr2m5Duqi8PZKwdaDfvMdKs1OnQOVPcQhmMrHimFAAikp
         WENw==
X-Forwarded-Encrypted: i=1; AKwUvByiQVOw5clvyWMCDV1TGA5XLCdnJ1ZzAkcasRm6sFy9IliFIfaf/bPJntXjYMNya/2zHnnbhWkmYL/bnSnMfw==@lists.linux.dev
X-Gm-Message-State: AFuF++mrvi+mtX8T2cRhPtjhuWdNr9lPgp7me7AbBfqMhwuj0gzhQKft
	OBxR3hc1WwByHcWVbMA1tZH2xkGf2DbKtejvw/XeAhWYAWHrpJl8TstQ
X-Gm-Gg: AYBFou18S/zzZMBPy6t2FU7fOr2bbDxZKIbaCyWBmVcZe+QJC+d0OpOn2SjSftxIqdR
	aIrWjTdfXWiWvqrYOd44KuJbrOEvB6mFDq0+e0quhKy9dVo4X/8gcSdN6b0+hT6Fjp+7QmtcaiB
	7jVjscSG1Gz82u9oWLxntSTbhCv5KBfq6ukUCGTHFyKNfvoxaUIUm8DHbL15GlvPy16yIAfvOdu
	ir/orsEJ67Xhwm+/mKpVE7Q8JXOmCOixXTVs+FuR1EUs2xOogfLrfxUxfGqFj/Wy2BZdy8+Wvr0
	rkTwEN/J8Ghl44fSkQ94CsepitZ4z7mkpN24bmj5eO5C3UKkmcqsDLW0Wl7iypxqJwJjYj8rY+2
	GnEhfBmST8xx54pU03xvRCc+V+g7JncH+L9GzvNTtPYhHTHlR7kC8PjDZMwhxOf0rS1xatSU6hf
	hPexzNNkOXaL6RePtfLcHZyGaLpxDlZlAhyK9ya9YCAO15nqYN19cTfvdvahh0guZIug9vkcniC
	mD+B7Z8W/gKbMRo5OGAlJ+y5r93RSgoZn1mA0eOVrNabeIsZvdeCKh/Gs5HnmZoXwruNygjWYA0
	8agiOSLKyfMpOZxdc4UopEgLZRo4LfR4Ac67AZgvth/aqyelMaZGeb9QWZl3oQWOXtp/m0s3pk5
	yXw==
X-Received: by 2002:a05:600c:3545:b0:4a1:242:1353 with SMTP id 5b1f17b1804b1-4a102421468mr181301955e9.5.1791226694299;
        Mon, 05 Oct 2026 11:58:14 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de. [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm281196795e9.2.2026.10.05.11.58.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 11:58:13 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Marco Elver <elver@google.com>,
	Bradley Morgan <brads@mainlining.org>,
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
Subject: [PATCH v4 0/6] kcov: Keep timer and scheduler noise out of task coverage
Date: Mon,  5 Oct 2026 20:57:57 +0200
Message-Id: <20261005185803.39170-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series reduces the executions syzkaller spends on rechecking
spurious timer and scheduler coverage. On a Raspberry Pi 400 with
PREEMPT_RT, triage dropped from 26-34% of all executions to 10%, and
20-minute runs ended with a 26-82% larger corpus at equal execution
counts.

Documentation/dev-tools/kcov.rst says that KCOV aims at stable coverage
that is a function of syscall inputs, and that it does not collect
coverage from non-deterministic parts of the kernel such as the
scheduler. kernel/sched/ is built without KCOV instrumentation, but code
that it calls is instrumented, for example sched_clock() and the CPU
capacity helpers. Deferred hrtimer rearm runs instrumented code in task
context on interrupt return. All of that is recorded for whichever task
is in the kernel at that moment. Identical syscalls then report
different coverage, and the fuzzer re-runs programs to tell the spurious
part from real new coverage.

The code involved also runs on behalf of real syscalls, for example the
hrtimer and timekeeping ones, so building it without KCOV would lose
wanted coverage. Add a nestable KCOV_PAUSED bit and a kcov_pause guard
instead. Take the guard in deferred hrtimer rearm, __schedule(),
try_to_wake_up() and wake_up_new_task(). With KCOV=n the guard compiles
away.

Measurements with syzkaller 29fd395f4ab6, patched against base, every
run from an empty corpus. Each row summarizes three pairs of runs,
except the last, which summarizes five. Ranges show the minimum and
maximum across pairs. Corpus size and coverage (covered PCs) are
compared at the execution count of the kernel that executed fewer
programs. The triage column is the relative change in the share of
executions spent on triage, for example from 13.5% to 6% in the third
row.

                            executions corpus    coverage  triage
  Pi 400 native, RT, 20 min 37-81k     +26..82%  +18..45%  -71..-63%
  Pi 500+ KVM, RT, 20 min   126-189k   +11..12%  +4..8%    -59..-52%
  Pi 500+ KVM, RT, 60 min   391-455k   +5..10%   -1..+1%   -58..-53%
  Pi 500+ KVM, 60 min       339-470k   +0..2%    -3..+4%   -25..-16%
  x86-64 QEMU, RT, 3 h      6-32k      +40..81%  +15..21%  -71..-59%
  x86-64 QEMU, 3 h          15-52k     +29..74%  +8..20%   -75..-68%

The gain is largest early in a run and narrows as coverage saturates.
After one hour on the Pi 500+ with PREEMPT_RT the coverage is the same,
the corpus is 5-10% larger and the share of executions spent on triage
is still roughly halved.

The Pi rows are real hardware. "Native" means that the board fuzzes its
own kernel, without a hypervisor. arm64 has no deferred hrtimer rearm,
so the Pi rows measure patches 4-6 only. The x86-64 rows are emulated
with QEMU TCG and -icount shift=0, at HZ=100. x86-64 has not been
measured at real speed.

The effect also shows without a fuzzer. Of 1,000 identical fork() calls
on the Pi 400 with PREEMPT_RT, 218-233 still produce new syzkaller
signal on the base kernel and 45-53 with this series.

The spurious coverage also breaks KCOV_SELFTEST. On x86-64 defconfig
with KCOV_SELFTEST=y, with and without PREEMPT_RT, current mainline
crashed in the selftest in 3/3 boots per configuration and this series
passed in 10/10. The crash is a recursive fault that does not name the
offending PC. The diagnostic patch that reports it is in

    https://lore.kernel.org/r/20261002181357.14293-1-kmehltretter@gmail.com

Known limits:
 - Without PREEMPT_RT, arm64 showed no clear corpus improvement in these
   runs. It also records its softirq stack switch on interrupt exit in
   task coverage, which this series does not touch. That is addressed
   by the softirq patch mentioned below together with

    https://lore.kernel.org/r/20260926191325.79047-1-kmehltretter@gmail.com

 - RISC-V showed no clear improvement from this series alone, because
   its trap entry code records into task coverage on every interrupt.
   A prototype fix looks promising. I will post it separately after more
   testing.
 - The KCOV selftest still fails on arm64 and RISC-V for these reasons.

Peter Zijlstra's IRQ-exit accounting idea from the v2 discussion is
complementary. I turned it into a separate patch, "softirq: Preserve
interrupt context during IRQ exit", which is at v5 and has been
reviewed:

    https://lore.kernel.org/r/20260930191432.62760-1-kmehltretter@gmail.com

It only covers work dispatched directly from IRQ exit. Deferred rearm
outside that path and the task-context scheduler paths remain.

Changes in v4:
 - Lead the cover letter with the fuzzing results, now including real
   hardware, and retitle the series, which was "kcov: Suppress timer and
   scheduler coverage leaks" (Andrew Morton).
 - Say "instrumented with KCOV" in the scheduler comments and in the
   changelogs of patches 4-6 (Alexander Potapenko).
 - Rebase onto current mainline (551c722f4080). No code change. The
   affected objects are identical to v3 rebased onto the same commit.

Other v4 testing:
 - KCOV=n: in kernel/, the .text of sched/core.o, time/hrtimer.o,
   softirq.o, entry/common.o and fork.o is identical to the base.
 - The affected objects build with KCOV on ARM32, arm64, RISC-V32,
   RISC-V64, s390 and LoongArch64, and on x86-64 with GCC 8.1 and
   Clang 21. With PREEMPT_RT: ARM32, arm64, RISC-V64 and LoongArch64.

v1:
    https://lore.kernel.org/r/20260807205027.31972-1-kmehltretter@gmail.com
v2:
    https://lore.kernel.org/r/20260811154111.64669-1-kmehltretter@gmail.com
v3:
    https://lore.kernel.org/r/20260914054632.12877-1-kmehltretter@gmail.com

Karl Mehltretter (6):
  kcov: Use unsigned int for kcov_start() mode parameter
  kcov: Add a kcov_pause guard
  hrtimer: Pause KCOV during deferred rearm
  sched/core: Pause KCOV in __schedule()
  sched/core: Pause KCOV in try_to_wake_up()
  sched/core: Pause KCOV in wake_up_new_task()

 include/linux/hrtimer_rearm.h | 18 +++++++-
 include/linux/kcov.h          | 80 +++++++++++++++++++++++++++++++----
 kernel/kcov.c                 |  7 +--
 kernel/sched/core.c           | 10 ++++-
 4 files changed, 97 insertions(+), 18 deletions(-)

Range-diff:
1:  cbbdcfe8483b = 1:  d11d5a628248 kcov: Use unsigned int for kcov_start() mode parameter
2:  1ca1b221b7e6 = 2:  d94ce0944f95 kcov: Add a kcov_pause guard
3:  238cf03aa786 = 3:  b251939de11f hrtimer: Pause KCOV during deferred rearm
4:  55c364e62fb8 ! 4:  8910122b4d6d sched/core: Pause KCOV in __schedule()
    @@ Metadata
      ## Commit message ##
         sched/core: Pause KCOV in __schedule()
     
    -    kernel/sched/ is built without KCOV instrumentation, but callees such
    -    as sched_clock(), architecture CPU-capacity helpers and profile_hits() are.
    +    kernel/sched/ is built without KCOV instrumentation, but it calls code
    +    that is instrumented with KCOV, such as sched_clock(), architecture
    +    CPU-capacity helpers and profile_hits().
     
    -    During preemption and schedule() calls, instrumented callees can add
    +    During preemption and schedule() calls, these callees can add
         nondeterministic scheduler coverage to current.
     
         With CONFIG_KCOV_SELFTEST added to x86_64 defconfig, the interrupt
    @@ kernel/sched/core.c: static void __sched notrace __schedule(int sched_mode)
      	struct rq *rq;
      	int cpu;
      
    -+	/* Instrumented callees would leak coverage into current. */
    ++	/* Callees instrumented with KCOV would leak coverage into current. */
     +	guard(kcov_pause)();
     +
      	/* Trace preemptions consistently with task switches */
5:  2b6c6355917c ! 5:  5bb61ae630f7 sched/core: Pause KCOV in try_to_wake_up()
    @@ Commit message
         sched/core: Pause KCOV in try_to_wake_up()
     
         try_to_wake_up() is built without KCOV instrumentation, but it calls
    -    instrumented helpers such as kthread_is_per_cpu(), CPU capacity helpers
    -    and SCHED_HRTICK arming. They can record into current while in_task() is
    -    true.
    +    helpers instrumented with KCOV, such as kthread_is_per_cpu(), CPU
    +    capacity helpers and SCHED_HRTICK arming. They can record into current
    +    while in_task() is true.
     
         CONFIG_KCOV_SELFTEST exposes this under PREEMPT_RT. The interrupt
         selftest fails on x86_64 in kthread_is_per_cpu(): RT runs the timer
    @@ kernel/sched/core.c: bool ttwu_state_match(struct task_struct *p, unsigned int s
       */
      int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
      {
    -+	/* Instrumented callees would leak coverage into current. */
    ++	/* Callees instrumented with KCOV would leak coverage into current. */
     +	guard(kcov_pause)();
      	guard(preempt)();
      	int cpu, success = 0;
6:  417784f395a8 ! 6:  7c13bc0e78d5 sched/core: Pause KCOV in wake_up_new_task()
    @@ Commit message
         sched/core: Pause KCOV in wake_up_new_task()
     
         wake_up_new_task() is built without KCOV instrumentation, but CPU
    -    selection and enqueue call instrumented helpers. During a KCOV-enabled
    -    fork, they can record scheduler, hrtimer and clockevent coverage into the
    -    parent.
    +    selection and enqueue call helpers instrumented with KCOV. During a
    +    KCOV-enabled fork, they can record scheduler, hrtimer and clockevent
    +    coverage into the parent.
     
         The paths depend on runqueue and CPU state, so coverage varies between
         identical forks. Pause KCOV for the whole function, extending the
    @@ kernel/sched/core.c: void wake_up_new_task(struct task_struct *p)
      	struct rq *rq;
      	int wake_flags = WF_FORK;
      
    -+	/* Instrumented callees would leak coverage into current. */
    ++	/* Callees instrumented with KCOV would leak coverage into current. */
     +	guard(kcov_pause)();
     +
      	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);

base-commit: 551c722f40809618230001baccf219193e22fc5a
-- 
2.53.0

