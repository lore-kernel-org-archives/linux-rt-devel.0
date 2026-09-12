Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC9F3B47CB;
	Sat, 12 Sep 2026 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789245375; cv=none; b=ApAakr0zaaMTlfvnkubN6DNviYSCCrDpf5vdSSJSMvktqiawIbhCDUFX0E+WZ+CmxoNbUsE0rF5UPGm/h4gOt+C1uqJgnp4uamBLSkz5z2fr/e5Q/8tbj8Uf+qv16hig0id9dKbVRpxNuGd/r9HNfXtiYt0JoxjtYbBq3RpCd78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789245375; c=relaxed/simple;
	bh=2tCo4TFT6/DZaGqgNSIwAiJOL8IGVsTPlkVsuiUIBYo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H5FyvD8L75/XbQ4Ku/IGt8JoCBL1Ge9eUiTmtkuPwQWsBxk/ySMH2pMQySzKQq/1OUb5oCaKbKC0rGV+xG2Z0muwCYUQt37LP3Pe50zD/G5dupjlofQb0cKuCrSYEVjIzltFPRhJJZ4Hcq2vijOgKAbELrDRJq3yI2cW2Wu4UrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCtDugJ4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCtDugJ4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85D31F000FF;
	Sat, 12 Sep 2026 20:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789245372;
	bh=VXVXqhp6ApyiTqcJ3Hf36THfHfahlafVZ6pQFIgKxDA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SCtDugJ4nzwZDh/t+FYKZZqEgDb1smAvZ33YDc5Yvf/70N4R5hSiR3pPmpQIAOX9o
	 lWhQZOFujP2nJEo59dRrtV3YP+jHH7zQEJoelwyCO6SkmaddIlEmUP6uGsHvknSdoe
	 Kcgv0usnNahWfU5p+SyugMij2pkrNfaaqm5hBN0/iO9P+wLaJWX0bZ1Dhx/ozzFD5M
	 TAHN3QhkoC21ZmdsARdFyOIREePgUFk4kXrLPZHVjUZw530ohD624JJu14xJlMYLBC
	 Q8SeHLJhI/tbROAX/zo3eqqBUGQjcEOVpTA4ikTIIktz1SY/lU3r1B1mgCTXuvLpX0
	 uZ/P+1fupiruQ==
Subject: Re: [PATCH net-next v2 4/8] net: xilinx: tsn: parse endpoint DMA
 channel configuration
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
 michal.simek@amd.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Sat, 12 Sep 2026 20:36:10 +0000
Message-ID: <178924537042.3125.10976584091391894658@kernel.org>
In-Reply-To: <20260909-patches_v2_external-v2-4-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-4-3a40babaff4c@amd.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] xlnx_tsn_ep_probe() and ep_parse_tx_queue_config() enforce two
  new mandatory device-tree constraints that the in-tree binding does…

--

net: xilinx: tsn: parse endpoint DMA channel configuration

This patch counts the TX and RX MCDMA channels listed in the endpoint's
"dma-names" property, allocates the conduit netdev with that many hardware
queues, and parses the "tx-queues-config" child node to map each logical TX
queue to a physical DMA channel.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 089f17a126f5..24025b1f6e66 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -69,15 +88,173 @@ static const struct ethtool_ops ep_ethtool_ops = {
>  	.get_drvinfo	= ep_get_drvinfo,
>  };
>  
> +/*
> + * Parse the "tx-queues-config" child of the EP node. The logical queue
> + * index is taken from the "queue<N>" node name, so the mapping does not
> + * depend on the order the child nodes appear in the device tree.
> + */
> +static int ep_parse_tx_queue_config(struct xlnx_tsn_ep *ep,
> +				    struct device_node *txcfg_np, u16 tx_present)
> +{
> +	DECLARE_BITMAP(queue_seen, TSN_MAX_TX_QUEUE) = {};
> +	DECLARE_BITMAP(chan_seen, TSN_MAX_TX_QUEUE) = {};
> +	unsigned int count = 0;
> +	int ret;
> +
> +	for_each_child_of_node_scoped(txcfg_np, qnode) {
> +		u32 chan, queue;
> +
> +		if (!str_has_prefix(qnode->name, "queue") ||
> +		    kstrtou32(qnode->name + strlen("queue"), 10, &queue) ||
> +		    queue >= ep->num_tx_queues)
> +			return dev_err_probe(ep->dev, -EINVAL,
> +					     "tx-config: invalid queue node %pOFn (have %u queues)\n",
> +					     qnode, ep->num_tx_queues);

[ ... ]

> +		ep->tx_dma_chan_map[queue] = chan;
> +		count++;
> +	}
> +
> +	if (count != ep->num_tx_queues)
> +		return dev_err_probe(ep->dev, -EINVAL,
> +				     "tx-config: described %u queues but expected %u\n",
> +				     count, ep->num_tx_queues);
> +
> +	return 0;
> +}

