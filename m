Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B61551E47DC
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Dec 2024 11:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226596; cv=none; b=InV/Q9/IPoHo/Ql6iFgQbRHDPRnS68ZtRYl/2KagQ8hF+d1IX6hjqQxcc5+8VQ6SO0ssI5lqH4AUDF3RMWXihxisY0Glo0Wijwk0bF29HgoX+zKa5o2M43N14WIYlG/ehZ3SL24hN3gXKti/hd7nGvPEAEjk5YnLjPx3seNsCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226596; c=relaxed/simple;
	bh=HBRmL7yUDdz9z73mngwQK3WqyB4pedtkTzZawzcyHdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZzU2FmZzXhvs2BRCYCshM5fIxpP4X5zp2lz4SF4liAwxpn12uxanbdALxMcGeE/ESs2fwrPHGYd0aaCToMt2PIHUpcelmrgeMePTcP4RHnfvqh7bLfqWnT71lyrikJ0Lkd9IErHmKHGV8oqNkvGup78ojCq6C0h+YpkTcHgJ3CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3700E1BF3;
	Tue,  3 Dec 2024 03:50:21 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3A32D3F58B;
	Tue,  3 Dec 2024 03:49:51 -0800 (PST)
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
	nd@arm.com,
	Yeoreum Yun <yeoreum.yun@arm.com>
Subject: [PATCH v2 2/9] coresight-etm4x: change etmv4_drvdata spinlock type to raw_spinlock_t
Date: Tue,  3 Dec 2024 11:49:35 +0000
Message-Id: <20241203114942.697188-3-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203114942.697188-1-yeoreum.yun@arm.com>
References: <20241203114942.697188-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In coresight-etm4x drivers, etmv4_drvdata->spinlock can be held during
__schedule() by perf_event_task_sched_out()/in().

Since etmv4_drvdata->spinlock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this, change type etmv4_drvdata->spinlock
in coresight-etm4x drivers, which can be called
by perf_event_task_sched_out()/in(), from spinlock_t to raw_spinlock_t.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 .../hwtracing/coresight/coresight-config.c    |   8 +-
 .../hwtracing/coresight/coresight-config.h    |   2 +-
 .../coresight/coresight-etm4x-core.c          |  10 +-
 .../coresight/coresight-etm4x-sysfs.c         | 250 +++++++++---------
 drivers/hwtracing/coresight/coresight-etm4x.h |   2 +-
 5 files changed, 136 insertions(+), 136 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-config.c b/drivers/hwtracing/coresight/coresight-config.c
index 4723bf7402a2..4f72ae71b696 100644
--- a/drivers/hwtracing/coresight/coresight-config.c
+++ b/drivers/hwtracing/coresight/coresight-config.c
@@ -76,10 +76,10 @@ static int cscfg_set_on_enable(struct cscfg_feature_csdev *feat_csdev)
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
+	raw_spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
 	for (i = 0; i < feat_csdev->nr_regs; i++)
 		cscfg_set_reg(&feat_csdev->regs_csdev[i]);
-	spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
+	raw_spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
 	dev_dbg(&feat_csdev->csdev->dev, "Feature %s: %s",
 		feat_csdev->feat_desc->name, "set on enable");
 	return 0;
@@ -91,10 +91,10 @@ static void cscfg_save_on_disable(struct cscfg_feature_csdev *feat_csdev)
 	unsigned long flags;
 	int i;
 
-	spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
+	raw_spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
 	for (i = 0; i < feat_csdev->nr_regs; i++)
 		cscfg_save_reg(&feat_csdev->regs_csdev[i]);
-	spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
+	raw_spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
 	dev_dbg(&feat_csdev->csdev->dev, "Feature %s: %s",
 		feat_csdev->feat_desc->name, "save on disable");
 }
diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 6ba013975741..b9ebc9fcfb7f 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -206,7 +206,7 @@ struct cscfg_feature_csdev {
 	const struct cscfg_feature_desc *feat_desc;
 	struct coresight_device *csdev;
 	struct list_head node;
-	spinlock_t *drv_spinlock;
+	raw_spinlock_t *drv_spinlock;
 	int nr_params;
 	struct cscfg_parameter_csdev *params_csdev;
 	int nr_regs;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index dd8c74f893db..8cf1d4090533 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -807,7 +807,7 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 			return ret;
 	}
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 
 	/* sysfs needs to read and allocate a trace ID */
 	ret = etm4_read_alloc_trace_id(drvdata);
