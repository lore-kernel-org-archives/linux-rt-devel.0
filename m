Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C6822ACEB
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jul 2026 13:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429233; cv=none; b=RfWZ8aYrcE7ELTiRh1GLig0yrg9fPjJiXIkKFTeRoY/AdTkuG/qHGfa1xDtTcRdJodboEhaqKuwLhvypw95DDu6UREubnoYFUINRazE7fvKOvpjywuKJFB9EgvnvTTeIGNiIMnS4F4rHTsT5ySO86BiZzQOc61f5e8GCXfgY5hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429233; c=relaxed/simple;
	bh=RvXzUh+Z5rLxburgzcvo+g9ZGozfoPunlEYEQZcFbHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1qIgQR2f9xY69x2BYZm8kpx7qbIv6EyfUAZuZo3f68JMcjkU1maRI60DQpgLmafSByswk+YjBLM/SzCae67hqPdbZbFmeIiAvTsWONgvSrOzWO2rfM1J6A3PEhVApblda6gi5o1AHZ8RrDp+9VU36c1xrKMj3gyiU/qCdgXE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFuazXe9; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFuazXe9"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-c999d839661so796993a12.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Jul 2026 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783429232; x=1784034032; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5W5DUkb1JUBfDdw5NFLWUB/50kxa7q0vorvfnztH0I4=;
        b=FFuazXe9OGoko+TfMSwKRaKOAJmog9Q36SDKYnHtQmbnBf/N35rnoG7A59QGj4Syy4
         l2XkfKD5EeK/hR7rL9VmCzJSBUlQAan7BCYXoJC5akEpyaUfb31ponhntYME9IMHcI1I
         xLuFmjWdpZUvVWff7CieCotRmm4ifHxYuzrymOH6hxTF3RRHclIBOzhTcNSAjvA2s3Pq
         RKE3ClpsUKOG5nSt0eXgncCXU7k/YrJUZNlnN4iNG9ZFVpCiZTOFc0AId3iVF62KqBrF
         8yPSR5ZZ972Knu25Y0wPFQQU5LQz2MWt4KGKh86MSTyOkozM3nWMJy5ezBi1ETMhmpei
         hVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429232; x=1784034032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5W5DUkb1JUBfDdw5NFLWUB/50kxa7q0vorvfnztH0I4=;
        b=JrHMCPGt+ePiyxQrF/V8J1pe3pyW4glfdBE0pRckDRUSBXRSRrOdriTi6psRCafCQv
         HwBSxFBD6BCiWTUrJUQPmdBy5jG+78v0ex10W4bAqfh31nXwzGMSUPKv0u9O4b2iuiwT
         N640TNP2ZifAH21ajPAOR6sXzjaM/4puz7Bs6NwPzUR1S6ImtIUQhXGgDi7+N7WSEb7/
         xb4SzIqn9iF8lVa8V9a/Kj2jTfG//NKX/yl7XsEe2UVgdDc0TSUL34BDBgY4oqDZXYMH
         uu56SRp+T90kILa1CN08DzR7BsW2i0hthvH1pFvt6izhHvj2Q/X6wYBuYw3eFuMY1xqx
         s7Fg==
X-Forwarded-Encrypted: i=1; AHgh+RpP2cO/Iv9uZfuGhsFkkIP+Spup/AfS87NWfi8g1EleeykYG5/hNkjnb9EQJSKQpTaNLCZmPs0TYWFGISDeGg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYgelHn1RE3E+mNSRET3lwrOHuDaz3MzPw4eTVntG7zWnu/Rj6
	F2r094za8zvfBraAaguj6N4xz1mHX62NtP04khGtPxHvuZ02Tkzy/IX1
