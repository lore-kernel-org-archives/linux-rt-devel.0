Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B11410D2D
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738746; cv=none; b=kVUBA841ks+0OFzXeApwR6gSV+svjRdZXi8Ae86W7VgpRTfgV8c4viKB7Gs6fwHoFHYiRWCeKeSm9CPUBcTCMpJACBODRNLN+MeYEBB9VNfWHQC+cnpC1bK3L/CYH7vozlom9ybeQxOdE+9Owo5diB39kEFqyjPYjFEabMd4rHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738746; c=relaxed/simple;
	bh=mjbpH/Ax6zXqST/jfztAcWFWimam01qcy6f291QHYyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tWjU4spmEfvxYuSVy/wHgS/7Id9JjLTvZJTQ2o5JHaPC54bwW8m135RJ+7jJhDYpUHJnzfame7q+vLGQjU0LioqxOndi05v6mO6XVufW1l8HOy892tnAcxlXUPOer59GlpPn2it0/lJ0lINSIBQhKVK8/tsgNV4dGO4Updli+Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WYdkG4yz; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WYdkG4yz"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493a6fe9ebdso8096105e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738743; x=1783343543; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LAoUsjWph/3flUCSB7flZmzGzWVdy8wS9hni21TX4N8=;
        b=WYdkG4yzlXe6EWb36eaOxUYLPJMB+UcI1uIK9nelmf14LFzGSelkR7kSsGUGASjbbm
         zUI1wIydmfCbsCstKGxXmK+oWHSG340WhI/fzTbytYxfhEAojkM93FP6yeUe+Uo3tnGi
         k5KyeHDGQEKAKH3BGUQAM6wzGwA2ESWkIdu1MIP8hLBXmt0DNE31yT9aGsVd/y+agnTp
         wbBna+VtW73wjh+ctd7iF1yVIUQTGPtBZzdoaYywpp7WnhhYEfecAvOh37qNF5NrqIeU
         teWjzph61PXWbJTUZrAg+10lrLkuuvGpw9Gk6ZUMIok7NeKStbbm1iBHghiCvjRvw770
         Bu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738743; x=1783343543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAoUsjWph/3flUCSB7flZmzGzWVdy8wS9hni21TX4N8=;
        b=I7RDb90BSYNQ9F+6WS3uZAgMBR6wvCrWTpcI7sDzFPKOc5zBFxqSiQg69FuvhmW3v7
         VWIOUho6Fl2uh3K1pZlsVM6vJuLB6NKDNlR4XjLokb4XJh1ilvg0rRT+Uk2N+sW1N4Bz
         VSBCAlO2VkSymB65a9DF74NAKYnhDbUgXx5C5eRnxylJxWb7kCIY2qqcDuAjqHjD2Fgv
         zhtW2TMQJ6P/TZY2CDw7mPQtTSvbhExrK0q6LbEk4EECZ4Wwb9lGe9nRuE+N59+h3SdE
         d9iRRhXI5kGg0bBNgk8ALfm55N9KWlR3tgUfa9ezEGNEGjqY9o+I1KKyt0WtLZ5A80uV
         Gh8g==
X-Forwarded-Encrypted: i=1; AFNElJ+eoUABwlW+xO/C3fuMz5hdwHCpDktQVl0jFl4meldPYF7oXkxo1ZMP5p22BtUJCuZwltDSlI3gDAzMt4VV2A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxtPKBfUmKVVpAy1SzyExW6my0I0MZMBn8ombBPl/sqPhf1DZTk
	NvdkQ6zxfeNF5IyAMxG9yEea30fiB1VNMJ2MNxBeLLapQuv8NvCaSbJsT2+j/coL/ZEjkDuVAyL
	4VpftM6MtpPNx5Q==
X-Received: from wmjq19.prod.google.com ([2002:a7b:ce93:0:b0:492:450b:fe7b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e45:b0:492:4948:bfce with SMTP id 5b1f17b1804b1-4926fc45f89mr171546305e9.16.1782738742815;
 Mon, 29 Jun 2026 06:12:22 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:55 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-6-57bef0eadbc2@google.com>
Subject: [PATCH v3 06/16] mm/page_alloc: relax GFP WARN in nolock allocs
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
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8d409d075e3e9..9cb3f1665b41b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5355,7 +5355,8 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 		return NULL;
 
 	if (alloc_flags & ALLOC_NOLOCK) {
-		VM_WARN_ON_ONCE(gfp & ~__GFP_ACCOUNT);
+		/* Certain other flags could be supported later if needed. */
+		VM_WARN_ON_ONCE(gfp & ~(__GFP_ACCOUNT | gfp_nolock));
 		if (!alloc_trylock_allowed())
 			return NULL;
 		gfp |= gfp_nolock;

-- 
2.54.0

