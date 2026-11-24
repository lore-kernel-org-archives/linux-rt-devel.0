Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795497337;
	b=nMfCO8qNcCXkHEi8CpjMJYnAyeyG+i8lzKrnhBGehU1vSITZgkXr7ISOzH8wGBP0w8c8
	 +CFufduO4lCdRfkGDLIdSxNDHWYLcUp09CTpJ6g9IJrnYchile/cx0smludK48lHKgBTG
	 ixMefChFl+/GRzwWrGl4gXH9JHITcRzxPpn+IdqPETQm5LbNCpvWRVeNeXqSC/O6v809K
	 CfluQV3+nW1dXyhEfioywFEK/8NkxSu6w80+gGOLJk15gdXwfMmE+CamsjpHrbt5yOVXM
	 hVLZ7E8HtgR8dcmyeZ8ykfZRqJlAAUF6GSKISkxraAKO02xrLt0/LTdvFQ8yFiaEQ7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497337;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=7vHjvmD/PBQZO1TvMxOYcbhdY53Pzfcnl62FBgloeOM=;
	b=H4WGAAoIk8KxYVNtpXtGFoMRAq+VoBnP8q4ltBH59sfk0ahNTe9dPI4W8U6hPyIvyF8t
	 E3z6M2B0ioiXhiMpAEkGH2fFsJJvIc7Qgncr5QOg1Qg/IcbvY6S6F0jR9gr0nrAIJwaUo
	 BlseukvH+z3S3LC/nk3ROHaN5zAU3N4WgbS8b7lGgXmKWgOOBsJQGTzgk59evq95ipe4A
	 SbANqJ47zN+6hXbuI/Y4SlbJQ8zEioFvb3PhucziCmbrplqMOOcj8DYVPejUQ6fUNBzhK
	 80pqKTkF8wIPMYXg/XmSbtuMVqdESzH81XbWhW4jaE6Y6nsgSEGxGFxk2xgAU6151Sw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T7GGqNaf;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2535606A321
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Nov 2026 05:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2535606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T7GGqNaf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795497337; x=1827033337;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YqOdD8uGwOjh3QOL1+7zMtLz55iOD5EU0eL7Q3rsA9U=;
  b=T7GGqNafnHMeNsu0kTzS94DxTQskSSWgj9ktZ+ct41ntcX6PoCV3wiDi
   a6xjVs7HCjpIA2Flb3yPsgw2ufCFkZPeh62qmqoBiZTLXRWwGrIbClZkv
   8/6U59a+W0lBB8THJ0g8x91N96AVTzjlp78dSWZ0zBkq0xi3ELRb5Vfzh
   XY/3RSB9pOb1cO/QEan4q9+51bkIYAMeUC4pAH20heLqTrvsI+X6dWkGN
   QJXjluzIxoP/0DC7XyfhxsTudL892nv2GAEJNyHu5fe2lWHiJ39pBM0OF
   qobYoOlrJpURH0FMCocjzfAuXlj+GLMySjWsWXNAxu2oXh9gZfCPN5WFY
   w==;
X-CSE-ConnectionGUID: cM6lVNbwQ2+pcchmPWTL9w==
X-CSE-MsgGUID: PZHnWoelSU6J7SeccbGTsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4209944"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4209944"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 21:15:36 -0800
X-CSE-ConnectionGUID: csY2rVqoSoiH5F/p0ILSUg==
X-CSE-MsgGUID: jOkqv0guQdKI43BJpjnUBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11809953"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa007.fm.intel.com with ESMTP; 23 Nov 2026 21:15:33 -0800
From: Jiebin Sun <jiebin.sun@intel.com>
To: akpm@linux-foundation.org,
	bigeasy@linutronix.de
Cc: dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	tim.c.chen@linux.intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com
Subject: [PATCH v2] lib/percpu_counter: allow concurrent sums with an rwlock
Date: Tue, 24 Nov 2026 13:19:52 +0800
Message-ID: <20261124051952.1059282-1-jiebin.sun@intel.com>
X-Mailer: git-send-email 2.52.0
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

__percpu_counter_sum() holds a raw spinlock while reading the global
count and per-CPU deltas, serializing concurrent sums of the same
counter. Since a sum changes neither the global count nor the per-CPU
deltas, use rwlock_t on !PREEMPT_RT to allow concurrent sums with a
read lock. Global updates take the write lock. The per-CPU fast path
remains lockless, so sums keep their existing snapshot semantics.

stress-ng dentry reaches this path through ext4_statfs():

  statfs -> ext4_statfs -> __percpu_counter_sum
         -> native_queued_spin_lock_slowpath

ext4_statfs() uses percpu_counter_sum_positive(), which calls
__percpu_counter_sum(). At low writeback thresholds, dirty throttling
also reaches percpu_counter_sum_positive() through wb_stat_sum().
Buffered writers sharing a writeback instance can sum the same page
counters concurrently.

