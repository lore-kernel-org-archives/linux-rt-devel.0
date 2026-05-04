Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ABB3DFC90
	for <linux-rt-devel@lists.linux.dev>; Mon,  4 May 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777905848; cv=none; b=jBLVNIMqo2DbCwL55z82cdDw1sFSynj7HzxnjM4V45dJcIHBESNyo0PH+8/hfDEESCTzKvP34RQiEY0q1PSQukX62VdeVWWgfiX8pXyUVCzhQ6IW293VgnHa2JNJ4NO9NCtmaAcqwM857b4yxWvvKRKjA3CZkKuBjHtxQyopdF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777905848; c=relaxed/simple;
	bh=4tBqnJLm+altkayC6UROJ0S349UF2t5XvnfxAIrYjPA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BuhZsUc1dozxk9IyI+hddQytQhyHzwVV+YydIqfdpTa0hyK71QmSFOmqBSf8IkUi1HbsCxBrYYwS5tgbdC6glL0AEvPTe8nZuvnKnL3wYsPhHYOQZedWGNJgeZHh9B1bLNQS/mqU1zeoL709dohMt/JbuZAEVHKUhOAszfmfPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KVACXtBQ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KVACXtBQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1777905846; x=1809441846;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4tBqnJLm+altkayC6UROJ0S349UF2t5XvnfxAIrYjPA=;
  b=KVACXtBQs0hrtVKJPcU80HOubGtPuar9sfJ3b4uZH747p58+LvIPnJ4L
   MfNNUsa45K70mUlYlpfK3cizSRpEzRiki9fkRbk3zcxorFlupOSLG6kuu
   A8EqGoq5pj7Um+ePdxccSrdQ6gbA5uHW0+uUZ9ActQo+JI8AxDs/DlkrC
   /pjm7D+CmESxBnl2xc0uO59DR3ic50nJLQlpuHpuqiWV204KjkydApwxV
   6B5+fiGsV7Xy93lociry1SlVyJj3I6En16Wd9+S8s956Ay6MyxIosHA3v
   ZdZVoiAdjUsfTAvxnV4OFLlAs2K+7JLhbJCKW+z3FCP7RVUP4Q81ZXUku
   A==;
X-CSE-ConnectionGUID: WV/KM/BVRTu9/vFRH3AT8g==
X-CSE-MsgGUID: o846igGHQhy0nyaNR1v0nw==
X-IronPort-AV: E=Sophos;i="6.23,215,1770620400"; 
   d="scan'208";a="224242092"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 May 2026 07:44:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Mon, 4 May 2026 07:44:04 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Mon, 4 May 2026 07:44:01 -0700
From: Daniel Machon <daniel.machon@microchip.com>
Date: Mon, 4 May 2026 16:43:43 +0200
Subject: [PATCH net 2/4] net: sparx5: fix sleep in atomic context in MAC
 table access
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260504-misc-fixes-sparx5-lan969x-v1-2-6604306b5743@microchip.com>
References: <20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com>
In-Reply-To: <20260504-misc-fixes-sparx5-lan969x-v1-0-6604306b5743@microchip.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Steen Hegelund
	<Steen.Hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Bjarni Jonasson
	<bjarni.jonasson@microchip.com>, Lars Povlsen <lars.povlsen@microchip.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Steen Hegelund
	<steen.hegelund@microchip.com>, <linux-rt-devel@lists.linux.dev>
X-Mailer: b4 0.14.3

sparx5_mact_learn() is called from .ndo_set_rx_mode with
netif_addr_lock_bh held, but takes sparx5->lock which is a mutex.
A mutex may block, which is not allowed from atomic context.

Convert sparx5->lock to a spinlock, switch the hardware completion poll
to readx_poll_timeout_atomic(), and use spin_lock_bh() since no caller
runs in hardirq context.

Observed with CONFIG_PROVE_LOCKING, CONFIG_DEBUG_SPINLOCK,
CONFIG_DEBUG_MUTEXES and CONFIG_DEBUG_ATOMIC_SLEEP enabled:

  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:591
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 217, name: ip
  preempt_count: 201, expected: 0
  Call trace:
   __might_resched+0x144/0x248
   __might_sleep+0x48/0x7c
   __mutex_lock+0x74/0x850
   mutex_lock_nested+0x24/0x30
   sparx5_mact_learn+0x78/0x100
   sparx5_mc_sync+0x40/0x54
   __hw_addr_sync_dev+0xc4/0x170
   sparx5_set_rx_mode+0x4c/0x58
   __dev_set_rx_mode+0x64/0xa4
   __dev_open+0x1ec/0x26c

Fixes: b37a1bae742f ("net: sparx5: add mactable support")
Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 .../ethernet/microchip/sparx5/sparx5_mactable.c    | 24 +++++++++++-----------
 .../net/ethernet/microchip/sparx5/sparx5_main.h    |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
