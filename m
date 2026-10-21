Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550389;
	b=baKOcqzCG6rkbWzlBvB49jYjzkiUbeA2EgGX65esYHAd6lbq3hrhkoUZbY5rix118+ly
	 RJ9F9n2TB8Zx+D/bIE4NElJRT//cV2Qo16y08WvBLt0WrLiHZfFzXwbZEDcYVmF69PNK6
	 VR5ISvvYNKgo8ortptpR9ycfYav8b+qfx3iJ6zNvX8IDF6uQw1MlGKuZuW9nj7FcsyJYs
	 ynSxOmTiQyCMOjM/2rS85RiLUuatw25fU1fqD5bQkayKIkXrVyhVOeJyVPuKg/198pSWF
	 LthaKAd3vOgkZ7xGusoBBVhhn0i3KdVUtZMPRnoBhD7SRqZCX7ArVk5gsEOZUntp2Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550389;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wZzEJG+KuWuKC34TpbwLEcO6lDSRUEVZ4rjGM6mtgtM=;
	b=wbbZoHvoO/+l9s7wxojLgO8Ge4f8psA4kLbUrSjJMH/kQNXEjwBzIpqtvYhTVqSijvfw
	 jXEd58lN+LVA68xg3SV+SZUYEhfISGejrM9lK9xtfyhBrHbeVKuof6mwFrr31am3I9Xhf
	 eKiBWgbt34d61v+hwbIKosKgMJ4NlpqiYt2i8+vEWHBoGClTrNw96MKvGRxSN5PRy4mpu
	 pjF8CV/J0MnHISRGCenQSJzW/WBsJI2n/w7x1+JXiGctH3Li1QPuH55vsLDvDN1a8KSk/
	 mNxpzJhAho8qZBe6xXBwJbPa7J2tcfLwP/GLoll+jZ/wZ7urdMcz2uweY/HtwaxLkVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=sBIQNJU1;
	arc=none smtp.remote-ip=209.85.160.180
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE981606A32F
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 02:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE981606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=sBIQNJU1
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-5364d86f7f0so3176841cf.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 19:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550388; x=1793155188; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wZzEJG+KuWuKC34TpbwLEcO6lDSRUEVZ4rjGM6mtgtM=;
        b=sBIQNJU1TuaXG7bi1CrVWxH7K4S0ct1vmPj1J1sfUlCoyYt4pSQSpxLc1ExcrhHJtl
         tT+vHqCbQeDR6r9YjVhnKaWuOZectn1gum9rp5HIc27Dkhsny5IpYHokpl7w523nRm8R
         8XwpfNlKPxrut/vkPUYqbY1RIT3qsZ3/ezKiT3r+xylFAD7WDl/PTRCB1EsFiaDYe5Nr
         teIWJcqZZjftUlr5La6+koh5FzTTKdsjytwWdDERf4iPdRMsnySVMdT7FtzoWdV+EyRs
         Nr/LkeKKlqA8N5ZyD34YTqTJCreJUtNB1D2kkNCH06grk06iAL8oue5qymKWTwbkPqCT
         gMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550388; x=1793155188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wZzEJG+KuWuKC34TpbwLEcO6lDSRUEVZ4rjGM6mtgtM=;
        b=Ysi+FbaOI9aeOxtontnBgzzVyf5DgSOwgsUob/8JNL56Kf/+LDKKMfWBxU1sMAFYIB
         gn8U23Y440YgT4zELluVu3riSquruD137HLchUL3I7atXHNbuFcPOpivIDTqEcNYYEqJ
         +GULCX25ano9uFU9VL8+FLNVLCsuJc0x20LLT9c67Qf9AEdLAsbCdmoeT6bZmma6FcOE
         YhayiunOrmLqKv7NFzRx2FmhpEaeg9NlDbev7DWh4zK6gIRNLYuns9DEwt5IMlgjyQqG
         wQxcOMJRRAzr215hFjeaUPmqazw1SirG87KV2WUoRIlDhjwsbtGCbfp7tmw+6ZijS4T+
         BlRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwofRpSytAmKBzPHuyceHHQb9oW1V3MvOZxis8eX7QbWTdo5hHUQu8tD4FUzoQrRdR+6KRlxlCJClpenSyCIA==@lists.linux.dev
