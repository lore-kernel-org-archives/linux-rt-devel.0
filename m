Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D152FE33
	for <linux-rt-devel@lists.linux.dev>; Tue, 13 Oct 2026 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905252; cv=none; b=BlKGmlLwz2pVcotk0lvuWtNckmqzlCrY/nMispejAZZc1AbLYNN9eqJsPlXX9eEoAHJmhLVufJPcxFl1Y49zR+ykxLAXb1UhlN9HCUAuDY/Q/m0Qd24zwG8krOiT+VEWRKJCdq7Nt4m6wHFXOlrOL8bAzFp5nc3uhVOLpXSamvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905252; c=relaxed/simple;
	bh=qbJvRcRE98nv2IVVWpWfShG1OAvGfynIDBrsbHsL430=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqhEwnp1rRgsAaDiPf1RtNsK2//omuV4PIPAsoAM8JQR5CbfayCISBeEoVeD26S+7DMI2EDf7XrSHTl/0tUznkD5Lclu85W+y3XYYawcgksmOzFVlgcYr4Bz4WzweymJI6Tk18yxOly80WMdQB9z0WyJOmGoGazOXLQpOaB9KZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rjP+eEw5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4h5xrAH0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rjP+eEw5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4h5xrAH0"
Date: Tue, 13 Oct 2026 17:27:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791905249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D1pv0RVRHmHu/hDts6dqOaef0+EBxYVfiItqfGjUP/E=;
	b=rjP+eEw5xzMXUoKe72pct8cJYzABjcWR1XOTt+bEW9lwwcDE3YhbOvbknN05DKYuLYOZda
	pN7lpGW2drS7ZX+4iGs2kSj6E514jse+j5JQTSpn44iMHriSS3IeuJ0txKN3VvNd6SveAg
	RkYzbB+BCmy53qij79Jh5f78sHgUpdSiH1pxkTm+D9IIaTVbvMgLFMPT0b0Ag+3Sq4FQfn
	bEvUa+R6GsgMk+yBZhE2pnemngXr7h7mXCLXRXi0VBYwWzRcFcFrKgAYxklP6PZZfb5Y9w
	5GFNVtgO+OKYl3fxqSS6HVYS00+sj9cS5PWLbCgjPFfCXSWOwOMiS+nLukM/TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791905249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D1pv0RVRHmHu/hDts6dqOaef0+EBxYVfiItqfGjUP/E=;
	b=4h5xrAH0/oA1nJYYIDfnssa+lx+mfABWGiGV8n02C3TaipbcVhCbDgYERpHhQ21xxsH2dG
	Iheiof5VleNJEyAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Anup Patel <anup@brainfault.org>, Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jessica Liu <liu.xuemei1@zte.com.cn>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v3] irqchip/riscv-aplic: fix asynchronous probing
Message-ID: <20261013152727.2cUDX3l0@linutronix.de>
References: <20261012-aplic-async-probe-v3-1-5cf52dc28690@mobileye.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261012-aplic-async-probe-v3-1-5cf52dc28690@mobileye.com>

On 2026-10-12 12:12:59 [+0300], Vladimir Kondratiev wrote:
> boolean flag don't protect from race when probing several instances
> asynchronously. On system with multiple APLICs, if probed asynchronously,
> warning triggered as below.

Why is this async? Doesn't __platform_driver_probe() set it to sync?

