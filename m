Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344755;
	b=TQAViGR+S9weTielvP5Mm0CM311QVN2ZR3N/XppzfpvHYUbiYjO2FdnZVxYqKYcXoc8E
	 5Y0YstqWEGhETBdkGnVAEsq8Vi2KAFwdAmIZ9rdVf0R156r4ccAw5gsDZql5eEdG/I8hY
	 mUfUjDfj8e5cP1k6u7V5K7h+QwEyrY/jYUh55xhy1Z67SBWwK82Sjm9AWSqg9Di2lmrHm
	 XyRbMhi6UvIYxBfKbhKvi71s8z/rILKXqmgJc/vadbhrM5x8pUQdniaRrcRcDF4zVyps+
	 BPgU3uxpyOGkjgiDBEovpHCFN+mxW1tWZo78deW6n2d0sOSkHWLdjf3n+rm5plRuGyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344755;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=K9In9Zcj7gt1OtN+lcji+Pbk1pTinQeT5pc+Z1I5NM4=;
	b=sOLZTHLnxVfI7DMQ+d3fP48x1UokKFsVJqmlBXw9VktOB7RqQRXteyKz74m3//VfwwpC
	 yCblhqueTLgPyh8OahYX45TId6T0l6RMgQbtxamKYhrADz+pJ783m5f61Z3WPlp/cWj2c
	 WQR0PYDXMrXIOIGs+/MGjUZnewU5TONeJND1f/6p5eUxvbp7TQr7iZGBZbDPZ8AnxkzcI
	 ZERq948CJMIlYY8PxWf+f3jbNheURESLEImCVn9M06KwQF23v0IECmLlOehTbUBM4Y7q1
	 8ITAyCOAniW8138+8afDG+r1bjaMMNWaONXrC5CWJE2YxoukiEq5s1RIRj2p3IN5adg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=Ev4NTde8;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C960A5BC4
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 21:05:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C7C960A5BC4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=Ev4NTde8
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-37071c0f42aso4373994eec.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 13:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344754; x=1794949554; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K9In9Zcj7gt1OtN+lcji+Pbk1pTinQeT5pc+Z1I5NM4=;
        b=Ev4NTde84LAPbA/iFND7TEKXPDrRPvvu9uxs0frv60pbIW/KcnlCt6XP0TJe0yRhUO
         lkoZX5glYmwduXs9CbRrVpB49Wiv9oewVOtZ5uaQnCtsOHcJh0ioczgkwl8Muao0Gg09
         lzc1Lcln3sExZZaPzgZGBtNkHoyGdnyIFzUVu9UabmNuP0OLs/DxqEqjtim9bw9Tq6Xc
         RR61QQ4x/41RU+NvCH6VR1dNLYKXHS+xR0SYKe22ySKEiTPWtudz5jpzZduOdANAVpgp
         vgNIp6qvOQnsITA53eTzu9q9KPAm/+x5DgJ32kobbnaslDRSHup/B22K93KkmuPhQ790
         g9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344754; x=1794949554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K9In9Zcj7gt1OtN+lcji+Pbk1pTinQeT5pc+Z1I5NM4=;
        b=vAAFL2ShTetpclcvmvqjGFRPzweNwPnbSM73mNIdmH8wG3kFobFBEUvdfJ7F2bV8JZ
         Vk3lkpUlO2SA2CikLw7d//Cf0uiXrtDcL14E7hKH463iOl8wWNJlYCb2a4n5uM9lvdPN
         D6nGhwt2KusS4agYg8upeuRk1FelIrv4yLZH/z6o1V1DGoiqWnI6TxSWTlLFoAVVUE7Q
         6i69XYJC73p04v7+g3fo9hLlMCPDiAUaBlBtJ3LYQgWi2/yCuSnNxgAy+aodhA9HlGyV
         PNWKFnkVsdssdf9hVUsDdNPJhvyIVu1RkWIKDBOgwceCxK1OpiEEaBR3cOKeL6dBYkPl
         qOCw==
