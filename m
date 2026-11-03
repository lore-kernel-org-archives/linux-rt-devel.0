Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.98
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793697969;
	b=SeIChW2/bguKQomkNHEFdhM2iTubOpm6llTVsKrNKjdGdBQpsRPwyJ2tZ/0Z3GMxfA5x
	 GKBvovUMFDPG+2ZYh0tYns/YVBsO7nus9CBeDpGVgi2ZwcUAacz9yvLR6lbxgogDBN2ov
	 ZHGU68tXtqhjbWpCIuK6E5mDatMXPobkIcDKjjQ+Z4GU6dDNzpUXTQ8V1GZrHrV0+OjIb
	 uGi/Tt34k0ZLqydBOq1cYT94HOwrSpS3mtjnXsonXqnqYlM1xE8w0U42yeU72maDH2si1
	 1+PEsj5EiG25+5ZdcJiOxW9ZueMO0l4tXA5f1uTa2SICvt0ow3nIcHO+IqNhVG1fp9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697969;
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
	bh=N1V6R7hWu/VsmWa0IUlxV7mZMzkRPXPTNYOFb07tu/s=;
	b=GAaJUjoGQujJbcZJ/L8diLnURWBtp/MzFgCvtYMvoU37zgHB5yXBpygQ7qot+P0fYq7N
	 bHIwZUFg/HvbZqFGwEDrzb2IMr5rIAyta1OKJlidkJD+uGtGmJTEZztEkSqElDQILnQfJ
	 6fHoS8L7iAHJtaL4PZA1frqDrET0AJCbZHQaxrh3kOIFvNP+yPn9+jP6rV8xAeSJ549U1
	 7ibFaIOx5WHXF8IWwOACl/66j2sbN6sdGrStgrIXweDTNuTNcK3zg0lTqdjSk6tDdLQxk
	 4DNb+BelHfG92O+z8wE5+TE7qGU8rMNF091aLBY4l4TsPYPcorNUQHqTD5taPsuWIbA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deeproute.ai;
	spf=pass smtp.mailfrom=deeproute.ai;
	dkim=pass header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=K8YkjF3g;
	arc=pass header.oldest-pass=0 smtp.remote-ip=139.219.146.98
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2098.outbound.protection.partner.outlook.cn [139.219.146.98])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FE5606A32C
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 09:26:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8FE5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deeproute.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=deeproute.ai header.i=@deeproute.ai header.a=rsa-sha256 header.s=selector1 header.b=K8YkjF3g
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9Yao+OnQxJ2t30vvX49ag74qgXiv/+MAFuxIA0mJejsTTps4Lfz7+9Nt2xrvLTXQk/fztDWixaBosEHrS2F458zVGBsLa6K/yvE+xl68HXxmVTDFUP/MQmV7sp4lqiMssJM59yU4wkApSwOjDyZ9e5Z3OotdO1LyQwnEL47U+YcawujylmGvE+Hav6/W/yW5CbZRmgNWOwXmSAMv9QIifwJSn1n7Tea2yZAFMEUonbemYVRd5dNb1JUR+Rg7jhgSrjgvxZRmitCEqE0E1sd0leAAQjd3yQmv7KVZ5gfNd5eBUJsLyE95VciicmHTprCD5OatPK0wHwXUslFD2rYqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1V6R7hWu/VsmWa0IUlxV7mZMzkRPXPTNYOFb07tu/s=;
 b=CXLjtMqPwaptTNu+IKKVqrK1l2zZCEytJ4yBMOtJqieoksdESULc5VeE1i/AJ5JRLcZ1Az9fboZ5ma5y1ZILulikE6T9C2LA+YhSk3gRcTQ6Sb+ejq3Xaa3bi99cW+Q8Q6fzF9pQJVE2pExntbjvMxRc/FqBmcTytmP7pQUoJeBrRaYJhUpfGiHiiBMyCmj8Oe8I6udPPQXWoees3XmsyO3Kx1Kc6njy7GUPaHvPjWhg1ktwYEhkKGPu6VUB5PoRqitnUY/CNBLz7iTxB80jc1S8DbWWDOvAxXdG64uBucVlNvfcHzT3AztEy2NHiYm/jQREIWq/lEVtfUGlgHxiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=deeproute.ai; dmarc=pass action=none header.from=deeproute.ai;
 dkim=pass header.d=deeproute.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=deeproute.ai;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1V6R7hWu/VsmWa0IUlxV7mZMzkRPXPTNYOFb07tu/s=;
 b=K8YkjF3gQvu3xk3WF9D46HprBmx6y1GEfvzn937PdrepNpt3dmVLBfEeQWkPg5Q7J4lYFlMn6/x1Fp3CfAn+e2KN8o3G5IU9FcnkjwNeJ9e5FIF9Lz79dnbSNqEdnPmYdDeRcY4a8CjMB5PZMcUiARt4bsC2ADVHTVfOmUDDz3k=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=deeproute.ai;
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::9) by ZQZPR01MB1074.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 09:25:57 +0000
Received: from ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
 ([fe80::2dda:e54d:5a3c:d686]) by
 ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn ([fe80::2dda:e54d:5a3c:d686%7])
 with mapi id 15.21.0592.007; Tue, 3 Nov 2026 09:25:57 +0000
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
Subject: [RFC PATCH net v3 0/1] af_packet: avoid waiting for TPACKET_V3 copies at retirement
Date: Tue,  3 Nov 2026 09:25:40 +0000
Message-ID: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
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
X-MS-TrafficTypeDiagnostic: ZQZPR01MB0980:EE_|ZQZPR01MB1074:EE_
X-MS-Office365-Filtering-Correlation-Id: dec972a5-9ca0-42d3-ec7f-08df398c7791
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|23010399003|10067099003|261102123227099003|18002099003|3023799007|38350700014|56012099006|261022075727099003|261026121527099003|261026140227099003|261022115727099003|261021121427099003|261022105027099003|261028144727099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	Cp10r1CFnGgNXexizoMhvqASrTj2lNH9Fyvc5Ujgk+MAvKH8Kl5xV7b5+90x76z5qTUxf/u+hmlM3KMenMxvpRgWcxRqTzAkC7ygGoJG4VtV9Vf3BfIIP7gAtbizQoTl0SQ6f/auuQZTSgU4hFJ7+fYcohM8SJR1xDm/K5vOaWgs7GD/jHMPZbFjY4uvmMKPUA4xGaDacqVqooWjtb6pdP4s8WOKrBURLHabJREmjPYG18HdNLEy8S8SK2q6Frr051uH74FYmII+d/ShtC0oPNNpOWfdZ21ISrSDnvdMrRyi79enj4QLdFKCdauoLXBfDgoMjcJVGVVugO/Jg3r2mhsLLn8W9xHp/0b9lyFAKU64J4KBlVAgL/AgsTM3vhSMCtlDv19fgpwcOueBoreu0RWu8gtHa1yCz8Cgqac4cL0INAtc5DRB3jUQjTV7yej+7OAQUrBN7PS+g8IrFX3qaUG+jvDcI86XTX9p6hNYrW7j/RXpknQ8GXl86i5uXuw3airKSFxmilIMD1jYIBoNqKxY+z+ciUijTS3xqmRYlobImOpQurr6io3g+dyUZtlp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(23010399003)(10067099003)(261102123227099003)(18002099003)(3023799007)(38350700014)(56012099006)(261022075727099003)(261026121527099003)(261026140227099003)(261022115727099003)(261021121427099003)(261022105027099003)(261028144727099003)(261009223027099003)(261021123027099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nDpXNDzyzGhIowcIX/xAL0K7LU/CmyO/kxVSWxl12XyiDMw8itFcirk3Bo9n?=
 =?us-ascii?Q?McGcz0lI4tqwoSO6QzclPzgZf5BhDD1XDLkbu0SZrwPoazb+Q8QmMXW1uR41?=
 =?us-ascii?Q?K2FVGHCJjfJeLuV14TWLWcXkMjuryVptRZ88t7cdkMCvokE0PD0BNyg8/qpx?=
 =?us-ascii?Q?nOIr6QTNHmSUXUcxwA1Rbvop+OngO5601UojIz8XVWFaaCNx/6OXed5BSkK0?=
 =?us-ascii?Q?C2k+RgvbfFlgHUzbcRXOyuX5nz5bihX8H4i7i+Srh/ULpwtC9tje+V3+2H8f?=
 =?us-ascii?Q?vzjhDAO/kBYrIKPaLxDOxYmUTJaLSM8wURoE9ZKOHKKZYIleFCcx9NQHLKKd?=
 =?us-ascii?Q?ugtNxWdoS4rAFvSimVqj7B8UyvfnkxU2Z7can8TsUB8jWUBoPR4FxQbvJQKd?=
 =?us-ascii?Q?ElM5LeBM2Rs+cKZiL5BsJV3ano8eyE0tXg69X47VVuo4QZ1gS8C4BJTpohyI?=
 =?us-ascii?Q?XO7TuLVa7aYY1gWtuD8a92FEp3aW62lVz0jM9zx2riVTV4ILjzuNOKse03h7?=
 =?us-ascii?Q?Ok5AvDq20+HQKx44HNE9SLu8dPCJNWyxKuury41F5GHqn2NSymE8gikWPb4x?=
 =?us-ascii?Q?2g9llFAsZlbi4HWjGPLH9tSM4PAFjyP7nh2A2tvJVJi1WkdWLniIewyUqfw8?=
 =?us-ascii?Q?3DFmBQrnDeF8qlqwIR4j8xdtikMYUveXhge7EYlrfs5YJ16206JwSdC3UslE?=
 =?us-ascii?Q?8x9to56cuZ6SY056O+w5qhGqKolfYCAEF1Jpi7+rqa5sztf01Ne/u9BuhkPH?=
 =?us-ascii?Q?yOvkEiXkzAEnsciSn7DlGGjYUBw4proPiRcudGixxHWmfPZG3pAHtIXwL8FA?=
 =?us-ascii?Q?+EN/rkb+VFCr3QWzNhCPrJUd4+JXZQIZT4LfZ/U9HIKI8e0j3i/umTlIHBJN?=
 =?us-ascii?Q?KChn0T6TRLJam5az2heWlxTY8kjnWxAAY8PCosAyHTWbgH3D6PabrWwCNTh2?=
 =?us-ascii?Q?BYt6aa7zU6j3AfLNZxNpsEh4n62JigUj8ZX4M7aZFtJgyx0LCodHbRVygTp6?=
 =?us-ascii?Q?ur58twdcpJdJPEnqKRf+6iDCbjCebi+E89iN5T42TQxg8efqeEsm27yjFlPg?=
 =?us-ascii?Q?OdBBvcFuyoZvdrIydOpSw/hyIP7zB+AcUYWHMAjVq3acuzLFWl3WW7DUuSam?=
 =?us-ascii?Q?e+g94SRYqI7l971P9K24AKiAh552cnIv8Bk0qmfrVUUrYpR30pZrhMeCRk4W?=
 =?us-ascii?Q?aNNY5woKIkh5VptFbk6GLVeK86IcFD7tXbP8WbfmAA25NUjKc8RnfgtI3YOo?=
 =?us-ascii?Q?Atz53DHyOGETzOfro9MBautGqBvdGTMAHANBIneYZebs8bOWKjlSxaHUYVcO?=
 =?us-ascii?Q?P/gLZLy8OIX/gAqe5jIuEK2ranO/jHhuLjJCBpHnVtk5y6I634dWaTQqfIKy?=
 =?us-ascii?Q?FpGyZA2nwqGFQSt+0rExCfaR1T4R9KrvJc1bwfMLHJgxWd8mKQfWERUCmDyC?=
 =?us-ascii?Q?Vswk5NEgpZ6sxLnf/fIxEKhmWggZzOptHzGkLQ0e+JRuvDFssSnk9KTMdNvP?=
 =?us-ascii?Q?+hqlpJQG8vQ+loNDxq74mld4MkvnXDz7bQxJmy79FbXmSxugr6eqQ+Y9XJtm?=
 =?us-ascii?Q?1FKRgEeOzbq2Ul4xYgu5JE5NfgNJxHOy0DLIvcsK2oA2pM6HSdKC0NcQjgK4?=
 =?us-ascii?Q?CN/rPVfVw5TXxZgBHdatUDsDyHnSysXPVAz7hCy3n8SIR9gb3+A6XJ9Tg87v?=
 =?us-ascii?Q?jpEwvQKvtN/5og0MU5zZ9t7vmcyPsTzFqIx/LfSY6DMfKMQHka3uSecj/+W7?=
 =?us-ascii?Q?p0z0xrhqcA=3D=3D?=
X-OriginatorOrg: deeproute.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: dec972a5-9ca0-42d3-ec7f-08df398c7791
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0980.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 09:25:57.5354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: df535b4a-68e6-4339-a092-afa4f2c24fcc
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZvlHazCv8hEnYhN+IPI8ZOSHSRH4eVOVb5D/H3vyuFoPXSnpE2VNuIFGntxHcyG2wIQF5kevvfKYQBf/WSJmM3mipDDRrzeZGjGx4YEnwU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1074

From: jingxuanxie <jingxuanxie@deeproute.ai>

This is v3 of the TPACKET_V3 block-retirement fix. It replaces both v2
postings; please review only this thread.

v2 tried to remove the wait by allowing capture into the next block while
copies were still in flight. That required per-block copy accounting,
ordered publication, and handling for a backlog of ready blocks. Willem
asked for a smaller fix first: make block retirement non-blocking and let
the existing timer retry.

v3 does exactly that, in one patch:

- prb_retire_current_block() uses write_trylock() instead of write_lock().
  If a copier still holds the read lock, the current block and its
  metadata are left untouched and false is returned.
- __packet_lookup_frame_in_block() stops instead of dispatching the next
  block when retirement fails; tpacket_rcv() drops this capture record
  and accounts it in tp_drops. The original packet is not affected.
- The retirement timer re-arms and retries if it cannot take the lock.
- A later packet can also retire the block once the copier has finished.

There is no spillover into the next block, no per-block state, no worker
and no publication budget. The existing lock order and rwlock completion
ordering are preserved.

The cost is a higher capture drop rate while a copier is preempted. This
is a deliberate trade-off to keep the receive path moving on PREEMPT_RT.

The v2 1/2 virtio-header prevalidation patch is not part of v3. It is an
independent bug fix; I will rework it separately with a concrete
description of the state left behind and a shared error path, as Willem
asked.

Testing so far:
- ARM64 PREEMPT_RT W=3D1 build of af_packet.o: pass
- QEMU ARM64 SMP PREEMPT_RT (4 CPUs, lockdep, debug spinlocks):
  psock_tpacket and psock_fanout pass; three consecutive candidate
  boots pass the delayed-copier tests. The TCG fanout queue-length
  warning is also present on the unpatched baseline and the program
  exits 0.
- Full-block path: with A delayed, B's sendto returned in 0.7 ms, only
  B's capture record was dropped (tp_drops=3D1), and no block was
  published. After release, A and the next packet were published, B was
  absent, and payload and length were verified.
- Timer-only path: 15 failed timer trylocks while A was delayed; the
  timer published A after release.
- Close/unmap while A was delayed: no hang or crash.
- Baseline contrast: without the patch, B blocked 505 ms until A was
  released and was captured.
- Control-flow harness covering rx-busy, timer-busy, recovery, full ring
  and shutdown: 6/6 pass. checkpatch on the diff: clean.

Not yet run: Orin hardware, KASAN/KCSAN, and capture drop-rate or
latency measurements. Timings above are QEMU TCG observations, not
hardware RT guarantees.

v2 thread (second posting):
https://lore.kernel.org/netdev/20261030081704.251652-1-jingxuanxie@deeprout=
e.ai/

v2 review:
- 1/2: https://lore.kernel.org/netdev/willemdebruijn.kernel.17d3748debf8b@g=
mail.com/
- 2/2: https://lore.kernel.org/netdev/willemdebruijn.kernel.54d115047658@gm=
ail.com/

jingxuanxie (1):
  af_packet: avoid waiting for TPACKET_V3 copies at retirement

 net/packet/af_packet.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

base-commit: 1f1f8e8c5176234fa31858cd25f2e9b88aac0a45


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
