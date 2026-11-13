Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.121
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794537513;
	b=Gg5YzksGRCctHDvxnOBt9/lOf1ifQddxwxvG5AgRjD1bLLwZyY+IJ2G5iyuM0eDUn1li
	 W961XFViVPh5zQVCHai699yjn1+nHciCI5E7BgDMcYXXD9EieBjDT+wfCRw88sthYO4ak
	 gM0zz7kQIjMQVF2nDqO/XAe4ZmKZ4B888iipqjM7b27ugkRiuRKcXtm5e50+NWqIiRTCf
	 PfqjRmjwmtmVXeS0VPRRvUJRmDrz9ci3IU8m8q/V26vzKJsWrEOpKb1PQI8fxEP/QvKCU
	 cztnrSxlnbBZvHcT9HJlIpDf0XnbcW235euMnnSGYdTjp2RCTMT0FUmFkIVCuVLTKTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537513;
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
	bh=0KFpJMDh0jQDxOpcv+yjbmPO5F0B/Xp13e7ZmAptGRI=;
	b=tkAI/NRk/5oO9cDOylCI765NEialoKjazXpxoJh29YKPTOH+q0qoQIyqU0gNC9FH1FC9
	 Mdcin49MxvalZKiNTkQRe6p4Wa5Bzw4FZnsYZTHrhWMYtDuTSrfXMD2XBE/XfUNVH8cON
	 uASuxv1Kq/TSiv0BRUFjQJs5qMd6BapqCDNnR2Wh97sDwOWsAR2NTFxbl/OcNDPkz/9hG
	 on2CBCltGBjkx0cSRyEN3EiLk0X5pFLmSclRvV80Y6YXp//+m5NUKz1VjhFfNIyJGTHpF
	 bSwgRfYwiDcM8KuvbcwiGBK2hMNv6QbG0pqC+fwIIV4KjggQGueXGXG1Fxc1GJCsF5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=gTO+lhFj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.121
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2121.outbound.protection.partner.outlook.cn [139.219.146.121])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6E2606A323
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 02:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C6E2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=gTO+lhFj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2plVkqCiYR7FLNN/Lzs0yDvhCoUTGhsS/VbWeKgnVvNfZ3XFFEpVOHZ4l2tO6xuZhdIcqm4JOjdxCIOoUNzA2DPzadlvQLYNCartrJKze0cONONj9tC+6XTVP1KviYWTzfv82uc+KAo2LQMByQrMTCAJaEG8L8j0XraRlBjZc54Xq0s4/33LO7hKDgY87rw+hs7rD6hfk30KOepwFPgilL3MOu3FCGfk5bS85zSMHuiaWj8fsQo8XMVYhye6B3Hytgm/Zpwb4LUpdZDQ8oCaV5yuLqUXlvAaFkGOu3jptdEQIbEMsG98SsGUjzaKw0Giu0j5usBHAvKO6yWgOxe7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0KFpJMDh0jQDxOpcv+yjbmPO5F0B/Xp13e7ZmAptGRI=;
 b=L3uGs2bCYshjg0xwP03v7QghTyfdDIV+BalhilaU8EkzCFlucIJeY5HQ8xNyxMBqOm+C4cKwqm+a1bGpwpgM827/3Zzsidos/haahk5ZXv9KmInK7cWzzaRuWJ+GGZtB7+yMBoT+pPqU5ol3s3ykgMRZ7YWtfjdJf3GUilh2dyBT82Glw1oUWAlQxq46wWt7Cu+DN7CDomkQyRQMN/3yWBgUk/qlWJhHF5P55hGXgxJbykxeAiDny866aHARxnBqbGZb1XFlzq8C71SI47xmDPliO2FTEJnagz/T4NEbaPwLG+BfavdmOf33sO4hctc69PGTi6DCZxm2reh6HprDbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0KFpJMDh0jQDxOpcv+yjbmPO5F0B/Xp13e7ZmAptGRI=;
 b=gTO+lhFjONki2Uw50Z86bDBf1O6Vsq101CGPZ6yJD1iBydLzWZ2dEcBiKnc37AwsbSTSNzq9o6h3BEd/kFfsriMIASliSkEvIDnFi8cBxjQquVksR/9moIWNr7H3qXqFKwYULwWHEb5WWRrAgNRsU38q9Jxk4wer8oOPyaOUXco=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB1041.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Fri, 13 Nov
 2026 02:38:21 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%5])
 with mapi id 15.21.0615.008; Fri, 13 Nov 2026 02:38:21 +0000
