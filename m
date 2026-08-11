Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FB83043DE
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786478768; cv=none; b=A/b6/llHrSm0Ls2mbvj8XuMyQrMYV3n0mjWzLR+MDiVG0VQeiMSUG7zhhMZn6oH7SAU99S4hjTrzE6mlPrqotX+PxozVA0HcujdnJutLiILrqFQsjkXi7QwfVVdmdkB3uk3zff1QGnsgmQgrIViG0zEbCbJ6SOyBx6rHBi+WV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786478768; c=relaxed/simple;
	bh=pGZ4j5wzZm9qIke8Q186PmhBGY2igKy313aN/7NKrrA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sgn1G3Y6AmaL9Gc93JMOEsXy2GJwn4MJtuUdHmXcQe1EMYucJkETGl7zaMcDHa9MQJkHoLOck7ML2FNceOPh2UAI5hUz6kFSZokxEyX2F0AGYTeHWoXM1fqH9KrPxj8lWLN86GEkgFGf+jKHeSq1OjffbQcBc69Y8bMufq2e93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikrkw6fy; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikrkw6fy"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cf7dd9fd91so2981215ad.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 13:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786478765; x=1787083565; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mHNzSxXj0COMq5ZCxE4trCLjxzBSaHB9lM75a8GWZr4=;
        b=ikrkw6fyQ3paP11a6UwKs86h87Ynn8EYg4zJvmPtPqJMQ0NY6xOCLKwrISsmrGH73V
         CgpfSJaXDZY/XKWisFOd5qG5V969lJ7REaQgZ+lHunKKqxCfcRBL+HtTk4Az1M2GbCWG
         du2vw6Q+e+cet0xPjSU2RnJiX3V2MS44Bw10WoajAGvP52IWfc2iiHSofW3fgjKCZLG0
         lIP7TfxG79KbeZE0UiGZTDK5KFyw8MAPdqeWIiZZ5nJ98ELCh02VS4IzcaSlFd1XQOLv
         9Lki7seOOHmBiDiXbwc/Sd1qgLJvWrEJMMCFUYH5M2rVmQkU1Q7PDGDv0ms4UuE3De+r
         sOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786478765; x=1787083565;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mHNzSxXj0COMq5ZCxE4trCLjxzBSaHB9lM75a8GWZr4=;
        b=lptcFyUSKaqX9HcNUEDSpr1ynBztT0vrrXxsjvdDCTWGrRYIBYmsK7t98oGQzH/r0H
         tZz2X0e/xEf7Lc8O3UEvebExsl9xpj6Ov+gr9yerSQJwZB3MOEKO/U/gUTKgtoUTgfp5
         ArJIzIobojyciSYqVp74/1NSuD0yFVsNoT/PE0+q2XtbloeBHElVGcD4L92RVuPqj/mR
         RcDl4qIdjzVr1JcA/KnUzeRjqgiqa8zqQH3TXYpBodTLSacArZeGIaYXzEI5v9oNIWu5
         PYnC2I9XvL0VuBJkGPnQYBKw8KO8ZV3x70s1dy3uX6jn121Vy7Po+ItevJq+oJ212z+H
         nH+A==
X-Forwarded-Encrypted: i=1; AHgh+RpaYmAVpIMDBKvCis1wxcAovdC6DU1DDjMqWC4xXOqo8CPuVJNmMFGzGjpAUT6Ejrgvi9gsQV5TNgt7gkPuvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzO2MoqlpMVAgvExcZD8qL+oMU9RmeQEzPQJQfqBnZq8D9kMwFq
	I6ILnD9UNwXiV65ddDPzx4Snj2K+kd62HJTS2HT1UwPJTPpSvAQvMlhIWJf8+F3OIhJkqxkI0YS
	hNljn0A==
X-Received: from plbko6.prod.google.com ([2002:a17:903:7c6:b0:2cc:77e3:3ef0])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e784:b0:2ca:b4b9:4586
 with SMTP id d9443c01a7336-2d3178e8ac4mr77418145ad.19.1786478764486; Tue, 11
 Aug 2026 13:06:04 -0700 (PDT)
Date: Tue, 11 Aug 2026 13:06:03 -0700
In-Reply-To: <20260811181915.GO544626@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260811162423.GL544626@ziepe.ca> <f33571137d2e3973e440d09c7602edaebe08b714.camel@infradead.org>
 <20260811172627.GN544626@ziepe.ca> <B25708F5-8425-4075-8D95-5E2A00C933DF@infradead.org>
 <20260811181915.GO544626@ziepe.ca>
Message-ID: <anuAq2s4mtyw4_Ql@google.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Woodhouse <dwmw2@infradead.org>, akpm@linux-foundation.org, david@kernel.org, 
	mhocko@suse.com, rostedt@goodmis.org, bigeasy@linutronix.de, 
	simona.vetter@ffwll.ch, jglisse@redhat.com, christian.koenig@amd.com, 
	paulmck@kernel.org, pbonzini@redhat.com, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 11, 2026, Jason Gunthorpe wrote:
> On Tue, Aug 11, 2026 at 06:59:24PM +0100, David Woodhouse wrote:
> > On 11 August 2026 18:26:27 BST, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > >On Tue, Aug 11, 2026 at 06:22:12PM +0100, David Woodhouse wrote:
> > >> On Tue, 2026-08-11 at 13:24 -0300, Jason Gunthorpe wrote:
> > >> > To be clear you should not be using any synchronize_[s]rcu() primitive
> > >> > inside the invalidation callbacks. These are well known to have
> > >> > multi-second delays on loaded systems which are a completely
> > >> > inappropriate performance characteristic for these mm callbacks.
> > >> > 
> > >> > This statement has nothing to do with deadlock.
> > >> > 
> > >> > RCU is always a trade off, you can make the read side run really fast
> > >> > and the write side is ghastly slow. If you can't handle the slow write
> > >> > you shouldn't use RCU techniques.
> > >> 
> > >> The multi-second horror stories are about the *global* RCU/SRCU
> > >> domains, where the grace period has to wait out arbitrary readers all
> > >> over the kernel.
> > >> 
> > >> This is not that. It is a dedicated srcu_struct, private to one VM,
> > >> and its entire reader population is a handful of KVM fast paths that
> > >> until now were under irqsave rwlocks.
> > >
> > >Are you sure? I've never heard that srcu has those kinds of properties.
> > >
> > >If its so fast you should just propose a non-sleeping version and
> > >leave the notifiers out of it
> >
> > I've got torture tests running for correctness on the GPC RCU
> > conversion. I'll throw in some metrics on how often even in that
> > pathological case we hit the wait case, and how long it actually
> > takes.
> 
> Well, to hit the bad RCU cases you need to usually do some other
> workload too..

Yeah, and we've had several (recent) examples of SRCU tail latencies causing
problems for KVM.

> I guess srcu does have some meaningful functional differences, but it
> is hardly guaranteed to be fast or non-sleeping out of the box.
> 
> I guess you are making an arugment that if SRCU critical sections are
> atomic themselves then the synchronize could also reasonably be
> atomic. That seems plausible, and may be worth some additional API
> surface on the SRCU side to expose this use model and drop the might
> sleep that is causing the trouble.
> 
> Some sort of "atomic RCU" that has a slower reader but a faster atomic
> writer.
> 
> I'm much happier to see a formal API under the notifiers that has
> strong properties of being reasonable than KVM using SRCU in a way
> that just happens to do that by accident, under the current
> implementation..

Agreed, I suspect shoving a synchronize_*rcu() of any kind in the mmu_notifier
invalidation path will come back to bite us, hard.

But I don't think we need an entirely new type of RCU for KVM.  Unlike (S)RCU,
KVM can and _must_ block relevant readers when an invalidation is in-flight.
I.e. the invalidation path doesn't need to ensure *all* readers go away, only
that the relevant readers have observed the invalidation.

