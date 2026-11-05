Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883023;
	b=4JT8s0dK1iNw4lZp0R4OVy67eoXWfoQxCBgc2nCol9vJAJ9p5K3eeq6OFDAYv5xO+O1f
	 QECPlknc14fA5lHeTjS3JjEIV8S0GyxvORtFKSwEoZYZfIhZQvvon3uj9H4j/a6to4yXF
	 7c5e00zZDPaYMsze56e94f0/u/YIeqJ4f27N/S5qUiuu7L8Kf9Vw6oJ67Q4OIdZyIFq9a
	 Tc6k48mrvCwn4O+rIr29NVcE2TfCHOfCJN4wPyPQ08G0tJQij6C0qE4Yjl4BsLh80QKHw
	 5maaObuZg9RAegR8qH798tMmCSPMLci/e3rjs09ltAne5qC+fJCyAHV8JL0XduUjoZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883023;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K6069raVZjKXnwnyV6hyjnEe/b14DOzc3pXe+PF6me4=;
	b=XJgGK3VsrI0ZD9dXNPZnYfIabs14ICHM+HCN2XRfk+MUIYNoaxTgC1vfGV3DZak0L93E
	 VpJ2NKI9Y0LIvODClS7AkYuu+83vTkoHodVmEQASUDpJAfPHaolpe319JPz6LKIWFtFpS
	 xYauH6MTIBPf422F3DiRf1tgebry7zOoEJlFP2+EjQjXH6f7PUlTLvm0NhNlaPzw5LwmD
	 qBGMbKoI8KjqTekB/vZObffMVzgaAf4OALRfLZ4yUzYIW38h4+Yeiu5xCvGoHOsPMAC3t
	 5m8V6NyZvYgO16pFENLadGgvIW7nxxNXmGDLMctvjwWtXDLvnL7VbFOIG3v1+/RjLNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=lhM7+zQm;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA77F606D83B
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Nov 2026 12:50:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA77F606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=lhM7+zQm
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36cad25b8b0so2673361eec.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 05 Nov 2026 04:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1793883022; x=1794487822; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K6069raVZjKXnwnyV6hyjnEe/b14DOzc3pXe+PF6me4=;
        b=lhM7+zQmRsIfmX4W+M7GMAMC+/fEO4uid5tzZfQpJ0gaDcJQeLx60YSqth4tIGgH+C
         G9IwpoR+2CaNshFmDgRCDgqGZkJqMHPmaIaNPOYdWSP2wzN9NMhCoS4SVbmwnoQhAjsU
         oLkFt4hvvbOHTak3w+QQ4TuR7W/qf9tpMR+oaM42+QNPEIaN/Hdscgr+t0LIKdh5Q7g/
         Z7+/R6vuiZMz58+/zuvTOlpxJhcDnDG5G6S8NAblC7EujdgSHDCZ1b6s1HUVYhHVuwq5
         fu7PBN7Rrz/Dv+7ikM9RaecrC/DEmVr78wlKaXRNMmZIl0gUEmcBjBv0Pw0el3UU5RYU
         Ew3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793883022; x=1794487822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K6069raVZjKXnwnyV6hyjnEe/b14DOzc3pXe+PF6me4=;
        b=oddFEySQhJSGGMirw42QdTCYM+sRwwsrXbdA0//QmvVjF+NMuJVHBjAfCfxcrutbVw
         GVQiiHvo9gL0XP6b+Fp7qZ4XC4UZGZaNGkweqfB0SX+z/XyO2RTHy/deW+8qBVCtD/xA
         SPKv+vHKnBMSrpZtjaMuel8CO82dO0DhTlAWhE+l66RKjtnI78X8PHDI0XiOeklF18B9
         NMd+qfxOGko0LTaNgbvF3CktegAzLcxgoH54+Majlx8COU42RmmyEYydZOXMzQVyyI+4
         UFYBssEW3Gx/6ZKtiO3ODAS+0MbiAlFrwPliLATOxednVI2dZU+YIzmPx8EsnbT6vP7p
         ehKw==
