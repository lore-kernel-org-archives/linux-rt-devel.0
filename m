Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071590;
	b=QEfzsxe6Nxy3VIr0SsZZHhJV/Vu/LDRh2WHsuzJ4/MR6Ea9fFjJ1/frEjdf/GCWq01yO
	 Mer/2GfBTYTKduJIglgQvdazM+RDEBaI06lkaCq1X0rnQYHKRnHkD7pdb4jg/20uu+NLg
	 n7uUvBUU7x4kKvMQsdcUZz8e1PYFb6A6UMsjkL72b2laGev1g7NKBmGyeXgr0Lmj30uxB
	 8lx1wDwQjORJU7tfQ64kt+TdnRq94au1qjYIFEidgqnmLnlHCZsFikSlFCox/5iZE3f00
	 Ud9Vu0XXCnEe7VykmB04uUSXQ9JpHidaoGhbGORvc6Difbjv9YzQfoZPXE0B0g3VPJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071590;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TIc6+YNxVXhGA8deHKYHd4FZyrT7f/jlj0igPXFCOsE=;
	b=u4qbhQauCz8OcJPA3i1a1DJfI7RLnP80uGoQRyZ29l9iMkY5zg2LWnpkMEggsbV7h0aT
	 bif5wK8+0P7cwLCufpfCzoF1cm40sDfRqppvKK0mL1CdLDm8UWJpq7T11c9ik2VD9Jjk0
	 oIgu8cZUj0P2g7wtqKyBCfze9p6OWrBJKmxuuUHw3WsiFEGwDMPPn0nCQsTd+hdXHUmEx
	 V0X2YGGhwwGTWmTiS+eum+TxBykKnPFfQPx+3nTYNOeSW6f1Hy4M7rvAiC0e8jDmzYARR
	 5rN0a5iIhX+P56aHJqnQhJyoKMpRuCJTyMZzZfmWJDr1BziBGA6IGO44VZfKFl9gSLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmniEiTx;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD269606A32C
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 17:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD269606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BmniEiTx
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-492f0a1b685so905907f8f.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 07 Nov 2026 09:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071588; x=1794676388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TIc6+YNxVXhGA8deHKYHd4FZyrT7f/jlj0igPXFCOsE=;
        b=BmniEiTxUYdWe0vDsyeUOzOtmP8IG+ykuDyOW1GPd7PaMOWMSF+tlR5v8Y45xUmLaZ
         iZa3+KrBi/4Df+Ft84cVnh5pfOa6QiAEn1k9M2+wA5TBuqgKQV/9n0mY9nNDvSkzQj+o
         Zf6mFvgXzUT2qEqffViM8C2/A8XRKESM3A4e/B6NIlO7X25im/11D2rlMOC68Gsk9tDt
         cRH0/h9fUvyDBph1oI3caJrhUVQ9t4auPHkYwVR2+0Zs0W6qnVqcF4pz80rSEyM6ceaQ
         9WeKM10q4OszomHEVM95dyrz50cvQ/BZ99oL8fDxn/Ka+ZUSo/rKJnFtdQFxSKKdMeeA
         yfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071588; x=1794676388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TIc6+YNxVXhGA8deHKYHd4FZyrT7f/jlj0igPXFCOsE=;
        b=gG+IYBmAaVZLK5OlI8ukbUfzBVo/FKh0ymTIgcH+c3YwpMj4KQ6IcznylNzY6Ky1IA
         9fks7ZrNkvo5hgqHT+x18+0QLNyKMJF3sn/nIsmlqfLDe+8ogNd5vt7lPcgYkAz23CKQ
         FG225c3W9U0C3jhEEgmNvvlSslqk3gNH8i+DEphVt/pcWbUlDu3sSEFJiODjIiM5y37h
         6mub7ImRpxKDtd1xkIrsfRZeXpe1omDXF9kKZ8b2naQHqaZj5Q9QDgRDLu7CG5KYBmrg
         ZocDcYtr1Ap9RXCwaRxuij+P3ojAeXPbziYJzfGYPTaVgdajqnZ6oAZegTe/sAKswmE0
         JfJA==
X-Forwarded-Encrypted: i=1; AL+hErGIBh1e7QD22D2wi4OS2MkCL85QC02b8x/mEic21q+BmZRSrcdbp70M/Nz7u5xlIJWf1lJYFcKq/Y7RZaCAkg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+P7neklJQ9WvHKmNS7xo9lsVntL82nvWN2Vr4crbJBr58siGnc
	MF886b9hZVgSf7OR+o5dLGgmG+iFFA6T9ecQyHPXL/zEtDPyu8hOn8xC
