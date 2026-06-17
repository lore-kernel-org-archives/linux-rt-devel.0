Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC1C3AFCFA;
	Wed, 17 Jun 2026 07:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680114; cv=none; b=HV2WZ86PlYqkCP+3ZarlNXR/wp0dgZFGOz1rA86ddqXN5OQXyZxwPxXiCBWv4w9Odmwv93t+rECo8iXOdR26gtmQ0vcAxVQe+mzLk0IgJOq8gU0N9w1UJ3vfeZXhNO5Ijtd3myM2n2mZK7lQP8lEesMrqzS/aE2sI1QKpM4X7dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680114; c=relaxed/simple;
	bh=qX0SI4SIXNmLzGD4dL4qJy4VbM9q+k0WVRywz9z4o70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YY/duuLSbbOXdU66yC1j+fcWGC7f38IgB/RQO4M78oAB4SD98aivoj8pGE7v02Y07uUTuSQaP2VYjDd7ODizGatLPEZennqIiQyd8jsA31PSGzhSez/8A8jmeIiQrYVDSaBAKFYwUmjOc7XpkWbVUac/f6jAk0n2uIHyhr2IDGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=He1dMbup; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="He1dMbup"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF301F000E9;
	Wed, 17 Jun 2026 07:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781680113;
	bh=xVvM5rK6L4jXwiPaJubLEbgXSNjgj7id/jLNs3I9zxc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=He1dMbupUrNKz5kCAlXY4oCCd6Uk7V2dhyYeSZrfiV8s5SKHDpyEMk2munyX4gsLV
	 /NwxhWQKnisXKIGPem0ahgwn4QxEuRq6LSOkluDhgM0Ar146ayDVHezdIeD1MiY4V7
	 tts73QMFHrlpl+RpXAOtAV8GXBSrqVqWMTuUjhp7pX9/QF41DTLSdtU0fUZEd5otst
	 K8+ti29OLZ87047ZOWs+TGZ05oYhD3nhdqWRoi/IjII9kHP8HiguVeeEMk4HvSF/bI
	 hRdbB4sIFdknyhs6qbrDgsIqL3Lk1zMbWd0BYrb0VjtJ6a0VfTYSy0SzukOoBgVq1Z
	 3wxT/yAz0loZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/10] mailbox: imx: Don't force-thread the primary
 handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: Frank.Li@kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260617-imx_mbox_rproc-v3-9-77948112defc@linutronix.de>
References: <20260617-imx_mbox_rproc-v3-0-77948112defc@linutronix.de>
 <20260617-imx_mbox_rproc-v3-9-77948112defc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:08:32 +0000
Message-Id: <20260617070833.1AF301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of `pm_runtime_get_sync()` is ignored in `imx_mu_=
startup()`, risking unclocked register accesses and PM reference leaks.
--

commit 14f99570339a0f5e4729690bf8d39e0fdeb47ac3
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

mailbox: imx: Don't force-thread the primary handler

This commit optimizes the i.MX mailbox driver by converting the
xcr_lock to a raw_spinlock_t and marking the primary interrupt handler
with IRQF_NO_THREAD. This prevents the primary handler from being
force-threaded, allowing it to run in hardirq context even on PREEMPT_RT.

> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c

[ ... ]

> @@ -640,7 +635,7 @@ static int imx_mu_startup(struct mbox_chan *chan)
>  {
>  	struct imx_mu_priv *priv =3D to_imx_mu_priv(chan->mbox);
>  	struct imx_mu_con_priv *cp =3D chan->con_priv;
> -	unsigned long irq_flag =3D 0;
> +	unsigned long irq_flag =3D IRQF_NO_THREAD;
>  	int ret;
> =20
>  	pm_runtime_get_sync(priv->dev);

[Severity: High]
This isn't a bug introduced by this patch, but should the return value of
pm_runtime_get_sync() be checked here?

If the device fails to resume (e.g., the PM domain fails to power on),
pm_runtime_get_sync() returns a negative error code but leaves the PM
usage counter incremented. Because the return value goes unchecked, the
driver might incorrectly assume the hardware is ready and proceed to call
hardware access functions like imx_mu_xcr_rmw() during startup.

Accessing unclocked or unpowered registers on i.MX devices can cause an
asynchronous external abort (bus fault), leading to a system crash. Could
this be updated to use pm_runtime_resume_and_get() instead, allowing the
driver to safely abort the startup on failure?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-imx_mbox_r=
proc-v3-0-77948112defc@linutronix.de?part=3D9
