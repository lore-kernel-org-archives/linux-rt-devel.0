Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EC61C5D7D
	for <linux-rt-devel@lists.linux.dev>; Sat, 16 Aug 2025 03:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755314234; cv=none; b=uAfbpQFGZdF8n4i6JqLpIGYNF+paAeW0PUolzvZQdTUOo3TzibB7ukBZc5La7OoimylbTi7UBUnOU/qQvxcYXML/emwZdvbWg36doEpJldyr5XdJ+m/WkClLqKebOqaj/7gHrAtcgiZjc1/R/ON8DrbBWhBIM25WZLZbYhDE8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755314234; c=relaxed/simple;
	bh=Lp1p/pE3gSmvjQq4yl/RaA3McLjGCT9Trs3+pVw+vAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=acigpr5xXXEIRlUj7n+mjnAz0rR+SjM+IlTzQ2b+/ssskY969oZGhiKtpvSVVUwUBotXFuy8GPtgFjfVWJQnYGFozQ16n/nO2Y4sSwHMxJAHqXt8yl2NHkSvv1JpiEKcSzu3wh9ycl2FSPKR/ywm0ivWyDdGDDOkcRLxOjjtTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kzalloc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b47170382a5so150891a12.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 15 Aug 2025 20:17:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755314232; x=1755919032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mo5uTjXLm9+e7BCFnkcEfOBnW1irWkf9Z7K6w05vMAc=;
        b=V0+sOHXYxC/M484fx0rDbR1J60TGuMB1V0nu6qmZonXV727WfkmYXOjghlmW82P4gK
         gb+3TXcm6wEhfPT6NFckHRJVDH3L/DnlIfNiyS+XI5r/fhUQgplt5nk7xVX7pJSwnG1M
         c0c12AjztZD2r9/W0Ck9oxW0VqmbcodOCvIbuQAS5ffT82Iij2c4vFjBtouRWuQnhfRS
         6KgtSA4sLBnzRkjNX1yy5fEqNr+4gsbuDaukDqRhAlAEjQ4H0wSicRS38Zw3oVnHBrfd
         kfWZXAxGQ2TIN+WlHkmDWcWv7xMvVovyneaCT4nTJuLYIpBZop7F2vWW/suQbkRh9/b+
         0qsA==
X-Forwarded-Encrypted: i=1; AJvYcCWXbsbswCjZuo5PWrrsfa/97y+mc6JKn3nLGr4fnmhm7YD2XSeXT35QesQ+QpxdG5XDjdHDyk1Sj8cdo2P1YA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz+p8P/o9oKFrYDwwJ6lI6hP8fs9YaMPK55V/hVCKeaDv1acEjA
	H8i5nlZ62Dq1S7U+3Z2QDlJ4Zvt1orzkb5FIzxzhpG5nKmGH6jWp82qI
X-Gm-Gg: ASbGncvMcBsyiP42tRFgqEJGTis30gYHYLVSyKxMexqRKC3QkBVJ857oJAQLQda9mBS
	BHoC60AZDdWQX+IGL1We5SckDZrjebFLXaACJ7sNNb3qn4NnB615gu/sgiI1G23JklExVeEutU4
	TNvCsQ9/mqUMPcr33m+ABVGCy8r4f4In1yXE1pZewTKzXzqVPg9wMzPsYvRTAVdYaJj9GbpCkxn
	f3UVyhHW4sefw/8KqlWmRXx8zOxtVyOI6YUvYWXtY0JwW78A0RZq4A2OLE40zQ/b2ttBvIqwbu5
	TZXlgprSAQRajJJWDranFO8det4cXvNrCBn/j+PolfTrpb0QUb4zRmCgGv22yXQkOvbPZ3q7Ee/
	d+XuB1kvKPeQ7
X-Google-Smtp-Source: AGHT+IHhgrqQBXd31zqrVLwdpvM48M0sC4bfy99ys9IoJddMaRjJlYwDc224E+3fKY7ZEsmxS+ZhIw==
X-Received: by 2002:a05:6a00:2ea0:b0:76b:d93a:69e3 with SMTP id d2e1a72fcca58-76e4456651amr2719790b3a.0.1755314231755;
        Fri, 15 Aug 2025 20:17:11 -0700 (PDT)
