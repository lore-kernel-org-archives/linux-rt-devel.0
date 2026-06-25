Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E743750CC;
	Thu, 25 Jun 2026 01:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782351650; cv=none; b=FSh2X3kQL4MJD57Z4xzBf8OHhYLbr+lnvrvqBMaaTQPBCK3Fz0NcwBFP0OYeUteUITnT+1MHeaK/GdZLgzV+WEDfkaf1cwtdb5K5FSed5GXchSXltkCerCO/ecv1SBTAPE9ZHVd+JSiIS6zXa/6CaOJEQuuUZjgGcyc4VsgJx8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782351650; c=relaxed/simple;
	bh=+ionyFv9lurwwDiWw+ePTClCXdl69DtYgAkjTpcZ7Q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NLRFh6jHy8cRyzmmO1RmEwAlcmHmX3UAoxcLw/GV2VMFTTHz66kztCoK/FQsNwjIW8pzkrq+l+DYdbPxKw2Wg9h81ptPgwXCDuYE5yMuisSyQOZLkyz3CGfn3CAYGrm++krKZIBX5fShF27BS8LQxGPH4nfbpJ3tDk35Q05B3K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHHdih/C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHHdih/C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12B41F00ADB;
	Thu, 25 Jun 2026 01:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782351648;
	bh=we1gTaO0/mtl656AVrC6p8j+YxwIRlQ30Hze8NO4hO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kHHdih/CU4BYvohe7bZsMdnnuYPlL2wRO5CSPl9nFuBKnge5Gaah7uKJAIvb4pVsY
	 QpOPc3VJB6tKHPRe5tL4xM8bRykQ1D1zMX+1JyOz2DA7pMoVq76cuP9l1Fjz9Tezer
	 4lBxAcyk6V48uv+OePJKzkwKbuvCx/qQ783B8iWMhPFBHoZ5xjnDe/jD83nPf1Pj7/
	 0Kbl8ME19UFLp/RJ/XAUW8nAvayGSg3ik0gMZjPV4XoHCcSV0kojYJqqSycV9bTXgG
	 5cp5oRgaJqzlNL16vJef0f0qIU2R7uE7PYFZfclMJ/8dXryTN96t+bobD8CMS8XJK/
	 3AVV8UcmtpdYQ==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 24 Jun 2026 18:38:34 -0700
Subject: [PATCH v2 6/8] riscv: Enable resctrl filesystem for Ssqosid
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-dfustini-atl-sc-cbqri-dt-v2-6-2f8049fd902b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=fustini@kernel.org;
 h=from:subject:message-id; bh=+ionyFv9lurwwDiWw+ePTClCXdl69DtYgAkjTpcZ7Q0=;
 b=owGbwMvMwCF2+43O4ZsaG3kYT6slMWTZtEtLTP4s1/hc+fWGHXnXpZIdV244ylvzzPGWzZVr3
 T7scv+edJSyMIhxMMiKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmso+HkeHbnV15VqETGC9e
 WP6q5JMUZ6Kf9G6BqT5M7EKcAQczDNYyMtz48p998wKmsDZV67Cu7CXT9zcrMSxyk7q2wdN+i+b
 8Ph4A
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

RISCV_ISA_SSQOSID selects RISCV_CBQRI unconditionally.

The resctrl filesystem integration is gated separately by
RISCV_CBQRI_RESCTRL_FS, a silent option that defaults to y when both
RISCV_CBQRI and RESCTRL_FS are enabled. Enabling the resctrl filesystem
itself stays a user choice via the standard fs/Kconfig MISC_FILESYSTEMS
menu.

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 arch/riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index ee586925f97227668c228b5481c05a2f914d928c..9c28bcbc29dc94fe9dd19b8a5c91816a2c75123e 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -594,6 +594,8 @@ config RISCV_ISA_SSQOSID
 	bool "Ssqosid extension support for supervisor mode Quality of Service ID"
 	depends on 64BIT
 	default n
+	select ARCH_HAS_CPU_RESCTRL
+	select RISCV_CBQRI
 	help
 	  Adds support for the Ssqosid ISA extension (Supervisor-mode
 	  Quality of Service ID).

-- 
2.34.1

