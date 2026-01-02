Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8421721B9C1
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Jan 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767366554; cv=none; b=dzjvdmke6Nv7HR3Hss9s3xK8Dcz+ksYE3U4YnM3KmXRS+f/ntv89DOJnfoBGOg+TewVbnHn9moRb8i9rzGJpDdmiSyYFQ+ltNND9MKyMc+phHCmlpAlxZwT+2p5WgPCTzKKMX+hgkGQ2GINHr7nfjoHjZI2QQwXkPRPfYIBpwrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767366554; c=relaxed/simple;
	bh=qAxuojgTzMBDTzFFpDNvQCczMgWbQiEpgImEkpPV1IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bTs1tBh25pp8WTbz99tlGr9fyANL69SUs6OJrsoxPigVhlHJ1/jIIBlam4no3S37bPXUdt5M9OcIs0ey7N9J+DNVsITuRXzL8fbTJWklcbxdmZwPPkPLG0RZLRk1jXMpjr8oHu+quNAyQljIgWUfQHtEOZ4vjOA3MtnUh6UqMps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6BA81424;
	Fri,  2 Jan 2026 07:09:03 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA1AB3F5A1;
	Fri,  2 Jan 2026 07:09:07 -0800 (PST)
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
Subject: [PATCH v4 1/3] arm64: mmu: introduce pgtable_alloc_t
Date: Fri,  2 Jan 2026 15:07:34 +0000
Message-Id: <20260102150736.1378818-2-yeoreum.yun@arm.com>
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

This is preparation patch to use preallocated page tables
for linear_map_split_to_ptes().

Define pgtable_alloc_t type for callback used by create_XXX_mapping().

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/arm64/mm/mmu.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8e1d80a7033e..4b4908ae189b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -74,6 +74,8 @@ EXPORT_SYMBOL(empty_zero_page);
 static DEFINE_SPINLOCK(swapper_pgdir_lock);
 static DEFINE_MUTEX(fixmap_lock);
 
+typedef phys_addr_t (pgtable_alloc_t)(enum pgtable_type);
+
 void noinstr set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
 {
 	pgd_t *fixmap_pgdp;
@@ -197,7 +199,7 @@ static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
 static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 			       unsigned long end, phys_addr_t phys,
 			       pgprot_t prot,
-			       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
+			       pgtable_alloc_t pgtable_alloc,
 			       int flags)
 {
 	unsigned long next;
@@ -252,7 +254,7 @@ static int alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
 
 static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 		    phys_addr_t phys, pgprot_t prot,
-		    phys_addr_t (*pgtable_alloc)(enum pgtable_type), int flags)
+		    pgtable_alloc_t pgtable_alloc, int flags)
 {
 	unsigned long next;
 
@@ -292,7 +294,7 @@ static int init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
 static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 			       unsigned long end, phys_addr_t phys,
 			       pgprot_t prot,
-			       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
+			       pgtable_alloc_t pgtable_alloc,
 			       int flags)
 {
 	int ret;
@@ -349,7 +351,7 @@ static int alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
 
 static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 			  phys_addr_t phys, pgprot_t prot,
-			  phys_addr_t (*pgtable_alloc)(enum pgtable_type),
+			  pgtable_alloc_t pgtable_alloc,
 			  int flags)
 {
 	int ret = 0;
@@ -415,7 +417,7 @@ static int alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
 
 static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 			  phys_addr_t phys, pgprot_t prot,
-			  phys_addr_t (*pgtable_alloc)(enum pgtable_type),
+			  pgtable_alloc_t pgtable_alloc,
 			  int flags)
 {
 	int ret;
@@ -467,7 +469,7 @@ static int alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
 static int __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 				       unsigned long virt, phys_addr_t size,
 				       pgprot_t prot,
-				       phys_addr_t (*pgtable_alloc)(enum pgtable_type),
+				       pgtable_alloc_t pgtable_alloc,
 				       int flags)
 {
 	int ret;
@@ -500,7 +502,7 @@ static int __create_pgd_mapping_locked(pgd_t *pgdir, phys_addr_t phys,
 static int __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 				unsigned long virt, phys_addr_t size,
 				pgprot_t prot,
-				phys_addr_t (*pgtable_alloc)(enum pgtable_type),
+				pgtable_alloc_t pgtable_alloc,
 				int flags)
 {
 	int ret;
@@ -516,7 +518,7 @@ static int __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 static void early_create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 				     unsigned long virt, phys_addr_t size,
 				     pgprot_t prot,
-				     phys_addr_t (*pgtable_alloc)(enum pgtable_type),
+				     pgtable_alloc_t pgtable_alloc,
 				     int flags)
 {
 	int ret;
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

