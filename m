Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8811C3368BA;
	Fri, 19 Jun 2026 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893791; cv=none; b=ArqRMvXnTzQ1h3XjF/9d78RaN2d7tfWkn+NufQM66Sr+LgyiOJd0XRkhlpjAPPFCSxkRmE0iimg1PAfO00zdzSpRbcPsSi/uV0Hma5V/eEFd/isE/zUNeWWq21KWk6SwBhQS+BTnv8EYwOuWJfbFMT25/E4pxiNy6cINccgge1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893791; c=relaxed/simple;
	bh=W43B+hIFOwUnoJaupr+EZ3l46lXq4kOFeQX11PT3jeo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYSEQ3TkjmaEug2HsIfkeg0/o3shF9rPF5Tlqie08SNWWy2CjFaPCc2kgZOCYFxS2n9uwwL+4EqxDObVTeCsQB1pzsKSPJZZ1QqANTVZxFKefj7fXgpcRdNiI+qemsnlwm6T0Pgv38V6ChVTJkyRgq/6V1RwP3EazSrJehOGoJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUgnOB/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUgnOB/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63901F00ADE;
	Fri, 19 Jun 2026 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781893789;
	bh=Q9bJOwtKZsbvqbuM+5EuWG5DnH0k5X2JQtsxLHkvLx0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BUgnOB/o3bJDcf5F8OuBVA28PqQP/4GKZNnh1AoU+J+0OIaolCzb1ToUIqGbpS8fX
	 uvXcZ3+i4s/TRcLKh55T4vYxk6pRDrDJOvRalJsN1NGaZjtbrauAzapTmKuwQ0NHNc
	 qnwU64EP13RNbcrgntJ09NdnK6XSu0AyorTsM6HIUrS6GwU3so8FJKi4Qp1QjetXFW
	 qCd5hKNyrvGfx6BkDavT5KOBOtKuTCLN6494a2hWBnpAlbwvGCsq2/2Wl4hD/02mcx
	 hGAkJQNGfuy9ViGQMKa1lDfsZkt8tgxR0rnCUG3Waj3nVT7fHtWK5dwEn/9iLIMAEk
	 dqCF0mUMkZF8g==
From: Drew Fustini <fustini@kernel.org>
Date: Fri, 19 Jun 2026 11:29:38 -0700
Subject: [PATCH 3/8] riscv: Add support for srmcfg CSR from Ssqosid
 extension
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260619-dfustini-atl-sc-cbqri-dt-v1-3-e79a7723fab0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12115; i=fustini@kernel.org;
 h=from:subject:message-id; bh=W43B+hIFOwUnoJaupr+EZ3l46lXq4kOFeQX11PT3jeo=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWSZds20cl+rv/z1jVUVF/P3WhTdeH1rd7WFbU3Fp+0HT
 4UnqU7Z3FHKwiDGxSArpsiy6UPehSVeoV8XzH+xDWYOKxPIEAYuTgGYyH1lhn+2Et6l8ZMnfFyu
 /G5ZYca1Oj3fAPUXd/+cPHXptYXm4V9sjAx9/A9XeSsHuLOHfD9Q8EaR45L1nw9rVWbsrDx1S7c
 3T5kTAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add support for the srmcfg CSR defined in the Ssqosid ISA extension.
The CSR contains two fields:

  - Resource Control ID (RCID) for resource allocation
  - Monitoring Counter ID (MCID) for tracking resource usage

Requests from a hart to shared resources are tagged with these IDs,
allowing resource usage to be associated with the running task.

Add a srmcfg field to thread_struct with the same format as the CSR so
the scheduler can set the RCID and MCID for each task on context
switch. A per-cpu cpu_srmcfg variable mirrors the CSR state to avoid
redundant writes. L1D-hot memory access is faster than a CSR read and
avoids traps under virtualization.