> [    0.227210] riscv-aplic 67560000.interrupt-controller: 257 interrupts directly connected to 8 CPUs
> [    0.227210] riscv-aplic 674e0000.interrupt-controller: 257 interrupts directly connected to 8 CPUs
> [    0.227224] ------------[ cut here ]------------
> [    0.227227] list_add double add: new=ffffffff8130ced0, prev=ffffffff8130ced0, next=ffffffff81316d40.
> [    0.227302] WARNING: lib/list_debug.c:35 at __list_add_valid_or_report+0xe0/0xe6, CPU#4: kworker/u97:0/211
> [    0.227322] Modules linked in:
> [    0.227333] CPU: 4 UID: 0 PID: 211 Comm: kworker/u97:0 Not tainted 7.3.0-rc6 #1 PREEMPT_RT
> [    0.227341] Hardware name: EyeQ7H evaluation board (DT)
> [    0.227346] Workqueue: async async_run_entry_fn
> [    0.227358] epc : __list_add_valid_or_report+0xe0/0xe6
> [    0.227366]  ra : __list_add_valid_or_report+0xe0/0xe6
> [    0.227375] epc : ffffffff804a08a0 ra : ffffffff804a08a0 sp : ffffffc600823b90
> [    0.227379]  gp : ffffffff81389e70 tp : ffffffd60135ee00 t0 : 0000000000000000
> [    0.227383]  t1 : 3fffffffffffffff t2 : 0000000000000000 s0 : ffffffc600823bb0
> [    0.227387]  s1 : ffffffff8130ced0 a0 : 0000000000000058 a1 : ffffffd9efc9e5c0
> [    0.227391]  a2 : ffffffd9efd5c510 a3 : 0000000000000000 a4 : 0000000000000000
> [    0.227395]  a5 : 0000000000000000 a6 : ffffffd9efc6e5c0 a7 : bfffffffffffe000
> [    0.227399]  s2 : 0000000000000000 s3 : ffffffff8130ce28 s4 : 0000000000000000
> [    0.227402]  s5 : ffffffd6018b65c8 s6 : 0000000000000000 s7 : ffffffd6012fd605
> [    0.227406]  s8 : ffffffd6010c3400 s9 : 0000000000000000 s10: 0000000000000000
> [    0.227409]  s11: 0000000000000000 t3 : 3fffffffffffe000 t4 : 0000000000000020
> [    0.227413]  t5 : 0000000000000000 t6 : ffffffc6008238f8 ssp : 0000000000000000
> [    0.227417] status: 0000000200000120 badaddr: ffffffff804a08a0 cause: 0000000000000003
> [    0.227422] [<ffffffff804a08a0>] __list_add_valid_or_report+0xe0/0xe6
> [    0.227432] [<ffffffff80558226>] register_syscore+0x30/0x60
> [    0.227444] [<ffffffff804ca0fe>] aplic_probe+0xd2/0xfa
> [    0.227453] [<ffffffff80559b2e>] platform_probe+0x3e/0x7a
> [    0.227461] [<ffffffff8055731a>] really_probe+0x88/0x35c
> [    0.227469] [<ffffffff805576ae>] __driver_probe_device+0xc0/0x13a
> [    0.227478] [<ffffffff805577f4>] driver_probe_device+0x38/0xb2
> [    0.227486] [<ffffffff80557ba6>] __driver_attach_async_helper+0x3c/0xc4
> [    0.227493] [<ffffffff80054a0e>] async_run_entry_fn+0x28/0x154
> [    0.227500] [<ffffffff8004482a>] process_one_work+0x14e/0x3d2
> [    0.227509] [<ffffffff800452fe>] worker_thread+0x144/0x286
> [    0.227516] [<ffffffff8004ca3e>] kthread+0xee/0x10e
> [    0.227524] [<ffffffff8001050a>] ret_from_fork_kernel+0x18/0x14e
> [    0.227532] [<ffffffff807bef36>] ret_from_fork_kernel_asm+0x16/0x18
> [    0.227542] ---[ end trace 0000000000000000 ]---
> [    0.228475] pinctrl-single 48508000.pinctrl: 512 pins, size 2048
> [    0.228500] pinctrl-single 53838000.pinctrl: 512 pins, size 2048
> [    0.228723] pinctrl-single 67107000.pinctrl: 512 pins, size 2048
> [    0.227210] riscv-aplic 674e0000.interrupt-controller: 257 interrupts directly connected to 8 CPUs
> [    0.227224] ------------[ cut here ]------------
> [    0.227227] list_add double add: new=ffffffff8130ced0, prev=ffffffff8130ced0, next=ffffffff81316d40.
> [    0.227302] WARNING: lib/list_debug.c:35 at __list_add_valid_or_report+0xe0/0xe6, CPU#4: kworker/u97:0/211
> [    0.227322] Modules linked in:
> [    0.227333] CPU: 4 UID: 0 PID: 211 Comm: kworker/u97:0 Not tainted 7.3.0-rc6 #1 PREEMPT_RT
> [    0.227341] Hardware name: EyeQ7H evaluation board (DT)
> [    0.227346] Workqueue: async async_run_entry_fn
> [    0.227358] epc : __list_add_valid_or_report+0xe0/0xe6
> [    0.227366]  ra : __list_add_valid_or_report+0xe0/0xe6
> [    0.227375] epc : ffffffff804a08a0 ra : ffffffff804a08a0 sp : ffffffc600823b90
> [    0.227379]  gp : ffffffff81389e70 tp : ffffffd60135ee00 t0 : 0000000000000000
> [    0.227383]  t1 : 3fffffffffffffff t2 : 0000000000000000 s0 : ffffffc600823bb0
> [    0.227387]  s1 : ffffffff8130ced0 a0 : 0000000000000058 a1 : ffffffd9efc9e5c0
> [    0.227391]  a2 : ffffffd9efd5c510 a3 : 0000000000000000 a4 : 0000000000000000
> [    0.227395]  a5 : 0000000000000000 a6 : ffffffd9efc6e5c0 a7 : bfffffffffffe000
> [    0.227399]  s2 : 0000000000000000 s3 : ffffffff8130ce28 s4 : 0000000000000000
> [    0.227402]  s5 : ffffffd6018b65c8 s6 : 0000000000000000 s7 : ffffffd6012fd605
> [    0.227406]  s8 : ffffffd6010c3400 s9 : 0000000000000000 s10: 0000000000000000
> [    0.227409]  s11: 0000000000000000 t3 : 3fffffffffffe000 t4 : 0000000000000020
> [    0.227413]  t5 : 0000000000000000 t6 : ffffffc6008238f8 ssp : 0000000000000000
> [    0.227417] status: 0000000200000120 badaddr: ffffffff804a08a0 cause: 0000000000000003
> [    0.227422] [<ffffffff804a08a0>] __list_add_valid_or_report+0xe0/0xe6
> [    0.227432] [<ffffffff80558226>] register_syscore+0x30/0x60
> [    0.227444] [<ffffffff804ca0fe>] aplic_probe+0xd2/0xfa
> [    0.227453] [<ffffffff80559b2e>] platform_probe+0x3e/0x7a
> [    0.227461] [<ffffffff8055731a>] really_probe+0x88/0x35c
> [    0.227469] [<ffffffff805576ae>] __driver_probe_device+0xc0/0x13a
> [    0.227478] [<ffffffff805577f4>] driver_probe_device+0x38/0xb2
> [    0.227486] [<ffffffff80557ba6>] __driver_attach_async_helper+0x3c/0xc4
> [    0.227493] [<ffffffff80054a0e>] async_run_entry_fn+0x28/0x154
> [    0.227500] [<ffffffff8004482a>] process_one_work+0x14e/0x3d2
> [    0.227509] [<ffffffff800452fe>] worker_thread+0x144/0x286
> [    0.227516] [<ffffffff8004ca3e>] kthread+0xee/0x10e
> [    0.227524] [<ffffffff8001050a>] ret_from_fork_kernel+0x18/0x14e
> [    0.227532] [<ffffffff807bef36>] ret_from_fork_kernel_asm+0x16/0x18
> [    0.227542] ---[ end trace 0000000000000000 ]---

