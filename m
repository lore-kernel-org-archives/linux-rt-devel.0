Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D40B19CCF7;
	Fri, 19 Jun 2026 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781894755; cv=none; b=QbcmSR5+PPkEqFmfEUqaiEuIcuQVZNHh7wevOk0W8Mix8NCXZ3nwHTbR+zAfU1rmSekbisthzRc9XLRzodhyX8wUpmCMbKvo0m0+iYNvojaPq4WG4RUEuHRIkpIStxahNL007I6klX5IVZ0j1aeJgqF/c6c0yKaBsGWyxIF7IOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781894755; c=relaxed/simple;
	bh=HQ99ZkS2qP/Mk+I1kjfZqngN2creNnXkqbm5DxCDnXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ivY2A8BEVsseQS55xE67ZWpQOlJWOcEMLAB70jpqzWAaZZe6jslZhXHxxIQApbz/3azUa7K7r+apgkmjiWQLrk76xh0U94ufzM1ngeXg2KSv9MsbbqJF0b4KCi2HeJg9HLDfq/lyoTtwrlcuDt/Z+VLb0QFZU/ioUJb4uMVLcBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKdQKpG6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKdQKpG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75661F000E9;
	Fri, 19 Jun 2026 18:45:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781894753;
	bh=JHW9Oobia66U/IDrDEv1ebncGijX/JFks8QgO3nE+FU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aKdQKpG63jwwPPXG1whkv68rsYkROUJkV/FV1na9dqQa8u9yoHMjZ8uFj8nnHF1j/
	 c4Xzhihe0Aotu3VqqwYaRuQgIr11s0JBd6PhApYoZEGwXUnXJzdxJHVjRFJzlQ5biQ
	 DhO0LF052fx41KNWOIzwM21GvCLZeAsTTqdbSJDcxnlLzA1X4tQfal8HCZub0n6LgF
	 oHQCdSAGPGkwWGozYAekkshhMdI0oTrjvfius3ZisbMSrsTy7kLO4cefM4h2NfGMGD
	 mfPrtN28uardjos3xSnu0eBaMwvw9Zdu+lQ5fGA9dG7uwfBzNeS9XVfo+NCodesqys
	 sEYDJCmGat2Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] riscv: Enable resctrl filesystem for Ssqosid
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260619-dfustini-atl-sc-cbqri-dt-v1-6-e79a7723fab0@kernel.org>
References: <20260619-dfustini-atl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org>
 <20260619-dfustini-atl-sc-cbqri-dt-v1-6-e79a7723fab0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 18:45:53 +0000
Message-Id: <20260619184553.A75661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The CBQRI cache controllers lose their MMIO configurations (Capaci=
ty Block Masks) across system suspend, but the driver implements no mechani=
sm to restore them on resume.
- [High] The per-CPU `CSR_SRMCFG` hardware register is not restored upon CP=
U wakeup from low-power states, allowing execution with an invalid RCID.
--

commit eb40435445d4659ca3c62bd3e4e35f35a4c254c5
Author: Drew Fustini <fustini@kernel.org>

riscv: Enable resctrl filesystem for Ssqosid

This commit enables the CBQRI driver for RISC-V when the Ssqosid ISA extens=
ion
is enabled. It links the RISC-V architecture support with the generic resct=
rl
filesystem logic.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 9eb65d0eaa070..cc261de01107f 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -595,6 +595,7 @@ config RISCV_ISA_SSQOSID
>  	depends on 64BIT
>  	default n
>  	select ARCH_HAS_CPU_RESCTRL
> +	select RISCV_CBQRI_DRIVER

[Severity: High]
Does enabling this driver introduce a regression in power management?

Looking at the CBQRI driver in drivers/resctrl/cbqri_capacity.c, the platfo=
rm
driver cbqri_capacity_driver is registered but doesn't implement any
dev_pm_ops:

drivers/resctrl/cbqri_capacity.c:
	static struct platform_driver cbqri_capacity_driver =3D {
		.probe	=3D cbqri_capacity_probe,
		.driver =3D {
			.name		=3D "cbqri-capacity",
	...

During deep system suspend, power to the SoC cache controllers is typically
gated, causing the partitioned Capacity Block Masks (CBMs) managed in
drivers/resctrl/cbqri_devices.c to revert to default permissive values.

Since the driver lacks PM callbacks (like dev_pm_ops or syscore_ops) to
restore the software-configured state on resume, will cache partitioning
guarantees be broken across suspend/resume cycles?


[Severity: High]
Does this also introduce a regression with restoring the CPU CSR_SRMCFG
register after low-power transitions?

In arch/riscv/kernel/qos.c:riscv_srmcfg_pm_notify(), the CPU_PM_EXIT handler
invalidates the software cache by writing U32_MAX to cpu_srmcfg:

	case CPU_PM_EXIT:
	case CPU_PM_ENTER_FAILED:
		__this_cpu_write(cpu_srmcfg, U32_MAX);
		break;

However, it does not explicitly rewrite the hardware CSR_SRMCFG register
itself.

Since the Ssqosid extension leaves the CSR state implementation-defined
across low-power transitions, could the CPU resume execution with the
reset value (0)?

This would mean memory accesses are performed with an incorrect RCID until
the next context switch invokes __switch_to_srmcfg(), which would
temporarily break cache partitioning guarantees.

>  	help
>  	  Adds support for the Ssqosid ISA extension (Supervisor-mode
>  	  Quality of Service ID).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-dfustini-a=
tl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org?part=3D6
