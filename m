Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4048472798
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143200; cv=fail; b=ZZziK2HOLPkcQj7enDYE3+aH80ONqvVt7cURiLdiEieBZ6+MOeAAnpbiWTYtjw3v3yrRyUYsvbUBTTJLYYfs0fiNO5l4xCDQoWW7Ocs6hL7JpZuI2/XlfA+FbOmsbMIkV6DUpFhaUim+lMVzH+3N3BFMoFJhqniMrwgXeNqlcIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143200; c=relaxed/simple;
	bh=lZpngcIcYtAcpYgHP57sNiupPbyr/3KRHQ7rRL98SNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kzmSX6IlB5AkMkXVm76QIlMQYBSJ0/8hXmC69zFyP9hqzM7uUOg7Uhh9SmiIGFsrbiAo17MZDAlW9kYiguScQs1b62InN1/4eH7YIJ3m6tHX2KXnqSw99/CDsK1o7izs3C9v08ZSsiLncN+3v1r//iejiyZSMkNf9n0pYUKqLYM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MAMxPer9; arc=fail smtp.client-ip=40.107.209.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MAMxPer9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=klj0dXExJdpTf06VOfkq3TmOCdUDOsyE8Y3akGgGcXY15an/6Adh+CwXp+oJcmrTteZQW5Oiij8vBZZSC6SDa1CouG1Rlf4XfVyfWZiR0eyuGmzYLOrVdPJcJpjszpMEsvc87jB7KDOB9YKjS/qpzQ8HjCwRKdYp6bVYOPg0UBbe/Fgo7WvPUrcIu7adq1pB+zOnhum8+N37JwVXjspxKhRkdb+zS7tUgSnLYBLDh2xrUR2HPUJhkC9FPsum/sFtXDGRLproZ4MZA4yNxFkzgGRxrraBv8ekKtxdxJrNreI1E5fDoBJTLIBsoxhmkrTgSrjqolD0cwZ4ZpBTOH8/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GIv9Bxbde2aCvXr0xIMaWIiapSiPA8pKgVf6lwwuP4=;
 b=ZFoh4aL+lzyrnTvV3F/zXfzFX0H2kSIyGk0A/F4I/J5JBOFvWOlG6SOi70K3xG+fiGhtOJeL3id4Zi7MIrDMegh0Jb4OLivyXfd2+GC3t0r1RtrBn0uRzYMJsCWCqnBmO9wMjaqJQrOH7q0AC7EvJ4xnJIf6pBERXdGpdxcQrXPYCKgKb2n1HOikBNmFEu/kaC5dNSFh/AuceoN64ZxBeOZ+af+r2SZ01z/9aCPzuTPu4IxXdyJwQxxyK5PtmTLGrmBjwK4JCr8A7QJv5nVxiWNdiCVbYYXhaBDvKUhMCS35gpUnpm1jyKLTSGPBo+/d07xL1Nwm214L15U2lVv7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GIv9Bxbde2aCvXr0xIMaWIiapSiPA8pKgVf6lwwuP4=;
 b=MAMxPer9iMIn7Pjqa4SypbZHL6NcFS14LAKOqEBpgMP8yp5PuSLIPbAtHoz2+EBKfgtNOHbHdbpbsqa70uI5fRjiWDtYbecrf8p9UbsG9X82o0FEJvSkUXKzDHcjfRo95pMByi1Qc99oIMOdojKrvBusyqMU0BKw/LsbAruZByc=
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by DS7PR12MB6310.namprd12.prod.outlook.com (2603:10b6:8:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 09:33:12 +0000
Received: from IA0PEPF00000039.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::a5) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 09:33:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000039.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:33:12 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:33:05 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:33:05 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 04:32:59 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 16 Oct 2026 15:02:05 +0530
Subject: [PATCH net-next v3 6/8] net: xilinx: tsn: add the endpoint RX data
 path
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261016-patches_v2_external-v3-6-e33d3960ca1e@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF00000039:EE_|DS7PR12MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: fba4d777-7d12-4d77-2505-08df2b687f68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|1800799024|376014|23010399003|36860700016|6133799003|18002099003|3023799007|22082099003|10067099003|261009223027099003|11063799006|921020|56012099006;
X-Microsoft-Antispam-Message-Info:
	6sxIIAateQmnb7mj1xBGu9X1lP6Lzmo1hTliExceDHHPAksncsCv3FDS9Ia3bNuuVSwTTdoUUBdRMs+qC999/RX057vMs/gdT38JUN4lORQQ2rx67Lt3x+MKQCx231B3et6auTNN+xjkiX/jWrvCYE1Rb33Q+r/8q7NseDRLMhd7OqYdf4FWd8ACqcbGmctbYKDJNKVKMJBEMAkFMfNFsK7faDcLMkYCrZqhgQZd2js92QsPKjL9lQhu+EfNFCrmEK/+6NaD6mJDvZu0LYIEvblDMB8APTwRYL6A5EGxcEcBuhcGUdrtmu1ngnzLRWjqWMj1q9RayFwIIyQYhSZNX0jNmV9yuIucahsSuCD4ddf0G/MdYYxMUt8+vPgMrH37qHuWS2UkwW11Z6R39O0QbFjcgofMGM3fBMQOijX4pceIDsX4dx4ZRUKPuB/4C/fwadIw+rT0DsmP9UchIhLeCNIqB8v2iYDti3Ay9QHrqpM9J4s+VQW4ZZymXPcRSt6Wq164omOxPcKdUrfG1K09+9HLqU384F/ipVCcQkmIe50wA+9FMWv1LCLPzSMQtUq66OHfmNjQ22dIE1l1ONbZnzrczikuQoOi1YvPCAtGzx+8b13ycUwpjCO3ovR0m9uA+5W1oyE7lvBFbTuqL8f3PehLo9OpcSbkfgoZfOGsO1bhN8TiA03rFp1kZEch94IxdvkYIYo1nSto30G9IMd06wiW1u8G8SEiidjkRdcujQAs9GRsZsqooC5Zw00IdnTx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(3023799007)(22082099003)(10067099003)(261009223027099003)(11063799006)(921020)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hZ/Sbk/1LV273am8/tfD1tckUxfXzSmx+oPNPaMcn31FryhUuYPlh14SQVhAUsvjCuNWh+oNT/GLiJhd3N6938NrT1OPJwQi+XsWTE5QQZRZHe21WozQ3aPPu5v3Ps9BVXWNuHaz+QIh9bPY5w1F5uKek3Yvw1NIFFXCqd+kYKdSEXcQkexplGL+7v/Xuy1BcwSQ6aB+oWElQnEnfkkyeT3RoIbfKHM8cm5/wq+zZI+1ogem/IzuaJ9Vcv2pUFmHsIw5FHtR1m6ZY3J2gQ6PJcGegc4S5AfTJMhVyFIyuPEw4qopW+BzA6tICC/OZbFJj4Xyc3nItV/70nQgijfpRGIVuIGP8p8/XigKXB0xMsm0Eb7ujdq/flryxNFIv2hAGImq8q0CqlkVSBC5prawzZ9BDSRKdkIZxxq1KEXbDaiNdlAoDaMnfZwpT7001tVE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:33:12.3673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba4d777-7d12-4d77-2505-08df2b687f68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000039.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6310

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
the ring, so ndo_stop() sets a closing flag before teardown and the refill
tests it under the per-channel lock. ep_free_dma_chan() then takes that
lock as a barrier, so any refill already past the closing test finishes
and no later one submits or arms the timer before the channel is
terminated. No descriptor is submitted once teardown has begun, so a single
dmaengine_terminate_sync() is enough to quiesce the channel.

