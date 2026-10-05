Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C84DBD74
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 Oct 2026 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226704; cv=none; b=lkkwvP5Gx9bSSU0BWCtR8JHiZbB//pRUXb180rPZlw76XT7Qig5VCS4BLNqw4T5H6wLJ4U+O14jsIniCCwHQjdaW3D7RsFuDNTzRRrcGvsNMa41JPoIoFJIMIS5qGMZhFA+juuHtxKBQ3Dqs33M/aR9AYdOMq2HGs2ZZ7Yz0KaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226704; c=relaxed/simple;
	bh=VhuMZhQSgNUoK23zJ2zuGMxgfoJ6eICwbGGFCSMgtLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k995AHM1I4+6Jp4Ja3LOB319cL1875AESzJLKJkZyAeP8bT/izsclmmvVp2iBmLVcKGDBkWXSsB1fZjqpiOQ0WWtMxfa27Fkdz7z3TVykeL0lmCjzO8yfZNBq89a55t2HyzoDSYf8zbgBjWSGNYugnkAPrcXvx5ONWjSBPkvwB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDSbtaJv; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDSbtaJv"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1688d7769so14014515e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 05 Oct 2026 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791226701; x=1791831501; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8DwGhYZenzciYHL+gywc0ajJIiQoquXAsP6MMMAsMaU=;
        b=MDSbtaJv9Yaqf33+hlyEmfA1EmUYEOLdKr9jw8+pm+6MlmnPGNzQhSSWvmS3YzrBFQ
         v9Wt2OU8mpBL9TNFBvICjxF7wY8+bT33YHGPiY0HoKYICoFLBPP2On7LG/mNaX8A5WoU
         oerYEjNC5J579F7+w7u3Knnn9c1DhXOhuMruS4GboDfx68SNqBTgimXkiptyz+pq+nwL
         KnBoZoYWlSrQaq1x3H+WhUjv/U7m41EcB/LQZFyurp0LYmf9nY7DjuDVCYkLNd/mmOL4
         QFkWwbQ8SMqjkkIXjq25w8UYMThh+G+OdA+bX5tEmWDdUmiczGUfHosmNXa4rxecLB81
         UN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791226701; x=1791831501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8DwGhYZenzciYHL+gywc0ajJIiQoquXAsP6MMMAsMaU=;
        b=YhZEPFnkDi/L41MoOwwdRbI5i0uVEXPVzBarLSXZl/5WiYRO7avPbzDJT7M3JbwRI/
         6b6A/4haxrSsGxk6Y7QHz6490BOKRJ+y5It3wVBoxuO5PFw725hEH/WI1eyTy9ak8+l2
         fPoDOnl8DX+Ft3Rnjqo/cLGECRdyW4RczlFKSF2FRV7hN5aCnnkG14av2rqCoDW07cgX
         Zzu/Dr3RoQ8n9FPEusrWsi4IWMAo5kCVQFxBa2U/zE7/ZTXwlgbj9eF2XFsxAlCehH68
         aZxi1X3dQYjcftWUsJiZpQBZbnuJaWG4zqOHJ1cl1jflUdTZOCUaNX90yigMH/lHTxUm
         bfkA==
X-Forwarded-Encrypted: i=1; AKwUvBxT4VvHF6UFlP5D3hbtR0eGK6vXBdFzfhI4uM8Pw8Q6Zekw+CQILnbLK/85nzGXSk4TDeYKzptEVfawWBfYjg==@lists.linux.dev
X-Gm-Message-State: AFuF++nlPNVYKW8lmshMEjX4r8wCD7uFlodlT7bo9cW3PfNDdJm4Le+G
	t2sXZ/neBlRneNw8/R5HTq587/ZkOqrmhkq4fqQFgrtqZcPTENWlPWxF
X-Gm-Gg: AYBFou1akPo4Eb+jkUdrf/4tFE5BKfMr/lsyDhdhyCV6FMMfT9r32tUhYs6SCWYHEpk
	FaMv9J/qeIx+xgh2Nb1lfbpwWm15TQ/p5tqus2yZCv2EkOp4kq9F4KQ3glziXdCKLVntEJKr9SP
	vuFtz1JWszEgktN3v7OUHINPxyrNyHZQbKbyL7i38VevIa5Ocraur8+OrUcKxr/wol9JH0Fu0c3
	eHb1tWjtsVuSrUd4gVbRl0OInjklX6pJZC4QCVbLbRwSMsBbfyMwAbakAK3++TK8nugFwAXN/S5
	M5Do1+04b4wFSxyx6KpWC5YrohLob0TNsHJs6h5e2hEBpK4q1o5Q0vmCw/T/P09Xqei/3NzPSGL
	Od97q+kxAI5twQc9hIfb1RXmVwCtyrdIKOJAsia5WbV+JtzaCSmhck+Oe/TYiV4qQGmu2c8G1cd
	XY3Kdd2wTXXm1cj1wAoHyVHXuEPqxsfLX44bbigIyVB8GXApitUOovOUKt8stU4K0e8x9yGoQSC
	EfyESCgeD6hGQw+eDYqLIen+zMQOfllNTPv7rBMonEsYAmYH2sbQNqIi6UJsUsRjqnFIANGuD+d
	01CNmLX/HCyo0u4HUlHnHmv19BU88v0oF5FZlEimU8nZlpHWmYYGuy+W3oZyWuECyhZKmYXOqpf
	fPA==
X-Received: by 2002:a05:600c:3485:b0:4a1:6916:798 with SMTP id 5b1f17b1804b1-4a176ca18femr29083865e9.14.1791226700993;
        Mon, 05 Oct 2026 11:58:20 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-b305-2001-39fa-3d24-821a-4eae.310.pool.telefonica.de. [2a02:3100:b305:2001:39fa:3d24:821a:4eae])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0394e6c5asm281196795e9.2.2026.10.05.11.58.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 05 Oct 2026 11:58:20 -0700 (PDT)
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
Subject: [PATCH v4 2/6] kcov: Add a kcov_pause guard
Date: Mon,  5 Oct 2026 20:57:59 +0200
Message-Id: <20261005185803.39170-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261005185803.39170-1-kmehltretter@gmail.com>
References: <20261005185803.39170-1-kmehltretter@gmail.com>
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

