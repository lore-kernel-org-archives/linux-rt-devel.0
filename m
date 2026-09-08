Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A8A5A0AA4
	for <linux-rt-devel@lists.linux.dev>; Tue,  8 Sep 2026 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895237; cv=fail; b=iBoxV8DbD+0/fIwyiUACreMAHBTCi6naOBgm9UDtKe9pboLMUKNYe5tb0g2xj54x5Xe75sRtu8Z6WNFUq0+lyjHrLFHZRJ9i90nD1q5CLo3ZNShJksCsHwCepr5VvDl9Khm6K7d70YWhLXGPR0cHebjd22ZEDL+4Rv6yEtP9SWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895237; c=relaxed/simple;
	bh=s3PqVk90hnLlMFhxWIHWLAdvpP7V7ABdtDUQFl/QNtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TDUAaJ5KTHvo0R3pY9f9wynkAXWNv1/al7b+nqYVZbvVYgl1j20tM/9/0X2L31L+Epdr2OM5gR7jeFbTLzL+skMlwFCGyI3I2AQKRMafQJOQIgL00ycmOCv+7I0T0dFz01kSBxDC0UHeAXcX3P6ZHlDeAPsuudvHqiNfYqopbR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dwyjQhbj; arc=fail smtp.client-ip=52.101.43.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dwyjQhbj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X58VCsp/hnMWTcstPTvkAa9JOIWndfZbY2lODtZjTu7FKHC4tUCsNoxH2Im1UWfhLuvT1bJiwmW6dOOvLtkDSjcq5aPlubckjhMWS3QQUmKSUaU170bF8BQ/QgqdMCebbroQSpMsHuAiMxeaQ1NNa23E9GaEizG/a8Ycc2iyN9LUzcf5UNpIwnpXf/v5JykuVUZnPWmcKhHdszSIZ+sk3g83BFpHQY5586bT1Mf7UyuJF2x66/b0xFIQDF6A53UL8tdBFfr15pa0xayW/S3wYS6CWOUuCq3d2WoDzT+KqC6+ngvTK9iJdVfZSEiY+YoNQQjhiAi9CGhOfAUCo8TFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9azW7t9dcyG3pqsXhQh6LRCJv3RFtJYyBaRfuLvzMGY=;
 b=Uy5WFHn7Zow85+DfwgSfQRTv3hkEdtJGVqAPL6anPWb0QzUjMeXUIZmYKJn6jqYgyK4M2dB2/1+t44iA/MB5iE6PWrVgyucBncUtrjGlqQI1pQD0xZieZc1uqUf7IYLv+558uAMf51DY7zpPGqt0AACM+9+Hms3fN+Xui4fA72UaSByxD9TY7ZU8jvEjp5sRAm/YDX7VwrG9UynXJTYk66frzDquaspeVWZdGJPP2YTSx7ejQ78KJze9ZFPXcwxi2APg3n+q4DyXw5aZBDwXIEOeVOnPdmz7q5DX+pw2M+8655Cl5LLNP66LlSrKiaZ3EtsXf/kNBDUdbHmtR0oJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9azW7t9dcyG3pqsXhQh6LRCJv3RFtJYyBaRfuLvzMGY=;
 b=dwyjQhbjBPa3238ofAwo/sYEH3flURNTVCJzGve/Nhh0pfx4THY9x8M2rhdAWPa/gtM+fv0gYfirltEXhW9z5k8WIaDBqNSe+VBc+3r6vT16XBcqbI9tZDuEZHfQ1/Uz8+oPzLnAtV4gl5WVepsMRYdsPl1xnJHy/XtktGs2GmY=
