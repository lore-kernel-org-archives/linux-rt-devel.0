Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81B22D4F0
	for <linux-rt-devel@lists.linux.dev>; Thu,  1 May 2025 10:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746094418; cv=none; b=JiXryk+WwrT4C1gYAdz+mFj8B3S+8piRac4GIQVCpaQV0T5PPswStgMVTw6UVll/aWmftL4YLB6UmVggGs/Ey0D3I3lbNh4MS/apnO2QfC1dMab7RmJYfmJUhAPZ1d6r4K7y8gTpF813J7xJhDPwfTkjT9OT/PGpnno2TVH66dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746094418; c=relaxed/simple;
	bh=2l/QmxsH+YGxcGpFMeCSPcOzGLYAZ/ECE5kxH40vnZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G5HfaYSTlNJFm2B5C+9dFdj0NgkL//bNfkBb+5gYBpOV+mOkZG4BeTo2EQ+Y+pArmYKB1sEJk2Ap7LQX/iQfhOW6LVmQMvBzlqs4jDIQoqgr9jRpylw49ZwSVIHvR7MRzHGxwnapu779cm9IXKwLhRC8q8spWIbUTbdYafYPP9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOLJgPLt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOLJgPLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746094415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+boqH3jMIoyB+S4qFE3D4u2O925uu+V0nhcw7bE3GY4=;
	b=gOLJgPLt/93r7dEaROSfuA7IbtkT/jrF7Dgb/hd9ZQkXarQs7MohKvBZZpQpy0CBh4po+f
	+3kAnbgXE0mFPfhsgD+JaeENkWr3e/VG9vOKsUjJuEd8cQgIlcOR3GDpNDoLf18IwcJ+Pd
	nYQ4MYrnxtBxmNuKNBvXIRj4nlxLzFs=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-pC-k7stlNeGhN9bwIbVEHw-1; Thu, 01 May 2025 06:13:28 -0400
X-MC-Unique: pC-k7stlNeGhN9bwIbVEHw-1
X-Mimecast-MFC-AGG-ID: pC-k7stlNeGhN9bwIbVEHw_1746094407
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-31b47704c13so3493131fa.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 01 May 2025 03:13:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746094406; x=1746699206;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+boqH3jMIoyB+S4qFE3D4u2O925uu+V0nhcw7bE3GY4=;
        b=d0syAHmd+pZuFHoQU/gLh1RSARXWNjnrtEbJ6A16yesfUxrcukydA7rdgNUi6CuTgY
         862YhyRli7qdzlZovlbjqIIgQ6kF+VYzI2H0yqNGemg3qspqJ1oqlV/cABVdWwFSye8i
         ku//pcc01j4gCJ8VZ5YdkU6jKcKwRCNAHIh7Oq+94+aL3sURLSxhwElKl2kNXu3OhPqc
         kF1l6F7T8hOEgqT0PW4IKxFV9eYm8Wu1dlymp2phm2vHS9WqHYTWbFu63K/iLqmsJgPr
         hejAqfFvfCSgF+rdYoZzWk0o0N8xUaA+hjLxVTslHVEBjOi4mHOOWJkzRa2P1FYpniBl
         HR2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUurVNZJUZi+MDAQJzXftKLJmslFQ8NufO0naUNNPXzAfZqqXtDeURd4lBa3/Yz4vqorUv+Kd40wCWmiARqmg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy//u+VUXoZnBR+W5fx9EYsq9Q6N1YN2SHhfM8PAAwbKwM5SesW
	S6AX8KNVUEEJ/aOSvGuBSFV3t+oWAtGE5YzLVSJi7EY8r0T81eJvtrrd2Mgn+eDxt8GxQ8gXf0c
	8MF6wIeJqsI3FNm6qrTCHRWY3Za4HhRtas1bJ+sq5rfc8wt58bRRfMvzgE4Bzg0Qp
X-Gm-Gg: ASbGncvVOer6xuDIppbT3rvomXWPuerMkSJnSlN6iYGFkpqXpwUIx3IdEncqZBmKFGD
	IH+pp2gNMXy+FKMycgpeD9w1HyuQcDhO4S42/jUX6jbEBpN5j+g4N1G0egT7dUsridLAzZbIE3V
	nsmCqEFaq21A91zQNSKhDZaXcppZl/GVaZBnwz7rxIZCfuzK8jjmkjL8iAxYLs2kAIMCP+jmUC8
	TlJwvhDRWpBdOKP/z5gw1WLHxeQEypR9DdnN8Nop1zY4QnjZiENMMw7kf4ZDkyH0WCZg2lu9IGx
	TEJqE8od
X-Received: by 2002:a05:651c:198c:b0:30d:e104:d64c with SMTP id 38308e7fff4ca-31f957abaf5mr6901741fa.40.1746094406540;
        Thu, 01 May 2025 03:13:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc2UPX1BFnJhpA8lfp7hWHbWdR3WeJHoV7vyckFWSd/+BKuvRRIDvwwjeftWP5ZTcbRwxOdQ==
X-Received: by 2002:a05:651c:198c:b0:30d:e104:d64c with SMTP id 38308e7fff4ca-31f957abaf5mr6901501fa.40.1746094406038;
        Thu, 01 May 2025 03:13:26 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3202a89f505sm539711fa.73.2025.05.01.03.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 03:13:25 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 540161A08244; Thu, 01 May 2025 12:13:24 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v3 05/18] xdp: Use nested-BH locking for
 system_page_pool
