Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3E37F32F;
	Sat,  3 Oct 2026 01:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991228; cv=none; b=Gwt1dJqewycyyWDTCmjU89WT4uoPr5KetIzJSkneY+jzRd9j01ITfbS5Ls5ih4gRokLtmhMdkoSKJeXX7Y++g4STpfNfXG/0/AfvR6zY0xTdSms6hSNmgGAy9FhqlAni9AR9NSqZnbYKiJ4TyUDYzy0xt8Nr29HrR5dXEGOornE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991228; c=relaxed/simple;
	bh=qTUdrvHZWCN5nV+RQp0ae+Urxpm1zOoJc4lV8jkKOOI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qqb5zz3DX+w0A5Kn2Qx+YQT2v7IJ8sPjrrN7JgrTkd82DsWzUsfvSOZkbfMjWfAz+3w9h8k+6zG4yfe/tp6y4BwF5LhJ41mjdfTixzCe9CxdY8Liwojqy/evhjsz0fyKfBEFgpjoG0jGK99M9vc4Jpt0N74PhkQcWXM92J9zn6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mu9epzio; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mu9epzio"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A1E1F0089A;
	Sat,  3 Oct 2026 01:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991226;
	bh=kgjF7XOPj6x+6f9kQGxpNSqGa/V9Xs9OUjAmLXEeBGA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mu9epzioI3Mm+f9R94nLM0auBl4kx5kYipYPV/tebxaWfYtLYRenEZvWqmOkE2hUn
	 xYpf5WKApI9SN1r3ao/u027nRFfUvTgUBWFO2sBxMnm00doG496SlTedL2gs+KTSs5
	 bX8C+rMHwOZMfBPO4F/rWWjHpi3+G3tNPg9WxNemGIXUqbURI5UPenT5OiMWNHJ/Ir
	 riiBvP07GohZwlnA3glbCw/B+aUQ15nzOV83TqgqYNNb7dAJikGDJAoHoB2B9gf1y/
	 ejejvZkTNaR2qUKCxANIP//7uemtNSTpsgBLsmjX+wEZTUtRxANPQ+wMHn1o+PD5eJ
	 pgNZ4HZM0Tb5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 02/14] coresight: etm4x: prohibit modifying cntr_val
 while session is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261002-separate_etm_cfg_v2-v13-2-fe429d8d96fb@arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
 <20261002-separate_etm_cfg_v2-v13-2-fe429d8d96fb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:45 +0000
Message-Id: <20261003013346.59A1E1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] coresight: TOCTOU race in cntr_val_store() defeats active sessio=
n check
--

commit d42ded85664acd4e853cec4a07df95780d0a17bb
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: prohibit modifying cntr_val while session is enabled

This commit adds a check to cntr_val_store() to prevent modifying the
counter value while the coresight session is active. This prevents user
configurations from being discarded when the session is disabled.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm4x-sysfs.c
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
[ ... ]
> @@ -1615,6 +1615,9 @@ static ssize_t cntr_val_store(struct device *dev,
>  		return -EINVAL;
>  	if (val > ETM_CNTR_MAX_VAL)
>  		return -EINVAL;
> +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> +	    coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
> =20
>  	raw_spin_lock(&drvdata->spinlock);

[Severity: Medium]
Is there a race condition here between the mode check and acquiring the
spinlock?

If a user-space thread writes to the cntr_val sysfs file while another
thread concurrently starts the trace session, cntr_val_store() evaluates
coresight_get_mode() without holding drvdata->spinlock.

If the trace session is enabled immediately after this check, the hardware
is programmed with the old configuration. The sysfs thread then acquires
the lock and writes the new configuration. When the session is later
disabled, the old hardware state overwrites the configuration array
(config->cntr_val), silently losing the user's update.

Could the mode check be performed inside the drvdata->spinlock critical
section to prevent this sequence?

>  	idx =3D config->cntr_idx;
>  	config->cntr_val[idx] =3D val;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-separate_e=
tm_cfg_v2-v13-0-fe429d8d96fb@arm.com?part=3D2
