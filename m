Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C9B38D6AD
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995985; cv=none; b=Ta9dNe60e+n0NRsXlT9jx/ISSahN5GA+9g730m5oiWZHq4KOZYIivENmNleUtWMUAwv6o8ctPtjftCsRk2uECrV1kMpfcE3j/iF2W/fclYdVJUQVtfzSoIwvuIv88KWIQ4CFtAfMtipOSr1TYHhGoNY5xt1CTJiUIzFJXd82htY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995985; c=relaxed/simple;
	bh=wNwlRPVGccAL8FovCT7RLGxnIutNCvLeW6sNMLH2d+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lIwX6uu1XMRPKaT8VoZDK8oum2eW6rDFgIR7kxG94PlwGU2X90SLatNg6amk+4Yi3qTXlVYNderf1qZnrw9XSPqYn3JaddViIMVP0p742CLfUFCkgt0DfSoZx1Z/6OCXigReydilSxnA1R+qYpATQNlAPD9RYOKMdqDk0lpgTLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rNWgaZd7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rNWgaZd7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9F8E143D;
	Fri,  2 Oct 2026 19:52:57 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 25F853F763;
	Fri,  2 Oct 2026 19:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790995981; bh=wNwlRPVGccAL8FovCT7RLGxnIutNCvLeW6sNMLH2d+Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rNWgaZd7dbis2nVc085PimeMGrci+x4TOLJkyIJ3f5WOT19U1H043LUiQVub0/aWV
	 cZcxujAvCjXlCNgS0KRMFqHPXRpjyfjhJdGoM7TQB3O5+XplyxeOkdn63t971QVtYH
	 xtFloW0AN4z5od+N4gOk+rUSynvnQD1EvyIICBX4=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Sat, 03 Oct 2026 03:52:24 +0100
Subject: [PATCH RESEND v13 12/14] coresight: etm3x: introduce struct
 etm_caps
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-separate_etm_cfg_v2-v13-12-5d8a29aead95@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13862; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=wNwlRPVGccAL8FovCT7RLGxnIutNCvLeW6sNMLH2d+Y=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqwG3sPBltQTYofx1b2DY1VSytiKtVtb6xa8d2s
 u6RZoXZJCaJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCasBt7AAKCRBt1cPRWsUx
 MzexDACPTMF8y4I5pxjtgM+yPOqlyhBTGUzygG3h4LmMOkKaxxR9VT0Qpt82RtsgfE3EBFNbIoP
 gUN3c0SVFJ9e7nyeLBPM1nnpJhBAJfQLaXgVFfa5YXL47VVoSFf7UmOJjUzrMc3I3Wj18ruxLCr
 tW/5VVqG/MLVUyKSQskjXlHWrugTKRhWBIzHY6tJl0zJeWjXh6899pnDUFlhxWG0utxXzzjo2l9
 tPumpCBjpgViKg5dJE7BGPW6Bwl92Tua9I7/r6D40+U8PaJ4M7V3uq051xpNfol38ao+W0EBuaU
 Y/nFRmHK2USkww72hp/6Vdis7ug6GCJ/YFzjnosyNXmH0nMRI3sI3FRhS9c2PRgnzQR5bGOnRGh
 A8aV73Ly+zcV1z+jajTmjnN6NMgvLqZwmcngPIaOowHdAbFPhOIopIjamhfSjPBUMWXAUjQ3oJf
 vKo2d6x5fi1efGYtvHYPpE31hjt0hg+k6V8GNUVSht/jSOIRTZpe2HRiMU6HvwrD1jrzA=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

Introduce struct etm_caps to describe ETMv3 capabilities
and move capabilities information into it.

Since drvdata->etmccr and drvdata->etmccer are used to check
whether it supports fifofull logic and timestamping,
remove etmccr and etmccer field from drvdata and add relevant fields
in etm_caps structure.

Reviewed-by: Mike Leach <mike.leach@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm.h        | 42 +++++++++++++---------
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 42 +++++++++++++---------
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 24 ++++++++-----
 3 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 52f23a3c7364..560a58a3817c 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -140,6 +140,30 @@
 				 ETM_ADD_COMP_0		|	\
 				 ETM_EVENT_NOT_A)
 
