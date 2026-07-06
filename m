Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863E8434E50;
	Mon,  6 Jul 2026 23:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379190; cv=none; b=ecUQVM4WXCCofXJSilNryaQ8NzjkcV4uHxpdsnuJ9EDCcugeGqz5g2ZE7qca+nVXt1Rryc0q1jtrP9t5fwRibL+MVD9/8C63i30F5urJlrDxtJ5iMe1I7mLthTEy0rOy5BLSCvobHevbLFQpuUIDpk/51w1oz4/9nZwEKfJKU/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379190; c=relaxed/simple;
	bh=qtrN+VuVA0g11CgdreqlkyqF/0Zrwlfr9P+Em9/9e5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+C/A5uIRjQtDfHWc8Ujxp7f2hAR85OnlilhitrEnyV5uCt2SPOdY5EwLj+LX2WPMJA8FHx8cHrcCNH4X9YcOuLqq/jgyRSr4P+PCMpt66s6RRPwgnEJVRyNd+oxhxc6bNaPTu5hicSNMjxrzhDDkgjF/1faZd4ypNE/lQrebPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Blo8sYyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Blo8sYyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2941F00ADF;
	Mon,  6 Jul 2026 23:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783379187;
	bh=HNIamF3GWRHsMDMIrXTl8/rBmkMcJrmJhimqcN8QRcA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Blo8sYyHse1Sov6Bbooikz3LqxkX42VjRMYwkadQg224tKJ8lZENwjFvcoy9hYTRs
	 BGaaHogpwJq+j3bXV4xIXj3O8C9rDeCl+59jNET2erx1HdYzj83QeLw4++9utZGhy8
	 6/FkCAW6Mxk0h4QRETkqMrq/O52xVpi7Wnx4njhdgpiGu8U+YWp8UJNopahH002hf4
	 yDdUeJcebQE+XuUtor8d9BRc6Aoac+QvOxvs6Ijes4DX2lMXUoTCMhjzseFSECrn3U
	 ghNz+e/PePFKAS/Yv4rjo1m+MgVCEqRMHpXcTsR7hKedWURlREXYxDcSH8DDxAEj8H
	 oXIW8qyA/X54Q==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 06 Jul 2026 16:06:14 -0700
Subject: [PATCH v4 4/8] riscv_cbqri: Add capacity controller probe and
 allocation device ops
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-dfustini-atl-sc-cbqri-dt-v4-4-e75c20201d64@kernel.org>
References: <20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org>
In-Reply-To: <20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org>
To: Adrien Ricciardi <aricciardi@baylibre.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>, 
 Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, 
 Chen Pei <cp0613@linux.alibaba.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghuay@nvidia.com>, 
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517@gmail.com>, 
 guo.wenjia23@zte.com.cn, James Morse <james.morse@arm.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, liu.qingtao2@zte.com.cn, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, 
 Peter Newman <peternewman@google.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Reinette Chatre <reinette.chatre@intel.com>, Rob Herring <robh@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Tony Luck <tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, 
 Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=27051; i=fustini@kernel.org;
 h=from:subject:message-id; bh=qtrN+VuVA0g11CgdreqlkyqF/0Zrwlfr9P+Em9/9e5c=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWT5mLzn0TW4s0gz1JiVL77s/dXy3UmNFyR+de7+FSzE8
 iM8yty0o5SFQYyLQVZMkWXTh7wLS7xCvy6Y/2IbzBxWJpAhDFycAjARP32G/3GbFWc5vvw6Lzz/
 8MHWndvZbHu+f685vE+0tnF7WfDRKAmG/0Wm7CVXt5q476gXzxF9473ZJjO7I+27v8viLzsNlH7
 wcwMA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add support for the RISC-V CBQRI capacity controller. A platform driver
passes a cbqri_controller_info descriptor together with the cache level
to riscv_cbqri_register_cc_dt(), which probes the controller and adds it
to the controller list.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                      |   3 +
 drivers/resctrl/Kconfig          |  13 +
 drivers/resctrl/Makefile         |   3 +
 drivers/resctrl/cbqri_devices.c  | 570 +++++++++++++++++++++++++++++++++++++++
 drivers/resctrl/cbqri_internal.h | 124 +++++++++
 include/linux/riscv_cbqri.h      |  47 ++++
 6 files changed, 760 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe101986917d..8720ec65e1c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23345,6 +23345,9 @@ L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/include/asm/qos.h
 F:	arch/riscv/kernel/qos.c
