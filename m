Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497499;
	b=jbnrbn5E3Wc/DEaC6H22P9thTZHorq0DhNjCjWkwmwJ0/+hCJ0HAwdWHlffxuZCMkoYt
	 hL8/W2nXb6Gsg1hoIR57bnJ7eog9AaMGlpIrfyIm2dp3TVAt4M2Y8aqY09OE3Uv0YRp63
	 RAMUidwtgUxcjJRzIH9Dq8zFSRKPYKKAvK3NnFiOQDUb1TNIGt5W9cfMcYU/jp9AWY4ys
	 R+/YsGR8n96/LWA/kL2XBRTxrHVBdUzbhp8Wu9Do6rcpg6L2WsltYwPh8LibudfkyNqny
	 KPdwaQgex/WS/VbfyEcTJSpNk3qWXmO9wuJJeajDQ+NzOIKyni6gjLpbG91oZDmg6nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497499;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=syc3GYQ5HvVy0QHYkXhBl6da7phjefuxw0j+dRWKLBw=;
	b=H/SO7dg2A8FK0X32gtKyr5d0c/HmfN+hXOMpXyZocSC6vzyvfC6jW0YgTde6/aoXpQfN
	 BqiLLLgXfgRmN1zMYyriSt83iEEytG5Fmr/bZ526HDnMhd5+19cAIlYZjlkLP2kFQNtWZ
	 y3D160BQYWURvdCh/uLGkYIYpbVSecGMJR73jVfxaghR/2sLW7ia6TsCmvA74CMWUu3fN
	 Go5rp0qIdkYYX5oFbvTq84vs+b6PUnO1NwoIQH2euICav4WPIK7pUOOpY9muGPQOMpWAC
	 VepqgSCtY5nDOeNG65BXuUbn0sKTmR2qZqaT52hrj7fywdlHT3YhKnSaQ4yF8aH2wrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnUcpCPj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24137606A31A;
	Tue, 20 Oct 2026 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cnUcpCPj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5674E1F000C5;
	Tue, 20 Oct 2026 11:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497498;
	bh=syc3GYQ5HvVy0QHYkXhBl6da7phjefuxw0j+dRWKLBw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cnUcpCPj39aSwUbTJl2ImdBjxR7PcPSlyyhK2fmIidXWub5mBTFxmVd9heKYG4QTJ
	 nkmZeZhbiLSpXv2u66P9YRvX8U0pCQxqjnthY+cgsEIPop88eiO92TTlmxSPT/w8wJ
	 UsKOMxfBGs9+VTWHu0qaHvqmS6ZtZRjf3iKc5kfvwf5K/wIQoFBqG6aj9vF/zj8SEY
	 NghsPBP0ICykBe0HZ51DRfl5en/V+3+v0jKbcqTw4PJZ/w4xKLib3oupdOnJfEFqZ9
	 oz8V7/5Hn+jhooaS9MLh9YZxtQeDob0VLJEuyO0/nkhfK9pGInGgOCF7ImO4Dq3JKH
	 puZkQgbj/2cuA==
Subject: Re: [PATCH net-next v3 4/8] net: xilinx: tsn: parse endpoint DMA
 channel configuration
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Tue, 20 Oct 2026 11:58:16 +0000
Message-ID: <179249749685.3135.16300213883821767663@kernel.org>
In-Reply-To: <20261016-patches_v2_external-v3-4-e33d3960ca1e@amd.com>
References: <20261016-patches_v2_external-v3-4-e33d3960ca1e@amd.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The driver enforces DT rules that the in-tree binding
  (Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-…

--

net: xilinx: tsn: parse endpoint DMA channel configuration

This commit counts the TX and RX MCDMA channels listed in dma-names and
allocates the conduit netdev with that many queues. It also parses the
tx-queues-config child node to map each logical TX queue to a tx_chanN
entry. Probe fails if the mapping is not one-to-one, or if the TX
channel count differs from xlnx,num-priorities.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 609d444c68356..2adee07f6f51c 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

>  static int xlnx_tsn_ep_probe(struct platform_device *pdev)
>  {

[ ... ]

> +	ip_np = of_get_parent(dev->of_node);
> +	if (!ip_np)
> +		return dev_err_probe(dev, -EINVAL, "missing parent IP node\n");
> +
> +	ret = of_property_read_u32(ip_np, "xlnx,num-priorities", &num_prio);
> +	of_node_put(ip_np);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing xlnx,num-priorities\n");
> +
> +	if (num_tx_dma_channels != num_prio)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "TX channel count %u must equal num-priorities %u\n",
> +				     num_tx_dma_channels, num_prio);

[Severity: Medium]
Do these rules match what the binding in
Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
allows?

Here xlnx_tsn_ep_probe() requires the number of tx_chanN entries in
dma-names to equal xlnx,num-priorities. ep_parse_tx_queue_config() adds
three more rules:

	if (!str_has_prefix(qnode->name, "queue") ||
	    kstrtou32(qnode->name + strlen("queue"), 10, &queue) ||
	    queue >= ep->num_tx_queues)
	...
	if (test_and_set_bit(chan, chan_seen))
	...
	if (count != ep->num_tx_queues)

The binding only has:

	dma-names:
	  items:
	    pattern: "^(tx|rx)_chan[0-7]$"
	  allOf:
	    - contains:
	        pattern: "^tx_chan[0-7]$"
	    - contains:
	        pattern: "^rx_chan[0-7]$"

	tx-queues-config:
	  patternProperties:
	    "^queue[0-7]$":

The allOf blocks at the end of the binding only require queue0 through
queue(num-priorities - 1). The binding does not tie the tx_chanN count to
xlnx,num-priorities. It does not forbid queueN nodes at or above
num-priorities, and it does not require each queue to use a distinct
channel.

Its description reads as a general mapping:

	For example, queue0 with xlnx,dma-channel-num set to 5 means
	priority queue 0 uses tx_chan5 for data transfer.

So some device trees pass schema validation but would make probe fail
with -EINVAL. For example:

  - xlnx,num-priorities = <4> with all eight tx_chanN entries listed and
    queue0..queue3 mapped to channels 4..7
  - xlnx,num-priorities = <2> with queue0, queue1 and queue2 nodes
  - xlnx,num-priorities = <2> with two tx channels and both queues
    mapped to channel 0

The binding also sets minimum: 2 for xlnx,num-priorities, and the driver
does not check that.

Later patches in the series do not change the binding, so the mismatch
is still there at the end of the series.

Should the binding describe and enforce the one-to-one queue/channel rule
and the num-priorities rule? Or should the driver accept the general
mapping that the binding describes?

>  
> -	ndev = alloc_netdev(sizeof(*ep), "eth%d", NET_NAME_UNKNOWN, ether_setup);
> +	ndev = alloc_netdev_mqs(sizeof(*ep), "eth%d", NET_NAME_UNKNOWN,
> +				ether_setup, num_tx_dma_channels,
> +				num_rx_dma_channels);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-patches_v2_external-v3-0-e33d3960ca1e%40amd.com
