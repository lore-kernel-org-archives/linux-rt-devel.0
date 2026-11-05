Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906002;
	b=HZy8ef0ooOBzf2vTOWYJSLU/YHUpBVvRuOgdd3Nybvw7pc9O0ITeU9HSHEDxApZuMmde
	 OxnEl+wT7Y4TTCnvVj/nuPZAAd0wuvpkguPXJBkNpswPIeFCSujpP1UL6frJmQyVZRkLB
	 1ABkQhs0kP52LFtGqDWu+z49b6KX+YELVX+f2DXs5cEQ4aTGiXyF8UC0UpmAF9Z4bFUDL
	 XB08ASnr1s+bNWuWQFReIEQODLPQJVcFx8dJF6cDx2IipKdxuqDCkhJsUgQ+fOQxyD5ZG
	 lyuClre7adKWFE6c9TcUIj0hqCvwTzMoS8Oq51Zt38vX1+c3IQwiZhY8004b/LNtH4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906002;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bWoUw0v85zV3qDcWRLloegiWXI8H90sykJZsNR/TAqw=;
	b=fWz4G9UmphQ3f4VyyvhrwwRpr6sdHHCyZ0J5Ha+g4m13MxcSpJp0QQgRGE2Tq7FnxZ+f
	 3K51EfMvvmr7eDhylrvZnCajn3aUQ+5tZIqkT92em3xIYu/iaiNPr/EVjM0+6jX4yeBSU
	 9CBLTuFekYV9GPBjo7+q1jCwJUyMZ8C/nf10hfGlmDXGg9WGceDnebsyGT73yfWWGMecl
	 HJxWCoB2Kc18e60LMNaOYI3TL9CCn94kNKY1grNITD4zk28zCh48LUUar+kv8IOnoTaIk
	 H1ebib96WHO3BFShuTXr5DaxYvJMJj4/dbqDGdNRq0leTEmTfNXPtMdptmy03hfTjzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCgVm33R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A20606A31B;
	Thu,  5 Nov 2026 19:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lCgVm33R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C151F000C1;
	Thu,  5 Nov 2026 19:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906001;
	bh=bWoUw0v85zV3qDcWRLloegiWXI8H90sykJZsNR/TAqw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lCgVm33RLYIh8TNpmuCn12/xAde129MgnsOWokB3gB6Rv91jNMzmtOSM257Ty9a7N
	 2e/SKFKpw1DOZe70ojYG0BZqOUu/bOxnqFqPKtSfGkfEDaakQFFeoQ6C4uiT3eIX+m
	 FUVnkJnAIULk52NAqho+YjViL9OsMWyVhVU6dKdskJOqEt7fpnQJVTyHjAO2V+nFDA
	 dhgTSRbkn4RZzfNe+5+HAHoPmopQe0uGJn1ylama7Q1583QpQpqYqTguX4twG4mfvr
	 dsr9nonV2SFJUqJAgK5Lewr2vtbCbR65T5vRCoLXUS23ND2em+CVCdH+J0b2uAkdZq
	 FcztQSYXaouUA==
Message-ID: <sashiko-outbox-199823@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 01/26] mtd: rawnand: sunxi: centralize OOB handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Hilliard" <james.hilliard1@gmail.com>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Richard
 Weinberger" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Philipp
 Zabel" <p.zabel@pengutronix.de>
Cc: "Chen-Yu Tsai" <wens@kernel.org>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Samuel
 Holland" <samuel@sholland.org>, "Maxime Ripard" <mripard@kernel.org>, "Richard
 Genoud" <richard.genoud@bootlin.com>, "Boris Brezillon" <bbrezillon@kernel.org>, "Masahiro
 Yamada" <yamada.masahiro@socionext.com>, "Brian Norris" <computersforpeace@gmail.com>, linux-mtd@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-1-dca1f6ed29a8@gmail.com>
References: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
 <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-1-dca1f6ed29a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:13:20 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] mtd: rawnand: sunxi: premature oob_ops selection in sunxi_nand_att=
ach_chip()
- [Medium] mtd: rawnand: sunxi: unaddressed maintainer NACK on vendor OOB l=
ayout ops
--

commit 8fda5c99d9befa1771418516828f040de60c5845
Author: James Hilliard <james.hilliard1@gmail.com>

mtd: rawnand: sunxi: centralize OOB handling

This commit centralizes hardware ECC result interpretation, protected OOB
retrieval, erased-chunk checking, and user-data layout reservation behind
per-chip sunxi_nfc_oob_ops callbacks for both PIO and DMA paths.

> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index f41feebe42571..80006d1a33d68 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
[ ... ]
> @@ -2066,6 +2096,58 @@ static int sunxi_nfc_maximize_user_data(struct nan=
d_chip *nand, uint32_t oobsize
[ ... ]
> +/*
> + * Both modes use the same layout and ECC policy. Scrambled transfers al=
so
> + * compensate the first two user bytes to keep the on-flash BBM unmodifi=
ed.
> + */
> +static const struct sunxi_nfc_oob_ops sunxi_nfc_plain_oob_ops =3D {
> +	.min_user_data =3D sunxi_nfc_oob_min_user_data,
> +	.init_user_data =3D sunxi_nfc_oob_init_user_data,
> +	.read_batch =3D sunxi_nfc_oob_read_batch,
> +	.finish_read =3D sunxi_nfc_oob_finish_read,
> +};
> +
> +static const struct sunxi_nfc_oob_ops sunxi_nfc_scrambled_plain_bbm_oob_=
ops =3D {
> +	.min_user_data =3D sunxi_nfc_oob_min_user_data,
> +	.init_user_data =3D sunxi_nfc_oob_init_user_data,
> +	.transform_bbm =3D sunxi_nfc_randomize_bbm,
> +	.read_batch =3D sunxi_nfc_oob_read_batch,
> +	.finish_read =3D sunxi_nfc_oob_finish_read,
> +};

[Severity: Medium]
As reported by Miquel Raynal on v6 [1], the series adding support for the
vendor-specific Allwinner randomized OOB layout was declined due to
maintainability concerns and kernel policy against vendor-specific NAND
layouts, with an invitation to submit only the standalone fixes outside of
the randomized layout support.

Here, sunxi_nfc_plain_oob_ops and sunxi_nfc_scrambled_plain_bbm_oob_ops use
identical callbacks for min_user_data, init_user_data, read_batch, and
finish_read, differing only in transform_bbm. The remaining indirection in
struct sunxi_nfc_oob_ops is only used by the vendor-specific randomized OOB
layout patch later in the series.

Could the PIO and DMA ECC read helpers be shared directly and the standalone
fixes split out without introducing the struct sunxi_nfc_oob_ops vtable?

[ ... ]
> @@ -2254,6 +2303,9 @@ static int sunxi_nand_attach_chip(struct nand_chip =
*nand)
>  	if (!ecc->size || !ecc->strength)
>  		return -EINVAL;
> =20
> +	sunxi_nand->oob_ops =3D nand->options & NAND_NEED_SCRAMBLING ?
> +		&sunxi_nfc_scrambled_plain_bbm_oob_ops : &sunxi_nfc_plain_oob_ops;

[Severity: High]
Does selecting sunxi_nand->oob_ops in sunxi_nand_attach_chip() break bad
block marker compensation for chips that set NAND_NEED_SCRAMBLING during
nand_manufacturer_init()?

In nand_scan_with_ids(), nand_attach() runs before nand_scan_tail():

  nand_scan_with_ids()
    -> nand_scan_ident()
    -> nand_attach()
      -> sunxi_nand_attach_chip()
    -> nand_scan_tail()
      -> nand_manufacturer_init()

For ONFI-compliant chips where nand_onfi_detect() succeeds in nand_detect()
and jumps to ident_done without setting NAND_NEED_SCRAMBLING, the flag can
be set later in nand_manufacturer_init(), such as in
drivers/mtd/nand/raw/nand_toshiba.c:

  toshiba_nand_init()
    -> tc58teg5dclta00_init()
      chip->options |=3D NAND_NEED_SCRAMBLING;

Because sunxi_nand_attach_chip() runs before nand_manufacturer_init(),
sunxi_nand->oob_ops is latched to sunxi_nfc_plain_oob_ops (where
transform_bbm is NULL). Later, during page and OOB reads and writes,
sunxi_nfc_randomizer_config() and sunxi_nfc_randomizer_enable() dynamically
check nand->options & NAND_NEED_SCRAMBLING and enable hardware scrambling,
while sunxi_nfc_hw_ecc_get_prot_oob_bytes() and
sunxi_nfc_hw_ecc_set_prot_oob_bytes() check sunxi_nand->oob_ops->transform_=
bbm
and skip calling sunxi_nfc_randomize_bbm().

[1] https://lore.kernel.org/r/871p9v4a1x.fsf@bootlin.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-submit-sun=
xi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com?part=3D1
