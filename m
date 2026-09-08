Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A4E59E32D
	for <linux-rt-devel@lists.linux.dev>; Tue,  8 Sep 2026 19:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895252; cv=fail; b=Bt73MpPw5X1RGdyFj73lbHr+S4CftS59d1DTy6KEojZVKv1cg0wawjfUvR3QR9zhR4ANAvpRM6v++i4BisFpKJIWLcGvPNBQPFWi1t9tCIoFfBEO9OcT1lm+ju3F+IpFkdcJIm4DxqD6QmpuVZWTCB44SMzFhO+ZMrYUvZo7kag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895252; c=relaxed/simple;
	bh=eOu9W2i7Me5z2gE07e26KZy/6PlWsoyLL9Sx2WeUmIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UHwWavCd6DuyqbfKWnUTw9m0ncqmf4metRXKV8jhPNcpBccQT9SOAJ5mqGjkFVIzVvQUdtLW/chvebV0cBhwqsl0aop4cWxsDHQQGgwijj7SjFEe34y0NQDydKMQmkYuwp/uidi8x40N3Z+Ps1fH0WfzWdUJ5oxPqaqUFPdH5R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vkZXL8oz; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vkZXL8oz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wcFFgMzKjUzDJslR4Fg5X5Oz4fFlSIEu2CSO6ODu52wefBtCl9oFJDIj7EGY1CVpO+epFVf5fv2ilcG3hl/J/SZljs9VpyY6XJu7Vxi5Kt4hwNBwXCV26z5qZls5eez5Lsfx8LhBJ8KMJeYrglziPYEb7RW9+UK4YJYjlMCHErnp7UShiEy3Mly4fKg0dAOyve98BXD1A4Lt6Y+FtL1tQQOIjM+WHZ1N7vDQL5lvuF6jP6sa0Yl866uwJyZ2lacPu2OWMabZ0lKQkx/WKNlhcx8yEQ6V9QmSYREZpePhL5kjy5xcLova2mQY+fz6SDgDzNl7A1CkSPBbzgeUXBO2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wf80GsUe881wpKKcZpNI+Upxtq7WdAN3T9NUYcgGTpY=;
 b=AWGZUJG/uhaIVxRgDRGVZ/oLBpoh0Qmn3Ly51Kop7vsUK8z9LV6hUUC3IamYxFpB+osOpVL/pZCQphI7uclmumuxlJxOYdhy6gylbFh4Wp2FKia3YrLK2raY/t89gNOiyPwuxphmnY+fbVEO5dSkB2MyOHoBrGC56728HFuW3ZjDV1KCjwMce6WHewyrbc/rEvII5ri7V5QtoXWw/m3XfJPhBZrctGS0AjvovkIf/rnwVaZLMHPbrFxgoRBMjs+PNmBh/Xw2r2KYFGK68f0Uj2+ERYDnpr7bjjc/jhdKLfRKqDQ5uU9W+JXidBqMBPsVN5AgaICvdseuLsojLJJ1Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wf80GsUe881wpKKcZpNI+Upxtq7WdAN3T9NUYcgGTpY=;
 b=vkZXL8ozo869HulQdVIIFA2GyfOiCXTzwx39ZQPXiS6PXNMPY2kB5Jt0DLYxYfQ3KHODxwSVOr/eCdXtTe6NaCyGNkc+K9wkgg8wwhiOXkv+spginhrXneODUUrGWPZaDAFBXEdPX+EWSPH/yZ9qR0tIoyDkYg93FABHYtvGeTk=
