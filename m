Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848719;
	b=LlHsRjEFIuiGyQrbz4SknMip1Kj7ZcyqeGYl5HpqTno8l5XwsE9dHi6NNMuwkBbKTOgt
	 q3F83vZ0A3UwRH6BrQcSv9mzUko4E2S/5jw6Chg+NKsie0AQDjb8KfGuKyB6TjYrMn/1A
	 E3Cs9HR6eIIwam2MqTtl1LO4PgXhF4exyC2HyGHY+fGCrxQi3wO6QFENjY6DdwZqC67Gt
	 2f58J7F4XpHVxW+ObYEcbOiKTsFzE2OgdgWG/GsR+/iojmdmbTYtUK9hCX4QB5qTfjoLX
	 mgyfjGGtarLhSmj7ONzX/iFDxrBy9Uf67tv0Npg8ugW8jafecK6gACF6C6WAkhRonow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848719;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t3LspBP5IifqhH31Ow+sU+WDEyBPyMVG0HX1yuzTEqY=;
	b=MMjdoZA12MmdK5qKN+F1LlAcQh6NEF7igwfG8Q+ttIRqD47Mw7JxR61SYNzWtT93FSdj
	 RBAoXJbJi9bvh0H0um71KmWV7p2dEZN1IJ7dk/qadqTyJgQZ8MGSD94nZM+oIE91DqYVc
	 aJDob8eEoCfQzKTd/DJOdQx9RZ3XoAj5jUT7i9sjpl8fMU3pyAYi9N3DMxqlfz66XkwLa
	 OQ5kCDhhC+clvJa9AacH30DVKF51NxwhDcfb6/QYzg6hKHlw9mWFZ8X9npcrNDzYn31eQ
	 AgZtAVEgLe/mUz8OFhRlNnddXjIyc4DPG62I8qc4PXprejzjDpg01CUDFBhZ6p8Fr2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EAUM3+kW;
	arc=none smtp.remote-ip=95.215.58.66
Received: from mta1.migadu.com (out-66.mta1.migadu.com [95.215.58.66])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29C606A31A
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A29C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EAUM3+kW
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=h6aK+3Gg2ZdWkLR5+dGPQZWmkIxGQxuJd23JOOgnNJQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848716; v=1; x=1793453516;
 b=EAUM3+kWjVd5G+hJ6XTbehyEh6HsMMXNgb7ANffP3o7ixxddlTGTeZHZBAxLix8Lq7gx+XOv
 dxy+oEc72KI79YpHMbR0zspPfHcTUtukgGp+UfNiFn8Xld3KKKPsuxhmUCHTbdeCypMNmVluG9D
 6QKPSgEy0XRDoxHqEl9Sp7DE=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id 348ec6e6c656b875;
	Sat, 24 Oct 2026 13:31:56 +0000
X-Mizu-Trace-ID: 348ec6e6c656b875
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 14/15] net: Use backlog-NAPI to clean up the defer_list.
Date: Sat, 24 Oct 2026 21:30:38 +0800
Message-Id: <1a7de7c1117d4522891051260363adfb171f42bb.1792847032.git.wen.yang@linux.dev>
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

commit 80d2eefcb4c84aa9018b2a997ab3a4c567bc821a upstream.

The defer_list is a per-CPU list which is used to free skbs outside of
the socket lock and on the CPU on which they have been allocated.
The list is processed during NAPI callbacks so ideally the list is
cleaned up.
Should the amount of skbs on the list exceed a certain water mark then
the softirq is triggered remotely on the target CPU by invoking a remote
function call. The raise of the softirqs via a remote function call
leads to waking the ksoftirqd on PREEMPT_RT which is undesired.
The backlog-NAPI threads already provide the infrastructure which can be
utilized to perform the cleanup of the defer_list.

The NAPI state is updated with the input_pkt_queue.lock acquired. It
order not to break the state, it is needed to also wake the backlog-NAPI
thread with the lock held. This requires to acquire the use the lock in
rps_lock_irq*() if the backlog-NAPI threads are used even with RPS
disabled.

Move the logic of remotely starting softirqs to clean up the defer_list
into kick_defer_list_purge(). Make sure a lock is held in
rps_lock_irq*() if backlog-NAPI threads are used. Schedule backlog-NAPI
for defer_list cleanup if backlog-NAPI is available.

Acked-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            | 25 +++++++++++++++++++++----
 net/core/skbuff.c         |  4 ++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index b399773d123b..d7361bc7635e 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3245,6 +3245,7 @@ static inline void dev_xmit_recursion_dec(void)
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
 
+void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index d5f8831e22e6..317c221c99c2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -246,7 +246,7 @@ static bool use_backlog_threads(void)
 static inline void rps_lock_irqsave(struct softnet_data *sd,
 				    unsigned long *flags)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irqsave(&sd->input_pkt_queue.lock, *flags);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_save(*flags);
@@ -254,7 +254,7 @@ static inline void rps_lock_irqsave(struct softnet_data *sd,
 
 static inline void rps_lock_irq_disable(struct softnet_data *sd)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_lock_irq(&sd->input_pkt_queue.lock);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_disable();
@@ -263,7 +263,7 @@ static inline void rps_lock_irq_disable(struct softnet_data *sd)
 static inline void rps_unlock_irq_restore(struct softnet_data *sd,
 					  unsigned long *flags)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irqrestore(&sd->input_pkt_queue.lock, *flags);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_restore(*flags);
@@ -271,7 +271,7 @@ static inline void rps_unlock_irq_restore(struct softnet_data *sd,
 
 static inline void rps_unlock_irq_enable(struct softnet_data *sd)
 {
-	if (IS_ENABLED(CONFIG_RPS))
+	if (IS_ENABLED(CONFIG_RPS) || use_backlog_threads())
 		spin_unlock_irq(&sd->input_pkt_queue.lock);
 	else if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		local_irq_enable();
@@ -4785,6 +4785,23 @@ static void napi_schedule_rps(struct softnet_data *sd)
 	__napi_schedule_irqoff(&mysd->backlog);
 }
 
+void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu)
+{
+	unsigned long flags;
+
+	if (use_backlog_threads()) {
+		rps_lock_irqsave(sd, &flags);
+
+		if (!__test_and_set_bit(NAPI_STATE_SCHED, &sd->backlog.state))
+			__napi_schedule_irqoff(&sd->backlog);
+
+		rps_unlock_irq_restore(sd, &flags);
+
+	} else if (!cmpxchg(&sd->defer_ipi_scheduled, 0, 1)) {
+		smp_call_function_single_async(cpu, &sd->defer_csd);
+	}
+}
+
 #ifdef CONFIG_NET_FLOW_LIMIT
 int netdev_flow_limit_table_len __read_mostly = (1 << 12);
 #endif
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6111c1bba704..717f23563ea9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6748,6 +6748,6 @@ nodefer:	__kfree_skb(skb);
 	/* Make sure to trigger NET_RX_SOFTIRQ on the remote CPU
 	 * if we are unlucky enough (this seems very unlikely).
 	 */
-	if (unlikely(kick) && !cmpxchg(&sd->defer_ipi_scheduled, 0, 1))
-		smp_call_function_single_async(cpu, &sd->defer_csd);
+	if (unlikely(kick))
+		kick_defer_list_purge(sd, cpu);
 }
-- 
2.25.1

