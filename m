Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE39851DAE8;
	Thu, 17 Sep 2026 17:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789665079; cv=none; b=IBRpzJ7sUrdhx2WlQmmaJ2mBMZ5SkA2eqQ0GfhymD/+rIX0vGsIJ0jwgvOhYbrlBsqxiu4wmiByNAPMXDMP3/8JlGCIHyZWGbDRwKeAZf3BnQ+jI7iF+OwAPccWgLy2YBscq/fxVqU27fsoTw9C6SWemWuFa4LExwCtsBE+VV44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789665079; c=relaxed/simple;
	bh=IdXe7NHfFnhBi6JL3nxqLRFqt/RRWCshiiTNe1qCQ1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jz8KVtCSQCafBM+tzxZRovstYPmgT9TDvhMvFe9lwm0FzCz0+YA9qcEt2XmCRUyxR2fu/jiF7+GxqLBJf2qwML6btnrSymCiqgHTbolOGWdVUfpFZ109Jo/Jes4kXDx0ej5CJuQrVJQVJm1yyClcihrO9pCuSRkzwXsJ1smh1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grPT7ufH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grPT7ufH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AD781F000FF;
	Thu, 17 Sep 2026 17:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789665076;
	bh=7tu7Osnrha5cZyvzL3BFIoRysU3A7nNkZyxIAQk5XFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=grPT7ufHljw/Z8TUtfVlYW+dXK7tZMU+ui6uAQDWnrDfwyH67+UKGmWXrGjKWtQqI
	 ujjTQvLgQmx4qfnVHtjav0roYHy6gWQ2W8bCXMYtFU5qV97ZFWPoQZWCirIg2Ed6HE
	 MwfhMt0Q8mZFikEU3+ALX4Ir9evXNNQTD6ln840tM+f3gF7xL17nmJ1L8yanodBc21
	 J5n6JMGqh/IVVTFpeq67pxWVCogGp+rFiK32iAVU/C5h+JKWqo/DfXI05rbfe7eI/3
	 un+jL4aJXMGy7y1aPU0V0sEe9uqGZk6YkNVKx1gT1qcqYF4VLWYueiJsX9qUkXUK/w
	 S9+d4irwleI+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/5] riscv_cbqri: Add CBQRI capacity allocation
 platform driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: linux-kernel@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260917-dfustini-atl-sc-cbqri-dt-v8-5-7964e8d73fe8@kernel.org>
References: <20260917-dfustini-atl-sc-cbqri-dt-v8-0-7964e8d73fe8@kernel.org>
 <20260917-dfustini-atl-sc-cbqri-dt-v8-5-7964e8d73fe8@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 17:11:15 +0000
Message-Id: <20260917171116.1AD781F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cbqri: probe fails for monitoring-only capacity controllers
--

commit 8ddfa638686f4f96df4bb905203f8a16edb1ece7
Author: Drew Fustini <fustini@kernel.org>

riscv_cbqri: Add CBQRI capacity allocation platform driver

This commit adds a platform driver for CBQRI capacity controllers
described in device tree. The driver registers the controller with
the CBQRI core to expose it through resctrl.

> diff --git a/drivers/resctrl/cbqri_capacity.c b/drivers/resctrl/cbqri_cap=
acity.c
> new file mode 100644
> index 0000000000000..0670a676bdb1f
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_capacity.c
> @@ -0,0 +1,127 @@
[ ... ]
> +static int cbqri_capacity_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct cbqri_controller_info info =3D {};
> +	struct device_node *cache_np;
> +	struct resource *res;
> +	u32 rcid_count, cache_level;
> +	int cache_id, cpu, ret;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	ret =3D of_property_read_u32(dev->of_node, "riscv,cbqri-rcid", &rcid_co=
unt);
> +	if (ret) {
> +		dev_err(dev, "missing riscv,cbqri-rcid\n");
> +		return ret;
> +	}

[Severity: Medium]
Does this unconditionally fail probe for valid monitoring-only capacity
controllers?

Monitoring-only controllers legitimately omit the riscv,cbqri-rcid property,
but this unconditional check returns an error if the property is missing.

The core driver riscv_cbqri_register_cc_dt() explicitly supports
rcid_count =3D=3D 0 for monitoring-only controllers, but making this proper=
ty
mandatory here prevents them from being used.

> +
> +	cache_np =3D of_parse_phandle(dev->of_node, "riscv,cbqri-cache", 0);
> +	if (!cache_np) {
> +		dev_err(dev, "missing riscv,cbqri-cache phandle\n");
> +		return -EINVAL;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-dfustini-a=
tl-sc-cbqri-dt-v8-0-7964e8d73fe8@kernel.org?part=3D5
