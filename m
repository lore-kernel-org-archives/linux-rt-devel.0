Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED2237DAB1;
	Sat,  3 Oct 2026 01:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991226; cv=none; b=ik2VA3sRr6DlclztWbkVbLpxpUZWyu/AVzNbEhsvwBTed6fuf22PuuJVSWqNrTpKBFWaVxK9ckTkEpqNnXrhe6NVV8Nxm0cjJYCDdH01ZvEbRRasnoPdwQ0JTlYO2XeMTKkvW+mxx3RjkfvevOiZNnCEX6F1cuvt5e0azIp0iEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991226; c=relaxed/simple;
	bh=g6HcahXsAOv+t59E3fCyoK4/BPqiQ7WmPHn5OaHAygs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kTXVTkm6Q1/H8A8x8e6ttZG6/Nmjb4Z067/uI0tHcH65QcQAm8Mbg14TxiynhBtlU/h6SiKZzhq58cEul2xOA3Q9FjttUNXc1SUxvVlWeejGrPBwjDRm79AKgakmqG3a7lB9EXwwI/NxFTxgWmk7lMZ5SAbGi1lytiAELtTLAi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dbiH4R6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dbiH4R6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D438A1F00898;
	Sat,  3 Oct 2026 01:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991225;
	bh=Fi0sVrZAW6F9zZzf+YkgrkJb7TKdH216q39b2jKlqgE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dbiH4R6axtV97SflcjE+i8D9GrQ+zN/D8A76XqAQIPE5nGgKJ/5cptnEd/tQ9ClRS
	 zUdXV0lKA/LjWPLbFM2Z6mBfG3aqs/3BJKhFWBavNkXGU69noARiL6iYzdH2A4PCr7
	 H7efpG4LOlAunWZ3HuW6WR7ssh42ZMEniWj0nukMD7oXvBd6QR5buzMTP1EScho11m
	 +khYUyqz/zk5x+EN/EW7pucWbuY3QGSMU6GEM6BLQpo/FKn8qFfiika9doe9kTNN6u
	 X5tM7et2EfLTn/xOEz2NgOOMEoR8Bj43bwN7bYRAHhL+pP6ZgsOrnWcF9AK1FbAjkZ
	 7KtFc80RrBkcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 05/14] coresight: etm3x: fix inconsistencies with
 sysfs configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20261002-separate_etm_cfg_v2-v13-5-fe429d8d96fb@arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
 <20261002-separate_etm_cfg_v2-v13-5-fe429d8d96fb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:44 +0000
Message-Id: <20261003013344.D438A1F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] coresight: etm3x: race condition exposes powered-down hardware rea=
ds
- [Medium] coresight: etm3x: data race on cntr_idx in sysfs read
--

commit 6e8889b8f94797194e00dbd7c1a4354b7b49c21d
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm3x: fix inconsistencies with sysfs configuration

This commit separates ETM3x configuration into curr_config and config to
resolve inconsistencies when modified via sysfs during an active perf sessi=
on.
It also removes the spinlock from sysfs enable/disable paths and uses IPIs =
to
read registers on the proper CPU.

> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers=
/hwtracing/coresight/coresight-etm3x-core.c
> index 862ad0786699c..dcadcc3830123 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
[ ... ]
> @@ -640,7 +641,14 @@ static void etm_disable_sysfs(struct coresight_devic=
e *csdev)
>  	smp_call_function_single(drvdata->cpu, etm_disable_sysfs_smp_call,
>  				 drvdata, 1);
> =20
> -	spin_unlock(&drvdata->spinlock);
> +	/*
> +	 * Userspace may read seq_curr_state and cntr_val through sysfs
> +	 * after the sysfs-session has been disabled.
> +	 */
> +	for (i =3D 0; i < drvdata->nr_cntr; i++)
> +		config->cntr_val[i] =3D curr_config->cntr_val[i];
> +
> +	config->seq_curr_state =3D curr_config->seq_curr_state;
> =20
>  	/*
>  	 * we only release trace IDs when resetting sysfs.
> @@ -649,6 +657,8 @@ static void etm_disable_sysfs(struct coresight_device=
 *csdev)
>  	 * prior trace id allocation method
>  	 */
> =20
> +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
> +

[Severity: High]
Can this expose a window where hardware registers are read while the device
is powered down?

The commit removes the drvdata->spinlock that previously serialized sysfs
reads against enable/disable paths. In etm_disable_sysfs(), the hardware is
powered down via smp_call_function_single(), but the mode is not changed
to CS_MODE_DISABLED until much later here.

During this window, could a concurrent sysfs reader like
seq_curr_state_show() observe coresight_get_mode() as CS_MODE_SYSFS and
proceed to call etm_readl_cslocked()? Reading from hardware registers such
as ETMSQR when the ETM power-down bit is set can lead to bus faults (SError)
or return garbage.

>  	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
>  }
> =20
> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm3x-sysfs.c
> index cdb70a4382eb8..284998f180170 100644
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
[ ... ]
> @@ -730,7 +765,10 @@ static ssize_t cntr_val_show(struct device *dev,
>  		val =3D config->cntr_val[config->cntr_idx];
>  		spin_unlock(&drvdata->spinlock);
>  	} else {
> -		val =3D etm_readl(drvdata, ETMCNTVRn(config->cntr_idx));
> +		ret =3D etm_readl_cslocked(drvdata, ETMCNTVRn(config->cntr_idx), &val2=
);

[Severity: Medium]
Is it safe to read config->cntr_idx here without holding drvdata->spinlock?

Concurrent updates from cntr_idx_store() via sysfs could change this value
mid-execution. Since the spinlock was removed from this branch, could this
data race cause the lockless read to fetch an inconsistent index and target
an unintended counter register?

> +		if (ret)
> +			return ret;
> +		val =3D val2;
>  	}
> =20
>  	return sysfs_emit(buf, "%#x\n", val);
[ ... ]
> @@ -946,15 +985,10 @@ static ssize_t seq_curr_state_show(struct device *d=
ev,
>  		goto out;
>  	}
> =20
> -	pm_runtime_get_sync(dev->parent);
> -	spin_lock_irqsave(&drvdata->spinlock, flags);
> -
> -	CS_UNLOCK(drvdata->csa.base);
> -	val =3D (etm_readl(drvdata, ETMSQR) & ETM_SQR_MASK);
> -	CS_LOCK(drvdata->csa.base);
> -
> -	spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -	pm_runtime_put(dev->parent);
> +	ret =3D etm_readl_cslocked(drvdata, ETMSQR, &val);

[Severity: High]
This is where a concurrent reader could read a powered-down register due to
the window mentioned above in etm_disable_sysfs().

> +	if (ret)
> +		return ret;
> +	val &=3D ETM_SQR_MASK;
>  out:
>  	return sprintf(buf, "%#lx\n", val);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-separate_e=
tm_cfg_v2-v13-0-fe429d8d96fb@arm.com?part=3D5
