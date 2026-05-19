Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4E2EE611
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 May 2026 01:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154084; cv=none; b=bFH3qcy9XtVdwtEhcms7/zIr9AZNVNHrc2ZjJK9lz0+GYssQmx0q1Wi5+U39KlByDqzrn3APm1lmIEr0ZHiITL26H8WDk4blpGVMR5w7ZNVQxU1XbcSEGWrcWU0xlTMM9MiL1runPwq1BqvSS64zEFNvEbOm00JvHqa8BBs2WtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154084; c=relaxed/simple;
	bh=ZORajtxT6wigR1eruHvBak0h54xyw0ZbbNpidoiz0aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBI7qvHTDs+jFj9VjWxhgB4n1MLtFE8Kqfb0GFjtwj9TwTYkS4Yv+4FL8wnFcJ45+hXsIjgxp4RuwIIfhveb1MSZjeRPq5vSsyKUxvybNmf1rAczARoeengsC9D5mDoiA2oiZz25hrrxVLd5X+pp+zV6pt4MTlfBpYSgeVpz6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkdEZwW7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkdEZwW7"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d7e23defbso1619441f8f.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 18 May 2026 18:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779154081; x=1779758881; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSA5ue1X4vqSsU9ce40m8EGDnzYMIz0AiRlAoh99mwA=;
        b=BkdEZwW7rT/27afR0/nru5taDRGsiKtDfTK5sXY4tbQDLR7SilWbONE+QWGJMD3L1X
         Ew25Fsreqr2q1FuKOE6tfOSQpECYngauAcw+998aHmiQAjV8xHGssiY9PigPi+lPoA5W
         jj+SuV04Jbg5mW6K4tlkqxttAYDb8KshvrSkxrChH6hcL5987zAXqltnQ6o5i9QY2C2S
         NuSNVFMJTUUIxDb+1RoTFYLnNwoJalokAryErWFegEDS+PQFa0wajnPOb0/sZ4rN6VQJ
         ivEjdNo3TEixffu6UfPS2aJ+rT1DU/U5cDxXQb0QsptFmY6X3Yxqq1TVfOG6uEpUOE/b
         2vfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154081; x=1779758881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rSA5ue1X4vqSsU9ce40m8EGDnzYMIz0AiRlAoh99mwA=;
        b=mgFkXOaFPZD2eYh9Cjffpthlmwff2laZZ9nvoHrtppov65S7RezW2mzFym2c0Twh5B
         y+ibZ7HcLSTa4vuxHoPk0pjb627WvVfH5tFUyuk5wtt6lTHN8Vw+bOgV0ljv73MZ4QFu
         BU6eUuVF51ML+uNLskmtifjz1Q6TOeBZg0Af1OMcWpbqEBYu0gI0xsRrw5uOM4HFY796
         fAGWJVH9zoilUzC48DM3meSv9QJnuaqSqAbhoix94DIm9LhaPLM2jv/eYbwCMydtijMT
         fnfiV/NhmFNEI04W7dSQkJdjxJlmeBN5kar9AraOJ8LtGWHYzYQkltKBAAX/I0vxcXXd
         FwhA==
X-Forwarded-Encrypted: i=1; AFNElJ/MopEGFC8JeXRdjgaY4IYr4EOm+HIzpxHLElwcdp9LPY/iv6HnXEebqE/cJMjnP+MH9LIL3CSAUaua0SVv4A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx4hUaeXomZeM6zONjtssIj5wYWkr2gcMCIxuTX8h5H+q1NTp1J
	y7chHs9b9pVLptwbYw8IC2BCYoaThw+P4OvUmNHR0JqdDkPe5tTFlG+c
X-Gm-Gg: Acq92OHoy1qQX2LK/zLSx2Uo3BbysxB03K6oguGkoMkBYVjTd5P49giVjTlxtbXQBKg
	dZosXooytRPMR89rHgsh/xduZvmzgfqFX54x2y0oQkgoeJNEUKTpjRBukWUTMXBRu/Y/vOPUrl8
	YVmTMyOdZjky7yO8kwNv3EFmbez04RAtn/c1rCpc/m/jGAY9WkeMykmq7bWmIjQt4vRheyAglsQ
	hC8jRTF9sKmYAWHlOpTlKWpDarjPxKUBrJNxy98sRVfLPgy23HPoyv6qkiZrPCFxI6517vU/9DM
	L0A+4NdYSju3yTLUiyFnvnr2TOHZDaZ6Ja7D2vecYzL3NKuBlh/6YtVq0Pf+dtHeGTPrBZLZ3By
	61uZrXFhNiL3XN1sHIs4zJ8SN/dWDEJNdt4ab9To59nABCHyVa00yN5lX+lQTJU5sUfUP9bLPrx
	OSCuFpYfE4Xw4+yf6ynx6zZ5cZ9POQHQ==
