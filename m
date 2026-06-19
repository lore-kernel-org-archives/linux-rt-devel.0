Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D686929D26E;
	Fri, 19 Jun 2026 18:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893790; cv=none; b=Zy9o+SgcukXb1YwPUvAy3Hq6h3EkOWX6G5k+ArZrMUdejlTketouxz2grUDeLfb/fSpJobrjr1lA/2H1NYLBUd28YPHYN91nKwR6XVRLUyeMkBChW1rNOWpW7ptfoAGr5JNvPpmmRjgBGfN2eBEMBnQx90q6zIqo0kLyIhPtCKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893790; c=relaxed/simple;
	bh=58g1568NRL7/SI4d2HoFSQSOKccqgmn0k03hr3pJQEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mD1p0qbDOzSnVoh76vIktSyjZ1oJTrsgIRZIgWR4F0zgOYh4S0KW2OvJaNpu93bGFcjsM1Xr3ePk//Idjy1a0P/cqNXS0uuDaN2aUnsx7S4yYPso2XmedCTG7m7yO5+uSzUNemVUwIaKycDC9QR0PisHyN3QXuuT0yPTo5cznaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=as0UcEKL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="as0UcEKL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1471F00ADB;
	Fri, 19 Jun 2026 18:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781893788;
	bh=SoMF0NvEK/nHml8RMjqK0ASTpVqLJvBd+3O6LznwQbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=as0UcEKL9AETztzpuRo62Bcy+ulQ8ioG2g5mSCBX2Y6WnqJ/NRy0Bm1jShvh6LOos
	 MpIGUUtOQxYNY2W/bxbtHxZ5ew6DpxJnPlnfx1wX8r29oISFvTjHKLHHSFgYFTnM+R
	 rrwVIsXaLjd2aRMMwQRjWVzL+C2H8CovvhlnRNbErgB7W0sH1A8IRNrtX8oXoySmqm
	 o/8z/3Mz6FixtEQCFQKCCFFtZgvE77HWRaB2ObFQqvm+loA2PYkK6U8UC2TFiK3PSU
	 6JMJBEc2iNlaMj0NZkZPftDtTAEP+MgbMkjuqzozmxumO7/oLa/EJrS474HEiYFw0Z
	 6Xlq9CFGgdM9Q==
From: Drew Fustini <fustini@kernel.org>
Date: Fri, 19 Jun 2026 11:29:37 -0700
Subject: [PATCH 2/8] riscv: Detect the Ssqosid extension
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260619-dfustini-atl-sc-cbqri-dt-v1-2-e79a7723fab0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637; i=fustini@kernel.org;
 h=from:subject:message-id; bh=58g1568NRL7/SI4d2HoFSQSOKccqgmn0k03hr3pJQEU=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWSZds2Uvz1x5Y/FFoGsjL3vPksvY/vm4yf6fbb0bfss9
 RUHrHae7ChlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBM5Ks/I8Nxhq3f9gpGmqT3
 HknrO6T07v6lH3Hc58/oX7NwbJ7/nXshw//E1mOrTPgfTkmqci9UOvPcPejd/+8zc05Pf5/x6fR
 Ps3OsAA==
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
index 7ef8e5f55c8d..b83dae5cebb9 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -112,6 +112,7 @@
 #define RISCV_ISA_EXT_ZCLSD		103
 #define RISCV_ISA_EXT_ZICFILP		104
 #define RISCV_ISA_EXT_ZICFISS		105
+#define RISCV_ISA_EXT_SSQOSID		106
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index f46aa5602d74..668a7e71ff1c 100644
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
2.43.0

