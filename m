Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550391;
	b=NPl1bKA8XpnB2qw4L6LvIp1Gw0iy1hXHMp0Q/lGA9fFnYSJ8IYAgxhP0d/ptlT7uEl+q
	 LjH5CnBhSi5K7Dk2qkS4rVc7WyfMgHdaIE+IlFO/G7B2+1zonq+2JlGaUKILnGA3PefAI
	 jAOP7LWmu1+aZshW3d6h0Ava383VsRKndfWHExPeVd1d36nSkFvopZ1omA/LPfcw+gZ2M
	 NMUKUugrdVM9VLpzhHRSunL3QCe3cf2eKOo+g3dtDl0x689VzHYjoLZ6JbHjrjcrUsPTh
	 eXbkoHPXVw+/5orSIMdFc1OU1omAzdUtjvwrRWmdt0rI5GceDVsRNcDWDp2CDmRE4ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UZtXCeX4FNS8qck5gj1e2IPK+BPL6kr+hoWf2wAHxQg=;
	b=l/0qdJynLp3G9MIlstdVPvUah4zLYLQZJguXZQN7tAiUnfM5c+uDao7iIQ3b3z4q2JUG
	 icV4S5196M+vLx/fAxJqe8k8PDRt7WrRDc75q66whFZIFEB9ywYDHBhX7o+kwdhqkNa9z
	 M0iGOM5vUU3YhsV0ThaOGHxauyaGszUkpv1zCppnd04DwcEpkdD8KKdARzGvkq9EduK4d
	 GIS+Lt2B2jcofV6saI8Qul1JnjBoYEKFgmpaLcJi4s+iJFKDB3xf1DJ/aPE8OjtrNMbEj
	 Ucw9kvN6iH4Lf66y7ZjqxR0uu+5DhKqECMEpzCBJBT6B1edH6IU4NCNjYMCNgRWEmPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=AuUnEDNS;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB84606A331
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 02:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BB84606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=AuUnEDNS
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-918f75a68f0so4081206d6.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 19:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550389; x=1793155189; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UZtXCeX4FNS8qck5gj1e2IPK+BPL6kr+hoWf2wAHxQg=;
        b=AuUnEDNSVdrmcps+mrFcYGMbUic7KzmBfmBJAQDbtRZJI+6XrRv53nwSNcEkbd/atM
         LuxAdBBPVM9qkVQ9+k5glwQIKZknFTVuuheuuOwIDT7bigmWM6ErbO3XMv9VKq+C3NQR
         pvXFN2K1d27a/0YB8RCkPlDaxBqDaYOmg4lv/joqHkT6oB1N3Er63gc7B+0V/v8oNa7H
         ZeG1J5jqwbXKMrQawkewmd9RZ4AW9LOvKdyQHGnt3uK1iMHfIWoAAOhwqwov6AWgWEON
         Ls3eMSrjUBKIs4+mboBf0+juCpe26yLgl6ZsGhqUEd8YULUrubE87hEhZi7S8cjTixt6
         OHQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550389; x=1793155189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZtXCeX4FNS8qck5gj1e2IPK+BPL6kr+hoWf2wAHxQg=;
        b=hAm+KyjEtklxSt10dD2Y+LMwp/MFyNBsp7xhjhBWjbWbDxQlMC9zKw6qw7UgMDQVsX
         9XgCjr8FFZO6jHvZN9XNTLDM5sfRD8gQJOoUlqi+zoa+GQcqN0NnCr59sQ4MfalX5ABI
         hq2Nghmlx+B41KO5ZMlO/pUH9FwPHxLZKo/Uv/Spb4HMSC4YSUjBd58hR2bebGXTlu59
         fu7IqYblveKR+DvHzwcNg7JwDOBIIYpr7WNgdpqbYEp+JLSDlEj7z3IJ6r/7zKZpeJGL
         Hof7u+DwIjotnqbchamrV3b4Mni5/6q0DQAV7tT69peqX/gim5WSj6GGU+2Gzllt9jmg
         R9Nw==
X-Forwarded-Encrypted: i=1; AKwUvBxZCaTiol+F5oDS5ONISTcGwRokFH8iXIuEUr/YRiO7e/B8h7zcUYEQk+xx0B46fjjZ8ETFJdGIGIM9/BODuw==@lists.linux.dev
X-Gm-Message-State: AFq9FYINds10c4P7zZJcC/YgYSHXwxMYD5ng4a2/iBuKu1V9B/OaSW8E
	f1GumANIcfNPLXZ9waQ+i4+q2mTS/TGrn4IqccUCRm0mYs6ehgz/ejgmUnMrZ0OaT5s=
