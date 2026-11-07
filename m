Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794012589;
	b=H5Ui68Q/4btLtB5rBmogxuL3KHvR6pbhEebYTfDmUosTjoEzTLgHtEP25m1Fl4aVxiEs
	 OoqYYDWfCd4p7ubrmofhw5Ey9yWUAoNyzo0O56EONwvfuXOixKRgJI1T1BkkbRGqo9/Dg
	 9KyLir9JvsyhC7BWmQlsrEs3NWMXQnf4A4Jex3sbFV87U3Zdf2tpuFdyLT0kfYm3RZNFx
	 bYrapSdQY8nfzhVbghXsUrVRBj1vaILmNxwII1I6AYrpatGeIoR0xITV9vZBZwViEZbbP
	 RMMttjh+QeTYAtcCVCMAVBchw2ChK3B/c2llwHPwfgUIXT50pUMQOFI8k8ugiQRiGDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=qU6qsrqQpVZ3NoUQuR/wRikyWPdKsBxhhM5wA6FCjv4=;
	b=x0REDVE1eP6t+4BYAIbg+H+ZDelIRQ9hFsdOdZcX5ed6wNoixZdg5E/l42Ul8C3Fhlwl
	 JHdW0E12QB5OHehTlU/0GpPZJPIgTLC3L2zur4UKbUByx3u1dGKWQFdplXkPTfiCMWwfF
	 AdylzjeZzRtoscg6OOKsT01riThXfwykjdvsA3mWKGx2jXaOCjVKdKu5FHBaKXQUswmaO
	 v4tIKDppUIn48p4/H8diB49fwipTuSFBj7oivIU2xSqYHGUoPHVgbgScks+d5Yxm/LS78
	 UO8yoRiEjoyX4kR5QyCXmJnYVwPW4cHMGIwVGb57FpDsQ86UnlV8vEa00/rMjV0zWqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=sObMCSx3;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663A560733DC
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 00:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 663A560733DC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=sObMCSx3
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15ea896ddc8so2091662c88.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Nov 2026 16:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794012588; x=1794617388; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qU6qsrqQpVZ3NoUQuR/wRikyWPdKsBxhhM5wA6FCjv4=;
        b=sObMCSx3DrmIvX5H8shdwE4lq/Q2W/S7xqCfRywQLfuWaTJJSbhBZedr6MKGTC1BDW
         hKYVvWruWqYEAz1s8HQs+2lf6xMiq0OYstdYoapdpZse4kQEp0xjhM/3wLnQ3d2amDVF
         bSalGmp8cgS/rOJ9wSIS01ka/YJvAGfu3mIlUKUGAstRumVvQCWdR8PJIlcne0GcrFk/
         267z+06BuiY+wwNhFCvvT3A5yg9EluCeiQhvgEo3xvRF5R1xMlZqWHTmcIx6hLTs1oWX
         7kaYU1JEvSAXrpROExhPfuCT2Og4XFXgIUJtUlwiTmK3GqmxRegyNM4Qs/9WEdQ1lOAQ
         b1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012588; x=1794617388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qU6qsrqQpVZ3NoUQuR/wRikyWPdKsBxhhM5wA6FCjv4=;
        b=azbIDgzhxnt4vfSXgJp8tS7yjP2pYb5Jin8BzBPJ+2Wq/smwd71g9Vzfps1x459fCK
         4O706UPmuv22ZzAAdhjSbzEIAs0LrZ0fXh9J4ZCQ552xAlFhZUAQBx8vaQ6AgZ7nDqkR
         YW08OIMvnQFaHsCc1OWeqviO5n0udQhJlzC2J6Msmr/xPL/x4ThtPvw3BIGS1WaCkoVp
         WedceLhOwVr41yDZoxSr4w08GEWFFE6ZeANqrAm/6LR8cXYgtt1okuA88LtpF1vwCiQG
         s5JKpa/o3/sPNZk/NNqxVRTX3XZR0gJhLGgb+JfUy0UttvxAGsulq64QGRCK06Cwlsdj
         SbVw==
