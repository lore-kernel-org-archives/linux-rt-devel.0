Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0264E37DEB8;
	Mon, 11 May 2026 05:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476274; cv=none; b=IoyzKLou2vCA5D+8L9X2FggRcToW70BPe9FxnyM0E4dv09yDKSzy8OKDXaJ6WCKjvkJkV4jw4UyTLpgOfd1MKXzfIW5CHbYblOzZUlh/CQUoFS07taSjaga5pvzwTEdPutkdTaXtBCzFfKoBDnIVwiEcY8gsWSQUB58KCDybbOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476274; c=relaxed/simple;
	bh=KKKwhdfWBZbsYLwKRvD3zdMUmtE8JC+2cxZr/Mt5HFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XxcBd3ETdKYh9ws0Ul1iMiC8UY93P3Nn8iPwKxs+CwlicX4vu5UYhwc0aLBQbLruhSO0BypnuNsFOuIVBk4RgmsglahkcQevnymhPFvkaNusgULeTCKGNH9zODK4/jpP76Ja2CsrAvX9XgWSlnW1C0a6EmeSkC99Af7DtoGsVrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsz6ul6f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsz6ul6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A882C2BCFD;
	Mon, 11 May 2026 05:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476273;
	bh=KKKwhdfWBZbsYLwKRvD3zdMUmtE8JC+2cxZr/Mt5HFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dsz6ul6fV9i3xnIlfSvvQ73jicJsVDt0BCNYH9VNd7Wyu0rSu2LcRoR7nfjyiB/sX
	 T4SBCFDG32whuRNL40PCQ1NtM3epJ1DfM+ttDHzE8wbrzeWEv+XR9XGGkU3916lbY0
	 qAGvWG/uSmlQKZ5Yj5SzKYmmGs5wbC0F51ETZicayTSST8QwYMQchcBhjOH42zlNQz
	 r/IpurRlWW4rgdiCvsK/3idoPTifDeLUtL3ky3mPkouFEXJd4SRToBwYI5hHesZLJX
	 7blksdiVdWL67NCZKODWBs/UKZbV13YIbcYcnHsPrAPHzLb42sjpHZrGmUNfNlwDn9
	 JJ9JneF0pzCLw==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 10 May 2026 22:11:03 -0700
Subject: [PATCH RFC v4 07/18] riscv_cbqri: Add capacity controller probe
 and allocation device ops
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-7-eb53831ef683@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=26522; i=fustini@kernel.org;
 h=from:subject:message-id; bh=KKKwhdfWBZbsYLwKRvD3zdMUmtE8JC+2cxZr/Mt5HFg=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQxpry2fVWveemS3f5kaeeLVq96tp+24jZzfLt46X+TJ
 XYiC7J1O0pZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQAT0TzO8D9TS1CxJyf+7DJv
 mcUfNKevbJvqJnNt0/HfHF+DbjPdK/rEyHBnQ4/EiiucRVniV7Q8NPyvrX3PODWyVnnDtd6ladP
 DbnMBAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add support for the RISC-V CBQRI capacity controller (CC). The firmware
discovery layer (ACPI or DT) is responsible for passing the
cbqri_controller_info descriptor to riscv_cbqri_register_controller().
The driver resolves the cpumask so callers do not need the cacheinfo
topology.

Each CC op is a sleeping read-poll-write-verify cycle on cc_alloc_ctl.
readq_poll_timeout() keeps preemption enabled so the driver is safe
under PREEMPT_RT. A sticky ctrl->faulted short-circuits subsequent ops
on a stuck controller.

AT-capable controllers with CDP off mirror the cbm into both DATA and
CODE halves so the spec's reserved-zero AT field cannot diverge.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                      |   3 +
 drivers/resctrl/Kconfig          |  28 ++
 drivers/resctrl/Makefile         |   5 +
 drivers/resctrl/cbqri_devices.c  | 534 +++++++++++++++++++++++++++++++++++++++
 drivers/resctrl/cbqri_internal.h | 125 +++++++++
 include/linux/riscv_cbqri.h      |  66 +++++
 6 files changed, 761 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5039f48f387a..f20a5929eb9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23013,6 +23013,9 @@ L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/include/asm/qos.h
 F:	arch/riscv/kernel/qos.c
