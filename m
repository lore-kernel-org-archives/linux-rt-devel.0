Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D20640D560
	for <linux-rt-devel@lists.linux.dev>; Tue,  7 Jul 2026 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783429195; cv=none; b=YCAla7AGG+a27naRtdy43qviI2aelxteQE/TVCFEIx+JBPzIsltv6plrukJU5o4Q7qyX2ZNsSqv6MqERkSPl3AXgdWlujKz+gk7va+2BrzG2eEkSjlinRb1KmQg+v2Y9eionVCjr4xYF6u9n1k5SY9k/wMzRbNvlqh/vQkaP4Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783429195; c=relaxed/simple;
	bh=yole13EigkRSd7xBnzu90SvW8e/P0ie4BQTT6so7T30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYZCrG0rnxPNLA0vOPhTsqg79eo1OihUmaXCCliRWb22kRVMPFqwrL4jq/1QMCYWsxl3XrdKkyCPex9+mB1fRP7GzMBnIimFTAhWZZkjKQmIk8BIB8bo2Va2gn95rOaQTeDWqdP9EpKwsDXRMq30kZmlzZGNZCPO9MrWJdjkSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGVsagjR; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGVsagjR"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca696c4b152so31719a12.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 07 Jul 2026 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783429194; x=1784033994; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RSA218qTv4mgdJzlBuvqRuFwwy+LpVW2vHjrCuIOTHM=;
        b=tGVsagjRnUjgwWt0qgSzRtcBexRhJEw6KOueQn4x/JX/UdNsG/pFxX9Wh1zGe3uvmQ
         kbqUDtjmvVQ7bHRBFPpuJ9dJAMIvXb6She9MKgZINJXdvthoPqpDRl4Z6FmmIdlfYYZe
         0aR8zhEcdfKunx5KjaXywy4ALJIf9mJ6LsdRNfUiM4W4uNEpTo3529+J4/817Tnieq0K
         2LEyjJfROJ08RT82DoKubYJ9v3Y4yOQAXmvIMoKrMiyvZLDgEpQQ2vH6vCds4iK2Ct4Q
         1FueM+FMurKK6ln3j4pOtSAQuYDL3BB1WcKJC3YhQTx76TT6vLwavBav/D7n3T2ehTu3
         W6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783429194; x=1784033994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RSA218qTv4mgdJzlBuvqRuFwwy+LpVW2vHjrCuIOTHM=;
        b=tYoX3mXgVkR+jPJFFl5egimCox/mMX4U2ZzkgKPPN+b5JC/wgnMHyHAwwXvsDJv77Z
         x/PM11OZ/EYY4b8DroibxugHSmVxNyS6ujDEzjXsioHTYD66TNtJRVUHSBPoK5i1xvaa
         rlkBifdZ7gVI112TpqHbME+sZ1sk1VrlpTFbxiAPa3i7ywGix+HUMBSry/vE/nUXJPyP
         rm1XqboGKRf6hcPe7nstVA8Yod1mHqzQU18GA6FPQ6mA4s0ZlJQHbaHPTiZdMgIqBLij
         tiurpsCWHS6soJfsAUVsEjcuw8E8nTuI5ekupNLqHMztcm8XyC6aG+058S8pwF1Y0ZXB
         bZKQ==
X-Forwarded-Encrypted: i=1; AHgh+Roc6bCjiR8snezhgFKWuLsS/tWOnn1xjBxP9vTOn4eahPxD/LkXbBhfHoWskkgJP7ZufrLyYKyxxYpL1s8EwQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxErYk1I2iZXzrUeXLjIrM9+EgKmZGU5w7R3vSn145bMKOETMjO
	5whwNXzpb9JRLO/QBrOxcSXVA5z9DpMvThG75mhVb5FsTTQqS1oAwZFH
