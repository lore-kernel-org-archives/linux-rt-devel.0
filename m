Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7093B840B;
	Sun, 24 May 2026 23:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779667065; cv=none; b=n6tQt5kBdPmRFlbt+Bl+NIhEQvg2EuWWxEutOJWmV9C5rPkqrcBhLUAxe3xMAVpNA6EpiL3EIRCMst/4sGLAEbg/doHcRNtijRG5ympT3yBpIXIRvD62Op4d/rrU0pN0wM/4lMYhX4BEwoigBXXbhOph0BA6bygW8SRKA0wnO6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779667065; c=relaxed/simple;
	bh=s6mdMtMUeq4TT8hNELVt0RXMUZ7RysIkQv3iK6nEkJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VNDLYnnMSi0TZwtdfVtGli4mJ+31aRS9XfpovTPpgvBZVLUHVAipwyJt4bEBy2ezMrbsCCJiROHur69HF8VP2Dc+J9sE0D+wRgW5HIbPu7aGXsqqaPDCl/phf95YGznwXmyVPAf7O7ZhbthTzv/OxlKbMl4yri9A/YBLpwijmlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdv1taJA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdv1taJA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306041F0155D;
	Sun, 24 May 2026 23:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779667057;
	bh=OMqgfTmILsYHDV3UCc6lUjhp93fXBJjwg+F7RAZcpBg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hdv1taJAzls3v5rp2VicATJsAxM2OMhCb2vrmxSx/BPdJIz75Qm6XWJyDI0tzpv4s
	 qJRBb+NH0poi9ctl3mvygGHC0WeLEghwoIrVK3Im8tV+658Z/ZR8L0jpyMFK5EVj2x
	 yOAfK2R3eK5vYEWNq2ANKinjE2jYaiW28yXbOfNcf9BSv50u1rC3Z27xufjs7HMDO1
	 DvrOV7QHjyHtRmRnGl4U8+ZRwcKIrohh+GvQGMe5xl5mBshpLpSovePHyokKVVw6Ha
	 Cchr2kgWY3UVa37OVgRYTpbhG6uPuZKy/5HK5bNZZmJ64cHt57guZ9lArrZPu2qjMD
	 /m49qHpA+PwSA==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 24 May 2026 16:55:39 -0700
Subject: [PATCH RFC v5 09/18] riscv_cbqri: Add bandwidth controller probe
 and allocation device ops
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-9-78d3a7ba9dbe@kernel.org>
References: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-0-78d3a7ba9dbe@kernel.org>
In-Reply-To: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-0-78d3a7ba9dbe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=19867; i=fustini@kernel.org;
 h=from:subject:message-id; bh=s6mdMtMUeq4TT8hNELVt0RXMUZ7RysIkQv3iK6nEkJk=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQJT8jcKnHh5Xp+i9knljXeMHx6fTkDu7de7ip9/zajD
 wu8Ty1T7yhlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMJO47I8O+SUvOXP/317N8
 9/SGiKeaH15MNNRVl5J7Y77k/FETgbR1jAyH10smRq1OPH68fuWKRGExhuUh7N8kMrPZPzSwiRy
 zTOEEAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add support for CBQRI bandwidth controller (BC) discovery and the two BC
allocation control knobs. Rbwb is the number of reserved bandwidth
blocks per RCID. Mweight is the weighted share per RCID of the remaining
unreserved bandwidth.

Both fields share the bc_bw_alloc register, so cbqri_apply_bc_field()
seeds both halves from per-RCID software caches (rbwb_cache and
mweight_cache) on every CONFIG_LIMIT. The caches are the authoritative
source of the unmodified field, which sidesteps a silent READ_LIMIT
no-op leaking stale data from a prior RCID. After CONFIG_LIMIT, the
caller writes a sentinel to the target field and reads back via
READ_LIMIT to verify hardware accepted the write. The cache is updated
only after verify succeeds.

mweight_cache is seeded to FIELD_MAX at probe so the first MB_MIN
domain init does not commit Mweight=0 (per CBQRI 4.5, a hard cap that
disallows opportunistic bandwidth) before the subsequent MB_WGHT init
catches up.

