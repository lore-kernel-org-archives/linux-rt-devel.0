Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471845AEC66
	for <linux-rt-devel@lists.linux.dev>; Tue,  8 Sep 2026 19:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895265; cv=fail; b=jTev83c8FIRmB1Gu/nxUPl1JoWF4AkPzfgph4Rrok75HYCdjOfRAmOZvvtY0hUoMayScXXqkXyo3G1ln/04p01STXawEKXxkB/I3O3SHq/mZbD90uTtGEQ5cfxpJNpy1JPBBofGrYQ3XnRik0rkqziz8/42tpAu5edeL11UsNGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895265; c=relaxed/simple;
	bh=W5YAm34tBG0hktTrUxHso6kWG0dRvWCkA5UyPreLHpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BiLApTdMqqzABDLLaSXolyd372R3WZgBwEKpj/xm7DxjyOAnJApAzQHdWrM58g3z9YoW6j6+IJqFP7+Q/Xx92Rq9ray277feR6J5ip3Cijug64zC1o9l1wtpQcOuj6cN5ONXJxU6wyrMytArh8b7WgKqymJzVjOCveYdEtqMt8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U6Y1cBtt; arc=fail smtp.client-ip=40.93.196.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U6Y1cBtt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VJobuR5yM87PRoPNZtN8I2ecl1lQRRD+yWngMVzU6JpKgtW59xTXApY877WK4BOJnhHxuF/OJssvVw7jK2O1mp8aaDzkNDRLnagDhf6a6eZLls6pIYvo92zqyiNf8LjiKG2YCOZX3LH1np8LsGP/LnXGe+SahjNVPMG04e0pO0hlQmipujcyv8lK+EZm1cd2QsqOtCF+tB7UrucnNFvTtm/owpnfmvKT3cJ7AfUb4qtqIH/w5D76tzT9s69OmZirl/+du3bCfnuls3YFEuaUkpB+p5bAgJCFqNznnHbdUHBU5wPRfgbgjvrRiNcHAl0njW0/yi4NKlFh7ggSdXzcsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJ6ggI2YqOU/GvZZmpsMIlupDakh0igiyE27aQOh2tc=;
 b=vQilX9hK9X2HmESmai85yJP4l304fS9hUCftm6X5BxpknzeE1AGE3JLoG6E/WpFrEAlnrRTwxQxR+uwZT2ifg3NdBwRfoQxTHpDT7AtZBbSl7MjhrL/G5UDzhQTDLWHhn06R8rzGQp3z07/i3Q3rQpOvrOB59VaEXJX7Yiq3CKikJFoLioxFNSYaZcgf37sYyiorRgjWWlVJmxNWMfIKXR84uOcBc845AnT6xGokjqZpqc0hx7ig2/ty0J2E/AHXZLH6P9dwbeW0V/WxAhWUiQ//NgQ/GZznVu/VhC97u5rKByfbCbeedbhJxPNC4R/NBk8NtNcr9Q4hF7z8X/i/pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lJ6ggI2YqOU/GvZZmpsMIlupDakh0igiyE27aQOh2tc=;
 b=U6Y1cBtt9dnZTOYbC0Fp038wzWOBypX+LOLQ4X1UkUmjnS7c6ZLhQnCMKPfKDNRRhaAx6kzSbCQDBUiHlkb1TDgLL8SR/WDQziPxQHwVZbUdma3XSE1nMHRYkcG1x4Ua+oGg2yCoM3u33/615dQZn199yZn5Vt4ZZ/aBM4MfGGQ=
