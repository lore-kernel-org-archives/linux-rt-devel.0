Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFD43E025E
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 23:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873493; cv=none; b=PYoET6cgzTSC/2LSLeOk6SA2dBW7E2rgLMyVMlIUHoiB+aeBDUGJHfCoTYT7oMzwVPJZczaFr2B5MywAH8+8kUO9b5z/V/aaPq0qu98qMorgBw9xyUXaa+FZZjNkxDT7UViINxpEw4V2VTol+s24IY/pu7bse5DfrJifkBjXnSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873493; c=relaxed/simple;
	bh=QzsK4I7O4UNU9KGyJGbH5fbGdEHciGy0e3moiv3yKA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H5ocoEnqysZih0V1CDNaQ7cSI0aqCxIq9Ntqm5N0FNC1GE2vko5a8B2XRcfKyFFulAr5ccedC545SnmTXnBV5VTJAofeBwUwenYGurGekiYSQmdIqZUzXMkMats7oUY+M3+6ro1gzOnM92Ra3tN22cir/+K74GHW8473fiTXAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pDvuvBsC; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDvuvBsC"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-388cfc4848dso506005a91.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 16:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787873491; x=1788478291; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DF4cMpT7HMhXRKSc173deaVgeyoN8RCgYF4bsP8Paw0=;
        b=pDvuvBsCLnnhX+4kdaFdA0slfAQnlaimDZ5p8379PHIYBdfGryuxSucr8DwxUPMJQA
         HbfZ07nMKh8QpXsWnRukL4iqSpdjkFnXpiLnnkhn8QTB3RWgvC19Cy8HeRiC8f7cihI1
         rba7epGeHaq01A5PANvy3rKLvI90/RXGHAWp6vUnwOUqZzjWCbOLz/Ky/TbdYqNmgRJV
         Qs55RCQWDQpuVYllBF+uQ+DgTvoUtSJSe/NCaAbH1aFzrGjPt3pY3jt8HZhaa+ZdrU7O
         yAF9YrrqiPK8vs4i0Nj2IQGod8AzoZ0M2FU8Tnzb3qCrszQjWtYutJsDYOHpGr2QQCvY
         wvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787873491; x=1788478291;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DF4cMpT7HMhXRKSc173deaVgeyoN8RCgYF4bsP8Paw0=;
        b=lwFT4m6gAGnh2FLOjvdEb0ga1xy4R+We+EXw9RYZgIQvXGRkhxcZ0kZqeEBLYXSbO7
         w4g4hTGDlB8aVj8Dciro72Nagcbfn18D9YT1HvBkzdgwxYkq7BfG65vJYYQnaRWzyzdx
         bgJE1fjAPvCW+p7Z15Fv213c5TXf+iT+l7ostqe0tRq558d+CqdVPWQRkHNQN+vo/yXI
         X5gm6DwBi5Zkgv6ntXJlCgmTJAPrNprXDwNNw7l8Iql3AkE5hZQQdNPVST4h3+Q2N42g
         vwJO66UOhmKsAg3ks+7DguZQGG104wy/92MUbm8dPzzbcPc+c2CBij26Msv76ntbMkwu
         oO/A==
X-Forwarded-Encrypted: i=1; AHgh+RpNfuungoezrjEgb1K7jttIpRbA+ckqoa2S66rCNa1PsYdxVquALnqmowl50MvnP+PBIjl4XNNeg/Cf0js6PQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lrJhFT0itcE+ZhwlXqiD5QB416bteVL3YDBFDBF+BgYyVUgtY7
	UEGckE7W3uwjfQ4OdWYk12a0YaaF8BywTG58xj8Fx68J/Mglb0wJuXE8stTHqUdFUrqpvTqJGny
	hPXxGsoXQjLzvYg==
