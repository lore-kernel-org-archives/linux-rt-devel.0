Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBCC3E7BCD
	for <linux-rt-devel@lists.linux.dev>; Thu, 25 Jun 2026 14:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399081; cv=none; b=l2V16xlPPZUL9HCpNd5xExVbdfgTiM8NK2sGG1Gq83K9obnw3Cy6NnCsIFdsRU6jnyd9BlxI3iWFcXnM34WFXyPWLjcTGUbnafRyP4ziNliUsFI0EBdju2AqUvBTcYTPopsOrosRQQ+1IZ6opSDFagE/XpCFVkCXLDb2BUDRA1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399081; c=relaxed/simple;
	bh=ZSo/K0zYaEvAiIQiwEIT4iky4JDvdNkIAcg0e3x2JSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3hSwqVujricNN5ORigvrFZwih3entzok3hmXK3CQhaoyb+6zbrICnbwvFR7+UapBQ8okXGjUFxOxZcU2bkA/g8tWWws1jqF0+9Nwl35jGb1Q1X0zZZJ6ALat5MIM+MjN7rPhNvatxLkwICLKEHcLqVZmt6D27YR5VpsmRAoiTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tAIJp+Dv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C6Z8XKLO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tAIJp+Dv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C6Z8XKLO"
Date: Thu, 25 Jun 2026 16:51:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782399077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ApX/fl8LKZ9+n2W+JlZhWLSnhxCbTTBA9ifvQ8K4HvY=;
	b=tAIJp+DvBvqvoMNf0DO4gtXkKTwUOcYer+vDHbIxbWKXv/Xrp7yMXPvZLRx6T0I2lp9Lu5
	qDyALu2p0Vp7QzGuHqOEbCZ6wMMjpMtv8BtpVZdWXSSxkNkxxm1DAM3+xg3pKBSOPz9jkL
	Vd2zjzCVjgt8tlE46gdtqMiOq5fHOEUm3+Qdqbu851M74qEW/7MNVDiQjlbaLl7QdaU24M
	+P6MQmkzuXkjHoxDSYqZjB3hym1RsY8gUg9k2MfTxB9CemCvzmP7wBqr9JtmMSYgM/Ev9Z
	uFflscKelMmnRk9e0kcSQsLTXAHLGD4f9HIOaAqXWRYZGPgddQCac/2V8O4CGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782399077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ApX/fl8LKZ9+n2W+JlZhWLSnhxCbTTBA9ifvQ8K4HvY=;
	b=C6Z8XKLOSA7duwmDNRwmGfJCTGDTEQYs3vNNJBcP+bHOYLAqx5rh8lAll+O1SbHJYP2L8D
	fYiKFEqHj8XYGmCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>, Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 5/5] lib/vsprintf: Validate spinlock context during
 restricted pointer formatting
Message-ID: <20260625145115.KZ9l1-lv@linutronix.de>
References: <20260608-restricted-pointers-final-v4-0-9a436615799e@linutronix.de>
 <20260608-restricted-pointers-final-v4-5-9a436615799e@linutronix.de>
 <20260611120615-4252b75d-55aa-4bed-b64b-0316b2148d2c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260611120615-4252b75d-55aa-4bed-b64b-0316b2148d2c@linutronix.de>

On 2026-06-11 12:09:08 [+0200], Thomas Wei=C3=9Fschuh wrote:
> > @@ -864,7 +864,14 @@ static noinline_for_stack
> >  char *restricted_pointer(char *buf, char *end, const void *ptr,
> >  			 struct printf_spec spec)
> >  {
> > +	/*
> > +	 * has_capability_noaudit() may use spinlocks.
> > +	 * Make sure %pK is only used from valid contexts.
> > +	 */
> > +	static DEFINE_WAIT_ASSERT_MAP(vsprintf_restricted_pointer_map, LD_WAI=
T_CONFIG);
> > +
> >  	lockdep_assert(in_task());
> > +	guard(lock_map_acquire)(&vsprintf_restricted_pointer_map);
>=20
> The kernel test robot found a lockdep violation with this patch:
> https://lore.kernel.org/all/202606110945.d3871219-lkp@intel.com/
>=20
> My suspicion is that this is a pre-existing problem that was not visible
> to lockdep so far, exactly what this patch is supposed to mitigate.
> I'll investigate some more and try to reproduce it.

The annotation is "wrong". What you say "I do spin_lock() here".
Then lockdep figured out that this lock is acquired under a lock which
is used also from within softirq. This in turn can lead to a dependency
problem based on softirq:

|       CPU0                    CPU1
|       ----                    ----
|  lock(vsprintf_restricted_pointer_map-wait-type-assert);
|                               local_irq_disable();
|                               lock(&ptr[i]);
|                               lock(vsprintf_restricted_pointer_map-wait-t=
ype-assert);
|  <Interrupt>
|    lock(&ptr[i]);
|=20
| *** DEADLOCK ***

If I'm not mistaken then this will not happen in real life because the
hook callback does _always_ spin_lock_irqsave() and as such it avoids
the interrupt+lock on CPU0 in this example.

Sebastian
