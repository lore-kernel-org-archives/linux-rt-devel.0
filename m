Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793944;
	b=04DfoUl15sGxltUe8Ogat2g9tdWc3S51jwxgL5JbGwkJjSJyyFW+3VQRQ8StnLAVDRaU
	 hJ0WeRSbETCdAN4UDu7it7cHHhh1UzLnGTQI8WF7Y3Byod3Yg17ltjaAlMrY8tnhBAck/
	 aRNunXlKyg3WQzc9Or5+l4rJkG/9hc5Q1tmXNtTc0w0rkngI4l/EZzQElJrSgwTeCBra9
	 EhASkveATpisYcEMpssXemqM+mrf1b3IhCFmA9+HqMjta54kCzupyXJojm66ook7NY49w
	 xITdn8oIMay9jGr7y6Pb0g0g7mFTerqsqXiaYiCK08lPv6AisYKSeoGJFrHRJJxp5eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793944;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=q3p5Ny9n1tlQYJdeoUKM5vEG7oFiEldi5brekpSeVZA=;
	b=bQLmgEJ6z3unfQ77EUZQ2TSMz+7oHIoubE2hgi75iUYkQco113v6f1Fi8s1rSImcLyL2
	 59qn9neaNKOkfMl9JfAEr/gLs9JB3camGtNFny4lP27lGLbhCizER5qOwMrXDTB734gYs
	 VWjqnqi5UfxFj4sLQJDVO9htaxUtatHHSwgh2xMe8U2hpmaz1t7tkMrk7YNXvOPABLo7a
	 TH+0B25iEN/wzQ34PEiIkbC30bSIxMxcRiPk1wWP2uCTsQ+FlMZ7UTh7GR5Yd2Pwm4mM+
	 pIN6wSCVFd8CIdGllIXXbHEPf7L4HCArfiKis6LJJ41/6tw4nZdMT+NydIBvgNhbu+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="LK4Ndi/d";
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7EE606A31F
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Nov 2026 01:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE7EE606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LK4Ndi/d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794793943; x=1826329943;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3evvT5Cp+KVAXQKYLiXSnN/s+2IfMMah8AYUtGTRNDg=;
  b=LK4Ndi/dm460AY50CicHOs5PTjhGRMh/4wke/EVAVnZVqLNYBHOmtxqj
   JiEns+tyU4QV0NqpOAtqDW6bmRewYp/0pu5ODQMC4zQsocHZqq27f01Qr
   fGdIY5NZnkdavNhkXEOWjwuU1t63G5RTGtt8JjpmaE6ka4DSeaJylr9SD
   GevIjeTZjOt+P7hytp4W/koErb0snsd9tvMsKjXbNchVY5DU24wOe2K7+
   iEuYcrZHBnOM6ZN4GDVvIX1c/kkqJluFw7y95F2vryrVYh60an4TQksb7
   YmsMEMGufNmNnZNhU6svQClozaYnYssq9M2uLwj2OGztwoBNlWDo4LqLS
   Q==;
X-CSE-ConnectionGUID: RcCWWnKzSxiwnmKR4px2lQ==
X-CSE-MsgGUID: zXFayl4eTCKVJtLhT1aOxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3561530"
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="3561530"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2026 17:52:23 -0800
X-CSE-ConnectionGUID: AiGtzromTC+xA+xdgiHFKw==
X-CSE-MsgGUID: r0t8OA5lRAaJVSRRofaizA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,215,1787036400"; 
   d="scan'208";a="9497022"
Received: from linux-pnp-gnr-1.sh.intel.com ([10.239.83.186])
  by fmviesa005.fm.intel.com with ESMTP; 15 Nov 2026 17:52:19 -0800
From: Jiebin Sun <jiebin.sun@intel.com>
To: akpm@linux-foundation.org
Cc: dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	linux-rt-devel@lists.linux.dev,
	tim.c.chen@linux.intel.com,
	tianyou.li@intel.com,
	wangyang.guo@intel.com,
	jiebin.sun@intel.com
