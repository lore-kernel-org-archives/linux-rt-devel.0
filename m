Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794012584;
	b=Iv+0HDHYgVTZUd7VLX+q7u1i93bUjb6JsPp8DOTgVxQ4wfX2/i7eFDnHPVm2uLeviqdH
	 PVS/wJARypJKN4rSYTEHGCYZqrfX1lJTfKFacuhv6/PAArI+NrBPyEW6rBGc+XETH7go3
	 ycjF5slQcPwsaGuSIVjYKFpEa2pa1YqvY7TY11uD6z6c6JVN9jMKrVHDlGTfCjn9gAbQM
	 +sMqUjcS1WU6INyjSfvy1YX3g83CbKDJ25FVJQ1EZGWnqG8HPTo9f5hTlEaF08qed1MX+
	 naUosQwux2nBD+O5u283yrXlFwTwGH3UD7OCnv0CtaKovsRXlb5zhqW1e6izVSB4vlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012584;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cwiVzp+HuR0Tj8DJ627xMZTOLW6WDCr4Uk7SOXWOnzI=;
	b=tV9iumjw5RGUjiDLV5G4/TmcFo7PPu955t1SPDE6ZFVtdu529OL/5MVaGy1HW9BPh1La
	 uE3AF2vlt0ithd3l16BN9838xsVndM48e1uZnvOCnenRKwsy0Ir6jeMsiGNzwCNXO+l2+
	 OZ48ptlow/bmznGhRRKhK5DgC9d6kyYDmKhIltu2lbfatKqs1Z3mo4GYwitPIgkPqaYvw
	 euZQCNUtnfNHByuXKXLXoQ6TgDpvUA/r1OwG9tncCVQWwdBYum8JVrxkBNYqO8Pe/KaqE
	 IZVIAucQ0suFKK/7B0T3Z3ggnLJfHTRDmO7LFjOJUk1aySAekEJ86lUZF56gfi7t9tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=TIzR7Voa;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636786070B85
	for <linux-rt-devel@lists.linux.dev>; Sat,  7 Nov 2026 00:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 636786070B85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=TIzR7Voa
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-37071c0f42aso1483468eec.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Nov 2026 16:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794012582; x=1794617382; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cwiVzp+HuR0Tj8DJ627xMZTOLW6WDCr4Uk7SOXWOnzI=;
        b=TIzR7VoaUEk9OblfD6dmmFgrjkigoO4U8A3EByb9p4ff5mW0nGEh2rnDpr7SeTB30a
         wtL4wMe67eRbhWv0enHqY9xe9XIO4hX5LjBuJ3kuHAdLZjhwTv67+FUSAlaZLWppQzAO
         EJmfxiuMiPx3MwN3mkoTsfGUrn+YDE0N/pdVkF0liX2FjXJnPiX7iH1fvKvutdX1iL4D
         VLXyWJ46MSMxpp2tFwKU6OEQnZldjoNAmO8msDwl5XHty2xplS2+TZQejd3mM6c+60mI
         1Rjfs8MeeKkvh1jsmFIS7nlGrDG052R8lrBT9JjweA7M37AuvpXJCgGp5AyTnfvGkSYY
         gF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012582; x=1794617382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cwiVzp+HuR0Tj8DJ627xMZTOLW6WDCr4Uk7SOXWOnzI=;
        b=ailQK8pmT03ueMCNOLQU4/erDbR0TqN0O7IEst+1/xBhozTUCLM9HOMQeStybNaz1O
         57NW6pRVTtyBrmHwn/6t6zgPwI2Y1j9/G7cBh7HUADhYuCWIODV+8e64EFyd765CyTmN
         RaWoMOPZVGcHUDHengRU+4Y8xZ9DXJA4ERXx4YkPO3WERnSqHuk5Za3nM59wAL+6vVi+
         Rj0cffeFSKTiRdYPW32F/qmNv4mHdU4Rcs8zsbvzMxWEmueXG5LAERxyIORsnlp+bZL5
         F3vVMJEncasAQVw28oHyHJxu0kjUO0RQ/ZjBD7V5q2uKr+CSmmkySLDFfU/1kEvI7jxI
         FfzQ==
