Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9D03F58D6
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 Oct 2026 19:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790967838; cv=none; b=BlyZzb5y38oCVRq6LD/nfwAqwt1dvWmfuEwdPGIu2jrg8xaPVXZyRHPpVOopaNtUkK0WUAcNysqY3IUDg4JBt52jFICOTXhHyi+UgED5s0pPFQTc7YL1OkMQFoSz77fH3bpOULY3IxvsvAM5uAO6+iB+4vl2Qfnpcgqgf7Y0Igs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790967838; c=relaxed/simple;
	bh=QI346Tum2hdxh0Sl+qYk0dZsNHrbkJ+VUxYcbx+dlnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O0oWAROYcEUzFOJKR7d7kLCOU2V1aepMDO8yyUmMAvX1QQ7J+rYaXS25nde9emu+BD3lLpSQgWFBjoYlUN9ok59EXJ79RglzqduMRiH6KORxsmPCFXGQcCoOjiqOrm55WUuaweLp6X59eqDjX4Z/QpW43bQG62TYEsMRMF4OGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=peCUQliv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="peCUQliv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D62D143D;
	Fri,  2 Oct 2026 12:03:52 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB61E3F85F;
	Fri,  2 Oct 2026 12:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790967835; bh=QI346Tum2hdxh0Sl+qYk0dZsNHrbkJ+VUxYcbx+dlnY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=peCUQlivoxj6+/QV2j4NEHQwvBIz+bdSy8PTqItYxCULvJlIYcL1lPW2XL5991QFZ
	 uRoOTkl9Yn83PQDH/lVelfEbkyj9m43KZSA3kc0Ensm3lNlokHLd/a35YSZo/Upmyh
	 a8OseL5+K6Pd6+dHpeehL7zMzSjfsY93kyrkGWrc=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 02 Oct 2026 20:03:29 +0100
Subject: [PATCH v13 08/14] coresight: etm4x: exclude ss_status from
 drvdata->config
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-separate_etm_cfg_v2-v13-8-fe429d8d96fb@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7784; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=QI346Tum2hdxh0Sl+qYk0dZsNHrbkJ+VUxYcbx+dlnY=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqwAADxbRKCvLMfoNa9DF1bFN3qongOKyuswet+
 GCZm5rfRAaJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCasAAAwAKCRBt1cPRWsUx
 M1ueDADJIbtq5g46EQP2I89Naqk4JPtZDsk5W3SGSvaK9XhtfADdUE9YkopAAsJKJw8DqI6UAdo
 5TgQ3q1ABJxFuvjcFB8iJF3AlomkrBLyKFXA/FnKQXHSGpr+rWepP5JBB+5bjji2w+z8bsksJ+i
 qbBf1/m+HOgtK7LUfyTic9pTRMQjN+c+imtJMBIMlm0PmsMSGsz79XQZF6qKGheV0+nRBe8wBMi
 aURUqXHM2S4uPDGfADDiWJxenOJOqWC1BGCs7JugWzv5nt40ifrZi80m5fvH5sIkZ5NNDoVbOa8
 HdJcqlZaqbXaK+6osveN/XZ+CKOfyQh5QzmdZaz4ZFHVt6oQMwFRjPEA7UdLlELsT41H/y/56e4
 BF44kz+rcTHLi1gbajCWZ9mHAkdwtb75MV1Vf6duTD/IxSroVH1WGdcSZLnMWcLPMDnY4FXF5Fn
 WCaOWvJDMFiTsGrS0hSvOFjO+AF4UzatV461okwwgI0yrNwNQ8BZbOmbDMByYU2ce14lo=
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
Reviewed-by: Mike Leach <mike.leach@arm.com>
Tested-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-cfg.c   |  1 -
 drivers/hwtracing/coresight/coresight-etm4x-core.c  | 18 +++++++-----------
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 10 +++++-----
 drivers/hwtracing/coresight/coresight-etm4x.h       |  8 +++++++-
 4 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-cfg.c b/drivers/hwtracing/coresight/coresight-etm4x-cfg.c
