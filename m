Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980739;
	b=TdyNObtJnnBTEEUnApaweUAJ9A9jlYC6KWsRK4xdEShuF0xsgiUr1tBOvAppO/6dsCsj
	 be/DMl50InQvU5sojRbu0MaeK4dAgCZVUB9dZPOvNfLl13xGihqgH2G/fPc302B5wZKa9
	 maGnAej4gvvfPWeNdWPNbCCH3XU2Rqu9MPpcPgJ2j3FJ+VsqzAJp9z3KsERJUTFAd0983
	 ldYvCE0YbxU/oZrCjEqolF6Yuupv+8eW+YrD3OUmFRVjYe79q0f5Nl6uDiGqh2SRkJToT
	 Juu+6CJ+1rF7SyxScguFGcr7H81bLJe3qNyZc/n5Jdc54fVBgApFcv56VQRjkooLWUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980739;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=h0FLNe7OgMvWwaVPDLaJN55GeCrtAhkwCaQBCaPz6Vg=;
	b=4uKBgyh1btaUHfb2cj+B7txNtgkiWaaEojN76kF+fFy1x3dTPrS7ZbyZFFD3dnHIR0a+
	 5ToA0Zt2Og97AA+ix2r1NAY/ojkoSIttzJvrCjWfBfKFeXdqt7rcT8wrR8gs53NiHSsI4
	 zobKCn1j5/FchYdIWrHwbv2cRdxYPFcvo079pyZhMHurX12x+qx7An/4NasMGDnJAhl1a
	 FbSqOdp3w2SBpJXy+G2ChI0/c09t+dM3USAXr43RXe7OR1yLJpJ+8O9kNo/ue4YbJWCSN
	 g+b0OGktBLqasDGoCRazK90U1Ofe8+uqAvFXUaxJMjCU6KjX3ccwxkBn7vsdxj4CA8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DCfJJyQI;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8021606A32C
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 15:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8021606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DCfJJyQI
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5ead9f60e26so1870199e0c.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Nov 2026 07:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793980737; x=1794585537; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h0FLNe7OgMvWwaVPDLaJN55GeCrtAhkwCaQBCaPz6Vg=;
        b=DCfJJyQId3+cCTkN6XKZm3QpGqgELWe6H65MH9dDnp9v2vLlJ5KgJSjr8u8SMdrLK9
         IyzbtFY1IA3RvRaWvUecnTCSBLSRB/SegCb0BKfZtI7Ri7jWPDdyhSeZKa7hhzVVVF3/
         lzctARSjbiQYdqhWwpDjADJtWNVsBQXODcsHAxU0/E7gk0E2yh3yPgO1arWXq+jQV27L
         W6/QrgxuKZUSk6HdixMHA/spaCj5tZEW9M+GVOuafLb6Zn1LFa1lrEK+wx/luboPDbAR
         ANHqEMYEJddXKVQgvmRMdRqyi1CBvm3NDI+a6UtylSlT15Hqqlc6y2myqYMJDJOFV8iy
         YQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793980737; x=1794585537;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h0FLNe7OgMvWwaVPDLaJN55GeCrtAhkwCaQBCaPz6Vg=;
        b=s7Z9C4+QCXceFGOApOy9AniUl0maR0ugnxsSQ04Hpx6mcdYe1hasmxnC6MAZUWp0NT
         mIFdJ/7fAApV46FpGPxUyCVkUhfqzWIDEUU259yHD0qQtilpfNVJen2xpyztaowyYx4p
         KmgQ1mIAHcTd32xodbLg/7yvt55hqoQi3amUwd8Xatdn6I0Nv8PU5gSrSdoEl6u9CDVm
         BbLCdxHlHhVy6XHQvM7LOOYCT3nPjTFAIeX5gAx3XWk5aZxmaPV+7idaGkSnpw5zfz6o
         WoJAYS5a/s7hTDUFqO9T2MZON5LHV3JYmRkFT0/JCDB5annNo2WH2+7Wrv8t78iCM8je
         Plwg==
