Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306C739C00B
	for <linux-rt-devel@lists.linux.dev>; Wed, 20 May 2026 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296285; cv=none; b=oAml4thxiHKXbwRXxMVxErMHj4y6KVBpXWFKXeYVw712yxBRv0Q2378oXU7YLmckBJtx4Y6VqccRXHRuRpsoK1Bc2bsIyXGi092/7dNM3hXtHVuw1xmeYA0Doke07C2qKirmYcefcFZasFxGRssSmBrjVrH7G7qjPAYYyuufA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296285; c=relaxed/simple;
	bh=icJcXdsi7CRJLMdDZmkysbls70Z0ApdLq3RSNq+a3FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=DkZFElLRwxHamSimEPDymp1gBgKdjM/SqfdzELSeSelaBZoyGQ+3wRWJH9U7J0UvuDMX1OcGS9rX7quRRGGJt1jA4UWdFWx5iqaq3k2vNe6mrDfAAmN+2Cwl9+QCdTsULKSzj7U3TiPGiDSA6lgEYw7fI/8Im2m2N0cfjK/JSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c7DJCUYZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c7DJCUYZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779296283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1JbUqzTRhA+d8JFjGb298if0vWvclJSfYv+5b7mJm1k=;
	b=c7DJCUYZnV8tyMrqmLxomxo/kBSc9RBAVHNt0NJs4gBthff8HXQsuHm8NgDayNlKFru4Wn
	iTMK8U1in1DVtFJznOgkgudBnwTmqesdWwbzPKV6aJj/pCyJ6al1fP8KH4yb34B+Cug+5f
	mJ8RLKYKCJ+mc7jOjX/HPIX+UtlyWuM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-mqNlTpKdPVmUgvpuygbC2A-1; Wed,
 20 May 2026 12:57:58 -0400
X-MC-Unique: mqNlTpKdPVmUgvpuygbC2A-1
X-Mimecast-MFC-AGG-ID: mqNlTpKdPVmUgvpuygbC2A_1779296277
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3FB91956048;
	Wed, 20 May 2026 16:57:56 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.248])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 349C51800465;
	Wed, 20 May 2026 16:57:55 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] debugobjects: Don't call fill_pool() in early boot non-task context of RT kernel
Date: Wed, 20 May 2026 12:57:44 -0400
Message-ID: <20260520165744.921951-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: a-GmxE9DgA8BokuMAET36pt_67WpTM-z7GTteqjHNvE_1779296277
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

When booting a debug PREEMPT_RT kernel on an arm64 system with grace
processor, the following lockdep splat was reported during early boot.

  ================================
  WARNING: inconsistent lock state
  7.1.0-rc4-test+ #1 Not tainted
  --------------------------------
  inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
  swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
  ffff0000803346a0 (&n->list_lock){?.+.}-{3:3}, at: get_from_partial_node+0x74/0xa0
  {HARDIRQ-ON-W} state was registered at:
    __lock_acquire+0x3d4/0xb70
    lock_acquire.part.0+0x178/0x2e0
    lock_acquire+0xa0/0x240
    rt_spin_lock+0xa0/0x400
    __refill_objects_node+0x8c/0x638
    refill_objects+0x60/0x120
    __pcs_replace_empty_main+0x11c/0x3a8
    __kmalloc_noprof+0x550/0x5e0
    __alloc_workqueue+0x7a4/0xb68
    alloc_workqueue_noprof+0xc0/0x118
    kmem_cache_init_late+0x3c/0xd8
    start_kernel+0x360/0x460
    __primary_switched+0x8c/0xa0
  irq event stamp: 12818
  hardirqs last  enabled at (12817): [<ffffda0f4322be98>] __raw_spin_unlock_irqrestore+0xb8/0xe8
  hardirqs last disabled at (12818): [<ffffda0f45a611f4>] el1_interrupt+0x34/0xb0
  softirqs last  enabled at (0): [<0000000000000000>] 0x0
  softirqs last disabled at (0): [<0000000000000000>] 0x0
    :
  Call trace:
   show_stack+0x20/0x40 (C)
   dump_stack_lvl+0x7c/0x160
   dump_stack+0x1c/0x48
   print_usage_bug.part.0+0x248/0x270
   mark_lock_irq+0x410/0x608
   mark_lock+0x1ec/0x3a8
   mark_usage+0x138/0x170
   __lock_acquire+0x3d4/0xb70
   lock_acquire.part.0+0x178/0x2e0
   lock_acquire+0xa0/0x240
   rt_spin_lock+0xa0/0x400
   get_from_partial_node+0x74/0xa0
   ___slab_alloc+0x94/0x4f8
   kmem_cache_alloc_noprof+0x2d4/0x598
   kmem_alloc_batch+0x54/0x170
   fill_pool+0x12c/0x438
   debug_objects_fill_pool.part.0+0x88/0x100
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
   el1h_64_irq_handler+0x18/0x28
   el1h_64_irq+0x80/0x88

The {IN-HARDIRQ-W} usage happens when debug_objects_fill_pool() calls
fill_pool() in the hardirq context during early boot. It is because of
the "system_state < SYSTEM_SCHEDULING" check in debug_objects_fill_pool()
which allows fill_pool() to be called from any context during early
boot.

Calling fill_pool() from any context is problematic as deadlock can
happen even though the early boot window should be pretty short. Fix
that by restricting the call to only in_task() context during early boot.

Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 lib/debugobjects.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 12e2e42e6a31..236ea5e716df 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -727,11 +727,14 @@ static void debug_objects_fill_pool(void)
 
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context -- for !RT kernels we rely on the fact that spinlock_t and
+	 * context or in task context during early boot.
+	 *
+	 * For !RT kernels we rely on the fact that spinlock_t and
 	 * raw_spinlock_t are basically the same type and this lock-type
 	 * inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() ||
+	   (system_state < SYSTEM_SCHEDULING && in_task())) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to LD_WAIT_CONFIG, matching
-- 
2.54.0

