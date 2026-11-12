Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.30
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794557916;
	b=l+FdsxdwI4IS4iPx8p6P9qIvRLGBT9K0GBhzNkXxLKHiKlHGYYgSI4QfhGaTXgey7Lx8
	 6mD00CWGykbRftKTkISnp4uFBzJnTQchcP6+1khsOF958mxdzoTE9+oQBaaXBIJ8pgG9s
	 k8eTZfBn7J2MV181z9MusuUloGWLUBaJblmSe3rRr6I4X5Gc/DePTvH0uEHGitAaiOBLD
	 kw0ZLUbEtfpilLT7rIMJN/pGmk3GXbnCj6ouApK10R/1IsCRTEqOIjzIEN4/2VrIgX4Vy
	 qiapWp6RFVtIvZIKPNfG7BLCVlNxzaYTmiN/A4J6ovec3HIQe7dhkc40VgKrPlUhSrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794557916;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=Jw0UjiPAEZDSAWd1YIMdW4nFovKNAiNTXrHUXuECyWU=;
	b=FUu8il7yR1gu/rulQQxrHEYtsFE0bU0l7tjnBEEvpAMm8fNx6fvY9DjbWO9llFcdUBMd
	 8CurNf1J7gXQ8CMGuGD5AuFSl0oPP7s42AI4HKCQbDns/FDMqdRUaBVNCBIqY5vJC6kEc
	 ZGox2PooIEwbYROpoSRPvKwDA/+A+y1eD5Ql9Z29oUGN2qWQQPtsrTYCE3ZdG+PaOXhXB
	 2tdT0aS0D/FhCcKrSbp9+wVDW9bjW/DBGtQ3QNmS2B+gPrIy3Ibhz88vl9MqOYbv8KAA7
	 2lx5jxftNrL2iSDaRdlYbqsz22ZjYJY4M+fw+jqavhgVAfOxl9u1pt3CMwJLqb3z1cA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ngRw7b05;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.30
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92585606A323
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 08:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92585606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ngRw7b05
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YL1cW6SNEceEqg5zQ/eaWgjqODFrZZvzVG9iPkXYf56Ax+EtLoHj1o6UmLxI0e+LD7O9/oz9cnYxt8Q0WA+c7LNqViKXcuTHwrI35rL/2k1LVl9aAY0vweObdHw0LT0GXpb4B+U08tdCPRr0HtOto7mVmCLxzQB/+uMiOX0Rsv3KJrkDxfSjD51npEMsB7Tov41gUNpGORI8FuEzoBzn0FIfKnsrxPIEGGIVeXkmcwGIWLZueaPbFbegRojBnrY0l2rg9GuEQizlkpnMBXMEV8PApEoIFXTkjulvRc83njFBh4Gz5w2Q+fVEl+aaPXCOrC0Mg7R/u3u+PCE8/Z9sYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jw0UjiPAEZDSAWd1YIMdW4nFovKNAiNTXrHUXuECyWU=;
 b=g+tHS/+raCYW6PJ6QT9eUHiFNAyUhhZDMWw7DjmVkw5I+DI9Nv31Njn9eaDSXxJipjdL4EGISrHiPqMCU5gI1eGPkSN3XFiPOAxLLjCQQrdlS/1TFfQ76PYcjP/G6C6X29Vn2fQllhdNSEqF3/0H6AQQB9/0oKq+aq1A2c8J1jvUL7gy1rp5PTEG+aHhMfs+03gIhV0YDRAdbk9E+hMNuQqFjAcplZy86Xkd0sdK7JEntlNS5cUQv5QPBpOIX2iOp5ncnP892OOHuejuHD2n9uGsqg59tV9k6RvIiWsnp45qQ1AKETkpQiNfkhwg7A5Q8StZacpPIb1LtigCwv6vWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jw0UjiPAEZDSAWd1YIMdW4nFovKNAiNTXrHUXuECyWU=;
 b=ngRw7b05uS0khWdi6/7lB7UhiJOamJLR7IaOSy2Sxnvzfdz+PgwvKiv1ziCWbxHjoLiMmPsxyfcm1U+drgoiPCgnrXiPIf5LvG7CgZ2JqDpGu/ENaogpmYizNwfO6ZZEd2QFohw5D8VvqdaIneaP8nPZzaYjsIxK8Fny4jpzaOc=
