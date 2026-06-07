Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F6C313E1D
	for <linux-rt-devel@lists.linux.dev>; Sun,  7 Jun 2026 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780855110; cv=none; b=b7MGsICLQMXNFNT0WZc0+1ugcQdSHYqCcSEbOkUCU4pDByKtLbhpaK+DPgTkxOaS9StkgWE8EpvqVBywwDdbaSS8biEtzBTfdmK7al8i7TqvF2YWcouV1CugmhvyRh2wGhCgd+edFW/V3hqzTcoyyRbvL3XEoSg7gaiYGdEZFwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780855110; c=relaxed/simple;
	bh=bY33RCJQEadB1FaV1As+lI256ULbTWOJA7RfVxN/ihQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjMHdJSQaSx+JqZHuPY8PuI1hCtgBTgQukh0M8v/Fb0Fm6LelR+UPXEPufvPsgW31eCTS2PYd/HstIb3JFxn3XgzBbZ0eaKbHAaZDJIzmJLqyK6BsvzT+5bpu6rV5PYbrbPPPnplJuTt0LD/FX942PWD4+XPz6YW0nC6uQiSFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d7LpOA1g; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7LpOA1g"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf30d530bdso36485355ad.3
        for <linux-rt-devel@lists.linux.dev>; Sun, 07 Jun 2026 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780855109; x=1781459909; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c2RDc7vwCs214SZmSr6J53htm9NHLBxoNBLD3OPbxYs=;
        b=d7LpOA1gvqaNJ1FM/4ErHVpNKWlkFfqfXDL63X6ZfBmsqxvhXKPYMr37q+O1Ssl3cN
         IXCvBj1mOEGTJAv1RZV0nOJ725EYVUKDzK+aULyzET7/aWGMLksE2TqgH7YPsROahT4S
         WHNVsr2ZNVGN1EzsHAwa+J9mr5wAn9DdbldB4Qcm6B/Re/8wBByuMFd5SZz+OH7/ynZR
         GGGMPjG8Pd8C0NDYmHxyxqiVpRv4I5RGlaGRjGwUfOLu/7ToT1BYirrfPWE91ogOeRSg
         4+R4lUzAPcnPdCrsZMpJBeD3S5UFXmQvslbzSA+1Gb7N7IuBThVz96Lyo7F+FEIMpSLU
         LiMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780855109; x=1781459909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c2RDc7vwCs214SZmSr6J53htm9NHLBxoNBLD3OPbxYs=;
        b=QP+SF6SnEpnff8vFAn9t8kG2ODr37MilVvbSIjVvn1nN7wDT6gVWhAEjmXlTYBHdT9
         mZjYRod9XZjIUb+osZGh8BFvKoIYM10EUAi2AU2u86aKthOUmTai6TgWDRW+S2FkOnB6
         jNp2ZHdL3RWnEvlTcZ1DvIFCJ5lDXP2avMKw0yaFR56YmboNmXPqZco3QUWT1IN8aRuK
         YDU7Jn0c//vEGiXghMCtJS/eZ2AQoaYUaf6VYU7s3SHDivLr87q6KE3kGIS2+DRVrILm
         UWhNBq4bBJ83wcpBG3fd4qf+4hYvOCsQHJc+zJ4ToIfapSpbx/APHIP7Ub5QsVap/8R2
         B8sw==
X-Forwarded-Encrypted: i=1; AFNElJ866TAxKeY9CynDiJ41AtdF0WnaLU9cxffu9KFXMwkVK/ZTay7TTd+RGVGY26vmRlAK6p2m9r5wEt2EwmGX6A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZkoSv+7o+wOLHonwKyUtqRFEfDgDQD9A+uuaPc2AZ5Hg5uaoz
	PEFOzcj7QkauL7y6OX3RWYjiINO5SufosOloPMIahqQ+AtmzdP31CE/c
X-Gm-Gg: Acq92OHwiPx5CrIuPqRWOZHr/kC7HVNj0b0aKnn70mdGyuKo6q85NGI8Gio7ONXrpl4
	DY6U+6y9FeE25rbENcBEmYTkPPSXLf4i/X6VDj7rBe+7mSxAhD4A13Lj1u2ilf7EBnFnanEwkaQ
	qDqX++q1slvDByxZXjgObcwvjFncqJ74qU0BCAJ7oSCZ+Myx6BPUp0Fbg/RU4Nyt3t2EE49oYwK
	DmG7wEMMe8ZwxQfI38fDjhDX0yrVHc+cYGWlnzIK39Sqb6HIaRei9S2iXxj5a1SGzYm0QN2mTpY
	Rpd4Nm36ISJWyBlABZEcJr2+O7CvkN+swerdEZeFOVewoGWvfrT2KtbX3S3x4QMmkEgYudcyoV8
	lt3BdPBjMHtdQp9C06/wThGBO2GjcXVGgNDWQ839p4RtiyfODyqJRSoY8SRqYCj0Agoyy+511IT
	mK2DLrsHR2Z+SberHWnM/1iP99CNkRL1GvTd0Zyj0=
X-Received: by 2002:a17:903:8ce:b0:2c0:b4f5:41ea with SMTP id d9443c01a7336-2c1e7e93bf0mr125718445ad.17.1780855108460;
        Sun, 07 Jun 2026 10:58:28 -0700 (PDT)
