Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794536839;
	b=eeWNzTilQbltn6zkKoj7Q7ZnpJUTDFj5KU2bn9fdw3Lz5CKz14LH8jesCimaMbawbnjN
	 CZFd61TPwXcuQeQQGVMjhAudwUKW50CT9Wq1sPUr/ppfFAEFG4+4EHHAAetYkVpyYQ9mN
	 3anIhvnQn+B/orlrjABe6L4wXYZ91RMrONnzxinoXL9HpzzSaPxX9kNO/dzbwWHZWU9nS
	 fbjfaIXHPliiMVDjr7xDY1eUl1+3zl1rwbBun4bzv1FyNXSFlYp1OnOS99iJLg+mLrulS
	 jYUl7d74HXcDVE1pNDi30GNvSjG0kKTxXMgvgXdsx9gLqbDlXIb9o7ITTyBhLlQjPNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536839;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
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
	bh=TxIZqIr06ayrrgVSLTDd54qmlbTTsdeODV+TWW/mI/A=;
	b=TtpERed6VMs2aKnenofW0M7ojfpbte0cl6uqmAnDJqPJLLKA/q2ib9LrCTwPyo+oC4BY
	 mvsiL97ggFvQlb7cxQPKozCupabiFMX9QVEgANCxiM4uydH5aiJtD6P7bjMElQHyyTARl
	 sMLmIQ4GNIZ9Bv6T1uySUD3sSgeS3/YjIRaD4cCdHNWbBPIjF3yo/oTvgYthxLNYdXxF3
	 SLF0B/zxiBKvubLPWbiFoSCxLy3xv1A6qg4fWg4KpnmgVj8U/GFfFO+wApLsWpvSTmSVm
	 1KTUH2c9kqB5PT5smJfTbRTMcQ3MOXayac6zO3M+oHKoYi+5vPo950QReP8lJT5+Jww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CrUWtMtV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.8
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648A2606A321
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 02:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 648A2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CrUWtMtV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DBapDl2dlOel+v3GW5Lz+59xFCUjNemk1AQhp2RORhscKNcyr54EUkprDL12m87g6C5DGfgB93IBMM7U7TWkxlpUIcMaKrIcP7igZ3ijMZu7CCqRK9BjTqbSc7Sax1e3DQ1neD79KmVcDqV+ezAlq8kh0NTUULqqdkvhRGLA9vMHfYJdAtj5IpByp2J4IStp7amLaIbJn4KS2T2pi0+QlJUWKBHZ5W/m0J2NbA7cTQ7cQ2khABjcdVFNMpz12OQbfFfQ0SGLqzoy196AH9Zv1ctm4405Z/ZC47+SbViok2S8TXtxMRecIhI9R8V7XQ68i3kBZTl37nxbByVml7vWqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxIZqIr06ayrrgVSLTDd54qmlbTTsdeODV+TWW/mI/A=;
 b=EaQA3QX69+QpebJc61cVAaiNHkMMNhpOcT3rJ1TtSe7X7BC30PYLwBKf1gSupRrrK48J6NJNkUoN1pqWhdM1mARVkJLS11oGWBU+d09obJpMmE52haYNHgKYfQJC+CWjG+24CObAiKgirxfUXW2Ebgv+adOxtHy0gVvXHoj9c7wn+xzOGX1LO/CdaL61bLUaBB3L2lu8y2SotJpHLbd/zrWpg5Gov+XOI7q7+w3xMiuW1PZazJqdW0qh4UMdL8mHvnTwl9dwpsX94T2w9WOK5mLw86+PVIkDG+m8xfey66xOOiVXg9CFZOR46fEIpeApsxTCpQzDie37NgSbbG6OkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxIZqIr06ayrrgVSLTDd54qmlbTTsdeODV+TWW/mI/A=;
 b=CrUWtMtV1qUxS/tup3xmzvNO8sQE5rQIVcaYetomKRNiKudFSrKy2e/kXx4ZrBLTkgjQ+whqkPjYMOhInQ1QTmbpPQ6Sjxw5NIGOiYKLh99Izr1FzkzJpIiIZlT7LwPLhoPqlucaAEhp/pGnZ70yZ7yMDeE/J6IsNGXW/rBbDjM=
