Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7D33D507
	for <linux-rt-devel@lists.linux.dev>; Wed, 21 Jan 2026 10:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768990866; cv=none; b=irk4Q7YByToHnwWQLD8nDVdmDNfiLQ/5pC94e9xjbj/+tt2+FMuIn86LJgCMq8ni9CKNj0H5YOGAvbDGOr4z9VtoaXB5u2EH8I0xKeYemLS3Icbhflj8ZYooaASQRbDsuVTatUbbAsn1v//IvHwHK+COA5d/z4Q/PpSvDb6xkTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768990866; c=relaxed/simple;
	bh=aWM41FwLJltNg5ijgscZl1PGdVDJmvdRJ/Sg/wjgfvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HuwmBxjWA444wfaddkzqhBf53pA1ZO9SZALP06y4Z6zP6U7qMqrhpnhkjy9U+T+2A5KgGR8i6m4yjvojJ/gXFw5tJSMF1Lf+zXjoqfsJC6P6Ucp8DLmsLQSygLlFSbvyDDYVPz4VMV/O4B8bc0aSaeMzl8rngJJuT+t/pT6Ih7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17BC51476;
	Wed, 21 Jan 2026 02:20:51 -0800 (PST)
Received: from [10.1.25.175] (XHFQ2J9959.cambridge.arm.com [10.1.25.175])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B4003F740;
	Wed, 21 Jan 2026 02:20:54 -0800 (PST)
Message-ID: <ee2bf4ba-0121-44dc-a465-4c186dc18f19@arm.com>
Date: Wed, 21 Jan 2026 10:20:52 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] arm64: mmu: avoid allocating pages while splitting
 the linear mapping
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>, Yang Shi <yang@os.amperecomputing.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 catalin.marinas@arm.com, akpm@linux-oundation.org, david@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 chaitanyas.prakash@arm.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, lorenzo.stoakes@oracle.com, ardb@kernel.org,
 jackmanb@google.com, vbabka@suse.cz, mhocko@suse.com
References: <aW5p1ylQBNXTEmmq@willie-the-truck>
 <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>
 <aW-k_D1Q8jpYMPoI@willie-the-truck>
 <a6c1f21f-43e4-41d2-adb6-c5f9985b3abd@arm.com>
 <aW+t8S1LfwX3LjRi@e129823.arm.com>
 <11a01f4e-9ae5-4001-9f9c-74a746f898cd@arm.com>
 <02bb61cc-f0be-41e5-b8b2-59768afd5254@os.amperecomputing.com>
 <aXCPHaylUbRJ3CME@e129823.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aXCPHaylUbRJ3CME@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 21/01/2026 08:32, Yeoreum Yun wrote:
>>>> My concern is that if a secondary CPU can race and cause a split, that is
>>>> unsound because we have determined that although the primary CPU supports BBML2,
>>>> at least one of the secondary CPUs does not. So splitting a live mapping is unsafe.
>>>>
>>>> I just had a brief chat with Rutland, and he agrees that this _could_ be a
>>>> problem. Basically there is a window between onlining the secondary cpus and
>>>> entering the stop_machine() where one of those cpus _could_ end up doing
>>>> something that causes us to split the linear map.
>>
>> If I remember correctly, split_kernel_leaf_mapping() does call
>> system_supports_bbml2_noabort() before doing real split. So we basically
>> should fall into two categories:
>>
>> 1. bbml2_noabort is supported on all cpus. Everything is fine.
>> 2. bbml2_noabort is not supported on all cpus. split_kernel_leaf_mapping()
>> just returns 0. Kernel doesn't split page table, so there won't be TLB
>> conflict issue. But the following page prot update may see unexpected block
>> mapping, then a   WARN  will be raised and it will return -EINVAL. So the
>> worst case is the caller will fail (IIRC all the callers of set_memory_*()
>> handle the failure), and we can know who is trying to change linear mapping
>> before the linear mapping gets                    finalized. AFAICT I
>> haven't seen such WARN yet.

Ahh good point! So this isn't quite as terrible as I was thinking.

> 
> Thanks for the great detail :)
> I've missed system_supports_bbml2_noabort() in split_kernel_leaf_mapping().
> 
>>
>>>>
>>>> I'm not immediately sure how to solve that.
>>
>> Do we need some synchronization mechanism? If the linear mapping is not
>> finalized yet, split_kernel_leaf_mapping() will spin. For example, something
>> like this off the top of my head,
>>
>> DEFINE_STATIC_KEY_FALSE(linear_mapping_finalized);
>>
>> Once the linear mapping is finalized, we can call
>> static_branch_enable(&linear_mapping_finalized);
>>
>> In split_kernel_leaf_mapping(), we can just do:
>>
>> retry:
>>     if (!static_branch_likely(&linear_mapping_finalized))
>>         goto retry;
>>

Yuck... But I guess it might work as long as the primary thread never does
anything that would cause an attempt to split; otherwise we have a deadlock.

>>
>> There may be better way to handle it. But this case should be very unlikely
>> IMHO. It sounds crazy to have such complicated kernel threads run so early.
>> I'm not sure whether we should pay immediate attention to it or not.

I think we need to figure out if this is actually possible. We bring up the
secondary cpus, set system caps and finalize the linear map in smp_init().
That's called from kernel_init_freeable() which is called from kernel_init(),
which is invoked as a thread pinned to the boot cpu.

sched_init_smp() is called after smp_init() (i.e. after the linear map is
finalized). I'm guessing (based on the name of sched_init_smp()) that nothing
other than the idle thread will run on any secondaries until after
sched_init_smp() is called? (I'd be greatful if anyone can confirm that).

Rutland suggested that it's probably too early for any PM type stuff to be
running in the idle loop, so based on all of that, perhaps this is not a problem
after all and there is basically zero chance of a secondary cpu doing anything
that could cause a linear map split during this window?

I'm inclined to leave this as is for now.

Thanks,
Ryan

> 
> Thinking about it again, I’m not sure whether
> it is acceptable to use a sleepable synchronization mechanism at this stage,
> like split_kernel_leaf_mapping() does with mutex_lock()
> (even though it may be technically possible).
> It also feels odd that this function can be called at this point in time.
> 
> If this is indeed considered problematic,
> I think it would be better to simply return -EINVAL immediately
> when linear_mapping_finalized has not yet been completed.
> 
> --
> Sincerely,
> Yeoreum Yun