X-Forwarded-Encrypted: i=1; AL+hErEf4AjnGH0ua4uIP2C2QEx+ogkdb6I44Ywijzx68E5ivAJmeIzk7R+fdN8DOC+CgpnGITYmgCM2MYbmT6vuYw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/lE8u0D66EFk83Jkq6ggC3hX2V2y0sWXF9s4RoRZ3XYVIe/mrv
	rS5cnUdI/0Mfv++AYjsz3VCNsXMLoKHJqRNNMNmh4EkJhfm8pgbv49g9IDMlA5I74Ac=
X-Gm-Gg: AYBFou0qy9yir9KrJowEtf6mSPAX0MGQoyR+k8DLnLxaUv4eiarZkmXfZZYAQuouQIS
	wvA8XyAJ5JXKohRXRysJbRiZopPxyuykY2dmI692kH3mup5Ky0KB/oIFbo4LG8Ugtz6aL9rbDLQ
	ZydOXqvqXSldUTYpvxOsCkO/gRrR84ojXYITwDaXPZtbiwSeDwy7GgI4bpV1B2kK7/tMgy8kQ6T
	cvhrK/VJcI1w4O38zyCOPnD9TXhUVdst4v9XRNx7jIHwwOrADmdPqOlkelkQKVq0e0PX3btDELB
	+GqW4tzpJ6ZwAR3VYg4slyjTVsRDIZ68f9FD5ZZyUudOTpiTaDkS3IrcyGnb80XWls7gRBAGl8L
	wvHR/YOuyHuL9KOoeYsTF48V3TfZb6rT/wLJ0vDjQ7FWoPd7MkKUH/vMWjdn1wdhyFXgF13/zR9
	p70Pdwse28DG9e8OVFxUuO6655SurlvC73bGKMvB1QHkEgdEJr0Q7DlJQlpd7+LMU2KpYGNFxZw
	qzlxvhqHEpPtMyZZmC1hU0Z1bfxJvoNUmJw876REVckhp02gTfETDcT5Nau36s953ZHSEwNNH96
	7xkWJ8wP14G4iFw4Avz3y+QSbWG9jFHVhOIVqn8grCh0nx58lycJ2LxIg72Y6YGRgnKqUAM=
X-Received: by 2002:a05:7300:d191:b0:36e:d060:8bad with SMTP id 5a478bee46e88-36f722e79ccmr5193728eec.5.1794012582316;
        Fri, 06 Nov 2026 16:49:42 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a718sm11021294eec.4.2026.11.06.16.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:49:41 -0800 (PST)
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
Subject: [PATCH net v6 2/6] amt: fix use-after-free when a Membership Update re-arms a freed tunnel
Date: Sat,  7 Nov 2026 00:49:31 +0000
Message-ID: <20261107004935.2627329-3-omar@blockcast.net>
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

amt_update_handler() refreshes a relay tunnel's garbage-collection timer
with mod_delayed_work() on a tunnel found by an RCU walk. A concurrent
amt_tunnel_expire() can unlink and free that tunnel while the Update path
still has the cached pointer, leaving gc_wq armed in freed memory.

Make amt_tunnel_expire() the only timeout-path freer. The Update path
records last_seen under tunnel->lock, and expire reads it under
tunnel->lock and, in the same section, either re-arms gc_wq from it or
marks the tunnel dead for freeing, so an Update either keeps the tunnel
alive or finds it dead. Protect the dead state with tunnel->lock so
report handling cannot add multicast state after teardown begins.
Device stop marks tunnels dead, unlinks them with list_del_rcu(),
synchronously cancels their work, and frees them after lockless readers
have passed.

