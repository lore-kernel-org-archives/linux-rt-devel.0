Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9DF3A254A
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122508; cv=none; b=lrkzMKscG7PE6VkUqvymm5BFARI6A4K8sNGD9nTYye0ZwreJevpE1lc/aDTV3D8ciH5xnoMnKnzjnfD1ZBNNJsT9HzjOc+nUNn3+KQBxZWFpgjcrHnPzDrjCF4pqDoW+Ye7/pO8KlJHIagx03Mj9LKmF72+jFYWFn9hktZCWr/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122508; c=relaxed/simple;
	bh=kv7GTwDm/5n35EceFdwQWo0vB+5W6ET2TxIaDEmzekc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I1a8C4zpl10X9Rkh0iTViD6v7zH1HbVOgwOrNV5l3tJus78cQSo0WgGAOhbjLwaO6TXLqBqC4NXREdQ2xN1TF6BY9zDFE5naOa+QjXqmyPvI81JACiHj/irK6Dj8NgzzLPDpqkOEvdF6LP7M4IgnQbe4BJYNlVObBWOXcotUn5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aEovy7Xk; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEovy7Xk"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c0774fb9eddso305106966b.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122504; x=1782727304; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u1/cP6vHwWuZGO/mgc7SKKRNMY8A0RgkRxhrS8s00BQ=;
        b=aEovy7XkxO7UyJ2cS9MzUKgisSAg8NV3TiHymla6bu/4AUW/LaJU7c5x7bbYFSVDXT
         WiRmWllg8Pi9vsfAES7tUr9cenLtGBiDcMEOGqGjXmHQE3oZ0dBvSUYpq5d8GFbWXDOu
         i9/BeBJwpOafTDIw+hILNmFGCI8crRE8F+nPgwyx9FNXTXN1PSM3su/mIuPuoW8JeiLL
         rej1F0PLw4BslTbLanoJi9Fkw2ijGj/5I9mhDFoXejFnMXDcyTvtfWTvn29j7tPJak6O
         yeoLW7M6KBd51MdLE6vI9tU2JBg22xVIX8O96z3z2Q1Z5j8bczoBO5PZBYM8JSCaa8Fr
         f+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122504; x=1782727304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u1/cP6vHwWuZGO/mgc7SKKRNMY8A0RgkRxhrS8s00BQ=;
        b=HgL2qQq6PQL4IGobmxz5Wrwy1lHTDILO/72TxIhI32tYzsJQF2vOv0BH5pFAovddUH
         SUvtxCATj5FgWtaJGnnDoAeb52qMn6z0nBYNf0Tnd/+/LA0LT7v0VBTYDgekszzYFZ4P
         8WBj2GQu6EUFzudroaWJXWUx4DjrWiFEPUNkMqlRNk4FzB5Nec6Rk7nJHpvk6hMW7qsP
         HqXcG4oA2aIrmb22DQHUcvEVuhX/to39UkvOMX1a6gCgyJLUp6dVp6Vp0hmQuYgUqQdx
         WQBpC1ECGorcCBgIsHvS/q4WUZXOmid0NAvoJ2Fw3Xc4UsX7LcLyCoBz02lY+6ibgHy/
         uANg==
X-Forwarded-Encrypted: i=1; AFNElJ+GaGSDc1Y4wAiFfLBaELXWeJu82rNL+CI9sFcx1gH/FLLRM+jP2eyTWWzC6RwmSEYrs9+7gxJLuw7D3wKvJw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ6hMmeGCHtTKnMabbGk8/U2JU6Nc9PSyhI1MjJjQ5j6t4Zlg4
	hnHXA2yQtvLyATLR5hNCv0PQINllbHjDfYnCOqxYv7bKhOuLAyzt6Skj88EU7cRXp7iTWZwh5uI
	qbBmOaVAQ+WsSjw==
X-Received: from ejbyz10.prod.google.com ([2002:a17:906:dc4a:b0:c07:7108:ccd2])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c01c:b0:bee:bbaa:f19d with SMTP id a640c23a62f3a-c0b61132b41mr553875566b.14.1782122503188;
 Mon, 22 Jun 2026 03:01:43 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:29 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-2-31f31367d420@google.com>
Subject: [PATCH v2 02/13] mm/page_alloc: some renames to clarify alloc_flags scopes
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

It's pretty confusing that:

- The slowpath and fastpath have a totally distinct set of alloc_flags.

- gfp_to_alloc_flags() sounds generic but it only influences the
  slowpath.

- prepare_alloc_pages() is generic in that it sets up the
  alloc_context, but the alloc_flags it generates are only used for the
  fastpath.

