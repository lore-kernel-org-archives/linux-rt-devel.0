Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50E93E315C
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873488; cv=none; b=DcX3/lfFWjUSa/g8scpLh5Kj3VLieJWAgT4Ub26ZKu19ZCL248lUiFxMQiC+Ne0R5x5D2BxDeA5063/iODBxGLHyjANSbmfnSFwEwRS0ex8r0c4z3UZ52gjpmiFC4XQ/KntbfUZ5hbfHAr7kPNAZStqYH9gm0DzZx9e7uL/2QPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873488; c=relaxed/simple;
	bh=OL5kyzzH3pevyaGpCfzUthvi5UyUYi/GZsUUb63MbgA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qWutvfyBIBNMYFZf5xxW/zE2CzyiqrxtcOzPdY6ZaIddv9UFK6z862+7IJQcgyI9uLOTofOhJ1S6d4/rF2y/b21aSuXDvp2akOvtdFmdSwNqR4T61bwd4zZnc31yXp+3hwRPn3qVSt/G6AgXJITGIK06d9QnnUtENp5j+DMRmho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hDvvQnAW; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hDvvQnAW"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d52734fc41so4603725ad.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 16:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787873486; x=1788478286; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/lOzSmEZ51hzHprpWRTTa0ItgwWLWckqKQo+nDAEYGw=;
        b=hDvvQnAWrmBUId4svfOqxLDrye5N4YpnJrXhEkVLKojNhlx3goVdNk3oUaNbfanJwB
         6+/ULV/BeH/62wSUswKtHM67jay0r54sbJS1Hk4ItenuhOy4z1fmb+w6EVALSr8ezi28
         rczocpogCDiiQZMTYstBCL2rgsZ7Rsl1XuN6gZMdoq14Yiv7z5TSOXxfgqzkUENWcN0n
         4vPVPHt9KBemAHwf3Ala1c5xewapSaSymv5occK918tRCFl10e16V8FcOXVeqYRs8w4X
         v+WMfo6YX91h3jJdprhxfM6JpEA+inRoz9d33vKos+rySG8FjK4p0mGyY9SxaVwoWXhT
         bkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787873486; x=1788478286;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lOzSmEZ51hzHprpWRTTa0ItgwWLWckqKQo+nDAEYGw=;
        b=ULDUJl5o+Bj4E25qlWCarT7QVrB96pSNVUv/VthbVWCs8SagNwRqiDpfaHP+C/ByjH
         MfnfWwkFY6vKkUD9EGZxisiCsICGNyMuOZeDM6nF4HmYY5O3u1/00NUtEbrk2Yjn4AO7
         cuWX6NYWMd1/+YJ9M6rhrq4oJOgpGaYTUAH/W0xTM2uebWTJIWmwyIXe5CE/VVUDSVAb
         Ds88igWB5MverNjldMAiYxcMyArJbhM1UXZsSi6th/JVSRQnXZcoTqsoZHrqYAWQ524b
         wgSYcAXHDFpXYJrJPrh9OJl/zF/fTMgH5n9ns3F76Mns0YI47uxUvSsPgcbaUzOwtY74
         /XGQ==
X-Forwarded-Encrypted: i=1; AHgh+RrklEFw9LOgSnvDo14ldwiO4DBxUHtTvLKrKgfCxqO6iuDF7fpdYBmWzy8xIm0ERLKIORuXZdiWdr9k7YBv7A==@lists.linux.dev
X-Gm-Message-State: AFuF++nmmxQSB2N2PzsO0mRDMsRyuHGzoidYmMfCLt5/6ySmx8TpJjOB
	sGcUcv3t3weiiKIbmeV0gMRInsM6/05pibFUprYp/jcXe+Kjrm7tWtGF+G/znFf6owQowIbO62S
	5ragBHCozVhU2VQ==
X-Received: from dybud10.prod.google.com ([2002:a05:7300:f60a:b0:311:6ce7:736d])
 (user=stevensd job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:458b:b0:2d6:f3f0:3e7a with SMTP id d9443c01a7336-2d74dc2ade3mr36340345ad.3.1787873485885;
 Thu, 27 Aug 2026 16:31:25 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:29:43 -0700
In-Reply-To: <20260827232948.2520558-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827232948.2520558-6-stevensd@google.com>
Subject: [RFC 05/10] fork: allocate reclaimable stacks with VM_SPARSE
From: David Stevens <stevensd@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Uladzislau Rezki <urezki@gmail.com>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, suleiman@google.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"

Since the pages of reclaimable stacks will not always be populated, we
need to set VM_SPARSE on their vm_structs to avoid crashes when
vread_iter sees a partially reclaimed stack. Note that stacks will only
be partially reclaimed when they are associated with a live task, so the
stack management and caching code in fork.c won't actually ever see a
partially reclaimed stack.

Directly managing the vm_structs instead of going through vmalloc also
requires doing the freeing of the stack on a work queue instead of in an
RCU callback. Previously, we were relying on deferred vfree work to move
much of the cleanup work from softirq to process context.

The fact that vmap stack pages are included in vmalloc's vmstat is well
known. We should continue that to avoid changing procfs.

Signed-off-by: David Stevens <stevensd@google.com>
---
 kernel/fork.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index 10bd76f6dd20..6acad0038b78 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -267,6 +267,97 @@ static bool try_release_thread_stack_to_cache(struct vm_struct *vm_area)
 	return false;
 }
 
