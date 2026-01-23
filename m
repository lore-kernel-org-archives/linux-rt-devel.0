Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EE82D3225;
	Fri, 23 Jan 2026 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769158011; cv=none; b=B2ce4bcA2UEBaALk/xIQrjGG595S+tTLiuZ26deGmTuG/JbNwPC261K4C4jvKlnPVTqoWGOI7+7M4nJCQiw23yYG5P0NSjKZ7ly4CUJrwFgkNMcohm+/UiOO8k/67GRnT9Cl0Fb4I4khNH0rxXqLSS9YNa57fK/7Tk1V7d/LAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769158011; c=relaxed/simple;
	bh=zlDYEoOkDwoDamgPxSwYuVDpDkFq4ttprobmkbfSa0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hvYKLFmLr172lJbVhwyARVMHZCNGqF4PNLQNCZtYEE5FHh+MFAXAL6QisLudJwKXJdlCbfmcJ6/WBX3NE1wNeYRRuVcbbbvQ7ETClxdaMBWLMHXcoRC/HnbqOFDkrKI1cWiYfGwbucgKmxTtfAzLIm3+1hIzN2FMtrgCj7L5SPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMYi7O9W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMYi7O9W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF8B9C19423;
	Fri, 23 Jan 2026 08:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769158011;
	bh=zlDYEoOkDwoDamgPxSwYuVDpDkFq4ttprobmkbfSa0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pMYi7O9Wzk4xL+ptKZFskBEAy2sMbDOm21rkjCBTr3+31p+kgjN5ghCT3gKWYyQe5
	 eVaJBjV5V/Fo2ORr2P0xGrNN2fd8bluNWvUjOslB4mXahJXHK0aZ9WFz5EqxE0fI+m
	 RctiRAW9zH8dGPXigIaHsb5MwbrbqD2Jt27aYPxd+LiJlrrd5gBQ9Gk/MmjYNqJ/Bq
	 RU0zkQGrxBD7PcRxiucWCLvsDrBfeY/NdFZpUItPCUyvz8m5ksZLYTBz0ci6NHedY+
	 E3+W+e00I8qWZvMeCt91IM0DEwfMxoUmnHe2vCUWCYhpUXmGi+EMly11xgKB24ngut
	 n1yI2xhLvSrvg==
Date: Fri, 23 Jan 2026 10:46:44 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Wei Yang <richard.weiyang@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v3] mm/mm_init: Don't cond_resched() in
 deferred_init_memmap_chunk() if called from deferred_grow_zone()
Message-ID: <aXM1dF6o3wwJltiV@kernel.org>
References: <20260122184343.546627-1-longman@redhat.com>
 <20260122112920.2b435873a0cc5f396df5d1a7@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122112920.2b435873a0cc5f396df5d1a7@linux-foundation.org>

On Thu, Jan 22, 2026 at 11:29:20AM -0800, Andrew Morton wrote:
> On Thu, 22 Jan 2026 13:43:43 -0500 Waiman Long <longman@redhat.com> wrote:
> 
> > Commit 3acb913c9d5b ("mm/mm_init: use deferred_init_memmap_chunk()
> > in deferred_grow_zone()") made deferred_grow_zone() call
> > deferred_init_memmap_chunk() within a pgdat_resize_lock() critical
> > section with irqs disabled.
> >
> > It did check for irqs_disabled() in
> > deferred_init_memmap_chunk() to avoid calling cond_resched(). For a
> > PREEMPT_RT kernel build, however, spin_lock_irqsave() does not disable
> > interrupt but rcu_read_lock() is called. This leads to the following
> > bug report.
> > 
> >   BUG: sleeping function called from invalid context at mm/mm_init.c:2091
> >   in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
> >   preempt_count: 0, expected: 0
> >
> > @@ -2085,10 +2085,10 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
> >  
> >  			spfn = chunk_end;
> >  
> > -			if (irqs_disabled())
> > -				touch_nmi_watchdog();
> > -			else
> > +			if (can_resched)
> >  				cond_resched();
> > +			else
> > +				touch_nmi_watchdog();
> >  		}
> >  	}
> 
> Disables the cond_resched() in some situations.  Can this reintroduce
> the watchdog warnings which that cond_resched() was intended to
> prevent?
> 
> The cond_resched() was added by <dig, dig> da97f2d56bbd ("mm: call
> cond_resched() from deferred_init_memmap()").
> 
> Pasha's 2020 patch replaced touch_nmi_watchdog() with cond_resched() to
> prevent RCU stall warnings.  So I think the answer to my question is
> yes, going back to touch_nmi_watchdog() could reintroduce those RCU
> warnings.

Before 3acb913c9d5b ("mm/mm_init: use deferred_init_memmap_chunk() we had
touch_nmi_watchdog() in deferred_grow_zone() and cond_resched() in the
deferred_init_memmap()->deferred_init_memmap_chunk() that ran in a thread context.

I thought irqs_disabled() would be enough to differentiate these cases
because deferred_grow_zone() takes a spinlock, but I missed that with RT
spinlock also sleeps.

Using a boolean essentially restores the behaviour we had before the
refactoring.

-- 
Sincerely yours,
Mike.
