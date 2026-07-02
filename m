Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490804DB542
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985811; cv=none; b=LrNGIFxpnEts2ZjTxkUAjUCL/nWXeOjkxpNNGTnWUXCsnKq/xhCz9QTsH5lQdll7YjzLuDrcIhoUGpZFoQQfxJsSsrlxkdAG3CKfgP0hWe1U0PIoQ0SSJfTwAa5tNShGvA+rthz7qEcVudW2eUPGAwIshbiqQXl91U3TTAs7gbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985811; c=relaxed/simple;
	bh=29DjDNblqVpTGDCQuZAaQoS1GbOAOm7XzMBS6FpDHNc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hxItOIwXb2258xjZuTc8L6LyY7JI/2ESB8BV1kdkTiVYU/joDUwrp224XC8ExqelE7WKEytH3yOn268x6NgKRceLFAkEk/m3xaItaq8cfB15ScALURgfvos7rjTity7nLxoXqxYjl8+sCyKQdvrce8KeV7YncR7nUmrZgbgCYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MHOp3Rf7; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MHOp3Rf7"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-472bdd6f529so975308f8f.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985809; x=1783590609; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jQXytmyYmI8a16dW0v09XUUNQjHph6nhuleCzdBkd7M=;
        b=MHOp3Rf78RLdFt0JnkyBK7j/X6fzjwOLuVsSTwudP5X5A5uXq/CkmnH5VUNUO3aHwC
         I3yKv2RqeyWRiIODxVlH5Xa2ktmr4381QwuU32I19IjWGv0AkWdtRlBN7eBKUQmaGceG
         2EfPjMAhqvpsasyfEMboYkL62ZRHKZEf7+jDPdyZgH7sO2zdT4be/EImCv38lnIs0HAu
         o/WkO7zdNmN5pMhDyHbqjh0BCfDP+NnMI8K7PPnt1JXpLM9QhlnUnGUfCjMsXP+zg2Gb
         Bd2z9awxA/JCIiut8X0aOv7IICNAbkQ/khOguJZdiGyYNCFfIN0HRo2orwjIa8ErR7gu
         rwfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985809; x=1783590609;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQXytmyYmI8a16dW0v09XUUNQjHph6nhuleCzdBkd7M=;
        b=Y342IMlDr4MV74sIsJ8y8LAeGLXCqJu03Ums4h4LWnt5Ofbghqhrn4wyFqefcTvhM8
         uXJXkMIdJaTEDGW64jUzSQd+3eL+0rkJmp3Nqzvwn1zfUW5Guri04uNLVjNZguF7aWwp
         1y0QlIA3NRR9nIyt34p48AotovEzJ9+vo7LJ9SbLJ+VQ042JKivus0QpxS6HKCwsVduF
         0YFLDJYGvJyjvqRs60YRjcsD6V/C7ASDD8HebZh+BSYciMgLNadcA151D0U6imhvmE9Q
         ywP+DQCw3L5zhnPiD03J1MKHQRNyQVabDz0b9SP9HqLQRsLYObqt7KwmUxTHELaW8T8c
         npSw==
X-Forwarded-Encrypted: i=1; AHgh+RofGnkWX/KqWpV5472l2FzdqoitioKjErVtJiJ3ppdzbvDdpK2z3LK0Gd5y0YTGWwOrpIgY+DjwpO4A2RE2Qw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwrVKgJV3/42tEQk5xM0GVYbvHoGctNg0gMXwSeY0/jMQdbwrdq
	B3863LWKg7inSJt/uZZ6L6FSVcimRlvAWfGczIXAI2tTUjKoh0Y7CTC+AxCrddXKj6P8TgFl1YK
	urAR9FzORzKqqgw==
X-Received: from wrsx9.prod.google.com ([2002:adf:ffc9:0:b0:462:fc9c:4a7a])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:fc08:0:b0:473:e22:e819 with SMTP id ffacd0b85a97d-4775a0fe0dcmr6360703f8f.29.1782985808510;
 Thu, 02 Jul 2026 02:50:08 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:48 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-17-0af8ff387e80@google.com>
Subject: [PATCH v4 17/18] mm/page_alloc: drop alloc_flags arg from alloc_flags_cma()
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

To align the style with other alloc_flags_*() functions, drop this
additive argument and just have the callers do that themselves.

Note you can't always freely or alloc_flags like these callers do
(because of the WMARK bits that encode an enum) but this is fine for
ALLOC_CMA, just like it's fine for e.g. ALLOC_NON_BLOCK returned by
alloc_flags_nonblocking() and or'd by its caller.

Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Link: https://lore.kernel.org/all/5dcdd1ef-21ad-4ed0-9e8a-0e5cf96b4392@kernel.org/
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfaf16244f56d..c3b246e67ed14 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3775,14 +3775,13 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 }
 
 /* Must be called after current_gfp_context() which can change gfp_mask */
-static inline unsigned int alloc_flags_cma(gfp_t gfp_mask,
-					   unsigned int alloc_flags)
+static inline unsigned int alloc_flags_cma(gfp_t gfp_mask)
 {
 #ifdef CONFIG_CMA
 	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
-		alloc_flags |= ALLOC_CMA;
+		return ALLOC_CMA;
 #endif
-	return alloc_flags;
+	return ALLOC_DEFAULT;
 }
 
 /*
@@ -4526,7 +4525,7 @@ alloc_flags_slowpath(gfp_t gfp_mask, unsigned int order)
 	} else if (unlikely(rt_or_dl_task(current)) && in_task())
 		alloc_flags |= ALLOC_MIN_RESERVE;
 
-	alloc_flags = alloc_flags_cma(gfp_mask, alloc_flags);
+	alloc_flags |= alloc_flags_cma(gfp_mask);
 
 	if (defrag_mode)
 		alloc_flags |= ALLOC_NOFRAGMENT;
@@ -4837,7 +4836,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
 	if (reserve_flags)
-		alloc_flags = alloc_flags_cma(gfp_mask, reserve_flags) |
+		alloc_flags = alloc_flags_cma(gfp_mask) | reserve_flags |
 				ac->alloc_flags | (alloc_flags & ALLOC_KSWAPD);
 
 	/*
@@ -5070,7 +5069,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 	    should_fail_alloc_page(gfp_mask, order))
 		return false;
 
-	*alloc_flags = alloc_flags_cma(gfp_mask, *alloc_flags);
+	*alloc_flags |= alloc_flags_cma(gfp_mask);
 
 	/* Dirty zone balancing only done in the fast path */
 	ac->spread_dirty_pages = (gfp_mask & __GFP_WRITE);

-- 
2.54.0

