Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3106B388E61
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 02:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995990; cv=none; b=sC1tf3yvZ5lbFqNK0o8kkvWHzHsqe67mSrL/n060PAhnr5+k3ydn5g+UZnDoD2o6xc8/rN7M+u2jOKWhju1PFWsb+7wOmxKV2fTWTLkRLLmFkRXEv1bYhfdCe6/vTTabUuKjl72UkzuXL2eKQtKmw5bGSefj/PyKwumO5MzrwmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995990; c=relaxed/simple;
	bh=GgTe8TX2AdylKlrinoex62bIZYcc9QkM6JV62oiUe1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q0XMyE8Lf1EnNnHu5cpbKXsJKpUY/e68DYBYhFaCXUERxPT0LscqwMfRt1Zqy5qGGj/R9dvMWPdJijxLMuliMg2uxuOvvSzfMfaNz+dInOAjxO4n+5/eT48qN6DJIQrYniy/YMAU0Sc5Ru8xjSDYcJe9piVMFuhDaRr7F/brjgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Pj2jPE5J; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Pj2jPE5J"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68AD9143D;
	Fri,  2 Oct 2026 19:53:02 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1DA03F763;
	Fri,  2 Oct 2026 19:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790995985; bh=GgTe8TX2AdylKlrinoex62bIZYcc9QkM6JV62oiUe1o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Pj2jPE5J6hff4/lZFfhQ/7C2ORBV24SPe9giiZcKWmVIQfkT7lVVSlSZyTaJ/7grF
	 c7q/abKHKp31BxGgqo135kwPAFI+r7UAW5yJjn32NypfT6sTcFwcKmNx/Vye+OFHKJ
	 qs7G+Y/DnpwUmVJwApgJ73OL6PcSICs0fjphDYe4=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Sat, 03 Oct 2026 03:52:26 +0100
Subject: [PATCH RESEND v13 14/14] coresight: etm3x: rename drvdata->config
 to sysfs_config
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-separate_etm_cfg_v2-v13-14-5d8a29aead95@arm.com>
References: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
In-Reply-To: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
To: Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=38817; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=GgTe8TX2AdylKlrinoex62bIZYcc9QkM6JV62oiUe1o=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqwG3u4vFUr/LUBjyrl9A9zJNnCFhU+U0Az2Akj
 6IluUYocDaJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCasBt7gAKCRBt1cPRWsUx
 M7rgDACL721wngBGzZy9bZgqDuk0C9hISJfUJp3UtJMXi6iNnL5kDMQql57skoR0WQ18xnGxvsa
 PX2w4hzz73IO1uIEQWjEUR4+GGffrktiundtEby2kxgGDDzPMHyyqM5+TTSfu0jZ7Bd93n6fAvJ
 pMafbryQ++SxKeOBbghywI+HPkXvUTxXtgvpETLE3xQARTtz2xf10QpDlfH28wMTTkPGiNS01hi
 x+yI7OIKg9Y9n+P02FIxDUEQ1INvb9k+YZne9+/UjZ7Qcw6EdQcPWpoXjkqFEerP/7UbwwgBK7o
 HhmqZcunG/PizLSfjAKIux357TorL9WFP/X7p/oKOzrKaUQklYM82Kb+SCtJGgwx5MsRyzYSdZ/
 vaNh/o99/hh5dxX8rd/yzuxHBoe1fETHkCfbbX8kjKNTomAeWl4ENKxMsCA+VrSBy31l6wVSrXh
 wpFKypg3PIZglHgdGVVWWnwE1Eiqftc9n/zJHOnIj6OX1cE0crUVxrSpFopZtzF7YB0Vw=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

drvdata->config is used only by the sysfs interface.
Rename it to sysfs_config to clarify its purpose.

For readability, also rename local config variables to sysfs_config
where they refer to drvdata->sysfs_config.

