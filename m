Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CEF3F1AD3;
	Sat, 17 Oct 2026 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792229696; cv=none; b=ncBkuqvB/1k51YTUGS6rliABDIRqU/voPOcZNfgimTApuBu7MazkdzI4nu13kFJ8APcr7ea1y+lCV2nx2SLxJL0DNBSn1bZzW5R1liTj2afW62San31HhV0H1HWxN5Np8iRKKwrWp1Rmbx6P6FNbwPJuX3xz5Qu87F3kqVoneK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792229696; c=relaxed/simple;
	bh=BwaK+6/iJVcxfkJPgcqnRIbk5s8WgGlaNro2vfOxH5U=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gUKmhODOMhOzSzBnxScvJMFBWGekM7/0ABGn4KorL++NKJHgsYvViu8iZoWoDeAeYV3ajPBoEmiyUM7W7zccjCg1pQc61R30x2NKRAZ1/DNpUBaTh0U0sZ7KGALJu1D/cAdD1jQIdVaHo9NeMmkndc1xjk7vXLh+EQpk2JFNsok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0QF2wTb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0QF2wTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2A91F000C5;
	Sat, 17 Oct 2026 09:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792229695;
	bh=qsicxrFsgo+BrmWaBVgaShqAZ/L71C0Mw7+aVwEvjmE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z0QF2wTbhZumL3N0Hy3P+3Mxgn07QpLQzlJQhVCfyvW/GUOxvplujR9bARmLCjdk/
	 nqzmMZYvJq7B0Bg88DlsheqniT2PlIOvSZHqa5zE6CiMRAqSasK9CtR2ppEp8FJgee
	 orVV2ynBxasBL2GGySRdAoH6j5Ew66Ejy71Z+OkjF2GqT2sGZJGeTpJ6jYjpG9GOPQ
	 IsVxZRNnqX7KulNlT6F3Flinsgj1S3k0OTzOpWnwSQafg5APL14wRJoJonKrte81WQ
	 VbH8XsOi6S+o5g91FmkTdR/lJpQNJe0AfresuSoCQAUF99Gbkj3Yq12yf4okbkoXxB
	 9akPgdrruXLCQ==
Message-ID: <sashiko-outbox-175445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v3 7/8] net: xilinx: tsn: add the endpoint TX
 data path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261016-patches_v2_external-v3-7-e33d3960ca1e@amd.com>
References: <20261016-patches_v2_external-v3-0-e33d3960ca1e@amd.com>
 <20261016-patches_v2_external-v3-7-e33d3960ca1e@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 09:34:54 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: Use-after-free of skb in ep_start_xmit() due to late timestam=
ping
--

commit 6fa02caf949cb04194e431c851b503c66e08312c
Author: Srinivas Neeli <srinivas.neeli@amd.com>

net: xilinx: tsn: add the endpoint TX data path

This commit adds the transmit path so the endpoint can send frames. It
selects the TX channel by indexing tx_chans[] with the frame's logical
queue, maps the frame, and submits it to the DMA engine.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/ne=
t/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 0a13e04d40575..bd8cd504cefb4 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> +static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device =
*ndev)
> +{

[ ... ]

> +	spin_lock_bh(&xchan->tx_lock);
> +	cookie =3D dmaengine_submit(dma_tx_desc);
> +	if (dma_submit_error(cookie)) {
> +		spin_unlock_bh(&xchan->tx_lock);
> +		skbuf_dma->skb =3D NULL;
> +		goto err_unmap_sg;
> +	}
> +	WRITE_ONCE(xchan->ring_head, xchan->ring_head + 1);
> +	netdev_tx_sent_queue(txq, skb->len);
> +	netif_txq_maybe_stop(txq,
> +			     CIRC_SPACE(xchan->ring_head,
> +					READ_ONCE(xchan->ring_tail),
> +					xchan->ring_size),
> +			     2, 2);
> +	spin_unlock_bh(&xchan->tx_lock);
> +
> +	skb_tx_timestamp(skb);

[Severity: High]
Is there a use-after-free risk for the skb here?

If dmaengine_submit() successfully transfers ownership of the descriptor to
the DMA engine, and the lock is subsequently released via spin_unlock_bh(),
could the following sequence occur:

CPU1 calls dmaengine_submit() and unlocks xchan->tx_lock.

The hardware begins processing the descriptor and triggers the completion
callback on another CPU.

CPU2 executes ep_dma_tx_cb(), unmaps the buffer, and frees the skb using
dev_consume_skb_any(skb).

CPU1 resumes execution and calls skb_tx_timestamp(skb), which attempts to
access the shinfo area of the already-freed skb.

Should skb_tx_timestamp() be called before the transmit lock is dropped,
or prior to handing the skb over to dmaengine_submit()?

> +	dma_async_issue_pending(xchan->chan);
> +
> +	return NETDEV_TX_OK;
> +
> +err_unmap_sg:
> +	dma_unmap_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
> +err_drop_skb:
>  	dev_kfree_skb_any(skb);
>  	DEV_STATS_INC(ndev, tx_dropped);
>  	return NETDEV_TX_OK;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-patches_v2=
_external-v3-0-e33d3960ca1e@amd.com?part=3D7