cbqri_apply_rbwb() enforces the spec-mandated sum(Rbwb) <= MRBWB
invariant from rbwb_cache rather than per-RCID READ_LIMIT round-trips,
which would cost up to 1 ms each while holding the mutex.
cbqri_apply_mweight_config() rejects values that would truncate against
the 8-bit MWEIGHT_MASK at entry.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/cbqri_devices.c  | 379 +++++++++++++++++++++++++++++++++++++++
 drivers/resctrl/cbqri_internal.h |  57 +++++-
 2 files changed, 435 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devices.c
index 90a95fd11190..2a80197764a9 100644
--- a/drivers/resctrl/cbqri_devices.c
+++ b/drivers/resctrl/cbqri_devices.c
@@ -14,6 +14,7 @@
 #include <linux/ioport.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
+#include <linux/numa.h>
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -30,6 +31,63 @@ static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
 	iowrite64(cbm, ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
 }
 
+/* Set the Rbwb (reserved bandwidth blocks) field in bc_bw_alloc */
+static void cbqri_set_rbwb(struct cbqri_controller *ctrl, u64 rbwb)
+{
+	u64 reg;
+
+	reg = ioread64(ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
+	FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_RBWB_MASK, &reg, rbwb);
+	iowrite64(reg, ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
+}
+
+/* Get the Rbwb (reserved bandwidth blocks) field in bc_bw_alloc */
+static u64 cbqri_get_rbwb(struct cbqri_controller *ctrl)
+{
+	u64 reg;
+
+	reg = ioread64(ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
+	return FIELD_GET(CBQRI_CONTROL_REGISTERS_RBWB_MASK, reg);
+}
+
+/* Set the Mweight (opportunistic weight) field in bc_bw_alloc */
+static void cbqri_set_mweight(struct cbqri_controller *ctrl, u64 mweight)
+{
+	u64 reg;
+
+	reg = ioread64(ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
+	FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_MWEIGHT_MASK, &reg, mweight);
+	iowrite64(reg, ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
+}
+
+/* Get the Mweight (opportunistic weight) field in bc_bw_alloc */
+static u64 cbqri_get_mweight(struct cbqri_controller *ctrl)
+{
+	u64 reg;
+
+	reg = ioread64(ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
+	return FIELD_GET(CBQRI_CONTROL_REGISTERS_MWEIGHT_MASK, reg);
+}
+
+/*
+ * Stage both fields of bc_bw_alloc in one read-modify-write so the staging
+ * register is consistent after a single MMIO write.
+ */
+static void cbqri_set_bc_bw_alloc(struct cbqri_controller *ctrl,
+				  u64 rbwb, u64 mweight)
+{
+	u64 reg = ioread64(ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
+
+	FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_RBWB_MASK, &reg, rbwb);
+	FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_MWEIGHT_MASK, &reg, mweight);
+	iowrite64(reg, ctrl->base + CBQRI_BC_BW_ALLOC_OFF);
+}
+
+enum cbqri_bc_field {
+	CBQRI_BC_FIELD_RBWB,
+	CBQRI_BC_FIELD_MWEIGHT,
+};
+
 static int cbqri_wait_busy_flag(struct cbqri_controller *ctrl, int reg_offset,
 				u64 *regp)
 {
@@ -135,6 +193,41 @@ int cbqri_mon_op(struct cbqri_controller *ctrl, int reg_offset,
 	return 0;
 }
 
+/*
+ * Perform bandwidth allocation control operation on bandwidth controller.
+ * Caller must hold ctrl->lock.
+ */
+static int cbqri_bc_alloc_op(struct cbqri_controller *ctrl, int operation, int rcid)
+{
+	int reg_offset = CBQRI_BC_ALLOC_CTL_OFF;
+	int status;
+	u64 reg;
+
+	lockdep_assert_held(&ctrl->lock);
+
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+		pr_err_ratelimited("BUSY timeout before starting operation\n");
+		return -EIO;
+	}
+	FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_OP_MASK, &reg, operation);
+	FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_RCID_MASK, &reg, rcid);
+	iowrite64(reg, ctrl->base + reg_offset);
+
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+		pr_err_ratelimited("BUSY timeout during operation\n");
+		return -EIO;
+	}
+
+	status = FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
+	if (status != CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS) {
+		pr_err_ratelimited("BC alloc op %d failed: status=%d\n",
+				   operation, status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
 /*
  * Apply a capacity block mask and verify via CONFIG_LIMIT + READ_LIMIT.
  *
@@ -266,6 +359,152 @@ int cbqri_read_cache_config(struct cbqri_controller *ctrl, u32 closid,
 	return err;
 }
 
+/*
+ * Apply a per-RCID update to one field (Rbwb or Mweight) of bc_bw_alloc.
+ * bc_bw_alloc packs both fields, so both halves are seeded from the
+ * authoritative software caches before CONFIG_LIMIT. This avoids the
+ * silent READ_LIMIT no-op window where stale data from a prior op's
+ * RCID could leak into the unmodified field. The verify step uses an
+ * inverted-value sentinel to confirm hardware accepted the target field.
+ *
+ * Caller must hold ctrl->lock.
+ */
+static int cbqri_apply_bc_field(struct cbqri_controller *ctrl, u32 closid,
+				enum cbqri_bc_field field, u64 val)
+{
+	u64 rbwb = ctrl->rbwb_cache[closid];
+	u64 mweight = ctrl->mweight_cache[closid];
+	u64 readback;
+	int ret;
+
+	lockdep_assert_held(&ctrl->lock);
+
+	if (field == CBQRI_BC_FIELD_RBWB)
+		rbwb = val;
+	else
+		mweight = val;
+
+	cbqri_set_bc_bw_alloc(ctrl, rbwb, mweight);
+
+	ret = cbqri_bc_alloc_op(ctrl, CBQRI_BC_ALLOC_CTL_OP_CONFIG_LIMIT, closid);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Pre-write a sentinel that cannot equal val to the target field
+	 * so a silent READ_LIMIT (status SUCCESS but no staging update)
+	 * is detectable in the readback. ~val truncated to the field
+	 * width cannot equal val.
+	 */
+	if (field == CBQRI_BC_FIELD_RBWB)
+		cbqri_set_rbwb(ctrl, ~val);
+	else
+		cbqri_set_mweight(ctrl, ~val);
+
+	ret = cbqri_bc_alloc_op(ctrl, CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT, closid);
+	if (ret < 0)
+		return ret;
+
+	readback = (field == CBQRI_BC_FIELD_RBWB) ?
+		   cbqri_get_rbwb(ctrl) : cbqri_get_mweight(ctrl);
+	if (readback != val) {
+		pr_err_ratelimited("BC field verify mismatch (reg=0x%llx != val=%llu)\n",
+				   readback, val);
+		return -EIO;
+	}
+
+	/* Hardware confirmed to hold val. Update the authoritative cache. */
+	if (field == CBQRI_BC_FIELD_RBWB)
+		ctrl->rbwb_cache[closid] = rbwb;
+	else
+		ctrl->mweight_cache[closid] = mweight;
+
+	return 0;
+}
+
+/*
+ * Apply an Rbwb update for closid, optionally enforcing CBQRI section 4.5
+ * sum(Rbwb) <= MRBWB. check_sum=false is used by coordinated init/reset
+ * walks where intermediate sums may transiently exceed MRBWB.
+ */
+int cbqri_apply_rbwb(struct cbqri_controller *ctrl, u32 closid,
+		     u64 rbwb, bool check_sum)
+{
+	u32 i;
+	int ret;
+
+	if (rbwb > U16_MAX)
+		return -EINVAL;
+
+	mutex_lock(&ctrl->lock);
+
+	if (check_sum && rbwb > 0) {
+		u64 sum = rbwb;
+
+		for (i = 0; i < ctrl->rcid_count; i++) {
+			if (i == closid)
+				continue;
+			sum += ctrl->rbwb_cache[i];
+		}
+		if (sum > ctrl->bc.mrbwb) {
+			/* Ratelimited: a userspace loop should not fill dmesg. */
+			pr_err_ratelimited("RBWB sum %llu exceeds MRBWB %u\n",
+					   sum, ctrl->bc.mrbwb);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+
+	ret = cbqri_apply_bc_field(ctrl, closid, CBQRI_BC_FIELD_RBWB, rbwb);
+out:
+	mutex_unlock(&ctrl->lock);
+	return ret;
+}
+
+int cbqri_apply_mweight_config(struct cbqri_controller *ctrl, u32 closid,
+			       u64 mweight)
+{
+	int ret;
+
+	if (mweight > FIELD_MAX(CBQRI_CONTROL_REGISTERS_MWEIGHT_MASK))
+		return -EINVAL;
+
+	mutex_lock(&ctrl->lock);
+	ret = cbqri_apply_bc_field(ctrl, closid, CBQRI_BC_FIELD_MWEIGHT, mweight);
+	mutex_unlock(&ctrl->lock);
+	return ret;
+}
+
+/*
+ * Read the Rbwb (reserved bandwidth blocks) for closid via READ_LIMIT.
+ */
+int cbqri_read_rbwb(struct cbqri_controller *ctrl, u32 closid, u64 *rbwb_out)
+{
+	int err;
+
+	mutex_lock(&ctrl->lock);
+	err = cbqri_bc_alloc_op(ctrl, CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT, closid);
+	if (err == 0)
+		*rbwb_out = cbqri_get_rbwb(ctrl);
+	mutex_unlock(&ctrl->lock);
+	return err;
+}
+
+/*
+ * Read the Mweight (opportunistic weight) for closid via READ_LIMIT.
+ */
+int cbqri_read_mweight(struct cbqri_controller *ctrl, u32 closid, u64 *mweight_out)
+{
+	int err;
+
+	mutex_lock(&ctrl->lock);
+	err = cbqri_bc_alloc_op(ctrl, CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT, closid);
+	if (err == 0)
+		*mweight_out = cbqri_get_mweight(ctrl);
+	mutex_unlock(&ctrl->lock);
+	return err;
+}
+
 static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_offset,
 			       int operation, int *status, bool *access_type_supported)
 {
@@ -442,6 +681,109 @@ static int cbqri_probe_cc(struct cbqri_controller *ctrl)
 	return 0;
 }
 
+static int cbqri_probe_bc(struct cbqri_controller *ctrl)
+{
+	bool has_mon_at_code = false;
+	int err, status;
+	u32 i;
+	u64 reg;
+
+	reg = ioread64(ctrl->base + CBQRI_BC_CAPABILITIES_OFF);
+	if (reg == 0)
+		return -ENODEV;
+
+	ctrl->ver_minor = FIELD_GET(CBQRI_BC_CAPABILITIES_VER_MINOR_MASK, reg);
+	ctrl->ver_major = FIELD_GET(CBQRI_BC_CAPABILITIES_VER_MAJOR_MASK, reg);
+	ctrl->bc.nbwblks = FIELD_GET(CBQRI_BC_CAPABILITIES_NBWBLKS_MASK, reg);
+	ctrl->bc.mrbwb = FIELD_GET(CBQRI_BC_CAPABILITIES_MRBWB_MASK, reg);
+
+	if (!ctrl->bc.nbwblks) {
+		pr_err("bandwidth controller has nbwblks=0\n");
+		return -EINVAL;
+	}
+
+	if (!ctrl->rcid_count) {
+		pr_err("bandwidth controller has rcid_count=0\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Reset seeds RCID 0 with mrbwb - (rcid_count - 1). Reject a
+	 * controller that would underflow that arithmetic.
+	 */
+	if (ctrl->bc.mrbwb < ctrl->rcid_count) {
+		pr_err("bandwidth controller has mrbwb=%u < rcid_count=%u, rejecting\n",
+		       ctrl->bc.mrbwb, ctrl->rcid_count);
+		return -EINVAL;
+	}
+
+	pr_debug("version=%d.%d nbwblks=%d mrbwb=%d\n",
+		 ctrl->ver_major, ctrl->ver_minor,
+		 ctrl->bc.nbwblks, ctrl->bc.mrbwb);
+
+	/* Probe monitoring features */
+	err = cbqri_probe_feature(ctrl, CBQRI_BC_MON_CTL_OFF,
+				  CBQRI_BC_MON_CTL_OP_READ_COUNTER, &status,
+				  &has_mon_at_code);
+	if (err)
+		return err;
+
+	if (status == CBQRI_MON_CTL_STATUS_SUCCESS)
+		ctrl->mon_capable = true;
+
+	/* Probe allocation features */
+	err = cbqri_probe_feature(ctrl, CBQRI_BC_ALLOC_CTL_OFF,
+				  CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT,
+				  &status, &ctrl->bc.supports_alloc_at_code);
+	if (err)
+		return err;
+
+	if (status == CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS) {
+		ctrl->alloc_capable = true;
+
+		/*
+		 * Per-RCID Rbwb and Mweight caches. The caches feed both
+		 * fields of bc_bw_alloc on every apply so the staging
+		 * register reflects authoritative software state, sidestepping
+		 * silent READ_LIMIT no-op corruption of the unmodified field.
+		 * rbwb_cache also lets cbqri_apply_rbwb() validate
+		 * sum(Rbwb) <= MRBWB without re-reading every RCID.
+		 */
+		ctrl->rbwb_cache = kcalloc(ctrl->rcid_count,
+					   sizeof(*ctrl->rbwb_cache),
+					   GFP_KERNEL);
+		if (!ctrl->rbwb_cache)
+			return -ENOMEM;
+
+		ctrl->mweight_cache = kcalloc(ctrl->rcid_count,
+					      sizeof(*ctrl->mweight_cache),
+					      GFP_KERNEL);
+		if (!ctrl->mweight_cache) {
+			kfree(ctrl->rbwb_cache);
+			ctrl->rbwb_cache = NULL;
+			return -ENOMEM;
+		}
+
+		/*
+		 * Seed mweight to the maximum, matching the resctrl-side
+		 * MB_WGHT default. cbqri_apply_bc_field() reads both halves
+		 * of bc_bw_alloc from the caches on every CONFIG_LIMIT, so
+		 * the first MB_MIN domain init (which writes Rbwb) would
+		 * otherwise commit Mweight=0 to every RCID. Per CBQRI 4.5
+		 * a weight of 0 implies the configured limit is a hard
+		 * limit and the use of unused or non-reserved bandwidth
+		 * is not allowed, which starves every RCID of opportunistic
+		 * bandwidth until the subsequent MB_WGHT domain init
+		 * catches up.
+		 */
+		for (i = 0; i < ctrl->rcid_count; i++)
+			ctrl->mweight_cache[i] =
+				FIELD_MAX(CBQRI_CONTROL_REGISTERS_MWEIGHT_MASK);
+	}
+
+	return 0;
+}
+
 static int cbqri_probe_controller(struct cbqri_controller *ctrl)
 {
 	int err;
@@ -477,6 +819,9 @@ static int cbqri_probe_controller(struct cbqri_controller *ctrl)
 	case CBQRI_CONTROLLER_TYPE_CAPACITY:
 		err = cbqri_probe_cc(ctrl);
 		break;
+	case CBQRI_CONTROLLER_TYPE_BANDWIDTH:
+		err = cbqri_probe_bc(ctrl);
+		break;
 	default:
 		pr_err("unknown controller type %d\n", ctrl->type);
 		err = -ENODEV;
@@ -529,6 +874,8 @@ void cbqri_controller_destroy(struct cbqri_controller *ctrl)
 		iounmap(ctrl->base);
 		release_mem_region(ctrl->addr, ctrl->size);
 	}
+	kfree(ctrl->mweight_cache);
+	kfree(ctrl->rbwb_cache);
 	kfree(ctrl);
 }
 
@@ -628,6 +975,38 @@ int riscv_cbqri_register_controller(const struct cbqri_controller_info *info)
 		}
 		break;
 	}
+	case CBQRI_CONTROLLER_TYPE_BANDWIDTH: {
+		struct cbqri_controller *other;
+		int node_id;
+
+		ctrl->mem.prox_dom = info->prox_dom;
+		node_id = pxm_to_node(info->prox_dom);
+		if (node_id == NUMA_NO_NODE) {
+			pr_warn("controller at %pa: proximity domain %u has no NUMA node, skipping\n",
+				&ctrl->addr, info->prox_dom);
+			cbqri_controller_destroy(ctrl);
+			return -ENODEV;
+		}
+		/*
+		 * cbqri_resctrl_dom tracks a single hw_ctrl per domain, so a
+		 * second BC sharing the same proximity domain would be
+		 * silently dropped when the resctrl glue resolves the cpu to
+		 * an existing domain. Reject the duplicate at register time
+		 * to keep the failure mode visible.
+		 */
+		list_for_each_entry(other, &cbqri_controllers, list) {
+			if (other->type != CBQRI_CONTROLLER_TYPE_BANDWIDTH)
+				continue;
+			if (other->mem.prox_dom != info->prox_dom)
+				continue;
+			pr_warn("controller at %pa: proximity domain %u already claimed by %pa, skipping\n",
+				&ctrl->addr, info->prox_dom, &other->addr);
+			cbqri_controller_destroy(ctrl);
+			return -EEXIST;
+		}
+		cpumask_copy(&ctrl->mem.cpu_mask, cpumask_of_node(node_id));
+		break;
+	}
 	default:
 		pr_warn("controller at %pa: unknown type %u, skipping\n",
 			&ctrl->addr, info->type);
diff --git a/drivers/resctrl/cbqri_internal.h b/drivers/resctrl/cbqri_internal.h
index e776b0267837..48f8a6e1923e 100644
--- a/drivers/resctrl/cbqri_internal.h
+++ b/drivers/resctrl/cbqri_internal.h
@@ -9,13 +9,21 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 
-/* Capacity Controller (CC) MMIO register offsets. */
+/*
+ * Capacity Controller (CC) and Bandwidth Controller (BC) MMIO register offsets.
+ */
 #define CBQRI_CC_CAPABILITIES_OFF 0
 #define CBQRI_CC_MON_CTL_OFF      8
 #define CBQRI_CC_MON_CTL_VAL_OFF 16
 #define CBQRI_CC_ALLOC_CTL_OFF   24
 #define CBQRI_CC_BLOCK_MASK_OFF  32
 
+#define CBQRI_BC_CAPABILITIES_OFF 0
+#define CBQRI_BC_MON_CTL_OFF      8
+#define CBQRI_BC_MON_CTR_VAL_OFF 16
+#define CBQRI_BC_ALLOC_CTL_OFF   24
+#define CBQRI_BC_BW_ALLOC_OFF    32
+
 /*
  * Smallest MMIO span the driver actually accesses: highest defined
  * register offset (0x20) plus the 8-byte register width. Used by
@@ -29,6 +37,11 @@
 #define CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK  GENMASK(7, 4)
 #define CBQRI_CC_CAPABILITIES_NCBLKS_MASK     GENMASK(23, 8)
 
+#define CBQRI_BC_CAPABILITIES_VER_MINOR_MASK  GENMASK(3, 0)
+#define CBQRI_BC_CAPABILITIES_VER_MAJOR_MASK  GENMASK(7, 4)
+#define CBQRI_BC_CAPABILITIES_NBWBLKS_MASK    GENMASK(23, 8)
+#define CBQRI_BC_CAPABILITIES_MRBWB_MASK      GENMASK_ULL(47, 32)
+
 #define CBQRI_CONTROL_REGISTERS_OP_MASK      GENMASK(4, 0)
 #define CBQRI_CONTROL_REGISTERS_AT_MASK      GENMASK(7, 5)
 #define CBQRI_CONTROL_REGISTERS_AT_DATA      0
@@ -36,14 +49,22 @@
 #define CBQRI_CONTROL_REGISTERS_RCID_MASK    GENMASK(19, 8)
 #define CBQRI_CONTROL_REGISTERS_STATUS_MASK  GENMASK_ULL(38, 32)
 #define CBQRI_CONTROL_REGISTERS_BUSY_MASK    GENMASK_ULL(39, 39)
+#define CBQRI_CONTROL_REGISTERS_RBWB_MASK    GENMASK(15, 0)
+#define CBQRI_CONTROL_REGISTERS_MWEIGHT_MASK GENMASK(27, 20)
 
 #define CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT 1
 #define CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT   2
 #define CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS  1
 
+#define CBQRI_BC_ALLOC_CTL_OP_CONFIG_LIMIT 1
+#define CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT   2
+#define CBQRI_BC_ALLOC_CTL_STATUS_SUCCESS  1
+
 #define CBQRI_CC_MON_CTL_OP_CONFIG_EVENT 1
 #define CBQRI_CC_MON_CTL_OP_READ_COUNTER 2
 
+#define CBQRI_BC_MON_CTL_OP_READ_COUNTER 2
+
 /* mon_ctl field masks (CC and BC share an identical OP/MCID/EVT_ID/STATUS layout) */
 #define CBQRI_MON_CTL_OP_MASK        GENMASK(4, 0)
 #define CBQRI_MON_CTL_MCID_MASK      GENMASK(19, 8)
@@ -61,6 +82,14 @@ struct riscv_cbqri_capacity_caps {
 	bool supports_alloc_at_code;
 };
 
+/* Bandwidth Controller hardware capabilities */
+struct riscv_cbqri_bandwidth_caps {
+	u16 nbwblks; /* number of bandwidth blocks */
+	u16 mrbwb;   /* max reserved bw blocks */
+
+	bool supports_alloc_at_code;
+};
+
 /**
  * enum cbqri_at - capacity controller access type for CDP
  * @CBQRI_AT_DATA: data access (CBQRI Table 1, AT=0)
@@ -109,6 +138,7 @@ struct cbqri_controller {
 	int ver_major;
 	int ver_minor;
 
+	struct riscv_cbqri_bandwidth_caps bc;
 	struct riscv_cbqri_capacity_caps cc;
 
 	bool alloc_capable;
@@ -120,6 +150,15 @@ struct cbqri_controller {
 	u32 rcid_count;
 	u32 mcid_count;
 
+	/*
+	 * Per-RCID cache of the most recent Rbwb / Mweight values applied
+	 * via CONFIG_LIMIT. bc_bw_alloc packs both fields into one register,
+	 * so cbqri_apply_bc_field() seeds both halves from the authoritative
+	 * cache before CONFIG_LIMIT.
+	 */
+	u16 *rbwb_cache;
+	u8  *mweight_cache;
+
 	struct list_head list;
 
 	struct cache_controller {
@@ -129,6 +168,12 @@ struct cbqri_controller {
 		/* Unique Cache ID from the PPTT table's Cache Type Structure */
 		u32 cache_id;
 	} cache;
+
+	struct mem_controller {
+		/* Proximity Domain from SRAT table Memory Affinity Controller */
+		u32 prox_dom;
+		struct cpumask cpu_mask;
+	} mem;
 };
 
 extern struct list_head cbqri_controllers;
@@ -146,4 +191,14 @@ int cbqri_mon_op(struct cbqri_controller *ctrl, int reg_offset,
 
 int cbqri_init_mon_counters(struct cbqri_controller *ctrl);
 
+int cbqri_apply_rbwb(struct cbqri_controller *ctrl, u32 closid,
+		     u64 rbwb, bool check_sum);
+
+int cbqri_apply_mweight_config(struct cbqri_controller *ctrl, u32 closid,
+			       u64 mweight);
+
+int cbqri_read_rbwb(struct cbqri_controller *ctrl, u32 closid, u64 *rbwb_out);
+
+int cbqri_read_mweight(struct cbqri_controller *ctrl, u32 closid, u64 *mweight_out);
+
 #endif /* _DRIVERS_RESCTRL_CBQRI_INTERNAL_H */

-- 
2.43.0

