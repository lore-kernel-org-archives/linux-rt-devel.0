Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6FA34107F;
	Fri, 19 Jun 2026 18:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781894563; cv=none; b=LK9w/0Q4wzT7VHvMczYq5G42Z1qcBBm4alcA6uR0mn3XG6G3L1Kz0RM2LAHOse75EAAtC8J3l23fi2UvdDyzA2x0Rmjm1IXpoxmd6GI8nXeiicIWi02yDjhcnnoW903y+es4UP9ezDCQUkgFgNTISEC9P8wrZFba0JJ1qMEG6g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781894563; c=relaxed/simple;
	bh=jUOEIesE7SXyTTuOGHX62W+t33pfCu323O6sKs076j4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ijzchaSQ/pbKJGRlWhvvD/tHhgqdh+6kzdetm6Rty5H4i708Umih6xpjHQqEPrQadnSFZYBTszakEE10Kl16UgZJrnmo6wp4SskQxqzmJEu18exU7BlIAgdrL+oEByK924layzaGtHrPJkVg2HthWGYA5ny/EUMpHDGvTC73hxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kyd+Xx1G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kyd+Xx1G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3651F000E9;
	Fri, 19 Jun 2026 18:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781894561;
	bh=WYBvvVi5GRU4sM/uz/hTfBCMiFxUSofD8DJlsjjuWQo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kyd+Xx1Gl1J9tSmlPBqeVgUNGGbJc7lNwMvMGl5R4XjVs7PYnTC8uKY+P7UHPXmt5
	 F9n18E/BS80b0jVbC4dcHlJk0LOFpauAvPEu9jx+yp9acS86FENAqLKu6zjo+1q41/
	 Cay8YCrKMwZSXqFXSScHL5R/+0D/8dERJyVZM+GJcuSAkRM1m8oUSSYiMoiwGsr+y6
	 NPNXsBPRCvBTJZmVXrIB/PbFvtZKZ/DmH/RZpMbNu7JKSHHyxOtuSXcATHrzd+flPN
	 NOuv8i2zql7eXhTJi+6xL+XRVLYBnj32nnsS2sY+WvMFdHnt04uD2d+vikUtzKFIDb
	 lFKlgb9VuqTRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/8] riscv_cbqri: resctrl: Add cache allocation via
 capacity block mask
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260619-dfustini-atl-sc-cbqri-dt-v1-5-e79a7723fab0@kernel.org>
References: <20260619-dfustini-atl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org>
 <20260619-dfustini-atl-sc-cbqri-dt-v1-5-e79a7723fab0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 18:42:40 +0000
Message-Id: <20260619184241.2B3651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Presence of an unsupported cache level causes complete resctrl i=
nitialization failure instead of skipping the unknown cache.
- [Low] Enabling CONFIG_RISCV_ISA_SSQOSID and CONFIG_RESCTRL_FS without CON=
FIG_RISCV_CBQRI_DRIVER results in a build failure due to missing resctrl_ar=
ch_* implementations.

Pre-existing issues:
- [High] Software fails to set the BUSY bit when initiating CBQRI control o=
perations, causing the hardware to never execute the command.
--

commit 44771fe47dad2b92018db7b06dd244e6b25cc218
Author: Drew Fustini <fustini@kernel.org>

    riscv_cbqri: resctrl: Add cache allocation via capacity block mask
   =20
    This commit wires up the CBQRI capacity controllers into the resctrl
    subsystem as RDT_RESOURCE_L2 and RDT_RESOURCE_L3 schemata. It treats
    mismatched capacity controller capabilities at the same cache level as a
    fatal configuration error. It also lazily creates domains in the CPU
    hotplug online callback.

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index ee586925f9722..9eb65d0eaa070 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -594,6 +594,7 @@ config RISCV_ISA_SSQOSID
>  	bool "Ssqosid extension support for supervisor mode Quality of Service =
ID"
>  	depends on 64BIT
>  	default n
> +	select ARCH_HAS_CPU_RESCTRL

