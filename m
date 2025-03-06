Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E8F20B80A
	for <linux-rt-devel@lists.linux.dev>; Thu,  6 Mar 2025 09:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741254503; cv=none; b=eClm3HtVhRtbOQG5w3rMLArHl2sMOkYfThLeC8BOSfvdqT7aBWk5W2bL4f2EZKNqeSB1TTgGERUlWy3R1EIxw3+DpFYkDYJKNqIH692Pb1NLRQtS+j5YHrM88mLTR7HWnHuzirFTMnRbojOFvHIZ/MB7bSUYu7SJizU8WDealCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741254503; c=relaxed/simple;
	bh=//gvwVma+oPF1bOphMNrpTrFJBnmM+5Cg5OM2SAc2x4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUnOu/hS1t2ztRnxahGkgerq2251aY3IQey6UGmD3hZFgrjC6QnSdY6OSFmh6SbajxU+yN2+oNoD8nGySBpgkYJEHR68LNvV235bWbnLpvnqaLnkVVSzWbti17HxD1T4Z8d21dzmZTT3WqFQuf/EqyEk75pghgENrjLk90E8i9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC3C4FEC;
	Thu,  6 Mar 2025 01:48:33 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0408D3F673;
	Thu,  6 Mar 2025 01:48:18 -0800 (PST)
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
Subject: [PATCH v5 8/9] coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
Date: Thu,  6 Mar 2025 09:47:59 +0000
Message-Id: <20250306094800.1082950-9-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250306094800.1082950-1-yeoreum.yun@arm.com>
References: <20250306094800.1082950-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In coresight-tmc drivers, tmc_drvdata->spinlock can be held
during __schedule() by perf_event_task_sched_out()/in().

Since tmc_drvdata->spinlock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this, change type tmc_drvdata->spinlock in coresight-tmc drivers,
which can be called by perf_event_task_sched_out()/in(),
from spinlock_t to raw_spinlock_t.

Reviewed-by: James Clark <james.clark@linaro.org>
Reviewed-by: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 .../hwtracing/coresight/coresight-tmc-core.c  |  6 +--
 .../hwtracing/coresight/coresight-tmc-etf.c   | 48 +++++++++----------
 .../hwtracing/coresight/coresight-tmc-etr.c   | 40 ++++++++--------
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
 4 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index d5122e12daa7..829d104fdaca 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -801,7 +801,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 	drvdata->base = base;
 	desc.access = CSDEV_ACCESS_IOMEM(base);
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 
 	devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
 	drvdata->config_type = BMVAL(devid, 6, 7);
@@ -913,7 +913,7 @@ static void tmc_shutdown(struct amba_device *adev)
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = amba_get_drvdata(adev);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	if (coresight_get_mode(drvdata->csdev) == CS_MODE_DISABLED)
 		goto out;
@@ -927,7 +927,7 @@ static void tmc_shutdown(struct amba_device *adev)
 	 * the system is going down after this.
 	 */
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 }
 
 static void __tmc_remove(struct device *dev)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index bdc3a7e9ba06..d858740001c2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -185,9 +185,9 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 	 * If we don't have a buffer release the lock and allocate memory.
 	 * Otherwise keep the lock and move along.
 	 */
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (!drvdata->buf) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 		/* Allocating the memory here while outside of the spinlock */
 		buf = kzalloc(drvdata->size, GFP_KERNEL);
@@ -195,7 +195,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 			return -ENOMEM;
 
 		/* Let's try again */
-		spin_lock_irqsave(&drvdata->spinlock, flags);
+		raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	}
 
 	if (drvdata->reading) {
@@ -237,7 +237,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 		used = false;
 	}
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free memory outside the spinlock if need be */
 	if (!used)
@@ -255,7 +255,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 	struct perf_output_handle *handle = data;
 	struct cs_buffers *buf = etm_perf_sink_config(handle);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	do {
 		ret = -EINVAL;
 		if (drvdata->reading)
@@ -298,7 +298,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 			csdev->refcnt++;
 		}
 	} while (0);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return ret;
 }
@@ -333,16 +333,16 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	if (drvdata->reading) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
 
 	csdev->refcnt--;
 	if (csdev->refcnt) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
 
@@ -353,7 +353,7 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 	drvdata->pid = -1;
 	coresight_set_mode(csdev, CS_MODE_DISABLED);
 
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(&csdev->dev, "TMC-ETB/ETF disabled\n");
 	return 0;
@@ -368,9 +368,9 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	bool first_enable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
 
@@ -383,7 +383,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	}
 	if (!ret)
 		csdev->refcnt++;
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
 		dev_dbg(&csdev->dev, "TMC-ETF enabled\n");
@@ -398,9 +398,9 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	bool last_disable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return;
 	}
 
@@ -410,7 +410,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 		coresight_set_mode(csdev, CS_MODE_DISABLED);
 		last_disable = true;
 	}
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (last_disable)
 		dev_dbg(&csdev->dev, "TMC-ETF disabled\n");
