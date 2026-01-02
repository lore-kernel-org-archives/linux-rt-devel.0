Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E1F2550AF
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Jan 2026 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366556; cv=none; b=FghHlcWp7riYP9GEHmuDrqa8iJ7SoN+qriM5ukiTHzt2wFx3wQkoOwLTo0gQTA1e5dqa5acLat1nZpsIPaK9fFL08E7A3xzjeTrrr4s/JhAzwfWynw7+Rz2i0yuRQ9C9N6wyKtkj8bupxucVTozXDbnjScDKRknVColl2GG6bfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366556; c=relaxed/simple;
	bh=i3bN1BAlzPmRqJ/yw8Ezyy1vzWqr7wjP1FxEKlEFgMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XGDeKYXRkY0iBnNBvXOHgU1jBz515MqHfP496VawFi9XlyrqLAh9hXbetB/TUAtDIwvV3wTrVzg2+/RB5deHz6veZeZ77P7g2DBRg4gOdOqy2o6KM2Ae8+JLmVplnsjhjzvhYvdIWp8BSrhDGeTneuKTXJ0HV6h3yeDjgAu07i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36897497;
	Fri,  2 Jan 2026 07:09:07 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D9EB3F5A1;
	Fri,  2 Jan 2026 07:09:10 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	kevin.brodsky@arm.com,
	quic_zhenhuah@quicinc.com,
	dev.jain@arm.com,
	yang@os.amperecomputing.com,
	chaitanyas.prakash@arm.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	lorenzo.stoakes@oracle.com,
	ardb@kernel.org,
	jackmanb@google.com,
	vbabka@suse.cz,
	mhocko@suse.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 2/3] arm64: mmu: avoid allocating pages while splitting the linear mapping
Date: Fri,  2 Jan 2026 15:07:35 +0000
Message-Id: <20260102150736.1378818-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260102150736.1378818-1-yeoreum.yun@arm.com>
References: <20260102150736.1378818-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linear_map_split_to_ptes() currently allocates page tables while
splitting the linear mapping into PTEs under stop_machine() using GFP_ATOMIC.

This is fine for non-PREEMPT_RT configurations.
However, it becomes problematic on PREEMPT_RT, because
generic memory allocation/free APIs (e.g. pgtable_alloc(), __get_free_pages(), etc.)
cannot be called from a non-preemptible context, except for the _nolock() variants.
This is because generic memory allocation/free paths are sleepable,
as they rely on spin_lock(), which becomes sleepable on PREEMPT_RT.

In other words, even calling pgtable_alloc() with GFP_ATOMIC is not permitted
in __linear_map_split_to_pte() when it is executed by the stopper thread,
 where preemption is disabled on PREEMPT_RT.

To address this, the required number of page tables is first collected
and preallocated, and the preallocated page tables are then used
when splitting the linear mapping in __linear_map_split_to_pte().

Fixes: 3df6979d222b ("arm64: mm: split linear mapping if BBML2 unsupported on secondary CPUs")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/mm/mmu.c | 204 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 166 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 4b4908ae189b..cc086e91a506 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -529,18 +529,14 @@ static void early_create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 		panic("Failed to create page tables\n");
 }
 
-static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
-				       enum pgtable_type pgtable_type)
-{
-	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
-	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
-	phys_addr_t pa;
-
-	if (!ptdesc)
-		return INVALID_PHYS_ADDR;
-
-	pa = page_to_phys(ptdesc_page(ptdesc));
+static struct ptdesc **split_pgtables;
+static unsigned long split_pgtables_count;
+static unsigned long split_pgtables_idx;
 
+static __always_inline void __pgd_pgtable_init(struct mm_struct *mm,
+					       struct ptdesc *ptdesc,
+					       enum pgtable_type pgtable_type)
+{
 	switch (pgtable_type) {
 	case TABLE_PTE:
 		BUG_ON(!pagetable_pte_ctor(mm, ptdesc));
@@ -555,26 +551,49 @@ static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
 		pagetable_p4d_ctor(ptdesc);
 		break;
 	}
-
-	return pa;
 }
 
-static phys_addr_t
-pgd_pgtable_alloc_init_mm_gfp(enum pgtable_type pgtable_type, gfp_t gfp)
+static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm,
+				       enum pgtable_type pgtable_type)
 {
-	return __pgd_pgtable_alloc(&init_mm, gfp, pgtable_type);
+	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
+	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
+
+	if (!ptdesc)
+		return INVALID_PHYS_ADDR;
+
+	__pgd_pgtable_init(mm, ptdesc, pgtable_type);
+
+	return page_to_phys(ptdesc_page(ptdesc));
 }
 
