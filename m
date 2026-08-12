Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059DC330678;
	Wed, 12 Aug 2026 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514407; cv=none; b=qBI+XD0FCDNXBMO4mtvAywi7jI9V+XH8Yr6EAfgC3/LW/A+rfPg8Dqq+2urC+qK+4FgWcxM4k/IyzEd7yxf9SKbNhCd8yiJylFppk58au/0c2U1HNvlcS4Fb4AZCMQMCROS3zoBxDz6xsmTae3217ML3AXSwX9KA8SEpvfj+RLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514407; c=relaxed/simple;
	bh=7w3AzN8WwtTvKzQfxVijiq5A30TXLQyNw5zbByksg2o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Cyjnthu2p1VH67gcB0ReA3s2pn6H/I2k6zxBjvwo2ngvwqwY+a+lBFWGeFu18XT5MBBbdJKvz/qmcQILltclyCXAhacKtUUv6vn9lAwFEvlLxUwnaS3PMf2BDaoV6OYkTv29G1xZ+4m7056XcNIMhqG/n0QAkjKNQlJtx+QAzdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMhRyXQR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMhRyXQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC081F000E9;
	Wed, 12 Aug 2026 06:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786514405;
	bh=iDFvyI8hhZ2MGl8yC5gADMDJMU8GPuFMc3qgwx0pGvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aMhRyXQRw11ocIEHTWEGIlJjAWRLjBWVeOXh40PRGc+FFYUBW/uEtYO5YBNaj6oIF
	 nlufSjHXsy/ATvtKsQN1zMmEaWxLjdikP9reqdOp5GBPIndeimOLxMeiMsAC34JEDc
	 HhIZT0KV10A6J46kOKdhmW0zWj9U7gXPJPmhqVynbfQiZTM4/+8wkNFV+6NdL9UWUY
	 jGWiZTGcudlWxj0pb8LoNwlQ4GDnE76MuNtN+QUbUpNAZFFTjLri/NqrM1phLJmwP+
	 V4HcZ/y8sapLEkzWc29obnp0pyN7eLMsBp1iyNw21u8Lz/A+rrE53OKky9MeiMM1I1
	 E8lWxZ/NxteSQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] EDAC/aspeed: Add AST2700 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Chen" <ryan_chen@aspeedtech.com>
Cc: linux-kernel@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260812-edac-v1-7-03992edea297@aspeedtech.com>
References: <20260812-edac-v1-0-03992edea297@aspeedtech.com>
 <20260812-edac-v1-7-03992edea297@aspeedtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 06:00:05 +0000
Message-Id: <20260812060005.6BC081F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unconditional `IRQ_HANDLED` in `ast2700_dramc_isr()` combined with=
 selective interrupt clearing can cause an interrupt storm if a non-ECC int=
errupt is asserted.

Pre-existing issues:
- [High] The `mci` structure is freed in `aspeed_remove()` while the devm-m=
anaged interrupt handler is still registered and active, leading to a poten=
tial Use-After-Free.
--

--- Patch [7]: [PATCH 7/7] EDAC/aspeed: Add AST2700 support ---
commit c0a432a45b2a7c26475522dd80a9b976dbcdd2d3
Author: Ryan Chen <ryan_chen@aspeedtech.com>
Subject: EDAC/aspeed: Add AST2700 support

Add SDRAM ECC reporting for the Aspeed AST2700. Its DRAMC has a different
register layout, requiring new interrupt handling and per-chip ISR hooks.

> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index 91df5d2df5f11..8b48044a00d14 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c

[ ... ]

