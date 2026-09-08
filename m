Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F675A5156
	for <linux-rt-devel@lists.linux.dev>; Tue,  8 Sep 2026 19:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895238; cv=fail; b=VVuav6HISe/Z2AWteFU8L+ejKzHfbR87YCq7shN0gQktRN0UrYyzbN2Dods6RzfD+Nw00zcQ1lAGNfNVU8kQYHGUN4pDZJl3oLZv5K1oE7CbKVuSCYzYCXlylbEX0VKZHI5sXgqQosLaEajadAlb/xnLuuX8IJ0nii2nljWq0ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895238; c=relaxed/simple;
	bh=jxpZUFi1pLUstJFuhWfFCT/HrPdrycPS3s0541fZkSs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=f4kOk/ZmAZYKYFZBUaHb8aSIYMOxnozSHYfDIUbWNGFA8Y8Xnf/sTissIoDUNHYFOIAEr8dDZ7jOrqpc5UopDlnl8pDPSQPK5TQwTHVJQU45sXZxfZv+b1oS+bCXol9QEy4/tlWnkLayHEem1vrzTB1oGyVZDPnGGmwliF1Nt50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ti7Lzokq; arc=fail smtp.client-ip=52.101.193.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ti7Lzokq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xB0jfODAHvNCZhYTMVsje0C6iXn8bEZLMU/ho7aA72pgzCgTepOg1o209UlxrhiDMI9f6rot91YowUhYYeq0QhPpftTs2ecMw1noGD8noVOmKuTLr2ecTe6B/i3jlXCkBAJiPp6Ryyn3cvJxLXg9GeuxnvK6XE9PZ8m+XKhEbz7KuHiAD3vr6t74TzPJwqnTsXxVSV/HbQJkkt5ZKriU5q2wVLzLqwv1qzPwbVIYqOlLn3gsu6QUkmN5sInJDp5Pbvj4ttk6zmCjjgUfnRLIMvc2pv7PGIlH1c0ckn8Sq32NKjoLObTJpAnK1JAA6MtEEz3M2fsOB79buvTEAqIbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThY4sqM3tnCtIq7Zxt55MKEZVmWctee2/Iw2F/FvSCI=;
 b=DZFlsQKHKJCyce0D8ocKnsyjrh2uHV1tPy0rCVFJM/y8Bqdat5V+oKbzA6NB+4CbYIlbh3ezr3Pp6F6Bw1JKTb3aGtfCJlQ1vAhiOBCpeyo4hEjXgksruZg12QbY+uHYZuFZE+V6sbeqLBg9VsNxW9CJ8hEvJcHpjqKxXzm9/1/669LS56CdzvcWm2tr/dqvHescO3Fy88zY9W1F/HZwsRXkNaf6+81ehKYrY9RxjgIT3e4fBDss+0SHWIuKCuJGsrBKyYhSUXuVDnccSZW/vFxbUx7h/a7uZR/QpjGgRGJhnwG77xf+RuGDU8716f23nSROPaAzK3U9mVywisXHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThY4sqM3tnCtIq7Zxt55MKEZVmWctee2/Iw2F/FvSCI=;
 b=Ti7LzokqlKLTPUiXZ8Gba0p7fxRZj5GNIGWQ8IAc+WaM7c17Pku+IUZ/GtO8SJ+f/QsNW5HF2yaQ6svEYsnpsCyPx+iqBUmu5RhSJX8ylM/ioUgXduUXjMUE2fK0nnB2ImwH5wZ6FXzKLUPROKX2AUuclkXCM2G/5bNHP2wXZtw=
Received: from SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::9)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Tue, 8 Sep
 2026 19:20:24 +0000
