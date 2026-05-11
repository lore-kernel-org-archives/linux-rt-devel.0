Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D7377EB2;
	Mon, 11 May 2026 05:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476275; cv=none; b=py8bZBSVLfVTEnJm2H6LPucHItSutqDcqkHzi+cNK8bW4GKS8BmaG0lai4Q7fDx3Xckfc3rvAl5sqiyPDl+KCxhVitd1v603EORhd7sdUyEzCXcqYg//vnxIIkYihgIAEpal4tJRrfeYb2z65cJMm4rScGqwO7uVWBKG6UdxhYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476275; c=relaxed/simple;
	bh=vbTMuSmp8KEt7D6wG8XhiJ3exZ5o54fnBY0ysq/F9V0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mSr6br3jTu4ugnH+vEfkoubyegKrsQy1AeiVKKC8I+xRq8dJF99TFBlp5j78/WXM+C+/ap7y3EpNX+enzMnlxUh72zURXe5iJTV0kZvJD0XFSxVxFQaqYtdBfi+SEJQ/FvnsdOGCT7vJA9aVeZY52rIdIHGV2FxIT+onOrt/oc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtevBB6x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtevBB6x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3509C2BD00;
	Mon, 11 May 2026 05:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476275;
	bh=vbTMuSmp8KEt7D6wG8XhiJ3exZ5o54fnBY0ysq/F9V0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LtevBB6xc2pQEAD323o+NGJi9rPEUYHvn0A1y1/JDnS/Aj93h3lQ3kGvM1TRc/Z6G
	 D5L43Recu3AT2ecG5gxC36/bCeVhAhBsqOwSOidxFZoIrJj4z3YGHcI6MwUH6+2U90
	 MM92Bd6GTbaHJkHzBfSSXmZEwU+FyP/a4Jkj8WxFafpIvtOlTAwvaJSLs1famDWenn
	 6LvEcgNMTvvlGfe5MXRMxLfR36WHwi8QA8BOcIisf5CvM/+v1QkzkGUWm+O43MwpYB
	 5XjTVdKoX07Z8ut/Qd+DqlIBGuqKeGdViyG6NQkt9PBXsgVinGH/B3b6UAqRO6UpYV
	 3/h9qvao09SGA==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 10 May 2026 22:11:05 -0700
Subject: [PATCH RFC v4 09/18] riscv_cbqri: Add bandwidth controller probe
 and allocation device ops
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-9-eb53831ef683@kernel.org>
References: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-0-eb53831ef683@kernel.org>
In-Reply-To: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-0-eb53831ef683@kernel.org>
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
 linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=16959; i=fustini@kernel.org;
 h=from:subject:message-id; bh=vbTMuSmp8KEt7D6wG8XhiJ3exZ5o54fnBY0ysq/F9V0=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQxprzO3rbjcaVmnUF3sdnffTW+3cu+beGxnmpx4f+Eo
 meugVeFOkpZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQATmXmX4X+67cuDDe0Wx3rF
 GzecMxII0utaGB52x6H88bqlviHfHvcz/JW8uNHXaLXbE/HXHwLeBX19fUY/J+7wJdZvLRHP+/Y
 JLWQGAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add support for CBQRI bandwidth controller (BC) discovery and the two BC
allocation control knobs. Rbwb is the number of reserved bandwidth
blocks per RCID. Mweight is the weighted share per RCID of the remaining
unreserved bandwidth.

Both fields share the bc_bw_alloc register, so each write needs
READ_LIMIT-modify-CONFIG_LIMIT-verify with a sentinel pre-write to catch
silent no-ops (status SUCCESS but the staged field unchanged).

cbqri_apply_rbwb() enforces the spec-mandated sum(Rbwb) <= MRBWB (max
reserved bw blocks) invariant from a per-RCID software cache rather than
per-RCID READ_LIMIT round-trips, which would cost up to 1 ms each while
holding the mutex.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/cbqri_devices.c  | 322 +++++++++++++++++++++++++++++++++++++++
 drivers/resctrl/cbqri_internal.h |  59 ++++++-
 2 files changed, 380 insertions(+), 1 deletion(-)

diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devices.c
index e46b02d2c50d..7e5decd7a6b2 100644
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
@@ -28,6 +29,44 @@ static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
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
 static int cbqri_wait_busy_flag(struct cbqri_controller *ctrl, int reg_offset,
 				u64 *regp)
 {
@@ -145,6 +184,44 @@ int cbqri_mon_op(struct cbqri_controller *ctrl, int reg_offset,
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
+	if (ctrl->faulted)
+		return -EIO;
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
@@ -271,6 +348,156 @@ int cbqri_read_cache_config(struct cbqri_controller *ctrl, u32 closid,
 	return err;
 }
 
+/*
+ * Write one field (Rbwb or Mweight) of the bc_bw_alloc staging register for
+ * closid and verify hardware accepted it. bc_bw_alloc packs both fields, so
+ * READ_LIMIT first loads the RCID's current state to preserve the unmodified
+ * field across the subsequent CONFIG_LIMIT.
+ *
+ * Caller must hold ctrl->lock.
+ */
+static int cbqri_apply_bc_field(struct cbqri_controller *ctrl, u32 closid,
+				void (*set)(struct cbqri_controller *, u64),
+				u64 (*get)(struct cbqri_controller *),
+				u64 val, bool *committed)
+{
+	int ret;
+	u64 reg;
+
+	lockdep_assert_held(&ctrl->lock);
+
+	/* Load current RCID state so the unmodified field is preserved */
+	ret = cbqri_bc_alloc_op(ctrl, CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT, closid);
+	if (ret < 0)
+		return ret;
+
+	set(ctrl, val);
+
+	ret = cbqri_bc_alloc_op(ctrl, CBQRI_BC_ALLOC_CTL_OP_CONFIG_LIMIT, closid);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * CONFIG_LIMIT committed. The per-CLOSID software cache must
+	 * track hardware regardless of whether the verify below passes.
+	 */
+	if (committed)
+		*committed = true;
+
+	/*
+	 * Pre-write a sentinel that cannot equal val so a silent
+	 * READ_LIMIT (status SUCCESS but no staging update) is detectable
+	 * in the readback. ~val works for any N-bit field width, and a
+	 * fixed-zero sentinel would collide with val == 0 (legal Mweight).
+	 */
+	set(ctrl, ~val);
+
+	ret = cbqri_bc_alloc_op(ctrl, CBQRI_BC_ALLOC_CTL_OP_READ_LIMIT, closid);
+	if (ret < 0)
+		return ret;
+
+	reg = get(ctrl);
+	if (reg != val) {
+		pr_err_ratelimited("BC field verify mismatch (reg=0x%llx != val=%llu)\n",
+				   reg, val);
+		return -EIO;
+	}
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
+	bool committed = false;
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
+	ret = cbqri_apply_bc_field(ctrl, closid,
+				   cbqri_set_rbwb, cbqri_get_rbwb, rbwb,
+				   &committed);
+	/*
+	 * Update the cache once CONFIG_LIMIT has committed. A stale
+	 * cache entry would let a future sum check pass a write that
+	 * exceeds MRBWB.
+	 */
+	if (committed)
+		ctrl->rbwb_cache[closid] = rbwb;
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
+	mutex_lock(&ctrl->lock);
+	ret = cbqri_apply_bc_field(ctrl, closid,
+				   cbqri_set_mweight, cbqri_get_mweight,
+				   mweight, NULL);
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
@@ -437,6 +664,83 @@ static int cbqri_probe_cc(struct cbqri_controller *ctrl)
 	return 0;
 }
 
+static int cbqri_probe_bc(struct cbqri_controller *ctrl)
+{
+	bool has_mon_at_code = false;
+	int err, status;
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
+	/*
+	 * rcid_count == 0 is malformed: kcalloc(0) returns ZERO_SIZE_PTR
+	 * which passes the NULL check, and the first apply oopses.
+	 */
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
+		 * Per-RCID Rbwb cache: lets cbqri_apply_rbwb() validate
+		 * sum(Rbwb) <= MRBWB without re-reading every RCID.
+		 */
+		ctrl->rbwb_cache = kcalloc(ctrl->rcid_count,
+					   sizeof(*ctrl->rbwb_cache),
+					   GFP_KERNEL);
+		if (!ctrl->rbwb_cache)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int cbqri_probe_controller(struct cbqri_controller *ctrl)
 {
 	int err;
@@ -472,6 +776,9 @@ static int cbqri_probe_controller(struct cbqri_controller *ctrl)
 	case CBQRI_CONTROLLER_TYPE_CAPACITY:
 		err = cbqri_probe_cc(ctrl);
 		break;
+	case CBQRI_CONTROLLER_TYPE_BANDWIDTH:
+		err = cbqri_probe_bc(ctrl);
+		break;
 	default:
 		pr_err("unknown controller type %d\n", ctrl->type);
 		err = -ENODEV;
@@ -515,6 +822,7 @@ int cbqri_init_mon_counters(struct cbqri_controller *ctrl)
 
 void cbqri_controller_destroy(struct cbqri_controller *ctrl)
 {
+	kfree(ctrl->rbwb_cache);
 	kfree(ctrl);
 }
 
@@ -601,6 +909,20 @@ int riscv_cbqri_register_controller(const struct cbqri_controller_info *info)
 		}
 		break;
 	}
+	case CBQRI_CONTROLLER_TYPE_BANDWIDTH: {
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
+		cpumask_copy(&ctrl->mem.cpu_mask, cpumask_of_node(node_id));
+		break;
+	}
 	default:
 		pr_warn("controller at %pa: unknown type %u, skipping\n",
 			&ctrl->addr, info->type);
diff --git a/drivers/resctrl/cbqri_internal.h b/drivers/resctrl/cbqri_internal.h
index b1169ffc599f..11a00f8e7436 100644
--- a/drivers/resctrl/cbqri_internal.h
+++ b/drivers/resctrl/cbqri_internal.h
@@ -9,13 +9,22 @@
 #include <linux/mutex.h>
 #include <linux/types.h>
 
-/* Capacity Controller (CC) MMIO register offsets. */
+/*
+ * Capacity Controller (CC) and Bandwidth Controller (BC) MMIO register
+ * offsets.
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
@@ -29,6 +38,11 @@
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
@@ -36,14 +50,22 @@
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
@@ -61,6 +83,14 @@ struct riscv_cbqri_capacity_caps {
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
@@ -106,6 +136,7 @@ struct cbqri_controller {
 	int ver_major;
 	int ver_minor;
 
+	struct riscv_cbqri_bandwidth_caps bc;
 	struct riscv_cbqri_capacity_caps cc;
 
 	bool alloc_capable;
@@ -117,6 +148,16 @@ struct cbqri_controller {
 	u32 rcid_count;
 	u32 mcid_count;
 
+	/*
+	 * Per-RCID cache of the most recent Rbwb value applied via
+	 * CONFIG_LIMIT. Lets cbqri_apply_rbwb() validate the
+	 * sum(Rbwb) <= MRBWB invariant in O(rcid_count) memory accesses
+	 * instead of O(rcid_count) READ_LIMIT round trips, each of which
+	 * spends up to 1 ms in cbqri_wait_busy_flag() under ->lock.
+	 * Allocated by cbqri_probe_bc(). NULL on capacity controllers.
+	 */
+	u16 *rbwb_cache;
+
 	struct list_head list;
 
 	struct cache_controller {
@@ -126,6 +167,12 @@ struct cbqri_controller {
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
@@ -143,4 +190,14 @@ int cbqri_mon_op(struct cbqri_controller *ctrl, int reg_offset,
 
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

