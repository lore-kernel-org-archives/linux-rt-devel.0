Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC42D40680A
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738757; cv=none; b=L2xTExyey2+/mwT1KicnoaBPP3Dvs2lbeNGvOuP8moC3q9n1lkzgOUal7Z5Z5/PORtJDCoWUsCRIJXmzBvSqpnW3DSk5gAlK0+MEuHG13vNNR2RJyZcV1ykyNSCkha8nsqXV0XKs5VmpZ6wSSeKL7g8SHglwwnSOZyC0zj/PBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738757; c=relaxed/simple;
	bh=Jd2xpnNcJCnVWO1WugDN2P0A+uNMGdLLZh7SbcJRwhU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rHXj1BEpSbu8UCTBLf+p9JqEhLH/M/USLkk4McmxX5ZzWyXnQVA7OQNqDYRP4I1VnbOqhp6HcL2Ece19EFLwLlrML2XvXVnVsRGc66v5E6FmuSEpGnnAVwKOIu6TQTdpprF1lxLovd5GxJM2i6OcthH1wrCtTi1SvA5tqK0TXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jI4CZ6E3; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jI4CZ6E3"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c1265eb65e9so108840266b.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738754; x=1783343554; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBAu5z1qpXLt1yVYTZOb/NZ4VE3m9FIqmIALTgVK9u0=;
        b=jI4CZ6E3cX2jI96wADeltpvWxZZiuLnFEt07NcQdrKRPs9ZdTRHsQmV/qVb1U41xKf
         QpQv6745ajWoFV4kpEguB4LHvvWHohS9M3avMacJKMTNZJ9vE4KjrVWSv99u0Td1tztm
         Xt+NdIltybsbP0wff7QZYtL7sIqQFUoXMU6ccfk6T3YLnYC4mtp8SyAyOSVkcsCHnunA
         nvMCA5ISn96uXDlXbNqK+ZUiernvR7G8k4Lkq3YHNeeYJZMAiy9PMRzxcSJAQGxCxACD
         mqMlpMTYS5mrUImBiFZDEY6fic/vkM1q/vz9CnVJhskRmuG5DAR2CI+GOVkzE+GOT0K0
         Jfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738754; x=1783343554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBAu5z1qpXLt1yVYTZOb/NZ4VE3m9FIqmIALTgVK9u0=;
        b=FiBXZrYph1KRuJxUIfGiZl10EbsZ5SnYjKoW0eSEGNVTXVdBc5cpRY978fZXM15rZg
         NsiVhBatPDXKCfUTmRvKmWKB9l4HXVJVaqHXizy7wtTlh9uKdPCFEY4cuUDccX6h2wWE
         YEWzbmRjRJ4qZYX2czp3P76mUauvT+Hu7iNDdZn8EtwNiv8xRUlnDY3YZdOPI2MD2EM8
         8Jm9lFzPepYvL6kUu5cg9bvbfNHq4GGPZWs6UHNv/VCd47XYrQeLydR4g76RsKwv+T02
         TnvFXa9iv7MhQSVMkey9cJzse73xwa5vozdgkklMml1/zz0r3DeFoXQi3XWlX8/ZmdLp
         MA0g==
X-Forwarded-Encrypted: i=1; AHgh+Ro4F+HPD64KTtUamQ9ju8rS0kRCtejw34Iqb5DjMF9TxUBYmRBn+rnhpYg3H+bLD/iVl0rVPX+r8tK+5x7TYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoXyhobcVqBycSlKM3fQY8subvJP9zqJ1kUypLkct5YW8UOFpe
	JGlXvb0UsObokyapwKKQ9fnxl2X9QHyWkCODggXKuKBC6oMleEKQywJl9M+B3+kvmS/sg6hDRCp
	Ft4Oj2hu6mOcAGA==
X-Received: from ejdn16.prod.google.com ([2002:a17:906:1650:b0:c12:6c81:a8ab])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c00b:b0:c12:80f5:d841 with SMTP id a640c23a62f3a-c1280f5df41mr35865866b.56.1782738754134;
 Mon, 29 Jun 2026 06:12:34 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:12:03 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-14-57bef0eadbc2@google.com>
Subject: [PATCH v3 14/16] mm: Move __alloc_pages() to mm/page_alloc.h
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

It's no longer used outside of mm/.

Since this means __alloc_pages_noprof() is no longer visible from gfp.h,
this also means moving the definition of alloc_pages_node_noprof into
the .c file.

Also remove references to this API from the documentation tree -
referring to the specific function name was already questionable but
now the function is not even public it definitely seems wrong.

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
index 9cb3f1665b41b..026f33f217036 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5427,7 +5427,18 @@ struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
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
index af83764788b96..2058cbdca56e7 100644
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

