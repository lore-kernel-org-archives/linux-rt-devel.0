Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE9F2E8B94;
	Thu, 18 Dec 2025 08:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046224; cv=none; b=kQqlh0SCbkW3NCPsVKBjsSMU2g3r5wz7oqZf2Mk0ZhSjLuJpvXCeZrLk/nX+mrOdDyUre0MqU01zzaWOs6kOJZMxLFTgbDFvpmqKHAhESH99EL8d+myAf2MeCdKReNYD7arq5nYyof7QcFwWGY6E3DMoXOdyKdPGHCmtCESD+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046224; c=relaxed/simple;
	bh=86abvgSko5dKP7P0BYXR5jcJ+ZvW7j9KkCOKJ7Pbnb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kMcn26MU0pWwQyZGi6Gb2rkSSC61YxxzE+re3dNIfqghYlS8lvkSG5jbF8QJFQTzblyNuC29aay97UhTZ83SDMie90eK5SorVvXfUR6B1fs+bGu1uEOHSlKG8ZFDE7MxE3UJnraiMDtEPbYKD+mI52kUrmnFfqtuUqhCTKBfCWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwYZNTxp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwYZNTxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DC2C4CEFB;
	Thu, 18 Dec 2025 08:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766046223;
	bh=86abvgSko5dKP7P0BYXR5jcJ+ZvW7j9KkCOKJ7Pbnb4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TwYZNTxpd2GTX5RxIpdgFNK3CPwYyYQCvYPUZFGbmXEVnE4Yxs0xEbVl5diQsMZBz
	 ZYK9cAQdH3tn0gdHwvDLw/V7IV5OU6aUXKlZcogq0uxf57NX9FFoZ73PFlLZGtllLZ
	 lhK7mexgeXHX6PyF+KuUmaBPyMtoZSRxH6z18ckyq8xvNkmJP49NOQiYGo0W+sDbgF
	 49hiHK/JOhLAXW4GAryZzCuLHro3ipUUuwpceofBFZOS/W+xITUnL20WvwXQbQSYzL
	 yDZ9ouZK0o0nXWjM8Nj1sWpthHstqXtFD49cABVRToSPl23msKsAd70Asql9mdckqf
	 aGj88nCZbdqQg==
Message-ID: <15777c12-d732-42e6-83da-61b3dca3764c@kernel.org>
Date: Thu, 18 Dec 2025 09:23:38 +0100
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: mmu: don't allocate page while spliting
 linear mapping
To: Yeoreum Yun <yeoreum.yun@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, ryan.roberts@arm.com, akpm@linux-foundation.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
 vbabka@suse.cz
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-2-yeoreum.yun@arm.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <20251217182007.2345700-2-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/17/25 19:20, Yeoreum Yun wrote:
> Current linear_map_split_to_ptes() allocate the pagetable
> while split linear mapping to ptes by stop_machine() with GFP_ATOMIC.
> 
> This is fine for non-PREEMPR_RT case.
> However It's a problem in PREEMPR_RT case since
> generic memory allocation/free APIs (e.x) pgtable_alloc(), __get_free_pages and etc
> couldn't be called in non-preemptible context except _nolock() APIs
> since generic memory allocation/free APIs are *sleepable* for using *spin_lock()*
> 
> IOW, calling a pgtable_alloc() even with GFP_ATOMIC
> doesn't allow in __linear_map_split_to_pte() executed by stopper thread
> where preemption is disabled in PREEMPR_RT.
> 
> To address this, divide linear_map_maybe_split_ptes:
>    - collect number of pages to require for spliting.

COLLECT step

>    - allocate the required number of pages for spliting.

PREALLOC step

>    - with pre-allocate page, split the linear map.

SPLIT step

The steps you have below are confusing :)

