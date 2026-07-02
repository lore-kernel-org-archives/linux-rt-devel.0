Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C044D990E
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985808; cv=none; b=RwgGIP7dBpqyfw3bp8IrQr75uUEKIWHp3Us2FGm+5qr2g7ejjOBd1zZBIx/25eEnk3vVwhZg3n4W4k0tE2Y+OQBQ1qMC1KALaVnXyO2hl4CTJTi1zFdxyuSnF7t8bH7O4bWwbSTfFXa8H3cve3/gx2j0CD6sPMuDYO4NtDDqSx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985808; c=relaxed/simple;
	bh=9FZJ7ctqu+8grALLfi8ALwSvdEWZD0RYxqdrbmDc6SQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fWfilcZx5l07qEpStDHU29ojoEkdJvFcxbBc4oYHzKEemIm1llrT6dMYXs8XDeN2Sext14q/+uUTnniwFoLx+EzgWDgEZQNmyDoYxACcp7f2Tq0yL4aHKaS7uGXQs9iDwi2+kCBXLQWmL2djZawRj8CbmcJliWtU7jgNtI3AQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZdFBTeVQ; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZdFBTeVQ"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-473941177b0so1385185f8f.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985805; x=1783590605; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAGFlYIEzSDpABnSzt62AXszlNoucsxh0ENbtnSNk8s=;
        b=ZdFBTeVQJ/s0++V9VEQqxgMgWl4Qlfxrg4s3bAs6M8eKyryeFody07kNqUhRTWlXAV
         5XUTnzbOb97xFrNv7oxjhS2d7dlCoFPn/HPp7Zgi90Jg0lwSNyRmt2pOITCF65EvFVNd
         JEu8wkSRrMT1ZrhI9Fjrx5VfgEOIDvT4XMFIa88fvWRwXiLo5zghe6ETis6JZkFdAIR1
         sZqpcHl5EmYj1Hk5TJ1iA8uWO5mzGINnkYVKI+7aUlLfsEjYcsgkzcw1MLtNgsLLObj3
         Em134yFgA7AMCSzvGg+Q7ocBlchxutqhn0B1uQvjAgKCsOCJeR+sXQAmC5TrZsGIrUrX
         afTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985805; x=1783590605;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAGFlYIEzSDpABnSzt62AXszlNoucsxh0ENbtnSNk8s=;
        b=DHsNjjPwatemeviiP0RVLx4LbPZQ69bCnbcwBiMjZI3U6iHXOZVYkhbgvkpWV3qYlZ
         eeRZWg3xAuoaSqLUlV/AloSu37wqS3TRfA/FXObmkO6QIiho78Td5p9OKF5PTt2GSud/
         Yd2Gu9ep4CnJ2F7Agp/G/Ji8WArvoAuovkDmoVP4aoPKjVReVL+kwYY4l4lvG15KOfpC
         5T5MOe1Quiwvdd3RuvFfOAl1+QyEZcXDVJx56k9gg3BWYtcQvfvb/7uaLS6MEfi+SF6x
         xhf2xVG62pJXHO9bRCg8D3759fCATfrnMCLhuxdn0Pt5PKfY91JS9Oknv78Q6xEObPp5
         /QQw==
X-Forwarded-Encrypted: i=1; AHgh+RrV+u8BRVkn9RermBjDvqUIlsA9ENztGS4G4BYE/8ZgI5x7uuTOk2Ffz/sBs7onKonONzT6gXlYhnsraJzzVg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy1DDOUzzPWHcUkmv55bOEK1KRmGa0uB/DblsUjdorV/j1o53hr
	V1GXn8BQ0wttD8mucSZ9Th+wiTuzd8Y/QLEvVq4wSplmPbvKGNEQmNqExceGYwyY9bY6NH1cvnb
	934dBk1hnvN/WRg==
X-Received: from wrbfl3.prod.google.com ([2002:a05:6000:29c3:b0:475:d5de:4af6])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e195:0:b0:460:64e8:2553 with SMTP id ffacd0b85a97d-47757e57472mr7853816f8f.4.1782985804592;
 Thu, 02 Jul 2026 02:50:04 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:45 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-14-0af8ff387e80@google.com>
