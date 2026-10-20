Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497501;
	b=aiL4uxkV9ILXdJXTAL3Gwr5GDj9U0IWYwZnIh79PJOGMhEgWOh65xsqN830QAYNPMh1T
	 93zNwNixR4qIwfYs2MtIu3SbTB7gF/PtsshsSQYI6Jf+/5ic3uWe19mWIzBr3tsUrpIEX
	 FyNj1DE0z8sgedBqpwszonA1vkh1Os5qB2MJT39hcN+sb9lO1o8+in4l9VzAlV4P5TEFh
	 109XPcNjdsXHcaN12UF6vd/pYp5JFt42QvPZ+gT41XegjizirWsj/oACj2EVeYG30SeN0
	 TDOsRLVdU2xYJb588Mdh9o9aDtc9PdemwLQ6eNZVM1eksUigPcHC8ZXjMnYMG9v30PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497501;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vpSCBqmNjvCfEzI72/33mULq5zVEPuCqZqDGgmalYOY=;
	b=b37DW4VqRYQqrWc8AZLyF57gKWQZWW1hsOoTMYNa8WY+1fBdylFa08zAYJfA5m3lSZ3z
	 8yf9KhHxbXUf6CbqG4qg5jlweUJPS7CK6PMyQrmqRSfFZ8hFQmfM16E6EwT8VMLwOTtVR
	 kF5w9hcaSYyCbMT58Q5h1pvJiHuzWWfsMAnmjwMvWNMFiPsDWMZzNSUcCI6mE1ka3LB1a
	 rH5bxnq6tISsqbSJhYhbNd8d1b3Esp2Num/0/q5YWVQy1Ha0FOidXthPm2hMA5QqO7RQZ
	 F3mL+H5jHKU3WhfghVB6xJx24uwMJKmU0AxdmgJQSSQ6ouTN/Fi7NHz1XiBpeXaIbLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d06FRsxT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52BE606A334;
	Tue, 20 Oct 2026 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d06FRsxT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C75A1F000D0;
	Tue, 20 Oct 2026 11:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497500;
	bh=vpSCBqmNjvCfEzI72/33mULq5zVEPuCqZqDGgmalYOY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=d06FRsxTYwJ+qu0tcjaH6OWzrK5d7sFyMXIiFtk7iRrBnhNYxn41KXbuDQ8qFLX1P
	 NwK+M3H9oKgi3VJF+1Kylh6XAcsYBb4Rg/xw+8/ScH6NHorpyiQFiTOoNozPo4u8oW
	 FOvuvp6DcMoEXP2UXJ1zdgSRnIxnFnrV96rRH+kEY81w1PW4c8t9GSqmxXQiQDqrhG
	 nUgbMc6NFgxu2d61LqK0Cg6KRJaVfV7hvwWXvIIFUKIXDW7C9f8xvAkxUS0Z7oULU0
	 rmHHVUDPA9BeARbYd3BOhzyc7F4y09rj5XLwYjQfUGLPyMaeJybdrFmODVpM1bUA0t
	 qGDxNfw5Izzgw==
Subject: Re: [PATCH net-next v3 5/8] net: xilinx: tsn: bring up the endpoint
 MCDMA channels
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Tue, 20 Oct 2026 11:58:18 +0000
Message-ID: <179249749885.3135.15584191069467566874@kernel.org>
In-Reply-To: <20261016-patches_v2_external-v3-5-e33d3960ca1e@amd.com>
References: <20261016-patches_v2_external-v3-5-e33d3960ca1e@amd.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ep_reset_dma_controller() resets the whole MCDMA core at probe
  through one channel handle, but the driver does not own every channel…
- [Low] In drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c, the kernel-
  doc for struct skbuf_dma_descriptor calls @dma_address the "physical…

--

net: xilinx: tsn: bring up the endpoint MCDMA channels

