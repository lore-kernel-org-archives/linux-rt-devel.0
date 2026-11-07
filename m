Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057448;
	b=Hbn5aEabNPESyp8raoZoyhXBqeEGvUSOV05zAXbelR0hNy6H/khur74kzNziYO5Wq9gu
	 1S3I3p++5SD+kNTEGqenzAAGHC/72k6sfCb8cWBFyeODXcXLcQMGJJYJrIeRB+vQlBwmi
	 8+xfN5HOxZ2Ljr1WkJxzidudfVN4oznMd4wtxvsn37IYQiCVNeyR7j1OZuUA16EdDekxG
	 vPM7h0WKaxnYeFDQIebDO7JI9yafsMP8fLXSWl/OspKKMFjiOS3ex3y+Bw6/YGEiLcCIp
	 P5a/jklKivrUsl6vJOmey7OvBjdxHCIa2i/yHfOaRx0dKpn/rLT/G97/OcvqkaM5xfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=seFoQ1M9VRMBka62Jgwt8ud5HzT0C+sBXGf5CP6RWJ8=;
	b=cjvhGZ2czQNa1owOLxmYZP38BMn0RKoqmmLGxgzyWyW6KdKFRBhWLT1lP4Ao1tX8YrCz
	 43/KSjYHrQJzVLlKIQQ2ipmYG2+lUrhRPdiAap66oM+WCOm3FYefDzWb6pu/BAwU1/6W+
	 0zK9Zlp7G9iD56sYA6Cs9O9yXIAwgwyAolY8rndAPBXM75NwXqG00i4ufJsCYm+7f5R4U
	 Oq6y7BTbcArdta5V046GD43XnG+abBanGRKVwSuH9aXbXAEpoyFJ2iYySMxxuRoDhDeZL
	 Y7cgIQTzXfumJPOV7aqVZ5Y970czvPH1FJAdsKoHMgugC3O4qRLFi3hGvYF7dZTkLvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="fu/TGCAV";
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125D606A32C
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 13:17:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D125D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fu/TGCAV
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso10407825e9.1
        for <linux-rt-devel@lists.linux.dev>; Sat, 07 Nov 2026 05:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057445; x=1794662245; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=seFoQ1M9VRMBka62Jgwt8ud5HzT0C+sBXGf5CP6RWJ8=;
        b=fu/TGCAV7nvWfOkl52XAeZ8wmgjuLiTt1IX0lIS5NrbCFfWTyE/ZVxVOiIrJUfDfUg
         8vLMvKamOMMIKH+ISExOzol5Swy6/U4tRq4Q7Y3OLn9JztNljTCED9GDRrHDnkLnNutw
         SI+tzPzyiM5GyyBXIBssNi3gxoqBb37DoCs1QgZOytI/wVjg4hLMX2Wgavdyyj0hFNyn
         Na1E0htL/tn6rLN/sQAHHw1NRu9Ry5jfffnwhbNCNcHLvWIlIVgLTtulp3XmyOP2XAeB
         Mv9zXsPFLZJs8s09CYMxn/VnrD3ad75ZI+l34d39Xem3OmgBvvSrtQwO8opkpcg5ZQ9e
         Iumw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057445; x=1794662245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=seFoQ1M9VRMBka62Jgwt8ud5HzT0C+sBXGf5CP6RWJ8=;
        b=ORkPPysUtLCiWbqzq7/2FfcpN8PSqNzj1AhzxmcUCjaR0moVK0NHPjkX0hjWTTijC4
         vNHP+fa6/K6nxocDWUUljmPNw6GNfLeLD5KSDOKbu5X5CaRJHhoPPmaugukgMGpHu691
         LuZF0WTY6m7QoD6Hut4DPn74NcEwu4fvhhQiNNxKEStpuk5HXyRSv+c+0Ga9bdbH9lAu
         i5hBGlNGKd+hFbkWGh5g9RU+NCTzSph+lP0qLZMtZ+o8uKiIxtfjGivwUhiQ2JLHXrTi
         A8ZGg1H7yfinEk+KtFpVKUkgVM/Pr6g1ZT6AbaiMUiPFNFl09hD5RCW9CRZjg1bjRSNE
         AHxg==