+F:	drivers/resctrl/cbqri_devices.c
+F:	drivers/resctrl/cbqri_internal.h
+F:	include/linux/riscv_cbqri.h
 
 RISC-V RPMI AND MPXY DRIVERS
 M:	Rahul Pathak <rahul@summations.net>
diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
index 672abea3b03c..d578bc7aed85 100644
--- a/drivers/resctrl/Kconfig
+++ b/drivers/resctrl/Kconfig
@@ -29,3 +29,31 @@ config ARM64_MPAM_RESCTRL_FS
 	default y if ARM64_MPAM_DRIVER && RESCTRL_FS
 	select RESCTRL_RMID_DEPENDS_ON_CLOSID
 	select RESCTRL_ASSIGN_FIXED
+
+menuconfig RISCV_CBQRI_DRIVER
+	bool "RISC-V CBQRI driver"
+	depends on RISCV && RISCV_ISA_SSQOSID
+	help
+	  Capacity and Bandwidth QoS Register Interface (CBQRI) driver
+	  for RISC-V cache and memory-controller QoS resources. CBQRI
+	  exposes capacity allocation, bandwidth reservation, weighted
+	  bandwidth share, and per-MCID monitoring counters through the
+	  resctrl filesystem at /sys/fs/resctrl when RESCTRL_FS is also
+	  enabled.
+
+	  RISCV_ISA_SSQOSID provides the srmcfg CSR that tags each hart's
+	  memory traffic with the RCID and MCID consumed by CBQRI
+	  controllers.
+
+if RISCV_CBQRI_DRIVER
+
+config RISCV_CBQRI_DRIVER_DEBUG
+	bool "Enable debug messages from the CBQRI driver"
+	help
+	  Say yes here to enable debug messages from the CBQRI driver.
+
+	  This adds pr_debug() output covering controller probe and
+	  per-controller registration steps.  Useful when bringing up a
+	  new platform; otherwise leave disabled to avoid log noise.
+
+endif
diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
index 4f6d0e81f9b8..28085036d895 100644
--- a/drivers/resctrl/Makefile
+++ b/drivers/resctrl/Makefile
@@ -3,3 +3,8 @@ mpam-y						+= mpam_devices.o
 mpam-$(CONFIG_ARM64_MPAM_RESCTRL_FS)		+= mpam_resctrl.o
 
 ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
