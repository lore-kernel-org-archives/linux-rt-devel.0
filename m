Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497504;
	b=JO0SPB4BETk/WyrsAy/0Qe7pCeEBzzCRE7sklGbY+nWI55pGZwDYHkv8xPWD8ZEcV8N9
	 u+lfk1j2M2wT1GSgqvSqR+7HDASpeaqXlzP0m6eo47p+9xvcnO9Mw3oDqSkFc1iIWW0C6
	 Nb6fWw3pNWm4C32hayLsTjyq+VXCcu9G/JM/tiHxE82hiBQBCojdKPZbTe7ixDe7b7T25
	 OHD/K+BgyPU2HurwTjRbeJVcxzhcimZylU+RUpaXO5LHvNA9TsNjo6RU/JPOattTo4cWe
	 hzQfL/yPvKmurH6rDnPzd/OLLlfIMxRT9dCqNYbS1+a9q8+gjcs+r87ZhEF8sgsO9yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497504;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=EmV7H7H9pVXS7kQ92UEMdxebd9ftYBHzKGYKggUyAzI=;
	b=ZauE2pnW7uQO/Yrgt1iyMkeoH0mRjFX7c90ikeG+Kx/rEbIOq8rWO4XYxsfWyD5NCdC7
	 M8KbdKug8kw4l6tPFbICqL6TNoAObzbKQeIxFn5L2AyN/Nhl1mi8u7Yb+LD0G3sraIaII
	 lBNlhuaI61qvVIxPxv+yOxTokyEahb4Tu2Sej4mRPno7J8HThemmFFEwzTuzDqQroez+A
	 3XcOW09t/BmOGUp78uRdka4Zw2opgSdB40Ph5R3ICfe3LiGYkiXQbmDbEZDGe4S+XVYgT
	 YLtkuLhrLccSfBJJfi13xrogaGX1UEhYqlZAmzUrfbMSXjRSg8+WnRzuaOsIgDQsLlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7nMHE6Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F960A2630;
	Tue, 20 Oct 2026 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7nMHE6Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1056B1F000D2;
	Tue, 20 Oct 2026 11:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497504;
	bh=EmV7H7H9pVXS7kQ92UEMdxebd9ftYBHzKGYKggUyAzI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=I7nMHE6YRtj0I6oORMf1USoRJLrgiFpNR2lC3/uRVB0i9OY3pHEyr8ohH4qRV7g/r
	 7OlsEuV7azrJxq8w2dwlioDsN6BlJXDZkKG7fohD8Uw8MiZhjygxfuyNtCpcFCgYk5
	 RGcKsjRbb02q0DQQYLm1g9RhZ/zP6jqRIITCbD1oop0x4rGYvmIZj+SKrw8m72p7ty
	 VHpx5Nyp1xHva8Yt4588CXP56ietpW2OB6RWtu08cv4G8QeATAFWE90bMUZ/C7HRHm
	 QLhQ9IyL4LTjpBPEaw3TOT5FNeSf6/fFaaLXTFG/Q9QKwOXKE31OXlyEZ7gD3miBmj
	 US4cpYNn8giaQ==
Subject:
 Re: [PATCH net-next v3 7/8] net: xilinx: tsn: add the endpoint TX data path
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Tue, 20 Oct 2026 11:58:22 +0000
Message-ID: <179249750260.3135.7334440284014386144@kernel.org>
In-Reply-To: <20261016-patches_v2_external-v3-7-e33d3960ca1e@amd.com>
References: <20261016-patches_v2_external-v3-7-e33d3960ca1e@amd.com>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 2 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Use-after-free in ep_start_xmit()
  (drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c).
- [High] Shutdown race: the closing flag does not stop a TX completion
  that is already running from waking a queue after ep_stop() has called…
- [Medium] The TX path cannot recover from an MCDMA channel error.
- [Medium] TX flow control counts frames, but the DMA engine runs out of
  segments.
- [Low] The patch now produces software TX timestamps (skb_tx_timestamp()
  in ep_start_xmit), but ep_ethtool_ops (line 515) only has .get_drvinfo…

--