A per-cpu cpu_srmcfg_default holds the default srmcfg for each CPU as
set by resctrl CPU group assignment. On context switch, RCID and MCID
inherit from the CPU default independently: a task whose thread RCID
field is zero takes the CPU default's RCID, and likewise for MCID.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                        |  8 ++++
 arch/riscv/Kconfig                 | 18 ++++++++
 arch/riscv/include/asm/csr.h       |  5 +++
 arch/riscv/include/asm/processor.h |  3 ++
 arch/riscv/include/asm/qos.h       | 86 +++++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  3 ++
 arch/riscv/kernel/Makefile         |  2 +
 arch/riscv/kernel/qos.c            | 91 ++++++++++++++++++++++++++++++++++++++
 8 files changed, 216 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 069b4aa6b523..e2a7f9766355 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23291,6 +23291,14 @@ F:	drivers/perf/riscv_pmu.c
 F:	drivers/perf/riscv_pmu_legacy.c
 F:	drivers/perf/riscv_pmu_sbi.c
 
+RISC-V QOS RESCTRL SUPPORT
+M:	Drew Fustini <fustini@kernel.org>
+R:	yunhui cui <cuiyunhui@bytedance.com>
+L:	linux-riscv@lists.infradead.org
+S:	Supported
+F:	arch/riscv/include/asm/qos.h
+F:	arch/riscv/kernel/qos.c
+
 RISC-V RPMI AND MPXY DRIVERS
 M:	Rahul Pathak <rahul@summations.net>
 M:	Anup Patel <anup@brainfault.org>
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3f0a647218e4..ee586925f972 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -590,6 +590,24 @@ config RISCV_ISA_SVNAPOT
 
 	  If you don't know what to do here, say Y.
 
+config RISCV_ISA_SSQOSID
+	bool "Ssqosid extension support for supervisor mode Quality of Service ID"
+	depends on 64BIT
+	default n
+	help
+	  Adds support for the Ssqosid ISA extension (Supervisor-mode
+	  Quality of Service ID).
+
+	  Ssqosid defines the srmcfg CSR which allows the system to tag the
+	  running process with an RCID (Resource Control ID) and MCID
+	  (Monitoring Counter ID). The RCID is used to determine resource
+	  allocation. The MCID is used to track resource usage in event
+	  counters.
+
+	  For example, a cache controller may use the RCID to apply a
+	  cache partitioning scheme and use the MCID to track how much
+	  cache a process, or a group of processes, is using.
+
 config RISCV_ISA_SVPBMT
 	bool "Svpbmt extension support for supervisor mode page-based memory types"
 	depends on 64BIT && MMU
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 31b8988f4488..7bce928e5daa 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -84,6 +84,10 @@
 #define SATP_ASID_MASK	_AC(0xFFFF, UL)
 #endif
 
+/* SRMCFG fields */
+#define SRMCFG_RCID_MASK	GENMASK(11, 0)
+#define SRMCFG_MCID_MASK	GENMASK(27, 16)
+
 /* Exception cause high bit - is an interrupt if set */
 #define CAUSE_IRQ_FLAG		(_AC(1, UL) << (__riscv_xlen - 1))
 
@@ -328,6 +332,7 @@
 #define CSR_STVAL		0x143
 #define CSR_SIP			0x144
 #define CSR_SATP		0x180
+#define CSR_SRMCFG		0x181
 
 #define CSR_STIMECMP		0x14D
 #define CSR_STIMECMPH		0x15D
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 812517b2cec1..49a386d74cd3 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -123,6 +123,9 @@ struct thread_struct {
 	/* A forced icache flush is not needed if migrating to the previous cpu. */
 	unsigned int prev_cpu;
 #endif
+#ifdef CONFIG_RISCV_ISA_SSQOSID
+	u32 srmcfg;
+#endif
 };
 
 /* Whitelist the fstate from the task_struct for hardened usercopy */
