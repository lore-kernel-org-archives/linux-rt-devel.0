Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EA64F4020
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617330; cv=none; b=IjClR3FIbgrht8vAi/tMZeY0TNJg3Y8hVDXYQt8aDMpq2gHfNOYJrZ1G74MZW/QN95fkpIwyqB5kDakLOfojunQVY9j5QVPuVrmzz5ykeW7VE7GDHqY0M5ND/LIeP0Tcc77vTRCL5HtbqGmSYeK4NBXIBDfugSzAVp3uIMVXVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617330; c=relaxed/simple;
	bh=RvCHcUH58yjJupLOvtO7BpR8q4h0ix3uvkPrlmgoNTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oh8i9ZdaQoQv4cnwuPIs4j3TDF/QnUOLwD+aFma/NNicFoPsPXaZrO548NKVMUidYsEwojwQt0leM6+dW75yNXBCDWbLUZGJGdUCA/RU/A1w+UTzJ+6nAGYNHblk3rIirvmr17Fow7QdNM1ZNbGOuJ28zFckIzJ5lzScX8wtIg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ToCyjlqa; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ToCyjlqa"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49ccfad90f1so26755205e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 10:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617324; x=1791222124; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7RH6hoqk7EsLMc9nVwpPE+90gab30BNeM/1qTHEr8Y8=;
        b=ToCyjlqalBF9FA0TPBNhpZL6BKP8fy2G3kjQEuAOoFsis+tN9BfD/o/SoUf5gThIi5
         6T3+zLZqVbHJHoMMVslD1YTT4PiWeGaOe7BcBtFCbWQkxAEeMmNtFyK3ZRJyHoKPmmFj
         WcWzEH3L455OllzmtDEgkFuPKPR68hrwWfx6Jgjjy7I+sC7zGpMr0NvHPKzfqRwy8q47
         Nptm6UAGbcXO8mtMQCHrDIKLjh2/w5D0AuDwV9JX03vB3hdAJgEpJJLZwWjccoZObqcY
         OOKjM+FJg+rLeJe5lzaAoz4zpdaI6nruBdPzihy5XJewoHvVzTU0bfYF9bZ5iqlfAz7/
         vHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617324; x=1791222124;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7RH6hoqk7EsLMc9nVwpPE+90gab30BNeM/1qTHEr8Y8=;
        b=GxPFv4vX3XAYcNEIVDDenTCxRx4R++K8rxbuR1OafHoEfKKjpvvyEDLPJTg4rR5fMe
         thbx2YgaJ+SpncefG4InJoWEBaicAA5t6AF6SIwRWb0L02IURTXDKFYcBuLO75l5TeST
         gSMgkZ2FskBCrJ6A/FWL+AXn4op6RqKBi9Dn+tJS5cLrLLwejo/ixKgTTSF5YB8zaiHR
         prK7lRI1yGnz0haOfFJNX0MU3y3QBvecILVfp68ZPxVHAqIHHkoOPWzSy8p0jL36YzpC
         5qdnqHIh1ujPTD3I6PWpGmrIBJSxVh0iLkvxYlFjid7npBNPdmkDptn1MEmDHkuCV69Y
         5vDg==
X-Forwarded-Encrypted: i=1; AKwUvBxXG4bceXyGqhRBzBJMIYfNdyDENLfmGtY3ZPV5L0retUrMmIXE5YAAz6igvqLWcQm4YxKgsEHsJNaPJL/PtQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lmumNHE9jyhQi96RPvZy7XVEUVMb6/LtZkB/HtQfqD7xIwBKz0
	+N9wb+k2AN5/zu+P7RKiNKX8tftXAYetTQGeODYwXw/RbY5heQhs5yFHo1p4u99f4gEH0bC4r88
	tWzf7zTbsR4MTNw==
X-Received: from wmon22.prod.google.com ([2002:a05:600c:4656:b0:49e:7ce3:41f9])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a15:b0:49f:e444:cc4c with SMTP id 5b1f17b1804b1-49ff06bdb00mr183042675e9.12.1790617324124;
 Mon, 28 Sep 2026 10:42:04 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:20 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-14-smostafa@google.com>
Subject: [RFC PATCH 13/15] fork: Implement partial VMAP stack allocation
From: Mostafa Saleh <smostafa@google.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, 
	akpm@linux-foundation.org, urezki@gmail.com, mingo@redhat.com, 
	peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com, kees@kernel.org, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, gustavoars@kernel.org, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, 
	Mostafa Saleh <smostafa@google.com>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Linus Walleij <linus.walleij@linaro.org>, David Stevens <stevensd@google.com>
Content-Type: text/plain; charset="UTF-8"

When CONFIG_ARCH_HAS_VARIABLE_STACK_SIZE is enabled, architectures can
allocate a VMAP stack that is smaller than the full THREAD_SIZE.

