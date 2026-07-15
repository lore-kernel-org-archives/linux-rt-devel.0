Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A1B44210B
	for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 11:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784113421; cv=none; b=DpVUebmcQXqcHu6LgTNNK93gChlC8hVZH59Koed9DjfZGdikGn+lrJAxPD5r0sGTDRQNHu1drF+VIZbuTr2onvRPieJfDTNNVMXUpj+ih8STOvYd/LB6740grhANZ9RSebI9x8po/hIcU3W7koCZGONvkJi1/rOBpYlXPzKFdKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784113421; c=relaxed/simple;
	bh=CVr87p16kUYIkKSvdn3e7Q96lklgqj1Zs1PBoozN1Ps=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nvEHVVyN4AaGxNDlpfvDEV4/4OfFI9vJ5nBTld3CqST8wAe51otw57fiVX+nSy4kPZlkrmUDoGIe80fntlIaDWADaB/8VNJowcXSOWg99vZNtv0Ny4rsHniC/irehcXRko9/nbEa0GiBJZ5d9klQ2mX3deezg5kfGFSSINQXGKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PFwH6xMB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFwH6xMB"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493ba771d1bso20291025e9.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 15 Jul 2026 04:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784113418; x=1784718218; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mf72NgjR/YGP7OyZOYwhsTao63XeRdktGGMG23Y8QgY=;
        b=PFwH6xMBTXmRMwhOK9JDxLeBx9DF1xo5UbeBLyFUVMPGxUsfg6GRh2F5sSt6ajIllt
         eqMBkCdWG35c7XOBScec9tLh3vjlVCjKMNTSate08sH0m1JWYuf59067O8zq3+d+uGPF
         IBRtzvdz518gf0KdrNZkbKzOBPPlWhenwUSk70aErSv9ifHHoP4ozDRQVgCpN5sOdsCT
         CvZ2WZ9HTtmKOpTKPXRF7eARPkky9vPOUvgvVlrj7OXPb63AEGSGS7FTsDoT03tuiVJY
         akhJ76WaO6TSZpBYj5UR6K8RuikXf0kIc55u4HR7ZQ3O/LhK8c/kWPsqsyTWNwy5s00u
         /lLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784113418; x=1784718218;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mf72NgjR/YGP7OyZOYwhsTao63XeRdktGGMG23Y8QgY=;
        b=Mj55oI8yyaBmHL+XfBCXlF4zsQQWfVJRtiBPOk9DjIqsC8eEv8Pc1nGQlgOTCLkI2p
         dNhMR21wnh5mPZAmrl8AHEzJOIv4rL6oH8yUzq5dlEDOGuR+lJeiYw6mqgosIUqryBVw
         f8zkvW0/Qxcvm1Pt7Dj02+wOQFKeXDLoJGDkULQYuEcFpi9u9ZYXTq/ywKWEr9hL570/
         46wBv0YeyObegN9bMA3wBV9zXPjTK/4OFONOHwS19dcZ7O2J/L1QrJzUD7wGPWn1S5+S
         +YF7PxPWWzbGkaAER/gXUqB2fuRwea7PsJXZ2YAuXRpEq45ZfxZPva8vhmr+AR+Ew4bn
         g5gw==
X-Forwarded-Encrypted: i=1; AHgh+RrmAb1T7MWnrYYz1mZRbokOMauQkuevknvnW1SWP2gUtHObeL1eqXOCgudhAIeNIZjwXwpBLzH/NgKQura6yw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yypqj+KeHsy4vcx632QWxjwtqjREeK005lGzAybv+127Qnp5azq
	Z2pITWoAJ7KItaGf82f5mD18wRLC8/1vL0ne/cA4f32+cgpyMEDjPltrtuYKzN6uP0HwdoOTaXI
	YL/OSUFaqJr6huQ==
X-Received: from wmat13.prod.google.com ([2002:a05:600c:6d0d:b0:495:3c56:7eb1])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3223:b0:495:50c:259c with SMTP id 5b1f17b1804b1-495050c29d0mr54629235e9.7.1784113418268;
 Wed, 15 Jul 2026 04:03:38 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:03:18 +0000
In-Reply-To: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260715-spin-trylock-followup-v3-0-fc4d246f705d@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260715-spin-trylock-followup-v3-1-fc4d246f705d@google.com>
Subject: [PATCH v3 1/4] mm/page_alloc: rename FPI_TRYLOCK -> FPI_NOLOCK
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Waiman Long <longman@redhat.com>, 
	Ridong Chen <ridong.chen@linux.dev>, Tejun Heo <tj@kernel.org>, 
	"=?utf-8?q?Michal_Koutn=C3=BD?=" <mkoutny@suse.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="utf-8"

As discussed in the linked patch, the there is some inconsistency between
"trylock" and "nolock" nomenclature, let's align it. Since "nolock" is
used in the public API it seems to have more mindshare so do that.

The linked patch did this for the ALLOC_ flag but forgot about FPI_.

Link: https://lore.kernel.org/all/20260703-alloc-trylock-v5-1-c87b714e19d3@google.com/
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index af63558391345..c2da85e69a0f8 100644
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
 
-	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
+	if (unlikely((fpi_flags & FPI_NOLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
 		     && (in_nmi() || in_hardirq()))) {
 		add_page_to_zone_llist(zone, page, order);
 		return;
@@ -3002,7 +3002,7 @@ void free_frozen_pages(struct page *page, unsigned int order)
 
 void free_frozen_pages_nolock(struct page *page, unsigned int order)
 {
-	__free_frozen_pages(page, order, FPI_TRYLOCK);
+	__free_frozen_pages(page, order, FPI_NOLOCK);
 }
 
 /*
@@ -5399,7 +5399,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	if (memcg_kmem_online() && (gfp & __GFP_ACCOUNT) && page &&
 	    unlikely(__memcg_kmem_charge_page(page, gfp, order) != 0)) {
 		__free_frozen_pages(page, order,
-				    alloc_flags & ALLOC_NOLOCK ? FPI_TRYLOCK : 0);
+				    alloc_flags & ALLOC_NOLOCK ? FPI_NOLOCK : 0);
 		page = NULL;
 	}
 
@@ -5522,7 +5522,7 @@ EXPORT_SYMBOL(__free_pages);
  */
 void free_pages_nolock(struct page *page, unsigned int order)
 {
-	___free_pages(page, order, FPI_TRYLOCK);
+	___free_pages(page, order, FPI_NOLOCK);
 }
 
 /**

-- 
2.54.0

