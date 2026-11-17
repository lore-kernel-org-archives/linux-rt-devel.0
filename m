Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921287;
	b=btGZTOh0dFzq8hCDh9hy0j2q8rRVXvGjn3oxoYJowF0yM8DtzAnqKQMLQe4mCprcssMS
	 z1KiSaT+OJlnY8XgjaC1HlITOJVibsTJ10HcQ/1j5zvFsBDFtR8XUns6xUFk+6zZRurri
	 jvZ5TznJvb+z2KppjKXvBcwlKlrJ5G4ng9g+h0cgU4hZlIRLFaWUlXPjOsKMbYQuq8zGP
	 +Gl4eHEA+3Jdat6rk9N+YRoYEufHSiP4F7RLM41CzigmJGTIcbgFWwEKr8xPjy+euE9ez
	 qMpEfGlEZ8GjfJkvo2BCGFPYazs13rkEllw070G8JTL4GITjRKx+XTEF5g8xUMpLAag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921287;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=0qKcuyhzLFuBHbczAbqx5crwyCe5DTKBouONLeSXJ7A=;
	b=pm9fcD6MomQ+XwbT+q2mEoDslmzagvHjuqOMDg+fLy+NMQgt5E4KD73ZlnyxyHjV204V
	 o89lIsWloTr7kmE2tWwpt+hpDWj8C4uz+QvDsscxEgd/c4UbC53IqYHNUhiC3+XI7uVLx
	 zx/pQWxwf/gHlemMS7iJJWxqpk/3kgjJBbOBDXDTTTxavc3cj6ck38jZl5MbFSJ1zqMuP
	 FceJGnABVjsZiIjidosROpWW4V6imd2U9Sv1yKD+4GKSWkjva62S05RA/J+20AdoDvM6R
	 pWlEvRQtr1JMle6JQt3KSPBx3ah99QqlrL6K5ugeVWZXj7hBlIAtEWB5UuzPXSJh+Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G64rw3CY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D24606A8BA;
	Tue, 17 Nov 2026 13:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G64rw3CY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E991F000C9;
	Tue, 17 Nov 2026 13:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794921286;
	bh=0qKcuyhzLFuBHbczAbqx5crwyCe5DTKBouONLeSXJ7A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=G64rw3CYHmgxRV/7GES39h1YULxbfVBT+cug1THdGAri/RqGKaMXNzkikasyR7m7O
	 c7YS74i8mNWKuefEWuDB5xLPkDpyCWy321NqP7jfxtknrk8xl6sOq37Ipub/fE6EaL
	 L3hOeyVbZt8N9E48dqn6qcFUEA/ccSwXT+MVKtIOFN6VmMSIt+AQ5h52ueJyQng8EK
	 /5lPSC8APo+at6ba3BJOUVelxnSSpbUda5mHJgXHy+j5avTqXyNkFUMKxQ7XFYRcsI
	 tVVwf4jvnuo3uMDIO/x5uqHpCU2rLUoGF3py7u1FAbVXjXYZV1+ZTOjo0Xo4hBCbS8
	 fVqdWv/zaS7pQ==
Subject: Re: [PATCH net-next v4 4/8] net: xilinx: tsn: parse endpoint DMA
 channel configuration
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, git@amd.com, neelisrinivas18@gmail.com
Date: Tue, 17 Nov 2026 13:14:44 +0000
Message-ID: <179492128482.3136.14229628808606591959@kernel.org>
In-Reply-To: <20261113-patches_v2_external-v4-4-56bb26f042a4@amd.com>
References: <20261113-patches_v2_external-v4-4-56bb26f042a4@amd.com>
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

- [Low] The driver requires the number of tx_chanN entries in "dma-names"
  to equal "xlnx,num-priorities", but the DT binding does not encode or…

--

net: xilinx: tsn: parse endpoint DMA channel configuration

This patch counts the tx_chanN and rx_chanN entries in dma-names and
allocates the conduit netdev with that many TX and RX queues. It parses
the tx-queues-config child node to map each logical TX queue to a TX DMA
channel. Probe also requires the TX channel count to equal
xlnx,num-priorities on the parent IP node.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index b6458bb0ba0fd..9458db38255d4 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -69,15 +88,180 @@ static const struct ethtool_ops ep_ethtool_ops = {

[ ... ]

>  static int xlnx_tsn_ep_probe(struct platform_device *pdev)
>  {

[ ... ]

> +	ret = of_property_read_u32(ip_np, "xlnx,num-priorities", &num_prio);
> +	of_node_put(ip_np);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "missing xlnx,num-priorities\n");
> +
> +	if (num_prio < TSN_MIN_PRIORITIES || num_prio > TSN_MAX_TX_QUEUE)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "invalid xlnx,num-priorities %u\n",
> +				     num_prio);
>  
> -	ndev = alloc_etherdev(sizeof(*ep));
> +	if (num_tx_dma_channels != num_prio)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "TX channel count %u must equal num-priorities %u\n",
> +				     num_tx_dma_channels, num_prio);

[Severity: Low]

Is this equality check stricter than what the binding in
xlnx,tsn-endpoint-ethernet-mac.yaml allows?

The binding says the following and nothing more:

  - each dma-names item matches "^(tx|rx)_chan[0-7]$"
  - there are 2..16 items, with at least one TX and one RX entry
  - each queueN under tx-queues-config maps to a distinct TX channel
    listed in dma-names

Taken together, these rules only require the TX channel count to be at
least xlnx,num-priorities. They don't require it to be equal.

For example, this DT looks valid against the schema:

    xlnx,num-priorities = <2>;
    ...
        dma-names = "tx_chan0", "tx_chan1", "tx_chan2", "rx_chan0";
        tx-queues-config {
            queue0 { xlnx,dma-channel-num = <0>; };
            queue1 { xlnx,dma-channel-num = <1>; };
        };

But xlnx_tsn_ep_probe()->ep_count_dma_channels() counts three TX
channels, and probe then fails with:

    TX channel count 3 must equal num-priorities 2

The commit message says equality is the intended rule. Should the binding
state or enforce that in the xlnx,num-priorities or dma-names
descriptions? Or should the driver accept extra TX channels that no queue
uses?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-patches_v2_external-v4-0-56bb26f042a4%40amd.com
