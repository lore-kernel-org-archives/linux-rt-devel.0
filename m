Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E178840757B
	for <linux-rt-devel@lists.linux.dev>; Fri,  5 Jun 2026 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780641080; cv=none; b=Xeqbfv3WJb5AegNp+REJd/sGWcRSL0ZauCodrUHYhMvh09EfE3ypxWY4HE7inmaxV4QYkQF2QTPwVhXM9Z+e1Q/tApoCAaCkWYQX2lHIBwADHcDaGWOpO2MHrUfCv9G/6Q2++/HwBmaqbQqWYMeUdaiLjMO3IszKPgf0rF7+ho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780641080; c=relaxed/simple;
	bh=pVvibre/UWFHBQKUMapnpGUW/jYbff3AR/kKjbgPY1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nesitaeLRlOTNkhiD1nIYyjz+SMzXQBYQ30NmMCoLOI3J2bnFpHEd2QP/cFis3UP/LEFabxV0YEwC+dxLrwJf5OLFfF9wffW9brCjCM6bB4hDb/UoqU34cRURDJqmCG6v8G9+r6xUOB/4vty6RBZuQMeQazJa1EkjPAS16L4YyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DhLCHq8W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xsbH183+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DhLCHq8W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xsbH183+"
Date: Fri, 5 Jun 2026 08:31:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1780641077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8yNhbgKtoyYFpFofUBfKnc/nlif5pzE+UC6FQ/29ds=;
	b=DhLCHq8W1NRL/svO+7xlfBdU1l3EDq3AKzVU7un1LcshSN2Hz7VFKBHRiC0C00/HDA+9zV
	5mE6rAwRfSkfLxSGlqK5AI9ru3zFxOqnVsiOo+LIDv4U3aECiG8gLmeMkAmOKNM0Y+6Z0w
	PhM84q50H4xoRPTFA4SoLYeYHIFURM5IRVHRmpR2OEHF0EuFe76fPEshEKYEdIgMabnW8o
	5IgAmvBwqxAiC1dBuoGZF2py5BiH50Umzc+pE4QHPi2gOY5KasU+XHxA+dkNFlln0+j5d+
	u6VGpB1qvEP4J+SUVSopL74F136JMfqF9X18fu04pimeEpSDuw3uF7ciWITtug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1780641077;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I8yNhbgKtoyYFpFofUBfKnc/nlif5pzE+UC6FQ/29ds=;
	b=xsbH183+fFG4kRoO56Pd44cWk5K2nIrr7pGtOJkH6jajgIaYyfwJ+kkZq+9rsu+9juDl19
	jXMWHrTg2IHCg4Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Waiman Long <longman@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] debugobjects: Don't call fill_pool() in early boot
 hardirq context
Message-ID: <20260605063115.ff4VR-pH@linutronix.de>
References: <20260603195250.362595-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260603195250.362595-1-longman@redhat.com>

On 2026-06-03 15:52:50 [-0400], Waiman Long wrote:
> When booting a debug PREEMPT_RT kernel on an arm64 system with grace
> processor, the following lockdep warning was reported during early boot.
> 
>   ================================
>   WARNING: inconsistent lock state
>   7.1.0-rc4-test+ #1 Not tainted
>   --------------------------------
>   inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>   swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
>   ffff0000803346a0 (&n->list_lock){?.+.}-{3:3}, at: get_from_partial_node+0x74/0xa0
>     :
>   Call trace:
>     :
>    rt_spin_lock+0xa0/0x400
>    get_from_partial_node+0x74/0xa0
>    ___slab_alloc+0x94/0x4f8
>    kmem_cache_alloc_noprof+0x2d4/0x598
>    kmem_alloc_batch+0x54/0x170
>    fill_pool+0x12c/0x438
>    debug_objects_fill_pool+0x58/0x60
>    debug_object_activate+0xfc/0x3d0
>    add_timer_on+0x250/0x3a0
>    add_interrupt_randomness+0x2d4/0x340
>    handle_percpu_devid_irq+0x2e0/0x4e0
>    handle_irq_desc+0xc0/0x120
>    generic_handle_domain_irq+0x20/0x40
>    __gic_handle_irq_from_irqson.isra.0+0x3c4/0x708
>    gic_handle_irq+0x7c/0xe0
>    call_on_irq_stack+0x30/0x48
>    do_interrupt_handler+0x134/0x158
>    el1_interrupt+0x48/0xb0
>     :

I would strip that backtrace since it is obvious from the description
below.

> During early boot, interrupts are getting enabled before the scheduler
> is enabled. In this window (before SYSTEM_SCHEDULING is set) interrupts
> can fire and attempt to fill the pool from within the hardirq. This can
> lead to a deadlock the interrupt occurred while in the memory allocator.
> 
> Add a new can_fill_pool() helper and reorder the exception rule and
> forbid this scenario by excluding allocations from hardirq.
> 
> Fixes: 06e0ae988f6e ("debugobjects: Allow to refill the pool before SYSTEM_SCHEDULING")
> Co-developed-by: Waiman Long <longman@redhat.com>
> Co-developed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
