Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497497;
	b=XwgeR2DSr7j5MupNM+cazkMMr3pzP2QG9jrLsR+5k5ctljejusF5vScBQBnUtH2Ei7PB
	 cqGfeR4cGT7t32bdAOnVCtsc1sT2n4ZfB44lJkBMqXuL+xd+9vgTFYo9jyLFL6ELgeLbB
	 PyhoXmPhJvVhJB5TUerR4EPtVh2pAjZXC4ueYFbnZL3RKP/18b0BioVCxQbU9bXqtxAaX
	 HAgL7y47G1V595Xz2gINkfbK9d13HalDjmthTGn/Z51Mbx2R3PhAFz0CFdbQwLTRSYxM5
	 BUluFuYJ1wY0hJbagM0WremG761qSNyp7qEOcvWFMSoQDKhAO1eIzL5f0qO4ecX26mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497497;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=6d6z90kujskdu9Nq7+vIIcl4GoA3T1K6qt7oPYIti/k=;
	b=L4ZNwZvP4w9+vMrwnUBGfSiocqI2ScVoRBEfd/PDV80boA1rRwqsKRvpXEPsyS3haOPD
	 H0rYtQuAIwUJEdeMIzFrkNHt2GKze9v5gR7SJdKEy8fgY3SVCVofyOG1re3sEqA2MoFkl
	 SNYfmVTUjzHjNAtL2ducqbDu9yz+RVLyRSWkr3exi0sDkD/m3ur8wt0+5bbche2lnkub9
	 z0OlTuUXZklxlOVuk7WsrKk/lShAZOjwQ72fUwq4S2Ggg2vKKCsGASW3iTvw8MbaTQcvc
	 RoY+m4cu8PyDCxSBTCQvi/JYaUO7nJli2iRG8IKE6CCkQRd3NZRVBsZp5KofV+a0c7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGxDBQkU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FEE606A320;
	Tue, 20 Oct 2026 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YGxDBQkU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604281F000C5;
	Tue, 20 Oct 2026 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497496;
	bh=6d6z90kujskdu9Nq7+vIIcl4GoA3T1K6qt7oPYIti/k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YGxDBQkUvKZwAULI5HrvGzRai3ZG0YuPxSnj3ToS4Iljs9LvcvnVujkIrgaPFQtan
	 X8jOWeh6JCLFnBA/+yMju1EOm7wTiaTXieaG4qCYeRqY5OhR90P4A7s8khvC7pm31A
	 l6xopzVc24mRghYbnplN9+INGcw6DAf5ngXF8FVFnnOLiAxFoRxUYm+R9rw3WKmANc
	 /sJbQcThKK+hoU2Ecu5lcGNmvEscuokfWd5H/gFnOS4tBwnlH1Fjx/TccBWBaOGUO9
	 s8laMiB7oLBNEHYedv/NA9WYocJzKUWrfXmksBLgRmNiufvVHYLPN7JzPvVcKYjFEq
	 v7F9vxThlZweg==
Subject: Re: [PATCH net-next v3 3/8] net: xilinx: tsn: add endpoint MAC driver
 skeleton
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Tue, 20 Oct 2026 11:58:14 +0000
Message-ID: <179249749490.3135.16050500473575890674@kernel.org>
In-Reply-To: <20261016-patches_v2_external-v3-3-e33d3960ca1e@amd.com>
References: <20261016-patches_v2_external-v3-3-e33d3960ca1e@amd.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] xlnx_tsn_ep_probe() in
  drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c (line 80) open-codes…

--

net: xilinx: tsn: add endpoint MAC driver skeleton

This adds a platform driver for the "xlnx,tsn-ep-mac" endpoint MAC. The
endpoint MAC provides the conduit netdev for the TSN DSA switch. The driver
registers an eth%d netdev, sets its MAC address from DT or a random one,
and provides minimal netdev/ethtool ops where xmit just drops frames.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> new file mode 100644
> index 0000000000000..609d444c68356
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> +static int xlnx_tsn_ep_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct net_device *ndev;
> +	struct xlnx_tsn_ep *ep;
> +	u8 mac_addr[ETH_ALEN];
> +	int ret;
> +
> +	ndev = alloc_netdev(sizeof(*ep), "eth%d", NET_NAME_UNKNOWN, ether_setup);

[Severity: Low]
Should this be NET_NAME_ENUM rather than NET_NAME_UNKNOWN?

With the "eth%d" template the kernel chooses the number. The standard
helper for that case uses NET_NAME_ENUM:

net/ethernet/eth.c:alloc_etherdev_mqs() {
	return alloc_netdev_mqs(sizeof_priv, "eth%d", NET_NAME_ENUM,
				ether_setup, txqs, rxqs);
}

The DSA user port fallback in dsa_user_create() in net/dsa/user.c also
pairs "eth%d" with NET_NAME_ENUM. The v2 changelog gave that as its reason.

With NET_NAME_UNKNOWN, reading /sys/class/net/ethX/name_assign_type for
this device returns -EINVAL:

net/core/net-sysfs.c:name_assign_type_show() {
	...
	if (READ_ONCE(ndev->name_assign_type) != NET_NAME_UNKNOWN)
		ret = netdev_show(dev, attr, buf, format_name_assign_type);
	...
}

Netdevs from alloc_etherdev() and the DSA user netdevs stacked on top of
this conduit report 1 there.

The v3 changelog says:

  "Register the netdev with the standard eth%d name (NET_NAME_UNKNOWN)"

That doesn't match what the standard helper does. Would alloc_etherdev()
work here instead? It would also drop the open-coded ether_setup.

Later in the series, "net: xilinx: tsn: parse endpoint DMA channel
configuration" changes this call to alloc_netdev_mqs(sizeof(*ep), "eth%d",
NET_NAME_UNKNOWN, ether_setup, ...) and still uses NET_NAME_UNKNOWN.
alloc_etherdev_mqs() would cover that multi-queue version.

> +	if (!ndev)
> +		return -ENOMEM;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-patches_v2_external-v3-0-e33d3960ca1e%40amd.com
