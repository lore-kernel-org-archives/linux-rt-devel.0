Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8443C056;
	Tue, 29 Sep 2026 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664188; cv=none; b=FigQnJLracuFkRUE+INQ2/Y+tiST71IIYKMSxLt8flifbTGbngBWHxycyr0yzjJflYcswb3ATA3FMGEjrgUDsfoRHAt0PxRpFq/QQtbxvOJj58nnb8EUPeFJVjhIjzanAFjASg47ubRWdIpVhRNU7ZUfkU0NHxhgKm3gbieyPbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664188; c=relaxed/simple;
	bh=C2nRmWD9empFXA+WPGdaDn6XwvjH0JpFUGAtGdDltDc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ltPdC7V7+j25xc9grEf6hfgJHy0zv10cLVNPYoAMfl/tFmL7XTcifEDta/AfP9PuEs1ANQFUsFlm7dUmq1PIg3EVgN1V2Yyqo+Z/sLUIydN6h7DcMCH56/V/PKRj+GN05V043UzoEpnG9aOikltySszvA0M0nNBCTL/6M6x+JF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEY5syIs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEY5syIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569CE1F000FF;
	Tue, 29 Sep 2026 06:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790664187;
	bh=RjtGT9UV8snzEnfpyf+twE1cQRKeeOlW2EZvEmvRVco=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SEY5syIsgcpWYh7ixiUldPRFNbc4IW6+cE54JmtecY7YqSzpaYB3cd7r0QHH/pcS7
	 8XGi1n+oawf3NV54M7l9/009N/4ymoVMs4Qm7+k5aVpicDFoJtVPEFma8yqIpTZmoB
	 ohSIGblC+0DO6E4JzHhG66gGQWcGMs1SUpEulJfi2MV32mXvWOVRpImlU+ubM7GSYg
	 iCtSXX3k38ikuoS74OmFNzBFvV9J9Sz9+AjWUx00Vweedk8P2IXRaK9EPn/Q21Gq1G
	 0FdX7K7PqHtcJXgxIl391saKvT0DLSSIF3XoFPfRpaI35FKB1M9rm657ecFLyCISNq
	 ZO5nYEkxWPN/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 2/2] netpoll: avoid blocking on the transmit lock in
 queue_process
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260928064239.32456-3-kmehltretter@gmail.com>
References: <20260928064239.32456-1-kmehltretter@gmail.com>
 <20260928064239.32456-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:43:06 +0000
Message-Id: <20260929064307.569CE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net: severe latency in netpoll queue_process on lock contention
--

commit eadeea48c72992b0b24239d8a823d8f836b84527
Author: Karl Mehltretter <kmehltretter@gmail.com>

netpoll: avoid blocking on the transmit lock in queue_process

This commit replaces HARD_TX_LOCK() with HARD_TX_TRYLOCK() in queue_process=
()
to fix a sleeping-in-atomic bug on PREEMPT_RT. If the lock is held, it requ=
eues
the skb and schedules a delayed work retry after HZ / 10.

> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index e0cfcb05468e2..a3c94f0b3f764 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -166,7 +166,13 @@ static void queue_process(struct work_struct *work)
>  			skb_set_queue_mapping(skb, q_index);
>  		}
>  		txq =3D netdev_get_tx_queue(dev, q_index);
> -		HARD_TX_LOCK(dev, txq, smp_processor_id());
> +		if (!HARD_TX_TRYLOCK(dev, txq)) {
> +			netpoll_txq_queue_head(npinfo, skb);
> +			local_irq_restore(flags);
> +
> +			schedule_delayed_work(&npinfo->tx_work, HZ / 10);
> +			return;

[Severity: High]
Does this schedule an excessively long delay when encountering a transient
spinlock contention?

When queue_process() attempts to transmit a deferred skb, it uses
HARD_TX_TRYLOCK(). If another CPU is actively transmitting on the same queu=
e,
the TX lock is transiently held and the trylock fails.

The TX spinlock is typically held for just a few microseconds during normal
network operations, but this introduces a 100ms (HZ / 10) delay upon lock
contention. Will this cause netpoll to stall for 100ms every time it
encounters a busy TX lock, dropping throughput drastically (e.g., to ~10
pkts/sec) and likely causing the deferred queue to overflow resulting in
lost kernel logs?

> +		}
>  		if (netif_xmit_frozen_or_stopped(txq) ||
>  		    !dev_xmit_complete(netpoll_start_xmit(skb, dev, txq))) {
>  			netpoll_txq_queue_head(npinfo, skb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928064239.3245=
6-1-kmehltretter@gmail.com?part=3D2
