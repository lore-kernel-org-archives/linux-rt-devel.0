Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7DE27055D
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022670; cv=none; b=gYJohXP0kNoXIebb7U61f0B4Pqgcey94Ti/Dwb3o57+0CSKI2DYefwvE1eYoOe/86TO1KdFa6vjwIgLSrYnL3cqXjHZNxuG4MX0xd2hmi4uxY2PSIrIKvuVzikjqD2SrDRjaOHlGcd1CEUwHyDsXxDgZYhgPbD2UD334N9esvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022670; c=relaxed/simple;
	bh=bErYaAb3B0D38V+6M4gvP8nCNaF/6QJaZ4x/EenMZ0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IJ9o39vNAef7VcFvYlcgI2pbivu7ZTUBCzPIZ5xV4N8PqqXHahrrY9gCYT13i9Zxu3fR3VXsVAZ3fx3JCWVNr3v1NJi6DM2Uny+J+tob05gtNX5EAMgyX2g5Az2QodwtkKda81gNsJsT14d0rDeLDgHjBh1xK2xwum/VlgzlrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JYp4XiuJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYp4XiuJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769022667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SdZRkQhKinw2Zzq19HysXvpWY3I1Lr5Ul0XP6wR89Go=;
	b=JYp4XiuJEmFTJwullkuqz72UfXK8RRosxvYGjFBoER1VKdjSo8nWNzEN9cHPI+yvzqvfEI
	uIIIzK0u8NZ4rPF5FV8b4d0pYzkogaqeTTIysDrr1OyY03j9yJl9zvQVw7+P90ADaGb73k
	LS8721BxfMsAe5RUgtAZzokOU99Q7UI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-277-XN4vaPV7PW6RxpaJHQxHwg-1; Wed,
 21 Jan 2026 14:11:03 -0500
X-MC-Unique: XN4vaPV7PW6RxpaJHQxHwg-1
X-Mimecast-MFC-AGG-ID: XN4vaPV7PW6RxpaJHQxHwg_1769022662
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 956081956096;
	Wed, 21 Jan 2026 19:11:01 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.197])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C42919560A2;
	Wed, 21 Jan 2026 19:10:59 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/mm_init: Don't call cond_resched() in deferred_init_memmap_chunk() if rcu_preempt_depth() set
Date: Wed, 21 Jan 2026 14:10:36 -0500
Message-ID: <20260121191036.461389-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Fix it by checking rcu_preempt_depth() as well to prevent calling
cond_resched(). Note that CONFIG_PREEMPT_RCU should always be enabled
in a PREEMPT_RT kernel.

Fixes: 3acb913c9d5b ("mm/mm_init: use deferred_init_memmap_chunk() in deferred_grow_zone()")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/mm_init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index fc2a6f1e518f..4d6b6dac6f58 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2085,7 +2085,12 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
 
 			spfn = chunk_end;
 
-			if (irqs_disabled())
+			/*
+			 * pgdat_resize_lock() only disables irqs in non-RT
+			 * kernels but calls rcu_read_lock() in a PREEMPT_RT
+			 * kernel.
+			 */
+			if (irqs_disabled() || rcu_preempt_depth())
 				touch_nmi_watchdog();
 			else
 				cond_resched();
-- 
2.52.0

