Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792497503;
	b=eOP399azSKMNXgcA3FdXiE9jwkdTOgAzmJxfjvvCPCvd3qiYidOw9mZeW0ovedzQH1IF
	 bBf+eAv20oFk7Qo/wlH8AcR2pISMLaNPn21do/sbNdKL/x23/gqP6GSHW0o3wo9jD5mz5
	 142ZA42IXkK2skbts5k5AFn4/8WFbSaScebNXhnqXzC631k5z2dS8heyW4yRzCmobsVzH
	 OuSyR5ErA8Gjzq0/7vfOhy1BaXIG5xJNBR3NWRJhwym/wlfqHZzs7euodQ5JMJhkwSoy3
	 U6YmeVcSjExsYjFmqZhqrXyjafaYeXOrnltjpM+eD/E9vB/ZT1FebqiHBRBv1uG2CeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792497503;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=UqSlIyIk6qjKoWIK+qLBrziazj0CloqHB/lLKRjw9ig=;
	b=axJQOkbLraPPOCgZxTwxz7p+uV4naNIE3xoWguA3bwQsbPzrnuOQqfZIDBSrtxTLo/Xj
	 bEXiT4dhNmI50Wq7UYUIIjBYv0ritRtk9F5zSFZutMnIGaK+2pH6LEtL3e+VteYKg61y9
	 Yxd7bQLVdMHWArlnwj/y7SxAzq2pF73rjfYe0SHZ8ouG+x8meQk6VcM3857nker75Xd5d
	 jSxq4tIr+AlAvrn5mYDqO3Z1ogIwxUoEX6Cx+MKPksypN2xVEhfVvAFLO854CXZRWTRlx
	 uVJvKXcdgzRJkDkU5dg1Irj2bmekKabPC9m4VBErgvRAdwOPxWl/eV3vcf2GigI1s0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9zlO8z7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBACD60A261B;
	Tue, 20 Oct 2026 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9zlO8z7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275351F000C6;
	Tue, 20 Oct 2026 11:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792497502;
	bh=UqSlIyIk6qjKoWIK+qLBrziazj0CloqHB/lLKRjw9ig=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D9zlO8z7idsjIRZ+rqp+QAyWvbo24wC7k/h+1DvX0ht/GH0SgIblUnTGxGZsSobvd
	 zUozG6VKm1WP5YHw/t2JbYz1wjvU1LIpjp88sUScnwhGjFR890q2AFhsmLJJdMfno7
	 caKhVMGGz70IwMZJuxOXpaLHXr4+oIXNMthRbXbtGZak2oYC49GATOVT2JU4DHCcZU
	 esJm6SUJ5ZofQhlVI1tuYirLQds0oKW8quwVskCa24eOxZGGn2g7M6gMg/pKv4/ZgL
	 PZo19PsU9gl4PJUSWLYD5Z+FCOfAcPASvEHGtIm4ctFlw3uEzDKd0d1KUjfZlRoqvb
	 Zgx1LDDPZfd2A==
Subject:
 Re: [PATCH net-next v3 6/8] net: xilinx: tsn: add the endpoint RX data path
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, michal.simek@amd.com,
 bigeasy@linutronix.de, clrkwllms@kernel.org, rostedt@goodmis.org,
 edumazet@kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Tue, 20 Oct 2026 11:58:20 +0000
Message-ID: <179249750068.3135.14908716798460807295@kernel.org>
In-Reply-To: <20261016-patches_v2_external-v3-6-e33d3960ca1e@amd.com>
References: <20261016-patches_v2_external-v3-6-e33d3960ca1e@amd.com>
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

- [Critical] RX buffers are freed and unmapped while the MCDMA engine
  still owns them, so incoming DMA lands in freed memory.
- [High] The RX path cannot deliver any frame on the in-tree Xilinx AXI
  MCDMA provider.
- [Medium] After an MCDMA RX channel error, RX on that queue stops
  permanently while the interface stays up.
- [Medium] A partially armed RX batch can hold received frames for an
  unbounded time under sparse traffic.
