Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550400;
	b=GujlA1nS95PScBNkR5CUTChRA1+A7gEgrgCv7LxG89BMo29uxTFpHcfaZRk6v+jlnIbD
	 xTkRJCVtscQZAHOZAvn3Y9lhdJFLdKBbJFh0uf57nFSuRwS8W9UhPojQUZ/l7U9S5U6YG
	 7YQ2z62BIzNuqtO60EHfglyHboBBFqx4tHyA4KoUajQUBzn8hUueoL0wmArT6gBRnC/Ed
	 7MU9pthLAHOwl146R0pd495GwU2F7YE3i0kHv0Ln/6QQ8seMXIMr3sbNqR/h/N0gV+l1n
	 8sFD+88AcUbwk5/2GXMAnLdoK1o26f4xzc24h2BK6iI37bA1M2LJ7XVs7s9j3O0WNrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550400;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=abLwrGFXoJBlnSAGPYLFFR7ZpE8C/Ap31b+sTibNse0=;
	b=48MmaQVSgtjItFEZ4KxcY6J9FQ/vlJYJ4j0cLKPKe+vpBiQ5Oh4kaBWv5xFpjyFWLZZx
	 O+ozKF1lnzMcjNK5s6ajX0YtYjuv37qlW+/b7T5TOvTjum851GbFe8/DdRgBzbBYpXNFn
	 Ce05GdApOoAZjkAQ7fgkQfGJAQHBq0KAcvYssTVrsFpu78ex6K4YBqQrWuvss3SsAt00P
	 J1SEdS77or9B7jwpnwyHOpmEIgVGSy+oElBQTGuuPkiyBqGVM0EXy5q2cM+JC4BA+//+v
	 DoGtvwGBF2XAVpVLoN0iA3nGaHY2q7ntJdJA8n7Te59YexVK+o+pTYPzVDAMLpNNjDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=kR5eYpTi;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C668E60A2629
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Oct 2026 02:39:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C668E60A2629
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=kR5eYpTi
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-93f22a8515eso23982885a.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 19:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1792550399; x=1793155199; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=abLwrGFXoJBlnSAGPYLFFR7ZpE8C/Ap31b+sTibNse0=;
        b=kR5eYpTi5HThG/cG3OJCoClu0/q2WVlmO35ZnD2FRU+tBdZo166+fpadsj+fyt3T7C
         ljXLK+vjvGnf2+hsIyGZLwL2x/GnLFdktRM6Lnv3r2MbOmIwRLVnKI3YfhzRgcLxLUsQ
         VV+Tu/uRr6ZA/T2psJhCCFYeHArkODLIOItmD7J6M+0wcm0TODkSbcHyLvISww0I/xjE
         SA2V4b4l/b6YzdJY4PIfCMXcEXHazXx+YRf8W9vMmhMSDjycWa4L5o7b0A/WDMHqiP0L
         TYhAJJZKhbhrCeYm1tP4S7AWoKekVtyMFOjhIc7QUOCUARWl8QmMFc0IZG4JY+zA0wxe
         JyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792550399; x=1793155199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=abLwrGFXoJBlnSAGPYLFFR7ZpE8C/Ap31b+sTibNse0=;
        b=0Uzq+dIv3GiQb044YRj3HebCOjWAdY+RxudH9EXWF00fEOAC74hfixLXi7ecR4JPmK
         gad6F4VZgZBGf2LNvG68dJGFfNMOMdyqex0nLohIoG+9yPpbrGTc7FPSr/MohBYCt/ix
         fIWTTIHIscH2x/Sdmka36GYGQ9duAA/fmql4jT9ALCMXzsUJ1mhArKtu35bbPe0bbh0N
         7S6MJVQI4D9gJnVxam/AvMB0o52fy35XCtakQASCFk6PBXWq72OYx5/isziUNmwMYLs8
         M1gmRRYhxg14skacLmZVgy7n8GBqse4ih4PLicIuGVbcHD9mz3TGvvbFCd4ZclDyNCoI
         /Mug==
X-Forwarded-Encrypted: i=1; AKwUvBxghDIXl1TnWDEH4nDfXe6zRHlwqU3xMdS5jiWsgdHtJ3kBZ9wokl78xFAwOCZj7uoIsKYn40ranM4YJFZ0rA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIDM49e4Lsv6BvXfm6M7fGMWUYEcIEa+/yt3ATpKPf9RgZwMXYI
	DCR0sfox/Tla+wqTtiaFVza40hLsrVaNNKnajxoof9dAIOsLfgZ2ptjE9zHEo+TP7KY=
X-Gm-Gg: AYBFou3JXxTjN514YsYxBuZk+1LlsB88aEntgw5Bt/PcKK/sgLw03fA+hq3UfqQB+aB
	f9Y7yON81K3WvU/iIe6ak2NznjFmGiR38wWEFFV+7d6QioudT3EtlrvpKvdenmfs/yDQywIev9o
	T8Wubj2BTJW9bSCi0p2bndrm2ACdXzOzzr++Kp/p/HhxwJIxIaamXOI2l26GHqTq1SxTEGlZv1R
	fKJ4XkblQjxrw1Df2IY/JwCD55Hs+jUPevsnmMOqZBGI5EKlujFgpMFzo6p9itU2fp48d4CrRvZ
	T0b3weEHwPu/EzTxGwUD7kX5B6cLVLdkaAbig5RCK6dskSWN/grHgpO6msNXxMCQtO74HkOpT+z
	+fdpqnnH88pA5WLX24p3c67k09K4JOzvZqKy/jpBNnC5eXrKwj/k51hiDTZrOeyILXhF+JvYASE
	1+MsrCMWBU91W+uC2jo+itt8+nMAVLLvpMRTKkvRzDJ1sxi6rWl7SryRWXmQgXzkdMOF18Bk6B3
	WQGfjxV6/O8NXC2MZLd4OfxN/r1eXmFiXjw1fRFwmBVW42iLDUSltnoDlfI77eNnZ6QtTbhLXdH
	EoL4U4mKn+9BGJuicp869+EKaA0lCrvSH14GzPSRrQ==
