Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D0336897;
	Fri, 19 Jun 2026 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893795; cv=none; b=O4rhQhwVjqyHTOUPwOHzVNVIFg6xeOrqK2Jl/phUn1hNQ5B48Ue3gqPlgJlFdar8cwx6XkkcKSKaphldPT85cUM9q6jJjNb5IlaeV0sQRFO8Y6DBLw30BrhjYnk5LMnjIJQsyeAyb5i1MwltBP5hOdDoMmNwhUGxzLd9Wa0SU2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893795; c=relaxed/simple;
	bh=o7wMFgyCIO6B1dAO8hx26txrqwFK0HIXUGLNP2JAr88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLpizR9KTdIG8PT69bqiuVtCqeg+OGIOclhwBp/Zk4zNrfYkDlyRjIy79pQe5MlP2bjRyVmB62r+Fa/iLb0GkUM/aaglcW5IDuwwTbCAFZVc1zyXv0nOLpvTeaOSWyYzVXYK3l6XrwD4at0NCfxEzUeou1oOh/0OEViUeTbCZAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbFOBgnS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbFOBgnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D7B1F00ADB;
	Fri, 19 Jun 2026 18:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781893790;
	bh=qgG0biySzKJweGphEDHlWbrF9FFxyxkTw9/StWtKY2I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=nbFOBgnSxyEkVD2YfpG9nzLUrVoI1wbUXBsLm+x//3is9A/cvn37oepKtea62Pc2U
	 /JVF6YtUaBxIyA0JV6sSS4j8U6JzZ9c11gdYb4J+DKwbVEWN8Qgh5KeZJmWNVj20YO
	 A2TrF9ZxdwgaADM0znsQ6OoubT0xJeM9u915jUIocVrbndTaqbnYdb8sZCgcpF+LLh
	 miHydzXcldeYugOedHwRM8t4JpGj66NpuqneKGa9El+9thagFWyA0uvccx/YXvbkJA
	 4CuCin996ufNKPV8rveiWTaTs1mEZkiiwLNNdrUt7t277dcpbrUe4XvyuIa6rB/mF+
	 I9JUltWFb5Ezg==
From: Drew Fustini <fustini@kernel.org>
Date: Fri, 19 Jun 2026 11:29:40 -0700
Subject: [PATCH 5/8] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dfustini-atl-sc-cbqri-dt-v1-5-e79a7723fab0@kernel.org>
References: <20260619-dfustini-atl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org>
In-Reply-To: <20260619-dfustini-atl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org>
To: Adrien Ricciardi <aricciardi@baylibre.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Atish Kumar Patra <atishp@rivosinc.com>, 
 Atish Patra <atish.patra@linux.dev>, Babu Moger <babu.moger@amd.com>, 
 Ben Horgan <ben.horgan@arm.com>, Borislav Petkov <bp@alien8.de>, 
 Chen Pei <cp0613@linux.alibaba.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Dave Martin <Dave.Martin@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=29082; i=fustini@kernel.org;
 h=from:subject:message-id; bh=o7wMFgyCIO6B1dAO8hx26txrqwFK0HIXUGLNP2JAr88=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWSZds2qmc+yJqUguGXp3NrdkRpbRW6vnv611ehRYkps/
 A6OytePOkpZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQATWbKM4Z/piSAn5W1By6c8
 cCk/td2KT2eHQb1JWsBRX/tjBS0fpyQzMtz8sim08ufsBeyL889fNvyStq1RpW+pg8UjN4mVM3b
 cT+ABAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Wire CBQRI capacity controllers into resctrl as RDT_RESOURCE_L2 and
RDT_RESOURCE_L3 schemata.

Mismatched CC caps at the same cache level are treated as a fatal
configuration error since fs/resctrl exposes a single per-rid cap
set. Domains are created lazily in the cpuhp online callback so
cpu_mask reflects only currently online CPUs.

Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                      |   2 +
 arch/riscv/Kconfig               |   1 +
 arch/riscv/include/asm/resctrl.h | 152 ++++++++
 drivers/resctrl/Kconfig          |   4 +
 drivers/resctrl/Makefile         |   1 +
 drivers/resctrl/cbqri_resctrl.c  | 774 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 934 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c090d52e9fa0..85d50efb6e5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23297,9 +23297,11 @@ R:	yunhui cui <cuiyunhui@bytedance.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/include/asm/qos.h
+F:	arch/riscv/include/asm/resctrl.h
 F:	arch/riscv/kernel/qos.c
 F:	drivers/resctrl/cbqri_devices.c
 F:	drivers/resctrl/cbqri_internal.h
+F:	drivers/resctrl/cbqri_resctrl.c
 F:	include/linux/riscv_cbqri.h
 
 RISC-V RPMI AND MPXY DRIVERS
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ee586925f972..9eb65d0eaa07 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -594,6 +594,7 @@ config RISCV_ISA_SSQOSID
 	bool "Ssqosid extension support for supervisor mode Quality of Service ID"
 	depends on 64BIT
 	default n
