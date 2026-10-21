Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550392;
	b=d548oct+2lyD8zUDIT9yfdbYEJj5yoBvFv8JeTEMypr+D4HnC/Ru+yndKe2KkHU+mkPI
	 hmoAgL9Q+g0c86mBmvXxc1Wt4sLmPPhTbwv/h7N38QaRfofKSegLF8BzChANqkGAICJmA
	 V43Kx81rW5c1NQDlgQDvdiraYeW52bfFoyhvaJ93MCVH/wXhYa9bgIHSMxUr1nJaS63xU
	 29ELlJ2keplNHxayktTDzSmOpXOc0Eyx3qitbt3TGR1uwZTtWk7VJFqiRj2pFY3rz5PB0
	 uT2mAFiESvbIgzfr1K7LpUnz3mv76Qol1PnwYdvHTbhwG68+IzRA+j8HhmblqY6h2NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/jQfbSOqJoBgAbQs/XcGflZND2lk7u6m7SNdjISK0qQ=;
	b=qj2C0u0ijNAfovje2z6kmUo9fEre82TtwKeoar2n4qSLZYvmGjbufld1/GHFXsJNsSzd
	 6wA5pVAHHN6EX8ud3ndB87XD6k7XdPvudps2E1Y5ORIqygc3M4h9VWFkyV0ONqPeRVOQy
	 O90dK8wQitjs5XVtJPQj7MLm36gl2Wql3cPPwcnUtH+CU52N00wPjh7astPGRaiRcYYRK
	 mCFo8mXXoGGw/1cfGVycrA0qUcfZORPIzWnwnHOXUIWMEH7QVH1e7b/ZOg3vEZjk6dNCE
	 JTMEiYgtYxb21/uOlAWjZDe9kyDXAcKiay9ik9MRuEo2mpvvZo4Oqkae7//Wh2iL0eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=G8hFu4tE;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14F8606A31F
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 02:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F14F8606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=G8hFu4tE
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91b83459526so3423126d6.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 19:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550391; x=1793155191; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/jQfbSOqJoBgAbQs/XcGflZND2lk7u6m7SNdjISK0qQ=;
        b=G8hFu4tEWTXEsM2M2HEIbmM5VphvNZWXUfJnqvCTXKUzdOU7ei/ZAuR8J262hwT2Cx
         A2SpXYldLyIlbUKEcn0qgltmu0mBkd2/zfXKNEXKnyymjcAhVPXxSCbRh+WspmPs5g2N
         jPSnG5Zv+tVWN9Sx7u5y6xrHrFAxiSenY+nmj7zSUYFpX2uuabFsxxi6rZyuS75g8/R+
         HMhFlBKKaYr0+kpfp1Z+Cs2IGpFNU8s+Tr5N3xNv343lvCMagnO2Jl3VLrPKj7yPCiQE
         i77rLMRvEJ7/X0SaNGhBtplv65IQOMRaA24lmvomXyRPW5sx5D3wITSOMfOalsD3cKD5
         GObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550391; x=1793155191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/jQfbSOqJoBgAbQs/XcGflZND2lk7u6m7SNdjISK0qQ=;
        b=TmxkJ7AJ+HJYHtE6BInQdXwbiv4b2GCPN4B3vZsXUxnfia3Z3B9AZsUCRmLfQClFEV
         8wzsfeao9JSs0g5mPI0Hia689UViRY82/b8gHnh+ZYiwcTcSPv/BVyrFCOyODBRhScZp
         6nH6yPZpG3UQoON9TsjcJvtJjvzz4NC58894iIalTNaY6gnV1obsBojiZPq9jx8SdMSc
         4JNVayjwr6WLJUcU5IDLftgLRPUVzLCqGoI4YEPy0ec36qf0kxQjphv70yT4vwK1kXCx
         D0Gsf5zVUaRYdyUh2mapzJXEjcrXIdCZh0Ddww9b2jK2iO22W0NMF6QvMwyAHxRAQ5cw
         BnKw==
X-Forwarded-Encrypted: i=1; AKwUvBySLKCuQoKogw+bgCq/q3yYRFEEcHdftnAunmyIQFslVISCfKIRVbJN8H0FJWJd3GPOc0v6UpjVoHcUktiZzQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLjB9gaefBp4nWsBFlY9ctdo9s7Erusr7WfcsU8PrGR9wzvb1Wo
	M7T3AOEjf3mElcV0Y1+wrcSbjLEk05TahD8xMdxAFcmmVmcoGXkiE1BR6EYpv67lUOg=