The RX path uses __netif_rx() from the dmaengine completion callback
rather than NAPI. dmaengine owns the RX interrupt and ring and delivers
one descriptor per callback, so there is no poll context to run NAPI or
GRO, and the per-packet counters use the dev->stats atomics.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v3:
- Check the dmaengine_submit() cookie in ep_rx_submit_desc(). Store the skb
  and submit, then advance ring_head only once dma_submit_error() is clear.
  On a submit failure clear the slot, unmap and free the buffer and return
  the error, so a failed descriptor can no longer pin its buffer or be read
  back by a later completion.
- Use scoped_guard() instead of guard() in ep_rx_refill() for the rx_lock,
  per the netdev cleanup.h guidance (guard() is discouraged in functions
  longer than 20 lines).
- Introduce the closing flag here (field, kernel-doc and the
  ndo_open/ndo_stop writes), together with its first reader in the RX
  refill path. It was added in the MCDMA bring-up patch before it had a
  consumer. Add the circ_buf.h and spinlock.h includes here, where
  CIRC_SPACE() and spinlock_t are first used.
- Reword the commit message to describe how the closing flag is published
  and tested, rather than stating that ndo_stop() sets it under the
  per-channel lock.

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
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c | 230 +++++++++++++++++++++++-
 1 file changed, 229 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
