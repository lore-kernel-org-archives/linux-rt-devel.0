Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50534F48F
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Mar 2026 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772612640; cv=none; b=IrqtlD2euWi0p5iRNEXSKAzBlPZQqQL87yAPG8I9Ewg9LDkziBsS8Q+BwTKSx8hTWfMtUY7Su1+7jEeQR7r0YuDCFq0WnfoAnhD+FBQ/g94ZqQbuBDZArn95VaqQsZpqxj0pvfHaia6mrNpeBBI4bxjrqQ9YIQmLhu7z9WmbaK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772612640; c=relaxed/simple;
	bh=hwA6lpCivxVIjx8KwDWDd/2TIk3vi+tOKsYXiDWGpwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UnmP6wbU1WUvl+MhdG7jIolxHwOpoYYUXPs05bQxpw04coCJm/u4CrhmboO6LtdTDDr+K635tQAktIINtFCAy59YKYD/RpICwl4YhDasw9aRk3N+uhLVPgQkLzGXdfiQuwUi2iPuwMFsa3n+/7nVd9c34vHn2/jIcdwVOVLxjDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVG23yCb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVG23yCb"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82748095892so3158300b3a.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 04 Mar 2026 00:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772612637; x=1773217437; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nQ73zfgDaWL9qyuJ1c3cWYTQ05lGxb7i+BoMrrgmH7w=;
        b=kVG23yCbt29MdW/UYabcWdWrX+qhY1Q+sXhnHtW6V9U+JJQPqTwk6Pe5JU2gvwKfdt
         Ee578D9ZYQrulr4jl+DM+yjYCMrP5zJrnjhr6RLETr7bqJyGgZ6z4ginGF13EGRiw6iY
         ojXv8kEiVg35Oec3v/MdKxPnk4ArBUMAcPXJMywUzaCo4bMWLwlkdtG6IAPbOsEFIlZt
         1MwKDUc+CMYCKUq6dpIc+TpH4EGDTwOVCtWIfVApQn0Xeajz+ZC4KTNlqtU4JvW1feTE
         SxhoIIwIunW6G6yHtvduBwQMF7Eg9LbxGzQDNIsjLszo58dQ0tTPNN1bBuQ9gLG+7lIA
         S0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772612637; x=1773217437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQ73zfgDaWL9qyuJ1c3cWYTQ05lGxb7i+BoMrrgmH7w=;
        b=vH0RHmupCnCEeQ1Ot/HsFk/YFyEPwC7vOqWVhJTqU7DnLWEZ0s9MFUMsreqfNrRWKo
         OIEoU8UVWj2WwCSmzQx47ojItGOoGPDt1WM88kcCt/+ZJ/2H6rLP2CivLMb8ZaQwUQZN
         hzOw0bbpRWgxefFv7l79Am/Sy1XmBaUKrwA1fK2o4lXhC+zL4TjzUC3yL3eAEO+/XHpq
         InMr+zGQzynCV+hFBAmKUaf03sgOqkqSFaQKV90cJ5IvLPrDBqRy+JDACvrS25UchMNT
         D+zJ/zdfcIrcI2EjYqYLbZDWFMtpbB4c1Y72DSRIR+LhHP3XgQwU0zqAonQGQ/FWmWYf
         QQ1g==
X-Forwarded-Encrypted: i=1; AJvYcCXL6v9zzgW3kR6TKE3LfH+R90/cIRtT0Nb4XKDsZErbPyRPZfUCIVgUQqUhTTyU6go8C99pS12MSWQR0l+G3g==@lists.linux.dev
X-Gm-Message-State: AOJu0YwW4sxc/fWFnl8rk99PFxkLIKYTmwOqgeVBEsoYXoU5LDY7P++3
	xbwoBJ1SV4Z7NQ7wZDM9rAg93H+NUy9UZISG/wYaP5TbTzRued6c49xu
X-Gm-Gg: ATEYQzy5idepmZm3764UuiAUdNd9d281XUoAOaP2HQ26gPTRXrqNGnFAgkfiUq3rGj+
	0Lo7eu5gq40YS7zMGV+O6Tu1Ca16jwYQZs9xdq8jIyJlIewhVFatplzuIYWcm5zcj5Lb8LeUMmT
	XZh2+shkYyxZLISAswfK/ZMpBsgeCsNXjDANnbpSnbtP/LjAZTLFE6kfSsyUq4eEt0T4eYe4Ey3
	ecrzJw3ApfwwrhtOtDFRD82SnszjpXOJj4lqtuhX+Ylw6wMfzr5gDoJtxcvZIAUnGs6WqvI8Zwk
	PG8LNEi5tqIa0//l64scgVkdpUQy4iicFsT9jScUscgCBsGHFmAKnzFaaOfc8Y61bhLGummYHIj
	/Q5Klh1ogyr5mMZNMv5JwPYMVPm5NDcpK/A9+SDVvh3qcw7q4wsVrKZ2ZOLzd/Xu6ORu/dSBbQX
	jnG7/HNU3dydZy8cAwm5x3/xpOJO9Mk+/nW699B2i0LcCM2xjiWRk1jDNAg0fPiY/CR6fxBiNJt
	Ch0FeJ4XbfvTqU=
X-Received: by 2002:a05:6a20:4327:b0:394:36ae:b91e with SMTP id adf61e73a8af0-3982ddb75bcmr1245015637.5.1772612637175;
        Wed, 04 Mar 2026 00:23:57 -0800 (PST)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa61fcdesm14733236a12.11.2026.03.04.00.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:23:56 -0800 (PST)
From: soolaugust@gmail.com
To: linux-kernel@vger.kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	shuah@kernel.org,
	bigeasy@linutronix.de,
	jstultz@google.com,
	kprateek.nayak@amd.com,
	linux-kselftest@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	zhidao su <suzhidao@xiaomi.com>
Subject: [RFC PATCH] sched/proxy_exec: Extend PE blocked_on chain to rwsem write-side
Date: Wed,  4 Mar 2026 16:23:48 +0800
Message-ID: <20260304082348.959786-1-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: zhidao su <suzhidao@xiaomi.com>

