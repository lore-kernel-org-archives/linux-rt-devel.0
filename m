Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE9F4C7536
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472102; cv=none; b=Pw0EulxpZ53EPl8Ex40g62pPGD8GiKw1gkdAFUSZMeOiQmAkB9J+/+V5OTh2BbxxZU2P8wJxWeEl6uEHp5dGp3euiaOo33AXKOA57Qn4CfiHrLf6+hZd/ROVyjthAqU1cK7g19PrHBPCJhKw0KtuC+hYp0GgRJoMWgB0bRxPgIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472102; c=relaxed/simple;
	bh=HFYTQP323JtBTvg1BVTZADAyiBCtU9wB5UWOCz0TQ2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kL6mdfuJXwxEhUyhEsgdNLXfjDKDeS9GF7SfNG5p2PSQx3RC26fFCjlvGi3iP9CL+y+/g6A7b42omPPIgDbyiXwum5BU0PrtMgTl9qDwFapiW1MZJjWwb4Evz19vXuvt6GsCLw2lDm7lOKEkfxnWhSFVolei+uQ+LaykYu97Fr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a/7x0Vwt; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a/7x0Vwt"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7811B153B;
	Tue, 15 Sep 2026 04:34:52 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E2F73F86F;
	Tue, 15 Sep 2026 04:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789472096; bh=HFYTQP323JtBTvg1BVTZADAyiBCtU9wB5UWOCz0TQ2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a/7x0Vwthruy45AieNT2n99DxaxySUvBlEjTKzW6MCv59nYS5CXnUNlZ1kdNy9vlp
	 tZrDeOWZQ+ArC2eCJOeeuUao2V7e+c7HDMAdVbIEW48edOVNFUVMisrbh8z7cdkEJi
	 BMhTvgx+SAiDmvIgwJ9+WueaWOq19LcGKYkIz7qU=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Tue, 15 Sep 2026 12:34:38 +0100
Subject: [PATCH v11 3/9] coresight: etm4x: fix inconsistencies with sysfs
 configuration
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-separate_etm_cfg_v2-v11-3-d2b258d51747@arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18252; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=HFYTQP323JtBTvg1BVTZADAyiBCtU9wB5UWOCz0TQ2k=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqqS1Ui4G31UbZIJdnjmYP/A6ZVc/7zKgzzxNpW
 uugJKTLLfyJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqktVAAKCRBt1cPRWsUx
 M/+WC/9fYTudurXyEJ1xVpxxNhu1HCf92B3jxMjAguNcoj+aJu5QXWrTWSsoYYnoPxBxSyxBuHW
 /76wJdA9EiMlpSCgSoC0F0Lpxtdm142Mon0Yd5vhiEo7uXkxEStHvr4oUZBDgv+8C/rCg/pGfZl
 M4YVr2yrsx1nv66EeE3BbgwXfyIkT7oHwxyiP4RCYolktdlzDXena8BgJohGR++DMkOZn2LwvYF
 +uViX0VNaY+GWgRAeieWiWSKp8mGSl0lkF1xnn1JfBsoXCIVqUxX+td5SxCBc/SOBTb6bUDM6M5
 DNDiDrgpUJYJkV9HqCrGx4S0JplJxT7Cg1jQ2zLAqEtzS/1FEPaeVhjIx4A7MO3fTXLpkbbS+i2
 8KIafa+M07rbQgK9XnlgBYmjh7lgEvhy163cxsDyLUyec/jKJjkdBPvFvXg5G7g79f7srqWJwjS
 9bNzW6XqbCGZgnNawf7t3lZTcTntRTQOHe1qgQVz8kztiGgmoXAB0BvvKTMOb7122slzs=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The current ETM4x configuration via sysfs can lead to
several inconsistencies:

  - If the configuration is modified via sysfs while a perf session is
    active, the running configuration may differ before a sched-out and
    after a subsequent sched-in.

  - If a perf session and a sysfs session enable tracing concurrently,
    the configuration from configfs may become corrupted.

  - There is a risk of corrupting drvdata->config if a perf session enables
    tracing while cscfg_csdev_disable_active_config() is being handled in
    etm4_disable_sysfs().

To resolve these issues, separate the configuration into:

  - active_config: the configuration applied to the current session
  - config: the configuration set via sysfs

