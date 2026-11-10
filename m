Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344753;
	b=ADv8XmFM7q2zo+MQKtoqK1PQdG43/uS6koVJpci4+RSpuQHXUIyv/sbJ5iYYginBPsz5
	 U0kb90N2mnk3koQDb/GlliUyWeGf75rzOcLPbyYL4728nk+wUP4UT7waK/Eu1+j4jI3CG
	 vATKwlPKevezBaY5C+2zeHalvvEWfRdH8nbUOUeD4rOVTCt1s0Nm4JHNeOnXUABH+9mbO
	 oOse2U8vvWiN5tNAiBbmWIf8f973AmZ1citbx/5aH4BlVGXDWEL+OYmYzCZ3wvmydj7i9
	 +d7KGWznaJuxXh3RfbSTwhTqBEA4nPmObzYk1hJQpbckl2c5bxuMnru3R3CwE9YmFSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vVZVlJz2xvnsRRciHhmJHZpeRfn5b7Ccf+nD0x4TgnE=;
	b=ThUwgfXDbZBJoAQGXvU7jMvWFmQCU21Lh7Ou52mnUYT4/IuzgKE/RwxdRkCoLJx8QGsS
	 rjLjn6hi85LlQjk/IvoW/xuFX1H0oxYWi9a6DSoFQpO8axSBFxceY2QeFEUq+kciPpmNO
	 3LOCvC3WZJfjQETFxUJxMveVIpzxr1U0efwD1Qo+ZXLo9MRz3SOdv/C88+psZdE4X3cd7
	 F2Vhed+l4aldjRULZybNmWeR8EimvDVZi5huCPMDE9z80xADeBysdKRtQtBiCv/SLOeOk
	 0Nu94xVDwMNADSTIyMyZa7J5k1pQKLaexuuRAht9XvIURizrTs0Hr8/z8afwrK4BKNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=BvLFD1YV;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ABF60A382D
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 21:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40ABF60A382D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=BvLFD1YV
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so345095c88.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 13:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344751; x=1794949551; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vVZVlJz2xvnsRRciHhmJHZpeRfn5b7Ccf+nD0x4TgnE=;
        b=BvLFD1YVi6ggHlH84vlBXwZ3XJZQgnIzP4S6CeZpAOn0M2d4CFa4BQEzCYKA+ehs2E
         qZ4qSdYgeaismJzTRF8f7bL7EH30LXlyf81xUVds7rB9Py4HeWoeLQthYpcGM1hAGZdj
         RET+JncJSf8fd3XmD2zcvBgyvcZlmV3p+3btdYovsNT8au7s8bEZx8OJrmkFQQqNrwPX
         QeF5rfIGlS3CsmX8iGxazFQVVb86wArJwUwUZjysD7YsO2XQ2VOuXX4L3g77iQVNk6+2
         eU96S/1IXyYylV1MSMXftPALmqBGP3GX9G92BwDugGP9YCQCwa5afIfA1D35O4qFsn9W
         8ejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344751; x=1794949551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vVZVlJz2xvnsRRciHhmJHZpeRfn5b7Ccf+nD0x4TgnE=;
        b=ZURxbqW9AbcVedQERZ6pgmQXmdQjpbVcUEb+U2XVkrvaFL9T0tFBLc8rCsC8Ag0jLi
         DV/vIhLkUbnn0Rx/iqamF2vaI0ozDubM0+nqqdKkWwlTH9DRJmiPAiojAW3QpXkdCq7C
         8wbpUp1t25bvkiMqLBIQYkDVW9qRvlGTmOC4M2OJ61RA55R20gNdDUwHJY+S75Fso/yP
         GFDcHUuE/8SGBOIQtLzznUru5oBUu/5oKQTYQ1QvlgpLqyNgt+UZI/3wpukgRfw4Ufzn
         XvwSCwwcyW7fGgX2zxIrBTNtC4GFL/tWwR2Fh78eS0yrexz5zvvq2Lvb+4LcD4cVn206
         RSyg==
X-Forwarded-Encrypted: i=1; AL+hErFkjJLiy5+tS9pQUN4Rlc69rq7iBhXTQrABprvJ9Tz6ExTIAcA028N6Tzs9Oi+yKYpJIW27CzIDpsc++jsUyQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Zcg4oTf3ccaIAczqKNc1Na1P676DqlxcsggZBvD/8VSP5PWUj
	qu5WNaZoo3gUUPTcUPjm7yp1HUEDcVStqkpHURr/+2Ty4oafLklOsSWaIuAQBLPbzCI=
