Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEFA2D47F3
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Jan 2026 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767357351; cv=none; b=TjfooUiTVoqMtNtL5J6c0aILfAdKVnARCN7C+ETlvKlH0C5lpmnyoXeRioT7cd5ZIS7+qynAWR7B5i97f2cWuS+EUFBsi5INn65z7QVzxrHclKcxjeHkht0u3Mz0+ahEQ6YpVP3sJGO7ppYbH133TYyBqZWqoXkRQQwdzXiiCmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767357351; c=relaxed/simple;
	bh=wSa0/xQTddA/n2ixzCUd6VWquUC9EPROZhsSnmmVsl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bsu6NOCniCNcatSb7t67ddfZ7z0VCICmgACl81Z3eafDOHKGenQRdFkiGatjBYG7Kl2YsGIp/k6d5YySYs8z11AM8NMMm4H3pwIcaKQiPSQ2VJ8V9nGNzKGwkepIj6FkJ+VtLcNjaTYL/rythzfc3/SyCQyrMB2fzKkignsaJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D60BE497;
	Fri,  2 Jan 2026 04:35:41 -0800 (PST)
Received: from [10.57.94.221] (unknown [10.57.94.221])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8AAEF3F63F;
	Fri,  2 Jan 2026 04:35:45 -0800 (PST)
Message-ID: <0923f6c6-5e56-4903-b9ea-4e787466ae71@arm.com>
Date: Fri, 2 Jan 2026 12:35:43 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] arm64: mmu: avoid allocating pages while splitting
 the linear mapping
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: catalin.marinas@arm.com, will@kernel.org, akpm@linux-foundation.org,
 david@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 dev.jain@arm.com, yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
 vbabka@suse.cz, mhocko@suse.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
References: <20251218194750.395301-1-yeoreum.yun@arm.com>
 <20251218194750.395301-2-yeoreum.yun@arm.com>
 <cd1c9dd0-dc1a-497c-b78f-d6c6dde898d9@arm.com>
 <aVe4SmuU1arLs14O@e129823.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <aVe4SmuU1arLs14O@e129823.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/01/2026 12:21, Yeoreum Yun wrote:
