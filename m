Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF0C3C5848
	for <linux-rt-devel@lists.linux.dev>; Thu,  8 Oct 2026 20:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791492418; cv=none; b=MTnPHvHTrDrnz5jr1kp1YMKEN2iAue4JULk6tF1cB4YuJa3XGEEeYK3xh9nFKEIfIPSZnGaZv5UIZTxpBtgz4Ua6EyAQVPhy2NsGJ1dKcYaMkbGK/rWBRWFNakuA6qL/uNHhXCn4eNeuof78DTCZU9Aw9EocUGaOimI5/ZZmUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791492418; c=relaxed/simple;
	bh=8pVDE6gKB5Gw0t6qxjwvlekmFJOu3ZyamWouP1sB23Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uITnjfoquiFYHb68pCjPjf7RGAtC97kruQUW28UpjP2cyzKUc22XZvoExijCdPkPPkIV2J6V9vf95cH9+Ud4dqpOQRtQNble+s298asePeB9MH64mOQq3u10HOvHEDDCHu11AwXMHCXEJCqvs1PoZPXzD9wupR8LvOuf1YCGUNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksdfzaaq; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksdfzaaq"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a020e65269so26294965e9.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 08 Oct 2026 13:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791492415; x=1792097215; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9mZZmE9NIEQo+14wGuifnEY8q83z61KsgfZ3VlGz8po=;
        b=ksdfzaaqMlqFmVdb52zqXqmlh9CxuY3Obez3My5joXa7aJjIewvA+rN/VozmX3AKg5
         BZhW/PHuYTgil+ZUYzjaCZl8PGVGS8Dvw+EvPQWf1/QnMaI0HzwL+sCNjh7rdB7zZgwp
         7xraMww/iZX+4N2qrT3bFDYdxi7HjVtXPRSzo6J5BoDpov3GY7EnRwl013U0B/y81Qwo
         pcvSChPBNjZ1jg32KFYmkQ4lSSgh/jCLkYJeTaDR68fJPb8jVNyA66pdxf9x1dt5ebJs
         Kx2NRNqNQbPOUnQJRxDwRaeZd0/KO/J/slq/dErCl6hcMngKr3yOM3WjfYecX2bFsfeR
         e/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791492415; x=1792097215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9mZZmE9NIEQo+14wGuifnEY8q83z61KsgfZ3VlGz8po=;
        b=W/mDWYeU5/ofelq4RvcxkR4+p1QWyW8fxU65sP/NKqTOnjMPh/vsX0HD1+P5Rwunse
         cEmbQZPoU4iObOfe632uWKRN7TAMvOPEMbGfRhZ7aPQmKOgOWM42tQzbFp7GefQzjxcH
         /mI0+mTKHlhKUujzxwx3fmcVTKqDKmoL/ng8620ebVj2clYtR5G1FETccjhw/wMAExPw
         /ZHe6Vvo1PxjgD7JLj/+XzQAMVqKpaqAwOOyCHok8A9ydvg5PJkAxaSLsj/s5Drwg1Sw
         r1173Lz6EzTKKDRSgS8VhTZ9sbOXc7QodEefYwDm4DnOp6/nxoV8KtEeyIb8mCpxiplW
         ZYsQ==
X-Forwarded-Encrypted: i=1; AKwUvBxgjJv9JXsDO5i/LaN41EwxlUwRhgDjk4vGDBE58LZT6MwG15/a6T+vZcapTqUrONGvAVx8d86LeMp0FJWh0A==@lists.linux.dev
X-Gm-Message-State: AFuF++lQHl3xX4uNUNH5lTUHv9MY1XUUS58mGMybsI5HWPnfrAigGHCk
	T3hN1dvNLoCJkQbaYiqzRH2zDSCWOeamhkWGZZUvAIBbqveAgBqD4+8L
