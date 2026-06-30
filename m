Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6049C233957;
	Tue, 30 Jun 2026 17:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782839344; cv=none; b=tfkVbW81HZKsnnHPGzY2M9YlWS/LQeUCyebEq2gasz2gup9Pf6A0D8JEbj1FUp1U1FhfYNCLSkxlCl/JJigym6L0hzCdKbnHaaXnAo4aVaSoatL127KOUmSAh3KhACfVD3r72w4urKrfDUy9uWh6GFvo8tQGFOnKGArPwojFRvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782839344; c=relaxed/simple;
	bh=1eBPPtu860A+oHcMSB4SXSw/BoJdGvl82wT4BAM9eHw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hGfyJZrM8UfcPcQYmEL+vSXLGhSho8Kirp8N//+TolBVTUtEV2oxCxzOnD1QiK43AW+Lm752eaZ9wl9u2F/Kng7y1mPD44n0F4FdrdomA9FuFF4ZLZwSg8yauBeizldhsdI+ZVoZIOSd+NUS1TE7Na4EHwutUohyfiWNub7XrpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbgWdOC7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbgWdOC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099D61F000E9;
	Tue, 30 Jun 2026 17:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782839343;
	bh=nw//PIlTtY1Pvq4jNYfhSyf74UWv2Ho2ELE1cxzsq1I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UbgWdOC7NjJWoqeikjPJrObEmSk6x9xMNxYx/WRhoI1LGb77lZtTZ0YnIRq3LoJZr
	 t2VdhclS8XAuU/kIhuoOQpmjz1xVIWsNBbx82icfALa1KAsJZ/A3dSSnrZd9qVlEju
	 LMLpYq21lnUUgj52hG16VNrLntqLOrRPFwGfN9kT1q+zcvmpyQxSOpA0utsdh78tWd
	 K9ho+S7c9rPWGeZTzNDYcyPGE1K8USmJiIbz2l6XuS3YLn3AuhfZSlNQRjn+PPKlDo
	 dgoufsdCb98eXFG1L0qz+05p2PMEY6qKkhhJMwOfoIol+PfMmnRp6tAJkycTQhsPbi
	 qc5FJe7dVK+iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] printk: nbcon: move printk_delay to console
 emiting code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrew Murray" <amurray@thegoodpenguin.co.uk>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
References: <20260630-deprecate_boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk>
 <20260630-deprecate_boot_delay-v2-3-f9883d36aa4b@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 17:09:02 +0000
Message-Id: <20260630170903.099D61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] `printk_delay(use_atomic)` causes massive IRQ latency by busy-wait=
ing with local interrupts disabled in `nbcon_legacy_emit_next_record()`.
- [Medium] `printk_delay()` bypasses its intended rate-limiting function wh=
en a console lock handover occurs in `console_emit_next_record()`.
- [Medium] Moving `printk_delay()` into the console flush loops incorrectly=
 multiplies the delay by the number of active consoles.

Pre-existing issues:
- [Critical] Use-after-free of the `con` pointer in `console_flush_all()` d=
ue to an expanded race window when `printk_delay()` is called.
--

commit e90407202970d9d83dc93dd60ca58eb802e88311
Author: Andrew Murray <amurray@thegoodpenguin.co.uk>

printk: nbcon: move printk_delay to console emiting code

This commit moves the printk delay from the caller of printk to the
console emitting code. This ensures delays are observed even when
messages are emitted asynchronously to the console.

> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c

[ ... ]

> @@ -1525,6 +1532,8 @@ bool nbcon_legacy_emit_next_record(struct console *=
con, bool *handover,
>  	}
> =20
>  	progress =3D nbcon_emit_one(&wctxt, use_atomic);
> +	if (progress && wctxt.emitted)
> +		printk_delay(use_atomic);

[Severity: High]
Does calling printk_delay() here cause massive IRQ latency?

In nbcon_legacy_emit_next_record(), when use_atomic is true, local
interrupts are explicitly disabled via printk_safe_enter_irqsave() just
before this block:

	if (use_atomic) {
		printk_safe_enter_irqsave(flags);
		console_lock_spinning_enable();
		stop_critical_timings();
	}

Calling printk_delay(use_atomic) while IRQs are disabled will execute
late_boot_delay_msec() which busy-loops.

Could this stall the CPU with interrupts disabled for hundreds of
milliseconds per message, potentially dropping hardware interrupts or
triggering the NMI watchdog?

>  	if (use_atomic) {
>  		start_critical_timings();

[ ... ]

> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c

[ ... ]

> @@ -3211,6 +3208,8 @@ static bool console_emit_next_record(struct console=
 *con, bool *handover, int co
>  		*handover =3D console_lock_spinning_disable_and_check(cookie);
>  		printk_safe_exit_irqrestore(flags);
>  	}
> +	printk_delay(true);
> +

[Severity: Critical]
This isn't a bug introduced by this patch, but does the expanded delay
create a use-after-free window for the con pointer in console_flush_all()?

In console_emit_next_record(), if a lock handover occurs,
console_lock_spinning_disable_and_check() releases the SRCU read lock.
This patch inserts printk_delay(true) immediately after this lock release,
adding a multi-millisecond busy-wait delay.

During this expanded window, another CPU can unregister and free the console
because the SRCU lock is no longer held.

When console_emit_next_record() returns to console_flush_all(), it
unconditionally dereferences con->seq before checking if a handover occurre=
d:

		if (!console_emit_next_record(con, &handover, cookie))
			continue;
		printk_seq =3D con->seq;

Could this massive delay guarantee a use-after-free if a console is
unregistered under contention?

[Severity: Medium]
Also regarding this delay placement, if a console lock handover occurs,
is the intended rate limiting bypassed?

When multiple CPUs attempt to print, console_lock_spinning_disable_and_chec=
k()
yields the lock to a waiting CPU before the delay begins.

The waiting CPU will immediately acquire the lock and begin printing the ne=
xt
message without waiting for the first CPU's delay to finish.

Does this result in messages being emitted in an immediate burst under lock
contention, bypassing the intended pacing?

[Severity: Medium]
Additionally, does moving printk_delay() here multiply the delay by the
number of active consoles?

Previously, vprintk_emit() called printk_delay() once per message.

Because console_emit_next_record() is called sequentially for each register=
ed
console within the for_each_console_srcu(con) loop in console_flush_all():

	for_each_console_srcu(con) {
		...
		if (!console_emit_next_record(con, &handover, cookie))
			continue;
		...
	}

Will the delay now be executed N times per message, where N is the number of
active consoles?

>  skip:
>  	return true;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630-deprecate_=
boot_delay-v2-0-f9883d36aa4b@thegoodpenguin.co.uk?part=3D3
