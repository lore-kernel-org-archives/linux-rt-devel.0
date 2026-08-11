Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2363B4EAB
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462892; cv=none; b=Qo6rJCr2s8dp1VKcNDWNHn31XU/mXOmswyq3qymTxGI8dGPiiYB9t9J5yLOjbgu5X1ygJNCDfak1uXSa5+FdouR4VkA9H4GMF53QhL38OD0Yx7soTUZMtjmn+v1W3lGDweuKRGmWmzMwiaG422o5VmJVC/PIANMo4uzWRXR5dx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462892; c=relaxed/simple;
	bh=/V1r6QXOL+eNTn/p3qGEcfXKl0uwiefVorjHNpHVPeI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aBoHQW/UUVGtW3lB/JYLgktn9MrDlCeIwj2FWn87ohlIi3tQbKhwHodgKxbDjRMUkvJuTBL/2n/YFLhYLxQ+jMef1S0rWb0AnqcTOF/2vhRtwcRlxVEiEcdHSHLnJGmGp9ZNsd/qEofnBMS7YLRw4AgMYKIAU9yHFw6cGvvFM0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqqQYAPC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqqQYAPC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so7514515e9.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 08:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786462887; x=1787067687; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HYWQ6l3VVM6j4JRhvg6XxcplbTfEh60ar/rx0eHl1vY=;
        b=YqqQYAPCmzxEiL4Z8dayjYKNQnq1s3pxBry7Z/5d6rBzyyQXmEYtswPYbkWCPVhga6
         6Pmlj85XIeExCNhKcnUSaCisXIOtKJu1idjzJAyWHxaKw4tsJW37unwv+ScwSBXFTkX0
         9em0uJdlYX6gKahqc9eNvL20awvRzRdhR1pEtCkCKIpqRZYqT7b0dVOJcjnzthF+fP6F
         VBrrcBHUrizmzhm+7SYWxCa+2aAkK6/ASNlnJuZgb33PU3+/LUWmHrJPEdKwD5H+L6Cc
         ddjP5Ykc+9Um2/L3WbQXmzTpAeq47ArlfyZsZ0jUAar4yNFxI4//lGXJFByiuRp7ui31
         ZRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462887; x=1787067687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HYWQ6l3VVM6j4JRhvg6XxcplbTfEh60ar/rx0eHl1vY=;
        b=nGLd6DQBgsdZuw798FoDF2dqCBfUBpSdabiE1BqyqNfv7rcJTivc0NCSE2fWu5VH9B
         i76Ma6HgJoMqFRs4Y57gELM04aIkEn9RHPBjEqx+2b2pDvUuCqlfl1UY2oqpwI7Un9qf
         DGri6sAOc10KAq1x2DRbAOFnxFw5ySf6f2dC1mp9x+1EM5eub/9gHEXGnbwdXnTlNfAm
         0IQFGqs0n7YEW3IMlFrNBdoC91QL2v8NU+OVsEkDT3gtPqNJcVTCgfh/br0ITAmAa3HK
         GW0EgweyuE0tBn5icFRF0X7KzTbgzeZPF2TAeK+7EJebBv04UcnDXhMBAr1uS1zHMKmp
         1aig==
X-Forwarded-Encrypted: i=1; AHgh+RoJBcWjNwl2WhO9HlM074oQ69Cu1jY5f67RkwzGPh1/BT3FyPwYxc0Y1ta4u1iLooPjK75UTP56mAV3I6wI2Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YxT6WqS11MA6ngD7nUzl9b0ZhgQ1ZO1iTQVPlUEHqDHOr9MmUr1
	e+Pkvshd3l3Xl64Kzwr46G1YakGNwlZnyAJ3v9QUWBgql4wp5iXEYPSn
X-Gm-Gg: AR+sD127tjrj+xYtIJHIOT0S6IE1vAg3GXatMxWDkDkylsX7wFxyLdcK4bNmz/vKTBQ
	2+pej5ucloL05ih0v9pfHlEc13EGDMnjFqFEXXI/J7RuwA3Rn/ZFpCL6Uu6QYHXVZ6n+AqmvyVR
	WgEcci3Mpmph2j/CDaXD9+hI43ur+T5mGFKTf5WEO3vRt6K+E2HYMMtU6OA4b2FwmIDtocnht2C
	n7OHDMdq+mF2jp7rNczrQ+J2Kl/zjyiV6KK1A9r/1OX9CixcP4lDnzXDZv5imVLX9bZw9Co4eFZ
	tpALYIN/g1W8r1EcROwJ56r5kOO4S3Z8Ch6iEVSm1yHsbVJ/JVwuTHglomW+mZ6WZiWVwVrFcFV
	QhLVDdzFyOyjoMDqfqpAK4z2nGZIpHY9xizR11xBCZxP4GO+eRBktFrvwGZch7n2J5pzneRwYCN
	TvErzwBOMNEdOseUKPnM/qzEIhCwGdCrIBhRTufD2OLIcNj8nsvS9UKP83tqztEBla5ZOzORFBW
	0f37nviecFG+z+0gtJzmdsbuJZ06l91j/pvRqclTfJjUd8N++FD1knDxtjxxphivtgBtfesx0pH
	aXgHKfnE9IGe2lVcIqV8NR5/DJ3QQ5y08bnGQd8IYRKe4VcQ+RYkjDS0CbeFL1QQK11R
