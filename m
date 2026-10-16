Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A094718E1
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143190; cv=fail; b=ZeMv5IjpAUNXQWyN/z2agSGXb5YY98FydX0Fv/ZFDqq8yffFfVJokUUY913Nx4t06I9zzrmaGzGXIKNOSPs1g/ihIs3klvp1IFgZ/XetNx6vXajSE5HRoTkd5xUHlnpXlh1qFkRqrbsiBC0DHd1jB6CYJKSEnGi+p7OqrXXgMho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143190; c=relaxed/simple;
	bh=QqjoOgK/EkidCE61uFQDzS4D3Vzjk7XzWqh8mAtEvk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KWBPlkwLQJg8AJINjG/O6bn4jacjdGGBGElpEM3SZqarS3kfsUA1+eCnA+Nlp2wpMrORkMJuWxaJVnNJlRBLohSLjTYQKH4ODW5Uq0KTlQAXXxir4UNjjbLEHqGpHbe0qwMmbXyrCptmWI8W9Ga5HVQfhBnYRPPbC3b4qBEDjCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Bic6H/bu; arc=fail smtp.client-ip=52.101.48.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Bic6H/bu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPUs5TycedtmL0ZlhnnWMtTjxRbhoCxl+GfzKExG/LnIRH0TBgWrRbBTBdLHZleo3iPO1jgfCywnjoWyQuWoqzI3pxxk/ltQFu6qUap0C/NWc0hTDWj+cFi8dOw+rLEn1YTayl122q/8quMh4KQWXS+Qf90So3RTaTkDJIq3K2t9pEZ2vDxj/16h3trdjJ+KSlkKZntBFh0z92+saIhat/c8rJv3IX6Mp93QJDJB4DemtaMDtTuOR0f+DJAj+kEiC5LpmMs16Tx+0gt4uKJNK5CEqMU+kdGhwrhdUM20Q/XzVplMU8EOn98wKt4hnCLa3DPsVfpZArtZdYa8UXumww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFuDSNg+UrTBz7E/chTHJJ84Q2cg4MLn/fKbjAyCVFM=;
 b=pCYOPMpNXDLxV/zDj6BxrD4NENjv7HKmlCL6njlZ4m6+eKdYTA1J1ioctwzywFCjUNnsg2/NYzGzrimy0MEsgdCVegiw/hhndJCyJgPAWMrA2GD/YxizcAPBmaFq0N+peOc+jYrMmOLWZfMLlKm0nm74qvPUS88BptUzjHsErCTNl22cEi/HnqH/uxG0yfgdnePzq7wFDPfmWtcVs31wQcF/p3JlCHfvpv/L4LTpVDQmNUjGydUmJ71IUGAoAUPn9qu2XXw2DLD8kkq5sn4KWkMHXoiiI6aljPL+i2I5NG1ZdD/kBkGO5RFCdAglktZmvOPgnBMA3Cp+W6g8skFB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SFuDSNg+UrTBz7E/chTHJJ84Q2cg4MLn/fKbjAyCVFM=;
 b=Bic6H/buLS+ggZF/WugmuCZctDNGBYgLaEI9Is0u5nl0WvFmdrLLwOFED3/2XJE1unC0NXiJszQpoY/0Jv4JnVUQweTEAQ+VrbIHGfcGzMG8P0sVr2Y4Z7+MKpIkDaAM4Q71KlAVKlMIfQhs8/SSg1uvc/BeeOxRQ0yAejxvEvs=
Received: from IA1P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::6)
 by SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 09:33:02 +0000
