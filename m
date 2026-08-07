Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3942BE043
	for <linux-rt-devel@lists.linux.dev>; Fri,  7 Aug 2026 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119579; cv=none; b=IKjlcNSNXWF1Fx181cMgbLLSo7NlIYr+9/iQqosm7c5pO21qPe9FYcCoSvmWMRPuTYc2TAWoXAu3bZj0jNOU5DqUIvxLmq4MNcSRZjjXzf3w4kGw5KpQbpdq62HDwUNwpbFXrvidAbZg99ELS/cRfJnRvcErsiwSyBPPbUmBVGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119579; c=relaxed/simple;
	bh=dEpKf7v329BrXdPs9AJn8DwSnEo1KjYommT4Au6roLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fB/atLhFf2B7jhdPvHCLxNopblI2ZPqi1S7xo76kg3O7p2z6SpSqk7HGu9NRCO95mewqwtjE8sy0MnhiP1ePZ37ZnrTodEEQ+t/wc1ZbWFYhSadioyBx2qQ2+M+yGF91sHVtXJQ0c7ZyJIqGZVwfu+zGjWLEnqEcyvlugpn7Bl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHtuEb5X; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHtuEb5X"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8486672f03cso4363683b3a.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 07 Aug 2026 09:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786119577; x=1786724377; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fM3zY6Yx/Bjknh43MLjZGdkrP5Xjj8XZi4L5KKoZ5Gk=;
        b=nHtuEb5XiAJSKn1caM6yU4nGxW/0Pp1McV5cVoNRDh2d2pTEx1ldsA8kbo6M2H4++I
         8g27FXtaRcGRsgGS1N4xYEjpOiW9R2OUYx5T5G9XJP1c1gFK8wpKOCHFIy0OZLxOWiAP
         xKo1EyUiyIagzfoHWoEf5g1cg6dyTReCundtK6S0s2R4YYm1yxIUUYm2ZJutBdfAgQ7i
         bjbIwH9dvYF44K4jI4t1kLtg0yizx4crbIrf0W8ehLc3b0I0TbFlPS4aY44EZhCB4xFT
         HS4QxMUi9Lk3pJlzfC4KwrUPIUgbBsMnB09n5TMdGZ/9lkbAMraorFZWc3hCzciIwr/o
         D5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786119577; x=1786724377;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fM3zY6Yx/Bjknh43MLjZGdkrP5Xjj8XZi4L5KKoZ5Gk=;
        b=pftswWK1WehJJbBdhdcZ7ICG5nAuaPGm6XZEpso3sX9o11SkA2dS76UO4p9tsaSMDF
         20zPQQEllQ1rl+rW+MPXQhj4slC2SCID/SMTLF0tHDtj3KuJf0JxzEEwKM8eswrm4dIw
         CwRE1f1AnqkslZlRJouQtUIEtx8bwyB64P9JnvW6gVFmxMlO55O///fo4jvPBDmRIhzt
         jDchXU6Ah1UkLBD4WbCk1qzvUV5qOg+kd58mU6BksaKTHotvKTuedmQ/BURau2z3vgnG
         5PrJR1cxNZvbh8/oYBcqna0b6QKbkYLpi0jVggSQYal97NuYSgnlD9+wy0QwmamNZT/H
         rrGQ==
X-Forwarded-Encrypted: i=1; AHgh+RpEc95En8OAz8FgYmGr1HNm0xo/yhWcLQSWcP6HZuUORmHxgnSqPp7s1grGYfe/+/G72TzsAuQZXLadSpRr2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyiYhDhpJN0X0q3BvWLYCIsP70xa9aqsmjk+jCz+O/ix6TxYfeW
	5IrMQGcP5L2TPO20n52Wg9Y1+5seN1TZrsXNW8doZuBPtnXK1V+PMpBq
