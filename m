Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057451;
	b=vFM74ZZpiT/hLdkbYhU7C6ZfdM0G/OopiNTMgt+L92iQWyHH5xeUdcSibgwihG67i4yo
	 2ME9QrBFT2Myr0tRL2xp8h63MUTi9qg66a1UhjvmPXsm80qSuAt3aId/5/EXVjqB3jhWz
	 +5K1saWESCyluSOTmQ8BKXHWyhUTRwwaIyndQUyQqRhl15uAb0sOaR4QyKoVHgJ5O0UGH
	 tkMR03UCWGNejmtRWZ9EL51mX6+WNzdatjwOXVtY+hbt3WJMwFsw7R6uUpQ8bUUKu3roe
	 mN7OFCKW2nxLi4kAxE6Vv9CjVIjTweiXDqi6avr2+1UubZtD1jeTLC1D9v8abFuOuOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f7hHMHm4WB1frdnfMK3rR7ZqF31yyOyM/lKH7fCZawM=;
	b=HlsYXbFHkpuhgV/wnWKKAnMYo8vb+dZWPVqV3lZF8MjQA7MUz6pGti82kpp2K5Yxegic
	 j31IyjPZfYZmCu2MhDEuhfRbRo/IaDJh1Z/k8BtlSeGXJQ01/XGAOQ0uqd6evVoPYhadd
	 7HGkcXQ8Z8l2UK76xwsEbmbktCKnHgc44IbpT9iQ5E2AgX6OxCNEgwJJxGlNNZa5srzy/
	 lgazUBJWLm/ODsplWv9k+lSyNlchAXL2m4PFQ5IgVhGUwJJ08wTQmNvZLunJZoJB330CP
	 hJ59AoO4LqZiY6ymy64oetytAhU96SpZ9ZBv0upeCalU+O8rZ3K+RINDgOyldWENH3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="W+cbf/4l";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11657606D802
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 13:17:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11657606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W+cbf/4l
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a59100fa83so12306275e9.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 07 Nov 2026 05:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057449; x=1794662249; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f7hHMHm4WB1frdnfMK3rR7ZqF31yyOyM/lKH7fCZawM=;
        b=W+cbf/4lBL9NGf9dYfKit+cvY+YPYpLeBJqsUULNmtdEyGIY9awaM2rAd15bPRWjCI
         MOMr5Vgc8vVtuR0UPK1vIWsDLWrwSrTVGHf/XQTIvYnu8vbhRCGm6ufgcTDpzA+Tr6w8
         RN5RZSccH00bEqPItT0azgYbzs6PZye5rvOHEbwqZ1knaugU7ZKlewXASUfSdyq7VpE1
         Tw5y1qC2xJqMXy/QPCFbhOy2pa/fSZ1/bUk+90l2XxvMamKsx2nNHvPhgyf14XsRBcIP
         Mg6o/3eGYXEUIMEfHdaOv47nIBeHhHzZGoNfiSHzkFFpxygNibhs3amIfdL5p0jM66rs
         v3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057449; x=1794662249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f7hHMHm4WB1frdnfMK3rR7ZqF31yyOyM/lKH7fCZawM=;
        b=WOlJt1cc4X1LGrSZAzGKDwlCeF/JGqW6BRIPrfiAlKDydGXAJNpztXJJNLpjvZy1/2
         zTCafRR3iyfLyyF2bi7YathDea39L+ORcT26j8Qvw+hWPxIuca8D3zvTahr6xWgSypRM
         wMoX9UnNfCLzoIkgCaMNEMeKSYlWoaz6/A/ccVXeyOTYVUvqqAOaPtw/XK4+lxSJQUjQ
         M3nAbDTdtCIwphwOJVndneDJMaqH6RX4gCfpYzk5J7p7lhAtCFNhS7OP0CF3Hq8Fov+I
         5li5z3c2DTYZU+kBNyrVecIm9gGkIAJEoLkBbFPKM8YL4w36tfChMKSzz6GpsWkotmRZ
         L1QQ==
X-Forwarded-Encrypted: i=1; AKwUvBwil+h9vP8C8bVFhKjjSnP5cQxSm5B5A2hh7JnoBq5FFJCfspnd0jwcOS1qMy03+HivvHAxBIloPw3/gQCAXQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/1NqbPd4dqyEJF4bN5kSOjkF5oS6Lw9zfsQjhnJAEYjtNlyoTw
	5CJRNI7mFsxnugMi2v3WiIduavcOR42pfSDVzkd22BaMKjlz+FKNhFs9
