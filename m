Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B9539EF16;
	Tue, 21 Jul 2026 14:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784644182; cv=none; b=OOLtI/wzjBOVJ0EWqH8ZkntMYHCBCM9OCMJJcUWXas/LBlEqbyFhJXYuDQeAZnqBiutWVnNFdiNEhtUZ49Og47O8oc9O+Pqu6viZmo6PGY+EygOb8IyPs/vTLszo3QPTdkPHahZJGxBD1eeUX1V0r8ULQnnjKNlZlPbralCDGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784644182; c=relaxed/simple;
	bh=1rBYNCGa8BZ7Ia5mCo62sXHE1xYNPxrgCq5Sjih+1ww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FpHncT0wFjDR0RmivRO0A9liocBzNB8hUDu9mzL+zbnurelqgFA0dJ/yL7PdFtaA4SifS922RUwPPXLF0Rket0wI+e/yVkhe2pEDsIMo8ZdGD2ekc5E0ctOrJeMag+1hPsNiflXT1tnOF7c4nwuYkKRTgfOYhBNXPu/gxga4eIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBMdUWZp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBMdUWZp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C301F000E9;
	Tue, 21 Jul 2026 14:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784644181;
	bh=SmOS/jNkjtP0V3qH/XLcPyLAUEQdalL3iNCm/r/dhDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HBMdUWZpUGSm/DrAlAloa5DgdU4135/pq6giuZglIHJbELEVlhSfsZjfKxfGw2RuJ
	 oQFZq7m47uaZmMrr0FdmbjX6woRb0+pppo/sEb72o51NtnVpMZEdpWJ2WP7imIlUry
	 8QC4GpzJ142SgmxvJUOFx0nZ8ETqhszW8baAbMARQWhNjfvf0doYILGF+sZtbEzjif
	 BCNGrtH3PdcNhjYfdEAy1bzEzGN3jQm5QRaxPrdVehc5FV9U5m3zpOMxgL8qOaYVq8
	 rcdBgWrXS0DKuipVpdOG/JPL7zQ6i9bUS1wyqYrZpXcUwjSi9ENz8xStw7LFy4/kgy
	 kYX07OozRNldw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 REPOST] remoteproc: imx_rproc: Invoke the callback
 directly
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260721-imx_mbox_rproc-v5-1-6386a2cf8524@linutronix.de>
References: <20260721-imx_mbox_rproc-v5-1-6386a2cf8524@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 14:29:40 +0000
Message-Id: <20260721142941.22C301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the IDR iteratio=
n via `idr_for_each()` in `imx_rproc_rx_callback()` is performed without ho=
lding the RCU read lock in a preemptible context, potentially leading to a =
use-after-free.
- [High] This problem wasn't introduced by this patch, but the mailbox chan=
nel is leaked on the `imx_rproc_start` error path, allowing concurrent mail=
box callbacks during resource cleanup and causing a Use-After-Free of `rvri=
ng`.
--

--- Patch [1]: [PATCH v5 REPOST] remoteproc: imx_rproc: Invoke the callback=
 directly ---
commit 861718f5edd7547335536b279e55e3c8605a7454
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

remoteproc: imx_rproc: Invoke the callback directly

This commit removes the workqueue handling in the imx_rproc driver and invo=
kes
the imx_rproc_notified_idr_cb callback directly from the mailbox RX callbac=
k.
This change is possible because the imx-mailbox driver moved the callback
invocation into the threaded IRQ handler, which runs in a preemptible conte=
xt.

Link: https://lore.kernel.org/all/20260703-imx_mbox_rproc-v4-1-67b10560a861=
@linutronix.de/

> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rpro=
c.c
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c

[ ... ]

> @@ -860,21 +857,11 @@ static int imx_rproc_notified_idr_cb(int id, void *=
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
This isn't a bug introduced by this patch, but since we are now relying
on the threaded IRQ handler's preemptible context instead of the workqueue,
is it safe to call idr_for_each() here without holding the RCU read lock?

According to the IDR API rules, concurrent modifications to the IDR require
readers to hold the RCU read lock. If preemption occurs during this
traversal and a concurrent IDR removal happens (e.g., during driver
teardown), could this allow RCU grace periods to complete prematurely
and result in a use-after-free when dereferencing freed radix tree nodes?

>  }

[ ... ]

Also, while reviewing the driver's mailbox handling, I noticed another
pre-existing issue in a different part of the file:

drivers/remoteproc/imx_rproc.c:imx_rproc_start() {
    ...
    ret =3D priv->ops->start(rproc);
    if (ret)
        dev_err(dev, "Failed to enable remote core!\n");

    return ret;
}

[Severity: High]
This isn't a bug introduced by this patch, but does the error path in
imx_rproc_start() leak the mailbox channel?

If priv->ops->start(rproc) fails, the function returns an error without
calling imx_rproc_free_mbox(). The remoteproc core then handles the start
failure by skipping rproc->ops->stop() and directly unwinding via
rproc_resource_cleanup().=20

Since this unregisters the virtio devices, causing rvdev to be freed via
devm_kzalloc devres cleanup, could a spurious or delayed interrupt trigger
imx_rproc_rx_callback() concurrently with or after the cleanup? That would
allow the callback to access rproc->notifyids, retrieve the freed rvring,
and dereference it, leading to a use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-imx_mbox_r=
proc-v5-1-6386a2cf8524@linutronix.de?part=3D1
