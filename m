Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA62947534A
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143184; cv=fail; b=TQKd+AM/SKMMUwcSX8r1YVgxBDmQbAFuCp+MTYRkf9h0CyOo2CjLJl6Spq/Lv5OdPocYv25m3+SfoeMe7wbDwolMWK+GqZqFKwCd1kLtWTCHvkjc9KRIRQjX06LSV7gaiNvnzZW8UuXfWwPuPPKvTFXNSOL9weaSLGcebARWIQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143184; c=relaxed/simple;
	bh=rvWUIFw1EjDnncdtMySsinn7+WFaV55SUQLj9s5a7FY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RFxw4Ncjh4VeBIRqC7Iw5iFWbPdopVY4bkdbfiFQpl8jJANw/yyiMdXDOfrMuJSMxDo3bY5OO9j5pYYxBSI06+ExR5kkT/NVeOJu2FYfHQ779Q3Y/x7d1tImlDSoFU1gfgpAMHI8ZRqYe0v68WAmW86vZim/GK/5lVGm8SUUgY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hKiRS6ec; arc=fail smtp.client-ip=52.101.57.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hKiRS6ec"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJQxNaH2ZyMIU+7OWOT/vsZs8sCl6wKVrT5lSey4kOWAt/ccAc1w/gIJr4g7oxGLOR75wWMz9vTv2C66gugCkDiYo+/AeulbQHnTMgfpXZ9fjEkmk/I+NUGk0dTbInBmNt8TVDEIZDd60N+vTwQ22tbVdJKGtFkIuwGJ8rS3ydfNckG+uFqx3cA4krSKFhxn5FnXiBCXOzmdMOQT6F7WO7E2/0xkgbfmumrmrxurNkCikc4OM8adCoOquW3sZo3V6U8tLwavqkCWMt40J1FzXHZJ31wfjcR1zi51BLnIfdgQt0dRleBGfrUxJovLUXcsfXO79b/ECEri2T7YyheJUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYV0rthsZuGLzQi6M19UuOhff30zgcQel7ywp16itho=;
 b=cKeUwTY7IA2aZvSqztBZh+uzBSlTgNRfa0ki4IQ/0yJLk9+7r+UWBYirVsp0uApBVKv3qDZBvLoLQtWGW6qH0UFP+veAKjTNHhoEb6US2eGmOXa0L2OZcekRMGaIjsSuCsCop3Q3QYzt0TfyyZdJyxImqwRwG9oMl2QtUsVCxi10H6KBWs0Su4+WqUl06tCz9RRxwVcRGEKWZAK4OAAFWU8CilTkNgAIpge8JwVzFtFWNI55ndJ2ckE5+d1Wy75a9hRcr7wjLGJJcUlzf0G9Ina/KC1r4WYR2VdSIEfuz10M8vVxHdNbAbke4GmN/yKQmG5F56Kj2Ak2rhRsHvQQ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYV0rthsZuGLzQi6M19UuOhff30zgcQel7ywp16itho=;
 b=hKiRS6ecQNduPMzFnUnkBGb2xHVqR+6kI2PxiRSGAI69eS5ipvQoxdFiIZYmG4z9MaVk/7Rf6vm+rfZ4CczyXNIjBkmZp44kYhQYLyQJTVu4DaZKUx7DfheAbMwZRRB73iAOfk+TKr0VCYY/Zfsxh25uvxT0CPo42L7ZxbWOZi8=
Received: from SJ0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:a03:33b::21)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.24; Fri, 16 Oct
 2026 09:32:58 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::47) by SJ0PR05CA0016.outlook.office365.com
 (2603:10b6:a03:33b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 09:32:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:32:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:32:48 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 04:32:43 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 16 Oct 2026 15:02:02 +0530
Subject: [PATCH net-next v3 3/8] net: xilinx: tsn: add endpoint MAC driver
 skeleton
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261016-patches_v2_external-v3-3-e33d3960ca1e@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: d17ac424-272a-4e66-d164-08df2b68770d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700016|82310400026|23010399003|56012099006|11063799006|261009223027099003|921020|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tsbg3CsUBjO+CM37l3XhnMEctzupI7D0fg3ESvYIsuBcdGDFLsNuojvlkMF7GnxZe+O2BjwVoC82aD32vQQdmZmQ/EgWdLhbr0IlRQzgPPR4wKONwt5PH7wiJC0Imx5fp3RMTDKIoMDWmvDVeOev/fe97yQFWzw5F/gNGzGNwPEcjQoU8JmUJ0+A9HZDlRK4T6VOul6mKIUZkO1VdkxYqhzWPiOn+R+HOcXlOZDRCJrDF7O7zs6zowIaecW7iUKQqbQ+sLJChbEwn3ybckZyC2gwaAdGmhlrSOi0e9aj99AAsuk4NYa1+X9OFJnW5PsMO8HHA/NNUqhbtpxdxikzhaCw2O6iwTKZGJH/opR9gIsftmlVYDSdVUNZHJl2Dbfg0id1LEoYbDVg56Xb5CTuExSKuUd04+LRLHvDe/kKnXZSJEY6K1L0cX1Sn+b3sPGaEl2ZLh/Oapxn4lX5EZ7Rd8W4DD/JbytpIpPT7bV9HU4s9+KRE3eUhyY0mh4kc24grThi7N0yP8eTARoXoCCmZFBl5hMWbHcafShO/PwEc3nqYx8oqx6pv2OeS6j+VccghYWafa+b/uLGH6kOv3SIXpjjS7HlqKCIqZ4sgxpd3SEg5PAVvNZouQCzf1EFdenZbyyL4nN8xP8Dy/sC6kDwQsXpT1FJcaHCO5zCRikobJbvIW/U7QcJq2z3ShuFmOk2dyNmQqEtSXqFwSEQ9M7iRdnNvyH82X3fJk94fse7yBwcWFtrs3TVhfZJy12OUnLt
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(921020)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XzX/kAoIUKWyionlY5rcMN1b2UEU/knMvDUPafSBUEDsrT5UZ3g/RD3lKF3FYzO7Q8aTX/RO/ycjy8JgxiiwGRLyiOQmQjeyQfdS445Rbxc3zLCGnEcermE93GHNjssQy1WFKPZ99lCkG9z7h9Gc8kK/7VxteT7XAS8JxJetcOoWRYkdabCllkl0X3aPZWQXn0/SqgBorzVpOLDhgsTlRf52A2352Am7kDm9Tj00peEi0QW9arEIoIUcN1Kv4OPwVK4xgeNDvticzFHXIHJOCDNIYkgfRT0e+oB/PKB6NnoJh4MTQaFEEdcLuOjJo4balzvLv1DnrzW2tPmjISylt2wkhkgynQ45cfgjnyBX9fRKqdKbueQno5wfVwQBPb25cF+nI/FF1UseuMW8HIMxuk+R/DimW9dLtsnz9OzOq1WlwyDD58skJvKgjKfmS53G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:32:58.3170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d17ac424-272a-4e66-d164-08df2b68770d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690

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
index 000000000000..609d444c6835
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
+	ndev = alloc_netdev(sizeof(*ep), "eth%d", NET_NAME_UNKNOWN, ether_setup);
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
2.44.4