Received: from localhost ([218.152.98.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b473ce25dafsm118546a12.17.2025.08.15.20.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 20:17:11 -0700 (PDT)
From: Yunseong Kim <ysk@kzalloc.com>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	Gal Pressman <gal@nvidia.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Kees Cook <kees@kernel.org>,
	cocci@inria.fr,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <ysk@kzalloc.com>
Subject: [WIP] coccinelle: rt: Add coccicheck on sleep in atomic context on PREEMPT_RT
Date: Sat, 16 Aug 2025 03:16:57 +0000
Message-ID: <20250816031657.906569-1-ysk@kzalloc.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I'm working on a new Coccinelle script to detect sleep-in-atomic bugs in
PREEMPT_RT kernels. This script identifies calls to sleeping functions
(e.g., mutex_lock, msleep, kmalloc with GFP_KERNEL, spin_lock which may
sleep in PREEMPT_RT) within atomic contexts (e.g., raw_spin_lock,
preempt_disable, bit_spin_lock).

It supports both direct calls and indirect call chains through
inter-procedural analysis using function call graphs. Memory allocations
are handled including GFP_ATOMIC/NOWAIT. This is a WIP patch for early
feedback. I've tested it with make coccicheck on various subsystems, but
there are still issues with position variables sometimes being tuples,
leading to "Invalid position info" warnings and incomplete data collection.

The script includes defensive checks, but indirect bugs are not always
detected. I'd appreciate any suggestions on improving the Python handling
of position variables or the SmPL rules for better matching in complex code
(e.g., macros, inlines). The script is added to scripts/coccinelle/rt/.

Detects sleep-in-atomic bugs in PREEMPT_RT kernels by identifying improper
calls to functions that may sleep, such as mutex locks, explicit sleep
functions (e.g., msleep), memory allocations and sleepable spinlocks,
within atomic contexts created by preempt_disable, raw_spin_lock,
irq_disable (e.g. bit_spin_lock).

1. Detection of direct calls to sleeping functions in atomic scopes.
2. Analysis of inter-procedural call chains to uncover indirect calls to
   sleeping functions via function call graphs.
3. Handling of memory allocation functions that may sleep.
   (including GFP_ATOMIC).

This cocci script should identify direct and indirect sleep-in-atomic
violations, improving PREEMPT_RT compatibility across kernel code.
For example:
Link: https://lore.kernel.org/linux-rt-devel/7a68c944-0199-468e-a0f2-ae2a9f21225b@kzalloc.com/t/#u

I understand that it’s not working perfectly yet, but I’d like to ask how
we can make it more clearly indicated.

$ make coccicheck COCCI=../../scripts/coccinelle/rt/sleep_in_atomic.cocci MODE=report M=fs/gfs2 2>&1 | tee gfs2-rt.log

The final desired outcome is as follows.

  [!] BUG (Indirect): Function 'lockref_get_not_dead' can sleep and is called from an atomic context.
    - Sleep details:
      - spin_lock() at fs/gfs2/quota.c:XXX (is a sleeping lock on PREEMPT_RT)
    - Atomic call sites:
      - gfs2_qd_search_bucket at fs/gfs2/quota.c:YYY from atomic context at fs/gfs2/quota.c:ZZZ
    - Call paths to sleepers:
      - lockref_get_not_dead -> gfs2_qd_search_bucket -> spin_lock_bucket -> gfs2_quota_init

The current output looks as follows:
Link: https://gist.github.com/kzall0c/8d081b36f5f6b23498441007c8a835cd

Signed-off-by: Yunseong Kim <ysk@kzalloc.com>
---
 scripts/coccinelle/rt/sleep_in_atomic.cocci | 509 ++++++++++++++++++++
 1 file changed, 509 insertions(+)
 create mode 100644 scripts/coccinelle/rt/sleep_in_atomic.cocci

diff --git a/scripts/coccinelle/rt/sleep_in_atomic.cocci b/scripts/coccinelle/rt/sleep_in_atomic.cocci
new file mode 100644
index 000000000000..f675eeff5c34
--- /dev/null
+++ b/scripts/coccinelle/rt/sleep_in_atomic.cocci
@@ -0,0 +1,509 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// @description: Finds direct and inter-procedural calls to sleeping functions
+///   (including spin_lock in PREEMPT_RT) within atomic contexts, such as
+///   preemption or interrupt disabled regions. Detects two types of bugs:
+///   1. Direct: A sleeping function is called inside an atomic context.
+///   2. Indirect: A function called from an atomic context eventually calls
+///      a sleeping function through a chain of calls.
+///
+// Confidence: High
+// Copyright: (C) 2025 Yunseong Kim <ysk@kzalloc.com>
+// Options: --no-includes --include-headers
+
+virtual report
+
+// =========================================================================
+// 1. Main Rules to Find Violations
+// =========================================================================
+
+// --- PART 1: Direct (Intra-procedural) Violation Detection ---
+
+@find_direct_sleep_in_atomic@
+position p_atomic, p_call;
+identifier bad_func =~ "^(mutex_lock|mutex_lock_interruptible|mutex_lock_killable|down|down_interruptible|down_killable|down_trylock|rwsem_down_read|rwsem_down_write|ww_mutex_lock|msleep|ssleep|usleep_range|wait_for_completion|schedule|cond_resched|copy_from_user|copy_to_user|get_user|put_user|vmalloc|spin_lock|read_lock|write_lock)$";
+expression lock, flags;
+@@
+(
+  raw_spin_lock@p_atomic(...)
+| raw_spin_lock_irq@p_atomic(...)
+| raw_spin_lock_irqsave@p_atomic(...)
+| raw_spin_lock_bh@p_atomic(...)
+| raw_read_lock@p_atomic(...)
+| raw_read_lock_irq@p_atomic(...)
+| raw_read_lock_irqsave@p_atomic(...)
+| raw_read_lock_bh@p_atomic(...)
+| raw_write_lock@p_atomic(...)
+| raw_write_lock_irq@p_atomic(...)
+| raw_write_lock_irqsave@p_atomic(...)
+| raw_write_lock_bh@p_atomic(...)
+| preempt_disable@p_atomic()
+| local_irq_disable@p_atomic()
+| local_irq_save@p_atomic(...)
+| local_bh_disable@p_atomic()
+| bit_spin_lock@p_atomic(...)
+)
+<...
+  bad_func@p_call(...)
+...>
+(
+  raw_spin_unlock(lock)
+| raw_spin_unlock_irq(lock)
+| raw_spin_unlock_irqrestore(lock, flags)
+| raw_spin_unlock_bh(lock)
+| raw_read_unlock(lock)
+| raw_read_unlock_irq(lock)
+| raw_read_unlock_irqrestore(lock, flags)
+| raw_read_unlock_bh(lock)
+| raw_write_unlock(lock)
+| raw_write_unlock_irq(lock)
+| raw_write_unlock_irqrestore(lock, flags)
+| raw_write_unlock_bh(lock)
+| preempt_enable()
+| local_irq_enable()
+| local_irq_restore(flags)
+| local_bh_enable()
+| bit_spin_unlock(...)
+)
+
+@find_direct_sleep_alloc_in_atomic@
+position p_atomic, p_call;
+identifier alloc_func =~ "^(kmalloc|kzalloc|kcalloc|kvmalloc|kvzalloc|kvcalloc)$";
+expression gfp, lock, flags;
+@@
+(
+  raw_spin_lock@p_atomic(...)
+| raw_spin_lock_irq@p_atomic(...)
+| raw_spin_lock_irqsave@p_atomic(...)
+| raw_spin_lock_bh@p_atomic(...)
+| raw_read_lock@p_atomic(...)
+| raw_read_lock_irq@p_atomic(...)
+| raw_read_lock_irqsave@p_atomic(...)
+| raw_read_lock_bh@p_atomic(...)
+| raw_write_lock@p_atomic(...)
+| raw_write_lock_irq@p_atomic(...)
+| raw_write_lock_irqsave@p_atomic(...)
+| raw_write_lock_bh@p_atomic(...)
+| preempt_disable@p_atomic()
+| local_irq_disable@p_atomic()
+| local_irq_save@p_atomic(...)
+| local_bh_disable@p_atomic()
+| bit_spin_lock@p_atomic(...)
+)
+<...
+  alloc_func@p_call(..., gfp)
+...>
+(
+  raw_spin_unlock(lock)
+| raw_spin_unlock_irq(lock)
+| raw_spin_unlock_irqrestore(lock, flags)
+| raw_spin_unlock_bh(lock)
+| raw_read_unlock(lock)
+| raw_read_unlock_irq(lock)
+| raw_read_unlock_irqrestore(lock, flags)
+| raw_read_unlock_bh(lock)
+| raw_write_unlock(lock)
+| raw_write_unlock_irq(lock)
+| raw_write_unlock_irqrestore(lock, flags)
+| raw_write_unlock_bh(lock)
+| preempt_enable()
+| local_irq_enable()
+| local_irq_restore(flags)
+| local_bh_enable()
+| bit_spin_unlock(...)
+)
+
+// --- PART 2: Indirect (Inter-procedural) Violation Data Collection ---
+
+@collect_atomic_callees@
+position p_atomic, p_callee_call;
+identifier callee_func !~ "^\\b(raw_spin|raw_read|raw_write|preempt|local_irq|local_bh|printk|pr_|dev_)\\b";
+expression lock, flags;
+@@
+(
+  raw_spin_lock@p_atomic(...)
+| raw_spin_lock_irq@p_atomic(...)
+| raw_spin_lock_irqsave@p_atomic(...)
+| raw_spin_lock_bh@p_atomic(...)
+| raw_read_lock@p_atomic(...)
+| raw_read_lock_irq@p_atomic(...)
+| raw_read_lock_irqsave@p_atomic(...)
+| raw_read_lock_bh@p_atomic(...)
+| raw_write_lock@p_atomic(...)
+| raw_write_lock_irq@p_atomic(...)
+| raw_write_lock_irqsave@p_atomic(...)
+| raw_write_lock_bh@p_atomic(...)
+| preempt_disable@p_atomic()
+| local_irq_disable@p_atomic()
+| local_irq_save@p_atomic(...)
+| local_bh_disable@p_atomic()
+| bit_spin_lock@p_atomic(...)
+)
+<...
+  callee_func@p_callee_call(...)
+...>
+(
+  raw_spin_unlock(lock)
+| raw_spin_unlock_irq(lock)
+| raw_spin_unlock_irqrestore(lock, flags)
+| raw_spin_unlock_bh(lock)
+| raw_read_unlock(lock)
+| raw_read_unlock_irq(lock)
+| raw_read_unlock_irqrestore(lock, flags)
+| raw_read_unlock_bh(lock)
+| raw_write_unlock(lock)
+| raw_write_unlock_irq(lock)
+| raw_write_unlock_irqrestore(lock, flags)
+| raw_write_unlock_bh(lock)
+| preempt_enable()
+| local_irq_enable()
+| local_irq_restore(flags)
+| local_bh_enable()
+| bit_spin_unlock(...)
+)
+
+@collect_potential_sleepers@
+position p_def, p_bad_call;
+identifier func_def;
+identifier bad_func =~ "^(mutex_lock|mutex_lock_interruptible|mutex_lock_killable|down|down_interruptible|down_killable|down_trylock|rwsem_down_read|rwsem_down_write|ww_mutex_lock|msleep|ssleep|usleep_range|wait_for_completion|schedule|cond_resched|copy_from_user|copy_to_user|get_user|put_user|vmalloc|spin_lock|read_lock|write_lock)$";
+@@
+(
+func_def@p_def(...) {
+  <...
+    bad_func@p_bad_call(...)
+  ...>
+}
+|
+static inline func_def@p_def(...) {
+  <...
+    bad_func@p_bad_call(...)
+  ...>
+}
+)
+
+@collect_potential_alloc_sleepers@
+position p_def, p_bad_call;
+identifier func_def;
+identifier alloc_func =~ "^(kmalloc|kzalloc|kcalloc|kvmalloc|kvzalloc|kvcalloc)$";
+expression gfp;
+@@
+(
+func_def@p_def(...) {
+  <...
+    alloc_func@p_bad_call(..., gfp)
+  ...>
+}
+|
+static inline func_def@p_def(...) {
+  <...
+    alloc_func@p_bad_call(..., gfp)
+  ...>
+}
+)
+
+@collect_call_graph@
+position p_def, p_call;
+identifier caller_func, callee_func !~ "^\\b(raw_spin|raw_read|raw_write|preempt|local_irq|local_bh|printk|pr_|dev_)\\b";
+@@
+(
+caller_func@p_def(...) {
+  <...
+    callee_func@p_call(...)
+  ...>
+}
+|
+static inline caller_func@p_def(...) {
+  <...
+    callee_func@p_call(...)
+  ...>
+}
+)
+
+// =========================================================================
+// 2. Python Scripts for Data Collection and Rich Reporting
+// =========================================================================
+
+@initialize:python@
+@@
+REASONS = {
+    "mutex_lock": "is a sleeping lock",
+    "down": "is a sleeping semaphore operation",
+    "rwsem_down": "is a sleeping lock",
+    "ww_mutex_lock": "is a sleeping lock",
+    "msleep": "is an explicit sleep",
+    "ssleep": "is an explicit sleep",
+    "usleep_range": "is an explicit sleep",
+    "wait_for_completion": "waits for an event and sleeps",
+    "schedule": "explicitly invokes the scheduler",
+    "cond_resched": "may invoke the scheduler",
+    "copy_from_user": "may sleep on page fault",
+    "copy_to_user": "may sleep on page fault",
+    "get_user": "may sleep on page fault",
+    "put_user": "may sleep on page fault",
+    "vmalloc": "can sleep",
+    "spin_lock": "is a sleeping lock on PREEMPT_RT",
+    "read_lock": "is a sleeping lock on PREEMPT_RT",
+    "write_lock": "is a sleeping lock on PREEMPT_RT",
+    "kmalloc": "may sleep in PREEMPT_RT",
+    "kzalloc": "may sleep in PREEMPT_RT",
+    "kcalloc": "may sleep in PREEMPT_RT",
+    "kvmalloc": "may sleep in PREEMPT_RT",
+    "kvzalloc": "may sleep in PREEMPT_RT",
+    "kvcalloc": "may sleep in PREEMPT_RT",
+}
+
+def get_reason(func_name):
+    for key in REASONS:
+        if func_name.startswith(key):
+            return REASONS[key]
+    return "is prohibited in atomic context"
+
+// --- PART 1 Report: Direct Violations ---
+
+@script:python depends on find_direct_sleep_in_atomic@
+p_atomic << find_direct_sleep_in_atomic.p_atomic;
+p_call << find_direct_sleep_in_atomic.p_call;
+bad_func << find_direct_sleep_in_atomic.bad_func;
+@@
+bad_func_name = str(bad_func)
+reason_str = get_reason(bad_func_name)
+
+# Handle p_call and p_atomic as list or tuple or single Location
+if isinstance(p_call, (list, tuple)):
+    if p_call:
+        p_call = p_call[0]
+    else:
+        p_call = None
+if isinstance(p_atomic, (list, tuple)):
+    if p_atomic:
+        p_atomic = p_atomic[0]
+    else:
+        p_atomic = None
+
+if p_call and hasattr(p_call, 'file') and hasattr(p_call, 'line') and hasattr(p_call, 'current_element') and p_atomic and hasattr(p_atomic, 'line'):
+    coccilib.report.print_report(p_call,
+        f"BUG (Direct): Prohibited call to {bad_func_name}() ({reason_str}) "
+        f"inside atomic context started at line {p_atomic.line} "
+        f"in function {p_call.current_element}.")
+else:
+    print(f"Warning: Invalid position info for direct sleep {bad_func_name} at p_call={repr(p_call)}, p_atomic={repr(p_atomic)}")
+
+@script:python depends on find_direct_sleep_alloc_in_atomic@
+p_atomic << find_direct_sleep_alloc_in_atomic.p_atomic;
+p_call << find_direct_sleep_alloc_in_atomic.p_call;
+alloc_func << find_direct_sleep_alloc_in_atomic.alloc_func;
+gfp << find_direct_sleep_alloc_in_atomic.gfp;
+@@
+alloc_func_name = str(alloc_func)
+reason_str = get_reason(alloc_func_name)
+
+# Handle p_call and p_atomic as list or tuple or single Location
+if isinstance(p_call, (list, tuple)):
+    if p_call:
+        p_call = p_call[0]
+    else:
+        p_call = None
+if isinstance(p_atomic, (list, tuple)):
+    if p_atomic:
+        p_atomic = p_atomic[0]
+    else:
+        p_atomic = None
+
+if p_call and hasattr(p_call, 'file') and hasattr(p_call, 'line') and hasattr(p_call, 'current_element') and p_atomic and hasattr(p_atomic, 'line'):
+    coccilib.report.print_report(p_call,
+        f"BUG (Direct): Prohibited call to {alloc_func_name}() with {gfp} ({reason_str}) "
+        f"inside atomic context started at line {p_atomic.line} "
+        f"in function {p_call.current_element}.")
+else:
+    print(f"Warning: Invalid position info for direct alloc {alloc_func_name} at p_call={repr(p_call)}, p_atomic={repr(p_atomic)}")
+
+// --- PART 2 Collect: Data for Indirect Violations ---
+
+@script:python depends on collect_atomic_callees@
+p_atomic << collect_atomic_callees.p_atomic;
+p_callee_call << collect_atomic_callees.p_callee_call;
+callee_func << collect_atomic_callees.callee_func;
+@@
+if "ATOMIC_CALLEES" not in globals():
+    ATOMIC_CALLEES = {}
+
+# Handle p_callee_call and p_atomic as list or tuple or single Location
+if isinstance(p_callee_call, (list, tuple)):
+    if p_callee_call:
+        p_callee_call = p_callee_call[0]
+    else:
+        p_callee_call = None
+if isinstance(p_atomic, (list, tuple)):
+    if p_atomic:
+        p_atomic = p_atomic[0]
+    else:
+        p_atomic = None
+
+if p_callee_call and hasattr(p_callee_call, 'file') and hasattr(p_callee_call, 'line') and hasattr(p_callee_call, 'current_element') and p_atomic and hasattr(p_atomic, 'file') and hasattr(p_atomic, 'line'):
+    context_info = (f"{p_callee_call.current_element} at {p_callee_call.file}:{p_callee_call.line} "
+                    f"from atomic context at {p_atomic.file}:{p_atomic.line}")
+else:
+    print(f"Warning: Invalid position info for {callee_func} at p_callee_call={repr(p_callee_call)}, p_atomic={repr(p_atomic)}")
+    context_info = f"{callee_func} (unknown location)"
+
+key = str(callee_func)
+if key not in ATOMIC_CALLEES:
+    ATOMIC_CALLEES[key] = set()
+ATOMIC_CALLEES[key].add(context_info)
+
+@script:python depends on collect_potential_sleepers@
+p_def << collect_potential_sleepers.p_def;
+p_bad_call << collect_potential_sleepers.p_bad_call;
+func_def << collect_potential_sleepers.func_def;
+bad_func << collect_potential_sleepers.bad_func;
+@@
+if "POTENTIAL_SLEEPERS" not in globals():
+    POTENTIAL_SLEEPERS = {}
+
+bad_func_name = str(bad_func)
+reason_str = get_reason(bad_func_name)
+
+# Handle p_bad_call as list or tuple or single Location
+if isinstance(p_bad_call, (list, tuple)):
+    if p_bad_call:
+        p_bad_call = p_bad_call[0]
+    else:
+        p_bad_call = None
+
+if p_bad_call and hasattr(p_bad_call, 'file') and hasattr(p_bad_call, 'line'):
+    sleeper_info = (f"{bad_func_name}() at {p_bad_call.file}:{p_bad_call.line} ({reason_str})")
+else:
+    print(f"Warning: Invalid position info for sleeper {bad_func_name} at p_bad_call={repr(p_bad_call)}")
+    sleeper_info = f"{bad_func_name}() (unknown location) ({reason_str})"
+
+key = str(func_def)
+if key not in POTENTIAL_SLEEPERS:
+    POTENTIAL_SLEEPERS[key] = set()
+POTENTIAL_SLEEPERS[key].add(sleeper_info)
+
+@script:python depends on collect_potential_alloc_sleepers@
+p_def << collect_potential_alloc_sleepers.p_def;
+p_bad_call << collect_potential_alloc_sleepers.p_bad_call;
+func_def << collect_potential_alloc_sleepers.func_def;
+alloc_func << collect_potential_alloc_sleepers.alloc_func;
+gfp << collect_potential_alloc_sleepers.gfp;
+@@
+if "POTENTIAL_SLEEPERS" not in globals():
+    POTENTIAL_SLEEPERS = {}
+
+alloc_func_name = str(alloc_func)
+reason_str = get_reason(alloc_func_name)
+
+# Handle p_bad_call as list or tuple or single Location
+if isinstance(p_bad_call, (list, tuple)):
+    if p_bad_call:
+        p_bad_call = p_bad_call[0]
+    else:
+        p_bad_call = None
+
+if p_bad_call and hasattr(p_bad_call, 'file') and hasattr(p_bad_call, 'line'):
+    sleeper_info = (f"{alloc_func_name}() with {gfp} at {p_bad_call.file}:{p_bad_call.line} ({reason_str})")
+else:
+    print(f"Warning: Invalid position info for alloc {alloc_func_name} at p_bad_call={repr(p_bad_call)}")
+    sleeper_info = f"{alloc_func_name}() with {gfp} (unknown location) ({reason_str})"
+
+key = str(func_def)
+if key not in POTENTIAL_SLEEPERS:
+    POTENTIAL_SLEEPERS[key] = set()
+POTENTIAL_SLEEPERS[key].add(sleeper_info)
+
+@script:python depends on collect_call_graph@
+p_def << collect_call_graph.p_def;
+caller_func << collect_call_graph.caller_func;
+callee_func << collect_call_graph.callee_func;
+@@
+if "CALL_GRAPH" not in globals():
+    CALL_GRAPH = {}
+
+key = str(caller_func)
+callee_str = str(callee_func)
+if key not in CALL_GRAPH:
+    CALL_GRAPH[key] = set()
+CALL_GRAPH[key].add(callee_str)
+
+// --- PART 3 Report: Indirect Violations ---
+
+@script:python final@
+@@
+import collections
+
+def build_call_path(func, reverse_graph, visited=None):
+    if visited is None:
+        visited = set()
+    if func not in reverse_graph or func in visited:
+        return []
+    visited.add(func)
+    paths = []
+    for parent in reverse_graph.get(func, set()):
+        sub_paths = build_call_path(parent, reverse_graph, visited.copy())
+        if sub_paths:
+            for path in sub_paths:
+                paths.append([func] + path)
+        else:
+            paths.append([func])
+    return paths if paths else [[func]]
+
+if "ATOMIC_CALLEES" in globals() and "POTENTIAL_SLEEPERS" in globals() and "CALL_GRAPH" in globals():
+    print("\n--- Inter-procedural Sleep-in-Atomic Analysis ---")
+    found_bugs = False
+
+    # Build reverse graph
+    REVERSE_GRAPH = {}
+    for caller, callees in CALL_GRAPH.items():
+        for callee in callees:
+            if callee not in REVERSE_GRAPH:
+                REVERSE_GRAPH[callee] = set()
+            REVERSE_GRAPH[callee].add(caller)
+
+    # Find transitive sleepers
+    may_sleep = set()
+    transitive_reasons = {}
+    queue = collections.deque(POTENTIAL_SLEEPERS.keys())
+    visited = set()
+
+    while queue:
+        func = queue.popleft()
+        if func in visited:
+            continue
+        visited.add(func)
+        may_sleep.add(func)
+        if func in POTENTIAL_SLEEPERS:
+            transitive_reasons[func] = POTENTIAL_SLEEPERS[func]
+        else:
+            transitive_reasons[func] = set()
+        for parent in REVERSE_GRAPH.get(func, set()):
+            if parent not in visited:
+                queue.append(parent)
+                transitive_reasons[parent] = transitive_reasons.get(parent, set()) | transitive_reasons[func]
+
+    # Find risky functions
+    risky_funcs = set(ATOMIC_CALLEES.keys()) & may_sleep
+    for func in sorted(risky_funcs):
+        found_bugs = True
+        print(f"\n[!] BUG (Indirect): Function '{func}' can sleep and is called from an atomic context.")
+        print(f"  - Sleep details:")
+        for reason in sorted(transitive_reasons.get(func, set())):
+            print(f"    - {reason}")
+        print(f"  - Atomic call sites:")
+        for context in sorted(ATOMIC_CALLEES.get(func, set())):
+            print(f"    - {context}")
+        # Print call paths
+        print(f"  - Call paths to sleepers:")
+        for path in build_call_path(func, REVERSE_GRAPH):
+            print(f"    - {' -> '.join(path)}")
+
+    if not found_bugs:
+        print("No indirect sleep-in-atomic bugs found.")
+else:
+    print("Error: Required data (ATOMIC_CALLEES, POTENTIAL_SLEEPERS, or CALL_GRAPH) not collected.")
+    # Debug globals state
+    if "ATOMIC_CALLEES" in globals():
+        print(f"Debug: ATOMIC_CALLEES = {ATOMIC_CALLEES}")
+    if "POTENTIAL_SLEEPERS" in globals():
+        print(f"Debug: POTENTIAL_SLEEPERS = {POTENTIAL_SLEEPERS}")
+    if "CALL_GRAPH" in globals():
+        print(f"Debug: CALL_GRAPH = {CALL_GRAPH}")
\ No newline at end of file
-- 
2.50.0

