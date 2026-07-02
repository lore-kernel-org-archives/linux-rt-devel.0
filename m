Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8CA4D98E3
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985807; cv=none; b=Vhe1F6zB1CWgh1jf8VNYE8SphdsyCvHhST2IkdkqvygiyM0e6lFK2tdvwYdxsfxyUTzVsJm+kAo5VW/cG3At2DUYRKhJNk0vR2rUGkesImZDskTtd2qTFSG9VaXIQSe4OeSbn7nSigfS3mOjUTHiWQESFrF4L9v9UztUHNNq38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985807; c=relaxed/simple;
	bh=etU0KmQ93MVQ8p8e74J7jmNSb0FdCttGT65sD7BwF2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sc1rDB4B+Zh9VPR2XOYuf+Vw78fgOHJeRoalqTUgA9neMjCf1W1Q3GoQ0kzRWIuxn1NdNOnLgKdKrSeN5BMxWR1k6dooEiW+qpA/QcFTwb6DxdV2Ag/ihcT+pyzD+iDL6d28vRUWaWe0emHOmt2WR0sWHHhpGI31ug5GNrXb2fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wOPeYHcu; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wOPeYHcu"
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-39accc98fffso6609001fa.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985804; x=1783590604; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxUSvpYnRk7TPJu9DIAcrJg+2SEdx9XX7++N/RbsLUU=;
        b=wOPeYHcudMwC7sLnW4QVGc07xUq5DaNwptz6Se2JWNfVfX5SGRvRa9vU04cKgE8ur3
         Xj1sgj2Zz058S4ieiO/yAbXIy8+iSE42j4ZkZkC/5p6RuxCdnmh/zJzgGmyRZ8/AiwyP
         mqpoDy2nH5TaM9prRsZz5025ALgB5+dgFx6HhzSLN1mEZNGwRX18C7oqisPYYDw6N5yK
         wYxuNxsNB8S3j+ukUHTKhZa+znVQoHPmnPlmCLEToiCXcf1y+buOp4D/7qhHyLWGHAqe
         a0PZgRAcZki44SbfjIquAui7dVly1Z655NU64qWXgqToGVcv95UJLiAg+ucC6cyX/Lok
         hqCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985804; x=1783590604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxUSvpYnRk7TPJu9DIAcrJg+2SEdx9XX7++N/RbsLUU=;
        b=E1k3WnEnlX94zjpCNiUxveN+GUSu9pT/AlCNTyJK4uG1lBI9lyhFJyj5R0RnJdbVv6
         Ga1nSldrnFTUWjjY4NDn3JTHSZyxzUJVlGZ4FiTBCXx1zjWJeWPiXiCLfgSbAcdWY+9e
         nYrqHG/e0yRG3rFacGOTDTMCOM18MCPs4lpYUWQjcIdrCePLA7kqjm5wK4D3SDm/MIiq
         VLxdPUcPaQ1o/tLmzCP850XrpjgsGn5wfj/3ht8AmEIGifY03Ynn6SX40kMELp9JwyT2
         O2ClOwn1tGErZL6SMiYUFsPgJ8/WmydBOd6TtkmbHkGFCkzmvgypk4mafh+BMz3EUJZU
         Bcjw==
X-Forwarded-Encrypted: i=1; AHgh+Rp3ypqgVaGmgnE7MDNyJuPlUlaUHuT/PZ3ebuObhMgpYVU3Y1taUOrUimfa1/gD1lP20c0xysZOLCM67u9HUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwS80EbD6YqYZ3YqdknzrDTXne8TJ0aeFaDNl7TnPp0Se5nvAUF
	cjKRiEUXr+7b/MbhnuLMyiZTbuBWbd/OfO4RI7tc6HmMMy8i6rUuptsGL77dzqQbKdbAy0x1y0c
	VJLyhCczHxsS4hw==
X-Received: from ljic12-n2.prod.google.com ([2002:a05:651c:234c:20b0:39a:f395:e002])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a2e:9b12:0:b0:39a:cfe8:dcde with SMTP id 38308e7fff4ca-39b37005de1mr6442781fa.30.1782985803272;
 Thu, 02 Jul 2026 02:50:03 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:44 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-13-0af8ff387e80@google.com>
Subject: [PATCH v4 13/18] mm: Remove __alloc_pages_node()
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

