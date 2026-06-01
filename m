Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7573FF8B3;
	Mon,  1 Jun 2026 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346199; cv=none; b=bJmnFoFi6hlZXRiEqp9l8BjIA7lCYtN4tYfhi9qUJYhoo/VBu0wktuuTqc4h6X2qdAeO8BkIyt+oCwUcMbkIbNzKkNjB+/rbYhZjsbK7zdmqJHLPLXdTHkzxQywRJtkJ7haaz5jnbZHG822zx/seFnQja8lk+SpVY4SVWjYeZJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346199; c=relaxed/simple;
	bh=J9k+kdxn9VBh2gcTNNCv4EIpVuWkTdzFDdzbka+fNg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YnDatMSO2uSFiBpp43ANarmIGkac7wMf1r+2OR+uwbnWwd08Nj4CJV9m4ztwtjvmsZIV2sxcVCDimTWixQq49LiDcOGaY/aIvB8G4l4ME7pL3i+le3kyzy600soUx5cGH8gAU3VDpBvpJJPLZ82AGEIgdv0w3qXTO8x6ot/GyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjEVZgO5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjEVZgO5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE861F008A2;
	Mon,  1 Jun 2026 20:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780346197;
	bh=6zw1YkJkBQFnyL3MGMXlh5Ks8e9UJTAJTqAov2MLs5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EjEVZgO5AQLGfNQ7aScZUx87ZdJYswihpQzcWMZZQuPlhoi2tnoB0KR1PPb0j6Iqj
	 wr+l/gIFy2z9I+lRYHbmulwPxQETmhnJ1q7nE3DT7NhbwQR9t8IbRjJ/CBjZ8hFcuV
	 Hrmr/5VmiDL+bwWxMK3oQcMos3FwHFVsDYo6FW9gFIR+2PfZk9vMcUV84N1LF+KFYm
	 51NZzD9koISz6UXrmyViqNr0tQYW7eC/zow9Zrdqe8m1W9ISr/APConh2pjVZYBTc4
	 xJo4B6gvth0JVcq1pgGCsys3XFJrXRLmDASaOUUNI2BjW1m/Rwjig12G4Cr4zo+fp7
	 lDsjJL23LGBKg==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 01 Jun 2026 13:36:11 -0700
Subject: [PATCH RFC v6 17/18] ACPI: RISC-V: Add support for RISC-V Quality
 of Service Controller (RQSC)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-17-baf00f50028a@kernel.org>
References: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-0-baf00f50028a@kernel.org>
In-Reply-To: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-0-baf00f50028a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1706; i=fustini@kernel.org;
 h=from:subject:message-id; bh=J9k+kdxn9VBh2gcTNNCv4EIpVuWkTdzFDdzbka+fNg8=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTJvnW5EnBOVuGM9dw7i1t+JossSmJa3bls+hyV5zZia
 xw+PDfK7ihlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMhOUqI8MFLenMt4F71tQv
 WjeNX+H1iXdX0u1W9/rO2tN3e9NZDYsCRoZNPLI1KXeC9J+mn7NZJiib31hRsN64LXFrs8eVc3O
 EfzAAAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Call acpi_parse_rqsc() from acpi_arch_init() to discover CBQRI
controllers when an RQSC table is present.

Gate on CONFIG_RISCV_CBQRI_DRIVER rather than CONFIG_RISCV_ISA_SSQOSID
so a kernel built with the ISA extension but without the driver (e.g.
RESCTRL_FS=n) does not walk the table and print a misleading "found 0
CBQRI controllers" line on every boot.

Link: https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
Link: https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/acpi/riscv/init.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index 7c00f7995e86..129ebfae28be 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -5,11 +5,32 @@
  */
 
 #include <linux/acpi.h>
+#include <linux/cleanup.h>
 #include "init.h"
+#include "rqsc.h"
 
 void __init acpi_arch_init(void)
 {
 	riscv_acpi_init_gsi_mapping();
+
 	if (IS_ENABLED(CONFIG_ACPI_RIMT))
 		riscv_acpi_rimt_init();
+
+	if (IS_ENABLED(CONFIG_RISCV_CBQRI_DRIVER)) {
+		struct acpi_table_header *rqsc __free(acpi_put_table) = NULL;
+		acpi_status status = acpi_get_table(ACPI_SIG_RQSC, 0, &rqsc);
+
+		if (status == AE_NOT_FOUND) {
+			/* RQSC is optional. Silence on systems without it. */
+		} else if (ACPI_FAILURE(status)) {
+			pr_err("RQSC: failed to get table: %s\n",
+			       acpi_format_exception(status));
+		} else {
+			int rc = acpi_parse_rqsc(rqsc);
+
+			if (rc < 0)
+				pr_err("RQSC: failed to parse table: %d\n",
+				       rc);
+		}
+	}
 }

-- 
2.43.0