X-Gm-Gg: AYBFou3N8068NwDw91AYEFomxI2u6N7fF5qqyS1zCvSM+quY/CBsGLhID0Y76F7uahd
	7f/1iXPWseY+YYHiRVeQvKho365IthpTF+g9A89GYfxW8hOexMlLku/fa2+r6ta8DAp3M4Qx9jd
	q7iWCDUuWd3F66Yyy7Qlg1m0sqhpOFSslG1XuInTz1dTgABzji0G1DhJJIyRfKLhApMdlckus5M
	Hw4JYy13seaUmf1t01Hq7DrplDludJXkq6GxY7mRPfH6Qfhzdm3zUALa+TQnXRqRhlOxLEgOd0T
	eBiK64/F1qW3V0FN0ihlh5tw1MGO6T2UmuHZKDG18sHIInzqziG2mH9g1KFmO45x1ftWqYFfrXL
	yFxrL9bmx2VWWL5ZkgRkviMMT/KbJrbnOik6iPpqOomdtkR9954i1Vdmc+/N0LFSkMPvbaTmr/A
	P4GKIxJ1zPApB1ifWDDCL0ZDM7MjOMonu7U5ndxe2YhQ4XiFbpSEZ5KvBWijHRgZDmiuYh1wciw
	aSNmLplbZJiG4ZeWHM6yKG7GtvX8FgA0IcHzCafbaAS73P4auc5nQh6AFlsMDJxjGRpzw5hDF/v
	1gCaf8tGrlr1FPNmRTX7RdhUG7/BvN18h1twXxydHFgtoQbgSG/dx1EGFC5GmJghooSxwyKqISG
	xPTp8ZVRN/VRSLow2nI9muQkCcweuczvKcZ3mKqlKpN0I03RNxT4l2GOWlxARLn9ijRm+sTRnjk
	bXRGMduh7JtB3t4kHEM8e3Jt1hsBGs4MY=
X-Received: by 2002:a05:600c:34d5:b0:4a3:59c2:b41e with SMTP id 5b1f17b1804b1-4b6dc6df61amr97456735e9.4.1794057449178;
        Sat, 07 Nov 2026 05:17:29 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3279f9csm65132675e9.8.2026.11.07.05.17.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 05:17:28 -0800 (PST)
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
Subject: [PATCH v5 2/6] kcov: Add a kcov_pause guard
Date: Sat,  7 Nov 2026 14:17:06 +0100
Message-Id: <20261107131710.89264-3-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20261107131710.89264-1-kmehltretter@gmail.com>
References: <20261107131710.89264-1-kmehltretter@gmail.com>
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

Provide a kcov_pause guard and kcov_pause_scope() macro backed by flag
helpers shared with context switch suppression. The helpers access
kcov_mode with READ_ONCE() and WRITE_ONCE() and use compiler barriers
to keep instrumented calls inside the suppressed region. The guard
saves the previous pause state and restores it at scope exit, so
sections nest. When KCOV is enabled for current, remote softirq
sections save and restore the complete mode, preserving the pause
state. With CONFIG_KCOV=n, kcov_pause_scope() expands to a no-op
without defining the guard type or cleanup variable.

With CONFIG_KCOV=y, restoring a previously clear flag still writes
kcov_mode even when task coverage is disabled; nested guards also take
that path in this case.

The helpers are __always_inline. Guard users must be built without KCOV
instrumentation because inlining does not remove the caller's own coverage
callbacks.

Suggested-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/kcov.h | 80 +++++++++++++++++++++++++++++++++++++++-----
 kernel/kcov.c        |  5 ---
 2 files changed, 71 insertions(+), 14 deletions(-)

diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 895b761b2db1..7f3c34071f85 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -9,6 +9,9 @@ struct task_struct;
 
 #ifdef CONFIG_KCOV
 
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+
 enum kcov_mode {
 	/* Coverage collection is not enabled yet. */
 	KCOV_MODE_DISABLED = 0,
@@ -23,20 +26,64 @@ enum kcov_mode {
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
@@ -89,6 +136,20 @@ void __sanitizer_cov_trace_const_cmp4(u32 arg1, u32 arg2);
 void __sanitizer_cov_trace_const_cmp8(kcov_u64 arg1, kcov_u64 arg2);
 void __sanitizer_cov_trace_switch(kcov_u64 val, void *cases);
 
+/*
+ * Scope-based KCOV pause:
+ *
+ *	kcov_pause_scope();
+ *
+ * pauses coverage for current until the end of the scope. Callers must be
+ * built without KCOV instrumentation.
+ */
+DEFINE_LOCK_GUARD_0(kcov_pause,
+		    _T->paused = __kcov_pause(),
+		    __kcov_resume(_T->paused),
+		    unsigned int paused)
+#define kcov_pause_scope()	guard(kcov_pause)()
+
 #else
 
 static inline void kcov_task_init(struct task_struct *t) {}
@@ -105,6 +166,7 @@ static inline void kcov_remote_start_common(struct kcov_common_handle_id id) {}
 static inline void kcov_remote_start_usb(u64 id) {}
 static inline void kcov_remote_start_usb_softirq(u64 id) {}
 static inline void kcov_remote_stop_softirq(void) {}
+#define kcov_pause_scope()	do { } while (0)
 
 #endif /* CONFIG_KCOV */
 #endif /* _LINUX_KCOV_H */
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 7f106182cf1b..1d741a16d5ca 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -848,11 +848,6 @@ static const struct file_operations kcov_fops = {
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
2.39.5

