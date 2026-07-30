Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237FB372EF7
	for <linux-rt-devel@lists.linux.dev>; Thu, 30 Jul 2026 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785378613; cv=none; b=EaX1b8f1tZIjFvafcWCJVENkmvEpcce9ArakQS2Ts3Z45H+B9Ebvk3xUYmd2cnshSJMg0OJefzgHJxut43+QS65aB5zbNLqt6H7bDnSeJTjilZo/KcJkC/0nrugfapL+O8UAVfQ6Dxh2Bl89ykgazOeukuaAAc1IkFbpedXEfzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785378613; c=relaxed/simple;
	bh=2WrHf54ZsmZ3jm8cH4LjyroI+yVbiU4b/7HzeVa2MPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UltrooHnKO3KSqqDnjIof3FbKfrEHLFHaWka7V7lznQ7Gx2/TnMqvDeCjvR/BQAqqXtP/MLvQJsStnA+Hmi2TtloYgzf620p932p6tXWHDAG9e3z90apm4l97mvQyhdmRcuWIVOWGTJHfKp7njHWg/dKz6ZHdsSKioF8K59m2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eYGCNEFp; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eYGCNEFp"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84874b52eabso2235169b3a.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jul 2026 19:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785378610; x=1785983410; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mLfUQdSDT+5Tj20niAkxfP89mXl5TKRW66T8U3XThNI=;
        b=eYGCNEFpgGwIbyq6zvDPp9DoMZlSgwTulBScfuuVwCbR+biUG3UmRvaIvZsUYickhI
         Jydgoi5V8fpWFuSZ33LDM1DaFeqe8ycnCCxNf27A9BHkLwDUBoiiiQ9ye6RiRuEvzpZZ
         vVY0noje8LjQAIq177v3Hdxw6Q0WI/RYLfuzMdJtdW2gcYfzGRrW59JWCGYZUnRuXy2h
         eX6KI1g2+gpgvxqJf+LXqSmsTzdcK1Gi6IP8SSu3xIfyHAh1bchiO6jTgaDp3DB+0dQm
         rfXb8zOXqnT8uUuxhIGzexb2DyXqndjDv5TzW7hTjBXav7m6D8x//kD78QLOPv9eFu+T
         ZO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785378610; x=1785983410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mLfUQdSDT+5Tj20niAkxfP89mXl5TKRW66T8U3XThNI=;
        b=hoy7Q1W8wHVERgo9Qf235rL8zUFy1UMOAQbLuIHcbEo612V6Xq5Gor7QjlYuN9J2tR
         wHM0pNPZ6GBZ9iTAEEgN1XuRiAi4KRI5Qp6MZz/DNrnVemhXbt5lW5/gM5aF4Er9f3Hg
         LbP3TXMVDo2suPyUKuQl2Ln1PokhgHwImVfmTpwaD4WvchPr1TTCoXRkELjNE5pK6Kno
         fygNPh57FSIS96RTJquzdGRjE5zy1blveE1NlWwlLgMF37uvJXJOhMH6q7IfMWU7UzbV
         OsYJdMDRLvG8QJUYdD66VnZLICjLVDxN7WllwsdpYqLSPpv8ORUtyz3d/dfX+xAfNzvC
         sifQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr484NQ3eXXmt07UbTY+EVXCa4mPPgI4DrmG+Iga/iefUQPa21hqO2mj2Tx+9Q3BUpKMZW40xyt1GSuD8Fhxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzVZYmUB/wC7CK5hpsIp05rBlGYkBiue9lldnyDmVsslx9LwQq
	PHPDfDDinX/k7t2WRFuiNaOyz88SrBDTRuyD9fABr+BxJt0lQaZj2AF1ruLPEg==
X-Gm-Gg: AR+sD10vjRAhF7gpu5j+D97VILVaLvsmhHipTM7AF0OyuXjLJPBuD6ox8MVfaqdHJBH
	VaNeh6wziZ6+mG2YIj1zVW7OxaJLSpTJrFJ+3RT0SS9FHox87rOdXXaDx6/bQEqTkFsjvmCUW+N
	r86edfo4PgjXwN2qjmY+a8TKY6YNBdSzybelYNEbv3QzKgcmFZ50MdGvRjxR9jOInQMbSrk39nD
	ylFg9VoVwA9A73NtRFLv25vwE3B2IxttrOmV88omIvChzCj6gYPBjVGo3gCM4JY4+j54TG7+J3W
	0UO7alb3GR08YoIv52bzDnEwqxwzQHgooo5+81zrC9sRpmekcPU/P4ToTzkMHnuaX9rhNkBE0ya
	tUxvpt43vgmV0c1eaEAF4+z9HY1PFTjhiPmdYncM+0ew0tYBJyXJ5DEsAVmt9uTFMSfKYwe74Qb
	CN0THJRSu3w8BSM/ZkbIVlICU73HuhPiM6Cgb1vJXCztX8W2F2+olxDonsw594pT9uaSSgMmxDY
	M2PkHzBAP50cCRMNQ7O3XYeJSisqfPV
