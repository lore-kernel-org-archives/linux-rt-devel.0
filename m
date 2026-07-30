Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AB8361675;
	Thu, 30 Jul 2026 01:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785373911; cv=none; b=V7ONPrIFjiiFSaQjxOXaqCxlnVzwk4auUPhyPViCUiwBq3J8RP6nw0Cchv+jYHx9fuRBA5uR2cV3KkMWc4aGc7z+ubmnlfTruywuNxOGyefHyEoUxphFmJiLLeRPESRMwyhPxO3GZELZErDrFeWeuJvtshDidywJ/brHFROAMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785373911; c=relaxed/simple;
	bh=AIc4tDc31aggQ9J4oF4HAHZHb1+qkUuy9Exiq2WSpEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cevk45OQcTU7JvM/mfo9Lu+WX7NY+PrxsN4b3kvNSkbOMwKcn4ootae39ElXswNLr74nLgmtCKnhSmU/ccBP1NhkUo0IqDMQpCd3nmOQwxk+Zs1iBumaPJY8PEp9/KefBVgbR8dsSAI1I+kM0iRCXj1VRKqdrg6mf4pyZXqs2Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjX4kZ80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjX4kZ80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8E21F00ADE;
	Thu, 30 Jul 2026 01:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785373909;
	bh=Ae3T6/sn13cFCypXS6tdbUCXb7A1L648QbTVdrMg/kY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fjX4kZ80NGnUrG9wmi/tTWsL0y0h1dV6S1l5ZxAFbBXRyUg2btg2FiHD68PVrEEeY
	 9r+brK5QwnsjL6t8NgD6i4pekQgoLPRby6tvALvhtJd1EY3pIN4Hr+Rqo7D2zk46ie
	 mMggN9Fg69TMJGDjQImSrBIfUEfWG6hvx3Co4XQ4NKaVRC0hO7vRQccKN/+1iWddVr
	 JPwV27Rpb61/yT4aHIMEBwvppJTxiaI5lkHR6b5DF5uAULh5pbLbMtWZe/6kpqUxLq
	 kKCry11A7N9BaJcH/H39U4oM4omyppYoSQLIM/PezH0YlyALQed/I0f822XRw88Ows
	 Xr0hOTZHOc7Zw==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 29 Jul 2026 18:11:33 -0700
Subject: [PATCH v6 6/8] riscv: Enable resctrl filesystem for Ssqosid
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-dfustini-atl-sc-cbqri-dt-v6-6-7c22b05d461b@kernel.org>
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
In-Reply-To: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1394; i=fustini@kernel.org;
 h=from:subject:message-id; bh=AIc4tDc31aggQ9J4oF4HAHZHb1+qkUuy9Exiq2WSpEA=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRlLbnw3lhI5Jxhw+LZryJSXsQ5MwhpbS0J8LqdWyLje
 s2wyG9dRykLgxgXg6yYIsumD3kXlniFfl0w/8U2mDmsTCBDGLg4BWAiQisZ/oernWA6d69XOP/F
 9LhJqy7ZbZl1/ObMkIfznX7w3NH6FfGU4Z9V8e+rydcKk7mf1tZe/670s+bY8X0ht5deXnl7C9/
 xpH9cAA==
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