- [Low] ep_rx_refill() decides whether 'at least one descriptor is armed'
  by testing ring_head != READ_ONCE(ring_tail) after…

--

net: xilinx: tsn: add the endpoint RX data path

This commit posts RX buffers to every MCDMA RX channel on open. It reaps
them from the dmaengine completion callback and passes MAC1/MAC2 frames up
the stack with __netif_rx(). Refill runs from the completion callback, with
a retry timer for a drained ring and a closing flag plus a per-channel lock
to serialise refill against teardown.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index ab3d6d8cb9440..0a13e04d40575 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -112,6 +135,181 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)

[ ... ]

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

[Severity: Critical]
Can this give RX buffers back to the allocator while the MCDMA engine still
owns them?

On open, this loop posts CIRC_SPACE(0, 0, 128) = 127 descriptors in one
batch. xilinx_mcdma_start_transfer() only reprograms the IRQ coalescing
threshold when the batch is small enough:

drivers/dma/xilinx/xilinx_dma.c:xilinx_mcdma_start_transfer() {
    ...
	if (chan->desc_pendingcount <= XILINX_MCDMA_COALESCE_MAX) {
		reg &= ~XILINX_MCDMA_COALESCE_MASK;
		reg |= chan->desc_pendingcount <<
			XILINX_MCDMA_COALESCE_SHIFT;
	}
    ...
}

XILINX_MCDMA_COALESCE_MAX is 24. With 127 pending, the threshold keeps its
previous or reset value, which is well below 127.

When the first IOC fires, xilinx_mcdma_irq_handler() calls
xilinx_dma_complete_descriptor(). That function only checks per-BD
completion for AXIDMA:

drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_complete_descriptor() {
    ...
	list_for_each_entry_safe(desc, next, &chan->active_list, node) {
		if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
			...
			if (!(seg->hw.status & XILINX_DMA_BD_COMP_MASK) && chan->has_sg)
				break;
		}
		...
		list_add_tail(&desc->node, &chan->done_list);
	}
}

For MCDMA, every active descriptor goes to done_list, and the tasklet runs
ep_dma_rx_cb() for each of them. For every BD the hardware has not filled
yet, ep_dma_rx_cb() unconditionally calls dma_unmap_single() and then frees
the skb.

The S2MM engine's CURDESC..TAILDESC chain still points at those BDs and
buffer addresses. Would the next received frames then be written into
freed skb memory?

The descriptor segments are also recycled, and the next refill rewrites
them while the engine is running. active_list is empty by then, so
xilinx_mcdma_start_transfer() also rewrites CDESC on a channel that already
has RUNSTOP set:

	if (chan->has_sg && list_empty(&chan->active_list))
		xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
			     head_desc->async_tx.phys);

The same thing looks possible in steady state, whenever a small refill
sets the threshold to 1 while other descriptors are still active.

The commit message says dmaengine "delivers one descriptor per callback".
That assumes per-BD completion, and this provider doesn't appear to
provide it for MCDMA.

[Severity: Medium]
Could a partially armed batch hold received frames for an unbounded time
when traffic is sparse?

This loop can post between 2 and 24 descriptors in one call. That happens
if dev_alloc_skb() fails partway through, or if a callback refills several
slots at once. xilinx_mcdma_start_transfer() then sets the coalescing
threshold to that count, and no IOC is raised until that many frames have
arrived.

xilinx_mcdma_irq_handler() only logs the delay interrupt and reaps nothing:

	if (status & XILINX_MCDMA_IRQ_DELAY_MASK) {
		...
		dev_dbg(chan->dev, "Inter-packet latency too long\n");
	}

No delay timer appears to be programmed for MCDMA. ep_rx_refill() returns
true because the ring is non-empty, so the refill timer isn't armed either.

Would low-rate traffic such as ARP, PTP or control frames sit in host
memory until enough further frames arrive, or indefinitely if traffic
stops?

> +
> +		if (xchan->ring_head != READ_ONCE(xchan->ring_tail))
> +			return true;

[Severity: Medium]
What recovers this RX queue after an MCDMA channel error?

