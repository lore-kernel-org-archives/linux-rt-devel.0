Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFD2493D51;
	Sat, 12 Sep 2026 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789245382; cv=none; b=Y3uXVYQ0K7R3XV9YqWY5xL1+aTkNgmHAaO36nIR+Fbhu5hfr3JvFQCG9upGIa9HtNiPAEW16Em3JBLqRnWDuUxyTZy3EYTPydXn4mT9HyvRmfhRSsxCaOvpHc/cRrn4jvo+eiuMrWF0Sk1fD+6kPR9c/A6ysNc3DnTXVdWJOt9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789245382; c=relaxed/simple;
	bh=5Leq0IQtSkoiXxrKaTVuNn2SJ7hx4Bbhak+PCBClPE0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUtQ4YR0k29WKAxquVhrYBChoHSkt0BiK4iwVu/EbkrNZRYBdl2ha0c9u3JBej2TvR4q3MlFNFKk8YGsI9OlWlTINi4QSG/F2iLGi8Liqtpb1UyGvvpyBgONtM8xcCeM7EtWRu24KJKWXQu2Tj8ZcMccuxsYT6eW3Xg6997Mcpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJwgHULw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJwgHULw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460CF1F000FF;
	Sat, 12 Sep 2026 20:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789245377;
	bh=IyW7M+3USsjdPpowUya5Cy2VtNU2n38Iub/uaGPKHuY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XJwgHULwjKXx+hhFNPkqWc9dQT0VWlRCA6OAJrpcnROnMmrazvZR+yHwh8P7OT4Ra
	 p8g/3WW1YgjQTKBT6cUyZJiFjC8Tt6AsV/Rj9hbsA5XVFKD21X6r/8FUZp2BXi4c3H
	 Zx7vTcwUrAi4nojYLL7KqRUJn3T6yTKqQsi9ButQa7HdvQhiWPUe/xKbn2JtacpaMd
	 UXv2+7QlMXmbePNEx+78LcWILMLazPcbKsDqT/bSVYZJ+EoTe6DbmDkc1I3o9WSxQq
	 xtwjqQfRcuzK31Ma/Y+qEMju3W9GpMT400IpUUWP1FdupB4S4ILQ7D3fOwG0yb9goV
	 ZnIn/iCRG58Jg==
Subject:
 Re: [PATCH net-next v2 7/8] net: xilinx: tsn: add the endpoint TX data path
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
 michal.simek@amd.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Sat, 12 Sep 2026 20:36:15 +0000
Message-ID: <178924537585.3125.10131680348285927053@kernel.org>
In-Reply-To: <20260909-patches_v2_external-v2-7-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-7-3a40babaff4c@amd.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 8 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 · Low: 5

- [High] With the AXI MCDMA provider, TX descriptors can be reported
  complete before their hardware transfer has finished, so…
