Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794657915;
	b=p7ATrC2FJUkGY2XVuNyLRLiEZidlJOrn2seSm12McThB/Qdta7AGPrmnmBHBeo59i6vg
	 /1QOKrObs0NBfz5sKBzkHMk4LwnRzCg5IeQ0OuVkBPu7ZiQLPPSwjp2U/iTtj2rQ3kYdM
	 CTXksQWdQvoNXYrVVa7BFa8St0nipvJvIaou88rycBQc0HksdeftLi1lEkzpqUa7E6ODm
	 RG2RNNRImDsabO35k7GoAyc5pfx/EJotSnpvaARp/PFYlVhWNQidgfwQzc225haJ7ZxV3
	 4NLxGY+vQvcY/U7Q2Hyw2sAoFTDDI4ZdeCWyU7sVStRH+pFrfIVUwLhCl9dDM89//kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FSQkRh0e4NqtbxT9WcFW29DNygz1S0dpmCNdibajqEE=;
	b=HVEVz4XuKygCNFbwBsZ1TwpStKfbGwQqMwgDM9/zQ4GyI8SuAc1gPYqjZEcgxs6pfGMX
	 bmmDBUeBGFOCY3UTeWPJrTBysePP2qOn68B0vDAYjMn0RoDqKRQa47PLNG7CQ21+bAMjc
	 5WwAnLiNN6yt+ZyG9CGAOunTweq96KVjonv9q7CFJr7jPXdlqM1es3jGpST/DmoLm4kC2
	 j6Dc8T3Oi7aCWNF3Vk+90F6LwCZ5rxWLVwQwv+pym4qxjKvahZ3F3+n3rL/MATAjfknKg
	 leLylR0UraasabOm3UPUGoUI5fUgD4wXJCx+ryBYxm1hJ2YCzgalKIYF2QrbAF5mZ3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSVQD3Sg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF32606A884;
	Sat, 14 Nov 2026 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FSVQD3Sg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7073D1F000C4;
	Sat, 14 Nov 2026 12:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794657915;
	bh=FSQkRh0e4NqtbxT9WcFW29DNygz1S0dpmCNdibajqEE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FSVQD3Sgp1goQVR80NNrhSidvYo/eDrUnufRHQRd5QbsbGEI9KKqumjKLOeUUpkhV
	 XaXUA5DQQOq4c8Uxx1rwZY33RfnuDIiDWBhE1wtgCq536BcbeEQEAMbdhL37tScjAt
	 i3zZwJibt6ugzQRtgEXJVQS2Cdipcuq5u9MTU8mKwFLbvMcGic4pkSsktszNxDCQxO
	 cq4WbztJ37cgAA/jAFq1cbwe+OxMEPVJ4jNawFlcPDig9V+oJmpPJRYUEeYWFJfwyE
	 L7f23pyi2D2/zpLUH5diUcA86QKl/AwGf6p8Pneq5loisGzfe9XMqa9IFagtsYLQRP
	 fBmewqdDFYAYQ==
Message-ID: <sashiko-outbox-214491@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 7/8] net: xilinx: tsn: add the endpoint TX
 data path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261113-patches_v2_external-v4-7-56bb26f042a4@amd.com>
References: <20261113-patches_v2_external-v4-0-56bb26f042a4@amd.com>
 <20261113-patches_v2_external-v4-7-56bb26f042a4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 12:05:15 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] net: xilinx: tsn: ep_stop() terminates TX DMA before
  netif_tx_disable()
- [Medium] net: xilinx: tsn: missing TX DMA error recovery in
  ep_start_xmit()
- [Medium] net: xilinx: tsn: ep_start_xmit() TX flow control ignores DMA
  segment limit
--

commit a8a4f14fcbe22e1b33cd5c8b571aab05e71576de
Author: Srinivas Neeli <srinivas.neeli@amd.com>

net: xilinx: tsn: add the endpoint TX data path

