Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5AA36492C
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Sep 2026 03:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405873; cv=none; b=bB5ViKeT9HJnoV1ij2MSkJbHBughTayNeZ/EQrsfSUyvHNGvyvdLZzVsViYNHykSrSQZuyKVzn48lEpC/pHAwKvcHApg12nDjCetV2o6mpEqqxVXKs+pd02p+4FOBERUl1EkFqk+JEn/idRzpbYRoUiimPJ30kJUtK9ad3XS9js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405873; c=relaxed/simple;
	bh=9NQez/XqcWKPGYJKIglU7rIL09ecKY+aDFGNo5VSQ+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kAQCbLvo+Ky+oaH1a5EHnuvQm+RyD1UOJP+0SxUswKN2jrFvFdVwpACUKgx3GBQAfEAs+Atgz2ovTLy2WyhNVBPWCLUBfc2CptO7LDCcFBdQD7mXviL/BMdcjvEA7crSriJ7oSdeWE+Me1eO01TUqcbSH1WfRNtHvel8ObQwOpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OIwsJIGm; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OIwsJIGm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788405862; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=0wgFQtv8dkO8eMVrOYWRVOpDJA+dvQgD+EuoMqAxNGQ=;
	b=OIwsJIGmnLmzsp3kGeuMK7esa/+IWD+kV/vZx47Mk9Ihf+/FyKAbbmELjU8p6KE/gv6aLn4E4LDGW7WgP/7KG7/FqR2r/ryanXTzVoq57msgG/9t5fwsZhncIsITm5Sqa46MwhJNY2RuYQzkphLjfVVsGke8VJT8YcIjDrT0obc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=41;SR=0;TI=SMTPD_---0XAEcfX3_1788405852;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XAEcfX3_1788405852 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 03 Sep 2026 11:24:20 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Adrien Ricciardi <aricciardi@baylibre.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Atish Kumar Patra <atishp@rivosinc.com>,
	Atish Patra <atish.patra@linux.dev>,
	Babu Moger <babu.moger@amd.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Borislav Petkov <bp@alien8.de>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dave Martin <Dave.Martin@arm.com>,
	Fenghua Yu <fenghuay@nvidia.com>,
	Gong Shuai <gong.shuai@sanechips.com.cn>,
	Gong Shuai <gsh517@gmail.com>,
	guo.wenjia23@zte.com.cn,
	James Morse <james.morse@arm.com>,
	=?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	liu.qingtao2@zte.com.cn,
	Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Peter Newman <peternewman@google.com>,
	=?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Vasudevan Srinivasan <vasu@rivosinc.com>,
	Ved Shanbhogue <ved@rivosinc.com>,
	Weiwei Li <liwei1518@gmail.com>,
	yunhui cui <cuiyunhui@bytedance.com>,
	Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>,
	Drew Fustini <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	x86@kernel.org,
	devicetree@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 0/5] riscv: Add Ssqosid and initial CBQRI resctrl support
Date: Thu,  3 Sep 2026 11:24:09 +0800
Message-ID: <20260903103930-testedby-cbqri-v7-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org>
References: <20260901-dfustini-atl-sc-cbqri-dt-v7-0-ca2935d85622@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> This series adds initial RISC-V QoS support: the Ssqosid extension [1]
> (srmcfg CSR), the CBQRI controller interface [2] integrated with resctrl
> [3], and a DT-based platform driver for cache controllers. It has been
> tested on both the Tenstorrent Ascalon Shared Cache controller and a QEMU
> implementation [4].

Hi Drew,

I picked up this series for testing as promised. I exercised it on both
QEMU (using the riscv.cbqri.capacity device from your branch [4]) and on
real FPGA hardware with a CBQRI capacity controller, and behavior and
functionality look good on both.

What I verified:

  - Mounting resctrl and reading the default schemata (CBM reflects the
    controller's capacity blocks).
  - Creating control groups, writing a narrower CBM to schemata and reading
    it back; the value matches what was written.
  - Assigning tasks to control groups, with the RCID taking effect via
    srmcfg on schedule-in.
  - The CBQRI capacity-controller block-mask limit actually constraining
    cache capacity allocation.

No functional issues observed.

For full disclosure, this was a general functional pass over the main
resctrl operations to confirm the controls take effect, rather than
exhaustive or corner-case testing.

Tested-by: Chen Pei <cp0613@linux.alibaba.com>

Best regards,
Pei
