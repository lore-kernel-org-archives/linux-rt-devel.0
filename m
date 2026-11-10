Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.137
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794295374;
	b=NI1Kxlt/1X5I13oha3PqzGswoDTqm/j5VGT6tbxOWuTMkzNKTXFOnrEeKHcSo4jznM3I
	 bE9/XlcW08NvYmg7H7Z9kSy7O6/LCzDYk9d6hmauLe2epwGf9mZ1S5Ne5d4xZw4F2RKd1
	 CMvS4q+uBehjVouYkk1gJ0MsL6SLtEiRC2Vj6N91wva3JWZNraIrMawNmS7Saja88jXAV
	 JmxafDO8z6jkyVZPblCZ4Wok/hDu3TutJu10WlFk3gXrkHrDWCdTo5KxPP4ppMwXybb4B
	 V8/qcm2HKDNTFKtkmPJHdBOdNaKMXGC9r0ZcCQz6MufwIXa2YBh9qoy87iO1VEwq+LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794295374;
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
	bh=F8kUs1zL5rRd/JnGrh/oCHDAFEE0e301VYS/wtheBeQ=;
	b=tvNS3ZPU8dg65eKOcQ7wAWDCPMrfF+zKFGRvbRHzvQkswsn1+nfMmlZaVz22tbAN/oBZ
	 mPlP92tUhHxsWKJqVl6lZNu9zDgpRkX1nCDmZH9RjXSe312h61kJymd0VGbCFPlSYyRpr
	 qua5Xw+eDyLKOn+Q66bXPN9HUlOw6rVSreoyYIQrRB5O18477WPXU3uHEMYYXv3cUqK3G
	 qy5XddTl3DA+Z3zTEYMaXv4l3KQMvisMfYoBzCCE2ixgbtg97pM4i/ka1sHcHPoM9ifJT
	 3tsnKc9CqFj5nURnL37KvmbDQFDzMNygULheBpMUZzxv+cRX4II3SvBZ6Jjts1hKcMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=t2b8TlZf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.137
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2137.outbound.protection.partner.outlook.cn [139.219.17.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972C4606A325
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 07:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 972C4606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=t2b8TlZf
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BidqcOszyV6TFyL7P5Nv4eoOY8OwI3PbPamgZwosQstaOBqIy+i2XEbfZOu3VMMfTK1PJ/8YfJbj+HnjIJpSJv80bs6iuuSaKJ6bgXmIPPHJ9+TkK8nt6ETNkqxW2OLqJQf7z5Nlo5fQuy08xXgQOeR2WVMP5cU1SquHi0rC1OjOf0TM9CcOXukQ8EQKVkHuypaVrV8RIOfRRTXk01DGrLXrE8PPzpbouGL46cHm9nhPuONchXf2YlexS0bdF6KX7zkeMvVCHW5WANNlOWdbzdcKZ3Z+95rljZpte8998N9pileicHDFFRrlYUDCTFHqd8FBEGqVMPr6osbPKM58GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8kUs1zL5rRd/JnGrh/oCHDAFEE0e301VYS/wtheBeQ=;
 b=gLxkp+giT+9Z6W2yDjGmezCe2x+/b25fdQpTyQze1SvaY3ipNJahHx2UmgH4lnbKRFDzQ6Wi4BQLbx9hmF1o3oJ4o4bDTiuQLgB0cA4rn5xHWBm6dJFA6U28vn/Ta+oSABxOkhQ/rVBZB6IsXHYb/Wgg9jc64IsoOMPR2ZT7H0xUTHkr60XixZzBs5Km/OW+kN/r2Jqus0Tbazn0GL2o20dsL7DiHZHOwNhLl6yo8nd/IXneW5J4HDHh+0A6xKGk087fzwlO9/BbUerN3CUP+t9wq3E4tEff+Q83poIK3vbSZtVPqjMRb3YEyTN2p+gzo+XyN3m+e2xvrcgqxmURqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F8kUs1zL5rRd/JnGrh/oCHDAFEE0e301VYS/wtheBeQ=;
 b=t2b8TlZf0OoBg9iPRDvTostS3hVgtKGVzk+lvbbthtRydX1P+S8kUBX8NfOHxEdHpOtNeNW8EJxHj/a3SIPI30fsLiYppN/Ws+oYb/bXCEE82TL0Kzboo7RAoeyOCUnhZ3PhuCfyr9eo5cOH9h6dxVf+OgYDCXrl05DPRQ5UTJU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB0961.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 07:22:38 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%4])
 with mapi id 15.21.0615.005; Tue, 10 Nov 2026 07:22:38 +0000
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
Subject: [PATCH net v4] af_packet: avoid waiting for TPACKET_V3 copies at retirement
Date: Tue, 10 Nov 2026 07:22:21 +0000
Message-ID: <20261110072221.24701-1-jingxuanxie@deeproute.ai>
X-Mailer: git-send-email 2.43.0
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
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0980:EE_|ZQZPR01MB0961:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c9a0c90-b7a8-44a8-a2ea-08df3efb664d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|52116014|18002099003|10067099003|56012099006|261102123227099003|261021133027099003|261028144727099003|261022115727099003|261022105027099003|261022113327099003|261022075727099003|261021135927099003|261026140227099003|261021121427099003|261021130227099003|261026135527099003|261009223027099003|261021123027099003|261026130827099003|261026121527099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	x+u+dLSfo0QV0U/GKgW30xQbKRwFGkkkLyUC4e5h+8qvvRolrRQdIZL4DVMxMTbh7oglYrg79E2G7X4g2j593JAfYN4L6V18xRpVf0S/McTBxiU/7v+3s5ESbit2ohD0wW2RwemixUzOVATUSNbAdBjPcRAHtiYqis2vSa3znz4AlToDZhdYaMoU9ge9eqBQx8N4KvkedELnowsaVdKArCzYDnuo9NL6+XyAmvgOeQWXCMPqjcd9Cqke+7uB6EUh7WNRdHcEPibJ9x1G7ETLb+D3dtFQ+7d9MrtPCuvNhWtG7vMWZw7nYoNkrNTxVhXqlz620uX3r+jzI/h27YN5/PqwG4qEqCcPqsGp76zpiRNZUHrAfAYq1KHHUR6MT1kDdNEiXNdiqDwTwt24QSSCtfe6rQlhRvOuh8jQ1C4Wwovw0nr/sWt0/YUhsAekI3VtBye0WOQBrRKMc7TkcvLFkcckwpBAQXFHLFGLi80a2+93ja4y4jXsZrNHCh5I2RsduM7ZdZMP7jZ7l3lUJ2H6UUtzumqM14CPy4RXRjUGSx9trzF1cbB+GS2ajcwCXZPk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(52116014)(18002099003)(10067099003)(56012099006)(261102123227099003)(261021133027099003)(261028144727099003)(261022115727099003)(261022105027099003)(261022113327099003)(261022075727099003)(261021135927099003)(261026140227099003)(261021121427099003)(261021130227099003)(261026135527099003)(261009223027099003)(261021123027099003)(261026130827099003)(261026121527099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LBRLikdv3L7gyM1KWxgl/Uy7xPLaG4+CGTeYUiSzZHn8dC8pVFBCXqG8Vxkp?=
 =?us-ascii?Q?iaWeR+9nHcWWAauV3losZdkUG9qJFw6wL8A/R5bM27L+Yg412k9od77mAXc0?=
 =?us-ascii?Q?syNoqIOzDZWjdN8BJp2UUC5hQ8sXAA295feD0ylvdiodZ7+9r6RpPpD/4zNe?=
 =?us-ascii?Q?7v4LKbmOuwO9mO9dYmP6igRLZH566CzLT0Olt6f44MPKwST3N4ydZKs3avQO?=
 =?us-ascii?Q?6fhz04BxEdfSwKXq55ZUqT6aFdB9pdEPPN15wcLZEDXt+j5+gvNVRUlHZ8ne?=
 =?us-ascii?Q?wYRbscQ1nYNXGXgnKVr0e7e/WkfAxCJ45Zg1qZAlNaeArisvyzc8jR3jz2mP?=
 =?us-ascii?Q?1YVSy/M/z8UXeYhuE9Rsziaz+TmTJSFAmpw0ReFHF06ANNm0AHcitL80u4b4?=
 =?us-ascii?Q?G0dXTZexmHuQwEOyZPvOmXL0axi6ojFZ0R+F0F5IATXxFLcN9kqVZx34t4Lz?=
 =?us-ascii?Q?G877mvNtwnt7fMJHBX2kcjaf83ZAvPRF7F4rKd/v80icnpNsxN2UYk5FCuPK?=
 =?us-ascii?Q?SrtxZJ/5O6AoZTjhzckMwXL3I9QfED0/DrhxpboaRtkcHsZpVcueM6rsF+1i?=
 =?us-ascii?Q?CGuDm4baNvVHXQUqARLt4z8gPt+CUXQhYYROWyQ5HDAkoE+gW06CGaax94Kr?=
 =?us-ascii?Q?ehfBar5VjtpHX2OVsXt+vA5P190Db3HEO91U/oDUxfrw+HkVLJsOIpUNC2lB?=
 =?us-ascii?Q?lE3alsyToduceaWg+N+xE6nfMmuQsvcTv3TZ3bXYTDYwmWV1pJZvoZfsZvXM?=
 =?us-ascii?Q?PvirZFkDamxpKy39ZS5IGo21xxqvhCmc0+KiC8pnxDT1Byc9mQmbhm8SBd8l?=
 =?us-ascii?Q?G/J0QAAH1J7J8OChwrtu+U7Q0PlALd4vNC6CbKJgL2rK1FlWVteHrX2eM4CK?=
 =?us-ascii?Q?39cwLyXdI8GGJCAunaLiAJmaGAAaNufNsMOWAiNvLNrKyoET2/8OKrC553Th?=
 =?us-ascii?Q?gjfueIHSjxoQFV2Bf1gAKVh5KNAKY4RgF3pm6DpxipHkBPDlXF+JN5LylXZL?=
 =?us-ascii?Q?/R7e5zMsbdJfv0A1cQqU9BdzWVWjncTLruKTbS+ojJ6dIRz/pglX0oKdhj/k?=
 =?us-ascii?Q?K9AMdry4EWmsbcbEhqIqaghZnl09PxmnruAE88McNYcVFRfyQiPeMVU6y84F?=
 =?us-ascii?Q?rvl06i3+c0OvPGLCdwSjZHqUunwiDIbMuO9DAv1VbCMCbUju182q5ascvifG?=
 =?us-ascii?Q?4JllcZKspKtV0C50vUVanLFJyUhlQF2CXg4mYU33ahgwLD/6Imd56pJ5dPTV?=
 =?us-ascii?Q?L6Sxb6vOgpXqAHMm1DGQLTYonsEDFK5JetOrGK4glacik+yGmu6AW/i3U7we?=
 =?us-ascii?Q?H4EGXje6nTbixVGad4ax3s6kK53IOAqb7cJ1ngBv131O5GAqO9FGy14Q3wj4?=
 =?us-ascii?Q?bMK+bJUFwBoS2vvFxNSkw8sqjjDaErN+IyRNfIXMrVAdSMfhBE7VEMBzjM67?=
 =?us-ascii?Q?cIUS02q+hxoawKn2eInpvq7zUuMLSNGe77Q/NtjKX4CnzXg8l/7/m+jn7+qB?=
 =?us-ascii?Q?RgxfW96nkaG52wBub3G2fiJt9L8kKKu1tG1wn2dTWPCFWRdrkdn+D3MtSQ2O?=
 =?us-ascii?Q?oAW72pfpoZa0ANzvToJ+8jaR0tH97GiNXlbbhlftNcTgDeyiypOyDIr4ovK+?=
 =?us-ascii?Q?HL+EAchw7/VBW2IbK/EArr6+j11qYJ5wtzoP+Ggs2QmomXyGmP46I6tS3abw?=
 =?us-ascii?Q?jmmH9UkGbL+nZ8Pkf2bHL39tCwWlUJxSnbsE7smJowByPXiQofRvFhaVD8bg?=
 =?us-ascii?Q?ReunxwFNMA=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c9a0c90-b7a8-44a8-a2ea-08df3efb664d
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 07:22:38.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt+n+8dKer0BR60NWDcVzlE0XOmJ54gP7GMc6ZpLuCJThxf+vgjMziOe4hafR+vt7HmidoOQPw61mnPWKKfYiotCqtLM+YThXyzErqicB04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB0961

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
Changes in v4:
- Limit the write_trylock() switch to PREEMPT_RT; non-PREEMPT_RT
  kernels keep the blocking write lock (Willem).
- Leave the existing indentation of prb_retire_current_block()
  unchanged (Willem).
- Add the discovery and reproduction information requested by
  netdev-bot.

v3: https://lore.kernel.org/r/20261103092541.273847-1-jingxuanxie@deeproute=
.ai

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
index 494d628d10a5..4d56893c4fe5 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -198,7 +198,7 @@ static void packet_increment_head(struct packet_ring_bu=
ffer *buff);
 static int prb_curr_blk_in_use(struct tpacket_block_desc *);
 static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
                        struct packet_sock *);
-static void prb_retire_current_block(struct tpacket_kbdq_core *,
+static bool prb_retire_current_block(struct tpacket_kbdq_core *,
                struct packet_sock *, unsigned int status);
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
@@ -666,6 +666,24 @@ static void init_prb_bdqc(struct packet_sock *po,
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
@@ -700,9 +718,9 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
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
@@ -727,6 +745,7 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
ired(struct hrtimer *t)
                }
        }

+refresh_timer:
        hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
        spin_unlock(&po->sk.sk_receive_queue.lock);
        return HRTIMER_RESTART;
@@ -935,7 +954,7 @@ static void *prb_dispatch_next_block(struct tpacket_kbd=
q_core *pkc,
        return (void *)pkc->nxt_offset;
 }

-static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
+static bool prb_retire_current_block(struct tpacket_kbdq_core *pkc,
                struct packet_sock *po, unsigned int status)
 {
        struct tpacket_block_desc *pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(p=
kc);
@@ -952,13 +971,13 @@ static void prb_retire_current_block(struct tpacket_k=
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
@@ -1086,7 +1105,8 @@ static void *__packet_lookup_frame_in_block(struct pa=
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