This commit adds the transmit path and TX DMA completion handling for the
Xilinx TSN endpoint driver.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/ne=
t/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index f179062c7d148..6e2721a74f287 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -311,8 +316,151 @@ static void ep_dma_rx_cb(void *data, const struct d=
maengine_result *result)
>  	ep_rx_refill(xchan, true);
>  }
> =20
> +static void ep_dma_tx_cb(void *data, const struct dmaengine_result *resu=
lt)
> +{
> +	struct xlnx_tsn_ep_dma_chan *xchan =3D data;
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	struct netdev_queue *txq;
> +	struct net_device *ndev;
> +	struct scatterlist *sgl;
> +	struct sk_buff *skb;
> +	int sg_len;
> +	int len;
> +
> +	scoped_guard(spinlock_bh, &xchan->tx_lock) {
> +		skbuf_dma =3D ep_get_desc(xchan,
> +					xchan->ring_tail & (xchan->ring_size - 1));
> +		if (!skbuf_dma || !skbuf_dma->skb)
> +			return;
> +
> +		skb =3D skbuf_dma->skb;
> +		sgl =3D skbuf_dma->sgl;
> +		sg_len =3D skbuf_dma->sg_len;
> +
> +		dma_unmap_sg(xchan->dma_dev, sgl, sg_len, DMA_TO_DEVICE);
> +
> +		skbuf_dma->skb =3D NULL;
> +		WRITE_ONCE(xchan->ring_tail, xchan->ring_tail + 1);
> +	}
> +
> +	ndev =3D skb->dev;
> +	txq =3D netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
> +	len =3D skb->len;
> +
> +	if (unlikely(result->result !=3D DMA_TRANS_NOERROR)) {
> +		DEV_STATS_INC(ndev, tx_errors);
> +		dev_kfree_skb_any(skb);
> +	} else {
> +		DEV_STATS_INC(ndev, tx_packets);
> +		DEV_STATS_ADD(ndev, tx_bytes, len);
> +		dev_consume_skb_any(skb);
> +	}
> +
> +	__netif_txq_completed_wake(txq, 1, len,
> +				   CIRC_SPACE(READ_ONCE(xchan->ring_head),
> +					      READ_ONCE(xchan->ring_tail),
> +					      xchan->ring_size), 2,
> +				   READ_ONCE(xchan->ep->closing));
> +}

[Severity: Medium]
Can an AXI MCDMA channel error leave a stopped TX queue permanently
wedged?

When xilinx_mcdma_irq_handler() handles XILINX_MCDMA_IRQ_ERR_MASK, it sets
chan->err =3D true, and xilinx_dma_complete_descriptor() only moves
descriptors to done_list when XILINX_DMA_BD_COMP_MASK is set.  In-flight
descriptors that do not complete never invoke ep_dma_tx_cb(), so
xchan->ring_tail does not advance and __netif_txq_completed_wake() is
never called.  If the subqueue was stopped by netif_txq_maybe_stop() or
BQL, ep_start_xmit() will not run again to reset the channel via
xilinx_dma_tx_submit(), and ep_netdev_ops defines no ndo_tx_timeout
callback to recover the channel and drain xchan->skb_ring.

> +
> +static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device =
*ndev)
> +{
> +	struct dma_async_tx_descriptor *dma_tx_desc;
> +	struct xlnx_tsn_ep *ep =3D netdev_priv(ndev);
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	int queue =3D skb_get_queue_mapping(skb);
> +	struct xlnx_tsn_ep_dma_chan *xchan;
> +	struct netdev_queue *txq;
> +	int sg_len, nents, ret;
> +	dma_cookie_t cookie;
> +
> +	if (unlikely(queue >=3D ep->num_tx_queues)) {
> +		if (net_ratelimit())
> +			netdev_warn(ndev, "Invalid TX queue %d (max %u)\n",
> +				    queue, ep->num_tx_queues);
> +		goto err_drop_skb;
> +	}
> +
> +	if (ep->tx_dma_chan_map[queue] =3D=3D TSN_DMA_CH_INVALID) {
> +		if (net_ratelimit())
> +			netdev_warn(ndev, "Logical TX queue %d has invalid DMA mapping\n",
> +				    queue);
> +		goto err_drop_skb;
> +	}
> +
> +	xchan =3D ep->tx_chans[queue];
> +
> +	sg_len =3D skb_shinfo(skb)->nr_frags + 1;
> +	txq =3D netdev_get_tx_queue(ndev, queue);
> +
> +	spin_lock_bh(&xchan->tx_lock);
> +	if (CIRC_SPACE(xchan->ring_head, READ_ONCE(xchan->ring_tail),
> +		       xchan->ring_size) <=3D 1) {
> +		netif_txq_try_stop(txq,
> +				   CIRC_SPACE(xchan->ring_head,
> +					      READ_ONCE(xchan->ring_tail),
> +					      xchan->ring_size),
> +				   2);
> +		spin_unlock_bh(&xchan->tx_lock);
> +		if (net_ratelimit())
> +			netdev_warn(ndev, "TSN TX ring full\n");
> +
> +		return NETDEV_TX_BUSY;
> +	}
> +
> +	skbuf_dma =3D ep_get_desc(xchan, xchan->ring_head & (xchan->ring_size -=
 1));
> +	if (!skbuf_dma) {
> +		spin_unlock_bh(&xchan->tx_lock);
> +		goto err_drop_skb;
> +	}
> +	spin_unlock_bh(&xchan->tx_lock);
> +
> +	sg_init_table(skbuf_dma->sgl, sg_len);
> +	ret =3D skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
> +	if (ret < 0)
> +		goto err_drop_skb;
> +	sg_len =3D ret;
> +
> +	nents =3D dma_map_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEV=
ICE);
> +	if (!nents)
> +		goto err_drop_skb;
> +
> +	dma_tx_desc =3D dmaengine_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
> +					      nents, DMA_MEM_TO_DEV,
> +					      DMA_PREP_INTERRUPT);
> +	if (!dma_tx_desc)
> +		goto err_unmap_sg;

