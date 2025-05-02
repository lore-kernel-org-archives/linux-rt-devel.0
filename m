Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C1125B1FA
	for <linux-rt-devel@lists.linux.dev>; Fri,  2 May 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746201578; cv=none; b=XUFxIT3ZanfVXDdZdgZtLMiXMCb6APo2lXbJZxm25TUUVtf5qrIU2lXPdJI4QSfnTf8FycpRTqf8zW52hiZNKl4WfPC/odgCusQ7ftUup51PlmQah2f0OVw5kNDXPm9RguU886VmQHtkwL41DWvAfulhOFU/gLf1uWJ4gMA7rX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746201578; c=relaxed/simple;
	bh=CXk24SNJGboWsLT67/coRRBj1+zmTXPzGEAu1HVVezo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eOe5tDJ+FVQfyxxf9gkTHwvG2Hel1yeLMUXZtCZNR2wnlfDccE1zbriVJo86xEfEkqbMh/QP42ppOsUuSurjBCs+fsqWr7dcA9oUy11GzEkOLULtGWOJhTkUIcmny4VDyZNbfRZWQCizT+0ZBGMN7af+bO1yCNXXxLOl5w5/0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BQ3LWm1x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BQ3LWm1x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746201575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRGxCthJ9RL5kpwdsn8DiO3171tDJb4YM19RAhItZG4=;
	b=BQ3LWm1xkb1oin/+LVknaVJfiwKAdqOEbkKRHwJdpzQ6y4i+VlyeUa0dcE92oqJ3s341kv
	zGZ/fmhNmF6W5zMpgHwAD5gUDuStyQmElQOsWm2FACLRljKzQnWDbeUl3NLpTQBur9fZSo
	hIzN0vGGSovY6lLADX+7AXob079toHE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-Wisev9HFNs2w8VeM18yJbA-1; Fri, 02 May 2025 11:59:34 -0400
X-MC-Unique: Wisev9HFNs2w8VeM18yJbA-1
X-Mimecast-MFC-AGG-ID: Wisev9HFNs2w8VeM18yJbA_1746201573
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-54e750de36dso1318382e87.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 02 May 2025 08:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746201572; x=1746806372;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCdtyBucBLgyJrIWE2a1E5opSPjkTpqCOuhdn8D/y7k=;
        b=hMYYCbEN2MWSIp2ASzdtFoaP7WDp/koY+nzrOKi7zvrWCvBdT/y1x63rkEUaZ1bHEB
         sR6RAmGE3MZjODHiPFMj3L+6FTp5QrVBDLphv7VnFFDZdcbWZm/e3fTNz9xPWZZ3ExNb
         GcTUjzBIa05Qvz/tfAzGypWmr2zgpDEyrcZqVwaIjqZ81XNyZTx5WXDIwg1iQ2ToQY84
         F4B6yi9mmYzT8Dj8y01aE8AAsvzI/pEkxDNHJyEyIwwW5dyT4aXT/BVRIXR9C58WlQeR
         sIGK/mVRU/iRYy4ZgGwKXG3H+7iM9Z8AA/bOHdsOqVeFkN3OKR/wARP91FD5FAFJYOKx
         foSg==
X-Forwarded-Encrypted: i=1; AJvYcCVPWpkmwCK5DcrHLiS4J+IHMnj/OV0XmZrWdToi9u9xi8yGSapJg/bQfvQLhiroqHZClIO6q1rvuYVJQ5e52A==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGrOkyg7axuaGeOVTVms7/CXk4ZkARbfTL25ayu1TEFDaLuDHY
	7R4ZPAwtbokSTgs1gYD3CZhT27u1qUaxydvb4bIjoz6F+Xau6QP5y1pgPpWljAaE6J2DDnbbeWc
	QTALZEXwAQZy7ybu0XmmheV6D+yZGYz5ADRssOdIpKS6SBe7XQM/9iUXvat8Ra6dL
X-Gm-Gg: ASbGncuhCZL0Qovz8AInTemxiRFWfa/0pVl7nSLpe8ZjzHFhfXCgelqAzgqe4XyR8DC
	bpny/mjr3m9XUxx+y82gSFnHCqzWgpyFj0j8n9Mer7BFLMCJQ9q6XqMMn0Qk7F4SDD8Gumqvf2H
	I30g1puGe38+WUwZj2jfS61C4vj1Rg03iyEtj9sEl+Ebx9/BoqUYtYlVSJ4MjoOmUwda3pEzPgN
	/71YTvalHk1n1NMwbT6m1uqFt3QrkXWbmg6+1iVDxclrxlwwvdt84KUMXSGd3KzkD9ITnumLSxT
	z9qctAIw
