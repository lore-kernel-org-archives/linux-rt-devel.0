Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D292828CF5D;
	Wed, 17 Jun 2026 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728371; cv=none; b=b8XSo0kQlNz/dJ5rtDYND8/iEJJh4e2k1CDCuAkgguOL4WavTDEW+pblDvU/dfg8egSbQ2AYkidQz9u8zjNJVSAfaJmxMna5lDUA+n+HXSetodjnpRZk5kFnWdHz8vRg+NIMIXf6toMZBNz3r3kwQHhV7XDCuXmIspKJ8T8286c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728371; c=relaxed/simple;
	bh=244F89HJq6grairusu2McbFxnZWIeBCe7PXbdWI8eIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=trvtFsTHcecdd31qMvx+GwHi3rOLX+b4K1Ta6cS5ri2TI/N3c/0lG8d3lRgudv71lPaUhjC9aSaQJcorzKVsBeCDkovAPZtvnPlP60vTFCADyiTkI2LZzgRzWYgM4kRgO6owbiu6Fl71eXAqSjOD66dt4SoUKUOLBTKTMEdswW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTMJpHCw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTMJpHCw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB581F000E9;
	Wed, 17 Jun 2026 20:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781728369;
	bh=InbGrCwGC2Nco5RREcwdgf8mYm4s8qhSQ3XSN/KA4bE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jTMJpHCwnoeVi8oklO74gUAzlvQBcgctt34KjparS39R7gzLPXH6yuDKen6WQWlxA
	 FG/EbazN+ycW27JUh9+iu4t0CVNYCxAiGQwl9FO/E4iJZ42GY2H0ECf7UZBtCw9S26
	 r05DoC5VqYKTaLrobR7QUs50IC9hIGcZOPgPiN/ulnyjOYrOLWKh34x+iJMjWeVGzO
	 CETr1flnrmIygU7/MwMVV+k6H2TsZFOwEtIJNf2dGE3zhyjCbD5Azs4tpsO6itxQP4
	 dU1sz1u2zM04kRlzl17ql4DbjZ/Q9M1+/58Bj/s6UPZwKtQETn6GVEjEAGUUh9CDXN
	 aoKc3xu2EWUwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] gpio: eic-sprd: use raw_spinlock_t in the irq
 startup path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260617154035.1199948-3-runyu.xiao@seu.edu.cn>
References: <20260617154035.1199948-1-runyu.xiao@seu.edu.cn>
 <20260617154035.1199948-3-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:32:48 +0000
Message-Id: <20260617203248.6EB581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Potential NULL pointer dereference in `sprd_eic_toggle_trigger=
` for unmapped or spurious hardware interrupts.
- [High] `sprd_eic_toggle_trigger` fails to properly toggle polarity for `S=
PRD_EIC_LATCH` because `sprd_eic_get` returns `-ENOTSUPP`.
- [High] Potential hardirq livelock and console spam due to `dev_warn` insi=
de a retry loop in `sprd_eic_toggle_trigger`.
- [High] Unbinding one EIC instance breaks all other EIC instances because =
they share the same parent IRQ chained handler.
- [High] sprd_eic_toggle_trigger modifies interrupt masks unconditionally w=
ithout holding desc->lock, creating a race condition with disable_irq().
--

commit 69e3dda6e9ba1a662342eec6f6b0ec04beeadc64
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

gpio: eic-sprd: use raw_spinlock_t in the irq startup path

sprd_eic_irq_unmask() enables the GPIO IRQ and then updates controller
state through sprd_eic_update(), which takes sprd_eic->lock with
spin_lock_irqsave(). The callback can be reached from irq_startup()
while setting up a requested IRQ, which is not sleepable on PREEMPT_RT.
This patch converts the lock to raw_spinlock_t to avoid sleeping.

> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index 50fafeda8d7e2..3b7ebcf12fe7f 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
[ ... ]
> @@ -149,7 +149,7 @@ static void sprd_eic_update(struct gpio_chip *chip, u=
nsigned int offset,
>  	unsigned long flags;
>  	u32 tmp;
> =20
> -	spin_lock_irqsave(&sprd_eic->lock, flags);
> +	raw_spin_lock_irqsave(&sprd_eic->lock, flags);
>  	tmp =3D readl_relaxed(base + reg);
> =20
>  	if (val)
> @@ -158,7 +158,7 @@ static void sprd_eic_update(struct gpio_chip *chip, u=
nsigned int offset,
>  		tmp &=3D ~BIT(SPRD_EIC_BIT(offset));
> =20
>  	writel_relaxed(tmp, base + reg);
> -	spin_unlock_irqrestore(&sprd_eic->lock, flags);
> +	raw_spin_unlock_irqrestore(&sprd_eic->lock, flags);
>  }

[Severity: Critical]
This is a pre-existing issue, but can sprd_eic_handle_one_type() cause a
NULL pointer dereference for unmapped or spurious hardware interrupts?

If an interrupt is unmapped, irq_find_mapping() returns 0:

drivers/gpio/gpio-eic-sprd.c:sprd_eic_handle_one_type() {
    ...
    girq =3D irq_find_mapping(chip->irq.domain, offset);
    generic_handle_irq(girq);
    sprd_eic_toggle_trigger(chip, girq, offset);
}

The girq value 0 is then passed into sprd_eic_toggle_trigger():

drivers/gpio/gpio-eic-sprd.c:sprd_eic_toggle_trigger() {
    ...
    struct irq_data *data =3D irq_get_irq_data(irq);
    u32 trigger =3D irqd_get_trigger_type(data);
    ...
}

Calling irq_get_irq_data(0) returns NULL, which causes irqd_get_trigger_typ=
e()
to dereference NULL. Can this path be triggered by the bootloader leaving an
interrupt unmasked?

[Severity: High]
This is a pre-existing issue, but does sprd_eic_toggle_trigger() race with
disable_irq() since it alters the hardware mask without holding the
descriptor lock?

Looking at sprd_eic_toggle_trigger(), it unconditionally calls
sprd_eic_irq_unmask() after returning from an interrupt handler:

drivers/gpio/gpio-eic-sprd.c:sprd_eic_toggle_trigger() {
    ...
    sprd_eic_irq_mask(data);
    ...
    sprd_eic_irq_unmask(data);
}

If a concurrent thread calls disable_irq(), which holds desc->lock and masks
the hardware, sprd_eic_toggle_trigger() could execute immediately afterward=
 and
unmask it again without checking irqd_irq_disabled(data). Can this leave the
system vulnerable to unhandled interrupt storms?

[Severity: High]
This is a pre-existing issue, but does sprd_eic_toggle_trigger() have a
potential hardirq livelock and console spam issue?

If the line state changes, the code logs a warning and retries endlessly:

drivers/gpio/gpio-eic-sprd.c:sprd_eic_toggle_trigger() {
    ...
retry:
    ...
    post_state =3D sprd_eic_get(chip, offset);
    if (state !=3D post_state) {
        dev_warn(chip->parent, "EIC level was changed.\n");
        state =3D post_state;
        goto retry;
    }
}

Since this runs in the context of a cascaded interrupt handler, if the input
line oscillates rapidly, will the dev_warn() overhead inside a tight loop
cause lockups and watchdog panics without any retry bounds?

[Severity: High]
This is a pre-existing issue, but does SPRD_EIC_LATCH fail to toggle polari=
ty?

In sprd_eic_toggle_trigger(), the state is used to set the latch polarity:

drivers/gpio/gpio-eic-sprd.c:sprd_eic_toggle_trigger() {
    ...
    state =3D sprd_eic_get(chip, offset);
    ...
    case SPRD_EIC_LATCH:
        if (state)
            sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 0);
        else
            sprd_eic_update(chip, offset, SPRD_EIC_LATCH_INTPOL, 1);
        break;
}

However, sprd_eic_get() doesn't implement reading for SPRD_EIC_LATCH
and returns -ENOTSUPP. This negative value evaluates as true, meaning the
code will always execute the true branch and never toggle to 1. Will this
cause LATCH EICs to become permanently stuck?

[ ... ]
> @@ -628,7 +628,7 @@ static int sprd_eic_probe(struct platform_device *pde=
v)
>  	if (!sprd_eic)
>  		return -ENOMEM;
> =20
> -	spin_lock_init(&sprd_eic->lock);
> +	raw_spin_lock_init(&sprd_eic->lock);
>  	sprd_eic->type =3D pdata->type;
> =20
>  	sprd_eic->irq =3D platform_get_irq(pdev, 0);

[Severity: High]
This is a pre-existing issue, but will unbinding one EIC instance break all
other EIC instances?

During probe, each instance sets its parent handler to sprd_eic_irq_handler
on the shared parent IRQ:

drivers/gpio/gpio-eic-sprd.c:sprd_eic_probe() {
    ...
    irq->parent_handler =3D sprd_eic_irq_handler;
    irq->parent_handler_data =3D sprd_eic;
    irq->num_parents =3D 1;
    irq->parents =3D &sprd_eic->irq;
    ...
}

If any single EIC instance is unbound, gpiolib's cleanup routine calls
irq_set_chained_handler_and_data(parent, NULL, NULL), clearing the shared
parent handler entirely. Will this leave the remaining EIC instances
completely non-functional?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617154035.1199=
948-1-runyu.xiao@seu.edu.cn?part=3D2
