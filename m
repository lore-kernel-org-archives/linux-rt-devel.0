Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057453;
	b=XhwrDl890uWaR5Z0eCBRxSzDpQpuBb9c/7+j1wfntLwIebzlBFIWWul10b/da9utWCqP
	 e1aibn1T+49+B91t6LWHfX1ziKDSJqnOjTZpCcLEfDkRWvha/ey71397xyh0nfjUZT0ZP
	 GkbtBzcVDjZAn/BgiuVXlmrYxyX92jlVOdLa2U2TPqa4St31x5rUs2nUZVMNZxmULd2pO
	 dXZCTdKPal54YwCtplulwbIHAuDc0RKnVvUhwDRzZkWovtPPmytUzI0V96cSXPg4yzkoQ
	 VkLFSqAruRLk+vws56XdEyA6h1tzQAJt0iS/F491pAIyJX/oqDAK2DIlYUdGgobuAEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lUMGRPQKK0YziSwuHZdCLQr3adBDCdp+cKA6XOKv3jc=;
	b=FAsbDKxYHQMHcK03GIuc1halovHigN3WxUYOoQZVPxV3YnFfZ5RdM5SdonhaOasI78ix
	 kKHN5GLTralP+XQAResDH4WRm0fgwxdnn6JKTWJirlvpFvWxFkiDTWx5yjiiRIBq43jTb
	 NMjLivBRL+ekKH1FxxK7MDHCG1vX9JWcaICdVNa9Cud2bJ7FFnmA2p6Lvv2z13jSfx+or
	 2dDMYABr9P7w79qlhmtHk8f6fuvObPpSIxc8zatO2TIOgZUHBEqmwoY1bzhGHYI6AC2OH
	 K0KUO21Tqena4n/qfNVoBe1aTLOh+XV5sBH0FagqGDYaI68SfWToAYiD/6SU2izy1IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lfz4B8bm;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BAB606A332
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 13:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1BAB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lfz4B8bm
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so11216205e9.3
        for <linux-rt-devel@lists.linux.dev>; Sat, 07 Nov 2026 05:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794057451; x=1794662251; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lUMGRPQKK0YziSwuHZdCLQr3adBDCdp+cKA6XOKv3jc=;
        b=Lfz4B8bmpKthm5o2I2vaSvAdBwWaLbbKFF92lg1hmABL9rsfEgFG26Zu61Yk9Z5shu
         QgNIUblNnJf8IOaE5qS1EYo6q5wBTIY6i0cXWUptanEhpJ74MXAGzCeQUwaMext5DrAN
         hhk3bXdh+YzzeYg0tl6rnS0+fcQiQhpbf5HmhoB7m+YgNF5d1INZlE97AjP7Qc6iOl0g
         ksP8e82W2bdDG16quapL2XRZNcfCnIbMUECB6BcdBceY7o1yKnTR50bDN6Hzue6h9dht
         cNFLF62W7cu2vRRNU3Tcf2tuQMDyuipNPrbDJ5tJLDPMBAO2NnZ1r1HkWaIUt4z9Hg04
         FDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794057451; x=1794662251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lUMGRPQKK0YziSwuHZdCLQr3adBDCdp+cKA6XOKv3jc=;
        b=O8LW0ciGQh0uMIlxHiyPFU99yRfYBljh4tgOZD3PCQxK3XjHYT1Ttdj6hMEz25SnxM
         v5yQ33RZIGvX2Y6utQ9VhCtQkA4AXM+uQUWemvJvZu/MBLDPcCeNdgP5uZ7VrGeLB+RE
         SA1H0HAdNJLCdGsK9vY75CH1EzxoAuhC4xZ5Eq5RQWL1Nvxf3f/P9Z0aMUxS4qMqLW0f
         xM1ZhHGLk6Ag91Tv2cnPAleqzJzbkbsNTZfUZAdzKZ4pgXPFyowGzgMWfsQ6cXqcE4N3
         ynifYk9mEX5wTh1VYs1Yy5hGTz0bSvOKOQA57r9s9mecuPlaMH5z3OLjJFWs1nfP2R02
         UXaQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7KwBHzIxNC7EnBOjF5XCMuBd8XyMZvikrrz5Fk//jFcoBJ9mm9z53jajsKcYoyzPaXnrwrsb57A6gy/A5kw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9PqNs8AqQGGOYvM4jAXoRiMXfmjK3dtj57Wl96z522BFvymibg
	BOcMzXqwsvYBlwZGJnUPWAVAkyu/fo/6SJtkU6zC/wSIa5kz3ieNr13y
