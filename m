Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47001EABA2;
	Fri,  8 Nov 2024 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078337; cv=none; b=AvS7jO3oodsl/Lfo8MwOWq92YYTBYSBRAVVvSvgLEqC43NttjmXNPERiU9QdobstbOJGTZtVNxij9XvcTHMvYSLCGo0NyQivAJ7QtjqItifyV42lq1fgB8UXhOtfGFRgMa+7pRh+luPOBV5IWQQCkmlgrpV1loOpWSmXI9OY2Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078337; c=relaxed/simple;
	bh=8KOpEqNXl7zuH4n2xZ+E3yhWKZMJsBdILBPRd/5Saik=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VE/bwhcajhplDHaWGBWF2vWw72lZFjRJ5gw8UWG+t1zlSmULt1E/nBanZQdm6GFTkdB5hw5Snndmm0qaYBzfglbKLOEwJzfKhOFdQsOopuU9Uy0Wvt8NM7Cpv5UvkOmxGV/zCdneYEOPtv6xzKWGG70vmNnghq8bN3RS2rzzODw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00A0C4CECD;
	Fri,  8 Nov 2024 15:05:35 +0000 (UTC)
Date: Fri, 8 Nov 2024 10:05:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
 loongarch@lists.linux.dev, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>,
 linux-rt-devel@lists.linux.dev, Guo Ren <guoren@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] LoongArch: Allow to enable PREEMPT_RT
Message-ID: <20241108100543.61769b59@gandalf.local.home>
In-Reply-To: <20241108091545.4182229-4-chenhuacai@loongson.cn>
References: <20241108091545.4182229-1-chenhuacai@loongson.cn>
	<20241108091545.4182229-4-chenhuacai@loongson.cn>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  8 Nov 2024 17:15:45 +0800
Huacai Chen <chenhuacai@loongson.cn> wrote:

> It is really time.
> 
> LoongArch has all the required architecture related changes, that have
> been identified over time, in order to enable PREEMPT_RT. With the recent
> printk changes, the last known road block has been addressed.
> 
> Allow to enable PREEMPT_RT on LoongArch.
> 
> Below are the latency data from cyclictest on a 4-core Loongson-3A5000
> machine, with a "make -j8" kernel building workload in the background.
> 
> 1. PREEMPT kernel with default configuration:
> 
> ./cyclictest -a -t -m -i200 -d0 -p99
> policy: fifo: loadavg: 8.78 8.96 8.64 10/296 64800
> T: 0 ( 4592) P:99 I:200 C:14838617 Min:   3 Act:    6 Avg:    8 Max:    844
> T: 1 ( 4593) P:99 I:200 C:14838765 Min:   3 Act:    9 Avg:    8 Max:    909
> T: 2 ( 4594) P:99 I:200 C:14838510 Min:   3 Act:    7 Avg:    8 Max:    832
> T: 3 ( 4595) P:99 I:200 C:14838631 Min:   3 Act:    8 Avg:    8 Max:    931
> 
> 2. PREEMPT_RT kernel with default configuration:
> 
> ./cyclictest -a -t -m -i200 -d0 -p99
> policy: fifo: loadavg: 10.38 10.47 10.35 9/336 77788
> T: 0 ( 3941) P:99 I:200 C:19439626 Min:   3 Act:   12 Avg:    8 Max:    227
> T: 1 ( 3942) P:99 I:200 C:19439624 Min:   2 Act:   11 Avg:    8 Max:    184
> T: 2 ( 3943) P:99 I:200 C:19439623 Min:   3 Act:    4 Avg:    7 Max:    223
> T: 3 ( 3944) P:99 I:200 C:19439623 Min:   2 Act:   10 Avg:    7 Max:    226
> 
> 3. PREEMPT_RT kernel with tuned configuration:
> 
> ./cyclictest -a -t -m -i200 -d0 -p99
> policy: fifo: loadavg: 10.52 10.66 10.62 12/334 109397
> T: 0 ( 4765) P:99 I:200 C:29335186 Min:   3 Act:    6 Avg:    8 Max:     62
> T: 1 ( 4766) P:99 I:200 C:29335185 Min:   3 Act:   10 Avg:    8 Max:     52
> T: 2 ( 4767) P:99 I:200 C:29335184 Min:   3 Act:    8 Avg:    8 Max:     64
> T: 3 ( 4768) P:99 I:200 C:29335183 Min:   3 Act:   12 Avg:    8 Max:     53
> 
> Main instruments of tuned configuration include: Disable the boot rom
> space in BIOS for kernel, in order to avoid speculative access to low-
> speed memory; Disable CPUFreq scaling; Disable RTC synchronization in
> the ntpd/chronyd service.

Nice! Looks good.

-- Steve

> 
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 3734f5dd9a57..26ed9d925e7f 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -66,6 +66,7 @@ config LOONGARCH
>  	select ARCH_SUPPORTS_LTO_CLANG
>  	select ARCH_SUPPORTS_LTO_CLANG_THIN
>  	select ARCH_SUPPORTS_NUMA_BALANCING
> +	select ARCH_SUPPORTS_RT
>  	select ARCH_USE_BUILTIN_BSWAP
>  	select ARCH_USE_CMPXCHG_LOCKREF
>  	select ARCH_USE_QUEUED_RWLOCKS

