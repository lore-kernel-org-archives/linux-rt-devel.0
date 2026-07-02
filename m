Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77DF4C77CB
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985792; cv=none; b=ioRMJYpVzW1NIx4iU922wBW6qSzYeOCTeLdfq3aYTS16zo+h88SZTg213u/JLqanTIUGYELMqy+0Kl584YoHSJSmTVP2wfIPTNrmAjCMg7yCO8SEaT7OPZq7Ya0GRTIYE+16vFp5fKl9PnwfEVKs/QfTM41ZhVscc1W2NaEhJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985792; c=relaxed/simple;
	bh=Lu7MbaQVyOUf1SmaYcR+owPfW6FHQTPQJ53YEqaID2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oWhkmFq+aN7UeNlGzj/uuAKKKfbv8lWznsQlgTpNu9q6tf1rjvLy9Kpbbe+DHNgdgSuVA61vzPVtOE4tYpngMOHJ97OKKd8X0+ghqSwx/Ttl8mlS+CwZa87iFQeewhWRFF5aeUvi6A1t5zGA8OBvwBxIHprCDz+KqmZwx31+m2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jyCGqFlP; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jyCGqFlP"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-472c330e555so796379f8f.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985789; x=1783590589; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni+aRw2R4ZEwrhwGe4xokmUGFRvRoyUT7XfJ1uWOieo=;
        b=jyCGqFlPiR6LZ3XA5iPcs+CKwa5t5yvYP/aAYTemJe2b3RCQr7MDjs9P72ZOtm5xbz
         v1RmIQocE+zFNalY742v4YoWiIAsUmru6pkcJEOsGVIov0qsMS8rpAv6avKYh5jQ3Xw5
         dn5vqyoRqJehQbv6GlO4lgw+WeSq9BGsu5V8M5ORx79zKmaU4z5SAcS6kIxqpptyT5in
         QZCWh5Wv9EfHwvjllhJBMGZJGdOe22V8zyq/narQtfgqg/WaNT7dEQI7w6LZYMjdxYOZ
         Lohfduv0Ee27xf1uvmc5sYM7rB709iMcWgPuZnE+gKvA6C9dnVNTCNNznRqC0q2eYICw
         fnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985789; x=1783590589;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni+aRw2R4ZEwrhwGe4xokmUGFRvRoyUT7XfJ1uWOieo=;
        b=oZudUkTI+xGqqdoqKF7s55pNXYWpaHQok/PdxEFpeSWLsxX2fzinBhL6AgjFl0gbhO
         0vHErwc3/m01fKMdWToUWKu8vXYSjRbT6ojEG4tfx1wdqjDDjao23GXLN+10gA4b8KDm
         CYMeZCsE2WHyaga+WDJ7d+bvmssgkecOQHf1Q1erXiL0ns2xHjbMeJtCj6vAArfRTE/v
         CNXQnyaaL9YfhKesZ2aoZvcbYKJ5FJyTStxaLdL6coIvkJ7C9MfFhLm7hUdsQ//RS8n3
         4Rd1XheRXd0ru3aqbko4yw7F6YHJScpq9QUJ2oGSfd4waf22/xPH7DPCFkHHCORatOod
         a47Q==
X-Forwarded-Encrypted: i=1; AFNElJ/P7a5Jd29uB5E/+SOMl64jNRjyiTNpUGSTMSswdNlSUx4u8Xy9RVHisxrJRPto09ZKsZ4Ah0GO/kgvYYyYLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKcNX9I6t996PUeeXxdzoG7S14zO99kRql/TuOFSVWygAuAK5T
	la3OovCLKhfKbYFI0cUtBt2gSOjqfHD6ynRd5MHzfT2H6XIVtUiMJTpAPCbdDnmExv9o1ENpPfC
	J9kxB0C3ijxlPpw==
X-Received: from wmbe17.prod.google.com ([2002:a05:600c:5911:b0:493:b008:cbbb])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34d4:b0:493:a966:d5b5 with SMTP id 5b1f17b1804b1-493c2b3a709mr77658925e9.2.1782985789017;
 Thu, 02 Jul 2026 02:49:49 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:33 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-2-0af8ff387e80@google.com>
Subject: [PATCH v4 02/18] mm/page_alloc: some renames to clarify alloc_flags scopes
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
	Yosry Ahmed <yosry@kernel.org>, JP Kobryn <jp.kobryn@linux.dev>
Content-Type: text/plain; charset="utf-8"

It's pretty confusing that:

- The slowpath and fastpath have a totally distinct set of alloc_flags.

- gfp_to_alloc_flags() sounds generic but it only influences the
  slowpath.

Rename some variables to highlight which alloc_flags are
fastpath-specific. Rename gfp_to_alloc_flags() to highlight that it's
slowpath-specific.

