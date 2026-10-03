Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F7538B7D2
	for <linux-rt-devel@lists.linux.dev>; Sat,  3 Oct 2026 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790995980; cv=none; b=E7Ojr66zMzt7XV1MKGm2AoRvGT2oPU5cGyquSzE8nVLqoKrVzpG54IvCC+NTp5wtv3HGwURFz3jO5b5GnLyDukHAEfDpsPMIl4o3aUIbWkWEvkSqqk6xtRQKfCvJkrC/5UPPJsc4NaKX4YJ6bv8UcaCrkGYUEnpH2UacwVma9iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790995980; c=relaxed/simple;
	bh=u0wXBVCHyA/A/wY8hrY601fO0zbn2h2CmaxcCDdq9gc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d91slP94AcYDK7JqRpUXBVDw11mwESlKh097tRf09qSWlZr89xA0FnfQ81EUVm+Yf1sCZ9AOifQdE/e7PTM6WymyKwcAJEBVYeehqN26eEAEXR0w9N6aIyyfGZKhSO7EFSX2jHEMEtNozGFAZEL8OPSYBS52sXj/eTteuk5bZww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=DNmlgC/+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="DNmlgC/+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B1BE143D;
	Fri,  2 Oct 2026 19:52:53 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89DAD3F763;
	Fri,  2 Oct 2026 19:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790995976; bh=u0wXBVCHyA/A/wY8hrY601fO0zbn2h2CmaxcCDdq9gc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DNmlgC/+TXvScXro249pNKallMxAm9d78PmLPZhGG5aDDVuY/lYZFq7DIGoc08osJ
	 Ig99A8VlbA5hGxpIn8YveUA2O/N/djRwxHFaq2q/lDOCQKiCeRviaOiKa+sPsvAMB2
	 Bk0CBd+DEYqul/vzcK0anC+4t4uktbIMcmJeJRQ0=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Sat, 03 Oct 2026 03:52:22 +0100
Subject: [PATCH RESEND v13 10/14] coresight: etm4x: rename local config as
 curr_config referring drvdata->curr_config
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-separate_etm_cfg_v2-v13-10-5d8a29aead95@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=19252; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=u0wXBVCHyA/A/wY8hrY601fO0zbn2h2CmaxcCDdq9gc=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqwG3qrllhwQe89HQeY8NhFW5giD/vgN4wlGH1M
 EyB6ZSKUDCJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCasBt6gAKCRBt1cPRWsUx
 M+t9C/9cz5/cWrsTVmuCSdrQQxd0yMMfx5VjRSw09h0ilHNWwvRClCvrlOz9jntGROmlUa7DNL+
 TscQgU2O2CzEx4FP4smYPh+Fhgpxnex++XaQ1CFftWPVFbShNdsdQ54d+3fXacwHV4WuCU/1sYh
 oATtM/dmcbAwaUcYGhpq/kOCXd6arsJoY3HG769E50L500Z5R1NyE3tmoRAfJU0nPVNnIoei2om
 Zjk+g31wTWJwWW6oFVjvGPqtD7HJ9Q92gZLFuOCIx1w6N5WWkxJU463cY16snaqtttXYQ30d8Vw
 0Z7O1KgLrd7wnNOcRCOofxtvp+7dr1dgqQyNqGKNFCQE2fRSB4FPa2GPPDg/EDGOYtCHb7+MgmH
 adOVNU8X+Ou15zjKLEiiebiNom1iUfZ4hYfHUiOVTHDc+H1DypqMTeUzgeWpXu6WtUJyz1pz9iP
 WCAPSvxNNulMLksjIOFPJLx8iATZfhHv4nhnJgMtMRzlULzhdi4V8xvUNGzKXjZbnaCsY=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

For readability, rename the local config variable to curr_config in
places where it refers to drvdata->curr_config.