X-Gm-Gg: AfdE7cmdleNkINB75kUtmK9f9+eFpeVd+POnzBk5zOLa3dsfc+cCndb+5ecZ8h9l9sZ
	crMDolhPEHp+q5wd6XCFbqFrk36RSbeq72JKIa9Vra9SKjrZns/ocZAF8aWn+gACazHNI6UclZx
	x3+6Tgb1i0sof8sibV3JvOtuwCehYNBEabtWev+HqbvQfs4RejvuUT9XQ6IcPsV85TAI4ICsO5M
	OL9/r7yzbMQ81QVK2RvJY32x80kYodVM3u5q+OMEOkWfaLGuJyjxSE420qUz0PyIqkEaTCFJq3r
	fYChDGoyz2WNhXkGm8rWYIHUQy2honB107Bbg227X3PIVU4YkQR6toCLflw8KmTccYFcY/s4r1f
	lurlzZK4hxthXjG791jo87pKoqapnyJYJqwurXWaCfVOCP/Zf07upCnRefFHcCw1/lQitwo5lOX
	h7oile1VEEcKS7RU+/OOKVzG9pXQ==
X-Received: by 2002:a05:6a00:760a:b0:848:2f74:d8da with SMTP id d2e1a72fcca58-8482f74dc6emr1994798b3a.75.1783429193368;
        Tue, 07 Jul 2026 05:59:53 -0700 (PDT)
Received: from intel.company.local ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6b5e566sm5415983b3a.3.2026.07.07.05.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:59:52 -0700 (PDT)
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
Subject: [PATCH v2 1/4] mm/migrate: do not migrate folios mapped into VM_LOCKED VMAs under compaction
Date: Tue,  7 Jul 2026 20:59:22 +0800
Message-ID: <20260707125925.3725177-2-chenwandun1@gmail.com>
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

When compact_unevictable_allowed=0, unevictable pages should not be
migrated. However, mlock_folio_batch in the mlock[all] syscall introduces
a race, mlock_folio() sets PG_mlocked immediately but defers PG_unevictable
to mlock_folio_batch(), causing pages that are about to become unevictable
to be migrated, which violates the intent of compact_unevictable_allowed,
and causes spike latency in RT kernels [1].

In order to fix this, migration is forbidden for pages mapped into VMAs
marked with VM_LOCKED. In addition, two early-return paths are introduced,
filter out mlocked pages, return early to avoid unnecessary operations.

Fixes: 90d07210ab55 ("mm: mlock: use folios and a folio batch internally")
Reported-by: Alexander Krabler <Alexander.Krabler@kuka.com>
Closes: https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/ [1]
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
Link: https://lore.kernel.org/linux-rt-users/33275585-f2db-4779-89f0-3ae24b455a67@suse.cz/#t
---
 include/linux/compaction.h |  6 ++++++
 include/linux/rmap.h       |  3 +++
 mm/compaction.c            |  8 +++++++-
 mm/migrate.c               | 23 +++++++++++++++++++----
 mm/rmap.c                  | 12 +++++++++---
 5 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/include/linux/compaction.h b/include/linux/compaction.h
