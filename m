Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794513203;
	b=a+pvoBz5WkVEu6HiCvCwkrppZ2hFmBqJphWBMoHuG45w3bc8ZJiPGt5S38pkWmw6GTuB
	 ZX7UnArUewee79D4p/rqsTVY+VPbeWVhnbOqIUQIbDdcqEKWz3BYy7VhMRN7dEKwHyXuD
	 DP8hMGPrJNDazXg3uPPUK6pDKjqdBP5+akvC/KTUJvmJJuKMK0f+ehXeogbajCRGKKDVj
	 KxnVbA5vlPkq+A58b8gTo5UQkYYFbIvDg5DWVary78IUv9hBI+5kC+tPimWZoGVKlnn9w
	 SC+/tuABRV5jNGRBZuk5FPRfwFLwUJauH4idq43+pH4UR1u+0Hn3Y6/npKJLZxO2LLQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513203;
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
	bh=GNKAZUVbORdQSI45Uga8oImsAkhNEQ9gkzJfJOThZjg=;
	b=uxY/z0G5xZTBpSmG9Pwor5+zedOyA+VbOhDx1LwHPWkWGtZ5nQEzpYDcpEPVfeTaOLXK
	 LcDdopWXV3DfS+t6r5BKae8u+nte+JGhZHE+2vHr3iatJhDkLEuV6nQLAA9pjdwHmEAN3
	 zstcYzPL8rLksAySRZpxrYq7hVNNaYnKIY8wTCciWzgn6vPmTQ1DDqWAjcrq9crs7QHdE
	 NXt+QHx9Q1pP7A/sKruovenXpchq34hjTtseiiCn4bdnMLn6tzFdG3kTKRaKqq8DSLgDB
	 9F0OV5drufleKWqmVOkr33+/fvJkGG6SeWyrdrdIaTXpPwdj+el7/k3vhKRjkB8L/Pw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zjnWBDWt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.49
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE1760A2613
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 19:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DE1760A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zjnWBDWt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k/Luasb2L+7L89is26Z+ZGWjPo14KO6/MmWiLmu6X02n2qTzeEKGiHtOZytbwv8PkyHu3+g+deFPr00KGz1EwYTVN47Lw8J8R53J/GPKj4CJ00g9BCHUbyPwAnsKY9VG03v8/AsEyoSvqnWxenha2VhNQZRQ3ujeI6ltnCM3MxIo2zp/Q88lT73FmaKTLUa1PvRrb8BPl9bdIf9sSky4QwnPGvXszAjudv2en21FEP5UgGbEuTUJsopmRNUdD/B2IJBQNlKEx2yu3xCmqQLfumQu/WzwfxyYLHJmPJip2Ll10vU8sxS8of8itZOB9yEZ2YNY+qQJY3xaW2CNRWGvBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GNKAZUVbORdQSI45Uga8oImsAkhNEQ9gkzJfJOThZjg=;
 b=HLDZSrPrN/cP/9KI3+7rbngG9NsPVpxL0Gmo011va53S2yn06o5xqBwAJAKqEiD1uSJwyQNFvAXd8gZ66BmWEyQv5s3lJRNAy70VKWyXPPaK/sJVngPl382nJJW79CS/ZGL7dmgKn88y/33zXPtqlkrX7izx8kCcuFOvVyvw8sZLsbf3KfIkWKTbUSyzWIPfpO5c44jGK3rPuZq+CyvvtQHGp3JsMdyWbwhtKnUZl/wZjWl3SHdunUb+eoJacJG/bHVL0Z6QhTNj9DDG98NAAJ6vucsSfXAoeqcpXdkN6xx7598bmp6zLWT/uSq/2jtmYg9pb357wSVdz5OOB7buEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GNKAZUVbORdQSI45Uga8oImsAkhNEQ9gkzJfJOThZjg=;
 b=zjnWBDWtOKxfQtOdviR+WNg6wuMnijiW7cySE+dWc55BstlATt4PYW7TqLIVGDYbJTClX6cr22sLTQK9XQNjlTq7SqO/xLyLyHtbVfe4Tr61rWiyC/8XolbR6a2GS68E7XrTkP6EZ4GKBUXoPCtI0oJQfoN+CvCwA92s6Pts3PE=
