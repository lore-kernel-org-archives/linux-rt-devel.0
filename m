Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6463B47F9
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081950; cv=none; b=W5OezYSC1ErDVoz9EjUW1UZFHbSU7g5UIo4xOLFd7aI8jrJDPBSikessUbg582sjJumZpuuA4fypnzF7L1NkPGeEPHEFzaGIKAH3YiabS5hUmazyK6j2VnVwWr3CplwVjGWifIoUNnwFfx0Wnz36wN0evFyxXr3fXFoga79I5po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081950; c=relaxed/simple;
	bh=YM3IhjKB6RosE8HNpfsLrnIPcX3YTIhpKGMzWSEpSws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qzeK17KtJdJTezAtvc9hoci0fPDTRTrbcC7iZRihwFLn62AKRtnN05GC/ZLWGDTC7SDAYg0SqRtCLmKuLfyg/FPp+xlXRoXT3lhmfrYFc60m7k9lcoIoLchNQ8lj9iFp50fnBIkwIBPIR1iqR2N9yUHM9MrAIepxE0G/UAJDSrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ooqv50Hy; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ooqv50Hy"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-c12dd729b4fso29567666b.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081942; x=1783686742; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3NbrxmcBD9wRA2EoZZ8V+E4lVFkjGW4tXUzXfNK2+Y=;
        b=Ooqv50Hy3ALbmqbg2KsOdncfvAPkHifJIbfDQQWT2BvJfriPEzSijtxcN3tzOI3ysf
         OENMiONdn8M6KsEBdRufL3IfwtWsR81i230xoA8zHs6KCZAbe1VhSq/wrjTi+bfXW94n
         Szppq1vLW4RGsFi7NdtUQRneqzLUBb/i5zq9nPgbPbKbbLB5qU68VxkINIPWzvXwBf6M
         QfqCvqSmJGVQYtG1u5/yqpo1IjotyaHIq+mlVSUwBSsvzDpqcCXnyjvlKr5vfMv41+i+
         6AUxync7ooVZkXznXUkgsudOle/EeMc94oU37L/e0Sgmsc5Od+kJ51CqY9O/sMZvO1n4
         cOxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081942; x=1783686742;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3NbrxmcBD9wRA2EoZZ8V+E4lVFkjGW4tXUzXfNK2+Y=;
        b=KO2+jjBwV2hLqB3tPvB+FNY2frZzqd+hawjhJXhxmudwG4ZbjpxCs8JpDnwDr+Y/82
         n+CZlYD/hOMiBYF0jnI7cmqLAzNXGy7Y3CLfaEPz5CocxgZBt0N5Y0Rx1AXqHZqi+t1e
         1hgsw+Ml6Aj3ybu27WrVYCRwBpfH9XP4v3HlhBfdH/3M8Lrg7H8pj23jgSFllNJ7GIS7
         eA45Pw++oUCLR3m+/3Pk4w5laaePPLu7LZgNnPuWbni6O/O5twj+fQ6RyGgLdMfF8YPF
         lNXMIQD9yzp/I6kB25BzvfspgeQyqNTAXR8d2VVV+j+7EoZlpbV2xd38CEG9khS4sfoS
         Vkcg==
X-Forwarded-Encrypted: i=1; AHgh+RrcP0H8xdBPTms9c3Rx/GxDoPcPCK16PxxpoE0SgTMs51A7GAr1eAuPAFFW0+vMoJ9cvZfJPjUUibwPHUWwlQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwhM9BH3crXi7A7l++MPcE/7WTwlPU099A72OmaixzYYydUZVq1
	cJuBJ7+A2m7cOofkh3NY+O5ruz7nOp28h65aj6nwQhdfkH2g8MjxYosb0/pRdYK1l6sa/ko2C8H
	4wrB1seAsxVN9Vw==
X-Received: from ejcho12.prod.google.com ([2002:a17:907:e8c:b0:c12:70f3:db84])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:99c4:b0:c12:b301:13bc with SMTP id a640c23a62f3a-c12b301156cmr388781766b.19.1783081941979;
 Fri, 03 Jul 2026 05:32:21 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:43 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-3-c87b714e19d3@google.com>
Subject: [PATCH v5 03/18] mm: name some args in a function declaration
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

Checkpatch complains about this, a later patch will move the code, fix
it so that checkpatch doesn't complain about that patch. Do it in a
separate patch so the "move the code" patch is trivial to review using
Git's diff colouring.

Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index a2b09a13735bf..1e252678bbc91 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -919,8 +919,8 @@ extern bool free_pages_prepare(struct page *page, unsigned int order);
 
 extern int user_min_free_kbytes;
 
-struct page *__alloc_frozen_pages_noprof(gfp_t, unsigned int order, int nid,
-		nodemask_t *);
+struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order, int nid,
+		nodemask_t *nodemask);
 #define __alloc_frozen_pages(...) \
 	alloc_hooks(__alloc_frozen_pages_noprof(__VA_ARGS__))
 void free_frozen_pages(struct page *page, unsigned int order);

-- 
2.54.0

