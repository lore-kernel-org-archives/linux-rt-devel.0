Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27944C6F0E
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985790; cv=none; b=LBi4Hg1xx2o4/b6ljZKNSY2G8q6Sf+mNNvYOexJczaaRt7rjMrmqxlAFYI5+pZ8BeEnMkc6sQYsKwYTqNdFHgNMyxpogH3MQSrwqJUkLmc3hR05chd/AIFpixARPFYIHKRfD/E4DkATPNMwH98LfkmkVJJB6CTTGucTxYKGoEds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985790; c=relaxed/simple;
	bh=XSMEx7/rnQ/A8Pwk/KpzBBynrXnVI6BQCpv6JO2sLSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZX9XH2HiazhMowZQEwGOd35FYopPU3at9F9vWLTWhEd73k45v0GJAJ130nYBU2k04zanjoKbQgkxrJegaJUTofcMxyYUC4HAESCoonef7EgL9apaVJvkJF4arPcwTi4PySj1dw4KFGunW/VKv4qPBHSFyOGONJEgjA2O2vzFLY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f3Q0m/C1; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f3Q0m/C1"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c07d22d503fso158525666b.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985787; x=1783590587; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QxpluEDl6Bvs+YrJCKdo0lCaCsO0ieanT5jt0bN1dTA=;
        b=f3Q0m/C1zH573eyc+pneqc6Dwq+3Cq3M+yglRnt3gXTwOeHWVU2f1+ndDDsSd0KmY4
         mdUYvEyM8OpuT+7Lpgv7JLMDhpZu6Oyy89sIDWo62PWc+1N5WMGP7h/ayegvxXDmxwBK
         te2r70wXi9HK4tP5ooB7Wtxp6pQGh6rIHTpai/Ftrqq8LMN+MIJy9bMdy4YDgxlnzVCA
         55PVas8mBKGLrPFo+0pZQC92m3y+JlPhplslxOIqywBBNN5hDU8ocSfHJ/Kpkg9N5gIk
         1KyxDsI6h67I3KFh3oB2fFG3lWZxUCPGxWqdi99hulq519Hfd/YzP+ldyIxgWsXTENIO
         ebTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985787; x=1783590587;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QxpluEDl6Bvs+YrJCKdo0lCaCsO0ieanT5jt0bN1dTA=;
        b=bVXtajpmAAX0CcSQzsuPFQ0HLs408aDg2n2HzxQw196KCPQU/XuNLTDP/xXbaW/Ln/
         DLl20o3Sb1WHjN0JA6aXOvqsXfvwN509IG/+eI8duEzbIym6/NPRN0FLB/JzM0Mt+eMg
         /nXj+O+ek2a8NBafXbexQYn+GclYFrnVk4xmoS5NM9K3IXiB8ORk0tck9jbdYO/YJyLf
         9Frje15ovZO4H5xmB55on/UNSUEwtz3yANgmrgGUoHP6NfdBABVoJdeYEH36nACv02on
         2T3uyJVKFZe8XaNCsLXVqE+79s76LitO/hdgQv7yHoHmKXP6aCH43mg0d1kPh1p/qCj2
         B5QA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7NV2TyvFEFDVHZq6YKqbsqSYtXwp70e7mTqEXR/jWo6SIwsm4v4QbSQ9NsghOigzHTBwF1cvfKzYHFS97nw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLQr6ZF6lCjP+ZM/Ug9gun6/tt8+2ed5SZr3MNX6GWtnSRDAjp
	d66aMWmWv/Ncc/zhX14D6BCmt09HXQChR1S/hev7LPHNyCeqpJPNJT5l/YZ2yoNhu9/dAYR9GT/
	jHXtxLJb0e+G/tQ==
X-Received: from ejjd17.prod.google.com ([2002:a17:906:3ed1:b0:c12:6c1e:ea29])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:6a01:b0:c12:b226:27 with SMTP id a640c23a62f3a-c12b2260182mr177229266b.11.1782985786777;
 Thu, 02 Jul 2026 02:49:46 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:32 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-1-0af8ff387e80@google.com>
Subject: [PATCH v4 01/18] mm/page_alloc: rename ALLOC_TRYLOCK -> ALLOC_NOLOCK
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

It's confusing that the function is called "nolock" but the flag is
called "trylock", align them.

The function's terminology is more visible and has more mindshare so use that.

Suggested-by: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Link: https://lore.kernel.org/linux-mm/2399b3ad-4eac-4a14-94c3-27e9f07972a1@kernel.org/
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/internal.h   |  2 +-
 mm/page_alloc.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index fa4fb69444ecd..a2b09a13735bf 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1480,7 +1480,7 @@ unsigned int reclaim_clean_pages_from_list(struct zone *zone,
 #define ALLOC_NOFRAGMENT	  0x0
 #endif
 #define ALLOC_HIGHATOMIC	0x200 /* Allows access to MIGRATE_HIGHATOMIC */
-#define ALLOC_TRYLOCK		0x400 /* Only use spin_trylock in allocation path */
+#define ALLOC_NOLOCK		0x400 /* Only use spin_trylock in allocation path */
 #define ALLOC_KSWAPD		0x800 /* allow waking of kswapd, __GFP_KSWAPD_RECLAIM set */
 
 /* Flags that allow allocations below the min watermark. */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 762d9b6bc792f..6004fe6583d47 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2530,7 +2530,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 	unsigned long flags;
 	int i;
 
-	if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
+	if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
 		if (!spin_trylock_irqsave(&zone->lock, flags))
 			return 0;
 	} else {
@@ -3218,7 +3218,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 
 	do {
 		page = NULL;
-		if (unlikely(alloc_flags & ALLOC_TRYLOCK)) {
+		if (unlikely(alloc_flags & ALLOC_NOLOCK)) {
 			if (!spin_trylock_irqsave(&zone->lock, flags))
 				return NULL;
 		} else {
@@ -5059,7 +5059,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 	 * Don't invoke should_fail logic, since it may call
 	 * get_random_u32() and printk() which need to spin_lock.
 	 */
-	if (!(*alloc_flags & ALLOC_TRYLOCK) &&
+	if (!(*alloc_flags & ALLOC_NOLOCK) &&
 	    should_fail_alloc_page(gfp_mask, order))
 		return false;
 
@@ -7804,7 +7804,7 @@ static bool cond_accept_memory(struct zone *zone, unsigned int order,
 		return false;
 
 	/* Bailout, since try_to_accept_memory_one() needs to take a lock */
-	if (alloc_flags & ALLOC_TRYLOCK)
+	if (alloc_flags & ALLOC_NOLOCK)
 		return false;
 
 	wmark = promo_wmark_pages(zone);
@@ -7896,7 +7896,7 @@ struct page *alloc_frozen_pages_nolock_noprof(gfp_t gfp_flags, int nid, unsigned
 	 */
 	gfp_t alloc_gfp = __GFP_NOWARN | __GFP_ZERO | __GFP_NOMEMALLOC | __GFP_COMP
 			| gfp_flags;
-	unsigned int alloc_flags = ALLOC_TRYLOCK;
+	unsigned int alloc_flags = ALLOC_NOLOCK;
 	struct alloc_context ac = { };
 	struct page *page;
 

-- 
2.54.0

