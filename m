Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307DD3FFAC7;
	Mon,  1 Jun 2026 20:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780346199; cv=none; b=J/NfsARvJao8q0i6LFG8ac4mJeQsn17v/oKnCXEOkTZQVTJNIRGVBIGjCw6zkvcLZkoS7b/7U3S21lv/D6iKdGkfG73UU2ZMDPHbpFMpdIbYYNcyuW1NVpuRUu9bh3CrJVMlX21Eyw4YFchRYOVZj1HLPPXHqHA3rLvRou1Vl8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780346199; c=relaxed/simple;
	bh=6CzKXhV0tXNwm1l8Ur8ud/xHZoolzjjof2zwrYxGHkE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TiKkr78PS6ovIvMeRb338xlFMKs3ZIjwsR9SsxerGn7aQp3DjjMy7ADLheKhNbHEpfbjQ+BMd0soywGri9zZuO1QPSwPvXFrtVc5X6y/150ICYaGiiZxM1KioC7KGmWk+oZSbS8HZ0qP+TILMrsLBEzjBlp4+a+G+HSj/ZMwjxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nl8wTyX/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nl8wTyX/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8091F008A7;
	Mon,  1 Jun 2026 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780346198;
	bh=U+t+EwaLSa9WOo0VEMTYqUakFDohqsI+NxBxDSmeLYo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Nl8wTyX/3fAHjM6xCDMCVHOCu3oJDWI+XRy1KZ9PvBnAqA4duBLSFcYQDXfH8LR3H
	 bmr/vkHgcmqlGVOPXOH7eCHLUrkofOuec9XEdAucwtz9xqZZHwYBth838JWjM42WrF
	 hRyA0hrHdvjTHSOwxDgjgflVsYBo75+Aupt/ay78vbAlWMnIJOnE8VIhCaoYlBKxcH
	 o8pRHP/gexjsttym3kyDtl8ZOM5k3lxZ1P95y0xEcdjTjfVFiPAHMIbFv+ZHgEkHDv
	 bM5jqFFfnUwjVLqNNStE9Sj4Yz0MjpUbRO5wwoFjBHhzrUAiD4jQtHRYj2dzZ60Xjk
	 vKo/0wGjioQwg==
From: Drew Fustini <fustini@kernel.org>
Date: Mon, 01 Jun 2026 13:36:12 -0700
Subject: [PATCH RFC v6 18/18] riscv: enable resctrl filesystem for Ssqosid
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-ssqosid-cbqri-rqsc-v7-0-v6-18-baf00f50028a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; i=fustini@kernel.org;
 h=from:subject:message-id; bh=6CzKXhV0tXNwm1l8Ur8ud/xHZoolzjjof2zwrYxGHkE=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWTJvnV52Za3ouVAzL3ilwppM5c5a08te3++5curp5eER
 TanbI9k6ShlYRDjYpAVU2TZ9CHvwhKv0K8L5r/YBjOHlQlkCAMXpwBMJOcGI0NvgXDqtYmLhE+G
 LVeYFdfqNWG+hJJ60TZPI6Nn2yMPnLNj+F8Q/2LCVN7dmtezuZ7369SkzJZ9d4PD4dLsk+rvZk8
 yEmYEAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

RISCV_ISA_SSQOSID selects RISCV_CBQRI_DRIVER unconditionally.

The resctrl filesystem integration is gated separately by
RISCV_CBQRI_RESCTRL_FS, a silent option that defaults to y when both
RISCV_CBQRI_DRIVER and RESCTRL_FS are enabled. Enabling the resctrl
filesystem itself stays a user choice via the standard fs/Kconfig
MISC_FILESYSTEMS menu.

Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 390353a6153a..dd65248df117 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -596,6 +596,7 @@ config RISCV_ISA_SSQOSID
 	depends on 64BIT
 	default n
 	select ARCH_HAS_CPU_RESCTRL
+	select RISCV_CBQRI_DRIVER
 	help
 	  Adds support for the Ssqosid ISA extension (Supervisor-mode
 	  Quality of Service ID).

-- 
2.43.0