The readers also don't need to be allowed to sleep; I suggested using SRCU instead
of RCU purely because the tail latencies for regular RCU are typically much, much
worse than SRCU (and I agree that they're bad for SRCU).

Earlier, David described KVM's GPCs as de facto software TLBs, and KVM already
has code to protect walks of what are effectively software TLBs, specifically
walk_shadow_page_lockless_{begin,end}() and the associated write-side handling
of READING_SHADOW_PAGE_TABLES in kvm_request_needs_ipi().

And looking to the future, if/when we use GPCs to track PFNs that are mapped into
the guest through control structures, i.e. not through page tables, we'll already
need to rely on kicking CPUs via IPI to ensure readers see the invalidation.

So rather than use (S)RCU, what if KVM tracks which CPUs are reading and then
blasts IPIs to complete the "TLB" shootdown?

The biggest wrinkle I can think of is that unlike READING_SHADOW_PAGE_TABLES,
there isn't a 1:1 association between vCPUs and CPUs, i.e. KVM can't walk its
array of vCPUs to see which CPUs need to be kicked.  But that should be easy enough
to solve with a cpumask.  Cache line contention might be a problem, but if so, it
seems like a solvable problem.

Very roughly and incomplete, relative to David's series to use SRCU:

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ac961f4c91da..b4a7b613ad91 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1719,18 +1719,18 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 {
 	struct pvclock_vcpu_time_info *guest_hv_clock;
 	struct pvclock_vcpu_time_info hv_clock;
-	int idx;
+	unsigned long flags;
 
 	memcpy(&hv_clock, ref_hv_clock, sizeof(hv_clock));
 
-	idx = srcu_read_lock(&vcpu->kvm->gpc_srcu);
+	flags = kvm_gpc_read_begin(vcpu->kvm);
 	while (!kvm_gpc_check(gpc, offset + sizeof(*guest_hv_clock))) {
-		srcu_read_unlock(&vcpu->kvm->gpc_srcu, idx);
+		kvm_gpc_read_end(vcpu->kvm, flags);
 
 		if (kvm_gpc_refresh(gpc, offset + sizeof(*guest_hv_clock)))
 			return;
 
-		idx = srcu_read_lock(&vcpu->kvm->gpc_srcu);
+		flags = kvm_gpc_read_begin(vcpu->kvm);
 	}
 
 	guest_hv_clock = (void *)(gpc->khva + offset);
@@ -1755,7 +1755,7 @@ static void kvm_setup_guest_pvclock(struct pvclock_vcpu_time_info *ref_hv_clock,
 	guest_hv_clock->version = ++hv_clock.version;
 
 	kvm_gpc_mark_dirty_in_slot(gpc);
-	srcu_read_unlock(&vcpu->kvm->gpc_srcu, idx);
+	kvm_gpc_read_end(vcpu->kvm, flags);
 
 	trace_kvm_pvclock_update(vcpu->vcpu_id, &hv_clock);
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7b2dbbd6b104..54ec1082c5ec 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -189,6 +189,8 @@ bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
 				 unsigned long *vcpu_bitmap);
 bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req);
 
+void kvm_kick_many_cpus(cpumask_var_t __cpus, bool wait);
+
 #define KVM_USERSPACE_IRQ_SOURCE_ID		0
 #define KVM_IRQFD_RESAMPLE_IRQ_SOURCE_ID	1
 #define KVM_PIT_IRQ_SOURCE_ID			2
@@ -814,7 +816,7 @@ struct kvm {
 	 * A dedicated domain (rather than kvm->srcu) keeps those waits from
 	 * being lengthened by unrelated memslot readers.
 	 */
-	struct srcu_struct gpc_srcu;
+	cpumask_var_t gpc_readers;
 
 	/*
 	 * created_vcpus is protected by kvm->lock, and is incremented
@@ -1569,6 +1571,20 @@ static inline bool kvm_gpc_is_hva_active(struct gfn_to_pfn_cache *gpc)
 	return gpc->active && kvm_is_error_gpa(gpc->gpa);
 }
 
+static inline unsigned long kvm_gpc_read_begin(struct kvm *kvm)
+{
+	unsigned long flags;
+
+	local_irq_save(flags);
+	cpumask_set_cpu(smp_processor_id(), kvm->gpc_readers);
+}
+
+static inline void kvm_gpc_read_end(struct kvm *kvm, unsigned long flags)
+{
+	cpumask_clear_cpu(smp_processor_id(), kvm->gpc_readers);
+	local_irq_restore(flags);
+}
+
 void kvm_sigset_activate(struct kvm_vcpu *vcpu);
 void kvm_sigset_deactivate(struct kvm_vcpu *vcpu);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c6e1c9c28b7e..9ef14057e477 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -205,7 +205,7 @@ static void ack_kick(void *_completed)
 {
 }
 
-static inline bool kvm_kick_many_cpus(struct cpumask *cpus, bool wait)
+static inline bool __kvm_kick_many_cpus(struct cpumask *cpus, bool wait)
 {
 	if (cpumask_empty(cpus))
 		return false;
@@ -214,6 +214,18 @@ static inline bool kvm_kick_many_cpus(struct cpumask *cpus, bool wait)
 	return true;
 }
 
+void kvm_kick_many_cpus(cpumask_var_t __cpus, bool wait)
+{
+	struct cpumask *cpus;
+
+	guard(preempt)();
+
+	cpus = this_cpu_cpumask_var_ptr(cpu_kick_mask);
+	cpumask_copy(cpus, __cpus);
+
+	__kvm_kick_many_cpus(cpus, wait);
+}
+
 static void kvm_make_vcpu_request(struct kvm_vcpu *vcpu, unsigned int req,
 				  struct cpumask *tmp, int current_cpu)
 {
@@ -262,7 +274,7 @@ bool kvm_make_vcpus_request_mask(struct kvm *kvm, unsigned int req,
 		kvm_make_vcpu_request(vcpu, req, cpus, me);
 	}
 
-	called = kvm_kick_many_cpus(cpus, !!(req & KVM_REQUEST_WAIT));
+	called = __kvm_kick_many_cpus(cpus, !!(req & KVM_REQUEST_WAIT));
 	put_cpu();
 
 	return called;
@@ -284,7 +296,7 @@ bool kvm_make_all_cpus_request(struct kvm *kvm, unsigned int req)
 	kvm_for_each_vcpu(i, vcpu, kvm)
 		kvm_make_vcpu_request(vcpu, req, cpus, me);
 
-	called = kvm_kick_many_cpus(cpus, !!(req & KVM_REQUEST_WAIT));
+	called = __kvm_kick_many_cpus(cpus, !!(req & KVM_REQUEST_WAIT));
 	put_cpu();
 
 	return called;
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 97958af667fb..305706ba35dd 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -121,7 +121,7 @@ void gfn_to_pfn_cache_invalidate_start(struct kvm *kvm, unsigned long start,
 	 * "size at init" flag, or GFP_NOWAIT in the upgrade).
 	 */
 	if (cleared)
-		synchronize_srcu(&kvm->gpc_srcu);
+		kvm_kick_many_cpus(kvm->gpc_readers, true);
 
 	/*
 	 * Note the GPC_INVALIDATING markers set above are deliberately NOT

