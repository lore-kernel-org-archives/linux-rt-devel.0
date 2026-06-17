Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAB926059D;
	Wed, 17 Jun 2026 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680098; cv=none; b=MsDhhLqGzr3cPQzwj9PKEcGctjQTybLiaw22nWv/sWm7P+A2NgOHH1OIMIhVezFg4YJcu/A3yXiEyI5DZR/LAtClmXlbG+GPsuFtL7B0pvgcFselIwWy3wdHYsU4b827zQ5GlhfwV49DnHTTbvvj9fQokNXcf/jb1bemVBZiydE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680098; c=relaxed/simple;
	bh=dw7e+AUkHHZQwcW9xQsECY++WgLEFFFtyfPdhNjCarM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DnGYHLc7Qx8KRSTNTIjMGqD8zorfEb9MOiS7vxBXq6HnrfsbmUCKjoyIcUmc2x2ry+qRKFgjTNqPjwV4U+EaD6MHI5L2pbpkzkLJCaeqZPz3321xvcAb4cXAayibCM2BMsLkCena4ax8O7zrzn9yB4K2I8JyR0xQO7Z+bd6NwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUeNWVS+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUeNWVS+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70241F000E9;
	Wed, 17 Jun 2026 07:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781680097;
	bh=OzArGnnq+UMZWk1aGt9CqWwQNqbCXS3jRfN/4P0krLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUeNWVS+iEaax1Gdkn/EVe6RurKuDy9MFWJBPT6KwrksO/QhTGGE6y+PIBFGZLjqx
	 SpCU78WAmO7w3Q7zR6CQT99l9XFXu/FEqWdKcjt+Pcrjfcp0XM1L1HsCzeQS6NUNhs
	 RnI4uvyjpe9XqSDY/5J4MGz7kDTUgcSaIEwWLSMcL0h4V/A98x8p54u3KSNoKjXf1a
	 gC8N92+BfPUrKB0Lr7hj1rxMvh4JiZECnYLuyxTwXTukhTmNUEPvqt6ITYVw6qR1LM
	 kgUHmjd9dfUWbGXNQyI9tGWwRFV8ppHc9viyLQrjo48KURREO+JM2Kk5YFaa/X9k9U
	 aOcU/i67HXxzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/10] mailbox: imx: Forward the timeout/ error in
 imx_mu_generic_tx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260617-imx_mbox_rproc-v3-1-77948112defc@linutronix.de>
References: <20260617-imx_mbox_rproc-v3-0-77948112defc@linutronix.de>
 <20260617-imx_mbox_rproc-v3-1-77948112defc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:08:16 +0000
Message-Id: <20260617070816.C70241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Returning a negative error code (-ETIMEDOUT) from the mailbox send=
_data callback wedges the TX queue permanently.

Pre-existing issues:
- [High] Using readl_poll_timeout() with a timeout inside an atomic section=
 creates up to 100ms of IRQ-disabled latency and is unsafe.
--

commit 00bd1a49fae92272b2f76397f788a118394fe7ae
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

mailbox: imx: Forward the timeout/ error in imx_mu_generic_tx()

This commit modifies imx_mu_generic_tx() to return the actual error code
(such as a timeout) instead of silently dropping it and returning 0. This
was intended to properly notify the caller of failures during the busy-wait
polling loop for TXDB_V2 channels.

> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 246a9a9e39520..0028073be4a71 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -227,6 +227,7 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
>  	u32 val;
>  	int ret, count;
> =20
> +	ret =3D 0;
>  	switch (cp->type) {

[ ... ]

> @@ -259,7 +260,7 @@ static int imx_mu_generic_tx(struct imx_mu_priv *priv,
>  		return -EINVAL;
>  	}
> =20
> -	return 0;
> +	return ret;

[Severity: High]
Does returning a negative error code here stall the TX queue?

The mailbox framework does not propagate errors from the send_data
callback back to the caller. Instead, it treats non-zero return values
as a sign the controller is temporarily busy:

    drivers/mailbox/mailbox.c:msg_submit() {
        ...
        err =3D chan->mbox->ops->send_data(chan, data);
        if (!err) {
            chan->active_req =3D data;
            chan->msg_count--;
        }
        ...
    }

Because this now returns -ETIMEDOUT, the framework skips dequeuing the
message (chan->msg_count is not decremented) and does not set
chan->active_req. Because err is non-zero, no retry timer is started.

The failed message remains at the head of the TX queue, blocking all
future messages. Subsequent calls to mbox_send_message() will repeatedly
attempt to send the exact same message.

[Severity: High]
This is a pre-existing issue, but does the busy-wait loop in this function
cause high latency with interrupts disabled?

When handling IMX_MU_TYPE_TXDB_V2, imx_mu_generic_tx() calls
readl_poll_timeout() with a 10ms timeout and retries up to 10 times.
However, the caller holds a spinlock with interrupts disabled:

    drivers/mailbox/mailbox.c:msg_submit() {
        scoped_guard(spinlock_irqsave, &chan->lock) {
            ...
            err =3D chan->mbox->ops->send_data(chan, data);
            ...
        }
    }

This can result in up to 100ms of busy-waiting with interrupts
disabled, which can trigger watchdogs.

Furthermore, readl_poll_timeout() relies on ktime_get(), which the kernel
documentation explicitly forbids using in atomic contexts if a timeout
is specified.

>  }
> =20
>  static int imx_mu_generic_rx(struct imx_mu_priv *priv,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-imx_mbox_r=
proc-v3-0-77948112defc@linutronix.de?part=3D1
