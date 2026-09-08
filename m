Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011061.outbound.protection.outlook.com [52.101.57.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360B05A515A
	for <linux-rt-devel@lists.linux.dev>; Tue,  8 Sep 2026 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788895236; cv=fail; b=L4zo1bR4lBfy5sQNihPGGrXJWt15hnRVGKiN8Yt61yTxU3AmzyGdfS13SX9XsazCHSulSieb/HutjF6QPfwOGxMq/h9630leFKTlLwWSc3GnWIIcpizuUdZb2GOqWd0jiuOtnv6mM2F6gcGh7jd1Geszmo0DYC6Cgy1P0MekhxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788895236; c=relaxed/simple;
	bh=bSZ1ehhdpJISLuL01nvBmIXlDdYjyphDZYgKQnDYoLM=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=j3HLacaMe3IszDRxwqi9XfK+oDmasTFZnUfxNlGxaCjqZg0JODkrmu0KFugBKGFNlWW1jbDYcL99U5Afr1Sau3yQyDGrIT+k4WjHrnMmcNdsF+SokKjo3t9suM/2HcuaJkHrq7MEQ1AQoZQjunjZsJpF7mqWI976bPSbH+seLEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TkkYlyP2; arc=fail smtp.client-ip=52.101.57.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TkkYlyP2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DzsV/d4rsucgpIWm13zo/iam/RNW2hhvn3iTBGTZXUK51uVsGaFiEFNBhjpj8XZUoRfCTbZgvKXoZXgn5haeO5mHeBWzXdcD262nwKnmwva9HdULidsKalDJOBmbsCCjNdoh71DRPOoVrOjqka8xjCEmmUjFX+GXD2LMRtnUKzFVs7MeyLIoMeuZU5yTefEAepLc2FrPYrFoO9yXapUDLQaDgKHkrCiSGEmIZtMwzevjPMH/FL8eZKg3th+94VA4O8XzvMaes4q0NTC5/2d5LOieSib56biD9q1vNEWPGl9wsWv5wfY4HH4dcPskkQ5KmuW6SMAF1HTtJe69U6ZMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+Dg5CSw2FY52VCDvUscXuY/0lhM1aiOFgvbHP3PirQ=;
 b=DpdZG0q63rHpyI3DAYhpQHvP9tZ+QsxibFa/l57mBDKLBhzaRBGRN4o5EsNaJ6+bMICneYjg489GhMRy0Ga+OHakCmRidbz/Z68fvhEV99IudDSw0vE/KwkUxd3hgayFm6QOYL8YIDZJHUjWz18m9sYuh9AI/Sxc5jPvyP6tXcTJDAclT5VwZipcwKiDA3pxUJUWeem/DPEO4vqR9sbaseF91MmbUNzzfoT6raA3OcctYqDBwtLskrztDyDud/4I2LkYIfCAf3e4wP0pirgWVMr+XrEdKs7xUInfk/UNQWYyudJfihK4Y5dyYO5Bg+rk98BgWTzug0a5TU3SBXh/Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+Dg5CSw2FY52VCDvUscXuY/0lhM1aiOFgvbHP3PirQ=;
 b=TkkYlyP2GZEoteDAZ23NPnrXWuXa9yBOdiR90ys76JSFSRggj7/s2NEY6ZnNFlYH+yhVytUcTm127a8tkUQxkkO3Ht7Yv4Wg9MZvjyLmYg0kmfodcHcz9MJg5xoT8ACBzkhuo79DQifiYq8Kl+A52CTepgMkpL+JEKnkqMzoZO8=
Received: from PH1PEPF000132E5.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::25)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 19:20:20 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2a01:111:f403:f90f::2) by PH1PEPF000132E5.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 19:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 19:20:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 14:20:07 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 14:20:02 -0500
From: Srinivas Neeli <srinivas.neeli@amd.com>
Subject: [PATCH net-next v2 0/8] Add Xilinx TSN Endpoint Ethernet MAC
 driver
Date: Wed, 9 Sep 2026 00:49:48 +0530
Message-ID: <20260909-patches_v2_external-v2-0-3a40babaff4c@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANVfoGoC/y2PS27DIBCGr2KxLpYHDI6z6j2qKBpgaKhikjLEi
 hTl7iVulp/mf81DMJVELPbdQxRaE6dLbqA+OuFPmL9JptBYqEHZYadBXrH6E/FxVUe6VyoZz1L
 bUQEZM416EM15LRTTfUv9EpmqzE0qDv8Xvrkf8vUV+tYW+r214vo2OGSS/rIsqe47522kOegBg
 pkjGe+UtsGOFh1Ns3IxIpmI9hW1EDNui9sD217YwTSCgR4azBNIkFxSTityn4nO6ROX0LcucXg
 +/wCNQWCgDAEAAA==
