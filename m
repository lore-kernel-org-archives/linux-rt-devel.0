Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B527C15B
	for <linux-rt-devel@lists.linux.dev>; Wed,  9 Apr 2025 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744225125; cv=none; b=pLGt1WUWLrWwT9ECLys/3CJ56Q9c+LC3B29RTi6PAaq31a31p2EGCnbHU3EtjGglnpnGbQcTM1M0Yps+Vl0ngaUSM5MWhlknuwz/CGpiQi8pJ+PTbFgoIhFjR6mCzOiodnyOUNwmQr2WGq7ZI1+xWpldlQF+bscYldX4OzdhydY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744225125; c=relaxed/simple;
	bh=WYAu8cwIOR3j5bPwNsv4yJ2R0q8DA2StD6bHldUkofY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VwMrk0JDTzkVHv+iqs20n8s/a4k+Jbrtm3VrYOYhG09RH5YS6nKWS7i1yFlVKDqqneskDyMTdWZoqm/NyMkx5JCay99d12ZvPT0TA80us1px5R5a056C1BUdf6Mmc9krFyd9bkZKKrgCyYA4WngNiPWMBmuC3aH07WonJb3Yx2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i87uQ01x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i87uQ01x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744225121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=IomF8IvW5GqoiLmMbddAQY7wujpofeB8cOEYdi3c1Xo=;
	b=i87uQ01x0pG4VUDAjXXLZNbCdAr8zKNZHWzKP/e/W3+v0OFu27t4AVLKk5hDyWw484prfs
	qycvCYKXMgZLT+nIKHHraxYa+FfMjODC4QGP1JFdAH93Ao4DnXbxR8OUrf4LmOUcbLh9wh
	bdu52CUt4/jGVykZ8RwBZfAux5FUDy0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-5t3HoGQ6OrayAldKMwkgeQ-1; Wed,
 09 Apr 2025 14:58:37 -0400
X-MC-Unique: 5t3HoGQ6OrayAldKMwkgeQ-1
X-Mimecast-MFC-AGG-ID: 5t3HoGQ6OrayAldKMwkgeQ_1744225115
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46A0F195608A;
	Wed,  9 Apr 2025 18:58:35 +0000 (UTC)
Received: from localhost (unknown [10.22.88.189])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 57EAD180B488;
	Wed,  9 Apr 2025 18:58:34 +0000 (UTC)
Date: Wed, 9 Apr 2025 15:58:32 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, lclaudio00@gmail.com
Subject: [PATCH v2] sched: do not call __put_task_struct() on rt if
 pi_blocked_on is set
Message-ID: <Z_bDWN2pAnijPAMR@uudg.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
from rt_mutex_adjust_prio_chain() could happen in preemptible context and
with a mutex enqueued. That could lead to this sequence:

	rt_mutex_adjust_prio_chain()
	  put_task_struct()
	    __put_task_struct()
	      sched_ext_free()
	        spin_lock_irqsave()
	          rtlock_lock() --->  TRIGGERS
	                              lockdep_assert(!current->pi_blocked_on);

Adjust the check in put_task_struct() to also consider pi_blocked_on before
calling __put_task_struct(), resorting to the deferred call in case it is
set.

v2: Rostedt suggested removing the #ifdef from put_task_struct() and
    creating tsk_is_pi_blocked_on() in sched.h to make the change cleaner.

Suggested-by: Crystal Wood <crwood@redhat.com>
Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
 include/linux/sched.h      |   12 ++++++++++++
 include/linux/sched/task.h |   10 +++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5ec93e5ba53a9..9fbfa7f55a83d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2148,6 +2148,18 @@ static inline bool task_is_runnable(struct task_struct *p)
 	return p->on_rq && !p->se.sched_delayed;
 }
 
+#ifdef CONFIG_RT_MUTEXES
+static inline bool tsk_is_pi_blocked_on(struct task_struct *tsk)
+{
+	return tsk->pi_blocked_on != NULL;
+}
+#else
+static inline bool tsk_is_pi_blocked_on(strut task_struct *tsk)
+{
+	return false;
+}
+#endif
+
 extern bool sched_task_on_rq(struct task_struct *p);
 extern unsigned long get_wchan(struct task_struct *p);
 extern struct task_struct *cpu_curr_snapshot(int cpu);
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0f2aeb37bbb04..1f17a3dd51774 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -135,9 +135,11 @@ static inline void put_task_struct(struct task_struct *t)
 
 	/*
 	 * In !RT, it is always safe to call __put_task_struct().
-	 * Under RT, we can only call it in preemptible context.
+	 * Under RT, we can only call it in preemptible context,
+	 * when not blocked on a PI chain.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
+	    (preemptible() || !tsk_is_pi_blocked_on(current))) {
 		static DEFINE_WAIT_OVERRIDE_MAP(put_task_map, LD_WAIT_SLEEP);
 
 		lock_map_acquire_try(&put_task_map);
@@ -149,7 +151,9 @@ static inline void put_task_struct(struct task_struct *t)
 	/*
 	 * under PREEMPT_RT, we can't call put_task_struct
 	 * in atomic context because it will indirectly
-	 * acquire sleeping locks.
+	 * acquire sleeping locks. The same is true if the
+	 * current process has a mutex enqueued (blocked on
+	 * a PI chain).
 	 *
 	 * call_rcu() will schedule delayed_put_task_struct_rcu()
 	 * to be called in process context.
-- 
2.49.0

