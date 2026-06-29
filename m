Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4657840F8F8
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738743; cv=none; b=SmtjrRHDzPo6WFsRtucz//uLbyb3aw3RmvYSWeJqVfQsuebeUkfdiu21LXNbDGjkZS1uumw+lE27kCH0bR1O3aVC/74LUaJGVwfHZqd+RuLDJ5ozjRXRRtRX3AAQ+TaLTR29EFaTgweLEavY0po60nqz8nMnkPDAaFKKrMYdmXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738743; c=relaxed/simple;
	bh=A6PO5m7eHsHCJ4z+aVyz3I2OdNJT25l7xWYbsMDayv4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GXKWV1v1kBrH39lSV+imeqh5uhpTScp95kausAVQLOjQqxw7KGi9uaIvKKpavEaZjik31NuFyAUeC0HK/2VWhM/sWIaadKnFn77/LbEsAT/x2EXeNcbLnu+Y31gzeJKdj3p3FCTs6Du/DmTluEksqbmPPBODJNh5W369OkhhzE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KJUXTQyv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KJUXTQyv"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493b0fe95b6so6142135e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738740; x=1783343540; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBLoZqf012NY8oih347qhngSGnPXSeDLqQelzL8Sglc=;
        b=KJUXTQyv4bJWxrp2PWSN3vZ6KYhKcCNn+PzkyQEUE1U2j+gLlas/VOTf/rrR7jJLSq
         ajGkw18oK98ZkLLjwDhHu7HEcP7dFcl9JtKgci/uw0JUFFYIZl+SayhqTVzjMyDjElxk
         R9sf2g9aEjv8oLO5e8Pz00wbU4aY4MCWi1V3bUO2Wvegnjl4i5Ufirp1eVQadSk3ZU68
         j9Pc2InbQkAH0cGH6eH7lSmItFlZRggontt4j3lHwEUM1bn7cTeDx824rb33QMHXb5QN
         HDyL91j9c3dWkn9zGhic7hgY23z/IXtF8gs9zzxfBteJBylJg/mWLsOehi1Y1xdkKpHe
         xGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738740; x=1783343540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBLoZqf012NY8oih347qhngSGnPXSeDLqQelzL8Sglc=;
        b=qN3PgHYJmtIHW2FKiPsh4AaTEiA4oep9Wv9eeunC8QchPkQ/qq1wwIKMlK+sVEzZOQ
         jzvXOQdhaQNHRFPcxEmWKhG1EB8ctBAQX5fj7IuH/RhABnrHqI5gphS5tgSOllnyS+Nl
         RGVaka9WMMmp1UcS327MqRaxVDCKAu757Aymde95ZEJ/iaJsQJ858ubGgHAkS1bslUA8
         8kvPZrAvLmToFQsB/wMan0ZCmOgZZHT6mYJdeNF9rjY7xHamkgpvIXyEUJAwaMQBF8kI
         lK+bd6N+2V6aKXDIcbDiFx36Sk63n+rdqdDM2fNJCOZ8eI1w2gmAkBTekZ+eXCktYPEx
         YJ5g==
X-Forwarded-Encrypted: i=1; AFNElJ+ui/ZMVeILv2zmo8pCbXu0HaNvs3+sb3jQnC9doiw3ZoAAFgzAGqe1vgsyFAOWW84SmHGdq3gdi5WsBgVISA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw71mdmpN/hN1wQ+zuWykLKGALWwwA/Smn3j0UzIqgacjJdC3u+
	s/PABZHwvo9XfV+D4VNZweV3PV0F7Tv57Il6nkfCyb3/ja2Zxm/0YiZS77LStpHHkWg9cznucj6
	aKEXxVmqM9LWdPQ==
X-Received: from wmph19.prod.google.com ([2002:a05:600c:4993:b0:493:b008:cbbb])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e03:b0:493:b4cf:d37a with SMTP id 5b1f17b1804b1-493b4cfd454mr27579035e9.4.1782738739272;
 Mon, 29 Jun 2026 06:12:19 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:53 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-4-57bef0eadbc2@google.com>
