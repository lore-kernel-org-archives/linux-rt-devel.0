Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BCB4915A3;
	Sat, 12 Sep 2026 20:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789245380; cv=none; b=H5mSUqzRVqy7r+Q3H2udkWTLtP39qE7lb28Us9iKzOR7DEffC5z0OOCYDKHG7o91ZemdvTeudka5qJRYz+XQP8xjQilOgszH/opqQylNmMyjVoDBkeQfeD0UMEEPc0+ItFYf9JOhLGCeI/8BOoXocIU0l1UDi+lfobeE3BLGF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789245380; c=relaxed/simple;
	bh=JGO46ehF7sqpS68qgd3kWtQ2MFRU857dNSVRKGzhV00=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XHlBOGfgRf0VjTTrFtQ6CP34SiuExFb92t3cFCaNZCPalKBaXB+gUuA1Sy2FxvywF3DcnwdDMeJ92AVdJvENjMoQL7zfgFE4nEX0cPQQF2q9eWWQrzZfUhgKpa3uE+ifv8OfZrh5MIfKBhhxL2lL8ro7FTqxQX3yt9bfNcY4enQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMQ57srT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMQ57srT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5BF1F00893;
	Sat, 12 Sep 2026 20:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789245375;
	bh=7ogonOqpgyEB6kgacfYKnKkNjbUMkziLQ4rxvlKSZwU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lMQ57srTtrpfqW2athOWSwRqqV47rFYG822cWJq5wYyeRwRx0J4hgMSftYISiIsNK
	 qe6kUjghyHMKC5tXXRogV7z033J1WCtZ74B8hK8N89MYm+qF1GPzmLetyuNoJBopzq
	 fCOeG5w0i2FnZ2hyIZKIt/elOTDLx4jUcW+4uqeigo7wT/AO1KZ4d/nc+0Jq6wJIl+
	 oUFE4wMmCW3twzlTxK9YHFW8ZmFeFq1DTpyBnYtrzvNXC/TQLSWsVGOujxeIo/Rl9a
	 KsktRcgUQUG75wOdHkQo8TZx7uZ/3izgUL+pmEc0AWCkU78HwYd0IdFH4TJiZdN9w5
	 2OV5SuVCna13g==
Subject:
 Re: [PATCH net-next v2 6/8] net: xilinx: tsn: add the endpoint RX data path
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
 michal.simek@amd.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Sat, 12 Sep 2026 20:36:14 +0000
Message-ID: <178924537407.3125.1382925704702790504@kernel.org>
In-Reply-To: <20260909-patches_v2_external-v2-6-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-6-3a40babaff4c@amd.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 3 · Low: 0

- [High] The new RX path cannot deliver a single frame on the hardware it
  targets.
- [High] ep_rx_submit_desc()
  (drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c:169-178) records the…
- [Medium] ep_dma_rx_cb() documents and indexes the dmaengine metadata
  window as "[0] = status, [1] = sideband (TID/TDEST/TUSER), [2..] =…
- [Medium] ep_rx_refill() holds the per-channel spinlock with softirqs
  disabled (guard(spinlock_bh)(&xchan->rx_lock), line 191) across a loop…
- [Medium] The commit message states "ndo_stop() sets a closing flag
  under the same per-channel lock the refill takes", but ep_stop() (line…

--

net: xilinx: tsn: add the endpoint RX data path

This adds the RX side of the Xilinx TSN endpoint: RX buffers are posted to
every RX channel at ndo_open and reaped from the dmaengine completion
callback, which decodes a TUSER port_id out of the descriptor metadata and
passes MAC1/MAC2 frames up with __netif_rx(). A per-channel rx_lock plus a
refill timer are added to serialise refill against teardown.

[Severity: Medium]
The commit message says:

  "Serialise the RX refill against teardown. The completion callback re-arms
   the ring, so ndo_stop() sets a closing flag under the same per-channel
   lock the refill takes, and ep_free_dma_chan() takes that lock as a barrier
   before it terminates the channel."

Is the "under the same per-channel lock" part accurate?  ep_stop() looks
like this:

	netif_tx_disable(ndev);
	WRITE_ONCE(ep->closing, true);
	ep_exit_dmaengine(ep);

