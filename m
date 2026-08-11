Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367EC3B5302
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 15:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462888; cv=none; b=Zlz+SnJZlZLSt4FrOZApnoFbQfcovjUoCSOzD3LI7JQ5GgBq7LIbQS0oj3YreKLgx1CCxszBgwD5NXBir5Lyiu6VOtBXMoXNG8cMt02bIupRVhZv6srttSozhqQhEdQ6yl+VPd/t72sXI2MK7h4eUielBvi/EzqNYJUQE4Z+QGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462888; c=relaxed/simple;
	bh=U/CuYnW3nKlm0Ag5nbrLZwr7GqhHDz5KB3HhWHjv9Ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cb4zaK+giNtBx4eiTqKmQEzddZCSYB783hQMWmBgMjT8G23dAUvl/OP4A8RxMWkJ+JaPaBAo016s5nGsz6gGe+7YpJ4COH1NM1pUhO4vj0E/XBT7UzLfUBjSB0+GHLqgiK894G1Jhr132s5MZO7nwQh5oe2U4ihnZmuhDM7GNF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f84FZauI; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f84FZauI"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4996f1ee4a4so18798665e9.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 08:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786462884; x=1787067684; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TYbzUo5s72w0MgSb7UEpNxz2BTiCO8snbdn2LAQeGn8=;
        b=f84FZauIFehWU8nITC/Ya3M9BxrCntFvX1isb1EcE7FSDkY9KOFZRWFV9Go5qJyGYo
         whExBlGbCii5jLxBduahzVm8/bHsVW4uX1LcuqO9gPEfOdUMPMYB/6p3RekWF8LxVm/j
         7PnVdlq4U23lJHzDG1adaT0kD+7WZKWTkXEP5iVVnYgC6PYXVjew4H4xWOtJ07XSMz5q
         zkiQnJLO75IBLN4RHEciEVGMrnA3T6XbRXyu4BsJtqcdbPgPiw17LxaRHETHUi9OJNHK
         FuRQcCeoIt1e8dLh9LsI2Oo8q1EVrYB/cDBMDTjinrqRr2X4LhhMc6RfqDzIdYNbCStQ
         eZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462884; x=1787067684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TYbzUo5s72w0MgSb7UEpNxz2BTiCO8snbdn2LAQeGn8=;
        b=CsVBy6Zo6O0DLRoNcddgpxqV7nKhdu5H1EvBnNaS00W6ru0wyNlQkloDWwrGula0yh
         6YweMDqRXLdOTO5WEMiSqxcAHwPn0N/kxSGwKOgjpZYYN+6g8sh7xyw1hhJJT6dEsHAw
         kGfZ/G57p0fqbms932bsx7iX7ECILB6olP6FZMmPJJ7XdCGKrMAvT1UfNRYxHsdKPLq1
         QHPVuX5rvdx0MnZbT9cTyoXqJN6euAhi2hH9ufoLWwX14rk0sD5dyNPBt/cNOCsodHVH
         MbXqjPcl8TSTXWa/v8Xi9SiFAny/s2nBk5bQXJa+bdNIRjEF+vC9pbWty88BpEXtU+TZ
         8R+A==
X-Forwarded-Encrypted: i=1; AHgh+RoOA4lY/vmNrZc04tNrZtsnblLXS153/Ut9kQYQzaLBUw7nOIcZD9SbjQ7YU6hxKcgbJ5Iej8uD51+d3nO2+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YyLAOUZZJRbru7kVhgSJjZN/EylnMS3R741iQ4TEmYOBGGPVY6P
	8wWeZ6yH3+elkUd1dqOvO7Zjg+ogZZbKb1fgyKe9/ff16su9d9FNvOK2
X-Gm-Gg: AR+sD12TryC+z7w+WCCQqiJXW9flfqFLxz5ruyekM9rZYcb1ufV5g9f1cQWwuI+fAXY
	pHNTOezAg+D5AG5uWjCi1WjNkOL2ViQj7ydljZGNY5UX4YFhTUmDSSojyvtB5jadA4OXo02ExYM
	N5eGSH6iALglOMux/Zfm7zi6VX4AlKjWiU7dIMVBcvpd1RpTlWXihEkIiE8gdkblwuQxihnNlpR
	pNDGSIDWT4mzRgBEw2mlyRZSib2m0o1rM/SDPQNCliKTfAQyTMXxPgBJ0OInwsgU8LywRGlBy14
	6U7LrZlCujVFu8w+c70gFYwxpWYDudZRkF6bVdmBRZxfNP+HCRBlGSrX+pF+xl+6L5deq5gKCiA
	ZWe9l4cvCfr6j6k6J3apmud3b8vygfWBJtObUk/MVLslGsFQ2xEE9o4nJE+9gd3qgD7Z/k4DEam
	EKBvNVOATcKKHWqgJ+/mpB9vF98FRTQWCM8Hbe5VWL//whYqyDdI96mQPw1izXcP3JRlkjmyXUu
	DjYCnYK7uexrCmVBEXgJdQn+rmoJns86QAWSjm+07iMvgfFhflcw+CXQirKb38NRV2lhv7pGrW6
	gX8i4hrt47uA00DQSYr+yLd493bz7AicNudRS/z2MhRBjYBCcQKI6cHVE1yH6LLuyXMm
