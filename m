Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848722;
	b=twDCrzEmGlSZqqsCBQN4686fPuttn2a/0B9ur1XymsCiDpje/IY8S0fv5vyZmi1TpcuW
	 R1eobaEt3xPwnqc9y2mC5w08v33InK8X+nmZbp76ovCu6mxTv3Dcf12mXGesKFqVYx013
	 BmxCexR1hku5hS3KNNc86tRya27O0Zn6vMfb81+GHnUm4fpJnM01vojIidhrMtAi9JASV
	 TJeSNVXCin+CA0CncEZwN7qUgj7HHz6SLx28OQyoqvWchwBhkLpvOVilthwRFVXQQY132
	 FqztYMCE1vItnF6xHuIfABrqWigjrdH7B5zTvAnytFpUy4fYFqw0VQhfQRmt03vZCAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848722;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GvXA5G/d5rtRhjHJNLiOl1BfEfqAeqrxlrCvKiBth9w=;
	b=hFY9DvJ5UOciy68ECFjOyRQWj4uq6n4jsROEVkq/2Ouahi6B4FJo7VLvRM9BxdaDd7a/
	 FqU5qZP6TG/fcmazgB9p5ixagJywfKykamRyRfILGbPhgEwNAV4WrM/0Uf0b5BP4+Q/rL
	 gCRAWjEa25WQIvAURlq1/AeYvXJ/qi83O7MLsYO3h3OIR3WJIhN0wzeOUUIX7N3BC0gP/
	 caN8NTl4l4Gs/Hpdiz42TeIydaaPlGKC04TERBq0ZzOJUDxAIUy0JiQSoWvz8u5xNf7rA
	 KAFeQ8KpEJCifYMtf7lt7jTYPfWjyLVutv8MONQMo4jhweWDtgPj6CVzZyMAdzBptwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=R9SsvetN;
	arc=none smtp.remote-ip=95.215.58.69
