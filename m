Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.111
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793348250;
	b=aQIzRjIqyi1virf9fyvI+9ZN8dyk/QWU1lcfK6JSFBkQQpfXC92Ph7TKmEA2Dxg1OEqQ
	 lJcUTF9hT7YAdkl0UcT34lGQ6gKRXlKOm5/gdK0LldRj3qqv1aRdR0ysnPLIfv65a2rq7
	 OFH7IjyXjcw6dm6+os7yWpuqQrF6IJLyqS4cs5mUFqL4TIrW/KSO6DjtGWqEKM4dtbZzP
	 N4kVb1zUzpdPI67c+KKEVdepsb3Wi6Jaf6TCTtlfRs4SAmbgfqax1Ub5V70u1c4S4HQRv
	 xI9mKU062naYgBqDTryNZvFdMW61KQiu6pA1Ch2jZCq2/k5FgdNu0siQAQwaQoMYggg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793348250;
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
	bh=JrRAjSRPFk1ac20MYsOWg8gOGCe9vIQquLa1QaKxQ08=;
	b=gbQ65qngw4i76MnZvYmWXY6PnXbRp7zvfvR/QXQ3O8VqFjC5/UC4rtg0UrNt5kaYXwss
	 LpIW7S1QItnB1eY1qmP4pKvKzy4dnNaRzZuaoyRijFtH/THXWIuUyFK92O4s61tG9JoQ9
	 9vjo0Vo2WEv/k0dqIiiK8sPxs3KSQ+ysrJcB5HEKotqHCyHDa5sLQn3fHzCJfdO4525oX
	 Bmov+y6Sb+/fVosLsdYNpAoE802VhYGzAtn2sqX7zFlrSoof1fqi/e3J/rUcJ/NjlAgNU
	 smRGLTVYPH8LAFHMlezI9DxkeP51B51e5vLnTYf8PeC48N5dXXWXcs8nP8qCbjKB4Uw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=kfZN+QOl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.17.111
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2111.outbound.protection.partner.outlook.cn [139.219.17.111])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69007606A331
	for <linux-rt-devel@lists.linux.dev>; Fri, 30 Oct 2026 08:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69007606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=kfZN+QOl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBcv/cOrsyJjhfpdah5DrrCL3YnpaROuGXQm2YzSZR6cwXkVK567tB7mRsavJpXNnqYLHbDqT+Q0b73jm0cLdHroILg4Ln+4miCXvoIJHuZcqxt9s7wKwiSk/ovvd+3pYEmc935+QmDLGbWXmEwtWlAvvF2/EB5Y/u7vTeH1X/v+6A9NLeyBSCPZAeuEW3Skxw2Yj0Tz5HjVPnMeYhZdjOopRGd9IEbp614WOfOaIbBMsDdcqPZcpA8bgzX14nynOHQ2PBP4cqVq3Xi7diHF/CeaJRAJX8OrmsKlGxpaNvzYTsHg9pl9eHWb5+hh90FVwCURAWGaQjQhvPO9mvM/RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrRAjSRPFk1ac20MYsOWg8gOGCe9vIQquLa1QaKxQ08=;
 b=KeOlC4iX1giAjgimMiuFP27tN4r6EbBMkxzFdIzuOOkBfDgMmWBIgeYOPHXiJWOnY/Ju5eDPtVd5SvdRI4LhDwsWXGwpViCOkSwzp5/UlzRIb6zoTiGQKLn7swv7G1H1WYOYfIKp+XDY2xSgZvHEf5sREUxr/IfD1AD2IQ00vFMoiOuHOUpHUaOvp5QZt9hpwjmqezktJoOk+kOAAJAbO1dph3NyNlRWfuPekYlbq4ukz9smTdeTmpuOcQJOYSgNeeSKbpkjnHqgmihg1WHa0CRE5jamRpHgh409f3NRcFX9qTbwqVTogs9DiZ/oQyfFYHuXXbhMrBAiHYs/uWHbfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrRAjSRPFk1ac20MYsOWg8gOGCe9vIQquLa1QaKxQ08=;
 b=kfZN+QOl5fedwWfI2Hyi4obDTEM2ogyXoaQg/fnrHa+f2fRkhC4aZs74ihSMl4alE9SmIfhIBCriSzh1WfDSGFdxvWszekbcJ8mHyEtqwoykF9yH3AZTrTKMfBa2wWF9lO4lqUAzi0/sMLoESQGwdBlJjZENcNO5TLeU8LOjYbU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1::5) by ZQ0PR01MB1157.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 08:17:18 +0000
