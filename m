Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C313404BF2
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738756; cv=none; b=QdcygLuhUSGGStsIU0XjvYyaYQaDqPldorumANBJ53QaawJyu17MXW7ZyUVySVqAi1B8GTWcOj2VETaKM7HrnjdgEqepghxg7d5hjt4xY+RxsrliGbXLeZvVJsm0VYhDn9PMj/GoGZEVgkwUUNaeQ0UaUAAwvvNDsjvlqS5MBJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738756; c=relaxed/simple;
	bh=v1xANvYQvnmxJHHFjHgpmxFCzUHLSMIlqhWk/CKUQf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bu98xzY0nOBAhaSbqgRlliclFTRgBk4fbBRSMuKiLUAazINTj6WIZQFgO6d4uiKgCVUqB4NNwRp3yQZIq27ymFoVovuHCraTa56qHoqVp/WW6F+CdBNDjCaZ5k3GPwvEnz0Ge8K8/W5VYDD1QTOh5Q88QFGXpdfXYJJZM0KyRno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Axa527hG; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Axa527hG"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-4744b72f90bso439862f8f.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738753; x=1783343553; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQupKTDZjED0JSNU6dTXI/Jh97qQEoEP5PP1fd9rJgc=;
        b=Axa527hGHiFipTNa+92oxeJyfW1lNdPm1nRJKIFPLFXU+1zLjJTgcXk9j3u3+FmYfg
         6lakkg+BFeIUmUOoQO/qSzEXw4IdUEr5AZwy0cOnvLo3yXSNqIilB7MGEg6tGqjZ2f53
         qZDyrdHyTNYeNkluCdU7KqNv9KJumBwIBbgCY/WNxNIKEJLvdxvxu+pEWWXaAZUFmKfm
         Vf6JoofvRUISmBMh2YR5m26xUJ5LJp4us4MFez2YBFrGoMbVA+3wWcS2/rsjPFFOm/v+
         JGY5UurT3A5FrpJuGveGssgD6xUCF5nTxYWpKE/MAZ0b4EvKFVMZxEV+akhntWqOieHj
         h4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738753; x=1783343553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQupKTDZjED0JSNU6dTXI/Jh97qQEoEP5PP1fd9rJgc=;
        b=r5bFNceUoGzSGdn4S4y68Ll7Jq7frXSHp5a7E6jOH52E4fEKQCxRGavhZtCqzq3gki
         0h2TZOwJ6CZucDI/t14WD43rxYOLCCAz+WPpYCo/j8/69GlbV0R91pUzQoWpmbFECA4L
         CqQZopghWrklPWphOpVXhd+Y8dFfQYyAVwXT0Wduq5SCK5YtfE4oFTAb6KPw2EkqYq6f
         1KynuiH/OUzT4ih8IqdXfN9meOFuH/5S1RQoJTfpdaX5WtJ6wMYEd8ikaXpvTemPA1Ig
         oT6qXwhSasVrw+Kg+f4m927/spytpv0H7oBoa1JqvuVv+3mhrZgZPvxCyE3c5SklRoF3
         RQig==
X-Forwarded-Encrypted: i=1; AFNElJ9YH7T6xYK3jfblPj6lsxuhigyhB2mRVCNAj5OsK9fVSs9ysXYsq4Cukp1+hV6pi5lPalyq1BO5EC5aCegeDw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9BFBD92QZvE0ija1Cf5fATjwDuA0R9jhY1bFsNtJvaBqpJ3QY
	8DBcCM8aeSs/MGBd1xhNapa/AfWhO8mdjD0Xk4Q8zN6cItME1HvAhYQwZGrAadG4PlhBL6Q9C3b
	vY0kTHeb5Povyng==
X-Received: from wmdv20.prod.google.com ([2002:a05:600c:12d4:b0:493:b21f:6ccc])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b03:b0:490:be78:1861 with SMTP id 5b1f17b1804b1-493b718f985mr10806475e9.4.1782738752633;
 Mon, 29 Jun 2026 06:12:32 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:12:02 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-13-57bef0eadbc2@google.com>
Subject: [PATCH v3 13/16] mm: Remove __alloc_pages_node()
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
	Brendan Jackman <jackmanb@google.com>
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

