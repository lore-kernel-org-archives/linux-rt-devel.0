Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A3E385D89
	for <linux-rt-devel@lists.linux.dev>; Thu, 25 Jun 2026 08:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782377438; cv=none; b=cMDY9SdSZYAoVff53zF8l6KKKrMz3dxWF7fBcybLHCTS60r7yWxnsvumD4cT4swPyIjpnaQW3crPcNrVkxfc4VQGGj/4aCfiatf8I6EMe8llJ0X3pafJOGCzGsGTxxgRj9AaQoCaaKZ/Xx8wy+kWrsBHbByqbiCbDZdvbQ8tnyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782377438; c=relaxed/simple;
	bh=5pZnBViEUMUYkNfwC5kKd1uVotxNzjRvvpEwtmfsAqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKpsc3nKy65kCMpNd//zYuPV7d+W0+hwF6iNDtahZ5YXKkZvWduXH10+AkqEQsQkKoVmKLM631SE2JhPC0OtvXVANQk9hK1t4xVLRffz0c/AKCUv8lCCYgrX/V0Zb+SlV4KnOwx/fbue8Hi/SM8zo74wdykggM2kPn4ja0+R1/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i8WCuLI9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z22sVkAL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i8WCuLI9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z22sVkAL"
Date: Thu, 25 Jun 2026 10:50:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782377435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOZszqMBrYS7JOlBZJmMDKPWZN1V0x6xdDNISbf7dUI=;
	b=i8WCuLI9qFqXegYkEOURO5ezSHMFVd2u4lSi+b8c6fXZ0gU5E4N94KwqAhq2w2i28IiLEt
	cTkP9tj86wKyoOXdw6yUN/ImRtrhDFf8jNcVEF5gIFTtYeWVNF226lSsOKviohiDM/i9mE
	JdcYra9PgOBSodB5PO/lhDIxhJjpQ6odVSUZc7SqZMfemDC+e+0CxbKtwPBtM2vn+3N1gx
	rCzK9VhmUfXjKECBeIMvIeE0ZzBp0KqqElmo/B18E3N1kszzITwbijLltjq+zp79CgFf7J
	jT5nt7ANJr+Egu1bDlwpFDMQ530ktxR+TkhtbGK6piwfov/ZwAOfTr+Q7Updjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782377435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOZszqMBrYS7JOlBZJmMDKPWZN1V0x6xdDNISbf7dUI=;
	b=Z22sVkALQHW/DiCA6kPcmCeR/Z6/CiYSX9STVgbCL1+GdnRphuBRSUKKp5Q3Vv0MHiqaUy
	nwMHDvrVIOXd4RBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Xie Yuanbin <xieyuanbin1@huawei.com>
Cc: linux@armlinux.org.uk, clrkwllms@kernel.org, rostedt@goodmis.org,
	rmk+kernel@armlinux.org.uk, linusw@kernel.org, arnd@arndb.de,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, liaohua4@huawei.com,
	lilinjie8@huawei.com
Subject: Re: [PATCH] ARM: enable interrupts when arm_notify_die() is handling
 user mode errors
Message-ID: <20260625085034.tvyGSmaP@linutronix.de>
References: <20260625073522.182503-1-xieyuanbin1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260625073522.182503-1-xieyuanbin1@huawei.com>

On 2026-06-25 15:35:22 [+0800], Xie Yuanbin wrote:
> For lastest linux-next kernel, with default multi_v7_defconfig, and
> setting CONFIG_PREEMPT_RT=y, CONFIG_DEBUG_ATOMIC_SLEEP=y, and
> CONFIG_PERF_EVENTS=n. When the user program executes bkpt
> instruction, the following WARN will be triggered:
> ```log
> [    3.677825] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [    3.678002] in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 84, name: test
> [    3.678036] preempt_count: 0, expected: 0
> [    3.678078] RCU nest depth: 0, expected: 0
> [    3.678864] CPU: 0 UID: 0 PID: 84 Comm: test Tainted: G        W           7.1.0-next-20260623 #45 PREEMPT_RT
> [    3.679067] Tainted: [W]=WARN
> [    3.679088] Hardware name: Generic DT based system
> [    3.679198] Call trace:
> [    3.679695]  unwind_backtrace from show_stack+0x10/0x14
> [    3.680363]  show_stack from dump_stack_lvl+0x50/0x5c
> [    3.680377]  dump_stack_lvl from __might_resched+0x160/0x174
> [    3.680393]  __might_resched from rt_spin_lock+0x38/0x138
> [    3.680425]  rt_spin_lock from force_sig_info_to_task+0x1c/0x11c
> [    3.680438]  force_sig_info_to_task from force_sig_fault+0x44/0x64
> [    3.680450]  force_sig_fault from do_PrefetchAbort+0x94/0x9c
> [    3.680461]  do_PrefetchAbort from ret_from_exception+0x0/0x20
> [    3.680513] Exception stack(0xf0ab5fb0 to 0xf0ab5ff8)
> [    3.680653] 5fa0:                                     00000000 bed32e94 bed32e9c 00037954
> [    3.680672] 5fc0: 00000002 00000001 bed32e94 0009d590 00000000 bed32e9c 00000002 00000000
> [    3.680682] 5fe0: bed32d48 bed32d38 00037a00 00037958 60000010 ffffffff
> ```

I don't think this required information as it is obvious. At the very
least you could trim it the needed parts if considered needed.

> When PREEMPT_RT is enabled, force_sig_info() requires interrupts to be
> enabled. Enable interrupts when arm_notify_die() is handling user mode
> errors to fix the issue.
> 
> Fixes: c6e61c06d606 ("ARM: 9463/1: Allow to enable RT")
> 
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>

So I did test the 32bit case on arm64 while testing/ backporting the
breakpoint handling there but apparently did not try it on real
arm32.

For "asm("BKPT #0");" the SIGTRAP is not raised instead I get just
| 8<--- cut here ---
| Unhandled prefetch abort: debug event (0x222) at 0x00000000

on the kernel side and a "Bus error" on userland side.

So
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

for this but actual breakpoint handling might be broken or is it just
me? But then your stack trace looks like mine so :/

Sebastian
