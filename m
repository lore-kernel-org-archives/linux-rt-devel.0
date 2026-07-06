Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AB544BC87;
	Mon,  6 Jul 2026 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379191; cv=none; b=Mw3L4tLvX07Qgqq09SJiYnFRbISoTLhzsmX992tR4VEnbGLmIl1585JigYjZC/pY5hZPsIpuNZKr6oWs+Evr7fA1JFqtcpblWLCaN71mNVQ/k7CToawKA6DxsWJjc1bIX6A7aSPatJ9oEB3drSNvcHXHR3azs40Bfye1cgZE+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379191; c=relaxed/simple;
	bh=9IrDESLBODps6b/MrN1OK5NOij2ro1fCuRbGEvFirgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2f8RhpB9lbf2YYnugmRMHpBdGo6EiCD2z71Vtmo3rk/qMH+JAgLEHQL7oJl6ty5o1lRleofEhxs+Iqh4khOZY9qR+MyPlbUWjR6OAeKrZAqbN3kL1ZaM85Ww3ZZp0wOT8TDPELyLaMVpAkhoeOxxaiBN/efhqbqiVvZg+umUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fb4H8rpC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fb4H8rpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1209A1F00ACF;
	Mon,  6 Jul 2026 23:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783379188;
	bh=COwVRmFiam0JgsBH5zSv6qcJkLMNhPBYvpYuXgJw4PU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fb4H8rpCX8pCcvUfoN+b0kMJJEq1jDp2dHUuLJfBBmeqhDTg3fDLLtRd8CCPHgrGM
	 GCHMA8al9eYUszSqZ94fjzfIDRIhFXUi2zilYwESxbr8VSkY6PMBLI5zzGl3QOGXnl
	 t+QjJq7VYo+MUmsJQzxWqQGHIkK7eWDhq1XSRQcMTUPffswUeJysxjJpeuyuq54FHT
	 bn0xP+d6k/HuE1vEIjGPdvwGWkbiLYEHjOvG8hWfhagdAwHGdYihucHA2ZxWmWlqQ9
	 pc767/gncPvIgQIeiHNFH8citeb5Aw16O0sowqO/J2jsErU5dVasepEWyhBEXQaZry
	 oX78Zjritc5ww==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 06 Jul 2026 16:06:16 -0700
Subject: [PATCH v4 6/8] riscv: Enable resctrl filesystem for Ssqosid
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-dfustini-atl-sc-cbqri-dt-v4-6-e75c20201d64@kernel.org>
References: <20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org>
In-Reply-To: <20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org>
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
 yunhui cui <cuiyunhui@bytedance.com>, Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=fustini@kernel.org;
 h=from:subject:message-id; bh=9IrDESLBODps6b/MrN1OK5NOij2ro1fCuRbGEvFirgg=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWT5mHz4yXm6NeKGY5Zm3kHpzO8Hg89MWbxYTzZk7gnR+
 9zvFZ/ld5SyMIhxMciKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmMmEFI8PT5w95/pr3bI82
 4/y2bMfK7DecE93mcvr8Er4j2/5jgUkGwz+T6duOXJssUxR3juGG4b00i80SLsdWsQtHdPAbGMi
 7LGcEAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Make RISCV_CBQRI a user-selectable option (default y) that depends on
RISCV_ISA_SSQOSID, rather than having RISCV_ISA_SSQOSID select it
unconditionally. A user with Ssqosid hardware can now build a kernel
without the CBQRI resctrl support if they do not want it, while the
default keeps it enabled.

RISCV_CBQRI selects ARCH_HAS_CPU_RESCTRL, which makes RESCTRL_FS
available on RISC-V, since resctrl is only meaningful when the CBQRI
core that backs it is built.

The resctrl filesystem integration is gated separately by
RISCV_CBQRI_RESCTRL_FS, a silent option that defaults to y when both
RISCV_CBQRI and RESCTRL_FS are enabled. Enabling the resctrl filesystem
itself stays a user choice via the standard fs/Kconfig MISC_FILESYSTEMS
menu.

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
index f8566c003d49..68b4124df396 100644
--- a/drivers/resctrl/Kconfig
+++ b/drivers/resctrl/Kconfig
@@ -33,6 +33,8 @@ config ARM64_MPAM_RESCTRL_FS
 menuconfig RISCV_CBQRI
 	bool "RISC-V CBQRI support"
 	depends on RISCV && RISCV_ISA_SSQOSID
+	select ARCH_HAS_CPU_RESCTRL
+	default y
 	help
 	  Capacity and Bandwidth QoS Register Interface (CBQRI) support for
 	  RISC-V cache QoS resources. CBQRI exposes cache capacity

-- 
2.43.0

