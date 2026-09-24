Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A8B4C1516
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 17:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271280; cv=none; b=QvUmPxTM1M2JsX2YovUNPLjCt8Wd0CJsIitAwEEL3w/F9qzYyOyhNZacMPUj6DVTSNeNW2mbotgLmY3legskkGjqp1Kw/PKJEpQvdKZ4hKtrmwib0GFqDdfBzedKYHxFB9kkNz6/ZRi+cHSo2qugh59CeP/SwF398/LTeqOqW6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271280; c=relaxed/simple;
	bh=PpJ12IQWQJ/3/nUgcEIg8UT/GJKx3P6fafIIekBm3Sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p3UdEKs7QE9q9WPIZ72KwFiTQnV3t5UTV9T4awagHPQPTka49tWIwEkZAt6BIV9JftvQB9zX7dA8ySzRQxE2JIxBzG/Q08vv/H6QphrZe/8oofhpRjH/gunSVeX0k6I6zFwPHIYSsb8GJ/3K20cL+g74ogephivd9iyTr79qHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Tag/Pz/g; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Tag/Pz/g"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7A7531E4D;
	Thu, 24 Sep 2026 10:34:34 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A143B3F86F;
	Thu, 24 Sep 2026 10:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790271277; bh=PpJ12IQWQJ/3/nUgcEIg8UT/GJKx3P6fafIIekBm3Sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tag/Pz/gU2ZOS9lrdcOWwYFJ8aPYi5umlOt3m/2aP4bnEvBRCcOtg7xE1nLkhRBzf
	 UQgF0amtjYRwOSIvBbPMjc355dO42g8Kt9j1VFwdQfpgWnDp4Qq4nSjxfMCLzk945s
	 jP3ftAwDDLUiDCfGi/e/yXy/bsKjU7SuqwnL+R5w=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Thu, 24 Sep 2026 18:33:47 +0100
Subject: [PATCH v12 09/14] coresight: etm4x: remove s_ex_level from config
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-separate_etm_cfg_v2-v12-9-a2b41d2f7c2b@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10229; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=PpJ12IQWQJ/3/nUgcEIg8UT/GJKx3P6fafIIekBm3Sk=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqtV8QAJnQ1f5iDZqJzzFUp6IEPOG+2deL1+JL5
 IIGYDhOt+KJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarVfEAAKCRBt1cPRWsUx
 M7ApDADMu2XetH6MUper+ngaLoTNTOxOu9E/2pomYKQllZ7/g9v3TCT7+YxERvVDkBMHuZmt+7I
 7hG01o5BfnURJ303IZscL6TTIPIFn43I7MLhWdx55Kc4N+Jyw25PPqc4jRca2oRDv7+jA/FQw4p
 JHPLvHkA72R413nQIYb7niI62TQiraiP4IYrU6kSJbK8jxjxo9VlqixvNeNh5qusFYoQlamIWGv
 jer2WpCDrKto/kv8GfLb6wt6HUtSp3bgLWY/AJYtohen3Fnb6IvVoFIvSnWkNIZmWl04+yo7UaF
 O+Z2h2IQyC280yqA1ZtQKG/NEICbOjlRSPB8aEl3wk2VkK7YGnmph6bNUO4u+Ax57FPNcWsGZFE
 VCjbgI3/i7b+FeqvgIC7ZgtrSc11hbmEQ25ilRxpdUzkpDfqXwwPFlNSsqU6VGJWeyM/pFmGCq3
 RJKTRlOtCMMrTwvjsHvVpqwX3fpY43HxTVkBeP/Eb8sm+4GGc49v9tGLTqlilkpm+Fuls=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

s_ex_level is a hardware capability rather than a configurable parameter.
As such, it should not be stored in the configuration structure.

Remove s_ex_level from the config structure and pass etm4_caps to the
functions that need to access this capability.

Reviewed-by: Mike Leach <mike.leach@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 58 +++++++++++++---------
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  2 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |  5 +-
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 4a8c1070bbcb..99d4e2d39e66 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -66,10 +66,12 @@ MODULE_PARM_DESC(pm_save_enable,
 	"Save/restore state on power down: 1 = never, 2 = self-hosted. MMIO and DT only.");
 
 static struct etmv4_drvdata *etmdrvdata[NR_CPUS];
