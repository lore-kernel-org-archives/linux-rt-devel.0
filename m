Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DAF51DE17;
	Tue, 29 Sep 2026 18:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790705392; cv=none; b=Ppt1p6mY5zf5Z5gCpbCTGY0xBGG6eea1nbNT7jhjRG7LBWEi21d8FgpH5xumERrjNZkRAK5ykmFml7tD6BlS1OjUbMYlb92wgBisYT3FTt/ATSijmYbtBO1LjcXOVAJ9rBEw0yIKg9Dll+KLSCNFlwuNU4SdYEmJc09zeQIs1vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790705392; c=relaxed/simple;
	bh=dJ3wWcS7lkJa2JC2ceFPQruGD9GAjHXCNWpgf6AYY3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iNwlUbcUwxc03xe6P1tEfKoPvcJHP+cSo8m5t7sNqrrz4FKL7vXweZBwY6pJP/Zm1/FLaXdY3qfO4T47I2bduYJLFf9p6QJ7OFuOJ/BGDU2iVW3sFCx7SQQbDNsh9oFOf5c975TGlvvP5N73HR7O4pCd1oEmYLWSEkL/4ve01e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXmmcU+x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXmmcU+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC961F000FF;
	Tue, 29 Sep 2026 18:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790705390;
	bh=99OpVub6iYC6VmMdemzhrmrJtXQGtvPnIqfGtEY1Hb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kXmmcU+xDCPETN/6pAIpaknbmGfrqVAvRDL62Xy98JMfabGGm1BnfYgkwtumKlwhs
	 KLIFJlfJeglFK8ER8nYOx/DBM+oNIm0mLl2k233NmXqDwFKbkkvdVaLZSIyE6oIcP2
	 ObKFXzd1Y7l0mY+Kli35CKyMJndxZPam1D5kovd6cxh3945Tw0PUiqf4gJxudJN/RG
	 naFQp2w8CX66BfIU8kNLziNaCXf2REqEWoHxCwuKLdSssi5cs5mbPigb7ZWzYjNk0A
	 8e6VmHS5BhhBiI/AAjEzXFVZxsZIn86q3bE4YkAKWql7npYsKuwj8g6TGo1H8q5JEr
	 2MOiVswFw6dDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] pinctrl: mediatek: common-v1: Use a raw spinlock for
 the pinctrl regmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Brue" <ryanbrue.dev@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260929-rbrue-suez-upstreaming-mtk-pinctrl-raw-regmap-v1-1-db92943f42cb@gmail.com>
References: <20260929-rbrue-suez-upstreaming-mtk-pinctrl-raw-regmap-v1-1-db92943f42cb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 18:09:50 +0000
Message-Id: <20260929180950.7DC961F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] pinctrl: mediatek: fallback to syscon bypasses lockdep fix
- [Medium] pinctrl: mediatek: integer underflow in max_register calculation
--

commit b8dcd543528b096e44b07a9f7d47936a1a0bdd08
Author: Ryan Brue <ryanbrue.dev@gmail.com>

pinctrl: mediatek: common-v1: Use a raw spinlock for the pinctrl regmap

This commit introduces a new regmap with a raw spinlock for Mediatek
pinctrl nodes to resolve invalid wait context splats in hard IRQ context.
It registers this regmap with syscon so other node users can share it,
and falls back to an existing syscon regmap if one is already registered.

> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinc=
trl/mediatek/pinctrl-mtk-common.c
> index 1a977acd6883a..65b1e3096183d 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
[ ... ]
> +static struct regmap *mtk_pctrl_syscon_regmap(struct device_node *np)
> +{
> +	struct regmap_config config =3D mtk_pctrl_regmap_config;
> +	struct regmap *regmap;
> +	struct resource res;
> +	void __iomem *base;
> +	int ret;
> +
> +	ret =3D of_address_to_resource(np, 0, &res);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	base =3D ioremap(res.start, resource_size(&res));
> +	if (!base)
> +		return ERR_PTR(-ENOMEM);
> +
> +	config.name =3D kasprintf(GFP_KERNEL, "%pOFn@%pa", np, &res.start);
> +	if (!config.name) {
> +		iounmap(base);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	config.max_register =3D resource_size(&res) - config.reg_stride;

[Severity: Medium]
Can this calculation underflow if the mapped resource size in the device
tree is smaller than config.reg_stride?=20

Because resource_size() returns an unsigned resource_size_t, a small
resource size (e.g., 1, 2, or 3) would underflow and set max_register to
an extremely large value. This seems to bypass regmap memory bounds checkin=
g.
The standard syscon code in drivers/mfd/syscon.c usually checks if the
resource size is smaller than the IO width to prevent this.

> +	regmap =3D regmap_init_mmio(NULL, base, &config);
> +	kfree(config.name);
> +	if (IS_ERR(regmap)) {
> +		iounmap(base);
> +		return regmap;
> +	}
> +
> +	ret =3D of_syscon_register_regmap(np, regmap);
> +	if (ret) {
> +		regmap_exit(regmap);
> +		iounmap(base);
> +		/* An earlier probe, or another user of the node, got there first. */
> +		return ret =3D=3D -EEXIST ? syscon_node_to_regmap(np) : ERR_PTR(ret);

[Severity: Medium]
Does this fallback path silently inherit a non-raw spinlock regmap if anoth=
er
driver (like ethernet) already triggered its creation?

If another driver sharing the syscon node probes before this pinctrl driver,
the standard syscon initialization will create a regmap with a normal,
sleepable spinlock_t. When the pinctrl driver subsequently probes,
of_syscon_register_regmap() returns -EEXIST, and we fall back to
syscon_node_to_regmap().

Would this result in the pinctrl driver using the existing non-raw
spinlock regmap, bypassing the intended lockdep fix and potentially causing
lockdep warnings on PREEMPT_RT when accessed from hard IRQ context?

> +	}
> +
> +	return regmap;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-rbrue-suez=
-upstreaming-mtk-pinctrl-raw-regmap-v1-1-db92943f42cb@gmail.com?part=3D1
