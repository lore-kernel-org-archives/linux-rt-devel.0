Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166E23F889E;
	Mon,  6 Jul 2026 23:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379188; cv=none; b=fs6dagFuL9hblhwD/rYL0aXzWMA1YFGQtT95O/3iXtyoZdhnELRd15gwP1M93MbBbrj0YqtryllHmgLEv3QqDrBXD/MAu5Zn9cAUCHK1rWCd4Z7KOpzr3VdkFI2W+t9JxvVq2Sz5G7pR9JZA8oZu22L8frHXGWiZVZno7myrjyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379188; c=relaxed/simple;
	bh=AmhvJTDaniQI7tWFCPQrdXgj6W7EU0k3i/M13ACNX44=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gsO9eW/ES84E70ZqHHS47H8ah+w//+Ct56yCnt7W6UOBviZSEtPOgoSnJv2Q5mSJh+wHy00ShyBjfSn66AAEPCSJAyvFmo0LZVZzxobDyAxe+A6eTSBsW2CNMa7K0B5otMonajkDEQR81ruHgfH+BBY2nx3L7g5eg1qxkREWiUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6VQrCh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6VQrCh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7DB1F00A3F;
	Mon,  6 Jul 2026 23:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783379186;
	bh=vCSYGogRBZVMlX/RS7q1ZKEPOOdhGYpOdaqtpLf9Rxw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=R6VQrCh0AeTrDLbQ7o7xMnn0AYe4ixzsSYP5oFnHyHdcivptHgnu/FARhkG/15qBZ
	 elDehn1TjqmVaqy2bIL3LsGcjCKXUp0fhZ++WoFAuOMnxW6deaF8D7P/XZGbt9Z/Nr
	 S5q9MaCpyXmfY3Q6dkhAgcsX9pVihG6lnhOwEW4yjxjEPcSRvFsVEYiy/k/T6JTB21
	 l+h7z2dq8GMO3pO9BJbDabjFh4qDvFcOaXkqleDzNCHTHO6qq5qT3NWhZ6ahLBasJw
	 yJVAD09WlIZEkwZdSU5T2FaNEBGDZJKEvqs6O8aMg3t2gPml2L89vl6hHyajoy7Q+N
	 SGAS+onYm++qA==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 06 Jul 2026 16:06:13 -0700
Subject: [PATCH v4 3/8] riscv: Add support for srmcfg CSR from Ssqosid
 extension
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-dfustini-atl-sc-cbqri-dt-v4-3-e75c20201d64@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12190; i=fustini@kernel.org;
 h=from:subject:message-id; bh=AmhvJTDaniQI7tWFCPQrdXgj6W7EU0k3i/M13ACNX44=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWT5mLx/Yui4OG7OYunY220rgudpHSp3dj1dvG/Toa8r0
 g4Fy2/t6ShlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMZCM3I8Pa6cJ3l55eunyf
 /28bg/Pn+TleMR7Rqfu3Tv109PsrngbmDP8d5ks8/OAm7igafniF7rLvVVMzTO2uuHz0nPKh8/L
 XjybMAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add support for the srmcfg CSR defined in the Ssqosid ISA extension.
The CSR contains two fields:

  - Resource Control ID (RCID) for resource allocation
  - Monitoring Counter ID (MCID) for tracking resource usage

Requests from a hart to shared resources are tagged with these IDs,
allowing resource usage to be associated with the running task.

Add a srmcfg field to thread_struct with the same format as the CSR.
The context-switch path writes the field to the CSR, and
resctrl_arch_set_closid_rmid() updates it when a task is assigned to a
resctrl control or monitoring group.

A per-cpu cpu_srmcfg_default holds the default srmcfg for each CPU, set
by resctrl_arch_set_cpu_default_closid_rmid() on CPU group assignment.
On context switch, RCID and MCID inherit from the CPU default
independently: a task whose thread RCID field is zero takes the CPU
default's RCID, and likewise for MCID.