Reviewed-by: Mike Leach <mike.leach@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 164 ++++++++++-----------
 1 file changed, 82 insertions(+), 82 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 99d4e2d39e66..5db11309bfbb 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -270,11 +270,11 @@ static void etm4x_prohibit_trace(struct etmv4_drvdata *drvdata)
 static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
 {
 	u64 trfcr = drvdata->trfcr;
-	struct etmv4_config *config = &drvdata->curr_config;
+	struct etmv4_config *curr_config = &drvdata->curr_config;
 
-	if (config->mode & ETM_MODE_EXCL_KERN)
+	if (curr_config->mode & ETM_MODE_EXCL_KERN)
 		trfcr &= ~TRFCR_EL1_ExTRE;
-	if (config->mode & ETM_MODE_EXCL_USER)
+	if (curr_config->mode & ETM_MODE_EXCL_USER)
 		trfcr &= ~TRFCR_EL1_E0TRE;
 
 	return trfcr;
@@ -293,13 +293,13 @@ static u64 etm4x_get_kern_user_filter(struct etmv4_drvdata *drvdata)
 static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
 {
 	u64 trfcr, guest_trfcr;
-	struct etmv4_config *config = &drvdata->curr_config;
+	struct etmv4_config *curr_config = &drvdata->curr_config;
 
 	/* If the CPU doesn't support FEAT_TRF, nothing to do */
 	if (!drvdata->trfcr)
 		return;
 
-	if (config->mode & ETM_MODE_EXCL_HOST)
+	if (curr_config->mode & ETM_MODE_EXCL_HOST)
 		trfcr = drvdata->trfcr & ~(TRFCR_EL1_ExTRE | TRFCR_EL1_E0TRE);
 	else
 		trfcr = etm4x_get_kern_user_filter(drvdata);
@@ -307,7 +307,7 @@ static void etm4x_allow_trace(struct etmv4_drvdata *drvdata)
 	write_trfcr(trfcr);
 
 	/* Set filters for guests and pass to KVM */
-	if (config->mode & ETM_MODE_EXCL_GUEST)
+	if (curr_config->mode & ETM_MODE_EXCL_GUEST)
 		guest_trfcr = drvdata->trfcr & ~(TRFCR_EL1_ExTRE | TRFCR_EL1_E0TRE);
 	else
 		guest_trfcr = etm4x_get_kern_user_filter(drvdata);
@@ -501,7 +501,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->curr_config;
+	struct etmv4_config *curr_config = &drvdata->curr_config;
 	struct coresight_device *csdev = drvdata->csdev;
 	struct device *etm_dev = &csdev->dev;
 	struct csdev_access *csa = &csdev->access;
@@ -533,37 +533,37 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 	if (caps->nr_pe)
-		etm4x_relaxed_write32(csa, config->pe_sel, TRCPROCSELR);
-	etm4x_relaxed_write32(csa, config->cfg, TRCCONFIGR);
+		etm4x_relaxed_write32(csa, curr_config->pe_sel, TRCPROCSELR);
+	etm4x_relaxed_write32(csa, curr_config->cfg, TRCCONFIGR);
 	/* nothing specific implemented */
 	etm4x_relaxed_write32(csa, 0x0, TRCAUXCTLR);
-	etm4x_relaxed_write32(csa, config->eventctrl0, TRCEVENTCTL0R);
-	etm4x_relaxed_write32(csa, config->eventctrl1, TRCEVENTCTL1R);
+	etm4x_relaxed_write32(csa, curr_config->eventctrl0, TRCEVENTCTL0R);
+	etm4x_relaxed_write32(csa, curr_config->eventctrl1, TRCEVENTCTL1R);
 	if (caps->stallctl)
-		etm4x_relaxed_write32(csa, config->stall_ctrl, TRCSTALLCTLR);
-	etm4x_relaxed_write32(csa, config->ts_ctrl, TRCTSCTLR);
-	etm4x_relaxed_write32(csa, config->syncfreq, TRCSYNCPR);
-	etm4x_relaxed_write32(csa, config->ccctlr, TRCCCCTLR);
-	etm4x_relaxed_write32(csa, config->bb_ctrl, TRCBBCTLR);
+		etm4x_relaxed_write32(csa, curr_config->stall_ctrl, TRCSTALLCTLR);
+	etm4x_relaxed_write32(csa, curr_config->ts_ctrl, TRCTSCTLR);
+	etm4x_relaxed_write32(csa, curr_config->syncfreq, TRCSYNCPR);
+	etm4x_relaxed_write32(csa, curr_config->ccctlr, TRCCCCTLR);
+	etm4x_relaxed_write32(csa, curr_config->bb_ctrl, TRCBBCTLR);
 	etm4x_relaxed_write32(csa, drvdata->trcid, TRCTRACEIDR);
-	etm4x_relaxed_write32(csa, config->vinst_ctrl, TRCVICTLR);
-	etm4x_relaxed_write32(csa, config->viiectlr, TRCVIIECTLR);
-	etm4x_relaxed_write32(csa, config->vissctlr, TRCVISSCTLR);
+	etm4x_relaxed_write32(csa, curr_config->vinst_ctrl, TRCVICTLR);
+	etm4x_relaxed_write32(csa, curr_config->viiectlr, TRCVIIECTLR);
+	etm4x_relaxed_write32(csa, curr_config->vissctlr, TRCVISSCTLR);
 	if (caps->nr_pe_cmp)
-		etm4x_relaxed_write32(csa, config->vipcssctlr, TRCVIPCSSCTLR);
+		etm4x_relaxed_write32(csa, curr_config->vipcssctlr, TRCVIPCSSCTLR);
 
 	for (i = 0; i < caps->nr_seq_ctrls; i++)
-		etm4x_relaxed_write32(csa, config->seq_ctrl[i], TRCSEQEVRn(i));
+		etm4x_relaxed_write32(csa, curr_config->seq_ctrl[i], TRCSEQEVRn(i));
 	if (caps->nrseqstate) {
-		etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
-		etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
+		etm4x_relaxed_write32(csa, curr_config->seq_rst, TRCSEQRSTEVR);
+		etm4x_relaxed_write32(csa, curr_config->seq_state, TRCSEQSTR);
 	}
 	if (caps->numextinsel)
-		etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
+		etm4x_relaxed_write32(csa, curr_config->ext_inp, TRCEXTINSELR);
 	for (i = 0; i < caps->nr_cntr; i++) {
-		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
-		etm4x_relaxed_write32(csa, config->cntr_ctrl[i], TRCCNTCTLRn(i));
-		etm4x_relaxed_write32(csa, config->cntr_val[i], TRCCNTVRn(i));
+		etm4x_relaxed_write32(csa, curr_config->cntrldvr[i], TRCCNTRLDVRn(i));
+		etm4x_relaxed_write32(csa, curr_config->cntr_ctrl[i], TRCCNTCTLRn(i));
+		etm4x_relaxed_write32(csa, curr_config->cntr_val[i], TRCCNTVRn(i));
 	}
 
 	/*
@@ -571,32 +571,32 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	 * such start at 2.
 	 */
 	for (i = 2; i < caps->nr_resource * 2; i++)
-		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
+		etm4x_relaxed_write32(csa, curr_config->res_ctrl[i], TRCRSCTLRn(i));
 
 	for (i = 0; i < caps->nr_ss_cmp; i++) {
 		/* always clear status and pending bits on restart if using single-shot */
-		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
+		if (curr_config->ss_ctrl[i] || curr_config->ss_pe_cmp[i])
 			drvdata->ss_status[i] &= ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
-		etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
+		etm4x_relaxed_write32(csa, curr_config->ss_ctrl[i], TRCSSCCRn(i));
 		etm4x_relaxed_write32(csa, drvdata->ss_status[i], TRCSSCSRn(i));
 		if (etm4x_sspcicrn_present(drvdata, i))
-			etm4x_relaxed_write32(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
+			etm4x_relaxed_write32(csa, curr_config->ss_pe_cmp[i], TRCSSPCICRn(i));
 	}
 	for (i = 0; i < caps->nr_addr_cmp * 2; i++) {
-		etm4x_relaxed_write64(csa, config->addr_val[i], TRCACVRn(i));
-		etm4x_relaxed_write64(csa, config->addr_acc[i], TRCACATRn(i));
+		etm4x_relaxed_write64(csa, curr_config->addr_val[i], TRCACVRn(i));
+		etm4x_relaxed_write64(csa, curr_config->addr_acc[i], TRCACATRn(i));
 	}
 	for (i = 0; i < caps->numcidc; i++)
-		etm4x_relaxed_write64(csa, config->ctxid_pid[i], TRCCIDCVRn(i));
-	etm4x_relaxed_write32(csa, config->ctxid_mask0, TRCCIDCCTLR0);
+		etm4x_relaxed_write64(csa, curr_config->ctxid_pid[i], TRCCIDCVRn(i));
+	etm4x_relaxed_write32(csa, curr_config->ctxid_mask0, TRCCIDCCTLR0);
 	if (caps->numcidc > 4)
-		etm4x_relaxed_write32(csa, config->ctxid_mask1, TRCCIDCCTLR1);
+		etm4x_relaxed_write32(csa, curr_config->ctxid_mask1, TRCCIDCCTLR1);
 
 	for (i = 0; i < caps->numvmidc; i++)
-		etm4x_relaxed_write64(csa, config->vmid_val[i], TRCVMIDCVRn(i));
-	etm4x_relaxed_write32(csa, config->vmid_mask0, TRCVMIDCCTLR0);
+		etm4x_relaxed_write64(csa, curr_config->vmid_val[i], TRCVMIDCVRn(i));
+	etm4x_relaxed_write32(csa, curr_config->vmid_mask0, TRCVMIDCCTLR0);
 	if (caps->numvmidc > 4)
-		etm4x_relaxed_write32(csa, config->vmid_mask1, TRCVMIDCCTLR1);
+		etm4x_relaxed_write32(csa, curr_config->vmid_mask1, TRCVMIDCCTLR1);
 
 	if (!caps->skip_power_up) {
 		u32 trcpdcr = etm4x_relaxed_read32(csa, TRCPDCR);
@@ -694,7 +694,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
 	int ctridx;
 	int rselector;
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->curr_config;
+	struct etmv4_config *curr_config = &drvdata->curr_config;
 
 	/* No point in trying if we don't have at least one counter */
 	if (!caps->nr_cntr)
@@ -702,7 +702,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
 
 	/* Find a counter that hasn't been initialised */
 	for (ctridx = 0; ctridx < caps->nr_cntr; ctridx++)
-		if (config->cntr_val[ctridx] == 0)
+		if (curr_config->cntr_val[ctridx] == 0)
 			break;
 
 	/* All the counters have been configured already, bail out */
@@ -723,7 +723,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
 	 * by 2.
 	 */
 	for (rselector = 2; rselector < caps->nr_resource * 2; rselector++)
-		if (!config->res_ctrl[rselector])
+		if (!curr_config->res_ctrl[rselector])
 			break;
 
 	if (rselector == caps->nr_resource * 2) {
@@ -733,7 +733,7 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
 	}
 
 	/* Initialise original and reload counter value. */
-	config->cntr_val[ctridx] = config->cntrldvr[ctridx] = 1 << (ts_level - 1);
+	curr_config->cntr_val[ctridx] = curr_config->cntrldvr[ctridx] = 1 << (ts_level - 1);
 
 	/*
 	 * Trace Counter Control Register TRCCNTCTLRn
@@ -743,11 +743,11 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
 	 * RLDEVENT = RES_SEL_FALSE (0), reload on single false resource (never reload)
 	 * CNTEVENT = RES_SEL_TRUE (1), count single fixed 'always true' resource (always decrement)
 	 */
-	config->cntr_ctrl[ctridx] = TRCCNTCTLRn_RLDSELF |
-				    FIELD_PREP(TRCCNTCTLRn_RLDEVENT_MASK,
-					       etm4_res_sel_single(ETM4_RES_SEL_FALSE)) |
-				    FIELD_PREP(TRCCNTCTLRn_CNTEVENT_MASK,
-					       etm4_res_sel_single(ETM4_RES_SEL_TRUE));
+	curr_config->cntr_ctrl[ctridx] = TRCCNTCTLRn_RLDSELF |
+					 FIELD_PREP(TRCCNTCTLRn_RLDEVENT_MASK,
+						    etm4_res_sel_single(ETM4_RES_SEL_FALSE)) |
+					 FIELD_PREP(TRCCNTCTLRn_CNTEVENT_MASK,
+						    etm4_res_sel_single(ETM4_RES_SEL_TRUE));
 
 	/*
 	 * Resource Selection Control Register TRCRSCTLRn
@@ -758,16 +758,16 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
 	 * Multiple counters can be selected, and each bit signifies a counter,
 	 * so set bit 'ctridx' to select our counter.
 	 */
-	config->res_ctrl[rselector] = FIELD_PREP(TRCRSCTLRn_GROUP_MASK, 2) |
-				      FIELD_PREP(TRCRSCTLRn_SELECT_MASK, 1 << ctridx);
+	curr_config->res_ctrl[rselector] = FIELD_PREP(TRCRSCTLRn_GROUP_MASK, 2) |
+					   FIELD_PREP(TRCRSCTLRn_SELECT_MASK, 1 << ctridx);
 
 	/*
 	 * Global Timestamp Control Register TRCTSCTLR
 	 *
 	 * EVENT = generate timestamp on single resource 'rselector'
 	 */
-	config->ts_ctrl = FIELD_PREP(TRCTSCTLR_EVENT_MASK,
-				     etm4_res_sel_single(rselector));
+	curr_config->ts_ctrl = FIELD_PREP(TRCTSCTLR_EVENT_MASK,
+					  etm4_res_sel_single(rselector));
 
 	return 0;
 }
@@ -778,7 +778,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 	int ret = 0;
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->curr_config;
+	struct etmv4_config *curr_config = &drvdata->curr_config;
 	struct perf_event_attr max_timestamp = {
 		.ATTR_CFG_FLD_timestamp_CFG = U64_MAX,
 	};
@@ -787,22 +787,22 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 	u8 ts_level;
 
 	/* Clear configuration from previous run */
-	memset(config, 0, sizeof(struct etmv4_config));
+	memset(curr_config, 0, sizeof(struct etmv4_config));
 
 	if (attr->exclude_kernel)
-		config->mode = ETM_MODE_EXCL_KERN;
+		curr_config->mode = ETM_MODE_EXCL_KERN;
 
 	if (attr->exclude_user)
-		config->mode = ETM_MODE_EXCL_USER;
+		curr_config->mode = ETM_MODE_EXCL_USER;
 
 	if (attr->exclude_host)
-		config->mode |= ETM_MODE_EXCL_HOST;
+		curr_config->mode |= ETM_MODE_EXCL_HOST;
 
 	if (attr->exclude_guest)
-		config->mode |= ETM_MODE_EXCL_GUEST;
+		curr_config->mode |= ETM_MODE_EXCL_GUEST;
 
 	/* Always start from the default config */
-	etm4_set_default_config(config, caps);
+	etm4_set_default_config(curr_config, caps);
 
 	/* Configure filters specified on the perf cmd line, if any. */
 	ret = etm4_set_event_filters(drvdata, event);
@@ -811,14 +811,14 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 
 	/* Go from generic option to ETMv4 specifics */
 	if (ATTR_CFG_GET_FLD(attr, cycacc)) {
-		config->cfg |= TRCCONFIGR_CCI;
+		curr_config->cfg |= TRCCONFIGR_CCI;
 		/* TRM: Must program this for cycacc to work */
 		cc_threshold = ATTR_CFG_GET_FLD(attr, cc_threshold);
 		if (!cc_threshold)
 			cc_threshold = ETM_CYC_THRESHOLD_DEFAULT;
 		if (cc_threshold < caps->ccitmin)
 			cc_threshold = caps->ccitmin;
-		config->ccctlr = cc_threshold;
+		curr_config->ccctlr = cc_threshold;
 	}
 
 	ts_level = max(ATTR_CFG_GET_FLD(attr, timestamp),
@@ -840,14 +840,14 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 		}
 
 		/* bit[11], Global timestamp tracing bit */
-		config->cfg |= TRCCONFIGR_TS;
+		curr_config->cfg |= TRCCONFIGR_TS;
 	}
 
 	/* Only trace contextID when runs in root PID namespace */
 	if (ATTR_CFG_GET_FLD(attr, contextid1) &&
 	    task_is_in_init_pid_ns(current))
 		/* bit[6], Context ID tracing bit */
-		config->cfg |= TRCCONFIGR_CID;
+		curr_config->cfg |= TRCCONFIGR_CID;
 
 	/*
 	 * If set bit contextid2 in perf config, this asks to trace VMID for
@@ -861,13 +861,13 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 		}
 		/* Only trace virtual contextID when runs in root PID namespace */
 		if (task_is_in_init_pid_ns(current))
-			config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
+			curr_config->cfg |= TRCCONFIGR_VMID | TRCCONFIGR_VMIDOPT;
 	}
 
 	/* return stack - enable if selected and supported */
 	if (ATTR_CFG_GET_FLD(attr, retstack) && caps->retstack)
 		/* bit[12], Return stack enable bit */
-		config->cfg |= TRCCONFIGR_RS;
+		curr_config->cfg |= TRCCONFIGR_RS;
 
 	/* branch broadcast - enable if selected and supported */
 	if (ATTR_CFG_GET_FLD(attr, branch_broadcast)) {
@@ -879,7 +879,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 			ret = -EINVAL;
 			goto out;
 		} else {
-			config->cfg |= TRCCONFIGR_BB;
+			curr_config->cfg |= TRCCONFIGR_BB;
 		}
 	}
 
