Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.126
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348125;
	b=iSySLAhQj+UaTRLMosRJGCnQPxeyQZUbaJsTGw5CuikldFv/xjDhlbc4rvJRwKrBGxr8
	 kYV/8PciEi3sAxMnnKmapwXjIi2EVdWMcQUHD0OiZen96LfhtBSlAN2I5H3G0Muk9xbQW
	 EgolaFnZBZ5dudkTe7PSqnilcTf1zdSsmcQja5EDg4yt9K3u3UOhk+J8Bwz/Yp8xEN6tz
	 9/xZwrO9nnSVq/8NtUOxxb89N5JMqJJcG/Dh/HXqMNdQKO6qVJRiM+Af+d5PJVdTRTylD
	 YJ+muUud0zk6/lOsDjoLqvmXYA0fvtd1/nfiKl2cMIG7UvYK4arfwsWgnlMLaqWhpNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348125;
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
	b=FA+rP81oif50hr5PT59bNiwtg3rE0rBJfTELr6EERu93sRAW405RuwWOq5cPLGZSEvtP
	 wcEkif90VwIiZU4MTfQ+t1+UnAAQkJN3LHn+zfrLAshQokCpBJlha2F5dT74GU6LnV9a/
	 gxdVK7KXz7ti22s1MTMUx1+GoQxU7ha5WqT0UUCtiRlxsv5CnvUKWokq6rBkRfTW5ZyXv
	 +sbc/7mUHsDHCQan49UyiUMfYZCoT3K6Jy1Wo5vR/Pu0irmlNgeYgetZQkrBD39Cj3qT9
	 ZWjDl11zoHAIw0AWJYPdvXzktSsPl23gIE0AzWmmjznoYS+S0cI7QB/9bUqwrkTdnMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=W1VRpx26;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.126
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2126.outbound.protection.partner.outlook.cn [139.219.146.126])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA7606A324
	for <linux-rt-devel@lists.linux.dev>; Fri, 30 Oct 2026 08:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FCA7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=W1VRpx26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HIParGJoywhS/DooKytl/C7iu2WuisSuaLbK+CSJZVA5POhftlSP9zkFmOChxyuXk9R5UREq1lJu6miwWqSb41CAcnoFRKHvKNs5R6iYzTb++SKCmVE/itg8RRWbI7GxiHquYOVfrG+pYlZTEPAeRILui2ZXAQZmTnXkdJRguWUiTvEIFug6XBUXQg5jYQuVGkHBmvNvBgdwc9SDPLMWkWty9qPNfCRCAZjwcKofcUo56oH0cJq6wUrPCvK7Lfzv6HADbOgVGmGgBPBoZ/By8hRFcWCKB0WudiS07fA6gSI87w+4huHS+Bw6Z+TVSLhtPDBjfKocpYMUPtrLH71NRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a7uKBDmelTul5hGRH2P8jTfQs2nG6n3F69DtU8FuRRo=;
 b=MyNNbwBn6W2mWc+x1qRTmGvgVCYfqHnYBjeFVsf9ivVSKXxHMEekwpCtoRsjD9rZDntvg1HJHFIMPF1PqrVCC1AkUpYgDenWZAcTdQTl1AEw8Pw23ZdeNgYLrrr/MVDUvXjq/G8wJVmLxpuUCk+Vh4tGGeoukXg8scZfupPNljjOfwkJjQC0fpfZu/Rvv18TQKmhJAXumyMS3fQdXCwf4u8A+6M9KJc1S2b7wKSfjQTZQcpPRLHBkhfHyFWsLFkCw5Ow39ElTsrMDRCE/VOweCmugTvHgAavgvwN+Jk54oU3Fk4HPjGCnVnv22Cm18ocOcy0IvYyQzIAnyUh11CjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a7uKBDmelTul5hGRH2P8jTfQs2nG6n3F69DtU8FuRRo=;
 b=W1VRpx26miel0Eql+sLGdnpeE3EVosvYhJdx4U/aem9csy1P6KEWOscZBYx2SYJy0fZUL/39UaYvlNpDzO+HDblDtWIMtNA3AqqsTkJsmj3WqsTmXbtudIfRUwpjdK1O01+TqjKqB1gIHbMa9R6KWb89kSEBwug42NcO12+o6xw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) by ZQ0PR01MB1239.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:15:13 +0000
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 ([fe80::197a:1934:4b5b:4520]) by
 ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn ([fe80::197a:1934:4b5b:4520%3])
 with mapi id 15.21.0569.008; Fri, 30 Oct 2026 08:15:13 +0000
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
Date: Fri, 30 Oct 2026 08:14:39 +0000
Message-ID: <20261030081440.251635-2-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030081440.251635-1-jingxuanxie@deeproute.ai>
References: <20261030081440.251635-1-jingxuanxie@deeproute.ai>
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
X-MS-Office365-Filtering-Correlation-Id: 67ffddcd-cf9a-44b9-46f6-08df365dec1e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|23010399003|366016|376014|38350700014|56012099006|261028144727099003|261022105027099003|261026135527099003|261026140227099003|261026130827099003|261026121527099003|261021133027099003|261021123027099003|261022075727099003|10067099003|261021135927099003|261021121427099003|261009223027099003|261022113327099003|261021130227099003|261022115727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	geyW8o0Kabi5/cYLv9uqsak1/ReSpsfsoPVUe9y4h7cfbMUWLbIy47w6lH53Tokc6yalJ/u6rH7jb9VooZfA9OyklPT+DjSv3Aoqk/PGoX8cqF8LMIw41ALfuFyz7ydxqB+R7xvZCI8+yzlC1NuAaBGvzr5K49/QfdZ0HhMD6ToTDMr+6chMeCgJzNxV+V2jJYT70LAEw4HivbYJ1b8OOARZ3WftjTX8YLwz8IwaAEu89Jc5q9LUDKZ+GqETM+BUJAAnk0NBjUBfWUr2gAd6Psmg+G2gs9yTrex9e9941Df14eY24AjJlAhIZDDCqVegU7DwIRI9xkEMs33/IeRQA2DTxjcgUIsYlTzvQAO+LoeXHyFPsbncHiCpjLlM6Ojq5+kc5qJnS/a0krmFQAc7LBif3eCJgvWUQFKYHNFbnoM3fvPbhRuRrhlbXk54gftU1+3Q0LNsknbnCKDAE9BgrqVb6fsCcdbmFypjXpXJ4vmAmtYmAgY0zPTbMQbFUSlzpIBn0fTvG6UBZdIUnu35kmN2cvS2i1b4YOeN2C9sAGfyeR+J0LMO+PEUepGildJl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(23010399003)(366016)(376014)(38350700014)(56012099006)(261028144727099003)(261022105027099003)(261026135527099003)(261026140227099003)(261026130827099003)(261026121527099003)(261021133027099003)(261021123027099003)(261022075727099003)(10067099003)(261021135927099003)(261021121427099003)(261009223027099003)(261022113327099003)(261021130227099003)(261022115727099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sUX1AUbUUnX9X7x/K5jZWXYJ3r6qKUMRGi/vshkj4HQn/klnSJEi2SC3FSCd?=
 =?us-ascii?Q?kwJJaDoIIfegujKmZMZsOdSjcwdYmuueLS1dleI+NxW0flN41jzpLpAF1SAe?=
 =?us-ascii?Q?mLXNOgYWEBtP+u0c9y+rRv/dpvdyS2Uc8M1jpgQPZEUMoAqKEG8jRongni6h?=
 =?us-ascii?Q?k8BO5Hiy0fIv4Plt0/CT3CFH+IfOL9rY+v1+ZZiSlm3aE57VEg8Q64cuduAU?=
 =?us-ascii?Q?iMO4K7G3HV0TFBDUAuhMy1G6RsBipTVdT08s1hy2P6FN5vttTiCzYf79mCDk?=
 =?us-ascii?Q?mlpIv3su2M+clrjtxrS0cFCQZoDApc5bJMMHUR2YSlAuUdMPcX5XwPOZKQQN?=
 =?us-ascii?Q?ujSdrF/zhrcZhgnUOdULj9ISdVR0/p7WfY+JpHz0x2eLiFI+CQ/tIgdEpJQe?=
 =?us-ascii?Q?ydIo+urRtOIh6a3Wr1tA2AwggDAO3SPVM7cl+0zTAe6BEHh9owxnjOQYvF0U?=
 =?us-ascii?Q?U4mUFs7XyX0zJnhuq41h8igkCOcl7AvHmMQ8INn+P4rOrV7KxySIh1LiTxwV?=
 =?us-ascii?Q?X/vQztqHPn15kULvuRu/67iWAkY0I53IMbffbqFwClPJLgaVVZ+nMzaQy8H3?=
 =?us-ascii?Q?8+vKkjx+8hL9zBabX6OgfdKG+xY4qOTU+KOHXP94kuWHV4emfe0eBuc5xZ+b?=
 =?us-ascii?Q?434YGBZedU9ULJNiGg9yGoz8GAhxG9ve5fER90ZPqPMnstxGKujK9plMJWN6?=
 =?us-ascii?Q?4mKaXKW3eiMWH75763q32HCZw+YsbcUSYIecl9AnY1eqwMyYRc/4rTdD0AM0?=
 =?us-ascii?Q?OstKk6QslApIM1zVXzJee4CDU8X/GCtAWiX6JfRQ2zIH2CaqdK45APKFOBRo?=
 =?us-ascii?Q?4g7wh1Z5nIVe9oyzyUd0ogwxcoX01WyKaq8UrPeJaafKWFVFm2pMUvauSWW+?=
 =?us-ascii?Q?7NZrohDPuSgcPQF/V7GF188N6YyRam011herW5mm7SqG2Q8i8hJIfgWKK5Ki?=
 =?us-ascii?Q?KOwmqRhXgYTVn6H/5bE+HjZeM7b2WlbC5Ed9/LcXIc3SFu9kBknrh561Q0M8?=
 =?us-ascii?Q?KqLjFACigp/Gj8KaDxu3kDOdeMtUus26HTUUMsclZTZX2f56rOQ3DSSySpYI?=
 =?us-ascii?Q?Q3rJKuA/NqDrW6merM8KclS7SWDgh/VflKiYuzos2RqDMAAfQoI1QVsIetoj?=
 =?us-ascii?Q?Uaq/T+eu0wCnKtH+nazVdkNifa/qeN9ch9KLLLPXO73TEf/UC4bsig0shtYE?=
 =?us-ascii?Q?b2KY7YjD9yHzZqZutO1ZJZtYRoJ18QDxHqZSU23ulGOn1+VDIB/4jpRA2WMx?=
 =?us-ascii?Q?J4kWu2+vSPa7oUywBBzkW/KK+oJI0lYXjaCOhNgxX+Gdb6/Dh9MRZglPLf7m?=
 =?us-ascii?Q?Mz9dnumlmO3KrlP55OZfRr2FRj90JDUmla4hr7CAuaiyDxoGqwssK/gNmUH8?=
 =?us-ascii?Q?b+Kdr5U5eibpQ+db5s61epURPJ5RKlPhaFr7Db88aVGbuBTmDHwyesdGxSpI?=
 =?us-ascii?Q?Uf6te34s1mTNh0l17w4Y0JLd72K40dxMe7mJi+fYjk5tzNcSxzmqrWH82CSa?=
 =?us-ascii?Q?TfBpWmZ2RPJ4w1jT5R1KBBEWEUrZLSSXYyANZ9VwEUCNl+6V1mq0OAgWIFnq?=
 =?us-ascii?Q?D5QTt7fiXJLGKJ+ad4abfkdmtfxd2J16/VQCZ1mRU5coHuzhevL2qCkFaUu/?=
 =?us-ascii?Q?/15Wa7QyrieaQw7J+NTc5j2wUkBo+cZ9VnCyc0gIQ0Z3MtprrWOX3Wgf0OZt?=
 =?us-ascii?Q?wkhmSsyIG5ItVTqr/xbglo/RBOmsoyZ1T6vQ/N8mH8wRBNvXBICSWhv5zWhc?=
 =?us-ascii?Q?OQZOLKGagw=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ffddcd-cf9a-44b9-46f6-08df365dec1e
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:15:13.2099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxHeuOJ9g8GxVgsipZrvwqyD9WEUFuiV8I12DluyjSJOo4BEKZypD1O34wZjcj5tu7/i9+BoA+hMFQ7u6HGPwHqxKPfjbO8xyC8t/6iOaR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1239

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