index 2bf9c5f64151..0797cfa32916 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_mactable.c
@@ -50,7 +50,7 @@ static int sparx5_mact_wait_for_completion(struct sparx5 *sparx5)
 {
 	u32 val;
 
-	return readx_poll_timeout(sparx5_mact_get_status,
+	return readx_poll_timeout_atomic(sparx5_mact_get_status,
 		sparx5, val,
 		LRN_COMMON_ACCESS_CTRL_MAC_TABLE_ACCESS_SHOT_GET(val) == 0,
 		TABLE_UPDATE_SLEEP_US, TABLE_UPDATE_TIMEOUT_US);
@@ -92,7 +92,7 @@ int sparx5_mact_learn(struct sparx5 *sparx5, int pgid,
 		addr = pgid - consts->n_ports;
 	}
 
-	mutex_lock(&sparx5->lock);
+	spin_lock_bh(&sparx5->lock);
 
 	sparx5_mact_select(sparx5, mac, vid);
 
@@ -111,7 +111,7 @@ int sparx5_mact_learn(struct sparx5 *sparx5, int pgid,
 
 	ret = sparx5_mact_wait_for_completion(sparx5);
 
-	mutex_unlock(&sparx5->lock);
+	spin_unlock_bh(&sparx5->lock);
 
 	return ret;
 }
@@ -164,7 +164,7 @@ bool sparx5_mact_getnext(struct sparx5 *sparx5,
 	u32 cfg2;
 	int ret;
 
-	mutex_lock(&sparx5->lock);
+	spin_lock_bh(&sparx5->lock);
 
 	sparx5_mact_select(sparx5, mac, *vid);
 
@@ -183,7 +183,7 @@ bool sparx5_mact_getnext(struct sparx5 *sparx5,
 			*pcfg2 = cfg2;
 	}
 
-	mutex_unlock(&sparx5->lock);
+	spin_unlock_bh(&sparx5->lock);
 
 	return ret == 0;
 }
@@ -194,7 +194,7 @@ int sparx5_mact_find(struct sparx5 *sparx5,
 	int ret;
 	u32 cfg2;
 
-	mutex_lock(&sparx5->lock);
+	spin_lock_bh(&sparx5->lock);
 
 	sparx5_mact_select(sparx5, mac, vid);
 
@@ -212,7 +212,7 @@ int sparx5_mact_find(struct sparx5 *sparx5,
 			ret = -ENOENT;
 	}
 
-	mutex_unlock(&sparx5->lock);
+	spin_unlock_bh(&sparx5->lock);
 
 	return ret;
 }
@@ -222,7 +222,7 @@ int sparx5_mact_forget(struct sparx5 *sparx5,
 {
 	int ret;
 
-	mutex_lock(&sparx5->lock);
+	spin_lock_bh(&sparx5->lock);
 
 	sparx5_mact_select(sparx5, mac, vid);
 
@@ -233,7 +233,7 @@ int sparx5_mact_forget(struct sparx5 *sparx5,
 
 	ret = sparx5_mact_wait_for_completion(sparx5);
 
-	mutex_unlock(&sparx5->lock);
+	spin_unlock_bh(&sparx5->lock);
 
 	return ret;
 }
@@ -440,7 +440,7 @@ static void sparx5_mact_pull_work(struct work_struct *work)
 	vid = 0;
 	memset(mac, 0, sizeof(mac));
 	do {
-		mutex_lock(&sparx5->lock);
+		spin_lock_bh(&sparx5->lock);
 		sparx5_mact_select(sparx5, mac, vid);
 		spx5_wr(LRN_SCAN_NEXT_CFG_SCAN_NEXT_UNTIL_FOUND_ENA_SET(1),
 			sparx5, LRN_SCAN_NEXT_CFG);
@@ -451,7 +451,7 @@ static void sparx5_mact_pull_work(struct work_struct *work)
 		ret = sparx5_mact_wait_for_completion(sparx5);
 		if (ret == 0)
 			ret = sparx5_mact_get(sparx5, mac, &vid, &cfg2);
-		mutex_unlock(&sparx5->lock);
+		spin_unlock_bh(&sparx5->lock);
 		if (ret == 0)
 			sparx5_mact_handle_entry(sparx5, mac, vid, cfg2);
 	} while (ret == 0);
@@ -493,7 +493,7 @@ int sparx5_mact_init(struct sparx5 *sparx5)
 {
 	char queue_name[32];
 
-	mutex_init(&sparx5->lock);
+	spin_lock_init(&sparx5->lock);
 
 	/*  Flush MAC table */
 	spx5_wr(LRN_COMMON_ACCESS_CTRL_CPU_ACCESS_CMD_SET(MAC_CMD_CLEAR_ALL) |
diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
index d5e6644ff124..8ef4050ceecc 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.h
@@ -373,7 +373,7 @@ struct sparx5 {
 	u32 features;
 	void __iomem *regs[NUM_TARGETS];
 	int port_count;
-	struct mutex lock; /* MAC reg lock */
+	spinlock_t lock; /* MAC reg lock */
 	/* port structures are in net device */
 	struct sparx5_port *ports[SPX5_PORTS];
 	enum sparx5_core_clockfreq coreclock;

-- 
2.34.1

