Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A4933AD9D;
	Fri, 19 Jun 2026 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893813; cv=none; b=B/+nzJK4J2VlJHRH7gI6BQ/HaEAt/iM1tiWXqZc3a94ZH1sdQE8Vxyx7Dnyx4e7oW7hd0eDgywjXbbBYf6D5aGlNkORlsBnCjo4oVZCSjrQd7Jf630zsf4ucmpnfTI6P+O4+2BF6XpTY8vsa/gJlc2x+iW+6Ti7vrqIsGbAFjvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893813; c=relaxed/simple;
	bh=k0sOCpd05z1JjOW+YZ6mBfMPJVw/6wkCK/Xyc5QIPLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBe/LpWMLeSUtiTQX+fHBvgzDAp4A2+KJwhLX8IzEEB8yGE1pxeKAe8pQG1KOOXEVgWbdbF5m1ZNJEjfU0aQdWcDTNY5jAz9aA/OoAwjPaTXkt2Bihm06R6p6PFPhpVuiH0kK5/bvRlrnOOAsuP4tWg7OKK/9pdiwYMrJivRWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpBjmiSa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpBjmiSa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 336A51F00ACF;
	Fri, 19 Jun 2026 18:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781893793;
	bh=VQoWlUCq/vA8VDrqy3netzbUf+zudMAVdy2/QCWUZYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fpBjmiSaGzuqtdZrDi91zmkWbQCrfrf7WZAdNQoCq+yvMKIhLp4eJ3dQwdTcZcZg4
	 89ZKFkS52zOCZigEqxZ6gZIc/IR8/dC8C+8B3oLD/5qMruBaxI/vm6CG1qtl7/fIgA
	 u9Cn8jZPnUQwD7krv1G6WZ9knfuLCKNRB7iidajJsLlqpX7OpoAHcM6xUQlCFQnnAk
	 jBInFQ3V6qV+B5jdOPon/zjVWna8MRwTBZEJXJA2s2mD4Dy6mAgg7QynNCRRKqgS3h
	 bztUgofmt3vvX5PssCoJ7K9TEe+no4pqC0D3DUTCDpqD1SHz2LyTdtC+//SgWjLkFe
	 yIo5SQRqJcBSA==
From: Drew Fustini <fustini@kernel.org>
Date: Fri, 19 Jun 2026 11:29:43 -0700
Subject: [PATCH 8/8] riscv_cbqri: Add CBQRI cache capacity-allocation
 platform driver
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dfustini-atl-sc-cbqri-dt-v1-8-e79a7723fab0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7417; i=fustini@kernel.org;
 h=from:subject:message-id; bh=k0sOCpd05z1JjOW+YZ6mBfMPJVw/6wkCK/Xyc5QIPLY=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWSZds06KJOsqXN7H3ODW8vBRs8rCidN1a61776+6oqJ6
 +qTKpuud5SyMIhxMciKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmsjWb4a8Yf2TlzL63xTIn
 zWSZbKvfTtpd0rNPo/mARuvFZ+mcG0sY/idOfCM3Td7BjpfvDu/BxXwBqTk8xf8CbU4Ibbw/98p
 SGRYA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

The CBQRI core exposes riscv_cbqri_register_cc_dt() so a device-tree
platform driver can register a capacity controller whose cache topology
it already knows.

Add a platform driver, bound to the generic compatible, that discovers a
CBQRI capacity controller backing a CPU cache from its DT node and
registers it via riscv_cbqri_register_cc_dt() as the resctrl cache
allocation resource. The controller node carries a riscv,cbqri-cache
phandle to the cache it governs.

The driver reads cache-level from that node and matches it against
cacheinfo to obtain both the resctrl domain id and the set of harts that
share the cache. The node must also provide riscv,cbqri-rcid. Nothing in
the driver is vendor-specific, so any SoC that describes a CBQRI
capacity controller in device tree can reuse it unchanged. The DT "reg"
describes the CBQRI capacity-controller register block directly, so the
driver only ever touches the CBQRI registers.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                      |   1 +
 drivers/resctrl/Kconfig          |  15 +++++
 drivers/resctrl/Makefile         |   1 +
 drivers/resctrl/cbqri_capacity.c | 132 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 149 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f8b995420c11..53d29dbbdb63 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23300,6 +23300,7 @@ F:	Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
 F:	arch/riscv/include/asm/qos.h
 F:	arch/riscv/include/asm/resctrl.h
 F:	arch/riscv/kernel/qos.c
+F:	drivers/resctrl/cbqri_capacity.c
 F:	drivers/resctrl/cbqri_devices.c
 F:	drivers/resctrl/cbqri_internal.h
 F:	drivers/resctrl/cbqri_resctrl.c
diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
index 0887b6a9fac1..bc1e71cc6dfc 100644
--- a/drivers/resctrl/Kconfig
+++ b/drivers/resctrl/Kconfig
@@ -53,6 +53,21 @@ config RISCV_CBQRI_DRIVER_DEBUG
 	  per-controller registration steps.  Useful when bringing up a
 	  new platform; otherwise leave disabled to avoid log noise.
 