X-Received: by 2002:a05:620a:3187:b0:93f:1823:308f with SMTP id af79cd13be357-93f57fe8708mr199104685a.81.1792550398715;
        Tue, 20 Oct 2026 19:39:58 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10a45336sm13819426d6.3.2026.10.20.19.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:39:58 -0700 (PDT)
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
Subject: [PATCH v3 8/8] mm/page_alloc: keep a zone's pagesets when it goes empty
Date: Tue, 20 Oct 2026 22:39:40 -0400
Message-ID: <20261021023940.1940971-9-gourry@gourry.net>
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

When offlining empties a zone, zone_pcp_reset() frees its pagesets while
the vmstat worker can still hold one across cond_resched():

  CPU 0                             CPU 1
  refresh_cpu_vm_stats()
    pcp = zone->per_cpu_pageset
    cond_resched()
                                    offline_pages()
                                      zone_pcp_reset()
                                        free_percpu(zone->per_cpu_pageset)
    decay_pcp_high(zone, this_cpu_ptr(pcp))

decay_pcp_high() then reads, and can write, memory the percpu allocator
may already have handed out again. With kprobes holding the worker
across the offline, it used the freed pageset in 6 of 6 runs, and
rewrote a new allocation at the freed address in 1 of them.

Keep the pagesets for the life of the zone, as pgdat->per_cpu_nodestats
already is, and only fold the stats in zone_pcp_reset().

Commit 340175b7d14d ("mm/hotplug: free zone->pageset when a zone becomes
empty") freed them because onlining the zone again allocated a new set
and leaked the old one. setup_zone_pageset() now reuses the existing
set, and zone_pcp_init() keeps it when the node is re-added, so nothing
is allocated twice. The pageset address stayed the same across repeated
offline/online cycles and across removing and re-adding the node.

The pagesets take 320 bytes per possible CPU: 30KiB per zone with 96
CPUs, 160KiB with 512 and 2.5MiB with 8192. A populated zone already
holds this memory, we just no longer give it back on offline.

Fixes: 340175b7d14d ("mm/hotplug: free zone->pageset when a zone becomes empty")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_alloc.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 96ae09c8099be..dfca77764f1fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6369,6 +6369,12 @@ void __meminit setup_zone_pageset(struct zone *zone)
 {
 	int cpu;
 
+	/* Reuse the pagesets zone_pcp_reset() kept. */
+	if (zone->per_cpu_pageset != &boot_pageset) {
+		zone_set_pageset_high_and_batch(zone, 0);
+		return;
+	}
+
 	/* Size may be 0 on !SMP && !NUMA */
 	if (sizeof(struct per_cpu_zonestat) > 0)
 		zone->per_cpu_zonestats = alloc_percpu(struct per_cpu_zonestat);
@@ -6465,9 +6471,12 @@ __meminit void zone_pcp_init(struct zone *zone)
 	 * per cpu subsystem is not up at this point. The following code
 	 * relies on the ability of the linker to provide the
 	 * offset of a (static) per cpu variable into the per cpu area.
+	 * A re-added node keeps the pagesets zone_pcp_reset() kept.
 	 */
-	zone->per_cpu_pageset = &boot_pageset;
-	zone->per_cpu_zonestats = &boot_zonestats;
+	if (!zone->per_cpu_pageset || zone->per_cpu_pageset == &boot_pageset) {
+		zone->per_cpu_pageset = &boot_pageset;
+		zone->per_cpu_zonestats = &boot_zonestats;
+	}
 	zone->pageset_high_min = BOOT_PAGESET_HIGH;
 	zone->pageset_high_max = BOOT_PAGESET_HIGH;
 	zone->pageset_batch = BOOT_PAGESET_BATCH;
@@ -7749,6 +7758,10 @@ void zone_pcp_enable(struct zone *zone)
 	mutex_unlock(&pcp_batch_high_lock);
 }
 
+/*
+ * Keep the pagesets of an emptied zone: refresh_cpu_vm_stats() can hold
+ * one across cond_resched(), and nothing waits for it to let go.
+ */
 void zone_pcp_reset(struct zone *zone)
 {
 	int cpu;
@@ -7759,12 +7772,6 @@ void zone_pcp_reset(struct zone *zone)
 			pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
 			drain_zonestat(zone, pzstats);
 		}
-		free_percpu(zone->per_cpu_pageset);
-		zone->per_cpu_pageset = &boot_pageset;
-		if (zone->per_cpu_zonestats != &boot_zonestats) {
-			free_percpu(zone->per_cpu_zonestats);
-			zone->per_cpu_zonestats = &boot_zonestats;
-		}
 	}
 }
 
-- 
2.53.0-Meta

