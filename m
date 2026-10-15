Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DB133939C;
	Thu, 15 Oct 2026 01:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029020; cv=none; b=SZBsHR3kNtLc8d1i3QjnKLe/X5mCWhb9VdqlIsOCgcv/PRzTF9h65vBfiqABOkCmjIWRotCmShrKKvtDXtG6Idiy/kHxrFdsx9Frz+oPaOaCIB1rvbX0IkF49yef5KVNz6dy1uabhCYK4tHI3ojCmR8/VlZ1asBGDgmMKktKSmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029020; c=relaxed/simple;
	bh=lqzqa6mXZFZB56ZiAqpMIdWmUh42nRNUKyxJ3d69eCw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZoYQ+qGDUXB8IPZMwaUpcke0DsQwnUnYPS6IuP//crfevdXkYI5l+sj+OhF2QR7qyleizN7ERRBg23tVsOTqeFnVvf15rwhHWuJMXPJhf/p6Wj0sheqEIMs7nf8/EejeON4Hi1jaD/y3zt6EQnZ0FJckoEV6o58Lpy3RUliNI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGJf06ng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGJf06ng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A73B1F000C4;
	Thu, 15 Oct 2026 01:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792029019;
	bh=XqCsBBDToclNhntWS7LwgwCgD6io3q7EceQlCXtUiuU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PGJf06ngwaQwr3biaCaU9TpAVmbFprp7n3Ipjgw+QnNJyDJ6lP8jJISWbjlWWJsTa
	 R4RnmmLTaQliAuKDYnjo3ypOGMbGxsfj+RMFnYjUcWW3bzl9BaQ5I0esD/h9ePfMHb
	 nRY17QRgTs9OdkABkpahY0OK4HO82/qPvVlZKtB06Mckthp7Vq/FQzBScGiNcbOZmy
	 2P5NykZAhpS4+7brbXgufHXsK839w8P4xnvYIGRtHHfw+7oSyHH0GDGYx9pxMcL+fW
	 9Eb+VF+d+U3mHcBgLwxvNNLOUO44ZX5amNIGycT8tAl16/mZ1Xi9XwXYcl6Y9HWqMy
	 7zXqFugGYiDvw==
Message-ID: <sashiko-outbox-172123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/16] mtd: rawnand: sunxi: select the pattern ID for
 the current ECC step
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
In-Reply-To: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-6-5d3fc6ad2da1@gmail.com>
References: <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-0-5d3fc6ad2da1@gmail.com>
 <20261014-submit-sunxi-nand-vendor-oob-layout-v1-v7-6-5d3fc6ad2da1@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 01:50:16 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] mtd: rawnand: sunxi: PIO mode overwrites zero pattern with SRAM =
garbage
--

commit 6c354ef3bc88ac95cdf40b092e5c146de75aa789
Author: James Hilliard <james.hilliard1@gmail.com>
Subject: mtd: rawnand: sunxi: select the pattern ID for the current ECC step

This commit fixes the pattern-ID register check during ECC exception mode.
It updates the correction helper to test the bit corresponding to the
current hardware step rather than always checking bit zero, which ensures
DMA processing classifies physical all-zero and all-ones data blocks
correctly.

> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index 57df88099206a..8256982d1d565 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -1101,7 +1101,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chi=
p *nand, u8 *data, u8 *oob,
>  	if (pattern_found & BIT(step)) {
>  		u8 pattern;
> =20
> -		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & 0x1))) {
> +		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID(nfc)) & BIT(step)))) {
>  			pattern =3D 0x0;

[Severity: Medium]
When the pattern is identified as 0x0, the *erased out parameter remains
false. Later in sunxi_nfc_oob_read_batch(), the code checks this boolean
and handles PIO mode (!read->dma) by copying directly from SRAM:

sunxi_nfc_oob_read_batch() {
    ...
    if (erased) {
        read->has_erased_chunk =3D true;
        continue;
    }

    if (!read->dma)
        memcpy_fromio(data, nfc->regs + NFC_RAM0_BASE, ecc->size);
    ...
}

If scrambling is enabled for a physical all-zero block read in PIO mode,
will this memcpy_fromio() overwrite the valid zeros populated in
sunxi_nfc_hw_ecc_correct() with descrambled pseudo-random garbage from
the SRAM?

It appears this regression leaves PIO broken while fixing DMA zero
pattern reads.

>  		} else {
>  			pattern =3D 0xff;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014-submit-sun=
xi-nand-vendor-oob-layout-v1-v7-0-5d3fc6ad2da1@gmail.com?part=3D6
