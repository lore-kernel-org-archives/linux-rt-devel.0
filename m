Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883021;
	b=gSXZ252HY0JLmDSAR4WHoD+7+homzPIPD820nBpc0CdEyAWkbfXzy0oFjJN10+Mkp9s1
	 vQSy4sGyNHMLPw92S7OIfCD17ZFckOep9oTSKD80rWHXS9Ncu86AMPEu++ekUfvwa7Lf0
	 eRPXzHIk6abUq5wqd6zKvHWV67yBVOv367xpfHNbTeYj/hr82ISbm3292E8oCL2NhxIM6
	 d2l2/wDZGKkWzBCXI2br/ek0DWUGK7YPPBWDJT58nzyLdeyVf4woZBX79EWN+8XJXobH3
	 4bKwczWX7zTdQu/mLNhpNFx0Z45ENIaV/FvJQ/E/v8fJDN8dJlM75FFFtAz/S5WNpnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EMyF93eU2YKIrSl7+R9jg9v5qd941Zg8klEalBJ3ZmA=;
	b=mynZt6jgHlfEWWTTk99+B1qBFo8XcKydm/2/TH+1+6LInAYUPbqPccsmOTpGKIgyRB38
	 xQ68LULPrus5W+08AfFNGOsN0i9C+szIpvYMESrwsv40JusMOUNVgKZXSYGfQmF98CkgJ
	 dYcTuX8+Y+OqUNjEJFPpCeRjn2/4+oEwSL/phRmuPbNSgfwDAWGCoyzYpN8o/uW0ry9C8
	 fLtjH6JeMPS34A32Fn8Qa5TUzfXihY4NvHPimvb8GS0peoAcB1oGHfjpcrFcCzdi85l/r
	 4YTk5Zb7aoqeoNjKZL6Dxtlso3b8aFa+rSnzQ+cjB51gcMLgEyAMYpyzIrpupbC5wcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=UpcH6R7k;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A05606D820
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 12:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85A05606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=UpcH6R7k
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36a0f27c9f4so3425948eec.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 04:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1793883020; x=1794487820; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EMyF93eU2YKIrSl7+R9jg9v5qd941Zg8klEalBJ3ZmA=;
        b=UpcH6R7kL9J81CRkTSCYi+chiD84Rt8uqsDbw7Q2HHmRGm8oazXhpolg/ERqtlUPYN
         8ZXz1eUBWVBV2yN+XmEnRde720RjsXJ8dR3A/pc0IS/JJRWLX2oaY3JoStl1VE0zt7vL
         LTmmD+GKekrgqqUOfYgU3Rv/sZinks5PlHqRLCosFhM+gox05cML3nwqqV9ALH2tWHF+
         yKDqp+PIazc8YDSEcnnw4dFLzpQRQWNOV43PAvlPu1NszGdKuOtvm1iG6oO0GZvBxDk/
         RLO7IpDyr2R0XtZz8XRZkTqg6NLPUzyPDwa+HpYsll4HY+GCxPCUbD3zNJcrL4cD6Wsr
         +d6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883020; x=1794487820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EMyF93eU2YKIrSl7+R9jg9v5qd941Zg8klEalBJ3ZmA=;
        b=iz9YOiUdDREbJoWQENI7QUODLA/CLp/roqZjKp0UOEK7fvFwULVWg7hQwrDNTxp2E4
         r8I/Cqsl/PSWdQgNtsa2XPyFzOcX+TshTaOhhtPfhQBxZfhetmt1/QRXCW40wClibxud
         m0GAuD5aaPiamLxrusRsrbUKyqf5fXyDwz+pm20a3DwVRDSCE0rWODD4rJMI1Y//rMmX
         rksDIiDxwm6VPL4UVzpEJCgAJH+/8kw+oB69Re2mlDoalGZfmK8n1e41XXs08rY1LpMh
         /wfNlokMSBQvc/WU9MbFkNahe4psYiU3Mk8utqAAprJxN+u1ffW4XDlC6uOcXnvHxFYP
         ykFg==
X-Forwarded-Encrypted: i=1; AKwUvBz6UJP+fcwQG1Lc3LuK+y9dhuHsDM2qXvzGzilZI/101LTDfZgO2b7QWzd8DkCTBbIIcL7T5fan7FguSKPBUA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8TtmX74MQSfTfOOdOXxwMF9dGFGhV/T11N0tjIVw8ITplLM6N+
	Rqu7qKpHzDmoe35DUfsbGrATK8SMSl1xcELSMqbbI+91J28HViDWYva6Kyxvl0+dVQ8=
