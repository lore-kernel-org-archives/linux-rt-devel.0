Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857D30DECB
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 23:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787873485; cv=none; b=s9Kg98qQIsFzHMxUYU/QLQUEu3cDZaD3DPW6iENcTaOmdo1m6YJoJ9xEcYWLFwmsw+AcH75cC6fok/nZiI1X8Y6UcEZFUKzCcGeDXcEwxxLl/QeQDkY4yccd2q/HeJBxsG821KzN3ERS1io0pD9Ni60m+4Pz6jAlVecd5IyAMT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787873485; c=relaxed/simple;
	bh=dfPDgNVh62+kHVsnAbD/7Pdvo8mCB2lnJPdMqfNI/Gc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k1nc3bq4bg+Dpg+HiS4KfzsM4/yiP38JTWbJKlch234DwWXsBq2SHUe1KeXBRwxDkdAIgNXQq3O2+o1zcNh3vA5ed44YZsNNQzJMu4JXJz3fvkGbsHaG4xStxCA7NogbiKKLE6miGXHrlFzgueubAmOHSLhGafuzXBHfKg1Vulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QbWD9Qtw; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--stevensd.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QbWD9Qtw"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cc1c62f0d60so720489a12.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 16:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787873482; x=1788478282; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRF3HmEVCSbkNryj4HHFEle4K2g8xeVsDlkdo6/RfiQ=;
        b=QbWD9Qtwz0EzSPqaMgI2vS8oUUA19FR978lnLvRKYKh8SHy7HN+VdqZcNe/pwwaBUB
         G6ebE089Ke18kO7u5OW/b4uBvcbYa1flJ079tZeXSwHzBk3LoKoadWpzeDDiagg/+IDJ
         xjgk385MQgcz6xNXjyFMnG0KpxVpIz6Gge1HsP06JgFPVaLQLNjheeVgcfXFHGpAJ9Ua
         f35RLl+hvU1OHcTeS9CoqiaN/JM5Km+YZEuOd9UyKJBKAvXlf3EwNHilJIpxsJSKePGx
         Vay3x7IfdVZ/0YyvQDSiNs0Hp6mDLyql3qU98VHxr3BjntNs58LhV9wQotFPL6QnZClU
         xQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787873482; x=1788478282;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRF3HmEVCSbkNryj4HHFEle4K2g8xeVsDlkdo6/RfiQ=;
        b=YcIYPCiLwSTXXBWC2aTcHIWAcHNiVLbnwgzQPsua8LgA5qGBSc5YpT4XDHloX5jbak
         NF03RQiwin37OsiUPPrWGmxM8ZNfrM/z8hR5soXBZ8Qo0xXeYomv/6iJTX52TfTj0C4G
         8oVo1tQ2DKXOLjAPLBlaL7XiRWYxpyTWp+EmBaNJJsU964vwtK3i3sxNt1Cku50T3p6t
         mIkC8wADVr9RMGeXWop1R+clNzAMWyoPIOr5vyAaiWiODV4crhaCZDnO73i/UcueSBxJ
         iCqQx+xgF+Ki0kUHEsXw4Ynz2qndHBvQf0Ajner/CX43o4EBxgTcWYkkUcQwi8o3kCNU
         Rstw==
X-Forwarded-Encrypted: i=1; AHgh+RrrsP0CatQjA370Gbt5d4ZtIlknykjZpkM8lVGwZsehhD8SvAm3NDG3fCJ8FYxnatXbMPUEuVEFe4YIXertMQ==@lists.linux.dev
X-Gm-Message-State: AFuF++kaDwkpVpV291Ye6n5hOChQhW2L6jT1VZHbFWbfdr+2ubhROAwt
	e3ZHoJW/dQYaWzioE5NU3RmFIqgYlZDfuh6bnch1cG3fYsDBeovn+dUQZFFMTlGVWlD9zbgaoSB
	jphbbaBrSOnKVDw==
