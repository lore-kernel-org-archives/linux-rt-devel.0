Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD42E2EEE
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 May 2026 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154086; cv=none; b=GZLkwt5lh9Jf2DJ9uqBV/n8oONTz3VEQJrs3fc62tgjcmGwJCjHPp/xEOiuSfFj/6a2ls6Ia2eJTKX5IsMx1Pq5RiQT4dN9TlnhGOhZF1tMIsvlS3DQE91Q8AEGySaQwAMXGneg9aFUxk4EIZYytVwuuikL4ZaaYksecMywm7Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154086; c=relaxed/simple;
	bh=4BVHLvuBFvyjuj3EzPBbAtH6I8IO+E5EmUGwpgvpZIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umwFjGVo8WVomidPnICr2WeLhqrE3OXKeaYZe3SVA5emfxDOjP9DdwXckcmhizfHwsSn34dzOB0Ez6RNSeAs0YjbOCECNANyA1c77fOrWzTbxfzjn2bUSE4qGyDAwQes3EyZgtqVwcBWThTOfErwPPF8QpNlCW+5J/NkCKJXvsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAckucwy; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAckucwy"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-441209fb77eso1699841f8f.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 18 May 2026 18:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779154083; x=1779758883; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYIFZtEOROXKEaAPsW/zk5dSrEVUPynUxnKhGIAxI0A=;
        b=GAckucwy63Pa6/XC1yNcBhjasWPQirJOW5GNvi88WfREwgLntbEhFQMUPyJZer4m8p
         iuTNklnwGu8wYvCmDyRCS62c00WDcSgiJjS0WO4d0zDyNAtF7N6WVOoVDnFgmflswg/W
         QW760cm1664V30ROcitXrsMQOrAu5imwd4COXBf1IXtfhk4DG+KsPjR6XBXSBLOMGUna
         7I2ZTNAE+YBvTSa6GrQ9fKlvblH1JPAqbLj40JfLXSpMP4Qmy7XuiNe84yHExbb7n82V
         yXsquWYTZIaabvoS9rwnfm/2xhG+j4wQaDWPU1CP3ZBmq5pFVp27i6dTslJ9LIA/tw80
         ZDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154083; x=1779758883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NYIFZtEOROXKEaAPsW/zk5dSrEVUPynUxnKhGIAxI0A=;
        b=sKuj6XesMXbfvFnZ/fxhe9xU+Vk1pPIX57sLlDVBqtFPP1ZmzLOMInVAS9qozdcorr
         bplMhf4A6UWSKaHZUMmivS9qo/QHPykMdR5oh+pdqPMEgYyo/ICdHLW4KvZOSuJgkb8F
         xO4pOTEbCauRJJ6l5m2POTwr/vKm4ohH+79VWeWCwtdQrE/guPCkvWRnDvwhC2pxAp18
         h0mDqEg9ae24us6LJ2wjd8JP1mE0bo4ZiJlLsw0G6mZK4kqmzbAbx8KbcIA2URCV4m4Q
         4Y8Qq4RkVqzikUn7YHzba3GWnj5ckfd4UrzsXVMJuXwOmWkIpjqFOBVX+xCkZ/SVMNl5
         vcXg==
X-Forwarded-Encrypted: i=1; AFNElJ+pevLacgqoDy2WAyJ4Asq89oBAxpEhOLojuh6ZWRP3srhPnvc2m5DxPWliKbUJiQI6/Wx5x/kHUxNWzkHeEQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YyrA78PBjwYpju0v4EaVZMl8RH22uPxNnQf1UxW0pJ00aGm/zqu
	8CemJZqRPLfagXgLvKHN8H7D03EyMnazWL+4PStrHwnrEltbCi0RgkfW
