Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013065.outbound.protection.outlook.com [40.107.201.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B6D47ECF3
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143202; cv=fail; b=Tar//J4+t1/xldAnzQV9TISqyv445fX6/qy/1fhlkC8Mnq+gMktd58d034tUBFta3K9rBfswGkjWy/RWUJIrOq3KesoYvw2ZDaV3rljdQzHe8tecmjlCpgA/oDA2RmY0lVYUIFKbvbCW4OWxmcCadExGEncKYPjVxwBmYI2n0V4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143202; c=relaxed/simple;
	bh=5axMPJLJso/d86a3/LUfRnhmIBOwxTSjY0ToAy7IIsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Wa6R3UW6ZTSaqWarPGe6oqojkHtIjEG3oaI/EMVSt50qMxjHA4IIJ9mIz0Kep7DkfT8yenP6/Lx3ryIudYW7SabwhxWuBx5Q0EvFPXBJQi2qAje0cMmaMr6EM8tjgpNMF8+l5frmOT5/hhguXxnJBZB9WRe6Sguy17zfB6HHcrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vkN5Ucvh; arc=fail smtp.client-ip=40.107.201.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vkN5Ucvh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yVyEylROJfCU3yF0fsuTJsGkBo+LOOmKh6d2s1pqnWTtUcokj2L4b4jpaostNHOVn3HNCc27APeNvMpuA67S9L9QP7mDla7rM4oudi+379BrCF9lfy79aDD7V7wncO2ub1XgsPAiTTvdAoPnhS2nBx8UApJn9hBopLblLltKkJ1tpdG2hku9mEZKnmrScs6+O201UJrM29Lbia/BfAlMGRgaojmnIpWhdRCXF2f2q4FqFqefDrf6/e88VZRkKL0ih3AWpa1tJADI+mqaEhaaFPX46SPqZKqwWUnaVvgtkPGaAsw2qQ6kkzACiAwAbXncDD/wie2+2HAcxKbcqry8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WbjXoel/LHcdPM6PZHmP2kAGynNrzmuq0z85aa4F2/c=;
 b=szhTlDS1MnW1/2fU13Q8JJMUAS2FxHFPXXkSXG9i3M8+VzbADMFK4iBXi7oCffeVCI6lHEtichJfmAUC/xP4sxOWRATELmd+K5BmqBG0jhVRys6X+ImKNDabzsiYmfODjy4om+11W0h981Q0rFrNuKWNRbH5kL72n4DpISLsFPWfL4/4tH52u4jY/lo07laW/afs0R1+j8pT6XmMbExRdJw1awGw78wVjTouopufJsa3vVFvB1KLHrVqOVEL9j1hNnrvZFXKWX8ZEEBWx3HCsMwViCcAw0JXFcUMtjWKzIWJEgLHg2elMfIU7fqXC2YeLq7CXojUuOUtXz4VSHyTSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbjXoel/LHcdPM6PZHmP2kAGynNrzmuq0z85aa4F2/c=;
 b=vkN5UcvhtPeJDgmxkwNQDUaAfTUbYGUMHa9Re64+M//mwUuN6jAqno/n6h4AlUoWqJU1t/vbnX31lGN5JQy1E88JEBGGqzwvIELPUMjzQeGp+1Fgtsp0HiwnTekUka68zrFWn3liTgTcmzgMdd1QkSY5sU8t6qBtf2RkWsEWAEo=
Received: from SJ0PR05CA0046.namprd05.prod.outlook.com (2603:10b6:a03:33f::21)
 by CY3PR12MB9656.namprd12.prod.outlook.com (2603:10b6:930:101::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 09:33:13 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::58) by SJ0PR05CA0046.outlook.office365.com
 (2603:10b6:a03:33f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 09:33:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:33:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:32:59 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 04:32:54 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 16 Oct 2026 15:02:04 +0530
Subject: [PATCH net-next v3 5/8] net: xilinx: tsn: bring up the endpoint
 MCDMA channels
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261016-patches_v2_external-v3-5-e33d3960ca1e@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|CY3PR12MB9656:EE_
X-MS-Office365-Filtering-Correlation-Id: 05943df1-54ea-4b54-1c14-08df2b687ffb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|1800799024|376014|18002099003|10067099003|22082099003|6133799003|11063799006|921020|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kFVrfLPmHx1IihmAhCiRG5w16KGOyLtdyvxVfT3MqGdLOCNxv6TTtjoBL2KOtN5LAfICvRazDtQKhSw52TZ29qxiVDNHEozr/PtiFP/votKNnHSmoLeE1hDB3PF8MW1rrrxuuQi2whMcKE6+2v1t95pGnlGBR9nkXZb/ruyWIe2wicDdRt75fzja1oi0l8MXIx4doJ0wasbkuO+oJG+R2OeBtFyHztVXhmS9eCNcztqOtwHbNiaxkWGlZUljW7fwlLiVG9Tgp84yOWoRx6Mp0bj3er185/MICzOpmPMuYnX8apeSYVLigTTBtDjsX8Bch1U92QxZVeM8mWJc30pA+vMrl8lM71U+pbl2L6SXjCB3j2+y8hxYJWr4pdQJh16fBxeBVUcJxhQGjMAjnKW2KvpTmSpiH2JR5aCSAjdbVlX5VoKS+kM6ym06b31JcY2ujGEEEororA8l30Nr1isqKVu0Wz8CPfQVsdSi3t1mnS4teWUig3BR198er/aLzSQvImK2cejaeK+m0P1CrYXARIaoaG41w6MNFNd6gqaysCNOaUqWa2021QRCz2J1LJp8RkhtwbZ4hv0s3O+Po5OEmdevXZ/RhHhLF2nbXCT9fHSwfJsfdvUiN8wtIqzdtj++6zmvVPCUCPeUnZ0re1EAiQgkyetwYj+hjR21oeuK5i0NeM8/K0T0oHnmXCqdIoatAXhI+vXpeF2BNtqLL3KO0YxtVNmSf2Zn/GRvNDQzupBVQhDtNcnHxPi6OfCRPpQO
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(1800799024)(376014)(18002099003)(10067099003)(22082099003)(6133799003)(11063799006)(921020)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r0uyXW71TESbs1wKDImtdssyUsApcDLT2JZH7XgWylfHc8qKUUwn4ol0tY/r6sShPpxGvhyWzUbouDB0tEzVp0kpKQXhkaDyvZoZIb3YPksOe5onHGgoQBcjQitrzeANCnVBc3Wkc+q+MlTl1VDrytLwyr/r52YDeKjv5B26554tPZJ6BNdcu110vKcEJUqjiHraDcbK0i8B6yW0ExNCoT7vLf/cUFpF5xufhpaSU730q2m6ICedA+trrnOHIRMG8wXrxvMp8MJBvQnjJ77vOxqhVk70iwcVeM1oWxMGfa4Sb1XordG/MZcK3V1o8E24HHiTq7eellR+VtYlJDPZWO/NKqyDSpEQJCsMKP0IY3NkPxiTr+7m4vWhTg3efSd6nVMIHaAuy9TFh7iZDRGpgTHxsb3I6kWdxvEu8H1MFUv6iFqM8WWHcw7iUFJS9WSE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:33:13.2894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05943df1-54ea-4b54-1c14-08df2b687ffb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9656

Before the endpoint can move frames, each MCDMA channel needs a ring of
buffers and a live dmaengine channel.

Request every TX and RX channel named in the device tree at probe and
hold them for the lifetime of the device. dma_request_chan() returns
-EPROBE_DEFER until the MCDMA provider is bound, and probe is the only
context the driver core retries, so acquiring the channels here keeps
the deferral where it can be handled. Holding them also pins the
provider, so the channels cannot go away while the interface is down.

Reset the controller once at probe through the first held TX channel. An
MCDMA soft reset resets the whole core, so any channel of the instance
reaches it.

Give each channel a ring of preallocated SKB descriptor slots when the
interface opens, and tear the rings down on stop, where
dmaengine_terminate_sync() returns each channel to a clean state. Add
the XILINX_DMA dependency for the dmaengine and Xilinx DMA APIs.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v3:
- Acquire every TX and RX channel in probe and hold them until remove.
  ndo_open now only builds the rings. dma_request_chan() is the call that
  can return -EPROBE_DEFER and probe is the only context the driver core
  retries, so the deferral no longer has to be translated in ndo_open.
  Holding the channels also pins the MCDMA provider, so it cannot go away
  while the interface is down.
- Reset the controller through the first held TX channel instead of
  requesting and releasing a channel for the reset alone.
- Move the closing flag (field, kernel-doc and its ndo_open/ndo_stop
  writes) to the RX data path patch, where it is first read. Drop the
  unused io.h include and move circ_buf.h and spinlock.h to the RX patch
  that first uses CIRC_SPACE() and spinlock_t.
- Reword the commit description for the probe-time channel acquisition.

Changes in v2:
- Request a channel at probe time so -EPROBE_DEFER stays in the probe path and
  ndo_open never hands a deferral back to userspace.
- Request the channels by their real dma-names index, not a dense 0..N-1
  sequence.
- Reword the commit message so the reset reads as probe-time through the first
  mapped TX channel, not on open.
---
 drivers/net/ethernet/xilinx/tsn/Kconfig         |   1 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c | 316 +++++++++++++++++++++++-
 2 files changed, 315 insertions(+), 2 deletions(-)

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
index 2adee07f6f51..ab3d6d8cb944 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -6,6 +6,9 @@
  */
 
 #include <linux/bitops.h>
+#include <linux/dma/xilinx_dma.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
 #include <linux/if_ether.h>
@@ -16,6 +19,8 @@
 #include <linux/of.h>
 #include <linux/of_net.h>
 #include <linux/platform_device.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/types.h>
 
@@ -30,6 +35,47 @@
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
  * @ndev: the conduit netdev
@@ -39,6 +85,10 @@
  * @tx_dma_chan_map: TX queue to tx_chanN map, or TSN_DMA_CH_INVALID when
  *	the queue has no channel
  * @max_frm_size: maximum frame size accepted on RX
+ * @tx_dma: dmaengine TX channels, held from probe until remove
+ * @rx_dma: dmaengine RX channels, held from probe until remove
+ * @tx_chans: array of TX channels (size @num_tx_queues)
+ * @rx_chans: array of RX channels (size @num_rx_queues)
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
@@ -47,8 +97,21 @@ struct xlnx_tsn_ep {
 	u32 num_rx_queues;
 	u32 tx_dma_chan_map[TSN_MAX_TX_QUEUE];
 	u32 max_frm_size;
+
+	struct dma_chan *tx_dma[TSN_MAX_TX_QUEUE];
+	struct dma_chan *rx_dma[TSN_MAX_RX_QUEUE];
+
+	struct xlnx_tsn_ep_dma_chan **tx_chans;
+	struct xlnx_tsn_ep_dma_chan **rx_chans;
+
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
@@ -56,8 +119,21 @@ static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
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
+	ret = ep_init_dmaengine(ep);
+	if (ret) {
+		netdev_err(ndev, "failed to initialize DMA engine\n");
+
+		return ret;
+	}
+
 	netif_tx_start_all_queues(ndev);
 
 	return 0;
@@ -65,7 +141,10 @@ static int ep_open(struct net_device *ndev)
 
 static int ep_stop(struct net_device *ndev)
 {
+	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+
 	netif_tx_disable(ndev);
+	ep_exit_dmaengine(ep);
 
 	return 0;
 }
@@ -87,6 +166,228 @@ static const struct ethtool_ops ep_ethtool_ops = {
 	.get_drvinfo	= ep_get_drvinfo,
 };
 
+static struct xlnx_tsn_ep_dma_chan *
+ep_alloc_dma_chan(struct xlnx_tsn_ep *ep, struct dma_chan *dma_chan,
+		  bool is_tx, int ring_size)
+{
+	struct xlnx_tsn_ep_dma_chan *chan;
+	int i;
+
+	chan = kzalloc_obj(*chan);
+	if (!chan)
+		return ERR_PTR(-ENOMEM);
+
+	chan->chan = dma_chan;
+
+	chan->skb_ring = kcalloc(ring_size, sizeof(*chan->skb_ring), GFP_KERNEL);
+	if (!chan->skb_ring) {
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
+		ep->tx_chans[i] = ep_alloc_dma_chan(ep, ep->tx_dma[i], true,
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
+		ep->rx_chans[i] = ep_alloc_dma_chan(ep, ep->rx_dma[i], false,
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
+static void ep_release_dma_chans(struct xlnx_tsn_ep *ep)
+{
+	unsigned int i;
+
+	for (i = 0; i < ep->num_tx_queues; i++) {
+		if (ep->tx_dma[i]) {
+			dma_release_channel(ep->tx_dma[i]);
+			ep->tx_dma[i] = NULL;
+		}
+	}
+
+	for (i = 0; i < ep->num_rx_queues; i++) {
+		if (ep->rx_dma[i]) {
+			dma_release_channel(ep->rx_dma[i]);
+			ep->rx_dma[i] = NULL;
+		}
+	}
+}
+
+static int ep_request_dma_chans(struct xlnx_tsn_ep *ep,
+				const u32 *rx_dma_chan_map)
+{
+	struct dma_chan *chan;
+	char name[16];
+	unsigned int i;
+	int ret;
+
+	for (i = 0; i < ep->num_tx_queues; i++) {
+		snprintf(name, sizeof(name), "tx_chan%u", ep->tx_dma_chan_map[i]);
+		chan = dma_request_chan(ep->dev, name);
+		if (IS_ERR(chan)) {
+			ret = PTR_ERR(chan);
+			goto err_release;
+		}
+		ep->tx_dma[i] = chan;
+	}
+
+	for (i = 0; i < ep->num_rx_queues; i++) {
+		snprintf(name, sizeof(name), "rx_chan%u", rx_dma_chan_map[i]);
+		chan = dma_request_chan(ep->dev, name);
+		if (IS_ERR(chan)) {
+			ret = PTR_ERR(chan);
+			goto err_release;
+		}
+		ep->rx_dma[i] = chan;
+	}
+
+	return 0;
+
+err_release:
+	ep_release_dma_chans(ep);
+
+	return dev_err_probe(ep->dev, ret, "failed to request %s\n", name);
+}
+
+static int ep_reset_dma_controller(struct xlnx_tsn_ep *ep)
+{
+	struct xilinx_vdma_config cfg = { .reset = 1 };
+	int ret;
+
+	ret = xilinx_vdma_channel_set_config(ep->tx_dma[0], &cfg);
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
@@ -286,9 +587,17 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_free_ndev;
 
+	ret = ep_request_dma_chans(ep, rx_dma_chan_map);
+	if (ret)
+		goto err_free_ndev;
+
+	ret = ep_reset_dma_controller(ep);
+	if (ret)
+		goto err_release_chans;
+
 	ret = of_get_mac_address(dev->of_node, mac_addr);
 	if (ret == -EPROBE_DEFER) {
-		goto err_free_ndev;
+		goto err_release_chans;
 	} else if (!ret && is_valid_ether_addr(mac_addr)) {
 		eth_hw_addr_set(ndev, mac_addr);
 	} else {
@@ -302,11 +611,13 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
 	ret = register_netdev(ndev);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register net device\n");
-		goto err_free_ndev;
+		goto err_release_chans;
 	}
 
 	return 0;
 
+err_release_chans:
+	ep_release_dma_chans(ep);
 err_free_ndev:
 	free_netdev(ndev);
 	return ret;
@@ -320,6 +631,7 @@ static void xlnx_tsn_ep_remove(struct platform_device *pdev)
 		return;
 
 	unregister_netdev(ep->ndev);
+	ep_release_dma_chans(ep);
 	free_netdev(ep->ndev);
 }
 

-- 
2.44.4