> Hi Ryan,
> 
> Thanks for your review :)
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
>>> ---
>>>  arch/arm64/mm/mmu.c | 232 +++++++++++++++++++++++++++++++++++---------
>>>  1 file changed, 184 insertions(+), 48 deletions(-)
>>>
>>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>>> index 9ae7ce00a7ef..96a9fa505e71 100644
>>> --- a/arch/arm64/mm/mmu.c
>>> +++ b/arch/arm64/mm/mmu.c
>>> @@ -527,18 +527,15 @@ static void early_create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
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
>>> +static int split_pgtables_order;
>>> +static unsigned long split_pgtables_count;
>>> +static unsigned long split_pgtables_idx;
>>>
>>> +static __always_inline void __pgd_pgtable_init(struct mm_struct *mm,
>>> +					       struct ptdesc *ptdesc,
>>> +					       enum pgtable_type pgtable_type)
>>> +{
>>>  	switch (pgtable_type) {
>>>  	case TABLE_PTE:
>>>  		BUG_ON(!pagetable_pte_ctor(mm, ptdesc));
>>> @@ -554,19 +551,28 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>>>  		break;
>>>  	}
>>>
>>
>> nit: no need for this empty line
> 
> Okay. I'll remove..
> 
>>
>>> -	return pa;
>>>  }
>>>
>>> -static phys_addr_t
>>> -pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
>>> +static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>>
>> nit: all remaining callers pass gfp=GFP_PGTABLE_KERNEL so you could remove the
>> param?
> 
> Agree. I'll remove it.
> 
>>
>>> +				       enum pgtable_type pgtable_type)
>>>  {
>>> -	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
>>> +	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
>>> +	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
>>> +
>>> +	if (!ptdesc)
>>> +		return INVALID_PHYS_ADDR;
>>> +
>>> +	__pgd_pgtable_init(mm, ptdesc, pgtable_type);
>>> +
>>> +	return page_to_phys(ptdesc_page(ptdesc));
>>>  }
>>>
>>> +typedef phys_addr_t (split_pgtable_alloc_fn)(enum pgtable_type);
>>
>> This type is used more generally than just for splitting. Perhaps simply call it
>> "pgtable_alloc_fn"?
>>
>> We also pass this type around in __create_pgd_mapping() and friends; perhaps we
>> should have a preparatory patch to define this type and consistently use it
>> everywhere instead of passing around "phys_addr_t (*pgtable_alloc)(enum
>> pgtable_type)"?
> 
> Oh. I miss that __create_pgd_mapping() uses the same callback type.
> I'll follow your suggestion. Thanks!
> 
>>
>>> +
>>>  static phys_addr_t __maybe_unused
>>
>> This is no longer __maybe_unused; you can drop the decorator.
> 
> Good point. Thanks!
> 
>>
>>>  pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>>>  {
>>> -	return pgd_pgtable_alloc_init_mm_gfp(pgtable_type, GFP_PGTABLE_KERNEL);
>>> +	return __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
>>>  }
>>>
>>>  static phys_addr_t
>>> @@ -575,6 +581,23 @@ pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
>>>  	return  __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL, pgtable_type);
>>>  }
>>>
>>> +static phys_addr_t
>>> +pgd_pgtable_get_preallocated(enum pgtable_type pgtable_type)
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
>>> +}
>>> +
>>>  static void split_contpte(pte_t *ptep)
>>>  {
>>>  	int i;
>>> @@ -584,7 +607,9 @@ static void split_contpte(pte_t *ptep)
>>>  		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>>>  }
>>>
>>> -static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>>> +static int split_pmd(pmd_t *pmdp, pmd_t pmd,
>>> +		     split_pgtable_alloc_fn *pgtable_alloc_fn,
>>
>> nit: I believe the * has no effect when passing function pointers and the usual
>> convention in Linux is to not use the *. Existing functions are also calling it
>> "pgtable_alloc" so perhaps this is a bit more consistent:
>>
>> pgtable_alloc_fn pgtable_alloc
>>
>> (same nitty comment for all uses below :) )
> 
> You're right. It just my *bad* habit. I'll remove it.
>>
>>> +		     bool to_cont)
>>>  {
>>>  	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
>>>  	unsigned long pfn = pmd_pfn(pmd);
>>> @@ -593,7 +618,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>>>  	pte_t *ptep;
>>>  	int i;
>>>
>>> -	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
>>> +	pte_phys = pgtable_alloc_fn(TABLE_PTE);
>>>  	if (pte_phys == INVALID_PHYS_ADDR)
>>>  		return -ENOMEM;
>>>  	ptep = (pte_t *)phys_to_virt(pte_phys);
>>> @@ -628,7 +653,9 @@ static void split_contpmd(pmd_t *pmdp)
>>>  		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>>>  }
>>>
>>> -static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>>> +static int split_pud(pud_t *pudp, pud_t pud,
>>> +		     split_pgtable_alloc_fn *pgtable_alloc_fn,
>>> +		     bool to_cont)
>>>  {
>>>  	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
>>>  	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
>>> @@ -638,7 +665,7 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>>>  	pmd_t *pmdp;
>>>  	int i;
>>>
>>> -	pmd_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PMD, gfp);
>>> +	pmd_phys = pgtable_alloc_fn(TABLE_PMD);
>>>  	if (pmd_phys == INVALID_PHYS_ADDR)
>>>  		return -ENOMEM;
>>>  	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
>>> @@ -707,7 +734,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>>>  	if (!pud_present(pud))
>>>  		goto out;
>>>  	if (pud_leaf(pud)) {
>>> -		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL, true);
>>> +		ret = split_pud(pudp, pud, pgd_pgtable_alloc_init_mm, true);
>>>  		if (ret)
>>>  			goto out;
>>>  	}
>>> @@ -732,7 +759,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>>>  		 */
>>>  		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
>>>  			goto out;
>>> -		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
>>> +		ret = split_pmd(pmdp, pmd, pgd_pgtable_alloc_init_mm, true);
>>>  		if (ret)
>>>  			goto out;
>>>  	}
>>> @@ -831,34 +858,35 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>>>  static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
>>>  				   unsigned long next, struct mm_walk *walk)
>>>  {
>>> -	gfp_t gfp = *(gfp_t *)walk->private;
>>> +	split_pgtable_alloc_fn *pgtable_alloc_fn = walk->private;
>>>  	pud_t pud = pudp_get(pudp);
>>> -	int ret = 0;
>>>
>>> -	if (pud_leaf(pud))
>>> -		ret = split_pud(pudp, pud, gfp, false);
>>> +	if (!pud_leaf(pud))
>>> +		return 0;
>>>
>>> -	return ret;
>>> +	return split_pud(pudp, pud, pgtable_alloc_fn, false);
>>
>> why are you changing the layout of this function? Seems like unneccessary churn.
>> Just pass pgtable_alloc to split_pud() instead of gfp.
>>
>>>  }
>>>
>>>  static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
>>>  				   unsigned long next, struct mm_walk *walk)
>>>  {
>>> -	gfp_t gfp = *(gfp_t *)walk->private;
>>> +	split_pgtable_alloc_fn *pgtable_alloc_fn = walk->private;
>>>  	pmd_t pmd = pmdp_get(pmdp);
>>> -	int ret = 0;
>>> +	int ret;
>>>
>>> -	if (pmd_leaf(pmd)) {
>>> -		if (pmd_cont(pmd))
>>> -			split_contpmd(pmdp);
>>> -		ret = split_pmd(pmdp, pmd, gfp, false);
>>> +	if (!pmd_leaf(pmd))
>>> +		return 0;
>>>
>>> -		/*
>>> -		 * We have split the pmd directly to ptes so there is no need to
>>> -		 * visit each pte to check if they are contpte.
>>> -		 */
>>> -		walk->action = ACTION_CONTINUE;
>>> -	}
>>> +	if (pmd_cont(pmd))
>>> +		split_contpmd(pmdp);
>>> +
>>> +	ret = split_pmd(pmdp, pmd, pgtable_alloc_fn, false);
>>> +
>>> +	/*
>>> +	 * We have split the pmd directly to ptes so there is no need to
>>> +	 * visit each pte to check if they are contpte.
>>> +	 */
>>> +	walk->action = ACTION_CONTINUE;
>>
>> Same comment; no need to change the layout of the function.
> 
> Okay. I'll keep the former layout.
> 
>>
>>>
>>>  	return ret;
>>>  }
>>> @@ -880,13 +908,15 @@ static const struct mm_walk_ops split_to_ptes_ops = {
>>>  	.pte_entry	= split_to_ptes_pte_entry,
>>>  };
>>>
>>> -static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
>>> +static int range_split_to_ptes(unsigned long start, unsigned long end,
>>> +			       split_pgtable_alloc_fn *pgtable_alloc_fn)
>>>  {
>>>  	int ret;
>>>
>>>  	arch_enter_lazy_mmu_mode();
>>>  	ret = walk_kernel_page_table_range_lockless(start, end,
>>> -					&split_to_ptes_ops, NULL, &gfp);
>>> +						    &split_to_ptes_ops, NULL,
>>> +						    pgtable_alloc_fn);
>>>  	arch_leave_lazy_mmu_mode();
>>>
>>>  	return ret;
>>> @@ -903,6 +933,105 @@ static void __init init_idmap_kpti_bbml2_flag(void)
>>>  	smp_mb();
>>>  }
>>>
>>> +static int __init
>>> +collect_to_split_pud_entry(pud_t *pudp, unsigned long addr,
>>> +			   unsigned long next, struct mm_walk *walk)
>>> +{
>>> +	pud_t pud = pudp_get(pudp);
>>> +
>>> +	if (pud_leaf(pud))
>>> +		split_pgtables_count += 1 + PTRS_PER_PMD;
>>
>> I think you probably want:
>>
>> 	walk->action = ACTION_CONTINUE;
>>
>> Likely you will end up with the same behaviour regardless. But you should at
>> least we consistent with collect_to_split_pmd_entry().
> 
> This is my fault to miss here. Thanks for catching this :)
> 
>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int __init
>>> +collect_to_split_pmd_entry(pmd_t *pmdp, unsigned long addr,
>>> +			   unsigned long next, struct mm_walk *walk)
>>> +{
>>> +	pmd_t pmd = pmdp_get(pmdp);
>>> +
>>> +	if (pmd_leaf(pmd))
>>> +		split_pgtables_count++;
>>> +
>>> +	walk->action = ACTION_CONTINUE;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static void __init linear_map_free_split_pgtables(void)
>>> +{
>>> +	int i;
>>> +
>>> +	if (!split_pgtables_count || !split_pgtables)
>>> +		goto skip_free;
>>> +
>>> +	for (i = split_pgtables_idx; i < split_pgtables_count; i++) {
>>> +		if (split_pgtables[i])
>>> +			pagetable_free(split_pgtables[i]);
>>> +	}
>>> +
>>> +	free_pages((unsigned long)split_pgtables, split_pgtables_order);
>>> +
>>> +skip_free:
>>> +	split_pgtables = NULL;
>>> +	split_pgtables_count = 0;
>>> +	split_pgtables_idx = 0;
>>> +	split_pgtables_order = 0;
>>> +}
>>> +
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
>>> +
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
>>> +	split_pgtables_order =
>>> +		order_base_2(PAGE_ALIGN(split_pgtables_count *
>>> +					sizeof(struct ptdesc *)) >> PAGE_SHIFT);
>>
>> Wouldn't this be simpler?
>>
>> 	split_pgtables_order = get_order(split_pgtables_count *
>> 					 sizeof(struct ptdesc *));
>>
> 
> Yes. that would be simpler. But I think we can use
> kvmalloc() for split_pagtables since
> linear_map_prealloc_split_pgtables() is called after mm_core_init().
> So It could be dropped or Am I missing something?
> 


If kvmalloc is usable at this point, I agree that would be much better.

Thanks,
Ryan

