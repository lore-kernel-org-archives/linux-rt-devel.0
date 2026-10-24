Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848661;
	b=wy5cTFvzx++wRWbmGmu9iNPMuHB3pLJ3arA0U75rVGNmktZoAgyKdHuz1B/Tisvejtmc
	 sLwDu/4l9rMyfDu/7Sm3xDw1zR0XMyDZQzwHRmzToqrYKsAFowpm7JDt5ojDxIcI3Pa9P
	 0GPeS/ifE8kOEl6tkyV2IhMsrspGBmTl74MzJId20rlPd20BT5e2DEkyi564IeqwhB5V7
	 Z7Lsc8eNWQuAViSqd/p5aJDwbD1N4PrxDiYAda/+MuoSTb1xx/H3qduM6gNgYupcrJutn
	 vrSmAeU31px+IOaoRxBK1ToFPF5EwNiUHmDPI8Q2weeo4LBaeshjqWYxMqFbH15kSuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848661;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HD26WpIM7L8NT+DrUSjizJyQJeOKDPtsAHeCGpKgER8=;
	b=kWb4IuJbPpKWvI2QZHSS5+nZnldLjo449z7PfQ7B8Ii+WY+i3Y9gNt8gKb7YqEW4s0bA
	 zrt44RroNTm/iq3tTmjqoJv0MmMsAuBUbdJdk0925PVolILbPAHbq7fNMuYghakdMLcfm
	 YI+aAoAPMRT/e34Cf7wQCXDOO0NROCFBBQNyDRIP6Ni2fGaSE7HJQYgeuD+GJrnacoyvQ
	 cNgdw7UBbaiMfJwSDRp/p7qLSm3Xh3LAi/Wv3k82paFuwOV3xQzMGCtAZ2neoGnav/CXA
	 vqOJuTLAl1wVud40J9TBliBSqMKJ3cgIgI75YZy9DfVeoCOlRre6ioCXjftPiUZI/JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KLOHPy+J;
	arc=none smtp.remote-ip=95.215.58.23
Received: from mta1.migadu.com (out-23.mta1.migadu.com [95.215.58.23])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33606606A31B
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:30:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33606606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KLOHPy+J
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=VlZR4Mxhbr+tblFwUgawmMQFo36/RGCn8J3pb3HzoQw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848658; v=1; x=1793453458;
 b=KLOHPy+J8SmcEnHavDbXjCZigUHzfeh2ASM35JcIk1yNiDOGjSnwfkN4lWlyuUG8DaqlazT4
 ZzXNxlr5VFzbu63EpolK6GJTTpLwCPy6wMJ/sho3oytXAEvZpinOtuxv9Uy1B+RcHucpU456UUI
 eYAQdThG5txHuJn8XlENaBtM=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id 599f400c215c85f8;
	Sat, 24 Oct 2026 13:30:58 +0000
X-Mizu-Trace-ID: 599f400c215c85f8
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 03/15] net: napi_schedule_rps() cleanup
Date: Sat, 24 Oct 2026 21:30:27 +0800
Message-Id: <e8122d1a655ae736ca1fa0f6dfc185748e8c97ed.1792847032.git.wen.yang@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1792847031.git.wen.yang@linux.dev>
References: <cover.1792847031.git.wen.yang@linux.dev>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

commit 8fcb76b934daff12cde76adeab3d502eeb0734b1 upstream.

napi_schedule_rps() return value is ignored, remove it.

Change the comment to clarify the intent.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Tested-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/dev.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index efe483d7e03f..36dbb86496ec 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4722,11 +4722,18 @@ static void trigger_rx_softirq(void *data)
 }
 
 /*
- * Check if this softnet_data structure is another cpu one
- * If yes, queue it to our IPI list and return 1
- * If no, return 0
+ * After we queued a packet into sd->input_pkt_queue,
+ * we need to make sure this queue is serviced soon.
+ *
+ * - If this is another cpu queue, link it to our rps_ipi_list,
+ *   and make sure we will process rps_ipi_list from net_rx_action().
+ *   As we do not know yet if we are called from net_rx_action(),
+ *   we have to raise NET_RX_SOFTIRQ. This might change in the future.
+ *
+ * - If this is our own queue, NAPI schedule our backlog.
+ *   Note that this also raises NET_RX_SOFTIRQ.
  */
-static int napi_schedule_rps(struct softnet_data *sd)
+static void napi_schedule_rps(struct softnet_data *sd)
 {
 	struct softnet_data *mysd = this_cpu_ptr(&softnet_data);
 
@@ -4736,11 +4743,10 @@ static int napi_schedule_rps(struct softnet_data *sd)
 		mysd->rps_ipi_list = sd;
 
 		__raise_softirq_irqoff(NET_RX_SOFTIRQ);
-		return 1;
+		return;
 	}
 #endif /* CONFIG_RPS */
 	__napi_schedule_irqoff(&mysd->backlog);
-	return 0;
 }
 
 #ifdef CONFIG_NET_FLOW_LIMIT
-- 
2.25.1