X-Gm-Gg: AYBFou3bqip4ESBO4ZCYADIiWJ97luKlk+h/BNLh1Fgy09KU/Ty0hX5JaTsOTTOM32c
	SsFCYfH/1f1pE/4tXZxN9v0fNMIHv3DyMkQNQVFQ6etQBNJnQz/wsJ/0GVzhPbdkXEygogOfGPX
	zmGX4/wBi2khXcgqQT/UC274AIpFmPUupj/vSWrgC6ugW+AghsJAJhbEqj8WSngYe+CLb35VV+3
	uUyMK9NSvRmXfQKEHypYZ25c8w9k3fxtjOgUZ+02aOLkzs2/Xb07IsU+/+MeADmeAYbzVwOlC6W
	sg45MyhYE2RrkCSwQ0e0/nkWhDImXRjYMkkxPAI9KThYb7E4QFAFrmrekFQ2G32thUI2qaTthnc
	EgJ1oqcseqKMGuvsxJ/FsPUCt190Qlfeb7xkAwBr9vhCOXHCu9MBeQnPce8ZbWztTLhu+xXTOzu
	KIcI/A9DsnkOtcOtXkdZdVko1rBt8k4MI62oDPbIrmesUfoqHJ17UZVueKI3LUbbYymZXWteAWa
	5ivbPCY0JFzhV5HKZ5EcwhfevXbc1Ey23t+mroJPGmt+JSeg4Ofd4ZgGKGGsDoC9JCRjdOjyBwd
	IgCGWA==
X-Received: by 2002:a05:600c:a00e:b0:4a0:1a18:b742 with SMTP id 5b1f17b1804b1-4a1800d3de4mr132110965e9.2.1791492414594;
        Thu, 08 Oct 2026 13:46:54 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9abdaa5sm154528f8f.35.2026.10.08.13.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 13:46:53 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [RFC PATCH] entry: Account the deferred hrtimer rearm as hardirq context for lockdep
Date: Fri,  9 Oct 2026 01:46:49 +0500
Message-ID: <20261008204649.62265-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On a desktop debug kernel (PROVE_LOCKING, KASAN, LOCKDEP_CHAINS_BITS=19)
lockdep switches itself off after about two days of uptime with
"BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!", and locking is not validated
until the next reboot. In the last such boot the pool ran out after 46.6
hours, and a fifth of it, 533509 of 2621431 chain hlocks in 63838 of
344717 chains, had been created by the deferred hrtimer rearm on return
from interrupt.

Make lockdep account that rearm as part of the timer interrupt it
belongs to.

Commit 15dd3a948855
("hrtimer: Push reprogramming timers into the interrupt return path")
moved the reprogramming of the clock event device out of the timer
interrupt into the interrupt return path. On return to kernel mode
irqentry_exit_to_kernel_mode_after_preempt() performs it after
irq_exit_rcu() has already left lockdep's hardirq context. lockdep
therefore records hrtimer_bases.lock and the timekeeper sequence count
as taken by the interrupted context, on top of the locks that context
holds, and every distinct held-lock stack an interrupt hits adds two
lock chains. When the rearm runs from irq_enter_rcu() or
__irq_exit_rcu() it is still inside lockdep's hardirq context, and there
the same acquisitions reuse one pair of chains.

The dependencies recorded on the return path are "lock held with
interrupts enabled -> hrtimer_bases.lock". Such a lock is hardirq-unsafe
and hrtimer_bases.lock is hardirq-safe, so a path in the reverse
direction is already reported by the irq-safety checks without these
edges.

Re-enter lockdep's hardirq context around the rearm on the kernel return
path. The return to user mode path holds no locks and is left alone, as
is the rearm in __schedule(), which runs under the runqueue lock.

With the same kernel tree, configuration and workload, one hour of
uptime including a full kernel build, the chains of this shape, with
hrtimer_bases.lock and optionally the timekeeper sequence count on top
of a held-lock stack outside the scheduler, go from 13266 (96187 chain
hlocks, 15.9% of those in use) to 4. Those 4 come from clock_was_set(),
which takes cpus_read_lock() and each CPU's hrtimer_bases.lock and reads
the clock under it.

Fixes: 15dd3a948855 ("hrtimer: Push reprogramming timers into the interrupt return path")
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
Not touched, and a question for you: the rearm in hrtick_schedule_exit()
also stacks chains on the preempted task's locks, under the runqueue lock.
Chains with hrtimer_bases.lock under the runqueue lock, this rearm among
them, were 4.9% of the pool in the boot above. Should it get the same
treatment?

