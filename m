Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2214378822;
	Thu, 25 Jun 2026 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782351659; cv=none; b=HLnTgJznEq7nZT2X8VdgfsMLBhDwk4UXxXpv4FdpIDkqcEKMe14/zAh4OGL4oulnaCfbYHXheOEBL4Sq8rtSX1J2Xixu0/xOWKMyn312OVc9/lljLWh7svXPmx5qojFHyjkFzvmiWS6a/l7geHOXECJ1oduvIOHalXW0rKl82D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782351659; c=relaxed/simple;
	bh=xAQHu7pJE18WEQ3dc4i0maZ3ITHgzD0oaXVgeAHUtfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OUmNqyRiWxuY4mD/4C2FNSTi4/FPRxcFVMaWF9Av8cB7WoyXXSdQJMw4J9cVpfxAfd+s/g9j+L/zwhogl0Nnq+HTnX/qcVZDHJ9vG2zE0nkH1YCUa+UzTpB5WV66AlwtEzOxuSLhtXMSYeuc3wTAszDeUfpL8hu0jQNxe1KT9uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kEGtJ5vw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kEGtJ5vw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677A91F00ADF;
	Thu, 25 Jun 2026 01:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782351648;
	bh=jY1wCdA0Fk09EfrpeC8Vj8YPRZgGaxvl5ff1BiLJNOE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kEGtJ5vw2qlAVAg0/xQFkFossP181BbZte4FFcKpPXSYbt+Y4klMeeKbeoA8sjfOy
	 j0yTyntq7OjIEj/WxabUN6xjVR9U7Yu5VGbdGvC3E+Ak/I8U6XheEoavREQZd8acPU
	 jo3TXpW3MUrTUX8ebm97GFfC4KfDLJBnV9V90P3GNyX7hHnVODbepQb5GAaqfX1CCB
	 zkU56as+RxjsbSLN+gQPUppsh0toQq7uR9yTSotQyODqNGAVUxL2HUg/GnBFU0T7YW
	 hQSNv7hOE8l86uSfDpkeCFykgpTSwszompCv9ODSCmhu086hnQW8PNCBKQYrGOiHm0
	 lKrya17VpdTKQ==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 24 Jun 2026 18:38:35 -0700
Subject: [PATCH v2 7/8] dt-bindings: riscv: Add generic CBQRI controller
 binding
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-dfustini-atl-sc-cbqri-dt-v2-7-2f8049fd902b@kernel.org>
References: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org>
In-Reply-To: <20260624-dfustini-atl-sc-cbqri-dt-v2-0-2f8049fd902b@kernel.org>
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
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4740; i=fustini@kernel.org;
 h=from:subject:message-id; bh=xAQHu7pJE18WEQ3dc4i0maZ3ITHgzD0oaXVgeAHUtfs=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWTZtEvHPuO0MF8WdHDaBJENvazG5Vednwj5nbj2yPlr3
 BTOeRuTOkpZGMQ4GGTFFFk2fci7sMQr9OuC+S+2wcxhZQIZwsDFKQATaQtg+O92pGhyjdzNCQXa
 HZ2T+S+liu05IHgj0v7I2k9MGZ//THIAqlDXv/9G3EzTMMjA/uj7JP//fDMfnpF6w6IVMH3+NI8
 1vAA=
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Document the generic compatibles for capacity and bandwidth controllers
that implement the RISC-V CBQRI specification. The binding also
describes the common riscv,cbqri-rcid and riscv,cbqri-mcid properties,
and the optional riscv,cbqri-cache phandle that links a capacity
controller to the cache whose capacity it allocates.

Assisted-by: Claude:claude-opus-4-8
Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 .../devicetree/bindings/riscv/riscv,cbqri.yaml     | 97 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 98 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml b/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..5d6be645381780e187b39e60c3bb487fdf2cfb69
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/riscv,cbqri.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Capacity and Bandwidth QoS Register Interface (CBQRI) controller
+
+description: |
+  The RISC-V CBQRI specification defines capacity-controller and
+  bandwidth-controller register blocks that allocate cache capacity and memory
+  bandwidth to resource-control IDs (RCIDs) and monitor usage per
+  monitoring-counter ID (MCID):
+  https://github.com/riscv-non-isa/riscv-cbqri/blob/main/riscv-cbqri.pdf
+
+  Allocation and monitoring share one register block, and a controller may
+  implement either or both. A driver discovers which at runtime from the
+  capabilities register, so the compatible names only the controller type. It
+  does not distinguish allocation-only, monitoring-only or combined
+  controllers, and no property declares monitoring support.
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
+      monitoring-counter IDs that usage-monitoring operations target. Present
+      on controllers that implement monitoring.
+
+  riscv,cbqri-cache:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the cache node whose capacity this controller allocates.
+      Applies to capacity controllers that back a CPU cache. The cache level
+      and the harts sharing it are taken from that node's cache topology.
+
+required:
+  - compatible
+  - reg
+
+allOf:
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
index 9e1092165046c773771b055869030bc1bdb64b16..64a95a4d795a57033d3f36200d98cfb4a013ab94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23298,6 +23298,7 @@ M:	Drew Fustini <fustini@kernel.org>
 R:	yunhui cui <cuiyunhui@bytedance.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
 F:	arch/riscv/include/asm/qos.h
 F:	arch/riscv/include/asm/resctrl.h
 F:	arch/riscv/kernel/qos.c

-- 
2.34.1