X-Forwarded-Encrypted: i=1; AKwUvBwSfZnAKLFW2EwJXttCWg/BlhcwpP4/2kHFcuAWgTQc3dG9E+m2q31TyB/+oP3+gbH0M8Lw0D+WtvBzZYKbIg==@lists.linux.dev
X-Gm-Message-State: APuU4Z89ZENIDYN0FOcki31h8p1+aKa43jYrxJO6vVeEOalw08CGZj2A
	ciCV91VcEVihcDnd7H7xzd/Fm5Rt36kASI8BOUvmtiTo86vZY1dtrwnT
X-Gm-Gg: AYBFou3lZEGpPp87DjCrxxXD0qFy4k1ROYx9XBdQArvAa9Ixp35hQhzA4luzvJ78lEz
	icR1p8T2bpb2nx+tJWhdJ2NVPNGuuo/+bp30bcRPd8NC1Aku8IKxmxD0dzgpBpLt0dco0dB6BTW
	yjepZmjFvFCwGYl6MBK3e9oYubgEgEszbiPaGtoFjb/VYw4zeG4OLJxsDORr9kfGDfnhcSGIGE7
	rjKZ4CHM8DopFJDlsS+nXwWCDtTA6eYSl0MELsfwXGEzVXRN0XNV/6bSw/hdzor0RD2c/Pg8ttf
	tpdwn8v5CjznRJe+ZGbwo0IDKSkeeuLjtmgO7JtwS8dirOYPPygGptKch3QCp4lpOGjuXmXpBSD
	PkmPTL5vF002ZVUdzEwA3qrjYoQCSR+BXM6QuuFyEL0JxzKPNcn8Nfu/pV06s1OSREgyW0AFZgP
	JyAncx/yNcctF3lZQdwV83scDOjwZi1qpLcT0rtYt0si2ieNub1RzEAhBX3fjLEOWyuphT9TzMx
	r3ndY9u1pVkKwgLQS5f3HdH1s7IJi9cHvwe8k6T+KOniF9OxLVRyUG+sOHc+Aaj5Czo+2Gb9AwJ
	u/v8oLSuTNmjQ/O/9oae7LluZpEt6hoz16ePyzuYdyhr+rAIdIsG9fwMimMPL9JCjWbzwQs184I
	Kje78sd672kUuBN9GaqKMuofO73aXFduxYvPDCY9mGIIcCFvbg5QaoFvsQl9AiyG1jFnNtNo=
X-Received: by 2002:a05:6122:c25c:b0:5ea:be49:f93 with SMTP id 71dfb90a1353d-5ecb428be54mr2464694e0c.11.1793980737461;
        Fri, 06 Nov 2026 07:58:57 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64cb602sm1627480e0c.7.2026.11.06.07.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:58:56 -0800 (PST)
Date: Fri, 06 Nov 2026 10:58:56 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jingxuan Xie <jingxuanxie@deeproute.ai>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev
Message-ID: <willemdebruijn.kernel.112eb85986c12@gmail.com>
In-Reply-To: <20261103092541.273847-2-jingxuanxie@deeproute.ai>
References: <20261103092541.273847-1-jingxuanxie@deeproute.ai>
 <20261103092541.273847-2-jingxuanxie@deeproute.ai>
Subject: Re: [RFC PATCH net v3 1/1] af_packet: avoid waiting for TPACKET_V3
 copies at retirement
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jingxuan Xie wrote:
> From: jingxuanxie <jingxuanxie@deeproute.ai>
> 
> TPACKET_V3 retires a full or expired block while holding
> sk_receive_queue.lock. prb_retire_current_block() takes
> blk_fill_in_prog_lock for write to wait for in-flight copy_bits()
> before publishing the block.
> 
> On PREEMPT_RT a copier can be preempted while holding the read lock.
> The packet path or the retirement timer then blocks on the write lock
> while holding sk_receive_queue.lock, and the receive path resumes only
> after the copier is scheduled again.
> 
> Try to take the write lock without blocking. If a copy is still in
> progress, leave the current block and its metadata untouched:
> 
> - the retirement timer re-arms itself and retries after the configured
>   interval;
> - packet allocation returns NULL, so tpacket_rcv() drops this capture
>   record and accounts it in tp_drops, while the original packet remains
>   in the network stack;
> - a later packet can retire the block once the copier has finished.
> 
> Do not dispatch the next block while the current block is still open.
> The existing lock order and completion ordering are preserved, and no
> new state or worker is introduced. The trade-off is a higher capture
> drop rate while a copier is preempted; original traffic is unaffected.
> 
> Fixes: 632ca50f2cbd ("af_packet: TPACKET_V3: replace busy-wait loop")
> Assisted-by: LLM
> Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>

