Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4110B49252E;
	Sat, 12 Sep 2026 20:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789245377; cv=none; b=VhpFKuQ1tC3O0ZG10Fvy38JEBPNDCIATCppZ4GYyGgi8BmGul5qmuzB/9BXH94b64xt1mkblPF0vBB7eG/JWom4HNfZMx9tK6+nb1awwFSnxKjZzeIamZVIBui9/qqFt01B13dkM8Td+MZP+MU3wCgod+ZtLqgjw0nO9LJjXMAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789245377; c=relaxed/simple;
	bh=IOIKJrWU/auowQpAOTPolb2KzyY1JaMLMJUaVogPqDI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mxO0C97Gih1GqyMTrG5s+y5WMxrn5QS+hFOBrObxWVzaHMkrJldA8ZzT0fK5/KUAFognIa1plJuhkhvVSIIFoxmvi3kz2JeXkftyPc0MMummcK8aK8j9eR17z9thqImAd9pqmwm2I45BaQqqyojFh8U/W0xAKc+bLu+jVoHCbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElbVwP+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElbVwP+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AE61F00899;
	Sat, 12 Sep 2026 20:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789245373;
	bh=D91XZFSXbMu1GrTrPk6RBOIp6Oley4QTR+Rid8PH2sI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ElbVwP+D/omayUqP5UU1F8RJdElMSd8cJ6iTKjG5wwFHJgK7+bjg8bneJKxb/U7pR
	 6Ede6RkRQRF0NaML4hKKKOc0It00U2TUrasrB0kzGP/aTCPJ9HPCU/Jd8mIC5ltNuT
	 ucyLtTLVD42m/qrni501pA3SaNnrMlqyTpuvxM2OaCIRQUyRhDtJEp6tcd24JUG1nY
	 90fhHnDS/GmLhUpuNhD1ur7fqJqr0MXHhtYXmQn/m1J9lLgCNmBRqGdSiXiG/4TnOK
	 N2qnhaGxN/+pI5VgRY6nZh2QrOgrLRtVg17ZWm1frvoYLjSphJc6Ou+h5YjuiP38p3
	 CVLuOFQccQOhA==
Subject: Re: [PATCH net-next v2 5/8] net: xilinx: tsn: bring up the endpoint
 MCDMA channels
From: netdev-bot+sashiko@kernel.org
To: srinivas.neeli@amd.com
Cc: nagadheeraj.rottela@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, richardcochran@gmail.com,
 michal.simek@amd.com, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rt-devel@lists.linux.dev, neelisrinivas18@gmail.com, git@amd.com
Date: Sat, 12 Sep 2026 20:36:12 +0000
Message-ID: <178924537224.3125.14152311392575331880@kernel.org>
In-Reply-To: <20260909-patches_v2_external-v2-5-3a40babaff4c@amd.com>
References: <20260909-patches_v2_external-v2-5-3a40babaff4c@amd.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 2 (1)

- [High] The stated purpose of the v2 change - "Request a channel at
  probe time so -EPROBE_DEFER stays in the probe path and ndo_open never…
- [Medium] The driver assumes the MCDMA reset and
  dmaengine_terminate_sync() act on a single logical channel, but for…
- [Low] The commit adds infrastructure that has no consumer in this patch
  and that the commit message does not disclose: `ep->closing` is only…
- [Low] ep_reset_dma_controller() hands a channel obtained from the
  generic DT dmaengine API (dma_request_chan(ep->dev, "tx_chanN")) to…

Pre-existing issues:
- [Low] The DT binding and the driver disagree about what a valid EP node
  is, and this patch makes the disagreement load-bearing at run time.

--

net: xilinx: tsn: bring up the endpoint MCDMA channels

This patch requests every TX and RX MCDMA channel named in the device tree
when the interface opens and gives each one a ring of preallocated SKB
descriptor slots.  It also resets the controller at probe time through the
first mapped TX channel and releases the channels again in ndo_stop, plus
adds a XILINX_DMA Kconfig dependency.

No Link: tags in the commit header.

