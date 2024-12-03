Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86101E47D6
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Dec 2024 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733226608; cv=none; b=fCzC8pc+ty9Yt7xcjeMxoNyE/cs15+YpFoDnN/mxnRAppr+q/65H+3KFMsiV9VRV5IxYOEJkjm4svqQ2Zjmzo4H2mbxS5W+Mvey4oFY6rB0Rv5wEULr3eKPtnvF5EyPkFiTQRqhP8UB4iYJYvThf6yB4/DZ9Jn/TNHFmHISC/Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733226608; c=relaxed/simple;
	bh=IsO+1yLGTY881Y/b2LoIim+/Z+q6QMa4VM1mZ4kn0f8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cd5KpcvI0eD54K9RYcHr5fIMd4HQSNmrglbCsbllqYqsyEgIpJNxoLxZ9L3PJihZ1XGhvtVZIfGo9sZ9+l9w2tA8/5IpReK8aNCzFnTpBAmoiLgbLjmLF8r1zZkzK3/YwNaqeDV7avCu3K3wfkZjhaEcMBkmyoHxXjcvmpXerDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B54B143D;
	Tue,  3 Dec 2024 03:50:34 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E7ED3F58B;
	Tue,  3 Dec 2024 03:50:04 -0800 (PST)
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
Subject: [PATCH v2 8/9] coresight-tmc: change tmc_drvdata spinlock's type to raw_spinlock_t
Date: Tue,  3 Dec 2024 11:49:41 +0000
Message-Id: <20241203114942.697188-9-yeoreum.yun@arm.com>
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

In coresight-tmc drivers, tmc_drvdata->spinlock can be held
during __schedule() by perf_event_task_sched_out()/in().

Since tmc_drvdata->spinlock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this, change type tmc_drvdata->spinlock in coresight-tmc drivers,
which can be called by perf_event_task_sched_out()/in(),
from spinlock_t to raw_spinlock_t.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 .../hwtracing/coresight/coresight-tmc-core.c  |  6 +--
 .../hwtracing/coresight/coresight-tmc-etf.c   | 48 +++++++++----------
 .../hwtracing/coresight/coresight-tmc-etr.c   | 40 ++++++++--------
 drivers/hwtracing/coresight/coresight-tmc.h   |  2 +-
 4 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index e9876252a789..4e9925300931 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -492,7 +492,7 @@ static int __tmc_probe(struct device *dev, struct resource *res)
 	drvdata->base = base;
 	desc.access = CSDEV_ACCESS_IOMEM(base);
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 
 	devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
 	drvdata->config_type = BMVAL(devid, 6, 7);
@@ -596,7 +596,7 @@ static void tmc_shutdown(struct amba_device *adev)
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = amba_get_drvdata(adev);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	if (coresight_get_mode(drvdata->csdev) == CS_MODE_DISABLED)
 		goto out;
@@ -610,7 +610,7 @@ static void tmc_shutdown(struct amba_device *adev)
 	 * the system is going down after this.
 	 */
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 }
 
 static void __tmc_remove(struct device *dev)
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d4f641cd9de6..fca8e9ffb3cf 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -182,9 +182,9 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
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
@@ -192,7 +192,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 			return -ENOMEM;
 
 		/* Let's try again */
-		spin_lock_irqsave(&drvdata->spinlock, flags);
+		raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	}
 
 	if (drvdata->reading) {
@@ -235,7 +235,7 @@ static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 		used = false;
 	}
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free memory outside the spinlock if need be */
 	if (!used)
@@ -253,7 +253,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 	struct perf_output_handle *handle = data;
 	struct cs_buffers *buf = etm_perf_sink_config(handle);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	do {
 		ret = -EINVAL;
 		if (drvdata->reading)
@@ -296,7 +296,7 @@ static int tmc_enable_etf_sink_perf(struct coresight_device *csdev, void *data)
 			csdev->refcnt++;
 		}
 	} while (0);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return ret;
 }
@@ -331,16 +331,16 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
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
 
@@ -351,7 +351,7 @@ static int tmc_disable_etf_sink(struct coresight_device *csdev)
 	drvdata->pid = -1;
 	coresight_set_mode(csdev, CS_MODE_DISABLED);
 
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(&csdev->dev, "TMC-ETB/ETF disabled\n");
 	return 0;
@@ -366,9 +366,9 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	bool first_enable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
 
