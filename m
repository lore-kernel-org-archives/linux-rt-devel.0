Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250F64BE422
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271268; cv=none; b=AVAvAEwcWc/gjUR0jgB68G+g9KmPiErO6K8Mn67WPiDfUAEqTogyOWLb1gq6342fY4rSgrFBnMmxs2j1p8+8rNsoz1HQFxc3ZJ8x4VAfSl4XWF8pjzYn4arIl/Vd6oQArQiqhenG4HLEF9LFyIKNFcZZ2CD18BfPap6UMUpIUrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271268; c=relaxed/simple;
	bh=tZl5Kxb6TJuwXVdpBw+ikrb4XluQCf0kgZPe5VVwMFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=citpUDub8fa4VKV6+6fFwmOGJB8z10ZjbcGacsrbPqqTGe445rYekxA/kuhJ6lcKW89OIL27NcMyNVbNL9qu0uXdFgyaZqPJDhi92xcVhl6tW5zC9qDF6cLsEukBIu/h5LCFCai+HoGRauFowvYcY8qu/n49lvif5MAlMRD2yVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Jyb/h10h; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Jyb/h10h"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 04C0A1E5E;
	Thu, 24 Sep 2026 10:34:21 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FD8A3F86F;
	Thu, 24 Sep 2026 10:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790271264; bh=tZl5Kxb6TJuwXVdpBw+ikrb4XluQCf0kgZPe5VVwMFs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jyb/h10hEyEg+4b3jZksj5IklsAhdcuYqTHZ2C6tnLwrzoT0n0aunXPozlHlLBFSf
	 VZHQsHTRB+/zw/2y9xh+ZzoWLbfZoa4nyku35uCAQvtkr8lXAP5k9o8FicQ3muu0y6
	 6RHAuMSDbYkZSKyMZov4y3LRvvgjEtT/FJhYxGYg=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Thu, 24 Sep 2026 18:33:42 +0100
Subject: [PATCH v12 04/14] coresight: etm4x: fix inconsistencies with sysfs
 configuration
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-separate_etm_cfg_v2-v12-4-a2b41d2f7c2b@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=17821; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=tZl5Kxb6TJuwXVdpBw+ikrb4XluQCf0kgZPe5VVwMFs=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqtV8N2vkHv8zoupCCbSSa9bwFcvJnhGtWGxqQ3
 1TrmGAY0kKJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarVfDQAKCRBt1cPRWsUx
 M3ahC/9XlfxsbUuQ6Kmbn9S/LgQLBWzRg/1w+ZEsRHbZk8FZzwZT2v3wAYhmaKYPE4DNgtjenW+
 aM4TpeoDMToeP6/dU4zqlor3zD8eO68c+3P2F3s6x3BPZWDrLTUkHVWObpFilTm8cRuSl9lLOqL
 tyH4g7UYFoXczrlZwzvCBJFAbFYqlmfX00tetSXEnQW/+PJnu6wdEoWaSTvGasdT4lwNzYghk/6
 nIHDYw/IUobH+I3TtphPF9QblSLYLUoLf5/8nKtc+VZXQOaiCbhkjMX+SqdADsCxzWoVdtGqlfQ
 k43PlrIqynFt9buJzXNB7lYAmbSEdlvXLcubz10jezJS9/IXTIfurlp+DfVf/gwVm8NhztSsiYx
 vAhcrMfI7CMKx2cWomyiF1yrJ0Ucxwmd1EjnldcIwoKI9BsWliLc8sC+BDBl/QP2lwOWeAwyONk
 3WW2V8Q4PVVMSJi0fYFVqmnkalt4qm7ZL0W9iImSTkZ1yqH/ywHvskdrgOul3n3Wr8xWo=
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

  - curr_config: the configuration applied to the current session
  - config: the configuration set via sysfs

Additionally:

  - Apply the configuration from configfs after taking the appropriate mode.

  - Since curr_config and related fields are accessed only by the local CPU
    in etm4_enable/disable_sysfs_smp_call() (similar to perf enable/disable),
    remove the lock/unlock from the sysfs enable/disable path and
    startup/dying_cpu except when to access config fields.

As the curr_config is used for cfg-configfs, etmv4 doesn't need to set
its lock for the cfg-configfs since the curr_config is proceted by cs_mode
otherwise it would make a possible cpu-stall when it get interrupt while
setting the sysfs configuration.

Therefore, set the drv_spinlock for cfg-configfs as NULL and
let the cfg-configfs disable irq without grap drv_spinlock when it is NULL.

