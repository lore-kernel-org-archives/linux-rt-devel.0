Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCAE36165C;
	Fri, 27 Feb 2026 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772212092; cv=none; b=Lk50gQZlC1MNqilnEh6q5M5w0C1jTNwLqmxN+TmWKFsGq+mQCkYBtBOYU9NibbjmPCvm/fKZ2RiQuRQqgJYiZbE52udnHWkHT8qQ/IouwUwosTDSwXFhrIInfY53SQQM1f4+hQhwCfFOFmGz47iAfA/xWfU12DVijgokOiOshMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772212092; c=relaxed/simple;
	bh=WUPDRrdwa5SkEyMU6GHPLmb001wCRNzEwHKZ7p9JCcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FJeh/zX0lOVH+QkIvt0QENqjYAN0DeYLO7L6cYKCViCWNAg2Kype/fH0waSJmSaYBm8S8D626g7ug/EeWIzYS9/2MQ9fjX/8t3+VAHMcEC/RW3Ut7tCpoK+DhyzoQcn8jZif1lf56UIcfk2t1eITjONQGO5RFVn63FwcPJzYb4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIusV8/z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIusV8/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FF9C2BC87;
	Fri, 27 Feb 2026 17:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772212091;
	bh=WUPDRrdwa5SkEyMU6GHPLmb001wCRNzEwHKZ7p9JCcI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nIusV8/zKNisDdm7CqRh9RiJxfIUV+V+BJVzPXzF7x2LZZPgK/DyfuzonpoBJ/jCy
	 hOrK9MB3PDZ0UBi2NiR4TnW9Hd05XeDJELywAS/IlR7w42XZUNZ2TMi8B4I3lfA4d5
	 1VeTqLhlgEyGa60Z1/FLBMKuFUhPRjcuPXs8BVqWlU0nWeSsEJrGReNa29OgzzcRwV
	 aSpVrWoysuIiAGO35s1hviNh4nCqGpY7ACZlLbXk/CnN4RUabZ6YwlQiMYiBZR4cbu
	 O+dpm/uNsffyVps9Fgk1tw1A3WIXbEKv0nigd2zJs31u4ChCEHGhPjtP5aIZTCH7UE
	 SJpCZZ+9ObdPQ==
From: Vlastimil Babka <vbabka@kernel.org>
Date: Fri, 27 Feb 2026 18:07:59 +0100
Subject: [PATCH 2/3] mm/page_alloc: remove IRQ saving/restoring from pcp
 locking
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260227-b4-pcp-locking-cleanup-v1-2-f7e22e603447@kernel.org>
References: <20260227-b4-pcp-locking-cleanup-v1-0-f7e22e603447@kernel.org>
In-Reply-To: <20260227-b4-pcp-locking-cleanup-v1-0-f7e22e603447@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>
Cc: Mel Gorman <mgorman@techsingularity.net>, 
 Matthew Wilcox <willy@infradead.org>, 
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.14.3

