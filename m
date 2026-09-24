Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9874BD0EB
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 17:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271269; cv=none; b=fpPJYf8b4LFsfzXdfYKBqIQEFyyHzGp584uWjPpmE3mLLmAfrlwNQaRTUV0aDHWe+0oOG1DlV2rf5eoTKPJuxmxT/31i/BzycsSkiNNtqBy46i7VstQFHhWA9iLHjmxS+Z8+VCufGxbo/9pCwpKjI6bSDE+YR9sYLf7tzHQZVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271269; c=relaxed/simple;
	bh=L5ml6IbiyG0hIHuWWCnceABE7F0ifMbwCyZYqoDTsJ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sELXQXm2gdGc6ZqwwTUxttk4yyKVsYvtmDGFBT8HqCYX/vBzdafUI1Tln11XpwJa0BlVZreh4Fuc3GSSNAXVPW/Q2bWFZEgrZfb/ohTuJBSa6uBFobT5euXPN+/AjTbVoNkfnNCJ/mNxxGDzNR1Oh46M5eGd6pEaMIfECvljtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=AywdBkny; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="AywdBkny"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A90AC1E4D;
	Thu, 24 Sep 2026 10:34:23 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D50EA3F86F;
	Thu, 24 Sep 2026 10:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790271267; bh=L5ml6IbiyG0hIHuWWCnceABE7F0ifMbwCyZYqoDTsJ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AywdBknyFQPB6T/xmLYCcq29oNPKkBTNMU88WbZmStF32VNwqew0u605J9KBZiP+h
	 xKFFFp+4epm/3uyrfOjgEUotpbKh6i2+zjb6ll/cZ7ZOdQAx60LL5bEzS0VfI+Rw6w
	 uBMRCGbUo4PBv+thoPg87peAmt0Wye2yiGXjoAxQ=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Thu, 24 Sep 2026 18:33:43 +0100
Subject: [PATCH v12 05/14] coresight: etm3x: fix inconsistencies with sysfs
 configuration
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-separate_etm_cfg_v2-v12-5-a2b41d2f7c2b@arm.com>
References: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
In-Reply-To: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11500; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=L5ml6IbiyG0hIHuWWCnceABE7F0ifMbwCyZYqoDTsJ0=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqtV8NcFsf2CDPAkHlGwOg73/fhyVNHhZy79gKl
 6tc/9mKjXqJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarVfDQAKCRBt1cPRWsUx
 M1A0DAC6r7SArWABElu7KxTrv1gve0um+8Q6H05Ml1LoX3M6G+OKEh0shMra0LjtMnSnWL99DYG
 ApewwpFqN57//A+H6FhoyMxUd7MJisZq1aDQDaKDOrynGyOgeFBDsdeAQ4swGTEcoxI/5j9Kvnw
 7Tl9Oyi0u+hFSgiNT7rp3PzmLXEeEnCHV9YsNMWxPJoSJUARkPg16s2zppgzME/qaMUQTh0WkYM
 syMAkNlDEfkPNJyIFOp8KRA7IQn+unjcgtvwOgdUmWUnpRZSkYAz6+qNo/BnbozvlVkeGtBDq49
 dkMjJdgD3KYq3xOhDEkhZbcz5emPijn876ITrhPwXQCi6CIDbVF4pytPrZQWDPuWHdYIFJ0WE0/
 kNkLw7IpBRaeSk04zm9hoRQJT6RRwndQvqsQEviArSVCnDaDCcia1FglPhtoUFCHQnweqTx0EhP
 rcTMVm6jAYrk3YLCOXGf2Kdbmhe/0MjqYakpDub60WSCYsDMQvkAVpqW0pasqiwT9sEYI=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The current ETM3x configuration via sysfs can lead to the following
inconsistencies:

  - If a configuration is modified via sysfs while a perf session is
    active, the running configuration may differ between before
    a sched-out and after a subsequent sched-in.

To resolve these issues, separate the configuration into:

  - curr_config: the configuration applied to the current session
  - config: the configuration set via sysfs

Additionally:

  - Since curr_config and related fields are accessed only by the local CPU
    in etm_enable/disable_sysfs_smp_call() (similar to perf enable/disable),
    remove the lock/unlock from the sysfs enable/disable path and
    starting/dying_cpu path except when to access config fields only.

  - Some of sysfs interface read etm register directly. To reduce lock
    scope while the etm_enable_hw()/etm_disable_hw(), handle it via
    IPI so that registers could be read from on proper CPU.

