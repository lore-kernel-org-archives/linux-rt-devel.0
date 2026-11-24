Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.10.208.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537664;
	b=10rg9yrtzWsJtF6Jym1YKLsDswerCxpq61VktOj6AZbbDspIwRQ1uQgQhSGAC9bFKciN
	 CfGBQkuk0rOowH7dlaBm3u7az4A3P1zGohdnvoAFwmAQwyN1XZjIu/yz5elGQF+8X7Ibx
	 z0QCvW4Bb2fIHdygTpWxOvqm7V1FFeDCrzMlc1mMrtbUht1ugC/0W77/+lZwJ85OlhYhy
	 b8SEVTER23goTa/3jpD4N10KE257TuE4OhuquT2UuUpP2boZgwwsBGaH/rNvxtD4+dVaU
	 xVp8SuJjd8KpAV9ebey6DGI+fxtiJyivAbwl9nL7CbwYKLIVgkWzxEWm4/nWGapHmqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537664;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Rspamd-Queue-Id;
	bh=Jrpxc1Q6pgjfCQC9LCXv5AaAKRJs/kdvERD9Fgr0nfc=;
	b=lDV9KB1CU6B0HVafaXvtYzN9UACqqtiJMzJsogOCA5ybT9h9z/xtyGC9uijy0BQyb5ug
	 mwdT8qglCGc7b1tTbcqxK7i0iVnLAyiWPvdl2coiPemUJuvR62zC/yj7xe1/mIffjDifo
	 OliKtigkU8bGiXyHAKvYgO0Xy89o+gTu1VlZ4xXI3SPQXV9IvNckWyxemWcgseDEdtUVk
	 m49LLPjqL3XFgEaE7/lfJx2rIzDWUmjYZFligISjyyYYMH67AsMSraoHaM+IrzmzriQEi
	 cgtHG6I9+ghDvqal9LvgUC/RyRxnYE6qKDylM2znZUBFQP/YsXJaoYNndEa5TjaqlDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mandelbit.com;
	spf=pass smtp.mailfrom=mandelbit.com;
	dkim=pass header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=cc4d7QZP;
	arc=none smtp.remote-ip=195.10.208.62
