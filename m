Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793380880;
	b=bLh2BbYAlGEEoMnsy8D/MeowEIPeldDMpTLj1dmgxJ/l7OqFiDY1imxEsxU+dZe3paij
	 cAWHJg+SWvvNKthpCJong3yIH9yak9NlTtGl4eHIurn0KGkjb2qoXOd+Rw2WU591rW6lQ
	 7CyYm0m78nQSQ1OeFIoc/qfV9DkudsB/c3ehGtLxMH2DCg8LpWPBBjFkLlz0HAVANlgXi
	 SLaKhm28PCIxZqxOeAv6C95VgAMN+135f7xmzQx5Maw1cH1XadF/wfNP213vmukCkknh7
	 P6GG5l75xoUItDLOQeyleqPD2vrgvzR2Gtt4mzVPrPpyxZ2BHRIqNoqIh3xrCYs7FnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793380880;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VxyF/d0tbyiABUKo5yoe5ji6zMNg4n+kmjLnR2dR3BI=;
	b=r86x90YRbWNpyA56a9ou3vMRaFYy+vKQvThVT5rqMRvHpZxegY6uDFGjUxAuvFHaPR/l
	 Kbcxgd1C88IWmkwKhJ8VHN7lrGtFT75qYn6bz5fwGR6nDg2/K0TUqBeNLIwNovd5PsbYt
	 EKU/5vMQV80Z9HM9JRyPkT2Hhs0llWdys54DXseqQSeoYawefL/QmyJ/F81yEa3pRYP3R
	 ZnU6BY1laodqoGDrWs2b2O+Ahvj69Li8wxmoOETZ2kdPJYVKqGX/hDZ1f2qDuI1o7pTFk
	 sHBEP7WMCNKA3sNXsY/G4uIItQbj82edDJqDoYwzrf6zSG9uHgGfxYm/qoFMePI3frg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1jYcdos;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C11606A31D
	for <linux-rt-devel@lists.linux.dev>; Fri, 30 Oct 2026 17:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C11606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U1jYcdos
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5ec6f271883so492807e0c.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 30 Oct 2026 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793380879; x=1793985679; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=VxyF/d0tbyiABUKo5yoe5ji6zMNg4n+kmjLnR2dR3BI=;
        b=U1jYcdosGIgFI9jfMMK+5BvkYovCF0e1KekOKHF4hqnleaXNrjb6tMWYcSGw3fXWWi
         sIkEpR8ZBi6YIMztymIYm4WNcVm1cv/21G4O0Pe3MAj8QEXjPOWQVo+f9Rx9UTyRj2n6
         Y52X8oHzGzvCeWotkoC35I763+pxGUu7gSRESBekhTimPe0hhRrcYe2xwHLWFEZeyiU/
         4IPp79YmAx4CnlC4cE2VctwG5MCMM0sjgmaPHR9Zej80vlC7alILucKag3hSkyUIG+qK
         LuAYjg/RHxu12dPHA63dd6GV1668GzVhul9QrmnEhtsxpKwf/xFXFORLZ93fmZlwTKIi
         Hqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793380879; x=1793985679;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VxyF/d0tbyiABUKo5yoe5ji6zMNg4n+kmjLnR2dR3BI=;
        b=yYV8Uh5QfrGj/0o77apZm9PVjpEGkw8YPc2R1NySNB0ADpPgICWJMLe0TwFBA+qsJO
         KPHpnBfiYxsb6LB9fby0AlQIl94ChbUnj2MSIfuv5KOFMGmAeSJKTqCQfFkASEgr5u/r
         4CgEObtNtIBZnwdbqZXdGWtF5R0+z5sBTz9R+uZWPgimuSigX2V4O1066sJL887lKzo/
         IbMmH9/Yp3cO66/BlorqJGBw61z49RlUyhQTZ8JikhZdNOh7P5taOmp66bdVOIJTdgH5
         GwcRcNSfelBFPoRbPaQxe+HSfuw1nA+j2Z7j0Nu5UmvCaD62C32v8WVa4PU5pBZdtoUt
         tqCA==
X-Forwarded-Encrypted: i=1; AKwUvByow6pm4ZtUTtTNSYULrqKlWK9iO/rDAqbjwNbeQHv1F/tEI4/uE5fFzeGGSeHuAeOsu6kMUJFZa+8X07LPtw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJnrU2ZlISJ/xbhdMNFWncjDqs9yUNdS74N9WN9aBSwqLjYehIZ
	QICMvEHoITyPPFep+4Ma8g4UReMpfJy3FNCT3ZCfm3Gvnywbfsei01Uq