From: Jingxuan Xie <jingxuanxie@deeproute.ai>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	=?UTF-8?q?=E9=9F=A9=E5=B0=91=E9=98=B3?= <shaoyanghan@deeproute.ai>,
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
Subject: [PATCH net v5] af_packet: avoid waiting for TPACKET_V3 copies at retirement
Date: Fri, 13 Nov 2026 02:38:09 +0000
Message-ID: <20261113023809.24730-1-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: SH0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::32) To ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
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
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0980:EE_|ZQZPR01MB1041:EE_
X-MS-Office365-Filtering-Correlation-Id: b405b92c-96c1-4e9e-9d9f-08df412f2e92
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|52116014|261028144727099003|261022115727099003|261026135527099003|261026121527099003|261102123227099003|261026140227099003|261021135927099003|261026130827099003|261022075727099003|261021121427099003|56012099006|38350700014|261022113327099003|261021133027099003|261021123027099003|261022105027099003|261021130227099003|10067099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4rxcF/C5S5yLkv6H9al63NgGdP3Y5MtWXAAZ/KbqsN7teNhTs/sqz0BoZKjKl6rObQ/izXZG7S/RmsNQCps4y/gvrJb1egxXgwn98L4Oa8H6N8ly0HYe+knrqoDwOVcvvtoYevrq+L37ABr1dP6nMFjgjc2kIvV1V/ZjPxjsE07T50RCaeB6Gf+IiXmisixUyA9TtuOiW3dsq2mpwuRC3OCjya/VpreTUfWNhMbMiX0t4sGTVT3Qu4T7qHXY1eM3o5U85WH4KHqPCQUabhxOXD8/ahomfl4wP1AJuRj+HFDNjuECr9Xpf2+7veO4CXw3BC6EMrsXZgqNoE0vA5920ZXaU7L8vznY9F0TBIhp3RrBsN7XxQepg6KkiDPkiZT/gJj0i+Tiy2TWBxX1dudIn5jNNEG0g+RSmrOAt+5P799BCmMPABd5jzxo5xz+P6SYcQOULvqi67+jG/jiL85aiL9LwMNUHk/8od1Ck6W+LMk2yt6KqAReGpVcaTbo9KmX/vuG/q+l/nI2u/RyJ055mesRPhJ+WCNfrwMOr/YfyXbXSWqJYuJ8I6gkpTMRlVSr
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(52116014)(261028144727099003)(261022115727099003)(261026135527099003)(261026121527099003)(261102123227099003)(261026140227099003)(261021135927099003)(261026130827099003)(261022075727099003)(261021121427099003)(56012099006)(38350700014)(261022113327099003)(261021133027099003)(261021123027099003)(261022105027099003)(261021130227099003)(10067099003)(261009223027099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SLmu5SGASLkeH7a9bi2CQYUD1p6G9gZTyJwE3wSODOzQdlH/Y7MxnQqJ8pMY?=
 =?us-ascii?Q?Ydc0xg1/luutEkCILCahjuu+47nftpq/RMCDoXPHJ5m1kjosakZhYFhZm2IJ?=
 =?us-ascii?Q?4xGHVWi5lu7krgEBxfahfvF66QQcHeolwqZTKncjBSxarnsfuczSL9vcra+M?=
 =?us-ascii?Q?sfdfgEmJXN56jhIyJCIUdgbW3Z/BpoJ5oAqbdBcWbtrJA8r4eLH7RvkQdUva?=
 =?us-ascii?Q?Zzyvd660g/wlPyZoJq4qGZKvMaEHm8bS+ztxbOd73QhmKRtd9+WLlo4rZheO?=
 =?us-ascii?Q?pc+GIo7wDMCj9+VfWmM+3r3rpYn13/fwEbba5zB3aOfHunapA1okRTvFcTqt?=
 =?us-ascii?Q?gT5jci+CpVUaLgud0kjSn8RL7J313zPnqV6RoJBhQ7Vs4jOTxrRb+lWUAVSn?=
 =?us-ascii?Q?qjPpbiI2ZMYNHidC21T24rwS7tCIYNOON1tKveoo129T4fBQyJCj8VDTrASL?=
 =?us-ascii?Q?q1jUHboOe0s48/LpnHvTA5fMgJoK2v9Ntm5VzTslXC6vZRsp+rEnCA1iapum?=
 =?us-ascii?Q?D9olwwjZ9rTOYq0nREIqsFKV5pZXDHInnW7M5SvdsDlyAmT4nOHZhiFoboko?=
 =?us-ascii?Q?gVJmvg9lrc64QJP42GbFu8q3OIgHQThO6Eg7JiQc8fM95NIoUsI/WfRThtlL?=
 =?us-ascii?Q?igy++L1ZFqBc0XN0nmhU5knmYmAlakqDmkaG6NUmK5DcucpwfvUrcb884gC6?=
 =?us-ascii?Q?hY3IfmDm+SfHPLUkvaMr33BLMOmk+EO66uDX13s52ggaynGqfjVbin/9kNIU?=
 =?us-ascii?Q?h72rb6r6u8B4z3CtPZ/NdhFWVWlKO2nz6sPPHhwxxSmDHP4HAK94mW9gg+2r?=
 =?us-ascii?Q?KNi7v3bafrPYmd5US0dRBXDpzALXn0LJ0QQrZg1XbNrEknJ7s41B0vHWWLxw?=
 =?us-ascii?Q?j7LgG1heSN1eTA+s0hjLOq22uCKPKJTBRsd1KaV0C1rpz74dKDCWO6ZzzmKV?=
 =?us-ascii?Q?3S32PTdLwBVX4PPEjG3WqUtc2+NFhglhjfrmoQohSE1z8YmxZLf5xKEHvcnT?=
 =?us-ascii?Q?Qj3k2sVx0bQcXtZYBZhm5dmzrt+qtpdgIq8KuSoGEqwLtCtgNHQm4KJauKRT?=
 =?us-ascii?Q?WxzZ+WZRAVftN0YYrj54pKT28I8KoShu4+58+Ts9FkCWzCwnHA9Cp+7EPFnw?=
 =?us-ascii?Q?n8ce0vA7MZx7tXMRG+liU10kxirTeepLGQEo3u7BAAC7nTja/HthftynPZPz?=
 =?us-ascii?Q?CpBTrf/IueFI0+gW8HxJ6v2vdeo5XFKNQcgvPMZBUwKYj4i36iOZB3SU4KFS?=
 =?us-ascii?Q?pqx3L1B1iqZID1XO8c+hgrZmeVh7/nZZDYwXujoKXA35oAd1fkgyw3SOphAm?=
 =?us-ascii?Q?Ec4U2sg0TgdjJiYsZ0bMKKz0VakaQckDgf7kacIKD+ozI3lYd8slEXqU6Wdo?=
 =?us-ascii?Q?D5VRIHm4xsGrZArqIwjEuWOb45ytwNNukv1NeXDvQCHY21yC2H+stPPZrzXt?=
 =?us-ascii?Q?nzyMw4ggsiNN1Yit6uYf9CzGGXQ23xtNhekarkpvFkkfA5H7yMQzumxWsJYs?=
 =?us-ascii?Q?uLWhLgt6TJcTl4nR0ae41DwJBYFLV1v/jpYmjWnR/kH6Y/3XIEdZYNP5JT3w?=
 =?us-ascii?Q?UVYJKRDHwLlesEP5ebHtH4BKNbeLSEaCOWm7OW/CvvYV0xamEySmFUmVPV+q?=
 =?us-ascii?Q?/lctOpB9iLQfijJx+1TnCM0izp/80xaq3ba5wHxIhQ1gPcwy19qw6PgoAD+M?=
 =?us-ascii?Q?FnCPLLobCUqoNuaIoRvoOC7Om6gZGE7rp8XljNYerOAmjYf5MChWUU/vbSpA?=
 =?us-ascii?Q?isyq4l2xbA=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: b405b92c-96c1-4e9e-9d9f-08df412f2e92
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 02:38:21.1990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuQYDQUTsuR1o6waSNcomB69M1s93uUs7kcyQ/bRBzODXRlB8KM3e8XpsfxS7pVHuXjTKqDLfAPwO5cMah9GfjQddBYUrr5HxZFaQ1+gKck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1041

TPACKET_V3 retires a full or expired block while holding
sk_receive_queue.lock. prb_retire_current_block() takes
blk_fill_in_prog_lock for write to wait for in-flight skb_copy_bits()
before publishing the block.

On PREEMPT_RT a read lock can be held by a task that has been
preempted or is running on another CPU. The packet path or the
retirement timer then blocks on the write lock while holding
sk_receive_queue.lock, and the receive path resumes only after the
copy completes. This was observed as a receive stall of hundreds of
milliseconds in a PREEMPT_RT deployment; manual inspection found the
same unconditional write_lock() in both the full-block and the timer
retirement paths.

Try to take the write lock without blocking on PREEMPT_RT. If a copy
is still in progress, leave the current block and its metadata
untouched:

- the retirement timer re-arms itself and retries after the configured
  interval;

- packet allocation returns NULL, so tpacket_rcv() drops this capture
  record and accounts it in tp_drops, while the original packet remains
  in the network stack;

- a later packet can retire the block once the copier has finished.

Do not dispatch the next block while the current block is still open.
The existing lock order and completion ordering are preserved, and no
new state or worker is introduced. The trade-off is a higher capture
drop rate while a copy is in progress; original traffic is unaffected.

Non-PREEMPT_RT kernels keep the unconditional write_lock(): there
read_lock() disables preemption, so the writer only waits for the copy
to finish, not for a scheduled-out task to run again.

The stall was reproduced on QEMU arm64 SMP PREEMPT_RT by delaying a
copier after frame reservation: without this change the next sender
blocks until the copier is released, with this change only that
capture record is dropped.

Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
---
Changes in v5:
- Rebase onto net/main; no functional change, so the v4 Reviewed-by
  still applies.

Changes in v4:
- Limit the write_trylock() switch to PREEMPT_RT; non-PREEMPT_RT
  kernels keep the blocking write lock (Willem).
- Leave the existing indentation of prb_retire_current_block()
  unchanged (Willem).
- Add the discovery and reproduction information requested by
  netdev-bot.

v3: https://lore.kernel.org/r/20261103092541.273847-1-jingxuanxie@deeproute=
.ai
v4: https://lore.kernel.org/r/20261110072221.24701-1-jingxuanxie@deeproute.=
ai

Testing:
- arm64 W=3D1 af_packet.o built with PREEMPT_RT=3Dy and PREEMPT_RT=3Dn.
- QEMU arm64 SMP PREEMPT_RT, 3 boots: psock_tpacket and psock_fanout
  exit 0 (the fanout queue-length warning also appears on the
  baseline); with a copier delayed in skb_copy_bits() while holding
  blk_fill_in_prog_lock, a second sender returns in 0.7-1.8 ms and only
  its capture record is dropped; the retirement timer retries and
  publishes the block after the copier is released; close/unmap during
  the delay does not hang; no lockdep or atomic-sleep splats.
- QEMU arm64 SMP PREEMPT (no RT) with the same delay: the second
  sender blocks until the copier is released (503 ms) and no capture
  record is dropped, matching the unpatched kernel.
 net/packet/af_packet.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7322256..e0ebd06 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -200,7 +200,7 @@ static void packet_increment_head(struct packet_ring_bu=
ffer *buff);
 static int prb_curr_blk_in_use(struct tpacket_block_desc *);
 static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
                        struct packet_sock *);
