Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1CD3C1973;
	Tue, 30 Jun 2026 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839292; cv=none; b=tEX5dqaZdNOPPqCQlAbn8Kls4+ZNSqvSPu713l+tE4q7wOVy4WdexhpZWnvw9eFkSaIAoorv/5jgGC122r3zfMpoMCAgg1O2N6ws7d+gn0+jE7/8m4lC6rxfoIiC4FFxmqWnurzaJKyeXPntOlzfdVaKZQPk5qJtsMzdx2I//xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839292; c=relaxed/simple;
	bh=CauJ0ruz274Y5Yv3bZsqPmTRTcwjrDC7xvLRW2VCI20=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LHPwsH4xh3BYg6/BBGtLgoUZwggB/Nq6vIOvaqWLFuHQI58DjmzhI7m3Pb6EF4Uxh0PHt+LNWaz2djlLgSOTjXM8dRz99o3WxfITDOQq7a/63hmyjCpft+Uvv0xScl186wYqob8CgTtFxB0EfJARZIdkMbuez13d2xzNTM4jlz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7hlG3QK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7hlG3QK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA0B51F000E9;
	Tue, 30 Jun 2026 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839291;
	bh=PUWJVOxa9/zJtVmt7IKZa3ZmjkhSiZvqlylKz6yOzMk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F7hlG3QKdk7nZAVgvOIgQk1s9dY8c7VfutqS6igHhM7cKfbMJ13MhhV8SW0yQJOaR
	 Q/rXdrVD6axo5iTP89zM7OiYw+JxQfmdgkSCz32Kq5nHKDnirTxtZa6mAaQjJ+48kp
	 yqH/VMRUlVgeEW0SHEXNqgfuWXebQ0bGu4JUyFMtG+hmA5gafFUD408rl0kRL9K+AZ
	 zpEhgIq2iNIrt5T1AzC7rIGrb+mdKm2LeJYSXG7s1ibFF0FERVxyw+yGLFrj71gxQ1
	 9BxLfonyz/sllvm5ODOkmAUifjHTu823UZsrebJB1phbZ9NzazSAtGhWwokw2lo/la
	 9jC6G/7rUQgTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] printk: remove BOOT_PRINTK_DELAY config option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Murray" <amurray@thegoodpenguin.co.uk>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260630-deprecate_boot_delay-v2-1-f9883d36aa4b@thegoodpenguin.co.uk>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-1-f9883d36aa4b@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:08:10 +0000
Message-Id: <20260630170810.BA0B51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The kernel command line parameter `boot_delay` can be parsed as a =
negative integer, which causes a massive integer underflow and a near-infin=
ite loop, resulting in a boot hang.
--

commit 7ede3add142d62f673ea88e35c108d0ec8e7599d
Author: Andrew Murray <amurray@thegoodpenguin.co.uk>

printk: remove BOOT_PRINTK_DELAY config option

The boot_delay (BOOT_PRINTK_DELAY) kernel parameter and printk_delay sysctl
are two distinct mechanisms for providing similar functionality which add a
delay prior to each printed printk message. This commit prepares to combine
them by removing the BOOT_PRINTK_DELAY kconfig option.

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 2fe9a963c823a..77f53eaed1321 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1289,7 +1289,7 @@ static bool suppress_message_printing(int level)
>  	return (level >=3D console_loglevel && !ignore_loglevel);
>  }
> =20
> -#ifdef CONFIG_BOOT_PRINTK_DELAY
> +#ifdef CONFIG_GENERIC_CALIBRATE_DELAY
> =20
>  static int boot_delay; /* msecs delay after each printk during bootup */
>  static unsigned long long loops_per_msec;	/* based on boot_delay */

[Severity: High]
This is a pre-existing issue, but does expanding the availability of the
boot_delay parameter expose a potential boot hang if a negative value is
provided on the kernel command line?

When boot_delay is parsed in boot_delay_setup(), the bounds check does not
reject negative inputs:

kernel/printk/printk.c:boot_delay_setup() {
    ...
    get_option(&str, &boot_delay);
    if (boot_delay > 10 * 1000)
        boot_delay =3D 0;
    ...
}

If a user provides a negative value like boot_delay=3D-1, could
boot_delay_msec() cast this negative integer to an unsigned type, resulting
in an immense timeout?

kernel/printk/printk.c:boot_delay_msec() {
    ...
    k =3D (unsigned long long)loops_per_msec * boot_delay;

    timeout =3D jiffies + msecs_to_jiffies(boot_delay);
    ...
}

Because msecs_to_jiffies() casts the negative value to an unsigned int, this
could result in spinning in cpu_relax() almost indefinitely.

Might it be safer to add a check in boot_delay_setup() to ensure boot_delay
is not less than zero?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-deprecate_=
boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk?part=3D1