net: xilinx: tsn: add the endpoint TX data path

This adds the transmit path to the Xilinx TSN endpoint driver. Each frame
is mapped into a scatterlist and submitted to the DMA channel in
tx_chans[] for the frame's logical queue. The queue is stopped when the
ring fills and woken from the DMA completion callback.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 0a13e04d40575..bd8cd504cefb4 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -310,8 +314,150 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  	ep_rx_refill(xchan, true);
>  }
>  
> +static void ep_dma_tx_cb(void *data, const struct dmaengine_result *result)
> +{

[ ... ]

> +	ndev = skb->dev;
> +	txq = netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
> +	len = skb->len;
> +
> +	if (unlikely(result->result != DMA_TRANS_NOERROR)) {
> +		DEV_STATS_INC(ndev, tx_errors);
> +		dev_kfree_skb_any(skb);

[Severity: Medium]
How does the TX path recover if the MCDMA channel reports an error?

In drivers/dma/xilinx/xilinx_dma.c, xilinx_mcdma_irq_handler() sets
chan->err on an error. After that, xilinx_mcdma_start_transfer() stops
handing BDs to the hardware:

xilinx_mcdma_start_transfer() {
    ...
	if (chan->err)
		return;
    ...
}

The flag is only cleared by xilinx_dma_chan_reset(). That runs from
xilinx_dma_tx_submit() on the next submit, or from terminate.

Suppose the error arrives while the TX queue is stopped, either by
netif_txq_maybe_stop() or by BQL through netdev_tx_sent_queue(). Then
ep_start_xmit() is never called again. No reset happens, ring_tail never
advances and __netif_txq_completed_wake() never runs. The queue stays
stopped until ifdown/ifup.

ep_netdev_ops has no .ndo_tx_timeout either. So the watchdog never
terminates the channel or resets ring_head/ring_tail and the BQL state.

A related point: xilinx_dma_complete_descriptor() checks per-BD
completion only for XDMA_TYPE_AXIDMA. Can descriptors abandoned across a
submit-triggered reset later complete here as DMA_TRANS_NOERROR and be
counted as tx_packets?

This looks unchanged at the end of the series.

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

[Severity: High]
Does the closing flag really prevent a wake after ep_stop() has disabled
the queues?

__netif_txq_completed_wake() checks netif_tx_queue_stopped(txq), then
checks !closing, then calls netif_tx_wake_queue(). None of these steps
is serialised against ep_stop():

CPU A (TX completion)               CPU B (ep_stop)
__netif_txq_completed_wake()
  queue stopped, closing == false
                                    WRITE_ONCE(ep->closing, true);
                                    netif_tx_disable(ndev);
  netif_tx_wake_queue(txq)
                                    ep_exit_dmaengine(ep);
                                      frees TX channels
                                      ep->tx_chans = NULL

netif_tx_disable() takes and drops each txq lock, then returns. It does
not wait for a completion that has already passed the closing check.

The qdisc path is covered by dev_deactivate_many(). generic_xdp_tx() is
not: it only checks netif_xmit_frozen_or_drv_stopped(txq) under
HARD_TX_LOCK.

It can be reached through xdp_do_generic_redirect(). xdp_ok_fwd_dev()
checks only IFF_UP, which is cleared after ndo_stop returns. It can also
be reached through generic XDP_TX on this device's own RX, whose
channels are freed after the TX channels.

Could ep_start_xmit() then dereference a NULL ep->tx_chans or a freed
xchan on the re-woken queue?

The v3 changelog says the patch will "Skip the queue wake in the
completion callback while closing". A lockless flag test doesn't seem
to give that guarantee. This also looks unchanged at the end of the
series.

> +}
> +
>  static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {

[ ... ]

> +	nents = dma_map_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
> +	if (!nents)
> +		goto err_drop_skb;
> +
> +	dma_tx_desc = dmaengine_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
> +					      nents, DMA_MEM_TO_DEV,
> +					      DMA_PREP_INTERRUPT);
> +	if (!dma_tx_desc)
> +		goto err_unmap_sg;

[Severity: Medium]
Can this path drop frames under load once the DMA segment pool runs out?

With ndev->features = NETIF_F_SG, one skb can need up to
MAX_SKB_FRAGS + 1 scatterlist entries. xilinx_mcdma_prep_slave_sg()
takes at least one segment per entry. The segments come from a fixed
per-channel pool of XILINX_DMA_NUM_DESCS (512):

xilinx_mcdma_prep_slave_sg() {
    ...
			segment = xilinx_aximcdma_alloc_tx_segment(chan);
			if (!segment)
				goto error;
    ...
}

The driver ring holds TX_BD_NUM_DEFAULT (64) frames. The stop/wake
thresholds of 2 count only frame slots.

Suppose in-flight frames average more than 8 segments each, for example
MSG_ZEROCOPY with many small frags. The pool then empties while
CIRC_SPACE() still reports room. prep returns NULL and the frame is
counted as tx_dropped, instead of the queue being stopped.

This looks unchanged at the end of the series.

> +
> +	skbuf_dma->skb = skb;
> +	skbuf_dma->sg_len = sg_len;
> +	dma_tx_desc->callback_param = xchan;
> +	dma_tx_desc->callback_result = ep_dma_tx_cb;
> +
> +	spin_lock_bh(&xchan->tx_lock);
> +	cookie = dmaengine_submit(dma_tx_desc);
> +	if (dma_submit_error(cookie)) {
> +		spin_unlock_bh(&xchan->tx_lock);
> +		skbuf_dma->skb = NULL;
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
> +	dma_async_issue_pending(xchan->chan);

[Severity: Critical]
Can the skb already be freed when skb_tx_timestamp() runs here?

Once dmaengine_submit() has returned and tx_lock is dropped,
ep_dma_tx_cb() can take skbuf_dma->skb and free it with
dev_kfree_skb_any() or dev_consume_skb_any().

This ordering seems to assume the transfer can't start before
dma_async_issue_pending(). However, the Xilinx MCDMA provider starts
pending descriptors from its IRQ handler when an earlier transfer
finishes:

xilinx_mcdma_irq_handler() {
    ...
		if (list_empty(&chan->active_list)) {
			chan->idle = true;
			chan->start_transfer(chan);
		}
    ...
}

xilinx_mcdma_start_transfer() then moves the whole pending list onto the
hardware:

	list_splice_tail_init(&chan->pending_list, &chan->active_list);

So with an earlier frame in flight on the same channel:

CPU A (ep_start_xmit)               CPU B
dmaengine_submit(frame B)
spin_unlock_bh(&xchan->tx_lock)
  <delayed by irq/preemption>
                                    IRQ for earlier frame
                                      start_transfer() starts frame B
                                    frame B completes
                                    ep_dma_tx_cb() frees frame B
skb_tx_timestamp(frame B)

skb_tx_timestamp() reads skb->sk, skb->dev and skb_shinfo()->tx_flags.
With SOF_TIMESTAMPING_TX_SOFTWARE or a PHY timestamper, it also clones
the skb or queues it to the socket error queue.

The skb_tx_timestamp() kernel-doc says it must be called "before TX
completion of this packet can trigger. Otherwise the packet could
potentially already be freed." The v3 note says the call was placed "at
the hardware handoff", but here it runs after the handoff.

Would moving skb_tx_timestamp() before dmaengine_submit() avoid this?
The later patches in the series don't touch the TX path, so this is
still present at the end of the series.

[Severity: Low]
The driver now generates software TX timestamps. Should ep_ethtool_ops
also get a .get_ts_info, such as ethtool_op_get_ts_info()?

ep_ethtool_ops only has .get_drvinfo. The default in
__ethtool_get_ts_info() reports only SOF_TIMESTAMPING_RX_SOFTWARE |
SOF_TIMESTAMPING_SOFTWARE. ethtool_op_get_ts_info() is what adds
SOF_TIMESTAMPING_TX_SOFTWARE.

As a result, ethtool -T won't list software-transmit for this device.
Tools such as linuxptp, which check TSINFO first, will treat it as
unsupported.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-patches_v2_external-v3-0-e33d3960ca1e%40amd.com