X-Received: from dyblf13.prod.google.com ([2002:a05:7301:a0d:b0:315:bf25:ce14])
 (user=stevensd job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:94c9:b0:3d1:be60:2816 with SMTP id adf61e73a8af0-3d268cf776bmr3404563637.10.1787873482070;
 Thu, 27 Aug 2026 16:31:22 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:29:41 -0700
In-Reply-To: <20260827232948.2520558-1-stevensd@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260827232948.2520558-1-stevensd@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260827232948.2520558-4-stevensd@google.com>
Subject: [RFC 03/10] fork: refactor vmap stack alloc/free into helpers
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

Prepare for alternate implementations of some functions for reclaimable
stacks by creating helpers for allocating and freeing vmap stacks. Also
reorder some functions to consolidate the functions that will have
alternate implementations.

Signed-off-by: David Stevens <stevensd@google.com>
---
 kernel/fork.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index f0e2e131a9a5..10bd76f6dd20 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -207,11 +207,6 @@ static DEFINE_PER_CPU(struct vm_struct *, cached_stacks[NR_CACHED_STACKS]);
  */
 #define GFP_VMAP_STACK (GFP_KERNEL | __GFP_ZERO | __GFP_SKIP_KASAN)
 
-struct vm_stack {
-	struct rcu_head rcu;
-	struct vm_struct *stack_vm_area;
-};
-
 static struct vm_struct *alloc_thread_stack_node_from_cache(struct task_struct *tsk, int node)
 {
 	struct vm_struct *vm_area;
@@ -272,6 +267,26 @@ static bool try_release_thread_stack_to_cache(struct vm_struct *vm_area)
 	return false;
 }
 
+static void free_vmap_stack(struct vm_struct *vm_area)
+{
+	vfree(vm_area->addr);
+}
+
+static struct vm_struct *alloc_vmap_stack(int node)
+{
+	void *stack = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN,
+				     GFP_VMAP_STACK,
+				     node, __builtin_return_address(0));
+	if (!stack)
+		return NULL;
+	return find_vm_area(stack);
+}
+
+struct vm_stack {
+	struct rcu_head rcu;
+	struct vm_struct *stack_vm_area;
+};
+
 static void thread_stack_free_rcu(struct rcu_head *rh)
 {
 	struct vm_stack *vm_stack = container_of(rh, struct vm_stack, rcu);
@@ -280,7 +295,7 @@ static void thread_stack_free_rcu(struct rcu_head *rh)
 	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
 		return;
 
-	vfree(vm_area->addr);
+	free_vmap_stack(vm_area);
 }
 
 static void thread_stack_delayed_free(struct task_struct *tsk)
@@ -302,7 +317,7 @@ static int free_vm_stack_cache(unsigned int cpu)
 		if (!vm_area)
 			continue;
 
-		vfree(vm_area->addr);
+		free_vmap_stack(vm_area);
 		cached_vm_stack_areas[i] = NULL;
 	}
 
@@ -338,7 +353,7 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	vm_area = alloc_thread_stack_node_from_cache(tsk, node);
 	if (vm_area) {
 		if (memcg_charge_kernel_stack(vm_area)) {
-			vfree(vm_area->addr);
+			free_vmap_stack(vm_area);
 			return -ENOMEM;
 		}
 
@@ -356,15 +371,13 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		return 0;
 	}
 
-	stack = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN,
-				     GFP_VMAP_STACK,
-				     node, __builtin_return_address(0));
-	if (!stack)
+	vm_area = alloc_vmap_stack(node);
+	if (!vm_area)
 		return -ENOMEM;
+	stack = vm_area->addr;
 
-	vm_area = find_vm_area(stack);
 	if (memcg_charge_kernel_stack(vm_area)) {
-		vfree(stack);
+		free_vmap_stack(vm_area);
 		return -ENOMEM;
 	}
 	/*
-- 
2.55.0.897.gb25b4bd76c-goog

