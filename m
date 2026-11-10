Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344747;
	b=P4p1XnlUVwu/ZlS+wn7Pe0FTM6PZgi9NoESiB7S0OGQFyPmQj3K18+RuGFJm+hd2ByzC
	 27mmlOogS1qm4LWdYatXF66epasOk9JHa2EkgxKVaSA7IFV60oX/DvfgzctP+qmy4oO63
	 i+CMrB82Ec7erNkhZ+apQbbnjxkCtL7J5GtXSfSFV7T+ls0IQZNwS9LOh6+CgQze6qvjh
	 fiOWtK9bmVzM/XafSaUCwh6rGfNZL2gksu5w0kWQhrsh3ZB6YuXbFqENVP/qhzpmNz3kc
	 r6e/MMasNJ6WhoI8GED5RLkmAHpbuBYzDzKHF+zePqemNGiPHUBL3M+QvEGJcTaRyQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=h+dfQQlag9pNfSKbdtf8zKlybrghYDxXM+sNxA+ytJ8=;
	b=ShG5AjKXbTtLj+mqaXSZo6TbO3BGlGE7VDQffONYGVVUyex+aLBE/ftA349eNcud+EqF
	 zCPOuXhzgc9zNA5B4j2CFTDleMpIi4v/ra03VEEPCewwFzkanVMQPxtzoUwA2yzZ49ZsG
	 8lcc1+RVbcHLXK+zI3jqkvu61ApPT/tNpcsyf6qyYOnDPRc6FBIiKxSuOu6L9Sc+Lvcis
	 MW9ItOcrssS9iTqfgMZjOXVt2xqrdEdukT0shak1Rw5S5DFG4NHl/FxKJclH36Gl/D/Tc
	 +IphIopm5WEkGOsZ3u9GrJxExQ0mvHDwUzcyhsxwLXX8+CuHtcMOoLFRZw+L6Ez/jrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=SMk47xsK;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9D60A2614
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 21:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21A9D60A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=SMk47xsK
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3282db206d3so1782216eec.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 10 Nov 2026 13:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344745; x=1794949545; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h+dfQQlag9pNfSKbdtf8zKlybrghYDxXM+sNxA+ytJ8=;
        b=SMk47xsK6dC/W4vfdLxei2X9mYf2Aav8d/r2QPvVbSXKzDqAbECACK1qIkgrtyDMIB
         5n4j8bGTMnb6F1fNQo3sHscvsYunpIoEyJ24jDnmwKQR2XKkxOYUEqiwzRrIZNXCffzO
         8Cw2+5Sspu08ysNEsY0CORdYxAQ9+rtAX/67aiTmPNjeIGF6QGZpnLFFguD2Wz4qsX/b
         BdqAb9dFmeVC04w4CSvDWXzRmEYh2ldlKunYaydeRvsGx5yozr2uuzzldSoYJnoKgatC
         YTyQ7R1VehjaQEvOB8lowPhyEbWBWpDRREZ4PuwKWMJBoxCIu6ixYOOzNBTL0aoV7RTT
         ho9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344745; x=1794949545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h+dfQQlag9pNfSKbdtf8zKlybrghYDxXM+sNxA+ytJ8=;
        b=yP1vICt8JWAMOk2oiTLQx9ByE0xa/e8lcRW/RHR7NtMvHeL0/hfHE+bJBK/6TREB1G
         qN2LrCDH+Ge7tNA37C9ZnuTMkDfPukY0t1HVfW24b74eADFxBvRmdP/kptC/2O5tR0vc
         GcI5q5iY3kxuAP9hxptheUoK3H8Cl6D2USigqqxehD/K86VB97mABkttlrxCIkIAUcXT
         e69abdYpRfAECSP88UTQqBG6Lv+CnrGpVptX0FgcqDJWlyX29b4p3XYtMmlUJveulaL1
         NpRHuogJL1qgY86Ox3FA6qxS6KtQxeh9e8y5NORerd8IkqWWwIJPpPbd2You9Y2Dj6I7
         tV4g==
X-Forwarded-Encrypted: i=1; AL+hErFMZO4kXR064jA0m7VauDtz+3Ub6sPJOPRsfANBtGb1gN9+Qs4tv3jVYQ6g3u3fXONyx2G6deQ1vivbetEdjg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8uDlT/xFxyJ3SWv/y2wmzZksV41zpjoZg/UrSXOn9Uu3prv/vX
	R+9LU497q9D/+Q8i+BDe5+gjHzxv6d3O3yXqhWJ37Wxv4hTW9w0nZgHj2weqxYl0DrY=
