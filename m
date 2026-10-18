Received: from mta1.migadu.com (out-35.mta1.migadu.com [95.215.58.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2A239B48D
	for <linux-rt-devel@lists.linux.dev>; Sun, 18 Oct 2026 18:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792347364; cv=none; b=GAZEVd24Vlpyb4muMoqKvXkmBsKcQLZdBWksE7VmUb8wcIMT8Dlu4HlRYZFDW6Q7HCeMSWx5C5hc3s/8ewfPfPJHsozmYmDAIbtaNl3ktM98ar0r6mOQddoEzqGdfi+OEwjRjjZqJCd7QLRVsfLDN/sdvrlIicFsGf4O/m6LGX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792347364; c=relaxed/simple;
	bh=KZltL9xNR26M29IGr7uwfCCiSufJHXqMktuk7hcLj+I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jRFocM7pkAnTqvsb9xg+Jl+PgTiPdhpsvpzSHzP5LCIy9wzvl6XiT+w4q6WP5h+qOSQR132gHT0tPPnwRzdP/n1l/G4sYev8qDmvTkcYASb8eH9RwFU7CiSgRfZoz+oTDtjW/q0egwitfgs3iQqcMv9ym6HzFVoIRgexEJwvho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bs94OGcW; arc=none smtp.client-ip=95.215.58.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bs94OGcW"
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=KZltL9xNR26M29IGr7uwfCCiSufJHXqMktuk7hcLj+I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792347360; v=1; x=1792952160;
 b=Bs94OGcW0WNoQGct4CSIK56pO6zIs1/2qJI7lZZkiR9PfHEzxvmlB+YO5baVj2B1Ap/rXwf9
 ZxtxVZzuCD1nhuJJcqWpmVD1kjSbUCrw8yWUByk5KHynwc+DLIqmTwRksgE6929336Tg/HUE/Uf
 d4k8yIHGz4sAHCMsPdf5E01k=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 399901fc37758485;
	Sun, 18 Oct 2026 18:16:00 +0000
X-Mizu-Trace-ID: 399901fc37758485
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.6-rt 4/5] net: Use backlog-NAPI to clean up the defer_list.
Date: Mon, 19 Oct 2026 02:15:26 +0800
Message-Id: <22309a8b876c53b9bfb05d642b0c16ed626b2a8c.1792345413.git.wen.yang@linux.dev>
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
index 3510177cd1ba..60d7d6d1a260 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3361,6 +3361,7 @@ static inline void dev_xmit_recursion_dec(void)
 	__this_cpu_dec(softnet_data.xmit.recursion);
 }
 
+void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 void __netif_schedule(struct Qdisc *q);
 void netif_schedule_queue(struct netdev_queue *txq);
 
diff --git a/net/core/dev.c b/net/core/dev.c
index dbd6c16b7838..abc75727f58d 100644
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
@@ -4890,6 +4890,23 @@ static void napi_schedule_rps(struct softnet_data *sd)
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
index 3f7c4e1d7c76..c5d8a24a8652 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6914,8 +6914,8 @@ nodefer:	__kfree_skb(skb);
 	/* Make sure to trigger NET_RX_SOFTIRQ on the remote CPU
 	 * if we are unlucky enough (this seems very unlikely).
 	 */
-	if (unlikely(kick) && !cmpxchg(&sd->defer_ipi_scheduled, 0, 1))
-		smp_call_function_single_async(cpu, &sd->defer_csd);
+	if (unlikely(kick))
+		kick_defer_list_purge(sd, cpu);
 }
 
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
-- 
2.25.1