+#ifdef CONFIG_RECLAIMABLE_STACK
+static void free_vmap_stack(struct vm_struct *vm_area)
+{
+	int i;
+
+	remove_vm_area(vm_area->addr);
+
+	for (i = 0; i < vm_area->nr_pages; i++) {
+		mod_node_page_state(page_pgdat(vm_area->pages[i]), NR_VMALLOC, -1);
+		__free_page(vm_area->pages[i]);
+	}
+
+	kfree(vm_area->pages);
+	kfree(vm_area);
+}
+
+static struct vm_struct *alloc_vmap_stack(int node)
+{
+	struct vm_struct *vm_area;
+	int ret;
+
+	vm_area = get_vm_area_node(THREAD_SIZE, THREAD_ALIGN, VM_MAP | VM_SPARSE, node);
+	if (!vm_area)
+		return NULL;
+
+	vm_area->pages = kcalloc_node(THREAD_SIZE >> PAGE_SHIFT, sizeof(*vm_area->pages),
+				      GFP_KERNEL | __GFP_ZERO, node);
+	if (!vm_area->pages)
+		goto alloc_failure;
+
+	while (vm_area->nr_pages < THREAD_SIZE >> PAGE_SHIFT) {
+		struct page *page;
+		gfp_t gfp = GFP_VMAP_STACK | __GFP_HIGHMEM;
+
+		if (node == NUMA_NO_NODE)
+			page = alloc_pages(gfp, 0);
+		else
+			page = alloc_pages_node(node, gfp, 0);
+
+		if (!page)
+			goto alloc_failure;
+
+		/*
+		 * Non-reclaimable vmap stacks pages aren't charged against an
+		 * memcg until account_kernel_stack(), but they are added to
+		 * the node's NR_VMALLOC counter. Copy that behavior to avoid
+		 * confusing userspace.
+		 */
+		mod_node_page_state(page_pgdat(page), NR_VMALLOC, 1);
+		vm_area->pages[vm_area->nr_pages++] = page;
+	}
+
+	ret = vmap_pages_range((unsigned long)vm_area->addr,
+			       (unsigned long)vm_area->addr + THREAD_SIZE,
+			       PAGE_KERNEL, vm_area->pages, PAGE_SHIFT);
+	if (ret)
+		goto alloc_failure;
+
+	return vm_area;
+
+alloc_failure:
+	free_vmap_stack(vm_area);
+	return NULL;
+}
+
+struct vm_stack {
+	struct rcu_work work;
+	struct vm_struct *stack_vm_area;
+};
+
+static void thread_stack_free_work(struct work_struct *work)
+{
+	struct vm_stack *vm_stack = container_of(to_rcu_work(work), struct vm_stack, work);
+	struct vm_struct *vm_area = vm_stack->stack_vm_area;
+
+	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
+		return;
+
+	free_vmap_stack(vm_area);
+}
+
+static void thread_stack_delayed_free(struct task_struct *tsk)
+{
+	struct vm_stack *vm_stack = tsk->stack;
+
+	vm_stack->stack_vm_area = tsk->stack_vm_area;
+	INIT_RCU_WORK(&vm_stack->work, thread_stack_free_work);
+	queue_rcu_work(system_wq, &vm_stack->work);
+}
+
+#else /* !CONFIG_RECLAIMABLE_STACK */
 static void free_vmap_stack(struct vm_struct *vm_area)
 {
 	vfree(vm_area->addr);
@@ -305,6 +396,7 @@ static void thread_stack_delayed_free(struct task_struct *tsk)
 	vm_stack->stack_vm_area = tsk->stack_vm_area;
 	call_rcu(&vm_stack->rcu, thread_stack_free_rcu);
 }
+#endif /* CONFIG_RECLAIMABLE_STACK */
 
 static int free_vm_stack_cache(unsigned int cpu)
 {
-- 
2.55.0.897.gb25b4bd76c-goog

