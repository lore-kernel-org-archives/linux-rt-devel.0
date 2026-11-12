Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.69
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794510906;
	b=HzBqbJHEMcRgf8CAhdwaTbCNRgDGhOhrU90W0rllvh7PcgwSd9pXhdnmkYJQr7dbqOwm
	 LW2rEgdUJ+Q0DtdaduufD0acW7rqnwxcnG/ny93rS+6nHgJNfdPagtuWSFnrXbpgdTuJ8
	 CvucoBAoFDDlFH0P6fDsDbHEnU+jwpRqKsqBBnVJ/SQjxiHbcG9HysmZt9fPpg8nXx1kx
	 DuXT0ZfCCEVxM0x8nh2TbbT7Ja2il9JlflTjZRnTHvcnNpqAp8ImEPSHVGxAkIXYmVKd6
	 urL/XAtSzuCYqqu6alk1HUa5ECozasF8IjWU4d6PigbIjbuPk720CDTmUe+47Lo5pzA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510906;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=bh3O2s3JESk67/zXCr9XU3LElcL8ZuOCLB0nONuqKfc=;
	b=o3f/A0h5Tq/H2CgxDR3d04Pq7D4nFTCXfXT5MMSGBbHSTQKJWb2eJknJcmSylO/CqTy5
	 BESUPflbGuj3qpIjE7Hs8WWuudF3vF/3zfjIqxrDHcR2zmi+No/HM4+OEY51LQOe9EpB9
	 BjW0RiQi9mLgvbtDKpQM+BSqN4CUZXoCiu07D9+hprFQPg5TVzfszDBkpbjO/D3xElSeF
	 8+ax+dHvixiDCoOtYX0ZOaaD4vJwNoroE7IhMVLEMH0tSLp1Eq+RwVSv/Je9V3P9b3Qjg
	 LxnfWhF1aw/tjoxNRd4zwnIRsAe8/SHxyluFE7Usr3RNBgkfQV4AV9y+eQ5HZG6joLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EGgyK1qX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.69
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010069.outbound.protection.outlook.com [52.101.193.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D93606A332
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 19:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79D93606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=EGgyK1qX
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r0cNPhoaXRfdBL21bGLUznSx7Wl4Bwfcpq+pDoa8G0IO0DOgBEiyESPwkPQpq9cx0E0dCXly3wdLQBdc9tbja8l5zc3Zcqm2gx4i/vgF6cOvFLVQGeweBRCbrcTGeoTdniEgtzFDggbGB5Bc9xr8tKJL8y+oZwj4ZsmBxelmOB56O1oGRSAALDDrUnfCDUhzXo4iORqlFCsD2wjOTB7kxfvj+T7+pWKH/qHY7e1DlNzh2Z74ZHlS4rbIDe4KEpkY1K3aCFOdX7NBWmADRZwilg14wbrAwBSwtZzp960BVlo/CP2USUoqyGxWEYvFqdWHDSId9bKSXuxE1t8FBbfZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bh3O2s3JESk67/zXCr9XU3LElcL8ZuOCLB0nONuqKfc=;
 b=ELYS1ck7Ggu0ifavZZDgvf4zjleGWCnRLgaanIn2L5CF7Kt6FKZ2jbPTL7bwnYiX8oLRtXGysCqHqBxU+/nSxM3b8HtXi2Bvt6HYq3F6SYS8d7BywbdERv69PEAQhJeX3PcBTalMz2TBznI6FwjgWVqTwhuiJSHUKcBzHuBJbTm0Qj4JSL96EhS30r9KlwwrGRbrSTAmlMgovY438Z1Q1QMWdQ15gG0Q63Z5ZzAicYSWYtUq6cGFIl/AQTFfMSICCgT32asNw4IG+iEorQKO6qZhVuJ9W1dF4YivziWF0O52qA9bYvIbo/YECTfvQCecBlPF0Ff5JcC88JVdRINs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bh3O2s3JESk67/zXCr9XU3LElcL8ZuOCLB0nONuqKfc=;
 b=EGgyK1qX5QM/lj+t9Yb8gtjnrK7f19s/h0kI1oHCpR7hueiRIuaRfM8h5pqqxrPJj0b+Y3yGShZAxHjs76e4YaeRO+NotraJTUttsTKr2o8F9tddGmpIWNfGkjxNgNb8MRtndAJK1YnM+NLAq/jNesvbtVS+ZfD6mW6fw/R/xsk=
Received: from MW4PR04CA0160.namprd04.prod.outlook.com (2603:10b6:303:85::15)
 by SN7PR12MB6744.namprd12.prod.outlook.com (2603:10b6:806:26c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 19:14:58 +0000
Received: from MN7PEPF0000014D.namprd04.prod.outlook.com
 (2603:10b6:303:85:cafe::27) by MW4PR04CA0160.outlook.office365.com
 (2603:10b6:303:85::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 19:14:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN7PEPF0000014D.mail.protection.outlook.com (10.167.254.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 19:14:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:55 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 12:47:50 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 13 Nov 2026 00:16:52 +0530
Subject: [PATCH net-next v4 8/8] net: xilinx: tsn: deliver endpoint RX
 frames to DSA user ports
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261113-patches_v2_external-v4-8-56bb26f042a4@amd.com>
References: <20261113-patches_v2_external-v4-0-56bb26f042a4@amd.com>
In-Reply-To: <20261113-patches_v2_external-v4-0-56bb26f042a4@amd.com>
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
	<git@amd.com>, <neelisrinivas18@gmail.com>
X-Mailer: b4 0.16.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014D:EE_|SN7PR12MB6744:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9d286b-f740-4163-53c6-08df40f13716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|82310400026|376014|23010399003|921020|11063799006|10067099003|261026140227099003|261009223027099003|261026121527099003|261021123027099003|261022105027099003|261021121427099003|56012099006|261022075727099003|261102123227099003|261028144727099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	djifkLN2TtPQU6l8R4VsZvI5fwHCXt4nhRTjs/JsvDYSTQRzCU/QPI2EFZYpn0hwpp6rVCQydwit/iHK4NN8DnxhDT21HO87JGWU39MZG8mRHqDMeN+JfRgZvTDEfaEj+7BoA04mbPwt6nj1kXw/GDzKWC309prV5pcd3i3Xwd7OdbrPP4IAgFQ8v0+M60sy80At5yemaGqpeyd1TdRvE41BRdxtYUvzJwVX03sOIEThDX8G1EIbWN0B5rNrcSuqZjtxnHfFdOf8eN/UVfYcLxJCJHuP1GRim0tWTyQ5sIAw8E39/yHGa5xQvcVv3R/NTNOohDVCd2uAdYK79sMUYYoinUz8T/SdArTgSG0oV0YYhsyJIGzEHdfAB0ebyMtAd9QGznQFVY+qZYvg5uN4feXxtjiVaXiMb9XUlw31dRryCGmuMsq8oyh8ykbOew0e2ncR9lEHT8XhoU7zD4WG2MxAeAFK9UKuY4wvrDFUMV+1srJ26THpYUNty4FvdNwGlBFUPbCWITJ8LTvXD4MJcoLatDnMjW/rTOdaT5HgvNJ/nnb4q9Lp6SJ+utYZh5P8oKjdOCDSGlTaB+BIT81MRHFODiWiiaY95HIW2SrHdJO9ouRdID6zMlEIheFdDAkyUJSgo7iZWO4imETkKMKSPVG66g1/MokR4DiqQYXF/VgYBG5GfaRrNJhQsfWmsVAfVbcOgjwfw2OHnw60I7Iu70AWyz76Er4hjP1nnyIG9d+PuqynXit6rlkbVz7nsO7m
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(82310400026)(376014)(23010399003)(921020)(11063799006)(10067099003)(261026140227099003)(261009223027099003)(261026121527099003)(261021123027099003)(261022105027099003)(261021121427099003)(56012099006)(261022075727099003)(261102123227099003)(261028144727099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CpxkH8s2W8x6BGrn9dF5h2W5yScN4mjFATg7cbDQDvlWhAGRKK0LKpF6Hg0C8gyEcs9BvgqQLFSGP2Yp/RQfE95Rkhd3shBuAOO/V4HqSPX+7UdpBBSefQcrG/8qpJWcMq4RMyzrwu5a4pPJeIKFOWduDYde07bA6UnECk+m87v7cUhm5c63oc/kr+gIzp+0mV314kbejwcJzqZwLwXwkaLEDUVotgt4X8A83rArGxnkMB9hauFWt4oAFEA0CCuNpcf+PJgR+fH+uCDZthnwb3iTUXt2xkF9SpgPgUc6pRojeG1UIe5MM9o3y7mlgXulcSPWQSPzHB9sIzb/rqPMzaQW3AQkEmgdQZHViROhnCDLkISxHX7ERxqjMqXaIlkYOsQPJIMk49wcsPxcDbWU6ip6OxVHwjysWrVQ9atJ9yBF0FXWRcJGV4br7PaXSLz3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 19:14:46.4947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9d286b-f740-4163-53c6-08df40f13716
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN7PEPF0000014D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6744

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
index 6e2721a74f28..0f4fd965b987 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -28,6 +28,8 @@
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
@@ -117,6 +122,8 @@ struct xlnx_tsn_ep_dma_chan {
  * @rx_chans: array of RX channels (size @num_rx_queues)
  * @closing: set in ndo_stop so the RX completion callback stops re-arming
  *	and the TX completion callback stops waking a stopped queue
+ * @port_md: per-TUSER-port METADATA_HW_PORT_MUX entries attached on RX,
+ *	indexed by port_id (1 for MAC1, 2 for MAC2)
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
@@ -133,6 +140,8 @@ struct xlnx_tsn_ep {
 	struct xlnx_tsn_ep_dma_chan **rx_chans;
 
 	bool closing;
+
+	struct metadata_dst *port_md[XLNX_TSN_EP_PORT_MD_SLOTS];
 };
 
 static inline struct skbuf_dma_descriptor *
@@ -304,6 +313,10 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	}
 
 	skb_put(skb, rx_len);
+	if (netdev_uses_dsa(ndev)) {
+		dst_hold(&ep->port_md[port_id]->dst);
+		skb_dst_set(skb, &ep->port_md[port_id]->dst);
+	}
 	skb->dev = ndev;
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb_checksum_none_assert(skb);
@@ -907,6 +920,37 @@ static int ep_count_dma_channels(struct device *dev, u32 *out_tx, u32 *out_rx,
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
@@ -996,16 +1040,24 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
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
@@ -1021,6 +1073,7 @@ static void xlnx_tsn_ep_remove(struct platform_device *pdev)
 		return;
 
 	unregister_netdev(ep->ndev);
+	ep_free_port_md(ep);
 	ep_release_dma_chans(ep);
 	free_netdev(ep->ndev);
 }

-- 
2.43.0

