Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF164CA28B
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985798; cv=none; b=PIEjaiiC0QcYqhvvm0Vr9toL7nhQnFEjjH9uJYiFl+3/g19efAV2mVNe1zzhsAQga6egtuvRjn8aMX11GlzwXNoY+UR6HnlvD20YVLofzm9kiEUGeV4+s5a213nPp+v0K7VTM1fUyh6eipKAalVClk9fpieylrZW/dgOeO+LYVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985798; c=relaxed/simple;
	bh=EAqViwusgRTi6rLOc2U+A6N+6KHjf2l3Cyf0mwTMYBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FBq+3Ks1reWwteq/Qau74TA6WnsmOW9HjfTsaZO6s2pcFBgSiG8iffYNKZzTI/hlwnxBOOPpYDFn1ixTAGcJwsAGUVqkOl0RfHNAkHal24cwkdyqqDWAh4id39PqcvlSUU3P+XQ1f3yFnG/5MTO0gtPmiBha/V4RwJrLQnK8Sl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLaFNFs+; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLaFNFs+"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-493c20d0468so22800035e9.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985795; x=1783590595; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iEqy9OiYUm+VnjUsJ3u1JVAY+AlpaBr9qaiRjmcKytg=;
        b=wLaFNFs+rXpyW7YFN+VKQ9k7Q2RgUr/0MXo7xqFS7qgQOhXF8hzkV/loF1U/TJDOzf
         bm/uEQTGoYNVKz0NjqboIpAQfUoKpxjmR3hTGHxTmxKlT39c+h38ON0SNnr7aDKdC9z1
         rYh0CygSwDouBjm9bKicem0mEMQZQulZGtMnYwI7UI8aS64I/nC++pDaaS8Pb97KQq8K
         p0qzwzAx9HZCeYKITO2F8b0J1Ri3neJNa9q2z8QKci1pcgtmqd1IEg3T8mSR+bSa1SLF
         /RHKBsuTxryVBCXTtgO4iaJzyz8tdW4CM8zbdr8DhTBZG9tYLNhG9JPgKc0OLYT+HagB
         wKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985795; x=1783590595;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEqy9OiYUm+VnjUsJ3u1JVAY+AlpaBr9qaiRjmcKytg=;
        b=VTuTAUyDeMJdaK8dliI138Ydi74sXDQy9Viqp9ZZAbmuEgbxRytRVfg2QnQcbG7QRn
         VBTDHIU/i432EghEpx4MjWZ5v+O3PTVad+DZCm0dgFi+b/Bl3w4btwkF16K8YEOxUiew
         sHkHaq/37baPOoAtQj7UarhvLMx/tp5S1IB/d3ux6WbW6yktqTq8v5BTJdOe+UL0gWcF
         AryS50uItMHnF/74qru6PVNUn8PSyBxWYvbEnTkhDdXzZZKKoXuzJzv5LXMMDGGzAlAn
         dHKU6IfI9vW8NNp2404iIgaSLHxjeQ4YP4FDyQzt02oX3qQu/3P7YYvqpShcmMZYuWUH
         w/9w==
X-Forwarded-Encrypted: i=1; AFNElJ9n+rKLM/lsF+0dd1nGqV0jK0LdYQQMAeCHh8tfNd6BD7CfI5V5eoj0AvFYIRaSKzC5TWgVN7rfHlKB/AKZXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxIafo925y2hjCXKe91t5MiKbZboDuBNjPq8SMJdXR7RQCO4Etb
	KeV9hVkT1Re8AMyh44P04Y/SoTVQKXuTN35oreJt/p4J/VMut+/3b7ds13ARRPlvmGwKaiCEBdN
	73dPawwF7kU8zoA==
X-Received: from wmg3.prod.google.com ([2002:a05:600c:22c3:b0:492:4659:9cd8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:70a:b0:493:b967:178d with SMTP id 5b1f17b1804b1-493c3ceb426mr42271475e9.19.1782985795274;
 Thu, 02 Jul 2026 02:49:55 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:38 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-7-0af8ff387e80@google.com>
Subject: [PATCH v4 07/18] mm: move some stuff to mm/page_alloc.h
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
	derkling@google.com, reijiw@google.com, Brendan Jackman <jackmanb@google.com>, 
	Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"

Some of this stuff in the public header is only used internally so
shrink the scope to avoid silently growing new users.

drain_local_pages() is still used from kernel/power/snapshot.c so that
needs to stay behind.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
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
index a4f4b325381ad..6bb50bae3ba27 100644
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

