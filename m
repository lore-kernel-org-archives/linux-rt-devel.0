Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7583A1D14
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122524; cv=none; b=swDKWW3a0us9+8nyHME0660pEdSWeCUFyooMEkwoXAXJDwxAEcR/kx0icpTNNBUKjp9dpXMuka8ofTTlh3hrtbhz61+Ql8Y7dhh1utowpbQQz6nqsKN4XJECVgSi95/Qu8NKovPGraXa6weKYxSKk060WmWRG/t+xk2wsmceuFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122524; c=relaxed/simple;
	bh=4lW2Ze6qmox/FZtLj928PmXt3Eb4zkO8jT8QwcqnvMk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kr6/9c8lKHOptBLfc0rreMCpRjPSV8DNTqt7mbLKpb+rTZ079Z8CLTkSiIWf9PpxATK5a5rGcpj01Vep1u7bUCTWKAEGDHBn5aRXZU8TEvrxQas3LZiqSRQAtkHb/oZejqDPcEvgsZDygx7ncKb+tC4hmPM/fzD6P3+SbyTd3ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OcKCGyjx; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OcKCGyjx"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-69763fd5cbcso3277554a12.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122510; x=1782727310; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9S11xQ2ndprBO95V/I6wL9RKFczfzFD4sM9MNZL9BLw=;
        b=OcKCGyjx8qmEYO/tBL6/8bLMNSCHFTQ9+CvYiyLImbtp9SD5Ie1RfWZx5VTOH7eaEV
         vhdRW1buBVvRl/uK8jkgZySsCbdyjoS4vnvvdmgsTXxXCuWJt8Y0J9PuKnv8LjNf0jBW
         QPb8yE0J6YcVH2oBbybyPvMAnIre5Qfrxb7+eymE7k9EvwyKk3QJhJfHQjqdeFnjNavQ
         RkDgc2qoiKLTYa6BzfLL6c1Sp6sXnubPK/WSnwJDypxWmwc6ZN9JDuoZJK9VeJ4lgla6
         ErIN3rbl+0L8+Nms1f0O67CC4+W6vhKgBx7zonaukmIZg5ihlAWBIUQ+Pbb4xRmcc+Ja
         Hcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122510; x=1782727310;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9S11xQ2ndprBO95V/I6wL9RKFczfzFD4sM9MNZL9BLw=;
        b=auHaXcNFEb3lcrK6bRSj2nSPiSZ1IBFXlPJQ27xojzukoZ7Cct6uQcjVdFhGKRxehD
         jTBtJIDXjTJMfWIZDp/n7BxggW2+i74I++g7ULcMi0uVX71ggpb8BA42jCqkPmPuYCM2
         Rs/MABC6x9cRVUWIeo3Z2igf+JdLecEV1D26mZGxR154D+q+h1RuWQk8Y4PtCFyar5LJ
         gMfsKeC6YcDgRDclsoEQ7vu4xEfgpzKvoX/Glyc+pMyANzz8eD713Bi2tV46i9KP7llN
         ITCWPJ7vx71g0jT08CZHTLZatkmDJs+yt9jxPUqXTbwj17nH+m5LuixwU1AlMoNWS490
         QhaQ==
X-Forwarded-Encrypted: i=1; AFNElJ9WWR3tXkO9HfB5FzN5QC3MblCGZt0qLVCJlyF2SD80ycDCxxVgvp4pa3qkJj+F45sQ35zKPQWUzQ86NQpY9Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDlCAVJkIQ+MWWFSx9ksnEI1rECjy87kKHjIiq0scm+IZwg6Az
	a8R/6+S4EFonQAa/9rHSNVhMj0jv+8e5eawgGse4ttUULyBoHwHlahDbDlNo4XnFK0zasiYYWxe
	vcd8LZo0VzzQjkg==
X-Received: from edvh9.prod.google.com ([2002:aa7:de09:0:b0:695:de87:8924])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:268a:b0:674:5b2c:d42c with SMTP id 4fb4d7f45d1cf-696edc828fcmr6463779a12.3.1782122507560;
 Mon, 22 Jun 2026 03:01:47 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:32 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-5-31f31367d420@google.com>
Subject: [PATCH v2 05/13] perf/x86/intel: Use higher-level allocator
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
	linux-rt-devel@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the former allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

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
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/events/intel/ds.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7f0d515c07c54..bbc20a5beabb6 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -834,7 +834,7 @@ static void *dsalloc_pages(size_t size, gfp_t flags, int cpu)
 	int node = cpu_to_node(cpu);
 	struct page *page;
 
-	page = __alloc_pages_node(node, flags | __GFP_ZERO, order);
+	page = alloc_pages_node(node, flags | __GFP_ZERO, order);
 	return page ? page_address(page) : NULL;
 }
 
@@ -1090,9 +1090,9 @@ void init_arch_pebs_on_cpu(int cpu)
 
 	/*
 	 * 4KB-aligned pointer of the output buffer
-	 * (__alloc_pages_node() return page aligned address)
+	 * (alloc_pages_node() returns page aligned address)
 	 * Buffer Size = 4KB * 2^SIZE
-	 * contiguous physical buffer (__alloc_pages_node() with order)
+	 * contiguous physical buffer (alloc_pages_node() with order)
 	 */
 	arch_pebs_base = virt_to_phys(cpuc->pebs_vaddr) | PEBS_BUFFER_SHIFT;
 	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, (u32)arch_pebs_base,

-- 
2.54.0