X-Received: by 2002:a05:6a00:3cd1:b0:845:d284:9e10 with SMTP id d2e1a72fcca58-84ebc4655f7mr814851b3a.55.1785378610079;
        Wed, 29 Jul 2026 19:30:10 -0700 (PDT)
Received: from lixiang-ThinkCentre-M755e-N000.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb7b8df4fsm1496917a12.2.2026.07.29.19.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 19:30:09 -0700 (PDT)
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
	zhouyuhang@kylinos.cn,
	arnd@arndb.de,
	colin.i.king@gmail.com,
	ebiggers@kernel.org,
	inux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	ruipengqi3@gmail.com
Subject: [PATCH 1/2] hung_task: show the blocker task if the task is hung on rtmutex
Date: Thu, 30 Jul 2026 10:29:08 +0800
Message-Id: <4dd13bdf76de6ce1e4d825af9f393a5dd59f25e8.1785376929.git.ruipengqi3@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1785376929.git.ruipengqi3@gmail.com>
References: <cover.1785376929.git.ruipengqi3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ruipeng Qi <ruipengqi3@gmail.com>

Currently, debug_show_blocker() only tracks mutex, semaphore and rwsem
lock types. Extend it to also cover rtmutex or rt_mutex-based
implementations locks on PREEMPT_RT, so that when a task is hung
on an rtmutex, the hung task detector can identify and report which
task holds the lock.

On 64-bit systems, lock pointers are 8-byte aligned, so their three
least significant bits are always zero. Use these bits to encode the
blocker type.

Unlike semaphores, rtmutex has built-in owner tracking via lock->owner,
so no additional bookkeeping is needed. The owner can be read with
rt_mutex_owner().

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

Signed-off-by: Ruipeng Qi <ruipengqi3@gmail.com>
---
 include/linux/hung_task.h  | 31 +++++++++++++++++++++++--------
 kernel/hung_task.c         | 22 ++++++++++++++++++++++
 kernel/locking/mutex.c     |  4 ++--
 kernel/locking/rtmutex.c   | 13 +++++++++++++
 kernel/locking/rwsem.c     |  8 ++++----
 kernel/locking/semaphore.c |  4 ++--
 lib/Kconfig.debug          |  1 -
 7 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/include/linux/hung_task.h b/include/linux/hung_task.h
index c4403eeb714424..1bec5fae6dbddb 100644
--- a/include/linux/hung_task.h
+++ b/include/linux/hung_task.h
@@ -16,7 +16,7 @@
  * @blocker: Combines lock address and blocking type.
  *
  * Since lock pointers are at least 4-byte aligned(32-bit) or 8-byte
- * aligned(64-bit). This leaves the 2 least bits (LSBs) of the pointer
+ * aligned(64-bit). This leaves the 2/3 least bits (LSBs) of the pointer
  * always zero. So we can use these bits to encode the specific blocking
  * type.
  *
@@ -29,21 +29,28 @@
  * 01 - Blocked on semaphore			(BLOCKER_TYPE_SEM)
  * 10 - Blocked on rw-semaphore as READER	(BLOCKER_TYPE_RWSEM_READER)
  * 11 - Blocked on rw-semaphore as WRITER	(BLOCKER_TYPE_RWSEM_WRITER)
+ * 100 - Blocked on rtmutex			(BLOCKER_TYPE_RTMUTEX if pointer is 8-byte aligned)
  */
 #define BLOCKER_TYPE_MUTEX		0x00UL
 #define BLOCKER_TYPE_SEM		0x01UL
 #define BLOCKER_TYPE_RWSEM_READER	0x02UL
 #define BLOCKER_TYPE_RWSEM_WRITER	0x03UL
 
+#ifdef CONFIG_64BIT
+#define BLOCKER_TYPE_RTMUTEX		0x04UL
+#define BLOCKER_TYPE_MASK		0x07UL
+#else
 #define BLOCKER_TYPE_MASK		0x03UL
+#endif
 
 #ifdef CONFIG_DETECT_HUNG_TASK_BLOCKER
