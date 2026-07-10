Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BD940BCB3
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 10:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680175; cv=none; b=HxPZ9qM6yl6mKjTQ1qWGiOy/zvCkZqWkIysEP5hyxYbdB4loffanC36XTYgmbgTDDxE1+6YvvtjfH0oL6bhuco/vBPKhO3pf/N0CO2BpwiYFDCnKkI3UEDMY/72B9U1S4qnQkiOSIrMaQO5H1Sb9dflzJ2qWJRQTRW1OM/a2YMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680175; c=relaxed/simple;
	bh=aiYpWqC+lEbJSqYbGuGqsr3lOJ9pBZxhrFZ54bihihs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mKKIUsuO+ECeq8AlJPuI9Na7Upkqz0OHsk4Tv/zOgjL3bPgmncB4dEVKop4uh1/mnP3Bx1wlixvw60cdyDYC2ORzK13Y/PIG7hl8wEneZHZh0r3z7RUS5Z1cRGurnlOylmKkBWSVOVutuXneCzHfajorMsYeaNserJES0G1ALnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZFbxli2s; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZFbxli2s"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c160b9c0676so33007466b.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 03:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783680163; x=1784284963; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SFOgGA5tRZCdjyayy1zy4J6RFFsh/yatP8j3QKMHQdQ=;
        b=ZFbxli2s0Pm5QbcZg+YVNcXFX7VqeNG5QAZzS2e4ttZTffjbMn77FWTxNPlbhW29mw
         0aCsdISSpk52TW8FL3Htn8FRARL7wVV2YVYYRY4jFMsMevDDbqngR2qJ1Kdd5wywcxuk
         Vp6KhY7WwYR50GxW7EW87obeM+ZR/DRTkvvx+3DQmevYEHBxfz8ylc9V6GfqAwfJIHwI
         8mJf0svHNmk0VRKUlKxum0bpWRWhCq6YXExFr8aBMcq6ojNR2vi0V8GGPVb88qfVZ63J
         mbye+jsdT6G7lXUAPORPhvtfmOzqQZSNQtNSzkUlGGZfbFNdG69av0bi0PF6lCaOlCXn
         LccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783680163; x=1784284963;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SFOgGA5tRZCdjyayy1zy4J6RFFsh/yatP8j3QKMHQdQ=;
        b=Xk/comZJTwHT4x14lpT6prrci6f5AbOdrqKmmLCnytlkHoAVCRt6vYwd6sajeublFV
         l5rkVQhHgoYtPlEwxMQzelm4PdrGdpTu43FnbhX6oerFVzbKrvTbFCJ226bUs0vtBC/V
         zoSsxHXZoZOLzbQRHIfSx6T5ZcvuPRw5UUyHNMU+FXMedImyfTEwI6N6OFh4DG8EmM6g
         oBxqq/7pNa2Gw2LHZL6gIgkA6Mk81b1PCR8YAbhCCs6UAhqIpgpen7/neZF5rNyDIAHs
         M7rDEvr5fx8ojXb5ZBeeTdryawhJ1wc2cfNHJ8pcp8d71nAR/ZZdDSmdCRz874Rh2ius
         F2cg==
X-Forwarded-Encrypted: i=1; AFNElJ+gNeTz37w99GWzv3t9T+Cg3zWjTUHruXCcLOq4tepmQgUO6nEbBhc3VrcfwINhL36P3MZ+qQJe5dC6iYFDog==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzcjz9IE7rIklfoWhC5N24kqDqhx7AbkbEDgSVReaSW+fvxZL3R
	woUYuwlViSR542kaaGvn3d8DdIpWvZr2kjuiiFK9ltgvdwj0UM7PXd+Z+aYAp4mWqSol/WkSz33
	3q99U5qp1oaaUmA==
X-Received: from ejn24.prod.google.com ([2002:a17:906:598:b0:c12:7dd1:56a5])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:7245:b0:c12:b227:614b with SMTP id a640c23a62f3a-c15ce03d925mr500309166b.27.1783680162267;
 Fri, 10 Jul 2026 03:42:42 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:42:21 +0000
In-Reply-To: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260710-spin-trylock-followup-v1-2-affb5fe5ed00@google.com>
Subject: [PATCH 2/2] mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Harry Yoo <harry@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