Subject: [PATCH] lib/percpu_counter: allow concurrent sums with an rwlock
Date: Mon, 16 Nov 2026 09:56:55 +0800
Message-ID: <20261116015655.2744577-1-jiebin.sun@intel.com>
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

Suggested-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Tianyou Li <tianyou.li@intel.com>
Reviewed-by: Wangyang Guo <wangyang.guo@intel.com>
Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
---
 include/linux/percpu_counter.h |  4 ++
 lib/percpu_counter.c           | 71 ++++++++++++++++++++++++++--------
 2 files changed, 59 insertions(+), 16 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 3a44dd1e33d2..7b28b0e22207 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -20,7 +20,11 @@
 #ifdef CONFIG_SMP
 
 struct percpu_counter {
+#ifdef CONFIG_PREEMPT_RT
 	raw_spinlock_t lock;
+#else
+	rwlock_t lock;		/* shared for sums, exclusive for updates */
+#endif
 	s64 count;
 #ifdef CONFIG_HOTPLUG_CPU
 	struct list_head list;	/* All percpu_counters are on a list */
diff --git a/lib/percpu_counter.c b/lib/percpu_counter.c
index 87b261b87b0b..ce0284bacf07 100644
--- a/lib/percpu_counter.c
+++ b/lib/percpu_counter.c
@@ -15,6 +15,46 @@ static LIST_HEAD(percpu_counters);
 static DEFINE_SPINLOCK(percpu_counters_lock);
 #endif
 
+/*
+ * Non-RT sums share the lock; global updates take it exclusively.
+ * Keep raw spinlocks on RT: rwlocks may sleep and their irqsave variants
+ * do not disable interrupts. Updates run in atomic contexts and need
+ * IRQ exclusion for CPU-local read-modify-write sequences.
+ */
+#ifdef CONFIG_PREEMPT_RT
+#define fbc_lock(fbc)			raw_spin_lock(&(fbc)->lock)
+#define fbc_unlock(fbc)			raw_spin_unlock(&(fbc)->lock)
+#define fbc_lock_irqsave(fbc, f)		raw_spin_lock_irqsave(&(fbc)->lock, f)
+#define fbc_unlock_irqrestore(fbc, f)	raw_spin_unlock_irqrestore(&(fbc)->lock, f)
+#define fbc_read_lock_irqsave		fbc_lock_irqsave
+#define fbc_read_unlock_irqrestore	fbc_unlock_irqrestore
+#else
+#define fbc_lock(fbc)			write_lock(&(fbc)->lock)
+#define fbc_unlock(fbc)			write_unlock(&(fbc)->lock)
+#define fbc_lock_irqsave(fbc, f)		write_lock_irqsave(&(fbc)->lock, f)
+#define fbc_unlock_irqrestore(fbc, f)	write_unlock_irqrestore(&(fbc)->lock, f)
+#define fbc_read_lock_irqsave(fbc, f)	read_lock_irqsave(&(fbc)->lock, f)
+#define fbc_read_unlock_irqrestore(fbc, f) read_unlock_irqrestore(&(fbc)->lock, f)
+#endif
+
+static void fbc_lock_init(struct percpu_counter *fbc,
+			  struct lock_class_key *key)
+{
+#ifdef CONFIG_PREEMPT_RT
+	raw_spin_lock_init(&fbc->lock);
+	lockdep_set_class(&fbc->lock, key);
+#else
+	rwlock_init(&fbc->lock);
+	/*
+	 * rwlock_t normally uses LD_WAIT_CONFIG because it sleeps on RT.
+	 * This counter uses a raw spinlock on RT, so it can be taken under
+	 * raw spinlocks or with IRQs off on every configuration.
+	 */
+	lockdep_init_map_wait(&fbc->lock.dep_map, "&fbc->lock", key, 0,
+			      LD_WAIT_SPIN);
+#endif
+}
+
 #ifdef CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER
 
 static const struct debug_obj_descr percpu_counter_debug_descr;
@@ -62,13 +102,13 @@ void percpu_counter_set(struct percpu_counter *fbc, s64 amount)
 	int cpu;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&fbc->lock, flags);
