Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA79C218EBA;
	Thu, 30 Jul 2026 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785374486; cv=none; b=C/QThtLh6YX1BbIUGnxe1zO1yU9lGlJ7vUJoBWiBulDW5LstjPk2xwJy/LmVCZxqFZZqmme4ZzqWzTMcBtG+d7HgK+lE8MRO0WS5r+bZ/fZ/uXBrnAG+o+NaoMAJCfYsJBfCcayVFLLGKhvgJwgiKMJPyQtLiiO7HxZjRakYc/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785374486; c=relaxed/simple;
	bh=DUK0UwcNVuKBCBMcOxWdATBO7j/tUEb/UmSGC6Wa5g0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ohcw0DltBu9b9KLO0IdvWnVrccbaGlG+Fg0kA6mmGi8gtD/9z84IeDwOdq0uU0Z2E3g0kHxtZ/yVXEcVnet6/AH4cM6nLAqibhLo2DKy5VTuC1SSaTAUaE9iBozc/lzfNIVMEss4Ntgs39eR0YYF42FDPl9bLOdg6uB9oG9qSro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMjEMYjJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMjEMYjJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA611F000E9;
	Thu, 30 Jul 2026 01:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785374485;
	bh=jJyM8N9kzgk5ZMXiqN8Cye3jqpyx4bZfxgvimKcN7I4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SMjEMYjJAw5XQnJktMZk6ykOxXcru8S5fKi17elYPYT54sp/ZV5h4insyLK+cOppK
	 0ks/NTnUpnMd+PsYBsS/XjR+hCc50UpyMsmlNZtUwK2He/kaBfPhtCl4HXfnDLag0X
	 ryT9GXSOQDHX5g2EHt/H3lFUUnUyWXFBG/vH12pm9oYWdA458ecBCjV43tvlKzfOED
	 U6Ed/cPV175khCKIYrfYmYEGZOl4u59yo8mNbtNSU78ZOXOm+QpPKM7MhXLPRUaLaC
	 klmBMqNKbp2X4mPIcIgWgZ7Mp7xSs4gpJJGzAzCvlvZYvXT6l+gKymYKIoXibie/ZN
	 +OirdOxd5WfLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/8] riscv_cbqri: Add CBQRI capacity allocation
 platform driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Drew Fustini" <fustini@kernel.org>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-rt-devel@lists.linux.dev, robh@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260729-dfustini-atl-sc-cbqri-dt-v6-8-7c22b05d461b@kernel.org>
References: <20260729-dfustini-atl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org>
 <20260729-dfustini-atl-sc-cbqri-dt-v6-8-7c22b05d461b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:21:24 +0000
Message-Id: <20260730012125.2DA611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The probe function unconditionally fails if the `riscv,cbqri-rci=
d` device tree property is missing, which breaks support for monitoring-onl=
y capacity controllers.
--

--- Patch [8]: [PATCH v6 8/8] riscv_cbqri: Add CBQRI capacity allocation pl=
atform driver ---
commit 954af62b51bb07d376a8671fb6db032a2ae482bc
Author: Drew Fustini <fustini@kernel.org>

riscv_cbqri: Add CBQRI capacity allocation platform driver

This commit adds a device-tree platform driver for the RISC-V CBQRI capacity
controller. It binds to the "riscv,cbqri-capacity-controller" compatible,
determines the cache domain, and registers the controller with the resctrl
framework.

> diff --git a/drivers/resctrl/cbqri_capacity.c b/drivers/resctrl/cbqri_cap=
acity.c
> new file mode 100644
> index 0000000000000..0670a676bdb1f
> --- /dev/null
> +++ b/drivers/resctrl/cbqri_capacity.c
[ ... ]
> +static int cbqri_capacity_probe(struct platform_device *pdev)
> +{
[ ... ]
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
Will this unconditionally failing check prevent monitoring-only controllers
from probing?

The core registration logic in riscv_cbqri_register_cc_dt() indicates that
monitoring-only controllers do not need an RCID count.

However, by returning an error when the riscv,cbqri-rcid property is absent,
the driver appears to reject valid monitoring-only controllers before they
can be registered.

Would it be better to treat this property as optional and default rcid_count
to 0 if it is missing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-dfustini-a=
tl-sc-cbqri-dt-v6-0-7c22b05d461b@kernel.org?part=3D8
