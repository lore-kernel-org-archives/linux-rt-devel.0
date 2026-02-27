Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5632F42DFE8
	for <linux-rt-devel@lists.linux.dev>; Fri, 27 Feb 2026 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772205557; cv=none; b=L3Ofc9gF8CxG6RskM0MzRT15ugS9Ircx8R+9/YHjYf6D1FI6vWdFmk3zDldbbSiI1wFDJ64JwR3bd+dWZh0xGp3ljU/+ypmveRpGLpqPIZYLIGQEYfZJnvsMyfZd18PYpzQXTuPI1MltdGwGajWC6ztSyF4i3s7BLz8C5lZuaXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772205557; c=relaxed/simple;
	bh=II4/WzEQO5kAvZGKHRz5WsXr/3x9dUuHIqw+QPQtvZI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=uNPEfaWIOSB2YPEkT6JOxNhweAlBIj18AOoL02ZsF2UOSU6l0rYz9Jy2BrYTjiJW10HZC9hJfKgLVaJ4MbevcBOwLjV17AdZDBkr03yp3C+8BfgECQ1HMU65dTSuxx+Axn4TIByp7Muj9kmEDcyHgqeZ2O5calTSiQaLN/PS0Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WYz7XY4O; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WYz7XY4O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=3bJxrnrMqHmmchyZ6y1WNMAH5JcYPSY8j6qyvPcwJeY=; b=WYz7XY4OQuZ1w7L/j/uPM+YwvC
	6/EGvMVidGxFm4O92DWtQkTa3pDgkNWHKdJbAi5hiLDk/qSTTiQfJAASQzBbWJgFUEp2Z0o34M9cK
	Lg5WwOFqJUITnr5oK+RbxxmXVIRF2CJSkPB+rgdqjC3axiTcGgowN0GhVbJOaP33DDJfQpndB6oiw
	K+nuVIEkqh9u+3N46IXLNe2uxOJyNM3Mz2JBfWdIj2WEskIN+8vQTSyg5kpqTuSxwfdyr4AuEcGX9
	6HyL+opkoFbqZWSQF5L4wi3SI1KzWqroCWGw88Jk/ZtiNNaeY25wUAWZCGi3mUpqbwwq6g3gpnTRM
	gRGCuPWA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:52958 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1vvzcY-000000000y7-1Dgs;
	Fri, 27 Feb 2026 15:19:14 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1vvzcX-0000000Awo0-2KBN;
	Fri, 27 Feb 2026 15:19:13 +0000
In-Reply-To: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
References: <aaG1wrNUaq_L0I5g@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
Cc: Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 2/6] ARM: move vmalloc() lazy-page table population
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1vvzcX-0000000Awo0-2KBN@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Fri, 27 Feb 2026 15:19:13 +0000

Split the vmalloc() lazy-page table population from
do_translation_fault() into a new vmalloc_fault() function.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mm/fault.c | 126 ++++++++++++++++++++++++--------------------
 1 file changed, 68 insertions(+), 58 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index 6c27ebd49093..0f3b6cc516c1 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -261,6 +261,70 @@ static inline bool ttbr0_usermode_access_allowed(struct pt_regs *regs)
 }
 #endif
 
