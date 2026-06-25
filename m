Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501E1374192;
	Thu, 25 Jun 2026 01:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782351647; cv=none; b=FbPXjXaE+e48sGQR6bMcxf92xrV+dGWcnrrxhTuwJuebJd+CiJ10ifHYm82vviuUamMBjqvlQXCIFzOIkEo8ai9YZIdBCE4RCbKx2JdYOJnWJ23GV72sO4xcssVlY0YLqNL+pEUgLfGF7ghkGrtQ88bqIaJ9pp1Me6AF9Vv5e7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782351647; c=relaxed/simple;
	bh=x9zob8Q+My3JqC1K8N4GCfe7DNcEjyxyU00/yAg+r/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZV0I59Z0gs4Y1iDxdh0d+HAiVD8PvLV963/DJYL0+K7IN+CTMpGut1mzfiYWey1vdSz6ewMcO1RcmsKTQnRx+QPUFj5AAjPc4ztxU8p4s9YYwLnWXY1DIl4TxTKlpC8RF52nkOpSg1u/J2D7OBx3ZNVepbi/eV8Yi3wBdlHlvLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDWOSHth; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDWOSHth"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C831F00ADB;
	Thu, 25 Jun 2026 01:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782351646;
	bh=P7Fx5JxHcGHBnFRKWSclF7q97XV2lAuqKNGJj7WnUNk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=HDWOSHthHBds1VCbCcStWcybX0c43Mi3G/hDOuovnSnaX/QKUfIfuCGPi02ButVJ4
	 dUMCeEQFlEzb1xlGnNeNC/wxN0N89PFBcSzPis9pNhJkGGgzLqP1nNcstxCOocwZQv
	 CJTjRGELLFRF7beR+h7JDRaogzXfwWWVZB/sG0r19OVIcRnru6Pl7TpnJEZ8AySRKS
	 vJ7oGrsKrMi7Aoxooi8q98TgkqghqKYSbCZthi6aM+IWpa5pkws17jOT2cQHU0tSER
	 9LxsxD4DlszETUhULK4Zh0K3eNz6kOnIqXKmO0h1MxES+7Bz9Ugf9mHxOOvoOvKHqQ
	 RXgF29FO/zIDA==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 24 Jun 2026 18:38:30 -0700
Subject: [PATCH v2 2/8] riscv: Detect the Ssqosid extension
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260624-dfustini-atl-sc-cbqri-dt-v2-2-2f8049fd902b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1749; i=fustini@kernel.org;
 h=from:subject:message-id; bh=x9zob8Q+My3JqC1K8N4GCfe7DNcEjyxyU00/yAg+r/U=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWTZtEt553RHh3wKtsnhjm1OO5Q6y25aXWld5t9J/8z3T
 PTwOn2xo5SFQYyDQVZMkWXTh7wLS7xCvy6Y/2IbzBxWJpAhDFycAjCR9n8M/0zCnV4+ufQ1x1Jd
 /rDe1a+HFnlLLzZ0DJF3LPD0CH7hsZCR4WPFJtOODp0dbcH+0/neCZ5rlTnJrmCyT2C+cMoDucB
 kLgA=
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Ssqosid is the RISC-V Quality-of-Service (QoS) Identifiers specification
which defines the Supervisor Resource Management Configuration (srmcfg)
register.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Co-developed-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 7ef8e5f55c8dcf26e3dcc676db32c2f16b7e7f5a..b83dae5cebb99269902279faa3c03fd23f7d4342 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -112,6 +112,7 @@
 #define RISCV_ISA_EXT_ZCLSD		103
 #define RISCV_ISA_EXT_ZICFILP		104
 #define RISCV_ISA_EXT_ZICFISS		105
+#define RISCV_ISA_EXT_SSQOSID		106
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index f46aa5602d74d3322960559fb73bb50152909344..668a7e71ff1c64e8bd36ba6ea94f8a5dd4600016 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -582,6 +582,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_DATA(ssqosid, RISCV_ISA_EXT_SSQOSID),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svade, RISCV_ISA_EXT_SVADE),
 	__RISCV_ISA_EXT_DATA_VALIDATE(svadu, RISCV_ISA_EXT_SVADU, riscv_ext_svadu_validate),

-- 
2.34.1