The store is not done under any rx_lock; the per-channel lock only shows up
later in ep_free_dma_chan() as a bare lock/unlock barrier, after the flag
has already been published.  Since this claim is the stated reason a single
dmaengine_terminate_sync() suffices, could the wording be adjusted to
describe what the code actually does?

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 23a15df71baa..9ed1170794e0 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c

[ ... ]

> @@ -41,6 +43,19 @@
>  #define TX_BD_NUM_DEFAULT		64
>  #define RX_BD_NUM_DEFAULT		128
>  
> +#define EP_RX_REFILL_RETRY		msecs_to_jiffies(10)
> +
> +/*
> + * The DMA descriptor sideband status word packs TID/TDEST/TUSER together;
> + * TUSER occupies the low byte, TID/TDEST sit in the upper bits.
> + */
> +#define TSN_TUSER_MASK			GENMASK(7, 0)
> +/* TUSER Input Port ID field (bits [5:4] of the TUSER field) */
> +#define TSN_TUSER_PORT_ID_MASK		GENMASK(5, 4)
> +#define TSN_TUSER_PORT_EP		0x0
> +#define TSN_TUSER_PORT_MAC1		0x1
> +#define TSN_TUSER_PORT_MAC2		0x2
> +

[ ... ]

> @@ -113,6 +132,174 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)

[ ... ]

> +	skbuf_dma->skb = skb;
> +	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
> +	skbuf_dma->desc = dma_rx_desc;
> +	dma_rx_desc->callback_param = xchan;
> +	dma_rx_desc->callback_result = ep_dma_rx_cb;
> +	xchan->ring_head++;
> +	dmaengine_submit(dma_rx_desc);
> +
> +	return 0;

[Severity: High]
Should ep_rx_submit_desc() check the cookie returned by dmaengine_submit()?
ring_head is advanced and the slot is marked armed before the submit, and
the return value is discarded, so 0 is returned even when the descriptor was
never queued.  The provider can fail:

drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_tx_submit() {
	...
	if (chan->err) {
		err = xilinx_dma_chan_reset(chan);
		if (err < 0)
			return err;
	}
	...
}

If that happens, three things seem to follow.

The skb and its DMA_FROM_DEVICE mapping stay pinned in the slot with no
completion ever arriving for it.

ep_dma_rx_cb() consumes slots strictly in ring_tail order with no
correlation to the completing descriptor:

	skbuf_dma = ep_get_desc(xchan, xchan->ring_tail & (xchan->ring_size - 1));
	WRITE_ONCE(xchan->ring_tail, xchan->ring_tail + 1);

so every later completion is attributed to the wrong slot.  Can this hand a
buffer the engine never wrote, i.e. freshly allocated dev_alloc_skb() memory
with another descriptor's length applied by skb_put(), to __netif_rx()?

And since ep_rx_refill() judges success only by ring_head != ring_tail, the
falsely advanced head makes refill report success, no retry timer is armed,
and the new ep_init_dmaengine() arming check passes with nothing queued.

The TX path in this series does check dma_submit_error() and rolls the slot
back; would the same handling fit here?

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
> +	guard(spinlock_bh)(&xchan->rx_lock);
> +
> +	if (READ_ONCE(xchan->ep->closing))
> +		return false;
> +
> +	avail = CIRC_SPACE(xchan->ring_head, READ_ONCE(xchan->ring_tail),
> +			   xchan->ring_size);
> +	for (i = 0; i < avail; i++) {
> +		if (ep_rx_submit_desc(xchan))
> +			break;
> +	}
> +	dma_async_issue_pending(xchan->chan);

[Severity: Medium]
Does rx_lock need to cover the whole submit loop?  The guard is taken at
function scope, so with an empty ring avail is ring_size - 1 (127 with
RX_BD_NUM_DEFAULT), and each iteration of ep_rx_submit_desc() does
dev_alloc_skb(), dma_map_single(), dmaengine_prep_slave_sg() and
dmaengine_submit() with softirqs disabled.

Two consequences worth considering.  On the ndo_open path
(ep_init_dmaengine -> ep_rx_refill(chan, false)) this is sleepable process
context, yet every allocation is forced into the GFP_ATOMIC reserve and can
fail ndo_open with -ENOMEM.  A concurrent RX completion on another CPU spins
on rx_lock for the whole burst.

Would moving the skb allocation and mapping outside rx_lock, or dropping and
retaking it per descriptor, work here?

