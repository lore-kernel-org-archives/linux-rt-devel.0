Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987762063D5
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Feb 2025 16:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378725; cv=none; b=QjCBJRSNcnLvorvto/Bog5aS5DJgJB9FbFREBsYv7E5dTmMHrb5cTIGSRirryoR5fkeA449iOu8nX7xNOG79ttoug/e5oHOMDyfu2JHkos4Kt9dxLnK8b0ndRhBgWka/WMPRq5iVColy8fckQ5H2IBYnYC3SKbrsIsu6QtxP/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378725; c=relaxed/simple;
	bh=+YX9lWNmBiTovtCoAKaB7ciIcgeZhf7f7Bwbc9n6MA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzdXQ+0gDNDbpHU7Rm3WPpePqq1qZquEKR24uEx0+FHiOOIUn8oafPktfTMmqsPrSEhSaLz0kxSbeib3Bpe/i9sTfjnf6d813OUDIqYWjN6QdsaQx7XKjHN5y3BAf3ajqLF8aW68FGMCJ/L+mUnuWX9DbDT7WyvX5j85aYlO0p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582EDC4CEDF;
	Wed, 12 Feb 2025 16:45:24 +0000 (UTC)
Date: Wed, 12 Feb 2025 11:45:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: possible circular locking dependency backtrace seen when
 enabling PREEMPT_RT
Message-ID: <20250212114531.4e95ffe7@gandalf.local.home>
In-Reply-To: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
References: <d9480845-7e81-46a2-8bbd-bd0ebdbc6a5f@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 07:56:44 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi,
> 
> when enabling PREEMPT_RT together with lock debugging, I see the attached
> "possible circular locking dependency" warning when instantiating the pcnet32
> Ethernet adapter with qemu.
> 
> Note: This is with
> 
> lockdep: Remove disable_irq_lockdep().
> lockdep: Don't disable interrupts on RT in disable_irq_nosync_lockdep.*()
> 
> applied on the top of the mainline kernel.

Thanks for the report.

> 
> Thanks,
> Guenter
> 
> ---
> Build reference: v6.14-rc2-3-g59b1a66735ce
> Compiler version: x86_64-linux-gcc (GCC) 13.3.0
> Qemu version: 9.1.2 (v9.1.2-51-g94825e22f3)
> ...
> Starting network: [   26.638045] pcnet32 0000:00:02.0 eth0: link up
> [   26.639386] 
> [   26.639429] ======================================================
> [   26.639435] WARNING: possible circular locking dependency detected
> [   26.639595] 6.14.0-rc2-00003-g59b1a66735ce #1 Tainted: G                 N
> [   26.639609] ------------------------------------------------------
> [   26.639616] irq/22-eth0/2680 is trying to acquire lock:
> [   26.639648] ffff9cb0438dae30 (&lp->lock){+.+.}-{3:3}, at: pcnet32_interrupt+0x2e/0x1e0

So the spin_lock(lp->lock) is being taken from the interrupt handler (now a
thread), while it already holds the softirq_ctrl.lock from the
local_bh_disable() in the irq_thread_fn().

> [   26.639853] 
> [   26.639853] but task is already holding lock:
> [   26.639858] ffff9cb0bdc1c818 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x94/0x180
> [   26.639877] 
> [   26.639877] which lock already depends on the new lock.
> [   26.639877] 
> [   26.639882] 
> [   26.639882] the existing dependency chain (in reverse order) is:
> [   26.639898] 
> [   26.639898] -> #1 ((softirq_ctrl.lock)){+.+.}-{3:3}:
> [   26.639950]        rt_spin_lock+0x39/0x170
> [   26.639985]        __local_bh_disable_ip+0x94/0x180
> [   26.639991]        __netdev_alloc_skb+0x139/0x1c0

The __netdev_alloc_skb() calls local_bh_disable() (which takes the
softirq_ctrl.lock in PREEMPT_RT).

> [   26.639998]        pcnet32_init_ring+0x18b/0x310
> [   26.640003]        pcnet32_open+0x477/0x820

But here it already acquired the lp->lock via a spin_lock_irqsave().

