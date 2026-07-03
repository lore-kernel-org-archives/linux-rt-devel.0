Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FADF3C0602
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081947; cv=none; b=DVO45vZTqf9DE2b2ApLwTn7UM64vRI28S5rbQd/ieF66qtJe1A3bh1ur56k/a+bxNqKkVIPFTPCzPjyyBhvVqiQKNKzznyG8RRvDYJKlv/Ej2ckDnUgTQaL4kl7PUs5lyF3T39k4aGPmJEebPV1qrEcWZNzlW/1Ykykz7uvuqcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081947; c=relaxed/simple;
	bh=Lu7MbaQVyOUf1SmaYcR+owPfW6FHQTPQJ53YEqaID2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o56iT6bEmtHQhGaUQIFMqk3Ru9gBCdRig+Qb1O1tUGmgEYfwmqN/8nudXGdwUTj3ukrGyUiBq6r2P+Gxl3rmakcLXozR9UVSmfWi39oMKqDpjZnc7YPwBWkD+sHXU/xS+7sYN6Kb1JLgJGljIMLCiOwu2a8EK0yoF4+5q+5Nops=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rkq22q9/; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rkq22q9/"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-47485fde05aso406201f8f.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081940; x=1783686740; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni+aRw2R4ZEwrhwGe4xokmUGFRvRoyUT7XfJ1uWOieo=;
        b=Rkq22q9/QQ2K0wpfAfLRzyF//9L68JkK92Xik2gfgygFSNAMDqCnSptaXrkJhY8W4O
         I6OSBtlbQoZAGdq8t4r4HAxThkd5KP54GwhFElDjMJA19C61yqAfWCadcKjAo3i/uvRG
         Xvt9upan8iN5MDUhRbE3C7Rs3+CB7onHxMd49C+TjqU+NBoHByGB96gpsjlwoH4bqB4M
         jHedXaYfpa+jjUUwDl0wYzf1dHC/1Yr5FqqCDXjaYHAzrWroBVajuqqRls4oRhx/vE3B
         n+lORmzqh9CmEhJJgQfeCJiJI6qMA8np+F94i9XKdNnnf4hJSwQ+5B2tCs4lsMR5ly0v
         yN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081940; x=1783686740;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ni+aRw2R4ZEwrhwGe4xokmUGFRvRoyUT7XfJ1uWOieo=;
        b=h4Eu28AfOGLMl4STSkQSfmjL8Nx102vcZf9pemqWKIFBExWSSDC1r7N44ZDEeaj8fq
         aVF0YnlRsIfiACQryLrdpm0n6BDVJnMZkRjT7mv+7HeCakslYjASFLu3c1w3ddwpztYm
         POQgKWYPhPv6wvDjSuWQR6ZvvATICTX5FAsP5OYYfL6UW88jZgvPDCQn9KYmpPfRLnfd
         MPBUN0k8hIprVOffm7fKXD3AQLU7fNCKArGdjjh7pnb3cw0fASz2awSL5PrMDo2qvicQ
         6WaeWZH0fV0Q/BPe+XXfVS3bnCrIggR2hnpcax0L7SLe6VEhlEFk6juvkd98KaD2uAxi
         srGg==
X-Forwarded-Encrypted: i=1; AFNElJ9pKfKtL4VIZqE6dMPaSTkxhoVCI9a0eIPVphdtTgsYY9oyFuFcooC0ohxiTVth7uB75SLNDXYuRxE9co7+Lw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz0HkVa9ONfSmawMcy0CfWmJkpTlFaYN7vrN0jK/oz5Y5cJfFBY
	O963M59OB2bM6+Ik8YZPXYv632pDBLz/5qdmOam8tsZFnAEiT/Z58KoHpER1s2WIZ+WnM8zq347
	efyUmQc22jYk9AA==
X-Received: from wmcn26.prod.google.com ([2002:a05:600c:c0da:b0:493:b60b:4681])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6a8e:b0:490:bd66:e523 with SMTP id 5b1f17b1804b1-493c2b7f3bbmr100883055e9.20.1783081940215;
 Fri, 03 Jul 2026 05:32:20 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:42 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-2-c87b714e19d3@google.com>
Subject: [PATCH v5 02/18] mm/page_alloc: some renames to clarify alloc_flags scopes
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