> diff --git a/drivers/net/ethernet/xilinx/tsn/Kconfig b/drivers/net/ethernet/xilinx/tsn/Kconfig
> index b8939d8a92ef..292f17694404 100644
> --- a/drivers/net/ethernet/xilinx/tsn/Kconfig
> +++ b/drivers/net/ethernet/xilinx/tsn/Kconfig
> @@ -6,6 +6,7 @@
>  config XILINX_TSN
>  	tristate "Xilinx TSN Ethernet driver"
>  	depends on OF_ADDRESS
> +	depends on XILINX_DMA
>  	help
>  	  This driver supports the AMD/Xilinx Time-Sensitive Networking
>  	  (TSN) Endpoint Ethernet MAC IP. It provides the wrapper device
> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 24025b1f6e66..23a15df71baa 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> @@ -6,16 +6,24 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/circ_buf.h>
> +#include <linux/dma/xilinx_dma.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmaengine.h>
>  #include <linux/etherdevice.h>
>  #include <linux/ethtool.h>
>  #include <linux/if_ether.h>
>  #include <linux/if_vlan.h>
> +#include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/netdevice.h>
>  #include <linux/of.h>
>  #include <linux/of_net.h>
>  #include <linux/platform_device.h>
> +#include <linux/scatterlist.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
>  
> @@ -30,6 +38,47 @@
>  #define TSN_MAX_VLAN_FRAME_SIZE		(ETH_DATA_LEN + VLAN_ETH_HLEN + \
>  					 ETH_FCS_LEN)
>  
> +#define TX_BD_NUM_DEFAULT		64
> +#define RX_BD_NUM_DEFAULT		128

[ ... ]

> +struct xlnx_tsn_ep_dma_chan {
> +	struct skbuf_dma_descriptor **skb_ring;
> +	struct xlnx_tsn_ep *ep;
> +	struct dma_chan *chan;
> +	struct device *dma_dev;
> +	u32 ring_head;
> +	u32 ring_tail;
> +	u32 ring_size;
> +	bool is_tx;
> +};
> +
>  /**
>   * struct xlnx_tsn_ep - EP MAC private data, embedded in net_device priv area
>   * @ndev: the conduit netdev ("ep0" for the first IP instance)
> @@ -39,6 +88,9 @@
>   * @tx_dma_chan_map: logical TX queue index -> physical DMA channel number
>   * @rx_chan_num: RX ring index -> physical DMA channel number
>   * @max_frm_size: maximum frame size accepted on RX
> + * @tx_chans: array of TX channels (size @num_tx_queues)
> + * @rx_chans: array of RX channels (size @num_rx_queues)
> + * @closing: set in ndo_stop so the RX completion callback stops re-arming
>   */
>  struct xlnx_tsn_ep {
>  	struct net_device *ndev;
> @@ -48,8 +100,19 @@ struct xlnx_tsn_ep {
>  	u32 tx_dma_chan_map[TSN_MAX_TX_QUEUE];
>  	u32 rx_chan_num[TSN_MAX_RX_QUEUE];
>  	u32 max_frm_size;
> +
> +	struct xlnx_tsn_ep_dma_chan **tx_chans;
> +	struct xlnx_tsn_ep_dma_chan **rx_chans;
> +
> +	bool closing;
>  };
>  
> +static inline struct skbuf_dma_descriptor *
> +ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int idx)
> +{
> +	return xchan->skb_ring[idx];
> +}
> +

[Severity: Low]

Several of the pieces added here have no consumer yet at this commit.

The closing field is only ever written, in ep_open() and ep_stop(), and
nothing reads it, but the kernel-doc already describes a contract with an
RX completion callback that this patch does not add:

 * @closing: set in ndo_stop so the RX completion callback stops re-arming

Similarly, ep_get_desc() has no caller, and the TX drain loop in
ep_free_dma_chan() walks [ring_tail, ring_head) although nothing advances
ring_head until the TX data path lands.

On the includes, circ_buf.h and spinlock.h have no CIRC_* or spinlock_t user
in this patch, and io.h has no readl()/writel() user here or at the end of
the series.

Could these move to the patches that first use them, or could the commit
message say they are groundwork for the later data-path patches?

>  static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>  	dev_kfree_skb_any(skb);
> @@ -57,8 +120,22 @@ static netdev_tx_t ep_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  	return NETDEV_TX_OK;
>  }
>  
> +static int ep_init_dmaengine(struct xlnx_tsn_ep *ep);
> +static void ep_exit_dmaengine(struct xlnx_tsn_ep *ep);
> +
>  static int ep_open(struct net_device *ndev)
>  {
> +	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
> +	int ret;
> +
> +	WRITE_ONCE(ep->closing, false);
> +
> +	ret = ep_init_dmaengine(ep);
> +	if (ret) {
> +		netdev_err(ndev, "failed to initialize DMA engine\n");
> +		return ret;
> +	}
> +

[Severity: High]

Can -EPROBE_DEFER still be returned to userspace from ndo_open here?

The changelog says the v2 change means "-EPROBE_DEFER stays in the probe
path and ndo_open never hands a deferral back to userspace", but
ep_reset_dma_controller() requests only "tx_chan<tx_dma_chan_map[0]>" and
drops the reference before probe returns:

	reset_chan = dma_request_chan(ep->dev, name);
	...
	ret = xilinx_vdma_channel_set_config(reset_chan, &cfg);
	dma_release_channel(reset_chan);

Every other TX channel of tx_dma_chan_map[] and every RX channel of
rx_chan_num[] is first requested from the open path:

ep_open() -> ep_init_dmaengine() -> ep_alloc_dma_chan() -> dma_request_chan()

and dma_request_chan() still yields a deferral when the controller behind
the phandle is not registered:

drivers/dma/of-dma.c:of_dma_request_slave_channel() {
	...
		} else {
			ret_no_channel = -EPROBE_DEFER;
			chan = NULL;
		}
	...
}

