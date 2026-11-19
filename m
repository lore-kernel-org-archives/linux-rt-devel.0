Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119389;
	b=uhZscMKkvdDjdUUpxARsnqRvY2ScUM1/D2uD+yBozmr0YklsIyRcjuduPNeFDbjeeaHe
	 B+R2UWuxHfdEB4xHhDxd9IZek/g7LxobnvSiS0tsX3FUpt5hYNKzwdlM5fhIdqUw17Z7H
	 ryro8mE3mNenp0O7SSIJBCKq6R0y9nWQgd90rcW8WQP7lOfDF7eZDlcJf864VXKEU69td
	 JsVX2ZMRCKWn5h/0g3ZK/JiaicIPNszuOWeHr6aN31Foqt+P+pPkAUyxvDfQmfS674+YO
	 I8M+wzVMSRc9Iy8uhhBbyfgaH0Vdb6Qt+juxEj9jFARBqqkdDg6UbN8zJiFMEJ1DouA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119389;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dacbOogbwNRhpR/7iOlXSNqp2+egjetAWwBLZZQJ5Ls=;
	b=0n+Ukd9seLd/hKdXDNaDeNz4cQv2lIjQJpOmT8+d1UKRhILhxB/9neBW2tZTI8m2Abtq
	 9KKvZwXAM+3WMRFCLQ458CAXIkTPdclzAcIyozMar5BsrvfbbrqajdfOoEB475ZEBPMOM
	 bHZPhtewnY/ueS3sq7PBl6RGb4xrqGZsD/3+yFJlu0wXRfAOvLaV7F+CKeh8ZCGnOqWT2
	 kK5IIDtiaws00tmq3HSqNQzx+W2ms1x7K2YgDx31Avq0cAh1xMtGnFMqaq7CYB7dZ8sH+
	 w57cTPhKZY14/wqdB4/kXkNskMX/5LNaj7/rDEWiLw4j3iBm27MnOhN1VHr31tmV66g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=duPXvNDb;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0522606A9E1
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 20:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0522606A9E1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=duPXvNDb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795119382;
	bh=dacbOogbwNRhpR/7iOlXSNqp2+egjetAWwBLZZQJ5Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duPXvNDbty/ak2ZBKL4MUpMKIvBL0cog+KkERl9t/NGiRo5UDB3/pjOGLByqktWQi
	 9XPc5PbJdrrHQEMi5G8pnVOiOkoApQBK6B7ClHFqUKgWAl1h/dYG2pF81Xw9Zr6WPs
	 kHQAfzl9dmrekUlOlyNqQvQV5vibk9xotE8K1FdaERSZAw79Q/CAwDMvf+lm4iRRIq
	 zcSRMfMQ/sE5KHxB4eAqgKDk/NO9+qlEi3K8xL04Fa6YMAIGvqlssn+9vu3pEjurSH
	 nQY+f5IpiNHB1V4aEbY+pG/hDafx6QlGwLuf97q2mBn5JK3Rkj00SYYnaKKoem8kBF
	 CIe+tq8c7HnxA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jVqVZ1jdRzS7j;
	Thu, 19 Nov 2026 15:16:22 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: juri.lelli@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com,
	vincent.guittot@linaro.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	tglx@kernel.org,
	will@kernel.org,
	boqun@kernel.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	luca.abeni@santannapisa.it,
	mathieu.poirier@linaro.org,
	longman@redhat.com,
	ridong.chen@linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	parri.andrea@gmail.com,
	m.szyprowski@samsung.com,
	kayracizmeci@gmail.com,
	weihengqiuu@gmail.com,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v8 26/33] sched/deadline: Start a period for a task that enters the class blocked
Date: Thu, 19 Nov 2026 15:16:05 -0500
Message-Id: <b218275f5c0dabbb914bf1ae9cf6a32f0551dd0e.1795116791.git.mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
References: <cover.1795116790.git.mathieu.desnoyers@efficios.com>
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

Commit fb00aca47440 ("rtmutex: Turn the plist into an rb-tree") sorts
the waiters of an rt_mutex by priority. For deadline tasks, "the one
with the earliest deadline wins". A waiter takes the deadline of its
task.

A task can enter the class while it waits on an rt_mutex.
sched_setattr() can make it SCHED_DEADLINE. A priority inheritance
boost can also put it in the class, if it owns another rt_mutex.
switched_to_dl() leaves a task that is not queued to its wakeup. But
the chain walk reads the deadline first, and copies it into the waiter.
A task new to the class has a deadline of 0.

So the waiter goes before every other deadline waiter. It takes the
rt_mutex first, whatever their deadlines. Those waiters can then miss
their deadlines. It also boosts a deadline owner whose own deadline is
earlier.

Fix this by starting a new period in switched_to_dl() for a task that
waits on an rt_mutex, if its deadline has passed. The period uses the
reservation the task runs on: its own, or the copy a boost made. This
is what setup_new_dl_entity() does at an enqueue. At the wakeup,
update_dl_entity() then checks that period as for any wakeup.