Received: from SN1PEPF00036F42.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::ae) by SJ0P220CA0004.outlook.office365.com
 (2603:10b6:a03:41b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 19:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F42.mail.protection.outlook.com (10.167.248.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:20:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:13 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 14:20:08 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Wed, 9 Sep 2026 00:49:49 +0530
Subject: [PATCH net-next v2 1/8] dt-bindings: net: add Xilinx TSN Endpoint
 Ethernet MAC
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260909-patches_v2_external-v2-1-3a40babaff4c@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F42:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: dc50e3ae-cfbc-492c-36f7-08df0dde3b8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|36860700016|1800799024|82310400026|13003099007|921020|6133799003|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	siOCdeFkSDibUp0xIdeXjFFYhYiTFrybA5tnWiplLBHOo7OA1LbFJWQS1kGu3Csyyb04J3AlW9mFUp9jBZ81GthWLuHOPbA+Wm5HqS+1JZ6TRMO1PHJqFMwPc2qO57rge73HCSa0BdQ/JwPfstQQ5AwetujUF55TMALkdQsZdnX1xDKZsrvStZUhxF2h3dECU8/7H+fMYLtc9gWyJsuG8/clhjh7k0epPoPzsQc2ZKhdNvCxNWQJNnmCxSfcW2UmypdpiOZn2uukgLpYZshZUclIDI/48FPoLhpem5QPAJnLMj+gwebAcwdhrzUiH82ExbtYdlvLVMkLHNd1O57dxLAGx/lEDOXbR17TR7ihMZBqoHxMH6Bwy3IJPxU2gYz77ge4ho7acke46HkTMPWcgdURI3bsrzADFOBh7wsyj9fwB5MKpKxloNYEvCQHrauY083vnJpAoNQ9Toch3oR1BjtBbmwJlGxRXUU+zn1yjELdPrStDRwQCYmrTNK1M5JpeTcMvor5tk3PBK4xcIsS3/G6O3PhdL1rWHLvcSgNE029ubcTOfvddQf2AhWGaPYrIrGksa76kIOyYR1+/R5GI5oHEFiP8om/aasqxFx2luxmUuBhQC/N7/5ra98GVYjnZ4G+xijNSaXG3sKnL2JtFjAV3z48Gh4n8SOUrbIl8BwX2f0G5HWfmnJEz94gQzRP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(36860700016)(1800799024)(82310400026)(13003099007)(921020)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6K03ikTlLAiuKB0n2mkXFMvYTKPnxBZxrwd2qyE5uN7ob13hTn8IKG5p+7iDrfJlZmo5djdRX03y/pZw1QBjLtPnmrLOAtAxRUKwl4FMqKQxkVHSlfKS9ibBocVZzT94dQNz1KOno5GnOaKGrv5tGcJj/RPKIkWvfGN8OQ8SBJc0QLpa9rKKct/XaBsNzVCjoiBzmQMNrk83TVVd6b0okHuzF7btFCfVbRFDhAj/fu9h3AUoKHMoEWXgyuephxQDzdZYik0jyGPftFiPgCRqLlmkVkkFLirnZYQzN0S3uaapFD0ZAhwMWb6xoiHp1fWw1adTr3NbWew+Fbs8XnbelihQ5lovADHlmyH498kW8B+SliZlJpamnhepdxwV0YHRtskmimb84gN8g7SNTwZSSRIrQdqM0moIRjPl7Cf4YqmLgmEuKf36sdVP+owgLpWC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:20:24.2149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc50e3ae-cfbc-492c-36f7-08df0dde3b8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F42.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203

Add a binding for the Xilinx TSN Endpoint Ethernet MAC IP. The
top-level node describes the IP wrapper, which owns the six shared
IP clocks and the xlnx,num-priorities parameter, and has two
children:

  - xlnx,tsn-ep-mac: the endpoint MAC, owning the host-side DMA
    channels (dmas / dma-names / tx-queues-config).

  - xlnx,tsn-switch: the three-port Ethernet switch covering the
    switch fabric and the two per-MAC register windows. The MDIO
    controllers and PTP register blocks sit at fixed offsets inside
    the per-MAC windows, accessed through the mdio-1 / mdio-2
    children and per-MAC interrupt-names entries. Each external
    port@N references its PHY through a phy-handle in the matching
    mdio-<N> child.

Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

---
Changes in v2:
- Describe only the Bridged Endpoint configuration. The IP has so far been
  simulated only as a bridged endpoint, so the binding and driver describe
  that configuration alone. Support for an Endpoint-only design will be added
  once that IP variant is simulated.
- Rename ep-mac@ to ethernet@ and mdio-mac1/mdio-mac2 to mdio-1/mdio-2, and
  anchor the node names (^ethernet@[0-9a-f]+$, ^switch@[0-9a-f]+$), per
  ethernet-controller.yaml and mdio.yaml.
- Cap TX at 8 and RX at 8 channels. The IP exposes 8 priorities, so it
  drives at most 8 TX and 8 RX MCDMA channels. dma-names lists both
  directions, so its combined maxItems is 16 (8 TX + 8 RX). V1 allowed up
  to 16 per direction, which the hardware cannot use.
- Set additionalProperties: false on tx-queues-config and its queue nodes.
- Drop reg from the wrapper node. It has no registers of its own, ranges
  already describes the child windows.
- Add minItems: 7 to the switch interrupts to match interrupt-names.
- Use a ^(ethernet-)?ports$ container with additionalProperties: false and its
  own #address-cells/#size-cells, and require either ports or ethernet-ports.
- Require ethernet on the CPU port@0.
- Add reg (enum [1, 2]) on the external port@[1-2] ports and require reg,
  phy-mode and phy-handle. MAC1 and MAC2 use gmii/rgmii/rgmii-id.
- Require port@0, port@1 and port@2. The IP is a fixed three-port bridged
  design (port@0 CPU, port@1 MAC1, port@2 MAC2), so a device tree missing
  any of them cannot describe working hardware.
- Add #address-cells and #size-cells (both const 1) on the wrapper node,
  which the child ethernet@/switch@ windows need now that reg is dropped,
  and set unevaluatedProperties: false on the endpoint node.
---
 .../net/xlnx,tsn-endpoint-ethernet-mac.yaml        | 364 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 371 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
new file mode 100644
index 000000000000..4e65d1710da7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
@@ -0,0 +1,364 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/xlnx,tsn-endpoint-ethernet-mac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx TSN Endpoint Ethernet MAC
+
+description:
+  TSN Endpoint Ethernet MAC IP implements IEEE 802.1 Time-Sensitive
+  Networking (TSN) standards and provides low-latency network connectivity
+  in the Bridged Endpoint configuration. The IP integrates a three-port
+  switch, with two ports connected to the external network and one port
+  connected to an internal endpoint. It also supports GMII/RGMII interfaces
+  for connection to an external PHY, enabling full-duplex operation at
+  100 Mb/s and 1 Gb/s speeds.
+
+maintainers:
+  - Srinivas Neeli <srinivas.neeli@amd.com>
+  - Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
+
+properties:
+  compatible:
+    const: xlnx,tsn-endpoint-ethernet-mac-3.0
+
+  clocks:
+    items:
+      - description: GTX clock for transmitter logic and RTC
+      - description: GTX 90-degree phase shifted clock for RGMII
+      - description: Host RX FIFO clock
+      - description: Host TX FIFO clock
+      - description: Reference clock for IDELAY control
+      - description: AXI-Lite register interface clock
+
+  clock-names:
+    items:
+      - const: gtx
+      - const: gtx90
+      - const: host_rxfifo
+      - const: host_txfifo
+      - const: ref
+      - const: s_axi
+
+  ranges: true
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  xlnx,num-priorities:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 2
+    maximum: 8
+    description:
+      Number of traffic classes (priorities) configured in the IP.
+      This is an IP configuration parameter that determines the number of
+      priority queues available for QoS scheduling. Traffic classes map to
+      IEEE 802.1Q priority levels (0-7).
+
+patternProperties:
+  "^ethernet@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/net/ethernet-controller.yaml#
+    unevaluatedProperties: false
+    description:
+      Endpoint MAC sub-node. Provides the host-side data path through the
+      DMA channels described by its dmas / dma-names.
+    properties:
+      compatible:
+        const: xlnx,tsn-ep-mac
+
+      reg:
+        maxItems: 1
+
+      dmas:
+        minItems: 2
+        maxItems: 16
+
+      dma-names:
+        minItems: 2
+        maxItems: 16
+        items:
+          pattern: "^(tx|rx)_chan[0-7]$"
+        description: |
+          Names matching the entries in 'dmas', one per DMA channel and in
+          the same order. TX channel names use "tx_chan<N>" and RX channel
+          names use "rx_chan<N>", where N is 0..7. Example: "tx_chan0",
+          "tx_chan1", ..., "rx_chan0", "rx_chan1", ....
+
+      tx-queues-config:
+        type: object
+        additionalProperties: false
+        description:
+          TX queue configuration node that maps IP priority queues to
+          DMA TX channels. The TSN IP supports multiple priority queues for
+          QoS scheduling, and each queue can be connected to a specific DMA
+          channel. This mapping defines which DMA TX channel is used to
+          transmit packets for each priority queue. For example, queue0
+          with xlnx,dma-channel-num set to 5 means priority queue 0 uses
+          tx_chan5 for data transfer.
+
+        patternProperties:
+          "^queue[0-7]$":
+            type: object
+            additionalProperties: false
+
+            description:
+              Each subnode represents a priority queue. The
+              xlnx,dma-channel-num property specifies which DMA TX channel
+              (tx_chan0 to tx_chan7) is connected to this queue for
+              transmitting packets.
+            properties:
+              xlnx,dma-channel-num:
+                $ref: /schemas/types.yaml#/definitions/uint32
+                description:
+                  DMA channel that transmits this priority queue, given as
+                  the N of the tx_chanN entry in dma-names.
+                minimum: 0
+                maximum: 7
+
+            required:
+              - xlnx,dma-channel-num
+
+    required:
+      - compatible
+      - reg
+      - dmas
+      - dma-names
+      - tx-queues-config
+
+  "^switch@[0-9a-f]+$":
+    type: object
+    $ref: /schemas/net/dsa/dsa.yaml#/$defs/ethernet-ports
+    description:
+      Three-port Ethernet switch sub-node. Contains the switch fabric
+      register window and the two per-MAC register windows. Each per-MAC
+      window houses an MDIO controller and a PTP register block at fixed
+      offsets. The IP's per-MAC and PTP-timer interrupts are exposed here.
+
+    properties:
+      compatible:
+        const: xlnx,tsn-switch
+
+      reg:
+        items:
+          - description: Switch fabric register window
+          - description: MAC1 register window (includes MDIO and PTP)
+          - description: MAC2 register window (includes MDIO and PTP)
+
+      reg-names:
+        items:
+          - const: switch
+          - const: mac1
+          - const: mac2
+
+      interrupts:
+        minItems: 7
+        maxItems: 7
+
+      interrupt-names:
+        items:
+          - const: ptp_rx_mac1
+          - const: ptp_tx_mac1
+          - const: mac_irq_mac1
+          - const: ptp_timer
+          - const: ptp_rx_mac2
+          - const: ptp_tx_mac2
+          - const: mac_irq_mac2
+
+      mdio-1:
+        $ref: /schemas/net/mdio.yaml#
+        description:
+          MDIO bus controller for MAC1. Registers reside inside the mac1
+          reg-names window.
+        unevaluatedProperties: false
+
+      mdio-2:
+        $ref: /schemas/net/mdio.yaml#
+        description:
+          MDIO bus controller for MAC2. Registers reside inside the mac2
+          reg-names window.
+        unevaluatedProperties: false
+
+    patternProperties:
+      "^(ethernet-)?ports$":
+        type: object
+        additionalProperties: false
+
+        properties:
+          '#address-cells':
+            const: 1
+
+          '#size-cells':
+            const: 0
+
+          port@0:
+            type: object
+            unevaluatedProperties: true
+            description:
+              CPU port. Wired internally to the endpoint MAC sibling.
+
+            properties:
+              reg:
+                const: 0
+
+              phy-mode:
+                const: internal
+
+            required:
+              - ethernet
+
+        patternProperties:
+          "^port@[1-2]$":
+            type: object
+            unevaluatedProperties: true
+            description:
+              External Ethernet port. port@1 is wired to MAC1 and reached
+              through the mdio-1 bus, port@2 is wired to MAC2 and reached
+              through the mdio-2 bus.
+
+            properties:
+              reg:
+                enum: [1, 2]
+
+              phy-mode:
+                enum:
+                  - gmii
+                  - rgmii
+                  - rgmii-id
+
+            required:
+              - reg
+              - phy-mode
+              - phy-handle
+
+        required:
+          - port@0
+          - port@1
+          - port@2
+
+    required:
+      - compatible
+      - reg
+      - reg-names
+      - interrupts
+      - interrupt-names
+
+    oneOf:
+      - required: [ports]
+      - required: [ethernet-ports]
+
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - xlnx,num-priorities
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+
+examples:
+  - |
+    tsn@80040000 {
+        compatible = "xlnx,tsn-endpoint-ethernet-mac-3.0";
+        clocks = <&misc_clk_2>, <&misc_clk_2>, <&misc_clk_1>, <&misc_clk_1>,
+                 <&misc_clk_3>, <&misc_clk_0>;
+        clock-names = "gtx", "gtx90", "host_rxfifo", "host_txfifo",
+                      "ref", "s_axi";
+        xlnx,num-priorities = <8>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges = <0x0 0x80040000 0x40000>;
+
+        ep_mac: ethernet@16000 {
+            compatible = "xlnx,tsn-ep-mac";
+            reg = <0x16000 0xa000>;
+            dmas = <&axi_mcdma_0 0>, <&axi_mcdma_0 1>, <&axi_mcdma_0 2>,
+                   <&axi_mcdma_0 3>, <&axi_mcdma_0 4>, <&axi_mcdma_0 5>,
+                   <&axi_mcdma_0 6>, <&axi_mcdma_0 7>, <&axi_mcdma_0 16>,
+                   <&axi_mcdma_0 17>, <&axi_mcdma_0 18>, <&axi_mcdma_0 19>,
+                   <&axi_mcdma_0 20>, <&axi_mcdma_0 21>, <&axi_mcdma_0 22>,
+                   <&axi_mcdma_0 23>;
+            dma-names = "tx_chan0", "tx_chan1", "tx_chan2", "tx_chan3",
+                        "tx_chan4", "tx_chan5", "tx_chan6", "tx_chan7",
+                        "rx_chan0", "rx_chan1", "rx_chan2", "rx_chan3",
+                        "rx_chan4", "rx_chan5", "rx_chan6", "rx_chan7";
+            tx-queues-config {
+                queue0 { xlnx,dma-channel-num = <0x7>; };
+                queue1 { xlnx,dma-channel-num = <0x6>; };
+                queue2 { xlnx,dma-channel-num = <0x5>; };
+                queue3 { xlnx,dma-channel-num = <0x4>; };
+                queue4 { xlnx,dma-channel-num = <0x3>; };
+                queue5 { xlnx,dma-channel-num = <0x2>; };
+                queue6 { xlnx,dma-channel-num = <0x1>; };
+                queue7 { xlnx,dma-channel-num = <0x0>; };
+            };
+        };
+
+        switch@38000 {
+            compatible = "xlnx,tsn-switch";
+            reg = <0x38000 0x8000>,
+                  <0x00000 0x14000>,
+                  <0x20000 0x14000>;
+            reg-names = "switch", "mac1", "mac2";
+
+            interrupt-parent = <&intc>;
+            interrupts = <0 2>, <2 2>, <4 2>, <6 2>,
+                         <1 2>, <3 2>, <5 2>;
+            interrupt-names = "ptp_rx_mac1", "ptp_tx_mac1",
+                              "mac_irq_mac1", "ptp_timer",
+                              "ptp_rx_mac2", "ptp_tx_mac2",
+                              "mac_irq_mac2";
+
+            mdio-1 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                phy0: ethernet-phy@0 {
+                    reg = <0>;
+                };
+            };
+
+            mdio-2 {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                phy1: ethernet-phy@1 {
+                    reg = <1>;
+                };
+            };
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    ethernet = <&ep_mac>;
+                    phy-mode = "internal";
+
+                    fixed-link {
+                        speed = <1000>;
+                        full-duplex;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    phy-handle = <&phy0>;
+                    phy-mode = "rgmii-id";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    phy-handle = <&phy1>;
+                    phy-mode = "rgmii-id";
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index b23fb6f2f4ef..8f93f165a744 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29911,6 +29911,13 @@ M:	Harsh Jain <h.jain@amd.com>
 S:	Maintained
 F:	drivers/char/hw_random/xilinx-trng.c
 
+XILINX TSN ENDPOINT ETHERNET MAC DRIVER
+M:	Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
+M:	Srinivas Neeli <srinivas.neeli@amd.com>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
+
 XILINX UARTLITE SERIAL DRIVER
 M:	Peter Korsgaard <jacmet@sunsite.dk>
 L:	linux-serial@vger.kernel.org

-- 
2.43.0

