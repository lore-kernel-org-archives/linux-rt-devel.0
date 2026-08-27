Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D5E305699
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 22:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787869081; cv=none; b=cf28IHMs+Fp6s1ekofbZiLmuL6amJ69E+lDOXBv/gQ2KKxBUjPnrwXDaY/xmy7hDeu2eQJifG03GyGfzEg7/GtZVIH75URBLVCgrSAK44kuvZuON7spU5s4dV5qLW3ZGMeYqtHCb+/Up0a3HIQv5SsWcNqi20a5zJlXYxfvCIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787869081; c=relaxed/simple;
	bh=4g6D4WJqie44pY6zCy76n2BzsOIVEEIrPZSj7mF5FAE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eoeaE9E/Ezq4izrwhv+Sdlbee5UOgDDtvQ1vfcaxKAjXNamsH1yh90cJJz5OmvUpyafaE8nIG5QiWym2OBcS/TSwU1WNikFYbTTlbjHqtIFhRV4GobVo4yZNCO/1w9U/NZiR0MzkK0U6QDxk+SZdCvISQisov4FCXpH3ShwN76U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iW4xCTWX; arc=none smtp.client-ip=209.85.215.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iW4xCTWX"
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc1b8088203so272189a12.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 27 Aug 2026 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787869079; x=1788473879; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cw6ij3wxYDl68tkuGy7ynKowVPqKz0JRX8l/MVMdLYQ=;
        b=iW4xCTWXZUkbJ0voA0nX1C01GFgNW4/XWmp9yuJXwNrMC4okwtAzsKlQho34mz3f1O
         G8/pWOPLHKO4P2MmrIV0318bHpTDJ8tkHMOxGkCnA0v29ffz6ZHd7HmWp7ESxtHwxe+w
         4hGvgcSGI6ySHqAJrNu5i3vzGPlVmPkEj5GOhb5f3yaUqsZOiEQuGtj0Le7PftoIoyaY
         FTOxLTURxbwVvNe5J9GIeKrODRKpL+NFTnsecjNKq5JvHVT102NHcwG8+/y0SW5y3INV
         f0Q2qyT0xCVIQ1zfe7auHoamA2emgx1m/pMP9GL4EFQsbdeVbobMX3Xr9/AZ6Jh0TQec
         ZS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787869079; x=1788473879;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cw6ij3wxYDl68tkuGy7ynKowVPqKz0JRX8l/MVMdLYQ=;
        b=NKVFuzMPTKYgXQGxeF5469g7l9Q0eduYUp04X+QNhRsFXbOi7r9yTSGWXWrf1OSD++
         WlCQeGHBe3GYh01erZy0ixzOPo69J+LHca5yGwnZTiTHz2rklzKOIwu+n8XhNor0j2uw
         3rvnQVhi+x0QN8a3P91Z5PY95+AN7b/AeFx6kJknWDtqx3Rzd6kMAwrcfHT+2JyYK6IV
         JhGuKOEcz8qdS8MIvRbFmH0IzcmDaAderq8YsyzXYU5xP8WKJlZDeLMFY4J7adrxr9p5
         vaQt38mqYZHr9ExhHulk0rmCpjC4johQb1S2i3Wt99zAux58vLmfUZ5Mb5KkuHo13K+p
         64ww==
X-Forwarded-Encrypted: i=1; AHgh+RoYdLwl1/gnutRtPHsiNZJd/pPgP+g8BzGCBndbHfq8HEj7JhtqTToK+LM4pNh6VPqI2fGVzH0DIfHBI/fwuw==@lists.linux.dev
X-Gm-Message-State: AFuF++nIQcINUbLk5DQm9SWwDv/43cgiioN093M1z26fh6+YVAzkeGmb
	Stcj9DU2WGNQwnUiF8GROvY6PYQUmFFG7/tMUsV9eKmj6ppeDlxwIdMuTblS97Ex9rzZbZXyuDf
	PDoFWSA==
X-Received: from pghf20.prod.google.com ([2002:a63:e314:0:b0:cc1:c65d:a775])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1c8a:b0:851:8394:1696
 with SMTP id d2e1a72fcca58-8562b49995emr4859459b3a.12.1787869078698; Thu, 27
 Aug 2026 15:17:58 -0700 (PDT)
