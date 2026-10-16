Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012007.outbound.protection.outlook.com [40.93.195.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AAE47F3D7
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 09:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143206; cv=fail; b=NfdGER9w1AtRtPaqlemIrLq7FVcm3rjqxWkXloYKB7vzUuydYzbEUDfZxAA2AMhGLJ6kvwljx9ENamBeSH6qNwk87FztMw6xyW+qc++UkW4T+vgd9UZNahnDufACKefrjklI5m75mUF2UZQNeZNK4LHDGLXB3RZAi6Tz/VZkofA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143206; c=relaxed/simple;
	bh=hojbTFIH+rGu+YJr88t3pa1cU5yyrflR6VO82NNWbhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=HsDIJzxSorMpJ8pdQUyWQM2xJNrlGq6Fs7uoW3itwY6je3umAs8ZjEQV+MCrxrkOEHPaFPKi98khbRrIT1odL+ngLngx0O772pGbV6l/gIXh0s9mjDaYovVAuUpq7Dq9A3N2aRiSiFOGYUPs5BxXVUhWkLaVUJ1NywHHrvk6g2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3NG4uDbW; arc=fail smtp.client-ip=40.93.195.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3NG4uDbW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjCqwJ4UDyAvkupX4VR1kvGFOJlEx9RpbCrBN44ssaCV/tGPkOPot/B5nzRLhUaYKX5J1Z79edpr4jfq3gSBynSWiPwbu70yp6hBD17KuGfIfG6++XDEg8E0iLsG+o+73XKOmkdS10XvfvpTRRiTIwbS4NawnJJdp1ChzKuvfU+my5vcTMQ+z1XeWn/05PmlhcwWcO7pMTe8/ipPu9y/2yBClz5G7ZFTQXpCPqSppwaTzRq/hpNuS+Ubou66exYQgeQqfolXKyWLtnQYDkBchxr69dQLUk9kT9A+On0Weopx30HslpmjPYEeNj3+QOyyYX1FD1JSQ0PgwuB20TyKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RW3opUpFOSEY2TXDe+cwXheKu2CZj6whCaGSi8e1Gb8=;
 b=XV1iZH9g1HAmx3kadFzMpPNV+QjsKtxsu2mDOoQ4a+bvkzsdbypCM2ioqbpSNcTEgtV0/UeSjuframMpiUPb6B5NXt4P5idctsPHg6/7Om3wyQ/M5di7qwWHw6IFcRMIUDfCCLgmD5OhpZRR1SXJTIrOzz5QbjQ9p22j/tq8lNBt2b2APepkyfc9m4mdMsRMgAkEDmYSPAUl9l3aMDgE5HXeaai+C5r/CtkBdToV7H5FMPd8Zn7mAEQFJkCsoeUm1n2F/ZHaRSWZPJlWewfLDSFFwK3jv62cxl23xmuOSd72Jjj8ouKYgi7P6mMSIMHwL0KKjBf9yCT7FMnyDeP+Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RW3opUpFOSEY2TXDe+cwXheKu2CZj6whCaGSi8e1Gb8=;
 b=3NG4uDbW7gXZu0tDllI/92eMqlSur9eA9W6vyaEHs3Eo3HlsSquIFLtJBy7IS3AS0KmZr0Xu3Io/+lUxeWpZOsVjIpZTOv5kcQ9Q+hijZIBrWpI4C8fbofW6xZVNuqiDou4WkDFK3A+APsO1Hg656PtmfpoB/wgEDM5SL0G7FIk=
Received: from BN9PR03CA0964.namprd03.prod.outlook.com (2603:10b6:408:109::9)
 by DS7PR12MB8289.namprd12.prod.outlook.com (2603:10b6:8:d8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.15; Fri, 16 Oct 2026 09:33:18 +0000
Received: from IA0PEPF0000003C.namprd03.prod.outlook.com
 (2603:10b6:408:109:cafe::44) by BN9PR03CA0964.outlook.office365.com
 (2603:10b6:408:109::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 09:33:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003C.mail.protection.outlook.com (10.167.249.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:33:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:33:11 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:33:10 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 04:33:05 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 16 Oct 2026 15:02:06 +0530
Subject: [PATCH net-next v3 7/8] net: xilinx: tsn: add the endpoint TX data
 path
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261016-patches_v2_external-v3-7-e33d3960ca1e@amd.com>
References: <20261016-patches_v2_external-v3-0-e33d3960ca1e@amd.com>
In-Reply-To: <20261016-patches_v2_external-v3-0-e33d3960ca1e@amd.com>
To: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "Michal
 Simek" <michal.simek@amd.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, Eric Dumazet <edumazet@kernel.org>, "Eric
 Dumazet" <edumazet@kernel.org>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rt-devel@lists.linux.dev>, Srinivas Neeli <srinivas.neeli@amd.com>,
	<neelisrinivas18@gmail.com>, <git@amd.com>
X-Mailer: b4 0.16.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003C:EE_|DS7PR12MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f879349-7e00-4303-de34-08df2b6882a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|921020|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mycNXHQph/FR7dop3LhcBdXA4Qbtkyp7cOM5XzpdQwnBHoXdpgrG0QghxK9l0wXqz9c7VqGbaVcoZS6B+Hka6TajnVCxoFywQvO6DXVB0d6tqmx3xzSLNaOYnDdBExBQcRB9eWZnQSinS9IawXHHJjnvZmmIpo97J7PcOP7c9+qZFHahfu7zBlw0UDIUaaLSBIQhZaV19Lf632Yncv+4OiUsyyb7R94fXvmPhAXXoqMykcvY76tg+yOQdtyWlNRO/UPCM9WNDbX4VNp7780VHYADVmV2jFfhFZm8onoLFH90sbONDZo9G2lRDTQpaOixDl5BQgxPBxB+taeKJOVVqScsWAgvJDx0gb8KDBEdX9kTsMdpKhe3muaj+Ub79SzvQaOvZkJDwbKSxsV5KSwm2ae+ZC4UeHDHTBWouXJUgGcY+ZdtiQ3nPmDYjvhlG9O+e43abaNlsPz+Hnb70yExxwDi9VbznXIwpnlffPR97JKYqQ4lFj+dU3neKuIRGgnNr8fP5J9hXtUz3T34/7UpL5C0E+f3zxeTcZiGm1tF1yYK+a0zbGS6+QNvm8yIoEN8C19CDMZ/apQWTJ8SjH/g8wQPDAUsimDkmSAC2Yba53oFgYN4OxFDtsqCfm1oPZHby8dabGeXrl7BfT3zf2YmUBc/8dNeGjElZQzs7Qa11n1mxLBq5B8wzAjhLuIinvrQ2pnhYbu43UEmlUUGb6q9QPcbmpK1JEyk80KyN4UOXnqxwMvq4XyNavUqs1esiK7t
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jLLXSGtBZzYs8PEVOvF4CDa+OXXakuBz3C2IgIa4KGAF7sGtCOyNFhYk/3MjisRnyQAz8R2KL/d2X7C7UeV4nYqONwk6+beG/u4HrvIgSHtjxbxniePztYrrn8mxUfxmWIvz9xdckhmq2bsSowpp6vf73AeKCKp0LUlT6q/96TPMNQx33IStdcUOjiWajpwgBCPpJgwFtZ7BBGwPHNS1Gs04dD/LyFzpeKZz0NKIRDPiepRmpGiSQnpuO0f1Y+37ymVRpNilr7lAc1Pr91pTQnN7juqSsEmmnNcLWlLxSQY1OZnBvjlqYQD7CmQKompuJiC4irwAlVKxnk/1UHeF3hAYIQz5hMvhxCamgZi2Wh0VnLPtYUePqDkXdmK2muE1+plZLXzqTeOwYogMSNAnxWbQbUri/cmW5oCphEKdlp+QrRpLW3BFqB7YgeqcgYZn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:33:17.7634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f879349-7e00-4303-de34-08df2b6882a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8289

Add the transmit path so the endpoint can send frames.

Select the TX channel by indexing tx_chans[] with the frame's logical
queue. ep_init_dmaengine() fills that array in logical-queue order, so the
index maps to the channel that queue's descriptors were set up on. The
driver consults tx_dma_chan_map[] only to reject a queue with no mapping.
Map the frame and submit it to that channel. Stop the queue when the ring
runs out of space, and wake it from the completion callback once a slot
opens.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v3:
- Free a DMA-error TX frame with dev_kfree_skb_any() and a completed one
  with dev_consume_skb_any(), so dropped frames are not reported as
  delivered.
- Add skb_tx_timestamp() at the hardware handoff for software TX
  timestamps.
- Skip the queue wake in the completion callback while closing. Use
  __netif_txq_completed_wake() with the closing flag, and set ep->closing
  before netif_tx_disable().
- Reword the body to state that tx_chans[] is indexed by logical queue, and
  drop the description of a runtime channel lookup that no longer exists.

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
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c | 155 +++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index 0a13e04d4057..bd8cd504cefb 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -28,6 +28,8 @@
 #include <linux/timer.h>
 #include <linux/types.h>
 
+#include <net/netdev_queues.h>
+
 #include "xilinx_tsn.h"
 
 #define DRIVER_NAME			"xilinx_tsn_ep"
@@ -81,6 +83,7 @@ struct skbuf_dma_descriptor {
  * @ring_tail: consumer index
  * @ring_size: number of slots in @skb_ring
  * @rx_lock: serialises @ring_head between the RX callback and the refill timer
+ * @tx_lock: serialises @ring_head and @ring_tail between xmit and TX completion
  * @rx_refill_timer: retries RX refill after an allocation failure
  * @is_tx: true for TX channels, false for RX
  */
@@ -93,6 +96,7 @@ struct xlnx_tsn_ep_dma_chan {
 	u32 ring_tail;
 	u32 ring_size;
 	spinlock_t rx_lock;	/* serialises @ring_head */
+	spinlock_t tx_lock;	/* serialises @ring_head and @ring_tail */
 	struct timer_list rx_refill_timer;
 	bool is_tx;
 };
@@ -310,8 +314,150 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
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
+		dev_kfree_skb_any(skb);
+	} else {
+		DEV_STATS_INC(ndev, tx_packets);
+		DEV_STATS_ADD(ndev, tx_bytes, len);
+		dev_consume_skb_any(skb);
+	}
+
+	__netif_txq_completed_wake(txq, 1, len,
+				   CIRC_SPACE(READ_ONCE(xchan->ring_head),
+					      READ_ONCE(xchan->ring_tail),
+					      xchan->ring_size), 2,
+				   READ_ONCE(xchan->ep->closing));
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
+	skb_tx_timestamp(skb);
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
@@ -342,10 +488,13 @@ static int ep_open(struct net_device *ndev)
 static int ep_stop(struct net_device *ndev)
 {
 	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+	unsigned int i;
 
-	netif_tx_disable(ndev);
 	WRITE_ONCE(ep->closing, true);
+	netif_tx_disable(ndev);
 	ep_exit_dmaengine(ep);
+	for (i = 0; i < ndev->num_tx_queues; i++)
+		netdev_tx_reset_subqueue(ndev, i);
 
 	return 0;
 }
@@ -401,7 +550,9 @@ ep_alloc_dma_chan(struct xlnx_tsn_ep *ep, struct dma_chan *dma_chan,
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
2.44.4

