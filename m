Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABDA2054F1
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Dec 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734349824; cv=none; b=SrylG/9IA3EaCrqfAx544uSAuWRlfi6jEVeP3HBB1n35cdJDAXKyyWRcrkgxr+iz0sMOq2QyYnIgFIPPHB0qz5aNOekycIAp2DAPU22roC+CZ/0r7fo3DYIkq1/COtIPyZ8wSkRA9EY4tU0TGDypcGOwyBk9dadd0qLISKy2hdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734349824; c=relaxed/simple;
	bh=IrwLoUb5O0ODsR5ovbo1Pbju3kQWwEkKaKsXaQvHDus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJdZfYJPYuBMC02EjznOKmoBAHebIFeUpIY5CN1ryB5l2Cz5G9CjjgzPv9ww+JPjSRzTFSg7QNJtWnxvqqiNZ/d+p3z3vnU4QPPpU0U+1rjY5q6XLe9hPBLJG+JAd9YMLR2lJ21g2zCnYk8kPPX6csU+K8svibsjV7TXrh60iPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B108011FB;
	Mon, 16 Dec 2024 03:50:50 -0800 (PST)
Received: from e129823.cambridge.arm.com (e129823.arm.com [10.1.197.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 970013F58B;
	Mon, 16 Dec 2024 03:50:20 -0800 (PST)
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
Subject: [PATCH v3 5/9] coresight-etb10: change etb_drvdata spinlock's type to raw_spinlock_t
Date: Mon, 16 Dec 2024 11:50:02 +0000
Message-Id: <20241216115006.415861-6-yeoreum.yun@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241216115006.415861-1-yeoreum.yun@arm.com>
References: <20241216115006.415861-1-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
 drivers/hwtracing/coresight/coresight-etb10.c | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index aea9ac9c4bd0..7948597d483d 100644
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
@@ -145,7 +145,7 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 	unsigned long flags;
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't messup with perf sessions. */
 	if (coresight_get_mode(csdev) == CS_MODE_PERF) {
@@ -163,7 +163,7 @@ static int etb_enable_sysfs(struct coresight_device *csdev)
 
 	csdev->refcnt++;
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return ret;
 }
 
@@ -176,7 +176,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	struct perf_output_handle *handle = data;
 	struct cs_buffers *buf = etm_perf_sink_config(handle);
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* No need to continue if the component is already in used by sysFS. */
 	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
@@ -219,7 +219,7 @@ static int etb_enable_perf(struct coresight_device *csdev, void *data)
 	}
 
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return ret;
 }
 
@@ -352,11 +352,11 @@ static int etb_disable(struct coresight_device *csdev)
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	unsigned long flags;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	csdev->refcnt--;
 	if (csdev->refcnt) {
-		spin_unlock_irqrestore(&drvdata->spinlock, flags);
+		raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 		return -EBUSY;
 	}
 
@@ -366,7 +366,7 @@ static int etb_disable(struct coresight_device *csdev)
 	/* Dissociate from monitored process. */
 	drvdata->pid = -1;
 	coresight_set_mode(csdev, CS_MODE_DISABLED);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(&csdev->dev, "ETB disabled\n");
 	return 0;
@@ -443,7 +443,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	capacity = drvdata->buffer_depth * ETB_FRAME_SIZE_WORDS;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
 	/* Don't do anything if another tracer is using this sink */
 	if (csdev->refcnt != 1)
@@ -566,7 +566,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 	__etb_enable_hw(drvdata);
 	CS_LOCK(drvdata->base);
 out:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	return to_read;
 }
@@ -587,13 +587,13 @@ static void etb_dump(struct etb_drvdata *drvdata)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&drvdata->spinlock, flags);
+	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS) {
 		__etb_disable_hw(drvdata);
 		etb_dump_hw(drvdata);
 		__etb_enable_hw(drvdata);
 	}
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	dev_dbg(&drvdata->csdev->dev, "ETB dumped\n");
 }
@@ -746,7 +746,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->base = base;
 	desc.access = CSDEV_ACCESS_IOMEM(base);
 
-	spin_lock_init(&drvdata->spinlock);
+	raw_spin_lock_init(&drvdata->spinlock);
 
 	drvdata->buffer_depth = etb_get_buffer_depth(drvdata);
 
-- 
LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}

