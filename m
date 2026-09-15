Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16494A5EC5;
	Tue, 15 Sep 2026 11:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472879; cv=none; b=es5UM8rIvXWSTPsqlFwskTnJO8POaFzE4GMwMZtu8B8rvYq0ROgqPWm/W0KaP8aH5ZX1gNO6ae0QycMUM0oRRKyIA9vMz28qTtNuXfT1zkM1req9URoenCd8X0eXibz74nzGkw3s+9d8RGu6zkGzlQW7Lc0MzNs7AjhCBsFXwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472879; c=relaxed/simple;
	bh=wUF9aZWKc7qyKfa/9mVie/183gjEweGPJy5lLYTRj8A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fbDe5PMUbM7wYn2i5XhUi86XgdzNZjKzEqwxrZd9ZhtvOlDT+/V6gyWTw4bJAy1RlgymZOeLARLFXItdiXSTxdXcdXiu2+okRVZwJBKUXOuahtlH4gIFNGFUL6+KElU0J3RLu75I5NkFBSn84xZ17RwKWEhvTY/0dRZkEx31GJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRVqwqAo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRVqwqAo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8743B1F00893;
	Tue, 15 Sep 2026 11:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472877;
	bh=aEhGxiVI9MqkY+MpF6UTuDKy8oADsqwRC2p2IOUycbg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XRVqwqAoiJBynbec+bD/X/FLAt0hppO7CEScrwXgLI3qs+4wWuXs2BSudTgF4jP1A
	 Xw273si+5NNLR4obu+n/E5erlQjPlEa+zodG3uMwCWvPCMApoYBlD/lK3sgWcMtizj
	 TFNyeOlMq864Cle+Bxku8L2CFqgYMrG9SXfJD7OFt9ihNRLnG3zVIInVenxpU5K+i+
	 RxnXaD7Phbrjb/17Y2UUmU4Tnoon4eB5WfZGay0XttpzQr0hdrKmU7Kjwb7OKJ+vbt
	 0Eyc+Wf7PAZllSHaKvI2Oy3y4BO2hB30lxzqmGT6ObRoBvbF/vpy9kwmY0fNlsXmXA
	 F6vUyyUFTANBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 4/9] coresight: etm3x: fix inconsistencies with
 sysfs configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-4-d2b258d51747@arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-4-d2b258d51747@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:47:57 +0000
Message-Id: <20260915114757.8743B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] coresight: TOCTOU race in sysfs read paths exposes powered-down =
hardware
- [Low] coresight: benign data race on config->cntr_idx in cntr_val_show
--

commit 7fbfa36b293dee9eea85d0d29da9faaa208abb46
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm3x: fix inconsistencies with sysfs configuration

This commit splits the sysfs configuration into active and mode
configurations to fix inconsistencies during active perf sessions. It also
avoids locking around some sysfs paths and uses IPIs to read registers
directly on the appropriate CPUs to reduce lock scopes.

> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers=
/hwtracing/coresight/coresight-etm3x-core.c
> index 862ad0786699c..fd76a57e5f861 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
[ ... ]
> @@ -630,8 +632,9 @@ static void etm_disable_perf(struct coresight_device =
*csdev)
>  static void etm_disable_sysfs(struct coresight_device *csdev)
>  {
>  	struct etm_drvdata *drvdata =3D dev_get_drvdata(csdev->dev.parent);
> -
> -	spin_lock(&drvdata->spinlock);
> +	struct etm_config *config =3D &drvdata->config;
> +	const struct etm_config *active_config =3D &drvdata->active_config;
> +	int i;
> =20
>  	/*
>  	 * Executing etm_disable_hw on the cpu whose ETM is being disabled
> @@ -640,7 +643,14 @@ static void etm_disable_sysfs(struct coresight_devic=
e *csdev)
>  	smp_call_function_single(drvdata->cpu, etm_disable_sysfs_smp_call,
>  				 drvdata, 1);
> =20

[Severity: Medium]
When thread A disables tracing via etm_disable_sysfs(), it sends an IPI to
power down the hardware here. Could a concurrent reader (like Thread B in
cntr_val_show()) see the mode still set to CS_MODE_SYSFS, and issue its own
IPI to read the hardware? Since the hardware is already powered down by
Thread A's IPI, Thread B might read a stale or garbage value instead of the
correctly saved trace state, breaking post-trace analysis.

> -	spin_unlock(&drvdata->spinlock);
> +	/*
> +	 * Userspace may read seq_curr_state and cntr_val through sysfs
> +	 * after the sysfs-session has been disabled.
> +	 */
> +	for (i =3D 0; i < drvdata->nr_cntr; i++)
> +		config->cntr_val[i] =3D active_config->cntr_val[i];
> +
> +	config->seq_curr_state =3D active_config->seq_curr_state;
> =20
>  	/*
>  	 * we only release trace IDs when resetting sysfs.
> @@ -649,6 +659,8 @@ static void etm_disable_sysfs(struct coresight_device=
 *csdev)
>  	 * prior trace id allocation method
>  	 */
> =20
> +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);

[Severity: Medium]
The software state is updated here, creating a race window between the
hardware disable above and the mode update here where the hardware is off b=
ut
the mode is still CS_MODE_SYSFS. A similar window exists during
etm_enable_sysfs().

> +
>  	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm3x-sysfs.c
> index d4846d6364945..2c8c129228589 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
[ ... ]
> @@ -719,7 +752,9 @@ static DEVICE_ATTR_RW(cntr_rld_event);
>  static ssize_t cntr_val_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
> +	int ret;
>  	u32 val;
> +	unsigned long val2;
>  	struct etm_drvdata *drvdata =3D dev_get_drvdata(dev->parent);
>  	struct etm_config *config =3D &drvdata->config;
> =20
> @@ -728,7 +763,10 @@ static ssize_t cntr_val_show(struct device *dev,
>  		val =3D config->cntr_val[config->cntr_idx];
>  		spin_unlock(&drvdata->spinlock);
>  	} else {
> -		val =3D etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
> +		ret =3D etm_readl_cslocked(drvdata, ETMCNTVRn(config->cntr_idx), &val2=
);

[Severity: Low]
Does reading config->cntr_idx without locking here create a data race? It
appears it can race with concurrent updates in cntr_idx_store(). While this
is likely benign since it is an 8-bit integer and bounded by
cntr_idx_store(), preventing out-of-bounds access, could it still trigger
sanitizer warnings when accessed by authorized users?

[Severity: Medium]
This reader accesses the hardware assuming it is active, based on a lockless
mode check in the if condition. If this races with etm_disable_sysfs()
powering down the hardware before the mode is updated to CS_MODE_DISABLED,
could this read return garbage values?

> +		if (ret)
> +			return ret;
> +		val =3D val2;
>  	}
> =20
>  	return sysfs_emit(buf, "%#x\n", val);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-separate_e=
tm_cfg_v2-v11-0-d2b258d51747@arm.com?part=3D4
