Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB09175A60;
	Tue,  7 Jul 2026 14:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783432959; cv=none; b=nwJ9GXxuCt1NK5ab65sdAYXKhCsXqSicDEVKdGHi3b+/naGP4VwA8vxqByB5OeIkyd4/Og/c1C+idsDtnSm1eABnFxF7aGFoUvZPhNdp0XXOyfPuk9DVNjWsSZGsIfT6GYKAcPVXzw/htlwAFi6aFBJgnOOEcwlm2X6EObRMk4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783432959; c=relaxed/simple;
	bh=5Xg0fsrBjTOORkLHe7ry/9anXZWlR7kfip779DvRnl4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=diKMjc6l9X9RxUqyNAFDWfmAjvJAfandT1jfUeC1yB+TMbqEqtvCKpCzzCWc55NgvvmmndxdGO67f0MdlAnG3THORanGfR8t49CzNZUbsvAxvpGtFqmVm9yqq+NC75pB2G1pVb8j/j+IxP0VWXHRikzJlJ3NeR1TtxgMkU5ZGEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2CqY8Nq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2CqY8Nq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3D71F000E9;
	Tue,  7 Jul 2026 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783432957;
	bh=7+TSsWB66ehjJwirJYpM6528tP5tWS6tNVkbdZX6no8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m2CqY8NqhMVxDrQhenKCGdZSfTMh4ep+c2uxF69ZjI6yDcyaoNoX9wtBEK09ZT7V4
	 4J2mJsEKEKb/QneqvEaKx2PxnLcgkQF9jj6GXiIz+N4uv7oM/PT8j2pX1jfEOGOvyy
	 VzPrR+F1aVC4/4XgH/p8Yw/GDYbk9DNb+z6GlokqXTPL0a7Zv99qUY8+IjH5b3991W
	 mq7TqjrB6BqF7OfHUyYj0b1oGnrge3SKNDmQQmi8lLSSCreg7QrWlkoDkNrYD5YCIR
	 ITKyyI88UOPLbzAGfkFSH2WrN9tXpNQtPd9bhQC33Ve1ItzOlhRyTE//XVb7j1dnP+
	 0s1rFTx68ngPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 1/2] net: macb: reprogram TBQP after shuffling the
 TX ring on link-up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Taedcke" <christian.taedcke@weidmueller.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
References: <20260706-upstreaming-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com>
 <20260706-upstreaming-macb-irq-storm-v1-1-ab3115b5a13a@weidmueller.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 14:02:37 +0000
Message-Id: <20260707140237.9E3D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] macb_hresp_error_task() reinitializes all TX and RX rings with=
out holding any locks and without synchronizing with NAPI.
- [High] macb_tx_error_task() accesses and modifies TX queue state without =
holding queue->tx_ptr_lock, causing data races with concurrent macb_start_x=
mit() and gem_shuffle_tx_rings() operations.
--

commit f087c1d0ffc5f4dd5ef2d3cbe0d1c4868c7a17b2
Author: Christian Taedcke <christian.taedcke@weidmueller.com>

net: macb: reprogram TBQP after shuffling the TX ring on link-up

gem_shuffle_tx_one_ring() rotates the software TX ring so that the
tail sits at index 0 and resets queue->tx_tail to 0, but it never
reprograms the hardware transmit buffer queue pointer (TBQP). Other
paths that reset tx_tail to the ring base (macb_init_buffers() and
macb_tx_error_task()) also reprogram TBQP to queue->tx_ring_dma; this
path does not, leaving TBQP pointing at a stale descriptor.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index fd282a1700fb9..b11cb8f068b73 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -820,7 +820,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue=
 *queue)
>  	if (!count) {
>  		queue->tx_head =3D 0;
>  		queue->tx_tail =3D 0;
> -		goto unlock;
> +		goto reset_hw_ptr;
>  	}

[Severity: High]
This is a pre-existing issue, but does macb_tx_error_task() modify TX queue
state without holding queue->tx_ptr_lock?

Looking at macb_tx_error_task(), it resets queue->tx_head and queue->tx_tail
to 0 without holding queue->tx_ptr_lock (it only takes bp->lock):

drivers/net/ethernet/cadence/macb_main.c:macb_tx_error_task() {
    ...
    queue->tx_head =3D 0;
    queue->tx_tail =3D 0;
    ...
}

Concurrently, macb_start_xmit() can be executing, which holds
queue->tx_ptr_lock but not bp->lock.

Also, macb_mac_link_up() releases bp->lock before calling
gem_shuffle_tx_rings(), enabling a race.

Although netif_tx_stop_all_queues() is called, it only sets a state flag and
does not wait for a currently executing macb_start_xmit() to finish.

Could this lead to data corruption or double-frees?

[ ... ]

> @@ -869,6 +869,13 @@ static void gem_shuffle_tx_one_ring(struct macb_queu=
e *queue)
>  	/* Make descriptor updates visible to hardware */
>  	wmb();
> =20
> +reset_hw_ptr:
> +	/* tx_tail was reset to the ring base, so TBQP must be reprogrammed
> +	 * to match; otherwise it keeps pointing at a stale descriptor. Safe
> +	 * to write directly here as TX is still disabled (called from
> +	 * macb_mac_link_up() before TE is set).
> +	 */
> +	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
>  unlock:
>  	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
>  }

[Severity: Critical]
This is a pre-existing issue, but does macb_hresp_error_task() reinitialize
all TX and RX rings without holding any locks or synchronizing with NAPI?

Looking at macb_hresp_error_task(), it calls mog_init_rings() which
destructively resets tx_head, tx_tail, and wipes descriptors across all
queues back to 0:

drivers/net/ethernet/cadence/macb_main.c:macb_hresp_error_task() {
    ...
    bp->macbgem_ops.mog_init_rings(bp);
    ...
}

However, macb_hresp_error_task() does not acquire bp->lock or
queue->tx_ptr_lock, and it fails to call napi_disable() to synchronize with
RX/TX softirq paths.

Concurrently, NAPI polls (macb_tx_poll, macb_rx_poll) or macb_start_xmit()
might still be operating on the ring state.

Could this cause memory corruption or use-after-frees?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-upstreamin=
g-macb-irq-storm-v1-0-ab3115b5a13a@weidmueller.com?part=3D1
