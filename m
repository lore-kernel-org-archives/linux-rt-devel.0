Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CC8367B7B
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 07:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928201; cv=none; b=a15O5yDvxOvG0jFcn+nCck2HRqWClv58P3NtgsY047+4UMyp8VoUicVrnP6Za/rfLeVovKLsnN2iKhr1kCBNbX+ykZArZMyJ08kOGeuJWejU+tdqJM2bT3CWsl7j6nuxn9nDCAlWN95gR9lIAdlBlYDl57xnnlED1FiWUnPJJPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928201; c=relaxed/simple;
	bh=mHCZKAcQUBimskWiWG6NLWBjA8DyFG2wLO0Pm3mvtdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPgIE6Yxz258ssdSboUPOOj0FbfkrqMO3jWarD2nGTg95odussC/r4z954gKe9sGyzEzMTUsD2HZIc+wFKhdHRV2J0Lf7lcBPiOGnhhH4aJcpq46VHVb8tkEiKy7pcUNKlse8l63sPmm9/jKMCAH1B/hOJHof200vJF4Chmfygc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W0U7mlyj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SP6eoOrW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W0U7mlyj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SP6eoOrW"
Date: Mon, 13 Jul 2026 09:36:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783928197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oJ+oiAJmm6M2K7Ydw/ek8HK5Sp2SDGAkvAxlUMtUw8=;
	b=W0U7mlyjOkyC/qu/kf7Rx/Jyuc+9x1Bjgu+Si4Q/HR8XmxUngDgHeyNGyfbLVKEwQx9Js+
	TchO0iSQvF6zRyH4qCapFqKVvF4i6a5kiKjoA6OtHPnCdvOjtrGNgIMsHKzNBqKHaQnc/m
	whwu/Kg6jRa4Ec4PoqjhNVaiHyDF9MkI34iflFI4YvHwk5Qw4ddaxEeHf3nhXSr/51E1dd
	cW+WLkQG5DuD1uhX3ZCGTkZS/N4hmYTl3n3tTSDBTosSCmCoRBgNk5o6UV/hEKmwvAPYkl
	NMdrDjyEdLildLm2JagNZdO/2vvZaQ3o3/clC8VBAInNYKWOdCGxZw3wUTf+VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783928197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+oJ+oiAJmm6M2K7Ydw/ek8HK5Sp2SDGAkvAxlUMtUw8=;
	b=SP6eoOrWruZC728Gbiktd+y7UFnGggX0GuRBK1mtb4RABNg/mE/y0Jy9niGxN4YM+I/pVQ
	m+9W2TOgais4OLDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Leonardo Bras <leobras.c@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Gary Guo <gary@garyguo.net>, Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>, Masahiro Yamada <masahiroy@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 4/4] slub: apply new pw_queue_on() interface
Message-ID: <20260713073634.3Hrxpfcx@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com>
 <20260519012754.240804-5-leobras.c@gmail.com>
 <20260520145308.nay9zt6r@linutronix.de>
 <alQWr2L_Kn23pxd9@WindFlash>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alQWr2L_Kn23pxd9@WindFlash>

On 2026-07-12 19:35:28 [-0300], Leonardo Bras wrote:
> On Wed, May 20, 2026 at 04:53:08PM +0200, Sebastian Andrzej Siewior wrote:
> > On 2026-05-18 22:27:50 [-0300], Leonardo Bras wrote:
> > > @@ -4733,121 +4735,121 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
> > >  
> > >  	/*
> > >  	 * We assume the percpu sheaves contain only local objects although it's
> > >  	 * not completely guaranteed, so we verify later.
> > >  	 */
> > >  	if (unlikely(node_requested && node != numa_mem_id())) {
> > >  		stat(s, ALLOC_NODE_MISMATCH);
> > >  		return NULL;
> > >  	}
> > >  
> > > -	if (!local_trylock(&s->cpu_sheaves->lock))
> > > +	if (!pw_trylock_local(&s->cpu_sheaves->lock))
> > >  		return NULL;
> > 
> > alloc_from_pcs() can be called from kmalloc_nolock()/ NMI context.
> > I don't remember why exactly local_trylock_t was introduced here instead
> > of a per-CPU spinlock_t. 
> 
> Probably to save the cost of using atomic operations on locking, and having 
> about the same restrictions that would allow using local_locks
> 
> > But there should be nothing wrong with a
> > trylock on it from NMI as you do here.
> 
> Awesome!

The problem is always the unlock which requires full locking and is
usually the problem from NMI.

> > 
> > One thing worth noting, on !PREEMPT_RT, spin_trylock() always succeeds
> > on UP. kmalloc_nolock() checks for it, not sure about other callers.
> 
> 
> Sorry, I did not sure I understand that part. 
> You mean we have since it always returns true, we may be in NMI context, 
> after it was interrupted holding this lock, and it will return true which 
> will use the protected area even though the lock should avoid it?

from include/linux/spinlock_api_up.h:
| static __always_inline int _raw_spin_trylock(raw_spinlock_t *lock)
|         __cond_acquires(true, lock)
| {
|         __LOCK(lock);
|         return 1;
| }

on UP a spin_trylock() always succeeds.

> Humm, but if that scenario exist, then is it actually ok to return true on 
> trylock() in that scenario?
> 
> Thanks!
> Leo

Sebastian