@@ -490,7 +490,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	if (WARN_ON_ONCE(coresight_get_mode(csdev) != CS_MODE_PERF))
 		return 0;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't do anything if another tracer is using this sink */
 	if (csdev->refcnt != 1)
@@ -587,7 +587,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	 */
 	CS_LOCK(drvdata->base);
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return to_read;
 }
@@ -705,7 +705,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
 		return -EINVAL;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	if (drvdata->reading) {
 		ret = -EBUSY;
@@ -737,7 +737,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 
 	drvdata->reading = true;
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return ret;
 }
@@ -754,14 +754,14 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
 		return -EINVAL;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Re-enable the TMC if need be */
 	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
 		/* There is no point in reading a TMC in HW FIFO mode */
 		mode = readl_relaxed(drvdata->base + TMC_MODE);
 		if (mode != TMC_MODE_CIRCULAR_BUFFER) {
-			spin_unlock_irqrestore(&drvdata->spinlock, flags);
+			raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 			return -EINVAL;
 		}
 		/*
@@ -775,7 +775,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 		memset(drvdata->buf, 0, drvdata->size);
 		rc = __tmc_etb_enable_hw(drvdata);
 		if (rc) {
-			spin_unlock_irqrestore(&drvdata->spinlock, flags);
+			raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 			return rc;
 		}
 	} else {
@@ -788,7 +788,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	drvdata->reading = false;
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/*
 	 * Free allocated memory outside of the spinlock.  There is no need
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index eda7cdad0e2b..e501bd5ac6e9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1251,10 +1251,10 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 	 * buffer, provided the size matches. Any allocation has to be done
 	 * with the lock released.
 	 */
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	sysfs_buf = READ_ONCE(drvdata->sysfs_buf);
 	if (!sysfs_buf || (sysfs_buf->size != drvdata->size)) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 		/* Allocate memory with the locks released */
 		free_buf = new_buf = tmc_etr_setup_sysfs_buf(drvdata);
@@ -1262,7 +1262,7 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 			return new_buf;
 
 		/* Let's try again */
-		spin_lock_irqsave(&drvdata->spinlock, flags);
+		raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	}
 
 	if (drvdata->reading || coresight_get_mode(csdev) == CS_MODE_PERF) {
@@ -1281,7 +1281,7 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 	}
 
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free memory outside the spinlock if need be */
 	if (free_buf)
@@ -1299,7 +1299,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	if (IS_ERR(sysfs_buf))
 		return PTR_ERR(sysfs_buf);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/*
 	 * In sysFS mode we can have multiple writers per sink.  Since this
@@ -1318,7 +1318,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	}
 
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (!ret)
 		dev_dbg(&csdev->dev, "TMC-ETR enabled\n");
@@ -1637,17 +1637,17 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	struct etr_perf_buffer *etr_perf = config;
 	struct etr_buf *etr_buf = etr_perf->etr_buf;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't do anything if another tracer is using this sink */
 	if (csdev->refcnt != 1) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		goto out;
 	}
 
 	if (WARN_ON(drvdata->perf_buf != etr_buf)) {
 		lost = true;
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		goto out;
 	}
 
@@ -1657,7 +1657,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	tmc_sync_etr_buf(drvdata);
 
 	CS_LOCK(drvdata->base);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	lost = etr_buf->full;
 	offset = etr_buf->offset;
@@ -1726,7 +1726,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	struct perf_output_handle *handle = data;
 	struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	 /* Don't use this sink if it is already claimed by sysFS */
 	if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
 		rc = -EBUSY;
@@ -1766,7 +1766,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	}
 
 unlock_out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return rc;
 }
 
@@ -1788,16 +1788,16 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	if (drvdata->reading) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
 
 	csdev->refcnt--;
 	if (csdev->refcnt) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
 
@@ -1810,7 +1810,7 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	/* Reset perf specific data */
 	drvdata->perf_buf = NULL;
 
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(&csdev->dev, "TMC-ETR disabled\n");
 	return 0;
@@ -1910,7 +1910,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
 		return -EINVAL;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		ret = -EBUSY;
 		goto out;
@@ -1932,7 +1932,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 
 	drvdata->reading = true;
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return ret;
 }
@@ -1946,7 +1946,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
 		return -EINVAL;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* RE-enable the TMC if need be */
 	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
@@ -1966,7 +1966,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	}
 
 	drvdata->reading = false;
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free allocated memory out side of the spinlock */
 	if (sysfs_buf)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index b48bc9a01cc0..6541a27a018e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -249,7 +249,7 @@ struct tmc_drvdata {
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
 	struct miscdevice	crashdev;
-	spinlock_t		spinlock;
+	raw_spinlock_t		spinlock;
 	pid_t			pid;
 	bool			reading;
 	bool			stop_on_flush;
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

