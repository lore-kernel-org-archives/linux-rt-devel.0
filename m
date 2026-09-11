Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1F031618B
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 10:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124180; cv=none; b=PX8sQtOoVUY+6JdTe73OpU5ZM78hHxVKW5F4oZAVxmv4/Vs5YXPgO/MeOfA7NY1Ya12NQ+io5qT82wxeuCn78+pfkHt6PLBvw7/Y65i7Sm5EBz1FBjPp6QsTLYp0B/7DFIATt0OtovXXKeqYT2HIOdEG1Dxl4lqoFn9TdiuBuS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124180; c=relaxed/simple;
	bh=dl0nX8oIRqlZdZr04w3T1fk5szxy2jcYwKPxeYOBvQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nCabVWhibPkBnYNYRzYuSn/wgHzkmUzZ9q9FJfA8Jh44ZXP155V5fC5hu4lqo7gTDR3jigVssF7F2+lEMDVPa6Ii15tQkPZ8cqZwgxFfENPDZ0fvo+skbGyFbNv1i0dvN0xGlZKiC90jHArdQEtP73RItBLZeeKdSdJ+CXhq9ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Fd0oBzw6; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Fd0oBzw6"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8308916F2;
	Fri, 11 Sep 2026 03:56:13 -0700 (PDT)
Received: from e129823.arm.com (unknown [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 04DAD3F7B4;
	Fri, 11 Sep 2026 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789124177; bh=dl0nX8oIRqlZdZr04w3T1fk5szxy2jcYwKPxeYOBvQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fd0oBzw6Q718cwYyvxE76I2+jJOkpzCGrNlm1d9KnCaVRGWfMhs4+Z1AxFWVPpFFl
	 VSCPpauzA7uBG6waSFTNb9yBMTiCENn/rasoVZiTCBshaIBJ5DOhUrs1XiE0BvaoCQ
	 +jGSA5HYTBH6iEMYLRG6D75E5Snk5LeZA7W2v+aE=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 11 Sep 2026 11:56:00 +0100
Subject: [PATCH v10 1/8] coresight: etm4x: fix inconsistencies with sysfs
 configuration
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-separate_etm_cfg_v2-v10-1-1b715d95927a@arm.com>
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
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=16444; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=dl0nX8oIRqlZdZr04w3T1fk5szxy2jcYwKPxeYOBvQw=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqo95In/1KM/KGAoAzOSj7DPqzjydqx5T8qZFVZ
 VtYp0/mFaWJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqPeSAAKCRBt1cPRWsUx
 MxUiDACZbjTL+goSwqfy5gCygUzc91zmLWmBbdN08Y2dGztjaTgnl+gTgJY6nSrpMk5W22FKExa
 xEu9b+JnWR9nio9snR/ajexuFJjBjADwD93op5Qw7fbr9D23ASVDBKnI1qs/yeVoJGZ/HrJSlJS
 ynj5PEc+nwKv4qzevELB1CBWX6xRAkEBfmutxTqIFCC7KAZsy/vrluOqo8AAzRJPtNazLXI+s2o
 TFkbPQOMWHK6vmj/wY22RJugCvn0p/VQf3PjlHQR+zg7qRbiiYiJlTLfeQ7JM5yMNbG9J3F1BFe
 PU2hlqtoo8oqXXWYvhv8OFWr6QTyg9KFkJSUIOb0HLnxk3JAFTBOECHphhwVKwq31X7u23Nhv66
 qf+SIhy5F6QWz7AmyB+RSx5Doje3e7rB6JOfVGyavDmI8gd5SumumigMToGLJit8TEF04nE/ObH
 pDNghpZDm95q+ZeouBI+qomG1NJMqor7yJI1dACTgWuGVo7OHG05zzT3dg/hqLAjRYFx8=
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
 drivers/hwtracing/coresight/coresight-config.h     |  22 +++++
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c  |  13 ++-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 103 +++++++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.h      |   4 +-
 5 files changed, 96 insertions(+), 64 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-config.c b/drivers/hwtracing/coresight/coresight-config.c
index 4f72ae71b696..0e296289f286 100644
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
index 90fd937d3bd8..ae6295e30813 100644
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
index e1a59b434505..d24f533c623d 100644
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
index 2247ad55d444..02b91a67b00b 100644
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
@@ -612,27 +615,52 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
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
+	drvdata = arg->drvdata;
+	csdev = drvdata->csdev;
 	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
 		/* Someone is already using the tracer */
 		arg->rc = -EBUSY;
 		return;
 	}
 
-	arg->rc = etm4_enable_hw(arg->drvdata);
+	drvdata->active_config = arg->config;
 
-	/* The tracer didn't start */
+	/* enable any config activated by configfs */
+	cscfg_config_sysfs_get_active_cfg(&cfg_hash, &preset);
+	if (cfg_hash) {
+		arg->rc = cscfg_csdev_enable_active_config(csdev,
+							   cfg_hash,
+							   preset);
+		if (arg->rc)
+			goto err;
+	}
+
+	drvdata->trcid = arg->path->trace_id;
+
+	/* Tracer will never be paused in sysfs mode */
+	drvdata->paused = false;
+
+	arg->rc = etm4_enable_hw(drvdata);
 	if (arg->rc) {
-		coresight_set_mode(csdev, CS_MODE_DISABLED);
-		return;
+		cscfg_csdev_disable_active_config(csdev);
+		goto err;
 	}
 
+	drvdata->sticky_enable = true;
 	csdev->path = arg->path;
+
+	return;
+err:
+	/* The tracer didn't start */
+	coresight_set_mode(csdev, CS_MODE_DISABLED);
 }
 
 /*
@@ -669,7 +697,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
 {
 	int ctridx;
 	int rselector;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->active_config;
 
 	/* No point in trying if we don't have at least one counter */
 	if (!drvdata->nr_cntr)