X-Gm-Gg: AYBFou0jElsS5K+VIPnddFIwJaHArdtbfH0VkYp1+UhCfXwFOVjaDC074JlbFfX6wYa
	dBdLpXovlLvJs+IxvMCFKqJgHv0ZZ9JlpPSQG4UyjQbswPKwVgaCuwOJBVmX+BVSmBdbfPGUkSi
	T3sv8MOaTj0HPkh+vVUQXLpQqPQ+ZfofHE3q1tJkj7XYjYvm2rZ1Ey/LPCZqwd5Lyira5zQBs8+
	tfNID3OQUw/6neyKft49ETOucSNV7kLNoabcDCTIJr72ZMDyIGcTNka/tHWHHMkdPrjKxspoDkL
	7U8WjMSyjIlDR0Wdp4zuJpLti1sp8tWWyN6Jv/6O4Pwidd/ACWXAY52mncU5Xl9+qB6pq1l2YgK
	MQg8dC7oCsKJ2+5fMx6TfbQSaKL7d/9MtKFOr1QiAK9y4lIy6+x8fOASxJ82zzsW1MY2rQOZ7aW
	vgMN9fAofUqlTlpcn0/krnNmyCL+an4rUmJBHJdnFxDuiG2cFoZyIAT64MBc9WwMyyE8ChnHJc9
	PBZVcVCvWE+0Oqwgh56YWnfeqKTKhiDM2iVb1ZwfaFIQsVhjE7jaukCIU/8lBHVNKQC01nk0Rg7
	xsxPrqpsXzaRQBtKTWy3bsoIdXUqn7oF4j/4L+/NdQ==
X-Received: by 2002:a05:620a:3913:b0:93e:66e6:fa4 with SMTP id af79cd13be357-93f57f05079mr224040885a.16.1792550389393;
        Tue, 20 Oct 2026 19:39:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:48 -0700 (PDT)
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
Subject: [PATCH v3 3/8] mm/mmzone: read each zoneref slot once when filtering by nodemask
Date: Tue, 20 Oct 2026 22:39:35 -0400
Message-ID: <20261021023940.1940971-4-gourry@gourry.net>
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

__next_zones_zonelist() tests a slot's zone for NULL, then reads the
slot again to look up the zone's node. Offlining a zone's last block
rebuilds the zonelists in place, so the second read can return the
terminator:

  CPU 0                             CPU 1
  __next_zones_zonelist(nodemask)
    zonelist_zone(slot 1) = NORMAL
                                    offline_pages()
                                      build_all_zonelists()
                                        [MOVABLE, NORMAL, NULL]
                                        -> [NORMAL, NULL]
    zref_in_nodemask(slot 1)
      zone_to_nid(NULL)

Current GCC and clang merge the two reads, but nothing requires it. With
mm/mmzone.o built with -fno-inline -fno-ipa-sra, holding a nodemask
allocation between the reads while the node's last movable block goes
offline oopses every time:

  BUG: kernel NULL pointer dereference, address: 0000000000000060
  RIP: 0010:zone_to_nid+0x0/0x10
  Call Trace:
   zref_in_nodemask+0x9/0x20
   __next_zones_zonelist+0x23/0x70
   prepare_alloc_pages.constprop.0+0x16c/0x190
   __alloc_frozen_pages_noprof+0xaf/0x330

Read the slot once and test that zone. A NULL zone still ends the walk.

Fixes: 11cd8638c37f ("mm, page_alloc: remove stop_machine from build_all_zonelists")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mmzone.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index 9cc9ef588580d..009f1dd75dde8 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -43,13 +43,14 @@ struct zone *next_zone(struct zone *zone)
 	return zone;
 }
 
-static inline int zref_in_nodemask(struct zoneref *zref,
-				   const nodemask_t *nodes)
+/* A NULL zone terminates the zonelist, so it ends the search. */
+static inline bool zone_in_nodemask(const struct zone *zone,
+				    const nodemask_t *nodes)
 {
 #ifdef CONFIG_NUMA
-	return node_isset(zonelist_node_idx(zref), *nodes);
+	return !zone || node_isset(zone_to_nid(zone), *nodes);
 #else
-	return 1;
+	return true;
 #endif /* CONFIG_NUMA */
 }
 
@@ -67,7 +68,7 @@ struct zoneref *__next_zones_zonelist(struct zoneref *z,
 			z++;
 	else
 		while (zonelist_zone_idx(z) > highest_zoneidx ||
-				(zonelist_zone(z) && !zref_in_nodemask(z, nodes)))
+		       !zone_in_nodemask(READ_ONCE(z->zone), nodes))
 			z++;
 
 	return z;
-- 
2.53.0-Meta