This introduces arch abstraction arch_vm_stack_pages() which defaults
to THREAD_SIZE / PAGE_SIZE.
During stack allocation, the kernel will map only the requested number
of pages at the top of the THREAD_SIZE virtual area (as the stack
grows down), leaving the bottom unmapped. This saves memory while
retaining the same virtual alignment and guard page overflow detection
characteristics.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[Rebased, used vm_area->nr_pages directly in one instance]
[Depends on !PREEMPT_RT]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[Fix races around accounting]
[Use GFP_ATOMIC when executing in the scheduler]
[Depend on INIT_STACK_ALL_* config]
[Fix bugs in some error paths and edge cases]
[Don't cache partially faulted stacks]
[Added out-var to tell if address is on target stack]
Signed-off-by: David Stevens <stevensd@google.com>
[Remove dynamic stack related code, and update commit message]
[Fix memory leak in error path of alloc_vmap_stack()] and use
 VM_UNINITIALIZED before installing the pages]
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 include/linux/thread_info.h |  8 +++++
 kernel/fork.c               | 68 +++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)

diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 307b8390fc67..8f052ec82402 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -92,6 +92,14 @@ static inline long set_restart_fn(struct restart_block *restart,
 #define THREAD_ALIGN	THREAD_SIZE
 #endif
 
+/*
+ * Arch selecting CONFIG_ARCH_HAS_VARIABLE_STACK_SIZE should override this
+ * with kernel stack size.
+ */
+#ifndef arch_vm_stack_pages
+#define arch_vm_stack_pages()	(THREAD_SIZE / PAGE_SIZE)
+#endif
+
 #define THREADINFO_GFP		(GFP_KERNEL_ACCOUNT | __GFP_ZERO | __GFP_SKIP_KASAN)
 
 /*
diff --git a/kernel/fork.c b/kernel/fork.c
index ca8e68882316..66fbad3d4cbd 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -119,6 +119,8 @@
 
 /* For dup_mmap(). */
 #include "../mm/internal.h"
+/* For clear_vm_uninitialized_flag(). */
+#include "../mm/vmalloc.h"
 
 #include <trace/events/sched.h>
 
@@ -272,6 +274,71 @@ static bool try_release_thread_stack_to_cache(struct vm_struct *vm_area)
 	return false;
 }
 
+#ifdef CONFIG_ARCH_HAS_VARIABLE_STACK_SIZE
+static struct vm_struct *alloc_vmap_stack(int node)
+{
+	gfp_t gfp = GFP_VMAP_STACK;
+	unsigned long addr, end;
+	struct vm_struct *vm_area;
+	int err, i;
+
+	vm_area = get_vm_area_node(THREAD_SIZE, THREAD_ALIGN,
+				   VM_MAP | VM_UNINITIALIZED, node, gfp,
+				   __builtin_return_address(0));
+	if (!vm_area)
+		return NULL;
+
+	vm_area->pages = kmalloc_node(sizeof(void *) * (THREAD_SIZE >> PAGE_SHIFT),
+				      gfp, node);
+	if (!vm_area->pages)
+		goto cleanup_err;
+
+	for (i = 0; i < arch_vm_stack_pages(); i++) {
+		vm_area->pages[i] = alloc_pages_node(node, gfp, 0);
+		if (!vm_area->pages[i])
+			goto cleanup_err;
+		vm_area->nr_pages++;
+		mod_lruvec_page_state(vm_area->pages[i], NR_VMALLOC, 1);
+	}
+
+	end = (unsigned long)kasan_reset_tag(vm_area->addr) + THREAD_SIZE;
+	addr = end - (arch_vm_stack_pages() * PAGE_SIZE);
+
+	err = vmap_pages_range(addr, end, PAGE_KERNEL, vm_area->pages, PAGE_SHIFT);
+	if (err)
+		goto cleanup_err;
+
+	clear_vm_uninitialized_flag(vm_area);
+	return vm_area;
+
+cleanup_err:
+	remove_vm_area(vm_area->addr);
+	if (vm_area->pages) {
+		for (i = 0; i < vm_area->nr_pages; i++) {
+			mod_lruvec_page_state(vm_area->pages[i], NR_VMALLOC, -1);
+			__free_page(vm_area->pages[i]);
+		}
+		kfree(vm_area->pages);
+	}
+	kfree(vm_area);
+	return NULL;
+}
+
+static void free_vmap_stack(struct vm_struct *vm_area)
+{
+	int i;
+
+	remove_vm_area(vm_area->addr);
+
+	for (i = 0; i < vm_area->nr_pages; i++) {
+		mod_lruvec_page_state(vm_area->pages[i], NR_VMALLOC, -1);
+		__free_page(vm_area->pages[i]);
+	}
+
+	kfree(vm_area->pages);
+	kfree(vm_area);
+}
+#else
 static inline struct vm_struct *alloc_vmap_stack(int node)
 {
 	void *stack;
@@ -286,6 +353,7 @@ static inline void free_vmap_stack(struct vm_struct *vm_area)
 {
 	vfree(vm_area->addr);
 }
+#endif /* CONFIG_ARCH_HAS_VARIABLE_STACK_SIZE */
 
 static void thread_stack_free_work(struct work_struct *work)
 {
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