Received: from ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
 ([fe80::197a:1934:4b5b:4520]) by
 ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn ([fe80::197a:1934:4b5b:4520%3])
 with mapi id 15.21.0569.008; Fri, 30 Oct 2026 08:17:18 +0000
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
Subject: [RFC net v2 2/2] af_packet: retire TPACKET_V3 blocks without waiting for copiers
Date: Fri, 30 Oct 2026 08:17:04 +0000
Message-ID: <20261030081704.251652-3-jingxuanxie@deeproute.ai>
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
X-MS-Office365-Filtering-Correlation-Id: a2fd6171-b403-431f-ec63-08df365e36ed
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|52116014|376014|366016|1800799024|38350700014|5023799004|56012099006|261009223027099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|261022115727099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	RE5NgwCuAYlbKurb+jyxVem21Cu43Q4Y5tXn/MA4MP7yTRWeqE3y7Wg+NmugtfeyAPJT02WIReUKsF5val9CrNixn7GYZgpQsrrhI6caLhgBCThWGyNiQWLS9qUOfnHq8HVHsi9WSnyG7TlQ9pi+wYw1zob+HPwUTRqgmy00TFr1QQDGO67YyYWysv1/KUV5MEyqmwg15TXjKJ1hU2rJuSMl2RqxjIJPPygY8qlXf32D292lPMy6ftNPyFpFfVyPvo4WdJBF+Czpt+x6ZEB0u9VjQGFPa8YGcCHvrpNPrlm7iLXAJ5fc1GGYX33wdvnQrO9VxmuavJDLzlkfNjeDkwzVeiJggwdLloxrOmKOQRIodsOx2fKoLjyU9OhOQISpPNwYktNskfB9Jy1UDgcmgB9Y1lfB7KXG2YQB2OXtHqsYdtHRJjVwcuBTE/2fEMgy1v0e1rkJrfwGvl676Z8YlJp/ofAkAyZr7BWggqBcRigy/3uWxN4zdkNw4NlnBTg7G7c5dfQLazuUZ9Hv4vs3vBZ8WP5xEISqkGbKSKnvFf218J7ow3O4AhcCVaDw/lHs
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(52116014)(376014)(366016)(1800799024)(38350700014)(5023799004)(56012099006)(261009223027099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(261022115727099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+NElK/3b3db3O8LsVGFuv6BUC/bbgfO6paUwHVWfe/Fhg9pfCEVnLWvLRBmv?=
 =?us-ascii?Q?ftmvPN5/Fss5EayT/SnfNwM+RMuqlU/gSyEsuXvK/P+UrxOIYrvgttcfEyk5?=
 =?us-ascii?Q?ZjdHZf+oGVl4P3GE/SOiah8I0ckVwk0L4mL7gLzmLSCrMG/z+FEcjBkqjhp6?=
 =?us-ascii?Q?TovIpJ9eJLrcIkc6uWZbaUp/BgGF8H1c2NagOrwm9joDasEvHieNQjE9opda?=
 =?us-ascii?Q?116tWZKdywBZc/BRfJhOuqWg3OCrRcfIjONnwuyxsSj5sVMiOLqBaifVk6dy?=
 =?us-ascii?Q?H/sWK/Upy2OdlS67FJyUjonERHdf+5dkwBUiKJgFhZhi9nT2PRloaa2iwYbE?=
 =?us-ascii?Q?MRCX1b1NNAzlWjYMWSInoUFeDxHKHTch2NTckIUiqp6mhpnRJUCi4hAeOaAN?=
 =?us-ascii?Q?7o+l5lLN92n9uszPGOJ35XFLTJxBR5yAAqoJ9+tK0oI46cT1FQG6J23leEuV?=
 =?us-ascii?Q?6AGkHfO/S3prXV7llr44/GCbfX5m9EA8ZRdhn9uQz2W88B2sQ6+HS7LwGPBo?=
 =?us-ascii?Q?iTisULYvUAwgVelsoc+Psg7+KtVZv9svdTt09vmG2ANbvg+2hFnSfOcehin2?=
 =?us-ascii?Q?gTZwRkO50ljphZsFalyrtWpaj7G2/cUqi0NIQs5LHIZzwqF2QqA2Gw3c6T2x?=
 =?us-ascii?Q?c+xw74t+xgcjXBvr913ySHZh3yYZna9bvSCPG+sy9JKH5U5COvnKlpJFlWpz?=
 =?us-ascii?Q?WwqwtjVt8w1Ilt9oaAoAKOR+mDB+28wPImVDhdcr19l/tPz/+IyHiMDZTlz1?=
 =?us-ascii?Q?Lg94ggSrvqTxFwS7S2uL8zMYGjlzDbGgTmym8UKOEsFwoJFWdTRcMUiuiTDy?=
 =?us-ascii?Q?fkFVYiMuw2ERmUHMcDmWJ0jRuJI/xPtvZs09ariEAPhE2PrYN8//E0MOr5qC?=
 =?us-ascii?Q?UPaOIn5DCkl9zJebOTkmzO37uDazfJmzwnK7aIAckXyps1Q98AegqJbTC8Cs?=
 =?us-ascii?Q?HQFqZrzTQa8XrX8bsBLEvE/jVZeCl6tkr+yi/IS1p4EetQ0/1+e2KRPxSwmY?=
 =?us-ascii?Q?M64juKCDGZ8wxMtprtXlJ7f/SE1QDan7vRDHn464fquQA/dxXcGElpLkuYp4?=
 =?us-ascii?Q?pd5rX7VfoBelLJqvCJd9hb38gT4ElXepOrpdA7wXKq+Kkxa/FWD7xeW+O7P5?=
 =?us-ascii?Q?kVUqgn72KigOz4Dm3HPWgEzJi+RvDFIKWiXXhrNdGft7jlljVyT47rfIBkkR?=
 =?us-ascii?Q?E472TN7ZbVvK4SJMUWHF76t4nqktpAB0UyCMyJHkl4DME/IDvwBTE5aEWhfa?=
 =?us-ascii?Q?2PE/inD/bCwmWqijkebaRTBfXoVRouitN6CYdMiVofyAy6s8Y+2v+blMwmBP?=
 =?us-ascii?Q?5J/3va8U6TiYaEMjP6K1XuzisCsqWsdHD4wSMUaHu1cxzWiTAfvR360jzmtt?=
 =?us-ascii?Q?v8p53y12LyIjyJl+/BVY4HXC0GkexEuBn1srbWo2npC+th4TVfMkTKViBFiG?=
 =?us-ascii?Q?XQAXE4SnF9uoeZJ6XIbovW50MuI8lClpuXLMgno4JJgV0dzh93BHxUK9bSii?=
 =?us-ascii?Q?P36GMxIwdB6v+lSavSIh+9pa88qVYw/gAJq2mPThvXieIKOZNmpZio6rW7tU?=
 =?us-ascii?Q?/eZHdvVV5/bhnXTtYeeBZuYD65SIZKJ6FAfZkt+IbrUWksF97EmeXn6Tr99i?=
 =?us-ascii?Q?Sybfnc+m++Ipcy2DtV5/oL/rmudVBe+JV1uN56ItmiWRBsv6Ex6oxKbM552X?=
 =?us-ascii?Q?K+zjnw0CWb7089jheoQn+MLa3X0JYIrV+CvC4KZmArTzRQQyAS5nq85hX/Gu?=
 =?us-ascii?Q?4hvXOM9Ybw=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: a2fd6171-b403-431f-ec63-08df365e36ed
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0982.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 08:17:18.7113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y11tNmQGGw5B+sNvgNTDZmzXKHKAWwEud/3SDPd7Gc8Ry16ypIQnLGW5LE5H/qd18zBmANpu16ytXCnbOfn7/wLuorMAQt4IF0eh4wDt46M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1157

From: jingxuanxie <jingxuanxie@deeproute.ai>

TPACKET_V3 waits for a ring-wide read lock while holding the receive
queue lock before retiring a block. On PREEMPT_RT a preempted copier
can delay another packet path or the retirement timer until it runs
again. This was investigated after an approximately 355 ms retirement
wait in a PREEMPT_RT deployment.

Keep copy accounting in each block's existing private pgv descriptor.
Seal a full or expired block and advance to the next block without
waiting. Retain the original descriptor across copying and release its
copy reference after all packet data and headers have been written.
Publish sealed blocks in order when an acquire read observes no copies.

Publication runs under the existing receive queue lock in packet
allocation and timer paths. Completion does not reacquire that lock.
No worker or publication budget is needed. When traffic stops, completed
blocks may remain unpublished until the next timer callback; this does
not promise a hard capture delivery deadline. Ring exhaustion can still
drop capture copies.

Use each retired block's saved last packet and its own cache-flush range,
and exclude sealed blocks from allocation and fanout space checks. Poll
uses the publication cursor instead of the producer cursor. Widen the
producer index to cover the same block count as the publication index.
Allow an exactly fitting record so a maximum-size first record cannot
cause an empty block to be reopened instead of advancing publication.

Reproduction uses a QEMU ARM64 SMP PREEMPT_RT kernel with validation-only
instrumentation delaying an outgoing copier after frame reservation.
The instrumentation is excluded from these patches.

Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
Assisted-by: LLM
Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
---
 net/packet/af_packet.c | 140 ++++++++++++++++++++---------------------
 net/packet/internal.h  |   9 ++-
 2 files changed, 76 insertions(+), 73 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 7b3e1e27f777..5bc486326be9 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -197,7 +197,7 @@ static void *packet_previous_frame(struct packet_sock *=
po,
                struct packet_ring_buffer *rb,
                int status);
 static void packet_increment_head(struct packet_ring_buffer *buff);
-static int prb_curr_blk_in_use(struct tpacket_block_desc *);
+static int prb_curr_blk_in_use(struct tpacket_kbdq_core *);
 static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
                        struct packet_sock *);
 static void prb_retire_current_block(struct tpacket_kbdq_core *,
@@ -205,6 +205,7 @@ static void prb_retire_current_block(struct tpacket_kbd=
q_core *,
 static int prb_queue_frozen(struct tpacket_kbdq_core *);
 static void prb_open_block(struct tpacket_kbdq_core *,
                struct tpacket_block_desc *);
+static void prb_publish_blocks(struct tpacket_kbdq_core *, struct packet_s=
ock *);
 static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer=
 *);
 static void prb_fill_rxhash(struct tpacket_kbdq_core *, struct tpacket3_hd=
r *);
 static void prb_clear_rxhash(struct tpacket_kbdq_core *,
@@ -666,7 +667,6 @@ static void init_prb_bdqc(struct packet_sock *po,
                p1->interval_ktime =3D ms_to_ktime(prb_calc_retire_blk_tmo(=
po,
                                                 req_u->req3.tp_block_size)=
);
        p1->blk_sizeof_priv =3D req_u->req3.tp_sizeof_priv;
-       rwlock_init(&p1->blk_fill_in_prog_lock);

        p1->max_frame_len =3D p1->kblk_size - BLK_PLUS_PRIV(p1->blk_sizeof_=
priv);
        prb_init_ft_ops(p1, req_u);
@@ -697,25 +697,11 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_e=
xpired(struct hrtimer *t)
        struct tpacket_block_desc *pbd;

        spin_lock(&po->sk.sk_receive_queue.lock);
+       prb_publish_blocks(pkc, po);

        frozen =3D prb_queue_frozen(pkc);
        pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);

-       /* We only need to plug the race when the block is partially filled=
.
-        * tpacket_rcv:
-        *              lock(); increment BLOCK_NUM_PKTS; unlock()
-        *              copy_bits() is in progress ...
-        *              timer fires on other cpu:
-        *              we can't retire the current block because copy_bits
-        *              is in progress.
-        *
-        */
-       if (BLOCK_NUM_PKTS(pbd)) {
-               /* Waiting for skb_copy_bits to finish... */
-               write_lock(&pkc->blk_fill_in_prog_lock);
-               write_unlock(&pkc->blk_fill_in_prog_lock);
-       }
-
        if (!frozen) {
                if (BLOCK_NUM_PKTS(pbd)) {
                        /* Not an empty block. Need retire the block. */
@@ -726,7 +712,7 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_exp=
ired(struct hrtimer *t)
                /* Case 1. Queue was frozen because user-space was
                 * lagging behind.
                 */
-               if (!prb_curr_blk_in_use(pbd)) {
+               if (!prb_curr_blk_in_use(pkc)) {
                        /* Case 2. queue was frozen,user-space caught up,
                         * now the link went idle && the timer fired.
                         * We don't have a block to close.So we open this
@@ -756,7 +742,7 @@ static void prb_flush_block(struct tpacket_kbdq_core *p=
kc1,
        /* Skip the block header(we know header WILL fit in 4K) */
        start +=3D PAGE_SIZE;

-       end =3D (u8 *)PAGE_ALIGN((unsigned long)pkc1->pkblk_end);
+       end =3D (u8 *)PAGE_ALIGN((unsigned long)pbd1 + pkc1->kblk_size);
        for (; start < end; start +=3D PAGE_SIZE)
                flush_dcache_page(pgv_to_page(start));

@@ -777,15 +763,7 @@ static void prb_flush_block(struct tpacket_kbdq_core *=
pkc1,
 #endif
 }

-/*
- * Side effect:
- *
- * 1) flush the block
- * 2) Increment active_blk_num
- *
- * Note:We DONT refresh the timer on purpose.
- *     Because almost always the next block will be opened.
- */
+/* The producer may already be filling another block. */
 static void prb_close_block(struct tpacket_kbdq_core *pkc1,
                struct tpacket_block_desc *pbd1,
                struct packet_sock *po, unsigned int stat)
@@ -799,7 +777,7 @@ static void prb_close_block(struct tpacket_kbdq_core *p=
kc1,
        if (atomic_read(&po->tp_drops))
                status |=3D TP_STATUS_LOSING;

-       last_pkt =3D (struct tpacket3_hdr *)pkc1->prev;
+       last_pkt =3D pkc1->pkbdq[pkc1->publish_blk_num].last_pkt;
        last_pkt->tp_next_offset =3D 0;

        /* Get the ts of the last pkt */
@@ -824,8 +802,27 @@ static void prb_close_block(struct tpacket_kbdq_core *=
pkc1,
        prb_flush_block(pkc1, pbd1, status);

        sk->sk_data_ready(sk);
+}
+
+/* Caller holds the receive queue lock. Never wait for unfinished copies. =
*/
+static void prb_publish_blocks(struct tpacket_kbdq_core *pkc,
+                              struct packet_sock *po)
+{
+       unsigned int pending =3D pkc->pending_blocks;
+
+       while (pending--) {
+               struct pgv *block =3D &pkc->pkbdq[pkc->publish_blk_num];
+               struct tpacket_block_desc *pbd =3D (void *)block->buffer;

-       pkc1->kactive_blk_num =3D GET_NEXT_PRB_BLK_NUM(pkc1);
+               /* Pairs with the release decrement after every completed c=
opy. */
+               if (atomic_read_acquire(&block->in_flight))
+                       break;
+               prb_close_block(pkc, pbd, po, block->retire_status);
+               WRITE_ONCE(block->last_pkt, NULL);
+               if (++pkc->publish_blk_num =3D=3D pkc->knum_blocks)
+                       pkc->publish_blk_num =3D 0;
+               pkc->pending_blocks--;
+       }
 }

 static void prb_thaw_queue(struct tpacket_kbdq_core *pkc)
@@ -852,6 +849,7 @@ static void prb_open_block(struct tpacket_kbdq_core *pk=
c1,
 {
        struct timespec64 ts;
        struct tpacket_hdr_v1 *h1 =3D &pbd1->hdr.bh1;
+       struct pgv *block =3D &pkc1->pkbdq[pkc1->kactive_blk_num];

        smp_rmb();

@@ -877,6 +875,7 @@ static void prb_open_block(struct tpacket_kbdq_core *pk=
c1,
        pbd1->version =3D pkc1->version;
        pkc1->prev =3D pkc1->nxt_offset;
        pkc1->pkblk_end =3D pkc1->pkblk_start + pkc1->kblk_size;
+       atomic_set(&block->in_flight, 0);

        prb_thaw_queue(pkc1);

@@ -932,7 +931,7 @@ static void *prb_dispatch_next_block(struct tpacket_kbd=
q_core *pkc,
        pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);

        /* 2. If this block is currently in_use then freeze the queue */
-       if (TP_STATUS_USER & BLOCK_STATUS(pbd)) {
+       if (prb_curr_blk_in_use(pkc)) {
                prb_freeze_queue(pkc, po);
                return NULL;
        }
@@ -950,31 +949,24 @@ static void prb_retire_current_block(struct tpacket_k=
bdq_core *pkc,
                struct packet_sock *po, unsigned int status)
 {
        struct tpacket_block_desc *pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(p=
kc);
+       struct pgv *block =3D &pkc->pkbdq[pkc->kactive_blk_num];

-       /* retire/close the current block */
-       if (likely(TP_STATUS_KERNEL =3D=3D BLOCK_STATUS(pbd))) {
-               /*
-                * Plug the case where copy_bits() is in progress on
-                * cpu-0 and tpacket_rcv() got invoked on cpu-1, didn't
-                * have space to copy the pkt in the current block and
-                * called prb_retire_current_block()
-                *
-                * We don't need to worry about the TMO case because
-                * the timer-handler already handled this case.
-                */
-               if (!(status & TP_STATUS_BLK_TMO)) {
-                       /* Waiting for skb_copy_bits to finish... */
-                       write_lock(&pkc->blk_fill_in_prog_lock);
-                       write_unlock(&pkc->blk_fill_in_prog_lock);
-               }
-               prb_close_block(pkc, pbd, po, status);
+       if (!BLOCK_NUM_PKTS(pbd))
                return;
-       }
+       block->retire_status =3D status;
+       WRITE_ONCE(block->last_pkt, (struct tpacket3_hdr *)pkc->prev);
+       pkc->pending_blocks++;
+       pkc->kactive_blk_num =3D GET_NEXT_PRB_BLK_NUM(pkc);
+       prb_publish_blocks(pkc, po);
 }

-static int prb_curr_blk_in_use(struct tpacket_block_desc *pbd)
+static int prb_curr_blk_in_use(struct tpacket_kbdq_core *pkc)
 {
-       return TP_STATUS_USER & BLOCK_STATUS(pbd);
+       struct pgv *block =3D &pkc->pkbdq[pkc->kactive_blk_num];
+       struct tpacket_block_desc *pbd =3D (void *)block->buffer;
+
+       return READ_ONCE(block->last_pkt) ||
+              (TP_STATUS_USER & READ_ONCE(BLOCK_STATUS(pbd)));
 }

 static int prb_queue_frozen(struct tpacket_kbdq_core *pkc)
@@ -982,14 +974,6 @@ static int prb_queue_frozen(struct tpacket_kbdq_core *=
pkc)
        return pkc->reset_pending_on_curr_blk;
 }

-static void prb_clear_blk_fill_status(struct packet_ring_buffer *rb)
-       __releases(&pkc->blk_fill_in_prog_lock)
-{
-       struct tpacket_kbdq_core *pkc  =3D GET_PBDQC_FROM_RB(rb);
-
-       read_unlock(&pkc->blk_fill_in_prog_lock);
-}
-
 static void prb_fill_rxhash(struct tpacket_kbdq_core *pkc,
                        struct tpacket3_hdr *ppd)
 {
@@ -1038,7 +1022,6 @@ static void prb_fill_curr_block(char *curr,
                                struct tpacket_kbdq_core *pkc,
                                struct tpacket_block_desc *pbd,
                                unsigned int len)
-       __acquires(&pkc->blk_fill_in_prog_lock)
 {
        struct tpacket3_hdr *ppd;

@@ -1048,7 +1031,7 @@ static void prb_fill_curr_block(char *curr,
        pkc->nxt_offset +=3D TOTAL_PKT_LEN_INCL_ALIGN(len);
        BLOCK_LEN(pbd) +=3D TOTAL_PKT_LEN_INCL_ALIGN(len);
        BLOCK_NUM_PKTS(pbd) +=3D 1;
-       read_lock(&pkc->blk_fill_in_prog_lock);
+       atomic_inc(&pkc->pkbdq[pkc->kactive_blk_num].in_flight);
        prb_run_all_ft_ops(pkc, ppd);
 }

@@ -1063,6 +1046,7 @@ static void *__packet_lookup_frame_in_block(struct pa=
cket_sock *po,
        char *curr, *end;

        pkc =3D GET_PBDQC_FROM_RB(&po->rx_ring);
+       prb_publish_blocks(pkc, po);
        pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);

        /* Queue is frozen when user space is lagging behind */
@@ -1071,7 +1055,7 @@ static void *__packet_lookup_frame_in_block(struct pa=
cket_sock *po,
                 * Check if that last block which caused the queue to freez=
e,
                 * is still in_use by user-space.
                 */
-               if (prb_curr_blk_in_use(pbd)) {
+               if (prb_curr_blk_in_use(pkc)) {
                        /* Can't record this packet */
                        return NULL;
                } else {
@@ -1091,7 +1075,7 @@ static void *__packet_lookup_frame_in_block(struct pa=
cket_sock *po,
        end =3D (char *)pbd + pkc->kblk_size;

        /* first try the current block */
-       if (curr+TOTAL_PKT_LEN_INCL_ALIGN(len) < end) {
+       if (curr + TOTAL_PKT_LEN_INCL_ALIGN(len) <=3D end) {
                prb_fill_curr_block(curr, pkc, pbd, len);
                return (void *)curr;
        }
@@ -1142,7 +1126,9 @@ static void *prb_lookup_block(const struct packet_soc=
k *po,
        struct tpacket_kbdq_core *pkc  =3D GET_PBDQC_FROM_RB(rb);
        struct tpacket_block_desc *pbd =3D GET_PBLOCK_DESC(pkc, idx);

-       if (status !=3D BLOCK_STATUS(pbd))
+       if (status =3D=3D TP_STATUS_KERNEL && READ_ONCE(pkc->pkbdq[idx].las=
t_pkt))
+               return NULL;
+       if (status !=3D (READ_ONCE(BLOCK_STATUS(pbd)) & TP_STATUS_USER))
                return NULL;
        return pbd;
 }
@@ -1150,8 +1136,8 @@ static void *prb_lookup_block(const struct packet_soc=
k *po,
 static int prb_previous_blk_num(struct packet_ring_buffer *rb)
 {
        unsigned int prev;
-       if (rb->prb_bdqc.kactive_blk_num)
-               prev =3D rb->prb_bdqc.kactive_blk_num-1;
+       if (rb->prb_bdqc.publish_blk_num)
+               prev =3D rb->prb_bdqc.publish_blk_num - 1;
        else
                prev =3D rb->prb_bdqc.knum_blocks-1;
        return prev;
@@ -1269,6 +1255,8 @@ static bool __tpacket_v3_has_room(const struct packet=
_sock *po, int pow_off)

        len =3D READ_ONCE(po->rx_ring.prb_bdqc.knum_blocks);
        idx =3D READ_ONCE(po->rx_ring.prb_bdqc.kactive_blk_num);
+       if (!prb_lookup_block(po, &po->rx_ring, idx, TP_STATUS_KERNEL))
+               return false;
        if (pow_off)
                idx +=3D len >> pow_off;
        if (idx >=3D len)
@@ -2274,6 +2262,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct ne=
t_device *dev,
        unsigned int slot_id =3D 0;
        int vnet_hdr_sz =3D 0;
        struct virtio_net_hdr vnet_hdr;
+       struct pgv *copy_block =3D NULL;

        /* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIG=
NMENT.
         * We may add members to them until current aligned size without fo=
rcing
@@ -2306,8 +2295,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct n=
et_device *dev,
        if (!res)
                goto drop_n_restore;

-       /* If we are flooded, just give up */
-       if (__packet_rcv_has_room(po, skb) =3D=3D ROOM_NONE) {
+       /* V3 allocation must get a chance to publish completed pending blo=
cks. */
+       if (__packet_rcv_has_room(po, skb) =3D=3D ROOM_NONE &&
+           (po->tp_version !=3D TPACKET_V3 ||
+            !READ_ONCE(po->rx_ring.prb_bdqc.pending_blocks))) {
                atomic_inc(&po->tp_drops);
                goto drop_n_restore;
        }
@@ -2389,6 +2380,11 @@ static int tpacket_rcv(struct sk_buff *skb, struct n=
et_device *dev,
                                        TP_STATUS_KERNEL, (macoff+snaplen))=
;
        if (!h.raw)
                goto drop_n_account;
+       if (po->tp_version =3D=3D TPACKET_V3) {
+               struct tpacket_kbdq_core *pkc =3D &po->rx_ring.prb_bdqc;
+
+               copy_block =3D &pkc->pkbdq[pkc->kactive_blk_num];
+       }

        if (po->tp_version <=3D TPACKET_V2) {
                slot_id =3D po->rx_ring.head;
@@ -2518,7 +2514,8 @@ static int tpacket_rcv(struct sk_buff *skb, struct ne=
t_device *dev,
                spin_unlock(&sk->sk_receive_queue.lock);
                sk->sk_data_ready(sk);
        } else if (po->tp_version =3D=3D TPACKET_V3) {
-               prb_clear_blk_fill_status(&po->rx_ring);
+               /* No frame accesses may follow this release. */
+               atomic_dec_return_release(&copy_block->in_flight);
        }

 drop_n_restore:
@@ -4376,8 +4373,9 @@ static __poll_t packet_poll(struct file *file, struct=
 socket *sock,

        spin_lock_bh(&sk->sk_receive_queue.lock);
        if (po->rx_ring.pg_vec) {
-               if (!packet_previous_rx_frame(po, &po->rx_ring,
-                       TP_STATUS_KERNEL))
+               if (po->tp_version =3D=3D TPACKET_V3 ?
+                   !!packet_previous_rx_frame(po, &po->rx_ring, TP_STATUS_=
USER) :
+                   !packet_previous_rx_frame(po, &po->rx_ring, TP_STATUS_K=
ERNEL))
                        mask |=3D EPOLLIN | EPOLLRDNORM;
        }
        __packet_rcv_try_clear_pressure(po);
diff --git a/net/packet/internal.h b/net/packet/internal.h
index f5c8cd0eed2c..bece88a9672c 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -20,7 +20,7 @@ struct tpacket_kbdq_core {
        unsigned int    feature_req_word;
        unsigned int    hdrlen;
        unsigned char   reset_pending_on_curr_blk;
-       unsigned short  kactive_blk_num;
+       unsigned int    kactive_blk_num;
        unsigned int    blk_sizeof_priv;

        unsigned short  version;
@@ -36,7 +36,8 @@ struct tpacket_kbdq_core {

        struct sk_buff  *skb;

-       rwlock_t        blk_fill_in_prog_lock;
+       unsigned int    publish_blk_num;
+       unsigned int    pending_blocks;

        /* Default is set to 8ms */
 #define DEFAULT_PRB_RETIRE_TOV (8)
@@ -49,6 +50,10 @@ struct tpacket_kbdq_core {

 struct pgv {
        char *buffer;
+       /* RX V3 only; last_pkt marks a sealed, unpublished block. */
+       struct tpacket3_hdr *last_pkt;
+       atomic_t in_flight;
+       unsigned int retire_status;
 };

 struct packet_ring_buffer {
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