-static void etm4_set_default_config(struct etmv4_config *config);
+static void etm4_set_default_config(struct etmv4_config *config,
+				    const struct etmv4_caps *caps);
 static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 				  struct perf_event *event);
-static u64 etm4_get_access_type(struct etmv4_config *config);
+static u64 etm4_get_access_type(struct etmv4_config *config,
+				const struct etmv4_caps *caps);
 
 static enum cpuhp_state hp_online;
 
@@ -800,7 +802,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 		config->mode |= ETM_MODE_EXCL_GUEST;
 
 	/* Always start from the default config */
-	etm4_set_default_config(config);
+	etm4_set_default_config(config, caps);
 
 	/* Configure filters specified on the perf cmd line, if any. */
 	ret = etm4_set_event_filters(drvdata, event);
@@ -1474,7 +1476,6 @@ static void etm4_init_arch_data(void *info)
 
 	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
 	caps->s_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_S_MASK, etmidr3);
-	drvdata->config.s_ex_level = caps->s_ex_level;
 	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
 	caps->ns_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_NS_MASK, etmidr3);
 	/*
@@ -1557,19 +1558,22 @@ static void etm4_init_arch_data(void *info)
 	cpu_detect_trace_filtering(drvdata);
 }
 
-static u32 etm4_get_victlr_access_type(struct etmv4_config *config)
+static u32 etm4_get_victlr_access_type(struct etmv4_config *config,
+				       const struct etmv4_caps *caps)
 {
-	return etm4_get_access_type(config) << __bf_shf(TRCVICTLR_EXLEVEL_MASK);
+	return etm4_get_access_type(config, caps) << __bf_shf(TRCVICTLR_EXLEVEL_MASK);
 }
 
 /* Set ELx trace filter access in the TRCVICTLR register */
-static void etm4_set_victlr_access(struct etmv4_config *config)
+static void etm4_set_victlr_access(struct etmv4_config *config,
+			           const struct etmv4_caps *caps)
 {
 	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_MASK;
-	config->vinst_ctrl |= etm4_get_victlr_access_type(config);
+	config->vinst_ctrl |= etm4_get_victlr_access_type(config, caps);
 }
 
-static void etm4_set_default_config(struct etmv4_config *config)
+static void etm4_set_default_config(struct etmv4_config *config,
+			            const struct etmv4_caps *caps)
 {
 	/* disable all events tracing */
 	config->eventctrl0 = 0x0;
@@ -1588,7 +1592,7 @@ static void etm4_set_default_config(struct etmv4_config *config)
 	config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
 
 	/* TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering */
-	etm4_set_victlr_access(config);
+	etm4_set_victlr_access(config, caps);
 }
 
 static u64 etm4_get_ns_access_type(struct etmv4_config *config)
@@ -1620,21 +1624,24 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
  * This must be shifted to the corresponding register field
  * for usage.
  */
-static u64 etm4_get_access_type(struct etmv4_config *config)
+static u64 etm4_get_access_type(struct etmv4_config *config,
+				const struct etmv4_caps *caps)
 {
 	/* All Secure exception levels are excluded from the trace */
-	return etm4_get_ns_access_type(config) | (u64)config->s_ex_level;
+	return etm4_get_ns_access_type(config) | (u64)caps->s_ex_level;
 }
 
