Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6D8319851;
	Sun, 12 Jul 2026 10:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783852210; cv=none; b=AQ/gv1vUN5uBqRDJZcYNqWfkep3ndyWOiTJ6Xeyl3ddgSSnWtibaXxB/dXH+8nBbBAAF9/zTY4hWmxteUhiofUPKsJh2doKXJQZ8dpncpckf2d1nB8fw2qLLFYMZEFYokZ3/Vpm3/MCMd7v2EuL+MYEbDDJMbMPeysQ8F1cx+xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783852210; c=relaxed/simple;
	bh=2LeuN8XfxNFqvH3+TMir9ZSxGZp824FLZ70WsXtK5eQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JKXINK4ZPMJySHRWsbHmx4bJ2ynr61O9cE61+kli9zGKNGtrWWnTLP6BmUFRKr0vwKnHozq2wGCXh7Hj1NywrvIbSqN1t/AbQJBzvGqJZRMjbjMJMjZ1jl1e5usyvVNLfp3EkHWqGScjp4ugrZtalzSWYQA71tHW2yvUAh3e1mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVOMvgeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVOMvgeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2071B1F000E9;
	Sun, 12 Jul 2026 10:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783852209;
	bh=K+E0wzF5X+eWcPcDmuv1BxWFOlFmO9M0zjV4XAK5gFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dVOMvgeLiDDV1RYFqE3TMBpeGBGal98XhcEhXjBqtZPyMA/+FIYpzF0yyVTZC8Vy6
	 yo0hLVyirgbImgyLjHjmgTY0VVeapPTSWBLuBqvq9f//l+hvtx95hdyuhyqg6cMf21
	 Pr28gMJd7CHkZHwUw9xoQJmZZgoPzpf8b2JNmItvk31zWJjMUm7m9wpzzoQXYHyw5Z
	 iPowD2W2YN2wqLYLm1N5eT///TB9yPqtcR+G4ZGJ6hm4xTZBs5vYpE3tFqolHmgCje
	 EdDqcD7yRkEQaaopSnCGW9vmLLrPHEgruw8YjzEXtbFCVXrcvdH9cDw7O+wGEvyiS0
	 xjdgUaj3f6Cww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/6] printk: add bounds checking to boot_delay
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Murray" <amurray@thegoodpenguin.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260712-printkcleanup-v3-2-574547b8f71b@thegoodpenguin.co.uk>
References: <20260712-printkcleanup-v3-0-574547b8f71b@thegoodpenguin.co.uk>
 <20260712-printkcleanup-v3-2-574547b8f71b@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 10:30:08 +0000
Message-Id: <20260712103009.2071B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The local variable `boot_delay_val` is read uninitialized when the=
 `boot_delay` kernel parameter is passed without a value, leading to massiv=
e and unpredictable boot delays.
--

--- Patch [2]: [PATCH v3 2/6] printk: add bounds checking to boot_delay ---
commit d84630c2b1ca4df747144242cedfc7df2ff7c068
Author: Andrew Murray <amurray@thegoodpenguin.co.uk>
printk: add bounds checking to boot_delay

This commit changes the boot_delay parameter type to an unsigned int and
adds explicit bounds checking to ensure it remains within a valid range.

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 31aabdf8248cc..8be562c9be277 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
[ ... ]
>  static int __init boot_delay_setup(char *str)
>  {
>  	unsigned long lpj;
> +	int boot_delay_val;
> =20
>  	lpj =3D preset_lpj ? preset_lpj : 1000000;	/* some guess */
>  	loops_per_msec =3D (unsigned long long)lpj / 1000 * HZ;
> =20
> -	get_option(&str, &boot_delay);
> -	if (boot_delay > 10 * 1000)
> -		boot_delay =3D 0;
> +	get_option(&str, &boot_delay_val);
> +	if (boot_delay_val < 0 || boot_delay_val > 10 * 1000)
> +		return 0;
> +
> +	boot_delay =3D (unsigned int)boot_delay_val;

[Severity: High]
Does this code leave boot_delay_val uninitialized if get_option() returns
early?

When the boot_delay parameter is supplied without an assigned value (for
example, just passing "boot_delay" on the kernel command line), parse_args()
and do_early_param() pass a NULL string to boot_delay_setup().

In this scenario, get_option() returns 0 immediately without writing to
boot_delay_val.

If the uninitialized stack value happens to fall between 0 and 10000, it
gets assigned to the global boot_delay. Could this cause unexpected and
massive boot delays after every printk message?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-printkclea=
nup-v3-0-574547b8f71b@thegoodpenguin.co.uk?part=3D2
