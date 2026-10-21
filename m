Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550394;
	b=lRjItnX8L3AyHeNjvSBG1LBxQ8f3UaS7fxUsZdHHBurRRb++NxUwpnVJo9/CKTMBvD+0
	 ob0ix0SGCogN/Xx9VaMc2Ik3GjwjP+witzBUZ/xxMc2U2dXT7iX8JNILPw13SAML8GBaa
	 DEKU2Nm11HgUSTIFEkNf7gj2MP28bO+n4MmsdFRiv8yfxhj62fLhljZR2JvJxHmRAbGXz
	 TMQ68MdlN6oBBnhxnBRw20QtTSP1Q7TNIhjZ2oKjVUA6dAspFeFruTh5uj4k/vy5OQzOH
	 vw7XC242B6JjxKLji+2dy3TgwfFxroayVuyTr5wFMD8FHijGssSKF1bnX/UmqjDc9BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7QVMVg0G5DwyEPbJ20bA+yPvHu9eLQ0AyyKAfGn2Dqw=;
	b=EutYpny4uR+RQe3saEoM4XLiodUCYbg2SXsCxbcWAsaFPWLBIybYlEfGXKS1EzyRS66O
	 sXc/ajHmoR3Bu4rU2KzmQSjzeV7+pbj4EV1bxQAUvNDeEbyqev+XqxqsRxRQvgdmXW0bx
	 yBaIImoDQFwhyirW2SbC86hChYEEJvKLVy9Hvyo7ZeJ4OgNXEFKkxT4Wt01I7twJI/7cN
	 tyBb9KqIyCCIDAi5xm2r/Rnvbc/0remOJoC1OdpnTAY1+HmVZCalwGFCMoL0uXkgDgQFG
	 jpXkygb70j+DKuqcVJHrQnKLgYndUVs7sM/9UcBFa2wWm46x9AYoh8ogOJFE6Vn0luw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b="bS0/egmB";
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2578B60A2606
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 02:39:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2578B60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=bS0/egmB
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917997ab0d9so2859266d6.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 19:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550393; x=1793155193; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7QVMVg0G5DwyEPbJ20bA+yPvHu9eLQ0AyyKAfGn2Dqw=;
        b=bS0/egmB+AEK/LQ+IjFp4K98H8P4jcsoFtauhQ0K0RE+PC7pRAUUqhkAmRx17EKVTE
         QVhmXffKFcdPj2g3GP0EDRzOsA0UPnRCSxooQsdoVXdNJw2TKEm8BbAgTBLRhGEN+cud
         zvOH2d2aKhy5Tc32qXdwyBPc21Mu+mddcDnrKunx3WXdRRkB0PeyiSwihMgoDY1bNwPB
         jV1v4A9PjtfHtktqR4JXcsPWsFGSUzrIreU/Opj6gCixvT+c77DprcN/btp7YcxwkXEp
         hG/GPGxf8/eVVdTdlI6d5cOM6Jj6vD5hSEmV1tg8u0yvLvYNmtd3eROj+CgiAoKoTFDx
         Ac5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550393; x=1793155193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7QVMVg0G5DwyEPbJ20bA+yPvHu9eLQ0AyyKAfGn2Dqw=;
        b=Vh946VhmSXmxuA3ef/nnffPZk/yrh95CGz/KpSjxNfO6nBT8niF6H06tUe8q6WWZRT
         vkzi1m9mgmzxGmXMwmgXUrS+lZ26Tp+tSUAvDJ3SQZOcjl2RK0qOgq6CdmEx3IqHEfEc
         nY0FtO/l5XXwBB//WOjvz518RGIwGYdMJf+aTBmzyJJUUKJcphq0QpL59hRy9Tn40KWW
         +HjHT4s0eywEgzzLYsu2it1NdO+fhiYexURzka+iFTXVwYseyTG1PvUDRaMzTZP2z73L
         hIjm2VOWvNGPtfs5oJdrft460SuxiYxNuZIwYFatmCbGFb31nj7Kz2OIxqf6dmi2AZ9L
         1gXg==
