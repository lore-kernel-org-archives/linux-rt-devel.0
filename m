Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.126
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348124;
	b=J3ZyMfhDmKFPqC/8ktN2lM7z11BtpfXRC6JDoqOmEgUjtCzRXH/l0YU9BTb4Xi5EFR8x
	 8Ef6m2KYUJ+v7o3v7wCecPyHys0xSbkeCpyfsJ9OaoX6IS1W32sjhjLC7HZYQo91UDRtT
	 Vg7gEDAgTsPJEYTS5K7verTLGuexaDO2GVCFmhE2vMUZFLIvMNWWJtqCslh3m3rgMeE9e
	 XFTUy605k3l3C2OgT4vsVS7pTyd64+W6S6HPP3dvhqsk6LVYsXk2EQHJEM9SqlU7T9n8k
	 4VVMrjEBhJY5L+jw2ikl0Mf/knw2sdwbZTvUSwX6Gud6Lk2pVrnPZzWjN/55BkjDGSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348124;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=EPWY86Jl8JPm3FFXtIzlMu2CCzJzgX8axZImHcjclTI=;
	b=pwT8jws+BbGPqFI9hC22jmOWioREtkloZ0wUW6Y8bjr5t3157PNvRYKLEDlo+54Zs2FL
	 poTJ6Me6Py0GQtKM/cwZ03l8e73NSuiE0tlp8lfBsCCLlOAql6KmWQ45mhz7gTD1ac1Yb
	 9/wjH7xmEqJe8r62pbO7usxx5R+zl2yO/ECMWYm2DT0nW7OS3pE46pDbKYgc8mqlZyPMY
	 5XPgB2wI7AuVPpVXPIHECOrKGqOn4ph8OzqIDPg3mg9+EFVvQdDx9hig2fDRv3+ofAtkm
	 +Up1gy3G4bBTNC09izos3P4V5EabX6x4xNPwGdx501Wi7lhbu08L0eYgoTnXaiSLl7Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=ILW5wbhL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.126
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2126.outbound.protection.partner.outlook.cn [139.219.146.126])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6AA606A324
	for <linux-rt-devel@lists.linux.dev>; Fri, 30 Oct 2026 08:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F6AA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=ILW5wbhL
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfYngSUfOFsjh9KYmlBPQd72sO2D3CFYnNtKcqwn1bv/DgHSpqCg1disDQWl86K98gwzmEqRKqY2OytKLov+ua45kLfubFBTjCKufLs4bkAzmjfGcyiDDYM0hjdCB3wtB3T544FbJaaWc2fXcRGezncQhoJLTiua4J4BqrXjH1sIQBxtv0P3V4OQ0epxiz8v6SS3fwuBdJhROda8WpSFGXcSA+LViLLshS+E+NlK20QzH88NdAPX/FxH40nF6QSjgW/XEkXj5u6uuNtmFGmYunbRKFvkExP/Vj1OU9SVgXFkYO6j/up3TuD74DBXQGGXKqSIrCWy3O02buDSvSzyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPWY86Jl8JPm3FFXtIzlMu2CCzJzgX8axZImHcjclTI=;
 b=CEmhWedA4dHTgV6Bi1789LOZKCC0YJxNw+ZH+nFUmerq+ga4DH1kuOVHIUKU/AzMu57Kp+AvO4Y+zOqMsz7KQVDm28V4fYizPy3KlPEAIWjL2+4W7UDK5j8ppaIYwK/0t4/8yKX6On0ZjDf1py2Jx9j+C1w7lSpgFREwphpWNv7IuSHZCPPuhvhy/vwh4EVrHYSWAr2HAvDZXnCGphImKt0o/8bm3lOv9GwwBquyx6ciQC9Muc/AsVATrVy/Z4iJeDTg8BFTrE3mN8fKRGiTWAWYiw7G931UvExqc1qN2sqkAy2CM3mn+M3hmHfPmjgX6PkVkdaVurrNDSrpFqJWSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPWY86Jl8JPm3FFXtIzlMu2CCzJzgX8axZImHcjclTI=;
 b=ILW5wbhLmz47Y4+4dheVVHxW0NaTCWkp9wuEm9H8gILAJn8MNY7C7muUe2tXxeIn3P5rHFfjkIndK4im61Gi0GFgXaasu0U6FQRqZAStk+5B9I7wkRHMOCI11ef7aqlE3GtsRaKdTQtbJRBosfFcFq+OiXv8HULd0+lJr+gjNfA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:15:12 +0000
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 ([fe80::197a:1934:4b5b:4520]) by
 ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn ([fe80::197a:1934:4b5b:4520%3])
 with mapi id 15.21.0569.008; Fri, 30 Oct 2026 08:15:12 +0000
