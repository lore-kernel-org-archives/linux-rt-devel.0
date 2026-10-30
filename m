Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.90
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348245;
	b=1P9sWproqg9QEq0Y9BTDSvhTECDveQv/3ucFrYDGTQoy+nfSeOSd+jRMgtAzGmttflra
	 0OnnmCEfkHfXE5i4gigMnNMHbQMZZUx1KOsmm6frHVXkw6wSz8E0JR8OEvtO/C48SXZcl
	 mrIHyb83mN/biTVsoavmmO7kdN1w0rVxToO8CzNGgqtD0DpKdZixzHnuXlhr3iMf0Ardd
	 vClTVIrqg7RgN7OgSaPH740ffUYYXsYsQQZD74n+eqxNAUwtVQcW+zaWwf3kYW7RVjYmD
	 p8zWHuPNQR4zUbIqznQlcUG9ijif7m00p3ROMFCQgaJGrAj0EoSBwB4FMTYlfMyLRCg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348245;
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
	b=1916f4Yxat/9cpydWPPQzuxvqhgbse4A6pSuo73VxpbLJeClm68hSShRafoPzSQc+jyV
	 G5dVljiCmKK4P+md3kw3Ah9okvd5SKNPMMckpJzTsKCMtVBlWicCwfQFu77UIRcNJtgw1
	 ot/8fwtG1JjZcTr14sDZ76WNVwfPxkAWOE6akmWl/ki8Kfiq/2zUswA6Chw36E1guUaLH
	 0+ZxX/6bpaSS7f9lN2SiiDXl4OmqvMWzL6e5SO9SGGuFxiQtS5LBhTQ7GLLI7mHzqX4wR
	 PG60NNbUGcp6FMhCbvrkmVbqhUbKNsRnnewfCmz4W6/p8ngqTv76VG3dOhGMDx8fzKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=nSwkJupH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.90
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2090.outbound.protection.partner.outlook.cn [139.219.146.90])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89689606A31A
	for <linux-rt-devel@lists.linux.dev>; Fri, 30 Oct 2026 08:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89689606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=nSwkJupH
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YhkDd7pt/oBju2vcChFUjcqjNNPSxgomhdQRsrOFtp5+Tdka7ssQ6coQsN+AE6VStSKNQw9+Gn620QCZAaUJT5cos957UiLXYSKZGnKX/j3Zdt/tpRPnAIfUzfI/eJZBHW5BICBZpPPf//hfdwADny5bYHH4TG4kO37LTI3Wvu2Spd2oNhTYp9CWQhY9IuvFLtdwxFIvAjjZfTujUxTq6oCm+PU8sx7JfSNG32+T+PfntEoVjOUOVmX73MtvoHhvFWvyeV49y7pWRmfWzD1lJiYAsEK4un1mD6fA0xkn1lLFYElAe0l0GzkoyazXNViaVxz6FE/af2/+jWGwjEHwgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPWY86Jl8JPm3FFXtIzlMu2CCzJzgX8axZImHcjclTI=;
 b=KMaTNLz5Ua02U97u/EvQkRkxd1yUxDfxQJk3J44WaDgJU1ms677o8npDojjt2Hxzkoyja91cWX8stEx94EWfQrH/KfllUz9BzErl09mE6RikKxOaZx1+lT/MOF+RBn6pqBi5UnIc65V2WfbgMzVnNGlxQv5xW2dL0Vf8PPjynKA6MoTIWDvVN+9AXRdaf6eRL9kMuD7LVlA5fvIfHUKbBTiS5W6vHcSePmdne2nxXLvP4F0wtcl++OxQppvWM0JEXsQmto+ZDRCPMmBK8IAZJhC7PHCaipxtbN8n8i8GFGK6Pfoodpj8ddOqiO+663zLSd9Svai15Er2c3hfJSKMNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPWY86Jl8JPm3FFXtIzlMu2CCzJzgX8axZImHcjclTI=;
 b=nSwkJupHU4N/0s4KgeJJqkIwgnw3PrBYEViHnqPoU7UA4P415Z2YWsBTRLZn43fdHGV891xTt3qpCfj6u2s5jxjw+eJA68wSGznrJPk9LJjAtw4K8wBD0iHVReUy81PDvjY3AdP1oxld8ANQZFpgRrb2OeZUOhFgO6m1laJe+eU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:17:16 +0000
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 ([fe80::197a:1934:4b5b:4520]) by
 ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn ([fe80::197a:1934:4b5b:4520%3])
 with mapi id 15.21.0569.008; Fri, 30 Oct 2026 08:17:16 +0000
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
Date: Fri, 30 Oct 2026 08:17:02 +0000
Message-ID: <20261030081704.251652-1-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SH0PR01CA0008.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::20) To ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
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
X-MS-Office365-Filtering-Correlation-Id: 6e9a80bf-33a6-46c8-ec6e-08df365e359e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|366016|376014|38350700014|56012099006|261028144727099003|261022105027099003|261026140227099003|261026121527099003|261021123027099003|261022075727099003|10067099003|261021135927099003|261021121427099003|261009223027099003|261022115727099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	So2vNvEwipyA13MXnTo+v2eCwDP2uO5IC+iNWGLklTfx3j8Jbm+iMpuSVhPTwTPAsoXIXDo4NV5hYrhq3Qho57NJk5udWVqf3p74xPdZNPrrjIyppbj5I0PjoNskaweTNXw6nrlbCnEl9Go4ht+zRxAJq8b/IvaCh5Ndj0GcK/Qxx8sER+SbwD9gpcjdwF5uwx/99x+uhQBbxyhrA/SOOnJPHJzt1LDDEFimOsUN8TEAr1qTajoz6uG0rZcCrHDh/iy6oEBdqonn4SO8Q98MJFLENgCmptC77m4IzGMNVBcJJUdP7h5Mb8HQ/thEc4QrpBWcDn5eUZun05Bl7dSYb0Vv0bSJ3PCXQZsWJ/9+2ev9DT+icV604Hg6wB2jdB9u6+I0CyF1CkYUFoSuQ8a7fNx0G62JLB5Lf6XjisbuC3XeC7B3JXS8a8W4rPKAUqIAycNBhURYyjpc7H6XjZMmaaDq2Nl1BlKGsou9moMza0yuQsszSNfjXu3xz/nahIHe0Y3IMwgsxna0c9gD4vVhuHMBhTSEMQzDXZgjCBGnvqZQofl4ZSx6MIs1FnM47y94
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(366016)(376014)(38350700014)(56012099006)(261028144727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261021123027099003)(261022075727099003)(10067099003)(261021135927099003)(261021121427099003)(261009223027099003)(261022115727099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jnz5OC+PGqEUuFkW0Pjabxy+iMFserRW8bSILMaqfoUzgiyuCID5WU4cmR9E?=
 =?us-ascii?Q?HrHtuyxyuuJI80UwumaPj7PDtR0G4du4jhVrdowpKg9IPUaFdv4uWgwLHPrL?=
 =?us-ascii?Q?9wn8MKrTU8Xw2fVa2X71gAEfHlB+QDzwBYNnE+erJ8nuOioZsCcny+bUPmEm?=
 =?us-ascii?Q?AyvpNAIsH1KfMxgI6544UtIuU8ODYfrlV81H4DcOPoqGIJrfs1eQ6+38Spx/?=
 =?us-ascii?Q?e4NsVVgjSGSrG3yD0U3A2Ll0pKT4551iA1Du5O1EqeTvSEvc76ji3hNe1FFq?=
 =?us-ascii?Q?I2WS5sllpkk9h25Fh4HmX7X8DgeCgA9AcAU5ZSpX/MsImfHOUUlxivbaA6As?=
 =?us-ascii?Q?W3FGJLRiOHyTy2uG3p1sbAPSeZJj52McxvFB/AXVuVqVUI6I2aq6MNyfLdZf?=
 =?us-ascii?Q?K7v8C7rpIe3Eb10HB3klYETw5DbvJalJW4mcI3kVFID/il5LtwoVzj5T830T?=
 =?us-ascii?Q?f3/XgS2R9mjoQcBx2gKlSbnI1i4l76/ueKZhET0VGCg2gP4GdCrT4ngO2mCH?=
 =?us-ascii?Q?II4MABYLtVy9odLrqJ7i5cx67g0QcPT4jfDeaAco/kjzrbYSRZUdmOpdMCS6?=
 =?us-ascii?Q?Nl31lf95HLC0S4WkxkU7tLPz74J6tFlsE1VXjZmaYyLD+vriU0ueWLGMV1XD?=
 =?us-ascii?Q?2y1Oc8umc5KiXw3/mVkcrN7kM9Q7vqWVc1r/YOOaC7qSmY7B9M9BTnE9iX8h?=
 =?us-ascii?Q?kQtSCELMISQCP8yTPDD1XJBbZToMXsLDWxdjOhY5R7yUdJXpzRQXi9k0di9M?=
 =?us-ascii?Q?kBjlSj5W7o0m3XeMsYgybmLFHWkAFh+80shv24Y7wt9cVD5Gmw85zMnhtREK?=
 =?us-ascii?Q?kOA7Hi1e0T/lg8olHqC87fmZQvkwYp2CavUQbp+jMEpnHaVIi9vpLwZbk7pj?=
 =?us-ascii?Q?Eve9EZ2ThwA7fJHsAJ6+J/f5bcNW8TdoZH+E6VhhcFP/+i3XnBfHtCsxq9/m?=
 =?us-ascii?Q?XYRTVDhwkY6Hv8U5InsBHQGll8b6peuwV9TAaQb+KVoai7GKkiHwXupYE14J?=
 =?us-ascii?Q?IY623OCPO0wMZbRTG9odYF1egkDBvUId++iNwokxHuW9VNKY0dGZTeLnOS70?=
 =?us-ascii?Q?p+bpkga+2J8sd1QAoXYZ4VeQ6J6lz9gkcH65+9SbCkakIUfYRTkErEk4Nd1X?=
 =?us-ascii?Q?XBtHQycZP8AASnq9lS8LX+JQZm5IyYpBo0Iyxj9i9q4TQQmNdtaEsZim4Tk4?=
 =?us-ascii?Q?zwE6aasP1o21beIK9JS8ilFzhUgTIuz39tJsaPfqN+4lEuOX/UMrTDYdhFES?=
 =?us-ascii?Q?EPNli/AjqihyvD/HpyA7yEqUtDWYzIWaycFYv7jcbRCh3g7uOMZB3YkbkdNu?=
 =?us-ascii?Q?Y77Q1tjxN53tuRpoLzHchkIa6e1xQtP1x7ZWBlTtlBzupBMJmPclVwBEshfT?=
 =?us-ascii?Q?hEGeBYpvNxQDhyGDCUoPcLquD61gvlkMQp5FjysqNOS/OChxi+DX86Qp1lHg?=
 =?us-ascii?Q?5B9BMjGubh0yAj0XpRPRkTta/dU2ACwCLu8XlCfM4GvzRytwKl7pUI8nUzW0?=
 =?us-ascii?Q?CtCSawZO+vQ+RmZ5SJWqL+TjYG3Q28l5DlnFOmvn9rDS8EQhw7JPxk4/4A5i?=
 =?us-ascii?Q?895DoV36ELmNHEvm6VuHSyVMTyTseBDoTo+4foQ6/YKRDLAkxtaKq4ySnnZC?=
 =?us-ascii?Q?ERN1m9DPjLjcxv7I40yGatqpX7CaedTOiG5+R3e15ufo1D2wYBqA3VZPvfgy?=
 =?us-ascii?Q?OnOqLpLJLPM1lkPWwvezPCR4pZUyjeirPiAGRBzzbFe4JIQyyir63QMaMdsr?=
 =?us-ascii?Q?aslzrd6QEw=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9a80bf-33a6-46c8-ec6e-08df365e359e
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:17:16.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tQn/RdjvU19ota0zcTg3LNJunqw7nPqRQS6Zi3/UoLgY4KBb+EXLJo3xLwfBZMAhebt6+H0Oj88prG+f2i8YgYwDB7DqDOzBE+hcC+pESS8=
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
