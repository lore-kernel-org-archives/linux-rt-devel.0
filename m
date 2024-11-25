Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31C6192B90
	for <linux-rt-devel@lists.linux.dev>; Mon, 25 Nov 2024 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528113; cv=none; b=ATNzlaXgZ3PQpLJvX8g2ytHrBV4ja5dUo4Kj8GGRqJsx+r3A3DrH2Ljy6LgcP5SRLvNjd7Lf3pV8J+SnbYWBWwPDjRFGG4KznNbMfaltOO5X/V4VNJiV1D+ZKuLcaJrjMfAKu5mXqug/MC8NMAwvTzi1gArKv6cv/KGFfYRRAIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528113; c=relaxed/simple;
	bh=djXJbAb1RGfZ7BDmxDBwgarcNIj+fJ6NdpcnqHzxdhk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hj/EhAqy/AyAFvEoGOw09qtbcyOMCMCWEBfthVDev0vlj8AWMeRduucGeFuZcxXrl8MqIikx+prR+izMtDftNTh6xwO0MdmXTNnIFZtLyY3Ljv4D8mJ/pbW3sZkD8PCPW1nTeYy/kxDmsLwwjNnDn5UfjmYKt610e6DcM3Qrhyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 470201692;
	Mon, 25 Nov 2024 01:49:01 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 133A03F66E;
	Mon, 25 Nov 2024 01:48:28 -0800 (PST)
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
	Levi Yun <yeoreum.yun@arm.com>
Subject: [PATCH 4/9] coresight-cti: change cti_drvdata spinlock's type to raw_spinlock_t
Date: Mon, 25 Nov 2024 09:48:11 +0000
Message-Id: <20241125094816.365472-5-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241125094816.365472-1-yeoreum.yun@arm.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Levi Yun <yeoreum.yun@arm.com>

In coresight-cti drivers, cti_drvdata->spinlock can be held during __schedule()
by perf_event_task_sched_out()/in().

Since cti_drvdata->spinlock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this, change type cti_drvdata->spinlock in coresight-cti drivers,
which can be called by perf_event_task_sched_out()/in(),
from spinlock_t to raw_spinlock_t.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 .../hwtracing/coresight/coresight-cti-core.c  |  65 +++------
 .../hwtracing/coresight/coresight-cti-sysfs.c | 135 ++++++++++--------
 drivers/hwtracing/coresight/coresight-cti.h   |   2 +-
 3 files changed, 96 insertions(+), 106 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
index d2b5a5718c29..1f7766e9a2ea 100644
--- a/drivers/hwtracing/coresight/coresight-cti-core.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -90,10 +90,9 @@ void cti_write_all_hw_regs(struct cti_drvdata *drvdata)
 static int cti_enable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
-	unsigned long flags;
 	int rc = 0;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	guard(raw_spinlock_irqsave)(&drvdata->spinlock);
 
 	/* no need to do anything if enabled or unpowered*/
 	if (config->hw_enabled || !config->hw_powered)
@@ -108,7 +107,6 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
 
 	config->hw_enabled = true;
 	drvdata->config.enable_req_count++;
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return rc;
 
 cti_state_unchanged:
@@ -116,7 +114,6 @@ static int cti_enable_hw(struct cti_drvdata *drvdata)
 
 	/* cannot enable due to error */
 cti_err_not_enabled:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return rc;
 }
 
@@ -125,25 +122,20 @@ static void cti_cpuhp_enable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
 	config->hw_powered = true;
 
 	/* no need to do anything if no enable request */
 	if (!drvdata->config.enable_req_count)
-		goto cti_hp_not_enabled;
+		return;
 
 	/* try to claim the device */
 	if (coresight_claim_device(drvdata->csdev))
-		goto cti_hp_not_enabled;
+		return;
 
 	cti_write_all_hw_regs(drvdata);
 	config->hw_enabled = true;
-	spin_unlock(&drvdata->spinlock);
 	return;
-
-	/* did not re-enable due to no claim / no request */
-cti_hp_not_enabled:
-	spin_unlock(&drvdata->spinlock);
 }
 
 /* disable hardware */
