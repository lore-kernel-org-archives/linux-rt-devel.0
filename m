Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792645649;
	b=QCA8/B+r+dJDQPepR0jvPt5iK/1rR0p4F+xBiF5dZUx84s0a7AvDGjIhKKxKEfH0mHG4
	 gwHmF4/fscDVLg2NJiRqmGk18swYXAD0QxBpR2hRSyMKwvM/GMVehYmzY2Qf4f+GXrth0
	 4VmQTjVSm9RFJ5sKuzf41JTUkjw7O73TZ/KwsNDsH7cgRTCGYofo0XqvaBBGCWuzEAMYM
	 iZK3VGK8I08dey1knW5mive4zpdi6QO3rBpVuhU+B50Px/HwtT4dtnjT5yTvEoGnDP0RM
	 fxt7lXYbtmutjxeZhoGTvQNVyOp9wNjOy9WxHyRDhIT1Q4TOapzI79Y6gCO5qEybfQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792645649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KKy+ja1fSybZTSaoVcplsHwk3DZqhgSOeUQYBnw8jvg=;
	b=U8kT0ZIxzZP1s5tpq2DCd1/nGNgucQPKpj+4SKRMoCznb7Z1MyrsmjdA073e0EFgFv/k
	 CRNI5SlKslRgzk4+FH5T3i4Nruo1dGdWskeRwKzkSwHmcgg2eghqG+UWy//kkLx4uzSpw
	 HyLO5a9k/R8RRkzqthuRxnPvZpTPtGgBn+2RsSiNbAQGIr67P8JTZMmzbr9hrKdQvVzys
	 EP5XUedAwwyjycY93LELW2s5giksehAs1p9xBnM53018hKrIDeYlyNRbge0DISsjcAPWG
	 WYwyzBezLXZcZnM9ClbSyJUZQBqE7mBDXKkpDu9MjTzUzHrZg2dZ9UyBAJc1WUtvbkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O6+ViVuK;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99EA7606A31D
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Oct 2026 05:07:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99EA7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O6+ViVuK
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2001dd4e7so13972725e9.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 22:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792645647; x=1793250447; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKy+ja1fSybZTSaoVcplsHwk3DZqhgSOeUQYBnw8jvg=;
        b=O6+ViVuK72UiUTVeKw2b8hsP7xEC/pTljERQVNxUs/Sz57q2OZtaoKxkJUHlmhwohi
         EmyLQKz9/uI+p+Ud27KAFBdVeyPVeX9WsYwVEI5RnQwHI+yHvSL5Yl0qkVlIkLeAnquQ
         Euwaw8hobbOcP4ebNn0TK7yrMTi/CMdbbtfVlGILAjSkiRJzPqEZLN00Av9nAXERyCWB
         b764l/IILCt7xxnEMaN8EKzgAXsstT1O+BjvCCA0R9ta+482ZTUaPIn7qPBzQw5l05+H
         0Q4gHYfo55sZ6tNH1fBRMGwpfloBTtdTzCeGC2KpMSAi3tXgvvBLPI9JPrJJ9VH6g34u
         kZfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792645647; x=1793250447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KKy+ja1fSybZTSaoVcplsHwk3DZqhgSOeUQYBnw8jvg=;
        b=qdzVdtZInuxZpiZGdbhXkFTmoaegzBLnYSLV8XsQZ2hUZ+V8lYbDL8oqi9VsEYQ72E
         mAl41Pg9J1VVgV4LbR1bOpvj2M7cQ3QGH1AkDxbH7eA+LkyhcB6MbCJ7LkkKwMPRLg2L
         Nc5Z5HTgBUWDFEfIQjs50M3enwxC8kU9EiXy+6fU0KLHYBHGcyxyL2+CQkJjEi3eP6wU
         l1LXLAdPnq+xv4uI1veEoA48D7njA7VvfUNqh4r5hl18bG9j3YOV65axNDRHqK+KhASB
         U28u9fhEvXrYBpQgAWLh/hK2EEA0iO1+eSa1OYTZOhsW2dCITftIEo7lNEBVW76LGceS
         yQ0A==