@@ -1061,7 +1061,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
 {
 	u32 control;
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->curr_config;
+	struct etmv4_config *curr_config = &drvdata->curr_config;
 	struct coresight_device *csdev = drvdata->csdev;
 	struct csdev_access *csa = &csdev->access;
 	int i;
@@ -1086,13 +1086,13 @@ static void etm4_disable_hw(struct etmv4_drvdata *drvdata)
 
 	/* read back the current counter values */
 	for (i = 0; i < caps->nr_cntr; i++) {
-		config->cntr_val[i] =
-			etm4x_relaxed_read32(csa, TRCCNTVRn(i));
+		curr_config->cntr_val[i] =
+			     etm4x_relaxed_read32(csa, TRCCNTVRn(i));
 	}
 
 	/* read back the sequence state */
 	if (caps->nrseqstate)
-		config->seq_state = etm4x_relaxed_read32(csa, TRCSEQSTR);
+		curr_config->seq_state = etm4x_relaxed_read32(csa, TRCSEQSTR);
 
 	coresight_disclaim_device_unlocked(csdev);
 	etm4_cs_lock(drvdata, csa);
@@ -1729,7 +1729,7 @@ static void etm4_set_default(struct etmv4_config *config,
 static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
 {
 	int nr_comparator, index = 0;
-	struct etmv4_config *config = &drvdata->curr_config;
+	struct etmv4_config *curr_config = &drvdata->curr_config;
 
 	/*
 	 * nr_addr_cmp holds the number of comparator _pair_, so time 2
@@ -1741,8 +1741,8 @@ static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
 	while (index < nr_comparator) {
 		switch (type) {
 		case ETM_ADDR_TYPE_RANGE:
-			if (config->addr_type[index] == ETM_ADDR_TYPE_NONE &&
-			    config->addr_type[index + 1] == ETM_ADDR_TYPE_NONE)
+			if (curr_config->addr_type[index] == ETM_ADDR_TYPE_NONE &&
+			    curr_config->addr_type[index + 1] == ETM_ADDR_TYPE_NONE)
 				return index;
 
 			/* Address range comparators go in pairs */
@@ -1750,7 +1750,7 @@ static int etm4_get_next_comparator(struct etmv4_drvdata *drvdata, u32 type)
 			break;
 		case ETM_ADDR_TYPE_START:
 		case ETM_ADDR_TYPE_STOP:
-			if (config->addr_type[index] == ETM_ADDR_TYPE_NONE)
+			if (curr_config->addr_type[index] == ETM_ADDR_TYPE_NONE)
 				return index;
 
 			/* Start/stop address can have odd indexes */
@@ -1771,7 +1771,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 	int i, comparator, ret = 0;
 	u64 address;
 	const struct etmv4_caps *caps = &drvdata->caps;
-	struct etmv4_config *config = &drvdata->curr_config;
+	struct etmv4_config *curr_config = &drvdata->curr_config;
 	struct etm_filters *filters = event->hw.addr_filters;
 
 	if (!filters)
@@ -1800,7 +1800,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 
 		switch (type) {
 		case ETM_ADDR_TYPE_RANGE:
-			etm4_set_comparator_filter(config, caps,
+			etm4_set_comparator_filter(curr_config, caps,
 						   filter->start_addr,
 						   filter->stop_addr,
 						   comparator);
@@ -1808,10 +1808,10 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 			 * TRCVICTLR::SSSTATUS == 1, the start-stop logic is
 			 * in the started state
 			 */
-			config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
+			curr_config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
 
 			/* No start-stop filtering for ViewInst */
-			config->vissctlr = 0x0;
+			curr_config->vissctlr = 0x0;
 			break;
 		case ETM_ADDR_TYPE_START:
 		case ETM_ADDR_TYPE_STOP:
@@ -1821,7 +1821,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 				   filter->stop_addr);
 
 			/* Configure comparator */
-			etm4_set_start_stop_filter(config, caps, address,
+			etm4_set_start_stop_filter(curr_config, caps, address,
 						   comparator, type);
 
 			/*
@@ -1836,10 +1836,10 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 			 * etm4_disable_perf().
 			 */
 			if (filters->ssstatus)
-				config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
+				curr_config->vinst_ctrl |= TRCVICTLR_SSSTATUS;
 
 			/* No include/exclude filtering for ViewInst */
-			config->viiectlr = 0x0;
+			curr_config->viiectlr = 0x0;
 			break;
 		default:
 			ret = -EINVAL;
@@ -1851,7 +1851,7 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,
 
 
 default_filter:
-	etm4_set_default_filter(config);
+	etm4_set_default_filter(curr_config);
 
 out:
 	return ret;

-- 
2.43.0