Received: from SN7PR04CA0078.namprd04.prod.outlook.com (2603:10b6:806:121::23)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 19:20:37 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::95) by SN7PR04CA0078.outlook.office365.com
 (2603:10b6:806:121::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 19:20:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:20:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:35 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 14:20:30 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Wed, 9 Sep 2026 00:49:53 +0530
Subject: [PATCH net-next v2 5/8] net: xilinx: tsn: bring up the endpoint
 MCDMA channels
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-patches_v2_external-v2-5-3a40babaff4c@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: e41f37ed-2c4c-4d23-3df7-08df0dde4333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|921020|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	M3QQ6TcB68XtfA8xW9VAkNDsAwu+Syja0dgRnmbyiUWqU003kfOz82WsoAXgWOjsQLZ66WARyt3e39f8sozXiaYGpbcUjOA+67xHRpEWQdu4ttHmZ/r+hlrTTYpSAON9nQeVjvNlM8kLM3KPaH7IDW8xjpvj/QozZm6pqUz/qRLEKc+Di3AMvZFWkU1GoQqfoaBhY0TTdJZnrYDzU1IEUahfOXkGp4EAbnHF/lyqxysJNsLXLAvItff8AiYxco33rEMcl2//vk0FEgiKNq5rlr+eIPA68OlQJPSOYqm/3O8xzceFBQgSLHzqUi5HFeljOXGG+buEOFGKH+zGFdd/txE0nVyerd6BXl1bQCgco/Cs8R4revGrPxtO5ih9C42ce9SbaZy8xeqehm2hG4w4Odt4KMbRvEiJz0N0vUUcMG+qdB85JjkY5643PFp2muu0/Dff8m/3xCy2RVCnKU8wS/q7h/FlGPkSZWTSTBL+MoFlAuL3TEYFmrne9zdRoqrGbbBhqLU0An3TP6O9F4nCzQTD1CbgaDuKyTQXme+ba+E18JdngJsnMOdKXLUyDiOwbpgW9Q7VSMWcQ5nHr8OlnIEQ5wQqyMmugAldsVFywUW0FjqQ0X/TqTDu83rtxddXjQRn1/lgoEBeGOIvVl0i+YHEe5FHdBy1H79WyAa59X1z0ioiR8YE1QzcYPvjZawUNqqMcC5DIMbdiCOKU1ack1RQLlYcbF53z7WBHDVqTigjl1V9T7T0MJwA+QuhTHTg
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kNkARlshU0tVSR1RNyqhVaU22qbLbrvIeM4ZqDMdCcJsUlLb8m7HWrO4H3kiZBimI44g3X0wjb96bM2b+H6w5Tspd8uNV+yTWRrAavz/nYbs4Qb/Kdf8Ju649u4u4IBSOdj1J9qN+POfmjUlsvW3pb0qu8aLmK9susOpbgRZ+L3SnwItXuIRdalRzn2Yy9apNbN6D43fuNgXRN0a1osrX/l5/WdQE5YfAMGUySdR7l46EU9W/Pq9sxhfNIDETWia3l0jvU6JQVyvDLEGn6pVZ7u5OlZDJxPdIbsKDbfoongcapqJkbpgmZJsb4v4WyNEZwped4Qr9MrRZRKATPS0f1NPBnOa1IxvG0ePmxfX0EpJs1nzd1BipmLfsiv8m9GkrWLgcjX58P6uS7PovPz2iBYyXobaAWpPX/Q6PkpD3SmHSp77ijTUGCppa9eAPp6M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:20:37.0566
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e41f37ed-2c4c-4d23-3df7-08df0dde4333
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411

Before the endpoint can move frames, each MCDMA channel needs a ring of
buffers and a live dmaengine channel.

Request every TX and RX channel named in the device tree when the
interface opens, and give each one a ring of preallocated SKB descriptor
slots. Reset the controller once at probe time through the first mapped
TX channel, which also gates probe on the MCDMA provider being bound so
-EPROBE_DEFER stays in the probe path and never reaches ndo_open. Release
the channels on stop, where dmaengine_terminate_sync() returns them to a
clean state. Add the XILINX_DMA dependency for the dmaengine and Xilinx
DMA APIs.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v2:
- Request a channel at probe time so -EPROBE_DEFER stays in the probe path and
  ndo_open never hands a deferral back to userspace.
- Request the channels by their real dma-names index, not a dense 0..N-1
  sequence.
- Reword the commit message so the reset reads as probe-time through the first
  mapped TX channel, not on open.
---
 drivers/net/ethernet/xilinx/tsn/Kconfig         |   1 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c | 281 ++++++++++++++++++++++++
 2 files changed, 282 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/tsn/Kconfig b/drivers/net/ethernet/xilinx/tsn/Kconfig
index b8939d8a92ef..292f17694404 100644
--- a/drivers/net/ethernet/xilinx/tsn/Kconfig
+++ b/drivers/net/ethernet/xilinx/tsn/Kconfig
@@ -6,6 +6,7 @@
 config XILINX_TSN
 	tristate "Xilinx TSN Ethernet driver"
 	depends on OF_ADDRESS
+	depends on XILINX_DMA
 	help
 	  This driver supports the AMD/Xilinx Time-Sensitive Networking
 	  (TSN) Endpoint Ethernet MAC IP. It provides the wrapper device
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index 24025b1f6e66..23a15df71baa 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -6,16 +6,24 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/circ_buf.h>
+#include <linux/dma/xilinx_dma.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_ether.h>
 #include <linux/if_vlan.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -30,6 +38,47 @@
 #define TSN_MAX_VLAN_FRAME_SIZE		(ETH_DATA_LEN + VLAN_ETH_HLEN + \
 					 ETH_FCS_LEN)
 