[Severity: Medium]
Can dmaengine_prep_slave_sg() exhaust the MCDMA channel's segment pool and
drop frames while the software ring still has space?

The driver advertises NETIF_F_SG and allows up to MAX_SKB_FRAGS + 1 (18)
scatterlist entries per frame, while queue flow control only checks
CIRC_SPACE() on the 64-frame software ring (up to 62 frames in flight).
In drivers/dma/xilinx/xilinx_dma.c, each MCDMA channel has a pool of
XILINX_DMA_NUM_DESCS (512) segments in chan->free_seg_list.  When
multi-fragment frames in flight consume all 512 segments before 62 frames
are queued, dmaengine_prep_slave_sg() returns NULL and ep_start_xmit()
drops the packet instead of stopping the TX queue.

[ ... ]

> @@ -343,10 +491,16 @@ static int ep_open(struct net_device *ndev)
>  static int ep_stop(struct net_device *ndev)
>  {
>  	struct xlnx_tsn_ep *ep =3D netdev_priv(ndev);
> +	unsigned int i;
> =20
> -	netif_tx_disable(ndev);
>  	WRITE_ONCE(ep->closing, true);
> +	for (i =3D 0; i < ep->num_tx_queues; i++)
> +		dmaengine_terminate_sync(ep->tx_chans[i]->chan);
> +
> +	netif_tx_disable(ndev);
>  	ep_exit_dmaengine(ep);
> +	for (i =3D 0; i < ndev->num_tx_queues; i++)
> +		netdev_tx_reset_subqueue(ndev, i);
> =20
>  	return 0;
>  }

[Severity: High]
Can ep_start_xmit() race with dmaengine_terminate_sync() when ep_stop()
terminates the TX channels before calling netif_tx_disable()?

Until netif_tx_disable() acquires HARD_TX_LOCK and sets
__QUEUE_STATE_DRV_XOFF, transmit paths that bypass qdisc deactivation
(such as AF_PACKET with PACKET_QDISC_BYPASS via __dev_direct_xmit(), or a
queue using noqueue) can still enter ep_start_xmit(), which does not check
ep->closing:

CPU0                              CPU1
ep_stop()                         __dev_direct_xmit()
  WRITE_ONCE(ep->closing, true)     ep_start_xmit()
  dmaengine_terminate_sync()
    xilinx_dma_terminate_all()
      xilinx_dma_chan_reset()
      chan->terminating =3D true
      xilinx_dma_free_descriptors()
                                      dmaengine_prep_slave_sg()
                                      dmaengine_submit()
                                        xilinx_dma_tx_submit()
                                          chan->terminating =3D false
                                      WRITE_ONCE(xchan->ring_head, ...)
                                      dma_async_issue_pending()
  netif_tx_disable()

Calling dma_async_issue_pending() concurrently with
dmaengine_terminate_sync() violates the dmaengine_synchronize() API
contract and races with the unlocked channel reset and descriptor freeing
in xilinx_dma_terminate_all().  In addition, because
xilinx_dma_terminate_all() discards earlier in-flight descriptors without
running ep_dma_tx_cb(), their SKBs remain at xchan->ring_tail; if the
newly issued transfer completes before ep_exit_dmaengine() frees the
channel, ep_dma_tx_cb() pops the stale slot at ring_tail, unmapping and
freeing the wrong skb and passing its length to
__netif_txq_completed_wake().

Calling netif_tx_disable(ndev) after WRITE_ONCE(ep->closing, true) and
before the dmaengine_terminate_sync() loop would serialize against
ep_start_xmit() while still preventing any concurrent ep_dma_tx_cb() from
waking a stopped queue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-patches_v2=
_external-v4-0-56bb26f042a4@amd.com?part=3D7
