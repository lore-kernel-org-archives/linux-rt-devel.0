Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9C530B51E;
	Tue,  4 Aug 2026 03:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812648; cv=none; b=YWsMuX+pLJ1L0tq5cpH1Q6tPpUdE+D+cB5RzUB8vj2GXBbIndgh4antk+YjfYAG6wXTQ1Sv/jgKDnScNiL1xveNiayQ38k5h9eZ929EfChh3+1I7S33jjm75p/3GYrrDagOX61oqhSrldtufLn6nLWVigiQLqkzZPobAgKM6P2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812648; c=relaxed/simple;
	bh=5F4jpsYYa71VFyNPIUSPDjrll1rr2OurnGlvjFq2/6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSkiWqR1AEwbwGvfZ8/DsTTd4dJcN2rUnDss6L1mLLRBP5yC5cbdZ9RdfiovF1tNKcdAPEBMrRKH53vDQWjxXX/tWWxDjY5Uqf3YSulTqCE9QI4AUjltfCPUxmD1ZKlZ/9ZE3xPLNnmE9cAZBe68a/3fmpqRAfT4g3PjWq+8FM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ehs8/bkh; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ehs8/bkh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=YKiBIk4wRt6v6NI7XRMCDBJJZejw6wWJNbI2X0Vwybs=;
	b=ehs8/bkhda2AjPr2bTWWWe8pn/oOuR3Godyaf8dliue5vCE+Hvh81ZacwZukAh
	B5wggLy2qPyVWcglluPf009vVnI6CXyO8Z5GLeiM0AyCOzOLN/8w/ztI5t7HyO+o
	+uwxzFvtRA0R7agxFV6mG9q5srWyl4j66mNRZDUuB+gD4=
Received: from [IPV6:2409:8a62:3e6:1400:e93f:3d77:3322:beb7] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3P1uTVnFqxrfcNg--.17519S2;
	Tue, 04 Aug 2026 11:03:48 +0800 (CST)
Message-ID: <c5f7df74-5a45-4bd6-b167-b4f970613d9a@163.com>
Date: Tue, 4 Aug 2026 11:03:47 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: stm32: use a raw spinlock regmap to program the
 EXTI mux
To: sashiko-reviews@lists.linux.dev
Cc: mfd@lists.linux.dev, linux-rt-devel@lists.linux.dev, lee@kernel.org,
 linux-kernel@vger.kernel.org
References: <20260803061718.43210-1-junan76@163.com>
 <20260803063431.205EC1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Ju Nan <junan76@163.com>
In-Reply-To: <20260803063431.205EC1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3P1uTVnFqxrfcNg--.17519S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW8Cry3XFWkGry8WrWruFg_yoW8KryDpF
	WaqayayrsrGrWIvryqvw48J3W09a1IyF43A3Z8WrWIv3s0ga4fGr15KF45AFWDGF4kC3Z0
	y3WjqryDu3WDZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U24iUUUUUU=
X-CM-SenderInfo: pmxqt0ixw6il2tof0z/xtbC9RSxY2pxVpQtIQAA3m



On 8/3/26 2:34 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Bypassing standard syscon regmap initialization leaves the syscfg clock disabled, leading to hardware bus faults on platforms where the syscfg node requires a clock.
> - [High] If another driver sharing the syscon node probes before pinctrl, the generic syscon layer will create a default regmap without `use_raw_spinlock`, causing the PREEMPT_RT sleeping-in-atomic bug to persist.

> [Severity: High]
> Does bypassing the standard syscon regmap initialization leave the syscfg
> clock disabled?
> 
> The generic syscon handling normally calls of_clk_get() and 
> regmap_mmio_attach_clk(). Since this manual initialization skips that, the
> clock is never attached to the regmap.
> 
> On platforms like STM32F4/F7/H7 where the syscfg node explicitly requires a 
> clock, could writing to the EXTI mux registers in stm32_gpio_domain_activate()
> with the clock disabled trigger an imprecise external abort (bus fault)?

That's right for STM32F4/F7, I have checked related dts files and the syscfg
node does require a clock.

>> +
>> +	/*
>> +	 * A regmap is already registered for that node, most likely by the
>> +	 * other pinctrl instance sharing it. Drop ours and use that one.
>> +	 */
>> +	if (of_syscon_register_regmap(syscfg_np, regmap)) {
>> +		regmap_exit(regmap);
>> +		iounmap(base);
>> +	}
> 
> [Severity: High]
> If another driver sharing the st,syscfg node (like Ethernet MAC, I2C, or USB)
> probes before pinctrl, won't the generic syscon layer have already
> instantiated a default regmap without use_raw_spinlock?
> 
> In that scenario, of_syscon_register_regmap() would return an error and the
> driver silently discards its raw regmap. Since the driver then falls back to
> the already registered sleeping regmap, does this cause the PREEMPT_RT 
> sleeping-in-atomic bug to persist when stm32_gpio_domain_activate() writes to
> the regmap under the raw desc->lock?
> 


True again for STM32F4/H7. But the syscfg node is shared between pinctrl and
pinctrl_z only on STM32MP series SoC, and that's the platform on which I tested
this patch.

Thanks sashiko-bot :P, I will send a V2 later.

>> +
>> +out_put:
>> +	of_node_put(syscfg_np);
>> +}
> 

