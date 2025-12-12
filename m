Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C881285CAA
	for <linux-rt-devel@lists.linux.dev>; Fri, 12 Dec 2025 16:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765556333; cv=none; b=TIlZrjRqeU/6oIUz4Q9QAHttOZuqzf9HqenD7ZRbjkdxDgfQsI+ewBvRhQUlY/YZGupzdEHaJKeIpBLq9DVjr7UY/JVOVMnxOc4X9MxkhnBtGI/wFA3NsSXBhDH3EXFT5l1/ma3w4/QhHokYD5xZczh7EV3IRjElSzsKPKxl3Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765556333; c=relaxed/simple;
	bh=gmiQZLMT0fRlOSVxSZUWZCPHVxcx6pgW8SlQPB5xtKw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AopT7zH3YucZm2DQwoq6kCTW0wYVHOmx/OkKDChIug6uBRTidYuX2yhAt0q+UyEgd0pddC+v5qOrzwUn42FpB5CopVCR26qN/DWtLsWQThlUVKFca6pWX4DrReuA1dHy2SE/AvZbMnF2ykqrMRW7aB9BR2CzSRHMjPy+Y6H8GpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81B46165C;
	Fri, 12 Dec 2025 08:18:43 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AC4203F762;
	Fri, 12 Dec 2025 08:18:45 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	ryan.roberts@arm.com,
	kevin.brodsky@arm.com,
	dev.jain@arm.com,
	yang@os.amperecomputing.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH 2/2] arm64: mmu: use pagetable_alloc_nolock() while stop_machine()
Date: Fri, 12 Dec 2025 16:18:32 +0000
Message-Id: <20251212161832.2067134-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251212161832.2067134-1-yeoreum.yun@arm.com>
References: <20251212161832.2067134-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

linear_map_split_to_ptes() and __kpti_install_ng_mappings()
are called as callback of stop_machine().
That means these functions context are preemption disabled.

Unfortunately, under PREEMPT_RT, the pagetable_alloc() or
__get_free_pages() couldn't be called in this context
since spin lock that becomes sleepable on RT,
potentially causing a sleep during page allocation.

To address this, pagetable_alloc_nolock().

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/mm/mmu.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 2ba01dc8ef82..0e98606d8c4c 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -475,10 +475,15 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
 				       enum pgtable_type pgtable_type)
 {
-	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
-	struct ptdesc *ptdesc = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
+	struct ptdesc *ptdesc;
 	phys_addr_t pa;
 
+	/* Page is zeroed by init_clear_pgtable() so don't duplicate effort. */
+	if (gfpflags_allow_spinning(gfp))
+		ptdesc  = pagetable_alloc(gfp & ~__GFP_ZERO, 0);
+	else
+		ptdesc  = pagetable_alloc_nolock(gfp & ~__GFP_ZERO, 0);
+
 	if (!ptdesc)
 		return INVALID_PHYS_ADDR;
 
@@ -869,6 +874,7 @@ static int __init linear_map_split_to_ptes(void *__unused)
 		unsigned long kstart = (unsigned long)lm_alias(_stext);
 		unsigned long kend = (unsigned long)lm_alias(__init_begin);
 		int ret;
+		gfp_t gfp = IS_ENABLED(CONFIG_PREEMPT_RT) ? __GFP_HIGH : GFP_ATOMIC;
 
 		/*
 		 * Wait for all secondary CPUs to be put into the waiting area.
@@ -881,9 +887,9 @@ static int __init linear_map_split_to_ptes(void *__unused)
 		 * PTE. The kernel alias remains static throughout runtime so
 		 * can continue to be safely mapped with large mappings.
 		 */
-		ret = range_split_to_ptes(lstart, kstart, GFP_ATOMIC);
+		ret = range_split_to_ptes(lstart, kstart, gfp);
 		if (!ret)
-			ret = range_split_to_ptes(kend, lend, GFP_ATOMIC);
+			ret = range_split_to_ptes(kend, lend, gfp);
 		if (ret)
 			panic("Failed to split linear map\n");
 		flush_tlb_kernel_range(lstart, lend);
@@ -1207,7 +1213,14 @@ static int __init __kpti_install_ng_mappings(void *__unused)
 	remap_fn = (void *)__pa_symbol(idmap_kpti_install_ng_mappings);
 
 	if (!cpu) {
-		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
+		if (IS_ENABLED(CONFIG_PREEMPT_RT))
+			alloc = (u64) pagetable_alloc_nolock(__GFP_HIGH | __GFP_ZERO, order);
+		else
+			alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
+
+		if (!alloc)
+			panic("Failed to alloc kpti_ng_pgd\n");
+
 		kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
 		kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

