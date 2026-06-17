Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF51394EBD;
	Wed, 17 Jun 2026 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680104; cv=none; b=eobDSXcwkya/hLqp8KMmf8+tRjiex+0CAhdsuFBXdJvaUoIeDpqPJrNYEKNJOqPrUzNnTWOD2ALa62mbgazlUy0SkciF8o8LQlBfnmgy/kgwam+Rj0emRvxTq30w0ipAFDnI6RQvWtQUYalwr/aVJ91NPI2sOsTX/7RmCJiru4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680104; c=relaxed/simple;
	bh=0ejKEPdvqWSRoojEauKCGJ/MFOSJcB2JYMwsQyE+o80=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Wsio8JpD7MuzBKwEzCyVOjzYHw0Ttelm5Ov+1ng8VdYy8/+upO0v4c2C6VQ2s23s28B6E01eEa2ogbysJFovrubz6wuK3Ws/Ytzq3oyvjZT00rHy4zRePjoEMfuY7R2kM4zB4NN4c9vxEBH26w8qVTGH+7mRZygdmOHQhA3sTxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N3P1FE6b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3P1FE6b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717BB1F000E9;
	Wed, 17 Jun 2026 07:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781680102;
	bh=cWPE00T7b6eoCSIZXAw9DU+TJAzXqVEnC8VNm8TS5z4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N3P1FE6bH29griiNxUvRUNkrqoxM5nyickhPNeq+mtLiO3ROQtvS9QRiLfBloeZCW
	 gxu0BfuCoL5tzWkzvPTaG/0sj1l2YDG/+H5RTRtMjE9s3UogFSnWrr6MJ+5ReXLbvR
	 v77eyU2jXm8TzH2Rj84pRb4K6ZozGSBxXGOcWsVKuZiPyGkAR0Gor8Z8xK4bocwx1n
	 dkaj19WmDgd0euqQMbaOzBvtQlviusDDkw/lhwRUXTVtRFNCbo91PnyUNOgFAdY1a3
	 mO6t++fTLZFQLF52CJPBCBN6qd9GOttmTJRIg7Vdnyu1KSrDz1uIYp8iajW8KfaTdX
	 6dCOb3F86SA7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/10] mailbox: imx: Start splitting the IRQ handler
 in primary and threaded handler
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: imx@lists.linux.dev, linux-rt-devel@lists.linux.dev, Frank.Li@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260617-imx_mbox_rproc-v3-6-77948112defc@linutronix.de>
References: <20260617-imx_mbox_rproc-v3-0-77948112defc@linutronix.de>
 <20260617-imx_mbox_rproc-v3-6-77948112defc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:08:22 +0000
Message-Id: <20260617070822.717BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Channel shutdown race condition leads to an unhandled IRQ storm on=
 shared interrupt line.
--

commit 7ed2b361db99c9ca608465a64760164124f3d0d2
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

mailbox: imx: Start splitting the IRQ handler in primary and threaded handl=
er

This commit splits the mailbox IRQ handling into primary and threaded
handlers. The primary handler masks the event, and the threaded handler
runs the mailbox core functions like mbox_chan_txdone() in a preemptible
context.

> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 408cd083c64ee..87acc43cb99c4 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -540,11 +540,31 @@ static void imx_mu_txdb_work(struct work_struct *t)
>  	mbox_chan_txdone(cp->chan, 0);
>  }
> =20
> +static irqreturn_t imx_mu_isr_th(int irq, void *p)
> +{
> +	struct mbox_chan *chan =3D p;
> +	struct imx_mu_priv *priv =3D to_imx_mu_priv(chan->mbox);
> +	struct imx_mu_con_priv *cp =3D chan->con_priv;
> +
> +	switch (cp->type) {
> +	case IMX_MU_TYPE_TX:
> +		mbox_chan_txdone(chan, 0);

[Severity: High]
This is a pre-existing issue, but does moving this into a threaded handler
expose a race condition during channel shutdown?

When mbox_free_channel() is called, it invokes the driver's imx_mu_shutdown=
()
callback, which masks the TX interrupt and calls free_irq().

Because free_irq() waits for any executing threaded handlers to finish,
it will block if imx_mu_isr_th() is currently executing mbox_chan_txdone().

This in turn triggers the mailbox core to submit the next previously queued
message via msg_submit() -> chan->mbox->ops->send_data().

The send callback (such as imx_mu_generic_tx() or imx_mu_specific_tx()) then
unconditionally unmasks the TX interrupt by calling imx_mu_xcr_rmw(),
completely bypassing any shutdown state.

Once the threaded handler finishes, free_irq() completes and unregisters
the interrupt action, but the hardware interrupt remains unmasked.

Since IRQF_SHARED is used, could the unhandled interrupt fire continuously,
resulting in a storm of IRQ_NONE that eventually causes the kernel to disab=
le
the shared IRQ line and break IPC globally?

> +		break;
> +
> +	default:
> +		dev_warn_ratelimited(priv->dev, "Unhandled channel type %d\n",
> +				     cp->type);
> +		return IRQ_NONE;
> +	}
> +	return IRQ_HANDLED;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-imx_mbox_r=
proc-v3-0-77948112defc@linutronix.de?part=3D6
