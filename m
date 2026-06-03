Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A6539DBD6
	for <linux-rt-devel@lists.linux.dev>; Wed,  3 Jun 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780516399; cv=none; b=nrSb9Du+Fxlf3NMyHncWb1jTzYjgRAxyylwng6CYNq1b+o/Y65WqU+DxmljT3QAYYAt1TwhAGJBYJD6qD8mott09GkdGBZrN5WDX78FU2RF90espBNK2aJoBpSyaPjUXrR5E6dUfgSBfFM2ZNZUQDCooUK3Ikns0+bBaWreImDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780516399; c=relaxed/simple;
	bh=yzuFeTE6+X/yNlUwAg2aSNY6dXCxlt0+U3Fodkm2zuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=LHQxXZpWyS/KroQHYbAeuGFQFcrdQ9soLgMIMBpIzdY9fGfM7Xcno96NV+2D8eVDBxf38CPX8+dlAda1oyVT8F/vb9bU6rB+TFuWZYmI3uS3dl5GONMiTG4Tvnw1faGMF/UOJoNxWGGnZmgP2uat6ePV3uBheo2rYBvPdMLJ5oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcyT34wC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcyT34wC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780516397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c+06T58AqbedUhCgMoin30VfhIUy2uLt7Vdg4Vhvfjc=;
	b=LcyT34wCp4qhE6myLsRjlbKHZOB9R9hhVNDfBfp4W2uFla2tA9VygXDbgQytrA4iwL0+sg
	EofAGH3yB2cJqHaP+tfWhgQfJYSgt7+/B3sCMefb2wsQIIKtjW9O2IgBoo5UA5LYtcSZ5y
	QHIfGpY6jU36u/o/TZqNuHg2RTINEPE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-JT3gD-fNOQup8IDiTUsSAQ-1; Wed,
 03 Jun 2026 15:53:13 -0400
X-MC-Unique: JT3gD-fNOQup8IDiTUsSAQ-1
X-Mimecast-MFC-AGG-ID: JT3gD-fNOQup8IDiTUsSAQ_1780516392
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C45041800599;
	Wed,  3 Jun 2026 19:53:11 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.171])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E3BB81624;
	Wed,  3 Jun 2026 19:53:09 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4] debugobjects: Don't call fill_pool() in early boot hardirq context
Date: Wed,  3 Jun 2026 15:52:50 -0400
Message-ID: <20260603195250.362595-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: w9U6uJux8B-OeNvroiddoGFYcAZHvbcV7eeX4uXOj00_1780516392
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When booting a debug PREEMPT_RT kernel on an arm64 system with grace
processor, the following lockdep warning was reported during early boot.

  ================================
  WARNING: inconsistent lock state
  7.1.0-rc4-test+ #1 Not tainted
  --------------------------------
  inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
  swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
  ffff0000803346a0 (&n->list_lock){?.+.}-{3:3}, at: get_from_partial_node+0x74/0xa0
    :
  Call trace:
    :
   rt_spin_lock+0xa0/0x400
   get_from_partial_node+0x74/0xa0
   ___slab_alloc+0x94/0x4f8
   kmem_cache_alloc_noprof+0x2d4/0x598
   kmem_alloc_batch+0x54/0x170
   fill_pool+0x12c/0x438
   debug_objects_fill_pool+0x58/0x60
   debug_object_activate+0xfc/0x3d0
   add_timer_on+0x250/0x3a0
   add_interrupt_randomness+0x2d4/0x340
   handle_percpu_devid_irq+0x2e0/0x4e0
   handle_irq_desc+0xc0/0x120
   generic_handle_domain_irq+0x20/0x40
   __gic_handle_irq_from_irqson.isra.0+0x3c4/0x708
   gic_handle_irq+0x7c/0xe0
   call_on_irq_stack+0x30/0x48
   do_interrupt_handler+0x134/0x158
   el1_interrupt+0x48/0xb0
    :

During early boot, interrupts are getting enabled before the scheduler
is enabled. In this window (before SYSTEM_SCHEDULING is set) interrupts
can fire and attempt to fill the pool from within the hardirq. This can
lead to a deadlock the interrupt occurred while in the memory allocator.

Add a new can_fill_pool() helper and reorder the exception rule and
forbid this scenario by excluding allocations from hardirq.

Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
Co-developed-by: Waiman Long <longman@redhat.com>
Co-developed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 46 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index b18a682fe3da..6fb00e08a4e2 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -720,6 +720,41 @@ static inline bool debug_objects_is_pi_blocked_on(void)
 #endif
 }
 
+static inline bool can_fill_pool(void)
+{
+	/*
+	 * On !RT enabled kernels there are no restrictions and spinlock_t and
+	 * raw_spinlock_t are the same types.
+	 */
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		return true;
+
+	/*
+	 * On RT enabled kernels, the task must not be blocked on a lock as
+	 * that could corrupt the PI state when blocking on a lock in the
+	 * allocation path.
+	 */
+	if (debug_objects_is_pi_blocked_on())
+		return false;
+
+	/*
+	 * On RT enabled kernels the pool refill should happen in preemptible
+	 * context.
+	 */
+	if (preemptible())
+		return true;
+
+	/*
+	 * Though during system boot before scheduling is set up, preemption is
+	 * disabled and the pool can get exhausted. Before scheduling is active
+	 * a task cannot be blocked on a sleeping lock, but it might hold a lock
+	 * and if interrupted then hard interrupt context might run into a lock
+	 * inversion. So exclude hard interrupt context from allocations before
+	 * scheduling is active.
+	 */
+	return system_state < SYSTEM_SCHEDULING && !in_hardirq();
+}
+
 static void debug_objects_fill_pool(void)
 {
 	if (!static_branch_likely(&obj_cache_enabled))
@@ -734,18 +769,11 @@ static void debug_objects_fill_pool(void)
 	if (likely(!pool_should_refill(&pool_global)))
 		return;
 
-	/*
-	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
-	 * on the fact that spinlock_t and raw_spinlock_t are basically the
-	 * same type and this lock-type inversion works just fine.
-	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
-	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
+	if (can_fill_pool()) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
-		 * the preemptible() condition above.
+		 * the preemptible() condition in can_fill_pool().
 		 */
 		static DEFINE_WAIT_OVERRIDE_MAP(fill_pool_map, LD_WAIT_CONFIG);
 		lock_map_acquire_try(&fill_pool_map);
-- 
2.54.0