X-Forwarded-Encrypted: i=1; AKwUvBywg5XiCEydmozBwbHQxZXtWFyy4I2NSv1H0JV0m1SGXiGOEgLLDUeBSw6fEPFCjc8W/GnNUI9FNdRpoOiLeQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+AeHatwyST1ellYnqHih7VZn6wbSx2ubILkFP65yJ+8ChyQ68/
	N4kCXwiR57nyWnOTcoF0kMK7zOZOZaPLF965rnjoMTeoK0qAeAEpUruTxIILH0/KdVk=
X-Gm-Gg: AYBFou12lXsmws1DWIz7Yj5Q0TDGZLwb29FqAJnhxAj1VjXSa5fqa053HGFKYRRO2qJ
	339gWVhWH/EHWXELqSN7SSvaAPAxpWKnGJnvBg+TTudrzDEFtMJQhLxXlQyL2XfZJgjvs6My/kV
	JrTNxol+Z6O9Za03Bz9ox2hZ0FFviXBBfNcO++Dm7exbYpLncUc/w4uvpZIFTJPrv4dsrKrHlw0
	xeaf0BUtv0krxTTgz7sg2CiSnJGcigbC7W+XV+szHVYhP7MMW6jqBEt+CTiGje4Nz1t6/d6Jxzt
	FENqQYIxcLMz48nmkex+PMa/JzB9YmaAIpcpyxhM4NbE+dlh4qg98F74iEZJ7ltAcvk4u9KJxIn
	dWsYZrT+W9QoZPtTlsIdZ943UQldzKM4wWaq7+MrRbcaX+6gNKQ6EaTiTq1Y1Zyr9bO8cq4QAfN
	B5h8oLMxgjbVVJEwRV6r3n73Lgn4S3tvEaTtAo2LDwe6VNL6tV1Aa6zyRdo3nKPBvdaibtHHHA6
	X70v9V3X9Actc3/mMSnyNbWE5zIkdFv7SGMsQ5nMbhHnD6+MzJ3cQXwgypKPnpxAtUlWZcl6FqO
	G822evmw8N6m76jc9oPrq/4HwGElStC43KvDl7vHZ1Ccf7gZRxnVCdssHrt1jWqUJk67c68=
X-Received: by 2002:a05:693c:88c4:10b0:36a:3186:b712 with SMTP id 5a478bee46e88-36a423d1c80mr28171002eec.20.1793883021595;
        Thu, 05 Nov 2026 04:50:21 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm22527257eec.27.2026.11.05.04.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:50:20 -0800 (PST)
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
Subject: [PATCH net v5 5/5] amt: harden relay authentication and teardown
Date: Thu,  5 Nov 2026 12:50:10 +0000
Message-ID: <20261105125010.1107546-6-omar@blockcast.net>
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

An AMT Request has an unauthenticated, spoofable source address. Allocating
tunnel state from that path allowed spoofed Requests to consume tunnel
slots or overwrite the nonce and MAC of an established gateway.

Keep Requests stateless by deriving the Query MAC from the source address,
source port, nonce, and current secret. Authenticate the Membership Update
before decapsulation or allocation, key verified state by the address/port
endpoint, enforce global and per-source limits, and silently reject an
endpoint that cannot be admitted. Retain four secret generations so a
gateway can renew its MAC across rotations.

Every Membership Update, forged ones included, reads the secret
generations to check its MAC. Their writers hold amt->lock and update
them inside a seqcount, amt->key_seq. The Update path copies them in a
key_seq read loop, so it takes amt->lock only on PREEMPT_RT, to wait
for a writer.

Keying by address and port lets one address hold several tunnels;
before this patch it could hold at most one. AMT_MAX_TUNNELS_PER_SRC
(16) bounds that, so one address can fill at most an eighth of the
default 128-slot table while gateways behind NAT still get several
tunnels. A configurable limit needs new uAPI, so it is left for
net-next.

