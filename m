Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE2B1DF74F
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Nov 2025 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762166504; cv=none; b=pBL2YsSR91nXOMRVqzHkAwUxot8jUng34JWGLX5tsdjszpyHt9mvkIjvpAcU8M85dofuxA2mtsgfXYddT73RLoNyuISpFrVE5E1Sdjdb/wPBGQO5C5Imj7BCU1tNEzl9GessPYtoUSb/RvNBBSJJT/LJg2hFLI34/pKROh3qK/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762166504; c=relaxed/simple;
	bh=ywHCDC6f70q+FVeVwqunZDaffuR4I1EUWoQ0AifeUk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxvN3gunxJ8EEkJcsR7yp1hprbgWPIobCeAMoAfLRvb7RJBCtjP7ZqLkPkYTxWyv9FR29WhYfK78aE5LRa9cM4CaUnV+el5vsDYvJWFJYoG+KoUx7AhM1o0LrGbT5yG37QwQlqvF07yzuj2hSw/+txRiA6LfRNohXz4nnqxE27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2KRnNo2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2KRnNo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9386EC4CEFD
	for <linux-rt-devel@lists.linux.dev>; Mon,  3 Nov 2025 10:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762166503;
	bh=ywHCDC6f70q+FVeVwqunZDaffuR4I1EUWoQ0AifeUk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=i2KRnNo2nLgcp0ju0M1YrqrrexGDv0pjZAm+p8PP1D261hfxiH2VgDYYQtWPFU2eI
	 vBJHYNtTXvQbSMZmuLHeH3BYZImua4W5iYahjt3wCb4QEyxFQsI7R828b9e629QRrz
	 p258VQ3CXkGgr9KV8bV33bgSUlajM+1x+0z+vVBOyZvM3bWdOvTBpJKmAFTqwd7tuV
	 +ua0y5c7vVNHkd8elgkQvqUZD6JPebbB4Crsy9GESsxWKr+0FQ2GEOMV6e2UPy4pfz
	 lebJv5yHWL82ORvjgvAHTq8hn3qpbCYLW/5yfI59Z2YHsxyTwFONfK9t6BKmh98Uhl
	 3MBVwbqH0QUSQ==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-378d50e1cccso43714731fa.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 03 Nov 2025 02:41:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWtuNEjqhin1ud6UqWdAIfjnGKgXiOAmcKL0izEj6b0+DlmXCKPbI9bBW8NZRml49gBlkj1LJzwiuClj4cIrQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwdE5gyAXjf5Pc3VNOVJPw2uhQT28JxMJ0QJxcslA4hE1kBQHIx
	U6FQEw0C6LKiiMrQ3NfTUKbeZJK39N3gn1e1p+WmYlD4EUcmzn2qENT+RWek0yTWIUNZQz8dmRK
	lDGGCOK7oKXECaAQjB+dO3xnObHQgyTc=
X-Google-Smtp-Source: AGHT+IGkM8viXJNBlQ80+5YfdV3jjNXsEEVUkp5Q6j2EjUrf25AVLVkvSj9qeEV5Pd0r/i3Y1KW9dhFw83oDj2eOFzM=
X-Received: by 2002:a05:651c:2103:b0:37a:15b6:f35b with SMTP id
 38308e7fff4ca-37a18d8ecabmr37322841fa.2.1762166501972; Mon, 03 Nov 2025
 02:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251103101545.760243-1-bigeasy@linutronix.de> <20251103101545.760243-4-bigeasy@linutronix.de>
In-Reply-To: <20251103101545.760243-4-bigeasy@linutronix.de>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 3 Nov 2025 11:41:30 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEv2iZ7UOiG7OSR3KQVguFtASh5yhpxMTXzuiZTOFz7_Q@mail.gmail.com>
X-Gm-Features: AWmQ_bmpyUNLlkLPqZocz3nncFM6nY6pwBfeKiZVNBLewlkUVJzl7p9usZ6XIY4
Message-ID: <CAMj1kXEv2iZ7UOiG7OSR3KQVguFtASh5yhpxMTXzuiZTOFz7_Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ARM: Disable jump-label on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-rt-devel@lists.linux.dev, 
	Russell King <linux@armlinux.org.uk>, Xie Yuanbin <xieyuanbin1@huawei.com>, 
	Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 3 Nov 2025 at 11:15, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> jump-labels are used to efficiently switch between two possible code
> paths. To achieve this, stop_machine() is used to keep the CPU in a
> known state while the opcode is modified. The usage of stop_machine()
> here leads to large latency spikes which can be observed on PREEMPT_RT.
>
> Jump labels may change the target during runtime and are not restricted
> to debug or "configuration/ setup" part of a PREEMPT_RT system where
> high latencies could be defined as acceptable.
>
> On 64-bit Arm, it is possible to use jump labels without the
> stop_machine() call, which architecturally provides a way to atomically
> change one 32-bit instruction word while keeping maintaining consistency,
> but this is not generally the case on 32-bit, in particular in thumb2
> mode.
>
> Disable jump-label support on a PREEMPT_RT system when SMP is enabled.
>
> [bigeasy: Patch description.]
> [arnd: add !SMP case, extend changelog]
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  arch/arm/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 2e3f93b690f47..92ca24336ec4b 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -80,7 +80,7 @@ config ARM
>         select HAS_IOPORT
>         select HAVE_ARCH_AUDITSYSCALL if AEABI && !OABI_COMPAT
>         select HAVE_ARCH_BITREVERSE if (CPU_32v7M || CPU_32v7) && !CPU_32v6
> -       select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU
> +       select HAVE_ARCH_JUMP_LABEL if !XIP_KERNEL && !CPU_ENDIAN_BE32 && MMU && (!PREEMPT_RT || !SMP)
>         select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
>         select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
>         select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
> --
> 2.51.0
>