Now, local_bh_disable() in non PREEMPT_RT disables preemption as well as
softirqs. But in PREEMPT_RT it does not disable preemption and has the
following code from __local_bh_disable_ip() in softirq.c:

	/* First entry of a task into a BH disabled section? */
	if (!current->softirq_disable_cnt) {
		if (preemptible()) {
			local_lock(&softirq_ctrl.lock);
			/* Required to meet the RCU bottomhalf requirements. */
			rcu_read_lock();
		} else {
			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
		}
	}

Where that local_lock() disables preemption and prevents softirqs from
executing on this CPU.

But in non PREEMPT_RT, spin_lock_irqsave() (as well as spin_lock_irq())
disables preemption and because it also disables interrupts will disable
softirqs too.

Shouldn't the spin_lock_irq*() variants for PREEMPT_RT also disable local_bh?

Like this patch (untested):

diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index f6499c37157d..50ad0fab66b6 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -90,6 +90,7 @@ static __always_inline void spin_lock_bh(spinlock_t *lock)
 
 static __always_inline void spin_lock_irq(spinlock_t *lock)
 {
+	local_bh_disable();
 	rt_spin_lock(lock);
 }
 
@@ -97,12 +98,14 @@ static __always_inline void spin_lock_irq(spinlock_t *lock)
 	do {						 \
 		typecheck(unsigned long, flags);	 \
 		flags = 0;				 \
+		local_bh_disable();			 \
 		spin_lock(lock);			 \
 	} while (0)
 
 static __always_inline void spin_unlock(spinlock_t *lock)
 {
 	rt_spin_unlock(lock);
+	local_bh_enable();
 }
 
 static __always_inline void spin_unlock_bh(spinlock_t *lock)
@@ -114,6 +117,7 @@ static __always_inline void spin_unlock_bh(spinlock_t *lock)
 static __always_inline void spin_unlock_irq(spinlock_t *lock)
 {
 	rt_spin_unlock(lock);
+	local_bh_enable();
 }
 
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,


We could probably consolidate the spin_lock_bh() with spin_lock_irq()
variants.

Guenter,

Can you test that patch to see if it stops this lockdep splat?

Thanks,

-- Steve


