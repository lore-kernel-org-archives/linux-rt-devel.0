Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E5D3D349F
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081955; cv=none; b=TvrCHGlmsszVbR5+n2UYV5tU1/tcCWIBWsohDH3fx8CbwidJSrAqJI7dNj9rggCNYfWPp0DTDBmZJ2Ih0Ed4pPsiOzCeq5ZClqx/gf+btInlqwmjgMFum5XpmqpSQslg3CXa51MYvh7qEV1SsJfx9YzCn/da+zi0PBj7/5eZ5nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081955; c=relaxed/simple;
	bh=22vkACm3zMTGwjU3/Ko9sIv39tcaXETpTXXq3Ombx3E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q0K3ofOn85KXkVCx+JJcbW8SkLeV/3Xipq6MqU91FV2JwHK0FbAkrX35DJUFy0xkekFxskNIOImBdYqmPM2nWxCmM8yhHNOyTfo7ZVHIl8/eL/YaZaXNnoVssOoHVGga2vBvreXaX5+Pec7bwzg2Ra4qH+Dn5vxge89q+ziJnS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A7GBaFU8; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A7GBaFU8"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c12690ff1fbso39539866b.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081948; x=1783686748; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kjqMpiMEIhi+v1xNPECWvli3AP0POG8k3VRaLZYrcmk=;
        b=A7GBaFU8v+Kh6/peb4sssaETsWnuOW4YXkFzPn/yqm1xiWApd9m3Fq6kvEk1AWdbfh
         Ak/JlTRmJ7KV+UsBzph0fOyXOPa6AcCm5W8FgTeJtooG4aSqFUm1xCqjok7vhbPdp5lx
         gRC95+Ixh7mqXkfb+05xEY+RSftBr+570x3MgYVUoGM7f33LQGS3KyTh8N35VLOvUFAL
         DyudZ80Y6CzQ4CVTRcOy8FUZsPshhNTQRDx3NgJwWB4b1vKIu4y+h3UU2i1LezlNvs5R
         S+7k5STaREfSXQxx7kSMV/VoFDDtYaQDk1RsBhExhe0QtJGR6bXfkxdWjKx+Z5Ricy3z
         f57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081948; x=1783686748;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjqMpiMEIhi+v1xNPECWvli3AP0POG8k3VRaLZYrcmk=;
        b=dJ+G8zM5goeGGukjDIXv84OK/XUPChkHwTgMf7RoUVVxgB+vp6JDVV9eEmGW7fAXHM
         eETQo8jtEVQ89iqrx2b31n9bJJV64qdvkLe59RuZTDcnA0bEQFm+Smhou80MvqKlBDfI
         pVAWrxrofp5WkmzkwMHHNb5za6HMkM1vWosBaCAQFBOq2Ea09qoHiuqPM24EmYeop2Fi
         wawbOAm1e0Q5ckztcRN7c2KjL/yKvz1YOXhX/qxnpm4+8+rtziJIw3CqqlsmkoijaEli
         XEwKdPfMyMdNuJPP8nELzaREpETvjMsIskJLYAi77t6kiHKmJ6FhZCrPNbwGSdc8eaYy
         C6PQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp0abWiD3JuHGClPLuUtErHzQUy4L/ZQ15K5KBVHwt2EbDWzVGx39GsJxyhltRAPlUWbqlHmAqWL7E8Kiydmw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxJPcai8EPMsE4973afMa1kIwnuljZWiUhkuflMaK91Ckbo/3rA
	Fs/OnCCFzsl36L8GpMBgEstKaYlejsp8f0RAJJHan5D3b/Z9OARCeJm1xAVhkPLFSUxjGXD5SLv
	q+dNx5m+J3s0E7w==
X-Received: from ejdj17.prod.google.com ([2002:a17:906:951:b0:c12:8a76:87bc])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:261a:b0:c11:f4d6:48fc with SMTP id a640c23a62f3a-c12aa336682mr327263566b.45.1783081947831;
 Fri, 03 Jul 2026 05:32:27 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:47 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-7-c87b714e19d3@google.com>
Subject: [PATCH v5 07/18] mm: move some stuff to mm/page_alloc.h
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
 mm/page_alloc.h     | 27 +++++++++++++++++++++++++++
 mm/vmstat.c         |  1 +
 3 files changed, 28 insertions(+), 26 deletions(-)

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
index a4f4b325381ad..2d60551b4453f 100644
--- a/mm/page_alloc.h
+++ b/mm/page_alloc.h
@@ -266,6 +266,33 @@ static inline bool free_area_empty(struct free_area *area, int migratetype)
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