+	fbc_lock_irqsave(fbc, flags);
 	for_each_possible_cpu(cpu) {
 		s32 *pcount = per_cpu_ptr(fbc->counters, cpu);
 		*pcount = 0;
 	}
 	fbc->count = amount;
-	raw_spin_unlock_irqrestore(&fbc->lock, flags);
+	fbc_unlock_irqrestore(fbc, flags);
 }
 EXPORT_SYMBOL(percpu_counter_set);
 
@@ -98,7 +138,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 	count = this_cpu_read(*fbc->counters);
 	do {
 		if (unlikely(abs(count + amount) >= batch)) {
-			raw_spin_lock_irqsave(&fbc->lock, flags);
+			fbc_lock_irqsave(fbc, flags);
 			/*
 			 * Note: by now we might have migrated to another CPU
 			 * or the value might have changed.
@@ -106,7 +146,7 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
 			count = __this_cpu_read(*fbc->counters);
 			fbc->count += count + amount;
 			__this_cpu_sub(*fbc->counters, count);
-			raw_spin_unlock_irqrestore(&fbc->lock, flags);
+			fbc_unlock_irqrestore(fbc, flags);
 			return;
 		}
 	} while (!this_cpu_try_cmpxchg(*fbc->counters, &count, count + amount));
@@ -125,10 +165,10 @@ void percpu_counter_add_batch(struct percpu_counter *fbc, s64 amount, s32 batch)
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
@@ -148,11 +188,11 @@ void percpu_counter_sync(struct percpu_counter *fbc)
 	unsigned long flags;
 	s64 count;
 
-	raw_spin_lock_irqsave(&fbc->lock, flags);
+	fbc_lock_irqsave(fbc, flags);
 	count = __this_cpu_read(*fbc->counters);
 	fbc->count += count;
 	__this_cpu_sub(*fbc->counters, count);
-	raw_spin_unlock_irqrestore(&fbc->lock, flags);
+	fbc_unlock_irqrestore(fbc, flags);
 }
 EXPORT_SYMBOL(percpu_counter_sync);
 
@@ -174,13 +214,13 @@ s64 __percpu_counter_sum(struct percpu_counter *fbc)
 	int cpu;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&fbc->lock, flags);
+	fbc_read_lock_irqsave(fbc, flags);
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
@@ -203,8 +243,7 @@ int __percpu_counter_init_many(struct percpu_counter *fbc, s64 amount,
 	}
 
 	for (i = 0; i < nr_counters; i++) {
-		raw_spin_lock_init(&fbc[i].lock);
-		lockdep_set_class(&fbc[i].lock, key);
+		fbc_lock_init(&fbc[i], key);
 #ifdef CONFIG_HOTPLUG_CPU
 		INIT_LIST_HEAD(&fbc[i].list);
 #endif
@@ -274,11 +313,11 @@ static int percpu_counter_cpu_dead(unsigned int cpu)
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
@@ -354,7 +393,7 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 		return true;
 	}
 
-	raw_spin_lock(&fbc->lock);
+	fbc_lock(fbc);
 	count = fbc->count + amount;
 
 	/* Skip percpu_counter_sum() when safe */
@@ -392,7 +431,7 @@ bool __percpu_counter_limited_add(struct percpu_counter *fbc,
 	fbc->count += count + amount;
 	__this_cpu_sub(*fbc->counters, count);
 out:
-	raw_spin_unlock(&fbc->lock);
+	fbc_unlock(fbc);
 	local_irq_restore(flags);
 	return good;
 }
-- 
2.52.0

