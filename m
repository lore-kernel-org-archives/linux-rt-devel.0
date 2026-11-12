Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.57
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794543103;
	b=h7LGNgkJu9bSAiij42o+n0UG8M35aUvWu1unVd8q1t0GL6iLC7YubZalLXWVt8Pz45lY
	 Ufr7kvIJ7XGadZyQdB071fFSLb/jx/9Ww1fhYjcEvmH/gsp6MiZ8TZZgvfNDPdwsiZ21b
	 BvdcU1/FLk1dwlUrTAiTO9OD8OQiYlBL3J7azKdBloB4QVRFNFs32oUBsyPDVCzh9U5D/
	 jJ/pi3yH6efW/XIF/gJgj8OYVxnYRtLNthfPcivxtQWgngreHcSPnXm/fhc7IkUrwHJKI
	 M8OkoSK8uachKs5+JsK876abwdPST2FQ2GV/qldU/XvcE/Y0PPk5datkOIeB8smCirQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794543103;
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
	bh=+lqkvsptNAsmFpGtYAdrOoSm4FQbFmznUqUV/049Skc=;
	b=1Nf+NQa/rbrs2srOLhx0+jw19eAV1RHhR1dltjKiodY7RQxO8KK9NDLztS0/gOHTtiSF
	 FR8z1CT5f9TPRD24Hv0tFFdnS+X4+4Uy1lQhgMQPJqa+76QngqsiUdX11/S4EuorbV0QX
	 e0d0xLEpmsLAqPW6KLfH7Sh6dJ+2jrhKAiME4m4IHisvoif6avL5nQCllRiPOVbN1TaWh
	 JsaR/XbTS0r7Vk2IFBMdP0VBdGV3NV8OMeXGtaCAykXJjsAZ8TEYWKp88O6WpksWd5+Nx
	 Tdv733m0ZVvBYNowoPP7iDer/K8S+p9TrhD1QVczqfX48p53YReHti4RUXBwBOhGgwg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iRRpvnUs;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.85.57
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2298606A321
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 04:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2298606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iRRpvnUs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KfzyOukX8zhOhdcX1rWgIeLzbpM0dZbN5P1ZcINefqXBbjdn7trPZeDtSMeC3A6xS1dlks4VTeGhD+K6eF8HmUkO3ZCDgmJsN38OuuA0u00qZRBH1mTJH0DklcNXVgle0E7Acof86FMJ33H5JBmNMDNuLevdpffTHZyDu43A87vNFOJFPDF5owpHlWYiDLLfmQ3hopkue4fyf1xaXlyC3kdgXM0tveRdruW/otOP1jsVqrWsTDEkuTvXJiNgKZfYiTM4/wrzWce61nb1v/bLWUBP8DhmDNlHhZFp64Ur+rGFbMCKRhcKI6lqjf9Mb5LAkMG+BFSsJlHl/Iwu1F7HEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lqkvsptNAsmFpGtYAdrOoSm4FQbFmznUqUV/049Skc=;
 b=WFIByYchdcw5BURknnPKAB3y8oiczzx/aj1vxFcSQ8yJ4BCTnYTD3raiZLQDf8eef8KJnNSwqcsmIkJ0ggT72n0zpgqa4w0fzH288oNec5d0BzpeV9//Hzkdr3S8GwPrgfOKBhHb5a014N39ILhjdYGC2W37C2bHG0scXz/6853ZMI5m3z4tqrRwP+3/TdzwiN93bSCE8JPl72T0Da+o7bA6SJZDf/1dYq8crH6QnNkCIeUj2TWjCA0KMdxWgteCvvj0UfnMIGgqpTaXsRp3mQtF4VCoNwbB0xjUK1qTdZLhLVOzUlcHCnVTsVsWnm+zvFkx2hbkZ3o89+X+9y5FXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lqkvsptNAsmFpGtYAdrOoSm4FQbFmznUqUV/049Skc=;
 b=iRRpvnUs7+nyykI4HNsmPcvzgp9BWNG25oLgoC/jVCSxyNm9hRtpc5r0bsmKBYrU1NeHl0X5pGnwGBzvBSAWK1lfvsm7TIemxS18Eape6yidp7avVWJfTiBHlooyOELldlXy0R03SZO2j6coLkVO/wMavHv4V9Ly93RhooxqcVk=
