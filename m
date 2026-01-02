Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49591262FD0
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Jan 2026 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767373472; cv=none; b=jPgjdYgEdRCVpWfwSdQEWMyyPr1GHuVBhKPVlY8yGXUn6q5qEgrjmtjxdt6bOmqKLsoSFra54LB/dGFNitMp23WNdHC4DLHPW8f+6Zwz/T0ajwWhm8SBzaWCbyuHTBO41b3j4OL7DHnJYVaym8xaGBRv6M7iMx5CF97MCwBoqfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767373472; c=relaxed/simple;
	bh=55pLin5c8TW3Aa2aA/LuJo2JW/m0wU2eGZOMf2uMaP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BwOQENNsUKfE2BbkyLEMn6QpNqgEJFK/8oGbgye6NA2QkvORi+NoOnvyDcv0Lid1QTGSFvq5IPBx1oPpx5BV0u5wseeJu20Lm9lHmhnxi8BHyHOhXfW+xldHItQovOEGeNBWiOiXPGtEnaI78btAy0YN5mrDTT/QYz0m/4QyX3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B060497;
	Fri,  2 Jan 2026 09:04:21 -0800 (PST)
Received: from [10.57.94.221] (unknown [10.57.94.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 179BA3F5A1;
	Fri,  2 Jan 2026 09:04:24 -0800 (PST)
Message-ID: <85b23ed5-6219-4da6-a19a-3577ebaeac3f@arm.com>
Date: Fri, 2 Jan 2026 17:04:23 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] arm64: mmu: avoid allocating pages while splitting
 the linear mapping
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 david@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 dev.jain@arm.com, yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
 vbabka@suse.cz, mhocko@suse.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20260102150736.1378818-1-yeoreum.yun@arm.com>
 <20260102150736.1378818-3-yeoreum.yun@arm.com>
 <df057023-7a06-41f7-ac6f-caf6b8d8c144@arm.com>
 <aVfu5EZM1XyJjrYp@e129823.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aVfu5EZM1XyJjrYp@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/01/2026 16:14, Yeoreum Yun wrote:
> Hi Ryan,
> 
>>> linear_map_split_to_ptes() currently allocates page tables while
>>> splitting the linear mapping into PTEs under stop_machine() using GFP_ATOMIC.
>>>
>>> This is fine for non-PREEMPT_RT configurations.
>>> However, it becomes problematic on PREEMPT_RT, because
>>> generic memory allocation/free APIs (e.g. pgtable_alloc(), __get_free_pages(), etc.)
>>> cannot be called from a non-preemptible context, except for the _nolock() variants.
>>> This is because generic memory allocation/free paths are sleepable,
>>> as they rely on spin_lock(), which becomes sleepable on PREEMPT_RT.
>>>
>>> In other words, even calling pgtable_alloc() with GFP_ATOMIC is not permitted
>>> in __linear_map_split_to_pte() when it is executed by the stopper thread,
>>>  where preemption is disabled on PREEMPT_RT.
>>>
>>> To address this, the required number of page tables is first collected
>>> and preallocated, and the preallocated page tables are then used
>>> when splitting the linear mapping in __linear_map_split_to_pte().
>>>
>>> Fixes: 3df6979d222b ("arm64: mm: split linear mapping if BBML2 unsupported on secondary CPUs")
>>> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
>>
>> Looks good from my perspective.
>>
>> I have a couple more small comments below. With those addressed:
>>
>> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
>>
>>> ---
>>>  arch/arm64/mm/mmu.c | 204 +++++++++++++++++++++++++++++++++++---------
>>>  1 file changed, 166 insertions(+), 38 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 4b4908ae189b..cc086e91a506 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -529,18 +529,14 @@ static void early_create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>>>  		panic("Failed to create page tables\n");
>>>  }
>>>
>>> -static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>>> -				       enum pgtable_type pgtable_type)
>>> -{
>>> -	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
>>> -	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
>>> -	phys_addr_t pa;
>>> -
>>> -	if (!ptdesc)
>>> -		return INVALID_PHYS_ADDR;
>>> -
>>> -	pa = page_to_phys(ptdesc_page(ptdesc));
>>> +static struct ptdesc **split_pgtables;
>>> +static unsigned long split_pgtables_count;
>>> +static unsigned long split_pgtables_idx;
>>
>> I think these could all be __initdata, if you make
>> pgd_pgtable_get_preallocated() __init (see below) ?
> 
> I don't think so since range_split_to_ptes() couldn't be __init.
> That's why there is warning while compiling below:
> 
>   WARNING: modpost: vmlinux: section mismatch in reference: range_split_to_ptes+0x3c (section: .text) -> pgd_pgtable_get_preallocated (section: .init.text)

Ahh ok, the compiler beats me :)

