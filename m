Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C51F274646
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Sep 2025 22:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852879; cv=none; b=TIRYHm9SZThRl8WiQfGwPWzVjDdsefxymlR2zzxhOYOlP3YF7sArG6DzqMzqAk3qIUkPqsEJPtWfFY9WasFotKIH5EJkbBxqLw3AIyVwt/L3pta5sZWZjJuAMREobAXCm1dUGkoGIboYm+05w2naumMDcv6h7kN4CMweBSkJ0Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852879; c=relaxed/simple;
	bh=v4Fil2zNyhzEn8Y/gdgAfMokXDb53dQ2oSj4wy3BVhM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nVBa4cdcOjQEs8tPu7sxKQae3Fh6Ty7CFDxZ+lHHuRqC7ZFsRm6D5yI0cZDFpbtXGOyTz6Ivw5W6006QggNXMNUzjq3SQP1JwRAM7M4zEL/tGxr90+1y4UEmcCXSIZ4YRd/z/JpRIlCgY8xWhT0L9WwVBOCnpxt6bXuLBLNHK+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPOIjVc8; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPOIjVc8"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-89019079fbeso1541986241.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 02 Sep 2025 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756852876; x=1757457676; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QBseKVhIOD7rddztwEAR/sKg97wfiErirFVx2pC+y8=;
        b=RPOIjVc86Pgkv4f6YgiGpNVnw2vqj0REC41bThI1Yy7zay1IBAE8btsRmmgrncDnqT
         trgFchNgdayORHr7mZ+4dfpX8kae+RtvqTWJIk72ZRq4/bKcpeNk2QFKm28AvQrS0op2
         dTl01hfn9brFI3gUtatiIJuGiZWK0WsrXpeNwbos0lDNFGHmBU6JwHA+EwiR5Yf/8ez9
         /pbL/bXJnZtsjLXPaEjBaiTkdWISZMYh0nkaTpAthOVyas9+Y15pnqH2FE4XhJjZzRt9
         2oyIYq09PEzqmYYf8YJWSng7gQTHXdy45Ykaut6xPz9RY3SO2/7QDn83Cr28prZYsEAI
         go4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756852876; x=1757457676;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5QBseKVhIOD7rddztwEAR/sKg97wfiErirFVx2pC+y8=;
        b=DfwJ32KOPQVwAnyGC/PBtR/LLgR0Q8YGtW5j6Jen82hUedQ3uYSnQjADR5wi/aUSWQ
         At2PebiUPGbW4UUuN1+KxDjrwqDC/9aofJfef8S8OTZHzkld+7/M+HQ0BSAdC7biUioT
         GwGHqeTcVf28mLyydYgdnStGidOC8Ab46ZjMgs1StEeIkJdQVs3kld75TCRBRXy2Chhb
         BUJmrjgCbY3Yk3zQp8NvvmU8Ju4bnf139aqfq/4o/w4u+XRfx6q6WQ+40OtgSUAv+s7N
         HuXLU3g0Ynv/coW+PlNOvWdJeVA3ga1pd5Hxn3v8USUbUK6cIyLoBX+MiWm3UGLlTNzo
         cprg==
X-Forwarded-Encrypted: i=1; AJvYcCXoXxoonq4XCIWIT6xzFb11a7zx/hlgpXdtyk9WNTBvX6vzeecRLIjoaxnMKB82ROSATjwHFJie7WUP+KMRxA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxZ+RHPdaIRVM3sFsyHEm6Skk+P5jBoEPx7E0brEMOdC62nsw1a
	C6R5e5QBGLP8Cqipdeon34907o143QS8Nh0peHYyKB1wKHOiJUtIscam
X-Gm-Gg: ASbGnctAFRDrbaI+DPguEoTGFRfRLnElQKpu8H1HVBb9JoamvaZSWYa99OPbbBL3Xpc
	Hx1FeDfrCGDxT6tOo8Wn1PdaJBdQHrP8hDqTrXKjWvPE9RJ5jjfbDGgL9by7iLGQGytIGuxRSia
	TzQp43lBwPnquPv949ZMV27milC9Jpuz7Ye2RQJl74pMvcT1hLNiVgZD5MW6aGq3sjw5NgGAOTK
	kXgzuBenLFlv/CXvJVae3trlVQLfWNAAYFPtuBDmYJvRzXmyaBfGUijEzCKH6xzj9PIDE7UizPJ
	V6hcUb8/wGfrgGZ0qOQJN8WYG+ZYusdL2/+y3StR+ewZvgfV5CnS2kpayx0t8cb+OuU4ZHJQFpA
	0wdCIoP32RJYXliKmklfylAGWRvHjI/CY7T68wah26zh39m92caRvv3LerrvtDaDbmi78LUGx1D
	+GzA==
X-Google-Smtp-Source: AGHT+IFoVGNaBflNy7LsGWkGUCgZQqNNgejO2tBaLky1MLKy0WgsmHoenbfRtwGQMjxSn6O8Urvjnw==
X-Received: by 2002:a05:6102:6c2:b0:4fc:eda:abd8 with SMTP id ada2fe7eead31-52b1be31b32mr3580050137.24.1756852876012;
        Tue, 02 Sep 2025 15:41:16 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id a1e0cc1a2514c-899f14c7752sm762863241.4.2025.09.02.15.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:41:15 -0700 (PDT)
Date: Tue, 02 Sep 2025 18:41:15 -0400
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
Message-ID: <willemdebruijn.kernel.16c9d77b1d2c@gmail.com>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-1-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-1-51a03d6411be@debian.org>
Subject: Re: [PATCH 1/7] netconsole: Split UDP message building and sending
 operations
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Remember to label the target branch: [PATCH net-next 1/7]

Breno Leitao wrote:
> Split the netpoll_send_udp() function into two separate operations:
> netpoll_prepare_skb() for message preparation and netpoll_send_skb()
> for transmission.
> 
> This improves separation of concerns. SKB building logic is now isolated
> from the actual network transmission, improving code modularity and
> testability.
> 
> Why?
> 
> The separation of SKB preparation and transmission operations enables
> more granular locking strategies. The netconsole buffer requires lock
> protection during packet construction, but the transmission phase can
> proceed without holding the same lock.
> 
> Also, this makes netpoll only reponsible for handling SKB.
> 
> netpoll_prepare_skb() is now exported, but, in the upcoming change, it
> will be moved to netconsole, and become static.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

aside from the above,

Reviewed-by: Willem de Bruijn <willemb@google.com>

