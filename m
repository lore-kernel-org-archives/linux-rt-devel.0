Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB8041168C
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738754; cv=none; b=Le5CUBc0//PmpMhqCsw6mda9zVc5ZxDfdxOSqkJDHO4xAoD9RIidpDuGVEE0DSHivUqo+oA192bJVAZ1OLkiLrUJxz9zp7OaPdS8ika0ER4sxVYtGkM3+9E2f344NsbSSdTlXbQZnUx5sXDP20+i/kzq6ou/9UsOKjcgedrtkbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738754; c=relaxed/simple;
	bh=cPFnL6cNjMQBmp/l7UMkgWhcM9/OVTtZURYtqvtzoBo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Knf+gJEos2iXMHZHY0xKQr3DJdHsQal7xDnLoj9m3fXdLleJ8loAvaGQuJfh4qJd/1v2YigFsOb6PQ463yIVI58C6w8V5F3gYKFGV3EHoudviCU0k6gBOw57pH4CQ5mXdWJq0krUK60laJqXV7Anp1dBb/cKElIKoq0ZS81lieE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QLuLIHAl; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QLuLIHAl"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-492488f8583so35359805e9.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738752; x=1783343552; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ugcG2ITTUxGvxQmxOqdEbKCPZm3gjUsTH8fz5PvZZs=;
        b=QLuLIHAlg3d/SdFZnc48Mms+QNYn00xuxzqSwQdjwPIi2DQNzyJ65wR7jqGES6XHJ1
         ixWTbwQIXxw/nafOBRtGzd3+QLDz5zbrAztrLLQuRBiI9ttatsyzqQEGFql8v7JjQgrL
         gWbis+WmujdSPslPNLxliCjMARlmTDLSpF+tJjh4uYdC0t2cF8n01PXxMEZPlTwum6u/
         vqsjU96PlKWIgMacwqdlvVQgOWQzwIOEQIoXafVyFUcXEZErTZLRJK4Bz9zOSwUJsl77
         bz9e0G1JOhVFotK381B7ofSX6t6JTJURnDCcOUR8kTKZ0EL0OeOsPhkouEAgUXc6pBMj
         cK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738752; x=1783343552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ugcG2ITTUxGvxQmxOqdEbKCPZm3gjUsTH8fz5PvZZs=;
        b=nfsOH6r4c+LccHu474e3xYy2jWAOMnbBzwazGdA/1MdiH/JS2Fc/+HoTlbvc1inicU
         q20arZTrpP0qLr+Kbz2Ln3mpfuiPa7ixCdsyuAth1YM8MGL52Hn/pE8Qwmh3SkDQlS4d
         Y6W+GWQjrAKXdd42+NzDHXW6E8YWDj9TeeViyCergKKumhe6iBTsGWw1quwoRfIBGbbU
         W+c+5Yba2/2uq9UYsI+uOy0XH/vEsCubD7WxOj4yYTB0ja9haaEKGsxj1J9Pi/WT3dK9
         Ll21UIQLyK07mjgFMqTcnb21S4/+I7ti5qPWXVlCzmZ6CElnu3mPh1g7bvFlyx1A52nN
         smdw==
X-Forwarded-Encrypted: i=1; AFNElJ9b6SP0O624ZZirvrnhhni3yCWMkzU7FkHa3OxmOkbaaE79q8quOsYX3KjNmZqWGXsAF2FSHjcIbh8O4Rqt8A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx9mhSZ97LvY4CiD0LhCP7EA/+POxs17v3vaJG4meMGb0z4T9TZ
	VSopHpYTjrrviNRZQyaeRa5wcReHRFu86jkvbH4A5pm59DsptprxSvBmYDryfybLbBWo6vA1bwk
	JqBp85ODXS4epZw==
X-Received: from wmby23.prod.google.com ([2002:a05:600c:c057:b0:493:b4ee:171])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:8454:b0:490:33b3:4be0 with SMTP id 5b1f17b1804b1-493b71d1679mr10649785e9.20.1782738751401;
 Mon, 29 Jun 2026 06:12:31 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:12:01 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-12-57bef0eadbc2@google.com>
Subject: [PATCH v3 12/16] net/funeth: Switch to higher-level allocator API
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
	Brendan Jackman <jackmanb@google.com>, Dimitris Michailidis <dmichail@fungible.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the latter allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

No functional change intended.

Cc: Dimitris Michailidis <dmichail@fungible.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Assisted-by: Gemini:unknown-version
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 drivers/net/ethernet/fungible/funeth/funeth_rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/fungible/funeth/funeth_rx.c b/drivers/net/ethernet/fungible/funeth/funeth_rx.c
index 7e2584895de39..d7000017ac2bd 100644
--- a/drivers/net/ethernet/fungible/funeth/funeth_rx.c
+++ b/drivers/net/ethernet/fungible/funeth/funeth_rx.c
@@ -103,7 +103,7 @@ static int funeth_alloc_page(struct funeth_rxq *q, struct funeth_rxbuf *rb,
 	if (cache_get(q, rb))
 		return 0;
 
-	p = __alloc_pages_node(node, gfp | __GFP_NOWARN, 0);
+	p = alloc_pages_node(node, gfp | __GFP_NOWARN, 0);
 	if (unlikely(!p))
 		return -ENOMEM;
 

-- 
2.54.0