ep_alloc_dma_chan() passes that up with ERR_CAST(), ep_open() returns it
unchanged, and the core does not translate ndo_open return values:

net/core/dev.c:__dev_open() {
	...
	if (!ret && ops->ndo_open)
		ret = ops->ndo_open(dev);
	...
}

so "ip link set ep0 up" would fail with errno 517 and no deferred probe
retry is queued.

Two ways to reach it: the MCDMA provider is unbound or unloaded after probe,
since nothing holds a channel reference once the reset channel is released;
or the dmas entries name more than one provider, which the binding permits
because it constrains dmas only by count and name pattern, so only the
provider of the first mapped TX channel is known to be bound at probe.

Would acquiring all channels in probe and keeping them, or explicitly
refusing or translating -EPROBE_DEFER in ndo_open, match what the changelog
describes?

>  	netif_tx_start_all_queues(ndev);
>  
>  	return 0;
> @@ -66,7 +143,11 @@ static int ep_open(struct net_device *ndev)
>  
>  static int ep_stop(struct net_device *ndev)
>  {
> +	struct xlnx_tsn_ep *ep = netdev_priv(ndev);
> +
>  	netif_tx_disable(ndev);
> +	WRITE_ONCE(ep->closing, true);
> +	ep_exit_dmaengine(ep);
>  
>  	return 0;
>  }
> @@ -88,6 +169,196 @@ static const struct ethtool_ops ep_ethtool_ops = {
>  	.get_drvinfo	= ep_get_drvinfo,
>  };
>  
> +static struct xlnx_tsn_ep_dma_chan *
> +ep_alloc_dma_chan(struct xlnx_tsn_ep *ep, const char *name, bool is_tx,
> +		  int ring_size)
> +{
> +	struct xlnx_tsn_ep_dma_chan *chan;
> +	struct dma_chan *err_chan;
> +	int i;
> +
> +	chan = kzalloc_obj(*chan);
> +	if (!chan)
> +		return ERR_PTR(-ENOMEM);
> +
> +	chan->chan = dma_request_chan(ep->dev, name);
> +	if (IS_ERR(chan->chan)) {
> +		err_chan = chan->chan;
> +		kfree(chan);
> +		return ERR_CAST(err_chan);
> +	}

[ ... ]

> +static void ep_free_dma_chan(struct xlnx_tsn_ep_dma_chan *chan)
> +{
> +	int i;
> +
> +	if (!chan)
> +		return;
> +
> +	if (chan->chan)
> +		dmaengine_terminate_sync(chan->chan);
> +

[Severity: Medium]

Is dmaengine_terminate_sync() really per logical channel on MCDMA?

For XDMA_TYPE_AXIMCDMA, xilinx_dma_chan_probe() sets chan->ctrl_offset to
XILINX_DMA_MM2S_CTRL_OFFSET for every MM2S channel and to
XILINX_MCDMA_S2MM_CTRL_OFFSET for every S2MM channel, so that register is
shared by all channels of a direction; the per-channel control register is
XILINX_MCDMA_CHAN_CR_OFFSET(tdest).

xilinx_dma_terminate_all() clears the shared RUNSTOP via
xilinx_dma_stop_transfer() and then resets:

drivers/dma/xilinx/xilinx_dma.c:xilinx_dma_reset() {
	...
	dma_ctrl_set(chan, XILINX_DMA_REG_DMACR, XILINX_DMA_DMACR_RESET);
	...
}

Given that, doesn't the first ep_free_dma_chan() call in the
ep_exit_dmaengine() loop reset the whole direction, so the sibling channels'
in-flight descriptors are aborted without any completion callback?  And does
ep_reset_dma_controller() at probe likewise reset every channel of that
MCDMA instance, including channels owned by another client of the same
instance?

If per-channel quiescing is what is intended, would clearing the
RUNSTOP/CHEN bit in the per-tdest CR be the right primitive here?

> +	if (chan->is_tx) {
> +		while (chan->ring_tail != chan->ring_head) {
> +			struct skbuf_dma_descriptor *skbuf_dma;
> +
> +			skbuf_dma = chan->skb_ring[chan->ring_tail &
> +						  (chan->ring_size - 1)];
> +			if (skbuf_dma && skbuf_dma->skb) {
> +				dma_unmap_sg(chan->dma_dev, skbuf_dma->sgl,
> +					     skbuf_dma->sg_len, DMA_TO_DEVICE);
> +				dev_kfree_skb_any(skbuf_dma->skb);
> +				skbuf_dma->skb = NULL;
> +			}
> +			chan->ring_tail++;
> +		}
> +	}
> +

[ ... ]

> +static void ep_exit_dmaengine(struct xlnx_tsn_ep *ep)
> +{
> +	int i;
> +
> +	if (ep->tx_chans) {
> +		for (i = 0; i < ep->num_tx_queues; i++)
> +			ep_free_dma_chan(ep->tx_chans[i]);
> +		kfree(ep->tx_chans);
> +		ep->tx_chans = NULL;
> +	}

[ ... ]

> +	for (i = 0; i < ep->num_tx_queues; i++) {
> +		snprintf(name, sizeof(name), "tx_chan%u", ep->tx_dma_chan_map[i]);
> +		ep->tx_chans[i] = ep_alloc_dma_chan(ep, name, true,
> +						    TX_BD_NUM_DEFAULT);
> +		if (IS_ERR(ep->tx_chans[i])) {
> +			ret = PTR_ERR(ep->tx_chans[i]);
> +			ep->tx_chans[i] = NULL;
> +			goto err_free_chans;
> +		}
> +		tx_allocated++;
> +	}
> +

[Severity: Low]

This is a pre-existing mismatch and was not introduced by this patch - both
the driver checks and the binding come from earlier patches - but requesting
one live channel per tx_dma_chan_map[] entry here makes the undocumented
invariant matter at ndo_open time.

Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
constrains dma-names only by count (minItems 2, maxItems 16) and the pattern
^(tx|rx)_chan[0-7]$, constrains xlnx,num-priorities only to 2..8, and places
no completeness or uniqueness requirement on the ^queue[0-7]$ children of
tx-queues-config.

The driver is stricter: xlnx_tsn_ep_probe() returns -EINVAL when the TX
channel count differs from xlnx,num-priorities, and ep_parse_tx_queue_config()
returns -EINVAL unless the queue children describe every logical queue
0..num_tx-1 exactly once.

So a DTB with xlnx,num-priorities = <8> but only "tx_chan0" and "tx_chan1"
in dma-names validates against the schema and is then rejected at probe.
Should the binding state the relationship between dma-names,
xlnx,num-priorities and the queue<N> children?

[ ... ]

> +static int ep_reset_dma_controller(struct xlnx_tsn_ep *ep)
> +{
> +	struct xilinx_vdma_config cfg = { .reset = 1 };
> +	struct dma_chan *reset_chan;
> +	char name[16];
> +	int ret;
> +
> +	snprintf(name, sizeof(name), "tx_chan%u", ep->tx_dma_chan_map[0]);
> +	reset_chan = dma_request_chan(ep->dev, name);
> +	if (IS_ERR(reset_chan))
> +		return dev_err_probe(ep->dev, PTR_ERR(reset_chan),
> +				     "failed to request %s for reset\n", name);
> +
> +	ret = xilinx_vdma_channel_set_config(reset_chan, &cfg);

[Severity: Low]

reset_chan comes from the generic DT dmaengine API, but the callee casts it
to a Xilinx-private object without any check:

drivers/dma/xilinx/xilinx_dma.c:xilinx_vdma_channel_set_config() {
	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
	u32 dmacr;

	if (cfg->reset)
		return xilinx_dma_chan_reset(chan);
	...
}

and with cfg.reset = 1 the reset path performs MMIO through
chan->xdev->regs + chan->ctrl_offset.

If the dmas phandle resolves to some other dmaengine provider, does this
reinterpret that provider's channel object and then write registers through
pointers read out of it?  depends on XILINX_DMA only makes the Xilinx driver
buildable, it does not tie the phandle to it.

axienet_probe() already does the same thing with cfg.reset = 1, so the
pattern is not new, but would a provider identity check before the call, or
a generic dmaengine reset, avoid adding a second unvalidated cast?

> +	dma_release_channel(reset_chan);
> +	if (ret < 0)
> +		return dev_err_probe(ep->dev, ret,
> +				     "failed to reset DMA controller\n");
> +
> +	return 0;
> +}
> +
>  /*
>   * Parse the "tx-queues-config" child of the EP node. The logical queue
>   * index is taken from the "queue<N>" node name, so the mapping does not
> @@ -285,6 +556,16 @@ static int xlnx_tsn_ep_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_free_ndev;
>  
> +	/*
> +	 * Request one DMA channel at probe time to reset the controller and to
> +	 * gate on the MCDMA provider being bound. This keeps -EPROBE_DEFER in
> +	 * the probe path, so the netdev is only registered once the provider is
> +	 * available and ndo_open never sees a deferral.
> +	 */
> +	ret = ep_reset_dma_controller(ep);
> +	if (ret)
> +		goto err_free_ndev;
> +

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909-patches_v2_external-v2-0-3a40babaff4c%40amd.com
