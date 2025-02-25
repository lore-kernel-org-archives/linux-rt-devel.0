Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1211B26B2D3
	for <linux-rt-devel@lists.linux.dev>; Tue, 25 Feb 2025 13:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740491616; cv=none; b=Gyzk+7IUMQQXDHPr4ZBZBAZbVEZ+m+Si3LX8WnpVS6bWBmjxCziCFDrdjFWwVQ9cvTJbB7LIzQBqMgpjpJ4ky8q4ZpYfh/F4k7fIyOcF7VYOXE35MqZ1KIn7unDVr+FJ5AoN25qcC8vUNFJ+PKfC7ZkHQNUtv2a3CDifYMCLLJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740491616; c=relaxed/simple;
	bh=kQMr7lWB3rM6vME9JhMVerK8QenMCmn2LtBMP2BTz08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ehq+DeNv7mzhzxBWztmHoJK0A3TI3uaY0WUZV5D9blp1KgMPIFnmAOR3kJUHXzo+4GUSMFyrOezCbNH4ZLg0wBUfl2JJoULhxS/+6od3JUjwZZ5i7wZbqy/fWS6dWP1WrK+fWB/l526ymfhqc2mzZsn1GzvKPojEwS8sA9kh7Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B11E21E4D;
	Tue, 25 Feb 2025 05:53:50 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A56593F6A8;
	Tue, 25 Feb 2025 05:53:32 -0800 (PST)
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	james.clark@linaro.org,
	alexander.shishkin@linux.intel.com,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org
Cc: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v5 3/9] coresight: change coresight_trace_id_map's lock type to raw_spinlock_t
Date: Tue, 25 Feb 2025 13:52:54 +0000
Message-Id: <20250225135300.339976-4-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250225135300.339976-1-yeoreum.yun@arm.com>
References: <20250225135300.339976-1-yeoreum.yun@arm.com>
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
index 0a9380350fb5..82dc1bacb144 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1239,7 +1239,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 
 	if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
 	    csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
-		spin_lock_init(&csdev->perf_sink_id_map.lock);
+		raw_spin_lock_init(&csdev->perf_sink_id_map.lock);
 		csdev->perf_sink_id_map.cpu_map = alloc_percpu(atomic_t);
 		if (!csdev->perf_sink_id_map.cpu_map) {
 			kfree(csdev);
diff --git a/drivers/hwtracing/coresight/coresight-trace-id.c b/drivers/hwtracing/coresight/coresight-trace-id.c
index 378af743be45..7ed337d54d3e 100644
--- a/drivers/hwtracing/coresight/coresight-trace-id.c
+++ b/drivers/hwtracing/coresight/coresight-trace-id.c
@@ -22,7 +22,7 @@ enum trace_id_flags {
 static DEFINE_PER_CPU(atomic_t, id_map_default_cpu_ids) = ATOMIC_INIT(0);
 static struct coresight_trace_id_map id_map_default = {
 	.cpu_map = &id_map_default_cpu_ids,
-	.lock = __SPIN_LOCK_UNLOCKED(id_map_default.lock)
+	.lock = __RAW_SPIN_LOCK_UNLOCKED(id_map_default.lock)
 };
 
 /* #define TRACE_ID_DEBUG 1 */
@@ -131,11 +131,11 @@ static void coresight_trace_id_release_all(struct coresight_trace_id_map *id_map
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
 
@@ -144,7 +144,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 	unsigned long flags;
 	int id;
 
-	spin_lock_irqsave(&id_map->lock, flags);
+	raw_spin_lock_irqsave(&id_map->lock, flags);
 
 	/* check for existing allocation for this CPU */
 	id = _coresight_trace_id_read_cpu_id(cpu, id_map);
@@ -171,7 +171,7 @@ static int _coresight_trace_id_get_cpu_id(int cpu, struct coresight_trace_id_map
 	atomic_set(per_cpu_ptr(id_map->cpu_map, cpu), id);
 
 get_cpu_id_out_unlock:
-	spin_unlock_irqrestore(&id_map->lock, flags);
+	raw_spin_unlock_irqrestore(&id_map->lock, flags);
 
 	DUMP_ID_CPU(cpu, id);
 	DUMP_ID_MAP(id_map);
@@ -188,12 +188,12 @@ static void _coresight_trace_id_put_cpu_id(int cpu, struct coresight_trace_id_ma
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
@@ -204,9 +204,9 @@ static int coresight_trace_id_map_get_system_id(struct coresight_trace_id_map *i
 	unsigned long flags;
 	int id;
 
-	spin_lock_irqsave(&id_map->lock, flags);
+	raw_spin_lock_irqsave(&id_map->lock, flags);
 	id = coresight_trace_id_alloc_new_id(id_map, preferred_id, traceid_flags);
-	spin_unlock_irqrestore(&id_map->lock, flags);
+	raw_spin_unlock_irqrestore(&id_map->lock, flags);
 
 	DUMP_ID(id);
 	DUMP_ID_MAP(id_map);
@@ -217,9 +217,9 @@ static void coresight_trace_id_map_put_system_id(struct coresight_trace_id_map *
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
index a4fe4da335ac..96fffd2c56e6 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -238,7 +238,7 @@ struct coresight_trace_id_map {
 	DECLARE_BITMAP(used_ids, CORESIGHT_TRACE_IDS_MAX);
 	atomic_t __percpu *cpu_map;
 	atomic_t perf_cs_etm_session_active;
-	spinlock_t lock;
+	raw_spinlock_t lock;
 };
 
 /**
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