X-Gm-Gg: Acq92OECeQ6lXF7cmG8iSRMKTAoayrOb8J5cQAjvGUqIchh1HMRJCat6HOnoiZWQZ2e
	0mayJUSrvUdnFnYrw/rwEkS3l6doojezTLSI+blEw2PmqLNjpJC9A080963ofKeESlcPn4fk5op
	aCSoT90IMgnsRUY1UgLi29+1CDDfLQeC5rDf9BuCS97dS2MbmQ0tzM/CdWPPpTNSaH0TxQdrVYL
	FjCoT/YTXbJXUtPuz2WwbqOKBfqaA0uDrPXdDFm/znoVyhnUfQQnH84Ov6i3rEN9ycsSalfhpaq
	/LqNF0KnXpFMtsoCe4pxuLeXjv5U86ZsFaEiGRV5vw6cfDmuixubYAMC6WrXKEqitz03YrT2y3E
	bxleWj8y1sZKOpk/GXz4nyFhzdFu6l8BNttlqjUjk/PkYAKzqe644PCWLjRMFxApSAaKqAn2lyi
	g+pWPzWbyfKqHJdxgLKEiGN3VpKBBxhA==
X-Received: by 2002:a05:6000:1a89:b0:452:bc74:b129 with SMTP id ffacd0b85a97d-45e5b886090mr27913668f8f.16.1779154082589;
        Mon, 18 May 2026 18:28:02 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f83:8501:800:cd4:5e2:9556])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm40548683f8f.16.2026.05.18.18.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:28:02 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Leonardo Bras <leobras.c@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Gary Guo <gary@garyguo.net>,
	Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v4 3/4] swap: apply new pw_queue_on() interface
Date: Mon, 18 May 2026 22:27:49 -0300
Message-ID: <20260519012754.240804-4-leobras.c@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519012754.240804-1-leobras.c@gmail.com>
References: <20260519012754.240804-1-leobras.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18514; i=leobras.c@gmail.com; h=from:subject; bh=4BVHLvuBFvyjuj3EzPBbAtH6I8IO+E5EmUGwpgvpZIw=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLK494Tn32I2yTyYcNf+2gxpTttQn28Xuy5dClV5u+9Kg fdhrvXZHaUsDGJcDLJiiiyyj+av4vk+JePIlR8LYOawMoEMYeDiFICJzEhn+Ke/3XQKX/6NHQ1r lqyp+db4e7lR2Jpv0/472m5+VGmyNiSMkWGj5y7lVyWfTuptXGOse/JHiYrpFp3fMo/XW66d/fT Qvi3sAA==
X-Developer-Key: i=leobras.c@gmail.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

Make use of the new pw_{un,}lock*() and pw_queue_on() interface to improve
performance & latency.

For functions that may be scheduled in a different cpu, replace
local_{un,}lock*() by pw_{un,}lock*(), and replace schedule_work_on() by
pw_queue_on(). The same happens for flush_work() and pw_flush().

The change requires allocation of pw_structs instead of a work_structs,
and changing parameters of a few functions to include the cpu parameter.

This should bring no relevant performance impact on non-PWLOCKS kernels:
For functions that may be scheduled in a different cpu, the local_*lock's
this_cpu_ptr() becomes a per_cpu_ptr(smp_processor_id()).

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
---
 mm/internal.h   |  4 ++-
 mm/mlock.c      | 51 ++++++++++++++++++++++++++----------
 mm/page_alloc.c |  2 +-
 mm/swap.c       | 69 ++++++++++++++++++++++++++-----------------------
 4 files changed, 79 insertions(+), 47 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 5a2ddcf68e0b..1ec9a11c373b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1209,24 +1209,26 @@ static inline void munlock_vma_folio(struct folio *folio,
 	 * cause folio not fully mapped to VMA.
 	 *
 	 * But it's not easy to confirm that's the situation. So we
 	 * always munlock the folio and page reclaim will correct it
 	 * if it's wrong.
 	 */
 	if (unlikely(vma->vm_flags & VM_LOCKED))
 		munlock_folio(folio);
 }
 
+int __init mlock_init(void);
 void mlock_new_folio(struct folio *folio);
 bool need_mlock_drain(int cpu);
 void mlock_drain_local(void);