-static u64 etm4_get_comparator_access_type(struct etmv4_config *config)
+static u64 etm4_get_comparator_access_type(struct etmv4_config *config,
+					   const struct etmv4_caps *caps)
 {
-	return etm4_get_access_type(config) << TRCACATR_EXLEVEL_SHIFT;
+	return etm4_get_access_type(config, caps) << TRCACATR_EXLEVEL_SHIFT;
 }
 
 static void etm4_set_comparator_filter(struct etmv4_config *config,
+				       const struct etmv4_caps *caps,
 				       u64 start, u64 stop, int comparator)
 {
-	u64 access_type = etm4_get_comparator_access_type(config);
+	u64 access_type = etm4_get_comparator_access_type(config, caps);
 
 	/* First half of default address comparator */
 	config->addr_val[comparator] = start;
@@ -1665,11 +1672,12 @@ static void etm4_set_comparator_filter(struct etmv4_config *config,
 }
 
 static void etm4_set_start_stop_filter(struct etmv4_config *config,
+				       const struct etmv4_caps *caps,
 				       u64 address, int comparator,
 				       enum etm_addr_type type)
 {
 	int shift;
-	u64 access_type = etm4_get_comparator_access_type(config);
+	u64 access_type = etm4_get_comparator_access_type(config, caps);
 
 	/* Configure the comparator */
 	config->addr_val[comparator] = address;
@@ -1701,7 +1709,8 @@ static void etm4_set_default_filter(struct etmv4_config *config)
 	config->vissctlr = 0x0;
 }
 
-static void etm4_set_default(struct etmv4_config *config)
+static void etm4_set_default(struct etmv4_config *config,
+			     const struct etmv4_caps *caps)
 {
 	if (WARN_ON_ONCE(!config))
 		return;
@@ -1713,7 +1722,7 @@ static void etm4_set_default(struct etmv4_config *config)
 	 * full instruction trace - with a default filter for trace all
 	 * achieved by having no filtering.
 	 */
-	etm4_set_default_config(config);
+	etm4_set_default_config(config, caps);
 	etm4_set_default_filter(config);
 }
 
@@ -1761,6 +1770,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 {
 	int i, comparator, ret = 0;
 	u64 address;
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->curr_config;
 	struct etm_filters *filters = event->hw.addr_filters;
 
@@ -1790,7 +1800,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 
 		switch (type) {
 		case ETM_ADDR_TYPE_RANGE:
-			etm4_set_comparator_filter(config,
+			etm4_set_comparator_filter(config, caps,
 						   filter->start_addr,
 						   filter->stop_addr,
 						   comparator);
@@ -1811,7 +1821,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 				   filter->stop_addr);
 
 			/* Configure comparator */
-			etm4_set_start_stop_filter(config, address,
+			etm4_set_start_stop_filter(config, caps, address,
 						   comparator, type);
 
 			/*
@@ -1847,7 +1857,8 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 	return ret;
 }
 
-void etm4_config_trace_mode(struct etmv4_config *config)
+void etm4_config_trace_mode(struct etmv4_config *config,
+			    const struct etmv4_caps *caps)
 {
 	u32 mode;
 
@@ -1861,7 +1872,7 @@ void etm4_config_trace_mode(struct etmv4_config *config)
 	if (!(mode & ETM_MODE_EXCL_KERN) && !(mode & ETM_MODE_EXCL_USER))
 		return;
 
-	etm4_set_victlr_access(config);
+	etm4_set_victlr_access(config, caps);
 }
 
 static int etm4_online_cpu(unsigned int cpu)
@@ -2173,6 +2184,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 	struct coresight_platform_data *pdata = NULL;
 	struct device *dev = init_arg->dev;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct coresight_desc desc = { 0 };
 	u8 major, minor;
 	char *type_name;
@@ -2202,7 +2214,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 	if (!desc.name)
 		return -ENOMEM;
 
-	etm4_set_default(&drvdata->config);
+	etm4_set_default(&drvdata->config, caps);
 
 	if (etm4x_always_pm_save(dev, init_arg->csa))
 		pm_save = true;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a66f34c942ba..8f5ea8edf5d8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -443,7 +443,7 @@ static ssize_t mode_store(struct device *dev,
 		config->vinst_ctrl &= ~TRCVICTLR_TRCERR;
 
 	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
-		etm4_config_trace_mode(config);
+		etm4_config_trace_mode(config, caps);
 
 	raw_spin_unlock(&drvdata->spinlock);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 67071f7cbdbc..ae97c5c004bf 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -956,7 +956,6 @@ struct etmv4_caps {
  * @vmid_mask0:	VM ID comparator mask for comparator 0-3.
  * @vmid_mask1:	VM ID comparator mask for comparator 4-7.
  * @ext_inp:	External input selection.
- * @s_ex_level: Secure ELs where tracing is supported.
  */
 struct etmv4_config {
 	u64				mode;
@@ -999,7 +998,6 @@ struct etmv4_config {
 	u32				vmid_mask0;
 	u32				vmid_mask1;
 	u32				ext_inp;
-	u8				s_ex_level;
 };
 
 /**
@@ -1117,7 +1115,8 @@ enum etm_addr_ctxtype {
 };
 
 extern const struct attribute_group *coresight_etmv4_groups[];
-void etm4_config_trace_mode(struct etmv4_config *config);
+void etm4_config_trace_mode(struct etmv4_config *config,
+			    const struct etmv4_caps *caps);
 
 u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit);
 void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit);

-- 
2.43.0

