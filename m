Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75149408611
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738748; cv=none; b=E7K6wrbUBDuFIBlNH48ZLWOevnvqh3xQsWvNvXK4Z46QG66mdrLJjX1ms6bzQXgBe3n8MGRc6G0bWjOTv9oC3rxXgQtQzJMmMjH9yeYVHumYWsTs+C+v4IlX/fhbDrE+6hUQxPbN7c8LiegOhIf6vVuySZ0JHTCEwhmfHye/r9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738748; c=relaxed/simple;
	bh=JW40cAXM1eoOofUNrVE6e84eWLUSW5fZtM+zK/Zmeus=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WBUu1UCyO1pGOwLY7Y1Q95PyjLknMU/E5F/ckPotzmjSm1RmLjGO8GxqFpj0kJGdcDJCmh3o2AmpQzTAgr/9HC796uSus/mlJ1R1jHUlyoOm0CBh3Tn8U9//rwkMVQDusO0f3EBhKzS4gzgIuIrDNQ5uR3G54X716aEN8gyZLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVbjbPPy; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVbjbPPy"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c1263968a24so78940366b.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738746; x=1783343546; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2Xbl3DpTg332+B3HXNH9gd21p1cWVBDgn76IACGTuM=;
        b=lVbjbPPyo/Gm2MF4kjaILl+EqWXG10gaq3BiWLVBfh38fsczOgJ93O8VhjFzdyp5Ur
         P/6B3nplIkTTEe0HmwMCPIHL/pB6Ao2NNMaF98MsdMhke7+4G5VQx1p0zmJLnRs/rUIz
         FOaBUzElxGXHAhuuteBNasiGP4NTURfWLWi7Uw6kReya4U+Qywzo/ha+BVJYcGM7BzRI
         lpUNofsoXSJ9wzpbnaZyvtUFN7gar/zLhl3b00LO58aAVy+DjGMqYdH5R4P3JNZ+QCoF
         SIo0u+XN/5JvtnJ9fUg06Runq04YXsEZESD0lRg5hp+oIGUisQanRV73Dr0FKDAniwlq
         Zo3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738746; x=1783343546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2Xbl3DpTg332+B3HXNH9gd21p1cWVBDgn76IACGTuM=;
        b=dQ+c4m1tKgqnbbz4ZlmDyfjV+WFhhoqhnoiB7XeSsVCazwfWTCCrbE0r5WoB5bi0fi
         GdZgvJSK2iidmdWWwpdK0cM7zokd6FEmA+Rspt3SooShtQHNh3VoKyHcbjh6CJw9RZnH
         2bKUOxnBPYY2tcqYNtgIo9PDs3tF9aCSHhQL9XxdBhU8MHUi7M5AwfphZpsfrcu5mzRC
         IMfv0iDTazut3f9RvZz/kMEwe41uANNnjmHKLfYb0WbUy6JCtFewDRmmdqnk63lMvgvg
         +L7fGSe0fl5+xNVH+O5kc0zpr4syAdFgCRs1AAaEyojkntrARbOwu2ctpVY5EeJTB6Mx
         Gsng==
X-Forwarded-Encrypted: i=1; AHgh+RpgdrxicNrThMHiCsq5U/9WUCIHRr6AKMqZwGUeoc1JbPJ/irPf66mNf7UPhtj2dI7e25GXdGUGiHOc1Tmh7Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNuR6kDFzDI/i3ERcoj91SCJfimrSSV6V3PBOoZ0xl/yjXr0zy
	Ql1Yp+HOgzMPkjCW/26FudyqkNWRnjnuI1iK8/bTDWAG3+dJwVv3bm5xAhu3ryk2jcM0U99afZT
	LUPOjVsN20j3L4g==
X-Received: from edge12-n2.prod.google.com ([2002:a05:6402:a54c:20b0:698:6fd7:ef0c])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:9f8a:b0:bee:f541:1dca with SMTP id a640c23a62f3a-c1205eb8582mr908967466b.28.1782738743913;
 Mon, 29 Jun 2026 06:12:23 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:56 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-7-57bef0eadbc2@google.com>
Subject: [PATCH v3 07/16] mm: move some stuff to mm/page_alloc.h
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

Some of this stuff in the public header is only used internally so
shrink the scope to avoid silently growing new users.

