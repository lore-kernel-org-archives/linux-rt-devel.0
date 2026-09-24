Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341814AA57C;
	Thu, 24 Sep 2026 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274968; cv=none; b=svCi5zyuJRrX9X6S0CF0h6oCKwI1+bnn+FjPU3s6pop46QGP0laMywm0/qFNdpZe9G+HwrUSW2UTGOKxAIX8JAzDlZYZShyDYgU5C2N83uZDevNC56WpgFdur/pi98ZNEZ0/RIAPn6/gujKpaxYbJyi1ZhXM5oBxbbdDzSC6xok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274968; c=relaxed/simple;
	bh=+7wSG1fbMiw6BVPZXKVldS6WeJ3iBDwlrglhzVY+a0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hVjz4tqwy9CEOjpIRpxpa+7uVlvPm1VwBAyoqvBaVqndC0rbSbaoJhuHIQJhnwk7YH79nZsc2RAV1Oz3cgmXWdjQiJBw3IpJRzm+hwiiKPxwKBh/pLQkQAABxzbx9ZK2RB0itBqTigXJwxZyaoaKxkivCeJU6y1NC0Bn6U4rVKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fhVJvTvu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fhVJvTvu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62FA1F000FF;
	Thu, 24 Sep 2026 18:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790274967;
	bh=4+YsEPkObCwuHlyeWj0xANQ9XQ3KCqB7MXvwiQKG6xI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fhVJvTvutBGQA9l7oh4TRcMGoJ7B3eutzB9KflPBHixj2UfXlm3L/UtC6Mprf5tbv
	 leRd1SdPubJMXkSlwBUH9bkIxXZzQd1wvcwX5q5gLfvpmdQcZ89dEa4vINEhGwgyx5
	 +bcmS2SaerhFqKlk+DWfPML9L/QJG5G/uM+joYOpEvlwFKbfm2zpO0twAUTwCpma3D
	 juTS2GBKHXMgdFNwpJE9qOCCvokRly+P63Nu1H9+vJAbpOYqeXT3TOUpKQz66oNvS0
	 brftD5K8ebXice222WH4kUSScCJnRaCd1WSTfDqkdm97mf1pkC83vkA8/8ooPwLM2E
	 yr/dE3Na5cntw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 14/14] coresight: etm3x: rename drvdata->config to
 sysfs_config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260924-separate_etm_cfg_v2-v12-14-a2b41d2f7c2b@arm.com>
References: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
 <20260924-separate_etm_cfg_v2-v12-14-a2b41d2f7c2b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:36:06 +0000
Message-Id: <20260924183606.D62FA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] coresight: missed variable rename in etm_disable_sysfs()
--

commit 675c6e2b645cb58619c01f29029e27576619cf41
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm3x: rename drvdata->config to sysfs_config

This commit renames the drvdata->config variable to sysfs_config to clarify
its purpose. It also intends to rename local variables referring to this
configuration for better readability.

> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers=
/hwtracing/coresight/coresight-etm3x-core.c
> index 0cad9ecb49b61..67f1b71de8811 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
[ ... ]
> @@ -627,7 +627,7 @@ static void etm_disable_sysfs(struct coresight_device=
 *csdev)
>  {
>  	struct etm_drvdata *drvdata =3D dev_get_drvdata(csdev->dev.parent);
>  	const struct etm_caps *caps =3D &drvdata->caps;
> -	struct etm_config *config =3D &drvdata->config;
> +	struct etm_config *config =3D &drvdata->sysfs_config;

[Severity: Low]
This isn't a bug, but should this local variable also be renamed to
sysfs_config?

The commit message mentions "also rename local config variables to
sysfs_config where they refer to drvdata->sysfs_config", but it appears
this instance in etm_disable_sysfs() was missed and remains named config.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-separate_e=
tm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com?part=3D14
