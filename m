Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD050423171
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 16:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768926177; cv=none; b=Nwe5IUNDvWiqkdL2/TWyaY0eZr++dUvXaauT05Dt0crrAiiqElUqliZ2wm5x8p0ZNO2os2ImmdqIvJipNZ4HhMZn3QBSu/rB633zUj2s5IGIQSu1H2zHbZpjJdkkDWJiX5BsdCLQ/wUJrtX3J7EfcELBmGuvUQFs104/+gtV7vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768926177; c=relaxed/simple;
	bh=SGb6VBUirougbchYwy8u5BB1T3pTC8g/mkN/WotbH34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gjY80H85Bsu4oPxHtOj02fi8gPQ02MwGo4LGZGKEfy4UjaIFOtayLs8ggVBQUcjzGGuvgY+kjY5HLBfRbg7CfXLJUyJaU3mtKy3N6jwqpZ1TpodTYGqOWHBm52Tv6o5CwuZ8caW5bxgSroUOmFmuzyopmyFaSoIetvZg1CIiY6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23D541476;
	Tue, 20 Jan 2026 08:22:48 -0800 (PST)
Received: from [10.1.39.200] (XHFQ2J9959.cambridge.arm.com [10.1.39.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5DEB3F694;
	Tue, 20 Jan 2026 08:22:51 -0800 (PST)
Message-ID: <a6c1f21f-43e4-41d2-adb6-c5f9985b3abd@arm.com>
Date: Tue, 20 Jan 2026 16:22:50 +0000
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
To: Will Deacon <will@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 catalin.marinas@arm.com, akpm@linux-oundation.org, david@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
 vbabka@suse.cz, mhocko@suse.com
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck> <aW6hISBu3hNYS771@e129823.arm.com>
 <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
 <aW9LCX92T9t8iDco@e129823.arm.com>
 <baa46ea0-737b-4d9e-b4f4-2eee1476da95@arm.com>
 <aW-k_D1Q8jpYMPoI@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aW-k_D1Q8jpYMPoI@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/01/2026 15:53, Will Deacon wrote:
> On Tue, Jan 20, 2026 at 10:40:30AM +0000, Ryan Roberts wrote:
>> On 20/01/2026 09:29, Yeoreum Yun wrote:
>>> Hi Ryan
>>>> On 19/01/2026 21:24, Yeoreum Yun wrote:
>>>>> Hi Will,
>>>>>
>>>>>> On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
>>>>>>> +static int __init linear_map_prealloc_split_pgtables(void)
>>>>>>> +{
>>>>>>> +	int ret, i;
>>>>>>> +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
>>>>>>> +	unsigned long lend = PAGE_END;
>>>>>>> +	unsigned long kstart = (unsigned long)lm_alias(_stext);
>>>>>>> +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
>>>>>>> +
>>>>>>> +	const struct mm_walk_ops collect_to_split_ops = {
>>>>>>> +		.pud_entry	= collect_to_split_pud_entry,
>>>>>>> +		.pmd_entry	= collect_to_split_pmd_entry
>>>>>>> +	};
>>>>>>
>>>>>> Why do we need to rewalk the page-table here instead of collating the
>>>>>> number of block mappings we put down when creating the linear map in
>>>>>> the first place?
>>>>
>>>> That's a good point; perhaps we can reuse the counters that this series introduces?
>>>>
>>>> https://lore.kernel.org/all/20260107002944.2940963-1-yang@os.amperecomputing.com/
>>>>
>>>>>
>>>>> First, linear alias of the [_text, __init_begin) is not a target for
>>>>> the split and it also seems strange to me to add code inside alloc_init_XXX()
>>>>> that both checks an address range and counts to get the number of block mappings.
>>>>>
>>>>> Second, for a future feature,
>>>>> I hope to add some code to split "specfic" area to be spilt e.x)
>>>>> to set a specific pkey for specific area.
>>>>
>>>> Could you give more detail on this? My working assumption is that either the
>>>> system supports BBML2 or it doesn't. If it doesn't, we need to split the whole
>>>> linear map. If it does, we already have logic to split parts of the linear map
>>>> when needed.
>>>
>>> This is not for a linear mapping case. but for a "kernel text area".
>>> As a draft, I want to mark some of kernel code can executable
>>> both kernel and eBPF program.
>>> (I'm trying to make eBPF program non-executable kernel code directly
>>> with POE feature).
>>> For this "executable area" both of kernel and eBPF program
>>> -- typical example is exception entry, It need to split that specific
>>> range and mark them with special POE index.
>>
>> Ahh yes, I recall you mentioning this a while back (although I confess all the
>> deatils have fallen out of my head). You'd need to make sure you're definitely
>> not splitting an area of text that the secondary CPUs are executing while they
>> are being held in the pen, since at least one of those CPUs doesn't support BBML2.
>>
>>>
>>>>
>>>>>
>>>>> In this case, it's useful to rewalk the page-table with the specific
>>>>> range to get the number of block mapping.
>>>>>
>>>>>>
>>>>>>> +	split_pgtables_idx = 0;
>>>>>>> +	split_pgtables_count = 0;
>>>>>>> +
>>>>>>> +	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
>>>>>>> +						    &collect_to_split_ops,
>>>>>>> +						    NULL, NULL);
>>>>>>> +	if (!ret)
>>>>>>> +		ret = walk_kernel_page_table_range_lockless(kend, lend,
>>>>>>> +							    &collect_to_split_ops,
>>>>>>> +							    NULL, NULL);
>>>>>>> +	if (ret || !split_pgtables_count)
>>>>>>> +		goto error;
> 
> Just noticed this, but why do we check '!split_pgtables_count' here?
> if the page-table is already somehow mapped at page granularity, that
> doesn't necessarily sound like a fatal error to me.
> 
>>>>>>> +
>>>>>>> +	ret = -ENOMEM;
>>>>>>> +
>>>>>>> +	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
>>>>>>> +				  GFP_KERNEL | __GFP_ZERO);
>>>>>>> +	if (!split_pgtables)
>>>>>>> +		goto error;
>>>>>>> +
>>>>>>> +	for (i = 0; i < split_pgtables_count; i++) {
>>>>>>> +		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
>>>>>>> +		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
>>>>>>> +		if (!split_pgtables[i])
>>>>>>> +			goto error;
>>>>>>
>>>>>> This looks potentially expensive on the boot path and only gets worse as
>>>>>> the amount of memory grows. Maybe we should predicate this preallocation
>>>>>> on preempt-rt?
>>>>>
>>>>> Agree. then I'll apply pre-allocation with PREEMPT_RT only.
>>>>
>>>> I guess I'm missing something obvious but I don't understand the problem here...
>>>> We are only deferring the allocation of all these pgtables, so the cost is
>>>> neutral surely? Had we correctly guessed that the system doesn't support BBML2
>>>> earlier, we would have had to allocate all these pgtables earlier.
>>>>
>>>> Another way to look at it is that we are still allocating the same number of
>>>> pgtables in the existing fallback path, it's just that we are doing it inside
>>>> the stop_machine().
>>>>
>>>> My vote would be _not_ to have a separate path for PREEMPT_RT, which will end up
>>>> with significantly less testing...
>>>
>>> IIUC, Will's mention is additional memory allocation for
>>> "split_pgtables" where saved "pre-allocate" page tables.
>>> As the memory increase, definitely this size would increase the cost.
>>
>> Err, so you're referring to the extra kvmalloc()? I don't think that's a big
>> deal is it? you get 512 pointers per page. So the amortized cost is 1/512= 0.2%?
> 
> Right, it was the page-table pages I was worried about not the array of
> pointers.
> 
>> I suspect we have both misunderstood Will's point...
> 
> I probably just got confused by linear_map_free_split_pgtables() as it
> has logic to free unused page-table pages between 'split_pgtables_idx'
> and 'split_pgtables_count', implying that we can over-allocate.
> 
> If that is only needed for the error path in
> linear_map_prealloc_split_pgtables(), then perhaps that part should be
> inlined to deal with the case where we fail to allocate part way through.

I was originally concerned [1] that there could be a race where another CPU
caused the normal splitting machinery to kick in after this cpu determined the
number of required page tables, so there could be some left over in that case.

On reflection, I guess (hope) that's not possible because we've determined that
some CPUs don't support BBML2. I'm guessing the secondaries haven't been
released to do general work yet?

In which case, I agree, this could be simplified and we could just assert that
all pre-allocated pages get used up if there is no error?

[1] https://lore.kernel.org/all/73ced1db-a2e2-49ea-927e-9fc4a30e771e@arm.com/

> 
> Will