Received: from CY5P221CA0116.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:1f::28)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 04:11:39 +0000
Received: from PH2PEPF00048917.namprd05.prod.outlook.com
 (2603:10b6:930:1f:cafe::67) by CY5P221CA0116.outlook.office365.com
 (2603:10b6:930:1f::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 04:11:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 PH2PEPF00048917.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 04:11:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:33 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 12:47:27 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 13 Nov 2026 00:16:48 +0530
Subject: [PATCH net-next v4 4/8] net: xilinx: tsn: parse endpoint DMA
 channel configuration
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
Message-ID: <20261113-patches_v2_external-v4-4-56bb26f042a4@amd.com>
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
X-MS-TrafficTypeDiagnostic: PH2PEPF00048917:EE_|SJ0PR12MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: ab04a08d-a7a8-4d97-6a15-08df413c337c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|36860700016|82310400026|921020|11063799006|261028144727099003|10067099003|5023799004|56012099006|261022105027099003|261021123027099003|261026121527099003|261026140227099003|261021121427099003|261022075727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	VA7cv4Mmp7cT/9M7KOj6FNaB0JiM1p5IynMmtcgwQctqKxpB3C1kMesL3Ckm++Mq6B2BckvMhec6jGwwZbF98HzXdcqNCFVUUSNY9cq+sciTsBE6oXcPs6D0PK1PrBDZymnGOBm5HxKd6qKgeVBuYv6Xi1FK04pyFju8GaQ0pom9S4LXeJAQy+s7Pa3J3q+RckD9XCexaIKX3cGUfItU4aF7m9eyuYhi1rMF/exa5QPWF4vUSU4cEqspMobfBVzx2/zswwHV+zQ+u74jO7MPBHQY9BeFf2kdPWKhi48rC7gAenKBe4eG+wrUPs6Fe2Wu7MrpnRdX4aFYyOkwCwLrgtj0DKYFgB4ZXhjD1k607FqOaggEhkoUskmxhByXp/gcQHNQwUpjdgFFYlleV9g/jav5eBjtLffLfRAAj4oXH3sGs+W1M9qQ6/mcViN2f7Y+UhtExzp8TkXeYDadSEWy287qsNzmzTLg/I+ba55MjWEj6vs+Wo+zL4Lz8CQJB4p82mNu1obFgyv19cGsj8Ulvb6ZZn85LUL3CUyHEG73ltwHlXFgI9iTZk8FIiHfccam2D77P3o2rxhg4txrkO2YwWPP71Ap9yyhInNjnDex1kQBrS8SBa8G9nvNrhb6YmN9Drjex1XK+hOv/O5hp8hllWjNGtzqQUiVovaVJFdtmabOWXBtc/oZeefWJ7gSOxo2S3J8vvYjwmhd0WcZ+7Oomc/+f68cvadA9ZeIAgdYx2K1H/aIMHgs+k/v2UuOmvcM
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(36860700016)(82310400026)(921020)(11063799006)(261028144727099003)(10067099003)(5023799004)(56012099006)(261022105027099003)(261021123027099003)(261026121527099003)(261026140227099003)(261021121427099003)(261022075727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	40EczBmyee+1jnAZQ+eMJbDYsUU2V0qBxinfJc1pZ1Xg3sUph/Isb4ZqS1J/ZI1VSt969/V0K2BEkGuiG0KuCQq8WUn0uhmJwNPjJbc5hdGGQlJxfEzmmZDmqR+AO5pldlsdkMH1XIVJDMl9b7ykY0B7wwnwaeuhQoi/cWDl8dR3OJqM5Pt74sqPUqMP4pTmxmNvBampJDk4/teF9jKeHLjDMr7KIj3mYWQ+RWM5ndIWJG7TNoE1gTFFjqUQoxaZJ7zM1Qw8DYbhBAZtFSJ5L4T+9YuSstppt+bk8kRq8vfkIZowuRKZIgNVRKdvHKDinj446xy2zw4C6zNMcaCx38r5fXjhnIztzQn7Mcs4noomCtuq5PHnfm5RGlcErgHNcpSzskvJov77rNTUNRFs7CyHVXx8VO+gBrwwv3is2XQnBKxZ47cKdwE9GEtMDmJO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 04:11:32.6397
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ab04a08d-a7a8-4d97-6a15-08df413c337c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	PH2PEPF00048917.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968

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
Changes in v4:
- Use alloc_etherdev_mqs() so the standard eth%d name is registered with
  NET_NAME_ENUM while preserving the TX and RX queue counts.
- Reject xlnx,num-priorities outside the 2..8 range the binding allows.
  A value of 1 used to probe with a single TX queue.

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
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c | 203 +++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index b6458bb0ba0f..9458db38255d 100644
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
+#define TSN_MIN_PRIORITIES		2
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
@@ -69,15 +88,180 @@ static const struct ethtool_ops ep_ethtool_ops = {
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
+	if (num_prio < TSN_MIN_PRIORITIES || num_prio > TSN_MAX_TX_QUEUE)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid xlnx,num-priorities %u\n",
+				     num_prio);
 
-	ndev = alloc_etherdev(sizeof(*ep));
+	if (num_tx_dma_channels != num_prio)
+		return dev_err_probe(dev, -EINVAL,
+				     "TX channel count %u must equal num-priorities %u\n",
+				     num_tx_dma_channels, num_prio);
+
+	ndev = alloc_etherdev_mqs(sizeof(*ep), num_tx_dma_channels,
+				  num_rx_dma_channels);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -89,6 +273,23 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
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
2.43.0

