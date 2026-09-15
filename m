Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4840B4A5EAA
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 11:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472117; cv=none; b=D8rNRsRO7aWz7PFXHlqjeOV+7guIIhLu9b/uDiIxoMMklegXbkmFPt2EV0b9r40a+KMyYT09xIoQM46q1H2hGJUGrk41RYuymLTLD0BT7y3n0JQug91zR3ILzre/Xd4fj5bNFGEpbM6fVNkxGg746k3HF7X7X4nZz3uexWLWfIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472117; c=relaxed/simple;
	bh=zO7pbNNdvVY9biP0avSl3GlDcgZXaeVSDchAt+brQzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F9+tHUeRznNyHxJmXmogww8VGXhtcR7QMJ9fQHvRXlIR4LgqT3l0IhGWbuP+HqL9ahoeN7BT/MSePqtOcqWAXgW+GC61OtVyRxabtLbV9qcOxVA7wlFHSziLdt1WGzhJjMGzm/v4zcG2LLKul3HiRpjr6PsEOYeDh0eWd5Ac25E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W1pmFuKq; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="W1pmFuKq"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9606D1D70;
	Tue, 15 Sep 2026 04:35:02 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 797F53F86F;
	Tue, 15 Sep 2026 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789472106; bh=zO7pbNNdvVY9biP0avSl3GlDcgZXaeVSDchAt+brQzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W1pmFuKqVIujO72GYkWJsAU8PafO8pxi07iqmeM6y0JjdjU/UYTSRnlZE1lECX3FM
	 x32tMQqlakrW5XQDcRRYlkszZe6yG2EdlG2YenUr+zDj9ajhLCvY0HHpbLaDdNBTHu
	 3BZZhK5z/xBndjkz806OOE7XeFs5PK2HMhfFmWo8=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Tue, 15 Sep 2026 12:34:43 +0100
Subject: [PATCH v11 8/9] coresight: etm4x: remove s_ex_level from config
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-separate_etm_cfg_v2-v11-8-d2b258d51747@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10153; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=zO7pbNNdvVY9biP0avSl3GlDcgZXaeVSDchAt+brQzk=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqqS1WdPEiP3LYiv2KdGayqx1uYtxVjqNVSD1ZH
 130nVCNWy6JAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqktVgAKCRBt1cPRWsUx
 M632DADJxeBDu3iG8qQB/Gf113sreIiwivBF+67UuJ0zv5Eo4RaaIPrnYO3ZSWZW8MB5zc9Vijq
 famJVesGT+q5g9Q2tk4brztquNo8OHkaJWXPg7YdaDGCW6Xxw/H4YheuNn8loPWF2iY7mcziiJ8
 bNhcW2TaxI+bf0DzgeRj4sYa/QCXdRqzX5Zl84REvsG5RJBSq9vkrRV6YREPjkZfBJjIc3hW52k
 2MdUta4LA97fWpKsttzLDhNQTLLHXSrKwQT/GHGXBilC/V7UBvUAYNyElUpGAYy6tKh6a+BowMr
 Z+NhTl6s7bQr2qvx8yy4njjZRw0aJ5OaZOk33UwGZ0now/oK1SXZZbzVWOP54qhbKOyU8OoRjsk
 b4O0dZu381wxh5D+2FkdQtz0PbBs9ZQiAbzaOP9zBU5+Q0v18n4Lrw4/mxFiZkWOwKHXrMtOBrQ
 nQfAwsNm67TXB9TwA5Mt2hA2WNraUhGmHYXZGq9V1a4gJLJpL6Xonx8Tgscaj1XtBt5x8=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

s_ex_level is a hardware capability rather than a configurable parameter.
As such, it should not be stored in the configuration structure.

Remove s_ex_level from the config structure and pass etm4_caps to the
functions that need to access this capability.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 58 +++++++++++++---------
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  2 +-
 drivers/hwtracing/coresight/coresight-etm4x.h      |  5 +-
 3 files changed, 38 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 9de0c268ff954..e484e12572732 100644
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
 
@@ -803,7 +805,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 		config->mode |= ETM_MODE_EXCL_GUEST;
 
 	/* Always start from the default config */
-	etm4_set_default_config(config);
+	etm4_set_default_config(config, caps);
 
 	/* Configure filters specified on the perf cmd line, if any. */
 	ret = etm4_set_event_filters(drvdata, event);
@@ -1471,7 +1473,6 @@ static void etm4_init_arch_data(void *info)
 
 	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
 	caps->s_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_S_MASK, etmidr3);
-	drvdata->config.s_ex_level = caps->s_ex_level;
 	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
 	caps->ns_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_NS_MASK, etmidr3);
 	/*
@@ -1556,19 +1557,22 @@ static void etm4_init_arch_data(void *info)
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
@@ -1587,7 +1591,7 @@ static void etm4_set_default_config(struct etmv4_config *config)
 	config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
 
 	/* TRCVICTLR::EXLEVEL_NS:EXLEVELS: Set kernel / user filtering */