Keep the raw spinlock on PREEMPT_RT, where rwlock_t can sleep.
Global counter updates can run in atomic context and must not sleep.

stress-ng dentry test average throughput change:

  +------------------------+------------+--------------------+
  | Case                   | Unit       | Average change (%) |
  +------------------------+------------+--------------------+
  | Dentry, 64 workers     | bogo ops/s |             +47.34 |
  +------------------------+------------+--------------------+

Dentry ran on ext4 with 64 workers pinned to physical CPUs:

  stress-ng --dentry 64 --dentries 4096 --timeout 20s

fio results from the review thread (3 x 60 s per batch, vs. mean baseline):

  +------+------------+-----------------+---------+
  | Test | Throughput | CPU utilization | Cycles  |
  +------+------------+-----------------+---------+
  | fio  |     +6.91% |         -40.41% | -40.80% |
  +------+------------+-----------------+---------+

fio ran on ext4 with 64 buffered jobs, 64 KiB sequential writes,
a 32 GiB memory limit, and 64/32 MiB dirty/background limits.

Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
---
Changes in v2:
- Replace the locking macros with static inline functions.
- Explain the RT lock choice in struct percpu_counter.
- Describe the percpu_counter_sum_positive() and dirty-throttling callers.

v1: https://lore.kernel.org/linux-mm/20261116015655.2744577-1-jiebin.sun@intel.com/

 include/linux/percpu_counter.h |   5 ++
 lib/percpu_counter.c           | 126 ++++++++++++++++++++++++++++-----
 2 files changed, 115 insertions(+), 16 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 3a44dd1e33d2..b3bdae27ece9 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -20,7 +20,12 @@
 #ifdef CONFIG_SMP
 
 struct percpu_counter {
+#ifdef CONFIG_PREEMPT_RT
+	/* Updates can run in atomic context, where an RT rwlock may sleep. */
 	raw_spinlock_t lock;
+#else
+	rwlock_t lock;		/* shared for sums, exclusive for updates */
+#endif
 	s64 count;
 #ifdef CONFIG_HOTPLUG_CPU
 	struct list_head list;	/* All percpu_counters are on a list */
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 87b261b87b0b..a91d20d73a0b 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -15,6 +15,101 @@ static LIST_HEAD(percpu_counters);
 static DEFINE_SPINLOCK(percpu_counters_lock);
 #endif
 
+#ifdef CONFIG_PREEMPT_RT
+static inline void fbc_lock(struct percpu_counter *fbc)
+{
+	raw_spin_lock(&fbc->lock);
+}
+
+static inline void fbc_unlock(struct percpu_counter *fbc)
+{
+	raw_spin_unlock(&fbc->lock);
+}
+
+static inline unsigned long fbc_lock_irqsave(struct percpu_counter *fbc)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&fbc->lock, flags);
+	return flags;
+}
+
+static inline void fbc_unlock_irqrestore(struct percpu_counter *fbc,
+					 unsigned long flags)
+{
+	raw_spin_unlock_irqrestore(&fbc->lock, flags);
+}
+
+static inline unsigned long fbc_read_lock_irqsave(struct percpu_counter *fbc)
+{
+	return fbc_lock_irqsave(fbc);
+}
+
+static inline void fbc_read_unlock_irqrestore(struct percpu_counter *fbc,
+					      unsigned long flags)
+{
+	fbc_unlock_irqrestore(fbc, flags);
+}
+
+static inline void fbc_lock_init(struct percpu_counter *fbc,
+				 struct lock_class_key *key)
+{
+	raw_spin_lock_init(&fbc->lock);
+	lockdep_set_class(&fbc->lock, key);
+}
+#else
+static inline void fbc_lock(struct percpu_counter *fbc)
+{
+	write_lock(&fbc->lock);
+}
+
+static inline void fbc_unlock(struct percpu_counter *fbc)
+{
+	write_unlock(&fbc->lock);
+}
+
+static inline unsigned long fbc_lock_irqsave(struct percpu_counter *fbc)
+{
+	unsigned long flags;
+
+	write_lock_irqsave(&fbc->lock, flags);
+	return flags;
+}
+
+static inline void fbc_unlock_irqrestore(struct percpu_counter *fbc,
+					 unsigned long flags)
+{
+	write_unlock_irqrestore(&fbc->lock, flags);
+}
+
+static inline unsigned long fbc_read_lock_irqsave(struct percpu_counter *fbc)
+{
+	unsigned long flags;
+
+	read_lock_irqsave(&fbc->lock, flags);
+	return flags;
+}
+
+static inline void fbc_read_unlock_irqrestore(struct percpu_counter *fbc,
+					      unsigned long flags)
+{
+	read_unlock_irqrestore(&fbc->lock, flags);
+}
+
+static inline void fbc_lock_init(struct percpu_counter *fbc,
+				 struct lock_class_key *key)
+{
+	rwlock_init(&fbc->lock);
+	/*
+	 * rwlock_t normally uses LD_WAIT_CONFIG because it sleeps on RT.
+	 * This counter uses a raw spinlock on RT, so it can be taken under
+	 * raw spinlocks or with IRQs off on every configuration.
+	 */
+	lockdep_init_map_wait(&fbc->lock.dep_map, "&fbc->lock", key, 0,
+			      LD_WAIT_SPIN);
+}
+#endif
+
 #ifdef CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER
 
 static const struct debug_obj_descr percpu_counter_debug_descr;