Received: from CH0PR04CA0004.namprd04.prod.outlook.com (2603:10b6:610:76::9)
 by CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 19:20:55 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::ab) by CH0PR04CA0004.outlook.office365.com
 (2603:10b6:610:76::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 19:20:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:20:55 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:53 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:52 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 14:20:47 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Wed, 9 Sep 2026 00:49:56 +0530
Subject: [PATCH net-next v2 8/8] net: xilinx: tsn: deliver endpoint RX
 frames to DSA user ports
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-patches_v2_external-v2-8-3a40babaff4c@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|CH2PR12MB4199:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ecb8aa-7c7a-46da-3979-08df0dde4e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|7416014|10067099003|3023799007|11063799006|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	DHNbqNg5YhHEntQd6W1PTEPbYlDtR1+oGTohg2ECV2JceymRZDpqyR87O9ON8U3pfYAt8B43WT2k3U6I807ffwxG+yse0WFDnCbZcxR3GJG5CcA0DjCbs62k61JkU5Rbq1jjH7JNVVP7cWm9F/WN+M71tBxHzSYyDMAGXYG8u+7HjwPNgIbTw4ysdMaszo3uMZG0oRn6WDZCpIc6gSkN3S2Uql2BhGH6efz8YPhzUehOePwdGX+Z03VSWYinaXW41PYktmo74uh+pX+Etb7T2SqhXWSxq51FzMyAEdKuFkoic0nJi6TsKL+Id68AG0sivhbwKBmEk3s3s8+RRchlopbou8dHBsDx9X0eyD4JOK7AbwZWuYYSNgrP1GVnmIdDQI4WGJGDk7OwAs8XA6ocW3Epx/c4k2dgfb/MUGkLn8RCnvo68D/3RLQN4vfgylGJEpcZCdd7l8J8FbOJL9crG3b99yjIaHHNmV+qqjpQj7+55jAyk6GkiTsjR4tk1EHkUwBbMkKXp68EWqz+cJM3q+welwUAuh1pjHF+6NChBuVUmPwnFb8MDgwd/xo/xONEVBpmSnDBlOV2Zlipl//DlBjUxPmGCLDaxzYdBCAFmYDtrFqKCRrG9weLWK8CQwLlxIIB4lfbhkkHvAdVgHtNN8oaDTjnEYhomxo/Df9zfahgV1ws3d1JgFImrKl0GG+WhEKtJ6uJUlYdMdH7hoiXfyCxQ6/mBS9+nQoNTY4JUovIz48LFe+938ja/ojXrXq6
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(7416014)(10067099003)(3023799007)(11063799006)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/qnnMjDeHSQ7AVag9dFL3ED6wyJfMc5rCzoWZcM+vj2rdltii651N1Riu3LcyqAbE9g1s8RR6Ke2aCY1hX6kBFfGH2AWkqC+vqAgGb59fzq041DanLR/hIOEZcbctkL2WwsIRQiBF2sJHBzooFqznsEpftdvBXEo5StSUp+qurSL30bFZsPgDxccO/f8elJYfWm1lOVfqM9G07/cO+VGhHVwxzDxYaQ7o1glcRhQUf0nCNghFaezyV/AUgnnK2s9XmF6ANJW2OHF8pgM1nCcZdqSQ7fclBuCZ3E4d+lSpFRNP2qLtpS/RoU5K4KTPkhriOWw0WR6oeeTS2ALpWTqunrs0yv/x7ooc8yY/v4HkU/GR8VDh1OI9nL5ymUTG1UrJ0u4wGb2PZJhIKZDBRtl4ftgDdQKJTA52WYcBK7ze3aum8i+ChRM7ADZNjrl42S7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:20:55.4039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ecb8aa-7c7a-46da-3979-08df0dde4e1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4199

From: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>

The DSA core routes an RX frame to a user port from the port metadata
attached to the skb. Without that metadata, frames from the two MACs
cannot reach their swpN netdevs.

Allocate a METADATA_HW_PORT_MUX entry per MAC port at probe and attach
the matching entry to each RX frame by its TUSER port_id. Frames from
MAC1 and MAC2 now reach the correct user netdev, which completes the
conduit data path.

The RX callback runs in softirq and hands the frame to __netif_rx(),
which queues it on the backlog instead of consuming it inline, so the
attached dst must be a counted reference (dst_hold() + skb_dst_set())
to survive the handoff.

Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v2:
- Attach the RX port metadata only when the netdev is a DSA conduit
  (netdev_uses_dsa()), so no dev-less dst leaks into the stack when no switch
  is bound.
- Take a real reference on the per-port metadata_dst with dst_hold() +
  skb_dst_set() before the __netif_rx() backlog handoff, instead of
  skb_dst_set_noref() + skb_dst_force(). The entries stay live for the driver
  lifetime, so this drops the rcu_read_lock() that skb_dst_force() would need
  in the softirq callback.
- Release the per-port metadata_dst with dst_release() at teardown, not
  metadata_dst_free(), so an skb still referencing it is not freed early.
---
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c | 55 ++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index 9e9a45169681..db7da26521d0 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -29,6 +29,8 @@
 #include <linux/timer.h>
 #include <linux/types.h>
 
+#include <net/dsa.h>
+#include <net/dst_metadata.h>
 #include <net/netdev_queues.h>
 
 #include "xilinx_tsn.h"
@@ -58,6 +60,9 @@
 #define TSN_TUSER_PORT_MAC1		0x1
 #define TSN_TUSER_PORT_MAC2		0x2
 
+/* Sized to index port_md[] by TUSER port_id (1 or 2, slot 0 unused) */
+#define XLNX_TSN_EP_PORT_MD_SLOTS	(TSN_TUSER_PORT_MAC2 + 1)
+
 /**
  * struct skbuf_dma_descriptor - skb container for each in-flight DMA descriptor
  * @sgl: scatter-gather list backing the DMA mapping
@@ -114,6 +119,8 @@ struct xlnx_tsn_ep_dma_chan {
  * @tx_chans: array of TX channels (size @num_tx_queues)
  * @rx_chans: array of RX channels (size @num_rx_queues)
  * @closing: set in ndo_stop so the RX completion callback stops re-arming
+ * @port_md: per-TUSER-port METADATA_HW_PORT_MUX entries attached on RX,
+ *	indexed by port_id (1 for MAC1, 2 for MAC2)
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
@@ -128,6 +135,8 @@ struct xlnx_tsn_ep {
 	struct xlnx_tsn_ep_dma_chan **rx_chans;
 
 	bool closing;
+
+	struct metadata_dst *port_md[XLNX_TSN_EP_PORT_MD_SLOTS];
 };
 
 static inline struct skbuf_dma_descriptor *
@@ -292,6 +301,10 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	}
 
 	skb_put(skb, rx_len);
+	if (netdev_uses_dsa(ndev)) {
+		dst_hold(&ep->port_md[port_id]->dst);
+		skb_dst_set(skb, &ep->port_md[port_id]->dst);
+	}
 	skb->dev = ndev;
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
@@ -854,6 +867,37 @@ static int ep_count_dma_queues(struct device *dev, u32 *out_tx, u32 *out_rx,
 	return 0;
 }
 
+static void ep_free_port_md(struct xlnx_tsn_ep *ep)
+{
+	int i;
+
+	for (i = 0; i < XLNX_TSN_EP_PORT_MD_SLOTS; i++) {
+		if (ep->port_md[i]) {
+			dst_release(&ep->port_md[i]->dst);
+			ep->port_md[i] = NULL;
+		}
+	}
+}
+
+static int ep_alloc_port_md(struct xlnx_tsn_ep *ep)
+{
+	int i;
+
+	for (i = TSN_TUSER_PORT_MAC1; i <= TSN_TUSER_PORT_MAC2; i++) {
+		struct metadata_dst *md;
+
+		md = metadata_dst_alloc(0, METADATA_HW_PORT_MUX, GFP_KERNEL);
+		if (!md) {
+			ep_free_port_md(ep);
+			return -ENOMEM;
+		}
+		md->u.port_info.port_id = i;
+		ep->port_md[i] = md;
+	}
+
+	return 0;
+}
+
 static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 {
 	u32 rx_chan_num[TSN_MAX_RX_QUEUE];
@@ -939,16 +983,24 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 			 ndev->dev_addr);
 	}
 
+	ret = ep_alloc_port_md(ep);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to allocate per-port metadata\n");
+		goto err_free_ndev;
+	}
+
 	platform_set_drvdata(pdev, ep);
 
 	ret = register_netdev(ndev);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register net device\n");
-		goto err_free_ndev;
+		goto err_free_md;
 	}
 
 	return 0;
 
+err_free_md:
+	ep_free_port_md(ep);
 err_free_ndev:
 	free_netdev(ndev);
 	return ret;
@@ -962,6 +1014,7 @@ static void xlnx_tsn_ep_remove(struct platform_device *pdev)
 		return;
 
 	unregister_netdev(ep->ndev);
+	ep_free_port_md(ep);
 	free_netdev(ep->ndev);
 }
 

-- 
2.43.0

