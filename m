Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06CE3F9F45
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Oct 2026 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967850; cv=none; b=sG7LZkwktTDNwaMkvzvjJ9hT0SMMSQ60zAzzQsKFNRTq0wi5zzCgOgZmwJQuYNLVVBK9Hj/h1mKNSFVyJYgymglhdeMWyLQI0xvk0qoaLm6AsgVB8LRvHiIYNNp4pDjT63DpyQZbMJSyN65ooYxAwgBFAe4CE4ZwhRxVeDhtf4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967850; c=relaxed/simple;
	bh=I5gF1aI6zM3JrpRuocabHDq7OjG3F6Z93bXDNOkqjP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WlGOsIp52TwWfPOEkT7T+trFiU1vLLvmxys5eiTpDQHjKWgzZwTtOIBrwmk7+wFWDhkSpWCNq5U+KaS1F22DnmFABX1AlWZaPphQlhnJxlRcX1sg1TOYXE9WEsf89iP3QrQ/tmcSZvQ2MrOpo0+jn4Ajcf7NlqQ918j/UhRa5/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=avvcxhU2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="avvcxhU2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE3DA143D;
	Fri,  2 Oct 2026 12:04:03 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A8003F85F;
	Fri,  2 Oct 2026 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790967847; bh=I5gF1aI6zM3JrpRuocabHDq7OjG3F6Z93bXDNOkqjP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=avvcxhU28MVqEVvUoMTQo1bZtwcYTMJ9jEURspfp4pgohouBBqbXZ3VADXz1P2fuS
	 5uYKbdkgovqGluPPhzV26L3gra6+7WnZzE/d1/dr2d5smIakjW0j9BrZd/OgkhcmTs
	 JgelBWYRlEYgb1PJYuDlcRPS0L9HZ3qjpFMhx2zw=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 02 Oct 2026 20:03:34 +0100
Subject: [PATCH v13 13/14] coresight: etm3x: rename local config as
 curr_config referring drvdata->curr_config
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-separate_etm_cfg_v2-v13-13-fe429d8d96fb@arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
In-Reply-To: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7366; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=I5gF1aI6zM3JrpRuocabHDq7OjG3F6Z93bXDNOkqjP0=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqwAAG2dYfDJZB8Hm7TNmf9Bl9ljkDpmWm55qg8
 hnTOfZC1RaJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCasAABgAKCRBt1cPRWsUx
 MxBuC/44oxspnDGFWtf1WjYBDgPPz6pqTZZhi+l7tSOlS9oi8XgUizKvO/yhdvbtaf47xSKPwwT
 Vz/qAoWrdtvDBCTZLjaNbromE079kq61hq+VNFAmzFA1MXeUgJdsKAXSM6Fp7jiurORMhQ0WvUh
 8N1wctYC1qvFHvlZoUnhYp0zrq/NbgodSgr+SEz3Y4B7vG4OU3Tbicnq5FdM/UDkoi9Zvviad6F
 Xk7FSjGlMewyu31GXjaPe8FxeHQ/6hu22mkJPITv7AGKwtwX/XZCaPQztQpHfLrOGeI9BVPFx33
 PLM+0MHE370rDhG+a1peuydZ6le3DWAElhN/u2DF8HtvR6njhBhvhPQKuZ8EvUa3Gv8DlVyGISU
 HWzBncMqDu0wEtR40VKYC5VGdVkEt317p8Uo6ITyudM/wjGcgpVGBjj7tfKyMPh+GQywArw5EV6
 uP3ujqMFtmMb8YhSWglIbbWDKLlmXvU7Xdrnu0O0X6hGsrd3hxWJwU3soMciuIeUU4jWY=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

For readability, rename the local config variable to curr_config in
places where it refers to drvdata->curr_config.

