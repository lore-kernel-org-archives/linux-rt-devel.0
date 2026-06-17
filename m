Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4173B8D70;
	Wed, 17 Jun 2026 07:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680401; cv=none; b=XYN+aTchSEru9n6Uv9zkHbYGFTB/JOlIyjjoqeWt4qFAGyN0i3Plt4jqH6u9MIu90we6Xi+tllKqR28GZBIJd7vsBmbRaaBmzo1j4YERVAsKtibhSMJHBnmSz+hpelGjSrib/9Lpg5fkePO9vphrc9WlizV/W3pBJGB2e9s8roA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680401; c=relaxed/simple;
	bh=ON778G6QOwTURBQYP5AX9YcZfjC2ncTQQbLiry0xO6Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p8lV85GZvegB5l/Xq87vkWjlc4vaIaujFMW/IbcjE6MnAApuGP0SSjDA7ThGUVoudyPjxks6+jzS0TdFF7bB97J24y081JQb5TP1pLqIZOdY1Bic3gYgbpC1Gk5wQSn2soKY/iSQYeaFgVQsBjxPa9FazEODEJe6//2k6dSNJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=obcIQb7L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="obcIQb7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C61F1F000E9;
	Wed, 17 Jun 2026 07:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781680399;
	bh=2X2mkSL+oINuLow0nG3HWSFVaHHUT6NTGMc7kXTS2oo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=obcIQb7LCYoBcBJOfugoaVGJGy8tkawtMGDY5TcXUUmghncqsEFh2MrxTDAdizIM4
	 yFM1SDw3sj8wppr2Mamk7lMidRTzjwlVFmOM9uZ++uJAz9Df5cDvuGhorcWX/8Ot82
	 BFh3/z/7CCKhyFvP74B3DMOUuluTkcbsF02lyDs+NqmB+ObbcP8eRWoiApLaVWsnTa
	 4PTfX3wOoMf3CB/zQ2zQqioMAY6z4SgIJ4y1HbnJBoRWHYfRA1Nft01k+uK3127Z2I
	 2DgyruGl9MuSzHshqJD7HXV+3vEphz3KVvcr4F0ZfA63nSb0C15uKvGbngjfCNh7ew
	 RAnfe+26X0eZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/10] mailbox: imx: Use channel index instead of
 zero in imx_mu_specific_rx()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260617-imx_mbox_rproc-v3-5-77948112defc@linutronix.de>
References: <20260617-imx_mbox_rproc-v3-0-77948112defc@linutronix.de>
 <20260617-imx_mbox_rproc-v3-5-77948112defc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:13:19 +0000
Message-Id: <20260617071319.7C61F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe hardware polling inside atomic context leads to deadlocks.
- [High] Error paths in `imx_mu_specific_rx()` leave the RX interrupt perma=
nently masked.
- [High] Error paths in `imx_mu_seco_rxdb()` skip clearing GIP and leave th=
e RXDB interrupt permanently masked.
- [High] PM runtime usage counter leak in `imx_mu_startup()` error path.
--

commit ab09c59a56c0e6ea31b7f95dd9b506c460b17d31
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

mailbox: imx: Use channel index instead of zero in imx_mu_specific_rx()

imx_mu_specific_rx() masks channel 0 and unmasks it again at the end of
the function. Given that at startup the channel index got unmasked it
should do the right job.

> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index a8d4e970fb786..408cd083c64ee 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -381,7 +381,7 @@ static int imx_mu_specific_rx(struct imx_mu_priv *pri=
v, struct imx_mu_con_priv *
> =20
>  	data =3D (u32 *)priv->msg;
> =20
> -	imx_mu_xcr_rmw(priv, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(priv->dcfg->type, 0=
));
> +	imx_mu_xcr_rmw(priv, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(priv->dcfg->type, c=
p->idx));
>  	*data++ =3D imx_mu_read(priv, priv->dcfg->xRR);
> =20
>  	if (priv->dcfg->type & IMX_MU_V2_S4) {

[Severity: High]
This is a pre-existing issue, but the error paths in imx_mu_specific_rx() s=
kip
the corresponding unmask operation.

If size exceeds max_size / 4 or if readl_poll_timeout() times out:

drivers/mailbox/imx-mailbox.c:imx_mu_specific_rx() {
...
	if (size > max_size / 4) {
		dev_err(priv->dev, "Maximal message size (%u bytes) exceeded on RX; got: =
%i bytes\n", max_size, size << 2);
		return -EINVAL;
	}
...
	for (i =3D 1; i < size; i++) {
		ret =3D readl_poll_timeout(...);
		if (ret) {
			dev_err(priv->dev, "timeout read idx %d\n", i);
			return ret;
		}
...
}

Does returning an error here skip unmasking the RIEn interrupt?

In the threaded IRQ handler imx_mu_isr_th(), the unmask is only performed if
this function returns 0. Could this leave the RX interrupt permanently mask=
ed
and cause a denial of service for the channel?

[ ... ]

> @@ -408,7 +408,7 @@ static int imx_mu_specific_rx(struct imx_mu_priv *pri=
v, struct imx_mu_con_priv *
>  		*data++ =3D imx_mu_read(priv, priv->dcfg->xRR + (i % num_rr) * 4);
>  	}
> =20
> -	imx_mu_xcr_set_act(priv, cp, IMX_MU_RCR, IMX_MU_xCR_RIEn(priv->dcfg->ty=
pe, 0));
> +	imx_mu_xcr_set_act(priv, cp, IMX_MU_RCR, IMX_MU_xCR_RIEn(priv->dcfg->ty=
pe, cp->idx));
>  	mbox_chan_received_data(cp->chan, (void *)priv->msg);
> =20
>  	return 0;

[Severity: High]
This isn't a bug introduced by this patch, but are there unsafe hardware po=
lling
loops inside atomic contexts elsewhere in this file?

The imx_mu_send_data() callback executes in atomic context (with chan->lock=
 held
and interrupts disabled), but the underlying TX functions wait using mechan=
isms
that are unsafe in atomic context.

For example, imx_mu_tx_waiting_write():

drivers/mailbox/imx-mailbox.c:imx_mu_tx_waiting_write() {
...
	} while (!can_write && time_is_after_jiffies64(timeout_time));
...
}

There are also readl_poll_timeout() calls in imx_mu_generic_tx() and
imx_mu_specific_tx():

drivers/mailbox/imx-mailbox.c:imx_mu_specific_tx() {
...
		ret =3D readl_poll_timeout(priv->base + priv->dcfg->xSR[IMX_MU_TSR], xsr,=
 xsr & IMX_MU_xSR_TEn(priv->dcfg->type, i % num_tr), 0, 5 * USEC_PER_SEC);
...
}

Can polling jiffies or using readl_poll_timeout() inside a spinlock with IR=
Qs
disabled cause hard deadlocks, especially if the local CPU is responsible f=
or
advancing the timer tick? Should readl_poll_timeout_atomic() be used here
instead?


[Severity: High]
This is a pre-existing issue, but do error paths in imx_mu_seco_rxdb() skip
clearing the GIP interrupt status?

drivers/mailbox/imx-mailbox.c:imx_mu_seco_rxdb() {
...
	if (byte_size > sizeof(*msg)) {
...
		err =3D -EINVAL;
		goto error;
	}
...
	for (i =3D 1; i < msg->hdr.size; i++) {
		err =3D imx_mu_rx_waiting_read(priv, arg++, i);
		if (err) {
			dev_err(priv->dev, "timeout read idx %d\n", i);
			goto error;
		}
	}
...
error:
	return err;
}

Because these paths jump directly to the error label, they skip the GSR
register write that clears the GIPn interrupt status.

Furthermore, returning an error skips the GIEn unmasking in imx_mu_isr_th().
Could this leave the RXDB interrupt permanently masked and cause spurious
interrupts if the channel is later closed and reopened?


[Severity: High]
This is a pre-existing issue, but does imx_mu_startup() leak the PM runtime
usage counter on error?

drivers/mailbox/imx-mailbox.c:imx_mu_startup() {
...
	ret =3D pm_runtime_get_sync(priv->dev);
...
	ret =3D request_threaded_irq(priv->irq[cp->type],
				   imx_mu_isr,
				   imx_mu_isr_th,
				   IRQF_SHARED,
				   cp->irq_desc, cp);
	if (ret) {
		dev_err(priv->dev, "Unable to acquire IRQ %d\n", priv->irq[cp->type]);
		return ret;
	}
...
}

If request_threaded_irq() fails, the function returns immediately without
calling pm_runtime_put_sync().

Since the mailbox core does not call shutdown() if startup() fails, does th=
is
permanently prevent the device and its power domain from suspending?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-imx_mbox_r=
proc-v3-0-77948112defc@linutronix.de?part=3D5
