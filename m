Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848705;
	b=XY5ys7fe6kCD3ihYtQwAKeB08nGSlmGJAnYsbNXkX7++Ypq2kgHqm4i2lwpY1pd6P6RI
	 y52/hTH3BfCNWhALgq0BarDXGCLjzt3/dUPKAaXesxTlN4bw+WtEx7JHJ/Zg1gRFITxMp
	 KCFcJBKZWECDWJBAstKev9CjlkGxMVeWWIGU6siiX9wjvwknsTGP4SjicOTRrHHeayE9I
	 EaHp2iRb1zXGG2BkDwC38urTuy7Ep7Z5iyUuVg93cwPHwTH2ZtpvTdEdfvDZgn28+csZo
	 vBOQqazLJjeykV3F21S6V+skunztLKmU9JeB/runx80+zzXgiUCmsqUyP+9CV2OGbZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848705;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GUdLmw/It2ZoJKaackiJFGRfe74HC3N5b97qCl9l23c=;
	b=x9y+NjO9Jk7UIt9jKpnC4UHNT/lrLRyRhzjUUzjQpX9NLyK8K+EAhLDqiGu3Q5P0cjpZ
	 YROyP8dLQREbhEN10RCYMaNvhqr3AWXhYm2VfKv/MAaYATLpzvxl4xY9OicFLQXhyaBxR
	 BTn0E8QVsI3ZqgzhdklJpxf0HiVGJR2TAsRuGLRZn3j2jhqssMjSP+LfOAylPBy6d4mbS
	 Tra+nsaZQgI6I6uBZ7dkV4hUiYrhlR2AxN1rO+87DIaL60vVI5qvSCiRXwbApPbrpYpwZ
	 F/mq4TmHk6APRF412RRS8V8kvIQRk4wjmYI842df28TAZ2dNoh8Xz0L4sRPoQklTUbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uJRL2m9M;
	arc=none smtp.remote-ip=95.215.58.57
Received: from mta1.migadu.com (out-57.mta1.migadu.com [95.215.58.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38619606A31A
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:31:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38619606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uJRL2m9M
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=whcFEX3jnzSYg1cdi6AXcu2fgt3Rhuv4tn7VIPvBHdY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848703; v=1; x=1793453503;
 b=uJRL2m9M9R6zG96XKcERSjtzbRW/1Um8wtX8vq0e1H+dWUZ2q8DTGI+TE3fd/Po+QlWgmg7r
 38LDSXuoTJbenulN0FaFEfp+lJDJ7PmmdjOjHRgPEPOKIdqYtopLNUArrWrP1jPnox+rf4WRXMv
 XeXXMVK/C4Ul5u5ufx0uD/oc=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id 2bc40e3ff4cad9b2;
	Sat, 24 Oct 2026 13:31:43 +0000
X-Mizu-Trace-ID: 2bc40e3ff4cad9b2
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 12/15] net: Remove conditional threaded-NAPI wakeup based on task state.
Date: Sat, 24 Oct 2026 21:30:36 +0800
Message-Id: <e39bb1587f501a40f865e0ce731c68eedaf0e744.1792847032.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1792847031.git.wen.yang@linux.dev>
References: <cover.1792847031.git.wen.yang@linux.dev>
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
index ab012a7eee94..0b2cf2f0f5a4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4485,13 +4485,7 @@ static inline void ____napi_schedule(struct softnet_data *sd,
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
@@ -6716,8 +6710,6 @@ static int napi_poll(struct napi_struct *n, struct list_head *repoll)
 
 static int napi_thread_wait(struct napi_struct *napi)
 {
-	bool woken = false;
-
 	set_current_state(TASK_INTERRUPTIBLE);
 
 	while (!kthread_should_stop()) {
@@ -6726,15 +6718,13 @@ static int napi_thread_wait(struct napi_struct *napi)
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

