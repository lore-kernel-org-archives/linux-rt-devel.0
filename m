Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619979;
	b=Hfr2cMvXDicD0p6PEKTlPZciJpv52QXiJ2+/JjSmvrQpYAmsMXp7uK5pOk0n+YwgNv1I
	 GK3LDgJC4efdRveifYpDCkIQeSfgBwVxt470ADIz1SgvGRcfGzNLPKc+jY09axsMFBilT
	 vJZGyyuM3SdscIoKurWOrOeF5RUQNVSIzpSEGkzbOw1Q1Pf743hDL6UbMI02yOQD+Jncl
	 E81mwuI7UUM89Ftxml57vs4ZBmyZulpIdFP1jkyGlWGcIh0fg1u1lcd8Z5lx1w8+Vapz+
	 dW4uUE6If8izoHGDQGIynptt8LSoI0QnpDmqqhgvBXW+h+lv+M1qXvlhj3hghFq7/CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619979;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=0a9q+huuyoIOz8IkHD+r5Bw+xupFItGuXtoD3i7TDIU=;
	b=tt5Ne/tHZxcSgcLy66qU9INSxJDnTipr2Oo1wsteQJgj/xTqVSXjYpLgt0/i3kaCGNQp
	 HYCdlyHBoyaZ1GAr9HzBOK/NFq0oPY7t8NJDSyflBE4J7gL5aSOPz7ktqpODMIpjgn5xV
	 Mp+B1UFVpZffojjs7NWZuLdfl8fpC6JDp9qot8L5oQ5MnYEgQBriPIYRSJWZgpBKajWK8
	 SxWW1rpmW9yuusPbK0CO2Sl255bUyaH39QCsHESyIDSWkKlAElcRiWgOHQAdAqH4byXrK
	 q155I5Viy7RwbzHRmteCiqu67QduVBaHal9gl3yQDblgJbct0ajUCZpeK9t8+sVke/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Q22kbEsz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=oePzjRX5;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4709A606A321
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 15:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4709A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Q22kbEsz;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=oePzjRX5
Date: Wed, 25 Nov 2026 16:19:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1795619976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0a9q+huuyoIOz8IkHD+r5Bw+xupFItGuXtoD3i7TDIU=;
	b=Q22kbEszPMOtoqXdNesp74j+B4T3Sddk02EMxGU6ZZti/drUuN/TTbmWfO9FVIknny0VNO
	OgqrVaLxdfFAEVBjvROhhG0IeqGFI0fNGDIX9Fz9WT2OU5l/+vX1LxV4MRCesSjHDsL+6h
	FGPMI8d2KLeabCQooQiYnNzHTSy67EjRE6O37eSgAqRmnnQKFuAU9Fk2QXkSq825ehV+HJ
	G5ZyJlmKbZNM2dmYzCHZH6qzfjwVA7wnimfDLlCqnF2ZT7Yi+pvbCEZ33w/w0zCHbjUEfz
	Ts0sqkVdUVRyuswHFpYAKJxad6MSPXIu3VOaPesUNpZ7oLYpFXSHAPwZXbPduA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1795619976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0a9q+huuyoIOz8IkHD+r5Bw+xupFItGuXtoD3i7TDIU=;
	b=oePzjRX50n0SqvTlICcaKy9+VF0d2Ledtjo6oUG+P6LBSzqaBex5HradhIL6Xi0oLfxVP1
	TAhWj9xLLXM4MdDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Harry Yoo <harry@kernel.org>
Cc: Takuo Koguchi <takuo.koguchi@gmail.com>, cip-dev@lists.cip-project.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Takuo Koguchi <takuo.koguchi.sw@hitachi.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, Clark Williams <clrkwllms@kernel.org>,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] memcontrol: protect drain_local_stock() with
 get_cpu_var()
Message-ID: <20261125151934.-RufHHEw@linutronix.de>
References: <20261125043900.3618611-1-takuo.koguchi.sw@hitachi.com>
 <awb6bJ1-_8zeyTYQ@thinkstation>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <awb6bJ1-_8zeyTYQ@thinkstation>

On 2026-11-25 15:13:05 [+0000], Harry Yoo wrote:
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -1933,14 +1933,21 @@ static void drain_stock(struct memcg_stock_pcp *stock)
> >  }
> >  
> >  /*
> > - * This must be called under preempt disabled or must be called by
> > - * a thread which is pinned to local cpu.
> > + * Drain this cpu's stock.  Called directly by drain_all_stock() for the
> > + * local cpu and as a work item for the other cpus.  Preemption is
> > + * disabled here because neither caller guarantees it on PREEMPT_RT:
> > + * drain_all_stock() only holds get_cpu_light(), which is a plain
> > + * barrier() without CONFIG_SMP, and the work item runs in a preemptible
> > + * kworker.  consume_stock() and refill_stock() run with preemption
> > + * disabled, so this keeps every user of the per-cpu stock serialized.
> >   */
> >  static void drain_local_stock(struct work_struct *dummy)
> >  {
> > -	struct memcg_stock_pcp *stock = this_cpu_ptr(&memcg_stock);
> > +	struct memcg_stock_pcp *stock = &get_cpu_var(memcg_stock);
> > +
> >  	drain_stock(stock);
> >  	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
> > +	put_cpu_var(memcg_stock);
> >  }

This breaks PREEMPT_RT and is nonsense. this_cpu_ptr() should not create
any warning here and if it is then something else is broken.
There is no need to disable preemption here, this is invoked from a
per-CPU worker.

Sebastian