Tested on x86_64 only (Ryzen 9 7950X), PREEMPT_DYNAMIC. Not tested on
PREEMPT_RT or on the other architectures that use generic entry with
HRTIMER_REARM_DEFERRED.

Method: tree 0c2669a9f4a1 plus local fixes, the same .config
(LOCKDEP_CHAINS_BITS=19, LOCKDEP_BITS=16) and gcc 16.2.1 for both kernels,
built with and without this patch. Each kernel booted fresh and sat at the
login screen with sleep inhibited; a full kernel build (make clean,
make -j32) started at 600 s of uptime, and /proc/lockdep_chains and
/proc/lockdep_stats were read at 3600 s. One run per kernel.

                                                       without    with
lock chains                                              97283   81257
chain hlocks used                                       603921  485100
hrtimer_bases.lock on held-lock stacks outside the
  scheduler (the shape above)                            13266       4
  their chain hlocks                                     96187      12
hrtimer_bases.lock under the runqueue lock (untouched)    5208    4665
hardirq chains starting with hrtimer_bases.lock             11      11
direct dependencies                                      36118   34332
deferred rearms in 2 s (hrtimer_rearm with deferred=1)     534     578

A chain is counted in the third row when it is in process or softirq
context, hrtimer_bases.lock sits on a non-empty held-lock stack with no
scheduler lock in it, nothing or one sequence count follows it, and
debugobjects' obj_hash lock never follows hrtimer_bases.lock on that same
stack (that would be the stack's own hrtimer_start()/hrtimer_cancel()).

The four left with the patch:

  cpu_hotplug_lock -> hrtimer_bases.lock [-> &____s->seqcount#2]
  &dev->mutex -> cpu_hotplug_lock -> hrtimer_bases.lock [-> &____s->seqcount#2]

Beyond the removed chains, the total dropped by another 2764 chains
(2.8%); one pair of runs does not separate that from run-to-run spread,
the untouched runqueue-lock row moved by 10% between the two runs.

Peter suggested looking for such patterns in lockdep_chains here:
https://lore.kernel.org/all/20250310112315.GS16878@noisy.programming.kicks-ass.net/

 include/linux/irq-entry-common.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 0bb6c03481fa..521cc30cef08 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -468,6 +468,21 @@ static inline void irqentry_exit_to_kernel_mode_preempt(struct pt_regs *regs,
 		irqentry_exit_cond_resched();
 }
 
+/*
+ * The deferred hrtimer rearm is the tail of the timer interrupt, moved to the
+ * interrupt return path so that it runs after a possible reschedule. By now
+ * irq_exit_rcu() has left lockdep's hardirq context. Re-enter it for the
+ * rearm, so that the hrtimer base lock and the timekeeping sequence count are
+ * not chained onto the locks held by the interrupted context, which would add
+ * new lock chains for every lock stack an interrupt hits.
+ */
+static __always_inline void irqentry_hrtimer_rearm_deferred(void)
+{
+	lockdep_hardirq_enter();
+	hrtimer_rearm_deferred();
+	lockdep_hardirq_exit();
+}
+
 /**
  * irqentry_exit_to_kernel_mode_after_preempt - Establish trace, lockdep and RCU state
  * @regs:	Pointer to current's pt_regs
@@ -491,7 +506,7 @@ irqentry_exit_to_kernel_mode_after_preempt(struct pt_regs *regs, irqentry_state_
 		 */
 		if (state.exit_rcu) {
 			instrumentation_begin();
-			hrtimer_rearm_deferred();
+			irqentry_hrtimer_rearm_deferred();
 			/* Tell the tracer that IRET will enable interrupts */
 			trace_hardirqs_on_prepare();
 			lockdep_hardirqs_on_prepare();
@@ -502,7 +517,7 @@ irqentry_exit_to_kernel_mode_after_preempt(struct pt_regs *regs, irqentry_state_
 		}
 
 		instrumentation_begin();
-		hrtimer_rearm_deferred();
+		irqentry_hrtimer_rearm_deferred();
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
-- 
2.56.0