Fixes: 1925a470ce69 ("coresight: etm3x: splitting struct etm_drvdata")
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm.h        |  4 +-
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 66 ++++++++++--------
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 80 +++++++++++++++-------
 3 files changed, 98 insertions(+), 52 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 1d753cca2943..52f23a3c7364 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -226,7 +226,8 @@ struct etm_config {
  * @etmccr:	value of register ETMCCR.
  * @etmccer:	value of register ETMCCER.
  * @traceid:	value of the current ID for this component.
- * @config:	structure holding configuration parameters.
+ * @curr_config:	structure holding current running configuration.
+ * @config:	structure holding sysfs mode configuration.
  */
 struct etm_drvdata {
 	struct csdev_access		csa;
@@ -248,6 +249,7 @@ struct etm_drvdata {
 	u32				etmccr;
 	u32				etmccer;
 	u32				traceid;
+	struct etm_config		curr_config;
 	struct etm_config		config;
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 862ad0786699..dcadcc383012 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -308,7 +308,7 @@ void etm_config_trace_mode(struct etm_config *config)
 static int etm_parse_event_config(struct etm_drvdata *drvdata,
 				  struct perf_event *event)
 {
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *config = &drvdata->curr_config;
 	struct perf_event_attr *attr = &event->attr;
 	u8 ts_level;
 
@@ -367,7 +367,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 {
 	int i, rc;
 	u32 etmcr;
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *config = &drvdata->curr_config;
 	struct coresight_device *csdev = drvdata->csdev;
 
 	CS_UNLOCK(drvdata->csa.base);
@@ -448,26 +448,22 @@ struct etm_enable_arg {
 static void etm_enable_sysfs_smp_call(void *info)
 {
 	struct etm_enable_arg *arg = info;
+	struct etm_drvdata *drvdata;
 	struct coresight_device *csdev;
 
 	if (WARN_ON(!arg))
 		return;
 
-	csdev = arg->drvdata->csdev;
-	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
-		/* Someone is already using the tracer */
-		arg->rc = -EBUSY;
-		return;
-	}
+	drvdata = arg->drvdata;
+	csdev = drvdata->csdev;
 
-	arg->rc = etm_enable_hw(arg->drvdata);
+	drvdata->traceid = arg->path->trace_id;
 
-	/* The tracer didn't start */
-	if (arg->rc) {
-		coresight_set_mode(csdev, CS_MODE_DISABLED);
+	arg->rc = etm_enable_hw(arg->drvdata);
+	if (arg->rc)
 		return;
-	}
 
+	drvdata->sticky_enable = true;
 	csdev->path = arg->path;
 }
 
@@ -512,9 +508,10 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
 	struct etm_enable_arg arg = { };
 	int ret;
 
-	spin_lock(&drvdata->spinlock);
-
-	drvdata->traceid = path->trace_id;
+	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
+		/* Someone is already using the tracer */
+		return -EBUSY;
+	}
 
 	/*
 	 * Configure the ETM only if the CPU is online.  If it isn't online
@@ -523,23 +520,27 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
 	if (cpu_online(drvdata->cpu)) {
 		arg.drvdata = drvdata;
 		arg.path = path;
+
+		scoped_guard(spinlock, &drvdata->spinlock) {
+			drvdata->curr_config = drvdata->config;
+		}
+
 		ret = smp_call_function_single(drvdata->cpu,
 					       etm_enable_sysfs_smp_call, &arg, 1);
 		if (!ret)
 			ret = arg.rc;
-		if (!ret)
-			drvdata->sticky_enable = true;
 	} else {
 		ret = -ENODEV;
 	}
 
-	if (ret)
+	if (!ret) {
+		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
+	} else {
 		etm_release_trace_id(drvdata);
+		/* The tracer didn't start */
+		coresight_set_mode(csdev, CS_MODE_DISABLED);
+	}
 
-	spin_unlock(&drvdata->spinlock);
-
-	if (!ret)
-		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
 	return ret;
 }
 
@@ -565,7 +566,7 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
 static void etm_disable_hw(struct etm_drvdata *drvdata)
 {
 	int i;
-	struct etm_config *config = &drvdata->config;
+	struct etm_config *config = &drvdata->curr_config;
 	struct coresight_device *csdev = drvdata->csdev;
 
 	CS_UNLOCK(drvdata->csa.base);
@@ -593,7 +594,6 @@ static void etm_disable_sysfs_smp_call(void *info)
 	etm_disable_hw(drvdata);
 
 	drvdata->csdev->path = NULL;
-	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
 }
 
 static void etm_disable_perf(struct coresight_device *csdev)
@@ -630,8 +630,9 @@ static void etm_disable_perf(struct coresight_device *csdev)
 static void etm_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	spin_lock(&drvdata->spinlock);
+	struct etm_config *config = &drvdata->config;
+	const struct etm_config *curr_config = &drvdata->curr_config;
+	int i;
 
 	/*
 	 * Executing etm_disable_hw on the cpu whose ETM is being disabled
@@ -640,7 +641,14 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	smp_call_function_single(drvdata->cpu, etm_disable_sysfs_smp_call,
 				 drvdata, 1);
 
-	spin_unlock(&drvdata->spinlock);
+	/*
+	 * Userspace may read seq_curr_state and cntr_val through sysfs
+	 * after the sysfs-session has been disabled.
+	 */
+	for (i = 0; i < drvdata->nr_cntr; i++)
+		config->cntr_val[i] = curr_config->cntr_val[i];
+
+	config->seq_curr_state = curr_config->seq_curr_state;
 
 	/*
 	 * we only release trace IDs when resetting sysfs.
@@ -649,6 +657,8 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	 * prior trace id allocation method
 	 */
 
+	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
+
 	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index cdb70a4382eb..284998f18017 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -6,10 +6,48 @@
 
 #include <linux/pid_namespace.h>
 #include <linux/pm_runtime.h>
+#include <linux/smp.h>
 #include <linux/sysfs.h>
 #include "coresight-etm.h"
 #include "coresight-priv.h"
 
+struct etm_readl_cslocked_arg {
+	struct etm_drvdata *drvdata;
+	u32 off;
+	unsigned long *val;
+};
+
+static void etm_readl_cslocked_smp_call(void *info)
+{
+	struct etm_readl_cslocked_arg *arg = info;
+
+	CS_UNLOCK(arg->drvdata->csa.base);
+	*arg->val = etm_readl(arg->drvdata, arg->off);
+	CS_LOCK(arg->drvdata->csa.base);
+}
+
+static int etm_readl_cslocked(struct etm_drvdata *drvdata, u32 off,
+			      unsigned long *val)
+{
+	int ret;
+	struct etm_readl_cslocked_arg arg;
+
+	ret = pm_runtime_get_sync(drvdata->csdev->dev.parent);
+	if (ret < 0)
+		goto out;
+
+	arg.drvdata = drvdata;
+	arg.off = off;
+	arg.val = val;
+
+	ret = smp_call_function_single(drvdata->cpu,
+				       etm_readl_cslocked_smp_call,
+				       (void *)&arg, 1);
+out:
+	pm_runtime_put(drvdata->csdev->dev.parent);
+	return ret;
+}
+
 static ssize_t nr_addr_cmp_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -45,18 +83,13 @@ static DEVICE_ATTR_RO(nr_ctxid_cmp);
 static ssize_t etmsr_show(struct device *dev,
 			  struct device_attribute *attr, char *buf)
 {
-	unsigned long flags, val;
+	int ret;
+	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	pm_runtime_get_sync(dev->parent);
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-	CS_UNLOCK(drvdata->csa.base);
-
-	val = etm_readl(drvdata, ETMSR);
-
-	CS_LOCK(drvdata->csa.base);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	pm_runtime_put(dev->parent);
+	ret = etm_readl_cslocked(drvdata, ETMSR, &val);
+	if (ret)
+		return ret;
 
 	return sprintf(buf, "%#lx\n", val);
 }
@@ -76,7 +109,7 @@ static ssize_t reset_store(struct device *dev,
 		return ret;
 
 	if (IS_ERR_OR_NULL(drvdata->csdev) ||
-	    coresight_get_mode(drvdata->csdev))
+	    coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
 		return -EBUSY;
 
 	if (val) {
@@ -721,7 +754,9 @@ static DEVICE_ATTR_RW(cntr_rld_event);
 static ssize_t cntr_val_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
 {
+	int ret;
 	u32 val;
+	unsigned long val2;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
@@ -730,7 +765,10 @@ static ssize_t cntr_val_show(struct device *dev,
 		val = config->cntr_val[config->cntr_idx];
 		spin_unlock(&drvdata->spinlock);
 	} else {
-		val = etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
+		ret = etm_readl_cslocked(drvdata, ETMCNTVRn(config->cntr_idx), &val2);
+		if (ret)
+			return ret;
+		val = val2;
 	}
 
 	return sysfs_emit(buf, "%#x\n", val);
@@ -749,7 +787,7 @@ static ssize_t cntr_val_store(struct device *dev,
 	if (ret)
 		return ret;
 	if (IS_ERR_OR_NULL(drvdata->csdev) ||
-	    coresight_get_mode(drvdata->csdev))
+	    coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
 		return -EBUSY;
 
 	spin_lock(&drvdata->spinlock);
@@ -937,7 +975,8 @@ static DEVICE_ATTR_RW(seq_13_event);
 static ssize_t seq_curr_state_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	unsigned long val, flags;
+	int ret;
+	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	struct etm_config *config = &drvdata->config;
 
@@ -946,15 +985,10 @@ static ssize_t seq_curr_state_show(struct device *dev,
 		goto out;
 	}
 
-	pm_runtime_get_sync(dev->parent);
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-
-	CS_UNLOCK(drvdata->csa.base);
-	val = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
-	CS_LOCK(drvdata->csa.base);
-
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-	pm_runtime_put(dev->parent);
+	ret = etm_readl_cslocked(drvdata, ETMSQR, &val);
+	if (ret)
+		return ret;
+	val &= ETM_SQR_MASK;
 out:
 	return sprintf(buf, "%#lx\n", val);
 }

-- 
2.43.0