-static void prb_retire_current_block(struct tpacket_kbdq_core *,
+static bool prb_retire_current_block(struct tpacket_kbdq_core *,
                struct packet_sock *, unsigned int status);
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
@@ -677,6 +677,24 @@ static void init_prb_bdqc(struct packet_sock *po,
        prb_open_block(p1, pbd);
 }

+/*
+ * Wait for an in-flight skb_copy_bits() before retiring the current block=
.
+ * On PREEMPT_RT the read lock can be held by a task that has been preempt=
ed
+ * or is running on another CPU, so do not block while holding
+ * sk_receive_queue.lock; return false and let the caller retry.
+ */
+static bool prb_wait_for_copy_bits(struct tpacket_kbdq_core *pkc)
+{
+       if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+               if (!write_trylock(&pkc->blk_fill_in_prog_lock))
+                       return false;
+       } else {
+               write_lock(&pkc->blk_fill_in_prog_lock);
+       }
+       write_unlock(&pkc->blk_fill_in_prog_lock);
+       return true;
+}
+
 /*
  * With a 1MB block-size, on a 1Gbps line, it will take
  * i) ~8 ms to fill a block + ii) memcpy etc.
@@ -711,9 +729,9 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
ired(struct hrtimer *t)
         *
         */
        if (BLOCK_NUM_PKTS(pbd)) {
-               /* Waiting for skb_copy_bits to finish... */
-               write_lock(&pkc->blk_fill_in_prog_lock);
-               write_unlock(&pkc->blk_fill_in_prog_lock);
+               /* Retry later if a packet copy is still in progress. */
+               if (!prb_wait_for_copy_bits(pkc))
+                       goto refresh_timer;
        }

        if (!frozen) {
@@ -738,6 +756,7 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
ired(struct hrtimer *t)
                }
        }