Fixes: 54ff892b76c6 ("coresight: etm4x: splitting struct etmv4_drvdata")
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-config.c     |  18 ++--
 drivers/hwtracing/coresight/coresight-config.h     |  22 ++++
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c  |  13 ++-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 117 ++++++++++++---------
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |   5 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   4 +-
 6 files changed, 112 insertions(+), 67 deletions(-)

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
index e1a59b434505..a9f6ed47a2f5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
@@ -47,7 +47,7 @@ static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
 				   struct cscfg_regval_csdev *reg_csdev, u32 offset)
 {
 	int err = -EINVAL, idx;
-	struct etmv4_config *drvcfg = &drvdata->config;
+	struct etmv4_config *drvcfg = &drvdata->curr_config;
 	u32 off_mask;
 
 	if (((offset >= TRCEVENTCTL0R) && (offset <= TRCVIPCSSCTLR)) ||
@@ -154,11 +154,14 @@ static int etm4_cfg_load_feature(struct coresight_device *csdev,
 	int i = 0, err = 0;
 
 	/*
-	 * essential we set the device spinlock - this is used in the generic
-	 * programming routines when copying values into the drvdata structures
-	 * via the pointers setup in etm4_cfg_map_reg_offset().
+	 * drvdata structure of etm4 for configfs is curr_config and
+	 * this curr_config is protected with csdev->mode by restricting
+	 * access to curr_config after mode changed to PERF or SYSFS.
+	 *
+	 * Therefore, it doesn't need to protected with etmv4_drvdata->spinlock
+	 * to feature applying and set the NULL.
 	 */
-	feat_csdev->drv_spinlock = &drvdata->spinlock;
+	feat_csdev->drv_spinlock = NULL;
 
 	/* process the register descriptions */
 	for (i = 0; i < feat_csdev->nr_regs && !err; i++) {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 9ca03a5913a3..61e9971bdc6b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -264,10 +264,11 @@ static void etm4x_prohibit_trace(struct etmv4_drvdata *drvdata)
 static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
 {
 	u64 trfcr = drvdata->trfcr;
+	struct etmv4_config *config = &drvdata->curr_config;
 
-	if (drvdata->config.mode & ETM_MODE_EXCL_KERN)
+	if (config->mode & ETM_MODE_EXCL_KERN)
 		trfcr &= ~TRFCR_EL1_ExTRE;
-	if (drvdata->config.mode & ETM_MODE_EXCL_USER)
+	if (config->mode & ETM_MODE_EXCL_USER)
 		trfcr &= ~TRFCR_EL1_E0TRE;
 
 	return trfcr;
@@ -275,7 +276,7 @@ static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
 
 /*
  * etm4x_allow_trace - Allow CPU tracing in the respective ELs,
- * as configured by the drvdata->config.mode for the current
+ * as configured by the drvdata->curr_config.mode for the current
  * session. Even though we have TRCVICTLR bits to filter the
  * trace in the ELs, it doesn't prevent the ETM from generating
  * a packet (e.g, TraceInfo) that might contain the addresses from
@@ -286,12 +287,13 @@ static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
 static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
 {
 	u64 trfcr, guest_trfcr;
+	struct etmv4_config *config = &drvdata->curr_config;
 
 	/* If the CPU doesn't support FEAT_TRF, nothing to do */
 	if (!drvdata->trfcr)
 		return;
 
-	if (drvdata->config.mode & ETM_MODE_EXCL_HOST)
+	if (config->mode & ETM_MODE_EXCL_HOST)
 		trfcr = drvdata->trfcr & ~(TRFCR_EL1_ExTRE | TRFCR_EL1_E0TRE);
 	else
 		trfcr = etm4x_get_kern_user_filter(drvdata);
@@ -299,7 +301,7 @@ static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
 	write_trfcr(trfcr);
 
 	/* Set filters for guests and pass to KVM */
-	if (drvdata->config.mode & ETM_MODE_EXCL_GUEST)
+	if (config->mode & ETM_MODE_EXCL_GUEST)
 		guest_trfcr = drvdata->trfcr & ~(TRFCR_EL1_ExTRE | TRFCR_EL1_E0TRE);
 	else
 		guest_trfcr = etm4x_get_kern_user_filter(drvdata);
@@ -492,7 +494,7 @@ static int etm4_enable_trace_unit(struct etmv4_drvdata *drvdata)
 static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->curr_config;
 	struct coresight_device *csdev = drvdata->csdev;
 	struct device *etm_dev = &csdev->dev;
 	struct csdev_access *csa = &csdev->access;
@@ -612,27 +614,42 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
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
+
+	/* Tracer will never be paused in sysfs mode */
+	drvdata->paused = false;
 
-	/* The tracer didn't start */
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
@@ -669,7 +686,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
 {
 	int ctridx;
 	int rselector;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->curr_config;
 
 	/* No point in trying if we don't have at least one counter */
 	if (!drvdata->nr_cntr)
@@ -752,7 +769,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 {
 	int ret = 0;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->curr_config;
 	struct perf_event_attr max_timestamp = {
 		.ATTR_CFG_FLD_timestamp_CFG = U64_MAX,
 	};
@@ -919,46 +936,36 @@ static int etm4_enable_sysfs(struct coresight_device *csdev, struct coresight_pa
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
+		drvdata->curr_config = drvdata->config;
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
 
@@ -1044,7 +1051,7 @@ static void etm4_disable_trace_unit(struct etmv4_drvdata *drvdata)
 static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
 {
 	u32 control;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->curr_config;
 	struct coresight_device *csdev = drvdata->csdev;
 	struct csdev_access *csa = &csdev->access;
 	int i;
@@ -1090,8 +1097,9 @@ static void etm4_disable_sysfs_smp_call(void *info)
 
 	etm4_disable_hw(drvdata);
 
+	cscfg_csdev_disable_active_config(drvdata->csdev);
+
 	drvdata->csdev->path = NULL;
-	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
 }
 
 static int etm4_disable_perf(struct coresight_device *csdev,
@@ -1134,8 +1142,9 @@ static int etm4_disable_perf(struct coresight_device *csdev,
 static void etm4_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	raw_spin_lock(&drvdata->spinlock);
+	struct etmv4_config *config = &drvdata->config;
+	const struct etmv4_config *curr_config = &drvdata->curr_config;
+	int i;
 
 	/*
 	 * Executing etm4_disable_hw on the cpu whose ETM is being disabled
@@ -1144,9 +1153,19 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	smp_call_function_single(drvdata->cpu, etm4_disable_sysfs_smp_call,
 				 drvdata, 1);
 
-	raw_spin_unlock(&drvdata->spinlock);
+	/*
+	 * Userspace may read ss_status and cntr_val through sysfs after
+	 * the sysfs-session has been disabled.
+	 */
+	for (i = 0; i < drvdata->nr_ss_cmp; i++)
+		config->ss_status[i] = curr_config->ss_status[i];
 
-	cscfg_csdev_disable_active_config(csdev);
+	for (i = 0; i < drvdata->nr_cntr; i++)
+		config->cntr_val[i] = curr_config->cntr_val[i];
+
+	config->seq_state = curr_config->seq_state;
+
+	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
 
 	/*
 	 * we only release trace IDs when resetting sysfs.
@@ -1694,7 +1713,7 @@ static void etm4_set_default(struct etmv4_config *config)
 static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
 {
 	int nr_comparator, index = 0;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->curr_config;
 
 	/*
 	 * nr_addr_cmp holds the number of comparator _pair_, so time 2
@@ -1735,7 +1754,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 {
 	int i, comparator, ret = 0;
 	u64 address;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *config = &drvdata->curr_config;
 	struct etm_filters *filters = event->hw.addr_filters;
 
 	if (!filters)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a547de5a3f9c..9c237507ac30 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1437,7 +1437,8 @@ static ssize_t seq_state_store(struct device *dev,
 		return -EINVAL;
 	if (val >= drvdata->nrseqstate)
 		return -EINVAL;
-	if (IS_ERR_OR_NULL(drvdata) || coresight_get_mode(drvdata->csdev))
+	if (IS_ERR_OR_NULL(drvdata) ||
+	    coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
 		return -EBUSY;
 
 	config->seq_state = val;
@@ -1616,7 +1617,7 @@ static ssize_t cntr_val_store(struct device *dev,
 	if (val > ETM_CNTR_MAX_VAL)
 		return -EINVAL;
 	if (IS_ERR_OR_NULL(drvdata->csdev) ||
-	    coresight_get_mode(drvdata->csdev))
+	    coresight_get_mode(drvdata->csdev) == CS_MODE_SYSFS)
 		return -EBUSY;
 
 	raw_spin_lock(&drvdata->spinlock);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index df9e0748d71e..52f66e26ceaa 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1019,7 +1019,8 @@ struct etmv4_save_state {
  *		allows tracing at all ELs. We don't want to compute this
  *		at runtime, due to the additional setting of TRFCR_CX when
  *		in EL2. Otherwise, 0.
- * @config:	structure holding configuration parameters.
+ * @curr_config:	structure holding current applied configuration.
+ * @config:	structure holding sysfs mode configuration.
  * @save_state:	State to be preserved across power loss
  * @skip_power_up: Indicates if an implementation can skip powering up
  *		   the trace unit.
@@ -1077,6 +1078,7 @@ struct etmv4_drvdata {
 	bool				skip_power_up : 1;
 	bool				paused : 1;
 	u64				trfcr;
+	struct etmv4_config		curr_config;
 	struct etmv4_config		config;
 	struct etmv4_save_state		*save_state;
 	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);

-- 
2.43.0

