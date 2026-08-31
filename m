Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D611643E069
	for <linux-rt-devel@lists.linux.dev>; Mon, 31 Aug 2026 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185955; cv=none; b=oF2KYvtNLi8Wiq9sKOlVWblHpFISmr7B8dFps91AjD0995AwHbDs8bY3BQMw74aPrENOciOYXNQcy4pigK+5YmfJFO0UXCePjdC2fQqvnHYlubXa7qND+Aoy0PQ9jx0TRHldKC6ekpfWJfcFjjEyf0zyuxBnf4yX1P1sNTqgWVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185955; c=relaxed/simple;
	bh=xBOkpPpwC9lHlwfkQwJ3roDgFvY3VyYswAOLyqMuw/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRaBzQq3zY/7tyTKosSEEAqZMu9IvTauih2IZZ6oclH1bBLuFUfi48sLNTj90Z0S14CEfhkTRb2KmrsG1w8Cz22n6Cij1xs4Y8ZWxZXmIz41psFvIsvQs8dYr/07PeihP0Az+X5W+5KzikXFmrHyaruRIZUlFJfBknGS87nmga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IJgNMTIM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YDLpBnsD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IJgNMTIM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YDLpBnsD"
Date: Mon, 31 Aug 2026 16:19:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788185951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fY9FkrWPyWj0ZgYccDxYtQRH8Ojx2I+KpYWeK1aZjSs=;
	b=IJgNMTIMa9qcuZqyQE+GWQmT7cQgtDV9HIZlDG+9zc4n8ry57LubvX9cN0NcV9TybkqM3z
	USaydmSmVjyyUm+3MS8IpLX+GPDIICU330OOMpKw/BwMUblf8gAPONtX90GufQu2LUT58s
	1tI2FVuP32tPuYLetmGEy18q/P01FFG6REUmB2uuqv1I73zUrGjcPnKSbrHqfIEyzjOCt3
	Aybhz5fr1Aw/+BnUPkvJngpbfn/GRZfa8uBO6vXA6muOIGleAe8PIfqaSRm+WZq7ui281O
	0b5u8OCx3UvWSblltmM5vardsl8wETIXZPeFqLeW5JOcO/07Dn4k1Kae9t2Tkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788185951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fY9FkrWPyWj0ZgYccDxYtQRH8Ojx2I+KpYWeK1aZjSs=;
	b=YDLpBnsDa5JKA0InFyvu7EzOe/ogs1h3Xq99G44tWTp3Fqgj4tW3yhLruINH7w66+25ZI0
	U7piwSBCg7GzteBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>, suleiman@google.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
Message-ID: <20260831141909.WrGjMogw@linutronix.de>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de>
 <20260828135947.GU776954@noisy.programming.kicks-ass.net>
 <CAOiLmNHrbXeTY7zoNodmaZUoMWf+NgvGvZ_LjfWD-1sKAoiLeQ@mail.gmail.com>
 <20260829084901.GA776954@noisy.programming.kicks-ass.net>
 <apLxcg3Lgy0-nXA4@casper.infradead.org>
 <20260831073619.Ssq-wt7s@linutronix.de>
 <0849e5ca-6dec-4cf9-83ac-89ab08364044@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0849e5ca-6dec-4cf9-83ac-89ab08364044@kernel.org>

On 2026-08-31 16:03:38 [+0200], Vlastimil Babka (SUSE) wrote:
> On 8/31/26 09:36, Sebastian Andrzej Siewior wrote:
> > On 2026-08-29 15:49:22 [+0100], Matthew Wilcox wrote:
> >> On Sat, Aug 29, 2026 at 10:49:01AM +0200, Peter Zijlstra wrote:
> >> > > On PREEMPT_RT, it is necessary to skip the call to
> >> > > alloc_pages_nolock_noprof() from under pi_lock, since with that
> >> > > configuration spin_trylock can end up needing to take pi_lock. But at
> >> > > least on !PREEMPT_RT, there is no risk of deadlock.
> >> > 
> >> > Yeah, which puts the lie to that horrific hack Alexei did. We should
> >> > probably teach lockdep about spin_trylock() not being safe and see the
> >> > house of cards crumble.
> 
> Is it already happening then?
> 
> https://lore.kernel.org/all/20260831053846.107974-1-ngocthang2710.1999@gmail.com/

here I would strip kfree_rcu_sheaf() from the kfree_rcu().

> >> Why is spin_trylock() unsafe on PREEMPT_RT?  It's not intuitive since
> >> one can mutex_trylock() in interrupt context or under spinlock.
> > 
> > no, you shouldn't do mutex_trylock() in IRQ. There was something, I
> > don't remember but that is the reason people use semaphores because it
> > is okay to do down_trylock() in IRQ. It might be unlock path. 
> 
> Is it what this comment (recently moved to can_spin_trylock()) explains?
> 
>         /*
>          * In PREEMPT_RT spin_trylock() will call raw_spin_lock() which is
>          * unsafe in NMI. If spin_trylock() is called from hard IRQ the current
>          * task may be waiting for one rt_spin_lock, but rt_spin_trylock() will
>          * mark the task as the owner of another rt_spin_lock which will
>          * confuse PI logic, so return immediately if called from hard IRQ or
>          * NMI.
>          *
>          * Note, irqs_disabled() case is ok. spin_trylock() can be called
>          * from raw_spin_lock_irqsave region.
>          */
>         if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))           
>                 return false;
> 
> Of course checking for being under raw_spinlock_t can't be added like this,
> hm.

Yes.

Sebastian