-static phys_addr_t __maybe_unused
+static phys_addr_t
 pgd_pgtable_alloc_init_mm(enum pgtable_type pgtable_type)
 {
-	return pgd_pgtable_alloc_init_mm_gfp(pgtable_type, GFP_PGTABLE_KERNEL);
+	return __pgd_pgtable_alloc(&init_mm, pgtable_type);
 }
 
 static phys_addr_t
 pgd_pgtable_alloc_special_mm(enum pgtable_type pgtable_type)
 {
-	return  __pgd_pgtable_alloc(NULL, GFP_PGTABLE_KERNEL, pgtable_type);
+	return  __pgd_pgtable_alloc(NULL, pgtable_type);
+}
+
+static phys_addr_t
+pgd_pgtable_get_preallocated(enum pgtable_type pgtable_type)
+{
+	struct ptdesc *ptdesc;
+
+	if (WARN_ON(split_pgtables_idx >= split_pgtables_count))
+		return INVALID_PHYS_ADDR;
+
+	ptdesc = split_pgtables[split_pgtables_idx++];
+	if (!ptdesc)
+		return INVALID_PHYS_ADDR;
+
+	__pgd_pgtable_init(&init_mm, ptdesc, pgtable_type);
+
+	return page_to_phys(ptdesc_page(ptdesc));
 }
 
 static void split_contpte(pte_t *ptep)
@@ -586,7 +605,9 @@ static void split_contpte(pte_t *ptep)
 		__set_pte(ptep, pte_mknoncont(__ptep_get(ptep)));
 }
 
-static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
+static int split_pmd(pmd_t *pmdp, pmd_t pmd,
+		     pgtable_alloc_t pgtable_alloc,
+		     bool to_cont)
 {
 	pmdval_t tableprot = PMD_TYPE_TABLE | PMD_TABLE_UXN | PMD_TABLE_AF;
 	unsigned long pfn = pmd_pfn(pmd);
@@ -595,7 +616,7 @@ static int split_pmd(pmd_t *pmdp, pmd_t pmd, gfp_t gfp, bool to_cont)
 	pte_t *ptep;
 	int i;
 
-	pte_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PTE, gfp);
+	pte_phys = pgtable_alloc(TABLE_PTE);
 	if (pte_phys == INVALID_PHYS_ADDR)
 		return -ENOMEM;
 	ptep = (pte_t *)phys_to_virt(pte_phys);
@@ -630,7 +651,9 @@ static void split_contpmd(pmd_t *pmdp)
 		set_pmd(pmdp, pmd_mknoncont(pmdp_get(pmdp)));
 }
 
-static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
+static int split_pud(pud_t *pudp, pud_t pud,
+		     pgtable_alloc_t pgtable_alloc,
+		     bool to_cont)
 {
 	pudval_t tableprot = PUD_TYPE_TABLE | PUD_TABLE_UXN | PUD_TABLE_AF;
 	unsigned int step = PMD_SIZE >> PAGE_SHIFT;
@@ -640,7 +663,7 @@ static int split_pud(pud_t *pudp, pud_t pud, gfp_t gfp, bool to_cont)
 	pmd_t *pmdp;
 	int i;
 
-	pmd_phys = pgd_pgtable_alloc_init_mm_gfp(TABLE_PMD, gfp);
+	pmd_phys = pgtable_alloc(TABLE_PMD);
 	if (pmd_phys == INVALID_PHYS_ADDR)
 		return -ENOMEM;
 	pmdp = (pmd_t *)phys_to_virt(pmd_phys);
@@ -709,7 +732,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 	if (!pud_present(pud))
 		goto out;
 	if (pud_leaf(pud)) {
-		ret = split_pud(pudp, pud, GFP_PGTABLE_KERNEL, true);
+		ret = split_pud(pudp, pud, pgd_pgtable_alloc_init_mm, true);
 		if (ret)
 			goto out;
 	}
@@ -734,7 +757,7 @@ static int split_kernel_leaf_mapping_locked(unsigned long addr)
 		 */
 		if (ALIGN_DOWN(addr, PMD_SIZE) == addr)
 			goto out;
-		ret = split_pmd(pmdp, pmd, GFP_PGTABLE_KERNEL, true);
+		ret = split_pmd(pmdp, pmd, pgd_pgtable_alloc_init_mm, true);
 		if (ret)
 			goto out;
 	}