@@ -151,23 +143,20 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
 {
 	struct cti_config *config = &drvdata->config;
 	struct coresight_device *csdev = drvdata->csdev;
-	int ret = 0;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
 
 	/* don't allow negative refcounts, return an error */
-	if (!drvdata->config.enable_req_count) {
-		ret = -EINVAL;
-		goto cti_not_disabled;
-	}
+	if (!drvdata->config.enable_req_count)
+		return -EINVAL;
 
 	/* check refcount - disable on 0 */
 	if (--drvdata->config.enable_req_count > 0)
-		goto cti_not_disabled;
+		return 0;
 
 	/* no need to do anything if disabled or cpu unpowered */
 	if (!config->hw_enabled || !config->hw_powered)
-		goto cti_not_disabled;
+		return 0;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -177,13 +166,7 @@ static int cti_disable_hw(struct cti_drvdata *drvdata)
 
 	coresight_disclaim_device_unlocked(csdev);
 	CS_LOCK(drvdata->base);
-	spin_unlock(&drvdata->spinlock);
-	return ret;
-
-	/* not disabled this call */
-cti_not_disabled:
-	spin_unlock(&drvdata->spinlock);
-	return ret;
+	return 0;
 }
 
 void cti_write_single_reg(struct cti_drvdata *drvdata, int offset, u32 value)
@@ -198,11 +181,11 @@ void cti_write_intack(struct device *dev, u32 ackval)
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct cti_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
+
 	/* write if enabled */
 	if (cti_active(config))
 		cti_write_single_reg(drvdata, CTIINTACK, ackval);
-	spin_unlock(&drvdata->spinlock);
 }
 
 /*
@@ -369,7 +352,7 @@ int cti_channel_trig_op(struct device *dev, enum cti_chan_op op,
 	reg_offset = (direction == CTI_TRIG_IN ? CTIINEN(trigger_idx) :
 		      CTIOUTEN(trigger_idx));
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
 
 	/* read - modify write - the trigger / channel enable value */
 	reg_value = direction == CTI_TRIG_IN ? config->ctiinen[trigger_idx] :
@@ -388,7 +371,6 @@ int cti_channel_trig_op(struct device *dev, enum cti_chan_op op,
 	/* write through if enabled */
 	if (cti_active(config))
 		cti_write_single_reg(drvdata, reg_offset, reg_value);
-	spin_unlock(&drvdata->spinlock);
 	return 0;
 }
 
@@ -406,7 +388,8 @@ int cti_channel_gate_op(struct device *dev, enum cti_chan_gate_op op,
 
 	chan_bitmask = BIT(channel_idx);
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock_irqsave)(&drvdata->spinlock);
+
 	reg_value = config->ctigate;
 	switch (op) {
 	case CTI_GATE_CHAN_ENABLE:
@@ -426,7 +409,6 @@ int cti_channel_gate_op(struct device *dev, enum cti_chan_gate_op op,
 		if (cti_active(config))
 			cti_write_single_reg(drvdata, CTIGATE, reg_value);
 	}
-	spin_unlock(&drvdata->spinlock);
 	return err;
 }
 
