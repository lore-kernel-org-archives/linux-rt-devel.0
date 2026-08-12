Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BEA3264FB;
	Wed, 12 Aug 2026 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514261; cv=none; b=W91elJQpTR0HmKejbVh3YXWm8MrBEz9Tw+4m0W7A49wvjENV4qr1o2MKDjE/pJ+qmghSGprs1xjZ7cIfMpsRrJ5MTmagi0mu/3IDArsjV3CQiKTRfXwGu8416fSeJqd7anGkcxuBZc6jdJ+Gjx/vmfJ0WPGeU2SeqloNTKllblc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514261; c=relaxed/simple;
	bh=/2EsmlpG5BoYPRfd5Hed7bnKFZuNl4KI+L0IXo3Tl8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yjam0wt91RfOABJto+nJgpeOtQKNPf7C2a8BKbmk1F9pdQBTficYbufap38F2rlbWjeA0b12yADZ1sLtUZCUk/raAUFJJURw1MP2PmJVC8rtoUGEoZ3E2PRPVbdUE/gAEDB5Ff6apNgQQBMbgKF4kYzWxLFmY6hWcMp+XAo2+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTGH0EDc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTGH0EDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7691F000E9;
	Wed, 12 Aug 2026 05:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786514259;
	bh=gLmRJ0wn4LbDj4z2qrPP/XDs1Vi0vNTcBODL/3acf6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MTGH0EDcGORlZX0LIJCBKHISxBZJYvZmQSrTYDYetSNS4KhiOI99c73jxrePKnQmy
	 Zu864kkCK115fv6pOtqDDmasG5N21kFWCFC2f6YjHS/8uRsjz6d1r/wwnY7AMI9eAg
	 N2BryoKZoWuBk9WpEPye9vUoSPW0dzdx5SSH2NID9pLGe5ftKlbsPpbQrbRT9ZkRLq
	 7WY9IrwHRDcO07v94unvMqCyHyd9qdVAkv6iayHDZFVAv11mOHma6xVWjc+91mLgnD
	 mcB35G4tvhOfL/zZsc+hEadXcPshMf0AXHEBRO6OylFh/i5mKajwLyKhNyJ4G1QcMf
	 n4EVM9SHL0Jzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/7] EDAC/aspeed: Free the mem_ctl_info unconditionally
 on remove
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ryan Chen" <ryan_chen@aspeedtech.com>
Cc: robh@kernel.org, conor+dt@kernel.org, linux-rt-devel@lists.linux.dev, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260812-edac-v1-4-03992edea297@aspeedtech.com>
References: <20260812-edac-v1-0-03992edea297@aspeedtech.com>
 <20260812-edac-v1-4-03992edea297@aspeedtech.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 05:57:38 +0000
Message-Id: <20260812055739.2C7691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Potential use-after-free of `mci` in the interrupt handler during =
driver removal due to devm-managed IRQ and manual resource freeing.
--

--- Patch [4]: [PATCH 4/7] EDAC/aspeed: Free the mem_ctl_info unconditional=
ly on remove ---
commit c5d400d5b360781ecdef9cf321a50a2fde1b94dc
Author: Ryan Chen <ryan_chen@aspeedtech.com>

EDAC/aspeed: Free the mem_ctl_info unconditionally on remove

This commit removes a redundant NULL check on the return value of
edac_mc_del_mc() in aspeed_remove(), instead fetching the mem_ctl_info
from driver data to free it unconditionally.

> diff --git a/drivers/edac/aspeed_edac.c b/drivers/edac/aspeed_edac.c
> index 71535e0b6bad8..8bfeb21d3204a 100644
> --- a/drivers/edac/aspeed_edac.c
> +++ b/drivers/edac/aspeed_edac.c
> @@ -343,16 +343,15 @@ static int aspeed_probe(struct platform_device *pde=
v)
> =20
>  static void aspeed_remove(struct platform_device *pdev)
>  {
> -	struct mem_ctl_info *mci;
> +	struct mem_ctl_info *mci =3D platform_get_drvdata(pdev);
> =20
>  	/* disable interrupts */
>  	regmap_update_bits(aspeed_regmap, ASPEED_MCR_INTR_CTRL,
>  			   ASPEED_MCR_INTR_CTRL_ENABLE, 0);
> =20
>  	/* free resources */
> -	mci =3D edac_mc_del_mc(&pdev->dev);
> -	if (mci)
> -		edac_mc_free(mci);
> +	edac_mc_del_mc(&pdev->dev);
> +	edac_mc_free(mci);

[Severity: High]
This is a pre-existing issue, but could this edac_mc_free() cause a
use-after-free if the interrupt handler is running concurrently during
driver removal?

Because config_irq() registers the interrupt using devm_request_irq(), the
IRQ handler won't be unregistered and synchronized until devres cleanup
runs, which happens after aspeed_remove() returns.

While the hardware interrupt is disabled via regmap_update_bits() just
above, this does not wait for already-executing handlers on other CPUs
to finish. If mcr_isr() is running on another CPU, it could access the
just-freed mci:

mcr_isr() {
	struct mem_ctl_info *mci =3D arg;
	...
	dev_dbg(mci->pdev, "received edac interrupt...");
}

Would it be safer to explicitly free and synchronize the interrupt before
freeing mci, or use a non-devm request_irq()/free_irq() instead?

>  }
> =20
>  static const struct of_device_id aspeed_of_match[] =3D {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-edac-v1-0-=
03992edea297@aspeedtech.com?part=3D4