[ ... ]

>  static int xlnx_tsn_ep_probe(struct platform_device *pdev)
>  {
> +	u32 rx_chan_num[TSN_MAX_RX_QUEUE];
>  	struct device *dev = &pdev->dev;
> +	struct device_node *txcfg_np;
> +	u32 num_tx, num_rx, num_prio;
> +	struct device_node *ip_np;
>  	struct net_device *ndev;
>  	struct xlnx_tsn_ep *ep;
>  	u8 mac_addr[ETH_ALEN];
> +	u16 tx_present = 0;
>  	int ret;
> +	int i;
> +
> +	ret = ep_count_dma_queues(dev, &num_tx, &num_rx, &tx_present, rx_chan_num);
> +	if (ret)
> +		return ret;
> +
> +	ip_np = of_get_parent(dev->of_node);
> +	if (!ip_np)
> +		return dev_err_probe(dev, -EINVAL, "missing parent IP node\n");
> +
> +	ret = of_property_read_u32(ip_np, "xlnx,num-priorities", &num_prio);
> +	of_node_put(ip_np);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing xlnx,num-priorities\n");
> +
> +	if (num_tx != num_prio)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "TX channel count %u must equal num-priorities %u\n",
> +				     num_tx, num_prio);

[Severity: Medium]
Can this equality check reject device trees that the in-tree binding
accepts?  Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
describes the two properties completely independently:

  xlnx,num-priorities:
    $ref: /schemas/types.yaml#/definitions/uint32
    minimum: 2
    maximum: 8

      dma-names:
        minItems: 2
        maxItems: 16
        items:
          pattern: "^(tx|rx)_chan[0-7]$"

With that schema, dma-names = "tx_chan0", "rx_chan0" together with
xlnx,num-priorities = <2> validates, but xlnx_tsn_ep_probe() now fails with
"TX channel count 1 must equal num-priorities 2".  A 4 TX + 4 RX endpoint
under xlnx,num-priorities = <8> fails the same way.

The queue node checks in ep_parse_tx_queue_config() add a second constraint
that the schema does not express: exactly one queue<N> node per TX channel,
with dense indices 0..num_tx-1.  The schema has no required queue children
under tx-queues-config, so an empty

  tx-queues-config {
  };

is schema-valid and gets "tx-config: described 0 queues but expected N",
and sparse names such as queue0/queue1/queue2/queue7 with 4 TX channels get
"tx-config: invalid queue node queue7 (have 4 queues)".

Because the endpoint MAC is the DSA conduit referenced by
port@0 { ethernet = <&ep_mac>; }, a probe failure here also takes away the
three-port switch, not just the ep0 netdev.

Semantically these look like different things: xlnx,num-priorities is an
IP-wide traffic class count on the parent node, while dma-names describes
host-side MCDMA wiring on the endpoint node, and the binding's own example
uses an arbitrary queueN -> tx_chanM permutation.  num_prio is read here for
no other purpose than this comparison.

Should the binding encode the coupling (required queue children and a
dma-names/num-priorities relation), or should the driver accept every
topology the binding advertises?

The YAML is unchanged by this patch and by the remainder of the series, and
only the 8 TX / 8 RX, xlnx,num-priorities = <8> example in the binding
satisfies the driver, so dt_binding_check does not surface the mismatch.

Could the commit message body state these new device tree requirements?
Right now they appear only in the below-the-line v2 changelog:

  - Require one queue node per tx_chan and num-priorities equal to the TX
    channel count.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-patches_v2_external-v2-0-3a40babaff4c%40amd.com