A new donor of a task with no parameters of its own needs the same. For
a queued task, the enqueue of the boost starts a period from the new
donor. For a blocked task, dl_boost_blocked() starts it at the boost.

The setattr_blocked_keeps_order and boost_blocked_keeps_order cases,
added to deadline_bw_test later in this series, test this. Both fail on
v7.4-rc2 and on the series without this patch. The triage of the Sashiko
AI review of this series found the bug.

Fixes: fb00aca47440 ("rtmutex: Turn the plist into an rb-tree")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/core.c     |  4 ++++
 kernel/sched/deadline.c | 46 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/sched.h    |  1 +
 3 files changed, 51 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 781eff645525..d30b28bfd919 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7954,8 +7954,12 @@ void rt_mutex_setprio(struct task_struct *p, struct task_struct *pi_task)
 			if (!dl_prio(p->normal_prio) ||
 			    (pi_task && dl_prio(pi_task->prio) &&
 			     dl_entity_preempt(&pi_task->dl, &p->dl))) {
+				bool new_donor = p->dl.pi_se != pi_task->dl.pi_se;
+
 				p->dl.pi_se = pi_task->dl.pi_se;
 				scope->flags |= ENQUEUE_REPLENISH;
+				if (!scope->queued && new_donor)
+					dl_boost_blocked(p);
 			} else {
 				dl_deboost(&p->dl);
 				/*
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 8ac78958a17a..77a1d1f463f6 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -125,6 +125,12 @@ void dl_deboost(struct sched_dl_entity *dl_se)
 	}
 	dl_drop_boost(dl_se);
 }
+
+/* Return true if @p waits on an rt_mutex. The caller holds its pi_lock. */
+static inline bool dl_task_pi_blocked(struct task_struct *p)
+{
+	return p->pi_blocked_on;
+}
 #else /* !CONFIG_RT_MUTEXES: */
 static inline struct sched_dl_entity *pi_of(struct sched_dl_entity *dl_se)
 {
@@ -139,6 +145,11 @@ static inline bool is_dl_boosted(struct sched_dl_entity *dl_se)
 {
 	return false;
 }
+
+static inline bool dl_task_pi_blocked(struct task_struct *p)
+{
+	return false;
+}
 #endif /* !CONFIG_RT_MUTEXES */
 
 static inline u8 dl_get_type(struct sched_dl_entity *dl_se, struct rq *rq)
@@ -1116,6 +1127,30 @@ static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
 	trace_sched_dl_replenish_tp(dl_se, cpu_of(rq), dl_get_type(dl_se, rq));
 }
 
+#ifdef CONFIG_RT_MUTEXES
+/*
+ * Start a period from the new donor of @p, if @p has no reservation of its
+ * own and waits on an rt_mutex. The enqueue does this for a queued task, in
+ * replenish_dl_entity(). A blocked task is not enqueued, but the chain walk
+ * copies its deadline into its waiter.
+ *
+ * The caller calls it only when the donor changes. A new period changes the
+ * deadline, so the chain walk finds the waiter out of date and goes on. In a
+ * ww_mutex cycle, a new period at each step would never let the walk stop.
+ *
+ * The caller holds the rq lock and the pi_lock of @p, and has updated the
+ * rq clock.
+ */
+void dl_boost_blocked(struct task_struct *p)
+{
+	struct sched_dl_entity *dl_se = &p->dl;
+
+	if (!dl_se->dl_deadline && !dl_se->dl_throttled &&
+	    dl_task_pi_blocked(p))
+		replenish_dl_new_period(dl_se, task_rq(p));
+}
+#endif
+
 /*
  * We are being explicitly informed that a new instance is starting,
  * and this means that:
@@ -4565,6 +4600,17 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 	if (!task_on_rq_queued(p)) {
 		add_rq_bw(&p->dl, &rq->dl);
 
+		/*
+		 * A task that waits on an rt_mutex cannot wait for its wakeup.
+		 * The chain walk sorts its waiter by its deadline first. A task
+		 * new to the class has a deadline of 0, which goes before every
+		 * real one. Start a new period now, as setup_new_dl_entity()
+		 * does at an enqueue.
+		 */
+		if (dl_task_pi_blocked(p) && !p->dl.dl_throttled &&
+		    dl_time_before(p->dl.deadline, rq_clock(rq)))
+			replenish_dl_new_period(&p->dl, rq);
+
 		return;
 	}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f80ea5541b3f..717ced2bb487 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -358,6 +358,7 @@ extern int  sched_dl_overflow(struct task_struct *p, int policy, const struct sc
 extern void __setparam_dl(struct task_struct *p, const struct sched_attr *attr);
 #ifdef CONFIG_RT_MUTEXES
 extern void dl_deboost(struct sched_dl_entity *dl_se);
+extern void dl_boost_blocked(struct task_struct *p);
 
 /* End the boost of @dl_se. The caller holds the rq lock of its task. */
 static inline void dl_drop_boost(struct sched_dl_entity *dl_se)
-- 
2.47.3

