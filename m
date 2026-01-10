Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E938E283FDD
	for <linux-rt-devel@lists.linux.dev>; Sat, 10 Jan 2026 21:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768081688; cv=none; b=qq3ZjGSzh/DWfp+9caB/VeQ9uxc5O0Qdpd2y/0D3al0BVEl/DHWLyCLgV/i8kfgm+k+cCaVjox/In5D1YZRlbW+g4YhDZL4kVBejtcYPgf5eKD8jNy+VyMcaG3aeVvmhvrm0iYwqO8dzLvae+tIYQAYvz1m8LEQd7g9IZEWJYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768081688; c=relaxed/simple;
	bh=QPHUoEpXPQPguZms/TBtw2hIhj0+tGVcWsN2AvszUDk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ONbnoLhcdL+LIEQj3gD8OIfraSLziwtTSha7IWnzts7IS8YWwAxJPemrw3jgV9iUJkn9cyOnu9knZFo+lU/gvRa9OiHiKyWkgMr1KL6PHg6rIQ8Dpyp/qMHx3CBzPvZDMhEAxNRm9tg0Vma8QmhxsGxdQBTcuMOnXnSzOgSYTfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNwCCTIS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNwCCTIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768081685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=046XaQZFAu8wvEAuybB5UMKwHOUklXTERb1ZGpwxEns=;
	b=RNwCCTISjPJQ34+MkVY6KCrtSLAZSUQ4QasGYV9kM7O3nadCnDKrOj+i1fS3piA73H7cIl
	feAHYK/sIIYzTJ21GQP6uivTa5/ayxKSbvS1/8W0gc0VSLro2dGBOt1iI524mGTfnNyH9d
	74Iu9OAqlHtmCksQc42M+2tSNQW0XOc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-YRLeEMZ8PhmN-cePQ5MW0Q-1; Sat, 10 Jan 2026 16:48:04 -0500
X-MC-Unique: YRLeEMZ8PhmN-cePQ5MW0Q-1
X-Mimecast-MFC-AGG-ID: YRLeEMZ8PhmN-cePQ5MW0Q_1768081684
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88883a2cabbso203277196d6.0
        for <linux-rt-devel@lists.linux.dev>; Sat, 10 Jan 2026 13:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768081681; x=1768686481;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=046XaQZFAu8wvEAuybB5UMKwHOUklXTERb1ZGpwxEns=;
        b=Meo/NiijbVMVTkz3NDpi6sRG/KY3vNR2BgTNede4iyRlGYglegYGu/cs3xeEMIlyOB
         ByXASFopOUbEODpLo9z4QHM7htqS2VHWpuxDOUDJZjy2FBtbrGLoGcZn2LWCQXizaX4b
         6tioZB1KW2FhPw66tCs9ECtD4/D9mg6vcplXqoncnlNXwPx2uVEaqB0HPXR/vP/MeFyV
         LawdIGwI2AS5yys8TXo/OIPEHPZRD5A+DCpb8gF2zNHee9rVJj7RiHHS0YvUv2CKoUKb
         M3MKBM8rUcpW/T+Dc5xw3gR2A95Gggw9uJcCtIO/RGlGwN0DGxRBryjiM105WV3sg4rE
         g0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdOX0LIQ//TBhDFY0oeqDVh9deKgOiz8qic2rny2M7jJ6I4GVeELsKLzmvv2AWk4mM0P8YTdXjH9rTttbdjw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxd+bAo3TDR+FvMJ6tf2NaQxmFCL3D9hBoIcdNSJGQV+xXZQ6Jb
	9DnE43nxqiZ5eMtzu5SS1t4YDWQmojPstM9WaMJpoFPyTmZHch2d4L73wdLt6Tvfe5UGj/wBfXG
	BHc17u5PwSDC0AGFZpy5YIg1EWGxgpgwysmSPon3p5OW44OMx2npJ4clkk+Vq8FpLdNPA
