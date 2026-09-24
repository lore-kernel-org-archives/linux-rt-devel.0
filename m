Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E89451985;
	Thu, 24 Sep 2026 18:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274097; cv=none; b=pkvKjpJYEdh5ZqmnY9ndyTfm7LjI7ogl3ALlF/2AHZwmMmFfuY3H9quc7RwAJATdaL/FGMeyLEdAr48OBYCvxgJ4ksOgmYXXN4l9y1lelZ404FMUHEn1BNYrakqQxo5m2MsQ2W6Cs6iT+inH6RZC0pZz/yUkIQ9uQ5MS079Unts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274097; c=relaxed/simple;
	bh=3vQfs+MJVZojtRezzkjvgqdfKW9p+z7Hr79oq2FwNj0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zx80dHi0+3oSONq/mUaUe2+lBf8iVJxQHfdJHS4UucMedIUU6mlVQOqWxKVh9vfg3d6t+KN+zPHN+k7mQNFcnynY6rE5ngDb9hAyeMszA8OpPCDSs1DsTLs5VIOYMXuoDQfmwaMdp7jGEWz18l6t/LBPhoRxUkYrjHU6iG/sTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id4FD2aW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id4FD2aW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8286E1F000FF;
	Thu, 24 Sep 2026 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790274095;
	bh=as++lK9Ubt084phj5j3py44mUhF1vpdCd0H/wffxLBw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Id4FD2aWUapkdbS43kuphJFx/6Fj30M6DkcJhTsBr+zNB8N9UrLQ9sD24crzctCwL
	 zlJxJmdszw0lpMEZGN0HUfkwLYL+6dOha7HEDgfsjYSF7+UBePs7xVvBTYwUMv/f4D
	 5gRoD4uvEX1jsAHwCa8iMuZxwie7nYpnu3bt2SKL0xFlMFuWAM37TnZBTePXps7VhT
	 9KTweJYvINpRFEpw3ze9AEWjbWxhfKv8MU3cbGfhsYR/Mhst2DQ+gVwFG6DinRe2no
	 L5rR8HrcdNpgDYBY8aKDur5j7kws+bf6NO0TC/tYT0tbmKE5JoWIB4ZrchlMXS/q18
	 FZbj5P8AVECpw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 08/14] coresight: etm4x: exclude ss_status from
 drvdata->config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260924-separate_etm_cfg_v2-v12-8-a2b41d2f7c2b@arm.com>
References: <20260924-separate_etm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com>
 <20260924-separate_etm_cfg_v2-v12-8-a2b41d2f7c2b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 18:21:35 +0000
Message-Id: <20260924182135.8286E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] coresight: etm4x: patch fails to preserve perf single-shot clear=
ing behavior
- [Medium] coresight: etm4x: data race on drvdata->ss_status during sysfs u=
pdate
--

commit 9755069e34bb3af0812d8f23f42579079827c7ca
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: exclude ss_status from drvdata->config

The patch moves ss_status out of drvdata->config and into drvdata directly.
It aims to separate configuration from reset and restore states, while
intentionally preserving existing single-shot clearing behavior.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers=
/hwtracing/coresight/coresight-etm4x-core.c
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
[ ... ]
> @@ -572,11 +572,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drv=
data)
>  		etm4x_relaxed_write32(csa, config->res_ctrl[i], TRCRSCTLRn(i));
> =20
>  	for (i =3D 0; i < caps->nr_ss_cmp; i++) {
> -		/* always clear status bit on restart if using single-shot */
> +		/* always clear status and pending bits on restart if using single-sho=
t */
>  		if (config->ss_ctrl[i] || config->ss_pe_cmp[i])
> -			config->ss_status[i] &=3D ~TRCSSCSRn_STATUS;
> +			drvdata->ss_status[i] &=3D ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);

[Severity: Medium]
Is it safe to perform a lockless read-modify-write on drvdata->ss_status
here? This can race with or interrupt sysfs stores.

>  		etm4x_relaxed_write32(csa, config->ss_ctrl[i], TRCSSCCRn(i));
> -		etm4x_relaxed_write32(csa, config->ss_status[i], TRCSSCSRn(i));
> +		etm4x_relaxed_write32(csa, drvdata->ss_status[i], TRCSSCSRn(i));

[Severity: Medium]
Does this change preserve the previous behavior for perf sessions as
intended?

When a perf session starts, the configuration is zero-initialized. Before
this patch, the code skipped the bit clearing (since config->ss_ctrl[i]
and ss_pe_cmp[i] were 0) but still wrote config->ss_status[i] to
TRCSSCSRn(i). Because ss_status was zero-initialized, this wrote 0 and
effectively cleared the bits.

Now, it writes drvdata->ss_status[i], which might retain previous hardware
state (potentially 1s). Doesn't this leave the bits uncleared and alter the
hardware state configuration instead of preserving it?

>  		if (etm4x_sspcicrn_present(drvdata, i))
>  			etm4x_relaxed_write32(csa, config->ss_pe_cmp[i], TRCSSPCICRn(i));
>  	}
[ ... ]
> @@ -1078,7 +1078,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *d=
rvdata)
> =20
>  	/* read the status of the single shot comparators */
>  	for (i =3D 0; i < caps->nr_ss_cmp; i++) {
> -		config->ss_status[i] =3D
> +		drvdata->ss_status[i] =3D
>  			etm4x_relaxed_read32(csa, TRCSSCSRn(i));

[Severity: Medium]
Can this lockless write in hardirq context race with the RMW sysfs stores,
leading to torn updates on drvdata->ss_status?

>  	}
> =20
[ ... ]
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm4x-sysfs.c
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
[ ... ]
> @@ -1835,8 +1835,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
>  	raw_spin_lock(&drvdata->spinlock);
>  	idx =3D config->ss_idx;
>  	config->ss_ctrl[idx] =3D FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
> -	/* must clear bit 31 in related status register on programming */
> -	config->ss_status[idx] &=3D ~TRCSSCSRn_STATUS;
> +	/* must clear bit 31 and 30 in related status register on programming */
> +	drvdata->ss_status[idx] &=3D ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);

[Severity: Medium]
Can this read-modify-write be interrupted by the hardware PMU path?

If a user writes to the sshot_ctrl or sshot_pe_ctrl sysfs node concurrently
with a perf session stopping (e.g. during a task context switch),
etm4_disable_hw() can trigger in interrupt context.

Because the sysfs path uses raw_spin_lock() rather than an IRQ-safe variant,
the PMU interrupt can preempt this sequence. Won't this lead to lost updates
or corrupted hardware status capability bits when the sysfs thread resumes?

>  	raw_spin_unlock(&drvdata->spinlock);
>  	return size;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-separate_e=
tm_cfg_v2-v12-0-a2b41d2f7c2b@arm.com?part=3D8