X-Received: by 2002:a05:6512:2c89:b0:549:2ae5:99db with SMTP id 2adb3069b0e04-54eac2347b5mr1180036e87.45.1746201572623;
        Fri, 02 May 2025 08:59:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbbWQ37DcyLp6u4Y7JWsAcBdhHWVsBBDog3Y4p3ar8KI2Q/GPFrZQ6gXIgWIBs257ALgTY0Q==
X-Received: by 2002:a05:6512:2c89:b0:549:2ae5:99db with SMTP id 2adb3069b0e04-54eac2347b5mr1180023e87.45.1746201572225;
        Fri, 02 May 2025 08:59:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94f2160sm377797e87.190.2025.05.02.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 08:59:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9AB7E1A0852F; Fri, 02 May 2025 17:59:00 +0200 (CEST)
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
In-Reply-To: <20250502150705.1sewZ77B@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250430124758.1159480-6-bigeasy@linutronix.de> <878qng7i63.fsf@toke.dk>
 <20250502133231.lS281-FN@linutronix.de> <87ikmj5bh5.fsf@toke.dk>
 <20250502150705.1sewZ77B@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 02 May 2025 17:59:00 +0200
Message-ID: <87frhn57i3.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tOA-xHbXVf92oK6rmmtsqhON31kpq-VNFRdJY4Jni_E_1746201573
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2025-05-02 16:33:10 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>=20
>> > @@ -751,16 +751,13 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp=
_buff *xdp)
>> >  =09local_lock_nested_bh(&system_page_pool.bh_lock);
>> >  =09pp =3D this_cpu_read(system_page_pool.pool);
>> >  =09data =3D page_pool_dev_alloc_va(pp, &truesize);
>> > -=09if (unlikely(!data)) {
>> > -=09=09local_unlock_nested_bh(&system_page_pool.bh_lock);
>> > -=09=09return NULL;
>> > -=09}
>> > +=09if (unlikely(!data))
>> > +=09=09goto out;
>> > =20
>> >  =09skb =3D napi_build_skb(data, truesize);
>> >  =09if (unlikely(!skb)) {
>> >  =09=09page_pool_free_va(pp, data, true);
>> > -=09=09local_unlock_nested_bh(&system_page_pool.bh_lock);
>> > -=09=09return NULL;
>> > +=09=09goto out;
>> >  =09}
>> > =20
>> >  =09skb_mark_for_recycle(skb);
>> > @@ -778,15 +775,16 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp=
_buff *xdp)
>> > =20
>> >  =09if (unlikely(xdp_buff_has_frags(xdp)) &&
>> >  =09    unlikely(!xdp_copy_frags_from_zc(skb, xdp, pp))) {
>> > -=09=09local_unlock_nested_bh(&system_page_pool.bh_lock);
>> >  =09=09napi_consume_skb(skb, true);
>> > -=09=09return NULL;
>> > +=09=09skb =3D NULL;
>> >  =09}
>> > +
>> > +out:
>> >  =09local_unlock_nested_bh(&system_page_pool.bh_lock);
>> > -
>> > -=09xsk_buff_free(xdp);
>> > -
>> > -=09skb->protocol =3D eth_type_trans(skb, rxq->dev);
>> > +=09if (skb) {
>> > +=09=09xsk_buff_free(xdp);
>> > +=09=09skb->protocol =3D eth_type_trans(skb, rxq->dev);
>> > +=09}
>>=20
>> I had in mind moving the out: label (and the unlock) below the
>> skb->protocol assignment, which would save the if(skb) check; any reason
>> we can't call xsk_buff_free() while holding the lock?
>
> We could do that, I wasn't entirely sure about xsk_buff_free(). It is
> just larger scope but nothing else so far.
>
> I've been staring at xsk_buff_free() and the counterparts such as
> xsk_buff_alloc_batch() and I didn't really figure out what is protecting
> the list. Do we rely on the fact that this is used once per-NAPI
> instance within RX-NAPI and never somewhere else?

Yeah, I believe so. The commit adding the API[0] mentions this being
"single core (single producer/consumer)".

-Toke

[0] 2b43470add8c ("xsk: Introduce AF_XDP buffer allocation API")