Subject: [PATCH v3 04/16] mm: Split out internal page_alloc.h
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
	Matthew Wilcox <willy@infradead.org>, Hao Ge <hao.ge@linux.dev>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

internal.h is a bit bloated, seems like time for a page_alloc.h.

Where it wasn't obvious, the heuristic for deciding what goes into this
new header was "does it support/correspond to a definition in
mm/page_alloc.c?"

Only need to include it from 15 .c files out of 164 so this does seem
like a genuine reduction in scopes, which is nice. And there's no
circular internal.h<->page_alloc.h dependency, so it seems worthwhile to
split this up before that inevitably emerges!

Suggested-by: "David Hildenbrand (Arm)" <david@kernel.org>
Link: https://lore.kernel.org/all/41e92bab-6882-401a-8de9-154adbdcfb36@kernel.org/
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 MAINTAINERS          |   1 +
 mm/compaction.c      |   1 +
 mm/hugetlb.c         |   1 +
 mm/internal.h        | 252 -----------------------------------------------
 mm/khugepaged.c      |   1 +
 mm/memory-failure.c  |   1 +
 mm/memory_hotplug.c  |   1 +
 mm/mempolicy.c       |   1 +
 mm/mm_init.c         |   1 +
 mm/page_alloc.c      |   1 +
 mm/page_alloc.h      | 269 +++++++++++++++++++++++++++++++++++++++++++++++++++
 mm/page_frag_cache.c |   2 +-
 mm/page_isolation.c  |   1 +
 mm/page_owner.c      |   2 +-
 mm/show_mem.c        |   1 +
 mm/slub.c            |   1 +
 mm/swap.c            |   1 +
 mm/vmscan.c          |   1 +
 18 files changed, 285 insertions(+), 254 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f55cc75801f4c..978a04e1f7cc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17171,6 +17171,7 @@ F:	mm/debug_page_alloc.c
 F:	mm/debug_page_ref.c
 F:	mm/fail_page_alloc.c
 F:	mm/page_alloc.c
+F:	mm/page_alloc.h
 F:	mm/page_ext.c
 F:	mm/page_frag_cache.c
 F:	mm/page_isolation.c
diff --git a/mm/compaction.c b/mm/compaction.c
index f08765ade014c..7d80735502d9a 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -24,6 +24,7 @@
 #include <linux/page_owner.h>
 #include <linux/psi.h>
 #include <linux/cpuset.h>
+#include "page_alloc.h"
 #include "internal.h"
 
 #ifdef CONFIG_COMPACTION
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index fb7ad2a4a26b4..f7925624c4d2e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -47,6 +47,7 @@
 #include <linux/node.h>
 #include <linux/page_owner.h>
 #include "internal.h"
+#include "page_alloc.h"
 #include "hugetlb_vmemmap.h"
 #include "hugetlb_cma.h"
 #include "hugetlb_internal.h"
diff --git a/mm/internal.h b/mm/internal.h
index 8ce59c5664497..c22284f04fc9e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -658,165 +658,6 @@ extern int defrag_mode;
 void setup_per_zone_wmarks(void);
 void calculate_min_free_kbytes(void);
 int __meminit init_per_zone_wmark_min(void);
