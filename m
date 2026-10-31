Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793434655;
	b=l9CTIvEsZihan6W3nu5StmZ8nei2xM+4duR3+6KsOnOC77auMJGMRMWtCNCx8DeooSbU
	 hL/6uSDgHoG2Ux1Rmlc7ixFGWRIcDULer71fVdHW/dKDeKjgFxaeeT1RAOzj51h2MOY4A
	 emx1lRfw2qIvXkSRByR9jMjK64BZYpPbjoeRKGBu7Fzs5/UB+T81rrftL7hRzBJRXGKql
	 fxrOZoRLl0kPQkL/FD5sNK+0XDy7Xvi6n0Z8bNkpUB8/L3p2LEvYYzvnGVrxSipZo53bs
	 iv73c/UFrqJozu1/DxYkjgWlMI+gnEQtPKgv4/NOPIjuBZvwIN2Emx15qBsSZNBIR/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793434655;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zlB2Ne42ndQ0FL9gkgblkMSA18ikPceLQS/DuNnQLKE=;
	b=CADOQQAya+ELPFmvh/lEaXsCg1gD0rzWGMf8myhx4B3KqG2WGHIIugcKsWH1MqZ6v99h
	 Q9RKRjohT8JFfDq0Kn2Aw9xpZmga3cAxEVoIwdsVfmrPLNao1Fyie+/TskP4RD1WHdwwn
	 gzusnBTlJq45T7q67+DTKlh2e922Keucnj6eqTm4eJeMsG36EaJzm/SRPAXS32MA1vIJ2
	 rxmAxEpi+dLY7xUxetEGfe+zd5RgnzSyXlgio6za0d8ZRAiWY6lhCS73CjGQbS8oPiOuQ
	 sgPoq8PysWT7jQab4c19r28LnD14XZPutujlroQ673jVhMAt6UdToW6w3dolA19Pi0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gc7Gz9WO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE1B606A31D;
	Sat, 31 Oct 2026 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gc7Gz9WO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8021F00919;
	Sat, 31 Oct 2026 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793434654;
	bh=zlB2Ne42ndQ0FL9gkgblkMSA18ikPceLQS/DuNnQLKE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gc7Gz9WOZ3h4bcDUmAusCDBgODUj2PxxkBVzl/x3aGapAW7F999wEGq09QNOtEFcO
	 p/KVqv6A49oojmWfuf1aHJ4amOzRg718pLS+Hyc22k3ht3K0yTlJCNL9Rhz5FOJadS
	 QK5YBzLDbIS+q0daPGodDDQaAl0wzeuqTEHS7mvgT50N3DoGZp8i+3KA+RvDX/aV+9
	 X4im1pNwPjFdZkCoBcatD6tK61R154QGlP3NVsofNq6Y7jWyWD0T6G+MGB2yVDymNC
	 roVo8sMAyt3OsD39Ze8CiorkJLiv0hEOhVgueUsXCzwJyHNV0hy81jmo29EV2LHgjB
	 mKx254578kTgA==
Message-ID: <sashiko-outbox-191824@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC net v2 2/2] af_packet: retire TPACKET_V3 blocks without
 waiting for copiers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jingxuan Xie" <jingxuanxie@deeproute.ai>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261030081704.251652-3-jingxuanxie@deeproute.ai>
References: <20261030081704.251652-1-jingxuanxie@deeproute.ai>
 <20261030081704.251652-3-jingxuanxie@deeproute.ai>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 08:17:33 +0000
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
- [High] af_packet: prb_retire_current_block() trusts user-mapped BLOCK_NUM=
_PKTS
- [Medium] af_packet: tpacket_rcv() bypasses ROOM_NONE drop when in_flight =
is non-zero
--

commit 9f9d78a929f32b0ce1f7614bea46eb96c69e1ab8
Author: jingxuanxie <jingxuanxie@deeproute.ai>

af_packet: retire TPACKET_V3 blocks without waiting for copiers

