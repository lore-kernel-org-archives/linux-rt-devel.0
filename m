Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599AE3822B2;
	Mon, 11 May 2026 05:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476280; cv=none; b=K8L2G9mLpChE8PqH9aOpkwqlpPqip8MWVDjKGavxg3KxH8yEXWOokIUSzUclTWvdSsarEqA/iVFtmKvlCVGpNCbOiZorlLxdws2kxM2VIPPDI7CzKDM5rU+qLXUMApr2IhH8fnfpmcusmwmMTPWo341OW3cIg1yydxGETbj3ZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476280; c=relaxed/simple;
	bh=waJCNkfo7Gi+cbJICDLJj/TEQGDl/0aLz8gi7LMw9T4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fpK90hW+ZRhO3qiTv4ZWLjLEVigWSfJVxjsvcJJaqiKX0ucDNVNJE75qEEk1VoqournDYrOmi75cRs6SG//B3ehpMml8eBbipsHNSQxd2fqHUSVcCD0W6x86bhZgbFrNg23nPzBEhpU+bbBb/wV4JIxX3SGbT+V8YSgowEuL8rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxInM7Cc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxInM7Cc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760AAC2BCFA;
	Mon, 11 May 2026 05:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476280;
	bh=waJCNkfo7Gi+cbJICDLJj/TEQGDl/0aLz8gi7LMw9T4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MxInM7Cc64OWnQsGWLUyv7lPOmKb33Rkn103ESJVIUa56nUMPWg8ODngQo6DA0Gqp
	 KRtu733CdisqWS2ku00djIRPLGik0YDn9U1NRpDmA3GznhZuE3a24u19kSAH9FigUj
	 8dEi8uDGDC2KNhzYyQgWpusjCg9neeLKAJZhQIZZNckI5pzv+e09CNYpOlUQeaasCA
	 j0OEWoszIRF+nioUpYxCl9qOS2xfeGholh5bwelA2ZSY8yDu7uYpyEq/8d2U6c/B+2
	 9pFngllrjexdKBH7rdKSiN+JMWKXCNyCpMBXpQcNilKmaPbAUW0807WJ77CdfpmR4/
	 qcvJ/qoBL1L0A==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 10 May 2026 22:11:12 -0700
Subject: [PATCH RFC v4 16/18] ACPI: RISC-V: Parse RISC-V Quality of Service
 Controller (RQSC) table
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-16-eb53831ef683@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9089; i=fustini@kernel.org;
 h=from:subject:message-id; bh=waJCNkfo7Gi+cbJICDLJj/TEQGDl/0aLz8gi7LMw9T4=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQxprw5bPh14tHN1/k1L97OfrIyz++Z56+GnCqZq1+F0
 lY8WXM+u6OUhUGMi0FWTJFl04e8C0u8Qr8umP9iG8wcViaQIQxcnAIwkf8fGP5HSHa+Xa1h0z9p
 9pw3nVJexe9vr0s+3+x84ek3rkmBGvvLGH6z3yne8vm3oNGbQ25fjU4IuMTyST10Vm2bU3dmy7G
 2F7cYAQ==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add a parser for the ACPI RQSC table, which describes the CBQRI
controllers in a system. For each table entry, populate a
cbqri_controller_info descriptor and hand it to the CBQRI driver via
riscv_cbqri_register_controller(). The driver owns all subsequent state,
including cpumask resolution at cbqri_resctrl_setup() time.

Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                   |   2 +
 arch/riscv/include/asm/acpi.h |  10 +++
 drivers/acpi/riscv/Makefile   |   1 +
 drivers/acpi/riscv/rqsc.c     | 147 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/rqsc.h     |  52 +++++++++++++++
 5 files changed, 212 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5589fe766153..3cf3cfa7e6f2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23014,6 +23014,8 @@ S:	Supported
 F:	arch/riscv/include/asm/qos.h
 F:	arch/riscv/include/asm/resctrl.h
 F:	arch/riscv/kernel/qos.c
+F:	drivers/acpi/riscv/rqsc.c
+F:	drivers/acpi/riscv/rqsc.h
 F:	drivers/resctrl/cbqri_devices.c
 F:	drivers/resctrl/cbqri_internal.h
 F:	drivers/resctrl/cbqri_resctrl.c
