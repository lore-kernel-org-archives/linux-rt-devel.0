Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EB441C303
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738760; cv=none; b=nD1RWe21iXRk2fprMCnV4catxD9JSR1FBnVuIOkz7SUjJVBZWKFr8Oaet8fCUfaLHZOQ80E4rX9LzrxoKAxNUEJO7Ize77gRUZWm4EwRwrIYn31c1Ee/hB0CuKGYvrfpnJHbJ7TnCn07dsgZdKeYOfgL/YZoYT8Eg+N7XsVak1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738760; c=relaxed/simple;
	bh=jCeFJd5hcegb+bkmcRTTqgKj9Zc19HKuhXraZrgs6V4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qhNcCOOdG+WgEYYzf3ece66GmRVAE6PqwlvPhr0i9KA9tOD0GmGh6LZom05Drmy5kxezFwol/2xkGFSIzPnScYNovC/a0QR1yqJRsEm+1B3Xa9lMs7RuOO4LYn2GFjJgg2FkWwMWTfubHP5OWTAkY0iwG0bFpyTiZ6NNjcpDUv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Znk6Fv+h; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Znk6Fv+h"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-473f4a48e9aso500754f8f.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738757; x=1783343557; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Mr23/ZUs7aDb6BM7e9K8eAVioMtQVUpxScWSecPbA8=;
        b=Znk6Fv+h6SbNMGS8ZW8PvWxJmqYcenXPWxsfGYJMJRPNji3KAvywWuRgfnccRmQ2Cb
         vUD6nuuKK6nzn0nT7Jr4+3wPiQ/0BrYXzRVR2vAgYusu0p/l/IUa4yubxcD1HV2kFjz8
         Hj0IPL6SsLs2Cfepsa5SgfvPi271aMW/YAmzN5D/NYSxkB6jpb7J4+fA9uQec1pepKsp
         oD6A1IeFMEnHO+a9HogLCafyzlECQYESfCPT2q92/n8+qtQ6zDCaHvAjWpp4jzQFW6B4
         XFEQLOedr5F+vZp1YRIKsDtGZdFRcMAz1ZAp9ZU6HHSNryY6lAxYf+QsarJE9l4E+4xm
         38KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738757; x=1783343557;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Mr23/ZUs7aDb6BM7e9K8eAVioMtQVUpxScWSecPbA8=;
        b=bSVirsMHXkzlnU+I3k6FRtUCdcFLLrFYqy6DqGcZwPNLqMcgQdYVXBqoDlJX+O/sCc
         9Gs2sH/DBJ+TMVknbEm/Rwe1bgvB2IXlQq0MDVxn/P/79Goz57dmLzXaD7B7QxhUXgu5
         gAYkaRqgYfJ5a7iZZ4YqyuFFSbucSX56dxD/K3WloCd6LWbLDKA0YrOPiStHMF4B5/6u
         dowxH5hIRmlp44vuUQIEEh6BEOTkGtfzFJ8UxRutWzehqGbPKIo1VoZLy/vPU36bMC97
         3clNiFLJC9fhtsoD2CnKMTzt65lcfI9dynardHWQuvDRJJDmWyFzLW5VnxF8vZ7Q7cCA
         c2kg==
X-Forwarded-Encrypted: i=1; AHgh+RrE1fbs/LQpNn6XR0B9G0b9/q3TLBlWdMkXeS9mGpvqvGvgiP3oBaq5bmjpb7je+pcI2iTcqtPDAIYSO6HdAQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNr4/6FFnRX+TVW3hnXZol+v0NfOp9P2U/mu5ox5KYjoZwsnER
	OlKsgO2yKdoJpRwHFGQpUYj1aWMveQILlZ4DPtapRNu6BDCNfOmDkSDAFKXSGH/AjfacJEJi5WT
	/mXF/TbPCah01wQ==
X-Received: from wrub13.prod.google.com ([2002:a5d:4d8d:0:b0:472:23aa:e797])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:438e:0:b0:473:1ccc:15b9 with SMTP id ffacd0b85a97d-474feeb1d56mr602415f8f.1.1782738757040;
 Mon, 29 Jun 2026 06:12:37 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:12:05 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-16-57bef0eadbc2@google.com>
Subject: [PATCH v3 16/16] mm: remove the __GFP_NO_OBJ_EXT flag
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

All users of the flag are converted to SLAB_ALLOC_NO_RECURSE or
ALLOC_NO_CODETAG (from __GFP_NO_CODETAG which reused the NO_OBJ_EXT bit).
Free up the flag bit.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
[Rebased onto __GFP_NO_CODETAG removal]
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/include/linux/gfp_types.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/include/linux/gfp_types.h b/tools/include/linux/gfp_types.h
index 6c75df30a281d..a93b8bd200b76 100644
--- a/tools/include/linux/gfp_types.h
+++ b/tools/include/linux/gfp_types.h
@@ -55,7 +55,6 @@ enum {
 #ifdef CONFIG_LOCKDEP
 	___GFP_NOLOCKDEP_BIT,
 #endif
-	___GFP_NO_OBJ_EXT_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -96,7 +95,6 @@ enum {
 #else
 #define ___GFP_NOLOCKDEP	0
 #endif
-#define ___GFP_NO_OBJ_EXT       BIT(___GFP_NO_OBJ_EXT_BIT)
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -137,17 +135,12 @@ enum {
  * node with no fallbacks or placement policy enforcements.
  *
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
- *
- * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
- * mark_obj_codetag_empty() should be called upon freeing for objects allocated
- * with this flag to indicate that their NULL tags are expected and normal.
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
 #define __GFP_HARDWALL   ((__force gfp_t)___GFP_HARDWALL)
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
-#define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
 
 /**
  * DOC: Watermark modifiers

-- 
2.54.0

