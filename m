Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E7A389452
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 02:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995985; cv=none; b=Wn9ef2X15rcooTDU8EX7/qHO6KNUSSVvMi61mdYbo7BGbUkr5th+3XsLL7NGL29U5MVTRuo+zSkPpC8lTNvT29MRjzNNpDdhLgrg3F2cx0QO4Ui7QenwljriYrEHjqZn/rLF2tST6sT6ai2kAwe77eUO3/DsfdMjwnaWAN67XbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995985; c=relaxed/simple;
	bh=O/HBovHvdjKFaZHIZVeYPyIo1HLwu1ePYnQOEHMf0nw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WqupoNlBxDxbj3rS0O3OQ32AU/q56AVBKLh4qo6SDSUwkdz+P2rLEYPvdxtDftMKZAREqCBdMIEe8v6Mbz4Xc2jEV7p7kke8ka9d3eBc2MxeyaDRthcilRd0GF6pjnT5w1KoLnqPOpTO9hgtKuRt39D5B8lTvOjAtF8WFxuaFUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VBP/InV9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VBP/InV9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 841882F;
	Fri,  2 Oct 2026 19:52:55 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D342E3F763;
	Fri,  2 Oct 2026 19:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790995978; bh=O/HBovHvdjKFaZHIZVeYPyIo1HLwu1ePYnQOEHMf0nw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VBP/InV9XYu/oykb3RPLooID0FBYwMr8IXXsY44Ub+c3qLccibfNpQF/spj3b+tlM
	 wfR9BBmx6/6UhfjjCVu/Zf49L8bb9V2FwZRqzA3nMhbSzhLQ8wuUV4E0gnQDn2mZdj
	 MnEbXTT/PIxYZ3ykbR3hyZSnI2o+WTYUnpyir6UE=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Sat, 03 Oct 2026 03:52:23 +0100
Subject: [PATCH RESEND v13 11/14] coresight: etm4x: rename drvdata->config
 to sysfs_config
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-separate_etm_cfg_v2-v13-11-5d8a29aead95@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=79336; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=O/HBovHvdjKFaZHIZVeYPyIo1HLwu1ePYnQOEHMf0nw=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqwG3r2dd/2ebFLU4P8KDIqim66KKYJxwRzzPMn
 6h7P90TW4iJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCasBt6wAKCRBt1cPRWsUx
 M/WbC/4uIJGJTSDSi/ms++7D5GIx2VsklTCrItvukb42G9J/Zi1X5tRWU3X/JfCYhptTkcjM91I
 kxpkhc2cG9jJ/r+Lr0pP6w1UHKBuSui2IZjLsbtAMHfw6Jj3/MGAzj++BLO3N0oyTMmRLTopkrr
 mCHzCjjkSwssVkPiDosi6Xaf65p8raqdw7UrnsMsnv8bKvdo6xm4XIWyP2tsbwXbNys53vxvzYs
 78OiCsQIdfqP7xDdSKKYFxh593hBj5Z0NKeWTmf8dzDO8y/H76TeFUosJ7Z3tqK3tgTWWG+uI72
 oYQwK30C2So04fJIPIY9PDYOFMjKhx2GM6v517iq6/creQ68KwYzB8fmX9OyeNwJOo+nX4p3CT1
 Z2h/nH+98oh25urKY0xho+RDhn/t4UrBxpfnffVl8DqSzQ3Wo7hw5LMUm0aplJbr8PC1z6U0lVx
 RGe/eJL+pUqBnyquQUNascCrLX/OiEwNV3gA0Lgbg7gWXlujVF6xerZJPvYG5Rj/btIac=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

drvdata->config is used only by the sysfs interface.
Rename it to sysfs_config to clarify its purpose.

For readability, also rename local config variables to sysfs_config
where they refer to drvdata->sysfs_config.

