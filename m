Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852462;
	b=qtLNb90NOpfJAgHldeeqir6T8f33Jk9aQbSpjaA26xO+ImEq+TvgIE5IvBB7iIGoSU7T
	 FkzpBkTjxX7H2ckjEzXXJvfK5kZxXfiWfQolSX4zDeAQNBhqGf91lgYJ16EbUhdXrSSnO
	 FmWlToWuV5ZLe7UKXWO8n3zUjeauuKOQ6QrkTiz+c5yIX9PK76Bd+F4xHqXm+B4CqlkNV
	 /4lVzIHrmLHzJQeOjAi6YsJG4klVN4rZEO4ymEkcpCjLhJBTUHom0EShiuw9p76wrpDpL
	 PPIxXLFaORhStq40+swecFqf7LwAxq1XkUieBn8U/Qj4jQ6JOygqlp8P0AoG6UpQWHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852462;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=W+eqI9m4/rpbzlI1PbhY9iYUUULZb5r6I0esvttZ1gs=;
	b=x5glkkEQnrhu6G93xNBmwiuvnDDkiS4rWr6VpcxBllP7FJkWXbWdTGpvMqO52h7d2cNc
	 85YaIAAXE47UCr7epob69djb71kGFc9jKCxmzcQnAK0szrIIxXT5dKKfvSqIQisZH/Gwv
	 3wauVuYfZXPhYS4buGlujKF7dNXYCyx9o1qkkcPVZwpYAtFvm4j7TOWgoXntetsNeJ2EG
	 vMTl/lPaazMi5ekDAP1CvBXqrDaeIOTJaYV8qAcoTp/7cEr9PTS/pury6R8+MZbYNEsBu
	 SRGG02D5xFDA9EhVI3xiDqLNnlywuNIwvnNoX+i/PwOkmIW1jXHgC6ZByHlUdiI9B9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=UA9tlo9G;
	arc=none smtp.remote-ip=209.85.219.51
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6C5606A32E
	for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 14:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C6C5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=UA9tlo9G
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-91986c5cb75so17704906d6.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 24 Oct 2026 07:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1792852461; x=1793457261; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W+eqI9m4/rpbzlI1PbhY9iYUUULZb5r6I0esvttZ1gs=;
        b=UA9tlo9GZFyBAxfKy4ljYn2D9JULSA6de3V2DCF4dvWiyzsbPIrZQTNNVhVzSa8Z8C
         bhTbG8/tN2CwTCD587bBbDz19zEaj0OcdCZegJqDcjX7t3/x1fTiZpKTLIdbECD+NNgi
         Ntk3hH6msH5//O6reR8G/7ii/q6Alvi1fDAiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792852461; x=1793457261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W+eqI9m4/rpbzlI1PbhY9iYUUULZb5r6I0esvttZ1gs=;
        b=110Ww8DaWx6rP2i6cWlr5D4oD7PLFXd4NvWSPzRX0KZ4dBtNJauOE2Lt3Tz/T8MqAh
         b179fMZr0CYjT05KXLkaezFC1y3iSo3jPewVdXNle2vswmaL879cEzn0epgJqHFJIgmg
         aalG8121RbwEsv3tKLWApy/gsKg95OH/ZvBBWUpR3qURxyv2LvgfmKJdZ/Q2sKG1KpEa
         /VrK6BnRQ+pi5Xu4g+Iu8lZ4sBJODvWoZa6KYVpZyo7/ACibjzD8hgmbGSwG7ESqU4FU
         VejFuUj3uxOmLS24bBRrBgXbTDUL3AJwHfum7GQ4B0DxcBjOpePZvQyPEaD0Tz1yL0fR
         MifA==
X-Forwarded-Encrypted: i=1; AKwUvByNC9b7dN71QEW3TqMfozbVKTUMg57d2UcyGrkBUOPF7JKzYwS5eLyHM5s3bNtes4j3YFvCQKFcf3yn26g2gQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIPes6TF3bTOqr+b8VFxdd3e4x6Nb/ynHS6vd3sCazxEOwTlXvI
	rTLq0hxIeiu8GomDOp/CCcAGJmBvrGn7/CGWF8PjsAlTf8kHXfWf0h/2pPCtr4kYtw==