+#define TX_BD_NUM_DEFAULT		64
+#define RX_BD_NUM_DEFAULT		128
+
+/**
+ * struct skbuf_dma_descriptor - skb container for each in-flight DMA descriptor
+ * @sgl: scatter-gather list backing the DMA mapping
+ * @desc: dmaengine descriptor handle
+ * @dma_address: physical address of the first sgl entry (RX path)
+ * @skb: SKB owning the buffer
+ * @sg_len: number of valid entries in @sgl (TX path)
+ */
+struct skbuf_dma_descriptor {
+	struct scatterlist sgl[MAX_SKB_FRAGS + 1];
+	struct dma_async_tx_descriptor *desc;
+	dma_addr_t dma_address;
+	struct sk_buff *skb;
+	int sg_len;
+};
+
+/**
+ * struct xlnx_tsn_ep_dma_chan - one DMA channel and its SKB ring
+ * @skb_ring: per-slot SKB descriptors
+ * @ep: pointer back to the owning EP instance
+ * @chan: dmaengine channel handle
+ * @dma_dev: device used for DMA mapping (the DMA engine, not the EP)
+ * @ring_head: producer index
+ * @ring_tail: consumer index
+ * @ring_size: number of slots in @skb_ring
+ * @is_tx: true for TX channels, false for RX
+ */
+struct xlnx_tsn_ep_dma_chan {
+	struct skbuf_dma_descriptor **skb_ring;
+	struct xlnx_tsn_ep *ep;
+	struct dma_chan *chan;
+	struct device *dma_dev;
+	u32 ring_head;
+	u32 ring_tail;
+	u32 ring_size;
+	bool is_tx;
+};
+
 /**
  * struct xlnx_tsn_ep - EP MAC private data, embedded in net_device priv area
  * @ndev: the conduit netdev ("ep0" for the first IP instance)
@@ -39,6 +88,9 @@
  * @tx_dma_chan_map: logical TX queue index -> physical DMA channel number
  * @rx_chan_num: RX ring index -> physical DMA channel number
  * @max_frm_size: maximum frame size accepted on RX
+ * @tx_chans: array of TX channels (size @num_tx_queues)
+ * @rx_chans: array of RX channels (size @num_rx_queues)
+ * @closing: set in ndo_stop so the RX completion callback stops re-arming
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
@@ -48,8 +100,19 @@ struct xlnx_tsn_ep {
 	u32 tx_dma_chan_map[TSN_MAX_TX_QUEUE];
 	u32 rx_chan_num[TSN_MAX_RX_QUEUE];
 	u32 max_frm_size;
+
+	struct xlnx_tsn_ep_dma_chan **tx_chans;
+	struct xlnx_tsn_ep_dma_chan **rx_chans;
+
+	bool closing;
 };
 
+static inline struct skbuf_dma_descriptor *
+ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)
+{
+	return xchan->skb_ring[idx];
+}
+
 static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	dev_kfree_skb_any(skb);
@@ -57,8 +120,22 @@ static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+static int ep_init_dmaengine(struct xlnx_tsn_ep *ep);
+static void ep_exit_dmaengine(struct xlnx_tsn_ep *ep);
+
 static int ep_open(struct net_device *ndev)
 {
+	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+	int ret;
+
+	WRITE_ONCE(ep->closing, false);
+
+	ret = ep_init_dmaengine(ep);
+	if (ret) {
+		netdev_err(ndev, "failed to initialize DMA engine\n");
+		return ret;
+	}
+
 	netif_tx_start_all_queues(ndev);
 
 	return 0;
@@ -66,7 +143,11 @@ static int ep_open(struct net_device *ndev)
 
 static int ep_stop(struct net_device *ndev)
 {
+	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+
 	netif_tx_disable(ndev);
+	WRITE_ONCE(ep->closing, true);
+	ep_exit_dmaengine(ep);
 
 	return 0;
 }
@@ -88,6 +169,196 @@ static const struct ethtool_ops ep_ethtool_ops = {
 	.get_drvinfo	= ep_get_drvinfo,
 };
 
+static struct xlnx_tsn_ep_dma_chan *
+ep_alloc_dma_chan(struct xlnx_tsn_ep *ep, const char *name, bool is_tx,
+		  int ring_size)
+{
+	struct xlnx_tsn_ep_dma_chan *chan;
+	struct dma_chan *err_chan;
+	int i;
+
+	chan = kzalloc_obj(*chan);
+	if (!chan)
+		return ERR_PTR(-ENOMEM);
+
+	chan->chan = dma_request_chan(ep->dev, name);
+	if (IS_ERR(chan->chan)) {
+		err_chan = chan->chan;
+		kfree(chan);
+		return ERR_CAST(err_chan);
+	}
+
+	chan->skb_ring = kcalloc(ring_size, sizeof(*chan->skb_ring), GFP_KERNEL);
+	if (!chan->skb_ring) {
+		dma_release_channel(chan->chan);
+		kfree(chan);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	for (i = 0; i < ring_size; i++) {
+		chan->skb_ring[i] = kzalloc_obj(*chan->skb_ring[i]);
+		if (!chan->skb_ring[i]) {
+			while (--i >= 0)
+				kfree(chan->skb_ring[i]);
+			kfree(chan->skb_ring);
+			dma_release_channel(chan->chan);
+			kfree(chan);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	chan->is_tx = is_tx;
+	chan->ep = ep;
+	chan->ring_size = ring_size;
+	chan->dma_dev = dmaengine_get_dma_device(chan->chan);
+
+	return chan;
+}
+
+static void ep_free_dma_chan(struct xlnx_tsn_ep_dma_chan *chan)
+{
+	int i;
+
+	if (!chan)
+		return;
+
+	if (chan->chan)
+		dmaengine_terminate_sync(chan->chan);
+
+	if (chan->is_tx) {
+		while (chan->ring_tail != chan->ring_head) {
+			struct skbuf_dma_descriptor *skbuf_dma;
+
+			skbuf_dma = chan->skb_ring[chan->ring_tail &
+						  (chan->ring_size - 1)];
+			if (skbuf_dma && skbuf_dma->skb) {
+				dma_unmap_sg(chan->dma_dev, skbuf_dma->sgl,
+					     skbuf_dma->sg_len, DMA_TO_DEVICE);
+				dev_kfree_skb_any(skbuf_dma->skb);
+				skbuf_dma->skb = NULL;
+			}
+			chan->ring_tail++;
+		}
+	}
+
+	if (chan->skb_ring) {
+		for (i = 0; i < chan->ring_size; i++) {
+			struct skbuf_dma_descriptor *skbuf_dma = chan->skb_ring[i];
+
+			if (skbuf_dma && !chan->is_tx && skbuf_dma->skb) {
+				dma_unmap_single(chan->dma_dev,
+						 skbuf_dma->dma_address,
+						 chan->ep->max_frm_size,
+						 DMA_FROM_DEVICE);
+				dev_kfree_skb_any(skbuf_dma->skb);
+			}
+			kfree(chan->skb_ring[i]);
+		}
+		kfree(chan->skb_ring);
+	}
+	if (chan->chan)
+		dma_release_channel(chan->chan);
+
+	kfree(chan);
+}
+
+static void ep_exit_dmaengine(struct xlnx_tsn_ep *ep)
+{
+	int i;
+
+	if (ep->tx_chans) {
+		for (i = 0; i < ep->num_tx_queues; i++)
+			ep_free_dma_chan(ep->tx_chans[i]);
+		kfree(ep->tx_chans);
+		ep->tx_chans = NULL;
+	}
+	if (ep->rx_chans) {
+		for (i = 0; i < ep->num_rx_queues; i++)
+			ep_free_dma_chan(ep->rx_chans[i]);
+		kfree(ep->rx_chans);
+		ep->rx_chans = NULL;
+	}
+}
+
+static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
+{
+	int tx_allocated = 0, rx_allocated = 0;
+	char name[16];
+	int i, ret;
+
+	ep->tx_chans = kcalloc(ep->num_tx_queues, sizeof(*ep->tx_chans),
+			       GFP_KERNEL);
+	if (!ep->tx_chans)
+		return -ENOMEM;
+
+	ep->rx_chans = kcalloc(ep->num_rx_queues, sizeof(*ep->rx_chans),
+			       GFP_KERNEL);
+	if (!ep->rx_chans) {
+		ret = -ENOMEM;
+		goto err_free_tx;
+	}
+
+	for (i = 0; i < ep->num_tx_queues; i++) {
+		snprintf(name, sizeof(name), "tx_chan%u", ep->tx_dma_chan_map[i]);
+		ep->tx_chans[i] = ep_alloc_dma_chan(ep, name, true,
+						    TX_BD_NUM_DEFAULT);
+		if (IS_ERR(ep->tx_chans[i])) {
+			ret = PTR_ERR(ep->tx_chans[i]);
+			ep->tx_chans[i] = NULL;
+			goto err_free_chans;
+		}
+		tx_allocated++;
+	}
+
+	for (i = 0; i < ep->num_rx_queues; i++) {
+		snprintf(name, sizeof(name), "rx_chan%u", ep->rx_chan_num[i]);
+		ep->rx_chans[i] = ep_alloc_dma_chan(ep, name, false,
+						    RX_BD_NUM_DEFAULT);
+		if (IS_ERR(ep->rx_chans[i])) {
+			ret = PTR_ERR(ep->rx_chans[i]);
+			ep->rx_chans[i] = NULL;
+			goto err_free_chans;
+		}
+		rx_allocated++;
+	}
+
+	return 0;
+
+err_free_chans:
+	while (--rx_allocated >= 0)
+		ep_free_dma_chan(ep->rx_chans[rx_allocated]);
+	while (--tx_allocated >= 0)
+		ep_free_dma_chan(ep->tx_chans[tx_allocated]);
+	kfree(ep->rx_chans);
+	ep->rx_chans = NULL;
+err_free_tx:
+	kfree(ep->tx_chans);
+	ep->tx_chans = NULL;
+	return ret;
+}
+
+static int ep_reset_dma_controller(struct xlnx_tsn_ep *ep)
+{
+	struct xilinx_vdma_config cfg = { .reset = 1 };
+	struct dma_chan *reset_chan;
+	char name[16];
+	int ret;
+
+	snprintf(name, sizeof(name), "tx_chan%u", ep->tx_dma_chan_map[0]);
+	reset_chan = dma_request_chan(ep->dev, name);
+	if (IS_ERR(reset_chan))
+		return dev_err_probe(ep->dev, PTR_ERR(reset_chan),
+				     "failed to request %s for reset\n", name);
+
+	ret = xilinx_vdma_channel_set_config(reset_chan, &cfg);
+	dma_release_channel(reset_chan);
+	if (ret < 0)
+		return dev_err_probe(ep->dev, ret,
+				     "failed to reset DMA controller\n");
+
+	return 0;
+}
+
 /*
  * Parse the "tx-queues-config" child of the EP node. The logical queue
  * index is taken from the "queue<N>" node name, so the mapping does not
@@ -285,6 +556,16 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free_ndev;
 
+	/*
+	 * Request one DMA channel at probe time to reset the controller and to
+	 * gate on the MCDMA provider being bound. This keeps -EPROBE_DEFER in
+	 * the probe path, so the netdev is only registered once the provider is
+	 * available and ndo_open never sees a deferral.
+	 */
+	ret = ep_reset_dma_controller(ep);
+	if (ret)
+		goto err_free_ndev;
+
 	ret = of_get_mac_address(dev->of_node, mac_addr);
 	if (ret == -EPROBE_DEFER) {
 		goto err_free_ndev;

-- 
2.43.0

