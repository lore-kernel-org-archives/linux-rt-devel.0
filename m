Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C119395DBF;
	Thu, 13 Aug 2026 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610094; cv=none; b=I7YEneYUtwSYM/80+BmIcbZZOyMs/Ptb+619uFdCYchs/Ef1gf11bldzTJZuMW8JixHlDwIRsQDg2/PTEC9Ka9v3jMo9bl65rUH04ES8nZ/Vryj4PbgUu3n+IWOeVSNve8CdgMaPzQVrOYdhC/GAht/cYnCp5orz3OQ/CU5DMIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610094; c=relaxed/simple;
	bh=d4Y1pRCOkgrzl2rVFDGa7BoEpu2xOktPf3qmSqYxoOY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=H6TXanrk3G2Mxq2I6edRA6q+dUBfZLEfpuXA9vY/5BJV1ELGekzUztk6LLF59WuU1Wzp+eJYVdzo0tDCPC1k/mxGZXeHjkgCNYsBwSZLkjyWRhMsTIpR6+8+176oD9yQ3Y6uWoYQQFh9hDmR/bC36wYs3HraTjJQcAes5haPgSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhqDz2dJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhqDz2dJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1198C1F00A3A;
	Thu, 13 Aug 2026 08:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786610091;
	bh=EWC6iWF53re0j19Fqwj2lhYURooG28lfk3Al/oHtj6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hhqDz2dJnOcic/b6V8+EiQMOnn8oS+xWgoYDiIS+rPLXBQhIuV9Mntk9lUXtTGDvj
	 t8pOqqbPMXN901nQ4MTB06fxYmA/QLQf/QcTEUDSacd0FUlHTH6EL+NgegL1WQqCoS
	 cHfdofWiUBAuTW2Vt8vNKimSWyhvtMWQwO6OcVXCnqs5UkRKIR9i7BKxuW9o1jtYe+
	 lOYcRitcyHCQ/GeY/tTV2bHtoB718NoetyHmmpTBmOvzAzmnlQXgJ5NC+Kzju3gwmM
	 ezXdX4cxa1auU2ruyQb/ed3ZB/rW5hA8yPR9eK9wS9xQu68LG0YPiD/5DQ7Ubi6Hnn
	 MGGBaf0JZHBXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH REPOST REPOST v6] remoteproc: imx_rproc: Invoke the
 callback directly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, Frank.Li@kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260813-imx_mbox_rproc-v6-1-6903a93b0456@linutronix.de>
References: <20260813-imx_mbox_rproc-v6-1-6903a93b0456@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 08:34:50 +0000
Message-Id: <20260813083451.1198C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing RCU read lock around `idr_for_each()` traversal of `notify=
ids` leading to potential Use-After-Free.
--

--- Patch [1]: [PATCH REPOST REPOST v6] remoteproc: imx_rproc: Invoke the c=
allback directly ---
commit d2ef12e25a967a32f7b650f21d89c9b5c07eccf3
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

remoteproc: imx_rproc: Invoke the callback directly

This commit removes the workqueue in the imx_rproc driver and invokes
the mailbox callback directly. It takes advantage of the imx-mailbox
driver moving callback invocation into its preemptible threaded IRQ handler.

> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rpro=
c.c
> index 7662ebd9d2f49..e18ae33a5cf85 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c

[ ... ]

> @@ -892,21 +889,11 @@ static int imx_rproc_notified_idr_cb(int id, void *=
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
This is a pre-existing issue, but since this callback is executed in a
preemptible context (now a threaded IRQ instead of a workqueue), does this
idr_for_each() call need rcu_read_lock() protection?

If a concurrent rproc_shutdown() calls rproc_free_vring() and removes nodes
from the IDR via idr_remove(), could the threaded IRQ be preempted during
this idr_for_each() traversal, allowing an RCU grace period to elapse?

If that sequence occurs, could the IDR traversal access freed memory when
the handler resumes?

>  }
> =20
>  static int imx_rproc_xtr_mbox_init(struct rproc *rproc, bool tx_block)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-imx_mbox_r=
proc-v6-1-6903a93b0456@linutronix.de?part=3D1
