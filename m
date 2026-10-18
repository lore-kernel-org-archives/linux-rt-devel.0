Received: from mta1.migadu.com (out-32.mta1.migadu.com [95.215.58.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6679F39B48D
	for <linux-rt-devel@lists.linux.dev>; Sun, 18 Oct 2026 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792347356; cv=none; b=oHXnfJtDdHR3EqqkOxI32r71lOATmGyb3HwXghEx1/RxP9C8ddVZLfvnWRwvPELIoW6M3qGiXp1uyhFNz1kXDJIY3yx4j8+OR1nNdOsiYGkgc5gOQypQtAPC/uUlV02ds3Tn+w5AsC3Op4KFU+St4COYAPLQQPTd6IAYKr0aYG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792347356; c=relaxed/simple;
	bh=20biJv+gYi7Qwrkn2S4IPsr/34SYjGdyvzidLkDwbV4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNuJLjahSRia9/jp8VbB+LvJggwQIwHRwzBhIe37j0yTiSxWk58UFtTGGs70f9eP2/3br5AX4wAwbRJsTyf0KXV26GkOnB+8iTy88vwlzza/PxB5Q8FZVdduvrrfsrwMwD1+tLhqEKr4SLBM4n5zjiNZ6phWmee35U3Gb/jxfv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e755vFwW; arc=none smtp.client-ip=95.215.58.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e755vFwW"
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=20biJv+gYi7Qwrkn2S4IPsr/34SYjGdyvzidLkDwbV4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792347352; v=1; x=1792952152;
 b=e755vFwW2HFiZpbVPkMLmnd8k5G1KJH3DQ+nqiRNLPQYnpsyXkYDyDrpdUFs3n2wWXZoRIfM
 oBLMjQZ+GT/bShw4FJNYOwe11pRM/0rH3umVGodztMbOdtLZInyHrpaQ1CHRB/+ZzT01bU1caHE
 VTSgzKfca/k2LaOP7s9rG3Dc=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id d80abcb8b9211ce3;
	Sun, 18 Oct 2026 18:15:52 +0000
X-Mizu-Trace-ID: d80abcb8b9211ce3
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.6-rt 2/5] net: Remove conditional threaded-NAPI wakeup based on task state.
Date: Mon, 19 Oct 2026 02:15:24 +0800
Message-Id: <5b78687b2230329845936b951ee561223b27c1fa.1792345413.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1792345413.git.wen.yang@linux.dev>
References: <cover.1792345413.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

commit 56364c910691f6d10ba88c964c9041b9ab777bd6 upstream.

A NAPI thread is scheduled by first setting NAPI_STATE_SCHED bit. If
successful (the bit was not yet set) then the NAPI_STATE_SCHED_THREADED
is set but only if thread's state is not TASK_INTERRUPTIBLE (is
TASK_RUNNING) followed by task wakeup.

If the task is idle (TASK_INTERRUPTIBLE) then the
NAPI_STATE_SCHED_THREADED bit is not set. The thread is no relying on
the bit but always leaving the wait-loop after returning from schedule()
because there must have been a wakeup.

The smpboot-threads implementation for per-CPU threads requires an
explicit condition and does not support "if we get out of schedule()
then there must be something to do".

Removing this optimisation simplifies the following integration.

Set NAPI_STATE_SCHED_THREADED unconditionally on wakeup and rely on it
in the wait path by removing the `woken' condition.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/dev.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 39ae67377358..5ba7b5ff1c87 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4589,13 +4589,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
 		 */
 		thread = READ_ONCE(napi->thread);
 		if (thread) {
-			/* Avoid doing set_bit() if the thread is in
-			 * INTERRUPTIBLE state, cause napi_thread_wait()
-			 * makes sure to proceed with napi polling
-			 * if the thread is explicitly woken from here.
-			 */
-			if (READ_ONCE(thread->__state) != TASK_INTERRUPTIBLE)
-				set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
+			set_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
 			wake_up_process(thread);
 			return;
 		}
@@ -6751,8 +6745,6 @@ static int napi_poll(struct napi_struct *n, struct list_head *repoll)
 
 static int napi_thread_wait(struct napi_struct *napi)
 {
-	bool woken = false;
-
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	while (!kthread_should_stop()) {
@@ -6761,15 +6753,13 @@ static int napi_thread_wait(struct napi_struct *napi)
 		 * Testing SCHED bit is not enough because SCHED bit might be
 		 * set by some other busy poll thread or by napi_disable().
 		 */
-		if (test_bit(NAPI_STATE_SCHED_THREADED, &napi->state) || woken) {
+		if (test_bit(NAPI_STATE_SCHED_THREADED, &napi->state)) {
 			WARN_ON(!list_empty(&napi->poll_list));
 			__set_current_state(TASK_RUNNING);
 			return 0;
 		}
 
 		schedule();
-		/* woken being true indicates this thread owns this napi. */
-		woken = true;
 		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	__set_current_state(TASK_RUNNING);
-- 
2.25.1

