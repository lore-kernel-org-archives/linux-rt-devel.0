Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923BA4C8C69
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 11:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472114; cv=none; b=YX58rV+qXKEgQyjRS8iBkZeEAMBTQLbizFOtSfgv7SeGDx1meyaLYmmav0WnN+/UtrChM9tMfX/aC3+IiiZBFuz/op9PGGRgKVUTj1oF9bNPaIylFayfaMl91viyWse+Seat05xJuMnRiZhLYEZa3+MyEO2nMRld8yaK/wbbx50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472114; c=relaxed/simple;
	bh=9vFo4hnMR5+AhjFk+/52PTzwWoe1InzOlQNdEDD6ER4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pvl1fjxWwq4SMPzwVF6tPPc/WrQ4hQFBSvn+7VLlQJ7PL4zj9yEKllMnKV+9SA5UyZNeOc5pzhxtzs7l4C2kP6LCWmdzkGtmf5HMQrcXXsKI1v0Vy+k2qUPVm2bv+WPgxHy/06j4Z4BWSI2TWbQsTBFiM8bexPkUR1hckVceXCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ub37UzNg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ub37UzNg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97503169E;
	Tue, 15 Sep 2026 04:35:04 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A3953F86F;
	Tue, 15 Sep 2026 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789472108; bh=9vFo4hnMR5+AhjFk+/52PTzwWoe1InzOlQNdEDD6ER4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ub37UzNgGwyYp4BbSNjAUyKUl81v+Z6f0YwVQysu7HJhjUy51h2hnSRhhY2zQa1Gw
	 oFTo+cgfbcS0I2AwlEAlQ2ZWCEEOgC8pe69UfwUTb1wStAqrmk7SeHT91lOZAGnGKX
	 fIFMI7aue7Uiovmnv817lxMtd7K+n8POLzuTRAMA=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Tue, 15 Sep 2026 12:34:44 +0100
Subject: [PATCH v11 9/9] coresight: etm3x: introduce struct etm_caps
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-separate_etm_cfg_v2-v11-9-d2b258d51747@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13802; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=9vFo4hnMR5+AhjFk+/52PTzwWoe1InzOlQNdEDD6ER4=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqqS1XS8HWKXiLmQhnTp4AEpQjud/CX5MjcBq8U
 XtEnfMBWjiJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqktVwAKCRBt1cPRWsUx
 M9I+C/9jdwg+q6bJMzx0xB58MQgBBEZtjiKhSw1vWSITDIrIHb/O0pptRecvfXq3V22sErBzq4U
 Gr+oosAlU7H4aII7t5ETEyoAA7COXic7XKQVip2k01G95aXsU+6WvX3+KrsCIg1W6bFt8GJOAGf
 HSb94OaIgJdZY/RfuSTq83CeR91YKBVsRNc+7+Cw/05Gtu0GKSu0cHrFsH98ylGzb1xHaSOqe9a
 Ox9Svsd71v/yQJbBYq7MuNeuivLxkudc8vQ95PdBb1AwLoF6D9jiQsE2d5UOe7MEafwV4fFs2a3
 pIJK6mfBE5EXeH0sUhMr4310X7/0iRVLKUMxBBwhYXcbgpLTFeYcBiQ+ZJCnhbgh8f/ZM29sxF0
 +8Ibosp+WBhDLukxRj/r1BzQLlHkZK/GcEVOD9Ius5sg60WxgdIeSnhfKHHqmXidRPCmsLQb+ls
 aodS6RAVo55MBP2iRteFngV7nVgeY09uhoXLjBO1w4QD/wKhUGWwM2Y+BjS/hhYlGZ1ms=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

Introduce struct etm_caps to describe ETMv3 capabilities
and move capabilities information into it.

