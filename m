Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8E322FE07;
	Tue, 10 Dec 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733846810; cv=none; b=oaKf/nEjQeyFlSbUyobybywYP20FA/vMcFL8fSlxypkOb/+ZrhcpmXr/j8V5c4mxqf9AE9LXlxQDby/EAmgP4k6wUgFcQePCbbnXq5q7jPYPDwY9HNYVBNWj3OvUWKdiNH9VEmcTqVsqomqykQl2nDapQMsH8IMTxAkL3kwblaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733846810; c=relaxed/simple;
	bh=IDAs66loD46ejrDZgcdhA2wj912kFUy5s0hoLSzyXSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c9ABv2zN7788WMftpTrPPU4jdL/2IctglHB5u1XOBNu+BzqZaSaZhUBaPwLlLZE/JLdee4Z/EOK0a4M6nXiba+8JbHfXchtapvH5GHBKnUeRx6928j3FASbh1TxQtzBy1IELDojGMXy9oxJjoSAgDxxHsdTNC7xgPAcjz7pJIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADJHIkfi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADJHIkfi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2AE5C4CEE1;
	Tue, 10 Dec 2024 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733846810;
	bh=IDAs66loD46ejrDZgcdhA2wj912kFUy5s0hoLSzyXSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADJHIkfiTV0YsOu/HXMzwiS2RxR+5D0cCrNlcj00SQU1YljAfFMCaXaJUWQ2rdFOU
	 iSq4zLD9LGm3Rf1r52f2jsvLRxJzbx4RHtht+B0YxK/e+1a1h1XYL9yntzNDQfQiSZ
	 Z5x1beU4WJoE/X7BOoMoY//o1542eZPoiKgXvjzBiFVv4Ok1RdB5kWh7b1KHLRwzuJ
	 mITMmSURfkPXvsQi08gl0RbQOPq87tCYfo9u81kCz3a8Z/pS/rAzarx8y7plmv+tHv
	 W3QP4/mwCMHdaVN4qnm8tdWHIryJnxDxcvzoT7KBq3kTjX98PcHL4zfil8uaKsh099
	 cHaTRkEQ4+Nsw==
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
Subject: [PATCH 3/4] ARM: drop CONFIG_HIGHPTE support
Date: Tue, 10 Dec 2024 17:05:55 +0100
Message-Id: <20241210160556.2341497-4-arnd@kernel.org>
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

CONFIG_HIGHPTE was added in linux-2.6.32, a few years before 64-bit
support. At the time it made sense, as the CONFIG_ARM_LPAE option allowed
systems with 16GB of memory that made lowmem a particularly scarce
resource, and the HIGHPTE implementation gave feature parity with 32-bit
x86 and frv machines.

Since Arm is the last architecture remaining that uses this, and almost
no 32-bit machines support more than 4GB of RAM, the cost of continuing
to maintain HIGHPTE seems unjustified, so remove it here to allow
simplifying the generic page table handling.

Link: https://lore.kernel.org/lkml/20241204103042.1904639-8-arnd@kernel.org/T/#u
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent a patch to drop HIGHPTE support on x86 today, see
https://lore.kernel.org/lkml/20241210144945.2325330-9-arnd@kernel.org/T/#u

If that one gets merged, we can merge this one instead of the one
that makes HIGHPTE depend on !PREEMPT_RT, but if we decide against
the x86 change, then we probably don't want this one either.
---
 arch/arm/Kconfig               | 11 -----------
 arch/arm/include/asm/pgalloc.h |  8 +-------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4de4e5697bdf..e132effafd8b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1229,17 +1229,6 @@ config HIGHMEM
 
 	  If unsure, say n.
 
-config HIGHPTE
-	bool "Allocate 2nd-level pagetables from highmem" if EXPERT
-	depends on HIGHMEM && !PREEMPT_RT
-	default y
-	help
-	  The VM uses one page of physical memory for each page table.
-	  For systems with a lot of processes, this can use a lot of
-	  precious low memory, eventually leading to low memory being
-	  consumed by page tables.  Setting this option will allow
-	  user-space 2nd level page tables to reside in high memory.
-
 config ARM_PAN
 	bool "Enable privileged no-access"
 	depends on MMU
diff --git a/arch/arm/include/asm/pgalloc.h b/arch/arm/include/asm/pgalloc.h
index a17f01235c29..ef6cb3e6d179 100644
--- a/arch/arm/include/asm/pgalloc.h
+++ b/arch/arm/include/asm/pgalloc.h
@@ -85,18 +85,12 @@ pte_alloc_one_kernel(struct mm_struct *mm)
 	return pte;
 }
 
-#ifdef CONFIG_HIGHPTE
-#define PGTABLE_HIGHMEM __GFP_HIGHMEM
-#else
-#define PGTABLE_HIGHMEM 0
-#endif
-
 static inline pgtable_t
 pte_alloc_one(struct mm_struct *mm)
 {
 	struct page *pte;
 
-	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER | PGTABLE_HIGHMEM);
+	pte = __pte_alloc_one(mm, GFP_PGTABLE_USER);
 	if (!pte)
 		return NULL;
 	if (!PageHighMem(pte))
-- 
2.39.5

