Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E774A43FF;
	Thu, 24 Sep 2026 17:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272696; cv=none; b=M/Av/So2kIT1uhIPuZq1ds1+jS69IrZa9Jt1RmOz7iXcE91ZfioRJzT9/v+wNe7u9m3rgKxC0H+6/Hsy0UmRahGC1s1p4fmCMVePmqV/WogFvGXT91gjz8qTw75uINyV8AQ0q9RW1F6iF5aPNa3xwxytAFIoUSbWEm0eGPOreJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272696; c=relaxed/simple;
	bh=Yv4caEHIaBlfKOuSDWI6+o9bqHkBkzCGnMi/jhXWQt0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mYkQG2QQCZBZPD+zeqagzMksPSCEP9YO4r3CAQN8iSngUviKFOkqGGRutV5rftP5gUekQdJNuGndRUFqAeM9SJ5MkEyK0FF20o6zRibs8yn+OaEuGtYeskXVz2GaHi8jQrSGOj2cATst3GBdEPk4Q68q0XClcyn1S5qL5TonQFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diSLQiHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diSLQiHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFC01F000FF;
	Thu, 24 Sep 2026 17:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272694;
	bh=nmpC3XilCMDn17muOmK9fED1iaCCh1DEkkKZ63LOdA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=diSLQiHWeb8GYp4Jh7DqcyLW5omie8oGcHXcdzlBgHIBZmYMc+vggbFeh/zS3Oxzg
	 3RnMgZT9Bud2vwN53VT9+m+6UEr5L/7WyVzGLQTE06Ri/9K1cquUJ2vv3OWb3oM8us
	 uUxZBlYBXkjISEVp0SjLDqogE4+2RCQ/fIXGgPp6INofzP5FFpqR+2V036MaCF2b5M
	 ZJY16+rZh+ETA5Goxht9YV6Sysf3+NI3VX4CYxERdwfeOAGjTgr7BEMro2OME/t+Sw
	 s+vL5hfT6xdEYF2GAdUSluxZAUMq8PPTpxLuYO+wsaCoRJxXcVxRCYujB9hF0wwbdk
	 bOJIlCgEqkbVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/14] coresight: etm3x: prohibit modifying cntr_val
 and reset while session is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260924-separate_etm_cfg_v2-v12-3-a2b41d2f7c2b@arm.com>
References: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
 <20260924-separate_etm_cfg_v2-v12-3-a2b41d2f7c2b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 17:58:14 +0000
Message-Id: <20260924175814.9AFC01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] coresight: TOCTOU race bypasses session-enabled check in sysfs s=
tores
--

commit 0c7e96565d9330c7133fb31d646be9050f666c48
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm3x: prohibit modifying cntr_val and reset while session is en=
abled

This commit prevents cntr_val and reset from being modified while a
Coresight ETM session is enabled. Changes to cntr_val would be lost when
the session is disabled, and reset should not be invoked during an active
session.

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

[Severity: Medium]
Is there a race condition here since the mode check happens outside the
spinlock?

If thread A executes this check and sees the mode is disabled, thread B
could then enable tracing (acquiring drvdata->spinlock, applying config to
hardware, and updating the mode).=20

When thread A proceeds, it will acquire the spinlock and zero the
configuration while the hardware is actively using it. When thread B later
disables tracing, it would partially overwrite the zeroed configuration with
hardware register values.

Should the coresight_get_mode() check be moved inside the spinlock to
prevent this time-of-check to time-of-use race?

>  	if (val) {
>  		spin_lock(&drvdata->spinlock);
>  		memset(config, 0, sizeof(struct etm_config));

[ ... ]

> @@ -744,6 +748,9 @@ static ssize_t cntr_val_store(struct device *dev,
>  	ret =3D kstrtoul(buf, 16, &val);
>  	if (ret)
>  		return ret;
> +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> +	    coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;

[Severity: Medium]
Does this have the same vulnerability as reset_store()?

The configuration could be corrupted if tracing is enabled by another thread
immediately after coresight_get_mode() returns but before the spinlock is
acquired.

> =20
>  	spin_lock(&drvdata->spinlock);
>  	config->cntr_val[config->cntr_idx] =3D val;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-separate_e=
tm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com?part=3D3