index f29ef0653546..04e60f65b976 100644
--- a/include/linux/compaction.h
+++ b/include/linux/compaction.h
@@ -106,6 +106,7 @@ bool compaction_zonelist_suitable(struct alloc_context *ac, int order,
 extern void __meminit kcompactd_run(int nid);
 extern void __meminit kcompactd_stop(int nid);
 extern void wakeup_kcompactd(pg_data_t *pgdat, int order, int highest_zoneidx);
+extern bool compaction_allow_unevictable(void);
 
 #else
 static inline void reset_isolation_suitable(pg_data_t *pgdat)
@@ -131,6 +132,11 @@ static inline void wakeup_kcompactd(pg_data_t *pgdat,
 {
 }
 
+static inline bool compaction_allow_unevictable(void)
+{
+	return true;
+}
+
 #endif /* CONFIG_COMPACTION */
 
 struct node;
diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 8dc0871e5f00..359c7426b6b9 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -102,6 +102,9 @@ enum ttu_flags {
 					 * do a final flush if necessary */
 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
 					 * caller holds it */
+	TTU_RESPECT_MLOCK	= 0x100,/* leave VM_LOCKED vmas mapped instead
+					 * of installing a migration entry
+					 */
 };
 
 #ifdef CONFIG_MMU
diff --git a/mm/compaction.c b/mm/compaction.c
index f08765ade014..5d256930e389 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1116,7 +1116,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
 		is_unevictable = folio_test_unevictable(folio);
 
 		/* Compaction might skip unevictable pages but CMA takes them */
-		if (!(mode & ISOLATE_UNEVICTABLE) && is_unevictable)
+		if (!(mode & ISOLATE_UNEVICTABLE) &&
+		    (is_unevictable || folio_test_mlocked(folio)))
 			goto isolate_fail_put;
 
 		/*
@@ -1898,6 +1899,11 @@ typedef enum {
  * compactable pages.
  */
 static int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;
+
+bool compaction_allow_unevictable(void)
+{
+	return sysctl_compact_unevictable_allowed;
+}
 /*
  * Tunable for proactive compaction. It determines how
  * aggressively the kernel should compact memory in the
diff --git a/mm/migrate.c b/mm/migrate.c
index a786549551e3..3a15eb13e82b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1202,7 +1202,7 @@ static void migrate_folio_done(struct folio *src,
 static int migrate_folio_unmap(new_folio_t get_new_folio,
 		free_folio_t put_new_folio, unsigned long private,
 		struct folio *src, struct folio **dstp, enum migrate_mode mode,
-		struct list_head *ret)
+		struct list_head *ret, enum migrate_reason reason)
 {
 	struct folio *dst;
 	int rc = -EAGAIN;
@@ -1210,6 +1210,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	struct anon_vma *anon_vma = NULL;
 	bool locked = false;
 	bool dst_locked = false;
+	enum ttu_flags ttu = 0;
 
 	dst = get_new_folio(src, private);
 	if (!dst)
@@ -1249,9 +1250,15 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		folio_lock(src);
 	}
 	locked = true;
-	if (folio_test_mlocked(src))
+	if (folio_test_mlocked(src)) {
 		old_folio_state |= FOLIO_WAS_MLOCKED;
 
+		if (reason == MR_COMPACTION && !compaction_allow_unevictable()) {
+			rc = -EBUSY;
+			goto out;
+		}
+	}
+
 	if (folio_test_writeback(src)) {
 		/*
 		 * Only in the case of a full synchronous migration is it
@@ -1324,7 +1331,14 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 		/* Establish migration ptes */
 		VM_BUG_ON_FOLIO(folio_test_anon(src) &&
 			       !folio_test_ksm(src) && !anon_vma, src);
-		try_to_migrate(src, mode == MIGRATE_ASYNC ? TTU_BATCH_FLUSH : 0);
+
+		if (mode == MIGRATE_ASYNC)
+			ttu |= TTU_BATCH_FLUSH;
+
+		if (reason == MR_COMPACTION && !compaction_allow_unevictable())
+			ttu |= TTU_RESPECT_MLOCK;
+
+		try_to_migrate(src, ttu);
 		old_folio_state |= FOLIO_WAS_MAPPED;
 	}
 
@@ -1905,7 +1919,8 @@ static int migrate_pages_batch(struct list_head *from,
 			}
 
 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
-					private, folio, &dst, mode, ret_folios);
+					private, folio, &dst, mode, ret_folios,
+					reason);
 			/*
 			 * The rules are:
 			 *	0: folio will be put on unmap_folios list,
diff --git a/mm/rmap.c b/mm/rmap.c
index 0fb7a1b82cf3..3cb7f6337d38 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2420,6 +2420,9 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 	unsigned long pfn;
 	unsigned long hsz = 0;
 
+	if ((flags & TTU_RESPECT_MLOCK) && (vma->vm_flags & VM_LOCKED))
+		return false;
+
 	/*
 	 * When racing against e.g. zap_pte_range() on another cpu,
 	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
@@ -2741,11 +2744,14 @@ void try_to_migrate(struct folio *folio, enum ttu_flags flags)
 	};
 
 	/*
-	 * Migration always ignores mlock and only supports TTU_RMAP_LOCKED and
-	 * TTU_SPLIT_HUGE_PMD, TTU_SYNC, and TTU_BATCH_FLUSH flags.
+	 * Migration normally ignores mlock, but TTU_RESPECT_MLOCK asks it to
+	 * leave folios mapped into VM_LOCKED vmas alone.  Only TTU_RMAP_LOCKED,
+	 * TTU_SPLIT_HUGE_PMD, TTU_SYNC, TTU_BATCH_FLUSH and TTU_RESPECT_MLOCK
+	 * are supported.
 	 */
 	if (WARN_ON_ONCE(flags & ~(TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
-					TTU_SYNC | TTU_BATCH_FLUSH)))
+					TTU_SYNC | TTU_BATCH_FLUSH |
+					TTU_RESPECT_MLOCK)))
 		return;
 
 	if (folio_is_zone_device(folio) &&
-- 
2.43.0

