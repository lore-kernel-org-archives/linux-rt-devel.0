Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748359;
	b=AzJLeWn1UmkXZyTUTBH5phmbivefAs4UTxKPx/WBi4zDuOfuBdMlI9hxpACVFFhJdAIH
	 U5boMz9P16vENn/4StI4J3sqDholiGaheK30s6yZ1mPLKm7UtDLb6mF4me28RlDGom1/a
	 mNLQdrY+9TuXWuZ07cd/lRQuJ4rl1bvjfkN1GqDIYhkOKtOInbb4CTrhaFl/snxLvfoQa
	 GRaEWvsJaBkyQZtttpo94TWGrfv9cV6mbzwSCEsuSZSLRfCbpoGHDBRJ/xUWuY8N5/Fa3
	 30B7STaBnJiB5cWrgtsfCtvr0s5WGPlTilhGz7Z1AmvSQshIvAtwDxykxp2seEXIxkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748359;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iN0PCNGlQE2YeIBopbEE/xXfAvmibpRO1mc8hqy0Ks0=;
	b=UMHnzplr8vKbBzFDbwq7kj88qZt3C4mUXOZMoNUBUWgWEkpSNBomPmKoyt0n8SBbGx82
	 0qFS5Hy694giv/UPH1SeFPlvAV71QozI8qj5eSS6YqH+6WOkoGZKqwkcMPsR/4Iiq8Fwx
	 Br8RK3Tb1Dl8AFkCz5VjjUVP9JtNTf1FI1p7G95V7uVyKo60+8oLSIn8P/OI7xFITa8bM
	 cnL9uWVL/wpJCIP+dC0avVsL+XqywitBy8p3qXfMCXxxepWnLK96UCRxpoqFfrNEjicZr
	 9IO3xMQxoM8d+brn7INRUkEh1/kjG2DTomV88j5f72LnRehHQrlUJ35oEfJKaYdyy6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZrgChme2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8345F606A337;
	Fri, 23 Oct 2026 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZrgChme2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D62A1F01825;
	Fri, 23 Oct 2026 09:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748359;
	bh=iN0PCNGlQE2YeIBopbEE/xXfAvmibpRO1mc8hqy0Ks0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZrgChme2el/c0UjaCs8GOzRxJSI5bGkwsYbhK9Ym1BnbsYSA4+ymvu/XgtuW+ATA3
	 qMYO2NeP9nEp4CUO8snhwTnfOIXTLFUZ0bokO4B7MX3/BfosPBiaMRzPkUWW+ONL3y
	 uLpgN7EmW+kWdKTvaCoCkpp1RiUMLPcZ1Yor1ohc+agmRmjjHX4pCrmsV4kh5i62Wa
	 2p9AV8wDVKwiNTHjuuRXNhFpXdEneWSCsymNDujdZ6rOiPSPIL5h3KLX5JT/XgVVXi
	 HSpLkbZOILRSsBgxV6Hbe+pOI+I2iiFsuuS3VG5dDlbW1jPq8E5pJnimE5Svfwu5qe
	 IJQPa9Z5CRYpg==
Message-ID: <sashiko-outbox-182615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net 5/6] net: macb: kick the transmitter on link-up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Dirkwinkel" <lists@steffen.cc>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261022-std-macb-v14-send-v1-5-9187bc545bf6@beckhoff.com>
References: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
 <20261022-std-macb-v14-send-v1-5-9187bc545bf6@beckhoff.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 09:39:18 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] net: macb: DMA of freed skb in macb_mac_link_up() when empty r=
ing resets TBQP
- [High] net: macb: unbased TBQP index in macb_tx_restart() breaks link-up =
kick
--

commit 19c83c729b5e6d7a587a6b6ecc879a9a247907de
Author: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>

net: macb: kick the transmitter on link-up

This commit calls macb_tx_restart() for each queue in macb_mac_link_up()
after enabling transmit so that pending frames in the ring are transmitted
even if byte queue limits previously stopped the queue.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 6e7ead23d0b74..3dfc7ffdd5985 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c

[ ... ]

