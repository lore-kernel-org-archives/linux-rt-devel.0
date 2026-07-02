Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0434C9578
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985793; cv=none; b=GD9sZUi1mVRRYh56WFYO6Kcl6WjdAt/cWnDWu7Mea/0zVLAsBXzctxyAmZBGbmdpKjoI65py+lMSVO5tLYEQ8tgEQnSlY8AlZ/q/kbV+cJkPGGUjv8K6B/GzXs54QJ2T+WcInGWivgEKCLtBc/PiTG8ggulAi85n8FoOB1uDDMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985793; c=relaxed/simple;
	bh=YM3IhjKB6RosE8HNpfsLrnIPcX3YTIhpKGMzWSEpSws=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tOGWA8sZNikESH1PgoMKoYrb4nNMm0N0fpOqX02ZONIUyUzS1KcCP42HZq9gE/vKdIj3YlqIiTTnMo9IFmXZXSsMrD2TCT/T+HIr1UslC5yJAYG0T0IPp4wLb8jbAi/ttMNVjzN/6lSLY84LxlOWnWnKsMUc+3sSWHDBS8Zj2p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2xM91fm; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2xM91fm"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-4740be00302so1335799f8f.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985791; x=1783590591; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3NbrxmcBD9wRA2EoZZ8V+E4lVFkjGW4tXUzXfNK2+Y=;
        b=G2xM91fmG0tOLLf6XTl7WsEhku6krpZqlm7jwaBLUSSyrMgvvmKkgfBoNuTDVOyd1S
         eAObbRaAPtrOURucvWxUlIQzc1Zs7fl84MA+nFNZKrqHseQRpu7sDLCqmDauTf6cZgWT
         Hwu8EeP6ylcc6ZEiA6SA1PjaiCz8w3zqpWTSrwmcMgYxjvZAoFx+D+tz2G973fGrkd4g
         jjshdTEFi/WkAO8IOOCl1GBTx9n5IxI8hEJy02t4l6crYKTjCxYRxyYsCKP+YOFckYcV
         bPtZHx92Hb06ytj6ADF54xmRAhovPaCtDSf/NqgT+YdokaMV0fv6X0y2f5W2vkXFRm1F
         J9Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985791; x=1783590591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g3NbrxmcBD9wRA2EoZZ8V+E4lVFkjGW4tXUzXfNK2+Y=;
        b=qP2ArOY3VQqe+TxI6l61cQGw+LyhJjXCATJn10M3jKac6F9BtO+nKA6/qkfA7PENZN
         K8s8GCwUE6Hml2bDJu0BTuXd92QqgxPdi5Zwr44bTEB3zh45/SG9A9DMab3PQsAcMsEZ
         SVn3dmZHa1V8l1+/HwtXJCIcIC7gU7KBkKHjUsT5mB+rlyOdN+NZOcy7tEjWs2wHAn5A
         vRdQmWOj3lbwVJSdNy1kqY0F+/KPFiqcCUYl9XpZiWreXqfNdYIgs6dKsLHzgxrXkFgS
         FsoN+I/H9zLbR2ODmagXKEk00YwNRHA312z68upnvn8a7k9SWHlXyHVm+FNLGmZ+5PKU
         xJYA==
X-Forwarded-Encrypted: i=1; AFNElJ9WHFFBsk2wNhXhx9pBE7L2za37YXUzXjKg6zCG3o9uIAnaU3rSsMIUgtw+yn9k1tb/Tejnnf9QHZxhRFG+Gg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwVUBTpMUsm9XEgMM3EtCJugFGzjylmWQek1MorEjUF94yurKfu
	bm8k8ZqtVN2U4ywgjC4qjzkaUANbUB+tVo7pRXciTqq5xugUvHenImdN+//spEHFz6/XiwmXH4t
	7AY1EOeKeam/OxA==
X-Received: from wrmg3.prod.google.com ([2002:adf:e403:0:b0:465:ae65:13e8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:b42:b0:493:b4cf:d37f with SMTP id 5b1f17b1804b1-493c3cd9dd5mr47740095e9.16.1782985790354;
 Thu, 02 Jul 2026 02:49:50 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:34 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-3-0af8ff387e80@google.com>
Subject: [PATCH v4 03/18] mm: name some args in a function declaration
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