Reviewed-by: Mike Leach <mike.leach@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm3x-core.c | 76 +++++++++++-----------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index ca2ba179b6fb..0cad9ecb49b6 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -309,7 +309,7 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 				  struct perf_event *event)
 {
 	const struct etm_caps *caps = &drvdata->caps;
-	struct etm_config *config = &drvdata->curr_config;
+	struct etm_config *curr_config = &drvdata->curr_config;
 	struct perf_event_attr *attr = &event->attr;
 	u8 ts_level;
 
@@ -317,28 +317,28 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 		return -EINVAL;
 
 	/* Clear configuration from previous run */
-	memset(config, 0, sizeof(struct etm_config));
+	memset(curr_config, 0, sizeof(struct etm_config));
 
 	if (attr->exclude_kernel)
-		config->mode = ETM_MODE_EXCL_KERN;
+		curr_config->mode = ETM_MODE_EXCL_KERN;
 
 	if (attr->exclude_user)
-		config->mode = ETM_MODE_EXCL_USER;
+		curr_config->mode = ETM_MODE_EXCL_USER;
 
 	/* Always start from the default config */
-	etm_set_default(config);
+	etm_set_default(curr_config);
 
 	/*
 	 * By default the tracers are configured to trace the whole address
 	 * range.  Narrow the field only if requested by user space.
 	 */
-	if (config->mode)
-		etm_config_trace_mode(config);
+	if (curr_config->mode)
+		etm_config_trace_mode(curr_config);
 
-	config->ctrl = 0;
+	curr_config->ctrl = 0;
 
 	if (ATTR_CFG_GET_FLD(attr, cycacc))
-		config->ctrl |= ETMCR_CYC_ACC;
+		curr_config->ctrl |= ETMCR_CYC_ACC;
 
 	ts_level = max(ATTR_CFG_GET_FLD(attr, timestamp),
 		       ATTR_CFG_GET_FLD(attr, deprecated_timestamp));
@@ -350,7 +350,7 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 	}
 
 	if (ts_level)
-		config->ctrl |= ETMCR_TIMESTAMP_EN;
+		curr_config->ctrl |= ETMCR_TIMESTAMP_EN;
 
 	/*
 	 * Possible to have cores with PTM (supports ret stack) and ETM (never
@@ -358,7 +358,7 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 	 * - trace will still continue normally otherwise.
 	 */
 	if (ATTR_CFG_GET_FLD(attr, retstack) && (caps->retstack))
-		config->ctrl |= ETMCR_RETURN_STACK;
+		curr_config->ctrl |= ETMCR_RETURN_STACK;
 
 	return 0;
 }
@@ -368,7 +368,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	int i, rc;
 	u32 etmcr;
 	const struct etm_caps *caps = &drvdata->caps;
-	struct etm_config *config = &drvdata->curr_config;
+	struct etm_config *curr_config = &drvdata->curr_config;
 	struct coresight_device *csdev = drvdata->csdev;
 
 	CS_UNLOCK(drvdata->csa.base);
@@ -391,39 +391,39 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
 	etmcr &= ~ETM3X_SUPPORTED_OPTIONS;
 	etmcr |= caps->port_size;
 	etmcr |= ETMCR_ETM_EN;
