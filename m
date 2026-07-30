Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2499C32ED40;
	Thu, 30 Jul 2026 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374549; cv=none; b=LIszdtztvDSOK45iRqvMRcz7gw1FZRc/JPLO1MjPA+UE0HG2RQhp/3PkxbjP30eJju8H+e4yTj6U/Dh3BLWxjD3Vg2WeShG04YkhNkDX5GFcCBjmIAZsRRUaDzV9ZxnMWyYhpEvKFcrI6veavNZLzprMWhRFxdWeQYb2u6I5zTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374549; c=relaxed/simple;
	bh=v+GKAzV4LU/SCUIsYQ43cKn9ZMWexs9fYvdBkHa7F0w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fufS11LA64L4thAmSLWOffRi1UArOTkWsZaT3gKkDQJBMLOR7zEI2ITtGAzxcl3g+JFaZL8KIcYcMFceD2DYW3e3cYwSlgnlw/stITiCP5XlboATsTfRhjuLIVMD8rXst+pYYCDLIl+KA9OZQs5hi1BljV8bM/oQjC6AN611x9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTcTfP95; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTcTfP95"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F5C1F000E9;
	Thu, 30 Jul 2026 01:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785374547;
	bh=u/A6smEN2MinHN2FQMu5UYm8l9+HDV7M++5ZimkU3hI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PTcTfP95hmfcssbQRElRROENUR0lhuqJiEc08i8J9cofYIgo6uO2CLMdLkccaz8NO
	 23tKC2vK024igk7TrBwehkPaB7ABnLOwRRjKxW67Qzv8c2oEkx+PvX/gjDDNd2v1Zo
	 OAHU6SlIInUrTc8H2FdCM+ckJNox8HcGVJlRdsyyLmpdV3i9VNvnP7DSnwG25ZxXOb
	 jp82yhCwvpSpfYIAdVGldvavId8kFpV3OntgxjkWO/rOxk6r9q14k09cFEBhlG8UGW
	 py3SwBnS3SNo5oCh62fy+daxiuyfr20cLi/FCKfzhbvQay8KY33GPrRfd54GmLal42
	 auVgdO0e2IFeQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/8] riscv: Add support for srmcfg CSR from Ssqosid
 extension
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, conor+dt@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260729-dfustini-atl-sc-cbqri-dt-v6-3-7c22b05d461b@kernel.org>
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
 <20260729-dfustini-atl-sc-cbqri-dt-v6-3-7c22b05d461b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:22:26 +0000
Message-Id: <20260730012227.58F5C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `srmcfg` CSR is not initialized during early boot or CPU hotpl=
ug bringup, leaving CPUs running with undefined QoS tags.
- [Medium] The architecture-specific resctrl setters `resctrl_arch_set_clos=
id_rmid()` and `resctrl_arch_set_cpu_default_closid_rmid()` are missing.
--

--- Patch [3]: [PATCH v6 3/8] riscv: Add support for srmcfg CSR from Ssqosi=
d extension ---
commit a02eee11a5e49e74d1e00459d9acc1ec4a1982fa
Author: Drew Fustini <fustini@kernel.org>

riscv: Add support for srmcfg CSR from Ssqosid extension

Add support for the srmcfg CSR defined in the Ssqosid ISA extension.
The CSR contains two fields: Resource Control ID (RCID) and Monitoring
Counter ID (MCID) for tracking resource usage.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0

> The context-switch path writes the field to the CSR, and
> resctrl_arch_set_closid_rmid() updates it when a task is assigned to a
> resctrl control or monitoring group.
>=20
> A per-cpu cpu_srmcfg_default holds the default srmcfg for each CPU, set
> by resctrl_arch_set_cpu_default_closid_rmid() on CPU group assignment.

[Severity: Medium]
Neither resctrl_arch_set_closid_rmid() nor
resctrl_arch_set_cpu_default_closid_rmid() appear to be implemented in this
patch.=20

Since they are missing, are thread_struct.srmcfg and cpu_srmcfg_default ever
actually modified from their initial zero values?

> diff --git a/arch/riscv/kernel/qos.c b/arch/riscv/kernel/qos.c
> index 0000000000000..99925c0e93dd8
> --- /dev/null
> +++ b/arch/riscv/kernel/qos.c
> @@ -0,0 +1,101 @@

[ ... ]

> +	/*
> +	 * cpuhp_setup_state() invokes the startup callback locally on every
> +	 * already-online CPU, so no separate seed loop is needed here.
> +	 */
> +	err =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/srmcfg:online",
> +				riscv_srmcfg_reset_cache, riscv_srmcfg_reset_cache);

[Severity: High]
Does this software cache correctly handle CPU hotplug and early boot?

When a CPU is offlined, it continues context-switching as it goes down, whi=
ch
overwrites the U32_MAX cache sentinel with a valid tag (such as 0 for the i=
dle
thread).

When the CPU is brought back online, its hardware srmcfg CSR is reset to an
implementation-defined value. If the software cache cpu_srmcfg is still 0, =
the
first context switch to a task with a 0 tag in __switch_to_srmcfg() will see
thread_srmcfg =3D=3D cpu_srmcfg and skip the CSR write:

arch/riscv/include/asm/qos.h:__switch_to_srmcfg() {
    ...
    if (thread_srmcfg !=3D __this_cpu_read(cpu_srmcfg)) {
        __this_cpu_write(cpu_srmcfg, thread_srmcfg);
        csr_write(CSR_SRMCFG, thread_srmcfg);
    }
    ...
}

This leaves the hardware CSR undefined until this CPUHP_AP_ONLINE_DYN start=
up
callback runs. Is CPUHP_AP_ONLINE_DYN too late to prevent the CPU from runn=
ing
with undefined QoS tags?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-dfustini-a=
tl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org?part=3D3