+
+obj-$(CONFIG_RISCV_CBQRI_DRIVER)		+= cbqri.o
+cbqri-y						+= cbqri_devices.o
+
+ccflags-$(CONFIG_RISCV_CBQRI_DRIVER_DEBUG)	+= -DDEBUG
diff --git a/drivers/resctrl/cbqri_devices.c b/drivers/resctrl/cbqri_devices.c
new file mode 100644
index 000000000000..dc76a146e34d
--- /dev/null
+++ b/drivers/resctrl/cbqri_devices.c
@@ -0,0 +1,534 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/cacheinfo.h>
+#include <linux/riscv_cbqri.h>
+#include <linux/cpu.h>
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
+#include "cbqri_internal.h"
+
+LIST_HEAD(cbqri_controllers);
+
+/* Set capacity block mask (cc_block_mask) */
+static void cbqri_set_cbm(struct cbqri_controller *ctrl, u64 cbm)
+{
+	iowrite64(cbm, ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
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
+	ret = readq_poll_timeout(ctrl->base + reg_offset, reg,
+				 !FIELD_GET(CBQRI_CONTROL_REGISTERS_BUSY_MASK, reg),
+				 10, 1000);
+	if (ret) {
+		/* Mark faulted so subsequent ops fail fast instead of repeating the 1ms wait. */
+		ctrl->faulted = true;
+		return ret;
+	}
+	/*
+	 * Clear any prior fault: probe-time paths do not gate on ->faulted,
+	 * so a transient early-boot stall self-heals once the controller
+	 * next responds.
+	 */
+	ctrl->faulted = false;
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
+			     int rcid, enum cbqri_at at)
+{
+	int reg_offset = CBQRI_CC_ALLOC_CTL_OFF;
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
+	iowrite64(reg, ctrl->base + reg_offset);
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
+	 */
+	if (need_at_mirror) {
+		err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT,
+					closid, cfg->at);
+		if (err < 0)
+			goto out;
+		saved_cbm = ioread64(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
+	}
+
+	/* Set capacity block mask (cc_block_mask) */
+	cbqri_set_cbm(ctrl, cfg->cbm);
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
+		enum cbqri_at other = (cfg->at == CBQRI_AT_CODE) ?
+				      CBQRI_AT_DATA : CBQRI_AT_CODE;
+
+		cbqri_set_cbm(ctrl, cfg->cbm);
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
+	reg = ioread64(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF);
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
+			    enum cbqri_at at, u32 *cbm_out)
+{
+	int err;
+
+	mutex_lock(&ctrl->lock);
+	cbqri_set_cbm(ctrl, 0);
+	err = cbqri_cc_alloc_op(ctrl, CBQRI_CC_ALLOC_CTL_OP_READ_LIMIT, closid, at);
+	if (err == 0) {
+		/*
+		 * cc_block_mask is a 64-bit MMIO register. resctrl exposes the
+		 * CBM as a u32. cbqri_probe_cc() rejects ncblks > 32 so the
+		 * upper 32 bits are reserved zero by the spec. Narrow
+		 * explicitly via lower_32_bits() so the assumption is visible
+		 * at the read site.
+		 */
+		*cbm_out = lower_32_bits(ioread64(ctrl->base + CBQRI_CC_BLOCK_MASK_OFF));
+	}
+	mutex_unlock(&ctrl->lock);
+	return err;
+}
+
+static int cbqri_probe_feature(struct cbqri_controller *ctrl, int reg_offset,
+			       int operation, int *status, bool *access_type_supported)
+{
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
+	reg = ioread64(ctrl->base + reg_offset);
+	saved_reg = reg;
+
+	/* Drain any in-flight firmware op before issuing our own write. */
+	if (cbqri_wait_busy_flag(ctrl, reg_offset, &saved_reg) < 0) {
+		pr_err("BUSY timeout before probe operation\n");
+		return -EIO;
+	}
+	reg = saved_reg;
+
+	/* Execute the requested operation to find if the register is implemented */
+	FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_OP_MASK, &reg, operation);
+	reg &= ~CBQRI_CONTROL_REGISTERS_RCID_MASK;
+	iowrite64(reg, ctrl->base + reg_offset);
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
+		reg = saved_reg;
+		FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_OP_MASK, &reg, operation);
+		FIELD_MODIFY(CBQRI_CONTROL_REGISTERS_AT_MASK, &reg,
+			     CBQRI_CONTROL_REGISTERS_AT_CODE);
+		iowrite64(reg, ctrl->base + reg_offset);
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
+	/* Restore the original register value. Clear OP to avoid re-triggering the probe op. */
+	saved_reg &= ~CBQRI_CONTROL_REGISTERS_OP_MASK;
+	iowrite64(saved_reg, ctrl->base + reg_offset);
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
+	u64 reg;
+
+	reg = ioread64(ctrl->base + CBQRI_CC_CAPABILITIES_OFF);
+	if (reg == 0)
+		return -ENODEV;
+
+	ctrl->ver_minor = FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MINOR_MASK, reg);
+	ctrl->ver_major = FIELD_GET(CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK, reg);
+	ctrl->cc.ncblks = FIELD_GET(CBQRI_CC_CAPABILITIES_NCBLKS_MASK, reg);
+
+	pr_debug("version=%d.%d ncblks=%d cache_level=%d\n",
+		 ctrl->ver_major, ctrl->ver_minor,
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
+	 * Resolve cache_size via cacheinfo. cpus_read_lock satisfies
+	 * lockdep_assert_cpus_held() inside get_cpu_cacheinfo_level(). If
+	 * every cpu_mask member is offline, cache_size stays 0 and the
+	 * controller cannot back occupancy monitoring.
+	 */
+	cpus_read_lock();
+	if (!ctrl->cache.cache_size) {
+		int cpu = cpumask_first_and(&ctrl->cache.cpu_mask, cpu_online_mask);
+
+		if (cpu < nr_cpu_ids) {
+			struct cacheinfo *ci;
+
+			ci = get_cpu_cacheinfo_level(cpu, ctrl->cache.cache_level);
+			if (ci)
+				ctrl->cache.cache_size = ci->size;
+		}
+	}
+	cpus_read_unlock();
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
+	pr_debug("controller info: type=%d addr=%pa size=%pa max-rcid=%u max-mcid=%u\n",
+		 ctrl->type, &ctrl->addr, &ctrl->size,
+		 ctrl->rcid_count, ctrl->mcid_count);
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
+	kfree(ctrl);
+}
+
+/*
+ * Roll back the most recent n successful riscv_cbqri_register_controller()
+ * calls. Discovery layers use this to undo partial registrations when a
+ * subsequent table entry turns out to be malformed and the whole parse must
+ * abort.
+ *
+ * Caller serialization: this is intended for boot-time discovery (ACPI
+ * acpi_arch_init, future DT) which run single-threaded before late_initcall.
+ * No lock is taken.
+ */
+void riscv_cbqri_unregister_last(unsigned int n)
+{
+	while (n--) {
+		struct cbqri_controller *ctrl;
+
+		if (list_empty(&cbqri_controllers))
+			return;
+		ctrl = list_last_entry(&cbqri_controllers,
+				       struct cbqri_controller, list);
+		list_del(&ctrl->list);
+		cbqri_controller_destroy(ctrl);
+	}
+}
+
+/*
+ * Allocate, populate, and add to cbqri_controllers a fresh controller
+ * descriptor based on info supplied by a discovery layer (ACPI RQSC,
+ * future DT). Resolves the cpumask via PPTT (capacity) so callers do
+ * not need to know about cacheinfo topology.
+ */
+int riscv_cbqri_register_controller(const struct cbqri_controller_info *info)
+{
+	struct cbqri_controller *ctrl;
+	int err;
+
+	if (!info->addr) {
+		pr_warn("skipping controller with invalid addr=0x0\n");
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
+	ctrl->mcid_count = info->mcid_count;
+
+	switch (info->type) {
+	case CBQRI_CONTROLLER_TYPE_CAPACITY: {
+		int level;
+
+		ctrl->cache.cache_id = info->cache_id;
+
+		level = find_acpi_cache_level_from_id(info->cache_id);
+		if (level < 0) {
+			pr_warn("Failed to resolve cache level for cache id 0x%x (%d), skipping\n",
+				info->cache_id, level);
+			cbqri_controller_destroy(ctrl);
+			return level;
+		}
+		ctrl->cache.cache_level = level;
+
+		/*
+		 * cache_size stays at 0 here. cacheinfo is not populated
+		 * yet at acpi_arch_init time. Filled lazily during probe
+		 * via get_cpu_cacheinfo_level().
+		 */
+
+		err = acpi_pptt_get_cpumask_from_cache_id(info->cache_id,
+							  &ctrl->cache.cpu_mask);
+		if (err) {
+			pr_warn("Failed to get cpumask for cache id 0x%x (%d), skipping\n",
+				info->cache_id, err);
+			cbqri_controller_destroy(ctrl);
+			return err;
+		}
+		break;
+	}
+	default:
+		pr_warn("controller at %pa: unknown type %u, skipping\n",
+			&ctrl->addr, info->type);
+		cbqri_controller_destroy(ctrl);
+		return -EINVAL;
+	}
+
+	err = cbqri_probe_controller(ctrl);
+	if (err) {
+		cbqri_controller_destroy(ctrl);
+		return err;
+	}
+
+	list_add_tail(&ctrl->list, &cbqri_controllers);
+	return 0;
+}
diff --git a/drivers/resctrl/cbqri_internal.h b/drivers/resctrl/cbqri_internal.h
new file mode 100644
index 000000000000..6a581a7e417b
--- /dev/null
+++ b/drivers/resctrl/cbqri_internal.h
@@ -0,0 +1,125 @@
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
+ * Smallest MMIO span the driver actually accesses: highest defined
+ * register offset (0x20) plus the 8-byte register width. Used by
+ * cbqri_probe_controller() to reject undersized firmware-supplied
+ * mappings before request_mem_region/ioremap, so a u64 access at
+ * BLOCK_MASK does not walk past the end of the mapping.
+ */
+#define CBQRI_CTRL_MIN_REG_SPAN  0x28u
+
+#define CBQRI_CC_CAPABILITIES_VER_MINOR_MASK  GENMASK(3, 0)
+#define CBQRI_CC_CAPABILITIES_VER_MAJOR_MASK  GENMASK(7, 4)
+#define CBQRI_CC_CAPABILITIES_NCBLKS_MASK     GENMASK(23, 8)
+
+#define CBQRI_CONTROL_REGISTERS_OP_MASK      GENMASK(4, 0)
+#define CBQRI_CONTROL_REGISTERS_AT_MASK      GENMASK(7, 5)
+#define CBQRI_CONTROL_REGISTERS_AT_DATA      0
+#define CBQRI_CONTROL_REGISTERS_AT_CODE      1
+#define CBQRI_CONTROL_REGISTERS_RCID_MASK    GENMASK(19, 8)
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
+};
+
+/**
+ * enum cbqri_at - capacity controller access type for CDP
+ * @CBQRI_AT_DATA: data access (CBQRI Table 1, AT=0)
+ * @CBQRI_AT_CODE: code access (CBQRI Table 1, AT=1)
+ *
+ * Selects between data and code halves on controllers that advertise
+ * supports_alloc_at_code. The resctrl glue maps from CDP_DATA / CDP_CODE
+ * to this enum at the boundary so cbqri_devices.c stays free of fs/resctrl
+ * types.
+ */
+enum cbqri_at {
+	CBQRI_AT_DATA = CBQRI_CONTROL_REGISTERS_AT_DATA,
+	CBQRI_AT_CODE = CBQRI_CONTROL_REGISTERS_AT_CODE,
+};
+
+/**
+ * struct cbqri_cc_config - desired capacity allocation state for one rcid
+ * @cbm:         capacity block mask
+ * @at:          AT half (data or code) the @cbm applies to
+ * @cdp_enabled: when false and the controller supports AT, mirror @cbm
+ *               into the other AT half so both stay in sync
+ */
+struct cbqri_cc_config {
+	u64           cbm;
+	enum cbqri_at at;
+	bool          cdp_enabled;
+};
+
+struct cbqri_controller {
+	void __iomem *base;
+	/*
+	 * Serializes the write-then-poll-busy MMIO sequences on this
+	 * controller. Each CBQRI op may busy-wait up to 1 ms on slow
+	 * firmware, so use a sleeping mutex (paired with the sleeping
+	 * readq_poll_timeout() in cbqri_wait_busy_flag()) to keep
+	 * preemption enabled, which is required for PREEMPT_RT.
+	 * All resctrl-arch entry points run in process context.
+	 */
+	struct mutex lock;
+	/* Sticky -EIO once cbqri_wait_busy_flag() has timed out. */
+	bool faulted;
+
+	int ver_major;
+	int ver_minor;
+
+	struct riscv_cbqri_capacity_caps cc;
+
+	bool alloc_capable;
+	bool mon_capable;
+
+	phys_addr_t addr;
+	phys_addr_t size;
+	enum cbqri_controller_type type;
+	u32 rcid_count;
+	u32 mcid_count;
+
+	struct list_head list;
+
+	struct cache_controller {
+		u32 cache_level;
+		u32 cache_size; /* in bytes */
+		struct cpumask cpu_mask;
+		/* Unique Cache ID from the PPTT table's Cache Type Structure */
+		u32 cache_id;
+	} cache;
+};
+
+extern struct list_head cbqri_controllers;
+
+void cbqri_controller_destroy(struct cbqri_controller *ctrl);
+
+int cbqri_apply_cache_config(struct cbqri_controller *ctrl, u32 closid,
+			     const struct cbqri_cc_config *cfg);
+
+int cbqri_read_cache_config(struct cbqri_controller *ctrl, u32 closid,
+			    enum cbqri_at at, u32 *cbm_out);
+
+#endif /* _DRIVERS_RESCTRL_CBQRI_INTERNAL_H */
diff --git a/include/linux/riscv_cbqri.h b/include/linux/riscv_cbqri.h
new file mode 100644
index 000000000000..18e138938095
--- /dev/null
+++ b/include/linux/riscv_cbqri.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Public registration API for the RISC-V Capacity and Bandwidth QoS
+ * Register Interface (CBQRI) driver. Discovery layers (ACPI RQSC, future
+ * device tree) call riscv_cbqri_register_controller() to hand a controller
+ * descriptor to the driver, which owns all subsequent state.
+ */
+#ifndef _LINUX_RISCV_CBQRI_H
+#define _LINUX_RISCV_CBQRI_H
+
+#include <linux/types.h>
+
+enum cbqri_controller_type {
+	CBQRI_CONTROLLER_TYPE_CAPACITY,
+	CBQRI_CONTROLLER_TYPE_BANDWIDTH,
+};
+
+/*
+ * Sanity caps on per-controller RCID/MCID counts from firmware (RQSC, DT).
+ * Per-id MMIO init loops busy-wait up to ~1-2 ms each, so a malformed table
+ * claiming the full u16 range (65535) would block boot long enough to trip
+ * the soft-lockup watchdog. Real CBQRI hardware advertises tens to a few
+ * hundred ids.
+ */
+#define CBQRI_MAX_RCID	1024
+#define CBQRI_MAX_MCID	1024
+
+/**
+ * struct cbqri_controller_info - registration descriptor
+ * @addr:        MMIO base address of the controller's register interface
+ * @size:        size of the MMIO region
+ * @type:        capacity or bandwidth controller
+ * @rcid_count:  number of supported RCIDs (per RQSC table)
+ * @mcid_count:  number of supported MCIDs (per RQSC table)
+ * @cache_id:    PPTT cache id. Only meaningful for CAPACITY controllers
+ * @prox_dom:    SRAT proximity domain. Only meaningful for BANDWIDTH
+ *               controllers
+ *
+ * Discovery layers populate one of @cache_id / @prox_dom according to
+ * @type. The CBQRI driver resolves the matching cpumask internally so
+ * callers do not need to know about cacheinfo/NUMA topology.
+ */
+struct cbqri_controller_info {
+	phys_addr_t			addr;
+	phys_addr_t			size;
+	enum cbqri_controller_type	type;
+	u32				rcid_count;
+	u32				mcid_count;
+	u32				cache_id;
+	u32				prox_dom;
+};
+
+#if IS_ENABLED(CONFIG_RISCV_CBQRI_DRIVER)
+int riscv_cbqri_register_controller(const struct cbqri_controller_info *info);
+void riscv_cbqri_unregister_last(unsigned int n);
+#else
+static inline int
+riscv_cbqri_register_controller(const struct cbqri_controller_info *info)
+{
+	return -ENODEV;
+}
+
+static inline void riscv_cbqri_unregister_last(unsigned int n) { }
+#endif
+
+#endif /* _LINUX_RISCV_CBQRI_H */

-- 
2.43.0

