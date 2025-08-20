Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F4A2E03FF
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 Aug 2025 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686222; cv=none; b=eVqfZmrj31M+MFjIaItfRzDkt0ZKZODPRYRnfsQFf2zEay/Boh6Z16uThRIbWMzAhRE+NyOrTHLm15zYZOQ1cMQ7u/5YCIokB1jn2gKR60rp50oZWgWwyOVkalo90DKtJOhK83ZVJMOAA24JTtUnrPGl25scHtEmPOcgLYemBsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686222; c=relaxed/simple;
	bh=kv3W/G1ARmOcJJTz/9sGIEr4fqmIvswblhhL9o40NPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5Z32HiXW7ptSwGehindOxZEG4DPvMK4JJ5Pa3yor1hK1aSHC4gAzFCUZ838D4DF6hkSPK6pKHmiYWkg79UOTe0+yNkgJYYXXWTNXvsIbiN9llNK60KVjZ8Vx3LtC5H4WySZuXzRvu+pR3CCHWxbgjOeePwNG83xm/N/qUal9xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n1keIyXP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b8KVD0rv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n1keIyXP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b8KVD0rv"
Date: Wed, 20 Aug 2025 12:36:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755686219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUAcx2/jO8NfEFGgnI4HZ0vELTMmQeqDK1jIGQqE9hE=;
	b=n1keIyXP4kJDwb2X6G/j4BoY+EWoUdgKQs1UzgEhRMjD6wnbIahKcscOgTiZX2Nyn/kOa6
	gaUdCDRguSYujJ/m5vSsEC+f+s8dAlgveIMUAVxHFEMFPe6eXfLltqWSLNzAuzs00bDrLb
	HFQDBp+xpGYdOJlAyKIlkXGq34aBdhH9fD1vvvbBEa4XN3FuStiROsw9CxMOG9I6hscytY
	gymqdKy3MYyQlWaWt/rPbv5Ha6s8l5xBYEuO4Wyi7DM6+jh2g/e0f++8zxZRDkJpNxn+UI
	+4L9NVp43rdlixKlD3hFF1b7slcVE95iqb9Vp3fINhlXKwS4M4v8jNsrNf+FYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755686219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yUAcx2/jO8NfEFGgnI4HZ0vELTMmQeqDK1jIGQqE9hE=;
	b=b8KVD0rvSA6QxdRuN7k4RM6lpdvanrn106bPzO9cPmxBCEKD1olS2bTNpxPg7fis0/4TyQ
	IX4tZoltKy+L31Dw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <20250820103657.vDuDuLx6@linutronix.de>
References: <20250812143930.22RBn5BW@linutronix.de>
 <20250812145359.QMcaYh9g@linutronix.de>
 <aJuYStGVBjyfVmZM@slm.duckdns.org>
 <20250813063311.33m0TDKl@linutronix.de>
 <aJzT7rqwkRQrLGqo@slm.duckdns.org>
 <20250818125242.vJ4wGk20@linutronix.de>
 <aKNlshZmWsHVXBo0@slm.duckdns.org>
 <20250819150105.DYeV89fa@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819150105.DYeV89fa@linutronix.de>

On 2025-08-19 17:01:07 [+0200], To Tejun Heo wrote:
> Okay. Then let me repost the tasklet patch and make one for workqueue to
> stay in sync.
> I do hope that we end up with a requirement that any kind of teardown
> does not happen from an atomic context ;)

That would be 

------------->8-------------

Subject: [PATCH] workqueue: Provide a handshake for canceling BH workers

While a BH work item is canceled, the core code spins until it
determines that the item completed. On PREEMPT_RT the spinning relies on
a lock in local_bh_disable() to avoid a live lock if the canceling
thread has higher priority than the BH-worker and preempts it. This lock
ensures that the BH-worker makes progress by PI-boosting it.

This lock in local_bh_disable() is a central per-CPU BKL and about to be
removed.