> @@ -969,6 +971,10 @@ static void macb_mac_link_up(struct phylink_config *=
config,
>  	spin_unlock_irqrestore(&bp->lock, flags);
> =20
>  	if (!(bp->caps & MACB_CAPS_MACB_IS_EMAC)) {
> +		/* With BQL holding a queue stopped no xmit would issue TSTART */
> +		for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)
> +			macb_tx_restart(queue);

[Severity: Critical]
Can kicking the transmitter here in macb_mac_link_up() cause the controller
to transmit an already unmapped and freed skb buffer on an empty queue?

When a multi-descriptor frame wraps across the end of the ring,
macb_tx_map() clears the used bit on all descriptors of the frame and
places the sentinel used bit at the new queue->tx_head. The controller only
sets the used bit on the first descriptor of a transmitted frame, and
macb_tx_complete() unmaps the buffers via macb_tx_unmap() and frees the skb
without setting the used bit on the remaining descriptors. As a result,
descriptor 0 can retain a cleared used bit and a stale buffer address while
the sentinel sits at start % ring_size !=3D 0.

When that queue is empty (count =3D=3D 0) with start % ring_size !=3D 0 dur=
ing
link-up, macb_mac_link_up() -> gem_shuffle_tx_rings() ->
gem_shuffle_tx_one_ring() skips the ring rotation and reprograms hardware
to descriptor 0:

drivers/net/ethernet/cadence/macb_main.c:gem_shuffle_tx_one_ring() {
	if (!(start % ring_size))
		goto reset_hw_ptr;

	if (!count) {
		queue->tx_head =3D 0;
		queue->tx_tail =3D 0;
		goto reset_hw_ptr;
	}
	...
reset_hw_ptr:
	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
}

Unlike macb_tx_error_task(), which explicitly marks descriptor 0 as used
before resetting the hardware pointer:

drivers/net/ethernet/cadence/macb_main.c:macb_tx_error_task() {
	/* Set end of TX queue */
	desc =3D macb_tx_desc(queue, 0);
	macb_set_addr(bp, desc, 0);
	desc->ctrl =3D MACB_BIT(TX_USED);
}

gem_shuffle_tx_one_ring() leaves descriptor 0 with its stale control word.
When macb_tx_restart() then sets MACB_BIT(TSTART) in the global NCR
register because another queue has pending frames, won't the controller
start reading from descriptor 0 on the empty queue, transmit the freed
buffer onto the network, and advance the hardware pointer past index 0
while queue->tx_head and queue->tx_tail remain at 0?

> +
>  		/* Reap the frames completed while link-down had TCOMP masked */
>  		local_bh_disable();
>  		for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue)

[Severity: High]
Does macb_tx_restart() compute the descriptor index from queue_readl(queue,
TBQP) without subtracting the ring base address, causing missed kicks or
spurious restarts on link-up?

Earlier in macb_mac_link_up(), gem_shuffle_tx_one_ring() rotates the ring
so that done completed frames sit at [ring_size - done, ring_size), unsent
frames sit at [0, count - done), and the hardware pointer is reset to the
ring base:

drivers/net/ethernet/cadence/macb_main.c:gem_shuffle_tx_one_ring() {
	queue->tx_tail =3D done ? ring_size - done : 0;
	queue->tx_head =3D queue->tx_tail + count;

	/* Make descriptor updates visible to hardware */
	wmb();

reset_hw_ptr:
	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
}

Then macb_mac_link_up() calls macb_tx_restart(queue) before scheduling
queue->napi_tx to reap those completed frames:

drivers/net/ethernet/cadence/macb_main.c:macb_tx_restart() {
	if (queue->tx_head =3D=3D queue->tx_tail)
		goto out_tx_ptr_unlock;

	tbqp =3D queue_readl(queue, TBQP) / macb_dma_desc_get_size(bp);
	tbqp =3D macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, tbqp));
	head_idx =3D macb_adj_dma_desc_idx(bp, macb_tx_ring_wrap(bp, queue->tx_hea=
d));

	if (tbqp =3D=3D head_idx)
		goto out_tx_ptr_unlock;
}

Because queue_readl(queue, TBQP) returns the raw 32-bit address
lower_32_bits(queue->tx_ring_dma) rather than a byte offset from the start
of the ring, dividing it directly by macb_dma_desc_get_size(bp) only wraps
to index 0 if lower_32_bits(queue->tx_ring_dma) is an exact multiple of
bp->tx_ring_size * macb_dma_desc_get_size(bp).

In macb_alloc(), queue->tx_ring_dma is not aligned to that product in
several configurations:

drivers/net/ethernet/cadence/macb_main.c:macb_alloc() {
	for (q =3D 0, queue =3D bp->queues; q < bp->num_queues; ++q, ++queue) {
		queue->tx_ring =3D tx + macb_tx_ring_size_per_queue(bp) * q;
		queue->tx_ring_dma =3D tx_dma + macb_tx_ring_size_per_queue(bp) * q;
}

Specifically:
- On multi-queue controllers with descriptor prefetch,
  macb_tx_ring_size_per_queue(bp) adds bp->tx_bd_rd_prefetch bytes per
  queue, shifting queue->tx_ring_dma for queues >=3D 1.
- When 64-bit addressing and ptp timestamping are both enabled,
  macb_dma_desc_get_size(bp) is 24 bytes, which does not evenly divide a
  page-aligned base address even on queue 0.
- When bp->tx_ring_size * macb_dma_desc_get_size(bp) exceeds page size and
  dma_alloc_coherent() returns an address aligned only to page size.

When tbqp at the ring base wraps to a non-zero base_idx instead of 0:
- If count - done =3D=3D base_idx unsent frames are waiting at [0, base_idx=
),
  head_idx equals tbqp, so macb_tx_restart() skips writing MACB_BIT(TSTART)
  and leaves the stopped queue stuck.
- If all queued frames completed while link-down masked completion
  interrupts (done =3D=3D count > 0), queue->tx_head !=3D queue->tx_tail is=
 still
  true before napi_tx runs, and head_idx is 0 while tbqp is non-zero, so
  macb_tx_restart() writes MACB_BIT(TSTART) onto a used descriptor at index
  0 and triggers a spurious used-bit-read interrupt.

Should macb_tx_restart() subtract lower_32_bits(queue->tx_ring_dma) from
queue_readl(queue, TBQP) before dividing by macb_dma_desc_get_size(bp)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-std-macb-v=
14-send-v1-0-9187bc545bf6@beckhoff.com?part=3D5
