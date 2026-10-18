Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC8636167E
	for <linux-rt-devel@lists.linux.dev>; Sun, 18 Oct 2026 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792347352; cv=none; b=uzVBCXwwnjx+kYdbFxI87UvCMQIIQMRfRriCOBccUto/6FtrDzmcdIWn1wHJWHB2CyPSz7tyxvzX6Gz4GvGqUQeN8qOamtSR34MjKGDiwY8N7TcAL1hlJxriABVtWCbRZlFfJv3rqq2RpSuBo4Oe05DyRfJsxxePqeKzRza580U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792347352; c=relaxed/simple;
	bh=BjxH9M4CzofdT+daVpizR78PvGADule6EhG2rLW46GM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u4ZUHPrYUiy6Bxu4hsg3c8CS7JjHG0Fs/nOX0nRNq348HKvMkAWXJxIYQcInfwvbh287c+4s57gViD4a5cCco1WoL4HDdVq3Y1FPSrWGsojA2KWOOlU72a9ICDlmwBCPaUGS0/Y4pHsgxBZum9yofIr+PCT37AHlE0IOSMMSK94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LJBn52lk; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LJBn52lk"
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=BjxH9M4CzofdT+daVpizR78PvGADule6EhG2rLW46GM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792347348; v=1; x=1792952148;
 b=LJBn52lkd1dCzVXi4Um90WE1pMpCD4+m0MzeR/cjgyoMAtUvIY7bJkc/zY5Qh8VbeJLwSSyC
 yJfY4B6bhjEtn7ZbML97KaQrsvwkn1gcavdd14/4UOmtS/aJzudFKaR5MOd9kw83jNHj9RIvenI
 2UAdDuq3rCu2AZbBP9Ve7rX0=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta10.migadu.com with ESMTPS id 3e6df812dc697190;
	Sun, 18 Oct 2026 18:15:48 +0000
X-Mizu-Trace-ID: 3e6df812dc697190
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.6-rt 1/5] Revert "net: Avoid the IPI to free the"
Date: Mon, 19 Oct 2026 02:15:23 +0800
Message-Id: <aae57b347236c1d4c767e570dda5c5a95f8f8830.1792345413.git.wen.yang@linux.dev>
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

From: Wen Yang <wen.yang@linux.dev>

This reverts commit 1f7514c9c75d41974744b46ca7665fa8d6d6adab.

The RT-only defer_work workaround covers the deferred-free path but not
RPS remote-backlog scheduling, which still raises NET_RX_SOFTIRQ from the
function-call IPI, so the do_softirq_post_smp_call_flush() warning remains
reachable. The following upstream backlog-NAPI thread backport replaces
both paths with backlog-thread scheduling, so revert the workaround rather
than extend it.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/linux/netdevice.h |  4 ----
 net/core/dev.c            | 39 +++++++++------------------------------
 net/core/skbuff.c         |  7 +------
 3 files changed, 10 insertions(+), 40 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 46f525292fb9..3510177cd1ba 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3319,11 +3319,7 @@ struct softnet_data {
 	int			defer_count;
 	int			defer_ipi_scheduled;
 	struct sk_buff		*defer_list;
-#ifndef CONFIG_PREEMPT_RT
 	call_single_data_t	defer_csd;
-#else
-	struct work_struct	defer_work;
-#endif
 };
 
 static inline void input_queue_head_incr(struct softnet_data *sd)
diff --git a/net/core/dev.c b/net/core/dev.c
index 2caeb73a74bb..39ae67377358 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4821,6 +4821,15 @@ static void rps_trigger_softirq(void *data)
 
 #endif /* CONFIG_RPS */
 
+/* Called from hardirq (IPI) context */
+static void trigger_rx_softirq(void *data)
+{
+	struct softnet_data *sd = data;
+
+	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
+	smp_store_release(&sd->defer_ipi_scheduled, 0);
+}
+
 /*
  * After we queued a packet into sd->input_pkt_queue,
  * we need to make sure this queue is serviced soon.
@@ -6789,32 +6798,6 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 	}
 }
 
-#ifndef CONFIG_PREEMPT_RT
-
-/* Called from hardirq (IPI) context */
-static void trigger_rx_softirq(void *data)
-{
-	struct softnet_data *sd = data;
-
-	__raise_softirq_irqoff(NET_RX_SOFTIRQ);
-	smp_store_release(&sd->defer_ipi_scheduled, 0);
-}
-
-#else
-
-static void trigger_rx_softirq(struct work_struct *defer_work)
-{
-	struct softnet_data *sd;
-
-	sd = container_of(defer_work, struct softnet_data, defer_work);
-	smp_store_release(&sd->defer_ipi_scheduled, 0);
-	local_bh_disable();
-	skb_defer_free_flush(sd);
-	local_bh_enable();
-}
-
-#endif
-
 static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
@@ -11876,11 +11859,7 @@ static int __init net_dev_init(void)
 		INIT_CSD(&sd->csd, rps_trigger_softirq, sd);
 		sd->cpu = i;
 #endif
-#ifndef CONFIG_PREEMPT_RT
 		INIT_CSD(&sd->defer_csd, trigger_rx_softirq, sd);
-#else
-		INIT_WORK(&sd->defer_work, trigger_rx_softirq);
-#endif
 		spin_lock_init(&sd->defer_lock);
 
 		init_gro_hash(&sd->backlog);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 16beed62e9e3..3f7c4e1d7c76 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6914,13 +6914,8 @@ nodefer:	__kfree_skb(skb);
 	/* Make sure to trigger NET_RX_SOFTIRQ on the remote CPU
 	 * if we are unlucky enough (this seems very unlikely).
 	 */
-	if (unlikely(kick) && !cmpxchg(&sd->defer_ipi_scheduled, 0, 1)) {
-#ifndef CONFIG_PREEMPT_RT
+	if (unlikely(kick) && !cmpxchg(&sd->defer_ipi_scheduled, 0, 1))
 		smp_call_function_single_async(cpu, &sd->defer_csd);
-#else
-		schedule_work_on(cpu, &sd->defer_work);
-#endif
-	}
 }
 
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
-- 
2.25.1

