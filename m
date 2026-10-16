Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012011.outbound.protection.outlook.com [40.107.200.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA944471D0F
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143176; cv=fail; b=JIzkoPWPLiYxfZzk7889kaAdtYSfWSVxKUNTjMcNbt4pMTOi+t6yMRh+G8rlOWx/08mFTr2MUCuup51JgoRO3D1BFncs2sTX80Zf2j7eJ69+UbqP8cnhGfPXfYG1x6deP4XMTUfGoNPBvs9cFfeVOObsYELIThCW9ryNGtQTdVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143176; c=relaxed/simple;
	bh=8WKaQt/PATLI1gSkOC1l9mbLvWNHN3ASYKJ1hmS5zHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=QNf3aaXpuCcVDDKYvP8STYhlYDP6D5lJ/nkyrtdyujQIDdVQVclJXXpcgODgFw1YVoFal02Ny6OEy4AjqAs8Su4G1kuAN1/s7IvFl6UVUm+uqbgbvrt1bt+4m10o08DSr1yEhPhC930nA4a5KNaXiEoFc0ABtvZwGl44m+N7Mbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KU86yPYP; arc=fail smtp.client-ip=40.107.200.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KU86yPYP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bF0HJdTQrFBmStbfwRM5DjF7hrkE6KlTIVQVkIRpg44QXl0XE6mNqIZ0ZZgn3VNWlSt6HvCDCkc3ZfELq1iPQ7YWJO0JdIc3K9zXNlahcRJsZ2ctJQlqLoo5xEwL1qxEcCpVcyAYiZSfOUC+yU+OhI7f02koTm5T+hUUdewSZN//GVciG1qUaKQ4sJ+55BEQfgjhBcIcP2JymEgWYARb326eZqyZZ+vBSG0Ls8D7r2sIBoW5zBdAIimNm702ATkgqDWTzlJ83s5tDxJbmBGX5PLGvKfS0i6SWGpOdP31tHSZx5JiXMaGjPWN7IIUfGCONg7lHvpo2lnA9ieY7xtsIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ok8UX3Cw/WgIRV7Q9Chij+uQHHaJ2sGrpzrGBFQtT9A=;
 b=NXI686B/18kFZiWkt9vt2uck0nFvOloTt7C+LfRY8L59REwy5U3pGO656K5Gpk482GEqrm99hyRt+CPoGZpHSjfJNSXk6ZfML4458zmG6jDWzSw5GJ+jOULn5UO83BKaPaY1Qnw16w5irOoXE+odi83kRGWKHBAYC7zdSUn1kk58UElgwZbvUG3IF2fCDXCuq1vzkJpxujdctYeOr8dQBXIBlyvBaW7NVgQ+gjBIJn5O3KINvF8XsMFzYVynWfyeIWQUxGiqxWCE8ZZz8/v1fBPakX5iCX1Y8F9+YgEGRIQaQDxlQvMy7kwY22gpMo+Fw5OHklBIfiaHl38n4/Hv/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ok8UX3Cw/WgIRV7Q9Chij+uQHHaJ2sGrpzrGBFQtT9A=;
 b=KU86yPYPdf/LSV+KPmt5/EKtQAwNI1YEJOx00xQrYJE8fEd7CsbljDLqsY9wQhggm+MZzIzdJknGw6oZcHKFeAeRC+2MaftCGup1XrlQtWP1h4+FXbb3temLbQbMAUkcUSQu1WZXtBzUH/WAgRLpvFDVFl/z0JI8sEpveX10vV0=
Received: from SJ0PR05CA0028.namprd05.prod.outlook.com (2603:10b6:a03:33b::33)
 by PH7PR12MB7164.namprd12.prod.outlook.com (2603:10b6:510:203::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 09:32:46 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a5) by SJ0PR05CA0028.outlook.office365.com
 (2603:10b6:a03:33b::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 09:32:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:32:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:32:38 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 04:32:33 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 16 Oct 2026 15:02:00 +0530
Subject: [PATCH net-next v3 1/8] dt-bindings: net: add Xilinx TSN Endpoint
 Ethernet MAC
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261016-patches_v2_external-v3-1-e33d3960ca1e@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|PH7PR12MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c394742-73db-41fe-da53-08df2b686f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|36860700016|82310400026|376014|23010399003|921020|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	G8Al1Kn6BGp1H5gQ7eeocwD7oKh1pMdIxbAb1UyflKu2o6eivRffxVIw8eSt8AKWiXOs6xAQRB7TYdMFqsMfEUkpRy3l9NpUKzzC3nKy9NNQcZJBMzIYlqCmjeBIJkktjfGUtzvk77LBNiNwCZau//uLxKL+EAX9N2owMc31v35uLLCKTJtv18aCp3aVIsouEglbQjJWO7dMebOhcoR+4QTorbxesAzsr3mrLK/rVsCQCtHmbyb4OHuD4Gju6YECavJ39XFK8n53lGyACnqjn3h+xsSTQIjR8B0yUsAJlDXu2BC/ira2Op+v8tAFVRCe/nKCP2EzFoABTE/kwsuW7y8WVWi7YNIH6ybrtEouwYvSRrsVfC+SdWvDkkR8DotAz+QE3NTWXBqnDhhbFf4ExZlm+xkzXxkxbd21jRgZbE80Frje/1egVgbod0MMvJgCjzbs+/i47JVeLnuZIQy+8bsCNKNyO3uzC4nDfTdYr2rqJlx1aVUzPKoTIEIhkJoFzXYpjE3XA6My11vn8EXNhBWoNSDtBHGhwTdttgPM2F+c9FPuxL2ccjo18tW+HUOMEVxOROcabSOVTnXvU3zj3P8F9d+LjIsZz6m7jJdGGsXPeJktJoKscamp19luMo35v4G2UI4bh5LTLTHV7+2HtZb5Yk6ycBIhyfrQ1li01YRXGo9Ujfu3CZKvvTFTQxYS
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(36860700016)(82310400026)(376014)(23010399003)(921020)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RoyYXcz1EbIAdX0T5W89eJQuwxYI7ta3n7bKHWbJpQ+p4ypeFE/S2bbJH58cZnSF1gkqNblpyMqn7WewNMhqK9D3L3Umke+POjL9PIfjUhWrHJZan2HsJLSewhktBA/ouFHYfuZKQGYePo6vSlG9y1ZeAbcfX+dsh7ofhmEvkhu77qkY/LNWfEBJZLLo36OZNn4KjwYTzl88n6TQ3Qp1VlEGyNaxDUkOIHM+fGiFBBVYIQf5pdBtkKSYxqg6Ru1Bd7d+vD9mVZl45XkvZUHNnyO0FXv7bO2u9aNWCLfR/Yum8356TUxGk5aXyIg5Tm0TyPYQz/E4czhn7/EKL3xcG76LAJmnJYHRjnaHPA6O7uz3kWGE9ikE+h7EZvYOyPMMf9wDblNgoI5bxpRgJy1vBpGgUjcUIIv6EhPNkWfXtSbeIbRi8vSZctN5vs6mhzzt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:32:45.7371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c394742-73db-41fe-da53-08df2b686f96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7164

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
Changes in v3:
- Rename ports to ethernet-ports and port@0..2 to ethernet-port@0..2, the
  preferred names for a new binding.
- Require reg on the CPU ethernet-port@0. dsa_switch_parse_ports_of() reads reg
  from every port before classifying it, so a DT that omits reg on the CPU port
  passes dt_binding_check but fails switch registration.
- Pin reg to the unit address on the external ports. Replace the shared
  ^port@[1-2]$ subschema with literal ethernet-port@1 (reg const 1) and
  ethernet-port@2 (reg const 2), so the node name and reg value can no longer
  disagree and each MAC/MDIO binds to the intended port.
- Require queue0 in tx-queues-config. An empty node, or one without queue0,
  is now rejected at dt_binding_check. The logical queue index is dense from
  0, so queue0 is always present. The driver validates the full queue set.
- Add contains rules to dma-names so a TX-only or RX-only list no longer
  validates. At least one tx_chan and one rx_chan are required.
- Tie the queueN children to xlnx,num-priorities. tx-queues-config now
  requires queue0 and queue1, which hold for every allowed value, and for
  each value 3 to 8 the schema requires queue0 through queueN-1. A device
  tree with fewer queues than the IP has priorities is rejected at
  dt_binding_check.

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
 .../net/xlnx,tsn-endpoint-ethernet-mac.yaml        | 491 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 498 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
new file mode 100644
index 000000000000..bca834120b3b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
@@ -0,0 +1,491 @@
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
+        allOf:
+          - contains:
+              pattern: "^tx_chan[0-7]$"
+          - contains:
+              pattern: "^rx_chan[0-7]$"
+        description: |
+          Names matching the entries in 'dmas', one per DMA channel and in
+          the same order. TX channel names use "tx_chan<N>" and RX channel
+          names use "rx_chan<N>", where N is 0..7. At least one TX and one RX
+          channel are required. Example: "tx_chan0", "tx_chan1", ...,
+          "rx_chan0", "rx_chan1", ....
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
+        required:
+          - queue0
+          - queue1
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
+      ethernet-ports:
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
+          ethernet-port@0:
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
+              - reg
+              - ethernet
+
+          ethernet-port@1:
+            type: object
+            unevaluatedProperties: true
+            description:
+              External Ethernet port wired to MAC1, reached through the
+              mdio-1 bus.
+
+            properties:
+              reg:
+                const: 1
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
+          ethernet-port@2:
+            type: object
+            unevaluatedProperties: true
+            description:
+              External Ethernet port wired to MAC2, reached through the
+              mdio-2 bus.
+
+            properties:
+              reg:
+                const: 2
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
+          - ethernet-port@0
+          - ethernet-port@1
+          - ethernet-port@2
+
+    required:
+      - compatible
+      - reg
+      - reg-names
+      - interrupts
+      - interrupt-names
+      - ethernet-ports
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
+allOf:
+  - if:
+      properties:
+        xlnx,num-priorities:
+          const: 3
+    then:
+      patternProperties:
+        "^ethernet@[0-9a-f]+$":
+          properties:
+            tx-queues-config:
+              required:
+                - queue0
+                - queue1
+                - queue2
+
+  - if:
+      properties:
+        xlnx,num-priorities:
+          const: 4
+    then:
+      patternProperties:
+        "^ethernet@[0-9a-f]+$":
+          properties:
+            tx-queues-config:
+              required:
+                - queue0
+                - queue1
+                - queue2
+                - queue3
+
+  - if:
+      properties:
+        xlnx,num-priorities:
+          const: 5
+    then:
+      patternProperties:
+        "^ethernet@[0-9a-f]+$":
+          properties:
+            tx-queues-config:
+              required:
+                - queue0
+                - queue1
+                - queue2
+                - queue3
+                - queue4
+
+  - if:
+      properties:
+        xlnx,num-priorities:
+          const: 6
+    then:
+      patternProperties:
+        "^ethernet@[0-9a-f]+$":
+          properties:
+            tx-queues-config:
+              required:
+                - queue0
+                - queue1
+                - queue2
+                - queue3
+                - queue4
+                - queue5
+
+  - if:
+      properties:
+        xlnx,num-priorities:
+          const: 7
+    then:
+      patternProperties:
+        "^ethernet@[0-9a-f]+$":
+          properties:
+            tx-queues-config:
+              required:
+                - queue0
+                - queue1
+                - queue2
+                - queue3
+                - queue4
+                - queue5
+                - queue6
+
+  - if:
+      properties:
+        xlnx,num-priorities:
+          const: 8
+    then:
+      patternProperties:
+        "^ethernet@[0-9a-f]+$":
+          properties:
+            tx-queues-config:
+              required:
+                - queue0
+                - queue1
+                - queue2
+                - queue3
+                - queue4
+                - queue5
+                - queue6
+                - queue7
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
+                ethernet-port@0 {
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
+                ethernet-port@1 {
+                    reg = <1>;
+                    phy-handle = <&phy0>;
+                    phy-mode = "rgmii-id";
+                };
+
+                ethernet-port@2 {
+                    reg = <2>;
+                    phy-handle = <&phy1>;
+                    phy-mode = "rgmii-id";
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 72ca3aab2106..d579df0ad578 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29963,6 +29963,13 @@ M:	Harsh Jain <h.jain@amd.com>
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
2.44.4