-	etm4_set_victlr_access(config);
+	etm4_set_victlr_access(config, caps);
 }
 
 static u64 etm4_get_ns_access_type(struct etmv4_config *config)
@@ -1619,21 +1623,24 @@ static u64 etm4_get_ns_access_type(struct etmv4_config *config)
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
@@ -1664,11 +1671,12 @@ static void etm4_set_comparator_filter(struct etmv4_config *config,
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
@@ -1700,7 +1708,8 @@ static void etm4_set_default_filter(struct etmv4_config *config)
 	config->vissctlr = 0x0;
 }
 
-static void etm4_set_default(struct etmv4_config *config)
+static void etm4_set_default(struct etmv4_config *config,
+			     const struct etmv4_caps *caps)
 {
 	if (WARN_ON_ONCE(!config))
 		return;
@@ -1712,7 +1721,7 @@ static void etm4_set_default(struct etmv4_config *config)
 	 * full instruction trace - with a default filter for trace all
 	 * achieved by having no filtering.
 	 */
-	etm4_set_default_config(config);
+	etm4_set_default_config(config, caps);
 	etm4_set_default_filter(config);
 }
 
@@ -1760,6 +1769,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 {
 	int i, comparator, ret = 0;
 	u64 address;
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->active_config;
 	struct etm_filters *filters = event->hw.addr_filters;
 
@@ -1789,7 +1799,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 
 		switch (type) {
 		case ETM_ADDR_TYPE_RANGE:
-			etm4_set_comparator_filter(config,
+			etm4_set_comparator_filter(config, caps,
 						   filter->start_addr,
 						   filter->stop_addr,
 						   comparator);
@@ -1810,7 +1820,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 				   filter->stop_addr);
 
 			/* Configure comparator */
-			etm4_set_start_stop_filter(config, address,
+			etm4_set_start_stop_filter(config, caps, address,
 						   comparator, type);
 
 			/*
@@ -1846,7 +1856,8 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 	return ret;
 }
 
-void etm4_config_trace_mode(struct etmv4_config *config)
+void etm4_config_trace_mode(struct etmv4_config *config,
+			    const struct etmv4_caps *caps)
 {
 	u32 mode;
 
@@ -1860,7 +1871,7 @@ void etm4_config_trace_mode(struct etmv4_config *config)
 	if (!(mode & ETM_MODE_EXCL_KERN) && !(mode & ETM_MODE_EXCL_USER))
 		return;
 
-	etm4_set_victlr_access(config);
+	etm4_set_victlr_access(config, caps);
 }
 
 static int etm4_online_cpu(unsigned int cpu)
@@ -2172,6 +2183,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 	struct coresight_platform_data *pdata = NULL;
 	struct device *dev = init_arg->dev;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct coresight_desc desc = { 0 };
 	u8 major, minor;
 	char *type_name;
@@ -2201,7 +2213,7 @@ static int etm4_add_coresight_dev(struct etm4_init_arg *init_arg)
 	if (!desc.name)
 		return -ENOMEM;
 
-	etm4_set_default(&drvdata->config);
+	etm4_set_default(&drvdata->config, caps);
 
 	if (etm4x_always_pm_save(dev, init_arg->csa))
 		pm_save = true;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 50ef2e957300f..d826033d52e24 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -443,7 +443,7 @@ static ssize_t mode_store(struct device *dev,
 		config->vinst_ctrl &= ~TRCVICTLR_TRCERR;
 
 	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
-		etm4_config_trace_mode(config);
+		etm4_config_trace_mode(config, caps);
 
 	raw_spin_unlock(&drvdata->spinlock);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 8c1c1364b1c44..f252da868b6de 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -955,7 +955,6 @@ struct etmv4_caps {
  * @vmid_mask0:	VM ID comparator mask for comparator 0-3.
  * @vmid_mask1:	VM ID comparator mask for comparator 4-7.
  * @ext_inp:	External input selection.
- * @s_ex_level: Secure ELs where tracing is supported.
  */
 struct etmv4_config {
 	u64				mode;
@@ -998,7 +997,6 @@ struct etmv4_config {
 	u32				vmid_mask0;
 	u32				vmid_mask1;
 	u32				ext_inp;
-	u8				s_ex_level;
 };
 
 /**
@@ -1116,7 +1114,8 @@ enum etm_addr_ctxtype {
 };
 
 extern const struct attribute_group *coresight_etmv4_groups[];
-void etm4_config_trace_mode(struct etmv4_config *config);
+void etm4_config_trace_mode(struct etmv4_config *config,
+			    const struct etmv4_caps *caps);
 
 u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit);
 void etm4x_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit);

-- 
2.43.0

