Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A72F1FE471;
	Sun, 19 Jul 2026 07:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784444696; cv=none; b=FP2rsSH163CVSga5bU2PEdLpIlShIsNYwXlCy5fxoRsghv37ltgq1ojFmZWRTp1hXXVGathHQBlFYa7q0zWxU6P0UtnKLgI+rfuH7+s4gDsWCU7n352SNPoV5CgXbxWjtLQVKkcZxcEKMozm0z+yuPYauM2X5zTs5J4/iGzZfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784444696; c=relaxed/simple;
	bh=0Fgv+qn/YVx64ihJe+s5AdQ68LAo8xwx+9PKzdtih3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TJguSop/GR8inqgHYTQtgruc1y01LxukxrUaaXzUCZCPEsQOYwp8cLF+8CqQGi4Ot/cV3D6haI5oL3wytZMsbyo3UQmkVSCjRN6nAFaz9GcjoyifNxzSfwlsqK0U2RkpmADSRnhZB8h9Ee6bWeaNGnRpFWz57nJAS9vX+zBdBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbUzP8Ul; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbUzP8Ul"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FA21F000E9;
	Sun, 19 Jul 2026 07:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784444695;
	bh=D1z0rz0DMEFcUu4I2/K7QRyOsus/S8erT51DuqL9lWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VbUzP8Uln+dAY0D+9UjomACjLZ7vzYlegsabMAf3x82LA4Mff2bR22CSY4N/V7tak
	 kuIn9zuuveQc88Ph1M8RlPYN4P0teXAnAnAZXtBzqvl2P9ESTJ9OlsFwB2Y5WV5c1s
	 oqwDmGRh/Ivbtb5Jh3ugtBlkDto7Rs2hh3v47USfz/4Q6w5iUF5Hf02X1la4pkUOiS
	 SXj6hybrCPCqmixcZPoe4j+isoagvh9RfzDa34KRxkeGWLV2KHh+kMhbEOvwRtKiRN
	 icHgrwg1yzPeYEot01y8jdnlvn2kpdT1IpGIaParjRUh2ZuJ+ixgEDAAyNfbUcXMMM
	 WJXpfYu99XELg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] serial: amba-pl011: unprepare console clock on
 unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260719063502.18852-2-kmehltretter@gmail.com>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
 <20260719063502.18852-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 19 Jul 2026 07:04:54 +0000
Message-Id: <20260719070454.D6FA21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing NULL check for `uap` in console callbacks leads to kernel =
panic if `uart_add_one_port` fails.
--

--- Patch [1]: [PATCH 1/2] serial: amba-pl011: unprepare console clock on u=
nregister ---
commit 7c5636c95e763ddaf7574887aeb1e24ce1d44fec
Author: Karl Mehltretter <kmehltretter@gmail.com>

serial: amba-pl011: unprepare console clock on unregister

This patch adds a console .exit() callback that calls clk_unprepare() on the
UART clock when the console is unregistered. This balances the clk_prepare()
called in pl011_console_setup().

> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl=
011.c
> index 8ed91e1da22be..1aa43994a3cdc 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -2552,6 +2552,15 @@ static int pl011_console_setup(struct console *co,=
 char *options)
>  	return uart_set_options(&uap->port, co, baud, parity, bits, flow);
>  }
> =20
> +static int pl011_console_exit(struct console *co)
> +{
> +	struct uart_amba_port *uap =3D amba_ports[co->index];
> +

[Severity: High]
This is a pre-existing issue, but does uap need a NULL check here to
prevent a kernel panic on error paths?

If uart_add_one_port() fails internally (e.g., an allocation failure in
serial_core_add_one_port() returning -ENOMEM), it returns an error but
crucially fails to unregister the console that was already registered
earlier in uart_configure_port().

The caller sees the error and clears the pointer:

drivers/tty/serial/amba-pl011.c:pl011_register_port() {
    ...
    ret =3D uart_add_one_port(&amba_reg, &uap->port);
    if (ret)
        pl011_unregister_port(uap);
    ...
}

Because pl011_unregister_port() clears amba_ports[co->index] to NULL, but
the console remains active in the system's console list, will
unconditionally dereferencing uap here (and in pl011_console_write_atomic)
cause a crash when invoked?

> +	clk_unprepare(uap->clk);
> +
> +	return 0;
> +}
> +

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719063502.1885=
2-1-kmehltretter@gmail.com?part=3D1
