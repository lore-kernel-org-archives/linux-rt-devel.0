Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957E53D9FB;
	Thu, 17 Sep 2026 16:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663250; cv=none; b=EuvTCJqDo5f3YeVrnq6i4H716YTBXoMOAa9BtxDiT3qKDgbwypwZeFDk8Tsm0wIQcr3PdOZFHgYQK1GKf+EN8DUWR//3bXOwMldrMKREiu3e3ulwdlBO/zFU2o6weLNx6aBgidOEfhrBCBY+VKBybFLU75AGHq1YWHKIh4fgEQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663250; c=relaxed/simple;
	bh=8So6ccZldy4L/KcTgwkLAjT7RYXgfaYjoD+/1AtBKIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ETo3rVJO5mgIkUxMHOrzWqWpz1au0ysF32+sxSFowbXPk+Atwgv+IrtWr2DFzjlXSaFBUqfhyo7/ASBRgOc/zv9yAmyrZJX6UF9SfZFxuRfn3mnQ2Ha9PN6Efxh5byxa7e/FMJpsuUjDrUeMdZJhxEcCLb5PZpLTjlJP2Z6KLY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DX8V+twS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DX8V+twS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8C11F008A1;
	Thu, 17 Sep 2026 16:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789663248;
	bh=VwFWqOZ4pOlB2wwYmiolP3Sp+mnMbUJd9qfFhnZEqBQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DX8V+twSQnA1rX/ZItYbL4XEQLBeM6c+85tg0bD/RIaYy0AC+FxqeH+WG6PLYLu9k
	 UdGdWaCWemAiOEQ4BZZBlb3UW/doSpexHlCuZzL98xHsgiL2OhvAG1tQICE9/vPG5N
	 fV0rIjozU3/PICfUFefdnfD1+WOIuBCZ1NwNBdTDFuGtnsD/jqTr8ES14pzDKsN53I
	 qFNjunPrcGEzd6Xi63X4qmmnE0xBlcBT8l1Bo7hKQ3HWeMxV47ZILZ2h0Qwifm7pjA
	 5GLwGqRqXJL17nVXovaTJwkE20BE0V9dFScVAkNQIPlLOuMNlls1z5Lhjlq+qYySUp
	 go8oJMh8gn3qg==
From: Drew Fustini <fustini@kernel.org>
Date: Thu, 17 Sep 2026 09:39:39 -0700
Subject: [PATCH v8 3/5] riscv_cbqri: Make RESCTRL_FS available on RISC-V
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-dfustini-atl-sc-cbqri-dt-v8-3-7964e8d73fe8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=fustini@kernel.org;
 h=from:subject:message-id; bh=8So6ccZldy4L/KcTgwkLAjT7RYXgfaYjoD+/1AtBKIE=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWStkeB9F8vOHxF5INHG1mnVgd+Tp346qPmnadOETYt4c
 pYUzrc701HKwiDGxSArpsiy6UPehSVeoV8XzH+xDWYOKxPIEAYuTgGYyIUtDP+Dfr9139vg8cTp
 ebhu0Ik/35Wmxx4vZK9LUl3lYmv76EEAI8M/JRau7MsSGW5WgtWfjq/ePXFf4KYLjdsF1l5853z
 xxxQeAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Enough CBQRI support is now present to enable ARCH_HAS_CPU_RESCTRL.
Have RISCV_CBQRI select it so that RESCTRL_FS can be enabled on
RISC-V, and default RISCV_CBQRI to y. RISCV_ISA_SSQOSID is default n,
so this only affects kernels where the user has already opted into
Ssqosid, and on those the CBQRI support is what makes the extension
useful.

This is a separate patch so that no commit makes RESCTRL_FS selectable
before the resctrl glue it depends on exists. Enabling the resctrl
filesystem itself stays a user choice under MISC_FILESYSTEMS.

Tested-by: Chen Pei <cp0613@linux.alibaba.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 drivers/resctrl/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
index cac23d20124b..617b813b9808 100644
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

