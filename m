Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9940F3D3336
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081945; cv=none; b=m4lwJhXzU7sqnPuQtnY4mgBdbWJgLkDWFdn1MU5MB4qAWnyVSUKecRnZ4VPRBPyPQPNTXoKM3YwhxienPMGNBJvbQeQNw4hMvMJAvDH5KuM86wQnnD7TNK5tv6P4dti95ZHUXVZHINtJiZ4t83/2Ge/EuFNRVNVxDDSRGHvQL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081945; c=relaxed/simple;
	bh=XSMEx7/rnQ/A8Pwk/KpzBBynrXnVI6BQCpv6JO2sLSQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j5ifQjyvCXTAZDSgJ9fUmHEgOJUz3Rc9vX7DQALmlG0vQcmbDz7I0hLIbSpxR4/oVHQDoOlBOZyMauHp3v5UnFEIwXELRVsdpxtnicfLMCnSfkMngAx/SY/sgs2DE0t8O9aYf2KvWru2maUvBupcTmM8CoyqoebnGVr8Vn+qORw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZmkivC20; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmkivC20"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493c588b6f2so4077425e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081938; x=1783686738; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QxpluEDl6Bvs+YrJCKdo0lCaCsO0ieanT5jt0bN1dTA=;
        b=ZmkivC20TyYuTluBHT2ZTGHtCgq5U89+XM2KyyD69X6Ay+h2sPCYsU2+v0zd6Sa4h5
         ONBtZZwfXhPKM4xYtTeBKjm16/3txVkgML9+BArZFmCMguidDYUgc8l8TqPXJkgyRiK8
         8lD8J5tHWNgHSdm6T+vses6q56eJ93EBxfgN6hWWm57TedbcYMh3vQfjUlDot8XLwfUo
         Gfak+HMqLnVMR/CtpfVfcs+1WrLAvKIpWZqCoNMWtuuRIBcsiBbG1+9/5yG0EEdzZ/84
         TNDFEBBvm1WR13BLc/vuaoKglpoY/HsglpAsYeZlM+J7aVSFoXe0zG6VNvpW/vZdZ7Vw
         2mlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081938; x=1783686738;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QxpluEDl6Bvs+YrJCKdo0lCaCsO0ieanT5jt0bN1dTA=;
        b=CSgb5ckqcsSGz1OSkzdVl4GJamZpEMfP+LL5ZhCGIcqlYyul6mpeYErizTTFHAg7Na
         Wez79n/xU5JyI8s8f2dAX1BD/noWKsAbnF+BIvRyJ3EA8BUS8Z2I6rPGhVai3rOllS11
         nTdE/zEftmrNaWPUnqBFyMOFC+MTUzgNe/lYh1qf+xjmEwXaP1BcXEnWRmNvCvTfKpj3
         oWPekyEJkPk9RutWbW2WrtfDgxSTjkIp+su6n+u6z0uUUAF2FmKPHgIHE3SY6HLGn2Be
         nUzGg1vH9IooeJpHML8Y6yzw5hWJFdY3crEdW4bjAY5AHw5v+1/zchngOvGRguYAOP9k
         6e1w==
X-Forwarded-Encrypted: i=1; AFNElJ/SN1j4b5LMV7ofbMqTeCAS/+H0P1o5qOWdqiJAVjI0mVrp+luAkLNRx9yrpAazd3ECELfxcs+H2Zn4oOcPPQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzSljUwlWGkmjZAGTJx7IVgATMi28ur6F+B2ia3eRu8R8zmZHW
	gteyAwjkKQhlMuQ4MuIBvohEgOFgGMB9ytMyJ4QWplS3IOy6peDp6NR6XDYYTeZtYSmsFFAKlar
	hx23tWReoY2+YJA==
X-Received: from wmqn2.prod.google.com ([2002:a05:600c:4f82:b0:489:1b01:386f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c1c:b0:493:c1a1:68f0 with SMTP id 5b1f17b1804b1-493c2b6e672mr171824055e9.20.1783081937799;
 Fri, 03 Jul 2026 05:32:17 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:41 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-1-c87b714e19d3@google.com>
Subject: [PATCH v5 01/18] mm/page_alloc: rename ALLOC_TRYLOCK -> ALLOC_NOLOCK
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

