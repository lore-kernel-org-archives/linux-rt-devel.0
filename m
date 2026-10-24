Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848685;
	b=oSfQr2e3lOuFGBJHL5DpLnbiVh8WLArxT0ydP7IMRxljn7/Z0RHB9T32Ry415Fb0yhK4
	 EOLGp48NqLjjrE3IdK2LyLihfp86z4/7HqevWj5l1mVyB0WScCsUWsEv77b94hSXJTwsE
	 7WN0Ylr9kS5xxCHdSllQU5Z5zjF0+GlhtkFM8zrSJct3MTWK9yw2rh1STp6JTnB4pC0JT
	 fEaJD6MwW6joINsU15OEhz0+6dMysNTE3QqW4ZVeDZi0HjrTK/YQQ+zlbM7N55nUaDHsk
	 D2uixXnKVKJezrrgsNjpOKTQyca1zMRytFNx0JZSFjsdshvRuSe61R0XfV4Piuq/NpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848685;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7hsOPqdhlgQcaTelrEMxHen/f+5t0Y1t+gFNN2pYDS0=;
	b=xx/6cjYzLrATV/Pifb/zlRJID4oP0FVkEAbj2hc2cBgmUEvfez9eWw/boZelw/o9klIk
	 JgYaHT7BWcs8ubqf3ap1loDvEMv6W6FMGLcLJLLxD+6GoWjYqdkQ51G7wxaqhh8HwYvEd
	 cAtGV7wBbyT7qJh2rN/1QPVm/uQg77uoQ4O4ampEOFJRz/4hggP+9ZRHHd8Uork3W04Yv
	 jRBurGxqdmpaGnG5/8dQ+6iC74KLhjFnrNdKFT66yZjUGOiGkfk1Ha7kqJ1y7eScB0ZMF
	 /qyFpNzKp+k4Sxx3mAbOEKH513kW169wRplspmEmfl5UoVR7kjdgXXJRWVqHZwtUU+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vjktuFsc;
	arc=none smtp.remote-ip=95.215.58.41
Received: from mta1.migadu.com (out-41.mta1.migadu.com [95.215.58.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC7606A31A
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24CC7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vjktuFsc
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=v7pK23cEJwXDA7NRq3cUL8owWe2UjNebeZQAaqr21aw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848682; v=1; x=1793453482;
 b=vjktuFscFQhdSwdQrDcjbyKU54vXPHkjgGcPtpjdLAMMABF5AhrtOUwr0uHWVSzKPs709Gp7
 7rd9/mP9/4caZHqnX0c8vlRg+jiRdWsP73hzyoj+VUroqteE+5m9uQGOgWKWONQFcsw1TBtWu+8
 9dRclEtYyEgqbsnEV3rKLzEI=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id 9818ef19a1ee113d;
	Sat, 24 Oct 2026 13:31:21 +0000
X-Mizu-Trace-ID: 9818ef19a1ee113d
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 08/15] net: do not provide hard irq safety for sd->defer_lock
Date: Sat, 24 Oct 2026 21:30:32 +0800
Message-Id: <944821e0eb0fdf47f09b8966ad52cd4c009f002b.1792847032.git.wen.yang@linux.dev>
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

commit 931e93bdf8ca71cef1f8759c43bc2c5385392b8b upstream.

kfree_skb() can be called from hard irq handlers,
but skb_attempt_defer_free() is meant to be used
from process or BH contexts, and skb_defer_free_flush()
is meant to be called from BH contexts.

Not having to mask hard irq can save some cycles.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/dev.c    | 4 ++--
 net/core/skbuff.c | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index db1fe85ebc90..c8789241f4a7 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6779,11 +6779,11 @@ static void skb_defer_free_flush(struct softnet_data *sd)
 	if (!READ_ONCE(sd->defer_list))
 		return;
 
-	spin_lock_irq(&sd->defer_lock);
+	spin_lock(&sd->defer_lock);
 	skb = sd->defer_list;
 	sd->defer_list = NULL;
 	sd->defer_count = 0;
-	spin_unlock_irq(&sd->defer_lock);
+	spin_unlock(&sd->defer_lock);
 
 	while (skb != NULL) {
 		next = skb->next;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 919ad5a2c5da..6111c1bba704 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6716,7 +6716,6 @@ void skb_attempt_defer_free(struct sk_buff *skb)
 {
 	int cpu = skb->alloc_cpu;
 	struct softnet_data *sd;
-	unsigned long flags;
 	unsigned int defer_max;
 	bool kick;
 
@@ -6735,7 +6734,7 @@ nodefer:	__kfree_skb(skb);
 	if (READ_ONCE(sd->defer_count) >= defer_max)
 		goto nodefer;
 
-	spin_lock_irqsave(&sd->defer_lock, flags);
+	spin_lock_bh(&sd->defer_lock);
 	/* Send an IPI every time queue reaches half capacity. */
 	kick = sd->defer_count == (defer_max >> 1);
 	/* Paired with the READ_ONCE() few lines above */
@@ -6744,7 +6743,7 @@ nodefer:	__kfree_skb(skb);
 	skb->next = sd->defer_list;
 	/* Paired with READ_ONCE() in skb_defer_free_flush() */
 	WRITE_ONCE(sd->defer_list, skb);
-	spin_unlock_irqrestore(&sd->defer_lock, flags);
+	spin_unlock_bh(&sd->defer_lock);
 
 	/* Make sure to trigger NET_RX_SOFTIRQ on the remote CPU
 	 * if we are unlucky enough (this seems very unlikely).
-- 
2.25.1