Received: from localhost ([116.72.144.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16629cf89sm156972585ad.56.2026.06.07.10.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 10:58:28 -0700 (PDT)
Date: Sun, 7 Jun 2026 23:28:25 +0530
From: shaikh kamaluddin <shaikhkamal2012@gmail.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	pbonzini@redhat.com, skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 0/1] mm/mmu_notifier: Add async OOM cleanup via
 call_srcu()
Message-ID: <aiWxQSlfcAZCZrnw@acer-nitro-anv15-41>
References: <CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com>
 <20260430141639.10815-1-shaikhkamal2012@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260430141639.10815-1-shaikhkamal2012@gmail.com>

On Thu, Apr 30, 2026 at 07:46:39PM +0530, shaikh.kamal wrote:
> This series implements the after_oom_unregister callback design
> proposed by Paolo in v1 review [1].
> 
> The current OOM notifier path calls synchronize_srcu() inline from
> mmu_notifier_oom_enter(), which can deadlock on PREEMPT_RT when
> locks such as siglock are held. This series moves the cleanup to an
> asynchronous context using call_srcu(), allowing the OOM path to
> proceed without waiting for an SRCU grace period.
> 
> Subscribers opt in via a new after_oom_unregister callback in
> struct mmu_notifier_ops.
> 
> KVM is the first (and currently only) user.
> 
> Changes since v1 [1]:
> - Implement after_oom_unregister callback in struct
>   mmu_notifier_ops as proposed by Paolo
> - Add mmu_notifier_oom_enter() to detach subscriptions and
>   schedule cleanup via call_srcu()
> - Add mmu_notifier_barrier() (srcu_barrier wrapper) so consumers
>   can wait for pending callbacks during teardown
> - Move call site from __oom_kill_process() to __oom_reap_task_mm()
>   to fix KASAN vmalloc-out-of-bounds observed in v1
> - Use hlist_del_init() to keep hlist_unhashed() correct for the
>   kvm_destroy_vm() detection path, avoiding use-after-free on the
>   stack-allocated oom_list head
> - Add KVM after_oom_unregister implementation to clear
>   mn_active_invalidate_count
> - Update kvm_destroy_vm() to detect detached subscriptions via
>   hlist_unhashed() and use mmu_notifier_barrier() + mmdrop()
>   instead of mmu_notifier_unregister()
> - Remove pr_err() on GFP_ATOMIC failure per checkpatch; the
>   trade-off is documented inline
> 
> Testing
> -------
> 
> Developed and tested under virtme-ng with PREEMPT_RT, KASAN, and
> lockdep enabled.
> 
> Test setup:
> - simple_kvm.c: minimal userspace program that opens /dev/kvm,
>   creates a VM, registers memory, creates a vCPU, and sleeps
> - CONFIG_DEBUG_VM-only debugfs interface (not part of this
>   submission) at /sys/kernel/debug/oom_reap_task to invoke
>   __oom_reap_task_mm() on a target task
> 
> Test sequence:
>   $ ./simple_kvm &
>   $ echo $! | sudo tee /sys/kernel/debug/oom_reap_task
> 
> Observed with patch applied:
> - __oom_reap_task_mm() completes
> - mmu_notifier_oom_enter() detaches the KVM subscription
> - call_srcu() callback runs after (SRCU grace period)
> - KVM after_oom_unregister clears mn_active_invalidate_count
> - mmu_notifier_barrier() returns cleanly
> - No KASAN reports, no kernel BUGs, lockdep clean
> 
> Stress runs (20 iterations) showed consistent results.
> 
> Reproducing the syzbot-reported issue
> -------------------------------------
> The issue reported by syzbot is reproducible on an unpatched
> PREEMPT_RT kernel, triggering a "sleeping function called from
> invalid context" warning in kvm_mmu_notifier_invalidate_range_start().
> With this patch applied, the warning is no longer observed..
> 
> 
> Known limitations
> -----------------
> 
> Failure of GFP_ATOMIC allocation in mmu_notifier_oom_enter()
> causes the corresponding after_oom_unregister callback to be
> skipped. The OOM path cannot sleep without reintroducing the
> deadlock this series fixes, and synchronous execution would
> require waiting for SRCU readers. Cleanup still occurs later via
> the normal unregister path. A mempool-backed allocator could
> address this in the future.
>
Hi Paolo, Lorenzo, Sean,

Gentle ping on v2, which implements the after_oom_unregister
approach Paolo suggested on v1:
  https://lore.kernel.org/all/20260430141701.10859-1-shaikhkamal2012@gmail.com/

The one outstanding issue was a build failure on !CONFIG_MMU_NOTIFIER
(arc/hexagon allnoconfig) from the kernel test robot, now fixed by
adding the missing mmu_notifier_oom_enter() stub:
  https://lore.kernel.org/all/20260607152830.8775-1-shaikhkamal2012@gmail.com/

So it builds clean and is ready for review whenever you have bandwidth.

Thanks,
Kamal
> [1] https://lore.kernel.org/all/CABgObfZQM0Eq1=vzm812D+CAcjOaE1f1QAUqGo5rTzXgLnR9cQ@mail.gmail.com
> 
> Reported-by: syzbot+c3178b6b512446632bac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c3178b6b512446632bac
> Tested-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> 
> shaikh.kamal (1):
>   mm/mmu_notifier: Add async OOM cleanup via call_srcu()
> 
>  include/linux/mmu_notifier.h |  10 +++
>  mm/mmu_notifier.c            | 123 +++++++++++++++++++++++++++++++++++
>  mm/oom_kill.c                |   3 +
>  virt/kvm/kvm_main.c          |  27 +++++++-
>  4 files changed, 162 insertions(+), 1 deletion(-)
> 
> --
> 2.43.0
> 