Found by code inspection against RFC 7450; not triggered at runtime.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 309 +++++++++++++++++++++++++++++++++-------------
 include/net/amt.h |  23 ++--
 2 files changed, 238 insertions(+), 94 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 26a942c2a..312b36b54 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -857,11 +857,16 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 
 static bool amt_send_membership_query(struct amt_dev *amt,
 				      struct sk_buff *skb,
-				      struct amt_tunnel_list *tunnel,
+				      __be32 daddr, __be16 dport,
+				      __be32 nonce, u64 mac,
 				      bool v6);
 
-static void amt_send_igmp_gq(struct amt_dev *amt,
-			     struct amt_tunnel_list *tunnel)
+/* The destination is passed by value rather than as a tunnel: the requesting
+ * source is not authenticated yet and no tunnel state exists for it - see
+ * amt_request_handler().
+ */
+static void amt_send_igmp_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			     __be32 nonce, u64 mac)
 {
 	struct sk_buff *skb;
 
@@ -870,7 +875,8 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 		return;
 
 	skb_pull(skb, sizeof(struct ethhdr));
-	if (amt_send_membership_query(amt, skb, tunnel, false)) {
+	if (amt_send_membership_query(amt, skb, daddr, dport, nonce, mac,
+				      false)) {
 		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
@@ -949,7 +955,8 @@ static struct sk_buff *amt_build_mld_gq(struct amt_dev *amt)
 	return skb;
 }
 
-static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
+static void amt_send_mld_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			    __be32 nonce, u64 mac)
 {
 	struct sk_buff *skb;
 
@@ -958,13 +965,15 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
 		return;
 
 	skb_pull(skb, sizeof(struct ethhdr));
-	if (amt_send_membership_query(amt, skb, tunnel, true)) {
+	if (amt_send_membership_query(amt, skb, daddr, dport, nonce, mac,
+				      true)) {
 		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
 }
 #else
-static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
+static void amt_send_mld_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			    __be32 nonce, u64 mac)
 {
 }
 #endif
@@ -998,7 +1007,16 @@ static void amt_secret_work(struct work_struct *work)
 					   secret_wq);
 
 	spin_lock_bh(&amt->lock);
-	get_random_bytes(&amt->key, sizeof(siphash_key_t));
+	write_seqcount_begin(&amt->key_seq);
+	/* Keep three previous generations for a 180-240s MAC lifetime.
+	 * Its 180s floor exceeds the advertised QQIC (amt->qi, 125s),
+	 * allowing the gateway to renew its MAC with a periodic Request.
+	 */
+	amt->key[3] = amt->key[2];
+	amt->key[2] = amt->key[1];
+	amt->key[1] = amt->key[0];
+	get_random_bytes(&amt->key[0], sizeof(siphash_key_t));
+	write_seqcount_end(&amt->key_seq);
 	spin_unlock_bh(&amt->lock);
 	mod_delayed_work(amt_wq, &amt->secret_wq,
 			 msecs_to_jiffies(AMT_SECRET_TIMEOUT));
@@ -1198,9 +1216,16 @@ static void amt_send_multicast_data(struct amt_dev *amt,
 			    0);
 }
 
