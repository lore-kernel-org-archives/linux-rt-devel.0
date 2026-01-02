Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0087C24A05D
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Jan 2026 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366559; cv=none; b=AluC18KbW2yGurtBrn0ucXo/rkT04W6tNOHJM5XxSuncCkdq4exMFDTmHCN7WhEKPYAOHK9wngm28fRYBpOdw9wyw/bEZgZKQaFPyqQICIaMvQL4+2bzeWKERTLDMdyR/9aF/LUmgM3OSZXErQR59V/ax97ccfP2XJv/5F2HHjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366559; c=relaxed/simple;
	bh=pE7l7ZGNHGoAo69MkgNtsOEtyJAFXcks8HAkfhuT3nE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JIJil3NnAaiSU6w9eZB8rLcXYyraF79aa3UAH+fwdZTfUI/zCfeLobxuoW4QSUt+XsZpsxdozLoHWzNkDoe4mlnAEuxJ4NEB6dc+z37augiSaNu7tutGveybnGPLCL+6zJA6DCAZtWTTfgM/W/sQkpIAqlEqqoYS31zGYhutXfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D3141424;
	Fri,  2 Jan 2026 07:09:10 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 643B73F5A1;
	Fri,  2 Jan 2026 07:09:14 -0800 (PST)
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
Subject: [PATCH v4 3/3] arm64: mmu: avoid allocating pages while installing ng-mapping for KPTI
Date: Fri,  2 Jan 2026 15:07:36 +0000
Message-Id: <20260102150736.1378818-4-yeoreum.yun@arm.com>
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

The current __kpti_install_ng_mappings() allocates a temporary PGD
while installing the NG mapping for KPTI under stop_machine(),
using GFP_ATOMIC.

This is fine in the non-PREEMPT_RT case. However, it becomes a problem
under PREEMPT_RT because generic memory allocation/free APIs
(e.g., pgtable_alloc(), __get_free_pages(), etc.) cannot be invoked
in a non-preemptible context, except for the *_nolock() variants.
These generic allocators may sleep due to their use of spin_lock().

In other words, calling __get_free_pages(), even with GFP_ATOMIC,
is not allowed in __kpti_install_ng_mappings(), which is executed by
the stopper thread where preemption is disabled under PREEMPT_RT.

To address this, preallocate the page needed for the temporary PGD
before invoking __kpti_install_ng_mappings() via stop_machine().

Fixes: 47546a1912fc ("arm64: mm: install KPTI nG mappings with MMU enabled")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/mm/mmu.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index cc086e91a506..7a7804dba381 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1362,7 +1362,7 @@ static phys_addr_t __init kpti_ng_pgd_alloc(enum pgtable_type type)
 	return kpti_ng_temp_alloc;
 }
 
-static int __init __kpti_install_ng_mappings(void *__unused)
+static int __init __kpti_install_ng_mappings(void *data)
 {
 	typedef void (kpti_remap_fn)(int, int, phys_addr_t, unsigned long);
 	extern kpti_remap_fn idmap_kpti_install_ng_mappings;
@@ -1370,10 +1370,9 @@ static int __init __kpti_install_ng_mappings(void *__unused)
 
 	int cpu = smp_processor_id();
 	int levels = CONFIG_PGTABLE_LEVELS;
-	int order = order_base_2(levels);
 	u64 kpti_ng_temp_pgd_pa = 0;
 	pgd_t *kpti_ng_temp_pgd;
-	u64 alloc = 0;
+	u64 alloc = *(u64 *)data;
 
 	if (levels == 5 && !pgtable_l5_enabled())
 		levels = 4;
@@ -1384,8 +1383,6 @@ static int __init __kpti_install_ng_mappings(void *__unused)
 
 	if (!cpu) {
 		int ret;
-
-		alloc = __get_free_pages(GFP_ATOMIC | __GFP_ZERO, order);
 		kpti_ng_temp_pgd = (pgd_t *)(alloc + (levels - 1) * PAGE_SIZE);
 		kpti_ng_temp_alloc = kpti_ng_temp_pgd_pa = __pa(kpti_ng_temp_pgd);
 
@@ -1416,16 +1413,16 @@ static int __init __kpti_install_ng_mappings(void *__unused)
 	remap_fn(cpu, num_online_cpus(), kpti_ng_temp_pgd_pa, KPTI_NG_TEMP_VA);
 	cpu_uninstall_idmap();
 
-	if (!cpu) {
-		free_pages(alloc, order);
+	if (!cpu)
 		arm64_use_ng_mappings = true;
-	}
 
 	return 0;
 }
 
 void __init kpti_install_ng_mappings(void)
 {
+	int order = order_base_2(CONFIG_PGTABLE_LEVELS);
+	u64 alloc;
 	/* Check whether KPTI is going to be used */
 	if (!arm64_kernel_unmapped_at_el0())
 		return;
@@ -1438,8 +1435,14 @@ void __init kpti_install_ng_mappings(void)
 	if (arm64_use_ng_mappings)
 		return;
 
+	alloc = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
+	if (!alloc)
+		panic("Failed to alloc page tables\n");
+
 	init_idmap_kpti_bbml2_flag();
-	stop_machine(__kpti_install_ng_mappings, NULL, cpu_online_mask);
+	stop_machine(__kpti_install_ng_mappings, &alloc, cpu_online_mask);
+
+	free_pages(alloc, order);
 }
 
 static pgprot_t __init kernel_exec_prot(void)
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

