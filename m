Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB743859D2
	for <linux-rt-devel@lists.linux.dev>; Thu, 22 Jan 2026 18:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769107492; cv=none; b=kPCTDewUtKkQ7OdZtn+8W14Pl7e77EY50bpmxPpguA/8sbnZ7NrxBKhERWbfZ2mMv6FHZ52b2jJ2484LEapwdm7nCv5sDg0/Wo9zdBbnP8uvvMYzOgyUZkT0zuhnRFyhfNTTC8hdCNUjn59ALcPHiv2D6FGcUAXkvAAtaQ7Gb8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769107492; c=relaxed/simple;
	bh=HKFPyQQ6hmbAczM0/cvKv4bWPuFTGBzmQ8bqeGgF68Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OBADtL8/KyHeDdQqkhI/Oy06U0jVr5Vl8r/XGJQTkKUTcYEV/2/sVAtvU0+bgZKKLxzzSXPJrk1oE4D7GluBEPqB0jtLv8eY6Ox2k3JA1wqOrwSlDckkfg6tiTLGXaistuim7n3u1wmXWl9MIQ5EvzhsjddG/rqSNUB46gwry5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ALi65AXK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ALi65AXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769107471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2hi9nw0ROEqCJmA86cR5BCja4mz2cFCx+tgdx6SAHhI=;
	b=ALi65AXKAa/RU/QRwLIz4ouGQow4ds56RnzyF6ksKi2a+XOJIaoJvjrGklSMmXmvKIETtS
	/KKWTs4njySuRYyaOBEKBBSgR31ounSd2LbzMPnaBOce/8EgCKNIjoei43RSqJAjO85eBa
	in7+zZHa4L+m4aDV3VpaTZLueOfCtD0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-DrPRUB-MMeeByGpbTwLtaw-1; Thu,
 22 Jan 2026 13:44:27 -0500
X-MC-Unique: DrPRUB-MMeeByGpbTwLtaw-1
X-Mimecast-MFC-AGG-ID: DrPRUB-MMeeByGpbTwLtaw_1769107465
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6209F1955D9F;
	Thu, 22 Jan 2026 18:44:25 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.90.13])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBA041800665;
	Thu, 22 Jan 2026 18:44:22 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v3] mm/mm_init: Don't cond_resched() in deferred_init_memmap_chunk() if called from deferred_grow_zone()
Date: Thu, 22 Jan 2026 13:43:43 -0500
Message-ID: <20260122184343.546627-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Commit 3acb913c9d5b ("mm/mm_init: use deferred_init_memmap_chunk()
in deferred_grow_zone()") made deferred_grow_zone() call
deferred_init_memmap_chunk() within a pgdat_resize_lock() critical
section with irqs disabled. It did check for irqs_disabled() in
deferred_init_memmap_chunk() to avoid calling cond_resched(). For a
PREEMPT_RT kernel build, however, spin_lock_irqsave() does not disable
interrupt but rcu_read_lock() is called. This leads to the following
bug report.

  BUG: sleeping function called from invalid context at mm/mm_init.c:2091
  in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
  preempt_count: 0, expected: 0
  RCU nest depth: 1, expected: 0
  3 locks held by swapper/0/1:
   #0: ffff80008471b7a0 (sched_domains_mutex){+.+.}-{4:4}, at: sched_domains_mutex_lock+0x28/0x40
   #1: ffff003bdfffef48 (&pgdat->node_size_lock){+.+.}-{3:3}, at: deferred_grow_zone+0x140/0x278
   #2: ffff800084acf600 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1b4/0x408
  CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.19.0-rc6-test #1 PREEMPT_{RT,(full)
}
  Tainted: [W]=WARN
  Call trace:
   show_stack+0x20/0x38 (C)
   dump_stack_lvl+0xdc/0xf8
   dump_stack+0x1c/0x28
   __might_resched+0x384/0x530
   deferred_init_memmap_chunk+0x560/0x688
   deferred_grow_zone+0x190/0x278
   _deferred_grow_zone+0x18/0x30
   get_page_from_freelist+0x780/0xf78
   __alloc_frozen_pages_noprof+0x1dc/0x348
   alloc_slab_page+0x30/0x110
   allocate_slab+0x98/0x2a0
   new_slab+0x4c/0x80
   ___slab_alloc+0x5a4/0x770
   __slab_alloc.constprop.0+0x88/0x1e0
   __kmalloc_node_noprof+0x2c0/0x598
   __sdt_alloc+0x3b8/0x728
   build_sched_domains+0xe0/0x1260
   sched_init_domains+0x14c/0x1c8
   sched_init_smp+0x9c/0x1d0
   kernel_init_freeable+0x218/0x358
   kernel_init+0x28/0x208
   ret_from_fork+0x10/0x20

Fix it adding a new argument to deferred_init_memmap_chunk() to
explicitly tell it if cond_resched() is allowed or not instead of
relying on some current state information which may vary depending
on the exact kernel configuration options that are enabled.

Fixes: 3acb913c9d5b ("mm/mm_init: use deferred_init_memmap_chunk() in deferred_grow_zone()")
Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Waiman Long <longman@redhat.com>
---

 [v3]: Add a new can_resched argument to deferred_init_memmap_chunk() as
       suggested by Sebastian.

 mm/mm_init.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index fc2a6f1e518f..2a809cd8e7fa 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2059,7 +2059,7 @@ static unsigned long __init deferred_init_pages(struct zone *zone,
  */
 static unsigned long __init
 deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
-			   struct zone *zone)
+			   struct zone *zone, bool can_resched)
 {
 	int nid = zone_to_nid(zone);
 	unsigned long nr_pages = 0;
@@ -2085,10 +2085,10 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 
 			spfn = chunk_end;
 
-			if (irqs_disabled())
-				touch_nmi_watchdog();
-			else
+			if (can_resched)
 				cond_resched();
+			else
+				touch_nmi_watchdog();
 		}
 	}
 
@@ -2101,7 +2101,7 @@ deferred_init_memmap_job(unsigned long start_pfn, unsigned long end_pfn,
 {
 	struct zone *zone = arg;
 
-	deferred_init_memmap_chunk(start_pfn, end_pfn, zone);
+	deferred_init_memmap_chunk(start_pfn, end_pfn, zone, true);
 }
 
 static unsigned int __init
@@ -2216,7 +2216,7 @@ bool __init deferred_grow_zone(struct zone *zone, unsigned int order)
 	for (spfn = first_deferred_pfn, epfn = SECTION_ALIGN_UP(spfn + 1);
 	     nr_pages < nr_pages_needed && spfn < zone_end_pfn(zone);
 	     spfn = epfn, epfn += PAGES_PER_SECTION) {
-		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone);
+		nr_pages += deferred_init_memmap_chunk(spfn, epfn, zone, false);
 	}
 
 	/*
-- 
2.52.0