X-Received: by 2002:a5d:5f90:0:b0:43d:300b:2285 with SMTP id ffacd0b85a97d-45e5c5be273mr27212388f8f.11.1779154080739;
        Mon, 18 May 2026 18:28:00 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f83:8501:800:cd4:5e2:9556])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm40548683f8f.16.2026.05.18.18.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:27:59 -0700 (PDT)
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
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH v4 2/4] mm/swap: move bh draining into a separate workqueue
Date: Mon, 18 May 2026 22:27:48 -0300
Message-ID: <20260519012754.240804-3-leobras.c@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519012754.240804-1-leobras.c@gmail.com>
References: <20260519012754.240804-1-leobras.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6247; i=leobras.c@gmail.com; h=from:subject; bh=dnloqw2ofMQgHOlrcYy0lnqm5BG7U4//P9axIvgFWic=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLK494TzVnNUJFg81Ts0ocTPLebpfN6VmUXcodwz5y0JL 7X/fq22o5SFQYyLQVZMkUX20fxVPN+nZBy58mMBzBxWJpAhDFycAjCR/dsZGZ7evOjOcdlPqGRu KOdb71KxD4+SpaKb4ybbzjk6J2V9UAjD/4xnL3beP7nksgDT/e+u/+W7W/7N3vX6d+XkTRuYzVd UL2YFAA==
X-Developer-Key: i=leobras.c@gmail.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

From: Marcelo Tosatti <mtosatti@redhat.com>

Separate the bh draining into a separate workqueue
(from the mm lru draining), so that its possible to switch
the mm lru draining to QPW.

To switch bh draining to QPW, it would be necessary to add
a spinlock to addition of bhs to percpu cache, and that is a
very hot path.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
---
 mm/swap.c | 52 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 5cc44f0de987..ed9b3d371547 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -744,60 +744,70 @@ void lru_add_drain(void)
 	local_unlock(&cpu_fbatches.lock);
 	mlock_drain_local();
 }
 
 /*
  * It's called from per-cpu workqueue context in SMP case so
  * lru_add_drain_cpu and invalidate_bh_lrus_cpu should run on
  * the same cpu. It shouldn't be a problem in !SMP case since
  * the core is only one and the locks will disable preemption.
  */
-static void lru_add_and_bh_lrus_drain(void)
+static void lru_add_mm_drain(void)
 {
 	local_lock(&cpu_fbatches.lock);
 	lru_add_drain_cpu(smp_processor_id());
 	local_unlock(&cpu_fbatches.lock);
-	invalidate_bh_lrus_cpu();
 	mlock_drain_local();
 }
 
 void lru_add_drain_cpu_zone(struct zone *zone)
 {
 	local_lock(&cpu_fbatches.lock);
 	lru_add_drain_cpu(smp_processor_id());
 	drain_local_pages(zone);
 	local_unlock(&cpu_fbatches.lock);
 	mlock_drain_local();
 }
 
 #ifdef CONFIG_SMP
 
 static DEFINE_PER_CPU(struct work_struct, lru_add_drain_work);
 
 static void lru_add_drain_per_cpu(struct work_struct *dummy)
 {
-	lru_add_and_bh_lrus_drain();
+	lru_add_mm_drain();
 }
 
