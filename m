Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3C333CE80;
	Fri, 19 Jun 2026 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893805; cv=none; b=Q9CIROMaVcZi3tYJ7jjYXEf7gJ4z7AwWtr/GVZ3L5z3kl+k1WAc60g9po4C5g3ntgVruxvfERmjkTzPjNvoe25v+DuzlRLyimhrthi7JhALu1R7WqdTQUQmnEAGOh7c62tnXxUMVWPALGx0AFZpnOEXKcOjy596vi+IwmWXHPVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893805; c=relaxed/simple;
	bh=JESD424JRusl50/42AHZu3nZKjE9cJpzGOgU+hfilZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttVorcaR6cACz4ZmJD81EBH9TEFkAPQen86rXbJhS2RgYmY0YcNGjlHAPdEXJjR0BV21M+ebvTmN8h4p40bvNaZZYnWS8BqEFXafsoKytqsawALsqsYj7bg55xG3t4SW9Ibf1fYwELEB0GPC62Sd/CZ3UhNRC75YjuUPiHfacug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/HQWJ3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/HQWJ3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C731F00A3D;
	Fri, 19 Jun 2026 18:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781893793;
	bh=3FNd65+Kd2T2L4uR4tw6oB8KAJNneqNpwKMKAP99qXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=c/HQWJ3B2rC4Nz9HerwDSmZAgFIM9duTwj8XHZ74vWJwEDoVNKXxmq+UgSHkio2HK
	 k9UhKhZb9ryVhITFuYDBwShuZ/ONnGPWKm6IjOHB44DKLRpuaEqND5l4Clj3e5jAPP
	 9tL3gAsGuW4I7w2XX3AjxeEXy4cwJGQ7ypGMZ+sLQC+vd96LbYfz/YPTmmRQFEJT5E
	 GvWhcMGNN/27wp+HjMWiiT2lsB1eqhL4GUSMokjX4GnKZBxNkBsNJHfjZtOxLwR8vW
	 1mUayOc9zLjRpPEurswbpvJnawkV6XVDcd1v8vGDoslTPAcjTADxo7gYuaFSsUOIN3
	 PhJUCNIsvaBbw==
From: Drew Fustini <fustini@kernel.org>
Date: Fri, 19 Jun 2026 11:29:42 -0700
Subject: [PATCH 7/8] dt-bindings: riscv: Add generic CBQRI controller
 binding
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dfustini-atl-sc-cbqri-dt-v1-7-e79a7723fab0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5768; i=fustini@kernel.org;
 h=from:subject:message-id; bh=JESD424JRusl50/42AHZu3nZKjE9cJpzGOgU+hfilZ0=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWSZds3aXFpS96t9qe0q39xnhpLvJvwyCOH4Kt2hfezTz
 V+3HsV4dpSyMIhxMciKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAm8vo6I8O2lvXvomqMJiaa
 Cfd/cXbrO2h/5l/mjqrd70q+b3i4eV4+I8PGipXJ4l5z1RZ+XD73aTmbpvz7B162f2Vjp+1Sife
 8Ls8BAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Document the generic "riscv,cbqri-capacity-controller" and
"riscv,cbqri-bandwidth-controller" compatibles for controllers that
implement the RISC-V CBQRI specification, together with the common
riscv,cbqri-rcid / riscv,cbqri-mcid properties and the optional
riscv,cbqri-cache phandle that links a capacity controller to the cache
node whose capacity it allocates.

The CBQRI register interface is architected, so an implementation pairs
a device-specific compatible (for example "tenstorrent,ascalon-sc-cbqri")
with the generic one as a fallback. This lets a single binding and driver
cover every CBQRI controller without a per-vendor schema.

Assisted-by: Claude:claude-opus-4-8
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 .../devicetree/bindings/riscv/riscv,cbqri.yaml     | 109 +++++++++++++++++++++
 MAINTAINERS                                        |   1 +
 2 files changed, 110 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml b/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
new file mode 100644
index 000000000000..cf007dcac0d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/riscv,cbqri.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Capacity and Bandwidth Register Interface (CBQRI) controller
+
+description: |
+  The RISC-V CBQRI specification defines capacity-controller and
+  bandwidth-controller register blocks that allow cache capacity and memory
+  bandwidth to be allocated to resource control IDs (RCIDs) and monitored per
+  monitoring counter ID (MCID):
+  https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
+
+  The register interface is architected, so a CBQRI controller is described by
+  a generic "riscv,cbqri-capacity-controller" or "riscv,cbqri-bandwidth-controller"
+  compatible. A device-specific compatible should be listed as the first entry
+  so a driver can apply integration-specific behavior (for example, the cache
+  level the controller backs).
+
+  A single controller register block may implement resource allocation and/or
+  usage monitoring: a capacity controller can allocate cache capacity to RCIDs
+  and monitor capacity usage per MCID, and a bandwidth controller likewise for
+  memory bandwidth. The allocation and monitoring register sets live in the
+  same block, and which of them a controller actually implements is discovered
+  at runtime from its capabilities register. The compatible therefore names the
+  controller type only; it does not distinguish allocation-only, monitoring-only
+  or combined controllers, and no property declares monitoring support.
+
+maintainers:
+  - Drew Fustini <fustini@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - description: Tenstorrent Ascalon Shared Cache
+            const: tenstorrent,ascalon-sc-cbqri
+          - const: riscv,cbqri-capacity-controller
+      - enum:
+          - riscv,cbqri-capacity-controller
+          - riscv,cbqri-bandwidth-controller
+
+  reg:
+    maxItems: 1
+    description:
+      The CBQRI controller register block.
+
+  riscv,cbqri-rcid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The maximum number of RCIDs the controller supports. RCIDs are the
+      resource-control IDs that allocation operations target.
+
+  riscv,cbqri-mcid:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The maximum number of MCIDs the controller supports. MCIDs are the
+      monitoring-counter IDs that usage-monitoring operations target; present
+      on controllers that implement monitoring.
+
+  riscv,cbqri-cache:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the cache node whose capacity this controller allocates.
+      Applies to capacity controllers that back a CPU cache; the cache level
+      and the harts sharing the cache are taken from that node's cache
+      topology.
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  # The Ascalon SC is a fixed cache capacity-allocation controller: the driver
+  # cannot register it without the RCID count and the cache it backs.
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: tenstorrent,ascalon-sc-cbqri
+    then:
+      required:
+        - riscv,cbqri-rcid
+        - riscv,cbqri-cache
+
+additionalProperties: false
+
+examples:
+  - |
+    l2_cache: l2-cache {
+        compatible = "cache";
+        cache-level = <2>;
+        cache-unified;
+        cache-size = <0xc00000>;
+        cache-sets = <512>;
+        cache-block-size = <64>;
+    };
+
+    cache-controller@a21a00c0 {
+        compatible = "tenstorrent,ascalon-sc-cbqri",
+                     "riscv,cbqri-capacity-controller";
+        reg = <0xa21a00c0 0xf40>;
+        riscv,cbqri-rcid = <16>;
+        riscv,cbqri-cache = <&l2_cache>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 85d50efb6e5f..f8b995420c11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23296,6 +23296,7 @@ M:	Drew Fustini <fustini@kernel.org>
 R:	yunhui cui <cuiyunhui@bytedance.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
 F:	arch/riscv/include/asm/qos.h
 F:	arch/riscv/include/asm/resctrl.h
 F:	arch/riscv/kernel/qos.c

-- 
2.43.0

