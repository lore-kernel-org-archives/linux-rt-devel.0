Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.98
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793697971;
	b=lRZXIlLv8s6tyDp/t+8hi8s5fd/Ju/l+UQVJLMSSMEpRpI+v2bOCevOJ3OIwjsUKoRJq
	 /r1+K7qxoLtI2OuDFJ1G4FN8RHO9KQjiXfMOgodKfSbw6DPfeRt+GlwDToZMu4jBzhll8
	 EiC95hv1LHxK6s6himd+H5QJOdi4G5znEc1CR/TZJ3OA2UGY32GXPfiHtJlDRK9mZPznK
	 hIiDO+zO034Vwsm+tQy60PJjXrqlkO6Rv7MGQnAxWVyLrniYtuBexBV9dkbqlTkHy28ra
	 27Vg+1HM58nYuENWEO5TC9ZUkvsCHZHm6Qwj+JAw8nVZhE0vocLF49pMmnOkrcAcRIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697971;
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
	bh=LHQkFKDkppfZJZ2sCyE4LX1nxm8Igpg8owgEeeY5l8U=;
	b=Qq+1sv4nxx0t5YdBJyUvgxbnUUa7K8DYJnHZkhQYNXS7gk4+BIEfY2z0QdW2GHYKfcTi
	 TNCHWe5Dr0z5Ty5XSmZkeXiDHpMRlVqIM1YDUixgOkDPWL2sUYhAcCxnt3e12VRhlD1+1
	 lyM5ybksFMbGAUoFsDB15tV7XUZBVIh5hxngMEIIsueUg4lE0NDi1gr5X0xBYZ5Qjp1Ci
	 IzlAT2bX9YTYUlSQGvuxKfNHvDxsdYbvPh62ocadjZ/epCl/EKJfJvm7RFjoz01JpklZW
	 N8NEX+/rx3AuQVy2lbw5I2tdrZAqtPab001enY7RhTIjL+9XAZZHnYTMsg6SNKn8uYg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=Uvxll+z1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.98
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2098.outbound.protection.partner.outlook.cn [139.219.146.98])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24663606A32C
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 09:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24663606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=Uvxll+z1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeNKuX0mZSkrG5/73ZPPlBx9nMSoc4iuEV0TkN803y9KqIeQ0mNY/sDE9cnolHG9w81wzy17d5NVdPwgtIRnUwfub1OjO3alaN48qGlXbXG9CMtd5eSTZDmcVWBB6bcd9GGeYxZ+TzJ+7mV8iucyVC51JwiZ6xAeDQ3haZbn7S4paqJWVFEiHOzYQ0fq7r9FU507W85IRvSvl5lciwLOfwqJw7QW8/EB1754UNTGxvBPlazSORXLK6hNWJF+/KljxWzVe6U9DJR1if512JLxH865ecMueb/tY/wEozrgTBIYQ7XH6WY8FqHQkGMGWmRTlTg2YW3kWxGYkYELet/cIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHQkFKDkppfZJZ2sCyE4LX1nxm8Igpg8owgEeeY5l8U=;
 b=KbP7zpErEpmMzHUUwisCw/w621TbjgnFU1B2o/5MsupyGcnEH/rLQwZDETur+fAV1G/u1Hn47+wOiSg9a8B0JrkYjLh17yvpD1v4WhxCnxmLu9eIU+bZlSWU6XESts2karkV1x0KnFJrggAuZ2lEMF7CD2/dVeLBoJ8ogMwx39elvQt2FEjKOs8nCm8Jg8DMtpVb1eawG4LjRgPlWyfTMvJTcXcnaJXhDU6Ga73ymPisWlElv4LUkl6hiQja9PK1Ct3d3fGKqi1XQj0DYUvTdZFzomErJ+8IzplYQM7EDch/ayOTTAT2mN8SSaD4oQXqOHgVCoY1NGlsERmwI1U7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHQkFKDkppfZJZ2sCyE4LX1nxm8Igpg8owgEeeY5l8U=;
 b=Uvxll+z1t6ybz1aPWQkFKBFf18gAyuX51oBfRrEwYEGkC/0Y/ioQ5v3+VXsY8K7B6DDcnAz+FXUn1rKSwT+X8OLipLCu55Pln1sOxtjzrREXWvYqIB4TToWwzfeDdBIs/KgEvld8Hqr9y/GoU1SNxKt+FKRZjTKYorsmznhYUsM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB1074.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 09:25:58 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%7])
 with mapi id 15.21.0592.007; Tue, 3 Nov 2026 09:25:58 +0000
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
Subject: [RFC PATCH net v3 1/1] af_packet: avoid waiting for TPACKET_V3 copies at retirement
Date: Tue,  3 Nov 2026 09:25:41 +0000
Message-ID: <20261103092541.273847-2-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
References: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SH0PR01CA0004.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::16) To ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9)
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
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0980:EE_|ZQZPR01MB1074:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad1c1fe-15d8-4c17-d99d-08df398c7835
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|10067099003|261102123227099003|22082099003|18002099003|38350700014|56012099006|261022075727099003|261026121527099003|261026140227099003|261022115727099003|261021121427099003|261022105027099003|261028144727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	h65P8vqdwhxAI24kOZjBNrlVerbk7fP9htvt2E5Q+56MiW6H+SUGBiTc2oTHK+m9n3tKLrwHgH2UXGZmXjjN77Xkw9xWfe36agIKjQEbVI1LFWqVzr/7l9clUTIVf/bSc1WhP/d78qEi+OfK8x/X7GUMbQ6jFS/hWCdwdtY5E0IJ9bi/Bn3P6B2gvGWUCORr6KoCIPyga59FkqD1C/qeSkcZ0Je5d2nhUGxmy58Gf6dtBhUxEKeiQXFtwURVJ1ECiw2cuYuMI+xeeRJaVtfSce8dhOK9diFVYZO34l64GxJQq8Sdzj2l7NBw855I3Rx/9BCJYY+M8nWPLV8MH/abuff5vgZXGJbM9fJtF+TpqSuO9vBNhCc0xfgbDcuGyV6ZlxzsnqKWi7dqmIBRjPwrcqgDFjjslucvd+R8DAA86KNIxIAnJvEe7Mj1o5aNWESM76qyDVl+lts1eeNtWenNzU0m6CNLIxvKrMT3AI2rErZSa29zwYz1AZ6kP1VrKtEZjmiVMrEN2H7pisHcxYbTJc+1d1A8v2Z3e3j/mVVT9pahRiwJRukU1gadBfz/+wzM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(10067099003)(261102123227099003)(22082099003)(18002099003)(38350700014)(56012099006)(261022075727099003)(261026121527099003)(261026140227099003)(261022115727099003)(261021121427099003)(261022105027099003)(261028144727099003)(261009223027099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Du+pnm2Bk2tmm6/gjZlto98OWXtWpUZfPXR8U/Qxi1rGPZsfaBg/kQZdZM6d?=
 =?us-ascii?Q?bxpr31bKN23RTjxm4F1qZf40gQYRnOpiTmfqBEVc+r1ZbLZqD86wZICVQp/e?=
 =?us-ascii?Q?HBY/u0ieaJ0Skk4LHSbdD8M5LZrsS83xxwBLPEaV/o2bIAL0W/G9eeNbSVQx?=
 =?us-ascii?Q?e+LMb5C+K9T0VUHmtYY0hnKUIGZZ5Ch5U5nWhprDpEl3orDWSHhctztTGLfh?=
 =?us-ascii?Q?UZezZ77wGueedPFGG0QqgkqNeCao3Z9hLJshDA7HXyWVL9a+Nb1jnXYOrqrw?=
 =?us-ascii?Q?qPmLGB5UXHJQduqBzaAzyGchsAu+UAFRYAIjEyTcbb3djtXR5ixcHrl3+UVY?=
 =?us-ascii?Q?bBrB+Qmj5aBtXNh5PmBbq6Nu0vpyjVt/AfiSXfnkiIkHqgu29BqUIjiuPUsR?=
 =?us-ascii?Q?+6G/nkcCb5dfJuL++C9kyPX7qMeiRjXcnTi6dp8uFAD6kR/2TYG9tzsYxhy6?=
 =?us-ascii?Q?JE8yw9HtUvhODpIdY6pLZCvfI7pRRvMMfydQkmZkv1vgG8ydfK4MDCJfaux5?=
 =?us-ascii?Q?qIdgZFzwrHWGLcIszxbTyCsyc8ViCt6zELB0YX9PeuxUoo0l3wQiwjDRO7lY?=
 =?us-ascii?Q?B1eyKAGVZIRMDBsQpZOOR+te2Lr3vGlQKA76GyrgM3KiBOjN4qw62d+nH364?=
 =?us-ascii?Q?3eGenW1Dnvwg0QxiKyY0/wktgNn212zM1lJP0BhdZB/JCaLXcvvqhTjmo3Qh?=
 =?us-ascii?Q?1kAOoZ4O3Av2FEl5eLp2+6lMQS8x6GXvDsxbD7MuQ26bBa7IRne81o+goITt?=
 =?us-ascii?Q?Bsr4PFdKK4uhF4EFudys5FIq0Otlb/GK2TwMP0jt2+lTKkV1c5PiKk1+iYWQ?=
 =?us-ascii?Q?6HsDB6XQWCEwZtxxAd+ARhIrzjnA1C57PwjXKrff4LHj72llbulbt3uxrgOv?=
 =?us-ascii?Q?Bw9h5om26PS9MH3l4pGABlFCIVtunYiEhust+ETE/4heWa/Y3J/g48cVOmLg?=
 =?us-ascii?Q?0g2lPX5L1louiRc40HVhmdWK1Hg94t3KmjaIO6uMaSebm+QBrDsYnYe3scbq?=
 =?us-ascii?Q?M8srIfLx0w3SSswm7sR+Te9/xFmI4gX6oVlLCDjo04yIVRxfAQAmoETeTqmH?=
 =?us-ascii?Q?7ShT9pP7PEmzHNm3z3AqUVBCzASxnffJnjArR+Zf/lOXtEBpcLoHFQ5bUTsJ?=
 =?us-ascii?Q?EuNinvwNnSSlK/CNZ7mT1FXUG7jDsLeaQ0zOHovc7NSVO99vD7EMdWNb4JIR?=
 =?us-ascii?Q?AvuqbIas12VhnpRtSHrCy61KhGbV3WN92gov4RP19SdNUW84R5c7wRJUW6d3?=
 =?us-ascii?Q?cfjasihHofkIZTYUc407IrXGeGJtJOpEgun3bpXY7Pr/GZyQDJ7NlqCrp8iS?=
 =?us-ascii?Q?e/pcuhIC0LdbnVoSJ4anapSaYM2lJpOZIGxBHAbaE03x2nxsgrjH4gVMvMCQ?=
 =?us-ascii?Q?yrZuqrvqvJ7v/HwQc417Ic0Hv0PNj33YEIQMi5iUCg7DRf9UOQUy4uplZa8i?=
 =?us-ascii?Q?KPyO99Frkkgq/zf0WUPA12dhmZo4s426DaChxzIsWCYEb/TjXA+yLBajCZvU?=
 =?us-ascii?Q?OK98B8rwuI4laUeOaZWToOIDilHZYgAuzWxM2AlHoR2W8ta5RxbOESKLfglh?=
 =?us-ascii?Q?qjK9B9DwgvMSaulQ0v1b2Rwrf74h+U3TWa5EunPj3PRwmASmz3AfhZ2px325?=
 =?us-ascii?Q?jJbBnCKh2emqbnMa0Go9GbTvpPUXDMDTMi57OBGU/d6at2+5dZbCt7B/7FOK?=
 =?us-ascii?Q?gvTg4R5psUlzE2frsH410PsYDJ1EK/VCvd27x83zQCakDXef0znvuQra6ZqI?=
 =?us-ascii?Q?BL3IcaXjgw=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad1c1fe-15d8-4c17-d99d-08df398c7835
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:25:58.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOZWvaP9ZWvPd2jZIBv6S9/4bo899w0HRIO0kbqmOzxBv7eY+YWdThir3f0AdSFFW7qziIUA0RCfbHdVwVdU+vlwJHjoogzHDoNxeI8PZXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1074

From: jingxuanxie <jingxuanxie@deeproute.ai>

TPACKET_V3 retires a full or expired block while holding
sk_receive_queue.lock. prb_retire_current_block() takes
blk_fill_in_prog_lock for write to wait for in-flight copy_bits()
before publishing the block.

On PREEMPT_RT a copier can be preempted while holding the read lock.
The packet path or the retirement timer then blocks on the write lock
while holding sk_receive_queue.lock, and the receive path resumes only
after the copier is scheduled again.

Try to take the write lock without blocking. If a copy is still in
progress, leave the current block and its metadata untouched:

- the retirement timer re-arms itself and retries after the configured
  interval;
- packet allocation returns NULL, so tpacket_rcv() drops this capture
  record and accounts it in tp_drops, while the original packet remains
  in the network stack;
- a later packet can retire the block once the copier has finished.

Do not dispatch the next block while the current block is still open.
The existing lock order and completion ordering are preserved, and no
new state or worker is introduced. The trade-off is a higher capture
drop rate while a copier is preempted; original traffic is unaffected.

Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
Assisted-by: LLM
Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
---
 net/packet/af_packet.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index cf6429f09477..8fd6372ab59b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -200,8 +200,8 @@ static void packet_increment_head(struct packet_ring_bu=
ffer *buff);
 static int prb_curr_blk_in_use(struct tpacket_block_desc *);
 static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
                        struct packet_sock *);
