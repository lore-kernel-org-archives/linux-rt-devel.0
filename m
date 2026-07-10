Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D5340C5A0
	for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783680165; cv=none; b=UyAk+5ioBS49nKVTNJtaD16nPrX8IoswobB0qlqACSBZlgslKc5vDrc+6zRLZkwV9OFkJ9detkLOqArHUzJeMuhVRkCtpCnsECl3FAtW2vmtQ5obxpInHzEvbdFlFagEx2RjxZz2doYCZyiD85tpco7VqMwF8HctvwMQn9h1KEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783680165; c=relaxed/simple;
	bh=hvg2eIJW3W5IntN8hk1akDVckNcGwAcn6UofVGjU3eI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lrRg4i7zZJSJICgGQX5qLoBMHn3i/WY/HvTCHSAKe6C2/SM8pcImvTTkaXWp9jistxbPS2FXMdofUOAnO3pY8vz0ckqgnj3/glHOCm2r5NIN80lJAGHe4/cvfyiJfkbH3r6+QLSKNXmovljcdteEnvT39sKFwzqv4YVpxcGHvKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/Mq2i8j; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/Mq2i8j"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-49244130073so6964095e9.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 10 Jul 2026 03:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783680161; x=1784284961; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fIBOMMuJQhrTdV+Tjmcx1KZT+n3b2t8dDXgjQ/32pgM=;
        b=t/Mq2i8jXsvM9lDMhE4zzWnuqAY7FgaEZm6XPGqZYak33x4Dq745/PWAJFiTbN8TV6
         f2mqS87PE+WR9lpfclN9Jc0ubkEIY62PPTFgG3ifOwbS5TyAdV5gqy29U9eB2Dp/4L4Q
         NhmWpXrEahjlZ0pTDRjjSeFb4RRM59M8zH5zIlf7g4pHazGwe2JRPgI34gfKsAZ1LlED
         +sviZiYw2b39lVFdyFVkoUW6CNwIvjH2Qv9rnBbr7uEkp2gC6LuGnSicsD1a3mn7pzxQ
         h3mhIxh1d8KRcLZa9pXSrrkezx5Nkurkq8O0LNZrzAjzFiW/1ClT/lAMInJa0kfM7T1m
         fB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783680161; x=1784284961;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fIBOMMuJQhrTdV+Tjmcx1KZT+n3b2t8dDXgjQ/32pgM=;
        b=oAjJBw3/Vk0trSNIqpehswKtjQ4s0vsIuj0fpQ7XO7MVsr17P7D7qSAllMM0nFfxoj
         MCV/2Id6wxOTsZ4ADUle/K2/uRFO8Y9Zcn+l0RlEo56ecFel+DPaPsOtDM/syyuFBhYD
         KB7TNIu/MXRtQNL95V1AysQn9KXamMX8WHCAnrgjZi5FEZwQqtlq17eA2R2nwZl/h0Tq
         JnCmNvv5vGzciHY9ssN/YFwDlHi0T1ght/AmTHhy/jG+7MX5S8jNrH7QGIFp8fyz0V0p
         q1kQOxtGM6iy7owIQpsRrahZX408VqSS3/FOiD9HlPFECP4xn4dxb02MdgnT56mjS42s
         /lZg==
X-Forwarded-Encrypted: i=1; AHgh+RqvdJnHRaueoC77VdNOe3YrSYi1n9xX3qvfSp9JUNNnro5ZfbPlKz+dycRZ4fyA+SMgxIUhHlYdg+oAX6QzFg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx/p2udLl4+kzRpDSPVphE1aF8hD7NBK3b7iFNyfmIh5ifYCMEg
	SRwj5wAKzvChRSheIEn/xO3Xi7tqdJ/zHQ/xw5Eca6dhb+X2T2C3ZhNfaO4rqDQ1o7t0f4FcnI/
	VL3d2dGebvZP4rw==
X-Received: from wmlz4.prod.google.com ([2002:a05:600c:2204:b0:492:1eeb:6111])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:528e:b0:492:4363:e7eb with SMTP id 5b1f17b1804b1-493e68f03damr112833265e9.32.1783680161137;
 Fri, 10 Jul 2026 03:42:41 -0700 (PDT)
Date: Fri, 10 Jul 2026 10:42:20 +0000
In-Reply-To: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
X-Mailer: b4 0.15.2
Message-ID: <20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
Subject: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Harry Yoo <harry@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, Brendan Jackman <jackmanb@google.com>, 
	sashiko-bot@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

As noted in can_spin_trylock(), using this is unsafe in this context.
commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from
alloc_frozen_pages_nolock() in NMI on UP") fixed this on the alloc side
but missed the free side.

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714e19d3@google.com
Cc: stable@vger.kernel.org
Fixes: d7242af86434 ("mm: Introduce alloc_frozen_pages_nolock()")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 mm/page_alloc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9c97a86da2b9f..5fe1c11f919d7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2979,8 +2979,7 @@ static void __free_frozen_pages(struct page *page, unsigned int order,
 		migratetype = MIGRATE_MOVABLE;
 	}
 
-	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT)
-		     && (in_nmi() || in_hardirq()))) {
+	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {
 		add_page_to_zone_llist(zone, page, order);
 		return;
 	}

-- 
2.54.0