-void page_alloc_sysctl_init(void);
-
-/*
- * Structure for holding the mostly immutable allocation parameters passed
- * between functions involved in allocations, including the alloc_pages*
- * family of functions.
- *
- * nodemask, migratetype and highest_zoneidx are initialized only once in
- * __alloc_pages() and then never change.
- *
- * zonelist, preferred_zone and highest_zoneidx are set first in
- * __alloc_pages() for the fast path, and might be later changed
- * in __alloc_pages_slowpath(). All other functions pass the whole structure
- * by a const pointer.
- */
-struct alloc_context {
-	struct zonelist *zonelist;
-	const nodemask_t *nodemask;
-	struct zoneref *preferred_zoneref;
-	int migratetype;
-
-	/*
-	 * highest_zoneidx represents highest usable zone index of
-	 * the allocation request. Due to the nature of the zone,
-	 * memory on lower zone than the highest_zoneidx will be
-	 * protected by lowmem_reserve[highest_zoneidx].
-	 *
-	 * highest_zoneidx is also used by reclaim/compaction to limit
-	 * the target zone since higher zone than this index cannot be
-	 * usable for this allocation request.
-	 */
-	enum zone_type highest_zoneidx;
-	bool spread_dirty_pages;
-};
-
-/*
- * This function returns the order of a free page in the buddy system. In
- * general, page_zone(page)->lock must be held by the caller to prevent the
- * page from being allocated in parallel and returning garbage as the order.
- * If a caller does not hold page_zone(page)->lock, it must guarantee that the
- * page cannot be allocated or merged in parallel. Alternatively, it must
- * handle invalid values gracefully, and use buddy_order_unsafe() below.
- */
-static inline unsigned int buddy_order(struct page *page)
-{
-	/* PageBuddy() must be checked by the caller */
-	return page_private(page);
-}
-
-/*
- * Like buddy_order(), but for callers who cannot afford to hold the zone lock.
- * PageBuddy() should be checked first by the caller to minimize race window,
- * and invalid values must be handled gracefully.
- *
- * READ_ONCE is used so that if the caller assigns the result into a local
- * variable and e.g. tests it for valid range before using, the compiler cannot
- * decide to remove the variable and inline the page_private(page) multiple
- * times, potentially observing different values in the tests and the actual
- * use of the result.
- */
-#define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
-
-/*
- * This function checks whether a page is free && is the buddy
- * we can coalesce a page and its buddy if
- * (a) the buddy is not in a hole (check before calling!) &&
- * (b) the buddy is in the buddy system &&
- * (c) a page and its buddy have the same order &&
- * (d) a page and its buddy are in the same zone.
- *
- * For recording whether a page is in the buddy system, we set PageBuddy.
- * Setting, clearing, and testing PageBuddy is serialized by zone->lock.
- *
- * For recording page's order, we use page_private(page).
- */
-static inline bool page_is_buddy(struct page *page, struct page *buddy,
-				 unsigned int order)
-{
-	if (!page_is_guard(buddy) && !PageBuddy(buddy))
-		return false;
-
-	if (buddy_order(buddy) != order)
-		return false;
-
-	/*
-	 * zone check is done late to avoid uselessly calculating
-	 * zone/node ids for pages that could never merge.
-	 */
-	if (page_zone_id(page) != page_zone_id(buddy))
-		return false;
-
-	VM_BUG_ON_PAGE(page_count(buddy) != 0, buddy);
-
-	return true;
-}
-
-/*
- * Locate the struct page for both the matching buddy in our
- * pair (buddy1) and the combined O(n+1) page they form (page).
- *
- * 1) Any buddy B1 will have an order O twin B2 which satisfies
- * the following equation:
- *     B2 = B1 ^ (1 << O)
- * For example, if the starting buddy (buddy2) is #8 its order
- * 1 buddy is #10:
- *     B2 = 8 ^ (1 << 1) = 8 ^ 2 = 10
- *
- * 2) Any buddy B will have an order O+1 parent P which
- * satisfies the following equation:
- *     P = B & ~(1 << O)
- *
- * Assumption: *_mem_map is contiguous at least up to MAX_PAGE_ORDER
- */
-static inline unsigned long
-__find_buddy_pfn(unsigned long page_pfn, unsigned int order)
-{
-	return page_pfn ^ (1 << order);
-}
-
-/*
- * Find the buddy of @page and validate it.
- * @page: The input page
- * @pfn: The pfn of the page, it saves a call to page_to_pfn() when the
- *       function is used in the performance-critical __free_one_page().
- * @order: The order of the page
- * @buddy_pfn: The output pointer to the buddy pfn, it also saves a call to
- *             page_to_pfn().
- *
- * The found buddy can be a non PageBuddy, out of @page's zone, or its order is
- * not the same as @page. The validation is necessary before use it.
- *
- * Return: the found buddy page or NULL if not found.
- */
-static inline struct page *find_buddy_page_pfn(struct page *page,
-			unsigned long pfn, unsigned int order, unsigned long *buddy_pfn)
-{
-	unsigned long __buddy_pfn = __find_buddy_pfn(pfn, order);
-	struct page *buddy;
-
-	buddy = page + (__buddy_pfn - pfn);
-	if (buddy_pfn)
-		*buddy_pfn = __buddy_pfn;
-
-	if (page_is_buddy(page, buddy, order))
-		return buddy;
-	return NULL;
-}
-
-extern struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
-				unsigned long end_pfn, struct zone *zone);
-
-static inline struct page *pageblock_pfn_to_page(unsigned long start_pfn,
-				unsigned long end_pfn, struct zone *zone)
-{
-	if (zone->contiguous)
-		return pfn_to_page(start_pfn);
-
-	return __pageblock_pfn_to_page(start_pfn, end_pfn, zone);
-}
 
 void set_zone_contiguous(struct zone *zone);
 bool pfn_range_intersects_zones(int nid, unsigned long start_pfn,
@@ -831,8 +672,6 @@ extern int __isolate_free_page(struct page *page, unsigned int order);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
 extern void memblock_free_pages(unsigned long pfn, unsigned int order);
-extern void __free_pages_core(struct page *page, unsigned int order,
-		enum meminit_context context);
 
 /*
  * This will have no effect, other than possibly generating a warning, if the
@@ -914,40 +753,6 @@ static inline void init_compound_tail(struct page *tail,
 	prep_compound_tail(tail, head, order);
 }
 
-void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
-extern bool free_pages_prepare(struct page *page, unsigned int order);
-
-extern int user_min_free_kbytes;
-
-struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order, int nid,
-		nodemask_t *nodemask);
-#define __alloc_frozen_pages(...) \
-	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
-void free_frozen_pages(struct page *page, unsigned int order);
-void free_unref_folios(struct folio_batch *fbatch);
-
-#ifdef CONFIG_NUMA
-struct page *alloc_frozen_pages_noprof(gfp_t, unsigned int order);
-#else
-static inline struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order)
-{
-	return __alloc_frozen_pages_noprof(gfp, order, numa_node_id(), NULL);
-}
-#endif
-
-#define alloc_frozen_pages(...) \
-	alloc_hooks(alloc_frozen_pages_noprof(__VA_ARGS__))
-
-struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order);
-#define alloc_frozen_pages_nolock(...) \
-	alloc_hooks(alloc_frozen_pages_nolock_noprof(__VA_ARGS__))
-void free_frozen_pages_nolock(struct page *page, unsigned int order);
-
-extern void zone_pcp_reset(struct zone *zone);
-extern void zone_pcp_disable(struct zone *zone);
-extern void zone_pcp_enable(struct zone *zone);
-extern void zone_pcp_init(struct zone *zone);
-
 extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
 			  phys_addr_t min_addr,
 			  int nid, bool exact_nid);
@@ -1101,23 +906,6 @@ static inline void init_cma_pageblock(struct page *page)
 }
 #endif
 
-enum fallback_result {
-	/* Found suitable migratetype, *mt_out is valid. */
-	FALLBACK_FOUND,
-	/* No fallback found in requested order. */
-	FALLBACK_EMPTY,
-	/* Passed @claimable, but claiming whole block is a bad idea. */
-	FALLBACK_NOCLAIM,
-};
-enum fallback_result
-find_suitable_fallback(struct free_area *area, unsigned int order,
-		       int migratetype, bool claimable, int *mt_out);
-
-static inline bool free_area_empty(struct free_area *area, int migratetype)
-{
-	return list_empty(&area->free_list[migratetype]);
-}
-
 /* mm/util.c */
 struct anon_vma *folio_anon_vma(const struct folio *folio);
 
