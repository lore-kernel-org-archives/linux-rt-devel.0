Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAE4356759;
	Thu, 30 Jul 2026 01:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373912; cv=none; b=uB8YdEv604R1t5f30hCKmxzdjtkDhcLJTPwA3XOtEsGsbN4dsOjTj8Xh+Jv2kNohVE9jLhBUuzWfbezJqOcho69Pv3OPoJA0OEMkI4/kcoYK+8FNBonZaI0Y4lYqTaG+zkRd74DTjkP97PTYgCvlGiZ5WeqMJMeTUTky+2X4W5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373912; c=relaxed/simple;
	bh=2zNvZuyr0PVv++Ei5cRqnrKkzLMSUKvDNhcp+pCEJ70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rafbl0bpzBefIp5FZjsxN9EIQ0seYzViD9Iy1YQ+z0u/IbX+nsWhsPsXKXvgTjP6rfVzo5gU2Z6COmHvQBKaKWI/+zSh7pfaM4YI/suDVRBipPV+ND8kcNFOfR3vl3s5rAF2lDvFe9hEw2iJQf4SPj13k5/i2ZApDAMfl+3qDJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BII0nMz8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BII0nMz8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B4C1F0155A;
	Thu, 30 Jul 2026 01:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373910;
	bh=ASHaEVp7Ef8aMRTywEhzYCZbjohqmo7/qWu46KKWNi8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BII0nMz8Mu7F+NC64lcm9CzPRw4ma2Kp5Vmkpv9FIO3CwX7wwyLLYLN2MLwGuVMoZ
	 4cszUfR/41v7aomLSnuB/KJW3kyOqMe0vQer0PqHwXrwcBaLBJ0qR/Dv23wXMG4Gkn
	 ZOEuhD/WGDTZqUHfwwjQF+f/edgQnwtyKfC6SKABJ4kJYhQvj/rz3INqfNYy60VxxT
	 BbG795Cewmf97fgp1L9cfQ2tepRTFdFArnGS32RYzAROITGwbIxp1we1We1fpx7Fge
	 dtGrlrUMQR5LgdaERpf6N9eZsFKID5tyf7EVUnIZrj185N9n7B+RtRGWP+f+pRHy9f
	 L2AQyotCIecGw==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 29 Jul 2026 18:11:35 -0700
Subject: [PATCH v6 8/8] riscv_cbqri: Add CBQRI capacity allocation platform
 driver
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-dfustini-atl-sc-cbqri-dt-v6-8-7c22b05d461b@kernel.org>
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
In-Reply-To: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
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
 yunhui cui <cuiyunhui@bytedance.com>, 
 Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
 Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6951; i=fustini@kernel.org;
 h=from:subject:message-id; bh=2zNvZuyr0PVv++Ei5cRqnrKkzLMSUKvDNhcp+pCEJ70=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRlLbko1Zih2FMio1PgLpK7M6P3WkhZwfkJ4Tm5f/RzC
 riVjp7sKGVhEONikBVTZNn0Ie/CEq/Qrwvmv9gGM4eVCWQIAxenAEzE7iQjw6+AK5q+Z1vDijJ6
 7R2lr0SkaV2aLerYELKIS8dQlMlkM8P/YmbX8MtBRyJzWL0Vy/q+f8xYWr3puc+JLdvd5tyvqz3
 ACAA=
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add a device-tree platform driver, bound to the generic
riscv,cbqri-capacity-controller compatible, that registers a CBQRI
capacity controller as the resctrl cache-allocation resource for the
cache it governs.

The driver follows the node's riscv,cbqri-cache phandle to that cache,
reads its level, and matches it against cacheinfo to get the resctrl
domain id. It then hands the controller to riscv_cbqri_register_cc_dt()
with the riscv,cbqri-rcid count from the node.

Nothing is vendor-specific, and the DT "reg" is the CBQRI register block
itself, so any SoC that describes a CBQRI capacity controller in device
tree can reuse the driver unchanged.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                      |   1 +
 drivers/resctrl/Kconfig          |  15 +++++
 drivers/resctrl/Makefile         |   1 +
 drivers/resctrl/cbqri_capacity.c | 127 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 144 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7acdab42e9c5..5c4be59b2670 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23367,6 +23367,7 @@ F:	Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
 F:	arch/riscv/include/asm/qos.h
 F:	arch/riscv/include/asm/resctrl.h
 F:	arch/riscv/kernel/qos.c
