Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38AA3793D2
	for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 10:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986529; cv=none; b=UwMOoimf7sMda61wdA3cawVvnDJhUUUnk1N9kxFWdTXFhhA87uPYp0S4dfaizq0tWJyhrA+3LDIl5jUrTqX0IhdLKfEhRbQy1FPtPvyAIpgxGODkMvXNv88wiQ4dr+9gFC6pBul9IKFLN4VNYtms9XztT9/zKd1GF8s+sy79MvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986529; c=relaxed/simple;
	bh=sYhPUGl65bZ+4ee7sBhE6hINVTPoB6kNjqfY6Um4gBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U2jZwq/+h24Wgiqae0SpkIEOZdI+KfwJXurnbEC7U60qkZyQqgiLpJBxeAA9U/5sI0cFt1OcFGab/otkNsg/0CU06wPxPNiDjNkO53hTHPIV41Hr7ReXfZDZdk88P7z4txSY4udh2qVuTnH/Q+m7TVL2T8iOtwth/K2U9PIefIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KaD0+Nm2; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KaD0+Nm2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=fO
	hX8Z+aPaewGfrUCGmPORCJ2ZVP5l81gADINLPc0Qc=; b=KaD0+Nm2iKYjdh8znO
	djzdcEYZ6CFFlpCRRnQHQ/bF3J8hGQcObC5pBCwAy64o3p2rMwWzQXv5AcdMJFey
	WdhSVJJ01IYXzH2taMKGXTsxzPkTq+ueyDHlGJwdFgGWtUId+8qE6ZF5EeohwNZm
	9V3nz6pdN0P7t8Zqj8SINSy0c=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3V22eBrFqr5HoBw--.320S2;
	Mon, 21 Sep 2026 18:27:43 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <jstultz@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun@kernel.org>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Quchaosheng <quchaosheng000406@163.com>
Subject: [PATCH v2] sched/proxy: allow SCHED_PROXY_EXEC with PREEMPT_RT
Date: Mon, 21 Sep 2026 18:27:12 +0800
Message-ID: <20260921102712.3245860-1-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3V22eBrFqr5HoBw--.320S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxtw47tFW8Jw15Zry5Gr1UAwb_yoWDJrW8pa
	1DKrW7Ja1DGFyI9ry7Aws7W390yw1kCa1fAFykKa109r98tr40vr1vgF1a9r1FqrWIqFWa
	qr4YgryYkF1j9r7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pR_uctUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC5ACwJmqxBqAkKQAA3C

CONFIG_SCHED_PROXY_EXEC could not be enabled together with
CONFIG_PREEMPT_RT. The Kconfig entry carried a "depends on !PREEMPT_RT"
with the comment "Avoid some build failures w/ PREEMPT_RT until it can be
fixed", and the failures are real: building kernel/sched/core.c with both
options set gives:

  kernel/sched/core.c:6927: error: passing argument 2 of 'clear_task_blocked_on' from incompatible pointer type
  kernel/sched/core.c:6939: error: 'struct mutex' has no member named 'wait_lock'
  kernel/sched/core.c:6943: error: implicit declaration of function '__get_task_blocked_on'
  kernel/sched/core.c:6956: error: implicit declaration of function '__mutex_owner'

The proxy execution machinery tracks a task's blocked-on mutex through
task_struct::blocked_on and walks that chain in find_proxy_task(). It was
written against the native struct mutex, which embeds wait_lock directly
and keeps the owner in atomic_long_t owner.

On PREEMPT_RT, struct mutex is instead a wrapper around struct rt_mutex,
so both live in the embedded rt_mutex_base: wait_lock is
rtmutex.wait_lock and the owner is reachable via rt_mutex_owner(). On top
of that, the RT variants of the blocked_on accessors were stubbed out with
a struct rt_mutex * parameter, so find_proxy_task() could not even compile.

The set of errors has two independent causes, addressed separately:

1. Header type mismatch. The PREEMPT_RT branch of the blocked_on helpers
   was declared with "struct rt_mutex *" while every caller passes a
   "struct mutex *". That parameter type came from __ww_mutex_die() and
   __ww_mutex_wound() in ww_mutex.h, which are shared with the WW_RT
   instantiation where the MUTEX macro expands to struct rt_mutex. Those
   two call sites are now compiled out for WW_RT, making the helpers
   consistently take a "struct mutex *". This is not a behavioural change
   for WW_RT: the blocked_on relation is only maintained for native
   mutexes, and an rt_mutex based lock relies on the rtmutex priority
   inheritance chain instead.

