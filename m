Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E742EBB8E
	for <linux-rt-devel@lists.linux.dev>; Tue, 12 Aug 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755009576; cv=none; b=KBbxiH7axHmAhaWVv8NbGmKRxhlhRGsa7hTPQXA88QP6i1ivd+Mh/Nio0Pd5n/WdTpiwjatjAG6NqoMIBSic4ZuGsm/wRD1NumeckBnmgS5X+2kEYhSTygk3tcrOs/Y7Opb3ApGdfaZaCkbjIcCMEOWDwiAAg5Tk6Zlw/r6dkUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755009576; c=relaxed/simple;
	bh=9eLIi7E9C1QAgVIzG+G9/HQo3fUT4g3sGMcBJuO07Do=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kgrEYVyfV6yc/1rtjOiax29VVb4WoczsyAfaWuwd6KmfPoE2c5rFcVSYQSpsVkHPJrasd25LWRdom1VUeCizAxAfNm0BjRFBTXkkdna0uB1e1dwa5pVYQhqXhpXHYUpJR3uBy2Zdtxx3G8EFgs4KVxDUNt2VmnLWCA+DHEJqCSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zPxfBNjz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4oPLisjO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zPxfBNjz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4oPLisjO"
Date: Tue, 12 Aug 2025 16:39:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755009571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mJ9c0MHZpKrJim1kv06EdDIC8iX3bNjJu87yC68CDw0=;
	b=zPxfBNjz3h7YyoYp/jzvK8edl1m6WhEK4kVIeROH+90r8hh+q5OL5D2W64bZIq1/0I8Aj4
	rHO6qi1fEaFh1VD33Zvwg7tr/zjFfKfeObZ9wXslshCzApYuY9YWdMcT7nHbM7qDFF79Jh
	xcUAXajWDcrFFU0FVrGUUNN/NXDBhWjb0+WC4iW/23qp2suozgPeAar955nACbNQEO5AIM
	TRedlN/Xtfz6/OseorwG0WCetnODPkshG+71cEPymUQ8SPLqJZnbfr1XrJVYy/IqX4cSIQ
	VwQqm2DYtCCd9Ll8bGDZ5ecCJse/tBWXZpsTjipQ0NMe0/yprkTVxjmBkIWN0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755009571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=mJ9c0MHZpKrJim1kv06EdDIC8iX3bNjJu87yC68CDw0=;
	b=4oPLisjOn2sKgg0M3poOjnOgeIO9CdS37YnZiSK2zYhoEW7P35SwotD49dWbHhpSfRw/J7
	lFoN0b4G3gg/KOBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] softirq: Provide a handshake for canceling tasklets via
 polling on PREEMPT_RT
Message-ID: <20250812143930.22RBn5BW@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The tasklet_unlock_spin_wait() via tasklet_disable_in_atomic() is
provided for a few legacy tasklet users. The interface is used from
atomic context (which is either softirq or disabled preemption) on
non-PREEMPT_RT an relies on spinning until the tasklet callback
completes.
On PREEMPT_RT the context is never atomic but the busy polling logic
remains. It possible that the thread invoking tasklet_unlock_spin_wait()
has higher priority than the tasklet. If both run on the same CPU the
the tasklet makes no progress and the thread trying to cancel the
tasklet will live-lock the system.
To avoid the lockup tasklet_unlock_spin_wait() uses local_bh_disable()/
enable() which utilizes the local_lock_t for synchronisation. This lock
is a central per-CPU BKL and about to be removed.

Acquire a lock in tasklet_action_common() which is held while the
tasklet's callback is invoked. This lock will be acquired from
tasklet_unlock_spin_wait() via tasklet_callback_cancel_wait_running().
After the tasklet completed tasklet_callback_sync_wait_running() drops
the lock and acquires it again. In order to avoid unlocking the lock
even if there is no cancel request, there is a cb_waiters counter which
is incremented during a cancel request.
Blocking on the lock will PI-boost the tasklet if needed, ensuring
progress is made.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/softirq.c | 60 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 55 insertions(+), 5 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 513b1945987cc..57a84758b8459 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -805,6 +805,56 @@ static bool tasklet_clear_sched(struct tasklet_struct *t)
 	return false;
 }
 
+#ifdef CONFIG_PREEMPT_RT
+struct tasklet_sync_callback {
+	spinlock_t	cb_lock;
+	atomic_t	cb_waiters;
+};
+
+static DEFINE_PER_CPU(struct tasklet_sync_callback, tasklet_sync_callback) = {
+	.cb_lock	= __SPIN_LOCK_UNLOCKED(tasklet_sync_callback.cb_lock),
+	.cb_waiters	= ATOMIC_INIT(0),
+};
+
+static void tasklet_lock_callback(void)
+{
+	spin_lock(this_cpu_ptr(&tasklet_sync_callback.cb_lock));
+}
+
+static void tasklet_unlock_callback(void)
+{
+	spin_unlock(this_cpu_ptr(&tasklet_sync_callback.cb_lock));
+}
+
+static void tasklet_callback_cancel_wait_running(void)
+{
+	struct tasklet_sync_callback *sync_cb = this_cpu_ptr(&tasklet_sync_callback);
+
+	atomic_inc(&sync_cb->cb_waiters);
+	spin_lock(&sync_cb->cb_lock);
+	atomic_dec(&sync_cb->cb_waiters);
+	spin_unlock(&sync_cb->cb_lock);
+}
+
+static void tasklet_callback_sync_wait_running(void)
+{
+	struct tasklet_sync_callback *sync_cb = this_cpu_ptr(&tasklet_sync_callback);
+
+	if (atomic_read(&sync_cb->cb_waiters)) {
+		spin_unlock(&sync_cb->cb_lock);
+		spin_lock(&sync_cb->cb_lock);
+	}
+}
+
+#else
+
+static void tasklet_lock_callback(void) { }
+static void tasklet_unlock_callback(void) { }
+static void tasklet_callback_cancel_wait_running(void) { }
+static void tasklet_callback_sync_wait_running(void) { }
+
+#endif
+
 static void tasklet_action_common(struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
 {
@@ -816,6 +866,7 @@ static void tasklet_action_common(struct tasklet_head *tl_head,
 	tl_head->tail = &tl_head->head;
 	local_irq_enable();
 
+	tasklet_lock_callback();
 	while (list) {
 		struct tasklet_struct *t = list;
 
@@ -835,6 +886,7 @@ static void tasklet_action_common(struct tasklet_head *tl_head,
 					}
 				}
 				tasklet_unlock(t);
+				tasklet_callback_sync_wait_running();
 				continue;
 			}
 			tasklet_unlock(t);
@@ -847,6 +899,7 @@ static void tasklet_action_common(struct tasklet_head *tl_head,
 		__raise_softirq_irqoff(softirq_nr);
 		local_irq_enable();
 	}
+	tasklet_unlock_callback();
 }
 
 static __latent_entropy void tasklet_action(void)
@@ -897,12 +950,9 @@ void tasklet_unlock_spin_wait(struct tasklet_struct *t)
 			/*
 			 * Prevent a live lock when current preempted soft
 			 * interrupt processing or prevents ksoftirqd from
-			 * running. If the tasklet runs on a different CPU
-			 * then this has no effect other than doing the BH
-			 * disable/enable dance for nothing.
+			 * running.
 			 */
-			local_bh_disable();
-			local_bh_enable();
+			tasklet_callback_cancel_wait_running();
 		} else {
 			cpu_relax();
 		}
-- 
2.50.1