Reviewed-by: Mike Leach <mike.leach@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm.h        |   4 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c |  10 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 356 ++++++++++-----------
 3 files changed, 185 insertions(+), 185 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 560a58a3817c..cf65d89a8e98 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -244,7 +244,7 @@ struct etm_config {
  * @os_unlock:	true if access to management registers is allowed.
  * @traceid:	value of the current ID for this component.
  * @curr_config:	structure holding current running configuration.
- * @config:	structure holding sysfs mode configuration.
+ * @sysfs_config:	structure holding sysfs mode configuration.
  */
 struct etm_drvdata {
 	struct csdev_access		csa;
@@ -260,7 +260,7 @@ struct etm_drvdata {
 	bool				os_unlock;
 	u32				traceid;
 	struct etm_config		curr_config;
-	struct etm_config		config;
+	struct etm_config		sysfs_config;
 };
 
 static inline void etm_writel(struct etm_drvdata *drvdata,
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 0cad9ecb49b6..b670a324bb41 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -518,7 +518,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
 	arg.path = path;
 
 	scoped_guard(spinlock, &drvdata->spinlock) {
-		drvdata->curr_config = drvdata->config;
+		drvdata->curr_config = drvdata->sysfs_config;
 	}
 
 	ret = smp_call_function_single(drvdata->cpu,
@@ -627,7 +627,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	const struct etm_caps *caps = &drvdata->caps;
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 	const struct etm_config *curr_config = &drvdata->curr_config;
 	int i;
 
@@ -643,9 +643,9 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	 * after the sysfs-session has been disabled.
 	 */
 	for (i = 0; i < caps->nr_cntr; i++)
-		config->cntr_val[i] = curr_config->cntr_val[i];
+		sysfs_config->cntr_val[i] = curr_config->cntr_val[i];
 
-	config->seq_curr_state = curr_config->seq_curr_state;
+	sysfs_config->seq_curr_state = curr_config->seq_curr_state;
 
 	/*
 	 * we only release trace IDs when resetting sysfs.
@@ -844,7 +844,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (etm_arch_supported(drvdata->arch) == false)
 		return -EINVAL;
 
-	etm_set_default(&drvdata->config);
+	etm_set_default(&drvdata->sysfs_config);
 
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index c27865d719eb..d185fb8270e1 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -104,7 +104,7 @@ static ssize_t reset_store(struct device *dev,
 	int i, ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
@@ -116,14 +116,14 @@ static ssize_t reset_store(struct device *dev,
 
 	if (val) {
 		spin_lock(&drvdata->spinlock);
-		memset(config, 0, sizeof(struct etm_config));
-		config->mode = ETM_MODE_EXCLUDE;
-		config->trigger_event = ETM_DEFAULT_EVENT_VAL;
+		memset(sysfs_config, 0, sizeof(struct etm_config));
+		sysfs_config->mode = ETM_MODE_EXCLUDE;
+		sysfs_config->trigger_event = ETM_DEFAULT_EVENT_VAL;
 		for (i = 0; i < drvdata->caps.nr_addr_cmp; i++) {
-			config->addr_type[i] = ETM_ADDR_TYPE_NONE;
+			sysfs_config->addr_type[i] = ETM_ADDR_TYPE_NONE;
 		}
 
-		etm_set_default(config);
+		etm_set_default(sysfs_config);
 		etm_release_trace_id(drvdata);
 		spin_unlock(&drvdata->spinlock);
 	}
@@ -137,9 +137,9 @@ static ssize_t mode_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->mode;
+	val = sysfs_config->mode;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -151,62 +151,62 @@ static ssize_t mode_store(struct device *dev,
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etm_caps *caps = &drvdata->caps;
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	config->mode = val & ETM_MODE_ALL;
+	sysfs_config->mode = val & ETM_MODE_ALL;
 
-	if (config->mode & ETM_MODE_EXCLUDE)
-		config->enable_ctrl1 |= ETMTECR1_INC_EXC;
+	if (sysfs_config->mode & ETM_MODE_EXCLUDE)
+		sysfs_config->enable_ctrl1 |= ETMTECR1_INC_EXC;
 	else
-		config->enable_ctrl1 &= ~ETMTECR1_INC_EXC;
+		sysfs_config->enable_ctrl1 &= ~ETMTECR1_INC_EXC;
 
-	if (config->mode & ETM_MODE_CYCACC)
-		config->ctrl |= ETMCR_CYC_ACC;
+	if (sysfs_config->mode & ETM_MODE_CYCACC)
+		sysfs_config->ctrl |= ETMCR_CYC_ACC;
 	else
-		config->ctrl &= ~ETMCR_CYC_ACC;
+		sysfs_config->ctrl &= ~ETMCR_CYC_ACC;
 
-	if (config->mode & ETM_MODE_STALL) {
+	if (sysfs_config->mode & ETM_MODE_STALL) {
 		if (!caps->fifofull) {
 			dev_warn(dev, "stall mode not supported\n");
 			ret = -EINVAL;
 			goto err_unlock;
 		}
-		config->ctrl |= ETMCR_STALL_MODE;
+		sysfs_config->ctrl |= ETMCR_STALL_MODE;
 	} else
-		config->ctrl &= ~ETMCR_STALL_MODE;
+		sysfs_config->ctrl &= ~ETMCR_STALL_MODE;
 
-	if (config->mode & ETM_MODE_TIMESTAMP) {
+	if (sysfs_config->mode & ETM_MODE_TIMESTAMP) {
 		if (!caps->timestamp) {
 			dev_warn(dev, "timestamp not supported\n");
 			ret = -EINVAL;
 			goto err_unlock;
 		}
-		config->ctrl |= ETMCR_TIMESTAMP_EN;
+		sysfs_config->ctrl |= ETMCR_TIMESTAMP_EN;
 	} else
-		config->ctrl &= ~ETMCR_TIMESTAMP_EN;
+		sysfs_config->ctrl &= ~ETMCR_TIMESTAMP_EN;
 
-	if (config->mode & ETM_MODE_CTXID)
-		config->ctrl |= ETMCR_CTXID_SIZE;
+	if (sysfs_config->mode & ETM_MODE_CTXID)
+		sysfs_config->ctrl |= ETMCR_CTXID_SIZE;
 	else
-		config->ctrl &= ~ETMCR_CTXID_SIZE;
+		sysfs_config->ctrl &= ~ETMCR_CTXID_SIZE;
 
-	if (config->mode & ETM_MODE_BBROAD)
-		config->ctrl |= ETMCR_BRANCH_BROADCAST;
+	if (sysfs_config->mode & ETM_MODE_BBROAD)
+		sysfs_config->ctrl |= ETMCR_BRANCH_BROADCAST;
 	else
-		config->ctrl &= ~ETMCR_BRANCH_BROADCAST;
+		sysfs_config->ctrl &= ~ETMCR_BRANCH_BROADCAST;
 
-	if (config->mode & ETM_MODE_RET_STACK)
-		config->ctrl |= ETMCR_RETURN_STACK;
+	if (sysfs_config->mode & ETM_MODE_RET_STACK)
+		sysfs_config->ctrl |= ETMCR_RETURN_STACK;
 	else
-		config->ctrl &= ~ETMCR_RETURN_STACK;
+		sysfs_config->ctrl &= ~ETMCR_RETURN_STACK;
 
-	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
-		etm_config_trace_mode(config);
+	if (sysfs_config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
+		etm_config_trace_mode(sysfs_config);
 
 	spin_unlock(&drvdata->spinlock);
 
@@ -223,9 +223,9 @@ static ssize_t trigger_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->trigger_event;
+	val = sysfs_config->trigger_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -236,13 +236,13 @@ static ssize_t trigger_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	config->trigger_event = val & ETM_EVENT_MASK;
+	sysfs_config->trigger_event = val & ETM_EVENT_MASK;
 
 	return size;
 }
@@ -253,9 +253,9 @@ static ssize_t enable_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->enable_event;
+	val = sysfs_config->enable_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -266,13 +266,13 @@ static ssize_t enable_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	config->enable_event = val & ETM_EVENT_MASK;
+	sysfs_config->enable_event = val & ETM_EVENT_MASK;
 
 	return size;
 }
@@ -283,9 +283,9 @@ static ssize_t fifofull_level_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->fifofull_level;
+	val = sysfs_config->fifofull_level;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -296,13 +296,13 @@ static ssize_t fifofull_level_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	config->fifofull_level = val;
+	sysfs_config->fifofull_level = val;
 
 	return size;
 }
@@ -313,9 +313,9 @@ static ssize_t addr_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->addr_idx;
+	val = sysfs_config->addr_idx;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -327,7 +327,7 @@ static ssize_t addr_idx_store(struct device *dev,
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etm_caps *caps = &drvdata->caps;
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
@@ -341,7 +341,7 @@ static ssize_t addr_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	spin_lock(&drvdata->spinlock);
-	config->addr_idx = val;
+	sysfs_config->addr_idx = val;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -354,17 +354,17 @@ static ssize_t addr_single_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
-	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
+	idx = sysfs_config->addr_idx;
+	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
 
-	val = config->addr_val[idx];
+	val = sysfs_config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -378,22 +378,22 @@ static ssize_t addr_single_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
-	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
+	idx = sysfs_config->addr_idx;
+	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
 
-	config->addr_val[idx] = val;
-	config->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
+	sysfs_config->addr_val[idx] = val;
+	sysfs_config->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -406,24 +406,24 @@ static ssize_t addr_range_show(struct device *dev,
 	u8 idx;
 	unsigned long val1, val2;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	if (idx % 2 != 0) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
-	if (!((config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
-	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
-	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
-	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
+	if (!((sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
+	       sysfs_config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
+	      (sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
+	       sysfs_config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	val1 = config->addr_val[idx];
-	val2 = config->addr_val[idx + 1];
+	val1 = sysfs_config->addr_val[idx];
+	val2 = sysfs_config->addr_val[idx + 1];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx %#lx\n", val1, val2);
@@ -436,7 +436,7 @@ static ssize_t addr_range_store(struct device *dev,
 	u8 idx;
 	unsigned long val1, val2;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (sscanf(buf, "%lx %lx", &val1, &val2) != 2)
 		return -EINVAL;
@@ -445,24 +445,24 @@ static ssize_t addr_range_store(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	if (idx % 2 != 0) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
-	if (!((config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
-	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
-	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
-	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
+	if (!((sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
+	       sysfs_config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
+	      (sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
+	       sysfs_config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	config->addr_val[idx] = val1;
-	config->addr_type[idx] = ETM_ADDR_TYPE_RANGE;
-	config->addr_val[idx + 1] = val2;
-	config->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
-	config->enable_ctrl1 |= (1 << (idx/2));
+	sysfs_config->addr_val[idx] = val1;
+	sysfs_config->addr_type[idx] = ETM_ADDR_TYPE_RANGE;
+	sysfs_config->addr_val[idx + 1] = val2;
+	sysfs_config->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
+	sysfs_config->enable_ctrl1 |= (1 << (idx/2));
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -475,17 +475,17 @@ static ssize_t addr_start_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
-	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
+	idx = sysfs_config->addr_idx;
+	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	val = config->addr_val[idx];
+	val = sysfs_config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -499,24 +499,24 @@ static ssize_t addr_start_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
-	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
+	idx = sysfs_config->addr_idx;
+	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	config->addr_val[idx] = val;
-	config->addr_type[idx] = ETM_ADDR_TYPE_START;
-	config->startstop_ctrl |= (1 << idx);
-	config->enable_ctrl1 |= ETMTECR1_START_STOP;
+	sysfs_config->addr_val[idx] = val;
+	sysfs_config->addr_type[idx] = ETM_ADDR_TYPE_START;
+	sysfs_config->startstop_ctrl |= (1 << idx);
+	sysfs_config->enable_ctrl1 |= ETMTECR1_START_STOP;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -529,17 +529,17 @@ static ssize_t addr_stop_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
-	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
+	idx = sysfs_config->addr_idx;
+	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	val = config->addr_val[idx];
+	val = sysfs_config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -553,24 +553,24 @@ static ssize_t addr_stop_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
-	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
+	idx = sysfs_config->addr_idx;
+	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
 		spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	config->addr_val[idx] = val;
-	config->addr_type[idx] = ETM_ADDR_TYPE_STOP;
-	config->startstop_ctrl |= (1 << (idx + 16));
-	config->enable_ctrl1 |= ETMTECR1_START_STOP;
+	sysfs_config->addr_val[idx] = val;
+	sysfs_config->addr_type[idx] = ETM_ADDR_TYPE_STOP;
+	sysfs_config->startstop_ctrl |= (1 << (idx + 16));
+	sysfs_config->enable_ctrl1 |= ETMTECR1_START_STOP;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -582,10 +582,10 @@ static ssize_t addr_acctype_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	spin_lock(&drvdata->spinlock);
-	val = config->addr_acctype[config->addr_idx];
+	val = sysfs_config->addr_acctype[sysfs_config->addr_idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -598,14 +598,14 @@ static ssize_t addr_acctype_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	config->addr_acctype[config->addr_idx] = val;
+	sysfs_config->addr_acctype[sysfs_config->addr_idx] = val;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -617,9 +617,9 @@ static ssize_t cntr_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->cntr_idx;
+	val = sysfs_config->cntr_idx;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -631,7 +631,7 @@ static ssize_t cntr_idx_store(struct device *dev,
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etm_caps *caps = &drvdata->caps;
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
@@ -644,7 +644,7 @@ static ssize_t cntr_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	spin_lock(&drvdata->spinlock);
-	config->cntr_idx = val;
+	sysfs_config->cntr_idx = val;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -656,10 +656,10 @@ static ssize_t cntr_rld_val_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	spin_lock(&drvdata->spinlock);
-	val = config->cntr_rld_val[config->cntr_idx];
+	val = sysfs_config->cntr_rld_val[sysfs_config->cntr_idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -672,14 +672,14 @@ static ssize_t cntr_rld_val_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	config->cntr_rld_val[config->cntr_idx] = val;
+	sysfs_config->cntr_rld_val[sysfs_config->cntr_idx] = val;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -691,10 +691,10 @@ static ssize_t cntr_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	spin_lock(&drvdata->spinlock);
-	val = config->cntr_event[config->cntr_idx];
+	val = sysfs_config->cntr_event[sysfs_config->cntr_idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -707,14 +707,14 @@ static ssize_t cntr_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	config->cntr_event[config->cntr_idx] = val & ETM_EVENT_MASK;
+	sysfs_config->cntr_event[sysfs_config->cntr_idx] = val & ETM_EVENT_MASK;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -726,10 +726,10 @@ static ssize_t cntr_rld_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	spin_lock(&drvdata->spinlock);
-	val = config->cntr_rld_event[config->cntr_idx];
+	val = sysfs_config->cntr_rld_event[sysfs_config->cntr_idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -742,14 +742,14 @@ static ssize_t cntr_rld_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	config->cntr_rld_event[config->cntr_idx] = val & ETM_EVENT_MASK;
+	sysfs_config->cntr_rld_event[sysfs_config->cntr_idx] = val & ETM_EVENT_MASK;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -763,14 +763,14 @@ static ssize_t cntr_val_show(struct device *dev,
 	u32 val;
 	unsigned long val2;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (!coresight_get_mode(drvdata->csdev)) {
 		spin_lock(&drvdata->spinlock);
-		val = config->cntr_val[config->cntr_idx];
+		val = sysfs_config->cntr_val[sysfs_config->cntr_idx];
 		spin_unlock(&drvdata->spinlock);
 	} else {
-		ret = etm_readl_cslocked(drvdata, ETMCNTVRn(config->cntr_idx), &val2);
+		ret = etm_readl_cslocked(drvdata, ETMCNTVRn(sysfs_config->cntr_idx), &val2);
 		if (ret)
 			return ret;
 		val = val2;
@@ -786,7 +786,7 @@ static ssize_t cntr_val_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
@@ -796,7 +796,7 @@ static ssize_t cntr_val_store(struct device *dev,
 		return -EBUSY;
 
 	spin_lock(&drvdata->spinlock);
-	config->cntr_val[config->cntr_idx] = val;
+	sysfs_config->cntr_val[sysfs_config->cntr_idx] = val;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -808,9 +808,9 @@ static ssize_t seq_12_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->seq_12_event;
+	val = sysfs_config->seq_12_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -821,13 +821,13 @@ static ssize_t seq_12_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	config->seq_12_event = val & ETM_EVENT_MASK;
+	sysfs_config->seq_12_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_12_event);
@@ -837,9 +837,9 @@ static ssize_t seq_21_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->seq_21_event;
+	val = sysfs_config->seq_21_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -850,13 +850,13 @@ static ssize_t seq_21_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	config->seq_21_event = val & ETM_EVENT_MASK;
+	sysfs_config->seq_21_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_21_event);
@@ -866,9 +866,9 @@ static ssize_t seq_23_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->seq_23_event;
+	val = sysfs_config->seq_23_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -879,13 +879,13 @@ static ssize_t seq_23_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	config->seq_23_event = val & ETM_EVENT_MASK;
+	sysfs_config->seq_23_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_23_event);
@@ -895,9 +895,9 @@ static ssize_t seq_31_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->seq_31_event;
+	val = sysfs_config->seq_31_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -908,13 +908,13 @@ static ssize_t seq_31_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	config->seq_31_event = val & ETM_EVENT_MASK;
+	sysfs_config->seq_31_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_31_event);
@@ -924,9 +924,9 @@ static ssize_t seq_32_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->seq_32_event;
+	val = sysfs_config->seq_32_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -937,13 +937,13 @@ static ssize_t seq_32_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	config->seq_32_event = val & ETM_EVENT_MASK;
+	sysfs_config->seq_32_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_32_event);
@@ -953,9 +953,9 @@ static ssize_t seq_13_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->seq_13_event;
+	val = sysfs_config->seq_13_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -966,13 +966,13 @@ static ssize_t seq_13_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	config->seq_13_event = val & ETM_EVENT_MASK;
+	sysfs_config->seq_13_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_13_event);
@@ -983,10 +983,10 @@ static ssize_t seq_curr_state_show(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (!coresight_get_mode(drvdata->csdev)) {
-		val = config->seq_curr_state;
+		val = sysfs_config->seq_curr_state;
 		goto out;
 	}
 
@@ -1005,7 +1005,7 @@ static ssize_t seq_curr_state_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
@@ -1014,7 +1014,7 @@ static ssize_t seq_curr_state_store(struct device *dev,
 	if (val > ETM_SEQ_STATE_MAX_VAL)
 		return -EINVAL;
 
-	config->seq_curr_state = val;
+	sysfs_config->seq_curr_state = val;
 
 	return size;
 }
@@ -1025,9 +1025,9 @@ static ssize_t ctxid_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->ctxid_idx;
+	val = sysfs_config->ctxid_idx;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -1039,7 +1039,7 @@ static ssize_t ctxid_idx_store(struct device *dev,
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etm_caps *caps = &drvdata->caps;
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
@@ -1053,7 +1053,7 @@ static ssize_t ctxid_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	spin_lock(&drvdata->spinlock);
-	config->ctxid_idx = val;
+	sysfs_config->ctxid_idx = val;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -1065,7 +1065,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	/*
 	 * Don't use contextID tracing if coming from a PID namespace.  See
@@ -1075,7 +1075,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 		return -EINVAL;
 
 	spin_lock(&drvdata->spinlock);
-	val = config->ctxid_pid[config->ctxid_idx];
+	val = sysfs_config->ctxid_pid[sysfs_config->ctxid_idx];
 	spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -1088,7 +1088,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	int ret;
 	unsigned long pid;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	/*
 	 * When contextID tracing is enabled the tracers will insert the
@@ -1107,7 +1107,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
 		return ret;
 
 	spin_lock(&drvdata->spinlock);
-	config->ctxid_pid[config->ctxid_idx] = pid;
+	sysfs_config->ctxid_pid[sysfs_config->ctxid_idx] = pid;
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
@@ -1119,7 +1119,7 @@ static ssize_t ctxid_mask_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	/*
 	 * Don't use contextID tracing if coming from a PID namespace.  See
@@ -1128,7 +1128,7 @@ static ssize_t ctxid_mask_show(struct device *dev,
 	if (task_active_pid_ns(current) != &init_pid_ns)
 		return -EINVAL;
 
-	val = config->ctxid_mask;
+	val = sysfs_config->ctxid_mask;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -1139,7 +1139,7 @@ static ssize_t ctxid_mask_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	/*
 	 * Don't use contextID tracing if coming from a PID namespace.  See
@@ -1152,7 +1152,7 @@ static ssize_t ctxid_mask_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	config->ctxid_mask = val;
+	sysfs_config->ctxid_mask = val;
 	return size;
 }
 static DEVICE_ATTR_RW(ctxid_mask);
@@ -1162,9 +1162,9 @@ static ssize_t sync_freq_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->sync_freq;
+	val = sysfs_config->sync_freq;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -1175,13 +1175,13 @@ static ssize_t sync_freq_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	config->sync_freq = val & ETM_SYNC_MASK;
+	sysfs_config->sync_freq = val & ETM_SYNC_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(sync_freq);
@@ -1191,9 +1191,9 @@ static ssize_t timestamp_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->timestamp_event;
+	val = sysfs_config->timestamp_event;
 	return sprintf(buf, "%#lx\n", val);
 }
 
@@ -1204,13 +1204,13 @@ static ssize_t timestamp_event_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *sysfs_config = &drvdata->sysfs_config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	config->timestamp_event = val & ETM_EVENT_MASK;
+	sysfs_config->timestamp_event = val & ETM_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(timestamp_event);

-- 
2.43.0