X-Forwarded-Encrypted: i=1; AKwUvBw4DQ3sp+wz607u7THVrqlVJKTZk7xLQtbg8aVeHGKUjEziD5NiviROQ0ix1FiyVyaVNrPgUwWE5uhSLPHXXQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/lgTIwsdTtzD72CWEpWjtqDXuKGD453mxhi79kfzFmEdUnWNaJ
	m1uPJkpt9yggYZeXuVutATvfYnNIMZPhzZYgfAnxlMx+xwlSTCX2JjLM
X-Gm-Gg: AYBFou38iUX3561ED2k4KugftZSy5ctAj3/9+k1zTdsq+H4SSYAnRUHMJHsV/TqbWMq
	f9jAb6SKXJfQhItybeecI0CRQFL6hsx97/GvvsdPRBZ/UONQ29NFOzKqjJCGkpXDBcUCGEaSFsU
	OIyHOxjLeECiFwvG68qKYraAPBGBkj26ITYUyOPs9ycwrQC/eow1FJ0CmTgRCCOrMgvL7eFkRIQ
	9zfWSt1+fI5EhFUQ/JwQFhhsOJhLlCI5TfNwKNChx7LQsOeZ32wgE9qm5Y+zBKVk5BFYo0f3jCe
	3RtFins3kJc9nqctF8Ax+4S3JdgooEXlO94oI4E5wTQCdS0+f7qBSMx4GKuo7YFBWy0accHtuIJ
	zbbLiDszWhj4t9nyh4llUgWxVHwGHWKYIJtj038W/ZqAQw77zh1EC8Iv/xwmNw5Z5x9zCiuoi1i
	bZAtNySB19K72xBs2BLBhxd6OWtaaXjef1u29UZ5YuKIU7Eati2fu5vXQo6kv6jAl5P/FzsliJL
	y6DHBk3a3tSrUO84Oig2L4x80WFzgxbDtLvFNS2y71il1VhxBSUrhZCcd1ByOovhuVgkOC+LKqr
	/kXCjaL/l3YdEhZzjOUoUCn7TXwKyF+/QnUKvm/sw5DhpCqDWd04i4p4gsMzCNJR+1wD1/KkDjt
	8ioF3Iq1lJMd+fVYfZmtp/RuYv5Aq2bVPjDzsqv7Ez2PU8sQD2ZQGXQngrYkRozEZPV1GsPX5HQ
	4aJGiDrEzGOX0bVQI27reN6CmWQ3Ds4+z+UtF51DSbev3I2oyQUvE1
X-Received: by 2002:a05:600c:34cc:b0:4a1:dfaf:f465 with SMTP id 5b1f17b1804b1-4b6db4a6e2fmr92698615e9.4.1794057444750;
        Sat, 07 Nov 2026 05:17:24 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3279f9csm65132675e9.8.2026.11.07.05.17.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 05:17:24 -0800 (PST)
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
Subject: [PATCH v5 0/6] kcov: Keep timer and scheduler noise out of task coverage
Date: Sat,  7 Nov 2026 14:17:04 +0100
Message-Id: <20261107131710.89264-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
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
instead. Take the guard with kcov_pause_scope() in deferred hrtimer
rearm, __schedule(), try_to_wake_up() and wake_up_new_task(). With
KCOV=n the pause calls expand to no-ops.