@@ -1445,46 +1233,6 @@ extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
 unsigned long reclaim_pages(struct list_head *folio_list);
 unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 					    struct list_head *folio_list);
-/* The ALLOC_WMARK bits are used as an index to zone->watermark */
-#define ALLOC_WMARK_MIN		WMARK_MIN
-#define ALLOC_WMARK_LOW		WMARK_LOW
-#define ALLOC_WMARK_HIGH	WMARK_HIGH
-#define ALLOC_NO_WATERMARKS	0x04 /* don't check watermarks at all */
-
-/* Mask to get the watermark bits */
-#define ALLOC_WMARK_MASK	(ALLOC_NO_WATERMARKS-1)
-
-/*
- * Only MMU archs have async oom victim reclaim - aka oom_reaper so we
- * cannot assume a reduced access to memory reserves is sufficient for
- * !MMU
- */
-#ifdef CONFIG_MMU
-#define ALLOC_OOM		0x08
-#else
-#define ALLOC_OOM		ALLOC_NO_WATERMARKS
-#endif
-
-#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. Allow access
-				       * to 25% of the min watermark or
-				       * 62.5% if __GFP_HIGH is set.
-				       */
-#define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
-				       * of the min watermark.
-				       */
-#define ALLOC_CPUSET		 0x40 /* check for correct cpuset */
-#define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */
-#ifdef CONFIG_ZONE_DMA32
-#define ALLOC_NOFRAGMENT	0x100 /* avoid mixing pageblock types */
-#else
-#define ALLOC_NOFRAGMENT	  0x0
-#endif
-#define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
-#define ALLOC_NOLOCK		0x400 /* Only use spin_trylock in allocation path */
-#define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
-
-/* Flags that allow allocations below the min watermark. */
-#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
 
 enum ttu_flags;
 struct tlbflush_unmap_batch;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 617bca76db49b..58e14d1543ecb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -26,6 +26,7 @@
 
 #include <asm/tlb.h>
 #include "internal.h"