[Severity: Low]
Does enabling CONFIG_RISCV_ISA_SSQOSID and CONFIG_RESCTRL_FS without
CONFIG_RISCV_CBQRI_DRIVER result in a build failure?

Selecting ARCH_HAS_CPU_RESCTRL here expects the architecture implementations
to be available. However, looking at drivers/resctrl/Kconfig,
RISCV_CBQRI_RESCTRL_FS is only selected if RISCV_CBQRI_DRIVER is enabled.

Could this configuration mismatch cause a link error during the kernel
build because the required resctrl_arch_* hooks are not compiled?

[ ... ]

> diff --git a/drivers/resctrl/cbqri_resctrl.c b/drivers/resctrl/cbqri_resc=
trl.c
> new file mode 100644
> index 0000000000000..d354129cc34fe
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_resctrl.c
> @@ -0,0 +1,774 @@

[ ... ]

> +static int cbqri_apply_cache_config_dom(struct cbqri_resctrl_dom *hw_dom,
> +					struct rdt_resource *r,
> +					u32 closid, enum resctrl_conf_type t,
> +					u64 cbm)
> +{
> +	struct cbqri_resctrl_res *hw_res =3D
> +		container_of(r, struct cbqri_resctrl_res, resctrl_res);
> +	struct cbqri_cc_config cfg =3D {
> +		.cbm =3D cbm,
> +		.at =3D (t =3D=3D CDP_CODE) ? CBQRI_CONTROL_REGISTERS_AT_CODE :
> +					CBQRI_CONTROL_REGISTERS_AT_DATA,
> +		.cdp_enabled =3D hw_res->cdp_enabled,
> +	};
> +
> +	return cbqri_apply_cache_config(hw_dom->hw_ctrl, closid, &cfg);
> +}

[Severity: High]
This is a pre-existing issue, but does the software fail to set the BUSY bit
when initiating CBQRI control operations in the underlying hardware driver?

This problem was introduced earlier in the same series. Looking at
cbqri_cc_alloc_op() and cbqri_probe_feature() in
drivers/resctrl/cbqri_devices.c, the driver modifies and writes the control
register but omits setting the CBQRI_CONTROL_REGISTERS_BUSY_MASK bit to 1
before issuing the MMIO write.

Because the hardware relies on the BUSY bit to trigger the state machine,
would the operations never start? It seems the subsequent wait-loop
incorrectly succeeds immediately because it polls for BUSY =3D=3D 0, leading
the driver to silently believe the hardware executed the command.

[ ... ]

> +static int cbqri_resctrl_pick_caches(void)
> +{
> +	struct cbqri_controller *ctrl;
> +
> +	list_for_each_entry(ctrl, &cbqri_controllers, list) {
> +		struct cbqri_resctrl_res *cbqri_res;
> +		int rid;
> +
> +		if (ctrl->type !=3D CBQRI_CONTROLLER_TYPE_CAPACITY)
> +			continue;
> +		if (!ctrl->alloc_capable)
> +			continue;
> +
> +		rid =3D cbqri_cache_level_to_rid(ctrl->cache.cache_level);
> +		if (rid < 0) {
> +			pr_err("unknown cache level %d\n",
> +			       ctrl->cache.cache_level);
> +			return rid;

[Severity: Medium]
If the device tree specifies a CBQRI controller for an unsupported cache
level like L4, does this entirely abort the setup of the resctrl filesystem?

Instead of returning -ENODEV and causing complete resctrl initialization
failure, would it be better to skip the unknown cache with a continue
statement? Otherwise, this prevents QoS from functioning on perfectly valid
and supported caches like L2 and L3.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619-dfustini-a=
tl-sc-cbqri-dt-v1-0-e79a7723fab0@kernel.org?part=3D5