@@ -381,7 +381,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	}
 	if (!ret)
 		csdev->refcnt++;
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (first_enable)
 		dev_dbg(&csdev->dev, "TMC-ETF enabled\n");
@@ -396,9 +396,9 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	bool last_disable = false;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return;
 	}
 
@@ -408,7 +408,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 		coresight_set_mode(csdev, CS_MODE_DISABLED);
 		last_disable = true;
 	}
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (last_disable)
 		dev_dbg(&csdev->dev, "TMC-ETF disabled\n");
@@ -488,7 +488,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	if (WARN_ON_ONCE(coresight_get_mode(csdev) != CS_MODE_PERF))
 		return 0;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't do anything if another tracer is using this sink */
 	if (csdev->refcnt != 1)
@@ -585,7 +585,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 	 */
 	CS_LOCK(drvdata->base);
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return to_read;
 }
@@ -623,7 +623,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 			 drvdata->config_type != TMC_CONFIG_TYPE_ETF))
 		return -EINVAL;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	if (drvdata->reading) {
 		ret = -EBUSY;
@@ -655,7 +655,7 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 
 	drvdata->reading = true;
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return ret;
 }
@@ -672,14 +672,14 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
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
@@ -693,7 +693,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 		memset(drvdata->buf, 0, drvdata->size);
 		rc = __tmc_etb_enable_hw(drvdata);
 		if (rc) {
-			spin_unlock_irqrestore(&drvdata->spinlock, flags);
+			raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 			return rc;
 		}
 	} else {
@@ -706,7 +706,7 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
 	}
 
 	drvdata->reading = false;
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/*
 	 * Free allocated memory outside of the spinlock.  There is no need
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index a48bb85d0e7f..a0a90ce7333e 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1176,10 +1176,10 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
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
@@ -1187,7 +1187,7 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 			return new_buf;
 
 		/* Let's try again */
-		spin_lock_irqsave(&drvdata->spinlock, flags);
+		raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	}
 
 	if (drvdata->reading || coresight_get_mode(csdev) == CS_MODE_PERF) {
@@ -1206,7 +1206,7 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 	}
 
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free memory outside the spinlock if need be */
 	if (free_buf)
@@ -1224,7 +1224,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	if (IS_ERR(sysfs_buf))
 		return PTR_ERR(sysfs_buf);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/*
 	 * In sysFS mode we can have multiple writers per sink.  Since this
@@ -1243,7 +1243,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 	}
 
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (!ret)
 		dev_dbg(&csdev->dev, "TMC-ETR enabled\n");
@@ -1562,17 +1562,17 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
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
 
@@ -1582,7 +1582,7 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
 	tmc_sync_etr_buf(drvdata);
 
 	CS_LOCK(drvdata->base);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	lost = etr_buf->full;
 	offset = etr_buf->offset;
@@ -1651,7 +1651,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	struct perf_output_handle *handle = data;
 	struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	 /* Don't use this sink if it is already claimed by sysFS */
 	if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
 		rc = -EBUSY;
@@ -1691,7 +1691,7 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 	}
 
 unlock_out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return rc;
 }
 
@@ -1713,16 +1713,16 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
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
 
@@ -1735,7 +1735,7 @@ static int tmc_disable_etr_sink(struct coresight_device *csdev)
 	/* Reset perf specific data */
 	drvdata->perf_buf = NULL;
 
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(&csdev->dev, "TMC-ETR disabled\n");
 	return 0;
@@ -1762,7 +1762,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
 		return -EINVAL;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		ret = -EBUSY;
 		goto out;
@@ -1784,7 +1784,7 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 
 	drvdata->reading = true;
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return ret;
 }
@@ -1798,7 +1798,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	if (WARN_ON_ONCE(drvdata->config_type != TMC_CONFIG_TYPE_ETR))
 		return -EINVAL;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* RE-enable the TMC if need be */
 	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
@@ -1818,7 +1818,7 @@ int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
 	}
 
 	drvdata->reading = false;
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free allocated memory out side of the spinlock */
 	if (sysfs_buf)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 2671926be62a..60b395025bc4 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -195,7 +195,7 @@ struct tmc_drvdata {
 	void __iomem		*base;
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
-	spinlock_t		spinlock;
+	raw_spinlock_t		spinlock;
 	pid_t			pid;
 	bool			reading;
 	union {
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

