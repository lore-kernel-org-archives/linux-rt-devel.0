Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6443A411681
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738750; cv=none; b=L3jvxoO1bPxFIdRxSc15pI9it5Gl+X9kPIIQ56SdrvQ08XMLh+xfPj3GfJVkztzwvDgFL1J/uVkoMJvW8GWIetBwuL18N3fJehEMz0FuxJ4iK1olJaHJKGx3MK9JFbM5ChhoRJYsJA6vsjT6RwQY+zheXn6q1o0BRUKds6KRjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738750; c=relaxed/simple;
	bh=8AgIFocv9gAdgFrvqd5zMeVFut960DYptbjYIWum5XY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=X8z0773uLadMj7tKWEoEsQIdY/KgMeueNj+lFcM+ZFTS8UiVSpuwwq27JuUkEDTAwgOODp+PS5cTOgcSdtHGyvyx0XR+nanCcIl2QAOyxQgOsVBQAs0LiSvrziD4pvLw8Ana1Y53Pj4udDXceYS5zEk8SeGPUReUrYsSWBJ7mUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QiuR21OH; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QiuR21OH"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49260d6eaadso23547485e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738747; x=1783343547; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVcvWpPvpGh0KKDm0kFg3LoFKQtlNo0e/vWFcO+Gc5k=;
        b=QiuR21OHWjdginl5XFobWYgzm39hUloHbBirAA6nvADcJqMDUhwxIz211MKDg/id1Y
         1jQOZSmhl3mTZrg8smP3zivLYV+xJMMNTpQdS2FBU85H12dbGIrI2ZNBff4bcyG1Kq46
         Axt+fdJ38P+wzBncVlFWkfQM6fYZmqqfFtfM7T+afiY8yscFAgsnb3NWyjbzf8HwRN7x
         ADSrDqSBUN+QTUazt+RdLVNqRVFXU/2rvJrOnm15Ya2nAfY2bToqKvmMW2JERfjIZKaI
         FCsOKmNVZjtGfNbmIOCmkg2q6qxCaZ6gXqGkPurqt7csrHU4oCKnXnzSp3/wyc5MHk2X
         R+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738747; x=1783343547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVcvWpPvpGh0KKDm0kFg3LoFKQtlNo0e/vWFcO+Gc5k=;
        b=syhAp6bmMDzhNIjye5vXyIoOdKnZHQn4O/BQBeTE8VkdZqA5uJ7PK+45iaUKKJo/dX
         hAqDLIUtzi/19V5a3koLwqDa3uG0XkXUbJkC4Q0ognQ0u4ngdO1D+ik9AoZDrDci4Pav
         +g+nKRmxx/D79j+TH6RiVWXwzbSgWDMsx4lZX9+WPLAc/mluc0hHyaqL+aVQeQPA01oj
         201SukKcU6fvTTLpIdWViNMWnQY9Wg6p9lObnYo+D1v+Cj99YMvwOWs1S2DQYtKFkG6z
         RF0cnkqug7iwxwCNSURzAfvDAmsHXlaFvophS9AlOVqZFTc5EMNSJTQ7SFBlj6epIoDR
         vJDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9F23Wb4hTtHeFRP35NykgTnyUmbP8lZQWn3jcfQHAoB5c9aaWhm32noiTW7/wqny5AV9qUzelKnKBqoQApfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwTYWvwYIm+yKLaFBV2HjGlyND57fcJZRTXYrZ3d+xjDWvy8FhX
	ALWrWytbQGPuXLHAGsPPH2yUT7GUvq3e5O7i7nXYXsEfwwtMrrcgCBAAjNi9bfSJoqyCZcVBQLV
	ae0GM2TZLlngQuA==
X-Received: from wmhn2.prod.google.com ([2002:a05:600c:3042:b0:493:ab17:3e61])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3f18:b0:492:6efc:7c60 with SMTP id 5b1f17b1804b1-4926fc919c3mr156189865e9.28.1782738745900;
 Mon, 29 Jun 2026 06:12:25 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:57 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-8-57bef0eadbc2@google.com>
Subject: [PATCH v3 08/16] perf/x86/intel: Use higher-level allocator API
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
	Brendan Jackman <jackmanb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
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

