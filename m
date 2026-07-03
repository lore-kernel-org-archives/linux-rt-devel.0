Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB023D3CE4
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081966; cv=none; b=hfTXWOpLZhjn8+KqijQcQSBxVdWk8l3TLvYUm9I8KBri1p35W4j/B3HHmNyh/ycLYZy3nvJHZEKI2UBn9wWmzMsTCJXukTEl5ZX72UVXXxvVzhvDn1bczGH0neym/q9Me4Cz+AlspwOeywEQq7eKctB/4WrUUH6jE2QbteGq3lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081966; c=relaxed/simple;
	bh=/Q2AlTOSzVbcxT32hKCZVSIdoKxcQYXgEjJH4UkdlV8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fF/F3AB1vzgRRewhfr8DYb6ELds/yxexdZf3+EI6HJ/vrXGyKO555Lk2SKOtlJsCcNcA7PLIX2Kw7OKFphPMsx/1KlKpqYajuSuhWNMJzXf0EDWhOCVQ9mH2ZDacNpn8N6AW08jPd3B7FVbkA9UD6cWSiYOuBLGIcV/6Pln12Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBBN39d7; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBBN39d7"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c092c622e15so44887266b.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081961; x=1783686761; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bD9d5R/Qa5BcsyyPmIa4YCQAd3/CPOGQg2JVFAI3c00=;
        b=EBBN39d7MDfoD+mQAiQBRNUXj+Ot6eAE/8c6ehRNbyX4jk+Of5ori2UOagHMv6wVC1
         TkqVCPHre1f96c8iXZGN/rpcUXzw8oIbfpuTyyRVLckO0BCYHh1egKr8+tj2AOADln3J
         DHHDPvVPmPTVre9jVwsaAEYfydn6PxUCzcwR8vf+eobBIfMDZZY/lHcOVuVHT1nPkQHP
         jlAXbu29EJXbRrKfOGCIKvCvZTFu1+pC5411C2PvLJWCtjptwnADE/hzw2HC/k+RcOtz
         xXPfeQlMikDhEtH/IJu9MLphCxpVTW2tMa/lmepeCiQcJsXNml8FpOJn8Le72CXkCgUY
         QeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081961; x=1783686761;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bD9d5R/Qa5BcsyyPmIa4YCQAd3/CPOGQg2JVFAI3c00=;
        b=Kxgc6Uf0hvXdV4L5CgA/0yhuoWoNffmN9N7+ecnwAuy/oLkROW8S1P6MIC69m6uqLC
         DFBYXAMCtYeQj4/cTKHn4yBuEeGv6QNvP+4QciU/tkZzjVT/njZ6obW8ykdWF8b/1UAR
         3hN0kEMMa8ouy9sKpBcrU28zoYXOnsQ8M3sLH1j0Mtyec6RIE4o9Dsc7VCbuY+LA+/Bm
         RKXp1tMwcUfHS4Zg/usRHHtW8pe5klxtn1Oo7X+NC157XimtZumze/mArIJU3yzwc6hP
         mbzoyUt5fIdlwjV+khR4EMg2jNKUkgtI570qyzc3OtWOy1CFBK+gl3ttGXNGqUYhg+qp
         pufQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7R2qmpBwGjvb+dQRspPCveNar1rp+R43Z3InZY37mBEOt4KVOijtCmsUdO5D1MkNi7hqTRDGMke63u7Zh8g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzeuRxTFtKMMn8CF5wdi6fo51I+wbhtdvhvOlbliITbTRzMYdNw
	kaTtrtkR81W3dEdg77vkkeSlwy8nmCp6yQw6U7rmW1hhwGEJGxLx2KSHGy7Huyo1g+VmTX+fDKy
	AbzHxt07YPkeIZA==
X-Received: from ejblz6.prod.google.com ([2002:a17:906:fb06:b0:c12:58f8:f86])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:fd0b:b0:c12:9692:791b with SMTP id a640c23a62f3a-c12ae79a0eemr441027266b.37.1783081961027;
 Fri, 03 Jul 2026 05:32:41 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:57 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-17-c87b714e19d3@google.com>
Subject: [PATCH v5 17/18] mm/page_alloc: drop alloc_flags arg from alloc_flags_cma()
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

To align the style with other alloc_flags_*() functions, drop this
additive argument and just have the callers do that themselves.

Note you can't always freely or alloc_flags like these callers do
(because of the WMARK bits that encode an enum) but this is fine for
ALLOC_CMA, just like it's fine for e.g. ALLOC_NON_BLOCK returned by
alloc_flags_nonblocking() and or'd by its caller.

Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Link: https://lore.kernel.org/all/5dcdd1ef-21ad-4ed0-9e8a-0e5cf96b4392@kernel.org/
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cfaf16244f56d..c3b246e67ed14 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3775,14 +3775,13 @@ alloc_flags_nofragment(struct zone *zone, gfp_t gfp_mask)
 }
 
 /* Must be called after current_gfp_context() which can change gfp_mask */
-static inline unsigned int alloc_flags_cma(gfp_t gfp_mask,
-					   unsigned int alloc_flags)
+static inline unsigned int alloc_flags_cma(gfp_t gfp_mask)
 {
 #ifdef CONFIG_CMA
 	if (gfp_migratetype(gfp_mask) == MIGRATE_MOVABLE)
-		alloc_flags |= ALLOC_CMA;
+		return ALLOC_CMA;
 #endif
-	return alloc_flags;
+	return ALLOC_DEFAULT;
 }
 
 /*
@@ -4526,7 +4525,7 @@ alloc_flags_slowpath(gfp_t gfp_mask, unsigned int order)
 	} else if (unlikely(rt_or_dl_task(current)) && in_task())
 		alloc_flags |= ALLOC_MIN_RESERVE;
 
-	alloc_flags = alloc_flags_cma(gfp_mask, alloc_flags);
+	alloc_flags |= alloc_flags_cma(gfp_mask);
 
 	if (defrag_mode)
 		alloc_flags |= ALLOC_NOFRAGMENT;
@@ -4837,7 +4836,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	reserve_flags = __gfp_pfmemalloc_flags(gfp_mask);
 	if (reserve_flags)
-		alloc_flags = alloc_flags_cma(gfp_mask, reserve_flags) |
+		alloc_flags = alloc_flags_cma(gfp_mask) | reserve_flags |
 				ac->alloc_flags | (alloc_flags & ALLOC_KSWAPD);
 
 	/*
@@ -5070,7 +5069,7 @@ static inline bool prepare_alloc_pages(gfp_t gfp_mask, unsigned int order,
 	    should_fail_alloc_page(gfp_mask, order))
 		return false;
 
-	*alloc_flags = alloc_flags_cma(gfp_mask, *alloc_flags);
+	*alloc_flags |= alloc_flags_cma(gfp_mask);
 
 	/* Dirty zone balancing only done in the fast path */
 	ac->spread_dirty_pages = (gfp_mask & __GFP_WRITE);

-- 
2.54.0

