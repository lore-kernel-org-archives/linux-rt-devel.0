Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD9B3C8196;
	Mon, 20 Jul 2026 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535242; cv=none; b=Q6HvijmyQCJKMwWtUqzJPszY7t98mplm+dWuL2yzVn1ZDparW+JSyFua4MIVppaUU/oxJWdH9Q7R1AVWJhMc/6ozDjkT3oYsXYFC4koRsNs8cceEqop2orN6cVcV9sA/Tr47kJ+Rz7utLO9iYJx95Myx/OEg/uyzYwSznVhQVPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535242; c=relaxed/simple;
	bh=6mNhg2L6Fzr5sI+qzEFiXGQ8eLWeQjI5AUGbKFSaVoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kERdtlGBgAddObHGggkck+8VFIuYn4gKlm22uutDD4ySC5qA5dfi+J/lBZl5g0TZ5weqhPgHxOPXjwsb893JiICN6jUt4INfbmRyJapEx/h+I0IPLg6sbls7+Ag/SqC5q4yQyBqS3ScIMLvs6BWaADgkU4ScH3SIIpvzJIwxOjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KMZFnXbu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VyOrT0D2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KMZFnXbu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VyOrT0D2"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784535238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3TCmEF1MdOub2Cj/08kORjw9H8KFt4ZHxdgW7TKjLA=;
	b=KMZFnXbuZhLRV+UaBQaRGT+mwXvwq3+Zz39zb7rZLMcnaRITpm0sjhRxckH93KyIGpkWpJ
	4jEvtdsrhS9n967AeE0g+9WAPReM79AF6deLxmH1Phmuvut5ebVp9Mf6ktZGhOdNnLKg5g
	SAwsAXAF9TBiAmPj0pAcoVujAA0Isi+mlQmpmTy6taZb7tbZrW19luJGkFfafN411fie0Z
	tViU2v1szzPCfaud9w6jJE9AlqVphFaUI3RNZv6z01ySBuZre3dAlJWKKInbyAkbTYAvo3
	sZRlXuu/YWONwno81q53GU4svTkR1hLi+tfjCabojM0W4v0h6k/H+TRIw2SQcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784535238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3TCmEF1MdOub2Cj/08kORjw9H8KFt4ZHxdgW7TKjLA=;
	b=VyOrT0D2AHafnANbR8xCg0VqaVLv3x9+3WWEHvde4qMFpBkgWb88hvKSMUxGaiT/43kbzs
	Jh4d4sZnjG+HKDAw==
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 sashiko-reviews@lists.linux.dev, Petr Mladek <pmladek@suse.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 2/2] serial: amba-pl011: keep console clock enabled for
 atomic writes
In-Reply-To: <20260720080100.Mk9zZFql@linutronix.de>
References: <20260719063502.18852-1-kmehltretter@gmail.com>
 <20260719063502.18852-3-kmehltretter@gmail.com>
 <20260719065214.A40521F000E9@smtp.kernel.org>
 <20260720080100.Mk9zZFql@linutronix.de>
Date: Mon, 20 Jul 2026 10:19:58 +0206
Message-ID: <8733xeaxix.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2026-07-20, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> On 2026-07-19 06:52:14 [+0000], sashiko-bot@kernel.org wrote:
>> > diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba=
-pl011.c
>> > index 1aa43994a3cdc..4facd1b350d5d 100644
>> > --- a/drivers/tty/serial/amba-pl011.c
>> > +++ b/drivers/tty/serial/amba-pl011.c
>> > @@ -2523,7 +2523,11 @@ static int pl011_console_setup(struct console *=
co, char *options)
>> >  	/* Allow pins to be muxed in and configured */
>> >  	pinctrl_pm_select_default_state(uap->port.dev);
>> >=20=20
>> > -	ret =3D clk_prepare(uap->clk);
>> > +	/*
>> > +	 * Keep the clock enabled while registered because write_atomic() may
>> > +	 * run in NMI context and must not acquire the clock framework lock.
>> > +	 */
>> > +	ret =3D clk_prepare_enable(uap->clk);
>>=20
>> [Severity: High]
>> Will this keep the UART clock unconditionally enabled during system susp=
end?
>>=20
>> Because the persistent clock reference is acquired here during console
>> registration and only dropped on console exit in pl011_console_exit(), t=
he
>> reference remains active.
>>=20
>> During system suspend, pl011_suspend() delegates to uart_suspend_port() =
but
>> fails to drop this console's persistent clock enable reference. This mig=
ht
>> prevent the SoC from turning off the clock tree or parent PLLs, preventi=
ng
>> deep system sleep.
>
> The comment somehow makes sense. What is the general advice here? If we
> drop the clock during suspend and acquire it again during resume we need
> to keep track and ignore all prints in between. Is the printk core
> taking care of this?

This is what the suspend/resume pm callbacks are for. In this case, it
is pl011_suspend() and pl011_resume().

> There is also this no_console_suspend argument=E2=80=A6

Yes, the callbacks need to check @console_suspend_enabled. If false, the
clocks obviously must not be disabled.

John Ogness