index a9f6ed47a2f5..52cb036bb04b 100644
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
index 3900b96e9c7c..4a8c1070bbcb 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -95,7 +95,7 @@ static bool etm4x_sspcicrn_present(struct etmv4_drvdata *drvdata, int n)
 	const struct etmv4_caps *caps = &drvdata->caps;
 
 	return (n < caps->nr_ss_cmp) && caps->nr_pe_cmp &&
-	       (drvdata->config.ss_status[n] & TRCSSCSRn_PC);
+	       (drvdata->ss_status[n] & TRCSSCSRn_PC);
 }
 
 u64 etm4x_sysreg_read(u32 offset, bool _relaxed, bool _64bit)
@@ -572,11 +572,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
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
@@ -1078,7 +1078,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
 
 	/* read the status of the single shot comparators */
 	for (i = 0; i < caps->nr_ss_cmp; i++) {
-		config->ss_status[i] =
+		drvdata->ss_status[i] =
 			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
 	}
 
@@ -1163,12 +1163,9 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 				 drvdata, 1);
 
 	/*
-	 * Userspace may read ss_status and cntr_val through sysfs after
+	 * Userspace may read cntr_val through sysfs after
 	 * the sysfs-session has been disabled.
 	 */
-	for (i = 0; i < caps->nr_ss_cmp; i++)
-		config->ss_status[i] = curr_config->ss_status[i];
-
 	for (i = 0; i < caps->nr_cntr; i++)
 		config->cntr_val[i] = curr_config->cntr_val[i];
 
@@ -1528,8 +1525,7 @@ static void etm4_init_arch_data(void *info)
 	 */
 	caps->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
 	for (i = 0; i < caps->nr_ss_cmp; i++) {
-		drvdata->config.ss_status[i] =
-			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
+		drvdata->ss_status[i] = etm4x_relaxed_read32(csa, TRCSSCSRn(i));
 	}
 	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
 	caps->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 128e1bdd8524..d57c4f56a37d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -1835,8 +1835,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
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
@@ -1850,7 +1850,7 @@ static ssize_t sshot_status_show(struct device *dev,
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
index b4579261868d..67071f7cbdbc 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -213,6 +213,11 @@
 #define TRCACATRn_EXLEVEL_MASK			GENMASK(14, 8)
 
 #define TRCSSCSRn_STATUS			BIT(31)
+/*
+ * TRCSSCSR.PENDING is only implemented by ETE and is therefore not
+ * described in DEN0117. See Arm ARM (DDI0487) M.c, section D24.4.59.
+ */
+#define TRCSSCSRn_PENDING			BIT(30)
 #define TRCSSCCRn_SAC_ARC_RST_MASK		GENMASK(24, 0)
 
 #define TRCSSPCICRn_PC_MASK			GENMASK(7, 0)
@@ -980,7 +985,6 @@ struct etmv4_config {
 	u32				res_ctrl[ETM_MAX_RES_SEL]; /* TRCRSCTLRn */
 	u8				ss_idx;
 	u32				ss_ctrl[ETM_MAX_SS_CMP];
-	u32				ss_status[ETM_MAX_SS_CMP];
 	u32				ss_pe_cmp[ETM_MAX_SS_CMP];
 	u8				addr_idx;
 	u64				addr_val[ETM_MAX_SINGLE_ADDR_CMP];
@@ -1071,6 +1075,7 @@ struct etmv4_save_state {
  * @config:	structure holding sysfs mode configuration.
  * @save_state:	State to be preserved across power loss
  * @paused:	Indicates if the trace unit is paused.
+ * @ss_status:	The status of the corresponding single-shot comparator.
  * @arch_features: Bitmap of arch features of etmv4 devices.
  */
 struct etmv4_drvdata {
@@ -1091,6 +1096,7 @@ struct etmv4_drvdata {
 	struct etmv4_config		curr_config;
 	struct etmv4_config		config;
 	struct etmv4_save_state		*save_state;
+	u32				ss_status[ETM_MAX_SS_CMP];
 	DECLARE_BITMAP(arch_features, ETM4_IMPDEF_FEATURE_MAX);
 };
 

-- 
2.43.0