> +enum split_modes {

Is it a "mode" or a "step" ?

enum split_step {
	SPLIT_STEP_COLLECT,
	...
};


But reading the code below I am lost how these modes apply here.

I guess what you mean is something like

enum split_mode {
	SPLIT_MODE_ALLOC, /* ... from the buddy. */
	SPLIT_MODE_PREALLOCATED, /* ... from preallocated buffer. */
	SPLIT_MODE_COLLECT, /* collect required page tables. */
};

But why is SPLIT_MODE_ALLOC vs. SPLIT_MODE_PREALLOCATED required?

Can't we just test if there is something in the preallocated buffer, and 
if not, simply allocate?

IOW, all you need is "collect vs. alloc", and the buffer information 
tells you how to allocate.

> +	SPLIT_ALLOC,
> +	SPLIT_PREALLOC,
> +	SPLIT_COLLECT,
> +};
>   
> -	pa = page_to_phys(ptdesc_page(ptdesc));
> +struct split_args {
> +	enum split_modes mode;
> +	union {
> +		struct {
> +			unsigned long nr;
> +			unsigned long i;
> +			struct page **pages;
> +		};
> +		gfp_t gfp;
> +	};
> +};
>   
> +static __always_inline void __pgd_pgtable_init(struct mm_struct *mm,
> +					       struct ptdesc *ptdesc,
> +					       enum pgtable_type pgtable_type)
> +{
>   	switch (pgtable_type) {
>   	case TABLE_PTE:
>   		BUG_ON(!pagetable_pte_ctor(mm, ptdesc));
> @@ -554,19 +564,56 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>   		break;
>   	}
>   
> +}
> +
> +static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
> +				       enum pgtable_type pgtable_type)
> +{
> +	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> +	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> +	phys_addr_t pa;
> +
> +	if (!ptdesc)
> +		return INVALID_PHYS_ADDR;
> +
> +	pa = page_to_phys(ptdesc_page(ptdesc));
> +
> +	__pgd_pgtable_init(mm, ptdesc, pgtable_type);
> +
>   	return pa;
>   }
>   
> +static phys_addr_t __pgd_pgtable_prealloc(struct mm_struct *mm,
> +					  struct split_args *split_args,
> +					  enum pgtable_type pgtable_type)

The function is called "_prealloc" but actually it simply grabs a 
preallocated page. Confusing.


Should this function be called something like 
"__pgd_pgtable_get_preallocated()". Not sure.