gfp_to_alloc_flags_cma() and gfp_to_alloc_flags_nonblocking() currently
have perfectly harmless names, but to keep the naming consistent also
rename those to the alloc_flags_*() pattern (which already exists for
alloc_flags_nofragment()).

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Acked-by: JP Kobryn <jp.kobryn@linux.dev>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/skbuff.h |  2 +-
 mm/page_alloc.c        | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e8..4431b026e429d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3573,7 +3573,7 @@ static inline struct page *__dev_alloc_pages_noprof(gfp_t gfp_mask,
 	 * 3.  If requesting a order 0 page it will not be compound
 	 *     due to the check to see if order has a value in prep_new_page
 	 * 4.  __GFP_MEMALLOC is ignored if __GFP_NOMEMALLOC is set due to
-	 *     code in gfp_to_alloc_flags that should be enforcing this.
+	 *     code in alloc_flags_slowpath() that should be enforcing this.
 	 */
 	gfp_mask |= __GFP_COMP | __GFP_MEMALLOC;
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6004fe6583d47..df1345cde301f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3774,8 +3774,8 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 }
 
 /* Must be called after current_gfp_context() which can change gfp_mask */
-static inline unsigned int gfp_to_alloc_flags_cma(gfp_t gfp_mask,
-						  unsigned int alloc_flags)
+static inline unsigned int alloc_flags_cma(gfp_t gfp_mask,
+					   unsigned int alloc_flags)
 {
 #ifdef CONFIG_CMA
 	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
@@ -4474,7 +4474,7 @@ static void wake_all_kswapds(unsigned int order, gfp_t gfp_mask,
 }
 
 static inline unsigned int
-gfp_to_alloc_flags_nonblocking(gfp_t gfp_mask, unsigned int order)
+alloc_flags_nonblocking(gfp_t gfp_mask, unsigned int order)
 {
 	unsigned int alloc_flags = 0;
 
@@ -4497,7 +4497,7 @@ gfp_to_alloc_flags_nonblocking(gfp_t gfp_mask, unsigned int order)
 }
 
 static inline unsigned int
-gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
+alloc_flags_slowpath(gfp_t gfp_mask, unsigned int order)
 {
 	unsigned int alloc_flags = ALLOC_WMARK_MIN | ALLOC_CPUSET;
 
@@ -4512,7 +4512,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 	if (gfp_mask & __GFP_KSWAPD_RECLAIM)
 		alloc_flags |= ALLOC_KSWAPD;
 
-	alloc_flags |= gfp_to_alloc_flags_nonblocking(gfp_mask, order);
+	alloc_flags |= alloc_flags_nonblocking(gfp_mask, order);
 
 	if (!(gfp_mask & __GFP_DIRECT_RECLAIM)) {
 		/*
@@ -4525,7 +4525,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask, unsigned int order)
 	} else if (unlikely(rt_or_dl_task(current)) && in_task())
 		alloc_flags |= ALLOC_MIN_RESERVE;
 
-	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
+	alloc_flags = alloc_flags_cma(gfp_mask, alloc_flags);
 
 	if (defrag_mode)
 		alloc_flags |= ALLOC_NOFRAGMENT;
@@ -4791,7 +4791,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	 * kswapd needs to be woken up, and to avoid the cost of setting up
 	 * alloc_flags precisely. So we do that now.
 	 */
-	alloc_flags = gfp_to_alloc_flags(gfp_mask, order);
+	alloc_flags = alloc_flags_slowpath(gfp_mask, order);
 
 	/*
 	 * We need to recalculate the starting point for the zonelist iterator
@@ -4832,7 +4832,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
 	if (reserve_flags)
-		alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, reserve_flags) |
+		alloc_flags = alloc_flags_cma(gfp_mask, reserve_flags) |
 					  (alloc_flags & ALLOC_KSWAPD);
 
 	/*
@@ -5063,7 +5063,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 	    should_fail_alloc_page(gfp_mask, order))
 		return false;
 
-	*alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, *alloc_flags);
+	*alloc_flags = alloc_flags_cma(gfp_mask, *alloc_flags);
 
 	/* Dirty zone balancing only done in the fast path */
 	ac->spread_dirty_pages = (gfp_mask & __GFP_WRITE);
@@ -5277,7 +5277,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 		int preferred_nid, nodemask_t *nodemask)
 {
 	struct page *page;
-	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned int fastpath_alloc_flags = ALLOC_WMARK_LOW;
 	gfp_t alloc_gfp; /* The gfp_t that was actually used for allocation */
 	struct alloc_context ac = { };
 
@@ -5299,18 +5299,18 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
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
-	alloc_flags |= gfp_to_alloc_flags_nonblocking(gfp, order) & ALLOC_HIGHATOMIC;
+	fastpath_alloc_flags |= alloc_flags_nofragment(zonelist_zone(ac.preferred_zoneref), gfp);
+	fastpath_alloc_flags |= alloc_flags_nonblocking(gfp, order) & ALLOC_HIGHATOMIC;
 
 	/* First allocation attempt */
-	page = get_page_from_freelist(alloc_gfp, order, alloc_flags, &ac);
+	page = get_page_from_freelist(alloc_gfp, order, fastpath_alloc_flags, &ac);
 	if (likely(page))
 		goto out;
 

-- 
2.54.0

