Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FF93C7DF5;
	Tue, 15 Sep 2026 11:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789472927; cv=none; b=CAOg1xoXNj2cFweZXG3YL/QsG20SRfig8fDTJpMeu0ck98dYdXPVAgBlsmhHrwyLlPDnhDOTf65Z0XtpTbN8Tqdh6wgvmeAzr5oHQfBGgGjhMv83rCB1PbjqVOTICv/dDCTum3FWPhp8ZaEdXC+4G6s7hnF60Rc2F4RGwZkXSOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789472927; c=relaxed/simple;
	bh=syoI9gzvW/GM43+NhCsnAEzCikK9E4+KxSk7MUKtaU8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OJ8KPMnPNXniFSMrXf/G+7rOckIK5/7s4qyL6hrSOeOSF69al4fkNuk1cbi9xtJgVcovyG1x5/0LjxELamz2U8HgCOaWXB/8Aoi7SDi/LIb/1Vr1ZaUShEoe8VuEsEMyUVTNUPeZ6D/xo5HttwiPPtwWxV9s69rZKmFLzu/JYHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ukhg7qKl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ukhg7qKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFA601F000FF;
	Tue, 15 Sep 2026 11:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472926;
	bh=LqstjRRd96+oTC2hWZ2zIbGYIwYZpTXGPPtJNbX5nN0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ukhg7qKl27ckYFNI6hSg25BeltsjkUHtY+yQVAjm1C9EL+Qv1afuejKd3poa6G+Zk
	 DGLBd4I3IJTQoKMLCby3Oq4kezNQZ2LtHOiqwpGdOvzWOG9ScBKNe+79ACowPZmu6R
	 CV3IKE+KVgwSFCcKgT9cefGyotA8sNCMomBAbzUN01wIU+8BvH9RE/yy0J2iH/tcKs
	 jmptPrhUw2senGKQ1fxp9zKtVhw9TDCyLYkPRmBkabYNukuc5jEyy9yldo98fr3E3N
	 YS++hY7TXd7R7QiTNkrYwqw+lpQ2hYXGID4dgzV/z7FVNEcDzStjUPGjhR4LeeLr3+
	 xjjMKSDuPgzww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/9] coresight: etm3x: prohibit modifying cntr_val
 and reset while session is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-2-d2b258d51747@arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-2-d2b258d51747@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:48:44 +0000
Message-Id: <20260915114845.CFA601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] coresight: TOCTOU race in sysfs configuration store functions
--

commit 9a331a4cd5a9fd51e7380e92ed6bdd6d8e20d5e4
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm3x: prohibit modifying cntr_val and reset while session is en=
abled

This commit attempts to prevent modifications to cntr_val and reset while
a CoreSight trace session is enabled. It adds a check for the current
mode using coresight_get_mode() before proceeding with the sysfs store
operations.

> diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm3x-sysfs.c
> --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> @@ -74,6 +74,8 @@ static ssize_t reset_store(struct device *dev,
>  	ret =3D kstrtoul(buf, 16, &val);
>  	if (ret)
>  		return ret;
> +	if (coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
> =20
>  	if (val) {
>  		spin_lock(&drvdata->spinlock);

[Severity: Medium]
Could this lockless check introduce a time-of-check to time-of-use race?

If a concurrent thread starts a trace session via the enable_source sysfs
file right after coresight_get_mode() returns false, it might win the race
before spin_lock() is acquired here.

This could result in resetting the configuration of an active trace session
and erroneously releasing its trace ID, potentially leading to trace ID
collisions and hardware trace stream corruption.

[ ... ]

> @@ -744,6 +746,8 @@ static ssize_t cntr_val_store(struct device *dev,
>  	ret =3D kstrtoul(buf, 16, &val);
>  	if (ret)
>  		return ret;
> +	if (coresight_get_mode(drvdata->csdev))
> +		return -EBUSY;
> =20
>  	spin_lock(&drvdata->spinlock);

[Severity: Medium]
Is this susceptible to a similar race condition as reset_store?

Since coresight_get_mode() is checked outside the spinlock, a concurrent
thread could enable the session just before spin_lock() is acquired,
allowing the counter value to be modified while the session is active.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-separate_e=
tm_cfg_v2-v11-0-d2b258d51747@arm.com?part=3D2
