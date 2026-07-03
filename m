Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E753D3CE3
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081965; cv=none; b=qjBM0M/GQjQ7m3pzj81ovw4V0a1nFlyHsDFNVV82nBfAf4fgJlcAOjVlWLIJaehpXbkpHLFsgiHr3EU5zzsm9vGUfQx+aX7zN2LRQIxdn7NBtGe/2Xeabg7t1eSIfyZznw8Mo/E61nM3roeK2gwRS/8970/oo3SFsEYWl3Q+IyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081965; c=relaxed/simple;
	bh=gjlIxPgMeedEPJ9k/uIWaq0fO9Ob53kXRuNpoa9e5KE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hO2UBrR7XlJk/b5qBoLqYz/MtCZIePYvi56QNkFxoyTYGSuk6iPekcF5Ta9/DuFnjZXSKtSgq5IrLKltaDbvLCZ9kR+GK8EU0L8bkufiyyXtv4pdBPOw+uThj2c+bAW1gxE97Vi+k8n3i4hs9z5IgPo2BPnhVEjRUgsRf9HUnyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lE4Anta4; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lE4Anta4"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493bd52dae6so3708795e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081960; x=1783686760; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6S3JNEhTHh8S5PWRfrbe8AKMasrMsda1UyR5Zu08tMA=;
        b=lE4Anta4hjCrWfiRBE9R9tVsd4ThkLXqOG9s765gcN7kjincd+GdZROuvd8PNEOns4
         HmpE22yXG7Ok2M+BtOdlikdKZTefvytMUANe4tm+rFiL3mgcvWcC95vEmYr9zKyMZwq9
         TlF1TcsCffBwHHEru74zm9j8K67N0oGrtn7oU3ZMNvmU1jUUbnrYzypsmWy8PQjJV5AR
         0UsyjaCN/1FahSKXmOHsEKNVX1VT8+tlwdUPQ1JaV73ZR6K7wZwIL8kz6uQs5bz6+URs
         kWL5kdKjiKKZ5/OA0ABUyyfC3C7OJD3MU3bwuOIH1QVUjcUuVwOFHr/PpoWhnhztM4zb
         R2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081960; x=1783686760;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6S3JNEhTHh8S5PWRfrbe8AKMasrMsda1UyR5Zu08tMA=;
        b=K6rrtZGx8KAMHOxJighmjrKoub9phQeIM4quWz3Ttc2rUoDoFUCaAedgb3L6BSkBiw
         Rq4UeO4iEgSgtdqSoThkefgIj9f1YeobEpVKEn2rTct8dzaBbEE+2RWst+4Ijk8+pxR+
         F0Ji+tQK6wPmItIIYKLb0zmC3zPI5epmSWMrRsf+NdEp2TrkurmFhH5DNFvAwRaNDhhr
         v1Of5/p7SSt/Vysm0UHXPDqhEuFX6Msl4mMHrJNrT+dr1DueKTzf8nORePj7oIjrlOaO
         /ha1e68gyYpZ56rA7aVcD7esHF3eLpA8cTFbMmHwblPiOB22SkOR3ezBiIIK2wWVeHhV
         YCBA==
X-Forwarded-Encrypted: i=1; AFNElJ/aYLpzFQ6i+v1gS1Y3qPFGZpq9zi3bWdnD2Nbjp8LlAFugdUT4UTeBq2vrU82izohTX39lINHOei4CbIMhEg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy+2iVgIhXB0DUjcS6Zs1wWNW8PRHJ0St4XdOUr3/SH0mR/blE0
	RzhAJiDWp11at7U3zu74vIWiLnAhVhpsC4SeXulAvIXiDFMi9KiJ27hmjueS9h8aJZJwyjb7BL1
	znioh0/yHjfUCPQ==
X-Received: from wmg3.prod.google.com ([2002:a05:600c:22c3:b0:492:4659:9cd8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:34d4:b0:493:b8cf:cc8a with SMTP id 5b1f17b1804b1-493c2b3ccd2mr128779195e9.4.1783081959528;
 Fri, 03 Jul 2026 05:32:39 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:56 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-16-c87b714e19d3@google.com>
Subject: [PATCH v5 16/18] mm: remove the __GFP_NO_OBJ_EXT flag
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

From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>

All users of the flag are converted to SLAB_ALLOC_NO_RECURSE or
ALLOC_NO_CODETAG (from __GFP_NO_CODETAG which reused the NO_OBJ_EXT bit).
Free up the flag bit.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
[Rebased onto __GFP_NO_CODETAG removal]
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/gfp_types.h       |  7 -------
 include/trace/events/mmflags.h  | 10 +---------
 tools/include/linux/gfp_types.h |  7 -------
 3 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 463b551d12d99..190191411009f 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -55,7 +55,6 @@ enum {
 #ifdef CONFIG_LOCKDEP
 	___GFP_NOLOCKDEP_BIT,
 #endif
-	___GFP_NO_OBJ_EXT_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -96,7 +95,6 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
-#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -138,17 +136,12 @@ enum {
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to the active
  * cgroup context.
- *
- * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
- * mark_obj_codetag_empty() should be called upon freeing for objects allocated
- * with this flag to indicate that their NULL tags are expected and normal.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
-#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
 
 /**
  * DOC: Watermark modifiers
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a6e5a44c9b429..c1a05ff0feab0 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -54,18 +54,10 @@
 # define TRACE_GFP_FLAGS_LOCKDEP
 #endif
 
-#ifdef CONFIG_SLAB_OBJ_EXT
-# define TRACE_GFP_FLAGS_SLAB			\
-	TRACE_GFP_EM(NO_OBJ_EXT)
-#else
-# define TRACE_GFP_FLAGS_SLAB
-#endif
-
 #define TRACE_GFP_FLAGS				\
 	TRACE_GFP_FLAGS_GENERAL			\
 	TRACE_GFP_FLAGS_KASAN			\
-	TRACE_GFP_FLAGS_LOCKDEP			\
-	TRACE_GFP_FLAGS_SLAB
+	TRACE_GFP_FLAGS_LOCKDEP
 
 #undef TRACE_GFP_EM
 #define TRACE_GFP_EM(a) TRACE_DEFINE_ENUM(___GFP_##a##_BIT);
diff --git a/tools/include/linux/gfp_types.h b/tools/include/linux/gfp_types.h
index 6c75df30a281d..a93b8bd200b76 100644
--- a/tools/include/linux/gfp_types.h
+++ b/tools/include/linux/gfp_types.h
@@ -55,7 +55,6 @@ enum {
 #ifdef CONFIG_LOCKDEP
 	___GFP_NOLOCKDEP_BIT,
 #endif
-	___GFP_NO_OBJ_EXT_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -96,7 +95,6 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
-#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -137,17 +135,12 @@ enum {
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
- *
- * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
- * mark_obj_codetag_empty() should be called upon freeing for objects allocated
- * with this flag to indicate that their NULL tags are expected and normal.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
-#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
 
 /**
  * DOC: Watermark modifiers

-- 
2.54.0

