Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784380;
	b=bdeFa7+CAMzpmLbm2oTlXbRSsgqu8fbQe+JtJ5deBm26b054BZRgFLnl+1iB9OummV9m
	 ShYhJRCMVH78D7ZcVehJJwltG+cunCTZjBx9VCFu8mgZ8/NGSa/6Y1gr3Ln5VZbImgkv7
	 gdUd8i3Dk7w4pXLapvoQt/STUT3I8k0RxT5/s7OxWIwb2A4dR+4frul9siEk0Psyp0O2h
	 hpkONIHOZ5G74ORgmWiLiAE5B/Ag/5UHeieZBDNzM2S63IH4cCn8KGD/2aCeNrdSwhKAc
	 P/ELCgOqltp1ZDH0NbAeXBP41c53M3FQlC04VZB2KMe55eGniEgTWSWJjjLscqVjpAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784380;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jO8RZUMPW/vjoyBppE3yfXu2wagzR2MyCjUuJjqye9M=;
	b=XNaswyGGnx4EO6svv1x0wxI+L/EFUCN/RrYbQUHyaySba8pmo8GBNIDuU0fgMSFpzEhD
	 1o3Gw6GvP20CERyFZqYqU3WvoIm5HkhUSdGy8+PrbgM/llY+Wq/ToqpuxIiS+iOSaj2D3
	 FRAit5MDyLieRI1ltH5M6AZ58lK+vO+qw+Y1kvQoz4AykjAfDjTCBVDIikAzAwuxJ6jQD
	 iPIYjwfHB7IO2p9+rJf9sh/tgOUgxdccZLoVcXK4J9Yw76qvQjuNfrMKI3jdUxgCKrEWe
	 RQcGGxaQGJZhlaY6rLZud8FGRGuiU3wda/C3zvvc56gvb8ow7l5BiuHKcDQWHHxHNFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4CTqFTj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B3C606A31B;
	Wed,  4 Nov 2026 09:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R4CTqFTj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0ACE1F000C1;
	Wed,  4 Nov 2026 09:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784380;
	bh=jO8RZUMPW/vjoyBppE3yfXu2wagzR2MyCjUuJjqye9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4CTqFTjBBDNzn8x1tMAI+kqr16iG+4thqQZtngIWTePJZToJp7T/nz0s8xJnDjZH
	 hOkjNdjHzLZT413BYVEU7FZPe+HpFF4PUH9s29mR+hwl8WjizpsGD+GEvP+dWcmggU
	 y/m2UjGT25C4plJdBZ8kzvsPhDyA35VnDbyb+nQccUyD3L7HIqL6cAWaM1pZmOWEtp
	 8IqBSIbzvDLTcQChkA0RoxADmLZsLIWgamzDaT/lyyxQUXdskYg7Ncmh0a8JxWNTEG
	 sbCrMwjpJIp8HxEneuDLHb/tclw7LNNGKfXhJ3TXtBCJUgK2K8s+gJGN7RnMKVWz+9
	 CS+zoympO+RDQ==
Message-ID: <sashiko-outbox-196956@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net v3 1/1] af_packet: avoid waiting for TPACKET_V3
 copies at retirement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingxuan Xie" <jingxuanxie@deeproute.ai>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261103092541.273847-2-jingxuanxie@deeproute.ai>
References: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
 <20261103092541.273847-2-jingxuanxie@deeproute.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:26:19 +0000
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
- [Medium] af_packet: premature packet drops in prb_retire_current_block() =
on SMP
--

commit ed9927a1021a4ff736d3e13140014c9d82d1ba49
Author: jingxuanxie <jingxuanxie@deeproute.ai>

af_packet: avoid waiting for TPACKET_V3 copies at retirement