This commit replaces the TPACKET_V3 ring-wide read/write lock with per-block
in-flight copy accounting in struct pgv so that full or expired blocks can
be sealed and advanced without waiting for active copiers to complete.
Sealed blocks are subsequently published in order under the receive queue
lock once their in_flight count reaches zero.

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 7b3e1e27f7771..5bc486326be93 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
[ ... ]
> @@ -950,31 +949,24 @@ static void prb_retire_current_block(struct tpacket=
_kbdq_core *pkc,
>  		struct packet_sock *po, unsigned int status)
>  {
>  	struct tpacket_block_desc *pbd =3D GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
> +	struct pgv *block =3D &pkc->pkbdq[pkc->kactive_blk_num];
> =20
> -	/* retire/close the current block */
> -	if (likely(TP_STATUS_KERNEL =3D=3D BLOCK_STATUS(pbd))) {
> -		/*
> -		 * Plug the case where copy_bits() is in progress on
> -		 * cpu-0 and tpacket_rcv() got invoked on cpu-1, didn't
> -		 * have space to copy the pkt in the current block and
> -		 * called prb_retire_current_block()
> -		 *
> -		 * We don't need to worry about the TMO case because
> -		 * the timer-handler already handled this case.
> -		 */
> -		if (!(status & TP_STATUS_BLK_TMO)) {
> -			/* Waiting for skb_copy_bits to finish... */
> -			write_lock(&pkc->blk_fill_in_prog_lock);
> -			write_unlock(&pkc->blk_fill_in_prog_lock);
> -		}
> -		prb_close_block(pkc, pbd, po, status);
> +	if (!BLOCK_NUM_PKTS(pbd))
>  		return;
> -	}
> +	block->retire_status =3D status;
> +	WRITE_ONCE(block->last_pkt, (struct tpacket3_hdr *)pkc->prev);
> +	pkc->pending_blocks++;
> +	pkc->kactive_blk_num =3D GET_NEXT_PRB_BLK_NUM(pkc);
> +	prb_publish_blocks(pkc, po);
>  }

[Severity: High]
Can a user process with the RX ring mapped read-write corrupt the kernel's
block tracking state by writing 0 to pbd->hdr.bh1.num_pkts
(BLOCK_NUM_PKTS(pbd)) while packets are in flight on the current block?

Because struct tpacket_block_desc lives in the shared packet_mmap() buffer,
user space can zero BLOCK_NUM_PKTS(pbd) while tpacket_rcv() copiers are
active on the block (or between the check in
prb_retire_rx_blk_timer_expired() and the check in
prb_retire_current_block()). When that happens, prb_retire_current_block()
returns early without setting block->last_pkt, incrementing
pkc->pending_blocks, or advancing pkc->kactive_blk_num.

Both callers (__packet_lookup_frame_in_block() and
prb_retire_rx_blk_timer_expired()) immediately call
prb_dispatch_next_block(pkc, po) on the next line:

	prb_retire_current_block(pkc, po, 0);

	/* Now, try to dispatch the next block */
	curr =3D (char *)prb_dispatch_next_block(pkc, po);

Since pkc->kactive_blk_num was not advanced and block->last_pkt is still
NULL, prb_dispatch_next_block() sees prb_curr_blk_in_use(pkc) =3D=3D 0 on t=
he
same active block and calls prb_open_block(pkc, pbd), which resets
pkc->nxt_offset to the start of the block and runs:

	atomic_set(&block->in_flight, 0);

while the earlier tpacket_rcv() copiers are still writing into that block.
When those earlier copiers finish and call
atomic_dec_return_release(&copy_block->in_flight), block->in_flight can hit
0 prematurely while a newly dispatched copier is still running, or underflow
to -1 and permanently wedge prb_publish_blocks().

[ ... ]
> @@ -2306,8 +2295,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct=
 net_device *dev,
>  	if (!res)
>  		goto drop_n_restore;
> =20
> -	/* If we are flooded, just give up */
> -	if (__packet_rcv_has_room(po, skb) =3D=3D ROOM_NONE) {
> +	/* V3 allocation must get a chance to publish completed pending blocks.=
 */
> +	if (__packet_rcv_has_room(po, skb) =3D=3D ROOM_NONE &&
> +	    (po->tp_version !=3D TPACKET_V3 ||
> +	     !READ_ONCE(po->rx_ring.prb_bdqc.pending_blocks))) {
>  		atomic_inc(&po->tp_drops);
>  		goto drop_n_restore;
>  	}

[Severity: Medium]
When the ring is full and a copier on the oldest pending block (at
publish_blk_num) is preempted or still in flight, does this check bypass the
lockless ROOM_NONE drop path on every arriving packet even though
prb_publish_blocks() cannot publish anything?

In prb_publish_blocks(), publication stops as soon as the block at
publish_blk_num has a non-zero in_flight count:

	while (pending--) {
		struct pgv *block =3D &pkc->pkbdq[pkc->publish_blk_num];
		struct tpacket_block_desc *pbd =3D (void *)block->buffer;

		/* Pairs with the release decrement after every completed copy. */
		if (atomic_read_acquire(&block->in_flight))
			break;

If a copier on publish_blk_num is preempted and subsequent traffic seals the
remaining blocks in the ring, __packet_rcv_has_room() returns ROOM_NONE
while pending_blocks > 0. Because tpacket_rcv() only checks
!READ_ONCE(po->rx_ring.prb_bdqc.pending_blocks) without checking whether the
head pending block's in_flight count has reached 0, every arriving packet
will take sk->sk_receive_queue.lock, call prb_publish_blocks() which
immediately breaks out of the loop, fail packet_current_rx_frame(), and jump
to drop_n_account where it triggers sk->sk_data_ready(sk) on every dropped
packet.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030081704.2516=
52-1-jingxuanxie@deeproute.ai?part=3D2