X-Gm-Gg: AR+sD10aPYR+1yNYNQ3PfmFYBjEvyfdLQZzieKAp/dzOCG4ThP9t3YbYuV7NHpDpulh
	yvsSK+A4UskGlg09t6N71gGDioCKrYQM3HjgTU9mDaKAN+ZIeCeRGEeR8fy+qzlgnQuMr3OMu+A
	wi0bN9zYpuVUmnZ07LQKPb4kOv0ypJqR2/NQMFG/NA11oJVloCetQoWY39ZvK50b4cWn4gcRmWY
	zGmW6AVPR5M1TGrJtHZKJ0Qnj2IO5BVIqj/DSSvIso9yngTuwqC5KmEfS2MXn2OY3PcnfZ3uNQU
	iksVhYNByXShNig83d+gKHc5gt6vTl0P1U2zaIYMikBGUuibjX7U0y+FxjlNRS5Eq6lRg9ml2iM
	XyzA/arxT29vK/s2wRdRYHo+AA6Oncy0XeKg6lOnlzjUtEHLDgxVh042p1rfGms6DPZIR43lTEf
	ty5SipAmRc4GTt+hkpr8rjoTWahYSUsF5JXquiFvjHlZ7ypnVzB1U1xDJoPxl+HSEnEQzbMDbNj
	w==
X-Received: by 2002:a05:6a00:3cce:b0:847:711f:49ab with SMTP id d2e1a72fcca58-84f2e006c85mr24601093b3a.22.1786119576732;
        Fri, 07 Aug 2026 09:19:36 -0700 (PDT)