X-Gm-Gg: AY/fxX6TjAu9uJng0ZwbqKGdNpyplZEwBGziviZbxFHvmoQ0OSgZXHN9r+AESoY6Wib
	htnw1TmLDBUjTISLuAOJUKPunkrHa6OTPA2lXD8KNthY5GxdUQrSv3WlS23rcUG00bzwZ5S+ENV
	d7y5EXLvaOL+KSIRyHXlRthpcGUhxWobydCGO8n9WGcbXTTVTgVyhI77TAlylyvGcM38wbgAPD7
	7dkB7/1sheZqpKipZ1f6/Gip7bdsVXMkwRWJE5tVdZ9t21Orh254nNGWKaGpx59EUphqJMu23tT
	W14DlIwgvrelfs8JOAwq2CKbgYB7+Pw6UX9ADyKXdlAxOwP/AOqLPHx4J4eHZpapuxDZm7HLGIj
	2LGzEUP29Q5eCvXTK1Ts8TcBcRiCXtskcjWd+dwPzNNXv/XvLIsBKHGag
X-Received: by 2002:ad4:4bca:0:b0:890:811c:16d9 with SMTP id 6a1803df08f44-8908424f388mr141000606d6.35.1768081680478;
        Sat, 10 Jan 2026 13:48:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqa/3EIlrrQmROvvSM1H5fKER/EbV32WZRI2pHHklaF5oYvOg0tNb2w/JZbDah9Xf2BIYWDw==
X-Received: by 2002:ad4:4bca:0:b0:890:811c:16d9 with SMTP id 6a1803df08f44-8908424f388mr141000496d6.35.1768081680082;
        Sat, 10 Jan 2026 13:48:00 -0800 (PST)
