Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11080293468
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Jun 2025 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750152992; cv=none; b=AEj0BlTPzhKl4p2J/To0MEd4OFK8GnEmmjV1YEskgjJzfaFxHfjzW6fUDzKuvGR0o87RvHA7tboYJBgBcKRIyv7zNd6mRPCn8JGhxKeA5arjONnkWQOpx3ayWZ0jg0ScYztY3n/q0u+hBgm0MkjjfKmCCAJkE4avUuMkRBq7nFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750152992; c=relaxed/simple;
	bh=/pp0PS55MJ6yh8r/94jB7SeDuSRDV13nKpCJfw/E3es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hq8vlhJfVsTBZeAJhxgCzcfCU7HQOPbrlAilwmOXRnpRJ2bAFC6PYafXC7OepUDsWeIE8g0GMiG7Br0gubVrBkSSa4jMI92R8zrcPlUOc0F/yRv0jdch0TpLas29nRKv8/vheeckGWbdOsNlxHTaGHJRE7DTeOYcXwl1NVAZCYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nE0bMyD0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kE03CUN9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nE0bMyD0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kE03CUN9"
Date: Tue, 17 Jun 2025 11:36:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750152989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puVplXsaXcxyDh0Jl680VqO1uA3clTSRdN8h/PW2JwU=;
	b=nE0bMyD04ZiC8pf1VZs9BSvjIV+bbe+U/FlKoMCPj9pEM7X994GFKMJu3hjhd8g8FirB90
	cagitXSSKEkStTdqOCheqR8Jmk2CkCUQuO8QoOw3CDsXbZuEKX085JdcouJ1cbG0x9ZEed
	oJjdQumW7aGQ1NPL2piGIslW4FWxwBAiQz/nCikI+WwIpSMTI68yjdnCKgpnFnmr5Ux/is
	lV0uw9yBbWr62UIq3xWcopdEwpdphlTkx9g1AlDRtrq9PkFwuzL9QRGtpdBHfGunS6GUfk
	ffCki7seqgpoWBy11E54Gl0N+ag1q4RAmcmY59unU/vhPSRysxdFUFytCQifgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750152989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=puVplXsaXcxyDh0Jl680VqO1uA3clTSRdN8h/PW2JwU=;
	b=kE03CUN9vcRiH7hSs/kJfH4bhlQpvmUMiveclJCOoDM4XOkvwDXlbug7ybSQ8rOlfDgGhQ
	igHlWK9qNZ/pUICg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>, Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>, Crystal Wood <crwood@redhat.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Juri Lelli <juri.lelli@redhat.com>, Ben Segall <bsegall@google.com>,
	DietmarEggemann@uudg.org, dietmar.eggemann@arm.com,
	Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>
Subject: Re: [RESEND PATCH v4] sched: do not call __put_task_struct() on rt
 if pi_blocked_on is set
Message-ID: <20250617093627.ykSeZMqk@linutronix.de>
References: <aEw-KjUjjP2gYH6z@uudg.org>
 <20250617092609.GR1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250617092609.GR1613376@noisy.programming.kicks-ass.net>

On 2025-06-17 11:26:09 [+0200], Peter Zijlstra wrote:
> On Fri, Jun 13, 2025 at 12:05:14PM -0300, Luis Claudio R. Goncalves wrote:
> > With PREEMPT_RT enabled, some of the calls to put_task_struct() coming
> > from rt_mutex_adjust_prio_chain() could happen in preemptible context and
> > with a mutex enqueued. That could lead to this sequence:
> > 
> >         rt_mutex_adjust_prio_chain()
> >           put_task_struct()
> >             __put_task_struct()
> >               sched_ext_free()
> >                 spin_lock_irqsave()
> >                   rtlock_lock() --->  TRIGGERS
> >                                       lockdep_assert(!current->pi_blocked_on);
> > 
> > Fix that by unconditionally resorting to the deferred call to
> > __put_task_struct() if PREEMPT_RT is enabled.
> > 
> 
> Should this have a Fixes: tag and go into /urgent?

I would say so. I'm not sure what caused it. I think Luis said at some
point that it is caused by a sched_ext case or I mixed it up with
something. Luis?

The other question I have, do we need to distinguish between PREEMPT_RT
and not or can we do this unconditionally?

Sebastian
