Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550398;
	b=HB+mvvKYs9981P1Ir92kdgIkLXmMzrQvEWo4tHg6IWclxpgybkZj8IhXsQ88zxrzYril
	 3CENNK+AdAt1Uf3jqx4MczXy68ZeV/FZHHPNIakxCKNzcHBSLqovhZkufahc0SkTizKvM
	 cRonpSmXNAxoSaeLFcfUGC7h1wgfT/+OBxngC0uw660AAb+noTiwq5Aop1BQ6YHR9zyHv
	 vDhAs9Ors7NENSrREWaETO+J/BLThBq1OtnfaJyA7HSyuLgVCuBDmori9L6jjzro2xOBG
	 3KjTzP/QJYMKpDhuHzokCIqMtRR9D3y/S4u4ROrxVNMVOD7j79wP2Ad9CRSrSC4Mvrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Pvfl7DviDeBHS//72/Hi95KkgY+0Xu5/rbujyfFHLK0=;
	b=gEoGUBTg+ogIHUIu4iR8GygvTdYRzWZecMzjCWQomyxmQh5EuIVDsWRkj4Xgg25Z53a7
	 u1YcG9WKh+d5qmvdxsV4PO15QA6ZfvyCNa8fuP9541PSyw1irfIMki+jsGH4JuZhz699w
	 /YW3z7TiN5JggPmc+W8azT3iCOoMjqY3HfJamO6EhFzKkaixAEOqNG+IIjh/6vhUh/6ei
	 Cnn/023OAKT/aR2dLRq17c/rvy2UWOb6mfdri/codsj0suSajAZimWoc/d8gEB1E9EfEo
	 hRKpB8p5OMXW5W2CO3IT4TAPEjYs86FebM0lYb/CTEw+I7xghg5R1zUBCR14JzDGU+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=bAvORaCP;
	arc=none smtp.remote-ip=209.85.219.47
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027A260A2600
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 02:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 027A260A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=bAvORaCP
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-917aca1aee5so3151926d6.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 19:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550397; x=1793155197; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pvfl7DviDeBHS//72/Hi95KkgY+0Xu5/rbujyfFHLK0=;
        b=bAvORaCPcHP4uxZwHI9ywnySbhZyGxX7HVFTlILj9TuR3hn/mWGOJzllyigtryw7Gk
         3X1ZRloKO+Dr1s46MSfDu47p3oEvlIV3btMFKLSXqNGy8FLVgtTcwTSH7h3nbG4X+abn
         dMNPe3wXizCvg9wPxq1RZ/curl1qzxpONFqc5XpKCYudGBZNkcOgAAei5GHQ1ubOof49
         JAGsfks768osgxrBiELIfI1O9JoOjsBvxvNGb8PWWns1eDzc4Z+VEm+n0z1x4+twN30D
         UBInUiidSrBelBQKpUSuk9Jftkie38HVsmqfgA4mX3iB7lYh0/ToCc0LyrQcIakoB9cZ
         03Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550397; x=1793155197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pvfl7DviDeBHS//72/Hi95KkgY+0Xu5/rbujyfFHLK0=;
        b=ID+FjJMPI/NKuCVJgR4DVqRV1WSnOx/0pN2/nH94U8vfxvZXDbWiKjVzCfrZgALa/k
         3BB1Xhs7RdexTYQBcPZlkw/ot+IH2zmeMjn+xu+uX04mqR3UqemedcBQrx16iq8N6508
         KG04ONqTaoMRSIMaYcftyilPZb+BZT3py+n9+fdDkG1lOVCCcObsRxQqFfbhvSUXegiH
         MvRWbAcgC96mjQp3ANumVPC/NhJRcdljcYrhUhiAx4lb1mBf+Pp8EL4y78pWkhGEeGtS
         lOxoWoeQlojdnSauc87dV3Q+mHiddsSNPZwwJCU/qGhEglP7iQNMTzhFqm0P49Jr1J8o
         OP7g==
X-Forwarded-Encrypted: i=1; AKwUvBwnORA5ee0wvTvz9Rdn+JC1g3w7P/21lnCkFrw7kdrf0wV9J7zP1EKnfIQ1k7ABbdYnFN1LtsNxUSVZpRbXfQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJJWPNn+uznrM/rQqOUN1uUmhgTYsKJ4LKd7SDMMugyFtH/f7tb
	3CQ2NSFoafl9iqPrVIYBXP9TfM8BXnMtscXhzx4mUgy/uTLpsH/oDSCeV5SjsHTW2/U=
