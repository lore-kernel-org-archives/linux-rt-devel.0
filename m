Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F93A1E8B
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768594194; cv=none; b=kZXGMqN2coVSAhxj54NYxYf6rQNSqkICoKS2OFaJR5h7FdDFn+lQIZbdU1r8BqaQSn+VTFWsrCJyPdB0paHCKOTCthvkf24E0Ig04Bjkrp/N/DQHEGNH5ke13FI2K29/8LO6XHoEFYmwSgkySKVyLqWMt8/jUn5l/S0NYn9NmhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768594194; c=relaxed/simple;
	bh=xhvEhgTxpzw8FKi/2iavt8ArNhknjWDqN9Co8r6sfuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSVdxOuIp1dAwL61Q0bV6hkjbOZGYQLN0JSHPaaB60SjzNvxj8rzomVr/lkZIFnPmZRbg+RKZnpP+RTa1O3j3vbTFyDpzh91qR4JHpasngABTybgM/bXaKqxhIJg+RfOcB19bLN3XfdRSFRozbtvWYt24bWqn68S4IfQbjrUTDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=axjmhudE; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="axjmhudE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cWzXywP779e9MNfrlQWmWyODpNBngl6JXST0EKlobYM=; b=axjmhudEl0bQt4bj5rAVrApBTg
	DI0+lVIl1EAUP2gSmGYDY4Y1MKi+VHPgtJUk9dl+BQ34h6hjNeccuo8QW1h3iDF/3dMJQEMiHWQKX
	Uw8tufpEDzudOBqal/AmKOKA7RPI0/be0E5Zpi/KPrX5HHiee4s0trWKdto/gQTVy361Udc0VdJMP
	6mZcpjic1cG2yrnS7wAkNxdDPIJp6R+R90yj42xA13vLLGayUMZ5vJFLDsM8Idery3GMvpo3JBMgS
	DRrgGVrMOxcV11eDaWaS7dWzI5l0SplKGiHOpya/2rIpuv87grWIgtyU2kdoyKs5njumcYw6DLOHH
	m95WfhrA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57758)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vgq8g-000000002fs-44Dn;
	Fri, 16 Jan 2026 20:09:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vgq8d-000000003t0-3rSt;
	Fri, 16 Jan 2026 20:09:43 +0000
Date: Fri, 16 Jan 2026 20:09:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Yadi.hu" <yadi.hu@windriver.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH v4 1/2] ARM: mm: fault: Enable interrupts before invoking
 __do_user_fault()
Message-ID: <aWqbB68tx8pdkN2q@shell.armlinux.org.uk>
References: <20260116170041.1059997-1-bigeasy@linutronix.de>
 <20260116170041.1059997-2-bigeasy@linutronix.de>
 <aWp2fKGfIQKJ8wze@shell.armlinux.org.uk>
 <20260116181201.v-z31XJY@linutronix.de>
 <aWqZDwxUtaE1yP28@shell.armlinux.org.uk>
 <aWqal9WQkYMkSzJl@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWqal9WQkYMkSzJl@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Jan 16, 2026 at 08:07:52PM +0000, Russell King (Oracle) wrote:
> On Fri, Jan 16, 2026 at 08:01:20PM +0000, Russell King (Oracle) wrote:
> > On Fri, Jan 16, 2026 at 07:12:01PM +0100, Sebastian Andrzej Siewior wrote:
> > > On 2026-01-16 17:33:48 [+0000], Russell King (Oracle) wrote:
> > > > On Fri, Jan 16, 2026 at 06:00:40PM +0100, Sebastian Andrzej Siewior wrote:
> > > > > From: "Yadi.hu" <yadi.hu@windriver.com>
> > > > > 
> > > > > A page fault from userland for a kernel address originates from from
> > > > > do_sect_fault() (!LPAE) or do_page_fault() and ends in __do_user_fault()
> > > > > by sending a signal.
> > > > > 
> > > > > Sending a signal requires to acquire sighand_struct::siglock which is a
> > > > > spinlock_t. On PREEMPT_RT spinlock_t becomes a sleeping spin lock which
> > > > > requires interrupts to be enabled. Since the calling context is user
> > > > > land, interrupts must have been enabled so it is fine to enable them in
> > > > > this case.
> > > > > 
> > > > > Enable interrupts in do_kernel_address_page_fault() unconditional in the
> > > > > user_mode case().
> > > > > Enable interrupts in do_sect_fault() if they were previously enabled.
> > > > 
> > > > Do you need any of this? __do_user_fault() now calls
> > > > local_irq_enable() as almost the first thing it does.
> > > 
> > > Different path(s):
> > > 
> > > LPAE
> > > | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> > > | in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 639, name: arm-segfault
> > > | preempt_count: 0, expected: 0
> > > | RCU nest depth: 0, expected: 0
> > > | CPU: 0 UID: 0 PID: 639 Comm: arm-segfault3 Tainted: G        W           6.19.0-rc5-dirty #7 PREEMPT_RT
> > > | Tainted: [W]=WARN
> > > | Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
> > > | Call trace:
> > > |  unwind_backtrace from show_stack+0x18/0x1c
> > > |  show_stack from dump_stack_lvl+0x34/0x44
> > > |  dump_stack_lvl from __might_resched+0x180/0x1c0
> > > |  __might_resched from rt_spin_lock+0x3c/0x1f0
> > > |  rt_spin_lock from force_sig_info_to_task+0x24/0x184
> > > |  force_sig_info_to_task from force_sig_fault+0x50/0x74
> > > |  force_sig_fault from do_kernel_address_page_fault+0xa8/0xb4
> > > |  do_kernel_address_page_fault from do_DataAbort+0x38/0xac
> > > |  do_DataAbort from __dabt_usr+0x50/0x60
> > > 
> > > !LPAE
> > > | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> > > | in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 622, name: arm-segfault
> > > | preempt_count: 0, expected: 0
> > > | RCU nest depth: 0, expected: 0
> > > | CPU: 0 UID: 0 PID: 622 Comm: arm-segfault Tainted: G        W           6.19.0-rc5-dirty #8 PREEMPT_RT
> > > | Tainted: [W]=WARN
> > > | Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
> > > | Call trace:
> > > |  unwind_backtrace from show_stack+0x18/0x1c
> > > |  show_stack from dump_stack_lvl+0x34/0x44
> > > |  dump_stack_lvl from __might_resched+0x180/0x1c0
> > > |  __might_resched from rt_spin_lock+0x3c/0x1f0
> > > |  rt_spin_lock from force_sig_info_to_task+0x24/0x184
> > > |  force_sig_info_to_task from force_sig_fault+0x50/0x74
> > > |  force_sig_fault from do_sect_fault+0x30/0x80
> > > |  do_sect_fault from do_DataAbort+0x44/0xb8
> > > |  do_DataAbort from __dabt_usr+0x50/0x60
> > 
> > Right, because I haven't pushed all the patches out. What was pushed out
> > was the basic set of fixes during the last merge window:
> > 
> > fd2dee1c6e22 ARM: fix branch predictor hardening (fixes)
> > 7733bc7d299d ARM: fix hash_name() fault
> > 40b466db1dff ARM: allow __do_kernel_fault() to report execution of memory faults
> > dea20281ac88 ARM: group is_permission_fault() with is_translation_fault()
> > edb924a7211c ARM: 9464/1: fix input-only operand modification in load_unaligned_zeropad()
> > 
> > which were sent out on the 8th December, but I still have these:
> > 
> > 1055c9d604f9 ARM: provide individual is_translation_fault() and is_permission_fault()
> > 47ce12a37f82 ARM: move FSR fault status definitions before fsr_fs()
> > eefbf2e97ad5 ARM: use BIT() and GENMASK() for fault status register fields
> > 5f1e55bed37f ARM: move is_permission_fault() and is_translation_fault() to fault.h
> > ad1c1212ae15 ARM: move vmalloc() lazy-page table population
> > 92442d814d99 ARM: ensure interrupts are enabled in __do_user_fault()
> > 
> > and, because they weren't fixes, it would've been inappropriate to
> > post these. However, I was on vacation from the 11th December through
> > to the 2nd January, had the madness of the huge email mountain, and
> > been working on stmmac and internal work issues since, I've not had any
> > time to look at anything else.
> > 
> > However, these changes will negate the need for your patch 1.
> 
> Oh, and, as I've said on netdev recently, I have lots of patches. I
> don't have time to push all patches all the time. Those that I think
> are the highest priority get the attention - so if something goes
> quiet, the patches don't get progressed (because something else has
> taken over.)
> 
> I haven't published these yet to my external git tree because they're
> currently on top of my raw private "development" branch containing...
> 
> $ git lg origin..rmk | wc -l
> 473
> 
> many of those behind those I mentioned above. At some point I need to
> move them to their own separate branch, or to the "misc" branch after
> sending them to the mailing list... but the latter means spending time
> writing a covering message summarising the changes, and the key thing
> is "time".
> 
> I've wasted almost all of today running a bisect for a stmmac issue that
> takes out my _entire_ network at home. It's wasted because what I
> thought was a good commit turns out, on re-testing, to have been bad,
> and right now I have no idea what a good commit is, and whether that
> even exists before the platform support was merged.

Sorry for a third reply... yesterday I started at about 10am, finished
at 2am last night chasing a different stmmac regression.

Yea, if there was more time, then I could push all the patches I have,
but I don't, and the above patches were generated back when we were
discussing the issue last time.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