-static inline void hung_task_set_blocker(void *lock, unsigned long type)
+static inline void hung_task_set_blocker(struct task_struct *task, void *lock,
+					 unsigned long type)
 {
 	unsigned long lock_ptr = (unsigned long)lock;
 
 	WARN_ON_ONCE(!lock_ptr);
-	WARN_ON_ONCE(READ_ONCE(current->blocker));
+	WARN_ON_ONCE(READ_ONCE(task->blocker));
 
 	/*
 	 * If the lock pointer matches the BLOCKER_TYPE_MASK, return
@@ -52,12 +59,12 @@ static inline void hung_task_set_blocker(void *lock, unsigned long type)
 	if (lock_ptr & BLOCKER_TYPE_MASK)
 		return;
 
-	WRITE_ONCE(current->blocker, lock_ptr | type);
+	WRITE_ONCE(task->blocker, lock_ptr | type);
 }
 
-static inline void hung_task_clear_blocker(void)
+static inline void hung_task_clear_blocker(struct task_struct *task)
 {
-	WRITE_ONCE(current->blocker, 0UL);
+	WRITE_ONCE(task->blocker, 0UL);
 }
 
 /*
@@ -81,11 +88,15 @@ static inline void *hung_task_blocker_to_lock(unsigned long blocker)
 
 	return (void *)(blocker & ~BLOCKER_TYPE_MASK);
 }
+extern void debug_trace_blocker(struct task_struct *task,
+				unsigned long timeout, bool iter);
 #else
-static inline void hung_task_set_blocker(void *lock, unsigned long type)
+static inline void hung_task_set_blocker(struct task_struct *task, void *lock,
+					 unsigned long type)
 {
 }
-static inline void hung_task_clear_blocker(void)
+
+static inline void hung_task_clear_blocker(struct task_struct *task)
 {
 }
 static inline unsigned long hung_task_get_blocker_type(unsigned long blocker)
@@ -96,6 +107,10 @@ static inline void *hung_task_blocker_to_lock(unsigned long blocker)
 {
 	return NULL;
 }
+static inline void debug_trace_blocker(struct task_struct *task,
+				       unsigned long timeout, bool iter)
+{
+}
 #endif
 
 #endif /* __LINUX_HUNG_TASK_H */
diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 6fcc94ce4ca9d2..0ccaac6041d925 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -27,6 +27,7 @@
 #include <linux/sys_info.h>
 
 #include <trace/events/sched.h>
+#include <linux/rtmutex.h>
 
 /*
  * The number of tasks checked:
@@ -149,12 +150,15 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
 	blocker_type = hung_task_get_blocker_type(blocker);
 
 	switch (blocker_type) {
+#ifndef CONFIG_PREEMPT_RT
 	case BLOCKER_TYPE_MUTEX:
 		owner = mutex_get_owner(hung_task_blocker_to_lock(blocker));
 		break;
+#endif
 	case BLOCKER_TYPE_SEM:
 		owner = sem_last_holder(hung_task_blocker_to_lock(blocker));
 		break;
+#ifndef CONFIG_PREEMPT_RT
 	case BLOCKER_TYPE_RWSEM_READER:
 	case BLOCKER_TYPE_RWSEM_WRITER:
 		owner = (unsigned long)rwsem_owner(
@@ -165,6 +169,12 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
 					hung_task_blocker_to_lock(blocker)) ?
 					"reader" : "writer";
 		break;
+#endif
+#if defined(CONFIG_64BIT) && defined(CONFIG_RT_MUTEXES)
+	case BLOCKER_TYPE_RTMUTEX:
+		owner = (unsigned long)rt_mutex_owner(hung_task_blocker_to_lock(blocker));
+		break;
+#endif
 	default:
 		WARN_ON_ONCE(1);
 		return;
@@ -186,6 +196,12 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
 			pr_err("INFO: task %s:%d is blocked on an rw-semaphore, but the owner is not found.\n",
 			       task->comm, task->pid);
 			break;
+#if defined(CONFIG_64BIT) && defined(CONFIG_RT_MUTEXES)
+		case BLOCKER_TYPE_RTMUTEX:
+			pr_err("INFO: task %s:%d is blocked on a rtmutex, but the owner is not found.\n",
+			       task->comm, task->pid);
+			break;
+#endif
 		}
 		return;
 	}
@@ -210,6 +226,12 @@ static void debug_show_blocker(struct task_struct *task, unsigned long timeout)
 			       task->comm, task->pid, rwsem_blocked_as, t->comm,
 			       t->pid, rwsem_blocked_by);
 			break;
+#if defined(CONFIG_64BIT) && defined(CONFIG_RT_MUTEXES)
+		case BLOCKER_TYPE_RTMUTEX:
+			pr_err("INFO: task %s:%d is blocked on a rtmutex likely owned by task %s:%d.\n",
+			       task->comm, task->pid, t->comm, t->pid);
+			break;
+#endif
 		}
 		/* Avoid duplicated task dump, skip if the task is also hung. */
 		if (!task_is_hung(t, timeout))
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 8a85912d7ee6ce..90b364b2ad5d73 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -211,7 +211,7 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 {
 	struct mutex_waiter *first = lock->first_waiter;
 
-	hung_task_set_blocker(lock, BLOCKER_TYPE_MUTEX);
+	hung_task_set_blocker(current, lock, BLOCKER_TYPE_MUTEX);
 	debug_mutex_add_waiter(lock, waiter, current);
 
 	if (pos) {
@@ -251,7 +251,7 @@ __mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
 	}
 
 	debug_mutex_remove_waiter(lock, waiter, current);
-	hung_task_clear_blocker();
+	hung_task_clear_blocker(current);
 }
 
 /*
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4728631ae71940..74aec0773846bf 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -23,6 +23,7 @@
 #include <linux/sched/rt.h>
 #include <linux/sched/wake_q.h>
 #include <linux/ww_mutex.h>
+#include <linux/hung_task.h>
 
 #include <trace/events/lock.h>
 
@@ -1183,6 +1184,9 @@ try_to_take_rt_mutex(struct rt_mutex_base *lock, struct task_struct *task,
 	 */
 	raw_spin_lock(&task->pi_lock);
 	task->pi_blocked_on = NULL;
+#if defined(CONFIG_64BIT)
+	hung_task_clear_blocker(task);
+#endif
 	/*
 	 * Finish the lock acquisition. @task is the new owner. If
 	 * other waiters exist we have to insert the highest priority
@@ -1251,6 +1255,9 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	rt_mutex_enqueue(lock, waiter);
 
 	task->pi_blocked_on = waiter;
+#if defined(CONFIG_64BIT)
+	hung_task_set_blocker(task, lock, BLOCKER_TYPE_RTMUTEX);
+#endif
 
 	raw_spin_unlock(&task->pi_lock);
 
@@ -1265,6 +1272,9 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 			raw_spin_lock(&task->pi_lock);
 			rt_mutex_dequeue(lock, waiter);
 			task->pi_blocked_on = NULL;
+#if defined(CONFIG_64BIT)
+			hung_task_clear_blocker(task);
+#endif
 			raw_spin_unlock(&task->pi_lock);
 			return res;
 		}
@@ -1569,6 +1579,9 @@ static void __sched remove_waiter(struct rt_mutex_base *lock,
 	scoped_guard(raw_spinlock, &waiter_task->pi_lock) {
 		rt_mutex_dequeue(lock, waiter);
 		waiter_task->pi_blocked_on = NULL;
+#if defined(CONFIG_64BIT)
+		hung_task_clear_blocker(waiter_task);
+#endif
 	}
 
 	/*
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index b9c180ac1eee7a..9674e46f6dadd1 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1095,7 +1095,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	set_current_state(state);
 
 	if (state == TASK_UNINTERRUPTIBLE)
-		hung_task_set_blocker(sem, BLOCKER_TYPE_RWSEM_READER);
+		hung_task_set_blocker(current, sem, BLOCKER_TYPE_RWSEM_READER);
 
 	/* wait to be given the lock */
 	for (;;) {
@@ -1117,7 +1117,7 @@ rwsem_down_read_slowpath(struct rw_semaphore *sem, long count, unsigned int stat
 	}
 
 	if (state == TASK_UNINTERRUPTIBLE)
-		hung_task_clear_blocker();
+		hung_task_clear_blocker(current);
 
 	__set_current_state(TASK_RUNNING);
 	lockevent_inc(rwsem_rlock);
@@ -1183,7 +1183,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	trace_contention_begin(sem, LCB_F_WRITE);
 
 	if (state == TASK_UNINTERRUPTIBLE)
-		hung_task_set_blocker(sem, BLOCKER_TYPE_RWSEM_WRITER);
+		hung_task_set_blocker(current, sem, BLOCKER_TYPE_RWSEM_WRITER);
 
 	for (;;) {
 		if (rwsem_try_write_lock(sem, &waiter)) {
@@ -1220,7 +1220,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
 	}
 
 	if (state == TASK_UNINTERRUPTIBLE)
-		hung_task_clear_blocker();
+		hung_task_clear_blocker(current);
 
 	__set_current_state(TASK_RUNNING);
 	raw_spin_unlock_irq(&sem->wait_lock);
diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 233730c2593308..c53e0753f933c1 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -312,13 +312,13 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
 {
 	int ret;
 
-	hung_task_set_blocker(sem, BLOCKER_TYPE_SEM);
+	hung_task_set_blocker(current, sem, BLOCKER_TYPE_SEM);
 
 	trace_contention_begin(sem, 0);
 	ret = ___down_common(sem, state, timeout);
 	trace_contention_end(sem, ret);
 
-	hung_task_clear_blocker();
+	hung_task_clear_blocker(current);
 
 	return ret;
 }
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

