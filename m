Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794921288;
	b=z1HJO6ImMrkaNN8Brj/TCYy+x4mqDkJc6j87661IWL6kV0RLVRAA1xyyFITZ51LjCeLs
	 H7jw1Y1MSqdJuXeHVX60+pd0fEzFMUf6KuqpO2YBYhg9Gu7iywudhT+I4GXSD1z6Y2o+U
	 AaseROwqMhAyL67+eCqLcN9Gfd9JKnTmQQLw+mNDqPiery8QL8B/xbxjHlXo7aLXkNjGH
	 bjuMbdocNZhz9O1izXkAgjCaYy4Ib0MzTBk7yHjt2tkwqnv5YTK82Q0N9e7Rw6g/0yNfE
	 8t7aBZD8jhfExbi0g2umw5XPjNSr0IFn0AIdsOXQ343NB97++BsczbXF7yfB6g2bPgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794921288;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VxC0DozNreNxgG26Yk5DzFkJ77rWztZR0nbiAbWO7/Y=;
	b=BJGcPcw5qRGhpOVFxTqCNvBvw1TKcUTdwFK6i3ig2dUUAdFFHSy3+fmdb0ypxveypgr1
	 FfRU5lq6meP3KjkYuHk8GSyQU9TZ4Aw9q2WEuzz6/VTOQFvNia1ucGYbpGo8IAHDQG5Dj
	 9f5e3cYS4jb46WLYtRUN6zJEfpJ03kfMPpcT82iuhNyieR4fBFgs69rr3Gk/aqQs1SpoY
	 eP0/JhlUcNXbMaDVZJnUWwrCzrZew6B0xPNmb/KGkjWkpiYpCB+s4NXk0Kv7I9PFXSrQQ
	 7HviwfPH9pndot/mmCOqszlt4XyqplZ0MhTmJyEgHNoQ9BdnUbo/B6YL5zWrNU0W2kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jA1WaEyL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D7606A883;
	Tue, 17 Nov 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jA1WaEyL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FA91F000C8;
	Tue, 17 Nov 2026 13:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794921288;
	bh=VxC0DozNreNxgG26Yk5DzFkJ77rWztZR0nbiAbWO7/Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jA1WaEyLYlV3n0eHvN36mhUjJsdUalbd8O9XLwAWsAot3vbI79qy33NTi9rBKjFY/
	 SVvXWp4SXNnc10/qnITDr4VSzzIIKEK6AGYfawnX4L3K7SJ/uIIADrOYejXCg4ttOv
	 owaOgKtxApCZoLzSSjTVA213sbRMQrkBS658DPqPvZ8/6KIEd6cZVNDxsU//sKwv00
	 3FnnAPuNXSOxq3PaAyVJi9gLJWAoz5rQw1kj9RxOfw5IJh9zVkBqX8H2u1YTKKf/UK
	 EtBsr18CNdzrQfK8vD5mP4gLyWzZgbfaodF+pRpx4zfJkUwr9ZdJSkSgB5TKOf0dNS
	 lxrCKkKn7q8gA==
Subject:
 Re: [PATCH net-next v4 6/8] net: xilinx: tsn: add the endpoint RX data path
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, git@amd.com, neelisrinivas18@gmail.com
Date: Tue, 17 Nov 2026 13:14:46 +0000
Message-ID: <179492128674.3136.6421836248333363912@kernel.org>
In-Reply-To: <20261113-patches_v2_external-v4-6-56bb26f042a4@amd.com>
References: <20261113-patches_v2_external-v4-6-56bb26f042a4@amd.com>
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

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c,
  ep_dma_rx_cb() gets the MCDMA S2MM metadata block (metadata[0] = S2MM…
- [Medium] net: xilinx: tsn: RX stall from MCDMA IRQ coalescing in
  ep_rx_refill()
- [Low] The RX path needs the dmaengine provider to support
  DESC_METADATA_ENGINE, and nothing checks for it.
- [Low] The commit message says that refilling from the completion
  callback "keeps the ring full without a separate refill worker".

--

net: xilinx: tsn: add the endpoint RX data path

This commit adds the RX data path for the Xilinx TSN endpoint driver. RX
buffers are posted to every MCDMA RX channel on open and reaped from the
dmaengine completion callback, which passes MAC1/MAC2 frames up the stack
with __netif_rx() and refills the ring. A per-channel lock and a closing
flag keep the refill from racing with teardown.

> Refill each slot from the completion callback unless the interface is
> closing, which keeps the ring full without a separate refill worker.

[Severity: Low]
Is this description accurate? The patch also adds rx_refill_timer.
ep_rx_refill() arms it with mod_timer() when a refill leaves the ring
empty. ep_rx_refill_timer() then submits descriptors from timer softirq
context.

The commit body never introduces the timer or says when it is armed. The
teardown paragraph mentions "the timer" as if it had already been
described.

The timer is only explained in the v2 changelog below the '---', which is
dropped when the patch is applied. Could the commit message describe the
timer-based retry after an allocation failure?

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 52d2da04a5d88..f179062c7d148 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -113,6 +136,181 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)