X-Gm-Message-State: AFq9FYISJb34ejk3tEfHMGkLY4jFJmno6JmeNnbhJnWkyFzM7uedCI/b
	YJW7dPOmgdgmA7TwNOH53ZxTRJHL71A5WhB+kYyypYVc1UUgZEq4M48Jgv2VLA1RZDE=
X-Gm-Gg: AYBFou2pf8MwyhdRu2DDgzR90QPrXKm59WSUAvd3mnv7CPRTynV1eJJjceRSzOC6zSC
	a9+oiFql9/hytRNqOP65obFDyYEybUad991By20KXoM/XQmz9Pq1P7fssgOETqx+mrcVv5AS2KA
	CmrKU3khMWCPZIqp3SaEFmOUUSj60f8SG7eJdcTZIpc7DT8Anua4zFXl6AqT0mgct+9u6D+Gtpn
	HfZuKdYnjWZxf0vJWglz8Ff895DB0VByAOIs2uqy+uQl3H0mX7YlPTCVDcp2mpD8gnsFFFO/KQU
	nLttRJh5NfIlUz3dmpBUYuz0VkId8AK1oBjF0iaPL++YuwLWwAZdN2ptG01NC43eWLBu4oy2ygP
	V4nPbosGRgg2SvDXs+ky0Mv2PvjrpkSD6pR1huJaAHL+LaewY2gk9WOxtMCdmou2o6BaF4EVKxA
	BhJ3U0IT3GjhnQSfGq3xyJE17UPLYL0Yuch4b074iochCBNTBz9G210ZVsd5EXyqvfjrVE14P6E
	S3XTB/S1jgvj2bkzkS3Qq87jcTC41adeYBlEpp5lIevD0+6RmaQcEQTb1AXwsTJO+VeKpT48rNg
	NiXcqSIZ+izPB5oqCYiry/RB4va9HsG3+SOd8bO5F2MBTJdvIcwzRLelkpA5pWI=
X-Received: by 2002:a05:620a:28c8:b0:93b:db80:e0cf with SMTP id af79cd13be357-93f57f4bd53mr204750985a.60.1792550387716;
        Tue, 20 Oct 2026 19:39:47 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:47 -0700 (PDT)
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
Subject: [PATCH v3 2/8] mm/page_alloc: snapshot the preferred zone against shrink rebuilds
Date: Tue, 20 Oct 2026 22:39:34 -0400
Message-ID: <20261021023940.1940971-3-gourry@gourry.net>
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

get_page_from_freelist() and alloc_pages_bulk_noprof() reread
ac->preferred_zoneref->zone at every use. Offlining a zone's last block
rebuilds the zonelists in place, and the shrunk list's NULL terminator
can land on the preferred slot mid-walk:

  CPU 0                             CPU 1
  get_page_from_freelist(GFP_KERNEL | __GFP_THISNODE)
    zone = NORMAL (slot 1)
                                    offline_pages()
                                      build_all_zonelists()
                                        [MOVABLE, NORMAL, NULL]
                                        -> [NORMAL, NULL]
    rmqueue(zonelist_zone(slot 1), zone)
      zone_statistics(NULL, zone)

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:get_page_from_freelist+0x6a5/0x15f0
  Call Trace:
   __alloc_frozen_pages_noprof+0x125/0x330

