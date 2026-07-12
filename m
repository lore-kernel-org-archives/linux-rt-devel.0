Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD586334;
	Sun, 12 Jul 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783852293; cv=none; b=DeJRaFqLiq79EzTF7FHwvIK9qI4lswX7+LqubDJhKmX7/Zdh5YT2Pv80dU0VsuE4RazffNeJMMce2/D3JNB+zmU+waddaAs4gB2/o0hMZig6G9qEmlvJ6Zcqj7/G0ifLtbWagA0r+jOVuBwcCuZvGZEISAHdiP0aj2vvAfvXMnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783852293; c=relaxed/simple;
	bh=idd89ZuuOTrreRoN7U7Q7rAjF3s5mCTqAovGqOLo8O4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ks5DYg8E5GFBSE1O7uupMf9FaG3/1w8x+wVejE83lOFyQAUstwfRwNppnRIAP6vklVarBSUxIKbWZ6izGQloAtRJMqLa32vIf5EqozVdULjmyU9Vy/6NUiwwPNR6KEfPxMmRL35UJe5Xi91iaU47omgK9mW/Jd4AoOF5Xy9iEVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ax0t7iSv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ax0t7iSv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2502A1F000E9;
	Sun, 12 Jul 2026 10:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783852292;
	bh=HUu6RPld1p4CaZ1+dgT1hPHL6XGwHG+5Bez7ciwymgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ax0t7iSv4ZW4gTVZ6FZZsw7udZkjnCVQyB0A75m1RKfZTWQBPGuZPvoOwmEz+xGH8
	 IBCE0qRww1lfuWPwxy+Njy4j1b3vUeKU5j56rlWzomY0Cl43J7OW+MfwVY14wTr22G
	 +vh8IH1zxaZJdiP5MFnKXZHD63mxunB7V6itBjDU0lEkjSMCbASnHPXuMi3suaihJg
	 4BRA3SKaJ/gBtbe4xAuXTY/Rl2S2gHPs7aGFmc/htFc9YvVo0a+UKrqnVWY2kzmfhm
	 RgVhTTgssA3jobVHi2dfdZtM+CEmVGdkTvRdiqfxkJZQcxYqXyikDpA7Ah8+0Syr9I
	 Ld4toYb1KUl2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/6] printk: nbcon: move printk_delay to console
 emiting code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Murray" <amurray@thegoodpenguin.co.uk>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260712-printkcleanup-v3-5-574547b8f71b@thegoodpenguin.co.uk>
References: <20260712-printkcleanup-v3-0-574547b8f71b@thegoodpenguin.co.uk>
 <20260712-printkcleanup-v3-5-574547b8f71b@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 10:31:31 +0000
Message-Id: <20260712103132.2502A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] printk_delay(true) busy-waits with IRQs disabled inside the consol=
e lock spinning critical section, causing cross-CPU hard lockups.
- [High] Per-message delays inside the flush loop hold console_sem and SRCU=
 read lock hostage, severely blocking the console subsystem.
--

--- Patch [5]: [PATCH v3 5/6] printk: nbcon: move printk_delay to console e=
miting code ---
commit 34b9c50abab2d207953ba74a453cbbd56801857d
Author: Andrew Murray <amurray@thegoodpenguin.co.uk>

printk: nbcon: move printk_delay to console emiting code

This commit moves the printk_delay logic from the printk() calling context
into the console emitting code. The goal is to ensure that asynchronous
console emission respects the delay without stalling the original caller.

> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 4b03b019cd5ee..c8427906b1c54 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
[ ... ]
> @@ -1525,6 +1532,8 @@ bool nbcon_legacy_emit_next_record(struct console *=
con, bool *handover,
>  	}
> =20
>  	progress =3D nbcon_emit_one(&wctxt, use_atomic);
> +	if (progress && ctxt->emitted)
> +		printk_delay(use_atomic);

[Severity: High]
Does this code hold console_sem and SRCU read lock hostage for the duration
of the delay?

If a user configures a non-zero printk_delay_msec, when legacy consoles are
flushed, the thread holds console_sem and console_srcu_read_lock(). Inside
the loop, the delay is now applied per-record while holding global locks.

A burst of messages will multiply the delay, holding console_sem hostage for
an extended period, which blocks TTY operations, CPU hotplug, module loadin=
g,
and suspend/resume which attempt to acquire console_lock().

Prior to this patch, the delay was isolated in vprintk_emit() before any
locks were taken.

> =20
>  	if (use_atomic) {
>  		start_critical_timings();
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 4517266e9ca11..5df09e56cf8ab 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
[ ... ]
> @@ -3206,6 +3205,7 @@ static bool console_emit_next_record(struct console=
 *con, bool *handover, int co
>  		printk_legacy_allow_spinlock_enter();
>  		con->write(con, outbuf, pmsg.outbuf_len);
>  		printk_legacy_allow_spinlock_exit();
> +		printk_delay(true);
> =20
>  		start_critical_timings();
> =20
> @@ -3214,6 +3214,7 @@ static bool console_emit_next_record(struct console=
 *con, bool *handover, int co
>  		*handover =3D console_lock_spinning_disable_and_check(cookie);
>  		printk_safe_exit_irqrestore(flags);
>  	}

[Severity: High]
Can this busy-wait cause a cross-CPU hard lockup?

When printk_delay(true) executes, it uses an mdelay() loop while the CPU
holds the console owner state, console lock spinning is enabled, and local
interrupts are disabled (via printk_safe_enter_irqsave()).

If another CPU concurrently calls printk(), it enters
console_trylock_spinning() and spins indefinitely with its own interrupts
disabled, waiting for the first CPU to release the spinning lock.

Since the spinning CPU does not call touch_nmi_watchdog(), it will hard
lockup while waiting for the owner's mdelay() loop to finish for each
pending message.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712-printkclea=
nup-v3-0-574547b8f71b@thegoodpenguin.co.uk?part=3D5
