Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA033B6EF
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 16:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581703; cv=none; b=jz+OjEurTYf+PsGQU8QrykydiY5VKZ9yC+c2u2Tj1nbWF8XwwpK4QiyowYys8QHgKoMsj81RpUi3GFsN/RIE9G9ILUSlN8kCWnbppqF9hmuQLe0Eyc5WvEvyNTNbrJ7QyO+5aPZzPGe3jer1X2OcPzA/7leAwqJEXSoa/qnJhFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581703; c=relaxed/simple;
	bh=W5qqiffb+6g0QVwSlVFeG2w/0xxRiZ8Rl/H/1wBjfK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQgdgeX0JNEeeOtwFms30TFzV/xjiutjC25eHKdfnsSZVZ5e95FjN0tbqW8ANQ2Rh4rabtInbC0D6GCIK8wRcKQojFA7OwjbVzv2eO260X4JBpHyFjvhLIUuAoL6v1+WDC7NPz3cmi37EpVxgofKN8ocTOj6FudO38IFS4RFHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ljkU0wOj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vb3vzNeB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ljkU0wOj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vb3vzNeB"
Date: Fri, 16 Jan 2026 17:41:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768581700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBUoLPWSKpuo6CuQ7wHh1j/tBavqQozUcWFWj2skMc4=;
	b=ljkU0wOjmbbu5GdN+yCB8VOn1tVFTyrVsfDFIMwgb33xhlIGtrAsyj8g0auZ3q+LoaM4uL
	0C/Xm6SsCSRGHmedgnJzPcPWMuVQlJsOTm7syhXXp0ypY9dH6ORAh+pqzwQeWZdt8m0cbs
	4yxNneclfyIyuWWCPvszFVmcaENUkMFD+nEhAr9lhbe7VTlLNJ+9i0U4kAo9ZZ4wT7ca/w
	ZyB73DkJitApkow0nL4ODJUJcETrPV4iLXTzExafkOUIC28RUsJgYZQZnbGxxljscvpl84
	mZFS//ohc80U2Ji4TT1ABDqIdADQiLuSve3Xis8y1dr/8ruKtGn4covJmZa1eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768581700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VBUoLPWSKpuo6CuQ7wHh1j/tBavqQozUcWFWj2skMc4=;
	b=vb3vzNeB7UJoIXhaDc97Gvm0agwiYu0/lVifQ07a84Kj9AcG9tGBrGCwRN29Plw4/ZnUDr
	Wnzhe/NmnNWTvjDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shakeel Butt <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RESEND 1/3] locking: add rwsem_is_write_locked(), update
 non-lockdep asserts
Message-ID: <20260116164139.8Sm2sJxG@linutronix.de>
References: <cover.1768569863.git.lorenzo.stoakes@oracle.com>
 <8e343ccb9319433364f5949a69519f1bb521fc8a.1768569863.git.lorenzo.stoakes@oracle.com>
 <20260116151215.GH831050@noisy.programming.kicks-ass.net>
 <99818e30-9f88-4751-af82-0bed019156eb@lucifer.local>
 <20260116155743.AuMKcTAO@linutronix.de>
 <5ca7b2a2-1e9d-4d90-8459-1aa35b30b49c@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5ca7b2a2-1e9d-4d90-8459-1aa35b30b49c@lucifer.local>

On 2026-01-16 16:21:29 [+0000], Lorenzo Stoakes wrote:
> On Fri, Jan 16, 2026 at 04:57:43PM +0100, Sebastian Andrzej Siewior wrote:
> > On 2026-01-16 15:50:24 [+0000], Lorenzo Stoakes wrote:
> > > No, but we need to be able to assert that one of two locks are held and we
> > > don't want the failure of one being held to cause an assert when the other
> > > isn't.
> >
> > But why don't you use the lockdep based check? That assert only ensures
> 
> Not sure what you mean, the checks I'm adding don't exist yet.

The checks you add are not lockdep.

> > that it is locked at the time you did the check. This does not mean you
> > are owner - it could be owned by another task which is unrelated to your
> > cause.
> 
> Yup I'm aware that lockdep tests more than a simple assert.
> 
> I wasn't aware this was possible with the lockdep primitives, mea culpa.
> 
> Also this came out of a previous discussion where I added a similar
> predicate vma_is_detached() and Suren suggested similar for the locks.
> 
> Anyway, I went and looked and yes I see there's lockdep_is_held() for
> instance.
> 
> However, I'd STILL need to do what I'm doing here to account for
> CONFIG_DEBUG_VM && !CONFIG_LOCKDEP configurations right?

Without CONFIG_LOCKDEP the locking view is not really accurate. So maybe
it is not worth doing it. The complains are that lockdep is too slow but
the other checks are just "is it locked by someone? - fine". 

> So I'll respin later with if (IS_ENABLED(CONFIG_LOCKDEP)) ...
> And sprinkle with some lockdep_is_held() and see how that works.
> 
> I mean rwsem_is_locked() is already specified, so naming is going to be a
> thing now but I guess:
> 
> static inline bool rwsem_is_locked_nolockdep(const struct rw_semaphore *sem)
> {
> 	return rw_base_is_locked(&sem->rwbase);
> }
> 
> static inline bool rwsem_is_locked(const struct rw_semaphore *sem)
> {
> 	if (IS_ENABLED(CONFIG_LOCKDEP))
> 		return lockdep_is_held(sem);
> 
> 	return rwsem_is_locked_nolockdep(sem);
> }
> 
> And obviously equivalent for the write case is what's necessary now right?

I would drop the rwsem_is_locked.* and just go with
lockdep_assert_held()/ lockdep_assert_held_write(). Unless you want that
verification in production because it is important and false positives
(as in held by other thread and not caller) are zero.

> Or am I misunderstanding you?

Sebastian