X-Gm-Gg: AYBFou30S7XXQTdX3MXSs2Wh6zf1ASLcyFiSlTZvuQNbi709hKIa+wnpdL8jmRQaSiG
	CQxIu+bbl0SIr6VvW0wy57uqmUQl8muld5V7dyg6KVso3gmNglNZXIarO/7xjQbETiCxU2Hbhjn
	Isd0gsVCyVNoC0xvnS9xKylZ/mnhiGWUQ3dtDAcg3gzwo+aL0fz2ham9Vxut8wBmAaPe65Oaa2K
	1fMSuOrGgMJ8pt+4aX8fKBVek/OLxYysPjJYvLx/08HPoBXFRseNIRdUfxvQCD/CUtb7iDox5gk
	ERMnjjQeyZU4xlIYKfta1REcrn3IcqN7fVTIQYQKWBsUMx8kqJGYC7sroC3IaHExl5GqKGKVG5C
	w2H6cAnQvfajsNy47hdqVldm7dm5dH7Uq2oRxz17Rh1fL/qw6bkhJCNkcqcETP5B/Hv67iGhrlr
	6o/7OJbHXw7NjzGT+5G03iTYOsAZMPRmSEZk9pZs4hTGJdectZdOPqdAn65fr4dab3Mm5dCIPGY
	kEDfDhSpn0c5mdJaHE2uZYTAJF1EDGJNePHu9V0qS06x6JajnI/tnjDpTDqdx0rgAU7VqJ/Q6sN
	R71m3ttQ04z6u3bn24m52YphCo7c/xBIqs7zstAiUEjGDeHM1ksnHFpu/RV/8efvidhxD0g=
X-Received: by 2002:a05:7022:ed07:b0:188:ea93:6cf9 with SMTP id a92af1059eb24-1b3c0359347mr89087c88.43.1794344751021;
        Tue, 10 Nov 2026 13:05:51 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm10464097eec.17.2026.11.10.13.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:05:50 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net v7 5/6] amt: make pre-query report drops visible
Date: Tue, 10 Nov 2026 21:05:36 +0000
Message-ID: <20261110210538.217936-6-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110210538.217936-1-omar@blockcast.net>
References: <20261110210538.217936-1-omar@blockcast.net>
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

A gateway cannot forward an IGMP or MLD report until it has received the
relay's Membership Query for that family.  The Query supplies the
response MAC the Update echoes, so dropping an early report is required,
but doing so silently leaves operators with a dark multicast path and no
indication why the join never happened.

Emit a family-specific debug message before taking the drop path.

tx_dropped could not show these drops either: amt_dev_xmit() reaches the
same tx_dropped increment after amt_send_membership_update() has handed
the report to the tunnel, so in gateway mode every forwarded report was
also counted as a drop. Return NETDEV_TX_OK directly once the report has
been sent, so a report the tunnel accepted is no longer counted in
tx_dropped.

The device is LLTX, so amt_dev_xmit() can run on several CPUs at once;
use DEV_STATS_INC() for tx_dropped and tx_errors, there and in the
control-message senders that update the same counters, so concurrent
increments are not lost.

Found by code inspection while debugging an IPv6-in-IPv6 forwarding
failure in a selftest for the AMT IPv6 outer transport. This drop can
leave one address family dark, so it was a suspect, but that was not
confirmed: the failure was later traced to the selftest, which sent a
single datagram without waiting for the relay's multicast routes to
converge. The drop has not been observed in production, and there is
no oops or trace. The Sashiko AI review of an earlier posting found the
tx_dropped miscount and the non-atomic counter updates.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 99cce0a14..de5b7dbe3 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -735,7 +735,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -745,7 +745,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -790,7 +790,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 	amt_update_gw_status(amt, AMT_STATUS_SENT_DISCOVERY, true);
 out:
@@ -826,7 +826,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -836,7 +836,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -883,7 +883,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 out:
 	rcu_read_unlock();
@@ -905,7 +905,7 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 
 	skb_pull(skb, sizeof(struct ethhdr));
 	if (amt_send_membership_query(amt, skb, tunnel, false)) {
-		amt->dev->stats.tx_dropped++;
+		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
@@ -949,7 +949,7 @@ static struct sk_buff *amt_build_mld_gq(struct amt_dev *amt)
 
 	if (ipv6_dev_get_saddr(amt->net, amt->dev, &ip6h->daddr, 0,
 			       &ip6h->saddr)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		kfree_skb(skb);
 		return NULL;
 	}
@@ -993,7 +993,7 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 
 	skb_pull(skb, sizeof(struct ethhdr));
 	if (amt_send_membership_query(amt, skb, tunnel, true)) {
-		amt->dev->stats.tx_dropped++;
+		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
@@ -1353,7 +1353,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		group.ip6 = ipv6_hdr(skb)->daddr;
 #endif
 	} else {
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 		goto free;
 	}
 
@@ -1366,12 +1366,21 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* Gateway only passes IGMP/MLD packets */
 		if (!report)
 			goto free;
+		/* A validated report can only be forwarded after the relay's
+		 * family-specific Membership Query supplies the state echoed
+		 * by the Membership Update. Log this readiness failure before
+		 * the shared drop path accounts it.
+		 */
 		if ((!v6 && !READ_ONCE(amt->ready4)) ||
-		    (v6 && !READ_ONCE(amt->ready6)))
+		    (v6 && !READ_ONCE(amt->ready6))) {
+			netdev_dbg(dev, "drop %s report: waiting for Membership Query\n",
+				   v6 ? "MLD" : "IGMP");
 			goto free;
+		}
 		if (amt_send_membership_update(amt, skb,  v6))
 			goto free;
-		goto unlock;
+		/* Sent: the tunnel consumed the skb.  Not a drop. */
+		return NETDEV_TX_OK;
 	} else if (amt->mode == AMT_MODE_RELAY) {
 		if (!data)
 			goto free;
@@ -1400,8 +1409,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 free:
 	dev_kfree_skb(skb);
-unlock:
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
@@ -2777,7 +2785,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -2787,7 +2795,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -2833,7 +2841,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 out:
 	rcu_read_unlock();
-- 
2.43.0