drain_local_pages() is still used from kernel/power/snapshot.c so that
needs to stay behind.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/gfp.h | 26 --------------------------
 mm/page_alloc.h     | 28 ++++++++++++++++++++++++++++
 mm/vmstat.c         |  1 +
 3 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index cdf95a9f0b87c..01d6d2591f49e 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -17,28 +17,6 @@ struct mempolicy;
 #define __default_gfp(a,b,...) b
 #define default_gfp(...) __default_gfp(,##__VA_ARGS__,GFP_KERNEL)
 
-/* Convert GFP flags to their corresponding migrate type */
-#define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
-#define GFP_MOVABLE_SHIFT 3
-
-static inline int gfp_migratetype(const gfp_t gfp_flags)
-{
-	VM_WARN_ON((gfp_flags & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
-	BUILD_BUG_ON((1UL << GFP_MOVABLE_SHIFT) != ___GFP_MOVABLE);
-	BUILD_BUG_ON((___GFP_MOVABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_MOVABLE);
-	BUILD_BUG_ON((___GFP_RECLAIMABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_RECLAIMABLE);
-	BUILD_BUG_ON(((___GFP_MOVABLE | ___GFP_RECLAIMABLE) >>
-		      GFP_MOVABLE_SHIFT) != MIGRATE_HIGHATOMIC);
-
-	if (unlikely(page_group_by_mobility_disabled))
-		return MIGRATE_UNMOVABLE;
-
-	/* Group based on mobility */
-	return (__force unsigned long)(gfp_flags & GFP_MOVABLE_MASK) >> GFP_MOVABLE_SHIFT;
-}
-#undef GFP_MOVABLE_MASK
-#undef GFP_MOVABLE_SHIFT
-
 static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
 {
 	return !!(gfp_flags & __GFP_DIRECT_RECLAIM);
@@ -395,10 +373,6 @@ extern void free_pages(unsigned long addr, unsigned int order);
 #define __free_page(page) __free_pages((page), 0)
 #define free_page(addr) free_pages((addr), 0)
 
-void page_alloc_init_cpuhp(void);
-bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
-void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
-void drain_all_pages(struct zone *zone);
 void drain_local_pages(struct zone *zone);
 
 void page_alloc_init_late(void);
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index e16f905f859a7..af83764788b96 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -266,6 +266,34 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
 	return list_empty(&area->free_list[migratetype]);
 }
 
+/* Convert GFP flags to their corresponding migrate type */
+#define GFP_MOVABLE_MASK (__GFP_RECLAIMABLE|__GFP_MOVABLE)
+#define GFP_MOVABLE_SHIFT 3
+
+static inline int gfp_migratetype(const gfp_t gfp_flags)
+{
+	VM_WARN_ON((gfp_flags & GFP_MOVABLE_MASK) == GFP_MOVABLE_MASK);
+	BUILD_BUG_ON((1UL << GFP_MOVABLE_SHIFT) != ___GFP_MOVABLE);
+	BUILD_BUG_ON((___GFP_MOVABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_MOVABLE);
+	BUILD_BUG_ON((___GFP_RECLAIMABLE >> GFP_MOVABLE_SHIFT) != MIGRATE_RECLAIMABLE);
+	BUILD_BUG_ON(((___GFP_MOVABLE | ___GFP_RECLAIMABLE) >>
+		      GFP_MOVABLE_SHIFT) != MIGRATE_HIGHATOMIC);
+
+	if (unlikely(page_group_by_mobility_disabled))
+		return MIGRATE_UNMOVABLE;
+
+	/* Group based on mobility */
+	return (__force unsigned long)(gfp_flags & GFP_MOVABLE_MASK) >> GFP_MOVABLE_SHIFT;
+}
+#undef GFP_MOVABLE_MASK
+#undef GFP_MOVABLE_SHIFT
+
+bool decay_pcp_high(struct zone *zone, struct per_cpu_pages *pcp);
+void drain_zone_pages(struct zone *zone, struct per_cpu_pages *pcp);
+void drain_all_pages(struct zone *zone);
+void drain_local_pages(struct zone *zone);
+
+void page_alloc_init_cpuhp(void);
 void page_alloc_sysctl_init(void);
 
 #endif /* __MM_PAGE_ALLOC_H */
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 7b93fbf9af092..3b5cb1031f720 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -30,6 +30,7 @@
 #include <linux/sched/isolation.h>
 
 #include "internal.h"
+#include "page_alloc.h"
 
 #ifdef CONFIG_PROC_FS
 #ifdef CONFIG_NUMA

-- 
2.54.0

