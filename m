Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A7A165F16;
	Wed, 17 Jun 2026 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680760; cv=none; b=n8guDnTI5WaANrLFasmZPLqZrqc2Qa796A7ZyX0Cn33Bg1S5ZAo9UYfg3misguP+21DbXrORdERLG6h8eNgWSd+szR7VGk8BR49V6/0jqMWyOzi+XYyCPnD42ihufKrdkrvntzdagYjdR+kWvovLeeFe5NOPzyrA33Va0bDIPmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680760; c=relaxed/simple;
	bh=VR7J5qmqwRlTFUdhKLpyhkaOnk0tf4ckTASpNeecPGg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cS5Ghf/ZZYRkIJATnz0EKqdWvOsJVlzvtRDK/gX8dCHnGWuVsL7zMHVCwl2VuEQdUWe7z6KPj2Dz+Rn6DE8RgXfLk6suX0JLc4qfrMSXYZ+SlszOYwMvzhhWfYlZ53KVmar9c15eZcX7AUieYr6Hi4Yg27gHEux6m+lJNRXVJQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvaKrPDF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvaKrPDF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F16781F000E9;
	Wed, 17 Jun 2026 07:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781680759;
	bh=O+47lQIQhmyYwWUko2jypkpBELVOay5WFxiflUip+ho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EvaKrPDFRISOtGw5Bi2dXmAeFQIbgqVX2y5t8WS/2c31cPLf2vufO76FgNfIT1Zb2
	 eLtQzxrAgG5vBo5WdJ2B5ZcMTwFIPkVEtaIW2QSbUbkfs10atrzTTnfn1oYlWUvpB+
	 Y4jc9qhVfYgFqbxE02jkHmsqv3wXIqFfDi+btGCdm4Of9OANQYwKp+/Ykyq4xDINQX
	 U40n0s1LBmZARYSnfCKPbzLo8J8+KHCMWCPdtGNx6afIvD9DT+JRFk/EcFnsYVuZrQ
	 eLEh7m8cuLZY5C0XSZV3/DGb5nNqiE/itX+z/O3n0v7/e6FIhGBz1YOFo2SPuZU18H
	 oxzxTFjqNcL2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] remoteproc: imx_rproc: Invoke the callback
 directly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: Frank.Li@kernel.org, linux-rt-devel@lists.linux.dev, imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260617-imx_mbox_rproc-v3-10-77948112defc@linutronix.de>
References: <20260617-imx_mbox_rproc-v3-0-77948112defc@linutronix.de>
 <20260617-imx_mbox_rproc-v3-10-77948112defc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:19:18 +0000
Message-Id: <20260617071918.F16781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unsafe lockless iteration of `rproc->notifyids` in preemptible con=
text risks Use-After-Free of IDR nodes and `rvring` structures during concu=
rrent device teardown.
- [High] If requesting the 'rx' mailbox channel fails, `priv->tx_ch` is fre=
ed but its pointer is not cleared, causing a subsequent start to mistakenly=
 treat initialization as successful.
--

commit 6f600102625eeb04d37188290cefc55632750bc2
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

remoteproc: imx_rproc: Invoke the callback directly

The imx-mailbox driver moved the callback invocation into the threaded
IRQ handler. This means the callback is invoked in preemptible context,
so there is no need to schedule a kworker. This patch removes the workqueue
handling and invokes the callback directly.

> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rpro=
c.c
> index 0dd80e688b0ea..c97bc1c401655 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c

[ ... ]

> @@ -835,21 +832,11 @@ static int imx_rproc_notified_idr_cb(int id, void *=
ptr, void *data)
>  	return 0;
>  }
> =20
> -static void imx_rproc_vq_work(struct work_struct *work)
> -{
> -	struct imx_rproc *priv =3D container_of(work, struct imx_rproc,
> -					      rproc_work);
> -	struct rproc *rproc =3D priv->rproc;
> -
> -	idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc);
> -}
> -
>  static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
>  {
>  	struct rproc *rproc =3D dev_get_drvdata(cl->dev);
> -	struct imx_rproc *priv =3D rproc->priv;
> =20
> -	queue_work(priv->workqueue, &priv->rproc_work);
> +	idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc);

[Severity: High]
This is a pre-existing issue, but since the iteration now runs directly
in the preemptible threaded IRQ handler, does the lack of RCU protection
risk a use-after-free?

During rproc_shutdown(), imx_rproc_stop() frees the mailbox channel, but
without disabling the IRQ, the callback can run concurrently with
rproc_resource_cleanup().

If the threaded IRQ handler is preempted here, could the RCU grace period
elapse while rproc_resource_cleanup() unregisters the device and removes
entries from the notifyids IDR?

rproc_vq_interrupt() also performs a lockless idr_find() lookup on the same
notifyids IDR:

drivers/remoteproc/remoteproc_virtio.c:rproc_vq_interrupt() {
    ...
    rvring =3D idr_find(&rproc->notifyids, notifyid);
    ...
}

Would wrapping the idr_for_each() call with rcu_read_lock() and
rcu_read_unlock() be necessary to safely iterate the IDR nodes and prevent
use-after-free of the rvring structures?

>  }
> =20
>  static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block)

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in the error
handling within imx_rproc_xtr_mbox_init().

If requesting the rx mailbox channel fails, the code frees the tx channel b=
ut
does not clear the pointer:

drivers/remoteproc/imx_rproc.c:imx_rproc_xtr_mbox_init() {
    ...
    priv->rx_ch =3D mbox_request_channel_byname(cl, "rx");
    if (IS_ERR(priv->rx_ch)) {
        mbox_free_channel(priv->tx_ch);
        return dev_err_probe(...);
    }
    ...
}

Because priv->tx_ch is not set to NULL, and priv->rx_ch contains an ERR_PTR,
the early exit check at the top of the function evaluates to true on any
subsequent call:

    if (priv->tx_ch && priv->rx_ch)
        return 0;

If a user retries starting the remoteproc via sysfs, this will incorrectly
return 0 (success) with a dangling priv->tx_ch pointer. When the remoteproc
later sends a kick, imx_rproc_kick() will use this dangling pointer, which
can cause a use-after-free crash.

Could we set priv->tx_ch to NULL after freeing it to prevent this sequence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-imx_mbox_r=
proc-v3-0-77948112defc@linutronix.de?part=3D10