No need for a cover letter for a single patch.

And a v4 will be needed, because this is sent as RFC.

> ---
>  net/packet/af_packet.c | 24 ++++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index cf6429f09477..8fd6372ab59b 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -200,8 +200,8 @@ static void packet_increment_head(struct packet_ring_buffer *buff);
>  static int prb_curr_blk_in_use(struct tpacket_block_desc *);
>  static void *prb_dispatch_next_block(struct tpacket_kbdq_core *,
>  			struct packet_sock *);
> -static void prb_retire_current_block(struct tpacket_kbdq_core *,
> -		struct packet_sock *, unsigned int status);
> +static bool prb_retire_current_block(struct tpacket_kbdq_core *,
> +				     struct packet_sock *, unsigned int status);

no unrelated style changes

>  static int prb_queue_frozen(struct tpacket_kbdq_core *);
>  static void prb_open_block(struct tpacket_kbdq_core *,
>  		struct tpacket_block_desc *);
> @@ -711,8 +711,9 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
>  	 *
>  	 */
>  	if (BLOCK_NUM_PKTS(pbd)) {
> -		/* Waiting for skb_copy_bits to finish... */
> -		write_lock(&pkc->blk_fill_in_prog_lock);
> +		/* Retry later if a packet copy is still in progress. */
> +		if (!write_trylock(&pkc->blk_fill_in_prog_lock))
> +			goto refresh_timer;

Since this is only a problem on RT, and it introduces drops,
consider limiting the switch from write_lock to write_trylock to only RT.

>  		write_unlock(&pkc->blk_fill_in_prog_lock);
>  	}
>  
> @@ -738,6 +739,7 @@ static enum hrtimer_restart prb_retire_rx_blk_timer_expired(struct hrtimer *t)
>  		}
>  	}
>  
> +refresh_timer:
>  	hrtimer_forward_now(&pkc->retire_blk_timer, pkc->interval_ktime);
>  	spin_unlock(&po->sk.sk_receive_queue.lock);
>  	return HRTIMER_RESTART;
> @@ -946,8 +948,8 @@ static void *prb_dispatch_next_block(struct tpacket_kbdq_core *pkc,
>  	return (void *)pkc->nxt_offset;
>  }
>  
> -static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
> -		struct packet_sock *po, unsigned int status)
> +static bool prb_retire_current_block(struct tpacket_kbdq_core *pkc,
> +				     struct packet_sock *po, unsigned int status)

again, unnecessary style changes

>  {
>  	struct tpacket_block_desc *pbd = GET_CURR_PBLOCK_DESC_FROM_CORE(pkc);
>  
> @@ -963,13 +965,14 @@ static void prb_retire_current_block(struct tpacket_kbdq_core *pkc,
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
>  
>  static int prb_curr_blk_in_use(struct tpacket_block_desc *pbd)
> @@ -1097,7 +1100,8 @@ static void *__packet_lookup_frame_in_block(struct packet_sock *po,
>  	}
>  
>  	/* Ok, close the current block */
> -	prb_retire_current_block(pkc, po, 0);
> +	if (!prb_retire_current_block(pkc, po, 0))
> +		return NULL;
>  
>  	/* Now, try to dispatch the next block */
>  	curr = (char *)prb_dispatch_next_block(pkc, po);