Received: from CH0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:b0::27)
 by DS0PR12MB8200.namprd12.prod.outlook.com (2603:10b6:8:f5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Thu, 12 Nov
 2026 19:53:14 +0000
Received: from CO1PEPF00018868.namprd03.prod.outlook.com
 (2603:10b6:610:b0:cafe::48) by CH0PR03CA0022.outlook.office365.com
 (2603:10b6:610:b0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Thu,
 12 Nov 2026 19:53:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00018868.mail.protection.outlook.com (10.167.249.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 19:53:12 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:39 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:38 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 12:47:33 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 13 Nov 2026 00:16:49 +0530
Subject: [PATCH net-next v4 5/8] net: xilinx: tsn: bring up the endpoint
 MCDMA channels
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
Message-ID: <20261113-patches_v2_external-v4-5-56bb26f042a4@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00018868:EE_|DS0PR12MB8200:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cfd456e-bcf9-422f-7a8d-08df40f6958c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|23010399003|36860700016|6133799003|261009223027099003|10067099003|261021123027099003|261022105027099003|261021135927099003|261022113327099003|261022115727099003|261026130827099003|261026140227099003|261021121427099003|261028144727099003|261021130227099003|261022075727099003|261026121527099003|261102123227099003|11063799006|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Vhx19UIp6jh2BGx6WkfNs1o5JaMkCQBZgUcUQ7SRa0ucpYMI7ikCA8tqs5TAceYRDK6senVqFwgQ/el+xcTsbGo1y8JWT8B+rlpit5FhpW9b/Gq/aIK4O+37OziYQZ4QRaTNSy8cQBQoU78TjzS1m1wGmu3QF3Ijp2F21zqhfOIP/n7HfuE8allphZlo50Mjw95m2FZq4LCd3qD8x2gE/7fw7B+pNXbDwsbEyz6YXVJtQWap15HeUluEHu/8XscorxRp/O0C1Ds96N1H5Wnh2Kc/ZUlpqyZViKz13Ura1fgztiJ2s+1O9cqqbpox4xtUp5Ni4bJWV83fi3tbRsUki/wKJNBst+DeX4sJ6bYYbeCDuWyQQzr0hC4FJMl4gvjfD2LKMVJpcJUpWQp/eK8+Kdf127w1+CcYeKRVESby7LjbeR+FQjE9DUr+b04MDH6fziIV1ullfalEd03UZgOluWAe0Zz/SmQujzQLrt+XwZhgOgoK89pECezYPG+yUSvLOZd+UDUe+MdpQ8aZgeD+rBBWEbyQ0J1VmdXw6yBmIKPg70aMbnclYqqfksArHg72+9H4T+rEjtudswiZBXxLlyrFPQbyJdf7BVPbfX4CFp97Diyip8eygjOBbt/A2/WPjoz9hZpyW0NWvepapYcnbvNRlGheHi8BtjjLeconFaQ0yLr0L6n2KjlphNiRWj1eCsloiowy6eISCz/zxKKPAmzgveESzCt1GVsmD76LVUbJYsl7mmSjdgpbcbCkqXRbFcgRUQzoE6yzeTLzBwGDVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(261009223027099003)(10067099003)(261021123027099003)(261022105027099003)(261021135927099003)(261022113327099003)(261022115727099003)(261026130827099003)(261026140227099003)(261021121427099003)(261028144727099003)(261021130227099003)(261022075727099003)(261026121527099003)(261102123227099003)(11063799006)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Fr0OAhpy1CoV6wMGzk9bqTbAicJKa+L3GxJ07Nzd4Mb63ZstvcSX1AXEneo9Uix4geTiEVX1jIcUJwo0zKXWpTQoUg/Bb2raNSD4K/2taFGhau0Rb6nYSl2Lz4gSeAcYx8MCycFrjDr+DiJbU3Gkdo8sHfV6HSDEIFXE/CvNMOjdLHnVALxnSqERu2oAKQVolYnbIoTvjbb9aYdhjZHTPMzyAdoq9Wuph6U2+jfOgqN+Y+rWG7UR0DcNuRnuCyZNHArY56sd7HqDVH0Rd0nwiOgo1nf6E7PM+/oOX0NNz9w7uQPwBPo1bS7QnbaxpeGnZnOrCPybshIad1eYLqnwzL75iyCQ7ZNGyRZr2L9K4YMPyinTWDDq1c6ptmOfoN4TGdeh2e3Gxbsyh2z1UEmp8dy4vAMUyl1VJPN5O8baTNsgHyUqyoEOW56ARBu+kq5M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 19:53:12.3692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cfd456e-bcf9-422f-7a8d-08df40f6958c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018868.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8200

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
Changes in v4:
- Describe @dma_address as the DMA address of the first sgl entry. It
  holds a dma_addr_t from the DMA mapping, not a physical address.

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
index 3164d1ce7caa..673c86ca99cd 100644
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
index 9458db38255d..52d2da04a5d8 100644
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
 
@@ -31,6 +36,47 @@
 #define TSN_MAX_VLAN_FRAME_SIZE		(ETH_DATA_LEN + VLAN_ETH_HLEN + \
 					 ETH_FCS_LEN)
 
+#define TX_BD_NUM_DEFAULT		64
+#define RX_BD_NUM_DEFAULT		128
+
+/**
+ * struct skbuf_dma_descriptor - skb container for each in-flight DMA descriptor
+ * @sgl: scatter-gather list backing the DMA mapping
+ * @desc: dmaengine descriptor handle
+ * @dma_address: DMA address of the first sgl entry (RX path)
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
@@ -40,6 +86,10 @@
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
@@ -48,8 +98,21 @@ struct xlnx_tsn_ep {
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
@@ -57,8 +120,21 @@ static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
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
@@ -66,7 +142,10 @@ static int ep_open(struct net_device *ndev)
 
 static int ep_stop(struct net_device *ndev)
 {
+	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
+
 	netif_tx_disable(ndev);
+	ep_exit_dmaengine(ep);
 
 	return 0;
 }
@@ -88,6 +167,228 @@ static const struct ethtool_ops ep_ethtool_ops = {
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
@@ -291,9 +592,17 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
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
@@ -307,11 +616,13 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
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
@@ -325,6 +636,7 @@ static void xlnx_tsn_ep_remove(struct platform_device *pdev)
 		return;
 
 	unregister_netdev(ep->ndev);
+	ep_release_dma_chans(ep);
 	free_netdev(ep->ndev);
 }
 

-- 
2.43.0

