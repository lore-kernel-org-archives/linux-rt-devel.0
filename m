Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0C827FD43
	for <linux-rt-devel@lists.linux.dev>; Mon, 14 Sep 2026 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364882; cv=none; b=pi3ba3qe2ILw1JZ59Nesn+CqW/82AhfsliMdHKKl8Kti9WuUKQtRA5Gk0aNKcWlBKekq7ukDArg2H0F9/U1MDTkxIgpyMaU5dVw5D9jq5ww8eIrwpSMlo53GALv5x2NrV38XpMwDOcT9w4hM7NKIEim5Lon/pQRKbqFJB1pEW/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364882; c=relaxed/simple;
	bh=VhuMZhQSgNUoK23zJ2zuGMxgfoJ6eICwbGGFCSMgtLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lNpNCyuNXkqF0ziEHoYatfeItiayHtke1Mqe7eNQei0sbl3hyGCr9D6Yov2nW5KJNh29wErguuZvcm9xyqKrN+0UCFPlJMFzTWL82qhUfDcAP6tb3PVVn7w0Jdkp3vJtLuA/FmTYGj2E+jdHrlLRsI8o7hi+v9ehPuIbjag+7+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lWDvr8PB; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWDvr8PB"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e7acdc816so410185e9.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 13 Sep 2026 22:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789364879; x=1789969679; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8DwGhYZenzciYHL+gywc0ajJIiQoquXAsP6MMMAsMaU=;
        b=lWDvr8PB00pP/OWZWRlxMldbEdhRcG79Vr5fBLdJ3et01/5tGF0j2jA5GEXDOCbDMU
         c2CQ+7rhtP4SPlC+qhb96GnUbaC4grCiMwUBAFoWk8jn4zAKQJQzbnREGBzBGPChBOPr
         mRa6u8dmAW2bm8oAtG0B9lMC2SdziL9k1x5iGfruO2U4PuyRnwZlcMPLB3eNuajvA/y2
         RCTmNyVf3RvXq7xo0lQZxbKhKg4DeDxWnmkgcFp9ir7YUmEuZ7vrvukWEnh6kYe2aEsu
         qDHNjRxvsXi94ZwA+b5cJdEcdMzGJLhsQkTLQRL1OwPXVhGREdc5V9H0E7U8nwp+QulM
         /+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364879; x=1789969679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8DwGhYZenzciYHL+gywc0ajJIiQoquXAsP6MMMAsMaU=;
        b=o5dtRqvyUrMQZu1mk7DlqSZyipLwlZlJjdBN1Iui/dzzBkjSlyEIABB0kT2JkZCeQV
         /anZ58f/HGzfUuiww/KkMyv/IT3F8LMmcORvidhlDtNSmW1c7B+uRjngOnWu1nplWq4v
         FFBc4oj0bzULO9SkIKfxnnKmU9CPsgoDQ3lQl44EK4FsNP0Qu7uUIDYrMhKtiRKgq9og
         lI02dpMO83YfNRou0Y95tdkkB22nHb2EdrcxtY/MwhyHYpVo71uev2coswx0Zaaku39d
         JFOJybqKNpyrlsvnkLE1qhYQ0MW5ZSvURg3ga7b+8yxduDRpjJG8kf5NNvhk7WcNKsac
         c8Ug==
X-Forwarded-Encrypted: i=1; AKwUvBxfGEtZo1JLHiErX1qV4DQBE7OMRDuTVWLxpoakCWIqHuPEbAnmMDniFLsD3ZB80rKS2NTylRY3mO4evyDypA==@lists.linux.dev
X-Gm-Message-State: AFuF++ktMDr7PNm5gbHEUDB/vuO+yZEMAglbuFbzpXH8BeYkvrW9vWfi
	yFG3gmgeWW+avvsuQOAa8GD4Lc/D+1gomwflaU5s7vqKORiwmqkMHsjz