Received: from mout-b-202.mailbox.org (mout-b-202.mailbox.org [195.10.208.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8709D606A332
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 16:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8709D606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mandelbit.com header.i=@mandelbit.com header.a=rsa-sha256 header.s=MBO0001 header.b=cc4d7QZP
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-202.mailbox.org (Postfix) with ESMTPS id 4jYpBG3f7szKnsH;
	Tue, 24 Nov 2026 17:27:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1795537654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jrpxc1Q6pgjfCQC9LCXv5AaAKRJs/kdvERD9Fgr0nfc=;
	b=cc4d7QZPuxOeD8POei5YQZbOALG+AOMebhNI5laNKtPtXKqVDBp0sU1gT1tUvKlffxcXSM
	OZg/EMz6Iu72bQSFozrs9ecmFfFEG4ad4DdqD/44xQjwzeJ9i9YLbWiLVjpS6vtRE/h2Jj
	rWTMkwxT4rrNwy0SC3G4TRDwi2WSvH4O+QocH9HqUbvDAmv1RJTilRagRjj4/5Ka5WXcqt
	bq9RJRtf/+vfRaku41lCj6b88pqHTPHw5rOlbTNnnTjLiyzkVOM29+k5ucWxBfsoE3Mwgc
	47/hadLTlAbYQtYwEqNxSpWYUB/lQchj+ht0atZkypsxCem/k8r0A7lpA8RfOA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of ralf@mandelbit.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=ralf@mandelbit.com
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Florian Westphal <fw@strlen.de>,
	Xia Yan <yanxia@cmss.chinamobile.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 4/4] ipv6: validate dsts against the state their lookup found
Date: Tue, 24 Nov 2026 17:27:10 +0100
Message-ID: <4b2bf5de6c9837fee8db88d639db0e27e6d687b9.1795537128.git.ralf@mandelbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795537128.git.ralf@mandelbit.com>
References: <cover.1795537128.git.ralf@mandelbit.com>
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
X-Rspamd-Queue-Id: 4jYpBG3f7szKnsH

Validate dsts in ip6_dst_check against the stamp of the lookup that
built them instead of the cookie passed by their holder, which may have
been read after a FIB change the lookup did not see. A stamp of 0,
recorded when the generation changed during the lookup or the route was
unlinked, never validates. Holders are covered without changes,
including dst_cache users and the route and path dsts of xfrm bundles,
and invalidation keeps its per-node scope: a FIB change only invalidates
dsts of routes under the nodes it stamps.

pcpu dsts are shared by all their holders, so they are never
re-stamped, which would revalidate a stale dst for every holder. A pcpu
dst is reused only if it carries the stamp of the current lookup.
Otherwise it is replaced, so a lookup that selected a route before a FIB
change cannot return a pcpu dst that another lookup rebuilt after it.
On PREEMPT_RT, a pcpu dst that another task installed while this lookup
built its own follows the same rule.

A replaced pcpu dst is released with dst_dev_put as before, and since
pcpu dsts of nexthop-object routes are validated against the IPv6
generation, now the one read before the lookup, they are also rejected
once released. Lookups may have read the slot without taking a
reference, and an xfrm bundle holding the dst as its child drops its
reference without waiting for a grace period, so the slot's reference
is dropped only after one (__fib6_drop_pcpu_from is unchanged).

Not covered yet: a holder that sends through a released dst without
validating it again, such as a corked UDP socket, loses those packets,
now also when a FIB change in the route's subtree replaces the pcpu
dst. Exceptions keep being validated against the holder's cookie, and
so keep the late sampling, as refreshing them needs their PMTU updates
serialized with the replacement.

Suggested-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
New in v5
- Replaces the lookup cookie API and its users from v4. (David)

 net/ipv6/route.c | 78 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 14 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 8b98ee945c58..be9bf7a4e780 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1501,7 +1501,7 @@ static struct rt6_info *ip6_rt_pcpu_alloc(const struct fib6_result *res)
 	pcpu_rt->rt6i_flags |= RTF_PCPU;
 
 	if (f6i->nh)
-		pcpu_rt->sernum = rt_genid_ipv6(dev_net(dev));
+		pcpu_rt->sernum = res->gen;
 
 	return pcpu_rt;
 }
@@ -1511,6 +1511,33 @@ static bool rt6_is_valid(const struct rt6_info *rt6)
 	return rt6->sernum == rt_genid_ipv6(dev_net(rt6->dst.dev));
 }
 