diff --git a/arch/riscv/include/asm/acpi.h b/arch/riscv/include/asm/acpi.h
index 26ab37c171bc..3cfd0102085e 100644
--- a/arch/riscv/include/asm/acpi.h
+++ b/arch/riscv/include/asm/acpi.h
@@ -67,6 +67,16 @@ int acpi_get_riscv_isa(struct acpi_table_header *table,
 
 void acpi_get_cbo_block_size(struct acpi_table_header *table, u32 *cbom_size,
 			     u32 *cboz_size, u32 *cbop_size);
+
+#ifdef CONFIG_RISCV_CBQRI_DRIVER
+int __init acpi_parse_rqsc(struct acpi_table_header *table);
+#else
+static inline int acpi_parse_rqsc(struct acpi_table_header *table)
+{
+	return -EINVAL;
+}
+#endif /* CONFIG_RISCV_CBQRI_DRIVER */
+
 #else
 static inline void acpi_init_rintc_map(void) { }
 static inline struct acpi_madt_rintc *acpi_cpu_get_madt_rintc(int cpu)
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 1284a076fa88..77f8f0101b7e 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= rhct.o init.o irq.o
+obj-$(CONFIG_RISCV_CBQRI_DRIVER)	+= rqsc.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
 obj-$(CONFIG_ACPI_RIMT)			+= rimt.o
diff --git a/drivers/acpi/riscv/rqsc.c b/drivers/acpi/riscv/rqsc.c
new file mode 100644
index 000000000000..ac3d43b13f3b
--- /dev/null
+++ b/drivers/acpi/riscv/rqsc.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define pr_fmt(fmt) "ACPI: RQSC: " fmt
+
+#include <linux/acpi.h>
+#include <linux/bits.h>
+#include <linux/riscv_cbqri.h>
+
+#include "rqsc.h"
+
+#define CBQRI_CTRL_SIZE 0x1000
+
+int __init acpi_parse_rqsc(struct acpi_table_header *table)
+{
+	struct acpi_table_rqsc *rqsc = (struct acpi_table_rqsc *)table;
+	struct acpi_rqsc_node *end, *node;
+	int num_controllers = 0;
+
+	/* Reject tables shorter than the fixed RQSC header. */
+	if (rqsc->header.length < sizeof(struct acpi_table_rqsc)) {
+		pr_err("RQSC table truncated: length %u < %zu, aborting\n",
+		       rqsc->header.length, sizeof(struct acpi_table_rqsc));
+		return -EINVAL;
+	}
+
+	end = ACPI_ADD_PTR(struct acpi_rqsc_node, rqsc, rqsc->header.length);
+
+	for (node = ACPI_ADD_PTR(struct acpi_rqsc_node, rqsc,
+				 sizeof(struct acpi_table_rqsc));
+	     node < end;
+	     node = ACPI_ADD_PTR(struct acpi_rqsc_node, node, node->length)
+	) {
+		const struct acpi_rqsc_resource *res0;
+		struct cbqri_controller_info info = {};
+		int ret;
+
+		if ((void *)node + sizeof(*node) > (void *)end) {
+			pr_err("truncated entry at end of table, aborting\n");
+			riscv_cbqri_unregister_last(num_controllers);
+			return -EINVAL;
+		}
+
+		if (node->length < sizeof(*node)) {
+			pr_err("malformed RQSC entry: length %u < %zu, aborting\n",
+			       node->length, sizeof(*node));
+			riscv_cbqri_unregister_last(num_controllers);
+			return -EINVAL;
+		}
+
+		/* GAS must describe system memory. ioremap() consumes it later. */
+		if (node->reg.space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY) {
+			pr_warn("controller has unsupported address space_id=%u, skipping\n",
+				node->reg.space_id);
+			continue;
+		}
+
+		/* Address 0 would map page 0 (reset vectors, SBI, boot ROM). */
+		if (!node->reg.address) {
+			pr_warn("controller has zero address, skipping\n");
+			continue;
+		}
+
+		info.type = node->type;
+		/* RQSC v0.9.2 section 2 Table 2: 12-byte GAS-format register interface address */
+		info.addr = node->reg.address;
+		info.size = CBQRI_CTRL_SIZE;
+		info.rcid_count = node->rcid;
+		info.mcid_count = node->mcid;
+
+		/* See CBQRI_MAX_RCID/MCID in <linux/riscv_cbqri.h> for the rationale. */
+		if (info.rcid_count > CBQRI_MAX_RCID) {
+			pr_warn("controller at %pa: rcid_count %u exceeds CBQRI_MAX_RCID %u, skipping\n",
+				&info.addr, info.rcid_count, CBQRI_MAX_RCID);
+			continue;
+		}
+
+		if (info.mcid_count > CBQRI_MAX_MCID) {
+			pr_warn("controller at %pa: mcid_count %u exceeds CBQRI_MAX_MCID %u, skipping\n",
+				&info.addr, info.mcid_count, CBQRI_MAX_MCID);
+			continue;
+		}
+
+		if (node->nres == 0) {
+			pr_warn("controller at %pa has no resource descriptors, skipping\n",
+				&info.addr);
+			continue;
+		}
+
+		/*
+		 * Resources follow the node header in-line. Only res[0] is
+		 * consumed. Bound it against end before reading its prefix so
+		 * a table that ends partway through a resource subtable is
+		 * rejected rather than read past the mapping.
+		 */
+		res0 = (const struct acpi_rqsc_resource *)
+		       ((const u8 *)node + sizeof(*node));
+		if ((void *)res0 + sizeof(*res0) > (void *)end ||
+		    node->length < sizeof(*node) + sizeof(*res0) ||
+		    res0->length < sizeof(*res0)) {
+			pr_warn("controller at %pa: node too short for resource descriptor, skipping\n",
+				&info.addr);
+			continue;
+		}
+
+		if (node->nres > 1)
+			pr_warn("controller at %pa has %u resource descriptors, using first\n",
+				&info.addr, node->nres);
+
+		/*
+		 * id1 is u64 on the wire but cache_id and prox_dom are u32
+		 * downstream (PPTT cache_id, ACPI proximity domain). Reject
+		 * rather than truncate, so a too-large id is not silently
+		 * mapped to the wrong PPTT entry or NUMA node.
+		 */
+		if (res0->id1 > U32_MAX) {
+			pr_warn("controller at %pa: id1 0x%llx exceeds u32, skipping\n",
+				&info.addr, res0->id1);
+			continue;
+		}
+
+		switch (info.type) {
+		case CBQRI_CONTROLLER_TYPE_CAPACITY:
+			info.cache_id = (u32)res0->id1;
+			break;
+		case CBQRI_CONTROLLER_TYPE_BANDWIDTH:
+			info.prox_dom = (u32)res0->id1;
+			break;
+		default:
+			pr_warn("controller at %pa: unknown type %u, skipping\n",
+				&info.addr, info.type);
+			continue;
+		}
+
+		pr_debug("registering controller type=%u addr=%pa rcid=%u mcid=%u\n",
+			 info.type, &info.addr, info.rcid_count, info.mcid_count);
+
+		ret = riscv_cbqri_register_controller(&info);
+		if (ret == 0)
+			num_controllers++;
+		else
+			pr_warn("controller at %pa: registration failed (%d), skipping\n",
+				&info.addr, ret);
+	}
+
+	pr_info("found %d CBQRI controllers\n", num_controllers);
+	return 0;
+}
diff --git a/drivers/acpi/riscv/rqsc.h b/drivers/acpi/riscv/rqsc.h
new file mode 100644
index 000000000000..7bea15cb26d8
--- /dev/null
+++ b/drivers/acpi/riscv/rqsc.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Local definitions for the RISC-V Quality of Service Controller (RQSC)
+ * ACPI table. Will move to ACPICA's include/acpi/actbl2.h once the spec
+ * is ratified.
+ */
+#ifndef _DRIVERS_ACPI_RISCV_RQSC_H
+#define _DRIVERS_ACPI_RISCV_RQSC_H
+
+#include <linux/types.h>
+#include <acpi/actbl.h>
+
+#define ACPI_SIG_RQSC	"RQSC"	/* RISC-V Quality of Service Controller */
+
+/*
+ * Byte-packed: u64 id1 would otherwise pad to 8-byte alignment and inflate
+ * sizeof(*res) from the spec's 20 bytes to 24, mis-sizing resource subtables.
+ */
+struct acpi_rqsc_resource {
+	u8 type;
+	u8 resv;
+	u16 length;
+	u16 flags;
+	u8 resv2;
+	u8 id_type;
+	u64 id1;
+	u32 id2;
+} __packed;
+
+struct acpi_rqsc_node {
+	u8 type;
+	u8 resv;
+	u16 length;
+	/* RQSC v0.9.2 section 2 Table 2: 12-byte GAS-format register interface address */
+	struct acpi_generic_address reg;
+	u16 rcid;
+	u16 mcid;
+	u16 flags;
+	u16 nres;
+	/*
+	 * Followed by nres acpi_rqsc_resource subtables. Walk them via
+	 * each resource's own length field so a future RQSC revision that
+	 * extends the resource layout cannot misalign older parsers.
+	 */
+} __packed;
+
+struct acpi_table_rqsc {
+	struct acpi_table_header header;	/* Common ACPI table header */
+	u32 num;
+} __packed;
+
+#endif /* _DRIVERS_ACPI_RISCV_RQSC_H */

-- 
2.43.0

