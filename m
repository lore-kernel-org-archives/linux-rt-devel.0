Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B274562B0
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 10:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124194; cv=none; b=XU9VYTZ5ZUCh9q3PczJWLtDKjMMDl9Y0nMLMF2jsWxJujjzQOwGHRz2gbH4b9gmBigzLyiD+zpB63OZFm1yiJm3+AhylrauM4pfxiDZdcFP1zndDKNaHGjIwiztnIXKEGUmKztaUxvbeuYItpzghoSrz4ZNfDiOiVMLnK/ud2ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124194; c=relaxed/simple;
	bh=/QfYO1y0wBtLnPIB59nia6+gs4uwrOFLUMOtC0imFE0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XSa9Afu8qgIYbw+3dOUDb02IJHxZG60VkBVJQZlk5CBCv/1aKlRX88oFWy5Bxc7GSPQSyLSJkjK2pOr6GHhGKWdh4Uc2weS4othL9gASDrBSVfq8gYxFPMg7j0EhJm15uJqUbjBP5yT5aswBMLWGGaYfwxYFeCAjSHf9wSw/DkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rsdali7P; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rsdali7P"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A71C428C7;
	Fri, 11 Sep 2026 03:56:25 -0700 (PDT)
Received: from e129823.arm.com (unknown [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 492123F7B4;
	Fri, 11 Sep 2026 03:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789124189; bh=/QfYO1y0wBtLnPIB59nia6+gs4uwrOFLUMOtC0imFE0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rsdali7PBZ9CDB2bbcaMckvj4LqC9t4Dbo4hO4lgLQw94NPYZtEgoR5R3D0b+pS79
	 Hggji6YUPWzB/Kx6OqxHweL+BEAlfEYn5syj9sEl4Zf4/UdZJuHAVjv0LAzyfOHhH9
	 MolCSrGaTcRk3MnWKIRKMSRu0Vm9bswBAU7Y/liU=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 11 Sep 2026 11:56:05 +0100
Subject: [PATCH v10 6/8] coresight: etm4x: exclude ss_status from
 drvdata->config
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-separate_etm_cfg_v2-v10-6-1b715d95927a@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7479; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=/QfYO1y0wBtLnPIB59nia6+gs4uwrOFLUMOtC0imFE0=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqo95KN1vU8l2qiWS4BIKRozHyzccNwkparbkkg
 WR8lP4/vNaJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqPeSgAKCRBt1cPRWsUx
 M7l1C/oCCZ2/mExQQ7PN1ezN3eZBzGjx5dzDPs/Opq+bimdNUqc3nZsExXJ2vGdsB/zTQNMFpmO
 vKd8a/j3ghTAZ0K8T0gp6AFPNUORFE85pQ6Pf6nGK42JrYdT2Lj3qyNJpFsf3tT7lLk9yyBfkFp
 jOmqhsjTUl7t2HkwjsM4QFFwGxBKGCUH3NZq8ybB7mKJZu6zoVG/Rlsin8QTJ6ZgM5E1aYEEH3A
 4RkLRL1r/iU8LvWiff7dsyZEcoeAQFsIfcPdFzT61wOQsXbHpdlOuxGkc6mKgXhy36AmtqvE+gX
 GenlyMDoneR3wQydCfyFp5Qlj+CGNNTrYzrfxPEDmGf2GqjNXEtpnv4A9q3NFxLjdOSS1iV2LyU
 sXpyV9y6sAD1W1xGWK7u5zMNi4dHuAC2ra7ppA5QkILgoUvPektouk237wYAojxvmkI9QV7ZAKy
 tfEP9o9T4LjZacxaO+ahmlfTPpHWWBDnCLYbYH7e9BRXjPfpKAyPmPwN07mHEFAEp0+Jo=
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
 drivers/hwtracing/coresight/coresight-etm4x-core.c  | 15 ++++++++-------
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 10 +++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h       |  7 ++++++-
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
index d24f533c623d..098aabd2b922 100644
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
index 6d64a3fbdea4..68aa99e8135d 100644
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
 
@@ -1511,8 +1511,9 @@ static void etm4_init_arch_data(void *info)
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
index 2d8a8f64a038..ac290f446c51 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1829,8 +1829,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
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
@@ -1844,7 +1844,7 @@ static ssize_t sshot_status_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	raw_spin_lock(&drvdata->spinlock);
-	val = config->ss_status[config->ss_idx];
+	val = drvdata->ss_status[config->ss_idx];
 	raw_spin_unlock(&drvdata->spinlock);
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
@@ -1879,8 +1879,8 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
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
index ffde48b6b41b..8c1c1364b1c4 100644
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