On XILINX_MCDMA_IRQ_ERR_MASK, xilinx_mcdma_irq_handler() sets
chan->err = true. An error-only interrupt completes no descriptor, because
completion only happens under XILINX_MCDMA_IRQ_IOC_MASK. So no
ep_dma_rx_cb() runs, and xilinx_mcdma_start_transfer() returns early while
chan->err is set.

The outstanding descriptors keep ring_head != ring_tail here. The refill
timer is never armed and nothing new is submitted. The only automatic
reset is in xilinx_dma_tx_submit():

	if (chan->err) {
		...
		err = xilinx_dma_chan_reset(chan);

That reset needs a new submit, and none ever happens.

Does the queue then stay halted until ifdown/ifup, with the interface up
and no driver-level counter showing the problem?

> +
> +		if (arm_timer)
> +			mod_timer(&xchan->rx_refill_timer,
> +				  jiffies + EP_RX_REFILL_RETRY);
> +	}
> +
> +	return false;
> +}

[ ... ]

> +static void ep_dma_rx_cb(void *data, const struct dmaengine_result *result)
> +{

[ ... ]

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

[Severity: High]
Can any frame reach __netif_rx() with the in-tree MCDMA provider?

For XDMA_TYPE_AXIMCDMA, xilinx_dma_probe() installs
xilinx_mcdma_prep_slave_sg(), and that function never sets
async_tx.metadata_ops. DESC_METADATA_ENGINE is only set when
has_axistream_connected is true, and that flag is only read for AXIDMA:

drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_probe() {
    ...
	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
		xdev->has_axistream_connected =
			of_property_read_bool(node, "xlnx,axistream-connected");
	}
    ...
	if (xdev->has_axistream_connected)
		xdev->common.desc_metadata_modes = DESC_METADATA_ENGINE;
    ...
}

So dmaengine_desc_get_metadata_ptr() looks like it always returns an
ERR_PTR for these descriptors. The error comes either from
desc_check_and_set_metadata_mode() or from the NULL metadata_ops check.

If so, every DMA_TRANS_NOERROR completion is dropped here with "Failed to
get RX metadata pointer". ndo_open still succeeds, so the interface comes
up with RX dead.

Wiring up the existing hook wouldn't fix this on its own.
xilinx_dma_get_metadata_ptr() casts to the AXIDMA segment type and returns
the app words, which start at BD offset 0x20:

	seg = list_first_entry(&desc->segments,
			       struct xilinx_axidma_tx_segment, node);
	return seg->hw.app;

In struct xilinx_aximcdma_desc_hw, status is at 0x18 and sideband_status
(TID/TDEST/TUSER) is at 0x1C. The "[0] = status, [1] = sideband" layout
assumed here doesn't match any get_ptr in the tree. metadata[1] would be
an app word, and the TUSER port_id filter would act on unrelated bits.

metadata[1] is also read without checking meta_len.

No patch in the series touches drivers/dma/. The same code is still there
at the end of the series, in "net: xilinx: tsn: deliver endpoint RX frames
to DSA user ports".

[ ... ]

> @@ -305,9 +523,19 @@ static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
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

[Severity: Low]
Can ep_rx_refill() return false here even though a descriptor was armed?

ep_rx_refill() decides success by testing ring_head !=
READ_ONCE(ring_tail) after dma_async_issue_pending(). ep_dma_rx_cb()
advances ring_tail outside rx_lock, before it calls ep_rx_refill() and
blocks on the lock:

	WRITE_ONCE(xchan->ring_tail, xchan->ring_tail + 1);

The callback runs in the provider tasklet, possibly on another CPU, and
spin_lock_bh() only blocks BH locally.

Suppose only one slot gets armed, because dev_alloc_skb() (GFP_ATOMIC) or
prep fails on the second slot. If that frame completes before the
head/tail test, head == tail and ep_rx_refill() returns false. ndo_open
then fails with -ENOMEM and "no descriptors armed", even though the frame
has already gone up through __netif_rx().

Teardown after that failure looks safe. closing is set before
ep_free_dma_chan() takes the lock and shuts down the timer.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016-patches_v2_external-v3-0-e33d3960ca1e%40amd.com