X-Gm-Gg: AYBFou0VH4t4FQ6QEdoQyY6cvJV7GENO6cVna4XJBHwoElWGXTgFD52f9Z0pPPK4g+N
	27+Y1Dx2o7KFJYEHLNFE7XhV/AQT29Ux1OL+n1EDeOwB68fIcVTvSsNnzXugXNKQ5mIpRgTPLaN
	4k7fwO3XVh7X6WeEKXgLQvmBdsZ6P2yBtGQJJxTHDPWI/oKzMxDZyI/nFWKx4hIaOBZk3KWZDZH
	lrG3E4sBoq6rKEL15bfNNgOzIytycAtd8Ey4aCR0KH+M/8yQud6uSdcd3IjJsbL18D1CMGN4LSh
	ju6RmsgGuDBHhzBYT5VuXQT3BlDksBattR9jOlRh6ambK8KM03wB4nicAaGlLT9Fir8Y1VSzdcW
	g1L4iHdc2SrqnCurxOOoQIPyG9OuN2huqXskNBWZ72i5RoHGIRpxCad/v66kL6AZRYT5DjZzR4k
	xCf3k5qP5Ta3CbhMOAABXFmt1WJdGhfkfB5LlvNgR8tkDgFSnTHhvgf1mD0pIWtGzZt6QM+BLgH
	9g1O49WSokoZErTTxXf7qUTxca1v84fJkqM7RMCK9CoNCT8NjWxEFkMZB9dSgdu1Czw9Ka0/PjQ
	/kzAtGr+0SRHfaJgT61lRg/nK1K+RsDJNWNxbg3mfer5fUdemqMHcuPRrwcVn/5dXpPmVTQ=
X-Received: by 2002:a05:7301:4d18:b0:375:a6b1:7366 with SMTP id 5a478bee46e88-376852c7b2dmr716353eec.12.1794344744597;
        Tue, 10 Nov 2026 13:05:44 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm10464097eec.17.2026.11.10.13.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:05:43 -0800 (PST)
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
Subject: [PATCH net v7 2/6] amt: fix use-after-free when a Membership Update re-arms a freed tunnel
Date: Tue, 10 Nov 2026 21:05:33 +0000
Message-ID: <20261110210538.217936-3-omar@blockcast.net>
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

amt_update_handler() refreshes a relay tunnel's garbage-collection timer
with mod_delayed_work() on a tunnel found by an RCU walk. A concurrent
amt_tunnel_expire() can unlink and free that tunnel while the Update path
still has the cached pointer, leaving gc_wq armed in freed memory.

A tunnel can also be freed twice. amt_dev_stop() unlinks and frees
tunnels without amt->lock, while amt_tunnel_expire() unlinks and frees
them under it, so an ifdown that races a tunnel timeout can run
list_del_rcu() and kfree_rcu() on the same tunnel twice.

Group and source nodes have lifetime bugs of their own:

- __amt_source_gc_work() frees a source, and amt_del_group() a group,
  after only cancel_delayed_work(), which does not wait for a timer work
  that is already running. amt_source_work() or amt_group_work() can
  then run on the freed node.
- amt_source_work() reads snode->gnode and gnode->tunnel_list, and
  amt_group_work() gnode->tunnel_list, before taking tunnel->lock or the
  RCU read lock, so either can follow a pointer to a group or tunnel
  that has already been freed.
- A timer work that waits for tunnel->lock while its node is deleted can
  then act on the deleted node: amt_source_work() destroys the source
  again, or amt_group_work() deletes the group again. Either decrements
  nr_sources or nr_groups a second time and unlinks, queues or frees the
  node a second time.

Make amt_tunnel_expire() the only timeout-path freer. The Update path
records last_seen under tunnel->lock, and expire reads it under
tunnel->lock and, in the same section, either re-arms gc_wq from it or
marks the tunnel dead for freeing, so an Update either keeps the tunnel
alive or finds it dead. Protect the dead state with tunnel->lock so
report handling cannot add multicast state after teardown begins.
Device stop marks tunnels dead under amt->lock, unlinks them one at a
time under it, synchronously cancels their work, and frees them after
lockless readers have passed.