X-Forwarded-Encrypted: i=1; AL+hErH0XNurQRAZ2XprAVmRjzO95/tF9AQ9YiGM2KmP/djrPCESVHm9FihfjyiTfa71JPgqkFc59vYuv6dM2ln8XQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Ly2DRMN6VnY74WmAg6yEZsm6sv+aHmbqAoQnJiXeWOXjyEtJ0
	ZEue5VOFBl5tX/S38SJoquARs+Qz20h7YAmrZcQNx4PK8lGDJFxh8wwrzFwRZT1EhJ4=
X-Gm-Gg: AYBFou3veAEu3V211sw4vtcsG2BWdSyCWtTgDRaga73wFR4hXWWBYq/+VBQjwDdhfdB
	EGHhOoLXGwDxbSYhKnTiSeZ2hL+EvKbUHAbkIm1Kawcn8/9vBVzD5SHCHApUeEz/L7CHyVRYuwC
	JXCVP4VBx9kt/GPwAchUsXy1aUu5p9bWRfaQo5xglZkDPMTShNMcpT/LqZQn4ONuBJd7VHTtYCd
	HnxJ0zCxh9UIuGFOm52MqpOxwY2AzENPd1/2YDNEplkvOhYmOe3Ltcxuf6KI6dy7rrhpctvbrUE
	U6N5OUL2v9GSBv9SIz3FuD3V8fSbzmzlm7IjjwpH1uJf2PPD2VOYVFWEarStN1oXNfne7pO3M2Z
	sMTZK7VujJ6NCirNoNmCsbdxsXoXp7zs19y9xqXrXaeqL3Zr5iCus2qbJY6F9vf8Gztv7ZQR40B
	uHa0jGvBrQ+2Nyw1Re75Ckiju25kpkMWVUj5FWlAs31FO2RR37wVL2JhL8pkSk19YCpcu3dre/p
	if90HAHU+sa0LuKiAI5Zo0h5AmX0yYJO7FFnIp89VMctEcrheaovS9oMDT/5XI7JET75ghxxT5a
	ZhB4hI7A2TBhi8KiXJJ78oOgtKIattzhlVS4+niXCgPVDqeL/MvqF2Y+1IPSmAmu7DH5uyI=
X-Received: by 2002:a05:7301:2892:b0:375:dc5b:43fa with SMTP id 5a478bee46e88-3768579fb7dmr585103eec.8.1794344753382;
        Tue, 10 Nov 2026 13:05:53 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm10464097eec.17.2026.11.10.13.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:05:52 -0800 (PST)
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
Subject: [PATCH net v7 6/6] amt: create relay tunnels only from authenticated Updates
Date: Tue, 10 Nov 2026 21:05:37 +0000
Message-ID: <20261110210538.217936-7-omar@blockcast.net>
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

An AMT Request has an unauthenticated, spoofable source address. Allocating
tunnel state from that path allowed spoofed Requests to consume tunnel
slots or overwrite the nonce and MAC of an established gateway.

Keep Requests stateless by deriving the Query MAC from the source
address, source port, nonce, and current secret, and retain four secret
generations so a gateway can renew its MAC across rotations.
Authenticate the Membership Update before decapsulation, and create or
refresh tunnel state only once ip_mc_check_igmp() or ipv6_mc_check_mld()
has accepted the encapsulated message. Key verified state by the
address/port endpoint, enforce global and per-source limits, and
silently reject an endpoint that cannot be admitted: withhold the Query
rather than send ICMP Host Unreachable to a source address nothing has
authenticated yet.

A MAC is now accepted only for a bounded time after the Query that
carried it. Before, a tunnel copied the secret when a Request created it
and never saw it rotate, so its MAC never expired. Now the secret
rotates every 60 seconds and four generations are kept, so a MAC is
accepted for 180 to 240 seconds. RFC 7450 section 5.2.3.5.4 has a
gateway start a query timer when it accepts a Query, with a duration it
SHOULD compute from the Query's QQIC (125 seconds here), and section
5.2.3.5.5 has it send a new Request when that timer expires, so a
gateway that times its next Request from QQIC renews its MAC inside the
window. The in-tree gateway re-Requests every two seconds while its
Requests are answered. A gateway that never sends another Request kept
working before; now its Updates are dropped as Invalid MAC once the
window has passed. So is the first Update after a new join from a
gateway that, as section 5.2.3.5.4 also allows, uses a longer timer
while it has no group subscriptions to report: it is dropped until that
gateway's next Request.