Date: Thu, 27 Aug 2026 15:17:57 -0700
In-Reply-To: <apCwV7xenDh2qmr7@google.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <8d47b43e1829ac92703723e6a1a4afc7a2eaacb5.camel@infradead.org> <apCwV7xenDh2qmr7@google.com>
Message-ID: <apC3lYri5r4KUM3T@google.com>
Subject: Re: KVM: x86/mmu: __kvm_rmap_lock() preemption assert trips on PREEMPT_RT
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: James Houghton <jthoughton@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 27, 2026, Sean Christopherson wrote:
> On Thu, Aug 27, 2026, David Woodhouse wrote:
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 81c30e2c74f3..31a372d0697c 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -913,11 +913,15 @@ static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu
>   */
>  #define KVM_RMAP_LOCKED	BIT(1)
>  
> -static unsigned long __kvm_rmap_lock(struct kvm_rmap_head *rmap_head)
> +static unsigned long __kvm_rmap_lock(struct kvm *kvm,
> +				     struct kvm_rmap_head *rmap_head)
>  {
>  	unsigned long old_val, new_val;
>  
> -	lockdep_assert_preemption_disabled();
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		lockdep_assert_preemption_disabled();
> +	else
> +		lockdep_assert_held(&kvm->mmu_lock);

...

> @@ -1745,11 +1754,15 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
>  	gfn_t gfn;
>  	int level;
>  
> +#ifdef CONFIG_PREEMPT_RT
> +	guard(read_lock)(&kvm->mmu_lock);
> +#endif

And now I remember why I swept this under the rug.  This really should take
mmu_lock for write, otherwise concurrent aging threads could theoretically get
stuck competing for KVM_RMAP_LOCKED.  Which is silly, because they don't actually
need to take a lock of any kind.  I.e. it's not super trivial?

Wait, duh.  It is trivial if mmu_lock is held, because then KVM can operate on
rmaps without any KVM_RMAP_LOCKED shenanigans.  I wouldn't test this because it
might break horribly, but I think this?

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 81c30e2c74f3..2b157b390a40 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -895,6 +895,7 @@ static struct kvm_memory_slot *gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu
  */
 #define KVM_RMAP_MANY	BIT(0)
 
+#ifndef CONFIG_PREEMPT_RT
 /*
  * rmaps and PTE lists are mostly protected by mmu_lock (the shadow MMU always
  * operates with mmu_lock held for write), but rmaps can be walked without
@@ -1008,7 +1009,8 @@ static unsigned long kvm_rmap_get(struct kvm_rmap_head *rmap_head)
  * actual locking is the same, but the caller is disallowed from modifying the
  * rmap, and so the unlock flow is a nop if the rmap is/was empty.
  */
-static unsigned long kvm_rmap_lock_readonly(struct kvm_rmap_head *rmap_head)
+static unsigned long kvm_rmap_lock_readonly(struct kvm *kvm,
+					    struct kvm_rmap_head *rmap_head)
 {
 	unsigned long rmap_val;
 
@@ -1032,6 +1034,35 @@ static void kvm_rmap_unlock_readonly(struct kvm_rmap_head *rmap_head,
 	__kvm_rmap_unlock(rmap_head, old_val);
 	preempt_enable();
 }
+#else
+static unsigned long kvm_rmap_get(struct kvm_rmap_head *rmap_head)
+{
+	return atomic_long_read(&rmap_head->val);
+}
+static unsigned long kvm_rmap_lock(struct kvm *kvm,
+				   struct kvm_rmap_head *rmap_head)
+{
+	lockdep_assert_held_write(&kvm->mmu_lock);
+	return kvm_rmap_get(rmap_head);
+}
+
+static void kvm_rmap_unlock(struct kvm *kvm,
+			    struct kvm_rmap_head *rmap_head,
+			    unsigned long new_val)
+{
+	atomic_long_set_release(&rmap_head->val, new_val);
+}
+
+static unsigned long kvm_rmap_lock_readonly(struct kvm *kvm,
+					    struct kvm_rmap_head *rmap_head)
+{
+	lockdep_assert_held_read(&kvm->mmu_lock);
+	return kvm_rmap_get(rmap_head);
+}
+
+static void kvm_rmap_unlock_readonly(struct kvm_rmap_head *rmap_head,
+				     unsigned long old_val) { }
+#endif
 
 /*
  * Returns the number of pointers in the rmap chain, not counting the new one.
@@ -1745,11 +1776,15 @@ static bool kvm_rmap_age_gfn_range(struct kvm *kvm,
 	gfn_t gfn;
 	int level;
 
+#ifdef CONFIG_PREEMPT_RT
+	guard(read_lock)(&kvm->mmu_lock);
+#endif
+
 	for (level = PG_LEVEL_4K; level <= KVM_MAX_HUGEPAGE_LEVEL; level++) {
 		for (gfn = range->start; gfn < range->end;
 		     gfn += KVM_PAGES_PER_HPAGE(level)) {
 			rmap_head = gfn_to_rmap(gfn, level, range->slot);
-			rmap_val = kvm_rmap_lock_readonly(rmap_head);
+			rmap_val = kvm_rmap_lock_readonly(kvm, rmap_head);
 
 			for_each_rmap_spte_lockless(rmap_val, &iter, sptep, old_spte) {
 				if (!is_accessed_spte(old_spte))
