Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794657915;
	b=HdxkMEsr4g+420IggfD4zzvWDADJTPiOJ/76lwyHX1vFLlCcJEAv+xnDHO3UWus8cM97
	 f/24btKSCRM4cT0jzX8QGFAbs8/QSqtMGoetV3f8IB/2AFHkIaaxdvDjluzYitY9duy8d
	 HwR8vlkEBg6SRpX7m/2oqB4+cw0/uWsK1Dft4ZG2Ff8QTNzXxU5xt4qBP7AZycXhAFloa
	 oIx3pQkNiPmNOowLoGqqPmF2fbDuq4fLH7zw0tOi0Uwh3xaKyo6+J068cBwY5mYHxzLHB
	 Y9Y6CkijA2pa69caxYRCSfgpTzcE1R6FcODAZ3U44dP6DpvGqdxN3qpXZibXcqrepLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794657915;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ABaM9Gqg9Dh+BrhyQsvPbubUz+lKv8398aIk880tOpk=;
	b=jiQa1ycdcLRCd5iqJDLjzsLkwVhJy7v1Q5FBrn3Wxu/jgiMP63NyzY0g7udWrHFl1RHN
	 n9jeB6zxc/xO9qUUifp49XAeGkD141PNAL7y4cxnzNZkw7TKOfJqcq/Nm8zvD3L8YvbS8
	 da3wFUSWwp2cYuLsjoK6/5y68nTafOMWlRv/IQldM4FuU2Cm+eaX1fH8rydCPhQeLFgnU
	 LLjPequL3SSk2YhtMKVZzDoqUiuzKVWxuTRUNqzmPxYtjWw0vAexnD77P8i1JKu6hgF52
	 gVyoCm1dLzE3H6EOdLjyp17RrlnQoBJyuWd3vQQxWHIQ9eWQRtAVEkaiQHV2MtfgZ+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aZ34/iOJ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31963606A335;
	Sat, 14 Nov 2026 12:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZ34/iOJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3E81F000C4;
	Sat, 14 Nov 2026 12:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794657915;
	bh=ABaM9Gqg9Dh+BrhyQsvPbubUz+lKv8398aIk880tOpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aZ34/iOJrdVXoiSQaq/9xjZq7nCxs7yo1SBhiKBS7zGkM0snG6UbXlJ1VY6Kj5sL6
	 5Ef4zR0bLbM+xH77avmue1ojcX6KikG7VXD4QC4O0xL29Pv2LCEZ4yKvKvKZVq984x
	 1xKuEhS/rnzfThjz7o/7bB1sc+wAazxtAi+DGAhShiAIqll0tsgxVg9FAFJ1GlYtFm
	 iSTj0DEvU6tgB+Sf98xXYayNOIsRf7TzigFAz8yQoNJbq9eHvhGq/HXlX7jYuT3aSQ
	 MKWvlLzUcumJXKz7YeWvqnc+vnWeMBXEYhAa+ayh1akfs7mzaEIiK/KkBQI7FxnFGX
	 w6eq8pqd+OQxA==
Message-ID: <sashiko-outbox-214490@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4 6/8] net: xilinx: tsn: add the endpoint RX
 data path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srinivas Neeli" <srinivas.neeli@amd.com>
Cc: devicetree@vger.kernel.org, linux-rt-devel@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261113-patches_v2_external-v4-6-56bb26f042a4@amd.com>
References: <20261113-patches_v2_external-v4-0-56bb26f042a4@amd.com>
 <20261113-patches_v2_external-v4-6-56bb26f042a4@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 12:05:14 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] net: xilinx: tsn: RX stall from MCDMA IRQ coalescing in
  ep_rx_refill()
- [Medium] net: xilinx: tsn: permanent RX stall after MCDMA error
  interrupt
--

commit 8a8c3c55f7d1afb981a05d0249b531e8e8eb911c
Author: Srinivas Neeli <srinivas.neeli@amd.com>

net: xilinx: tsn: add the endpoint RX data path

