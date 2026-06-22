Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4135839A7E7
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122528; cv=none; b=YP88+OV0D9SKC0HFcLVq14tT+faUWIXc/bfsJIrEIquRifodPYee6RQFY6HVfakrpnHGC+MrdimwpY48ffO2NJMrHfvWU8OJnL6qUnwmTZjuBV+BuSxRitgKd9mxRF6jfNOEx/e83PdAAPc1VdS1H38spXYxSWkQL3LHjv302JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122528; c=relaxed/simple;
	bh=lSrfEAdp+xzeMpkJERzhgKn4D4brE9Ytl6icNjrBrKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fr/pogqn/5gJtYK5dLtx3hlNDh6QpKtvjUbAi+wRzR0d9itPvWUi4FeyNOQYOJvJsfxPKDkoD7f1J+t+o+YW9q3FoiWR53oHpn8qzgH2alVt7ZyBBU2gRBf6R7BnLoShWdimjgQz1DJpjolAiYnh7oTS+Q33ReLpFG5wJCqSU/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6MfOiKh; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6MfOiKh"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-463dd955dafso2573871f8f.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122520; x=1782727320; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LYiGzvh99rMY4kNYNexhfMgzkwWFV4iojo7tWSGYnXM=;
        b=m6MfOiKhIzRVLtcm+F6Q1IlM3gIX16eWOu+LmhXZcuQn+yRLeGnuwBBHKkkhcqBmdD
         scZsHQd+dacTyrYOsbMxqiaPndonbmrx+onDWbR5KHZo1Ph+AgaewLRK8YusBQDkcV+Z
         WKD6ZD9OxhVbZRVrVWNgZ2h3QLOLDj9p8JKOTu+Kfx/R0wr0CyDHRubRthB+SBFszBmz
         VYxQRFWyp6fGiYj/BhSOYjvJMRJ4QIZ3MDcpZ6ptxsS98OYwXFB1yGvs3U7Mln7jsnX8
         HOtlQbP232bJBu5y8L5Ebm3WYlKFEfbyx+eDvlrjtVx31NEdEIEB+COLGAeLrDodCTAL
         6F4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122520; x=1782727320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LYiGzvh99rMY4kNYNexhfMgzkwWFV4iojo7tWSGYnXM=;
        b=UM3i8pa+SnGtZvI4r6QmzW4PduabcWQ1RR9Tc1c2RGbfgm+HP+V+x3PosQ/YaXZbnM
         dVwrF8fe++M+Ln9ZVwaDW9awXQwwbQBFkkfuwA1hsR7jZFBXjwjWhRu5qFniKziJwCdc
         DgKDE8++mzzTy2ZhSXnoThrswmWIiu/9LXS4lmRf9HSiJcaGK9y05TuPCpuFLuOdrOdH
         3fwASyLDqm+EmMytlsLHiEsauNP9BaIJDDIN4hRejXSn81cKXW6Pyv77x6a+viUNfBd5
         sHPhAaKfV8T0q4cBsK0eEPuWvro/swNiY7QidIP11HPP1cwAunpTvehUBTkDQdnLiF1v
         s91Q==
X-Forwarded-Encrypted: i=1; AFNElJ/PqK1dB6fMNz1t5qDwzQSD5eMQZ6eHBOAoFAZ9EydyfNGEk1cwAEtHv6Xw56uewXIvqXv53DKit0GRpW2TIw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy5C/38xMpycrfl+Pk1dX0kmOw3nEZpJgCx0oZw0Iygvt3QIy9W
	PfUn4mPFqJ6JYj7Km/2kc9GB9swNZeqc35b/ETe9sNazaPCdFbx88dxyk7bIW25vrHpDqmhCx9o
	x8Mp9XzUSRP6IKQ==
