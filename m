Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792848690;
	b=mo6s05WxUEk+QUwhYka0EVOe28MrJtu8KFRnxFae0aAJvszczOCvdeuH4ro7S6x79Kvw
	 lrkJGWlB0Y/4RV0SHgJ9t6r9wXVvi/SrBF1/M7qFh1ZET/uscwxYudcRgj4pyYNqVuLuN
	 p9aUvOV94uDOyBl0Bym7jTYEnBXv4ihdc/jJTssP4x4q8HNJz7q3NpxCuXbz9E0SU2YYH
	 bCY5m7JtgXrGiicKiY3xqywDYno4EgJ+Fck4AAPs9GalsNysmIu3YIeOCC99YIFDxONKC
	 0vYTa59/c+9D5sKveE7T4U4b7hHPiXXPijjhqrseMOr4dT8Ghv64bEuQ6mtFT5hGDAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792848690;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iy2+4wBJ6RPwDBSmK6Jvd4TYr5DjKa9V5YzEtF8pP+g=;
	b=0G/8OYOZLwLpDlCd2PTxDEzbXU73lDv7wYjDZ6wShm92CC/0QzVFVE4EpbRgrowtKRiI
	 wCMeBsVYTle2GiGx82mJoTyL1tGjhzUUmBFkYJCxmxI7YzvgOxwkEwog9Muw28W4+5z4V
	 hoS+/od4yD99vjhRozvmhm05OjbctlBmuREYSOtNBf2Vacg14nvvIGWCp6/aVlaxVm2jT
	 +N3uMb+dUncu5549Si+tNYtzU9wLOzhh3dTff7SwGeqmuVY6+7jf5Nf9Qkhya29w2tT0O
	 b3TxfyLfJUeWSXQfFfLu+U+GLh20fA/c4TCpGdJmUrBMsCeUI8vXIrT83ee9mtA1Xhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FHXBPqzQ;
	arc=none smtp.remote-ip=95.215.58.44
Received: from mta1.migadu.com (out-44.mta1.migadu.com [95.215.58.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C7606A31B
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 13:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC4C7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FHXBPqzQ
X-Envelope-To: linux-rt-devel@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=OQsvWYYDKTSrCwcNRn+ysQf3ZrpF3PUXCq1k8vUtuag=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792848688; v=1; x=1793453488;
 b=FHXBPqzQ33ICjEuy2eH5JePc0OPq3e/8l99slJRmw6/POaTqxgjTeocif8uQwgtQ81BD9s7b
 +EY/AONzo4uxlqUErmav2k476QqIvuycLuFPqxLRSC2gBXodS/RTUTy60nwwmWBNASPwyTpR1zr
 gMEabIwB7yzqliAnv6lwrMFM=
X-Envelope-To: linux-rt-devel@lists.linux.dev
Received: by mta11.migadu.com with ESMTPS id aaf2badf5dde2d43;
	Sat, 24 Oct 2026 13:31:27 +0000
X-Mizu-Trace-ID: aaf2badf5dde2d43
X-Migadu-Flow: FLOW_OUT
From: wen.yang@linux.dev
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-rt-devel@lists.linux.dev
Subject: [PATCH 6.1-rt v2 09/15] net: move skb_defer_free_flush() up
Date: Sat, 24 Oct 2026 21:30:33 +0800
Message-Id: <3dfbbd70a40cb3d2891e5e36283c4ce770c5883c.1792847032.git.wen.yang@linux.dev>
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

commit e6f50edfef046cf8ad541b4d5972bf38fdcdec39 upstream.

We plan using skb_defer_free_flush() from napi_threaded_poll()
in the following patch.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 net/core/dev.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c8789241f4a7..df7df594e7f0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6742,6 +6742,27 @@ static int napi_thread_wait(struct napi_struct *napi)
 	return -1;
 }
 
+static void skb_defer_free_flush(struct softnet_data *sd)
+{
+	struct sk_buff *skb, *next;
+
+	/* Paired with WRITE_ONCE() in skb_attempt_defer_free() */
+	if (!READ_ONCE(sd->defer_list))
+		return;
+
+	spin_lock(&sd->defer_lock);
+	skb = sd->defer_list;
+	sd->defer_list = NULL;
+	sd->defer_count = 0;
+	spin_unlock(&sd->defer_lock);
+
+	while (skb != NULL) {
+		next = skb->next;
+		napi_consume_skb(skb, 1);
+		skb = next;
+	}
+}
+
 static int napi_threaded_poll(void *data)
 {
 	struct napi_struct *napi = data;
@@ -6771,27 +6792,6 @@ static int napi_threaded_poll(void *data)
 	return 0;
 }
 
-static void skb_defer_free_flush(struct softnet_data *sd)
-{
-	struct sk_buff *skb, *next;
-
-	/* Paired with WRITE_ONCE() in skb_attempt_defer_free() */
-	if (!READ_ONCE(sd->defer_list))
-		return;
-
-	spin_lock(&sd->defer_lock);
-	skb = sd->defer_list;
-	sd->defer_list = NULL;
-	sd->defer_count = 0;
-	spin_unlock(&sd->defer_lock);
-
-	while (skb != NULL) {
-		next = skb->next;
-		napi_consume_skb(skb, 1);
-		skb = next;
-	}
-}
-
 static __latent_entropy void net_rx_action(struct softirq_action *h)
 {
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
-- 
2.25.1

