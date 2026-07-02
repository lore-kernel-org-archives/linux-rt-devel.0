Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DDD4A13AB
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985797; cv=none; b=fldqx2Ag4X1v5E4GWEql+2flgqrAHmZ2/hz9TuZrkzpqIdzBqtcN4MJczGuqMIEucHASaIjhVSKaj/6QV7HJPdn5hVUBCmb006E7vh0s7ctHyLGhjaDTFpY1L6bbjUzJLmSqH67bm8guv4YM7fA/jb/BpLzN90/d6XyaehFqgoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985797; c=relaxed/simple;
	bh=4JV/dnncChu5h8Yu3gsmWxfntPIFpYV3vfK/cEvVBdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l+t8ppudTL7wj/8zMS35nkop9otdS025VxV38NctLWv1+TzEZZ6wq4c/qK+wZIjP9xC/oki14D+Kp41FACZJfj11M3LthKNGpcRrlHIHRsuy4BTQ9p/FGTSW9P7oA/ROAdmIuYiztMXl9SSD6DS5m6D0uNL+jx/4swf14oDi8xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UirOFOVH; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UirOFOVH"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-493bd52dae6so10744645e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985795; x=1783590595; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSxEwrSlsWzCUsFCp9f9B1Fd4DZM61HmbiQS7KAxRp8=;
        b=UirOFOVHm8bztaVPjPaiG2LGMpFUp3QH13qpizo07cbrjSUhkLFR2xIJWbaEy/lO4u
         XKxrbNUQGbXqedTcw+8FdCW/6Esecuh8Kd054wVyohzKpXRgdfn9Euj2reB9HtdvudqB
         Y8TzP9YctS5KdgPOE0gkrvYJQLE4TqPZbUHPoEl4HzxViSOK/vw31IGVr7UR8XYvWwfo
         f4IaiJuJZwZlWzIE9WaeDFqEaPdKXBUgrEcBh9SIkY9cmxlP4+2kc5Zb22XBkAUd1GpY
         F7v2cy2CQsGXTeYjjxo4DaR/3uBTwYtExZFWiQO0KBhMW1uVo1tG2DHUcaAIXBgfBFPh
         YKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985795; x=1783590595;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSxEwrSlsWzCUsFCp9f9B1Fd4DZM61HmbiQS7KAxRp8=;
        b=mTecLRVxAgabRqGlqMDfcljupIY/qHo9sJ/V0INLg4MK9HqpnyeZ2X0y1akUy/3DEq
         1vqyrd4NbNfC3+WSJ7sY5zTtJMoSPT6Sjey3PmCSaq2IorBWypneOs3OTSIyhBfBlvzk
         oN83XMN9oH/S6bLVIyhzTI/TdZ/rFZ675bfmT4Xfax+6O16hpZcZocnadp47Hk0Fi1uU
         z8HuR+Xp3VcQ1C3dohu/kQNnTRauQnl/4JOrYH/0oVcfbM0OqhSyZB/+xXjsX7WVHVj5
         uHxWZq9f6T3Cxw+RqB1xGhxr/rdChvDEShPXDzt9GLABUgqf/NAT699il+4J7zGBQkqs
         tHlg==
X-Forwarded-Encrypted: i=1; AFNElJ+IXqcIjP0ZAy0Qz4nZ3AsnsFQh0uglMeTch/TgJSagU3IqXHELmQpJY1SX1/VjgElIPbu0RV4ogfzgd0HiOw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpnJD8InWQa28c52WGO/Bu5aOkQHwByNw0E9pAqMtHDC9j+fsO
	Eeb2rgkxAnLco0CC6Jk1UbEWGxgiSVSTJexrAfJmfaguJuts/wtinbn5pYUqwvpvwx+5Nyx0slT
	rRHUcDIvOts91dQ==
X-Received: from wmim5.prod.google.com ([2002:a7b:cb85:0:b0:490:b1af:78f3])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6a8e:b0:490:bd66:e523 with SMTP id 5b1f17b1804b1-493c2b7f3bbmr54894255e9.20.1782985794289;
 Thu, 02 Jul 2026 02:49:54 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:37 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-6-0af8ff387e80@google.com>
Subject: [PATCH v4 06/18] mm/page_alloc: relax GFP WARN in nolock allocs
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

This WARN forbids setting other flags than __GFP_ACCOUNT but we
unconditionally set the ones in gfp_nolock so they are certainly fine
for the caller to set.

There are other GFP flags that are almost certainly fine to set here;
Willy noted GFP_HIGHMEM, GFP_DMA, GFP_MOVABLE and GFP_HARDWALL. But,
nolock allocation is rather special, so be conservative to try and
ensure we have a chance to think carefully before nontrivial new
usecases arise.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Link: https://lore.kernel.org/linux-mm/ajS96fWbG4dzP3u3@casper.infradead.org/
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f47a848555077..c2839959d7908 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5355,7 +5355,8 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 		return NULL;
 
 	if (alloc_flags & ALLOC_NOLOCK) {
-		VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
+		/* Certain other flags could be supported later if needed. */
+		VM_WARN_ON_ONCE(gfp & ~(__GFP_ACCOUNT | gfp_nolock));
 		if (!alloc_nolock_allowed())
 			return NULL;
 		gfp |= gfp_nolock;

-- 
2.54.0

