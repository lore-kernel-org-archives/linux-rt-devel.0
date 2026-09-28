Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3C4EB869
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 17:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617316; cv=none; b=KczwKvBcN2rcLuQaoQ9FVkb50I5NCkLD1UsZsa0qIq/dfGiyJDnZlaBXiAWC24yF/Zjxe/vetPLK+qiSvqYWCf/k0FfDmWpsZrlBCSYCp5lzlZTAUIgE0wI9tKJ0ayQ3Ne0f9RsgOamrlY6wHMcCu7IA3FtQ3uzGB3TwR3Bt8M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617316; c=relaxed/simple;
	bh=c1POIadwprxPDNsdozfeD1o6wPxvRs9raPf1U3VIYsA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BAEOODVqLOn0TEiqVnQhJ4iAcgdDSTWA1lE5F7up4HJ/Z5igzw9vfq647NiFdXz8Kkw8Uq1jvLeBKvlU63+Xxf8PrS1p9sV9Jajk/ZbP4ba7KoUSWELt0Rjseco9HibH3QR/AGyghSQsfK4iRfJ8EZnsbfaL3y0LL58Mr4cEISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s++Z/F6W; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s++Z/F6W"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49e635a6002so39743795e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 10:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617312; x=1791222112; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1DJuPuQM9kSMFWHvWycx46i6Qw8Tz2JNB7c4R6pz+k=;
        b=s++Z/F6WTg63biR4Uys/WpmcNunxduGRCiyblfim/qbY4tCo2iQPJPOb5DABnKeV0d
         zkVuRZvCMB7969zoRpA3/GWdEoN+fkuh8jGZOK1aoPa3ELLfx4BJaDjhMjGoxmB9bL+g
         x6Tno85PiuVpICbj8YeDrEFDlltIvcm3gwsRCiN4UWyypqd5adLuJRaLgVAXTaahne5Q
         9JHfDNArFQP3LpoTrGEOZwFO+lfLSZaiEEFXahknWZugdvlQXGCyUnjtYa2oBbC5ktEZ
         fYnUIP7NMpqyf+6fWotBnLxq4pggYq+kYMQeyJp2NY+sFj+IngpSNThyugcn9Fsf+TIr
         TS3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617312; x=1791222112;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+1DJuPuQM9kSMFWHvWycx46i6Qw8Tz2JNB7c4R6pz+k=;
        b=pp9SYxYhgdv2OOVaQqR/KhoK6GXzylAnuhMoBkJDt8X6gJHitR5F3ckhZFa3bKK377
         r+pu3lm+kxRHTaL/pW69x9Sk4OyXzBvOKYCJ8rXhFITcR0oZtMeLE6WpYDkTLtahvnp3
         rUSy8O5iENi/O4+JgDq6tgfMmpToS+Bt6g005ESWxLI3ena78lwA0L1a2TdANXNc/ukG
         pPo82gX7cHCtCSrkhJy57EQnD0IbDXFdvG3M/w0Mb8oFyRvl5oUXlaP0lKHwomX6ddRR
         e/v2GNwdtjEX8dD6x4t+/xuCgwM/54gXyoolrKfRRWQrvaRNaOkIF+0cLvRq8vwclmS/
         lQ/g==
X-Forwarded-Encrypted: i=1; AKwUvBzeUIDz+7G6nPTzwRjFJ4EoO0Zvp1lWedZ0pz2187AYlObhXnb2j05ktSmkEca3DqUsr5C1gJKsFUkMqvZ34w==@lists.linux.dev
X-Gm-Message-State: AFuF++kesFT6gKE3bMBzyNni9GXXUzK17CWkkXklxN5oGAuZzfYnjjpu
	fi9C4lIBK5XYw04uN6y775G8Pof9nH7aCqoI3EP9i1QfC/YW6Apq32RPZrkf4AEmdelM1R3/Z07
	wIMg8EEWCjCAuig==
X-Received: from wmbhn25.prod.google.com ([2002:a05:600c:a399:b0:4a0:146:71bc])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:83c4:b0:49f:c331:39e4 with SMTP id 5b1f17b1804b1-49fe66ca101mr236728135e9.7.1790617311982;
 Mon, 28 Sep 2026 10:41:51 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:11 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-5-smostafa@google.com>
Subject: [RFC PATCH 04/15] fork: Separate vmap stack allocation and free calls
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
	Pasha Tatashin <pasha.tatashin@soleen.com>, Linus Walleij <linus.walleij@linaro.org>, 
	David Stevens <stevensd@google.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Pasha Tatashin <pasha.tatashin@soleen.com>

In preparation for the partially populated stacks, separate out the
__vmalloc_node and vfree calls from the vmap based stack allocations.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
[Fix a bug in original patch: free_vmap_stack(vm_area->addr)]
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
[Add missing free_vmap_stack conversion, fix typos, rebase]
Signed-off-by: David Stevens <stevensd@google.com>
[Resolved conflict in alloc_thread_stack_node(), update commit msg]
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/fork.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 473878d7f62f..3f1c46d8f7ec 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -272,6 +272,21 @@ static bool try_release_thread_stack_to_cache(struct vm_struct *vm_area)
 	return false;
 }
 
+static inline struct vm_struct *alloc_vmap_stack(int node)
+{
+	void *stack;
+
+	stack = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN, GFP_VMAP_STACK,
+			       node, __builtin_return_address(0));
+
+	return stack ? find_vm_area(stack) : NULL;
+}
+
+static inline void free_vmap_stack(struct vm_struct *vm_area)
+{
+	vfree(vm_area->addr);
+}
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
@@ -307,7 +322,7 @@ static int free_vm_stack_cache(unsigned int cpu)
 		if (!vm_area)
 			continue;
 
-		vfree(vm_area->addr);
+		free_vmap_stack(vm_area);
 		cached_vm_stack_areas[i] = NULL;
 	}
 
@@ -336,14 +351,14 @@ static int memcg_charge_kernel_stack(struct vm_struct *vm_area)
 static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 {
 	struct vm_struct *vm_area;
-	void *stack;
 
 	vm_area = alloc_thread_stack_node_from_cache(tsk, node);
 	if (vm_area) {
 		unsigned long offset = 0;
+		void *stack;
 
 		if (memcg_charge_kernel_stack(vm_area)) {
-			vfree(vm_area->addr);
+			free_vmap_stack(vm_area);
 			return -ENOMEM;
 		}
 
@@ -364,15 +379,12 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 		return 0;
 	}
 
-	stack = __vmalloc_node(THREAD_SIZE, THREAD_ALIGN,
-				     GFP_VMAP_STACK,
-				     node, __builtin_return_address(0));
-	if (!stack)
+	vm_area = alloc_vmap_stack(node);
+	if (!vm_area)
 		return -ENOMEM;
 
-	vm_area = find_vm_area(stack);
 	if (memcg_charge_kernel_stack(vm_area)) {
-		vfree(stack);
+		free_vmap_stack(vm_area);
 		return -ENOMEM;
 	}
 	/*
@@ -381,8 +393,7 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
 	 * so cache the vm_struct.
 	 */
 	tsk->stack_vm_area = vm_area;
-	stack = kasan_reset_tag(stack);
-	tsk->stack = stack;
+	tsk->stack = kasan_reset_tag(vm_area->addr);
 	return 0;
 }
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