X-Gm-Gg: AYBFou3+9BvLuOnFK3t41GVDr5IbNK+RoAx2dE8Qb1+mWNuk5VevKOY0ITIznNMeMpz
	KuY8kxJNx7ViXye9kUCaa7D3deYEwjRA/oFudsgAXbziFxQC8udQtlQRZPr0mYlByNENZU2pFUb
	FtWt0Kmv7UPkAYzkLWF9N4pqX/zja2TzV4ihoJ/9iowPS+xe3+sF1lrQ0no+0c6+lRhcMJ/rt47
	li+st+O4OHHyveIXN1SoPvsChzDWZsK0ARlP0VKWXgU8IHzR8gOWBa1q5GSNrk2xSRnUqAUVT9W
	S5MpFrW2fEYP2DhEtE44iIOLmk4fJsW3Hie+c6lN2COstHrduToAm6mwn8W/SOtuGE1LURAQska
	RaQl1uq6SY5ubxZb1bsg9bZbBJzCe/N1sDyBRIzgz/j6H9Ao7KV1rSmwXXDIqV8PlLc+zM9BJ1I
	PqKwbZsX5lUujRXp0YdAJz8vihihGdYaL9IIKvvGBQ8HSPNU6CNXHViSWypam+GiaXD/t9zp9IM
	WsE5Agh+mvEZndvBKjPaXp+zPJ19HK3LEk2ui8NMzB4+JWyt17xWVHW/iPogKUo+6tcjevdhgaJ
	K8Z6rTfsAsr/V+qNhFI5VNFi3ksOp7j2vKTAA2PHRg==
X-Received: by 2002:a05:6214:20e5:b0:919:5a24:d77c with SMTP id 6a1803df08f44-91c12f1d462mr11333536d6.31.1792550390950;
        Tue, 20 Oct 2026 19:39:50 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:50 -0700 (PDT)
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
Subject: [PATCH v3 4/8] mm/page_alloc: pass the zone, not the zoneref, to reclaim_retry_zone
Date: Tue, 20 Oct 2026 22:39:36 -0400
Message-ID: <20261021023940.1940971-5-gourry@gourry.net>
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

should_reclaim_retry() hands the reclaim_retry_zone tracepoint the
zoneref it is walking, and the tracepoint reads the slot again for the
zone's node and index. Offlining a zone's last block rebuilds the
zonelists in place, and the shrunk list's NULL terminator can land on
that slot in between:

  CPU 0                             CPU 1
  should_reclaim_retry()
    zone = zonelist_zone(slot 1)    /* NORMAL1 */
    zone_reclaimable_pages(zone)
                                    offline_pages()
                                      build_all_zonelists()
                                        [MOVABLE1, NORMAL1, NULL]
                                        -> [NORMAL1, NULL]
    trace_reclaim_retry_zone(slot 1)
      zonelist_node_idx(slot 1)
        zone_to_nid(NULL)

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:trace_event_raw_event_reclaim_retry_zone+0x57/0xd0
  Call Trace:
   __alloc_pages_slowpath.constprop.0+0xa80/0x16d0
   __alloc_frozen_pages_noprof+0x2d5/0x360
   alloc_pages_node_noprof+0x53/0xe0

The second read follows zone_reclaimable_pages() and a per-CPU vmstat
snapshot, so unlike the iterator's double read no compiler merges it.

Pass the zone the loop already loaded. The event's fields are unchanged.

With the tracepoint enabled and kprobes holding should_reclaim_retry()
across the offline, the base kernel oopsed in 3 of 3 runs and this
change in none.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 include/trace/events/oom.h | 8 ++++----
 mm/page_alloc.c            | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/oom.h b/include/trace/events/oom.h
index 9f0a5d1482c44..cbcf6fe4cc615 100644
--- a/include/trace/events/oom.h
+++ b/include/trace/events/oom.h
@@ -33,7 +33,7 @@ TRACE_EVENT(oom_score_adj_update,
 
 TRACE_EVENT(reclaim_retry_zone,
 
-	TP_PROTO(struct zoneref *zoneref,
+	TP_PROTO(struct zone *zone,
 		int order,
 		unsigned long reclaimable,
 		unsigned long available,
@@ -41,7 +41,7 @@ TRACE_EVENT(reclaim_retry_zone,
 		int no_progress_loops,
 		bool wmark_check),
 
-	TP_ARGS(zoneref, order, reclaimable, available, min_wmark, no_progress_loops, wmark_check),
+	TP_ARGS(zone, order, reclaimable, available, min_wmark, no_progress_loops, wmark_check),
 
 	TP_STRUCT__entry(
 		__field(	int, node)
@@ -55,8 +55,8 @@ TRACE_EVENT(reclaim_retry_zone,
 	),
 
 	TP_fast_assign(
-		__entry->node = zonelist_node_idx(zoneref);
-		__entry->zone_idx = zonelist_zone_idx(zoneref);
+		__entry->node = zone_to_nid(zone);
+		__entry->zone_idx = zone_idx(zone);
 		__entry->order = order;
 		__entry->reclaimable = reclaimable;
 		__entry->available = available;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4cf2982c5b107..1bb308296fcdc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4679,7 +4679,7 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 		 */
 		wmark = __zone_watermark_ok(zone, order, min_wmark,
 				ac->highest_zoneidx, alloc_flags, available);
-		trace_reclaim_retry_zone(z, order, reclaimable,
+		trace_reclaim_retry_zone(zone, order, reclaimable,
 				available, min_wmark, *no_progress_loops, wmark);
 		if (wmark) {
 			ret = true;
-- 
2.53.0-Meta

