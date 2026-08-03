Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83F33B6C18;
	Mon,  3 Aug 2026 06:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785738873; cv=none; b=h+7/t0vDSv1eqKgnt3S69gie1Ehpxn6gbbs0yCTk9pujle8Mkz2N+i1t5QXjD9f7DFkB3WBRjuGHEBv5+Sjdt0NdbmymonEz9CFLHjykRa+oZYGFq0iAycLX2dFGPWwJ47BrQ6s0FbRuPqh1JJznceeQ9eIbKpcpkOVtfwLDHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785738873; c=relaxed/simple;
	bh=nO51FQdO5ImZYCrFSQ6/Hyhu4g6a3rR53H83DavsJ2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qdq6dcCJ/X7xIM/P6ueJtIcP3Sqa0yPBDQkYZT5wK7KGiSH6RCvd37cLGRz6dlWKwPsaYbC+7kK36rjklCRt5gQOx0k6aulh/mFCNXWS2Bg4vFcCYOhEpj6Qgxv5G8bx14xVcGyxsCDiKeXztmQiEyI7Xav7wMUfPE0vTy1O1pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FqsnT/P0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FqsnT/P0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205EC1F000E9;
	Mon,  3 Aug 2026 06:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785738871;
	bh=tpVdomlbMg0+OxXRZ8UUrBMlFMf6DT1oL/Nd62kJLTU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FqsnT/P0keMHZoAVHGs6MYzMYGkNlIDGOVXL0tP+gsGvy6i1ClBUCDBq+MBSfJlwa
	 vcKnI/YCbamuuEiuv7QdhbuCeOFDmp77mqMPi7pv9qdhrZATTkEgsJjZX8Y9YgWg4E
	 0bHMVpefaiNWxfUocvLgocQSfhCyMBn1iqFC21C/d9q55SHe6U1zOrIEdF8bhxbgH1
	 5Ysyzlcqr1dSPEtQOPJ5vUkBM+5Jv+3oTXut3y1Zmazw13gtoatPHgxNvThmDuxDfd
	 F0nC0vxYrd9gUxfpCFZjIhFG2M2VzxIhqg6yWI1tLGUkAalurBukUprdEeZ43lxCe8
	 895huqXciFMtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pinctrl: stm32: use a raw spinlock regmap to program
 the EXTI mux
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ju Nan" <junan76@163.com>
Cc: mfd@lists.linux.dev, linux-rt-devel@lists.linux.dev, lee@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260803061718.43210-1-junan76@163.com>
References: <20260803061718.43210-1-junan76@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 06:34:30 +0000
Message-Id: <20260803063431.205EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Bypassing standard syscon regmap initialization leaves the syscfg =
clock disabled, leading to hardware bus faults on platforms where the syscf=
g node requires a clock.
- [High] If another driver sharing the syscon node probes before pinctrl, t=
he generic syscon layer will create a default regmap without `use_raw_spinl=
ock`, causing the PREEMPT_RT sleeping-in-atomic bug to persist.
--

--- Patch [1]: [PATCH] pinctrl: stm32: use a raw spinlock regmap to program=
 the EXTI mux ---
commit e662d8a81eaff2488e3427af7c289ca0a5b94fde
Author: Ju Nan <junan76@163.com>
Subject: pinctrl: stm32: use a raw spinlock regmap to program the EXTI mux

This commit addresses an invalid wait context issue on PREEMPT_RT by manual=
ly
publishing a regmap with use_raw_spinlock =3D true for the st,syscfg node. =
It
attempts to preempt the generic syscon layer from instantiating a default
regmap protected by a sleeping spinlock. The interrupt multiplexer is then
programmed using this raw-spinlock-protected regmap.

Closes: https://lore.kernel.org/all/20220202174430.pf37tt6lua2op3gc@pengutr=
onix.de/

> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm3=
2/pinctrl-stm32.c
> index 6a99708a5a23c..39df117489d12 100644
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
[ ... ]
> @@ -1757,6 +1757,68 @@ static struct irq_domain *stm32_pctrl_get_irq_doma=
in(struct platform_device *pde
[ ... ]
> +static void stm32_pctrl_publish_syscfg_regmap(struct device_node *np)
> +{
> +	struct regmap_config config =3D stm32_pctrl_syscfg_regmap_config;
> +	struct device_node *syscfg_np;
> +	struct regmap *regmap;
> +	void __iomem *base;
> +	struct resource res;
[ ... ]
> +	/*
> +	 * The regmap is handed over to the syscon layer, which never releases
> +	 * it, so it must outlive this driver: no device managed allocation
> +	 * here, and no device to attach it to either.
> +	 */
> +	regmap =3D regmap_init_mmio(NULL, base, &config);
> +	if (IS_ERR(regmap)) {
> +		iounmap(base);
> +		goto out_put;
> +	}

[Severity: High]
Does bypassing the standard syscon regmap initialization leave the syscfg
clock disabled?

The generic syscon handling normally calls of_clk_get() and=20
regmap_mmio_attach_clk(). Since this manual initialization skips that, the
clock is never attached to the regmap.

On platforms like STM32F4/F7/H7 where the syscfg node explicitly requires a=
=20
clock, could writing to the EXTI mux registers in stm32_gpio_domain_activat=
e()
with the clock disabled trigger an imprecise external abort (bus fault)?

> +
> +	/*
> +	 * A regmap is already registered for that node, most likely by the
> +	 * other pinctrl instance sharing it. Drop ours and use that one.
> +	 */
> +	if (of_syscon_register_regmap(syscfg_np, regmap)) {
> +		regmap_exit(regmap);
> +		iounmap(base);
> +	}

[Severity: High]
If another driver sharing the st,syscfg node (like Ethernet MAC, I2C, or US=
B)
probes before pinctrl, won't the generic syscon layer have already
instantiated a default regmap without use_raw_spinlock?

In that scenario, of_syscon_register_regmap() would return an error and the
driver silently discards its raw regmap. Since the driver then falls back to
the already registered sleeping regmap, does this cause the PREEMPT_RT=20
sleeping-in-atomic bug to persist when stm32_gpio_domain_activate() writes =
to
the regmap under the raw desc->lock?

> +
> +out_put:
> +	of_node_put(syscfg_np);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803061718.4321=
0-1-junan76@163.com?part=3D1
