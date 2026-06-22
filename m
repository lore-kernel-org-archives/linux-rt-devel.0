Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C4A3A2E00
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782122527; cv=none; b=LHRjgCyyqJojLEzxuFYXqDAdtCoWRy7sd3eJbpAY9nHsOoZ34zEpzL8hyi0KzuDjiNYJUI+rpNt42KMyoQZTshrw6td/r88N4eayQzdI27UWU3/i4miQ9AVC0hIm8vxihubH61aCr5eSP+yRTdT7MZo0s1jJyfgKSr6fJ74fhNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782122527; c=relaxed/simple;
	bh=afuTyJIfjFDEu6C6ZPTJGNvdcGiq+qnd+m3gX5XzUdw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bqGHCOfZ6I72ZkuwDjVRGRBC10WZGW5jeTDfwowC/0rQxqgx4wWnAXDXSK4nbyPQs68M4i0Imff4/Qhi2XlQu65mpKENKmqam/hFPfDmqoUp3i7GThd9utDaMYSajWh08GRRQ+6A/aQDeKep15cNV9kHzgwqa5cupDjGWe5ylpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=advAhyFr; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="advAhyFr"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-695c6b2814cso4372538a12.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Jun 2026 03:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782122515; x=1782727315; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TCcnOhiuUzkCpkbV1xfgXpOTpaq02YLmqaFAcy8zthU=;
        b=advAhyFriX704OXtZNxG2lPYO7cR+LOaUEYyAYiZAl8gehkGIZyRm+whDKCJ2flICz
         AQEcpgelj0SwKiOdcemPTLEAG6oP1yOtnY3Ds5JWo1wJ+uLCiP54N3jzc3twkhJO0kNh
         gl610tiCxLI8iTVWbpaYyyna1XreoxdQK4U5B2atMa2EcgLBIYxc3uM6qgJeiE3jXiNz
         iC9oWKlPfq2g7o73ldAxN81B/tkVHz0RrPWxfTbsX5aqIJmmXWh2OZ0zuB3AXplU4rOl
         RwQ/ShN6gs34n9j9c5JekL+V72ZyVZyjKd0Ypbft+uacysko9yCSQ8iHw/+wcjG5GgSk
         zJhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782122515; x=1782727315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TCcnOhiuUzkCpkbV1xfgXpOTpaq02YLmqaFAcy8zthU=;
        b=V3TiM0/udn2re170yfcOPlV564ce3kB12tyFkIG1fbKTWN3Pxjw/dX3+unpxx9Ipu6
         zliGnvp8tMuvmlJZpZOksR49QNY3tsv2MFU1Ubw9oIrkknFH7/yscxLTk9TMrW4b+l1G
         AtJd46eFYEu1Bhrv8JSH8e1UJpY4mCchmihcpuWXWamb3/vj6pG9S+DBDFYWxBi6DuSP
         VvlZ7ek+FIKHgMghHaERrnIAurdAX6s4juZ8n4Tsv6A6uzfTlnFff14SUXBJc3zod/mg
         PfYCEleR9Fzqx2DZcfv/C8TbtCspWrW608/MVRHvJemTN4DS0a8A0Nim6yzghRRWneaz
         fYnA==
X-Forwarded-Encrypted: i=1; AFNElJ+rpnMtx0BqSsmfaOJ/dMXhWtE/TAgKcTX12EM/Tj1Sv0r83XYMeJoI9XxLe+wIS3TH5wBDhsb84qksMrtVAw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx6b+KO0D1hJJegTZWwSqNCdHKltb/81PJ/TQrZ7E5eoVQN+dCk
	eZiYrwIqOlBiVFBV7dvnWXSObHN+sBe3EPiVnPTYU8lUBsM4nAwQLj5morAINkR+rBinuOikAvZ
	TedBfRTl1UT3Bgg==
X-Received: from edik3.prod.google.com ([2002:a50:cb83:0:b0:695:6267:8c69])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:a51b:10b0:695:45eb:8ff4 with SMTP id 4fb4d7f45d1cf-69711e1625cmr4201100a12.25.1782122513986;
 Mon, 22 Jun 2026 03:01:53 -0700 (PDT)
Date: Mon, 22 Jun 2026 10:01:36 +0000
In-Reply-To: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260622-alloc-trylock-v2-0-31f31367d420@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260622-alloc-trylock-v2-9-31f31367d420@google.com>
Subject: [PATCH v2 09/13] net/funeth: Switch to higher-level allocator
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
	Dimitris Michailidis <dmichail@fungible.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the former allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

Cc: Dimitris Michailidis <dmichail@fungible.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Assisted-by: Gemini:unknown-version
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

