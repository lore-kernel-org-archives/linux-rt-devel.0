Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EEC13D2B2
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 May 2025 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746196401; cv=none; b=Ox1o8j+y1iYyVK3fxh2FNtpDpXrhDPQJV2/0xVt5Vqv/1cOMGGSwYYK56yzrpu3h0OewNe28H4+wvs7lQekTM5cdwOjKsn6RH6ZKN3dmWnJLbLXEF9isQyIkfa/E83UImvF0gOb5N+FcMES+bd81bO9vRSEsG+LqK2j/roXE0uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746196401; c=relaxed/simple;
	bh=A9gHf8PmrqRjGba3c4AmxwG2GmbqGfOhMYHdx9ZWyI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z/dEwaEtdebhSKU0unnYBCH2cLauC7PHDYjand9ahP2c9oRizTolq5NI2+seAe2vHI57zCygFPvcNlseP9baRiepqJYac1g4kDxi1wVAx2yB5EhyZhAOiVmoImhlAvXSFxkKAz8Z9DVqPGpxWG0OFod/rtIhThhzKp/ZLsGQgWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K58ax9lX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K58ax9lX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746196398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0I0LfSQ1f4C9/gRL4Z16YYyoZ235xIfBwJWYiH+Qtwk=;
	b=K58ax9lXFZu4rV6fk+f0XhTBVzbGq3Gp2DpDD1JlNsULcc43YtCZwmdno72wa5q6ydxysK
	KF7GfbEs3Cnh8AvfvBDbwbLNmYC7gaXBmiOWZpEjCI3qCua7qSO8QIhwqeqreI5OLRGf5/
	wb0KopoCu0lZINF2S1A2K86oK/YfEfg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-lWkXntZIMymxAs3XdHkvgQ-1; Fri, 02 May 2025 10:33:14 -0400
X-MC-Unique: lWkXntZIMymxAs3XdHkvgQ-1
X-Mimecast-MFC-AGG-ID: lWkXntZIMymxAs3XdHkvgQ_1746196393
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-54b0f0a88d5so872647e87.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 02 May 2025 07:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746196393; x=1746801193;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iidq5caE2qrMnaUyfRtrVUdIHj/SGDnk/ds3ljYLCTU=;
        b=sXCRyOwYVcp3sdt+n5c0TYKdCn6JyJF+aEfFg0Law44SfkJYXh2TFd7kbLWSYP2Oft
         dwCcnoDKu6GfVbKmXMAjk7KMx7VXsEP2AFE9xxxJhIoOUqMgJpLIXszHi7nA/kQqNJYN
         NcRwTpFtrTxS5cqbWPP+G3rvdPYRIoIdoFZJR1Y3y+9uVww9ODj3g/f7on3/OTyLC+4m
         l6Yk7PFmEhFenPWx9+aR2Gf/XvvCiItHkRa1mPRz4Y/TZIYTw/9BJd64GL+am+zx+4hX
         qPjoqwna/fIUNK/i79jlDQOzAbZTaDF1tKiyIEHSmEAG+dac1G/YuGW/sUr/W9b6isMp
         eemg==
X-Forwarded-Encrypted: i=1; AJvYcCU46SB4TwUG20+xjo3MLuklr8E7wge+ngM+P77Ln788tjcRl19R2zlCFH7VYzljgXjFhja8EFojQdQxc91cUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG/9evglzUlYuJTniUOKCHlAP3aj7xDo8a95sPewRGWY8eWrb7
	3iVvUk4nZhJh2AYsIU5kSFigW8EbKlfpmV23Du/YXRMI5bT1a18rWr0ch5VcPJkr/WVrgQ4DJLv
	G+ZFBeardYZr/2iXtpxKJ869vWNkC0RRUIuUWScr/IJkMihJI3xCMi8E51V26hcCQ
