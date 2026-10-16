Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9731C471CFE
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 09:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143177; cv=fail; b=Bf5vcoUCTtqFavqxIZowa1z5IhUTmerQYl9pzGR9RPx5W4RfWCqE7EyZFyHTRjyxKda85GvWnsB5qXlQjpOgyXt5kf3cVlJhgM5AbCdO8Xh5vJZoji3KzfgmLnh72p2Zyj7oFYK0N/yliujHgCQ4NHv3V9jUEZEJTq0ieNZ/p10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143177; c=relaxed/simple;
	bh=kTis9a+Y67/q9N09noemkxQ1IcTgX0NwYsra/m+etUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AlwTO1vXLEpGHquuKz9z3ZirYs+0tJgIAg7mebC8LEsPEjc69gCvlxF87pkf6mjjb656RoAoC6aZldJmQ4BhURy/imSn828nws9DIlY+zQcghSoS/VtoCPz9dWtORsiyGWiM7N/Kk/Vkj5GFXyf/fl9loS/5XObAVcsChUJAwSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RqJKcOIm; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RqJKcOIm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oD0JYTco4hkV+izVn2BMdzQ9NfWRfkcuXGFOenSXRlvnUIszxUxG4Lv2m0I+S4VzjJoQlloanzLUq2IADgTNtC5IUYW3L3TlMCYjtkuVMl6csflYGFNjdM14qSA/ylxms0A0agys1zJo8tmb83D24qL0XFISI2jbp/PfVlySja7nANTJj8JM8W/zUG7HeogAZmmBwufXYknXfsp/WU06AyKWsp5jyG4ry/G5iyjbzaQtR3ESE7ZeUUlvZXX6SnaTsTGLenMk1QL08/ydJMEpKhe/DPoTno7ZO33VqWLs4u4EgT3SAjNEkpKG97noAKUG/chkrr2zhPD1hg/y/pnb0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svwTYhNnGTeaBrpT8CabYazTVQv+jcD/zafmIctE+uA=;
 b=HaHol600vLa/Hkq3onzcgK+JF8uhBRN9fkWqSvsVbFf7hUQbmUUe/PLqmftQFJXKVhmCg+oBjpach7/WOKzf3cW584PoL0CPtvhorS6P25NiAVcWmej4IxrwjccDWGLzKh27rDnNqXe9dyk2se0cYVBY8PuDy57YxTrQFdkWaOQNu2nvY6txMwKiLriGIf2HQ4+Y4nBGCDlm6xkyhE4Fni2UT92peG7cJRWEhlpeC0tr04UBh2cRbhXZBuhpgvZS9EkQhha0i+/6rfGqYKs7uh/afYejTGDp+dyLdkGb9zBjkI0SImKR63suGOAijA8OFTgnWzyZlFKCzGUkEhDAXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svwTYhNnGTeaBrpT8CabYazTVQv+jcD/zafmIctE+uA=;
 b=RqJKcOImDGMQ2tPwE407XeWJ9TSW1VLeVePTMUINdUNwmHbEzFugQAkURmJcrl6lBKsptcZq+tjmTkrzlRsISoPITMvzwZdAhn765l8e28pIGvvYZ2IPneuo1FHvfhH0KdJatG7atOdYrc0b6U8ZfM+dMDVA1eCpqihuAet8aYw=
Received: from BN8PR04CA0056.namprd04.prod.outlook.com (2603:10b6:408:d4::30)
 by IA0PR12MB9046.namprd12.prod.outlook.com (2603:10b6:208:405::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 09:32:51 +0000
Received: from IA0PEPF0000003A.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::99) by BN8PR04CA0056.outlook.office365.com
 (2603:10b6:408:d4::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 09:32:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF0000003A.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:32:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:32:43 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 04:32:38 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 16 Oct 2026 15:02:01 +0530
Subject: [PATCH net-next v3 2/8] net: xilinx: tsn: add TSN endpoint wrapper
 driver
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261016-patches_v2_external-v3-2-e33d3960ca1e@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003A:EE_|IA0PR12MB9046:EE_
X-MS-Office365-Filtering-Correlation-Id: 013b99b1-4714-4911-21af-08df2b6872b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|7416014|36860700016|82310400026|921020|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MpwToTOe2zahyhktNUsVwuGh2sVDMZuCJRRAjQKFhqiE/sSaIwV5mEGnj0kvpxe/ivkM189Qw4eZ9ayOmk3D0AIy2rdD6yhYATlFidLNHZQIFB9/wDJz/TIn14YfkC1921a9nl56IXxHEjOZeHQMk4uhBOsC81Z27ybF0CrjcLzjbq+XYUKo2jgKlyMaeY3tC86neOCNTJrP6l1gMyogP8HycH9WhUoQ0eINcLmIbaUZCeYObPXWn54wgy9wsigQEipsGCmfXozAL5M8/EsVH9P89W+9u2SP0weTFLyNhi6oMzqp/C2ThEVyrl/dgUO7zQ9F95gYlHakJoD3OQT5Pz9uDZBihcI6tf3/9eRdO3y1yNBTVvfeT7wGdRELD57ZAGzBxxWK94I7p6bqg2FuEOEW4y//YOFyJopeNA2dkk17MBeZB3Y4Y6qt/NRbdK5A957Q5Af5jMMZEZCD5J2XvKV49WqQDGgdM2VHyIf3yu7mP5dIjcYKxzc7AHi2ht1qCdUIjP944Yt1GnSmL+HLs2yQ+RyJRgTDkeH1mf7hT8LmkwPxwARiRrejqzrl7XZT+oo7n12co48CDZVFmz3rmxMoF+/UCEwsunZN/GzUTJWuVMVmJxrGhTdF64oDEhJzat0J1P8wUoPR8DW2JozD47BwCWFI3mEfBJUMr5mBPeY4ue+Q9CWpcC5Pzboy/n+nc5jKfhdHcoys4wXrZeR9bu/pn35wTjbMmLdGSC7ha1VBxnYEnhQbxWgTwk+5FiN7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xFkn0uKHX00B7uX9WTPqD88atdM1L50wV3MP6sIslo3vI/i2p6nPiQKWT1AQNcJ1ZdVuCW6kx7PdJqnyWuUs29XHVebi42VLyihAwa7LST3liMVk6quf6oocmCKijP+5SI0aswMByrWL7Tekhb+bJFUqsrMPPe2Yb+c3FFI5ed2cKovfxmsE1P3puIedEuMKI4Pd2YRdFw8TsVOKD31p+5KE4Uy0AQi4lNAcJAp9PH4tq/TqcWB+Zb/fEkTpqWGbKt2iedkH1LlJ92rGqMvaRTsFYG5M3brj74qan2tJo0B7UruR9HhdVlZ+hqv0muaxMHP9AMfu0yd4T8GRuE4E0DCoSq9i4eg6MGrP1sPyVBaZEPt5J/lhL+9B7gUyYV/j69eN9BxIxRMVhWAp4QUtU9Wr8gskWLqnAYiAZxqHFPlOMqzpFHJUI/GhHf4k9sE5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:32:51.0543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 013b99b1-4714-4911-21af-08df2b6872b4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9046

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
index d579df0ad578..7cb61c16995d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29969,6 +29969,7 @@ M:	Srinivas Neeli <srinivas.neeli@amd.com>
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
2.44.4

