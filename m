Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4035E1C9
	for <linux-rt-devel@lists.linux.dev>; Wed,  1 Jul 2026 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870478; cv=none; b=sEPOC4rxh8bq9+9gXVugTR9WRJ7nkgje5XpZFVnICgjRcNDwXvvcIq+RSOSPwa12MVJjibc/a+YcwhQdAdfm9efseJW7n/m+czkNKDtr2sBW9uVdtd72HdnezPl+S9cHVhvqvipwB1DO625xIr1QlzQV/YKHLMB83QttsOvCYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870478; c=relaxed/simple;
	bh=r8jgEEjWaZBcdWI2dLqQPIaOXfT9NDjKgCBwhcpBHHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H9wn0h3PE6KcW3eBNnjb42OHAnwoBbx0cg3FQtb/Mt7+NUEewcKpU3AwQ18fZAMRlVurWXLixXFxng/ipemjRWPV4kUf9uy0SCUHHVFksoEicHzJAlBnMD21H+BI6awiUfGuYKd8dJZpLWsicpxD3fF83Xd0muWDX8JJJT1bVqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ACb/zxQc; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ACb/zxQc"
Message-ID: <97e35cad-20f8-46cf-ae37-18fecb978e2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782870474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ysLxtr1n2K4bo9wRx4/EdIOpK0zk8mIVVHbKxk1Ez/4=;
	b=ACb/zxQcg/Qyy9PQAB+n+SdUBjP5gkfNkc0qneHUbVvZLKbT35HJ0QyVpHyP3DOEy0Oljn
	J/BViD0FXAgiAlMq0EVr4v3VL9sVJgd77k+tAXQ6CRTziWSFwtvK4y3zo0c7UPKcL4xfvk
	GUIyk034z++L4bDAPTBIjp3p5uFQdFA=
Date: Wed, 1 Jul 2026 09:47:06 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH v3 15/16] mm: replace __GFP_NO_CODETAG with
 ALLOC_NO_CODETAG
To: Brendan Jackman <brendan.jackman@linux.dev>,
 Brendan Jackman <jackmanb@google.com>
Cc: "Harry Yoo (Oracle)" <harry@kernel.org>, Gregory Price
 <gourry@gourry.net>, Alexei Starovoitov <ast@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Vlastimil Babka <vbabka@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
 Muchun Song <muchun.song@linux.dev>, David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Mike Rapoport <rppt@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Hao Li <hao.li@linux.dev>, Christoph Lameter <cl@gentwo.org>,
 David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
References: <20260629-alloc-trylock-v3-0-57bef0eadbc2@google.com>
 <20260629-alloc-trylock-v3-15-57bef0eadbc2@google.com>
 <b4916118-3537-4e19-8bc8-1d103dd0d225@linux.dev>
 <DJMAWIOIOII3.24TMC6HTPXA7C@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <DJMAWIOIOII3.24TMC6HTPXA7C@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Brendan


On 2026/6/30 18:10, Brendan Jackman wrote:
> On Tue Jun 30, 2026 at 1:55 AM UTC, Hao Ge wrote:
>> Hi Brendan
>>
>>
>> On 2026/6/29 21:12, Brendan Jackman wrote:
>>> Now that alloc_pages has an entrypoint that allows passing alloc_flags,
>>> we can take advantage of this to start removing GFP flags that are only
>>> used for mm-internal stuff.
>>>
>>> This requires also plumbing the alloc_flags into some more of the
>>> allocator code, in particular __alloc_pages[_noprof]() gets an
>>> alloc_flags arg to go along with its callees, and we now need to pass
>>> those flags deeper into the allocator so they can reach the alloc_tag
>>> code.
>>>
>>> No functional change intended.
>>>
>>> Signed-off-by: Brendan Jackman <jackmanb@google.com>
>>> ---
>>>    mm/alloc_tag.c       | 22 ++++++----------------
>>>    mm/compaction.c      |  4 ++--
>>>    mm/internal.h        |  1 -
>>>    mm/page_alloc.c      | 42 ++++++++++++++++++++++++------------------
>>>    mm/page_alloc.h      | 17 +++++++++++++++--
>>>    mm/page_frag_cache.c |  4 ++--
>>>    6 files changed, 49 insertions(+), 41 deletions(-)
>>>
>>> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
>>> index d9be1cf5187d9..a32a94e759b94 100644
>>> --- a/mm/alloc_tag.c
>>> +++ b/mm/alloc_tag.c
>>> @@ -15,6 +15,8 @@
>>>    #include <linux/vmalloc.h>
>>>    #include <linux/kmemleak.h>
>>>    
>>> +#include "internal.h"
>>
>> Should we include page_alloc.h here, as we call __alloc_pages later in
>> this file?
> Yeah, there are a few build failures due to me not doing a broad enough
> build. From now on I will just wait for allmodconfig instead of trying
> to be clever with my build tests, sorry about this.


