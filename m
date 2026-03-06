Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194023AEF37
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Mar 2026 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815326; cv=none; b=NDXQF88TWfP2wuwLbNvoRAQVxxJhaiRQWJHMjVkwjawe4G4BIZrMh/ogrGxGflmNKymbt73zarhZ5jiFitec75rKim40m6Qj19uDh27MNT0fOHxWRVTAMFaWlsYy0ZpVCqKdkAa6NN+O0aFVGbFmEKbRQCVK3f8b5pi2JN4kgXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815326; c=relaxed/simple;
	bh=TADcOpWEvJLAOeAtgeTIyGynHje+264iN18XJs1JvqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sPcqHP0Udx5aDZwLxUtoFMosHIHeaZqAt7PHRVAPb48BDCPwQK3he/vpUSMcTBI43rGlj2COLdIF2ZsTDwI0X3BtwOe0FpmjjeNxSIDkQFmYRqvuTyYvNtrWcEPMvHkOEV8HwBpD3ojqe87CbeFdlE6rbgjldF4PDS3Qhbuej+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pOYhnDAI; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pOYhnDAI"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ae4b96c259so64121235ad.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Mar 2026 08:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772815322; x=1773420122; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rk41VVSwMD1I02bvg41LBcCUW/2xACIjrkOSKPXzHO4=;
        b=pOYhnDAInRPzqaIza1/PFSd7hzWHjkt0gK0fkd/jL8zIRAeVVnFpivmZY3IKFzf91a
         fdXpXivgJZxjteQJVYsri+afnPmH3KeeTlvt58T7jrSuJCMQtMmTLp37euytmQ4C2ZRz
         mNHgGFT6GWs8z1HXAdtmqBBPsuM1Jqf4NHmME8iT482bUmrC2Kx1gszlE93yAg2pKsoH
         57tCQDT2g4ecONu+yQpYyXSSgnfvauJYM8VpwbY3coMQpdL3wE3zgXqUF+g9W9r5+xlo
         IL1X90aV5o+Zad92j2cJpVkMSxEDcwspqEzoGu5lXankz05OvN4ftv0XLH/ljYFKzKYM
         pncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772815322; x=1773420122;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rk41VVSwMD1I02bvg41LBcCUW/2xACIjrkOSKPXzHO4=;
        b=fiRz+ip1VuhIa+94eaAJaxS+gkvUU/0xoD+NyPTYlECKQJgiqv+MhlqPmSnmwWTNHH
         eMJGOcL4RK2/vnN1sqd5Fat8xHc1892MFogNC+84LR2/0+8PhYTGaZVQd+PQ0WAYt4px
         38Yhmd1lSMTEx8E8s6Ks7o0Bf+Ztg0m0maIb66B0CLntLv04QUZu+CB2iGPJYPzZfD39
         u6AoZcBsmdOCfza6lEA5o14jWI0t87nMiaCwReP6fDNV15u5Ky1TNf1LiEKE7dS60wNn
         JQHMfsHVGrxUCq/NtR0EwCTCN9rBDzR2CN1KBYjGKJlseuJxHoVe6hb00b7N4K3Jpb6/
         1Tbw==
X-Forwarded-Encrypted: i=1; AJvYcCU2XpyKBLCS8l7HNb61/IoU2L4Zc1nXsEwVfZ8RQavFuU9GlQssVAhjyEqtCQon3aRAtXo2ietIos5X5VTJQw==@lists.linux.dev
X-Gm-Message-State: AOJu0YztBoAAGefoouw21D5PExUMvyctUru7MgPZU9NfIjnoJ0P+9wH8
	PT8TuGO6LviqDG6K8CxxIKZz8+9uD3Ujt3w17Y7nFcR9v846zTstEhPdA0/XDa+uLGf9zCgRaO/
	RYJ1O8w==
X-Received: from plch14.prod.google.com ([2002:a17:902:f2ce:b0:2ae:3b56:7c6a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b2d:b0:2ae:525a:f971
 with SMTP id d9443c01a7336-2ae82a0a890mr26503905ad.23.1772815321672; Fri, 06
 Mar 2026 08:42:01 -0800 (PST)
Date: Fri, 6 Mar 2026 08:42:00 -0800
In-Reply-To: <aactOOfirdVRYfNS@acer-nitro-anv15-41>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260209161527.31978-1-shaikhkamal2012@gmail.com>
 <20260211120944.-eZhmdo7@linutronix.de> <aYyhfvC_2s000P7H@google.com> <aactOOfirdVRYfNS@acer-nitro-anv15-41>
Message-ID: <aasD2OHkQN3kdRba@google.com>
Subject: Re: [PATCH] KVM: mmu_notifier: make mn_invalidate_lock non-sleeping
 for non-blocking invalidations
From: Sean Christopherson <seanjc@google.com>
To: shaikh kamaluddin <shaikhkamal2012@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Wed, Mar 04, 2026, shaikh kamaluddin wrote:
> On Wed, Feb 11, 2026 at 07:34:22AM -0800, Sean Christopherson wrote:
> > On Wed, Feb 11, 2026, Sebastian Andrzej Siewior wrote:
> > It's not at all clear to me that switching mmu_lock to a raw lock would be a net
> > positive for PREEMPT_RT.  OOM-killing a KVM guest in a PREEMPT_RT seems like a
> > comically rare scenario.  Whereas contending mmu_lock in normal operation is
> > relatively common (assuming there are even use cases for running VMs with a
> > PREEMPT_RT host kernel).
> > 
> > In fact, the only reason the splat happens is because mmu_notifiers somewhat
> > artificially forces an atomic context via non_block_start() since commit
> > 
> >   ba170f76b69d ("mm, notifier: Catch sleeping/blocking for !blockable")
> > 
> > Given the massive amount of churn in KVM that would be required to fully eliminate
> > the splat, and that it's not at all obvious that it would be a good change overall,
> > at least for now:
> > 
> > NAK
> > 
> > I'm not fundamentally opposed to such a change, but there needs to be a _lot_
> > more analysis and justification beyond "fix CONFIG_DEBUG_ATOMIC_SLEEP=y".
> >
> Hi Sean,
> Thanks for the detailed explanation and for spelling out the border
> issue.
> Understood on both points:
> 	1. The changelog wording was too strong; PREEMPT_RT changes
> 	spin_lock() semantics, and the splat is fundamentally due to
> 	spinlocks becoming sleepable there.
> 	2. Converting only mm_invalidate_lock to raw is insufficient
> 	since KVM can still take the mmu_lock (and other sleeping locks
> 	RT) in invalidate_range_start() when the invalidation hits a
> 	memslot.
> Given the above, it shounds like "convert locks to raw" is not the right
> direction without sinificat rework and justification.
> Would an acceptable direction be to handle the !blockable notifier case
> by deferring the heavyweight invalidation work(anything that take
> mmu_lock/may sleep on RT) to a context that may block(e.g. queued work),
> while keeping start()/end() accounting consisting with memslot changes ?

No, because the _only_ case where the invalidation is non-blockable is when the
kernel is OOM-killing.  Deferring the invalidations when we're OOM is likely to
make the problem *worse*.

That's the crux of my NAK.  We'd be making KVM and kernel behavior worse to "fix"
a largely hypothetical issue (OOM-killing a KVM guest in a RT kernel).