X-Gm-Gg: ASbGncuKCqtawAtNjFPrSJYnJgk6lrhGrS9zz/+cP0bSORomLcAYq+M0PTItsWriUBl
	lTSq44urUn1IWG4Z0/K8FOzrgzcp2B1SfyI6mc/GCCybDkC2af2hKA1RaDwn5xXI83baHK0+7JX
	sIINE4ck+E/w6ly5eFprrtIkay2y0DKiox9yy1dyJvWrbw3NS7BHWGJYXTyq2bfgwPO8UARLEUX
	vm+vqpgH0VpuUwLviev3XXkbUhkdzridpNgKvZ4ki57gYcC38ELpkKydMWO+og3fxRdwQ3xhkRN
	Ki4xg/5sBbNTN0bka+5CVWshEl4ej5vD+GEU
X-Received: by 2002:a05:6512:b22:b0:54a:cc11:b558 with SMTP id 2adb3069b0e04-54eac20ce44mr844940e87.33.1746196393303;
        Fri, 02 May 2025 07:33:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxZP3x8CctExY8BKU1Krhhw8vg7FGAq7GpbD015fqIistJw782m5FQTvV2H/OW0LrIz3wBow==
X-Received: by 2002:a05:6512:b22:b0:54a:cc11:b558 with SMTP id 2adb3069b0e04-54eac20ce44mr844927e87.33.1746196392826;
        Fri, 02 May 2025 07:33:12 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94b17d6sm364278e87.6.2025.05.02.07.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 07:33:12 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DDB061A0851B; Fri, 02 May 2025 16:33:10 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH net-next v3 05/18] xdp: Use nested-BH locking for
 system_page_pool
In-Reply-To: <20250502133231.lS281-FN@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250430124758.1159480-6-bigeasy@linutronix.de> <878qng7i63.fsf@toke.dk>
 <20250502133231.lS281-FN@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 02 May 2025 16:33:10 +0200
Message-ID: <87ikmj5bh5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YrYiDzc-hx802ETt2lCMLnxw9b8PtKMyvhY1Ql_P1r8_1746196393
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2025-05-01 12:13:24 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > --- a/net/core/dev.c
>> > +++ b/net/core/dev.c
>> > @@ -462,7 +462,9 @@ EXPORT_PER_CPU_SYMBOL(softnet_data);
>> >   * PP consumers must pay attention to run APIs in the appropriate con=
text
>> >   * (e.g. NAPI context).
>> >   */
>> > -DEFINE_PER_CPU(struct page_pool *, system_page_pool);
>> > +DEFINE_PER_CPU(struct page_pool_bh, system_page_pool) =3D {
>> > +=09.bh_lock =3D INIT_LOCAL_LOCK(bh_lock),
>> > +};
>>=20
>> I'm a little fuzzy on how DEFINE_PER_CPU() works, but does this
>> initialisation automatically do the right thing with the multiple
>> per-CPU instances?
>
> It sets the "first" per-CPU data which is then copied to all
> "possible-CPUs" during early boot when the per-CPU data is made
> available. You can initialize almost everything like that. Pointer based
> structures (such as LIST_HEAD_INIT()) is something that obviously won't
> work.

Right, I see. Cool, thanks for explaining :)