Received: from IA0PEPF0000003B.namprd03.prod.outlook.com
 (2603:10b6:208:461:cafe::8d) by IA1P220CA0009.outlook.office365.com
 (2603:10b6:208:461::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 09:33:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003B.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:33:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:32:54 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 04:32:49 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 16 Oct 2026 15:02:03 +0530
Subject: [PATCH net-next v3 4/8] net: xilinx: tsn: parse endpoint DMA
 channel configuration
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261016-patches_v2_external-v3-4-e33d3960ca1e@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003B:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b82971f-08e3-472c-f2f7-08df2b687926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|7416014|82310400026|11063799006|56012099006|921020|5023799004|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/oSzJYpxvQKOVIQ8DqjHd5TMU/WI5gq/yzoxrtBbyymiTkQkLg2vrPk8pu+sI0xrS+WcxQnMWhgkyRvR+lsB0JTM7W9XYBI24SYb2wRrCT+kNGLU2P24snMUVe78kWc4uaHgmbdVXspJpUPnfCKf8le+OrnBBq1dL9ffg/Y7lEy1OupbT08myfTiKLCtJ1mJ+cR8rBp2Lr6GIHtPqHZMQsvaqC6AAnWati0iHMwdw5576J8RX1brWIDwvwbAMTyeYjzemJsLPVRTi+J1tMDaO5SJN7PYra+0160j4tGiNQ89bxyReD3MY7cnPoEcDN/UkWuzcqhpda1l0rw1cEhRfdV6mWZrggoPODJb2WodX2PgGkKJIIopk0LGbxKtLrv4O1IFgGFJTAmahsvSspLZxGuvowqvoxngy9dU8TbtkXUZKuzYk/GjG31GRk9ZhMIaopvtK1Ma6RqRTZEyki7xgfTK0nK+IKh5ozEktgczkPAn2Dxd5Dlb6oZ3T256etQl8b/LE/Vc/f3hwd1W4y519LaD3FkxO5C3R/sPXkDtKqENxHIMokOurTw490aKkD3sV5JjZmUWxuAQ2IQhrB9X4qo4zssE4bRHENZ/ckLbpgzkm2Lt64KSNXvfdQHClzm2rr9Urt2ZSWS4Tb0ABeZR1qDlgrEWG6+KxHcEYagpWhYaYx/ePP3UKQelwnYC6yHrl4+rIozNdch0qj6CaDctfFRbYDUQDNcvC6x6hvx0wBSvDodxD6pi+JlMHThfvoHT
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(7416014)(82310400026)(11063799006)(56012099006)(921020)(5023799004)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AGipfRyA0/lLsbMjjhG/FOwn8MDhe3uepnv1kPmeJcZWfjRpwmaGEPkqRIPcmKH6t+bNjd71HFGCUX37pjyX9Ft8Qiz2vkci2u3d1H/Qsz2RNMAQIW0IgJCLCpNW+QNDpyeXIZb96hI5kWh/RcafzoE5aLKjdDW3gerMQ5cidXG7ITjwq8Y86DsjUVhjGLV+F7GJjWzhsyzBfyATfWn2gUUXakIpVoQ6VJmcbKfn0ryzVt09NJ6T4rva//rNEI5iiQliWnouoyWKdOeaz9fDlop6tVF3mN5hvcQ/fBQYFPtZP2BCAeIDZUA+Md8EpW9wnZgXBK2/WuLGwIO+Pe4KGelc5EAZvEvLKJjeA3rvLg52CNsHuXm9crMCqwSRQHSimt4cd2m6+1yw/8FXf/PNqaw68Iako2b2r2rt7eeRl0sW7/5qIosFlZ1+RBsDQZsK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:33:01.8144
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b82971f-08e3-472c-f2f7-08df2b687926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886

The endpoint has one MCDMA channel per TX queue and per RX queue, and
the device tree lists them in "dma-names". The transmit path needs to
know which channel backs each logical TX queue.

Count the TX and RX channels in "dma-names" and allocate the conduit
netdev with that many hardware queues. Parse the "tx-queues-config"
child node to map each logical TX queue to its channel.

The device tree describes one "queueN" child per TX channel under
"tx-queues-config". Each child names its channel with
"xlnx,dma-channel-num", given as the N of the tx_chanN entry in
"dma-names". Every logical TX queue must be described exactly once and
name a distinct channel that "dma-names" lists, and the TX channel count
must equal "xlnx,num-priorities" on the parent IP node. Probe fails with
dev_err_probe() when any of that does not hold.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v3:
- State the device tree requirements in the commit body. One "queueN"
  child per TX channel naming its channel with "xlnx,dma-channel-num",
  every TX queue described exactly once, and the TX channel count equal
  to "xlnx,num-priorities". They were only in the v2 changelog before.
- Correct the kernel-doc for tx_dma_chan_map. It holds the N of a tx_chanN
  entry in "dma-names", not a hardware channel number.
- Name the counting helper ep_count_dma_channels() and its probe results
  num_tx_dma_channels and num_rx_dma_channels. Both count MCDMA channels
  listed in "dma-names", which "queues" did not convey.
- Call the RX map rx_dma_chan_map, matching tx_dma_chan_map. Both hold the
  N of a chanN entry in "dma-names", so one concept now has one name.
- Keep the RX map in a probe local rather than copying it into the private
  struct. Nothing outside probe reads it.

Changes in v2:
- Check xlnx,dma-channel-num against the channels that dma-names actually
  lists, using a presence bitmask. Reject duplicates and out-of-range channels,
  and index the channel arrays by logical queue.
- Require one queue node per tx_chan and num-priorities equal to the TX channel
  count. This also gives xlnx,num-priorities a consumer.
- Cap TX and RX at 8 to match the binding.
- Error out on an unknown dma-names entry instead of skipping it.
- Drop the unreachable TX and RX count guards. The in-loop index and duplicate
  checks already bound the count, so the channel arrays cannot be over-indexed.
---
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c | 198 +++++++++++++++++++++++-
 1 file changed, 197 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index 609d444c6835..2adee07f6f51 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -5,9 +5,11 @@
  * Copyright (C) 2026 Advanced Micro Devices, Inc.
  */
 
+#include <linux/bitops.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_ether.h>
+#include <linux/if_vlan.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -21,14 +23,30 @@
 
 #define DRIVER_NAME			"xilinx_tsn_ep"
 
+#define TSN_DMA_CH_INVALID		0xFFU
+#define TSN_MAX_TX_QUEUE		8
+#define TSN_MAX_RX_QUEUE		8
+
+#define TSN_MAX_VLAN_FRAME_SIZE		(ETH_DATA_LEN + VLAN_ETH_HLEN + \
+					 ETH_FCS_LEN)
+
 /**
  * struct xlnx_tsn_ep - EP MAC private data, embedded in net_device priv area
  * @ndev: the conduit netdev
  * @dev: backing device
+ * @num_tx_queues: number of TX DMA channels (one per priority)
+ * @num_rx_queues: number of RX DMA channels
+ * @tx_dma_chan_map: TX queue to tx_chanN map, or TSN_DMA_CH_INVALID when
+ *	the queue has no channel
+ * @max_frm_size: maximum frame size accepted on RX
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
 	struct device *dev;
+	u32 num_tx_queues;
+	u32 num_rx_queues;
+	u32 tx_dma_chan_map[TSN_MAX_TX_QUEUE];
+	u32 max_frm_size;
 };
 
 static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
@@ -69,15 +87,176 @@ static const struct ethtool_ops ep_ethtool_ops = {
 	.get_drvinfo	= ep_get_drvinfo,
 };
 
+/*
+ * Parse the "tx-queues-config" child of the EP node. The logical queue
+ * index is taken from the "queue<N>" node name, so the mapping does not
+ * depend on the order the child nodes appear in the device tree.
+ */
+static int ep_parse_tx_queue_config(struct xlnx_tsn_ep *ep,
+				    struct device_node *txcfg_np, u16 tx_present)
+{
+	DECLARE_BITMAP(queue_seen, TSN_MAX_TX_QUEUE) = {};
+	DECLARE_BITMAP(chan_seen, TSN_MAX_TX_QUEUE) = {};
+	unsigned int count = 0;
+	int ret;
+
+	for_each_child_of_node_scoped(txcfg_np, qnode) {
+		u32 chan, queue;
+
+		if (!str_has_prefix(qnode->name, "queue") ||
+		    kstrtou32(qnode->name + strlen("queue"), 10, &queue) ||
+		    queue >= ep->num_tx_queues)
+			return dev_err_probe(ep->dev, -EINVAL,
+					     "tx-config: invalid queue node %pOFn (have %u queues)\n",
+					     qnode, ep->num_tx_queues);
+
+		if (test_and_set_bit(queue, queue_seen))
+			return dev_err_probe(ep->dev, -EINVAL,
+					     "tx-config: queue %u described twice\n",
+					     queue);
+
+		ret = of_property_read_u32(qnode, "xlnx,dma-channel-num", &chan);
+		if (ret)
+			return dev_err_probe(ep->dev, ret,
+					     "tx-config: queue %u missing xlnx,dma-channel-num\n",
+					     queue);
+
+		if (chan >= TSN_MAX_TX_QUEUE || !(tx_present & BIT(chan)))
+			return dev_err_probe(ep->dev, -EINVAL,
+					     "tx-config: queue %u maps to channel %u not present in dma-names\n",
+					     queue, chan);
+
+		if (test_and_set_bit(chan, chan_seen))
+			return dev_err_probe(ep->dev, -EINVAL,
+					     "tx-config: channel %u already assigned to another queue\n",
+					     chan);
+
+		ep->tx_dma_chan_map[queue] = chan;
+		count++;
+	}
+
+	if (count != ep->num_tx_queues)
+		return dev_err_probe(ep->dev, -EINVAL,
+				     "tx-config: described %u queues but expected %u\n",
+				     count, ep->num_tx_queues);
+
+	return 0;
+}
+
+static int ep_count_dma_channels(struct device *dev, u32 *out_tx, u32 *out_rx,
+				 u16 *tx_present, u32 *rx_dma_chan_map)
+{
+	u32 tx = 0, rx = 0;
+	u16 rx_present = 0;
+	int n, i, ret;
+
+	n = of_property_count_strings(dev->of_node, "dma-names");
+	if (n < 0)
+		return dev_err_probe(dev, n, "failed to read dma-names\n");
+
+	for (i = 0; i < n; i++) {
+		const char *name;
+		size_t plen;
+		u32 idx;
+
+		ret = of_property_read_string_index(dev->of_node, "dma-names",
+						    i, &name);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to read dma-names[%d]\n", i);
+
+		plen = str_has_prefix(name, "tx_chan");
+		if (plen) {
+			if (kstrtou32(name + plen, 10, &idx) ||
+			    idx >= TSN_MAX_TX_QUEUE)
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid TX channel name %s\n",
+						     name);
+
+			if (*tx_present & BIT(idx))
+				return dev_err_probe(dev, -EINVAL,
+						     "duplicate TX channel %s\n",
+						     name);
+
+			*tx_present |= BIT(idx);
+			tx++;
+			continue;
+		}
+
+		plen = str_has_prefix(name, "rx_chan");
+		if (plen) {
+			if (kstrtou32(name + plen, 10, &idx) ||
+			    idx >= TSN_MAX_RX_QUEUE)
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid RX channel name %s\n",
+						     name);
+
+			if (rx_present & BIT(idx))
+				return dev_err_probe(dev, -EINVAL,
+						     "duplicate RX channel %s\n",
+						     name);
+
+			rx_present |= BIT(idx);
+			rx_dma_chan_map[rx] = idx;
+			rx++;
+			continue;
+		}
+
+		return dev_err_probe(dev, -EINVAL,
+				     "unrecognised dma-names entry %s\n", name);
+	}
+
+	if (!tx)
+		return dev_err_probe(dev, -EINVAL,
+				     "no TX channels in dma-names\n");
+
+	if (!rx)
+		return dev_err_probe(dev, -EINVAL,
+				     "no RX channels in dma-names\n");
+
+	*out_tx = tx;
+	*out_rx = rx;
+
+	return 0;
+}
+
 static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 {
+	u32 num_tx_dma_channels, num_rx_dma_channels, num_prio;
+	u32 rx_dma_chan_map[TSN_MAX_RX_QUEUE];
 	struct device *dev = &pdev->dev;
+	struct device_node *txcfg_np;
+	struct device_node *ip_np;
 	struct net_device *ndev;
 	struct xlnx_tsn_ep *ep;
 	u8 mac_addr[ETH_ALEN];
+	u16 tx_present = 0;
 	int ret;
+	int i;
+
+	ret = ep_count_dma_channels(dev, &num_tx_dma_channels,
+				    &num_rx_dma_channels, &tx_present,
+				    rx_dma_chan_map);
+	if (ret)
+		return ret;
+
+	ip_np = of_get_parent(dev->of_node);
+	if (!ip_np)
+		return dev_err_probe(dev, -EINVAL, "missing parent IP node\n");
+
+	ret = of_property_read_u32(ip_np, "xlnx,num-priorities", &num_prio);
+	of_node_put(ip_np);
+	if (ret)
+		return dev_err_probe(dev, ret, "missing xlnx,num-priorities\n");
+
+	if (num_tx_dma_channels != num_prio)
+		return dev_err_probe(dev, -EINVAL,
+				     "TX channel count %u must equal num-priorities %u\n",
+				     num_tx_dma_channels, num_prio);
 
-	ndev = alloc_netdev(sizeof(*ep), "eth%d", NET_NAME_UNKNOWN, ether_setup);
+	ndev = alloc_netdev_mqs(sizeof(*ep), "eth%d", NET_NAME_UNKNOWN,
+				ether_setup, num_tx_dma_channels,
+				num_rx_dma_channels);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -89,6 +268,23 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 	ep = netdev_priv(ndev);
 	ep->ndev = ndev;
 	ep->dev = dev;
+	ep->num_tx_queues = num_tx_dma_channels;
+	ep->num_rx_queues = num_rx_dma_channels;
+	ep->max_frm_size = TSN_MAX_VLAN_FRAME_SIZE;
+
+	for (i = 0; i < TSN_MAX_TX_QUEUE; i++)
+		ep->tx_dma_chan_map[i] = TSN_DMA_CH_INVALID;
+
+	txcfg_np = of_get_child_by_name(dev->of_node, "tx-queues-config");
+	if (!txcfg_np) {
+		ret = dev_err_probe(dev, -EINVAL,
+				    "missing tx-queues-config node\n");
+		goto err_free_ndev;
+	}
+	ret = ep_parse_tx_queue_config(ep, txcfg_np, tx_present);
+	of_node_put(txcfg_np);
+	if (ret)
+		goto err_free_ndev;
 
 	ret = of_get_mac_address(dev->of_node, mac_addr);
 	if (ret == -EPROBE_DEFER) {

-- 
2.44.4