To provide the required synchronisation add a per pool lock. The lock is
acquired by the bh_worker at the begin while the individual callbacks
are invoked. To enforce progress in case of interruption, __flush_work()
needs to acquire the lock.
This will flush all BH-work items assigned to that pool.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/workqueue.c | 51 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 9 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c6b79b3675c31..94e226f637992 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -222,7 +222,9 @@ struct worker_pool {
 	struct workqueue_attrs	*attrs;		/* I: worker attributes */
 	struct hlist_node	hash_node;	/* PL: unbound_pool_hash node */
 	int			refcnt;		/* PL: refcnt for unbound pools */
-
+#ifdef CONFIG_PREEMPT_RT
+	spinlock_t		cb_lock;	/* BH worker cancel lock */
+#endif
 	/*
 	 * Destruction of pool is RCU protected to allow dereferences
 	 * from get_work_pool().
@@ -3078,6 +3080,31 @@ __acquires(&pool->lock)
 		goto restart;
 }
 
+#ifdef CONFIG_PREEMPT_RT
+static void worker_lock_callback(struct worker_pool *pool)
+{
+	spin_lock(&pool->cb_lock);
+}
+
+static void worker_unlock_callback(struct worker_pool *pool)
+{
+	spin_unlock(&pool->cb_lock);
+}
+
+static void workqueue_callback_cancel_wait_running(struct worker_pool *pool)
+{
+	spin_lock(&pool->cb_lock);
+	spin_unlock(&pool->cb_lock);
+}
+
+#else
+
+static void worker_lock_callback(struct worker_pool *pool) { }
+static void worker_unlock_callback(struct worker_pool *pool) { }
+static void workqueue_callback_cancel_wait_running(struct worker_pool *pool) { }
+
+#endif
+
 /**
  * manage_workers - manage worker pool
  * @worker: self
@@ -3557,6 +3584,7 @@ static void bh_worker(struct worker *worker)
 	int nr_restarts = BH_WORKER_RESTARTS;
 	unsigned long end = jiffies + BH_WORKER_JIFFIES;
 
+	worker_lock_callback(pool);
 	raw_spin_lock_irq(&pool->lock);
 	worker_leave_idle(worker);
 
@@ -3585,6 +3613,7 @@ static void bh_worker(struct worker *worker)
 	worker_enter_idle(worker);
 	kick_pool(pool);
 	raw_spin_unlock_irq(&pool->lock);
+	worker_unlock_callback(pool);
 }
 
 /*
@@ -4222,17 +4251,18 @@ static bool __flush_work(struct work_struct *work, bool from_cancel)
 		    (data & WORK_OFFQ_BH)) {
 			/*
 			 * On RT, prevent a live lock when %current preempted
-			 * soft interrupt processing or prevents ksoftirqd from
-			 * running by keeping flipping BH. If the BH work item
-			 * runs on a different CPU then this has no effect other
-			 * than doing the BH disable/enable dance for nothing.
-			 * This is copied from
-			 * kernel/softirq.c::tasklet_unlock_spin_wait().
+			 * soft interrupt processing by blocking on lock which
+			 * is owned by the thread invoking the callback.
 			 */
 			while (!try_wait_for_completion(&barr.done)) {
 				if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-					local_bh_disable();
-					local_bh_enable();
+					struct worker_pool *pool;
+
+					mutex_lock(&wq_pool_mutex);
+					pool = get_work_pool(work);
+					if (pool)
+						workqueue_callback_cancel_wait_running(pool);
+					mutex_unlock(&wq_pool_mutex);
 				} else {
 					cpu_relax();
 				}
@@ -4782,6 +4812,9 @@ static int init_worker_pool(struct worker_pool *pool)
 	ida_init(&pool->worker_ida);
 	INIT_HLIST_NODE(&pool->hash_node);
 	pool->refcnt = 1;
+#ifdef CONFIG_PREEMPT_RT
+	spin_lock_init(&pool->cb_lock);
+#endif
 
 	/* shouldn't fail above this point */
 	pool->attrs = alloc_workqueue_attrs();
-- 
2.50.1

