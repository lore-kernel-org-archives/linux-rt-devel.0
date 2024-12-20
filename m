Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AC01BD00A
	for <linux-rt-devel@lists.linux.dev>; Fri, 20 Dec 2024 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734691537; cv=none; b=i9VRcDNs6n38g4jRRiGczch3wk12pOsgdPHaYQgRs+cdM+ZVYLz07qKqeIoAWwzDHgyeDPI+kXOiVxHLnusoDVAT+Joe8tE/iLvoJG1dViRFnV2W1xmVkU2Cqc8Kem9tEOUPS0wfDqYnGEFaA47dQMO+hg+oV324fgdioL2mDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734691537; c=relaxed/simple;
	bh=5hcRys7vWlDfCUAt5mKKa1yibkFDpz3b8L4QxEbqwmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PkVo/1tR6/+Dp3U44/ebWRW1pF6o5ViWQFTdUrUIm3jcUhLWd2FMNI8EQ+JFzZrOwZqho7HxkQ6/3o6eGT72CkWgkS2WdOBNRD6j3UXKfS/daMsesaSrBmzshJE3Ebdkfe/BH2CODCEUNmRmXLA1lcShikn+hwy8K2w5EXPHce4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FE581480;
	Fri, 20 Dec 2024 02:46:03 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 711793F720;
	Fri, 20 Dec 2024 02:45:33 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: suzuki.poulose@arm.com,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	mike.leach@linaro.org
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v4 3/9] coresight: change coresight_trace_id_map's lock type to  raw_spinlock_t
Date: Fri, 20 Dec 2024 10:45:15 +0000
Message-Id: <20241220104521.809071-5-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220104521.809071-1-yeoreum.yun@arm.com>
References: <20241220104521.809071-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

coresight_trace_id_map->lock can be acquired while coresight devices'
drvdata_lock.

But the drvdata_lock can be raw_spinlock_t (i.e) coresight-etm4x.

To address this, change type of coresight_trace_id_map->lock to
raw_spinlock_t

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-core.c  |  2 +-
 .../hwtracing/coresight/coresight-trace-id.c  | 22 +++++++++----------
 include/linux/coresight.h                     |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index ea38ecf26fcb..cc2d87b2f248 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1164,7 +1164,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
 	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
-		spin_lock_init(&csdev->perf_sink_id_map.lock);
+		raw_spin_lock_init(&csdev->perf_sink_id_map.lock);
 		csdev->perf_sink_id_map.cpu_map = alloc_percpu(atomic_t);
 		if (!csdev->perf_sink_id_map.cpu_map) {
 			kfree(csdev);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index d98e12cb30ec..a6531869e9ec 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -16,7 +16,7 @@
 static DEFINE_PER_CPU(atomic_t, id_map_default_cpu_ids) = ATOMIC_INIT(0);
 static struct coresight_trace_id_map id_map_default = {
 	.cpu_map = &id_map_default_cpu_ids,
-	.lock = __SPIN_LOCK_UNLOCKED(id_map_default.lock)
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(id_map_default.lock)
 };
 
 /* #define TRACE_ID_DEBUG 1 */
@@ -121,11 +121,11 @@ static void coresight_trace_id_release_all(struct coresight_trace_id_map *id_map
 	unsigned long flags;
 	int cpu;
 
-	spin_lock_irqsave(&id_map->lock, flags);
+	raw_spin_lock_irqsave(&id_map->lock, flags);
 	bitmap_zero(id_map->used_ids, CORESIGHT_TRACE_IDS_MAX);
 	for_each_possible_cpu(cpu)
 		atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
-	spin_unlock_irqrestore(&id_map->lock, flags);
+	raw_spin_unlock_irqrestore(&id_map->lock, flags);
 	DUMP_ID_MAP(id_map);
 }
 
@@ -134,7 +134,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 	unsigned long flags;
 	int id;
 
-	spin_lock_irqsave(&id_map->lock, flags);
+	raw_spin_lock_irqsave(&id_map->lock, flags);
 
 	/* check for existing allocation for this CPU */
 	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
@@ -161,7 +161,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
 
 get_cpu_id_out_unlock:
-	spin_unlock_irqrestore(&id_map->lock, flags);
+	raw_spin_unlock_irqrestore(&id_map->lock, flags);
 
 	DUMP_ID_CPU(cpu, id);
 	DUMP_ID_MAP(id_map);
@@ -178,12 +178,12 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
 	if (!id)
 		return;
 
-	spin_lock_irqsave(&id_map->lock, flags);
+	raw_spin_lock_irqsave(&id_map->lock, flags);
 
 	coresight_trace_id_free(id, id_map);
 	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), 0);
 
-	spin_unlock_irqrestore(&id_map->lock, flags);
+	raw_spin_unlock_irqrestore(&id_map->lock, flags);
 	DUMP_ID_CPU(cpu, id);
 	DUMP_ID_MAP(id_map);
 }
@@ -193,10 +193,10 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
 	unsigned long flags;
 	int id;
 
-	spin_lock_irqsave(&id_map->lock, flags);
+	raw_spin_lock_irqsave(&id_map->lock, flags);
 	/* prefer odd IDs for system components to avoid legacy CPU IDS */
 	id = coresight_trace_id_alloc_new_id(id_map, 0, true);
-	spin_unlock_irqrestore(&id_map->lock, flags);
+	raw_spin_unlock_irqrestore(&id_map->lock, flags);
 
 	DUMP_ID(id);
 	DUMP_ID_MAP(id_map);
@@ -207,9 +207,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&id_map->lock, flags);
+	raw_spin_lock_irqsave(&id_map->lock, flags);
 	coresight_trace_id_free(id, id_map);
-	spin_unlock_irqrestore(&id_map->lock, flags);
+	raw_spin_unlock_irqrestore(&id_map->lock, flags);
 
 	DUMP_ID(id);
 	DUMP_ID_MAP(id_map);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 924b58c343b3..6446ca1f09d8 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -233,7 +233,7 @@ struct coresight_trace_id_map {
 	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
 	atomic_t __percpu *cpu_map;
 	atomic_t perf_cs_etm_session_active;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
 
 /**
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

