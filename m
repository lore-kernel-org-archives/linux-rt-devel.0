Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794513199;
	b=tfKp8cQNelVd4V167TAf8yboahoC2MafPVX3cvUYS8PZyrOJN2pIpfvCpD5wyvs/ceQ9
	 HXICB6BvDNx6IYWQdRovVRtK2hMHPfAqhy4IBd7VNxm4OYdIsvHS6IW9UlRVr0ODzoMUO
	 06XVQpABeupnb/nQG4WrRkcQ6LQdMKCKOhn5Gqd7Ir2aXTzKxJ8Rj2RRzFQ0GAe2HvR8Z
	 hf+dmmOyLtEXj2riJNGYKMrGlhUDB1g54hSw2/qANVqFjx/IjUVcdiX5VdDLB6rlqvXTb
	 hsXwgUNothfsrtuPsKEgXAfaBxvy9IDtAM6rVIN6ZhHqiZTIUUqTZN8L0ir3jHz9eMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794513199;
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
	bh=29R05VH5Y4/K9A+0U43YHRXTFG/IR621ypMLaZzADxo=;
	b=lyS9Pz7ccXhN7l8fVG2P+PfqfcT1QVyfHRq79YRoDy/Bx/+zmCRE1dCRSfOEucjAKpxf
	 gaU09L6fjJN1arS56+H3czwAX4E5NSmkd/jv3X1keaR+dq+ulyuEsirD9cF3LkmkNOFta
	 KPd+NmQK+i4kOL6QI+481nFJMwbvPNdyi/C2eP7jZmm5vP1iRjSFYNLJ61LSqx9Dsj9FQ
	 sHf+Z2HQl0nr8ERvt2jcnT8yMR/opZw7EB6UwhRLIWLKOU5cUkstWqVrRncZMuHkmuFpW
	 s8pSpzPeCzPCIx70Lgl7ubMHKzz32YrO2JUczPSrrzexuCUHdUBhFrLiuMtatnPg0rQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="U3ZWby/E";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.66
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB4660A2606
	for <linux-rt-devel@lists.linux.dev>; Thu, 12 Nov 2026 19:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ABB4660A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=U3ZWby/E
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzAugoITDNOLPZA2YQ5fR6y800QRzOZ8TmS59YeYpbQ5/vhLg2HU/jMWyGjVD6xS9EOkBYzW3hZp6bKtxDh4Nt6VPPw36y78ECFXiNva31ZgvEJD9gZXlY4t2OpdySqIjXYq/C0Z2Rz8OWpOqJsM8dL/7gSsCDGkp0o73nejhle9r06iwDqmuRieegB+1NIDKTM7/iV1NfGnr1JnxcPXUYc2GP2eoPM96Zd266vRly1yKix6GjxjPIFwOtnL5kYXzyrzdYUArwcauHu8Gy5Fcj7mM0HEaCB5OfWjQ/y2fuDuCgIb/ggN44m0QJ5kfUFSHiBVfU9tCYV4XK8JGaJe4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29R05VH5Y4/K9A+0U43YHRXTFG/IR621ypMLaZzADxo=;
 b=RfBN4tixcSID8DqhHKXJg7H6kERZ0a14fQZ2SS5m18sFiTQkHRuy9eurhk585l3H62dN7jP+rMBIAkaBWRncLb8XCL4JATrlGMl+bDPncAwCb4XTfE4R6Dl49/KK/rWHh/7rhT9we0XfyapNIu4UaDXOIoeXWm6VDa6gwRLHDa+Qo+DBO6Nu37ELaA2oue+kb628PvaJwZw6LWYUGCzE2jS3fiumD4z6AIw6DpdIFZhD0cWwgm3CaJJKyOBX/LbZWv6ImLnGFzAtm8pGmWAMY+my9Hm0it7rMKTyNazH9MuQOrUuIXV7SF5ktv/p8itq6FdGwA9AD7PVyPJf+XvWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29R05VH5Y4/K9A+0U43YHRXTFG/IR621ypMLaZzADxo=;
 b=U3ZWby/EqgBxlvB+JNAXbGLRHeI4T09Y51UA+ILiDKrBtCRyZjXwO/l27HRuWbs16VOZynyK9cjONvVyBcTaKTrDQ19MYTuWmYEjz57ZBPAYEp1HmP1aIiLnyANq0K+xVWjz8Re1onOMFAmNkhcdCoIS4DAQUjG6QlbLEIFkmUM=
