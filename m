Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D851A4D2ED9
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985800; cv=none; b=Y2ZU5hC3Fe5Fu2QKrsbom1NgWX1X5C2/zli5XxYSHtwD6KGzZiUYgE8S4mjhSEG4uP5b9YrLgv8cuFqrPS3dsj06ehcOONmlWZZCv07XpE5m2bxUeGCv2/UmkA63po6+Vk/Hw1r/t9tfpbFXQBepgvZoFQ5PFm22uHaL/IuuMrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985800; c=relaxed/simple;
	bh=gAX1ZmzFPfazfApyiQ0SZUESO7aPJSw5OGicaVcGYLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nTj6znLJyCOdASRIguvKnQhP4UEv8qRqAA+29uBBPisJV+14e4FpI3hbKthA/Dc2XpM8zPsAew6P6lgDUPnqufOjb/j1msXXhhCjcpdebYhE6+FRMMa520Ku84fJ97GjIkkUVUuqYsiRQq2athnZE1ZDRC4P+2mWKkUEWUd791I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hPmOz+gz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hPmOz+gz"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490c56e2576so13190235e9.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985797; x=1783590597; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyqQt98xw9ATzSToTJPs54AMwBuvYnqZayPicgnewLI=;
        b=hPmOz+gzgq94TOuTybBo/hDC5xNcZ9SpDkTxaIS6qE5C9jHH3zBuOEWEwSxpO/3PgB
         7Zm+kEm34Tvr0eC64HV2XakNHxA7Nvc+Ic9rXlz6i+D7WX2fZ4R8jpbWR+h7qfz+EhIm
         viQHiFtGRUHvlsEWErnSXLB8yfBX5bOjO3nzv1cgyouNN3Dif+6Kf1TZd40YHGoA4p16
         ZSqsVSaa8AWJKq8D8yhvpdttyc+brk+VvM6UOWcxVWpkJhza/j956XqFYfrjbEgMcEm0
         Lh8/HNOcpp9ev4GEs3GMD3WujNahaRkt1RgQK09Y6nDvlPsraxtB1yzCabiqSbKom3EQ
         sy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985797; x=1783590597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyqQt98xw9ATzSToTJPs54AMwBuvYnqZayPicgnewLI=;
        b=FVn6lARpiZuAgIro/5oJXiNL0VsELVNC5gv3kyGm2Axmvi+SaU1NeGOtDEPn1S+IVT
         RLwwwkUhq4tNP+VSuFB5cPrrIy7Ax1B7a7Uis6i/xeaDYe+d71yC7xl6K8SPeGTKk+0X
         TTr7sj0FggsEuw2vQflKbjn/wAzjLZ5u5SbhCM+bo2/j5L2n+TT7Zt5QUo1pLnL+HPm3
         fkXm0vKNgBnjWgIbPV2hrm9p2atIDW+ZvMank4uyDwbXAySLqRFiR/L9MgQR8p2mlcdo
         rDRjOUCFNBDUD0gHnieTPwPYhbXbGrfXlluBUDPTKOn7am8WsbZmUYfjUg77KJWjPq+4
         u77Q==
X-Forwarded-Encrypted: i=1; AFNElJ/dcuxi/xqmRYtgz7CCdJEqFnNQLKHXp4mAeIWoqsIUWX7ZUC2fAnv9VT/VEZIsEI3CP7IdnWQ3+JdJEf0w4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxzwj8+4Mrsr5qx96y3VCoIdqd0tQ2zTUC5Eclqp5ij8lZqw5Ge
	raFXMfUOnO07/Th0ppMFaP7MJ1KG7WvnUGwyxdVycXVYOS6+wOv3DD/UfVrJHvDnJ46Cl5iMiKq
	lJdZyMq53VWYe2Q==
X-Received: from wmbf16.prod.google.com ([2002:a05:600c:5950:b0:493:c773:ff79])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a4b:b0:493:bef8:ba8 with SMTP id 5b1f17b1804b1-493c3dfc635mr58366765e9.39.1782985796552;
 Thu, 02 Jul 2026 02:49:56 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:39 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-8-0af8ff387e80@google.com>
Subject: [PATCH v4 08/18] perf/x86/intel: Use higher-level allocator API
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
	Yosry Ahmed <yosry@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the latter allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

No functional change intended.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:unknown-version
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/events/intel/ds.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 91a093d8cf2e7..70be80211d823 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -832,7 +832,7 @@ static void *dsalloc_pages(size_t size, gfp_t flags, int cpu)
 	int node = cpu_to_node(cpu);
 	struct page *page;
 
-	page = __alloc_pages_node(node, flags | __GFP_ZERO, order);
+	page = alloc_pages_node(node, flags | __GFP_ZERO, order);
 	return page ? page_address(page) : NULL;
 }
 
@@ -1088,9 +1088,9 @@ void init_arch_pebs_on_cpu(int cpu)
 
 	/*
 	 * 4KB-aligned pointer of the output buffer
-	 * (__alloc_pages_node() return page aligned address)
+	 * (alloc_pages_node() returns page aligned address)
 	 * Buffer Size = 4KB * 2^SIZE
-	 * contiguous physical buffer (__alloc_pages_node() with order)
+	 * contiguous physical buffer (alloc_pages_node() with order)
 	 */
 	arch_pebs_base = virt_to_phys(cpuc->pebs_vaddr) | PEBS_BUFFER_SHIFT;
 	wrmsrq_on_cpu(cpu, MSR_IA32_PEBS_BASE, arch_pebs_base);

-- 
2.54.0