X-Gm-Gg: AYBFou3nnrztu55wrZgyF1ZVaQ/cYOtNxJEL3e5RF6HwmBcb6Bx+uS/W4/hbtk7f2J2
	gVpaUI0N1e41ajHKEJau6Xy6zJBZf/xqIPrbBT0NEDJeuzU+wdY6ugNpVBJ1a43lPsB+y/v6F2J
	9Jcb15Ae9AeaZuhD6DcRWYauOdD/15qVM/C741ca5zNJHcjt9w0LNRyaoVA+1ts4oucVhb451wI
	TYyStUaz1Cs4uYkGoqSLHEctoR627u2GoupBLwGjQQtbzh9cAdjj34L6VcjTrTsuseIT1B/qpED
	75cuyQnKkQsXmAqjY2VtXqvyblDi/ULoLFz/i3jIMpXGDgOkp9Aelhjg7Lz7O2JmI34CS+5B0w3
	QnuGx53C45XZobrrSjm47rl1yoWZnYfXGKS//vjFMgisTEtuMRQI0dijmmgbWxe1t2mJAgoCHz2
	O2f2R3rXmip16Tmu93eI/IVVL2l4tfnB0/mWn7j51rao+glIKdro5F36dLlE/MdEQhsfkBa8VPp
	RtQUZuM6STsf8qvjh+p5hNkNuwwY7nKcmI6A06bDBq613vO22cik0311PdK0B1TFF6CG9HZZdK9
	IPD2y2SrcNz7YxisR4CC2kH3D+YbVxMlR2+r97KF4bWeXDrjkOA0eY9UWwcETh7ACRPzG7K9EZN
	puCihuvHhJoKHszd1/ZAO88qCpBuYv/WEqNGsk4oTIqWfGr9fdBXri7dya3PQRFDD5WTLX2uJX9
	YgNHbN0ivHiYVSrZlPeNXjOO4Qv+1v0W4CmUAShzceHKrwj39ChGiz
X-Received: by 2002:a05:600c:a308:b0:4b7:6b0a:a2f6 with SMTP id 5b1f17b1804b1-4b76b0aa492mr50947135e9.21.1794057450936;
        Sat, 07 Nov 2026 05:17:30 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3279f9csm65132675e9.8.2026.11.07.05.17.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 05:17:30 -0800 (PST)
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
Subject: [PATCH v5 3/6] hrtimer: Pause KCOV during deferred rearm
Date: Sat,  7 Nov 2026 14:17:07 +0100
Message-Id: <20261107131710.89264-4-kmehltretter@gmail.com>
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

Deferred hrtimer rearm can run after HARDIRQ_OFFSET is dropped. in_task()
is then true, so KCOV attributes the instrumented timer-reprogramming
subtree to current.

With CONFIG_KCOV_SELFTEST added to x86_64 defconfig, the interrupt
selftest fails under QEMU, detecting spurious coverage in
__hrtimer_rearm_deferred(). The same happens on s390, RISC-V and LoongArch,
which also enable HRTIMER_REARM_DEFERRED.

Excluding the involved files instead would cost their coverage on real
task-context paths, e.g. the hrtimer and timekeeping syscalls.