X-Received: by 2002:a05:600c:4fd5:b0:496:c18c:f9a3 with SMTP id 5b1f17b1804b1-4997840ab65mr67073835e9.5.1786462884404;
        Tue, 11 Aug 2026 08:41:24 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aaa7aabsm1670275e9.7.2026.08.11.08.41.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 08:41:23 -0700 (PDT)
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
Subject: [PATCH v2 2/6] kcov: Add a kcov_pause guard
Date: Tue, 11 Aug 2026 17:41:07 +0200
Message-Id: <20260811154111.64669-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260811154111.64669-1-kmehltretter@gmail.com>
References: <20260811154111.64669-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Interrupt-return work can run after HARDIRQ_OFFSET is dropped, when
in_task() is true. KCOV then attributes instrumented callees to the
interrupted task.

Add a KCOV_PAUSED bit next to KCOV_IN_CTXSW and mask both in
kcov_mode_enabled(). The coverage callbacks need no new check because
check_kcov_mode()'s exact comparison rejects modes with KCOV_PAUSED set.

The context switch suppression keeps its own bit: kcov_prepare_switch()
runs on the previous task and kcov_finish_switch() on the one switched
in, so its lifetime is not a pause section.

Provide a kcov_pause guard backed by internal helpers that operate on
current. The guard saves the previous pause state and restores it at
scope exit, so sections nest. When KCOV is enabled for current, remote
softirq sections save and restore the complete mode, preserving the pause
state.

The helpers are __always_inline, and guard users must be uninstrumented:
inlining does not remove the caller's own coverage callbacks.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Notes:
    v2:
     - add guard(kcov_pause)() backed by private current-only helpers

 include/linux/kcov.h | 40 +++++++++++++++++++++++++++++++++++++++-
 kernel/kcov.c        |  2 +-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 895b761b2db15..1b4806dab62fb 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_KCOV_H
 #define _LINUX_KCOV_H
 
+#include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/sched.h>
 #include <uapi/linux/kcov.h>
 
@@ -23,7 +25,8 @@ enum kcov_mode {
 	KCOV_MODE_TRACE_CMP = 3,
 };
 
-#define KCOV_IN_CTXSW	(1 << 30)
+#define KCOV_IN_CTXSW	BIT(30)
+#define KCOV_PAUSED	BIT(29)
 
 void kcov_task_init(struct task_struct *t);
 void kcov_task_exit(struct task_struct *t);
@@ -38,6 +41,25 @@ do {						\
 	(t)->kcov_mode &= ~KCOV_IN_CTXSW;	\
 } while (0)
 
+/*
+ * Pause coverage for current. Callers must be uninstrumented.
+ * Pass the returned state to __kcov_resume().
+ */
+static __always_inline unsigned int __kcov_pause(void)
+{
+	unsigned int paused;
+
+	paused = current->kcov_mode & KCOV_PAUSED;
+	current->kcov_mode |= KCOV_PAUSED;
+	return paused;
+}
+
+static __always_inline void __kcov_resume(unsigned int paused)
+{
+	if (!paused)
+		current->kcov_mode &= ~KCOV_PAUSED;
+}
+
 /* See Documentation/dev-tools/kcov.rst for usage details. */
 void kcov_remote_start(u64 handle);
 void kcov_remote_stop(void);
@@ -93,6 +115,8 @@ void __sanitizer_cov_trace_switch(kcov_u64 val, void *cases);
 
 static inline void kcov_task_init(struct task_struct *t) {}
 static inline void kcov_task_exit(struct task_struct *t) {}
+static inline unsigned int __kcov_pause(void) { return 0; }
+static inline void __kcov_resume(unsigned int paused) {}
 static inline void kcov_prepare_switch(struct task_struct *t) {}
 static inline void kcov_finish_switch(struct task_struct *t) {}
 static inline void kcov_remote_start(u64 handle) {}
@@ -107,4 +131,18 @@ static inline void kcov_remote_start_usb_softirq(u64 id) {}
 static inline void kcov_remote_stop_softirq(void) {}
 
 #endif /* CONFIG_KCOV */
+
+/*
+ * Scope-based KCOV pause:
+ *
+ *	guard(kcov_pause)();
+ *
+ * pauses coverage for current until the end of the scope. Callers must be
+ * uninstrumented.
+ */
+DEFINE_LOCK_GUARD_0(kcov_pause,
+		    _T->paused = __kcov_pause(),
+		    __kcov_resume(_T->paused),
+		    unsigned int paused)
+
 #endif /* _LINUX_KCOV_H */
diff --git a/kernel/kcov.c b/kernel/kcov.c
index b5340369e6fe3..a5c43764f21ac 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -830,7 +830,7 @@ static const struct file_operations kcov_fops = {
 
 static inline bool kcov_mode_enabled(unsigned int mode)
 {
-	return (mode & ~KCOV_IN_CTXSW) != KCOV_MODE_DISABLED;
+	return (mode & ~(KCOV_IN_CTXSW | KCOV_PAUSED)) != KCOV_MODE_DISABLED;
 }
 
 static void kcov_remote_softirq_start(struct task_struct *t)
-- 
2.53.0
