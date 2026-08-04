Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B999A184;
	Tue,  4 Aug 2026 03:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785814705; cv=none; b=LF+tnxOtDdvXTLK+9pC71u5qDhm8H4AsYJl98qfykxWkrUC8qx+p8Y2kI77dgZRMdfaxUi1q7ahbzM0Ze+NIyvUKbPBvjTZv6dbACvosAgdX1F31h63Q6/pAhPBDJBi1kl7iGYrZ0K26FH6s9DWB3xippsD5EzCH4xeBboWUUcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785814705; c=relaxed/simple;
	bh=em2d2679/q9dJUAyj6/jD1FJeVjJqOByKLBKL2PcAsM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WPFedoqJmEBIiohEJSnzAZiojiO9ovgnwhb6+RpgWF6uJBBCXK6usIElSgnk62IxRClroBiw+A5p1xOAXLwrFd44D4ehn6NvsCySPELf1aHOh+dFgv04lYTZiEVl4ebnL/fWHMkEH5i2r6tFpPmmH8EnJ4C2L/KzTR3qQmKI3hA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8GGz+jp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8GGz+jp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3585B1F000E9;
	Tue,  4 Aug 2026 03:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785814704;
	bh=LT/JUv0n5z4Tk1NjC7c6CVIrYJj8B5LFDHvCFnM6yCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l8GGz+jpPaaiV9d420+voxH6Ruq0tYnsqxXzrWXTdhtQEhNpln1G2ZXCge/NbVs1R
	 irP7TzLMeQmdF4UtN7YITSdZJWri1KT/k4EG4Xpattv0SAAXGmTWpa3KeC1eEmw8JF
	 ZPVwTlMqXTyZVHKnh20A0jUMXaOu3gnNFfSK/bpmPvOmMXLZ6j8ytN8gWoL7qShvqY
	 Tg0QC5TT0cpixMKpvf/l938h5wzm+XzRnuSNoKUUl75T6oofVJE0KZSoRoZO54EGsZ
	 5t7bawY2Akc8HXWmLK1vi7T/60Y7Eed/5qHewQF52udinYESYWaxDTouttHAxJhVpI
	 gtAzaDzkK0HBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] pinctrl: stm32: program the EXTI mux from .alloc
 instead of .activate
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ju Nan" <junan76@163.com>
Cc: lee@kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, mfd@lists.linux.dev
In-Reply-To: <20260804032227.35017-3-junan76@163.com>
References: <20260803061718.43210-1-junan76@163.com>
 <20260804032227.35017-3-junan76@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 03:38:23 +0000
Message-Id: <20260804033824.3585B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hwspin_lock_timeout_in_atomic() is called in a sleepable context a=
nd held across a sleepable operation, leading to hardware lock corruption a=
nd co-processor lockups.
--

--- Patch [1]: [PATCH v2] pinctrl: stm32: program the EXTI mux from .alloc =
instead of .activate ---
commit e4c0724053fe56b6dc864fd8cb1577c252a8ed5b
Author: Ju Nan <junan76@163.com>

pinctrl: stm32: program the EXTI mux from .alloc instead of .activate

This commit moves the programming of the EXTI mux and its associated hardwa=
re
spinlock from the .activate callback (an atomic context) to the .alloc
callback (a sleepable context) to resolve invalid wait context bugs on
PREEMPT_RT.

Closes: https://lore.kernel.org/all/20220202174430.pf37tt6lua2op3gc@pengutr=
onix.de/

> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm3=
2/pinctrl-stm32.c
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c

[ ... ]

> @@ -653,6 +629,27 @@ static int stm32_gpio_domain_alloc(struct irq_domain=
 *d,
>  	if (ret)
>  		return ret;
> =20
> +	/*
> +	 * Now that the line is reserved, point its mux at this bank. Doing it
> +	 * here rather than from .activate() keeps the access out of the raw
> +	 * atomic section the irq core runs .activate() in; nothing needs it to
> +	 * be reprogrammed at startup time, and the resume path rewrites it on
> +	 * its own.
> +	 */
> +	if (pctl->hwlock) {
> +		ret =3D hwspin_lock_timeout_in_atomic(pctl->hwlock,
> +						    HWSPNLCK_TIMEOUT);

[Severity: High]
Since stm32_gpio_domain_alloc() runs in a sleepable context, could using the
_in_atomic variant of the hwspinlock lead to lock corruption?

The _in_atomic variant skips local locking, meaning it does not disable
preemption or local IRQs. Without preemption disabled, can two Linux threads
concurrently attempt to acquire the lock and corrupt its state?

> +		if (ret) {
> +			dev_err(pctl->dev, "Can't get hwspinlock\n");
> +			goto err_free_mux;
> +		}
> +	}
> +
> +	regmap_field_write(pctl->irqmux[hwirq], bank->bank_ioport_nr);

[Severity: High]
Can this sequence cause a deadlock with co-processors on PREEMPT_RT systems?

Hardware spinlocks are cross-core resources. Because this is now in a=20
sleepable context, regmap_field_write() can sleep on PREEMPT_RT while
contending for its lock. If the thread is preempted or sleeps while holding=
=20
the hardware spinlock, will co-processors attempting to acquire the lock=20
spin forever and hang?

> +
> +	if (pctl->hwlock)
> +		hwspin_unlock_in_atomic(pctl->hwlock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804032227.3501=
7-3-junan76@163.com?part=3D1
