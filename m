Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D7277818;
	Mon, 20 Jul 2026 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534465; cv=none; b=QbakPSWI5UMMY++CVD5/P9FPGwYpr7AOCZWFqvtsoM3esQU1dgL1hfNYcsgzXU8VTAmv62PPK+XMvOvmmQRKnvrQF4YFcCmSR74CweRM5A4dG4CjDaLC83OM9Y2TuDwS4LOgmjQ+7IqxQ1nqIYejxFAT25OM37Gy3y1ZXV8wfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534465; c=relaxed/simple;
	bh=051TGrhIvVFJx06mOlteug7bWLIhkb2Qiz/fQzJZkfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hCzg+a78KFo/12vuEAyMFFubmJhcvB7O2Ph697KKdR4LrrWclOWbLkHPUaN6ZtXskXVaYJUF2TrbokqkyQg/oUjXkQbUGuD0icAdJCwdYD3ug2RCw0AOTklsdtVUd0xdxM/hBtezVKvrg/AnSWc6BW90Y6VfRPeHm61aGQRg730=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GIlLwaCk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GB+tjk4L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GIlLwaCk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GB+tjk4L"
Date: Mon, 20 Jul 2026 10:01:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784534461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=paNfqt5pMqFOnxF8pIqP3NXE7U+Q4pDkq1wFgzo9PFE=;
	b=GIlLwaCkxqN5g4fd33UaH7CygskI3B2ZlJQkkbLmv5r+KDEInt3xUX+5ae5zB6PrwNoJu4
	STWmZjbpMALq5/xxrVOxjks8SuZiGO9im6v87MPHHDKEDvZtFBBbXdq4b+zm3BoefjeSoo
	nkq8axe7DuBRezD38wAL+Be67LB0O7u8GHaubkAqabJs5x7jXB76KO18pVcx6m4fgeUAhP
	xBuV6qEHacpM75NRUcHA6MflCQ0JeHN2YUdT8nvG/HWabJglwck6h3bKS4bfDvklTzXKlH
	4j2em1EyGFe/BuJrsPqUGeUIeBcst2jW164kDbVfcnXurSPTNaZOn0OLM4U6Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784534462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=paNfqt5pMqFOnxF8pIqP3NXE7U+Q4pDkq1wFgzo9PFE=;
	b=GB+tjk4LT4QddoKie0+Jppjb9fF3j449VrGfJaAMJC8rnZMrUDZkVgliAfACjk5UnYMBJp
	iDKAE15eE7fgbSDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: sashiko-reviews@lists.linux.dev,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 2/2] serial: amba-pl011: keep console clock enabled for
 atomic writes
Message-ID: <20260720080100.Mk9zZFql@linutronix.de>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
 <20260719063502.18852-3-kmehltretter@gmail.com>
 <20260719065214.A40521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260719065214.A40521F000E9@smtp.kernel.org>

On 2026-07-19 06:52:14 [+0000], sashiko-bot@kernel.org wrote:
> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-=
pl011.c
> > index 1aa43994a3cdc..4facd1b350d5d 100644
> > --- a/drivers/tty/serial/amba-pl011.c
> > +++ b/drivers/tty/serial/amba-pl011.c
> > @@ -2523,7 +2523,11 @@ static int pl011_console_setup(struct console *c=
o, char *options)
> >  	/* Allow pins to be muxed in and configured */
> >  	pinctrl_pm_select_default_state(uap->port.dev);
> > =20
> > -	ret =3D clk_prepare(uap->clk);
> > +	/*
> > +	 * Keep the clock enabled while registered because write_atomic() may
> > +	 * run in NMI context and must not acquire the clock framework lock.
> > +	 */
> > +	ret =3D clk_prepare_enable(uap->clk);
>=20
> [Severity: High]
> Will this keep the UART clock unconditionally enabled during system suspe=
nd?
>=20
> Because the persistent clock reference is acquired here during console
> registration and only dropped on console exit in pl011_console_exit(), the
> reference remains active.
>=20
> During system suspend, pl011_suspend() delegates to uart_suspend_port() b=
ut
> fails to drop this console's persistent clock enable reference. This might
> prevent the SoC from turning off the clock tree or parent PLLs, preventing
> deep system sleep.

The comment somehow makes sense. What is the general advice here? If we
drop the clock during suspend and acquire it again during resume we need
to keep track and ignore all prints in between. Is the pritnk core
taking care of this? There is also this no_console_suspend argument=E2=80=A6

Sebastian