Pause KCOV with kcov_pause_scope() in an __always_inline wrapper around
__hrtimer_rearm_deferred(), and map the wrapper directly to
__hrtimer_rearm_deferred() when CONFIG_KCOV=n. Use it at all call sites,
including hrtick_schedule_exit(). Callers that may run with KCOV enabled
for current are built without KCOV instrumentation or marked noinstr.
HAVE_NOINSTR_HACK covers pre-GCC-12 x86. The other affected architectures
restrict KCOV to GCC 12 or Clang through ARCH_WANTS_NO_INSTR. This avoids
relying on __no_sanitize_coverage, which is empty before GCC 12. Tested
with GCC 8.1 and 15 on x86_64.

A later patch also pauses __schedule(); keeping hrtick_schedule_exit()
guarded here makes the deferred-rearm fix independent of that scheduler
change.

Fixes: 15dd3a948855 ("hrtimer: Push reprogramming timers into the interrupt return path")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
This patch depends on patch 2, "kcov: Add a kcov_pause guard".

 include/linux/hrtimer_rearm.h | 23 +++++++++++++++++++++--
 kernel/sched/core.c           |  2 +-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/hrtimer_rearm.h b/include/linux/hrtimer_rearm.h
index 12e42721c8e0..b0fd7aaff538 100644
--- a/include/linux/hrtimer_rearm.h
+++ b/include/linux/hrtimer_rearm.h
@@ -12,6 +12,24 @@
 
 void __hrtimer_rearm_deferred(void);
 
+#ifdef CONFIG_KCOV
+#include <linux/kcov.h>
+
+/*
+ * KCOV: Pause outside __hrtimer_rearm_deferred() to suppress entry coverage.
+ * Callers with KCOV enabled for current must be built without KCOV
+ * instrumentation.
+ */
+static __always_inline void hrtimer_rearm_deferred_kcov_paused(void)
+{
+	kcov_pause_scope();
+
+	__hrtimer_rearm_deferred();
+}
+#else
+#define hrtimer_rearm_deferred_kcov_paused()	__hrtimer_rearm_deferred()
+#endif
+
 /*
  * This is purely CPU local, so check the TIF bit first to avoid the overhead of
  * the atomic test_and_clear_bit() operation for the common case where the bit
@@ -43,7 +61,7 @@ hrtimer_rearm_deferred_user_irq(unsigned long *tif_work, const unsigned long tif
 	 */
 	if (unlikely((*tif_work & TIF_REARM_MASK) == _TIF_HRTIMER_REARM)) {
 		clear_thread_flag(TIF_HRTIMER_REARM);
-		__hrtimer_rearm_deferred();
+		hrtimer_rearm_deferred_kcov_paused();
 		/* Don't go into the loop if HRTIMER_REARM was the only flag */
 		*tif_work &= ~_TIF_HRTIMER_REARM;
 		return !*tif_work;
@@ -55,7 +73,7 @@ hrtimer_rearm_deferred_user_irq(unsigned long *tif_work, const unsigned long tif
 static __always_inline void hrtimer_rearm_deferred_tif(unsigned long tif_work)
 {
 	if (hrtimer_test_and_clear_rearm_deferred_tif(tif_work))
-		__hrtimer_rearm_deferred();
+		hrtimer_rearm_deferred_kcov_paused();
 }
 
 /*
@@ -78,6 +96,7 @@ static __always_inline bool hrtimer_test_and_clear_rearm_deferred(void)
 
 #else  /* CONFIG_HRTIMER_REARM_DEFERRED */
 static __always_inline void __hrtimer_rearm_deferred(void) { }
+#define hrtimer_rearm_deferred_kcov_paused()	__hrtimer_rearm_deferred()
 static __always_inline void hrtimer_rearm_deferred(void) { }
 static __always_inline void hrtimer_rearm_deferred_tif(unsigned long tif_work) { }
 static __always_inline bool
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 04b62c16fa8c..3f13170c2939 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1020,7 +1020,7 @@ static inline void hrtick_schedule_exit(struct rq *rq)
 	}
 
 	if (rq->hrtick_sched & HRTICK_SCHED_REARM_HRTIMER)
-		__hrtimer_rearm_deferred();
+		hrtimer_rearm_deferred_kcov_paused();
 
 	rq->hrtick_sched = HRTICK_SCHED_NONE;
 }
-- 
2.39.5
