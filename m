Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF293C1976;
	Wed, 21 Jan 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769024611; cv=none; b=gLSvXZzUno2iV+/n5nythCpKRB2V/eJEJxYvj8VOeqMbtgrLWZs/LzloqiYwwh7yLTOdwnqRJHLbiI0dczb6lynG/A7A4gRfvso0YDp1TsEstE8VG9lGEWm+5j+dlyLeuTvrxZ1tVXWXAnX2ODCPEmaR5DrU8RL06udq3EJT25k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769024611; c=relaxed/simple;
	bh=fcYWIsY0a8jIMini5uUJGd2fm0NxOpMRtgEzKTWhHT4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=n8ReqxZu8ACIs/fTL6YD0rjVjO5pbfPsuGIImlgZWJhbF69N1CTd4i+DOZvtAIdo6k4SuHbp3RyxV5dzyXpKrHFP4Y//3zL9n2m3M3VdXhYHqFNXW3tLwEdorKR1pF5XmI1Mosu4cQ4c331ktZTE0OWOI+NLxLaXgxLX+ure+KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QRyULm6C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QRyULm6C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0EEC4CEF1;
	Wed, 21 Jan 2026 19:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1769024611;
	bh=fcYWIsY0a8jIMini5uUJGd2fm0NxOpMRtgEzKTWhHT4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRyULm6CgvL82pTCiKEubsSOP4+Sp5QzXCaiAOxoy0mSmABrwU+dA5Dn6zJDej0bG
	 FIt8bQf2R1qzEjPkHh+U2/phU6X/z7WYVfwrIRCXDoeyJvDC9jA1yysvMVrOWZ5lNF
	 fcxZXM9IBFBfEJ62arS8BA7Hv6Zgk8SM5odv+KCE=
Date: Wed, 21 Jan 2026 11:43:30 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: Mike Rapoport <rppt@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Wei Yang
 <richard.weiyang@gmail.com>, David Hildenbrand <david@kernel.org>,
 "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH] mm/mm_init: Don't call cond_resched() in
 deferred_init_memmap_chunk() if rcu_preempt_depth() set
Message-Id: <20260121114330.6cd34b4732c7803f1720f0ba@linux-foundation.org>
In-Reply-To: <20260121191036.461389-1-longman@redhat.com>
References: <20260121191036.461389-1-longman@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Jan 2026 14:10:36 -0500 Waiman Long <longman@redhat.com> wrote:

> Commit 3acb913c9d5b ("mm/mm_init: use deferred_init_memmap_chunk()
> in deferred_grow_zone()") made deferred_grow_zone() call
> deferred_init_memmap_chunk() within a pgdat_resize_lock() critical
> section with irqs disabled. It did check for irqs_disabled() in
> deferred_init_memmap_chunk() to avoid calling cond_resched(). For a
> PREEMPT_RT kernel build, however, spin_lock_irqsave() does not disable
> interrupt but rcu_read_lock() is called. This leads to the following
> bug report.
> 
>   BUG: sleeping function called from invalid context at mm/mm_init.c:2091
>   in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
>   preempt_count: 0, expected: 0
>   RCU nest depth: 1, expected: 0
>   3 locks held by swapper/0/1:
>    #0: ffff80008471b7a0 (sched_domains_mutex){+.+.}-{4:4}, at: sched_domains_mutex_lock+0x28/0x40
>    #1: ffff003bdfffef48 (&pgdat->node_size_lock){+.+.}-{3:3}, at: deferred_grow_zone+0x140/0x278
>    #2: ffff800084acf600 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1b4/0x408
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W           6.19.0-rc6-test #1 PREEMPT_{RT,(full)
> }
>   Tainted: [W]=WARN
>   Call trace:
>    show_stack+0x20/0x38 (C)
>    dump_stack_lvl+0xdc/0xf8
>    dump_stack+0x1c/0x28
>    __might_resched+0x384/0x530
>    deferred_init_memmap_chunk+0x560/0x688
>    deferred_grow_zone+0x190/0x278
>    _deferred_grow_zone+0x18/0x30
>    get_page_from_freelist+0x780/0xf78
>    __alloc_frozen_pages_noprof+0x1dc/0x348
>    alloc_slab_page+0x30/0x110
>    allocate_slab+0x98/0x2a0
>    new_slab+0x4c/0x80
>    ___slab_alloc+0x5a4/0x770
>    __slab_alloc.constprop.0+0x88/0x1e0
>    __kmalloc_node_noprof+0x2c0/0x598
>    __sdt_alloc+0x3b8/0x728
>    build_sched_domains+0xe0/0x1260
>    sched_init_domains+0x14c/0x1c8
>    sched_init_smp+0x9c/0x1d0
>    kernel_init_freeable+0x218/0x358
>    kernel_init+0x28/0x208
>    ret_from_fork+0x10/0x20
> 
> Fix it by checking rcu_preempt_depth() as well to prevent calling
> cond_resched(). Note that CONFIG_PREEMPT_RCU should always be enabled
> in a PREEMPT_RT kernel.
>
> ...
> 
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2085,7 +2085,12 @@ deferred_init_memmap_chunk(unsigned long start_pfn, unsigned long end_pfn,
>  
>  			spfn = chunk_end;
>  
> -			if (irqs_disabled())
> +			/*
> +			 * pgdat_resize_lock() only disables irqs in non-RT
> +			 * kernels but calls rcu_read_lock() in a PREEMPT_RT
> +			 * kernel.
> +			 */
> +			if (irqs_disabled() || rcu_preempt_depth())
>  				touch_nmi_watchdog();

rcu_preempt_depth() seems a fairly internal low-level thing - it's
rarely used.

Is there a more official way of detecting this condition?  Maybe even
#ifdef CONFIG_PREEMPT_RCU?
