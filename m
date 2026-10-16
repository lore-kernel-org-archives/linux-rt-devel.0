Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41D254B03;
	Fri, 16 Oct 2026 04:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123354; cv=none; b=pulgGG4B4Y8XGrrsw3EAnQR00i9k4q79+nCtEWlS4731YuDruwBWXZ2DdJ2XcUxhxjFoU+UcRNxhgChVWBrYS7daGdW2025W7PDF2RV602LP2XZoRXhL+DJK1Wo+jwMS/eHT+gs0KYC8LN4G3GczJwSPmpO+OqMJIu3GLFaIz3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123354; c=relaxed/simple;
	bh=D/7WZn96n/4VQB8L8pTjKKxOtCun2ZxLUzSvWC0YHM8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=sqYzbpKLinrSE6LFvS/lg8dA1WMAsLcYGRf1ujXVAjtVbkBqWaTxvYkIwb7GhmzZeyNeUNt62uKWwWt/jchaNKfeQibBsh/wa4i/hYyGz8hblqR03vUOyJCakCgbbxkmoSjHAxiL7bcdDhpEDVHGaYfYnUJh0m5+ZwwikYS61ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OedRXRla; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OedRXRla"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888A51F000C4;
	Fri, 16 Oct 2026 04:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792123353;
	bh=NYhYtY6NNxHVhaTXOhMMsowXI57SxMv7/T8lMzWMVN8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OedRXRlapUce4ZGThtU3JvUeqJMCsQv8lMObcrwmI61z2UHc0QWOmhzVm6DNtGp5L
	 chuK0oubaBpriDQSOUC8YCT3+0bYTaYmJesqyIFDUFXPiVs2uJkBZRe/L+XkEwKFjT
	 nzznNLTeqj1Oxh0o6qE/hhhJwD08qBFwFLHuiT13uZHKBqpPwX+ILWkoG3wpp6EWn+
	 T1lCbXIkIiNszSfWuOrKJea2GE81s8ziROlv/8rt2hhCw+VWcUe66InWcMy5H7foSX
	 B7kl+vxTppAGGpUpuiux4aQVIazKdM4oSgS83hJkmkr2AWLYmx9BA4VC1nAmp/FQwZ
	 9zYP3GWUDPrkA==
Message-ID: <sashiko-outbox-173724@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 17/17] mtd: rawnand: sunxi: support the Allwinner
 randomized OOB format
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Richard
 Weinberger" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>
Cc: "Chen-Yu Tsai" <wens@kernel.org>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Samuel
 Holland" <samuel@sholland.org>, "Maxime Ripard" <mripard@kernel.org>, "Richard
 Genoud" <richard.genoud@bootlin.com>, "Boris Brezillon" <bbrezillon@kernel.org>, "Masahiro
 Yamada" <yamada.masahiro@socionext.com>, "Brian Norris" <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-17-8ba4881fbee8@gmail.com>
References: <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-0-8ba4881fbee8@gmail.com>
 <20261015-submit-sunxi-nand-vendor-oob-layout-v1-v8-17-8ba4881fbee8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 04:02:32 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mtd: rawnand: sunxi: Missing bounds check on ecc->steps against ma=
x_ecc_steps
--

commit a2ae1cf95bb52a1850e6dc239c873b74d175805e
Author: James Hilliard <james.hilliard1@gmail.com>

    mtd: rawnand: sunxi: support the Allwinner randomized OOB format
   =20
    Normal hardware-ECC reads also decode protected OOB, including the
    bad-block marker and metadata used in bad-block-table scans. Allwinner
    firmware leaves the marker in the randomizer stream, but the existing
    driver compensates it to keep a plain physical marker. On H6/H616,
    firmware also packs protected user data before the first parity region
    rather than maximizing its allocation across the page. Those mismatches
    prevent normal ECC reads from interpreting firmware-formatted pages and
    their markers.

> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index 56594bb411933..0e2ff1c59120f 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c

[ ... ]

> @@ -2342,6 +2353,299 @@ static const struct sunxi_nfc_oob_ops sunxi_nfc_s=
crambled_plain_bbm_oob_ops =3D {
>  	.finish_read =3D sunxi_nfc_oob_finish_read,
>  };
> =20
> +/* Allwinner randomized-OOB format, selected only by allwinner,randomize=
d-oob. */
> +#define SUNXI_NFC_H6_ALLWINNER_OOB_MAX_USER_DATA_SZ 16
> +
> +static void sunxi_nfc_randomize_buf(u16 state, u8 *buf, unsigned int len)
> +{
> +	while (len--) {
> +		*buf++ ^=3D state;
> +		state =3D sunxi_nfc_randomizer_step(state, 8);
> +	}
> +}
> +
> +static void
> +sunxi_nfc_allwinner_oob_record_status(struct nand_chip *nand,
> +				      struct sunxi_nfc_allwinner_oob_status *result,
> +				      int logical_step, int hw_step,
> +				      struct sunxi_nfc_ecc_snapshot *snapshot)
> +{
> +	u32 count;
> +
> +	if ((snapshot->pattern_found & BIT(hw_step)) &&
> +	    !(snapshot->pattern_id & BIT(hw_step)))
> +		result->zero_steps |=3D BIT(logical_step);

[Severity: High]
Does this code invoke undefined behavior if logical_step exceeds the bit-wi=
dth?

The number of ECC steps is derived directly from the NAND page size in
sunxi_nand_hw_ecc_ctrl_init():

	nsectors =3D mtd->writesize / ecc->size;
	ret =3D sunxi_nand->oob_ops->init_user_data(nand, nsectors);

It doesn't appear that nsectors is validated against the controller's
max_ecc_steps limit. If a NAND flash with a large page size is used,
ecc->steps (and thus logical_step) can exceed the hardware limit (e.g.,
16 or 32). On 32-bit platforms, this could cause the BIT(logical_step)
shift to overflow.

Additionally, this could lead to out-of-bounds MMIO reads in
sunxi_nfc_hw_ecc_get_prot_oob_bytes() when iterating over ecc->steps,
as reg_index might exceed the supported hardware registers for user data.

[ ... ]

> +static int sunxi_nfc_allwinner_oob_finish_read(struct nand_chip *nand,
> +					       struct sunxi_nfc_ecc_read *read,
> +					       int *cur_off)
> +{
> +	struct sunxi_nfc_allwinner_oob_status *result =3D &read->allwinner_oob;
> +	u8 *buf =3D read->buf;
> +	bool oob_required =3D read->oob_required;
> +	bool dma =3D read->dma;
> +	int page =3D read->page;
> +	struct mtd_info *mtd =3D nand_to_mtd(nand);
> +	struct nand_ecc_ctrl *ecc =3D &nand->ecc;
> +	int ret;
> +
> +	/*
> +	 * Allwinner firmware treats an all-zero physical page as bad, even wit=
hout
> +	 * ECC errors. This takes precedence over the spare-byte heuristic.
> +	 */
> +	if (result->zero_steps =3D=3D GENMASK(ecc->steps - 1, 0)) {

[Severity: High]
Can GENMASK() invoke undefined behavior here if ecc->steps exceeds the
architecture's bit-width?

Similar to the BIT() shift above, since ecc->steps isn't bounded by
max_ecc_steps, a large page size could cause this range to exceed 32 bits,
leading to an overflow.

> +		memset(buf, 0, mtd->writesize);
> +		memset(nand->oob_poi, 0, mtd->oobsize);
> +		mtd->ecc_stats.failed +=3D ecc->steps;
> +		return 0;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-submit-sun=
xi-nand-vendor-oob-layout-v1-v8-0-8ba4881fbee8@gmail.com?part=3D17