2. Data structure access. Add mutex_wait_lock(), which returns the
   wait_lock of either mutex implementation, and provide a
   PREEMPT_RT __mutex_owner() that reads rt_mutex_base::owner, so that
   find_proxy_task() works on both.

With that, the Kconfig restriction can be dropped.

Note that this makes the combination build and boot; it does not make
proxy execution actually do anything useful on PREEMPT_RT. A task's
blocked_on is only ever set by the native mutex slow path, which is
compiled out when PREEMPT_RT is set, so task_is_blocked() is always false
and find_proxy_task() is never reached. An rt_mutex already provides
priority inheritance, so there is no blocked_on chain to follow either.
Making proxy execution functional on PREEMPT_RT would require the RT
mutex implementation to maintain blocked_on as well; that is not part of
this change.

Verified with a full x86_64 build plus a QEMU boot of the resulting
SMP PREEMPT_RT kernel, both with and without CONFIG_SCHED_PROXY_EXEC and
with PROVE_LOCKING, DEBUG_ATOMIC_SLEEP and DEBUG_PREEMPT enabled. The
kernel boots clean and an 8-thread SCHED_FIFO pthread mutex stress loop
runs without any BUG or WARNING.

Signed-off-by: Quchaosheng <quchaosheng000406@163.com>

---

Link to v1: https://lore.kernel.org/all/20260921081525.2982361-1-quchaosheng000406@163.com/

Changes in v2:
 - Corrected Cc list. Boqun Feng's address in v1 was wrong and the copy sent
   to him bounced; it is boqun@kernel.org. linux-rt-devel is Cc'd as well, as
   that is what get_maintainer.pl reports for the PREEMPT_RT keyword. Nothing
   in the code depends on this.
 - Restored the indentation of the __ww_mutex_wound() comment block, which v1
   had re-indented by accident. Whitespace only.
 - Reworded the note about proxy execution remaining inactive on PREEMPT_RT.
   v1 stated that replacing rt_mutexes was tracked as future work in the proxy
   execution series, which I cannot point at. It now describes the mechanism
   instead: p->blocked_on is only ever set from the native mutex slow path,
   which is compiled out when PREEMPT_RT is set, so task_is_blocked() is false
   and find_proxy_task() is not reached there.

No functional change relative to v1.
 include/linux/sched.h     | 11 -----------
 init/Kconfig              |  6 ++++--
 kernel/locking/mutex.h    | 36 ++++++++++++++++++++++++++++++++++--
 kernel/locking/ww_mutex.h |  8 ++++++++
 kernel/sched/core.c       |  2 +-
 5 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 705970d07614..334935d0ab55 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2216,8 +2216,6 @@ extern int __cond_resched_rwlock_write(rwlock_t *lock) __must_hold(lock);
 	__cond_resched_rwlock_write(lock);					\
 })
 
-#ifndef CONFIG_PREEMPT_RT
-
 static inline struct mutex *__get_task_blocked_on(struct task_struct *p)
 {
 	lockdep_assert_held_once(&p->blocked_lock);
@@ -2258,15 +2256,6 @@ static inline void clear_task_blocked_on(struct task_struct *p, struct mutex *m)
 	guard(raw_spinlock_irqsave)(&p->blocked_lock);
 	__clear_task_blocked_on(p, m);
 }
