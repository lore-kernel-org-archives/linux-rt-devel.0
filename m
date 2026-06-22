Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE53A254C
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122520; cv=none; b=ohmjaQ/2iooobM4nzxeJA3Vq4ZBh99ZFhpe55FKseW4nn//duD52ORKaOH9uAkIrm90hC59uCZaHeqlwUQ+OZ0OxTrO9hgTxcu/H2bjJipw1O76ymNV8qJCmvoX0FcCZ1y+49aIiUWkBbrJDivJJqwf6P20TrWbqFzTD5EpxQHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122520; c=relaxed/simple;
	bh=qN0Xs4C8ZeZVlsVBF6rIjAULLE8cWjNyo7/3Tdx+cpQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FfKnA9bkYpjv2hKw7ga9o2mq0m6dhb57+/5TzMkV6HPREuIIT6IzBbFMgSPdp9KIaEii5pO0KLKI7SjDkXp9Hz2PG6BMl+fG5MUPSfyHX+NE+Pd1nLDfuXD04V4EbDePsQAfjbyNyfCRxqb0KnWPDOjx+2qNsq3Df2rzfDUXkzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S7R/oniE; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S7R/oniE"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-49244130073so15452745e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122516; x=1782727316; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9FrPB48FwcDezsnLpR3fJd40Qt1udKU6vCDBpIqP+Xw=;
        b=S7R/oniEjuUoysvGZMqt8CRiOMs1Ld6ejCuM9g3WyKzxUwv1wPbR09Rq/EHkpyYh76
         qRlfky5I09GGTiMgCXcYpkN4rDbZqdcUd7XIp3R3KKIdaa1V2Q+VXAguytjf2UWpDIXV
         SuwbGmbRUDds9yKwYTcvUzYcTztFAsxi9sjNkzWpQx3c6M8zfvkEsnkY5UBAU3rWFjFb
         D2TqLht/J6LlN+94p8OaX9H8rKak2IpytuCZafIlbGYjZSu06cohwjQpBrZBUJI2ez7j
         jHur1KMIzz8kgI36TVSm8Woja8hWAs3s1FHoH6IK+hnTa1jFioc9QJ5VXPQkvecQA3i4
         sYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122516; x=1782727316;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FrPB48FwcDezsnLpR3fJd40Qt1udKU6vCDBpIqP+Xw=;
        b=SS6igiCEkcwpjqjozmZWE+x9TJyzdtX4uJaH2XxjGRDg9sEPjtU4g/wKPXBKeJHP2C
         u8N/2KnPnsY/HvgUgSQ+J5NhJVTLs7A0uO3vjuUH73OvCVUXjjXuIFo6B/X+kTIFy/EE
         1Fdqdcmdey0mEwJJ3Fn/jEsCHvVvAt7JJt9tsAgv8h7coqgSxYFZGHMHIqp5+w2y7y1u
         p092elsNXCjHE8QYXHuNEYqinOpTSBiKTYGyTxRm1FMpacGcyuILs1s9gcive+6LjUEe
         t/fnfgyda/VOHs7tR4L/R/DgWW71R/BfmSXwFs3L4hl9XtcDBtJSXSVxgQRlSGm2vI4B
         TGEw==
X-Forwarded-Encrypted: i=1; AFNElJ+H3EsMdaP08uDJtjhj0YIpXrfmHd/jcH8Aj7A1APQ4QCwqxiYH6J/KInYYeGzHqEA/hcdlEJhsqx+sZscc+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzhXoWRKqv1HTHIXJjYYIIhfB341y/UIoHI/4HKCKB45rqfCtC6
	i3KHT/VNVhHvDKc/6nuvhZy9Egq6s0RJYRkoG4unJj4uf+D8SMOkkGsZdJmuET9mjlFDXu8bv0M
	z1gSs+MCpjTVGXw==
X-Received: from wmbe25.prod.google.com ([2002:a05:600c:5919:b0:490:7229:9747])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f92:b0:490:a1dc:e542 with SMTP id 5b1f17b1804b1-49242314217mr179945285e9.6.1782122515233;
 Mon, 22 Jun 2026 03:01:55 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:37 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-10-31f31367d420@google.com>
Subject: [PATCH v2 10/13] mm: Remove __alloc_pages_node()
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

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 include/linux/gfp.h | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index cdf95a9f0b87c..7edcc2e0be9ce 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -278,21 +278,6 @@ static inline void warn_if_node_offline(int this_node, gfp_t gfp_mask)
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
@@ -315,7 +300,10 @@ static inline struct page *alloc_pages_node_noprof(int nid, gfp_t gfp_mask,
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