-void mlock_drain_remote(int cpu);
+void mlock_drain_cpu(int cpu);
+void mlock_drain_offline(int cpu);
 
 extern pmd_t maybe_pmd_mkwrite(pmd_t pmd, struct vm_area_struct *vma);
 
 /**
  * vma_address - Find the virtual address a page range is mapped at
  * @vma: The vma which maps this object.
  * @pgoff: The page offset within its object.
  * @nr_pages: The number of pages to consider.
  *
  * If any page in this range is mapped by this VMA, return the first address
diff --git a/mm/mlock.c b/mm/mlock.c
index 8c227fefa2df..5d25bbbb09e9 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -18,31 +18,30 @@
 #include <linux/mempolicy.h>
 #include <linux/syscalls.h>
 #include <linux/sched.h>
 #include <linux/export.h>
 #include <linux/rmap.h>
 #include <linux/mmzone.h>
 #include <linux/hugetlb.h>
 #include <linux/memcontrol.h>
 #include <linux/mm_inline.h>
 #include <linux/secretmem.h>
+#include <linux/pwlocks.h>
 
 #include "internal.h"
 
 struct mlock_fbatch {
-	local_lock_t lock;
+	pw_lock_t lock;
 	struct folio_batch fbatch;
 };
 
-static DEFINE_PER_CPU(struct mlock_fbatch, mlock_fbatch) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-};
+static DEFINE_PER_CPU(struct mlock_fbatch, mlock_fbatch);
 
 bool can_do_mlock(void)
 {
 	if (rlimit(RLIMIT_MEMLOCK) != 0)
 		return true;
 	if (capable(CAP_IPC_LOCK))
 		return true;
 	return false;
 }
 EXPORT_SYMBOL(can_do_mlock);
@@ -202,32 +201,43 @@ static void mlock_folio_batch(struct folio_batch *fbatch)
 			lruvec = __mlock_new_folio(folio, lruvec);
 		else
 			lruvec = __munlock_folio(folio, lruvec);
 	}
 
 	if (lruvec)
 		lruvec_unlock_irq(lruvec);
 	folios_put(fbatch);
 }
 
+void mlock_drain_cpu(int cpu)
+{
+	struct folio_batch *fbatch;
+
+	pw_lock(&mlock_fbatch.lock, cpu);
+	fbatch = per_cpu_ptr(&mlock_fbatch.fbatch, cpu);
+	if (folio_batch_count(fbatch))
+		mlock_folio_batch(fbatch);
+	pw_unlock(&mlock_fbatch.lock, cpu);
+}
+
 void mlock_drain_local(void)
 {
 	struct folio_batch *fbatch;
 
-	local_lock(&mlock_fbatch.lock);
+	pw_lock_local(&mlock_fbatch.lock);
 	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
 	if (folio_batch_count(fbatch))
 		mlock_folio_batch(fbatch);
-	local_unlock(&mlock_fbatch.lock);
+	pw_unlock_local(&mlock_fbatch.lock);
 }
 
-void mlock_drain_remote(int cpu)
+void mlock_drain_offline(int cpu)
 {
 	struct folio_batch *fbatch;
 
 	WARN_ON_ONCE(cpu_online(cpu));
 	fbatch = &per_cpu(mlock_fbatch.fbatch, cpu);
 	if (folio_batch_count(fbatch))
 		mlock_folio_batch(fbatch);
 }
 
 bool need_mlock_drain(int cpu)
@@ -236,79 +246,79 @@ bool need_mlock_drain(int cpu)
 }
 
 /**
  * mlock_folio - mlock a folio already on (or temporarily off) LRU
  * @folio: folio to be mlocked.
  */
 void mlock_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
 
-	local_lock(&mlock_fbatch.lock);
+	pw_lock_local(&mlock_fbatch.lock);
 	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
 
 	if (!folio_test_set_mlocked(folio)) {
 		int nr_pages = folio_nr_pages(folio);
 
 		zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
 		__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 	}
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_lru(folio)) ||
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
-	local_unlock(&mlock_fbatch.lock);
+	pw_unlock_local(&mlock_fbatch.lock);
 }
 
 /**
  * mlock_new_folio - mlock a newly allocated folio not yet on LRU
  * @folio: folio to be mlocked, either normal or a THP head.
  */
 void mlock_new_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
 	int nr_pages = folio_nr_pages(folio);
 
