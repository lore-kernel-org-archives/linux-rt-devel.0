Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC792874E1
	for <linux-rt-devel@lists.linux.dev>; Thu, 18 Dec 2025 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766067732; cv=none; b=j6JnAOw78ox+DwzkMSp8LgMZdoW2eN7gJaygyqP35sHpArj7xsSD0kRrSRThef8iKamnzHgwEhfGgWfqFdf7IKtBz6CB38Qy2/W2zzr+qUUMGSBK8kZBsiGG+NOAU7QJKZVHAa1IIHIEl3byseDVNYZ1zjsX+ilIGjbopjHC0IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766067732; c=relaxed/simple;
	bh=F8xSNrARdyqqq92L65wfCixBUWUiAhgO1Es0Yd2jrSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=li1lpuPyFyEHs/T8/EHKMQRZi6++m0zv16mh4PnxumJqtPrKzcKxX9cZv3sC0VINzYo5JXVQv3jnaa0N9Zr/3M9GzjPCT8Q7+Xv2odWoKp1NuOLx+b6lw3BWAl9DFUzd8vdOt4HeKNddpEx6u4hYpFKHkb+VWzUT1Bz6frYbOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72105FEC;
	Thu, 18 Dec 2025 06:22:02 -0800 (PST)
Received: from [10.1.39.180] (unknown [10.1.39.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A04FF3F762;
	Thu, 18 Dec 2025 06:22:06 -0800 (PST)
Message-ID: <73ced1db-a2e2-49ea-927e-9fc4a30e771e@arm.com>
Date: Thu, 18 Dec 2025 14:22:05 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: mmu: don't allocate page while spliting
 linear mapping
Content-Language: en-GB
To: Yeoreum Yun <yeoreum.yun@arm.com>, catalin.marinas@arm.com,
 will@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com, dev.jain@arm.com,
 yang@os.amperecomputing.com, chaitanyas.prakash@arm.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 lorenzo.stoakes@oracle.com, ardb@kernel.org, jackmanb@google.com,
 vbabka@suse.cz
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20251217182007.2345700-1-yeoreum.yun@arm.com>
 <20251217182007.2345700-2-yeoreum.yun@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20251217182007.2345700-2-yeoreum.yun@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/12/2025 18:20, Yeoreum Yun wrote:
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
>   - collect number of pages to require for spliting.
>   - allocate the required number of pages for spliting.
>   - with pre-allocate page, split the linear map.

Thanks for working on this fix!

First some high level comments: I'm not a huge fan of the approach with the
different modes to modify behaviour.

For the first step of figuring out the number of pages required; there is no
need to be inside stop_machine() for that. Can should be able to just walk the
linear map without any locking since it is created once and remains static, with
the exception of hotplug, but that is not enabled yet.

I think it would be cleaner to just create separate walker callbacks rather than
repurpose the existing walker.

Then you could simply change the gfp flag to a callback function pointer and
pass the desired allocator as a function pointer. This would match the existing
patterns used in mmu.c today.

The preallocated page list could be stored in a global static variable and you
could create an allocation function that just strims a page from that list. See
kpti_ng_pgd_alloc() for an existing example. That assumes a contiguous block,
but you could generalize it to hold a list of struct pages and reuse it for both
cases?


> 
> Fixes: 3df6979d222b ("arm64: mm: split linear mapping if BBML2 unsupported on secondary CPUs")
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 213 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 170 insertions(+), 43 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 9ae7ce00a7ef..e4e6c7e0a016 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -527,18 +527,28 @@ static void early_create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
>  		panic("Failed to create page tables\n");
>  }
>  
> -static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
> -				       enum pgtable_type pgtable_type)
> -{
> -	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
> -	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
> -	phys_addr_t pa;
> -
> -	if (!ptdesc)
> -		return INVALID_PHYS_ADDR;
> +enum split_modes {
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
>  	switch (pgtable_type) {
>  	case TABLE_PTE:
>  		BUG_ON(!pagetable_pte_ctor(mm, ptdesc));
> @@ -554,19 +564,56 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
>  		break;
>  	}
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
>  	return pa;
>  }
>  
> +static phys_addr_t __pgd_pgtable_prealloc(struct mm_struct *mm,
> +					  struct split_args *split_args,
> +					  enum pgtable_type pgtable_type)
> +{
> +	struct page *page;
> +
> +	BUG_ON(split_args->i >= split_args->nr);
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
>  static phys_addr_t
> -pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
> +pgd_pgtable_alloc_split(enum pgtable_type pgtable_type,
> +		        struct split_args *split_args)
>  {
> -	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
> +	if (split_args->mode == SPLIT_ALLOC)
> +		return __pgd_pgtable_alloc(&init_mm, split_args->gfp, pgtable_type);
> +
> +	return __pgd_pgtable_prealloc(&init_mm, split_args, pgtable_type);
>  }
>  
>  static phys_addr_t __maybe_unused
>  pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
>  {
> -	return pgd_pgtable_alloc_init_mm_gfp(pgtable_type, GFP_PGTABLE_KERNEL);
> +	return __pgd_pgtable_alloc(&init_mm, GFP_PGTABLE_KERNEL, pgtable_type);
>  }
>  
>  static phys_addr_t
> @@ -584,7 +631,9 @@ static void split_contpte(pte_t *ptep)
>  		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
>  }
>  
> -static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
> +static int split_pmd(pmd_t *pmdp, pmd_t pmd,
> +		     struct split_args *split_args,
> +		     bool to_cont)
>  {
>  	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
>  	unsigned long pfn = pmd_pfn(pmd);
> @@ -593,7 +642,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
>  	pte_t *ptep;
>  	int i;
>  
> -	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
> +	pte_phys = pgd_pgtable_alloc_split(TABLE_PTE, split_args);
>  	if (pte_phys == INVALID_PHYS_ADDR)
>  		return -ENOMEM;
>  	ptep = (pte_t *)phys_to_virt(pte_phys);
> @@ -628,7 +677,9 @@ static void split_contpmd(pmd_t *pmdp)
>  		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
>  }
>  
> -static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
> +static int split_pud(pud_t *pudp, pud_t pud,
> +		    struct split_args *split_args,
> +		    bool to_cont)
>  {
>  	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
>  	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
> @@ -638,7 +689,7 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
>  	pmd_t *pmdp;
>  	int i;
>  
> -	pmd_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PMD, gfp);
> +	pmd_phys = pgd_pgtable_alloc_split(TABLE_PMD, split_args);
>  	if (pmd_phys == INVALID_PHYS_ADDR)
>  		return -ENOMEM;
>  	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
> @@ -672,6 +723,10 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>  	pmd_t *pmdp, pmd;
>  	pte_t *ptep, pte;
>  	int ret = 0;
> +	struct split_args split_args = {
> +		.mode = SPLIT_ALLOC,
> +		.gfp = GFP_PGTABLE_KERNEL,
> +	};
>  
>  	/*
>  	 * PGD: If addr is PGD aligned then addr already describes a leaf
> @@ -707,7 +762,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>  	if (!pud_present(pud))
>  		goto out;
>  	if (pud_leaf(pud)) {
> -		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL, true);
> +		ret = split_pud(pudp, pud, &split_args, true);
>  		if (ret)
>  			goto out;
>  	}
> @@ -732,7 +787,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
>  		 */
>  		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
>  			goto out;
> -		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
> +		ret = split_pmd(pmdp, pmd, &split_args, true);
>  		if (ret)
>  			goto out;
>  	}
> @@ -831,12 +886,17 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
>  static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
>  				   unsigned long next, struct mm_walk *walk)
>  {
> -	gfp_t gfp = *(gfp_t *)walk->private;
> +	struct split_args *split_args = (struct split_args *)walk->private;

no need for the casting here; it's a void *.

>  	pud_t pud = pudp_get(pudp);
>  	int ret = 0;
>  
> -	if (pud_leaf(pud))
> -		ret = split_pud(pudp, pud, gfp, false);
> +	if (!pud_leaf(pud))
> +		return 0;
> +
> +	if (split_args->mode == SPLIT_COLLECT)
> +		split_args->nr++;

bug: you're incrementing this for the pmd table that you would have inserted,
but because you're not actually splitting, split_to_ptes_pmd_entry() will never
be called for the 512 pte tables you also need. So you need:

		nr += 1 + PTRS_PER_PMD;

I'm guessing you didn't test this as the BUG would have triggered when you ran
out of preallocated memory?

> +	else
> +		ret = split_pud(pudp, pud, split_args, false);
>  
>  	return ret;
>  }
> @@ -844,22 +904,29 @@ static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
>  static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
>  				   unsigned long next, struct mm_walk *walk)
>  {
> -	gfp_t gfp = *(gfp_t *)walk->private;
> +	struct split_args *split_args = (struct split_args *)walk->private;
>  	pmd_t pmd = pmdp_get(pmdp);
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
>  	}
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
>  	return ret;
>  }
>  
> @@ -880,13 +947,15 @@ static const struct mm_walk_ops split_to_ptes_ops = {
>  	.pte_entry	= split_to_ptes_pte_entry,
>  };
>  
> -static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
> +static int range_split_to_ptes(unsigned long start, unsigned long end,
> +		 	       struct split_args *split_args)
>  {
>  	int ret;
>  
>  	arch_enter_lazy_mmu_mode();
>  	ret = walk_kernel_page_table_range_lockless(start, end,
> -					&split_to_ptes_ops, NULL, &gfp);
> +						    &split_to_ptes_ops, NULL,
> +						    split_args);
>  	arch_leave_lazy_mmu_mode();
>  
>  	return ret;
> @@ -903,7 +972,7 @@ static void __init init_idmap_kpti_bbml2_flag(void)
>  	smp_mb();
>  }
>  
> -static int __init linear_map_split_to_ptes(void *__unused)
> +static int __init linear_map_split_to_ptes(void *data)
>  {
>  	/*
>  	 * Repainting the linear map must be done by CPU0 (the boot CPU) because
> @@ -911,6 +980,7 @@ static int __init linear_map_split_to_ptes(void *__unused)
>  	 * be held in a waiting area with the idmap active.
>  	 */
>  	if (!smp_processor_id()) {
> +		struct split_args *split_args = data;
>  		unsigned long lstart = _PAGE_OFFSET(vabits_actual);
>  		unsigned long lend = PAGE_END;
>  		unsigned long kstart = (unsigned long)lm_alias(_stext);
> @@ -928,12 +998,13 @@ static int __init linear_map_split_to_ptes(void *__unused)
>  		 * PTE. The kernel alias remains static throughout runtime so
>  		 * can continue to be safely mapped with large mappings.
>  		 */
> -		ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
> +		ret = range_split_to_ptes(lstart, lend, split_args);
>  		if (!ret)
> -			ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
> +			ret = range_split_to_ptes(kstart, kend, split_args);
>  		if (ret)
>  			panic("Failed to split linear map\n");
> -		flush_tlb_kernel_range(lstart, lend);
> +		if (split_args->mode != SPLIT_COLLECT)
> +			flush_tlb_kernel_range(lstart, lend);
>  
>  		/*
>  		 * Relies on dsb in flush_tlb_kernel_range() to avoid reordering
> @@ -963,10 +1034,61 @@ static int __init linear_map_split_to_ptes(void *__unused)
>  
>  void __init linear_map_maybe_split_to_ptes(void)
>  {
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

This doesn't require stop_machine().

> +
> +	/*
> +	 * Phase 2: Allocate necessary pages to split.
> +	 */
> +	if (split_args.nr == 0) {
> +		err = 0;
> +		split_args.mode = SPLIT_ALLOC;

How would we hit this condition? If everything is already split why not just
exit early?

> +	} else {
> +		err = -ENOMEM;
> +		order = order_base_2(PAGE_ALIGN(split_args.nr *
> +					sizeof(struct page *)) >> PAGE_SHIFT);
> +
> +		pages = (struct page **)__get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);

As per the other patch, I'd prefer to see GFP_KERNEL | __GFP_ZERO here.

Let's make this a list of struct ptdesc * though.


> +		if (!pages)
> +			goto error;
> +
> +		nr_populated = alloc_pages_bulk(GFP_ATOMIC | __GFP_ZERO, split_args.nr, pages);

Just GFP_KERNEL. No need for __GFP_ZERO as they will all be fully overwritten
with PTEs.

I'd prefer to use pagetable_alloc(GFP_KERNEL, 0) in a loop since that will
return a proper ptdesc.

> +		if (nr_populated < split_args.nr)
> +			goto error;
> +
> +		err = 0;
> +		split_args.mode = SPLIT_PREALLOC;
> +		split_args.i = 0;
> +		split_args.pages = pages;
>  	}
> +
> +	/*
> +	 * Phase 3: Split linear map.
> +	 */
> +	init_idmap_kpti_bbml2_flag();
> +	stop_machine(linear_map_split_to_ptes, &split_args, cpu_online_mask);
> +
> +error:
> +	if (pages)
> +		free_pages((unsigned long)pages, order);

It's possible (but unlikely) that another CPU caused a split between figuring
out the required number of tables and actually doing the full split. In this
case, you would have preallocated pages left over that you will need to free here.

Thanks,
Ryan

> +
> +	if (err)
> +		panic("Failed to split linear map: %d\n", err);
>  }
>  
>  /*
> @@ -1087,6 +1209,11 @@ bool arch_kfence_init_pool(void)
>  	unsigned long start = (unsigned long)__kfence_pool;
>  	unsigned long end = start + KFENCE_POOL_SIZE;
>  	int ret;
> +	struct split_args split_args = {
> +		.mode = SPLIT_ALLOC,
> +		.gfp = GFP_PGTABLE_KERNEL,
> +	};
> +
>  
>  	/* Exit early if we know the linear map is already pte-mapped. */
>  	if (!split_leaf_mapping_possible())
> @@ -1097,7 +1224,7 @@ bool arch_kfence_init_pool(void)
>  		return true;
>  
>  	mutex_lock(&pgtable_split_lock);
> -	ret = range_split_to_ptes(start, end, GFP_PGTABLE_KERNEL);
> +	ret = range_split_to_ptes(start, end, &split_args);
>  	mutex_unlock(&pgtable_split_lock);
>  
>  	/*