@@ -752,7 +780,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 {
 	int ret = 0;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->active_config;
 	struct perf_event_attr max_timestamp = {
 		.ATTR_CFG_FLD_timestamp_CFG = U64_MAX,
 	};
@@ -919,25 +947,7 @@ static int etm4_enable_sysfs(struct coresight_device *csdev, struct coresight_pa
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct etm4_enable_arg arg = { };
-	unsigned long cfg_hash;
-	int ret, preset;
-
-	/* enable any config activated by configfs */
-	cscfg_config_sysfs_get_active_cfg(&cfg_hash, &preset);
-	if (cfg_hash) {
-		ret = cscfg_csdev_enable_active_config(csdev, cfg_hash, preset);
-		if (ret) {
-			etm4_release_trace_id(drvdata);
-			return ret;
-		}
-	}
-
-	raw_spin_lock(&drvdata->spinlock);
-
-	drvdata->trcid = path->trace_id;
-
-	/* Tracer will never be paused in sysfs mode */
-	drvdata->paused = false;
+	int ret;
 
 	/*
 	 * Executing etm4_enable_hw on the cpu whose ETM is being enabled
@@ -945,20 +955,20 @@ static int etm4_enable_sysfs(struct coresight_device *csdev, struct coresight_pa
 	 */
 	arg.drvdata = drvdata;
 	arg.path = path;
+
+	raw_spin_lock(&drvdata->spinlock);
+	arg.config = drvdata->config;
+	raw_spin_unlock(&drvdata->spinlock);
+
 	ret = smp_call_function_single(drvdata->cpu,
 				       etm4_enable_sysfs_smp_call, &arg, 1);
 	if (!ret)
 		ret = arg.rc;
 	if (!ret)
-		drvdata->sticky_enable = true;
-
-	if (ret)
+		dev_dbg(&csdev->dev, "ETM tracing enabled\n");
+	else
 		etm4_release_trace_id(drvdata);
 
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
@@ -1086,7 +1096,10 @@ static void etm4_disable_sysfs_smp_call(void *info)
 
 	etm4_disable_hw(drvdata);
 
+	cscfg_csdev_disable_active_config(drvdata->csdev);
+
 	drvdata->csdev->path = NULL;
+
 	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
 }
 
@@ -1131,8 +1144,6 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	raw_spin_lock(&drvdata->spinlock);
-
 	/*
 	 * Executing etm4_disable_hw on the cpu whose ETM is being disabled
 	 * ensures that register writes occur when cpu is powered.
@@ -1140,10 +1151,6 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	smp_call_function_single(drvdata->cpu, etm4_disable_sysfs_smp_call,
 				 drvdata, 1);
 
-	raw_spin_unlock(&drvdata->spinlock);
-
-	cscfg_csdev_disable_active_config(csdev);
-
 	/*
 	 * we only release trace IDs when resetting sysfs.
 	 * This permits sysfs users to read the trace ID after the trace
@@ -1690,7 +1697,7 @@ static void etm4_set_default(struct etmv4_config *config)
 static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
 {
 	int nr_comparator, index = 0;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->active_config;
 
 	/*
 	 * nr_addr_cmp holds the number of comparator _pair_, so time 2
@@ -1731,7 +1738,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 {
 	int i, comparator, ret = 0;
 	u64 address;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->active_config;
 	struct etm_filters *filters = event->hw.addr_filters;
 
 	if (!filters)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index df9e0748d71e..c33700711154 100644
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