[ ... ]

> +static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
> +{

[ ... ]

> +	/* MCDMA metadata: [0] = status, [1] = sideband (TID/TDEST/TUSER), [2..] = app */
> +	tuser = metadata[1] & TSN_TUSER_MASK;
> +	rx_len = ep->max_frm_size - result->residue;

[Severity: Medium]
Should metadata[0] be checked here too? The comment says it holds the S2MM
BD status. Only the sideband word in metadata[1] is read, so the
RXSOF/RXEOF bits are never checked.

ep_rx_submit_desc() posts each RX slot as a single buffer of
ep->max_frm_size (TSN_MAX_VLAN_FRAME_SIZE, 1522) bytes:

    sg_dma_len(skbuf_dma->sgl) = ep->max_frm_size;

If a frame longer than that reaches the S2MM channel, the MCDMA continues
it into the next BD. That BD completes as a separate dmaengine descriptor.

On the provider side, xilinx_dma_complete_descriptor() only tests the
Cmplt bit and copies the channel-wide chan->err into desc->err. So
result->result is DMA_TRANS_NOERROR for both parts. That gives two cases:

  - The head BD has residue 0, so rx_len is 1522. It passes the length
    check and goes up the stack truncated.
  - The tail BD starts mid-payload. If rx_len >= ETH_HLEN and its sideband
    carries port_id 1 or 2, eth_type_trans() reads sender-controlled
    payload bytes as the MAC header, and then __netif_rx() delivers it.

Could a remote sender use this to inject an L2 frame built from the payload
of an oversized outer frame? That frame would be credited to the port_id
of a BD that is not the start of the packet.

The driver has no ndo_change_mtu, and nothing in the tree sets the
MAC/switch maximum frame size. So what stops a frame over 1522 bytes (QinQ,
or an 802.1CB R-TAG plus VLAN) from reaching the DMA? This depends on
hardware behaviour that can't be confirmed from the tree.

The commit message also says:

    Drop and count frames with bad descriptor status, an invalid length or
    no metadata pointer.

However, the only status check is result->result. That is the channel-level
error, not the per-BD status word.

The later patch "net: xilinx: tsn: deliver endpoint RX frames to DSA user
ports" uses this same port_id to pick the DSA user port. So the issue is
still there at the end of the series.

[ ... ]

> @@ -306,9 +524,19 @@ static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
>  		rx_allocated++;
>  	}
>  
> +	for (i = 0; i < ep->num_rx_queues; i++) {
> +		if (!ep_rx_refill(ep->rx_chans[i], false)) {
> +			dev_err(ep->dev, "RX channel %d: no descriptors armed\n",
> +				i);
> +			ret = -ENOMEM;
> +			goto err_free_chans;
> +		}
> +	}
> +
>  	return 0;

[Severity: Low]
Should ep_init_dmaengine() check that the RX channels support
DESC_METADATA_ENGINE before arming them?

xilinx_dma_probe() only sets DESC_METADATA_ENGINE when the DMA node has the
optional xlnx,axistream-connected property:

    if (xdev->has_axistream_connected)
        xdev->common.desc_metadata_modes = DESC_METADATA_ENGINE;

Without that property, desc_check_and_set_metadata_mode() returns
-ENOTSUPP. Then dmaengine_desc_get_metadata_ptr() in ep_dma_rx_cb() fails
for every descriptor, so every frame is dropped and counted in rx_errors.

ep_rx_refill() still returns true in this case, so ndo_open() succeeds.
The only sign of the problem is a rate-limited "Failed to get RX metadata
pointer" warning.

Would it be worth adding a dmaengine_is_metadata_mode_supported() check at
open or probe time? The new xlnx,tsn-endpoint-ethernet-mac.yaml binding
also doesn't say that the MCDMA node needs this property.

[ ... ]

