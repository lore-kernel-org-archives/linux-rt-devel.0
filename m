Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB12FFF90;
	Fri, 31 Jul 2026 03:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785469198; cv=none; b=KuotqSEJBxhLeAatWg6WXQkJaMZgc/fxwcmWH+ea1jtdjjcrCOzH/Z/MSaFxwZwkEMq3PSnUELBAuASnzOqi2M1XjfdChYkfV0G3asRE0sbri0lyxmgbFBDRngl8P5r/UMyuB6xq4lJ8OVmdGOTQGrK5aNONgRVpqjfvaPCzQhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785469198; c=relaxed/simple;
	bh=MdocCksSYMb9QPKCMGzvW74rwsbTk9oAAin9HPC/NMU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mh7wo0X12QybQtPAnUIZKHEnQqnkewzncLQVVzL+0DjIx1adZgZSUAOJh9Fha6UpZcP0VbbOsT7IS9PR57EK7HNHxXKRXtRjhvRJNRXy1klZ6h6hG6wWNJ5G1EkHwXAtdvIPMAmQ2RZzqjeOMYfUoYX+GkKa/MRQ7zFgkakv6TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5d9mfWr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5d9mfWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6F61F000E9;
	Fri, 31 Jul 2026 03:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785469197;
	bh=kC2fHvPArVBTnfb6h+/PDZu7ExySC9HKoJrr3kS7Il4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A5d9mfWrdsaH5V6loNOmLESQueDghedKWIRQPiH4vGwGScjqVMJy995MrkkmK3WT9
	 5RMzuD9wZjfb8a/Pr7tXx2s8e9w2rBzU5Hvz6zNTiruUkc+8eTXQSvMlNkZ76M6JGN
	 HLLzgjjxvEgg81pd5lRp7GWqQ+tET4oO/vZXWIaBKtfn2H9FM60sclfBoYtQt/PiTh
	 ePaHr/HU5lKXQvoUFEq4VfBHkzLcs49jt7lqLcg6lh2kLOF9hYa9Z2z1EpkuPWntYu
	 IGVDrC6+CXFazg/lybes8fpoI2tjJhlF6WlU2EAoTtY2p6PO7sLqacvc+qiLBUhXl4
	 NGN76cQh21izQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpio: ml-ioh: use raw_spinlock_t for the register lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junjie Cao" <junjie.cao@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260731032747.2987292-1-junjie.cao@intel.com>
References: <20260731032747.2987292-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 03:39:56 +0000
Message-Id: <20260731033956.EE6F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Suspend and resume functions bypass spinlocks for channels 1-7, ca=
using data races on hardware registers.
- [High] The driver uses `handle_simple_irq` for all interrupts, which caus=
es an interrupt storm for level-triggered threaded interrupts.
--

--- Patch [1]: [PATCH] gpio: ml-ioh: use raw_spinlock_t for the register lo=
ck ---
commit c58bab978628257e8b70587775813cefa999a4d6
Author: Junjie Cao <junjie.cao@intel.com>

gpio: ml-ioh: use raw_spinlock_t for the register lock

This patch converts the driver's register lock from spinlock_t to
raw_spinlock_t. This fixes an issue on PREEMPT_RT where irqchip callbacks
invoked with hardirqs disabled would attempt to acquire a sleepable lock.

> diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
> index 6576e5dcb0eef..0a9d34b7636ef 100644
> --- a/drivers/gpio/gpio-ml-ioh.c
> +++ b/drivers/gpio/gpio-ml-ioh.c

[ ... ]

> @@ -256,7 +256,7 @@ static int ioh_irq_type(struct irq_data *d, unsigned =
int type)
>  	dev_dbg(chip->dev, "%s:irq=3D%d type=3D%d ch=3D%d pos=3D%d type=3D%d\n",
>  		__func__, irq, type, ch, im_pos, type);
> =20
> -	spin_lock_irqsave(&chip->spinlock, flags);
> +	raw_spin_lock_irqsave(&chip->spinlock, flags);
> =20
>  	switch (type) {
>  	case IRQ_TYPE_EDGE_RISING:

[Severity: High]
This is a pre-existing issue, but does this driver fail to assign the
correct flow handler for level-triggered interrupts?

During initialization, ioh_gpio_alloc_generic_chip() in
drivers/gpio/gpio-ml-ioh.c assigns handle_simple_irq to all interrupts:

gc =3D devm_irq_alloc_generic_chip(chip->dev, "ioh_gpio", 1, irq_start,
                                 chip->base, handle_simple_irq);

When a client driver requests a level-triggered threaded interrupt,
shouldn't ioh_irq_type() call irq_set_handler_locked() to switch the
flow handler to handle_level_irq?

Because handle_simple_irq does not mask the interrupt before waking the
thread, returning from the primary handler will immediately re-assert the
interrupt if the external hardware hasn't been serviced yet, leading to a
hardirq storm.

[ ... ]

> @@ -484,9 +484,9 @@ static int ioh_gpio_suspend(struct device *dev)
>  	struct ioh_gpio *chip =3D dev_get_drvdata(dev);
>  	unsigned long flags;
> =20
> -	spin_lock_irqsave(&chip->spinlock, flags);
> +	raw_spin_lock_irqsave(&chip->spinlock, flags);
>  	ioh_gpio_save_reg_conf(chip);

[Severity: High]
This isn't a bug introduced by this patch, but does this lock only protect
the first of the eight GPIO chips?

In ioh_gpio_suspend(), we retrieve the base pointer to an array of 8 chips
and acquire the lock for chip[0]. However, ioh_gpio_save_reg_conf()
iterates through and saves registers for all 8 chips without acquiring
their respective locks:

static void ioh_gpio_save_reg_conf(struct ioh_gpio *chip)
{
    int i;
    for (i =3D 0; i < 8; i++, chip++) {
        chip->ioh_gpio_reg.po_reg =3D
                    ioread32(&chip->reg->regs[chip->ch].po);
        ...

If a concurrent operation accesses channels 1-7 during this time, it
will acquire the lock for that specific channel (like chip[1].spinlock),
which isn't held by the suspend path, potentially causing a data race.

> -	spin_unlock_irqrestore(&chip->spinlock, flags);
> +	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
> =20
>  	return 0;
>  }
> @@ -496,11 +496,11 @@ static int ioh_gpio_resume(struct device *dev)
>  	struct ioh_gpio *chip =3D dev_get_drvdata(dev);
>  	unsigned long flags;
> =20
> -	spin_lock_irqsave(&chip->spinlock, flags);
> +	raw_spin_lock_irqsave(&chip->spinlock, flags);
>  	iowrite32(0x01, &chip->reg->srst);
>  	iowrite32(0x00, &chip->reg->srst);
>  	ioh_gpio_restore_reg_conf(chip);

[Severity: High]
This is a pre-existing issue, but does the same data race occur here
during resume?

ioh_gpio_restore_reg_conf() also loops over all 8 chips and blindly
restores their registers, protected solely by chip[0]'s spinlock. Could
this overwrite concurrent changes to channels 1-7?

> -	spin_unlock_irqrestore(&chip->spinlock, flags);
> +	raw_spin_unlock_irqrestore(&chip->spinlock, flags);
> =20
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731032747.2987=
292-1-junjie.cao@intel.com?part=3D1
