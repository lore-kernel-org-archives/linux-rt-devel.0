Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5411F40D598
	for <linux-rt-devel@lists.linux.dev>; Tue, 30 Jun 2026 04:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782794100; cv=none; b=ZgHvUNXbascf1Z4uaTR7IEpx0W1BCpxuJn6CZjv+hxZrXwA5OWGCDPoQX1Uht7YSo25r7enuJQEHSBQ08aFe/xXgVmfc1MYji5x+MuMueVIWzErC+sX/ugi09Xi1VFtwZTQZ5T3aVYj1Sf4ng4grCmqzqqyVsGdPlKz+UiUeP7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782794100; c=relaxed/simple;
	bh=y/04EdBzzHdRlsfF0oPaZCIwM/XdlAzWW4cyqcAUUH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twUASCfXBLzfawWfpOl8k8RjxmKuMnj/BW4J1sUigSH42if9sdjOtonxFYG45oigYgJ97noSw9V3oXdtKvHv0oHts9xg3h7G5165f0joZXuERmUCcNK9AfYnNPuhZ1tA/2yrs3/AIz6GqtkSRhhPW1I6WtFlazWnHj8nhqDZPvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RNkBf8/9; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RNkBf8/9"
Message-ID: <7a53b311-92f8-4058-bd92-73b4e64a96d7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782794095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0hzdxx9t9+R3e5R6FejY/wwQQYMET+soEHVV0SefJg=;
	b=RNkBf8/9pBI2jrZdOX/nx4RkjvAVG/AoJ8gw/sClDQntNYrbLbXM1XMuz1kp12GM0S4mXE
	jpo54jqedh9eoDOkVPQOkqmMQiD/TAbxhRzXtcHJ9IATulDqkncp3dMJmT/0m58JtHOdTa
	XoNQnfiuBYCVgwFC9K5hG5mJptxtMe8=
Date: Tue, 30 Jun 2026 12:34:14 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v3 15/16] mm: replace __GFP_NO_CODETAG with
 ALLOC_NO_CODETAG
To: sashiko-reviews@lists.linux.dev, Brendan Jackman <jackmanb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-15-57bef0eadbc2@google.com>
 <20260629155637.A59241F000E9@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <20260629155637.A59241F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


CC Andrew and Suren


On 2026/6/29 23:56, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>
> New issues:
> - [Low] The fallback `#else` definition of `pgalloc_tag_add` was not updated to accept `unsigned int alloc_flags`.
>
> Pre-existing issues:
> - [Critical] TOCTOU race in `__alloc_tag_add_early_pfn` leading to an out-of-bounds array write.
> --
>
> commit ccee7f6d4bcf9d00da38c878e97dd852c5e649b3
> Author: Brendan Jackman <jackmanb@google.com>
>
> mm: replace __GFP_NO_CODETAG with ALLOC_NO_CODETAG
>
> This commit replaces the mm-internal __GFP_NO_CODETAG flag with a
> new alloc_flags bit, ALLOC_NO_CODETAG. It plumbs alloc_flags through
> several allocator functions to allow passing this flag directly to the
> alloc_tag code.
>
>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>> index d9be1cf5187d9..a32a94e759b94 100644
>> --- a/mm/alloc_tag.c
>> +++ b/mm/alloc_tag.c
> [ ... ]
>> @@ -806,7 +795,8 @@ static void __init __alloc_tag_add_early_pfn(unsigned long pfn)
>>   	do {
>>   		pool = READ_ONCE(current_pfn_pool);
>>   		if (!pool || atomic_read(&pool->count) >= PFN_POOL_SIZE) {
>> -			struct page *new_page = alloc_page(__GFP_HIGH | __GFP_NO_CODETAG);
>> +			struct page *new_page = __alloc_pages(__GFP_HIGH, 0, numa_mem_id(),
>> +							      NULL, ALLOC_NO_CODETAG);
>>   			struct pfn_pool *new;
> [Severity: Critical]
> This is a pre-existing issue, but is there a time-of-check to time-of-use
> race condition here?
>
> If multiple CPUs are active during the deferred init window, could they
> concurrently observe the same remaining capacity?
>
> CPU1:
>      if (!pool || atomic_read(&pool->count) >= PFN_POOL_SIZE)
>
> CPU2:
>      if (!pool || atomic_read(&pool->count) >= PFN_POOL_SIZE)
>
> If both see 1 remaining slot, won't they both proceed to call
> atomic_fetch_add() on the pool counter further down in this function?
> This could cause an out-of-bounds array write at pool->pfns[PFN_POOL_SIZE].


It's interesting.

I didn't get this warning from Sashiko when I submitted the patch earlier,

I'm not sure what changed on its end to trigger it now.

No worries though, unless I've overlooked some detail,

I believe this is a false positive


Even if both CPUs see 1 remaining slot and both skip the pool-growing 
branch,

they still have to go through atomic_cmpxchg to actually claim it.

static void __init __alloc_tag_add_early_pfn(unsigned long pfn)
{
     struct pfn_pool *pool;
     int idx;

     do {
         pool = READ_ONCE(current_pfn_pool);
         if (!pool || atomic_read(&pool->count) >= PFN_POOL_SIZE) {
         .........
         }
         idx = atomic_read(&pool->count);
         if (idx >= PFN_POOL_SIZE)
             continue;
         if (atomic_cmpxchg(&pool->count, idx, idx + 1) == idx)
             break;
     } while (1);

     pool->pfns[idx] = pfn;
}


Only one wins, the other gets a CAS failure and loops back.

There's no path where both write to pfns[PFN_POOL_SIZE].


Given that, I think we can ignore this Sashiko report and

move forward with Brendan's patch.


Thanks

Best Regards

Hao


> [ ... ]
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 026f33f217036..803b32e5a5e47 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
> [ ... ]
>> @@ -1263,17 +1263,17 @@ void __pgalloc_tag_add(struct page *page, struct task_struct *task,
>>   		alloc_tag_add_early_pfn(page_to_pfn(page), alloc_flags);
>>   		if (task->alloc_tag)
>>   			alloc_tag_set_inaccurate(task->alloc_tag);
>>   	}
>>   }
>>   
>>   static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
>> -				   unsigned int nr, gfp_t gfp_flags)
>> +				   unsigned int nr, unsigned int alloc_flags)
>>   {
>>   	if (mem_alloc_profiling_enabled())
>> -		__pgalloc_tag_add(page, task, nr, gfp_flags);
>> +		__pgalloc_tag_add(page, task, nr, alloc_flags);
>>   }
> [Severity: Low]
> Does this change miss updating the fallback definition of pgalloc_tag_add()
> when memory allocation profiling is disabled?
>
> If the kernel is compiled without mem-alloc profiling, the dummy function
> signature appears to still use the old type:
>
> static inline void pgalloc_tag_add(struct page *page, struct task_struct *task,
>                     unsigned int nr, gfp_t gfp_flags) {}
>
> Since callers like post_alloc_hook() are now passing an unsigned int
> for alloc_flags, won't this cause a Sparse type mismatch warning because
> gfp_t is a restricted bitwise type?
>