-	local_lock(&mlock_fbatch.lock);
+	pw_lock_local(&mlock_fbatch.lock);
 	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
 	folio_set_mlocked(folio);
 
 	zone_stat_mod_folio(folio, NR_MLOCK, nr_pages);
 	__count_vm_events(UNEVICTABLE_PGMLOCKED, nr_pages);
 
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, mlock_new(folio)) ||
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
-	local_unlock(&mlock_fbatch.lock);
+	pw_unlock_local(&mlock_fbatch.lock);
 }
 
 /**
  * munlock_folio - munlock a folio
  * @folio: folio to be munlocked, either normal or a THP head.
  */
 void munlock_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
 
-	local_lock(&mlock_fbatch.lock);
+	pw_lock_local(&mlock_fbatch.lock);
 	fbatch = this_cpu_ptr(&mlock_fbatch.fbatch);
 	/*
 	 * folio_test_clear_mlocked(folio) must be left to __munlock_folio(),
 	 * which will check whether the folio is multiply mlocked.
 	 */
 	folio_get(folio);
 	if (!folio_batch_add(fbatch, folio) ||
 	    !folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		mlock_folio_batch(fbatch);
-	local_unlock(&mlock_fbatch.lock);
+	pw_unlock_local(&mlock_fbatch.lock);
 }
 
 static inline unsigned int folio_mlock_step(struct folio *folio,
 		pte_t *pte, unsigned long addr, unsigned long end)
 {
 	unsigned int count = (end - addr) >> PAGE_SHIFT;
 	pte_t ptent = ptep_get(pte);
 
 	if (!folio_test_large(folio))
 		return 1;
@@ -822,10 +832,25 @@ int user_shm_lock(size_t size, struct ucounts *ucounts)
 	return allowed;
 }
 
 void user_shm_unlock(size_t size, struct ucounts *ucounts)
 {
 	spin_lock(&shmlock_user_lock);
 	dec_rlimit_ucounts(ucounts, UCOUNT_RLIMIT_MEMLOCK, (size + PAGE_SIZE - 1) >> PAGE_SHIFT);
 	spin_unlock(&shmlock_user_lock);
 	put_ucounts(ucounts);
 }