+#include "page_alloc.h"
 #include "mm_slot.h"
 
 enum scan_result {
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a09d85142da46..49edc37ad4324 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -66,6 +66,7 @@
 #include <trace/events/memory-failure.h>
 
 #include "swap.h"
+#include "page_alloc.h"
 #include "internal.h"
 
 static int sysctl_memory_failure_early_kill __read_mostly;
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7ac19fab22632..9539e40c478ed 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -40,6 +40,7 @@
 #include <asm/tlbflush.h>
 
 #include "internal.h"
+#include "page_alloc.h"
 #include "shuffle.h"
 
 enum {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 36699fabd3c22..9c740324f9160 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -119,6 +119,7 @@
 #include <linux/memory.h>
 
 #include "internal.h"
+#include "page_alloc.h"
 
 /* Internal flags */
 #define MPOL_MF_DISCONTIG_OK (MPOL_MF_INTERNAL << 0)	/* Skip checks for continuous vmas */
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 4026b084bd4bf..32593cca124f8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -33,6 +33,7 @@
 #include <linux/kexec_handover.h>
 #include <linux/hugetlb.h>
 #include "internal.h"
+#include "page_alloc.h"
 #include "slab.h"
 #include "shuffle.h"
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6010693861ec2..a3ba63c7f9199 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -56,6 +56,7 @@
 #include <linux/pgalloc_tag.h>
 #include <asm/div64.h>
 #include "internal.h"
+#include "page_alloc.h"
 #include "shuffle.h"
 #include "page_reporting.h"
 
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
new file mode 100644
index 0000000000000..3250d44f96457
--- /dev/null
+++ b/mm/page_alloc.h
@@ -0,0 +1,269 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * mm-internal API for the page (buddy) allocator. Public API lives in
+ * include/linux/gfp.h.
+ */
+#ifndef __MM_PAGE_ALLOC_H
+#define __MM_PAGE_ALLOC_H
+
+#include <linux/mm.h>
+#include <linux/mmzone.h>
+#include <linux/nodemask.h>
+#include <linux/types.h>
+
+/* The ALLOC_WMARK bits are used as an index to zone->watermark */
+#define ALLOC_WMARK_MIN		WMARK_MIN
+#define ALLOC_WMARK_LOW		WMARK_LOW
+#define ALLOC_WMARK_HIGH	WMARK_HIGH
+#define ALLOC_NO_WATERMARKS	0x04 /* don't check watermarks at all */
+
+/* Mask to get the watermark bits */
+#define ALLOC_WMARK_MASK	(ALLOC_NO_WATERMARKS-1)
+
+/*
+ * Only MMU archs have async oom victim reclaim - aka oom_reaper so we
+ * cannot assume a reduced access to memory reserves is sufficient for
+ * !MMU
+ */
+#ifdef CONFIG_MMU
+#define ALLOC_OOM		0x08
+#else
+#define ALLOC_OOM		ALLOC_NO_WATERMARKS
+#endif
+
+#define ALLOC_NON_BLOCK		 0x10 /* Caller cannot block. Allow access
+				       * to 25% of the min watermark or
+				       * 62.5% if __GFP_HIGH is set.
+				       */
+#define ALLOC_MIN_RESERVE	 0x20 /* __GFP_HIGH set. Allow access to 50%
+				       * of the min watermark.
+				       */
+#define ALLOC_CPUSET		 0x40 /* check for correct cpuset */
+#define ALLOC_CMA		 0x80 /* allow allocations from CMA areas */
+#ifdef CONFIG_ZONE_DMA32
+#define ALLOC_NOFRAGMENT	0x100 /* avoid mixing pageblock types */
+#else
+#define ALLOC_NOFRAGMENT	  0x0
+#endif
+#define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
+#define ALLOC_NOLOCK		0x400 /* Only use spin_trylock in allocation path */
+#define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
+
+/* Flags that allow allocations below the min watermark. */
+#define ALLOC_RESERVES (ALLOC_NON_BLOCK|ALLOC_MIN_RESERVE|ALLOC_HIGHATOMIC|ALLOC_OOM)
+
+/*
+ * Structure for holding the mostly immutable allocation parameters passed
+ * between functions involved in allocations, including the alloc_pages*
+ * family of functions.
+ *
+ * nodemask, migratetype and highest_zoneidx are initialized only once in
+ * __alloc_pages() and then never change.
+ *
+ * zonelist, preferred_zone and highest_zoneidx are set first in
+ * __alloc_pages() for the fast path, and might be later changed
+ * in __alloc_pages_slowpath(). All other functions pass the whole structure
+ * by a const pointer.
+ */
+struct alloc_context {
+	struct zonelist *zonelist;
+	const nodemask_t *nodemask;
+	struct zoneref *preferred_zoneref;
+	int migratetype;
+
+	/*
+	 * highest_zoneidx represents highest usable zone index of
+	 * the allocation request. Due to the nature of the zone,
+	 * memory on lower zone than the highest_zoneidx will be
+	 * protected by lowmem_reserve[highest_zoneidx].
+	 *
+	 * highest_zoneidx is also used by reclaim/compaction to limit
+	 * the target zone since higher zone than this index cannot be
+	 * usable for this allocation request.
+	 */
+	enum zone_type highest_zoneidx;
+	bool spread_dirty_pages;
+};
+
+/*
+ * This function returns the order of a free page in the buddy system. In
+ * general, page_zone(page)->lock must be held by the caller to prevent the
+ * page from being allocated in parallel and returning garbage as the order.
+ * If a caller does not hold page_zone(page)->lock, it must guarantee that the
+ * page cannot be allocated or merged in parallel. Alternatively, it must
+ * handle invalid values gracefully, and use buddy_order_unsafe() below.
+ */
+static inline unsigned int buddy_order(struct page *page)
+{
+	/* PageBuddy() must be checked by the caller */
+	return page_private(page);
+}
+
+/*
+ * Like buddy_order(), but for callers who cannot afford to hold the zone lock.
+ * PageBuddy() should be checked first by the caller to minimize race window,
+ * and invalid values must be handled gracefully.
+ *
+ * READ_ONCE is used so that if the caller assigns the result into a local
+ * variable and e.g. tests it for valid range before using, the compiler cannot
+ * decide to remove the variable and inline the page_private(page) multiple
+ * times, potentially observing different values in the tests and the actual
+ * use of the result.
+ */
+#define buddy_order_unsafe(page)	READ_ONCE(page_private(page))
+
+/*
+ * This function checks whether a page is free && is the buddy
+ * we can coalesce a page and its buddy if
+ * (a) the buddy is not in a hole (check before calling!) &&
+ * (b) the buddy is in the buddy system &&
+ * (c) a page and its buddy have the same order &&
+ * (d) a page and its buddy are in the same zone.
+ *
+ * For recording whether a page is in the buddy system, we set PageBuddy.
+ * Setting, clearing, and testing PageBuddy is serialized by zone->lock.
+ *
+ * For recording page's order, we use page_private(page).
+ */
+static inline bool page_is_buddy(struct page *page, struct page *buddy,
+				 unsigned int order)
+{
+	if (!page_is_guard(buddy) && !PageBuddy(buddy))
+		return false;
+
+	if (buddy_order(buddy) != order)
+		return false;
+
+	/*
+	 * zone check is done late to avoid uselessly calculating
+	 * zone/node ids for pages that could never merge.
+	 */
+	if (page_zone_id(page) != page_zone_id(buddy))
+		return false;
+
+	VM_BUG_ON_PAGE(page_count(buddy) != 0, buddy);
+
+	return true;
+}
+
+/*
+ * Locate the struct page for both the matching buddy in our
+ * pair (buddy1) and the combined O(n+1) page they form (page).
+ *
+ * 1) Any buddy B1 will have an order O twin B2 which satisfies
+ * the following equation:
+ *     B2 = B1 ^ (1 << O)
+ * For example, if the starting buddy (buddy2) is #8 its order
+ * 1 buddy is #10:
+ *     B2 = 8 ^ (1 << 1) = 8 ^ 2 = 10
+ *
+ * 2) Any buddy B will have an order O+1 parent P which
+ * satisfies the following equation:
+ *     P = B & ~(1 << O)
+ *
+ * Assumption: *_mem_map is contiguous at least up to MAX_PAGE_ORDER
+ */
+static inline unsigned long
+__find_buddy_pfn(unsigned long page_pfn, unsigned int order)
+{
+	return page_pfn ^ (1 << order);
+}
+
+/*
+ * Find the buddy of @page and validate it.
+ * @page: The input page
+ * @pfn: The pfn of the page, it saves a call to page_to_pfn() when the
+ *       function is used in the performance-critical __free_one_page().
+ * @order: The order of the page
+ * @buddy_pfn: The output pointer to the buddy pfn, it also saves a call to
+ *             page_to_pfn().
+ *
+ * The found buddy can be a non PageBuddy, out of @page's zone, or its order is
+ * not the same as @page. The validation is necessary before use it.
+ *
+ * Return: the found buddy page or NULL if not found.
+ */
+static inline struct page *find_buddy_page_pfn(struct page *page,
+			unsigned long pfn, unsigned int order, unsigned long *buddy_pfn)
+{
+	unsigned long __buddy_pfn = __find_buddy_pfn(pfn, order);
+	struct page *buddy;
+
+	buddy = page + (__buddy_pfn - pfn);
+	if (buddy_pfn)
+		*buddy_pfn = __buddy_pfn;
+
+	if (page_is_buddy(page, buddy, order))
+		return buddy;
+	return NULL;
+}
+
+extern struct page *__pageblock_pfn_to_page(unsigned long start_pfn,
+				unsigned long end_pfn, struct zone *zone);
+
+static inline struct page *pageblock_pfn_to_page(unsigned long start_pfn,
+				unsigned long end_pfn, struct zone *zone)
+{
+	if (zone->contiguous)
+		return pfn_to_page(start_pfn);
+
+	return __pageblock_pfn_to_page(start_pfn, end_pfn, zone);
+}
+
+extern void __free_pages_core(struct page *page, unsigned int order,
+		enum meminit_context context);
+
+void post_alloc_hook(struct page *page, unsigned int order, gfp_t gfp_flags);
+extern bool free_pages_prepare(struct page *page, unsigned int order);
+
+extern int user_min_free_kbytes;
+
+struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order, int nid,
+		nodemask_t *nodemask);
+#define __alloc_frozen_pages(...) \
+	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
+void free_frozen_pages(struct page *page, unsigned int order);
+void free_unref_folios(struct folio_batch *fbatch);
+
+#ifdef CONFIG_NUMA
+struct page *alloc_frozen_pages_noprof(gfp_t, unsigned int order);
+#else
+static inline struct page *alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order)
+{
+	return __alloc_frozen_pages_noprof(gfp, order, numa_node_id(), NULL);
+}
+#endif
+
+#define alloc_frozen_pages(...) \
+	alloc_hooks(alloc_frozen_pages_noprof(__VA_ARGS__))
+
+struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned int order);
+#define alloc_frozen_pages_nolock(...) \
+	alloc_hooks(alloc_frozen_pages_nolock_noprof(__VA_ARGS__))
+void free_frozen_pages_nolock(struct page *page, unsigned int order);
+
+extern void zone_pcp_reset(struct zone *zone);
+extern void zone_pcp_disable(struct zone *zone);
+extern void zone_pcp_enable(struct zone *zone);
+extern void zone_pcp_init(struct zone *zone);
+
+enum fallback_result {
+	/* Found suitable migratetype, *mt_out is valid. */
+	FALLBACK_FOUND,
+	/* No fallback found in requested order. */
+	FALLBACK_EMPTY,
+	/* Passed @claimable, but claiming whole block is a bad idea. */
+	FALLBACK_NOCLAIM,
+};
+enum fallback_result
+find_suitable_fallback(struct free_area *area, unsigned int order,
+		       int migratetype, bool claimable, int *mt_out);
+
+static inline bool free_area_empty(struct free_area *area, int migratetype)
+{
+	return list_empty(&area->free_list[migratetype]);
+}
+
+void page_alloc_sysctl_init(void);
+
+#endif /* __MM_PAGE_ALLOC_H */
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index d2423f30577e4..a1077cef3a791 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -18,7 +18,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/page_frag_cache.h>
-#include "internal.h"
+#include "page_alloc.h"
 
 static unsigned long encoded_page_create(struct page *page, unsigned int order,
 					 bool pfmemalloc)
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 32ce8a7d9df35..e5dfc7bf49446 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -11,6 +11,7 @@
 #include <linux/page_owner.h>
 #include <linux/migrate.h>
 #include "internal.h"