A per-cpu cpu_srmcfg variable mirrors the CSR state to avoid
redundant writes. L1D-hot memory access is faster than a CSR read and
avoids traps under virtualization.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                        |   8 +++
 arch/riscv/Kconfig                 |  18 +++++++
 arch/riscv/include/asm/csr.h       |   5 ++
 arch/riscv/include/asm/processor.h |   3 ++
 arch/riscv/include/asm/qos.h       |  74 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |   3 ++
 arch/riscv/kernel/Makefile         |   2 +
 arch/riscv/kernel/qos.c            | 101 +++++++++++++++++++++++++++++++++++++
 8 files changed, 214 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 52b6c2e1d6a2..fe101986917d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23338,6 +23338,14 @@ F:	drivers/perf/riscv_pmu.c
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
index 66638fc9ba43..705c5b25cae7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -592,6 +592,24 @@ config RISCV_ISA_SVNAPOT
 
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
index 000000000000..cf19e8438bb9
--- /dev/null
+++ b/arch/riscv/include/asm/qos.h
@@ -0,0 +1,74 @@
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
+	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are both 0, so a
+	 * zero field means "unassigned" and takes the CPU default.
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
+		 * No fence around the csrw. Ssqosid is silent on srmcfg
+		 * ordering versus memory accesses, so a few accesses at the
+		 * switch boundary may carry the previous RCID/MCID. The
+		 * tagging inaccuracy is bounded and acceptable for QoS.
+		 */
+		__this_cpu_write(cpu_srmcfg, thread_srmcfg);
+		csr_write(CSR_SRMCFG, thread_srmcfg);
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
index 000000000000..99925c0e93dd
--- /dev/null
+++ b/arch/riscv/kernel/qos.c
@@ -0,0 +1,101 @@
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
+ * Invalidate the per-CPU srmcfg cache. Used as both the cpuhp startup
+ * and teardown callback. U32_MAX is not a valid srmcfg value
+ * (MCID << 16 | RCID, both fields under 16 bits), so the next
+ * __switch_to_srmcfg() always writes the CSR.
+ *
+ * Ssqosid leaves the CSR implementation-defined across hart stop/start,
+ * so the cached value cannot be trusted after online. The startup
+ * callback runs at CPUHP_AP_ONLINE_DYN, before CPUHP_AP_ACTIVE makes
+ * the CPU schedulable, so the cache is invalidated before any normal
+ * task runs and the CSR is written on that task's first switch.
+ * The teardown callback is not relied on. Idle and per-CPU kthreads keep
+ * switching as the CPU goes down and overwrite the sentinel with the CPU
+ * default, so it does not survive the offline period.
+ */
+static int riscv_srmcfg_reset_cache(unsigned int cpu)
+{
+	per_cpu(cpu_srmcfg, cpu) = U32_MAX;
+	return 0;
+}
+
+/*
+ * CPU PM notifier: invalidate the cached srmcfg on resume from a deep
+ * idle / suspend. Ssqosid leaves CSR_SRMCFG state across low-power
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
+		/*
+		 * The CSR is implementation-defined across the low-power
+		 * transition. Invalidate the cache and eagerly rewrite the
+		 * CSR for the current task so it does not run mis-tagged
+		 * until the next context switch.
+		 */
+		__this_cpu_write(cpu_srmcfg, U32_MAX);
+		__switch_to_srmcfg(current);
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
+	if (err < 0)
+		pr_warn("srmcfg: cpuhp setup failed (%d), cache not invalidated on CPU online\n",
+			err);
+
+	/*
+	 * Register the PM notifier even if the cpuhp setup failed. It is
+	 * independent of the cpuhp state and guards suspend/resume.
+	 */
+	cpu_pm_register_notifier(&riscv_srmcfg_pm_nb);
+	return 0;
+}
+arch_initcall(riscv_srmcfg_init);

-- 
2.43.0

