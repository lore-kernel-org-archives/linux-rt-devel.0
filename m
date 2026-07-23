Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE5B7080D;
	Thu, 23 Jul 2026 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784772160; cv=none; b=KLR75OsmZmAAAbIGVY/vFqpcmLVDqJaP9oPHcgmA4cXyooH+aqwpjOTpwlf2fY+J2vmXusfpB6QRMsUjGGKXj1tilUWrDzbqWJtIKDYY0wEwr4pLVzMVcB/aYK6aAp3C2oluaErCV07x8TwRJPRGjb2pd3PLmFcArkqzg53rUog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784772160; c=relaxed/simple;
	bh=6FZo6Z42pHh3qOLHOsyHmUkINVTVkzQLzxCFW6UQ0zk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cIacIEAsqZMZopNBrECyPxt1lIgDIGmJAPjIOhUUKz/puy/HATC1bVhBdN5aR9TzKTRTEaaToxckOWV1/5MsG6JfFMOrkipvpoUPktxOvsG/qc8eUgHoUi8hyFVBC9uhn+Kw7BPTbzhHPrYc02SJnv9+/vDyaPBNkaTZyBzHTVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AjlsX7OL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AjlsX7OL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1776C1F000E9;
	Thu, 23 Jul 2026 02:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784772159;
	bh=8w2X05O1575+fHNU5xD4IxJXcFclve8e1n0oPHDroHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AjlsX7OLfdiPquAJ2eqcUNPeoolluHWqJqeLvR3SQj+V5tZsf7QGa3Bq2gu2d9EEz
	 yqpbigdjjaUWD1CkQhQqMlMpKqswvN4Sesyw0jiitgXd1gqPCBusMtkK/pCjGtVNfK
	 ULn1apDBPgxMlMWE8PHXZzebyLqMPJx26WXBlUdG0EThQj/XUgp6GVESDn9pDpDetz
	 8SDJO1kjvpUw0RLiNHOReZRvJLWNFBJ8OIBfNdSlvIS5KVUuyDRkrlhGNxeBmamBwH
	 KXgDoQOLXE8bL+UIiZ5W8roVWpNm9ws3/Fcie09mu7DI6zt8KhMZT0aV+0wrtCmFYE
	 bbC4KLw+CkZfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gpio: pch: use raw_spinlock_t for the register lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Junjie Cao" <junjie.cao@intel.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260723014129.1129730-1-junjie.cao@intel.com>
References: <20260723014129.1129730-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 02:02:38 +0000
Message-Id: <20260723020239.1776C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The GPIO chip is registered via devm_gpiochip_add_data() before it=
s irq_base is initialized, exposing incorrect IRQ mappings to consumers.
- [High] The shared interrupt handler is requested before the generic irqch=
ip is fully initialized, which could lead to uninitialized descriptor acces=
ses.
- [High] pch_gpio_to_irq() returns valid-looking bogus IRQ numbers when IRQ=
 allocation fails during probe.
--

--- Patch [1]: [PATCH] gpio: pch: use raw_spinlock_t for the register lock =
---
commit 90a7cbda6861f749a9ed833233971bb8a60d95dc
Author: Junjie Cao <junjie.cao@intel.com>

gpio: pch: use raw_spinlock_t for the register lock

This patch converts the spinlock_t register lock in the PCH GPIO driver to a
raw_spinlock_t. This prevents invalid wait context and scheduling while ato=
mic
issues on PREEMPT_RT kernels, as the lock is acquired within the non-sleepa=
ble
irq_set_type callback.

> diff --git a/drivers/gpio/gpio-pch.c b/drivers/gpio/gpio-pch.c
> index 4ffa0955a9e3d..07a5617b314b3 100644
> --- a/drivers/gpio/gpio-pch.c
> +++ b/drivers/gpio/gpio-pch.c
[ ... ]
> @@ -374,7 +374,7 @@ static int pch_gpio_probe(struct pci_dev *pdev,
>  	chip->ioh =3D id->driver_data;
>  	chip->reg =3D chip->base;
>  	pci_set_drvdata(pdev, chip);
> -	spin_lock_init(&chip->spinlock);
> +	raw_spin_lock_init(&chip->spinlock);
>  	pch_gpio_setup(chip);
> =20
>  	ret =3D devm_gpiochip_add_data(dev, &chip->gpio, chip);

[Severity: High]
This isn't a bug introduced by this patch, but in
drivers/gpio/gpio-pch.c:pch_gpio_probe(), does registering the GPIO chip be=
fore
initializing its IRQ base expose incorrect IRQ mappings to consumers?

If a consumer acquires the GPIO and calls gpiod_to_irq() in the race window
after devm_gpiochip_add_data() but before devm_irq_alloc_descs() sets
chip->irq_base, pch_gpio_to_irq() will return 0 + offset since the chip
structure is initially zeroed out.

[Severity: High]
This is a pre-existing issue, but in drivers/gpio/gpio-pch.c:pch_gpio_probe=
(),
if devm_irq_alloc_descs() fails, probe succeeds but leaves chip->irq_base
as -1:

	irq_base =3D devm_irq_alloc_descs(dev, -1, 0,
					gpio_pins[chip->ioh], NUMA_NO_NODE);
	if (irq_base < 0) {
		dev_warn(dev, "PCH gpio: Failed to get IRQ base num\n");
		chip->irq_base =3D -1;
		return 0;
	}

When a consumer later calls gpiod_to_irq(), pch_gpio_to_irq() calculates
chip->irq_base + offset:

static int pch_gpio_to_irq(struct gpio_chip *gpio, unsigned int offset)
{
	struct pch_gpio *chip =3D gpiochip_get_data(gpio);

	return chip->irq_base + offset;
}

For offsets > 0, does this compute a non-negative value (e.g. 0, 1, 2),
breaking the error-reporting contract of to_irq and potentially causing
consumers to steal essential system IRQs?

[Severity: High]
This is also a pre-existing issue, but later in
drivers/gpio/gpio-pch.c:pch_gpio_probe(), the shared interrupt handler is
requested before the generic irqchip is allocated:

	ret =3D devm_request_irq(dev, pdev->irq, pch_gpio_handler,
			       IRQF_SHARED, KBUILD_MODNAME, chip);
	if (ret)
		return dev_err_probe(dev, ret, "Failed to request IRQ\n");

	return pch_gpio_alloc_generic_chip(chip, irq_base, gpio_pins[chip->ioh]);

If an interrupt fires immediately on the shared line, could pch_gpio_handle=
r()
try to dispatch the interrupt using uninitialized descriptors, leading to a
handle_bad_irq warning and potentially disabling the shared interrupt line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723014129.1129=
730-1-junjie.cao@intel.com?part=3D1
