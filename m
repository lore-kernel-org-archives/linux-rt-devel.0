Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB06744C4EA
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124195; cv=none; b=otHg/fTN2OiyOnrjrFyW/bIGnvEfnzpREB+CAEAnU8QdJZZiwiOF90ARL9SI4kiNhlqzehsUo9CFbwXr4ITSVULkN+QlJOQiQqDzisZp44qXsFKA/HsuFJJUhaASEZpZ0LcnmoUfwiNx46BPa/VJTJU+NpqJDZ/HxSuRqWt2phM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124195; c=relaxed/simple;
	bh=Tk02Tv0ad4Hl9l2/XHLlv4hPNRqKdgYbqWBLtYiI9hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SPC4C2k7mmonpwRxJs1z8yJDxn1CxLu2a71k9Rp9UOn0JE692U9ACalxSHJ/JcwcRQTdxSXiWQL7qfgl43G3bJGhDIjswxVVBxdNnqOPO6bH5k3dFFzqMEjLjv6H7hEN2k+KLegt2/Wux/q+5uwuW/ZTj667+Zy5xgD/HpdScto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lBt+SDU5; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lBt+SDU5"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4676828AC;
	Fri, 11 Sep 2026 03:56:23 -0700 (PDT)
Received: from e129823.arm.com (unknown [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C15213F7B4;
	Fri, 11 Sep 2026 03:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789124186; bh=Tk02Tv0ad4Hl9l2/XHLlv4hPNRqKdgYbqWBLtYiI9hQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lBt+SDU5f7+Qp3dQEI9evrVtC81+wbS4Z89cgJurxwQajGBtcKLiaBGcFsHwfbcqG
	 y2vmTKgLunQeMOZcxEDi6IFo1pZvSF0fvdGlkzBqsizD3ARqBwT+ElB+z1FApq3mkz
	 rDntxLr1BLFVkhCMtswD6gPHKittFHxj37CiZjAM=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Fri, 11 Sep 2026 11:56:04 +0100
Subject: [PATCH v10 5/8] coresight: etm4x: introduce struct etm4_caps
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-separate_etm_cfg_v2-v10-5-1b715d95927a@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=66937; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=Tk02Tv0ad4Hl9l2/XHLlv4hPNRqKdgYbqWBLtYiI9hQ=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqo95KfDmkoqX+gn1KN+ffXEAeUfgJZPwypKIeu
 ByZI7Eq0mmJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCaqPeSgAKCRBt1cPRWsUx
 M0l4DAC2ZWQYhzLMSkIAqVsa2grfwiaJLrOsQezCVtEn6qHT9hrj9UGl73uPgZlzCBOflEprtso
 +4sCE0gvipMPkt0496G9BWdx7znXafTxmwERDZmoD8rjAS9AP9UdyS4tikeGFKp6LXgTpVnqBKS
 hWcw8YqRZZitDiy8DDC613aarRt157nNIGPykYJS5ItOQ2pb4GvXZDVzF6fYqXM7CV1SHOe/Hmw
 0NbJAdCLmJo/pJDhdjnc5hzFcgpH1NPBL+Wb4HKLfAH6xAYYPIZkUKf2+QMZXgivi0aCRaryn1y
 3najMQ5pQdLF3nFxbd1wvi8LSXWOt98HRbPywomtA7FWa9buz5IsDC1ndhkqnz6JytnvN4bkTUl
 AL+U32p3WZB7s6dX+L1xaDSOz+CgEbexdnTYciZsbxHzro4Wkhf64JTOfXEZjFw3gIy7qaHofxF
 n0cPkna48X9Q5UAO5VFp569yijomMUnU9yavLLfvwvZyXgQIcmdhudKtzMXxAZyjwgRkA=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

Introduce struct etm4_caps to describe ETMv4 capabilities
and move capabilities information into it.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 239 +++++++++++----------
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 192 ++++++++++-------
 drivers/hwtracing/coresight/coresight-etm4x.h      | 180 ++++++++--------
 3 files changed, 333 insertions(+), 278 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 02b91a67b00b..6d64a3fbdea4 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -92,8 +92,9 @@ static int etm4_probe_cpu(unsigned int cpu);
  */
 static bool etm4x_sspcicrn_present(struct etmv4_drvdata *drvdata, int n)
 {
-	return (n < drvdata->nr_ss_cmp) &&
-	       drvdata->nr_pe_cmp &&
+	const struct etmv4_caps *caps = &drvdata->caps;
+
+	return (n < caps->nr_ss_cmp) && caps->nr_pe_cmp &&
 	       (drvdata->config.ss_status[n] & TRCSSCSRn_PC);
 }
 
@@ -164,17 +165,20 @@ static void ete_sysreg_write(u64 val, u32 offset, bool _relaxed, bool _64bit)
 static void etm_detect_os_lock(struct etmv4_drvdata *drvdata,
 			       struct csdev_access *csa)
 {
+	struct etmv4_caps *caps = &drvdata->caps;
 	u32 oslsr = etm4x_relaxed_read32(csa, TRCOSLSR);
 
-	drvdata->os_lock_model = ETM_OSLSR_OSLM(oslsr);
+	caps->os_lock_model = ETM_OSLSR_OSLM(oslsr);
 }
 
 static void etm_write_os_lock(struct etmv4_drvdata *drvdata,
 			      struct csdev_access *csa, u32 val)
 {
+	const struct etmv4_caps *caps = &drvdata->caps;
+
 	val = !!val;
 
-	switch (drvdata->os_lock_model) {
+	switch (caps->os_lock_model) {
 	case ETM_OSLOCK_PRESENT:
 		etm4x_relaxed_write32(csa, val, TRCOSLAR);
 		break;
@@ -183,7 +187,7 @@ static void etm_write_os_lock(struct etmv4_drvdata *drvdata,
 		break;
 	default:
 		pr_warn_once("CPU%d: Unsupported Trace OSLock model: %x\n",
-			     smp_processor_id(), drvdata->os_lock_model);
+			     smp_processor_id(), caps->os_lock_model);
 		fallthrough;
 	case ETM_OSLOCK_NI:
 		return;
@@ -495,6 +499,7 @@ static int etm4_enable_trace_unit(struct etmv4_drvdata *drvdata)
 static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->active_config;
 	struct coresight_device *csdev = drvdata->csdev;
 	struct device *etm_dev = &csdev->dev;
@@ -526,14 +531,14 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	if (etm4x_wait_status(csa, TRCSTATR_IDLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
-	if (drvdata->nr_pe)
+	if (caps->nr_pe)
 		etm4x_relaxed_write32(csa, config->pe_sel, TRCPROCSELR);
 	etm4x_relaxed_write32(csa, config->cfg, TRCCONFIGR);
 	/* nothing specific implemented */
 	etm4x_relaxed_write32(csa, 0x0, TRCAUXCTLR);
 	etm4x_relaxed_write32(csa, config->eventctrl0, TRCEVENTCTL0R);
 	etm4x_relaxed_write32(csa, config->eventctrl1, TRCEVENTCTL1R);
-	if (drvdata->stallctl)
+	if (caps->stallctl)
 		etm4x_relaxed_write32(csa, config->stall_ctrl, TRCSTALLCTLR);
 	etm4x_relaxed_write32(csa, config->ts_ctrl, TRCTSCTLR);
 	etm4x_relaxed_write32(csa, config->syncfreq, TRCSYNCPR);
@@ -543,18 +548,18 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	etm4x_relaxed_write32(csa, config->vinst_ctrl, TRCVICTLR);
 	etm4x_relaxed_write32(csa, config->viiectlr, TRCVIIECTLR);
 	etm4x_relaxed_write32(csa, config->vissctlr, TRCVISSCTLR);
-	if (drvdata->nr_pe_cmp)
+	if (caps->nr_pe_cmp)
 		etm4x_relaxed_write32(csa, config->vipcssctlr, TRCVIPCSSCTLR);
 
-	for (i = 0; i < drvdata->nr_seq_ctrls; i++)
+	for (i = 0; i < caps->nr_seq_ctrls; i++)
 		etm4x_relaxed_write32(csa, config->seq_ctrl[i], TRCSEQEVRn(i));
-	if (drvdata->nrseqstate) {
+	if (caps->nrseqstate) {
 		etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
 		etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
 	}
-	if (drvdata->numextinsel)
+	if (caps->numextinsel)
 		etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
-	for (i = 0; i < drvdata->nr_cntr; i++) {
+	for (i = 0; i < caps->nr_cntr; i++) {
 		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
 		etm4x_relaxed_write32(csa, config->cntr_ctrl[i], TRCCNTCTLRn(i));
 		etm4x_relaxed_write32(csa, config->cntr_val[i], TRCCNTVRn(i));
@@ -564,10 +569,10 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	 * Resource selector pair 0 is always implemented and reserved.  As
 	 * such start at 2.
 	 */
-	for (i = 2; i < drvdata->nr_resource * 2; i++)
+	for (i = 2; i < caps->nr_resource * 2; i++)
 		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
 
-	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
+	for (i = 0; i < caps->nr_ss_cmp; i++) {
 		/* always clear status bit on restart if using single-shot */
 		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
 			config->ss_status[i] &= ~TRCSSCSRn_STATUS;
@@ -576,23 +581,23 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		if (etm4x_sspcicrn_present(drvdata, i))
 			etm4x_relaxed_write32(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
 	}
-	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
+	for (i = 0; i < caps->nr_addr_cmp * 2; i++) {
 		etm4x_relaxed_write64(csa, config->addr_val[i], TRCACVRn(i));
 		etm4x_relaxed_write64(csa, config->addr_acc[i], TRCACATRn(i));
 	}
-	for (i = 0; i < drvdata->numcidc; i++)
+	for (i = 0; i < caps->numcidc; i++)
 		etm4x_relaxed_write64(csa, config->ctxid_pid[i], TRCCIDCVRn(i));
 	etm4x_relaxed_write32(csa, config->ctxid_mask0, TRCCIDCCTLR0);
-	if (drvdata->numcidc > 4)
+	if (caps->numcidc > 4)
 		etm4x_relaxed_write32(csa, config->ctxid_mask1, TRCCIDCCTLR1);
 
-	for (i = 0; i < drvdata->numvmidc; i++)
+	for (i = 0; i < caps->numvmidc; i++)
 		etm4x_relaxed_write64(csa, config->vmid_val[i], TRCVMIDCVRn(i));
 	etm4x_relaxed_write32(csa, config->vmid_mask0, TRCVMIDCCTLR0);
-	if (drvdata->numvmidc > 4)
+	if (caps->numvmidc > 4)
 		etm4x_relaxed_write32(csa, config->vmid_mask1, TRCVMIDCCTLR1);
 
-	if (!drvdata->skip_power_up) {
+	if (!caps->skip_power_up) {
 		u32 trcpdcr = etm4x_relaxed_read32(csa, TRCPDCR);
 
 		/*
@@ -697,19 +702,20 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
 {
 	int ctridx;
 	int rselector;
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->active_config;
 
 	/* No point in trying if we don't have at least one counter */
-	if (!drvdata->nr_cntr)
+	if (!caps->nr_cntr)
 		return -EINVAL;
 
 	/* Find a counter that hasn't been initialised */
-	for (ctridx = 0; ctridx < drvdata->nr_cntr; ctridx++)
+	for (ctridx = 0; ctridx < caps->nr_cntr; ctridx++)
 		if (config->cntr_val[ctridx] == 0)
 			break;
 
 	/* All the counters have been configured already, bail out */
-	if (ctridx == drvdata->nr_cntr) {
+	if (ctridx == caps->nr_cntr) {
 		pr_debug("%s: no available counter found\n", __func__);
 		return -ENOSPC;
 	}
@@ -725,11 +731,11 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
 	 * ETMIDR4 gives the number of resource selector _pairs_, hence multiply
 	 * by 2.
 	 */
-	for (rselector = 2; rselector < drvdata->nr_resource * 2; rselector++)
+	for (rselector = 2; rselector < caps->nr_resource * 2; rselector++)
 		if (!config->res_ctrl[rselector])
 			break;
 
-	if (rselector == drvdata->nr_resource * 2) {
+	if (rselector == caps->nr_resource * 2) {
 		pr_debug("%s: no available resource selector found\n",
 			 __func__);
 		return -ENOSPC;
@@ -780,6 +786,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 {
 	int ret = 0;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->active_config;
 	struct perf_event_attr max_timestamp = {
 		.ATTR_CFG_FLD_timestamp_CFG = U64_MAX,
@@ -818,8 +825,8 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 		cc_threshold = ATTR_CFG_GET_FLD(attr, cc_threshold);
 		if (!cc_threshold)
 			cc_threshold = ETM_CYC_THRESHOLD_DEFAULT;
-		if (cc_threshold < drvdata->ccitmin)
-			cc_threshold = drvdata->ccitmin;
+		if (cc_threshold < caps->ccitmin)
+			cc_threshold = caps->ccitmin;
 		config->ccctlr = cc_threshold;
 	}
 
@@ -867,13 +874,13 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 	}
 
 	/* return stack - enable if selected and supported */
-	if (ATTR_CFG_GET_FLD(attr, retstack) && drvdata->retstack)
+	if (ATTR_CFG_GET_FLD(attr, retstack) && caps->retstack)
 		/* bit[12], Return stack enable bit */
 		config->cfg |= TRCCONFIGR_RS;
 
 	/* branch broadcast - enable if selected and supported */
 	if (ATTR_CFG_GET_FLD(attr, branch_broadcast)) {
-		if (!drvdata->trcbb) {
+		if (!caps->trcbb) {
 			/*
 			 * Missing BB support could cause silent decode errors
 			 * so fail to open if it's not supported.
@@ -1054,6 +1061,7 @@ static void etm4_disable_trace_unit(struct etmv4_drvdata *drvdata)
 static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
 {
 	u32 control;
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->active_config;
 	struct coresight_device *csdev = drvdata->csdev;
 	struct csdev_access *csa = &csdev->access;
@@ -1062,7 +1070,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
 	etm4_cs_unlock(drvdata, csa);
 	etm4_disable_arch_specific(drvdata);
 
-	if (!drvdata->skip_power_up) {
+	if (!caps->skip_power_up) {
 		/* power can be removed from the trace unit now */
 		control = etm4x_relaxed_read32(csa, TRCPDCR);
 		control &= ~TRCPDCR_PU;
@@ -1072,13 +1080,13 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
 	etm4_disable_trace_unit(drvdata);
 
 	/* read the status of the single shot comparators */
-	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
+	for (i = 0; i < caps->nr_ss_cmp; i++) {
 		config->ss_status[i] =
 			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
 	}
 
 	/* read back the current counter values */
-	for (i = 0; i < drvdata->nr_cntr; i++) {
+	for (i = 0; i < caps->nr_cntr; i++) {
 		config->cntr_val[i] =
 			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
 	}
@@ -1360,7 +1368,7 @@ static struct midr_range etm_wrong_ccitmin_cpus[] = {
 	{},
 };
 
-static void etm4_fixup_wrong_ccitmin(struct etmv4_drvdata *drvdata)
+static void etm4_fixup_wrong_ccitmin(struct etmv4_caps *caps)
 {
 	/*
 	 * Erratum affected cpus will read 256 as the minimum
@@ -1370,8 +1378,8 @@ static void etm4_fixup_wrong_ccitmin(struct etmv4_drvdata *drvdata)
 	 * this problem.
 	 */
 	if (is_midr_in_range_list(etm_wrong_ccitmin_cpus)) {
-		if (drvdata->ccitmin == 256)
-			drvdata->ccitmin = 4;
+		if (caps->ccitmin == 256)
+			caps->ccitmin = 4;
 	}
 }
 
@@ -1384,11 +1392,13 @@ static void etm4_init_arch_data(void *info)
 	u32 etmidr5;
 	struct etm4_init_arg *init_arg = info;
 	struct etmv4_drvdata *drvdata;
+	struct etmv4_caps *caps;
 	struct csdev_access *csa;
 	struct device *dev = init_arg->dev;
 	int i;
 
 	drvdata = dev_get_drvdata(init_arg->dev);
+	caps = &drvdata->caps;
 	csa = init_arg->csa;
 
 	/*
@@ -1401,7 +1411,7 @@ static void etm4_init_arch_data(void *info)
 
 	if (!csa->io_mem ||
 	    fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
-		drvdata->skip_power_up = true;
+		caps->skip_power_up = true;
 
 	/* Detect the support for OS Lock before we actually use it */
 	etm_detect_os_lock(drvdata, csa);
@@ -1416,71 +1426,71 @@ static void etm4_init_arch_data(void *info)
 	etmidr0 = etm4x_relaxed_read32(csa, TRCIDR0);
 
 	/* INSTP0, bits[2:1] P0 tracing support field */
-	drvdata->instrp0 = !!(FIELD_GET(TRCIDR0_INSTP0_MASK, etmidr0) == 0b11);
+	caps->instrp0 = !!(FIELD_GET(TRCIDR0_INSTP0_MASK, etmidr0) == 0b11);
 	/* TRCBB, bit[5] Branch broadcast tracing support bit */
-	drvdata->trcbb = !!(etmidr0 & TRCIDR0_TRCBB);
+	caps->trcbb = !!(etmidr0 & TRCIDR0_TRCBB);
 	/* TRCCOND, bit[6] Conditional instruction tracing support bit */
-	drvdata->trccond = !!(etmidr0 & TRCIDR0_TRCCOND);
+	caps->trccond = !!(etmidr0 & TRCIDR0_TRCCOND);
 	/* TRCCCI, bit[7] Cycle counting instruction bit */
-	drvdata->trccci = !!(etmidr0 & TRCIDR0_TRCCCI);
+	caps->trccci = !!(etmidr0 & TRCIDR0_TRCCCI);
 	/* RETSTACK, bit[9] Return stack bit */
-	drvdata->retstack = !!(etmidr0 & TRCIDR0_RETSTACK);
+	caps->retstack = !!(etmidr0 & TRCIDR0_RETSTACK);
 	/* NUMEVENT, bits[11:10] Number of events field */
-	drvdata->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0);
+	caps->nr_event = FIELD_GET(TRCIDR0_NUMEVENT_MASK, etmidr0);
 	/* QSUPP, bits[16:15] Q element support field */
-	drvdata->q_support = FIELD_GET(TRCIDR0_QSUPP_MASK, etmidr0);
-	if (drvdata->q_support)
-		drvdata->q_filt = !!(etmidr0 & TRCIDR0_QFILT);
+	caps->q_support = FIELD_GET(TRCIDR0_QSUPP_MASK, etmidr0);
+	if (caps->q_support)
+		caps->q_filt = !!(etmidr0 & TRCIDR0_QFILT);
 	/* TSSIZE, bits[28:24] Global timestamp size field */
-	drvdata->ts_size = FIELD_GET(TRCIDR0_TSSIZE_MASK, etmidr0);
+	caps->ts_size = FIELD_GET(TRCIDR0_TSSIZE_MASK, etmidr0);
 
 	/* maximum size of resources */
 	etmidr2 = etm4x_relaxed_read32(csa, TRCIDR2);
 	/* CIDSIZE, bits[9:5] Indicates the Context ID size */
-	drvdata->ctxid_size = FIELD_GET(TRCIDR2_CIDSIZE_MASK, etmidr2);
+	caps->ctxid_size = FIELD_GET(TRCIDR2_CIDSIZE_MASK, etmidr2);
 	/* VMIDSIZE, bits[14:10] Indicates the VMID size */
-	drvdata->vmid_size = FIELD_GET(TRCIDR2_VMIDSIZE_MASK, etmidr2);
+	caps->vmid_size = FIELD_GET(TRCIDR2_VMIDSIZE_MASK, etmidr2);
 	/* CCSIZE, bits[28:25] size of the cycle counter in bits minus 12 */
-	drvdata->ccsize = FIELD_GET(TRCIDR2_CCSIZE_MASK, etmidr2);
+	caps->ccsize = FIELD_GET(TRCIDR2_CCSIZE_MASK, etmidr2);
 
 	etmidr3 = etm4x_relaxed_read32(csa, TRCIDR3);
 	/* CCITMIN, bits[11:0] minimum threshold value that can be programmed */
-	drvdata->ccitmin = FIELD_GET(TRCIDR3_CCITMIN_MASK, etmidr3);
-	etm4_fixup_wrong_ccitmin(drvdata);
+	caps->ccitmin = FIELD_GET(TRCIDR3_CCITMIN_MASK, etmidr3);
+	etm4_fixup_wrong_ccitmin(caps);
 
 	/* EXLEVEL_S, bits[19:16] Secure state instruction tracing */
-	drvdata->s_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_S_MASK, etmidr3);
-	drvdata->config.s_ex_level = drvdata->s_ex_level;
+	caps->s_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_S_MASK, etmidr3);
+	drvdata->config.s_ex_level = caps->s_ex_level;
 	/* EXLEVEL_NS, bits[23:20] Non-secure state instruction tracing */
-	drvdata->ns_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_NS_MASK, etmidr3);
+	caps->ns_ex_level = FIELD_GET(TRCIDR3_EXLEVEL_NS_MASK, etmidr3);
 	/*
 	 * TRCERR, bit[24] whether a trace unit can trace a
 	 * system error exception.
 	 */
-	drvdata->trc_error = !!(etmidr3 & TRCIDR3_TRCERR);
+	caps->trc_error = !!(etmidr3 & TRCIDR3_TRCERR);
 	/* SYNCPR, bit[25] implementation has a fixed synchronization period? */
-	drvdata->syncpr = !!(etmidr3 & TRCIDR3_SYNCPR);
+	caps->syncpr = !!(etmidr3 & TRCIDR3_SYNCPR);
 	/* STALLCTL, bit[26] is stall control implemented? */
-	drvdata->stallctl = !!(etmidr3 & TRCIDR3_STALLCTL);
+	caps->stallctl = !!(etmidr3 & TRCIDR3_STALLCTL);
 	/* SYSSTALL, bit[27] implementation can support stall control? */
-	drvdata->sysstall = !!(etmidr3 & TRCIDR3_SYSSTALL);
+	caps->sysstall = !!(etmidr3 & TRCIDR3_SYSSTALL);
 	/*
 	 * NUMPROC - the number of PEs available for tracing, 5bits
 	 *         = TRCIDR3.bits[13:12]bits[30:28]
 	 *  bits[4:3] = TRCIDR3.bits[13:12] (since etm-v4.2, otherwise RES0)
 	 *  bits[3:0] = TRCIDR3.bits[30:28]
 	 */
-	drvdata->nr_pe =  (FIELD_GET(TRCIDR3_NUMPROC_HI_MASK, etmidr3) << 3) |
-			   FIELD_GET(TRCIDR3_NUMPROC_LO_MASK, etmidr3);
+	caps->nr_pe = (FIELD_GET(TRCIDR3_NUMPROC_HI_MASK, etmidr3) << 3) |
+			       FIELD_GET(TRCIDR3_NUMPROC_LO_MASK, etmidr3);
 	/* NOOVERFLOW, bit[31] is trace overflow prevention supported */
-	drvdata->nooverflow = !!(etmidr3 & TRCIDR3_NOOVERFLOW);
+	caps->nooverflow = !!(etmidr3 & TRCIDR3_NOOVERFLOW);
 
 	/* number of resources trace unit supports */
 	etmidr4 = etm4x_relaxed_read32(csa, TRCIDR4);
 	/* NUMACPAIRS, bits[0:3] number of addr comparator pairs for tracing */
-	drvdata->nr_addr_cmp = FIELD_GET(TRCIDR4_NUMACPAIRS_MASK, etmidr4);
+	caps->nr_addr_cmp = FIELD_GET(TRCIDR4_NUMACPAIRS_MASK, etmidr4);
 	/* NUMPC, bits[15:12] number of PE comparator inputs for tracing */
-	drvdata->nr_pe_cmp = FIELD_GET(TRCIDR4_NUMPC_MASK, etmidr4);
+	caps->nr_pe_cmp = FIELD_GET(TRCIDR4_NUMPC_MASK, etmidr4);
 	/*
 	 * NUMRSPAIR, bits[19:16]
 	 * The number of resource pairs conveyed by the HW starts at 0, i.e a
@@ -1491,43 +1501,43 @@ static void etm4_init_arch_data(void *info)
 	 * the default TRUE and FALSE resource selectors are omitted.
 	 * Otherwise for values 0x1 and above the number is N + 1 as per v4.2.
 	 */
-	drvdata->nr_resource = FIELD_GET(TRCIDR4_NUMRSPAIR_MASK, etmidr4);
-	if ((drvdata->arch < ETM_ARCH_V4_3) || (drvdata->nr_resource > 0))
-		drvdata->nr_resource += 1;
+	caps->nr_resource = FIELD_GET(TRCIDR4_NUMRSPAIR_MASK, etmidr4);
+	if ((drvdata->arch < ETM_ARCH_V4_3) || (caps->nr_resource > 0))
+		caps->nr_resource += 1;
 	/*
 	 * NUMSSCC, bits[23:20] the number of single-shot
 	 * comparator control for tracing. Read any status regs as these
 	 * also contain RO capability data.
 	 */
-	drvdata->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
-	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
+	caps->nr_ss_cmp = FIELD_GET(TRCIDR4_NUMSSCC_MASK, etmidr4);
+	for (i = 0; i < caps->nr_ss_cmp; i++) {
 		drvdata->config.ss_status[i] =
 			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
 	}
 	/* NUMCIDC, bits[27:24] number of Context ID comparators for tracing */
-	drvdata->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);
+	caps->numcidc = FIELD_GET(TRCIDR4_NUMCIDC_MASK, etmidr4);
 	/* NUMVMIDC, bits[31:28] number of VMID comparators for tracing */
-	drvdata->numvmidc = FIELD_GET(TRCIDR4_NUMVMIDC_MASK, etmidr4);
+	caps->numvmidc = FIELD_GET(TRCIDR4_NUMVMIDC_MASK, etmidr4);
 
 	etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
 	/* NUMEXTIN, bits[8:0] number of external inputs implemented */
-	drvdata->nr_ext_inp = FIELD_GET(TRCIDR5_NUMEXTIN_MASK, etmidr5);
-	drvdata->numextinsel = FIELD_GET(TRCIDR5_NUMEXTINSEL_MASK, etmidr5);
+	caps->nr_ext_inp = FIELD_GET(TRCIDR5_NUMEXTIN_MASK, etmidr5);
+	caps->numextinsel = FIELD_GET(TRCIDR5_NUMEXTINSEL_MASK, etmidr5);
 	/* TRACEIDSIZE, bits[21:16] indicates the trace ID width */
-	drvdata->trcid_size = FIELD_GET(TRCIDR5_TRACEIDSIZE_MASK, etmidr5);
+	caps->trcid_size = FIELD_GET(TRCIDR5_TRACEIDSIZE_MASK, etmidr5);
 	/* ATBTRIG, bit[22] implementation can support ATB triggers? */
-	drvdata->atbtrig = !!(etmidr5 & TRCIDR5_ATBTRIG);
+	caps->atbtrig = !!(etmidr5 & TRCIDR5_ATBTRIG);
 	/*
 	 * LPOVERRIDE, bit[23] implementation supports
 	 * low-power state override
 	 */
-	drvdata->lpoverride = (etmidr5 & TRCIDR5_LPOVERRIDE) && (!drvdata->skip_power_up);
+	caps->lpoverride = (etmidr5 & TRCIDR5_LPOVERRIDE) && (!caps->skip_power_up);
 	/* NUMSEQSTATE, bits[27:25] number of sequencer states implemented */
-	drvdata->nrseqstate = FIELD_GET(TRCIDR5_NUMSEQSTATE_MASK, etmidr5);
-	if (drvdata->nrseqstate)
-		drvdata->nr_seq_ctrls = ETM_MAX_SEQ_TRANSITIONS;
+	caps->nrseqstate = FIELD_GET(TRCIDR5_NUMSEQSTATE_MASK, etmidr5);
+	if (caps->nrseqstate)
+		caps->nr_seq_ctrls = ETM_MAX_SEQ_TRANSITIONS;
 	/* NUMCNTR, bits[30:28] number of counters available for tracing */
-	drvdata->nr_cntr = FIELD_GET(TRCIDR5_NUMCNTR_MASK, etmidr5);
+	caps->nr_cntr = FIELD_GET(TRCIDR5_NUMCNTR_MASK, etmidr5);
 
 	coresight_clear_self_claim_tag_unlocked(csa);
 	etm4_cs_lock(drvdata, csa);
@@ -1703,7 +1713,7 @@ static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
 	 * nr_addr_cmp holds the number of comparator _pair_, so time 2
 	 * for the total number of comparators.
 	 */
-	nr_comparator = drvdata->nr_addr_cmp * 2;
+	nr_comparator = drvdata->caps.nr_addr_cmp * 2;
 
 	/* Go through the tally of comparators looking for a free one. */
 	while (index < nr_comparator) {
@@ -1860,6 +1870,7 @@ static int etm4_cpu_save(struct coresight_device *csdev)
 {
 	int i, ret = 0;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_save_state *state;
 	struct csdev_access *csa;
 	struct device *etm_dev;
@@ -1892,57 +1903,56 @@ static int etm4_cpu_save(struct coresight_device *csdev)
 
 	state = drvdata->save_state;
 
-	if (drvdata->nr_pe)
+	if (caps->nr_pe)
 		state->trcprocselr = etm4x_read32(csa, TRCPROCSELR);
 	state->trcconfigr = etm4x_read32(csa, TRCCONFIGR);
 	state->trcauxctlr = etm4x_read32(csa, TRCAUXCTLR);
 	state->trceventctl0r = etm4x_read32(csa, TRCEVENTCTL0R);
 	state->trceventctl1r = etm4x_read32(csa, TRCEVENTCTL1R);
-	if (drvdata->stallctl)
+	if (caps->stallctl)
 		state->trcstallctlr = etm4x_read32(csa, TRCSTALLCTLR);
 	state->trctsctlr = etm4x_read32(csa, TRCTSCTLR);
 	state->trcsyncpr = etm4x_read32(csa, TRCSYNCPR);
 	state->trcccctlr = etm4x_read32(csa, TRCCCCTLR);
 	state->trcbbctlr = etm4x_read32(csa, TRCBBCTLR);
 	state->trctraceidr = etm4x_read32(csa, TRCTRACEIDR);
-	if (drvdata->q_filt)
+	if (caps->q_filt)
 		state->trcqctlr = etm4x_read32(csa, TRCQCTLR);
 
 	state->trcvictlr = etm4x_read32(csa, TRCVICTLR);
 	state->trcviiectlr = etm4x_read32(csa, TRCVIIECTLR);
 	state->trcvissctlr = etm4x_read32(csa, TRCVISSCTLR);
-	if (drvdata->nr_pe_cmp)
+	if (caps->nr_pe_cmp)
 		state->trcvipcssctlr = etm4x_read32(csa, TRCVIPCSSCTLR);
 
-	for (i = 0; i < drvdata->nr_seq_ctrls; i++)
+	for (i = 0; i < caps->nr_seq_ctrls; i++)
 		state->trcseqevr[i] = etm4x_read32(csa, TRCSEQEVRn(i));
-
-	if (drvdata->nrseqstate) {
+	if (caps->nrseqstate) {
 		state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
 		state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
 	}
 
-	if (drvdata->numextinsel)
+	if (caps->numextinsel)
 		state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
 
-	for (i = 0; i < drvdata->nr_cntr; i++) {
+	for (i = 0; i < caps->nr_cntr; i++) {
 		state->trccntrldvr[i] = etm4x_read32(csa, TRCCNTRLDVRn(i));
 		state->trccntctlr[i] = etm4x_read32(csa, TRCCNTCTLRn(i));
 		state->trccntvr[i] = etm4x_read32(csa, TRCCNTVRn(i));
 	}
 
 	/* Resource selector pair 0 is reserved */
-	for (i = 2; i < drvdata->nr_resource * 2; i++)
+	for (i = 2; i < caps->nr_resource * 2; i++)
 		state->trcrsctlr[i] = etm4x_read32(csa, TRCRSCTLRn(i));
 
-	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
+	for (i = 0; i < caps->nr_ss_cmp; i++) {
 		state->trcssccr[i] = etm4x_read32(csa, TRCSSCCRn(i));
 		state->trcsscsr[i] = etm4x_read32(csa, TRCSSCSRn(i));
 		if (etm4x_sspcicrn_present(drvdata, i))
 			state->trcsspcicr[i] = etm4x_read32(csa, TRCSSPCICRn(i));
 	}
 
-	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
+	for (i = 0; i < caps->nr_addr_cmp * 2; i++) {
 		state->trcacvr[i] = etm4x_read64(csa, TRCACVRn(i));
 		state->trcacatr[i] = etm4x_read64(csa, TRCACATRn(i));
 	}
@@ -1954,23 +1964,23 @@ static int etm4_cpu_save(struct coresight_device *csdev)
 	 * unit") of ARM IHI 0064D.
 	 */
 
-	for (i = 0; i < drvdata->numcidc; i++)
+	for (i = 0; i < caps->numcidc; i++)
 		state->trccidcvr[i] = etm4x_read64(csa, TRCCIDCVRn(i));
 
-	for (i = 0; i < drvdata->numvmidc; i++)
+	for (i = 0; i < caps->numvmidc; i++)
 		state->trcvmidcvr[i] = etm4x_read64(csa, TRCVMIDCVRn(i));
 
 	state->trccidcctlr0 = etm4x_read32(csa, TRCCIDCCTLR0);
-	if (drvdata->numcidc > 4)
+	if (caps->numcidc > 4)
 		state->trccidcctlr1 = etm4x_read32(csa, TRCCIDCCTLR1);
 
 	state->trcvmidcctlr0 = etm4x_read32(csa, TRCVMIDCCTLR0);
-	if (drvdata->numvmidc > 4)
+	if (caps->numvmidc > 4)
 		state->trcvmidcctlr1 = etm4x_read32(csa, TRCVMIDCCTLR1);
 
 	state->trcclaimset = etm4x_read32(csa, TRCCLAIMCLR);
 
-	if (!drvdata->skip_power_up)
+	if (!caps->skip_power_up)
 		state->trcpdcr = etm4x_read32(csa, TRCPDCR);
 
 	/* wait for TRCSTATR.IDLE to go up */
@@ -1987,7 +1997,7 @@ static int etm4_cpu_save(struct coresight_device *csdev)
 	 * potentially save power on systems that respect the TRCPDCR_PU
 	 * despite requesting software to save/restore state.
 	 */
-	if (!drvdata->skip_power_up)
+	if (!caps->skip_power_up)
 		etm4x_relaxed_write32(csa, (state->trcpdcr & ~TRCPDCR_PU),
 				      TRCPDCR);
 out:
@@ -1999,83 +2009,84 @@ static void etm4_cpu_restore(struct coresight_device *csdev)
 {
 	int i;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_save_state *state = drvdata->save_state;
 	struct csdev_access *csa = &drvdata->csdev->access;
 
 	etm4_cs_unlock(drvdata, csa);
 	etm4x_relaxed_write32(csa, state->trcclaimset, TRCCLAIMSET);
 
-	if (drvdata->nr_pe)
+	if (caps->nr_pe)
 		etm4x_relaxed_write32(csa, state->trcprocselr, TRCPROCSELR);
 	etm4x_relaxed_write32(csa, state->trcconfigr, TRCCONFIGR);
 	etm4x_relaxed_write32(csa, state->trcauxctlr, TRCAUXCTLR);
 	etm4x_relaxed_write32(csa, state->trceventctl0r, TRCEVENTCTL0R);
 	etm4x_relaxed_write32(csa, state->trceventctl1r, TRCEVENTCTL1R);
-	if (drvdata->stallctl)
+	if (caps->stallctl)
 		etm4x_relaxed_write32(csa, state->trcstallctlr, TRCSTALLCTLR);
 	etm4x_relaxed_write32(csa, state->trctsctlr, TRCTSCTLR);
 	etm4x_relaxed_write32(csa, state->trcsyncpr, TRCSYNCPR);
 	etm4x_relaxed_write32(csa, state->trcccctlr, TRCCCCTLR);
 	etm4x_relaxed_write32(csa, state->trcbbctlr, TRCBBCTLR);
 	etm4x_relaxed_write32(csa, state->trctraceidr, TRCTRACEIDR);
-	if (drvdata->q_filt)
+	if (caps->q_filt)
 		etm4x_relaxed_write32(csa, state->trcqctlr, TRCQCTLR);
 
 	etm4x_relaxed_write32(csa, state->trcvictlr, TRCVICTLR);
 	etm4x_relaxed_write32(csa, state->trcviiectlr, TRCVIIECTLR);
 	etm4x_relaxed_write32(csa, state->trcvissctlr, TRCVISSCTLR);
-	if (drvdata->nr_pe_cmp)
+	if (caps->nr_pe_cmp)
 		etm4x_relaxed_write32(csa, state->trcvipcssctlr, TRCVIPCSSCTLR);
 
-	for (i = 0; i < drvdata->nr_seq_ctrls; i++)
+	for (i = 0; i < caps->nr_seq_ctrls; i++)
 		etm4x_relaxed_write32(csa, state->trcseqevr[i], TRCSEQEVRn(i));
 
-	if (drvdata->nrseqstate) {
+	if (caps->nrseqstate) {
 		etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
 		etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
 	}
-	if (drvdata->numextinsel)
+	if (caps->numextinsel)
 		etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
 
-	for (i = 0; i < drvdata->nr_cntr; i++) {
+	for (i = 0; i < caps->nr_cntr; i++) {
 		etm4x_relaxed_write32(csa, state->trccntrldvr[i], TRCCNTRLDVRn(i));
 		etm4x_relaxed_write32(csa, state->trccntctlr[i], TRCCNTCTLRn(i));
 		etm4x_relaxed_write32(csa, state->trccntvr[i], TRCCNTVRn(i));
 	}
 
 	/* Resource selector pair 0 is reserved */
-	for (i = 2; i < drvdata->nr_resource * 2; i++)
+	for (i = 2; i < caps->nr_resource * 2; i++)
 		etm4x_relaxed_write32(csa, state->trcrsctlr[i], TRCRSCTLRn(i));
 
-	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
+	for (i = 0; i < caps->nr_ss_cmp; i++) {
 		etm4x_relaxed_write32(csa, state->trcssccr[i], TRCSSCCRn(i));
 		etm4x_relaxed_write32(csa, state->trcsscsr[i], TRCSSCSRn(i));
 		if (etm4x_sspcicrn_present(drvdata, i))
 			etm4x_relaxed_write32(csa, state->trcsspcicr[i], TRCSSPCICRn(i));
 	}
 
-	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
+	for (i = 0; i < caps->nr_addr_cmp * 2; i++) {
 		etm4x_relaxed_write64(csa, state->trcacvr[i], TRCACVRn(i));
 		etm4x_relaxed_write64(csa, state->trcacatr[i], TRCACATRn(i));
 	}
 
-	for (i = 0; i < drvdata->numcidc; i++)
+	for (i = 0; i < caps->numcidc; i++)
 		etm4x_relaxed_write64(csa, state->trccidcvr[i], TRCCIDCVRn(i));
 
-	for (i = 0; i < drvdata->numvmidc; i++)
+	for (i = 0; i < caps->numvmidc; i++)
 		etm4x_relaxed_write64(csa, state->trcvmidcvr[i], TRCVMIDCVRn(i));
 
 	etm4x_relaxed_write32(csa, state->trccidcctlr0, TRCCIDCCTLR0);
-	if (drvdata->numcidc > 4)
+	if (caps->numcidc > 4)
 		etm4x_relaxed_write32(csa, state->trccidcctlr1, TRCCIDCCTLR1);
 
 	etm4x_relaxed_write32(csa, state->trcvmidcctlr0, TRCVMIDCCTLR0);
-	if (drvdata->numvmidc > 4)
+	if (caps->numvmidc > 4)
 		etm4x_relaxed_write32(csa, state->trcvmidcctlr1, TRCVMIDCCTLR1);
 
 	etm4x_relaxed_write32(csa, state->trcclaimset, TRCCLAIMSET);
 
-	if (!drvdata->skip_power_up)
+	if (!caps->skip_power_up)
 		etm4x_relaxed_write32(csa, state->trcpdcr, TRCPDCR);
 
 	/*
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index cc6cdd3ae29d..2d8a8f64a038 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -62,8 +62,9 @@ static ssize_t nr_pe_cmp_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 
-	val = drvdata->nr_pe_cmp;
+	val = caps->nr_pe_cmp;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_pe_cmp);
@@ -74,8 +75,9 @@ static ssize_t nr_addr_cmp_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 
-	val = drvdata->nr_addr_cmp;
+	val = caps->nr_addr_cmp;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_addr_cmp);
@@ -86,8 +88,9 @@ static ssize_t nr_cntr_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 
-	val = drvdata->nr_cntr;
+	val = caps->nr_cntr;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_cntr);
@@ -98,8 +101,9 @@ static ssize_t nr_ext_inp_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 
-	val = drvdata->nr_ext_inp;
+	val = caps->nr_ext_inp;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_ext_inp);
@@ -110,8 +114,9 @@ static ssize_t numcidc_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 
-	val = drvdata->numcidc;
+	val = caps->numcidc;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(numcidc);
@@ -122,8 +127,9 @@ static ssize_t numvmidc_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 
-	val = drvdata->numvmidc;
+	val = caps->numvmidc;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(numvmidc);
@@ -134,8 +140,9 @@ static ssize_t nrseqstate_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 
-	val = drvdata->nrseqstate;
+	val = caps->nrseqstate;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nrseqstate);
@@ -146,8 +153,9 @@ static ssize_t nr_resource_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 
-	val = drvdata->nr_resource;
+	val = caps->nr_resource;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_resource);
@@ -158,8 +166,9 @@ static ssize_t nr_ss_cmp_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 
-	val = drvdata->nr_ss_cmp;
+	val = caps->nr_ss_cmp;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_ss_cmp);
@@ -171,6 +180,7 @@ static ssize_t reset_store(struct device *dev,
 	int i;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
@@ -200,7 +210,7 @@ static ssize_t reset_store(struct device *dev,
 	config->stall_ctrl = 0x0;
 
 	/* Reset trace synchronization period  to 2^8 = 256 bytes*/
-	if (drvdata->syncpr == false)
+	if (!caps->syncpr)
 		config->syncfreq = 0x8;
 
 	/*
@@ -209,7 +219,7 @@ static ssize_t reset_store(struct device *dev,
 	 * each trace run.
 	 */
 	config->vinst_ctrl = FIELD_PREP(TRCVICTLR_EVENT_MASK, 0x01);
-	if (drvdata->nr_addr_cmp > 0) {
+	if (caps->nr_addr_cmp > 0) {
 		config->mode |= ETM_MODE_VIEWINST_STARTSTOP;
 		/* SSSTATUS, bit[9] */
 		config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
@@ -223,7 +233,7 @@ static ssize_t reset_store(struct device *dev,
 	config->vipcssctlr = 0x0;
 
 	/* Disable seq events */
-	for (i = 0; i < drvdata->nr_seq_ctrls; i++)
+	for (i = 0; i < caps->nr_seq_ctrls; i++)
 		config->seq_ctrl[i] = 0x0;
 	config->seq_rst = 0x0;
 	config->seq_state = 0x0;
@@ -232,38 +242,38 @@ static ssize_t reset_store(struct device *dev,
 	config->ext_inp = 0x0;
 
 	config->cntr_idx = 0x0;
-	for (i = 0; i < drvdata->nr_cntr; i++) {
+	for (i = 0; i < caps->nr_cntr; i++) {
 		config->cntrldvr[i] = 0x0;
 		config->cntr_ctrl[i] = 0x0;
 		config->cntr_val[i] = 0x0;
 	}
 
 	config->res_idx = 0x0;
-	for (i = 2; i < 2 * drvdata->nr_resource; i++)
+	for (i = 2; i < 2 * caps->nr_resource; i++)
 		config->res_ctrl[i] = 0x0;
 
 	config->ss_idx = 0x0;
-	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
+	for (i = 0; i < caps->nr_ss_cmp; i++) {
 		config->ss_ctrl[i] = 0x0;
 		config->ss_pe_cmp[i] = 0x0;
 	}
 
 	config->addr_idx = 0x0;
-	for (i = 0; i < drvdata->nr_addr_cmp * 2; i++) {
+	for (i = 0; i < caps->nr_addr_cmp * 2; i++) {
 		config->addr_val[i] = 0x0;
 		config->addr_acc[i] = 0x0;
 		config->addr_type[i] = ETM_ADDR_TYPE_NONE;
 	}
 
 	config->ctxid_idx = 0x0;
-	for (i = 0; i < drvdata->numcidc; i++)
+	for (i = 0; i < caps->numcidc; i++)
 		config->ctxid_pid[i] = 0x0;
 
 	config->ctxid_mask0 = 0x0;
 	config->ctxid_mask1 = 0x0;
 
 	config->vmid_idx = 0x0;
-	for (i = 0; i < drvdata->numvmidc; i++)
+	for (i = 0; i < caps->numvmidc; i++)
 		config->vmid_val[i] = 0x0;
 	config->vmid_mask0 = 0x0;
 	config->vmid_mask1 = 0x0;
@@ -297,6 +307,7 @@ static ssize_t mode_store(struct device *dev,
 {
 	unsigned long val, mode;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
@@ -305,7 +316,7 @@ static ssize_t mode_store(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	config->mode = val & ETMv4_MODE_ALL;
 
-	if (drvdata->instrp0 == true) {
+	if (caps->instrp0) {
 		/* start by clearing instruction P0 field */
 		config->cfg  &= ~TRCCONFIGR_INSTP0_LOAD_STORE;
 		if (config->mode & ETM_MODE_LOAD)
@@ -323,45 +334,44 @@ static ssize_t mode_store(struct device *dev,
 	}
 
 	/* bit[3], Branch broadcast mode */
-	if ((config->mode & ETM_MODE_BB) && (drvdata->trcbb == true))
+	if ((config->mode & ETM_MODE_BB) && (caps->trcbb))
 		config->cfg |= TRCCONFIGR_BB;
 	else
 		config->cfg &= ~TRCCONFIGR_BB;
 
 	/* bit[4], Cycle counting instruction trace bit */
 	if ((config->mode & ETMv4_MODE_CYCACC) &&
-		(drvdata->trccci == true))
+		(caps->trccci == true))
 		config->cfg |= TRCCONFIGR_CCI;
 	else
 		config->cfg &= ~TRCCONFIGR_CCI;
 
 	/* bit[6], Context ID tracing bit */
-	if ((config->mode & ETMv4_MODE_CTXID) && (drvdata->ctxid_size))
+	if ((config->mode & ETMv4_MODE_CTXID) && (caps->ctxid_size))
 		config->cfg |= TRCCONFIGR_CID;
 	else
 		config->cfg &= ~TRCCONFIGR_CID;
 
-	if ((config->mode & ETM_MODE_VMID) && (drvdata->vmid_size))
+	if ((config->mode & ETM_MODE_VMID) && (caps->vmid_size))
 		config->cfg |= TRCCONFIGR_VMID;
 	else
 		config->cfg &= ~TRCCONFIGR_VMID;
 
 	/* bits[10:8], Conditional instruction tracing bit */
 	mode = ETM_MODE_COND(config->mode);
-	if (drvdata->trccond == true) {
+	if (caps->trccond) {
 		config->cfg &= ~TRCCONFIGR_COND_MASK;
 		config->cfg |= mode << __bf_shf(TRCCONFIGR_COND_MASK);
 	}
 
 	/* bit[11], Global timestamp tracing bit */
-	if ((config->mode & ETMv4_MODE_TIMESTAMP) && (drvdata->ts_size))
+	if ((config->mode & ETMv4_MODE_TIMESTAMP) && (caps->ts_size))
 		config->cfg |= TRCCONFIGR_TS;
 	else
 		config->cfg &= ~TRCCONFIGR_TS;
 
 	/* bit[12], Return stack enable bit */
-	if ((config->mode & ETM_MODE_RETURNSTACK) &&
-					(drvdata->retstack == true))
+	if ((config->mode & ETM_MODE_RETURNSTACK) && (caps->retstack))
 		config->cfg |= TRCCONFIGR_RS;
 	else
 		config->cfg &= ~TRCCONFIGR_RS;
@@ -375,31 +385,29 @@ static ssize_t mode_store(struct device *dev,
 	 * Always set the low bit for any requested mode. Valid combos are
 	 * 0b00, 0b01 and 0b11.
 	 */
-	if (mode && drvdata->q_support)
+	if (mode && caps->q_support)
 		config->cfg |= TRCCONFIGR_QE_W_COUNTS;
 	/*
 	 * if supported, Q elements with and without instruction
 	 * counts are enabled
 	 */
-	if ((mode & BIT(1)) && (drvdata->q_support & BIT(1)))
+	if ((mode & BIT(1)) && (caps->q_support & BIT(1)))
 		config->cfg |= TRCCONFIGR_QE_WO_COUNTS;
 
 	/* bit[11], AMBA Trace Bus (ATB) trigger enable bit */
-	if ((config->mode & ETM_MODE_ATB_TRIGGER) &&
-	    (drvdata->atbtrig == true))
+	if ((config->mode & ETM_MODE_ATB_TRIGGER) && (caps->atbtrig))
 		config->eventctrl1 |= TRCEVENTCTL1R_ATB;
 	else
 		config->eventctrl1 &= ~TRCEVENTCTL1R_ATB;
 
 	/* bit[12], Low-power state behavior override bit */
-	if ((config->mode & ETM_MODE_LPOVERRIDE) &&
-	    (drvdata->lpoverride == true))
+	if ((config->mode & ETM_MODE_LPOVERRIDE) && (caps->lpoverride))
 		config->eventctrl1 |= TRCEVENTCTL1R_LPOVERRIDE;
 	else
 		config->eventctrl1 &= ~TRCEVENTCTL1R_LPOVERRIDE;
 
 	/* bit[8], Instruction stall bit */
-	if ((config->mode & ETM_MODE_ISTALL_EN) && (drvdata->stallctl == true))
+	if ((config->mode & ETM_MODE_ISTALL_EN) && (caps->stallctl))
 		config->stall_ctrl |= TRCSTALLCTLR_ISTALL;
 	else
 		config->stall_ctrl &= ~TRCSTALLCTLR_ISTALL;
@@ -411,8 +419,7 @@ static ssize_t mode_store(struct device *dev,
 		config->stall_ctrl &= ~TRCSTALLCTLR_INSTPRIORITY;
 
 	/* bit[13], Trace overflow prevention bit */
-	if ((config->mode & ETM_MODE_NOOVERFLOW) &&
-		(drvdata->nooverflow == true))
+	if ((config->mode & ETM_MODE_NOOVERFLOW) && (caps->nooverflow))
 		config->stall_ctrl |= TRCSTALLCTLR_NOOVERFLOW;
 	else
 		config->stall_ctrl &= ~TRCSTALLCTLR_NOOVERFLOW;
@@ -430,8 +437,7 @@ static ssize_t mode_store(struct device *dev,
 		config->vinst_ctrl &= ~TRCVICTLR_TRCRESET;
 
 	/* bit[11], Whether a trace unit must trace a system error exception */
-	if ((config->mode & ETM_MODE_TRACE_ERR) &&
-		(drvdata->trc_error == true))
+	if ((config->mode & ETM_MODE_TRACE_ERR) && (caps->trc_error))
 		config->vinst_ctrl |= TRCVICTLR_TRCERR;
 	else
 		config->vinst_ctrl &= ~TRCVICTLR_TRCERR;
@@ -463,13 +469,14 @@ static ssize_t pe_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	if (val > drvdata->nr_pe) {
+	if (val > caps->nr_pe) {
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
@@ -498,13 +505,14 @@ static ssize_t event_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
-	switch (drvdata->nr_event) {
+	switch (caps->nr_event) {
 	case 0x0:
 		/* EVENT0, bits[7:0] */
 		config->eventctrl0 = val & 0xFF;
@@ -547,6 +555,7 @@ static ssize_t event_instren_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
@@ -555,7 +564,7 @@ static ssize_t event_instren_store(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	/* start by clearing all instruction event enable bits */
 	config->eventctrl1 &= ~TRCEVENTCTL1R_INSTEN_MASK;
-	switch (drvdata->nr_event) {
+	switch (caps->nr_event) {
 	case 0x0:
 		/* generate Event element for event 1 */
 		config->eventctrl1 |= val & TRCEVENTCTL1R_INSTEN_1;
@@ -603,11 +612,12 @@ static ssize_t event_ts_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (!drvdata->ts_size)
+	if (!caps->ts_size)
 		return -EINVAL;
 
 	config->ts_ctrl = val & ETMv4_EVENT_MASK;
@@ -633,11 +643,12 @@ static ssize_t syncfreq_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (drvdata->syncpr == true)
+	if (caps->syncpr)
 		return -EINVAL;
 
 	config->syncfreq = val & ETMv4_SYNC_MASK;
@@ -663,6 +674,7 @@ static ssize_t cyc_threshold_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
@@ -670,7 +682,7 @@ static ssize_t cyc_threshold_store(struct device *dev,
 
 	/* mask off max threshold before checking min value */
 	val &= ETM_CYC_THRESHOLD_MASK;
-	if (val < drvdata->ccitmin)
+	if (val < caps->ccitmin)
 		return -EINVAL;
 
 	config->ccctlr = val;
@@ -696,13 +708,14 @@ static ssize_t bb_ctrl_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (drvdata->trcbb == false)
+	if (!caps->trcbb)
 		return -EINVAL;
-	if (!drvdata->nr_addr_cmp)
+	if (!caps->nr_addr_cmp)
 		return -EINVAL;
 
 	/*
@@ -768,6 +781,7 @@ static ssize_t s_exlevel_vinst_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
@@ -777,7 +791,7 @@ static ssize_t s_exlevel_vinst_store(struct device *dev,
 	/* clear all EXLEVEL_S bits  */
 	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_S_MASK;
 	/* enable instruction tracing for corresponding exception level */
-	val &= drvdata->s_ex_level;
+	val &= caps->s_ex_level;
 	config->vinst_ctrl |= val << __bf_shf(TRCVICTLR_EXLEVEL_S_MASK);
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
@@ -803,6 +817,7 @@ static ssize_t ns_exlevel_vinst_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
@@ -812,7 +827,7 @@ static ssize_t ns_exlevel_vinst_store(struct device *dev,
 	/* clear EXLEVEL_NS bits  */
 	config->vinst_ctrl &= ~TRCVICTLR_EXLEVEL_NS_MASK;
 	/* enable instruction tracing for corresponding exception level */
-	val &= drvdata->ns_ex_level;
+	val &= caps->ns_ex_level;
 	config->vinst_ctrl |= val << __bf_shf(TRCVICTLR_EXLEVEL_NS_MASK);
 	raw_spin_unlock(&drvdata->spinlock);
 	return size;
@@ -837,11 +852,12 @@ static ssize_t addr_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (val >= drvdata->nr_addr_cmp * 2)
+	if (val >= caps->nr_addr_cmp * 2)
 		return -EINVAL;
 
 	/*
@@ -1060,6 +1076,7 @@ static ssize_t addr_start_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
@@ -1067,7 +1084,7 @@ static ssize_t addr_start_store(struct device *dev,
 
 	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
-	if (!drvdata->nr_addr_cmp) {
+	if (!caps->nr_addr_cmp) {
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
@@ -1115,6 +1132,7 @@ static ssize_t addr_stop_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
@@ -1122,7 +1140,7 @@ static ssize_t addr_stop_store(struct device *dev,
 
 	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
-	if (!drvdata->nr_addr_cmp) {
+	if (!caps->nr_addr_cmp) {
 		raw_spin_unlock(&drvdata->spinlock);
 		return -EINVAL;
 	}
@@ -1167,6 +1185,7 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 	u8 idx;
 	char str[10] = "";
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (strlen(buf) >= 10)
@@ -1181,13 +1200,13 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 		config->addr_acc[idx] &= ~TRCACATRn_CONTEXTTYPE_MASK;
 	else if (!strcmp(str, "ctxid")) {
 		/* 0b01 The trace unit performs a Context ID */
-		if (drvdata->numcidc) {
+		if (caps->numcidc) {
 			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_CTXID;
 			config->addr_acc[idx] &= ~TRCACATRn_CONTEXTTYPE_VMID;
 		}
 	} else if (!strcmp(str, "vmid")) {
 		/* 0b10 The trace unit performs a VMID */
-		if (drvdata->numvmidc) {
+		if (caps->numvmidc) {
 			config->addr_acc[idx] &= ~TRCACATRn_CONTEXTTYPE_CTXID;
 			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_VMID;
 		}
@@ -1196,9 +1215,9 @@ static ssize_t addr_ctxtype_store(struct device *dev,
 		 * 0b11 The trace unit performs a Context ID
 		 * comparison and a VMID
 		 */
-		if (drvdata->numcidc)
+		if (caps->numcidc)
 			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_CTXID;
-		if (drvdata->numvmidc)
+		if (caps->numvmidc)
 			config->addr_acc[idx] |= TRCACATRn_CONTEXTTYPE_VMID;
 	}
 	raw_spin_unlock(&drvdata->spinlock);
@@ -1230,14 +1249,15 @@ static ssize_t addr_context_store(struct device *dev,
 	u8 idx;
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if ((drvdata->numcidc <= 1) && (drvdata->numvmidc <= 1))
+	if ((caps->numcidc <= 1) && (caps->numvmidc <= 1))
 		return -EINVAL;
-	if (val >=  (drvdata->numcidc >= drvdata->numvmidc ?
-		     drvdata->numcidc : drvdata->numvmidc))
+	if (val >=  (caps->numcidc >= caps->numvmidc ?
+		     caps->numcidc : caps->numvmidc))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
@@ -1348,9 +1368,10 @@ static ssize_t vinst_pe_cmp_start_stop_show(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
-	if (!drvdata->nr_pe_cmp)
+	if (!caps->nr_pe_cmp)
 		return -EINVAL;
 	val = config->vipcssctlr;
 	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
@@ -1361,11 +1382,12 @@ static ssize_t vinst_pe_cmp_start_stop_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (!drvdata->nr_pe_cmp)
+	if (!caps->nr_pe_cmp)
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
@@ -1393,13 +1415,14 @@ static ssize_t seq_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
-	if (!drvdata->nr_seq_ctrls)
+	if (!caps->nr_seq_ctrls)
 		return -ENOTSUPP;
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (val >= drvdata->nr_seq_ctrls)
+	if (val >= caps->nr_seq_ctrls)
 		return -EINVAL;
 
 	/*
@@ -1431,11 +1454,12 @@ static ssize_t seq_state_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (val >= drvdata->nrseqstate)
+	if (val >= caps->nrseqstate)
 		return -EINVAL;
 
 	config->seq_state = val;
@@ -1498,11 +1522,12 @@ static ssize_t seq_reset_event_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (!(drvdata->nrseqstate))
+	if (!(caps->nrseqstate))
 		return -EINVAL;
 
 	config->seq_rst = val & ETMv4_EVENT_MASK;
@@ -1528,11 +1553,12 @@ static ssize_t cntr_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (val >= drvdata->nr_cntr)
+	if (val >= caps->nr_cntr)
 		return -EINVAL;
 
 	/*
@@ -1676,6 +1702,7 @@ static ssize_t res_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
@@ -1684,7 +1711,7 @@ static ssize_t res_idx_store(struct device *dev,
 	 * Resource selector pair 0 is always implemented and reserved,
 	 * namely an idx with 0 and 1 is illegal.
 	 */
-	if ((val < 2) || (val >= 2 * drvdata->nr_resource))
+	if ((val < 2) || (val >= 2 * caps->nr_resource))
 		return -EINVAL;
 
 	/*
@@ -1758,11 +1785,12 @@ static ssize_t sshot_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (val >= drvdata->nr_ss_cmp)
+	if (val >= caps->nr_ss_cmp)
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
@@ -1876,11 +1904,12 @@ static ssize_t ctxid_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (val >= drvdata->numcidc)
+	if (val >= caps->numcidc)
 		return -EINVAL;
 
 	/*
@@ -1924,6 +1953,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	u8 idx;
 	unsigned long pid;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	/*
@@ -1943,7 +1973,7 @@ static ssize_t ctxid_pid_store(struct device *dev,
 	 * ctxid comparator is implemented and ctxid is greater than 0 bits
 	 * in length
 	 */
-	if (!drvdata->ctxid_size || !drvdata->numcidc)
+	if (!caps->ctxid_size || !caps->numcidc)
 		return -EINVAL;
 	if (kstrtoul(buf, 16, &pid))
 		return -EINVAL;
@@ -1985,6 +2015,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	u8 i, j, maskbyte;
 	unsigned long val1, val2, mask;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 	int nr_inputs;
 
@@ -2000,11 +2031,11 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	 * ctxid comparator is implemented and ctxid is greater than 0 bits
 	 * in length
 	 */
-	if (!drvdata->ctxid_size || !drvdata->numcidc)
+	if (!caps->ctxid_size || !caps->numcidc)
 		return -EINVAL;
 	/* one mask if <= 4 comparators, two for up to 8 */
 	nr_inputs = sscanf(buf, "%lx %lx", &val1, &val2);
-	if ((drvdata->numcidc > 4) && (nr_inputs != 2))
+	if ((caps->numcidc > 4) && (nr_inputs != 2))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
@@ -2012,7 +2043,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	 * each byte[0..3] controls mask value applied to ctxid
 	 * comparator[0..3]
 	 */
-	switch (drvdata->numcidc) {
+	switch (caps->numcidc) {
 	case 0x1:
 		/* COMP0, bits[7:0] */
 		config->ctxid_mask0 = val1 & 0xFF;
@@ -2059,7 +2090,7 @@ static ssize_t ctxid_masks_store(struct device *dev,
 	 * of ctxid comparator0 value (corresponding to byte 0) register.
 	 */
 	mask = config->ctxid_mask0;
-	for (i = 0; i < drvdata->numcidc; i++) {
+	for (i = 0; i < caps->numcidc; i++) {
 		/* mask value of corresponding ctxid comparator */
 		maskbyte = mask & ETMv4_EVENT_MASK;
 		/*
@@ -2102,11 +2133,12 @@ static ssize_t vmid_idx_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
-	if (val >= drvdata->numvmidc)
+	if (val >= caps->numvmidc)
 		return -EINVAL;
 
 	/*
@@ -2147,6 +2179,7 @@ static ssize_t vmid_val_store(struct device *dev,
 {
 	unsigned long val;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 
 	/*
@@ -2160,7 +2193,7 @@ static ssize_t vmid_val_store(struct device *dev,
 	 * only implemented when vmid tracing is enabled, i.e. at least one
 	 * vmid comparator is implemented and at least 8 bit vmid size
 	 */
-	if (!drvdata->vmid_size || !drvdata->numvmidc)
+	if (!caps->vmid_size || !caps->numvmidc)
 		return -EINVAL;
 	if (kstrtoul(buf, 16, &val))
 		return -EINVAL;
@@ -2200,6 +2233,7 @@ static ssize_t vmid_masks_store(struct device *dev,
 	u8 i, j, maskbyte;
 	unsigned long val1, val2, mask;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
+	const struct etmv4_caps *caps = &drvdata->caps;
 	struct etmv4_config *config = &drvdata->config;
 	int nr_inputs;
 
@@ -2214,11 +2248,11 @@ static ssize_t vmid_masks_store(struct device *dev,
 	 * only implemented when vmid tracing is enabled, i.e. at least one
 	 * vmid comparator is implemented and at least 8 bit vmid size
 	 */
-	if (!drvdata->vmid_size || !drvdata->numvmidc)
+	if (!caps->vmid_size || !caps->numvmidc)
 		return -EINVAL;
 	/* one mask if <= 4 comparators, two for up to 8 */
 	nr_inputs = sscanf(buf, "%lx %lx", &val1, &val2);
-	if ((drvdata->numvmidc > 4) && (nr_inputs != 2))
+	if ((caps->numvmidc > 4) && (nr_inputs != 2))
 		return -EINVAL;
 
 	raw_spin_lock(&drvdata->spinlock);
@@ -2227,7 +2261,7 @@ static ssize_t vmid_masks_store(struct device *dev,
 	 * each byte[0..3] controls mask value applied to vmid
 	 * comparator[0..3]
 	 */
-	switch (drvdata->numvmidc) {
+	switch (caps->numvmidc) {
 	case 0x1:
 		/* COMP0, bits[7:0] */
 		config->vmid_mask0 = val1 & 0xFF;
@@ -2275,7 +2309,7 @@ static ssize_t vmid_masks_store(struct device *dev,
 	 * of vmid comparator0 value (corresponding to byte 0) register.
 	 */
 	mask = config->vmid_mask0;
-	for (i = 0; i < drvdata->numvmidc; i++) {
+	for (i = 0; i < caps->numvmidc; i++) {
 		/* mask value of corresponding vmid comparator */
 		maskbyte = mask & ETMv4_EVENT_MASK;
 		/*
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index c33700711154..ffde48b6b41b 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -813,6 +813,97 @@ enum etm_impdef_type {
 	ETM4_IMPDEF_FEATURE_MAX,
 };
 
+/**
+ * struct etmv4_caps - specifics ETM capabilities
+ * @nr_pe:	The number of processing entity available for tracing.
+ * @nr_pe_cmp:	The number of processing entity comparator inputs that are
+ *		available for tracing.
+ * @nr_addr_cmp:Number of pairs of address comparators available
+ *		as found in ETMIDR4 0-3.
+ * @nr_cntr:    Number of counters as found in ETMIDR5 bit 28-30.
+ * @nr_ext_inp: Number of external input.
+ * @numcidc:	Number of contextID comparators.
+ * @numextinsel: Number of external input selector resources.
+ * @numvmidc:	Number of VMID comparators.
+ * @nrseqstate: The number of sequencer states that are implemented.
+ * @nr_seq_ctrls: The number of sequence state transition control registers.
+ * @nr_event:	Indicates how many events the trace unit support.
+ * @nr_resource:The number of resource selection pairs available for tracing.
+ * @nr_ss_cmp:	Number of single-shot comparator controls that are available.
+ * @trcid_size: Indicates the trace ID width.
+ * @ts_size:	Global timestamp size field.
+ * @ctxid_size:	Size of the context ID field to consider.
+ * @vmid_size:	Size of the VM ID comparator to consider.
+ * @ccsize:	Indicates the size of the cycle counter in bits.
+ * @ccitmin:	minimum value that can be programmed in
+ * @s_ex_level:	In secure state, indicates whether instruction tracing is
+ *		supported for the corresponding Exception level.
+ * @ns_ex_level:In non-secure state, indicates whether instruction tracing is
+ *		supported for the corresponding Exception level.
+ * @q_support:	Q element support characteristics.
+ * @os_lock_model: OSLock model.
+ * @instrp0:	Tracing of load and store instructions
+ *		as P0 elements is supported.
+ * @q_filt:	Q element filtering support, if Q elements are supported.
+ * @trcbb:	Indicates if the trace unit supports branch broadcast tracing.
+ * @trccond:	If the trace unit supports conditional
+ *		instruction tracing.
+ * @retstack:	Indicates if the implementation supports a return stack.
+ * @trccci:	Indicates if the trace unit supports cycle counting
+ *		for instruction.
+ * @trc_error:	Whether a trace unit can trace a system
+ *		error exception.
+ * @syncpr:	Indicates if an implementation has a fixed
+ *		synchronization period.
+ * @stallctl:	If functionality that prevents trace unit buffer overflows
+ *		is available.
+ * @sysstall:	Does the system support stall control of the PE?
+ * @nooverflow:	Indicate if overflow prevention is supported.
+ * @atbtrig:	If the implementation can support ATB triggers
+ * @lpoverride:	If the implementation can support low-power state over.
+ * @skip_power_up: Indicates if an implementation can skip powering up
+ *		   the trace unit.
+ */
+struct etmv4_caps {
+	u8	nr_pe;
+	u8	nr_pe_cmp;
+	u8	nr_addr_cmp;
+	u8	nr_cntr;
+	u8	nr_ext_inp;
+	u8	numcidc;
+	u8	numextinsel;
+	u8	numvmidc;
+	u8	nrseqstate;
+	u8	nr_seq_ctrls;
+	u8	nr_event;
+	u8	nr_resource;
+	u8	nr_ss_cmp;
+	u8	trcid_size;
+	u8	ts_size;
+	u8	ctxid_size;
+	u8	vmid_size;
+	u8	ccsize;
+	u16	ccitmin;
+	u8	s_ex_level;
+	u8	ns_ex_level;
+	u8	q_support;
+	u8	os_lock_model;
+	bool	instrp0 : 1;
+	bool	q_filt : 1;
+	bool	trcbb : 1;
+	bool	trccond : 1;
+	bool	retstack : 1;
+	bool	trccci : 1;
+	bool	trc_error : 1;
+	bool	syncpr : 1;
+	bool	stallctl : 1;
+	bool	sysstall : 1;
+	bool	nooverflow : 1;
+	bool	atbtrig : 1;
+	bool	lpoverride : 1;
+	bool	skip_power_up : 1;
+};
+
 /**
  * struct etmv4_config - configuration information related to an ETMv4
  * @mode:	Controls various modes supported by this ETM.
@@ -820,8 +911,8 @@ enum etm_impdef_type {
  * @cfg:	Controls the tracing options.
  * @eventctrl0: Controls the tracing of arbitrary events.
  * @eventctrl1: Controls the behavior of the events that @event_ctrl0 selects.
- * @stallctl:	If functionality that prevents trace unit buffer overflows
- *		is available.
+ * @stall_ctrl:	Enables trace unit functionality that prevents trace
+ *		unit buffer overflows.
  * @ts_ctrl:	Controls the insertion of global timestamps in the
  *		trace streams.
  * @syncfreq:	Controls how often trace synchronization requests occur.
@@ -967,54 +1058,11 @@ struct etmv4_save_state {
  * @mode:	This tracer's mode, i.e sysFS, Perf or disabled.
  * @cpu:        The cpu this component is affined to.
  * @arch:       ETM architecture version.
- * @nr_pe:	The number of processing entity available for tracing.
- * @nr_pe_cmp:	The number of processing entity comparator inputs that are
- *		available for tracing.
- * @nr_addr_cmp:Number of pairs of address comparators available
- *		as found in ETMIDR4 0-3.
- * @nr_cntr:    Number of counters as found in ETMIDR5 bit 28-30.
- * @nr_ext_inp: Number of external input.
- * @numcidc:	Number of contextID comparators.
- * @numvmidc:	Number of VMID comparators.
- * @nrseqstate: The number of sequencer states that are implemented.
- * @nr_seq_ctrls: The number of sequence state transition control registers.
- * @nr_event:	Indicates how many events the trace unit support.
- * @nr_resource:The number of resource selection pairs available for tracing.
- * @nr_ss_cmp:	Number of single-shot comparator controls that are available.
+ * @caps:	ETM capabilities.
  * @trcid:	value of the current ID for this component.
- * @trcid_size: Indicates the trace ID width.
- * @ts_size:	Global timestamp size field.
- * @ctxid_size:	Size of the context ID field to consider.
- * @vmid_size:	Size of the VM ID comparator to consider.
- * @ccsize:	Indicates the size of the cycle counter in bits.
- * @ccitmin:	minimum value that can be programmed in
- * @s_ex_level:	In secure state, indicates whether instruction tracing is
- *		supported for the corresponding Exception level.
- * @ns_ex_level:In non-secure state, indicates whether instruction tracing is
- *		supported for the corresponding Exception level.
  * @sticky_enable: true if ETM base configuration has been done.
  * @boot_enable:True if we should start tracing at boot time.
  * @os_unlock:  True if access to management registers is allowed.
- * @instrp0:	Tracing of load and store instructions
- *		as P0 elements is supported.
- * @q_filt:	Q element filtering support, if Q elements are supported.
- * @trcbb:	Indicates if the trace unit supports branch broadcast tracing.
- * @trccond:	If the trace unit supports conditional
- *		instruction tracing.
- * @retstack:	Indicates if the implementation supports a return stack.
- * @trccci:	Indicates if the trace unit supports cycle counting
- *		for instruction.
- * @q_support:	Q element support characteristics.
- * @trc_error:	Whether a trace unit can trace a system
- *		error exception.
- * @syncpr:	Indicates if an implementation has a fixed
- *		synchronization period.
- * @stall_ctrl:	Enables trace unit functionality that prevents trace
- *		unit buffer overflows.
- * @sysstall:	Does the system support stall control of the PE?
- * @nooverflow:	Indicate if overflow prevention is supported.
- * @atbtrig:	If the implementation can support ATB triggers
- * @lpoverride:	If the implementation can support low-power state over.
  * @trfcr:	If the CPU supports FEAT_TRF, value of the TRFCR_ELx that
  *		allows tracing at all ELs. We don't want to compute this
  *		at runtime, due to the additional setting of TRFCR_CX when
@@ -1022,8 +1070,6 @@ struct etmv4_save_state {
  * @active_config:	structure holding current applied configuration.
  * @config:	structure holding sysfs mode configuration.
  * @save_state:	State to be preserved across power loss
- * @skip_power_up: Indicates if an implementation can skip powering up
- *		   the trace unit.
  * @paused:	Indicates if the trace unit is paused.
  * @arch_features: Bitmap of arch features of etmv4 devices.
  */
@@ -1035,47 +1081,11 @@ struct etmv4_drvdata {
 	raw_spinlock_t			spinlock;
 	int				cpu;
 	u8				arch;
-	u8				nr_pe;
-	u8				nr_pe_cmp;
-	u8				nr_addr_cmp;
-	u8				nr_cntr;
-	u8				nr_ext_inp;
-	u8				numcidc;
-	u8				numextinsel;
-	u8				numvmidc;
-	u8				nrseqstate;
-	u8				nr_seq_ctrls;
-	u8				nr_event;
-	u8				nr_resource;
-	u8				nr_ss_cmp;
+	struct etmv4_caps		caps;
 	u8				trcid;
-	u8				trcid_size;
-	u8				ts_size;
-	u8				ctxid_size;
-	u8				vmid_size;
-	u8				ccsize;
-	u16				ccitmin;
-	u8				s_ex_level;
-	u8				ns_ex_level;
-	u8				q_support;
-	u8				os_lock_model;
 	bool				sticky_enable : 1;
 	bool				boot_enable : 1;
 	bool				os_unlock : 1;
-	bool				instrp0 : 1;
-	bool				q_filt : 1;
-	bool				trcbb : 1;
-	bool				trccond : 1;
-	bool				retstack : 1;
-	bool				trccci : 1;
-	bool				trc_error : 1;
-	bool				syncpr : 1;
-	bool				stallctl : 1;
-	bool				sysstall : 1;
-	bool				nooverflow : 1;
-	bool				atbtrig : 1;
-	bool				lpoverride : 1;
-	bool				skip_power_up : 1;
 	bool				paused : 1;
 	u64				trfcr;
 	struct etmv4_config		active_config;

-- 
2.43.0

