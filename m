Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.70
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794571293;
	b=R8c52uptqBp80aKjPVlVFfQXHOyzZaiY4JE9p6M7aqMGzMOpwWnaJdc0jFnXjjgIknvq
	 hNQH1FW5+czw7wjCc9UXRC+rLBK/h0Y3ih/KyRxy+YsAnA0u2/ixWzceMfvYjObJ64Rmd
	 jmk/N05ZTqKKKPLkHxziXsOyVtaXG6IgnP8vG1jdkVNRJmCGIvwPhzrcRf+hkTSADmYmi
	 GGzP+8gkVHDVNmxV8xiFQ+qN1P5RpLuS4RpzHTcziFR8RnucN9+JUNEobqgHWyD7nk4gX
	 otPgJDpuvWUuQ817VJeo3MBBtDYyMnlOgR9WuHThTIzHy0G6OTo7bBbJDPefsqMLCvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571293;
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
	bh=eV/gi3p8QD+J0jU/yTFip0aizZUD3zkeIXu4tj4WtZA=;
	b=BAIRzcdmKdxh5jHYrcxrucqJXQBZs22Ou4IS+8esB+60QKJ6rkk2vvCLR0YDAclfFAcT
	 9XXPyxTNWmuirDbRyCoh9m/nfAKv/7v/63uBO9nXm17CdZGdySTbS6QShK7mwWtpmUfst
	 Uu8MDeI8mY+aQWqmhXPU8G4ES0FeLCQv4u4BodCFjVjn+hRA5/cyHtRyKNTfrtQ4TQ/Ax
	 h8HR1qKnrAZqSPXE6lK+npGVyNKmCGb7earxGAOvHQolICDFsQJ+fZRgYDEq/ORm0b1e0
	 bp/dvko3R4FpUjhiwLQycRtZnEf2xEX1uOVjoCMxBlSEvJt91FL5xK//YxRhqxviX3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mrO90zkq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.70
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013070.outbound.protection.outlook.com [40.93.196.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F927606A321
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 12:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F927606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mrO90zkq
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKC/id6dyKmxQG6o6rfBHqz8OpVbQhRfcFD8Z0xotMuCC/t39m2gH82yYY5fJt5piskJOTW32zrR2mrMVUXpn/r/L1MdEZ50QUt5SbF8BKoJq8o+UAs+CpNf+DgxEcG/xOAi4LqryWCxKsiVDq2Ww9bPlcYdchz+Hta4w4ckvZM0DdlLsZyIUoiIl94gf/JWrxzMTrdOJmUFnDzZc0UeM8gyiijXWLMBxHcNWUB9ALfnVDXfVXbH3NQxzKE/LbdoTRj9ZVU6qNguz9hq8yOl2vA7Hd9iVIBMCZBk244XywRw8N494Z52DZTC26jJzNhrFj5h+6tKFiv3/5OKCjLgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eV/gi3p8QD+J0jU/yTFip0aizZUD3zkeIXu4tj4WtZA=;
 b=ls1zf3H1ldWOqIPhIKM24z8aY2Gj27myc0eDnYnRTcvdmlRvjjQ+NbRpHpbYJ1t9DVx/KfA7px0ZO+5LfrEcDN9dPemt1Ug+fIKp7Ew6/17rjtiNGrigMjro3SLVvFb246gK/xIl3/HkuD2IvAx2cB/pq5k419I3qPf0TWeEmc4bJQnBhXRvkXyY4KzQ45OnlyYck9ojN9IgP3XDhg40Ie1HWmrokVBI6jVT/6bgQzodmwUv0lRu5bVmPyEeMXfWa3O6h9+BQyseJfgYIndyQIEFHJxBuTZAh0vDAGcp5iVdlIMZAuT8qaYp9/MYbnjmJKxH8LCEKB31QyUDUvSApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eV/gi3p8QD+J0jU/yTFip0aizZUD3zkeIXu4tj4WtZA=;
 b=mrO90zkqwcJFslnoRv245D6VIiRcFRQj1oXCq/1u60R3gOTt5sTUrsXo3G2EmObGq4+Ol/zfnxaxFzIzK0gjIHKSdUXevizgWha9OvcDjePbbGGUNkwkJb4iVz3nRHDK7z1246FH1IgmYL5NB6kfZQTIOEFSkq2HiUOUUFmK38U=
Received: from CH5PR05CA0016.namprd05.prod.outlook.com (2603:10b6:610:1f0::21)
 by DS3PR12MB964154.namprd12.prod.outlook.com (2603:10b6:8:438::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 12:01:29 +0000
Received: from BN1PEPF0001854A.namprd05.prod.outlook.com
 (2603:10b6:610:1f0:cafe::72) by CH5PR05CA0016.outlook.office365.com
 (2603:10b6:610:1f0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Fri, 13
 Nov 2026 12:01:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0001854A.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 12:01:29 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:16 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 12:47:10 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
Date: Fri, 13 Nov 2026 00:16:45 +0530
Subject: [PATCH net-next v4 1/8] dt-bindings: net: add Xilinx TSN Endpoint
 Ethernet MAC
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
Message-ID: <20261113-patches_v2_external-v4-1-56bb26f042a4@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0001854A:EE_|DS3PR12MB964154:EE_
X-MS-Office365-Filtering-Correlation-Id: ef63c671-847d-465b-d01f-08df417dd9ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|7416014|261028144727099003|261026121527099003|261102123227099003|261026140227099003|261022075727099003|261021121427099003|921020|56012099006|11063799006|261021123027099003|261022105027099003|10067099003|22082099003|261009223027099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	PHLY2fACVmIjZLMcutikvpeQmueq/fGvxyU/aoOweVnB8eMbLVkRd7XOrR+RW78whryFazE7hLn69Q2SJAkVPh4qSEURApf8jM2UTldNKOdYwyyln9oobYINo1IShlZCUL0APJbqtG5RltNJzvqfP8Ix6UfIakdd/TsZ9suloSSPsxeHZ+XjBAGAEnL0qajZNAmscNbewT/wr8xnWFq+OjgYfLvJFBv7RPeX6QBU/tbTcuR6Hb9L0hVTq74snuawwIfk1Ry2DLAxwKsJ9A4QkMSLU1IWpY5zxk0h7Whaj9UNGy59OUOyfAWWOUxF0W51ggusDaLfAWiH0w8QAPO/rih8CVE2NpfrGQXlvQswPXt5oqYjtA2kZx+TAYXSwtSgWcW69/P1uXl8Al0mJvx3MapYC3+TVP38di+5ntS3dc5mSUr7upJCUn5AV/tI+zI7cFLCveZzGp2lflJ/aR1Wh83MtHP/YggSLGnJOmg0m/5HeIvGCCBzgYPHy+77kYwtVxgQeSoVp/UX3K9zGEcCo9URgnYRdoxr7i9sicSMfr3PrMGlzqmc6d3TG7oMCs07kJqyVCetPO72ARtJ0uvwY40ERCZL619ewn0ifc+7nB5MlG+lRMq9bY+zxJuy0XYupVlkY5kYA0pPyxzKRA9bnjF/DSe0H2///KB+EhVqSvFZVEaFF03Vrg+lH6bKy68d
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(7416014)(261028144727099003)(261026121527099003)(261102123227099003)(261026140227099003)(261022075727099003)(261021121427099003)(921020)(56012099006)(11063799006)(261021123027099003)(261022105027099003)(10067099003)(22082099003)(261009223027099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	c19bZ/xUxgJ/jquVGYpdOM6j3stKmUMvtv8YpK/7GRcKxVmEBlZK0/ggM1fn5DE7/rieotJBjaezH/qlwvNjn5ekI4ndq7rQJaaIK/ZHjm5DYfm6NYa6IPhdOdl6scQ4pV/2XaMWCs6MUmurRhljAzAArITdLyaM3Ni2jDVDiPucKuH/XtQ+L4i6IzXSqD447NiGdTqm2xM1aJmDBYVMQF9AIk5RSocS1z1t/+GnOnnxyTjxzKIWUgJZ7Xf//ddZGEHsBKZODH/rrPlnMIX6824DO5oHe+Wgk54+P3z11GhpIWXdTP48ZjA8/NO57bVd3FQnywUX4cJZ192MKz1Hnlx/R39wv/BOYYhTJ4Mi1p/7S4SvbXWVydm45nCbsX/qlPXltfeYdjtqQ4D0ex7sxdHZRxt8iRmC7FFTXB8quyYMLWxb4FAkiyArtOqaF6vm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 12:01:29.2343
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef63c671-847d-465b-d01f-08df417dd9ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0001854A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR12MB964154

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
Changes in v4:
- Bound the queueN children from above as well as below. Each
  xlnx,num-priorities branch now narrows patternProperties to
  "^queue[0-N-1]$" and sets additionalProperties: false, so a device tree
  that describes more queues than the IP has priorities is rejected at
  dt_binding_check and the offending nodes are named. The driver keeps its
  own check, since a device tree is not required to have been validated.
- Clarify that each priority queue must use a distinct TX channel listed
  in dma-names. The driver rejects two queues mapped to the same channel.
- Add the optional xlnx,max-learning-entries switch property for the
  per-port MAX_LEARNING_ENTRIES IP parameter (256 to 1920, default 1920).

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
 .../net/xlnx,tsn-endpoint-ethernet-mac.yaml        | 536 +++++++++++++++++++++
 MAINTAINERS                                        |   7 +
 2 files changed, 543 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
new file mode 100644
index 000000000000..2fd22bc0d035
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
@@ -0,0 +1,536 @@
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
+          QoS scheduling. Each priority queue must be described exactly
+          once and map to a distinct TX channel listed in dma-names. Two
+          queues must not use the same TX channel. The mapping need not
+          follow the channel numbering. For example, queue0 with
+          xlnx,dma-channel-num set to 5 means priority queue 0 uses tx_chan5
+          for data transfer.
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
+      xlnx,max-learning-entries:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 256
+        maximum: 1920
+        default: 1920
+        description:
+          Maximum number of addresses the hardware address learning engine
+          can learn on each network port (MAC1 and MAC2). This is the
+          MAX_LEARNING_ENTRIES IP configuration parameter, and no register
+          reports it. The endpoint port does not take part in hardware
+          address learning.
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
+          const: 2
+    then:
+      patternProperties:
+        "^ethernet@[0-9a-f]+$":
+          properties:
+            tx-queues-config:
+              patternProperties:
+                "^queue[0-1]$": {}
+              additionalProperties: false
+
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
+              patternProperties:
+                "^queue[0-2]$": {}
+              additionalProperties: false
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
+              patternProperties:
+                "^queue[0-3]$": {}
+              additionalProperties: false
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
+              patternProperties:
+                "^queue[0-4]$": {}
+              additionalProperties: false
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
+              patternProperties:
+                "^queue[0-5]$": {}
+              additionalProperties: false
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
+              patternProperties:
+                "^queue[0-6]$": {}
+              additionalProperties: false
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
+              patternProperties:
+                "^queue[0-7]$": {}
+              additionalProperties: false
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
+            xlnx,max-learning-entries = <1920>;
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
index fe23913b1e43..6e71049322df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -30742,6 +30742,13 @@ M:	Harsh Jain <h.jain@amd.com>
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

