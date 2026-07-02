Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BAC4DB553
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985813; cv=none; b=algbSpNgSJJaM1dRLjhWgIAGRtnUrngKyxeu0IEx5lhYoPSgpVJsI9h6m4xdPaEK9wVK7JNd06zi4wzG7ypOf8hYwQA8h60jHatVbLHIXvqs/ztTWg6cdZgWlzgxroLWhkHbkhWa0vMlryMhS4wQeGrZmYlHbT6wQRDCJQkXd7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985813; c=relaxed/simple;
	bh=6lXyelhP+YzK5NOUKYSS01IIuo1QDayHo85EqH8ryQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sr6v7PiEmbTmDE+pkXGWRxcLQa29GRRSs9TZQ8Qwu7QILBlvimY11d5+EnRPAI37RAZgwMR32WLMZ79qtXXaCbQfQupL72llwP9i41bEO1+QCXV7dJTySZUrL8TSZMiWNMtp2t3y8nJSKPRo054ndKRY+nOWzMEu9pDD3+kbQ04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TM5nk0rt; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TM5nk0rt"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c1260766980so178107466b.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985810; x=1783590610; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TP8w64q3enZcalDNTlZcEsZaQVlvwCzoUrHNAb6H0EQ=;
        b=TM5nk0rt0YIEaZCtgnt3PQ3GuzYu4zjVMH3EdLTH7SseSsgLtY8clY0PTW48+9d4fh
         nyJseKWucK0kl6hRCupAaqjV9sVU0pk9x820C1f2QbZ72MkX8IXhygzxj3327zpH46Xu
         2j8KIhI7x+cqPRCQtVvrXa9gja89K6viKB35VMXldT2jvRIN02pYWQvIsEOIC5D4pGGk
         QHS4Pb1OGV2YZF8VxjfE1HUco7pxHpikGwE6KMdrDJmXWwfjW6mIzuaDIbLISWFGHQjh
         /nNknVyEW+CmRiJqi15iYIuwXAV8NPIIhhhtbRYIc3zEIHGh4Aq1tkXaoJdM7E2O7ysd
         rk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985810; x=1783590610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TP8w64q3enZcalDNTlZcEsZaQVlvwCzoUrHNAb6H0EQ=;
        b=WeSnh/rSnbMrGAnI1C9HeDWsgiNIINhguXEMlLBK/B5ztIRUGOVIb9+8mO6Os04OYz
         Z7+1dYmFHOP8woHcSSU9xJgU+Yhu6/Ggra8yi+qkQ9jFsRNHuv77oghZfgwYzgjuLhVA
         ZXACJrjcoKmMAytUaF+Yquh6Aqlgc0BoZKWtIzkPsJwrr/3rfPvFeFVYQYsSQ5tQ5kxM
         i70Sc8irzmJ6UA4CIG7Vdv0D4n/S4pt7+5Pte5eMXYHUyAKmhP0aS9Rgq3V11l2IE07g
         NPRKtUxu08aL1qOc5R+BmICr0rbPWjaxnqLafte+nKPkzc98k7OrUJThPmpPTkQi/rnQ
         wirg==
X-Forwarded-Encrypted: i=1; AHgh+RppkB87n/eUm/ShpLfq1aFjQcqV7IwcIMGc+a7Pp7knyLKNLUMnmz20r5CyWwbZNfKk3bztq9YVuNekq+12ZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqboNUtUDBe0zmY+w9TZKt7qo3Arc2515vX60MuICiYsL0AO01
	CNBrap9KXvpSSTy1zY088TSJ8LygQTt2pg4eKCLX3pAmN48moyM85oEM17dDAMet3Akoq7GsWvB
	FlDUFNxy0WLhkaQ==
X-Received: from ejiv19.prod.google.com ([2002:a17:906:2f13:b0:c12:6b9c:5e58])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:e117:b0:bfb:1e1c:3197 with SMTP id a640c23a62f3a-c12ae7ba8e9mr187344066b.41.1782985809984;
 Thu, 02 Jul 2026 02:50:09 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:49 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-18-0af8ff387e80@google.com>
Subject: [PATCH v4 18/18] mm: factor out can_spin_trylock()
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

Deduplicate checks for whether the current context is safe for
spin_trylock().

Does this function really belong in mm/internal.h or is it generic? Not
sure. If someone ends up duplicating this logic elsewhere in the kernel,
that would be a shame. But goes in some generic header, someone treats
it as documentation about where it's guaranteed safe to spin_trylock(),
and then it emerges that there are other subtle preconditions that
didn't affect the mm usecase, that would be worse. So, just be
conservative and keep it local.

Suggested-by: Harry Yoo <harry@kernel.org>
Link: https://lore.kernel.org/all/397859cb-b127-4cc6-9c71-044afc99bf0c@kernel.org/
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/internal.h   | 23 +++++++++++++++++++++++
 mm/page_alloc.c | 17 +----------------
 mm/slub.c       | 10 +---------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 3c00eaf5f45a4..e6f300693ffd7 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1715,4 +1715,27 @@ static inline void mm_prepare_for_swap_entries(struct mm_struct *mm)
 	}
 }
 
+static inline bool can_spin_trylock(void)
+{
+	/*
+	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
+	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the current
+	 * task may be waiting for one rt_spin_lock, but rt_spin_trylock() will
+	 * mark the task as the owner of another rt_spin_lock which will
+	 * confuse PI logic, so return immediately if called from hard IRQ or
+	 * NMI.
+	 *
+	 * Note, irqs_disabled() case is ok. spin_trylock() can be called
+	 * from raw_spin_lock_irqsave region.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
+		return false;
+
+	/* On UP, spin_trylock() always succeeds even when it is locked */
+	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
+		return false;
+
+	return true;
+}
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c3b246e67ed14..a63733dac659e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5291,22 +5291,7 @@ static inline bool alloc_order_allowed(gfp_t gfp, unsigned int order,
 
 static inline bool alloc_nolock_allowed(void)
 {
-	/*
-	 * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
-	 * unsafe in NMI. If spin_trylock() is called from hard IRQ the current
-	 * task may be waiting for one rt_spin_lock, but rt_spin_trylock() will
-	 * mark the task as the owner of another rt_spin_lock which will
-	 * confuse PI logic, so return immediately if called from hard IRQ or
-	 * NMI.
-	 *
-	 * Note, irqs_disabled() case is ok. This function can be called
-	 * from raw_spin_lock_irqsave region.
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
-		return false;
-
-	/* On UP, spin_trylock() always succeeds even when it is locked */
-	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
+	if (!can_spin_trylock())
 		return false;
 
 	/* Bailout, since _deferred_grow_zone() needs to take a lock */
diff --git a/mm/slub.c b/mm/slub.c
index 3989b4758ae0a..b19dc46de73c5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5408,15 +5408,7 @@ static void *__kmalloc_nolock_noprof(DECL_TOKEN_PARAMS(size, token), gfp_t gfp_f
 	if (unlikely(!size))
 		return ZERO_SIZE_PTR;
 
-	/*
-	 * See the comment for the same check in
-	 * alloc_frozen_pages_nolock_noprof()
-	 */
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
-		return NULL;
-
-	/* On UP, spin_trylock() always succeeds even when it is locked */
-	if (!IS_ENABLED(CONFIG_SMP) && in_nmi())
+	if (!can_spin_trylock())
 		return NULL;
 
 retry:

-- 
2.54.0

