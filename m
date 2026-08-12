Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D4256C8B;
	Wed, 12 Aug 2026 06:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514484; cv=none; b=tTXihEhHcSKxuKBKuXALdOZsRKDX1a0l5CLzqk+Gz5bxSnxp3z4p3hKUeE7IrG54TWd/bL4BsvtmD63CHX2N0VZRIlT0mBE2wu3UAZAZ7eYpfqL7kRlXMBs6r0diod1icjVp5Am+rGMFReo0RGJlLbEBDnGyqR5s11LiJcUabfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514484; c=relaxed/simple;
	bh=ySbQEE5F2LJU7WgYs2oq+UVvrzG8K+2GVYB6naGhWVg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6FhyOLqh0WJgC/58rugLG5guuhFP47WOXnB1bl3V+z1f7sDptaETkw3aQ8LzpANjWTqQAYrFdI0qpi0Oo1iS6aNUVQDoP7ztbtYX0aZfSmY7EPeEaJgUtm89n7p4LuiVypwtyxHjat6DDnQ7ImDxv8X+casCYPC5Zi4XYNKTiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUBW5wjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUBW5wjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63351F000E9;
	Wed, 12 Aug 2026 06:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786514482;
	bh=IDn8WKxkKqu7/UcHP3E+qpgfa3J4Ik5rqLQmcB2LLK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUBW5wjJJQ8U0kYOqrfde3jj4xpBTCMPnIRG0xVRkPNT60Kqh83oXgZc91uKE5JfX
	 FxEHQgF9FU4js7OJ8qva/k2fQ1wDhdXmh3ecz8I4chC7qpdv/TCRv0PqeEoeJnYGP1
	 JPdlNK0D88/YYJBPuIYQN1oO8/zwyDXkSPF0xgSzRCrh5T5i+iERIyznClt4mBIniz
	 tc+rAk3TmMz50DI5uCqCcsSsqAIS8YvXx9V45o+IvjMJdtyaPNGXB55gXq8EV7eSW0
	 A041Fc6w4CJ+3jMY4cvean2wVzeZTcup1ZSNZ5naENqyytwQe/QMiYyVNscfSRwe31
	 q34oUgghMtAEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] EDAC/aspeed: Abstract SoC differences behind chip
 data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Chen" <ryan_chen@aspeedtech.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260812-edac-v1-6-03992edea297@aspeedtech.com>
References: <20260812-edac-v1-0-03992edea297@aspeedtech.com>
 <20260812-edac-v1-6-03992edea297@aspeedtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:01:21 +0000
Message-Id: <20260812060121.D63351F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The `mci` structure is freed before the devm-managed interrupt han=
dler is unregistered, leading to a Use-After-Free.
- [High] Lockdep splat due to acquiring `priv->lock` with interrupts enable=
d.
--

--- Patch [6]: [PATCH 6/7] EDAC/aspeed: Abstract SoC differences behind chi=
p data ---
commit 95a7cd8a39c90d2b48dfabaca16f91703e3c872b
Author: Ryan Chen <ryan_chen@aspeedtech.com>

EDAC/aspeed: Abstract SoC differences behind chip data

The driver hard-codes the AST2400/2500/2600 register layout, ECC and
DRAM-type bits, memory types and write-protection key. Abstract these
SoC-specific details behind a per-SoC struct aspeed_edac_chip selected by
the compatible, and move the per-instance state (register base, lock)
into mci->pvt_info instead of globals.

> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index 7bd552ee9a612..91df5d2df5f11 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
[ ... ]
> @@ -213,12 +249,12 @@ static int init_csrows(struct mem_ctl_info *mci)
>  	nr_pages =3D resource_size(&r) >> PAGE_SHIFT;
>  	csrow->last_page =3D csrow->first_page + nr_pages - 1;
> =20
> -	scoped_guard(raw_spinlock, &aspeed_lock)
> -		reg04 =3D readl(aspeed_regs + ASPEED_MCR_CONF);
> -	dram_type =3D (reg04 & ASPEED_MCR_CONF_DRAM_TYPE) ? MEM_DDR4 : MEM_DDR3;
> +	scoped_guard(raw_spinlock, &priv->lock)
> +		conf =3D readl(priv->regs + priv->chip->conf_reg);

[Severity: High]
This isn't a bug introduced by this patch, but could this lock acquisition
cause a lockdep violation?

This lock is acquired in hardirq context by aspeed_mcr_isr(). By using
scoped_guard(raw_spinlock, ...) here in init_csrows(), the lock is acquired
with interrupts enabled in process context.

Does acquiring the same lock both in hardirq context and with interrupts
enabled trigger a lockdep warning?

> +	type =3D field_get(priv->chip->conf_dram_type, conf);
> =20
>  	dimm =3D csrow->channels[0]->dimm;
> -	dimm->mtype =3D dram_type;
> +	dimm->mtype =3D priv->chip->dram_type[type];
>  	dimm->edac_mode =3D EDAC_SECDED;
[ ... ]
> @@ -311,17 +356,36 @@ static void aspeed_remove(struct platform_device *p=
dev)
>  	struct mem_ctl_info *mci =3D platform_get_drvdata(pdev);
> =20
>  	/* disable interrupts */
> -	aspeed_set_irq(false);
> +	aspeed_set_irq(mci, false);
> =20
>  	/* free resources */
>  	edac_mc_del_mc(&pdev->dev);
>  	edac_mc_free(mci);

[Severity: High]
This is a pre-existing issue, but does this devres-managed IRQ ordering cau=
se
a use-after-free here?

Because the interrupt is registered with devm_request_irq() during probe, it
is not actually unregistered and synchronized until the devres cleanup phas=
e,
which happens after aspeed_remove() returns.

If an interrupt handler is running concurrently on another CPU during remov=
al,
could it dereference mci and mci->pvt_info after edac_mc_free(mci) has freed
them?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-edac-v1-0-=
03992edea297@aspeedtech.com?part=3D6