X-Gm-Gg: AfdE7cnK10515HCIKg9kMOrcrr4AqpxkMvX9kxU0YIPj3Ie/szIOBadT33XwiYGaoOM
	CBpqH+0aZXb0cH2QZyZlNv0zJK+ZVSTBwamn3Jz7yipYIpk14X+a34Zq5ysRtxXuPrQitkskIIA
	aMVk1T56tyb/ysLtq31XoRlV4K1DMOO2CqpZ5NhbU5F+B7Ydt/VgHKmX1dWgsy1pXV9893r77oX
	S0a/TWYQkShsZ5BQoEe02TWIZeAYVABy0llJ319DH/cKLPm588RptqSzDrUg5zX0mHE5PA3pgTw
	AnF2vDje3w+OSSw+h9x9i/LAZSfrA+/9rVzfxOpAGbWCT/ZQiSDf4kV7pORojaB2S9AUuuc43er
	Ey1ys5sjY7No9yqZTqXD5PydlFbWHzDRjMu44TtJwJH2mp692D8yHVFQizEemOPgG8YwGQcp6f8
	1de0lGi9mKcW1bYv6Wx6azvAaXQw==
X-Received: by 2002:a05:6a00:1819:b0:847:8b1d:22fe with SMTP id d2e1a72fcca58-84826df12a7mr4541501b3a.50.1783429231350;
        Tue, 07 Jul 2026 06:00:31 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b5e566sm5415983b3a.3.2026.07.07.06.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 06:00:30 -0700 (PDT)
From: Wandun Chen <chenwandun1@gmail.com>
To: vbabka@kernel.org,
	david@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	Alexander.Krabler@kuka.com,
	hughd@google.com,
	fvdl@google.com,
	bigeasy@linutronix.de,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: akpm@linux-foundation.org,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	harry@kernel.org,
	jannh@google.com,
	lance.yang@linux.dev,
	mathieu.desnoyers@efficios.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	pfalcato@suse.de
Subject: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mlocking a range
Date: Tue,  7 Jul 2026 20:59:25 +0800
Message-ID: <20260707125925.3725177-5-chenwandun1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707125925.3725177-1-chenwandun1@gmail.com>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wandun Chen <chenwandun@lixiang.com>

The region covered by mlock[all] may contain CMA pages. cma_alloc installs
migration entries in the page table, if a memory access occurs at this
point, it must wait for the migration to complete, which may cause
latency spikes on the RT kernels.

Try to move the migration cost into the mlock[all] caller, which is
typically a setup path. So reduce the chance of latency spikes on RT
kernels by migrating the currently mapped CMA pages out of CMA region.