> [   26.640008]        __dev_open+0x100/0x200
> [   26.640014]        __dev_change_flags+0x217/0x2b0
> [   26.640018]        dev_change_flags+0x21/0x60
> [   26.640022]        do_setlink.isra.0+0x31b/0x1250
> [   26.640027]        rtnl_newlink+0x7eb/0xb10
> [   26.640031]        rtnetlink_rcv_msg+0x414/0x670
> [   26.640036]        netlink_rcv_skb+0x56/0x100
> [   26.640041]        netlink_unicast+0x1a3/0x290
> [   26.640046]        netlink_sendmsg+0x203/0x450
> [   26.640050]        ____sys_sendmsg+0x301/0x330
> [   26.640060]        ___sys_sendmsg+0x95/0xe0
> [   26.640066]        __sys_sendmsg+0x88/0xe0
> [   26.640070]        do_syscall_64+0xbb/0x1d0
> [   26.640076]        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [   26.640094] 
> [   26.640094] -> #0 (&lp->lock){+.+.}-{3:3}:
> [   26.640102]        __lock_acquire+0x11ef/0x1940
> [   26.640109]        lock_acquire.part.0+0x9a/0x220
> [   26.640114]        rt_spin_lock+0x39/0x170
> [   26.640118]        pcnet32_interrupt+0x2e/0x1e0
> [   26.640123]        irq_thread_fn+0x1e/0x60
> [   26.640129]        irq_forced_thread_fn+0x2d/0x50
> [   26.640134]        irq_thread+0x15d/0x220
> [   26.640138]        kthread+0xfe/0x220
> [   26.640144]        ret_from_fork+0x2f/0x50
> [   26.640151]        ret_from_fork_asm+0x1a/0x30
> [   26.640162] 
> [   26.640162] other info that might help us debug this:
> [   26.640162] 
> [   26.640188]  Possible unsafe locking scenario:
> [   26.640188] 
> [   26.640192]        CPU0                    CPU1
> [   26.640196]        ----                    ----
> [   26.640203]   lock((softirq_ctrl.lock));
> [   26.640217]                                lock(&lp->lock);
> [   26.640232]                                lock((softirq_ctrl.lock));
> [   26.640251]   lock(&lp->lock);
> [   26.640264] 
> [   26.640264]  *** DEADLOCK ***
> [   26.640264] 
> [   26.640285] 3 locks held by irq/22-eth0/2680:
> [   26.640302]  #0: ffff9cb0bdc1c818 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x94/0x180
> [   26.640327]  #1: ffffffff97406f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xdf/0x170
> [   26.640351]  #2: ffffffff97406f20 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xab/0x180
> [   26.640370] 
> [   26.640370] stack backtrace:
> [   26.640464] CPU: 0 UID: 0 PID: 2680 Comm: irq/22-eth0 Tainted: G                 N 6.14.0-rc2-00003-g59b1a66735ce #1
> [   26.640507] Tainted: [N]=TEST
> [   26.640516] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   26.640599] Call Trace:
> [   26.640640]  <TASK>
> [   26.640691]  dump_stack_lvl+0x78/0xe0
> [   26.640743]  print_circular_bug+0x26e/0x350
> [   26.640752]  check_noncircular+0x169/0x180
> [   26.640764]  __lock_acquire+0x11ef/0x1940
> [   26.640776]  lock_acquire.part.0+0x9a/0x220
> [   26.640787]  ? pcnet32_interrupt+0x2e/0x1e0
> [   26.640795]  ? trace_lock_acquire+0x83/0xb0
> [   26.640800]  ? lock_acquire+0x33/0x80
> [   26.640805]  ? pcnet32_interrupt+0x2e/0x1e0
> [   26.640813]  rt_spin_lock+0x39/0x170
> [   26.640818]  ? pcnet32_interrupt+0x2e/0x1e0
> [   26.640823]  ? trace_lock_acquire+0x83/0xb0
> [   26.640829]  pcnet32_interrupt+0x2e/0x1e0
> [   26.640835]  ? irq_forced_thread_fn+0x1a/0x50
> [   26.640841]  irq_thread_fn+0x1e/0x60
> [   26.640846]  ? irq_forced_thread_fn+0x1a/0x50
> [   26.640850]  irq_forced_thread_fn+0x2d/0x50
> [   26.640855]  ? irq_thread+0xad/0x220
> [   26.640859]  irq_thread+0x15d/0x220
> [   26.640864]  ? __pfx_irq_forced_thread_fn+0x10/0x10
> [   26.640869]  ? __pfx_irq_thread_dtor+0x10/0x10
> [   26.640876]  ? __pfx_irq_thread+0x10/0x10
> [   26.640881]  kthread+0xfe/0x220
> [   26.640889]  ? __pfx_kthread+0x10/0x10
> [   26.640896]  ret_from_fork+0x2f/0x50
> [   26.640902]  ? __pfx_kthread+0x10/0x10
> [   26.640908]  ret_from_fork_asm+0x1a/0x30
> [   26.640935]  </TASK>
> 
> Stack decode:
> 
> [   26.639435] WARNING: possible circular locking dependency detected
> [   26.639595] 6.14.0-rc2-00003-g59b1a66735ce #1 Tainted: G                 N
> [   26.639609] ------------------------------------------------------
> [   26.639616] irq/22-eth0/2680 is trying to acquire lock:
> [   26.639648] ffff9cb0438dae30 (&lp->lock){+.+.}-{3:3}, at: pcnet32_interrupt (drivers/net/ethernet/amd/pcnet32.c:2572) 
> [   26.639853]
> [   26.639853] but task is already holding lock:
> [   26.639858] ffff9cb0bdc1c818 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip (include/linux/rcupdate.h:847 kernel/softirq.c:156) 
> [   26.639877]
> [   26.639877] which lock already depends on the new lock.
> [   26.639877]
> [   26.639882]
> [   26.639882] the existing dependency chain (in reverse order) is:
> [   26.639898]
> [   26.639898] -> #1 ((softirq_ctrl.lock)){+.+.}-{3:3}:
> [   26.639950] rt_spin_lock (arch/x86/include/asm/current.h:47 kernel/locking/spinlock_rt.c:48 kernel/locking/spinlock_rt.c:57) 
> [   26.639985] __local_bh_disable_ip (include/linux/rcupdate.h:847 kernel/softirq.c:156) 
> [   26.639991] __netdev_alloc_skb (net/core/skbuff.c:759) 
> [   26.639998] pcnet32_init_ring (drivers/net/ethernet/amd/pcnet32.c:2376 (discriminator 1)) 
> [   26.640003] pcnet32_open (drivers/net/ethernet/amd/pcnet32.c:2269) 
> [   26.640008] __dev_open (net/core/dev.c:1606) 
> [   26.640014] __dev_change_flags (net/core/dev.c:9172) 
> [   26.640018] dev_change_flags (net/core/dev.c:9244) 
> [   26.640022] do_setlink.isra.0 (net/core/rtnetlink.c:3118 (discriminator 1)) 
> [   26.640027] rtnl_newlink (net/core/rtnetlink.c:3732 net/core/rtnetlink.c:3884 net/core/rtnetlink.c:4021) 
> [   26.640031] rtnetlink_rcv_msg (net/core/rtnetlink.c:6911) 
> [   26.640036] netlink_rcv_skb (net/netlink/af_netlink.c:2543) 
> [   26.640041] netlink_unicast (net/netlink/af_netlink.c:1323 net/netlink/af_netlink.c:1348) 
> [   26.640046] netlink_sendmsg (net/netlink/af_netlink.c:1892) 
> [   26.640050] ____sys_sendmsg (net/socket.c:718 (discriminator 1) net/socket.c:733 (discriminator 1) net/socket.c:2573 (discriminator 1)) 
> [   26.640060] ___sys_sendmsg (net/socket.c:2629) 
> [   26.640066] __sys_sendmsg (net/socket.c:2659 (discriminator 1)) 
> [   26.640070] do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
> [   26.640076] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
> [   26.640094]
> [   26.640094] -> #0 (&lp->lock){+.+.}-{3:3}:
> [   26.640102] __lock_acquire (kernel/locking/lockdep.c:3164 (discriminator 1) kernel/locking/lockdep.c:3282 (discriminator 1) kernel/locking/lockdep.c:3906 (discriminator 1) kernel/locking/lockdep.c:5228 (discriminator 1)) 
> [   26.640109] lock_acquire.part.0 (kernel/locking/lockdep.c:469 (discriminator 4) kernel/locking/lockdep.c:5853 (discriminator 4)) 
> [   26.640114] rt_spin_lock (arch/x86/include/asm/current.h:47 kernel/locking/spinlock_rt.c:48 kernel/locking/spinlock_rt.c:57) 
> [   26.640118] pcnet32_interrupt (drivers/net/ethernet/amd/pcnet32.c:2572) 
> [   26.640123] irq_thread_fn (kernel/irq/manage.c:1191) 
> [   26.640129] irq_forced_thread_fn (include/linux/bottom_half.h:33 (discriminator 1) kernel/irq/manage.c:1216 (discriminator 1)) 
> [   26.640134] irq_thread (kernel/irq/manage.c:1318) 
> [   26.640138] kthread (kernel/kthread.c:464) 
> [   26.640144] ret_from_fork (arch/x86/kernel/process.c:154) 
> [   26.640151] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [   26.640162]
> [   26.640162] other info that might help us debug this:
> [   26.640162]
> [   26.640188]  Possible unsafe locking scenario:
> [   26.640188]
> [   26.640192]        CPU0                    CPU1
> [   26.640196]        ----                    ----
> [   26.640203]   lock((softirq_ctrl.lock));
> [   26.640217]                                lock(&lp->lock);
> [   26.640232]                                lock((softirq_ctrl.lock));
> [   26.640251]   lock(&lp->lock);
> [   26.640264]
> [   26.640264]  *** DEADLOCK ***
> [   26.640264]
> [   26.640285] 3 locks held by irq/22-eth0/2680:
> [   26.640302] #0: ffff9cb0bdc1c818 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip (include/linux/rcupdate.h:847 kernel/softirq.c:156) 
> [   26.640327] #1: ffffffff97406f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock (include/linux/rcupdate.h:337 (discriminator 1) include/linux/rcupdate.h:849 (discriminator 1) kernel/locking/spinlock_rt.c:50 (discriminator 1) kernel/locking/spinlock_rt.c:57 (discriminator 1)) 
> [   26.640351] #2: ffffffff97406f20 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip (include/linux/rcupdate.h:337 (discriminator 1) include/linux/rcupdate.h:849 (discriminator 1) kernel/softirq.c:156 (discriminator 1)) 
> [   26.640370]
> [   26.640370] stack backtrace:
> [   26.640464] CPU: 0 UID: 0 PID: 2680 Comm: irq/22-eth0 Tainted: G                 N 6.14.0-rc2-00003-g59b1a66735ce #1
> [   26.640507] Tainted: [N]=TEST
> [   26.640516] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> [   26.640599] Call Trace:
> [   26.640640]  <TASK>
> [   26.640691] dump_stack_lvl (lib/dump_stack.c:123) 
> [   26.640743] print_circular_bug (kernel/locking/lockdep.c:2079) 
> [   26.640752] check_noncircular (kernel/locking/lockdep.c:2211) 
> [   26.640764] __lock_acquire (kernel/locking/lockdep.c:3164 (discriminator 1) kernel/locking/lockdep.c:3282 (discriminator 1) kernel/locking/lockdep.c:3906 (discriminator 1) kernel/locking/lockdep.c:5228 (discriminator 1)) 
> [   26.640776] lock_acquire.part.0 (kernel/locking/lockdep.c:469 (discriminator 4) kernel/locking/lockdep.c:5853 (discriminator 4)) 
> [   26.640787] ? pcnet32_interrupt (drivers/net/ethernet/amd/pcnet32.c:2572) 
> [   26.640795] ? trace_lock_acquire (include/trace/events/lock.h:24 (discriminator 2)) 
> [   26.640800] ? lock_acquire (kernel/locking/lockdep.c:5824) 
> [   26.640805] ? pcnet32_interrupt (drivers/net/ethernet/amd/pcnet32.c:2572) 
> [   26.640813] rt_spin_lock (arch/x86/include/asm/current.h:47 kernel/locking/spinlock_rt.c:48 kernel/locking/spinlock_rt.c:57) 
> [   26.640818] ? pcnet32_interrupt (drivers/net/ethernet/amd/pcnet32.c:2572) 
> [   26.640823] ? trace_lock_acquire (include/trace/events/lock.h:24 (discriminator 2)) 
> [   26.640829] pcnet32_interrupt (drivers/net/ethernet/amd/pcnet32.c:2572) 
> [   26.640835] ? irq_forced_thread_fn (include/linux/bottom_half.h:20 (discriminator 1) kernel/irq/manage.c:1210 (discriminator 1)) 
> [   26.640841] irq_thread_fn (kernel/irq/manage.c:1191) 
> [   26.640846] ? irq_forced_thread_fn (include/linux/bottom_half.h:20 (discriminator 1) kernel/irq/manage.c:1210 (discriminator 1)) 
> [   26.640850] irq_forced_thread_fn (include/linux/bottom_half.h:33 (discriminator 1) kernel/irq/manage.c:1216 (discriminator 1)) 
> [   26.640855] ? irq_thread (kernel/irq/manage.c:1307) 
> [   26.640859] irq_thread (kernel/irq/manage.c:1318) 
> [   26.640864] ? __pfx_irq_forced_thread_fn (kernel/irq/manage.c:1207) 
> [   26.640869] ? __pfx_irq_thread_dtor (kernel/irq/manage.c:1227) 
> [   26.640876] ? __pfx_irq_thread (kernel/irq/manage.c:1294) 
> [   26.640881] kthread (kernel/kthread.c:464) 
> [   26.640889] ? __pfx_kthread (kernel/kthread.c:413) 
> [   26.640896] ret_from_fork (arch/x86/kernel/process.c:154) 
> [   26.640902] ? __pfx_kthread (kernel/kthread.c:413) 
> [   26.640908] ret_from_fork_asm (arch/x86/entry/entry_64.S:257) 
> [   26.640935]  </TASK>