+/**
+ * struct etm_caps - specifics ETM capabilities
+ * @port_size:	port size as reported by ETMCR bit 4-6 and 21.
+ * @nr_addr_cmp:Number of pairs of address comparators as found in ETMCCR.
+ * @nr_cntr:	Number of counters as found in ETMCCR bit 13-15.
+ * @nr_ext_inp:	Number of external input as found in ETMCCR bit 17-19.
+ * @nr_ext_out:	Number of external output as found in ETMCCR bit 20-22.
+ * @nr_ctxid_cmp: Number of contextID comparators as found in ETMCCR bit 24-25.
+ * @fifofull:	FIFOFULL logic is present.
+ * @timestamp:	Timestamping is implemented.
+ * @retstack:	Return stack is implemented.
+ */
+struct etm_caps {
+	int	port_size;
+	u8	nr_addr_cmp;
+	u8	nr_cntr;
+	u8	nr_ext_inp;
+	u8	nr_ext_out;
+	u8	nr_ctxid_cmp;
+	bool	fifofull : 1;
+	bool	timestamp : 1;
+	bool	retstack : 1;
+};
+
 /**
  * struct etm_config - configuration information related to an ETM
  * @mode:	controls various modes supported by this ETM/PTM.
@@ -212,19 +236,12 @@ struct etm_config {
  * @csdev:	component vitals needed by the framework.
  * @spinlock:	only one at a time pls.
  * @cpu:	the cpu this component is affined to.
- * @port_size:	port size as reported by ETMCR bit 4-6 and 21.
  * @arch:	ETM/PTM version number.
+ * @caps:	ETM capabilities.
  * @use_cpu14:	true if management registers need to be accessed via CP14.
  * @sticky_enable: true if ETM base configuration has been done.
  * @boot_enable:true if we should start tracing at boot time.
  * @os_unlock:	true if access to management registers is allowed.
- * @nr_addr_cmp:Number of pairs of address comparators as found in ETMCCR.
- * @nr_cntr:	Number of counters as found in ETMCCR bit 13-15.
- * @nr_ext_inp:	Number of external input as found in ETMCCR bit 17-19.
- * @nr_ext_out:	Number of external output as found in ETMCCR bit 20-22.
- * @nr_ctxid_cmp: Number of contextID comparators as found in ETMCCR bit 24-25.
- * @etmccr:	value of register ETMCCR.
- * @etmccer:	value of register ETMCCER.
  * @traceid:	value of the current ID for this component.
  * @curr_config:	structure holding current running configuration.
  * @config:	structure holding sysfs mode configuration.
@@ -235,19 +252,12 @@ struct etm_drvdata {
 	struct coresight_device		*csdev;
 	spinlock_t			spinlock;
 	int				cpu;
-	int				port_size;
 	u8				arch;
+	struct etm_caps			caps;
 	bool				use_cp14;
 	bool				sticky_enable;
 	bool				boot_enable;
 	bool				os_unlock;
-	u8				nr_addr_cmp;
-	u8				nr_cntr;
-	u8				nr_ext_inp;
-	u8				nr_ext_out;
-	u8				nr_ctxid_cmp;
-	u32				etmccr;
-	u32				etmccer;
 	u32				traceid;
 	struct etm_config		curr_config;
 	struct etm_config		config;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index ac7c154720cb..ca2ba179b6fb 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -308,6 +308,7 @@ void etm_config_trace_mode(struct etm_config *config)
 static int etm_parse_event_config(struct etm_drvdata *drvdata,
 				  struct perf_event *event)
 {
+	const struct etm_caps *caps = &drvdata->caps;
 	struct etm_config *config = &drvdata->curr_config;
 	struct perf_event_attr *attr = &event->attr;
 	u8 ts_level;
@@ -356,8 +357,7 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 	 * has ret stack) on the same SoC. So only enable when it can be honored
 	 * - trace will still continue normally otherwise.
 	 */
-	if (ATTR_CFG_GET_FLD(attr, retstack) &&
-	    (drvdata->etmccer & ETMCCER_RETSTACK))
+	if (ATTR_CFG_GET_FLD(attr, retstack) && (caps->retstack))
 		config->ctrl |= ETMCR_RETURN_STACK;
 
 	return 0;
