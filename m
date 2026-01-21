Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90CF3A63EA;
	Wed, 21 Jan 2026 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769030855; cv=none; b=X10lsFgQlRYQAd64i/753Ub2E3SahiCAxOGGfkT0qlxzOmi7iPG4MV2VqMmfHQ7nKVGQbPa4+d7iB4QsZ0hz4c669qEC2G+ip4yPYGP05Rn+6cmJ78ru2MFgGUwKB/GIukJ/rC3Bf+7zYoOMz3UBevZD9DFS5zvBx2gLDgG5mYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769030855; c=relaxed/simple;
	bh=wHIw5TPm4O6V3ga3pvGbmOKiv5XwGhHbujwaaUmkcig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOfdreQmCgTYCc7vNcL/yR5r38hz3d0ehMdMFkE35qFo75jCapLUby8ad4AJyhS7fmVWd1FHNo2RZ/dcHR5JKWyyGQU+4MhXP2qhWJhmC/FeXPDxX+e2jH7cs4c/mV6gmii+FXNHq/ySxj/3m/HbkeAjWoPLKLwX+1NtIxdKOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iR0WgM55; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iR0WgM55"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C295C4CEF1;
	Wed, 21 Jan 2026 21:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769030852;
	bh=wHIw5TPm4O6V3ga3pvGbmOKiv5XwGhHbujwaaUmkcig=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=iR0WgM55VOt/E2Nayn/DT1ITw6fKryAlV+r3QB7FriJX8eC1r8XR6i+ePxfBvtZzv
	 KhzzNqPNcvu/Jxwm1WXV5AevamPSX1b4DYndcVNHs00yKVMmWQ7vl3AqshiGXllxdC
	 eCjZXQm9pmlNwk2u84VUP45+LyNUbixckuFjxsJgl2TncSDguX1w3CtuZXa/ixY+uW
	 Tf8nkLX4q9h985aIjHk18AKdsCW8yQDmrMYKNTQoDSSbsvFbCqQd/BaF+CYBGLO7Rv
	 aM8THwkQXd7V0WKIzpxlfdiOjuFjPaArL341mvGsuIguuOi5s97WLJXAgE0wTrDPbq
	 N1I/mKxP+noVg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0B155CE0B2C; Wed, 21 Jan 2026 13:27:32 -0800 (PST)
Date: Wed, 21 Jan 2026 13:27:32 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Waiman Long <llong@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Mike Rapoport <rppt@kernel.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH] mm/mm_init: Don't call cond_resched() in
 deferred_init_memmap_chunk() if rcu_preempt_depth() set
Message-ID: <13d0b8b5-1ba7-4a3e-a686-13a7b993d471@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260121191036.461389-1-longman@redhat.com>
 <20260121114330.6cd34b4732c7803f1720f0ba@linux-foundation.org>
 <0e385146-67a3-4fdd-b119-059caba8c5f0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e385146-67a3-4fdd-b119-059caba8c5f0@redhat.com>

