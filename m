Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E092315ECDF;
	Wed, 20 Nov 2024 07:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088455; cv=none; b=XcEV8CUxlCxC96QpNOJIsR7YlLFThGZHdHIB5cziUwI+omMFuhgsRn/XXtPp7rHsYF4Ga69xcu89hOsgXGvFf/AWeYsaF7KI0edhPzjrZa9aL9Aim4vHpyPPiGvW7JejKQoy+hux+I/9yBLJFQRc9UsiNNZybfmjhy+GA0QFdoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088455; c=relaxed/simple;
	bh=A/JiFBbcc/IV/tvUuUZ/aWjedVNAdpJFupjskMj2vJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2tY9h3Ja0jlDCnKqKjLonw2uN0mGFFb5b155x//401A5CS+m7ndo8ofeRkH4Thcdn/hWk2mSG8mvNLHqKuNUXQt4uxgkX2sxsW1Sy3xDY1v0dse3cMhu5ZCRPh7HAz/V3UvgMrsw+lT4HgUorE/MnLkc9HUqgIZxZQsa/hL4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YrwQHZSv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n+wIOZ0H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YrwQHZSv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n+wIOZ0H"
Date: Wed, 20 Nov 2024 08:40:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732088451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cK03xlN9F8mNRtnFGnNvqthdBMpyVGKGPyINStIebX0=;
	b=YrwQHZSvzsXzCbEJOQkBgMKBE/oAEl8b0hPr4EZIi2wGlSTtsAbeNXBnGbQCiW/+2w+7vP
	lKmziyc3CCmmq+DSbUYq2kGbY6PDvqAExEoOG8pzfzA6NOY1ITAok6MHwZge1MPCYlSO/d
	fnfPDU4/CbooJM1UFtvYdyRaVbFHAc8VC3Oyo1E1HPVIoiXcgmGyYKsl3aH2PHfB1ijc25
	9slD/1bvYvBjdt3w0RKQhm89Lf1T6ilxdS0RmVpU2kkcxkH2/EDCa2hL8Vn72i2DQm6OHW
	K2Yv7avRoBfruhbj/LnlEWTYydtvmc3AR0GIADPWT0M44AJsWjuWovwwMN3q+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732088451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cK03xlN9F8mNRtnFGnNvqthdBMpyVGKGPyINStIebX0=;
	b=n+wIOZ0HrEubHietkjiyxTa05lyQb5TEd6rELRLHtBlBTzoZfnUJTKr1XMMsdoXBGtowCj
	4hn9guR7mGHAdmDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH V2 2/4] LoongArch: Fix sleeping in atomic context for
 PREEMPT_RT
Message-ID: <20241120074049.hw2lHvyM@linutronix.de>
References: <20241117053740.3938646-1-chenhuacai@loongson.cn>
 <20241117054017.3938700-1-chenhuacai@loongson.cn>
 <20241117054017.3938700-2-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241117054017.3938700-2-chenhuacai@loongson.cn>