X-Gm-Gg: AYBFou31/PzVyasp3Ct0uNrpVflyUHkXLfxT6HeNI4Xfz3Pd2V52Yev/Yo3C69MKxr9
	eVJ241oDwVwr5b4nbRUndSJCxRSYzbj1pWCgADUS72RebKjca0RuoGW1B2ujDVpreS+k1LKXaWN
	IRAZ8DKKlORoZTroqYl3peUnSmTkw4sVzoGXLFGugC2Rjrp151rhq8el0WLAf7MEM38yA9PjWMV
	AXpcVErWOhUNul2xwZ+4MnJULkjfRYDtzRTeOi7USIQRNeTpixtXqZEMkSpP3NptXbNGr4dqZrl
	rxtBcItDb7upEQ31R8nz6TNHcvEI+n6hosKtijGXUI29GQJzEbDnUpki1R5jHKfSGYn0if5zSt4
	Ck8FW3eVpoiLle+N9xOx07m3DPZi8PrsFUa9fek+0LepuGytfRBUDrO9LvI6PIjM6YnUWej2fHK
	WPzkrzDtTdEkKtZaaLy5Uz5KzdXKfyidosUjQd7SqIdk7C5DiqelD8q2NplMrz9WXj0XeRbCsA1
	n1nZuwGdAn/dMDwmT+fIaeQvSsTAobH18tfrpSse8pMioVkZotE68NiMmIs0mRdci1Ur75+YLSC
	4lSK4zEHzhmq5uswZca+ydUjudx/FDk9a7uWhEdNgDdUAKKV1vICGxsKqTk6HI87lGkTryBIki2
	qppR2Ix1Njy7JNumBd4iKsD4AB2+BIKQsqAI7eq3bpLYoovinrRVhg/8tIOs5UFH8kGD5bd/rxv
	/itE9qnGtK3AmCbPma5ljEXWwWachWOPA=
X-Received: by 2002:a05:6000:490d:b0:48f:fcac:a5e2 with SMTP id ffacd0b85a97d-49277404453mr10990954f8f.38.1794071587759;
        Sat, 07 Nov 2026 09:13:07 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d723222fsm10627105f8f.21.2026.11.07.09.13.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 09:13:06 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Wen Yang <wen.yang@linux.dev>,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/9] rv: Verify generic IRQ context transitions
Date: Sat,  7 Nov 2026 18:12:43 +0100
Message-Id: <20261107171252.25090-1-kmehltretter@gmail.com>
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

IRQ action tracepoints describe handlers, but not the lifetime of the
enclosing IRQ context. One context may run several actions, and an action
may be dispatched outside hardirq context. PREEMPT_RT may also enter
serving-softirq state without invoking an action. This leaves no generic
event stream from which an RV monitor can check IRQ-context transitions.

This RFC adds tracepoints at the generic hardirq and serving-softirq
boundaries. The irq:irqstate RV monitor checks their order and agreement
with live kernel state. irq:irqexit follows the owner of a
preempt_schedule_irq() invocation across task switches and CPU migration.

The hardirq tracepoints cover paths through irq_enter() or
irq_enter_rcu() and their matching exits. They do not cover direct
__irq_enter() and __irq_exit() users, raw paths, or architecture-specific
entry and return intervals. irqexit covers preempt_schedule_irq(), not
the complete interrupt-return path.

Boundary callbacks can raise softirq work after the pending-work check.
The series wakes ksoftirqd or ktimerd for remaining work. KUnit covers
nesting, monitor synchronization, PREEMPT_RT worker intervals, provenance
and late-work handoff.

Gabriele answered two of the v1 questions [1]:

  - The boundaries are now bare DECLARE_TRACE() tracepoints like the
    existing RV hooks in include/trace/events/sched.h, so they add no
    tracefs ABI.
  - irqstate and irqexit stay separate automata because one is per-CPU
    and the other per-task. A hardirq or non-RT softirq belongs to the
    CPU it interrupts. A preempt_schedule_irq() invocation belongs to
    the interrupted task, several tasks can be inside one at the same
    time, and it can migrate before it returns. Each RV automaton has a
    single monitor type. Both now sit under an irq container, so they
    are enabled together by default, and the irqentry/irqexit naming
    clash is gone.

Questions still open from v1:

  1. Are dedicated scheduler tracepoints the right way to follow
     preempt_schedule_irq() across task switches and migration?
  2. Is the KUnit-only hook for an empty ksoftirqd invocation
     acceptable? Outside a KUnit run, its worker checks take a disabled
     static-key path.

Patches 1-5 add the tracepoints, monitors and documentation. Patches 6-9
add KUnit coverage.

The series is based on v7.4-rc1, which contains the v1 prerequisite and
Wen Yang's reactor lockdep fix:

  commit feb5c9a2447a ("softirq: Preserve interrupt context on return from interrupt")
  commit 39ccedfd9e55 ("rv: Use LD_WAIT_SPIN as the reactor lockdep wait type")

The series is independent of the early-hardirq series [2], which
installs hardirq state before entry tracing. Both change
kernel/softirq.c, so applying one on top of the other needs a small
conflict resolution in __irq_exit_rcu().

Changes since v1:

  - Use bare DECLARE_TRACE() tracepoints instead of trace events
    (Gabriele)
  - Rename the irqentry container to irq (Gabriele)
  - Add text schematics of both models to the documentation (Gabriele)
  - Document why irqstate and irqexit are separate automata
  - Rebase onto v7.4-rc1

