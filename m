Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748358;
	b=DFHEE9gJ7aZSbhu8UABR7ujzdIvUbDBrzlSlxIVk2KfZxExvTSO/aSR3zlFrlfocZkAu
	 cfbjXMZQUUpRExrBy8zCSRkJlxw1Z/bsHyUaAfVOUG73wIkBGQ1NAtNfWcUB1eUzn7nLB
	 kV2MlRuYCHU8M0o5G/7lWXGZhZk/6qqB14+BzQ5mLCguHBlj0H6skiFdPOdhRcS3z7Pad
	 +BjMfVG2wv6zrHCvW9drtnqFLsy6/N+Kpid9MCQcbsxi40Z/P9rSyBivWxcypTfZRg752
	 zclaEZgAtzWITcHyMsOr6HZXVIjU1xPcNjMjDPE9QTk1WCB8N0rbidLfkseB3LcHPjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748358;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4tf90m9jG5eMljEYtnk9jbkUFR0mOTT0OPUqGGC0+2g=;
	b=2EA7oR2kx03UeHTa/k7K4Usf2kLSs37cG1b8UVApRI1/cQ+dWFlXgIeqHRaU6GaiwWo2
	 ZlBBvm1kpa1Z4EflASFpWnOdgkUkFO3b29kpXdjWGwCCVeZVaJrSbYuYktF8k6IuJLaZI
	 exv4b/M8b/9s1E6luLEbRBTkG0KaV2IRtOQDjbEVoOLFrbaEXEP99EVdsGeSkjIzmnC6U
	 PjVPjAdDLMreYVoEFMlOB75pqgsRslfD4Kqmpbwqi6tjdcuqQbWzhQp6fQAHzDCHX5WIW
	 rwZC6mg0XVwFrxzlMGBTLApopyLGh9vlls2MlFCz31NiKVIkEcMNcjtgkBv2RIM43XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dK/vWTv/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21ED8606A32D;
	Fri, 23 Oct 2026 09:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dK/vWTv/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB451F01829;
	Fri, 23 Oct 2026 09:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748357;
	bh=4tf90m9jG5eMljEYtnk9jbkUFR0mOTT0OPUqGGC0+2g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dK/vWTv/SAR/e14ze+NhyRR/ReYun9CIL8eD2Oy5sJVpP3Z030bykKASSCELK9srv
	 tKmwzPRyRt2Rgyxd35gFjoOrOBnhPAKSRJ2VpVqdK4QpwQxT6HBGh1d3cNIgMNuL20
	 D2OYSK/dxQpfOdTRO+SBrfZ0Ua505eOYrcKit6tCXOzfVSDekiX+A2FGNIsR1m45fa
	 oLqUoLJ2BAGbxrIikfcMDj4WgGuVCkR3CBJAeY8oJGt6/bJoKWEpdvv7WoQS36/H5n
	 xCH1NqlwgRler+zymp3YZUVSddbC3dJKQolYWO7Po4EvdRJGbiZuYNIoK6+1rhqXnN
	 PxiwhiJohdPvQ==
Message-ID: <sashiko-outbox-182612@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net 2/6] net: macb: reprogram TBQP after shuffling
 the TX ring on link-up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Dirkwinkel" <lists@steffen.cc>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261022-std-macb-v14-send-v1-2-9187bc545bf6@beckhoff.com>
References: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
 <20261022-std-macb-v14-send-v1-2-9187bc545bf6@beckhoff.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 09:39:17 +0000
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: macb: missing TX_USED bit on desc 0 in gem_shuffle_tx_one_rin=
g()
--

commit ded0ab42c83afe9d93d9bc6c0ab9623a1dc038f5
Author: Christian Taedcke <christian.taedcke@weidmueller.com>

net: macb: reprogram TBQP after shuffling the TX ring on link-up

This commit reprograms the hardware transmit buffer queue pointer (TBQP) to
queue->tx_ring_dma in gem_shuffle_tx_one_ring() whenever tx_tail is reset to
0 during link-up, preventing TBQP from pointing at a stale descriptor.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 4b50378675378..97494933eb1ee 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -823,7 +823,7 @@ static void gem_shuffle_tx_one_ring(struct macb_queue=
 *queue)
>  	if (!count) {
>  		queue->tx_head =3D 0;
>  		queue->tx_tail =3D 0;
> -		goto unlock;
> +		goto reset_hw_ptr;
>  	}
> =20
>  	shift =3D tail % ring_size;
> @@ -872,6 +872,13 @@ static void gem_shuffle_tx_one_ring(struct macb_queu=
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

[Severity: High]
When count is 0 and gem_shuffle_tx_one_ring() in
drivers/net/ethernet/cadence/macb_main.c jumps from the !count branch to
reset_hw_ptr without rotating the ring, is descriptor 0 guaranteed to have
MACB_BIT(TX_USED) set before TBQP is reprogrammed to queue->tx_ring_dma?

When a multi-descriptor frame (such as scatter-gather or segmentation
offload) wraps around the end of tx_ring so that descriptor 0 is a non-first
descriptor of that frame, macb_tx_map() clears MACB_BIT(TX_USED) on all
descriptors of the frame and sets MACB_BIT(TX_USED) on the sentinel
descriptor at tx_head. On frame completion, the hardware only sets
MACB_BIT(TX_USED) on the first descriptor of the frame, and
macb_tx_complete() unmaps the buffers without setting MACB_BIT(TX_USED) on
the remaining descriptors:

drivers/net/ethernet/cadence/macb_main.c:macb_tx_complete() {
	...
		/* TX_USED bit is only set by hardware on the very first buffer
		 * descriptor of the transmitted frame.
		 */
		if (!(ctrl & MACB_BIT(TX_USED)))
			break;
	...
}

If the queue subsequently drains (count =3D=3D 0) at a non-zero ring index
(tail % ring_size !=3D 0) before link-up, the TX_USED sentinel sits at
desc[tail % ring_size] while desc[0]->ctrl still has TX_USED cleared and
desc[0]->addr holds an unmapped dma address.

Jumping to reset_hw_ptr points TBQP at desc[0] with TX_USED =3D=3D 0. If
MACB_BIT(TSTART) is then written to NCR (for example when another queue
transmits in macb_start_xmit() or when TSTART is kicked on link-up) before a
new frame is mapped on this queue, can the controller read the stale unmapp=
ed
address in desc[0]->addr and advance TBQP past index 0 while tx_head and
tx_tail remain 0?

In comparison, macb_tx_error_task() marks descriptor 0 as used and issues a
write barrier before writing TBQP:

drivers/net/ethernet/cadence/macb_main.c:macb_tx_error_task() {
	...
	/* Set end of TX queue */
	desc =3D macb_tx_desc(queue, 0);
	macb_set_addr(bp, desc, 0);
	desc->ctrl =3D MACB_BIT(TX_USED);

	/* Make descriptor updates visible to hardware */
	wmb();

	/* Reinitialize the TX desc queue */
	queue_writel(queue, TBQP, lower_32_bits(queue->tx_ring_dma));
	...
}

Should the !count path also set MACB_BIT(TX_USED) on descriptor 0 and call
wmb() before reprogramming TBQP?

>  unlock:
>  	spin_unlock_irqrestore(&queue->tx_ptr_lock, flags);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-std-macb-v=
14-send-v1-0-9187bc545bf6@beckhoff.com?part=3D2
