Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B327C55C319;
	Wed, 14 Oct 2026 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994842; cv=none; b=N63A0kyxBQCIv6cwjzA0Qp0mpBLS2zPr5CuazWykZFhlxPtHXvkjFtgn8XeLpSocDQErnkh0iu/zpcye+zzXSpiP9EBLw+kEQCUKh7AHBl8SXQtemz3tpfEd+y4AYAb03ewPUfDmOitXJ/jJWzmtnADLe0j9sAQr3WDLGpBHQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994842; c=relaxed/simple;
	bh=BA63DfBqD4GX5KxgTBNJ4SlIgSApddIn/Z38iRlmodg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ATPA+sahH8ROhlIiRoltPpm3BCjvjZDubUs7LAWQjZZe34QU3qzLOR0LoyQBPcbcF89sVbVvFxh4lWy4VJ6KunvG0ztG98l6MaF3R3qDrkBcffGmEoYa7XFO14h209vsmd+mGrh5acDi9lVJGkV91ciHba8fVrtM/7bilUdp+Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3fIAepR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3fIAepR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3C01F000C4;
	Wed, 14 Oct 2026 16:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791994837;
	bh=MouLh1BUaaXNAJgSChZQtUApspyT7f0na2hcEZ8x2zw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3fIAepRjqRno40hkJXSaxFeB18+ySFdMAmtna6JYJcjqCpZrk+ZFncMG4LszWzhs
	 VJD0YSXGVVYigRGZhCAzqQf89vNidvKGIGGfblV0Dd3V3U6TflZO0CBW5H8NJ1N7ok
	 VsIZ0RQQ7J8uhlc9Me1VWahq6snn9zf8pmzhyE6IWgxAJYtt/w1BEnOD74f5XAOcp0
	 RRWGpyVHrl6y4gPa1pq5FfXmjSe7gmdclDrEXNh8FVWgV4ob+9p+S8ovl2kE9Jkf7j
	 1q68H43vr7nG8oJym2MbewUDInnxTl4tDnBuTRe4ksepHuN840W23vb8uDUEZ6GR9f
	 IN6UZ5OwqA8Ig==
Message-ID: <sashiko-outbox-171521@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] pinctrl: stm32: Fix the unit of the hwspinlock
 timeout
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ju Nan" <junan76@163.com>
Cc: linux-gpio@vger.kernel.org, linux-rt-devel@lists.linux.dev, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, lee@kernel.org
In-Reply-To: <20261014160917.139241-3-junan76@163.com>
References: <20261014160917.139241-2-junan76@163.com>
 <20261014160917.139241-3-junan76@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 16:20:36 +0000
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pinctrl: stm32: same-CPU starvation with HWLOCK_IN_ATOMIC on PREEM=
PT_RT
--

commit 635cf6ace8c829d5e8fd3222bc79311f9ac07fc2
Author: Ju Nan <junan76@163.com>

pinctrl: stm32: Fix the unit of the hwspinlock timeout

This commit updates the hardware spinlock timeout parameter passed to
hwspin_lock_timeout_in_atomic(). It modifies the timeout constant name and
changes its value from microseconds to milliseconds across the stm32 pinctrl
driver to match the expected API units.

> diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm3=
2/pinctrl-stm32.c
> --- a/drivers/pinctrl/stm32/pinctrl-stm32.c
> +++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
[ ... ]
> @@ -946,7 +946,7 @@ static int stm32_pmx_set_mode(struct stm32_gpio_bank =
*bank,
> =20
>  	if (pctl->hwlock) {
>  		err =3D hwspin_lock_timeout_in_atomic(pctl->hwlock,
> -						    HWSPNLCK_TIMEOUT);
> +						    HWSPNLCK_TIMEOUT_MS);

[Severity: High]
Does calling hwspin_lock_timeout_in_atomic() here cause a same-CPU starvati=
on
issue on PREEMPT_RT?

Because hwspin_lock_timeout_in_atomic() uses the HWLOCK_IN_ATOMIC mode,
it implements the timeout by busy-waiting via udelay() and assumes preempti=
on
is disabled by the caller.

However, on PREEMPT_RT, spin_lock_irqsave(&bank->lock) acquires an rt_mutex
which leaves preemption enabled.

If thread A acquires pctl->hwlock and is preempted, and thread B on the
same CPU subsequently acquires a different bank's lock and attempts to acqu=
ire
this shared pctl->hwlock, thread B will busy-wait.

Since thread B loops in a busy-wait for the entire 1ms timeout, thread A is
starved and cannot run to release the hardware lock, resulting in a guarant=
eed
spurious -ETIMEDOUT failure for thread B.

>  		if (err) {
>  			dev_err(pctl->dev, "Can't get hwspinlock\n");
>  			goto unlock;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261014160917.1392=
41-2-junan76@163.com?part=3D1