> @@ -113,6 +136,181 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)
>  	return xchan->skb_ring[idx];
>  }
>  
> +static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result);
> +
> +static int ep_rx_submit_desc(struct xlnx_tsn_ep_dma_chan *xchan)
> +{
> +	struct dma_async_tx_descriptor *dma_rx_desc;
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	struct xlnx_tsn_ep *ep = xchan->ep;
> +	struct sk_buff *skb;
> +	dma_cookie_t cookie;
> +	dma_addr_t addr;
> +
> +	skbuf_dma = ep_get_desc(xchan, xchan->ring_head & (xchan->ring_size - 1));
> +	if (!skbuf_dma)
> +		return -ENOSPC;
> +
> +	skb = dev_alloc_skb(ep->max_frm_size);
> +	if (!skb)
> +		return -ENOMEM;
> +
> +	sg_init_table(skbuf_dma->sgl, 1);
> +	addr = dma_map_single(xchan->dma_dev, skb->data, ep->max_frm_size,
> +			      DMA_FROM_DEVICE);
> +	if (unlikely(dma_mapping_error(xchan->dma_dev, addr))) {
> +		if (net_ratelimit())
> +			dev_warn(ep->dev, "DMA mapping error on RX submit\n");
> +
> +		goto err_free_skb;
> +	}
> +	sg_dma_address(skbuf_dma->sgl) = addr;
> +	sg_dma_len(skbuf_dma->sgl) = ep->max_frm_size;
> +	dma_rx_desc = dmaengine_prep_slave_sg(xchan->chan, skbuf_dma->sgl,
> +					      1, DMA_DEV_TO_MEM,
> +					      DMA_PREP_INTERRUPT);
> +	if (!dma_rx_desc)
> +		goto err_unmap_skb;
> +
> +	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
> +	skbuf_dma->desc = dma_rx_desc;
> +	dma_rx_desc->callback_param = xchan;
> +	dma_rx_desc->callback_result = ep_dma_rx_cb;
> +
> +	skbuf_dma->skb = skb;
> +	cookie = dmaengine_submit(dma_rx_desc);
> +	if (dma_submit_error(cookie)) {
> +		skbuf_dma->skb = NULL;
> +		goto err_unmap_skb;
> +	}
> +	xchan->ring_head++;
> +
> +	return 0;
> +
> +err_unmap_skb:
> +	dma_unmap_single(xchan->dma_dev, addr, ep->max_frm_size, DMA_FROM_DEVICE);
> +err_free_skb:
> +	dev_kfree_skb(skb);
> +	return -ENOMEM;
> +}
> +
> +static bool ep_rx_refill(struct xlnx_tsn_ep_dma_chan *xchan, bool arm_timer)
> +{
> +	int avail, i;
> +
> +	scoped_guard(spinlock_bh, &xchan->rx_lock) {
> +		if (READ_ONCE(xchan->ep->closing))
> +			return false;
> +
> +		avail = CIRC_SPACE(xchan->ring_head, READ_ONCE(xchan->ring_tail),
> +				   xchan->ring_size);
> +		for (i = 0; i < avail; i++) {
> +			if (ep_rx_submit_desc(xchan))
> +				break;
> +		}
> +		dma_async_issue_pending(xchan->chan);
> +
> +		if (i > 0 || xchan->ring_head != READ_ONCE(xchan->ring_tail))
> +			return true;
> +
> +		if (arm_timer)
> +			mod_timer(&xchan->rx_refill_timer,
> +				  jiffies + EP_RX_REFILL_RETRY);
> +	}
> +
> +	return false;
> +}
> +
> +static void ep_rx_refill_timer(struct timer_list *t)
> +{
> +	struct xlnx_tsn_ep_dma_chan *xchan = timer_container_of(xchan, t,
> +							       rx_refill_timer);
> +
> +	ep_rx_refill(xchan, true);
> +}
> +
> +static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
> +{
> +	struct xlnx_tsn_ep_dma_chan *xchan = data;
> +	struct skbuf_dma_descriptor *skbuf_dma;
> +	size_t meta_len, meta_max_len, rx_len;
> +	struct xlnx_tsn_ep *ep = xchan->ep;
> +	struct net_device *ndev = ep->ndev;
> +	struct sk_buff *skb;
> +	u32 port_id, tuser;
> +	u32 *metadata;
> +
> +	skbuf_dma = ep_get_desc(xchan, xchan->ring_tail & (xchan->ring_size - 1));
> +	WRITE_ONCE(xchan->ring_tail, xchan->ring_tail + 1);
> +	skb = skbuf_dma->skb;
> +	skbuf_dma->skb = NULL;
> +
> +	dma_unmap_single(xchan->dma_dev, skbuf_dma->dma_address,
> +			 ep->max_frm_size, DMA_FROM_DEVICE);
> +
> +	if (result->result != DMA_TRANS_NOERROR) {
> +		if (net_ratelimit())
> +			dev_warn(ep->dev, "RX DMA transfer error %d\n",
> +				 result->result);
> +
> +		dev_kfree_skb_any(skb);
> +		DEV_STATS_INC(ndev, rx_dropped);
> +		DEV_STATS_INC(ndev, rx_errors);
> +		goto submit_new;
> +	}
> +
> +	metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc,
> +						   &meta_len,
> +						   &meta_max_len);
> +	if (IS_ERR_OR_NULL(metadata)) {
> +		if (net_ratelimit())
> +			dev_warn(ep->dev, "Failed to get RX metadata pointer\n");
> +
> +		dev_kfree_skb_any(skb);
> +		DEV_STATS_INC(ndev, rx_dropped);
> +		DEV_STATS_INC(ndev, rx_errors);
> +		goto submit_new;
> +	}
> +
> +	/* MCDMA metadata: [0] = status, [1] = sideband (TID/TDEST/TUSER), [2..] = app */
> +	tuser = metadata[1] & TSN_TUSER_MASK;
> +	rx_len = ep->max_frm_size - result->residue;
> +
> +	if (rx_len > ep->max_frm_size || rx_len < ETH_HLEN) {
> +		if (net_ratelimit())
> +			dev_warn(ep->dev, "Invalid RX length %zu (max=%u, min=%u)\n",
> +				 rx_len, ep->max_frm_size, ETH_HLEN);
> +
> +		dev_kfree_skb_any(skb);
> +		DEV_STATS_INC(ndev, rx_dropped);
> +		DEV_STATS_INC(ndev, rx_errors);
> +		goto submit_new;
> +	}
> +
> +	port_id = FIELD_GET(TSN_TUSER_PORT_ID_MASK, tuser);
> +	if (port_id != TSN_TUSER_PORT_MAC1 && port_id != TSN_TUSER_PORT_MAC2) {
> +		dev_dbg_ratelimited(ep->dev,
> +				    "RX dropping unexpected TUSER port_id=%u\n",
> +				    port_id);
> +
> +		dev_kfree_skb_any(skb);
> +		DEV_STATS_INC(ndev, rx_dropped);
> +		goto submit_new;
> +	}
> +
> +	skb_put(skb, rx_len);
> +	skb->dev = ndev;
> +	skb->protocol = eth_type_trans(skb, ndev);
> +	skb_checksum_none_assert(skb);
> +	__netif_rx(skb);
> +
> +	DEV_STATS_INC(ndev, rx_packets);
> +	DEV_STATS_ADD(ndev, rx_bytes, rx_len);
> +
> +submit_new:
> +	ep_rx_refill(xchan, true);
> +}
> +
>  static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	dev_kfree_skb_any(skb);