Effectively revert commit 038a102535eb ("mm/page_alloc: prevent pcp
corruption with SMP=n"). The original problem is now avoided by
pcp_spin_trylock() always failing on CONFIG_SMP=n, so we do not need to
disable IRQs anymore.

It's not a complete revert, because keeping the pcp_spin_(un)lock()
wrappers is useful. Rename them from _maybe_irqsave/restore to _nopin.
The difference from pcp_spin_trylock()/pcp_spin_unlock() is that the
_nopin variants don't perform pcpu_task_pin/unpin().

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 mm/page_alloc.c | 46 ++++++++++++++++------------------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 65efcaeb8800..8e5b30adfe40 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -155,24 +155,14 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
 		BUG_ON(1)
 #endif
 
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
-static inline void __flags_noop(unsigned long *flags) { }
-#define pcp_spin_lock_maybe_irqsave(ptr, flags)		\
-({							\
-	 __flags_noop(&(flags));			\
-	 spin_lock(&(ptr)->lock);			\
-})
-#define pcp_spin_unlock_maybe_irqrestore(ptr, flags)	\
-({							\
-	 spin_unlock(&(ptr)->lock);			\
-	 __flags_noop(&(flags));			\
-})
-#else
-#define pcp_spin_lock_maybe_irqsave(ptr, flags)		\
-		spin_lock_irqsave(&(ptr)->lock, flags)
-#define pcp_spin_unlock_maybe_irqrestore(ptr, flags)	\
-		spin_unlock_irqrestore(&(ptr)->lock, flags)
-#endif
+/*
+ * In some cases we do not need to pin the task to the CPU because we are
+ * already given a specific cpu's pcp pointer.
+ */
+#define pcp_spin_lock_nopin(ptr)			\
+		spin_lock(&(ptr)->lock)
+#define pcp_spin_unlock_nopin(ptr)			\
+		spin_unlock(&(ptr)->lock)
 
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
@@ -2572,7 +2562,6 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 {
 	int high_min, to_drain, to_drain_batched, batch;
-	unsigned long UP_flags;
 	bool todo = false;
 
 	high_min = READ_ONCE(pcp->high_min);
@@ -2592,9 +2581,9 @@ bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
 	to_drain = pcp->count - pcp->high;
 	while (to_drain > 0) {
 		to_drain_batched = min(to_drain, batch);
-		pcp_spin_lock_maybe_irqsave(pcp, UP_flags);
+		pcp_spin_lock_nopin(pcp);
 		free_pcppages_bulk(zone, to_drain_batched, pcp, 0);
-		pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
+		pcp_spin_unlock_nopin(pcp);
 		todo = true;
 
 		to_drain -= to_drain_batched;
@@ -2611,15 +2600,14 @@ bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp)
  */
 void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 {
-	unsigned long UP_flags;
 	int to_drain, batch;
 
 	batch = READ_ONCE(pcp->batch);
 	to_drain = min(pcp->count, batch);
 	if (to_drain > 0) {
-		pcp_spin_lock_maybe_irqsave(pcp, UP_flags);
+		pcp_spin_lock_nopin(pcp);
 		free_pcppages_bulk(zone, to_drain, pcp, 0);
-		pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
+		pcp_spin_unlock_nopin(pcp);
 	}
 }
 #endif
@@ -2630,11 +2618,10 @@ void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp)
 static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 {
 	struct per_cpu_pages *pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
-	unsigned long UP_flags;
 	int count;
 
 	do {
-		pcp_spin_lock_maybe_irqsave(pcp, UP_flags);
+		pcp_spin_lock_nopin(pcp);
 		count = pcp->count;
 		if (count) {
 			int to_drain = min(count,
@@ -2643,7 +2630,7 @@ static void drain_pages_zone(unsigned int cpu, struct zone *zone)
 			free_pcppages_bulk(zone, to_drain, pcp, 0);
 			count -= to_drain;
 		}
-		pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
+		pcp_spin_unlock_nopin(pcp);
 	} while (count);
 }
 
@@ -6127,7 +6114,6 @@ static void zone_pcp_update_cacheinfo(struct zone *zone, unsigned int cpu)
 {
 	struct per_cpu_pages *pcp;
 	struct cpu_cacheinfo *cci;
-	unsigned long UP_flags;
 
 	pcp = per_cpu_ptr(zone->per_cpu_pageset, cpu);
 	cci = get_cpu_cacheinfo(cpu);
@@ -6138,12 +6124,12 @@ static void zone_pcp_update_cacheinfo(struct zone *zone, unsigned int cpu)
 	 * This can reduce zone lock contention without hurting
 	 * cache-hot pages sharing.
 	 */
-	pcp_spin_lock_maybe_irqsave(pcp, UP_flags);
+	pcp_spin_lock_nopin(pcp);
 	if ((cci->per_cpu_data_slice_size >> PAGE_SHIFT) > 3 * pcp->batch)
 		pcp->flags |= PCPF_FREE_HIGH_BATCH;
 	else
 		pcp->flags &= ~PCPF_FREE_HIGH_BATCH;
-	pcp_spin_unlock_maybe_irqrestore(pcp, UP_flags);
+	pcp_spin_unlock_nopin(pcp);
 }
 
 void setup_pcp_cacheinfo(unsigned int cpu)

-- 
2.53.0