Received: from SJ0PR03CA0209.namprd03.prod.outlook.com (2603:10b6:a03:2ef::34)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 08:15:09 +0000
Received: from MWH0EPF000C6191.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::7f) by SJ0PR03CA0209.outlook.office365.com
 (2603:10b6:a03:2ef::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Fri,
 13 Nov 2026 08:15:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6191.mail.protection.outlook.com (10.167.249.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 08:14:57 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 12:47:10 -0600
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Thu, 12 Nov 2026 12:47:05 -0600
From: Srinivas Neeli <srinivas.neeli@amd.com>
Subject: [PATCH net-next v4 0/8] Add Xilinx TSN Endpoint Ethernet MAC
 driver
Date: Fri, 13 Nov 2026 00:16:44 +0530
Message-ID: <20261113-patches_v2_external-v4-0-56bb26f042a4@amd.com>
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
X-B4-Tracking: v=1; b=H4sIAJQJ9moC/22OQQ7CIBREr2JYiwE+rdaV9zCmofTXYpQqUKIxv
 bsUjW5cTmbmzTyJR2fQk+3iSRxG481gk5DLBdG9skekpk2aCCZKtgFOryroHn0dRY33gM6qM4V
 SCo5FsZbASGpeHXbmnql7YjFQm6Lk8Hb82JxQhxn6yTq8jWk4vAtzrDc+DO6RX0WRMflAxaq/B
 6KgjIKSrFGN6jqpd+rSrvRwyaMRvgTOePmfAImAAC1UJdOK448wTdMLvTV0picBAAA=
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
	<git@amd.com>, <neelisrinivas18@gmail.com>
X-Mailer: b4 0.16.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6191:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: e19f3c42-8037-466c-82ac-08df415e346b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|23010399003|1800799024|18002099003|6133799003|261009223027099003|3023799007|921020|56012099006|5023799004|11063799006|261021135927099003|261028144727099003|10067099003|261102123227099003|261022075727099003|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info:
	Sl90kzVcttfS3c0Xd8fqAEJSQdSJV70blNp3fQ2aarF5hwDp413a6KYOC/DzBRTuG6L71Mz+IV1IP77S6CY6EkCst2m0dHKwW6egMpLXmJ3ArECcF9laBabOOwOkiN399ExGN7T+RGm5TnN6sf7tHpSmfYZYXg1lH4Rv5Mg8y2MpwKj6BfARlTmGUgBSiPNiNnQ3wsylI+eFQXOOtetv/R+E80sEACsKMJQZBD/hYrIolHqR8VUi/IRrmcj/Nw7xls0OxcXsmTi/IBbtUOMRGHnhO73W4Tvw82x1TOVVYZLJgAQcg+rBgipbFdfwa+trRI+BPqGL6MABo18hazl1iNLcQGtke46SUFmOyafjXVy/8O3iI9J1lbIFsjMJtegFDiUxUR5cCsr1IFrwuN9rPDyTrTxNGya0gE29ObuBZKgiMgiQfk3bCorgHWxJ55WJRf1kQ5eVOWd1hqwdcvbkWpc6RbOZe/DlCBlNQRPj027/thDf+j5jK3sCT1U7Zol3FopXI7lZUKM0b8Au/qrzeOz5QWc6gYnT4uvat8LI1ZOFXQP1zChGYN7cJ9uoqvPFg5JwwSM9c+34wgeBSKsiAEpx5AKKAczfIEeqWXxgtFRdLo3QKNIH58XfL9zmquxXxaw61JH1+F3ZGpHWr425abZN2gAW+crR6iYxnwfTELgk71pJ/iTXXRGH1XXMm1CS/4RljBTYIw2HnRHYg9m92g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(23010399003)(1800799024)(18002099003)(6133799003)(261009223027099003)(3023799007)(921020)(56012099006)(5023799004)(11063799006)(261021135927099003)(261028144727099003)(10067099003)(261102123227099003)(261022075727099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261026140227099003)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	uv0x5kqqdHGukgNgBUxi75vqGem89wh43o3Slx5FAY9GOMzaFJ6B18Cm5r+kI3AJ6nx79uqNm/Iaj2Kyc0PwOe8x0Cw8oq5Co2+v0ejolReD2tlVrt6XnXC8bo8DAeRfl0KJ41VS0DQzqBCNpNrEr6F7c0USHhRtCCbzo1yt1tifvyYEAKRjvx0nrtLqptF8iMNsmuE8YxsgAz6KmmmOh+4xAyUI3kVlYFMWrXm3oMc60KNIf284Pq+P7pfjUpmMU5BtVOQHz2ztxg2SGd4vBUo63pbwOaSmydVHhcZ0E5yUuFgsmvEaKWTYFuIi3cxg5jpcMzQK1J4zWX3wt8VeeBaAFiOa8BPVJ+lSFz+WS2uPN/zxgklCMMug5xVI4hntW45gQ2wcuZC7fnPqFUjSY0O0Ksf5+hyadgWRsp9iFUEtA4wr/a4m1/e4J6qi2Znh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 08:14:57.0741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e19f3c42-8037-466c-82ac-08df415e346b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000C6191.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859

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

Sample hardware architecture diagram for Bridge End Point like below:

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

Since the endpoint must be exposed to users for Qbv and time-triggered
per-stream schedule configuration, it requires a user-facing netdev,
which also aligns well with the DSA model. In addition, the hardware
lacks a destination-port selector and does not provide an independent
per-port forwarding mask. As a result, standalone port isolation is
achieved using a private VLAN that contains only the selected port and
the endpoint. The DSA framework enables reuse of the tag_8021q helpers to
manage these VLANs, insert the destination-port VLAN tag (which is
stripped by the hardware before egress on the wire), and seamlessly
handle transitions between standalone and bridged operation.

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

Changes in v4:
- Rebase onto net-next, which now carries the AXI MCDMA dmaengine changes
  merged for v7.4-rc1. Commit 5b585cc87781 ("dmaengine: xilinx_dma: Move
  descriptors to done list based on completion bit") keeps RX buffers
  owned by the engine until their descriptor completes, and
  commit 5f677afc9567 ("dmaengine: xilinx_dma: Extend metadata handling
  for AXI DMA and MCDMA") provides the RX sideband metadata the endpoint
  reads. The series no longer has an external dependency.
- binding: bound the queueN children from above as well as below, so a
  device tree with more queues than xlnx,num-priorities is rejected, and
  state that each priority queue must use a distinct TX channel. Add the
  optional xlnx,max-learning-entries switch property.
- Kconfig: drop the reference to the companion DSA driver, which is not
  part of this series.
- endpoint MAC: use alloc_etherdev() so the eth%d name is registered with
  NET_NAME_ENUM.
- endpoint DMA parse: use alloc_etherdev_mqs() for the multi-queue
  netdev, and reject xlnx,num-priorities outside the 2..8 range the
  binding allows.
- endpoint MCDMA bring-up: describe @dma_address as a DMA address in the
  kernel-doc.
- endpoint RX: report the ring as armed when the refill submitted at least
  one descriptor, so ndo_open no longer fails when a buffer completes
  before the ring is tested.
- endpoint TX: call skb_tx_timestamp() before dmaengine_submit(), add
  .get_ts_info so ethtool reports software TX timestamps, and terminate
  the TX channels before netif_tx_disable() in ndo_stop so a completion
  cannot wake a queue while the channels are freed. Extend the @closing
  kernel-doc to the TX completion.
- Link to v3: https://patch.msgid.link/20261016-patches_v2_external-v3-0-e33d3960ca1e@amd.com

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

 .../net/xlnx,tsn-endpoint-ethernet-mac.yaml        |  536 ++++++++++
 MAINTAINERS                                        |    8 +
 drivers/net/ethernet/xilinx/Kconfig                |    1 +
 drivers/net/ethernet/xilinx/Makefile               |    1 +
 drivers/net/ethernet/xilinx/tsn/Kconfig            |   15 +
 drivers/net/ethernet/xilinx/tsn/Makefile           |    2 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h       |   15 +
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c    | 1094 ++++++++++++++++++++
 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c  |  107 ++
 9 files changed, 1779 insertions(+)
---
base-commit: 6584acd42820478910a771efb28a355a707e9cb0
change-id: 20260831-patches_v2_external-36421e557430

Best regards,
--  
Srinivas Neeli <srinivas.neeli@amd.com>