Suggested-by: Frank van der Linden <fvdl@google.com>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://lore.kernel.org/all/CAPTztWZpnX1j8-7yeppVUsxE=O9hbVeqricDjZt8_pnN7a-kBQ@mail.gmail.com/#t
---
 mm/mlock.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 1 deletion(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index ac65de40b22b..f56c685533f5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -25,6 +25,7 @@
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/secretmem.h>
+#include <linux/migrate.h>
 #include <linux/compaction.h>
 
 #include "internal.h"
@@ -428,6 +429,119 @@ static int mlock_pte_range(pmd_t *pmd, unsigned long addr,
 	return 0;
 }
 
+#ifdef CONFIG_CMA
+static int mlock_collect_migratable_pte_range(pmd_t *pmd, unsigned long addr,
+			unsigned long end, struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	struct list_head *folio_list = walk->private;
+	spinlock_t *ptl;
+	pte_t *start_pte, *pte;
+	pte_t ptent;
+	struct folio *folio;
+	unsigned int step = 1;
+
+	if (!(vma->vm_flags & VM_LOCKED))
+		return 0;
+
+	ptl = pmd_trans_huge_lock(pmd, vma);
+	if (ptl) {
+		if (!pmd_present(*pmd)) {
+			if (unlikely(softleaf_is_migration(softleaf_from_pmd(*pmd)))) {
+				spin_unlock(ptl);
+				pmd_migration_entry_wait(vma->vm_mm, pmd);
+				walk->action = ACTION_AGAIN;
+				return 0;
+			}
+			goto out;
+		}
+		if (is_huge_zero_pmd(*pmd))
+			goto out;
+		folio = pmd_folio(*pmd);
+		if (folio_is_zone_device(folio))
+			goto out;
+		if (is_migrate_cma_page(&folio->page))
+			isolate_folio_to_list(folio, folio_list);
+		goto out;
+	}
+
+	start_pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
+	if (!start_pte) {
+		walk->action = ACTION_AGAIN;
+		return 0;
+	}
+
+	for (pte = start_pte; addr != end; pte += step, addr += step * PAGE_SIZE) {
+		step = 1;
+		ptent = ptep_get(pte);
+		if (!pte_present(ptent)) {
+			if (unlikely(softleaf_is_migration(softleaf_from_pte(ptent)))) {
+				pte_unmap_unlock(start_pte, ptl);
+				migration_entry_wait(vma->vm_mm, pmd, addr);
+				walk->action = ACTION_AGAIN;
+				return 0;
+			}
+			continue;
+		}
+		folio = vm_normal_folio(vma, addr, ptent);
+		if (!folio || folio_is_zone_device(folio))
+			continue;
+		step = folio_mlock_step(folio, pte, addr, end);
+		if (is_migrate_cma_page(&folio->page))
+			continue;
+		isolate_folio_to_list(folio, folio_list);
+	}
+	pte_unmap(start_pte);
+out:
+	spin_unlock(ptl);
+	cond_resched();
+	return 0;
+}
+
+static const struct mm_walk_ops mlock_collect_migratable_ops = {
+	.pmd_entry	= mlock_collect_migratable_pte_range,
+	.walk_lock	= PGWALK_RDLOCK,
+};
+
+static void mlock_migrate_cma_range(unsigned long start, unsigned long len)
+{
+	struct mm_struct *mm = current->mm;
+	unsigned long end = start + len;
+	LIST_HEAD(folio_list);
+	struct migration_target_control mtc = {
+		.nid = NUMA_NO_NODE,
+		.gfp_mask = GFP_HIGHUSER | __GFP_NOWARN,
+		.reason = MR_SYSCALL,
+	};
+
+	if (compaction_allow_unevictable())
+		return;
+
+	lru_cache_disable();
+
+	if (mmap_read_lock_killable(mm))
+		goto out;
+
+	walk_page_range(mm, start, end, &mlock_collect_migratable_ops,
+			&folio_list);
+	mmap_read_unlock(mm);
+
+	if (list_empty(&folio_list))
+		goto out;
+
+	if (migrate_pages(&folio_list, alloc_migration_target, NULL,
+			  (unsigned long)&mtc, MIGRATE_SYNC, MR_SYSCALL, NULL))
+		putback_movable_pages(&folio_list);
+out:
+	lru_cache_enable();
+}
+#else
+static inline void mlock_migrate_cma_range(unsigned long start,
+					   unsigned long len)
+{
+}
+#endif /* CONFIG_CMA */
+
 /*
  * mlock_vma_pages_range() - mlock any pages already in the range,
  *                           or munlock all pages in the range.
@@ -678,6 +792,7 @@ static __must_check int do_mlock(unsigned long start, size_t len, vm_flags_t fla
 	error = __mm_populate(start, len, 0);
 	if (error)
 		return __mlock_posix_error_return(error);
+	mlock_migrate_cma_range(start, len);
 	return 0;
 }
 
@@ -790,8 +905,10 @@ SYSCALL_DEFINE1(mlockall, int, flags)
 	    capable(CAP_IPC_LOCK))
 		ret = apply_mlockall_flags(flags);
 	mmap_write_unlock(current->mm);
-	if (!ret && (flags & MCL_CURRENT))
+	if (!ret && (flags & MCL_CURRENT)) {
 		mm_populate(0, TASK_SIZE);
+		mlock_migrate_cma_range(0, TASK_SIZE);
+	}
 
 	return ret;
 }
-- 
2.43.0

