Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D83E3D34AB
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081961; cv=none; b=nP5ZO/0X+akC4ILt7tl4uHIlBn6THG0mdbukWeUQsuA9c3Y68Bcoi4H8Nz81SrhXZ+hAJFI+KANF5MTL904Mu1LK1d0dx94P7lBAsdlj1BAQNZYvRGsh1ySUb4O3Z9hfKiihrXPAzH+fgOK5miWHo+/U8QDxqcopxTTLAz19v8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081961; c=relaxed/simple;
	bh=F67T0oCRBrio7FIBWLmEqRTYstsC6jLNeHD5MDQHVvg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iTggEOC/IL5c0b0eXwv2/O7KcgTj9qB8FP532cBvIILphcHPg/ZrRZGDjUc/Szw362qyvpHQ/0MC+Y0aqF8d8LAFls8AmgzvoXLQUoHBhegaCzF1q2M05FpXhQIgIdWbSgUQaWhLNTJCHT2YOeT0jIbTu43hU/3fA/SPdLnYGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RwwAUEVn; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RwwAUEVn"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-c125bdd01cbso63261266b.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081955; x=1783686755; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yrjGnXdjo/8AidhzqQZNVSKN71a7xjQgfBXFiB4gebQ=;
        b=RwwAUEVn0iqMesIZdrFQaRKbpzJFHoBz68iV/VNg7tIAF8kAg79dsY4vpO73OfCpLX
         iRosXaEL72td5w3Z9SfunshFvyoK+JIMNGBOLZu+jHckze6MZclHAliDn9wTEtpkwt6A
         1TIO8E6gFq2kqVQDK232uHejPNVgOk4ZUCalPq7ksxc/6mJsrf9isPnFomufXBPaGnYK
         OFWoFwopImvmvAz89cqoatZZFwV1XGVzNLN8QYrHx7qX76LSW7szu4uT1Kr1F9qLORYL
         nE5yES13esVBLseSaNyxvueETQy3dVBbGZf+nyMSnr/yOpgyOXEr5T2uAUiyS78/e8Jv
         rX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081955; x=1783686755;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yrjGnXdjo/8AidhzqQZNVSKN71a7xjQgfBXFiB4gebQ=;
        b=Y3coGBbyfV1eYiZJXq5xpy7XGtMFcLnlahPk1wOKPXqg5o89wzXx5Ejl0dtBGrtTWr
         AiPZiTXuO1rw1mMMlr8b0LDg4NLkVP2LISE7L+gxXEWddhZ8+xWJKAEIQZwqio2tQsyY
         x+2XQ23QAhSnGWK7HfvC8qogwLU/1NktQ79KoCVDcbGNi9+2tXWFB9AfOLngLul/BDxi
         ZG7EDxtz2QDUNx0GLHFhYgyMIOkeGYuVcGvRRgYEOmKhkpZqbx09cfdO75mLp/JWBKDb
         cqR8SzWwkeC4wV1Qm79Qw+XNxrIHMLhjz8p8kHDJdxzi97XGV3DtiWied5K0GxKA536m
         DdMA==
X-Forwarded-Encrypted: i=1; AHgh+Rp/P+CpCvm7+nC8+X30PQxJK1YNVqSzCzU5F0KDw0WJ2bHfRbwxVPK04pYJCFqFAeyvqPAUj40/RDb24B3L0A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxK6HogrVGlO73xCkhkF76xy5++5IfxS+cgnoD90Xi7hb04takL
	iParaZ+klVPGlDwv7iHWihNcxRQQpGieyWS4htIRhKP7SXZMbcJ9Xo1xCOpI9TlSGknI81Spc5n
	oHide6+QWHmOB3w==
X-Received: from ejbc12.prod.google.com ([2002:a17:906:340c:b0:c12:dc59:3d56])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c1e:b0:c12:d971:1c2d with SMTP id a640c23a62f3a-c12d97142d4mr91013266b.59.1783081954713;
 Fri, 03 Jul 2026 05:32:34 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:52 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-12-c87b714e19d3@google.com>
Subject: [PATCH v5 12/18] net/funeth: Switch to higher-level allocator API
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

