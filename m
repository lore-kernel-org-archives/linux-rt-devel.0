Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7663D4131
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081959; cv=none; b=qMSQUZn7auDq3r/597Z3C2EAXdh+rEjL5X/LTYIUTs9wrAc2j29ksTYN/JJKpQjlR1NQVpRCP43sfXmjVOJVdBQHd6ivaV6rNj7m86RmuNSUUDtJgFUz9UnUygD5QGDuxaA/cPQyMZ2Ipk+2I4fI5xuGpaf/+ok6H+HcUQjMqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081959; c=relaxed/simple;
	bh=gAX1ZmzFPfazfApyiQ0SZUESO7aPJSw5OGicaVcGYLU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e1iDD0yi1kJuXgiyL/Fi4Av50ab2ej17GCyHiBVGwRCa4hPxpo4C7NZnadRaHJjyvNuXuRXQbmcEJ2TSu8uJElh+C9wZG2W8VeHdrpGcv3OoXGZCGxhVIv7NPuIyn7zGyXO+kAbvJcJFsoxQiRcj2Nx37S2IyJRV9FE85IVaE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hy723Q4+; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hy723Q4+"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-473de38dcfaso369462f8f.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081949; x=1783686749; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kyqQt98xw9ATzSToTJPs54AMwBuvYnqZayPicgnewLI=;
        b=hy723Q4+oFidXSW7PzcCbK3g44V9nmjEbTujcjlNFlFmkAB4rQtO1qM3hiEyDdcxEU
         30FBcXYLdDJyy4rykCn8FHL4RE/oh8I9IBVdScAWB0eSfrkEwp/3IXHtFRNFA71EFC3z
         T9VcetR+N1aOpyFfOPTRwju/YLPQtEw6EarBG7S9DugBr9/DDfkRt43rN5e+JU5a5mVH
         z5XAdesIWvO2jSRLYSYx1bvmmiNFhFtlGKy4n3o5Mq4QVjMFoDMeY9Pys4XSRNnMPwAS
         xwsX2g5J/h1b9kbxJy6gyz+k+QZ1xGDYKuKHiMAZf2MgflAKr/7M7HvXVLamdrIvsfyO
         9/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081949; x=1783686749;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kyqQt98xw9ATzSToTJPs54AMwBuvYnqZayPicgnewLI=;
        b=Z2/g8on40c7oAfZmHFFzuRcE64WlIEodnOWxfk6G9aRq7G1VdHMtMlpRFw2LVRWkdX
         jmkOwS+doQvVLcxgL2ur8rbacOW2DBnLzDPsSeJqW6wW2wNAeoX1W4lVXbykcl3l2M5s
         ePkIR7VJd2u7mfgEh2VTeabVN/Q8MElQzmWzsw9kKQOfVvJpWYGah8BxgFmVKIcOrTeh
         XmljZ5tCT05sc/XE0mytJ6JG4iaqxze4JUyX25TuD74pQZxT5YyuhrkU+Wq0XOG6AI5v
         EsoMyvWz9apIZ3fVNAcaRmqxRD/HpX4JsnZ3NRg5H6Fg1YFnjXMLyVyooOZNjXCPWLnv
         Isjw==
X-Forwarded-Encrypted: i=1; AFNElJ86My0X7VrLfD/IrRbnvKqwWCGkOMoRmJs7lDxXGqvHFBNc/K0BkhSTYkURhlnEa/uTNnD9E60J+mGHAe2KUw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy2MNiIq5aUegMrrBL0mpVQwKac5Y2FImlE5DJXxt2gwoI/myQl
	zWdXgvnUxp/PGiFgSj2/42+HpxfocgnAAahp3kTmKDTIxPRWsHm5G3WvyE33b4NzDArKd3lWbeZ
	ysOsjyrbUdxx3XA==
X-Received: from wmbip29.prod.google.com ([2002:a05:600c:a69d:b0:493:b6e1:bb31])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5296:b0:492:6efc:7c60 with SMTP id 5b1f17b1804b1-493c2b99781mr138970395e9.28.1783081949082;
 Fri, 03 Jul 2026 05:32:29 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:48 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-8-c87b714e19d3@google.com>
Subject: [PATCH v5 08/18] perf/x86/intel: Use higher-level allocator API
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

