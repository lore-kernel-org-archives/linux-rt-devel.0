Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE3275B1B
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853428; cv=none; b=Aox3MbEyP6mY61AX0rOdmWmZZN0tgknX4Mc+LeS5K+ZbEsSRvjW40+1YhO3xloreMwmwvUjSb6PZQxm08j3HwqrcVXMDSiFNf6OZpFNu0P5VZkN259iVKvscFgkgSnQAm328IfsoFRaD7H0WvfEzAUFBVOf/Yt4jr+MbOGFDIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853428; c=relaxed/simple;
	bh=VJ0ZObnZaXxnRWhbjNFj5HtFsZcyPM2WWMoCiOu53IU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=W6a8zxiCLSiYKxRQF2JVMQ58dPjf5iqtWHc68AFHX7FlnC0vYwLBFVbChe4G+0h3onJelb5LrbHUwY+ZUTUorWl5BXkq9JhCzZTYA01ZHG7xoFpVa0OozdvTRiDvq2mMSdYbtwKmEzYJBzTFLmcs19loZf3AQ5cVBSG8gvAoVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/pCd+DB; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/pCd+DB"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7f04816589bso542878985a.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756853426; x=1757458226; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtLQPpLxI6ZjgQLK+QJDLph+ec5t3i/JbVs9rfBJ4lI=;
        b=H/pCd+DBNGI+c5fGctRtW4cXc1XDR/vb646sAKIbMnMwFISptaqFRaf9HnTcdGVR9x
         Qu0GS+uOcRXBx2wvMvXcjc7iD7QMXFJuDNeqD3CJ7gGUwuBYDBH9xCCZ2U8pmI6xHEK4
         YTCuvp0l1vp9pFnKJ+3ZFpwFB2vhF4T88h/hZT6xluG+vHIgvNPnTq9e/jD5dvVk/83W
         Zirk3WSFuMelYD+kgp7QoU/4p8KppkvopFY0NBpxxY/vPlGO7W5qsHv62/ri+YiZHBal
         7qoIquff3bPIF49zmUy5UN97Gixu1i/AH9OYZyucX0g3WI8JNwWZAIt67LZQW3ljXzg0
         c1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853426; x=1757458226;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WtLQPpLxI6ZjgQLK+QJDLph+ec5t3i/JbVs9rfBJ4lI=;
        b=eK5l0AWfJF21hAakA455qXtwtWFLrbbA/0sy16QhfmM+3azJO4kS/p6+MMWAPdjH9n
         2w6+a2OYXylgnmvMQ2xWlJLDIPn8fpHEtOtltLD5oCsD63UeVTPz4lW8cuAYw4lq0HH+
         Vx/x6eMsm+1K/wz8JdV4KnL4azerNyGh+7+4OqP5Qe4ysQBsuq3vlNfWQ2ip1BBNvna4
         mmuNMfZNh6ABadIP3CVJBFhFSmr6dAldfTyThCQFvIvG3WJfcR6wVw3gzJHWDmr5Kaxf
         nco8xGYJvavndLjORumRepwC6T5lCW/xMHDQzaG4/pHrgkTIJptWVyqFSEc+1huH7irH
         LdJw==
X-Forwarded-Encrypted: i=1; AJvYcCX175QxwCtVSBeIlTJeGpMbbN1dEsBafbi+OBI2CfxXP01LzaLa/Eokytd7IZB24LKRP+dP05MUV1E6majuAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyikvJleAE/0i4avjS4PLS4UkN//6p8MdhfX1gJZcYpqmRDeZAR
	Orm394CUc91CmGZwVx1WNAWs+fqGK5lQpijBx6AkZnXUAoGMYoXDvk15