X-Forwarded-Encrypted: i=1; AKwUvBwnJFoc+dXwe5qmCP1T+TwwZI9tzumEtNewQ/yTYoFtaCFFfwDUl9S+IHpDg2vGEnhexTSmN9svYO5MnAl5HQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJsL8aEsbdG5Vz01eWzVydT0CL4eMXWI1/0TboSQFgz1GvRm331
	yd+9j3bOn576qpyVKWcaqGx2N2ALpjP7uGhU4W0CIew5qw2w7/jUdmmOzr4UsIHgFZU=
X-Gm-Gg: AYBFou2busDI/XVTHefxLBGtQttm1M9llXcM3wQv8cDuTc5pgo6GidFWOBwWHOA7Fz8
	dOdO/Sc9VD47LnzAGMWBA8+cynt1ule6cwkoaHOqJ9kPo7KcEAUeRlADTOVHEYnFHEVxcuQSLm6
	odJSgM5psen31HFM8cge5Z8hx3VqNKVgvyZufnuMl62v5U9IwOIoNQ/tKUsqK3BTMooKpMlBwwI
	p4azSe+2BnFQWY781TwjOC0EDrfuvw5CuV68+ncMhMERmg4waEJ5Rc3wgtWKuc9z9rw4xAx1AqW
	Xh9HBdpTrthYz2tl+LHT8d5g7J4zPesIKTl60tFNqdU0Vwa5R6qhzM83JpdUI+vMe4qjDkAhset
	7S9b2tYJhcrahOFP7jdXiJO/oUqOvFF5OnkQNYyIhJCS+L0ROupG4IWLE4xSKGCB9eDsp9EGUtC
	M3la2/c99ofL+LQKGEW+YsijagqEfCvmrYjiv1kjyascScgSeWcCmyhWOLbYlmiTIiStXcyMdN4
	ZZtcfj8WhQHTlXDFaSGi6TWHD4kEOJZEslaMxMAlLRkYCpqR3S8AB47OVYg8ILqx7dFr72AB43L
	vRsbifNW1RT5E6pmsFxR1BVIk2EHQtgEZyNzDCN4MQ==
X-Received: by 2002:ad4:5d67:0:b0:91b:d948:c415 with SMTP id 6a1803df08f44-91c12f1de15mr12928996d6.44.1792550393065;
        Tue, 20 Oct 2026 19:39:53 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:52 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	rientjes@google.com,
	shakeel.butt@linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	mgorman@techsingularity.net,
	anshuman.khandual@arm.com,
	Bessel.Wang@huawei.com,
	jiang.liu@huawei.com,
	stable@vger.kernel.org
Subject: [PATCH v3 5/8] mm/page_alloc: retry allocations that raced with a zonelist rebuild
Date: Tue, 20 Oct 2026 22:39:37 -0400
Message-ID: <20261021023940.1940971-6-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021023940.1940971-1-gourry@gourry.net>
References: <20261021023940.1940971-1-gourry@gourry.net>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Onlining the first block of a zone rebuilds every zonelist in place,
shifting the slots after the new zone. A GFP_KERNEL request can then
land in ZONE_MOVABLE, and a nodemask request can land on a node outside
its mask.

The iterator approves a slot by its zone index and node, and the
allocator loads the zone from the slot afterwards:

  CPU 0                             CPU 1
  prepare_alloc_pages()
    first_zones_zonelist(nodemask {1})
      slot 0 (NORMAL1) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [NORMAL1, NORMAL2, ...]
                                        -> [MOVABLE1, NORMAL1, ...]
  get_page_from_freelist()
    zone = zonelist_zone(slot 0)    /* MOVABLE1 */
    allocates from MOVABLE1

zonelist_update_seq detects the rebuild, but only the slowpath's failure
exits check it, and this race ends in a successful allocation.

Check the count whenever an allocation succeeds, and free the page and
retry if it changed, as the memcg charge failure path already frees a
fresh page.

The fast and bulk paths sample the count without waiting for a writer: a
sample taken during a write only costs a retry, and a fastpath
ALLOC_NOLOCK caller can be an NMI that interrupted the writer. They read
the seqcount inside the seqlock, because on PREEMPT_RT the seqlock
accessor takes the spinlock while a write is in progress, which
ALLOC_NOLOCK cannot do.