Additionally:

  - Apply the configuration from configfs after taking the appropriate mode.

  - Since active_config and related fields are accessed only by the local CPU
    in etm4_enable/disable_sysfs_smp_call() (similar to perf enable/disable),
    remove the lock/unlock from the sysfs enable/disable path and
    startup/dying_cpu except when to access config fields.

As the active_config is used for cfg-configfs, etmv4 doesn't need to set
its lock for the cfg-configfs since the active_config is proceted by cs_mode
otherwise it would make a possible cpu-stall when it get interrupt while
setting the sysfs configuration.

Therefore, set the drv_spinlock for cfg-configfs as NULL and
let the cfg-configfs disable irq without grap drv_spinlock when it is NULL.

Fixes: 54ff892b76c6 ("coresight: etm4x: splitting struct etmv4_drvdata")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-config.c     |  18 ++--
 drivers/hwtracing/coresight/coresight-config.h     |  22 ++++
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c  |  13 ++-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 118 ++++++++++++---------
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   6 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   4 +-
 6 files changed, 113 insertions(+), 68 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-config.c b/drivers/hwtracing/coresight/coresight-config.c
index 4f72ae71b696e..0e296289f286d 100644
--- a/drivers/hwtracing/coresight/coresight-config.c
+++ b/drivers/hwtracing/coresight/coresight-config.c
@@ -73,13 +73,12 @@ static void cscfg_init_reg_param(struct cscfg_feature_csdev *feat_csdev,
 /* set values into the driver locations referenced in cscfg_reg_csdev */
 static int cscfg_set_on_enable(struct cscfg_feature_csdev *feat_csdev)
 {
-	unsigned long flags;
 	int i;
 
-	raw_spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
-	for (i = 0; i < feat_csdev->nr_regs; i++)
-		cscfg_set_reg(&feat_csdev->regs_csdev[i]);
-	raw_spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
+	scoped_guard(feat_csdev_lock, feat_csdev) {
+		for (i = 0; i < feat_csdev->nr_regs; i++)
+			cscfg_set_reg(&feat_csdev->regs_csdev[i]);
+	}
 	dev_dbg(&feat_csdev->csdev->dev, "Feature %s: %s",
 		feat_csdev->feat_desc->name, "set on enable");
 	return 0;
@@ -88,13 +87,12 @@ static int cscfg_set_on_enable(struct cscfg_feature_csdev *feat_csdev)
 /* copy back values from the driver locations referenced in cscfg_reg_csdev */
 static void cscfg_save_on_disable(struct cscfg_feature_csdev *feat_csdev)
 {
-	unsigned long flags;
 	int i;
 
-	raw_spin_lock_irqsave(feat_csdev->drv_spinlock, flags);
-	for (i = 0; i < feat_csdev->nr_regs; i++)
-		cscfg_save_reg(&feat_csdev->regs_csdev[i]);
-	raw_spin_unlock_irqrestore(feat_csdev->drv_spinlock, flags);
+	scoped_guard(feat_csdev_lock, feat_csdev) {
+		for (i = 0; i < feat_csdev->nr_regs; i++)
+			cscfg_save_reg(&feat_csdev->regs_csdev[i]);
+	}
 	dev_dbg(&feat_csdev->csdev->dev, "Feature %s: %s",
 		feat_csdev->feat_desc->name, "save on disable");
 }
diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwtracing/coresight/coresight-config.h
index 90fd937d3bd83..ae6295e308131 100644
--- a/drivers/hwtracing/coresight/coresight-config.h
+++ b/drivers/hwtracing/coresight/coresight-config.h
@@ -7,6 +7,7 @@
 #ifndef _CORESIGHT_CORESIGHT_CONFIG_H
 #define _CORESIGHT_CORESIGHT_CONFIG_H
 
+#include <linux/cleanup.h>
 #include <linux/coresight.h>
 #include <linux/types.h>
 
@@ -259,4 +260,25 @@ void cscfg_csdev_disable_config(struct cscfg_config_csdev *config_csdev);
 /* reset a feature to default values */
 void cscfg_reset_feat(struct cscfg_feature_csdev *feat_csdev);
 
+#define feat_csdev_lock(feat_csdev, flags)				\
+	do {								\
+		raw_spinlock_t *__lock = feat_csdev->drv_spinlock;	\
+		typecheck(unsigned long, flags);			\
+		if (__lock)						\
+			raw_spin_lock_irqsave(__lock, flags);		\
+	} while (0)
+
+#define feat_csdev_unlock(feat_csdev, flags)				\
+	do {								\
+		raw_spinlock_t *__lock = feat_csdev->drv_spinlock;	\
+		typecheck(unsigned long, flags);			\
+		if (__lock)						\
+			raw_spin_unlock_irqrestore(__lock, flags);	\
+	} while (0)
+
+DEFINE_LOCK_GUARD_1(feat_csdev_lock, struct cscfg_feature_csdev,
+		    feat_csdev_lock(_T->lock, _T->flags),
+		    feat_csdev_unlock(_T->lock, _T->flags),
+		    unsigned long flags)
+
 #endif /* _CORESIGHT_CORESIGHT_CONFIG_H */
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
index e1a59b4345052..d24f533c623d0 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
@@ -47,7 +47,7 @@ static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
 				   struct cscfg_regval_csdev *reg_csdev, u32 offset)
 {
 	int err = -EINVAL, idx;
-	struct etmv4_config *drvcfg = &drvdata->config;
+	struct etmv4_config *drvcfg = &drvdata->active_config;
 	u32 off_mask;
 
 	if (((offset >= TRCEVENTCTL0R) && (offset <= TRCVIPCSSCTLR)) ||
@@ -154,11 +154,14 @@ static int etm4_cfg_load_feature(struct coresight_device *csdev,
 	int i = 0, err = 0;
 
 	/*
-	 * essential we set the device spinlock - this is used in the generic
-	 * programming routines when copying values into the drvdata structures
-	 * via the pointers setup in etm4_cfg_map_reg_offset().
+	 * drvdata structure of etm4 for configfs is active_config and
+	 * this active_config is protected with csdev->mode by restricting
+	 * access to active_config after mode changed to PERF or SYSFS.
+	 *
+	 * Therefore, it doesn't need to protected with etmv4_drvdata->spinlock
+	 * to feature applying and set the NULL.
 	 */
-	feat_csdev->drv_spinlock = &drvdata->spinlock;
+	feat_csdev->drv_spinlock = NULL;
 
 	/* process the register descriptions */
 	for (i = 0; i < feat_csdev->nr_regs && !err; i++) {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 2247ad55d4442..2df7f592bb5cf 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -239,6 +239,7 @@ void etm4_release_trace_id(struct etmv4_drvdata *drvdata)
 struct etm4_enable_arg {
 	struct etmv4_drvdata *drvdata;
 	struct coresight_path *path;
+	struct etmv4_config config;
 	int rc;
 };
 
@@ -264,10 +265,11 @@ static void etm4x_prohibit_trace(struct etmv4_drvdata *drvdata)
 static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
 {
 	u64 trfcr = drvdata->trfcr;
+	struct etmv4_config *config = &drvdata->active_config;
 
-	if (drvdata->config.mode & ETM_MODE_EXCL_KERN)
+	if (config->mode & ETM_MODE_EXCL_KERN)
 		trfcr &= ~TRFCR_EL1_ExTRE;
-	if (drvdata->config.mode & ETM_MODE_EXCL_USER)
+	if (config->mode & ETM_MODE_EXCL_USER)
 		trfcr &= ~TRFCR_EL1_E0TRE;
 
 	return trfcr;
@@ -275,7 +277,7 @@ static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
 
 /*
  * etm4x_allow_trace - Allow CPU tracing in the respective ELs,
- * as configured by the drvdata->config.mode for the current
+ * as configured by the drvdata->active_config.mode for the current
  * session. Even though we have TRCVICTLR bits to filter the
  * trace in the ELs, it doesn't prevent the ETM from generating
  * a packet (e.g, TraceInfo) that might contain the addresses from
@@ -286,12 +288,13 @@ static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
 static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
 {
 	u64 trfcr, guest_trfcr;
+	struct etmv4_config *config = &drvdata->active_config;
 
 	/* If the CPU doesn't support FEAT_TRF, nothing to do */
 	if (!drvdata->trfcr)
 		return;
 
-	if (drvdata->config.mode & ETM_MODE_EXCL_HOST)
+	if (config->mode & ETM_MODE_EXCL_HOST)
 		trfcr = drvdata->trfcr & ~(TRFCR_EL1_ExTRE | TRFCR_EL1_E0TRE);
 	else
 		trfcr = etm4x_get_kern_user_filter(drvdata);
@@ -299,7 +302,7 @@ static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
 	write_trfcr(trfcr);
 
 	/* Set filters for guests and pass to KVM */
-	if (drvdata->config.mode & ETM_MODE_EXCL_GUEST)
+	if (config->mode & ETM_MODE_EXCL_GUEST)
 		guest_trfcr = drvdata->trfcr & ~(TRFCR_EL1_ExTRE | TRFCR_EL1_E0TRE);
 	else
 		guest_trfcr = etm4x_get_kern_user_filter(drvdata);
@@ -492,7 +495,7 @@ static int etm4_enable_trace_unit(struct etmv4_drvdata *drvdata)
 static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->active_config;
 	struct coresight_device *csdev = drvdata->csdev;
 	struct device *etm_dev = &csdev->dev;
 	struct csdev_access *csa = &csdev->access;
@@ -612,27 +615,44 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 static void etm4_enable_sysfs_smp_call(void *info)
 {
 	struct etm4_enable_arg *arg = info;
+	struct etmv4_drvdata *drvdata;
 	struct coresight_device *csdev;
+	unsigned long cfg_hash;
+	int preset;
 
 	if (WARN_ON(!arg))
 		return;
 
-	csdev = arg->drvdata->csdev;
-	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
-		/* Someone is already using the tracer */
-		arg->rc = -EBUSY;
-		return;
+	drvdata = arg->drvdata;
+	csdev = drvdata->csdev;
+
+	drvdata->active_config = arg->config;
+
+	/* enable any config activated by configfs */
+	cscfg_config_sysfs_get_active_cfg(&cfg_hash, &preset);
+	if (cfg_hash) {
+		arg->rc = cscfg_csdev_enable_active_config(csdev,
+							   cfg_hash,
+							   preset);
+		if (arg->rc)
+			return;
 	}
 
-	arg->rc = etm4_enable_hw(arg->drvdata);
+	drvdata->trcid = arg->path->trace_id;
 
-	/* The tracer didn't start */
+	/* Tracer will never be paused in sysfs mode */
+	drvdata->paused = false;
+
+	arg->rc = etm4_enable_hw(drvdata);
 	if (arg->rc) {
-		coresight_set_mode(csdev, CS_MODE_DISABLED);
+		cscfg_csdev_disable_active_config(csdev);
 		return;
 	}
 
+	drvdata->sticky_enable = true;
 	csdev->path = arg->path;
+
+	return;
 }
 
 /*
@@ -669,7 +689,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
 {
 	int ctridx;
 	int rselector;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->active_config;
 
 	/* No point in trying if we don't have at least one counter */
 	if (!drvdata->nr_cntr)
@@ -752,7 +772,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 {
 	int ret = 0;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->active_config;
 	struct perf_event_attr max_timestamp = {
 		.ATTR_CFG_FLD_timestamp_CFG = U64_MAX,
 	};
@@ -919,46 +939,36 @@ static int etm4_enable_sysfs(struct coresight_device *csdev, struct coresight_pa
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct etm4_enable_arg arg = { };
-	unsigned long cfg_hash;
-	int ret, preset;
+	int ret;
 
-	/* enable any config activated by configfs */
-	cscfg_config_sysfs_get_active_cfg(&cfg_hash, &preset);
-	if (cfg_hash) {
-		ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
-		if (ret) {
-			etm4_release_trace_id(drvdata);
-			return ret;
-		}
+	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
+		/* Someone is already using the tracer */
+		return -EBUSY;
 	}
 
-	raw_spin_lock(&drvdata->spinlock);
-
-	drvdata->trcid = path->trace_id;
-
-	/* Tracer will never be paused in sysfs mode */
-	drvdata->paused = false;
-
 	/*
 	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
 	 * ensures that register writes occur when cpu is powered.
 	 */
 	arg.drvdata = drvdata;
 	arg.path = path;
+
+	scoped_guard(raw_spinlock, &drvdata->spinlock) {
+		arg.config = drvdata->config;
+	}
+
 	ret = smp_call_function_single(drvdata->cpu,
 				       etm4_enable_sysfs_smp_call, &arg, 1);
 	if (!ret)
 		ret = arg.rc;
-	if (!ret)
-		drvdata->sticky_enable = true;
-
-	if (ret)
+	if (!ret) {
+		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
+	} else {
 		etm4_release_trace_id(drvdata);
+		/* The tracer didn't start */
+		coresight_set_mode(csdev, CS_MODE_DISABLED);
+	}
 
-	raw_spin_unlock(&drvdata->spinlock);
-
-	if (!ret)
-		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
 	return ret;
 }
 
@@ -1044,7 +1054,7 @@ static void etm4_disable_trace_unit(struct etmv4_drvdata *drvdata)
 static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
 {
 	u32 control;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->active_config;
 	struct coresight_device *csdev = drvdata->csdev;
 	struct csdev_access *csa = &csdev->access;
 	int i;
@@ -1086,8 +1096,9 @@ static void etm4_disable_sysfs_smp_call(void *info)
 
 	etm4_disable_hw(drvdata);
 
+	cscfg_csdev_disable_active_config(drvdata->csdev);
+
 	drvdata->csdev->path = NULL;
-	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
 }
 
 static int etm4_disable_perf(struct coresight_device *csdev,
@@ -1130,8 +1141,9 @@ static int etm4_disable_perf(struct coresight_device *csdev,
 static void etm4_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	raw_spin_lock(&drvdata->spinlock);
+	struct etmv4_config *config = &drvdata->config;
+	const struct etmv4_config *active_config = &drvdata->active_config;
+	int i;
 
 	/*
 	 * Executing etm4_disable_hw on the cpu whose ETM is being disabled
@@ -1140,9 +1152,17 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	smp_call_function_single(drvdata->cpu, etm4_disable_sysfs_smp_call,
 				 drvdata, 1);
 
-	raw_spin_unlock(&drvdata->spinlock);
+	/*
+	 * Userspace may read ss_status and cntr_val through sysfs after
+	 * the sysfs-session has been disabled.
+	 */
+	for (i = 0; i < drvdata->nr_ss_cmp; i++)
+		config->ss_status[i] = active_config->ss_status[i];
 
-	cscfg_csdev_disable_active_config(csdev);
+	for (i = 0; i < drvdata->nr_cntr; i++)
+		config->cntr_val[i] = active_config->cntr_val[i];
+
+	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
 
 	/*
 	 * we only release trace IDs when resetting sysfs.
@@ -1690,7 +1710,7 @@ static void etm4_set_default(struct etmv4_config *config)
 static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
 {
 	int nr_comparator, index = 0;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->active_config;
 
 	/*
 	 * nr_addr_cmp holds the number of comparator _pair_, so time 2
@@ -1731,7 +1751,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 {
 	int i, comparator, ret = 0;
 	u64 address;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->active_config;
 	struct etm_filters *filters = event->hw.addr_filters;
 
 	if (!filters)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 8d73248b840a6..f64c0acebc701 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1613,7 +1613,7 @@ static ssize_t cntr_val_store(struct device *dev,
 		return -EINVAL;
 	if (val > ETM_CNTR_MAX_VAL)
 		return -EINVAL;
-	if (coresight_get_mode(drvdata->csdev))
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
 		return -EBUSY;
 
 	raw_spin_lock(&drvdata->spinlock);
@@ -1799,7 +1799,7 @@ static ssize_t sshot_ctrl_store(struct device *dev,
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (coresight_get_mode(drvdata->csdev))
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
 		return -EBUSY;
 
 	raw_spin_lock(&drvdata->spinlock);
@@ -1851,7 +1851,7 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (coresight_get_mode(drvdata->csdev))
+	if (coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
 		return -EBUSY;
 
 	raw_spin_lock(&drvdata->spinlock);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index df9e0748d71ec..c33700711154d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1019,7 +1019,8 @@ struct etmv4_save_state {
  *		allows tracing at all ELs. We don't want to compute this
  *		at runtime, due to the additional setting of TRFCR_CX when
  *		in EL2. Otherwise, 0.
- * @config:	structure holding configuration parameters.
+ * @active_config:	structure holding current applied configuration.
+ * @config:	structure holding sysfs mode configuration.
  * @save_state:	State to be preserved across power loss
  * @skip_power_up: Indicates if an implementation can skip powering up
  *		   the trace unit.
@@ -1077,6 +1078,7 @@ struct etmv4_drvdata {
 	bool				skip_power_up : 1;
 	bool				paused : 1;
 	u64				trfcr;
+	struct etmv4_config		active_config;
 	struct etmv4_config		config;
 	struct etmv4_save_state		*save_state;
 	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);

-- 
2.43.0