X-Forwarded-Encrypted: i=1; AKwUvBxMlQa4o4JqrokFax6Pu2D1GOetR8gM4wuFqFn38uwFCM3Y6CcNnApnLbLdqpVgIWPD5I9M/BiSArCzSPs8Fg==@lists.linux.dev
X-Gm-Message-State: AFq9FYIHaxljAF8Zhj+jsys8pCaB3g8sWbYntc+IperhFzwhUnwFGoCc
	f1fn90ydL1oVNMwTsVYuB+/86c2WsqBuOtLJhgFpx5gVMe6SXTngw3Lx
X-Gm-Gg: AYBFou3ZhGdG0Dd4sKm+rQzVO8ymjsstmMOmLrdf6rJXqfXrYNdiPPdw+XrDNchC8Jh
	rBvOeWlINs/M2nPRdIVPgr5FPQ+yx58RUDks/ahHnwgVxFI7t9QPw3h7VUR5Co41eRfpGnfmUWF
	SKNj+fd5AlXZ95CU3/uHZgVGzUToL1vlqPjCVNc4RkE9cCg5iim33Qq8Bxw3t1pazeVa+LRR1hq
	ILmca6vsa9qlYe0ogdLdcEeubQxZXxTtrLsIOztRhjWaJRBLRW3QYhEczq2YRuG7LXEaxAV7lvt
	lx9agXFk3tBu8EI2h6yaridkGbH5tsb1+jXeAbN3l52hI40HqOTs8VQVCJhZze0w04V8mKjMlro
	m/WXE7PobK3qV3s8sDsamAEaJvGkp1GBwF6leF9PBJPlda8xHlk1hgJcCUFbModDZuxsGOOnYpT
	MuKIg+j1wok1jQpb0BinjOfgTud0hxFGUE62WPJEsm95IuP4JpfvZMTVgWp2i281chXeAEBaeSz
	s5q+IJcYUZMzDrUbARES1FAuja7jitXAVSr3U4fldvaqf54+Ck6i+talcbws4rYkHWgq17jECDx
	i8zQy8AuY5OWpBAVecECcNzTAqM9nYwEXJj5vEECXfukjT0kL+cFglS4pL83mwrYd8jpurVhrMR
	NvQGgyDH57JMu8wW1DciuHhC34HcAzyuUpaN54tY67kfjCqmpYzp3Jt/M7d0=
X-Received: by 2002:a05:600c:4585:b0:4a1:acaa:9d4c with SMTP id 5b1f17b1804b1-4a1fdb20774mr81702295e9.25.1792645646631;
        Wed, 21 Oct 2026 22:07:26 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-ad43-d501-2c28-bb72-120d-420e.310.pool.telefonica.de. [2a02:3100:ad43:d501:2c28:bb72:120d:420e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254eeef6sm9994979f8f.8.2026.10.21.22.07.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 22:07:25 -0700 (PDT)
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
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/9] rv: Verify generic IRQ context transitions
Date: Thu, 22 Oct 2026 07:07:03 +0200
Message-Id: <20261022050712.75035-1-kmehltretter@gmail.com>
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

This RFC adds events at the generic hardirq and serving-softirq
boundaries. The irqstate RV monitor checks their order and agreement with
live kernel state. irqexit follows the owner of a preempt_schedule_irq()
invocation across task switches and CPU migration.

The hardirq events cover paths through irq_enter() or irq_enter_rcu() and
their matching exits. They do not cover direct __irq_enter() and
__irq_exit() users, raw paths, or architecture-specific entry and return
intervals. irqexit covers preempt_schedule_irq(), not the complete
interrupt-return path.

Boundary callbacks can raise softirq work after the pending-work check.
The series wakes ksoftirqd or ktimerd for remaining work. KUnit covers
nesting, monitor synchronization, PREEMPT_RT worker intervals, provenance
and late-work handoff.

Cross-architecture RV KUnit testing also exposed an Arm-specific opid bug:

  https://lore.kernel.org/r/20261020035158.90190-1-kmehltretter@gmail.com

