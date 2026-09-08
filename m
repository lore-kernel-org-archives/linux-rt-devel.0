Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012058.outbound.protection.outlook.com [40.93.195.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA9B5A987D
	for <linux-rt-devel@lists.linux.dev>; Tue,  8 Sep 2026 19:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895240; cv=fail; b=aFA+jfBik4MHgBM3THdX5R9xs4uOxN1k7eK3pQIhpsbkMF6s5xqH5qnseSao57pv/XQqZO+N852Y2CPgB8UkZFOix6kszZb+I2PwavbWPujXeiRhV4+6ukNv7beKigldwttlZY188qzb7OrZvIAiahHa0Q30ryxFhazg1BpNpbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895240; c=relaxed/simple;
	bh=Wh4avkiaWe2T0JxVHo1fazNQ+foIiWVoF94uagQK97w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AMNK9YG9l44xuI/yKq+ZHibXLUtIsR3DwMnD32yq/0XHmDo5+tnEDQZ1wvGgNqAbsGUywvw98ERTQjIQV/2qCK4Izb429iR9xlCOFdrRk6FiD79nSuWRiuCLcEGkAH+Ry8A5fSqqeaiEFnVzx6Nx2xjhC6Ev4MRP9m/SPeR7m3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QcuCqjcz; arc=fail smtp.client-ip=40.93.195.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QcuCqjcz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QclTN1DWtMzLEKV/c50lDHLdCa5eWjgPOh68HBxE9E8PpRF51y/pYipNl8OeS7D1b8SVFR2bmfImszE6QXwR7gsGL+Clo8SUbKZnsBceTf8iGZljy3cHTdF+LqfRTkB2BC8KqyEQ5U3vx2WidtbHKhiBDsqcPlPkCVsEVoAIdG88xrsmaBX+3DD1aDOpxefP3fuyqJBECPqUcF7aXiud6pZ3bokvARdvgX4+smgEqUXFGse699jXdbzuH7ADih+rKV7sUXQEErafFdyIxdQfXc2cmBgr5Uy+C1m+6dYM9xuCmniWmglCIPd97WuE5lJbiYIOoGzTnLwtDAQ4fC637w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upYXsiFbEClDPnWjVVZrsMcq6TGb5bBqXx1hRAbDXK8=;
 b=SqiV+jON7sUeqIvwmLQWKKVdM7DQJo5jUndveYoIYOyjHam/FGYTfFaKWWCQT4gUrVJLLqDYfkhkvaue8k8n3YoWOhY4E2Eo622YO5zMkywxvNLhkRUg5o8TA6qf2ED/1XEXV8u9lMs/Bi53JMzAoTybhXWBkoMlAvSn1nst0E3vS5ANyT1Kzl+R09qUw0/Nxtq4rR/nBYVuJGLekJUM9sBY9mEEvtY36IgNSA+rbM8nDBZWE5IIgGqFCV8K6d0Z+CtbFHElN6beaPcCzDaUBEPtX6iunQUun6hN8iDyaH094sk0izuofClRAXgsjjKup3SW14cEe86UmfmOaAp1VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upYXsiFbEClDPnWjVVZrsMcq6TGb5bBqXx1hRAbDXK8=;
 b=QcuCqjcz8/dk6yAXRTkLtzGzJLWONWzYbhljeawouIC4XVipT7NdBYixBdLF80F4F6edolxm5fHAjzyEYB90ZJ54IW0ajHTC2CrQ4DFjYnkF7VRIWlRVT4f9sP1vZ/JoHfEQBQN4C30sU+RklZsYxBW1MXghAWpl4rL1JK+iBBA=
Received: from SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::31)
 by CH8PR12MB9767.namprd12.prod.outlook.com (2603:10b6:610:275::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 19:20:32 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::8) by SJ0P220CA0011.outlook.office365.com
 (2603:10b6:a03:41b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 19:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:20:31 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:30 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 14:20:24 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Wed, 9 Sep 2026 00:49:52 +0530
Subject: [PATCH net-next v2 4/8] net: xilinx: tsn: parse endpoint DMA
 channel configuration
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-patches_v2_external-v2-4-3a40babaff4c@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|CH8PR12MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: 10be9b33-ad92-4392-797f-08df0dde4011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|1800799024|36860700016|921020|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Tg83W4S3yIU2tPS0mW853InbisZZ656NdzSkJnAlpmTgvNvggQAQQLIBcQCJPAACSTVjVkFiUCzSX56f2xQn7LhDvls3NV5lLFClqAoqFI1cxvyJqWwkg0+I+si0BbjHj3ncuTQyPhvTX4Mb5vDOeFz7hTuAgSJV6IGgBumnWJcRpGAWh9Fr7/Aa8ghfc8lcadL25BXv068aUZpdGI2Zb8oNdVWsrMDzcIxyixHec89Q7c0sDzAu/hUpAa3rWpTM7p/B3dgJL6opEX/3OxbPNJcH/mWeXoqHAFugib+isU0ym5aUxPTooKLyH2M6o6flNZ6TFvO1e8xc/LyE5YC8U8v5JYlQt3F6rysosAMUIK9vK+OTLWow/EdveKGI5G4wTxQFmf1UV9qqQdHm8eCED2l21OxRWK1+NkOUPVw/izw0pFyfwTto62kixAKKaU4kU0c2LDPi7KtwcvoNWICced1nXpBCkF9hI1r9VGMAfPoY/DGckZ29u9gCGZyNzRitxFTynWslzIXX4/aI1PvROoe/Cn5pn9D3wKcLJGNSctfJjBCR0p6t6PndSIDvmz7jHJz6JkKsYuHWJeC48gwjDGU2pJCgrc84yhTwjCExuytEQVy1SIczmct7vxYm1GeYbhFeSi2MqbbK/XBHtAMpMrHJbkVXibP0z4t9RxWOU70awVEQdbb1xJOkeKNUPNk7dlXwrhaJkt9d0XPs7180vov2D8GMkWQvoeohubCp9t/EjSdpLiijx3JEBF8UHSvx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(1800799024)(36860700016)(921020)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kT7o14LEM2qTvU1VpPhiUEZowA6A64OCJ0pfQfDMLjPTlANe78nXvlpSzI4cnqymcpY0MrdXrEeN/epMr+4GUrSio/3M+mDZkSSTWYyZ2E9z1SZy21HQPceGODCs9Hg5x1wyZx2exkDiv6LjLLZrzR6Es/JusOuOn4ZfQvbp0ygwNTGcBAe9AUud7+x1dBTr/iPuuJoNd2CqPUA/G9nGBwu9XrmUPIvtlo+IkKb3HyQMOgLJ30lmu3yXfrD88/35qEbxYGSCpCkfkc/MQTernVp0kIEp/7enwavppZU0RFTVDNPs2R76w0uuiujhOluTpo9juPROCBlYmRkX5IuFHw+v/rPlcOR1dlvwSk1JDfeh7nmnRSoN0tkh/o1wa3x2caQO51c62yPqOWpioJEKNfTN6esfCBpD6Jc5jhxS+e80Xn69w2dYiTJDm/0xuSAg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:20:31.7972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10be9b33-ad92-4392-797f-08df0dde4011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9767

The endpoint has one MCDMA channel per TX queue and per RX queue, and
the device tree lists them in "dma-names". The transmit path needs to
know which physical DMA channel backs each logical TX queue.

Count the TX and RX channels in "dma-names" and allocate the conduit
netdev with that many hardware queues. Parse the "tx-queues-config"
child node to map each logical TX queue to its physical DMA channel.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
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
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c | 197 +++++++++++++++++++++++-
 1 file changed, 196 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index 089f17a126f5..24025b1f6e66 100644
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
@@ -21,14 +23,31 @@
 
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
  * @ndev: the conduit netdev ("ep0" for the first IP instance)
  * @dev: backing device
+ * @num_tx_queues: number of TX DMA channels (one per priority)
+ * @num_rx_queues: number of RX DMA channels
+ * @tx_dma_chan_map: logical TX queue index -> physical DMA channel number
+ * @rx_chan_num: RX ring index -> physical DMA channel number
+ * @max_frm_size: maximum frame size accepted on RX
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
 	struct device *dev;
+	u32 num_tx_queues;
+	u32 num_rx_queues;
+	u32 tx_dma_chan_map[TSN_MAX_TX_QUEUE];
+	u32 rx_chan_num[TSN_MAX_RX_QUEUE];
+	u32 max_frm_size;
 };
 
 static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