+	select ARCH_HAS_CPU_RESCTRL
 	help
 	  Adds support for the Ssqosid ISA extension (Supervisor-mode
 	  Quality of Service ID).
diff --git a/arch/riscv/include/asm/resctrl.h b/arch/riscv/include/asm/resctrl.h
new file mode 100644
index 000000000000..7392a099b6f8
--- /dev/null
+++ b/arch/riscv/include/asm/resctrl.h
@@ -0,0 +1,152 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_RESCTRL_H
+#define _ASM_RISCV_RESCTRL_H
+
+#include <linux/resctrl_types.h>
+#include <linux/sched.h>
+#include <linux/types.h>
+
+#include <asm/qos.h>
+
+struct rdt_resource;
+
+/*
+ * Sentinel "no CLOSID assigned" used by resctrl_arch_rmid_idx_decode().
+ * fs/resctrl treats this opaquely. CBQRI uses MCID directly as the linear
+ * rmid index, so closid is unused on decode.
+ */
+#define RISCV_RESCTRL_EMPTY_CLOSID	((u32)~0)
+
+/*
+ * Terminology mapping between x86 (Intel RDT/AMD QoS) and RISC-V:
+ *
+ *  CLOSID on x86 is RCID on RISC-V
+ *    RMID on x86 is MCID on RISC-V
+ *     CDP on x86 is AT (access type) on RISC-V
+ *
+ * Each fast-path arch entry point below is the RISC-V realization of the
+ * generic contract documented in <linux/resctrl.h>. Comments here describe
+ * only the RISC-V-specific behavior (srmcfg encoding, CBQRI controller
+ * lookup, MCID-as-index policy).
+ */
+
+/**
+ * resctrl_arch_alloc_capable() - any CBQRI controller exposes resctrl alloc
+ *
+ * Returns true once at least one CBQRI controller has successfully probed for
+ * a resctrl-exposed cache capacity allocation feature. Only meaningful after
+ * cbqri_resctrl_setup() runs at late_initcall.
+ */
+bool resctrl_arch_alloc_capable(void);
+
+/**
+ * resctrl_arch_mon_capable() - any CBQRI controller exposes resctrl monitoring
+ *
+ * The CBQRI driver implements capacity allocation only and wires up no
+ * monitoring events, so this always returns false. fs/resctrl references it
+ * unconditionally, hence the stub.
+ */
+bool resctrl_arch_mon_capable(void);
+
+/**
+ * resctrl_arch_rmid_idx_encode() - encode (RCID, MCID) into a linear index
+ * @closid: RCID (resource control id)
+ * @rmid:   MCID (monitoring counter id)
+ *
+ * RISC-V uses MCID directly as the linear index into per-RMID arrays
+ * managed by fs/resctrl, since CBQRI controllers admit any MCID for any
+ * RCID. closid is unused here. CDP is encoded via the AT field on each
+ * CBQRI op rather than via the index.
+ */
+u32  resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid);
+
+/**
+ * resctrl_arch_rmid_idx_decode() - inverse of resctrl_arch_rmid_idx_encode()
+ * @idx:    linear index
+ * @closid: out: always RISCV_RESCTRL_EMPTY_CLOSID
+ * @rmid:   out: the MCID that @idx encodes
+ */
+void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid);
+
+/**
+ * resctrl_arch_set_cpu_default_closid_rmid() - install per-CPU srmcfg default
+ * @cpu:    CPU number
+ * @closid: RCID to use when no task is matched
+ * @rmid:   MCID to use when no task is matched
+ *
+ * Sets the per-CPU cpu_srmcfg_default so __switch_to_srmcfg() can fall back
+ * to the CPU's default RCID/MCID for default-group tasks (those whose
+ * thread.srmcfg encodes to 0, i.e. closid == RESCTRL_RESERVED_CLOSID and
+ * rmid == RESCTRL_RESERVED_RMID). Implements resctrl allocation rule 2
+ * ("CPU default") on RISC-V.
+ */
+void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 rmid);
+
+/**
+ * resctrl_arch_sched_in() - context-switch hook to install task RCID/MCID
+ * @tsk: the task being scheduled in
+ *
+ * Called from finish_task_switch() to write tsk->thread.srmcfg into the
+ * srmcfg CSR. Tasks tagged with RISCV_RESCTRL_EMPTY_CLOSID inherit the
+ * per-CPU default set via resctrl_arch_set_cpu_default_closid_rmid().
+ */
+void resctrl_arch_sched_in(struct task_struct *tsk);
+
+/**
+ * resctrl_arch_set_closid_rmid() - tag a task with an RCID/MCID
+ * @tsk:    task to tag
+ * @closid: RCID to install
+ * @rmid:   MCID to install
+ *
+ * Updates tsk->thread.srmcfg with the encoded (RCID, MCID) pair. The new
+ * value takes effect on the next resctrl_arch_sched_in() for this task.
+ */
+void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid);
+
+/**
+ * resctrl_arch_match_closid() - test whether a task carries a given RCID
+ * @tsk:    task
+ * @closid: RCID
+ */
+bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid);
+
+/**
+ * resctrl_arch_match_rmid() - test whether a task carries a given (RCID, MCID)
+ * @tsk:    task
+ * @closid: RCID
+ * @rmid:   MCID
+ */
+bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rmid);
+
+/**
+ * resctrl_arch_mon_ctx_alloc() - allocate per-monitor-event arch context
+ * @r:     resctrl resource being monitored
+ * @evtid: which monitor event needs context
+ *
+ * The CBQRI driver implements no monitoring events, so there is no per-event
+ * context to allocate and the stub returns NULL. fs/resctrl references it
+ * unconditionally before checking resctrl_arch_mon_capable().
+ */
+void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r, enum resctrl_event_id evtid);
+
+/**
+ * resctrl_arch_mon_ctx_free() - release context returned by mon_ctx_alloc()
+ * @r:            resctrl resource
+ * @evtid:        monitor event id
+ * @arch_mon_ctx: pointer returned by resctrl_arch_mon_ctx_alloc()
+ */
+void resctrl_arch_mon_ctx_free(struct rdt_resource *r, enum resctrl_event_id evtid,
+			       void *arch_mon_ctx);
+
+static inline unsigned int resctrl_arch_round_mon_val(unsigned int val)
+{
+	return val;
+}
+
+/* Not needed for RISC-V */
+static inline void resctrl_arch_enable_mon(void) { }
+static inline void resctrl_arch_disable_mon(void) { }
+static inline void resctrl_arch_enable_alloc(void) { }
+static inline void resctrl_arch_disable_alloc(void) { }
+
+#endif /* _ASM_RISCV_RESCTRL_H */
diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
index 8b16f69df17c..0887b6a9fac1 100644
--- a/drivers/resctrl/Kconfig
+++ b/drivers/resctrl/Kconfig
@@ -54,3 +54,7 @@ config RISCV_CBQRI_DRIVER_DEBUG
 	  new platform; otherwise leave disabled to avoid log noise.
 
 endif