+/* Send a Membership Query to a source that has not been authenticated yet.
+ *
+ * No per-source state exists at this point and none is created: the nonce and
+ * the keyed MAC are carried in the Query and recomputed from the Membership
+ * Update when it comes back, so everything this needs is passed by value.
+ */
 static bool amt_send_membership_query(struct amt_dev *amt,
 				      struct sk_buff *skb,
-				      struct amt_tunnel_list *tunnel,
+				      __be32 daddr, __be16 dport,
+				      __be32 nonce, u64 mac,
 				      bool v6)
 {
 	struct amt_header_membership_query *amtmq;
@@ -1221,13 +1246,13 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 	skb_reset_inner_headers(skb);
 	memset(&fl4, 0, sizeof(struct flowi4));
 	fl4.flowi4_oif         = amt->stream_dev->ifindex;
-	fl4.daddr              = tunnel->ip4;
+	fl4.daddr              = daddr;
 	fl4.saddr              = amt->local_ip;
 	fl4.flowi4_dscp        = inet_dsfield_to_dscp(AMT_TOS);
 	fl4.flowi4_proto       = IPPROTO_UDP;
 	rt = ip_route_output_key(amt->net, &fl4);
 	if (IS_ERR(rt)) {
-		netdev_dbg(amt->dev, "no route to %pI4\n", &tunnel->ip4);
+		netdev_dbg(amt->dev, "no route to %pI4\n", &daddr);
 		return true;
 	}
 
@@ -1237,8 +1262,8 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 	amtmq->reserved = 0;
 	amtmq->l	= 0;
 	amtmq->g	= 0;
-	amtmq->nonce	= tunnel->nonce;
-	amtmq->response_mac = tunnel->mac;
+	amtmq->nonce	= nonce;
+	amtmq->response_mac = mac;
 
 	if (!v6)
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
@@ -1251,11 +1276,10 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 			    ip4_dst_hoplimit(&rt->dst),
 			    0,
 			    amt->relay_port,
-			    tunnel->source_port,
+			    dport,
 			    false,
 			    false,
 			    0);
-	amt_update_relay_status(tunnel, AMT_STATUS_SENT_QUERY, true);
 	return false;
 }
 
@@ -2586,16 +2610,107 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	return false;
 }
 