Received: from ?IPV6:2601:188:c102:b180:1f8b:71d0:77b1:1f6e? ([2601:188:c102:b180:1f8b:71d0:77b1:1f6e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770d17a3sm104961296d6.9.2026.01.10.13.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jan 2026 13:47:59 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <9c0791ea-edb7-44b3-b8ec-ae0452400497@redhat.com>
Date: Sat, 10 Jan 2026 16:47:58 -0500
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't acquire rt_spin_lock in
 allocate_vpe_l1_table()
To: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20260107215353.75612-1-longman@redhat.com>
 <864iowmrx6.wl-maz@kernel.org>
In-Reply-To: <864iowmrx6.wl-maz@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HhWbDIgHyy9jIN0bJ0jVEw0EIR5jkqQErQzk_pBz42Q_1768081684
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/8/26 3:26 AM, Marc Zyngier wrote:
> On Wed, 07 Jan 2026 21:53:53 +0000,
> Waiman Long <longman@redhat.com> wrote:
>> When running a PREEMPT_RT debug kernel on a 2-socket Grace arm64 system,
>> the following bug report was produced at bootup time.
>>
>>    BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
>>    in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/72
>>    preempt_count: 1, expected: 0
>>    RCU nest depth: 1, expected: 1
>>     :
>>    CPU: 72 UID: 0 PID: 0 Comm: swapper/72 Tainted: G        W           6.19.0-rc4-test+ #4 PREEMPT_{RT,(full)}
>>    Tainted: [W]=WARN
>>    Call trace:
>>      :
>>     rt_spin_lock+0xe4/0x408
>>     rmqueue_bulk+0x48/0x1de8
>>     __rmqueue_pcplist+0x410/0x650
>>     rmqueue.constprop.0+0x6a8/0x2b50
>>     get_page_from_freelist+0x3c0/0xe68
>>     __alloc_frozen_pages_noprof+0x1dc/0x348
>>     alloc_pages_mpol+0xe4/0x2f8
>>     alloc_frozen_pages_noprof+0x124/0x190
>>     allocate_slab+0x2f0/0x438
>>     new_slab+0x4c/0x80
>>     ___slab_alloc+0x410/0x798
>>     __slab_alloc.constprop.0+0x88/0x1e0
>>     __kmalloc_cache_noprof+0x2dc/0x4b0
>>     allocate_vpe_l1_table+0x114/0x788
>>     its_cpu_init_lpis+0x344/0x790
>>     its_cpu_init+0x60/0x220
>>     gic_starting_cpu+0x64/0xe8
>>     cpuhp_invoke_callback+0x438/0x6d8
>>     __cpuhp_invoke_callback_range+0xd8/0x1f8
>>     notify_cpu_starting+0x11c/0x178
>>     secondary_start_kernel+0xc8/0x188
>>     __secondary_switched+0xc0/0xc8
>>
>> This is due to the fact that allocate_vpe_l1_table() will call
>> kzalloc() to allocate a cpumask_t when the first CPU of the
>> second node of the 72-cpu Grace system is being called from the
>> CPUHP_AP_MIPS_GIC_TIMER_STARTING state inside the starting section of
> Surely *not* that particular state.

My mistake, it should be CPUHP_AP_IRQ_GIC_STARTING. There are three 
static gic_starting_cpu() functions that confuse me.


>> the CPU hotplug bringup pipeline where interrupt is disabled. This is an
>> atomic context where sleeping is not allowed and acquiring a sleeping
>> rt_spin_lock within kzalloc() may lead to system hang in case there is
>> a lock contention.
>>
>> To work around this issue, a static buffer is used for cpumask
>> allocation when running a PREEMPT_RT kernel via the newly introduced
>> vpe_alloc_cpumask() helper. The static buffer is currently set to be
>> 4 kbytes in size. As only one cpumask is needed per node, the current
>> size should be big enough as long as (cpumask_size() * nr_node_ids)
>> is not bigger than 4k.
> What role does the node play here? The GIC topology has nothing to do
> with NUMA. It may be true on your particular toy, but that's
> definitely not true architecturally. You could, at worse, end-up with
> one such cpumask per *CPU*. That'd be a braindead system, but this
> code is written to support the architecture, not any particular
> implementation.
>
It is just what I have observed on the hardware that I used for 
reproducing the problem. I agree that it may be different in other arm64 
CPUs.
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>   drivers/irqchip/irq-gic-v3-its.c | 26 +++++++++++++++++++++++++-
>>   1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index ada585bfa451..9185785524dc 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2896,6 +2896,30 @@ static bool allocate_vpe_l2_table(int cpu, u32 id)
>>   	return true;
>>   }
>>   
>> +static void *vpe_alloc_cpumask(void)
>> +{
>> +	/*
>> +	 * With PREEMPT_RT kernel, we can't call any k*alloc() APIs as they
>> +	 * may acquire a sleeping rt_spin_lock in an atomic context. So use
>> +	 * a pre-allocated buffer instead.
>> +	 */
>> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>> +		static unsigned long mask_buf[512];
>> +		static atomic_t	alloc_idx;
>> +		int idx, mask_size = cpumask_size();
>> +		int nr_cpumasks = sizeof(mask_buf)/mask_size;
>> +
>> +		/*
>> +		 * Fetch an allocation index and if it points to a buffer within
>> +		 * mask_buf[], return that. Fall back to kzalloc() otherwise.
>> +		 */
>> +		idx = atomic_fetch_inc(&alloc_idx);
>> +		if (idx < nr_cpumasks)
>> +			return &mask_buf[idx * mask_size/sizeof(long)];
>> +	}
> Err, no. That's horrible. I can see three ways to address this in a
> more appealing way:
>
> - you give RT a generic allocator that works for (small) atomic
>    allocations. I appreciate that's not easy, and even probably
>    contrary to the RT goals. But I'm also pretty sure that the GIC code
>    is not the only pile of crap being caught doing that.
>
> - you pre-compute upfront how many cpumasks you are going to require,
>    based on the actual GIC topology. You do that on CPU0, outside of
>    the hotplug constraints, and allocate what you need. This is
>    difficult as you need to ensure the RD<->CPU matching without the
>    CPUs having booted, which means wading through the DT/ACPI gunk to
>    try and guess what you have.
>
> - you delay the allocation of L1 tables to a context where you can
>    perform allocations, and before we have a chance of running a guest
>    on this CPU. That's probably the simplest option (though dealing
>    with late onlining while guests are already running could be
>    interesting...).
>
> But I'm always going to say no to something that is a poor hack and
> ultimately falling back to the same broken behaviour.

Thanks for the suggestion. I will try  the first alternative of a more 
generic memory allocator.

Cheers,
Longman

>
> Thanks,
>
> 	M.
>