+
+int __init mlock_init(void)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct mlock_fbatch *fbatch = &per_cpu(mlock_fbatch, cpu);
+
+		pw_lock_init(&fbatch->lock);
+	}
+
+	return 0;
+}
+
+module_init(mlock_init);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 227d58dc3de6..fa768f07f88a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6217,21 +6217,21 @@ void free_reserved_page(struct page *page)
 	__free_page(page);
 	adjust_managed_page_count(page, 1);
 }
 EXPORT_SYMBOL(free_reserved_page);
 
 static int page_alloc_cpu_dead(unsigned int cpu)
 {
 	struct zone *zone;
 
 	lru_add_drain_cpu(cpu);
-	mlock_drain_remote(cpu);
+	mlock_drain_offline(cpu);
 	drain_pages(cpu);
 
 	/*
 	 * Spill the event counters of the dead processor
 	 * into the current processors event counters.
 	 * This artificially elevates the count of the current
 	 * processor.
 	 */
 	vm_events_fold_cpu(cpu);
 
diff --git a/mm/swap.c b/mm/swap.c
index ed9b3d371547..42f51bf4bb71 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -28,54 +28,51 @@
 #include <linux/memremap.h>
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/backing-dev.h>
 #include <linux/memcontrol.h>
 #include <linux/gfp.h>
 #include <linux/uio.h>
 #include <linux/hugetlb.h>
 #include <linux/page_idle.h>
-#include <linux/local_lock.h>
+#include <linux/pwlocks.h>
 #include <linux/buffer_head.h>
 
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/pagemap.h>
 
 /* How many pages do we try to swap or page in/out together? As a power of 2 */
 int page_cluster;
 static const int page_cluster_max = 31;
 
 struct cpu_fbatches {
 	/*
 	 * The following folio batches are grouped together because they are protected
 	 * by disabling preemption (and interrupts remain enabled).
 	 */
-	local_lock_t lock;
+	pw_lock_t lock;
 	struct folio_batch lru_add;
 	struct folio_batch lru_deactivate_file;
 	struct folio_batch lru_deactivate;
 	struct folio_batch lru_lazyfree;
 #ifdef CONFIG_SMP
 	struct folio_batch lru_activate;
 #endif
 	/* Protecting the following batches which require disabling interrupts */
-	local_lock_t lock_irq;
+	pw_lock_t lock_irq;
 	struct folio_batch lru_move_tail;
 };
 
-static DEFINE_PER_CPU(struct cpu_fbatches, cpu_fbatches) = {
-	.lock = INIT_LOCAL_LOCK(lock),
-	.lock_irq = INIT_LOCAL_LOCK(lock_irq),
-};
+static DEFINE_PER_CPU(struct cpu_fbatches, cpu_fbatches);
 
 static void __page_cache_release(struct folio *folio, struct lruvec **lruvecp,
 		unsigned long *flagsp)
 {
 	if (folio_test_lru(folio)) {
 		folio_lruvec_relock_irqsave(folio, lruvecp, flagsp);
 		lruvec_del_folio(*lruvecp, folio);
 		__folio_clear_lru_flags(folio);
 	}
 }
@@ -180,32 +177,32 @@ static void folio_batch_move_lru(struct folio_batch *fbatch, move_fn_t move_fn)
 }
 
 static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		struct folio *folio, move_fn_t move_fn, bool disable_irq)
 {
 	unsigned long flags;
 
 	folio_get(folio);
 
 	if (disable_irq)
-		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
+		pw_lock_local_irqsave(&cpu_fbatches.lock_irq, flags);
 	else
-		local_lock(&cpu_fbatches.lock);
+		pw_lock_local(&cpu_fbatches.lock);
 
 	if (!folio_batch_add(this_cpu_ptr(fbatch), folio) ||
 			!folio_may_be_lru_cached(folio) || lru_cache_disabled())
 		folio_batch_move_lru(this_cpu_ptr(fbatch), move_fn);
 
 	if (disable_irq)
-		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
+		pw_unlock_local_irqrestore(&cpu_fbatches.lock_irq, flags);
 	else
-		local_unlock(&cpu_fbatches.lock);
+		pw_unlock_local(&cpu_fbatches.lock);
 }
 
 #define folio_batch_add_and_move(folio, op)		\
 	__folio_batch_add_and_move(			\
 		&cpu_fbatches.op,			\
 		folio,					\
 		op,					\
 		offsetof(struct cpu_fbatches, op) >=	\
 		offsetof(struct cpu_fbatches, lock_irq)	\
 	)