On 2024-11-17 13:40:15 [+0800], Huacai Chen wrote:
> Commit bab1c299f3945ffe79 ("LoongArch: Fix sleeping in atomic context in
> setup_tlb_handler()") changes the gfp flag from GFP_KERNEL to GFP_ATOMIC
> for alloc_pages_node(). However, for PREEMPT_RT kernels we can still get
> a "sleeping in atomic context" error:
> 
> [    0.372259] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
> [    0.372266] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/1
> [    0.372268] preempt_count: 1, expected: 0
> [    0.372270] RCU nest depth: 1, expected: 1
> [    0.372272] 3 locks held by swapper/1/0:
> [    0.372274]  #0: 900000000c9f5e60 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x524/0x1c60
> [    0.372294]  #1: 90000000087013b8 (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x50/0x140
> [    0.372305]  #2: 900000047fffd388 (&zone->lock){+.+.}-{3:3}, at: __rmqueue_pcplist+0x30c/0xea0
> [    0.372314] irq event stamp: 0
> [    0.372316] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [    0.372322] hardirqs last disabled at (0): [<9000000005947320>] copy_process+0x9c0/0x26e0
> [    0.372329] softirqs last  enabled at (0): [<9000000005947320>] copy_process+0x9c0/0x26e0
> [    0.372335] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [    0.372341] CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.12.0-rc7+ #1891
> [    0.372346] Hardware name: Loongson Loongson-3A5000-7A1000-1w-CRB/Loongson-LS3A5000-7A1000-1w-CRB, BIOS vUDK2018-LoongArch-V2.0.0-prebeta9 10/21/2022
> [    0.372349] Stack : 0000000000000089 9000000005a0db9c 90000000071519c8 9000000100388000
> [    0.372486]         900000010038b890 0000000000000000 900000010038b898 9000000007e53788
> [    0.372492]         900000000815bcc8 900000000815bcc0 900000010038b700 0000000000000001
> [    0.372498]         0000000000000001 4b031894b9d6b725 00000000055ec000 9000000100338fc0
> [    0.372503]         00000000000000c4 0000000000000001 000000000000002d 0000000000000003
> [    0.372509]         0000000000000030 0000000000000003 00000000055ec000 0000000000000003
> [    0.372515]         900000000806d000 9000000007e53788 00000000000000b0 0000000000000004
> [    0.372521]         0000000000000000 0000000000000000 900000000c9f5f10 0000000000000000
> [    0.372526]         90000000076f12d8 9000000007e53788 9000000005924778 0000000000000000
> [    0.372532]         00000000000000b0 0000000000000004 0000000000000000 0000000000070000
> [    0.372537]         ...
> [    0.372540] Call Trace:
> [    0.372542] [<9000000005924778>] show_stack+0x38/0x180
> [    0.372548] [<90000000071519c4>] dump_stack_lvl+0x94/0xe4
> [    0.372555] [<900000000599b880>] __might_resched+0x1a0/0x260
> [    0.372561] [<90000000071675cc>] rt_spin_lock+0x4c/0x140
> [    0.372565] [<9000000005cbb768>] __rmqueue_pcplist+0x308/0xea0
> [    0.372570] [<9000000005cbed84>] get_page_from_freelist+0x564/0x1c60
> [    0.372575] [<9000000005cc0d98>] __alloc_pages_noprof+0x218/0x1820
> [    0.372580] [<900000000593b36c>] tlb_init+0x1ac/0x298
> [    0.372585] [<9000000005924b74>] per_cpu_trap_init+0x114/0x140
> [    0.372589] [<9000000005921964>] cpu_probe+0x4e4/0xa60
> [    0.372592] [<9000000005934874>] start_secondary+0x34/0xc0
> [    0.372599] [<900000000715615c>] smpboot_entry+0x64/0x6c
> 
> This is because in PREEMPT_RT kernels normal spinlocks are replaced by
> rt spinlocks and rt_spin_lock() will cause sleeping. Fix it by disabling
> NUMA optimization completely for PREEMPT_RT kernels.
> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/mm/tlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
> index 5ac9beb5f093..3b427b319db2 100644
> --- a/arch/loongarch/mm/tlb.c
> +++ b/arch/loongarch/mm/tlb.c
> @@ -289,7 +289,7 @@ static void setup_tlb_handler(int cpu)
>  		/* Avoid lockdep warning */
>  		rcutree_report_cpu_starting(cpu);
>  
> -#ifdef CONFIG_NUMA
> +#if defined(CONFIG_NUMA) && !defined(CONFIG_PREEMPT_RT)
>  		vec_sz = sizeof(exception_handlers);

How does this work with NUMA and RT? You don't allocate memory and
everything is fine? Couldn't you pre-allocate the memory on the boot CPU
before kicking the CPU to boot? And then just assign the memory here.

>  		if (pcpu_handlers[cpu])

Sebastian
