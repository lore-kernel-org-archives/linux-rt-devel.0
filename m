Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED64D90AE
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Jul 2026 09:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985805; cv=none; b=MEJZN7cS7947raVIvdzumqNvTQBSx5sDspad/Z9YZ7fZYn+Odv/IciQnfD9pbDqTouyzp5f0eTomtP65pgmtrSCWuE+GsHBVX0zoRLGxurKDEJc2R5OjM2HdpgXiDbE63KkUVaqechSpiKw81LCTo9NJ7rBMzW6OIOpq/tL4I+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985805; c=relaxed/simple;
	bh=F67T0oCRBrio7FIBWLmEqRTYstsC6jLNeHD5MDQHVvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aeq2sHzn6zilwkjHTyLfbVnJL3+J/PTzTOT7or4rQ7USpq6uQUcLlNz67ucaTpNIfTDFJy3LJgfZ++V3ASlJcnw1M/HL+td7OCJK/WDSOAfzMvH2Vwynyi8P0dP7ONqtKfvpmiofZYI5m80mSQnWuvWO75pLEy+IKoknpUw5qYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kCOaZr4V; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kCOaZr4V"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493b786d550so16921855e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 02 Jul 2026 02:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782985802; x=1783590602; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrjGnXdjo/8AidhzqQZNVSKN71a7xjQgfBXFiB4gebQ=;
        b=kCOaZr4VLuBWYsZVOXgDIC6qHgOTBvryjjjuV7LaTHai6VVGuJpOfobbYVaK/+P0YL
         5tL/O59kEc106/uo6A/c3OyxtF9d8x2fGo9k057cCJRlxQTfDoYqncyooUK1hXz2HFle
         BIkrJWysOkac9p7MQiUt5Nx910k9iXSfchNhGZyeYIW5LrZvp7ojSPEkzWxMXmbIQOyf
         VcHuAGvCxWnmDVA8M31NABVW4RXMy8FJJgg40RWoTalpxBxsyc62quhVpBoGWd9yGIex
         JfgOwE4MvLwI2Ucjs65iOgHDRg67o2fN2EHBkgm1EnCR/1t2bEdNLL23LZC0VSl5hgrG
         p2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985802; x=1783590602;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrjGnXdjo/8AidhzqQZNVSKN71a7xjQgfBXFiB4gebQ=;
        b=tGraRt9vkLNj/zYB18j7vuq1NiMRhOX0mLT7/fWQY9gjBbWpQJpVv4yILXFg/zHGh1
         pBEKKEna2kAJrSdcNa01XnhtqGAfOFUEJyF64gD8MigJFRp3c2o8dfv/J3TFnNtM7Son
         2uEmEu4J9kBxUI8mtU3LsvQioNHaA90Z3Zagk0xPLU6TUzZ86YK1z3Oa7qjg9SsKTjhH
         x/ykzwHnK7MPYeYK7Ow3GVXpRmyADIypq5KIa2EfB3tEw82IoEal3LoA+OgDbj2e3pOT
         J/SlsFciSWHxoJuLq44TDGDMiOpXQ7J6l3IhMzrMFy0QHod9bFs1uQv1Y8+ruDqZuEeJ
         8JDw==
X-Forwarded-Encrypted: i=1; AFNElJ95LHfaNY1agqia5UNyG9UhXnuocPg9EnIaMBJpbAeVri1OgakPwPSEvOHnmwCTvf5RZymkNMR1Urd//s3kYA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzqjJF5wh7b0aMil1ZJwPf1xc6R1K1kTx4AKMt8+AGWiH7//E8o
	4CFfjPfXk85OytRJGdfhvwvS3Xa6oliZHgVnfGCHWHN1LeUAmv/7ALqHgz9WiwzsE/Hk2HB+Ygi
	VbRZ+fLlwLKDGcQ==
X-Received: from wmdn12.prod.google.com ([2002:a05:600c:294c:b0:493:bb4f:c4fa])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c046:b0:492:4668:27b5 with SMTP id 5b1f17b1804b1-493c2b3d3ffmr52598625e9.6.1782985801648;
 Thu, 02 Jul 2026 02:50:01 -0700 (PDT)
Date: Thu, 02 Jul 2026 09:49:43 +0000
In-Reply-To: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260702-alloc-trylock-v4-0-0af8ff387e80@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260702-alloc-trylock-v4-12-0af8ff387e80@google.com>
Subject: [PATCH v4 12/18] net/funeth: Switch to higher-level allocator API
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
	Yosry Ahmed <yosry@kernel.org>, Dimitris Michailidis <dmichail@fungible.com>, 
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
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
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