diff --git a/arch/riscv/include/asm/qos.h b/arch/riscv/include/asm/qos.h
new file mode 100644
index 000000000000..600d889ef63d
--- /dev/null
+++ b/arch/riscv/include/asm/qos.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_QOS_H
+#define _ASM_RISCV_QOS_H
+
+#include <linux/percpu-defs.h>
+
+#ifdef CONFIG_RISCV_ISA_SSQOSID
+
+#include <linux/bitfield.h>
+#include <linux/cpufeature.h>
+#include <linux/sched.h>
+
+#include <asm/csr.h>
+#include <asm/fence.h>
+#include <asm/hwcap.h>
+
+/* cached value of srmcfg csr for each cpu */
+DECLARE_PER_CPU(u32, cpu_srmcfg);
+
+/* default srmcfg value for each cpu, set via resctrl cpu assignment */
+DECLARE_PER_CPU(u32, cpu_srmcfg_default);
+
+static inline void __switch_to_srmcfg(struct task_struct *next)
+{
+	u32 thread_srmcfg, default_srmcfg;
+
+	thread_srmcfg = READ_ONCE(next->thread.srmcfg);
+	default_srmcfg = __this_cpu_read(cpu_srmcfg_default);
+
+	/*
+	 * RCID and MCID inherit from cpu_srmcfg_default independently.
+	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are both 0,
+	 * so a per-field zero means "no task assignment for this
+	 * dimension" and the CPU default supplies that field. The fully
+	 * unassigned (thread.srmcfg == 0) and fully assigned (both
+	 * fields non-zero) cases short-circuit the field math.
+	 */
+	if (thread_srmcfg == 0) {
+		thread_srmcfg = default_srmcfg;
+	} else {
+		u32 rcid = FIELD_GET(SRMCFG_RCID_MASK, thread_srmcfg);
+		u32 mcid = FIELD_GET(SRMCFG_MCID_MASK, thread_srmcfg);
+
+		if (rcid == 0 || mcid == 0) {
+			if (rcid == 0)
+				rcid = FIELD_GET(SRMCFG_RCID_MASK, default_srmcfg);
+			if (mcid == 0)
+				mcid = FIELD_GET(SRMCFG_MCID_MASK, default_srmcfg);
+			thread_srmcfg = FIELD_PREP(SRMCFG_RCID_MASK, rcid) |
+					FIELD_PREP(SRMCFG_MCID_MASK, mcid);
+		}
+	}
+
+	if (thread_srmcfg != __this_cpu_read(cpu_srmcfg)) {
+		/*
+		 * Drain stores from the outgoing task before the CSR write
+		 * so they retain the previous RCID/MCID tag at the cache
+		 * interconnect.
+		 */
+		RISCV_FENCE(rw, o);
+
+		__this_cpu_write(cpu_srmcfg, thread_srmcfg);
+		csr_write(CSR_SRMCFG, thread_srmcfg);
+		/*
+		 * Order the csrw before the new task's loads/stores so they
+		 * pick up the new tag. Zicsr 6.1.1 makes CSR writes weakly
+		 * ordered (device-output) vs memory ops. Ssqosid v1.0 is
+		 * silent so honor the general CSR rule.
+		 */
+		RISCV_FENCE(o, rw);
+	}
+}
+
+static __always_inline bool has_srmcfg(void)
+{
+	return riscv_has_extension_unlikely(RISCV_ISA_EXT_SSQOSID);
+}
+
+#else /* ! CONFIG_RISCV_ISA_SSQOSID  */
+
+struct task_struct;
+static __always_inline bool has_srmcfg(void) { return false; }
+static inline void __switch_to_srmcfg(struct task_struct *next) { }
+
+#endif /* CONFIG_RISCV_ISA_SSQOSID */
+#endif /* _ASM_RISCV_QOS_H */
diff --git a/arch/riscv/include/asm/switch_to.h b/arch/riscv/include/asm/switch_to.h
index 0e71eb82f920..1c7ea53ec012 100644
--- a/arch/riscv/include/asm/switch_to.h
+++ b/arch/riscv/include/asm/switch_to.h
@@ -14,6 +14,7 @@
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/csr.h>
+#include <asm/qos.h>
 
 #ifdef CONFIG_FPU
 extern void __fstate_save(struct task_struct *save_to);