Received: from SJ0PR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:33f::31)
 by LY0PR12MB390394.namprd12.prod.outlook.com (2603:10b6:408:3b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 02:26:29 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:a03:33f::4) by SJ0PR05CA0056.outlook.office365.com
 (2603:10b6:a03:33f::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 02:26:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 02:26:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:45 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:44 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 12:47:38 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 13 Nov 2026 00:16:50 +0530
Subject: [PATCH net-next v4 6/8] net: xilinx: tsn: add the endpoint RX data
 path
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
Message-ID: <20261113-patches_v2_external-v4-6-56bb26f042a4@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|LY0PR12MB390394:EE_
X-MS-Office365-Filtering-Correlation-Id: 680461ee-3da2-4da6-bf44-08df412d8141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|23010399003|18002099003|22082099003|6133799003|261009223027099003|3023799007|921020|11063799006|56012099006|10067099003|261102123227099003|261022105027099003|261026121527099003|261022113327099003|261022075727099003|261028144727099003|261021121427099003|261026140227099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	ADBnho2tso/V5KfZFnYmCsyTjXvEZh6savfdh+yDfLAjCgAnL6gpbuQHGz5DLab8urssACFKt3vRISV2ewYK60SLbZc8Eo9n4h0fxClbfCf9Y5SYNB0W2YMrGb363BV5OB1DIDJ9oSye0/DCL89GAlbSfnbjcMuxP5QSEtCa2C3lc7dRvRpZlwV/+o+kuyFBPEiJPMIa2zhCSz8bt3fdUt6AIAp+fdVfT9+99kVRzvGIQ8S5oAZPjortHYuaqGdM1eGLCCW4rkyH0L4fbvAHP1C8Crl6N2Raw54Jh29DWtQEQIgcxe9PS1gZ7+p/qC8N/HM2jNucZPcckGcHkLBnhi2IKb5fOZXyd1rncUJQnS8Eti1AE6g4cG/es8um8xQQ/Nder7hVueylU/6B7wIdek9L/pL+oIhxOvdmZtdbBaQyq53PVIj8mKC5Vq9ByPPcRCFEGrOB3ibSoeAljSvfyhHCVzT+YQo0ZmbvWyXAdzfffIm4jbznl8ex52YNsKEJbrryRLTEfujJoC+WTzS+/ZAGKztw9KHdOczTDbbHwX8+wcblm75onTICqo6REbfhxXlsOq6zFiPqmRJUCZo4zKhebB3Z4EO91c6qkQCobqeCeBnz1G6YFFBHk8syqzEoOTHN4RmHztofUsYxpIbiCqu9RgZyTn2l/9H8HWQcxRL8MaN2qR1KQLURmzNG9Tx4P5xkQTN4mUejDW1NzM/btmwI/xpflbgKIzc77UO2zSLiW2Dt1TZpdomFqAadqZtf
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(921020)(11063799006)(56012099006)(10067099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022113327099003)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jLCH4Ccw/BwWm5d/2f7EYFsk5h6bagRKmOyyU6sfBul/8CQDTBLJTyqUgrYgQ+Ir+woaTjTWXV+bIO8RTYPmw9uZrhJjxypQ2hUuP77VpRFJdc3owa8Ipgmlq27uN/JgPvkEiKkk4cRMEOScGlGW6zayN5tdV/QidvozuvqViYlsOLJNklnbEwtYoUS6f6CgXrmMYNIfBpfkMETc0sl+EB+zwDPpv3oIWvhfYrUmvmnTNIgLyiSB5yvqSfaUD9pPBdkXwXT6BmBN06/E+0uwRYF8ZI/J8o35pLTuvxynMVTFuKEYXL//BBuJXLK+Hw3iN4drUT2z4yu4mi7IvHJtc9ikPyUDY8aZZB5mPxsXgmDbpvFjwj+2/lFVl8UM7lchpBxKFyD9JPitHE0KCK0Ty8jSSqlRvOyWCyRzfmUEt4c8H4XQ0pXWBAGb/TUA2cmx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 02:26:20.7187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 680461ee-3da2-4da6-bf44-08df412d8141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB390394

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
Changes in v4:
- Return true from ep_rx_refill() when this call submitted at least one
  descriptor. The completion callback advances ring_tail without rx_lock,
  so a descriptor could complete before the ring_head != ring_tail test
  and make ndo_open() fail with -ENOMEM.
- Use dev_dbg_ratelimited() for the unexpected port_id message, so it does
  not consume the shared net_ratelimit() budget, and replace the redundant
  CHECKSUM_NONE store with skb_checksum_none_assert().

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
index 52d2da04a5d8..f179062c7d14 100644
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
@@ -39,6 +43,19 @@
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
@@ -64,6 +81,8 @@ struct skbuf_dma_descriptor {
  * @ring_head: producer index
  * @ring_tail: consumer index
  * @ring_size: number of slots in @skb_ring
+ * @rx_lock: serialises @ring_head between the RX callback and the refill timer
+ * @rx_refill_timer: retries RX refill after an allocation failure
  * @is_tx: true for TX channels, false for RX
  */
 struct xlnx_tsn_ep_dma_chan {
@@ -74,6 +93,8 @@ struct xlnx_tsn_ep_dma_chan {
 	u32 ring_head;
 	u32 ring_tail;
 	u32 ring_size;
+	spinlock_t rx_lock;	/* serialises @ring_head */
+	struct timer_list rx_refill_timer;
 	bool is_tx;
 };
 
@@ -90,6 +111,7 @@ struct xlnx_tsn_ep_dma_chan {
  * @rx_dma: dmaengine RX channels, held from probe until remove
  * @tx_chans: array of TX channels (size @num_tx_queues)
  * @rx_chans: array of RX channels (size @num_rx_queues)
+ * @closing: set in ndo_stop so the RX completion callback stops re-arming
  */
 struct xlnx_tsn_ep {
 	struct net_device *ndev;
@@ -105,6 +127,7 @@ struct xlnx_tsn_ep {
 	struct xlnx_tsn_ep_dma_chan **tx_chans;
 	struct xlnx_tsn_ep_dma_chan **rx_chans;
 
+	bool closing;
 };
 
 static inline struct skbuf_dma_descriptor *
@@ -113,6 +136,181 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)
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
+		if (i > 0 || xchan->ring_head != READ_ONCE(xchan->ring_tail))
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
+		dev_dbg_ratelimited(ep->dev,
+				    "RX dropping unexpected TUSER port_id=%u\n",
+				    port_id);
+
+		dev_kfree_skb_any(skb);
+		DEV_STATS_INC(ndev, rx_dropped);
+		goto submit_new;
+	}
+
+	skb_put(skb, rx_len);
+	skb->dev = ndev;
+	skb->protocol = eth_type_trans(skb, ndev);
+	skb_checksum_none_assert(skb);
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
@@ -128,6 +326,8 @@ static int ep_open(struct net_device *ndev)
 	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
 	int ret;
 
+	WRITE_ONCE(ep->closing, false);
+
 	ret = ep_init_dmaengine(ep);
 	if (ret) {
 		netdev_err(ndev, "failed to initialize DMA engine\n");
@@ -145,6 +345,7 @@ static int ep_stop(struct net_device *ndev)
 	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
 
 	netif_tx_disable(ndev);
+	WRITE_ONCE(ep->closing, true);
 	ep_exit_dmaengine(ep);
 
 	return 0;
@@ -201,6 +402,10 @@ ep_alloc_dma_chan(struct xlnx_tsn_ep *ep, struct dma_chan *dma_chan,
 	chan->ep = ep;
 	chan->ring_size = ring_size;
 	chan->dma_dev = dmaengine_get_dma_device(chan->chan);
+	if (!is_tx) {
+		spin_lock_init(&chan->rx_lock);
+		timer_setup(&chan->rx_refill_timer, ep_rx_refill_timer, 0);
+	}
 
 	return chan;
 }
@@ -212,8 +417,21 @@ static void ep_free_dma_chan(struct xlnx_tsn_ep_dma_chan *chan)
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
@@ -306,9 +524,19 @@ static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
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

