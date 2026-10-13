Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1D348034C
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 07:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791875607; cv=none; b=gT1+Rm2XMen9y07ZLzG7MXzvD7heEho1JX7NbcPvse7hzpZ/M4ULEVnLZpHtUx9Y9eN8Rg1T2ZeC9XZZOy9xV8KZdy/GSb3EaY4fOKiFc+ha0NUY+X0EdUZzm5BBcVcXms7kVCE2fWXRdbKQFW4SgJ4IA+mh+hSADZJC3dPbHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791875607; c=relaxed/simple;
	bh=6n1/bklGvRXQfMIJUUkJMJYnLo5+/iBbEmbwF8vc8t8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tYF9sMxN+L6NTKL+UMFhPjXKNwv5Teuduu7xaRdtBzZzB0zwby5dgdjnTFk3pOXZLk/IR0WdodHXRtLWQXv0Rp1M1Mdnb8bz/71B9Xud4IJetVFBaru7jH/mBnIGb+HORjA9xS5s50owc2RaXmRysC3lLPInmYos3FyT1FeSEiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuG2PMV4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuG2PMV4"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso1489881f8f.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791875604; x=1792480404; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p+Wtn59KvC+feTOOdrVuSvpYHmlcgQavv6c7dXxLqcI=;
        b=kuG2PMV4tLd0ssVUuxJoRNRI+tYOtZZ1Dbmhx5/bW/LG7y1IzCfxJ+Yu1Le5rGobzA
         Gi37PvNkwbujLDd/q5oxRXjqxYGPqcOiHj/MfC8YR6oQ0T7o2sWLN1wUSk4bwJliXNyk
         XUaXsgV2nqCc+YcgruOVMhXZZkoCr9YvED2vbplleLnugC/YcAyVTLBIZkDoUQFzXXYZ
         ZR8ZyfOU7rKPolCk8gEbMsbvgvv4f2zA7qim3sEVyJvD6mbIT4dBC3NvrPJShVmSJ8aC
         5U0csdyIn65cLP08q4hxmcniOMMfQVFyl+0TJEM1tJe2QwbAkhIT5FIEV80uAotF5/4P
         hejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791875604; x=1792480404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p+Wtn59KvC+feTOOdrVuSvpYHmlcgQavv6c7dXxLqcI=;
        b=ENRGXVpW0WfE2je7s5L/tWdOgsq5eCWEGCOZdffq35wqu5Vn7DRwVoxz4nEeMUtdmb
         HV3YllAVk3KzRiq4l+ezYAQgC4eaSxz8xWDgDHdhrl7we31uXVpchzZ/dhtwzp7zanmy
         IKfr3YaH9N2Eq0RURPs4HKHzydTXSVKffrIh57HQMgpSxbcsILLV1z9t2qctDUROvX8u
         w0H95Vf6qDnBhU9B6A3xfLZlNYry9JC4JEbd5m2LAvNd+OhJapXAjcRMPCcgumrjaB4R
         BXZSZ1dnIFAg5p24DMJprRByj4kqxOMk3V6amwq1xU7giISmDI7WYSyMC2ewm+wqfccH
         lZqA==
X-Forwarded-Encrypted: i=1; AKwUvBxkcSE4MhtwKwfLzFixOGRVrJwRfYKvnCP05SX83x7pFCwOREgMuKDwINrtjQkD/w6xgK+1XrkrtCqgNg6EDg==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ7fWFhYB5jlbCXhs8QTrgIvSWdwwM5oww7Psu5TpD0kyUZATfj
	mD2qBE+kBqoF1jkFSBT9l++tPUssyiP1bvf+NLeZzdop/Uuosz2hCmVl
X-Gm-Gg: AYBFou0CDTkdbj5xkMZtMP5gKsJdy7qYmsE1Sc+a7nJ1qWdoOiHeYPbBuCwIOJXb0Qu
	cPt4E1W1+TFi3aq9jhbMUlkoiPjpispFiNkZ2AK9dIOLGvmez9iAMDdjbTrjU2W3/UWI92Od2Io
	9cuQTY5NH9s8nYkg1LkZpPa6SLJzR4ai5atwv+BgfbVHxBFcfTHuzWkQj6VA0ofWETVNEIQDhCe
	WRB44skB3510kOkH2X2WZ6GC5FyOCZuTBl9EmRthKWDkbtygHSSmjp8iyQzUv7G7KraexuPR5QB
	Ru4Njw+CeIB/bwkM2Rv8yMXGSiTHba5XtZtihCurVy5rigyqZqaXhT2e40bGayRpRttXuMR3tML
	T99KvdOzYvC1u+JNAUzHxgpXpZMY6LNJR+6iaPGAIULE6Qn2R5m+v1n+2bhQYyd5fY6HJ9FZle2
	mswblCj6m54hu3SowzBekDM40VUz8ZPt5zCHCR6FCD0b/dVuE1uI76tdnZAFdmLtQhRZ1XSuj3x
	MD2jH1K9in7hgmh/2ZgKpH6npNuvDoiroE32jjPlfvlZnh7+9JlXLESmsCxr6y10OwV7iY=
X-Received: by 2002:adf:f341:0:b0:487:197a:5c1f with SMTP id ffacd0b85a97d-48dbaae84e0mr17789931f8f.49.1791875604065;
        Tue, 13 Oct 2026 00:13:24 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0ab4764sm3289111f8f.25.2026.10.13.00.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:13:22 -0700 (PDT)
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
Subject: [PATCH v2] entry: Account the deferred hrtimer rearm as hardirq context for lockdep
Date: Tue, 13 Oct 2026 12:13:18 +0500
Message-ID: <20261013071318.33300-1-mikhail.v.gavrilov@gmail.com>
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
v2:
- Say in the comment above the helper why the return to user mode is
  left alone (Peter). No code change; the numbers below are from v1.

v1: https://lore.kernel.org/all/20261008204649.62265-1-mikhail.v.gavrilov@gmail.com/

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

 include/linux/irq-entry-common.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
index 0bb6c03..c74b5c8 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -468,6 +468,25 @@ static inline void irqentry_exit_to_kernel_mode_preempt(struct pt_regs *regs,
 		irqentry_exit_cond_resched();
 }
 
+/*
+ * The deferred hrtimer rearm is the tail of the timer interrupt, moved to the
+ * interrupt return path so that it runs after a possible reschedule. By now
+ * irq_exit_rcu() has left lockdep's hardirq context. Re-enter it for the
+ * rearm, so that the hrtimer base lock and the timekeeping sequence count are
+ * not chained onto the locks held by the interrupted context, which would add
+ * new lock chains for every lock stack an interrupt hits.
+ *
+ * The rearm on return to user mode needs no such annotation: no locks are
+ * held there, so it uses the same lock chains as the rearm in hardirq
+ * context.
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
@@ -491,7 +510,7 @@ irqentry_exit_to_kernel_mode_after_preempt(struct pt_regs *regs, irqentry_state_
 		 */
 		if (state.exit_rcu) {
 			instrumentation_begin();
-			hrtimer_rearm_deferred();
+			irqentry_hrtimer_rearm_deferred();
 			/* Tell the tracer that IRET will enable interrupts */
 			trace_hardirqs_on_prepare();
 			lockdep_hardirqs_on_prepare();
@@ -502,7 +521,7 @@ irqentry_exit_to_kernel_mode_after_preempt(struct pt_regs *regs, irqentry_state_
 		}
 
 		instrumentation_begin();
-		hrtimer_rearm_deferred();
+		irqentry_hrtimer_rearm_deferred();
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
-- 
2.43.0

