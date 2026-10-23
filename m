Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748359;
	b=qDXcG3DpZjeDlh4JQOEOsmA22ngtqe4wu+Z6P+7q/BTDduP29LJRMMKSkcptibQAm5i1
	 lf9376kOGn+IGyXT3xQpaiKYVp8PkFuOUw/O1g+d6tQ1VN9eovDVtLq7weiF/yvrmUiF+
	 fSXwrNubkyQXBotal2nXJuhLNtpI34QqybQdsXq98aY/9MR+/AWvb6qtr/FLNqf4MIiqi
	 6DaZRxADRJNeB0YPkCuWl4ggCOzAjGGkDxLPM+O1kO+TJkOma8U/Vs6hiCrmVr5w6udqm
	 yg68JepeMEcY1XYBmJ3jY/FP1cWguOfK1QhOHeLosG2HUSgspBFGf6Ybc8HT9+XzVzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748359;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6IWJHyZ7u9fcny5kqPQ36kMf+/FUiOJV/SSQ0AoHVmQ=;
	b=jeZDi32SHD9WiMdS7OYyzcqxJSyCyJIhIYnjpclksxO6ObSbbddgFWkFpzwGW3/ON6Bx
	 GIkMQro0ZlqIf5Nhsn7z9BXjIhPfa/t7qpDDP+4mKYJByNxxw5aHKoDBeD8aM6m5creeU
	 boYFVJRnHdoL58d5Y3onLfPne3k4S3btyH2HmYSN5YLU58Ckzcs0PYiBgqiN5cmVQ+MQ6
	 03v+qVlLJ+DTxm1qTVs9u06XZhs5UyWt5MGg6C0EwlNgpv68oZG2Dysfb8s4TlUmUwAAs
	 xJIwbsJiwo+B9VTKsx76y6ku8tZDZDd5fmYtGZ/KBdqC9wpmOQUevKehNA1oLxLpIxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRszCCsm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0548606A32C;
	Fri, 23 Oct 2026 09:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QRszCCsm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E741F031E1;
	Fri, 23 Oct 2026 09:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792748358;
	bh=6IWJHyZ7u9fcny5kqPQ36kMf+/FUiOJV/SSQ0AoHVmQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QRszCCsmAP8kSKJIZZngJA1wO7f/dM7M7e8sJAaEfWnIBwWjriFfFMccAYXNCJcHK
	 GZGpdDq0ZTaBy5DBiggerksIz6QcOIbUNM7e8nw+ubUgpUOL0bLnJcSvbkNqb7IDfQ
	 jMNjWcWFbgu2Bw0OsH2wNOw6vP1yBjDkN7vS1IzNl9cMxL7uQIWyNfnx0jRVGMxpAK
	 RZ/v/vCeHZXMuj/FuE3wIEj2ZaHJbJVOqNpW9fSaBwHkph22W+b8QOzVb3v66Rv8Mg
	 qvsG2h3Prm6wsJNkTOD10E94PPXxEG54Ip65HOnNw2QwBxHTkSMyvt3JQgKDaUDv2P
	 X34aQH50QOXMw==
Message-ID: <sashiko-outbox-182613@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net 3/6] net: macb: mask TXUBR during TX NAPI poll
 to prevent IRQ storms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Dirkwinkel" <lists@steffen.cc>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261022-std-macb-v14-send-v1-3-9187bc545bf6@beckhoff.com>
References: <20261022-std-macb-v14-send-v1-0-9187bc545bf6@beckhoff.com>
 <20261022-std-macb-v14-send-v1-3-9187bc545bf6@beckhoff.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] net: macb: lost TXUBR event while masked in macb_tx_poll() stalls =
TX queue
- [Medium] net: macb: TXUBR left unmasked when macb_tx_poll() reschedules N=
API
--

commit a3dccad77456cfe6ddb20424831a548f63c5269b
Author: Christian Taedcke <christian.taedcke@weidmueller.com>

net: macb: mask TXUBR during TX NAPI poll to prevent IRQ storms

This commit updates macb_interrupt() to mask MACB_BIT(TXUBR) alongside
MACB_BIT(TCOMP) when scheduling the TX NAPI poll, and updates macb_tx_poll()
to re-enable both bits when NAPI completes.

> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index 97494933eb1ee..14c8299cb7f37 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1979,7 +1979,7 @@ static int macb_tx_poll(struct napi_struct *napi, i=
nt budget)
>  		    (unsigned int)(queue - bp->queues), work_done, budget);
> =20
>  	if (work_done < budget && napi_complete_done(napi, work_done)) {
> -		queue_writel(queue, IER, MACB_BIT(TCOMP));
> +		queue_writel(queue, IER, MACB_BIT(TCOMP) | MACB_BIT(TXUBR));
> =20
>  		/* Packet completions only seem to propagate to raise
>  		 * interrupts when interrupts are enabled at the time, so if

[Severity: Medium]
In drivers/net/ethernet/cadence/macb_main.c, when work_done < budget and
napi_complete_done(napi, work_done) returns true, macb_tx_poll() writes
MACB_BIT(TCOMP) | MACB_BIT(TXUBR) to IER to unmask both TX interrupt source=
s.

Immediately afterward, macb_tx_poll() checks macb_tx_complete_pending(queue)
to handle packets that completed while interrupts were disabled:

		if (macb_tx_complete_pending(queue)) {
			queue_writel(queue, IDR, MACB_BIT(TCOMP));
			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP));
			netdev_vdbg(bp->netdev, "TX poll: packets pending, reschedule\n");
			napi_schedule(napi);
		}

Unlike macb_rx_poll(), which writes bp->rx_intr_mask to IER and then masks
the same bp->rx_intr_mask in IDR when macb_rx_pending(queue) is true:

		if (macb_rx_pending(queue)) {
			queue_writel(queue, IDR, bp->rx_intr_mask);
			macb_queue_isr_clear(bp, queue, MACB_BIT(RCOMP));
			netdev_vdbg(bp->netdev, "poll: packets pending, reschedule\n");
			napi_schedule(napi);
		}

should this reschedule block in macb_tx_poll() also write
MACB_BIT(TCOMP) | MACB_BIT(TXUBR) to IDR and macb_queue_isr_clear() so that
MACB_BIT(TXUBR) is not left unmasked while napi_tx is rescheduled and polli=
ng?

> @@ -2174,7 +2174,8 @@ static irqreturn_t macb_interrupt(int irq, void *de=
v_id)
> =20
>  		if (status & (MACB_BIT(TCOMP) |
>  			      MACB_BIT(TXUBR))) {
> -			queue_writel(queue, IDR, MACB_BIT(TCOMP));
> +			queue_writel(queue, IDR, MACB_BIT(TCOMP) |
> +						 MACB_BIT(TXUBR));
>  			macb_queue_isr_clear(bp, queue, MACB_BIT(TCOMP) |
>  							MACB_BIT(TXUBR));
>  			if (status & MACB_BIT(TXUBR)) {

[Severity: High]
Can masking MACB_BIT(TXUBR) in macb_interrupt() cause a TXUBR halt event to
be lost during NAPI polling, stalling the TX queue until macb_tx_timeout()
fires?

In drivers/net/ethernet/cadence/macb_main.c, when macb_interrupt() handles a
normal TX completion where status only has MACB_BIT(TCOMP) set, it now writ=
es
MACB_BIT(TCOMP) | MACB_BIT(TXUBR) to IDR, masking TXUBR while
queue->txubr_pending remains false, and schedules queue->napi_tx. Similarly,
in macb_tx_poll(), queue->txubr_pending is cleared to false before calling
macb_tx_restart() while TXUBR remains masked until napi_complete_done() (or
across multiple polls when work_done =3D=3D budget):

	rmb(); // ensure txubr_pending is up to date
	if (queue->txubr_pending) {
		queue->txubr_pending =3D false;
		netdev_vdbg(bp->netdev, "poll: tx restart\n");
		macb_tx_restart(queue);
	}

When the transmitter reads a descriptor with MACB_BIT(TX_USED) set, it halt=
s.
As noted in the comments in macb_tx_poll() and macb_rx_poll() (and commits
0bf476fc3624 and 1900e30d0ef7), events on this controller only propagate to
raise interrupts if the corresponding interrupt bit is enabled at the moment
the event occurs; re-enabling the bit in IER later does not raise an
interrupt.

If the race between macb_start_xmit() updating descriptors and the controll=
er
reading MACB_BIT(TX_USED) (commit 4298388574da) happens while MACB_BIT(TXUB=
R)
is masked, the transmitter halts at the unsent descriptor (with TBQP !=3D
tx_head) without latching MACB_BIT(TXUBR) in ISR, so queue->txubr_pending
stays false.

In macb_tx_poll(), macb_tx_complete() then reaps completed frames and stops=
 at
the unsent frame at queue->tx_tail (where MACB_BIT(TX_USED) is 0), and skips
macb_tx_restart() because queue->txubr_pending is false. When
napi_complete_done() succeeds and macb_tx_poll() writes
MACB_BIT(TCOMP) | MACB_BIT(TXUBR) to IER, no interrupt is raised for the
earlier TXUBR halt, and macb_tx_complete_pending(queue) returns false becau=
se
macb_tx_desc(queue, queue->tx_tail)->ctrl still has MACB_BIT(TX_USED) clear:

	if (queue->tx_head !=3D queue->tx_tail) {
		/* Make hw descriptor updates visible to CPU */
		rmb();

		if (macb_tx_desc(queue, queue->tx_tail)->ctrl & MACB_BIT(TX_USED))
			retval =3D true;
	}

Could NAPI then complete without calling macb_tx_restart(), leaving the
transmitter halted with unsent frames in the ring until the netdev watchdog
times out?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-std-macb-v=
14-send-v1-0-9187bc545bf6@beckhoff.com?part=3D3