I would especially appreciate feedback on:

  1. Should the context boundaries be trace events or private RV
     instrumentation?
  2. Are dedicated scheduler events the right way to follow
     preempt_schedule_irq() across task switches and migration?
  3. Should irqstate and irqexit remain separate monitors?
  4. Is the KUnit-only hook for an empty ksoftirqd invocation acceptable?
     Outside a KUnit run, its worker checks take a disabled static-key
     path.

Patches 1-5 add the events, monitors, and documentation. Patches 6-9 add
KUnit coverage.

This series is based on v7.3 (c03c1a14507d) and depends on the following
accepted change, which is not included:

  softirq: Preserve interrupt context on return from interrupt
  https://lore.kernel.org/r/20261011060742.30584-1-kmehltretter@gmail.com

A pre-existing issue can make rv_test_dummy intermittently report a
false-positive invalid-wait-context warning under lockdep. Wen Yang has
posted a fix:

  https://lore.kernel.org/lkml/5586dd00789a0f904cc299cd8889744b8c6f8dc9.1789412799.git.wen.yang@linux.dev/

This series does not include that fix.

Karl Mehltretter (9):
  tracing/irq: Add generic IRQ context boundary events
  tracing/sched: Add IRQ preemption lifecycle events
  rv: Add a monitor for generic IRQ context transitions
  rv: Add a monitor for IRQ-exit scheduling ownership
  docs/rv: Document the IRQ-entry monitors
  rv: Add KUnit coverage for IRQ context transitions
  rv: Add KUnit coverage for IRQ-exit scheduling
  rv: Test empty PREEMPT_RT softirq worker intervals
  rv: Test IRQ-exit softirq provenance and handoff

 Documentation/trace/rv/index.rst              |    1 +
 Documentation/trace/rv/monitor_irqentry.rst   |  398 ++++
 include/linux/interrupt.h                     |    7 +
 include/rv/kunit.h                            |   34 +-
 include/trace/events/irq.h                    |   70 +
 include/trace/events/sched.h                  |   51 +
 kernel/sched/core.c                           |    6 +
 kernel/softirq.c                              |  308 ++-
 kernel/trace/rv/Kconfig                       |    5 +
 kernel/trace/rv/Makefile                      |    3 +
 kernel/trace/rv/monitors/irqentry/Kconfig     |   13 +
 kernel/trace/rv/monitors/irqentry/irqentry.c  |   35 +
 kernel/trace/rv/monitors/irqentry/irqentry.h  |    3 +
 kernel/trace/rv/monitors/irqexit/Kconfig      |   14 +
 kernel/trace/rv/monitors/irqexit/irqexit.c    |  172 ++
 kernel/trace/rv/monitors/irqexit/irqexit.h    |   85 +
 .../trace/rv/monitors/irqexit/irqexit_kunit.c |  537 +++++
 .../trace/rv/monitors/irqexit/irqexit_kunit.h |   21 +
 .../trace/rv/monitors/irqexit/irqexit_trace.h |   19 +
 kernel/trace/rv/monitors/irqstate/Kconfig     |   14 +
 kernel/trace/rv/monitors/irqstate/irqstate.c  |  289 +++
 kernel/trace/rv/monitors/irqstate/irqstate.h  |  139 ++
 .../rv/monitors/irqstate/irqstate_kunit.c     | 2062 +++++++++++++++++
 .../rv/monitors/irqstate/irqstate_kunit.h     |   25 +
 .../rv/monitors/irqstate/irqstate_trace.h     |   15 +
 kernel/trace/rv/rv_monitors_test.c            |   29 +
 kernel/trace/rv/rv_trace.h                    |    2 +
 .../verification/models/irqentry/irqexit.dot  |   21 +
 .../verification/models/irqentry/irqstate.dot |   32 +
 29 files changed, 4397 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_irqentry.rst
 create mode 100644 kernel/trace/rv/monitors/irqentry/Kconfig
 create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.c
 create mode 100644 kernel/trace/rv/monitors/irqentry/irqentry.h
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
 create mode 100644 tools/verification/models/irqentry/irqexit.dot
 create mode 100644 tools/verification/models/irqentry/irqstate.dot

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
prerequisite-patch-id: 6ac7167f0aa7c5319dac78bf5b06a989fd7dfac5
-- 
2.39.5 (Apple Git-154)

