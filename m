Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3598443C10
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 10:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124185; cv=none; b=kaQxVC4+7IF8v3PIEtNxDreCBeaBZkuoTTJ2+6lJTSjVijhLAX/kNd6Tu0sHXfGF2hHpMbD7YaPaim/k6tJlaKDSy9KvorGcftphi3lpzLzhOfenPMnKNcFwUkx50NcFgwPrB52nC68yIxfalv3F5OEGhWiFE0CNMFkGYIMA2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124185; c=relaxed/simple;
	bh=qi9ScefD9ScqFoy1bpsS3ysLDeXlh6lEvWOaOYWn3RM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S0KsGJt3RX5P/Ig/EQ9hU0RngYpRemBYmigCk6B/XoxmBqyts+D5tAMggCEgZm9/8QtTdjEtBvX6ZxYPjWS/1//alZzMiEAM6WFY2YI/N/ac/38fqyjBlm9e285dKHO5dqG6NZVjOh5U7VdYXcLkwAkvqPjw5FCSbHtWx2gn2Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tQgg6qUB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tQgg6qUB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 66EC71570;
	Fri, 11 Sep 2026 03:56:18 -0700 (PDT)
Received: from e129823.arm.com (unknown [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DCAD93F7B4;
	Fri, 11 Sep 2026 03:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789124182; bh=qi9ScefD9ScqFoy1bpsS3ysLDeXlh6lEvWOaOYWn3RM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tQgg6qUBvOAh8wuwiDROZgEuU5gpEIN4TfIUgny7ZGgOMWpg/1YITO67OIfCEG574
	 qJQxE/izcxe4uhR31AcsFdIUcOBSewRyyLHO11saMdl78512uMjUXj0Us4PR9C/W1j
	 xhSTxFqFTUurrUOhujix8/Y7VSl/ElfJiiUrKh7g=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 11 Sep 2026 11:56:02 +0100
Subject: [PATCH v10 3/8] coresight: etm3x: change drvdata->spinlock type to
 raw_spin_lock_t
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-separate_etm_cfg_v2-v10-3-1b715d95927a@arm.com>
References: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
In-Reply-To: <20260911-separate_etm_cfg_v2-v10-0-1b715d95927a@arm.com>
To: Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Leo Yan <leo.yan@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Jie Gan <jie.gan@oss.qualcomm.com>, Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16140; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=qi9ScefD9ScqFoy1bpsS3ysLDeXlh6lEvWOaOYWn3RM=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqo95Jq/VOCgPgHIsJdXhTTAYFqp+RfGysJRFzL
 srlCBHSg1CJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqPeSQAKCRBt1cPRWsUx
 M+5XDACJe2rLWAgeyiO8oFDcnAqFCwFVBfIH9VIeM0rnUd1phMjpen7n/J+ouUj6c2iQxQzVUle
 yUotC8YorrYIXVspYpy46t50hQGlXRJcqANPKJZOnhO0Jg4CYMDO3Td9LWqBRrGXO6pnrK/zYYq
 VfjY6uqrrTkHLVD1nvD5aiQhuufLoCIowueUqL3RKlnHagLVampn34iDWc0tNigoeJbH/vK0Qzh
 3tLBylKUEekhro+HA5fZZRawcP2bwjzMPPJo9T138Mhu4ASpnJaz71LRJgqtlUv6zejo+mklSsU
 InX0iMJNKtJs1/v2mMHtYqtvqKkoVP49AeKXdl4HcNBBLUy7cC90YlqwRElW1DWlVYFKTZ0jGdj
 YI3N1drsWZm6f+Ov2q9K9NelVcLuKCPLowqRvQK2VnijK6jE7JvBP6cLa0tbINREPv3lqvxEW2T
 RJvLWokBcv2Y61vDenBvao2UTXJunJKg1iqBsQTcac/tHUqtVFbUUc8De2EsCJ6t/Jwug=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

etm_starting_cpu()/etm_dying_cpu() are called in not sleepable context.
This poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this, change etm3's drvdata->spinlock type to raw_spin_lock_t.
This will be good to align with etm4x.

Reviewed-by: Jie Gan <jie.gan@oss.qualcomm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm.h        |   2 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c |   2 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 130 ++++++++++-----------
 3 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index f3796162168d..bc8909a905c7 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -233,7 +233,7 @@ struct etm_drvdata {
 	struct csdev_access		csa;
 	struct clk			*atclk;
 	struct coresight_device		*csdev;
-	spinlock_t			spinlock;
+	raw_spinlock_t			spinlock;
 	int				cpu;
 	int				port_size;
 	u8				arch;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 93dc98145b66..7a1e183c0b48 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -811,7 +811,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 
 	desc.access = drvdata->csa = CSDEV_ACCESS_IOMEM(base);
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 
 	drvdata->atclk = devm_clk_get_optional_enabled(dev, "atclk");
 	if (IS_ERR(drvdata->atclk))
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index b3c67e96a82a..0701edc09458 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -49,13 +49,13 @@ static ssize_t etmsr_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	pm_runtime_get_sync(dev->parent);
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	CS_UNLOCK(drvdata->csa.base);
 
 	val = etm_readl(drvdata, ETMSR);
 
 	CS_LOCK(drvdata->csa.base);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	pm_runtime_put(dev->parent);
 
 	return sprintf(buf, "%#lx\n", val);
@@ -76,7 +76,7 @@ static ssize_t reset_store(struct device *dev,
 		return ret;
 
 	if (val) {
-		spin_lock(&drvdata->spinlock);
+		raw_spin_lock(&drvdata->spinlock);
 		memset(config, 0, sizeof(struct etm_config));
 		config->mode = ETM_MODE_EXCLUDE;
 		config->trigger_event = ETM_DEFAULT_EVENT_VAL;
@@ -86,7 +86,7 @@ static ssize_t reset_store(struct device *dev,
 
 		etm_set_default(config);
 		etm_release_trace_id(drvdata);
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 	}
 
 	return size;
@@ -117,7 +117,7 @@ static ssize_t mode_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->mode = val & ETM_MODE_ALL;
 
 	if (config->mode & ETM_MODE_EXCLUDE)
@@ -168,12 +168,12 @@ static ssize_t mode_store(struct device *dev,
 	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
 		etm_config_trace_mode(config);
 
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 
 err_unlock:
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 	return ret;
 }
 static DEVICE_ATTR_RW(mode);
@@ -299,9 +299,9 @@ static ssize_t addr_idx_store(struct device *dev,
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
@@ -315,16 +315,16 @@ static ssize_t addr_single_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
 
 	val = config->addr_val[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -343,17 +343,17 @@ static ssize_t addr_single_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
 
 	config->addr_val[idx] = val;
 	config->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -367,23 +367,23 @@ static ssize_t addr_range_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
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
 
 	val1 = config->addr_val[idx];
 	val2 = config->addr_val[idx + 1];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx %#lx\n", val1, val2);
 }
@@ -403,17 +403,17 @@ static ssize_t addr_range_store(struct device *dev,
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
 	if (!((config->addr_type[idx] == ETM_ADDR_TYPE_NONE &&
 	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_NONE) ||
 	      (config->addr_type[idx] == ETM_ADDR_TYPE_RANGE &&
 	       config->addr_type[idx + 1] == ETM_ADDR_TYPE_RANGE))) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
@@ -422,7 +422,7 @@ static ssize_t addr_range_store(struct device *dev,
 	config->addr_val[idx + 1] = val2;
 	config->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
 	config->enable_ctrl1 |= (1 << (idx/2));
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -436,16 +436,16 @@ static ssize_t addr_start_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
 	val = config->addr_val[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -464,11 +464,11 @@ static ssize_t addr_start_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
@@ -476,7 +476,7 @@ static ssize_t addr_start_store(struct device *dev,
 	config->addr_type[idx] = ETM_ADDR_TYPE_START;
 	config->startstop_ctrl |= (1 << idx);
 	config->enable_ctrl1 |= ETMTECR1_START_STOP;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -490,16 +490,16 @@ static ssize_t addr_stop_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
 	val = config->addr_val[idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -518,11 +518,11 @@ static ssize_t addr_stop_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
 	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
@@ -530,7 +530,7 @@ static ssize_t addr_stop_store(struct device *dev,
 	config->addr_type[idx] = ETM_ADDR_TYPE_STOP;
 	config->startstop_ctrl |= (1 << (idx + 16));
 	config->enable_ctrl1 |= ETMTECR1_START_STOP;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -543,9 +543,9 @@ static ssize_t addr_acctype_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->addr_acctype[config->addr_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -563,9 +563,9 @@ static ssize_t addr_acctype_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->addr_acctype[config->addr_idx] = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -601,9 +601,9 @@ static ssize_t cntr_idx_store(struct device *dev,
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
@@ -616,9 +616,9 @@ static ssize_t cntr_rld_val_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->cntr_rld_val[config->cntr_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -636,9 +636,9 @@ static ssize_t cntr_rld_val_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->cntr_rld_val[config->cntr_idx] = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -651,9 +651,9 @@ static ssize_t cntr_event_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->cntr_event[config->cntr_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -671,9 +671,9 @@ static ssize_t cntr_event_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->cntr_event[config->cntr_idx] = val & ETM_EVENT_MASK;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -686,9 +686,9 @@ static ssize_t cntr_rld_event_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->cntr_rld_event[config->cntr_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -706,9 +706,9 @@ static ssize_t cntr_rld_event_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->cntr_rld_event[config->cntr_idx] = val & ETM_EVENT_MASK;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -722,9 +722,9 @@ static ssize_t cntr_val_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	if (!coresight_get_mode(drvdata->csdev)) {
-		spin_lock(&drvdata->spinlock);
+		raw_spin_lock(&drvdata->spinlock);
 		val = config->cntr_val[config->cntr_idx];
-		spin_unlock(&drvdata->spinlock);
+		raw_spin_unlock(&drvdata->spinlock);
 	} else {
 		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
 	}
@@ -745,9 +745,9 @@ static ssize_t cntr_val_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->cntr_val[config->cntr_idx] = val;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }
@@ -940,13 +940,13 @@ static ssize_t seq_curr_state_show(struct device *dev,
 	}
 
 	pm_runtime_get_sync(dev->parent);
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	CS_UNLOCK(drvdata->csa.base);
 	val = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
 	CS_LOCK(drvdata->csa.base);
 
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	pm_runtime_put(dev->parent);
 out:
 	return sprintf(buf, "%#lx\n", val);
@@ -1005,9 +1005,9 @@ static ssize_t ctxid_idx_store(struct device *dev,
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
@@ -1027,9 +1027,9 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	if (task_active_pid_ns(current) != &init_pid_ns)
 		return -EINVAL;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	val = config->ctxid_pid[config->ctxid_idx];
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -1059,9 +1059,9 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	spin_lock(&drvdata->spinlock);
+	raw_spin_lock(&drvdata->spinlock);
 	config->ctxid_pid[config->ctxid_idx] = pid;
-	spin_unlock(&drvdata->spinlock);
+	raw_spin_unlock(&drvdata->spinlock);
 
 	return size;
 }

-- 
2.43.0