@@ -830,7 +830,7 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 		etm4_release_trace_id(drvdata);
 
 unlock_sysfs_enable:
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	if (!ret)
 		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
@@ -977,7 +977,7 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	 * DYING hotplug callback is serviced by the ETM driver.
 	 */
 	cpus_read_lock();
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 
 	/*
 	 * Executing etm4_disable_hw on the cpu whose ETM is being disabled
@@ -985,7 +985,7 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	 */
 	smp_call_function_single(drvdata->cpu, etm4_disable_hw, drvdata, 1);
 
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
 	/*
@@ -2125,7 +2125,7 @@ static int etm4_probe(struct device *dev)
 			return -ENOMEM;
 	}
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 
 	drvdata->cpu = coresight_get_cpu(dev);
 	if (drvdata->cpu < 0)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a9f19629f3f8..11e865b8e824 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -174,7 +174,7 @@ static ssize_t reset_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	if (val)
 		config->mode = 0x0;
 
@@ -266,7 +266,7 @@ static ssize_t reset_store(struct device *dev,
 	config->vmid_mask0 = 0x0;
 	config->vmid_mask1 = 0x0;
 
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	/* for sysfs - only release trace id when resetting */
 	etm4_release_trace_id(drvdata);
@@ -300,7 +300,7 @@ static ssize_t mode_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->mode = val & ETMv4_MODE_ALL;
 
 	if (drvdata->instrp0 == true) {
@@ -437,7 +437,7 @@ static ssize_t mode_store(struct device *dev,
 	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
 		etm4_config_trace_mode(config);
 
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -466,14 +466,14 @@ static ssize_t pe_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	if (val > drvdata->nr_pe) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
 
 	config->pe_sel = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(pe);
@@ -501,7 +501,7 @@ static ssize_t event_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	switch (drvdata->nr_event) {
 	case 0x0:
 		/* EVENT0, bits[7:0] */
@@ -522,7 +522,7 @@ static ssize_t event_store(struct device *dev,
 	default:
 		break;
 	}
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(event);
@@ -550,7 +550,7 @@ static ssize_t event_instren_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	/* start by clearing all instruction event enable bits */
 	config->eventctrl1 &= ~TRCEVENTCTL1R_INSTEN_MASK;
 	switch (drvdata->nr_event) {
@@ -578,7 +578,7 @@ static ssize_t event_instren_store(struct device *dev,
 	default:
 		break;
 	}
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(event_instren);
@@ -739,11 +739,11 @@ static ssize_t event_vinst_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val &= TRCVICTLR_EVENT_MASK >> __bf_shf(TRCVICTLR_EVENT_MASK);
 	config->vinst_ctrl &= ~TRCVICTLR_EVENT_MASK;
 	config->vinst_ctrl |= FIELD_PREP(TRCVICTLR_EVENT_MASK, val);
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(event_vinst);
@@ -771,13 +771,13 @@ static ssize_t s_exlevel_vinst_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	/* clear all EXLEVEL_S bits  */
 	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_S_MASK;
 	/* enable instruction tracing for corresponding exception level */
 	val &= drvdata->s_ex_level;
 	config->vinst_ctrl |= val << __bf_shf(TRCVICTLR_EXLEVEL_S_MASK);
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(s_exlevel_vinst);
@@ -806,13 +806,13 @@ static ssize_t ns_exlevel_vinst_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	/* clear EXLEVEL_NS bits  */
 	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_NS_MASK;
 	/* enable instruction tracing for corresponding exception level */
 	val &= drvdata->ns_ex_level;
 	config->vinst_ctrl |= val << __bf_shf(TRCVICTLR_EXLEVEL_NS_MASK);
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(ns_exlevel_vinst);
@@ -846,9 +846,9 @@ static ssize_t addr_idx_store(struct device *dev,
 	 * Use spinlock to ensure index doesn't change while it gets
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->addr_idx = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(addr_idx);
@@ -862,7 +862,7 @@ static ssize_t addr_instdatatype_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	val = FIELD_GET(TRCACATRn_TYPE_MASK, config->addr_acc[idx]);
 	len = scnprintf(buf, PAGE_SIZE, "%s\n",
@@ -870,7 +870,7 @@ static ssize_t addr_instdatatype_show(struct device *dev,
 			(val == TRCACATRn_TYPE_DATA_LOAD_ADDR ? "data_load" :
 			(val == TRCACATRn_TYPE_DATA_STORE_ADDR ? "data_store" :
 			"data_load_store")));
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return len;
 }
 
@@ -888,13 +888,13 @@ static ssize_t addr_instdatatype_store(struct device *dev,
 	if (sscanf(buf, "%s", str) != 1)
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!strcmp(str, "instr"))
 		/* TYPE, bits[1:0] */
 		config->addr_acc[idx] &= ~TRCACATRn_TYPE_MASK;
 
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(addr_instdatatype);
@@ -909,14 +909,14 @@ static ssize_t addr_single_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	idx = config->addr_idx;
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 	val = (unsigned long)config->addr_val[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -932,17 +932,17 @@ static ssize_t addr_single_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
 	config->addr_val[idx] = (u64)val;
 	config->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(addr_single);
@@ -956,23 +956,23 @@ static ssize_t addr_range_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (idx % 2 != 0) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 	if (!((config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
 	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
 	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
 	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
 	val1 = (unsigned long)config->addr_val[idx];
 	val2 = (unsigned long)config->addr_val[idx + 1];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
 }
 
@@ -995,10 +995,10 @@ static ssize_t addr_range_store(struct device *dev,
 	if (val1 > val2)
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (idx % 2 != 0) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
@@ -1006,7 +1006,7 @@ static ssize_t addr_range_store(struct device *dev,
 	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
 	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
 	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
@@ -1023,7 +1023,7 @@ static ssize_t addr_range_store(struct device *dev,
 		exclude = config->mode & ETM_MODE_EXCLUDE;
 	etm4_set_mode_exclude(drvdata, exclude ? true : false);
 
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(addr_range);
@@ -1037,17 +1037,17 @@ static ssize_t addr_start_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
 	val = (unsigned long)config->addr_val[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1063,22 +1063,22 @@ static ssize_t addr_start_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!drvdata->nr_addr_cmp) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
 	config->addr_val[idx] = (u64)val;
 	config->addr_type[idx] = ETM_ADDR_TYPE_START;
 	config->vissctlr |= BIT(idx);
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(addr_start);
@@ -1092,17 +1092,17 @@ static ssize_t addr_stop_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
 	val = (unsigned long)config->addr_val[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1118,22 +1118,22 @@ static ssize_t addr_stop_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!drvdata->nr_addr_cmp) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	       config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
 	config->addr_val[idx] = (u64)val;
 	config->addr_type[idx] = ETM_ADDR_TYPE_STOP;
 	config->vissctlr |= BIT(idx + 16);
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(addr_stop);
@@ -1147,14 +1147,14 @@ static ssize_t addr_ctxtype_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	/* CONTEXTTYPE, bits[3:2] */
 	val = FIELD_GET(TRCACATRn_CONTEXTTYPE_MASK, config->addr_acc[idx]);
 	len = scnprintf(buf, PAGE_SIZE, "%s\n", val == ETM_CTX_NONE ? "none" :
 			(val == ETM_CTX_CTXID ? "ctxid" :
 			(val == ETM_CTX_VMID ? "vmid" : "all")));
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return len;
 }
 
@@ -1172,7 +1172,7 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 	if (sscanf(buf, "%s", str) != 1)
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!strcmp(str, "none"))
 		/* start by clearing context type bits */
@@ -1199,7 +1199,7 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 		if (drvdata->numvmidc)
 			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_VMID;
 	}
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(addr_ctxtype);
@@ -1213,11 +1213,11 @@ static ssize_t addr_context_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	/* context ID comparator bits[6:4] */
 	val = FIELD_GET(TRCACATRn_CONTEXT_MASK, config->addr_acc[idx]);
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1238,12 +1238,12 @@ static ssize_t addr_context_store(struct device *dev,
 		     drvdata->numcidc : drvdata->numvmidc))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	/* clear context ID comparator bits[6:4] */
 	config->addr_acc[idx] &= ~TRCACATRn_CONTEXT_MASK;
 	config->addr_acc[idx] |= val << __bf_shf(TRCACATRn_CONTEXT_MASK);
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(addr_context);
@@ -1257,10 +1257,10 @@ static ssize_t addr_exlevel_s_ns_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	val = FIELD_GET(TRCACATRn_EXLEVEL_MASK, config->addr_acc[idx]);
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1279,12 +1279,12 @@ static ssize_t addr_exlevel_s_ns_store(struct device *dev,
 	if (val & ~(TRCACATRn_EXLEVEL_MASK >> __bf_shf(TRCACATRn_EXLEVEL_MASK)))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	/* clear Exlevel_ns & Exlevel_s bits[14:12, 11:8], bit[15] is res0 */
 	config->addr_acc[idx] &= ~TRCACATRn_EXLEVEL_MASK;
 	config->addr_acc[idx] |= val << __bf_shf(TRCACATRn_EXLEVEL_MASK);
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(addr_exlevel_s_ns);
@@ -1307,7 +1307,7 @@ static ssize_t addr_cmp_view_show(struct device *dev,
 	int size = 0;
 	bool exclude = false;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	addr_v = config->addr_val[idx];
 	addr_ctrl = config->addr_acc[idx];
@@ -1322,7 +1322,7 @@ static ssize_t addr_cmp_view_show(struct device *dev,
 		}
 		exclude = config->viiectlr & BIT(idx / 2 + 16);
 	}
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	if (addr_type) {
 		size = scnprintf(buf, PAGE_SIZE, "addr_cmp[%i] %s %#lx", idx,
 				 addr_type_names[addr_type], addr_v);
@@ -1366,9 +1366,9 @@ static ssize_t vinst_pe_cmp_start_stop_store(struct device *dev,
 	if (!drvdata->nr_pe_cmp)
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->vipcssctlr = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(vinst_pe_cmp_start_stop);
@@ -1402,9 +1402,9 @@ static ssize_t seq_idx_store(struct device *dev,
 	 * Use spinlock to ensure index doesn't change while it gets
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->seq_idx = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(seq_idx);
@@ -1448,10 +1448,10 @@ static ssize_t seq_event_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->seq_idx;
 	val = config->seq_ctrl[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1467,11 +1467,11 @@ static ssize_t seq_event_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->seq_idx;
 	/* Seq control has two masks B[15:8] F[7:0] */
 	config->seq_ctrl[idx] = val & 0xFFFF;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(seq_event);
@@ -1535,9 +1535,9 @@ static ssize_t cntr_idx_store(struct device *dev,
 	 * Use spinlock to ensure index doesn't change while it gets
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->cntr_idx = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(cntr_idx);
@@ -1551,10 +1551,10 @@ static ssize_t cntrldvr_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->cntr_idx;
 	val = config->cntrldvr[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1572,10 +1572,10 @@ static ssize_t cntrldvr_store(struct device *dev,
 	if (val > ETM_CNTR_MAX_VAL)
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->cntr_idx;
 	config->cntrldvr[idx] = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(cntrldvr);
@@ -1589,10 +1589,10 @@ static ssize_t cntr_val_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->cntr_idx;
 	val = config->cntr_val[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1610,10 +1610,10 @@ static ssize_t cntr_val_store(struct device *dev,
 	if (val > ETM_CNTR_MAX_VAL)
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->cntr_idx;
 	config->cntr_val[idx] = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(cntr_val);
@@ -1627,10 +1627,10 @@ static ssize_t cntr_ctrl_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->cntr_idx;
 	val = config->cntr_ctrl[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1646,10 +1646,10 @@ static ssize_t cntr_ctrl_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->cntr_idx;
 	config->cntr_ctrl[idx] = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(cntr_ctrl);
@@ -1687,9 +1687,9 @@ static ssize_t res_idx_store(struct device *dev,
 	 * Use spinlock to ensure index doesn't change while it gets
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->res_idx = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(res_idx);
@@ -1703,10 +1703,10 @@ static ssize_t res_ctrl_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->res_idx;
 	val = config->res_ctrl[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1722,7 +1722,7 @@ static ssize_t res_ctrl_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->res_idx;
 	/* For odd idx pair inversal bit is RES0 */
 	if (idx % 2 != 0)
@@ -1732,7 +1732,7 @@ static ssize_t res_ctrl_store(struct device *dev,
 				       TRCRSCTLRn_INV |
 				       TRCRSCTLRn_GROUP_MASK |
 				       TRCRSCTLRn_SELECT_MASK);
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(res_ctrl);
@@ -1761,9 +1761,9 @@ static ssize_t sshot_idx_store(struct device *dev,
 	if (val >= drvdata->nr_ss_cmp)
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->ss_idx = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(sshot_idx);
@@ -1776,9 +1776,9 @@ static ssize_t sshot_ctrl_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->ss_ctrl[config->ss_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1794,12 +1794,12 @@ static ssize_t sshot_ctrl_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->ss_idx;
 	config->ss_ctrl[idx] = FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
 	/* must clear bit 31 in related status register on programming */
 	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(sshot_ctrl);
@@ -1811,9 +1811,9 @@ static ssize_t sshot_status_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->ss_status[config->ss_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(sshot_status);
@@ -1826,9 +1826,9 @@ static ssize_t sshot_pe_ctrl_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etmv4_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->ss_pe_cmp[config->ss_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1844,12 +1844,12 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->ss_idx;
 	config->ss_pe_cmp[idx] = FIELD_PREP(TRCSSPCICRn_PC_MASK, val);
 	/* must clear bit 31 in related status register on programming */
 	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(sshot_pe_ctrl);
@@ -1883,9 +1883,9 @@ static ssize_t ctxid_idx_store(struct device *dev,
 	 * Use spinlock to ensure index doesn't change while it gets
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->ctxid_idx = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(ctxid_idx);
@@ -1906,10 +1906,10 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	if (task_active_pid_ns(current) != &init_pid_ns)
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->ctxid_idx;
 	val = (unsigned long)config->ctxid_pid[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1944,10 +1944,10 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	if (kstrtoul(buf, 16, &pid))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->ctxid_idx;
 	config->ctxid_pid[idx] = (u64)pid;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(ctxid_pid);
@@ -1967,10 +1967,10 @@ static ssize_t ctxid_masks_show(struct device *dev,
 	if (task_active_pid_ns(current) != &init_pid_ns)
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val1 = config->ctxid_mask0;
 	val2 = config->ctxid_mask1;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
 }
 
@@ -2003,7 +2003,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	if ((drvdata->numcidc > 4) && (nr_inputs != 2))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	/*
 	 * each byte[0..3] controls mask value applied to ctxid
 	 * comparator[0..3]
@@ -2075,7 +2075,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 			mask >>= 0x8;
 	}
 
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(ctxid_masks);
@@ -2109,9 +2109,9 @@ static ssize_t vmid_idx_store(struct device *dev,
 	 * Use spinlock to ensure index doesn't change while it gets
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->vmid_idx = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(vmid_idx);
@@ -2131,9 +2131,9 @@ static ssize_t vmid_val_show(struct device *dev,
 	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = (unsigned long)config->vmid_val[config->vmid_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -2161,9 +2161,9 @@ static ssize_t vmid_val_store(struct device *dev,
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->vmid_val[config->vmid_idx] = (u64)val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(vmid_val);
@@ -2182,10 +2182,10 @@ static ssize_t vmid_masks_show(struct device *dev,
 	if (!task_is_in_init_pid_ns(current))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val1 = config->vmid_mask0;
 	val2 = config->vmid_mask1;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
 }
 
@@ -2217,7 +2217,7 @@ static ssize_t vmid_masks_store(struct device *dev,
 	if ((drvdata->numvmidc > 4) && (nr_inputs != 2))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 
 	/*
 	 * each byte[0..3] controls mask value applied to vmid
@@ -2290,7 +2290,7 @@ static ssize_t vmid_masks_store(struct device *dev,
 		else
 			mask >>= 0x8;
 	}
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_RW(vmid_masks);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 9e9165f62e81..366f8f23a3e5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -989,7 +989,7 @@ struct etmv4_drvdata {
 	struct clk			*pclk;
 	void __iomem			*base;
 	struct coresight_device		*csdev;
-	spinlock_t			spinlock;
+	raw_spinlock_t			spinlock;
 	int				cpu;
 	u8				arch;
 	u8				nr_pe;
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