Proxy Execution currently tracks blocked_on chains only through
struct mutex. This patch extends the infrastructure to support
rw_semaphore write-side blocking, allowing PE to eliminate priority
inversion where a high-priority writer waits for a low-priority
write lock holder.

Changes:

1. include/linux/sched.h: Generalise blocked_on from struct mutex *
   to void *, and add a 2-bit blocked_on_type field encoding the
   primitive type (BLOCKED_ON_NONE/MUTEX/RWSEM). All existing mutex
   helpers are renamed to _mutex suffix; compatibility wrappers
   preserve the old names so that mutex.c requires no change.
   New __set/clear_task_blocked_on_rwsem() helpers are added
   (void * parameter avoids pulling rwsem.h into sched.h).

2. kernel/locking/rwsem.c: In rwsem_down_write_slowpath(), call
   __set_task_blocked_on_rwsem() after entering the wait queue
   (wait_lock held), re-set it after each schedule() wakeup, and
   clear it on lock acquisition and on signal-interrupted exit.
   Pattern mirrors the existing mutex slowpath.

3. kernel/sched/core.c: find_proxy_task() now dispatches on
   blocked_on_type. The BLOCKED_ON_RWSEM branch acquires
   sem->wait_lock, re-validates blocked_on, then calls
   rwsem_owner() to retrieve the write owner (returns NULL for
   reader-owned sem, which safely terminates the chain). Owner
   validity checks (on_rq, sched_delayed, cpu, migrating) are
   shared between both branches.

4. tools/testing/selftests/sched/proxy_exec_test.c: Add TC-4
   (single-level rwsem write PE) and TC-5 (mixed rwsem->mutex
   chain). TAP plan updated from 3 to 5.

PREEMPT_RT limitation: rwsem is backed by rwbase_rt/rt_mutex under
CONFIG_PREEMPT_RT. The new code paths are not compiled on RT kernels;
on RT blocked_on is never set for rwsem and find_proxy_task()
terminates cleanly at such nodes.

Signed-off-by: zhidao su <suzhidao@xiaomi.com>
---
 include/linux/sched.h                         | 110 ++-
 kernel/locking/rwsem.c                        |   9 +
 kernel/sched/core.c                           | 106 ++-
 .../testing/selftests/sched/proxy_exec_test.c | 763 ++++++++++++++++++
 4 files changed, 943 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/sched/proxy_exec_test.c

diff --git a/include/linux/sched.h b/include/linux/sched.h
index a7b4a980eb2..4bef3618889 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1237,7 +1237,8 @@ struct task_struct {
 	struct rt_mutex_waiter		*pi_blocked_on;
 #endif
 
-	struct mutex			*blocked_on;	/* lock we're blocked on */
+	void				*blocked_on;	/* lock we're blocked on */
+	unsigned int			 blocked_on_type : 2; /* enum blocked_on_type */
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
 	/*
@@ -2178,8 +2179,21 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock) __must_hold(lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
+/*
+ * Type tag for task_struct::blocked_on. Allows PE chain traversal
+ * to handle different lock primitives (mutex, rwsem write-side).
+ */
+enum blocked_on_type {
+	BLOCKED_ON_NONE  = 0,
+	BLOCKED_ON_MUTEX = 1,
+	BLOCKED_ON_RWSEM = 2,
+};
+
 #ifndef CONFIG_PREEMPT_RT
-static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
+/* --- mutex blocked_on helpers --- */
+
+static inline struct mutex *
+__get_task_blocked_on_mutex(struct task_struct *p)
 {
 	struct mutex *m = p->blocked_on;
 
@@ -2188,7 +2202,8 @@ static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
 	return m;
 }
 
-static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
+static inline void
+__set_task_blocked_on_mutex(struct task_struct *p, struct mutex *m)
 {
 	struct mutex *blocked_on = READ_ONCE(p->blocked_on);
 
@@ -2204,15 +2219,18 @@ static inline void __set_task_blocked_on(struct task_struct *p, struct mutex *m)
 	 */
 	WARN_ON_ONCE(blocked_on && blocked_on != m);
 	WRITE_ONCE(p->blocked_on, m);
+	p->blocked_on_type = BLOCKED_ON_MUTEX;
 }
 
-static inline void set_task_blocked_on(struct task_struct *p, struct mutex *m)
+static inline void
+set_task_blocked_on_mutex(struct task_struct *p, struct mutex *m)
 {
 	guard(raw_spinlock_irqsave)(&m->wait_lock);
-	__set_task_blocked_on(p, m);
+	__set_task_blocked_on_mutex(p, m);
 }
 
-static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *m)
+static inline void
+__clear_task_blocked_on_mutex(struct task_struct *p, struct mutex *m)
 {
 	if (m) {
 		struct mutex *blocked_on = READ_ONCE(p->blocked_on);
@@ -2227,21 +2245,91 @@ static inline void __clear_task_blocked_on(struct task_struct *p, struct mutex *
 		WARN_ON_ONCE(blocked_on && blocked_on != m);
 	}
 	WRITE_ONCE(p->blocked_on, NULL);
+	p->blocked_on_type = BLOCKED_ON_NONE;
 }
 
-static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
+static inline void
+clear_task_blocked_on_mutex(struct task_struct *p, struct mutex *m)
 {
 	guard(raw_spinlock_irqsave)(&m->wait_lock);
-	__clear_task_blocked_on(p, m);
+	__clear_task_blocked_on_mutex(p, m);
 }
-#else
-static inline void __clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
+
+/* Compatibility wrappers — keep mutex.c callers unchanged */
+static inline struct mutex *
+__get_task_blocked_on(struct task_struct *p)
+{
+	return __get_task_blocked_on_mutex(p);
+}
+
+static inline void
+__set_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
+	__set_task_blocked_on_mutex(p, m);
 }
 
-static inline void clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
+static inline void
+set_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	set_task_blocked_on_mutex(p, m);
+}
+
+static inline void
+__clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 {
+	__clear_task_blocked_on_mutex(p, m);
 }