X-Forwarded-Encrypted: i=1; AKwUvBwnoXbXkLWvCHOv8/BZZFwIcQo8o54TKweaUFiaJGkxrb+qAwNbE7T+AbC5AVigWmwSnoLC0Qe4Me3sd/1ZWA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8SiBrGEoyAs4OFxN5Lj3h4E0MMEIaVOOH7jMHXDrERXY0pJZLx
	iDDig7DCJbk2TWZHDQ1RnUKRgUXE1naaY9ZUF+KDt9YiSibhSPtlJ5hsB7HkGYFiLmQ=
X-Gm-Gg: AYBFou0G4vriWGDsQGjMiLq39bY5Ho7C6VYhl//EN7jxX63yFk2bJSijGuVEHQkbvkC
	UTQweC+Sg32IuWhgYPZE8bhaECIuHU3xZhWjGo0tqti3kgG+U54Otgv2IzEs1sRsJuOMZwA8pz4
	6V9RjuAl442PKynxSyShWNeLO4cdqtlFU4C4ihjnHUYPodUML5PzSCD7n43Yna32sBj7r2gdCuj
	GwJPauqhBOUWc8ZnJvrBP6BdnRP5zzfiP9o666QAAIOYm6whvuyIE7cYYieQDpap+1Jk1+zMoNe
	RSIFu0zsQRkwcwRUYwUIorzEVt9phU+VL1HT5j0+RMVop8IwQSM78aqgMkfs4vmruyojH+i3lsu
	q+nWta/kXPDy1lyO/kEuZYIOm6COXua88TfSOZ1CfcSFTy3h7CxE49t7HNSYclUAqfzqzuWlWRu
	lLWemMLzo2RdKaEu6j1F9ancCxBBqO4IG1Tt6aJMnNE2LV96iqDCxceM1KSydy03xbvNdjHSgQJ
	ZOotZ1ww6yS29c0U0lCoyh/3wAX4kW5pIEMTW2L0vv+gd+vom87wNRvU2OKwbxk8EUrID7APeQc
	fl4zwRh0BD1TOTC9Wwv9dUtM/I0U4h8xBhXxzltWqE52dECiRYnUPVAFSCOykx3Mds+IMGo=
X-Received: by 2002:a05:693c:40d6:b0:368:4acb:f8a with SMTP id 5a478bee46e88-36f75b2c11fmr5999546eec.17.1794012588456;
        Fri, 06 Nov 2026 16:49:48 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a718sm11021294eec.4.2026.11.06.16.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:49:47 -0800 (PST)
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
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v6 5/6] amt: make pre-query report drops visible
Date: Sat,  7 Nov 2026 00:49:34 +0000
Message-ID: <20261107004935.2627329-6-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107004935.2627329-1-omar@blockcast.net>
References: <20261107004935.2627329-1-omar@blockcast.net>
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
index 6d5d43b48..e430f38c4 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -707,7 +707,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -717,7 +717,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -762,7 +762,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 	amt_update_gw_status(amt, AMT_STATUS_SENT_DISCOVERY, true);
 out:
@@ -798,7 +798,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -808,7 +808,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -855,7 +855,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 out:
 	rcu_read_unlock();
@@ -877,7 +877,7 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 
 	skb_pull(skb, sizeof(struct ethhdr));
 	if (amt_send_membership_query(amt, skb, tunnel, false)) {
-		amt->dev->stats.tx_dropped++;
+		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
@@ -921,7 +921,7 @@ static struct sk_buff *amt_build_mld_gq(struct amt_dev *amt)
 
 	if (ipv6_dev_get_saddr(amt->net, amt->dev, &ip6h->daddr, 0,
 			       &ip6h->saddr)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		kfree_skb(skb);
 		return NULL;
 	}
@@ -965,7 +965,7 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 
 	skb_pull(skb, sizeof(struct ethhdr));
 	if (amt_send_membership_query(amt, skb, tunnel, true)) {
-		amt->dev->stats.tx_dropped++;
+		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
@@ -1325,7 +1325,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		group.ip6 = ipv6_hdr(skb)->daddr;
 #endif
 	} else {
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 		goto free;
 	}
 
@@ -1338,12 +1338,21 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -1372,8 +1381,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 free:
 	dev_kfree_skb(skb);
-unlock:
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
@@ -2749,7 +2757,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -2759,7 +2767,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -2805,7 +2813,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 out:
 	rcu_read_unlock();
-- 
2.43.0