X-Gm-Gg: AYBFou2JKEAjlM3b0cfP6lBbm1sPADhf6AL8mpEpuupQcNEhxRrH1bMpTFF3d3T0HsL
	h3NA1lYtUYUCQ1UDPjem/indKC1aOfp8XinKOi3EuN0BlXmHaTHIQelbAvjz84Yu4VAcWocPoF/
	Nso4BX3Xzgi2W+R0sLDGo5S7LJAbRZwI3F+ENNfC4tNq2y4yOecug554C3HuCqkKWolhyIN5mEq
	tx0exUa0KcI+5sXQtF4y0OkfbxbSvr4ArnI2lMTi/4KRb1H8YGUsznFpoFGP01KHCxdBJNtTqWu
	q2HW+rEDbsud7d5/SHroTLdW4T0dfEPqIj9IUtKCKLYrcWr3WAU6jajrEdsMP/j1WZs9ZGP6pe2
	XQ61EtjGn+SaN14vUEAdrCNS+m2wVgAo5z2BIiPMSd5rivBrUU/FAiGmV6zfheCBrsVu41M43ro
	DlF/1mZfJp35yCDsdhL1S1ZK8KHDI5oOhfFFUJCzSxfyutCa4rYkeor3i4kSBsPc4MMZWr5ao4b
	scJ/IjAn43uYN1s2tHUvJzUAioTVQFytYHtDBjuc5eqL2/KqAMnccaaLYnukkxHvGmjBtcOKiUo
	JF6TwAwBSeg0hygSjnS2D7e51ByUDpc=
X-Received: by 2002:a05:600c:6989:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-49e7a64ccc4mr8629955e9.2.1789364878978;
        Sun, 13 Sep 2026 22:47:58 -0700 (PDT)
Received: from localhost.localdomain (dynamic-077-007-122-014.77.7.pool.telefonica.de. [77.7.122.14])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6a06cfb8sm214537735e9.5.2026.09.13.22.47.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 13 Sep 2026 22:47:58 -0700 (PDT)
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
Subject: [PATCH v3 2/6] kcov: Add a kcov_pause guard
Date: Mon, 14 Sep 2026 07:46:28 +0200
Message-Id: <20260914054632.12877-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260914054632.12877-1-kmehltretter@gmail.com>
References: <20260914054632.12877-1-kmehltretter@gmail.com>
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

The shared setter no longer sets KCOV_IN_CTXSW on a disabled task,
since its mode already fails the coverage callbacks' exact comparison.

Provide a kcov_pause guard backed by flag helpers shared with context
switch suppression. The helpers access kcov_mode with READ_ONCE() and
WRITE_ONCE() and use compiler barriers to keep instrumented calls inside
the suppressed region. The guard saves the previous pause state and
restores it at scope exit, so sections nest. When KCOV is enabled for
current, remote softirq sections save and restore the complete mode,
preserving the pause state.

With CONFIG_KCOV=y, restoring a previously clear flag still writes
kcov_mode even when task coverage is disabled; nested guards also take
that path in this case.

The helpers are __always_inline. Guard users must be built without KCOV
instrumentation because inlining does not remove the caller's own coverage
callbacks.

Assisted-by: LLM
Suggested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/kcov.h | 80 +++++++++++++++++++++++++++++++++++++++-----
 kernel/kcov.c        |  5 ---
 2 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 895b761b2db1..41833b434c40 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -2,6 +2,8 @@
 #ifndef _LINUX_KCOV_H
 #define _LINUX_KCOV_H
 
+#include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/sched.h>
 #include <uapi/linux/kcov.h>
 
@@ -23,20 +25,64 @@ enum kcov_mode {
 	KCOV_MODE_TRACE_CMP = 3,
 };
 
-#define KCOV_IN_CTXSW	(1 << 30)
+#define KCOV_IN_CTXSW	BIT(30)
+#define KCOV_PAUSED	BIT(29)
+
+static __always_inline bool kcov_mode_enabled(unsigned int mode)
+{
+	return (mode & ~(KCOV_IN_CTXSW | KCOV_PAUSED)) != KCOV_MODE_DISABLED;
+}
 
 void kcov_task_init(struct task_struct *t);
 void kcov_task_exit(struct task_struct *t);
 