Received: from localhost ([220.196.228.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3a1911sm1285011b3a.3.2026.08.07.09.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:19:36 -0700 (PDT)
From: Liang Hao <haohlliang@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Liang Hao <haohlliang@gmail.com>
Subject: [PATCH] docs: timers: hrtimers: clarify expiry modes and ktimersd on PREEMPT_RT
Date: Sat,  8 Aug 2026 00:19:29 +0800
Message-ID: <20260807161929.49913-1-haohlliang@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/timers/hrtimers.rst described the high-resolution timer
subsystem but did not cover the PREEMPT_RT expiry-mode semantics.  On a
PREEMPT_RT kernel a timer that is not explicitly marked
HRTIMER_MODE_HARD is forced into softirq expiry and its callback runs on
the per-CPU ktimers/%u thread at SCHED_FIFO priority 1, regardless of
the priority of the task that armed it -- a SCHED_FIFO task's priority
does not extend into its timer callback.  This is a recurring source of
hard-to-diagnose latency for RT/DL authors who assume the opposite.

Add a dedicated "Expiry modes and PREEMPT_RT" section that documents:

 - the distinction between HRTIMER_MODE_HARD and HRTIMER_MODE_SOFT;
 - the fact that unmarked timers are forced into softirq expiry on
   PREEMPT_RT (__hrtimer_setup());
 - the role of the per-CPU ktimers/%u thread and its fixed SCHED_FIFO
   priority 1 (sched_set_fifo_low());
 - the absence of priority inheritance between the arming task and the
   timer callback on RT;
 - the sleeper exception, where hrtimer_setup_sleeper() automatically
   marks RT/DL-armed timers HRTIMER_MODE_HARD
   (__hrtimer_setup_sleeper());
 - the critical distinction between the *requested* expiry mode (passed
   by the caller) and the *effective* execution context (chosen by the
   kernel and stored in timer->is_soft).

The hrtimer_start tracepoint logs the *requested* mode, not the
effective one.  On PREEMPT_RT a timer armed with the default mode
(e.g. ABS or REL without HARD/SOFT flags) is implicitly forced into
softirq expiry, so the effective soft nature must be inferred from the
*absence* of explicit mode flags in the trace rather than read directly.

Documentation only; no code or behaviour change.

Signed-off-by: Liang Hao <haohlliang@gmail.com>
---
 Documentation/timers/hrtimers.rst | 66 +++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/timers/hrtimers.rst b/Documentation/timers/hrtimers.rst
index f88ff8bae89c..ff42377668c1 100644
--- a/Documentation/timers/hrtimers.rst
+++ b/Documentation/timers/hrtimers.rst
@@ -171,3 +171,69 @@ hrtimers-based high-resolution clock implementation, so the hrtimers
 code got a healthy amount of testing and use in practice.
 
 	Thomas Gleixner, Ingo Molnar
+
+
+Expiry modes and PREEMPT_RT
+---------------------------
+
+Each hrtimer carries an expiry mode that determines the execution context
+of its callback:
+
+  * ``HRTIMER_MODE_HARD`` -- the callback runs in hard interrupt context.
+    It must be hardirq-safe (no sleeping locks, no allocations, no
+    scheduling).
+  * ``HRTIMER_MODE_SOFT`` -- the callback runs in softirq context and may
+    use operations that are not hardirq-safe.
+  * Default (neither flag) -- the mode is selected by the subsystem or
+    the kernel configuration.
+
+On ``CONFIG_PREEMPT_RT`` the choice is not optional for most timers:
+any timer not explicitly marked ``HRTIMER_MODE_HARD`` is forced into
+softirq expiry (see ``__hrtimer_setup()``). Instead of executing in
+hardirq context or within the context of the task that armed it, the
+callback runs on the per-CPU ``ktimers/%u`` thread.
+
+The ``ktimersd`` thread operates at ``SCHED_FIFO`` priority 1 (established
+via ``sched_set_fifo_low()``). This priority is fixed and **does not
+inherit the priority of the task that armed the timer**. The effective
+execution context is determined internally by the hrtimer subsystem at
+setup time and is reflected in ``timer->is_soft``; it is not directly
+visible as a mode flag at arming time.
+
+Consequently, even if a timer is armed by a ``SCHED_FIFO`` task with
+priority 99, its callback will execute only when the ``ktimersd`` thread
+(priority 1) is selected to run.
+
+This design ensures that timer processing does not interfere with
+higher-priority real-time workloads, while still providing bounded
+latency relative to ``SCHED_OTHER`` tasks. However, it also means that
+latency-sensitive processing must not rely on implicit priority
+inheritance through the timer arming path.
+
+A notable exception is the sleeper path: a timer set up via
+``hrtimer_setup_sleeper()`` (used by ``clock_nanosleep()`` and similar)
+that is armed by an RT or DEADLINE task is automatically marked
+``HRTIMER_MODE_HARD``, so its wakeup runs in hardirq context and does
+not go through ``ktimersd`` (see ``__hrtimer_setup_sleeper()``).
+
+**Guidelines for RT authors:**
+
+- If the timer callback contains logic that must execute at the priority
+  of the owning RT task, the timer must be declared as
+  ``HRTIMER_MODE_HARD``. Ensure the callback adheres to hardirq context
+  constraints.
+- Alternatively, move the latency-sensitive logic out of the timer
+  callback and into a dedicated, properly prioritized kthread which is
+  woken by the timer.
+
+**Debugging context:** The ``hrtimer_start`` tracepoint logs the
+*requested* expiry mode passed by the caller (e.g. ``ABS``, ``REL``,
+``ABS|HARD``), not the effective mode chosen by the kernel. On
+PREEMPT_RT, any timer armed with the default mode (i.e. the trace shows
+``ABS`` or ``REL`` without ``|SOFT`` or ``|HARD``) is implicitly forced
+into softirq expiry. When such a timer is armed by an RT or DEADLINE
+task, the consequence -- the callback running at ``ktimersd`` priority
+rather than the arming task's -- is the case to watch. The effective
+soft nature of such timers is inferred from the *absence* of an explicit
+mode flag in the trace, combined with the ``CONFIG_PREEMPT_RT``
+configuration.
-- 
2.50.1 (Apple Git-155)