@@ -367,6 +367,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 {
 	int i, rc;
 	u32 etmcr;
+	const struct etm_caps *caps = &drvdata->caps;
 	struct etm_config *config = &drvdata->curr_config;
 	struct coresight_device *csdev = drvdata->csdev;
 
@@ -388,7 +389,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	etmcr = etm_readl(drvdata, ETMCR);
 	/* Clear setting from a previous run if need be */
 	etmcr &= ~ETM3X_SUPPORTED_OPTIONS;
-	etmcr |= drvdata->port_size;
+	etmcr |= caps->port_size;
 	etmcr |= ETMCR_ETM_EN;
 	etm_writel(drvdata, config->ctrl | etmcr, ETMCR);
 	etm_writel(drvdata, config->trigger_event, ETMTRIGGER);
@@ -396,11 +397,11 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	etm_writel(drvdata, config->enable_event, ETMTEEVR);
 	etm_writel(drvdata, config->enable_ctrl1, ETMTECR1);
 	etm_writel(drvdata, config->fifofull_level, ETMFFLR);
-	for (i = 0; i < drvdata->nr_addr_cmp; i++) {
+	for (i = 0; i < caps->nr_addr_cmp; i++) {
 		etm_writel(drvdata, config->addr_val[i], ETMACVRn(i));
 		etm_writel(drvdata, config->addr_acctype[i], ETMACTRn(i));
 	}
-	for (i = 0; i < drvdata->nr_cntr; i++) {
+	for (i = 0; i < caps->nr_cntr; i++) {
 		etm_writel(drvdata, config->cntr_rld_val[i], ETMCNTRLDVRn(i));
 		etm_writel(drvdata, config->cntr_event[i], ETMCNTENRn(i));
 		etm_writel(drvdata, config->cntr_rld_event[i],
@@ -414,9 +415,9 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	etm_writel(drvdata, config->seq_32_event, ETMSQ32EVR);
 	etm_writel(drvdata, config->seq_13_event, ETMSQ13EVR);
 	etm_writel(drvdata, config->seq_curr_state, ETMSQR);
-	for (i = 0; i < drvdata->nr_ext_out; i++)
+	for (i = 0; i < caps->nr_ext_out; i++)
 		etm_writel(drvdata, ETM_DEFAULT_EVENT_VAL, ETMEXTOUTEVRn(i));
-	for (i = 0; i < drvdata->nr_ctxid_cmp; i++)
+	for (i = 0; i < caps->nr_ctxid_cmp; i++)
 		etm_writel(drvdata, config->ctxid_pid[i], ETMCIDCVRn(i));
 	etm_writel(drvdata, config->ctxid_mask, ETMCIDCMR);
 	etm_writel(drvdata, config->sync_freq, ETMSYNCFR);
@@ -560,6 +561,7 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
 static void etm_disable_hw(struct etm_drvdata *drvdata)
 {
 	int i;
+	const struct etm_caps *caps = &drvdata->caps;
 	struct etm_config *config = &drvdata->curr_config;
 	struct coresight_device *csdev = drvdata->csdev;
 
@@ -569,7 +571,7 @@ static void etm_disable_hw(struct etm_drvdata *drvdata)
 	/* Read back sequencer and counters for post trace analysis */
 	config->seq_curr_state = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
 
-	for (i = 0; i < drvdata->nr_cntr; i++)
+	for (i = 0; i < caps->nr_cntr; i++)
 		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
 
 	etm_set_pwrdwn(drvdata);
@@ -624,6 +626,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
 static void etm_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	const struct etm_caps *caps = &drvdata->caps;
 	struct etm_config *config = &drvdata->config;
 	const struct etm_config *curr_config = &drvdata->curr_config;
 	int i;
@@ -639,7 +642,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	 * Userspace may read seq_curr_state and cntr_val through sysfs
 	 * after the sysfs-session has been disabled.
 	 */
-	for (i = 0; i < drvdata->nr_cntr; i++)
+	for (i = 0; i < caps->nr_cntr; i++)
 		config->cntr_val[i] = curr_config->cntr_val[i];
 
 	config->seq_curr_state = curr_config->seq_curr_state;
@@ -724,7 +727,9 @@ static void etm_init_arch_data(void *info)
 {
 	u32 etmidr;
 	u32 etmccr;
+	u32 etmccer;
 	struct etm_drvdata *drvdata = info;
+	struct etm_caps *caps = &drvdata->caps;
 
 	/* Make sure all registers are accessible */
 	etm_os_unlock(drvdata);
@@ -749,16 +754,19 @@ static void etm_init_arch_data(void *info)
 	/* Find all capabilities */
 	etmidr = etm_readl(drvdata, ETMIDR);
 	drvdata->arch = BMVAL(etmidr, 4, 11);
-	drvdata->port_size = etm_readl(drvdata, ETMCR) & PORT_SIZE_MASK;
+	caps->port_size = etm_readl(drvdata, ETMCR) & PORT_SIZE_MASK;
+
+	etmccer = etm_readl(drvdata, ETMCCER);
+	caps->timestamp = !!(etmccer & ETMCCER_TIMESTAMP);
+	caps->retstack = !!(etmccer & ETMCCER_RETSTACK);
 
-	drvdata->etmccer = etm_readl(drvdata, ETMCCER);
 	etmccr = etm_readl(drvdata, ETMCCR);
-	drvdata->etmccr = etmccr;
-	drvdata->nr_addr_cmp = BMVAL(etmccr, 0, 3) * 2;
-	drvdata->nr_cntr = BMVAL(etmccr, 13, 15);
-	drvdata->nr_ext_inp = BMVAL(etmccr, 17, 19);
-	drvdata->nr_ext_out = BMVAL(etmccr, 20, 22);
-	drvdata->nr_ctxid_cmp = BMVAL(etmccr, 24, 25);
+	caps->fifofull = !!(etmccr & ETMCCR_FIFOFULL);
+	caps->nr_addr_cmp = BMVAL(etmccr, 0, 3) * 2;
+	caps->nr_cntr = BMVAL(etmccr, 13, 15);
+	caps->nr_ext_inp = BMVAL(etmccr, 17, 19);
+	caps->nr_ext_out = BMVAL(etmccr, 20, 22);
+	caps->nr_ctxid_cmp = BMVAL(etmccr, 24, 25);
 
 	coresight_clear_self_claim_tag_unlocked(&drvdata->csa);
 	etm_set_pwrdwn(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 284998f18017..c27865d719eb 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -53,8 +53,9 @@ static ssize_t nr_addr_cmp_show(struct device *dev,
 {
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etm_caps *caps = &drvdata->caps;
 
-	val = drvdata->nr_addr_cmp;
+	val = caps->nr_addr_cmp;
 	return sprintf(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_addr_cmp);
@@ -63,8 +64,9 @@ static ssize_t nr_cntr_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etm_caps *caps = &drvdata->caps;
 
-	val = drvdata->nr_cntr;
+	val = caps->nr_cntr;
 	return sprintf(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_cntr);
@@ -75,7 +77,7 @@ static ssize_t nr_ctxid_cmp_show(struct device *dev,
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	val = drvdata->nr_ctxid_cmp;
+	val = drvdata->caps.nr_ctxid_cmp;
 	return sprintf(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_ctxid_cmp);
@@ -117,7 +119,7 @@ static ssize_t reset_store(struct device *dev,
 		memset(config, 0, sizeof(struct etm_config));
 		config->mode = ETM_MODE_EXCLUDE;
 		config->trigger_event = ETM_DEFAULT_EVENT_VAL;
-		for (i = 0; i < drvdata->nr_addr_cmp; i++) {
+		for (i = 0; i < drvdata->caps.nr_addr_cmp; i++) {
 			config->addr_type[i] = ETM_ADDR_TYPE_NONE;
 		}
 
@@ -148,6 +150,7 @@ static ssize_t mode_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etm_caps *caps = &drvdata->caps;
 	struct etm_config *config = &drvdata->config;
 
 	ret = kstrtoul(buf, 16, &val);
@@ -168,7 +171,7 @@ static ssize_t mode_store(struct device *dev,
 		config->ctrl &= ~ETMCR_CYC_ACC;
 
 	if (config->mode & ETM_MODE_STALL) {
-		if (!(drvdata->etmccr & ETMCCR_FIFOFULL)) {
+		if (!caps->fifofull) {
 			dev_warn(dev, "stall mode not supported\n");
 			ret = -EINVAL;
 			goto err_unlock;
@@ -178,7 +181,7 @@ static ssize_t mode_store(struct device *dev,
 		config->ctrl &= ~ETMCR_STALL_MODE;
 
 	if (config->mode & ETM_MODE_TIMESTAMP) {
-		if (!(drvdata->etmccer & ETMCCER_TIMESTAMP)) {
+		if (!caps->timestamp) {
 			dev_warn(dev, "timestamp not supported\n");
 			ret = -EINVAL;
 			goto err_unlock;
@@ -323,13 +326,14 @@ static ssize_t addr_idx_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etm_caps *caps = &drvdata->caps;
 	struct etm_config *config = &drvdata->config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	if (val >= drvdata->nr_addr_cmp)
+	if (val >= caps->nr_addr_cmp)
 		return -EINVAL;
 
 	/*
@@ -626,13 +630,14 @@ static ssize_t cntr_idx_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etm_caps *caps = &drvdata->caps;
 	struct etm_config *config = &drvdata->config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	if (val >= drvdata->nr_cntr)
+	if (val >= caps->nr_cntr)
 		return -EINVAL;
 	/*
 	 * Use spinlock to ensure index doesn't change while it gets
@@ -1033,13 +1038,14 @@ static ssize_t ctxid_idx_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etm_caps *caps = &drvdata->caps;
 	struct etm_config *config = &drvdata->config;
 
 	ret = kstrtoul(buf, 16, &val);
 	if (ret)
 		return ret;
 
-	if (val >= drvdata->nr_ctxid_cmp)
+	if (val >= caps->nr_ctxid_cmp)
 		return -EINVAL;
 
 	/*

-- 
2.43.0

