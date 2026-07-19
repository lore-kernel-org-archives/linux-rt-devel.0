Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276162F12A1;
	Sun, 19 Jul 2026 06:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784443936; cv=none; b=avcfNv6bYU3SG5bfj1KMSkZztclwQ2pclIGx89eetYLzGmm7hOR0AXwl0H/sSrVZi7vn+6CtftToeQNq6Rn5baHJFa8VQH4SgmYSPMeMH27xPprCy7o+3P7VKuBt+YCfZ+No/DnpdPa0VuZpJ3b0tZClGLgglKhoP6E81UpxXGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784443936; c=relaxed/simple;
	bh=k6379KmZkQlWFzv1UjZHG4kQ6hm9ko6WFDo30IZ5pbk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YFhbSebjrqxMPpanki7LFN1z3U9DpLvqREWUGHtYS6Ez09VY0MV7Fe2R46Y4ZKo7dxat5Ri5QpUeOckmuCrt8tRXMq6PLctPv99XsOEVjWiuzprF5mcGRhHQ6zZDPsqBYKqmM4uwPhY8fw3E7GBzarVB8uBqhWDWjtRja9pA0eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3k506qo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3k506qo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40521F000E9;
	Sun, 19 Jul 2026 06:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784443934;
	bh=+HojYlK/7snqth9DA3tPX6BkfwOG2+vw3ZsUCgD3Gd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q3k506qoIfeRda96ds02noRJSp/L7d5sPFr1ul4GHNIypZFiaRZFYxq530RqLGYen
	 tmMf59p/Q1qghcRxSI0WQ/luSgElGJlwa53lRqD4AlAFz6/JJDozXOzpcfVVn8BVvI
	 nMK2OYYbIvXdc7+ynkvYju27hzurz3rQiFdvcxd0K+Lr6k+ahBLUzkhAPAJBK1vmRB
	 hcFYR2VcEOoPer8Gv/VTw77oPN1S6MB0rwJvu/8Tke1BDK60FjbUPge1PcfFxdsKT9
	 exmGt2D4tpYBaEB3EXEU59sR9EF1B1rjmNNa7WtZtleNhp3c2ib/f1jWtZ38ztvufe
	 8adglFCYHGYZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] serial: amba-pl011: keep console clock enabled for
 atomic writes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260719063502.18852-3-kmehltretter@gmail.com>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
 <20260719063502.18852-3-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 06:52:14 +0000
Message-Id: <20260719065214.A40521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The UART clock is kept unconditionally enabled during system suspe=
nd, potentially preventing deep system sleep.
--

--- Patch [2]: [PATCH 2/2] serial: amba-pl011: keep console clock enabled f=
or atomic writes ---
commit d187007d951bc1373a13bbdbd4ba5d6db47490d1
Author: Karl Mehltretter <kmehltretter@gmail.com>

serial: amba-pl011: keep console clock enabled for atomic writes

This commit fixes a sleeping-in-atomic bug under PREEMPT_RT by keeping the
console clock enabled while the console is registered. It moves the clock
enable from the atomic write path to console setup and exit.

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 1aa43994a3cdc..4facd1b350d5d 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2523,7 +2523,11 @@ static int pl011_console_setup(struct console *co,=
 char *options)
>  	/* Allow pins to be muxed in and configured */
>  	pinctrl_pm_select_default_state(uap->port.dev);
> =20
> -	ret =3D clk_prepare(uap->clk);
> +	/*
> +	 * Keep the clock enabled while registered because write_atomic() may
> +	 * run in NMI context and must not acquire the clock framework lock.
> +	 */
> +	ret =3D clk_prepare_enable(uap->clk);

[Severity: High]
Will this keep the UART clock unconditionally enabled during system suspend?

Because the persistent clock reference is acquired here during console
registration and only dropped on console exit in pl011_console_exit(), the
reference remains active.

During system suspend, pl011_suspend() delegates to uart_suspend_port() but
fails to drop this console's persistent clock enable reference. This might
prevent the SoC from turning off the clock tree or parent PLLs, preventing
deep system sleep.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719063502.1885=
2-1-kmehltretter@gmail.com?part=3D2