+/* The tunnel of the gateway endpoint @saddr:@sport, or NULL. */
+static struct amt_tunnel_list *amt_tunnel_lookup(struct amt_dev *amt,
+						 __be32 saddr, __be16 sport)
+{
+	struct amt_tunnel_list *tunnel;
+
+	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
+		if (tunnel->ip4 == saddr && tunnel->source_port == sport)
+			return tunnel;
+	return NULL;
+}
+
+/* Look up the tunnel for a source whose Membership Update has already been
+ * authenticated, creating it on first contact.
+ *
+ * This is now the only place tunnel state is allocated, so amt->max_tunnels
+ * bounds the number of *verified* gateways rather than the number of
+ * unverified Requests anyone can send.  A fixed per-source cap additionally
+ * stops one verified source address from monopolising the table.
+ */
+static struct amt_tunnel_list *amt_tunnel_get_or_create(struct amt_dev *amt,
+							__be32 saddr,
+							__be16 sport)
+{
+	struct amt_tunnel_list *tunnel;
+	int per_src = 0;
+	int i;
+
+	tunnel = amt_tunnel_lookup(amt, saddr, sport);
+	if (tunnel)
+		return tunnel;
+
+	spin_lock_bh(&amt->lock);
+
+	/* Re-check under the lock in case a concurrent Update won the race, and
+	 * count how many tunnels this source already holds on the same walk.
+	 */
+	list_for_each_entry(tunnel, &amt->tunnel_list, list) {
+		if (tunnel->ip4 != saddr)
+			continue;
+		if (tunnel->source_port == sport) {
+			spin_unlock_bh(&amt->lock);
+			return tunnel;
+		}
+		per_src++;
+	}
+
+	if (amt->nr_tunnels >= amt->max_tunnels ||
+	    per_src >= AMT_MAX_TUNNELS_PER_SRC) {
+		spin_unlock_bh(&amt->lock);
+		return NULL;
+	}
+
+	if (!netif_running(amt->dev)) {
+		spin_unlock_bh(&amt->lock);
+		return NULL;
+	}
+
+	tunnel = kzalloc(sizeof(*tunnel) +
+			 (sizeof(struct hlist_head) * amt->hash_buckets),
+			 GFP_ATOMIC);
+	if (!tunnel) {
+		spin_unlock_bh(&amt->lock);
+		return NULL;
+	}
+
+	tunnel->source_port = sport;
+	tunnel->ip4 = saddr;
+	tunnel->amt = amt;
+	spin_lock_init(&tunnel->lock);
+	for (i = 0; i < amt->hash_buckets; i++)
+		INIT_HLIST_HEAD(&tunnel->groups[i]);
+
+	tunnel->last_seen = jiffies;
+	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
+	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_UPDATE, false);
+
+	/* Publish only once the entry is fully initialised. */
+	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
+	amt->nr_tunnels++;
+	mod_delayed_work(amt_wq, &tunnel->gc_wq,
+			 msecs_to_jiffies(amt_gmi(amt)) * 3);
+	spin_unlock_bh(&amt->lock);
+
+	return tunnel;
+}
+
 static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 {
 	struct amt_header_membership_update *amtmu;
 	struct amt_tunnel_list *tunnel;
 	struct ethhdr *eth;
 	struct iphdr *iph;
-	int len, hdr_size;
+	siphash_key_t key[4];
+	int len, hdr_size, i;
+	unsigned int seq;
 	u64 response_mac;
+	bool verified = false;
 	__be32 saddr;
 	__be32 nonce;
+	__be16 sport;
 
 	saddr = ip_hdr(skb)->saddr;
 
@@ -2609,34 +2724,52 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 
 	nonce = amtmu->nonce;
 	response_mac = amtmu->response_mac;
+	/* Snapshot the tunnel endpoint port before the encap is stripped. */
+	sport = udp_hdr(skb)->source;
 
-	if (iptunnel_pull_header(skb, hdr_size, skb->protocol, false))
+	/* Recompute the MAC handed out in the Membership Query.  Four live
+	 * secrets cover 180-240s, exceeding the advertised QQIC (amt->qi,
+	 * 125s), so a periodic Request can renew the MAC before it expires.
+	 * Authenticate before decapsulation or allocating tunnel state.
+	 */
+	do {
+		seq = read_seqcount_begin(&amt->key_seq);
+		for (i = 0; i < ARRAY_SIZE(key); i++)
+			key[i] = amt->key[i];
+	} while (read_seqcount_retry(&amt->key_seq, seq));
+
+	for (i = 0; i < ARRAY_SIZE(key); i++) {
+		u64 mac = siphash_3u32((__force u32)saddr,
+				       (__force u32)sport,
+				       (__force u32)nonce,
+				       &key[i]) >> 16;
+
+		if (response_mac == mac) {
+			verified = true;
+			break;
+		}
+	}
+
+	if (!verified) {
+		netdev_dbg(amt->dev, "Invalid MAC\n");
 		return true;
+	}
 
-	skb_reset_network_header(skb);
+	tunnel = amt_tunnel_get_or_create(amt, saddr, sport);
+	if (!tunnel)
+		return true;
 
-	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
-		if (tunnel->ip4 == saddr) {
-			if ((nonce == tunnel->nonce &&
-			     response_mac == tunnel->mac)) {
-				/* Refresh liveness only.  gc_wq is
-				 * re-armed by amt_tunnel_expire() itself
-				 * from last_seen, never from here, so this
-				 * cannot re-queue the work of a tunnel
-				 * that is being freed.
-				 */
-				WRITE_ONCE(tunnel->last_seen, jiffies);
-				goto report;
-			} else {
-				netdev_dbg(amt->dev, "Invalid MAC\n");
-				return true;
-			}
-		}
-	}
+	/* Refresh liveness only.  gc_wq is re-armed by amt_tunnel_expire()
+	 * itself from last_seen, never from here, so this cannot re-queue the
+	 * work of a tunnel that is being freed.
+	 */
+	WRITE_ONCE(tunnel->last_seen, jiffies);
 
-	return true;
+	if (iptunnel_pull_header(skb, hdr_size, skb->protocol, false))
+		return true;
+
+	skb_reset_network_header(skb);
 
-report:
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
 
@@ -2821,15 +2954,29 @@ static bool amt_discovery_handler(struct amt_dev *amt, struct sk_buff *skb)
 	return false;
 }
 