@@ -445,7 +427,8 @@ int cti_channel_setop(struct device *dev, enum cti_chan_set_op op,
 
 	chan_bitmask = BIT(channel_idx);
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
+
 	reg_value = config->ctiappset;
 	switch (op) {
 	case CTI_CHAN_SET:
@@ -473,7 +456,6 @@ int cti_channel_setop(struct device *dev, enum cti_chan_set_op op,
 
 	if ((err == 0) && cti_active(config))
 		cti_write_single_reg(drvdata, reg_offset, reg_value);
-	spin_unlock(&drvdata->spinlock);
 
 	return err;
 }
@@ -676,7 +658,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
 	if (WARN_ON_ONCE(drvdata->ctidev.cpu != cpu))
 		return NOTIFY_BAD;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
 
 	switch (cmd) {
 	case CPU_PM_ENTER:
@@ -703,7 +685,7 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
 		if (drvdata->config.enable_req_count) {
 			/* check we can claim the device as we re-power */
 			if (coresight_claim_device(csdev))
-				goto cti_notify_exit;
+				return notify_res;
 
 			drvdata->config.hw_enabled = true;
 			cti_write_all_hw_regs(drvdata);
@@ -715,8 +697,6 @@ static int cti_cpu_pm_notify(struct notifier_block *nb, unsigned long cmd,
 		break;
 	}
 
-cti_notify_exit:
-	spin_unlock(&drvdata->spinlock);
 	return notify_res;
 }
 
@@ -743,11 +723,12 @@ static int cti_dying_cpu(unsigned int cpu)
 	if (!drvdata)
 		return 0;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
+
 	drvdata->config.hw_powered = false;
 	if (drvdata->config.hw_enabled)
 		coresight_disclaim_device(drvdata->csdev);
-	spin_unlock(&drvdata->spinlock);
+
 	return 0;
 }
 
@@ -888,7 +869,7 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->ctidev.ctm_id = 0;
 	INIT_LIST_HEAD(&drvdata->ctidev.trig_cons);
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 
 	/* initialise CTI driver config values */
 	cti_set_default_config(dev, drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index d25dd2737b49..fa149b94a495 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -84,11 +84,11 @@ static ssize_t enable_show(struct device *dev,
 	bool enabled, powered;
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	spin_lock(&drvdata->spinlock);
-	enable_req = drvdata->config.enable_req_count;
-	powered = drvdata->config.hw_powered;
-	enabled = drvdata->config.hw_enabled;
-	spin_unlock(&drvdata->spinlock);
+	scoped_guard(raw_spinlock, &drvdata->spinlock) {
+		enable_req = drvdata->config.enable_req_count;
+		powered = drvdata->config.hw_powered;
+		enabled = drvdata->config.hw_enabled;
+	}
 
 	if (powered)
 		return sprintf(buf, "%d\n", enabled);
@@ -134,9 +134,9 @@ static ssize_t powered_show(struct device *dev,
 	bool powered;
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	spin_lock(&drvdata->spinlock);
-	powered = drvdata->config.hw_powered;
-	spin_unlock(&drvdata->spinlock);
+	scoped_guard(raw_spinlock, &drvdata->spinlock) {
+		powered = drvdata->config.hw_powered;
+	}
 
 	return sprintf(buf, "%d\n", powered);
 }
@@ -181,10 +181,10 @@ static ssize_t coresight_cti_reg_show(struct device *dev,
 	u32 val = 0;
 
 	pm_runtime_get_sync(dev->parent);
-	spin_lock(&drvdata->spinlock);
-	if (drvdata->config.hw_powered)
-		val = readl_relaxed(drvdata->base + cti_attr->off);
-	spin_unlock(&drvdata->spinlock);
+	scoped_guard(raw_spinlock, &drvdata->spinlock) {
+		if (drvdata->config.hw_powered)
+			val = readl_relaxed(drvdata->base + cti_attr->off);
+	}
 	pm_runtime_put_sync(dev->parent);
 	return sysfs_emit(buf, "0x%x\n", val);
 }
@@ -202,10 +202,10 @@ static __maybe_unused ssize_t coresight_cti_reg_store(struct device *dev,
 		return -EINVAL;
 
 	pm_runtime_get_sync(dev->parent);
-	spin_lock(&drvdata->spinlock);
-	if (drvdata->config.hw_powered)
-		cti_write_single_reg(drvdata, cti_attr->off, val);
-	spin_unlock(&drvdata->spinlock);
+	scoped_guard(raw_spinlock, &drvdata->spinlock) {
+		if (drvdata->config.hw_powered)
+			cti_write_single_reg(drvdata, cti_attr->off, val);
+	}
 	pm_runtime_put_sync(dev->parent);
 	return size;
 }
@@ -264,17 +264,18 @@ static ssize_t cti_reg32_show(struct device *dev, char *buf,
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct cti_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
-	if ((reg_offset >= 0) && cti_active(config)) {
-		CS_UNLOCK(drvdata->base);
-		val = readl_relaxed(drvdata->base + reg_offset);
-		if (pcached_val)
-			*pcached_val = val;
-		CS_LOCK(drvdata->base);
-	} else if (pcached_val) {
-		val = *pcached_val;
+	scoped_guard (raw_spinlock, &drvdata->spinlock) {
+		if ((reg_offset >= 0) && cti_active(config)) {
+			CS_UNLOCK(drvdata->base);
+			val = readl_relaxed(drvdata->base + reg_offset);
+			if (pcached_val)
+				*pcached_val = val;
+			CS_LOCK(drvdata->base);
+		} else if (pcached_val) {
+			val = *pcached_val;
+		}
 	}
-	spin_unlock(&drvdata->spinlock);
+
 	return sprintf(buf, "%#x\n", val);
 }
 
@@ -293,7 +294,8 @@ static ssize_t cti_reg32_store(struct device *dev, const char *buf,
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
+
 	/* local store */
 	if (pcached_val)
 		*pcached_val = (u32)val;
@@ -301,7 +303,7 @@ static ssize_t cti_reg32_store(struct device *dev, const char *buf,
 	/* write through if offset and enabled */
 	if ((reg_offset >= 0) && cti_active(config))
 		cti_write_single_reg(drvdata, reg_offset, val);
-	spin_unlock(&drvdata->spinlock);
+
 	return size;
 }
 
@@ -349,9 +351,10 @@ static ssize_t inout_sel_store(struct device *dev,
 	if (val > (CTIINOUTEN_MAX - 1))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
+
 	drvdata->config.ctiinout_sel = val;
-	spin_unlock(&drvdata->spinlock);
+
 	return size;
 }
 static DEVICE_ATTR_RW(inout_sel);
@@ -364,10 +367,11 @@ static ssize_t inen_show(struct device *dev,
 	int index;
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	spin_lock(&drvdata->spinlock);
-	index = drvdata->config.ctiinout_sel;
-	val = drvdata->config.ctiinen[index];
-	spin_unlock(&drvdata->spinlock);
+	scoped_guard(raw_spinlock, &drvdata->spinlock) {
+		index = drvdata->config.ctiinout_sel;
+		val = drvdata->config.ctiinen[index];
+	}
+
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -383,14 +387,15 @@ static ssize_t inen_store(struct device *dev,
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
+
 	index = config->ctiinout_sel;
 	config->ctiinen[index] = val;
 
 	/* write through if enabled */
 	if (cti_active(config))
 		cti_write_single_reg(drvdata, CTIINEN(index), val);
-	spin_unlock(&drvdata->spinlock);
+
 	return size;
 }
 static DEVICE_ATTR_RW(inen);
@@ -403,10 +408,11 @@ static ssize_t outen_show(struct device *dev,
 	int index;
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	spin_lock(&drvdata->spinlock);
-	index = drvdata->config.ctiinout_sel;
-	val = drvdata->config.ctiouten[index];
-	spin_unlock(&drvdata->spinlock);
+	scoped_guard(raw_spinlock, &drvdata->spinlock) {
+		index = drvdata->config.ctiinout_sel;
+		val = drvdata->config.ctiouten[index];
+	}
+
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -422,14 +428,15 @@ static ssize_t outen_store(struct device *dev,
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
+
 	index = config->ctiinout_sel;
 	config->ctiouten[index] = val;
 
 	/* write through if enabled */
 	if (cti_active(config))
 		cti_write_single_reg(drvdata, CTIOUTEN(index), val);
-	spin_unlock(&drvdata->spinlock);
+
 	return size;
 }
 static DEVICE_ATTR_RW(outen);
@@ -463,7 +470,7 @@ static ssize_t appclear_store(struct device *dev,
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
 
 	/* a 1'b1 in appclr clears down the same bit in appset*/
 	config->ctiappset &= ~val;
@@ -471,7 +478,7 @@ static ssize_t appclear_store(struct device *dev,
 	/* write through if enabled */
 	if (cti_active(config))
 		cti_write_single_reg(drvdata, CTIAPPCLEAR, val);
-	spin_unlock(&drvdata->spinlock);
+
 	return size;
 }
 static DEVICE_ATTR_WO(appclear);
@@ -487,12 +494,12 @@ static ssize_t apppulse_store(struct device *dev,
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
 
 	/* write through if enabled */
 	if (cti_active(config))
 		cti_write_single_reg(drvdata, CTIAPPPULSE, val);
-	spin_unlock(&drvdata->spinlock);
+
 	return size;
 }
 static DEVICE_ATTR_WO(apppulse);
@@ -681,9 +688,10 @@ static ssize_t trig_filter_enable_show(struct device *dev,
 	u32 val;
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	spin_lock(&drvdata->spinlock);
-	val = drvdata->config.trig_filter_enable;
-	spin_unlock(&drvdata->spinlock);
+	scoped_guard(raw_spinlock, &drvdata->spinlock) {
+		val = drvdata->config.trig_filter_enable;
+	}
+
 	return sprintf(buf, "%d\n", val);
 }
 
@@ -697,9 +705,10 @@ static ssize_t trig_filter_enable_store(struct device *dev,
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
+
 	drvdata->config.trig_filter_enable = !!val;
-	spin_unlock(&drvdata->spinlock);
+
 	return size;
 }
 static DEVICE_ATTR_RW(trig_filter_enable);
@@ -728,7 +737,7 @@ static ssize_t chan_xtrigs_reset_store(struct device *dev,
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct cti_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
 
 	/* clear the CTI trigger / channel programming registers */
 	for (i = 0; i < config->nr_trig_max; i++) {
@@ -747,7 +756,6 @@ static ssize_t chan_xtrigs_reset_store(struct device *dev,
 	if (cti_active(config))
 		cti_write_all_hw_regs(drvdata);
 
-	spin_unlock(&drvdata->spinlock);
 	return size;
 }
 static DEVICE_ATTR_WO(chan_xtrigs_reset);
@@ -768,9 +776,10 @@ static ssize_t chan_xtrigs_sel_store(struct device *dev,
 	if (val > (drvdata->config.nr_ctm_channels - 1))
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	guard(raw_spinlock)(&drvdata->spinlock);
+
 	drvdata->config.xtrig_rchan_sel = val;
-	spin_unlock(&drvdata->spinlock);
+
 	return size;
 }
 
@@ -781,9 +790,9 @@ static ssize_t chan_xtrigs_sel_show(struct device *dev,
 	unsigned long val;
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	spin_lock(&drvdata->spinlock);
-	val = drvdata->config.xtrig_rchan_sel;
-	spin_unlock(&drvdata->spinlock);
+	scoped_guard(raw_spinlock, &drvdata->spinlock) {
+		val = drvdata->config.xtrig_rchan_sel;
+	}
 
 	return sprintf(buf, "%ld\n", val);
 }
@@ -838,12 +847,12 @@ static ssize_t print_chan_list(struct device *dev,
 	unsigned long inuse_bits = 0, chan_mask;
 
 	/* scan regs to get bitmap of channels in use. */
-	spin_lock(&drvdata->spinlock);
-	for (i = 0; i < config->nr_trig_max; i++) {
-		inuse_bits |= config->ctiinen[i];
-		inuse_bits |= config->ctiouten[i];
+	scoped_guard(raw_spinlock, &drvdata->spinlock) {
+		for (i = 0; i < config->nr_trig_max; i++) {
+			inuse_bits |= config->ctiinen[i];
+			inuse_bits |= config->ctiouten[i];
+		}
 	}
-	spin_unlock(&drvdata->spinlock);
 
 	/* inverse bits if printing free channels */
 	if (!inuse)
diff --git a/drivers/hwtracing/coresight/coresight-cti.h b/drivers/hwtracing/coresight/coresight-cti.h
index cb9ee616d01f..16e310e7e9d4 100644
--- a/drivers/hwtracing/coresight/coresight-cti.h
+++ b/drivers/hwtracing/coresight/coresight-cti.h
@@ -175,7 +175,7 @@ struct cti_drvdata {
 	void __iomem *base;
 	struct coresight_device	*csdev;
 	struct cti_device ctidev;
-	spinlock_t spinlock;
+	raw_spinlock_t spinlock;
 	struct cti_config config;
 	struct list_head node;
 	void (*csdev_release)(struct device *dev);
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