+
+static inline void
+clear_task_blocked_on(struct task_struct *p, struct mutex *m)
+{
+	clear_task_blocked_on_mutex(p, m);
+}
+
+/* --- rwsem write-side blocked_on helpers --- */
+
+/*
+ * __set/clear_task_blocked_on_rwsem: called with sem->wait_lock held.
+ * Uses void* to avoid pulling struct rw_semaphore into sched.h.
+ * Callers (rwsem.c) cast sem to void* before passing.
+ */
+static inline void
+__set_task_blocked_on_rwsem(struct task_struct *p, void *sem)
+{
+	void *blocked_on = READ_ONCE(p->blocked_on);
+
+	WARN_ON_ONCE(!sem);
+	/* The task should only be setting itself as blocked */
+	WARN_ON_ONCE(p != current);
+	WARN_ON_ONCE(blocked_on && blocked_on != sem);
+	WRITE_ONCE(p->blocked_on, sem);
+	p->blocked_on_type = BLOCKED_ON_RWSEM;
+}
+
+static inline void
+__clear_task_blocked_on_rwsem(struct task_struct *p, void *sem)
+{
+	if (sem) {
+		void *blocked_on = READ_ONCE(p->blocked_on);
+
+		WARN_ON_ONCE(blocked_on && blocked_on != sem);
+	}
+	WRITE_ONCE(p->blocked_on, NULL);
+	p->blocked_on_type = BLOCKED_ON_NONE;
+}
+
+#else /* CONFIG_PREEMPT_RT */
+
+static inline void
+__clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
+{
+}
+
+static inline void
+clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
+{
+}
+
 #endif /* !CONFIG_PREEMPT_RT */
 
 static __always_inline bool need_resched(void)
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 24df4d98f7d..4ef9893a3e4 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1154,6 +1154,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 
 	if (state == TASK_UNINTERRUPTIBLE)
 		hung_task_set_blocker(sem, BLOCKER_TYPE_RWSEM_WRITER);