> +
> +	if (xchan->ring_head != READ_ONCE(xchan->ring_tail))
> +		return true;
> +
> +	if (arm_timer)
> +		mod_timer(&xchan->rx_refill_timer, jiffies + EP_RX_REFILL_RETRY);
> +
> +	return false;
> +}

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

[Severity: High]
Can this drop every received frame on the AXI MCDMA channels the endpoint
binding uses?  dmaengine_desc_get_metadata_ptr() goes through:

drivers/dma/dmaengine.c:
	ret = desc_check_and_set_metadata_mode(desc, DESC_METADATA_ENGINE);
	if (ret)
		return ERR_PTR(ret);

and xilinx_dma.c only advertises DESC_METADATA_ENGINE for
XDMA_TYPE_AXIDMA:

drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_probe() {
	...
	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA)
		xdev->has_axistream_connected =
			of_property_read_bool(node, "xlnx,axistream-connected");
	...
	if (xdev->has_axistream_connected)
		xdev->common.desc_metadata_modes = DESC_METADATA_ENGINE;
	...
}

xilinx_mcdma_prep_slave_sg() also never assigns
desc->async_tx.metadata_ops, unlike the two AXIDMA prep paths.  With
desc_metadata_modes unset, desc_check_and_set_metadata_mode() returns
-ENOTSUPP for every MCDMA completion, so IS_ERR_OR_NULL(metadata) is taken
and the skb is freed with rx_dropped/rx_errors incremented, making the
port_id filtering and __netif_rx() below unreachable.

Would a one-time capability check at open (for example
dmaengine_is_metadata_mode_supported()) be better than a ratelimited
per-packet warning here, and does the MCDMA side need metadata support added
first?

> +
> +	/* MCDMA metadata: [0] = status, [1] = sideband (TID/TDEST/TUSER), [2..] = app */
> +	tuser = metadata[1] & TSN_TUSER_MASK;
> +	rx_len = ep->max_frm_size - result->residue;

[Severity: Medium]
Is metadata[1] really the sideband word?  The in-tree provider hands out the
APP window, not the status word:

drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_get_metadata_ptr() {
	*max_len = *payload_len = sizeof(u32) * XILINX_DMA_NUM_APP_WORDS;
	seg = list_first_entry(&desc->segments,
			       struct xilinx_axidma_tx_segment, node);
	return seg->hw.app;
}

and in the MCDMA hardware descriptor the status and sideband words sit
before app[]:

struct xilinx_aximcdma_desc_hw {
	...
	u32 control;		/* @0x14 */
	u32 status;		/* @0x18 */
	u32 sideband_status;	/* @0x1C */
	u32 app[XILINX_DMA_NUM_APP_WORDS]; /* @0x20 */
};

So metadata[0] is APP0 and metadata[1] is APP1, which would make the decoded
port_id below unrelated to TUSER: a zero APP1 gives port_id 0
(TSN_TUSER_PORT_EP) and every frame is dropped as an unexpected port_id,
while non-zero garbage can accept a frame and later select the wrong
ep->port_md[port_id] for DSA delivery.  The peer consumer of this same ABI,
axienet_dma_rx_cb(), indexes app_metadata[XILINX_DMA_NUM_APP_WORDS - 1],
which matches the APP-window interpretation.

Also, meta_len and meta_max_len are fetched and then never used.  Should
this check meta_len >= 2 * sizeof(u32) before dereferencing metadata[1]?

> +
> +	if (rx_len > ep->max_frm_size || rx_len < ETH_HLEN) {

[ ... ]

> +	port_id = FIELD_GET(TSN_TUSER_PORT_ID_MASK, tuser);
> +	if (port_id != TSN_TUSER_PORT_MAC1 && port_id != TSN_TUSER_PORT_MAC2) {
> +		if (net_ratelimit())
> +			dev_dbg(ep->dev, "RX dropping unexpected TUSER port_id=%u\n",
> +				port_id);
> +
> +		dev_kfree_skb_any(skb);
> +		DEV_STATS_INC(ndev, rx_dropped);
> +		goto submit_new;
> +	}

[ ... ]

> @@ -322,9 +526,19 @@ static int ep_init_dmaengine(struct xlnx_tsn_ep *ep)
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

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-patches_v2_external-v2-0-3a40babaff4c%40amd.com