X-Gm-Gg: AYBFou2Hrc6g1yJ6mUREHFvbLQmeytO0gK50WkcAjqIFmnQV0u3FeOmasEMqzQIKdcn
	w/5AL3CKm8xHnx/dFPCAWD6L/AJ9LCtIcqBgUxj2cFmek2C79UIpMOAG19KrdSzuZQQbLE6+3FA
	yR2bCKE73nVMI61gG5zzKtfMuQsJ/pN/qyc18Ar3PEPVPIj7PrKWP2StZrZc+TnlP5BzbBNwSTy
	bSckMshr1ag12AezCVxh78dPnDBxvdkYm0vre/JAIlGVysYbPBK67QPM2uEET8fQvuO1DW5rg87
	VbJHm36OneTRJNpPePSYpQAEo8Cz66j2Vb8TzCOtKqyiiNaQu3929Y3+SGpoxMuJkF1I9/TQgkw
	8RqfbFfHAvFrDOZjNZUVAbmA55ya71zy7FBXFk0G7MqtF20E+Gm0W36VbVZL4Jq06R+C9xqPXSe
	pMzdp2/FulR/AEvGtRH5ydFdY0rjWz/LA9ayF2IP2CNGFCNbLC3bIP0Bq7A0KrLws0pbj8mOJ5C
	wHetk9tm9droxAITtLHKQQOzCd0mcOOKorAnazNKFNvOeD9pgR1Qek3Si6e0JlEZg3cEBjNEUhC
	nuYmNy/Jaqn5e9Q+btS2dl9cQGN7B3aHpxDS5cbUjXI56MF1RSl0Cerv5F7m2Bfbv+gID/pmhnr
	+oEfIwhXIVSWzUbUrlxDGXMxGFu6/0k/ReM+SmcjtRYTXtST1osMh1rIEZIsnTR0O6Crb
X-Received: by 2002:a05:6122:3a03:b0:5ea:c722:b3a with SMTP id 71dfb90a1353d-5ec6871d778mr1795867e0c.7.1793380879159;
        Fri, 30 Oct 2026 10:21:19 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69803be7sm3127076e0c.0.2026.10.30.10.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:21:17 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:21:17 -0400
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
Message-ID: <willemdebruijn.kernel.17d3748debf8b@gmail.com>
In-Reply-To: <20261030081704.251652-2-jingxuanxie@deeproute.ai>
References: <20261030081704.251652-1-jingxuanxie@deeproute.ai>
 <20261030081704.251652-2-jingxuanxie@deeproute.ai>
Subject: Re: [RFC net v2 1/2] af_packet: prepare the virtio header before
 reserving an RX frame
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
> An RX virtio-header conversion can fail after packet_current_rx_frame()
> has reserved space in a TPACKET_V3 block and increased its packet count.
> Releasing the copy lock on that error path does not remove the incomplete
> record from the block.

Can you give a little more detail on the exact bug: what state does
not get reverted on error, and how problematic is this.

> Prepare the header in a local variable before reserving a frame, and copy
> it to the reserved frame only after conversion succeeds. Keep drop
> accounting, notification and copy_skb cleanup on conversion failure.
> This also keeps conversion out of the receive queue critical section.
> 
> Assisted-by: LLM
> Signed-off-by: Jingxuan Xie <jingxuanxie@deeproute.ai>
> ---
>  net/packet/af_packet.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 823e0911c910..7b3e1e27f777 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -2273,6 +2273,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	__u32 ts_status;
>  	unsigned int slot_id = 0;
>  	int vnet_hdr_sz = 0;
> +	struct virtio_net_hdr vnet_hdr;
>  
>  	/* struct tpacket{2,3}_hdr is aligned to a multiple of TPACKET_ALIGNMENT.
>  	 * We may add members to them until current aligned size without forcing
> @@ -2375,6 +2376,14 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  			vnet_hdr_sz = 0;
>  		}
>  	}
> +	if (vnet_hdr_sz &&
> +	    virtio_net_hdr_from_skb(skb, &vnet_hdr, vio_le(), true, 0)) {
> +		drop_reason = SKB_DROP_REASON_PACKET_SOCK_ERROR;
> +		atomic_inc(&po->tp_drops);
> +		sk->sk_data_ready(sk);
> +		sk_skb_reason_drop(sk, copy_skb, drop_reason);
> +		goto drop_n_restore;

Probably prefer a goto drop_n_account_unlocked rather than open coding
that here.

> +	}
>  	spin_lock(&sk->sk_receive_queue.lock);
>  	h.raw = packet_current_rx_frame(po, skb,
>  					TP_STATUS_KERNEL, (macoff+snaplen));
> @@ -2388,16 +2397,9 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  		__set_bit(slot_id, po->rx_ring.rx_owner_map);
>  	}
>  
> -	if (vnet_hdr_sz &&
> -	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
> -				    sizeof(struct virtio_net_hdr),
> -				    vio_le(), true, 0)) {
> -		if (po->tp_version <= TPACKET_V2)
> -			__clear_bit(slot_id, po->rx_ring.rx_owner_map);
> -		else
> -			prb_clear_blk_fill_status(&po->rx_ring);
> -		goto drop_n_account;
> -	}
> +	if (vnet_hdr_sz)
> +		memcpy(h.raw + macoff - sizeof(vnet_hdr), &vnet_hdr,
> +		       sizeof(vnet_hdr));
>  
>  	if (po->tp_version <= TPACKET_V2) {
>  		packet_increment_rx_head(po, &po->rx_ring);
> -- 
> 2.25.1


