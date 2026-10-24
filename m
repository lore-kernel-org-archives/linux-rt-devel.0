Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848654;
	b=nsoMwUB/OC1B8SsWlXqRyZI/+IskhB7eS7BJWjgI/Tr2cNM5ec6jI5Q2y8kcyPaJHKAC
	 Q6lpfvc7vEJ3QEw32LzwEbS/6BT+rXsLdMiMH0Sg+BujH0dIaFnHyvpjiIty7Q66j2Iuy
	 PQn2us1OeWBYBJAJ9Kx9R6d0zUM6peTh75Wx/FMAmCUAhm9undeBCZmaAcQudNvoK+HOo
	 STwZo+cWnL9C0ntbdzy0bhVDztmMkK1pIgctuWWHNo4OKleSI18lGOZ+IC7S+lnqqr+8b
	 K+Rxf8w7FGoJhaQkZU6Vd2oE5J10TAXd3HhA8Jof6Av7pqIbRwLBN8rn6OtdrsDKw+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848654;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QbdRzKTr2Rl9eV0O34NZ1XahI9TwRKXXiukfxr79S+o=;
	b=4C1qGONclCCHEXnX+O8QEdgqI4iqlYlEQXrKCnDw3rr8XkjHJ0P81Plj0MizZu5LVyyv
	 NiAVjirttHK0e0y1KwIyvlnA9aaqH1wbnv1smBhknl6VKpJkLZD9yVqV5KeXAlFA53B2e
	 qBCjdagH9zMX47i1BZvmrUmy5TGu1217NuzaFi8jgqhJTAeCn7Cjcn4jYf0OctCTqD3I7
	 NcxQiEdn1+w/I+x9aUOirFwhvHpkQZVIURDo/tcoyniysxbO3SHafyIw2Q2QalD6/eeev
	 VNQ/c01kNPTRUSUP1QCuJs5Nt9kW2vkTvQIemNZTBQ+61/QxgyWz/hLI1YZ+1EqJGIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EWtIqwz7;
	arc=none smtp.remote-ip=95.215.58.17
Received: from mta1.migadu.com (out-17.mta1.migadu.com [95.215.58.17])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A6606A31D
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A7A6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EWtIqwz7
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=hc0b6c2PXRIxYG6V/KHnEs6I6EzoXLJjB2vmU1fF8Bg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848650; v=1; x=1793453450;
 b=EWtIqwz7NDgY2HZ8GJLfPfhnDKXyYsO5RZEZFiTD0VI7RNEvtRIPjBvcvah5CKkvWru+tE3f
 okJAI11XB2SWK4gxpWsD3Xd77pLtZiXn1ELA0ODCSvDKlTg5tGmrTeWLUkBi96duSTeSYMPhqBG
 0ztGlCMUhpHb5jLMahF6B0/8=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id 5cfe49cf9140ddd7;
	Sat, 24 Oct 2026 13:30:49 +0000
X-Mizu-Trace-ID: 5cfe49cf9140ddd7
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 01/15] Revert "net: Avoid the IPI to free the"
Date: Sat, 24 Oct 2026 21:30:25 +0800
Message-Id: <a36d97a1db7d7092f4d506ff0df79e17ac55ec9f.1792847032.git.wen.yang@linux.dev>
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

From: Wen Yang <wen.yang@linux.dev>

This reverts commit 8d152d22d9f056f87875f97aec016a65622abbf0.

The RT-only defer_work workaround covers the deferred-free path but not
RPS remote-backlog scheduling, which still raises NET_RX_SOFTIRQ from the
function-call IPI, so the do_softirq_post_smp_call_flush() warning remains
reachable. The following upstream backlog-NAPI thread backport replaces
both paths with backlog-thread scheduling, so revert the workaround rather
than extend it.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 include/linux/netdevice.h |  4 ----
 net/core/dev.c            | 37 +++++++++----------------------------
 net/core/skbuff.c         |  7 +------
 3 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index fbd3b17463da..e97967ca2760 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3199,11 +3199,7 @@ struct softnet_data {
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
index 5d6ca8510227..f44ffac6cba6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4712,6 +4712,15 @@ static void rps_trigger_softirq(void *data)
 
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
  * Check if this softnet_data structure is another cpu one
  * If yes, queue it to our IPI list and return 1
@@ -6772,30 +6781,6 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 	}
 }
 
-#ifndef CONFIG_PREEMPT_RT
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
-#endif
-
 static __latent_entropy void net_rx_action(struct softirq_action *h)
 {
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
@@ -11620,11 +11605,7 @@ static int __init net_dev_init(void)
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
index 665be0ad4b8d..a66066bc9861 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6746,11 +6746,6 @@ nodefer:	__kfree_skb(skb);
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
-- 
2.25.1

