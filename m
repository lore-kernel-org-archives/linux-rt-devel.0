Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668EE41A504;
	Tue, 15 Sep 2026 11:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789473077; cv=none; b=mlW0wdx9T5kuXrlvROi2titcJS7Uu8HyUW3QV1KnXmY38zZtjQEZmo8gB2Cw1rh0Hvg7bbZt7H1J8CLqOHoohWGOXZRozcst82wbzSb57L9h5sjQ2jSuXrObkkTbzlFS9aL/cQpHNwRx6a9lkZjopY5JZjBYnVaBa0/S41TVTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789473077; c=relaxed/simple;
	bh=K7W4k2f+iekuoISuCnJPGAGoUblnu8UWzRlx4C8OH84=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=beUk/eeUAvZHZmdCRowU9ii+UnpuitmUAv4Hfnbi0tLmWzovWknALHwNYzWTlh4EWij/iDhIvIggfr2djTUALm+vltG8Vtv0KiRh4f3hS18IrEmFKExvFfsyFD9rkm6sfFAALUbbG3jLXlJy0LGMMNB9RpSIYe6QwvjHbRtbGyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IA0xWGnH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA0xWGnH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B2A1F000FF;
	Tue, 15 Sep 2026 11:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789473076;
	bh=Gys+iiTGtcVUDYXX47MKmXZ3Eu5eRKpeRpf14iNffWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IA0xWGnHm5bsyEBgBHLM2QBB4mBs6SIxkviW1aq1JnGvgyZAdg3r3k8X6WVFSVRx9
	 8kqxsk+FQqXQWc+zxPmlX7F8g4CUgx57LOGlaQLaBaHEf9/m1WaWz1zyaNc/qa9ZYW
	 zye8vSB6G4NqsfwkFN3/QfDbi4pFPyESgB5psuFPtNlfsjnV7y/M2k1CKwweRko5bp
	 b7Q1LvyVIyo84+FhGoL4EnI6ekLyj5VWsPGGBIOAp07ACihKXHNdtSVWe/SVQlcEzi
	 ltjiddVznZT77d3iccIxA35iKkkY+td1nmaphtMCdFJXUu8ErKQyMCDyadsAoF3g8+
	 bkT+8UyFohwrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/9] coresight: etm4x: prohibit modifying ss_status
 and cntr_val while session is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yeoreum Yun" <yeoreum.yun@arm.com>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260915-separate_etm_cfg_v2-v11-1-d2b258d51747@arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-1-d2b258d51747@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 11:51:15 +0000
Message-Id: <20260915115115.E6B2A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] coresight: NULL pointer dereference in sysfs stores during device =
initialization
- [Medium] coresight: TOCTOU race in sysfs store functions bypasses session=
 check
--

commit e0461b6a1ca35a227d37c4654e32e424dc9d60f7
Author: Yeoreum Yun <yeoreum.yun@arm.com>

coresight: etm4x: prohibit modifying ss_status and cntr_val while session i=
s enabled

This commit adds checks to prohibit modifying ss_status and cntr_val via sy=
sfs
while a trace session is enabled. It prevents changes to these values from
being silently overwritten and lost when the session is disabled.

> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/driver=
s/hwtracing/coresight/coresight-etm4x-sysfs.c
> index cc6cdd3ae29d5..8d73248b840a6 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> @@ -1613,6 +1613,8 @@ static ssize_t cntr_val_store(struct device *dev,
>  		return -EINVAL;
>  	if (val > ETM_CNTR_MAX_VAL)
>  		return -EINVAL;
> +	if (coresight_get_mode(drvdata->csdev))

[Severity: High]
Can drvdata->csdev be NULL here if this sysfs attribute is accessed during
device initialization?

If userspace writes to this sysfs attribute immediately upon device creation
(e.g., via udev rules), coresight_register() might not have returned yet to
assign drvdata->csdev in etm4_probe(), leading to a NULL pointer dereferenc=
e.

Could we use to_coresight_device(dev) instead to avoid this?

> +		return -EBUSY;
> =20
>  	raw_spin_lock(&drvdata->spinlock);

[Severity: Medium]
Is there a race condition here since the mode check happens before acquiring
the spinlock?

If Thread A writes to cntr_val and passes the mode check, Thread B could
concurrently enable the session (taking the spinlock, configuring the hardw=
are,
and changing the mode). Thread A would then acquire the spinlock and modify
the software configuration, leaving it out of sync with the active hardware.

Should the mode check be moved inside the spinlock?

>  	idx =3D config->cntr_idx;
[ ... ]
> @@ -1797,6 +1799,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
> =20
>  	if (kstrtoul(buf, 16, &val))
>  		return -EINVAL;
> +	if (coresight_get_mode(drvdata->csdev))

[Severity: High]
Does this suffer from the same NULL pointer dereference risk during device
initialization as cntr_val_store()?

> +		return -EBUSY;
> =20
>  	raw_spin_lock(&drvdata->spinlock);

[Severity: Medium]
Is this check also vulnerable to the same race condition by being outside
the spinlock?

>  	idx =3D config->ss_idx;
[ ... ]
> @@ -1847,6 +1851,8 @@ static ssize_t sshot_pe_ctrl_store(struct device *d=
ev,
> =20
>  	if (kstrtoul(buf, 16, &val))
>  		return -EINVAL;
> +	if (coresight_get_mode(drvdata->csdev))

[Severity: High]
Does this suffer from the same NULL pointer dereference risk during device
initialization as cntr_val_store()?

> +		return -EBUSY;
> =20
>  	raw_spin_lock(&drvdata->spinlock);

[Severity: Medium]
Is this check also vulnerable to the same race condition by being outside
the spinlock?

>  	idx =3D config->ss_idx;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915-separate_e=
tm_cfg_v2-v11-0-d2b258d51747@arm.com?part=3D1