X-Received: by 2002:a05:600c:6a09:b0:493:f783:c46a with SMTP id 5b1f17b1804b1-4997a70a41cmr9098195e9.6.1786462886886;
        Tue, 11 Aug 2026 08:41:26 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aaa7aabsm1670275e9.7.2026.08.11.08.41.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 08:41:26 -0700 (PDT)
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
Subject: [PATCH v2 3/6] hrtimer: Pause KCOV during deferred rearm
Date: Tue, 11 Aug 2026 17:41:08 +0200
Message-Id: <20260811154111.64669-4-kmehltretter@gmail.com>
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

Deferred hrtimer rearm can run after HARDIRQ_OFFSET is dropped. in_task()
is then true, so KCOV attributes the instrumented timer-reprogramming
subtree to current.

With CONFIG_KCOV_SELFTEST added to x86_64 defconfig, the interrupt
selftest fails under QEMU, detecting spurious coverage in
__hrtimer_rearm_deferred(). The same happens on s390, RISC-V and LoongArch,
which also enable HRTIMER_REARM_DEFERRED.

Excluding the involved files instead would cost their coverage on real
task-context paths, e.g. the hrtimer and timekeeping syscalls.

Take the kcov_pause guard in an __always_inline wrapper around
__hrtimer_rearm_deferred(). Use it at all call sites, including
hrtick_schedule_exit(). Callers that may run with KCOV enabled for current
are built without KCOV instrumentation or marked noinstr. HAVE_NOINSTR_HACK
covers pre-GCC-12 x86. The other affected architectures restrict KCOV to
GCC 12 or Clang through ARCH_WANTS_NO_INSTR. This avoids relying on
__no_sanitize_coverage, which is empty before GCC 12. Tested with GCC 8.1
and 15 on x86_64.

Fixes: 15dd3a948855 ("hrtimer: Push reprogramming timers into the interrupt return path")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Notes:
    v2:
     - take guard(kcov_pause)() in an inline wrapper
     - clarify the test configuration and caller instrumentation requirements

 include/linux/hrtimer_rearm.h | 17 +++++++++++++++--
 kernel/sched/core.c           |  2 +-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/hrtimer_rearm.h b/include/linux/hrtimer_rearm.h
index a6f2e5d5e1c7d..45e47421fa0c7 100644
--- a/include/linux/hrtimer_rearm.h
+++ b/include/linux/hrtimer_rearm.h
@@ -3,10 +3,22 @@
 #define _LINUX_HRTIMER_REARM_H
 
 #ifdef CONFIG_HRTIMER_REARM_DEFERRED
+#include <linux/kcov.h>
 #include <linux/thread_info.h>
 
 void __hrtimer_rearm_deferred(void);
 
+/*
+ * KCOV: Pause outside __hrtimer_rearm_deferred() to suppress entry coverage.
+ * Callers with KCOV enabled for current must be uninstrumented.
+ */
+static __always_inline void hrtimer_rearm_deferred_kcov_paused(void)
+{
+	guard(kcov_pause)();
+
+	__hrtimer_rearm_deferred();
+}
+
 /*
  * This is purely CPU local, so check the TIF bit first to avoid the overhead of
  * the atomic test_and_clear_bit() operation for the common case where the bit
@@ -38,7 +50,7 @@ hrtimer_rearm_deferred_user_irq(unsigned long *tif_work, const unsigned long tif
 	 */
 	if (unlikely((*tif_work & TIF_REARM_MASK) == _TIF_HRTIMER_REARM)) {
 		clear_thread_flag(TIF_HRTIMER_REARM);
-		__hrtimer_rearm_deferred();
+		hrtimer_rearm_deferred_kcov_paused();
 		/* Don't go into the loop if HRTIMER_REARM was the only flag */
 		*tif_work &= ~TIF_HRTIMER_REARM;
 		return !*tif_work;
@@ -50,7 +62,7 @@ hrtimer_rearm_deferred_user_irq(unsigned long *tif_work, const unsigned long tif
 static __always_inline void hrtimer_rearm_deferred_tif(unsigned long tif_work)
 {
 	if (hrtimer_test_and_clear_rearm_deferred_tif(tif_work))
-		__hrtimer_rearm_deferred();
+		hrtimer_rearm_deferred_kcov_paused();
 }
 
 /*
@@ -73,6 +85,7 @@ static __always_inline bool hrtimer_test_and_clear_rearm_deferred(void)
 
 #else  /* CONFIG_HRTIMER_REARM_DEFERRED */
 static __always_inline void __hrtimer_rearm_deferred(void) { }
+static __always_inline void hrtimer_rearm_deferred_kcov_paused(void) { }
 static __always_inline void hrtimer_rearm_deferred(void) { }
 static __always_inline void hrtimer_rearm_deferred_tif(unsigned long tif_work) { }
 static __always_inline bool
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 96226707c2f61..3cbf817f52a4a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1010,7 +1010,7 @@ static inline void hrtick_schedule_exit(struct rq *rq)
 	}
 
 	if (rq->hrtick_sched & HRTICK_SCHED_REARM_HRTIMER)
-		__hrtimer_rearm_deferred();
+		hrtimer_rearm_deferred_kcov_paused();
 
 	rq->hrtick_sched = HRTICK_SCHED_NONE;
 }
-- 
2.53.0