X-Received: from wmbf6.prod.google.com ([2002:a05:600c:5946:b0:492:4336:6b5f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a00e:b0:492:4cce:53e2 with SMTP id 5b1f17b1804b1-4924cce540emr110031025e9.3.1782122518697;
 Mon, 22 Jun 2026 03:01:58 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:40 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-13-31f31367d420@google.com>
Subject: [PATCH v2 13/13] mm: remove __GFP_NO_CODETAG
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Matthew Brost <matthew.brost@intel.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>, 
	Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price <gourry@gourry.net>, 
	Johannes Weiner <hannes@cmpxchg.org>, Alexei Starovoitov <ast@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Now that alloc_pages has an entrypoint that allows passing alloc_flags,
we can take advantage of this to start removing GFP flags that are only
used for mm-internal stuff.

This requires also plumbing the alloc_flags into some more of the
allocator code, in particular __alloc_pages[_noprof]() gets an
alloc_flags arg to go along with its callees, and we now need to pass
those flags deeper into the allocator so they can reach the alloc_tag
code.

To try and keep the new ALLOC_NO_CODETAG's scope nice and narrow, don't
define it in mm/internal.h, instead just define a "reserved bit" and
then use that in places that don't care about what it means.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/alloc_tag.c       | 18 ++++++++++--------
 mm/compaction.c      |  4 ++--
 mm/internal.h        |  8 ++++++--
 mm/page_alloc.c      | 42 ++++++++++++++++++++++++------------------
 mm/page_frag_cache.c |  4 ++--
 5 files changed, 44 insertions(+), 32 deletions(-)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index d9be1cf5187d9..61a6cba32ff35 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -15,6 +15,8 @@
 #include <linux/vmalloc.h>
 #include <linux/kmemleak.h>
 
+#include "internal.h"
+
 #define ALLOCINFO_FILE_NAME		"allocinfo"
 #define MODULE_ALLOC_TAG_VMAP_SIZE	(100000UL * sizeof(struct alloc_tag))
 #define SECTION_START(NAME)		(CODETAG_SECTION_START_PREFIX NAME)
@@ -785,16 +787,15 @@ struct pfn_pool {
 					 sizeof(unsigned long))
 
 /*
- * Skip early PFN recording for a page allocation.  Reuses the
- * %__GFP_NO_OBJ_EXT bit.  Used by __alloc_tag_add_early_pfn() to avoid
- * recursion when allocating pages for the early PFN tracking list
- * itself.
+ * Skip early PFN recording for a page allocation.  Used by
+ * __alloc_tag_add_early_pfn() to avoid recursion when allocating pages for the
+ * early PFN tracking list itself.
  *
  * Codetags of the pages allocated with __GFP_NO_CODETAG should be
  * cleared (via clear_page_tag_ref()) before freeing the pages to prevent
  * alloc_tag_sub_check() from triggering a warning.
  */
-#define __GFP_NO_CODETAG		__GFP_NO_OBJ_EXT
+#define ALLOC_NO_CODETAG		__ALLOC_ALLOC_TAG
 
 static struct pfn_pool *current_pfn_pool __initdata;
 
@@ -806,7 +807,8 @@ static void __init __alloc_tag_add_early_pfn(unsigned long pfn)
 	do {
 		pool = READ_ONCE(current_pfn_pool);
 		if (!pool || atomic_read(&pool->count) >= PFN_POOL_SIZE) {
-			struct page *new_page = alloc_page(__GFP_HIGH | __GFP_NO_CODETAG);
+			struct page *new_page = __alloc_pages(__GFP_HIGH, 0, numa_mem_id(),
+							      NULL, ALLOC_NO_CODETAG);
 			struct pfn_pool *new;
 
 			if (!new_page) {
@@ -837,7 +839,7 @@ typedef void alloc_tag_add_func(unsigned long pfn);
 static alloc_tag_add_func __rcu *alloc_tag_add_early_pfn_ptr __refdata =
 	RCU_INITIALIZER(__alloc_tag_add_early_pfn);
 
-void alloc_tag_add_early_pfn(unsigned long pfn, gfp_t gfp_flags)
+void alloc_tag_add_early_pfn(unsigned long pfn, unsigned int alloc_flags)
 {
 	alloc_tag_add_func *alloc_tag_add;
 
@@ -845,7 +847,7 @@ void alloc_tag_add_early_pfn(unsigned long pfn, gfp_t gfp_flags)
 		return;
 
 	/* Skip allocations for the tracking list itself to avoid recursion. */
-	if (gfp_flags & __GFP_NO_CODETAG)
+	if (alloc_flags & ALLOC_NO_CODETAG)
 		return;
 
 	rcu_read_lock();
diff --git a/mm/compaction.c b/mm/compaction.c
index b776f35ad0200..e90ebd2c54f48 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -82,7 +82,7 @@ static inline bool is_via_compact_memory(int order) { return false; }
 
 static struct page *mark_allocated_noprof(struct page *page, unsigned int order, gfp_t gfp_flags)
 {
-	post_alloc_hook(page, order, __GFP_MOVABLE);
+	post_alloc_hook(page, order, __GFP_MOVABLE, ALLOC_DEFAULT);
 	set_page_refcounted(page);
 	return page;
 }
@@ -1850,7 +1850,7 @@ static struct folio *compaction_alloc_noprof(struct folio *src, unsigned long da
 	}
 	dst = (struct folio *)freepage;
 
-	post_alloc_hook(&dst->page, order, __GFP_MOVABLE);
+	post_alloc_hook(&dst->page, order, __GFP_MOVABLE, ALLOC_DEFAULT);
 	set_page_refcounted(&dst->page);
 	if (order)
 		prep_compound_page(&dst->page, order);
diff --git a/mm/internal.h b/mm/internal.h
index 0847b55bfc147..a45bedb9ada5f 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -684,6 +684,8 @@ struct alloc_context {
 	 */
 	enum zone_type highest_zoneidx;
 	bool spread_dirty_pages;
+	/* Only flags that are global to the whole allocation go here. */
+	unsigned int alloc_flags;
 };
 
 /*
@@ -907,7 +909,8 @@ static inline void init_compound_tail(struct page *tail,
 	prep_compound_tail(tail, head, order);
 }
 
-void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
+void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags,
+		     unsigned int alloc_flags);
 extern bool free_pages_prepare(struct page *page, unsigned int order);
 
 extern int user_min_free_kbytes;
@@ -1481,6 +1484,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
 #define ALLOC_NOLOCK		0x400 /* Only use spin_trylock in allocation path */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
+#define __ALLOC_ALLOC_TAG      0x1000 /* Reserved bit for use by alloc_tag code */
 
 /* Flags that allow allocations below the min watermark. */
 #define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
@@ -1956,7 +1960,7 @@ bool may_expand_vm(struct mm_struct *mm, const vma_flags_t *vma_flags,
 		   unsigned long npages);
 
 struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
-		nodemask_t *nodemask);
+		nodemask_t *nodemask, unsigned int alloc_flags);
 #define __alloc_pages(...)			alloc_hooks(__alloc_pages_noprof(__VA_ARGS__))
 
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d99e4ea8307ea..d50fd9c77a2e8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1246,7 +1246,7 @@ void __clear_page_tag_ref(struct page *page)
 /* Should be called only if mem_alloc_profiling_enabled() */
 static noinline
 void __pgalloc_tag_add(struct page *page, struct task_struct *task,
-		       unsigned int nr, gfp_t gfp_flags)
+		       unsigned int nr, unsigned int alloc_flags)
 {
 	union pgtag_ref_handle handle;
 	union codetag_ref ref;
@@ -1260,17 +1260,17 @@ void __pgalloc_tag_add(struct page *page, struct task_struct *task,
 		 * page_ext is not available yet, record the pfn so we can
 		 * clear the tag ref later when page_ext is initialized.
 		 */
-		alloc_tag_add_early_pfn(page_to_pfn(page), gfp_flags);
+		alloc_tag_add_early_pfn(page_to_pfn(page), alloc_flags);
 		if (task->alloc_tag)
 			alloc_tag_set_inaccurate(task->alloc_tag);
 	}
 }
 
 static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
-				   unsigned int nr, gfp_t gfp_flags)
+				   unsigned int nr, unsigned int alloc_flags)
 {
 	if (mem_alloc_profiling_enabled())
-		__pgalloc_tag_add(page, task, nr, gfp_flags);
+		__pgalloc_tag_add(page, task, nr, alloc_flags);
 }
 
 /* Should be called only if mem_alloc_profiling_enabled() */
@@ -1807,7 +1807,7 @@ static inline bool should_skip_init(gfp_t flags)
 }
 
 inline void post_alloc_hook(struct page *page, unsigned int order,
-				gfp_t gfp_flags)
+				gfp_t gfp_flags, unsigned int alloc_flags)
 {
 	const bool zero_tags = gfp_flags & __GFP_ZEROTAGS;
 	bool init = !want_init_on_free() && want_init_on_alloc(gfp_flags) &&
@@ -1858,13 +1858,13 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	set_page_owner(page, order, gfp_flags);
 	page_table_check_alloc(page, order);
-	pgalloc_tag_add(page, current, 1 << order, gfp_flags);
+	pgalloc_tag_add(page, current, 1 << order, alloc_flags);
 }
 
 static void prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
 							unsigned int alloc_flags)
 {
-	post_alloc_hook(page, order, gfp_flags);
+	post_alloc_hook(page, order, gfp_flags, alloc_flags);
 
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
@@ -4773,8 +4773,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * The fast path uses conservative alloc_flags to succeed only until
 	 * kswapd needs to be woken up, and to avoid the cost of setting up
 	 * alloc_flags precisely. So we do that now.
+	 *
+	 * Can't just or alloc_flags if it contains WMARK bits, but those flags
+	 * shouldn't be set in ac->alloc_flags.
 	 */
-	alloc_flags = slowpath_alloc_flags(gfp_mask, order);
+	VM_WARN_ON(ac->alloc_flags & ALLOC_WMARK_MASK);
+	alloc_flags = ac->alloc_flags | slowpath_alloc_flags(gfp_mask, order);
 
 	/*
 	 * We need to recalculate the starting point for the zonelist iterator
@@ -4816,7 +4820,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
 	if (reserve_flags)
 		alloc_flags = cma_alloc_flags(gfp_mask, reserve_flags) |
-					  (alloc_flags & ALLOC_KSWAPD);
+				ac->alloc_flags | (alloc_flags & ALLOC_KSWAPD);
 
 	/*
 	 * Reset the nodemask and zonelist iterators if memory policies can be
@@ -5218,7 +5222,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	return nr_populated;
 
 failed:
-	page = __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask);
+	page = __alloc_pages_noprof(gfp, 0, preferred_nid, nodemask, ALLOC_DEFAULT);
 	if (page)
 		page_array[nr_populated++] = page;
 	goto out;
@@ -5326,11 +5330,13 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 {
 	struct page *page;
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
-	struct alloc_context ac = { };
+	struct alloc_context ac = {
+		.alloc_flags = alloc_flags,
+	};
 	unsigned int fastpath_alloc_flags = alloc_flags;
 
 	/* Other flags could be supported later if needed. */
-	if (WARN_ON(alloc_flags & ~ALLOC_NOLOCK))
+	if (WARN_ON(alloc_flags & ~(ALLOC_NOLOCK | __ALLOC_ALLOC_TAG)))
 		return NULL;
 
 	if (!alloc_order_allowed(gfp, order, alloc_flags))
@@ -5398,12 +5404,12 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 EXPORT_SYMBOL(__alloc_frozen_pages_noprof);
 
 struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
-		int preferred_nid, nodemask_t *nodemask)
+		int preferred_nid, nodemask_t *nodemask, unsigned int alloc_flags)
 {
 	struct page *page;
 
 	page = __alloc_frozen_pages_noprof(gfp, order, preferred_nid, nodemask,
-					   ALLOC_DEFAULT);
+					   alloc_flags);
 	if (page)
 		set_page_refcounted(page);
 	return page;
