Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0CB260A28
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Feb 2025 17:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294538; cv=none; b=Yh3uHSywgF6FcfZuv7LMY4jcX6U4gDcX+mZW5pO4wdjRKHl+sqJsIn2OTzKr9SglkxASqaGqY97zfDkWoybr3aHsBoO6Z8vAKpkRrU6fFXKc1heqQPQG5lzswzDw2cM/jg9+Q9GD2bFHg0ZypwIPxnt3fd3XWRFM1w0d2Wvnb88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294538; c=relaxed/simple;
	bh=mvYekEeitqhoOx5GVGOG42niWy2x5e9P7gHLYFOVEF8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRtIi6ASazaWeZ4su5vcXIH4vkXO/E/O2Vys7L1cqaoEbd/bnZkoVbq4EcqlRBuL1EfxmsvuROgeIckMpwecQ2K/V7asZUQBTIho6IhMxj7KUIoF58NWvbHcx3WVazetuIQy1EoOsztW50Qb4Z5vG+JYMv1RdV1ZdGind1puAuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8D2C4CEE5;
	Tue, 11 Feb 2025 17:22:17 +0000 (UTC)
Date: Tue, 11 Feb 2025 12:22:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-rt-devel@lists.linux.dev
Subject: Re: Backtrace seen when enabling PREEMPT_RT
Message-ID: <20250211122222.740824a0@gandalf.local.home>
In-Reply-To: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
References: <760e34f9-6034-40e0-82a5-ee9becd24438@roeck-us.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 08:12:37 -0800
Guenter Roeck <linux@roeck-us.net> wrote:

> Hi,
> 
> When I tried to enable PREEMPT_RT together with various lock debugging
> options, I got the attached backtraces.
> 
> This is with qemu's ne2k_pci Ethernet emulation.
> 
> Question: If I enable PREEMPT_RT tests at kerneltests.org, should I report
> such issues or stop testing affected configurations (I understand that
> ne2k_pci probably isn't used much nowadays).

Yes, I think you should still report this.

> 
> Thanks,
> Guenter
> 
> ---
> Build reference: v6.14-rc2-8-g3309945911b8
> Compiler version: x86_64-linux-gcc (GCC) 13.3.0
> Qemu version: 9.1.2 (v9.1.2-51-g94825e22f3)
> ...
> Starting network: [   13.511263] ip (2707) used greatest stack depth: 11928 bytes left
> [   13.708177] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [   13.708226] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 8, name: kworker/0:0

Interrupts are disabled  while taking a spin_lock() (in RT that's a mutex).

> [   13.708236] preempt_count: 0, expected: 0
> [   13.708242] RCU nest depth: 6, expected: 6
> [   13.708265] 14 locks held by kworker/0:0/8:
> [   13.708280]  #0: ff4dd8b344e6dd38 ((wq_completion)mld){+.+.}-{0:0}, at: process_one_work+0x590/0x6d0
> [   13.708568]  #1: ff5a3c8a40057e48 ((work_completion)(&(&idev->mc_ifc_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1df/0x6d0
> [   13.708582]  #2: ff4dd8b344fbc620 (&idev->mc_lock){+.+.}-{4:4}, at: mld_ifc_work+0x32/0x560
> [   13.708595]  #3: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: mld_sendpack+0x73/0x380
> [   13.708616]  #4: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: ip6_finish_output2+0xe0/0xb80
> [   13.708629]  #5: ff4dd8b3bf61c818 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x94/0x180
> [   13.708653]  #6: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xdf/0x170
> [   13.708669]  #7: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xab/0x180
> [   13.708682]  #8: ffffffff90806ee0 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x71/0x13b0
> [   13.708694]  #9: ff4dd8b34566c398 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{3:3}, at: __dev_queue_xmit+0x1061/0x13b0
> [   13.708705]  #10: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x52/0xc0
> [   13.708717]  #11: ff4dd8b344c66f58 (_xmit_ETHER#2){+...}-{3:3}, at: sch_direct_xmit+0x113/0x2b0
> [   13.708737]  #12: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xdf/0x170
> [   13.708752]  #13: ff4dd8b344c14e40 (&ei_local->page_lock){+.+.}-{3:3}, at: ei_start_xmit+0xb5/0x470
> [   13.708793] irq event stamp: 198329
> [   13.708799] hardirqs last  enabled at (198328): [<ffffffff8fa1fb36>] _raw_spin_unlock_irqrestore+0x46/0x70
> [   13.708808] hardirqs last disabled at (198329): [<ffffffff8f31d897>] ei_start_xmit+0x2a7/0x470

Hmm, where is that ei_start_xmit+0x2a7, This would be good to run
scripts/decode_stacktrace.sh on this.

-- Steve



> [   13.708816] softirqs last  enabled at (198304): [<ffffffff8e49a5ca>] __local_bh_enable_ip+0x11a/0x160
> [   13.708824] softirqs last disabled at (198310): [<ffffffff8f5f1551>] __dev_queue_xmit+0x71/0x13b0
> [   13.709017] CPU: 0 UID: 0 PID: 8 Comm: kworker/0:0 Tainted: G                 N 6.14.0-rc2-00008-g3309945911b8 #1
> [   13.709056] Tainted: [N]=TEST
> [   13.709063] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> [   13.709129] Workqueue: mld mld_ifc_work
> [   13.709214] Call Trace:
> [   13.709249]  <TASK>
> [   13.709292]  dump_stack_lvl+0x78/0xe0
> [   13.709331]  __might_resched+0x152/0x210
> [   13.709353]  rt_spin_lock+0x5b/0x170
> [   13.709363]  ? ei_start_xmit+0xb5/0x470
> [   13.709371]  ? __disable_irq_nosync+0x5b/0x90
> [   13.709386]  ei_start_xmit+0xb5/0x470
> [   13.709390]  ? lock_acquire.part.0+0x9a/0x220
> [   13.709444]  dev_hard_start_xmit+0x47/0x260
> [   13.709475]  sch_direct_xmit+0x91/0x2b0
> [   13.709504]  __dev_queue_xmit+0x10e3/0x13b0
> [   13.709524]  ? lock_acquire.part.0+0x9a/0x220
> [   13.709534]  ? find_held_lock+0x2b/0x80
> [   13.709557]  ? mark_held_locks+0x40/0x70
> [   13.709571]  ? eth_header+0x25/0xb0
> [   13.709608]  ip6_finish_output2+0x246/0xb80
> [   13.709638]  ? ip6_mtu+0x9a/0x190
> [   13.709671]  mld_sendpack+0x1bb/0x380
> [   13.709734]  mld_ifc_work+0x22f/0x560
> [   13.709762]  process_one_work+0x220/0x6d0
> [   13.709812]  worker_thread+0x18c/0x320
> [   13.709829]  ? __pfx_worker_thread+0x10/0x10
> [   13.709836]  kthread+0xfe/0x220
> [   13.709854]  ? __pfx_kthread+0x10/0x10
> [   13.709871]  ret_from_fork+0x2f/0x50
> [   13.709878]  ? __pfx_kthread+0x10/0x10
> [   13.709889]  ret_from_fork_asm+0x1a/0x30
> [   13.709969]  </TASK>
> udhcpc: started, v1.36.1
> udhcpc: broadcasting discover
> udhcpc: broadcasting select for 10.0.2.15, server 10.0.2.2
> udhcpc: lease of 10.0.2.15 obtained from 10.0.2.2, lease time 86400
> deleting routers
> adding dns 10.0.2.3
> OK
> Found console ttyS0
> Linux version 6.14.0-rc2-00008-g3309945911b8 (groeck@server.roeck-us.net) (x86_64-linux-gcc (GCC) 13.3.0, GNU ld (GNU Binutils) 2.42) #1 SMP PREEMPT_RT Tue Feb 11 07:24:33 PST 2025
> Network interface test passed
> TPM selftest failed
> File system test skipped
> Boot successful.
> [   15.502550] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [   15.502593] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 112, name: kworker/u16:4
> [   15.502599] preempt_count: 0, expected: 0
> [   15.502602] RCU nest depth: 6, expected: 6
> [   15.502606] 15 locks held by kworker/u16:4/112:
> [   15.502611]  #0: ff4dd8b344f91138 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x590/0x6d0
> [   15.502660]  #1: ff5a3c8a403efe48 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x1df/0x6d0
> [   15.502676]  #2: ffffffff909b1a98 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x74/0x690
> [   15.502693]  #3: ff4dd8b344fbc620 (&idev->mc_lock){+.+.}-{4:4}, at: ipv6_mc_dad_complete+0x1a/0xe0
> [   15.502709]  #4: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: mld_sendpack+0x73/0x380
> [   15.502724]  #5: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: ip6_finish_output2+0xe0/0xb80
> [   15.502740]  #6: ff4dd8b3bf61c818 ((softirq_ctrl.lock)){+.+.}-{3:3}, at: __local_bh_disable_ip+0x94/0x180
> [   15.502756]  #7: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xdf/0x170
> [   15.502772]  #8: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0xab/0x180
> [   15.502787]  #9: ffffffff90806ee0 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x71/0x13b0
> [   15.502801]  #10: ff4dd8b34566c398 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock){+...}-{3:3}, at: __dev_queue_xmit+0x1061/0x13b0
> [   15.502815]  #11: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x52/0xc0
> [   15.502829]  #12: ff4dd8b344c66f58 (_xmit_ETHER#2){+...}-{3:3}, at: sch_direct_xmit+0x113/0x2b0
> [   15.502847]  #13: ffffffff90806f20 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0xdf/0x170
> [   15.502861]  #14: ff4dd8b344c14e40 (&ei_local->page_lock){+.+.}-{3:3}, at: ei_start_xmit+0xb5/0x470
> [   15.502878] irq event stamp: 7561
> [   15.502881] hardirqs last  enabled at (7560): [<ffffffff8fa1fb36>] _raw_spin_unlock_irqrestore+0x46/0x70
> [   15.502889] hardirqs last disabled at (7561): [<ffffffff8f31d897>] ei_start_xmit+0x2a7/0x470
> [   15.502895] softirqs last  enabled at (7538): [<ffffffff8e49a5ca>] __local_bh_enable_ip+0x11a/0x160
> [   15.502901] softirqs last disabled at (7544): [<ffffffff8f5f1551>] __dev_queue_xmit+0x71/0x13b0
> [   15.502916] CPU: 0 UID: 0 PID: 112 Comm: kworker/u16:4 Tainted: G        W        N 6.14.0-rc2-00008-g3309945911b8 #1
> [   15.502929] Tainted: [W]=WARN, [N]=TEST
> [   15.502931] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
> [   15.502940] Workqueue: ipv6_addrconf addrconf_dad_work
> [   15.502951] Call Trace:
> [   15.502956]  <TASK>
> [   15.502969]  dump_stack_lvl+0x78/0xe0
> [   15.502982]  __might_resched+0x152/0x210
> [   15.503009]  rt_spin_lock+0x5b/0x170
> [   15.503015]  ? ei_start_xmit+0xb5/0x470
> [   15.503024]  ? __disable_irq_nosync+0x5b/0x90
> [   15.503042]  ei_start_xmit+0xb5/0x470
> [   15.503048]  ? lock_acquire.part.0+0x9a/0x220
> [   15.503116]  dev_hard_start_xmit+0x47/0x260
> [   15.503154]  sch_direct_xmit+0x91/0x2b0
> [   15.503191]  __dev_queue_xmit+0x10e3/0x13b0
> [   15.503241]  ? lock_acquire.part.0+0x9a/0x220
> [   15.503254]  ? find_held_lock+0x2b/0x80
> [   15.503282]  ? mark_held_locks+0x40/0x70
> [   15.503322]  ip6_finish_output2+0x38e/0xb80
> [   15.503360]  ? ip6_mtu+0x9a/0x190
> [   15.503400]  mld_sendpack+0x1bb/0x380
> [   15.503479]  ipv6_mc_dad_complete+0xba/0xe0
> [   15.503492]  addrconf_dad_completed+0x388/0x440
> [   15.503498]  ? addrconf_dad_work+0x220/0x690
> [   15.503543]  ? addrconf_dad_work+0x220/0x690
> [   15.503552]  ? addrconf_dad_work+0x328/0x690
> [   15.503562]  addrconf_dad_work+0x328/0x690
> [   15.503587]  ? lock_acquire+0x33/0x80
> [   15.503592]  ? process_one_work+0x1df/0x6d0
> [   15.503628]  process_one_work+0x220/0x6d0
> [   15.503691]  worker_thread+0x18c/0x320
> [   15.503712]  ? __pfx_worker_thread+0x10/0x10
> [   15.503721]  kthread+0xfe/0x220
> [   15.503744]  ? __pfx_kthread+0x10/0x10
> [   15.503765]  ret_from_fork+0x2f/0x50
> [   15.503772]  ? __pfx_kthread+0x10/0x10
> [   15.503786]  ret_from_fork_asm+0x1a/0x30
> [   15.503873]  </TASK>
> Rebooting
> [   30.831707] ACPI: PM: Preparing to enter system sleep state S5
> [   30.836459] reboot: Restarting system
> [   30.836571] reboot: machine restart
> ------------
> Skipping x86_64:q35:Icelake-Server:defconfig:rt:smp8:net=i82557a:mem4G:nvme:fstest=gfs2:btrfs ... 
> Skipping x86_64:q35:Skylake-Client-IBRS:defconfig:rt:smp2:net=i82558b:efi32:mem1G:sdhci-mmc:ext2 ... 
> Skipping x86_64:q35:KnightsMill:defconfig:rt:smp6:net=i82550:mem512:ata:fstest=minix:ext2 ... 
> Skipping x86_64:pc:Opteron_G3:defconfig:nosmp:net=e1000:mem1G:usb:ext2 ... 
> Skipping x86_64:q35:Opteron_G4:defconfig:nosmp:net=ne2k_pci:efi:mem512:ata:fstest=hfs+:ext2 ... 
> Skipping x86_64:q35:Haswell-noTSX-IBRS:defconfig:nosmp:net=pcnet:efi32:mem2G:ata:ext2 ... 