+#include "page_alloc.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/page_isolation.h>
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 74a844a86441e..6f580a64bdba3 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -13,7 +13,7 @@
 #include <linux/memcontrol.h>
 #include <linux/sched/clock.h>
 
-#include "internal.h"
+#include "page_alloc.h"
 
 /*
  * TODO: teach PAGE_OWNER_STACK_DEPTH (__dump_page_owner and save_stack)
diff --git a/mm/show_mem.c b/mm/show_mem.c
index 1b721a8ade67d..d1288b4c2b640 100644
--- a/mm/show_mem.c
+++ b/mm/show_mem.c
@@ -16,6 +16,7 @@
 #include <linux/vmstat.h>
 
 #include "internal.h"
+#include "page_alloc.h"
 #include "swap.h"
 
 atomic_long_t _totalram_pages __read_mostly;
diff --git a/mm/slub.c b/mm/slub.c
index 9ec774dc70096..877021e69cc41 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -53,6 +53,7 @@
 #include <trace/events/kmem.h>
 
 #include "internal.h"
+#include "page_alloc.h"
 
 /*
  * Lock order:
diff --git a/mm/swap.c b/mm/swap.c
index 0132ed0fb76b6..5e389bcc073a9 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -39,6 +39,7 @@
 #include <linux/buffer_head.h>
 
 #include "internal.h"
+#include "page_alloc.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/pagemap.h>
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 754c5f5d716aa..de1879db39160 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -66,6 +66,7 @@
 #include <linux/sched/sysctl.h>
 
 #include "internal.h"
+#include "page_alloc.h"
 #include "swap.h"
 
 #define CREATE_TRACE_POINTS

-- 
2.54.0

