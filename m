Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AEA37E304;
	Sat, 12 Sep 2026 20:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789245372; cv=none; b=sTGzVsldtnvYkItd8jiK8S+JouRvNfKbk50hL6cE1sgn3DedB0LMKytWhCT/t2LMGW1P9XVxqJWZe7CNeXIlmokdJDMhvsHjeg+w39U4A4QUUGPtbF8EtIZabFkLGGdTkV2+JD5l39aI73wjr+aIxHicjGJxf0KeH9vjYlbrhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789245372; c=relaxed/simple;
	bh=RT2OUbFQDyh9sTCT+pvBbSIarmLVT+SX06rHWtJXeZQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KIGWIxIza6G3ei/R57aJtb1xUaxeniE+Z7jH8rp2turaKpd64lQpBRgtDA72nuTCFQ7jLy7UilnoXFy4h5l5FWFEdmEIL+puPgRjovgKjx6Ceh9EIcHTibpNFIQCXDYO7deI/YJeOiIPvrg70Wn5lUF6NHbnWXfFwVQxQ2GYCTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZjr33AS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZjr33AS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29221F00898;
	Sat, 12 Sep 2026 20:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789245370;
	bh=yB+qPympDgej2P0RT4awNqENmPN0DVLN9Y0lFyxzCw8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oZjr33ASNsZqqvhPztx3+hVwun5yHxMJZckJ0Yk0Qo2yfn2QtGEu5jfAHvZ3PTRZx
	 ZC8QkVr2XnPZit1LQ9jjZqyMlW2eLpYRBIkv0fZIJdBCGC9GG9n8EUvL8fRBNKzOJw
	 t3bLvXHMMLnM9yPNU7rPVxe3NQS37V5rjsn37Q7yAAWUX/8dIzYc3OTt24yN2EHCzo
	 K9acrCJfKv0eWS7vS7rkr3fxaRLSULlV0me0NPBx9r+kXeSt+8LRLEvxl/dyN/kgef
	 mQVkluRYAuT8kk95j32tjiqWQwsLNLWfWxkRV/8vcBvQP6dIdZHVdTKAT+Az2+AOGr
	 te/Hy9bNuhPtw==
Subject: Re: [PATCH net-next v2 3/8] net: xilinx: tsn: add endpoint MAC driver
 skeleton
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
 michal.simek@amd.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Sat, 12 Sep 2026 20:36:08 +0000
Message-ID: <178924536843.3125.9655255476131138078@kernel.org>
In-Reply-To: <20260909-patches_v2_external-v2-3-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-3-3a40babaff4c@amd.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 2

- [Low] Commit message contradicts the code: the message body states
  'Register the netdev named "ep"', but xlnx_tsn_ep_probe() calls…
- [Low] Reported concern (validated as NOT a defect at the end of the
  series): the binding Documentation/devicetree/bindings/net/xlnx,tsn-…

--

net: xilinx: tsn: add endpoint MAC driver skeleton

This adds a platform driver for the "xlnx,tsn-ep-mac" endpoint MAC that
registers an enumerated netdev with minimal netdev and ethtool ops, sets
the MAC address from DT or a random one, and drops all transmitted
frames.  The new driver is registered alongside the existing TSN
platform driver.

Two questions below, both minor.

> Add a platform driver (compatible "xlnx,tsn-ep-mac") for the endpoint.
> Register the netdev named "ep", set its MAC address, and provide minimal
> netdev and ethtool ops. ndo_open starts the queues and ndo_start_xmit
> drops frames.

[Severity: Low]
Should "the netdev named "ep"" say ep%d here?  xlnx_tsn_ep_probe() uses:

	ndev = alloc_netdev(sizeof(*ep), "ep%d", NET_NAME_ENUM, ether_setup);

so the interface shows up as ep0, and ep1 for a second IP instance.  The
kernel-doc for struct xlnx_tsn_ep in the same file already says '("ep0"
for the first IP instance)'.

The rename is described in the v2 changelog below the "---" separator,
which is dropped when the patch is applied, so the permanent log would
keep the old name.  Can the message body be updated to match?

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> new file mode 100644
> index 000000000000..089f17a126f5
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> @@ -0,0 +1,143 @@

[ ... ]

> +static int xlnx_tsn_ep_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct net_device *ndev;
> +	struct xlnx_tsn_ep *ep;
> +	u8 mac_addr[ETH_ALEN];
> +	int ret;
> +
> +	ndev = alloc_netdev(sizeof(*ep), "ep%d", NET_NAME_ENUM, ether_setup);
> +	if (!ndev)
> +		return -ENOMEM;
> +
> +	SET_NETDEV_DEV(ndev, dev);
> +	ndev->netdev_ops = &ep_netdev_ops;
> +	ndev->ethtool_ops = &ep_ethtool_ops;
> +	ndev->features = NETIF_F_SG;
> +
> +	ep = netdev_priv(ndev);
> +	ep->ndev = ndev;
> +	ep->dev = dev;
> +
> +	ret = of_get_mac_address(dev->of_node, mac_addr);

[Severity: Low]
This isn't a bug, but of_get_mac_address() is the only DT property read
here, while the binding
Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
lists reg, dmas, dma-names and tx-queues-config as required for this
node.

The later patches in this series ("net: xilinx: tsn: parse endpoint DMA
channel configuration" and the MCDMA/RX/TX data path patches) do add
ep_count_dma_queues() and ep_parse_tx_queue_config(), so dmas,
dma-names, tx-queues-config and xlnx,num-priorities all end up parsed
and enforced with dev_err_probe() by the end of the series.

The one property that is still never consumed at the end of the series
is the required reg region, since the v2 changelog notes the ioremap
comes back with QBV support.  Is reg intended to stay documentation-only
for the node unit address until then?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-patches_v2_external-v2-0-3a40babaff4c%40amd.com
