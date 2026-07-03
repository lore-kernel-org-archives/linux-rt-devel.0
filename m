Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FACB3D75A9
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081968; cv=none; b=DCE3kyc4RO9qFT8bubzQw6Efb1kilMSvSPSfAOodhtJIoqpm4CB9FvVQtvezonHCsPaQGhkFWterzR8qkzEB0kpZvbDQZHacoXwFRlYTHwII7Rx7HLoxfJFnvZa5O/CKEs1V1i+wzTwAILJwHumzKNk54ctyqo4KDijF2oHS3EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081968; c=relaxed/simple;
	bh=cbhrnwky3M1OQ4/1gR5owBLQRKaVFV0YFMBztYNU3MQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZI5wo+ft/FLL9lqR5fEImBd9UzndOKJXqwHEws0YcEBoNhYPvBHW0jlUALirg04NPUeVUWZp90XZ/uFQbH+Hu739u6BX6iqoeQAIL8masUDrxgZ+zjxif1QEJksuDJR8QJB7Ezg+zuEsCHBuzMOex66Cwf6NElWmYL25SQGkgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bOpDkz0j; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bOpDkz0j"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493ba771d1bso4943205e9.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081962; x=1783686762; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qmGplZPZ08UUT4GJp4VHEL7joXJ434YzWEyzXagN1Q8=;
        b=bOpDkz0jN1yVHXz74p9xakQKO9/Gy3S2RNpAb8ljvsq4sTC03oOQxb1PR6bMmAy/kP
         olP6qw4Ge3RP7BuDbDDuWxNwVgUmj+Ca6cHJygi9ySmuPZb1C0n3dS3ZIhF4JZRclVPf
         obpgnTfFQt8YFE4l6B3NrzfKIxD55romjdg4LgPZILYJDsBIJo2PVMSTMNqQzHyhOzqh
         TQGR7TmcC53gmIfGnTjwkAK8iwIFBTQScizdPslQiURRsDAB+xOKOxs0LI3agEd5XtA7
         iN/G5/a27ytNqUC2tTnoLo2pulATY/EvGzpVuLmUcjoECShxan6SMZet5T6IYP3MM5ku
         DsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081962; x=1783686762;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qmGplZPZ08UUT4GJp4VHEL7joXJ434YzWEyzXagN1Q8=;
        b=Pd72uMpeG9+7zApEba2ADCxkifw9Qed/Q00wh8t9ronLg4C2iVUvJjtbc1AwcoF8L7
         CuL90JuEOIUMBq/Zvm7ERtAR6Qg2jYrTvBqPCbMvcdz40rnQjebP7QlWTGXIFg2kdSVc
         qlOXXf16OBCbufIc/Qn+UzZqsMDw8sFaAHz31Ip8K1Y2pPUmDBSuDOYkNtzNF3KOb0Td
         fQ6nhTNKV1B6jz4NyvPNUvIjl/3VX3QeR/oDokqBn+oEHdM2KXt8dzP8KzENPVRNBeo0
         uFEzrjFmKaxtNTIaKso+QVfYrRGLbm3kJFYT9wv8KdeEL1T6oabVnFEXvyFNMV9qJUNF
         f2wQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ZDc3ilvBIDWf6eVFKqheEosqkhNi+KS9kxqGYQBODM9wj9zk+5odKOTRKWovCdXqN6AFFI8alQ4gbXoEkwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw78Ryaw4zAJ/I5uSbY3PjqbHVfh5KTtIhm23kxFxogFms7ReZP
	nW5LkOLC0XeY8A36FdaXW3bDPeqPF3QmKB07yMP5jOMxQ0mtYuJ5Opl7Dv07LdegMQerruSSaz5
	jKLOsmxrqyCAw1w==
X-Received: from wmok15.prod.google.com ([2002:a05:600c:478f:b0:493:b78f:716b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35d2:b0:493:c3f9:65a2 with SMTP id 5b1f17b1804b1-493c3f9664bmr156103915e9.5.1783081962154;
 Fri, 03 Jul 2026 05:32:42 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:58 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-18-c87b714e19d3@google.com>
Subject: [PATCH v5 18/18] mm: factor out can_spin_trylock()
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
that would be a shame. But if it goes in some generic header, someone
treats it as documentation about where it's guaranteed safe to
spin_trylock(), and then it emerges that there are other subtle
preconditions that didn't affect the mm usecase, that would be worse.
So, just be conservative and keep it local.

Suggested-by: Harry Yoo <harry@kernel.org>
Link: https://lore.kernel.org/all/397859cb-b127-4cc6-9c71-044afc99bf0c@kernel.org/
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Reviewed-by: Harry Yoo (Oracle) <harry@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/internal.h   | 23 +++++++++++++++++++++++
 mm/page_alloc.c | 17 +----------------
 mm/slub.c       | 10 +---------
 3 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 7e3b2386e274b..0ae6ad2265125 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1716,4 +1716,27 @@ static inline void mm_prepare_for_swap_entries(struct mm_struct *mm)
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

