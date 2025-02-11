Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E38272910
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 23:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316070; cv=none; b=Ki8FjFdGW1NJaer/RIVFcgAMl7AG9zzAzZm1kcIu1uEQeMU26pS066I3hRWX60qYpDX3WmCGl9rjElNLProBQFQlJVn2WShHV3InqbQDowkDWcXyRNAaPPyMbE7fS2Zm5vyCg0yGowQKKL9kOxCUsA834Sfr2xpYJE0SdRGGW3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316070; c=relaxed/simple;
	bh=41Uc1aIolL8rrqL4cRqQgTMANb1fK8jMo8W2VVtVb0I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7GH236Cjv/Rj9ANWojug3RlzwAx/D7rtoN4CO5wSkNt2gIE9LIVQqARSgoovNIW+KBFMH1RYG3xhFEkh3UaXgltVsmlTgdzI7oo+NWGLtV6LkmFJvB/10fD6s1s1zGoQC5OUHYv++nO1ALG26uRhcSmnObkVv4RYR1QFJY/gc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996D6C4CEDD;
	Tue, 11 Feb 2025 23:21:08 +0000 (UTC)
Date: Tue, 11 Feb 2025 18:21:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Backtrace seen when enabling PREEMPT_RT
Message-ID: <20250211182113.4875751a@gandalf.local.home>
In-Reply-To: <bfecd294-d68d-4e71-af43-b19c59012c98@roeck-us.net>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
	<20250211122222.740824a0@gandalf.local.home>
	<bfecd294-d68d-4e71-af43-b19c59012c98@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 14:54:47 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> Does this help ?

Yes.

> 
> [   13.163019] hardirqs last enabled at (52626): _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:87 arch/x86/include/asm/irqflags.h:147 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
> [   13.163030] hardirqs last disabled at (52627): ei_start_xmit (include/linux/interrupt.h:460 (discriminator 1) drivers/net/ethernet/8390/lib8390.c:333 (discriminator 1) drivers/net/ethernet/8390/8390.c:23 (discriminator 1))

Ug, we have in __ei_start_xmit():

        /*
         *      Slow phase with lock held.
         */

        disable_irq_nosync_lockdep_irqsave(dev->irq, &flags);

        spin_lock(&ei_local->page_lock);


Where we have:

static inline void disable_irq_nosync_lockdep(unsigned int irq)
{
        disable_irq_nosync(irq); 
#ifdef CONFIG_LOCKDEP
        local_irq_disable();
#endif 
}

Where when we have LOCKDEP enabled, it disables interrupts. But as you can
see, that's going to trigger the warning:

  BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48

Because the spin_lock() is a mutex when PREEMPT_RT is enabled, but now we
have interrupts disabled when LOCKDEP in enabled.

Peter, should that be:

static inline void disable_irq_nosync_lockdep(unsigned int irq)
{
        disable_irq_nosync(irq); 
#if defined(CONFIG_LOCKDEP) && !defined(CONFIG_PREEMPT_RT)
        local_irq_disable();
#endif 
}

Or is that just wishful thinking that this would be solved by such a simple
solution (of course the enable_irq() version also needs to be updated).

-- Steve



> [   13.163038] softirqs last enabled at (52602): __local_bh_enable_ip (kernel/softirq.c:247)
> [   13.163046] softirqs last disabled at (52608): __dev_queue_xmit (include/linux/bottom_half.h:20 (discriminator 1) include/linux/rcupdate.h:901 (discriminator 1) net/core/dev.c:4509 (discriminator 1))
> [   13.163257] CPU: 2 UID: 0 PID: 59 Comm: kworker/2:1 Tainted: G                 N 6.14.0-rc2-00008-g3309945911b8 #1
> [   13.163300] Tainted: [N]=TEST
> [   13.163307] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> [   13.163376] Workqueue: mld mld_ifc_work
> [   13.163466] Call Trace:
> [   13.163501]  <TASK>
> [   13.163544] dump_stack_lvl (lib/dump_stack.c:123)
> [   13.163584] __might_resched (kernel/sched/core.c:8767)
> [   13.163607] rt_spin_lock (kernel/locking/spinlock_rt.c:40 kernel/locking/spinlock_rt.c:49 kernel/locking/spinlock_rt.c:57)
> [   13.163618] ? ei_start_xmit (drivers/net/ethernet/8390/lib8390.c:337 drivers/net/ethernet/8390/8390.c:23)
> [   13.163625] ? __disable_irq_nosync (kernel/irq/manage.c:702)
> [   13.163638] ei_start_xmit (drivers/net/ethernet/8390/lib8390.c:337 drivers/net/ethernet/8390/8390.c:23)
> [   13.163642] ? lock_acquire.part.0 (kernel/locking/lockdep.c:469 (discriminator 4) kernel/locking/lockdep.c:5853 (discriminator 4))
> [   13.163685] dev_hard_start_xmit (include/linux/netdevice.h:5144 include/linux/netdevice.h:5153 net/core/dev.c:3735 net/core/dev.c:3751)
> [   13.163709] sch_direct_xmit (net/sched/sch_generic.c:343)
> [   13.163735] __dev_queue_xmit (net/core/dev.c:3974 (discriminator 1) net/core/dev.c:4550 (discriminator 1))
> [   13.163751] ? lock_acquire.part.0 (kernel/locking/lockdep.c:469 (discriminator 4) kernel/locking/lockdep.c:5853 (discriminator 4))
> [   13.163760] ? find_held_lock (kernel/locking/lockdep.c:5341 (discriminator 1))
> [   13.163778] ? mark_held_locks (kernel/locking/lockdep.c:4323 (discriminator 1))
> [   13.163790] ? eth_header (net/ethernet/eth.c:85)
> [   13.163819] ip6_finish_output2 (include/net/neighbour.h:539 (discriminator 2) net/ipv6/ip6_output.c:141 (discriminator 2))
> [   13.163843] ? ip6_mtu (net/ipv6/route.c:3220)
> [   13.163869] mld_sendpack (net/ipv6/mcast.c:1866)
> [   13.163918] mld_ifc_work (net/ipv6/mcast.c:2699)
> [   13.163940] process_one_work (kernel/workqueue.c:3241)
> [   13.163979] worker_thread (kernel/workqueue.c:3311 (discriminator 2) kernel/workqueue.c:3398 (discriminator 2))
> [   13.163993] ? __pfx_worker_thread (kernel/workqueue.c:3344)
> [   13.164000] kthread (kernel/kthread.c:464)
> [   13.164015] ? __pfx_kthread (kernel/kthread.c:413)
> [   13.164030] ret_from_fork (arch/x86/kernel/process.c:154)
> [   13.164036] ? __pfx_kthread (kernel/kthread.c:413)
> [   13.164046] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)

