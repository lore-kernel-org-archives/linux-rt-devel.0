Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECD726980F
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122511; cv=none; b=jAt4EQE2rlEDvDD1guiKyWHUmRXHZ/ki0JYFK8hiQML0GtSrIMlLrx8LkYDHlC/i6I3GrP/9Dp5dHSoiGERQUqp+e4ycgR2f19/4CBsKm1iAwq/YVQcP4D/9beV6/5Qt49pSZEoDqzRH/3Eyvs37APDNM4oIH+bCTQYqvbXkvf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122511; c=relaxed/simple;
	bh=D2zL/isK1DwcYPyXmvwNRFN+cwKhi4zjlvZRjHvouQE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OUZo6yVP5dVO8b8DGKMJBnZkUele8q4U0zOo3CD4u8wEWRZEjyHGreX/OKM/JhnX+d1KuXF3TSpq7ZH9vQo60wOAldpY8nqtl2KtVgP0bhYsRbaLCBgjk8WiYia8tvFTVm+e2fXqyvGBIOF6HUaqJ0V0YDGXD8Uqjuh7Wqtmj1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mzb4IAIQ; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mzb4IAIQ"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490b61243easo57556185e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122506; x=1782727306; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KmHe0ClpKecy9d0Nv0FMY1kBXtGrgiG+qiOUOhwXnXI=;
        b=mzb4IAIQ9EUUhxKzPIHxVth9TYzhQ565T2FGTm1Xsprag5YsfERK6uETneNZun2pNV
         2hnGFKv1V8nxnms0P0+4/tt+WQ8zXwq5Kv7DegovjJT9F1z73Afw6U6SrR7l8AlNTeQg
         rGcRmnHVkeYanEI3jJA/lGKsG3sp5hUbbrKfgIa5ho9Iuojg4yu5U5uyhx5+TwYFFGFh
         7y0lX2vutkdoylk8mcUbLC/nZBGJL/T0myRKUrxcgU+e95M10kgF64S5VVcP/EHwtoiF
         UmtQEvw9sSr/l9I3Ei2T/2HAbSM+cSuqoniOaWh+5dui3ZI6Q4+RWgPET+4vzj7KvMvQ
         6PyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122506; x=1782727306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KmHe0ClpKecy9d0Nv0FMY1kBXtGrgiG+qiOUOhwXnXI=;
        b=gw/zlKfgH2j9C+rDH3jhqjJLb4m7fD67GtMTXgWBtx6uUZuJzVEI3UYIZJmv+7BqfX
         oMrVOexKOxd3P0JloPq5//oFI6dM5OJJH05svhErOOz/1goTsfVrQFt3ENLzkwTiJaW2
         c0twkA2VdIEkGc4g4Z9HaHE1+mlztx5ByILyYxU+YEpOAhDcIn6jgdZO8xaPxZrbSRSG
         ZruO9Y7I4cUyZInVJRjz5Ww1kB2bp8G1lbYo9UnsaaEe2f6X0JhhdgE91Emqz+VcFyme
         Ppbv1/X0rTkHk7Qnq9LI4zXljwiQ2b/QTpairjve4Y0AiTt0L0HWYIGRkgRFxqFKmv6n
         ouBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wF9NPGwwaZo5bpiLA5shWnvk4vW4i0n7aYsR3ZQYUkCFQxpuTw7B02h53ugdwo7iai1Q1HwHcrRmYV7DQcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxQG4n5UVWgZnHoYjXZI0z5ZCVqGQM1KitC9jSHiDnhI8mjZYx
	GobuYZuv0vd2oijIv+7tQSSl4OjYD+sJQvZvYLFOuTrakAL9NB61tasouhi72Ybwt1wGA0ge+c5
	ltlBi+1SAamTAWQ==
X-Received: from wmsk10.prod.google.com ([2002:a05:600d:848a:b0:488:a71c:cf48])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:101:b0:492:4050:d495 with SMTP id 5b1f17b1804b1-49240ea31famr152824405e9.30.1782122506179;
 Mon, 22 Jun 2026 03:01:46 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:31 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-4-31f31367d420@google.com>
Subject: [PATCH v2 04/13] mm/page_alloc: relax GFP WARN in nolock allocs
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
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Brendan Jackman <jackmanb@google.com>
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
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e31babe2181a1..074e007bf1bc3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5337,7 +5337,8 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 		return NULL;
 
 	if (alloc_flags & ALLOC_NOLOCK) {
-		VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
+		/* Certain other flags could be supported later if needed. */
+		VM_WARN_ON_ONCE(gfp & ~(__GFP_ACCOUNT | gfp_nolock));
 		if (!alloc_trylock_allowed())
 			return NULL;
 		gfp |= gfp_nolock;

-- 
2.54.0

