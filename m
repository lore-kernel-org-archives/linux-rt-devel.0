Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D678303C86
	for <linux-rt-devel@lists.linux.dev>; Wed,  7 Jan 2026 21:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822881; cv=none; b=AaAaUqekQ/Fxikpn3yRyL6RkXcD0pzCBCwe8ADZ8/JcS93RvJFswI+0pCzMoRm6v2d+d3z3UMJmk1P3z+TLFqGvwka6PnSwjUxAe0a9jN/aafE5UAy6TV7LsEReaAab1YT3ss0wsmA+AgMpUVg+ttEvbjnIufeSnrggoIngJVsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822881; c=relaxed/simple;
	bh=IXPguWXGtTzF6Ezm1vzRDLMNFA3Kqh9ZTGciya1xfnA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JWeaPS5MwxiclVcvKmMn29mQnxWhVk5D7cd6VTTuA7ep+1EROco8GXqX01DaOxg99qsaCXaLOh7AUhHhEVk9Db8snqKqIipdm8iiGrr+KRNq7hToxEVbC/5Vgy6l7sEeRDgv3GpJAVCnKeFMSxgWoykkbcLfmnbdC0ORGa0NpOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KeIdMzbJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KeIdMzbJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767822878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=CWbYS1PWWwziLddhvpqLVmHnAcvw25qM8FhFwh1XOz8=;
	b=KeIdMzbJsaSBYTxDJtfi+CtRHm7cHVxI6vlT4bbLNsDwFjlkuz0M1gGkM9whM00OnteGnP
	kUv8h16zX1S326vENOGyDUBmg1E5KKTf4BgJ1n6G1h+tiowkssqPj5y225nqRd8Ujj82jd
	XitpBr0OMdOnKOk8CTs1R+ygXlAh2lQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-ONoBIn6kOfaA6fo4rpJTXA-1; Wed,
 07 Jan 2026 16:54:34 -0500
X-MC-Unique: ONoBIn6kOfaA6fo4rpJTXA-1
X-Mimecast-MFC-AGG-ID: ONoBIn6kOfaA6fo4rpJTXA_1767822873
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2B3C1800447;
	Wed,  7 Jan 2026 21:54:32 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.77])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4A62618007D2;
	Wed,  7 Jan 2026 21:54:30 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in allocate_vpe_l1_table()
Date: Wed,  7 Jan 2026 16:53:53 -0500
Message-ID: <20260107215353.75612-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

When running a PREEMPT_RT debug kernel on a 2-socket Grace arm64 system,
the following bug report was produced at bootup time.

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
  in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/72
  preempt_count: 1, expected: 0
  RCU nest depth: 1, expected: 1
   :
  CPU: 72 UID: 0 PID: 0 Comm: swapper/72 Tainted: G        W           6.19.0-rc4-test+ #4 PREEMPT_{RT,(full)}
  Tainted: [W]=WARN
  Call trace:
    :
   rt_spin_lock+0xe4/0x408
   rmqueue_bulk+0x48/0x1de8
   __rmqueue_pcplist+0x410/0x650
   rmqueue.constprop.0+0x6a8/0x2b50
   get_page_from_freelist+0x3c0/0xe68
   __alloc_frozen_pages_noprof+0x1dc/0x348
   alloc_pages_mpol+0xe4/0x2f8
   alloc_frozen_pages_noprof+0x124/0x190
   allocate_slab+0x2f0/0x438
   new_slab+0x4c/0x80
   ___slab_alloc+0x410/0x798
   __slab_alloc.constprop.0+0x88/0x1e0
   __kmalloc_cache_noprof+0x2dc/0x4b0
   allocate_vpe_l1_table+0x114/0x788
   its_cpu_init_lpis+0x344/0x790
   its_cpu_init+0x60/0x220
   gic_starting_cpu+0x64/0xe8
   cpuhp_invoke_callback+0x438/0x6d8
   __cpuhp_invoke_callback_range+0xd8/0x1f8
   notify_cpu_starting+0x11c/0x178
   secondary_start_kernel+0xc8/0x188
   __secondary_switched+0xc0/0xc8

This is due to the fact that allocate_vpe_l1_table() will call
kzalloc() to allocate a cpumask_t when the first CPU of the
second node of the 72-cpu Grace system is being called from the
CPUHP_AP_MIPS_GIC_TIMER_STARTING state inside the starting section of
the CPU hotplug bringup pipeline where interrupt is disabled. This is an
atomic context where sleeping is not allowed and acquiring a sleeping
rt_spin_lock within kzalloc() may lead to system hang in case there is
a lock contention.

To work around this issue, a static buffer is used for cpumask
allocation when running a PREEMPT_RT kernel via the newly introduced
vpe_alloc_cpumask() helper. The static buffer is currently set to be
4 kbytes in size. As only one cpumask is needed per node, the current
size should be big enough as long as (cpumask_size() * nr_node_ids)
is not bigger than 4k.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ada585bfa451..9185785524dc 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2896,6 +2896,30 @@ static bool allocate_vpe_l2_table(int cpu, u32 id)
 	return true;
 }
 
+static void *vpe_alloc_cpumask(void)
+{
+	/*
+	 * With PREEMPT_RT kernel, we can't call any k*alloc() APIs as they
+	 * may acquire a sleeping rt_spin_lock in an atomic context. So use
+	 * a pre-allocated buffer instead.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+		static unsigned long mask_buf[512];
+		static atomic_t	alloc_idx;
+		int idx, mask_size = cpumask_size();
+		int nr_cpumasks = sizeof(mask_buf)/mask_size;
+
+		/*
+		 * Fetch an allocation index and if it points to a buffer within
+		 * mask_buf[], return that. Fall back to kzalloc() otherwise.
+		 */
+		idx = atomic_fetch_inc(&alloc_idx);
+		if (idx < nr_cpumasks)
+			return &mask_buf[idx * mask_size/sizeof(long)];
+	}
+	return kzalloc(sizeof(cpumask_t), GFP_ATOMIC);
+}
+
 static int allocate_vpe_l1_table(void)
 {
 	void __iomem *vlpi_base = gic_data_rdist_vlpi_base();
@@ -2927,7 +2951,7 @@ static int allocate_vpe_l1_table(void)
 	if (val & GICR_VPROPBASER_4_1_VALID)
 		goto out;
 
-	gic_data_rdist()->vpe_table_mask = kzalloc(sizeof(cpumask_t), GFP_ATOMIC);
+	gic_data_rdist()->vpe_table_mask = vpe_alloc_cpumask();
 	if (!gic_data_rdist()->vpe_table_mask)
 		return -ENOMEM;
 
-- 
2.52.0

