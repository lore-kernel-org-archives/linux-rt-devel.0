Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9ED346A05
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 18:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768587125; cv=none; b=Otqe/09PT+qvgHrz2kYwuhHcsnIDsC2JrkIZgpAsZi7pJxQkHNKjLBRf5ZXg5VRVTuep9cE1UXQTBtBatIhs5s+URximZcl76idDXJeXOYJg7UHVZEsic+yFxgqYVke2DhwxayU5Vrdk7qDNz/bQSJs54wvZHiXt+G4a1pZc0yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768587125; c=relaxed/simple;
	bh=i7qG0Jivy20qYGZZn6Q1MtZPx/pPzXTeIFmnYAq3LCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJnVpXR0ztxT4Fl/vJfnhp4y0QKQdOvzIEY36Ojv6BF70XcjXhw5iXRCurBbR3wv+00dexmz2aJobqMxk8cqoqyVc92XEeGM1SBGfDJhrimm2KMCE7iZPIH7fDNlItQUZD59hNV6mzYQFI3TMdyJ2LvNWI94SGrt/DQpp6GVVNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J1hwsbAz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zEvPD4Nf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J1hwsbAz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zEvPD4Nf"
Date: Fri, 16 Jan 2026 19:12:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768587122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44ovzE0jgnGikbgDfiXC8zkvtERzgKGt8g/FgXzZCh0=;
	b=J1hwsbAzRj47aAHpn7CcxGiJHFdJjbGjpfmOkeRFUQ2QcIH20XReb9sYr2ZPQQbkGebfxW
	GLYnEj7jHQPBO8C0D2OqFlfztwJTl9R1ZXIrhedihNQkHhNLQj/bPkLi53boZXbJzAV9yd
	DVZoI4YPyGAV3fwNfTxrdxpH2azIQ3BtHXGrYiGBIiGDXdFpg8e5Axlh2A093sMD71BpEQ
	CqCFpDWR2XXKFCFX+GPo401DyPOcEM+c+O7IXkkLmJlIih8t5OKNVFexWKqOX0gH5zUJDV
	+XvvdsALqj8LFgVKKqA94/13AybsvieX4AjgzCr8ER4yF0hjrwoRK9Hj2qRcrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768587122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=44ovzE0jgnGikbgDfiXC8zkvtERzgKGt8g/FgXzZCh0=;
	b=zEvPD4Nf6oR7B1xtbrUtlnU67rQ+EZnMCcC5XjIBmyyjaI1q2eYEL/zo8pgPHiakOG1b8+
	x0C+F3Zxas35VODQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Yadi.hu" <yadi.hu@windriver.com>, Bryan Brattlof <bb@ti.com>
Subject: Re: [PATCH v4 1/2] ARM: mm: fault: Enable interrupts before invoking
 __do_user_fault()
Message-ID: <20260116181201.v-z31XJY@linutronix.de>
References: <20260116170041.1059997-1-bigeasy@linutronix.de>
 <20260116170041.1059997-2-bigeasy@linutronix.de>
 <aWp2fKGfIQKJ8wze@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aWp2fKGfIQKJ8wze@shell.armlinux.org.uk>

On 2026-01-16 17:33:48 [+0000], Russell King (Oracle) wrote:
> On Fri, Jan 16, 2026 at 06:00:40PM +0100, Sebastian Andrzej Siewior wrote:
> > From: "Yadi.hu" <yadi.hu@windriver.com>
> > 
> > A page fault from userland for a kernel address originates from from
> > do_sect_fault() (!LPAE) or do_page_fault() and ends in __do_user_fault()
> > by sending a signal.
> > 
> > Sending a signal requires to acquire sighand_struct::siglock which is a
> > spinlock_t. On PREEMPT_RT spinlock_t becomes a sleeping spin lock which
> > requires interrupts to be enabled. Since the calling context is user
> > land, interrupts must have been enabled so it is fine to enable them in
> > this case.
> > 
> > Enable interrupts in do_kernel_address_page_fault() unconditional in the
> > user_mode case().
> > Enable interrupts in do_sect_fault() if they were previously enabled.
> 
> Do you need any of this? __do_user_fault() now calls
> local_irq_enable() as almost the first thing it does.

Different path(s):

LPAE
| BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
| in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 639, name: arm-segfault
| preempt_count: 0, expected: 0
| RCU nest depth: 0, expected: 0
| CPU: 0 UID: 0 PID: 639 Comm: arm-segfault3 Tainted: G        W           6.19.0-rc5-dirty #7 PREEMPT_RT
| Tainted: [W]=WARN
| Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
| Call trace:
|  unwind_backtrace from show_stack+0x18/0x1c
|  show_stack from dump_stack_lvl+0x34/0x44
|  dump_stack_lvl from __might_resched+0x180/0x1c0
|  __might_resched from rt_spin_lock+0x3c/0x1f0
|  rt_spin_lock from force_sig_info_to_task+0x24/0x184
|  force_sig_info_to_task from force_sig_fault+0x50/0x74
|  force_sig_fault from do_kernel_address_page_fault+0xa8/0xb4
|  do_kernel_address_page_fault from do_DataAbort+0x38/0xac
|  do_DataAbort from __dabt_usr+0x50/0x60

!LPAE
| BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
| in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 622, name: arm-segfault
| preempt_count: 0, expected: 0
| RCU nest depth: 0, expected: 0
| CPU: 0 UID: 0 PID: 622 Comm: arm-segfault Tainted: G        W           6.19.0-rc5-dirty #8 PREEMPT_RT
| Tainted: [W]=WARN
| Hardware name: QEMU QEMU Virtual Machine, BIOS unknown 02/02/2022
| Call trace:
|  unwind_backtrace from show_stack+0x18/0x1c
|  show_stack from dump_stack_lvl+0x34/0x44
|  dump_stack_lvl from __might_resched+0x180/0x1c0
|  __might_resched from rt_spin_lock+0x3c/0x1f0
|  rt_spin_lock from force_sig_info_to_task+0x24/0x184
|  force_sig_info_to_task from force_sig_fault+0x50/0x74
|  force_sig_fault from do_sect_fault+0x30/0x80
|  do_sect_fault from do_DataAbort+0x44/0xb8
|  do_DataAbort from __dabt_usr+0x50/0x60

Sebastian
