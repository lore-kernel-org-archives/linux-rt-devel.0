Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A588282F05;
	Fri,  3 Jul 2026 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068323; cv=none; b=JWgXMTksVhF6s2Qt00GPsz+X23Teh/IljGprBKDASWZSvjunE07UEGniSD38VM22S5fFLYyE2yYIPtND+hoYHtcfZO20Zlkp20ElvfXPUsp5tw36+TsA+zTEH+g1QH72BuOvpKfYUK1xNRzXV4IelmkX02W2QxFf0VsLOFkhZ84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068323; c=relaxed/simple;
	bh=/OLpNwgDewrrq8i2+sB+btgtkVfoF3i7aU8UhoMSFh0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V9uT5GUQLZWEJQCqaOiMQCiS/qprOEE10bzxfz+9OeVJis4Pv9gyhRshROEylRXxLgLFSL+zDGdX0Uly21nBiVW1gpBAJDjQgwKUCdDgmNUW2IrsrJcXDH1o7IqQEV8kU5RxoEDvdpkEr9bvXNmfbC6LD3fr0SPbNSMcVPSOYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I32TYtmC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I32TYtmC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F4B1F000E9;
	Fri,  3 Jul 2026 08:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783068322;
	bh=Be6hosvtsW4hWYn4TwQetckFZyIJOaogWw8UlPld7gc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I32TYtmCPazkVwHS3G4hz4Xv1nVNpN2HWw1Wn8cawHFT0G8vVeCq5t1233sgE1+79
	 e8VGt8erluK01ggQYN8dcutHkX6sghXqzDiZO5SdsJl3wX9hu2b89B+SluEIvEPMcS
	 4ZCILJO+lW7jHNiZR7CjLkpHIVV1u2BX8swwuS6KB+KJrOqIupRe47umSMF+E8BKYH
	 qzH7G8SVJG9mEcA8Th3mA3MmIoXxoru5SqXzZI6+b972pjrfQEU06/Ecu43PA6GCbV
	 +vQ4OuvO+xuMuPGtWBW/GyJtfqZlAwVtlZJHu0iPPcjtSnobvaUMYgKdfXUkefuvw5
	 M+fnX5dd7khAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] remoteproc: imx_rproc: Invoke the callback directly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, Frank.Li@kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260703-imx_mbox_rproc-v4-1-67b10560a861@linutronix.de>
References: <20260703-imx_mbox_rproc-v4-1-67b10560a861@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 03 Jul 2026 08:45:21 +0000
Message-Id: <20260703084521.D8F4B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing RCU read lock around idr_for_each() and idr_find() in pree=
mptible context.
- [High] Improper devm cleanup order leaves mailbox active during driver te=
ardown, causing Use-After-Free.
--

commit 24cd624015487c1ba761a43443263ce588b90c10
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

remoteproc: imx_rproc: Invoke the callback directly

This commit removes the workqueue used for callback invocation in the
imx_rproc driver. The callback is now invoked directly from the threaded
IRQ handler since it runs in a preemptible context.

> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rpro=
c.c
> index 745ce52cd8226..a1f2b76ec8187 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
[ ... ]
>  static void imx_rproc_rx_callback(struct mbox_client *cl, void *msg)
>  {
>  	struct rproc *rproc =3D dev_get_drvdata(cl->dev);
> =20
> -	queue_work(priv->workqueue, &priv->rproc_work);
> +	idr_for_each(&rproc->notifyids, imx_rproc_notified_idr_cb, rproc);

[Severity: High]
This isn't a bug introduced by this patch, but does this lockless iteration
over the notifyids IDR lack RCU protection?

Because imx_rproc_rx_callback() now runs in a preemptible context (threaded
IRQ handler), it iterates over the rproc->notifyids IDR using idr_for_each()
without the rcu_read_lock().=20

The IDR API requires lockless readers to hold rcu_read_lock() to prevent ra=
dix
tree nodes from being freed during traversal. If a concurrent modification
like idr_remove() occurs during teardown, the RCU grace period could expire,
leading to a use-after-free on the IDR internal nodes.

>  }
> =20
>  static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block)
[ ... ]
> @@ -1273,17 +1253,6 @@ static int imx_rproc_probe(struct platform_device =
*pdev)
>  		priv->ops =3D dcfg->ops;
> =20
>  	dev_set_drvdata(dev, rproc);
> -	priv->workqueue =3D create_workqueue(dev_name(dev));
> -	if (!priv->workqueue) {
> -		dev_err(dev, "cannot create workqueue\n");
> -		return -ENOMEM;
> -	}
> -
> -	ret =3D devm_add_action_or_reset(dev, imx_rproc_destroy_workqueue, priv=
->workqueue);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "Failed to add devm destroy workqueue a=
ction\n");
> -
> -	INIT_WORK(&priv->rproc_work, imx_rproc_vq_work);
> =20
>  	ret =3D imx_rproc_xtr_mbox_init(rproc, true);
>  	if (ret)

[Severity: High]
This is a pre-existing issue, but could the devm cleanup order in
imx_rproc_probe() lead to a use-after-free during driver teardown?

Earlier in imx_rproc_probe(), the mailbox cleanup action imx_rproc_free_mbox
is registered via devm_add_action_or_reset() before devm_rproc_add() is
called.

Because devm actions execute in LIFO order, devm_rproc_remove() executes
first, which tears down the remote processor and frees virtio subdevices and
their IDR entries.

This leaves a dangerous race window during driver unbind where the mailbox =
is
still fully active while the core remoteproc data structures are being torn
down. If a mailbox interrupt fires during this window, the RX handler will
access the notifyids IDR and rvring structures while they are concurrently
being modified or freed by rproc_del().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260703-imx_mbox_r=
proc-v4-1-67b10560a861@linutronix.de?part=3D1
