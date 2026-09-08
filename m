Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013052.outbound.protection.outlook.com [40.107.201.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3225A0AD5
	for <linux-rt-devel@lists.linux.dev>; Tue,  8 Sep 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895261; cv=fail; b=uBc7kBJCadQkZ2sr3PoUIeUfRSrtmkmCGnQzWZGeOpcMlDm7LVXPIC2S3bmuFmkmftmI6j7QMdc7KNytyvuDBaOSdiHMvKK9pK3ivlyowOAjndVfshqUs8I5xQq7HyiIlwdRCi0TGDaUjmFtFocDvfBMK5xPaDHv4JVvgkCAQ7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895261; c=relaxed/simple;
	bh=d0r9stBMQImfokNbQnOQuq9rkUffMJdGPuiSKHp0z7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XjkLUuXwzNwLo9XG8CGJkMnK27/j8ygLSEmBnO5mDvuMceg0z9aXfOBs3M8wQ+r4cIlNJBdDvDFYHaAmFVddFNGGdbukHB2HaF93TCSAcW12Txqc8/QoCKJuKCKAWfwUtevc1ZXOn1bLWh3wk5Uftz1vfBmDgDZf711G7YHqS1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rF2QjRvr; arc=fail smtp.client-ip=40.107.201.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rF2QjRvr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHuV44yqFypQMN9l4UVlb9EhNzwd3SzAwNfWEeZnONGb3nrEhBg94SDuXrAMkj/domzTyfOWPWdrygZDQNWKoznrDNPhhX38FpymksQjigwrdEF+i2178wukszqi02X/cqTZ1atIblFEW1UvQIRr2nN8mSlelG8D0V9KBir0ybhekv8puJVNEyQ2JpjqVNkGpj5l4YgQ79ThIDMEFSRnnhL+j2bflIRgkrZ0ir0gqNyeFX9TLzBMqBNsd7G18M91Z9bvXuNCvMikrrJ8pW65uhxsLVrP6LXX8FWIkW7iDSVsjVYUzMDBd0EuHOBgYRObB2ywbmPzv4GHg0L+fG40wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+RCwtmufnkDttMm+0TQw4ZlhWBlLporL76du00bJdE=;
 b=mO4pCIQsPc/9nS7vNQgfDgQYfEVZWLIoAdM0S36zItvNKlZSS6kKLjLXhs4+1LEls58is4S23SgkW07jyDKMvkolfwv0aylyXtvCNVjQAp3WReSZzTIeVn91+NZtMDphK1qbFJ/GESMc4LtnOdZPsFuHw3Km1c3mY9CqlEA77ClFLFaPJl9GJEi2JsetrWsEpb02XEwOBTHq7dpoyXeeCO7AvcHn/BdF/W8b81Ha+ew9EVPOdShMc/hdX+SzpjJ2w/S9CG8TJtJNjGIu1UZOE4Ugr6L1s5FFYwl/cDTfwxNj08GSzNTh8DLv6evvnoZJUUgstdlkAwsJS5lY0dHHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X+RCwtmufnkDttMm+0TQw4ZlhWBlLporL76du00bJdE=;
 b=rF2QjRvrhz3+GA6zMQMWEDWAuVQSStH99GHWNoqE1uPD6cnD8XMfKMIx8PK5/xTZFUx/C5ntoE1afTrK0sYGS02O3FcWpY7S5YLNHE8RQMZ/rkvI/8ggdqPHBlqznNUyTxWqGlLdgPRc2kkrY6+4M3d57bdPU6Dmn/FCZtY9QFI=
Received: from SN7PR04CA0077.namprd04.prod.outlook.com (2603:10b6:806:121::22)
 by IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 19:20:47 +0000
Received: from SN1PEPF00036F3E.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::a4) by SN7PR04CA0077.outlook.office365.com
 (2603:10b6:806:121::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 19:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F3E.mail.protection.outlook.com (10.167.248.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:20:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:41 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 14:20:36 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Wed, 9 Sep 2026 00:49:54 +0530
Subject: [PATCH net-next v2 6/8] net: xilinx: tsn: add the endpoint RX data
 path
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-patches_v2_external-v2-6-3a40babaff4c@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3E:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7ceb77-a6c0-41bd-bdcb-08df0dde48f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|23010399003|36860700016|921020|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	MgzPT6OFVYdIlYSyEYC2wDqTsNK8ylnnp0MbL8DVesWTdAbyi6qo2T76ADfo1ZWbVEHcF8Pq+kiOEGkKxF+Z7KHxjSRj3nwKvwYTtd89+wkgDa1J40P6LgDQWxSPp9l8R5ROZSNzE6MSQW0331+vPaRf89Y3IC4fDVz2kof8fcMmxHz2kQwxzcQLzRTqhA1jY2IzBcTQTBGg6EOJeGps0/q9mVbvt9lh71bjWgxNtZvUPtuC4S7H8wZYK+G/zJDoml09R7kWUmUau6C6FbmV/m78YaM/vAU7faFtu2Y0AuXaqeN3qcm7zgvvgaaQfq1noKDqkTNcbbEzgscMkHXxuv5/kYRFU7bXXB0Q8fZaX+s96FD6Mv9yy5F0T9G9U4X2zsZTy98gGlzb4pQbZ9feGtgZw8soNEe3Qybm/+PAmiGzDzwf4u1ImTlUBalUqOmt0O2dXSIUFTgmVmPGFYOuyQ1b7WryEn2POklXL0GdeacnLpLOCZ+XuXPGeh3t8XNrNHk7++fPtehPegMn4XlmqdA56YUNSbvFZmIIpcDIGur7tQ47Ckg9k6URfyXwBzoAGgCtd7nbkIht4RZSo922CZBW75NzUkKvOuAHT4m6gAAxdHs258hfO3GUZ5f6+ibWhWghRvEMqVSQevzmZsaIVyeRDTM/B4Fi8SErTiCVDXaAXgXrAUKlf0z0oWKjasThMCme1bmRRmPQG8QlFqIYZ2Iv53dCMpC40qpEYBhSlCLm1NGdwRmY6u+I1RW9EKdX
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(23010399003)(36860700016)(921020)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KXguW69PDTsBEtZ0YgWWK5Gx5Gy1GN1NIG2HxCsXXpq65GlyF+yaI+CcA37EB6DbnmuCxGq7d+dWN1bWfp64J8lu+Rg2VoOkErjfc/oSTeNVFytvsu41OCmsAnmf2a7KPSGMwxqEbcxs6pg665ANMB3L+vXpLfOIEWobDtgeZo3TMltGI5amYzfyhgBzOBWG7k/igfN4dk+sbLwCcUnxmWpwkLxP218oFI94vAeMdUjQ6M+QKx3sdl5VHRY8z+El4CwAZdUzvyeMfDvtKAhzJEQYaC3o5dByn3kcmxXZzWbmAYnGa2JH/Eow5FClofch6218z3cp9TLAhI1W1u6DGCXgcV+oIRZdk/DN9iivll6z98mdJq8mA7NAK6NmGXs+9UJjgFPYIlZ4MWzxc4ttpxlrS98CfltxLJbm/3WwyDNhq1ce30ksN5w15RNZxsJZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:20:46.7399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7ceb77-a6c0-41bd-bdcb-08df0dde48f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422

With the RX channels armed, the endpoint can start receiving frames.

Post RX buffers to every RX channel on open and reap them from the
completion callback. Each inbound frame carries a TUSER port_id in the
descriptor sideband. Accept frames from MAC1 (port_id 1) and MAC2
(port_id 2) and pass them up the stack. Drop any other port_id, since
the bridged-only model never produces it. Drop and count frames with
bad descriptor status, an invalid length or no metadata pointer.

Refill each slot from the completion callback unless the interface is
closing, which keeps the ring full without a separate refill worker.

Serialise the RX refill against teardown. The completion callback re-arms
the ring, so ndo_stop() sets a closing flag under the same per-channel
lock the refill takes, and ep_free_dma_chan() takes that lock as a barrier
before it terminates the channel. No descriptor is submitted once teardown
has begun, so a single dmaengine_terminate_sync() is enough to quiesce the
channel.

The RX path uses __netif_rx() from the dmaengine completion callback
rather than NAPI. dmaengine owns the RX interrupt and ring and delivers
one descriptor per callback, so there is no poll context to run NAPI or
GRO, and the per-packet counters use the dev->stats atomics.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v2:
- Serialise the RX refill against teardown under a per-channel rx_lock. The
  completion callback re-arms the ring, so ndo_stop() sets a closing flag under
  the same lock and ep_free_dma_chan() takes it as a barrier before terminating.
- Recover a drained ring with a refill timer instead of leaving RX dead after
  an allocation failure.
- Fail ndo_open if a channel cannot arm any RX descriptor.
- Set the closing flag on the ndo_open error path too, before tearing the
  channels down.
- Take the ring size from the channel instead of a compile-time constant.
- Note in the commit message why RX is not NAPI based. dmaengine owns the RX
  interrupt and ring and delivers one descriptor per callback, so there is no
  poll context for NAPI or GRO, and the counters use the dev->stats atomics.
- Shut the refill timer down with timer_shutdown_sync() at teardown rather than
  relying on timer_delete_sync() plus the closing flag.
- Return true from ep_rx_refill() when at least one descriptor is armed, false
  otherwise, following the usual bool convention.
- Init the refill timer and rx_lock only for RX channels.
---
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c | 216 +++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index 23a15df71baa..9ed1170794e0 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2026 Advanced Micro Devices, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/circ_buf.h>
 #include <linux/dma/xilinx_dma.h>
@@ -25,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/timer.h>
 #include <linux/types.h>
 
 #include "xilinx_tsn.h"
@@ -41,6 +43,19 @@
 #define TX_BD_NUM_DEFAULT		64
 #define RX_BD_NUM_DEFAULT		128
 
+#define EP_RX_REFILL_RETRY		msecs_to_jiffies(10)
+
+/*
+ * The DMA descriptor sideband status word packs TID/TDEST/TUSER together;
+ * TUSER occupies the low byte, TID/TDEST sit in the upper bits.
+ */
+#define TSN_TUSER_MASK			GENMASK(7, 0)
+/* TUSER Input Port ID field (bits [5:4] of the TUSER field) */
+#define TSN_TUSER_PORT_ID_MASK		GENMASK(5, 4)
+#define TSN_TUSER_PORT_EP		0x0
+#define TSN_TUSER_PORT_MAC1		0x1
+#define TSN_TUSER_PORT_MAC2		0x2
+
 /**
  * struct skbuf_dma_descriptor - skb container for each in-flight DMA descriptor
  * @sgl: scatter-gather list backing the DMA mapping
@@ -66,6 +81,8 @@ struct skbuf_dma_descriptor {
  * @ring_head: producer index
  * @ring_tail: consumer index
  * @ring_size: number of slots in @skb_ring
+ * @rx_lock: serialises @ring_head between the RX callback and the refill timer
+ * @rx_refill_timer: retries RX refill after an allocation failure
  * @is_tx: true for TX channels, false for RX
  */
 struct xlnx_tsn_ep_dma_chan {
@@ -76,6 +93,8 @@ struct xlnx_tsn_ep_dma_chan {
 	u32 ring_head;
 	u32 ring_tail;
 	u32 ring_size;
+	spinlock_t rx_lock;	/* serialises @ring_head */
+	struct timer_list rx_refill_timer;
 	bool is_tx;
 };
 
@@ -113,6 +132,174 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)
 	return xchan->skb_ring[idx];
 }
 
+static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result);
+
+static int ep_rx_submit_desc(struct xlnx_tsn_ep_dma_chan *xchan)
+{
+	struct dma_async_tx_descriptor *dma_rx_desc;
+	struct skbuf_dma_descriptor *skbuf_dma;
+	struct xlnx_tsn_ep *ep = xchan->ep;
+	struct sk_buff *skb;
+	dma_addr_t addr;
+
+	skbuf_dma = ep_get_desc(xchan, xchan->ring_head & (xchan->ring_size - 1));
+	if (!skbuf_dma)
+		return -ENOSPC;
+
+	skb = dev_alloc_skb(ep->max_frm_size);
+	if (!skb)
+		return -ENOMEM;
+
+	sg_init_table(skbuf_dma->sgl, 1);
+	addr = dma_map_single(xchan->dma_dev, skb->data, ep->max_frm_size,
+			      DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(xchan->dma_dev, addr))) {
+		if (net_ratelimit())
+			dev_warn(ep->dev, "DMA mapping error on RX submit\n");
+
+		goto err_free_skb;
+	}
+	sg_dma_address(skbuf_dma->sgl) = addr;
+	sg_dma_len(skbuf_dma->sgl) = ep->max_frm_size;
+	dma_rx_desc = dmaengine_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
+					      1, DMA_DEV_TO_MEM,
+					      DMA_PREP_INTERRUPT);
+	if (!dma_rx_desc)
+		goto err_unmap_skb;
+
+	skbuf_dma->skb = skb;
+	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
+	skbuf_dma->desc = dma_rx_desc;
+	dma_rx_desc->callback_param = xchan;
+	dma_rx_desc->callback_result = ep_dma_rx_cb;
+	xchan->ring_head++;
+	dmaengine_submit(dma_rx_desc);
+
+	return 0;
+
+err_unmap_skb:
+	dma_unmap_single(xchan->dma_dev, addr, ep->max_frm_size, DMA_FROM_DEVICE);
+err_free_skb:
+	dev_kfree_skb(skb);
+	return -ENOMEM;
+}
+
+static bool ep_rx_refill(struct xlnx_tsn_ep_dma_chan *xchan, bool arm_timer)
+{
+	int avail, i;
+
+	guard(spinlock_bh)(&xchan->rx_lock);
+
+	if (READ_ONCE(xchan->ep->closing))
+		return false;
+
+	avail = CIRC_SPACE(xchan->ring_head, READ_ONCE(xchan->ring_tail),
+			   xchan->ring_size);
+	for (i = 0; i < avail; i++) {
+		if (ep_rx_submit_desc(xchan))
+			break;
+	}
+	dma_async_issue_pending(xchan->chan);
+
+	if (xchan->ring_head != READ_ONCE(xchan->ring_tail))
+		return true;
+
+	if (arm_timer)
+		mod_timer(&xchan->rx_refill_timer, jiffies + EP_RX_REFILL_RETRY);
+
+	return false;
+}
+
+static void ep_rx_refill_timer(struct timer_list *t)
+{
+	struct xlnx_tsn_ep_dma_chan *xchan = timer_container_of(xchan, t,
+							       rx_refill_timer);
+
+	ep_rx_refill(xchan, true);
+}
+
+static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct xlnx_tsn_ep_dma_chan *xchan = data;
+	struct skbuf_dma_descriptor *skbuf_dma;
+	size_t meta_len, meta_max_len, rx_len;
+	struct xlnx_tsn_ep *ep = xchan->ep;
+	struct net_device *ndev = ep->ndev;
+	struct sk_buff *skb;
+	u32 port_id, tuser;
+	u32 *metadata;
+
+	skbuf_dma = ep_get_desc(xchan, xchan->ring_tail & (xchan->ring_size - 1));
+	WRITE_ONCE(xchan->ring_tail, xchan->ring_tail + 1);
+	skb = skbuf_dma->skb;
+	skbuf_dma->skb = NULL;
+
+	dma_unmap_single(xchan->dma_dev, skbuf_dma->dma_address,
+			 ep->max_frm_size, DMA_FROM_DEVICE);
+
+	if (result->result != DMA_TRANS_NOERROR) {
+		if (net_ratelimit())
+			dev_warn(ep->dev, "RX DMA transfer error %d\n",
+				 result->result);
+
+		dev_kfree_skb_any(skb);
+		DEV_STATS_INC(ndev, rx_dropped);
+		DEV_STATS_INC(ndev, rx_errors);
+		goto submit_new;
+	}
+
+	metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc,
+						   &meta_len,
+						   &meta_max_len);
+	if (IS_ERR_OR_NULL(metadata)) {
+		if (net_ratelimit())
+			dev_warn(ep->dev, "Failed to get RX metadata pointer\n");
+
+		dev_kfree_skb_any(skb);
+		DEV_STATS_INC(ndev, rx_dropped);
+		DEV_STATS_INC(ndev, rx_errors);
+		goto submit_new;
+	}
+
+	/* MCDMA metadata: [0] = status, [1] = sideband (TID/TDEST/TUSER), [2..] = app */
+	tuser = metadata[1] & TSN_TUSER_MASK;
+	rx_len = ep->max_frm_size - result->residue;
+
+	if (rx_len > ep->max_frm_size || rx_len < ETH_HLEN) {
+		if (net_ratelimit())
+			dev_warn(ep->dev, "Invalid RX length %zu (max=%u, min=%u)\n",
+				 rx_len, ep->max_frm_size, ETH_HLEN);
+
+		dev_kfree_skb_any(skb);
+		DEV_STATS_INC(ndev, rx_dropped);
+		DEV_STATS_INC(ndev, rx_errors);
+		goto submit_new;
+	}
+
+	port_id = FIELD_GET(TSN_TUSER_PORT_ID_MASK, tuser);
+	if (port_id != TSN_TUSER_PORT_MAC1 && port_id != TSN_TUSER_PORT_MAC2) {
+		if (net_ratelimit())
+			dev_dbg(ep->dev, "RX dropping unexpected TUSER port_id=%u\n",
+				port_id);
+
+		dev_kfree_skb_any(skb);
+		DEV_STATS_INC(ndev, rx_dropped);
+		goto submit_new;
+	}
+
+	skb_put(skb, rx_len);
+	skb->dev = ndev;
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb->ip_summed = CHECKSUM_NONE;
+	__netif_rx(skb);
+
+	DEV_STATS_INC(ndev, rx_packets);
+	DEV_STATS_ADD(ndev, rx_bytes, rx_len);
+
+submit_new:
+	ep_rx_refill(xchan, true);
+}
+
 static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 {
 	dev_kfree_skb_any(skb);
@@ -211,6 +398,10 @@ ep_alloc_dma_chan(struct xlnx_tsn_ep *ep, const char *name, bool is_tx,
 	chan->ep = ep;
 	chan->ring_size = ring_size;
 	chan->dma_dev = dmaengine_get_dma_device(chan->chan);
+	if (!is_tx) {
+		spin_lock_init(&chan->rx_lock);
+		timer_setup(&chan->rx_refill_timer, ep_rx_refill_timer, 0);
+	}
 
 	return chan;
 }
@@ -222,8 +413,21 @@ static void ep_free_dma_chan(struct xlnx_tsn_ep_dma_chan *chan)
 	if (!chan)
 		return;
 
-	if (chan->chan)
+	if (chan->chan) {
+		if (!chan->is_tx) {
+			/* ep_stop() sets closing before teardown. Take rx_lock
+			 * so any refill that already passed the closing check
+			 * finishes and no later one submits or arms the timer,
+			 * then shut down the timer so it cannot be rearmed
+			 * before the channel is freed.
+			 */
+			spin_lock_bh(&chan->rx_lock);
+			spin_unlock_bh(&chan->rx_lock);
+			timer_shutdown_sync(&chan->rx_refill_timer);
+		}
+
 		dmaengine_terminate_sync(chan->chan);
+	}
 
 	if (chan->is_tx) {
 		while (chan->ring_tail != chan->ring_head) {
@@ -322,9 +526,19 @@ static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
 		rx_allocated++;
 	}
 
+	for (i = 0; i < ep->num_rx_queues; i++) {
+		if (!ep_rx_refill(ep->rx_chans[i], false)) {
+			dev_err(ep->dev, "RX channel %d: no descriptors armed\n",
+				i);
+			ret = -ENOMEM;
+			goto err_free_chans;
+		}
+	}
+
 	return 0;
 
 err_free_chans:
+	WRITE_ONCE(ep->closing, true);
 	while (--rx_allocated >= 0)
 		ep_free_dma_chan(ep->rx_chans[rx_allocated]);
 	while (--tx_allocated >= 0)

-- 
2.43.0