+F:	drivers/resctrl/cbqri_devices.c
+F:	drivers/resctrl/cbqri_internal.h
+F:	include/linux/riscv_cbqri.h
 
 RISC-V RPMI AND MPXY DRIVERS
 M:	Rahul Pathak <rahul@summations.net>
diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
index 672abea3b03c..92b9c82cf9f3 100644
--- a/drivers/resctrl/Kconfig
+++ b/drivers/resctrl/Kconfig
@@ -29,3 +29,16 @@ config ARM64_MPAM_RESCTRL_FS
 	default y if ARM64_MPAM_DRIVER && RESCTRL_FS
 	select RESCTRL_RMID_DEPENDS_ON_CLOSID
 	select RESCTRL_ASSIGN_FIXED
+
+menuconfig RISCV_CBQRI
+	bool "RISC-V CBQRI support"
+	depends on RISCV && RISCV_ISA_SSQOSID
+	help
+	  Capacity and Bandwidth QoS Register Interface (CBQRI) support for
+	  RISC-V cache QoS resources. CBQRI exposes cache capacity
+	  allocation through the resctrl filesystem at /sys/fs/resctrl when
+	  RESCTRL_FS is also enabled.
+
+if RISCV_CBQRI
+
+endif
diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
index 4f6d0e81f9b8..4d8a2c4b5627 100644
--- a/drivers/resctrl/Makefile
+++ b/drivers/resctrl/Makefile
@@ -3,3 +3,6 @@ mpam-y						+= mpam_devices.o
 mpam-$(CONFIG_ARM64_MPAM_RESCTRL_FS)		+= mpam_resctrl.o
 
 ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
