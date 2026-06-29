Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DB405C4B
	for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738740; cv=none; b=L7IRQ7Xp3wVX1YbRuO9+By9n3VbeQvc5Uxb9+qnLkidKZJEgtUlQXZdAA2AJT9aaChfEG86GFKcYz6dXZoV9u7uc6zeebo81FH1tQRDPbkS4SBdipQxJuXATbfWORkmUPXjNfvPv1YgzikiSsbIiCkjOOCDssfVgx7hYMxMm3lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738740; c=relaxed/simple;
	bh=KJP1T6VpLVEGG/mblidKaJdxtFAg9gWIkb2G9rhTOB0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=naSafbSefFpBImxYGt93RxBD6NlSpCpIc12q/4j87FoJKKdbzSF8mqKchwTuoFxOXwJRdF/FGA84Y/ENQQHZe9SoMt8j6LmAg/4NS2Z6g3OgD7IyfebymDCoQNatCuIiNL+RXWacKLkOjx8Gje48eCAeg6gClPkRywwNjW7dDTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fqNyQ/CH; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fqNyQ/CH"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-474170b59dfso374384f8f.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 29 Jun 2026 06:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782738738; x=1783343538; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kyq+jF6tfnrMCoNpsmlosgu1iRsoA+3mO594b2jRXtQ=;
        b=fqNyQ/CHGOW03587zKv3DVj8I0dh3IkFjqNvOh6Sb8Clv4JAW8Lp/urDbYr+i/qVP9
         d+uRI2k8uwLP2ao3j8FNeBv9EydNkULI4elY5pSbmVyGabIQfU7YMpZqLJ1m2TQXJ4g7
         g53ZLOi6xC1dWzFvMocnWkI+9xD4B5qbwEsgJROj3aJf9g1VGlHTin03ErQbA9n52ZYR
         LdTwfRdDHsXU6IuAZl6acyQxWNpyPqIOUudfSCaNxA+D7dgMeHoENZqhVkqJmD29VudN
         BV2tx6abCHbcJSMtHNwuVwdhAMAjlKfZKroWrvDa3Morq26UqZK7nH7iOOxRgdHtAYQ0
         sYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782738738; x=1783343538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kyq+jF6tfnrMCoNpsmlosgu1iRsoA+3mO594b2jRXtQ=;
        b=Z9CqyJRaBj6emqXUSNkDRb0FbU9c9Xgb52bnluKF53xia7Qw3iG1DAa48U6N2Zqytk
         iGiDv0N2E4DSJB6cUgpxtBAESD9Hb8/3V08cEu8h3QtF4OP1vJlZKXPT5Vt6d6ysTfKK
         HcSy7NuNuOZ6uxg2QtmIk1/TjRkzspt/aNlNhxLXAi+D4bFP5tTynXN0iZosD3x4tmho
         sIJXZcz2YcVUVeyZLwm+uMQ6ewinrs0C8XqusG42WbyG7PdcSR2lYROYq8WrTwlA64pP
         gJ0C81fjdQHd7zrifNfyClprARWTicg/xPqHuolSb2m8io/ENwIYsty/tmehlpGOEJ+j
         Cfmg==
X-Forwarded-Encrypted: i=1; AHgh+RoX9y0KZnkPz2tA531CyXNWA0HVmaiK+ob0S5ywPIb961FMIWrVD/HM2OoQvcBcE9EuiBHU09Fz4jMBXX0pcA==@lists.linux.dev
X-Gm-Message-State: AOJu0YydBRrxHU4reXP8L2h26moCRllnhvhjTX4sv2DGVYocsSLlSCiM
	fXG3YYofcgOCd4QmNY/nGFjuS08L8R/ifHLBfW0ff6/6KcEu/HET7Os5NtvttACYgRwseD1km9/
	8Kl7SrokCoGf19w==
X-Received: from wrim6.prod.google.com ([2002:adf:e0c6:0:b0:45e:f3ae:e713])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4618:b0:475:1583:a414 with SMTP id ffacd0b85a97d-4751583a44cmr153079f8f.31.1782738737575;
 Mon, 29 Jun 2026 06:12:17 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:52 +0000
In-Reply-To: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260629-alloc-trylock-v3-3-57bef0eadbc2@google.com>
Subject: [PATCH v3 03/16] mm: name some args in a function declaration
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

Checkpatch complains about this, a later patch will move the code, fix
it so that checkpatch doesn't complain about that patch. Do it in a
separate patch so the "move the code" patch is trivial to review using
Git's diff colouring.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/internal.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 2237eee030cba..8ce59c5664497 100644
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