Apply the same lifetime rules to group and source timer work: mark nodes
dead under tunnel->lock, keep RCU held while workers resolve their
parents, defer node freeing, and synchronously cancel each node's timer
before freeing that node. Run the deferred GC directly before freeing a
tunnel so nodes are reclaimed promptly. Do not flush the GC work
instead: flush_delayed_work() queues the work and waits for it to run,
which needs a free amt_wq active slot, so amt_tunnel_expire() and the
group GC, both amt_wq work, can deadlock once every slot is held by such
a waiter. The cancel_delayed_work_sync() calls the GC makes need no
slot: each takes a pending timer work off its timer or queue, or waits
for a running one on a barrier that max_active does not count. Lifetime
does not rest on that GC run, which misses nodes a concurrent run has
already spliced off: it rests on kfree_rcu() and on the parent pointers
being cleared, and the dead checks made, under tunnel->lock. Release the
group timer's device reference on every exit.

A Request-only tunnel retains the original GMI timeout. Its last_seen
stays 0, a value an Update never stores, and only a valid, authenticated
Membership Update refreshes last_seen and gives the tunnel the longer
lifetime: an Update whose encapsulated message fails ip_mc_check_igmp()
or ipv6_mc_check_mld() no longer extends the tunnel. amt_tunnel_expire()
reads jiffies once, so the re-arm delay comes from the value it
compared.

The Sashiko AI review of an earlier posting of this series pointed out
the gc_wq re-arm, and reading amt_update_handler() against
amt_tunnel_expire() and amt_dev_stop() confirms it. It is theoretical:
it needs a Membership Update that has already found the tunnel under RCU
to arrive while amt_tunnel_expire() is freeing that tunnel. I have not
triggered it, so there is no trace to include. Review of later postings
raised the races in the group and source timer work.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 212 ++++++++++++++++++++++++++++++++++++++++------
 include/net/amt.h |  17 ++++
 2 files changed, 205 insertions(+), 24 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 3a703b79f..e4b8c02a0 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -38,6 +38,10 @@ static HLIST_HEAD(source_gc_list);
 /* Lock for source_gc_list */
 static spinlock_t source_gc_lock;
 static struct delayed_work source_gc_wq;
+static HLIST_HEAD(group_gc_list);
+/* Lock for group_gc_list */
+static spinlock_t group_gc_lock;
+static struct delayed_work group_gc_wq;
 static char *status_str[] = {
 	"AMT_STATUS_INIT",
 	"AMT_STATUS_SENT_DISCOVERY",
@@ -90,8 +94,9 @@ static void __amt_source_gc_work(void)
 	hlist_move_list(&source_gc_list, &gc_list);
 	spin_unlock_bh(&source_gc_lock);
 
-	hlist_for_each_entry_safe(snode, t, &gc_list, node) {
-		hlist_del_rcu(&snode->node);
+	hlist_for_each_entry_safe(snode, t, &gc_list, gc_node) {
+		cancel_delayed_work_sync(&snode->source_timer);
+		hlist_del_init(&snode->gc_node);
 		kfree_rcu(snode, rcu);
 	}
 }
@@ -106,6 +111,46 @@ static void amt_source_gc_work(struct work_struct *work)
 	spin_unlock_bh(&source_gc_lock);
 }
 
