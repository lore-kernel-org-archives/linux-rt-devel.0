Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE4038E12B
	for <linux-rt-devel@lists.linux.dev>; Sat,  8 Aug 2026 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786194165; cv=none; b=oC+eD1CByfw9Yus458St/SzeOdGB2Bk5Bv/lf5pbXSvK7DmfmyPxvi3YSpI/o3z0zdE4cbuSyshTTtjIvFMXNRrqjCd5OlLeHK6FlIhEkY1cL2RsQsnUuIqkrnFBQ4W0g24H/ANJRuUdSUO3TUlMNb7nLLFRDPxkaMHjUb2ezoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786194165; c=relaxed/simple;
	bh=Fz8uUuJuZicLOuefarTv8QYWKTzU19sc/T7t7JLcAKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h6XZIK0IBJZgHunoGknyp5QcNGmlTYSswe+PTFRPMXEeUBHjvkH2K+JQsHXOodgs1h4F7X2tTQ/0CWlLJHDbKMq21bf98TgxNfDsuGthA4K80gG1iWPaqndcVTQN5WdE6uzeGtZ70Wzo+gTyrqDAOdLTf96Ec+uRIVmzIdvhTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oDEpC6zv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oDEpC6zv"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cf52d15d88so3391455ad.2
        for <linux-rt-devel@lists.linux.dev>; Sat, 08 Aug 2026 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786194160; x=1786798960; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcsQzzuEG+9D2g/tQc/6AnTj5eKcDL5LL0P3pegqw9k=;
        b=oDEpC6zvWukfmweS1LTwhrxgJ2gOCOST6NhzufRIThkr+HrQmGsUcxqqHZgV08MrVH
         6DW2rb8Y97/EEO4VcnQQhS/6VEUxXzoN4G5sUdDe5bdPK10EGCuP1qOUf7hCfx8h7kgU
         jTtqLeskHvdvdlTKM9Ry/DS9kok2VkCYgdqpTxY+VBfng37nnSZYrTCGcZYxBpluy7Vm
         IJ7HzMvjv9euy6v8dPkp3TDiikmi/lCVADZf2gMtE8BpBytc/qv/af/lrOqS/h4HqUvR
         cAZz42jgp/0eLjQ84/gTnczCrU5PgZfa5R9nsGMWN9D+b3OkFMKLykB4sx6nT7FVSIRf
         /XOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786194160; x=1786798960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DcsQzzuEG+9D2g/tQc/6AnTj5eKcDL5LL0P3pegqw9k=;
        b=TndEXKUm1QMaq7ZIYLbfkRF4k6fkzsiR/NRZzCQ1oJ56dgNClSyQQqt8EhJ+N5ujxO
         2qvQuhbQxXkszNzvkW5KhG78stT0YfLVC0TGTW65KL34qmeKprXeej8foSf9Nqc1o0a/
         5M63XMzBrbIKEwwdl/AcLdBOUNUEGrlp+BHlRaZeYW4C96pnnKWxNS1dw6aMlhBq62qC
         OXhPa9Eg3ubCQjsTK8EIbZNi8yIfjPimXLXoHmLdME3GU42JXXc2dRbPaOV9bgfR8CD3
         v/kDKUUKu7SdarXVlo0epD4d1tVNhjx2RM4ec2gvmhQG2KUfwZqV8MvN11Zjq2r7SyhN
         L49A==
X-Forwarded-Encrypted: i=1; AHgh+Rr1y9JjxJTrSpfHo+J5jGKMZMbwG8TgcYef68Dn2sN66U/3uJgNWJC6Ld8JOM5ComefaRv1bMMzwMAxwirpTw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFEH+mRb87ERzjGFF6A5Mu9kc7eXYR8Uiby0H7A6Tz19Ipe8fj
	LYgf7KAnjLIHwvr5SFWn3pQknRLDA49UtkForPqaHZLxnc+H+Hlwb/pi