X-Received: from dlbdx3.prod.google.com ([2002:a05:7022:e03:b0:141:59a4:247a])
 (user=stevensd job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3c47:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-396d0e27e11mr5441676a91.1.1787873490274;
 Thu, 27 Aug 2026 16:31:30 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:29:45 -0700
In-Reply-To: <20260827232948.2520558-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827232948.2520558-8-stevensd@google.com>
Subject: [RFC 07/10] Reclaim stacks via a shrinker
From: David Stevens <stevensd@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, suleiman@google.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"

Use a shrinker to reclaim unused portions of blocked task stacks. The
core of the shrinker is a list_lru. A referenced bit is used to require
that a stack remains unused for long enough to be seen by the shrinker
twice.

To minimize how much work is done in the scheduler path and under the
pi_lock, tasks are initially put onto a regular list before being moved
onto the list_lru by a shrinker. Additionally, tasks are not proactively
removed from the lru when they become unblocked - again, to reduce what
happens in the scheduler path.

Signed-off-by: David Stevens <stevensd@google.com>
---
 include/linux/sched.h   |  13 +-
 kernel/stack_shrinker.c | 400 ++++++++++++++++++++++++++++++++++------
 2 files changed, 357 insertions(+), 56 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index c93a234fac96..dc241d1c058f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -83,7 +83,6 @@ struct sched_dl_entity;
 struct seq_file;
 struct sighand_struct;
 struct signal_struct;
-struct stack_reclaim_work;
 struct task_delay_info;
 struct task_exec_state;
 struct task_group;
@@ -835,9 +834,17 @@ enum stack_reclaim_enum {
 	STACK_RECLAIMED		= 5,
 } __packed;
 
+enum stack_reclaim_lru_state_enum {
+	STACK_LRU_NOT_PRESENT	= 0,
+	STACK_LRU_PENDING	= 1,
+	STACK_LRU_NEW		= 2,
+	STACK_LRU_OLD		= 3,
+} __packed;
+
 union stack_reclaim_state {
 	struct {
 		enum stack_reclaim_enum stack_state;
+		enum stack_reclaim_lru_state_enum lru_state;
 		u16 node;
 	};
 	u32 val;
@@ -845,6 +852,7 @@ union stack_reclaim_state {
 
 union stack_reclaim_list {
 	struct llist_node refill_entry;
+	struct list_head reclaim_entry;
 };
 #endif
 
@@ -1618,9 +1626,6 @@ struct task_struct {
 #ifdef CONFIG_MEMCG
 	struct obj_cgroup		*stack_obj_cgroup;
 #endif
-
-	// TODO: Replace these with a shrinker
-	struct stack_reclaim_work	*stack_reclaim_work;
 #endif
 #endif
 #ifdef CONFIG_THREAD_INFO_IN_TASK
diff --git a/kernel/stack_shrinker.c b/kernel/stack_shrinker.c
index d7b1a7dfa716..62cc5303d69b 100644
--- a/kernel/stack_shrinker.c
+++ b/kernel/stack_shrinker.c
@@ -26,28 +26,41 @@ struct repopulate_work {
 
 static DEFINE_PER_CPU(struct repopulate_work, repopulate_work);
 
-// TODO: replace with shrinker
-struct stack_reclaim_work {
-	struct task_struct *tsk;
-	struct irq_work irq_work;
-	struct work_struct work;
-};
+static DEFINE_RAW_SPINLOCK(new_reclaimable_stacks_lock);
+static LIST_HEAD(new_reclaimable_stacks);
 
-static void schedule_stack_reclaim_work(struct irq_work *w)
-{
-	struct stack_reclaim_work *work = container_of(w, typeof(*work), irq_work);
+static struct list_lru reclaimable_stacks_lru;
 
-	if (!queue_work(system_wq, &work->work))
-		put_task_struct(work->tsk);
-}
+/*
+ * do_shrink_slab() wants us to scan (nr_obj / (1 << priority)), but unless
+ * reclaim is really struggling, that can round down to 0 for a lot of
+ * memcgs. Compensate for that by scaling count and batch size.
+ */
+#define STACK_COUNT_SHIFT DEF_PRIORITY
+/*
+ * Large batch sizes (like the 128 default) can result in spiky behavior, where
+ * deferred work acculmulates and then all of a memcg's stacks get scanned all
+ * at once.
+ */
+#define STACK_BATCH_SIZE 4
 
-static void do_reclaim_stack(struct task_struct *tsk);
+/*
+ * For purposes of shrinker iteration, a stack allocated with NUMA_NO_NODE is
+ * associated with the node that created it. This extra bit allows us to
+ * determine if NUMA_NO_NODE or the saved node should be used for repopulation.
+ */
+#define TASK_NUMA_NO_NODE_FLAG BIT(15)
 
-static void do_stack_reclaim_work(struct work_struct *w)
+static int task_shrinker_node(struct task_struct *tsk)
 {
-	struct task_struct *tsk = container_of(w, struct stack_reclaim_work, work)->tsk;
+	return tsk->stack_reclaim_state.node & ~TASK_NUMA_NO_NODE_FLAG;
+}
 
-	do_reclaim_stack(tsk);
+static int task_alloc_node(struct task_struct *tsk)
+{
+	if (tsk->stack_reclaim_state.node & TASK_NUMA_NO_NODE_FLAG)
+		return NUMA_NO_NODE;
+	return tsk->stack_reclaim_state.node;
 }
 
 #ifdef CONFIG_MEMCG
@@ -85,17 +98,13 @@ void add_to_stack_shrinker(struct task_struct *tsk, int node)
 
 	tsk->stack_reclaim_state.val = 0;
 	tsk->stack_reclaim_state.stack_state = STACK_IN_USE;
-	tsk->stack_reclaim_state.node = node;
+	tsk->stack_reclaim_state.lru_state = STACK_LRU_NOT_PRESENT;
 	set_stack_obj_cgroup(tsk);
-	init_llist_node(&tsk->stack_reclaim_list.refill_entry);
+	INIT_LIST_HEAD(&tsk->stack_reclaim_list.reclaim_entry);
 
-	// TODO: replace with shrinker
-	tsk->stack_reclaim_work = kmalloc_obj(*tsk->stack_reclaim_work, GFP_KERNEL);
-	BUG_ON(!tsk->stack_reclaim_work);
-
-	tsk->stack_reclaim_work->tsk = tsk;
-	init_irq_work(&tsk->stack_reclaim_work->irq_work, schedule_stack_reclaim_work);
-	INIT_WORK(&tsk->stack_reclaim_work->work, do_stack_reclaim_work);
+	if (node == NUMA_NO_NODE)
+		node = numa_node_id() | TASK_NUMA_NO_NODE_FLAG;
+	tsk->stack_reclaim_state.node = node;
 }
 
 static inline int calculate_num_unused_pages(struct task_struct *tsk)
@@ -118,8 +127,7 @@ static bool repopulate_stack(struct task_struct *tsk, bool is_deferred,
 	struct vm_struct *vm_area = tsk->stack_vm_area;
 	unsigned long addr = (unsigned long)vm_area->addr;
 	struct mem_cgroup *tsk_memcg, *old_active_memcg;
-	int node = tsk->stack_reclaim_state.node == U16_MAX ? NUMA_NO_NODE
-							    : tsk->stack_reclaim_state.node;
+	int node = task_alloc_node(tsk);
 
 	num_missing_pages = (THREAD_SIZE >> PAGE_SHIFT) - vm_area->nr_pages;
 	if (num_missing_pages == 0)
@@ -239,21 +247,6 @@ static void do_reclaim_stack(struct task_struct *tsk)
 {
 	union stack_reclaim_state prev_state, target_state;
 
-	prev_state.val = READ_ONCE(tsk->stack_reclaim_state.val);
-	do {
-		target_state.val = prev_state.val;
-		if (prev_state.stack_state == STACK_RECLAIMABLE)
-			target_state.stack_state = STACK_RECLAIMING;
-	} while (!try_cmpxchg(&tsk->stack_reclaim_state.val, &prev_state.val, target_state.val));
-
-	/*
-	 * If target_state.stack_state == STACK_RECLAIMING, we know tsk is still
-	 * alive and can't run until we're done, so putting the ref here is safe.
-	 */
-	put_task_struct(tsk);
-	if (target_state.stack_state != STACK_RECLAIMING)
-		return;
-
 	release_stack(tsk);
 
 	prev_state.val = READ_ONCE(tsk->stack_reclaim_state.val);
@@ -271,6 +264,245 @@ static void do_reclaim_stack(struct task_struct *tsk)
 	}
 }
 
+static void process_one_new_reclaimable_stack(struct task_struct *tsk, struct list_head *new_stacks)
+{
+	union stack_reclaim_state prev_state, target_state;
+
+	prev_state.val = READ_ONCE(tsk->stack_reclaim_state.val);
+	do {
+		target_state.val = prev_state.val;
+
+		switch (prev_state.stack_state) {
+		case STACK_IN_USE:
+		case STACK_PREPARE_RECLAIM:
+			target_state.lru_state = STACK_LRU_NOT_PRESENT;
+			break;
+		case STACK_RECLAIMABLE:
+			target_state.lru_state = STACK_LRU_NEW;
+			break;
+		case STACK_RECLAIMING:
+		case STACK_RECLAIMING_IN_USE:
+		case STACK_RECLAIMED:
+			/*
+			 * These states only happen after a shrinker has started
+			 * processing a stack, so seeing one of these means
+			 * multiple shrinkers are somehow targeting one stack.
+			 */
+			WARN(1, "task with stack state %x on list\n", prev_state.val);
+			put_task_struct(tsk);
+			return;
+		}
+	} while (!try_cmpxchg(&tsk->stack_reclaim_state.val, &prev_state.val, target_state.val));
+
+	if (target_state.stack_state == STACK_RECLAIMABLE)
+		list_add(&tsk->stack_reclaim_list.reclaim_entry, new_stacks);
+	else
+		put_task_struct(tsk);
+}
+
+static void process_new_reclaimable_stacks(void)
+{
+	LIST_HEAD(new_stacks);
+	struct task_struct *tsk, *tmp;
+
+	scoped_guard(raw_spinlock_irq, &new_reclaimable_stacks_lock) {
+		while ((tsk = list_first_entry_or_null(&new_reclaimable_stacks,
+						       typeof(*tsk),
+						       stack_reclaim_list.reclaim_entry))) {
+			list_del_init(&tsk->stack_reclaim_list.reclaim_entry);
+
+			/*
+			 * We hold a ref on the task during the interval when a
+			 * stack is being moved from new_reclaimable_stacks
+			 * onto the lru, to avoid needing to deal with races
+			 * against remove_from_stack_shrinker(). If tryget
+			 * fails here, tsk is about to be deleted, so we can
+			 * just skip it.
+			 */
+			if (!tryget_task_struct(tsk))
+				continue;
+
+			raw_spin_unlock_irq(&new_reclaimable_stacks_lock);
+
+			process_one_new_reclaimable_stack(tsk, &new_stacks);
+
+			raw_spin_lock_irq(&new_reclaimable_stacks_lock);
+		}
+	}
+
+	list_for_each_entry_safe(tsk, tmp, &new_stacks, stack_reclaim_list.reclaim_entry) {
+		struct mem_cgroup *memcg = get_stack_memcg(tsk);
+
+		list_del_init(&tsk->stack_reclaim_list.reclaim_entry);
+
+		if (memcg_list_lru_alloc(memcg, &reclaimable_stacks_lru, GFP_ATOMIC) == 0) {
+			local_bh_disable();
+			list_lru_add(&reclaimable_stacks_lru,
+				     &tsk->stack_reclaim_list.reclaim_entry,
+				     task_shrinker_node(tsk), memcg);
+			local_bh_enable();
+		} else {
+			union stack_reclaim_state prev_state, target_state;
+
+			pr_warn_ratelimited("failed to allocate stack reclaim metadata\n");
+
+			/*
+			 * Just give up if memcg_list_lru_alloc() fails. We
+			 * could try immediately reclaiming the stack, but
+			 * reclaiming a single stack isn't going to help if
+			 * things are so bad a GFP_ATOMIC slab allocation fails.
+			 */
+			prev_state.val = READ_ONCE(tsk->stack_reclaim_state.val);
+			do {
+				target_state.val = prev_state.val;
+				if (prev_state.stack_state == STACK_RECLAIMABLE)
+					target_state.stack_state = STACK_RECLAIMED;
+				target_state.lru_state = STACK_LRU_NOT_PRESENT;
+			} while (!try_cmpxchg(&tsk->stack_reclaim_state.val,
+					      &prev_state.val, target_state.val));
+		}
+
+		mem_cgroup_put(memcg);
+		put_task_struct(tsk);
+	}
+}
+
+static enum lru_status isolate_lru_stack(struct list_head *item,
+					 struct list_lru_one *lru, void *arg)
+{
+	struct list_head *to_reclaim = arg;
+	struct task_struct *tsk = container_of(item, struct task_struct,
+					       stack_reclaim_list.reclaim_entry);
+	union stack_reclaim_state prev_state, target_state;
+	enum lru_status ret;
+	bool is_isolated = false;
+
+	prev_state.val = READ_ONCE(tsk->stack_reclaim_state.val);
+	do {
+		target_state.val = prev_state.val;
+
+		switch (prev_state.stack_state) {
+		case STACK_IN_USE:
+		case STACK_PREPARE_RECLAIM:
+			target_state.lru_state = STACK_LRU_NOT_PRESENT;
+			ret = LRU_REMOVED;
+			break;
+		case STACK_RECLAIMABLE:
+			switch (prev_state.lru_state) {
+			case STACK_LRU_NEW:
+				target_state.lru_state = STACK_LRU_OLD;
+				ret = LRU_ROTATE;
+				break;
+			case STACK_LRU_OLD:
+				target_state.stack_state = STACK_RECLAIMING;
+				target_state.lru_state = STACK_LRU_NOT_PRESENT;
+				ret = LRU_REMOVED;
+				break;
+			case STACK_LRU_NOT_PRESENT:
+			case STACK_LRU_PENDING:
+				WARN(1, "item on stack reclaim lru with bad state\n");
+				list_lru_isolate(lru, item);
+				return LRU_REMOVED;
+			}
+			break;
+		case STACK_RECLAIMING:
+		case STACK_RECLAIMING_IN_USE:
+		case STACK_RECLAIMED:
+			/*
+			 * These states only happen after a shrinker has started
+			 * processing a stack, so seeing one of these means
+			 * multiple shrinkers are somehow targeting one stack.
+			 */
+			WARN(1, "stack with state %x on list\n", prev_state.val);
+			list_lru_isolate(lru, item);
+			return LRU_REMOVED;
+		}
+
+		/*
+		 * We need to isolate the item before the cmpxchg to prevent
+		 * races with process_one_new_reclaimable_stack() adding the
+		 * entry to its new_stacks list.
+		 */
+		if (ret == LRU_REMOVED && !is_isolated) {
+			is_isolated = true;
+			list_lru_isolate(lru, item);
+		}
+	} while (!try_cmpxchg(&tsk->stack_reclaim_state.val, &prev_state.val, target_state.val));
+
+	if (target_state.stack_state == STACK_RECLAIMING) {
+		/*
+		 * The task can't be freed since STACK_RECLAIMING prevents
+		 * it from running and exiting, so no need to hold a ref.
+		 */
+		list_add_tail(item, to_reclaim);
+	} else if (target_state.stack_state == STACK_RECLAIMABLE) {
+		/*
+		 * If we isolated but then lost a cmpxchg race against
+		 * __allow_stack_reclaim(), we need to undo the isolation.
+		 *
+		 * STACK_RECLAIMABLE means we observed the task blocked (i.e.
+		 * not dead). Even if the task dies and its refcount hits zero,
+		 * RCU cleanup of the task will be delayed because the lru walk
+		 * is guarded by local_bh_disable(), so unlocking won't cause
+		 * races with remove_from_stack_shrinker().
+		 */
+		if (is_isolated) {
+			struct mem_cgroup *lru_memcg;
+
+			spin_unlock(&lru->lock);
+
+			lru_memcg = get_stack_memcg(tsk);
+			list_lru_add(&reclaimable_stacks_lru, item,
+				     task_shrinker_node(tsk), lru_memcg);
+			mem_cgroup_put(lru_memcg);
+
+			ret = LRU_REMOVED_RETRY;
+
+		} else {
+			WARN(target_state.lru_state != STACK_LRU_OLD,
+			     "Reclaimable stack with bad state %x\n", target_state.val);
+		}
+	} else {
+		WARN(target_state.lru_state != STACK_LRU_NOT_PRESENT,
+		     "Isolate stack with bad state %x\n", target_state.val);
+	}
+
+	return ret;
+}
+
+static unsigned long scan_reclaimable_stacks(struct shrinker *shrinker,
+					     struct shrink_control *sc)
+{
+	unsigned long freed = 0;
+	LIST_HEAD(to_reclaim);
+	struct task_struct *tsk, *tmp;
+
+	sc->nr_to_scan >>= STACK_COUNT_SHIFT;
+	local_bh_disable();
+	list_lru_shrink_walk(&reclaimable_stacks_lru, sc,
+			     isolate_lru_stack, &to_reclaim);
+	local_bh_enable();
+
+	list_for_each_entry_safe(tsk, tmp, &to_reclaim, stack_reclaim_list.reclaim_entry) {
+		freed++;
+		list_del_init(&tsk->stack_reclaim_list.reclaim_entry);
+		do_reclaim_stack(tsk);
+	}
+
+	return freed << STACK_COUNT_SHIFT;
+}
+
+static unsigned long get_reclaimable_stack_count(struct shrinker *shrinker,
+						 struct shrink_control *sc)
+{
+	unsigned long count;
+
+	process_new_reclaimable_stacks();
+	count = list_lru_shrink_count(&reclaimable_stacks_lru, sc);
+
+	return count ? (unsigned long)(count << STACK_COUNT_SHIFT) : SHRINK_EMPTY;
+}
+
 static void do_repopulate_stacks(struct work_struct *w)
 {
 	struct repopulate_work *work = container_of(w, struct repopulate_work, work);
@@ -285,7 +517,7 @@ static void do_repopulate_stacks(struct work_struct *w)
 				wake_up_state(tsk, TASK_STACK_RECLAIM);
 			} else {
 				/*
-				 * Repopulate only failes due to low memory. If
+				 * Repopulate only fails due to low memory. If
 				 * that happens, give the rest of the system a
 				 * chance to free some memory.
 				 */
@@ -387,6 +619,7 @@ void __prepare_stack_for_reclaim(struct task_struct *tsk)
 void __allow_stack_reclaim(struct task_struct *tsk)
 {
 	union stack_reclaim_state prev_state, target_state;
+	bool add_to_list = false;
 
 	if (WARN_ON_ONCE(tsk->__state == TASK_DEAD))
 		return;
@@ -401,14 +634,17 @@ void __allow_stack_reclaim(struct task_struct *tsk)
 			return;
 		}
 		target_state.stack_state = STACK_RECLAIMABLE;
+		if (prev_state.lru_state == STACK_LRU_NOT_PRESENT) {
+			target_state.lru_state = STACK_LRU_PENDING;
+			add_to_list = true;
+		} else if (prev_state.lru_state == STACK_LRU_OLD) {
+			target_state.lru_state = STACK_LRU_NEW;
+		}
 	} while (!try_cmpxchg(&tsk->stack_reclaim_state.val, &prev_state.val, target_state.val));
 
-	if (irq_work_queue(&tsk->stack_reclaim_work->irq_work)) {
-		/*
-		 * Take a ref that gets released by do_reclaim_stack() so we don't
-		 * have to worry about races with remove_from_stack_shrinker().
-		 */
-		get_task_struct(tsk);
+	if (add_to_list) {
+		guard(raw_spinlock_irqsave)(&new_reclaimable_stacks_lock);
+		list_add(&tsk->stack_reclaim_list.reclaim_entry, &new_reclaimable_stacks);
 	}
 }
 
@@ -421,8 +657,34 @@ void __allow_stack_reclaim(struct task_struct *tsk)
  */
 void remove_from_stack_shrinker(struct task_struct *tsk)
 {
+	struct mem_cgroup *lru_memcg;
+
+	/*
+	 * Since tsk is being deleted, the tryget_task_struct() call in
+	 * process_new_reclaimable_stacks() excludes racing with a shrinker
+	 * moving the task from STACK_LRU_PENDING -> STACK_LRU_NEW. A race can
+	 * just result in the delete operation being a no-op.
+	 */
+	switch (READ_ONCE(tsk->stack_reclaim_state.lru_state)) {
+	case STACK_LRU_NOT_PRESENT:
+		break;
+	case STACK_LRU_PENDING:
+		scoped_guard(raw_spinlock_irqsave, &new_reclaimable_stacks_lock) {
+			if (!list_empty(&tsk->stack_reclaim_list.reclaim_entry))
+				list_del_init(&tsk->stack_reclaim_list.reclaim_entry);
+		}
+		break;
+	case STACK_LRU_NEW:
+	case STACK_LRU_OLD:
+		lru_memcg = get_stack_memcg(tsk);
+		local_bh_disable();
+		list_lru_del(&reclaimable_stacks_lru, &tsk->stack_reclaim_list.reclaim_entry,
+			     task_shrinker_node(tsk), lru_memcg);
+		local_bh_enable();
+		mem_cgroup_put(lru_memcg);
+		break;
+	}
 	put_stack_obj_cgroup(tsk);
-	kfree(tsk->stack_reclaim_work);
 }
 
 void wake_stack_repopulate(void)
@@ -431,6 +693,8 @@ void wake_stack_repopulate(void)
 	preempt_enable();
 }
 
+static struct lock_class_key stack_shrinker_key;
+
 static int stack_shrinker_cpuhp_setup(unsigned int cpu)
 {
 	struct repopulate_work *work = per_cpu_ptr(&repopulate_work, cpu);
@@ -448,16 +712,48 @@ static int stack_shrinker_cpuhp_teardown(unsigned int cpu)
 
 static int __init fork_late_init(void)
 {
+	struct shrinker *shrinker;
+	const char *msg;
 	int ret;
+	enum cpuhp_state cpuhp_val;
 
 	ret = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "stack_shrinker",
 				stack_shrinker_cpuhp_setup,
 				stack_shrinker_cpuhp_teardown);
 	if (ret < 0) {
-		WARN(1, "Failed to initialize stack_shrinker cpuhp %d\n", ret);
-		return 0;
+		msg = "cpuhp failure";
+		goto cpuhp_setup_fail;
+	}
+	cpuhp_val = ret;
+
+	shrinker = shrinker_alloc(SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE,
+				  "stack_shrinker");
+	if (!shrinker) {
+		msg = "shrinker alloc failure";
+		ret = -ENOMEM;
+		goto shrinker_alloc_fail;
 	}
 
+	ret = list_lru_init_memcg_key(&reclaimable_stacks_lru, shrinker,
+				      &stack_shrinker_key);
+	if (ret != 0) {
+		msg = "list_lru_init failure";
+		goto list_lru_init_fail;
+	}
+
+	shrinker->count_objects = get_reclaimable_stack_count;
+	shrinker->scan_objects = scan_reclaimable_stacks;
+	shrinker->seeks = 4;
+	shrinker->batch = STACK_BATCH_SIZE << STACK_COUNT_SHIFT;
+	shrinker_register(shrinker);
+	return 0;
+
+list_lru_init_fail:
+	shrinker_free(shrinker);
+shrinker_alloc_fail:
+	cpuhp_remove_state(cpuhp_val);
+cpuhp_setup_fail:
+	WARN(1, "Failed to initialize stack_shrinker %s: %d\n", msg, ret);
 	return 0;
 }
 
-- 
2.55.0.897.gb25b4bd76c-goog