At probe, this patch requests every TX and RX MCDMA channel named in the
device tree and holds them until remove. It also resets the MCDMA
controller once, through the first TX channel. Each channel gets a ring of
preallocated SKB descriptor slots in ndo_open, and the rings are torn down
in ndo_stop.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 2adee07f6f51c..ab3d6d8cb9440 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -30,6 +35,47 @@
>  #define TSN_MAX_VLAN_FRAME_SIZE		(ETH_DATA_LEN + VLAN_ETH_HLEN + \
>  					 ETH_FCS_LEN)
>  
> +#define TX_BD_NUM_DEFAULT		64
> +#define RX_BD_NUM_DEFAULT		128
> +
> +/**
> + * struct skbuf_dma_descriptor - skb container for each in-flight DMA descriptor
> + * @sgl: scatter-gather list backing the DMA mapping
> + * @desc: dmaengine descriptor handle
> + * @dma_address: physical address of the first sgl entry (RX path)

[Severity: Low]

This isn't a bug, but is "physical address" the right description for
@dma_address?

The field is a dma_addr_t. ep_free_dma_chan() passes it to
dma_unmap_single() as a mapping handle, and in the RX data path patch
ep_rx_submit_desc() fills it from sg_dma_address() after dma_map_single().
If an IOMMU sits in front of the MCDMA, the value is an IOVA, not a CPU
physical address.

The same wording is still there at the end of the series. Would something
like "DMA address of the first sgl entry" be more accurate?

> + * @skb: SKB owning the buffer
> + * @sg_len: number of valid entries in @sgl (TX path)
> + */

[ ... ]

> +static int ep_reset_dma_controller(struct xlnx_tsn_ep *ep)
> +{
> +	struct xilinx_vdma_config cfg = { .reset = 1 };
> +	int ret;
> +
> +	ret = xilinx_vdma_channel_set_config(ep->tx_dma[0], &cfg);

[Severity: Medium]

Can this reset stall channels on the same MCDMA instance that belong to
another dmaengine client?

The commit message says:

  "An MCDMA soft reset resets the whole core, so any channel of the
  instance reaches it."

For MCDMA, every MM2S channel uses ctrl_offset 0, which is the common
control register. The call chain is:

xlnx_tsn_ep_probe()
  ep_reset_dma_controller()
    xilinx_vdma_channel_set_config()
      xilinx_dma_chan_reset()
        xilinx_dma_reset()

drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_reset() {
	dma_ctrl_set(chan, XILINX_DMA_REG_DMACR, XILINX_DMA_DMACR_RESET);
	...
	chan->err = false;
	chan->idle = true;
	chan->desc_pendingcount = 0;
	chan->desc_submitcount = 0;
	...
}

The hardware reset hits the whole core, but software state is only reset
for tx_dma[0].

The endpoint only requests the tx_chanN/rx_chanN entries in its own
dma-names. Nothing in the binding or the driver stops the other channels of
the instance from going to another consumer. Suppose one of those channels
is mid-transfer when the endpoint probes, for example after a probe
deferral or a module load. It is still marked idle == false and has
descriptors on active_list. Its next submit then goes through:

drivers/dma/xilinx/xilinx_dma.c:xilinx_mcdma_start_transfer() {
	...
	if (chan->has_sg && list_empty(&chan->active_list))
		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
			     head_desc->async_tx.phys);
	...
	if (chan->idle)
		xilinx_dma_start(chan);
	...
}

CDESC is not reprogrammed and xilinx_dma_start() is skipped. Doesn't that
leave the engine halted, with no error reported to that client?

I could not confirm that shared MCDMA designs exist in practice. The
binding example gives the whole instance to the endpoint.

Is the reset needed at all? The provider already resets each channel in
xilinx_dma_chan_probe(). The MCDMA path of
xilinx_dma_alloc_chan_resources() only allocates BD memory and does not
program the hardware. So the endpoint's own channels look clean already,
and the only visible effect of this reset is on channels the endpoint does
not own.

Calling dmaengine_terminate_sync() from ep_free_dma_chan() on ndo_stop also
resets the whole core, through the provider's xilinx_dma_terminate_all().
Any MCDMA client that terminates a channel causes this, so that part comes
from the provider and not from this patch.

> +	if (ret < 0)
> +		return dev_err_probe(ep->dev, ret,
> +				     "failed to reset DMA controller\n");
> +
> +	return 0;
> +}

[ ... ]

> @@ -286,9 +587,17 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_free_ndev;
>  
> +	ret = ep_request_dma_chans(ep, rx_dma_chan_map);
> +	if (ret)
> +		goto err_free_ndev;
> +
> +	ret = ep_reset_dma_controller(ep);
> +	if (ret)
> +		goto err_release_chans;
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-patches_v2_external-v3-0-e33d3960ca1e%40amd.com