+
+config RISCV_CBQRI_RESCTRL_FS
+	bool
+	default y if RISCV_CBQRI_DRIVER && RESCTRL_FS
diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
index 28085036d895..ed737b4461b9 100644
--- a/drivers/resctrl/Makefile
+++ b/drivers/resctrl/Makefile
@@ -6,5 +6,6 @@ ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
 
 obj-$(CONFIG_RISCV_CBQRI_DRIVER)		+= cbqri.o
 cbqri-y						+= cbqri_devices.o
+cbqri-$(CONFIG_RISCV_CBQRI_RESCTRL_FS)		+= cbqri_resctrl.o
 
 ccflags-$(CONFIG_RISCV_CBQRI_DRIVER_DEBUG)	+= -DDEBUG
diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resctrl.c
new file mode 100644
index 000000000000..d354129cc34f
--- /dev/null
+++ b/drivers/resctrl/cbqri_resctrl.c
@@ -0,0 +1,774 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) "%s:%s: " fmt, KBUILD_MODNAME, __func__
+
+#include <linux/bitfield.h>
+#include <linux/cacheinfo.h>
+#include <linux/riscv_cbqri.h>
+#include <linux/cpu.h>
+#include <linux/cpufeature.h>
+#include <linux/cpuhotplug.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/resctrl.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <asm/csr.h>
+#include <asm/qos.h>
+
+#include "cbqri_internal.h"
+
+struct cbqri_resctrl_res {
+	struct cbqri_controller *ctrl;
+	struct rdt_resource     resctrl_res;
+	bool                    cdp_enabled;
+};
+
+struct cbqri_resctrl_dom {
+	struct rdt_ctrl_domain  resctrl_ctrl_dom;
+	struct cbqri_controller *hw_ctrl;
+};
+
+static struct cbqri_resctrl_res cbqri_resctrl_resources[RDT_NUM_RESOURCES];
+
+static bool exposed_alloc_capable;
+
+/* Protects ctrl_domain list mutations across CPU hotplug. */
+static DEFINE_MUTEX(cbqri_domain_list_lock);
+
+static struct rdt_ctrl_domain *
+cbqri_find_ctrl_domain(struct list_head *h, int id)
+{
+	struct rdt_domain_hdr *hdr = resctrl_find_domain(h, id, NULL);
+
+	return hdr ? container_of(hdr, struct rdt_ctrl_domain, hdr) : NULL;
+}
+
+/* Map a hardware cache level to its resctrl resource id, or -ENODEV. */
+static int cbqri_cache_level_to_rid(u32 cache_level)
+{
+	switch (cache_level) {
+	case 2:
+		return RDT_RESOURCE_L2;
+	case 3:
+		return RDT_RESOURCE_L3;
+	default:
+		return -ENODEV;
+	}
+}
+
+static int cbqri_apply_cache_config_dom(struct cbqri_resctrl_dom *hw_dom,
+					struct rdt_resource *r,
+					u32 closid, enum resctrl_conf_type t,
+					u64 cbm)
+{
+	struct cbqri_resctrl_res *hw_res =
+		container_of(r, struct cbqri_resctrl_res, resctrl_res);
+	struct cbqri_cc_config cfg = {
+		.cbm = cbm,
+		.at = (t == CDP_CODE) ? CBQRI_CONTROL_REGISTERS_AT_CODE :
+					CBQRI_CONTROL_REGISTERS_AT_DATA,
+		.cdp_enabled = hw_res->cdp_enabled,
+	};
+
+	return cbqri_apply_cache_config(hw_dom->hw_ctrl, closid, &cfg);
+}
+
+bool resctrl_arch_alloc_capable(void)
+{
+	return exposed_alloc_capable;
+}
+
+bool resctrl_arch_mon_capable(void)
+{
+	return false;
+}
+
+bool resctrl_arch_get_cdp_enabled(enum resctrl_res_level rid)
+{
+	if (rid != RDT_RESOURCE_L2 && rid != RDT_RESOURCE_L3)
+		return false;
+	return cbqri_resctrl_resources[rid].cdp_enabled;
+}
+
+int resctrl_arch_set_cdp_enabled(enum resctrl_res_level rid, bool enable)
+{
+	struct cbqri_resctrl_res *cbqri_res;
+
+	if (rid != RDT_RESOURCE_L2 && rid != RDT_RESOURCE_L3)
+		return -ENODEV;
+
+	cbqri_res = &cbqri_resctrl_resources[rid];
+	if (!cbqri_res->resctrl_res.cdp_capable)
+		return -ENODEV;
+
+	cbqri_res->cdp_enabled = enable;
+	return 0;
+}
+
+struct rdt_resource *resctrl_arch_get_resource(enum resctrl_res_level l)
+{
+	if (l >= RDT_NUM_RESOURCES)
+		return NULL;
+
+	return &cbqri_resctrl_resources[l].resctrl_res;
+}
+
+/*
+ * fs/resctrl unconditionally references the symbols below before checking
+ * mon_capable. They are stubs for features CBQRI does not yet support.
+ */
+bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt)
+{
+	return false;
+}
+
+void *resctrl_arch_mon_ctx_alloc(struct rdt_resource *r,
+				 enum resctrl_event_id evtid)
+{
+	return NULL;
+}
+
+void resctrl_arch_mon_ctx_free(struct rdt_resource *r,
+			       enum resctrl_event_id evtid, void *arch_mon_ctx)
+{
+}
+
+void resctrl_arch_config_cntr(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
+			      enum resctrl_event_id evtid, u32 rmid, u32 closid,
+			      u32 cntr_id, bool assign)
+{
+}
+
+int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
+			   u32 unused, u32 rmid, int cntr_id,
+			   enum resctrl_event_id eventid, u64 *val)
+{
+	return -EOPNOTSUPP;
+}
+
+bool resctrl_arch_mbm_cntr_assign_enabled(struct rdt_resource *r)
+{
+	return false;
+}
+
+int resctrl_arch_mbm_cntr_assign_set(struct rdt_resource *r, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
+void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
+			     u32 unused, u32 rmid, int cntr_id,
+			     enum resctrl_event_id eventid)
+{
+}
+
+bool resctrl_arch_get_io_alloc_enabled(struct rdt_resource *r)
+{
+	return false;
+}
+
+int resctrl_arch_io_alloc_enable(struct rdt_resource *r, bool enable)
+{
+	return -EOPNOTSUPP;
+}
+
+void resctrl_arch_mon_event_config_read(void *info)
+{
+}
+
+void resctrl_arch_mon_event_config_write(void *info)
+{
+}
+
+void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_l3_mon_domain *d)
+{
+}
+
+void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_l3_mon_domain *d,
+			     u32 unused, u32 rmid, enum resctrl_event_id eventid)
+{
+}
+
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_domain_hdr *hdr,
+			   u32 closid, u32 rmid, enum resctrl_event_id eventid,
+			   void *arch_priv, u64 *val, void *arch_mon_ctx)
+{
+	return -ENODATA;
+}
+
+/*
+ * Note about terminology between x86 (Intel RDT/AMD QoS) and RISC-V:
+ *   CLOSID on x86 is RCID on RISC-V
+ *     RMID on x86 is MCID on RISC-V
+ */
+u32 resctrl_arch_get_num_closid(struct rdt_resource *res)
+{
+	struct cbqri_resctrl_res *hw_res;
+
+	hw_res = container_of(res, struct cbqri_resctrl_res, resctrl_res);
+
+	if (!hw_res->ctrl)
+		return 0;
+
+	return hw_res->ctrl->rcid_count;
+}
+
+u32 resctrl_arch_system_num_rmid_idx(void)
+{
+	return 1;
+}
+
+u32 resctrl_arch_rmid_idx_encode(u32 closid, u32 rmid)
+{
+	return rmid;
+}
+
+void resctrl_arch_rmid_idx_decode(u32 idx, u32 *closid, u32 *rmid)
+{
+	*closid = RISCV_RESCTRL_EMPTY_CLOSID;
+	*rmid = idx;
+}
+
+void resctrl_arch_set_cpu_default_closid_rmid(int cpu, u32 closid, u32 rmid)
+{
+	u32 srmcfg = FIELD_PREP(SRMCFG_RCID_MASK, closid) |
+		     FIELD_PREP(SRMCFG_MCID_MASK, rmid);
+
+	WRITE_ONCE(per_cpu(cpu_srmcfg_default, cpu), srmcfg);
+}
+
+void resctrl_arch_sched_in(struct task_struct *tsk)
+{
+	__switch_to_srmcfg(tsk);
+}
+
+void resctrl_arch_set_closid_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
+{
+	u32 srmcfg = FIELD_PREP(SRMCFG_RCID_MASK, closid) |
+		     FIELD_PREP(SRMCFG_MCID_MASK, rmid);
+
+	WRITE_ONCE(tsk->thread.srmcfg, srmcfg);
+}
+
+void resctrl_arch_sync_cpu_closid_rmid(void *info)
+{
+	struct resctrl_cpu_defaults *r = info;
+
+	lockdep_assert_preemption_disabled();
+
+	if (r) {
+		resctrl_arch_set_cpu_default_closid_rmid(smp_processor_id(),
+							 r->closid, r->rmid);
+	}
+
+	resctrl_arch_sched_in(current);
+}
+
+bool resctrl_arch_match_closid(struct task_struct *tsk, u32 closid)
+{
+	return FIELD_GET(SRMCFG_RCID_MASK, READ_ONCE(tsk->thread.srmcfg)) == closid;
+}
+
+bool resctrl_arch_match_rmid(struct task_struct *tsk, u32 closid, u32 rmid)
+{
+	return FIELD_GET(SRMCFG_MCID_MASK, READ_ONCE(tsk->thread.srmcfg)) == rmid;
+}
+
+void resctrl_arch_pre_mount(void)
+{
+	/* All controllers discovered at boot via late_initcall. Nothing to do. */
+}
+
+int resctrl_arch_update_one(struct rdt_resource *r, struct rdt_ctrl_domain *d,
+			    u32 closid, enum resctrl_conf_type t, u32 cfg_val)
+{
+	struct cbqri_resctrl_dom *dom;
+
+	dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
+
+	if (!r->alloc_capable)
+		return -EINVAL;
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L2:
+	case RDT_RESOURCE_L3:
+		return cbqri_apply_cache_config_dom(dom, r, closid, t, cfg_val);
+	default:
+		return -EINVAL;
+	}
+}
+
+int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid)
+{
+	struct resctrl_staged_config *cfg;
+	enum resctrl_conf_type t;
+	struct rdt_ctrl_domain *d;
+	int err = 0;
+
+	/* Walking r->ctrl_domains, ensure it can't race with cpuhp */
+	lockdep_assert_cpus_held();
+
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		for (t = 0; t < CDP_NUM_TYPES; t++) {
+			cfg = &d->staged_config[t];
+			if (!cfg->have_new_ctrl)
+				continue;
+			err = resctrl_arch_update_one(r, d, closid, t, cfg->new_ctrl);
+			if (err)
+				return err;
+		}
+	}
+	return err;
+}
+
+u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_ctrl_domain *d,
+			    u32 closid, enum resctrl_conf_type type)
+{
+	struct cbqri_resctrl_dom *hw_dom;
+	struct cbqri_controller *ctrl;
+	u32 at;
+	u32 val;
+	int err;
+
+	hw_dom = container_of(d, struct cbqri_resctrl_dom, resctrl_ctrl_dom);
+	ctrl = hw_dom->hw_ctrl;
+	val = resctrl_get_default_ctrl(r);
+
+	if (!r->alloc_capable)
+		return val;
+
+	switch (r->rid) {
+	case RDT_RESOURCE_L2:
+	case RDT_RESOURCE_L3:
+		at = (type == CDP_CODE) ? CBQRI_CONTROL_REGISTERS_AT_CODE :
+					  CBQRI_CONTROL_REGISTERS_AT_DATA;
+		err = cbqri_read_cache_config(ctrl, closid, at, &val);
+		if (err < 0)
+			val = resctrl_get_default_ctrl(r);
+		break;
+	default:
+		break;
+	}
+
+	return val;
+}
+
+void resctrl_arch_reset_all_ctrls(struct rdt_resource *r)
+{
+	struct cbqri_resctrl_res *hw_res;
+	struct rdt_ctrl_domain *d;
+	enum resctrl_conf_type t;
+	u32 default_ctrl;
+	int i;
+
+	lockdep_assert_cpus_held();
+
+	hw_res = container_of(r, struct cbqri_resctrl_res, resctrl_res);
+	default_ctrl = resctrl_get_default_ctrl(r);
+
+	if (!hw_res->ctrl)
+		return;
+
+	list_for_each_entry(d, &r->ctrl_domains, hdr.list) {
+		for (i = 0; i < hw_res->ctrl->rcid_count; i++) {
+			for (t = 0; t < CDP_NUM_TYPES; t++) {
+				int rerr;
+
+				rerr = resctrl_arch_update_one(r, d, i, t, default_ctrl);
+				if (rerr)
+					pr_err_ratelimited("rid=%d reset RCID %u type %u failed (%d)\n",
+							   r->rid, i, t, rerr);
+			}
+		}
+	}
+}
+
+static struct rdt_ctrl_domain *cbqri_new_domain(struct cbqri_controller *ctrl)
+{
+	struct cbqri_resctrl_dom *hw_dom;
+	struct rdt_ctrl_domain *domain;
+
+	hw_dom = kzalloc_obj(*hw_dom, GFP_KERNEL);
+	if (!hw_dom)
+		return NULL;
+
+	hw_dom->hw_ctrl = ctrl;
+	domain = &hw_dom->resctrl_ctrl_dom;
+
+	INIT_LIST_HEAD(&domain->hdr.list);
+
+	return domain;
+}
+
+static int cbqri_init_domain_ctrlval(struct rdt_resource *r, struct rdt_ctrl_domain *d)
+{
+	struct cbqri_resctrl_res *hw_res;
+	enum resctrl_conf_type t;
+	int err = 0;
+	int i;
+
+	hw_res = container_of(r, struct cbqri_resctrl_res, resctrl_res);
+
+	for (i = 0; i < hw_res->ctrl->rcid_count; i++) {
+		/*
+		 * Seed both DATA and CODE staged slots so a later mount
+		 * with -o cdp does not see stale CODE values.
+		 * On non-AT controllers cbqri_cc_alloc_op() masks AT to 0
+		 * so all three iterations land on the same hardware state.
+		 * The redundant writes are harmless.
+		 */
+		for (t = 0; t < CDP_NUM_TYPES; t++) {
+			err = resctrl_arch_update_one(r, d, i, t,
+						      resctrl_get_default_ctrl(r));
+			if (err)
+				return err;
+		}
+	}
+	return 0;
+}
+
+/*
+ * Walk cbqri_controllers and pick one capacity controller (CC) per cache
+ * level (L2/L3) to back the corresponding RDT_RESOURCE_L*. When more than
+ * one CC sits at the same level (e.g. one per socket), they must agree on
+ * rcid_count / ncblks / alloc_capable. A mismatch is fatal because resctrl
+ * exposes a single set of caps per rid. The first matching controller wins.
+ */
+static int cbqri_resctrl_pick_caches(void)
+{
+	struct cbqri_controller *ctrl;
+
+	list_for_each_entry(ctrl, &cbqri_controllers, list) {
+		struct cbqri_resctrl_res *cbqri_res;
+		int rid;
+
+		if (ctrl->type != CBQRI_CONTROLLER_TYPE_CAPACITY)
+			continue;
+		if (!ctrl->alloc_capable)
+			continue;
+
+		rid = cbqri_cache_level_to_rid(ctrl->cache.cache_level);
+		if (rid < 0) {
+			pr_err("unknown cache level %d\n",
+			       ctrl->cache.cache_level);
+			return rid;
+		}
+
+		cbqri_res = &cbqri_resctrl_resources[rid];
+		if (cbqri_res->ctrl) {
+			/*
+			 * CCs at the same cache level must agree on every cap
+			 * resctrl exposes globally. Reject mismatches at pick
+			 * time so the inconsistency is visible at boot.
+			 */
+			if (cbqri_res->ctrl->rcid_count != ctrl->rcid_count ||
+			    cbqri_res->ctrl->cc.ncblks != ctrl->cc.ncblks ||
+			    cbqri_res->ctrl->cc.supports_alloc_at_code !=
+				    ctrl->cc.supports_alloc_at_code ||
+			    cbqri_res->ctrl->alloc_capable != ctrl->alloc_capable) {
+				pr_err("L%d controllers have mismatched capabilities\n",
+				       ctrl->cache.cache_level);
+				return -EINVAL;
+			}
+			continue;
+		}
+
+		cbqri_res->ctrl = ctrl;
+	}
+
+	return 0;
+}
+
+/*
+ * Fill the rdt_resource fields for one picked rid. An rid with no picked
+ * controller is left untouched so it stays out of resctrl_arch_get_resource().
+ */
+static void cbqri_resctrl_control_init(struct cbqri_resctrl_res *cbqri_res)
+{
+	struct cbqri_controller *ctrl = cbqri_res->ctrl;
+	struct rdt_resource *res = &cbqri_res->resctrl_res;
+
+	if (!ctrl)
+		return;
+
+	switch (res->rid) {
+	case RDT_RESOURCE_L2:
+	case RDT_RESOURCE_L3:
+		res->name = (res->rid == RDT_RESOURCE_L2) ? "L2" : "L3";
+		res->schema_fmt = RESCTRL_SCHEMA_BITMAP;
+		res->ctrl_scope = (res->rid == RDT_RESOURCE_L2) ?
+				    RESCTRL_L2_CACHE : RESCTRL_L3_CACHE;
+		res->cache.cbm_len = ctrl->cc.ncblks;
+		res->cache.shareable_bits = 0;
+		res->cache.min_cbm_bits = 1;
+		res->cache.arch_has_sparse_bitmasks = false;
+		res->cdp_capable = ctrl->cc.supports_alloc_at_code;
+		res->alloc_capable = ctrl->alloc_capable;
+		INIT_LIST_HEAD(&res->ctrl_domains);
+		INIT_LIST_HEAD(&res->mon_domains);
+		break;
+	default:
+		break;
+	}
+}
+
+static void cbqri_resctrl_accumulate_caps(void)
+{
+	int rid;
+
+	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
+		struct cbqri_resctrl_res *hw_res = &cbqri_resctrl_resources[rid];
+
+		if (!hw_res->ctrl)
+			continue;
+		if (hw_res->ctrl->alloc_capable)
+			exposed_alloc_capable = true;
+	}
+}
+
+/*
+ * Create, list-insert, and online a fresh ctrl_domain backing ctrl on
+ * resource res, seeded with cpu and identified by dom_id. Caller must
+ * hold cbqri_domain_list_lock and must have already verified that no
+ * existing ctrl_domain on res carries this id.
+ */
+static struct rdt_ctrl_domain *cbqri_create_ctrl_domain(struct cbqri_controller *ctrl,
+							struct rdt_resource *res,
+							unsigned int cpu, int dom_id)
+{
+	struct rdt_ctrl_domain *domain;
+	struct list_head *pos = NULL;
+	int err;
+
+	domain = cbqri_new_domain(ctrl);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
+	domain->hdr.id = dom_id;
+	domain->hdr.type = RESCTRL_CTRL_DOMAIN;
+
+	err = cbqri_init_domain_ctrlval(res, domain);
+	if (err) {
+		kfree(container_of(domain, struct cbqri_resctrl_dom,
+				   resctrl_ctrl_dom));
+		return ERR_PTR(err);
+	}
+
+	/* Insert sorted by id so user-visible ordering is deterministic. */
+	resctrl_find_domain(&res->ctrl_domains, dom_id, &pos);
+	list_add_tail(&domain->hdr.list, pos);
+
+	resctrl_online_ctrl_domain(res, domain);
+
+	return domain;
+}
+
+static int cbqri_attach_cpu_to_cap_ctrl(struct cbqri_controller *ctrl,
+					unsigned int cpu)
+{
+	struct cbqri_resctrl_res *hw_res;
+	struct rdt_ctrl_domain *domain;
+	struct rdt_resource *res;
+	int dom_id;
+	int rid;
+
+	rid = cbqri_cache_level_to_rid(ctrl->cache.cache_level);
+	if (rid < 0)
+		return 0;
+	hw_res = &cbqri_resctrl_resources[rid];
+
+	if (!hw_res->ctrl)
+		return 0;
+
+	res = &hw_res->resctrl_res;
+	dom_id = ctrl->cache.cache_id;
+
+	domain = cbqri_find_ctrl_domain(&res->ctrl_domains, dom_id);
+	if (domain) {
+		cpumask_set_cpu(cpu, &domain->hdr.cpu_mask);
+		return 0;
+	}
+
+	domain = cbqri_create_ctrl_domain(ctrl, res, cpu, dom_id);
+	if (IS_ERR(domain))
+		return PTR_ERR(domain);
+
+	return 0;
+}
+
+static void cbqri_detach_cpu_from_ctrl_domains(struct rdt_resource *res,
+					       unsigned int cpu)
+{
+	struct rdt_ctrl_domain *domain, *tmp;
+
+	list_for_each_entry_safe(domain, tmp, &res->ctrl_domains, hdr.list) {
+		if (!cpumask_test_cpu(cpu, &domain->hdr.cpu_mask))
+			continue;
+		cpumask_clear_cpu(cpu, &domain->hdr.cpu_mask);
+		if (cpumask_empty(&domain->hdr.cpu_mask)) {
+			resctrl_offline_ctrl_domain(res, domain);
+			list_del(&domain->hdr.list);
+			kfree(container_of(domain, struct cbqri_resctrl_dom,
+					   resctrl_ctrl_dom));
+		}
+	}
+}
+
+/*
+ * Remove a CPU from every domain it was attached to. The per-resource
+ * detach helpers act only when the CPU is set in a domain's mask, so this
+ * is idempotent and undoes a partial online attach as well as a full
+ * offline. Caller holds cbqri_domain_list_lock.
+ */
+static void cbqri_detach_cpu_from_all_ctrls(unsigned int cpu)
+{
+	int rid;
+
+	lockdep_assert_held(&cbqri_domain_list_lock);
+
+	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
+		struct cbqri_resctrl_res *hw_res = &cbqri_resctrl_resources[rid];
+
+		if (!hw_res->ctrl)
+			continue;
+		cbqri_detach_cpu_from_ctrl_domains(&hw_res->resctrl_res, cpu);
+	}
+}
+
+/*
+ * Attach a CPU to every controller that claims it. On failure, detach the
+ * CPU from everything attached so far: the cpuhp core does not run this
+ * state's offline teardown when its startup fails, so a partial attach
+ * would otherwise leak into the domain cpu_masks. Caller holds
+ * cbqri_domain_list_lock.
+ */
+static int cbqri_attach_cpu_to_all_ctrls(unsigned int cpu)
+{
+	struct cbqri_controller *ctrl;
+	int err = 0;
+
+	lockdep_assert_held(&cbqri_domain_list_lock);
+
+	list_for_each_entry(ctrl, &cbqri_controllers, list) {
+		if (ctrl->type != CBQRI_CONTROLLER_TYPE_CAPACITY)
+			continue;
+		if (!cpumask_test_cpu(cpu, &ctrl->cache.cpu_mask))
+			continue;
+		if (!ctrl->alloc_capable)
+			continue;
+
+		err = cbqri_attach_cpu_to_cap_ctrl(ctrl, cpu);
+		if (err) {
+			cbqri_detach_cpu_from_all_ctrls(cpu);
+			break;
+		}
+	}
+
+	return err;
+}
+
+static bool cbqri_resctrl_inited;
+
+static void cbqri_resctrl_teardown(void)
+{
+	int rid;
+
+	if (!cbqri_resctrl_inited)
+		return;
+
+	resctrl_exit();
+
+	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++) {
+		struct cbqri_resctrl_res *hw_res = &cbqri_resctrl_resources[rid];
+
+		hw_res->ctrl = NULL;
+		hw_res->cdp_enabled = false;
+	}
+	exposed_alloc_capable = false;
+	cbqri_resctrl_inited = false;
+}
+
+static int cbqri_resctrl_setup(void)
+{
+	int rid;
+	int err;
+
+	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++)
+		cbqri_resctrl_resources[rid].resctrl_res.rid = rid;
+
+	err = cbqri_resctrl_pick_caches();
+	if (err)
+		return err;
+
+	for (rid = 0; rid < RDT_NUM_RESOURCES; rid++)
+		cbqri_resctrl_control_init(&cbqri_resctrl_resources[rid]);
+
+	cbqri_resctrl_accumulate_caps();
+
+	if (!exposed_alloc_capable) {
+		pr_debug("no resctrl-capable CBQRI controllers found\n");
+		return -ENODEV;
+	}
+
+	err = resctrl_init();
+	if (err)
+		return err;
+
+	cbqri_resctrl_inited = true;
+	return 0;
+}
+
+static int cbqri_resctrl_online_cpu(unsigned int cpu)
+{
+	int err;
+
+	mutex_lock(&cbqri_domain_list_lock);
+	err = cbqri_attach_cpu_to_all_ctrls(cpu);
+	mutex_unlock(&cbqri_domain_list_lock);
+	if (err)
+		return err;
+
+	/*
+	 * Seed the per-CPU default RCID/MCID to the reserved (0, 0) pair and
+	 * notify the resctrl core so it tracks this CPU in the default group.
+	 */
+	resctrl_arch_set_cpu_default_closid_rmid(cpu, 0, 0);
+	resctrl_online_cpu(cpu);
+	return 0;
+}
+
+static int cbqri_resctrl_offline_cpu(unsigned int cpu)
+{
+	resctrl_offline_cpu(cpu);
+
+	mutex_lock(&cbqri_domain_list_lock);
+	cbqri_detach_cpu_from_all_ctrls(cpu);
+	mutex_unlock(&cbqri_domain_list_lock);
+	return 0;
+}
+
+static int __init cbqri_arch_late_init(void)
+{
+	int err;
+
+	if (!riscv_isa_extension_available(NULL, SSQOSID))
+		return -ENODEV;
+
+	err = cbqri_resctrl_setup();
+	if (err)
+		return err;
+
+	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "cbqri:online",
+				cbqri_resctrl_online_cpu,
+				cbqri_resctrl_offline_cpu);
+	if (err < 0) {
+		cbqri_resctrl_teardown();
+		return err;
+	}
+
+	return 0;
+}
+late_initcall(cbqri_arch_late_init);

-- 
2.43.0

