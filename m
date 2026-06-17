Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE51396597;
	Wed, 17 Jun 2026 07:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781679889; cv=none; b=fIv4y87U4PWSvN2oRAxSwmgmKRDx1WvCqH7sliP2ZQdn/kvgYx+DLyKGUtds22oNPyav5MpYMFkFyTXcin30blyYKBP8ELod3uVvFB+ghmshNZs2R1p3gQYIdcPI0dVdR+upcK+ThNj4djBlawDszSBVFwObQdQRT3ps8mhCqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781679889; c=relaxed/simple;
	bh=tXywHdqf04Vy+NGa+ToZ2eW0iYUMtnR2/wNPxLkrzmo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e3ZMIqRq9q7FA6kGsIk77pqlOLXE1OE/tbGcL3FAsOEbAWZT3cWrEtd3mZ7YIVNTr2Mc6qT/Qq0nYnJKVbrqSL5mLX7lg/ARVz2P+w1Ei3L3nH7dcF69uVt7fOlkXlFa9wRrA1Yjsagn4/A9GHpCzdwkhO60y+yKDaeaDAhfq0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSK0P3IY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSK0P3IY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34C31F000E9;
	Wed, 17 Jun 2026 07:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781679888;
	bh=itn3qpWX8Dz41rwwUs5k6DA37SGWUAfq38vKtJ6TP3w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mSK0P3IYn6JLYPAlQcSjWIZEITdEx+4TB5ykxqsrww41VMhgcx//dQuZ4soh2Qr7r
	 we3mxCOiWa4gJ6k3TXaTh8CeQFpAXbTCdOu40Sihy3ZiALCNx6tAQkXiu8k7ZYufac
	 tH49eplTIsFV5BhCpVNLObNh8elAT0qJiAS3fP0uhD8Kz7yEqo9d9DxMyAntO5QsYw
	 CINIzYCXK/L8faGH+f9tL8IOnon7pstGNTsyjyrilpXNwBLh4vhkEqhhTPLbnRXK0c
	 iByVUdgFeixeS0Sc1whzfXkLqhJ/xudEjSnn6fU9rwmRSMxko6U2FaC/Nj3CvTnCN/
	 O66lBNnYJdIgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/10] mailbox: imx: use devm_of_platform_populate()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: imx@lists.linux.dev, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260617-imx_mbox_rproc-v3-4-77948112defc@linutronix.de>
References: <20260617-imx_mbox_rproc-v3-0-77948112defc@linutronix.de>
 <20260617-imx_mbox_rproc-v3-4-77948112defc@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 07:04:47 +0000
Message-Id: <20260617070447.E34C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The return value of devm_of_platform_populate() is ignored, leadin=
g to silent probe success even if child devices fail to populate, and break=
ing the intended cleanup on module removal.
--

commit 583b7f6c5d004040c54817c853b20be8858487ce
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

mailbox: imx: use devm_of_platform_populate()

This commit transitions the driver to use the managed function
devm_of_platform_populate(). This is intended to ensure that populated
child devices are properly removed when the parent device is removed,
fixing an issue where module reloads could lead to "double devices".

> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -984,7 +984,7 @@ static int imx_mu_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_out;
> =20
> -	of_platform_populate(dev->of_node, NULL, NULL, dev);
> +	devm_of_platform_populate(dev);

[Severity: High]
Should this code check the return value of devm_of_platform_populate()?

If the function fails and returns an error code, the devres cleanup action
is not registered, but imx_mu_probe() will still return 0. This could
lead to a situation where child devices silently fail to populate, and any
partially populated devices would not be cleaned up on module removal.

For example:

	ret =3D devm_of_platform_populate(dev);
	if (ret)
		goto err_out;

> =20
>  	return 0;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-imx_mbox_r=
proc-v3-0-77948112defc@linutronix.de?part=3D4