@@ -62,13 +157,13 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
 	int cpu;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&fbc->lock, flags);
+	flags = fbc_lock_irqsave(fbc);
 	for_each_possible_cpu(cpu) {
 		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
 		*pcount = 0;
 	}
 	fbc->count = amount;
-	raw_spin_unlock_irqrestore(&fbc->lock, flags);
+	fbc_unlock_irqrestore(fbc, flags);
 }
 EXPORT_SYMBOL(percpu_counter_set);
 
@@ -98,7 +193,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 	count = this_cpu_read(*fbc->counters);
 	do {
 		if (unlikely(abs(count + amount) >= batch)) {
-			raw_spin_lock_irqsave(&fbc->lock, flags);
+			flags = fbc_lock_irqsave(fbc);
 			/*
 			 * Note: by now we might have migrated to another CPU
 			 * or the value might have changed.
@@ -106,7 +201,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 			count = __this_cpu_read(*fbc->counters);
 			fbc->count += count + amount;
 			__this_cpu_sub(*fbc->counters, count);
-			raw_spin_unlock_irqrestore(&fbc->lock, flags);
+			fbc_unlock_irqrestore(fbc, flags);
 			return;
 		}
 	} while (!this_cpu_try_cmpxchg(*fbc->counters, &count, count + amount));
@@ -125,10 +220,10 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 	local_irq_save(flags);
 	count = __this_cpu_read(*fbc->counters) + amount;
 	if (abs(count) >= batch) {
-		raw_spin_lock(&fbc->lock);
+		fbc_lock(fbc);
 		fbc->count += count;
 		__this_cpu_sub(*fbc->counters, count - amount);
-		raw_spin_unlock(&fbc->lock);
+		fbc_unlock(fbc);
 	} else {
 		this_cpu_add(*fbc->counters, amount);
 	}
@@ -148,11 +243,11 @@ void percpu_counter_sync(struct percpu_counter *fbc)
 	unsigned long flags;
 	s64 count;
 
-	raw_spin_lock_irqsave(&fbc->lock, flags);
+	flags = fbc_lock_irqsave(fbc);
 	count = __this_cpu_read(*fbc->counters);
 	fbc->count += count;
 	__this_cpu_sub(*fbc->counters, count);
-	raw_spin_unlock_irqrestore(&fbc->lock, flags);
+	fbc_unlock_irqrestore(fbc, flags);
 }
 EXPORT_SYMBOL(percpu_counter_sync);
 
@@ -174,13 +269,13 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
 	int cpu;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&fbc->lock, flags);
+	flags = fbc_read_lock_irqsave(fbc);
 	ret = fbc->count;
 	for_each_cpu_or(cpu, cpu_online_mask, cpu_dying_mask) {
 		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
 		ret += *pcount;
 	}
-	raw_spin_unlock_irqrestore(&fbc->lock, flags);
+	fbc_read_unlock_irqrestore(fbc, flags);
 	return ret;
 }
 EXPORT_SYMBOL(__percpu_counter_sum);
@@ -203,8 +298,7 @@ int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
 	}
 
 	for (i = 0; i < nr_counters; i++) {
-		raw_spin_lock_init(&fbc[i].lock);
-		lockdep_set_class(&fbc[i].lock, key);
+		fbc_lock_init(&fbc[i], key);
 #ifdef CONFIG_HOTPLUG_CPU
 		INIT_LIST_HEAD(&fbc[i].list);
 #endif
@@ -274,11 +368,11 @@ static int percpu_counter_cpu_dead(unsigned int cpu)
 	list_for_each_entry(fbc, &percpu_counters, list) {
 		s32 *pcount;
 
-		raw_spin_lock(&fbc->lock);
+		fbc_lock(fbc);
 		pcount = per_cpu_ptr(fbc->counters, cpu);
 		fbc->count += *pcount;
 		*pcount = 0;
-		raw_spin_unlock(&fbc->lock);
+		fbc_unlock(fbc);
 	}
 	spin_unlock_irq(&percpu_counters_lock);
 #endif
@@ -354,7 +448,7 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 		return true;
 	}
 
-	raw_spin_lock(&fbc->lock);
+	fbc_lock(fbc);
 	count = fbc->count + amount;
 
 	/* Skip percpu_counter_sum() when safe */
@@ -392,7 +486,7 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 	fbc->count += count + amount;
 	__this_cpu_sub(*fbc->counters, count);
 out:
-	raw_spin_unlock(&fbc->lock);
+	fbc_unlock(fbc);
 	local_irq_restore(flags);
 	return good;
 }

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.52.0