Received: from CH0PR03CA0022.namprd03.prod.outlook.com (2603:10b6:610:b0::27)
 by LVUPR12MB999159.namprd12.prod.outlook.com (2603:10b6:408:3a4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 19:53:11 +0000
Received: from CO1PEPF00018868.namprd03.prod.outlook.com
 (2603:10b6:610:b0:cafe::4c) by CH0PR03CA0022.outlook.office365.com
 (2603:10b6:610:b0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Thu,
 12 Nov 2026 19:52:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00018868.mail.protection.outlook.com (10.167.249.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 19:52:47 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:22 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:21 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 12:47:16 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 13 Nov 2026 00:16:46 +0530
Subject: [PATCH net-next v4 2/8] net: xilinx: tsn: add TSN endpoint wrapper
 driver
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
Message-ID: <20261113-patches_v2_external-v4-2-56bb26f042a4@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00018868:EE_|LVUPR12MB999159:EE_
X-MS-Office365-Filtering-Correlation-Id: af6dcf59-1dcd-4fa2-3b91-08df40f686fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|921020|10067099003|11063799006|56012099006|261022075727099003|261026121527099003|261026140227099003|261022105027099003|261021121427099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	PuV4/+8U/z3cgw1zfk4CHyBDjQ+EiV7OrNG04Edih47JlzCl4szpt+yd82jeuUh3Emq7UV4h9X0hReamhz3szdy6gbUTNq0OMM5kNKZzQqxalxEwwTUUhfx/2lB7WoRPWGG5y5hxTGGfdn2RD/iBWiIS6tZQKzEb/juB3hzn4xDVIvR4RKOl7j4uYOPNhkrR5N5KCva2wIMBgmBGfsRRencnuuVd2j+iNiEEVL8RdUhcvpp6FEocllTc9Dl8sQDPDy85H2QQeKY7w1bieJMxlWbCbH1NDIAqoSgPvBUiT0q9xbPOqFx+L6FxuVcbe4cCAaHu5b52UqwnS8JkqYWiMiAgzPUgBNEPNVGbsjj+Bm/0oS7xYrZ7jWKp04EcB5QMM7O7t1m7KA9Zf+MopKxoLBKZhV5k2KY/zzLGN6oYKEkUQUmMTblggrXRTCW/JyZFMZKK/vInTqP9ebunFfZjrgel3+9NU7V43GhZzAeHRBR8zOlpMXP8EQ1UYV/vLXF3tchh6bv15RX3s8KQdNrlbecbXB4V8ZvI0xfhwrYg3F+7LjispOTOUv770yBYGzj9cholVYXaS+h7OY3FtbdGYOLRa7UnhsNrxG+15c3kMlQyiAjbmyn4NrUxmfZbzOHXhOwEJ42BjAfwBPGfiTOIL9aBYY3GmxrEfzgr1+3t6gY1dFCDvz205T4ELC1JBwWalVvpMkRjGLHyTEp31he9cWn0zMekL3ROmvWYaP7fgkguTuW1U5fw6aoeLtybuWg49qnhbpGSLUsw+U52nqFt+A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(921020)(10067099003)(11063799006)(56012099006)(261022075727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021121427099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pEV/o2Ndkk0GyMHOorZAJNoxbel7TQnHz5tS9T+/hCEO8db1WXANKcL7f/2TbTtOsQXuof2oi+EoM4+DGxMdFYtwezvIoALHatcTWDYr9nV4F5tNCiLYNMuKEKEP+xW1L/IYS26uMaHal/FW8NxtYphH/sdq12rz0N8scOlRxu73yAXK9i6VkxaUDfhpnsdOD2JPN+E1d+HKAdeqYFvdlXfVHpmYKPr+4ajp3ykAp5i9HDR0bPj9mzEYjifojMoqBbdykLl/CeADKeCLI4S9W0cQTURDVJ5SvmrGJbrHCpngUCmzRL2gXSManeM+fi48NjS6/cbt6Q5RfInICCKTfDW4wIjSrRiUIiCXSCDEgYYGUmBzD3EcTxk/pTxEn5xPzJ5cGVgpA7l2T3fZmBkytFXkYYQTkRYUo7oCgqFPglgF4xPmsszFtgfCd93lYpzR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 19:52:47.9455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af6dcf59-1dcd-4fa2-3b91-08df40f686fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00018868.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999159

The TSN Endpoint Ethernet MAC IP groups several sub-nodes under one IP
node with a set of IP-wide clocks. Each sub-node needs its own driver,
and the shared clocks must be running before any of them probe.

Add a thin wrapper platform driver for the IP node. Enable the IP-wide
clocks from the device tree and bind each sub-node to its own driver.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v4:
- Drop the Kconfig reference to a companion DSA driver that is not in
  this series.

Changes in v2:
- Depend on OF_ADDRESS instead of OF && HAS_IOMEM.
- Point the Kconfig help text at the companion DSA driver, not a symbol that
  does not exist yet at this patch.
- Drop the mod_devicetable.h include, platform_device.h already pulls it in.
---
 MAINTAINERS                                       |   1 +
 drivers/net/ethernet/xilinx/Kconfig               |   1 +
 drivers/net/ethernet/xilinx/Makefile              |   1 +
 drivers/net/ethernet/xilinx/tsn/Kconfig           |  14 +++
 drivers/net/ethernet/xilinx/tsn/Makefile          |   2 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c | 104 ++++++++++++++++++++++
 6 files changed, 123 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6e71049322df..27f42178c12d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30748,6 +30748,7 @@ M:	Srinivas Neeli <srinivas.neeli@amd.com>
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
index 000000000000..3164d1ce7caa
--- /dev/null
+++ b/drivers/net/ethernet/xilinx/tsn/Kconfig
@@ -0,0 +1,14 @@
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
+	  and the endpoint MAC that connects the IP to the host CPU.
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