+/* Handle an AMT Relay Membership Request.
+ *
+ * The source of a Request is unauthenticated: it is a bare UDP datagram with a
+ * trivially spoofable source address.  Allocating tunnel state here let an
+ * attacker fill the table from spoofed addresses, and let one spoofed packet
+ * overwrite the nonce/MAC of an established tunnel and cut that gateway off.
+ *
+ * Nothing needs to be remembered at this point.  Every input to the keyed MAC
+ * is carried in the packet or is device state, so the MAC is generated here,
+ * echoed back by the gateway in its Membership Update, and recomputed and
+ * verified there - see amt_update_handler().  Tunnel state is created only once
+ * that verification succeeds.
+ */
 static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 {
 	struct amt_header_request *amtrh;
 	struct amt_tunnel_list *tunnel;
-	unsigned long long key;
 	struct udphdr *udph;
 	struct iphdr *iph;
+	siphash_key_t key;
+	bool full, have = false;
+	int per_src = 0;
 	u64 mac;
-	int i;
 
 	if (!pskb_may_pull(skb, sizeof(*udph) + sizeof(*amtrh)))
 		return true;
@@ -2841,59 +2988,41 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 	if (amtrh->reserved1 || amtrh->reserved2 || amtrh->version)
 		return true;
 
-	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list)
-		if (tunnel->ip4 == iph->saddr)
-			goto send;
-
-	spin_lock_bh(&amt->lock);
-	if (amt->nr_tunnels >= amt->max_tunnels) {
-		spin_unlock_bh(&amt->lock);
-		icmp_ndo_send(skb, ICMP_DEST_UNREACH, ICMP_HOST_UNREACH, 0);
-		return true;
-	}
-
-	tunnel = kzalloc(sizeof(*tunnel) +
-			 (sizeof(struct hlist_head) * amt->hash_buckets),
-			 GFP_ATOMIC);
-	if (!tunnel) {
-		spin_unlock_bh(&amt->lock);
+	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
 		return true;
-	}
-
-	tunnel->source_port = udph->source;
-	tunnel->ip4 = iph->saddr;
-
-	memcpy(&key, &tunnel->key, sizeof(unsigned long long));
-	tunnel->amt = amt;
-	spin_lock_init(&tunnel->lock);
-	for (i = 0; i < amt->hash_buckets; i++)
-		INIT_HLIST_HEAD(&tunnel->groups[i]);
-
-	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
 
-	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
-	tunnel->key = amt->key;
-	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_REQUEST, true);
-	amt->nr_tunnels++;
-	mod_delayed_work(amt_wq, &tunnel->gc_wq,
-			 msecs_to_jiffies(amt_gmi(amt)));
+	/* Snapshot the secret and limits under the lock; keep the endpoint walk
+	 * out of the lock so spoofed Requests cannot serialize relay updates.
+	 */
+	spin_lock_bh(&amt->lock);
+	key = amt->key[0];
+	full = amt->nr_tunnels >= amt->max_tunnels;
 	spin_unlock_bh(&amt->lock);
 
-send:
-	tunnel->nonce = amtrh->nonce;
-	mac = siphash_3u32((__force u32)tunnel->ip4,
-			   (__force u32)tunnel->source_port,
-			   (__force u32)tunnel->nonce,
-			   &tunnel->key);
-	tunnel->mac = mac >> 16;
+	rcu_read_lock();
+	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
+		if (tunnel->ip4 != iph->saddr)
+			continue;
+		per_src++;
+		if (tunnel->source_port == udph->source)
+			have = true;
+	}
+	rcu_read_unlock();
 
-	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
+	/* Withhold the Query when a new endpoint cannot get a tunnel. */
+	if (!have && (full || per_src >= AMT_MAX_TUNNELS_PER_SRC))
 		return true;
 
+	mac = siphash_3u32((__force u32)iph->saddr,
+			   (__force u32)udph->source,
+			   (__force u32)amtrh->nonce,
+			   &key) >> 16;
 	if (!amtrh->p)
-		amt_send_igmp_gq(amt, tunnel);
+		amt_send_igmp_gq(amt, iph->saddr, udph->source, amtrh->nonce,
+				 mac);
 	else
-		amt_send_mld_gq(amt, tunnel);
+		amt_send_mld_gq(amt, iph->saddr, udph->source, amtrh->nonce,
+				mac);
 
 	return false;
 }
