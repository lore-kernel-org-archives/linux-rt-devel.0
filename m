Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6E37F8AD;
	Sun, 28 Jun 2026 21:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782681530; cv=none; b=YoNzuhD7MIIo5zcAuDU820DWrCkGme8kxQgF7uuB+ww9n3VE12rOJUHyId1QgvEQ44ky4bxBegTSEIcuc+dKMLnx8UBr2LAD2R2O0E3CBBXeNbB3X2SpWtm8WC9lXGxW9HorFgEQrRMTRIG1g3QB+GTLJVhIPL1KzUvjx/2zBv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782681530; c=relaxed/simple;
	bh=zsLy4be+qGSSdOY88fIZH+FMZosR11q5wcnoQzfCuqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lxlEUNNYcS2V94UFv43bv2GvXjtbrQSqrMxvIgDTdY63z1j+3Wu47C4daQXn7eD6jzOpRKW4WOU/VYmTO3YdtL5joI8ovcLyzOUWSxazusGMioKmt7ppR0exOqFBRfHhxcMeLJ322RRsUXS17GyrCyLcd4uYywsxRH7Ch0XH3kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJ2aPtPN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJ2aPtPN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526581F00ADF;
	Sun, 28 Jun 2026 21:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782681528;
	bh=9dTCVpZ2o0d6cZ2bkua3Fp3iYBjf1tCQZk2/G+Myl7M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZJ2aPtPNQvTx/UHasoqdBQnFQVS/N9TvshjPVJ3DxKyNgSDwfREBSQkXCvc/BTevj
	 IACAcBXVMC/1M8jhpQGVVOHVCfhnzGfmgtaFVLZYUd/JRxy4LR9MCeTxrfDcK45fCc
	 iWyZnuLLhYbvMHjDi57gcv3rZeK7r3dDC16fzJ1bdscV8P+bYXIt2stWCSMuovLUQP
	 UxRfbDNoHz7+RkKo+ovoBXqZxeBN0aMlVzu3poti3KmChNyifsPNw7DOffCqyd0H3Q
	 QTWqU7DylCKn9YpwkBLW9MU6wvdrss/mRDCRqGLyxK+yPP9kG48ZJwlDVPVp5o2iiK
	 hBL7ObzzIHXhw==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 28 Jun 2026 14:18:18 -0700
Subject: [PATCH v3 7/8] dt-bindings: riscv: Add binding for CBQRI
 controllers
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-dfustini-atl-sc-cbqri-dt-v3-7-c9c1342fe3cf@kernel.org>
References: <20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org>
In-Reply-To: <20260628-dfustini-atl-sc-cbqri-dt-v3-0-c9c1342fe3cf@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4668; i=fustini@kernel.org;
 h=from:subject:message-id; bh=zsLy4be+qGSSdOY88fIZH+FMZosR11q5wcnoQzfCuqI=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQ59m/OumJ6Zt+ugLN6TzkCvuiGu3nx81sVuL1zqGF5t
 dhUYHp8RykLgxgXg6yYIsumD3kXlniFfl0w/8U2mDmsTCBDGLg4BWAiPFsYGZ49SinKurYsxDj7
 enhDoOUSjp/3Lk7++UnM8j1nQ/0OzR5GhhZDaTsPOfMH7TxsDw9tNbd7OMmGs/dPt1sM2wzJar0
 nfAA=
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Document the device tree binding for RISC-V CBQRI capacity and bandwidth
controllers. Each controller is named by a device-specific compatible
followed by the generic compatible. The binding also describes the
common riscv,cbqri-rcid and riscv,cbqri-mcid properties, and the
optional riscv,cbqri-cache phandle that links a capacity controller to
the cache whose capacity it allocates.

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
index 000000000000..62d547a0cb96
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
+          - enum:
+              - tenstorrent,ascalon-shared-cache-controller
+          - const: riscv,cbqri-capacity-controller
+      - items:
+          - {}
+          - const: riscv,cbqri-bandwidth-controller
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
+            const: tenstorrent,ascalon-shared-cache-controller
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
+    qos-controller@a21a00c0 {
+        compatible = "tenstorrent,ascalon-shared-cache-controller",
+                     "riscv,cbqri-capacity-controller";
+        reg = <0xa21a00c0 0xf40>;
+        riscv,cbqri-rcid = <16>;
+        riscv,cbqri-cache = <&l2_cache>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 9e1092165046..64a95a4d795a 100644
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
2.43.0