Which MACs are accepted changes too. Before, an Update had to carry the
nonce and MAC of the latest Request from its address; now any pair
minted for its address and port within the window is accepted. The MAC
never covered the encapsulated report, so this changes only how long a
pair seen by an on-path observer stays usable: off-path senders still
cannot produce a valid pair.

The secret is now seeded before amt_socket_create() enables the receive
path. It was seeded after the socket was created since
commit b9022b53adad ("amt: add control plane of amt interface"), when
there was no receive path yet, and
commit cbc21dc1cfe9 ("amt: add data plane of amt interface") added
amt_rcv() and the per-tunnel copy of the key without moving it. Since
then a Request that arrived during amt_dev_open() could get a tunnel
whose MAC used an all-zero key (on the first open) or the previous key
for the tunnel's whole life.

amt_update_tunnel() retries once when it finds its tunnel dead, and the
lookup skips dead tunnels, so an Update that races amt_tunnel_expire()
creates the replacement instead of being dropped. The Request path's
per-source count and the re-check under amt->lock in
amt_tunnel_get_or_create() skip them too. Every tunnel is now created by
an Update, which stamps last_seen, so amt_tunnel_expire() no longer
treats a last_seen of 0 as never refreshed. amt_tunnel_get_or_create()
also rechecks netif_running() under amt->lock before it links a tunnel.
dev_close() clears the running state before it calls amt_dev_stop(),
which drains the list under amt->lock, so an Update still being received
while the device goes down cannot link a tunnel after the drain.

Every Membership Update, forged ones included, reads the secret
generations to check its MAC. Their writers hold amt->lock and update
them inside a seqcount, amt->key_seq. The Update path copies them in a
key_seq read loop, so reading them takes amt->lock only on PREEMPT_RT,
to wait for a writer.

Keying by address and port lets one address hold several tunnels; before
this patch the Request path looked tunnels up by address alone, so an
address normally held only one. amt_max_tunnels_per_src() bounds that
at an eighth of max_tunnels, at least one tunnel and at most
AMT_MAX_TUNNELS_PER_SRC (16): 16 at the default 128 slots, 2 at 16. One
address then holds at most an eighth of a table of eight or more slots,
while gateways behind NAT still get several tunnels once the table has
16 or more slots. A configurable limit needs new uAPI, so it is left
for net-next.

Found by code inspection against RFC 7450; not triggered at runtime.
The Sashiko AI review of an earlier posting pointed out the undocumented
behaviour changes and that a fixed per-source cap let one address fill
a small table.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 405 ++++++++++++++++++++++++++++++++--------------
 include/net/amt.h |  14 +-
 2 files changed, 294 insertions(+), 125 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index de5b7dbe3..8014798b3 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -700,14 +700,6 @@ static void __amt_update_relay_status(struct amt_tunnel_list *tunnel,
 	tunnel->status = status;
 }
 