> +{
> +	struct page *page;
> +
> +	BUG_ON(split_args->i >= split_args->nr);

No BUG_ON().

> +
> +	page = split_args->pages[split_args->i++];
> +	if (!page)
> +		return INVALID_PHYS_ADDR;
> +
> +	__pgd_pgtable_init(mm, page_ptdesc(page), pgtable_type);
> +
> +	return page_to_phys(page);
> +}
> +
>   static phys_addr_t
> -pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
> +pgd_pgtable_alloc_split(enum pgtable_type pgtable_type,
> +		        struct split_args *split_args)
>   {
> -	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
> +	if (split_args->mode == SPLIT_ALLOC)
> +		return __pgd_pgtable_alloc(&init_mm, split_args->gfp, pgtable_type);
> +
> +	return __pgd_pgtable_prealloc(&init_mm, split_args, pgtable_type);
>   }
>   
>   static phys_addr_t __maybe_unused
>   pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>   {
> -	return pgd_pgtable_alloc_init_mm_gfp(pgtable_type, GFP_PGTABLE_KERNEL);
> +	return __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
>   }
>   
>   static phys_addr_t
> @@ -584,7 +631,9 @@ static void split_contpte(pte_t *ptep)
>   		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>   }
>   
> -static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> +static int split_pmd(pmd_t *pmdp, pmd_t pmd,
> +		     struct split_args *split_args,
> +		     bool to_cont)
>   {
>   	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
>   	unsigned long pfn = pmd_pfn(pmd);
> @@ -593,7 +642,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>   	pte_t *ptep;
>   	int i;
>   
> -	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
> +	pte_phys = pgd_pgtable_alloc_split(TABLE_PTE, split_args);
>   	if (pte_phys == INVALID_PHYS_ADDR)
>   		return -ENOMEM;
>   	ptep = (pte_t *)phys_to_virt(pte_phys);
> @@ -628,7 +677,9 @@ static void split_contpmd(pmd_t *pmdp)
>   		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>   }
>   
> -static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
> +static int split_pud(pud_t *pudp, pud_t pud,
> +		    struct split_args *split_args,
> +		    bool to_cont)
>   {
>   	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
>   	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
> @@ -638,7 +689,7 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>   	pmd_t *pmdp;
>   	int i;
>   
> -	pmd_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PMD, gfp);
> +	pmd_phys = pgd_pgtable_alloc_split(TABLE_PMD, split_args);
>   	if (pmd_phys == INVALID_PHYS_ADDR)
>   		return -ENOMEM;
>   	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
> @@ -672,6 +723,10 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>   	pmd_t *pmdp, pmd;
>   	pte_t *ptep, pte;
>   	int ret = 0;
> +	struct split_args split_args = {
> +		.mode = SPLIT_ALLOC,
> +		.gfp = GFP_PGTABLE_KERNEL,
> +	};
>   
>   	/*
>   	 * PGD: If addr is PGD aligned then addr already describes a leaf
> @@ -707,7 +762,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>   	if (!pud_present(pud))
>   		goto out;
>   	if (pud_leaf(pud)) {
> -		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL, true);
> +		ret = split_pud(pudp, pud, &split_args, true);
>   		if (ret)
>   			goto out;
>   	}
> @@ -732,7 +787,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>   		 */
>   		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
>   			goto out;
> -		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
> +		ret = split_pmd(pmdp, pmd, &split_args, true);
>   		if (ret)
>   			goto out;
>   	}
> @@ -831,12 +886,17 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>   static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
>   				   unsigned long next, struct mm_walk *walk)
>   {
> -	gfp_t gfp = *(gfp_t *)walk->private;
> +	struct split_args *split_args = (struct split_args *)walk->private;
>   	pud_t pud = pudp_get(pudp);
>   	int ret = 0;
>   
> -	if (pud_leaf(pud))
> -		ret = split_pud(pudp, pud, gfp, false);
> +	if (!pud_leaf(pud))
> +		return 0;
> +
> +	if (split_args->mode == SPLIT_COLLECT)
> +		split_args->nr++;
> +	else
> +		ret = split_pud(pudp, pud, split_args, false);
>   
>   	return ret;
>   }
> @@ -844,22 +904,29 @@ static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
>   static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
>   				   unsigned long next, struct mm_walk *walk)
>   {
> -	gfp_t gfp = *(gfp_t *)walk->private;
> +	struct split_args *split_args = (struct split_args *)walk->private;
>   	pmd_t pmd = pmdp_get(pmdp);
> -	int ret = 0;
> +	int ret;
>   
> -	if (pmd_leaf(pmd)) {
> -		if (pmd_cont(pmd))
> -			split_contpmd(pmdp);
> -		ret = split_pmd(pmdp, pmd, gfp, false);
> +	if (!pmd_leaf(pmd))
> +		return 0;
>   
> -		/*
> -		 * We have split the pmd directly to ptes so there is no need to
> -		 * visit each pte to check if they are contpte.
> -		 */
> -		walk->action = ACTION_CONTINUE;
> +	if (split_args->mode == SPLIT_COLLECT) {
> +		split_args->nr++;
> +		return 0;
>   	}
>   
> +	if (pmd_cont(pmd))
> +		split_contpmd(pmdp);
> +	ret = split_pmd(pmdp, pmd, split_args, false);
> +
> +	/*
> +	 * We have split the pmd directly to ptes so there is no need to
> +	 * visit each pte to check if they are contpte.
> +	 */
> +	walk->action = ACTION_CONTINUE;
> +
> +
>   	return ret;
>   }
>   
> @@ -880,13 +947,15 @@ static const struct mm_walk_ops split_to_ptes_ops = {
>   	.pte_entry	= split_to_ptes_pte_entry,
>   };
>   
> -static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
> +static int range_split_to_ptes(unsigned long start, unsigned long end,
> +		 	       struct split_args *split_args)
>   {
>   	int ret;
>   
>   	arch_enter_lazy_mmu_mode();
>   	ret = walk_kernel_page_table_range_lockless(start, end,
> -					&split_to_ptes_ops, NULL, &gfp);
> +						    &split_to_ptes_ops, NULL,
> +						    split_args);
>   	arch_leave_lazy_mmu_mode();
>   
>   	return ret;
> @@ -903,7 +972,7 @@ static void __init init_idmap_kpti_bbml2_flag(void)
>   	smp_mb();
>   }
>   
> -static int __init linear_map_split_to_ptes(void *__unused)
> +static int __init linear_map_split_to_ptes(void *data)
>   {
>   	/*
>   	 * Repainting the linear map must be done by CPU0 (the boot CPU) because
> @@ -911,6 +980,7 @@ static int __init linear_map_split_to_ptes(void *__unused)
>   	 * be held in a waiting area with the idmap active.
>   	 */
>   	if (!smp_processor_id()) {
> +		struct split_args *split_args = data;
>   		unsigned long lstart = _PAGE_OFFSET(vabits_actual);
>   		unsigned long lend = PAGE_END;
>   		unsigned long kstart = (unsigned long)lm_alias(_stext);
> @@ -928,12 +998,13 @@ static int __init linear_map_split_to_ptes(void *__unused)
>   		 * PTE. The kernel alias remains static throughout runtime so
>   		 * can continue to be safely mapped with large mappings.
>   		 */
> -		ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
> +		ret = range_split_to_ptes(lstart, lend, split_args);
>   		if (!ret)
> -			ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
> +			ret = range_split_to_ptes(kstart, kend, split_args);
>   		if (ret)
>   			panic("Failed to split linear map\n");
> -		flush_tlb_kernel_range(lstart, lend);
> +		if (split_args->mode != SPLIT_COLLECT)
> +			flush_tlb_kernel_range(lstart, lend);
>   
>   		/*
>   		 * Relies on dsb in flush_tlb_kernel_range() to avoid reordering
> @@ -963,10 +1034,61 @@ static int __init linear_map_split_to_ptes(void *__unused)
>   
>   void __init linear_map_maybe_split_to_ptes(void)
>   {
> -	if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort()) {
> -		init_idmap_kpti_bbml2_flag();
> -		stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
> +	struct page **pages = NULL;
> +	struct split_args split_args;
> +	int order;
> +	int nr_populated;
> +	int err;
> +
> +	if (!linear_map_requires_bbml2 || system_supports_bbml2_noabort())
> +		return;
> +
> +	/*
> +	 * Phase 1: Collect required extra pages to split.
> +	 */
> +	split_args.mode = SPLIT_COLLECT;
> +	split_args.nr = 0;
> +
> +	init_idmap_kpti_bbml2_flag();
> +	stop_machine(linear_map_split_to_ptes, &split_args, cpu_online_mask);
> +
> +	/*
> +	 * Phase 2: Allocate necessary pages to split.
> +	 */
> +	if (split_args.nr == 0) {
> +		err = 0;
> +		split_args.mode = SPLIT_ALLOC;
> +	} else {
> +		err = -ENOMEM;
> +		order = order_base_2(PAGE_ALIGN(split_args.nr *
> +					sizeof(struct page *)) >> PAGE_SHIFT);
> +
> +		pages = (struct page **)__get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
> +		if (!pages)
> +			goto error;
> +
> +		nr_populated = alloc_pages_bulk(GFP_ATOMIC | __GFP_ZERO, split_args.nr, pages);
> +		if (nr_populated < split_args.nr)
> +			goto error;

That is prone to cause trouble in the future once we allocate memdescs 
separately.

Can we simply call pagetable_alloc() in a loop here instead for the time 
being? A future-proof bulk allocation can be done later separately.

-- 
Cheers

David