Since drvdata->etmccr and drvdata->etmccer are used to check
whether it supports fifofull logic and timestamping,
remove etmccr and etmccer field from drvdata and add relevant fields
in etm_caps structure.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm.h        | 42 +++++++++++++---------
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 42 +++++++++++++---------
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 24 ++++++++-----
 3 files changed, 66 insertions(+), 42 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index f3796162168d4..cb5f18dcdd974 100644
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
  * @active_config:	structure holding current running configuration.
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
 	struct etm_config		active_config;
 	struct etm_config		config;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 12bb38dc596e7..79c7cbe2084de 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -308,6 +308,7 @@ void etm_config_trace_mode(struct etm_config *config)
 static int etm_parse_event_config(struct etm_drvdata *drvdata,
 				  struct perf_event *event)
 {
+	const struct etm_caps *caps = &drvdata->caps;
 	struct etm_config *config = &drvdata->active_config;
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
 	struct etm_config *config = &drvdata->active_config;
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
@@ -562,6 +563,7 @@ static int etm_enable(struct coresight_device *csdev, struct perf_event *event,
 static void etm_disable_hw(struct etm_drvdata *drvdata)
 {
 	int i;
+	const struct etm_caps *caps = &drvdata->caps;
 	struct etm_config *config = &drvdata->active_config;
 	struct coresight_device *csdev = drvdata->csdev;
 
@@ -571,7 +573,7 @@ static void etm_disable_hw(struct etm_drvdata *drvdata)
 	/* Read back sequencer and counters for post trace analysis */
 	config->seq_curr_state = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
 
-	for (i = 0; i < drvdata->nr_cntr; i++)
+	for (i = 0; i < caps->nr_cntr; i++)
 		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
 
 	etm_set_pwrdwn(drvdata);
@@ -626,6 +628,7 @@ static void etm_disable_perf(struct coresight_device *csdev)
 static void etm_disable_sysfs(struct coresight_device *csdev)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	const struct etm_caps *caps = &drvdata->caps;
 	struct etm_config *config = &drvdata->config;
 	const struct etm_config *active_config = &drvdata->active_config;
 	int i;
@@ -641,7 +644,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	 * Userspace may read seq_curr_state and cntr_val through sysfs
 	 * after the sysfs-session has been disabled.
 	 */
-	for (i = 0; i < drvdata->nr_cntr; i++)
+	for (i = 0; i < caps->nr_cntr; i++)
 		config->cntr_val[i] = active_config->cntr_val[i];
 
 	config->seq_curr_state = active_config->seq_curr_state;
@@ -726,7 +729,9 @@ static void etm_init_arch_data(void *info)
 {
 	u32 etmidr;
 	u32 etmccr;
+	u32 etmccer;
 	struct etm_drvdata *drvdata = info;
+	struct etm_caps *caps = &drvdata->caps;
 
 	/* Make sure all registers are accessible */
 	etm_os_unlock(drvdata);
@@ -751,16 +756,19 @@ static void etm_init_arch_data(void *info)
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
index 2c8c129228589..36d4673537930 100644
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
@@ -115,7 +117,7 @@ static ssize_t reset_store(struct device *dev,
 		memset(config, 0, sizeof(struct etm_config));
 		config->mode = ETM_MODE_EXCLUDE;
 		config->trigger_event = ETM_DEFAULT_EVENT_VAL;
-		for (i = 0; i < drvdata->nr_addr_cmp; i++) {
+		for (i = 0; i < drvdata->caps.nr_addr_cmp; i++) {
 			config->addr_type[i] = ETM_ADDR_TYPE_NONE;
 		}
 
@@ -146,6 +148,7 @@ static ssize_t mode_store(struct device *dev,
 	int ret;
 	unsigned long val;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etm_caps *caps = &drvdata->caps;
 	struct etm_config *config = &drvdata->config;
 
 	ret = kstrtoul(buf, 16, &val);
@@ -166,7 +169,7 @@ static ssize_t mode_store(struct device *dev,
 		config->ctrl &= ~ETMCR_CYC_ACC;
 
 	if (config->mode & ETM_MODE_STALL) {
-		if (!(drvdata->etmccr & ETMCCR_FIFOFULL)) {
+		if (!caps->fifofull) {
 			dev_warn(dev, "stall mode not supported\n");
 			ret = -EINVAL;
 			goto err_unlock;
@@ -176,7 +179,7 @@ static ssize_t mode_store(struct device *dev,
 		config->ctrl &= ~ETMCR_STALL_MODE;
 
 	if (config->mode & ETM_MODE_TIMESTAMP) {
-		if (!(drvdata->etmccer & ETMCCER_TIMESTAMP)) {
+		if (!caps->timestamp) {
 			dev_warn(dev, "timestamp not supported\n");
 			ret = -EINVAL;
 			goto err_unlock;
@@ -321,13 +324,14 @@ static ssize_t addr_idx_store(struct device *dev,
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
@@ -624,13 +628,14 @@ static ssize_t cntr_idx_store(struct device *dev,
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
@@ -1030,13 +1035,14 @@ static ssize_t ctxid_idx_store(struct device *dev,
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