X-Gm-Gg: AYBFou06eSmBeTKYA2MIShBrau0yV/S5TFuaNN0tAoa8M2XS8tR+RgVWRnTgy/0SvuJ
	SQM8PSaov4mIl+w0u0FxQCx8Q/k7+4obp86zsFKADlO9qpjoqIssckPjv3lu5DZQua22QVJ0CfT
	D0sMl11J3B0BndQ9xLfPxMw+kWHgu8GIMaPOSovdUQUaSee12QAKnqQDZvZaykT3+7+Okzj26+A
	2cjIU/+CeM/Q8KpilRhRm8eJh1yqqDwqvm04533RNQeh0FWYMWyyMplRkq2wERoOMtblsFSmoK5
	tu5jeBWiTrc4tv6BcduNpxoV0zoJAa/8yAfve0v88/081F7V+hFVIUeiRPPA+HVSMOzzcHXG+jz
	TkirKodmp65X2XQi+o6WKbfxxsWVp6gaLC9b5VqY5+KO6q593IJW/pogI0RSX6tPgeewSMLrzkp
	N7ky/frzXnwouZuw7J9t1acnMnDvYPQ6gHk7rpUkUljgJ9qDs+7GvbxXwEhwZKPmdMpVDL7vE/q
	49TmGq8CqPNl8lx1OuWtbFi1/QJz1pVTzLlN5q4U4g7PlSZsJMDFkRtF2qlwX9loTJm+zMAWTFu
	GTZUUPUdgQpVsvwkBntsL5vi04ybVqnIoS4G1uDR/LCqmDn0Kq4nBdIXiMZ3ebEReUFNU4Y=
X-Received: by 2002:a05:693c:69cf:b0:369:daea:812a with SMTP id 5a478bee46e88-36a423fae73mr25902658eec.30.1793883019358;
        Thu, 05 Nov 2026 04:50:19 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm22527257eec.27.2026.11.05.04.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:50:18 -0800 (PST)
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
Subject: [PATCH net v5 4/5] amt: make pre-query report drops visible
Date: Thu,  5 Nov 2026 12:50:09 +0000
Message-ID: <20261105125010.1107546-5-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105125010.1107546-1-omar@blockcast.net>
References: <20261105125010.1107546-1-omar@blockcast.net>
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
also counted as a drop.  Return NETDEV_TX_OK directly once the report has
been sent, so tx_dropped counts only reports that were discarded.

The device is LLTX, so amt_dev_xmit() can run on several CPUs at once;
use DEV_STATS_INC() for its tx_dropped and tx_errors updates so
concurrent increments are not lost.

Found by code inspection while debugging an IPv6-in-IPv6 forwarding
failure in a selftest for the AMT IPv6 outer transport. This drop can
leave one address family dark, so it was a suspect, but that was not
confirmed: the failure was later traced to the selftest, which sent a
single datagram without waiting for the relay's multicast routes to
converge. The drop has not been observed in production, and there is
no oops or trace. Review of v3 found the tx_dropped miscount and the
non-atomic counter updates.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 68f08f5f6..26a942c2a 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -701,7 +701,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -711,7 +711,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -756,7 +756,7 @@ static void amt_send_discovery(struct amt_dev *amt)
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 	amt_update_gw_status(amt, AMT_STATUS_SENT_DISCOVERY, true);
 out:
@@ -792,7 +792,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -802,7 +802,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -849,7 +849,7 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 out:
 	rcu_read_unlock();
@@ -871,7 +871,7 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 
 	skb_pull(skb, sizeof(struct ethhdr));
 	if (amt_send_membership_query(amt, skb, tunnel, false)) {
-		amt->dev->stats.tx_dropped++;
+		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
@@ -915,7 +915,7 @@ static struct sk_buff *amt_build_mld_gq(struct amt_dev *amt)
 
 	if (ipv6_dev_get_saddr(amt->net, amt->dev, &ip6h->daddr, 0,
 			       &ip6h->saddr)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		kfree_skb(skb);
 		return NULL;
 	}
@@ -959,7 +959,7 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 
 	skb_pull(skb, sizeof(struct ethhdr));
 	if (amt_send_membership_query(amt, skb, tunnel, true)) {
-		amt->dev->stats.tx_dropped++;
+		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
@@ -1319,7 +1319,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		group.ip6 = ipv6_hdr(skb)->daddr;
 #endif
 	} else {
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 		goto free;
 	}
 
@@ -1332,12 +1332,21 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
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
@@ -1366,8 +1375,7 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	return NETDEV_TX_OK;
 free:
 	dev_kfree_skb(skb);
-unlock:
-	dev->stats.tx_dropped++;
+	DEV_STATS_INC(dev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
@@ -2730,7 +2738,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 				   IPPROTO_UDP, 0,
 				   amt->stream_dev->ifindex);
 	if (IS_ERR(rt)) {
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -2740,7 +2748,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	skb = netdev_alloc_skb_ip_align(amt->dev, len);
 	if (!skb) {
 		ip_rt_put(rt);
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 		goto out;
 	}
 
@@ -2786,7 +2794,7 @@ static void amt_send_advertisement(struct amt_dev *amt, __be32 nonce,
 	ip_send_check(iph);
 	err = ip_local_out(amt->net, sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		amt->dev->stats.tx_errors++;
+		DEV_STATS_INC(amt->dev, tx_errors);
 
 out:
 	rcu_read_unlock();
-- 
2.47.3