Measurements from v4 on mainline 551c722f4080 (before commits
feb5c9a2447a ("softirq: Preserve interrupt context on return from
interrupt") and a9cd14bfb0c1 ("arm64: irq: exclude the softirq stack
switch from KCOV")), with syzkaller 29fd395f4ab6, every run from an
empty corpus. Each row summarizes three pairs of runs, except the last,
which summarizes five. Ranges show the minimum and maximum across pairs.
Corpus size and coverage (covered PCs) are compared at the execution
count of the kernel that executed fewer programs. The triage column is
the relative change in the share of executions spent on triage, for
example from 13.5% to 6% in the third row.

                            executions corpus    coverage  triage
  Pi 400 native, RT, 20 min 37-81k     +26..82%  +18..45%  -71..-63%
  Pi 500+ KVM, RT, 20 min   126-189k   +11..12%  +4..8%    -59..-52%
  Pi 500+ KVM, RT, 60 min   391-455k   +5..10%   -1..+1%   -58..-53%
  Pi 500+ KVM, 60 min       339-470k   +0..2%    -3..+4%   -25..-16%
  x86-64 QEMU, RT, 3 h      6-32k      +40..81%  +15..21%  -71..-59%
  x86-64 QEMU, 3 h          15-52k     +29..74%  +8..20%   -75..-68%

The gain is largest early in a run and narrows as coverage saturates.
After one hour on the Pi 500+ with PREEMPT_RT the number of covered PCs
is within -1% to +1%, the corpus is 5-10% larger and the share of
executions spent on triage is still roughly halved.

The Pi rows are real hardware. "Native" means that the board fuzzes its
own kernel, without a hypervisor. arm64 has no deferred hrtimer rearm,
so the Pi rows measure patches 4-6 only. The x86-64 rows are emulated
with QEMU TCG and -icount shift=0, at HZ=100. x86-64 fuzzing has not
been measured at real speed.

The effect also shows without a fuzzer. Of 1,000 identical fork() calls
on the Pi 400 with PREEMPT_RT (v4 on 551c722f4080), 218-233 still
produce new syzkaller signal on the base kernel and 45-53 with this
series. On the v5 base (d48723711bae) under x86-64 KVM, 10,000 pipe
wakeup round-trips produce new signal 11-12 times on the base kernel
(17 with PREEMPT_RT) and 4 times with this series (9 with PREEMPT_RT).

The spurious coverage also breaks KCOV_SELFTEST. On the v5 base
(d48723711bae) with KCOV_SELFTEST=y on x86-64 and arm64 defconfig, with
and without PREEMPT_RT, the base kernel failed the selftest in 5/5 boots
per configuration under QEMU TCG (4/5 on arm64 without PREEMPT_RT) and
10/10 under x86-64 KVM. With v5 it passed in 10/10 boots per
configuration under TCG and 20/20 under KVM.

Known limits:
 - Without PREEMPT_RT, arm64 showed no clear corpus improvement in the
   v4 runs above, which predated commits feb5c9a2447a and a9cd14bfb0c1.
 - RISC-V showed no clear improvement from this series alone, because
   its trap entry code records into task coverage on every interrupt,
   and KCOV_SELFTEST still fails there. A prototype fix looks promising.
   I will post it separately after more testing.

Changes in v5:
 - Move DEFINE_LOCK_GUARD_0(kcov_pause, ...) inside #ifdef CONFIG_KCOV
   behind a kcov_pause_scope() macro, and map
   hrtimer_rearm_deferred_kcov_paused() directly to
   __hrtimer_rearm_deferred() when CONFIG_KCOV=n, so non-KCOV builds do
   not emit guard types, constructors or cleanup variables in
   preprocessed output (Andrew Morton).
 - Update patch 5's commit message for commit feb5c9a2447a.
 - Drop the removed Assisted-by tag from the commits (commit
   1e035297ffda).
 - Rebase onto current mainline (d48723711bae).

Other v5 testing:
 - KCOV=n: kernel/sched/core.i and kernel/time/hrtimer.i contain no
   kcov_pause declarations, and in kernel/, the .text and .sched.text of
   sched/core.o, time/hrtimer.o, softirq.o, entry/common.o and fork.o
   are identical to the base.
 - Pause/resume transition tests on x86-64 and arm64 (with and without
   PREEMPT_RT): nested kcov_pause_scope() guards under KCOV_TRACE_PC and
   KCOV_TRACE_CMP, context switching while paused, and remote softirq
   coverage interrupting a paused task.
 - The affected objects build with KCOV on ARM32, arm64, RISC-V32,
   RISC-V64, s390 and LoongArch64, and on x86-64 with GCC and Clang.
   With PREEMPT_RT: x86-64, ARM32, arm64, RISC-V64 and LoongArch64.

An LLM assisted with the patches and testing.

v4:
    https://lore.kernel.org/r/20261005185803.39170-1-kmehltretter@gmail.com

Karl Mehltretter (6):
  kcov: Use unsigned int for kcov_start() mode parameter
  kcov: Add a kcov_pause guard
  hrtimer: Pause KCOV during deferred rearm
  sched/core: Pause KCOV in __schedule()
  sched/core: Pause KCOV in try_to_wake_up()
  sched/core: Pause KCOV in wake_up_new_task()

 include/linux/hrtimer_rearm.h | 23 +++++++++-
 include/linux/kcov.h          | 80 +++++++++++++++++++++++++++++++----
 kernel/kcov.c                 |  7 +--
 kernel/sched/core.c           | 10 ++++-
 4 files changed, 102 insertions(+), 18 deletions(-)

Range-diff:
1:  d11d5a628248 ! 1:  d1b5c6a641c6 kcov: Use unsigned int for kcov_start() mode parameter
    @@ Commit message
         Type the parameter unsigned int, like the field and the saved copy. No
         functional change.
     
    -    Assisted-by: LLM
         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
         Reviewed-by: Alexander Potapenko <glider@google.com>
2:  d94ce0944f95 ! 2:  8addfc05f54c kcov: Add a kcov_pause guard
    @@ Commit message
         The shared setter no longer sets KCOV_IN_CTXSW on a disabled task,
         since its mode already fails the coverage callbacks' exact comparison.
     
    -    Provide a kcov_pause guard backed by flag helpers shared with context
    -    switch suppression. The helpers access kcov_mode with READ_ONCE() and
    -    WRITE_ONCE() and use compiler barriers to keep instrumented calls inside
    -    the suppressed region. The guard saves the previous pause state and
    -    restores it at scope exit, so sections nest. When KCOV is enabled for
    -    current, remote softirq sections save and restore the complete mode,
    -    preserving the pause state.
    +    Provide a kcov_pause guard and kcov_pause_scope() macro backed by flag
    +    helpers shared with context switch suppression. The helpers access
    +    kcov_mode with READ_ONCE() and WRITE_ONCE() and use compiler barriers
    +    to keep instrumented calls inside the suppressed region. The guard
    +    saves the previous pause state and restores it at scope exit, so
    +    sections nest. When KCOV is enabled for current, remote softirq
    +    sections save and restore the complete mode, preserving the pause
    +    state. With CONFIG_KCOV=n, kcov_pause_scope() expands to a no-op
    +    without defining the guard type or cleanup variable.
     
         With CONFIG_KCOV=y, restoring a previously clear flag still writes
         kcov_mode even when task coverage is disabled; nested guards also take
    @@ Commit message
         instrumentation because inlining does not remove the caller's own coverage
         callbacks.
     
    -    Assisted-by: LLM
         Suggested-by: Alexander Potapenko <glider@google.com>
         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## include/linux/kcov.h ##
    -@@
    - #ifndef _LINUX_KCOV_H
    - #define _LINUX_KCOV_H
    +@@ include/linux/kcov.h: struct task_struct;
    + 
    + #ifdef CONFIG_KCOV
      
     +#include <linux/bits.h>
     +#include <linux/cleanup.h>
    - #include <linux/sched.h>
    - #include <uapi/linux/kcov.h>
    - 
    ++
    + enum kcov_mode {
    + 	/* Coverage collection is not enabled yet. */
    + 	KCOV_MODE_DISABLED = 0,
     @@ include/linux/kcov.h: enum kcov_mode {
      	KCOV_MODE_TRACE_CMP = 3,
      };
    @@ include/linux/kcov.h: enum kcov_mode {
      
      /* See Documentation/dev-tools/kcov.rst for usage details. */
      void kcov_remote_start(u64 handle);
    -@@ include/linux/kcov.h: void __sanitizer_cov_trace_switch(kcov_u64 val, void *cases);
    +@@ include/linux/kcov.h: void __sanitizer_cov_trace_const_cmp4(u32 arg1, u32 arg2);
    + void __sanitizer_cov_trace_const_cmp8(kcov_u64 arg1, kcov_u64 arg2);
    + void __sanitizer_cov_trace_switch(kcov_u64 val, void *cases);
      
    - static inline void kcov_task_init(struct task_struct *t) {}
    - static inline void kcov_task_exit(struct task_struct *t) {}
    -+static inline unsigned int __kcov_pause(void) { return 0; }
    -+static inline void __kcov_resume(unsigned int paused) {}
    - static inline void kcov_prepare_switch(struct task_struct *t) {}
    - static inline void kcov_finish_switch(struct task_struct *t) {}
    - static inline void kcov_remote_start(u64 handle) {}
    -@@ include/linux/kcov.h: static inline void kcov_remote_start_usb_softirq(u64 id) {}
    - static inline void kcov_remote_stop_softirq(void) {}
    - 
    - #endif /* CONFIG_KCOV */
    -+
     +/*
     + * Scope-based KCOV pause:
     + *
    -+ *	guard(kcov_pause)();
    ++ *	kcov_pause_scope();
     + *
     + * pauses coverage for current until the end of the scope. Callers must be
     + * built without KCOV instrumentation.
    @@ include/linux/kcov.h: static inline void kcov_remote_start_usb_softirq(u64 id) {
     +		    _T->paused = __kcov_pause(),
     +		    __kcov_resume(_T->paused),
     +		    unsigned int paused)
    ++#define kcov_pause_scope()	guard(kcov_pause)()
     +
    + #else
    + 
    + static inline void kcov_task_init(struct task_struct *t) {}
    +@@ include/linux/kcov.h: static inline void kcov_remote_start_common(struct kcov_common_handle_id id) {}
    + static inline void kcov_remote_start_usb(u64 id) {}
    + static inline void kcov_remote_start_usb_softirq(u64 id) {}
    + static inline void kcov_remote_stop_softirq(void) {}
    ++#define kcov_pause_scope()	do { } while (0)
    + 
    + #endif /* CONFIG_KCOV */
      #endif /* _LINUX_KCOV_H */
     
      ## kernel/kcov.c ##
3:  b251939de11f ! 3:  1e93271df5d3 hrtimer: Pause KCOV during deferred rearm
    @@ Commit message
         Excluding the involved files instead would cost their coverage on real
         task-context paths, e.g. the hrtimer and timekeeping syscalls.
     
    -    Take the kcov_pause guard in an __always_inline wrapper around
    -    __hrtimer_rearm_deferred(). Use it at all call sites, including
    -    hrtick_schedule_exit(). Callers that may run with KCOV enabled for current
    -    are built without KCOV instrumentation or marked noinstr. HAVE_NOINSTR_HACK
    -    covers pre-GCC-12 x86. The other affected architectures restrict KCOV to
    -    GCC 12 or Clang through ARCH_WANTS_NO_INSTR. This avoids relying on
    -    __no_sanitize_coverage, which is empty before GCC 12. Tested with GCC 8.1
    -    and 15 on x86_64.
    +    Pause KCOV with kcov_pause_scope() in an __always_inline wrapper around
    +    __hrtimer_rearm_deferred(), and map the wrapper directly to
    +    __hrtimer_rearm_deferred() when CONFIG_KCOV=n. Use it at all call sites,
    +    including hrtick_schedule_exit(). Callers that may run with KCOV enabled
    +    for current are built without KCOV instrumentation or marked noinstr.
    +    HAVE_NOINSTR_HACK covers pre-GCC-12 x86. The other affected architectures
    +    restrict KCOV to GCC 12 or Clang through ARCH_WANTS_NO_INSTR. This avoids
    +    relying on __no_sanitize_coverage, which is empty before GCC 12. Tested
    +    with GCC 8.1 and 15 on x86_64.
     
         A later patch also pauses __schedule(); keeping hrtick_schedule_exit()
         guarded here makes the deferred-rearm fix independent of that scheduler
         change.
     
         Fixes: 15dd3a948855 ("hrtimer: Push reprogramming timers into the interrupt return path")
    -    Assisted-by: LLM
         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## include/linux/hrtimer_rearm.h ##
     @@
      
    - #ifdef CONFIG_HRTIMER_REARM_DEFERRED
    - #include <linux/irqflags.h>
    -+#include <linux/kcov.h>
    - #include <linux/lockdep.h>
    - #include <linux/preempt.h>
    - #include <linux/thread_info.h>
    - 
      void __hrtimer_rearm_deferred(void);
      
    ++#ifdef CONFIG_KCOV
    ++#include <linux/kcov.h>
    ++
     +/*
     + * KCOV: Pause outside __hrtimer_rearm_deferred() to suppress entry coverage.
     + * Callers with KCOV enabled for current must be built without KCOV
    @@ include/linux/hrtimer_rearm.h
     + */
     +static __always_inline void hrtimer_rearm_deferred_kcov_paused(void)
     +{
    -+	guard(kcov_pause)();
    ++	kcov_pause_scope();
     +
     +	__hrtimer_rearm_deferred();
     +}
    ++#else
    ++#define hrtimer_rearm_deferred_kcov_paused()	__hrtimer_rearm_deferred()
    ++#endif
     +
      /*
       * This is purely CPU local, so check the TIF bit first to avoid the overhead of
    @@ include/linux/hrtimer_rearm.h: hrtimer_rearm_deferred_user_irq(unsigned long *ti
     -		__hrtimer_rearm_deferred();
     +		hrtimer_rearm_deferred_kcov_paused();
      		/* Don't go into the loop if HRTIMER_REARM was the only flag */
    - 		*tif_work &= ~TIF_HRTIMER_REARM;
    + 		*tif_work &= ~_TIF_HRTIMER_REARM;
      		return !*tif_work;
     @@ include/linux/hrtimer_rearm.h: hrtimer_rearm_deferred_user_irq(unsigned long *tif_work, const unsigned long tif
      static __always_inline void hrtimer_rearm_deferred_tif(unsigned long tif_work)
    @@ include/linux/hrtimer_rearm.h: static __always_inline bool hrtimer_test_and_clea
      
      #else  /* CONFIG_HRTIMER_REARM_DEFERRED */
      static __always_inline void __hrtimer_rearm_deferred(void) { }
    -+static __always_inline void hrtimer_rearm_deferred_kcov_paused(void) { }
    ++#define hrtimer_rearm_deferred_kcov_paused()	__hrtimer_rearm_deferred()
      static __always_inline void hrtimer_rearm_deferred(void) { }
      static __always_inline void hrtimer_rearm_deferred_tif(unsigned long tif_work) { }
      static __always_inline bool
4:  8910122b4d6d ! 4:  07e20f89a5fb sched/core: Pause KCOV in __schedule()
    @@ Commit message
         KCOV_PAUSED remains set while a task is switched out. The guard in its
         resumed __schedule() frame restores the prior state.
     
    -    Assisted-by: LLM
         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## kernel/sched/core.c ##
     @@ kernel/sched/core.c: static void __sched notrace __schedule(int sched_mode)
      	int cpu;
      
     +	/* Callees instrumented with KCOV would leak coverage into current. */
    -+	guard(kcov_pause)();
    ++	kcov_pause_scope();
     +
      	/* Trace preemptions consistently with task switches */
      	trace_sched_entry_tp(sched_mode == SM_PREEMPT);
5:  5bb61ae630f7 ! 5:  ee6862d0659c sched/core: Pause KCOV in try_to_wake_up()
    @@ Commit message
         helpers instrumented with KCOV, such as kthread_is_per_cpu(), CPU
         capacity helpers and SCHED_HRTICK arming. They can record into current
         while in_task() is true.
     
    -    CONFIG_KCOV_SELFTEST exposes this under PREEMPT_RT. The interrupt
    -    selftest fails on x86_64 in kthread_is_per_cpu(): RT runs the timer
    -    softirq in a thread, so the wakeup runs in task context during the
    -    selftest's spin. The same helpers leak into non-RT syscall wakeups such
    -    as a pipe write waking a reader.
    +    During task-context wakeups such as a pipe write waking a reader, these
    +    helpers record coverage that depends on the target task and runqueue
    +    state into the waking task. Before commit feb5c9a2447a ("softirq:
    +    Preserve interrupt context on return from interrupt"), the IRQ-exit
    +    ktimersd wakeup under PREEMPT_RT also ran in task context and failed
    +    CONFIG_KCOV_SELFTEST in kthread_is_per_cpu().
     
    -    Pause the wakeup body with the kcov_pause guard. Take it before the
    +    Pause the wakeup body with kcov_pause_scope(). Take it before the
         preemption guard so preemption is re-enabled while KCOV remains paused.
         Wrapping only select_task_rq() would miss SCHED_HRTICK arming during
         enqueue.
     
    -    Assisted-by: LLM
         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## kernel/sched/core.c ##
     @@ kernel/sched/core.c: bool ttwu_state_match(struct task_struct *p, unsigned int s
       int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
       {
      +	/* Callees instrumented with KCOV would leak coverage into current. */
     -+	guard(kcov_pause)();
     ++	kcov_pause_scope();
       	guard(preempt)();
       	int cpu, success = 0;
      
6:  7c13bc0e78d5 ! 6:  95936d470e3d sched/core: Pause KCOV in wake_up_new_task()
    @@ Commit message
         The paths depend on runqueue and CPU state, so coverage varies between
         identical forks. Pause KCOV for the whole function, extending the
         scheduler exclusion to new-task wakeups.
     
    -    Assisted-by: LLM
         Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
     
      ## kernel/sched/core.c ##
     @@ kernel/sched/core.c: void wake_up_new_task(struct task_struct *p)
      	int wake_flags = WF_FORK;
      
     +	/* Callees instrumented with KCOV would leak coverage into current. */
    -+	guard(kcov_pause)();
    ++	kcov_pause_scope();
     +
      	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
      	WRITE_ONCE(p->__state, TASK_RUNNING);

base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
-- 
2.39.5