Testing on v7.4-rc1 with Clang 23.1.5, GCC 14.2 (x86) and GCC 16.2
(cross), and QEMU 10.0 TCG, with lockdep and the locking selftests:

  - Each patch builds with W=1 on x86_64 without new warnings.
    RV_MONITORS_KUNIT_TEST=m builds on x86_64 and arm64. kernel-doc
    reports no warnings for the changed headers.
  - The rv_mon KUnit suite and the reactor suites passed without
    failures on:

      x86_64   PREEMPT SMP4 and UP, PREEMPT with nohz_full=1-3 and
               threadirqs, PREEMPT_RT SMP4, PREEMPT_RT SMP8 with
               nohz_full=1-3
      arm64    PREEMPT, PREEMPT with nohz_full=1-3 and threadirqs,
               PREEMPT_RT, PREEMPT_RT SMP8 with nohz_full=1-3
      riscv64  PREEMPT
      ARMv7    UP

    Each configuration ran 13 to 21 of the 29 rv_mon cases. The others
    are skipped because they need a different configuration.
  - RV=n kernels boot on x86_64 and arm64.
  - On top of the early-hardirq series, the same suites passed on
    x86_64 (PREEMPT, PREEMPT_RT), arm64 (PREEMPT, PREEMPT_RT) and
    riscv64.

An LLM assisted with the patches and the testing.

v1: https://lore.kernel.org/all/20261022050712.75035-1-kmehltretter@gmail.com/

[1] https://lore.kernel.org/all/FACA54EC-F846-4051-9ADD-DB46E7665FAD@redhat.com/
[2] https://lore.kernel.org/all/20261028033127.82193-1-kmehltretter@gmail.com/

Karl Mehltretter (9):
  tracing/irq: Add generic IRQ context boundary tracepoints
  tracing/sched: Add IRQ preemption lifecycle tracepoints
  rv: Add a monitor for generic IRQ context transitions
  rv: Add a monitor for IRQ-exit scheduling ownership
  docs/rv: Document the IRQ monitors
  rv: Add KUnit coverage for IRQ context transitions
  rv: Add KUnit coverage for IRQ-exit scheduling
  rv: Test empty PREEMPT_RT softirq worker intervals
  rv: Test IRQ-exit softirq provenance and handoff

 Documentation/trace/rv/index.rst              |    1 +
 Documentation/trace/rv/monitor_irq.rst        |  475 ++++
 include/linux/interrupt.h                     |    8 +
 include/rv/kunit.h                            |   34 +-
 include/trace/events/irq.h                    |   56 +
 include/trace/events/sched.h                  |   26 +
 kernel/sched/core.c                           |    6 +
 kernel/softirq.c                              |  324 ++-
 kernel/trace/rv/Kconfig                       |   11 +-
 kernel/trace/rv/Makefile                      |    3 +
 kernel/trace/rv/monitors/irq/Kconfig          |   13 +
 kernel/trace/rv/monitors/irq/irq.c            |   35 +
 kernel/trace/rv/monitors/irq/irq.h            |    3 +
 kernel/trace/rv/monitors/irqexit/Kconfig      |   14 +
 kernel/trace/rv/monitors/irqexit/irqexit.c    |  172 ++
 kernel/trace/rv/monitors/irqexit/irqexit.h    |   85 +
 .../trace/rv/monitors/irqexit/irqexit_kunit.c |  540 ++++
 .../trace/rv/monitors/irqexit/irqexit_kunit.h |   21 +
 .../trace/rv/monitors/irqexit/irqexit_trace.h |   19 +
 kernel/trace/rv/monitors/irqstate/Kconfig     |   14 +
 kernel/trace/rv/monitors/irqstate/irqstate.c  |  289 ++
 kernel/trace/rv/monitors/irqstate/irqstate.h  |  139 +
 .../rv/monitors/irqstate/irqstate_kunit.c     | 2339 +++++++++++++++++
 .../rv/monitors/irqstate/irqstate_kunit.h     |   25 +
 .../rv/monitors/irqstate/irqstate_trace.h     |   15 +
 kernel/trace/rv/rv_monitors_test.c            |   30 +
 kernel/trace/rv/rv_trace.h                    |    2 +
 tools/verification/models/irq/irqexit.dot     |   21 +
 tools/verification/models/irq/irqstate.dot    |   32 +
 29 files changed, 4737 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_irq.rst
 create mode 100644 kernel/trace/rv/monitors/irq/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irq/irq.c
 create mode 100644 kernel/trace/rv/monitors/irq/irq.h
 create mode 100644 kernel/trace/rv/monitors/irqexit/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.c
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit.h
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.c
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_kunit.h
 create mode 100644 kernel/trace/rv/monitors/irqexit/irqexit_trace.h
 create mode 100644 kernel/trace/rv/monitors/irqstate/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.c
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate.h
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit.c
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_kunit.h
 create mode 100644 kernel/trace/rv/monitors/irqstate/irqstate_trace.h
 create mode 100644 tools/verification/models/irq/irqexit.dot
 create mode 100644 tools/verification/models/irq/irqstate.dot


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.39.5 (Apple Git-154)

