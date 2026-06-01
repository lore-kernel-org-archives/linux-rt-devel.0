Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8D63FADE0;
	Mon,  1 Jun 2026 20:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346192; cv=none; b=SwJFAsXuO5NEwC72oj/idxpqrvh1D5YCBhGXfVo2iOHsmrj4rITDdbYwZWXzqt+t5U61zpSqC9iHuJb+od1AF0V4nI/B1zveQjNtJy+sBfCft9RLIldrNFzPS2ddV7AW1CQXldN/LXi7Z9aiHAkW6wgxWUnm2Ts4TbCQQ/9bGj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346192; c=relaxed/simple;
	bh=6pGb65kUi8C4rTI8Gu7TEGZMX7qYRHql0RDoSYaXCBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SeDzNmNWOINq2y8vMRE4MLg7KanjcMGtfqjipYEfpoJNzhLXGme575qotgf8Wcj/D6fC49QJ0HM/U07w8/9qfaEUDF8CaYj11cWPBnRSOyF8YX5QV3QCeGYUpD9zZLsqC22FrrgMe3yrV+UJppf8P7hFp3BycJ9zyEBSH1X8JOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/CK1X2r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/CK1X2r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3FF1F008A2;
	Mon,  1 Jun 2026 20:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780346189;
	bh=rEo6Boe1f4U6J69bplZaagznip1xGYS4k0AxEWh7bSg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Q/CK1X2rY8jP1eiaXjNZK1292cWzD9n1bNUfa14c8m7WoBei4nTvGz0HznSYPOYpg
	 bVm4FdFr8x3rL1Kl4btvZU5HXxXwYhQr8dY+DUT/bzxFm47W12O26x+u0+F5Zx9IST
	 B6mAVOpNCxnHemCuCoHlCCD/GvGXDxO8qIa02Cd0lU08/WFh+PH/QksYsaMW4QrBT+
	 vgW5exUG9rmwxiKZS04Mu4NZu/sK0n0kjUJOmWXibmp2fRLan1avSfQ79xdeKBkWAA
	 WHCPtLxCVj/6kq7DRWbNWQhUcJc5ijBAuT64wQ7OcXGQjVjsDV9Ub9KJg4M1KOWh5N
	 av/5/GoNon42A==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 01 Jun 2026 13:36:02 -0700
Subject: [PATCH RFC v6 08/18] riscv_cbqri: Add capacity controller
 monitoring device ops
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-8-baf00f50028a@kernel.org>
References: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-0-baf00f50028a@kernel.org>
In-Reply-To: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-0-baf00f50028a@kernel.org>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, Gong Shuai <gong.shuai@sanechips.com.cn>, 
 Gong Shuai <gsh517@gmail.com>, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Drew Fustini <fustini@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
 devicetree@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 Conor Dooley <conor@kernel.org>, linux-rt-devel@lists.linux.dev, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9666; i=fustini@kernel.org;
 h=from:subject:message-id; bh=6pGb65kUi8C4rTI8Gu7TEGZMX7qYRHql0RDoSYaXCBA=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTJvnXe9+mSpW1VwpGCF8t+67FJ3FCacuoAR1wW2+Ug5
 UCP+UsPd5SyMIhxMciKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmcv8YI8M27bXHp1vMUJ90
 4N1LwQB1DefyGRNqS+fPe6bH0XdPupuD4Z9GUusE8b0Gn9Y2WS7eLP3FpLTpVPn7TVcOFMYVFxY
 sWMICAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add capacity monitoring operations. cbqri_init_mon_counters() pre-arms
every MCID with the Occupancy event so a subsequent READ_COUNTER just
snapshots the live counter without re-configuring the slot.

cbqri_probe_cc() leaves ctrl->mon_capable false when cacheinfo has not
given a non-zero cache_size, since the byte conversion would be
meaningless. cbqri_mon_op() takes a reg_offset and serves both capacity
and bandwidth mon_ctl registers as they share an identical layout.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/cbqri_devices.c  | 124 ++++++++++++++++++++++++++++++++++-----
 drivers/resctrl/cbqri_internal.h |  14 +++++
 2 files changed, 124 insertions(+), 14 deletions(-)

diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devices.c
index 65453e614a43..c44bc50c31ba 100644
--- a/drivers/resctrl/cbqri_devices.c
+++ b/drivers/resctrl/cbqri_devices.c
@@ -98,6 +98,43 @@ static int cbqri_cc_alloc_op(struct cbqri_controller *ctrl, int operation,
 	return 0;
 }
 
