Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8368383C7E;
	Mon, 11 May 2026 05:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778476281; cv=none; b=Xmqk98wEUmO/iSGIY14Svu8VBlBKy7t+3aRRKkvdgEN0KrupzaDcqhVhIMdalDJbO0+b+ps6jrc5fegfDzBhNaFyMgymP7DbewjdTk3jWDFrpQIMsfF5buHhJyYCUMFkyeBRTPqvc3ZdrE6moIIS+u9S/cW1DbE1cyk+mwKEKU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778476281; c=relaxed/simple;
	bh=IfK90oL89PLZ77zZUqMTiT6Ew+f2/fOrCwuhT7VtBQ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j/uB8aMCDVaFSdaYbKnrXh/uJpPB6xl7IX5U4UxuWGGYpqyF8CuK3Yy2o/IPI0PF5yRIt30Bz1koyDoHbRybyYqDlXVJdZt5a8+ruADpc5sNDOi7B3IiBrsxquCk+CflxJofQfRRUBkHJuNuo8XEBkoe901RBzBLnFYrj4L1FL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NO5H17Mo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NO5H17Mo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7E1C2BCF5;
	Mon, 11 May 2026 05:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778476281;
	bh=IfK90oL89PLZ77zZUqMTiT6Ew+f2/fOrCwuhT7VtBQ0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NO5H17MoG/pw6yzuPDowtnsunSDQIo679yk1cZvTcR8hnDUSQQhjA/0uI6E+t97Gf
	 tzdPuyigKDPkEANJxOlSponqMMUkAqnMrx+TqlwPsaSb/NVelm1X90Rd4iDaSlPCg3
	 WJ/rTsx+X/h1WJni3NVoVMjtl5k99+cPHWPcOyz2zd+lNXidaLj5MaPsAG5hrMHF9P
	 PkgjQqdPLRleCLTgumxOqkL8/M4qElXssAG22cRWIWnIzMGbClZsLIhzqAwGegTDe4
	 pDokNii24iXjMhDJH6DT9SqqCEtNsujHEW562hPDS0V3hq7pPSMn/bDDSFF3iWGcRF
	 D3gLonk8WA0UQ==
From: Drew Fustini <fustini@kernel.org>
Date: Sun, 10 May 2026 22:11:14 -0700
Subject: [PATCH RFC v4 18/18] riscv: enable resctrl filesystem for Ssqosid
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-18-eb53831ef683@kernel.org>
References: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-0-eb53831ef683@kernel.org>
In-Reply-To: <20260510-ssqosid-cbqri-rqsc-v7-0-v4-0-eb53831ef683@kernel.org>
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
 linux-doc@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=732; i=fustini@kernel.org;
 h=from:subject:message-id; bh=IfK90oL89PLZ77zZUqMTiT6Ew+f2/fOrCwuhT7VtBQ0=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWQxprxZ2yOz0U5U4FPV5R8Ry+qPTpdcertH7Katwh6N+
 M+PWdpXdZSyMIhxMciKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmsqubkWFGeN+b36eXx8WY
 9nqx/rB26E1dau6n1u1gmqRulS4dXsLI8OSMZOeaibGdr4NX7876/iTnk4bTVflTFtlPkvQFq2b
 rsQIA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

RISCV_ISA_SSQOSID selects RISCV_CBQRI_DRIVER, which in turn depends
on RESCTRL_FS. Enabling the resctrl filesystem itself stays a user
choice via the standard fs/Kconfig MISC_FILESYSTEMS menu.

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a0c73edbe734..ea430b4a3aab 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -596,6 +596,7 @@ config RISCV_ISA_SSQOSID
 	depends on 64BIT
 	default n
 	select ARCH_HAS_CPU_RESCTRL
+	select RISCV_CBQRI_DRIVER if RESCTRL_FS
 	help
 	  Adds support for the Ssqosid ISA extension (Supervisor-mode
 	  Quality of Service ID).

-- 
2.43.0