@@ -832,12 +855,12 @@ int split_kernel_leaf_mapping(unsigned long start, unsigned long end)
 static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
 				   unsigned long next, struct mm_walk *walk)
 {
-	gfp_t gfp = *(gfp_t *)walk->private;
+	pgtable_alloc_t *pgtable_alloc = walk->private;
 	pud_t pud = pudp_get(pudp);
 	int ret = 0;
 
 	if (pud_leaf(pud))
-		ret = split_pud(pudp, pud, gfp, false);
+		ret = split_pud(pudp, pud, pgtable_alloc, false);
 
 	return ret;
 }
@@ -845,14 +868,14 @@ static int split_to_ptes_pud_entry(pud_t *pudp, unsigned long addr,
 static int split_to_ptes_pmd_entry(pmd_t *pmdp, unsigned long addr,
 				   unsigned long next, struct mm_walk *walk)
 {
-	gfp_t gfp = *(gfp_t *)walk->private;
+	pgtable_alloc_t *pgtable_alloc = walk->private;
 	pmd_t pmd = pmdp_get(pmdp);
 	int ret = 0;
 
 	if (pmd_leaf(pmd)) {
 		if (pmd_cont(pmd))
 			split_contpmd(pmdp);
-		ret = split_pmd(pmdp, pmd, gfp, false);
+		ret = split_pmd(pmdp, pmd, pgtable_alloc, false);
 
 		/*
 		 * We have split the pmd directly to ptes so there is no need to
@@ -881,13 +904,15 @@ static const struct mm_walk_ops split_to_ptes_ops = {
 	.pte_entry	= split_to_ptes_pte_entry,
 };
 
-static int range_split_to_ptes(unsigned long start, unsigned long end, gfp_t gfp)
+static int range_split_to_ptes(unsigned long start, unsigned long end,
+			       pgtable_alloc_t pgtable_alloc)
 {
 	int ret;
 
 	arch_enter_lazy_mmu_mode();
 	ret = walk_kernel_page_table_range_lockless(start, end,
-					&split_to_ptes_ops, NULL, &gfp);
+						    &split_to_ptes_ops, NULL,
+						    pgtable_alloc);
 	arch_leave_lazy_mmu_mode();
 
 	return ret;
@@ -904,6 +929,103 @@ static void __init init_idmap_kpti_bbml2_flag(void)
 	smp_mb();
 }
 
+static int __init
+collect_to_split_pud_entry(pud_t *pudp, unsigned long addr,
+			   unsigned long next, struct mm_walk *walk)
+{
+	pud_t pud = pudp_get(pudp);
+
+	if (pud_leaf(pud)) {
+		split_pgtables_count += 1 + PTRS_PER_PMD;
+		walk->action = ACTION_CONTINUE;
+	}
+
+	return 0;
+}
+
+static int __init
+collect_to_split_pmd_entry(pmd_t *pmdp, unsigned long addr,
+			   unsigned long next, struct mm_walk *walk)
+{
+	pmd_t pmd = pmdp_get(pmdp);
+
+	if (pmd_leaf(pmd))
+		split_pgtables_count++;
+
+	walk->action = ACTION_CONTINUE;
+
+	return 0;
+}
+
+static void __init linear_map_free_split_pgtables(void)
+{
+	int i;
+
+	if (!split_pgtables_count || !split_pgtables)
+		goto skip_free;
+
+	for (i = split_pgtables_idx; i < split_pgtables_count; i++) {
+		if (split_pgtables[i])
+			pagetable_free(split_pgtables[i]);
+	}
+
+	kvfree(split_pgtables);
+
+skip_free:
+	split_pgtables = NULL;
+	split_pgtables_count = 0;
+	split_pgtables_idx = 0;
+}
+
+static int __init linear_map_prealloc_split_pgtables(void)
+{
+	int ret, i;
+	unsigned long lstart = _PAGE_OFFSET(vabits_actual);
+	unsigned long lend = PAGE_END;
+	unsigned long kstart = (unsigned long)lm_alias(_stext);
+	unsigned long kend = (unsigned long)lm_alias(__init_begin);
+
+	const struct mm_walk_ops collect_to_split_ops = {
+		.pud_entry	= collect_to_split_pud_entry,
+		.pmd_entry	= collect_to_split_pmd_entry
+	};
+
+	split_pgtables_idx = 0;
+	split_pgtables_count = 0;
+
+	ret = walk_kernel_page_table_range_lockless(lstart, kstart,
+						    &collect_to_split_ops,
+						    NULL, NULL);
+	if (!ret)
+		ret = walk_kernel_page_table_range_lockless(kend, lend,
+							    &collect_to_split_ops,
+							    NULL, NULL);
+	if (ret || !split_pgtables_count)
+		goto error;
+
+	ret = -ENOMEM;
+
+	split_pgtables = kvmalloc(split_pgtables_count * sizeof(struct ptdesc *),
+				  GFP_KERNEL | __GFP_ZERO);
+	if (!split_pgtables)
+		goto error;
+
+	for (i = 0; i < split_pgtables_count; i++) {
+		/* The page table will be filled during splitting, so zeroing it is unnecessary. */
+		split_pgtables[i] = pagetable_alloc(GFP_PGTABLE_KERNEL & ~__GFP_ZERO, 0);
+		if (!split_pgtables[i])
+			goto error;
+	}
+
+	ret = 0;
+
+error:
+	if (ret)
+		linear_map_free_split_pgtables();
+
+	return ret;
+}
+
 static int __init linear_map_split_to_ptes(void *__unused)
 {
 	/*
@@ -929,9 +1051,9 @@ static int __init linear_map_split_to_ptes(void *__unused)
 		 * PTE. The kernel alias remains static throughout runtime so
 		 * can continue to be safely mapped with large mappings.
 		 */
-		ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
+		ret = range_split_to_ptes(lstart, kstart, pgd_pgtable_get_preallocated);
 		if (!ret)
-			ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
+			ret = range_split_to_ptes(kend, lend, pgd_pgtable_get_preallocated);
 		if (ret)
 			panic("Failed to split linear map\n");
 		flush_tlb_kernel_range(lstart, lend);
@@ -964,10 +1086,16 @@ static int __init linear_map_split_to_ptes(void *__unused)
 
 void __init linear_map_maybe_split_to_ptes(void)
 {
-	if (linear_map_requires_bbml2 && !system_supports_bbml2_noabort()) {
-		init_idmap_kpti_bbml2_flag();
-		stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
-	}
+	if (!linear_map_requires_bbml2 || system_supports_bbml2_noabort())
+		return;
+
+	if (linear_map_prealloc_split_pgtables())
+		panic("Failed to split linear map\n");
+
+	init_idmap_kpti_bbml2_flag();
+	stop_machine(linear_map_split_to_ptes, NULL, cpu_online_mask);
+
+	linear_map_free_split_pgtables();
 }
 
 /*
@@ -1098,7 +1226,7 @@ bool arch_kfence_init_pool(void)
 		return true;
 
 	mutex_lock(&pgtable_split_lock);
-	ret = range_split_to_ptes(start, end, GFP_PGTABLE_KERNEL);
+	ret = range_split_to_ptes(start, end, pgd_pgtable_alloc_init_mm);
 	mutex_unlock(&pgtable_split_lock);
 
 	/*
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