+refresh_timer:
        hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
        spin_unlock(&po->sk.sk_receive_queue.lock);
        return HRTIMER_RESTART;
@@ -946,7 +965,7 @@ static void *prb_dispatch_next_block(struct tpacket_kbd=
q_core *pkc,
        return (void *)pkc->nxt_offset;
 }

-static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
+static bool prb_retire_current_block(struct tpacket_kbdq_core *pkc,
                struct packet_sock *po, unsigned int status)
 {
        struct tpacket_block_desc *pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(p=
kc);
@@ -963,13 +982,13 @@ static void prb_retire_current_block(struct tpacket_k=
bdq_core *pkc,
                 * the timer-handler already handled this case.
                 */
                if (!(status & TP_STATUS_BLK_TMO)) {
-                       /* Waiting for skb_copy_bits to finish... */
-                       write_lock(&pkc->blk_fill_in_prog_lock);
-                       write_unlock(&pkc->blk_fill_in_prog_lock);
+                       /* Do not wait for copies while holding the queue l=
ock. */
+                       if (!prb_wait_for_copy_bits(pkc))
+                               return false;
                }
                prb_close_block(pkc, pbd, po, status);
-               return;
        }
+       return true;
 }

 static int prb_curr_blk_in_use(struct tpacket_block_desc *pbd)
@@ -1097,7 +1116,8 @@ static void *__packet_lookup_frame_in_block(struct pa=
cket_sock *po,
        }

        /* Ok, close the current block */
-       prb_retire_current_block(pkc, po, 0);
+       if (!prb_retire_current_block(pkc, po, 0))
+               return NULL;

        /* Now, try to dispatch the next block */
        curr =3D (char *)prb_dispatch_next_block(pkc, po);
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