X-Gm-Gg: AYBFou3WPeGQBvQKFGBI03xeugAj9aEsfMTm7WPDL7zFixKNmV24Ob+fh7mB31g3qoc
	S9/8umICFRyBD8pZGXmtzLWWXk3MzetHugUKmuFzgpGwAerpZDLaXgEa4QN7ItCSjenTHnkRVxB
	rRBY7wWKHFtBuMdFRt/29qj9GAonRkcx6JfGvwzYZAZKsxRTN149gvBHGFbbgjOyDabV7CIUxn+
	34pc1lJdyPAQEgwopyuPaqoEARBNNTmCXnYG3KJcP9RsoWrROM/0cDJlernyBcL54Ys7TVk96tv
	DytcP9TzVuSSac+J7SuJVwCQHVGcBMbqxcllgJIMAEDkSZKJ/ssK2t53adxfB9aehyoFkv7w1tw
	5cl9el8Diuyxryb6wia+gbq97OhI7jGgbyLmh0vClYiqS1j9IJcK9t3KOeLHEtg+y9qBOzQWed6
	vm75PO9HYg06ZFzWvn4OLEppYhrOFcnpHmCsDBdMWOh6Z116dZlL14GrUp4eogpqVGuD8KkBPZ2
	VVTVtWbUpgtqCH8NDo9iU+dptSZizqb2XCX6JdR4TUZHOAsIaSXrPyFqlC//PVYLWzPr+6MWEk0
	f+IqW14/mpWkBbZ0J4AezhXR1TiVljOly5EQiSf/Xg==
X-Received: by 2002:a05:6214:590c:b0:917:fadc:2f21 with SMTP id 6a1803df08f44-91c48e9071bmr27088566d6.41.1792852461246;
        Sat, 24 Oct 2026 07:34:21 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd5b65sm22397466d6.10.2026.10.24.07.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 07:34:20 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	zdi-disclosures@trendmicro.com
Subject: [PATCH net v2 1/2] net/sched: sch_teql: fix slaves_lock IRQ deadlock
Date: Sat, 24 Oct 2026 10:34:14 -0400
Message-Id: <QDISC-Y0BY.v2.r0.20261024060625-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com>
References: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com>
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