-static void amt_update_relay_status(struct amt_tunnel_list *tunnel,
-				    enum amt_status status, bool validate)
-{
-	spin_lock_bh(&tunnel->lock);
-	__amt_update_relay_status(tunnel, status, validate);
-	spin_unlock_bh(&tunnel->lock);
-}
-
 static void amt_send_discovery(struct amt_dev *amt)
 {
 	struct amt_header_discovery *amtd;
@@ -891,11 +883,16 @@ static void amt_send_request(struct amt_dev *amt, bool v6)
 
 static bool amt_send_membership_query(struct amt_dev *amt,
 				      struct sk_buff *skb,
-				      struct amt_tunnel_list *tunnel,
+				      __be32 daddr, __be16 dport,
+				      __be32 nonce, u64 mac,
 				      bool v6);
 
-static void amt_send_igmp_gq(struct amt_dev *amt,
-			     struct amt_tunnel_list *tunnel)
+/* The destination is passed by value rather than as a tunnel: a Request is
+ * unauthenticated, so no tunnel state is created or changed for it - see
+ * amt_request_handler().
+ */
+static void amt_send_igmp_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			     __be32 nonce, u64 mac)
 {
 	struct sk_buff *skb;
 
@@ -904,7 +901,8 @@ static void amt_send_igmp_gq(struct amt_dev *amt,
 		return;
 
 	skb_pull(skb, sizeof(struct ethhdr));
-	if (amt_send_membership_query(amt, skb, tunnel, false)) {
+	if (amt_send_membership_query(amt, skb, daddr, dport, nonce, mac,
+				      false)) {
 		DEV_STATS_INC(amt->dev, tx_dropped);
 		kfree_skb(skb);
 	}
@@ -983,7 +981,8 @@ static struct sk_buff *amt_build_mld_gq(struct amt_dev *amt)
 	return skb;
 }
 
-static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
+static void amt_send_mld_gq(struct amt_dev *amt, __be32 daddr, __be16 dport,
+			    __be32 nonce, u64 mac)
 {
 	struct sk_buff *skb;
 
@@ -992,13 +991,15 @@ static void amt_send_mld_gq(struct amt_dev *amt, struct amt_tunnel_list *tunnel)
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
@@ -1032,7 +1033,16 @@ static void amt_secret_work(struct work_struct *work)
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
@@ -1232,9 +1242,16 @@ static void amt_send_multicast_data(struct amt_dev *amt,
 			    0);
 }
 
+/* Send a Membership Query in reply to an unauthenticated Request.
+ *
+ * No per-source state is read or created: the gateway echoes the nonce and
+ * the keyed MAC in its Membership Update, where the MAC is recomputed, so
+ * everything this needs is passed by value.
+ */
 static bool amt_send_membership_query(struct amt_dev *amt,
 				      struct sk_buff *skb,
-				      struct amt_tunnel_list *tunnel,
+				      __be32 daddr, __be16 dport,
+				      __be32 nonce, u64 mac,
 				      bool v6)
 {
 	struct amt_header_membership_query *amtmq;
@@ -1255,13 +1272,13 @@ static bool amt_send_membership_query(struct amt_dev *amt,
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
 
@@ -1271,8 +1288,8 @@ static bool amt_send_membership_query(struct amt_dev *amt,
 	amtmq->reserved = 0;
 	amtmq->l	= 0;
 	amtmq->g	= 0;
-	amtmq->nonce	= tunnel->nonce;
-	amtmq->response_mac = tunnel->mac;
+	amtmq->nonce	= nonce;
+	amtmq->response_mac = mac;
 
 	if (!v6)
 		skb_set_inner_protocol(skb, htons(ETH_P_IP));
@@ -1285,11 +1302,10 @@ static bool amt_send_membership_query(struct amt_dev *amt,
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
 
@@ -1477,12 +1493,7 @@ static void amt_tunnel_expire(struct work_struct *work)
 	 * or finds it dead.
 	 */
 	now = jiffies;
-	deadline = tunnel->last_seen;
-	/* No Update yet: the Request armed gc_wq for one GMI. */
-	if (!deadline)
-		deadline = now;
-	else
-		deadline += msecs_to_jiffies(amt_gmi(amt)) * 3;
+	deadline = tunnel->last_seen + msecs_to_jiffies(amt_gmi(amt)) * 3;
 	if (time_before(now, deadline)) {
 		mod_delayed_work(amt_wq, &tunnel->gc_wq, deadline - now);
 		spin_unlock_bh(&tunnel->lock);
@@ -2631,16 +2642,165 @@ static bool amt_membership_query_handler(struct amt_dev *amt,
 	return false;
 }
 
+/* The live tunnel of the gateway endpoint @saddr:@sport, or NULL.  Dead
+ * tunnels are skipped, so the retry in amt_update_tunnel() after losing a
+ * race with amt_tunnel_expire() creates the replacement.
+ */
+static struct amt_tunnel_list *amt_tunnel_lookup(struct amt_dev *amt,
+						 __be32 saddr, __be16 sport)
+{
+	struct amt_tunnel_list *tunnel;
+
+	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
+		if (tunnel->ip4 == saddr && tunnel->source_port == sport &&
+		    !READ_ONCE(tunnel->dead))
+			return tunnel;
+	}
+	return NULL;
+}
+
+/* Most tunnels one source address may hold: an eighth of the table, at
+ * least one and at most AMT_MAX_TUNNELS_PER_SRC.
+ */
+static u32 amt_max_tunnels_per_src(const struct amt_dev *amt)
+{
+	return clamp_t(u32, amt->max_tunnels / 8, 1,
+		       AMT_MAX_TUNNELS_PER_SRC);
+}
+
+/* Look up the tunnel for a source whose Membership Update has already been
+ * authenticated, creating it on first contact.
+ *
+ * This is the only place tunnel state is allocated, so amt->max_tunnels
+ * bounds the number of *verified* gateways rather than the number of
+ * unverified Requests anyone can send.  A per-source cap derived from the
+ * table, amt_max_tunnels_per_src(), additionally limits the tunnels one
+ * verified source address may hold.
+ */
+static struct amt_tunnel_list *amt_tunnel_get_or_create(struct amt_dev *amt,
+							__be32 saddr,
+							__be16 sport)
+{
+	struct amt_tunnel_list *tunnel;
+	u32 per_src = 0;
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
+	 * Skip dead tunnels, as amt_tunnel_lookup() and the Request path do, so
+	 * a tunnel being freed neither stands in for its endpoint nor counts
+	 * against its address.
+	 */
+	list_for_each_entry(tunnel, &amt->tunnel_list, list) {
+		if (tunnel->ip4 != saddr || READ_ONCE(tunnel->dead))
+			continue;
+		if (tunnel->source_port == sport) {
+			spin_unlock_bh(&amt->lock);
+			return tunnel;
+		}
+		per_src++;
+	}
+
+	if (amt->nr_tunnels >= amt->max_tunnels ||
+	    per_src >= amt_max_tunnels_per_src(amt)) {
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
+/* Apply a valid, authenticated Membership Update to the tunnel of its
+ * endpoint, creating the tunnel on first contact.  Returns false if the
+ * Update is dropped.
+ *
+ * amt_tunnel_expire() reads last_seen and sets dead under tunnel->lock, so
+ * the refresh below either keeps the tunnel alive or finds it dead.  A
+ * tunnel that expired between the lookup and the lock is skipped by the
+ * second amt_tunnel_get_or_create() call, which creates its replacement.
+ */
+static bool amt_update_tunnel(struct amt_dev *amt, struct sk_buff *skb,
+			      __be32 saddr, __be16 sport, bool v6)
+{
+	struct amt_tunnel_list *tunnel;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		tunnel = amt_tunnel_get_or_create(amt, saddr, sport);
+		if (!tunnel)
+			return false;
+
+		spin_lock_bh(&tunnel->lock);
+		if (!READ_ONCE(tunnel->dead)) {
+			/* gc_wq is re-armed by amt_tunnel_expire() itself
+			 * from last_seen, never from here, so this cannot
+			 * re-queue the work of a tunnel that is being freed.
+			 */
+			tunnel->last_seen = jiffies;
+#if IS_ENABLED(CONFIG_IPV6)
+			if (v6)
+				amt_mld_report_handler(amt, skb, tunnel);
+			else
+#endif
+				amt_igmp_report_handler(amt, skb, tunnel);
+			spin_unlock_bh(&tunnel->lock);
+			return true;
+		}
+		spin_unlock_bh(&tunnel->lock);
+	}
+	return false;
+}
+
 static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 {
 	struct amt_header_membership_update *amtmu;
-	struct amt_tunnel_list *tunnel;
+	bool verified = false;
+	siphash_key_t key[4];
+	int len, hdr_size, i;
 	struct ethhdr *eth;
 	struct iphdr *iph;
-	int len, hdr_size;
+	unsigned int seq;
 	u64 response_mac;
 	__be32 saddr;
 	__be32 nonce;
+	__be16 sport;
 
 	saddr = ip_hdr(skb)->saddr;
 
@@ -2654,27 +2814,45 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 
 	nonce = amtmu->nonce;
 	response_mac = amtmu->response_mac;
+	/* Snapshot the tunnel endpoint port before the encap is stripped. */
+	sport = udp_hdr(skb)->source;
 
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
+		return true;
+	}
+
+	/* Create or refresh a tunnel only once the encapsulated message has
+	 * passed ip_mc_check_igmp() or ipv6_mc_check_mld().
+	 */
 	if (iptunnel_pull_header(skb, hdr_size, skb->protocol, false))
 		return true;
 
 	skb_reset_network_header(skb);
 
-	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
-		if (tunnel->ip4 == saddr) {
-			if ((nonce == tunnel->nonce &&
-			     response_mac == tunnel->mac)) {
-				goto report;
-			} else {
-				netdev_dbg(amt->dev, "Invalid MAC\n");
-				return true;
-			}
-		}
-	}
-
-	return true;
-
-report:
 	if (!pskb_may_pull(skb, sizeof(*iph)))
 		return true;
 
@@ -2688,21 +2866,8 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 			return true;
 		}
 
-		spin_lock_bh(&tunnel->lock);
-		if (READ_ONCE(tunnel->dead)) {
-			spin_unlock_bh(&tunnel->lock);
+		if (!amt_update_tunnel(amt, skb, saddr, sport, false))
 			return true;
-		}
-		/* Refresh liveness under tunnel->lock, where
-		 * amt_tunnel_expire() reads it; 0 is kept for a tunnel no
-		 * Update has refreshed.  gc_wq is re-armed by
-		 * amt_tunnel_expire() itself from last_seen, never from
-		 * here, so this cannot re-queue the work of a tunnel that is
-		 * being freed.
-		 */
-		tunnel->last_seen = jiffies ?: 1;
-		amt_igmp_report_handler(amt, skb, tunnel);
-		spin_unlock_bh(&tunnel->lock);
 
 		skb_push(skb, sizeof(struct ethhdr));
 		skb_reset_mac_header(skb);
@@ -2720,14 +2885,8 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 			return true;
 		}
 
-		spin_lock_bh(&tunnel->lock);
-		if (READ_ONCE(tunnel->dead)) {
-			spin_unlock_bh(&tunnel->lock);
+		if (!amt_update_tunnel(amt, skb, saddr, sport, true))
 			return true;
-		}
-		tunnel->last_seen = jiffies ?: 1;
-		amt_mld_report_handler(amt, skb, tunnel);
-		spin_unlock_bh(&tunnel->lock);
 
 		skb_push(skb, sizeof(struct ethhdr));
 		skb_reset_mac_header(skb);
@@ -2746,13 +2905,10 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 	skb->pkt_type = PACKET_MULTICAST;
 	skb->ip_summed = CHECKSUM_NONE;
 	len = skb->len;
-	if (__netif_rx(skb) == NET_RX_SUCCESS) {
-		amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_UPDATE,
-					true);
+	if (__netif_rx(skb) == NET_RX_SUCCESS)
 		dev_sw_netstats_rx_add(amt->dev, len);
-	} else {
+	else
 		amt->dev->stats.rx_dropped++;
-	}
 
 	return false;
 }
@@ -2868,15 +3024,30 @@ static bool amt_discovery_handler(struct amt_dev *amt, struct sk_buff *skb)
 	return false;
 }
 
+/* Handle an AMT Request.
+ *
+ * The source of a Request is unauthenticated: it is a bare UDP datagram with a
+ * trivially spoofable source address.  Allocating tunnel state here would let
+ * an attacker fill the table from spoofed addresses, or let one spoofed packet
+ * overwrite the nonce/MAC of an established tunnel and cut that gateway off.
+ *
+ * Nothing needs to be remembered at this point.  Every input to the keyed MAC
+ * is carried in the packet or is device state, so the MAC is generated here,
+ * echoed back by the gateway in its Membership Update, and recomputed and
+ * verified there - see amt_update_handler().  Tunnel state is created only once
+ * that verification succeeds and the encapsulated message passes its IGMP or
+ * MLD check.
+ */
 static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
 {
 	struct amt_header_request *amtrh;
 	struct amt_tunnel_list *tunnel;
-	unsigned long long key;
+	bool full, have = false;
 	struct udphdr *udph;
 	struct iphdr *iph;
+	siphash_key_t key;
+	u32 per_src = 0;
 	u64 mac;
-	int i;
 
 	if (!pskb_may_pull(skb, sizeof(*udph) + sizeof(*amtrh)))
 		return true;
@@ -2888,59 +3059,45 @@ static bool amt_request_handler(struct amt_dev *amt, struct sk_buff *skb)
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
 
-	INIT_DELAYED_WORK(&tunnel->gc_wq, amt_tunnel_expire);
-
-	list_add_tail_rcu(&tunnel->list, &amt->tunnel_list);
-	tunnel->key = amt->key;
-	__amt_update_relay_status(tunnel, AMT_STATUS_RECEIVED_REQUEST, true);
-	amt->nr_tunnels++;
-	mod_delayed_work(amt_wq, &tunnel->gc_wq,
-			 msecs_to_jiffies(amt_gmi(amt)));
+	/* Snapshot the secret and the table-full state under the lock and walk
+	 * the endpoints outside it, so a Request holds amt->lock only for this
+	 * O(1) snapshot.
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
+	/* Skip dead tunnels, as amt_tunnel_lookup() does: each is already
+	 * being torn down, so it must not count against a new endpoint.
+	 */
+	rcu_read_lock();
+	list_for_each_entry_rcu(tunnel, &amt->tunnel_list, list) {
+		if (tunnel->ip4 != iph->saddr || READ_ONCE(tunnel->dead))
+			continue;
+		per_src++;
+		if (tunnel->source_port == udph->source)
+			have = true;
+	}
+	rcu_read_unlock();
 
-	if (!netif_running(amt->dev) || !netif_running(amt->stream_dev))
+	/* Withhold the Query when a new endpoint cannot get a tunnel. */
+	if (!have && (full || per_src >= amt_max_tunnels_per_src(amt)))
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
@@ -3208,6 +3365,16 @@ static int amt_dev_open(struct net_device *dev)
 	enable_delayed_work(&amt->discovery_wq);
 	enable_delayed_work(&amt->req_wq);
 
+	/* Seed the keys before amt_socket_create() enables the encap receive
+	 * path, so no Query MAC is generated, and no Update verified, with an
+	 * all-zero (predictable) secret.
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
@@ -3218,7 +3385,6 @@ static int amt_dev_open(struct net_device *dev)
 	amt->req_cnt = 0;
 	WRITE_ONCE(amt->remote_ip, 0);
 	amt->nonce = 0;
-	get_random_bytes(&amt->key, sizeof(siphash_key_t));
 
 	amt->status = AMT_STATUS_INIT;
 	if (amt->mode == AMT_MODE_GATEWAY) {
@@ -3436,6 +3602,7 @@ static int amt_newlink(struct net_device *dev,
 		amt->max_tunnels = AMT_MAX_TUNNELS;
 
 	spin_lock_init(&amt->lock);
+	seqcount_spinlock_init(&amt->key_seq, &amt->lock);
 	amt->max_groups = AMT_MAX_GROUP;
 	amt->max_sources = AMT_MAX_SOURCE;
 	amt->hash_buckets = AMT_HSIZE;
diff --git a/include/net/amt.h b/include/net/amt.h
index dedf328d8..9ba097127 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -253,10 +253,6 @@ struct amt_tunnel_list {
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
@@ -342,8 +338,12 @@ struct amt_dev {
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
@@ -401,6 +401,8 @@ struct amt_dev {
 #define AMT_SECRET_TIMEOUT	60000
 #define IANA_AMT_UDP_PORT	2268
 #define AMT_MAX_TUNNELS         128
+/* Upper bound of amt_max_tunnels_per_src(), the per-address tunnel cap */
+#define AMT_MAX_TUNNELS_PER_SRC 16
 #define AMT_MAX_REQS		128
 #define AMT_GW_HLEN (sizeof(struct iphdr) + \
 		     sizeof(struct udphdr) + \
-- 
2.43.0

