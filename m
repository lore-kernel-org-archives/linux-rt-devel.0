Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728341324C
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Mar 2026 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820889; cv=none; b=B6qXIZSDsRDepLzOvjV4H1K9SJkI0Gk0idJImgjUR6azFEUKR1JJnDFYLeFU6pUmUCz8lLfFihL0RS6h5KoogNqe+MctM8oy7tq0ZC+0m9o3MWXGLoUcequa8fAXqDt/lQVjQhmtp6jMMp+QD6klhkKOrMB2PA316Av4upL8SzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820889; c=relaxed/simple;
	bh=bX/QxuS9OoDi1uRMFJB4oQmkvSNVP2tvqOucb4SUIz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kxwl7G3jJVR0l+ygmttQ1x7qt4pe5sDB/ErS8cKbEGnViyC4tw7FWdkzWXSmFzIYdWkz5515a8XQwMzCjvkdsj72w+/WiBkf6DFhSQH2CXUzB1qtmPFCHuQ2jGtKc953vsFHomkLSa/EiIcMp6XBgDu2q+A7AxlkqMnTPbsFRwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NZtvmC5N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NZtvmC5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772820887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jwfI0UzgDdM6KwDTpaPVK51Dh9pqjddR4e0hn1DOm0=;
	b=NZtvmC5NnzZM9pQWVx6mnr/m7Ayp3WwHEXzyaJqurIEOVLRBiFb14qFcSEsJtJdec/AMA/
	cfb6kShwzf5cCli2WsNByStrOUKDYx0q910GbUAacH5JWJ/nRoVm7TbGMtqFyJ9nO3bMrO
	MMBIwt2mzU/HY/9XXDg3KCMOyBK3iCQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-NxaaHpvfMqqGyWtHy2l8kw-1; Fri, 06 Mar 2026 13:14:45 -0500
X-MC-Unique: NxaaHpvfMqqGyWtHy2l8kw-1
X-Mimecast-MFC-AGG-ID: NxaaHpvfMqqGyWtHy2l8kw_1772820885
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4837246211bso124546915e9.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Mar 2026 10:14:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772820884; x=1773425684;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+jwfI0UzgDdM6KwDTpaPVK51Dh9pqjddR4e0hn1DOm0=;
        b=CRb6dLbgJ3Vc7Bfcbku6mnthh8urd17xqXZoOFSeL+x7BHe7BuYrq4uYuNvZiohLNa
         2tZMfg3fLEhu7P5DXDLx2YiDBBPqb1e075NRych6uXTn0u25jtleZc34Vh7kVxxxoT/+
         PVFikfYCflGJdHvhMsVS2MJ+cokHMUTV/sgiOEn4SwGOg7PAR7ChYsr+2ip58QbagRgn
         xuBMO4+xfgTBPN5xGtaTELAgiQCheQ0sXhNtpV24fMBJOHIKzDRKfetkMtZcBy3XnlKk
         ykFceJRO9yh7yDx+ENAQguLSG673Ms9lIUAcpT+LHEwcLpXImY5trmHy5wSC/0NurT5t
         ZWMw==
X-Forwarded-Encrypted: i=1; AJvYcCUlSaiscyaGHU31NzqUZciJNLJXpxbfFQdQdO2qd0sMYvYMPO0kFOdGrcJPWL6njCdjNR0+s5XI5cJrFJqKog==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxxl+RoK5zZhgtpTlfW3sU1ubAClk+n4puR99Z1QxkvUGXfPT94
	JxMa6Kx3POGGGgCaNuQH+SMt6wPzrQ9RBXA8srIRW3+m/zgePiOTzFNVJqZIKIDf5nlg6tP+Fwl
	v8DZ5rWTbtrP+u7rtbG8Kd7YzcXjX8fzqCwFeGJeNpgWtCKcuY2a8B+ZEp8JDxCyeDCng5X0+bW
	34
X-Gm-Gg: ATEYQzyU0/HWnuwt8vpSgR6ZuCwjE2JSLqoK1cAF5/Js6httN4fEL+LhpGntzSsjXag
	dypACBSawB3mGfCVIEgMp9J20gDjDcprSMSEBmdL8dxexaR+Fvcz9xv5iC7nf38D5kbeyEgJnZo
	xKPhgyvaD8hL4tsA2UsOUbwntVEjXXL/dbPKp5ykBVIZRhhdbHzzk9bil3eFghacAF1HjowWoB6
	cLmLPEaf+27r9Fbe+5kWO3y9unNAL1luTOreLDWIB+lkyy0kzlkmErL1uT3UGBKyhTdVaXL4nQX
	HEzstj1I7AglZbXviQL3EtrlNZ2eSV0BgBA41OUOcavl+8u2sx3puvAAxnaT6UFQdVIQsjowPjY
	nOKW+n/IRJ1qTGCkZ8yoAs3BHyP1+bfCq6xiA8cv2Dj3y4pwTmrLlxqgha1E6Jj1S+nHDLXHgDQ
	hq/TaggzCmPEOQTTKpY5RlICQiqPI=
