Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7C3E1CE4;
	Tue, 22 Sep 2026 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059283; cv=none; b=pG99aHt/H/OH96r1D8Yr3FOPVmiUxuXx/wWs+84VayC6wyml62/Wo1TAuGS79SrSyzxcENElbYs0697TkiQqB4alA5uAGqTkpXZJJw2gVtcUgxfMxArPOfTNeKCaXEkkXc/BNrM6/mnRpX10x+7ppz8G6Z4j6zBqxsbwMKrgwz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059283; c=relaxed/simple;
	bh=T/rooOz0bMUCZQoHz+LkMZ/52k8muHtt02qNmdUhTjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jie11Cr9nj+bLYaji//pcB9zRkPFCoP6vsX8ZSXMaZhu1MZ47hvrSiq0/5OQNbrY1C+qpGcB8NzQavt3UxCmC4vkJa/a2fgguotbPP79TwgzLDIAz5tKMcK9bsMtTFNh4tbPIcDxIFGLHw4MgBR4Q7nr2l+9vOI3APOoYGB+124=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ng4Zhz4O; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ng4Zhz4O"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pY6Tt3cbhiuu898NJ0FxQ3k1nT9mPSnOBzUUA1MwmA4=; b=Ng4Zhz4OfgMHYyQ6ifs+1zTLZB
	7HBG/Ed3fQUhgafz+k7pBzaMjSLCWUQGzRiz1GpaGr77oD3yKD+du5Uys6mfF6xLlMMxVYWV60neI
	SkfLzxapASC+ZZtYaX8zDxF7c6TwrIZZ/xGfpZhhj9id4gOUTPG4V/beO2v0h/GG8mIbA9sLlOMrL
	oUxLwAVJ7i93xAjgQKbmFK1Qj8IcBtwsosmCLFoTQdFm+OVY7F7qx/DZRgz4T8hqycaihBQzDY6ZD
	hVLwu3Mjb8pBjfUa0eEajYAh/ZZfxuiWmA+8JsnV03iJpfOltVyLS61mj2ppvVTlsuoOmMQWWPP7h
	ey2BZe6g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8uBj-00000007Maz-1aWu;
	Tue, 22 Sep 2026 06:41:11 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 29DCB300478; Tue, 22 Sep 2026 08:41:10 +0200 (CEST)
Date: Tue, 22 Sep 2026 08:41:10 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Quchaosheng <quchaosheng000406@163.com>
Cc: Ingo Molnar <mingo@redhat.com>, John Stultz <jstultz@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun@kernel.org>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] sched/proxy: allow SCHED_PROXY_EXEC with PREEMPT_RT
Message-ID: <20260922064110.GR4121339@noisy.programming.kicks-ass.net>
References: <20260921102712.3245860-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921102712.3245860-1-quchaosheng000406@163.com>

On Mon, Sep 21, 2026 at 06:27:12PM +0800, Quchaosheng wrote:
> CONFIG_SCHED_PROXY_EXEC could not be enabled together with
> CONFIG_PREEMPT_RT. The Kconfig entry carried a "depends on !PREEMPT_RT"
> with the comment "Avoid some build failures w/ PREEMPT_RT until it can be
> fixed", and the failures are real: building kernel/sched/core.c with both
> options set gives:
> 
>   kernel/sched/core.c:6927: error: passing argument 2 of 'clear_task_blocked_on' from incompatible pointer type
>   kernel/sched/core.c:6939: error: 'struct mutex' has no member named 'wait_lock'
>   kernel/sched/core.c:6943: error: implicit declaration of function '__get_task_blocked_on'
>   kernel/sched/core.c:6956: error: implicit declaration of function '__mutex_owner'
> 
> The proxy execution machinery tracks a task's blocked-on mutex through
> task_struct::blocked_on and walks that chain in find_proxy_task(). It was
> written against the native struct mutex, which embeds wait_lock directly
> and keeps the owner in atomic_long_t owner.
> 
> On PREEMPT_RT, struct mutex is instead a wrapper around struct rt_mutex,
> so both live in the embedded rt_mutex_base: wait_lock is
> rtmutex.wait_lock and the owner is reachable via rt_mutex_owner(). On top
> of that, the RT variants of the blocked_on accessors were stubbed out with
> a struct rt_mutex * parameter, so find_proxy_task() could not even compile.
> 
> The set of errors has two independent causes, addressed separately:
> 
> 1. Header type mismatch. The PREEMPT_RT branch of the blocked_on helpers
>    was declared with "struct rt_mutex *" while every caller passes a
>    "struct mutex *". That parameter type came from __ww_mutex_die() and
>    __ww_mutex_wound() in ww_mutex.h, which are shared with the WW_RT
>    instantiation where the MUTEX macro expands to struct rt_mutex. Those
>    two call sites are now compiled out for WW_RT, making the helpers
>    consistently take a "struct mutex *". This is not a behavioural change
>    for WW_RT: the blocked_on relation is only maintained for native
>    mutexes, and an rt_mutex based lock relies on the rtmutex priority
>    inheritance chain instead.
> 
> 2. Data structure access. Add mutex_wait_lock(), which returns the
>    wait_lock of either mutex implementation, and provide a
>    PREEMPT_RT __mutex_owner() that reads rt_mutex_base::owner, so that
>    find_proxy_task() works on both.
> 
> With that, the Kconfig restriction can be dropped.
> 
> Note that this makes the combination build and boot; it does not make
> proxy execution actually do anything useful on PREEMPT_RT. A task's
> blocked_on is only ever set by the native mutex slow path, which is
> compiled out when PREEMPT_RT is set, so task_is_blocked() is always false
> and find_proxy_task() is never reached. An rt_mutex already provides
> priority inheritance, so there is no blocked_on chain to follow either.
> Making proxy execution functional on PREEMPT_RT would require the RT
> mutex implementation to maintain blocked_on as well; that is not part of
> this change.
> 
> Verified with a full x86_64 build plus a QEMU boot of the resulting
> SMP PREEMPT_RT kernel, both with and without CONFIG_SCHED_PROXY_EXEC and
> with PROVE_LOCKING, DEBUG_ATOMIC_SLEEP and DEBUG_PREEMPT enabled. The
> kernel boots clean and an 8-thread SCHED_FIFO pthread mutex stress loop
> runs without any BUG or WARNING.
> 

I would like to wait with this until such time that we're are indeed
ready to drop rt_mutex entirely. Having the build option but it being
effectively 'broken' just doesn't make much sense to me.
