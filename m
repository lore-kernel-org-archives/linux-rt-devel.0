Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348249;
	b=boDqB7MYSwvYia1yT+OIBReMMGI5oHE0Y5rulzLjEi/XI+oyw3DbLkQ6OKTm1j7IDQYF
	 PdJwIKcNiJpsohdjIbDq4ssMnOW8Cm2ndCBEGWiSEXMNwA+jykkY7ar00AMk/Wzv91D2V
	 PJXBY/BAJ3Q2t+kJjA8ZqyB7UGv/W18MCNrOQQINJ21PS8BAF8TZIdSycWCbRb6fh1YqJ
	 rt+csgrSRO71vz0hroMDib9lhx1iTkxxSmQ9DLXBYzhB7JSU1jE7wzdunkIsMin4hIQ35
	 DFHeUgUfAx8DM4e3LotxmKSwM6o3PtqZw/46nUAFcilLmRprzQo6XnKvgcSRl3TvfNw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348249;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=a7uKBDmelTul5hGRH2P8jTfQs2nG6n3F69DtU8FuRRo=;
	b=rkH3Yn97Q2a1jTZpPs8hJ7jZ1aeSaD5rkgYywJ23H1M66eft/aaOswZBCvOTOanMVdnS
	 YFh4w85IxTQOmuGmf+e6wwsBWshD+JUy367obgEnmYGJ3bYZNRVTwObpngCZSt5D9M6Wx
	 ET7HT2iOzqmLCuTWixsheEr9M9chciJZslbWfpdWCNdLTCwwmTI0m2VlpRKOcpC/n0kQn
	 i3kLvy5zxa/MsvQ3obXBomsOMhc3wdN4VWXLATIL1ELiZ4uuUzFrKC1yW6o28LRfzdCK9
	 c122fjEkIsy5QF5h6Lae+53OuGOvY7DusHBk/dmLfueUnOzuy9qyuWQTkFKuzVZZmKw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=n00MBMtG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.111
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2111.outbound.protection.partner.outlook.cn [139.219.17.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B08606A331
	for <linux-rt-devel@lists.linux.dev>; Fri, 30 Oct 2026 08:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76B08606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=n00MBMtG
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLZn8OzYIhTORM/Nc4O3wEEjeUJuqg80e8N+Lg9TgKFeaMiUfl8umvDuIw6BiQZHcsSGb8tFvWQglsWsTvbH72TyEjeZEa9+3Bo2kSpx5m8TdO8AZdfEIS0WykdlxUPIgJ0C/LHtIS79DxrLMum4sqEauM3/EGD3gFVcdCFqFr2W2goMt3IF+UiLkDDJA7lhm1Hi5Bi0nQUs3i2ylwrcWZltYX9Q7WJjbovDd1PNYmKUJoe3XFbfcpCJxgnunu7qtkWEWpiPIznZOBT/lPEloHZn6pzC+sfSKHsRCPHDfu8qdmhLvW1rSwGSFyCCBLe97E0LYSP/Ujc1bAJ9IgJvfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7uKBDmelTul5hGRH2P8jTfQs2nG6n3F69DtU8FuRRo=;
 b=LnQp3gFnjzLzPVeOPuE8R4MyxHypuZXexTf3u7fM1c2zIObG44cXXIs9Kjn5Llik79NCObRVMPtP8F6odKgzmzpj4NC/dIpl3f+E8jcS1xb5TRP/lqQ5677t+FvqyJfb7ACz3w0Cb1/zHLX0pObY2SqWttVNRFk3JzML6egPKljvXEceqR2DazlH48GPKLqrOuMkN6kshIiFlBZMKtNiieFHFl7CPXE/1XXK0u6hLbr1DIOFilcz+/wgOZYjYiYKEAh91uviBf2SgOI9v4fmDBsMuBpV8l7pk6kk1r09bWCQ1pmlTfYO5nZrKxxMHORTyqpmEF0n/R0hCSMgeiGGPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7uKBDmelTul5hGRH2P8jTfQs2nG6n3F69DtU8FuRRo=;
 b=n00MBMtGTmlp11M5u5VFAdXN6GiVcrtdvpaNzs8rQK49OEsvukIJcjIz1axNE1V1MXCYi/zO7MsdJd4XdooeRNgBtOHJWtr1m5jF0eHd4FUTwjX4eDjq6reZH+F4bg1EpS6e6x4p8sZLrCXyVR+S598Y/gtWM677Tlw9fbluX7s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) by ZQ0PR01MB1157.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:17:17 +0000
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 ([fe80::197a:1934:4b5b:4520]) by
 ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn ([fe80::197a:1934:4b5b:4520%3])
 with mapi id 15.21.0569.008; Fri, 30 Oct 2026 08:17:17 +0000
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
Subject: [RFC net v2 1/2] af_packet: prepare the virtio header before reserving an RX frame
Date: Fri, 30 Oct 2026 08:17:03 +0000
Message-ID: <20261030081704.251652-2-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030081704.251652-1-jingxuanxie@deeproute.ai>
References: <20261030081704.251652-1-jingxuanxie@deeproute.ai>
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
X-MS-TrafficTypeDiagnostic: ZQ0PR01MB0982:EE_|ZQ0PR01MB1157:EE_
X-MS-Office365-Filtering-Correlation-Id: 59b291e0-0e0f-4ac4-eb16-08df365e3643
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|38350700014|56012099006|261009223027099003|261026130827099003|261026140227099003|261026135527099003|261026121527099003|261028144727099003|261021133027099003|261021135927099003|261021130227099003|261021123027099003|261022113327099003|261022105027099003|261022075727099003|261021121427099003|261022115727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jNFPbrPzJFMT55doFVURk56dbA/Nm+Ve6GFwxt0m17TSC8lHbPBPEooN3m5saKBuxH4i9VVYxdmS30uNuaNpdqdsBIzojHq6NGRXZC36aMbnn3Fr4gIsMXxR/B9SSSWqNm0cG/BW0P/3BRW1LGJ55inJBssXt1Lz1nu9fGdIEAWglBO4chzuBBkhqjrq3DfVNXyHi8V2wX3rmCZ95scN3bj1VAJgZtgMawBWfCkBX80TMX23SzNSjHcGKqUvrU1SGllHqMw42GeTKMB966G9Hkx+1/v+JLjVZDXMUDZaJEFGSKpUizG/XJ4d77wHi/bI4/5bZ0wJa5gVxNK9bID3cAujF/U9+lfj8s/xd52y9tuJSN2rAnNl3lug9ISpbRGQS4Su5tiCeCG1SPNwtsW2KXVKepb5u3flJ8P9gr6nkaTmMLMooadQmMaAHEs9/osh8TXZfaikutL4IXCGjgiSDqoWqNzayNEqhdMJI8dHZjIApUEFRZhZYPPlZQEvU29wml8MtbJWlOacZqaqsIU0uaWC17O8WFG+qwOzIyiOlxxNyYfsDlPIgPQFGTbZTobH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(38350700014)(56012099006)(261009223027099003)(261026130827099003)(261026140227099003)(261026135527099003)(261026121527099003)(261028144727099003)(261021133027099003)(261021135927099003)(261021130227099003)(261021123027099003)(261022113327099003)(261022105027099003)(261022075727099003)(261021121427099003)(261022115727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?toY3cjEKl7m9jNWTsAcX9+/goBCfrYgMQOSvEmI7SAwfykvZRJ05kxQ995+d?=
 =?us-ascii?Q?v09AsTfsUtXBiFDKiF1H3duPlByBczdJh7axgt8ac3sILHvowYNb8pu6HgM9?=
 =?us-ascii?Q?VofTYUt4YzEZwvBmEodNyAepyj0XVzc8i6fuxK96Pz2aKx8QlS2IyTAjrn4J?=
 =?us-ascii?Q?nuwQ21Ed5qoj6IZnOUZEZe/+wwUy/YTTQlmVjEnbUTpG1qwo2Y7mrSviYoE3?=
 =?us-ascii?Q?ele+VrkG6/KWEEjpL1SVGNdWHhGYM3mgxn9UJfu8aSvyijTHpva5e7EqcILN?=
 =?us-ascii?Q?27b+oE0V+AXJtMk5yT2m9KadX3L0+KUJgtmx8KhdOBN11uBhzLhColcdTjoE?=
 =?us-ascii?Q?tE1T7QtE0csOT2td7f++z4gecE6aqmLDMXHktA2w2XJuOaGK+tNl2Oe/LlUw?=
 =?us-ascii?Q?mgkquP4QzC6xzoODQmB3//joaZxqQxnOI8phhd2ff+luwuhNtY8Gr+UJxNmz?=
 =?us-ascii?Q?Pg4yxbA4JO9jVthJqRltdH5z1us5MRNi0UDWWPWc/bq8QEqUWq4Y4ebixVCf?=
 =?us-ascii?Q?hgY2Tit4nvlSr2peM41cGPV7WV7X4Ob149BiX9VeHUh44AuOH+KGJS0TvK+Z?=
 =?us-ascii?Q?6HdLfv0dkb+YPwIXUKwCVaLEtGa/jkq/S2dp/VDZsCDVa/uCPPIMM4icvMAt?=
 =?us-ascii?Q?URE9S08d2Jz9yilQKocP5F3eN2FmUJHskZb2u3SqNsePDz8555bvaKQZwRxc?=
 =?us-ascii?Q?+r6RPLZKPLCY+bH2/8/hjiBSYjR5FebZ4dDU929qfcS7D+maV66T91+shT/Y?=
 =?us-ascii?Q?dUV63I1qkeJzyN3TkEJa16bSMVY7ZrnqyuyG7a9VDz4GuIaBUOWun/8pXQyx?=
 =?us-ascii?Q?JbgUz4dqXQG531gS2YAiVze9XluTMWSY46G5s2gj7E+/nxQck6abj+hG1A/L?=
 =?us-ascii?Q?4TKC1cUlu4kp9o9AkZvzBXm/RvjGyKwRM9N6MhpatPHLYpKOoGSIgacuXIgw?=
 =?us-ascii?Q?DQtpBPcyumE1608Rd5C8W3c+UitzRvIaQ/YnTCTN8h5mWWb1R2du44dklAEN?=
 =?us-ascii?Q?9sDk1L2ZIW0k0EVm29QwKoJDbXUDF0Qzf9Pamc8lToXDX7+S5R8wA6ddfwP7?=
 =?us-ascii?Q?iVP6pEr3eKYKwyJwmEPKShmyIEi/4jvqQtIe0asMrftzqZ4VsYofBLrtcKYR?=
 =?us-ascii?Q?j+v/L/4bGaHCd6xhCiLnuCMqAGKzIzV2of/BdOr+npUMo3ehsH84HUyqlWFz?=
 =?us-ascii?Q?SFrfpwUtwhVT5Fi7MFPmMuTZKW69w+mfExFjxR7s1COguk3LDOepxA0nuOH5?=
 =?us-ascii?Q?SajKGiKnsqRHO87phNd68aS3ZV33Co0r3osy8bcXlHpVcS3/cWJmAf6UN3ok?=
 =?us-ascii?Q?bt7OUsBBeNEb9RccqIevtWkB/lhsirpTjCJ1CYXbSZv4cxYpiEZ54addEo2Y?=
 =?us-ascii?Q?ADFG2e0tFhglL0ywWgUrMTkUNY9SPq64OHowTgIqDqxtMRzzEzBdj4QPSpFR?=
 =?us-ascii?Q?BBZ7kh2c4pts+42EJhSyx2xBNeT8fEskxvjU6O5n/kZ+bkCHLWNBkAs2NgOe?=
 =?us-ascii?Q?GSVORndGw453YOF0DkAp6FEAonOOWOBrX+EF9srtugUIMFKHrJSbHAzDv0EF?=
 =?us-ascii?Q?uWh6AyNCA6FAq2hOFImG26I80Pc3d9HhRO8KKQxTplxo2E4/0f8IZj5apPu0?=
 =?us-ascii?Q?u+FnySAPMHgopl4VjjjGEK79FOPGaSi0v5RQa3d0TT24RtkFqqz17M8mIH38?=
 =?us-ascii?Q?f24mczt/OGZjbaSR15au721w9rdJFCPx17TZU01Lz/bq1r7tsZIA5GmZd4Yh?=
 =?us-ascii?Q?junpAS/zbw=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 59b291e0-0e0f-4ac4-eb16-08df365e3643
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:17:17.5871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxToovAo+8OnFNA9WqPZl6k/bBbN39SxlcYKY7d6HwyOE7QgMmZssgzmGxAhUy+22pt3rHyJYG3xjIoP2DrFQlaMMlsJ7N6ncbBqBSyzzXM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1157

From: jingxuanxie <jingxuanxie@deeproute.ai>

An RX virtio-header conversion can fail after packet_current_rx_frame()
has reserved space in a TPACKET_V3 block and increased its packet count.
Releasing the copy lock on that error path does not remove the incomplete
record from the block.

Prepare the header in a local variable before reserving a frame, and copy
it to the reserved frame only after conversion succeeds. Keep drop
accounting, notification and copy_skb cleanup on conversion failure.
This also keeps conversion out of the receive queue critical section.

Assisted-by: LLM
Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
---
 net/packet/af_packet.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c910..7b3e1e27f777 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2273,6 +2273,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct ne=
t_device *dev,
        __u32 ts_status;
        unsigned int slot_id =3D 0;
        int vnet_hdr_sz =3D 0;
+       struct virtio_net_hdr vnet_hdr;

        /* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIG=
NMENT.
         * We may add members to them until current aligned size without fo=
rcing
@@ -2375,6 +2376,14 @@ static int tpacket_rcv(struct sk_buff *skb, struct n=
et_device *dev,
                        vnet_hdr_sz =3D 0;
                }
        }
+       if (vnet_hdr_sz &&
+           virtio_net_hdr_from_skb(skb, &vnet_hdr, vio_le(), true, 0)) {
+               drop_reason =3D SKB_DROP_REASON_PACKET_SOCK_ERROR;
+               atomic_inc(&po->tp_drops);
+               sk->sk_data_ready(sk);
+               sk_skb_reason_drop(sk, copy_skb, drop_reason);
+               goto drop_n_restore;
+       }
        spin_lock(&sk->sk_receive_queue.lock);
        h.raw =3D packet_current_rx_frame(po, skb,
                                        TP_STATUS_KERNEL, (macoff+snaplen))=
;
@@ -2388,16 +2397,9 @@ static int tpacket_rcv(struct sk_buff *skb, struct n=
et_device *dev,
                __set_bit(slot_id, po->rx_ring.rx_owner_map);
        }

-       if (vnet_hdr_sz &&
-           virtio_net_hdr_from_skb(skb, h.raw + macoff -
-                                   sizeof(struct virtio_net_hdr),
-                                   vio_le(), true, 0)) {
-               if (po->tp_version <=3D TPACKET_V2)
-                       __clear_bit(slot_id, po->rx_ring.rx_owner_map);
-               else
-                       prb_clear_blk_fill_status(&po->rx_ring);
-               goto drop_n_account;
-       }
+       if (vnet_hdr_sz)
+               memcpy(h.raw + macoff - sizeof(vnet_hdr), &vnet_hdr,
+                      sizeof(vnet_hdr));

        if (po->tp_version <=3D TPACKET_V2) {
                packet_increment_rx_head(po, &po->rx_ring);
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
