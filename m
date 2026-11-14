Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794657914;
	b=1+0Ftf62gY03hFb++YtVOE7qetLaDnHk4QxVF7CNfoxhQyYKyS6vn+2pXdZqfkMek0WY
	 q/gEBQ059qgAG1452Yn6CJn2xGx8UrRztBbuS56LgwZcTYxBziQZZRXMXZbRMlF+p4pk4
	 ANqAj/kziJhAwvtupW8hioeCA+jkhuELh0uJRLdAVhsJu5JIGC22aY8s13XWhJ+xSMkb5
	 4j0pBfzjS/zEuctZEuPoKFCsQQOeNuU8W0jtFVjbSuVxOpwLmrdYOp0N4h+5QzF4YPGPQ
	 oTDkPATbEc6VUCtIX7CA0qXECmjZ8QFR7VLFlgT9fFPVI8YWkZruiOoFWU6QeNWEhVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657914;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j5DRAQTyYS6iSrSTZr638K4+srbL2hzIWrDPBudTrjM=;
	b=1sy57EcdOiL5f3W75ROEpFhbqyHEcKzGMuoJZeg0datHsszqlupwoYy9W9k6zSZ5PqKq
	 evgjl/Bpd5zqU8pEn6yFHZ5cWItr1GyKVXIlRGW8Ljoywcn9uixkMo8+EfzZvqHnhQnMK
	 ijws/G9qWi8ktUQL6ZSvyQ0jliAYR/i9Eafu3Oha7ENXz7CPHIHn5SOS3a4EtbbFYv2bC
	 cg6uIf2jFE+AgGCXVU+Scl8QYaP6FOXAAq1nXs7qfqtTONGnN/h3CY5PPBlbhfoEB3NiA
	 zd/BT0i4v8eicrGvoNH05QS+TbhOmzZOaEyVTTunoMCdGO7Pxj0A8QrskYzAZgVGSAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RNerS/7M";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF69606A327;
	Sat, 14 Nov 2026 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNerS/7M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE571F000C4;
	Sat, 14 Nov 2026 12:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794657914;
	bh=j5DRAQTyYS6iSrSTZr638K4+srbL2hzIWrDPBudTrjM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RNerS/7MJd/pNYQg0h1KAUJymbRsGFwTY7pnWDDI6KSxWuMPFQMEkRrYsdYglvD+n
	 RaOR/qqAiBEKi0arbsPWDBDZqVF+dlNxZSWu5+ketU/JnQZ/t6D8V38Vmi6YF8hJjO
	 LU9T/19+NHwz5y3zP0nHo/P/81K12Y3Y0zWS2JWj5lU2kRpVeLCoPyEJ2x8qVQceO/
	 +xmPyB4NTJs5z/bzMXnyDKp4T5/thuDFoxA1tUl+wVW1zRu7v8HrTYyuKzqSy7HfD6
	 geYCnuIrVlTVNvDZSMtYeSrsjNnC8+mUPcx8uobzYYQLucSnkEAvVNRXuuimcBQWfd
	 Wvzok3r/ikTDQ==
Message-ID: <sashiko-outbox-214486@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 2/8] net: xilinx: tsn: add TSN endpoint
 wrapper driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261113-patches_v2_external-v4-2-56bb26f042a4@amd.com>
References: <20261113-patches_v2_external-v4-0-56bb26f042a4@amd.com>
 <20261113-patches_v2_external-v4-2-56bb26f042a4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 12:05:12 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] net: xilinx: tsn: use devm_clk_bulk_get_enable() in
  tsn_ip_probe()
--

commit 9fffc2486144ec3dd4b7c4d984f898729124f771
Author: Srinivas Neeli <srinivas.neeli@amd.com>

net: xilinx: tsn: add TSN endpoint wrapper driver

This commit adds a platform driver for the AMD/Xilinx TSN Endpoint Ethernet
MAC IP wrapper node that enables the IP-wide clocks and populates its child
sub-nodes.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/=
net/ethernet/xilinx/tsn/xilinx_tsn_main.c
> new file mode 100644
> index 0000000000000..afe7609c67fb4
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c

[ ... ]

> +static void tsn_clk_bulk_disable(void *data)
> +{
> +	struct xlnx_tsn_ip *w =3D data;
> +
> +	clk_bulk_disable_unprepare(TSN_NUM_CLOCKS, w->clks);
> +}
> +
> +static int tsn_ip_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct xlnx_tsn_ip *w;
> +	int ret;
> +
> +	w =3D devm_kzalloc(dev, sizeof(*w), GFP_KERNEL);
> +	if (!w)
> +		return -ENOMEM;
> +
> +	for (int i =3D 0; i < TSN_NUM_CLOCKS; i++)
> +		w->clks[i].id =3D tsn_clk_names[i];
> +
> +	ret =3D devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, w->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get clocks\n");
> +
> +	ret =3D clk_bulk_prepare_enable(TSN_NUM_CLOCKS, w->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable clocks\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, tsn_clk_bulk_disable, w);
> +	if (ret)
> +		return ret;

[Severity: Low]
Could tsn_ip_probe() use devm_clk_bulk_get_enable() instead of calling
devm_clk_bulk_get(), clk_bulk_prepare_enable() and
devm_add_action_or_reset() with tsn_clk_bulk_disable()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-patches_v2=
_external-v4-0-56bb26f042a4@amd.com?part=3D2
