Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A3557C9F;
	Fri, 28 Aug 2026 14:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925608; cv=none; b=MQl53OlgO1vfv9s7Iwgul8i6AA0aITt2gWw12YWptmiW47UjXtPMw82pHKrAlbWK/FqHXU6kFKzlnDN1KIJRrPBsG0WwBqk6q+29dXeCgyJfvK5dIlKFMZzeduFLl1UEUbfIyjRUay5U224hw3M+0f8drZjPh6+12V5OMCbDzyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925608; c=relaxed/simple;
	bh=bGgnoFrFidNEZffnwuT1K657Hs/NpOW53aHDHEol8EQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqOALBVCd7xElHw4sIq0IlqTawgcY22uB7jLBFvJ5aE+x1dTvk+ker4jWQke3/WGdc1kUFZZcS3SrdIESFYMGUmr9M8c98Vjh5SoJ8V/+vQ7G/PKt7/lojMM8+pNzNPyO0jfy48dvlkbFscIH8S99wLzhpU3cCfSlXTFwKEsboU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MGYbK7pg; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MGYbK7pg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Z/vQkPRWfO3dMD1qnZW0cONo4+Wv9gcM6DMq0ft41q4=; b=MGYbK7pgkLwreR1NbEJ2ExVAGl
	KTSjrpILVYOMD0bXalDOVqN/fVKi44fsPfymsoGuNmuRRaofeLVyUrTIHNb0siKB3sHW1QfFH/ElJ
	XJqv6SDJOSrPIt+kYiBVrZwpvDs7W76upT8P/0xg+JI1Uyn2mz5bsErnOPePpn3Q6EeVga+qZWe8P
	aFyvCXNgTh8vEzFs4LxWN7e6eFMAk6q9tFW/1D3cAhu4R2IZPpdqSf72p3g1JzFYqCHmn4H5doMo5
	+U3XKywepWEMgvPNZ8vWLa/1x4zGYEyw/PiASNH/8vyscBy1cgu06aUJ2BsbF/FK0ZwUBrskyEqax
	Yp9ajIzQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wzx7U-00000008IYq-40GE;
	Fri, 28 Aug 2026 13:59:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5325230030F; Fri, 28 Aug 2026 15:59:47 +0200 (CEST)
Date: Fri, 28 Aug 2026 15:59:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: David Stevens <stevensd@google.com>,
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
Message-ID: <20260828135947.GU776954@noisy.programming.kicks-ass.net>
References: <20260827232948.2520558-1-stevensd@google.com>
 <20260827232948.2520558-7-stevensd@google.com>
 <20260828133620._x2XfJR_@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828133620._x2XfJR_@linutronix.de>

On Fri, Aug 28, 2026 at 03:36:20PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-08-27 16:29:44 [-0700], David Stevens wrote:
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index fa7507ac8e13..adb4a5957996 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -1534,6 +1534,24 @@ config VMAP_STACK
> >  	  backing virtual mappings with real shadow memory, and KASAN_VMALLOC
> >  	  must be enabled.
> >  
> > +config HAVE_ARCH_RECLAIMABLE_STACK
> > +	def_bool n
> > +
> > +config RECLAIMABLE_STACK
> > +	default !PREEMPT_RT && !PROC_KCORE
> 
> This shouldn't default like this for RT. It either is useable or it is
> not.
> 
> > +	bool "Allow stacks of some blocked threads to be reclaimed"
> > +	depends on VMAP_STACK && !STACK_GROWSUP
> > +	depends on HAVE_ARCH_RECLAIMABLE_STACK
> > +	depends on !DEBUG_STACK_USAGE
> > +	depends on !KASAN_VMALLOC # TODO: add support for this
> > +	depends on !DEBUG_KMEMLEAK # TODO: add support for this
> > +	help
> > +	  Enable this to allow the unused portion of kernel stacks of most
> > +	  blocked tasks to be reclaimed.
> > +
> > +	  The wakeup latency of tasks with reclaimed stacks may increase,
> > +	  especially while the system is under memory pressure.
> 
> It says *may* increase and on RT it _definitely_ will increase since
> there is a kworker involved not to mention the memory allocation itself.
> Anyway. This either needs to stay away from PREEMPT_RT or find a way to
> exclude at the very least mlock()ed tasks.
> Did lockdep see this?

It should have. They're taking spinlock inside raw_spinlock and lockdep
should very much warn about that by default.

> If I understood the whole exercise correct then you have a kernel stack
> of two pages and in best case you can unmap and release the second page
> while the task is napping.

THREAD_SIZE_ORDER	2
THREAD_SIZE		(PAGE_SIZE << THREAD_SIZE_ORDER)

that makes for 4 pages.

> What might be a tad simpler is to memset(,0,) the remaining part of the
> stack. Since the stack is vmap-ed it should be swapped out on its own
> without additional tricks. That memset() would help zram to compress
> better so it uses less memory. ta-da.

That would still be a 12k memset with IRQs-disabled and rq->lock held.

> What also should be simpler (and I am not saying just to move you away
> from the scheduler) is to have a shrinker which iterates over all tasks
> which are marked for reclaim and then similar to swap just unmap both
> stack pages and release the second page which is not used.
> Upon wake up the task should create a page_fault which would be used to
> allocate the second stack page and map the whole stack again.

Right, so you can FREEZE the task, unmap its stack and then thaw it or
something. But there should be a definite opt-out on all this, because
taking faults on your stack will be horrible.

Not to mention you'll suffer wakeup latencies while frozen.

This all really sounds like what should be addressed is this insane
number of tasks rather than trying to cope with the consequences of
that.
