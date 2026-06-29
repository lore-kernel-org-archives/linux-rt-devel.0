Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2116405C54
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738738; cv=none; b=CNzNdfMtnfmjz1ZUf4MjvEHb/VkB6ucMhnLDm/ZkxN+JVao3pdVujyyYK7Gup7EqONfcujv5MQ49LHuQOuG039pIU1H9jWdkYsSivFVN7qggU7puSCkXzYkeWUUO36xojcjlHv+89KCfAwB1M+kl8RD8TxDE9betxftpUyMhRZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738738; c=relaxed/simple;
	bh=IxYE9llJYlk6JZgwqyrWR3NpDimgqSc4tCw4MYHPFKg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r76ifiaP8hiWBnxc1wvCv3SH+e4BQ3UBnKWipqoV2C9yPp+LqH9rAei8mNAmRB2RHjUUJFOXbjFMlEcEparnX5QTL75wqKkN+q24FsnmlqEeoJ26IeRbhNc1qoScoUdTGLdE6I1C/w25PIRpCigCYpglLDE0Llo4xa7iufZe4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F1V6R+CE; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F1V6R+CE"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49277e7fc5cso16474215e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738735; x=1783343535; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KiAPxDKk/sTRmD2XdxXE4JggXE3gBepw6QWVMegxow=;
        b=F1V6R+CEqRfig7Isv6jCiIIu440hof3VzCvFv630t7yQWC08DzFHFOxOTjhgwW+Ihi
         htLFl38EP5truKg91m6CSbFyWE7cWg2BOMFk7HqGLUi7wi9lOteUnAyE4XVdd5FnH0wt
         yKjm7PAASUjO2+Rc2jDCqiBpdVBqYBVOzfPSRGGnyAHDitG3BRfYJ1Usfza2tGAbiiL3
         ehtAlR6UfUazZsl3/fR7E0+tLA6gMD6tkWaQiE4qrdsJXK5Hf8l+UVcGs0MFNi0X5VvV
         dw+zSZUzftpJI9dVhF/xok7CkQOhJWx12yZHEwhJnDYXXeoaap6EDWUB240JJxHe+9mT
         SwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738735; x=1783343535;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KiAPxDKk/sTRmD2XdxXE4JggXE3gBepw6QWVMegxow=;
        b=LABvwV2ohPBxUDIK+CWw5x9vs85DPam0xl+PQHwwtBOknrtjha/vPXIZPUidpSXHJs
         y7wEk0Xb3YDRxqJKWXwY7Ad2kla2oVccfDbo4qZeO03WPclSPgOcQCdtH+bp9BZpzxP1
         5EsYTCNhPbZSMSTZZcTbIaIqlvqcLlZf0ITa3vz5NiC8pIU/k3y1xcd2yIN+4bJeCUwY
         uKpaLp/OZzEDtXbq3uf2MkK2xI+mn2MxfgVVyggVAPtSITKlsTmVYG09w3SMZ8oA4rK8
         mITxMl5FF1UGaXcuCuGSPgTZGcmhiu1hyQRTxeZeQqY1S14N4W/4ByLFoLQFj2Rc9oKq
         M6cw==
X-Forwarded-Encrypted: i=1; AFNElJ9bklCG29kwcS/UnWGVlIWqBRRQ5TgqP2HP/Ot+VexvO9A/3PBxqHk8oFQwsbCajh5Jth0XdcpQdB/EW5D6Nw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxnfF5YuxZYf8nNJ8EZyyS07sNPh2A76/ys9klbippLDfRQsvCv
	SDxurOXJB9QA3KJ8Zoq3fIVuwxuxKbQ7nG4OjQQbsj/TeIjV4v2jCMtfHBwPLgdicABg5QTliUc
	c9VpEwZZy0wFK1w==
X-Received: from wmbei8.prod.google.com ([2002:a05:600c:3f08:b0:490:4477:50d3])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b85:b0:490:50c5:8153 with SMTP id 5b1f17b1804b1-4926683231fmr257056755e9.2.1782738734079;
 Mon, 29 Jun 2026 06:12:14 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:50 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-1-57bef0eadbc2@google.com>
Subject: [PATCH v3 01/16] mm/page_alloc: rename ALLOC_TRYLOCK -> ALLOC_NOLOCK
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

It's confusing that the function is called "nolock" but the flag is
called "trylock", align them.

The function's terminology is more visible and has more mindshare so use that.

Suggested-by: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Link: https://lore.kernel.org/linux-mm/2399b3ad-4eac-4a14-94c3-27e9f07972a1@kernel.org/
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/internal.h   |  2 +-
 mm/page_alloc.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 430aa72a45758..2237eee030cba 100644
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
index 62f71ece7ca17..421271849f291 100644
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