No worries at all. For the alloc_tag build error, it depends on whether

CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.


> Also, this suggests that I have not actually re-tested the alloc_tag
> code since v3 so I must repeat the test described in my cover letter (I
> just manually enable the feature and check the kernel boots) for v4.
>

Thanks a lot for your work. I merged your patch locally via my 
automation bot,

and verified the basic functionality of alloc_tag.

The alloc_tag feature works well so far.


By the way, you may need to rebase your patchset on top of mm-new.

This patch has been merged into mm-new and will cause a minor conflict,

assuming the mm-new tree has not made further modifications to this patch:

https://lore.kernel.org/all/20260629-free-pfn-on-alloc-contig-range-error-path-v1-1-496ff9ca22db@nvidia.com/


Thanks

Best Regards

Hao


>>> +
>>>    #define ALLOCINFO_FILE_NAME		"allocinfo"
>>>    #define MODULE_ALLOC_TAG_VMAP_SIZE	(100000UL * sizeof(struct alloc_tag))
>>>    #define SECTION_START(NAME)		(CODETAG_SECTION_START_PREFIX NAME)
>>> @@ -783,19 +785,6 @@ struct pfn_pool {
>>>    
>>>    #define PFN_POOL_SIZE			((PAGE_SIZE - offsetof(struct pfn_pool, pfns)) / \
>>>    					 sizeof(unsigned long))
>>> -
>>> -/*
>>> - * Skip early PFN recording for a page allocation.  Reuses the
>>> - * %__GFP_NO_OBJ_EXT bit.  Used by __alloc_tag_add_early_pfn() to avoid
>>> - * recursion when allocating pages for the early PFN tracking list
>>> - * itself.
>>> - *
>>> - * Codetags of the pages allocated with __GFP_NO_CODETAG should be
>>> - * cleared (via clear_page_tag_ref()) before freeing the pages to prevent
>>> - * alloc_tag_sub_check() from triggering a warning.
>>> - */
>>> -#define __GFP_NO_CODETAG		__GFP_NO_OBJ_EXT
>>> -
>>>    static struct pfn_pool *current_pfn_pool __initdata;
>>>    
>>>    static void __init __alloc_tag_add_early_pfn(unsigned long pfn)
>>> @@ -806,7 +795,8 @@ static void __init __alloc_tag_add_early_pfn(unsigned long pfn)
>>>    	do {
>>>    		pool = READ_ONCE(current_pfn_pool);
>>>    		if (!pool || atomic_read(&pool->count) >= PFN_POOL_SIZE) {
>>> -			struct page *new_page = alloc_page(__GFP_HIGH | __GFP_NO_CODETAG);
>>> +			struct page *new_page = __alloc_pages(__GFP_HIGH, 0, numa_mem_id(),
>>> +							      NULL, ALLOC_NO_CODETAG);
>>>    			struct pfn_pool *new;
>>>    
>>>    			if (!new_page) {
>>> @@ -837,7 +827,7 @@ typedef void alloc_tag_add_func(unsigned long pfn);
>>>    static alloc_tag_add_func __rcu *alloc_tag_add_early_pfn_ptr __refdata =
>>>    	RCU_INITIALIZER(__alloc_tag_add_early_pfn);
>>>    
>>> -void alloc_tag_add_early_pfn(unsigned long pfn, gfp_t gfp_flags)
>>> +void alloc_tag_add_early_pfn(unsigned long pfn, unsigned int alloc_flags)
>>
>> alloc_tag_add_early_pfn() has three occurrences across the codebase:
>>
>> 1. Definition in mm/alloc_tag.c:830:
>>
>> void alloc_tag_add_early_pfn(unsigned long pfn, unsigned int alloc_flags)
>>
>> 2. Declaration in include/linux/alloc_tag.h:166:
>>
>> void alloc_tag_add_early_pfn(unsigned long pfn, gfp_t gfp_flags)
>>
>> 3. Static inline stub in include/linux/alloc_tag.h:170:
>>
>> static inline void alloc_tag_add_early_pfn(unsigned long pfn, gfp_t
>> gfp_flags) {}
>>
>> This patch updates the definition in alloc_tag.c to take unsigned int
>> alloc_flags,
>>
>> but the two declarations in alloc_tag.h are left with the old gfp_t
>> gfp_flags signature
>>
>> These should be updated to match.
> Yeah ditto, sorry about this and thanks for the review.
