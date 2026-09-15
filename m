Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6052A4C7554
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472113; cv=none; b=CfjozH0pKIkP0K7ozoKryEPViV/d1pFhyIfFe/HMOsBTk+aoEgi1VM5CHakXpy9DgBo/bCxEl3MUFR1Ya4woyYofmux2eA37KhcpSejZwlVN+L1pJcPUEo+Fx+Vmjxb+YvOG2jQ9G3ajKRWr4yAIK7ATmgk9zq7K/ZFYg1aw+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472113; c=relaxed/simple;
	bh=/cDs6W9clgGEJzYLEVGX54ETwHYxrQIEKSpVe7Q1eX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BcXejCAbW5YLzjDSo5EbAUl9L14psQRtdGFzCQD16pZ6V2hbiaAuzGNdzD/Egy+7pyQ0nP4WVf06Uu/Sm9GM0t8aK2EYMZb/Qo40c7vxmxGQca8YkE954ONYoIyILLGXkLSjKMkJjnl1FnyUzj1ecSYx6uAH6de92BvAoO9W11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HJKSxgn7; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HJKSxgn7"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 99A641BD0;
	Tue, 15 Sep 2026 04:35:00 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7731F3F86F;
	Tue, 15 Sep 2026 04:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789472104; bh=/cDs6W9clgGEJzYLEVGX54ETwHYxrQIEKSpVe7Q1eX8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HJKSxgn7EATQ7E8Rub8VXNoo1+Ar4TS/UB6sgDNdETj+AfiDXTxRboifykm/y+LLs
	 kl2AzFj28mMTC9KHGAT4IC+E8dojrIXDmlUhLYxozGSRt+HpGiP7fJKBZQZYiKtO+C
	 ND/OAQT5pWdsT5kzDc9nzIZVZY0ql3ivZXccs9lA=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Tue, 15 Sep 2026 12:34:42 +0100
Subject: [PATCH v11 7/9] coresight: etm4x: exclude ss_status from
 drvdata->config
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-separate_etm_cfg_v2-v11-7-d2b258d51747@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7976; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=/cDs6W9clgGEJzYLEVGX54ETwHYxrQIEKSpVe7Q1eX8=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqqS1WxjEJEpOcbL8MfhWcuYW83ZdHIUltZLnri
 zPrdO1zpmuJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqktVgAKCRBt1cPRWsUx
 M8W9DACqhq+k3udBWQGOiBekdLI/Ex2hXvfxHCvvvzRYn4fkNisVVk4co2jqbPGAvL8Z1vKZiEs
 ky5M4KsThAIPcPK7HCFgsElCFdPBnODydp+JOLxlj+iBhQt90GtdkzTDX3m44BkSvKLcl6WayvC
 P5onDrK3czwT5efmd5PU7AK0tBOe6aVss7x7M20+bARUx7w9tpMkmHtkQ2MGZD5DQaXoLYl1tUr
 N2YGw/PE9RKQBhpDahVwlf5drG/GYNu6r4YzsZ7EzO8gMRuNMz5ARvCy+jGVZvKkUlbBWBGMQdB
 21s1nCuQdZ4wmaU4FNC8y+nBAWKNM26AdRIdE8IffSd2vqneOgNEUchSfedsLiHNWiIbieJR/y0
 ujeOOFR+B77/E8mmNk4KVA8Ozk0ghE+hJDtEF4lvN/t94gqahNpDJxPyXTjtDAf3xJgWElUf6ZD
 Lh5VtAM7Mt2bII2sUzWUdlF1LoKmvSMZ98z5/xc9FXXBCKL0OIFS8AUip9qMGdgVRBQFc=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The purpose of TRCSSCSRn register is to show status of
the corresponding Single-shot Comparator Control and input supports.
That means writable field's purpose for reset or restore from idle status
not for configuration.

Therefore, exclude ss_status from drvdata->config and move it to drvdata.

Before this patch, clearing the PENDING and STATUS bits when enabling
a perf session could trigger multiple single-shot events within
the same session. This issue will be addressed in a future patch;
this patch intentionally preserves the existing behavior.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c   |  1 -
 drivers/hwtracing/coresight/coresight-etm4x-core.c  | 20 +++++++++-----------
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 10 +++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h       |  7 ++++++-
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
index d24f533c623d0..098aabd2b922c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
@@ -86,7 +86,6 @@ static int etm4_cfg_map_reg_offset(struct etmv4_drvdata *drvdata,
 		off_mask =  (offset & GENMASK(11, 5));
 		do {
 			CHECKREGIDX(TRCSSCCRn(0), ss_ctrl, idx, off_mask);
-			CHECKREGIDX(TRCSSCSRn(0), ss_status, idx, off_mask);
 			CHECKREGIDX(TRCSSPCICRn(0), ss_pe_cmp, idx, off_mask);
 		} while (0);
 	} else if ((offset >= TRCCIDCVRn(0)) && (offset <= TRCVMIDCVRn(7))) {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 70a5c0b4fad1c..9de0c268ff954 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -95,7 +95,7 @@ static bool etm4x_sspcicrn_present(struct etmv4_drvdata *drvdata, int n)
 	const struct etmv4_caps *caps = &drvdata->caps;
 
 	return (n < caps->nr_ss_cmp) && caps->nr_pe_cmp &&
-	       (drvdata->config.ss_status[n] & TRCSSCSRn_PC);
+	       (drvdata->ss_status[n] & TRCSSCSRn_PC);
 }
 
 u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