>>
>>>
>>> +static __always_inline void __pgd_pgtable_init(struct mm_struct *mm,
>>
>> Is there a reason for __always_inline? If not, I think it's preferable to just
>> leave it static and let the compiler decide.
> 
> Okay. I'll remove __always_inline. Thanks.
> 
>>
>>> +					       struct ptdesc *ptdesc,
>>> +					       enum pgtable_type pgtable_type)
>>> +{
>>>  	switch (pgtable_type) {
>>>  	case TABLE_PTE:
>>>  		BUG_ON(!pagetable_pte_ctor(mm, ptdesc));
>>> @@ -555,26 +551,49 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>>>  		pagetable_p4d_ctor(ptdesc);
>>>  		break;
>>>  	}
>>> -
>>> -	return pa;
>>>  }
>>>
>>> -static phys_addr_t
>>> -pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
>>> +static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
>>> +				       enum pgtable_type pgtable_type)
>>>  {
>>> -	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
>>> +	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
>>> +	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
>>> +
>>> +	if (!ptdesc)
>>> +		return INVALID_PHYS_ADDR;
>>> +
>>> +	__pgd_pgtable_init(mm, ptdesc, pgtable_type);
>>> +
>>> +	return page_to_phys(ptdesc_page(ptdesc));
>>>  }
>>>
>>> -static phys_addr_t __maybe_unused
>>> +static phys_addr_t
>>>  pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>>>  {
>>> -	return pgd_pgtable_alloc_init_mm_gfp(pgtable_type, GFP_PGTABLE_KERNEL);
>>> +	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
>>>  }
>>>
>>>  static phys_addr_t
>>>  pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
>>>  {
>>> -	return  __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL, pgtable_type);
>>> +	return  __pgd_pgtable_alloc(NULL, pgtable_type);
>>> +}
>>> +
>>> +static phys_addr_t
>>> +pgd_pgtable_get_preallocated(enum pgtable_type pgtable_type)
>>
>> I think this could probably be __init?
> 
> See above.
> 
>>
>>> +{
>>> +	struct ptdesc *ptdesc;
>>> +
>>> +	if (WARN_ON(split_pgtables_idx >= split_pgtables_count))
>>> +		return INVALID_PHYS_ADDR;
>>> +
>>> +	ptdesc = split_pgtables[split_pgtables_idx++];
>>> +	if (!ptdesc)
>>> +		return INVALID_PHYS_ADDR;
>>> +
>>> +	__pgd_pgtable_init(&init_mm, ptdesc, pgtable_type);
>>> +
>>> +	return page_to_phys(ptdesc_page(ptdesc));
>>>  }
>>>
>>>  static void split_contpte(pte_t *ptep)
>>> @@ -586,7 +605,9 @@ static void split_contpte(pte_t *ptep)
>>>  		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>>>  }
>>>
>>> -static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>>> +static int split_pmd(pmd_t *pmdp, pmd_t pmd,
>>> +		     pgtable_alloc_t pgtable_alloc,
>>> +		     bool to_cont)
>>
>> nit: this will easily fit in 2 lines and still be within 80 chars:
> 
> Okay. I'll change it.
> 
>>
>> static int split_pmd(pmd_t *pmdp, pmd_t pmd, pgtable_alloc_t pgtable_alloc,
>> 		     bool to_cont)
>>
>>>  {
>>>  	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
>>>  	unsigned long pfn = pmd_pfn(pmd);
>>> @@ -595,7 +616,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>>>  	pte_t *ptep;
>>>  	int i;
>>>
>>> -	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
>>> +	pte_phys = pgtable_alloc(TABLE_PTE);
>>>  	if (pte_phys == INVALID_PHYS_ADDR)
>>>  		return -ENOMEM;
>>>  	ptep = (pte_t *)phys_to_virt(pte_phys);
>>> @@ -630,7 +651,9 @@ static void split_contpmd(pmd_t *pmdp)
>>>  		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>>>  }
>>>
>>> -static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>>> +static int split_pud(pud_t *pudp, pud_t pud,
>>> +		     pgtable_alloc_t pgtable_alloc,
>>> +		     bool to_cont)
>>
>> nit: same comment.
> 
> Thanks for your review :D
> BTW, except the __init related comments, Could I add R-b tag
> after fixing others?

Yes, please add my R-b.

> 
> --
> Sincerely,
> Yeoreum Yun