This is a followup of commit e5b811fe7931 ("net/sched: sch_teql:
Introduce slaves_lock to avoid race condition and UAF") as reported by
Sashiko.

The issue: master->slaves_lock serializes the master's ring of slave
qdiscs.  The control paths -- teql_dequeue(), teql_destroy() and
teql_qdisc_init() -- take it with spin_lock_bh(), while
teql_master_xmit() (the master's ndo_start_xmit) takes it with plain
spin_lock().

netpoll_send_skb() wraps the transmit in local_irq_save(), and
__netpoll_send_skb() asserts lockdep_assert_irqs_disabled(), so
teql_master_xmit() reached from netconsole always acquires slaves_lock
with hard IRQs disabled.  On PREEMPT_RT spinlock_t is an rtmutex, and
Documentation/locking/locktypes.rst names

	local_irq_disable();
	spin_lock(&lock);

as a sequence that breaks there because the rtmutex requires a fully
preemptible context.  This is reachable without any panic: the nbcon
printer thread calls netconsole's write_thread() callback on every
message.  The usual remedy -- folding the IRQ disable into the lock with
spin_lock_irqsave() -- is unavailable because the local_irq_save() is
netpoll's, not ours.

On non-RT the same asymmetry leaves slaves_lock acquirable with hard IRQs
disabled on one path and held with hard IRQs enabled on another.  That is
only exploitable during the panic console flush (netconsole is
CON_NBCON_ATOMIC_UNSAFE, so console_is_usable() admits its write_atomic()
only from nbcon_atomic_flush_unsafe(), which panic() alone calls), and
even then an IRQ-saving lock does not help if the holder oopsed inside the
section or was stopped by panic_other_cpus_shutdown().  So the non-RT half
is hardening; the PREEMPT_RT half is the bug.

The Fix: take slaves_lock as a raw spinlock with IRQs saved at every
site.  Since skb_queue_purge() takes the queue's spinlock_t and may not
nest inside a raw lock on PREEMPT_RT, move its call in teql_destroy()
outside the raw section; dat->q is the dying qdisc's own queue and was
never serialized by slaves_lock, so the move is behaviour-neutral.

The new critical sections contain only RCU pointer assignments and
netdev_get_tx_queue(); skb_queue_purge(), netif_wake_queue() and
dev_reset_queue() are all outside them.  teql_destroy()'s ring walk is
O(slaves), two pointer loads and a compare per iteration, so even a large
ring is microseconds with IRQs off.  Keeping the purge conditional rather
than dropping it outright is the conservative call for a backport.

Some context: commit 6301f6a34ed8 ("net/sched: sch_teql: move
rcu_read_lock()/spin_lock() from _bh variants") hardened the parent
fix; together they addressed the master->slaves resurrection
use-after-free and the xmit-side BH warning but left the reverse
direction -- a hard IRQ re-entering xmit while a control path holds the
lock -- unaddressed.

Conditions to recreate the bug:
- CONFIG_PREEMPT_RT, CONFIG_NET_SCH_TEQL, CONFIG_DUMMY and
  CONFIG_NETCONSOLE.
- Run `ip link add dev teqlslave0 type dummy`, bring teqlslave0 up, attach
  it with `tc qdisc add dev teqlslave0 root teql0`, and bring teql0 up.
- Configure a netconsole target on teql0 with explicit local and remote
  IP addresses and a remote MAC address, then emit a console message.
  The nbcon printer thread reaches teql_master_xmit() with hard IRQs
  disabled by netpoll; taking slaves_lock as a spinlock_t is invalid on
  PREEMPT_RT. No panic or concurrent qdisc change is required.
- Reachable by an admin with CAP_NET_ADMIN; teql devices exist only in the
  initial netns (no per-netns ops), so a user namespace does not suffice.

Fixes: e5b811fe7931 ("net/sched: sch_teql: Introduce slaves_lock to avoid race condition and UAF")
Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260630150922.238714-1-jhs%40mojatatu.com
Link: https://lore.kernel.org/netdev/20260630150922.238714-1-jhs@mojatatu.com/
Cc: stable@vger.kernel.org
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---

 net/sched/sch_teql.c | 45 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index 409ce50cc0db..c7dcec25ef42 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -53,7 +53,7 @@ struct teql_master {
 	struct Qdisc_ops qops;
 	struct net_device *dev;
 	struct Qdisc __rcu	*slaves;
-	spinlock_t		slaves_lock; /* serializes writes to ->slaves */
+	raw_spinlock_t		slaves_lock; /* serializes writes to ->slaves */
 	struct list_head master_list;
 	unsigned long	tx_bytes;
 	unsigned long	tx_packets;
@@ -92,6 +92,7 @@ teql_dequeue(struct Qdisc *sch)
 {
 	struct teql_sched_data *dat = qdisc_priv(sch);
 	struct netdev_queue *dat_queue;
+	unsigned long flags;
 	struct sk_buff *skb;
 	struct Qdisc *q;
 
@@ -102,9 +103,9 @@ teql_dequeue(struct Qdisc *sch)
 	if (skb == NULL) {
 		struct net_device *m = qdisc_dev(q);
 		if (m) {
-			spin_lock_bh(&dat->m->slaves_lock);
+			raw_spin_lock_irqsave(&dat->m->slaves_lock, flags);
 			rcu_assign_pointer(dat->m->slaves, sch);
-			spin_unlock_bh(&dat->m->slaves_lock);
+			raw_spin_unlock_irqrestore(&dat->m->slaves_lock, flags);
 			netif_wake_queue(m);
 		}
 	} else {
@@ -137,11 +138,13 @@ teql_destroy(struct Qdisc *sch)
 	struct teql_master *master = dat->m;
 	struct netdev_queue *txq = NULL;
 	bool reset_master_queue = false;
+	unsigned long flags;
+	bool purge = false;
 
 	if (!master)
 		return;
 
-	spin_lock_bh(&master->slaves_lock);
+	raw_spin_lock_irqsave(&master->slaves_lock, flags);
 	prev = rcu_dereference_protected(master->slaves,
 					 lockdep_is_held(&master->slaves_lock));
 	if (prev) {
@@ -169,12 +172,18 @@ teql_destroy(struct Qdisc *sch)
 					reset_master_queue = true;
 				}
 			}
-			skb_queue_purge(&dat->q);
+			purge = true;
 			break;
 		} while (prev != rcu_dereference_protected(master->slaves,
 							   lockdep_is_held(&master->slaves_lock)));
 	}
-	spin_unlock_bh(&master->slaves_lock);
+	raw_spin_unlock_irqrestore(&master->slaves_lock, flags);
+
+	/* skb_queue_purge() takes the queue's spinlock_t, which cannot nest
+	 * inside a raw lock on PREEMPT_RT; purge after the raw section.
+	 */
+	if (purge)
+		skb_queue_purge(&dat->q);
 
 	if (reset_master_queue)
 		dev_reset_queue(master->dev, txq, NULL);
@@ -187,6 +196,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 	struct teql_master *m = (struct teql_master *)sch->ops;
 	struct teql_sched_data *q = qdisc_priv(sch);
 	struct Qdisc *first;
+	unsigned long flags;
 
 	if (dev->hard_header_len > m->dev->hard_header_len)
 		return -EINVAL;
@@ -203,7 +213,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 
 	skb_queue_head_init(&q->q);
 
-	spin_lock_bh(&m->slaves_lock);
+	raw_spin_lock_irqsave(&m->slaves_lock, flags);
 	first = rcu_dereference_protected(m->slaves, lockdep_is_held(&m->slaves_lock));
 	if (first) {
 		if (m->dev->flags & IFF_UP) {
@@ -214,7 +224,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 			    (m->dev->flags & IFF_MULTICAST &&
 			     !(dev->flags & IFF_MULTICAST)) ||
 			    dev->mtu < m->dev->mtu) {
-				spin_unlock_bh(&m->slaves_lock);
+				raw_spin_unlock_irqrestore(&m->slaves_lock, flags);
 				return -EINVAL;
 			}
 		} else {
@@ -237,7 +247,7 @@ static int teql_qdisc_init(struct Qdisc *sch, struct nlattr *opt,
 		m->dev->mtu = dev->mtu;
 		m->dev->flags = (m->dev->flags&~FMASK)|(dev->flags&FMASK);
 	}
-	spin_unlock_bh(&m->slaves_lock);
+	raw_spin_unlock_irqrestore(&m->slaves_lock, flags);
 	return 0;
 }
 
@@ -302,11 +312,12 @@ static inline int teql_resolve(struct sk_buff *skb,
 static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct teql_master *master = netdev_priv(dev);
-	struct Qdisc *start, *q;
-	int busy;
-	int nores;
 	int subq = skb_get_queue_mapping(skb);
 	struct sk_buff *skb_res = NULL;
+	struct Qdisc *start, *q;
+	unsigned long flags;
+	int nores;
+	int busy;
 
 restart:
 	nores = 0;
@@ -342,13 +353,13 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				    netdev_start_xmit(skb, slave, slave_txq, false) ==
 				    NETDEV_TX_OK) {
 					__netif_tx_unlock(slave_txq);
-					spin_lock(&master->slaves_lock);
+					raw_spin_lock_irqsave(&master->slaves_lock, flags);
 					if (rcu_dereference_protected(master->slaves,
 								      lockdep_is_held(&master->slaves_lock)) == q)
 						rcu_assign_pointer(master->slaves,
 								   rcu_dereference_protected(NEXT_SLAVE(q),
 											     lockdep_is_held(&master->slaves_lock)));
-					spin_unlock(&master->slaves_lock);
+					raw_spin_unlock_irqrestore(&master->slaves_lock, flags);
 					netif_wake_queue(dev);
 					master->tx_packets++;
 					master->tx_bytes += length;
@@ -361,13 +372,13 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
 				busy = 1;
 			break;
 		case 1:
-			spin_lock(&master->slaves_lock);
+			raw_spin_lock_irqsave(&master->slaves_lock, flags);
 			if (rcu_dereference_protected(master->slaves,
 						      lockdep_is_held(&master->slaves_lock)) == q)
 				rcu_assign_pointer(master->slaves,
 						   rcu_dereference_protected(NEXT_SLAVE(q),
 									     lockdep_is_held(&master->slaves_lock)));
-			spin_unlock(&master->slaves_lock);
+			raw_spin_unlock_irqrestore(&master->slaves_lock, flags);
 			rcu_read_unlock();
 			return NETDEV_TX_OK;
 		default:
@@ -489,7 +500,7 @@ static __init void teql_master_setup(struct net_device *dev)
 	struct teql_master *master = netdev_priv(dev);
 	struct Qdisc_ops *ops = &master->qops;
 
-	spin_lock_init(&master->slaves_lock);
+	raw_spin_lock_init(&master->slaves_lock);
 	master->dev	= dev;
 	ops->priv_size  = sizeof(struct teql_sched_data);
 
-- 
2.43.0