[Severity: Medium]
Can this leave received frames stranded when RX traffic is sparse?

ep_rx_refill() queues up to avail descriptors with ep_rx_submit_desc()
and then calls dma_async_issue_pending() once for the whole batch. On
the provider side, xilinx_mcdma_start_transfer() sets the channel IRQ
coalescing threshold in XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest) to
chan->desc_pendingcount whenever that count is at most
XILINX_MCDMA_COALESCE_MAX (24).

A refill that queues between 2 and 24 descriptors therefore sets the
threshold to that batch size. That happens when several RX
completions are reaped before the next refill runs. It also happens
when dev_alloc_skb() or dmaengine_prep_slave_sg() fails partway
through a batch and a later refill tops up the rest.

Batches larger than 24 skip the reprogramming. The initial fill of a
128-entry ring is one example. In that case a threshold left over
from an earlier small batch stays in the control register.

With a threshold of N > 1, the MCDMA only raises the IOC interrupt
after N frames have completed. xilinx_mcdma_irq_handler() only logs
XILINX_MCDMA_IRQ_DELAY_MASK and does not call
xilinx_dma_complete_descriptor(). No delay timeout appears to be
programmed either.

If fewer than N frames arrive, they sit in the RX buffers and
ep_dma_rx_cb() does not run for them until enough further traffic
arrives.

The refill timer does not cover this case. ep_rx_refill() returns
true because descriptors are still outstanding, so rx_refill_timer is
never armed.

Much of the traffic on a TSN endpoint is low rate: ARP, PTP and other
control frames. That can mean unbounded RX latency or a queue that
looks stalled.

Should ep_rx_refill() issue pending after each submitted descriptor?
Or does the fix belong in xilinx_dma, for example by completing
descriptors on the delay interrupt or programming the coalesce delay
timer? This depends on how the MCDMA coalescing behaves, so could you
confirm what the hardware does here?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113-patches_v2_external-v4-0-56bb26f042a4%40amd.com
