Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B1B39937B;
	Wed, 17 Jun 2026 07:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781680135; cv=none; b=resaFuvvotC49NnPz9MKExjbGcEIkDJby0HMLzkcVFnh+WjVvtw/v1ZXH9ZzYLauB+5aot9G9rNbt8HmngRHnzflDASbHJj+YcDZ99tl1hjqBUAsN5O9fNKZ1BMCFAI16LFV3gSyG1PRX8aW4g77SHVf6ieaqavc2SEZUgsC0wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781680135; c=relaxed/simple;
	bh=8TWWA5FbBTjltOuYNbj34SXTYt+k5/bLobjEBf2pz2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ClHLHtKKziv7vJx+SFEw+fS90wef+pGDXYDEZhVAiO937QQ9wcpHKZojrpeksIOHxxzum/ktMB3d6wMNXzFcD93Oy5m5o1rd58eXFumb9WQKR5BAOSmR5gzISacYq9SN6N4+hU26SeeOwcYBJoTYd/LuSxTfgk6MRIHR8WIBMGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RozUtLYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RozUtLYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A431F000E9;
	Wed, 17 Jun 2026 07:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781680134;
	bh=t7MRrDxyjZ2iYZyx0vamiV0sXV0kK3VqDrkxQDzB2js=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RozUtLYkCJMNyjFIykneCxEie2WmemgcTTD93wBXEwgGnNTinNEijY0SynuRXtfdm
	 UWav/peA3TfL9y19TAwVBZX3UrF5pYf5Xzi1YcziCc14zyUe8e61XXgtK83XSmmc3c
	 BwsGyPSStNEarc6q2zFOgQhSuTip+4f/0+90zRU26KP89C8Vp+0Quq2FdtKF5FurQD
	 3Pz5sZUORf+ff+eE05ahSHS3WzJo0d9z1hAiGVE118G8jeQlUpoJLipYX5G9OCvsY9
	 STEJbPBcJAhHo+ZX+Fd19OxDV+uhgrpqwW1Hf+PV60GRfluwXVpPPVcBkfUXgYtCr6
	 y4Nx/5UCjSuRw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/10] mailbox: imx: Use devm_pm_runtime_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: imx@lists.linux.dev, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260617-imx_mbox_rproc-v3-3-77948112defc@linutronix.de>
References: <20260617-imx_mbox_rproc-v3-0-77948112defc@linutronix.de>
 <20260617-imx_mbox_rproc-v3-3-77948112defc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:08:53 +0000
Message-Id: <20260617070853.C1A431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing error check on `pm_runtime_get_sync()` in `imx_mu_startup(=
)` allows unclocked hardware access.
- [High] Checking `ret < 0` for `pm_runtime_put_sync()` causes spurious pro=
be failures and resource leaks on concurrent PM access.
- [High] Missing `pm_runtime_put_sync()` when `request_irq()` fails in `imx=
_mu_startup()`.
--

commit 023389d6153d2d912a21b34dd94fa1a45a63f27a
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

mailbox: imx: Use devm_pm_runtime_enable()

This patch updates the imx mailbox driver to use devm_pm_runtime_enable()
and reorders the probe function to delay mailbox controller registration
until after PM runtime initialization. This ensures proper cleanup order
during device removal or probe failure, resolving issues with early device
usage.

> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index e261b382d5c90..516a05b64daa1 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
[ ... ]
> @@ -966,38 +966,36 @@ static int imx_mu_probe(struct platform_device *pde=
v)
[ ... ]
>  	ret =3D pm_runtime_resume_and_get(dev);
>  	if (ret < 0)
> -		goto disable_runtime_pm;
> +		goto disable_clk;
> =20
>  	ret =3D pm_runtime_put_sync(dev);
>  	if (ret < 0)
> -		goto disable_runtime_pm;
> +		goto disable_clk;

[Severity: High]
This isn't a bug introduced by this patch, but should the return value
of pm_runtime_put_sync() be treated as a fatal error here?

pm_runtime_put_sync() can return -EAGAIN or -EBUSY if the device cannot be
suspended immediately, such as when another thread concurrently accesses the
device's PM runtime via sysfs.

If this happens, the valid non-error return value causes the driver to
spuriously abort the probe process. It also leaves the device in RPM_ACTIVE,
which leaks the clock enabled by the earlier pm_runtime_resume_and_get() ca=
ll.

[ ... ]

While reviewing the PM runtime usage, I also noticed two other pre-existing
issues in imx_mu_startup().

[Severity: High]
This is a pre-existing issue, but does this code leave the clock disabled
if the PM runtime resume fails?

drivers/mailbox/imx-mailbox.c:imx_mu_startup() {
	...
	pm_runtime_get_sync(priv->dev);

	spin_lock_irqsave(&priv->xcr_lock, flags);
	imx_mu_xcr_rmw(priv, 0, IMX_MU_xCR_GIEn(cp->type, cp->idx));
	...
}

If pm_runtime_get_sync() fails (for example, if the clock fails to enable),
the return value is ignored and the device remains suspended. The function
then immediately proceeds to access hardware registers via imx_mu_xcr_rmw().
Can accessing unclocked peripheral registers cause a synchronous external
abort and lead to a system crash?

[Severity: High]
This is a pre-existing issue, but does this error path leak the PM runtime
usage counter?

drivers/mailbox/imx-mailbox.c:imx_mu_startup() {
	...
	pm_runtime_get_sync(priv->dev);
	...
	ret =3D request_irq(priv->irq[cp->type], imx_mu_isr, irq_flag,
			  cp->irq_desc, chan);
	if (ret) {
		dev_err(priv->dev, "Unable to acquire IRQ %d\n",
			priv->irq[cp->type]);
		return ret;
	}
	...
}

If request_irq() fails, the function returns the error directly without
calling pm_runtime_put_sync(). This would permanently leak the PM runtime
usage counter, preventing the device from ever suspending and keeping the
hardware clock continuously enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-imx_mbox_r=
proc-v3-0-77948112defc@linutronix.de?part=3D3
