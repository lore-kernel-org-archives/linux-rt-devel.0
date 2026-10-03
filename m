Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E15379988;
	Sat,  3 Oct 2026 01:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991224; cv=none; b=fnMz3YqcqF7bVjZcQa3m0g0mj7Bl/rkceli5sK+4aBwYNLInWab7DYorkAcA5M8hCRe4FVEeH7VmvqQlAsGLidbBYLul9Pdryymw68SBeHYT2l6HR4dF/9W1A/40q53iHnwiBWfWh6bU/QZ6vMy+MoT5v6wP9Txh69dTrpOWYQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991224; c=relaxed/simple;
	bh=tKeF/qLlCpF06xDLotrC6QZnp6FuESVq5Cbj3/+LKAc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HA1Sw46esQI4PwRe9Bf+zquOwcoaJdK2JKu9sxyaWK1qz5eqDz7OvI5+qmJ6pW7IG+DLqyLI74Ed6a4eyY4KL1KUigK6Xlb8Tzkz2CLmmj2hooT9ACaiQMXQSC4h4tqdIXeCFP2SEmDJytFrsgsjRiCOkQPALv0e2rjcZR35veo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLTLrQFn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLTLrQFn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B201F000FF;
	Sat,  3 Oct 2026 01:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991223;
	bh=MdTgCMmAmX/XhHFbdiYg72pO5sBVE2iam1ls7C+P5D0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bLTLrQFnws+fcCYL4AtlFDQ2grMOq419Dy87Duqjr8R14P0zf1c7KL+tT2vI4i3Nc
	 8aa7qnHuiOOyt9FNfsF+lJH0cJgjOOzFM3WZi5BdXZByX17INe23ypT9aX50FwZIjL
	 7f+qS54W2zOjAehOCJ5ZiK6JMW4XlM921HeAzqCtLCIBHctQkEt8mWTtWXSQ/oxDxf
	 7wljI4Cv0PpoMipNFAq6Xqfuw7V7pHv+1+8+ZXzwSmFjTOgb6Du2m1Z8visD1gJrKf
	 ePOl2Oe9cfW+zzV6Lip9V1W6MUM7bwNztqtPJ6rS9V1INiqseCsLgtPsaaRyxfqZpc
	 jlYnZvAGM+Q0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 03/14] coresight: etm3x: prohibit modifying cntr_val
 and reset while session is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20261002-separate_etm_cfg_v2-v13-3-fe429d8d96fb@arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
 <20261002-separate_etm_cfg_v2-v13-3-fe429d8d96fb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:42 +0000
Message-Id: <20261003013343.64B201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] coresight: TOCTOU race in sysfs configuration modifications
--

commit 58a68349c3bcb900219eaabae6561553d37341df
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm3x: prohibit modifying cntr_val and reset while session is en=
abled

This commit prevents modifying cntr_val and resetting the state when the
trace session is enabled. It does so by checking the coresight mode before
proceeding with modifications in sysfs store functions.

> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm3x-sysfs.c
> index b3c67e96a82a4..cdb70a4382eb8 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -75,6 +75,10 @@ static ssize_t reset_store(struct device *dev,
>  	if (ret)
>  		return ret;
> =20
> +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> +	    coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
> +
>  	if (val) {
>  		spin_lock(&drvdata->spinlock);

[Severity: High]
Does this code introduce a TOCTOU race condition?

The coresight_get_mode() check is evaluated outside the drvdata->spinlock
that serializes hardware and state changes.

If a concurrent thread writes to the sysfs reset attribute while another
thread enables the trace session via enable_source, couldn't the sysfs store
function's check pass just before the session enablement code takes the
mode (via coresight_take_mode()) without holding the spinlock?

The sysfs store would then acquire the spinlock, clear the config, and
release the trace ID while the session is actively building its path and
starting up.

This could corrupt the trace configuration, allow a trace session to start
with a zeroed-out configuration, and prematurely release the actively
assigned trace ID, causing trace ID conflicts.

This issue was verified to remain unfixed in the final state of the patch
series (commit 45def19b707827632be083676fa86077f5bc1585).

>  		memset(config, 0, sizeof(struct etm_config));

[ ... ]

> @@ -744,6 +748,9 @@ static ssize_t cntr_val_store(struct device *dev,
>  	ret =3D kstrtoul(buf, 16, &val);
>  	if (ret)
>  		return ret;
> +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> +	    coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
> =20
>  	spin_lock(&drvdata->spinlock);

[Severity: High]
Similarly, does this safety check fail to guard concurrent updates
to cntr_val?

The check is performed outside the spinlock, creating the same race window
where cntr_val could be updated while the session is being enabled.

>  	config->cntr_val[config->cntr_idx] =3D val;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-separate_e=
tm_cfg_v2-v13-0-fe429d8d96fb@arm.com?part=3D3