+/*
+ * Issue a monitoring op on a CC or BC controller's mon_ctl register at
+ * reg_offset (CBQRI_CC_MON_CTL_OFF or CBQRI_BC_MON_CTL_OFF). The CC and
+ * BC mon_ctl registers share an identical OP/MCID/EVT_ID/STATUS layout, so
+ * one helper covers both. Caller must hold ctrl->lock.
+ */
+int cbqri_mon_op(struct cbqri_controller *ctrl, int reg_offset,
+		 int operation, int mcid, int evt_id, u64 *out_reg)
+{
+	u64 reg;
+
+	lockdep_assert_held(&ctrl->lock);
+
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+		pr_err_ratelimited("BUSY timeout before starting operation\n");
+		return -EIO;
+	}
+	FIELD_MODIFY(CBQRI_MON_CTL_OP_MASK, &reg, operation);
+	FIELD_MODIFY(CBQRI_MON_CTL_MCID_MASK, &reg, mcid);
+	FIELD_MODIFY(CBQRI_MON_CTL_EVT_ID_MASK, &reg, evt_id);
+	iowrite64(reg, ctrl->base + reg_offset);
+
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+		pr_err_ratelimited("BUSY timeout\n");
+		return -EIO;
+	}
+
+	if (FIELD_GET(CBQRI_MON_CTL_STATUS_MASK, reg) !=
+	    CBQRI_MON_CTL_STATUS_SUCCESS)
+		return -EIO;
+
+	if (out_reg)
+		*out_reg = reg;
+
+	return 0;
+}
+
 /*
  * Apply a capacity block mask and verify via CONFIG_LIMIT + READ_LIMIT.
  *
@@ -230,7 +267,8 @@ int cbqri_read_cache_config(struct cbqri_controller *ctrl, u32 closid,
 }
 
 static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_offset,
-			       int operation, int *status, bool *access_type_supported)
+			       int operation, int evt_id, int *status,
+			       bool *access_type_supported)
 {
 	const u64 active_mask = CBQRI_CONTROL_REGISTERS_OP_MASK |
 				CBQRI_CONTROL_REGISTERS_AT_MASK |
@@ -242,9 +280,11 @@ static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_offset,
 	/*
 	 * Default the output to false so the status==0 (feature not
 	 * implemented) path returns a deterministic value to the caller
-	 * rather than leaving an uninitialized bool.
+	 * rather than leaving an uninitialized bool. mon_ctl probes pass
+	 * NULL: the register has no AT field, so the AT probe is skipped.
 	 */
-	*access_type_supported = false;
+	if (access_type_supported)
+		*access_type_supported = false;
 
 	/* Keep the initial register value to preserve the WPRI fields */
 	reg = ioread64(ctrl->base + reg_offset);
@@ -257,15 +297,14 @@ static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_offset,
 	}
 
 	/*
-	 * Execute the requested operation with all active fields
-	 * (OP/AT/RCID/EVT_ID) zeroed except OP itself. The same builder
-	 * works for ALLOC_CTL and MON_CTL because every bit not in
-	 * active_mask is WPRI and gets carried over from saved_reg. The
-	 * AT and EVT_ID positions are reserved for the other register
-	 * type, where writing zero is harmless.
+	 * Execute the requested operation with the active fields
+	 * (OP/AT/RCID/EVT_ID) cleared, then set OP and, for mon_ctl, the
+	 * probe-safe evt_id. WPRI bits outside active_mask carry over from
+	 * saved_reg. alloc_ctl callers pass evt_id 0.
 	 */
 	reg = (saved_reg & ~active_mask) |
-	      FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation);
+	      FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation) |
+	      FIELD_PREP(CBQRI_MON_CTL_EVT_ID_MASK, evt_id);
 	iowrite64(reg, ctrl->base + reg_offset);
 	if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
 		pr_err_ratelimited("BUSY timeout during operation\n");
@@ -276,10 +315,11 @@ static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_offset,
 	*status = FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
 
 	/*
-	 * Check for the AT support if the register is implemented
-	 * (if not, the status value will remain 0)
+	 * Probe AT support only on alloc_ctl registers (mon_ctl has no AT
+	 * field, so access_type_supported is NULL there). Skipped when the
+	 * register is unimplemented (status stays 0).
 	 */