As discussed in the linked patch, the there is some inconsistency between
"trylock" and "nolock" nomenclature, let's align it. Since "nolock" is
used in the public API it seems to have more mindshare so do that.

The linked patch did this for the ALLOC_ flag but forgot about FPI_.

Link: https://lore.kernel.org/all/20260703-alloc-trylock-v5-1-c87b714e19d3@google.com/
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5fe1c11f919d7..ba8d882072de5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -90,7 +90,7 @@ typedef int __bitwise fpi_t;
 #define FPI_TO_TAIL		((__force fpi_t)BIT(1))
 
 /* Free the page without taking locks. Rely on trylock only. */
-#define FPI_TRYLOCK		((__force fpi_t)BIT(2))
+#define FPI_NOLOCK		((__force fpi_t)BIT(2))
 
 /* free_pages_prepare() has already been called for page(s) being freed. */
 #define FPI_PREPARED		((__force fpi_t)BIT(3))
@@ -1419,7 +1419,7 @@ static __always_inline bool __free_pages_prepare(struct page *page,
 	page_table_check_free(page, order);
 	pgalloc_tag_sub(page, 1 << order);
 
-	if (!PageHighMem(page) && !(fpi_flags & FPI_TRYLOCK)) {
+	if (!PageHighMem(page) && !(fpi_flags & FPI_NOLOCK)) {
 		debug_check_no_locks_freed(page_address(page),
 					   PAGE_SIZE << order);
 		debug_check_no_obj_freed(page_address(page),
@@ -1558,7 +1558,7 @@ static void free_one_page(struct zone *zone, struct page *page,
 	struct llist_head *llhead;
 	unsigned long flags;
 
-	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
+	if (unlikely(fpi_flags & FPI_NOLOCK)) {
 		if (!spin_trylock_irqsave(&zone->lock, flags)) {
 			add_page_to_zone_llist(zone, page, order);
 			return;
@@ -1569,7 +1569,7 @@ static void free_one_page(struct zone *zone, struct page *page,
 
 	/* The lock succeeded. Process deferred pages. */
 	llhead = &zone->trylock_free_pages;
-	if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_TRYLOCK))) {
+	if (unlikely(!llist_empty(llhead) && !(fpi_flags & FPI_NOLOCK))) {
 		struct llist_node *llnode;
 		struct page *p, *tmp;
 
@@ -2882,7 +2882,7 @@ static bool free_frozen_page_commit(struct zone *zone,
 	if (pcp->free_count < (batch << CONFIG_PCP_BATCH_SCALE_MAX))
 		pcp->free_count += (1 << order);
 
-	if (unlikely(fpi_flags & FPI_TRYLOCK)) {
+	if (unlikely(fpi_flags & FPI_NOLOCK)) {
 		/*
 		 * Do not attempt to take a zone lock. Let pcp->count get
 		 * over high mark temporarily.
@@ -2979,7 +2979,7 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 		migratetype = MIGRATE_MOVABLE;
 	}
 
-	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {
+	if (unlikely((fpi_flags & FPI_NOLOCK) && !can_spin_trylock())) {
 		add_page_to_zone_llist(zone, page, order);
 		return;
 	}
@@ -3001,7 +3001,7 @@ void free_frozen_pages(struct page *page, unsigned int order)
 
 void free_frozen_pages_nolock(struct page *page, unsigned int order)
 {
-	__free_frozen_pages(page, order, FPI_TRYLOCK);
+	__free_frozen_pages(page, order, FPI_NOLOCK);
 }
 
 /*
@@ -5409,7 +5409,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
 	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
 		__free_frozen_pages(page, order,
-				    alloc_flags & ALLOC_NOLOCK ? FPI_TRYLOCK : 0);
+				    alloc_flags & ALLOC_NOLOCK ? FPI_NOLOCK : 0);
 		page = NULL;
 	}
 
@@ -5532,7 +5532,7 @@ EXPORT_SYMBOL(__free_pages);
  */
 void free_pages_nolock(struct page *page, unsigned int order)
 {
-	___free_pages(page, order, FPI_TRYLOCK);
+	___free_pages(page, order, FPI_NOLOCK);
 }
 
 /**

-- 
2.54.0

