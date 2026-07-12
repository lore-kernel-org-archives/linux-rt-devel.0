Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C1175A81;
	Sun, 12 Jul 2026 10:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783852362; cv=none; b=CH/QBBuc/UXl+1cMjnLa48B9PN6CGd+xyQRbsNC3JcS9zdTFEZ6/pvH0mYMLzbzmo5vZDVEREp9NHy6YvDGeRyTfxhtcSBpK3ATNqcWwNjGZJm2AB2hYwJ0RY5+up+JXkzq0xVMRV5cEQPkCZN3iPOOyzj0Iy52v32k4Le1T500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783852362; c=relaxed/simple;
	bh=sjL0bSfBzOXOSGcqO2wQj2kPwq6H2up0Irmfi5y2eAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qGQNjouyQ/2jSG4xnYBfsPcWBCYItvPosL2sfdjSk9zvUsUXFgHwgkQATZ9aCVAP9O40W4UgweBb1gfSlJpEnvlbEFxOplxTupSWPwhscClOsUGwk9LjON81kMcksK0MMDfPlDVSZjgOqheM0UM/cdmaZMvxQ3a86nuvel8W0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxhOrqKi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxhOrqKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 682451F000E9;
	Sun, 12 Jul 2026 10:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783852360;
	bh=/5g5fmHhSk5kTHhVDnhJMQRt8Y/aHzdUqhmGqjAYfjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DxhOrqKiv/sd7PswolPVlLQZS+1u2D7s9msADHYCe1r0Z6z6FnbPOGkyCfdt1AaMP
	 PU11UrUXERPA4SwsJNLyfKj2ezhQcLAvdrUgsUXin9n/Gs4L7Ux5/MORCtkNAoZHsC
	 gWEYKTnJQngyzcRjl6q7B+TCmkkoeM60woBYsgjLtQ8w8kQLormuXTjNT4cb6FaBj4
	 UdxpWqFrVDGMY+cUhe60d86x81aQDzVOYuZYFfcT5MY53WBGo52n3FqSOF6XJRPQ7I
	 iH0RzGdmmOrLRqWQ/lecN2rUahdn1bRNufcNth4AflUj/gLXVc77MrXOQAJSjTh4QP
	 JDTOrCHLJyj/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] Documentation/kernel-parameters: add/update
 printk_delay/boot_delay
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Murray" <amurray@thegoodpenguin.co.uk>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260712-printkcleanup-v3-6-574547b8f71b@thegoodpenguin.co.uk>
References: <20260712-printkcleanup-v3-0-574547b8f71b@thegoodpenguin.co.uk>
 <20260712-printkcleanup-v3-6-574547b8f71b@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 10:32:39 +0000
Message-Id: <20260712103240.682451F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The documentation for the newly added `printk_delay=3D` parameter i=
ncorrectly advises users that they can specify `lpj=3D` to calibrate the ea=
rly boot delay. However, `printk_delay=3D` is an `early_param` while `lpj=
=3D` is processed later during `__setup`, meaning `lpj=3D` is always ignore=
d for early boot delays.
--

--- Patch [6]: [PATCH v3 6/6] Documentation/kernel-parameters: add/update p=
rintk_delay/boot_delay ---
commit 1f87f2eec164de9ec5ebb73bcbae241eb291ecf2
Author: Andrew Murray <amurray@thegoodpenguin.co.uk>

Documentation/kernel-parameters: add/update printk_delay/boot_delay

This commit updates the kernel-parameters documentation to reflect the
addition of printk_delay and the deprecation of boot_delay.

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt

[ ... ]

> @@ -5468,6 +5476,19 @@ Kernel parameters
>  	printk.time=3D	Show timing data prefixed to each printk message line
>  			Format: <bool>  (1/Y/y=3Denable, 0/N/n=3Ddisable)
> =20
> +	printk_delay=3D	[KNL,EARLY]
> +			Milliseconds to delay each printk during and post boot.
> +			Boot time delays only work if GENERIC_CALIBRATE_DELAY
> +			is enabled.
> +
> +			Once booted the delay can be removed or adjusted via
> +			the printk_delay sysctl.
> +
> +			Please note that you may also have to specify "lpj=3D".

[Severity: Low]
Does "lpj=3D" actually work for early boot delays?=20

Since printk_delay=3D is registered as an early_param and lpj=3D is registe=
red
via __setup in init/calibrate.c:lpj_setup(), lpj=3D is processed after early
parameters.

This means preset_lpj will always be 0 when kernel/printk/printk.c:
printk_delay_setup() calls printk_delay_calculate() during early boot,
causing it to silently ignore the provided lpj=3D value.

> +			printk_delay values larger than 10 seconds (10000) are
> +			assumed erroneous and ignored.
> +			Format: integer
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-printkclea=
nup-v3-0-574547b8f71b@thegoodpenguin.co.uk?part=3D6