On Wed, Jan 21, 2026 at 03:07:46PM -0500, Waiman Long wrote:
> On 1/21/26 2:43 PM, Andrew Morton wrote:
> > On Wed, 21 Jan 2026 14:10:36 -0500 Waiman Long<longman@redhat.com> wrote:
> > 
> > > Commit 3acb913c9d5b ("mm/mm_init: use deferred_init_memmap_chunk()
> > > in deferred_grow_zone()") made deferred_grow_zone() call
> > > deferred_init_memmap_chunk() within a pgdat_resize_lock() critical
> > > section with irqs disabled. It did check for irqs_disabled() in
> > > deferred_init_memmap_chunk() to avoid calling cond_resched(). For a
> > > PREEMPT_RT kernel build, however, spin_lock_irqsave() does not disable
> > > interrupt but rcu_read_lock() is called. This leads to the following
> > > bug report.
> > > 
> > >    BUG: sleeping function called from invalid context at mm/mm_init.c:2091
> > >    in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
> > >    preempt_count: 0, expected: 0
> > >    RCU nest depth: 1, expected: 0
> > >    3 locks held by swapper/0/1:
> > >     #0: ffff80008471b7a0 (sched_domains_mutex){+.+.}-{4:4}, at: sched_domains_mutex_lock+0x28/0x40
> > >     #1: ffff003bdfffef48 (&pgdat->node_size_lock){+.+.}-{3:3}, at: deferred_grow_zone+0x140/0x278
> > >     #2: ffff800084acf600 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1b4/0x408
> > >    CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.19.0-rc6-test #1 PREEMPT_{RT,(full)
> > > }
> > >    Tainted: [W]=WARN
> > >    Call trace:
> > >     show_stack+0x20/0x38 (C)
> > >     dump_stack_lvl+0xdc/0xf8
> > >     dump_stack+0x1c/0x28
> > >     __might_resched+0x384/0x530
> > >     deferred_init_memmap_chunk+0x560/0x688
> > >     deferred_grow_zone+0x190/0x278
> > >     _deferred_grow_zone+0x18/0x30
> > >     get_page_from_freelist+0x780/0xf78
> > >     __alloc_frozen_pages_noprof+0x1dc/0x348
> > >     alloc_slab_page+0x30/0x110
> > >     allocate_slab+0x98/0x2a0
> > >     new_slab+0x4c/0x80
> > >     ___slab_alloc+0x5a4/0x770
> > >     __slab_alloc.constprop.0+0x88/0x1e0
> > >     __kmalloc_node_noprof+0x2c0/0x598
> > >     __sdt_alloc+0x3b8/0x728
> > >     build_sched_domains+0xe0/0x1260
> > >     sched_init_domains+0x14c/0x1c8
> > >     sched_init_smp+0x9c/0x1d0
> > >     kernel_init_freeable+0x218/0x358
> > >     kernel_init+0x28/0x208
> > >     ret_from_fork+0x10/0x20
> > > 
> > > Fix it by checking rcu_preempt_depth() as well to prevent calling
> > > cond_resched(). Note that CONFIG_PREEMPT_RCU should always be enabled
> > > in a PREEMPT_RT kernel.
> > > 
> > > ...
> > > 
> > > --- a/mm/mm_init.c
> > > +++ b/mm/mm_init.c
> > > @@ -2085,7 +2085,12 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
> > >   			spfn = chunk_end;
> > > -			if (irqs_disabled())
> > > +			/*
> > > +			 * pgdat_resize_lock() only disables irqs in non-RT
> > > +			 * kernels but calls rcu_read_lock() in a PREEMPT_RT
> > > +			 * kernel.
> > > +			 */
> > > +			if (irqs_disabled() || rcu_preempt_depth())
> > >   				touch_nmi_watchdog();
> > rcu_preempt_depth() seems a fairly internal low-level thing - it's
> > rarely used.
> That is true. Beside the scheduler, workqueue also use rcu_preempt_depth().
> This API is included in "include/linux/rcupdate.h" which is included
> directly or indirectly by many kernel files. So even though it is rarely
> used, but it is still a public API.

It is a bit tricky, for example, given a kernel built with both
CONFIG_PREEMPT_NONE=y and CONFIG_PREEMPT_DYNAMIC=y, it will never
invoke touch_nmi_watchdog(), even if it really is in an RCU read-side
critical section.  This is because it was intended for lockdep-like use,
where (for example) you don't want to complain about sleeping in an RCU
read-side critical section unless you are 100% sure that you are in fact
in an RCU read-side critical section.

Maybe something like this?

	if (irqs_disabled() || !IS_ENABLED(CONFIG_PREEMPT_RCU) || rcu_preempt_depth())
		touch_nmi_watchdog();

This would *always* invoke touch_nmi_watchdog() for such kernels, which
might or might not be OK.

I freely confesss that I am not sure which of these is appropriate in
this setting.

							Thanx, Paul

> > Is there a more official way of detecting this condition?  Maybe even
> > #ifdef CONFIG_PREEMPT_RCU?
> > 
> I am not aware of a more official way of detecting this. Maybe Sebastian has
> some ideas. rcu_preempt_count() is defined whether CONFIG_PREEMPT_RCU is
> defined or not. So we don't need a "#ifdef CONFIG_PREEMPT_RCU". Maybe I
> should explicitly include "include/linux/rcupdate.h" in mm/mm_init.c just to
> be sure.
> 
> CONFIG_PREEMPT_RCU defaults to on if PREMPT_RT is set. With
> !CONFIG_PREEMPT_RCU, rcu_preempt_depth() is hard-coded to 0 and will be
> optimized out.
> 
> Cheers,
> Longman
