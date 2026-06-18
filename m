Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059318872A;
	Thu, 18 Jun 2026 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781770559; cv=none; b=iSx7cl1eCUJtJytNm4++787mQSPSkPZB6ueN91p0HeehyAZf6+/pZaouAnOzfb57c+Pcxw0DCdAXn/z6Eb1XEna5E95F4+q98as+BwY+vg7Wk33+d75Z0++7s7xzYNWVH01KmgzVzo3Ta5hF1uMsrjGGVPw5h16ZzY3h1F+pSsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781770559; c=relaxed/simple;
	bh=Ft3DR8HYqhv7bLm/AkmBWtVUOn1fgDkjToaIGnHHPQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRgu72CWAD3+eOYqhqmLtHMKM7fOYiIrxCbyuVx1RueaDZqVNwR/aCEgelwgKnuhWc/6lKTiLxQvjN7B4VMionDgGOlwa6VFF7ZvfjGWYOAGbdbRSAMUqUHX4YcgYdgdXZMctqeN245yutNw6kLa7rWL/YhpdWf7D53RTNyW3kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r0y5D7NJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5CPeMOk3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r0y5D7NJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5CPeMOk3"
Date: Thu, 18 Jun 2026 10:15:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781770556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfKiKVq3hU3pjcBqUpBBITy3boOVHoqwPFPh0Ujjzk8=;
	b=r0y5D7NJYb4QTTOEoORJ6biEUdtaD8LliAbG4rfJBSYfP0u/4miH20xoNkr3VAJVDDr+hC
	2kw2RkVTQhqwfZ3NbbLjKlVNdqpSNWt05bqc2Cmou0QG4NwzmxuSAv0cZtsEvMfp4bst5e
	YyY6mDGnP6vXPicLqUmAjUycpPhx6b0CFwsKA5m1cGmF0wx5zPIVU5pypGLf2IpVyj8IWg
	4Dz+Ji6QZpVMFvIvCkBOWOtIp/rftXIsEtbwCmDputtdUXO6yOxWfmrHJvZAaBYGS/oAE+
	XQgLfSbYtvGuLL6Bjvyv9y1vmxnDnBRfP8kv1iniZV3g3lCp9K8AqP7ya9QmAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781770556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bfKiKVq3hU3pjcBqUpBBITy3boOVHoqwPFPh0Ujjzk8=;
	b=5CPeMOk3GIo1h9V/CqjAAL8dMVouMDzCVxeFdnTfaVIMu/N/0RPcwSBhdwm/hFObeI/2/w
	39FONTNnrS0xcEAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>, Mark Brown <broonie@kernel.org>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
	linux-gpio@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: Question: SPEAr PLGPIO irq_enable on PREEMPT_RT and regmap
 updates
Message-ID: <20260618081554.zifCwv4I@linutronix.de>
References: <20260618023418.213453-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260618023418.213453-1-runyu.xiao@seu.edu.cn>

On 2026-06-18 10:34:18 [+0800], Runyu Xiao wrote:
> Hi,
Hi,

=E2=80=A6
> The repair I am considering is to keep the gpiolib resource updates in
> the fast irq_enable/irq_disable callbacks, but defer the actual PLGPIO
> IE/EIT register writes to irq_bus_sync_unlock(), after the IRQ core has
> dropped desc->lock.  The driver would keep per-line shadow state for:
>=20
>   - IRQ disabled/enabled state
>   - pending IE update
>   - edge direction state
>   - pending EIT update
>=20
> and then synchronize those shadow updates from irq_bus_sync_unlock()
> under a mutex.

Not sure how this will look like, but okay. I was looking at making the
a lock a raw_spinlock_t for fast_io. Since it is just a read and write
it shouldn't be a problem. But then there is the regcache and the sync
of many registers might be painful. The actual problem is the type MAPLE
and RBTREE which have an allocation in their write callback. That is a
no but the FLAT ones should work since there is just one alloc during
init. Well, wouldn't it be for the lock that is acquired during the
callback.

I don't think this is required given that it is init time so
holding the lock shouldn't be required. This was introduced in commit
fd4ebc07b4dff ("regmap: Hold the regmap lock when allocating and freeing
the cache"). This change broke gpio-104-idio-16.c, pio-pci-idio-16.c,
pio-pcie-idio-24, gpio-ws16c48.c and pinctrl-apple-gpio.c.

So unless there is something that I miss=E2=80=A6

> In other words, the fast callbacks would only update local shadow state
> and call gpiochip_enable_irq()/gpiochip_disable_irq(), while the sleepable
> regmap writes would be batched into the irq bus sync phase.
>=20
> Does that sound like an acceptable direction for SPEAr PLGPIO, or would
> you prefer a different fix, such as changing the underlying syscon regmap
> locking model or handling only the IE register path?
>=20
> The draft patch I have locally is roughly:
>=20
>   pinctrl: spear: defer PLGPIO IRQ updates to bus sync
>=20
> and it changes only drivers/pinctrl/spear/pinctrl-plgpio.c.
>=20
> Thanks,
> Runyu

Sebastian