+static void __amt_group_gc_work(void)
+{
+	struct amt_group_node *gnode;
+	struct hlist_head gc_list;
+	struct hlist_node *t;
+
+	spin_lock_bh(&group_gc_lock);
+	hlist_move_list(&group_gc_list, &gc_list);
+	spin_unlock_bh(&group_gc_lock);
+
+	/* Group deletion queues all of its sources first.  Reclaim them now
+	 * rather than at the next periodic run; a source callback cannot
+	 * reach a freed group because it resolves snode->gnode under RCU and
+	 * the pointer is cleared before the source is queued.  Call the GC
+	 * here rather than flush source_gc_wq: a flush queues the work and
+	 * waits for it to run, which needs a free amt_wq active slot, and
+	 * when this runs on amt_wq every slot can be held by such waiters.
+	 * The cancel_delayed_work_sync() calls in the GC need no slot: each
+	 * takes a pending timer work off its timer or queue, or waits for a
+	 * running one on a barrier that max_active does not count.
+	 */
+	__amt_source_gc_work();
+
+	hlist_for_each_entry_safe(gnode, t, &gc_list, gc_node) {
+		cancel_delayed_work_sync(&gnode->group_timer);
+		hlist_del_init(&gnode->gc_node);
+		kfree_rcu(gnode, rcu);
+	}
+}
+
+static void amt_group_gc_work(struct work_struct *work)
+{
+	__amt_group_gc_work();
+
+	spin_lock_bh(&group_gc_lock);
+	mod_delayed_work(amt_wq, &group_gc_wq,
+			 msecs_to_jiffies(AMT_GC_INTERVAL));
+	spin_unlock_bh(&group_gc_lock);
+}
+
 static bool amt_addr_equal(union amt_addr *a, union amt_addr *b)
 {
 	return !memcmp(a, b, sizeof(union amt_addr));
@@ -215,8 +260,13 @@ static struct amt_group_node *amt_lookup_group(struct amt_tunnel_list *tunnel,
 
 static void amt_destroy_source(struct amt_source_node *snode)
 {
-	struct amt_group_node *gnode = snode->gnode;
 	struct amt_tunnel_list *tunnel;
+	struct amt_group_node *gnode;
+
+	if (READ_ONCE(snode->dead))
+		return;
+	WRITE_ONCE(snode->dead, true);
+	gnode = snode->gnode;
 
 	tunnel = gnode->tunnel_list;
 
@@ -238,8 +288,9 @@ static void amt_destroy_source(struct amt_source_node *snode)
 	hlist_del_init_rcu(&snode->node);
 	tunnel->nr_sources--;
 	gnode->nr_sources--;
+	WRITE_ONCE(snode->gnode, NULL);
 	spin_lock_bh(&source_gc_lock);
-	hlist_add_head_rcu(&snode->node, &source_gc_list);
+	hlist_add_head(&snode->gc_node, &source_gc_list);
 	spin_unlock_bh(&source_gc_lock);
 }
 
@@ -249,6 +300,9 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 	struct hlist_node *t;
 	int i;
 
+	if (READ_ONCE(gnode->dead))
+		return;
+	WRITE_ONCE(gnode->dead, true);
 	if (cancel_delayed_work(&gnode->group_timer))
 		dev_put(amt->dev);
 	hlist_del_rcu(&gnode->node);
@@ -266,10 +320,10 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 		hlist_for_each_entry_safe(snode, t, &gnode->sources[i], node)
 			amt_destroy_source(snode);
 
-	/* tunnel->lock was acquired outside of amt_del_group()
-	 * But rcu_read_lock() was acquired too so It's safe.
-	 */
-	kfree_rcu(gnode, rcu);
+	WRITE_ONCE(gnode->tunnel_list, NULL);
+	spin_lock_bh(&group_gc_lock);
+	hlist_add_head(&gnode->gc_node, &group_gc_list);
+	spin_unlock_bh(&group_gc_lock);
 }
 
 /* If a source timer expires with a router filter-mode for the group of
@@ -282,13 +336,28 @@ static void amt_source_work(struct work_struct *work)
 	struct amt_source_node *snode = container_of(to_delayed_work(work),
 						     struct amt_source_node,
 						     source_timer);
-	struct amt_group_node *gnode = snode->gnode;
-	struct amt_dev *amt = gnode->amt;
 	struct amt_tunnel_list *tunnel;
+	struct amt_group_node *gnode;
+	struct amt_dev *amt;
 
-	tunnel = gnode->tunnel_list;
-	spin_lock_bh(&tunnel->lock);
 	rcu_read_lock();
+	gnode = READ_ONCE(snode->gnode);
+	if (!gnode) {
+		rcu_read_unlock();
+		return;
+	}
+	amt = READ_ONCE(gnode->amt);
+	tunnel = READ_ONCE(gnode->tunnel_list);
+	if (!tunnel) {
+		rcu_read_unlock();
+		return;
+	}
+	spin_lock_bh(&tunnel->lock);
+	if (READ_ONCE(snode->dead) || READ_ONCE(gnode->dead)) {
+		spin_unlock_bh(&tunnel->lock);
+		rcu_read_unlock();
+		return;
+	}
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		amt_destroy_source(snode);
 		if (!gnode->nr_sources)
@@ -299,8 +368,8 @@ static void amt_source_work(struct work_struct *work)
 		 */
 		snode->status = AMT_SOURCE_STATUS_D_FWD;
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
+	rcu_read_unlock();
 }
 
 static void amt_act_src(struct amt_tunnel_list *tunnel,
@@ -368,6 +437,7 @@ static struct amt_source_node *amt_alloc_snode(struct amt_group_node *gnode,
 	snode->status = AMT_SOURCE_STATUS_NONE;
 	snode->flags = AMT_SOURCE_NEW;
 	INIT_HLIST_NODE(&snode->node);
+	INIT_HLIST_NODE(&snode->gc_node);
 	INIT_DELAYED_WORK(&snode->source_timer, amt_source_work);
 
 	return snode;
@@ -403,23 +473,31 @@ static void amt_group_work(struct work_struct *work)
 	struct amt_group_node *gnode = container_of(to_delayed_work(work),
 						    struct amt_group_node,
 						    group_timer);
-	struct amt_tunnel_list *tunnel = gnode->tunnel_list;
-	struct amt_dev *amt = gnode->amt;
+	struct amt_tunnel_list *tunnel;
 	struct amt_source_node *snode;
 	bool delete_group = true;
 	struct hlist_node *t;
+	struct amt_dev *amt;
 	int i, buckets;
 
+	rcu_read_lock();
+	tunnel = READ_ONCE(gnode->tunnel_list);
+	amt = READ_ONCE(gnode->amt);
+	if (!tunnel)
+		goto out;
 	buckets = amt->hash_buckets;
 
 	spin_lock_bh(&tunnel->lock);
+	if (READ_ONCE(gnode->dead)) {
+		spin_unlock_bh(&tunnel->lock);
+		goto out;
+	}
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		/* Not Used */
 		spin_unlock_bh(&tunnel->lock);
 		goto out;
 	}
 
-	rcu_read_lock();
 	for (i = 0; i < buckets; i++) {
 		hlist_for_each_entry_safe(snode, t,
 					  &gnode->sources[i], node) {
@@ -436,9 +514,9 @@ static void amt_group_work(struct work_struct *work)
 		amt_del_group(amt, gnode);
 	else
 		gnode->filter_mode = MCAST_INCLUDE;
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 out:
+	rcu_read_unlock();
 	dev_put(amt->dev);
 }
 
@@ -479,6 +557,7 @@ static struct amt_group_node *amt_add_group(struct amt_dev *amt,
 	gnode->tunnel_list = tunnel;
 	gnode->filter_mode = MCAST_INCLUDE;
 	INIT_HLIST_NODE(&gnode->node);
+	INIT_HLIST_NODE(&gnode->gc_node);
 	INIT_DELAYED_WORK(&gnode->group_timer, amt_group_work);
 	for (i = 0; i < amt->hash_buckets; i++)
 		INIT_HLIST_HEAD(&gnode->sources[i]);
@@ -1342,14 +1421,51 @@ static void amt_tunnel_expire(struct work_struct *work)
 						      struct amt_tunnel_list,
 						      gc_wq);
 	struct amt_dev *amt = tunnel->amt;
+	unsigned long deadline, now;
 
 	spin_lock_bh(&amt->lock);
+	spin_lock_bh(&tunnel->lock);
+	/* amt_dev_stop() has taken ownership of the teardown. */
+	if (READ_ONCE(tunnel->dead)) {
+		spin_unlock_bh(&tunnel->lock);
+		spin_unlock_bh(&amt->lock);
+		return;
+	}
+	/* A Membership Update may have refreshed the tunnel after this work
+	 * was queued.  Re-arm from last_seen rather than letting
+	 * amt_update_handler() re-arm gc_wq: this handler is then the only
+	 * context that frees the tunnel on the timeout path; amt_dev_stop()
+	 * still owns teardown during device shutdown.  last_seen is read and
+	 * dead is set under tunnel->lock, which the Update path holds while
+	 * it refreshes last_seen, so an Update either keeps the tunnel alive
+	 * or finds it dead.
+	 */
+	now = jiffies;
+	deadline = tunnel->last_seen;
+	/* No Update yet: the Request armed gc_wq for one GMI. */
+	if (!deadline)
+		deadline = now;
+	else
+		deadline += msecs_to_jiffies(amt_gmi(amt)) * 3;
+	if (time_before(now, deadline)) {
+		mod_delayed_work(amt_wq, &tunnel->gc_wq, deadline - now);
+		spin_unlock_bh(&tunnel->lock);
+		spin_unlock_bh(&amt->lock);
+		return;
+	}
+	WRITE_ONCE(tunnel->dead, true);
+	spin_unlock_bh(&tunnel->lock);
 	rcu_read_lock();
 	list_del_rcu(&tunnel->list);
 	amt->nr_tunnels--;
 	amt_clear_groups(tunnel);
 	rcu_read_unlock();
 	spin_unlock_bh(&amt->lock);
+	/* Free now, rather than at the next periodic run, the nodes that
+	 * amt_clear_groups() queued.  Call the GC rather than flush
+	 * group_gc_wq, as explained in __amt_group_gc_work().
+	 */
+	__amt_group_gc_work();
 	kfree_rcu(tunnel, rcu);
 }
 
@@ -2508,9 +2624,6 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		if (tunnel->ip4 == saddr) {
 			if ((nonce == tunnel->nonce &&
 			     response_mac == tunnel->mac)) {
-				mod_delayed_work(amt_wq, &tunnel->gc_wq,
-						 msecs_to_jiffies(amt_gmi(amt))
-								  * 3);
 				goto report;
 			} else {
 				netdev_dbg(amt->dev, "Invalid MAC\n");
@@ -2536,6 +2649,18 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		}
 
 		spin_lock_bh(&tunnel->lock);
+		if (READ_ONCE(tunnel->dead)) {
+			spin_unlock_bh(&tunnel->lock);
+			return true;
+		}
+		/* Refresh liveness under tunnel->lock, where
+		 * amt_tunnel_expire() reads it; 0 is kept for a tunnel no
+		 * Update has refreshed.  gc_wq is re-armed by
+		 * amt_tunnel_expire() itself from last_seen, never from
+		 * here, so this cannot re-queue the work of a tunnel that is
+		 * being freed.
+		 */
+		tunnel->last_seen = jiffies ?: 1;
 		amt_igmp_report_handler(amt, skb, tunnel);
 		spin_unlock_bh(&tunnel->lock);
 
@@ -2556,6 +2681,11 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		}
 
 		spin_lock_bh(&tunnel->lock);
+		if (READ_ONCE(tunnel->dead)) {
+			spin_unlock_bh(&tunnel->lock);
+			return true;
+		}
+		tunnel->last_seen = jiffies ?: 1;
 		amt_mld_report_handler(amt, skb, tunnel);
 		spin_unlock_bh(&tunnel->lock);
 
@@ -3064,7 +3194,7 @@ static int amt_dev_open(struct net_device *dev)
 static int amt_dev_stop(struct net_device *dev)
 {
 	struct amt_dev *amt = netdev_priv(dev);
-	struct amt_tunnel_list *tunnel, *tmp;
+	struct amt_tunnel_list *tunnel;
 	struct sk_buff *skb;
 	struct sock *sk;
 	int i;
@@ -3098,11 +3228,37 @@ static int amt_dev_stop(struct net_device *dev)
 	amt->req_cnt = 0;
 	WRITE_ONCE(amt->remote_ip, 0);
 
-	list_for_each_entry_safe(tunnel, tmp, &amt->tunnel_list, list) {
-		list_del_rcu(&tunnel->list);
-		amt->nr_tunnels--;
+	/* Mark every tunnel dead first, so a concurrent amt_tunnel_expire()
+	 * sees ->dead and bails instead of freeing a tunnel in parallel; this
+	 * path is then the sole freer.
+	 */
+	spin_lock_bh(&amt->lock);
+	list_for_each_entry(tunnel, &amt->tunnel_list, list) {
+		spin_lock_bh(&tunnel->lock);
+		WRITE_ONCE(tunnel->dead, true);
+		spin_unlock_bh(&tunnel->lock);
+	}
+	spin_unlock_bh(&amt->lock);
+
+	/* Unlink one tunnel at a time with list_del_rcu() rather than splicing
+	 * the list onto a local head: a lockless reader walking tunnel_list
+	 * must always terminate at &amt->tunnel_list, never at a stack head.
+	 */
+	for (;;) {
+		spin_lock_bh(&amt->lock);
+		tunnel = list_first_entry_or_null(&amt->tunnel_list,
+						  struct amt_tunnel_list, list);
+		if (tunnel) {
+			list_del_rcu(&tunnel->list);
+			amt->nr_tunnels--;
+		}
+		spin_unlock_bh(&amt->lock);
+		if (!tunnel)
+			break;
+
 		cancel_delayed_work_sync(&tunnel->gc_wq);
 		amt_clear_groups(tunnel);
+		__amt_group_gc_work();
 		kfree_rcu(tunnel, rcu);
 	}
 
@@ -3480,11 +3636,17 @@ static int __init amt_init(void)
 	}
 
 	spin_lock_init(&source_gc_lock);
+	spin_lock_init(&group_gc_lock);
 	spin_lock_bh(&source_gc_lock);
 	INIT_DELAYED_WORK(&source_gc_wq, amt_source_gc_work);
 	mod_delayed_work(amt_wq, &source_gc_wq,
 			 msecs_to_jiffies(AMT_GC_INTERVAL));
 	spin_unlock_bh(&source_gc_lock);
+	spin_lock_bh(&group_gc_lock);
+	INIT_DELAYED_WORK(&group_gc_wq, amt_group_gc_work);
+	mod_delayed_work(amt_wq, &group_gc_wq,
+			 msecs_to_jiffies(AMT_GC_INTERVAL));
+	spin_unlock_bh(&group_gc_lock);
 
 	return 0;
 
@@ -3504,6 +3666,8 @@ static void __exit amt_fini(void)
 	unregister_netdevice_notifier(&amt_notifier_block);
 	cancel_delayed_work_sync(&source_gc_wq);
 	__amt_source_gc_work();
+	cancel_delayed_work_sync(&group_gc_wq);
+	__amt_group_gc_work();
 	destroy_workqueue(amt_wq);
 }
 module_exit(amt_fini);
diff --git a/include/net/amt.h b/include/net/amt.h
index 2846dde0c..568565793 100644
--- a/include/net/amt.h
+++ b/include/net/amt.h
@@ -240,6 +240,17 @@ struct amt_tunnel_list {
 	u32			nr_sources;
 	enum amt_status		status;
 	struct delayed_work	gc_wq;
+	/* Last time a Membership Update refreshed this tunnel, under ->lock.
+	 * gc_wq re-arms itself from this rather than being re-armed by the
+	 * Update path, so the Update path cannot re-queue the work of a
+	 * tunnel that amt_tunnel_expire() is freeing.
+	 */
+	unsigned long		last_seen;
+	/* Set under amt->lock and tunnel->lock by whichever freer reaches the
+	 * tunnel first; the other then leaves it alone, so the tunnel is freed
+	 * exactly once.
+	 */
+	bool			dead;
 	__be16			source_port;
 	__be32			ip4;
 	__be32			nonce;
@@ -275,6 +286,7 @@ enum amt_source_status {
 /* protected by gnode->lock */
 struct amt_source_node {
 	struct hlist_node	node;
+	struct hlist_node	gc_node;
 	struct amt_group_node	*gnode;
 	struct delayed_work     source_timer;
 	union amt_addr		source_addr;
@@ -282,6 +294,8 @@ struct amt_source_node {
 #define AMT_SOURCE_OLD	0
 #define AMT_SOURCE_NEW	1
 	u8			flags;
+	/* Protected by gnode->tunnel_list->lock. */
+	bool			dead;
 	struct rcu_head		rcu;
 };
 
@@ -295,7 +309,10 @@ struct amt_group_node {
 	u32			nr_sources;
 	struct amt_tunnel_list	*tunnel_list;
 	struct hlist_node	node;
+	struct hlist_node	gc_node;
 	struct delayed_work     group_timer;
+	/* Protected by tunnel_list->lock. */
+	bool			dead;
 	struct rcu_head		rcu;
 	struct hlist_head	sources[];
 };
-- 
2.43.0