This commit replaces blocking write_lock() calls on blk_fill_in_prog_lock
with write_trylock() in the TPACKET_V3 block retirement paths so that
callers holding sk_receive_queue.lock do not block waiting for in-progress
packet copies. When write_trylock() fails during frame lookup,
prb_retire_current_block() returns false and the packet capture record is
dropped.

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index cf6429f094772..8fd6372ab59bd 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
[ ... ]
> @@ -946,8 +948,8 @@ static void *prb_dispatch_next_block(struct tpacket_k=
bdq_core *pkc,
>  	return (void *)pkc->nxt_offset;
>  }
> =20
> -static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
> -		struct packet_sock *po, unsigned int status)
> +static bool prb_retire_current_block(struct tpacket_kbdq_core *pkc,
> +				     struct packet_sock *po, unsigned int status)
>  {
>  	struct tpacket_block_desc *pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
> =20
> @@ -963,13 +965,14 @@ static void prb_retire_current_block(struct tpacket=
_kbdq_core *pkc,
>  		 * the timer-handler already handled this case.
>  		 */
>  		if (!(status & TP_STATUS_BLK_TMO)) {
> -			/* Waiting for skb_copy_bits to finish... */
> -			write_lock(&pkc->blk_fill_in_prog_lock);
> +			/* Do not wait for copies while holding the queue lock. */
> +			if (!write_trylock(&pkc->blk_fill_in_prog_lock))
> +				return false;
>  			write_unlock(&pkc->blk_fill_in_prog_lock);
>  		}
>  		prb_close_block(pkc, pbd, po, status);
> -		return;
>  	}
> +	return true;
>  }
> =20
>  static int prb_curr_blk_in_use(struct tpacket_block_desc *pbd)
> @@ -1097,7 +1100,8 @@ static void *__packet_lookup_frame_in_block(struct =
packet_sock *po,
>  	}
> =20
>  	/* Ok, close the current block */
> -	prb_retire_current_block(pkc, po, 0);
> +	if (!prb_retire_current_block(pkc, po, 0))
> +		return NULL;

[Severity: Medium]
Does using write_trylock() here cause premature packet drops and delayed
block retirement during normal multi-core traffic, even on non-PREEMPT_RT
kernels and when free blocks are available in the ring?

In tpacket_rcv(), a CPU reserves a slot in the current block via:

  tpacket_rcv()
    packet_current_rx_frame()
      __packet_lookup_frame_in_block()
        prb_fill_curr_block()
          read_lock(&pkc->blk_fill_in_prog_lock);

and then drops sk->sk_receive_queue.lock before running skb_copy_bits(),
tpacket_get_timestamp(), and dev_parse_header() concurrently with other
CPUs.

While CPU 0 is mid-copy on the last packet of a block, CPU 1 can arrive in
tpacket_rcv() with a packet that does not fit in the current block and call
__packet_lookup_frame_in_block() -> prb_retire_current_block(). Even though
CPU 0 has not been preempted (and on non-PREEMPT_RT kernels read_lock()
disables preemption), write_trylock() on CPU 1 will fail immediately,
causing tpacket_rcv() to drop the packet, increment tp_drops (setting
TP_STATUS_LOSING), and skip dispatching the next free block.

Furthermore, when CPU 0 finishes its copy and calls
prb_clear_blk_fill_status(), it only releases the read lock without closing
the block. If the dropped packet on CPU 1 was the end of a burst, won't the
full block remain unretired in TP_STATUS_KERNEL until
prb_retire_rx_blk_timer_expired() fires (and could be delayed by another
full interval_ktime if write_trylock() in the timer handler also coincides
with an active copy)?

Finally, when __packet_lookup_frame_in_block() returns NULL here,
tpacket_rcv() jumps to drop_n_account:

  drop_n_account:
        spin_unlock(&sk->sk_receive_queue.lock);
        atomic_inc(&po->tp_drops);
        drop_reason =3D SKB_DROP_REASON_PACKET_SOCK_ERROR;

        sk->sk_data_ready(sk);

which wakes user-space waiters even though no block was retired to
TP_STATUS_USER. On PREEMPT_RT, could waking a higher-priority user-space
reader thread on every dropped packet preempt the copier thread holding
blk_fill_in_prog_lock and prolong the state where write_trylock() keeps
failing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103092541.2738=
47-1-jingxuanxie@deeproute.ai?part=3D1