+
+obj-$(CONFIG_RISCV_CBQRI)			+= cbqri.o
+cbqri-y						+= cbqri_devices.o
diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devices.c
new file mode 100644
index 000000000000..9a767ba06198
--- /dev/null
+++ b/drivers/resctrl/cbqri_devices.c
@@ -0,0 +1,570 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
+
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/riscv_cbqri.h>
+#include <linux/cpumask.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/ioport.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <asm/csr.h>
+
+#include "cbqri_internal.h"
+
+LIST_HEAD(cbqri_controllers);
+
+/*
+ * Serializes cbqri_controllers mutations against a concurrent insert under
+ * asynchronous driver probing, and against the boot-time walk in the resctrl
+ * glue. Runtime cpuhp walks happen after registration has settled.
+ */
+DEFINE_MUTEX(cbqri_controllers_lock);
+
+/*
+ * CBQRI registers are 64-bit, but the spec only guarantees single-copy
+ * atomicity for naturally aligned 4-byte accesses. Read the two halves and
+ * reconstruct, so the driver does not rely on native 64-bit MMIO.
+ *
+ * The halves are not sampled atomically, but a tear is harmless. The fields
+ * that change while an operation runs, BUSY (bit 39) and STATUS (bits
+ * 38:32), are in the high half and read by the single high readl(). The low
+ * half (OP/AT/RCID) is software-written and constant for the operation.
+ */
+static u64 cbqri_readq(void __iomem *addr)
+{
+	u32 lo = readl(addr);
+	u32 hi = readl(addr + 4);
+
+	return (u64)hi << 32 | lo;
+}
+
+/* Set capacity block mask (cc_block_mask) */
+static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
+{
+	/*
+	 * cbqri_probe_cc() rejects ncblks > 32, so the mask fits the low word.
+	 * Per CBQRI 3.5 the cc_block_mask bits above NCBLKS are read-only zero,
+	 * so the upper word needs no write.
+	 */
+	writel(lower_32_bits(cbm), ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
+}
+
+/*
+ * Clear cc_cunits so a CONFIG_LIMIT on a CUNITS-capable controller imposes no
+ * capacity-unit limit. resctrl models only the block mask. On controllers
+ * with cc_capabilities.CUNITS == 0 the register is read-only zero, so there is
+ * nothing to do.
+ */
+static void cbqri_clear_cunits(struct cbqri_controller *ctrl)
+{
+	if (ctrl->cc.cunits) {
+		writel(0, ctrl->base + CBQRI_CC_CUNITS_OFF);
+		writel(0, ctrl->base + CBQRI_CC_CUNITS_OFF + 4);
+	}
+}
+
+static int cbqri_wait_busy_flag(struct cbqri_controller *ctrl, int reg_offset,
+				u64 *regp)
+{
+	u64 reg;
+	int ret;
+
+	/*
+	 * Sleeping poll: caller holds ctrl->lock as a sleeping mutex, so
+	 * 10us/1ms is safe under PREEMPT_RT.
+	 */
+	ret = read_poll_timeout(cbqri_readq, reg,
+				!FIELD_GET(CBQRI_CONTROL_REGISTERS_BUSY_MASK, reg),
+				10, 1000, false, ctrl->base + reg_offset);
+	if (ret)
+		return ret;
+	if (regp)
+		*regp = reg;
+	return 0;
+}
+
+/*
+ * Perform capacity allocation control operation on capacity controller.
+ * Caller must hold ctrl->lock.
+ */
+static int cbqri_cc_alloc_op(struct cbqri_controller *ctrl, int operation,
+			     int rcid, u32 at)
+{
+	int reg_offset = CBQRI_CC_ALLOC_CTL_OFF;
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
+
+	/*
+	 * CBQRI Table 1: AT 0=Data, 1=Code. Program AT on controllers
+	 * that report supports_alloc_at_code. On controllers that don't,
+	 * AT is reserved-zero and the op acts on both halves.
+	 */
+	reg &= ~CBQRI_CONTROL_REGISTERS_AT_MASK;
+	if (ctrl->cc.supports_alloc_at_code)
+		reg |= FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK, at);
+
+	writel(lower_32_bits(reg), ctrl->base + reg_offset);
+
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+		pr_err_ratelimited("BUSY timeout during operation\n");
+		return -EIO;
+	}
+
+	status = FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
+	if (status != CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS) {
+		pr_err_ratelimited("operation %d failed: status=%d\n", operation, status);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+/*
+ * Apply a capacity block mask and verify via CONFIG_LIMIT + READ_LIMIT.
+ *
+ * AT-capable controllers with CDP off need a second CONFIG_LIMIT on the
+ * other AT half (the spec encodes AT only as 0=Data / 1=Code, there is
+ * no "both halves" value). CDP-on issues separate per-type writes from
+ * resctrl, so a single CONFIG_LIMIT per call is correct.
+ */
+int cbqri_apply_cache_config(struct cbqri_controller *ctrl, u32 closid,
+			     const struct cbqri_cc_config *cfg)
+{
+	bool need_at_mirror;
+	u64 saved_cbm = 0;
+	int err = 0;
+	u64 reg;
+
+	mutex_lock(&ctrl->lock);
+
+	need_at_mirror = ctrl->cc.supports_alloc_at_code && !cfg->cdp_enabled;
+
+	/*
+	 * Capture the cfg->at half CBM before any write so a partial
+	 * AT-mirror failure can revert and keep the two halves consistent.
+	 * Pre-clear cc_block_mask so a silent firmware no-op (status
+	 * SUCCESS but staging not updated) shows as a zero readback
+	 * rather than carrying stale data from a prior op.
+	 */
+	if (need_at_mirror) {
+		cbqri_set_cbm(ctrl, 0);
+		err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
+					closid, cfg->at);
+		if (err < 0)
+			goto out;
+		saved_cbm = cbqri_readq(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
+	}
+
+	/* Set capacity block mask (cc_block_mask) */
+	cbqri_set_cbm(ctrl, cfg->cbm);
+	cbqri_clear_cunits(ctrl);
+
+	/* Capacity config limit operation for the AT half implied by cfg->at */
+	err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT,
+				closid, cfg->at);
+	if (err < 0)
+		goto out;
+
+	/*
+	 * CDP-off mirror: on AT-capable controllers, also program the
+	 * other AT half with the same mask so the two halves stay in sync.
+	 */
+	if (need_at_mirror) {
+		u32 other = (cfg->at == CBQRI_CONTROL_REGISTERS_AT_CODE) ?
+			    CBQRI_CONTROL_REGISTERS_AT_DATA :
+			    CBQRI_CONTROL_REGISTERS_AT_CODE;
+
+		cbqri_set_cbm(ctrl, cfg->cbm);
+		cbqri_clear_cunits(ctrl);
+		err = cbqri_cc_alloc_op(ctrl,
+					CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT,
+					closid, other);
+		if (err < 0) {
+			int rerr;
+
+			/*
+			 * Best-effort revert of the cfg->at half so the two
+			 * halves stay in sync. A schemata read sees only one
+			 * half, so silent divergence would otherwise report
+			 * the new value as if the write had succeeded.
+			 */
+			cbqri_set_cbm(ctrl, saved_cbm);
+			cbqri_clear_cunits(ctrl);
+			rerr = cbqri_cc_alloc_op(ctrl,
+						 CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT,
+						 closid, cfg->at);
+			if (rerr < 0)
+				pr_err_ratelimited("AT-mirror revert failed (err=%d), AT halves diverged\n",
+						   rerr);
+			goto out;
+		}
+	}
+
+	/* Clear cc_block_mask before read limit to verify op works */
+	cbqri_set_cbm(ctrl, 0);
+
+	/* Perform a capacity read limit operation to verify blockmask */
+	err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
+				closid, cfg->at);
+	if (err < 0)
+		goto out;
+
+	/*
+	 * Read capacity blockmask and narrow to u32 to match resctrl's CBM
+	 * width. cbqri_probe_cc() rejects ncblks > 32 so the upper bits are
+	 * reserved zero.
+	 */
+	reg = cbqri_readq(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
+	if (lower_32_bits(reg) != cfg->cbm) {
+		pr_err_ratelimited("CBM verify mismatch (reg=%llx != cbm=%llx)\n",
+				   reg, cfg->cbm);
+		err = -EIO;
+	}
+
+out:
+	mutex_unlock(&ctrl->lock);
+	return err;
+}
+
+/*
+ * Read the configured CBM for closid on the at half via READ_LIMIT.
+ * Pre-clears cc_block_mask before the op so a silent firmware no-op
+ * (status SUCCESS but staging not updated) is detectable in cbm_out.
+ */
+int cbqri_read_cache_config(struct cbqri_controller *ctrl, u32 closid,
+			    u32 at, u32 *cbm_out)
+{
+	int err;
+
+	mutex_lock(&ctrl->lock);
+	cbqri_set_cbm(ctrl, 0);
+	err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, closid, at);
+	if (err == 0) {
+		/*
+		 * resctrl exposes the CBM as a u32 and cbqri_probe_cc() rejects
+		 * ncblks > 32, so the mask fits the low 32-bit word of the
+		 * cc_block_mask register.
+		 */
+		*cbm_out = readl(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
+	}
+	mutex_unlock(&ctrl->lock);
+	return err;
+}
+
+static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_offset,
+			       int operation, int *status, bool *access_type_supported)
+{
+	const u64 active_mask = CBQRI_CONTROL_REGISTERS_OP_MASK |
+				CBQRI_CONTROL_REGISTERS_AT_MASK |
+				CBQRI_CONTROL_REGISTERS_RCID_MASK;
+	u64 reg, saved_reg;
+	int at;
+
+	/*
+	 * Default the output to false so the status==0 (feature not
+	 * implemented) path returns a deterministic value to the caller
+	 * rather than leaving an uninitialized bool.
+	 */
+	*access_type_supported = false;
+
+	/* Keep the initial register value to preserve the WPRI fields */
+	reg = cbqri_readq(ctrl->base + reg_offset);
+	saved_reg = reg;
+
+	/* Drain any in-flight firmware op before issuing our own write. */
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &saved_reg) < 0) {
+		pr_err("BUSY timeout before probe operation\n");
+		return -EIO;
+	}
+
+	/*
+	 * Execute the requested operation with all active fields
+	 * (OP/AT/RCID) zeroed except OP itself. Every bit not in
+	 * active_mask is WPRI and gets carried over from saved_reg.
+	 */
+	reg = (saved_reg & ~active_mask) |
+	      FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation);
+	writel(lower_32_bits(reg), ctrl->base + reg_offset);
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+		pr_err_ratelimited("BUSY timeout during operation\n");
+		return -EIO;
+	}
+
+	/* Get the operation status */
+	*status = FIELD_GET(CBQRI_CONTROL_REGISTERS_STATUS_MASK, reg);
+
+	/*
+	 * Check for the AT support if the register is implemented
+	 * (if not, the status value will remain 0)
+	 */
+	if (*status != 0) {
+		/*
+		 * Re-issue operation with AT=CODE so the controller
+		 * latches AT=CODE on supported hardware (or resets it to 0
+		 * on hardware that doesn't). OP must be a defined CBQRI op
+		 * here. OP=0 is a no-op and would silently disable CDP.
+		 */
+		reg = (saved_reg & ~active_mask) |
+		      FIELD_PREP(CBQRI_CONTROL_REGISTERS_OP_MASK, operation) |
+		      FIELD_PREP(CBQRI_CONTROL_REGISTERS_AT_MASK,
+				 CBQRI_CONTROL_REGISTERS_AT_CODE);
+		writel(lower_32_bits(reg), ctrl->base + reg_offset);
+		if (cbqri_wait_busy_flag(ctrl, reg_offset, &reg) < 0) {
+			pr_err("BUSY timeout setting AT field\n");
+			return -EIO;
+		}
+
+		/*
+		 * If the AT field value has been reset to zero,
+		 * then the AT support is not present
+		 */
+		at = FIELD_GET(CBQRI_CONTROL_REGISTERS_AT_MASK, reg);
+		if (at == CBQRI_CONTROL_REGISTERS_AT_CODE)
+			*access_type_supported = true;
+	}
+
+	/*
+	 * Restore the original register value.
+	 * Clear OP to avoid re-triggering the probe op.
+	 */
+	saved_reg &= ~CBQRI_CONTROL_REGISTERS_OP_MASK;
+	writel(lower_32_bits(saved_reg), ctrl->base + reg_offset);
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, NULL) < 0) {
+		pr_err("BUSY timeout restoring register value\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int cbqri_probe_cc(struct cbqri_controller *ctrl)
+{
+	int err, status;
+	int ver_major, ver_minor;
+	u64 reg;
+
+	reg = cbqri_readq(ctrl->base + CBQRI_CC_CAPABILITIES_OFF);
+	if (reg == 0)
+		return -ENODEV;
+
+	ver_minor = FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MINOR_MASK, reg);
+	ver_major = FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK, reg);
+	ctrl->cc.ncblks = FIELD_GET(CBQRI_CC_CAPABILITIES_NCBLKS_MASK, reg);
+
+	pr_debug("version=%d.%d ncblks=%d cache_level=%d\n",
+		 ver_major, ver_minor,
+		 ctrl->cc.ncblks, ctrl->cache.cache_level);
+
+	/*
+	 * NCBLKS == 0 would divide-by-zero in the schemata math while
+	 * ctrl->lock is held.
+	 */
+	if (!ctrl->cc.ncblks) {
+		pr_warn("CC at %pa has 0 capacity blocks, skipping\n",
+			&ctrl->addr);
+		return -ENODEV;
+	}
+
+	if (ctrl->cc.ncblks > 32) {
+		pr_warn("CC at %pa has ncblks=%u > 32 (resctrl CBM is u32), skipping\n",
+			&ctrl->addr, ctrl->cc.ncblks);
+		return -ENODEV;
+	}
+
+	/*
+	 * On a CUNITS-capable controller, CONFIG_LIMIT also consumes cc_cunits,
+	 * whose reset value is unspecified. The driver clears it to 0 (no limit)
+	 * on every CONFIG_LIMIT, so cc_cunits at 0x28 must be within the mapping.
+	 */
+	ctrl->cc.cunits = FIELD_GET(CBQRI_CC_CAPABILITIES_CUNITS_MASK, reg);
+	if (ctrl->cc.cunits && ctrl->size < CBQRI_CC_CUNITS_OFF + 8) {
+		pr_warn("CC at %pa supports CUNITS but maps only %pa, skipping\n",
+			&ctrl->addr, &ctrl->size);
+		return -ENODEV;
+	}
+
+	/* Probe allocation features */
+	err = cbqri_probe_feature(ctrl, CBQRI_CC_ALLOC_CTL_OFF,
+				  CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
+				  &status, &ctrl->cc.supports_alloc_at_code);
+	if (err)
+		return err;
+
+	if (status == CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS)
+		ctrl->alloc_capable = true;
+
+	return 0;
+}
+
+static int cbqri_probe_controller(struct cbqri_controller *ctrl)
+{
+	int err;
+
+	pr_debug("controller info: type=%d addr=%pa size=%pa max-rcid=%u\n",
+		 ctrl->type, &ctrl->addr, &ctrl->size, ctrl->rcid_count);
+
+	if (!ctrl->addr) {
+		pr_warn("controller has invalid addr=0x0, skipping\n");
+		return -EINVAL;
+	}
+
+	if (ctrl->size < CBQRI_CTRL_MIN_REG_SPAN) {
+		pr_warn("controller at %pa: size %pa < minimum 0x%x, skipping\n",
+			&ctrl->addr, &ctrl->size, CBQRI_CTRL_MIN_REG_SPAN);
+		return -EINVAL;
+	}
+
+	if (!request_mem_region(ctrl->addr, ctrl->size, "cbqri_controller")) {
+		pr_err("request_mem_region failed for %pa\n", &ctrl->addr);
+		return -EBUSY;
+	}
+
+	ctrl->base = ioremap(ctrl->addr, ctrl->size);
+	if (!ctrl->base) {
+		pr_err("ioremap failed for %pa\n", &ctrl->addr);
+		err = -ENOMEM;
+		goto err_release;
+	}
+
+	switch (ctrl->type) {
+	case CBQRI_CONTROLLER_TYPE_CAPACITY:
+		err = cbqri_probe_cc(ctrl);
+		break;
+	default:
+		pr_err("unknown controller type %d\n", ctrl->type);
+		err = -ENODEV;
+		break;
+	}
+
+	if (err)
+		goto err_iounmap;
+
+	return 0;
+
+err_iounmap:
+	iounmap(ctrl->base);
+	ctrl->base = NULL;
+err_release:
+	release_mem_region(ctrl->addr, ctrl->size);
+	return err;
+}
+
+void cbqri_controller_destroy(struct cbqri_controller *ctrl)
+{
+	/*
+	 * cbqri_probe_controller() clears ctrl->base on its error paths and
+	 * releases the mem region itself, so reach into both only when
+	 * destroy is rolling back a successful probe.
+	 */
+	if (ctrl->base) {
+		iounmap(ctrl->base);
+		release_mem_region(ctrl->addr, ctrl->size);
+	}
+	kfree(ctrl);
+}
+
+/**
+ * riscv_cbqri_register_cc_dt() - register a DT-described capacity controller
+ * @info:        registration descriptor. info->cache_id is used as the
+ *               resctrl domain id. info->type must be CAPACITY.
+ * @cache_level: cache level (2 or 3) the controller backs, mapped to the
+ *               resctrl L2/L3 resource by the resctrl glue.
+ * @cpu_mask:    CPUs that share this cache.
+ *
+ * The cache topology is supplied directly by the caller. A device-tree
+ * platform driver that already knows which CPUs share the cache and at what
+ * level passes that in. There is no firmware table to resolve it from.
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int riscv_cbqri_register_cc_dt(const struct cbqri_controller_info *info,
+			       u32 cache_level, const struct cpumask *cpu_mask)
+{
+	struct cbqri_controller *ctrl;
+	int err;
+
+	if (!info->addr) {
+		pr_warn("skipping controller with invalid addr=0x0\n");
+		return -EINVAL;
+	}
+
+	if (info->type != CBQRI_CONTROLLER_TYPE_CAPACITY) {
+		pr_warn("register_cc_dt called with non-capacity type %u\n",
+			info->type);
+		return -EINVAL;
+	}
+
+	if (!cpu_mask || cpumask_empty(cpu_mask)) {
+		pr_warn("register_cc_dt called with empty cpu_mask\n");
+		return -EINVAL;
+	}
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		return -ENOMEM;
+
+	mutex_init(&ctrl->lock);
+
+	ctrl->addr = info->addr;
+	ctrl->size = info->size;
+	ctrl->type = info->type;
+	ctrl->rcid_count = info->rcid_count;
+
+	/*
+	 * SRMCFG encodes RCID in 12 bits. Reject an out-of-range count rather
+	 * than silently truncating in every FIELD_PREP(SRMCFG_RCID_MASK, closid)
+	 * on the schedule-in fast path.
+	 */
+	if (ctrl->rcid_count > FIELD_MAX(SRMCFG_RCID_MASK) + 1) {
+		pr_warn("CC at %pa has RCID count %u beyond the 12-bit SRMCFG field, skipping\n",
+			&ctrl->addr, ctrl->rcid_count);
+		cbqri_controller_destroy(ctrl);
+		return -EINVAL;
+	}
+
+	ctrl->cache.cache_id = info->cache_id;
+	ctrl->cache.cache_level = cache_level;
+	cpumask_copy(&ctrl->cache.cpu_mask, cpu_mask);
+
+	err = cbqri_probe_controller(ctrl);
+	if (err) {
+		cbqri_controller_destroy(ctrl);
+		return err;
+	}
+
+	/*
+	 * Allocation capability comes from the capabilities register probed
+	 * above, not from device tree. rcid_count only bounds the RCID range,
+	 * so a controller the hardware reports as alloc-capable but described
+	 * with no RCID count cannot be driven. Reject that inconsistency. A
+	 * monitoring-only controller (not alloc_capable) needs no RCID count.
+	 */
+	if (ctrl->alloc_capable && !ctrl->rcid_count) {
+		pr_warn("CC at %pa is alloc-capable but has no RCID count, skipping\n",
+			&ctrl->addr);
+		cbqri_controller_destroy(ctrl);
+		return -EINVAL;
+	}
+
+	guard(mutex)(&cbqri_controllers_lock);
+	list_add_tail(&ctrl->list, &cbqri_controllers);
+	return 0;
+}
diff --git a/drivers/resctrl/cbqri_internal.h b/drivers/resctrl/cbqri_internal.h
new file mode 100644
index 000000000000..cbc9166ad4c0
--- /dev/null
+++ b/drivers/resctrl/cbqri_internal.h
@@ -0,0 +1,124 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _DRIVERS_RESCTRL_CBQRI_INTERNAL_H
+#define _DRIVERS_RESCTRL_CBQRI_INTERNAL_H
+
+#include <linux/bitfield.h>
+#include <linux/riscv_cbqri.h>
+#include <linux/cpumask.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+/* Capacity Controller (CC) MMIO register offsets. */
+#define CBQRI_CC_CAPABILITIES_OFF 0
+#define CBQRI_CC_ALLOC_CTL_OFF   24
+#define CBQRI_CC_BLOCK_MASK_OFF  32
+
+/*
+ * Per CBQRI 3.5 the block-mask width BMW is the smallest multiple of 64 bits
+ * that holds NCBLKS, so cc_cunits sits at 32 + BMW/8 bytes. This constant is
+ * valid only while NCBLKS <= 64. cbqri_probe_cc() rejects ncblks > 32 before
+ * it reads cc_capabilities.CUNITS, forcing BMW to 64 bits, one 8-byte block
+ * mask, and cc_cunits at 0x28. Raising that cap above 64 would require
+ * computing 32 + roundup(ncblks, 64) / 8 instead of a constant.
+ */
+#define CBQRI_CC_CUNITS_OFF      40
+
+/*
+ * Highest base register offset (cc_block_mask at 0x20) plus its 8-byte width.
+ * cbqri_probe_controller() rejects smaller mappings. cc_cunits at 0x28 is
+ * optional and only required when cc_capabilities.CUNITS is set, which
+ * cbqri_probe_cc() checks against the mapping size separately.
+ */
+#define CBQRI_CTRL_MIN_REG_SPAN  0x28u
+
+#define CBQRI_CC_CAPABILITIES_VER_MINOR_MASK  GENMASK_ULL(3, 0)
+#define CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK  GENMASK_ULL(7, 4)
+#define CBQRI_CC_CAPABILITIES_NCBLKS_MASK     GENMASK_ULL(23, 8)
+#define CBQRI_CC_CAPABILITIES_CUNITS_MASK     BIT_ULL(25)
+
+/*
+ * CC control registers are 64-bit, but the CBQRI spec only guarantees
+ * single-copy atomicity for naturally aligned 4-byte accesses. They are read
+ * as two 32-bit halves (cbqri_readq) reconstructed into a u64 for field
+ * extraction, and written via the low 32-bit half, so the driver does not
+ * depend on native 64-bit MMIO. Keep every field mask GENMASK_ULL so
+ * FIELD_MODIFY() or ~mask on the reconstructed u64 never zero-extends a
+ * 32-bit mask and clobbers STATUS/BUSY/WPRI in bits 63:32.
+ */
+#define CBQRI_CONTROL_REGISTERS_OP_MASK      GENMASK_ULL(4, 0)
+#define CBQRI_CONTROL_REGISTERS_AT_MASK      GENMASK_ULL(7, 5)
+/* AT field values (CBQRI Table 1): data vs code half for CDP */
+#define CBQRI_CONTROL_REGISTERS_AT_DATA      0
+#define CBQRI_CONTROL_REGISTERS_AT_CODE      1
+#define CBQRI_CONTROL_REGISTERS_RCID_MASK    GENMASK_ULL(19, 8)
+#define CBQRI_CONTROL_REGISTERS_STATUS_MASK  GENMASK_ULL(38, 32)
+#define CBQRI_CONTROL_REGISTERS_BUSY_MASK    GENMASK_ULL(39, 39)
+
+#define CBQRI_CC_ALLOC_CTL_OP_CONFIG_LIMIT 1
+#define CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT   2
+#define CBQRI_CC_ALLOC_CTL_STATUS_SUCCESS  1
+
+/* Capacity Controller hardware capabilities */
+struct riscv_cbqri_capacity_caps {
+	u16 ncblks;
+	bool supports_alloc_at_code;
+	/* cc_capabilities.CUNITS: controller enforces a capacity-unit limit */
+	bool cunits;
+};
+
+/**
+ * struct cbqri_cc_config - desired capacity allocation state for one rcid
+ * @cbm:         capacity block mask
+ * @at:          AT half the @cbm applies to (CBQRI_CONTROL_REGISTERS_AT_DATA
+ *               or CBQRI_CONTROL_REGISTERS_AT_CODE)
+ * @cdp_enabled: when false and the controller supports AT, mirror @cbm
+ *               into the other AT half so both stay in sync
+ */
+struct cbqri_cc_config {
+	u64  cbm;
+	u32  at;
+	bool cdp_enabled;
+};
+
+struct cbqri_controller {
+	void __iomem *base;
+	/*
+	 * Serializes the write-then-poll-busy MMIO sequences on this
+	 * controller. Each CBQRI op may busy-wait up to 1 ms on slow
+	 * firmware, so use a sleeping mutex to keep preemption enabled.
+	 * All resctrl-arch entry points run in process context.
+	 */
+	struct mutex lock;
+
+	struct riscv_cbqri_capacity_caps cc;
+
+	bool alloc_capable;
+
+	phys_addr_t addr;
+	phys_addr_t size;
+	enum cbqri_controller_type type;
+	u32 rcid_count;
+
+	struct list_head list;
+
+	struct cache_controller {
+		u32 cache_level;
+		struct cpumask cpu_mask;
+		/* Cache id used as the resctrl domain id */
+		u32 cache_id;
+	} cache;
+};
+
+extern struct list_head cbqri_controllers;
+extern struct mutex cbqri_controllers_lock;
+
+void cbqri_controller_destroy(struct cbqri_controller *ctrl);
+
+int cbqri_apply_cache_config(struct cbqri_controller *ctrl, u32 closid,
+			     const struct cbqri_cc_config *cfg);
+
+int cbqri_read_cache_config(struct cbqri_controller *ctrl, u32 closid,
+			    u32 at, u32 *cbm_out);
+
+#endif /* _DRIVERS_RESCTRL_CBQRI_INTERNAL_H */
diff --git a/include/linux/riscv_cbqri.h b/include/linux/riscv_cbqri.h
new file mode 100644
index 000000000000..58737224d2f2
--- /dev/null
+++ b/include/linux/riscv_cbqri.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Public registration API for the RISC-V Capacity and Bandwidth QoS
+ * Register Interface (CBQRI) core. Discovery layers (device tree
+ * platform drivers) call riscv_cbqri_register_cc_dt() to hand a capacity
+ * controller descriptor to the core, which owns all subsequent state.
+ */
+#ifndef _LINUX_RISCV_CBQRI_H
+#define _LINUX_RISCV_CBQRI_H
+
+#include <linux/types.h>
+
+struct cpumask;
+
+enum cbqri_controller_type {
+	CBQRI_CONTROLLER_TYPE_CAPACITY,
+};
+
+/**
+ * struct cbqri_controller_info - registration descriptor
+ * @addr:        MMIO base address of the controller's register interface
+ * @size:        size of the MMIO region
+ * @type:        controller type (capacity)
+ * @rcid_count:  number of supported RCIDs
+ * @cache_id:    cache id used as the resctrl domain id
+ */
+struct cbqri_controller_info {
+	phys_addr_t			addr;
+	phys_addr_t			size;
+	enum cbqri_controller_type	type;
+	u32				rcid_count;
+	u32				cache_id;
+};
+
+#if IS_ENABLED(CONFIG_RISCV_CBQRI)
+int riscv_cbqri_register_cc_dt(const struct cbqri_controller_info *info,
+			       u32 cache_level, const struct cpumask *cpu_mask);
+#else
+static inline int
+riscv_cbqri_register_cc_dt(const struct cbqri_controller_info *info,
+			   u32 cache_level, const struct cpumask *cpu_mask)
+{
+	return -ENODEV;
+}
+#endif
+
+#endif /* _LINUX_RISCV_CBQRI_H */

-- 
2.43.0