@@ -573,11 +573,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
 
 	for (i = 0; i < caps->nr_ss_cmp; i++) {
-		/* always clear status bit on restart if using single-shot */
+		/* always clear status and pending bits on restart if using single-shot */
 		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
-			config->ss_status[i] &= ~TRCSSCSRn_STATUS;
+			drvdata->ss_status[i] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
 		etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
-		etm4x_relaxed_write32(csa, config->ss_status[i], TRCSSCSRn(i));
+		etm4x_relaxed_write32(csa, drvdata->ss_status[i], TRCSSCSRn(i));
 		if (etm4x_sspcicrn_present(drvdata, i))
 			etm4x_relaxed_write32(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
 	}
@@ -1081,7 +1081,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
 
 	/* read the status of the single shot comparators */
 	for (i = 0; i < caps->nr_ss_cmp; i++) {
-		config->ss_status[i] =
+		drvdata->ss_status[i] =
 			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
 	}
 
@@ -1162,12 +1162,9 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 				 drvdata, 1);
 
 	/*
-	 * Userspace may read ss_status and cntr_val through sysfs after
+	 * Userspace may read cntr_val through sysfs after
 	 * the sysfs-session has been disabled.
 	 */
-	for (i = 0; i < caps->nr_ss_cmp; i++)
-		config->ss_status[i] = active_config->ss_status[i];
-
 	for (i = 0; i < caps->nr_cntr; i++)
 		config->cntr_val[i] = active_config->cntr_val[i];
 
@@ -1525,8 +1522,9 @@ static void etm4_init_arch_data(void *info)
 	 */
 	caps->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
 	for (i = 0; i < caps->nr_ss_cmp; i++) {
-		drvdata->config.ss_status[i] =
-			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
+		drvdata->ss_status[i] = etm4x_relaxed_read32(csa, TRCSSCSRn(i));
+		drvdata->ss_status[i] &= (TRCSSCSRn_PC | TRCSSCSRn_DV |
+					  TRCSSCSRn_DA | TRCSSCSRn_INST);
 	}
 	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
 	caps->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index f6d053f73264c..50ef2e957300f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1833,8 +1833,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	idx = config->ss_idx;
 	config->ss_ctrl[idx] = FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
-	/* must clear bit 31 in related status register on programming */
-	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
+	/* must clear bit 31 and 30 in related status register on programming */
+	drvdata->ss_status[idx] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
@@ -1848,7 +1848,7 @@ static ssize_t sshot_status_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	val = config->ss_status[config->ss_idx];
+	val = drvdata->ss_status[config->ss_idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1885,8 +1885,8 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	idx = config->ss_idx;
 	config->ss_pe_cmp[idx] = FIELD_PREP(TRCSSPCICRn_PC_MASK, val);
-	/* must clear bit 31 in related status register on programming */
-	config->ss_status[idx] &= ~TRCSSCSRn_STATUS;
+	/* must clear bit 31 and 30 in related status register on programming */
+	drvdata->ss_status[idx] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index ffde48b6b41b2..8c1c1364b1c44 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -213,6 +213,7 @@
 #define TRCACATRn_EXLEVEL_MASK			GENMASK(14, 8)
 
 #define TRCSSCSRn_STATUS			BIT(31)
+#define TRCSSCSRn_PENDING			BIT(30)
 #define TRCSSCCRn_SAC_ARC_RST_MASK		GENMASK(24, 0)
 
 #define TRCSSPCICRn_PC_MASK			GENMASK(7, 0)
@@ -730,6 +731,9 @@ static inline u32 etm4_res_sel_pair(u8 res_sel_idx)
 #define ETM_DEFAULT_ADDR_COMP		0
 
 #define TRCSSCSRn_PC			BIT(3)
+#define TRCSSCSRn_DV			BIT(2)
+#define TRCSSCSRn_DA			BIT(1)
+#define TRCSSCSRn_INST			BIT(0)
 
 /* PowerDown Control Register bits */
 #define TRCPDCR_PU			BIT(3)
@@ -980,7 +984,6 @@ struct etmv4_config {
 	u32				res_ctrl[ETM_MAX_RES_SEL]; /* TRCRSCTLRn */
 	u8				ss_idx;
 	u32				ss_ctrl[ETM_MAX_SS_CMP];
-	u32				ss_status[ETM_MAX_SS_CMP];
 	u32				ss_pe_cmp[ETM_MAX_SS_CMP];
 	u8				addr_idx;
 	u64				addr_val[ETM_MAX_SINGLE_ADDR_CMP];
@@ -1071,6 +1074,7 @@ struct etmv4_save_state {
  * @config:	structure holding sysfs mode configuration.
  * @save_state:	State to be preserved across power loss
  * @paused:	Indicates if the trace unit is paused.
+ * @ss_status:	The status of the corresponding single-shot comparator.
  * @arch_features: Bitmap of arch features of etmv4 devices.
  */
 struct etmv4_drvdata {
@@ -1091,6 +1095,7 @@ struct etmv4_drvdata {
 	struct etmv4_config		active_config;
 	struct etmv4_config		config;
 	struct etmv4_save_state		*save_state;
+	u32				ss_status[ETM_MAX_SS_CMP];
 	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
 };
 

-- 
2.43.0

