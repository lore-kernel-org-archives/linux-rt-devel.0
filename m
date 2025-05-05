Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2631DED40
	for <linux-rt-devel@lists.linux.dev>; Mon,  5 May 2025 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436439; cv=none; b=kjmbJT2rj0tX4KL74s0muiDomXpDP3rZ+J9Kgk+kRhD4YcMDdNoffMU20pqVTxBJFimqaz3sc2xiLD+YNmbtL3NzpBFzGw2e0VNNnTYs39rfgOlw8AHnyxK8LV83UMYylPxV8S5nKkP8aKiPwfbbmBR52hSrniCErsFjJKkdA40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436439; c=relaxed/simple;
	bh=k1IcIw8oEyJYviPuUQqrU0ETws0CuY9iE8gFyKeLrvQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kbXd8sQB6yDfY+UpnnJhYjjf0ChfsKgog1l4Wh7HN5vHbPPFO0IZOpUdWv88L3d6tZGTM6X+uJ442C1eJyLnfhKiJkYHTv2AN4aBtJxBocAyKvzeXYWqOLEmPsaw0Po3LTdVFWvatqhw41F9E7BD3E28+KdjFkQOu66EEuqywlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FE3himxt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FE3himxt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746436435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k1IcIw8oEyJYviPuUQqrU0ETws0CuY9iE8gFyKeLrvQ=;
	b=FE3himxtUjfXeQO/b7eHd09A6Kmz1F6Hy0GJDC9wLJW6hYqiJ8u/7kZGHYQPI5UhntJu8K
	WevyStAS5h/7RXt7yP8oGvbIfRc5VX0RLsggY0tOUmzB1pLY1If1nSNjjkilnJ2G/wdnsP
	qZdhYNFU5y9ATtSdPe4ldP8x2F0+IxU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-zIqjtFJmOD-Yo_6XlWI4CQ-1; Mon, 05 May 2025 05:13:54 -0400
X-MC-Unique: zIqjtFJmOD-Yo_6XlWI4CQ-1
X-Mimecast-MFC-AGG-ID: zIqjtFJmOD-Yo_6XlWI4CQ_1746436433
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-acb67aad0e2so346149566b.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 05 May 2025 02:13:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436433; x=1747041233;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k1IcIw8oEyJYviPuUQqrU0ETws0CuY9iE8gFyKeLrvQ=;
        b=kjuwkhU+cUGJ5rq6M+8JdGkf8jMEcrd3Ps5wjgCWQOO2rUOM4CIiQxtQ+7UJP03ldZ
         TuWzxgnyEh8dkUfA3COH8ueM7IJs4UFxpr6WDAfgbTJ2y3JlunuC4h/nlDVDMPNokdXQ
         +7g0+2wA7TySgq0P0FajZz0RI7BE36YF6qzGmRBD9eWZVqirTWC/8a8Gto73TZCb03oN
         kxP7AAs4h5iPL2EQCnw7BhDV5jY2K+7Yx82HlJAzVKk39Mw87Qeij8XJuVmvWFuMUSxV
         pIgbJXYDkzzk7dCr1xDADN/X1Aac4OumK3fktF1IswtqKq0cbWlvLVIA+PChTiCSMc3/
         oakw==
X-Forwarded-Encrypted: i=1; AJvYcCX4sMRL0NWuOqekOeR7BjZRMuB01cmgyq15GE6Np4KksaBdsq63mKYKochNKHpeya//I3PhRY8hNMnyVgAiXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoiAPAmzOoyqeHm6ZeUYuVoGZ5ywxGvbbh7oLa5QJjZ++EUTnU
	IQr70MKj5t/ZGAp6AsZILp7vzaCZXmXXg+KKaHSd6dBt8FimtNeATq5d8Z5mr5FqQeaqxP59Mr8
	MWnZ73/W+qYsyEz8eNwN7Rcdxduomfh867Q43XIY/J3LpUnoHfeR8PGCMy86WqXK9
X-Gm-Gg: ASbGnct3wzmAwZq3gmTw6ukQ13MAnocL9QV4oQVAoEoWotXajennHtrpTgZ38BrczJo
	aKmvPQlrSJE/0UHE8V5qM8JNhtAzX9Xm8LYXExNegXBwqvkDXH3d4t6UfY2M5+xdru2tSqmQqxJ
	CKLCtmRHY92ECBjB90kAsPFJXe3UWOsMM8xBTnj5hhY94nEP28+dY2BEmr9GCqISeAsiSXzARxV
	ZfE4NQxYVziODcWGlrSGlraksmN9paRG0ee8xmAnGvEBfB+VlMFAZGvtEpftobkKXzijHSRbyBa
	/3sBETSd
X-Received: by 2002:a17:907:2daa:b0:acb:aa43:e82d with SMTP id a640c23a62f3a-ad17ad44558mr1016883666b.3.1746436432773;
        Mon, 05 May 2025 02:13:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzH7nbUKnkvNU50lx2bKZYCMG1O7IVV7E6VLNwRUOWFhfv66iShat4B39Dv/kpSXct4T08lQ==
X-Received: by 2002:a17:907:2daa:b0:acb:aa43:e82d with SMTP id a640c23a62f3a-ad17ad44558mr1016880466b.3.1746436432331;
        Mon, 05 May 2025 02:13:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1895402c7sm456179466b.164.2025.05.05.02.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:13:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 848561A0BD4D; Mon, 05 May 2025 11:13:50 +0200 (CEST)
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
In-Reply-To: <20250505085713.ZAgyY1mJ@linutronix.de>
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
 <20250430124758.1159480-6-bigeasy@linutronix.de> <878qng7i63.fsf@toke.dk>
 <20250502133231.lS281-FN@linutronix.de> <87ikmj5bh5.fsf@toke.dk>
 <20250502150705.1sewZ77B@linutronix.de> <87frhn57i3.fsf@toke.dk>
 <20250505085713.ZAgyY1mJ@linutronix.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 05 May 2025 11:13:50 +0200
Message-ID: <87a57r5sj5.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: H2mNgOdsAZ_gkocgW77RIgpJJNLXXA37hQ5qxXL7TEA_1746436433
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2025-05-02 17:59:00 [+0200], Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> >> I had in mind moving the out: label (and the unlock) below the
>> >> skb->protocol assignment, which would save the if(skb) check; any rea=
son
>> >> we can't call xsk_buff_free() while holding the lock?
>> >
>> > We could do that, I wasn't entirely sure about xsk_buff_free(). It is
>> > just larger scope but nothing else so far.
>> >
>> > I've been staring at xsk_buff_free() and the counterparts such as
>> > xsk_buff_alloc_batch() and I didn't really figure out what is protecti=
ng
>> > the list. Do we rely on the fact that this is used once per-NAPI
>> > instance within RX-NAPI and never somewhere else?
>>=20
>> Yeah, I believe so. The commit adding the API[0] mentions this being
>> "single core (single producer/consumer)".
>
> So if TX is excluded, it should work=E2=80=A6
> For the former, I have now this:

Yeah, much cleaner, thanks!

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

