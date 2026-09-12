Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1171495021;
	Sat, 12 Sep 2026 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789245384; cv=none; b=uIUM3kvEb4Vs56k1UpU0tIpdeEK67x4OBcrWTkET8leX/+zkOH/sZ690YgxZxNymqj8BeijnGcPPJ2tVL8+e3aJWEbP5yB6nFmqSM6OrYgfQmhtOHsa4JrWwhOzpcmI2QLwZauGYSNrDKA2TAs+kFDVyHLJtXzRV0XxYpXZ2Vn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789245384; c=relaxed/simple;
	bh=wZ6ON7nbByGn6aphJaFrr3m6yrZUFPatxIwXW1TVGgY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUQ//gyM+1xs7ksUNXXNzevIpc3Hm/N89gTB/TDy1bu93UkeZTzGC5gQ5uMkcW4wR/RJi1wjfv2oAN+Xfbw+Lgi9Th6pRHx249IJzou587YM28Oqobv7VmHIrJi5+Q1RQkifuxhd1gVA54ivHPrUoIOuMo78Nwiu+jAYnjUVWao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nt8NHwrz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nt8NHwrz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD341F0089C;
	Sat, 12 Sep 2026 20:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789245379;
	bh=zSsm6oTmFMVfKovf/ccETQl62thue38ciB9y/XGgrIc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nt8NHwrz7tjVMmsF1D2RYudIdaMVokWyjkEZWsDPCLc+G4GIxN8/Oiou5T7ZBsFxU
	 gxn64RQ2VFYwEl/GE+dBznbxVSSMOgSRXluuldkHMZrvl9BXIoEMoLu9qELFGG7zZi
	 JgQwp1rcFLaV2NfzA0A0GJbDm3oKgZBVez9rYy2C+cZfXR9jJDfExXvnpr5gj94zYW
	 LeQT5WKQ5ey37Susq+2n1nQJJnK9XHriSUgFhKaJ9/nfYAXR2ZHrm9g4XXGlHS0dCx
	 Uvba/Zhoa1xBC5cuDB4iU7IsUCkFLl/Yjoit65of1Bvc7E1/95XWdPEbbWf6bYdAkd
	 nH60Oj9LVrESg==
Subject: Re: [PATCH net-next v2 8/8] net: xilinx: tsn: deliver endpoint RX
 frames to DSA user ports
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
 michal.simek@amd.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Sat, 12 Sep 2026 20:36:17 +0000
Message-ID: <178924537752.3125.4000398250445793561@kernel.org>
In-Reply-To: <20260909-patches_v2_external-v2-8-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-8-3a40babaff4c@amd.com>
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

- [Medium] The new RX metadata attach in ep_dma_rx_cb()
  (drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c:303-307) is gated on…

--

net: xilinx: tsn: deliver endpoint RX frames to DSA user ports

This patch allocates one METADATA_HW_PORT_MUX metadata_dst per MAC port at
probe time and attaches the matching entry to each RX frame based on its
TUSER port_id, so that DSA can route frames to the swpN user netdevs. The
entries are freed with dst_release() on probe failure and at remove.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 9e9a45169681..db7da26521d0 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -292,6 +301,10 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  	}
>  
>  	skb_put(skb, rx_len);
> +	if (netdev_uses_dsa(ndev)) {
> +		dst_hold(&ep->port_md[port_id]->dst);
> +		skb_dst_set(skb, &ep->port_md[port_id]->dst);
> +	}

[Severity: Medium]

Can this branch ever be taken with the current tree?  netdev_uses_dsa()
requires a DSA switch to have claimed this netdev as its conduit:

include/net/dsa.h:netdev_uses_dsa() {
	return dev->dsa_ptr && dev->dsa_ptr->rcv;
}

drivers/net/ethernet/xilinx/tsn/ contains only Kconfig, Makefile,
xilinx_tsn.h, xilinx_tsn_ep.c and xilinx_tsn_main.c, and xilinx_tsn_main.c
registers only the wrapper and endpoint platform drivers:

static struct platform_driver * const tsn_drivers[] = {
	&tsn_driver,
	&xlnx_tsn_ep_driver,
};

There is no Xilinx/xlnx TSN switch driver under drivers/net/dsa/ and no
"xlnx,tsn-switch" compatible anywhere in the tree, so nothing sets
dev->dsa_ptr for this netdev.  The Kconfig help text points at an
out-of-tree component:

	  and the endpoint MAC that connects the IP to the host CPU. The
	  three-port switch is supported by the companion DSA driver.

The commit message states as fact:

    Frames from MAC1 and MAC2 now reach the correct user netdev, which
    completes the conduit data path.

Since the switch-side DSA driver is not part of this submission, is that
result reachable today?  Would it make sense to either submit the DSA
switch driver in the same series or state the dependency in the commit
message, so the port_id 1/2 -> swp1/swp2 contract can be reviewed against
its consumer?

>  	skb->dev = ndev;
>  	skb->protocol = eth_type_trans(skb, ndev);
>  	skb->ip_summed = CHECKSUM_NONE;

[ ... ]

> @@ -854,6 +867,37 @@ static int ep_count_dma_queues(struct device *dev, u32 *out_tx, u32 *out_rx,
> +static int ep_alloc_port_md(struct xlnx_tsn_ep *ep)
> +{
> +	int i;
> +
> +	for (i = TSN_TUSER_PORT_MAC1; i <= TSN_TUSER_PORT_MAC2; i++) {
> +		struct metadata_dst *md;
> +
> +		md = metadata_dst_alloc(0, METADATA_HW_PORT_MUX, GFP_KERNEL);

Related to the above: these two metadata_dst objects are allocated
unconditionally in xlnx_tsn_ep_probe() and kept for the device lifetime,
including on CONFIG_NET_DSA=n builds where netdev_uses_dsa() folds to a
constant false and the attach site in ep_dma_rx_cb() compiles away.  Should
the allocation be tied to the conduit actually being used, or is holding
them unconditionally intended?

> +		if (!md) {
> +			ep_free_port_md(ep);
> +			return -ENOMEM;
> +		}
> +		md->u.port_info.port_id = i;
> +		ep->port_md[i] = md;
> +	}
> +
> +	return 0;
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-patches_v2_external-v2-0-3a40babaff4c%40amd.com