@@ -356,21 +353,21 @@ void folio_activate(struct folio *folio)
 	lruvec_unlock_irq(lruvec);
 	folio_set_lru(folio);
 }
 #endif
 
 static void __lru_cache_activate_folio(struct folio *folio)
 {
 	struct folio_batch *fbatch;
 	int i;
 
-	local_lock(&cpu_fbatches.lock);
+	pw_lock_local(&cpu_fbatches.lock);
 	fbatch = this_cpu_ptr(&cpu_fbatches.lru_add);
 
 	/*
 	 * Search backwards on the optimistic assumption that the folio being
 	 * activated has just been added to this batch. Note that only
 	 * the local batch is examined as a !LRU folio could be in the
 	 * process of being released, reclaimed, migrated or on a remote
 	 * batch that is currently being drained. Furthermore, marking
 	 * a remote batch's folio active potentially hits a race where
 	 * a folio is marked active just after it is added to the inactive
@@ -378,21 +375,21 @@ static void __lru_cache_activate_folio(struct folio *folio)
 	 */
 	for (i = folio_batch_count(fbatch) - 1; i >= 0; i--) {
 		struct folio *batch_folio = fbatch->folios[i];
 
 		if (batch_folio == folio) {
 			folio_set_active(folio);
 			break;
 		}
 	}
 
-	local_unlock(&cpu_fbatches.lock);
+	pw_unlock_local(&cpu_fbatches.lock);
 }
 
 #ifdef CONFIG_LRU_GEN
 
 static void lru_gen_inc_refs(struct folio *folio)
 {
 	unsigned long new_flags, old_flags = READ_ONCE(folio->flags.f);
 
 	if (folio_test_unevictable(folio))
 		return;
@@ -652,23 +649,23 @@ void lru_add_drain_cpu(int cpu)
 
 	if (folio_batch_count(fbatch))
 		folio_batch_move_lru(fbatch, lru_add);
 
 	fbatch = &fbatches->lru_move_tail;
 	/* Disabling interrupts below acts as a compiler barrier. */
 	if (data_race(folio_batch_count(fbatch))) {
 		unsigned long flags;
 
 		/* No harm done if a racing interrupt already did this */
-		local_lock_irqsave(&cpu_fbatches.lock_irq, flags);
+		pw_lock_irqsave(&cpu_fbatches.lock_irq, flags, cpu);
 		folio_batch_move_lru(fbatch, lru_move_tail);
-		local_unlock_irqrestore(&cpu_fbatches.lock_irq, flags);
+		pw_unlock_irqrestore(&cpu_fbatches.lock_irq, flags, cpu);
 	}
 
 	fbatch = &fbatches->lru_deactivate_file;
 	if (folio_batch_count(fbatch))
 		folio_batch_move_lru(fbatch, lru_deactivate_file);
 
 	fbatch = &fbatches->lru_deactivate;
 	if (folio_batch_count(fbatch))
 		folio_batch_move_lru(fbatch, lru_deactivate);
 
@@ -732,56 +729,56 @@ void folio_mark_lazyfree(struct folio *folio)
 	if (!folio_test_anon(folio) || !folio_test_swapbacked(folio) ||
 	    !folio_test_lru(folio) ||
 	    folio_test_swapcache(folio) || folio_test_unevictable(folio))
 		return;
 
 	folio_batch_add_and_move(folio, lru_lazyfree);
 }
 
 void lru_add_drain(void)
 {
-	local_lock(&cpu_fbatches.lock);
+	pw_lock_local(&cpu_fbatches.lock);
 	lru_add_drain_cpu(smp_processor_id());
-	local_unlock(&cpu_fbatches.lock);
+	pw_unlock_local(&cpu_fbatches.lock);
 	mlock_drain_local();
 }
 
 /*
  * It's called from per-cpu workqueue context in SMP case so
  * lru_add_drain_cpu and invalidate_bh_lrus_cpu should run on
  * the same cpu. It shouldn't be a problem in !SMP case since
  * the core is only one and the locks will disable preemption.
  */
-static void lru_add_mm_drain(void)
+static void lru_add_mm_drain(int cpu)
 {
-	local_lock(&cpu_fbatches.lock);
-	lru_add_drain_cpu(smp_processor_id());
-	local_unlock(&cpu_fbatches.lock);
-	mlock_drain_local();
+	pw_lock(&cpu_fbatches.lock, cpu);
+	lru_add_drain_cpu(cpu);
+	pw_unlock(&cpu_fbatches.lock, cpu);
+	mlock_drain_cpu(cpu);
 }
 
 void lru_add_drain_cpu_zone(struct zone *zone)
 {
-	local_lock(&cpu_fbatches.lock);
+	pw_lock_local(&cpu_fbatches.lock);
 	lru_add_drain_cpu(smp_processor_id());
 	drain_local_pages(zone);
-	local_unlock(&cpu_fbatches.lock);
+	pw_unlock_local(&cpu_fbatches.lock);
 	mlock_drain_local();
 }
 
 #ifdef CONFIG_SMP
 
-static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
+static DEFINE_PER_CPU(struct pw_struct, lru_add_drain_pw);
 