X-Gm-Gg: ASbGnctgXYlH6MpZBzgNxK0u/Goa2JBPh8Eyz4Iws9CmOv9BbVTkVmXTo5VqIyF32z9
	uf520CRT1sB9aPpSSOTlaQzTkEydxcuPy5LNELc4/bYn0Jy/33vAhsaFs4ZVzWi7jdG2e1ONXW/
	gS4bUYOfapX7x0cxBMDjk094EVi8WORLxtqupyuTx4xeVhF2GpgKktfSf/NRHNky6VnSIG/tpp+
	p01ApExDb0LeD5csQ0TpDm/6aexOAuBfmP1Dbx17psrcndazaJINvAN/4bDYF6sLWR8smkL6e6+
	kvsn6dWDizNWojBxw7XHVg0sXd8CTIcp54aq3U72SDKGJljuA082Wm8I7/k1fbJEVWPCNsEkly6
	rMJsDuR53SYhIua3t6t0dpCZJNlupDeoayDvHiAsXcxKzHZcVdrLJvqBSgC3h7fQHlxiuSyjVBX
	qI/A==
X-Google-Smtp-Source: AGHT+IE/kWt363/ZQE1Nw+pZybIpAW8G7ekOjiHkWmjQlOxKd2fohOCAbHVaJtwx8UN+tV0ugk5yyQ==
X-Received: by 2002:a05:620a:1a21:b0:7e8:74d:fdf5 with SMTP id af79cd13be357-7ff26f9fd2fmr1459440885a.4.1756853425989;
        Tue, 02 Sep 2025 15:50:25 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-80aab5a062fsm20291285a.48.2025.09.02.15.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:50:25 -0700 (PDT)
Date: Tue, 02 Sep 2025 18:50:25 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, 
 kernel-team@meta.com, 
 efault@gmx.de, 
 calvin@wbinvd.org, 
 Breno Leitao <leitao@debian.org>
Message-ID: <willemdebruijn.kernel.9ee65133b4b7@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-4-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-4-51a03d6411be@debian.org>
Subject: Re: [PATCH 4/7] netpoll: Export zap_completion_queue
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Breno Leitao wrote:
> Make zap_completion_queue() a globally visible symbol by changing its
> linkage to non-static and adding EXPORT_SYMBOL_GPL.
> 
> This is a true netpoll function that will be needed by non-netpoll
> functions that will be moved away from netpoll.
> 
> This will allow moving the skb pool management to netconsole, mainly
> find_skb(), which invokes zap_completion_queue(), and will be moved to
> netconsole.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  include/linux/netpoll.h | 1 +
>  net/core/netpoll.c      | 5 ++---
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
> index 65bfade025f09..7f8b4d758a1e7 100644
> --- a/include/linux/netpoll.h
> +++ b/include/linux/netpoll.h
> @@ -75,6 +75,7 @@ void __netpoll_free(struct netpoll *np);
>  void do_netpoll_cleanup(struct netpoll *np);
>  netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
>  struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
> +void zap_completion_queue(void);
>  
>  #ifdef CONFIG_NETPOLL
>  static inline void *netpoll_poll_lock(struct napi_struct *napi)
> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 9e12a667a5f0a..04a55ec392fd2 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c
> @@ -50,8 +50,6 @@
>  	 sizeof(struct udphdr) +					\
>  	 MAX_UDP_CHUNK)
>  
> -static void zap_completion_queue(void);
> -
>  static unsigned int carrier_timeout = 4;
>  module_param(carrier_timeout, uint, 0644);
>  
> @@ -240,7 +238,7 @@ static void refill_skbs(struct netpoll *np)
>  	spin_unlock_irqrestore(&skb_pool->lock, flags);
>  }
>  
> -static void zap_completion_queue(void)
> +void zap_completion_queue(void)
>  {
>  	unsigned long flags;
>  	struct softnet_data *sd = &get_cpu_var(softnet_data);
> @@ -267,6 +265,7 @@ static void zap_completion_queue(void)
>  
>  	put_cpu_var(softnet_data);
>  }
> +EXPORT_SYMBOL_GPL(zap_completion_queue);

consider EXPORT_SYMBOL_NS_GPL(zap_completion_queue, "NETDEV_INTERNAL");