From: Jingxuan Xie <jingxuanxie@deeproute.ai>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [RFC net v2 0/2] af_packet: retire TPACKET_V3 blocks without waiting for copiers
Date: Fri, 30 Oct 2026 08:14:38 +0000
Message-ID: <20261030081440.251635-1-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SH0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::26) To ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5)
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB0982:EE_|ZQ0PR01MB1239:EE_
X-MS-Office365-Filtering-Correlation-Id: e57bb457-762d-4f17-6b55-08df365deb6f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|366016|376014|38350700014|56012099006|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261022075727099003|10067099003|261021135927099003|261021121427099003|261009223027099003|261022115727099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vtthhAna70LmBvArwjy/7IKaH5aedKN0iLCrqvzpZJqswp3i+HUS6XJPFhdOMme2PZAFfOFed84ayvSyxqqeL8RrJh7ECMQiNDVEQCFxew9ApikCGbZH1JoZN6ImPuS1RvNXDtcFaksdrLMCBWMRgoQtFTztFWAuQToM0U/OGvY4Pp2dFy4ad1rQ0dLzGTI34I2t9wBibdx1Et9v6TXV5Oyvwz5ea3GykBO7/HoaD5f0Z8DT5Flb+Hkupn/WWUEnU1P8IpAMv0WpdKcM5Xie2IIqcHCI+MghLtcqyhvWSBKKvj2RerF8nXcek/lHT7VA8B6oGA4O7TDdefUesCpHJIKd4UcEB62fkaA/5/9ALM3InQEflCWInF2QhyWoWhRSYN8R0VWvRxwb/P3h3M3xmdPPcn3BnaV506IO31mMKV9KLfzD0Nb59zIxI9/M0dOh5m3o33uxsMKqzhVIAjagYSNj1MkBeS7x2xJGyDpcivoC9ZRMaUBNpM4bz6FU73xMc998AcHvRg+ENw7G7PslmWvMeEaSuy4tN/U/XqhfWfs2H8Y8XQ3L98VsOkLsPjwn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(366016)(376014)(38350700014)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022075727099003)(10067099003)(261021135927099003)(261021121427099003)(261009223027099003)(261022115727099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P4miUgEFnYKOWJW2M3moPbqwfjsscsbPfZKgUpQBU8HUkdAhF7bnEZ/Ys1KN?=
 =?us-ascii?Q?xtCSBhHkZpjo1dqba4tGVVk+n9fjbwBq1ckiniqUuvCP2t5Dy9wAjTETPhc1?=
 =?us-ascii?Q?koc4CZpJmKZl2ykqK1Na3G1QynbAWsZ+xK3iI8Y9FboGnrAxfnRC7igWcobr?=
 =?us-ascii?Q?ZysP4V539Vj/k6602URbnr3adUTAH90WRTll4Rcgtzy1x63E3VJtlYLgJSUN?=
 =?us-ascii?Q?IYQIic6+bKJ0/dxoVV4VqWdaN3VkKpdbcZZ0ObjDWO0WAGBusMxs68+9YBM3?=
 =?us-ascii?Q?l2Ex8qW2evyqq0uMCyArIwLVB4kLEBRYuHJmeItTVk2P3BUvwNbvXttR39C+?=
 =?us-ascii?Q?jUIaWYN7IBC9nu4L9y5Wpifj371xA+q6Eznb1IaP1MrRukDSl2QOK6fVsMKg?=
 =?us-ascii?Q?Ur4s/mC+c15RixgzrKZDL4XCQiLOJBV3xD7SFh3AZVBQdOtsql6rgHNOPCCu?=
 =?us-ascii?Q?pG6temwTh19IJ4gpB/mteqOxyX+lA/sR4IYo2hXLYPo8AAwIc6f0IYG4txWA?=
 =?us-ascii?Q?PlKsHaTVbtV98/U3M2txaHZhUMoRnQuQaQzvef6x+Cu/h9Plv9NIWMG7ipHI?=
 =?us-ascii?Q?h6F+5neDPR6qCCnB4wfBzsLFmikaq5CwFw1ZOZVC5s/SVWXHB8ac2S5bLV4E?=
 =?us-ascii?Q?lvvodMNHWZq+gy3tSW+H49EhBTtfbfBCCsabsS5Z2U+mAQyXB9xPQ4Xj9+ZL?=
 =?us-ascii?Q?198T4b/GyT+V8SK3Y7lZ6f9IvrKvia0eEkmQyXkiIU9Qsbrbzv+rn4iBMvDj?=
 =?us-ascii?Q?gs8qOG20Q/6OSZRw/+TcTUiFGO6RDkmZb0nLFhuVFn510pJjJ56Sc7NRTYfF?=
 =?us-ascii?Q?Oskdm7xOFpXsQ+aKrS5l/UDAFJLBtJ4Hegl0N4PVdAexSpbCmzzOEde12V/u?=
 =?us-ascii?Q?q0kPbOBvTgJUxhr5KBOXzpFWkYC0kFJjbHfBxCSuS63o3/1QpHM9OViHHZRn?=
 =?us-ascii?Q?l1yGGXOQVoclzWOhB7SikKWYAkatsT1b9bW1I4BwwiL6y4vAHdcQOPxV7Uxj?=
 =?us-ascii?Q?hpHMSccmIz4Miny2uPT7AqG1/ve7tr3XBGE/U4C7i2PxjPi5zz2K0yvmx0TL?=
 =?us-ascii?Q?DnXU+iS7IdBhpKAi5PTxgBlNvZWDomQNKFVIdt4VLEFXRw5AHDL5HLst9vmK?=
 =?us-ascii?Q?a1dxV/SOYWqeAIrhVr3uaiePSKJA2RFDg4eWxOJDLT3IEW0y9z544kVxuqLk?=
 =?us-ascii?Q?RrvarwXXkbeoOc5WxKSS/Jm3Vtm5ffB5gALLJxWsDT6rLm5l5y+zs9U1h6cW?=
 =?us-ascii?Q?y/DeV7uWqmGN7QyGVgwKLO8RSptiGkZFxzsKRfaLZ79bYcsY6Gf1swvbpDQ2?=
 =?us-ascii?Q?0gb0I9vToEzsz9ZWPmdFMTPKPyLanxVIpjGP25Mk4VwQScoRnVl6f1b1vR/q?=
 =?us-ascii?Q?y5pe8IeWQrY5MervlczUp0Sy0ak2ApG6W6yZ50uOxIK/+fLE1AuVLUKR0E12?=
 =?us-ascii?Q?GnbDr1Q0FUymggc4IYwBUPZfDoL6GV5lUvTgR9Tr97QD6aeVajzqDKc/BPhO?=
 =?us-ascii?Q?z/TSYDbN8fsMqkeiuqpiAj6yWnPOh5kNg+Ueui+kwv1gkMJbAXUKir+KB2ue?=
 =?us-ascii?Q?yyzlbWhzT3hFHfkjqegaOAwm0WZED4sPBWqEzMIyQlVLXekzW/Q7mD+V2NRs?=
 =?us-ascii?Q?u/w+LVwobqhDCr3yemnETr/I+ICeE7Gnzvl8jeeI3/5zPuUJeZWciCVtxIBO?=
 =?us-ascii?Q?Y07zlHOFnkhvYOAM+iXikjnCgUBgj5bqjrYeUPRYxhIuHruxs/Qye6NXTV7T?=
 =?us-ascii?Q?UDsXWrcR7A=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: e57bb457-762d-4f17-6b55-08df365deb6f
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:15:12.0459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wEPY4E/VeJmPVXsqfCvIDWA4rRItOd/ieK6iOABB7Pg6enh+/VRYqcrqn/0hi7HWcVJk6GCkY+20nCQsWE+Kbo+eq79hyEvG88mtyDaR7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1239

This revision keeps asynchronous block retirement but removes completion-si=
de
queue locking, the four-state enum, the eight-block publication budget and
the workqueue used in v1. Private copy accounting now lives in the existing
pgv allocation. Packet allocation and the existing retirement timer publish
ready blocks in order under their existing receive queue lock.

A preempted copier in a sealed block does not prevent capture into the next
available block. Copy completion only performs a release decrement. In the
absence of further traffic, publication may wait for a later timer callback=
;
there is no hard bound under RT starvation. A finite ring can still exhaust=
.

Patch 1 independently moves virtio RX-header preparation ahead of frame
reservation. Patch 2 implements the retirement change. Neither patch change=
s
the mmap layout or adds a UAPI.

Changes since v1, in response to Willem de Bruijn:
- Split virtio header preparation into its own patch.
- Remove the second receive queue lock acquisition from copy completion.
- Remove the state enum, separate metadata allocation and worker lifecycle.
- Replace the fixed publication budget with a loop over existing ready bloc=
ks.
- Use release completion and acquire observation of per-block counts.
- Permit idle delivery to wait for the existing retirement timer.

Testing: ARM64 QEMU virt, four CPUs, PREEMPT_RT and lockdep. The unmodified
retirement logic blocks sender B behind a deliberately delayed copier A.
With v2, B completes capture before A is released, for full-block and timer
retirement; idle delivery, block sequence, lengths and payload are checked.
The delay is introduced by validation-only kernel instrumentation and is
not included in this series. Ordinary psock_tpacket and psock_fanout pass
on uninstrumented RT and non-RT builds. External validation tests exercise
the actual private helpers; LKMM tests check multi-copier ordering.

The ready-block loop has no fixed work budget: a large ready backlog can
lengthen the receive queue critical section. A validation case publishes
1000 blocks in one call. This tradeoff is explicitly retained for review.
Separate RT KASAN and strict KCSAN runs pass the helper checks, psock tests=
,
delayed-copy tests and concurrent-close test without sanitizer reports.
Patch 1 also passes an independent malformed-GSO runtime check. ARM64 W=3D1
packet-object builds pass for each patch and under allyesconfig/allmodconfi=
g.
QEMU does not establish hardware NIC or Orin integration acceptance.

v1:
https://lore.kernel.org/netdev/20261028070528.139531-1-jingxuanxie@deeprout=
e.ai/

Review:
https://lore.kernel.org/netdev/willemdebruijn.kernel.31ae9fde05c@gmail.com/

Base: fcc00b15cb21a6de76826e5012b2c758505f5e65 (net/main).

jingxuanxie (2):
  af_packet: prepare the virtio header before reserving an RX frame
  af_packet: retire TPACKET_V3 blocks without waiting for copiers

 net/packet/af_packet.c | 162 +++++++++++++++++++++----------------------
 net/packet/internal.h  |   9 ++-
 2 files changed, 88 insertions(+), 83 deletions(-)


base-commit: fcc00b15cb21a6de76826e5012b2c758505f5e65
--
2.25.1

________________________________


=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=8F=8A=E8=BD=AC=E8=BD=BD=E7=
=9A=84=E4=BB=BB=E4=BD=95=E6=96=87=E4=BB=B6=E9=83=BD=E5=B1=9E=E7=BB=9D=E5=AF=
=86=E6=96=87=E4=BB=B6=EF=BC=8C=E5=B9=B6=E4=B8=94=E4=BB=85=E4=BE=9B=E6=A0=87=
=E6=98=8E=E5=9C=B0=E5=9D=80=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E5=9B=A2=E4=
=BD=93=E4=BD=BF=E7=94=A8=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E6=94=B6=E5=88=
=B0=E7=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E5=AD=98=E5=9C=A8=E9=94=99=
=E8=AF=AF=EF=BC=8C=E8=AF=B7=E9=80=9A=E7=9F=A5=E6=9C=AC=E5=85=AC=E5=8F=B8=EF=
=BC=8C=E5=88=A0=E9=99=A4=E5=85=A8=E9=83=A8=E5=8E=9F=E5=A7=8B=E4=BF=A1=E6=81=
=AF=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BB=BB=E4=BD=95=E5=8E=9F=E5=A7=8B=E4=BF=A1=
=E6=81=AF=E7=9A=84=E5=A4=87=E4=BB=BD=EF=BC=89=EF=BC=8C=E5=B9=B6=E4=B8=94=E7=
=A6=81=E6=AD=A2=E6=95=A3=E5=B8=83=E6=88=96=E5=88=86=E5=8F=91=E5=85=A8=E9=83=
=A8=E6=88=96=E9=83=A8=E5=88=86=E5=8E=9F=E5=A7=8B=E4=BF=A1=E6=81=AF=E3=80=82=
=E6=9C=AC=E5=85=AC=E5=8F=B8=E4=B8=8D=E6=8B=85=E4=BF=9D=E6=9C=AC=E7=94=B5=E5=
=AD=90=E9=82=AE=E4=BB=B6=E4=B8=AD=E4=BF=A1=E6=81=AF=E7=9A=84=E5=87=86=E7=A1=
=AE=E6=80=A7=E3=80=81=E9=80=82=E5=BD=93=E6=80=A7=E6=88=96=E5=AE=8C=E6=95=B4=
=E6=80=A7=EF=BC=8C=E5=B9=B6=E4=B8=94=E5=AF=B9=E6=AD=A4=E4=BA=A7=E7=94=9F=E7=
=9A=84=E4=BB=BB=E4=BD=95=E9=94=99=E8=AF=AF=E6=88=96=E7=96=8F=E5=BF=BD=E4=B8=
=8D=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=B4=A3=E4=BB=BB=E3=80=82=E5=9C=A8=
=E6=AD=A3=E5=BC=8F=E5=8D=8F=E8=AE=AE=E7=AD=BE=E8=AE=A2=E4=BB=A5=E5=89=8D=EF=
=BC=8C=E8=BF=99=E9=87=8C=E6=8F=90=E5=88=B0=E7=9A=84=E4=BB=BB=E4=BD=95=E5=8F=
=82=E8=80=83=E6=9C=AF=E8=AF=AD=E3=80=81=E4=B8=8E=E4=B8=BB=E9=A2=98=E7=9B=B8=
=E5=85=B3=E7=9A=84=E6=83=85=E5=BD=A2=E4=BB=A5=E5=8F=8A=E9=9A=8F=E5=90=8E=E7=
=9A=84=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E8=B0=88=E5=88=
=A4=EF=BC=8C=E9=83=BD=E5=B0=86=E4=B8=A5=E6=A0=BC=E2=80=9C=E9=81=B5=E5=AE=88=
=E5=90=88=E5=90=8C=E2=80=9D=E3=80=82=E6=8E=A5=E6=94=B6=E6=96=B9=E5=BA=94=E5=
=9C=A8=E6=8E=A5=E6=94=B6=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E6=88=96=E4=BB=
=BB=E4=BD=95=E9=99=84=E4=BB=B6=E6=97=B6=E6=A3=80=E6=9F=A5=E6=9C=89=E6=97=A0=
=E7=97=85=E6=AF=92=EF=BC=8C=E6=9C=AC=E5=85=AC=E5=8F=B8=E5=AF=B9=E7=94=B1=E4=
=BA=8E=E8=BD=AC=E8=BD=BD=E6=9C=AC=E7=94=B5=E5=AD=90=E9=82=AE=E4=BB=B6=E8=80=
=8C=E5=BC=95=E5=8F=91=E7=97=85=E6=AF=92=E4=BA=A7=E7=94=9F=E7=9A=84=E4=BB=BB=
=E4=BD=95=E6=8D=9F=E5=9D=8F=E4=B8=8D=E6=89=BF=E6=8B=85=E4=BB=BB=E4=BD=95=E8=
=B4=A3=E4=BB=BB=E3=80=82


Reproduced in this e-mail and any files are considered top-secret documents=
, and only indicate the address of individuals or groups. If you receive an=
 e-mail there is an error, please notify the Company, delete all the origin=
al information (including any backup of the original information), and the =
prohibition of the dissemination or distribution of all or part of the orig=
inal information. The Company does not guarantee the accuracy of the inform=
ation in this e-mail, adequacy, or completeness, and this produces any erro=
r or omission does not bear any responsibility. The formal agreement was si=
gned prior to any reference to the term mentioned here, and the circumstanc=
es relevant to the subject and subsequent e-mail in the negotiations will b=
e strictly "comply with the contract." The receiver should be receiving an =
e-mail or any attachment, check for viruses. The company reproduced this e-=
mail because of the virus caused any damage resulting from not bear any res=
ponsibility.