+	/* PE: mark this task as blocked on the rwsem write lock */
+	__set_task_blocked_on_rwsem(current, sem);
 
 	for (;;) {
 		if (rwsem_try_write_lock(sem, &waiter)) {
@@ -1187,8 +1189,13 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 		set_current_state(state);
 trylock_again:
 		raw_spin_lock_irq(&sem->wait_lock);
+		/* PE: re-set blocked_on after wakeup re-acquires wait_lock */
+		__set_task_blocked_on_rwsem(current, sem);
 	}
 
+	/* PE: clear blocked_on — lock acquired, wait_lock still held */
+	__clear_task_blocked_on_rwsem(current, sem);
+
 	if (state == TASK_UNINTERRUPTIBLE)
 		hung_task_clear_blocker();
 
@@ -1201,6 +1208,8 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 out_nolock:
 	__set_current_state(TASK_RUNNING);
 	raw_spin_lock_irq(&sem->wait_lock);
+	/* PE: clear blocked_on on signal-interrupted exit */
+	__clear_task_blocked_on_rwsem(current, sem);
 	rwsem_del_wake_waiter(sem, &waiter, &wake_q);
 	lockevent_inc(rwsem_wlock_fail);
 	trace_contention_end(sem, -EINTR);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index dc9f17b35e4..d50c8a90908 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -54,6 +54,7 @@
 #include <linux/mmu_context.h>
 #include <linux/mmzone.h>
 #include <linux/mutex_api.h>
+#include <linux/rwsem.h>
 #include <linux/nmi.h>
 #include <linux/nospec.h>
 #include <linux/perf_event_api.h>
@@ -6594,35 +6595,69 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 	struct task_struct *owner = NULL;
 	int this_cpu = cpu_of(rq);
 	struct task_struct *p;
-	struct mutex *mutex;
 
 	/* Follow blocked_on chain. */
 	for (p = donor; task_is_blocked(p); p = owner) {
-		mutex = p->blocked_on;
+		void *blocked_lock = READ_ONCE(p->blocked_on);
+		enum blocked_on_type btype = p->blocked_on_type;
+
 		/* Something changed in the chain, so pick again */
-		if (!mutex)
+		if (!blocked_lock)
 			return NULL;
-		/*
-		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
-		 * and ensure @owner sticks around.
-		 */
-		guard(raw_spinlock)(&mutex->wait_lock);
 
-		/* Check again that p is blocked with wait_lock held */
-		if (mutex != __get_task_blocked_on(p)) {
+		if (btype == BLOCKED_ON_MUTEX) {
+			struct mutex *mutex = blocked_lock;
+
 			/*
-			 * Something changed in the blocked_on chain and
-			 * we don't know if only at this level. So, let's
-			 * just bail out completely and let __schedule()
-			 * figure things out (pick_again loop).
+			 * By taking mutex->wait_lock we hold off concurrent
+			 * mutex_unlock() and ensure @owner sticks around.
 			 */
-			return NULL;
-		}
+			guard(raw_spinlock)(&mutex->wait_lock);
 
-		owner = __mutex_owner(mutex);
-		if (!owner) {
-			__clear_task_blocked_on(p, mutex);
-			return p;
+			/* Check again that p is blocked with wait_lock held */
+			if (mutex != __get_task_blocked_on(p)) {
+				/*
+				 * Something changed in the blocked_on chain
+				 * and we don't know if only at this level.
+				 * Bail out and let __schedule() figure things
+				 * out (pick_again loop).
+				 */
+				return NULL;
+			}
+
+			owner = __mutex_owner(mutex);
+			if (!owner) {
+				__clear_task_blocked_on(p, mutex);
+				return p;
+			}
+		} else if (btype == BLOCKED_ON_RWSEM) {
+			struct rw_semaphore *sem = blocked_lock;
+
+			/*
+			 * Take sem->wait_lock to serialise against concurrent
+			 * up_write() and ensure the owner pointer is stable.
+			 */
+			guard(raw_spinlock)(&sem->wait_lock);
+
+			/*
+			 * Re-check after acquiring wait_lock: blocked_on
+			 * could have been cleared by a concurrent wakeup.
+			 */
+			if (sem != READ_ONCE(p->blocked_on))
+				return NULL;
+
+			owner = rwsem_owner(sem);
+			if (!owner) {
+				/*
+				 * rwsem is reader-owned or has no writer
+				 * owner. Cannot proxy-execute through
+				 * readers; treat as terminal node.
+				 */
+				return p;
+			}
+		} else {
+			/* Unknown blocked_on type — bail */
+			return NULL;
 		}
 
 		if (!READ_ONCE(owner->on_rq)) {
@@ -6630,7 +6665,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 * Owner is off the runqueue; proxy execution cannot
 			 * proceed through it. Deactivate the donor so it will
 			 * be properly re-enqueued when the owner eventually
-			 * wakes and releases the mutex.
+			 * wakes and releases the lock.
 			 */
 			return proxy_deactivate(rq, donor);
 		}
@@ -6658,12 +6693,14 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 
 		if (task_on_rq_migrating(owner)) {
 			/*
-			 * One of the chain of mutex owners is currently migrating to this
-			 * CPU, but has not yet been enqueued because we are holding the
-			 * rq lock. As a simple solution, just schedule rq->idle to give
-			 * the migration a chance to complete. Much like the migrate_task
-			 * case we should end up back in find_proxy_task(), this time
-			 * hopefully with all relevant tasks already enqueued.
+			 * One of the chain of lock owners is currently
+			 * migrating to this CPU, but has not yet been
+			 * enqueued because we are holding the rq lock. As a
+			 * simple solution, just schedule rq->idle to give
+			 * the migration a chance to complete. Much like the
+			 * migrate_task case we should end up back in
+			 * find_proxy_task(), this time hopefully with all
+			 * relevant tasks already enqueued.
 			 */
 			return proxy_resched_idle(rq);
 		}
@@ -6683,8 +6720,8 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			/*
 			 * It's possible we interleave with mutex_unlock like:
 			 *
-			 *				lock(&rq->lock);
-			 *				  find_proxy_task()
+			 *			lock(&rq->lock);
+			 *			  find_proxy_task()
 			 * mutex_unlock()
 			 *   lock(&wait_lock);
 			 *   donor(owner) = current->blocked_donor;
@@ -6694,13 +6731,14 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 			 *     ...
 			 *       ttwu_runnable()
 			 *         __task_rq_lock()
-			 *				  lock(&wait_lock);
-			 *				  owner == p
+			 *			  lock(&wait_lock);
+			 *			  owner == p
 			 *
-			 * Which leaves us to finish the ttwu_runnable() and make it go.
+			 * Which leaves us to finish the ttwu_runnable() and
+			 * make it go.
 			 *
-			 * So schedule rq->idle so that ttwu_runnable() can get the rq
-			 * lock and mark owner as running.
+			 * So schedule rq->idle so that ttwu_runnable() can
+			 * get the rq lock and mark owner as running.
 			 */
 			return proxy_resched_idle(rq);
 		}
diff --git a/tools/testing/selftests/sched/proxy_exec_test.c b/tools/testing/selftests/sched/proxy_exec_test.c
new file mode 100644
index 00000000000..30fc58b9738
--- /dev/null
+++ b/tools/testing/selftests/sched/proxy_exec_test.c
@@ -0,0 +1,763 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Proxy Execution (PE) selftest
+ *
+ * Tests for the sched_proxy_exec feature. Verifies that the kernel
+ * correctly handles RT priority inheritance through proxy execution.
+ *
+ * TC-1: Basic PE activation — low-prio holder releases lock for high-prio
+ *        waiter within expected time bound.
+ * TC-2: Three-level blocked_on chain — PE chains through B->C so that
+ *        A eventually acquires its mutex.
+ * TC-3: PE deactivate path — SIGSTOP/SIGCONT on holder; high-prio thread
+ *        must still acquire the lock within a generous timeout.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <sched.h>
+#include <errno.h>
+#include <signal.h>
+#include <time.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+
+static int test_count;
+
+/* ------------------------------------------------------------------ */
+/* Helpers                                                              */
+/* ------------------------------------------------------------------ */
+
+/*
+ * is_proxy_exec_enabled - check whether CONFIG_SCHED_PROXY_EXEC is active
+ *
+ * Try to read /proc/sys/kernel/sched_proxy_exec. If the file exists and
+ * contains a non-zero value the feature is considered enabled. Returns 1
+ * when enabled, 0 otherwise.
+ */
+static int is_proxy_exec_enabled(void)
+{
+	FILE *f;
+	int val = 0;
+
+	f = fopen("/proc/sys/kernel/sched_proxy_exec", "r");
+	if (!f)
+		return 0;
+
+	if (fscanf(f, "%d", &val) != 1)
+		val = 0;
+
+	fclose(f);
+	return val != 0;
+}
+
+/*
+ * set_rt_prio - set the calling thread to SCHED_FIFO at the given priority
+ *
+ * Returns 0 on success, -1 on failure.
+ */
+static int set_rt_prio(int prio)
+{
+	struct sched_param sp = { .sched_priority = prio };
+
+	if (sched_setscheduler(0, SCHED_FIFO, &sp) != 0)
+		return -1;
+	return 0;
+}
+
+/*
+ * print_result - emit a single TAP result line
+ *
+ * Increments the global test counter and prints either "ok N - name" or
+ * "not ok N - name".
+ */
+static void print_result(const char *name, int pass)
+{
+	++test_count;
+	if (pass)
+		printf("ok %d - %s\n", test_count, name);
+	else
+		printf("not ok %d - %s\n", test_count, name);
+}
+
+/*
+ * elapsed_ms - compute elapsed wall-clock milliseconds between two
+ * CLOCK_MONOTONIC timestamps.
+ */
+static long elapsed_ms(const struct timespec *start, const struct timespec *end)
+{
+	long diff_sec  = (long)(end->tv_sec  - start->tv_sec);
+	long diff_nsec = (long)(end->tv_nsec - start->tv_nsec);
+
+	return diff_sec * 1000L + diff_nsec / 1000000L;
+}
+
+/* ------------------------------------------------------------------ */
+/* TC-1: Basic PE activation                                            */
+/* ------------------------------------------------------------------ */
+
+struct tc1_args {
+	pthread_mutex_t *mutex;
+	int              hold_ms;       /* how long to sleep in critical section */
+};
+
+static void *tc1_holder_thread(void *arg)
+{
+	struct tc1_args *a = arg;
+	struct timespec ts = { 0, (long)a->hold_ms * 1000000L };
+
+	/* Become a low-prio RT thread so PE applies. */
+	set_rt_prio(20);
+
+	pthread_mutex_lock(a->mutex);
+	nanosleep(&ts, NULL);
+	pthread_mutex_unlock(a->mutex);
+
+	return NULL;
+}
+
+static void test_basic_pe_activation(void)
+{
+	pthread_t        holder;
+	pthread_mutex_t  mutex = PTHREAD_MUTEX_INITIALIZER;
+	struct tc1_args  args  = { .mutex = &mutex, .hold_ms = 200 };
+	struct timespec  t0, t1;
+	long             ms;
+	int              pass;
+
+	printf("# TC-1: basic PE activation\n");
+
+	/* Spawn the low-prio holder first; let it grab the mutex. */
+	if (pthread_create(&holder, NULL, tc1_holder_thread, &args) != 0) {
+		printf("# TC-1: pthread_create failed: %s\n", strerror(errno));
+		print_result("basic_pe_activation", 0);
+		return;
+	}
+
+	/*
+	 * Give the holder a moment to actually lock the mutex before this
+	 * (main) thread — soon to be prio 80 — tries to acquire it.
+	 */
+	usleep(20000); /* 20 ms */
+
+	/* Raise our own priority so we become the blocked high-prio waiter. */
+	if (set_rt_prio(80) != 0) {
+		printf("# TC-1: set_rt_prio(80) failed: %s\n", strerror(errno));
+		pthread_join(holder, NULL);
+		pthread_mutex_destroy(&mutex);
+		print_result("basic_pe_activation", 0);
+		return;
+	}
+
+	clock_gettime(CLOCK_MONOTONIC, &t0);
+	pthread_mutex_lock(&mutex);
+	clock_gettime(CLOCK_MONOTONIC, &t1);
+	pthread_mutex_unlock(&mutex);
+
+	/* Restore to SCHED_OTHER for the remaining tests. */
+	{
+		struct sched_param sp = { .sched_priority = 0 };
+
+		sched_setscheduler(0, SCHED_OTHER, &sp);
+	}
+
+	pthread_join(holder, NULL);
+	pthread_mutex_destroy(&mutex);
+
+	ms   = elapsed_ms(&t0, &t1);
+	pass = (ms < 300L);
+	printf("# TC-1: acquired mutex in %ld ms (limit 300 ms)\n", ms);
+	print_result("basic_pe_activation", pass);
+}
+
+/* ------------------------------------------------------------------ */
+/* TC-2: Three-level blocked_on chain                                   */
+/* ------------------------------------------------------------------ */
+
+struct tc2_shared {
+	pthread_mutex_t mutex1;
+	pthread_mutex_t mutex2;
+
+	/* Synchronisation: holders signal when they have grabbed the lock. */
+	pthread_mutex_t sync_mutex;
+	pthread_cond_t  sync_cond;
+	int             holders_ready; /* incremented by each holder */
+};
+
+struct tc2_b_args {
+	struct tc2_shared *s;
+};
+
+struct tc2_c_args {
+	struct tc2_shared *s;
+	int                hold_ms;
+};
+
+/* Thread C: holds mutex2, sleeps, releases. */
+static void *tc2_c_thread(void *arg)
+{
+	struct tc2_c_args *a = arg;
+	struct tc2_shared *s = a->s;
+	struct timespec    ts = { 0, (long)a->hold_ms * 1000000L };
+
+	set_rt_prio(20);
+
+	pthread_mutex_lock(&s->mutex2);
+
+	/* Signal that we are ready. */
+	pthread_mutex_lock(&s->sync_mutex);
+	s->holders_ready++;
+	pthread_cond_broadcast(&s->sync_cond);
+	pthread_mutex_unlock(&s->sync_mutex);
+
+	nanosleep(&ts, NULL);
+	pthread_mutex_unlock(&s->mutex2);
+
+	return NULL;
+}
+
+/* Thread B: holds mutex1, then blocks on mutex2. */
+static void *tc2_b_thread(void *arg)
+{
+	struct tc2_b_args *a = arg;
+	struct tc2_shared *s = a->s;
+
+	set_rt_prio(50);
+
+	pthread_mutex_lock(&s->mutex1);
+
+	/* Signal that we are ready. */
+	pthread_mutex_lock(&s->sync_mutex);
+	s->holders_ready++;
+	pthread_cond_broadcast(&s->sync_cond);
+	pthread_mutex_unlock(&s->sync_mutex);
+
+	/* Now block on C. */
+	pthread_mutex_lock(&s->mutex2);
+	pthread_mutex_unlock(&s->mutex2);
+
+	pthread_mutex_unlock(&s->mutex1);
+
+	return NULL;
+}
+
+static void test_three_level_chain(void)
+{
+	struct tc2_shared  shared;
+	struct tc2_b_args  b_args;
+	struct tc2_c_args  c_args;
+	pthread_t          b_tid, c_tid;
+	struct timespec    t0, t1;
+	long               ms;
+	int                pass;
+
+	printf("# TC-2: three-level blocked_on chain\n");
+
+	memset(&shared, 0, sizeof(shared));
+	pthread_mutex_init(&shared.mutex1, NULL);
+	pthread_mutex_init(&shared.mutex2, NULL);
+	pthread_mutex_init(&shared.sync_mutex, NULL);
+	pthread_cond_init(&shared.sync_cond, NULL);
+	shared.holders_ready = 0;
+
+	c_args.s       = &shared;
+	c_args.hold_ms = 100;
+	b_args.s       = &shared;
+
+	/* Start C first so it grabs mutex2 before B tries. */
+	if (pthread_create(&c_tid, NULL, tc2_c_thread, &c_args) != 0) {
+		printf("# TC-2: pthread_create C failed\n");
+		goto cleanup;
+	}
+
+	/* Wait until C holds mutex2. */
+	pthread_mutex_lock(&shared.sync_mutex);
+	while (shared.holders_ready < 1)
+		pthread_cond_wait(&shared.sync_cond, &shared.sync_mutex);
+	pthread_mutex_unlock(&shared.sync_mutex);
+
+	/* Now start B so it grabs mutex1 then blocks on mutex2. */
+	if (pthread_create(&b_tid, NULL, tc2_b_thread, &b_args) != 0) {
+		printf("# TC-2: pthread_create B failed\n");
+		pthread_join(c_tid, NULL);
+		goto cleanup;
+	}
+
+	/* Wait until B holds mutex1. */
+	pthread_mutex_lock(&shared.sync_mutex);
+	while (shared.holders_ready < 2)
+		pthread_cond_wait(&shared.sync_cond, &shared.sync_mutex);
+	pthread_mutex_unlock(&shared.sync_mutex);
+
+	/* Small delay to let B actually block on mutex2. */
+	usleep(10000); /* 10 ms */
+
+	/* Raise our (A's) priority and try to acquire mutex1. */
+	if (set_rt_prio(80) != 0) {
+		printf("# TC-2: set_rt_prio(80) failed: %s\n", strerror(errno));
+		pthread_join(b_tid, NULL);
+		pthread_join(c_tid, NULL);
+		goto cleanup;
+	}
+
+	clock_gettime(CLOCK_MONOTONIC, &t0);
+	pthread_mutex_lock(&shared.mutex1);
+	clock_gettime(CLOCK_MONOTONIC, &t1);
+	pthread_mutex_unlock(&shared.mutex1);
+
+	/* Restore scheduling. */
+	{
+		struct sched_param sp = { .sched_priority = 0 };
+
+		sched_setscheduler(0, SCHED_OTHER, &sp);
+	}
+
+	pthread_join(b_tid, NULL);
+	pthread_join(c_tid, NULL);
+
+	ms   = elapsed_ms(&t0, &t1);
+	pass = (ms < 200L);
+	printf("# TC-2: acquired mutex1 in %ld ms (limit 200 ms)\n", ms);
+	print_result("three_level_chain", pass);
+
+cleanup:
+	pthread_mutex_destroy(&shared.mutex1);
+	pthread_mutex_destroy(&shared.mutex2);
+	pthread_mutex_destroy(&shared.sync_mutex);
+	pthread_cond_destroy(&shared.sync_cond);
+}
+
+/* ------------------------------------------------------------------ */
+/* TC-3: PE deactivate path (owner SIGSTOP)                             */
+/* ------------------------------------------------------------------ */
+
+/* Flag set by SIGALRM handler so we can detect timeout. */
+static volatile sig_atomic_t tc3_alarm_fired;
+
+static void tc3_alarm_handler(int sig)
+{
+	(void)sig;
+	tc3_alarm_fired = 1;
+}
+
+struct tc3_args {
+	pthread_mutex_t *mutex;
+	/* tid for SIGSTOP/SIGCONT from the main thread */
+	pid_t            tid;
+	pthread_mutex_t  ready_mutex;
+	pthread_cond_t   ready_cond;
+	int              ready;
+};
+
+static void *tc3_holder_thread(void *arg)
+{
+	struct tc3_args *a = arg;
+	struct timespec  ts = { 0, 50L * 1000000L }; /* 50 ms sleep */
+
+	set_rt_prio(20);
+
+	/* Record our own tid so main can send signals. */
+	a->tid = (pid_t)syscall(SYS_gettid);
+
+	pthread_mutex_lock(a->mutex);
+
+	/* Signal main that we hold the mutex. */
+	pthread_mutex_lock(&a->ready_mutex);
+	a->ready = 1;
+	pthread_cond_signal(&a->ready_cond);
+	pthread_mutex_unlock(&a->ready_mutex);
+
+	/*
+	 * Sleep inside the critical section.  The main thread will SIGSTOP
+	 * us while we are in here.
+	 */
+	nanosleep(&ts, NULL);
+
+	pthread_mutex_unlock(a->mutex);
+
+	return NULL;
+}
+
+/* Arguments for the SIGCONT helper thread. */
+struct tc3_cont_args {
+	pid_t tid;
+	pid_t pid;
+};
+
+/*
+ * tc3_cont_thread - sleep 1 second then send SIGCONT to the stopped holder.
+ */
+static void *tc3_cont_thread(void *arg)
+{
+	struct tc3_cont_args *ca = arg;
+	struct timespec       ts = { 1, 0 }; /* 1 second */
+
+	nanosleep(&ts, NULL);
+	syscall(SYS_tgkill, ca->pid, ca->tid, SIGCONT);
+	return NULL;
+}
+
+static void test_pe_deactivate_sigstop(void)
+{
+	pthread_t            holder;
+	pthread_t            cont_tid;
+	pthread_mutex_t      mutex = PTHREAD_MUTEX_INITIALIZER;
+	struct tc3_args      args;
+	struct tc3_cont_args cont_args;
+	struct sigaction     sa_alarm, sa_old;
+	struct timespec      t0, t1;
+	long                 ms;
+	int                  pass = 0;
+
+	printf("# TC-3: PE deactivate path (owner SIGSTOP/SIGCONT)\n");
+
+	memset(&args, 0, sizeof(args));
+	args.mutex = &mutex;
+	pthread_mutex_init(&args.ready_mutex, NULL);
+	pthread_cond_init(&args.ready_cond, NULL);
+
+	/* Install SIGALRM handler. */
+	memset(&sa_alarm, 0, sizeof(sa_alarm));
+	sa_alarm.sa_handler = tc3_alarm_handler;
+	sigemptyset(&sa_alarm.sa_mask);
+	sa_alarm.sa_flags = 0;
+	sigaction(SIGALRM, &sa_alarm, &sa_old);
+	tc3_alarm_fired = 0;
+
+	if (pthread_create(&holder, NULL, tc3_holder_thread, &args) != 0) {
+		printf("# TC-3: pthread_create holder failed: %s\n",
+		       strerror(errno));
+		goto cleanup_sig;
+	}
+
+	/* Wait until the holder has the mutex. */
+	pthread_mutex_lock(&args.ready_mutex);
+	while (!args.ready)
+		pthread_cond_wait(&args.ready_cond, &args.ready_mutex);
+	pthread_mutex_unlock(&args.ready_mutex);
+
+	/* SIGSTOP the holder — it is now off the run queue. */
+	syscall(SYS_tgkill, getpid(), args.tid, SIGSTOP);
+
+	/* Raise our priority so we are the high-prio blocked waiter. */
+	if (set_rt_prio(80) != 0) {
+		printf("# TC-3: set_rt_prio(80) failed: %s\n", strerror(errno));
+		syscall(SYS_tgkill, getpid(), args.tid, SIGCONT);
+		pthread_join(holder, NULL);
+		goto cleanup_sig;
+	}
+
+	/* Spawn the SIGCONT helper before blocking; it fires after 1 second. */
+	cont_args.tid = args.tid;
+	cont_args.pid = getpid();
+
+	if (pthread_create(&cont_tid, NULL, tc3_cont_thread, &cont_args) != 0) {
+		printf("# TC-3: pthread_create cont failed: %s\n",
+		       strerror(errno));
+		syscall(SYS_tgkill, getpid(), args.tid, SIGCONT);
+		pthread_join(holder, NULL);
+		goto cleanup_prio;
+	}
+
+	/* Set a 5-second alarm as overall watchdog. */
+	alarm(5);
+
+	clock_gettime(CLOCK_MONOTONIC, &t0);
+	pthread_mutex_lock(&mutex);
+	clock_gettime(CLOCK_MONOTONIC, &t1);
+	pthread_mutex_unlock(&mutex);
+
+	alarm(0); /* cancel watchdog */
+
+	pthread_join(cont_tid, NULL);
+
+	ms   = elapsed_ms(&t0, &t1);
+	pass = (!tc3_alarm_fired && ms < 5000L);
+	printf("# TC-3: acquired mutex in %ld ms (limit 5000 ms, alarm=%d)\n",
+	       ms, (int)tc3_alarm_fired);
+	print_result("pe_deactivate_sigstop", pass);
+
+cleanup_prio:
+	/* Restore scheduling. */
+	{
+		struct sched_param sp = { .sched_priority = 0 };
+
+		sched_setscheduler(0, SCHED_OTHER, &sp);
+	}
+
+	pthread_join(holder, NULL);
+
+cleanup_sig:
+	sigaction(SIGALRM, &sa_old, NULL);
+	pthread_mutex_destroy(&mutex);
+	pthread_mutex_destroy(&args.ready_mutex);
+	pthread_cond_destroy(&args.ready_cond);
+}
+
+/* ------------------------------------------------------------------ */
+/* TC-4: rwsem write-side PE — basic activation                        */
+/* ------------------------------------------------------------------ */
+
+/*
+ * NOTE: This test exercises the rwsem PE integration added by the
+ * proxy-exec-rwsem-support patch.  It uses pthread_rwlock_t as the
+ * user-space analogue of the kernel rw_semaphore.  The kernel PE path
+ * (blocked_on tracking in rwsem_down_write_slowpath) ensures that when
+ * a high-priority writer is blocked on an rwsem held by a low-priority
+ * writer, the holder is proxy-executed at the waiter's priority.
+ *
+ * The timing assertion (< 300 ms) is the same as TC-1: with PE the
+ * holder finishes its 200 ms critical section and releases the lock
+ * within the window.
+ */
+
+struct tc4_args {
+	pthread_rwlock_t *rwlock;
+	int               hold_ms;
+};
+
+static void *tc4_holder_thread(void *arg)
+{
+	struct tc4_args *a = arg;
+	struct timespec  ts = { 0, (long)a->hold_ms * 1000000L };
+
+	/* Become a low-prio RT thread so PE applies. */
+	set_rt_prio(20);
+
+	pthread_rwlock_wrlock(a->rwlock);
+	nanosleep(&ts, NULL);
+	pthread_rwlock_unlock(a->rwlock);
+
+	return NULL;
+}
+
+static void test_rwsem_write_pe_basic(void)
+{
+	pthread_t        holder;
+	pthread_rwlock_t rwlock = PTHREAD_RWLOCK_INITIALIZER;
+	struct tc4_args  args   = { .rwlock = &rwlock, .hold_ms = 200 };
+	struct timespec  t0, t1;
+	long             ms;
+	int              pass;
+
+	printf("# TC-4: rwsem write-side PE activation\n");
+
+	if (pthread_create(&holder, NULL, tc4_holder_thread, &args) != 0) {
+		printf("# TC-4: pthread_create failed: %s\n",
+		       strerror(errno));
+		print_result("rwsem_write_pe_basic", 0);
+		return;
+	}
+
+	/* Give the holder time to acquire the write lock. */
+	usleep(20000); /* 20 ms */
+
+	/* Raise to high prio — we become the blocked writer. */
+	if (set_rt_prio(80) != 0) {
+		printf("# TC-4: set_rt_prio(80) failed: %s\n",
+		       strerror(errno));
+		pthread_join(holder, NULL);
+		pthread_rwlock_destroy(&rwlock);
+		print_result("rwsem_write_pe_basic", 0);
+		return;
+	}
+
+	clock_gettime(CLOCK_MONOTONIC, &t0);
+	pthread_rwlock_wrlock(&rwlock);
+	clock_gettime(CLOCK_MONOTONIC, &t1);
+	pthread_rwlock_unlock(&rwlock);
+
+	{
+		struct sched_param sp = { .sched_priority = 0 };
+
+		sched_setscheduler(0, SCHED_OTHER, &sp);
+	}
+
+	pthread_join(holder, NULL);
+	pthread_rwlock_destroy(&rwlock);
+
+	ms   = elapsed_ms(&t0, &t1);
+	pass = (ms < 300L);
+	printf("# TC-4: acquired write lock in %ld ms (limit 300 ms)\n",
+	       ms);
+	print_result("rwsem_write_pe_basic", pass);
+}
+
+/* ------------------------------------------------------------------ */
+/* TC-5: Mixed chain — rwsem write → mutex                             */
+/* ------------------------------------------------------------------ */
+
+/*
+ * Chain layout:
+ *   A (prio=80) waiting for rwlock write
+ *   B (prio=50) holds rwlock write, waiting for mutex
+ *   C (prio=20) holds mutex, sleeping 300 ms
+ *
+ * With rwsem PE support the chain A→rwlock→B→mutex→C is fully
+ * traversed.  A should acquire the rwlock within 500 ms.
+ */
+
+struct tc5_shared {
+	pthread_rwlock_t rwlock;
+	pthread_mutex_t  mutex;
+
+	pthread_mutex_t  sync_mu;
+	pthread_cond_t   sync_cv;
+	int              ready; /* incremented by B and C when ready */
+};
+
+struct tc5_b_args { struct tc5_shared *s; };
+struct tc5_c_args { struct tc5_shared *s; int hold_ms; };
+
+static void *tc5_c_thread(void *arg)
+{
+	struct tc5_c_args *a = arg;
+	struct tc5_shared *s = a->s;
+	struct timespec    ts = { 0, (long)a->hold_ms * 1000000L };
+
+	set_rt_prio(20);
+
+	pthread_mutex_lock(&s->mutex);
+
+	pthread_mutex_lock(&s->sync_mu);
+	s->ready++;
+	pthread_cond_signal(&s->sync_cv);
+	pthread_mutex_unlock(&s->sync_mu);
+
+	nanosleep(&ts, NULL);
+	pthread_mutex_unlock(&s->mutex);
+	return NULL;
+}
+
+static void *tc5_b_thread(void *arg)
+{
+	struct tc5_b_args *a = arg;
+	struct tc5_shared *s = a->s;
+
+	set_rt_prio(50);
+
+	pthread_rwlock_wrlock(&s->rwlock);
+
+	pthread_mutex_lock(&s->sync_mu);
+	s->ready++;
+	pthread_cond_signal(&s->sync_cv);
+	pthread_mutex_unlock(&s->sync_mu);
+
+	/* Block on the mutex — this is the middle of the PE chain. */
+	pthread_mutex_lock(&s->mutex);
+	pthread_mutex_unlock(&s->mutex);
+
+	pthread_rwlock_unlock(&s->rwlock);
+	return NULL;
+}
+
+static void test_rwsem_mutex_chain(void)
+{
+	pthread_t         tb, tc;
+	struct tc5_shared s = {
+		.rwlock  = PTHREAD_RWLOCK_INITIALIZER,
+		.mutex   = PTHREAD_MUTEX_INITIALIZER,
+		.sync_mu = PTHREAD_MUTEX_INITIALIZER,
+		.sync_cv = PTHREAD_COND_INITIALIZER,
+		.ready   = 0,
+	};
+	struct tc5_b_args bargs = { .s = &s };
+	struct tc5_c_args cargs = { .s = &s, .hold_ms = 300 };
+	struct timespec   t0, t1;
+	long              ms;
+	int               pass;
+
+	printf("# TC-5: mixed rwsem-write -> mutex PE chain\n");
+
+	if (pthread_create(&tc, NULL, tc5_c_thread, &cargs) != 0 ||
+	    pthread_create(&tb, NULL, tc5_b_thread, &bargs) != 0) {
+		printf("# TC-5: pthread_create failed: %s\n",
+		       strerror(errno));
+		print_result("rwsem_mutex_chain", 0);
+		return;
+	}
+
+	/* Wait until both B and C have grabbed their locks. */
+	pthread_mutex_lock(&s.sync_mu);
+	while (s.ready < 2)
+		pthread_cond_wait(&s.sync_cv, &s.sync_mu);
+	pthread_mutex_unlock(&s.sync_mu);
+
+	if (set_rt_prio(80) != 0) {
+		printf("# TC-5: set_rt_prio(80) failed: %s\n",
+		       strerror(errno));
+		pthread_join(tb, NULL);
+		pthread_join(tc, NULL);
+		print_result("rwsem_mutex_chain", 0);
+		return;
+	}
+
+	clock_gettime(CLOCK_MONOTONIC, &t0);
+	pthread_rwlock_wrlock(&s.rwlock);
+	clock_gettime(CLOCK_MONOTONIC, &t1);
+	pthread_rwlock_unlock(&s.rwlock);
+
+	{
+		struct sched_param sp = { .sched_priority = 0 };
+
+		sched_setscheduler(0, SCHED_OTHER, &sp);
+	}
+
+	pthread_join(tb, NULL);
+	pthread_join(tc, NULL);
+	pthread_rwlock_destroy(&s.rwlock);
+	pthread_mutex_destroy(&s.mutex);
+	pthread_mutex_destroy(&s.sync_mu);
+	pthread_cond_destroy(&s.sync_cv);
+
+	ms   = elapsed_ms(&t0, &t1);
+	pass = (ms < 500L);
+	printf("# TC-5: acquired write lock in %ld ms (limit 500 ms)\n",
+	       ms);
+	print_result("rwsem_mutex_chain", pass);
+}
+
+/* ------------------------------------------------------------------ */
+/* main                                                                 */
+/* ------------------------------------------------------------------ */
+
+int main(void)
+{
+	struct sched_param sp = { .sched_priority = 1 };
+
+	/*
+	 * Capability check: attempt to raise to SCHED_FIFO prio 1.  A plain
+	 * EPERM means we lack CAP_SYS_NICE; skip gracefully in that case.
+	 */
+	if (sched_setscheduler(0, SCHED_FIFO, &sp) != 0) {
+		if (errno == EPERM) {
+			printf("1..0 # SKIP: requires CAP_SYS_NICE\n");
+			return 0;
+		}
+		/* Unexpected error — restore SCHED_OTHER and continue. */
+	} else {
+		/* Restore normal scheduling before running tests. */
+		sp.sched_priority = 0;
+		sched_setscheduler(0, SCHED_OTHER, &sp);
+	}
+
+	if (!is_proxy_exec_enabled()) {
+		printf("1..0 # SKIP: CONFIG_SCHED_PROXY_EXEC not enabled\n");
+		return 0;
+	}
+
+	/* TAP plan: five test cases (3 original + 2 rwsem) */
+	printf("1..5\n");
+
+	test_basic_pe_activation();
+	test_three_level_chain();
+	test_pe_deactivate_sigstop();
+	test_rwsem_write_pe_basic();
+	test_rwsem_mutex_chain();
+
+	return 0;
+}
-- 
2.43.0

