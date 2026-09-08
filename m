Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011031.outbound.protection.outlook.com [40.107.208.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3459D623
	for <linux-rt-devel@lists.linux.dev>; Tue,  8 Sep 2026 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895233; cv=fail; b=S/LHBgGPUb8ED61jJ4KVokmnBa1Te8da/2FiwUq6mG57pN5jqtl2VQ7/G7kNHiRV+Meu940OfNPsxrOevAdRYKFoJWRYe088qNIBL78FaWeYiLEFOfAFjgRtmoMXs7t5CeOWAHp2nMMzDjan8U2d0LprtFv68Z74EIklQQICO5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895233; c=relaxed/simple;
	bh=Npjg88SQf2SRAlmH1Q3iOznlOImBzzwYpSd1ZgLN8Kw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=u2udZLSDAHa/fy3VResDYVsr12tLOAJnpIV812bzEGr46/h9XyNebAOruPpY1pAX3v+MX/EPRISDavWG6Owbt9fqfs5MMGzqPgf2rWDdTL5fLRRKZVHoinKu4Pf9PGIJWxkXFGmOzCJZ5F4OddOqAt+zmGMORpUUl6twRGZu1K8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ne/UHurf; arc=fail smtp.client-ip=40.107.208.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ne/UHurf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kjuq7mflvMvyIRLCC58V8XgXSIEKreoJzsspz5HZQkcMOpmjPhIOuh/V0KEeT+uVoy563l55RnbGRnoOQ2cThGKwSwpRY5hi+QbzrVHqYx1JJZB5xjojdZ4AyLRsM+KRZtE4K2jj276+Z1j3AS9m+vakF64TAlOSux5yPwixWw9kCYZBMbJ90wRDn334KlQoHizPtMJqe2MAYEJThg2wD/BDpq7pC5YPRd0CT+nFAuIF3aDHyj3NH72KtheJk4k+X5VtsVc8RlaxR9zx7GqEnpyWhrwQVS9/75zTyqBnr7y0Hkq8AB9HvgYIQUzwKJXg5b816KZxbvXWaXWzh+rYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8aY+Nr3x7XzHIYfiumJnMaUePwpMkRrArh4k09YEsQ=;
 b=ZmrnCc2ZN/jrOgzkEfYT7/fg8pA/ZwY8Pc73JVxxSu1hI9nOot1bfx7V3EByj79jCkso94i4H3R0r1Ewbe2Mc43bJxRjx9JS8wlq7wx6kP74ECvstxfJrZWwABTjiiJ5FUwh4FLhO0V3t3EIOP8peQao8hlbnykyJmoFhI34s7UsI47cqYRzvddEzUzRp1TV0BigODcZuC+uenzmeNM7wlDZabcQ3+wN+GNAapKRdIBmEdYrNtOfXuQdLeBkT7XDGTbCtYeaH37IYOOzo+fsQMjcPwE1MB3KxNipdGNaZInoBWfQEn1tUSAbxUaMmM+pyh2Modwi4KaEe/d7UKaqjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8aY+Nr3x7XzHIYfiumJnMaUePwpMkRrArh4k09YEsQ=;
 b=ne/UHurfSvMD5lURyt57JDtSk3+uJDOiyCOvOwy5CToyY1I24DHbIkP9IhPA85/Fu7KAKIUnvuBcPm68sX1vnLrrbs7U3UV2996ZjT6ngx9BJE+X27ImFsY9k7gx+TJrWL33TdUSI7m42QaeRn/s+IgtTdEmS09qJCIcjmMPepE=
Received: from BN9PR03CA0663.namprd03.prod.outlook.com (2603:10b6:408:10e::8)
 by SA3PR12MB7950.namprd12.prod.outlook.com (2603:10b6:806:31c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 19:20:21 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:408:10e:cafe::2c) by BN9PR03CA0663.outlook.office365.com
 (2603:10b6:408:10e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 19:20:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:20:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:18 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 14:20:13 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Wed, 9 Sep 2026 00:49:50 +0530
Subject: [PATCH net-next v2 2/8] net: xilinx: tsn: add TSN endpoint wrapper
 driver
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-patches_v2_external-v2-2-3a40babaff4c@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SA3PR12MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 9777f74b-2154-4e41-44b5-08df0dde38fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|23010399003|921020|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	55xZMqhqQm8IztrBnh59b+1vKZAbhOu7N3vEPt5YkjGIvIq+flA1gl6JWtSmlKJIno0m22R2nONif+sknRZRXCJY5Sdl3Y9J9WKZOgV9o5vCa60nqWoEKoZP9aR0Tc+ERfy40ZEkhLiFqki7qD4+VngNvHoknZrDpssDAqfN4KldOR6Xvx+C5WphNoPRvoxXYiJe8nDrUTKFcCpoIa+3qbceOqoL8RnTrndVY3F2Hh9e3BtgYA8Q9KUJPCVAL0xtoZDr4MFpacxV1mrnZr5r8WLg6wXLXPzoEXJwzoUNbmipJpKpeQzlXT8pRBfsK9LAPf+AEJqzPoY4stqggg6ztVaTCBrSw48nCg0jZrhEjAbyF/rbKoSbMMTy7WNrwpCJvzrrnfbDQ1r/JS6W6tir6z1tFIy47q6p3ZqscK25wX7+ik5Wp7KcCK6UkvRIwz5t5XSVe2ZUR6fWsQun7qecZlDT65MpKl3smmNzCv/DSiRA0Ygtfzso6gIy3jIERAjENz4MiQjrGF916Hzg5uwyT+DwTgt2v8T6q4F8rVGshcKdQeTodtsaxks7uVc2rvKHjLmVsJsnohnpWM8FD71WuuDZlRlqwMKdpIxFFp7Bqq+KbI7teDWyOnnfOp9gXNSm7Tpg7tScn7inuB1PPc8VVaDotVBVX0tlcnbho2heYaMvhlc7HAq0fW9mCI44KE5eVLTf1sF56qOlIrL7JQWZR8B+Kvb5dUYtmvq2TzOITNBoCJZmHdjWbaogaqLwv8ld
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(23010399003)(921020)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7z7+X/YERt2rbkH+AVIPwQMMYzQ87U0JMToqlnfHN1AJtpu9zonO9yFYqQgNLt6+Zwx9JBppoh4EF7AhqwCe0KAgOfyiHotaJzJ9qXsnETstZVU2JwVtgbI81AfS3t7LnLLjpnabQHE3FQ1tR1bQk0FHU/f+RfmQHcqoGlDoIkjNuLHaH2KADsJW1QZGUExvw/8R0cpRyV2YwyXr0y6Ro5YJjTXPU5kWiVyNJxhsl1wSN+DRW6gtduUW+au1E1Qbf8lika4Srl7eisXPynFkfO9F6Ee9+n6rin76K5KpaGPABqf4sxxCarhLS/lcW0MDwpW+aQXVdDqAKHKE3IPl+Jg5kCdNYZvfu/t1pECEF/OrHmXdYK/3pAA220LiXlO1NMqPTxlp9MYf0BvfP2lxVraLgK9hMSzCwp4BqcbQ6R7NyQC6OS7tW0KyBWVcI9HO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:20:19.9527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9777f74b-2154-4e41-44b5-08df0dde38fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7950

The TSN Endpoint Ethernet MAC IP groups several sub-nodes under one IP
node with a set of IP-wide clocks. Each sub-node needs its own driver,
and the shared clocks must be running before any of them probe.

Add a thin wrapper platform driver for the IP node. Enable the IP-wide
clocks from the device tree and bind each sub-node to its own driver.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v2:
- Depend on OF_ADDRESS instead of OF && HAS_IOMEM.
- Point the Kconfig help text at the companion DSA driver, not a symbol that
  does not exist yet at this patch.
- Drop the mod_devicetable.h include, platform_device.h already pulls it in.
---
 MAINTAINERS                                       |   1 +
 drivers/net/ethernet/xilinx/Kconfig               |   1 +
 drivers/net/ethernet/xilinx/Makefile              |   1 +
 drivers/net/ethernet/xilinx/tsn/Kconfig           |  15 ++++
 drivers/net/ethernet/xilinx/tsn/Makefile          |   2 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c | 104 ++++++++++++++++++++++
 6 files changed, 124 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f93f165a744..ff94e314eeb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29917,6 +29917,7 @@ M:	Srinivas Neeli <srinivas.neeli@amd.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
+F:	drivers/net/ethernet/xilinx/tsn/
 
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 7502214cc7d5..c6d704c8d3d4 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -41,4 +41,5 @@ config XILINX_LL_TEMAC
 	  This driver supports the Xilinx 10/100/1000 LocalLink TEMAC
 	  core used in Xilinx Spartan and Virtex FPGAs
 
+source "drivers/net/ethernet/xilinx/tsn/Kconfig"
 endif # NET_VENDOR_XILINX
diff --git a/drivers/net/ethernet/xilinx/Makefile b/drivers/net/ethernet/xilinx/Makefile
index 7d7dc1771423..66dab012650b 100644
--- a/drivers/net/ethernet/xilinx/Makefile
+++ b/drivers/net/ethernet/xilinx/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_XILINX_LL_TEMAC) += ll_temac.o
 obj-$(CONFIG_XILINX_EMACLITE) += xilinx_emaclite.o
 xilinx_emac-objs := xilinx_axienet_main.o xilinx_axienet_mdio.o
 obj-$(CONFIG_XILINX_AXI_EMAC) += xilinx_emac.o
+obj-$(CONFIG_XILINX_TSN) += tsn/
diff --git a/drivers/net/ethernet/xilinx/tsn/Kconfig b/drivers/net/ethernet/xilinx/tsn/Kconfig
new file mode 100644
index 000000000000..b8939d8a92ef
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx TSN device configuration
+#
+
+config XILINX_TSN
+	tristate "Xilinx TSN Ethernet driver"
+	depends on OF_ADDRESS
+	help
+	  This driver supports the AMD/Xilinx Time-Sensitive Networking
+	  (TSN) Endpoint Ethernet MAC IP. It provides the wrapper device
+	  and the endpoint MAC that connects the IP to the host CPU. The
+	  three-port switch is supported by the companion DSA driver.
+
+	  If unsure, say N.
diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ethernet/xilinx/tsn/Makefile
new file mode 100644
index 000000000000..6f99226f3dc8
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/Makefile
@@ -0,0 +1,2 @@
+obj-$(CONFIG_XILINX_TSN) += xilinx_tsn.o
+xilinx_tsn-y := xilinx_tsn_main.o
diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
new file mode 100644
index 000000000000..afe7609c67fb
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Time Sensitive Networking (TSN) Ethernet MAC wrapper driver.
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#define TSN_NUM_CLOCKS		6
+
+/**
+ * struct xlnx_tsn_ip - wrapper-private IP state
+ * @clks: bulk-managed IP clocks
+ */
+struct xlnx_tsn_ip {
+	struct clk_bulk_data clks[TSN_NUM_CLOCKS];
+};
+
+static const char * const tsn_clk_names[TSN_NUM_CLOCKS] = {
+	"gtx",
+	"gtx90",
+	"host_rxfifo",
+	"host_txfifo",
+	"ref",
+	"s_axi",
+};
+
+static void tsn_clk_bulk_disable(void *data)
+{
+	struct xlnx_tsn_ip *w = data;
+
+	clk_bulk_disable_unprepare(TSN_NUM_CLOCKS, w->clks);
+}
+
+static int tsn_ip_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct xlnx_tsn_ip *w;
+	int ret;
+
+	w = devm_kzalloc(dev, sizeof(*w), GFP_KERNEL);
+	if (!w)
+		return -ENOMEM;
+
+	for (int i = 0; i < TSN_NUM_CLOCKS; i++)
+		w->clks[i].id = tsn_clk_names[i];
+
+	ret = devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, w->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get clocks\n");
+
+	ret = clk_bulk_prepare_enable(TSN_NUM_CLOCKS, w->clks);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable clocks\n");
+
+	ret = devm_add_action_or_reset(dev, tsn_clk_bulk_disable, w);
+	if (ret)
+		return ret;
+
+	return devm_of_platform_populate(dev);
+}
+
+static const struct of_device_id tsn_of_match[] = {
+	{ .compatible = "xlnx,tsn-endpoint-ethernet-mac-3.0" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, tsn_of_match);
+
+static struct platform_driver tsn_driver = {
+	.probe = tsn_ip_probe,
+	.driver = {
+		.name = "xilinx-tsn",
+		.of_match_table = tsn_of_match,
+	},
+};
+
+static struct platform_driver * const tsn_drivers[] = {
+	&tsn_driver,
+};
+
+static int __init xlnx_tsn_init(void)
+{
+	return platform_register_drivers(tsn_drivers, ARRAY_SIZE(tsn_drivers));
+}
+module_init(xlnx_tsn_init);
+
+static void __exit xlnx_tsn_exit(void)
+{
+	platform_unregister_drivers(tsn_drivers, ARRAY_SIZE(tsn_drivers));
+}
+module_exit(xlnx_tsn_exit);
+
+MODULE_AUTHOR("Srinivas Neeli <srinivas.neeli@amd.com>");
+MODULE_DESCRIPTION("AMD/Xilinx TSN Endpoint Ethernet MAC wrapper driver");
+MODULE_LICENSE("GPL");

-- 
2.43.0