index ab3d6d8cb944..0a13e04d4057 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -5,7 +5,9 @@
  * Copyright (C) 2026 Advanced Micro Devices, Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
+#include <linux/circ_buf.h>
 #include <linux/dma/xilinx_dma.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -21,7 +23,9 @@
 #include <linux/platform_device.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/timer.h>
 #include <linux/types.h>
 
 #include "xilinx_tsn.h"
@@ -38,6 +42,19 @@
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
@@ -63,6 +80,8 @@ struct skbuf_dma_descriptor {
  * @ring_head: producer index
  * @ring_tail: consumer index
  * @ring_size: number of slots in @skb_ring
+ * @rx_lock: serialises @ring_head between the RX callback and the refill timer
+ * @rx_refill_timer: retries RX refill after an allocation failure
  * @is_tx: true for TX channels, false for RX
  */
 struct xlnx_tsn_ep_dma_chan {
@@ -73,6 +92,8 @@ struct xlnx_tsn_ep_dma_chan {
 	u32 ring_head;
 	u32 ring_tail;
 	u32 ring_size;
+	spinlock_t rx_lock;	/* serialises @ring_head */
+	struct timer_list rx_refill_timer;
 	bool is_tx;
 };
 
@@ -89,6 +110,7 @@ struct xlnx_tsn_ep_dma_chan {
  * @rx_dma: dmaengine RX channels, held from probe until remove
  * @tx_chans: array of TX channels (size @num_tx_queues)
  * @rx_chans: array of RX channels (size @num_rx_queues)
+ * @closing: set in ndo_stop so the RX completion callback stops re-arming
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
@@ -104,6 +126,7 @@ struct xlnx_tsn_ep {
 	struct xlnx_tsn_ep_dma_chan **tx_chans;
 	struct xlnx_tsn_ep_dma_chan **rx_chans;
 
+	bool closing;
 };
 
 static inline struct skbuf_dma_descriptor *
@@ -112,6 +135,181 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)
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
+	dma_cookie_t cookie;
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
+	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
+	skbuf_dma->desc = dma_rx_desc;
+	dma_rx_desc->callback_param = xchan;
+	dma_rx_desc->callback_result = ep_dma_rx_cb;
+
+	skbuf_dma->skb = skb;
+	cookie = dmaengine_submit(dma_rx_desc);
+	if (dma_submit_error(cookie)) {
+		skbuf_dma->skb = NULL;
+		goto err_unmap_skb;
+	}
+	xchan->ring_head++;
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
+	scoped_guard(spinlock_bh, &xchan->rx_lock) {
+		if (READ_ONCE(xchan->ep->closing))
+			return false;
+
+		avail = CIRC_SPACE(xchan->ring_head, READ_ONCE(xchan->ring_tail),
+				   xchan->ring_size);
+		for (i = 0; i < avail; i++) {
+			if (ep_rx_submit_desc(xchan))
+				break;
+		}
+		dma_async_issue_pending(xchan->chan);
+
+		if (xchan->ring_head != READ_ONCE(xchan->ring_tail))
+			return true;
+
+		if (arm_timer)
+			mod_timer(&xchan->rx_refill_timer,
+				  jiffies + EP_RX_REFILL_RETRY);
+	}
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
@@ -127,6 +325,8 @@ static int ep_open(struct net_device *ndev)
 	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
 	int ret;
 
+	WRITE_ONCE(ep->closing, false);
+
 	ret = ep_init_dmaengine(ep);
 	if (ret) {
 		netdev_err(ndev, "failed to initialize DMA engine\n");
@@ -144,6 +344,7 @@ static int ep_stop(struct net_device *ndev)
 	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
 
 	netif_tx_disable(ndev);
+	WRITE_ONCE(ep->closing, true);
 	ep_exit_dmaengine(ep);
 
 	return 0;
@@ -200,6 +401,10 @@ ep_alloc_dma_chan(struct xlnx_tsn_ep *ep, struct dma_chan *dma_chan,
 	chan->ep = ep;
 	chan->ring_size = ring_size;
 	chan->dma_dev = dmaengine_get_dma_device(chan->chan);
+	if (!is_tx) {
+		spin_lock_init(&chan->rx_lock);
+		timer_setup(&chan->rx_refill_timer, ep_rx_refill_timer, 0);
+	}
 
 	return chan;
 }
@@ -211,8 +416,21 @@ static void ep_free_dma_chan(struct xlnx_tsn_ep_dma_chan *chan)
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
@@ -305,9 +523,19 @@ static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
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
2.44.4

