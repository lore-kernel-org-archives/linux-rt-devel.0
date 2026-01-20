Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A99C3BC4E6
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Jan 2026 08:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768899385; cv=none; b=FXRtytmx4x/s/ytpVTuE4NX693CgsejpQaIhh7qfKy0/y95n75a/CvH37Xr9ulNv1V6o3+tqaYmGXhF2XZpPmX2LMlpeX6ARRv67+DhysCls3R3XK7mO8wrfITZ5FT7fT7uAhhHvcRYIYWbJyEKDz5pSAWOTzk5TUbkYNQv0S9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768899385; c=relaxed/simple;
	bh=h6aTgqrs9iaD3xYpFr6nfljLfGH45suE9udXBkZ6mnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tA5KjqBPQEZ11MGhC6jZ/P0kBbiAT49vGQQlvapgzLuRXP8hfVMjGbnLkhe1daJhQjDu78c+ychjSbWp9LpQBeR8j6vZqgVnRUMh/Lm3Nj16ElpWfwesIghf9yyKIWhgafQikLc432Bf9/zD/cj+T4urSfLGomnS+9KqdZSzMgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFBC91476;
	Tue, 20 Jan 2026 00:56:10 -0800 (PST)
Received: from [10.57.93.204] (unknown [10.57.93.204])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2603C3F740;
	Tue, 20 Jan 2026 00:56:14 -0800 (PST)
Message-ID: <2619166b-13ef-4daa-82c7-1d44035a8d6c@arm.com>
Date: Tue, 20 Jan 2026 08:56:12 +0000
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
To: Yeoreum Yun <yeoreum.yun@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, catalin.marinas@arm.com,
 akpm@linux-oundation.org, david@kernel.org, kevin.brodsky@arm.com,
 quic_zhenhuah@quicinc.com, dev.jain@arm.com, yang@os.amperecomputing.com,
 chaitanyas.prakash@arm.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, lorenzo.stoakes@oracle.com, ardb@kernel.org,
 jackmanb@google.com, vbabka@suse.cz, mhocko@suse.com
References: <20260105202328.2418990-1-yeoreum.yun@arm.com>
 <20260105202328.2418990-3-yeoreum.yun@arm.com>
 <aW5p1ylQBNXTEmmq@willie-the-truck> <aW6hISBu3hNYS771@e129823.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aW6hISBu3hNYS771@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/01/2026 21:24, Yeoreum Yun wrote:
> Hi Will,
> 
>> On Mon, Jan 05, 2026 at 08:23:27PM +0000, Yeoreum Yun wrote:
>>> +static int __init linear_map_prealloc_split_pgtables(void)
>>> +{
>>> +	int ret, i;
>>> +	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
>>> +	unsigned long lend = PAGE_END;
>>> +	unsigned long kstart = (unsigned long)lm_alias(_stext);
>>> +	unsigned long kend = (unsigned long)lm_alias(__init_begin);
>>> +
>>> +	const struct mm_walk_ops collect_to_split_ops = {
>>> +		.pud_entry	= collect_to_split_pud_entry,
>>> +		.pmd_entry	= collect_to_split_pmd_entry
>>> +	};
>>
>> Why do we need to rewalk the page-table here instead of collating the
>> number of block mappings we put down when creating the linear map in
>> the first place?

That's a good point; perhaps we can reuse the counters that this series introduces?

https://lore.kernel.org/all/20260107002944.2940963-1-yang@os.amperecomputing.com/

> 
> First, linear alias of the [_text, __init_begin) is not a target for
> the split and it also seems strange to me to add code inside alloc_init_XXX()
> that both checks an address range and counts to get the number of block mappings.
> 
> Second, for a future feature,
> I hope to add some code to split "specfic" area to be spilt e.x)
> to set a specific pkey for specific area.

Could you give more detail on this? My working assumption is that either the
system supports BBML2 or it doesn't. If it doesn't, we need to split the whole
linear map. If it does, we already have logic to split parts of the linear map
when needed.

> 
> In this case, it's useful to rewalk the page-table with the specific
> range to get the number of block mapping.
> 
>>
>>> +	split_pgtables_idx = 0;
>>> +	split_pgtables_count = 0;
>>> +
>>> +	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
>>> +						    &collect_to_split_ops,
>>> +						    NULL, NULL);
>>> +	if (!ret)
>>> +		ret = walk_kernel_page_table_range_lockless(kend, lend,
>>> +							    &collect_to_split_ops,
>>> +							    NULL, NULL);
>>> +	if (ret || !split_pgtables_count)
>>> +		goto error;
>>> +
>>> +	ret = -ENOMEM;
>>> +
>>> +	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
>>> +				  GFP_KERNEL | __GFP_ZERO);
>>> +	if (!split_pgtables)
>>> +		goto error;
>>> +
>>> +	for (i = 0; i < split_pgtables_count; i++) {
>>> +		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
>>> +		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
>>> +		if (!split_pgtables[i])
>>> +			goto error;
>>
>> This looks potentially expensive on the boot path and only gets worse as
>> the amount of memory grows. Maybe we should predicate this preallocation
>> on preempt-rt?
> 
> Agree. then I'll apply pre-allocation with PREEMPT_RT only.

I guess I'm missing something obvious but I don't understand the problem here...
We are only deferring the allocation of all these pgtables, so the cost is
neutral surely? Had we correctly guessed that the system doesn't support BBML2
earlier, we would have had to allocate all these pgtables earlier.

Another way to look at it is that we are still allocating the same number of
pgtables in the existing fallback path, it's just that we are doing it inside
the stop_machine().

My vote would be _not_ to have a separate path for PREEMPT_RT, which will end up
with significantly less testing...

Thanks,
Ryan

> 
> Thanks for your review.
> 
> --
> Sincerely,
> Yeoreum Yun

