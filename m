Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C54191F94
	for <linux-rt-devel@lists.linux.dev>; Mon, 25 Nov 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528116; cv=none; b=aaFK1RmYETWm4+6ncWrGO3loaGyToxc1QI8RYuCeBbYOVTR1huIUqWnWXj2lq3W9lSuvi/gopYT3qO2EaqeGDU0jC8VRhctYka946rI6dnBcC6FaTjosTz1pihVfTp4kFNiHEpqrbFCDtNVS6unKxDAhMi3eByerfcIxNUpKhZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528116; c=relaxed/simple;
	bh=zU4bpZy/SFTjJmyIE/IrCPa01LhIUwlxVkvBGUSgpO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UsFKkV02ZdnVgwOTWTjf7EVFen3ibk9UX1Lut68NdckBWscm0cwqoIvysfonKiCtYRbVtDtoWpy+1gfrFE7DMnaybZXu+a8Xn1+NSeE+KHYEWYHoc3N1HJ9gw4WfYR4GPTM0Zp8pPU+IyiTm3w9Gdpz12HYumWr9iYM1EMQHsjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C16821756;
	Mon, 25 Nov 2024 01:49:03 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8DBBF3F66E;
	Mon, 25 Nov 2024 01:48:31 -0800 (PST)
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
Subject: [PATCH 5/9] coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
Date: Mon, 25 Nov 2024 09:48:12 +0000
Message-Id: <20241125094816.365472-6-yeoreum.yun@arm.com>
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

In coresight-etb10 drivers, etb_drvdata->spinlock can be held
during __schedule() by perf_event_task_sched_out()/in().

Since etb_drvdata->spinlock type is spinlock_t and
perf_event_task_sched_out()/in() is called after acquiring rq_lock,
which is raw_spinlock_t (an unsleepable lock),
this poses an issue in PREEMPT_RT kernel where spinlock_t is sleepable.

To address this, change type etb_drvdata->spinlock in coresight-etb10 drivers,
which can be called by perf_event_task_sched_out()/in(),
from spinlock_t to raw_spinlock_t.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c | 62 +++++++------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index aea9ac9c4bd0..ec439f8fbc1e 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -84,7 +84,7 @@ struct etb_drvdata {
 	struct clk		*atclk;
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
-	spinlock_t		spinlock;
+	raw_spinlock_t		spinlock;
 	local_t			reading;
 	pid_t			pid;
 	u8			*buf;
@@ -141,56 +141,47 @@ static int etb_enable_hw(struct etb_drvdata *drvdata)
 
 static int etb_enable_sysfs(struct coresight_device *csdev)
 {
-	int ret = 0;
-	unsigned long flags;
+	int ret;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	guard(raw_spinlock_irqsave)(&drvdata->spinlock);
 
 	/* Don't messup with perf sessions. */
-	if (coresight_get_mode(csdev) == CS_MODE_PERF) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (coresight_get_mode(csdev) == CS_MODE_PERF)
+		return -EBUSY;
 
 	if (coresight_get_mode(csdev) == CS_MODE_DISABLED) {
 		ret = etb_enable_hw(drvdata);
 		if (ret)
-			goto out;
+			return ret;
 
 		coresight_set_mode(csdev, CS_MODE_SYSFS);
 	}
 
 	csdev->refcnt++;
-out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	return ret;
+
+	return 0;
 }
 
 static int etb_enable_perf(struct coresight_device *csdev, void *data)
 {
-	int ret = 0;
+	int ret;
 	pid_t pid;
-	unsigned long flags;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct perf_output_handle *handle = data;
 	struct cs_buffers *buf = etm_perf_sink_config(handle);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	guard(raw_spinlock_irqsave)(&drvdata->spinlock);
 
 	/* No need to continue if the component is already in used by sysFS. */
-	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
+		return -EBUSY;
 
 	/* Get a handle on the pid of the process to monitor */
 	pid = buf->pid;
 
-	if (drvdata->pid != -1 && drvdata->pid != pid) {
-		ret = -EBUSY;
-		goto out;
-	}
+	if (drvdata->pid != -1 && drvdata->pid != pid)
+		return -EBUSY;
 
 	/*
 	 * No HW configuration is needed if the sink is already in
@@ -198,7 +189,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	 */
 	if (drvdata->pid == pid) {
 		csdev->refcnt++;
-		goto out;
+		return 0;
 	}
 
 	/*
@@ -208,7 +199,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	 */
 	ret = etb_set_buffer(csdev, handle);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = etb_enable_hw(drvdata);
 	if (!ret) {
@@ -218,8 +209,6 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 		csdev->refcnt++;
 	}
 
-out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return ret;
 }
 
@@ -350,13 +339,11 @@ static void etb_disable_hw(struct etb_drvdata *drvdata)
 static int etb_disable(struct coresight_device *csdev)
 {
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	unsigned long flags;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	guard(raw_spinlock_irqsave)(&drvdata->spinlock);
 
 	csdev->refcnt--;
 	if (csdev->refcnt) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
 
@@ -366,7 +353,6 @@ static int etb_disable(struct coresight_device *csdev)
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
 	coresight_set_mode(csdev, CS_MODE_DISABLED);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(&csdev->dev, "ETB disabled\n");
 	return 0;
@@ -434,7 +420,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	const u32 *barrier;
 	u32 read_ptr, write_ptr, capacity;
 	u32 status, read_data;
-	unsigned long offset, to_read = 0, flags;
+	unsigned long offset, to_read = 0;
 	struct cs_buffers *buf = sink_config;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
@@ -443,11 +429,11 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	guard(raw_spinlock_irqsave)(&drvdata->spinlock);
 
 	/* Don't do anything if another tracer is using this sink */
 	if (csdev->refcnt != 1)
-		goto out;
+		return 0;
 
 	__etb_disable_hw(drvdata);
 	CS_UNLOCK(drvdata->base);
@@ -565,8 +551,6 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	__etb_enable_hw(drvdata);
 	CS_LOCK(drvdata->base);
-out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return to_read;
 }
@@ -585,15 +569,13 @@ static const struct coresight_ops etb_cs_ops = {
 
 static void etb_dump(struct etb_drvdata *drvdata)
 {
-	unsigned long flags;
+	guard(raw_spinlock_irqsave)(&drvdata->spinlock);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
 		__etb_disable_hw(drvdata);
 		etb_dump_hw(drvdata);
 		__etb_enable_hw(drvdata);
 	}
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(&drvdata->csdev->dev, "ETB dumped\n");
 }
@@ -746,7 +728,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->base = base;
 	desc.access = CSDEV_ACCESS_IOMEM(base);
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 
 	drvdata->buffer_depth = etb_get_buffer_depth(drvdata);
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