-#define kcov_prepare_switch(t)			\
-do {						\
-	(t)->kcov_mode |= KCOV_IN_CTXSW;	\
-} while (0)
+static __always_inline unsigned int
+__kcov_set_flag(struct task_struct *t, unsigned int flag)
+{
+	unsigned int mode = READ_ONCE(t->kcov_mode);
+	unsigned int prev_flag = mode & flag;
+
+	if (!prev_flag && kcov_mode_enabled(mode)) {
+		WRITE_ONCE(t->kcov_mode, mode | flag);
+		barrier();
+	}
+	return prev_flag;
+}
 
-#define kcov_finish_switch(t)			\
-do {						\
-	(t)->kcov_mode &= ~KCOV_IN_CTXSW;	\
-} while (0)
+static __always_inline void
+__kcov_restore_flag(struct task_struct *t, unsigned int flag,
+		    unsigned int prev_flag)
+{
+	if (!prev_flag) {
+		barrier();
+		WRITE_ONCE(t->kcov_mode, READ_ONCE(t->kcov_mode) & ~flag);
+	}
+}
+
+static __always_inline void kcov_prepare_switch(struct task_struct *t)
+{
+	__kcov_set_flag(t, KCOV_IN_CTXSW);
+}
+
+static __always_inline void kcov_finish_switch(struct task_struct *t)
+{
+	__kcov_restore_flag(t, KCOV_IN_CTXSW, 0);
+}
+
+/*
+ * Pause coverage for current. Callers must be built without KCOV
+ * instrumentation.
+ * Pass the returned state to __kcov_resume().
+ */
+static __always_inline unsigned int __kcov_pause(void)
+{
+	return __kcov_set_flag(current, KCOV_PAUSED);
+}
+
+static __always_inline void __kcov_resume(unsigned int paused)
+{
+	__kcov_restore_flag(current, KCOV_PAUSED, paused);
+}
 
 /* See Documentation/dev-tools/kcov.rst for usage details. */
 void kcov_remote_start(u64 handle);
@@ -93,6 +139,8 @@ void __sanitizer_cov_trace_switch(kcov_u64 val, void *cases);
 
 static inline void kcov_task_init(struct task_struct *t) {}
 static inline void kcov_task_exit(struct task_struct *t) {}
+static inline unsigned int __kcov_pause(void) { return 0; }
+static inline void __kcov_resume(unsigned int paused) {}
 static inline void kcov_prepare_switch(struct task_struct *t) {}
 static inline void kcov_finish_switch(struct task_struct *t) {}
 static inline void kcov_remote_start(u64 handle) {}
@@ -107,4 +155,18 @@ static inline void kcov_remote_start_usb_softirq(u64 id) {}
 static inline void kcov_remote_stop_softirq(void) {}
 
 #endif /* CONFIG_KCOV */
+
+/*
+ * Scope-based KCOV pause:
+ *
+ *	guard(kcov_pause)();
+ *
+ * pauses coverage for current until the end of the scope. Callers must be
+ * built without KCOV instrumentation.
+ */
+DEFINE_LOCK_GUARD_0(kcov_pause,
+		    _T->paused = __kcov_pause(),
+		    __kcov_resume(_T->paused),
+		    unsigned int paused)
+
 #endif /* _LINUX_KCOV_H */
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 79dabbad5a38..faccbd3bd2b8 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -830,11 +830,6 @@ static const struct file_operations kcov_fops = {
  * collecting coverage and copies all collected coverage into the kcov area.
  */
 
-static inline bool kcov_mode_enabled(unsigned int mode)
-{
-	return (mode & ~KCOV_IN_CTXSW) != KCOV_MODE_DISABLED;
-}
-
 static void kcov_remote_softirq_start(struct task_struct *t)
 	__must_hold(&kcov_percpu_data.lock)
 {
-- 
2.53.0