-static void lru_add_drain_per_cpu(struct work_struct *dummy)
+static void lru_add_drain_per_cpu(struct work_struct *w)
 {
-	lru_add_mm_drain();
+	lru_add_mm_drain(pw_get_cpu(w));
 }
 
 static DEFINE_PER_CPU(struct work_struct, bh_add_drain_work);
 
 static void bh_add_drain_per_cpu(struct work_struct *dummy)
 {
 	invalidate_bh_lrus_cpu();
 }
 
 static bool cpu_needs_mm_drain(unsigned int cpu)
@@ -882,38 +879,38 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
 	 * If the paired barrier is done at any later step, e.g. after the
 	 * loop, CPU #x will just exit at (C) and miss flushing out all of its
 	 * added pages.
 	 */
 	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
 	smp_mb();
 
 	cpumask_clear(&has_mm_work);
 	cpumask_clear(&has_bh_work);
 	for_each_online_cpu(cpu) {
-		struct work_struct *mm_work = &per_cpu(lru_add_drain_work, cpu);
+		struct pw_struct *mm_pw = &per_cpu(lru_add_drain_pw, cpu);
 		struct work_struct *bh_work = &per_cpu(bh_add_drain_work, cpu);
 
 		if (cpu_needs_mm_drain(cpu)) {
-			INIT_WORK(mm_work, lru_add_drain_per_cpu);
-			queue_work_on(cpu, mm_percpu_wq, mm_work);
+			INIT_PW(mm_pw, lru_add_drain_per_cpu, cpu);
+			pw_queue_on(cpu, mm_percpu_wq, mm_pw);
 			__cpumask_set_cpu(cpu, &has_mm_work);
 		}
 
 		if (cpu_needs_bh_drain(cpu)) {
 			INIT_WORK(bh_work, bh_add_drain_per_cpu);
 			queue_work_on(cpu, mm_percpu_wq, bh_work);
 			__cpumask_set_cpu(cpu, &has_bh_work);
 		}
 	}
 
 	for_each_cpu(cpu, &has_mm_work)
-		flush_work(&per_cpu(lru_add_drain_work, cpu));
+		pw_flush(&per_cpu(lru_add_drain_pw, cpu));
 
 	for_each_cpu(cpu, &has_bh_work)
 		flush_work(&per_cpu(bh_add_drain_work, cpu));
 
 done:
 	mutex_unlock(&lock);
 }
 
 void lru_add_drain_all(void)
 {
@@ -949,21 +946,21 @@ void lru_cache_disable(void)
 	 *
 	 * Since v5.1 kernel, synchronize_rcu() is guaranteed to wait on
 	 * preempt_disable() regions of code. So any CPU which sees
 	 * lru_disable_count = 0 will have exited the critical
 	 * section when synchronize_rcu() returns.
 	 */
 	synchronize_rcu_expedited();
 #ifdef CONFIG_SMP
 	__lru_add_drain_all(true);
 #else
-	lru_add_mm_drain();
+	lru_add_mm_drain(smp_processor_id());
 	invalidate_bh_lrus_cpu();
 #endif
 }
 
 /**
  * folios_put_refs - Reduce the reference count on a batch of folios.
  * @folios: The folios.
  * @refs: The number of refs to subtract from each folio.
  *
  * Like folio_put(), but for a batch of folios.  This is more efficient
@@ -1156,23 +1153,31 @@ static const struct ctl_table swap_sysctl_table[] = {
 		.extra2		= (void *)&page_cluster_max,
 	}
 };
 
 /*
  * Perform any setup for the swap system
  */
 void __init swap_setup(void)
 {
 	unsigned long megs = PAGES_TO_MB(totalram_pages());
+	unsigned int cpu;
 
 	/* Use a smaller cluster for small-memory machines */
 	if (megs < 16)
 		page_cluster = 2;
 	else
 		page_cluster = 3;
 	/*
 	 * Right now other parts of the system means that we
 	 * _really_ don't want to cluster much more
 	 */
 
 	register_sysctl_init("vm", swap_sysctl_table);
+
+	for_each_possible_cpu(cpu) {
+		struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
+
+		pw_lock_init(&fbatches->lock);
+		pw_lock_init(&fbatches->lock_irq);
+	}
 }
-- 
2.54.0

