Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22785332EC8;
	Sat, 29 Aug 2026 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787992790; cv=none; b=GI16cOG/7D1Kk5L3tMwSylSwz2M2g9oF15PTW5hIdJHquF63KTFav+lrBzgPLFWCsdlx98FlcLLvXcvTEUQzuHBqBk3gmhnvE1/BKpAAIciv3lojJLeciwvU02Wbf9Igl5XeKq7Nm8A7XZjKfB4OxjYcDnreeR3rU5jBhT20Ls8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787992790; c=relaxed/simple;
	bh=4hB+9zIhf+45dhPQDpAFRpcEeWXIKWIg53mmhlbpWGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyoOAKcHk6Qu59zpYT2aW/lgcaYiCLk8lsx7KpI8GG6xKSkMe/E2xle8nocnZBzrxMxzdzmWgTv/m2NF3uIZ0evLsQtfBOGu0He52mooAfEU3MS2l+mYatdQPJ+vWcyLgkR+cc+KE5v2avPPQtoASqUbpkbVwTf8gZArtS9cFQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZahZMba6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZahZMba6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=RETR9ZdOPAaJvJ2OaRnDzRNeiap5w2m3NE8auivvriM=; b=ZahZMba6YhGKTDAO0it9zThjzz
	qVFXjLyX9C94Dx+HFaJOa88kQDZap5Jeb+13KyHd0/9uToz0Dt7AlGI55zenIlLQBEqoczN8iuTu0
	lcZroASoO7g7JUUzZYe4zw9Ryu9lOmTI3fBvMBTjU4+nBPFQsw8pVqnvRfq/GHWWy1JqOB796HsqN
	N5s4wqHnJiC/+ySxurnFsFV9JdZLBGXTrp5TPvCQPfJhjg93D0WZuA6gzN1D4w2gkn0WMeJq70/9e
	F/QsyB+1jst0mjCSS8+68Sg0INtvJS6/UK3fv7jsyJMn1K81YfUfBNGA0dIJwBfdpEmOOT4MXeKjs
	V2Ea1z2A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0Eb3-0000000GD4W-4BR2;
	Sat, 29 Aug 2026 08:39:30 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 72E64300382; Sat, 29 Aug 2026 10:39:29 +0200 (CEST)
Date: Sat, 29 Aug 2026 10:39:29 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: David Stevens <stevensd@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>, suleiman@google.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev
Subject: Re: [RFC 06/10] Reclaim memory from blocked kernel stacks
Message-ID: <20260829083929.GZ776954@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828120408.GN687043@noisy.programming.kicks-ass.net>
 <CAOiLmNHWGSwAqH815X3JWMrQCc2nh-fRNsNZ0hjQGv8JvFndag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiLmNHWGSwAqH815X3JWMrQCc2nh-fRNsNZ0hjQGv8JvFndag@mail.gmail.com>

On Fri, Aug 28, 2026 at 05:18:05PM -0700, David Stevens wrote:
> On Fri, Aug 28, 2026 at 5:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Aug 27, 2026 at 04:29:44PM -0700, David Stevens wrote:
> > > @@ -4320,8 +4319,18 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
> > >                * A similar smp_rmb() lives in __task_needs_rq_lock().
> > >                */
> > >               smp_rmb();
> > > -             if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
> > > +             if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags)) {
> > > +                     trace_sched_waking(p);
> > > +                     break;
> > > +             }
> > > +
> > > +             if (!ensure_stack_is_present(p, &need_deferred_repopulate)) {
> > > +                     WRITE_ONCE(p->__state, TASK_STACK_RECLAIM);
> > > +                     do_deferred_repopulate_wake = need_deferred_repopulate;
> > >                       break;
> > > +             }
> > > +
> > > +             trace_sched_waking(p);
> >
> > Absolutely not; ensure_stack_is_present() must not call
> > repopulate_stack() while holding ->pi_lock. Not happening.
> 
> The optimistic fast path for repopulate_stack() could be modified to
> try pulling from a pre-allocated pool of zero'ed pages. That would
> reduce the function to a couple of memcg_kmem_charge_page() calls and

Afaict memcg_kmem_charge_page() ends up in a local_lock, which is a
spinlock, so that cannot be.

Most, if not everything, in mm/ is build around being preemptible and
thus not suitable for use under raw_spinlock_t.

> then vmap_pages_range() to repopulate the stack's page tables. That

vmap_page_range() can end up in the allocator, which I suppose is ruled
out by the vmap having been populated before, but it still has a
might_sleep() that will scream AFAICT.

> wouldn't require touching any locks except a raw_spinlock protecting
> the pre-allocated pool (or just make it per_cpu). In terms of cost,
> this would involve a couple of atomic operations for the page pool
> lock and the memcg charging plus non-atomic operations on 5-10 other
> cache lines.
> 
> Is that within the scope of what can be done under the pi_lock? If
> that's still not happening, I can see how things look if we always
> defer wakeup to a workqueue.

As long as it really is all atomics it should be fine. If there is a
lock, it must be raw_spinlock_t, but ideally no new locks nested under
pi_lock.

