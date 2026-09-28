Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A24449B2B
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 06:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790577781; cv=none; b=eQYQSIPXnjpMziUqbhpFx9DMTeI65BtIhE7JCGfw9nQuRNxXOORc+3uz26mbJq4IhC5+1fVmAUKZ/sfWMMEhrlyeYQ98xoXaR1PGJYiHjtgcUCP8GK+Jy/Xli9sKEu4I6qN3lvjqAWgsf5x01AqoYeNPvpVKov8B87BjCporTcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790577781; c=relaxed/simple;
	bh=MyorId+LNXDQ3tBXVrKOG34/XwgfgE8q2c/oj8aOYQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jXgTDOAUADNiCTkRD9q5QmBuZc1hQ3d7zRcgxTfKTEVprFYSOybFwnw7LYCdo/t10qK+az3XDQfwMz5+nbU0MJnAZtV6GMzSKy1YoKl4pYu/tkFx7LDNe7ibcdWmUvcRVZBb7xrpddPfpcuuAB+rBW7oNaYElqxISaJi5KFDngw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU9jmhvL; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU9jmhvL"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so1485096f8f.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 27 Sep 2026 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790577776; x=1791182576; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nf3oV330ckZwsw/LTGlRTnwET/Uw246suYw2VNp67Og=;
        b=EU9jmhvLn8RsRnjPnkf/H02KTA302h5oguSI0+jRqyKLaPewUE/plVSfXBNuG9Pcpi
         rR9G8J7PbtYDmUmLJqsy2iak58POPNF31oh33toVoKBHTG9wmoJNxDKQQouACFo01rpE
         jkc59XzjYbhdOk3cMd3Ue0EoM7D7kRyVNzBjYSAfIZPQeIaPpA7QeWCikqg70UlxaSV9
         rGBp0p6JqW0S1Zrz/3YUHHGQQJmp4hI6lShA0XAGguQMX6EfZ2EAszEDEG2nl3+fexIj
         b4vlzmK7b1FcjCZUg3QeCrirLOuUiVJofW9NlGOtjwQMyylefINaDOJxpukgy/YtzMBr
         18oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790577776; x=1791182576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nf3oV330ckZwsw/LTGlRTnwET/Uw246suYw2VNp67Og=;
        b=XYCsA5khTCVMeyA6X6U261sFXYGoh3pFADI62bydJfR8Od9w76ap+oaaU0E6q0GOuy
         s8lq4IesMRLtQkGDNrB4wlaOOCT1+LiPOrbWTCKdnAIvVPSoJJ7vcXRYpW/BOYNxfXtE
         5KIYV0ZDvEkoxjJxWcbhASrNJCMPFsQFExyoSX68D/Jtqf6U18cmCW9Ipbpb7RlC9HGK
         gk/5KibA46BnIbyw9i3813pJ/mm4q9QoEv1ExyXBiuZEqFRwcEY6Lvf6nvznSzJcafkk
         wgwSihNT1dIaRcoWIdQcT3ToBNZKGV4stGWYcyFkT4SW9bhf3/HMSvSO37xp7MsjP2Rm
         4Wrw==
X-Forwarded-Encrypted: i=1; AKwUvBzliorKHgXlL1wF3w1oDzpaXnPcBRO/4ij9XB42BFX95Tx4D143ZdAk2mFtEurKUv8Fq7iuqNCiSuyWVTvRMg==@lists.linux.dev
X-Gm-Message-State: AFq9FYLdeppvo4HQq+7rQSeTlcz+R9jzCYXJNlTTw3HJt75knBu9pqhQ
	Uo6XUDPifd91STzp24PtcXp4Y8RZZHvbdxackMzYQwAfseJnMh9KgEXF