@@ -69,15 +88,173 @@ static const struct ethtool_ops ep_ethtool_ops = {
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
+static int ep_count_dma_queues(struct device *dev, u32 *out_tx, u32 *out_rx,
+			       u16 *tx_present, u32 *rx_chan_num)
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
+			rx_chan_num[rx] = idx;
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
+	u32 rx_chan_num[TSN_MAX_RX_QUEUE];
 	struct device *dev = &pdev->dev;
+	struct device_node *txcfg_np;
+	u32 num_tx, num_rx, num_prio;
+	struct device_node *ip_np;
 	struct net_device *ndev;
 	struct xlnx_tsn_ep *ep;
 	u8 mac_addr[ETH_ALEN];
+	u16 tx_present = 0;
 	int ret;
+	int i;
+
+	ret = ep_count_dma_queues(dev, &num_tx, &num_rx, &tx_present, rx_chan_num);
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
+	if (num_tx != num_prio)
+		return dev_err_probe(dev, -EINVAL,
+				     "TX channel count %u must equal num-priorities %u\n",
+				     num_tx, num_prio);
 
-	ndev = alloc_netdev(sizeof(*ep), "ep%d", NET_NAME_ENUM, ether_setup);
+	ndev = alloc_netdev_mqs(sizeof(*ep), "ep%d", NET_NAME_ENUM,
+				ether_setup, num_tx, num_rx);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -89,6 +266,24 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 	ep = netdev_priv(ndev);
 	ep->ndev = ndev;
 	ep->dev = dev;
+	ep->num_tx_queues = num_tx;
+	ep->num_rx_queues = num_rx;
+	ep->max_frm_size = TSN_MAX_VLAN_FRAME_SIZE;
+	memcpy(ep->rx_chan_num, rx_chan_num, num_rx * sizeof(*rx_chan_num));
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
2.43.0