> @@ -174,6 +199,52 @@ static irqreturn_t aspeed_mcr_isr(int irq, void *arg)
>  	return IRQ_HANDLED;
>  }
> =20
> +static irqreturn_t ast2700_dramc_isr(int irq, void *arg)
> +{
> +	u32 int_sts, ecc_sts, fail_addr;
> +	struct mem_ctl_info *mci =3D arg;
> +	struct aspeed_edac *priv;
> +	u8 rec_cnt, un_rec_cnt;
> +	phys_addr_t addr;
> +
> +	priv =3D mci->pvt_info;
> +
> +	scoped_guard(raw_spinlock, &priv->lock) {
> +		int_sts =3D readl(priv->regs + AST2700_INT_STS);
> +		ecc_sts =3D readl(priv->regs + AST2700_ECC_STS);
> +		fail_addr =3D readl(priv->regs + AST2700_ECC_FAIL_ADDR);
> +
> +		/* the interrupt registers are not key-protected; clear only ECC */
> +		writel(int_sts & (AST2700_INT_ECC_RECOVERABLE | AST2700_INT_ECC_UNRECO=
VERABLE),
> +		       priv->regs + AST2700_INT_CLR);
> +	}
> +
> +	rec_cnt =3D FIELD_GET(AST2700_ECC_REC_CNT, ecc_sts);
> +	un_rec_cnt =3D FIELD_GET(AST2700_ECC_UNREC_CNT, ecc_sts);
> +
> +	/* the register holds address bits [35:4], in units of 16 bytes */
> +	addr =3D (phys_addr_t)fail_addr << 4;
> +
> +	/*
> +	 * The controller records only the address of the latest failure,
> +	 * shared by both error types. When only one type occurred it owns
> +	 * that address; when both occurred attribute it to the uncorrectable
> +	 * error and report the corrected ones without an address.
> +	 */
> +	if (un_rec_cnt && !rec_cnt) {
> +		count_un_rec(mci, un_rec_cnt, addr, true);
> +	} else if (!un_rec_cnt && rec_cnt) {
> +		count_rec(mci, rec_cnt, addr, true);
> +	} else if (un_rec_cnt && rec_cnt) {
> +		count_un_rec(mci, un_rec_cnt, addr, true);
> +		count_rec(mci, rec_cnt, 0, false);
> +	} else {
> +		dev_dbg_ratelimited(mci->pdev, "received interrupt with no ECC counter=
s set\n");
> +	}
> +
> +	return IRQ_HANDLED;
> +}

[Severity: High]
Can this cause an interrupt storm if a non-ECC interrupt is asserted?

The handler intentionally clears only the ECC interrupt bits in AST2700_INT=
_CLR,
but it unconditionally returns IRQ_HANDLED even if other unmasked bits were
asserted and left uncleared.

Because IRQ_HANDLED is returned unconditionally, the kernel's spurious
interrupt detector will not disable the level-triggered interrupt line. This
could result in an endless interrupt loop if a non-ECC bit is raised.

Would it be safer to return IRQ_NONE when no ECC bits are found, or ensure
all asserted bits are cleared?

[ ... ]

> @@ -354,9 +439,10 @@ static int aspeed_probe(struct platform_device *pdev)
>  static void aspeed_remove(struct platform_device *pdev)
>  {
>  	struct mem_ctl_info *mci =3D platform_get_drvdata(pdev);
> +	struct aspeed_edac *priv =3D mci->pvt_info;
> =20
>  	/* disable interrupts */
> -	aspeed_set_irq(mci, false);
> +	priv->chip->set_irq(mci, false);
> =20
>  	/* free resources */
>  	edac_mc_del_mc(&pdev->dev);
>  	edac_mc_free(mci);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does this code leave an acti=
ve
interrupt handler vulnerable to a use-after-free?

The interrupt is registered using devm_request_irq() in config_irq(), meani=
ng
it will be automatically freed after aspeed_remove() returns. However,
aspeed_remove() frees the mci structure here via edac_mc_free(mci).

If an interrupt is executing concurrently on another CPU, or fires after th=
is
point but before the devm cleanup completes, the ISR will access the freed
mci structure:

ast2700_dramc_isr()
    priv =3D mci->pvt_info;
    scoped_guard(raw_spinlock, &priv->lock) {
        ...
    }

Should the interrupt be explicitly synchronized or freed (e.g. using
devm_free_irq) before freeing the mci structure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-edac-v1-0-=
03992edea297@aspeedtech.com?part=3D7
