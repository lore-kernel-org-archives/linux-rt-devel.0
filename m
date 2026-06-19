Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E29B331ECA;
	Fri, 19 Jun 2026 18:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893792; cv=none; b=TmgNZoLj4auALG3OKkN9kfWet/Rpz3LLHoH7T6FOaPst9qM7gx5f4AEq12ZNHyLgxrzdTnq+GIT3vOcrv/aVtVDxL75KWiF1n67OAGG60VLPxlBOZETxIbfcCVXPdbyS0wBdhluZn/GHQ/ryxjaruril9+0eBxnEMvfXZ9THI38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893792; c=relaxed/simple;
	bh=Il21aTORLEmMcb+bqZtjLfUVNnbLhe3aUQEf7IOrJ3o=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oJfv6ejp6ujR+uUMOpUyRgioDvg8cPeUuqulLnd6taZBoouF22eo1CwTlgIFDizipEPXZrHHYOpIbjcgJtT/81lE7nZf63AzFbhN2e7ze4izGNo6kXhx07gNDJuX+OFm0Ur/Tu5DzW5MzYh1gmqz6bg9wqwYC7GY2WlofDUU7Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1YKyMtc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1YKyMtc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4361F000E9;
	Fri, 19 Jun 2026 18:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781893787;
	bh=7krNnge6CqDFpXfWCA2S/6g3TXm4KR3ObMbF3c3qLxw=;
	h=From:Subject:Date:To:Cc;
	b=B1YKyMtcV1TBG0oE6SZ1Qm89ffWi9qe7LEUSGLaeganJTMFzREb8GxXRwDHIRiF0o
	 WF2VOBw5MVFmSqcTbouT4GwXH8ISqZ8c594e0CPhIZZGKAdaNcubzEu6BcRMXJVhjh
	 wW8E9D10pcx4sIXbZyDr3QuePv8iTeT9KsIfelCoYE4LV0j7lyd5mCIe6ge5CW3yvm
	 O6n2yzuD6x8CnwmLA6OF5rE/ItBPXmRVdE/SfqmndF7SZZZWZiYdL+uOZbQIx6x5oS
	 c4zKL3dlS7WncPh+adneJmfexcD5I9Epged0SBO1kenvU2Le87KXpukqER98a/wwaZ
	 QDo7Fu5vGBP/A==
From: Drew Fustini <fustini@kernel.org>
Subject: [PATCH 0/8] riscv: Add Ssqosid and initial CBQRI resctrl support
Date: Fri, 19 Jun 2026 11:29:35 -0700
Message-Id: <20260619-dfustini-atl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI+KNWoC/yXMQQrCQAxA0auUrA1MBmmLVxEXbZLaFBl1MhWh9
 O6OunyL/zdwzaYOp2aDrC9zu6cKOjTA85CuiibVEENsQ0sBZVq9WDIcyg2dkcdnNpSCRwrca+y
 IRKDmj6yTvX/r8+VvX8dFuXx/sO8fECGvBnwAAAA=
X-Change-ID: 20260610-dfustini-atl-sc-cbqri-dt-410c8e2711dd
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3589; i=fustini@kernel.org;
 h=from:subject:message-id; bh=Il21aTORLEmMcb+bqZtjLfUVNnbLhe3aUQEf7IOrJ3o=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWSZdk2pEubjOXIi+9PGjyelEtOa2p0KTQ6ca8ziV+i4f
 IfJUcOio5SFQYyLQVZMkWXTh7wLS7xCvy6Y/2IbzBxWJpAhDFycAjCRwsMM/1N/Zsa5n2z2/aaU
 djUnJa5qisxy9SrRgvLr/lqmEqz1exj+SpQFqTxc9ytwkTrXkSf2zndWtC9onx4gY8915nN6z3M
 XdgA=
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

This series adds initial RISC-V QoS support: the Ssqosid extension [1]
(srmcfg CSR), the CBQRI controller interface [2] integrated with resctrl
[3], and DT-based platform driver for cache controllers. It has been
tested both on the Tenstorrent Ascalon Shared Cache controller as well
as a Qemu implementation [4].

Note that this series only implements support for resctrl CAT using
CBQRI capacity allocation control. cc_block_mask maps onto resctrl's
existing cbm schema. However, cc_cunits is not supported as there is no
existing equivalent for capacity units in the resctrl schemata.

I had previously been iterating on an RFC series [5] that did a full
implementation of CBQRI including capacity monitoring, bandwidth
allocation and monitoring, as well as a parser for the ACPI RQSC table.
The bandwidth controls for CBQRI do not fit well into resctrl's existing
throttle based MB schemata. I believe that the path forward is
Reinette's generic schema description proof of concept [6] but that will
take time to mature. My plan is to rebase the full support of CBQRI on
to the generic schema once it is ready.

[1] https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
[2] https://github.com/riscv-non-isa/riscv-cbqri/releases/tag/v1.0
[3] https://docs.kernel.org/filesystems/resctrl.html
[4] https://github.com/riscv-non-isa/riscv-rqsc/blob/main/src/
[5] https://lore.kernel.org/linux-riscv/20260601-ssqosid-cbqri-rqsc-v7-0-v6-16-baf00f50028a@kernel.org/
[6] https://lore.kernel.org/all/aab804b9-e8b5-40ad-a85b-af7033391243@intel.com/

---
Drew Fustini (8):
      dt-bindings: riscv: Add Ssqosid extension description
      riscv: Detect the Ssqosid extension
      riscv: Add support for srmcfg CSR from Ssqosid extension
      riscv_cbqri: Add capacity controller probe and allocation device ops
      riscv_cbqri: resctrl: Add cache allocation via capacity block mask
      riscv: Enable resctrl filesystem for Ssqosid
      dt-bindings: riscv: Add generic CBQRI controller binding
      riscv_cbqri: Add CBQRI cache capacity-allocation platform driver

 .../devicetree/bindings/riscv/extensions.yaml      |   6 +
 .../devicetree/bindings/riscv/riscv,cbqri.yaml     | 109 +++
 MAINTAINERS                                        |  15 +
 arch/riscv/Kconfig                                 |  20 +
 arch/riscv/include/asm/csr.h                       |   5 +
 arch/riscv/include/asm/hwcap.h                     |   1 +
 arch/riscv/include/asm/processor.h                 |   3 +
 arch/riscv/include/asm/qos.h                       |  86 +++
 arch/riscv/include/asm/resctrl.h                   | 152 ++++
 arch/riscv/include/asm/switch_to.h                 |   3 +
 arch/riscv/kernel/Makefile                         |   2 +
 arch/riscv/kernel/cpufeature.c                     |   1 +
 arch/riscv/kernel/qos.c                            |  91 +++
 drivers/resctrl/Kconfig                            |  44 ++
 drivers/resctrl/Makefile                           |   7 +
 drivers/resctrl/cbqri_capacity.c                   | 132 ++++
 drivers/resctrl/cbqri_devices.c                    | 511 ++++++++++++++
 drivers/resctrl/cbqri_internal.h                   | 110 +++
 drivers/resctrl/cbqri_resctrl.c                    | 774 +++++++++++++++++++++
 include/linux/riscv_cbqri.h                        |  47 ++
 20 files changed, 2119 insertions(+)
---
base-commit: 4fa3f5fabb30bf00d7475d5a33459ea83d639bf9
change-id: 20260610-dfustini-atl-sc-cbqri-dt-410c8e2711dd

Best regards,
--  
Drew Fustini <fustini@kernel.org>

