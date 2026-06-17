Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF8A26059D;
	Wed, 17 Jun 2026 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680092; cv=none; b=PfYrgepJ6dEe/D47MRN9JLkLzbZtiOyFRSOHRXNsN9tRX4Wfc0ziEMhVluQMjIJsJ4qwifavgjUq/9Q1pFihF0gF//VrWrG1hLfESFdNH5vvNMzfa4hMDRdcM6NFymMkGQAc75oDmARk4R8oXeOJNTagYiMoyEMHahSXjKw7xto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680092; c=relaxed/simple;
	bh=l1c8tLje5i48X1tvUl4/V+vO9khJKr+oBb/pYNqKpKI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LPFZG6D3MGF8I4ckGBbI4IsTJo8v+M81I5bP87me460dOsnpFG7UOTDFaHcwkG8wT+pE+h3RwCr4wk7VgQPCDxSiSk/b0+niGAmB4poCYUkwWZ+Id6SSU9SiSYvZJRGoCnf828PGUd3/w6VV0FNoUDVEGLFqQGxBggC5VpMUX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK3y0e+f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK3y0e+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286031F000E9;
	Wed, 17 Jun 2026 07:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781680091;
	bh=sH/KK53c9P2v2U90v7O5x3mUWpaPocI1za1GXULsH6U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JK3y0e+fAWKlisZNdJH0Ws/727HYjtCmpS7orsi4cdXbI4nyBt/CKIHtdVPejniEB
	 DdIqOgZuF6LnAid1MTQ1ydszHK8KmKxTf6c/2R5hxKc+84VLbSKeLeCbCCu5LImuNB
	 LZPEDnq/XTWVNr++D6ErZ3VNw1wspG59srMCsUztvc3YWEaEqb1Os/9JLhCgTB2DEB
	 TM3bR3fprNPajuTshS5Wmfxgcf9yVLhSwBf8fmxLWk0wT/Nren15zZ4AHVb7Ul/KAQ
	 77KGYqkgvuGOp464PWUxhMYRi0X2lH6H4fu6q+ZTjr4sbGj8mc+wy/HpYw0HHVSFKX
	 iYZ4R4Q2tZh7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/10] mailbox: imx: Add a channel shutdown field
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: Frank.Li@kernel.org, linux-rt-devel@lists.linux.dev, imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260617-imx_mbox_rproc-v3-2-77948112defc@linutronix.de>
References: <20260617-imx_mbox_rproc-v3-0-77948112defc@linutronix.de>
 <20260617-imx_mbox_rproc-v3-2-77948112defc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:08:10 +0000
Message-Id: <20260617070811.286031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch introduces `cp->shutdown` to fix a teardown race in the =
RX path but fails to apply the same fix to the TX path. If a channel is fre=
ed while TX messages are queued, the ISR can unconditionally unmask the TX =
interrupt after `shutdown()` has masked it, leading to a 'nobody cared' int=
errupt storm.
- [High] Polling jiffies with local IRQs disabled leads to potential deadlo=
ck in `imx_mu_tx_waiting_write()`.
- [Medium] Missing `pm_runtime_put_sync()` on the error path of `imx_mu_sta=
rtup()` causes a permanent power management reference leak.
--

commit ceab4c0d8020e02fd68ce7762cacc2496963937c
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

mailbox: imx: Add a channel shutdown field

sashiko complained about possible teardown problem. The scenario

 CPU 0                              CPU 1
  imx_mu_isr()                   imx_mu_shutdown()
                                   imx_mu_xcr_rmw(priv, IMX_MU_RCR, 0, IMX_=
MU_xCR_RIEn(priv->dcfg->type, cp->idx));
    imx_mu_specific_rx()
      imx_mu_xcr_rmw(priv, IMX_MU_RCR, IMX_MU_xCR_RIEn(priv->dcfg->type, 0)=
, 0);
                                   free_irq()

The RX event remains enabled because in this short window the RX event
was disabled in ->shutdown() while the interrupt was active and then
enabled again by the ISR while ->shutdown waited in free_irq().

This race requires timing and if happens can be problematic on shared
handlers if the "removed" channel triggers an interrupt. In this case
the irq-core will shutdown the interrupt with the "nobody cared"
message.

Introduce imx_mu_con_priv::shutdown to signal that the channel is
shutting down. This flag is set with the lock held (by
imx_mu_xcr_clr_shut()). The unmask side uses imx_mu_xcr_set_act() which
only enables the event if the channel has not been shutdown and
serialises on the same lock.

> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 0028073be4a71..e261b382d5c90 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c

[ ... ]

> @@ -605,6 +636,7 @@ static int imx_mu_startup(struct mbox_chan *chan)
>  		return ret;
>  	}
> =20
> +	cp->shutdown =3D false;

[Severity: Medium]
This is a pre-existing issue and was not introduced by the patch under
review, but does this error path leak the PM runtime reference?

In imx_mu_startup(), pm_runtime_get_sync() is called to increment the PM
usage counter. If request_threaded_irq() fails, the function returns
directly without calling pm_runtime_put_sync():

drivers/mailbox/imx-mailbox.c:imx_mu_startup() {
    ...
    pm_runtime_get_sync(priv->dev);
    ...
    ret =3D request_threaded_irq(...);
    if (ret) {
        dev_err(...);
        return ret;
    }
    ...
}

The mailbox framework handles this failure via mbox_clean_and_put_channel(),
but does not invoke the shutdown() callback when startup() fails.
Consequently, can the device's PM runtime reference be permanently leaked,
preventing the hardware from entering a suspended state?

[ ... ]

> @@ -639,13 +671,13 @@ static void imx_mu_shutdown(struct mbox_chan *chan)
> =20
>  	switch (cp->type) {
>  	case IMX_MU_TYPE_TX:
> -		imx_mu_xcr_rmw(priv, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(priv->dcfg->type, =
cp->idx));
> +		imx_mu_xcr_clr_shut(priv, cp, IMX_MU_TCR, IMX_MU_xCR_TIEn(priv->dcfg->=
type, cp->idx));
>  		break;

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but does this patch leave the TX path vulnerable to a similar
teardown race?

The patch introduces cp->shutdown to fix the teardown race in the RX path,
but if a TX channel is freed while messages are queued, can the ISR
unconditionally unmask the TX interrupt after shutdown() has masked it?

When mbox_free_channel() calls imx_mu_shutdown(), it masks the TX interrupt
via imx_mu_xcr_clr_shut(), sets cp->shutdown =3D true, and waits in free_ir=
q().

If a TX interrupt concurrently fires, imx_mu_isr() masks it and wakes the
threaded handler imx_mu_isr_th(). This handler calls mbox_chan_txdone() and
eventually triggers msg_submit().

Because the queue isn't purged yet, it dequeues the next message and
synchronously calls the driver's TX callback. However, imx_mu_generic_tx()
and imx_mu_specific_tx() unconditionally re-enable the TX interrupt:

drivers/mailbox/imx-mailbox.c:imx_mu_generic_tx() {
    ...
    case IMX_MU_TYPE_TX:
        imx_mu_write(priv, *arg, priv->dcfg->xTR + cp->idx * 4);
        imx_mu_xcr_rmw(priv, IMX_MU_TCR, IMX_MU_xCR_TIEn(priv->dcfg->type, =
cp->idx), 0);
        break;
    ...
}

Once the threaded ISR finishes, free_irq() unblocks, leaving the hardware TX
interrupt enabled but without a registered handler. Will this result in a
"nobody cared" kernel warning?

[ ... ]

[Severity: High]
This is a pre-existing issue and was not introduced by the patch under
review, but does polling jiffies with local IRQs disabled lead to a potenti=
al
deadlock here?

The imx_mu_tx_waiting_write() function uses an open-coded timeout loop based
on jiffies:

drivers/mailbox/imx-mailbox.c:imx_mu_tx_waiting_write() {
    ...
    do {
        status =3D imx_mu_read(priv, priv->dcfg->xSR[IMX_MU_TSR]);
        can_write =3D status & IMX_MU_xSR_TEn(priv->dcfg->type, idx % 4);
    } while (!can_write && time_is_after_jiffies64(timeout_time));
    ...
}

This function is called from the send_data callback (imx_mu_seco_tx), which
the mailbox core invokes with the channel's spinlock (chan->lock) held. This
spinlock unconditionally disables local interrupts.

Because local interrupts are disabled, the timer tick cannot fire on the
local CPU to update jiffies. On a single-core system, or if the local CPU is
responsible for updating the tick, jiffies will never increment.

If the hardware does not promptly set the status bit, will the loop spin
infinitely and cause a hard lockup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-imx_mbox_r=
proc-v3-0-77948112defc@linutronix.de?part=3D2
