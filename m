Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670618003D;
	Mon,  6 Jul 2026 23:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783379826; cv=none; b=DvKxJKO5qYXBPc2o5x79smHg5ghWMBWZco7kLuruHnpkSaKXFK53wqY2sXjTxxlSGCw5ZMYPTiej2oCa8gz7KoM5oe/sS1gfs9Xj0UTWAQ/mS48+PxXehVWEHT09ZB4OtLdRfTTQ2nMK9lBudsB32npbBJfooMcCPxxeRmvVRsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783379826; c=relaxed/simple;
	bh=qMqR27LY5oxc6Jm8FICPiakS1BIvirMariVREeNFh50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UZxskuAkvD2/WyC07O066RnFwq/KTR6+sP4N4PjKIsM+YPXTRaQ/k3UeA3KXr1QswtKJucbFnlNXTJydt3ItLrQyBj0zGedw4rY/Xy8dALWADJ5Tl8JCr48mPNeymbaAzcVXGxy0c+TlIdzTDwRfC//yODTJHni207tfwduDGtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEayu7Yk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEayu7Yk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A741F000E9;
	Mon,  6 Jul 2026 23:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783379825;
	bh=UhIJ3D6hEIVFpi/POFGgV4Fgls2GxwXh+sTVJH1vOyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XEayu7Ykm8+dGUdYSiVhaQGpJNo3YuwyJ1Jy9S5yVKAYvfzEGLabIssft+2njI9UA
	 MNWATU52GK1yxuIK0sn2lG75OVlWkRV1wr8bDHEI2adZ6FJmF2NwBraJe66lKh3lr2
	 1IplWdaoj5Hl5RgEnNyME8J7Gutm3tHOD50xuOf8n96pRBOw0UCYhyAcN4YbympujO
	 VmUx0SUBOGkVB379fWkP6WhMNjKhar6ZyDOTwcUY/IF8oH6Jf5UF/rJDCJsm7MUiar
	 vTzWErIgGBwT31A/PAQKXv7qStic9AM0sexXwHqWY/f6NfWj3kKUS+1PXT68q+iOQn
	 /1FtGWpNP4T+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/8] riscv: Add support for srmcfg CSR from Ssqosid
 extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: conor+dt@kernel.org, linux-rt-devel@lists.linux.dev, robh@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260706-dfustini-atl-sc-cbqri-dt-v4-3-e75c20201d64@kernel.org>
References: <20260706-dfustini-atl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org>
 <20260706-dfustini-atl-sc-cbqri-dt-v4-3-e75c20201d64@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 23:17:04 +0000
Message-Id: <20260706231704.C4A741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Late CPU hotplug cache invalidation allows newly onlined CPUs to e=
xecute with implementation-defined CSR values and potentially bypass the CS=
R update.
- [Medium] Missing resctrl architecture callbacks and generic subsystem int=
egration, rendering the srmcfg context-switch logic functionally dead code.
--

--- Patch [3]: [PATCH v4 3/8] riscv: Add support for srmcfg CSR from Ssqosi=
d extension ---
commit 5baf8388a55d26b8cdc1b9f1025583f7b6a3e4f3
Author: Drew Fustini <fustini@kernel.org>

riscv: Add support for srmcfg CSR from Ssqosid extension

Add support for the srmcfg CSR defined in the Ssqosid ISA extension.
The CSR contains two fields: Resource Control ID (RCID) and Monitoring
Counter ID (MCID) for tracking resource usage.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0

>     resctrl_arch_set_closid_rmid() updates it when a task is assigned to a
>     resctrl control or monitoring group.
>    =20
>     A per-cpu cpu_srmcfg_default holds the default srmcfg for each CPU, s=
et
>     by resctrl_arch_set_cpu_default_closid_rmid() on CPU group assignment.

[Severity: Medium]
Are these resctrl architecture callbacks missing from this patch series?

The commit message mentions resctrl_arch_set_closid_rmid() and
resctrl_arch_set_cpu_default_closid_rmid(), but they do not appear to be
implemented.

Without these integration functions, the new srmcfg field in thread_struct
and the cpu_srmcfg_default per-CPU variable are never updated.

Does this leave the context-switch tracking as functionally dead code that
only ever zeroes the CSR?

> diff --git a/arch/riscv/kernel/qos.c b/arch/riscv/kernel/qos.c
> new file mode 100644
> index 0000000000000..99925c0e93dd8
> --- /dev/null
> +++ b/arch/riscv/kernel/qos.c
[ ... ]
> +static int riscv_srmcfg_reset_cache(unsigned int cpu)
> +{
> +	per_cpu(cpu_srmcfg, cpu) =3D U32_MAX;
> +	return 0;
> +}
[ ... ]
> +static int __init riscv_srmcfg_init(void)
> +{
> +	int err;
> +
> +	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SSQOSID))
> +		return 0;
> +
> +	/*
> +	 * cpuhp_setup_state() invokes the startup callback locally on every
> +	 * already-online CPU, so no separate seed loop is needed here.
> +	 */
> +	err =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/srmcfg:online",
> +				riscv_srmcfg_reset_cache, riscv_srmcfg_reset_cache);

[Severity: High]
Does this late CPU hotplug cache invalidation allow newly onlined CPUs to
execute with implementation-defined CSR values?

The CPU cache invalidation happens at CPUHP_AP_ONLINE_DYN, which runs on the
target CPU itself. This means the CPU has already booted and context-switch=
ed
into the hotplug thread before riscv_srmcfg_reset_cache() is called.

If a CPU is offlined while its software cpu_srmcfg cache happens to be 0, a=
nd
then powered back on, its hardware SRMCFG register initializes to an
implementation-defined value.

When the CPU context-switches to the cpuhp thread (which has a default
srmcfg of 0), __switch_to_srmcfg() might see that the incoming thread's 0
matches the stale software cache's 0.

Could this bypass the necessary CSR write, leaving the CPU to run with
garbage values in the SRMCFG hardware CSR until the next context switch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-dfustini-a=
tl-sc-cbqri-dt-v4-0-e75c20201d64@kernel.org?part=3D3