X-Gm-Gg: AR+sD126/L8/LB1xzGq6oJEEzgS8KAD9Ll0Pgq3dt6DnBf4nZNvRRvHj2dI4Vdg7kLE
	btIvFXQRByaq8TFitFM8AtAByyDzZrav5m9C2CkEbMdU72Fk4zpg6X/lfTZOWkJXrno+oS+TckN
	nDMYGwAk4+qwYVKldYBEiozDvGpu9SkJ6ZGOqe7uTMju1g9GHcWWkeLY2R8saQ436587pgCP1pc
	18nex5PwfD8wZxZhrYn5/enQqQq3B75nXB/o/ibVci+fb96lJwZXsi2GBPusZtuUzc/8GOLvBo+
	iWGnO99y3pqE4wVV9gIdS5MTDviuto80W897tIQW44dYP5aTVKexA0IE/xSQmwlaeoRAPs11y5r
	R4YFa0pOk9kWp/OUPlDpq7gGbhf3EWbMHSjVhQ/MInQS5cccf74SnwmKqlWQ8mXVBEdLYZlcsGq
	w843OqTqRtlE1/9nhZdoN6JRwbknZCei4sbGTij9K2zaM45OibSQi4V1gFQULEf3wcG87SGJ8F6
	i1wHSSxDlObqSfoQEBzUY9+rAEGCYE7
X-Received: by 2002:a17:902:ebc2:b0:2cc:d69a:354a with SMTP id d9443c01a7336-2d2a8eb76e2mr101854685ad.22.1786194159557;
        Sat, 08 Aug 2026 06:02:39 -0700 (PDT)
Received: from lixiang-ThinkCentre-M755e-N000.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccae6f8sm18584645ad.1.2026.08.08.06.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 06:02:37 -0700 (PDT)
From: ruipengqi <ruipengqi3@gmail.com>
To: akpm@linux-foundation.org,
	peterz@infradead.org,
	bigeasy@linutronix.de
Cc: lance.yang@linux.dev,
	mhiramat@kernel.org,
	pmladek@suse.com,
	mingo@redhat.com,
	will@kernel.org,
	boqun@kernel.org,
	longman@redhat.com,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	ruipengqi3@gmail.com,
	Zhan Xusheng <zhanxusheng1024@gmail.com>
Subject: [PATCH v2 1/2] hung_task: show the blocker task if the task is hung on rtmutex
Date: Sat,  8 Aug 2026 21:02:17 +0800
Message-Id: <51d7411207693824ee515b62a31c2a3d76fdf0d4.1786193045.git.ruipengqi3@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1786193045.git.ruipengqi3@gmail.com>
References: <cover.1786193045.git.ruipengqi3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruipeng Qi <ruipengqi3@gmail.com>

Currently, debug_show_blocker() only tracks mutex, semaphore and rwsem
lock types. Extend it to also cover rtmutex or rt_mutex-based lock
implementations on PREEMPT_RT, so that when a task is hung on an
rtmutex, the hung task detector can identify and report which task holds
the lock.

Add rt_mutex_task_owner() to get the task's lock owner when a task is
blocked by an rtmutex-based lock implementation.

Since the LSBs of task->blocker pointer are already fully utilized and
leave no room for new blocker types, this version avoids adding a new
blocker type by directly leveraging rt_mutex_task_owner() to retrieve
the lock owner information.

With this change, the hung task detector can now show blocker task's
info like below:

[ 3000.899985] INFO: task cat:195 blocked for more than 120 seconds.
[ 3000.900561]       Not tainted 7.2.0-rc4-00366-gf339a6eb59f3-dirty #22
[ 3000.900930] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3000.901376] task:cat             state:D stack:13784 pid:195   tgid:195   ppid:1      task_flags:0x400000 flags:0x00080000
[ 3000.902081] Call Trace:
[ 3000.902233]  <TASK>
[ 3000.902383]  __schedule+0x514/0xf50
[ 3000.902677]  rt_mutex_schedule+0x1b/0x30
[ 3000.902916]  rt_mutex_slowlock_block.constprop.0+0x3b/0x1c0
[ 3000.903242]  __rt_mutex_slowlock_locked.constprop.0+0xa8/0x200
[ 3000.903716]  rt_mutex_slowlock.constprop.0+0x48/0xb0
[ 3000.904023]  rt_mutex_lock+0x32/0x40
[ 3000.904249]  read_dummy_rtmutex+0x2a/0x60 [hung_task_tests]
[ 3000.904647]  full_proxy_read+0x5b/0x90
[ 3000.904843]  vfs_read+0xb0/0x370
[ 3000.905051]  ? vm_mmap_pgoff+0xf1/0x1b0
[ 3000.905293]  ? vm_mmap_pgoff+0x122/0x1b0
[ 3000.905684]  ksys_read+0x68/0xe0
[ 3000.905980]  do_syscall_64+0xf9/0x540
[ 3000.906213]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 3000.906643] RIP: 0033:0x49a182
[ 3000.906844] RSP: 002b:00007ffc431f6528 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 3000.907251] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000049a182
[ 3000.907673] RDX: 0000000000010000 RSI: 00007f69b2166000 RDI: 0000000000000003
[ 3000.908044] RBP: 00007f69b2166000 R08: 00000000ffffffff R09: 0000000000000000
[ 3000.908485] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000010000
[ 3000.908816] R13: 0000000000000003 R14: 0000000000000001 R15: 0000000001000000
[ 3000.909206]  </TASK>
[ 3000.909351] INFO: task cat:195 is blocked on a rtmutex likely owned by task cat:194.
[ 3000.909832] task:cat             state:S stack:13784 pid:194   tgid:194   ppid:1      task_flags:0x400000 flags:0x00080000
[ 3000.910426] Call Trace:
[ 3000.910618]  <TASK>
[ 3000.910727]  __schedule+0x514/0xf50
[ 3000.910912]  schedule+0x22/0xa0
[ 3000.911064]  schedule_timeout+0x81/0x100
[ 3000.911254]  ? __pfx_process_timeout+0x10/0x10
[ 3000.911522]  msleep_interruptible+0x28/0x50
[ 3000.911754]  read_dummy_rtmutex+0x34/0x60 [hung_task_tests]
[ 3000.912019]  full_proxy_read+0x5b/0x90
[ 3000.912212]  vfs_read+0xb0/0x370
[ 3000.912378]  ? vm_mmap_pgoff+0xf1/0x1b0
[ 3000.912630]  ? vm_mmap_pgoff+0x122/0x1b0
[ 3000.912839]  ksys_read+0x68/0xe0
[ 3000.913007]  do_syscall_64+0xf9/0x540
[ 3000.913187]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[ 3000.913461] RIP: 0033:0x49a182
[ 3000.913618] RSP: 002b:00007ffd0b4cf048 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[ 3000.913972] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000049a182
[ 3000.914294] RDX: 0000000000010000 RSI: 00007fbf49a0d000 RDI: 0000000000000003
[ 3000.914648] RBP: 00007fbf49a0d000 R08: 00000000ffffffff R09: 0000000000000000
[ 3000.914955] R10: 0000000000000022 R11: 0000000000000246 R12: 0000000000010000
[ 3000.915208] R13: 0000000000000003 R14: 0000000000000001 R15: 0000000001000000
[ 3000.915439]  </TASK>

Suggested-by: Petr Mladek <pmladek@suse.com>
Suggested-by: Zhan Xusheng <zhanxusheng1024@gmail.com>
Signed-off-by: Ruipeng Qi <ruipengqi3@gmail.com>

---
v2 changes:
 - Reduce #ifdef-ery by using rt_mutex_task_owner() instead of adding a new blocker type.
 - Remove the unused function debug_trace_blocker().
 - Clean up and update relevant comments.
---
 include/linux/rtmutex.h      |  2 ++
 kernel/hung_task.c           | 26 +++++++++++++++++++++++---
 kernel/locking/rtmutex_api.c | 29 +++++++++++++++++++++++++++++
 lib/Kconfig.debug            |  1 -
 4 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/include/linux/rtmutex.h b/include/linux/rtmutex.h
index 9e1f012f89db89..c179f946d2d040 100644
--- a/include/linux/rtmutex.h
+++ b/include/linux/rtmutex.h
@@ -53,6 +53,8 @@ static inline struct task_struct *rt_mutex_owner(struct rt_mutex_base *lock)
 
 	return (struct task_struct *) (owner & ~RT_MUTEX_HAS_WAITERS);
 }
+
+extern struct task_struct *rt_mutex_task_owner(struct task_struct *task);
 #endif
 extern void rt_mutex_base_init(struct rt_mutex_base *rtb);
 
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 6fcc94ce4ca9d2..9467011f878c95 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -27,6 +27,7 @@
 #include <linux/sys_info.h>
 
 #include <trace/events/sched.h>