Received: from mta1.migadu.com (out-69.mta1.migadu.com [95.215.58.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1AF606A31B
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB1AF606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=R9SsvetN
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=R+pI384S0Q9r6atCJ0SvFSIfiwHu6LC+34s4EEpq3to=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848719; v=1; x=1793453519;
 b=R9SsvetNnYv6jyxvdWHkQEwAcS9CJIa/UEsllv9n6KgWOVj+fYqBdxYwguGrDGN+8QtnC9X8
 oJMT1oL96lGy0xUI75Og3IHJlN73v0HW7J1Onctrd5JdJW+oNDnGsLU2NHgcfw7Ulhyj5XYkc92
 1ljC1qhlSLXMEiEpEVhU1CVA=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id 9d141d559e62e5e8;
	Sat, 24 Oct 2026 13:31:59 +0000
X-Mizu-Trace-ID: 9d141d559e62e5e8
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 15/15] net: Rename rps_lock to backlog_lock.
Date: Sat, 24 Oct 2026 21:30:39 +0800
Message-Id: <b5a680ca3e528f11845ccc41512ded20bc72434d.1792847032.git.wen.yang@linux.dev>
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

commit 765b11f8f4e20b7433e4ba4a3e9106a0d59501ed upstream.

The rps_lock.*() functions use the inner lock of a sk_buff_head for
locking. This lock is used if RPS is enabled, otherwise the list is
accessed lockless and disabling interrupts is enough for the
synchronisation because it is only accessed CPU local. Not only the list
is protected but also the NAPI state protected.
With the addition of backlog threads, the lock is also needed because of
the cross CPU access even without RPS. The clean up of the defer_list
list is also done via backlog threads (if enabled).

It has been suggested to rename the locking function since it is no
longer just RPS.

Rename the rps_lock*() functions to backlog_lock*().

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/dev.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 317c221c99c2..f1ac29d7144e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -243,8 +243,8 @@ static bool use_backlog_threads(void)
 
 #endif
 
-static inline void rps_lock_irqsave(struct softnet_data *sd,
-				    unsigned long *flags)
+static inline void backlog_lock_irq_save(struct softnet_data *sd,
+					 unsigned long *flags)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
@@ -252,7 +252,7 @@ static inline void rps_lock_irqsave(struct softnet_data *sd,
 		local_irq_save(*flags);
 }
 
-static inline void rps_lock_irq_disable(struct softnet_data *sd)
+static inline void backlog_lock_irq_disable(struct softnet_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irq(&sd->input_pkt_queue.lock);
@@ -260,8 +260,8 @@ static inline void rps_lock_irq_disable(struct softnet_data *sd)
 		local_irq_disable();
 }
 
-static inline void rps_unlock_irq_restore(struct softnet_data *sd,
-					  unsigned long *flags)
+static inline void backlog_unlock_irq_restore(struct softnet_data *sd,
+					      unsigned long *flags)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
@@ -269,7 +269,7 @@ static inline void rps_unlock_irq_restore(struct softnet_data *sd,
 		local_irq_restore(*flags);
 }
 
-static inline void rps_unlock_irq_enable(struct softnet_data *sd)
+static inline void backlog_unlock_irq_enable(struct softnet_data *sd)
 {
 	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irq(&sd->input_pkt_queue.lock);
@@ -4790,12 +4790,12 @@ void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu)
 	unsigned long flags;
 
 	if (use_backlog_threads()) {
-		rps_lock_irqsave(sd, &flags);
+		backlog_lock_irq_save(sd, &flags);
 
 		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
 			__napi_schedule_irqoff(&sd->backlog);
 
-		rps_unlock_irq_restore(sd, &flags);
+		backlog_unlock_irq_restore(sd, &flags);
 
 	} else if (!cmpxchg(&sd->defer_ipi_scheduled, 0, 1)) {
 		smp_call_function_single_async(cpu, &sd->defer_csd);
@@ -4857,7 +4857,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 	reason = SKB_DROP_REASON_NOT_SPECIFIED;
 	sd = &per_cpu(softnet_data, cpu);
 
-	rps_lock_irqsave(sd, &flags);
+	backlog_lock_irq_save(sd, &flags);
 	if (!netif_running(skb->dev))
 		goto drop;
 	qlen = skb_queue_len(&sd->input_pkt_queue);
@@ -4866,7 +4866,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 enqueue:
 			__skb_queue_tail(&sd->input_pkt_queue, skb);
 			input_queue_tail_incr_save(sd, qtail);
-			rps_unlock_irq_restore(sd, &flags);
+			backlog_unlock_irq_restore(sd, &flags);
 			return NET_RX_SUCCESS;
 		}
 
@@ -4881,7 +4881,7 @@ static int enqueue_to_backlog(struct sk_buff *skb, int cpu,
 
 drop:
 	sd->dropped++;
-	rps_unlock_irq_restore(sd, &flags);
+	backlog_unlock_irq_restore(sd, &flags);
 
 	dev_core_stats_rx_dropped_inc(skb->dev);
 	kfree_skb_reason(skb, reason);
@@ -5977,7 +5977,7 @@ static void flush_backlog(struct work_struct *work)
 	local_bh_disable();
 	sd = this_cpu_ptr(&softnet_data);
 
-	rps_lock_irq_disable(sd);
+	backlog_lock_irq_disable(sd);
 	skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->input_pkt_queue);
@@ -5985,7 +5985,7 @@ static void flush_backlog(struct work_struct *work)
 			input_queue_head_incr(sd);
 		}
 	}
-	rps_unlock_irq_enable(sd);
+	backlog_unlock_irq_enable(sd);
 
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
 		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
@@ -6003,14 +6003,14 @@ static bool flush_required(int cpu)
 	struct softnet_data *sd = &per_cpu(softnet_data, cpu);
 	bool do_flush;
 
-	rps_lock_irq_disable(sd);
+	backlog_lock_irq_disable(sd);
 
 	/* as insertion into process_queue happens with the rps lock held,
 	 * process_queue access may race only with dequeue
 	 */
 	do_flush = !skb_queue_empty(&sd->input_pkt_queue) ||
 		   !skb_queue_empty_lockless(&sd->process_queue);
-	rps_unlock_irq_enable(sd);
+	backlog_unlock_irq_enable(sd);
 
 	return do_flush;
 #endif
@@ -6125,7 +6125,7 @@ static int process_backlog(struct napi_struct *napi, int quota)
 
 		}
 
-		rps_lock_irq_disable(sd);
+		backlog_lock_irq_disable(sd);
 		if (skb_queue_empty(&sd->input_pkt_queue)) {
 			/*
 			 * Inline a custom version of __napi_complete().
@@ -6141,7 +6141,7 @@ static int process_backlog(struct napi_struct *napi, int quota)
 			skb_queue_splice_tail_init(&sd->input_pkt_queue,
 						   &sd->process_queue);
 		}
-		rps_unlock_irq_enable(sd);
+		backlog_unlock_irq_enable(sd);
 	}
 
 	return work;
-- 
2.25.1