-	if (*status != 0) {
+	if (access_type_supported && *status != 0) {
 		/*
 		 * Re-issue operation with AT=CODE so the controller
 		 * latches AT=CODE on supported hardware (or resets it to 0
@@ -372,9 +412,31 @@ static int cbqri_probe_cc(struct cbqri_controller *ctrl)
 	}
 	cpus_read_unlock();
 
+	/* Probe monitoring features */
+	err = cbqri_probe_feature(ctrl, CBQRI_CC_MON_CTL_OFF,
+				  CBQRI_CC_MON_CTL_OP_CONFIG_EVENT,
+				  CBQRI_CC_EVT_ID_NONE, &status, NULL);
+	if (err)
+		return err;
+
+	if (status == CBQRI_MON_CTL_STATUS_SUCCESS) {
+		/*
+		 * Occupancy is reported to userspace in bytes, computed as
+		 * cache_size * counter / ncblks by the resctrl glue. If
+		 * cacheinfo has no cache_size, leave mon_capable false so
+		 * the file is not exposed at all rather than silently
+		 * returning 0.
+		 */
+		if (!ctrl->cache.cache_size)
+			pr_debug("CC @%pa: cache_size unknown, occupancy monitoring disabled\n",
+				 &ctrl->addr);
+		else
+			ctrl->mon_capable = true;
+	}
+
 	/* Probe allocation features */
 	err = cbqri_probe_feature(ctrl, CBQRI_CC_ALLOC_CTL_OFF,
-				  CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
+				  CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, 0,
 				  &status, &ctrl->cc.supports_alloc_at_code);
 	if (err)
 		return err;
@@ -439,6 +501,28 @@ static int cbqri_probe_controller(struct cbqri_controller *ctrl)
 	return err;
 }
 
+/*
+ * Pre-arm every MCID with the Occupancy event so a subsequent READ_COUNTER
+ * just snapshots the live counter rather than re-configuring the slot.
+ * Called once per CC during resctrl-side cpuhp online for the L3 monitoring
+ * domain.
+ */
+int cbqri_init_mon_counters(struct cbqri_controller *ctrl)
+{
+	int i, err;
+
+	for (i = 0; i < ctrl->mcid_count; i++) {
+		mutex_lock(&ctrl->lock);
+		err = cbqri_mon_op(ctrl, CBQRI_CC_MON_CTL_OFF,
+				   CBQRI_CC_MON_CTL_OP_CONFIG_EVENT,
+				   i, CBQRI_CC_EVT_ID_OCCUPANCY, NULL);
+		mutex_unlock(&ctrl->lock);
+		if (err)
+			return err;
+	}
+	return 0;
+}
+
 void cbqri_controller_destroy(struct cbqri_controller *ctrl)
 {
 	/*
@@ -518,6 +602,18 @@ int riscv_cbqri_register_controller(const struct cbqri_controller_info *info)
 		return -EINVAL;
 	}
 
+	/*
+	 * mon_ctl encodes MCID in 12 bits. acpi_parse_rqsc() caps
+	 * info->mcid_count at CBQRI_MAX_MCID (1024), but a future discovery
+	 * path could bypass that. Reject an out-of-range count so
+	 * cbqri_init_mon_counters() iterates a trusted bound and no MCID
+	 * aliases another slot through FIELD_MODIFY(MON_CTL_MCID_MASK).
+	 */
+	if (WARN_ON_ONCE(ctrl->mcid_count > FIELD_MAX(CBQRI_MON_CTL_MCID_MASK) + 1)) {
+		cbqri_controller_destroy(ctrl);
+		return -EINVAL;
+	}
+
 	switch (info->type) {
 	case CBQRI_CONTROLLER_TYPE_CAPACITY: {
 		int level;
diff --git a/drivers/resctrl/cbqri_internal.h b/drivers/resctrl/cbqri_internal.h
index 518955963403..1d2007a0c15b 100644
--- a/drivers/resctrl/cbqri_internal.h
+++ b/drivers/resctrl/cbqri_internal.h
@@ -11,6 +11,8 @@
 
 /* Capacity Controller (CC) MMIO register offsets. */
 #define CBQRI_CC_CAPABILITIES_OFF 0
+#define CBQRI_CC_MON_CTL_OFF      8
+#define CBQRI_CC_MON_CTL_VAL_OFF 16
 #define CBQRI_CC_ALLOC_CTL_OFF   24
 #define CBQRI_CC_BLOCK_MASK_OFF  32
 
@@ -45,6 +47,9 @@
 #define CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT   2
 #define CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS  1
 
+#define CBQRI_CC_MON_CTL_OP_CONFIG_EVENT 1
+#define CBQRI_CC_MON_CTL_OP_READ_COUNTER 2
+
 /* mon_ctl field masks (CC and BC share an identical OP/MCID/EVT_ID/STATUS layout) */
 #define CBQRI_MON_CTL_OP_MASK        GENMASK_ULL(4, 0)
 #define CBQRI_MON_CTL_MCID_MASK      GENMASK_ULL(19, 8)
@@ -52,6 +57,10 @@
 #define CBQRI_MON_CTL_STATUS_MASK    GENMASK_ULL(38, 32)
 #define CBQRI_MON_CTL_STATUS_SUCCESS 1
 
+/* Capacity usage monitoring event IDs (CBQRI spec Table 4) */
+#define CBQRI_CC_EVT_ID_NONE         0
+#define CBQRI_CC_EVT_ID_OCCUPANCY    1
+
 /* Capacity Controller hardware capabilities */
 struct riscv_cbqri_capacity_caps {
 	u16 ncblks;
@@ -138,4 +147,9 @@ int cbqri_apply_cache_config(struct cbqri_controller *ctrl, u32 closid,
 int cbqri_read_cache_config(struct cbqri_controller *ctrl, u32 closid,
 			    enum cbqri_at at, u32 *cbm_out);
 
+int cbqri_mon_op(struct cbqri_controller *ctrl, int reg_offset,
+		 int operation, int mcid, int evt_id, u64 *out_reg);
+
+int cbqri_init_mon_counters(struct cbqri_controller *ctrl);
+
 #endif /* _DRIVERS_RESCTRL_CBQRI_INTERNAL_H */

-- 
2.43.0