-	etm_writel(drvdata, config->ctrl | etmcr, ETMCR);
-	etm_writel(drvdata, config->trigger_event, ETMTRIGGER);
-	etm_writel(drvdata, config->startstop_ctrl, ETMTSSCR);
-	etm_writel(drvdata, config->enable_event, ETMTEEVR);
-	etm_writel(drvdata, config->enable_ctrl1, ETMTECR1);
-	etm_writel(drvdata, config->fifofull_level, ETMFFLR);
+	etm_writel(drvdata, curr_config->ctrl | etmcr, ETMCR);
+	etm_writel(drvdata, curr_config->trigger_event, ETMTRIGGER);
+	etm_writel(drvdata, curr_config->startstop_ctrl, ETMTSSCR);
+	etm_writel(drvdata, curr_config->enable_event, ETMTEEVR);
+	etm_writel(drvdata, curr_config->enable_ctrl1, ETMTECR1);
+	etm_writel(drvdata, curr_config->fifofull_level, ETMFFLR);
 	for (i = 0; i < caps->nr_addr_cmp; i++) {
-		etm_writel(drvdata, config->addr_val[i], ETMACVRn(i));
-		etm_writel(drvdata, config->addr_acctype[i], ETMACTRn(i));
+		etm_writel(drvdata, curr_config->addr_val[i], ETMACVRn(i));
+		etm_writel(drvdata, curr_config->addr_acctype[i], ETMACTRn(i));
 	}
 	for (i = 0; i < caps->nr_cntr; i++) {
-		etm_writel(drvdata, config->cntr_rld_val[i], ETMCNTRLDVRn(i));
-		etm_writel(drvdata, config->cntr_event[i], ETMCNTENRn(i));
-		etm_writel(drvdata, config->cntr_rld_event[i],
+		etm_writel(drvdata, curr_config->cntr_rld_val[i], ETMCNTRLDVRn(i));
+		etm_writel(drvdata, curr_config->cntr_event[i], ETMCNTENRn(i));
+		etm_writel(drvdata, curr_config->cntr_rld_event[i],
 			   ETMCNTRLDEVRn(i));
-		etm_writel(drvdata, config->cntr_val[i], ETMCNTVRn(i));
+		etm_writel(drvdata, curr_config->cntr_val[i], ETMCNTVRn(i));
 	}
-	etm_writel(drvdata, config->seq_12_event, ETMSQ12EVR);
-	etm_writel(drvdata, config->seq_21_event, ETMSQ21EVR);
-	etm_writel(drvdata, config->seq_23_event, ETMSQ23EVR);
-	etm_writel(drvdata, config->seq_31_event, ETMSQ31EVR);
-	etm_writel(drvdata, config->seq_32_event, ETMSQ32EVR);
-	etm_writel(drvdata, config->seq_13_event, ETMSQ13EVR);
-	etm_writel(drvdata, config->seq_curr_state, ETMSQR);
+	etm_writel(drvdata, curr_config->seq_12_event, ETMSQ12EVR);
+	etm_writel(drvdata, curr_config->seq_21_event, ETMSQ21EVR);
+	etm_writel(drvdata, curr_config->seq_23_event, ETMSQ23EVR);
+	etm_writel(drvdata, curr_config->seq_31_event, ETMSQ31EVR);
+	etm_writel(drvdata, curr_config->seq_32_event, ETMSQ32EVR);
+	etm_writel(drvdata, curr_config->seq_13_event, ETMSQ13EVR);
+	etm_writel(drvdata, curr_config->seq_curr_state, ETMSQR);
 	for (i = 0; i < caps->nr_ext_out; i++)
 		etm_writel(drvdata, ETM_DEFAULT_EVENT_VAL, ETMEXTOUTEVRn(i));
 	for (i = 0; i < caps->nr_ctxid_cmp; i++)
-		etm_writel(drvdata, config->ctxid_pid[i], ETMCIDCVRn(i));
-	etm_writel(drvdata, config->ctxid_mask, ETMCIDCMR);
-	etm_writel(drvdata, config->sync_freq, ETMSYNCFR);
+		etm_writel(drvdata, curr_config->ctxid_pid[i], ETMCIDCVRn(i));
+	etm_writel(drvdata, curr_config->ctxid_mask, ETMCIDCMR);
+	etm_writel(drvdata, curr_config->sync_freq, ETMSYNCFR);
 	/* No external input selected */
 	etm_writel(drvdata, 0x0, ETMEXTINSELR);
-	etm_writel(drvdata, config->timestamp_event, ETMTSEVR);
+	etm_writel(drvdata, curr_config->timestamp_event, ETMTSEVR);
 	/* No auxiliary control selected */
 	etm_writel(drvdata, 0x0, ETMAUXCR);
 	etm_writel(drvdata, drvdata->traceid, ETMTRACEIDR);
@@ -562,17 +562,17 @@ static void etm_disable_hw(struct etm_drvdata *drvdata)
 {
 	int i;
 	const struct etm_caps *caps = &drvdata->caps;
-	struct etm_config *config = &drvdata->curr_config;
+	struct etm_config *curr_config = &drvdata->curr_config;
 	struct coresight_device *csdev = drvdata->csdev;
 
 	CS_UNLOCK(drvdata->csa.base);
 	etm_set_prog(drvdata);
 
 	/* Read back sequencer and counters for post trace analysis */
-	config->seq_curr_state = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
+	curr_config->seq_curr_state = (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
 
 	for (i = 0; i < caps->nr_cntr; i++)
-		config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
+		curr_config->cntr_val[i] = etm_readl(drvdata, ETMCNTVRn(i));
 
 	etm_set_pwrdwn(drvdata);
 	coresight_disclaim_device_unlocked(csdev);

-- 
2.43.0