-#else
-static inline void __clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
-{
-}
-
-static inline void clear_task_blocked_on(struct task_struct *p, struct rt_mutex *m)
-{
-}
-#endif /* !CONFIG_PREEMPT_RT */
 
 static __always_inline bool need_resched(void)
 {
diff --git a/init/Kconfig b/init/Kconfig
index 8583d9f06c52..c4fca7951658 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -936,8 +936,6 @@ config UCLAMP_BUCKETS_COUNT
 
 config SCHED_PROXY_EXEC
 	bool "Proxy Execution"
-	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
-	depends on !PREEMPT_RT
 	# Need to investigate how to inform sched_ext of split contexts
 	depends on !SCHED_CLASS_EXT
 	# Not particularly useful until we get to multi-rq proxying
@@ -946,6 +944,10 @@ config SCHED_PROXY_EXEC
 	  This option enables proxy execution, a mechanism for mutex-owning
 	  tasks to inherit the scheduling context of higher priority waiters.
 
+	  On PREEMPT_RT the mutex implementation already provides priority
+	  inheritance via rt_mutex, so proxy execution has no blocked_on
+	  chains to follow and the feature is effectively inactive there.
+
 endmenu
 
 #
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 3e263e98e5fc..4e8b26840669 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -6,8 +6,25 @@
  *
  *  Copyright (C) 2004, 2005, 2006 Red Hat, Inc., Ingo Molnar <mingo@redhat.com>
  */
-#ifndef CONFIG_PREEMPT_RT
 #include <linux/mutex.h>
+
+/*
+ * Where a mutex keeps its wait_lock differs between the two mutex
+ * implementations: native mutexes embed it directly, while PREEMPT_RT mutexes
+ * wrap an rt_mutex and keep it in rt_mutex_base. Provide a common accessor for
+ * the scheduler's proxy-execution code, which takes this lock to pin down a
+ * mutex owner.
+ */
+static inline raw_spinlock_t *mutex_wait_lock(struct mutex *lock)
+{
+#ifdef CONFIG_PREEMPT_RT
+	return &lock->rtmutex.wait_lock;
+#else
+	return &lock->wait_lock;
+#endif
+}
+
+#ifndef CONFIG_PREEMPT_RT
 /*
  * This is the control structure for tasks blocked on mutex, which resides
  * on the blocked task's kernel stack:
@@ -76,4 +93,19 @@ extern void debug_mutex_init(struct mutex *lock);
 # define debug_mutex_unlock(lock)			do { } while (0)
 # define debug_mutex_init(lock)				do { } while (0)
 #endif /* !CONFIG_DEBUG_MUTEXES */
-#endif /* CONFIG_PREEMPT_RT */
+
+#else /* CONFIG_PREEMPT_RT */
+
+/*
+ * On PREEMPT_RT a mutex is an rt_mutex, which keeps track of its owner in
+ * rt_mutex_base::owner. Expose it through the same helper the native mutex
+ * path uses so that the proxy-execution scheduler code builds for both.
+ */
+static inline struct task_struct *__mutex_owner(struct mutex *lock)
+{
+	if (!lock)
+		return NULL;
+	return rt_mutex_owner(&lock->rtmutex);
+}
+
+#endif /* !CONFIG_PREEMPT_RT */
diff --git a/kernel/locking/ww_mutex.h b/kernel/locking/ww_mutex.h
index d62b49b53ec3..73495b074b65 100644
--- a/kernel/locking/ww_mutex.h
+++ b/kernel/locking/ww_mutex.h
@@ -323,8 +323,14 @@ __ww_mutex_die(struct MUTEX *lock, struct MUTEX_WAITER *waiter,
 		 * When waking up the task to die, be sure to set the
 		 * blocked_on to PROXY_WAKING. Otherwise we can see
 		 * circular blocked_on relationships that can't resolve.
+		 *
+		 * The blocked_on relation is only maintained for native
+		 * mutexes; on PREEMPT_RT an rt_mutex based lock relies on
+		 * priority inheritance instead.
 		 */
+#ifndef WW_RT
 		clear_task_blocked_on(waiter->task, lock);
+#endif
 		wake_q_add(wake_q, waiter->task);
 	}
 
@@ -383,7 +389,9 @@ static bool __ww_mutex_wound(struct MUTEX *lock,
 			 * are waking the mutex owner, who may be currently
 			 * blocked on a different mutex.
 			 */
+#ifndef WW_RT
 			clear_task_blocked_on(owner, NULL);
+#endif
 			wake_q_add(wake_q, owner);
 		}
 		return true;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b998ef6b87af..dcad037cbc08 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6936,7 +6936,7 @@ find_proxy_task(struct rq *rq, struct task_struct *donor, struct rq_flags *rf)
 		 * By taking mutex->wait_lock we hold off concurrent mutex_unlock()
 		 * and ensure @owner sticks around.
 		 */
-		guard(raw_spinlock)(&mutex->wait_lock);
+		guard(raw_spinlock)(mutex_wait_lock(mutex));
 		guard(raw_spinlock)(&p->blocked_lock);
 
 		/* Check again that p is blocked with blocked_lock held */
-- 
2.43.0