+static bool rt6_stamp_matches(const struct rt6_info *rt,
+			      const struct fib6_result *res)
+{
+	if (rt->sernum || res->f6i->nh)
+		return res->gen && rt->sernum == res->gen;
+
+	return res->cookie && rt->cookie == res->cookie;
+}
+
+static void rt6_pcpu_release_rcu(struct rcu_head *head)
+{
+	struct dst_entry *dst = container_of(head, struct dst_entry, rcu_head);
+
+	dst_release(dst);
+}
+
+/* Release a pcpu dst taken out of its slot. Lookups may have read the slot
+ * without taking a reference, so drop the slot's own only after a grace
+ * period: an xfrm bundle holding the dst as its child releases its
+ * reference without waiting for one.
+ */
+static void rt6_pcpu_release(struct rt6_info *rt)
+{
+	dst_dev_put(&rt->dst);
+	call_rcu(&rt->dst.rcu_head, rt6_pcpu_release_rcu);
+}
+
 /* It should be called with rcu_read_lock() acquired */
 static struct rt6_info *rt6_get_pcpu_route(const struct fib6_result *res)
 {
@@ -1518,16 +1545,19 @@ static struct rt6_info *rt6_get_pcpu_route(const struct fib6_result *res)
 
 	pcpu_rt = this_cpu_read(*res->nh->rt6i_pcpu);
 
-	if (pcpu_rt && pcpu_rt->sernum && !rt6_is_valid(pcpu_rt)) {
+	/* A pcpu dst is shared by all its holders, so it is never re-stamped.
+	 * Reuse it only if it was built under the state this lookup found,
+	 * otherwise replace it: a dst rebuilt by another lookup after a FIB
+	 * change must not be returned to a lookup that selected before it.
+	 */
+	if (pcpu_rt && !rt6_stamp_matches(pcpu_rt, res)) {
 		struct rt6_info *prev, **p;
 
 		p = this_cpu_ptr(res->nh->rt6i_pcpu);
 		/* Paired with READ_ONCE() in __fib6_drop_pcpu_from() */
 		prev = xchg(p, NULL);
-		if (prev) {
-			dst_dev_put(&prev->dst);
-			dst_release(&prev->dst);
-		}
+		if (prev)
+			rt6_pcpu_release(prev);
 
 		pcpu_rt = NULL;
 	}
@@ -1550,13 +1580,21 @@ static struct rt6_info *rt6_make_pcpu_route(struct net *net,
 		/*
 		 * Another task on this CPU already installed a pcpu_rt.
 		 * This can happen on PREEMPT_RT where preemption is possible.
-		 * Free our allocation and return the existing one.
+		 * Free our allocation and return the existing one if it was
+		 * built under the state this lookup found, otherwise replace
+		 * it as rt6_get_pcpu_route does.
 		 */
 		WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT_RT));
 
-		dst_dev_put(&pcpu_rt->dst);
-		dst_release(&pcpu_rt->dst);
-		return prev;
+		if (rt6_stamp_matches(prev, res)) {
+			dst_dev_put(&pcpu_rt->dst);
+			dst_release(&pcpu_rt->dst);
+			return prev;
+		}
+
+		prev = xchg(p, pcpu_rt);
+		if (prev)
+			rt6_pcpu_release(prev);
 	}
 
 	if (res->f6i->fib6_destroying) {
@@ -2864,11 +2902,16 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
 	struct dst_entry *dst_ret;
 	struct fib6_info *from;
 	struct rt6_info *rt;
+	bool exception;
 
 	rt = dst_rt6_info(dst);
 
+	/* a nexthop-object pcpu dst replaced by another lookup has been
+	 * released with dst_dev_put and must fail even if its stamp is current
+	 */
 	if (rt->sernum)
-		return rt6_is_valid(rt) ? dst : NULL;
+		return (READ_ONCE(rt->dst.obsolete) == DST_OBSOLETE_FORCE_CHK &&
+			rt6_is_valid(rt)) ? dst : NULL;
 
 	rcu_read_lock();
 
@@ -2879,9 +2922,16 @@ INDIRECT_CALLABLE_SCOPE struct dst_entry *ip6_dst_check(struct dst_entry *dst,
 
 	from = rcu_dereference(rt->from);
 
-	if (from && (rt->rt6i_flags & RTF_PCPU ||
-	    unlikely(rt->dst.rt_uncached_list)))
-		dst_ret = rt6_dst_from_check(rt, from, cookie);
+	/* Exceptions are validated against the holder's cookie, every other
+	 * dst against the stamp of the lookup that built it rather than the
+	 * cookie its holder read afterwards, which may postdate a FIB change
+	 * the lookup did not see.
+	 */
+	exception = (rt->rt6i_flags & RTF_CACHE) && !rt->dst.rt_uncached_list;
+	if (from && !exception)
+		dst_ret = rt->cookie ?
+				  rt6_dst_from_check(rt, from, rt->cookie) :
+				  NULL;
 	else
 		dst_ret = rt6_check(rt, from, cookie);
 
-- 
2.56.0