Subject: [PATCH v4 14/18] mm: Move __alloc_pages() to mm/page_alloc.h
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

It's no longer used outside of mm/.

Since this means __alloc_pages_noprof() is no longer visible from gfp.h,
this also means moving the definition of alloc_pages_node_noprof into
the .c file.

Also remove references to this API from the documentation tree -
referring to the specific function name was already questionable but
now the function is not even public it definitely seems wrong.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/admin-guide/cgroup-v1/cpusets.rst |  2 +-
 Documentation/admin-guide/mm/transhuge.rst      |  2 +-
 include/linux/gfp.h                             | 16 +---------------
 mm/page_alloc.c                                 | 13 ++++++++++++-
 mm/page_alloc.h                                 |  4 ++++
 5 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/cpusets.rst b/Documentation/admin-guide/cgroup-v1/cpusets.rst
index c7909e5ac1361..52a213aff04e5 100644
--- a/Documentation/admin-guide/cgroup-v1/cpusets.rst
+++ b/Documentation/admin-guide/cgroup-v1/cpusets.rst
@@ -284,7 +284,7 @@ take action.
 ==>
     Unless this feature is enabled by writing "1" to the special file
     /dev/cpuset/memory_pressure_enabled, the hook in the rebalance
-    code of __alloc_pages() for this metric reduces to simply noticing
+    code of the page allocator for this metric reduces to simply noticing
     that the cpuset_memory_pressure_enabled flag is zero.  So only
     systems that enable this feature will compute the metric.
 
diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
index 23f8d13c2629d..16f37135ed80d 100644
--- a/Documentation/admin-guide/mm/transhuge.rst
+++ b/Documentation/admin-guide/mm/transhuge.rst
@@ -761,7 +761,7 @@ compact_fail
 	but failed.
 
 It is possible to establish how long the stalls were using the function
-tracer to record how long was spent in __alloc_pages() and
+tracer to record how long was spent in the page allocator and
 using the mm_page_alloc tracepoint to identify which allocations were
 for huge pages.
 
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 3bf55a5f9143e..4d57e9c0bf204 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -204,10 +204,6 @@ static inline void arch_free_page(struct page *page, int order) { }
 static inline void arch_alloc_page(struct page *page, int order) { }
 #endif
 
-struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
-		nodemask_t *nodemask);
-#define __alloc_pages(...)			alloc_hooks(__alloc_pages_noprof(__VA_ARGS__))
-
 struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask);
 #define __folio_alloc(...)			alloc_hooks(__folio_alloc_noprof(__VA_ARGS__))
@@ -272,17 +268,7 @@ struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
  * prefer the current CPU's closest node. Otherwise node must be valid and
  * online.
  */
-static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
-						   unsigned int order)
-{
-	if (nid == NUMA_NO_NODE)
-		nid = numa_mem_id();
-
-	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
-	warn_if_node_offline(nid, gfp_mask);
-
-	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
-}
+struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order);
 
 #define  alloc_pages_node(...)			alloc_hooks(alloc_pages_node_noprof(__VA_ARGS__))
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c2839959d7908..f68b2b138a2e8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5431,7 +5431,18 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
 		set_page_refcounted(page);
 	return page;
 }
-EXPORT_SYMBOL(__alloc_pages_noprof);
+
+struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order)
+{
+	if (nid == NUMA_NO_NODE)
+		nid = numa_mem_id();
+
+	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
+	warn_if_node_offline(nid, gfp_mask);
+
+	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
+}
+EXPORT_SYMBOL(alloc_pages_node_noprof);
 
 struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask)
diff --git a/mm/page_alloc.h b/mm/page_alloc.h
index 6bb50bae3ba27..3b8a4709b1497 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -244,6 +244,10 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 	alloc_hooks(alloc_frozen_pages_nolock_noprof(__VA_ARGS__))
 void free_frozen_pages_nolock(struct page *page, unsigned int order);
 
+struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
+		nodemask_t *nodemask);
+#define __alloc_pages(...)			alloc_hooks(__alloc_pages_noprof(__VA_ARGS__))
+
 extern void zone_pcp_reset(struct zone *zone);
 extern void zone_pcp_disable(struct zone *zone);
 extern void zone_pcp_enable(struct zone *zone);

-- 
2.54.0