Rename some variables to highlight which alloc_flags are
fastpath-specific. Rename gfp_to_alloc_flags() to highlight that it's
slowpath-specific.

gfp_to_alloc_flags_cma()'s current name is actually fine, but rename it
anyway, just for consistency.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6c4eb6908bd95..bc05d75a41627 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3771,8 +3771,8 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 }
 
 /* Must be called after current_gfp_context() which can change gfp_mask */
-static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
-						  unsigned int alloc_flags)
+static inline unsigned int cma_alloc_flags(gfp_t gfp_mask,
+					   unsigned int alloc_flags)
 {
 #ifdef CONFIG_CMA
 	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
@@ -4471,7 +4471,7 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 }
 
 static inline unsigned int
-gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
+slowpath_alloc_flags(gfp_t gfp_mask, unsigned int order)
 {
 	unsigned int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
 
@@ -4508,7 +4508,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 	} else if (unlikely(rt_or_dl_task(current)) && in_task())
 		alloc_flags |= ALLOC_MIN_RESERVE;
 
-	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
+	alloc_flags = cma_alloc_flags(gfp_mask, alloc_flags);
 
 	if (defrag_mode)
 		alloc_flags |= ALLOC_NOFRAGMENT;
@@ -4774,7 +4774,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * kswapd needs to be woken up, and to avoid the cost of setting up
 	 * alloc_flags precisely. So we do that now.
 	 */
-	alloc_flags = gfp_to_alloc_flags(gfp_mask, order);
+	alloc_flags = slowpath_alloc_flags(gfp_mask, order);
 
 	/*
 	 * We need to recalculate the starting point for the zonelist iterator
@@ -4815,7 +4815,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
 	if (reserve_flags)
-		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags) |
+		alloc_flags = cma_alloc_flags(gfp_mask, reserve_flags) |
 					  (alloc_flags & ALLOC_KSWAPD);
 
 	/*
@@ -5017,7 +5017,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 		int preferred_nid, nodemask_t *nodemask,
 		struct alloc_context *ac, gfp_t *alloc_gfp,
-		unsigned int *alloc_flags)
+		unsigned int *fastpath_alloc_flags)
 {
 	ac->highest_zoneidx = gfp_zone(gfp_mask);
 	ac->zonelist = node_zonelist(preferred_nid, gfp_mask);
@@ -5033,7 +5033,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 		if (in_task() && !ac->nodemask)
 			ac->nodemask = &cpuset_current_mems_allowed;
 		else
-			*alloc_flags |= ALLOC_CPUSET;
+			*fastpath_alloc_flags |= ALLOC_CPUSET;
 	}
 
 	might_alloc(gfp_mask);
@@ -5042,11 +5042,11 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 	 * Don't invoke should_fail logic, since it may call
 	 * get_random_u32() and printk() which need to spin_lock.
 	 */
-	if (!(*alloc_flags & ALLOC_NOLOCK) &&
+	if (!(*fastpath_alloc_flags & ALLOC_NOLOCK) &&
 	    should_fail_alloc_page(gfp_mask, order))
 		return false;
 
-	*alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);
+	*fastpath_alloc_flags = cma_alloc_flags(gfp_mask, *fastpath_alloc_flags);
 
 	/* Dirty zone balancing only done in the fast path */
 	ac->spread_dirty_pages = (gfp_mask & __GFP_WRITE);
@@ -5260,7 +5260,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 		int preferred_nid, nodemask_t *nodemask)
 {
 	struct page *page;
-	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned int fastpath_alloc_flags = ALLOC_WMARK_LOW;
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
 
@@ -5282,17 +5282,17 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	gfp = current_gfp_context(gfp);
 	alloc_gfp = gfp;
 	if (!prepare_alloc_pages(gfp, order, preferred_nid, nodemask, &ac,
-			&alloc_gfp, &alloc_flags))
+			&alloc_gfp, &fastpath_alloc_flags))
 		return NULL;
 
 	/*
 	 * Forbid the first pass from falling back to types that fragment
 	 * memory until all local zones are considered.
 	 */
-	alloc_flags |= alloc_flags_nofragment(zonelist_zone(ac.preferred_zoneref), gfp);
+	fastpath_alloc_flags |= alloc_flags_nofragment(zonelist_zone(ac.preferred_zoneref), gfp);
 
 	/* First allocation attempt */
-	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
+	page = get_page_from_freelist(alloc_gfp, order, fastpath_alloc_flags, &ac);
 	if (likely(page))
 		goto out;
 

-- 
2.54.0

