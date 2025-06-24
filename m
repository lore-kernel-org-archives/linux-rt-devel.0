Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1197A2D23BC
	for <linux-rt-devel@lists.linux.dev>; Tue, 24 Jun 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774295; cv=none; b=S2oOPCzULL7zjYM4HOMyJZ2M1GMP7u4rmvKlJDbxMM2+dOLEiQEWVRjLGR3pJwLcRCguGBWsz5wKxrMhPdbE9F5qwLX233X7peI+CUkBOalUJ8I+3wITXOoQ9JzVEO4sm8ONlDiJ3T14MfcE1E1ZN82+KfRfLdeykieJLDxanzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774295; c=relaxed/simple;
	bh=JVFplqwsSQ3zE1ZVwdS/hU7LtAvyp0kA42SNMGfb1YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cm+XJAwwsN9uksE1zEf0e2F+UqgFRVVeVmOi1/ugVyefrxvTjnqqD4GSnvSriyrMvAg3oMybt6vrOOnwmaxFAY/AD0nmPUeUkyt+5hq//ciz4/hl6uVNTWOCzNMjP6pnMCSYWkxAaS7i0Q8dLfTmU7sqV2EgxhUBrQmbB6XCqz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TLtUKRDz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YeP5Il+w; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TLtUKRDz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YeP5Il+w"
Date: Tue, 24 Jun 2025 16:11:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750774292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjUSNJBMO+NBHGXbrFO7m3NMv5jpn0HjiAjQvupbPQE=;
	b=TLtUKRDzrCWby1lUcFpFQCjEm+oAuqTumSYmUcjarD9QPhfU6cpZlel815owYMrOLbcjTU
	ZW7mJTC74r56TNCKjDtPWjGbGqXWIeSw3cuIdJErYfrgLnMNCkdAE5UwdeXTGhmJVJ3P5Y
	q3BUcz49yxjiTD++uNCb84Ym6sEH1VpoCcpeA9R4BobiWXiFX1t5dyw7WncjD6wwkd94j6
	IzJ16E8rIrCw1gviZCMNPth5lPARpHoeK8qmXSNsZri1QRNJ7dirQBRrj45LwVK5e5PcIs
	SzXnKGYGlD1dDeFwSlagjeroMs2YNHZe9p4B4OqJyfFuEN5amC3/eUOOUtrQZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750774292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PjUSNJBMO+NBHGXbrFO7m3NMv5jpn0HjiAjQvupbPQE=;
	b=YeP5Il+wFMDFn8GvKnUnxIjrb3n+p8xYBQHKxAzStmmgPVJA+axdAcaEsEA72G9j6HnyWr
	1ti+iOY15gkGfJAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
	Nam Cao <namcao@linutronix.de>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
	Alexandre Ghiti <alex@ghiti.fr>, clrkwllms@kernel.org,
	rostedt@goodmis.org, linux-rt-devel@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Enable interrupt during exception handling
Message-ID: <20250624141130.gZVv4WnP@linutronix.de>
References: <mhng-60581B88-6FC7-4349-96B6-730D908ABF4A@palmerdabbelt-mac>
 <alpine.DEB.2.21.2506240303170.61655@angie.orcam.me.uk>
 <19cf2371-7293-4e71-a17d-669db4c8270a@rivosinc.com>
 <20250624131730.XqPd1HUR@linutronix.de>
 <d135d6cc-5117-4b3a-9abe-2e5fd9e3e490@rivosinc.com>
 <20250624140815.GU1613200@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250624140815.GU1613200@noisy.programming.kicks-ass.net>

On 2025-06-24 16:08:15 [+0200], Peter Zijlstra wrote:
> > >>
> > >> I also had a series which was doing so for misaligned accesses handling,
> > >> but after discussion, it was not ok to do so.:
> > >>
> > >> https://lore.kernel.org/linux-riscv/20250422094419.GC14170@noisy.programming.kicks-ass.net/
> > > 
> > > If I understand that right, exceptions from kernel should be treated as
> > > NMI, so that lockdep can tell us if exception handlers touch locks.
> > > 
> > > But (conditionally) enabling interrupts does not lose us that benefit. It
> > > is still considered NMI by lockdep.
> > > 
> > > Unless I miss something, the patch is fine as is.
> 
> I'm confused, you're wanting to conditionally enable interrupts from a
> kernel exception while its NMI like? *WHY* ?!

What we want is to enable interrupt handling if it was enabled before
the exception occured. So we can send a proper signal on PREEMPT_RT
without chocking on spinlock_t/ sighand.

Sebastian