@@ -5418,14 +5424,14 @@ struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order
 	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
 	warn_if_node_offline(nid, gfp_mask);
 
-	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
+	return __alloc_pages_noprof(gfp_mask, order, nid, NULL, ALLOC_DEFAULT);
 }
 
 struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask)
 {
 	struct page *page = __alloc_pages_noprof(gfp | __GFP_COMP, order,
-					preferred_nid, nodemask);
+					preferred_nid, nodemask, ALLOC_DEFAULT);
 	return page_rmappable_folio(page);
 }
 EXPORT_SYMBOL(__folio_alloc_noprof);
@@ -7107,7 +7113,7 @@ static void split_free_frozen_pages(struct list_head *list, gfp_t gfp_mask)
 		list_for_each_entry_safe(page, next, &list[order], lru) {
 			int i;
 
-			post_alloc_hook(page, order, gfp_mask);
+			post_alloc_hook(page, order, gfp_mask, ALLOC_DEFAULT);
 			if (!order)
 				continue;
 
@@ -7312,7 +7318,7 @@ int alloc_contig_frozen_range_noprof(unsigned long start, unsigned long end,
 		struct page *head = pfn_to_page(start);
 
 		check_new_pages(head, order);
-		prep_new_page(head, order, gfp_mask, 0);
+		prep_new_page(head, order, gfp_mask, ALLOC_DEFAULT);
 	} else {
 		ret = -EINVAL;
 		WARN(true, "PFN range: requested [%lu, %lu), allocated [%lu, %lu)\n",
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index d2423f30577e4..d9573170e0719 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -57,10 +57,10 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	gfp_mask = (gfp_mask & ~__GFP_DIRECT_RECLAIM) |  __GFP_COMP |
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = __alloc_pages(gfp_mask, PAGE_FRAG_CACHE_MAX_ORDER,
-			     numa_mem_id(), NULL);
+			     numa_mem_id(), NULL, ALLOC_DEFAULT);
 #endif
 	if (unlikely(!page)) {
-		page = __alloc_pages(gfp, 0, numa_mem_id(), NULL);
+		page = __alloc_pages(gfp, 0, numa_mem_id(), NULL, ALLOC_DEFAULT);
 		order = 0;
 	}
 

-- 
2.54.0