Reviewed-by: Mike Leach <mike.leach@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  10 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 775 +++++++++++----------
 drivers/hwtracing/coresight/coresight-etm4x.h      |   4 +-
 3 files changed, 395 insertions(+), 394 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 5db11309bfbb..2a4751a75382 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -960,7 +960,7 @@ static int etm4_enable_sysfs(struct coresight_device *csdev, struct coresight_pa
 	arg.path = path;
 
 	scoped_guard(raw_spinlock, &drvdata->spinlock) {
-		drvdata->curr_config = drvdata->config;
+		drvdata->curr_config = drvdata->sysfs_config;
 	}
 
 	ret = smp_call_function_single(drvdata->cpu,
@@ -1153,7 +1153,7 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 	const struct etmv4_config *curr_config = &drvdata->curr_config;
 	int i;
 
@@ -1169,9 +1169,9 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	 * the sysfs-session has been disabled.
 	 */
 	for (i = 0; i < caps->nr_cntr; i++)
-		config->cntr_val[i] = curr_config->cntr_val[i];
+		sysfs_config->cntr_val[i] = curr_config->cntr_val[i];
 
-	config->seq_state = curr_config->seq_state;
+	sysfs_config->seq_state = curr_config->seq_state;
 
 	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
 
@@ -2214,7 +2214,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 	if (!desc.name)
 		return -ENOMEM;
 
-	etm4_set_default(&drvdata->config, caps);
+	etm4_set_default(&drvdata->sysfs_config, caps);
 
 	if (etm4x_always_pm_save(dev, init_arg->csa))
 		pm_save = true;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index aa3deb15ba96..db9e603f97ba 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -16,15 +16,15 @@
 static int etm4_set_mode_exclude(struct etmv4_drvdata *drvdata, bool exclude)
 {
 	u8 idx;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 
 	/*
 	 * TRCACATRn.TYPE bit[1:0]: type of comparison
 	 * the trace unit performs
 	 */
-	if (FIELD_GET(TRCACATRn_TYPE_MASK, config->addr_acc[idx]) == TRCACATRn_TYPE_ADDR) {
+	if (FIELD_GET(TRCACATRn_TYPE_MASK, sysfs_config->addr_acc[idx]) == TRCACATRn_TYPE_ADDR) {
 		if (idx % 2 != 0)
 			return -EINVAL;
 
@@ -33,8 +33,8 @@ static int etm4_set_mode_exclude(struct etmv4_drvdata *drvdata, bool exclude)
 		 * relevant bit of ViewInst Include/Exclude Control register
 		 * for corresponding address comparator pair.
 		 */
-		if (config->addr_type[idx] != ETM_ADDR_TYPE_RANGE ||
-		    config->addr_type[idx + 1] != ETM_ADDR_TYPE_RANGE)
+		if (sysfs_config->addr_type[idx] != ETM_ADDR_TYPE_RANGE ||
+		    sysfs_config->addr_type[idx + 1] != ETM_ADDR_TYPE_RANGE)
 			return -EINVAL;
 
 		if (exclude == true) {
@@ -42,15 +42,15 @@ static int etm4_set_mode_exclude(struct etmv4_drvdata *drvdata, bool exclude)
 			 * Set exclude bit and unset the include bit
 			 * corresponding to comparator pair
 			 */
-			config->viiectlr |= BIT(idx / 2 + 16);
-			config->viiectlr &= ~BIT(idx / 2);
+			sysfs_config->viiectlr |= BIT(idx / 2 + 16);
+			sysfs_config->viiectlr &= ~BIT(idx / 2);
 		} else {
 			/*
 			 * Set include bit and unset exclude bit
 			 * corresponding to comparator pair
 			 */
-			config->viiectlr |= BIT(idx / 2);
-			config->viiectlr &= ~BIT(idx / 2 + 16);
+			sysfs_config->viiectlr |= BIT(idx / 2);
+			sysfs_config->viiectlr &= ~BIT(idx / 2 + 16);
 		}
 	}
 	return 0;
@@ -181,102 +181,102 @@ static ssize_t reset_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
 	if (val)
-		config->mode = 0x0;
+		sysfs_config->mode = 0x0;
 
 	/* Disable data tracing: do not trace load and store data transfers */
-	config->mode &= ~(ETM_MODE_LOAD | ETM_MODE_STORE);
-	config->cfg &= ~(TRCCONFIGR_INSTP0_LOAD | TRCCONFIGR_INSTP0_STORE);
+	sysfs_config->mode &= ~(ETM_MODE_LOAD | ETM_MODE_STORE);
+	sysfs_config->cfg &= ~(TRCCONFIGR_INSTP0_LOAD | TRCCONFIGR_INSTP0_STORE);
 
 	/* Disable data value and data address tracing */
-	config->mode &= ~(ETM_MODE_DATA_TRACE_ADDR |
+	sysfs_config->mode &= ~(ETM_MODE_DATA_TRACE_ADDR |
 			   ETM_MODE_DATA_TRACE_VAL);
-	config->cfg &= ~(TRCCONFIGR_DA | TRCCONFIGR_DV);
+	sysfs_config->cfg &= ~(TRCCONFIGR_DA | TRCCONFIGR_DV);
 
 	/* Disable all events tracing */
-	config->eventctrl0 = 0x0;
-	config->eventctrl1 = 0x0;
+	sysfs_config->eventctrl0 = 0x0;
+	sysfs_config->eventctrl1 = 0x0;
 
 	/* Disable timestamp event */
-	config->ts_ctrl = 0x0;
+	sysfs_config->ts_ctrl = 0x0;
 
 	/* Disable stalling */
-	config->stall_ctrl = 0x0;
+	sysfs_config->stall_ctrl = 0x0;
 
 	/* Reset trace synchronization period  to 2^8 = 256 bytes*/
 	if (!caps->syncpr)
-		config->syncfreq = 0x8;
+		sysfs_config->syncfreq = 0x8;
 
 	/*
 	 * Enable ViewInst to trace everything with start-stop logic in
 	 * started state. ARM recommends start-stop logic is set before
 	 * each trace run.
 	 */
-	config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
+	sysfs_config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
 	if (caps->nr_addr_cmp > 0) {
-		config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
+		sysfs_config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
 		/* SSSTATUS, bit[9] */
-		config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
+		sysfs_config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
 	}
 
 	/* No address range filtering for ViewInst */
-	config->viiectlr = 0x0;
+	sysfs_config->viiectlr = 0x0;
 
 	/* No start-stop filtering for ViewInst */
-	config->vissctlr = 0x0;
-	config->vipcssctlr = 0x0;
+	sysfs_config->vissctlr = 0x0;
+	sysfs_config->vipcssctlr = 0x0;
 
 	/* Disable seq events */
 	for (i = 0; i < caps->nr_seq_ctrls; i++)
-		config->seq_ctrl[i] = 0x0;
-	config->seq_rst = 0x0;
-	config->seq_state = 0x0;
+		sysfs_config->seq_ctrl[i] = 0x0;
+	sysfs_config->seq_rst = 0x0;
+	sysfs_config->seq_state = 0x0;
 
 	/* Disable external input events */
-	config->ext_inp = 0x0;
+	sysfs_config->ext_inp = 0x0;
 
-	config->cntr_idx = 0x0;
+	sysfs_config->cntr_idx = 0x0;
 	for (i = 0; i < caps->nr_cntr; i++) {
-		config->cntrldvr[i] = 0x0;
-		config->cntr_ctrl[i] = 0x0;
-		config->cntr_val[i] = 0x0;
+		sysfs_config->cntrldvr[i] = 0x0;
+		sysfs_config->cntr_ctrl[i] = 0x0;
+		sysfs_config->cntr_val[i] = 0x0;
 	}
 
-	config->res_idx = 0x0;
+	sysfs_config->res_idx = 0x0;
 	for (i = 2; i < 2 * caps->nr_resource; i++)
-		config->res_ctrl[i] = 0x0;
+		sysfs_config->res_ctrl[i] = 0x0;
 
-	config->ss_idx = 0x0;
+	sysfs_config->ss_idx = 0x0;
 	for (i = 0; i < caps->nr_ss_cmp; i++) {
-		config->ss_ctrl[i] = 0x0;
-		config->ss_pe_cmp[i] = 0x0;
+		sysfs_config->ss_ctrl[i] = 0x0;
+		sysfs_config->ss_pe_cmp[i] = 0x0;
 	}
 
-	config->addr_idx = 0x0;
+	sysfs_config->addr_idx = 0x0;
 	for (i = 0; i < caps->nr_addr_cmp * 2; i++) {
-		config->addr_val[i] = 0x0;
-		config->addr_acc[i] = 0x0;
-		config->addr_type[i] = ETM_ADDR_TYPE_NONE;
+		sysfs_config->addr_val[i] = 0x0;
+		sysfs_config->addr_acc[i] = 0x0;
+		sysfs_config->addr_type[i] = ETM_ADDR_TYPE_NONE;
 	}
 
-	config->ctxid_idx = 0x0;
+	sysfs_config->ctxid_idx = 0x0;
 	for (i = 0; i < caps->numcidc; i++)
-		config->ctxid_pid[i] = 0x0;
+		sysfs_config->ctxid_pid[i] = 0x0;
 
-	config->ctxid_mask0 = 0x0;
-	config->ctxid_mask1 = 0x0;
+	sysfs_config->ctxid_mask0 = 0x0;
+	sysfs_config->ctxid_mask1 = 0x0;
 
-	config->vmid_idx = 0x0;
+	sysfs_config->vmid_idx = 0x0;
 	for (i = 0; i < caps->numvmidc; i++)
-		config->vmid_val[i] = 0x0;
-	config->vmid_mask0 = 0x0;
-	config->vmid_mask1 = 0x0;
+		sysfs_config->vmid_val[i] = 0x0;
+	sysfs_config->vmid_mask0 = 0x0;
+	sysfs_config->vmid_mask1 = 0x0;
 
 	raw_spin_unlock(&drvdata->spinlock);
 
@@ -295,9 +295,9 @@ static ssize_t mode_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->mode;
+	val = sysfs_config->mode;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -308,142 +308,142 @@ static ssize_t mode_store(struct device *dev,
 	unsigned long val, mode;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	config->mode = val & ETMv4_MODE_ALL;
+	sysfs_config->mode = val & ETMv4_MODE_ALL;
 
 	if (caps->instrp0) {
 		/* start by clearing instruction P0 field */
-		config->cfg  &= ~TRCCONFIGR_INSTP0_LOAD_STORE;
-		if (config->mode & ETM_MODE_LOAD)
+		sysfs_config->cfg  &= ~TRCCONFIGR_INSTP0_LOAD_STORE;
+		if (sysfs_config->mode & ETM_MODE_LOAD)
 			/* 0b01 Trace load instructions as P0 instructions */
-			config->cfg  |= TRCCONFIGR_INSTP0_LOAD;
-		if (config->mode & ETM_MODE_STORE)
+			sysfs_config->cfg  |= TRCCONFIGR_INSTP0_LOAD;
+		if (sysfs_config->mode & ETM_MODE_STORE)
 			/* 0b10 Trace store instructions as P0 instructions */
-			config->cfg  |= TRCCONFIGR_INSTP0_STORE;
-		if (config->mode & ETM_MODE_LOAD_STORE)
+			sysfs_config->cfg  |= TRCCONFIGR_INSTP0_STORE;
+		if (sysfs_config->mode & ETM_MODE_LOAD_STORE)
 			/*
 			 * 0b11 Trace load and store instructions
 			 * as P0 instructions
 			 */
-			config->cfg  |= TRCCONFIGR_INSTP0_LOAD_STORE;
+			sysfs_config->cfg  |= TRCCONFIGR_INSTP0_LOAD_STORE;
 	}
 
 	/* bit[3], Branch broadcast mode */
-	if ((config->mode & ETM_MODE_BB) && (caps->trcbb))
-		config->cfg |= TRCCONFIGR_BB;
+	if ((sysfs_config->mode & ETM_MODE_BB) && (caps->trcbb))
+		sysfs_config->cfg |= TRCCONFIGR_BB;
 	else
-		config->cfg &= ~TRCCONFIGR_BB;
+		sysfs_config->cfg &= ~TRCCONFIGR_BB;
 
 	/* bit[4], Cycle counting instruction trace bit */
-	if ((config->mode & ETMv4_MODE_CYCACC) &&
+	if ((sysfs_config->mode & ETMv4_MODE_CYCACC) &&
 		(caps->trccci == true))
-		config->cfg |= TRCCONFIGR_CCI;
+		sysfs_config->cfg |= TRCCONFIGR_CCI;
 	else
-		config->cfg &= ~TRCCONFIGR_CCI;
+		sysfs_config->cfg &= ~TRCCONFIGR_CCI;
 
 	/* bit[6], Context ID tracing bit */
-	if ((config->mode & ETMv4_MODE_CTXID) && (caps->ctxid_size))
-		config->cfg |= TRCCONFIGR_CID;
+	if ((sysfs_config->mode & ETMv4_MODE_CTXID) && (caps->ctxid_size))
+		sysfs_config->cfg |= TRCCONFIGR_CID;
 	else
-		config->cfg &= ~TRCCONFIGR_CID;
+		sysfs_config->cfg &= ~TRCCONFIGR_CID;
 
-	if ((config->mode & ETM_MODE_VMID) && (caps->vmid_size))
-		config->cfg |= TRCCONFIGR_VMID;
+	if ((sysfs_config->mode & ETM_MODE_VMID) && (caps->vmid_size))
+		sysfs_config->cfg |= TRCCONFIGR_VMID;
 	else
-		config->cfg &= ~TRCCONFIGR_VMID;
+		sysfs_config->cfg &= ~TRCCONFIGR_VMID;
 
 	/* bits[10:8], Conditional instruction tracing bit */
-	mode = ETM_MODE_COND(config->mode);
+	mode = ETM_MODE_COND(sysfs_config->mode);
 	if (caps->trccond) {
-		config->cfg &= ~TRCCONFIGR_COND_MASK;
-		config->cfg |= mode << __bf_shf(TRCCONFIGR_COND_MASK);
+		sysfs_config->cfg &= ~TRCCONFIGR_COND_MASK;
+		sysfs_config->cfg |= mode << __bf_shf(TRCCONFIGR_COND_MASK);
 	}
 
 	/* bit[11], Global timestamp tracing bit */
-	if ((config->mode & ETMv4_MODE_TIMESTAMP) && (caps->ts_size))
-		config->cfg |= TRCCONFIGR_TS;
+	if ((sysfs_config->mode & ETMv4_MODE_TIMESTAMP) && (caps->ts_size))
+		sysfs_config->cfg |= TRCCONFIGR_TS;
 	else
-		config->cfg &= ~TRCCONFIGR_TS;
+		sysfs_config->cfg &= ~TRCCONFIGR_TS;
 
 	/* bit[12], Return stack enable bit */
-	if ((config->mode & ETM_MODE_RETURNSTACK) && (caps->retstack))
-		config->cfg |= TRCCONFIGR_RS;
+	if ((sysfs_config->mode & ETM_MODE_RETURNSTACK) && (caps->retstack))
+		sysfs_config->cfg |= TRCCONFIGR_RS;
 	else
-		config->cfg &= ~TRCCONFIGR_RS;
+		sysfs_config->cfg &= ~TRCCONFIGR_RS;
 
 	/* bits[14:13], Q element enable field */
-	mode = ETM_MODE_QELEM(config->mode);
+	mode = ETM_MODE_QELEM(sysfs_config->mode);
 	/* start by clearing QE bits */
-	config->cfg &= ~(TRCCONFIGR_QE_W_COUNTS | TRCCONFIGR_QE_WO_COUNTS);
+	sysfs_config->cfg &= ~(TRCCONFIGR_QE_W_COUNTS | TRCCONFIGR_QE_WO_COUNTS);
 	/*
 	 * if supported, Q elements with instruction counts are enabled.
 	 * Always set the low bit for any requested mode. Valid combos are
 	 * 0b00, 0b01 and 0b11.
 	 */
 	if (mode && caps->q_support)
-		config->cfg |= TRCCONFIGR_QE_W_COUNTS;
+		sysfs_config->cfg |= TRCCONFIGR_QE_W_COUNTS;
 	/*
 	 * if supported, Q elements with and without instruction
 	 * counts are enabled
 	 */
 	if ((mode & BIT(1)) && (caps->q_support & BIT(1)))
-		config->cfg |= TRCCONFIGR_QE_WO_COUNTS;
+		sysfs_config->cfg |= TRCCONFIGR_QE_WO_COUNTS;
 
 	/* bit[11], AMBA Trace Bus (ATB) trigger enable bit */
-	if ((config->mode & ETM_MODE_ATB_TRIGGER) && (caps->atbtrig))
-		config->eventctrl1 |= TRCEVENTCTL1R_ATB;
+	if ((sysfs_config->mode & ETM_MODE_ATB_TRIGGER) && (caps->atbtrig))
+		sysfs_config->eventctrl1 |= TRCEVENTCTL1R_ATB;
 	else
-		config->eventctrl1 &= ~TRCEVENTCTL1R_ATB;
+		sysfs_config->eventctrl1 &= ~TRCEVENTCTL1R_ATB;
 
 	/* bit[12], Low-power state behavior override bit */
-	if ((config->mode & ETM_MODE_LPOVERRIDE) && (caps->lpoverride))
-		config->eventctrl1 |= TRCEVENTCTL1R_LPOVERRIDE;
+	if ((sysfs_config->mode & ETM_MODE_LPOVERRIDE) && (caps->lpoverride))
+		sysfs_config->eventctrl1 |= TRCEVENTCTL1R_LPOVERRIDE;
 	else
-		config->eventctrl1 &= ~TRCEVENTCTL1R_LPOVERRIDE;
+		sysfs_config->eventctrl1 &= ~TRCEVENTCTL1R_LPOVERRIDE;
 
 	/* bit[8], Instruction stall bit */
-	if ((config->mode & ETM_MODE_ISTALL_EN) && (caps->stallctl))
-		config->stall_ctrl |= TRCSTALLCTLR_ISTALL;
+	if ((sysfs_config->mode & ETM_MODE_ISTALL_EN) && (caps->stallctl))
+		sysfs_config->stall_ctrl |= TRCSTALLCTLR_ISTALL;
 	else
-		config->stall_ctrl &= ~TRCSTALLCTLR_ISTALL;
+		sysfs_config->stall_ctrl &= ~TRCSTALLCTLR_ISTALL;
 
 	/* bit[10], Prioritize instruction trace bit */
-	if (config->mode & ETM_MODE_INSTPRIO)
-		config->stall_ctrl |= TRCSTALLCTLR_INSTPRIORITY;
+	if (sysfs_config->mode & ETM_MODE_INSTPRIO)
+		sysfs_config->stall_ctrl |= TRCSTALLCTLR_INSTPRIORITY;
 	else
-		config->stall_ctrl &= ~TRCSTALLCTLR_INSTPRIORITY;
+		sysfs_config->stall_ctrl &= ~TRCSTALLCTLR_INSTPRIORITY;
 
 	/* bit[13], Trace overflow prevention bit */
-	if ((config->mode & ETM_MODE_NOOVERFLOW) && (caps->nooverflow))
-		config->stall_ctrl |= TRCSTALLCTLR_NOOVERFLOW;
+	if ((sysfs_config->mode & ETM_MODE_NOOVERFLOW) && (caps->nooverflow))
+		sysfs_config->stall_ctrl |= TRCSTALLCTLR_NOOVERFLOW;
 	else
-		config->stall_ctrl &= ~TRCSTALLCTLR_NOOVERFLOW;
+		sysfs_config->stall_ctrl &= ~TRCSTALLCTLR_NOOVERFLOW;
 
 	/* bit[9] Start/stop logic control bit */
-	if (config->mode & ETM_MODE_VIEWINST_STARTSTOP)
-		config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
+	if (sysfs_config->mode & ETM_MODE_VIEWINST_STARTSTOP)
+		sysfs_config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
 	else
-		config->vinst_ctrl &= ~TRCVICTLR_SSSTATUS;
+		sysfs_config->vinst_ctrl &= ~TRCVICTLR_SSSTATUS;
 
 	/* bit[10], Whether a trace unit must trace a Reset exception */
-	if (config->mode & ETM_MODE_TRACE_RESET)
-		config->vinst_ctrl |= TRCVICTLR_TRCRESET;
+	if (sysfs_config->mode & ETM_MODE_TRACE_RESET)
+		sysfs_config->vinst_ctrl |= TRCVICTLR_TRCRESET;
 	else
-		config->vinst_ctrl &= ~TRCVICTLR_TRCRESET;
+		sysfs_config->vinst_ctrl &= ~TRCVICTLR_TRCRESET;
 
 	/* bit[11], Whether a trace unit must trace a system error exception */
-	if ((config->mode & ETM_MODE_TRACE_ERR) && (caps->trc_error))
-		config->vinst_ctrl |= TRCVICTLR_TRCERR;
+	if ((sysfs_config->mode & ETM_MODE_TRACE_ERR) && (caps->trc_error))
+		sysfs_config->vinst_ctrl |= TRCVICTLR_TRCERR;
 	else
-		config->vinst_ctrl &= ~TRCVICTLR_TRCERR;
+		sysfs_config->vinst_ctrl &= ~TRCVICTLR_TRCERR;
 
-	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
-		etm4_config_trace_mode(config, caps);
+	if (sysfs_config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
+		etm4_config_trace_mode(sysfs_config, caps);
 
 	raw_spin_unlock(&drvdata->spinlock);
 
@@ -457,9 +457,9 @@ static ssize_t pe_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->pe_sel;
+	val = sysfs_config->pe_sel;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -470,7 +470,7 @@ static ssize_t pe_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -481,7 +481,7 @@ static ssize_t pe_store(struct device *dev,
 		return -EINVAL;
 	}
 
-	config->pe_sel = val;
+	sysfs_config->pe_sel = val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -493,9 +493,9 @@ static ssize_t event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->eventctrl0;
+	val = sysfs_config->eventctrl0;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -506,7 +506,7 @@ static ssize_t event_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -515,19 +515,19 @@ static ssize_t event_store(struct device *dev,
 	switch (caps->nr_event) {
 	case 0x0:
 		/* EVENT0, bits[7:0] */
-		config->eventctrl0 = val & 0xFF;
+		sysfs_config->eventctrl0 = val & 0xFF;
 		break;
 	case 0x1:
 		 /* EVENT1, bits[15:8] */
-		config->eventctrl0 = val & 0xFFFF;
+		sysfs_config->eventctrl0 = val & 0xFFFF;
 		break;
 	case 0x2:
 		/* EVENT2, bits[23:16] */
-		config->eventctrl0 = val & 0xFFFFFF;
+		sysfs_config->eventctrl0 = val & 0xFFFFFF;
 		break;
 	case 0x3:
 		/* EVENT3, bits[31:24] */
-		config->eventctrl0 = val;
+		sysfs_config->eventctrl0 = val;
 		break;
 	default:
 		break;
@@ -543,9 +543,9 @@ static ssize_t event_instren_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = FIELD_GET(TRCEVENTCTL1R_INSTEN_MASK, config->eventctrl1);
+	val = FIELD_GET(TRCEVENTCTL1R_INSTEN_MASK, sysfs_config->eventctrl1);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -556,32 +556,33 @@ static ssize_t event_instren_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
 	/* start by clearing all instruction event enable bits */
-	config->eventctrl1 &= ~TRCEVENTCTL1R_INSTEN_MASK;
+	sysfs_config->eventctrl1 &= ~TRCEVENTCTL1R_INSTEN_MASK;
 	switch (caps->nr_event) {
 	case 0x0:
 		/* generate Event element for event 1 */
-		config->eventctrl1 |= val & TRCEVENTCTL1R_INSTEN_1;
+		sysfs_config->eventctrl1 |= val & TRCEVENTCTL1R_INSTEN_1;
 		break;
 	case 0x1:
 		/* generate Event element for event 1 and 2 */
-		config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 | TRCEVENTCTL1R_INSTEN_1);
+		sysfs_config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
+						   TRCEVENTCTL1R_INSTEN_1);
 		break;
 	case 0x2:
 		/* generate Event element for event 1, 2 and 3 */
-		config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
+		sysfs_config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
 					     TRCEVENTCTL1R_INSTEN_1 |
 					     TRCEVENTCTL1R_INSTEN_2);
 		break;
 	case 0x3:
 		/* generate Event element for all 4 events */
-		config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
+		sysfs_config->eventctrl1 |= val & (TRCEVENTCTL1R_INSTEN_0 |
 					     TRCEVENTCTL1R_INSTEN_1 |
 					     TRCEVENTCTL1R_INSTEN_2 |
 					     TRCEVENTCTL1R_INSTEN_3);
@@ -600,9 +601,9 @@ static ssize_t event_ts_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->ts_ctrl;
+	val = sysfs_config->ts_ctrl;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -613,14 +614,14 @@ static ssize_t event_ts_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 	if (!caps->ts_size)
 		return -EINVAL;
 
-	config->ts_ctrl = val & ETMv4_EVENT_MASK;
+	sysfs_config->ts_ctrl = val & ETMv4_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(event_ts);
@@ -631,9 +632,9 @@ static ssize_t syncfreq_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->syncfreq;
+	val = sysfs_config->syncfreq;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -644,14 +645,14 @@ static ssize_t syncfreq_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 	if (caps->syncpr)
 		return -EINVAL;
 
-	config->syncfreq = val & ETMv4_SYNC_MASK;
+	sysfs_config->syncfreq = val & ETMv4_SYNC_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(syncfreq);
@@ -662,9 +663,9 @@ static ssize_t cyc_threshold_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->ccctlr;
+	val = sysfs_config->ccctlr;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -675,7 +676,7 @@ static ssize_t cyc_threshold_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -685,7 +686,7 @@ static ssize_t cyc_threshold_store(struct device *dev,
 	if (val < caps->ccitmin)
 		return -EINVAL;
 
-	config->ccctlr = val;
+	sysfs_config->ccctlr = val;
 	return size;
 }
 static DEVICE_ATTR_RW(cyc_threshold);
@@ -696,9 +697,9 @@ static ssize_t bb_ctrl_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->bb_ctrl;
+	val = sysfs_config->bb_ctrl;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -709,7 +710,7 @@ static ssize_t bb_ctrl_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -726,7 +727,7 @@ static ssize_t bb_ctrl_store(struct device *dev,
 	if ((val & TRCBBCTLR_MODE) && (FIELD_GET(TRCBBCTLR_RANGE_MASK, val) == 0))
 		return -EINVAL;
 
-	config->bb_ctrl = val & (TRCBBCTLR_MODE | TRCBBCTLR_RANGE_MASK);
+	sysfs_config->bb_ctrl = val & (TRCBBCTLR_MODE | TRCBBCTLR_RANGE_MASK);
 	return size;
 }
 static DEVICE_ATTR_RW(bb_ctrl);
@@ -737,9 +738,9 @@ static ssize_t event_vinst_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = FIELD_GET(TRCVICTLR_EVENT_MASK, config->vinst_ctrl);
+	val = FIELD_GET(TRCVICTLR_EVENT_MASK, sysfs_config->vinst_ctrl);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -749,15 +750,15 @@ static ssize_t event_vinst_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
 	val &= TRCVICTLR_EVENT_MASK >> __bf_shf(TRCVICTLR_EVENT_MASK);
-	config->vinst_ctrl &= ~TRCVICTLR_EVENT_MASK;
-	config->vinst_ctrl |= FIELD_PREP(TRCVICTLR_EVENT_MASK, val);
+	sysfs_config->vinst_ctrl &= ~TRCVICTLR_EVENT_MASK;
+	sysfs_config->vinst_ctrl |= FIELD_PREP(TRCVICTLR_EVENT_MASK, val);
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -769,9 +770,9 @@ static ssize_t s_exlevel_vinst_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = FIELD_GET(TRCVICTLR_EXLEVEL_S_MASK, config->vinst_ctrl);
+	val = FIELD_GET(TRCVICTLR_EXLEVEL_S_MASK, sysfs_config->vinst_ctrl);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -782,17 +783,17 @@ static ssize_t s_exlevel_vinst_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
 	/* clear all EXLEVEL_S bits  */
-	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_S_MASK;
+	sysfs_config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_S_MASK;
 	/* enable instruction tracing for corresponding exception level */
 	val &= caps->s_ex_level;
-	config->vinst_ctrl |= val << __bf_shf(TRCVICTLR_EXLEVEL_S_MASK);
+	sysfs_config->vinst_ctrl |= val << __bf_shf(TRCVICTLR_EXLEVEL_S_MASK);
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -804,10 +805,10 @@ static ssize_t ns_exlevel_vinst_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	/* EXLEVEL_NS, bits[23:20] */
-	val = FIELD_GET(TRCVICTLR_EXLEVEL_NS_MASK, config->vinst_ctrl);
+	val = FIELD_GET(TRCVICTLR_EXLEVEL_NS_MASK, sysfs_config->vinst_ctrl);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -818,17 +819,17 @@ static ssize_t ns_exlevel_vinst_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
 	/* clear EXLEVEL_NS bits  */
-	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_NS_MASK;
+	sysfs_config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_NS_MASK;
 	/* enable instruction tracing for corresponding exception level */
 	val &= caps->ns_ex_level;
-	config->vinst_ctrl |= val << __bf_shf(TRCVICTLR_EXLEVEL_NS_MASK);
+	sysfs_config->vinst_ctrl |= val << __bf_shf(TRCVICTLR_EXLEVEL_NS_MASK);
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -840,9 +841,9 @@ static ssize_t addr_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->addr_idx;
+	val = sysfs_config->addr_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -853,7 +854,7 @@ static ssize_t addr_idx_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -865,7 +866,7 @@ static ssize_t addr_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	raw_spin_lock(&drvdata->spinlock);
-	config->addr_idx = val;
+	sysfs_config->addr_idx = val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -878,11 +879,11 @@ static ssize_t addr_instdatatype_show(struct device *dev,
 	ssize_t len;
 	u8 val, idx;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
-	val = FIELD_GET(TRCACATRn_TYPE_MASK, config->addr_acc[idx]);
+	idx = sysfs_config->addr_idx;
+	val = FIELD_GET(TRCACATRn_TYPE_MASK, sysfs_config->addr_acc[idx]);
 	len = scnprintf(buf, PAGE_SIZE, "%s\n",
 			val == TRCACATRn_TYPE_ADDR ? "instr" :
 			(val == TRCACATRn_TYPE_DATA_LOAD_ADDR ? "data_load" :
@@ -899,7 +900,7 @@ static ssize_t addr_instdatatype_store(struct device *dev,
 	u8 idx;
 	char str[20] = "";
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (strlen(buf) >= 20)
 		return -EINVAL;
@@ -907,10 +908,10 @@ static ssize_t addr_instdatatype_store(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	if (!strcmp(str, "instr"))
 		/* TYPE, bits[1:0] */
-		config->addr_acc[idx] &= ~TRCACATRn_TYPE_MASK;
+		sysfs_config->addr_acc[idx] &= ~TRCACATRn_TYPE_MASK;
 
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
@@ -924,16 +925,16 @@ static ssize_t addr_single_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	raw_spin_lock(&drvdata->spinlock);
-	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
+	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
-	val = (unsigned long)config->addr_val[idx];
+	val = (unsigned long)sysfs_config->addr_val[idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -945,21 +946,21 @@ static ssize_t addr_single_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
-	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
+	idx = sysfs_config->addr_idx;
+	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_SINGLE)) {
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	config->addr_val[idx] = (u64)val;
-	config->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
+	sysfs_config->addr_val[idx] = (u64)val;
+	sysfs_config->addr_type[idx] = ETM_ADDR_TYPE_SINGLE;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -972,24 +973,24 @@ static ssize_t addr_range_show(struct device *dev,
 	u8 idx;
 	unsigned long val1, val2;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	if (idx % 2 != 0) {
 		raw_spin_unlock(&drvdata->spinlock);
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
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	val1 = (unsigned long)config->addr_val[idx];
-	val2 = (unsigned long)config->addr_val[idx + 1];
+	val1 = (unsigned long)sysfs_config->addr_val[idx];
+	val2 = (unsigned long)sysfs_config->addr_val[idx + 1];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
 }
@@ -1001,7 +1002,7 @@ static ssize_t addr_range_store(struct device *dev,
 	u8 idx;
 	unsigned long val1, val2;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 	int elements, exclude;
 
 	elements = sscanf(buf, "%lx %lx %x", &val1, &val2, &exclude);
@@ -1014,31 +1015,31 @@ static ssize_t addr_range_store(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	if (idx % 2 != 0) {
 		raw_spin_unlock(&drvdata->spinlock);
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
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	config->addr_val[idx] = (u64)val1;
-	config->addr_type[idx] = ETM_ADDR_TYPE_RANGE;
-	config->addr_val[idx + 1] = (u64)val2;
-	config->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
+	sysfs_config->addr_val[idx] = (u64)val1;
+	sysfs_config->addr_type[idx] = ETM_ADDR_TYPE_RANGE;
+	sysfs_config->addr_val[idx + 1] = (u64)val2;
+	sysfs_config->addr_type[idx + 1] = ETM_ADDR_TYPE_RANGE;
 	/*
 	 * Program include or exclude control bits for vinst or vdata
 	 * whenever we change addr comparators to ETM_ADDR_TYPE_RANGE
 	 * use supplied value, or default to bit set in 'mode'
 	 */
 	if (elements != 3)
-		exclude = config->mode & ETM_MODE_EXCLUDE;
+		exclude = sysfs_config->mode & ETM_MODE_EXCLUDE;
 	etm4_set_mode_exclude(drvdata, exclude ? true : false);
 
 	raw_spin_unlock(&drvdata->spinlock);
@@ -1053,18 +1054,18 @@ static ssize_t addr_start_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 
-	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
+	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	val = (unsigned long)config->addr_val[idx];
+	val = (unsigned long)sysfs_config->addr_val[idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1077,26 +1078,26 @@ static ssize_t addr_start_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	if (!caps->nr_addr_cmp) {
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
-	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
+	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_START)) {
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	config->addr_val[idx] = (u64)val;
-	config->addr_type[idx] = ETM_ADDR_TYPE_START;
-	config->vissctlr |= BIT(idx);
+	sysfs_config->addr_val[idx] = (u64)val;
+	sysfs_config->addr_type[idx] = ETM_ADDR_TYPE_START;
+	sysfs_config->vissctlr |= BIT(idx);
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1109,18 +1110,18 @@ static ssize_t addr_stop_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 
-	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	      config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
+	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	      sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	val = (unsigned long)config->addr_val[idx];
+	val = (unsigned long)sysfs_config->addr_val[idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1133,26 +1134,26 @@ static ssize_t addr_stop_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	if (!caps->nr_addr_cmp) {
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
-	if (!(config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
-	       config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
+	if (!(sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_NONE ||
+	       sysfs_config->addr_type[idx] == ETM_ADDR_TYPE_STOP)) {
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EPERM;
 	}
 
-	config->addr_val[idx] = (u64)val;
-	config->addr_type[idx] = ETM_ADDR_TYPE_STOP;
-	config->vissctlr |= BIT(idx + 16);
+	sysfs_config->addr_val[idx] = (u64)val;
+	sysfs_config->addr_type[idx] = ETM_ADDR_TYPE_STOP;
+	sysfs_config->vissctlr |= BIT(idx + 16);
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1165,12 +1166,12 @@ static ssize_t addr_ctxtype_show(struct device *dev,
 	ssize_t len;
 	u8 idx, val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	/* CONTEXTTYPE, bits[3:2] */
-	val = FIELD_GET(TRCACATRn_CONTEXTTYPE_MASK, config->addr_acc[idx]);
+	val = FIELD_GET(TRCACATRn_CONTEXTTYPE_MASK, sysfs_config->addr_acc[idx]);
 	len = scnprintf(buf, PAGE_SIZE, "%s\n", val == ETM_CTX_NONE ? "none" :
 			(val == ETM_CTX_CTXID ? "ctxid" :
 			(val == ETM_CTX_VMID ? "vmid" : "all")));
@@ -1186,7 +1187,7 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 	char str[10] = "";
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (strlen(buf) >= 10)
 		return -EINVAL;
@@ -1194,21 +1195,21 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	if (!strcmp(str, "none"))
 		/* start by clearing context type bits */
-		config->addr_acc[idx] &= ~TRCACATRn_CONTEXTTYPE_MASK;
+		sysfs_config->addr_acc[idx] &= ~TRCACATRn_CONTEXTTYPE_MASK;
 	else if (!strcmp(str, "ctxid")) {
 		/* 0b01 The trace unit performs a Context ID */
 		if (caps->numcidc) {
-			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_CTXID;
-			config->addr_acc[idx] &= ~TRCACATRn_CONTEXTTYPE_VMID;
+			sysfs_config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_CTXID;
+			sysfs_config->addr_acc[idx] &= ~TRCACATRn_CONTEXTTYPE_VMID;
 		}
 	} else if (!strcmp(str, "vmid")) {
 		/* 0b10 The trace unit performs a VMID */
 		if (caps->numvmidc) {
-			config->addr_acc[idx] &= ~TRCACATRn_CONTEXTTYPE_CTXID;
-			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_VMID;
+			sysfs_config->addr_acc[idx] &= ~TRCACATRn_CONTEXTTYPE_CTXID;
+			sysfs_config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_VMID;
 		}
 	} else if (!strcmp(str, "all")) {
 		/*
@@ -1216,9 +1217,9 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 		 * comparison and a VMID
 		 */
 		if (caps->numcidc)
-			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_CTXID;
+			sysfs_config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_CTXID;
 		if (caps->numvmidc)
-			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_VMID;
+			sysfs_config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_VMID;
 	}
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
@@ -1232,12 +1233,12 @@ static ssize_t addr_context_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	/* context ID comparator bits[6:4] */
-	val = FIELD_GET(TRCACATRn_CONTEXT_MASK, config->addr_acc[idx]);
+	val = FIELD_GET(TRCACATRn_CONTEXT_MASK, sysfs_config->addr_acc[idx]);
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1250,7 +1251,7 @@ static ssize_t addr_context_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1261,10 +1262,10 @@ static ssize_t addr_context_store(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	/* clear context ID comparator bits[6:4] */
-	config->addr_acc[idx] &= ~TRCACATRn_CONTEXT_MASK;
-	config->addr_acc[idx] |= val << __bf_shf(TRCACATRn_CONTEXT_MASK);
+	sysfs_config->addr_acc[idx] &= ~TRCACATRn_CONTEXT_MASK;
+	sysfs_config->addr_acc[idx] |= val << __bf_shf(TRCACATRn_CONTEXT_MASK);
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1277,11 +1278,11 @@ static ssize_t addr_exlevel_s_ns_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
-	val = FIELD_GET(TRCACATRn_EXLEVEL_MASK, config->addr_acc[idx]);
+	idx = sysfs_config->addr_idx;
+	val = FIELD_GET(TRCACATRn_EXLEVEL_MASK, sysfs_config->addr_acc[idx]);
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1293,7 +1294,7 @@ static ssize_t addr_exlevel_s_ns_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 0, &val))
 		return -EINVAL;
@@ -1302,10 +1303,10 @@ static ssize_t addr_exlevel_s_ns_store(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
+	idx = sysfs_config->addr_idx;
 	/* clear Exlevel_ns & Exlevel_s bits[14:12, 11:8], bit[15] is res0 */
-	config->addr_acc[idx] &= ~TRCACATRn_EXLEVEL_MASK;
-	config->addr_acc[idx] |= val << __bf_shf(TRCACATRn_EXLEVEL_MASK);
+	sysfs_config->addr_acc[idx] &= ~TRCACATRn_EXLEVEL_MASK;
+	sysfs_config->addr_acc[idx] |= val << __bf_shf(TRCACATRn_EXLEVEL_MASK);
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1325,24 +1326,24 @@ static ssize_t addr_cmp_view_show(struct device *dev,
 	u8 idx, addr_type;
 	unsigned long addr_v, addr_v2, addr_ctrl;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 	int size = 0;
 	bool exclude = false;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->addr_idx;
-	addr_v = config->addr_val[idx];
-	addr_ctrl = config->addr_acc[idx];
-	addr_type = config->addr_type[idx];
+	idx = sysfs_config->addr_idx;
+	addr_v = sysfs_config->addr_val[idx];
+	addr_ctrl = sysfs_config->addr_acc[idx];
+	addr_type = sysfs_config->addr_type[idx];
 	if (addr_type == ETM_ADDR_TYPE_RANGE) {
 		if (idx & 0x1) {
 			idx -= 1;
 			addr_v2 = addr_v;
-			addr_v = config->addr_val[idx];
+			addr_v = sysfs_config->addr_val[idx];
 		} else {
-			addr_v2 = config->addr_val[idx + 1];
+			addr_v2 = sysfs_config->addr_val[idx + 1];
 		}
-		exclude = config->viiectlr & BIT(idx / 2 + 16);
+		exclude = sysfs_config->viiectlr & BIT(idx / 2 + 16);
 	}
 	raw_spin_unlock(&drvdata->spinlock);
 	if (addr_type) {
@@ -1369,11 +1370,11 @@ static ssize_t vinst_pe_cmp_start_stop_show(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (!caps->nr_pe_cmp)
 		return -EINVAL;
-	val = config->vipcssctlr;
+	val = sysfs_config->vipcssctlr;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static ssize_t vinst_pe_cmp_start_stop_store(struct device *dev,
@@ -1383,7 +1384,7 @@ static ssize_t vinst_pe_cmp_start_stop_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1391,7 +1392,7 @@ static ssize_t vinst_pe_cmp_start_stop_store(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	config->vipcssctlr = val;
+	sysfs_config->vipcssctlr = val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1403,9 +1404,9 @@ static ssize_t seq_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->seq_idx;
+	val = sysfs_config->seq_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1416,7 +1417,7 @@ static ssize_t seq_idx_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (!caps->nr_seq_ctrls)
 		return -ENOTSUPP;
@@ -1430,7 +1431,7 @@ static ssize_t seq_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	raw_spin_lock(&drvdata->spinlock);
-	config->seq_idx = val;
+	sysfs_config->seq_idx = val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1442,9 +1443,9 @@ static ssize_t seq_state_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->seq_state;
+	val = sysfs_config->seq_state;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1455,7 +1456,7 @@ static ssize_t seq_state_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1465,7 +1466,7 @@ static ssize_t seq_state_store(struct device *dev,
 	if (val >= caps->nrseqstate)
 		return -EINVAL;
 
-	config->seq_state = val;
+	sysfs_config->seq_state = val;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_state);
@@ -1477,11 +1478,11 @@ static ssize_t seq_event_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->seq_idx;
-	val = config->seq_ctrl[idx];
+	idx = sysfs_config->seq_idx;
+	val = sysfs_config->seq_ctrl[idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1493,15 +1494,15 @@ static ssize_t seq_event_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->seq_idx;
+	idx = sysfs_config->seq_idx;
 	/* Seq control has two masks B[15:8] F[7:0] */
-	config->seq_ctrl[idx] = val & 0xFFFF;
+	sysfs_config->seq_ctrl[idx] = val & 0xFFFF;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1513,9 +1514,9 @@ static ssize_t seq_reset_event_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->seq_rst;
+	val = sysfs_config->seq_rst;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1526,14 +1527,14 @@ static ssize_t seq_reset_event_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 	if (!(caps->nrseqstate))
 		return -EINVAL;
 
-	config->seq_rst = val & ETMv4_EVENT_MASK;
+	sysfs_config->seq_rst = val & ETMv4_EVENT_MASK;
 	return size;
 }
 static DEVICE_ATTR_RW(seq_reset_event);
@@ -1544,9 +1545,9 @@ static ssize_t cntr_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->cntr_idx;
+	val = sysfs_config->cntr_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1557,7 +1558,7 @@ static ssize_t cntr_idx_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1569,7 +1570,7 @@ static ssize_t cntr_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	raw_spin_lock(&drvdata->spinlock);
-	config->cntr_idx = val;
+	sysfs_config->cntr_idx = val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1582,11 +1583,11 @@ static ssize_t cntrldvr_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->cntr_idx;
-	val = config->cntrldvr[idx];
+	idx = sysfs_config->cntr_idx;
+	val = sysfs_config->cntrldvr[idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1598,7 +1599,7 @@ static ssize_t cntrldvr_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1606,8 +1607,8 @@ static ssize_t cntrldvr_store(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->cntr_idx;
-	config->cntrldvr[idx] = val;
+	idx = sysfs_config->cntr_idx;
+	sysfs_config->cntrldvr[idx] = val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1620,11 +1621,11 @@ static ssize_t cntr_val_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->cntr_idx;
-	val = config->cntr_val[idx];
+	idx = sysfs_config->cntr_idx;
+	val = sysfs_config->cntr_val[idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1636,7 +1637,7 @@ static ssize_t cntr_val_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1647,8 +1648,8 @@ static ssize_t cntr_val_store(struct device *dev,
 		return -EBUSY;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->cntr_idx;
-	config->cntr_val[idx] = val;
+	idx = sysfs_config->cntr_idx;
+	sysfs_config->cntr_val[idx] = val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1661,11 +1662,11 @@ static ssize_t cntr_ctrl_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->cntr_idx;
-	val = config->cntr_ctrl[idx];
+	idx = sysfs_config->cntr_idx;
+	val = sysfs_config->cntr_ctrl[idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1677,14 +1678,14 @@ static ssize_t cntr_ctrl_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->cntr_idx;
-	config->cntr_ctrl[idx] = val;
+	idx = sysfs_config->cntr_idx;
+	sysfs_config->cntr_ctrl[idx] = val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1696,9 +1697,9 @@ static ssize_t res_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->res_idx;
+	val = sysfs_config->res_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1709,7 +1710,7 @@ static ssize_t res_idx_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1725,7 +1726,7 @@ static ssize_t res_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	raw_spin_lock(&drvdata->spinlock);
-	config->res_idx = val;
+	sysfs_config->res_idx = val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1738,11 +1739,11 @@ static ssize_t res_ctrl_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->res_idx;
-	val = config->res_ctrl[idx];
+	idx = sysfs_config->res_idx;
+	val = sysfs_config->res_ctrl[idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1754,18 +1755,18 @@ static ssize_t res_ctrl_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->res_idx;
+	idx = sysfs_config->res_idx;
 	/* For odd idx pair inversal bit is RES0 */
 	if (idx % 2 != 0)
 		/* PAIRINV, bit[21] */
 		val &= ~TRCRSCTLRn_PAIRINV;
-	config->res_ctrl[idx] = val & (TRCRSCTLRn_PAIRINV |
+	sysfs_config->res_ctrl[idx] = val & (TRCRSCTLRn_PAIRINV |
 				       TRCRSCTLRn_INV |
 				       TRCRSCTLRn_GROUP_MASK |
 				       TRCRSCTLRn_SELECT_MASK);
@@ -1779,9 +1780,9 @@ static ssize_t sshot_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->ss_idx;
+	val = sysfs_config->ss_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1792,7 +1793,7 @@ static ssize_t sshot_idx_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1800,7 +1801,7 @@ static ssize_t sshot_idx_store(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	config->ss_idx = val;
+	sysfs_config->ss_idx = val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1812,10 +1813,10 @@ static ssize_t sshot_ctrl_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	val = config->ss_ctrl[config->ss_idx];
+	val = sysfs_config->ss_ctrl[sysfs_config->ss_idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1827,14 +1828,14 @@ static ssize_t sshot_ctrl_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->ss_idx;
-	config->ss_ctrl[idx] = FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
+	idx = sysfs_config->ss_idx;
+	sysfs_config->ss_ctrl[idx] = FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
 	/* must clear bit 31 and 30 in related status register on programming */
 	drvdata->ss_status[idx] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
 	raw_spin_unlock(&drvdata->spinlock);
@@ -1847,10 +1848,10 @@ static ssize_t sshot_status_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	val = drvdata->ss_status[config->ss_idx];
+	val = drvdata->ss_status[sysfs_config->ss_idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1862,10 +1863,10 @@ static ssize_t sshot_pe_ctrl_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	val = config->ss_pe_cmp[config->ss_idx];
+	val = sysfs_config->ss_pe_cmp[sysfs_config->ss_idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1877,14 +1878,14 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->ss_idx;
-	config->ss_pe_cmp[idx] = FIELD_PREP(TRCSSPCICRn_PC_MASK, val);
+	idx = sysfs_config->ss_idx;
+	sysfs_config->ss_pe_cmp[idx] = FIELD_PREP(TRCSSPCICRn_PC_MASK, val);
 	/* must clear bit 31 and 30 in related status register on programming */
 	drvdata->ss_status[idx] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
 	raw_spin_unlock(&drvdata->spinlock);
@@ -1898,9 +1899,9 @@ static ssize_t ctxid_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->ctxid_idx;
+	val = sysfs_config->ctxid_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -1911,7 +1912,7 @@ static ssize_t ctxid_idx_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -1923,7 +1924,7 @@ static ssize_t ctxid_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	raw_spin_lock(&drvdata->spinlock);
-	config->ctxid_idx = val;
+	sysfs_config->ctxid_idx = val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1936,7 +1937,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	/*
 	 * Don't use contextID tracing if coming from a PID namespace.  See
@@ -1946,8 +1947,8 @@ static ssize_t ctxid_pid_show(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->ctxid_idx;
-	val = (unsigned long)config->ctxid_pid[idx];
+	idx = sysfs_config->ctxid_idx;
+	val = (unsigned long)sysfs_config->ctxid_pid[idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1960,7 +1961,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	unsigned long pid;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	/*
 	 * When contextID tracing is enabled the tracers will insert the
@@ -1985,8 +1986,8 @@ static ssize_t ctxid_pid_store(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	idx = config->ctxid_idx;
-	config->ctxid_pid[idx] = (u64)pid;
+	idx = sysfs_config->ctxid_idx;
+	sysfs_config->ctxid_pid[idx] = (u64)pid;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1998,7 +1999,7 @@ static ssize_t ctxid_masks_show(struct device *dev,
 {
 	unsigned long val1, val2;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	/*
 	 * Don't use contextID tracing if coming from a PID namespace.  See
@@ -2008,8 +2009,8 @@ static ssize_t ctxid_masks_show(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	val1 = config->ctxid_mask0;
-	val2 = config->ctxid_mask1;
+	val1 = sysfs_config->ctxid_mask0;
+	val2 = sysfs_config->ctxid_mask1;
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
 }
@@ -2022,7 +2023,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	unsigned long val1, val2, mask;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 	int nr_inputs;
 
 	/*
@@ -2052,39 +2053,39 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	switch (caps->numcidc) {
 	case 0x1:
 		/* COMP0, bits[7:0] */
-		config->ctxid_mask0 = val1 & 0xFF;
+		sysfs_config->ctxid_mask0 = val1 & 0xFF;
 		break;
 	case 0x2:
 		/* COMP1, bits[15:8] */
-		config->ctxid_mask0 = val1 & 0xFFFF;
+		sysfs_config->ctxid_mask0 = val1 & 0xFFFF;
 		break;
 	case 0x3:
 		/* COMP2, bits[23:16] */
-		config->ctxid_mask0 = val1 & 0xFFFFFF;
+		sysfs_config->ctxid_mask0 = val1 & 0xFFFFFF;
 		break;
 	case 0x4:
 		 /* COMP3, bits[31:24] */
-		config->ctxid_mask0 = val1;
+		sysfs_config->ctxid_mask0 = val1;
 		break;
 	case 0x5:
 		/* COMP4, bits[7:0] */
-		config->ctxid_mask0 = val1;
-		config->ctxid_mask1 = val2 & 0xFF;
+		sysfs_config->ctxid_mask0 = val1;
+		sysfs_config->ctxid_mask1 = val2 & 0xFF;
 		break;
 	case 0x6:
 		/* COMP5, bits[15:8] */
-		config->ctxid_mask0 = val1;
-		config->ctxid_mask1 = val2 & 0xFFFF;
+		sysfs_config->ctxid_mask0 = val1;
+		sysfs_config->ctxid_mask1 = val2 & 0xFFFF;
 		break;
 	case 0x7:
 		/* COMP6, bits[23:16] */
-		config->ctxid_mask0 = val1;
-		config->ctxid_mask1 = val2 & 0xFFFFFF;
+		sysfs_config->ctxid_mask0 = val1;
+		sysfs_config->ctxid_mask1 = val2 & 0xFFFFFF;
 		break;
 	case 0x8:
 		/* COMP7, bits[31:24] */
-		config->ctxid_mask0 = val1;
-		config->ctxid_mask1 = val2;
+		sysfs_config->ctxid_mask0 = val1;
+		sysfs_config->ctxid_mask1 = val2;
 		break;
 	default:
 		break;
@@ -2095,7 +2096,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	 * For example, if bit[3] of ctxid_mask0 is 1, we must clear bits[31:24]
 	 * of ctxid comparator0 value (corresponding to byte 0) register.
 	 */
-	mask = config->ctxid_mask0;
+	mask = sysfs_config->ctxid_mask0;
 	for (i = 0; i < caps->numcidc; i++) {
 		/* mask value of corresponding ctxid comparator */
 		maskbyte = mask & ETMv4_EVENT_MASK;
@@ -2105,13 +2106,13 @@ static ssize_t ctxid_masks_store(struct device *dev,
 		 */
 		for (j = 0; j < 8; j++) {
 			if (maskbyte & 1)
-				config->ctxid_pid[i] &= ~(0xFFUL << (j * 8));
+				sysfs_config->ctxid_pid[i] &= ~(0xFFUL << (j * 8));
 			maskbyte >>= 1;
 		}
 		/* Select the next ctxid comparator mask value */
 		if (i == 3)
 			/* ctxid comparators[4-7] */
-			mask = config->ctxid_mask1;
+			mask = sysfs_config->ctxid_mask1;
 		else
 			mask >>= 0x8;
 	}
@@ -2127,9 +2128,9 @@ static ssize_t vmid_idx_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
-	val = config->vmid_idx;
+	val = sysfs_config->vmid_idx;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 
@@ -2140,7 +2141,7 @@ static ssize_t vmid_idx_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -2152,7 +2153,7 @@ static ssize_t vmid_idx_store(struct device *dev,
 	 * dereferenced multiple times within a spinlock block elsewhere.
 	 */
 	raw_spin_lock(&drvdata->spinlock);
-	config->vmid_idx = val;
+	sysfs_config->vmid_idx = val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -2164,7 +2165,7 @@ static ssize_t vmid_val_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	/*
 	 * Don't use virtual contextID tracing if coming from a PID namespace.
@@ -2174,7 +2175,7 @@ static ssize_t vmid_val_show(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	val = (unsigned long)config->vmid_val[config->vmid_idx];
+	val = (unsigned long)sysfs_config->vmid_val[sysfs_config->vmid_idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -2186,7 +2187,7 @@ static ssize_t vmid_val_store(struct device *dev,
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	/*
 	 * Don't use virtual contextID tracing if coming from a PID namespace.
@@ -2205,7 +2206,7 @@ static ssize_t vmid_val_store(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	config->vmid_val[config->vmid_idx] = (u64)val;
+	sysfs_config->vmid_val[sysfs_config->vmid_idx] = (u64)val;
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -2216,7 +2217,7 @@ static ssize_t vmid_masks_show(struct device *dev,
 {
 	unsigned long val1, val2;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 
 	/*
 	 * Don't use virtual contextID tracing if coming from a PID namespace.
@@ -2226,8 +2227,8 @@ static ssize_t vmid_masks_show(struct device *dev,
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	val1 = config->vmid_mask0;
-	val2 = config->vmid_mask1;
+	val1 = sysfs_config->vmid_mask0;
+	val2 = sysfs_config->vmid_mask1;
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
 }
@@ -2240,7 +2241,7 @@ static ssize_t vmid_masks_store(struct device *dev,
 	unsigned long val1, val2, mask;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->config;
+	struct etmv4_config *sysfs_config = &drvdata->sysfs_config;
 	int nr_inputs;
 
 	/*
@@ -2270,39 +2271,39 @@ static ssize_t vmid_masks_store(struct device *dev,
 	switch (caps->numvmidc) {
 	case 0x1:
 		/* COMP0, bits[7:0] */
-		config->vmid_mask0 = val1 & 0xFF;
+		sysfs_config->vmid_mask0 = val1 & 0xFF;
 		break;
 	case 0x2:
 		/* COMP1, bits[15:8] */
-		config->vmid_mask0 = val1 & 0xFFFF;
+		sysfs_config->vmid_mask0 = val1 & 0xFFFF;
 		break;
 	case 0x3:
 		/* COMP2, bits[23:16] */
-		config->vmid_mask0 = val1 & 0xFFFFFF;
+		sysfs_config->vmid_mask0 = val1 & 0xFFFFFF;
 		break;
 	case 0x4:
 		/* COMP3, bits[31:24] */
-		config->vmid_mask0 = val1;
+		sysfs_config->vmid_mask0 = val1;
 		break;
 	case 0x5:
 		/* COMP4, bits[7:0] */
-		config->vmid_mask0 = val1;
-		config->vmid_mask1 = val2 & 0xFF;
+		sysfs_config->vmid_mask0 = val1;
+		sysfs_config->vmid_mask1 = val2 & 0xFF;
 		break;
 	case 0x6:
 		/* COMP5, bits[15:8] */
-		config->vmid_mask0 = val1;
-		config->vmid_mask1 = val2 & 0xFFFF;
+		sysfs_config->vmid_mask0 = val1;
+		sysfs_config->vmid_mask1 = val2 & 0xFFFF;
 		break;
 	case 0x7:
 		/* COMP6, bits[23:16] */
-		config->vmid_mask0 = val1;
-		config->vmid_mask1 = val2 & 0xFFFFFF;
+		sysfs_config->vmid_mask0 = val1;
+		sysfs_config->vmid_mask1 = val2 & 0xFFFFFF;
 		break;
 	case 0x8:
 		/* COMP7, bits[31:24] */
-		config->vmid_mask0 = val1;
-		config->vmid_mask1 = val2;
+		sysfs_config->vmid_mask0 = val1;
+		sysfs_config->vmid_mask1 = val2;
 		break;
 	default:
 		break;
@@ -2314,7 +2315,7 @@ static ssize_t vmid_masks_store(struct device *dev,
 	 * For example, if bit[3] of vmid_mask0 is 1, we must clear bits[31:24]
 	 * of vmid comparator0 value (corresponding to byte 0) register.
 	 */
-	mask = config->vmid_mask0;
+	mask = sysfs_config->vmid_mask0;
 	for (i = 0; i < caps->numvmidc; i++) {
 		/* mask value of corresponding vmid comparator */
 		maskbyte = mask & ETMv4_EVENT_MASK;
@@ -2324,13 +2325,13 @@ static ssize_t vmid_masks_store(struct device *dev,
 		 */
 		for (j = 0; j < 8; j++) {
 			if (maskbyte & 1)
-				config->vmid_val[i] &= ~(0xFFUL << (j * 8));
+				sysfs_config->vmid_val[i] &= ~(0xFFUL << (j * 8));
 			maskbyte >>= 1;
 		}
 		/* Select the next vmid comparator mask value */
 		if (i == 3)
 			/* vmid comparators[4-7] */
-			mask = config->vmid_mask1;
+			mask = sysfs_config->vmid_mask1;
 		else
 			mask >>= 0x8;
 	}
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index ae97c5c004bf..5417280cdb27 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -1070,7 +1070,7 @@ struct etmv4_save_state {
  *		at runtime, due to the additional setting of TRFCR_CX when
  *		in EL2. Otherwise, 0.
  * @curr_config:	structure holding current applied configuration.
- * @config:	structure holding sysfs mode configuration.
+ * @sysfs_config:	structure holding sysfs mode configuration.
  * @save_state:	State to be preserved across power loss
  * @paused:	Indicates if the trace unit is paused.
  * @ss_status:	The status of the corresponding single-shot comparator.
@@ -1092,7 +1092,7 @@ struct etmv4_drvdata {
 	bool				paused : 1;
 	u64				trfcr;
 	struct etmv4_config		curr_config;
-	struct etmv4_config		config;
+	struct etmv4_config		sysfs_config;
 	struct etmv4_save_state		*save_state;
 	u32				ss_status[ETM_MAX_SS_CMP];
 	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);

-- 
2.43.0