Apply the same lifetime rules to group and source timer work: mark nodes
dead under tunnel->lock, keep RCU held while workers resolve their
parents, clear the parent pointers before a node is queued for freeing,
defer node freeing, and synchronously cancel each node's timer before
freeing that node. Park sources and groups through a gc_node of their
own. A destroyed source used to reuse snode->node, its link into the
group's hash; no lockless reader is known to follow it onto the GC list,
so this is hardening. Run the deferred GC directly before freeing a
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

A node on a GC list is no longer charged to max_groups or max_sources,
and unless a tunnel expires or the device stops, only the periodic GC
drains the lists, every 30 seconds. Sources were already parked that
way; groups, which went to kfree_rcu() before, now are too, so
Report/Leave churn from one gateway could pin memory without bound in
between. Count the nodes parked on both lists, under the one lock that
now protects both, and when the count reaches AMT_GC_KICK (2048) queue
the drain of both lists at once. A parked group still holds its
AMT_HSIZE (256) source hash heads, so it is a kmalloc-4k object, and
2048 of them is about 8 MiB; the kick keeps the backlog near that
instead of letting it grow for up to 30 seconds. A periodic drain that
ends with that many parked again runs again at once rather than after
the interval. This also bounds what amt_dev_stop() has to free in its
drain under RTNL, and both drains now call cond_resched() after each
node.

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
to arrive while amt_tunnel_expire() is freeing that tunnel. Review of
later postings raised the races in the group and source timer work, the
amt_dev_stop() double free and the unbounded GC lists. I have not
triggered any of them, so there is no trace to include.

Fixes: cbc21dc1cfe9 ("amt: add data plane of amt interface")
Fixes: bc54e49c140b ("amt: add multicast(IGMP) report message handler")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 239 +++++++++++++++++++++++++++++++++++++++++-----
 include/net/amt.h |  18 ++++
 2 files changed, 232 insertions(+), 25 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 3a703b79f..fc3900e25 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -35,9 +35,19 @@
 static struct workqueue_struct *amt_wq;
 
 static HLIST_HEAD(source_gc_list);
-/* Lock for source_gc_list */
+/* Lock for source_gc_list, group_gc_list and the counts below */
 static spinlock_t source_gc_lock;
 static struct delayed_work source_gc_wq;
+static HLIST_HEAD(group_gc_list);
+static struct delayed_work group_gc_wq;
+/* Nodes parked on source_gc_list and group_gc_list, and the sources among
+ * them, so that a drain of either list can take its nodes off the count.
+ * Parked nodes are not charged to max_groups or max_sources, so
+ * Report/Leave churn could park them faster than the AMT_GC_INTERVAL tick
+ * frees them: once AMT_GC_KICK are parked, the drain runs at once.
+ */
+static unsigned int amt_gc_queued;
+static unsigned int amt_gc_sources;
 static char *status_str[] = {
 	"AMT_STATUS_INIT",
 	"AMT_STATUS_SENT_DISCOVERY",
@@ -88,11 +98,15 @@ static void __amt_source_gc_work(void)
 
 	spin_lock_bh(&source_gc_lock);
 	hlist_move_list(&source_gc_list, &gc_list);
+	amt_gc_queued -= amt_gc_sources;
+	amt_gc_sources = 0;
 	spin_unlock_bh(&source_gc_lock);
 
-	hlist_for_each_entry_safe(snode, t, &gc_list, node) {
-		hlist_del_rcu(&snode->node);
+	hlist_for_each_entry_safe(snode, t, &gc_list, gc_node) {
+		cancel_delayed_work_sync(&snode->source_timer);
+		hlist_del_init(&snode->gc_node);
 		kfree_rcu(snode, rcu);
+		cond_resched();
 	}
 }
 
@@ -106,6 +120,62 @@ static void amt_source_gc_work(struct work_struct *work)
 	spin_unlock_bh(&source_gc_lock);
 }
 