@@ -3161,6 +3290,16 @@ static int amt_dev_open(struct net_device *dev)
 	enable_delayed_work(&amt->discovery_wq);
 	enable_delayed_work(&amt->req_wq);
 
+	/* Seed the keys before amt_socket_create() enables the encap receive
+	 * path, so a Request or Update that arrives immediately is never
+	 * verified against an all-zero (predictable) secret.
+	 */
+	spin_lock_bh(&amt->lock);
+	write_seqcount_begin(&amt->key_seq);
+	get_random_bytes(&amt->key, sizeof(amt->key));
+	write_seqcount_end(&amt->key_seq);
+	spin_unlock_bh(&amt->lock);
+
 	err = amt_socket_create(amt);
 	if (err) {
 		disable_delayed_work(&amt->req_wq);
@@ -3171,7 +3310,6 @@ static int amt_dev_open(struct net_device *dev)
 	amt->req_cnt = 0;
 	WRITE_ONCE(amt->remote_ip, 0);
 	amt->nonce = 0;
-	get_random_bytes(&amt->key, sizeof(siphash_key_t));
 
 	amt->status = AMT_STATUS_INIT;
 	if (amt->mode == AMT_MODE_GATEWAY) {
@@ -3384,6 +3522,7 @@ static int amt_newlink(struct net_device *dev,
 		amt->max_tunnels = AMT_MAX_TUNNELS;
 
 	spin_lock_init(&amt->lock);
+	seqcount_spinlock_init(&amt->key_seq, &amt->lock);
 	amt->max_groups = AMT_MAX_GROUP;
 	amt->max_sources = AMT_MAX_SOURCE;
 	amt->hash_buckets = AMT_HSIZE;
diff --git a/include/net/amt.h b/include/net/amt.h
index 123725c88..abe528bec 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -242,20 +242,17 @@ struct amt_tunnel_list {
 	struct delayed_work	gc_wq;
 	/* Last time this tunnel was refreshed.  gc_wq
 	 * re-arms itself from this rather than being re-armed by the Update
-	 * path, so the Update path cannot re-queue the work of a tunnel that
-	 * amt_tunnel_expire() is freeing.
+	 * path, so the Update path cannot re-queue work for a tunnel that
+	 * amt_tunnel_expire() is freeing on the timeout path.
 	 */
 	unsigned long		last_seen;
 	/* Set under amt->lock and tunnel->lock by whichever freer reaches the
-	 * tunnel first; the other then leaves it alone, so it is freed once.
+	 * tunnel first;
+	 * the other then leaves it alone, so the tunnel is freed exactly once.
 	 */
 	bool			dead;
 	__be16			source_port;
 	__be32			ip4;
-	__be32			nonce;
-	siphash_key_t		key;
-	u64			mac:48,
-				reserved:16;
 	struct rcu_head		rcu;
 	struct hlist_head	groups[];
 };
@@ -341,8 +338,12 @@ struct amt_dev {
 	struct work_struct	event_wq;
 	/* AMT status */
 	enum amt_status		status;
-	/* Generated key */
-	siphash_key_t		key;
+	/* Current key and three previous generations keep MACs valid for
+	 * 180-240s, beyond the advertised QQIC (see amt_secret_work()).
+	 */
+	siphash_key_t		key[4];
+	/* For lockless readers of key; writers hold lock */
+	seqcount_spinlock_t	key_seq;
 	struct sock	  __rcu *sk;
 	u32			max_groups;
 	u32			max_sources;
@@ -399,6 +400,10 @@ struct amt_dev {
 #define AMT_SECRET_TIMEOUT	60000
 #define IANA_AMT_UDP_PORT	2268
 #define AMT_MAX_TUNNELS         128
+/* Fixed per-source cap stops one verified source address from monopolising
+ * the AMT_MAX_TUNNELS-slot table.
+ */
+#define AMT_MAX_TUNNELS_PER_SRC 16
 #define AMT_MAX_REQS		128
 #define AMT_GW_HLEN (sizeof(struct iphdr) + \
 		     sizeof(struct udphdr) + \
-- 
2.43.0

