Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3C41A9B39;
	Tue, 10 Dec 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846814; cv=none; b=K9zRWlcU0gyQ6tLG9o1Vu5M7YzAv0BZo1jQDgsJuMmlEDadD89MigC0RmyUMd3bcmBnT1s/7ddCLja6ME5ZSVdgSpyT6BFyqIi6NfOIs3aapvgWL+pxgiBVc9QKbDyzJxp7S39NttvmZ5gZF9iF8+dstBrezOfd6QQVqJVeCTv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846814; c=relaxed/simple;
	bh=au+G63Alb5GCF/A9SMKFt0ffiADn8Kv5aULRnynJplQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ndQFtCoKPEYmur9WYOcTeCoarHB2AiPljGxw/qqwoWFI8buHipof3PUklvUpDtQUaBY+po/U986xZjwekhCoZA6CdeKlmr/BRxRdi/3gVEWR1UEicrnu3P1eqpJpbD5uiIhPPhPXRZA/y8wUZaizjqcetdvvs0gj+9B4RJNlcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DEjxcxD8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DEjxcxD8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931B6C4CEE5;
	Tue, 10 Dec 2024 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733846814;
	bh=au+G63Alb5GCF/A9SMKFt0ffiADn8Kv5aULRnynJplQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DEjxcxD8oTx/TOiQj0A2f+JJWdp/WTkV38+nqMqbKqE7+bF6LG9S+6FdFjp6oYQtq
	 rW1mfkcfhys/Emrwns6joq2JUc53T52CS463Zf/K5eFYzyYk7YjDEIVC4mkWw39m9j
	 S6Z6Oqr/P1VJwWZx+FKYRsDQ6xsQzrgLqFnD+wTb1DLUo4Rj1JRdck87rev7uW6xSX
	 mfsaWuEGPNNqdlX046i345AyLRdM8upKoU4Y31jGz7ADYX6irfh+RsIJEiaUdtPhbV
	 0Lh1SwNgDuIqEQjYvdRqYWOg3GV79ubzX6l4VsAKF47MKqP0JVWTeXepIEOL0Y7J6Q
	 sQebOtMZyj6vg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	Ard Biesheuvel <ardb@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 4/4] mm: drop HIGHPTE support altogether
Date: Tue, 10 Dec 2024 17:05:56 +0100
Message-Id: <20241210160556.2341497-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210160556.2341497-1-arnd@kernel.org>
References: <20241210160556.2341497-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

With both x86 and arm having dropped CONFIG_HIGHPTE support, no
architecture is left using it, so remove the remnants in common code.

It is likely that further cleanups are possible in the page table
code but those are not obvious from the config options.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/hugetlb.h | 5 +----
 include/linux/mm.h      | 1 -
 include/linux/pgtable.h | 9 ---------
 3 files changed, 1 insertion(+), 14 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index ae4fe8615bb6..5369a269dd39 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -176,7 +176,6 @@ extern struct list_head huge_boot_pages[MAX_NUMNODES];
 
 /* arch callbacks */
 
-#ifndef CONFIG_HIGHPTE
 /*
  * pte_offset_huge() and pte_alloc_huge() are helpers for those architectures
  * which may go down to the lowest PTE level in their huge_pte_offset() and
@@ -191,7 +190,6 @@ static inline pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
 {
 	return pte_alloc(mm, pmd) ? NULL : pte_offset_huge(pmd, address);
 }
-#endif
 
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz);
@@ -966,9 +964,8 @@ static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
 	 */
 	if (size >= PUD_SIZE)
 		return pud_lockptr(mm, (pud_t *) pte);
-	else if (size >= PMD_SIZE || IS_ENABLED(CONFIG_HIGHPTE))
+	else if (size >= PMD_SIZE)
 		return pmd_lockptr(mm, (pmd_t *) pte);
-	/* pte_alloc_huge() only applies with !CONFIG_HIGHPTE */
 	return ptep_lockptr(mm, pte);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f56f81d5e244..6353fd939702 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2954,7 +2954,6 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
 
 static inline spinlock_t *ptep_lockptr(struct mm_struct *mm, pte_t *pte)
 {
-	BUILD_BUG_ON(IS_ENABLED(CONFIG_HIGHPTE));
 	BUILD_BUG_ON(MAX_PTRS_PER_PTE * sizeof(pte_t) > PAGE_SIZE);
 	return ptlock_ptr(virt_to_ptdesc(pte));
 }
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index adef9d6e9b1b..23be8776bd5e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -119,14 +119,6 @@ static inline pte_t *pte_offset_kernel(pmd_t *pmd, unsigned long address)
 #define pte_offset_kernel pte_offset_kernel
 #endif
 
-#ifdef CONFIG_HIGHPTE
-#define __pte_map(pmd, address) \
-	((pte_t *)kmap_local_page(pmd_page(*(pmd))) + pte_index((address)))
-#define pte_unmap(pte)	do {	\
-	kunmap_local((pte));	\
-	rcu_read_unlock();	\
-} while (0)
-#else
 static inline pte_t *__pte_map(pmd_t *pmd, unsigned long address)
 {
 	return pte_offset_kernel(pmd, address);
@@ -135,7 +127,6 @@ static inline void pte_unmap(pte_t *pte)
 {
 	rcu_read_unlock();
 }
-#endif
 
 void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable);
 
-- 
2.39.5