In-Reply-To: <20250430124758.1159480-6-bigeasy@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250430124758.1159480-6-bigeasy@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 01 May 2025 12:13:24 +0200
Message-ID: <878qng7i63.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LSsh7I1pfma2U8_cnRghVhQgmVGDAkfNgHB2hMmp_wg_1746094407
X-Mimecast-Originator: redhat.com
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> system_page_pool is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
>
> Make a struct with a page_pool member (original system_page_pool) and a
> local_lock_t and use local_lock_nested_bh() for locking. This change
> adds only lockdep coverage and does not alter the functional behaviour
> for !PREEMPT_RT.
>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jesper Dangaard Brouer <hawk@kernel.org>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/netdevice.h |  7 ++++++-
>  net/core/dev.c            | 15 ++++++++++-----
>  net/core/xdp.c            | 11 +++++++++--
>  3 files changed, 25 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 2d11d013cabed..2018e2432cb56 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3502,7 +3502,12 @@ struct softnet_data {
>  };
>  
>  DECLARE_PER_CPU_ALIGNED(struct softnet_data, softnet_data);
> -DECLARE_PER_CPU(struct page_pool *, system_page_pool);
> +
> +struct page_pool_bh {
> +	struct page_pool *pool;
> +	local_lock_t bh_lock;
> +};
> +DECLARE_PER_CPU(struct page_pool_bh, system_page_pool);
>  
>  #ifndef CONFIG_PREEMPT_RT
>  static inline int dev_recursion_level(void)
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 1be7cb73a6024..b56becd070bc7 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -462,7 +462,9 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
>   * PP consumers must pay attention to run APIs in the appropriate context
>   * (e.g. NAPI context).
>   */
> -DEFINE_PER_CPU(struct page_pool *, system_page_pool);
> +DEFINE_PER_CPU(struct page_pool_bh, system_page_pool) = {
> +	.bh_lock = INIT_LOCAL_LOCK(bh_lock),
> +};

I'm a little fuzzy on how DEFINE_PER_CPU() works, but does this
initialisation automatically do the right thing with the multiple
per-CPU instances?

>  #ifdef CONFIG_LOCKDEP
>  /*
> @@ -5238,7 +5240,10 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
>  	struct sk_buff *skb = *pskb;
>  	int err, hroom, troom;
>  
> -	if (!skb_cow_data_for_xdp(this_cpu_read(system_page_pool), pskb, prog))
> +	local_lock_nested_bh(&system_page_pool.bh_lock);
> +	err = skb_cow_data_for_xdp(this_cpu_read(system_page_pool.pool), pskb, prog);
> +	local_unlock_nested_bh(&system_page_pool.bh_lock);
> +	if (!err)
>  		return 0;
>  
>  	/* In case we have to go down the path and also linearize,
> @@ -12629,7 +12634,7 @@ static int net_page_pool_create(int cpuid)
>  		return err;
>  	}
>  
> -	per_cpu(system_page_pool, cpuid) = pp_ptr;
> +	per_cpu(system_page_pool.pool, cpuid) = pp_ptr;
>  #endif
>  	return 0;
>  }
> @@ -12759,13 +12764,13 @@ static int __init net_dev_init(void)
>  		for_each_possible_cpu(i) {
>  			struct page_pool *pp_ptr;
>  
> -			pp_ptr = per_cpu(system_page_pool, i);
> +			pp_ptr = per_cpu(system_page_pool.pool, i);
>  			if (!pp_ptr)
>  				continue;
>  
>  			xdp_unreg_page_pool(pp_ptr);
>  			page_pool_destroy(pp_ptr);
> -			per_cpu(system_page_pool, i) = NULL;
> +			per_cpu(system_page_pool.pool, i) = NULL;
>  		}
>  	}
>  
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index f86eedad586a7..b2a5c934fe7b7 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -737,10 +737,10 @@ static noinline bool xdp_copy_frags_from_zc(struct sk_buff *skb,
>   */
>  struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>  {
> -	struct page_pool *pp = this_cpu_read(system_page_pool);
>  	const struct xdp_rxq_info *rxq = xdp->rxq;
>  	u32 len = xdp->data_end - xdp->data_meta;
>  	u32 truesize = xdp->frame_sz;
> +	struct page_pool *pp;
>  	struct sk_buff *skb;
>  	int metalen;
>  	void *data;
> @@ -748,13 +748,18 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>  	if (!IS_ENABLED(CONFIG_PAGE_POOL))
>  		return NULL;
>  
> +	local_lock_nested_bh(&system_page_pool.bh_lock);
> +	pp = this_cpu_read(system_page_pool.pool);
>  	data = page_pool_dev_alloc_va(pp, &truesize);
> -	if (unlikely(!data))
> +	if (unlikely(!data)) {
> +		local_unlock_nested_bh(&system_page_pool.bh_lock);
>  		return NULL;
> +	}
>  
>  	skb = napi_build_skb(data, truesize);
>  	if (unlikely(!skb)) {
>  		page_pool_free_va(pp, data, true);
> +		local_unlock_nested_bh(&system_page_pool.bh_lock);
>  		return NULL;
>  	}
>  
> @@ -773,9 +778,11 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>  
>  	if (unlikely(xdp_buff_has_frags(xdp)) &&
>  	    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
> +		local_unlock_nested_bh(&system_page_pool.bh_lock);
>  		napi_consume_skb(skb, true);
>  		return NULL;
>  	}
> +	local_unlock_nested_bh(&system_page_pool.bh_lock);

Hmm, instead of having four separate unlock calls in this function, how
about initialising skb = NULL, and having the unlock call just above
'return skb' with an out: label?

Then the three topmost 'return NULL' can just straight-forwardly be
replaced with 'goto out', while the last one becomes 'skb = NULL; goto
out;'. I think that would be more readable than this repetition.

-Toke

