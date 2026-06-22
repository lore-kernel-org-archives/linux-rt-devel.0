Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FAA364042
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122524; cv=none; b=iatJTjg1rBUsKdSQywS5tUWtH6khbDCp6pp4TXlo1xmvTXVTn/ROAk2FHPOha3c6748Glg3xaB8V0k22A6zNMWEHKzmR1s0gObZ5QeY9bCsIgJiw7zh5HuV5/tJLGoKReQpD0Ul0kkFa41gz0N+oUH81GTBKDZXF5HcJhRl3z94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122524; c=relaxed/simple;
	bh=zbY9/RiRicFkbP/jenbYraBRONOcJZ2kJaWAeqyJJ38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WuWp636Wm3m0o5SMfl2PxQcazTXFpp4GvFzQHvOOALYhwMp59K/PaJtKqiH5rj1wjnijxzSEEpWifwGBy/CsNzNopyEmgX9GLwgQvLx7+nUMnVNSJmEH49bW6rYUuQbz6ge4B5s1iyD5bQjrQpNMjvxzzf5hcLo48Beb2mkyxGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gTYRtx56; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gTYRtx56"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4924314568cso25001715e9.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122518; x=1782727318; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MsOFaY28yUvKoPbHZxbuYx2M7iMWmO856P7+eBzy0OY=;
        b=gTYRtx56iNfiKkVgpuratjxkGON4Ka36ldaLTFkhNvZNsC+Hjm5Z3ZS1ZNMU5YrZKi
         u2CW0f53/4tfu+zJhn+9/t7ojxskrHX2qriVyKL1tgHLldmdV0IU+/FvpnqK2o9qNjru
         oYE/3EG6a5sZry8LBucnRllydDSEzNqfrhX9y/5kPNXb3due/vt0GXEnZjUawXvMzyvq
         tdTogb/YgLUGTD08Ygtw9PI22/BKwKawjx9TMufS+F5hu9Yy14KR3YRdfmQ8mom1LCB1
         08GulzEFHw5D7hgBhEEJlKKdpnq1gyhnMYl15hOHRLRPcI1joVQahlhCCbN5SCUr/czF
         i7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122518; x=1782727318;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MsOFaY28yUvKoPbHZxbuYx2M7iMWmO856P7+eBzy0OY=;
        b=K9X+7GsUBvJTCp2mRPDRoNII1K2zjmwWnhXb/H1enqM2GGsCEpSnO4ieDzSaHWtTkp
         uEAI0CFmqUlgqa6w7bP6RtGmJjK6aqxkSawuZabQmWs/OCUNQroSYU81tHvqAuTNQFll
         nB4dx3JS61ch5GaGbxmRpHTO/afa7H+Tap20YnkLXPrAX6d9jlFPQiOi4osaci3H5vRL
         2ImYvumVvbCs4sP0KT/iZs2Jf6R1XTu1m6sLJibdXyFRBk0FbhuZzsvn9LkyiTgr+Gs4
         5+1HZwEmFRT/oQcpw7hj1efMIeZASodPr2egDzCGoninF+QRhfispXC9iCkya+qJoPWQ
         ri9A==
X-Forwarded-Encrypted: i=1; AFNElJ+yXL0quOgnfq+xsY47jzbGP/QMT0ScFZJgg0StCHLUSjm74lBMOAb8zlAT9E5KVCh2rBFZw/o7SaThDtkfBQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQXqbs97slrGJaUOGr09plSqeRQ5hi5BQ7RyXlyjABNFQSKicm
	byPwiSlosyQGSsvfbH+mDtCh1LFFKjsd5O2IfP6kSQQ5Uo+/ZjfwJnA1omu4GJffK4vz8Fd/WkT
	DRAGk9Eck2ypbog==
X-Received: from wmjk5.prod.google.com ([2002:a7b:c305:0:b0:490:dc44:9b3d])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c088:b0:490:4ee0:82ff with SMTP id 5b1f17b1804b1-4923f58896emr216559755e9.27.1782122517852;
 Mon, 22 Jun 2026 03:01:57 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:39 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-12-31f31367d420@google.com>
Subject: [PATCH v2 12/13] mm: Move __alloc_pages() to mm/internal.h
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

It's no longer used outside of mm/.

Since this means __alloc_pages_noprof() is no longer visible from gfp.h,
this also means moving the definition of alloc_pages_node_noprof into
the .c file.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/admin-guide/cgroup-v1/cpusets.rst |  2 +-
 Documentation/admin-guide/mm/transhuge.rst      |  2 +-
 include/linux/gfp.h                             | 16 +---------------
 mm/internal.h                                   |  4 ++++
 mm/page_alloc.c                                 | 11 +++++++++++
 5 files changed, 18 insertions(+), 17 deletions(-)

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
index 7edcc2e0be9ce..9656a62138917 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -226,10 +226,6 @@ static inline void arch_free_page(struct page *page, int order) { }
 static inline void arch_alloc_page(struct page *page, int order) { }
 #endif
 
-struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
-		nodemask_t *nodemask);
-#define __alloc_pages(...)			alloc_hooks(__alloc_pages_noprof(__VA_ARGS__))
-
 struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask);
 #define __folio_alloc(...)			alloc_hooks(__folio_alloc_noprof(__VA_ARGS__))
@@ -294,17 +290,7 @@ struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
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
 
diff --git a/mm/internal.h b/mm/internal.h
index 6bc89ec62e527..0847b55bfc147 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1955,4 +1955,8 @@ static inline int get_sysctl_max_map_count(void)
 bool may_expand_vm(struct mm_struct *mm, const vma_flags_t *vma_flags,
 		   unsigned long npages);
 
+struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
+		nodemask_t *nodemask);
+#define __alloc_pages(...)			alloc_hooks(__alloc_pages_noprof(__VA_ARGS__))
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 074e007bf1bc3..d99e4ea8307ea 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5410,6 +5410,17 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
 }
 EXPORT_SYMBOL(__alloc_pages_noprof);
 
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
+
 struct folio *__folio_alloc_noprof(gfp_t gfp, unsigned int order, int preferred_nid,
 		nodemask_t *nodemask)
 {

-- 
2.54.0