-static void prb_retire_current_block(struct tpacket_kbdq_core *,
-               struct packet_sock *, unsigned int status);
+static bool prb_retire_current_block(struct tpacket_kbdq_core *,
+                                    struct packet_sock *, unsigned int sta=
tus);
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
                struct tpacket_block_desc *);
@@ -711,8 +711,9 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
ired(struct hrtimer *t)
         *
         */
        if (BLOCK_NUM_PKTS(pbd)) {
-               /* Waiting for skb_copy_bits to finish... */
-               write_lock(&pkc->blk_fill_in_prog_lock);
+               /* Retry later if a packet copy is still in progress. */
+               if (!write_trylock(&pkc->blk_fill_in_prog_lock))
+                       goto refresh_timer;
                write_unlock(&pkc->blk_fill_in_prog_lock);
        }

@@ -738,6 +739,7 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
ired(struct hrtimer *t)
                }
        }

+refresh_timer:
        hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
        spin_unlock(&po->sk.sk_receive_queue.lock);
        return HRTIMER_RESTART;
@@ -946,8 +948,8 @@ static void *prb_dispatch_next_block(struct tpacket_kbd=
q_core *pkc,
        return (void *)pkc->nxt_offset;
 }

-static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
-               struct packet_sock *po, unsigned int status)
+static bool prb_retire_current_block(struct tpacket_kbdq_core *pkc,
+                                    struct packet_sock *po, unsigned int s=
tatus)
 {
        struct tpacket_block_desc *pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(p=
kc);

@@ -963,13 +965,14 @@ static void prb_retire_current_block(struct tpacket_k=
bdq_core *pkc,
                 * the timer-handler already handled this case.
                 */
                if (!(status & TP_STATUS_BLK_TMO)) {
-                       /* Waiting for skb_copy_bits to finish... */
-                       write_lock(&pkc->blk_fill_in_prog_lock);
+                       /* Do not wait for copies while holding the queue l=
ock. */
+                       if (!write_trylock(&pkc->blk_fill_in_prog_lock))
+                               return false;
                        write_unlock(&pkc->blk_fill_in_prog_lock);
                }
                prb_close_block(pkc, pbd, po, status);
-               return;
        }
+       return true;
 }

 static int prb_curr_blk_in_use(struct tpacket_block_desc *pbd)
@@ -1097,7 +1100,8 @@ static void *__packet_lookup_frame_in_block(struct pa=
cket_sock *po,
        }

        /* Ok, close the current block */
-       prb_retire_current_block(pkc, po, 0);
+       if (!prb_retire_current_block(pkc, po, 0))
+               return NULL;

        /* Now, try to dispatch the next block */
        curr =3D (char *)prb_dispatch_next_block(pkc, po);

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
