Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4809D4D179A;
	Thu, 17 Sep 2026 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663252; cv=none; b=j5BSbO20DpyZ9OyVARrs6sSVgaxlu/+PtE+toCHC2xkue6GyV4pXBW5YAMtFPLWemXtGA0z4RUTiFFyMiS1zibIOkE7v4n9PVVs6ZpZMyLp27ei77WGuLTsOzmYmLfHafY9YO+Ud/+6zROuTNy2wUteTWfaHP90GOIeWnrgmIlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663252; c=relaxed/simple;
	bh=8gd2DiQMGEItozKo4O59vb2wFFEJ1o4qZdVPzkL/Tnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fEdsn/ymmoKBX4kbomEBlSm9bbDpdufQVnuXL9J5wT1p4uIi9pnOC8ysZhzxz4hf5SDdM/gbZwC3mViruNpY/bzQTTzMZSLI3DTGyA1GkQlNvQ66dL+0IgWLYSpzKwEhPTHpvcOHvz86q3Dma9ddd1Z9sske5/vUK4q2Gjk9QjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S48h55Lf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S48h55Lf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D9C1F00A00;
	Thu, 17 Sep 2026 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663249;
	bh=YyijQXay86LO7WuPF3AZ9mmm2+iWcDQRp4YaV1G9MDQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=S48h55LfkH2XX5pNuCu6yu15mtAepY0fDUh6GFcWaNJBztQM3rhPOTA3iRH6jxWNC
	 0CJDiWamAdM1TS5wwEAy9h5haqHwQEPnlRM/gDJvPWVX46h4lwFP5gz3i9aNXn4njq
	 RWC5NE29htYtCb9aD6zcG2VUr26NJxCo6opg0s8Wmp1KKRBs1ioU+PhvywRxChBPwO
	 H9xQSQEXmLrVX8aDarVcLWA/86tcEvoQnNTDc0tD75mFVlKZC4BE++sEuZyHZC8vjx
	 Rqx1dkLOwoE3Sl2NUnSQmzcnTtolBMDvVhqBJ7NS063URIj5UaeHGS2knaR6S4VMiS
	 WjF7jWfxYigYg==
From: Drew Fustini <fustini@kernel.org>
Date: Thu, 17 Sep 2026 09:39:40 -0700
Subject: [PATCH v8 4/5] dt-bindings: riscv: Add binding for CBQRI
 controllers
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-dfustini-atl-sc-cbqri-dt-v8-4-7964e8d73fe8@kernel.org>
References: <20260917-dfustini-atl-sc-cbqri-dt-v8-0-7964e8d73fe8@kernel.org>
In-Reply-To: <20260917-dfustini-atl-sc-cbqri-dt-v8-0-7964e8d73fe8@kernel.org>
To: Adrien Ricciardi <aricciardi@baylibre.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, Albert Ou <aou@eecs.berkeley.edu>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
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
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Tony Luck <tony.luck@intel.com>, Vasudevan Srinivasan <vasu@rivosinc.com>, 
 Ved Shanbhogue <ved@rivosinc.com>, Weiwei Li <liwei1518@gmail.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, 
 Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
 Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4705; i=fustini@kernel.org;
 h=from:subject:message-id; bh=8gd2DiQMGEItozKo4O59vb2wFFEJ1o4qZdVPzkL/Tnk=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWStkeBdzrlh6f65z6LXPa2/qpTM53K/S1P7u8za91JC5
 x33yHyW6yhlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMZFsswz+9jC+vc8UZbHrm
 r1qvr8tVuMkx58yf0gdqyXt/Hf1xTukFI8MlQduL10q1n9z/lb/8f2Qqc4CZd6vD3zMThEzO3T2
 00ZkJAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Document the device tree binding for RISC-V CBQRI capacity and bandwidth
controllers. Each controller is named by a device-specific compatible
followed by the generic compatible. The binding also describes the
common riscv,cbqri-rcid and riscv,cbqri-mcid properties, and the
optional riscv,cbqri-cache phandle that links a capacity controller to
the cache whose capacity it allocates.

Assisted-by: LLM
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
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
index db0799d8cbf8..c362d53ed355 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23569,6 +23569,7 @@ M:	Drew Fustini <fustini@kernel.org>
 R:	yunhui cui <cuiyunhui@bytedance.com>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
+F:	Documentation/devicetree/bindings/riscv/riscv,cbqri.yaml
 F:	arch/riscv/include/asm/qos.h
 F:	arch/riscv/include/asm/resctrl.h
 F:	arch/riscv/kernel/qos.c

-- 
2.43.0