- [Medium] This patch introduces a real TX ring with lockless queue
  stop/wake (netif_txq_maybe_stop()/netif_txq_try_stop() at…
- [Medium] A TX DMA transfer error is turned only into a statistic; there
  is no channel recovery and no way for the driver's ring bookkeeping to…
- [Low] Commit message no longer describes the code.
- [Low] The new transmit path never calls skb_tx_timestamp().
- [Low] ep_dma_tx_cb() violates the BQL completion-reporting contract by
  reporting once per packet.
- [Low] The dma-names schema is under-constrained relative to
  ep_count_dma_queues().
- [Low] The new TX completion callback re-enables the netdev TX queue
  unconditionally: ep_dma_tx_cb() ends in `netif_txq_completed_wake(txq,…

--

net: xilinx: tsn: add the endpoint TX data path

This adds ep_start_xmit() and ep_dma_tx_cb() to the Xilinx TSN endpoint
driver, mapping each skb with dma_map_sg() and submitting it to the
per-queue dmaengine channel. Queue stop/wake is driven from the software
ring indexes with the netif_txq_* helpers, and BQL accounting is added.

No Link: tags in the commit header.

A few questions below.

>     Add the transmit path so the endpoint can send frames.
>     
>     Look up the physical DMA channel for the frame's queue through the map
>     built at probe, map the frame and submit it to that channel. Stop the
>     queue when the ring runs out of space, and wake it from the completion
>     callback once a slot frees up.

[Severity: Low]
Does the commit message still match the code?  The sentence "Look up the
physical DMA channel for the frame's queue through the map built at probe"
describes a runtime lookup, but ep_start_xmit() indexes the channel array
by the logical queue:

	xchan = ep->tx_chans[queue];

and reads ep->tx_dma_chan_map[queue] only as a validity test against
TSN_DMA_CH_INVALID.  The v2 changelog says this lookup was deliberately
removed ("Index tx_chans directly by logical queue in ep_start_xmit() and
drop the phys_chan/dma_dev locals, so the transmit path no longer
re-derives the channel through tx_dma_chan_map"), so the body seems to
have been left at v1.

What actually makes tx_chans[queue] correct is ep_init_dmaengine()
populating the array in logical-queue order:

	snprintf(name, sizeof(name), "tx_chan%u", ep->tx_dma_chan_map[i]);
	ep->tx_chans[i] = ep_alloc_dma_chan(ep, name, true, TX_BD_NUM_DEFAULT);

Could the message be reworded to state that invariant instead?

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 9ed1170794e0..9e9a45169681 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -300,8 +304,147 @@ static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
>  	ep_rx_refill(xchan, true);
>  }
>  
> +static void ep_dma_tx_cb(void *data, const struct dmaengine_result *result)
> +{
> +	struct xlnx_tsn_ep_dma_chan *xchan = data;
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	struct netdev_queue *txq;
> +	struct net_device *ndev;
> +	struct scatterlist *sgl;
> +	struct sk_buff *skb;
> +	int sg_len;
> +	int len;
> +
> +	scoped_guard(spinlock_bh, &xchan->tx_lock) {
> +		skbuf_dma = ep_get_desc(xchan,
> +					xchan->ring_tail & (xchan->ring_size - 1));
> +		if (!skbuf_dma || !skbuf_dma->skb)
> +			return;

[Severity: Medium]
Is there anything that can recover the queue if this early return is
taken?  It leaves the scope before advancing ring_tail and before
netif_txq_completed_wake(), so CIRC_SPACE stays below the start
threshold, the BQL bytes charged by netdev_tx_sent_queue() are never
returned, and the queue stays DRV_XOFF.

ep_netdev_ops registers no .ndo_tx_timeout:

static const struct net_device_ops ep_netdev_ops = {
	.ndo_open		= ep_open,
	.ndo_stop		= ep_stop,
	.ndo_start_xmit		= ep_start_xmit,
	.ndo_validate_addr	= eth_validate_addr,
	.ndo_set_mac_address	= eth_mac_addr,
};

and net/sched/sch_generic.c:netdev_watchdog_up() then never arms the
timer:

void netdev_watchdog_up(struct net_device *dev)
{
	if (!dev->netdev_ops->ndo_tx_timeout)
		return;

so the txq->trans_start bookkeeping that the newly added
netdev_tx_sent_queue() performs has no consumer either.

The same stuck state is reachable from the provider side:
xilinx_mcdma_irq_handler() sets chan->err on an error IRQ and only calls
xilinx_dma_complete_descriptor() when the IOC bit is also set, and
xilinx_mcdma_start_transfer() returns immediately on chan->err, so
descriptors already on active_list never complete and no further
callbacks arrive.

> +
> +		skb = skbuf_dma->skb;
> +		sgl = skbuf_dma->sgl;
> +		sg_len = skbuf_dma->sg_len;
> +
> +		dma_unmap_sg(xchan->dma_dev, sgl, sg_len, DMA_TO_DEVICE);

[Severity: High]
Can this unmap (and the dev_consume_skb_any() below) run while the engine
is still reading the buffer?  With the AXI MCDMA provider each frame is
submitted and issued on its own:

	cookie = dmaengine_submit(dma_tx_desc);
	...
	dma_async_issue_pending(xchan->chan);

and xilinx_mcdma_start_transfer() has no idle guard, unlike
xilinx_dma_start_transfer():

	if (chan->err)
		return;

	if (list_empty(&chan->pending_list))
		return;
	...
	list_splice_tail_init(&chan->pending_list, &chan->active_list);

so a new descriptor is appended and TDESC written while an earlier
transfer is still in flight, with the coalesce threshold programmed from
chan->desc_pendingcount alone.

When the first IOC arrives, xilinx_dma_complete_descriptor() tests the
hardware completion bit only for AXI DMA:

		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
			...
			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
				break;
		}

For XDMA_TYPE_AXIMCDMA every descriptor on active_list is moved to
done_list and dma_cookie_complete()d, and xilinx_dma_chan_desc_cleanup()
then invokes a callback for each.  So ep_dma_tx_cb() would unmap and free
skbs whose descriptors the engine has not finished, which on IOMMU
systems means a translation fault and otherwise means transmitting
whatever now occupies those pages.

This provider behaviour predates the series (the axienet dmaengine client
shares it), but this is the code doing the unmap and free.  Should the
client keep a single transaction outstanding, or is this meant to depend
on a provider-side fix?

> +
> +		skbuf_dma->skb = NULL;
> +		WRITE_ONCE(xchan->ring_tail, xchan->ring_tail + 1);
> +	}
> +
> +	ndev = skb->dev;
> +	txq = netdev_get_tx_queue(ndev, skb_get_queue_mapping(skb));
> +	len = skb->len;
> +
> +	if (unlikely(result->result != DMA_TRANS_NOERROR)) {
> +		DEV_STATS_INC(ndev, tx_errors);
> +	} else {

[Severity: Medium]
Should a TX DMA error do more than bump a counter here?  There is no
channel termination or reset, and no way for ring_head/ring_tail to
resynchronise with the hardware.

On the MCDMA side the error leaves the channel wedged:

xilinx_mcdma_irq_handler() sets chan->err on XILINX_MCDMA_IRQ_ERR_MASK and
only calls xilinx_dma_complete_descriptor() under
XILINX_MCDMA_IRQ_IOC_MASK, and xilinx_mcdma_start_transfer() starts with
if (chan->err) return;

Since ep_start_xmit() derives all of its flow control from the ring
indexes:

	if (CIRC_SPACE(xchan->ring_head, READ_ONCE(xchan->ring_tail),
		       xchan->ring_size) <= 1) {

a channel that stops delivering completions freezes ring_tail, so the ring
looks permanently full, the queue stays DRV_XOFF, the BQL bytes stay
charged and the queued skbs stay dma_map_sg()-mapped until
ep_free_dma_chan() runs from ep_stop().

The driver already has ep_reset_dma_controller() (which programs
struct xilinx_vdma_config cfg = { .reset = 1 }) but only uses it at probe
time.  Would an .ndo_tx_timeout that terminates/resets the channel and
resets the ring indexes cover both this and the missing watchdog above?

> +		DEV_STATS_INC(ndev, tx_packets);
> +		DEV_STATS_ADD(ndev, tx_bytes, len);
> +	}
> +
> +	dev_consume_skb_any(skb);
> +	netif_txq_completed_wake(txq, 1, len,
> +				 CIRC_SPACE(READ_ONCE(xchan->ring_head),
> +					    READ_ONCE(xchan->ring_tail),
> +					    xchan->ring_size), 2);
> +}

[Severity: Low]
This reports one packet per descriptor callback.
netif_txq_completed_wake() reaches netdev_tx_completed_queue(), whose
kernel-doc in include/linux/netdevice.h says:

 *	Must be called at most once per TX completion round (and not per
 *	individual packet), so that BQL can adjust its limits appropriately.

With this provider one hardware completion round yields many callbacks:
xilinx_dma_complete_descriptor() moves every descriptor on
chan->active_list to done_list on a single IOC, and
xilinx_dma_chan_desc_cleanup() then walks the list:

	list_for_each_entry_safe(desc, next, &chan->done_list, node) {
		...
		dmaengine_desc_callback_invoke(&desc->async_tx, &result);

so dql_completed() is called N times with per-packet byte counts instead
of once with the round total.  Could the completions be batched into a
single report?

> +
>  static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {

[ ... ]

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
> +	dma_async_issue_pending(xchan->chan);
> +
> +	return NETDEV_TX_OK;

[Severity: Low]
Is a skb_tx_timestamp(skb) call missing around the hardware handoff here?
Neither ep_start_xmit() nor ep_dma_tx_cb() calls it (there is no
occurrence of skb_tx_timestamp anywhere in the file), so
SOF_TIMESTAMPING_TX_SOFTWARE requests on this netdev never produce a
timestamp.  Documentation/networking/timestamping.rst asks drivers to
generate it as close as possible to the handoff.

> +
> +err_unmap_sg:
> +	dma_unmap_sg(xchan->dma_dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
> +err_drop_skb:
>  	dev_kfree_skb_any(skb);
>  	DEV_STATS_INC(ndev, tx_dropped);
>  	return NETDEV_TX_OK;
> @@ -331,10 +474,13 @@ static int ep_open(struct net_device *ndev)
>  static int ep_stop(struct net_device *ndev)
>  {
>  	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
> +	unsigned int i;
>  
>  	netif_tx_disable(ndev);
>  	WRITE_ONCE(ep->closing, true);
>  	ep_exit_dmaengine(ep);
> +	for (i = 0; i < ndev->num_tx_queues; i++)
> +		netdev_tx_reset_subqueue(ndev, i);
>  
>  	return 0;
>  }

[Severity: Low]
Can a TX completion undo the stop that netif_tx_disable() performs here?
ep_free_dma_chan() calls dmaengine_terminate_sync(), so callbacks can
still run while the channels are being freed, and ep_dma_tx_cb() ends in:

	netif_txq_completed_wake(txq, 1, len, CIRC_SPACE(...), 2);

which expands to __netif_txq_completed_wake() with down_cond == false, so
it cannot tell a stop done by the xmit path from the one done by ndo_stop.
Neither ep_dma_tx_cb() nor ep_start_xmit() consults ep->closing, unlike
the RX path.  The visible effect looks limited to leaving
__QUEUE_STATE_DRV_XOFF cleared after ndo_stop plus one spurious
__netif_schedule() on the already-installed noop_qdisc, since
dev_deactivate_many() runs before ndo_stop and noop_qdisc has
.enqueue = noop_enqueue, so ep_start_xmit() is not reachable at that
point.

Would using __netif_txq_completed_wake() with a READ_ONCE(ep->closing)
down condition, and publishing ep->closing before netif_tx_disable(), be
cleaner?

One more item, on the binding added earlier in the series rather than on
this patch:

[Severity: Low]
The dma-names schema in
Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
is looser than what ep_count_dma_queues() accepts:

      dma-names:
        minItems: 2
        maxItems: 16
        items:
          pattern: "^(tx|rx)_chan[0-7]$"

There is no uniqueItems: true and no contains rule requiring an entry of
each direction, so a list of only tx_chanN names, only rx_chanN names, or
a repeated name validates.  ep_count_dma_queues() rejects all of those:

	if (!tx)
		return dev_err_probe(dev, -EINVAL, "no TX channels in dma-names\n");

	if (!rx)
		return dev_err_probe(dev, -EINVAL, "no RX channels in dma-names\n");

plus the -EINVAL returns on the *tx_present & BIT(idx) and
rx_present & BIT(idx) duplicate checks.  Could the schema gain
uniqueItems and two contains rules so it does not advertise device trees
that cannot probe?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-patches_v2_external-v2-0-3a40babaff4c%40amd.com