+static void __amt_group_gc_work(void)
+{
+	struct amt_group_node *gnode;
+	struct hlist_head gc_list;
+	struct hlist_node *t;
+
+	spin_lock_bh(&source_gc_lock);
+	hlist_move_list(&group_gc_list, &gc_list);
+	amt_gc_queued = amt_gc_sources;
+	spin_unlock_bh(&source_gc_lock);
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
+		cond_resched();
+	}
+}
+
+static void amt_group_gc_work(struct work_struct *work)
+{
+	__amt_group_gc_work();
+
+	/* Run again at once if AMT_GC_KICK nodes were parked meanwhile: a
+	 * kick that landed during the drain must not be pushed back to the
+	 * interval.
+	 */
+	spin_lock_bh(&source_gc_lock);
+	mod_delayed_work(amt_wq, &group_gc_wq,
+			 amt_gc_queued >= AMT_GC_KICK ? 0 :
+			 msecs_to_jiffies(AMT_GC_INTERVAL));
+	spin_unlock_bh(&source_gc_lock);
+}
+
+/* Caller holds source_gc_lock and has just parked one node.  This runs
+ * under tunnel->lock, often in softirq; mod_delayed_work() does not sleep.
+ */
+static void amt_gc_parked(void)
+{
+	if (++amt_gc_queued == AMT_GC_KICK)
+		mod_delayed_work(amt_wq, &group_gc_wq, 0);
+}
+
 static bool amt_addr_equal(union amt_addr *a, union amt_addr *b)
 {
 	return !memcmp(a, b, sizeof(union amt_addr));
@@ -215,8 +285,13 @@ static struct amt_group_node *amt_lookup_group(struct amt_tunnel_list *tunnel,
 
 static void amt_destroy_source(struct amt_source_node *snode)
 {
-	struct amt_group_node *gnode = snode->gnode;
 	struct amt_tunnel_list *tunnel;
+	struct amt_group_node *gnode;
+
+	if (snode->dead)
+		return;
+	snode->dead = true;
+	gnode = snode->gnode;
 
 	tunnel = gnode->tunnel_list;
 
@@ -238,8 +313,11 @@ static void amt_destroy_source(struct amt_source_node *snode)
 	hlist_del_init_rcu(&snode->node);
 	tunnel->nr_sources--;
 	gnode->nr_sources--;
+	WRITE_ONCE(snode->gnode, NULL);
 	spin_lock_bh(&source_gc_lock);
-	hlist_add_head_rcu(&snode->node, &source_gc_list);
+	hlist_add_head(&snode->gc_node, &source_gc_list);
+	amt_gc_sources++;
+	amt_gc_parked();
 	spin_unlock_bh(&source_gc_lock);
 }
 
@@ -249,6 +327,9 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 	struct hlist_node *t;
 	int i;
 
+	if (gnode->dead)
+		return;
+	gnode->dead = true;
 	if (cancel_delayed_work(&gnode->group_timer))
 		dev_put(amt->dev);
 	hlist_del_rcu(&gnode->node);
@@ -266,10 +347,11 @@ static void amt_del_group(struct amt_dev *amt, struct amt_group_node *gnode)
 		hlist_for_each_entry_safe(snode, t, &gnode->sources[i], node)
 			amt_destroy_source(snode);
 
-	/* tunnel->lock was acquired outside of amt_del_group()
-	 * But rcu_read_lock() was acquired too so It's safe.
-	 */
-	kfree_rcu(gnode, rcu);
+	WRITE_ONCE(gnode->tunnel_list, NULL);
+	spin_lock_bh(&source_gc_lock);
+	hlist_add_head(&gnode->gc_node, &group_gc_list);
+	amt_gc_parked();
+	spin_unlock_bh(&source_gc_lock);
 }
 
 /* If a source timer expires with a router filter-mode for the group of
@@ -282,13 +364,28 @@ static void amt_source_work(struct work_struct *work)
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
+	amt = gnode->amt;
+	tunnel = READ_ONCE(gnode->tunnel_list);
+	if (!tunnel) {
+		rcu_read_unlock();
+		return;
+	}
+	spin_lock_bh(&tunnel->lock);
+	if (snode->dead || gnode->dead) {
+		spin_unlock_bh(&tunnel->lock);
+		rcu_read_unlock();
+		return;
+	}
 	if (gnode->filter_mode == MCAST_INCLUDE) {
 		amt_destroy_source(snode);
 		if (!gnode->nr_sources)
@@ -299,8 +396,8 @@ static void amt_source_work(struct work_struct *work)
 		 */
 		snode->status = AMT_SOURCE_STATUS_D_FWD;
 	}
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
+	rcu_read_unlock();
 }
 
 static void amt_act_src(struct amt_tunnel_list *tunnel,
@@ -368,6 +465,7 @@ static struct amt_source_node *amt_alloc_snode(struct amt_group_node *gnode,
 	snode->status = AMT_SOURCE_STATUS_NONE;
 	snode->flags = AMT_SOURCE_NEW;
 	INIT_HLIST_NODE(&snode->node);
+	INIT_HLIST_NODE(&snode->gc_node);
 	INIT_DELAYED_WORK(&snode->source_timer, amt_source_work);
 
 	return snode;
@@ -403,23 +501,31 @@ static void amt_group_work(struct work_struct *work)
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
+	amt = gnode->amt;
+	if (!tunnel)
+		goto out;
 	buckets = amt->hash_buckets;
 
 	spin_lock_bh(&tunnel->lock);
+	if (gnode->dead) {
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
@@ -436,9 +542,9 @@ static void amt_group_work(struct work_struct *work)
 		amt_del_group(amt, gnode);
 	else
 		gnode->filter_mode = MCAST_INCLUDE;
-	rcu_read_unlock();
 	spin_unlock_bh(&tunnel->lock);
 out:
+	rcu_read_unlock();
 	dev_put(amt->dev);
 }
 
@@ -479,6 +585,7 @@ static struct amt_group_node *amt_add_group(struct amt_dev *amt,
 	gnode->tunnel_list = tunnel;
 	gnode->filter_mode = MCAST_INCLUDE;
 	INIT_HLIST_NODE(&gnode->node);
+	INIT_HLIST_NODE(&gnode->gc_node);
 	INIT_DELAYED_WORK(&gnode->group_timer, amt_group_work);
 	for (i = 0; i < amt->hash_buckets; i++)
 		INIT_HLIST_HEAD(&gnode->sources[i]);
@@ -1342,14 +1449,51 @@ static void amt_tunnel_expire(struct work_struct *work)
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
 
@@ -2508,9 +2652,6 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		if (tunnel->ip4 == saddr) {
 			if ((nonce == tunnel->nonce &&
 			     response_mac == tunnel->mac)) {
-				mod_delayed_work(amt_wq, &tunnel->gc_wq,
-						 msecs_to_jiffies(amt_gmi(amt))
-								  * 3);
 				goto report;
 			} else {
 				netdev_dbg(amt->dev, "Invalid MAC\n");
@@ -2536,6 +2677,18 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
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
 
@@ -2556,6 +2709,11 @@ static bool amt_update_handler(struct amt_dev *amt, struct sk_buff *skb)
 		}
 
 		spin_lock_bh(&tunnel->lock);
+		if (READ_ONCE(tunnel->dead)) {
+			spin_unlock_bh(&tunnel->lock);
+			return true;
+		}
+		tunnel->last_seen = jiffies ?: 1;
 		amt_mld_report_handler(amt, skb, tunnel);
 		spin_unlock_bh(&tunnel->lock);
 
@@ -3064,7 +3222,7 @@ static int amt_dev_open(struct net_device *dev)
 static int amt_dev_stop(struct net_device *dev)
 {
 	struct amt_dev *amt = netdev_priv(dev);
-	struct amt_tunnel_list *tunnel, *tmp;
+	struct amt_tunnel_list *tunnel;
 	struct sk_buff *skb;
 	struct sock *sk;
 	int i;
@@ -3098,11 +3256,37 @@ static int amt_dev_stop(struct net_device *dev)
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
 
@@ -3484,6 +3668,9 @@ static int __init amt_init(void)
 	INIT_DELAYED_WORK(&source_gc_wq, amt_source_gc_work);
 	mod_delayed_work(amt_wq, &source_gc_wq,
 			 msecs_to_jiffies(AMT_GC_INTERVAL));
+	INIT_DELAYED_WORK(&group_gc_wq, amt_group_gc_work);
+	mod_delayed_work(amt_wq, &group_gc_wq,
+			 msecs_to_jiffies(AMT_GC_INTERVAL));
 	spin_unlock_bh(&source_gc_lock);
 
 	return 0;
@@ -3504,6 +3691,8 @@ static void __exit amt_fini(void)
 	unregister_netdevice_notifier(&amt_notifier_block);
 	cancel_delayed_work_sync(&source_gc_wq);
 	__amt_source_gc_work();
+	cancel_delayed_work_sync(&group_gc_wq);
+	__amt_group_gc_work();
 	destroy_workqueue(amt_wq);
 }
 module_exit(amt_fini);
diff --git a/include/net/amt.h b/include/net/amt.h
index 2846dde0c..dedf328d8 100644
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
@@ -370,6 +387,7 @@ struct amt_dev {
 #define AMT_IPHDR_OPTS		4
 #define AMT_IP6HDR_OPTS		8
 #define AMT_GC_INTERVAL		(30 * 1000)
+#define AMT_GC_KICK		2048
 #define AMT_MAX_GROUP		32
 #define AMT_MAX_SOURCE		128
 #define AMT_HSIZE_SHIFT		8
-- 
2.43.0