+#include <linux/rtmutex.h>
 
 /*
  * The number of tasks checked:
@@ -139,9 +140,19 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
 	struct task_struct *g, *t;
 	unsigned long owner, blocker, blocker_type;
 	const char *rwsem_blocked_by, *rwsem_blocked_as;
+	bool is_rtmutex = false;
 
 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "No rcu lock held");
 
+#if defined(CONFIG_RT_MUTEXES)
+	owner = (unsigned long)rt_mutex_task_owner(task);
+	if (owner) {
+		is_rtmutex = true;
+		blocker_type = -1;
+		goto found;
+	}
+#endif
+
 	blocker = READ_ONCE(task->blocker);
 	if (!blocker)
 		return;
@@ -149,12 +160,13 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
 	blocker_type = hung_task_get_blocker_type(blocker);
 
 	switch (blocker_type) {
-	case BLOCKER_TYPE_MUTEX:
-		owner = mutex_get_owner(hung_task_blocker_to_lock(blocker));
-		break;
 	case BLOCKER_TYPE_SEM:
 		owner = sem_last_holder(hung_task_blocker_to_lock(blocker));
 		break;
+#ifndef CONFIG_PREEMPT_RT
+	case BLOCKER_TYPE_MUTEX:
+		owner = mutex_get_owner(hung_task_blocker_to_lock(blocker));
+		break;
 	case BLOCKER_TYPE_RWSEM_READER:
 	case BLOCKER_TYPE_RWSEM_WRITER:
 		owner = (unsigned long)rwsem_owner(
@@ -165,6 +177,7 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
 					hung_task_blocker_to_lock(blocker)) ?
 					"reader" : "writer";
 		break;
+#endif
 	default:
 		WARN_ON_ONCE(1);
 		return;
@@ -190,6 +203,7 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
 		return;
 	}
 
+found:
 	/* Ensure the owner information is correct. */
 	for_each_process_thread(g, t) {
 		if ((unsigned long)t != owner)
@@ -210,6 +224,12 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
 			       task->comm, task->pid, rwsem_blocked_as, t->comm,
 			       t->pid, rwsem_blocked_by);
 			break;
+		default:
+			if (is_rtmutex) {
+				pr_err("INFO: task %s:%d is blocked on a rtmutex likely owned by task %s:%d.\n",
+						task->comm, task->pid, t->comm, t->pid);
+			}
+			break;
 		}
 		/* Avoid duplicated task dump, skip if the task is also hung. */
 		if (!task_is_hung(t, timeout))
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 5d48d64725b125..d0826b31a148c0 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -530,6 +530,35 @@ void __sched rt_mutex_postunlock(struct rt_wake_q_head *wqh)
 	rt_mutex_wake_up_q(wqh);
 }
 
+/**
+ * rt_mutex_task_owner - Get the lock owner a task is blocked on
+ * @task: Task to inspect.
+ *
+ * Caller must hold an RCU read lock. The owner value is a snapshot read
+ * without exclusion, so it may become stale immediately. Use only for
+ * best-effort diagnostics (e.g., hung task detection).
+ *
+ * Return: The task_struct owning the lock, or NULL if not blocked.
+ */
+struct task_struct *rt_mutex_task_owner(struct task_struct *task)
+{
+        struct task_struct *owner = NULL;
+        struct rt_mutex_base *lock;
+        unsigned long flags;
+
+	lockdep_assert(rcu_read_lock_held());
+
+        raw_spin_lock_irqsave(&task->pi_lock, flags);
+        lock = task_blocked_on_lock(task);
+
+        if (lock)
+                owner = rt_mutex_owner(lock);
+        raw_spin_unlock_irqrestore(&task->pi_lock, flags);
+
+        return owner;
+}
+EXPORT_SYMBOL(rt_mutex_task_owner);
+
 #ifdef CONFIG_DEBUG_RT_MUTEXES
 void rt_mutex_debug_task_free(struct task_struct *task)
 {
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1244dcac2294ad..92dff380027e78 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1317,7 +1317,6 @@ config BOOTPARAM_HUNG_TASK_PANIC
 config DETECT_HUNG_TASK_BLOCKER
 	bool "Dump Hung Tasks Blocker"
 	depends on DETECT_HUNG_TASK
-	depends on !PREEMPT_RT
 	default y
 	help
 	  Say Y here to show the blocker task's stacktrace who acquires
-- 
2.25.1

