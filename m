Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606973D333D
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081963; cv=none; b=eR8fHON7Adseek1ajFU8JIocpUrSr3tIRnII9s21yahfSIkegGGB6MSMsb/7eN3Nypnf4GkGl7B2f2zfMJ77B6LB2bIRMNj06jntQ26t68diN4cWXseBHsX0UXynUZPPockcFrh5G3h49YcpqCBlAHBPhPJ4IuVFa5JhdO8pT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081963; c=relaxed/simple;
	bh=WYRAiNqfuhhWu100CnX8SSdMrI632TiSlNqqVOt1euE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tNRraV5rk1Z3kqMrszBqmKdAlLlBlME6UlbhOtezJNr4zk3Js7nP/qJmUxdpbgRucBPnk0bBN/0uXs4poy8hCZFDn2IDL7W7jxfInxWUuPeG8PY7hsn8CRgJyQZnrYPEcSM1kDwp7RWLBLVB8dEbOJLyCrms1wsi+AFcR+qAPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mYaalpJc; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mYaalpJc"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-47248bd8bc0so512173f8f.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081957; x=1783686757; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1tnwOMpS/BIg5QL0SfFSSGMbCh9S3UbjX7wTwpmbKGs=;
        b=mYaalpJc+Cq5DSn+MIqOemRbsv+bD1bsptaSZe8mBR3GEfibzH1tL9fB42FTgtXQ7V
         R5zErrkB17yBzMRmacy/MbYkJiqo4icvd6J9m9g6eX3flh1Lmhz8YP6KB4DAznIyu+S4
         x55e/a2rJcnSLbNPoK/11kwjl33v7aQ0gTzIZRUEKY/5fmaR5iVNsyDOUfXO/zvJJ3+d
         qLbIFjme5oVywpXrqCUiBaAqKmvHZFugfNPdTAo8TRc0iCHODXoFqal/xcWRrP/32JEo
         NwONfklP6YeipEMhRJYEh4xM2QI7sLAFxOEztk8GviF1aQRwaXXHKihk1FECEkaCWzh0
         KiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081957; x=1783686757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tnwOMpS/BIg5QL0SfFSSGMbCh9S3UbjX7wTwpmbKGs=;
        b=LQ6p7387emwjAOxTsnyUF8vrWXy2oQcMrF0JlJzprINxYipLoV2Alsnh5lna2J1WH+
         U5AYeTti4miFHom95nPD+Mt7UNpiyQodniKRnj6YVEM2QZTf/metDYIc3RZVPB7V6tZH
         g95Vg9zZosPCynPLa9TuAFcuZGOUPEq5tsaAZ+C9gSkxT9MYhvry2wy67qS/1IOE254D
         7zhudmqG0NTw0VZ0D6ZCTUzH12l6fZQNMH4QJFD0hJqfB9ufuoCEK5E+e3kF4cK5lgkb
         bbkILTEZTl5JopcgScLiNsjvdgTumkgnraVQI6f7X5/V8g6psTEqY1dlOz/eJtJq43dq
         P5ag==
X-Forwarded-Encrypted: i=1; AFNElJ+hmHOH2aczQ+kD8d4m56ZnUcBSSvL/Nga39ZCCFuY9aSpceHV0PKTYlsV080oQN6YrqggSWgv3ySPn4VIhLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyHJ1SAIeoLiKQR/mFsz83yGI0tICn3OrsLwsVDaPT0SYlCJQNg
	+PdKtlkD/A565uC8i3A+muzgrW7lZsdAY0B8IPD5kYWl+yUFMnaLf732NSlGjClcCWUxrZONiWX
	zIvsit2EekyjI7g==
X-Received: from wrhm3.prod.google.com ([2002:a05:6000:1803:b0:46d:6fd3:e5e9])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34c8:b0:493:c2e3:b2c1 with SMTP id 5b1f17b1804b1-493c3df75ebmr139076715e9.33.1783081957147;
 Fri, 03 Jul 2026 05:32:37 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:54 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-14-c87b714e19d3@google.com>
Subject: [PATCH v5 14/18] mm: Move __alloc_pages() to mm/page_alloc.h
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
index 2d60551b4453f..aa0c1481f7ca3 100644
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

