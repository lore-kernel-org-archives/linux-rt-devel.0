Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E03064BC
	for <linux-rt-devel@lists.linux.dev>; Mon,  1 Sep 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744699; cv=none; b=mOlimGIgHxqh8k10Iw4JN8hZRyyO+L/JbPjh+uAo/x/1UebzRaya+T4q9bNAVguT2LYb+8IEINtf5F1hi3Rsj0a/0OWUwbgpEYa3NhaAQHReo9R4v554HaqI7wwAR4Ckd2mVQwW7cIZiWLvhxZcF5CY2o165IO97Kce8WOKvaSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744699; c=relaxed/simple;
	bh=BrexX74KTRK7FMalM1pY5dC2CuUGR6ggJVFFqo1/zDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVJVuVJSvD0OIimaFoPa0z2AQyVokznQHhyjm5dsgWGL6KFmAXk8BUcOBPbOf/2WWs6I+x2gKHRSufWoYDKwU9ygm8lVlVJlvO0SDbFaDc+g7/A/5i5VrOl5ClYaWp0SQ9MiSdkaUXn+/hVU8IqBQXkrOnIrLpV8svl1O0APLuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N1nr/4xo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=egmu6wlV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N1nr/4xo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="egmu6wlV"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756744695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVN5CLakpk5U9Y52EwxJn3/1VRy6LEwOBHWKO5lWw8o=;
	b=N1nr/4xoLtQlltAQ8MjUQSk8YVZ/c6BkotHebQdcOORfFpikcmGmOe567uUMMCN7A2oJd+
	Nzt7k/khAUXKUTgg5n3CkGPgDTu2W94+0l7jCz8fPENj7SwmL43I9HR+nXZSFnJIO30X3o
	X/oyN/yZb9OjAm0hl7olLE/et/COPHtBpIppHx+DAyd8I6w3oVkC+hCOlYsBhnjZLc3xzq
	jDZcMx0vFw01X3SkQMo28JdE3O4NOrCw/R6E2s+5N9t6ZNBLa5j28eOOHGqoGYg2RJzFOo
	PXyhEwNB1grenx3iRflAn9R6uHjjbytIAQYK0fzmrVfcESD57dUsqXfkB1qa7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756744695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UVN5CLakpk5U9Y52EwxJn3/1VRy6LEwOBHWKO5lWw8o=;
	b=egmu6wlVdxQ7GfrWIOyY+Ez7zn7yMxQPmJY+E+wiiXISElBFb+ZZx5dmw1qttLS/fo/F9N
	pi7XAFC5l+bSj7Dg==
To: linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Clark Williams <clrkwllms@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tejun Heo <tj@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/3] softirq: Provide a handshake for canceling tasklets via polling
Date: Mon,  1 Sep 2025 18:38:10 +0200
Message-ID: <20250901163811.963326-3-bigeasy@linutronix.de>
In-Reply-To: <20250901163811.963326-1-bigeasy@linutronix.de>
References: <20250901163811.963326-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

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
 kernel/softirq.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 513b1945987cc..4e2c980e7712e 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -805,6 +805,58 @@ static bool tasklet_clear_sched(struct tasklet_struct =
*t)
 	return false;
 }
=20
+#ifdef CONFIG_PREEMPT_RT
+struct tasklet_sync_callback {
+	spinlock_t	cb_lock;
+	atomic_t	cb_waiters;
+};
+
+static DEFINE_PER_CPU(struct tasklet_sync_callback, tasklet_sync_callback)=
 =3D {
+	.cb_lock	=3D __SPIN_LOCK_UNLOCKED(tasklet_sync_callback.cb_lock),
+	.cb_waiters	=3D ATOMIC_INIT(0),
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
+	struct tasklet_sync_callback *sync_cb =3D this_cpu_ptr(&tasklet_sync_call=
back);
+
+	atomic_inc(&sync_cb->cb_waiters);
+	spin_lock(&sync_cb->cb_lock);
+	atomic_dec(&sync_cb->cb_waiters);
+	spin_unlock(&sync_cb->cb_lock);
+}
+
+static void tasklet_callback_sync_wait_running(void)
+{
+	struct tasklet_sync_callback *sync_cb =3D this_cpu_ptr(&tasklet_sync_call=
back);
+
+	if (atomic_read(&sync_cb->cb_waiters)) {
+		spin_unlock(&sync_cb->cb_lock);
+		spin_lock(&sync_cb->cb_lock);
+	}
+}
+
+#else /* !CONFIG_PREEMPT_RT: */
+
+static void tasklet_lock_callback(void) { }
+static void tasklet_unlock_callback(void) { }
+static void tasklet_callback_sync_wait_running(void) { }
+
+#ifdef CONFIG_SMP
+static void tasklet_callback_cancel_wait_running(void) { }
+#endif
+#endif /* !CONFIG_PREEMPT_RT */
+
 static void tasklet_action_common(struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
 {
@@ -816,6 +868,7 @@ static void tasklet_action_common(struct tasklet_head *=
tl_head,
 	tl_head->tail =3D &tl_head->head;
 	local_irq_enable();
=20
+	tasklet_lock_callback();
 	while (list) {
 		struct tasklet_struct *t =3D list;
=20
@@ -835,6 +888,7 @@ static void tasklet_action_common(struct tasklet_head *=
tl_head,
 					}
 				}
 				tasklet_unlock(t);
+				tasklet_callback_sync_wait_running();
 				continue;
 			}
 			tasklet_unlock(t);
@@ -847,6 +901,7 @@ static void tasklet_action_common(struct tasklet_head *=
tl_head,
 		__raise_softirq_irqoff(softirq_nr);
 		local_irq_enable();
 	}
+	tasklet_unlock_callback();
 }
=20
 static __latent_entropy void tasklet_action(void)
@@ -897,12 +952,9 @@ void tasklet_unlock_spin_wait(struct tasklet_struct *t)
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
--=20
2.51.0

