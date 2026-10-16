Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010066.outbound.protection.outlook.com [52.101.85.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA2346C4D9
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792143166; cv=fail; b=lxtl7uCuapVX7wDkfB1/RvUb7wVXJpQyvWO10IkHyk9MnRR0OrfFLz3L3jcXFNmfWev/0s/AcZJHm1p91Y1m1t1vbhjN2hiwvl49uQ/DtgcCesLabkFllKa8AnCoLEgo38OeIQRibGzHFPfjxoy9cUlLqjxMakqNVhF69S7Mp70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792143166; c=relaxed/simple;
	bh=g1XfKxIzWuECUJHkI5RZFemsLC7Q8HatHFia0lVaO4A=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=Nn+uJel1r7BIyYXJVdMw8NPCQqyuYVfgwbw/ED9OAH3WfbFk6y6btceRcbYGzdxehCPhgBL7QxtvauIccKak+iCaGND6X5560k3g45McU+UDQSxn0BhfvC+/cB+ccavxisvc005A+E6ivlMC+75HJekgrRN2Z6BcpHqJqUlhOgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZNwVPEdZ; arc=fail smtp.client-ip=52.101.85.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZNwVPEdZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSasGxOlC8ey1T56Bm+vK0O8FUrq1gpWLwhxIk4W+YV16+sAo8fsUViEwlDj/1Rur0DUs7Dg9MBjAsRKWwe1pw0bQ+wN/59z6MqReIfNIO73ywyCeQj4e8m8+/2zpFIcXIwF0dmDwsUfqVS68FoefFOgkhE9YQlDPglsHmvtuboRqmefDd8FuGBKI1Nx892i5UuYbQ3YfbOkn/QAncXuaOAL/H99R/GzEgBMwAc+M8xqm+ExGCvcTpjP1gPdEQvmXSsAw2MLRldQdr+utNyGxv2/7vQcebANr50neZ1U8B8uaCWKp7lNScFxcB26LDXmLLPeVY0f7PkF3GythD4bsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhhEG39aCLX8CWf6h1wJ/cZaDBsKd0JT3rNA8Viq2eE=;
 b=q6CvOKw9QYjmHNgU7/KIksIHbftZSpL24bi5cMAdKft7i8hyzxWBns7m8I9tTe+FNCmIwQiP90gU6MUncRg7aOmjOWXt7EC+xPRxNHRd7RzAaJPucywUU0bRQDGL6MrCFcSnnZ7egWEz4owGENCUA44bcTG7MXeIMZ0cRjYPAdt3CIJHnAgIVGcIBQhVXHXOwSxuYtxoF7euq0y8BzyOlM+zEfVEgZ1JCtLAx5d44rOCqkCzFc1QFh16UaLT8KDN+snO3wV+P5Df/30wDoPcAB5lHtLtzMp4M0hyZaF/9zns46NyDV1leYS7iXGi3QMorT6wXbFodi1d/69BaBBfVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhhEG39aCLX8CWf6h1wJ/cZaDBsKd0JT3rNA8Viq2eE=;
 b=ZNwVPEdZhTvEecXWi4E15KJadsl9ly97kmwqHPvnmVPzyPuGgo4vZLRYBBiKuHjmPBduMHncQInA7YEOnqcMBNt1C98f0RxmJTMzVekmPqbSW1DKJGdGdAiDbI5lcKRP9v34qWO9X66pzjebvOk+Atah9JytmQYlYNxK/WRjtYE=
Received: from BN0PR03CA0020.namprd03.prod.outlook.com (2603:10b6:408:e6::25)
 by LY0PR12MB262873.namprd12.prod.outlook.com (2603:10b6:404:229::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Fri, 16 Oct
 2026 09:32:40 +0000
Received: from IA0PEPF00000037.namprd03.prod.outlook.com
 (2603:10b6:408:e6:cafe::2f) by BN0PR03CA0020.outlook.office365.com
 (2603:10b6:408:e6::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 09:32:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 IA0PEPF00000037.mail.protection.outlook.com (10.167.249.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:32:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 04:32:32 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 04:32:27 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Subject: [PATCH net-next v3 0/8] Add Xilinx TSN Endpoint Ethernet MAC
 driver
Date: Fri, 16 Oct 2026 15:01:59 +0530
Message-ID: <20261016-patches_v2_external-v3-0-e33d3960ca1e@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABDv0WoC/22QS27DMAxEr2JoXRnUx99V7lEUAWXRjYpYTiXFS
 BH47lWUAN10OSDnzZB3Fik4imys7izQ5qJbfRbqrWLTCf0ncWezZhJkC70S/IJpOlE8bvJIt0T
 B45mrVktBTdNpBSw7L4FmdyvUd+YpcZ9X2cdzEq/mi6b0gL52A31fc3B6GQxG4tO6LC6NlW7Q9
 trKHoA0wiBn09uhBWixUcpIC2iEmtsHaqEYsTQeq2df0YtOi0bUIouhE1zwGJx3G8baE53dARd
 b56xS7uRiWsNP+cUmS5eCGWD49+xNcuAKNRg0OM96+qPt+/4LUtR8ZVsBAAA=
X-Change-ID: 20260831-patches_v2_external-36421e557430
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
X-MS-TrafficTypeDiagnostic: IA0PEPF00000037:EE_|LY0PR12MB262873:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d712045-81ca-43df-29ab-08df2b686c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|7416014|36860700016|82310400026|921020|56012099006|11063799006|5023799004|261009223027099003|10067099003|18002099003|6133799003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	fOqeSCsno3XvyOHmvl3STp2o7UxDBmzL0l7Ul8tRgcp4s0vVrnU684tS+5V23qv1s5Vp1TDHMj5DFpY0bB+Fm6juaxVOOF56Makuqft4GLHCpDuE+gS5vVPejopO3yt+yNNO8MmGVwD2UM9QqgKPRzFkdmXRN+rjtl74it4tdOiwwCCCUCqS/Bl91sdvXsi4/n5Lo5GoKkZ/1u4bhPEg9aEZS6hMQQc8WUFh/JnK6dqsZfoeWwoloRZ4XEFVc22PP+8ckhT+qB1bZPaYKx9gOFWXk+jTFWHjWwq3WDlg79gFx1goAbNxffgLjhIJbikvPHdgRYiMOb6p77YDPhuC3SAMYNwlcCcbivcSQjQQS86NO5iFii2/gD1PrZdG6X8yJDDA/am+iDMAcgkq5FXDfdPrMKns9WcdckjhQ5ph5ltr9Y+5ZNqoun3BLqzLy3h3PGQygxbKN85DZmUsP2mmc4ZH75Cd1gTnAts+EAKuJ5127ZIg+qOtBeiOBKlxLwRkQXLDRqZascePuwOp/2QPOql4w9QYpFGa+BPk5u9qBM5ll/CokrJNT7g/SnkesTcWa3F/EeG1fpnCEOW0+Wl7n602/ZLk9+46k/L2V7wmhqBO3F1k/t7dqolyRhjYHnRIrdsZ5lMoQ/RHLzJLW7+scrjM8Mh2q118RYWNvISQMsouPh03SXWXuxYC4/YVhiqcHS0+RaSCplU4TEgClwvjJw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(7416014)(36860700016)(82310400026)(921020)(56012099006)(11063799006)(5023799004)(261009223027099003)(10067099003)(18002099003)(6133799003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5QmVipYtNOyRfko+umocyBLQHhaDJ/c9MOWX5qHRrR1Hsfxa8d9BUCFYawY6c1lARJ1umCUSkXSdheOvrYFIdGpYKFBXmUqUd1vEIZBjbNN1A4rii2FpFKr9K77rTBSJsMnqckKOBSvz77wN26hRjTCbdb07KRPzPiSckmUnZCYLJu700DEXcpXLAcTXIL6QXzGkEMO0sz+VWpPQV4imQo09dLGK5g6c4XRG6TDC9T1aa+ccjGIUKNoRPaj6c89t8faFRsGitf7fyxmBdTQwBG6lQ5agokgFg+VYGyoRbd11gPVBmcmcrsUdlUE71+8K2trz+H4I0slYGT+WgsBScXRLCfEUS8zxOZ4y0VBTUjoT2HZq58mmKO6gEr2KDG5vo3lRhlSsZ8k8t+vaAN3Gt9ymZELfTiAN+5f2fMqEKty1Y99GG13ckPxKmoGeQT8J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:32:40.1080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d712045-81ca-43df-29ab-08df2b686c2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF00000037.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB262873

Introduce a new network driver for the AMD LogiCORE 100M/1G TSN
Subsystem IP, also known as the TSN Endpoint Ethernet MAC IP, which
implements IEEE 802.1 Time-Sensitive Networking (TSN) features for
deterministic and low-latency Ethernet communication in real-time and
industrial automation use cases.

The v1 posting sent all 20 patches (wrapper, endpoint and the DSA switch)
as one series. Following the review feedback to split it, this series
sends only the wrapper and endpoint side (patches 1-8). The DSA switch
driver, tag protocol, MDIO, phylink, PTP and bridge offloads will follow
as a separate series once this base lands.

IP Core Overview:
The AMD LogiCORE 100M/1G TSN Subsystem IP solution (named as TSN Endpoint
Ethernet MAC IP in the IP catalog) implements IEEE 802.1 Time Sensitive
Networking (TSN) Standards and provides a low latency Bridged Endpoint or
Endpoint only solutions. The bridged endpoint solution consists of a 3-port
switch that connects to an endpoint including Linux software drivers. For
Bridged Endpoint (Switch Endpoint), two ports connects to the network and
one port connects to an internal Endpoint. It supports the use of
GMII/RGMII interfaces connecting to a physical-side interface (PHY) chip
with full duplex 100 Mb/s and 1 Gb/s operations.

Features:
- IP Customizable to generate TSN Endpoint or Bridged Endpoint solution
- Supports interface to network software stack
- Designed to comply with the following IEEE standards
    - 802.1AS  : Precision Time Protocol (PTP) synchronization
    - 802.1Qav : Credit-Based Shaper for traffic shaping
    - 802.1Qbv : Time-Aware Shaper for scheduled traffic
    - 802.1Qbu : Frame Preemption for ultra-low latency
    - 802.1CB  : Frame Replication and Elimination for redundancy
    - 802.1Qcc : Stream Reservation Protocol (SRP)
- IP is customizable to enable various TSN feature-sets
- Supports 2 to 8 priority queues for scheduled, reserved (IEEE 802.1 Qav
  Credit Based Shaper) and best effort traffic classes
- Provides feature rich Ethernet Switch that caters to various network
  needs
	* 3-port Switch (2-external, 1-internal)
	* Programmable cut-through and store-forward operations
	* 4-port Switch (2-external, 2-internal) extension through
          'Endpoint Extension' and 'Endpoint Packet Switching' features
- Solution validated on ZCU102 & ZC702 AMD Evaluation boards.

Sample hardware architecture diagram for Bidge End Point like below:

             +------------------+
             |      MCDMA       |
             +---------+--------+
                    Q0---Q7
                       |
          +------------------------------------------------------------ +
          |            |	 TSN sub system(Bridge End Point)	|
          |            |                                                |
          |     +------+----+  Port 0   +-----------------------+       |
          |     |  EndPoint |<--------->|       TSN Switch      |       |
          |     |    (EP)   |           +----+-------------+----+       |
          |     +-----------+                |             |            |
          |                                  |             |            |
          |                              Port 1         Port 2          |
          |                                  |             |            |
          |                            +-----------+  +-----------+     |
          |                            |  MAC-1    |  |  MAC-2    |     |
          |                            |  (ETH1)   |  |  (ETH2)   |     |
          |                            +-----+-----+  +-----+-----+     |
	  |			             |		    |           |
          |				     |              |           |
          +-------------------------------------------------------------+
                                             |              |
                                          RGMII           RGMII
                                             |              |
                                      +-----------+  +-----------+
                                      |  PHY1     |  |  PHY2     |
                                      | (Port 0)  |  | (Port 2)  |
                                      +-----------+  +-----------+

The endpoint is capable of Qbv scheduling and is connected to hardware
that implements time-triggered per-stream scheduling as specified in
IEEE 802.1Qcc-2018 Annex U.1.3.

Software Driver Overview:

This series adds the wrapper and endpoint side of the IP. The switch-facing
part is exposed through the Distributed Switch Architecture (DSA) framework
in a follow-up series, so that MAC1 and MAC2 show up to Linux as switch
ports with the endpoint acting as the CPU/conduit port. The endpoint frames
are already classified by source-port id and tagged with DSA port metadata
here, so the switch series can consume them without further endpoint
change.

Since the endpoint must be exposed to users for Qbv and TADMA schedule
configuration, it requires a user-facing netdev, which also aligns well
with the DSA model. In addition, the hardware lacks a destination-port
selector and does not provide an independent per-port forwarding mask.
As a result, standalone port isolation is achieved using a private VLAN
that contains only the selected port and the endpoint. The DSA framework
enables reuse of the tag_8021q helpers to manage these VLANs, insert the
destination-port VLAN tag (which is stripped by the hardware before egress
on the wire), and seamlessly handle transitions between standalone and
bridged operation.

Wrapper driver:
- Binds the top-level IP node, acquires and enables the IP-block clocks.
- Spawns the endpoint (and, later, switch) blocks as child platform
  devices via devm_of_platform_populate() and carries no netdev or
  register access of its own.

Endpoint driver:
- Implements the conduit net_device that Linux DMA traffic flows through
  on its way to and from the switch fabric.
- Manages multi-queue TX and RX descriptor rings using the dmaengine
  framework for high-performance packet transfer.
- Classifies each received frame by the source-port id carried in the RX
  descriptor sideband metadata and attaches DSA port metadata so the DSA
  core can demux it to the right user port netdev.

Changes in v3:
- cover letter: explain why the switch-facing part is implemented as DSA,
  what the endpoint netdev provides beyond being the conduit, and how RX
  demultiplexing and TX port selection map onto the hardware.
- binding: rename ports to ethernet-ports and port@0..2 to
  ethernet-port@0..2, the preferred names for a new binding. Require reg
  on the CPU ethernet-port@0 and pin reg to the unit address on the
  external ports (literal ethernet-port@1 reg=1 and ethernet-port@2 reg=2
  instead of a shared enum). Require queue0 in tx-queues-config, and add
  contains rules so dma-names must carry at least one tx_chan and one
  rx_chan.
- endpoint MAC: register the netdev with the standard eth%d name
  (NET_NAME_UNKNOWN) instead of a custom "ep%d".
- endpoint DMA parse: state the queueN to TX channel mapping in the commit
  body rather than only in the changelog. Rename the counting helper to
  ep_count_dma_channels() and the RX map to rx_dma_chan_map, keep the RX
  map in a probe local, and document the TSN_DMA_CH_INVALID sentinel in
  the tx_dma_chan_map kernel-doc.
- endpoint MCDMA bring-up: acquire every TX and RX channel at probe and
  hold them until remove, so ndo_open only builds the rings and no
  deferral can reach userspace. Reset the controller through the first
  held channel. Move the closing flag and the circ_buf.h and spinlock.h
  includes to the RX patch that first uses them, and drop the unused io.h
  include.
- endpoint RX: check the dmaengine_submit() cookie before advancing
  ring_head, and free the buffer if the submit fails. Use scoped_guard()
  rather than guard() for the rx_lock, per the netdev cleanup.h guidance.
  Introduce the closing flag here, alongside its first reader.
- endpoint TX: free a DMA-error frame with dev_kfree_skb_any() and a
  completed one with dev_consume_skb_any(). Add skb_tx_timestamp() at the
  hardware handoff. Skip the queue wake while closing, using
  __netif_txq_completed_wake() with the closing flag.
- endpoint RX to DSA: reword the commit message to describe the metadata
  this patch adds, and drop the claim that RX frames already reach the
  swpN netdevs.
- Link to v2: https://patch.msgid.link/20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com
- This series has a dependency on the MCDMA patches, which are currently
  not present in net-next:
https://lore.kernel.org/all/20260818174151.1608971-1-srinivas.neeli@amd.com

Changes in v2:
- Split the original 20-patch series. This v2 carries only the wrapper and
  endpoint (patches 1-8). The DSA switch driver, tag protocol and offloads
  will be posted as a separate follow-up series.
- binding: describe only the Bridged Endpoint configuration, drop reg from
  the wrapper node (it has none of its own, ranges covers the child
  windows), rename ep-mac@ to ethernet@ and mdio-mac1/2 to mdio-1/2, cap
  the DMA channels at 8 (dma-names maxItems 16, tx_chan/rx_chan [0-7],
  dma-channel-num max 7), use a ports/ethernet-ports container and require
  port@0, port@1 and port@2, add reg (enum [1, 2]) and require reg,
  phy-mode and phy-handle on the external ports (gmii/rgmii/rgmii-id), and
  add minItems on the switch interrupts.
- Kconfig: depend on OF_ADDRESS instead of OF && HAS_IOMEM, point the help
  text at the companion DSA driver rather than a symbol that does not exist
  yet, and drop the mod_devicetable.h include (platform_device.h pulls it
  in).
- endpoint: name the netdev ep%d instead of a fixed "ep", drop the mapped
  but unused register window, use dev_kfree_skb_any() on the drop path, and
  drop the mod_devicetable.h include.
- endpoint DMA: check xlnx,dma-channel-num against the channels dma-names
  lists, require one queue per tx_chan and num-priorities equal to the TX
  channel count, cap TX/RX at 8, error out on an unknown dma-names entry,
  and drop the unreachable count guards.
- endpoint MCDMA bring-up: request a channel at probe time so -EPROBE_DEFER
  stays in the probe path and never reaches ndo_open, and request channels
  by their real dma-names index instead of a dense 0..N-1 sequence.
- endpoint RX: serialise the refill against teardown under a per-channel
  lock, recover a drained ring with a refill timer instead of stalling,
  fail ndo_open if a channel cannot arm any descriptor, take the ring size
  from the channel, shut the refill timer down with timer_shutdown_sync()
  at teardown, and return true from the refill helper when it arms a
  descriptor.
- endpoint TX: take the scatterlist count from skb_to_sgvec(), check
  dmaengine_submit() before advancing the ring and charging BQL, publish
  the ring head and tail with WRITE_ONCE(), move tx_lock into the
  per-channel struct so independent TX queues do not share one lock, use
  the spinlock_bh guard class in the completion callback, and use
  dmaengine_prep_slave_sg().
- endpoint RX to DSA: attach the port metadata only when the netdev is a
  DSA conduit, take a counted dst reference (dst_hold() + skb_dst_set()) so
  the dst survives the __netif_rx() backlog handoff without skb_dst_force()
  in softirq, and release it with dst_release() at teardown.

Previous versions:
v1 (full 20-patch series, now split):
https://lore.kernel.org/lkml/20260807104431.157230-1-nagadheeraj.rottela@amd.com/

Test information:
- Validated these changes on the net-next branch with the MCDMA metadata
  patches cherry-picked from linux-next, along with the series listed below
  https://lore.kernel.org/all/20260713072146.45269-1-srinivas.neeli@amd.com/
- The endpoint RX path depends on AXI MCDMA metadata support in the
  dmaengine driver. On plain net-next, xilinx_mcdma_prep_slave_sg() does
  not attach metadata_ops and desc_metadata_modes stays 0 for
  XDMA_TYPE_AXIMCDMA, so dmaengine_desc_get_metadata_ptr() returns
  -ENOTSUPP and ep_dma_rx_cb() would drop every received frame. The series
  therefore depends on the MCDMA metadata support that extends metadata_ops
  to XDMA_TYPE_AXIMCDMA and returns the descriptor status word (index 0 is
  status, index 1 is the sideband word carrying TID/TDEST/TUSER, index 2
  onward is the app words). That dmaengine work is a prerequisite for RX to
  function and the TSN patches touch no dmaengine code. It will be posted
  to the dmaengine tree and this series carries a Depends-on note plus a
  lore link once it is on-list.
- Performed ping, iperf3 and multi-queue TX/RX tests on the ZynqMP ZCU102
  platform, with the endpoint conduit up and both external MACs cabled to
  peer NICs. Also ran teardown and probe-defer stress under KASAN and
  lockdep with no use-after-free or locking splats.

Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
---
Nagadheeraj Rottela (1):
      net: xilinx: tsn: deliver endpoint RX frames to DSA user ports

Srinivas Neeli (7):
      dt-bindings: net: add Xilinx TSN Endpoint Ethernet MAC
      net: xilinx: tsn: add TSN endpoint wrapper driver
      net: xilinx: tsn: add endpoint MAC driver skeleton
      net: xilinx: tsn: parse endpoint DMA channel configuration
      net: xilinx: tsn: bring up the endpoint MCDMA channels
      net: xilinx: tsn: add the endpoint RX data path
      net: xilinx: tsn: add the endpoint TX data path

 .../net/xlnx,tsn-endpoint-ethernet-mac.yaml        |  491 +++++++++
 MAINTAINERS                                        |    8 +
 drivers/net/ethernet/xilinx/Kconfig                |    1 +
 drivers/net/ethernet/xilinx/Makefile               |    1 +
 drivers/net/ethernet/xilinx/tsn/Kconfig            |   16 +
 drivers/net/ethernet/xilinx/tsn/Makefile           |    2 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h       |   15 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c    | 1083 ++++++++++++++++++++
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c  |  107 ++
 9 files changed, 1724 insertions(+)
---
base-commit: 45ad84d2800e4a092fb8d96006a533b2d0ab13f6
change-id: 20260831-patches_v2_external-36421e557430
prerequisite-message-id: 20260818174151.1608971-1-srinivas.neeli@amd.com
prerequisite-patch-id: abfd1f0259ea7524a5b6a4a7c98b116a213910d0
prerequisite-patch-id: 64bc1fc9008bff333d8cab78d018d93db31c2ee7
prerequisite-patch-id: 3e7fee96146b9a89dbd70f83942e4acf61cfd730
prerequisite-patch-id: 87d626e07a12df2d50163e12e34879868c750253

Best regards,
--  
Srinivas Neeli <srinivas.neeli@amd.com>

