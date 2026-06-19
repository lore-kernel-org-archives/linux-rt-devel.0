Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A884331EDD;
	Fri, 19 Jun 2026 18:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893793; cv=none; b=b9s0v9nzv0dJYju4SXSeraXQm61kn1+b3DNCK8rPWOUaSGIgoKTGvPVx9Istb7/QL5KfGUyn6aNM6Pk5U9Mq2U5+QjsUEgg+uTGRMnpI8FQkkQb1xaRBVYIpDAM7K9pSq7LOg/+SK3r/nZxl1uUPVhEHlu8/+LkipJaR3V6stSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893793; c=relaxed/simple;
	bh=XzD8qxhMVFjGTkcUSWhD7808N9wJROgN3KTUSR29OyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VkNkvlVO9ETcob3wPT+KpLwh+VMtbeeV1wYcwFzDNDG4GITRnM3EG4zCGVxfZ0O/TNKF4xebtkj9+6gdzGh7MLJpRWoIcDGNFxg6MpTbQJCIkWCbOndRhFHLpBPJwyFY4krnq1XRum4zwR5WswMuafT7s6H9VqeS8PHc95dNRgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgL36/Md; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgL36/Md"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05BD81F00ADF;
	Fri, 19 Jun 2026 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781893792;
	bh=FHASCoT2hpjqe3g0pZSejYTwgoS9bxzyrN/pYid+Zvg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BgL36/MdtkXnliB3muWgnlfl6C4aF9t93w31WTSM4HaW8ALqeNqV1F3hl2xyoyaXa
	 OY8iy2TBxwShD0gNJB6BD8pSoWCUDUqBC4OPmpO2x9ql8WiVlbyT4Ib4qwsuajIM2D
	 5OlqhfJBzMgnlNkdeOlJv9FSRoWpD7qHXeiz3SoaqHF2KZzglbzXhjIasCyVWGO9Xz
	 TQfHZoyGUx1l4SQMRQuRvr+9Ay+rTjtwJdECPje4OBJqvFtyQONjO9aySRGZf91dbh
	 8voSCzq+E1WaaVYSwFcEBjYPedqlTuPd5hCvwPQhT0SWznNprGi6ksgfheY/L2C+PV
	 FVuF9aQgsSlOg==
From: Drew Fustini <fustini@kernel.org>
Date: Fri, 19 Jun 2026 11:29:41 -0700
Subject: [PATCH 6/8] riscv: Enable resctrl filesystem for Ssqosid
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-dfustini-atl-sc-cbqri-dt-v1-6-e79a7723fab0@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=876; i=fustini@kernel.org;
 h=from:subject:message-id; bh=XzD8qxhMVFjGTkcUSWhD7808N9wJROgN3KTUSR29OyQ=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWSZds2ScJ7qpp9w9l7uG0Fz9munnv0xzGNZKSj7Z96M1
 rQfCtfvdJSyMIhxMciKKbJs+pB3YYlX6NcF819sg5nDygQyhIGLUwAmEtjDyLDv+PXNygsDvjZt
 jL1y3PPx3G2h0jt27VP7l/LFccWe65taGRkOnVBcs0Bjx4aIspaKkKl+LBZfV1Up7gxZEvQuVLj
 26VEOAA==
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
index 9eb65d0eaa07..cc261de01107 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -595,6 +595,7 @@ config RISCV_ISA_SSQOSID
 	depends on 64BIT
 	default n
 	select ARCH_HAS_CPU_RESCTRL
+	select RISCV_CBQRI_DRIVER
 	help
 	  Adds support for the Ssqosid ISA extension (Supervisor-mode
 	  Quality of Service ID).

-- 
2.43.0