-static bool cpu_needs_drain(unsigned int cpu)
+static DEFINE_PER_CPU(struct work_struct, bh_add_drain_work);
+
+static void bh_add_drain_per_cpu(struct work_struct *dummy)
+{
+	invalidate_bh_lrus_cpu();
+}
+
+static bool cpu_needs_mm_drain(unsigned int cpu)
 {
 	struct cpu_fbatches *fbatches = &per_cpu(cpu_fbatches, cpu);
 
 	/* Check these in order of likelihood that they're not zero */
 	return folio_batch_count(&fbatches->lru_add) ||
 		folio_batch_count(&fbatches->lru_move_tail) ||
 		folio_batch_count(&fbatches->lru_deactivate_file) ||
 		folio_batch_count(&fbatches->lru_deactivate) ||
 		folio_batch_count(&fbatches->lru_lazyfree) ||
 		folio_batch_count(&fbatches->lru_activate) ||
-		need_mlock_drain(cpu) ||
-		has_bh_in_lru(cpu, NULL);
+		need_mlock_drain(cpu);
+}
+
+static bool cpu_needs_bh_drain(unsigned int cpu)
+{
+	return has_bh_in_lru(cpu, NULL);
 }
 
 /*
  * Doesn't need any cpu hotplug locking because we do rely on per-cpu
  * kworkers being shut down before our page_alloc_cpu_dead callback is
  * executed on the offlined cpu.
  * Calling this function with cpu hotplug locks held can actually lead
  * to obscure indirect dependencies via WQ context.
  */
 static inline void __lru_add_drain_all(bool force_all_cpus)
@@ -806,21 +816,21 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
 	 * lru_drain_gen - Global pages generation number
 	 *
 	 * (A) Definition: global lru_drain_gen = x implies that all generations
 	 *     0 < n <= x are already *scheduled* for draining.
 	 *
 	 * This is an optimization for the highly-contended use case where a
 	 * user space workload keeps constantly generating a flow of pages for
 	 * each CPU.
 	 */
 	static unsigned int lru_drain_gen;
-	static struct cpumask has_work;
+	static struct cpumask has_mm_work, has_bh_work;
 	static DEFINE_MUTEX(lock);
 	unsigned cpu, this_gen;
 
 	/*
 	 * Make sure nobody triggers this path before mm_percpu_wq is fully
 	 * initialized.
 	 */
 	if (WARN_ON(!mm_percpu_wq))
 		return;
 
@@ -869,34 +879,45 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
 	 * along, adds some pages to its per-cpu vectors, then calls
 	 * lru_add_drain_all().
 	 *
 	 * If the paired barrier is done at any later step, e.g. after the
 	 * loop, CPU #x will just exit at (C) and miss flushing out all of its
 	 * added pages.
 	 */
 	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
 	smp_mb();
 
-	cpumask_clear(&has_work);
+	cpumask_clear(&has_mm_work);
+	cpumask_clear(&has_bh_work);
 	for_each_online_cpu(cpu) {
-		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
+		struct work_struct *mm_work = &per_cpu(lru_add_drain_work, cpu);
+		struct work_struct *bh_work = &per_cpu(bh_add_drain_work, cpu);
 
-		if (cpu_needs_drain(cpu)) {
-			INIT_WORK(work, lru_add_drain_per_cpu);
-			queue_work_on(cpu, mm_percpu_wq, work);
-			__cpumask_set_cpu(cpu, &has_work);
+		if (cpu_needs_mm_drain(cpu)) {
+			INIT_WORK(mm_work, lru_add_drain_per_cpu);
+			queue_work_on(cpu, mm_percpu_wq, mm_work);
+			__cpumask_set_cpu(cpu, &has_mm_work);
+		}
+
+		if (cpu_needs_bh_drain(cpu)) {
+			INIT_WORK(bh_work, bh_add_drain_per_cpu);
+			queue_work_on(cpu, mm_percpu_wq, bh_work);
+			__cpumask_set_cpu(cpu, &has_bh_work);
 		}
 	}
 
-	for_each_cpu(cpu, &has_work)
+	for_each_cpu(cpu, &has_mm_work)
 		flush_work(&per_cpu(lru_add_drain_work, cpu));
 
+	for_each_cpu(cpu, &has_bh_work)
+		flush_work(&per_cpu(bh_add_drain_work, cpu));
+
 done:
 	mutex_unlock(&lock);
 }
 
 void lru_add_drain_all(void)
 {
 	__lru_add_drain_all(false);
 }
 #else
 void lru_add_drain_all(void)
@@ -928,21 +949,22 @@ void lru_cache_disable(void)
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
-	lru_add_and_bh_lrus_drain();
+	lru_add_mm_drain();
+	invalidate_bh_lrus_cpu();
 #endif
 }
 
 /**
  * folios_put_refs - Reduce the reference count on a batch of folios.
  * @folios: The folios.
  * @refs: The number of refs to subtract from each folio.
  *
  * Like folio_put(), but for a batch of folios.  This is more efficient
  * than writing the loop yourself as it will optimise the locks which need
-- 
2.54.0

