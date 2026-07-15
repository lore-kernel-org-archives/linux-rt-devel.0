Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513A59460;
	Wed, 15 Jul 2026 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784075028; cv=none; b=XD8lqzLajIAw6NUldqNO3AlU1VAykg7rylakvg4h5eSgXwey8PiK3EbkHiRrMnpgPsYtsT439WF8DgQDjhEgvkYEqCkde0vrx8UFJeSZKoTR6MV6UgNCl3tLVKCNZj80ygBQuMrxhp69Vg5/qglMxjLIqxrApzKYZ97pRP8n1Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784075028; c=relaxed/simple;
	bh=58g1568NRL7/SI4d2HoFSQSOKccqgmn0k03hr3pJQEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AtIOVjgGhhoEjOcFcYpIKw4S4At6+K+3vWdoEYhBurl5KhjZuTpaFGXCOVVhqrhkvhgPkj0BV/+Y34hT7P6Jf5x03fOyf5WsPYdjmz1fanqCYAC+c9z7IOr4/w39hlEtSVkkSvWOJf8ehmD7clNXQZ5puo+TzUwx8CiWECNNvm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCOL7mrL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCOL7mrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAA31F00ADB;
	Wed, 15 Jul 2026 00:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784075027;
	bh=SoMF0NvEK/nHml8RMjqK0ASTpVqLJvBd+3O6LznwQbI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gCOL7mrL68De7cYo/mD3keRoocGjXVRKH7wXtFoA+4tYxIb9PtZS9Q9iaD+ICj9zW
	 jhyrqClIsS9xJc7g+RChW5tPByARc14UGrgv5GiX9HQiiG6Ka/XOC7OQ3GpClq1L8i
	 bw7ibUrZkWVruJdB9KuMxuntDqGZ7UxMEFCKzle+dBtjlwWdEhH0FwwwA0F79RxZwy
	 o4jAQLrY0QizXZO7a0oUiQBbCRbZ2vVqm6E63+J2F836hxm3tcSn7ixO9AKb8T64NA
	 YhrghpeKQ2H2HPpVrXWg7WX1wsvi7L/uGM9DRTUMqkPgUow/2uc0O7MNdWnLobp5Ob
	 BgPg3g8bL6y1w==
From: Drew Fustini <fustini@kernel.org>
Date: Tue, 14 Jul 2026 17:23:24 -0700
Subject: [PATCH v5 2/8] riscv: Detect the Ssqosid extension
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260714-dfustini-atl-sc-cbqri-dt-v5-2-b0ae7e9c932e@kernel.org>
References: <20260714-dfustini-atl-sc-cbqri-dt-v5-0-b0ae7e9c932e@kernel.org>
In-Reply-To: <20260714-dfustini-atl-sc-cbqri-dt-v5-0-b0ae7e9c932e@kernel.org>
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
 yunhui cui <cuiyunhui@bytedance.com>, 
 Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
 Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 linux-doc@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1637; i=fustini@kernel.org;
 h=from:subject:message-id; bh=58g1568NRL7/SI4d2HoFSQSOKccqgmn0k03hr3pJQEU=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWSFXRb4f2vjnFVuDKv1OS7OUdUy7VH9+v7vgruWDBOvM
 104NOV2ckcpC4MYF4OsmCLLpg95F5Z4hX5dMP/FNpg5rEwgQxi4OAVgIivvMjKcPrMqVm/r1MK2
 N0tvdM+eOfPKK2G+u2mz9Bfy/F2g7bXzNiPDhlNRCjdX5S6Pnvd5rkjd46UpUVtnn4g+faPi2xX
 R4x1HmQA=
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

