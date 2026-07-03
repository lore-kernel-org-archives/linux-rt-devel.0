Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD183D47C0
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081961; cv=none; b=r6MtFYL8kEBBMdOXPq/VlT4po8BmxC5eLPg+i0eY1utEDM8H1m4QPS/RwkgU1MhfwBwibex8NNEDEaE38myWwFaFQGqlnuUdavxi6hdc6WGlX8a5ZIVhBz859E7bkb7f/+BjgaiuT5BFSOP4Tdmjrut5rMsa9Hv0bAzpkvH1Nco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081961; c=relaxed/simple;
	bh=KNqrD2+2Bt6o9OriZEPOrcJLAbYLOMYUdx5zH9TW50c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kw3iHwNFVWp/ewNH/zpLSxo2BaLVwSxxYRIfvYk/R6LitwUw45wYxYN0hD8u/T+cvio+cBCYg8aRR5+lCskKiZJzaHNxFJCUrOMvSZ+Ne+u+DQlC3iYKf6Vd2UPnznwXSaotLRbX6OsIPt6dtOzFrCA0dLKomQb8tdZFu/RxKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdMenWJH; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdMenWJH"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c1271887c33so51097866b.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081954; x=1783686754; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oi2WdNtyn6OBAE6+L/wDlXe84IAgE1icOUsCwlXzl0o=;
        b=cdMenWJHZLCw2cq7WThVwEzzBm7Z7JCvWR0yWr+wKYLPOma4BbjZh46aY65yK0pYOv
         QI2UjibnZL+EuYS+DfDnJLSwxz5Ozzar8XyS9lH/oaDQF96VHbxPnVB3kL+J5nTCvSt1
         qtXMWyyv+8cszNxJHwMvj/l9Vrei2I1aIBjDotgGqDugn9KUr2GWZf4kzQJr3j1hJuue
         FTlixt/Ncn95Ec9BbK3tUgdnVIUKMrUqEMxe9GNJ5Ic9rYjjywJm14N6GKs8K2+N0nG1
         Os0OKOozXOd3fXJYHgGL80T2jLedxJYrOda6Mn8MdZmwZklNnGDQw9/39M+fmuOw8AEm
         EKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081954; x=1783686754;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oi2WdNtyn6OBAE6+L/wDlXe84IAgE1icOUsCwlXzl0o=;
        b=iwpJRh7iT5tJMt01tcIiABxIaQfYJxCP6hUGBiPztDm5ZeEAbLWEcRW0kGpywJu3CM
         CL9C0umLepRUmRdKJmj7szKeiDAEJrJNyis3FWi/nGhnmpnNwobQ1qujtkfaOYitJhmM
         FR1q8feMjWjtcYHsboosM4HbXqWOhhmlRVZHb9wcfzYEeKZuTDziTJoNYtjf61dODF5B
         YKO9xDgCeBGu21/SFwB5OgpRUpLDX+C6ewkAmfnXNUhuuv24O9Okhjg240/EAwcycSbJ
         lv0MdsnGYRWR+ASe/edDdAu6xL7DV1u6lbbxZ/7bQ/2wOgRMYWg21IYsH+uIoBLuqHM5
         RdqQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro4vl4TvtlhjDrFwyccV+TQ9Jz7cYuFyhqGUWIAbBHmd/fM4SDIvd5G8S4yH3zfKbnsCYhyBN1EWJ8mClkX7g==@lists.linux.dev
X-Gm-Message-State: AOJu0YzTmhG/WvC7XDUAtRlCqb2sIQ6z8SADUhONRBAbEfnxsjp3B3XC
	ZS7J8U8YApMQ0TcqERknnbMYjjQ7tRtoWD+leUA2Sq5+rc//dSSXpPUZO90k+HvS0BGhD1gSWNp
	7/zY8Zg+D+ScOBw==
X-Received: from ejbqk13.prod.google.com ([2002:a17:906:d9cd:b0:c12:75b1:2e99])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:22d6:b0:bd5:151d:2d31 with SMTP id a640c23a62f3a-c12ae45e66fmr436553266b.13.1783081953398;
 Fri, 03 Jul 2026 05:32:33 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:51 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-11-c87b714e19d3@google.com>
Subject: [PATCH v5 11/18] sgi-xp: Use higher-level allocator API
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
	Yosry Ahmed <yosry@kernel.org>, Robin Holt <robinmholt@gmail.com>, Steve Wahl <steve.wahl@hpe.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="utf-8"

The difference between __alloc_pages_node() and alloc_pages_node() is
that the latter allows you to pass NUMA_NO_NODE.

The former is going away and the latter works fine here so switch over.

No functional change intended.

Cc: Robin Holt <robinmholt@gmail.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Assisted-by: Gemini:unknown-model
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Steve Wahl <steve.wahl@hpe.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 drivers/misc/sgi-xp/xpc_uv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/sgi-xp/xpc_uv.c b/drivers/misc/sgi-xp/xpc_uv.c
index 772c787268932..79c2f00ed4d70 100644
--- a/drivers/misc/sgi-xp/xpc_uv.c
+++ b/drivers/misc/sgi-xp/xpc_uv.c
@@ -170,9 +170,8 @@ xpc_create_gru_mq_uv(unsigned int mq_size, int cpu, char *irq_name,
 	mq->mmr_blade = uv_cpu_to_blade_id(cpu);
 
 	nid = cpu_to_node(cpu);
-	page = __alloc_pages_node(nid,
-				      GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
-				      pg_order);
+	page = alloc_pages_node(nid, GFP_KERNEL | __GFP_ZERO | __GFP_THISNODE,
+				pg_order);
 	if (page == NULL) {
 		dev_err(xpc_part, "xpc_create_gru_mq_uv() failed to alloc %d "
 			"bytes of memory on nid=%d for GRU mq\n", mq_size, nid);

-- 
2.54.0

