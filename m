Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012066.outbound.protection.outlook.com [40.93.195.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074B25AEC55
	for <linux-rt-devel@lists.linux.dev>; Tue,  8 Sep 2026 19:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895268; cv=fail; b=SyQYceAns8Od275ro94s9Fq/3YgaE2RYwQVtfN2lodeuj2XtD08yoz4VikcFg92enVb+K0VUO5CA4gXEp6pqKc0xXNxlSbQGWmhFWBSqg1ZufhvY0A5UaeD32+yoMXaY2iwjP3yYcRZNdUFRV7sZYiL0mGZ752b2+JKcP/gEDHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895268; c=relaxed/simple;
	bh=HbJkWX2FDZjd+kCROoaAp65l2oqSopXDjnST6eKyWIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=anObqc9V+4DmTLzhr0MenJK6M/ss6oTjG2CwnkEqEL9+S1TfgHTucuD8zmWYACZDxOZFZTqXtOyOKTaoshXllJPD3HT/XlZvwI/SaWc4vRzKtmH/7bt4N7u2HnzNj+K1rXYJd5AZEmlYoIk9AldNzRfkQxmO5iesBhlpN3u+bQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hyLC9FiA; arc=fail smtp.client-ip=40.93.195.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hyLC9FiA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4cjIMCkHeOdWJWKF+f61bW3odezXh5MgoYClxr0yt1rQqsL/TwZGie/th+sWEZpQR4ik8e3x8U/m+mvo2zmm591GMFPTWzT1K89mbO8rehCn0NwjLQp59QkpbqoIrgjGS68tbAhN04VYK+QAJNncGLfCyA6OFtvrd/tWET6+OP2iHoV0Eel++xuSm2T7WCayd8M33AEaaOz0/xyLQ+5XZ862Ujdr+wiG8hhppoV71U6J6cgme7DAHMZtXbJ9BiJ2SVpXO0dRodwKfgIVY+8xP+K3TuYh62Gd6TQFHEBTOOJ3quAFy0a2xtFNJHEs6rmd3NsCPpJOnexHqSBptmwQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2TR2rfQJZAdozzzGJmS6EUcaEISc8MfL70mFCGxrZE=;
 b=ycQaB9v6QalgRBRrEb0Uxotbu0QLVBlxSBIuCpB4P9pujqNzEvliDRDMDxh3F2R5yoZtL25QoGJW9AvYpdN5QA9vr8GvIRE/UTbRxcMJNKZTDKQEtypHrVIjQwyJk47/L7g0Iyp0PeV54vY/xNzz8v1Qys40V8nBccvbuhRGd9LJ2HpwpwY+QUS1VLj9wDo2z2LkZ09APfVGT7mgavAHPLHiVmTGf5tdKnDoMKvkTnMFi5qF2mHA6LKgYcYxGN67El7jj7+/3jyvFKVtqabwCTDGbno7Q/f1Y+RlKkn6sPOdDw2Oz4k4xfKZOHiAw5HL7AzKalIyd62bVptzRt4txg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2TR2rfQJZAdozzzGJmS6EUcaEISc8MfL70mFCGxrZE=;
 b=hyLC9FiAJ+0oR82VXBW3Fb2iMGQ4Qw6a+l0jCFqEA5MTbfE+/Hs5I5HG3/zXVG3aLF6JJjqeXkOGGPglld5VBHa2rXH5gBtEiEjL5QR9Eg8oFU7laAZtm6SgAmEXH4DTg93nivTGM9J12ndRLYNdkRyR+gNFtW1VxwBGbOxsUHk=
Received: from CH0PR04CA0005.namprd04.prod.outlook.com (2603:10b6:610:76::10)
 by LV8PR12MB9715.namprd12.prod.outlook.com (2603:10b6:408:2a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 19:20:54 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::47) by CH0PR04CA0005.outlook.office365.com
 (2603:10b6:610:76::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 19:20:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:20:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:46 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 14:20:41 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Wed, 9 Sep 2026 00:49:55 +0530
Subject: [PATCH net-next v2 7/8] net: xilinx: tsn: add the endpoint TX data
 path
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-patches_v2_external-v2-7-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
In-Reply-To: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
To: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, Michal Simek <michal.simek@amd.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Clark Williams
	<clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rt-devel@lists.linux.dev>, Srinivas Neeli <srinivas.neeli@amd.com>,
	<neelisrinivas18@gmail.com>, <git@amd.com>
X-Mailer: b4 0.16.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|LV8PR12MB9715:EE_
X-MS-Office365-Filtering-Correlation-Id: 624c38b3-3dcb-4ddd-31eb-08df0dde4cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|23010399003|1800799024|82310400026|11063799006|56012099006|10067099003|921020|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yCwMMLekk1pGyE0DZvjhYgAp/kEVoGZuznmHjrhyd9gwSmmNIAy2YdJmtH0/mhcePhiZLz6EC1WT1aUobruar0tqeZ9QAXuNhxikB3fbh8Ak/0EVDb1KgUvJGIsdXN+VWCNT3kM/TlFY7GekWLF8wWQOoaIvy0Ogl9Ice4LHyLrVNg/I8uTEubpcp9jtlkWyxrXHphzuSI696Wd2lvIaORyG1a3i12I8cIoYHch1FG6qAMq72IaZ0lDENXb0DncjJWiVazsarzYaL5h9Tb9tUU7QB79xFHpX1zJzr4VjZgaSVZSl8XjtIBCqHS20fP1J9uMAM49760XVDRadZi+Qf59uxAHt4eMSpe69s3Nen86yA7alGj56LL9LWJwLPY2xSCf+9vt5eVeqxKXpPfjSa0uPdfzqOylE6UaV1in29yQGCOuyldQ0K4ALTCNeyJIJ4Pos8CSOPFegkS9UvYB9buQGcaszQWOEuHpqFGmMGO9YWhbJprCBhheicVK7s6QuLzvyVyNRAul01IsCsj6nw+8VbsNRfDNV7199F9vjfjYx5yBXUBnaJyBQdZ2/Hjy/iqe65Eb4ZSsy5hsDIR48r1PaV/iBqUHGgOuEuVYsDDLiqNvjmUWvH5dnjI03FZyYw10T9sHtHm+wp6dOCZg9vLn52Lys/z2lpZ6mu6ZoffaRaAQ4kkvHhbBGShnn2JzVfR8VJNAUkqlqa8cbbzVcb98esPSqAqv/K9bJjtqOQdv+/oRVe8oO3sUj8maoxu0I
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(23010399003)(1800799024)(82310400026)(11063799006)(56012099006)(10067099003)(921020)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bcghSC86s1xKur2HuLP4dEhRU8vY2SAjhKBCBQUFG0SEi0YKYmk94IXDNX4RvHn+aIjD4aI65WVXO1l6rqEiCyRzF2qexZJINes5cfl1azTZlUGUIqKyEqP8pSW5/Ymx6L3MU4kMEh4bnxUpv5AmrG9wMyFZOh/GmU1FMM7/v//XJcMWEi/kAfiFi+m3p7r+sZ8wkHwr3d8rdG+HSNZ88ZudeysH0L7+Yx2I/bbc88pfuoTU8N/GyA/JbB9CEJsWvrmb9IoWSimWbAgMwsic2uUVguyMvdg8seveOpTqw7ZK64LjzgdVA8sveZn0b3tZWuOX2mPs+hN3xML8pPXW5WsDNgYKPQjbb7Z+ylvEIcaD+haKF8TvvGjv7OaDNkmbVNgHjC54CQik2v8Y6TEECVsASlHEZke+Ess6D/hqGq5BHXG6wJvZluBPGM1mtBPf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:20:53.0773
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624c38b3-3dcb-4ddd-31eb-08df0dde4cbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9715

Add the transmit path so the endpoint can send frames.

Look up the physical DMA channel for the frame's queue through the map
built at probe, map the frame and submit it to that channel. Stop the
queue when the ring runs out of space, and wake it from the completion
callback once a slot frees up.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v2:
- Take the scatterlist entry count from skb_to_sgvec() instead of assuming
  nr_frags + 1, so dma_map_sg() cannot walk past the end of the list.
- Check dmaengine_submit() with dma_submit_error() before advancing the ring
  head and charging BQL, and drop the frame if the submit fails.
- Publish the ring head with WRITE_ONCE(), paired with the READ_ONCE() on the
  completion side.
- Take the ring size from the channel instead of the compile-time constant.
- Use dmaengine_prep_slave_sg() instead of calling the ops member directly.
- Move tx_lock into the per-channel struct, mirroring rx_lock, so independent
  TX queues do not serialise on one device-wide lock.
- Narrow the tx_lock kernel-doc to what it actually protects.
- Mark the ring_tail store in the completion callback with WRITE_ONCE() to
  match the READ_ONCE() readers.
- Use the spinlock_bh guard class in the completion callback so it matches the
  spin_lock_bh() in the xmit path.
- Index tx_chans directly by logical queue in ep_start_xmit() and drop the
  phys_chan/dma_dev locals, so the transmit path no longer re-derives the
  channel through tx_dma_chan_map.
---
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c | 150 +++++++++++++++++++++++-
 1 file changed, 149 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index 9ed1170794e0..9e9a45169681 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -29,6 +29,8 @@
 #include <linux/timer.h>
 #include <linux/types.h>
 
+#include <net/netdev_queues.h>
+
 #include "xilinx_tsn.h"
 
 #define DRIVER_NAME			"xilinx_tsn_ep"
@@ -82,6 +84,7 @@ struct skbuf_dma_descriptor {
  * @ring_tail: consumer index
  * @ring_size: number of slots in @skb_ring
  * @rx_lock: serialises @ring_head between the RX callback and the refill timer
+ * @tx_lock: serialises @ring_head and @ring_tail between xmit and TX completion
  * @rx_refill_timer: retries RX refill after an allocation failure
  * @is_tx: true for TX channels, false for RX
  */
@@ -94,6 +97,7 @@ struct xlnx_tsn_ep_dma_chan {
 	u32 ring_tail;
 	u32 ring_size;
 	spinlock_t rx_lock;	/* serialises @ring_head */
+	spinlock_t tx_lock;	/* serialises @ring_head and @ring_tail */
 	struct timer_list rx_refill_timer;
 	bool is_tx;
 };
@@ -300,8 +304,147 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	ep_rx_refill(xchan, true);
 }
 
+static void ep_dma_tx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct xlnx_tsn_ep_dma_chan *xchan = data;
+	struct skbuf_dma_descriptor *skbuf_dma;
+	struct netdev_queue *txq;
+	struct net_device *ndev;
+	struct scatterlist *sgl;
+	struct sk_buff *skb;
+	int sg_len;
+	int len;
+
+	scoped_guard(spinlock_bh, &xchan->tx_lock) {
+		skbuf_dma = ep_get_desc(xchan,
+					xchan->ring_tail & (xchan->ring_size - 1));
+		if (!skbuf_dma || !skbuf_dma->skb)
+			return;
+
+		skb = skbuf_dma->skb;
+		sgl = skbuf_dma->sgl;
+		sg_len = skbuf_dma->sg_len;
+
+		dma_unmap_sg(xchan->dma_dev, sgl, sg_len, DMA_TO_DEVICE);
+
+		skbuf_dma->skb = NULL;
+		WRITE_ONCE(xchan->ring_tail, xchan->ring_tail + 1);
+	}
+
+	ndev = skb->dev;
+	txq = netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
+	len = skb->len;
+
+	if (unlikely(result->result != DMA_TRANS_NOERROR)) {
+		DEV_STATS_INC(ndev, tx_errors);
+	} else {
+		DEV_STATS_INC(ndev, tx_packets);
+		DEV_STATS_ADD(ndev, tx_bytes, len);
+	}
+
+	dev_consume_skb_any(skb);
+	netif_txq_completed_wake(txq, 1, len,
+				 CIRC_SPACE(READ_ONCE(xchan->ring_head),
+					    READ_ONCE(xchan->ring_tail),
+					    xchan->ring_size), 2);
+}
+
 static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
+	struct dma_async_tx_descriptor *dma_tx_desc;
+	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+	struct skbuf_dma_descriptor *skbuf_dma;
+	int queue = skb_get_queue_mapping(skb);
+	struct xlnx_tsn_ep_dma_chan *xchan;
+	struct netdev_queue *txq;
+	int sg_len, nents, ret;
+	dma_cookie_t cookie;
+
+	if (unlikely(queue >= ep->num_tx_queues)) {
+		if (net_ratelimit())
+			netdev_warn(ndev, "Invalid TX queue %d (max %u)\n",
+				    queue, ep->num_tx_queues);
+		goto err_drop_skb;
+	}
+
+	if (ep->tx_dma_chan_map[queue] == TSN_DMA_CH_INVALID) {
+		if (net_ratelimit())
+			netdev_warn(ndev, "Logical TX queue %d has invalid DMA mapping\n",
+				    queue);
+		goto err_drop_skb;
+	}
+
+	xchan = ep->tx_chans[queue];
+
+	sg_len = skb_shinfo(skb)->nr_frags + 1;
+	txq = netdev_get_tx_queue(ndev, queue);
+
+	spin_lock_bh(&xchan->tx_lock);
+	if (CIRC_SPACE(xchan->ring_head, READ_ONCE(xchan->ring_tail),
+		       xchan->ring_size) <= 1) {
+		netif_txq_try_stop(txq,
+				   CIRC_SPACE(xchan->ring_head,
+					      READ_ONCE(xchan->ring_tail),
+					      xchan->ring_size),
+				   2);
+		spin_unlock_bh(&xchan->tx_lock);
+		if (net_ratelimit())
+			netdev_warn(ndev, "TSN TX ring full\n");
+
+		return NETDEV_TX_BUSY;
+	}
+
+	skbuf_dma = ep_get_desc(xchan, xchan->ring_head & (xchan->ring_size - 1));
+	if (!skbuf_dma) {
+		spin_unlock_bh(&xchan->tx_lock);
+		goto err_drop_skb;
+	}
+	spin_unlock_bh(&xchan->tx_lock);
+
+	sg_init_table(skbuf_dma->sgl, sg_len);
+	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
+	if (ret < 0)
+		goto err_drop_skb;
+	sg_len = ret;
+
+	nents = dma_map_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+	if (!nents)
+		goto err_drop_skb;
+
+	dma_tx_desc = dmaengine_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
+					      nents, DMA_MEM_TO_DEV,
+					      DMA_PREP_INTERRUPT);
+	if (!dma_tx_desc)
+		goto err_unmap_sg;
+
+	skbuf_dma->skb = skb;
+	skbuf_dma->sg_len = sg_len;
+	dma_tx_desc->callback_param = xchan;
+	dma_tx_desc->callback_result = ep_dma_tx_cb;
+
+	spin_lock_bh(&xchan->tx_lock);
+	cookie = dmaengine_submit(dma_tx_desc);
+	if (dma_submit_error(cookie)) {
+		spin_unlock_bh(&xchan->tx_lock);
+		skbuf_dma->skb = NULL;
+		goto err_unmap_sg;
+	}
+	WRITE_ONCE(xchan->ring_head, xchan->ring_head + 1);
+	netdev_tx_sent_queue(txq, skb->len);
+	netif_txq_maybe_stop(txq,
+			     CIRC_SPACE(xchan->ring_head,
+					READ_ONCE(xchan->ring_tail),
+					xchan->ring_size),
+			     2, 2);
+	spin_unlock_bh(&xchan->tx_lock);
+
+	dma_async_issue_pending(xchan->chan);
+
+	return NETDEV_TX_OK;
+
+err_unmap_sg:
+	dma_unmap_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+err_drop_skb:
 	dev_kfree_skb_any(skb);
 	DEV_STATS_INC(ndev, tx_dropped);
 	return NETDEV_TX_OK;
@@ -331,10 +474,13 @@ static int ep_open(struct net_device *ndev)
 static int ep_stop(struct net_device *ndev)
 {
 	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+	unsigned int i;
 
 	netif_tx_disable(ndev);
 	WRITE_ONCE(ep->closing, true);
 	ep_exit_dmaengine(ep);
+	for (i = 0; i < ndev->num_tx_queues; i++)
+		netdev_tx_reset_subqueue(ndev, i);
 
 	return 0;
 }
@@ -398,7 +544,9 @@ ep_alloc_dma_chan(struct xlnx_tsn_ep *ep, const char *name, bool is_tx,
 	chan->ep = ep;
 	chan->ring_size = ring_size;
 	chan->dma_dev = dmaengine_get_dma_device(chan->chan);
-	if (!is_tx) {
+	if (is_tx) {
+		spin_lock_init(&chan->tx_lock);
+	} else {
 		spin_lock_init(&chan->rx_lock);
 		timer_setup(&chan->rx_refill_timer, ep_rx_refill_timer, 0);
 	}

-- 
2.43.0