Received: from SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::25)
 by PH8PR12MB7112.namprd12.prod.outlook.com (2603:10b6:510:22c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 19:20:26 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::36) by SJ0P220CA0009.outlook.office365.com
 (2603:10b6:a03:41b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 19:20:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:20:26 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:25 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:24 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 14:20:19 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Wed, 9 Sep 2026 00:49:51 +0530
Subject: [PATCH net-next v2 3/8] net: xilinx: tsn: add endpoint MAC driver
 skeleton
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-patches_v2_external-v2-3-3a40babaff4c@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|PH8PR12MB7112:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f7ee20c-1695-40fe-b4aa-08df0dde3ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|7416014|10067099003|18002099003|22082099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	wfdbnu3IuYoorEDe9bvvXlOVFIkUO9bD2qR9veB/ElWG/hfFTHtNi73S51aCZlt/AhdX7WCK2JdJ/6yPMe9rmEBiazhLPCh8FNDF0mLLvc4MQ9XZwNA60lpdLFa3f+udiNJWmtV66jR0iUDFmZ0aXBYXv2eytK2HBca4wNFwAfLZCDeCDA9WaMtBYEmaCNd/B4N/+tiSJaVlz3T4FW0ns9jnFaX7fPFmAUGU85NDtShEFzcqwlniqjHpP/NYL+YQX3TVABkyUaZHnujk4aRxuwcUGM3yl63oLZQtNUvznjQMFVm8btP5QglEK731+3O11QweTU00ByTz6k9NVAtHnRxYIlNisleTO1cCC+PK+do1BsqiLAswjbvKkNR2RbZkB4YTqT1UjMSUCDkgpMhFHjW9s5yaVTg9cseerwM2/ktuSJ6oh9lNARYcz2KLnBxNinykMnPqWso6hR/f5D8Bi6EUwsWKYVPrBCRjw3wh4GveeDsiDwbOOL6PK7NzSgi2ylO7xjGlaoeTUak95VEJJ+bHVjZmzTlgvYIev/ps6lVq50eSD6Oss8gL0YXy4Y+09luwJPSDWs32ZUrJrqYskqth0DDwp6ZJ2VP9hIw4JZ0YVkyKwmN7KtgA/UBfRDaNEx3fy6ZfUXcS3bcscDaGQHDCDqejHaXfl4MnLYHujeJ9r7dEb3il7jvWEvn5oQMhfa/aw+WmE+fH+1/1kxjxugtgIEdx/nzzNV3kZXm3S6ZIS/mY/CYLN/p3MtAilvwJ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(7416014)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SMol4o8859tYihef6aHjmGnRBi4magRf6qB/MkEhdqjxOyGjIMEvb18mMwYLB8sBrQbI1J2ZXeZWQ+izTAxL1ub5wsYSOAISFf37KhQyZPI/JlHEMRaNi7KI/xDkIC7l6yEyREq/Wb0rfvwT0P6AXuJFcB/8ysmlag0xePk77FcAziuC/hAvBz705Zab9gGWzJ4B1myBphePrrE/a43/gkDZjVImq1hKmaQuKw3lfv2Q76N1MHhhx9n+888GtqeQZoBx+MFS/pF72Ur0yYTCbcMWOS6wUyOysl2uQRJ0sYKXF05jujSlDyGhf9sr0rlSKsuE+zwnHYIRUAlOfwxB9i8aEbVFox3a3N/G6iqpYarMR0kPJXyLqZKC/oXBV117iZREZeWpZYkbMgIQVZK6FeSqhus/MYHI4jRwJajESoOpuhPKMaLLr5cDi4ofyYH3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:20:26.0396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f7ee20c-1695-40fe-b4aa-08df0dde3ca1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7112

The TSN Endpoint MAC owns the IP's host-side MCDMA data path and is the
netdev physically wired to the CPU. The DSA switch needs this netdev to
exist as its conduit.

Add a platform driver (compatible "xlnx,tsn-ep-mac") for the endpoint.
Register the netdev named "ep", set its MAC address, and provide minimal
netdev and ethtool ops. ndo_open starts the queues and ndo_start_xmit
drops frames.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
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
index 000000000000..089f17a126f5
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
+ * @ndev: the conduit netdev ("ep0" for the first IP instance)
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
+	ndev = alloc_netdev(sizeof(*ep), "ep%d", NET_NAME_ENUM, ether_setup);
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

