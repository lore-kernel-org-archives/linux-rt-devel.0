Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BF82641CA
	for <linux-rt-devel@lists.linux.dev>; Thu, 25 Jun 2026 09:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378376; cv=none; b=tlfvmM/38xf/AHiTQDeGwtTmzsGwP/ci1LBpjsVH1SYD3mW/ARYd9Y8zycBa97E+ucnrsORzYg+wh+8pQNFAp07+OEBKsWz3pcvBwckMwMYBIgDkI2Hkvfit4J3Ywv2pSes6/nApvPj8PZeII6ShVTl77sUNi00tqd8lSqRfZl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378376; c=relaxed/simple;
	bh=RzJmWELCsPq4gL03V6rwjMoMDPK8YLnVKJQNMotLthw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQMlD3rKJRj1eetjUzAfs/E7Gfe679lnLc2Cq+IFX667X/v/gLhQ4QGEeoeMiQ2KgVPRDfa3acyZPJRrTPKG0FVdcciDdIrz0eil0zdDgDdYRvrlRDWbt4jnobw3fKoOTdYrZE6aQkhKs60nTMaVCZvpMvVMPNVnUgExGRgcJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a2wge7aw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a2wge7aw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OO+/HYEHVU7mrQlTQFm+x8smhOEbJOWX2G5Z9vZo/LU=; b=a2wge7awYvSVOrIb6JR/DXjX1Z
	CS8EiK4eIIXAxU5duFXx8VssXWvKe5MwSEEq0syXbEBBuJae68Wn543V9DZzf92TJqJFo8dctJrEW
	UTh4D7UBhAQksKZa1mNk4k+m8NqWwKeepZ0w6ymaUTCcNCp//kFWQ8YMKjS8ci0MwvAq4hJcg7Ytf
	jT+nfizmlrqc1nZE8Q2TU47LZdGnlZs9QBUwBWtcZBay5vJZw/jj4yj5WXE3q2+PPSwKXK3WgSPjN
	omkCfhyAP9bK9YmfuDn/r/PqvQDdVtq4q+B/UjRnIIBYEGwZeDkE7ytUnzy3Nnu8dJ6EZ9zVY7HN/
	1cKJVqEQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55702)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wcg20-000000000gq-1mB7;
	Thu, 25 Jun 2026 10:05:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wcg1w-000000001sO-44Zi;
	Thu, 25 Jun 2026 10:05:52 +0100
Date: Thu, 25 Jun 2026 10:05:52 +0100
From: Russell King <linux@armlinux.org.uk>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Xie Yuanbin <xieyuanbin1@huawei.com>, clrkwllms@kernel.org,
	rostedt@goodmis.org, linusw@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, liaohua4@huawei.com,
	lilinjie8@huawei.com
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling
 user mode errors
Message-ID: <ajzvcCve4LubjH9J@shell.armlinux.org.uk>
References: <20260625073522.182503-1-xieyuanbin1@huawei.com>
 <20260625085034.tvyGSmaP@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625085034.tvyGSmaP@linutronix.de>
Sender: "Russell King,,," <linux@armlinux.org.uk>

On Thu, Jun 25, 2026 at 10:50:34AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-06-25 15:35:22 [+0800], Xie Yuanbin wrote:
> > For lastest linux-next kernel, with default multi_v7_defconfig, and
> > setting CONFIG_PREEMPT_RT=y, CONFIG_DEBUG_ATOMIC_SLEEP=y, and
> > CONFIG_PERF_EVENTS=n. When the user program executes bkpt
> > instruction, the following WARN will be triggered:
> > ```log
> > [    3.677825] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> > [    3.678002] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 84, name: test
> > [    3.678036] preempt_count: 0, expected: 0
> > [    3.678078] RCU nest depth: 0, expected: 0
> > [    3.678864] CPU: 0 UID: 0 PID: 84 Comm: test Tainted: G        W           7.1.0-next-20260623 #45 PREEMPT_RT
> > [    3.679067] Tainted: [W]=WARN
> > [    3.679088] Hardware name: Generic DT based system
> > [    3.679198] Call trace:
> > [    3.679695]  unwind_backtrace from show_stack+0x10/0x14
> > [    3.680363]  show_stack from dump_stack_lvl+0x50/0x5c
> > [    3.680377]  dump_stack_lvl from __might_resched+0x160/0x174
> > [    3.680393]  __might_resched from rt_spin_lock+0x38/0x138
> > [    3.680425]  rt_spin_lock from force_sig_info_to_task+0x1c/0x11c
> > [    3.680438]  force_sig_info_to_task from force_sig_fault+0x44/0x64
> > [    3.680450]  force_sig_fault from do_PrefetchAbort+0x94/0x9c
> > [    3.680461]  do_PrefetchAbort from ret_from_exception+0x0/0x20
> > [    3.680513] Exception stack(0xf0ab5fb0 to 0xf0ab5ff8)
> > [    3.680653] 5fa0:                                     00000000 bed32e94 bed32e9c 00037954
> > [    3.680672] 5fc0: 00000002 00000001 bed32e94 0009d590 00000000 bed32e9c 00000002 00000000
> > [    3.680682] 5fe0: bed32d48 bed32d38 00037a00 00037958 60000010 ffffffff
> > ```
> 
> I don't think this required information as it is obvious. At the very
> least you could trim it the needed parts if considered needed.
> 
> > When PREEMPT_RT is enabled, force_sig_info() requires interrupts to be
> > enabled. Enable interrupts when arm_notify_die() is handling user mode
> > errors to fix the issue.
> > 
> > Fixes: c6e61c06d606 ("ARM: 9463/1: Allow to enable RT")
> > 
> > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Cc: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
> 
> So I did test the 32bit case on arm64 while testing/ backporting the
> breakpoint handling there but apparently did not try it on real
> arm32.
> 
> For "asm("BKPT #0");" the SIGTRAP is not raised instead I get just
> | 8<--- cut here ---
> | Unhandled prefetch abort: debug event (0x222) at 0x00000000
> 
> on the kernel side and a "Bus error" on userland side.
> 
> So
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> for this but actual breakpoint handling might be broken or is it just
> me? But then your stack trace looks like mine so :/

ARM Linux doesn't use BKPT. BKPT was an instruction introduced by Arm
Ltd in ARMv5TE. Prior to this, we use a UDF instruction instead (we
had to pick something!) and gdb and other tools use that as a
breapoint.

Moreover, BKPT isn't guaranteed to trap to the kernel, especially when
there is a hardware debugger connected. In that case, DDI0100E states
that use of BKPT must be according to the instructions provided with
the hardware debugger. This makes BKPT unsuitable for use.

Consequently, ARM Linux has not supported the use of BKPT - no code
was added to support this instruction, hence why the kernel prints an
Alert level message stating that the fault was unhandled.

In addition, when a hardware debugger is not being used, with the
addition of hw_breakpoint.c, what userland sees in response depends on
kernel configuration. If hw_breakpoint.c is not built (when PERF_EVENTS
is disabled), then a SIGBUS signal will be raised. If it is built, and
prior to a recent commit by LinusW, it will raise a SIGTRAP. After
LinusW's commit, it won't raise a signal, but userspace will spin on
the BKPT instruction.

The path we go through in the above case is very much an "oh damn,
we aren't handling this exception, let's try to do something that
might save the day".

Rather than throwing local_irq_enable() in random places, it would
be better to do it earlier, but I would want to review what x86 does
when it gets an exception that the kernel doesn't handle - not sure
when I'll get around to doing that though.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
