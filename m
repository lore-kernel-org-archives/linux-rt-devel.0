Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB0737E304;
	Sat,  3 Oct 2026 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991228; cv=none; b=gIlBKtcWZz5KEEihOh1PFqjgDflpZsdNYiAns6T676aQs/SVRPfuyv7h15X7qw+jELJLni6dviWrJY4K4NCuessy2YVgnf6lrpH/lSmHVXcPj5Ff22P2D2hlPzjjfqSU/3oeFfkXypfSou4tavn5YsbXd0wxEV2z64lNbe/JVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991228; c=relaxed/simple;
	bh=YHK+qssK9PdC/L90gyBLgnaNcC2cnXkISBWmcDvhioU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VfMZ9DKMNOEXMu/PnOJdOZ79Qth2SnDvFWLum3mmU2eS04dg9YXu2OSqkIGKg8N8GdRE5PSAEG9khLp/OdMBCKm8YRmS9hjw5Lzth8wzv2P/dfFd4AYXrGuKX/DMCifZFavUhME+IcGeRn+JVlM0FB1ByU/rrFyI4a3reQqvI68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I55Eib8O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I55Eib8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E07E1F00899;
	Sat,  3 Oct 2026 01:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991227;
	bh=uKSEN/FxIAyQr1d9V5tn98g2VcHl8sUoxhXL9RhOsRM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I55Eib8OoWAyGBJGqpodKcpXRZUQmuatG3dzw6L8d7yEsNIecR1TIfQFd35GOPFwX
	 XQxWRZvZfH+s5ceGqu8Cr76sRbeCSpxkY2176Y2MeKieTN5tOwlqXMVahSxAoSEDXU
	 Ot2w0FuDsvzElRjsESZExBey8mTNIZugxzqDi7JewSBKrF+ZySlkeOqI6qKSIyTpeN
	 yAXa98lSG45RyVlXa1Exp7FelS8MIPk5iv3ndiyZl/FuYmHFdNxmgr/Huh8nPsGR1B
	 7q9Nqt03y9skm6+Ve63ZOntgitwbvFHY7Zt1o3PcY1nFksq/IeaF+PfWg1ZVjx6tn8
	 Zm+CZOWgGGnkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 04/14] coresight: etm4x: fix inconsistencies with
 sysfs configuration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20261002-separate_etm_cfg_v2-v13-4-fe429d8d96fb@arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
 <20261002-separate_etm_cfg_v2-v13-4-fe429d8d96fb@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:33:46 +0000
Message-Id: <20261003013347.0E07E1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] coresight: etm4x: data race in etm4_disable_sysfs() due to missi=
ng spinlock
- [Medium] coresight: etm4x: resource leak when disabling sysfs tracing on =
an offline CPU
--

commit 431ca53aed38063c4c77184079a32f5fbbb5b69b
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: fix inconsistencies with sysfs configuration

This commit separates the configuration into curr_config and config to prev=
ent
inconsistencies when modifying via sysfs during an active perf session. It
also removes the lock/unlock from the sysfs enable/disable path and
startup/dying_cpu, except when accessing config fields.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers=
/hwtracing/coresight/coresight-etm4x-core.c
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -1090,8 +1097,9 @@ static void etm4_disable_sysfs_smp_call(void *info)
> =20
>  	etm4_disable_hw(drvdata);
> =20
> +	cscfg_csdev_disable_active_config(drvdata->csdev);
> +
>  	drvdata->csdev->path =3D NULL;
> -	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
>  }

[ ... ]

> @@ -1144,9 +1153,19 @@ static void etm4_disable_sysfs(struct coresight_de=
vice *csdev)
>  	smp_call_function_single(drvdata->cpu, etm4_disable_sysfs_smp_call,
>  				 drvdata, 1);

[Severity: Medium]
If smp_call_function_single() fails (for instance, if the target CPU is
offline), it will return -ENXIO and bypass the callback entirely.

Since cscfg_csdev_disable_active_config() was moved into the SMP callback
etm4_disable_sysfs_smp_call(), does this mean we could permanently leak the
active configuration when the CPU is offline? This could leave the module
reference count (active_cnt) leaked and active_cscfg_ctxt dangling.

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
Is it safe to copy curr_config to config here without holding the
drvdata->spinlock?

Sysfs writers (like reset_store()) and readers (like cntr_val_show()) do
not check if the device is currently in CS_MODE_SYSFS; they rely solely on
the spinlock for synchronization.

Could this create a data race where concurrent sysfs operations are
overwritten by this lockless loop, corrupting the sysfs-exposed state?

> +
> +	coresight_set_mode(drvdata->csdev, CS_MODE_DISABLED);
> =20
>  	/*
>  	 * we only release trace IDs when resetting sysfs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-separate_e=
tm_cfg_v2-v13-0-fe429d8d96fb@arm.com?part=3D4
