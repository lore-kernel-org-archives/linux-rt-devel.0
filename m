Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A833D522C
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081962; cv=none; b=qINsSWoi3Pmu6CccoCrULQQ77SQZqXHPDdJRf1OPKSgU9GjdhN+Tzb5Pt9/bjYO/jyhWx8W7OuBGNKcdtlHuEK8MmdIwo1GQpgOnM+LPuE1frtvWi5XmvqfdroflLtrKSPhk00F+3FirQ9wENOoPi5exUFxOdLe1XdhRyjADh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081962; c=relaxed/simple;
	bh=etU0KmQ93MVQ8p8e74J7jmNSb0FdCttGT65sD7BwF2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EzeEdHlgbnTHPuxy+q3ydJovcWwVjHqFQ2ZZ3j56po2zGwUTtSlG9Pf/hP2M7LkZl6NUmJ5x5A5Efv03b1yDnGdgqceOotJftgNgFAUWvsrm/lccxH+Ga1yHW4OEqOTogTzwC54w6aJuzre+RnPW343U2KCFR9CBBtXCT3PUt4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A9bUoZfb; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9bUoZfb"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-493bc2b376fso3218435e9.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081956; x=1783686756; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxUSvpYnRk7TPJu9DIAcrJg+2SEdx9XX7++N/RbsLUU=;
        b=A9bUoZfbrAbcr8bNrtVEo92tD3iaggq8X6pPni20useNaCtOxdJ0xK7rrq6xPGPZzr
         updqUY4oK6AQgOvXsfvXfMrBVn4VfOI3q98c520Brbq0MOcTFS4wnPnxLzpr1L3qYEYh
         Wtc7fDUuJ92KTXibsCIGqwp8af7Kl3jxMfUEAmddOZkn3tcZe4cxuPcXDerdhNXTJ8t4
         FnUhleo13tZKkrEl+ba3LYGPQ9KdQvCGW2VQNjRldcJd5fjdKHfwI+0HWB24d4VWZ8Ge
         JICk7icTUGf8MluJ8jwoGyWrUJghj48/MuzJgUHMCkr6EipMN+H1lvFeHqoZUoozPDC3
         ykfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081956; x=1783686756;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxUSvpYnRk7TPJu9DIAcrJg+2SEdx9XX7++N/RbsLUU=;
        b=HiKq221wwQagXes0YZWuoNeqqhcn6gMrc0t215VH39Gu9IxaOySJyXodBC8lxIo2dT
         lMxTA2COztf7IzoGi2yt2cUObxKTvCUb9B4DBWl6i6LwtiergCMKaKANylE5gry3LMje
         OGXLWUGKDAnuO7TqiVQSEPoG0gO9I0FDRATrX4ljn0W4z7Vj0BsYIeOuE3P5Q0Uw/ylR
         7V8v9WHLlEG6X1ZwmlT13Dv7dVDXdu9QDWQCrnqKDigWkYcD4cSbPpyG6sSxBWAaGVe6
         qe/+loATt87uyC+eM6j7QtS0cOgb+IszhXRh5SxCbWYDVCsflMHl4CDCfvYhNKZo25io
         4yVA==
X-Forwarded-Encrypted: i=1; AFNElJ/deXzNhj8zeZA8BevCJseERSS1Qtev8UHBW86edMLTKODKUa9TBjBYCvRgxtSpLLyRrs2q1cdGvCbtxwXRTg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMOaB40/pJZKxB+1LHHJXNzHM7jeboL/K3ZCJrY+XKhT8zQXr0
	4pt7wBFHfDqpzomxT6HuvzJi+oytQadT15QsYLsI832fBFCYbjXxDdEf+CoYsh4qOwmRq0qCv/z
	UUUd2LuE7asxyMQ==
X-Received: from wmdn10.prod.google.com ([2002:a05:600c:294a:b0:493:b4c4:536f])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5d3:b0:493:bd37:1cdf with SMTP id 5b1f17b1804b1-493c2b3d40bmr104790495e9.2.1783081955851;
 Fri, 03 Jul 2026 05:32:35 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:53 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-13-c87b714e19d3@google.com>
Subject: [PATCH v5 13/18] mm: Remove __alloc_pages_node()
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

There were only a few users, which have been removed. The only advantage
of this API over alloc_pages_node() is avoiding a single conditional
branch. The disadvantages are:

1. More API surface, more sources of confusion, more maintenance.

2. Worse impact of CPU hotplug bugs: most users of __alloc_pages_node()
   were using the result of cpu_to_node(); if the CPU gets hotplugged
   out this will return NUMA_NO_NODE. If one of these paths fails to
   protect against a concurrent hotplug then page_alloc.c will use
   NUMA_NO_NODE as an index into NODE_DATA() and cause some horrible
   memory corruption or other. With alloc_pages_node(), the code might
   just work fine.

Ulterior motive: this frees up the __* variants of the allocator APIs to
serve specifically for use as mm-internal API.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/gfp.h | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 01d6d2591f49e..3bf55a5f9143e 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -256,21 +256,6 @@ static inline void warn_if_node_offline(int this_node, gfp_t gfp_mask)
 	dump_stack();
 }
 
-/*
- * Allocate pages, preferring the node given as nid. The node must be valid and
- * online. For more general interface, see alloc_pages_node().
- */
-static inline struct page *
-__alloc_pages_node_noprof(int nid, gfp_t gfp_mask, unsigned int order)
-{
-	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
-	warn_if_node_offline(nid, gfp_mask);
-
-	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
-}
-
-#define  __alloc_pages_node(...)		alloc_hooks(__alloc_pages_node_noprof(__VA_ARGS__))
-
 static inline
 struct folio *__folio_alloc_node_noprof(gfp_t gfp, unsigned int order, int nid)
 {
@@ -293,7 +278,10 @@ static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
 	if (nid == NUMA_NO_NODE)
 		nid = numa_mem_id();
 
-	return __alloc_pages_node_noprof(nid, gfp_mask, order);
+	VM_BUG_ON(nid < 0 || nid >= MAX_NUMNODES);
+	warn_if_node_offline(nid, gfp_mask);
+
+	return __alloc_pages_noprof(gfp_mask, order, nid, NULL);
 }
 
 #define  alloc_pages_node(...)			alloc_hooks(alloc_pages_node_noprof(__VA_ARGS__))

-- 
2.54.0