>> >  #ifdef CONFIG_LOCKDEP
>> >  /*
>> > --- a/net/core/xdp.c
>> > +++ b/net/core/xdp.c
>> > @@ -737,10 +737,10 @@ static noinline bool xdp_copy_frags_from_zc(stru=
ct sk_buff *skb,
>> >   */
>> >  struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
>> >  {
>> > -=09struct page_pool *pp =3D this_cpu_read(system_page_pool);
>> >  =09const struct xdp_rxq_info *rxq =3D xdp->rxq;
>> >  =09u32 len =3D xdp->data_end - xdp->data_meta;
>> >  =09u32 truesize =3D xdp->frame_sz;
>> > +=09struct page_pool *pp;
>> >  =09struct sk_buff *skb;
>> >  =09int metalen;
>> >  =09void *data;
>> > @@ -748,13 +748,18 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp=
_buff *xdp)
>> >  =09if (!IS_ENABLED(CONFIG_PAGE_POOL))
>> >  =09=09return NULL;
>> > =20
>> > +=09local_lock_nested_bh(&system_page_pool.bh_lock);
>> > +=09pp =3D this_cpu_read(system_page_pool.pool);
>> >  =09data =3D page_pool_dev_alloc_va(pp, &truesize);
>> > -=09if (unlikely(!data))
>> > +=09if (unlikely(!data)) {
>> > +=09=09local_unlock_nested_bh(&system_page_pool.bh_lock);
>> >  =09=09return NULL;
>> > +=09}
>> > =20
>> >  =09skb =3D napi_build_skb(data, truesize);
>> >  =09if (unlikely(!skb)) {
>> >  =09=09page_pool_free_va(pp, data, true);
>> > +=09=09local_unlock_nested_bh(&system_page_pool.bh_lock);
>> >  =09=09return NULL;
>> >  =09}
>> > =20
>> > @@ -773,9 +778,11 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_=
buff *xdp)
>> > =20
>> >  =09if (unlikely(xdp_buff_has_frags(xdp)) &&
>> >  =09    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
>> > +=09=09local_unlock_nested_bh(&system_page_pool.bh_lock);
>> >  =09=09napi_consume_skb(skb, true);
>> >  =09=09return NULL;
>> >  =09}
>> > +=09local_unlock_nested_bh(&system_page_pool.bh_lock);
>>=20
>> Hmm, instead of having four separate unlock calls in this function, how
>> about initialising skb =3D NULL, and having the unlock call just above
>> 'return skb' with an out: label?
>>=20
>> Then the three topmost 'return NULL' can just straight-forwardly be
>> replaced with 'goto out', while the last one becomes 'skb =3D NULL; goto
>> out;'. I think that would be more readable than this repetition.
>
> Something like the following maybe? We would keep the lock during
> napi_consume_skb() which should work.
>
> diff --git a/net/core/xdp.c b/net/core/xdp.c
> index b2a5c934fe7b7..1ff0bc328305d 100644
> --- a/net/core/xdp.c
> +++ b/net/core/xdp.c
> @@ -740,8 +740,8 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff=
 *xdp)
>  =09const struct xdp_rxq_info *rxq =3D xdp->rxq;
>  =09u32 len =3D xdp->data_end - xdp->data_meta;
>  =09u32 truesize =3D xdp->frame_sz;
> +=09struct sk_buff *skb =3D NULL;
>  =09struct page_pool *pp;
> -=09struct sk_buff *skb;
>  =09int metalen;
>  =09void *data;
> =20
> @@ -751,16 +751,13 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_bu=
ff *xdp)
>  =09local_lock_nested_bh(&system_page_pool.bh_lock);
>  =09pp =3D this_cpu_read(system_page_pool.pool);
>  =09data =3D page_pool_dev_alloc_va(pp, &truesize);
> -=09if (unlikely(!data)) {
> -=09=09local_unlock_nested_bh(&system_page_pool.bh_lock);
> -=09=09return NULL;
> -=09}
> +=09if (unlikely(!data))
> +=09=09goto out;
> =20
>  =09skb =3D napi_build_skb(data, truesize);
>  =09if (unlikely(!skb)) {
>  =09=09page_pool_free_va(pp, data, true);
> -=09=09local_unlock_nested_bh(&system_page_pool.bh_lock);
> -=09=09return NULL;
> +=09=09goto out;
>  =09}
> =20
>  =09skb_mark_for_recycle(skb);
> @@ -778,15 +775,16 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_bu=
ff *xdp)
> =20
>  =09if (unlikely(xdp_buff_has_frags(xdp)) &&
>  =09    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
> -=09=09local_unlock_nested_bh(&system_page_pool.bh_lock);
>  =09=09napi_consume_skb(skb, true);
> -=09=09return NULL;
> +=09=09skb =3D NULL;
>  =09}
> +
> +out:
>  =09local_unlock_nested_bh(&system_page_pool.bh_lock);
> -
> -=09xsk_buff_free(xdp);
> -
> -=09skb->protocol =3D eth_type_trans(skb, rxq->dev);
> +=09if (skb) {
> +=09=09xsk_buff_free(xdp);
> +=09=09skb->protocol =3D eth_type_trans(skb, rxq->dev);
> +=09}

I had in mind moving the out: label (and the unlock) below the
skb->protocol assignment, which would save the if(skb) check; any reason
we can't call xsk_buff_free() while holding the lock?

-Toke