+config RISCV_CBQRI_CAPACITY
+	bool "RISC-V CBQRI cache capacity-allocation controller"
+	depends on OF
+	help
+	  Device-tree platform driver for a RISC-V CBQRI capacity controller
+	  that backs a CPU cache, matching the generic
+	  "riscv,cbqri-capacity-controller" compatible. The controller node
+	  carries a phandle to the cache it governs; the driver derives the
+	  cache level and the set of harts that share it from the kernel
+	  cache topology and registers it as the resctrl cache-allocation
+	  resource.
+
+	  Say N unless your SoC describes a CBQRI capacity controller in its
+	  device tree.
+
 endif
 
 config RISCV_CBQRI_RESCTRL_FS
diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
index ed737b4461b9..78d729534e3e 100644
--- a/drivers/resctrl/Makefile
+++ b/drivers/resctrl/Makefile
@@ -7,5 +7,6 @@ ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
 obj-$(CONFIG_RISCV_CBQRI_DRIVER)		+= cbqri.o
 cbqri-y						+= cbqri_devices.o
 cbqri-$(CONFIG_RISCV_CBQRI_RESCTRL_FS)		+= cbqri_resctrl.o
+cbqri-$(CONFIG_RISCV_CBQRI_CAPACITY)		+= cbqri_capacity.o
 
 ccflags-$(CONFIG_RISCV_CBQRI_DRIVER_DEBUG)	+= -DDEBUG
diff --git a/drivers/resctrl/cbqri_capacity.c b/drivers/resctrl/cbqri_capacity.c
new file mode 100644
index 000000000000..2172432eb328
--- /dev/null
+++ b/drivers/resctrl/cbqri_capacity.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Platform driver for a RISC-V CBQRI capacity controller that backs a CPU
+ * cache. The controller is described in device tree by the generic
+ * "riscv,cbqri-capacity-controller" compatible together with a phandle to the
+ * cache node it governs. The driver hands it to the CBQRI core, which probes
+ * the capabilities register and exposes a controller that supports allocation
+ * as the resctrl cache allocation resource for that cache.
+ */
+
+#define pr_fmt(fmt) "cbqri-capacity: " fmt
+
+#include <linux/cacheinfo.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/ioport.h>
+#include <linux/mod_devicetable.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/riscv_cbqri.h>
+#include <linux/types.h>
+
+static int cbqri_capacity_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cbqri_controller_info info = {};
+	struct device_node *cache_np;
+	cpumask_var_t cpu_mask;
+	struct resource *res;
+	u32 rcid_count, cache_level;
+	int cache_id, cpu, ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	ret = of_property_read_u32(dev->of_node, "riscv,cbqri-rcid", &rcid_count);
+	if (ret) {
+		dev_err(dev, "missing riscv,cbqri-rcid\n");
+		return ret;
+	}
+
+	cache_np = of_parse_phandle(dev->of_node, "riscv,cbqri-cache", 0);
+	if (!cache_np) {
+		dev_err(dev, "missing riscv,cbqri-cache phandle\n");
+		return -EINVAL;
+	}
+
+	ret = of_property_read_u32(cache_np, "cache-level", &cache_level);
+	if (ret) {
+		dev_err(dev, "%pOF: missing cache-level\n", cache_np);
+		goto out_put;
+	}
+
+	if (!zalloc_cpumask_var(&cpu_mask, GFP_KERNEL)) {
+		ret = -ENOMEM;
+		goto out_put;
+	}
+
+	/*
+	 * Associate the controller with its cache instance via
+	 * cacheinfo. The matching cache provides the cache id and the
+	 * set of harts that share the cache.
+	 */
+	cache_id = -1;
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, cache_level);
+
+		if (ci && ci->fw_token == cache_np) {
+			cache_id = ci->id;
+			cpumask_copy(cpu_mask, &ci->shared_cpu_map);
+			break;
+		}
+	}
+	cpus_read_unlock();
+
+	if (cache_id < 0) {
+		dev_err(dev, "%pOF: no online hart reports an L%u cache for this node\n",
+			cache_np, cache_level);
+		ret = -ENODEV;
+		goto out_free;
+	}
+
+	info.type = CBQRI_CONTROLLER_TYPE_CAPACITY;
+	info.addr = res->start;
+	info.size = resource_size(res);
+	info.rcid_count = rcid_count;
+	info.cache_id = cache_id;
+
+	ret = riscv_cbqri_register_cc_dt(&info, cache_level, cpu_mask);
+	if (ret) {
+		dev_err(dev, "failed to register capacity controller: %d\n", ret);
+		goto out_free;
+	}
+
+	dev_info(dev, "registered L%u capacity controller at %pa (cache_id=%d, rcid=%u)\n",
+		 cache_level, &info.addr, cache_id, rcid_count);
+
+out_free:
+	free_cpumask_var(cpu_mask);
+out_put:
+	of_node_put(cache_np);
+	return ret;
+}
+
+static const struct of_device_id cbqri_capacity_of_match[] = {
+	{ .compatible = "riscv,cbqri-capacity-controller" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, cbqri_capacity_of_match);
+
+static struct platform_driver cbqri_capacity_driver = {
+	.probe	= cbqri_capacity_probe,
+	.driver = {
+		.name		= "cbqri-capacity",
+		.of_match_table	= cbqri_capacity_of_match,
+		/*
+		 * The controller is registered permanently into the
+		 * CBQRI core for the life of the system. Block unbind
+		 * so userspace cannot leave a dangling controller.
+		 */
+		.suppress_bind_attrs = true,
+	},
+};
+
+/*
+ * Register at device_initcall so probe runs before the CBQRI core's
+ * late_initcall which walks the cbqri_controllers list.
+ */
+builtin_platform_driver(cbqri_capacity_driver);

-- 
2.43.0

