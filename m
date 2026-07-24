Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFF93C5837;
	Fri, 24 Jul 2026 21:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930151; cv=none; b=CkajbV/aUZXwjcMTK/FMQl2/nf9DYyY12aDE3emEhtrJ9hxL/aJ+7yiVUUD3hVwN9ZP13smxFxXcyo/i/tFrv0qcC6Fzsr3up7oEwcPqNI1Cw6n+gvXWpP+PmkjEWIno2zLPLHcYPSfsJ2iINa++xazaTlk2D3taWHLfvjplJOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930151; c=relaxed/simple;
	bh=iEWt1hrle9o8HZT6Lw0fHDuohR/cfqEIeNMoNJsZ2jo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vop2MvsGr2tmE0Koz8YsKJSlAr2djLBMGRQPNNVcTREhl+1zA3fVgUFj1lCtiTM4mVqxR59lrpRjs1pMcq59j+DYYU+96sdeMxyZLAuZarIeNn6wty/Q1+dTtg0i2eVQmS5BsaIvVrNYYTGbPNsuBy5Cg9BHlsdwzzDGQnUe2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNsj53h5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNsj53h5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CAC1F000E9;
	Fri, 24 Jul 2026 21:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784930148;
	bh=Gmm31eDzh6RP7MXtrU+pmUKWb1LRgyOTtVYTCddrmE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gNsj53h5BRlRfJB36csk8oWrur63QGAtObC8ij8hN/8VTiSPqvMPYmn5HWcYfuzbc
	 GtFYzyRsqMPm/CYn9OYtwT0+oCPhzNtyLZ5xxLf5FHNkRHCnKNfYDH2ZEw5A598AsG
	 yl0nqiW3HgwKI3deZAbEUc7ywcAEyUCUAmZXmEcfIB908D+ICYfgIe06YnsWi8uEhJ
	 o259X+CSBkB6m8/1Ura6wTQaPc7mQlefYrsha4WsWI+JZ3nGS8Pw7qfo0boz7ptxr7
	 CXBpmRju1DbY5iDIJ09QWL5B9vOf7v/VH60qjJXVp//5T58oAeQD/VdMaxmv8YQSU9
	 KIdHR4iprVYoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] serial: amba-pl011: unprepare console clock on
 unregister
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260724213348.77418-2-kmehltretter@gmail.com>
References: <20260724213348.77418-1-kmehltretter@gmail.com>
 <20260724213348.77418-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 21:55:47 +0000
Message-Id: <20260724215548.54CAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing NULL check for `uap` in `pl011_console_exit()` can lead to=
 a NULL pointer dereference.
--

--- Patch [1]: [PATCH v2 1/2] serial: amba-pl011: unprepare console clock o=
n unregister ---
commit 52f009641a6d04998b843ae51d6c555711f29559
Author: Karl Mehltretter <kmehltretter@gmail.com>

serial: amba-pl011: unprepare console clock on unregister

This commit adds a console .exit() callback to balance the clock prepare
count. It ensures that the UART clock is unprepared when the console is
unregistered, preventing stale reference leaks.

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
> +	clk_unprepare(uap->clk);

[Severity: High]
Is it possible for uap to be NULL here in pl011_console_exit() within
drivers/tty/serial/amba-pl011.c?

During device probe, uart_add_one_port() registers the console via
uart_configure_port(). If a subsequent operation in
serial_core_add_one_port() fails (for example, allocating uport->tty_groups
returns -ENOMEM), the error path returns the error but does not unregister
the console.

The driver then cleans up by calling pl011_unregister_port(), which clears
the amba_ports array entry by setting amba_ports[co->index] =3D NULL.

The console remains globally registered. If this console is eventually
unregistered (such as when displaced by a preferred console or via sysfs
unbind), pl011_console_exit() is invoked. It unconditionally assigns uap
and dereferences it, leading to a kernel panic. Other console callbacks like
pl011_console_setup() correctly check for a NULL uap before proceeding.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724213348.7741=
8-1-kmehltretter@gmail.com?part=3D1