Would you mind providing a coherent description of the problem and
implemented solution instead of slapping console output?

> Fixes: b330fbfd34d7 ("irqchip/riscv-aplic: Register syscore operations only once")
> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> ---
> Changes in v3:
> - drop __ro_after_init attribute due to write to read-only page concern

What concern? That __ro_after_init can stay. It is built-in only.

> diff --git a/drivers/irqchip/irq-riscv-aplic-main.c b/drivers/irqchip/irq-riscv-aplic-main.c
> index d9afb6ae98cf56d6fd9f858c31a3d23546c3b450..54e1d5602f15a04127e900c0a4983022d49da553 100644
> --- a/drivers/irqchip/irq-riscv-aplic-main.c
> +++ b/drivers/irqchip/irq-riscv-aplic-main.c
> @@ -116,14 +116,12 @@ static struct syscore aplic_syscore = {
>  	.ops = &aplic_syscore_ops,
>  };
>  
> -static bool aplic_syscore_registered __ro_after_init;
> +static atomic_t aplic_syscore_registered = ATOMIC_INIT(0);
>  
>  static void aplic_syscore_init(void)
>  {
> -	if (!aplic_syscore_registered) {
> +	if (!atomic_cmpxchg(&aplic_syscore_registered, 0, 1))
>  		register_syscore(&aplic_syscore);
> -		aplic_syscore_registered = true;
> -	}
>  }
>  
>  static int aplic_pm_notifier(struct notifier_block *nb, unsigned long action, void *data)
> 

Sebastian