X-Gm-Gg: AYBFou1fdyWKtnFR+sBox/fg71sNcyfB45hpmCw2pBh3xBPJGPjepCbsc+ewWOSa9rx
	psShiMGvLeXxwqSfz2fZbD+DDeZ4nFLZFzG1U91MUoum6Ynok2768ujhEE2UK5kZBY/RcGJohTs
	II/OvrNMD1IC5Wv6fBlfakHBTE0WRskLdAW0Xge2KlqkdF5h0NrpqhcVP92InEEyvHhknCCDhIt
	Pp2jF49szNqQo5R0ppO1Atz2ZrYTmqRLfvFCSkDuTQtb2milqTU0pGqtkFRtUkRxp1P3dGPXuzl
	nXbExWdZdDgn/7Q7RVv6oifZgP3S2vi3N2QCByNsnAViVerQmITxgTcT8RV1Tde8pk51bKr+/zq
	9FSKvFi4L9dwD6OC/pL5ibwSEMuIuCchdjVT004F1AOxGXkKwhkkkpXKb2rENNXt1fjyj2gDx3u
	A9/cKY+zW1nIQYxks1IcncC6gn38F0ZB73wa4oEcBNxtns94YzF4H3lLeEHGoXY4+UJPKMh95We
	yq4QqVV6lHrAYVGJeVko3eSFtKcjRtAypVce5RZspRAKAe0SbAvszZCaoMG+uUslXp2BGWqdMkW
	XZqVC9D0dvV2vtwfIFYy3cQhiKBcRqEg6Wd7+/WcxA6Fe5sUWvf/NYA47kB5MEH9iZCuzBQwM8v
	qgydJow==
X-Received: by 2002:a05:6000:2909:b0:487:ff2:14f5 with SMTP id ffacd0b85a97d-4887d9fa53dmr18309491f8f.4.1790577775945;
        Sun, 27 Sep 2026 23:42:55 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-acba-a601-4494-3582-465b-0eab.310.pool.telefonica.de. [2a02:3100:acba:a601:4494:3582:465b:eab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30b1dfsm26283196f8f.4.2026.09.27.23.42.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 27 Sep 2026 23:42:55 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: netdev@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH net 1/2] netpoll: use a raw lock for the deferred transmit queue
Date: Mon, 28 Sep 2026 08:42:38 +0200
Message-Id: <20260928064239.32456-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260928064239.32456-1-kmehltretter@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netpoll_send_skb() calls __netpoll_send_skb() with hard interrupts
disabled. When direct transmission cannot complete, the latter queues
the skb with skb_queue_tail(). The sk_buff_head lock may sleep on
PREEMPT_RT:

  BUG: sleeping function called from invalid context
  in_atomic(): 0, irqs_disabled(): 1, non_block: 0
  rt_spin_lock
  skb_queue_tail
  netpoll_send_skb

The delayed transmit worker has the same problem when it requeues a busy
skb with skb_queue_head() after disabling interrupts.

Add a dedicated raw spinlock and use the unlocked skb queue helpers under
it. Keep raw critical sections limited to queue operations. During
cleanup, splice the queue to a private list before freeing its skbs.

Fixes: b6cd27ed3388 ("netpoll per device txq")
Cc: stable@vger.kernel.org # 6.12+
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 include/linux/netpoll.h |  1 +
 net/core/netpoll.c      | 75 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 70 insertions(+), 6 deletions(-)

diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 1c6b1eec5efd6..e20e0592e9349 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -47,6 +47,7 @@ struct netpoll_info {
 	struct semaphore dev_lock;
 
 	struct sk_buff_head txq;
+	raw_spinlock_t txq_lock;
 
 	struct delayed_work tx_work;
 
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index fe1e0cda5d6bf..e0cfcb05468e2 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -79,6 +79,68 @@ static netdev_tx_t netpoll_start_xmit(struct sk_buff *skb,
 	return status;
 }
 
+/*
+ * Transmit paths can access txq with hard IRQs disabled. Use a raw lock
+ * because the skb queue lock may sleep on PREEMPT_RT.
+ */
+static bool netpoll_txq_empty(struct netpoll_info *npinfo)
+{
+	unsigned long flags;
+	bool empty;
+
+	raw_spin_lock_irqsave(&npinfo->txq_lock, flags);
+	empty = skb_queue_empty(&npinfo->txq);
+	raw_spin_unlock_irqrestore(&npinfo->txq_lock, flags);
+
+	return empty;
+}
+
+static struct sk_buff *netpoll_txq_dequeue(struct netpoll_info *npinfo)
+{
+	unsigned long flags;
+	struct sk_buff *skb;
+
+	raw_spin_lock_irqsave(&npinfo->txq_lock, flags);
+	skb = __skb_dequeue(&npinfo->txq);
+	raw_spin_unlock_irqrestore(&npinfo->txq_lock, flags);
+
+	return skb;
+}
+
+static void netpoll_txq_queue_head(struct netpoll_info *npinfo,
+				   struct sk_buff *skb)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&npinfo->txq_lock, flags);
+	__skb_queue_head(&npinfo->txq, skb);
+	raw_spin_unlock_irqrestore(&npinfo->txq_lock, flags);
+}
+
+static void netpoll_txq_queue_tail(struct netpoll_info *npinfo,
+				   struct sk_buff *skb)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&npinfo->txq_lock, flags);
+	__skb_queue_tail(&npinfo->txq, skb);
+	raw_spin_unlock_irqrestore(&npinfo->txq_lock, flags);
+}
+
+static void netpoll_txq_purge(struct netpoll_info *npinfo)
+{
+	struct sk_buff_head purge;
+	unsigned long flags;
+
+	__skb_queue_head_init(&purge);
+
+	raw_spin_lock_irqsave(&npinfo->txq_lock, flags);
+	skb_queue_splice_init(&npinfo->txq, &purge);
+	raw_spin_unlock_irqrestore(&npinfo->txq_lock, flags);
+
+	__skb_queue_purge(&purge);
+}
+
 static void queue_process(struct work_struct *work)
 {
 	struct netpoll_info *npinfo =
@@ -86,7 +148,7 @@ static void queue_process(struct work_struct *work)
 	struct sk_buff *skb;
 	unsigned long flags;
 
-	while ((skb = skb_dequeue(&npinfo->txq))) {
+	while ((skb = netpoll_txq_dequeue(npinfo))) {
 		struct net_device *dev = skb->dev;
 		struct netdev_queue *txq;
 		unsigned int q_index;
@@ -107,7 +169,7 @@ static void queue_process(struct work_struct *work)
 		HARD_TX_LOCK(dev, txq, smp_processor_id());
 		if (netif_xmit_frozen_or_stopped(txq) ||
 		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
-			skb_queue_head(&npinfo->txq, skb);
+			netpoll_txq_queue_head(npinfo, skb);
 			HARD_TX_UNLOCK(dev, txq);
 			local_irq_restore(flags);
 
@@ -282,7 +344,7 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	}
 
 	/* don't get messages out of order, and no recursion */
-	if (skb_queue_len(&npinfo->txq) == 0 && !netpoll_owner_active(dev)) {
+	if (netpoll_txq_empty(npinfo) && !netpoll_owner_active(dev)) {
 		struct netdev_queue *txq;
 
 		txq = netdev_core_pick_tx(dev, skb, NULL);
@@ -314,7 +376,7 @@ static netdev_tx_t __netpoll_send_skb(struct netpoll *np, struct sk_buff *skb)
 	}
 
 	if (!dev_xmit_complete(status)) {
-		skb_queue_tail(&npinfo->txq, skb);
+		netpoll_txq_queue_tail(npinfo, skb);
 		schedule_delayed_work(&npinfo->tx_work,0);
 	}
 	ret = NETDEV_TX_OK;
@@ -362,7 +424,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		}
 
 		sema_init(&npinfo->dev_lock, 1);
-		skb_queue_head_init(&npinfo->txq);
+		__skb_queue_head_init(&npinfo->txq);
+		raw_spin_lock_init(&npinfo->txq_lock);
 		INIT_DELAYED_WORK(&npinfo->tx_work, queue_process);
 
 		refcount_set(&npinfo->refcnt, 1);
@@ -397,7 +460,7 @@ static void rcu_cleanup_netpoll_info(struct rcu_head *rcu_head)
 	struct netpoll_info *npinfo =
 			container_of(rcu_head, struct netpoll_info, rcu);
 
-	skb_queue_purge(&npinfo->txq);
+	netpoll_txq_purge(npinfo);
 	kfree(npinfo);
 }
 
-- 
2.53.0
