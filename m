Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FE63D34B3
	for <linux-rt-devel@lists.linux.dev>; Fri,  3 Jul 2026 12:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081959; cv=none; b=ud+bBDCxA4vYo43C/1XmtOfe8hVaIb6fLwES5dObHwJid18rhgkFAhGFtWK38LRIJSYNEs4mZ1u2R3ItlhJuVkhIYw2gjdoNFYDPwGxZB/4NIYSPc7bP1WJj4QYq5GQa2PqDVThlCW8Oqx2gxCyXBjuGhvRpBo8hTcFx3y38njE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081959; c=relaxed/simple;
	bh=4JV/dnncChu5h8Yu3gsmWxfntPIFpYV3vfK/cEvVBdg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VhE9tWMhd3RT0J4KYyqbdiJ6KwX5jsiP7+NyW9ne1cesYJr0I/SgX3BT3+sgj/3DZg3h5GS+KuFT2vPApS9vVA3L5GGPzsTLsAZhhc1bV6n9VnpZGARj4rC+wvKsKiuKL+MdZurJIEZFgk9I66unIFgMAl1C6TbTE7CQhQpG0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YDmG1fss; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YDmG1fss"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-47499916233so95639f8f.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 03 Jul 2026 05:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783081947; x=1783686747; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSxEwrSlsWzCUsFCp9f9B1Fd4DZM61HmbiQS7KAxRp8=;
        b=YDmG1fssxKbKDCRfmO+g2q/3HrM3fZQjscpweG6qMiFVch+KBSq8rSBAi5KZ0YfdiZ
         ZVVAk07F1isTBUdjQovI1CvvHbJiUgr0angRonpPqV2KIcFviqz3U8/5xT2/ArqCp29O
         PycNQb/mVRPW3NslwEIiVA/fLCBPwJGeSTl6h8DObwU7xT0DIi/8hA7by9Z6sfewClFi
         x08AIrywm9+7jJ2WEvEKJ4ffC07xYTV1SYLAZ8DWLALMf+HKaeR3PdB/Lh3hk5tIymO8
         sBjXsnoOcCjk7uQfSfLsL5OfzovpvEYbl6qHW4C2ReW554FhL2yfBwKcvkszq3eKM7Et
         2Reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081947; x=1783686747;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSxEwrSlsWzCUsFCp9f9B1Fd4DZM61HmbiQS7KAxRp8=;
        b=NmjXD9fFijffFkaD8+KEAKeuELTpuuf6gr81pEVYFKOBRaTi7QghGePucvKXsT9dR2
         b7WL2NPrIGdyZTn1+Gf7GtXWgWNPc+9LmM7ZWvDdz7EyYErXHDMGilykRT4/ys81mJSf
         J26/IPqQmhx0rfkndI2/XaqMxb4DnP3N+869auUrrymF72aZMD5Okvdw+dMt9FFhgwFp
         lQQrJGu+X6shQQiYL+Xz66KlL8ArR8/Luwx1v/VjnR34N73N/Ng0HpT4BPXZoxIOfXAG
         x5LOVwZh3I87ovNyWdJceL7osmDQX/e2qM8ktoqeGJjMekqJVfP62Re+O86dtRsqYt3D
         jU3A==
X-Forwarded-Encrypted: i=1; AHgh+RoyRBTHgZ5Yb9DKWue2KfYrSP5EvE+DygQeT1z4DaADd5IOk3n6KkwvalselviGLsq3OUAdJvFo7HKWRNjVPA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxmrMz6qmNngcp1OBZyOqfktj3YCaPoGI/Ga1MWrMCAD5oU19o7
	ME6iyW+8w7YbE2UyPV14EtYQrozsERozhRhgc8e4dzDZST3w8YSUIxMtkVuCGWlaQJoqRLHz0FD
	gwsmUWc4pThTeqw==
X-Received: from wrbfi5.prod.google.com ([2002:a05:6000:4405:b0:463:60a:d024])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5d0a:0:b0:473:506a:e47c with SMTP id ffacd0b85a97d-4775a7cda27mr16629163f8f.26.1783081946118;
 Fri, 03 Jul 2026 05:32:26 -0700 (PDT)
Date: Fri, 03 Jul 2026 12:31:46 +0000
In-Reply-To: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260703-alloc-trylock-v5-0-c87b714e19d3@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260703-alloc-trylock-v5-6-c87b714e19d3@google.com>
Subject: [PATCH v5 06/18] mm/page_alloc: relax GFP WARN in nolock allocs
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

This WARN forbids setting other flags than __GFP_ACCOUNT but we
unconditionally set the ones in gfp_nolock so they are certainly fine
for the caller to set.

There are other GFP flags that are almost certainly fine to set here;
Willy noted GFP_HIGHMEM, GFP_DMA, GFP_MOVABLE and GFP_HARDWALL. But,
nolock allocation is rather special, so be conservative to try and
ensure we have a chance to think carefully before nontrivial new
usecases arise.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Link: https://lore.kernel.org/linux-mm/ajS96fWbG4dzP3u3@casper.infradead.org/
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
Acked-by: Harry Yoo (Oracle) <harry@kernel.org>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f47a848555077..c2839959d7908 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5355,7 +5355,8 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 		return NULL;
 
 	if (alloc_flags & ALLOC_NOLOCK) {
-		VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
+		/* Certain other flags could be supported later if needed. */
+		VM_WARN_ON_ONCE(gfp & ~(__GFP_ACCOUNT | gfp_nolock));
 		if (!alloc_nolock_allowed())
 			return NULL;
 		gfp |= gfp_nolock;

-- 
2.54.0