X-Gm-Gg: AYBFou2RU6+XJkuUQZzD8RyhmQmXBwnm2MRxInUOysiozOweNfssyZ4+SQc2pkEVdJR
	BpVUTaYJhBFswcHsW6VZguUoAo1emagMRsrAD4iX2B0oU5P0tmmUnvqkMAOQyHJ4bBM9ga1dv1k
	Y/NpPp/OSIgF6SbAQanCJIUqc5zkRD1O26WN5OVWVRC9pzjbcisInSs4p3okZy7w1a7tSIkVZ6I
	VpMU/EpLI1QaCoToItLOg9eFGziaDVP5JqvMql3mD93MP/IEqpPS8dGkrRlJ6VaCQCt9AD6YQxx
	NKG/uhqAas2WeNWFyqCHo2dFg3pSa8DQpTogXHi04gw6BKgJO9yq2LF7FIWAADD/vgQbm4oXC9H
	4uqEn9OzjYD3HvXv5FH64Oe6KhF5X68PUX/fdUZ0GHXUTryX0l9Eu5H05y/e4SgItGWNwJTm+5Y
	nGsKSkF5Ae/sH5JloeiWHjVFJp4BvyQBUqWVea/n/CqTAQPH7EyNm1KFu48V0E/0hpxq93EXzMd
	xvHQPr/BmhjiEZ1we0rEVlfyNL6K3UFNOxkg7l49weSwcrlIq9W5B9MiAOe6uu5+qmK7JSHOrce
	vNLCXjnzWqgsnqHwxrxJMDwjGQ9/Y5tXzljZwVebpRQ/qRjlb3Psyma1rJ+u+DA=
X-Received: by 2002:a05:6214:300c:b0:915:eacb:cb90 with SMTP id 6a1803df08f44-91c12dfef37mr14292296d6.5.1792550397043;
        Tue, 20 Oct 2026 19:39:57 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:56 -0700 (PDT)
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
Subject: [PATCH v3 7/8] mm/page_alloc: retry alloc_contig_pages() when the zonelist is rebuilt
Date: Tue, 20 Oct 2026 22:39:39 -0400
Message-ID: <20261021023940.1940971-8-gourry@gourry.net>
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
shifting the slots after the new zone. alloc_contig_pages() can then
take a range from a zone or node its filters rejected.

Writing 1 to a node's 1G nr_hugepages while that node's first
ZONE_MOVABLE block comes online puts the gigantic page in ZONE_MOVABLE,
which commit 79b63f12abcb ("mm, hugetlb: do not allocate non-migrateable
gigantic pages from movable zones") excludes.

alloc_contig_frozen_pages_noprof() walks the zonelist with the caller's
gfp and nodemask, and the iterator approves a slot before the walk loads
the zone from it:

  CPU 0                             CPU 1
  alloc_contig_frozen_pages_noprof(GFP_HIGHUSER | __GFP_THISNODE)
    slot 0 (NORMAL1) approved
                                    online_pages()
                                      build_all_zonelists()
                                        [NORMAL1]
                                        -> [MOVABLE1, NORMAL1]
    zone = zonelist_zone(slot 0)    /* MOVABLE1 */
    alloc_contig_frozen_range(MOVABLE1 pfns)

Check zonelist_update_seq before using each zone the walk returns, and
on the way out with nothing found, and restart the walk if it changed,
as the hugetlb pool walk does.

With kprobes holding the walk across the online, the base kernel put the
1G page in ZONE_MOVABLE in 3 of 3 runs, and this change put it in
ZONE_NORMAL in 3 of 3.

Calling alloc_contig_pages() directly, GFP_KERNEL with nodemask {1} got
a ZONE_MOVABLE range and nodemask {2} a node 1 range in 3 of 3 runs
each, and neither did with this change.

Fixes: 5e27a2df03b8 ("mm/page_alloc: add alloc_contig_pages()")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 5ca8e57c5fcbf..96ae09c8099be 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7592,6 +7592,7 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 		gfp_t gfp_mask, int nid, nodemask_t *nodemask)
 {
 	unsigned long ret, pfn, flags;
+	unsigned int zonelist_cookie;
 	struct zonelist *zonelist;
 	struct zone *zone;
 	struct zoneref *z;
@@ -7600,8 +7601,13 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 
 retry:
 	zonelist = node_zonelist(nid, gfp_mask);
+	zonelist_cookie = zonelist_iter_begin();
 	for_each_zone_zonelist_nodemask(zone, z, zonelist,
 					gfp_zone(gfp_mask), nodemask) {
+		/* A rebuild may have shifted an ineligible zone into this slot. */
+		if (unlikely(check_retry_zonelist(zonelist_cookie)))
+			goto retry;
+
 		spin_lock_irqsave(&zone->lock, flags);
 
 		pfn = ALIGN(zone->zone_start_pfn, nr_pages);
@@ -7640,6 +7646,8 @@ struct page *alloc_contig_frozen_pages_noprof(unsigned long nr_pages,
 		skip_hugetlb = false;
 		goto retry;
 	}
+	if (unlikely(check_retry_zonelist(zonelist_cookie)))
+		goto retry;
 	return NULL;
 }
 EXPORT_SYMBOL(alloc_contig_frozen_pages_noprof);
-- 
2.53.0-Meta