This commit adds the endpoint RX data path, posting RX buffers to the MCDMA
channels, handling completion callbacks with TUSER port_id filtering, and
refilling the RX ring under a per-channel lock.

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/ne=
t/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> index 52d2da04a5d88..f179062c7d148 100644
> --- a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
[ ... ]
> @@ -113,6 +136,181 @@ ep_get_desc(struct xlnx_tsn_ep_dma_chan *xchan, int=
 idx)
[ ... ]
> +static bool ep_rx_refill(struct xlnx_tsn_ep_dma_chan *xchan, bool arm_ti=
mer)
> +{
> +	int avail, i;
> +
> +	scoped_guard(spinlock_bh, &xchan->rx_lock) {
> +		if (READ_ONCE(xchan->ep->closing))
> +			return false;
> +
> +		avail =3D CIRC_SPACE(xchan->ring_head, READ_ONCE(xchan->ring_tail),
> +				   xchan->ring_size);
> +		for (i =3D 0; i < avail; i++) {
> +			if (ep_rx_submit_desc(xchan))
> +				break;
> +		}
> +		dma_async_issue_pending(xchan->chan);

[Severity: Medium]
Can calling dma_async_issue_pending() once after submitting a batch of 2 to
24 descriptors stall RX under sparse traffic?

Each ep_rx_submit_desc() increments chan->desc_pendingcount in the MCDMA
driver, and dma_async_issue_pending() then programs the channel's hardware
interrupt coalescing threshold from that batch count:

drivers/dma/xilinx/xilinx_dma.c:xilinx_mcdma_start_transfer() {
    ...
	if (chan->desc_pendingcount <=3D XILINX_MCDMA_COALESCE_MAX) {
		reg &=3D ~XILINX_MCDMA_COALESCE_MASK;
		reg |=3D chan->desc_pendingcount <<
			XILINX_MCDMA_COALESCE_SHIFT;
	}

	reg |=3D XILINX_MCDMA_IRQ_ALL_MASK;
	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
    ...
}

If ep_rx_refill() submits between 2 and 24 descriptors (for example when
multiple descriptors complete before refill runs, or when an allocation
fails partway through filling the ring), the hardware waits for that many
frames before raising XILINX_MCDMA_IRQ_IOC_MASK, and later batches larger
than 24 leave that threshold programmed.  Because xilinx_mcdma_irq_handler()
does not complete descriptors on XILINX_MCDMA_IRQ_DELAY_MASK, received
frames fewer than the coalescing threshold sit in the ring without a
completion callback until more traffic arrives.

> +
> +		if (i > 0 || xchan->ring_head !=3D READ_ONCE(xchan->ring_tail))
> +			return true;
> +
> +		if (arm_timer)
> +			mod_timer(&xchan->rx_refill_timer,
> +				  jiffies + EP_RX_REFILL_RETRY);

[Severity: Medium]
Does an MCDMA channel error interrupt wedge the RX queue until the interface
is cycled down and up?

When xilinx_mcdma_irq_handler() sees XILINX_MCDMA_IRQ_ERR_MASK without a
completed descriptor (XILINX_DMA_BD_COMP_MASK), it sets chan->err =3D true =
and
leaves the active descriptors on chan->active_list rather than moving them
to chan->done_list:

drivers/dma/xilinx/xilinx_dma.c:xilinx_mcdma_irq_handler() {
    ...
	if (status & XILINX_MCDMA_IRQ_ERR_MASK) {
		...
		chan->err =3D true;
	}
    ...
	if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
		spin_lock(&chan->lock);
		xilinx_dma_complete_descriptor(chan);
    ...
}

Because nothing lands on chan->done_list, ep_dma_rx_cb() is never called for
the in-flight descriptors, xchan->ring_head !=3D xchan->ring_tail remains
true, and rx_refill_timer is not armed.  No further ep_rx_submit_desc() call
runs to trigger xilinx_dma_chan_reset() in xilinx_dma_tx_submit(), leaving
RX on that channel halted while the netdev stays up.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-patches_v2=
_external-v4-0-56bb26f042a4@amd.com?part=3D6
