Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3CA4B1B42;
	Tue, 15 Sep 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473000; cv=none; b=Dx6JKMnuGrqCJJyxX9uhtCX8wH7pN5PVDO5ZKDJvVs3PGNeMyL0rq9/kkkZzaqacuQg4Kn70Q4Ii1vxs+QNbSA7eHWvNx8xqfQk7+YHhgktb5wSgVWMBHYywIqVujWv2GnwxkXpEC5yGJnqO3P+ev/PQOXfx51t0buIjNxpKDp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473000; c=relaxed/simple;
	bh=K91+LUJz2nG3uN9tVTjvjGPaYR5m9J9RX3tOoDSLcYQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XCJab6/6hB5ACvKFsRAOEk8u7scUngzYHsUffuTAgv0wEqRrTVPYkOhUsazPaGh6w7kRPly8oPD1BzlWuTchIaVMsEnAF1ueH0ufQQjIJS5S5cipjdXCYStKZhDSQCpQy9WNbiuVIZ5atr2mtULIg50t5iTYsnbc0sXP3hYoUOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvNO+8P6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvNO+8P6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A22A1F00893;
	Tue, 15 Sep 2026 11:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789472999;
	bh=Y70Xls/F2gfnQ3EZUXKppKqZ6FS9lNnhMyXoi236EUk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GvNO+8P6mk6INK1JmLiLeI3BqIqlKoZiT4+3ZA2SKRWwxuzil2eCbysk/u+gIAHI6
	 GxKFG8PMiFKd3JSw6LnkRaRlIwA+SMajcJ4AgrvXlZJXFn21f+tz2qrUkXPo5M25M3
	 rvZ9ORzuioWemRlwV0RWGbCI7YqooivFmXHawr1joYtnLBsxNlYjlCQK/YzFdszCCT
	 ODxjyjWtW5wy7eg7LnceLWY0UDBQCjA845/sfd2E0G6FZ9iCjya0LmluhtxOj7dLOA
	 V9sU8+NEK879N1vM9o/6HlG+lz3uKfS+nnmt65G2U8qeSBlKhJfu7PjzAVcBSj1YJM
	 bLjxqUSeknvJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 7/9] coresight: etm4x: exclude ss_status from
 drvdata->config
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-7-d2b258d51747@arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-7-d2b258d51747@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:49:58 +0000
Message-Id: <20260915114959.1A22A1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] coresight: data race and state leak in shared ss_status array
- [Medium] coresight: contradictory bitmask change introduces unhandled beh=
avior
--

commit 1a408a1bbc8676e137115f3c8798cfbd8a499e15
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: exclude ss_status from drvdata->config
   =20
This patch moves the ss_status array out of the session-specific configurat=
ion=20
structures and into the shared etmv4_drvdata structure. It aims to preserve=
=20
existing behavior regarding single-shot comparator events while cleaning up=
=20
the configuration data.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers=
/hwtracing/coresight/coresight-etm4x-core.c
> index 70a5c0b4fad1c..9de0c268ff954 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
[ ... ]
> @@ -573,11 +573,11 @@ static int etm4_enable_hw(struct etmv4_drvdata *drv=
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
The commit message states that this patch intentionally preserves the exist=
ing
behavior regarding the clearing of PENDING and STATUS bits. However, the
pre-patch code only cleared TRCSSCSRn_STATUS. By explicitly adding
TRCSSCSRn_PENDING to the bitmask here, does this code actively introduce the
behavioral change it claims to defer?

[ ... ]
> @@ -1081,7 +1081,7 @@ static void etm4_disable_hw(struct etmv4_drvdata *d=
rvdata)
> =20
>  	/* read the status of the single shot comparators */
>  	for (i =3D 0; i < caps->nr_ss_cmp; i++) {
> -		config->ss_status[i] =3D
> +		drvdata->ss_status[i] =3D
>  			etm4x_relaxed_read32(csa, TRCSSCSRn(i));
>  	}

[Severity: High]
When a perf session stops, etm4_disable_hw() writes the hardware state
directly into the shared drvdata->ss_status array without holding
drvdata->spinlock.

Since a concurrent sysfs session could be writing to this same array in
sshot_ctrl_store() under the spinlock, can this lockless write cause a data
race?

Additionally, does this overwrite leak the perf session's single-shot state
into the shared array, allowing a subsequent sysfs session to inadvertently
observe or re-inject the leftover perf state?

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm4x-sysfs.c
> index f6d053f73264c..50ef2e957300f 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
[ ... ]
> @@ -1833,8 +1833,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
>  	raw_spin_lock(&drvdata->spinlock);
>  	idx =3D config->ss_idx;
>  	config->ss_ctrl[idx] =3D FIELD_PREP(TRCSSCCRn_SAC_ARC_RST_MASK, val);
> -	/* must clear bit 31 in related status register on programming */
> -	config->ss_status[idx] &=3D ~TRCSSCSRn_STATUS;
> +	/* must clear bit 31 and 30 in related status register on programming */
> +	drvdata->ss_status[idx] &=3D ~(TRCSSCSRn_STATUS | TRCSSCSRn_PENDING);
>  	raw_spin_unlock(&drvdata->spinlock);

[Severity: High]
As seen here, sysfs modifies the same shared array under the spinlock.
Is it safe to move ss_status to the shared drvdata struct without
synchronizing the hardware stop paths or segregating the session state?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-separate_e=
tm_cfg_v2-v11-0-d2b258d51747@arm.com?part=3D7
