Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE73F45C6FA
	for <linux-rt-devel@lists.linux.dev>; Thu, 20 Aug 2026 13:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787232630; cv=none; b=Kj3T5ZLeS+EUFv+fCZROHdWhzR9Df3+HLWza14E9gfQdIlcF7jcC3yyL0iAvL3r9O1obG5mIqG+2TdFVkETvSCbtcAZ9wrPK7JSTt+fdHKQRz7htMLorubFkr6ZYUKrNYqRQ4Y2RDr0yefgrQsnGTDNXu/at1s81ROqAyJUNP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787232630; c=relaxed/simple;
	bh=TkUR3eg84C2wQNgwp6xVpowcFHmodQ5i03LpSgbOSzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6s/UJj0HN1krjTDnIG964CXdwApte2l0q95sxUnJLwV+Q1Szw90674kRI/ptVa74fZZwQJ3hU/1TEBlxTHkFxb+5rz1qZ6osk1JhlnVzvs36g/SK4aNHiPugCCy3fC5J8JWOLdaUpcBzKDDUtV6Dc+h3HoRhT2QdcAoddR3Kgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ElP4FyOS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j0/TWGAJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ElP4FyOS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j0/TWGAJ"
Date: Thu, 20 Aug 2026 15:30:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787232622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ASNA2n2ULlXCgF/csvU3xJ+NVPUzckfBtl899VP2uQ=;
	b=ElP4FyOSCqRqb+Pz69s3P2eYfQne5TxOixt6SdH8S2CopMBSZftuRFoSbGEy++xou/Yghi
	538wjhY1axt5CUInvKs6ZQ1MRy6ycYWKzB6ZupFgJiMo25KIAm2K7g13UPevbLKjFVzD45
	pcCNpr0cwpPtzfnRW2H/O29HtPhDYt004+TGnyvA4nIX0TgoLnmTYcQoEw8w7+3+/bru9T
	QNU5TLPExroibLaHPbe52kdIkgEnUlCPoEuUoBlxf25kD+Bg4x9/jBEHgm9vt3ATMBxi6t
	YmpdFraagC0M6kKHnxW+8i1Wv/yI6rexAV5dqA1rpNH68Rbme9mH83I8A/smjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787232622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2ASNA2n2ULlXCgF/csvU3xJ+NVPUzckfBtl899VP2uQ=;
	b=j0/TWGAJFkzJNx7Du3miqrUhSBSiWlaEQe10/wRY+y/76Ymy8VShiRRORIKazfzuJVO2sp
	lscicN1nOj4GtlCg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Michal Hocko <mhocko@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@google.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260820133020.7ZCRIhwX@linutronix.de>
References: <anwraNIKJV8zwrNT@tiehlicka>
 <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca>
 <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
 <20260812134934.GC662699@ziepe.ca>
 <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
 <fb87f673bf290cad133d113dbb0750a7752b9d30.camel@infradead.org>
 <a94b75e8b9b1d2191f365c0f4275fd5082332df5.camel@infradead.org>
 <CABgObfYjdQ13Gd9AH-kck85ZWch7j_E00rajawFuRdt5D=m3Sg@mail.gmail.com>
 <5364F424-42B7-4D1B-BE55-B6F9E68B0F2B@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5364F424-42B7-4D1B-BE55-B6F9E68B0F2B@infradead.org>

On 2026-08-12 18:49:50 [+0100], David Woodhouse wrote:
> >Making synchronize_srcu_atomic() spin in CONFIG_PREEMPT_RT is a
> >slightly tall request - it's basically putting it on the same level as
> >raw_spinlock. But if the MMU notifier guys really want to make OOM
> >notifiers atomic, this would be basically the only way to do so.
> >
> >If instead it's okay to remove nonblock_start/end under
> >CONFIG_PREEMPT_RT, for RT kernels I'd rather avoid
> >preempt_disable/enable and only make synchronize_srcu_atomic() try to
> >skip the index flip:
> >
> >   if (!try_synchronize_srcu(ssp))
> >      synchronize_srcu_expedited(ssp);
> 
> Yeah, so in the normal case it's truly atomic but in the RT case both
> readers and grace periods quietly start to sleep again... just like
> spinlocks in RT. That seems reasonable.

I just caught up with the thread.
The task_struct::non_block_count is not properly defined IMHO. It talks
about sleeping and atomic but it is fine to acquire a spinlock_t which
is a spinning lock on !RT.
The other user of non_block_start() is pwm_set_waveform_might_sleep()
where it is used if the pwmchip's lock is a spinlock_t and not a
mutex_t. Again, it seems fine to acquire a spinlock_t.

So it seems if a lock is acquired which is spinning on !RT and part that
these locks are turned into sleeping locks shouldn't lead to a problem.

The splat referenced in
	https://lore.kernel.org/all/787aa26cf62dfd361eea8ed19f384fc517892501.camel@infradead.org/

complains only about non_block, the other fields are zero.
In that case it is just a question of how might_sleep() is implemented
and we could skip the warning for the few locks that sleep on RT and
spin on !RT. (FTR: There is also no RCU warning on RT if we sleep
(schedule()) within a RCU read section while blocking on a spinlock_t
but there is a warning if we block on a mutex_t).

In
   https://lore.kernel.org/all/a94b75e8b9b1d2191f365c0f4275fd5082332df5.camel@infradead.org
there was a suggestion for "srcu: Add an ATOMIC reader flavor and a spinning
synchronize_srcu_atomic()". This one had preempt_disable() in
srcu_read_lock_atomic(). This is bad as not only forbids to acquire any
sleeping locks (such as spinlock_t) but it also does not allow any
scheduling of any kind within this section.

So if it is *just* the annoying splat on RT, I could try to teach
might_sleep() no to be upset here.

Sebastian