X-Change-ID: 20260831-patches_v2_external-36421e557430
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: 81858d8b-cd9a-400f-0074-08df0dde37ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|7416014|11063799006|6133799003|56012099006|3023799007|10067099003|18002099003|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	tJaGs5NJ0EH+tZwExgbLN7GYx7/UgLdfNwN/VfP3xXeuTUc7zYyGhJ628Z7b/5Z4kJMGIMhYuPW3qqn9/XcQMTP57DufezLflPagu5n49Lg0pV6H55IUKWdFMlLyDa/4C3dgpIleTFYP4eejLSzr7OBJKyeAyqWXAzCsUbUaMNlC6pVCPJ3e5M6ufTaL9F8e+aKdt/bVV5GvvFLDPURccjn8lDoB9+M9UvMQeAYoI2vdqApqiGvX2vWDGlRAy7VUjaFTW6Q/rJ1paoHZ+bz6sQSCxGjwycyqn82+s5oZ0Wd3QB9f2ouOoLAHjP5RjEqUIZO6OA+NSddJO4u1YnEDI52fPzAeDgSARNjuGqPG7MSn2zJufbmN5yiMv61o9IV5U+9MYkALk5WQ9icQy82CSyDSCDTe3FTbd3ytAECxyiFlVhhxuYQ1n4RlcqNbmEW9pMPRPiSNv+7+Pzs+AHG1wub5hBzAZmFRAgMMW+ryUP+i3kJfaqei9raf2YHEjlxPC/EJykOE3D1pVEZe3MLCZQeUYVbCU6i8rT/R/ubDOoAJ83eUEa9XnH9HDZFhWjbDTkrgDE1HT+neCfC1DDC+avtlCn05RaLC0uPPlj7pjGElbPmDzh75VlHBcHCTk6LfXkDEBxK3awhEXssd+AsyQCfmmq8Gf0zwzqUY/bFoQ9RQFxolnz4oDqMXi7PZjAWEfO2ulaKKz9ufPFZB8Fb+P1g7+EuraCUJE0cqZO/fOL2zA566ftccX1Bd9vaZgeA2
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(7416014)(11063799006)(6133799003)(56012099006)(3023799007)(10067099003)(18002099003)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AuQD/ygTROKVdRFT/1FN6PbuNl65MfDy4xmu0qBg4EJgMPxDU+tdgCJxl84VVJzk4lRmHg4jR/LKJFogAfTCUoh5Pv+QxWlxWpJD8gEE6tJ81oqs4/BxysK2MctfBcV3DUGU6T8CX9A0tcQyjwBLqEdPGFYuGemPJkyXMwg0hLsC6hzblnmbVlRXSEf8fAP1SRqlhJX0pSd3FrRJAf5jhkOzvvC+UwIFXrmwJql1AxNg5RR/xVma4jfOB8qakWRDgnQF4Epudb4LyiMu9tgyA2aoQ3sumBxFrjpDBZigkXT+qoj39HhXFSrGbs6S84IsjFX+6rBzo/mGN3K7cwEku4kowD2WMxp+t9VFeQJXxN434Mu/IlWSbYkO9PTJi6KhWg51W3xye0XyuF/P5fDX5MKWtbUWlwcomMYnvhpxB0jZh9BqhEjIyzVQ6b1xglpH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 19:20:17.6785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81858d8b-cd9a-400f-0074-08df0dde37ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063

Introduce a new network driver for the AMD LogiCORE 100M/1G TSN
Subsystem IP, also known as the TSN Endpoint Ethernet MAC IP, which
implements IEEE 802.1 Time-Sensitive Networking (TSN) features for
deterministic and low-latency Ethernet communication in real-time and
industrial automation use cases.

The v1 posting sent all 20 patches (wrapper, endpoint and the DSA switch)
as one series. Following the review feedback to split it, this v2 sends
only the wrapper and endpoint side (patches 1-8). The DSA switch driver,
tag protocol, MDIO, phylink, PTP and bridge offloads will follow as a
separate series once this base lands.

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

Software Driver Overview:

This series adds the wrapper and endpoint side of the IP. The switch-facing
part is exposed through the Distributed Switch Architecture (DSA) framework
in a follow-up series, so that MAC1 and MAC2 show up to Linux as switch
ports with the endpoint acting as the CPU/conduit port. The endpoint frames
are already classified by source-port id and tagged with DSA port metadata
here, so the switch series can consume them without further endpoint
change.

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

 .../net/xlnx,tsn-endpoint-ethernet-mac.yaml        |  364 +++++++
 MAINTAINERS                                        |    8 +
 drivers/net/ethernet/xilinx/Kconfig                |    1 +
 drivers/net/ethernet/xilinx/Makefile               |    1 +
 drivers/net/ethernet/xilinx/tsn/Kconfig            |   16 +
 drivers/net/ethernet/xilinx/tsn/Makefile           |    2 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h       |   15 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c    | 1034 ++++++++++++++++++++
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c  |  107 ++
 9 files changed, 1548 insertions(+)
---
base-commit: bc6fe9d301d59fe5cb236d646abe792bffae5fa6
change-id: 20260831-patches_v2_external-36421e557430
prerequisite-message-id: 20260818174151.1608971-1-srinivas.neeli@amd.com
prerequisite-patch-id: abfd1f0259ea7524a5b6a4a7c98b116a213910d0
prerequisite-patch-id: 64bc1fc9008bff333d8cab78d018d93db31c2ee7
prerequisite-patch-id: 3e7fee96146b9a89dbd70f83942e4acf61cfd730
prerequisite-patch-id: 87d626e07a12df2d50163e12e34879868c750253

Best regards,
--  
Srinivas Neeli <srinivas.neeli@amd.com>

