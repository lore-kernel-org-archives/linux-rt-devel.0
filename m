Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794571307;
	b=j644HYFwzeD+4IJgHeZ6HeIEoHz+sKht78cMYL6pAWsF9BF0Srw9O3mFWQpD+M72kZ50
	 bWqHJNrJqzelRei9EXVziSqstWc98dsPzIyXckvQZsVcG5bjSLZuZLJaMj66ja5IpYmmi
	 T4Ilji1iwefafxBKNbDrV19nnHNgaOkMeJJghP44eyL/ME6WoMpy5RRr1vd2FPV67+tYl
	 T55l9+NhtuwM+fbdE5gpsPKLaTkmsDc5jUCmLAfbWz/Kz0nc0k9gbma66Sn6gcoyoMnXo
	 3TC+fEXF3Zgt1YDkzIiFrxU9udLrcmowG+i2cXUELrKXutIrhusiknyNsSte4Tnxzfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571307;
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
	bh=cu0W+xYu8Ur8iREfOVKM1Sg6ts8WzrHN5Mt/1Du8ils=;
	b=gDi0CkxF+T81/ZvpFmy8vpn/B+MpcdheYzga9d2hopciyXO77Rj1+EGKKPTcVJG6mSde
	 hoL6xtCXhL2HeWnLNybKodvBL8r4yT4Hqnrl/EhrRdi3x6VVp8J/OzUc8mw+1gZ8vDd4b
	 y9TPIp+UOzdbpI6LtcdwU3M+ylIkSz2hrul2QFuv1DvEfp+wBqvqpr2cynlqkyN8nOl9f
	 mSrvW6qbgOWKs+gpWwDpdqwk/pJ8KH2QI2/8yL0YKfp30ZNeqYAgsevAMTmFBJweBuoTu
	 cxuqgU2sgwNmFmSRQrN3rA6Nboyml9R67gVCv1WM9rzIlwGntEyaHVBJIsIyj5IiqcQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cxxqjDJ7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.21
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011021.outbound.protection.outlook.com [52.101.52.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815CD606A8AD
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 12:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 815CD606A8AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cxxqjDJ7
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgQJZyeaINvO0RGWRtJ66ftqYt/TFcsvox4YCEIq+9sqeQYvBOJMx/TgIuSvTZNB9OHrWKSbwYdnGScZIGh4LB18DJi/ChmbSruR/8808VePEswNiGc4ALHG3w0C/gFYBs8XHPKRuBTuLqUHbJCb83SKZ/RHRtGJsk+1I6g1R4/VKLeqAJsvTdXwT+idmbZ6hTbmSlHD/QbD07Xwi/q49rlvY7W2/LWvYg1moDFFduSKbQPld1EXfEql2lrR24au3omhyexj9R2ND9wVDKNgNh5NZDPWzzMlv397xA8qQ7/E9vVkrclGVKEzczCdVwcuP5RTpnSZIWARMC6fCZBpeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu0W+xYu8Ur8iREfOVKM1Sg6ts8WzrHN5Mt/1Du8ils=;
 b=MoCiBfDSPiJcImn1spSsun7VYiOgFOD3KXDF4HLpB9vFckAXjlGNfePDoM+Jg8gMrcEeiZM5WahCdB2mvOH5s7u2IIekrrcn4M2MJ+sFhbpcUGUGkPZEiaJJ4+Z+pRLa3YBwGC6ex4xbBP9Ed5oRh7pW3+7cLzXNiuMO48+GHAm6ZCNyERT4KizmVWq1uP+b0vt1+Hrnf2CP2loXuLOMn8lnxG1Iybd0IXK35IA3FOGvCyDKOK4E/XlILk4kFhZWLEYIlSCDHV+fqRBjJ56vbF8flMqqI6S/a/I4wu1m/wwRull/PAiAmAJ51aGG5fbTA0bU81NqunwJ1vttBNExHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu0W+xYu8Ur8iREfOVKM1Sg6ts8WzrHN5Mt/1Du8ils=;
 b=cxxqjDJ7+glqvduoI8dToV8TGE9mZXhsQ/O0JfZDc90gnW5pXG8v3Az6fDbBPGS59glxnk/eUgZMeVe7VMeeET2Y+Bqi13H+ysGVKvia8tSCjqF9mUYutLXUd0jIzkQzfgR4xL7o2pEwWimK2AX3U7QEhT8Z26k39eE0hWeSGuY=
Received: from CH2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:610:58::27)
 by CH2PR12MB4248.namprd12.prod.outlook.com (2603:10b6:610:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 12:01:42 +0000
Received: from BL2PEPF000352CC.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::1f) by CH2PR20CA0017.outlook.office365.com
 (2603:10b6:610:58::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 12:01:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352CC.mail.protection.outlook.com (10.167.249.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 12:01:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:27 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 12:47:22 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 13 Nov 2026 00:16:47 +0530
Subject: [PATCH net-next v4 3/8] net: xilinx: tsn: add endpoint MAC driver
 skeleton
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
Message-ID: <20261113-patches_v2_external-v4-3-56bb26f042a4@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL2PEPF000352CC:EE_|CH2PR12MB4248:EE_
X-MS-Office365-Filtering-Correlation-Id: 08ffa4b1-593a-487a-2315-08df417de0a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|22082099003|18002099003|921020|11063799006|261102123227099003|261026140227099003|261028144727099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|56012099006|261021123027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	QaDJiIejak70rMsheAbneAWD8NVfhCQHiwMCY466E/j8w/5i7UWSqkJV3UiWQEMR4ovx70wuSyguh9HwMAsmLWO4fhtoCuaErev1pV+7hDX1KfrtM4LTzB8zkplFKkNG9uq/O4OBP6t4Pn90gqLZPoXhOjzLjjraHJreaxZ9h6HRS2fJ7aBUnoqvEzatXvI1mYK23Y6XgUQ1GCfukxrSmwVswa0hVVaHwZNlwxHAdfBJCJF+f8De4tVYbSWrZYO9rIZu1FmXoVYO+kq5nMznz5Nbq7MVQWLAQxs0zf1bfKRGA/4OWMKyWVTNgl2Pf6TwDWGpaf0CBQKvhDlKWSY1EXX8f2EmcBkBr/J1jryy8CnkG2qpB+UKcQt4d1U5opAQpjHFmxAAC82dTutb3G9d3eU/ttXtTc4SRKq1vpZjKWYZrLjZdn9+s09hBEe37tswnCxib6TJ+t2lW+W0ZIXcznX/oeEPJdmuqIwugwX1bBehqZWRxByUSo7l0i0VAaQ0CwuqE5KeA3R9xWuGDhOIhRRaZtMbOel/Ky/cvlUGavMkDKG+OKxH/+dNsX+GeNEpI1bQSySLSe4QIQWhMLFCWpWlNi3Bz3uge9toCJwhXiFCk0sJ1RCa8Qg+dfk7vOYhCkufjt5yupdAYznEn2AXcq36vEbkNsMLRtRwWoCCNg3hNM9OdcQDRNoic2r5wK5aLlvaxYAn1lA3KMx6mM227OcyWO/NPoTg+/h/ghVqRKqn6b0JFK1iVw32T0ABYzTU
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(22082099003)(18002099003)(921020)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(56012099006)(261021123027099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	haoWTkl4kgFjiLGwtz8U/4HD6MM9loVOLMQMNtvBQ0IiYZt+6jtgc+clBaMEV6lCC5da6cFnHsgPSSWhcpcuG+4AL2DWMxoltAI35+Z0hJmN7jLeduw3IlGR8tTAZKdcHo+JWkGkmwuGi1xxQvm8jtPQoJNmmNwjirrtREujKE2zQdNMIVwBNahDx1lan4o7gBxw29NXtfONksWrW/roDFOdBu6JBTc+lDY3+lw3xltc0czN2DBJ0kkYzAcIEn9M/WVep1Pr+b24z+6iYnk2Vky6Mt6wPM1EbNy9g8IZnbV1jZLHpLqVJrCep9i0HyVl9UxsyIgbapSNVfPIPPkEIeJwmJ0s5CZ6zlaemUV2UnaFdQyA//6yiy9wHL4k4Qc71+mfeOot/8fs60Lunm4SBHi/2n3wRS0zqw/DIWeRPyI5h6Pn3YnTRBbHHKfkW6S+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:01:40.4349
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ffa4b1-593a-487a-2315-08df417de0a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL2PEPF000352CC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248

The TSN Endpoint MAC owns the IP's host-side MCDMA data path and is the
netdev physically wired to the CPU. The DSA switch needs this netdev to
exist as its conduit.

Add a platform driver (compatible "xlnx,tsn-ep-mac") for the endpoint.
Register the netdev with the standard eth%d name, set its MAC address, and
provide minimal netdev and ethtool ops. ndo_open starts the queues and
ndo_start_xmit drops frames.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v4:
- Use alloc_etherdev() so the standard eth%d name is registered with
  NET_NAME_ENUM.

Changes in v3:
- Register the netdev with the standard eth%d name (NET_NAME_UNKNOWN) instead
  of a custom "ep%d".

Changes in v2:
- Name the netdev ep%d with NET_NAME_ENUM instead of a fixed "ep", so a second
  IP instance does not clash on register_netdev(). The %d enumeration is what
  NET_NAME_ENUM describes, and it matches the eth%d naming in net/dsa/user.c.
- Drop the mapped but unused register window (ep->regs and its ioremap).
  It was intended for QBV support, which is not part of this series, so the
  endpoint driver does not use it. The mapping will be re-added when QBV
  support lands.
- Use dev_kfree_skb_any() on the drop path, not dev_kfree_skb().
- Drop the mod_devicetable.h include, platform_device.h already pulls it in.
---
 drivers/net/ethernet/xilinx/tsn/Makefile          |   2 +-
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h      |  15 +++
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c   | 143 ++++++++++++++++++++++
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c |   3 +
 4 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ethernet/xilinx/tsn/Makefile
index 6f99226f3dc8..5886828b386f 100644
--- a/drivers/net/ethernet/xilinx/tsn/Makefile
+++ b/drivers/net/ethernet/xilinx/tsn/Makefile
@@ -1,2 +1,2 @@
 obj-$(CONFIG_XILINX_TSN) += xilinx_tsn.o
-xilinx_tsn-y := xilinx_tsn_main.o
+xilinx_tsn-y := xilinx_tsn_main.o xilinx_tsn_ep.o
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
new file mode 100644
index 000000000000..b0757e22d1fd
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD/Xilinx TSN Endpoint Ethernet MAC driver, shared definitions.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#ifndef _XILINX_TSN_H
+#define _XILINX_TSN_H
+
+#include <linux/platform_device.h>
+
+extern struct platform_driver xlnx_tsn_ep_driver;
+
+#endif /* _XILINX_TSN_H */
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
new file mode 100644
index 000000000000..b6458bb0ba0f
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD/Xilinx TSN Endpoint MAC driver.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/etherdevice.h>
+#include <linux/ethtool.h>
+#include <linux/if_ether.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/of.h>
+#include <linux/of_net.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include "xilinx_tsn.h"
+
+#define DRIVER_NAME			"xilinx_tsn_ep"
+
+/**
+ * struct xlnx_tsn_ep - EP MAC private data, embedded in net_device priv area
+ * @ndev: the conduit netdev
+ * @dev: backing device
+ */
+struct xlnx_tsn_ep {
+	struct net_device *ndev;
+	struct device *dev;
+};
+
+static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
+{
+	dev_kfree_skb_any(skb);
+	DEV_STATS_INC(ndev, tx_dropped);
+	return NETDEV_TX_OK;
+}
+
+static int ep_open(struct net_device *ndev)
+{
+	netif_tx_start_all_queues(ndev);
+
+	return 0;
+}
+
+static int ep_stop(struct net_device *ndev)
+{
+	netif_tx_disable(ndev);
+
+	return 0;
+}
+
+static void ep_get_drvinfo(struct net_device *ndev, struct ethtool_drvinfo *ed)
+{
+	strscpy(ed->driver, DRIVER_NAME, sizeof(ed->driver));
+}
+
+static const struct net_device_ops ep_netdev_ops = {
+	.ndo_open		= ep_open,
+	.ndo_stop		= ep_stop,
+	.ndo_start_xmit		= ep_start_xmit,
+	.ndo_validate_addr	= eth_validate_addr,
+	.ndo_set_mac_address	= eth_mac_addr,
+};
+
+static const struct ethtool_ops ep_ethtool_ops = {
+	.get_drvinfo	= ep_get_drvinfo,
+};
+
+static int xlnx_tsn_ep_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct net_device *ndev;
+	struct xlnx_tsn_ep *ep;
+	u8 mac_addr[ETH_ALEN];
+	int ret;
+
+	ndev = alloc_etherdev(sizeof(*ep));
+	if (!ndev)
+		return -ENOMEM;
+
+	SET_NETDEV_DEV(ndev, dev);
+	ndev->netdev_ops = &ep_netdev_ops;
+	ndev->ethtool_ops = &ep_ethtool_ops;
+	ndev->features = NETIF_F_SG;
+
+	ep = netdev_priv(ndev);
+	ep->ndev = ndev;
+	ep->dev = dev;
+
+	ret = of_get_mac_address(dev->of_node, mac_addr);
+	if (ret == -EPROBE_DEFER) {
+		goto err_free_ndev;
+	} else if (!ret && is_valid_ether_addr(mac_addr)) {
+		eth_hw_addr_set(ndev, mac_addr);
+	} else {
+		eth_hw_addr_random(ndev);
+		dev_info(dev, "no valid MAC in DT, using random address %pM\n",
+			 ndev->dev_addr);
+	}
+
+	platform_set_drvdata(pdev, ep);
+
+	ret = register_netdev(ndev);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to register net device\n");
+		goto err_free_ndev;
+	}
+
+	return 0;
+
+err_free_ndev:
+	free_netdev(ndev);
+	return ret;
+}
+
+static void xlnx_tsn_ep_remove(struct platform_device *pdev)
+{
+	struct xlnx_tsn_ep *ep = platform_get_drvdata(pdev);
+
+	if (!ep)
+		return;
+
+	unregister_netdev(ep->ndev);
+	free_netdev(ep->ndev);
+}
+
+static const struct of_device_id xlnx_tsn_ep_of_match[] = {
+	{ .compatible = "xlnx,tsn-ep-mac" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, xlnx_tsn_ep_of_match);
+
+struct platform_driver xlnx_tsn_ep_driver = {
+	.probe	= xlnx_tsn_ep_probe,
+	.remove	= xlnx_tsn_ep_remove,
+	.driver	= {
+		.name		= DRIVER_NAME,
+		.of_match_table	= xlnx_tsn_ep_of_match,
+	},
+};
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
index afe7609c67fb..d33a00dd6d15 100644
--- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
@@ -15,6 +15,8 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
+#include "xilinx_tsn.h"
+
 #define TSN_NUM_CLOCKS		6
 
 /**
@@ -85,6 +87,7 @@ static struct platform_driver tsn_driver = {
 
 static struct platform_driver * const tsn_drivers[] = {
 	&tsn_driver,
+	&xlnx_tsn_ep_driver,
 };
 
 static int __init xlnx_tsn_init(void)

-- 
2.43.0

