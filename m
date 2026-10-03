Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA50233D9E;
	Sat,  3 Oct 2026 03:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790996800; cv=none; b=mfLqWioQlYRvkdePIFEDGdlVH+V1JT9IBjrBK3fmJH9NPJhFL+HFaXMslr/ubIw7FYYf/htwAjp0nByRmlm9bSLSAShRpabESbHaqml61iOQldcPx7V4i+VlEXHJJQAOigIVYoCucvi7+x9MpvB4L6m4vunJ879mvQpgLTMB85g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790996800; c=relaxed/simple;
	bh=42oMzqG5/YDV2hEOKfOM65urWlXR7TKQm/gxRKFVS0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hqxb4LtaG/f/p2Uxi7Q4b+AL0rdgNmBfVvDk3e0rKX0k3OUZFs1dG7eZysKABSyIYE40YzvvjVNlRiln85+ZejZnZCuVTqwP07M5MRbmwprQIJCEEw7sziNC3GDvkTl6Be+tA/SYGrunRhglTmeTBDKEjDNjajC9iAQ5H9eR9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+7gmEKN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+7gmEKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A511F000FF;
	Sat,  3 Oct 2026 03:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790996799;
	bh=PZEsoLh3Zv5Tx0LLMI75KNPHv99WIueXklB2HBerH4o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C+7gmEKNHmCk+QTM5y3p6lWKzMFcFOolM82BLA+jLa4QxkQFJm2Le3LeB+q+2r4c/
	 ANJRYDE/u1RK/4KqHdwMkMNBPoFs4DOXs0LDdAdYr0uF50loBLUScoGzzo8X7z4U+F
	 iTkYoOJ5WyND9A373Lq1STKU76b4VJ1uGWB+hc57fH0fRd8BDxWCEwa7XA2VPOEoGa
	 m68V9SWMOxUIp6v8rQ4Rl+TxK2NeF4vj1rlv84MNZsCluLtm4w3V+L87JU1NbEeTpK
	 EVkAUB9gaQBWLB6z1il561BLjFcwZxnADCm1E/aOSYhoyMEsCe8XcyjSfw239QqEEm
	 d8Z+GqXsu07ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v13 03/14] coresight: etm3x: prohibit modifying
 cntr_val and reset while session is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20261003-separate_etm_cfg_v2-v13-3-5d8a29aead95@arm.com>
References: <20261003-separate_etm_cfg_v2-v13-0-5d8a29aead95@arm.com>
 <20261003-separate_etm_cfg_v2-v13-3-5d8a29aead95@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 03:06:38 +0000
Message-Id: <20261003030639.07A511F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] coresight: etm3x: TOCTOU race in reset_store() allows trace ID rel=
ease during active session
--

commit e2e191629dd66da8998d4646f82c1d5c193cb283
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm3x: prohibit modifying cntr_val and reset while session is en=
abled
   =20
This commit adds checks to prohibit modifying cntr_val and calling reset wh=
ile
a trace session is enabled by returning -EBUSY.

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
Does this code introduce a Time-of-Check to Time-of-Use (TOCTOU) race?

Since coresight_get_mode() is checked outside drvdata->spinlock, a concurre=
nt
sysfs write to enable_source could start a trace session (allocating a trace
ID and starting the hardware tracer) immediately after the mode check passe=
s.

Once reset_store() acquires the spinlock, it will unconditionally zero the
sysfs configuration and call etm_release_trace_id().

Releasing the trace ID while the hardware tracer is actively emitting packe=
ts
returns the ID to the global pool. Another source might subsequently alloca=
te
the same trace ID, leading to collisions at the CoreSight sink and
unrecoverable trace data corruption. This structural race condition appears
to remain unfixed through the end of the patch series.

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
Could the same TOCTOU race pattern apply here as well?

If a trace session is concurrently enabled right after the mode check, the
counter value could be modified while the session is active, resulting in a
lost sysfs write.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003-separate_e=
tm_cfg_v2-v13-0-5d8a29aead95@arm.com?part=3D3
