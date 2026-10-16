Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010041.outbound.protection.outlook.com [52.101.193.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B308A480336
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 09:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143214; cv=fail; b=dQJZYb28mtnqeRmSdQjCP+hIzJ7XdrRm9nyucGEnkbDqKN0EkxOZlDa+pEj5xd3Wwpckp7l1vBBEihmIhmJeaLf4AAhZkSxtdoKto3x9kS6IVqIqVe+UYcc3h4xCF6g9DoH75p0Z3GLZ6stynJWwVSBsQdV+kmrull8vRRle5pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143214; c=relaxed/simple;
	bh=oP8AVuB2f9Ppd0S2t9l2BE+lBA3VvWOX1sIFQ5laru4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=G3lZ+tRz52Iu3dnOQiBeuGzXJy7OsVGbUpXZe+Y34hpcopo1iZLQosrlldsqznQ63vp1kTwETts0xiPzEYesuiTJD0OybCuL+T0hzmrxWH6+toUVhmeikunL7yaI0aDNTd+8Ma8LNyHxykome4KR5LSZSUpAhE3JB1V+4O9cWSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bDXKJ1K/; arc=fail smtp.client-ip=52.101.193.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bDXKJ1K/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y6nbkCdCU+uJscCrSp5SPluUJZWmeTc5LVrNA0tx8gSSMXZgZm+CVPlBGRbokSN9DED49IOHTAzgrwNn1Yim6sb3+v5c7JW2xHBTTzqUxVaD4iI7Rokj9+GRTDvyNTe/dF86sZPXktx/UAoOX0tq6jvlfwQr8eHDhAB8PeTHLuSaleriRXuE5FjhCz0nrYCAnErA42+NKr3KECosc3VoGaxbYU/cgQ279Stk3oaUrmeFEcrL+F8nAd6Pgz300TfmOaZeAuK5+qkRD24T7vAiq4P2fRSvrjLqhz5M/lb3PxV6DVqmXWJsVQQsDAr7JSJSMd4kquWePkgP+fB5ol73gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYSy2ar4Jq6NNz8SsotcCJ3s2mksFHmZ5rRpB7OsP+Q=;
 b=soOjg1NFDQAaSefU1c3R9DpM7F/SBDp21Zc2DSojj+EBWMB8fEkGIvORRwrkk7vbCXKZRemEkDIZTbqJd1rdPAzfDV6utPJUdMj6s3M1WHouZ7WcLS5okmQG01wJx+kb7lpYafXf3BTNQdCPwnBMfl+cVYMqSM2y4UPfxRAVbjn1aADwEx/wRN/jTQrSFhwGiNlZOrucqNKNXfBCjTvqFqjyFcfxQ/vseWNq9Hs0jVEZb8PjHPVF/vNwNwRy77zDALJQFETEOKPh7Kl3Dp4xErBpjGV6eSVNDW1NAEvViPvYj/m2ih924DsJUFQ9och3B710DKmg73kQq8SV3yuhIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYSy2ar4Jq6NNz8SsotcCJ3s2mksFHmZ5rRpB7OsP+Q=;
 b=bDXKJ1K/JxPchCWwNFP2tjuXEJ/5QwxI4kB2yJ+RNK0SK/syVF0kkVXmdZ0K3UaOvQmsXMtEokUm1SjIwGtlA8slW033dIG12gWeRCY0SCRu1nOvVL0kezeDYjl1IfbmbDG3jiv7q+YWPEt8bHIZbE/NuQBbmFuTljknG6SBTmw=
Received: from PH8P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::18)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 09:33:25 +0000
Received: from SJ5PEPF00000204.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::9a) by PH8P222CA0003.outlook.office365.com
 (2603:10b6:510:2d7::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 09:33:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000204.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:33:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:33:15 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 04:33:10 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 16 Oct 2026 15:02:07 +0530
Subject: [PATCH net-next v3 8/8] net: xilinx: tsn: deliver endpoint RX
 frames to DSA user ports
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261016-patches_v2_external-v3-8-e33d3960ca1e@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000204:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e825bf-5f51-4dae-1571-08df2b6886f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|7416014|376014|82310400026|11063799006|56012099006|921020|261009223027099003|18002099003|10067099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vAV9E58hgXVxPytWFW3CoNj5HFMajy5q0X/OPS5v7DL4GeW0hmyWba8EdharT282j4254d5uSKQ1F2nEdLjfGhJ2V2BPQ77t/g2lrQi+rafsoVD6B7ntMeB0bkVe7tQeuKfTI+ZjZ5BM531hWCNsaqy2tOgEQawg4QnwlEGLjrmR1/Igabov2a6RL48hvoDdgmOCntrOB5uC8xgYVwYegEnN4vJLqfWYyj9zAMxwTiBBB8v7npJQfusFu9ytbWu227rt+4kjDmlJffNS58gCupGdN6FFQwlfsIBXGrjE/pD4c+kchLfEN0xfctXWNXqG4FdSWAe4N01/H7lUPWBJpJ1y/uQfhKq9QnWCbMOS6QBbCKCsWJR+aU2jTKj39u5fVR3VN1mkOk+nJqtkarmtOfcFIAOpf7CGpUhL/EODFk187BkPhbAEiUGGcajtjhkCqnYzO9yxMiDxAhXVoYsaaLa+D+jJtge5rBGy3JhLFah0Wt2zcWaGXJs4zagBFmb+XC0HruN3wFCXnI83lmy88Z6Zkl6EsdDBEevx9sP4/OpG+Dmy/474BoUnRtYOpX10+9miilNqr+qNzyoyoyknKqNQMSUTiJKHFTX5XEZ+iDp/7UqIQZraXzSva+ruJzqeFI0BjNHFRmk/ELIDNu/rVSi9NPwn9dQT+fMK3B7oHrGYHpwGvio+Tjhk0F+XKV3PuEWvn9JIXTXUabu7H+eFbjGyUXt63b124qR0xIFZRd1Z2JYckpviImFnYn1epVGO
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(7416014)(376014)(82310400026)(11063799006)(56012099006)(921020)(261009223027099003)(18002099003)(10067099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rmh85wHPN6+f07wa/5kR9u1IyU3H7hOULlKEEjVSF+TbsNSiK3ZVaSDGCIndaQqTI26lcmxOE0K0jTBlNqJ9zv6OVZycKd/Dg2qsWhGUJPvV8m5mg2U/vaxwSNFo5pW8afESxy3cF8rtQmTSupRF/2XkccfYQkbZdysAX9Icf/VdFEbmiL/QE2o9WNiz2c5/Y/VACefGzWqv2BFyEOHtgc9WnftGpN9XlNRRnofjhl5/2/HxBSjSLXevx4Ncse13d+ZQqQYR/4sx+6K2aLy2vNfivG0/GdqyyLH3QQcY5jzniw6ghKyyQTrG70Xx/iSQxYuV3uhJ4/gxV09Ia5xymo2xWce2TEDLCihgSc9FJTCiPyieWzu1yB0ymk7db5DzAJpXDoEAUxV54wf8U/Z/kv/kN1NStFGZszUD9ZcRoC3jxgk1Z+CHCECFChhXWk+n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:33:25.0039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e825bf-5f51-4dae-1571-08df2b6886f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000204.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

From: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>

The endpoint MAC is the DSA conduit for the three-port TSN switch. DSA
selects an RX frame's user port from the port metadata on the skb, so a
frame from either MAC needs that metadata to reach its swpN netdev.

Allocate a METADATA_HW_PORT_MUX entry per MAC port at probe and attach it
to each RX frame by its TUSER port_id (1 for MAC1, 2 for MAC2), guarded by
netdev_uses_dsa() so it runs only while a switch is bound as the conduit.

The RX callback runs in softirq and hands the frame to __netif_rx(), which
queues it on the backlog, so the attached dst must be a counted reference
(dst_hold() + skb_dst_set()) to survive the handoff.

Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Co-developed-by: Srinivas Neeli <srinivas.neeli@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c | 55 ++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index bd8cd504cefb..5103a3b4b018 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -28,6 +28,8 @@
 #include <linux/timer.h>
 #include <linux/types.h>
 
+#include <net/dsa.h>
+#include <net/dst_metadata.h>
 #include <net/netdev_queues.h>
 
 #include "xilinx_tsn.h"
@@ -57,6 +59,9 @@
 #define TSN_TUSER_PORT_MAC1		0x1
 #define TSN_TUSER_PORT_MAC2		0x2
 
+/* Sized to index port_md[] by TUSER port_id (1 or 2, slot 0 unused) */
+#define XLNX_TSN_EP_PORT_MD_SLOTS	(TSN_TUSER_PORT_MAC2 + 1)
+
 /**
  * struct skbuf_dma_descriptor - skb container for each in-flight DMA descriptor
  * @sgl: scatter-gather list backing the DMA mapping
@@ -115,6 +120,8 @@ struct xlnx_tsn_ep_dma_chan {
  * @tx_chans: array of TX channels (size @num_tx_queues)
  * @rx_chans: array of RX channels (size @num_rx_queues)
  * @closing: set in ndo_stop so the RX completion callback stops re-arming
+ * @port_md: per-TUSER-port METADATA_HW_PORT_MUX entries attached on RX,
+ *	indexed by port_id (1 for MAC1, 2 for MAC2)
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
@@ -131,6 +138,8 @@ struct xlnx_tsn_ep {
 	struct xlnx_tsn_ep_dma_chan **rx_chans;
 
 	bool closing;
+
+	struct metadata_dst *port_md[XLNX_TSN_EP_PORT_MD_SLOTS];
 };
 
 static inline struct skbuf_dma_descriptor *
@@ -302,6 +311,10 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	}
 
 	skb_put(skb, rx_len);
+	if (netdev_uses_dsa(ndev)) {
+		dst_hold(&ep->port_md[port_id]->dst);
+		skb_dst_set(skb, &ep->port_md[port_id]->dst);
+	}
 	skb->dev = ndev;
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
@@ -900,6 +913,37 @@ static int ep_count_dma_channels(struct device *dev, u32 *out_tx, u32 *out_rx,
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
 	u32 num_tx_dma_channels, num_rx_dma_channels, num_prio;
@@ -985,16 +1029,24 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 			 ndev->dev_addr);
 	}
 
+	ret = ep_alloc_port_md(ep);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to allocate per-port metadata\n");
+		goto err_release_chans;
+	}
+
 	platform_set_drvdata(pdev, ep);
 
 	ret = register_netdev(ndev);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register net device\n");
-		goto err_release_chans;
+		goto err_free_md;
 	}
 
 	return 0;
 
+err_free_md:
+	ep_free_port_md(ep);
 err_release_chans:
 	ep_release_dma_chans(ep);
 err_free_ndev:
@@ -1010,6 +1062,7 @@ static void xlnx_tsn_ep_remove(struct platform_device *pdev)
 		return;
 
 	unregister_netdev(ep->ndev);
+	ep_free_port_md(ep);
 	ep_release_dma_chans(ep);
 	free_netdev(ep->ndev);
 }

-- 
2.44.4

