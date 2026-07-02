Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323524D9902
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985810; cv=none; b=GQV/Z7fv5F/lM+gKuNwe38oaifvX6wH9emkXHlfZi8e7HMaZWzj9UuUTr99AkvX8Y8Zdgn+HqUxr+eiQYfHTqqZISkbhZg8f6FD+al6xhzPQLrXszudaNM60Cz8dpNnVzI/u7TTOZOj+JViyk87EHpRdFt+ljtxCsxQhe+pO1oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985810; c=relaxed/simple;
	bh=gjlIxPgMeedEPJ9k/uIWaq0fO9Ob53kXRuNpoa9e5KE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s4CCst/ASRFgXF4ukIsyhML+6EbcB4f+CWk1h9QeMVmSvVjkzyk3mf/qVCtwMQvY86wKMeaExqtVutZIGxWmuigzvHd/+s/IcUYWkF+d5TlKr5ND2kLi0jfr2ikBCxoaUjW0N/hXiT8VN4LyF6uZLEfKmn9/Tcy090ID5saSWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ezgwanoj; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ezgwanoj"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4925bf70f5bso14470815e9.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985808; x=1783590608; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6S3JNEhTHh8S5PWRfrbe8AKMasrMsda1UyR5Zu08tMA=;
        b=EzgwanojFcoBgAzwFQuOcjLvGvuAN0FMTj9pfq5jLtZW47kIQITjSUcixGy9Oe2CNq
         lcnpmq0epmHMn9YQGyLQKAUcivTjrNTP/VBNNMYDO1qZlv/V7rNJ4ysXW9d/RmriSU8I
         snWAaEm4jYpV8+caVf5GfYRHjRPTZTPgegEJW9CP7PMLCFoSsXzJKycth52AjGSuaxVO
         eTkW5PFo5179LjdzcwNRRwY693COLg1XvdJBy+/qMUfxnh8T5C6aOGnpo9MJlJ8oYDR1
         Jrhv8fIvKTuGQoJIMLMo7fiJbD7tWkpIL6QX1GYRJz37kvfi7/CBzeD20Y20iHiqfxDO
         KyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985808; x=1783590608;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6S3JNEhTHh8S5PWRfrbe8AKMasrMsda1UyR5Zu08tMA=;
        b=Z/XHM1XfLpATMyRI14hxUga7UDOOHsnscNCj6DTl/Q3qn8GFIOlr8QlGtq7l0eXoAS
         m670+hs/DrB63zXbMG44iNUXrGk96GSgF2x5un0ko3mV+iB2dHbaE/rj7FvZFHZYSxaj
         ad2OcZby7Q08FvV4MhYEEy69BnlpeKqqmz4Kp1hL1l43X4e/UCtI6HzDWj9se5iSsMCm
         NRyMGqknkBvO5H0QfP0LEwBwYXJiz3Df733IM7D2pv9apao78nRmk6ArriZJ8/pXzeF6
         0Sl96u57Md6HpTaWgw7ZIKYX51qMjrIuaqYQKAfYsGIZ8635vhlaxkI6K0py9JQuqNWW
         dqzg==
X-Forwarded-Encrypted: i=1; AFNElJ9A5SgtwCi02bSE0Wa5oifAmCNcHN5g/yo6bwHSbWu9TaN+TipBoi/F6DKVN+iLOfWsEG+B0KSBQqHsX9gxDQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzo07aDZd1LPPb0iKaqQsaXk+Q4PAD3/PiPvuhkCdmfjzLXSHy4
	3Pt8E+LwbRVcjgyiakDdgI7LZzSmLJftCfXARQCowiqSFIuu6S+xEelCzPkXmgEt0dgi6tDdaDb
	/al/qXsl4BhRs1Q==
X-Received: from wmdp9.prod.google.com ([2002:a05:600c:5c9:b0:490:60cd:352b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6c45:b0:493:b782:10d9 with SMTP id 5b1f17b1804b1-493c3cd9b8dmr44954545e9.10.1782985807257;
 Thu, 02 Jul 2026 02:50:07 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:47 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-16-0af8ff387e80@google.com>
Subject: [PATCH v4 16/18] mm: remove the __GFP_NO_OBJ_EXT flag
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