Read the slot once. Zones are never freed, so a stale zone is safe, and
a NULL slot fails the same way as walking off the end.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c7125f6693574..4cf2982c5b107 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3794,12 +3794,21 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 {
 	struct zoneref *z;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct pglist_data *last_pgdat = NULL;
 	bool last_pgdat_dirty_ok = false;
 	bool no_fallback;
 	bool skip_kswapd_nodes = nr_online_nodes > 1;
 	bool skipped_kswapd_nodes = false;
 
+	/*
+	 * A concurrent zonelist rebuild can NULL or replace this slot. Zones
+	 * are never freed, so reading it once keeps a usable zone.
+	 */
+	preferred_zone = READ_ONCE(ac->preferred_zoneref->zone);
+	if (!preferred_zone)
+		return NULL;
+
 retry:
 	/*
 	 * Scan zonelist, looking for a zone with enough free.
@@ -3846,7 +3855,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 		if (no_fallback && !defrag_mode && nr_online_nodes > 1 &&
-		    zone != zonelist_zone(ac->preferred_zoneref)) {
+		    zone != preferred_zone) {
 			int local_nid;
 
 			/*
@@ -3854,7 +3863,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 			 * fragmenting fallbacks. Locality is more important
 			 * than fragmentation avoidance.
 			 */
-			local_nid = zonelist_node_idx(ac->preferred_zoneref);
+			local_nid = zone_to_nid(preferred_zone);
 			if (zone_to_nid(zone) != local_nid) {
 				alloc_flags &= ~ALLOC_NOFRAGMENT;
 				goto retry;
@@ -3916,7 +3925,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 				goto try_this_zone;
 
 			if (!node_reclaim_enabled() ||
-			    !zone_allows_reclaim(zonelist_zone(ac->preferred_zoneref), zone))
+			    !zone_allows_reclaim(preferred_zone, zone))
 				continue;
 
 			if (!node_reclaim(zone->zone_pgdat, gfp_mask, order))
@@ -3929,7 +3938,7 @@ get_page_from_freelist(gfp_t gfp_mask, unsigned int order, int alloc_flags,
 		}
 
 try_this_zone:
-		page = rmqueue(zonelist_zone(ac->preferred_zoneref), zone, order,
+		page = rmqueue(preferred_zone, zone, order,
 				gfp_mask, alloc_flags, ac->migratetype);
 		if (page) {
 			prep_new_page(page, order, gfp_mask, alloc_flags);
@@ -5183,6 +5192,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 {
 	struct page *page;
 	struct zone *zone;
+	struct zone *preferred_zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
 	struct list_head *pcp_list;
@@ -5231,6 +5241,11 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	if (!prepare_alloc_pages(gfp, 0, preferred_nid, nodemask, &ac, &gfp, &alloc_flags))
 		goto out;
 
+	/* Read once; see get_page_from_freelist(). */
+	preferred_zone = READ_ONCE(ac.preferred_zoneref->zone);
+	if (!preferred_zone)
+		goto failed;
+
 	/* Find an allowed local zone that meets the low watermark. */
 	z = ac.preferred_zoneref;
 	for_next_zone_zonelist_nodemask(zone, z, ac.highest_zoneidx, ac.nodemask) {
@@ -5241,8 +5256,8 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		if (nr_online_nodes > 1 && zone != zonelist_zone(ac.preferred_zoneref) &&
-		    zone_to_nid(zone) != zonelist_node_idx(ac.preferred_zoneref)) {
+		if (nr_online_nodes > 1 && zone != preferred_zone &&
+		    zone_to_nid(zone) != zone_to_nid(preferred_zone)) {
 			goto failed;
 		}
 
@@ -5250,7 +5265,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 retry_this_zone:
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK) + nr_pages - nr_populated;
 		if (zone_watermark_fast(zone, 0,  mark,
-				zonelist_zone_idx(ac.preferred_zoneref),
+				zone_idx(preferred_zone),
 				alloc_flags, gfp)) {
 			break;
 		}
@@ -5309,7 +5324,7 @@ unsigned long alloc_pages_bulk_noprof(gfp_t gfp, int preferred_nid,
 	pcp_spin_unlock(pcp);
 
 	__count_zid_vm_events(PGALLOC, zone_idx(zone), nr_account);
-	zone_statistics(zonelist_zone(ac.preferred_zoneref), zone, nr_account);
+	zone_statistics(preferred_zone, zone, nr_account);
 
 out:
 	return nr_populated;
-- 
2.53.0-Meta