@@ -119,6 +120,8 @@ do {							\
 		__switch_to_fpu(__prev, __next);	\
 	if (has_vector() || has_xtheadvector())		\
 		__switch_to_vector(__prev, __next);	\
+	if (has_srmcfg())				\
+		__switch_to_srmcfg(__next);		\
 	if (switch_to_should_flush_icache(__next))	\
 		local_flush_icache_all();		\
 	__switch_to_envcfg(__next);			\
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index cabb99cadfb6..ebe1c3588177 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -128,3 +128,5 @@ obj-$(CONFIG_ACPI_NUMA)	+= acpi_numa.o
 
 obj-$(CONFIG_GENERIC_CPU_VULNERABILITIES) += bugs.o
 obj-$(CONFIG_RISCV_USER_CFI) += usercfi.o
+
+obj-$(CONFIG_RISCV_ISA_SSQOSID) += qos.o
diff --git a/arch/riscv/kernel/qos.c b/arch/riscv/kernel/qos.c
new file mode 100644
index 000000000000..42f1ff9b219d
--- /dev/null
+++ b/arch/riscv/kernel/qos.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/cpu.h>
+#include <linux/cpu_pm.h>
+#include <linux/cpuhotplug.h>
+#include <linux/notifier.h>
+#include <linux/percpu-defs.h>
+#include <linux/types.h>
+
+#include <asm/cpufeature-macros.h>
+#include <asm/hwcap.h>
+#include <asm/qos.h>
+
+/*
+ * Cached value of srmcfg csr for each cpu. Seeded to U32_MAX so the next
+ * __switch_to_srmcfg() unconditionally writes the CSR. The encoding
+ * MCID << 16 | RCID with both fields well under 16 bits can never
+ * produce this sentinel. This covers early-boot context switches that
+ * happen before riscv_srmcfg_init() runs as an arch_initcall.
+ */
+DEFINE_PER_CPU(u32, cpu_srmcfg) = U32_MAX;
+
+/* default srmcfg value for each cpu, set via resctrl cpu assignment */
+DEFINE_PER_CPU(u32, cpu_srmcfg_default);
+
+/*
+ * Invalidate the per-CPU srmcfg cache, used as both the cpuhp startup and
+ * teardown callback. The sentinel is a value no real srmcfg encoding can
+ * produce (MCID << 16 | RCID, both fields well under 16 bits) so the next
+ * __switch_to_srmcfg() unconditionally writes the CSR.
+ *
+ * Ssqosid v1.0 leaves CSR state across hart stop/start implementation-
+ * defined, so the cached value cannot be trusted after online. Invalidating
+ * on offline as well means the sentinel persists across the offline period:
+ * a CPU brought back online finds the cache already invalidated before it is
+ * schedulable, closing the window where a task scheduled before the startup
+ * callback runs could match a stale cache and skip the CSR write while the
+ * hardware CSR was reset across hart stop/start.
+ */
+static int riscv_srmcfg_reset_cache(unsigned int cpu)
+{
+	per_cpu(cpu_srmcfg, cpu) = U32_MAX;
+	return 0;
+}
+
+/*
+ * CPU PM notifier: invalidate the cached srmcfg on resume from a deep
+ * idle / suspend. Ssqosid v1.0 leaves CSR_SRMCFG state across low-power
+ * transitions implementation-defined, and the boot CPU never goes
+ * through the cpuhp online callback during system suspend, so without
+ * this hook __switch_to_srmcfg() would skip the CSR write when the
+ * outgoing task happens to share its srmcfg with the pre-suspend cache.
+ */
+static int riscv_srmcfg_pm_notify(struct notifier_block *nb,
+				  unsigned long action, void *unused)
+{
+	switch (action) {
+	case CPU_PM_EXIT:
+	case CPU_PM_ENTER_FAILED:
+		__this_cpu_write(cpu_srmcfg, U32_MAX);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block riscv_srmcfg_pm_nb = {
+	.notifier_call = riscv_srmcfg_pm_notify,
+};
+
+static int __init riscv_srmcfg_init(void)
+{
+	int err;
+
+	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SSQOSID))
+		return 0;
+
+	/*
+	 * cpuhp_setup_state() invokes the startup callback locally on every
+	 * already-online CPU, so no separate seed loop is needed here.
+	 */
+	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/srmcfg:online",
+				riscv_srmcfg_reset_cache, riscv_srmcfg_reset_cache);
+	if (err < 0) {
+		pr_warn("srmcfg cpuhp registration failed (%d), cpus brought online after boot will not invalidate the CSR_SRMCFG cache\n",
+			err);
+		return err;
+	}
+
+	cpu_pm_register_notifier(&riscv_srmcfg_pm_nb);
+	return 0;
+}
+arch_initcall(riscv_srmcfg_init);

-- 
2.43.0

