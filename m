Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64DE3D6CD6;
	Tue, 30 Jun 2026 16:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838153; cv=none; b=CbOcDY9sXaNQYFt1d0Hpj9vwmAk42jmX7QHMHFDzsHGke2WOeKnKA8ukAkrHv5oVBnCUWH1B0eIjIZNjdrQTxyomJZQElGABhGDDzRRBFLel9zvJqTA24skD3hhV4zcbxjcyecSgsT95FKzynDPb6lEOU1Da1FVVWLeo1dDTkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838153; c=relaxed/simple;
	bh=cMdIekInDHe3eARpQSoWS4XLsaF9GpDrO8uqfbhFXfg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtPtxdIlaGu41ZZmtZ5l87tJ36wLaL94xmbHgNTZf0fdTQamzoE+xhl0NU5WNjNcaVC+4tmcwoCAk9oVJIyJ9EG90r5fBha4gus9cluZFhHqcSQDSggL9JysJ48FJ9Ah+r4v6rLZaTv1EMiBoWXf2DFIUNxEX6kOFClS7fOCgKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jd17sz/m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd17sz/m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973F31F000E9;
	Tue, 30 Jun 2026 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782838152;
	bh=3jTqeCAn3eXbJ2egoqB5crzhxUIPPMaB6Na2gAMhgG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jd17sz/m//KCQrHQjIYt0uLpMEy4nJU+OofpFaOwwHvGtg/IiC7QIiQID4Jw8tK/u
	 Jxsjypn2gLYR8Gnx6BvWXjMgSdvICqLGTBDNX7ZvzbsjX/x+0lvUYYgG7yF1ZSqMbT
	 tRuUkZo1TDF2XQN3yPQqn460Ho2NL1neIewjtFHF5oOJ6gJtUyVa7P6+rM9lh1X1Cs
	 mxNTW6T00dC+TCb9yYI7dkshEASBlgxk6ijMyTR3xwJdhOYNpWbNDX5m+F/jBLGzhV
	 oP6PQBwPUzGR90oVLkQWn32D8L7e+ssbG2kA+Nuk3Mp9cH/CYj0plq37UERb+gJtsI
	 29RkBG+4M4vMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] printk: deprecate boot_delay in favour of
 printk_delay
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Murray" <amurray@thegoodpenguin.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260630-deprecate_boot_delay-v2-2-f9883d36aa4b@thegoodpenguin.co.uk>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-2-f9883d36aa4b@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 16:49:12 +0000
Message-Id: <20260630164912.973F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Sysctl handler `proc_dointvec_minmax` is incorrectly used for an `u=
nsigned int` variable.
- [Low] Passing an incompatible pointer type (`unsigned int *`) to `get_opt=
ion()`, which expects an `int *`.
--

commit 75c913a5c205c791c2728e8990c05d9b6634f1b5
Author: Andrew Murray <amurray@thegoodpenguin.co.uk>

printk: deprecate boot_delay in favour of printk_delay

This commit deprecates the boot_delay kernel parameter in favor of
printk_delay. It extends printk_delay to be configurable via an early
kernel parameter, allowing it to function during both boot and runtime.
The delay is now skipped when messages are suppressed across all system
states.

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 77f53eaed1321..cc203327247aa 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c

[ ... ]

> @@ -1339,11 +1327,34 @@ static void boot_delay_msec(int level)
>  	}
>  }
>  #else
> -static inline void boot_delay_msec(int level)
> +static inline void __init printk_delay_calculate(void)
>  {
>  }
> =20
> +static inline void early_boot_delay_msec(void)
>  {
>  }
>  #endif
> =20
> +static int __init printk_delay_setup(char *str)
> +{
> +	get_option(&str, &printk_delay_msec);

[Severity: Low]
Does this pointer sign mismatch introduce a build regression?

The get_option() function expects an int * for its second argument, but
printk_delay_msec was changed to an unsigned int in this patch. This trigge=
rs
a -Wincompatible-pointer-types warning, which is often treated as an error =
by
modern compilers.

[ ... ]

> @@ -2117,20 +2128,30 @@ static u8 *__printk_recursion_counter(void)
>  		local_irq_restore(flags);		\
>  	} while (0)
> =20
> -int printk_delay_msec __read_mostly;
> +unsigned int printk_delay_msec __read_mostly;

[Severity: Low]
Is the sysctl handler for printk_delay_msec still correct?

In kernel/printk/sysctl.c, the sysctl entry for printk_delay_msec uses
the proc_dointvec_minmax handler, which expects a pointer to a signed int.
Since printk_delay_msec is now an unsigned int, should this be updated to
proc_douintvec_minmax to prevent an API regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-deprecate_=
boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk?part=3D2
