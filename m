Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D804733A03A;
	Tue, 15 Sep 2026 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473216; cv=none; b=ftv868K8JgpXhyrqVnEwh8xE083NqFXJmPsXWy+Vqnkjmucn5FKE9QDAxRC3W1kkIjCZFH/qzA+OgvVARcF8GIoTBdNfv8o9KX89AOzq93qpY+vyGJP8e+UN9pcJu9t3q6zzUKwbfuvWfTtq0HcfN/Pi/aMU/rwPLhrrgac10c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473216; c=relaxed/simple;
	bh=8QXbZ8I+9o9yTyJvFts1sa5d47rPzE6A80UaFqPuVWs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PzS3oYFj9uY20m7ffWKWBOLBQVN2yeY7FfNkSrWGpnuH2EK1pNogKfXIfjY+vBch6JduvE1rK9uyyIQCFeRlyH5tLjhGAs9Bo9ZI/lon0nbroeVdaCUzf1r886Vqbbs/0dzGUG1DkukoMHgKXqpLymG1zzugEPnYpFrSLEmENVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvmAI+J8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvmAI+J8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FB91F000FF;
	Tue, 15 Sep 2026 11:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473214;
	bh=r5FCBucUZVboJWM6zfaVu4MyS1vGwapKVq7Y/3CWpNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hvmAI+J8VhVlIRtpF7MdpaJ/10pyVJCHWZEFxkGJFT5SatCDb1iTHDcFeHVosNIwO
	 5PaQn/Wm5ffc9jL1CJ4E9IHLbtArowck0oa1sPPbO/zidcp3zVITcHNcU5InHYgEN/
	 G6+fYkbCZbPh2t4yPWQADRjgdRr3gL58i5VCAGkOHcZrdJtIzU49rqkgkxpkT1svla
	 lz3wBKyRYOA0YUKZPOXzTCF24XzAmdSPUhWxNUA3Fin2YxResaZUgPvYAuXHj8K/q7
	 FejMB1fzWRCPoxQBoJGL5M9JzeELBq31LsjY7hvx2CQqFMP2obR5C6zGefYfSzsB3S
	 UZbcYLYqPS0rw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/9] coresight: etm4x: fix inconsistencies with
 sysfs configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-3-d2b258d51747@arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-3-d2b258d51747@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:53:33 +0000
Message-Id: <20260915115334.49FB91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] coresight: data race when updating cntr_val in etm4_disable_sysf=
s()
- [Medium] coresight: feat_csdev_lock macro fails to disable IRQs when __lo=
ck is NULL
--

commit 5571e5128409a42536b24f594b727e037107f3f4
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: fix inconsistencies with sysfs configuration

This commit separates the active configuration applied to the current sessi=
on
from the sysfs configuration to resolve inconsistencies. It applies configfs
settings after taking the appropriate mode and removes the lock/unlock arou=
nd
sysfs enable/disable paths except when accessing config fields.

> diff --git a/drivers/hwtracing/coresight/coresight-config.h b/drivers/hwt=
racing/coresight/coresight-config.h
> index 90fd937d3bd83..ae6295e308131 100644
> --- a/drivers/hwtracing/coresight/coresight-config.h
> +++ b/drivers/hwtracing/coresight/coresight-config.h

[ ... ]

> @@ -259,4 +260,25 @@ void cscfg_csdev_disable_config(struct cscfg_config_=
csdev *config_csdev);
>  /* reset a feature to default values */
>  void cscfg_reset_feat(struct cscfg_feature_csdev *feat_csdev);
> =20
> +#define feat_csdev_lock(feat_csdev, flags)				\
> +	do {								\
> +		raw_spinlock_t *__lock =3D feat_csdev->drv_spinlock;	\
> +		typecheck(unsigned long, flags);			\
> +		if (__lock)						\
> +			raw_spin_lock_irqsave(__lock, flags);		\
> +	} while (0)
> +
> +#define feat_csdev_unlock(feat_csdev, flags)				\
> +	do {								\
> +		raw_spinlock_t *__lock =3D feat_csdev->drv_spinlock;	\
> +		typecheck(unsigned long, flags);			\
> +		if (__lock)						\
> +			raw_spin_unlock_irqrestore(__lock, flags);	\
> +	} while (0)

[Severity: Medium]
Will these macros fail to disable IRQs when __lock is NULL?

The intent is to let cfg-configfs operate without grabbing the drv_spinlock
when it is NULL. However, raw_spin_lock_irqsave() also saves and disables
IRQs. If the lock is bypassed completely here, IRQs are left enabled.

Could this lead to reentrancy bugs or deadlocks if generic coresight config=
fs
routines like cscfg_csdev_enable_active_config() are called from contexts
where IRQs are enabled? Should there be a fallback like local_irq_save() wh=
en
__lock is NULL to ensure the critical section remains protected from
interrupts?

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers=
/hwtracing/coresight/coresight-etm4x-core.c
> index 2247ad55d4442..2df7f592bb5cf 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c

[ ... ]

> @@ -1140,9 +1152,17 @@ static void etm4_disable_sysfs(struct coresight_de=
vice *csdev)
>  	smp_call_function_single(drvdata->cpu, etm4_disable_sysfs_smp_call,
>  				 drvdata, 1);
> =20
> -	raw_spin_unlock(&drvdata->spinlock);
> +	/*
> +	 * Userspace may read ss_status and cntr_val through sysfs after
> +	 * the sysfs-session has been disabled.
> +	 */
> +	for (i =3D 0; i < drvdata->nr_ss_cmp; i++)
> +		config->ss_status[i] =3D active_config->ss_status[i];
> =20
> -	cscfg_csdev_disable_active_config(csdev);
> +	for (i =3D 0; i < drvdata->nr_cntr; i++)
> +		config->cntr_val[i] =3D active_config->cntr_val[i];

[Severity: Medium]
Does this create a data race with sysfs operations?

The etm4_disable_sysfs() function removes drvdata->spinlock but continues to
copy active_config values into config->cntr_val locklessly.

Meanwhile, concurrent sysfs show and store functions access these fields un=
der
the spinlock:

cntr_val_store() {
        ...
        raw_spin_lock(&drvdata->spinlock);
        idx =3D config->cntr_idx;
        config->cntr_val[idx] =3D val;
        raw_spin_unlock(&drvdata->spinlock);
        ...
}

If etm4_disable_sysfs() runs while another thread concurrently reads or
writes cntr_val through sysfs, can it corrupt the configuration state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-separate_e=
tm_cfg_v2-v11-0-d2b258d51747@arm.com?part=3D3