+/*
+ * Handle a vmalloc fault, copying the non-leaf page table entries from
+ * init_mm.pgd. Any kernel context can trigger this, so we must not sleep
+ * or enable interrupts. Having two CPUs execute this for the same page is
+ * no problem, we'll just copy the same data twice.
+ *
+ * Returns false on failure.
+ */
+static bool __kprobes __maybe_unused vmalloc_fault(unsigned long addr)
+{
+	unsigned int index;
+	pgd_t *pgd, *pgd_k;
+	p4d_t *p4d, *p4d_k;
+	pud_t *pud, *pud_k;
+	pmd_t *pmd, *pmd_k;
+
+	index = pgd_index(addr);
+
+	pgd = cpu_get_pgd() + index;
+	pgd_k = init_mm.pgd + index;
+
+	p4d = p4d_offset(pgd, addr);
+	p4d_k = p4d_offset(pgd_k, addr);
+
+	if (p4d_none(*p4d_k))
+		return false;
+	if (!p4d_present(*p4d))
+		set_p4d(p4d, *p4d_k);
+
+	pud = pud_offset(p4d, addr);
+	pud_k = pud_offset(p4d_k, addr);
+
+	if (pud_none(*pud_k))
+		return false;
+	if (!pud_present(*pud))
+		set_pud(pud, *pud_k);
+
+	pmd = pmd_offset(pud, addr);
+	pmd_k = pmd_offset(pud_k, addr);
+
+#ifdef CONFIG_ARM_LPAE
+	/*
+	 * Only one hardware entry per PMD with LPAE.
+	 */
+	index = 0;
+#else
+	/*
+	 * On ARM one Linux PGD entry contains two hardware entries (see page
+	 * tables layout in pgtable.h). We normally guarantee that we always
+	 * fill both L1 entries. But create_mapping() doesn't follow the rule.
+	 * It can create inidividual L1 entries, so here we have to call
+	 * pmd_none() check for the entry really corresponded to address, not
+	 * for the first of pair.
+	 */
+	index = (addr >> SECTION_SHIFT) & 1;
+#endif
+	if (pmd_none(pmd_k[index]))
+		return false;
+
+	copy_pmd(pmd, pmd_k);
+
+	return true;
+}
+
 static int __kprobes
 do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
 			     unsigned int fsr, struct pt_regs *regs)
@@ -496,10 +560,9 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
  * directly to do_kernel_address_page_fault() to handle.
  *
  * Otherwise, we're probably faulting in the vmalloc() area, so try to fix
- * that up. Note that we must not take any locks or enable interrupts in
- * this case.
+ * that up via vmalloc_fault().
  *
- * If vmalloc() fixup fails, that means the non-leaf page tables did not
+ * If vmalloc_fault() fails, that means the non-leaf page tables did not
  * contain an entry for this address, so handle this via
  * do_kernel_address_page_fault().
  */
@@ -508,65 +571,12 @@ static int __kprobes
 do_translation_fault(unsigned long addr, unsigned int fsr,
 		     struct pt_regs *regs)
 {
-	unsigned int index;
-	pgd_t *pgd, *pgd_k;
-	p4d_t *p4d, *p4d_k;
-	pud_t *pud, *pud_k;
-	pmd_t *pmd, *pmd_k;
-
 	if (addr < TASK_SIZE)
 		return do_page_fault(addr, fsr, regs);
 
-	if (user_mode(regs))
-		goto bad_area;
-
-	index = pgd_index(addr);
-
-	pgd = cpu_get_pgd() + index;
-	pgd_k = init_mm.pgd + index;
-
-	p4d = p4d_offset(pgd, addr);
-	p4d_k = p4d_offset(pgd_k, addr);
-
-	if (p4d_none(*p4d_k))
-		goto bad_area;
-	if (!p4d_present(*p4d))
-		set_p4d(p4d, *p4d_k);
-
-	pud = pud_offset(p4d, addr);
-	pud_k = pud_offset(p4d_k, addr);
-
-	if (pud_none(*pud_k))
-		goto bad_area;
-	if (!pud_present(*pud))
-		set_pud(pud, *pud_k);
-
-	pmd = pmd_offset(pud, addr);
-	pmd_k = pmd_offset(pud_k, addr);
-
-#ifdef CONFIG_ARM_LPAE
-	/*
-	 * Only one hardware entry per PMD with LPAE.
-	 */
-	index = 0;
-#else
-	/*
-	 * On ARM one Linux PGD entry contains two hardware entries (see page
-	 * tables layout in pgtable.h). We normally guarantee that we always
-	 * fill both L1 entries. But create_mapping() doesn't follow the rule.
-	 * It can create inidividual L1 entries, so here we have to call
-	 * pmd_none() check for the entry really corresponded to address, not
-	 * for the first of pair.
-	 */
-	index = (addr >> SECTION_SHIFT) & 1;
-#endif
-	if (pmd_none(pmd_k[index]))
-		goto bad_area;
-
-	copy_pmd(pmd, pmd_k);
-	return 0;
+	if (!user_mode(regs) && vmalloc_fault(addr))
+		return 0;
 
-bad_area:
 	do_kernel_address_page_fault(current->mm, addr, fsr, regs);
 
 	return 0;
-- 
2.47.3

