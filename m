Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949143B8930;
	Sun, 24 May 2026 23:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779667065; cv=none; b=ACCnxvytyE0qyx2KX7Txn4ePcsETMJwS1hohtmaCKbgWLcSfSeAoHK2DYSyD0oeZZ0EjjfiCHIKTv+E398ZcPjEQcz5olrI68yKf7ig4yBqV7GMYET1h8JJUVofIyBSjpvEeYjZlFdn9lgZLkSJaBPlMjQGEUF1GoCxYrQjmE9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779667065; c=relaxed/simple;
	bh=G+L29Ob1l5pZuRL1dYTcPXw+6N7JDQocSeNE8cYMlqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GuQqW52NGuxmXQlUf/gocKeqOpxZPD5zR4iriZfhltJ+47+I4FxuqxwGYM2lc5bkbjV0eZcJq5dqK7eDqXTdWl3JGzG0LoUk6WE8UcoC6Eo5+86+Vm+CvxUMMXpapVkwxOVs05NTdXETb3MlrG0ww5nIFPvJICF3oexhyHiqeoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMwozZWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMwozZWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A411F01566;
	Sun, 24 May 2026 23:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779667063;
	bh=cUuRBu2/xKXw2Co0MSkuLR4qMvzG1/GgD9Z9r4O74iE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VMwozZWaLAO8dZvZ8eSgUX6c810uiS2mP2bVxVNUoFrQOVBzaEeuv4qQ8R5ZZEcX7
	 zGNk0vR3uHYhFtEm4oOBpxxw2/CH1GtWAG0j+Z3acokE1UK2Z96Na0TsrsTlRPDTh4
	 bpTWez1rtrOnbMhoDzp96BX24X2hWU5XCVFjs+PD/0wTL46Tb3v1y2co8j5iaf8RO8
	 U49M4aXYM7AP3tFqphdMITEg73fcKBkVjEuFYhHkOtutlAUfHV9BBmOwPQ9x8A3cZx
	 UWckXx+NYXpUV8xujPg1mmh9b1rb2vZBw2qUpngqR+zQsQW+aBQQNXaM9nTt7tJMgi
	 iJSi0UNb9qraw==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 24 May 2026 16:55:46 -0700
Subject: [PATCH RFC v5 16/18] ACPI: RISC-V: Parse RISC-V Quality of Service
 Controller (RQSC) table
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-ssqosid-cbqri-rqsc-v7-0-v5-16-78d3a7ba9dbe@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11590; i=fustini@kernel.org;
 h=from:subject:message-id; bh=G+L29Ob1l5pZuRL1dYTcPXw+6N7JDQocSeNE8cYMlqk=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQJT8iKWn72uq/uD7v6g+e0W8S28e1VsH55sapF+srKs
 n+zJvIVd5SyMIhxMciKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmYufByND/m696n+/KXgbN
 shlMHyUWWjiKr95pVZn2IXA5Z/D0OGaG/7UH5T4uMllvviXAqWX9j7iup74TnmWZ76rb8VWL5QM
 7OycA
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
 drivers/acpi/riscv/rqsc.c     | 194 ++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/rqsc.h     |  63 ++++++++++++++
 5 files changed, 270 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7821dd5159cb..eab31c7b5e91 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23025,6 +23025,8 @@ S:	Supported
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
index 000000000000..1cbc5c07e191
--- /dev/null
+++ b/drivers/acpi/riscv/rqsc.c
@@ -0,0 +1,194 @@
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
+	/*
+	 * Reject revisions newer than this parser was written against.  A
+	 * future revision could extend the fixed RQSC header before the
+	 * first node, which would shift the resource subtables and cause the
+	 * sizeof(*node)-based offset below to point into the wrong place.
+	 */
+	if (rqsc->header.revision != ACPI_RQSC_REVISION) {
+		pr_err("RQSC table revision %u, expected %u, aborting\n",
+		       rqsc->header.revision, ACPI_RQSC_REVISION);
+		return -EINVAL;
+	}
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
+		/*
+		 * Without this check, a node whose length claims to extend
+		 * past the end of the table would advance the loop cursor
+		 * past `end` and silently terminate.  Flag the corruption
+		 * explicitly so a malformed firmware table cannot truncate
+		 * the controller list without noise.
+		 */
+		if ((void *)node + node->length > (void *)end) {
+			pr_err("RQSC entry length %u overruns table end, aborting\n",
+			       node->length);
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
+		/*
+		 * Pair the QoS controller type with the resource descriptor
+		 * fields that index id1.  RQSC v0.9.2 Table 4 defines the
+		 * mapping: a Capacity controller indexes a Processor Cache
+		 * via PPTT cache_id, a Bandwidth controller indexes a Memory
+		 * Range via SRAT proximity domain.  Mismatched pairings
+		 * (e.g. a CC whose first resource is Memory) would otherwise
+		 * route id1 into the wrong downstream lookup.
+		 */
+		switch (info.type) {
+		case CBQRI_CONTROLLER_TYPE_CAPACITY:
+			if (res0->type != ACPI_RQSC_RESOURCE_TYPE_CACHE ||
+			    res0->id_type != ACPI_RQSC_RESOURCE_ID_TYPE_PROCESSOR_CACHE) {
+				pr_warn("CC at %pa: resource type=%u id_type=%u not (cache, processor cache), skipping\n",
+					&info.addr, res0->type, res0->id_type);
+				continue;
+			}
+			info.cache_id = (u32)res0->id1;
+			break;
+		case CBQRI_CONTROLLER_TYPE_BANDWIDTH:
+			if (res0->type != ACPI_RQSC_RESOURCE_TYPE_MEMORY ||
+			    res0->id_type != ACPI_RQSC_RESOURCE_ID_TYPE_MEMORY_RANGE) {
+				pr_warn("BC at %pa: resource type=%u id_type=%u not (memory, memory range), skipping\n",
+					&info.addr, res0->type, res0->id_type);
+				continue;
+			}
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
index 000000000000..f7b556f29e16
--- /dev/null
+++ b/drivers/acpi/riscv/rqsc.h
@@ -0,0 +1,63 @@
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
+/* RQSC v0.9.2 Table 1: current revision number. */
+#define ACPI_RQSC_REVISION	1
+
+/* RQSC v0.9.2 Table 4: Resource Type values for acpi_rqsc_resource.type. */
+#define ACPI_RQSC_RESOURCE_TYPE_CACHE	0
+#define ACPI_RQSC_RESOURCE_TYPE_MEMORY	1
+
+/* RQSC v0.9.2 Table 4: Resource ID Type values for .id_type. */
+#define ACPI_RQSC_RESOURCE_ID_TYPE_PROCESSOR_CACHE	0
+#define ACPI_RQSC_RESOURCE_ID_TYPE_MEMORY_RANGE		1
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

