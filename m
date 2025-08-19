Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6D331B10D
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755598080; cv=none; b=Hq3BnTGPTF9bTDOT2GpiSfWdjM6nMMlu6SIXtNR0yLPzJ3hU/SIUvZuTiAgysv6Q/2WCbr6kdXxH7wuGG+cJCho3bs+SwjlVBnLg3diSalnpAEvu0KjN5spgE0s1ZkYWiLUV5iNBUohJDhID5hdYK9vmtuoMWbB1pXL4VqDgVdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755598080; c=relaxed/simple;
	bh=nVyrLvtFnGW6pKdDmrn0M948ArlCF/8vi280nC29aC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGubnUTDISiS4GBuhdDvQdK2N2y5CCzyRwT4gxTtFW0UDUdDy6c9g6eGNYiJu9NJE31qc5V4z7ZnIfv30T0bdAFfOt0AcbnqFmTb5Too87iGgppqEz7DMuB/NJE5MqNDJwc07pGxG2C0kExNjYGkLrPI2suoLBfefM3EnlYDkIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=auYbvPmi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FZe250lS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="auYbvPmi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FZe250lS"
Date: Tue, 19 Aug 2025 12:07:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755598077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dn/X6qy0XrMI61WmXeW/uOGvPrRWbztbvR64S1pgjFw=;
	b=auYbvPmi8tvz4msSCs1Wym3uuIfSEx/Mkxt6RqGqgJxhI9zQEhOPJCzTMssoZ4Yrl+1qE0
	iRLijAkuRDPtJMa1kxZMhY2FAowouie6IUf5TM7JO8RB62B5WWG+XCuTEfKGVVRNVSrnKN
	YAuO2aAV8MP/cGAK2fd+HBisiwDhLSatSLDv9y3knFLFhmUnshsNSDaTM0zG3VVd+5wfOR
	X3bcsajaboP7J+aGR9dx747qJiCwqghC6c5h7e4cLzcRkKxBut5Err13NNTgs54Gz+kZFJ
	AdMbPw+oZ3LoRzudzcsVumpxN1TVGZkyQSKmNr/FxdB+PLV2X81Xu0eZkMre1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755598077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dn/X6qy0XrMI61WmXeW/uOGvPrRWbztbvR64S1pgjFw=;
	b=FZe250lS4laYBS7vxw2NAvjeeJ1hnAv/G/KwSKSw1NZXRP7yDQoGVAqV4p9jXWkG7rxfjG
	HwEL/kWSOAxayNDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yunseong Kim <ysk@kzalloc.com>
Cc: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Florian Westphal <fw@strlen.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-rt-devel@lists.linux.dev,
	netdev@vger.kernel.org
Subject: Re: [RFC] net: inet: Potential sleep in atomic context in
 inet_twsk_hashdance_schedule on PREEMPT_RT
Message-ID: <20250819100756.IpUQx4jh@linutronix.de>
References: <3edfd3ac-8127-41c2-afc5-3967b8b45410@kzalloc.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3edfd3ac-8127-41c2-afc5-3967b8b45410@kzalloc.com>

On 2025-08-19 01:46:10 [+0900], Yunseong Kim wrote:
> Hi everyone,
Hi,

>  {
>      ...
>      local_bh_disable();
>      spin_lock(&bhead->lock);
>      spin_lock(&bhead2->lock);
>      ...
>  }
> 
> The sequence local_bh_disable() followed by spin_lock(), In a PREEMPT_RT
> enabled kernel, spin_lock() is replaced by a mutex that an sleep.
> However, local_bh_disable() creates an atomic context by incrementing
> preempt_count, where sleeping is forbidden.

As Eric said, the mentioned pattern is common and not problematic.
The wrong assumption here is that local_bh_disable() on PREEMPT_RT
"creates an atomic context by incrementing preempt_count, where sleeping
is forbidden". This is simply not the case.

> Best regards,
> Yunseong Kim

Sebastian
