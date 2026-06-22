Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BC43A0E8A
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122527; cv=none; b=ozE4NU+h680CA9/LalmGCDmGUMhnuCEYeFzcLTBCabFHuUJh7LLDLBcvNzgmdyxhncNKBaQh7Pf6cFyJdSkIV+lMew7sIVzkZzbk7v2UHnsZa1JjK8HnW0F/Qg1XUrOQHvniP33flgTi/DeAeokR0thbfmnaND3vmv2yW3gqWcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122527; c=relaxed/simple;
	bh=7JNThNqA/rsEikbti+3GPsR/jUMWefVhBT4KBWfRSDw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pB1qBo+y1vugc6eP7vwK7fK2jn1sBGmRF4sNQgF8gwv3L0xpZksJ4tvdrdI1CIJdtLdWNTPubTek4zfood8dOhsrKc5xXcUxdmKmf2wfcNjBfSr7xSOPnGbwZpb6CW0Z6szeuDcho8kbiYai5FRrM389XqoHTY1XRgMujQxkt0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bpwOHLfs; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bpwOHLfs"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-490aadb1386so24682025e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122517; x=1782727317; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AO5lqlMnd9mItpXQ83kdKJUoYx9mwrmKGw5gn5aBMIM=;
        b=bpwOHLfsnxwGIim9ZD/AjCevys1oekVxvkZyn+FcoTZhplmQCnLO68XIuZqxpuR4Rb
         pQjQF87hIn55afA3GKa6b8aAkH5zo/6Q6aW5I6YcsIsAOvts/8U1ARNHZRH/3DucbUND
         euA0e4uK5b4GKlnZgumqS8MH4zXLOkZoP/QQVJAohelIDcbS8wlpwcHC7KGYoSQyioGE
         6aaLE2vWHutWMGhw33mdJVAj1kD10qoyQHvnzgN/YLkcKf05SWOWIbgR62FafRoKWZ7D
         j/zv+W6eczLlAvJci7leHBHeKOg5veK1hVhONrIduqReWwTlHvvNK7NdryFPiA+BRhXX
         u+ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122517; x=1782727317;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AO5lqlMnd9mItpXQ83kdKJUoYx9mwrmKGw5gn5aBMIM=;
        b=PNLhoLD+1mQFhKFuHiaMO6Myp8KB3/79Cv0v/zycKv+NiypYtbC71thZspuYOoDpQk
         gQRAIse/NuZHeu0VgOHS+EEvPQPgsrXoa/KGDoJQQ51yAW70k9XQnR832KfV2lMC6emE
         ehHrXx8WSc2yDFe9UnmzUJfRRB5wqh+8VK1EyP/gou27txZKaVZSmxLG0P3hpayeQgOc
         RO3sr6nnPyEfmVTRHwwb4bPAB/qUlEKYzIQTWJ3kEQ9OpIDAU69Z1CEeTb4wLYx2rKfS
         Ntm2n5h7u1UOzRekVkZMp5sXTk9xODjhlZjpQPPU9ucC81Oo3LeZ7/qi5jyYHUnKdp9G
         A4KA==
X-Forwarded-Encrypted: i=1; AFNElJ9sHJtDA/MK/FgRRMiQIM7Wmyj8o1VwKEmJp5EKOYY/Y92A+bb4Z0SvYjj0o35Q4Lmrvwc7GDBheCGJg0Rbkg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwiwnMMqByaAHEuyT/HIuH281ABJnlNanbYMin15hCG10QBq9zB
	6X9XjAqBMRauqOenlJGq3oYHkLemASIWEUiUlLCcmmsJ4RSnCQGOCN48Bya5oFB+oRcBypZuEAf
	hvb11MXt4Y1rR7w==
X-Received: from wmbjt3.prod.google.com ([2002:a05:600c:5683:b0:490:b6a8:96fa])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:4448:20b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-49240a09f71mr144939135e9.6.1782122516674;
 Mon, 22 Jun 2026 03:01:56 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:38 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-11-31f31367d420@google.com>
Subject: [PATCH v2 11/13] alloc_tag: Move to mm/
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

This is logically mm code. Moving to mm/ allows access to mm/internal.h

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 MAINTAINERS             | 2 +-
 lib/Makefile            | 1 -
 mm/Makefile             | 1 +
 {lib => mm}/alloc_tag.c | 0
 4 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65bd4328fe056..5d426b79b8fe7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16713,7 +16713,7 @@ S:	Maintained
 F:	Documentation/mm/allocation-profiling.rst
 F:	include/linux/alloc_tag.h
 F:	include/linux/pgalloc_tag.h
-F:	lib/alloc_tag.c
+F:	mm/alloc_tag.c
 
 MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
diff --git a/lib/Makefile b/lib/Makefile
index f33a24bf1c19a..44f6538533a97 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -197,7 +197,6 @@ obj-$(CONFIG_OF_RECONFIG_NOTIFIER_ERROR_INJECT) += \
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
 
 obj-$(CONFIG_CODE_TAGGING) += codetag.o
-obj-$(CONFIG_MEM_ALLOC_PROFILING) += alloc_tag.o
 
 lib-$(CONFIG_GENERIC_BUG) += bug.o
 
diff --git a/mm/Makefile b/mm/Makefile
index eff9f9e7e061c..4fc713867b9bd 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -147,3 +147,4 @@ obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
 obj-$(CONFIG_LAZY_MMU_MODE_KUNIT_TEST) += tests/lazy_mmu_mode_kunit.o
+obj-$(CONFIG_MEM_ALLOC_PROFILING) += alloc_tag.o
diff --git a/lib/alloc_tag.c b/mm/alloc_tag.c
similarity index 100%
rename from lib/alloc_tag.c
rename to mm/alloc_tag.c

-- 
2.54.0