check_retry_zonelist() now returns 0 when the check is compiled out, so
a backport without the hot-add change stays harmless.

With kprobes holding the walk across the online, the base kernel
misplaced the page in all 18 runs, through the fast path, the slowpath
and the bulk allocator, and none was misplaced with this change. The
check adds 5 instructions to an order-0 allocation on x86.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1bb308296fcdc..dd8c9046f9a06 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4419,12 +4419,25 @@ static unsigned int zonelist_iter_begin(void)
 	return 0;
 }
 
+/*
+ * Never wait for the writer, which an ALLOC_NOLOCK caller in NMI may have
+ * interrupted. Read the raw seqcount: on PREEMPT_RT the seqlock accessor takes
+ * the spinlock while a write is in progress.
+ */
+static unsigned int zonelist_iter_sample(void)
+{
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		return raw_seqcount_begin(&zonelist_update_seq.seqcount.seqcount);
+
+	return 0;
+}
+
 static unsigned int check_retry_zonelist(unsigned int seq)
 {
 	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
 		return read_seqretry(&zonelist_update_seq, seq);
 
-	return seq;
+	return 0;
 }
 
 /* Perform direct synchronous page reclaim */
@@ -5114,6 +5127,12 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	warn_alloc(gfp_mask, ac->nodemask,
 			"page allocation failure: order:%u", order);
 got_pg:
+	/* A rebuild during the walk may have handed out an ineligible zone. */
+	if (page && check_retry_zonelist(zonelist_iter_cookie)) {
+		__free_frozen_pages(page, order, FPI_NONE);
+		page = NULL;
+		goto restart;
+	}
 	return page;
 }
 
@@ -5198,6 +5217,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	struct list_head *pcp_list;
 	struct alloc_context ac;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
+	unsigned int zonelist_iter_cookie;
 	int nr_populated = 0, nr_account = 0;
 
 	/*
@@ -5238,6 +5258,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	/* May set ALLOC_NOFRAGMENT, fragmentation will return 1 page. */
 	gfp &= gfp_allowed_mask;
 	gfp = current_gfp_context(gfp);
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
 		goto out;
 
@@ -5287,6 +5308,10 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (unlikely(!zone))
 		goto failed;
 
+	/* The zone was chosen from a zonelist that a rebuild may have changed. */
+	if (unlikely(check_retry_zonelist(zonelist_iter_cookie)))
+		goto failed;
+
 	/* spin_trylock may fail due to a parallel drain or IRQ reentrancy. */
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (!pcp)
@@ -5427,6 +5452,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 		.alloc_flags = alloc_flags,
 	};
 	unsigned int fastpath_alloc_flags = alloc_flags;
+	unsigned int zonelist_iter_cookie;
 
 	/* Other flags could be supported later if needed. */
 	if (WARN_ON(alloc_flags & ~(ALLOC_NOLOCK | ALLOC_NO_CODETAG)))
@@ -5456,6 +5482,7 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 	 */
 	gfp = current_gfp_context(gfp);
 	alloc_gfp = gfp;
+	zonelist_iter_cookie = zonelist_iter_sample();
 	if (!prepare_alloc_pages(gfp, order, preferred_nid, nodemask, &ac,
 			&alloc_gfp, &fastpath_alloc_flags))
 		return NULL;
@@ -5472,6 +5499,11 @@ struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
 
 	/* First allocation attempt (or, for nolock, only attempt) */
 	page = get_page_from_freelist(alloc_gfp, order, fastpath_alloc_flags, &ac);
+	if (likely(page) && unlikely(check_retry_zonelist(zonelist_iter_cookie))) {
+		__free_frozen_pages(page, order,
+				    alloc_flags & ALLOC_NOLOCK ? FPI_NOLOCK : 0);
+		page = NULL;
+	}
 	if (likely(page) || (alloc_flags & ALLOC_NOLOCK))
 		goto out;
 
-- 
2.53.0-Meta

