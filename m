Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44754DD3D1
	for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 17:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617327; cv=none; b=ieXSTs0ne2PztH12PZ8BudcRmmX9JGzjuC4Lss1fTgCnLQBAW+1G7S6qXlQnA+05xoTmxHScltnrxdWWikaG619LVADV4edlZUZ8iQW0K2n3grPAuTOlXXcZ+WwAH/5RXMVFxYI9HgyU+iYNBwHKEyNo0dNC8Ar44Tcvs83Tpyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617327; c=relaxed/simple;
	bh=ZaSrs3uAjhFQCf51F89mMRcouDsCdEAkW+43AUiaKuM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LtETN7pgKYwqoP7RJrgIeHO4Hp0Z2U065b/JIBOvN+yFeOkSNxmy9c2IJ9mqwVR5E2PsDmsy8UIb08gZBSkqOHz8NgqdMpZapNsMikZGKBBwBuQcH3iS2aKT/0cvIM6ixUy7wWDpuAUPraYazOmLw0AxfcK/AzKp+BDlZB487zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lk8SooX3; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--smostafa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lk8SooX3"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a0032846d7so13805055e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 28 Sep 2026 10:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790617321; x=1791222121; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S18+bNUDQLF3l+YcVeHHvKuNDyoqJaJ7Bbt9+2o39Go=;
        b=lk8SooX36raBlNFotYrPMbzjlBRPFPPNP8tg+e0+khKPWJHU5ZrHvChc6Gma8t97Tp
         2dYmQ1uKGlejgE327lRlD3JAGbykGlY4PLZ4C6qbS9BiHzP/3Kq9F5MgW1YzZLT3vU0e
         OQf9YcyUYSOVtoyI/2lXaIR6C9AdmncbMmI8qKkUx1dLqWm/cmd9Ezymb0HTsNGSywQ/
         s5ycG5cuic/9/3Ly4tDYpLQ2lw9ZXrj/VwKsdC6e/C93KWPz1xH1VeNVxkY74D39cQJM
         PHWT3ThWpSScTeVt64V17sEjX7+M2qe8nZMw1MiuHFP9t2kUk+/dvYDrpRjmazvavyM3
         /j1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617321; x=1791222121;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S18+bNUDQLF3l+YcVeHHvKuNDyoqJaJ7Bbt9+2o39Go=;
        b=z/kEgVITpt780HpDvivoC0gQTuQOkJC4a6mvbuJlecMlh8FXZr4tlYCR976hhIYGg2
         n7UrF2MTeUZz8FQr0CkthQmDSnRGA+sC3hLq6Pe4yTNhvVdT49A3lARW4Rw7lWlTf/vJ
         YqH6TT2saV+aaV5SEhzyYcR6LY8gqWhtKL6joFMpj3+fzvOqAJocc/jAQfj+XZs8IgbN
         hyJoNB7n3Xv/82bH8p/04IyOLdYiaB76NkzXT/cA+UVKVs+1/DGc8TO8UOHFn31c+hIl
         FHkRBssUj8YzgN2Ic12u60otOj4ViaJgsL+uauP9xGIMzSZ2NcQpkB/3TW+4wZ2Ykz4B
         Hefw==
X-Forwarded-Encrypted: i=1; AKwUvBy7iw7utCFOwAphfmxJxMlPS24zshFGCCPKa4Pk6Zzb067w3uHI/i5RtMHwdHujPXTNid8dHBwMWx691ETgIg==@lists.linux.dev
X-Gm-Message-State: AFuF++mgBPMYkGuyUj9Nrmxx/VvRIIDKzUwA4i/Nq25l4sJ84zCFDxPu
	mmxnSJUrymLKPJ7exCYJx6X3n6UCeazK10IFvCZiFOvWkib72bn99zy4Fia3ToKcJUBIchmsEli
	cpJEba2t/NcIrdA==
X-Received: from wmoy19.prod.google.com ([2002:a05:600c:17d3:b0:4a0:507:52])
 (user=smostafa job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6990:b0:4a0:3c3:1ad4 with SMTP id 5b1f17b1804b1-4a003c31c71mr63736595e9.22.1790617321190;
 Mon, 28 Sep 2026 10:42:01 -0700 (PDT)
Date: Mon, 28 Sep 2026 17:41:18 +0000
In-Reply-To: <20260928174122.3380703-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260928174122.3380703-1-smostafa@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260928174122.3380703-12-smostafa@google.com>
Subject: [RFC PATCH 11/15] fork: Move vmap stack freeing to work queue
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
	David Stevens <stevensd@google.com>, Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"

From: David Stevens <stevensd@google.com>

For vmap stacks not immediately released into the stack cache, free them
in a workqueue instead of via call_rcu(). In an RCU context, vfree
already schedules the actual freeing on the per-cpu system workqueue, so
this change only affects when exactly the second attempt to put the
stack into the stack cache occurs.

Moving freeing to a workqueue will allow for freeing partially
populated stacks in a sleepable context (for remove_vm_area),
rather than relying on vfree dispatching to a workqueue via
vfree_atomic.

Signed-off-by: David Stevens <stevensd@google.com>
[Use system_percpu_wq instead of system_wq as it is deprecated and
 update commit msg]
Signed-off-by: Mostafa Saleh <smostafa@google.com>
---
 kernel/fork.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 3f1c46d8f7ec..ca8e68882316 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -208,7 +208,7 @@ static DEFINE_PER_CPU(struct vm_struct *, cached_stacks[NR_CACHED_STACKS]);
 #define GFP_VMAP_STACK (GFP_KERNEL | __GFP_ZERO | __GFP_SKIP_KASAN)
 
 struct vm_stack {
-	struct rcu_head rcu;
+	struct rcu_work work;
 	struct vm_struct *stack_vm_area;
 };
 
@@ -287,9 +287,9 @@ static inline void free_vmap_stack(struct vm_struct *vm_area)
 	vfree(vm_area->addr);
 }
 
-static void thread_stack_free_rcu(struct rcu_head *rh)
+static void thread_stack_free_work(struct work_struct *work)
 {
-	struct vm_stack *vm_stack = container_of(rh, struct vm_stack, rcu);
+	struct vm_stack *vm_stack = container_of(to_rcu_work(work), struct vm_stack, work);
 	struct vm_struct *vm_area = vm_stack->stack_vm_area;
 
 	if (try_release_thread_stack_to_cache(vm_stack->stack_vm_area))
@@ -308,7 +308,8 @@ static void thread_stack_delayed_free(struct task_struct *tsk)
 		vm_stack = tsk->stack + THREAD_SIZE - sizeof(*vm_stack);
 
 	vm_stack->stack_vm_area = tsk->stack_vm_area;
-	call_rcu(&vm_stack->rcu, thread_stack_free_rcu);
+	INIT_RCU_WORK(&vm_stack->work, thread_stack_free_work);
+	queue_rcu_work(system_percpu_wq, &vm_stack->work);
 }
 
 static int free_vm_stack_cache(unsigned int cpu)
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

