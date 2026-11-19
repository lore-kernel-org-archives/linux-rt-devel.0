Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795089510;
	b=WjJHQ7s9mmyW2npS9iK0nYaNkUcsZlCz1C/qcOTrNjg/4uAVz4CfkbvlEZLxs/COju+c
	 C8M4XHv0jk0yMZ+EK4u+X11J1uZJzZdM/yuh2NUCtoFluo//Kr/iX4/0Ez+qXSz/EmXIN
	 vbAeEzRv9On7+Mg0HdDauO2Rju/ITg1bm2GwSp59lQVd3dJLhtCxzZn6n5B8hMtavWoUp
	 dXMWdjNQ2bkw4Hy+zHn4+LN4LQPru5gs2g1yhYYeJ5XksAVjlAZTol72r7Oe5kCTYnxgf
	 wDEV3zNPPsObi4Nj+/w3ub/aOODNgUO0/9aYd2pB212962PpRQHjoRyv2P0Gp5jVJrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795089510;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:In-Reply-To:References:User-Agent:Date:Message-ID:
	 MIME-Version:Content-Type:X-Last-TLS-Session-Version;
	bh=8pKyecCVKJ3P2/DllSf4QADgUTwIySkDcGXpaKJszRo=;
	b=wxyQI2VV3ypPssfmwzUbR5yI/seDD7JidVeje3rkeEJ5gKBhvxvDm/lYYoqS9+YAG8xx
	 rVAx8HDQWx7uzKiS6JlrEQ9GsZkpsNoVpN0Q/70zQS+nUK9ZUmqUAdumsxpobdjVKVEok
	 LA0RpxBSfmI0RBnmLQazlZgAGksyk0+0pst2csfUnmxnaw70fRChURkBZdNMmJu0WsGdR
	 lWVyzdGbf4ycbh32RMBFYroWS5/OR53mNsPKefqsXstuxc9ion0rN/3HjN8aMyvIEHERX
	 dXGcn0gtiHiMuwt7lyTmwVnRyPJRNLG8UF9ln2m/zSuSJRggdE2VlFuQG4mwP9//gRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lVOzcWV8;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A185606A326
	for <linux-rt-devel@lists.linux.dev>; Thu, 19 Nov 2026 11:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A185606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lVOzcWV8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 953DDC4CBEF;
	Thu, 19 Nov 2026 11:58:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 490C860237;
	Thu, 19 Nov 2026 11:58:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFB3011BC04AA;
	Thu, 19 Nov 2026 12:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795089502; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=8pKyecCVKJ3P2/DllSf4QADgUTwIySkDcGXpaKJszRo=;
	b=lVOzcWV8O+0BgL+87QRl2KBYiDz9tcVvNzQIeJ2CmmtYY33VlT0tOKm6VnE+mN33wFsbuc
	BNRv49hvyR2Bqs4xtfCAMpVgd4g9dQ3z45YF4zAqM9xPatZMW+DqgqGq3n6NfIcYNjeDdT
	UdkJCCT9HH1zPxl8/eaJ1M2tGB+h4xeIDwbwjwtuG73TE1SPFoqvKn6fHzl2dEnEF1eunF
	KOyB9zBildxT/9RVuq/xhbsVmUBQfiXLfmjTfmwvE4y0EzM3KZEs+x9kPKbfWa6q6MOg30
	EpmxuiZuHIW6cslkUH5GSfCuflQvoIWWcAVomu0VhKi8Gocm96CFWoMqFlusUw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
  Clark Williams <clrkwllms@kernel.org>,  Steven Rostedt
 <rostedt@goodmis.org>,  Rob Herring <robh@kernel.org>,  Krzysztof
 Kozlowski <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,
  Philipp Zabel <p.zabel@pengutronix.de>,  Chen-Yu Tsai <wens@kernel.org>,
  Jernej Skrabec <jernej.skrabec@gmail.com>,  Samuel Holland
 <samuel@sholland.org>,  Maxime Ripard <mripard@kernel.org>,  Richard
 Genoud <richard.genoud@bootlin.com>,  Boris Brezillon
 <bbrezillon@kernel.org>,  Masahiro Yamada <yamada.masahiro@socionext.com>,
  Brian Norris <computersforpeace@gmail.com>,
  linux-mtd@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev,  linux-kernel@vger.kernel.org,
  linux-rt-devel@lists.linux.dev,  devicetree@vger.kernel.org,  Sashiko
 <sashiko-bot@kernel.org>
Subject: Re: [PATCH v10 04/26] mtd: rawnand: sunxi: reject pages exceeding
 the ECC step limit
In-Reply-To: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-4-dca1f6ed29a8@gmail.com>
	(James Hilliard's message of "Thu, 05 Nov 2026 11:55:20 -0700")
References: <20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-0-dca1f6ed29a8@gmail.com>
	<20261105-submit-sunxi-nand-vendor-oob-layout-v1-v10-4-dca1f6ed29a8@gmail.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Thu, 19 Nov 2026 12:58:13 +0100
Message-ID: <87ik1tdodm.fsf@bootlin.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3

On 05/11/2026 at 11:55:20 -07, James Hilliard <james.hilliard1@gmail.com> wrote:

> The controller has 16 ECC status slots on A10/A23 and 32 on H6/H616.
> Hardware-ECC setup checks the strength and available OOB space, but does
> not check that the page fits those slots. NAND identification can supply
> a larger page size, and the NAND core does not enforce this
> controller-specific limit.
>
> If enough OOB space is available, an unsupported geometry can pass attach
> and reach DMA code that indexes status and user-data registers by ECC
> step. H6/H616 also represent enabled data blocks with a 32-bit mask. The
> number of steps must fit the controller even when their user data fits
> the register bank.
>
> Reject excessive step counts before allocating user-data lengths or
> installing the hardware-ECC callbacks. Check the final step size, after
> strength maximization and the conversion from 512-byte to 1-KiB steps,
> so valid geometries retain their existing layout. This also keeps PIO
> fallback from accepting a page that the controller cannot handle.
>
> Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/r/sashiko-outbox-173724@kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
> index 662d96fc2535..1a61f608ad91 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -2223,6 +2223,11 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>  	ecc->bytes = ALIGN(ecc->bytes, 2);
>  
>  	nsectors = mtd->writesize / ecc->size;
> +	if (nsectors > nfc->caps->max_ecc_steps) {
> +		dev_err(nfc->dev, "unsupported number of ECC steps: %d (max %u)\n",
> +			nsectors, nfc->caps->max_ecc_steps);
> +		return -EINVAL;
> +	}

I'm fine with this patch, but if your manual says that the controller
support chips with pages up to 32k and you wire a chip -that does not
exist on earth yet- with a larger page size, screw you? This is again
one of those over defensive approaches...