+F:	drivers/resctrl/cbqri_capacity.c
 F:	drivers/resctrl/cbqri_devices.c
 F:	drivers/resctrl/cbqri_internal.h
 F:	drivers/resctrl/cbqri_resctrl.c
diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
index 617b813b9808..689a91873d7b 100644
--- a/drivers/resctrl/Kconfig
+++ b/drivers/resctrl/Kconfig
@@ -41,6 +41,21 @@ menuconfig RISCV_CBQRI
 	  allocation through the resctrl filesystem at /sys/fs/resctrl when
 	  RESCTRL_FS is also enabled.
 
+if RISCV_CBQRI
+
+config RISCV_CBQRI_CAPACITY
+	bool "RISC-V CBQRI cache capacity-allocation controller"
+	depends on OF
+	help
+	  Enable driver for a RISC-V CBQRI capacity controller that
+	  governs a CPU cache, matching the "riscv,cbqri-capacity-controller"
+	  compatible. The controller's cache phandle gives the cache level and
+	  id, which the driver registers as a resctrl cache-allocation resource.
+
+	  Say N unless your device tree describes a CBQRI capacity controller.
+
+endif
+
 config RISCV_CBQRI_RESCTRL_FS
 	bool
 	default y if RISCV_CBQRI && RESCTRL_FS
diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
index a7631712dba9..c8339113ef1f 100644
--- a/drivers/resctrl/Makefile
+++ b/drivers/resctrl/Makefile
@@ -7,3 +7,4 @@ ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
 obj-$(CONFIG_RISCV_CBQRI)			+= cbqri.o
 cbqri-y						+= cbqri_devices.o
 cbqri-$(CONFIG_RISCV_CBQRI_RESCTRL_FS)		+= cbqri_resctrl.o
+cbqri-$(CONFIG_RISCV_CBQRI_CAPACITY)		+= cbqri_capacity.o
diff --git a/drivers/resctrl/cbqri_capacity.c b/drivers/resctrl/cbqri_capacity.c
new file mode 100644
index 000000000000..0670a676bdb1
--- /dev/null
+++ b/drivers/resctrl/cbqri_capacity.c
@@ -0,0 +1,127 @@
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
+#include <linux/device-id/of.h>
+#include <linux/ioport.h>
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
+	/*
+	 * Associate the controller with its cache instance via cacheinfo.
+	 * The matching cache provides the cache id used as the resctrl
+	 * domain id.
+	 *
+	 * Taking the first leaf at the level is sufficient, because fw_token
+	 * is keyed on the DT cache node, so sibling leaves of a split cache
+	 * share it, and riscv,cbqri-cache must reference a unified shared
+	 * cache (cache-unified), not a split private L1.
+	 */
+	cache_id = -1;
+	cpus_read_lock();
+	for_each_online_cpu(cpu) {
+		struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, cache_level);
+
+		if (ci && ci->fw_token == cache_np) {
+			cache_id = ci->id;
+			break;
+		}
+	}
+	cpus_read_unlock();
+
+	if (cache_id < 0) {
+		dev_err(dev, "%pOF: no online hart reports an L%u cache for this node\n",
+			cache_np, cache_level);
+		ret = -ENODEV;
+		goto out_put;
+	}
+
+	info.type = CBQRI_CONTROLLER_TYPE_CAPACITY;
+	info.addr = res->start;
+	info.size = resource_size(res);
+	info.rcid_count = rcid_count;
+	info.cache_id = cache_id;
+
+	ret = riscv_cbqri_register_cc_dt(&info, cache_level);
+	if (ret) {
+		dev_err(dev, "failed to register capacity controller: %d\n", ret);
+		goto out_put;
+	}
+
+	dev_info(dev, "registered L%u capacity controller at %pa (cache_id=%d, rcid=%u)\n",
+		 cache_level, &info.addr, cache_id, rcid_count);
+
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

