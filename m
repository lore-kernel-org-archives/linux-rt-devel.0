Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292083AF66E
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 07:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161784; cv=none; b=nkjnQOphtoRyowoHvcNztSktVIgqD3FKroo+fELlUsMpVMLGMlhKs7yGjJd3Y+xZ3DvtiPxPeTH13s/1xza9uQ6y+2jvcPCOOcWZWEnwLIJwNH1/ELKndGc8AsqXJluTWjuQBDSlTS0MvcbQAgAGM6XQzgeRYS9HvbOY/LmLzTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161784; c=relaxed/simple;
	bh=NBzwoNyefdSIH6rQCwuf5xORJ6xN6NWSfTYFyk0eN28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OucIBoOoWVRjCZA3sca59r9XVLSKgoryE8N0AiREU7MgeSMQsPiZjmwZAZ2nsHQM0Dt6JjzuDdaXBniSKdKDJR5uTxMleH1bM7UAeOpv/zS+zmlbZnfTOR8chZ1L5HeRQ/bZqSl3KWBUHXbS72sLMyKK2V/EsGMos8l9V+xOUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nq4JVzso; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pk91fDTw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nq4JVzso";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pk91fDTw"
Date: Mon, 31 Aug 2026 09:36:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788161781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0bbLn43OEfzJk6RijiG0hY9eLwY+qM7uVXluXMN+YSs=;
	b=nq4JVzso6agIIEJPtT+hA2jj6xB08NNe45cLx3b3da5REQJup3Vb5gX/bgy+epwACYFOwh
	4dmrOIEwuY26RvfhCQapR4BZRlTBYX8V9rIvVQdNqVZtO9KcX8cY2gPUAvu7eG1IUk4zWI
	iGQf6n/EHr3gsDVe8aj2pFL/0A65eG2jbRDrih1dS473/GiZE0uyEJDNlC2egaMTnbXRGM
	I0XJQ4EsLkyrO58e8EV7+vj7II5p+fmDJfFCHdFbMJyuZD3zYw5jR1Vz6jk6oExsjbzlZX
	KRTFOrv9cQRhCIMu5h9rUFqvjPoLMdr2d2IYVQJDRkrwgFk+D6SvmF+ajLcFWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788161781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0bbLn43OEfzJk6RijiG0hY9eLwY+qM7uVXluXMN+YSs=;
	b=pk91fDTwvh9wOOk+diFwBjcIFfkAtuIAvaITJVIRjHrxu/tDM8ZpStQUYGvAopCfp7Lifw
	XzuXrIPEv7O0J2AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	David Stevens <stevensd@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>, Qi Zheng <qi.zheng@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>, suleiman@google.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
Message-ID: <20260831073619.Ssq-wt7s@linutronix.de>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de>
 <20260828135947.GU776954@noisy.programming.kicks-ass.net>
 <CAOiLmNHrbXeTY7zoNodmaZUoMWf+NgvGvZ_LjfWD-1sKAoiLeQ@mail.gmail.com>
 <20260829084901.GA776954@noisy.programming.kicks-ass.net>
 <apLxcg3Lgy0-nXA4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <apLxcg3Lgy0-nXA4@casper.infradead.org>

On 2026-08-29 15:49:22 [+0100], Matthew Wilcox wrote:
> On Sat, Aug 29, 2026 at 10:49:01AM +0200, Peter Zijlstra wrote:
> > > On PREEMPT_RT, it is necessary to skip the call to
> > > alloc_pages_nolock_noprof() from under pi_lock, since with that
> > > configuration spin_trylock can end up needing to take pi_lock. But at
> > > least on !PREEMPT_RT, there is no risk of deadlock.
> > 
> > Yeah, which puts the lie to that horrific hack Alexei did. We should
> > probably teach lockdep about spin_trylock() not being safe and see the
> > house of cards crumble.
> 
> Why is spin_trylock() unsafe on PREEMPT_RT?  It's not intuitive since
> one can mutex_trylock() in interrupt context or under spinlock.

no, you shouldn't do mutex_trylock() in IRQ. There was something, I
don't remember but that is the reason people use semaphores because it
is okay to do down_trylock() in IRQ. It might be unlock path. 

Sebastian