X-Received: by 2002:a05:600d:8489:20b0:485:2af3:3f7d with SMTP id 5b1f17b1804b1-4852af34088mr14851375e9.4.1772820883630;
        Fri, 06 Mar 2026 10:14:43 -0800 (PST)
X-Received: by 2002:a05:600d:8489:20b0:485:2af3:3f7d with SMTP id 5b1f17b1804b1-4852af34088mr14850845e9.4.1772820883141;
        Fri, 06 Mar 2026 10:14:43 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4851fad2812sm218866435e9.1.2026.03.06.10.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 10:14:42 -0800 (PST)
Message-ID: <ae2143b3-ce28-4c87-afcf-1505694246d8@redhat.com>
Date: Fri, 6 Mar 2026 19:14:40 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: mmu_notifier: make mn_invalidate_lock non-sleeping
 for non-blocking invalidations
To: shaikh kamaluddin <shaikhkamal2012@gmail.com>,
 Sean Christopherson <seanjc@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260209161527.31978-1-shaikhkamal2012@gmail.com>
 <20260211120944.-eZhmdo7@linutronix.de> <aYyhfvC_2s000P7H@google.com>
 <aactOOfirdVRYfNS@acer-nitro-anv15-41>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <aactOOfirdVRYfNS@acer-nitro-anv15-41>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wbnjZue5oQ4CDECpwGQY6YikPNwsP_hdwaM74W235NM_1772820885
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/26 19:49, shaikh kamaluddin wrote:
> On Wed, Feb 11, 2026 at 07:34:22AM -0800, Sean Christopherson wrote:
>> On Wed, Feb 11, 2026, Sebastian Andrzej Siewior wrote:
>>> On 2026-02-09 21:45:27 [+0530], shaikh.kamal wrote:
>>>> mmu_notifier_invalidate_range_start() may be invoked via
>>>> mmu_notifier_invalidate_range_start_nonblock(), e.g. from oom_reaper(),
>>>> where sleeping is explicitly forbidden.
>>>>
>>>> KVM's mmu_notifier invalidate_range_start currently takes
>>>> mn_invalidate_lock using spin_lock(). On PREEMPT_RT, spin_lock() maps
>>>> to rt_mutex and may sleep, triggering:
>>>>
>>>>    BUG: sleeping function called from invalid context
>>>>
>>>> This violates the MMU notifier contract regardless of PREEMPT_RT;
>>
>> I highly doubt that.  kvm.mmu_lock is also a spinlock, and KVM has been taking
>> that in invalidate_range_start() since
>>
>>    e930bffe95e1 ("KVM: Synchronize guest physical memory map to host virtual memory map")
>>
>> which was a full decade before mmu_notifiers even added the blockable concept in
>>
>>    93065ac753e4 ("mm, oom: distinguish blockable mode for mmu notifiers")
>>
>> and even predate the current concept of a "raw" spinlock introduced by
>>
>>    c2f21ce2e312 ("locking: Implement new raw_spinlock")
>>
>>>> RT kernels merely make the issue deterministic.
>>
>> No, RT kernels change the rules, because suddenly a non-sleeping locking becomes
>> sleepable.
>>
>>>> Fix by converting mn_invalidate_lock to a raw spinlock so that
>>>> invalidate_range_start() remains non-sleeping while preserving the
>>>> existing serialization between invalidate_range_start() and
>>>> invalidate_range_end().
>>
>> This is insufficient.  To actually "fix" this in KVM mmu_lock would need to be
>> turned into a raw lock on all KVM architectures.  I suspect the only reason there
>> haven't been bug reports is because no one trips an OOM kill on VM while running
>> with CONFIG_DEBUG_ATOMIC_SLEEP=y.
>>
>> That combination is required because since commit
>>
>>    8931a454aea0 ("KVM: Take mmu_lock when handling MMU notifier iff the hva hits a memslot")
>>
>> KVM only acquires mmu_lock if the to-be-invalidated range overlaps a memslot,
>> i.e. affects memory that may be mapped into the guest.
>>
>> E.g. this hack to simulate a non-blockable invalidation
>>
>> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index 7015edce5bd8..7a35a83420ec 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -739,7 +739,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>>                  .handler        = kvm_mmu_unmap_gfn_range,
>>                  .on_lock        = kvm_mmu_invalidate_begin,
>>                  .flush_on_ret   = true,
>> -               .may_block      = mmu_notifier_range_blockable(range),
>> +               .may_block      = false,//mmu_notifier_range_blockable(range),
>>          };
>>   
>>          trace_kvm_unmap_hva_range(range->start, range->end);
>> @@ -768,6 +768,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>>           */
>>          gfn_to_pfn_cache_invalidate_start(kvm, range->start, range->end);
>>   
>> +       non_block_start();
>>          /*
>>           * If one or more memslots were found and thus zapped, notify arch code
>>           * that guest memory has been reclaimed.  This needs to be done *after*
>> @@ -775,6 +776,7 @@ static int kvm_mmu_notifier_invalidate_range_start(struct mmu_notifier *mn,
>>           */
>>          if (kvm_handle_hva_range(kvm, &hva_range).found_memslot)
>>                  kvm_arch_guest_memory_reclaimed(kvm);
>> +       non_block_end();
>>   
>>          return 0;
>>   }
>>
>> immediately triggers
>>
>>    BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:241
>>    in_atomic(): 0, irqs_disabled(): 0, non_block: 1, pid: 4992, name: qemu
>>    preempt_count: 0, expected: 0
>>    RCU nest depth: 0, expected: 0
>>    CPU: 6 UID: 1000 PID: 4992 Comm: qemu Not tainted 6.19.0-rc6-4d0917ffc392-x86_enter_mmio_stack_uaf_no_null-rt #1 PREEMPT_RT
>>    Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
>>    Call Trace:
>>     <TASK>
>>     dump_stack_lvl+0x51/0x60
>>     __might_resched+0x10e/0x160
>>     rt_write_lock+0x49/0x310
>>     kvm_mmu_notifier_invalidate_range_start+0x10b/0x390 [kvm]
>>     __mmu_notifier_invalidate_range_start+0x9b/0x230
>>     do_wp_page+0xce1/0xf30
>>     __handle_mm_fault+0x380/0x3a0
>>     handle_mm_fault+0xde/0x290
>>     __get_user_pages+0x20d/0xbe0
>>     get_user_pages_unlocked+0xf6/0x340
>>     hva_to_pfn+0x295/0x420 [kvm]
>>     __kvm_faultin_pfn+0x5d/0x90 [kvm]
>>     kvm_mmu_faultin_pfn+0x31b/0x6e0 [kvm]
>>     kvm_tdp_page_fault+0xb6/0x160 [kvm]
>>     kvm_mmu_do_page_fault+0xee/0x1f0 [kvm]
>>     kvm_mmu_page_fault+0x8d/0x600 [kvm]
>>     vmx_handle_exit+0x18c/0x5a0 [kvm_intel]
>>     kvm_arch_vcpu_ioctl_run+0xc70/0x1c90 [kvm]
>>     kvm_vcpu_ioctl+0x2d7/0x9a0 [kvm]
>>     __x64_sys_ioctl+0x8a/0xd0
>>     do_syscall_64+0x5e/0x11b0
>>     entry_SYSCALL_64_after_hwframe+0x4b/0x53
>>     </TASK>
>>    kvm: emulating exchange as write
>>
>>
>> It's not at all clear to me that switching mmu_lock to a raw lock would be a net
>> positive for PREEMPT_RT.  OOM-killing a KVM guest in a PREEMPT_RT seems like a
>> comically rare scenario.  Whereas contending mmu_lock in normal operation is
>> relatively common (assuming there are even use cases for running VMs with a
>> PREEMPT_RT host kernel).
>>
>> In fact, the only reason the splat happens is because mmu_notifiers somewhat
>> artificially forces an atomic context via non_block_start() since commit
>>
>>    ba170f76b69d ("mm, notifier: Catch sleeping/blocking for !blockable")
>>
>> Given the massive amount of churn in KVM that would be required to fully eliminate
>> the splat, and that it's not at all obvious that it would be a good change overall,
>> at least for now:
>>
>> NAK
>>
>> I'm not fundamentally opposed to such a change, but there needs to be a _lot_
>> more analysis and justification beyond "fix CONFIG_DEBUG_ATOMIC_SLEEP=y".
>>
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
> if so, I can protoptype a patch along those lines and share for
> feedback.
> 
> Alternatively, if you think this needs to be addressed in
> mmu_notifiers(eg. how non_block_start() is applied), I'm happy to
> redirect my efforts there-Please advise.

Have you considered a "OOM entered" callback for MMU notifiers?  KVM's 
MMU notifier can just remove itself for example, in fact there is code 
in kvm_destroy_vm() to do that even if invalidations are unbalanced.

Paolo

