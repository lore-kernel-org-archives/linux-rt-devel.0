Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D44E372692;
	Mon, 11 May 2026 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476271; cv=none; b=Vz5UpghZKLc6gNhfXoI+W4akDahJ6Jwr65ZJWKrIbL3CfKmMaDidfA9e2TS8kTtqJHyuEn60yVWOewoNNhBwfpGsHBRo/Te0L9nIJPSpbprBXR2S38HVutt0jrR6CUG5XrX/ZEsWoewAKdq3tw68Wvz09WAvRhMe7raZh5q7P7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476271; c=relaxed/simple;
	bh=7zh/xIk9KE07e14wxorJlZWgxkGTVDJv66IX1VUZcbw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OE3yvf5RZgbCoGi0cCjnEqXeWnl9n0PaMwuDMygRjC8NpSB/REsIh17P41QY93ei9Tl8kM3fc/fdXMsu6d480c/e1fm1iWg8LCcF67Ejitm6It6CxqdxPb6m3Gu56dRMxFGBz8RQyqklGe1aOJ4vkxLCD0D6qcBLtBSSP6Jwtl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sKjUhHIM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sKjUhHIM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8290DC2BCFF;
	Mon, 11 May 2026 05:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476271;
	bh=7zh/xIk9KE07e14wxorJlZWgxkGTVDJv66IX1VUZcbw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sKjUhHIMSBu1y5OcyzL7CvAKZnhEzDQfkIIPIXfuA3QH+hw/aqkc0mVS255QN0Sss
	 GqcP35LnLhM0wyNugeDoW0RO71ltcf5W/I/Ah8JUxkIDEljugK5+E/TDEk7jv3WTri
	 qst4JomXXqKtbQvhW/3RfOxXkl6ia8A67Z+0LLY6/FLOT57eSiR9oqZhc40o3Hoajv
	 dDDlyNqt8OEtBQXm/+ieNwH//2ovjr/Lrcw2EqCogYNIgGuNn5yJC8D9TlyYZ+qxUz
	 yAydKbN1JXk6M5LvePH7lcec2CursB8tMOrY4iDJO0zwVD5Z/Fpu+aqIxY+yudygtO
	 fzYdIT3jcLGMQ==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 10 May 2026 22:10:59 -0700
Subject: [PATCH RFC v4 03/18] riscv: add support for srmcfg CSR from
 Ssqosid extension
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-3-eb53831ef683@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9619; i=fustini@kernel.org;
 h=from:subject:message-id; bh=7zh/xIk9KE07e14wxorJlZWgxkGTVDJv66IX1VUZcbw=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQxprzi9HPfalb0au8yzV/sC3Mb50+omHPUp1Ch95RAg
 dTPNYH3O0pZGMS4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQAT+XOakeGSlcv5VMUcubIz
 AikcV3/7yLyulHYtkubXfHDn3cfU62oM/6zmq3q9UncXLoh5onrg54WfhYpTrtuwH4gQ+cOyq+Q
 HIxsA
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
set by resctrl CPU group assignment. On context switch, if the next
task belongs to the default resource group (srmcfg == 0), the CPU's
default value is used instead. This implements resctrl allocation
rule 2: default-group tasks on a CPU assigned to a specific group
receive that group's allocations.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Assisted-by: Claude:claude-opus-4-7
Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                        |  8 +++++
 arch/riscv/Kconfig                 | 18 +++++++++++
 arch/riscv/include/asm/csr.h       |  5 +++
 arch/riscv/include/asm/processor.h |  3 ++
 arch/riscv/include/asm/qos.h       | 64 ++++++++++++++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  3 ++
 arch/riscv/kernel/Makefile         |  2 ++
 arch/riscv/kernel/qos.c            | 49 +++++++++++++++++++++++++++++
 8 files changed, 152 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d1e198959e4..5039f48f387a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23006,6 +23006,14 @@ F:	drivers/perf/riscv_pmu.c
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
index d235396c4514..a7e87c49be21 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -591,6 +591,24 @@ config RISCV_ISA_SVNAPOT
 
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
index 000000000000..6988fe37551e
--- /dev/null
+++ b/arch/riscv/include/asm/qos.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_RISCV_QOS_H
+#define _ASM_RISCV_QOS_H
+
+#include <linux/percpu-defs.h>
+
+#ifdef CONFIG_RISCV_ISA_SSQOSID
+
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
+	u32 thread_srmcfg;
+
+	thread_srmcfg = READ_ONCE(next->thread.srmcfg);
+
+	/* Default-group tasks (thread.srmcfg == 0) follow this CPU's default. */
+	if (thread_srmcfg == 0)
+		thread_srmcfg = __this_cpu_read(cpu_srmcfg_default);
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
index 000000000000..75bda2ed89e1
--- /dev/null
+++ b/arch/riscv/kernel/qos.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/cpu.h>
+#include <linux/cpuhotplug.h>
+#include <linux/percpu-defs.h>
+#include <linux/types.h>
+
+#include <asm/cpufeature-macros.h>
+#include <asm/hwcap.h>
+#include <asm/qos.h>
+
+/* cached value of srmcfg csr for each cpu */
+DEFINE_PER_CPU(u32, cpu_srmcfg);
+
+/* default srmcfg value for each cpu, set via resctrl cpu assignment */
+DEFINE_PER_CPU(u32, cpu_srmcfg_default);
+
+/*
+ * Seed the per-CPU srmcfg cache to a sentinel that no real srmcfg encoding
+ * can produce (MCID << 16 | RCID, both fields well under 16 bits) so the
+ * next __switch_to_srmcfg() unconditionally writes the CSR. Ssqosid v1.0
+ * leaves CSR state across hart stop/start implementation-defined, so the
+ * cached value cannot be trusted after online.
+ */
+static int riscv_srmcfg_online(unsigned int cpu)
+{
+	per_cpu(cpu_srmcfg, cpu) = U32_MAX;
+	return 0;
+}
+
+static int __init riscv_srmcfg_init(void)
+{
+	unsigned int cpu;
+	int err;
+
+	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SSQOSID))
+		return 0;
+
+	/* Seed already-online CPUs. The cpuhp callback covers later onlines. */
+	for_each_online_cpu(cpu)
+		per_cpu(cpu_srmcfg, cpu) = U32_MAX;
+
+	err = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/srmcfg:online",
+				riscv_srmcfg_online, NULL);
+	if (err < 0)
+		pr_warn("srmcfg cpuhp registration failed (%d), cpus brought online after boot will not invalidate the CSR_SRMCFG cache\n",
+			err);
+	return err;
+}
+arch_initcall(riscv_srmcfg_init);

-- 
2.43.0

