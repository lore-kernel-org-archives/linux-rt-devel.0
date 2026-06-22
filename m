Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC5436308F
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122505; cv=none; b=ds79fJMn3ir736fgPxWYMqWxjoZsRKpwlG3Cms04OduRYGFIFnrGot1tRnDO0gOLV0EhBbTOLSQ0y5vLId58+wqPD+Cw0CDqG9F2/6+sz9E2wZfNivKP39Bh9sOvPh+shRGQImU6KtgjDwXWjAx64Yd1sMZKEnlgwb2+ObX/VQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122505; c=relaxed/simple;
	bh=5N1IHbTh4aGWLCt5X+YQBvX1CjUk4c66onkWMns28ME=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XdsPIeivXPfPdEaVC+XkfXfNyZYv+C68S54O0kXR40BUw1JiiIH2LJgRHTFbQAcaWP6XHVvEQOdycvPJkWHW3odjUCkwUuc8EkTe9ZKEgFt2hopzA+oAt77Jw7x3uvV4zGQol9r4xZ1NbfwhehaZkpoHzbl5OffoVMIzHPhYR3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eWDBHlMJ; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eWDBHlMJ"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-695bbac451bso4455121a12.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122502; x=1782727302; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UneJ0hQ9IswDca+FJXWZCL3Fj/wq6Co0/EBHWSTe0wU=;
        b=eWDBHlMJPthy7ov7LsjDItH7DPMULv4KrWpsDaMesR3uNR5Ulpcy4a993MMQMeliJm
         FCGp+3vBaoXkeoFKsYmqdpTJzYLBiFqK69R7GRAd3nDkafQCQxC/3aPgGtBvDlREtl8z
         ei5lsQZE5/nRO/PLuo0VjM5L/1BjT982HrSiYKaJS92jztvWAQjNnrK+NlWTSnU5tpLw
         s8MeKDwuTub1vTpxuzHtGBTWLkavVUeryFR5OQ2DsuC/gEEWkRj+bLsnOXK/OjAgYnIt
         /LVoUYSyijoTXedvnw0/dWSuRCkXD3CwxH/kexvnhDjM3JsevM1hz7h57RmRMI9wux+V
         bRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122502; x=1782727302;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UneJ0hQ9IswDca+FJXWZCL3Fj/wq6Co0/EBHWSTe0wU=;
        b=dcjQjoPW+zwrp5ImoungQqwLtRYrBo4z9/cxfuLr1I/7Ta3SdtOAkTOWHYSTeWfejs
         rn861NFTjMoaifipqVce4hxv2tJyJWxV2zxCi2BxoAGjjECKSW0it2ps2JWtQr4Of38r
         qTUcmSqsnwySZ7rGp57dZ4oXPHuGfPUyJT4/kxmkTOdT9uOQYXjYV6KNmF2Rzam7if78
         czkb+zm+/NIA5Qld86J7T6gtRJlaZd8F/ra08GOS3uxYQpyQB/M4ZAKJmTtXFNKc9HSX
         DuQoy/FGbPRsJDRmfpm3lcLmm4orhGRGhD0sl6gy7WAoJBvS3+0WOX2LFY/TijQXuBsY
         ZZjw==
X-Forwarded-Encrypted: i=1; AFNElJ88m0fdOghw63xWrPXm3RuPBT7NAqqxIinjm/54gJ0JM67FupZdDN6y3rHUiLhg5CkH1pU+vqi0ix8NNLVapg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyNdVaKzCdSFGOm/Eqmdx3jczcu1vWpuis+0okXCLak+pS8i0nx
	jQ0Dtv+RNebOJeM9KbNRp7gmO9ncUJsih0cb3jywRfFMV1gJ0E8YGeCuokXCrgJzCuy0DV9z4+7
	buPsZDIkH9wGuKw==
X-Received: from edsn17.prod.google.com ([2002:aa7:c791:0:b0:695:c3e8:f517])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:400f:b0:697:be39:606f with SMTP id 4fb4d7f45d1cf-697be3960f5mr844476a12.11.1782122501844;
 Mon, 22 Jun 2026 03:01:41 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:28 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-1-31f31367d420@google.com>
Subject: [PATCH v2 01/13] mm/page_alloc: rename ALLOC_TRYLOCK -> ALLOC_NOLOCK
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

It's confusing that the function is called "nolock" but the flag is
called "trylock", align them.

The function's terminology is more visible and has more mindshare so use that.

Suggested-by: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Link: https://lore.kernel.org/linux-mm/2399b3ad-4eac-4a14-94c3-27e9f07972a1@kernel.org/
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/internal.h   |  2 +-
 mm/page_alloc.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 181e79f1d6a20..1483a4fcdfce1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1475,7 +1475,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_NOFRAGMENT	  0x0
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
-#define ALLOC_TRYLOCK		0x400 /* Only use spin_trylock in allocation path */
+#define ALLOC_NOLOCK		0x400 /* Only use spin_trylock in allocation path */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
 /* Flags that allow allocations below the min watermark. */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0111cdbdb5321..6c4eb6908bd95 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2528,7 +2528,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	unsigned long flags;
 	int i;
 
-	if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
+	if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
 		if (!spin_trylock_irqsave(&zone->lock, flags))
 			return 0;
 	} else {
@@ -3216,7 +3216,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 	do {
 		page = NULL;
-		if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
+		if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
 			if (!spin_trylock_irqsave(&zone->lock, flags))
 				return NULL;
 		} else {
@@ -5042,7 +5042,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 	 * Don't invoke should_fail logic, since it may call
 	 * get_random_u32() and printk() which need to spin_lock.
 	 */
-	if (!(*alloc_flags & ALLOC_TRYLOCK) &&
+	if (!(*alloc_flags & ALLOC_NOLOCK) &&
 	    should_fail_alloc_page(gfp_mask, order))
 		return false;
 
@@ -7786,7 +7786,7 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order,
 		return false;
 
 	/* Bailout, since try_to_accept_memory_one() needs to take a lock */
-	if (alloc_flags & ALLOC_TRYLOCK)
+	if (alloc_flags & ALLOC_NOLOCK)
 		return false;
 
 	wmark = promo_wmark_pages(zone);
@@ -7878,7 +7878,7 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 	 */
 	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC | __GFP_COMP
 			| gfp_flags;
-	unsigned int alloc_flags = ALLOC_TRYLOCK;
+	unsigned int alloc_flags = ALLOC_NOLOCK;
 	struct alloc_context ac = { };
 	struct page *page;
 

-- 
2.54.0

