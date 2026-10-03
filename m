Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBC4233D9E;
	Sat,  3 Oct 2026 03:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790996794; cv=none; b=r7GzCv4RzW04I6lJ1RiQYMqNROXKkkMSbeSJmkrBL36tRreKjHS38k3yHYyTeWvV+11hpq5DHimgxtsx8tt8DS+tjtH/5X9c2I1IgyJqNPc+VvgCMFuHv7Hop5NmalY2jsfxkStNm4aoQ80LTaonbGORpkNgQDom9BSj/4SacsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790996794; c=relaxed/simple;
	bh=8BMVqBBfQEuB72o3zpn5z8CgDAZy6Z3ITY1YNeLnaNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MVcjA97V0u7Dz3C4Q2nrzSwIis61kBfu99skizDG/lSd6aI059KugdOojKlQAPv/Sf+o4QouuD1jYlaD7rLCw7Jr0AJe3VsvvpoABniN93Oyqs+VfszOlsCHiOu0zVT/UFrobzChGZKJEGmq+476ASeWorQzgoEyLjNvZ+wGLd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jOt5Rdzv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jOt5Rdzv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477A61F000FF;
	Sat,  3 Oct 2026 03:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790996793;
	bh=Ye8Ddz+lKZX24VeGRq3hBaAycOLUEo5SioC7FJLsy5w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jOt5Rdzv0cYMUvFFURYnVbEMYr/PTKxnaqiyyLW6YZ0xMaZqQSUBVXkJfIIuRbcCo
	 ZQZpmqnhqikL/zx9xdGf1Rf5VkqI+k1MLemyHZeXB56OdDuWbQ+VEO/90npoVoBQAs
	 M5/rN5kZZ3E1Bzz9w8mcwVOzWS5WhO46+4VFXtn+qaDUcYRndHlwGS3wu8vladfLGT
	 smVfR2wXQpYBWgTk0X3Bf5YUEMSWFEK9R5yENev0TE4BkaNUqEHQ49fxEnxLsO9q7H
	 QIBtKaQ3dtTLzSsD/3OSunmr7pp3k7X2UDnOBcxFrsbzsgDpna4E9bQx53xrQ51dFc
	 AjeloFyJgF4hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v13 04/14] coresight: etm4x: fix inconsistencies
 with sysfs configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20261003-separate_etm_cfg_v2-v13-4-5d8a29aead95@arm.com>
References: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
 <20261003-separate_etm_cfg_v2-v13-4-5d8a29aead95@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 03:06:32 +0000
Message-Id: <20261003030633.477A61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] coresight: data race in etm4_disable_sysfs() due to missing spin=
lock
--

commit 047fa1646a004922cd9c2e2d801758f38062c7c6
Author: Yeoreum Yun <yeoreum.yun@arm.com>
Subject: coresight: etm4x: fix inconsistencies with sysfs configuration

This commit separates the ETM4x configuration into a session-specific=20
curr_config and a sysfs-set config to prevent corruption and inconsistency.=
=20
It also removes drvdata->spinlock coverage from the enable/disable paths=20
except when explicitly accessing configuration fields.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers=
/hwtracing/coresight/coresight-etm4x-core.c
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c

[ ... ]

> @@ -1134,8 +1142,9 @@ static int etm4_disable_perf(struct coresight_devic=
e *csdev,
>  static void etm4_disable_sysfs(struct coresight_device *csdev)
>  {
>  	struct etmv4_drvdata *drvdata =3D dev_get_drvdata(csdev->dev.parent);
> -
> -	raw_spin_lock(&drvdata->spinlock);
> +	struct etmv4_config *config =3D &drvdata->config;
> +	const struct etmv4_config *curr_config =3D &drvdata->curr_config;
> +	int i;
> =20
>  	/*
>  	 * Executing etm4_disable_hw on the cpu whose ETM is being disabled
> @@ -1144,9 +1153,19 @@ static void etm4_disable_sysfs(struct coresight_de=
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
> +		config->ss_status[i] =3D curr_config->ss_status[i];
> =20
> -	cscfg_csdev_disable_active_config(csdev);
> +	for (i =3D 0; i < drvdata->nr_cntr; i++)
> +		config->cntr_val[i] =3D curr_config->cntr_val[i];
> +
> +	config->seq_state =3D curr_config->seq_state;

[Severity: Medium]
Does this modification to the config fields require drvdata->spinlock
protection?

The commit message notes the intent to remove the lock "except when to
access config fields", which is correctly followed during sysfs enable
via scoped_guard. However, sysfs readers expect this spinlock to be held
when reading these arrays.

For example, a sysfs read legitimately holds the lock here:

drivers/hwtracing/coresight/coresight-etm4x-sysfs.c:sshot_status_show() {
    ...
    raw_spin_lock(&drvdata->spinlock);
    val =3D config->ss_status[config->ss_idx];
    raw_spin_unlock(&drvdata->spinlock);
    ...
}

Writing to config->ss_status, config->cntr_val, and config->seq_state
concurrently without the lock in etm4_disable_sysfs() could create a
data race resulting in KCSAN warnings and inconsistent reads.

> +
> +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
> =20
>  	/*
>  	 * we only release trace IDs when resetting sysfs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-separate_e=
tm_cfg_v2-v13-0-5d8a29aead95@arm.com?part=3D4
